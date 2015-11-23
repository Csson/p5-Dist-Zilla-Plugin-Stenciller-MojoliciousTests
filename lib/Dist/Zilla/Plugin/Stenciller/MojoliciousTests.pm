use strict;
use warnings;

package Dist::Zilla::Plugin::Stenciller::MojoliciousTests {

    # VERSION
    # ABSTRACT: Create Mojolicious tests from text files parsed with Stenciller

    use Moose;
    with 'Dist::Zilla::Role::FileGatherer';
    use Stenciller;
    use Types::Stenciller -types;
    use Path::Tiny;
    use Dist::Zilla::File::InMemory;

    has source_directory => (
        is => 'ro',
        isa => Dir,
        coerce => 1,
        default => 'examples/source',
    );
    has file_pattern => (
        is => 'ro',
        isa => Str,
        default => '.+\.stencil',
    );
    has output_directory => (
        is => 'ro',
        isa => Path,
        coerce => 1,
        default => 't',
    );
    has template_file => (
        is => 'ro',
        isa => AbsFile,
        lazy => 1,
        coerce => 1,
        default => sub { shift->source_directory->child('template.test')->absolute },
    );

    sub gather_files {
        my $self = shift;

        my $template = $self->template_file->slurp_utf8;
        my @source_files = $self->source_directory->children(qr{^@{[ $self->file_pattern ]}$});

        $self->log('Generating tests from stencils');

        foreach my $file (@source_files) {
            my $contents = Stenciller->new(filepath => $file->stringify)->transform(
                plugin_name => 'ToMojoliciousTest',
                transform_args => {
                    require_in_extra => {
                        key => 'is_test',
                        value => 1,
                        default => 1
                    },
                },
                constructor_args => {
                    template => $self->template_file,
                },
            );

            my $new_filename = $file->basename(qr/\.[^.]+$/) . '.t';
            $self->log("Generated $new_filename");

            my $generated_file = Dist::Zilla::File::InMemory->new(
                name => path($self->output_directory, $new_filename)->stringify,
                content => $contents,
            );
            $self->add_file($generated_file);

        }
    }

}

1;

__END__

=pod

=head1 SYNOPSIS

    ; in dist.ini
    ; these are the defaults:
    [Stenciller::MojoliciousTests]
    source_directory = examples/source
    file_pattern = .+\.stencil
    template_file = examples/source/template.test
    output_directory = t

=head1 DESCRIPTION

Dist::Zilla::Plugin::Stenciller::MojoliciousTests uses L<Stenciller> and L<Stenciller::Plugin::ToMojoliciousTest> to turn
stencil files in C<source_directory> (that matches the C<file_pattern>) into
test files in C<output_directory> by applying the C<template_file>.

This L<Dist::Zilla> plugin does the C<FileGatherer> role.

=head1 ATTRIBUTES

=head2 source_directory

Path to where the stencil files are.

=head2 output_directory

Path to where the generated files are saved.

=head2 file_pattern

This is put inside a regular expression (with start and end anchors) to find stencil files in the C<source_directory>. The output files
will have the same basename, but the suffix is replaced by C<t>.

=head2 template_file

The template file should contain use statements and such. The transformed contents returned from L<Stenciller::Plugin::ToMojoliciousTest> will be placed after
the contents of C<template_file>. The template file is applied to each stencil file, so the number of generated test files is equal
to the number of stencil files.

=head1 SEE ALSO

=for :list
* L<Stenciller>
* L<Stenciller::Plugin::ToMojoliciousTest>

=cut

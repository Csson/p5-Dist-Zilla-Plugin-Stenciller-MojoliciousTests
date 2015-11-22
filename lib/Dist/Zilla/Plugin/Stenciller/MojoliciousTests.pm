use strict;
use warnings;

package Dist::Zilla::Plugin::Stenciller::MojoliciousTests {

    # VERSION
    # ABSTRACT: Short intro

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

    use Dist::Zilla::Plugin::Stenciller::MojoliciousTests;

=head1 DESCRIPTION

Dist::Zilla::Plugin::Stenciller::MojoliciousTests is ...

=head1 SEE ALSO

=cut

use 5.10.1;
use strict;
use warnings FATAL => 'all';
use Test::More;
use Test::DZil;
use Test::Differences;
use Path::Tiny;
use syntax 'qi';
use String::Cushion;
use File::Temp 'tempdir';
use if $ENV{'AUTHOR_TESTING'}, 'Test::Warnings';

use Dist::Zilla::Plugin::Stenciller::MojoTests;

ok 1;


my $tzil = Builder->from_config(
    {   dist_root => 't/corpus' },
    {   add_files => {
            'source/t/corpus/template.html' => path('t/corpus/template.html')->slurp_utf8,
            'source/t/corpus/01-test.stencil' => path('t/corpus/01-test.stencil')->slurp_utf8,
            'source/example/du.mmy' => '',
            'source/dist.ini' => simple_ini(
                ['Stenciller::MojoTests' => {
                    source_directory => 't/corpus',
                    file_pattern => '.+\.stencil',
                    output_directory => 'example',
                    template_file => 't/corpus/template.test',
                }],
            )
        }
    },
);

$tzil->build;

my $generated_test = $tzil->slurp_file('build/t/01-test.t');
eq_or_diff $generated_test, expected_test(), 'Generated correct test';

done_testing;

sub expected_test {
    return cushion 0, 1, qi{
        use 5.10.1;
        use strict;
        use warnings FATAL => 'all';
        use Test::More;
        use Test::Warnings;
        use Test::Mojo::Trim;
        use Mojolicious::Lite;

        use if $ENV{'AUTHOR_TESTING'}, 'Test::Warnings';

        my $test = Test::Mojo::Trim->new;

    };

}

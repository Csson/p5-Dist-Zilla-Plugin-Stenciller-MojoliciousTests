# NAME

Dist::Zilla::Plugin::Stenciller::MojoliciousTests - Create Mojolicious tests from text files parsed with Stenciller

<div>
    <p>
    <img src="https://img.shields.io/badge/perl-5.10+-blue.svg" alt="Requires Perl 5.10+" />
    <a href="https://travis-ci.org/Csson/p5-Dist-Zilla-Plugin-Stenciller-MojoliciousTests"><img src="https://api.travis-ci.org/Csson/p5-Dist-Zilla-Plugin-Stenciller-MojoliciousTests.svg?branch=master" alt="Travis status" /></a>
    <a href="http://cpants.cpanauthors.org/dist/Dist-Zilla-Plugin-Stenciller-MojoliciousTests-0.0200"><img src="https://badgedepot.code301.com/badge/kwalitee/Dist-Zilla-Plugin-Stenciller-MojoliciousTests/0.0200" alt="Distribution kwalitee" /></a>
    <a href="http://matrix.cpantesters.org/?dist=Dist-Zilla-Plugin-Stenciller-MojoliciousTests%200.0200"><img src="https://badgedepot.code301.com/badge/cpantesters/Dist-Zilla-Plugin-Stenciller-MojoliciousTests/0.0200" alt="CPAN Testers result" /></a>
    <img src="https://img.shields.io/badge/coverage-98.1%-yellow.svg" alt="coverage 98.1%" />
    </p>
</div>

# VERSION

Version 0.0200, released 2016-03-23.

# SYNOPSIS

    ; in dist.ini
    ; these are the defaults:
    [Stenciller::MojoliciousTests]
    source_directory = examples/source
    file_pattern = .+\.stencil
    template_file = examples/source/template.test
    output_directory = t

# DESCRIPTION

Dist::Zilla::Plugin::Stenciller::MojoliciousTests uses [Stenciller](https://metacpan.org/pod/Stenciller) and [Stenciller::Plugin::ToMojoliciousTest](https://metacpan.org/pod/Stenciller::Plugin::ToMojoliciousTest) to turn
stencil files in `source_directory` (that matches the `file_pattern`) into
test files in `output_directory` by applying the `template_file`.

This [Dist::Zilla](https://metacpan.org/pod/Dist::Zilla) plugin does the `FileGatherer` role.

# ATTRIBUTES

## source\_directory

Path to where the stencil files are.

## output\_directory

Path to where the generated files are saved.

## file\_pattern

This is put inside a regular expression (with start and end anchors) to find stencil files in the `source_directory`. The output files
will have the same basename, but the suffix is replaced by `t`.

## template\_file

The template file should contain use statements and such. The transformed contents returned from [Stenciller::Plugin::ToMojoliciousTest](https://metacpan.org/pod/Stenciller::Plugin::ToMojoliciousTest) will be placed after
the contents of `template_file`. The template file is applied to each stencil file, so the number of generated test files is equal
to the number of stencil files.

# SEE ALSO

- [Stenciller](https://metacpan.org/pod/Stenciller)
- [Stenciller::Plugin::ToMojoliciousTest](https://metacpan.org/pod/Stenciller::Plugin::ToMojoliciousTest)

# SOURCE

[https://github.com/Csson/p5-Dist-Zilla-Plugin-Stenciller-MojoliciousTests](https://github.com/Csson/p5-Dist-Zilla-Plugin-Stenciller-MojoliciousTests)

# HOMEPAGE

[https://metacpan.org/release/Dist-Zilla-Plugin-Stenciller-MojoliciousTests](https://metacpan.org/release/Dist-Zilla-Plugin-Stenciller-MojoliciousTests)

# AUTHOR

Erik Carlsson <info@code301.com>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2016 by Erik Carlsson.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

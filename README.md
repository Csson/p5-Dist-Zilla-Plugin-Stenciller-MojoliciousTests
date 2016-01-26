# NAME

Dist::Zilla::Plugin::Stenciller::MojoliciousTests - Create Mojolicious tests from text files parsed with Stenciller

![Requires Perl 5.14+](https://img.shields.io/badge/perl-5.14+-brightgreen.svg) [![Travis status](https://api.travis-ci.org/Csson/p5-Dist-Zilla-Plugin-Stenciller-MojoliciousTests.svg?branch=master)](https://travis-ci.org/Csson/p5-Dist-Zilla-Plugin-Stenciller-MojoliciousTests) ![coverage 97.7%](https://img.shields.io/badge/coverage-97.7%-yellow.svg)

# VERSION

Version 0.0102, released 2016-01-26.

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

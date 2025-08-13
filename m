Return-Path: <linux-kernel+bounces-767681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7331FB2579E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 01:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4253E5A36EC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671BB9475;
	Wed, 13 Aug 2025 23:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cvh26uOt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22D22F60DF;
	Wed, 13 Aug 2025 23:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755127992; cv=none; b=R1IXOFcsi1h++i9q5i6TnCgRiQzqSjjZsp9MMKJiStJZvB6MaWPE81Hd5F0YQEqDX3eXKutng+Dt1Vrsw8MEXDTxxKK1ADZwSiCshKme4x6oGTh3mp0eZddA6zSCX8iP+4qC6NvJvv+YMEhcLRDr7p0axvrpVfelRrdSu6EzTkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755127992; c=relaxed/simple;
	bh=aLsgGIoG8wOMcDTyvHWHlB6595c4xgDewBgN5a2MD+8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n/AW8jkDrNsbenCojvW6j5vTOZgEduvQOFDOHOOdXb990L0ObjByko7q4Uzx9d7X1SMuceQ3E3wD73otwJ53DnI1CGkdq305SzWmHnNF7DexC95zfQQaxcyoKHveTwlZxf3HosLlFAYADGtAkd45/VY9y4u2j7AE5OtGOtfIijk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cvh26uOt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0578AC4CEEB;
	Wed, 13 Aug 2025 23:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755127991;
	bh=aLsgGIoG8wOMcDTyvHWHlB6595c4xgDewBgN5a2MD+8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cvh26uOtLo1NBfkPPj2Lq9HRKH8vUVV1Za5scHMUdJubBINsl0HCts78YmfgKhBGA
	 pz/babCLylTcoiKMQUWbYljvvRdmQtjcLuH/IH4E3bFBPRK/WqdvNhDMTtKrsm8eyC
	 tcwfTb7OQTrJ5S5LyI/25VkF7q69Of6wQMI48sD1362nUY/RAdLLDAV+FiWv9Aqxel
	 GUp2ScoSV77qGMuQUAjW3W1ngZiFFgpRqx/Sk3+bS9W+EsvRu9jcLTyQJRrDSpxhFc
	 3l0Fb2L2IZrMKks7l3qvg14VuMkvlOEH9l/3gDG4/TpbFmT6iOFPcSmbKoUEfeLj/i
	 gppx5G+4BTeBA==
Date: Thu, 14 Aug 2025 01:33:07 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 13/13] docs: remove kernel-doc.pl
Message-ID: <20250814013307.51483d19@foz.lan>
In-Reply-To: <20250813213218.198582-14-corbet@lwn.net>
References: <20250813213218.198582-1-corbet@lwn.net>
	<20250813213218.198582-14-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Wed, 13 Aug 2025 15:32:12 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> We've been using the Python version and nobody has missed this one.  All
> credit goes to Mauro Carvalho Chehab for creating the replacement.
>=20
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  scripts/kernel-doc.pl | 2439 -----------------------------------------
>  1 file changed, 2439 deletions(-)
>  delete mode 100755 scripts/kernel-doc.pl
>=20
> diff --git a/scripts/kernel-doc.pl b/scripts/kernel-doc.pl
> deleted file mode 100755
> index 5db23cbf4eb2..000000000000
> --- a/scripts/kernel-doc.pl
> +++ /dev/null
> @@ -1,2439 +0,0 @@
> -#!/usr/bin/env perl
> -# SPDX-License-Identifier: GPL-2.0
> -# vim: softtabstop=3D4
> -
> -use warnings;
> -use strict;
> -
> -## Copyright (c) 1998 Michael Zucchi, All Rights Reserved        ##
> -## Copyright (C) 2000, 1  Tim Waugh <twaugh@redhat.com>          ##
> -## Copyright (C) 2001  Simon Huggins                             ##
> -## Copyright (C) 2005-2012  Randy Dunlap                         ##
> -## Copyright (C) 2012  Dan Luedtke                               ##
> -## 								 ##
> -## #define enhancements by Armin Kuster <akuster@mvista.com>	 ##
> -## Copyright (c) 2000 MontaVista Software, Inc.			 ##
> -#
> -# Copyright (C) 2022 Tomasz Warnie=C5=82=C5=82o (POD)
> -
> -use Pod::Usage qw/pod2usage/;
> -
> -=3Dhead1 NAME
> -
> -kernel-doc - Print formatted kernel documentation to stdout
> -
> -=3Dhead1 SYNOPSIS
> -
> - kernel-doc [-h] [-v] [-Werror] [-Wall] [-Wreturn] [-Wshort-desc[ription=
]] [-Wcontents-before-sections]
> -   [ -man |
> -     -rst [-enable-lineno] |
> -     -none
> -   ]
> -   [
> -     -export |
> -     -internal |
> -     [-function NAME] ... |
> -     [-nosymbol NAME] ...
> -   ]
> -   [-no-doc-sections]
> -   [-export-file FILE] ...
> -   FILE ...
> -
> -Run `kernel-doc -h` for details.
> -
> -=3Dhead1 DESCRIPTION
> -
> -Read C language source or header FILEs, extract embedded documentation c=
omments,
> -and print formatted documentation to standard output.
> -
> -The documentation comments are identified by the "/**" opening comment m=
ark.
> -
> -See Documentation/doc-guide/kernel-doc.rst for the documentation comment=
 syntax.
> -
> -=3Dcut
> -
> -# more perldoc at the end of the file
> -
> -## init lots of data
> -
> -my $errors =3D 0;
> -my $warnings =3D 0;
> -my $anon_struct_union =3D 0;
> -
> -# match expressions used to find embedded type information
> -my $type_constant =3D '\b``([^\`]+)``\b';
> -my $type_constant2 =3D '\%([-_*\w]+)';
> -my $type_func =3D '(\w+)\(\)';
> -my $type_param =3D '\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)';
> -my $type_param_ref =3D '([\!~\*]?)\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)';
> -my $type_fp_param =3D '\@(\w+)\(\)';  # Special RST handling for func pt=
r params
> -my $type_fp_param2 =3D '\@(\w+->\S+)\(\)';  # Special RST handling for s=
tructs with func ptr params
> -my $type_env =3D '(\$\w+)';
> -my $type_enum =3D '\&(enum\s*([_\w]+))';
> -my $type_struct =3D '\&(struct\s*([_\w]+))';
> -my $type_typedef =3D '\&(typedef\s*([_\w]+))';
> -my $type_union =3D '\&(union\s*([_\w]+))';
> -my $type_member =3D '\&([_\w]+)(\.|->)([_\w]+)';
> -my $type_fallback =3D '\&([_\w]+)';
> -my $type_member_func =3D $type_member . '\(\)';
> -
> -# Output conversion substitutions.
> -#  One for each output format
> -
> -# these are pretty rough
> -my @highlights_man =3D (
> -    [$type_constant, "\$1"],
> -    [$type_constant2, "\$1"],
> -    [$type_func, "\\\\fB\$1\\\\fP"],
> -    [$type_enum, "\\\\fI\$1\\\\fP"],
> -    [$type_struct, "\\\\fI\$1\\\\fP"],
> -    [$type_typedef, "\\\\fI\$1\\\\fP"],
> -    [$type_union, "\\\\fI\$1\\\\fP"],
> -    [$type_param, "\\\\fI\$1\\\\fP"],
> -    [$type_param_ref, "\\\\fI\$1\$2\\\\fP"],
> -    [$type_member, "\\\\fI\$1\$2\$3\\\\fP"],
> -    [$type_fallback, "\\\\fI\$1\\\\fP"]
> -  );
> -my $blankline_man =3D "";
> -
> -# rst-mode
> -my @highlights_rst =3D (
> -    [$type_constant, "``\$1``"],
> -    [$type_constant2, "``\$1``"],
> -
> -    # Note: need to escape () to avoid func matching later
> -    [$type_member_func, "\\:c\\:type\\:`\$1\$2\$3\\\\(\\\\) <\$1>`"],
> -    [$type_member, "\\:c\\:type\\:`\$1\$2\$3 <\$1>`"],
> -    [$type_fp_param, "**\$1\\\\(\\\\)**"],
> -    [$type_fp_param2, "**\$1\\\\(\\\\)**"],
> -    [$type_func, "\$1()"],
> -    [$type_enum, "\\:c\\:type\\:`\$1 <\$2>`"],
> -    [$type_struct, "\\:c\\:type\\:`\$1 <\$2>`"],
> -    [$type_typedef, "\\:c\\:type\\:`\$1 <\$2>`"],
> -    [$type_union, "\\:c\\:type\\:`\$1 <\$2>`"],
> -
> -    # in rst this can refer to any type
> -    [$type_fallback, "\\:c\\:type\\:`\$1`"],
> -    [$type_param_ref, "**\$1\$2**"]
> -  );
> -my $blankline_rst =3D "\n";
> -
> -# read arguments
> -if ($#ARGV =3D=3D -1) {
> -    pod2usage(
> -        -message =3D> "No arguments!\n",
> -        -exitval =3D> 1,
> -        -verbose =3D> 99,
> -        -sections =3D> 'SYNOPSIS',
> -        -output =3D> \*STDERR,
> -      );
> -}
> -
> -my $kernelversion;
> -
> -my $dohighlight =3D "";
> -
> -my $verbose =3D 0;
> -my $Werror =3D 0;
> -my $Wreturn =3D 0;
> -my $Wshort_desc =3D 0;
> -my $output_mode =3D "rst";
> -my $output_preformatted =3D 0;
> -my $no_doc_sections =3D 0;
> -my $enable_lineno =3D 0;
> -my @highlights =3D @highlights_rst;
> -my $blankline =3D $blankline_rst;
> -my $modulename =3D "Kernel API";
> -
> -use constant {
> -    OUTPUT_ALL          =3D> 0, # output all symbols and doc sections
> -    OUTPUT_INCLUDE      =3D> 1, # output only specified symbols
> -    OUTPUT_EXPORTED     =3D> 2, # output exported symbols
> -    OUTPUT_INTERNAL     =3D> 3, # output non-exported symbols
> -};
> -my $output_selection =3D OUTPUT_ALL;
> -my $show_not_found =3D 0;	# No longer used
> -
> -my @export_file_list;
> -
> -my @build_time;
> -if (defined($ENV{'KBUILD_BUILD_TIMESTAMP'}) &&
> -    (my $seconds =3D `date -d "${ENV{'KBUILD_BUILD_TIMESTAMP'}}" +%s`) n=
e '') {
> -    @build_time =3D gmtime($seconds);
> -} else {
> -    @build_time =3D localtime;
> -}
> -
> -my $man_date =3D ('January', 'February', 'March', 'April', 'May', 'June',
> -                'July', 'August', 'September', 'October',
> -                'November', 'December')[$build_time[4]] .
> -    " " . ($build_time[5]+1900);
> -
> -# Essentially these are globals.
> -# They probably want to be tidied up, made more localised or something.
> -# CAVEAT EMPTOR!  Some of the others I localised may not want to be, whi=
ch
> -# could cause "use of undefined value" or other bugs.
> -my ($function, %function_table, %parametertypes, $declaration_purpose);
> -my %nosymbol_table =3D ();
> -my $declaration_start_line;
> -my ($type, $declaration_name, $return_type);
> -my ($newsection, $newcontents, $prototype, $brcount);
> -
> -if (defined($ENV{'KBUILD_VERBOSE'}) && $ENV{'KBUILD_VERBOSE'} =3D~ '1') {
> -    $verbose =3D 1;
> -}
> -
> -if (defined($ENV{'KCFLAGS'})) {
> -    my $kcflags =3D "$ENV{'KCFLAGS'}";
> -
> -    if ($kcflags =3D~ /(\s|^)-Werror(\s|$)/) {
> -        $Werror =3D 1;
> -    }
> -}
> -
> -# reading this variable is for backwards compat just in case
> -# someone was calling it with the variable from outside the
> -# kernel's build system
> -if (defined($ENV{'KDOC_WERROR'})) {
> -    $Werror =3D "$ENV{'KDOC_WERROR'}";
> -}
> -# other environment variables are converted to command-line
> -# arguments in cmd_checkdoc in the build system
> -
> -# Generated docbook code is inserted in a template at a point where
> -# docbook v3.1 requires a non-zero sequence of RefEntry's; see:
> -# https://www.oasis-open.org/docbook/documentation/reference/html/refent=
ry.html
> -# We keep track of number of generated entries and generate a dummy
> -# if needs be to ensure the expanded template can be postprocessed
> -# into html.
> -my $section_counter =3D 0;
> -
> -my $lineprefix=3D"";
> -
> -# Parser states
> -use constant {
> -    STATE_NORMAL        =3D> 0,        # normal code
> -    STATE_NAME          =3D> 1,        # looking for function name
> -    STATE_BODY_MAYBE    =3D> 2,        # body - or maybe more description
> -    STATE_BODY          =3D> 3,        # the body of the comment
> -    STATE_BODY_WITH_BLANK_LINE =3D> 4, # the body, which has a blank line
> -    STATE_PROTO         =3D> 5,        # scanning prototype
> -    STATE_DOCBLOCK      =3D> 6,        # documentation block
> -    STATE_INLINE        =3D> 7,        # gathering doc outside main block
> -};
> -my $state;
> -my $leading_space;
> -
> -# Inline documentation state
> -use constant {
> -    STATE_INLINE_NA     =3D> 0, # not applicable ($state !=3D STATE_INLI=
NE)
> -    STATE_INLINE_NAME   =3D> 1, # looking for member name (@foo:)
> -    STATE_INLINE_TEXT   =3D> 2, # looking for member documentation
> -    STATE_INLINE_END    =3D> 3, # done
> -    STATE_INLINE_ERROR  =3D> 4, # error - Comment without header was fou=
nd.
> -                              # Spit a warning as it's not
> -                              # proper kernel-doc and ignore the rest.
> -};
> -my $inline_doc_state;
> -
> -#declaration types: can be
> -# 'function', 'struct', 'union', 'enum', 'typedef'
> -my $decl_type;
> -
> -# Name of the kernel-doc identifier for non-DOC markups
> -my $identifier;
> -
> -my $doc_start =3D '^/\*\*\s*$'; # Allow whitespace at end of comment sta=
rt.
> -my $doc_end =3D '\*/';
> -my $doc_com =3D '\s*\*\s*';
> -my $doc_com_body =3D '\s*\* ?';
> -my $doc_decl =3D $doc_com . '(\w+)';
> -# @params and a strictly limited set of supported section names
> -# Specifically:
> -#   Match @word:
> -#	  @...:
> -#         @{section-name}:
> -# while trying to not match literal block starts like "example::"
> -#
> -my $doc_sect =3D $doc_com .
> -    '\s*(\@[.\w]+|\@\.\.\.|description|context|returns?|notes?|examples?=
)\s*:([^:].*)?$';
> -my $doc_content =3D $doc_com_body . '(.*)';
> -my $doc_block =3D $doc_com . 'DOC:\s*(.*)?';
> -my $doc_inline_start =3D '^\s*/\*\*\s*$';
> -my $doc_inline_sect =3D '\s*\*\s*(@\s*[\w][\w\.]*\s*):(.*)';
> -my $doc_inline_end =3D '^\s*\*/\s*$';
> -my $doc_inline_oneline =3D '^\s*/\*\*\s*(@[\w\s]+):\s*(.*)\s*\*/\s*$';
> -my $export_symbol =3D '^\s*EXPORT_SYMBOL(_GPL)?\s*\(\s*(\w+)\s*\)\s*;';
> -my $export_symbol_ns =3D '^\s*EXPORT_SYMBOL_NS(_GPL)?\s*\(\s*(\w+)\s*,\s=
*"\S+"\)\s*;';
> -my $function_pointer =3D qr{([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)};
> -my $attribute =3D qr{__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)}i;
> -
> -my %parameterdescs;
> -my %parameterdesc_start_lines;
> -my @parameterlist;
> -my %sections;
> -my @sectionlist;
> -my %section_start_lines;
> -my $sectcheck;
> -my $struct_actual;
> -
> -my $contents =3D "";
> -my $new_start_line =3D 0;
> -
> -# the canonical section names. see also $doc_sect above.
> -my $section_default =3D "Description";	# default section
> -my $section_intro =3D "Introduction";
> -my $section =3D $section_default;
> -my $section_context =3D "Context";
> -my $section_return =3D "Return";
> -
> -my $undescribed =3D "-- undescribed --";
> -
> -reset_state();
> -
> -while ($ARGV[0] =3D~ m/^--?(.*)/) {
> -    my $cmd =3D $1;
> -    shift @ARGV;
> -    if ($cmd eq "man") {
> -        $output_mode =3D "man";
> -        @highlights =3D @highlights_man;
> -        $blankline =3D $blankline_man;
> -    } elsif ($cmd eq "rst") {
> -        $output_mode =3D "rst";
> -        @highlights =3D @highlights_rst;
> -        $blankline =3D $blankline_rst;
> -    } elsif ($cmd eq "none") {
> -        $output_mode =3D "none";
> -    } elsif ($cmd eq "module") { # not needed for XML, inherits from cal=
ling document
> -        $modulename =3D shift @ARGV;
> -    } elsif ($cmd eq "function") { # to only output specific functions
> -        $output_selection =3D OUTPUT_INCLUDE;
> -        $function =3D shift @ARGV;
> -        $function_table{$function} =3D 1;
> -    } elsif ($cmd eq "nosymbol") { # Exclude specific symbols
> -        my $symbol =3D shift @ARGV;
> -        $nosymbol_table{$symbol} =3D 1;
> -    } elsif ($cmd eq "export") { # only exported symbols
> -        $output_selection =3D OUTPUT_EXPORTED;
> -        %function_table =3D ();
> -    } elsif ($cmd eq "internal") { # only non-exported symbols
> -        $output_selection =3D OUTPUT_INTERNAL;
> -        %function_table =3D ();
> -    } elsif ($cmd eq "export-file") {
> -        my $file =3D shift @ARGV;
> -        push(@export_file_list, $file);
> -    } elsif ($cmd eq "v") {
> -        $verbose =3D 1;
> -    } elsif ($cmd eq "Werror") {
> -        $Werror =3D 1;
> -    } elsif ($cmd eq "Wreturn") {
> -        $Wreturn =3D 1;
> -    } elsif ($cmd eq "Wshort-desc" or $cmd eq "Wshort-description") {
> -        $Wshort_desc =3D 1;
> -    } elsif ($cmd eq "Wall") {
> -        $Wreturn =3D 1;
> -        $Wshort_desc =3D 1;
> -    } elsif (($cmd eq "h") || ($cmd eq "help")) {
> -        pod2usage(-exitval =3D> 0, -verbose =3D> 2);
> -    } elsif ($cmd eq 'no-doc-sections') {
> -        $no_doc_sections =3D 1;
> -    } elsif ($cmd eq 'enable-lineno') {
> -        $enable_lineno =3D 1;
> -    } elsif ($cmd eq 'show-not-found') {
> -        $show_not_found =3D 1;  # A no-op but don't fail
> -    } else {
> -        # Unknown argument
> -        pod2usage(
> -            -message =3D> "Argument unknown!\n",
> -            -exitval =3D> 1,
> -            -verbose =3D> 99,
> -            -sections =3D> 'SYNOPSIS',
> -            -output =3D> \*STDERR,
> -            );
> -    }
> -    if ($#ARGV < 0){
> -        pod2usage(
> -            -message =3D> "FILE argument missing\n",
> -            -exitval =3D> 1,
> -            -verbose =3D> 99,
> -            -sections =3D> 'SYNOPSIS',
> -            -output =3D> \*STDERR,
> -            );
> -    }
> -}
> -
> -# continue execution near EOF;
> -
> -sub findprog($)
> -{
> -    foreach(split(/:/, $ENV{PATH})) {
> -        return "$_/$_[0]" if(-x "$_/$_[0]");
> -    }
> -}
> -
> -# get kernel version from env
> -sub get_kernel_version() {
> -    my $version =3D 'unknown kernel version';
> -
> -    if (defined($ENV{'KERNELVERSION'})) {
> -        $version =3D $ENV{'KERNELVERSION'};
> -    }
> -    return $version;
> -}
> -
> -#
> -sub print_lineno {
> -    my $lineno =3D shift;
> -    if ($enable_lineno && defined($lineno)) {
> -        print ".. LINENO " . $lineno . "\n";
> -    }
> -}
> -
> -sub emit_warning {
> -    my $location =3D shift;
> -    my $msg =3D shift;
> -    print STDERR "$location: warning: $msg";
> -    ++$warnings;
> -}
> -##
> -# dumps section contents to arrays/hashes intended for that purpose.
> -#
> -sub dump_section {
> -    my $file =3D shift;
> -    my $name =3D shift;
> -    my $contents =3D join "\n", @_;
> -
> -    if ($name =3D~ m/$type_param/) {
> -        $name =3D $1;
> -        $parameterdescs{$name} =3D $contents;
> -        $sectcheck =3D $sectcheck . $name . " ";
> -        $parameterdesc_start_lines{$name} =3D $new_start_line;
> -        $new_start_line =3D 0;
> -    } elsif ($name eq "@\.\.\.") {
> -        $name =3D "...";
> -        $parameterdescs{$name} =3D $contents;
> -        $sectcheck =3D $sectcheck . $name . " ";
> -        $parameterdesc_start_lines{$name} =3D $new_start_line;
> -        $new_start_line =3D 0;
> -    } else {
> -        if (defined($sections{$name}) && ($sections{$name} ne "")) {
> -            # Only warn on user specified duplicate section names.
> -            if ($name ne $section_default) {
> -                emit_warning("${file}:$.", "duplicate section name '$nam=
e'\n");
> -            }
> -            $sections{$name} .=3D $contents;
> -        } else {
> -            $sections{$name} =3D $contents;
> -            push @sectionlist, $name;
> -            $section_start_lines{$name} =3D $new_start_line;
> -            $new_start_line =3D 0;
> -        }
> -    }
> -}
> -
> -##
> -# dump DOC: section after checking that it should go out
> -#
> -sub dump_doc_section {
> -    my $file =3D shift;
> -    my $name =3D shift;
> -    my $contents =3D join "\n", @_;
> -
> -    if ($no_doc_sections) {
> -        return;
> -    }
> -
> -    return if (defined($nosymbol_table{$name}));
> -
> -    if (($output_selection =3D=3D OUTPUT_ALL) ||
> -        (($output_selection =3D=3D OUTPUT_INCLUDE) &&
> -         defined($function_table{$name})))
> -    {
> -        dump_section($file, $name, $contents);
> -        output_blockhead({'sectionlist' =3D> \@sectionlist,
> -                          'sections' =3D> \%sections,
> -                          'module' =3D> $modulename,
> -                          'content-only' =3D> ($output_selection !=3D OU=
TPUT_ALL), });
> -    }
> -}
> -
> -##
> -# output function
> -#
> -# parameterdescs, a hash.
> -#  function =3D> "function name"
> -#  parameterlist =3D> @list of parameters
> -#  parameterdescs =3D> %parameter descriptions
> -#  sectionlist =3D> @list of sections
> -#  sections =3D> %section descriptions
> -#
> -
> -sub output_highlight {
> -    my $contents =3D join "\n",@_;
> -    my $line;
> -
> -#   DEBUG
> -#   if (!defined $contents) {
> -#	use Carp;
> -#	confess "output_highlight got called with no args?\n";
> -#   }
> -
> -#   print STDERR "contents b4:$contents\n";
> -    eval $dohighlight;
> -    die $@ if $@;
> -#   print STDERR "contents af:$contents\n";
> -
> -    foreach $line (split "\n", $contents) {
> -        if (! $output_preformatted) {
> -            $line =3D~ s/^\s*//;
> -        }
> -        if ($line eq ""){
> -            if (! $output_preformatted) {
> -                print $lineprefix, $blankline;
> -            }
> -        } else {
> -            if ($output_mode eq "man" && substr($line, 0, 1) eq ".") {
> -                print "\\&$line";
> -            } else {
> -                print $lineprefix, $line;
> -            }
> -        }
> -        print "\n";
> -    }
> -}
> -
> -##
> -# output function in man
> -sub output_function_man(%) {
> -    my %args =3D %{$_[0]};
> -    my ($parameter, $section);
> -    my $count;
> -    my $func_macro =3D $args{'func_macro'};
> -    my $paramcount =3D $#{$args{'parameterlist'}}; # -1 is empty
> -
> -    print ".TH \"$args{'function'}\" 9 \"$args{'function'}\" \"$man_date=
\" \"Kernel Hacker's Manual\" LINUX\n";
> -
> -    print ".SH NAME\n";
> -    print $args{'function'} . " \\- " . $args{'purpose'} . "\n";
> -
> -    print ".SH SYNOPSIS\n";
> -    if ($args{'functiontype'} ne "") {
> -        print ".B \"" . $args{'functiontype'} . "\" " . $args{'function'=
} . "\n";
> -    } else {
> -        print ".B \"" . $args{'function'} . "\n";
> -    }
> -    $count =3D 0;
> -    my $parenth =3D "(";
> -    my $post =3D ",";
> -    foreach my $parameter (@{$args{'parameterlist'}}) {
> -        if ($count =3D=3D $#{$args{'parameterlist'}}) {
> -            $post =3D ");";
> -        }
> -        $type =3D $args{'parametertypes'}{$parameter};
> -        if ($type =3D~ m/$function_pointer/) {
> -            # pointer-to-function
> -            print ".BI \"" . $parenth . $1 . "\" " . " \") (" . $2 . ")"=
 . $post . "\"\n";
> -        } else {
> -            $type =3D~ s/([^\*])$/$1 /;
> -            print ".BI \"" . $parenth . $type . "\" " . " \"" . $post . =
"\"\n";
> -        }
> -        $count++;
> -        $parenth =3D "";
> -    }
> -
> -    $paramcount =3D $#{$args{'parameterlist'}}; # -1 is empty
> -    if ($paramcount >=3D 0) {
> -    	print ".SH ARGUMENTS\n";
> -	}
> -    foreach $parameter (@{$args{'parameterlist'}}) {
> -        my $parameter_name =3D $parameter;
> -        $parameter_name =3D~ s/\[.*//;
> -
> -        print ".IP \"" . $parameter . "\" 12\n";
> -        output_highlight($args{'parameterdescs'}{$parameter_name});
> -    }
> -    foreach $section (@{$args{'sectionlist'}}) {
> -        print ".SH \"", uc $section, "\"\n";
> -        output_highlight($args{'sections'}{$section});
> -    }
> -}
> -
> -##
> -# output enum in man
> -sub output_enum_man(%) {
> -    my %args =3D %{$_[0]};
> -    my ($parameter, $section);
> -    my $count;
> -
> -    print ".TH \"$args{'module'}\" 9 \"enum $args{'enum'}\" \"$man_date\=
" \"API Manual\" LINUX\n";
> -
> -    print ".SH NAME\n";
> -    print "enum " . $args{'enum'} . " \\- " . $args{'purpose'} . "\n";
> -
> -    print ".SH SYNOPSIS\n";
> -    print "enum " . $args{'enum'} . " {\n";
> -    $count =3D 0;
> -    foreach my $parameter (@{$args{'parameterlist'}}) {
> -        print ".br\n.BI \"    $parameter\"\n";
> -        if ($count =3D=3D $#{$args{'parameterlist'}}) {
> -            print "\n};\n";
> -            last;
> -        } else {
> -            print ", \n.br\n";
> -        }
> -        $count++;
> -    }
> -
> -    print ".SH Constants\n";
> -    foreach $parameter (@{$args{'parameterlist'}}) {
> -        my $parameter_name =3D $parameter;
> -        $parameter_name =3D~ s/\[.*//;
> -
> -        print ".IP \"" . $parameter . "\" 12\n";
> -        output_highlight($args{'parameterdescs'}{$parameter_name});
> -    }
> -    foreach $section (@{$args{'sectionlist'}}) {
> -        print ".SH \"$section\"\n";
> -        output_highlight($args{'sections'}{$section});
> -    }
> -}
> -
> -##
> -# output struct in man
> -sub output_struct_man(%) {
> -    my %args =3D %{$_[0]};
> -    my ($parameter, $section);
> -
> -    print ".TH \"$args{'module'}\" 9 \"" . $args{'type'} . " " . $args{'=
struct'} . "\" \"$man_date\" \"API Manual\" LINUX\n";
> -
> -    print ".SH NAME\n";
> -    print $args{'type'} . " " . $args{'struct'} . " \\- " . $args{'purpo=
se'} . "\n";
> -
> -    my $declaration =3D $args{'definition'};
> -    $declaration =3D~ s/\t/  /g;
> -    $declaration =3D~ s/\n/"\n.br\n.BI \"/g;
> -    print ".SH SYNOPSIS\n";
> -    print $args{'type'} . " " . $args{'struct'} . " {\n.br\n";
> -    print ".BI \"$declaration\n};\n.br\n\n";
> -
> -    print ".SH Members\n";
> -    foreach $parameter (@{$args{'parameterlist'}}) {
> -        ($parameter =3D~ /^#/) && next;
> -
> -        my $parameter_name =3D $parameter;
> -        $parameter_name =3D~ s/\[.*//;
> -
> -        ($args{'parameterdescs'}{$parameter_name} ne $undescribed) || ne=
xt;
> -        print ".IP \"" . $parameter . "\" 12\n";
> -        output_highlight($args{'parameterdescs'}{$parameter_name});
> -    }
> -    foreach $section (@{$args{'sectionlist'}}) {
> -        print ".SH \"$section\"\n";
> -        output_highlight($args{'sections'}{$section});
> -    }
> -}
> -
> -##
> -# output typedef in man
> -sub output_typedef_man(%) {
> -    my %args =3D %{$_[0]};
> -    my ($parameter, $section);
> -
> -    print ".TH \"$args{'module'}\" 9 \"$args{'typedef'}\" \"$man_date\" =
\"API Manual\" LINUX\n";
> -
> -    print ".SH NAME\n";
> -    print "typedef " . $args{'typedef'} . " \\- " . $args{'purpose'} . "=
\n";
> -
> -    foreach $section (@{$args{'sectionlist'}}) {
> -        print ".SH \"$section\"\n";
> -        output_highlight($args{'sections'}{$section});
> -    }
> -}
> -
> -sub output_blockhead_man(%) {
> -    my %args =3D %{$_[0]};
> -    my ($parameter, $section);
> -    my $count;
> -
> -    print ".TH \"$args{'module'}\" 9 \"$args{'module'}\" \"$man_date\" \=
"API Manual\" LINUX\n";
> -
> -    foreach $section (@{$args{'sectionlist'}}) {
> -        print ".SH \"$section\"\n";
> -        output_highlight($args{'sections'}{$section});
> -    }
> -}
> -
> -##
> -# output in restructured text
> -#
> -
> -#
> -# This could use some work; it's used to output the DOC: sections, and
> -# starts by putting out the name of the doc section itself, but that ten=
ds
> -# to duplicate a header already in the template file.
> -#
> -sub output_blockhead_rst(%) {
> -    my %args =3D %{$_[0]};
> -    my ($parameter, $section);
> -
> -    foreach $section (@{$args{'sectionlist'}}) {
> -        next if (defined($nosymbol_table{$section}));
> -
> -        if ($output_selection !=3D OUTPUT_INCLUDE) {
> -            print ".. _$section:\n\n";
> -            print "**$section**\n\n";
> -        }
> -        print_lineno($section_start_lines{$section});
> -        output_highlight_rst($args{'sections'}{$section});
> -        print "\n";
> -    }
> -}
> -
> -#
> -# Apply the RST highlights to a sub-block of text.
> -#
> -sub highlight_block($) {
> -    # The dohighlight kludge requires the text be called $contents
> -    my $contents =3D shift;
> -    eval $dohighlight;
> -    die $@ if $@;
> -    return $contents;
> -}
> -
> -#
> -# Regexes used only here.
> -#
> -my $sphinx_literal =3D '^[^.].*::$';
> -my $sphinx_cblock =3D '^\.\.\ +code-block::';
> -
> -sub output_highlight_rst {
> -    my $input =3D join "\n",@_;
> -    my $output =3D "";
> -    my $line;
> -    my $in_literal =3D 0;
> -    my $litprefix;
> -    my $block =3D "";
> -
> -    foreach $line (split "\n",$input) {
> -        #
> -        # If we're in a literal block, see if we should drop out
> -        # of it.  Otherwise pass the line straight through unmunged.
> -        #
> -        if ($in_literal) {
> -            if (! ($line =3D~ /^\s*$/)) {
> -                #
> -                # If this is the first non-blank line in a literal
> -                # block we need to figure out what the proper indent is.
> -                #
> -                if ($litprefix eq "") {
> -                    $line =3D~ /^(\s*)/;
> -                    $litprefix =3D '^' . $1;
> -                    $output .=3D $line . "\n";
> -                } elsif (! ($line =3D~ /$litprefix/)) {
> -                    $in_literal =3D 0;
> -                } else {
> -                    $output .=3D $line . "\n";
> -                }
> -            } else {
> -                $output .=3D $line . "\n";
> -            }
> -        }
> -        #
> -        # Not in a literal block (or just dropped out)
> -        #
> -        if (! $in_literal) {
> -            $block .=3D $line . "\n";
> -            if (($line =3D~ /$sphinx_literal/) || ($line =3D~ /$sphinx_c=
block/)) {
> -                $in_literal =3D 1;
> -                $litprefix =3D "";
> -                $output .=3D highlight_block($block);
> -                $block =3D ""
> -            }
> -        }
> -    }
> -
> -    if ($block) {
> -        $output .=3D highlight_block($block);
> -    }
> -
> -    $output =3D~ s/^\n+//g;
> -    $output =3D~ s/\n+$//g;
> -
> -    foreach $line (split "\n", $output) {
> -        print $lineprefix . $line . "\n";
> -    }
> -}
> -
> -sub output_function_rst(%) {
> -    my %args =3D %{$_[0]};
> -    my ($parameter, $section);
> -    my $oldprefix =3D $lineprefix;
> -
> -    my $signature =3D "";
> -    my $func_macro =3D $args{'func_macro'};
> -    my $paramcount =3D $#{$args{'parameterlist'}}; # -1 is empty
> -
> -	if ($func_macro) {
> -        $signature =3D $args{'function'};
> -	} else {
> -		if ($args{'functiontype'}) {
> -        	$signature =3D $args{'functiontype'} . " ";
> -		}
> -		$signature .=3D $args{'function'} . " (";
> -    }
> -
> -    my $count =3D 0;
> -    foreach my $parameter (@{$args{'parameterlist'}}) {
> -        if ($count ne 0) {
> -            $signature .=3D ", ";
> -        }
> -        $count++;
> -        $type =3D $args{'parametertypes'}{$parameter};
> -
> -        if ($type =3D~ m/$function_pointer/) {
> -            # pointer-to-function
> -            $signature .=3D $1 . $parameter . ") (" . $2 . ")";
> -        } else {
> -            $signature .=3D $type;
> -        }
> -    }
> -
> -    if (!$func_macro) {
> -    	$signature .=3D ")";
> -    }
> -
> -    if ($args{'typedef'} || $args{'functiontype'} eq "") {
> -        print ".. c:macro:: ". $args{'function'} . "\n\n";
> -
> -        if ($args{'typedef'}) {
> -            print_lineno($declaration_start_line);
> -            print "   **Typedef**: ";
> -            $lineprefix =3D "";
> -            output_highlight_rst($args{'purpose'});
> -            print "\n\n**Syntax**\n\n";
> -            print "  ``$signature``\n\n";
> -        } else {
> -            print "``$signature``\n\n";
> -        }
> -    } else {
> -        print ".. c:function:: $signature\n\n";
> -    }
> -
> -    if (!$args{'typedef'}) {
> -        print_lineno($declaration_start_line);
> -        $lineprefix =3D "   ";
> -        output_highlight_rst($args{'purpose'});
> -        print "\n";
> -    }
> -
> -    #
> -    # Put our descriptive text into a container (thus an HTML <div>) to =
help
> -    # set the function prototypes apart.
> -    #
> -    $lineprefix =3D "  ";
> -	if ($paramcount >=3D 0) {
> -    	print ".. container:: kernelindent\n\n";
> -   		print $lineprefix . "**Parameters**\n\n";
> -    }
> -    foreach $parameter (@{$args{'parameterlist'}}) {
> -        my $parameter_name =3D $parameter;
> -        $parameter_name =3D~ s/\[.*//;
> -        $type =3D $args{'parametertypes'}{$parameter};
> -
> -        if ($type ne "") {
> -            print $lineprefix . "``$type``\n";
> -        } else {
> -            print $lineprefix . "``$parameter``\n";
> -        }
> -
> -        print_lineno($parameterdesc_start_lines{$parameter_name});
> -
> -        $lineprefix =3D "    ";
> -        if (defined($args{'parameterdescs'}{$parameter_name}) &&
> -            $args{'parameterdescs'}{$parameter_name} ne $undescribed) {
> -            output_highlight_rst($args{'parameterdescs'}{$parameter_name=
});
> -        } else {
> -            print $lineprefix . "*undescribed*\n";
> -        }
> -        $lineprefix =3D "  ";
> -        print "\n";
> -    }
> -
> -    output_section_rst(@_);
> -    $lineprefix =3D $oldprefix;
> -}
> -
> -sub output_section_rst(%) {
> -    my %args =3D %{$_[0]};
> -    my $section;
> -    my $oldprefix =3D $lineprefix;
> -
> -    foreach $section (@{$args{'sectionlist'}}) {
> -        print $lineprefix . "**$section**\n\n";
> -        print_lineno($section_start_lines{$section});
> -        output_highlight_rst($args{'sections'}{$section});
> -        print "\n";
> -    }
> -    print "\n";
> -}
> -
> -sub output_enum_rst(%) {
> -    my %args =3D %{$_[0]};
> -    my ($parameter);
> -    my $oldprefix =3D $lineprefix;
> -    my $count;
> -    my $outer;
> -
> -    my $name =3D $args{'enum'};
> -    print "\n\n.. c:enum:: " . $name . "\n\n";
> -
> -    print_lineno($declaration_start_line);
> -    $lineprefix =3D "  ";
> -    output_highlight_rst($args{'purpose'});
> -    print "\n";
> -
> -    print ".. container:: kernelindent\n\n";
> -    $outer =3D $lineprefix . "  ";
> -    $lineprefix =3D $outer . "  ";
> -    print $outer . "**Constants**\n\n";
> -    foreach $parameter (@{$args{'parameterlist'}}) {
> -        print $outer . "``$parameter``\n";
> -
> -        if ($args{'parameterdescs'}{$parameter} ne $undescribed) {
> -            output_highlight_rst($args{'parameterdescs'}{$parameter});
> -        } else {
> -            print $lineprefix . "*undescribed*\n";
> -        }
> -        print "\n";
> -    }
> -    print "\n";
> -    $lineprefix =3D $oldprefix;
> -    output_section_rst(@_);
> -}
> -
> -sub output_typedef_rst(%) {
> -    my %args =3D %{$_[0]};
> -    my ($parameter);
> -    my $oldprefix =3D $lineprefix;
> -    my $name;
> -
> -    $name =3D $args{'typedef'};
> -
> -    print "\n\n.. c:type:: " . $name . "\n\n";
> -    print_lineno($declaration_start_line);
> -    $lineprefix =3D "   ";
> -    output_highlight_rst($args{'purpose'});
> -    print "\n";
> -
> -    $lineprefix =3D $oldprefix;
> -    output_section_rst(@_);
> -}
> -
> -sub output_struct_rst(%) {
> -    my %args =3D %{$_[0]};
> -    my ($parameter);
> -    my $oldprefix =3D $lineprefix;
> -
> -    my $name =3D $args{'struct'};
> -    if ($args{'type'} eq 'union') {
> -        print "\n\n.. c:union:: " . $name . "\n\n";
> -    } else {
> -        print "\n\n.. c:struct:: " . $name . "\n\n";
> -    }
> -
> -    print_lineno($declaration_start_line);
> -    $lineprefix =3D "  ";
> -    output_highlight_rst($args{'purpose'});
> -    print "\n";
> -
> -    print ".. container:: kernelindent\n\n";
> -    print $lineprefix . "**Definition**::\n\n";
> -    my $declaration =3D $args{'definition'};
> -    $lineprefix =3D $lineprefix . "  ";
> -    $declaration =3D~ s/\t/$lineprefix/g;
> -    print $lineprefix . $args{'type'} . " " . $args{'struct'} . " {\n$de=
claration" . $lineprefix . "};\n\n";
> -
> -    $lineprefix =3D "  ";
> -    print $lineprefix . "**Members**\n\n";
> -    foreach $parameter (@{$args{'parameterlist'}}) {
> -        ($parameter =3D~ /^#/) && next;
> -
> -        my $parameter_name =3D $parameter;
> -        $parameter_name =3D~ s/\[.*//;
> -
> -        ($args{'parameterdescs'}{$parameter_name} ne $undescribed) || ne=
xt;
> -        $type =3D $args{'parametertypes'}{$parameter};
> -        print_lineno($parameterdesc_start_lines{$parameter_name});
> -        print $lineprefix . "``" . $parameter . "``\n";
> -        $lineprefix =3D "    ";
> -        output_highlight_rst($args{'parameterdescs'}{$parameter_name});
> -        $lineprefix =3D "  ";
> -        print "\n";
> -    }
> -    print "\n";
> -
> -    $lineprefix =3D $oldprefix;
> -    output_section_rst(@_);
> -}
> -
> -## none mode output functions
> -
> -sub output_function_none(%) {
> -}
> -
> -sub output_enum_none(%) {
> -}
> -
> -sub output_typedef_none(%) {
> -}
> -
> -sub output_struct_none(%) {
> -}
> -
> -sub output_blockhead_none(%) {
> -}
> -
> -##
> -# generic output function for all types (function, struct/union, typedef=
, enum);
> -# calls the generated, variable output_ function name based on
> -# functype and output_mode
> -sub output_declaration {
> -    no strict 'refs';
> -    my $name =3D shift;
> -    my $functype =3D shift;
> -    my $func =3D "output_${functype}_$output_mode";
> -
> -    return if (defined($nosymbol_table{$name}));
> -
> -    if (($output_selection =3D=3D OUTPUT_ALL) ||
> -        (($output_selection =3D=3D OUTPUT_INCLUDE ||
> -          $output_selection =3D=3D OUTPUT_EXPORTED) &&
> -         defined($function_table{$name})) ||
> -        ($output_selection =3D=3D OUTPUT_INTERNAL &&
> -         !($functype eq "function" && defined($function_table{$name}))))
> -    {
> -        &$func(@_);
> -        $section_counter++;
> -    }
> -}
> -
> -##
> -# generic output function - calls the right one based on current output =
mode.
> -sub output_blockhead {
> -    no strict 'refs';
> -    my $func =3D "output_blockhead_" . $output_mode;
> -    &$func(@_);
> -    $section_counter++;
> -}
> -
> -##
> -# takes a declaration (struct, union, enum, typedef) and
> -# invokes the right handler. NOT called for functions.
> -sub dump_declaration($$) {
> -    no strict 'refs';
> -    my ($prototype, $file) =3D @_;
> -    my $func =3D "dump_" . $decl_type;
> -    &$func(@_);
> -}
> -
> -sub dump_union($$) {
> -    dump_struct(@_);
> -}
> -
> -sub dump_struct($$) {
> -    my $x =3D shift;
> -    my $file =3D shift;
> -    my $decl_type;
> -    my $members;
> -    my $type =3D qr{struct|union};
> -    # For capturing struct/union definition body, i.e. "{members*}qualif=
iers*"
> -    my $qualifiers =3D qr{$attribute|__packed|__aligned|____cacheline_al=
igned_in_smp|____cacheline_aligned};
> -    my $definition_body =3D qr{\{(.*)\}\s*$qualifiers*};
> -    my $struct_members =3D qr{($type)([^\{\};]+)\{([^\{\}]*)\}([^\{\}\;]=
*)\;};
> -
> -    if ($x =3D~ /($type)\s+(\w+)\s*$definition_body/) {
> -        $decl_type =3D $1;
> -        $declaration_name =3D $2;
> -        $members =3D $3;
> -    } elsif ($x =3D~ /typedef\s+($type)\s*$definition_body\s*(\w+)\s*;/)=
 {
> -        $decl_type =3D $1;
> -        $declaration_name =3D $3;
> -        $members =3D $2;
> -    }
> -
> -    if ($members) {
> -        if ($identifier ne $declaration_name) {
> -            emit_warning("${file}:$.", "expecting prototype for $decl_ty=
pe $identifier. Prototype was for $decl_type $declaration_name instead\n");
> -            return;
> -        }
> -
> -        # ignore members marked private:
> -        $members =3D~ s/\/\*\s*private:.*?\/\*\s*public:.*?\*\///gosi;
> -        $members =3D~ s/\/\*\s*private:.*//gosi;
> -        # strip comments:
> -        $members =3D~ s/\/\*.*?\*\///gos;
> -        # strip attributes
> -        $members =3D~ s/\s*$attribute/ /gi;
> -        $members =3D~ s/\s*__aligned\s*\([^;]*\)/ /gos;
> -        $members =3D~ s/\s*__counted_by\s*\([^;]*\)/ /gos;
> -        $members =3D~ s/\s*__counted_by_(le|be)\s*\([^;]*\)/ /gos;
> -        $members =3D~ s/\s*__packed\s*/ /gos;
> -        $members =3D~ s/\s*CRYPTO_MINALIGN_ATTR/ /gos;
> -        $members =3D~ s/\s*____cacheline_aligned_in_smp/ /gos;
> -        $members =3D~ s/\s*____cacheline_aligned/ /gos;
> -        # unwrap struct_group():
> -        # - first eat non-declaration parameters and rewrite for final m=
atch
> -        # - then remove macro, outer parens, and trailing semicolon
> -        $members =3D~ s/\bstruct_group\s*\(([^,]*,)/STRUCT_GROUP(/gos;
> -        $members =3D~ s/\bstruct_group_attr\s*\(([^,]*,){2}/STRUCT_GROUP=
(/gos;
> -        $members =3D~ s/\bstruct_group_tagged\s*\(([^,]*),([^,]*),/struc=
t $1 $2; STRUCT_GROUP(/gos;
> -        $members =3D~ s/\b__struct_group\s*\(([^,]*,){3}/STRUCT_GROUP(/g=
os;
> -        $members =3D~ s/\bSTRUCT_GROUP(\(((?:(?>[^)(]+)|(?1))*)\))[^;]*;=
/$2/gos;
> -
> -        my $args =3D qr{([^,)]+)};
> -        # replace DECLARE_BITMAP
> -        $members =3D~ s/__ETHTOOL_DECLARE_LINK_MODE_MASK\s*\(([^\)]+)\)/=
DECLARE_BITMAP($1, __ETHTOOL_LINK_MODE_MASK_NBITS)/gos;
> -        $members =3D~ s/DECLARE_PHY_INTERFACE_MASK\s*\(([^\)]+)\)/DECLAR=
E_BITMAP($1, PHY_INTERFACE_MODE_MAX)/gos;
> -        $members =3D~ s/DECLARE_BITMAP\s*\($args,\s*$args\)/unsigned lon=
g $1\[BITS_TO_LONGS($2)\]/gos;
> -        # replace DECLARE_HASHTABLE
> -        $members =3D~ s/DECLARE_HASHTABLE\s*\($args,\s*$args\)/unsigned =
long $1\[1 << (($2) - 1)\]/gos;
> -        # replace DECLARE_KFIFO
> -        $members =3D~ s/DECLARE_KFIFO\s*\($args,\s*$args,\s*$args\)/$2 \=
*$1/gos;
> -        # replace DECLARE_KFIFO_PTR
> -        $members =3D~ s/DECLARE_KFIFO_PTR\s*\($args,\s*$args\)/$2 \*$1/g=
os;
> -        # replace DECLARE_FLEX_ARRAY
> -        $members =3D~ s/(?:__)?DECLARE_FLEX_ARRAY\s*\($args,\s*$args\)/$=
1 $2\[\]/gos;
> -        #replace DEFINE_DMA_UNMAP_ADDR
> -        $members =3D~ s/DEFINE_DMA_UNMAP_ADDR\s*\($args\)/dma_addr_t $1/=
gos;
> -        #replace DEFINE_DMA_UNMAP_LEN
> -        $members =3D~ s/DEFINE_DMA_UNMAP_LEN\s*\($args\)/__u32 $1/gos;
> -        my $declaration =3D $members;
> -
> -        # Split nested struct/union elements as newer ones
> -        while ($members =3D~ m/$struct_members/) {
> -            my $newmember;
> -            my $maintype =3D $1;
> -            my $ids =3D $4;
> -            my $content =3D $3;
> -            foreach my $id(split /,/, $ids) {
> -                $newmember .=3D "$maintype $id; ";
> -
> -                $id =3D~ s/[:\[].*//;
> -                $id =3D~ s/^\s*\**(\S+)\s*/$1/;
> -                foreach my $arg (split /;/, $content) {
> -                    next if ($arg =3D~ m/^\s*$/);
> -                    if ($arg =3D~ m/^([^\(]+\(\*?\s*)([\w\.]*)(\s*\).*)/=
) {
> -                        # pointer-to-function
> -                        my $type =3D $1;
> -                        my $name =3D $2;
> -                        my $extra =3D $3;
> -                        next if (!$name);
> -                        if ($id =3D~ m/^\s*$/) {
> -                            # anonymous struct/union
> -                            $newmember .=3D "$type$name$extra; ";
> -                        } else {
> -                            $newmember .=3D "$type$id.$name$extra; ";
> -                        }
> -                    } else {
> -                        my $type;
> -                        my $names;
> -                        $arg =3D~ s/^\s+//;
> -                        $arg =3D~ s/\s+$//;
> -                        # Handle bitmaps
> -                        $arg =3D~ s/:\s*\d+\s*//g;
> -                        # Handle arrays
> -                        $arg =3D~ s/\[.*\]//g;
> -                        # The type may have multiple words,
> -                        # and multiple IDs can be defined, like:
> -                        #    const struct foo, *bar, foobar
> -                        # So, we remove spaces when parsing the
> -                        # names, in order to match just names
> -                        # and commas for the names
> -                        $arg =3D~ s/\s*,\s*/,/g;
> -                        if ($arg =3D~ m/(.*)\s+([\S+,]+)/) {
> -                            $type =3D $1;
> -                            $names =3D $2;
> -                        } else {
> -                            $newmember .=3D "$arg; ";
> -                            next;
> -                        }
> -                        foreach my $name (split /,/, $names) {
> -                            $name =3D~ s/^\s*\**(\S+)\s*/$1/;
> -                            next if (($name =3D~ m/^\s*$/));
> -                            if ($id =3D~ m/^\s*$/) {
> -                                # anonymous struct/union
> -                                $newmember .=3D "$type $name; ";
> -                            } else {
> -                                $newmember .=3D "$type $id.$name; ";
> -                            }
> -                        }
> -                    }
> -                }
> -            }
> -            $members =3D~ s/$struct_members/$newmember/;
> -        }
> -
> -        # Ignore other nested elements, like enums
> -        $members =3D~ s/(\{[^\{\}]*\})//g;
> -
> -        create_parameterlist($members, ';', $file, $declaration_name);
> -        check_sections($file, $declaration_name, $decl_type, $sectcheck,=
 $struct_actual);
> -
> -        # Adjust declaration for better display
> -        $declaration =3D~ s/([\{;])/$1\n/g;
> -        $declaration =3D~ s/\}\s+;/};/g;
> -        # Better handle inlined enums
> -        do {} while ($declaration =3D~ s/(enum\s+\{[^\}]+),([^\n])/$1,\n=
$2/);
> -
> -        my @def_args =3D split /\n/, $declaration;
> -        my $level =3D 1;
> -        $declaration =3D "";
> -        foreach my $clause (@def_args) {
> -            $clause =3D~ s/^\s+//;
> -            $clause =3D~ s/\s+$//;
> -            $clause =3D~ s/\s+/ /;
> -            next if (!$clause);
> -            $level-- if ($clause =3D~ m/(\})/ && $level > 1);
> -            if (!($clause =3D~ m/^\s*#/)) {
> -                $declaration .=3D "\t" x $level;
> -            }
> -            $declaration .=3D "\t" . $clause . "\n";
> -            $level++ if ($clause =3D~ m/(\{)/ && !($clause =3D~m/\}/));
> -        }
> -        output_declaration($declaration_name,
> -                   'struct',
> -                   {'struct' =3D> $declaration_name,
> -                    'module' =3D> $modulename,
> -                    'definition' =3D> $declaration,
> -                    'parameterlist' =3D> \@parameterlist,
> -                    'parameterdescs' =3D> \%parameterdescs,
> -                    'parametertypes' =3D> \%parametertypes,
> -                    'sectionlist' =3D> \@sectionlist,
> -                    'sections' =3D> \%sections,
> -                    'purpose' =3D> $declaration_purpose,
> -                    'type' =3D> $decl_type
> -                   });
> -    } else {
> -        print STDERR "${file}:$.: error: Cannot parse struct or union!\n=
";
> -        ++$errors;
> -    }
> -}
> -
> -
> -sub show_warnings($$) {
> -    my $functype =3D shift;
> -    my $name =3D shift;
> -
> -    return 0 if (defined($nosymbol_table{$name}));
> -
> -    return 1 if ($output_selection =3D=3D OUTPUT_ALL);
> -
> -    if ($output_selection =3D=3D OUTPUT_EXPORTED) {
> -        if (defined($function_table{$name})) {
> -            return 1;
> -        } else {
> -            return 0;
> -        }
> -    }
> -    if ($output_selection =3D=3D OUTPUT_INTERNAL) {
> -        if (!($functype eq "function" && defined($function_table{$name})=
)) {
> -            return 1;
> -        } else {
> -            return 0;
> -        }
> -    }
> -    if ($output_selection =3D=3D OUTPUT_INCLUDE) {
> -        if (defined($function_table{$name})) {
> -            return 1;
> -        } else {
> -            return 0;
> -        }
> -    }
> -    die("Please add the new output type at show_warnings()");
> -}
> -
> -sub dump_enum($$) {
> -    my $x =3D shift;
> -    my $file =3D shift;
> -    my $members;
> -
> -    # ignore members marked private:
> -    $x =3D~ s/\/\*\s*private:.*?\/\*\s*public:.*?\*\///gosi;
> -    $x =3D~ s/\/\*\s*private:.*}/}/gosi;
> -
> -    $x =3D~ s@/\*.*?\*/@@gos;	# strip comments.
> -    # strip #define macros inside enums
> -    $x =3D~ s@#\s*((define|ifdef|if)\s+|endif)[^;]*;@@gos;
> -
> -    if ($x =3D~ /typedef\s+enum\s*\{(.*)\}\s*(\w*)\s*;/) {
> -        $declaration_name =3D $2;
> -        $members =3D $1;
> -    } elsif ($x =3D~ /enum\s+(\w*)\s*\{(.*)\}/) {
> -        $declaration_name =3D $1;
> -        $members =3D $2;
> -    }
> -
> -    if ($members) {
> -        if ($identifier ne $declaration_name) {
> -            if ($identifier eq "") {
> -                emit_warning("${file}:$.", "wrong kernel-doc identifier =
on line:\n");
> -            } else {
> -                emit_warning("${file}:$.", "expecting prototype for enum=
 $identifier. Prototype was for enum $declaration_name instead\n");
> -            }
> -            return;
> -        }
> -        $declaration_name =3D "(anonymous)" if ($declaration_name eq "");
> -
> -        my %_members;
> -
> -        $members =3D~ s/\s+$//;
> -        $members =3D~ s/\([^;]*?[\)]//g;
> -
> -        foreach my $arg (split ',', $members) {
> -            $arg =3D~ s/^\s*(\w+).*/$1/;
> -            push @parameterlist, $arg;
> -            if (!$parameterdescs{$arg}) {
> -                $parameterdescs{$arg} =3D $undescribed;
> -                if (show_warnings("enum", $declaration_name)) {
> -                    emit_warning("${file}:$.", "Enum value '$arg' not de=
scribed in enum '$declaration_name'\n");
> -                }
> -            }
> -            $_members{$arg} =3D 1;
> -        }
> -
> -        while (my ($k, $v) =3D each %parameterdescs) {
> -            if (!exists($_members{$k})) {
> -                if (show_warnings("enum", $declaration_name)) {
> -                    emit_warning("${file}:$.", "Excess enum value '$k' d=
escription in '$declaration_name'\n");
> -                }
> -            }
> -        }
> -
> -        output_declaration($declaration_name,
> -                           'enum',
> -                           {'enum' =3D> $declaration_name,
> -                            'module' =3D> $modulename,
> -                            'parameterlist' =3D> \@parameterlist,
> -                            'parameterdescs' =3D> \%parameterdescs,
> -                            'sectionlist' =3D> \@sectionlist,
> -                            'sections' =3D> \%sections,
> -                            'purpose' =3D> $declaration_purpose
> -                           });
> -    } else {
> -        print STDERR "${file}:$.: error: Cannot parse enum!\n";
> -        ++$errors;
> -    }
> -}
> -
> -my $typedef_type =3D qr { ((?:\s+[\w\*]+\b){0,7}\s+(?:\w+\b|\*+))\s* }x;
> -my $typedef_ident =3D qr { \*?\s*(\w\S+)\s* }x;
> -my $typedef_args =3D qr { \s*\((.*)\); }x;
> -
> -my $typedef1 =3D qr { typedef$typedef_type\($typedef_ident\)$typedef_arg=
s }x;
> -my $typedef2 =3D qr { typedef$typedef_type$typedef_ident$typedef_args }x;
> -
> -sub dump_typedef($$) {
> -    my $x =3D shift;
> -    my $file =3D shift;
> -
> -    $x =3D~ s@/\*.*?\*/@@gos;	# strip comments.
> -
> -    # Parse function typedef prototypes
> -    if ($x =3D~ $typedef1 || $x =3D~ $typedef2) {
> -        $return_type =3D $1;
> -        $declaration_name =3D $2;
> -        my $args =3D $3;
> -        $return_type =3D~ s/^\s+//;
> -
> -        if ($identifier ne $declaration_name) {
> -            emit_warning("${file}:$.", "expecting prototype for typedef =
$identifier. Prototype was for typedef $declaration_name instead\n");
> -            return;
> -        }
> -
> -        create_parameterlist($args, ',', $file, $declaration_name);
> -
> -        output_declaration($declaration_name,
> -                           'function',
> -                           {'function' =3D> $declaration_name,
> -                            'typedef' =3D> 1,
> -                            'module' =3D> $modulename,
> -                            'functiontype' =3D> $return_type,
> -                            'parameterlist' =3D> \@parameterlist,
> -                            'parameterdescs' =3D> \%parameterdescs,
> -                            'parametertypes' =3D> \%parametertypes,
> -                            'sectionlist' =3D> \@sectionlist,
> -                            'sections' =3D> \%sections,
> -                            'purpose' =3D> $declaration_purpose
> -                           });
> -        return;
> -    }
> -
> -    while (($x =3D~ /\(*.\)\s*;$/) || ($x =3D~ /\[*.\]\s*;$/)) {
> -        $x =3D~ s/\(*.\)\s*;$/;/;
> -        $x =3D~ s/\[*.\]\s*;$/;/;
> -    }
> -
> -    if ($x =3D~ /typedef.*\s+(\w+)\s*;/) {
> -        $declaration_name =3D $1;
> -
> -        if ($identifier ne $declaration_name) {
> -            emit_warning("${file}:$.", "expecting prototype for typedef =
$identifier. Prototype was for typedef $declaration_name instead\n");
> -            return;
> -        }
> -
> -        output_declaration($declaration_name,
> -                           'typedef',
> -                           {'typedef' =3D> $declaration_name,
> -                            'module' =3D> $modulename,
> -                            'sectionlist' =3D> \@sectionlist,
> -                            'sections' =3D> \%sections,
> -                            'purpose' =3D> $declaration_purpose
> -                           });
> -    } else {
> -        print STDERR "${file}:$.: error: Cannot parse typedef!\n";
> -        ++$errors;
> -    }
> -}
> -
> -sub save_struct_actual($) {
> -    my $actual =3D shift;
> -
> -    # strip all spaces from the actual param so that it looks like one s=
tring item
> -    $actual =3D~ s/\s*//g;
> -    $struct_actual =3D $struct_actual . $actual . " ";
> -}
> -
> -sub create_parameterlist($$$$) {
> -    my $args =3D shift;
> -    my $splitter =3D shift;
> -    my $file =3D shift;
> -    my $declaration_name =3D shift;
> -    my $type;
> -    my $param;
> -
> -    # temporarily replace commas inside function pointer definition
> -    my $arg_expr =3D qr{\([^\),]+};
> -    while ($args =3D~ /$arg_expr,/) {
> -        $args =3D~ s/($arg_expr),/$1#/g;
> -    }
> -
> -    foreach my $arg (split($splitter, $args)) {
> -        # strip comments
> -        $arg =3D~ s/\/\*.*\*\///;
> -        # ignore argument attributes
> -        $arg =3D~ s/\sPOS0?\s/ /;
> -        # strip leading/trailing spaces
> -        $arg =3D~ s/^\s*//;
> -        $arg =3D~ s/\s*$//;
> -        $arg =3D~ s/\s+/ /;
> -
> -        if ($arg =3D~ /^#/) {
> -            # Treat preprocessor directive as a typeless variable just t=
o fill
> -            # corresponding data structures "correctly". Catch it later =
in
> -            # output_* subs.
> -            push_parameter($arg, "", "", $file);
> -        } elsif ($arg =3D~ m/\(.+\)\s*\(/) {
> -            # pointer-to-function
> -            $arg =3D~ tr/#/,/;
> -            $arg =3D~ m/[^\(]+\(\*?\s*([\w\[\]\.]*)\s*\)/;
> -            $param =3D $1;
> -            $type =3D $arg;
> -            $type =3D~ s/([^\(]+\(\*?)\s*$param/$1/;
> -            save_struct_actual($param);
> -            push_parameter($param, $type, $arg, $file, $declaration_name=
);
> -        } elsif ($arg =3D~ m/\(.+\)\s*\[/) {
> -            # array-of-pointers
> -            $arg =3D~ tr/#/,/;
> -            $arg =3D~ m/[^\(]+\(\s*\*\s*([\w\[\]\.]*?)\s*(\s*\[\s*[\w]+\=
s*\]\s*)*\)/;
> -            $param =3D $1;
> -            $type =3D $arg;
> -            $type =3D~ s/([^\(]+\(\*?)\s*$param/$1/;
> -            save_struct_actual($param);
> -            push_parameter($param, $type, $arg, $file, $declaration_name=
);
> -        } elsif ($arg) {
> -            $arg =3D~ s/\s*:\s*/:/g;
> -            $arg =3D~ s/\s*\[/\[/g;
> -
> -            my @args =3D split('\s*,\s*', $arg);
> -            if ($args[0] =3D~ m/\*/) {
> -                $args[0] =3D~ s/(\*+)\s*/ $1/;
> -            }
> -
> -            my @first_arg;
> -            if ($args[0] =3D~ /^(.*\s+)(.*?\[.*\].*)$/) {
> -                shift @args;
> -                push(@first_arg, split('\s+', $1));
> -                push(@first_arg, $2);
> -            } else {
> -                @first_arg =3D split('\s+', shift @args);
> -            }
> -
> -            unshift(@args, pop @first_arg);
> -            $type =3D join " ", @first_arg;
> -
> -            foreach $param (@args) {
> -                if ($param =3D~ m/^(\*+)\s*(.*)/) {
> -                    save_struct_actual($2);
> -
> -                    push_parameter($2, "$type $1", $arg, $file, $declara=
tion_name);
> -                } elsif ($param =3D~ m/(.*?):(\w+)/) {
> -                    if ($type ne "") { # skip unnamed bit-fields
> -                        save_struct_actual($1);
> -                        push_parameter($1, "$type:$2", $arg, $file, $dec=
laration_name)
> -                    }
> -                } else {
> -                    save_struct_actual($param);
> -                    push_parameter($param, $type, $arg, $file, $declarat=
ion_name);
> -                }
> -            }
> -        }
> -    }
> -}
> -
> -sub push_parameter($$$$$) {
> -    my $param =3D shift;
> -    my $type =3D shift;
> -    my $org_arg =3D shift;
> -    my $file =3D shift;
> -    my $declaration_name =3D shift;
> -
> -    if (($anon_struct_union =3D=3D 1) && ($type eq "") &&
> -        ($param eq "}")) {
> -        return;        # ignore the ending }; from anon. struct/union
> -    }
> -
> -    $anon_struct_union =3D 0;
> -    $param =3D~ s/[\[\)].*//;
> -
> -    if ($type eq "" && $param =3D~ /\.\.\.$/)
> -    {
> -        if (!$param =3D~ /\w\.\.\.$/) {
> -            # handles unnamed variable parameters
> -            $param =3D "...";
> -        } elsif ($param =3D~ /\w\.\.\.$/) {
> -            # for named variable parameters of the form `x...`, remove t=
he dots
> -            $param =3D~ s/\.\.\.$//;
> -        }
> -        if (!defined $parameterdescs{$param} || $parameterdescs{$param} =
eq "") {
> -            $parameterdescs{$param} =3D "variable arguments";
> -        }
> -    }
> -    elsif ($type eq "" && ($param eq "" or $param eq "void"))
> -    {
> -        $param=3D"void";
> -        $parameterdescs{void} =3D "no arguments";
> -    }
> -    elsif ($type eq "" && ($param eq "struct" or $param eq "union"))
> -    # handle unnamed (anonymous) union or struct:
> -    {
> -        $type =3D $param;
> -        $param =3D "{unnamed_" . $param . "}";
> -        $parameterdescs{$param} =3D "anonymous\n";
> -        $anon_struct_union =3D 1;
> -    }
> -    elsif ($param =3D~ "__cacheline_group" )
> -    # handle cache group enforcing variables: they do not need be descri=
bed in header files
> -    {
> -        return; # ignore __cacheline_group_begin and __cacheline_group_e=
nd
> -    }
> -
> -    # warn if parameter has no description
> -    # (but ignore ones starting with # as these are not parameters
> -    # but inline preprocessor statements);
> -    # Note: It will also ignore void params and unnamed structs/unions
> -    if (!defined $parameterdescs{$param} && $param !~ /^#/) {
> -        $parameterdescs{$param} =3D $undescribed;
> -
> -        if (show_warnings($type, $declaration_name) && $param !~ /\./) {
> -            emit_warning("${file}:$.", "Function parameter or struct mem=
ber '$param' not described in '$declaration_name'\n");
> -        }
> -    }
> -
> -    # strip spaces from $param so that it is one continuous string
> -    # on @parameterlist;
> -    # this fixes a problem where check_sections() cannot find
> -    # a parameter like "addr[6 + 2]" because it actually appears
> -    # as "addr[6", "+", "2]" on the parameter list;
> -    # but it's better to maintain the param string unchanged for output,
> -    # so just weaken the string compare in check_sections() to ignore
> -    # "[blah" in a parameter string;
> -    ###$param =3D~ s/\s*//g;
> -    push @parameterlist, $param;
> -    $org_arg =3D~ s/\s\s+/ /g;
> -    $parametertypes{$param} =3D $org_arg;
> -}
> -
> -sub check_sections($$$$$) {
> -    my ($file, $decl_name, $decl_type, $sectcheck, $prmscheck) =3D @_;
> -    my @sects =3D split ' ', $sectcheck;
> -    my @prms =3D split ' ', $prmscheck;
> -    my $err;
> -    my ($px, $sx);
> -    my $prm_clean;        # strip trailing "[array size]" and/or beginni=
ng "*"
> -
> -    foreach $sx (0 .. $#sects) {
> -        $err =3D 1;
> -        foreach $px (0 .. $#prms) {
> -            $prm_clean =3D $prms[$px];
> -            $prm_clean =3D~ s/\[.*\]//;
> -            $prm_clean =3D~ s/$attribute//i;
> -            # ignore array size in a parameter string;
> -            # however, the original param string may contain
> -            # spaces, e.g.:  addr[6 + 2]
> -            # and this appears in @prms as "addr[6" since the
> -            # parameter list is split at spaces;
> -            # hence just ignore "[..." for the sections check;
> -            $prm_clean =3D~ s/\[.*//;
> -
> -            ##$prm_clean =3D~ s/^\**//;
> -            if ($prm_clean eq $sects[$sx]) {
> -                $err =3D 0;
> -                last;
> -            }
> -        }
> -        if ($err) {
> -            if ($decl_type eq "function") {
> -                emit_warning("${file}:$.",
> -                    "Excess function parameter " .
> -                    "'$sects[$sx]' " .
> -                    "description in '$decl_name'\n");
> -            } elsif (($decl_type eq "struct") or
> -                          ($decl_type eq "union")) {
> -                emit_warning("${file}:$.",
> -                    "Excess $decl_type member " .
> -                    "'$sects[$sx]' " .
> -                    "description in '$decl_name'\n");
> -            }
> -        }
> -    }
> -}
> -
> -##
> -# Checks the section describing the return value of a function.
> -sub check_return_section {
> -    my $file =3D shift;
> -    my $declaration_name =3D shift;
> -    my $return_type =3D shift;
> -
> -    # Ignore an empty return type (It's a macro)
> -    # Ignore functions with a "void" return type. (But don't ignore "voi=
d *")
> -    if (($return_type eq "") || ($return_type =3D~ /void\s*\w*\s*$/)) {
> -        return;
> -    }
> -
> -    if (!defined($sections{$section_return}) ||
> -        $sections{$section_return} eq "")
> -    {
> -        emit_warning("${file}:$.",
> -                     "No description found for return value of " .
> -                     "'$declaration_name'\n");
> -    }
> -}
> -
> -##
> -# takes a function prototype and the name of the current file being
> -# processed and spits out all the details stored in the global
> -# arrays/hashes.
> -sub dump_function($$) {
> -    my $prototype =3D shift;
> -    my $file =3D shift;
> -    my $func_macro =3D 0;
> -
> -    print_lineno($new_start_line);
> -
> -    $prototype =3D~ s/^static +//;
> -    $prototype =3D~ s/^extern +//;
> -    $prototype =3D~ s/^asmlinkage +//;
> -    $prototype =3D~ s/^inline +//;
> -    $prototype =3D~ s/^__inline__ +//;
> -    $prototype =3D~ s/^__inline +//;
> -    $prototype =3D~ s/^__always_inline +//;
> -    $prototype =3D~ s/^noinline +//;
> -    $prototype =3D~ s/^__FORTIFY_INLINE +//;
> -    $prototype =3D~ s/__init +//;
> -    $prototype =3D~ s/__init_or_module +//;
> -    $prototype =3D~ s/__deprecated +//;
> -    $prototype =3D~ s/__flatten +//;
> -    $prototype =3D~ s/__meminit +//;
> -    $prototype =3D~ s/__must_check +//;
> -    $prototype =3D~ s/__weak +//;
> -    $prototype =3D~ s/__sched +//;
> -    $prototype =3D~ s/_noprof//;
> -    $prototype =3D~ s/__printf\s*\(\s*\d*\s*,\s*\d*\s*\) +//;
> -    $prototype =3D~ s/__(?:re)?alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\)=
 +//;
> -    $prototype =3D~ s/__diagnose_as\s*\(\s*\S+\s*(?:,\s*\d+\s*)*\) +//;
> -    $prototype =3D~ s/DECL_BUCKET_PARAMS\s*\(\s*(\S+)\s*,\s*(\S+)\s*\)/$=
1, $2/;
> -    my $define =3D $prototype =3D~ s/^#\s*define\s+//; #ak added
> -    $prototype =3D~ s/__attribute_const__ +//;
> -    $prototype =3D~ s/__attribute__\s*\(\(
> -            (?:
> -                 [\w\s]++          # attribute name
> -                 (?:\([^)]*+\))?   # attribute arguments
> -                 \s*+,?            # optional comma at the end
> -            )+
> -          \)\)\s+//x;
> -
> -    # Yes, this truly is vile.  We are looking for:
> -    # 1. Return type (may be nothing if we're looking at a macro)
> -    # 2. Function name
> -    # 3. Function parameters.
> -    #
> -    # All the while we have to watch out for function pointer parameters
> -    # (which IIRC is what the two sections are for), C types (these
> -    # regexps don't even start to express all the possibilities), and
> -    # so on.
> -    #
> -    # If you mess with these regexps, it's a good idea to check that
> -    # the following functions' documentation still comes out right:
> -    # - parport_register_device (function pointer parameters)
> -    # - atomic_set (macro)
> -    # - pci_match_device, __copy_to_user (long return type)
> -    my $name =3D qr{[a-zA-Z0-9_~:]+};
> -    my $prototype_end1 =3D qr{[^\(]*};
> -    my $prototype_end2 =3D qr{[^\{]*};
> -    my $prototype_end =3D qr{\(($prototype_end1|$prototype_end2)\)};
> -    my $type1 =3D qr{[\w\s]+};
> -    my $type2 =3D qr{$type1\*+};
> -
> -    if ($define && $prototype =3D~ m/^()($name)\s+/) {
> -        # This is an object-like macro, it has no return type and no par=
ameter
> -        # list.
> -        # Function-like macros are not allowed to have spaces between
> -        # declaration_name and opening parenthesis (notice the \s+).
> -        $return_type =3D $1;
> -        $declaration_name =3D $2;
> -        $func_macro =3D 1;
> -    } elsif ($prototype =3D~ m/^()($name)\s*$prototype_end/ ||
> -        $prototype =3D~ m/^($type1)\s+($name)\s*$prototype_end/ ||
> -        $prototype =3D~ m/^($type2+)\s*($name)\s*$prototype_end/)  {
> -        $return_type =3D $1;
> -        $declaration_name =3D $2;
> -        my $args =3D $3;
> -
> -        create_parameterlist($args, ',', $file, $declaration_name);
> -    } else {
> -        emit_warning("${file}:$.", "cannot understand function prototype=
: '$prototype'\n");
> -        return;
> -    }
> -
> -    if ($identifier ne $declaration_name) {
> -        emit_warning("${file}:$.", "expecting prototype for $identifier(=
). Prototype was for $declaration_name() instead\n");
> -        return;
> -    }
> -
> -    my $prms =3D join " ", @parameterlist;
> -    check_sections($file, $declaration_name, "function", $sectcheck, $pr=
ms);
> -
> -    # This check emits a lot of warnings at the moment, because many
> -    # functions don't have a 'Return' doc section. So until the number
> -    # of warnings goes sufficiently down, the check is only performed in
> -    # -Wreturn mode.
> -    # TODO: always perform the check.
> -    if ($Wreturn && !$func_macro) {
> -        check_return_section($file, $declaration_name, $return_type);
> -    }
> -
> -    # The function parser can be called with a typedef parameter.
> -    # Handle it.
> -    if ($return_type =3D~ /typedef/) {
> -        output_declaration($declaration_name,
> -                           'function',
> -                           {'function' =3D> $declaration_name,
> -                            'typedef' =3D> 1,
> -                            'module' =3D> $modulename,
> -                            'functiontype' =3D> $return_type,
> -                            'parameterlist' =3D> \@parameterlist,
> -                            'parameterdescs' =3D> \%parameterdescs,
> -                            'parametertypes' =3D> \%parametertypes,
> -                            'sectionlist' =3D> \@sectionlist,
> -                            'sections' =3D> \%sections,
> -                            'purpose' =3D> $declaration_purpose,
> -							'func_macro' =3D> $func_macro
> -                           });
> -    } else {
> -        output_declaration($declaration_name,
> -                           'function',
> -                           {'function' =3D> $declaration_name,
> -                            'module' =3D> $modulename,
> -                            'functiontype' =3D> $return_type,
> -                            'parameterlist' =3D> \@parameterlist,
> -                            'parameterdescs' =3D> \%parameterdescs,
> -                            'parametertypes' =3D> \%parametertypes,
> -                            'sectionlist' =3D> \@sectionlist,
> -                            'sections' =3D> \%sections,
> -                            'purpose' =3D> $declaration_purpose,
> -							'func_macro' =3D> $func_macro
> -                           });
> -    }
> -}
> -
> -sub reset_state {
> -    $function =3D "";
> -    %parameterdescs =3D ();
> -    %parametertypes =3D ();
> -    @parameterlist =3D ();
> -    %sections =3D ();
> -    @sectionlist =3D ();
> -    $sectcheck =3D "";
> -    $struct_actual =3D "";
> -    $prototype =3D "";
> -
> -    $state =3D STATE_NORMAL;
> -    $inline_doc_state =3D STATE_INLINE_NA;
> -}
> -
> -sub tracepoint_munge($) {
> -    my $file =3D shift;
> -    my $tracepointname =3D 0;
> -    my $tracepointargs =3D 0;
> -
> -    if ($prototype =3D~ m/TRACE_EVENT\((.*?),/) {
> -        $tracepointname =3D $1;
> -    }
> -    if ($prototype =3D~ m/DEFINE_SINGLE_EVENT\((.*?),/) {
> -        $tracepointname =3D $1;
> -    }
> -    if ($prototype =3D~ m/DEFINE_EVENT\((.*?),(.*?),/) {
> -        $tracepointname =3D $2;
> -    }
> -    $tracepointname =3D~ s/^\s+//; #strip leading whitespace
> -    if ($prototype =3D~ m/TP_PROTO\((.*?)\)/) {
> -        $tracepointargs =3D $1;
> -    }
> -    if (($tracepointname eq 0) || ($tracepointargs eq 0)) {
> -        emit_warning("${file}:$.", "Unrecognized tracepoint format: \n".
> -                 "$prototype\n");
> -    } else {
> -        $prototype =3D "static inline void trace_$tracepointname($tracep=
ointargs)";
> -        $identifier =3D "trace_$identifier";
> -    }
> -}
> -
> -sub syscall_munge() {
> -    my $void =3D 0;
> -
> -    $prototype =3D~ s@[\r\n]+@ @gos; # strip newlines/CR's
> -##    if ($prototype =3D~ m/SYSCALL_DEFINE0\s*\(\s*(a-zA-Z0-9_)*\s*\)/) {
> -    if ($prototype =3D~ m/SYSCALL_DEFINE0/) {
> -        $void =3D 1;
> -##        $prototype =3D "long sys_$1(void)";
> -    }
> -
> -    $prototype =3D~ s/SYSCALL_DEFINE.*\(/long sys_/; # fix return type &=
 func name
> -    if ($prototype =3D~ m/long (sys_.*?),/) {
> -        $prototype =3D~ s/,/\(/;
> -    } elsif ($void) {
> -        $prototype =3D~ s/\)/\(void\)/;
> -    }
> -
> -    # now delete all of the odd-number commas in $prototype
> -    # so that arg types & arg names don't have a comma between them
> -    my $count =3D 0;
> -    my $len =3D length($prototype);
> -    if ($void) {
> -        $len =3D 0;    # skip the for-loop
> -    }
> -    for (my $ix =3D 0; $ix < $len; $ix++) {
> -        if (substr($prototype, $ix, 1) eq ',') {
> -            $count++;
> -            if ($count % 2 =3D=3D 1) {
> -                substr($prototype, $ix, 1) =3D ' ';
> -            }
> -        }
> -    }
> -}
> -
> -sub process_proto_function($$) {
> -    my $x =3D shift;
> -    my $file =3D shift;
> -
> -    $x =3D~ s@\/\/.*$@@gos; # strip C99-style comments to end of line
> -
> -    if ($x =3D~ /^#/ && $x !~ /^#\s*define/) {
> -        # do nothing
> -    } elsif ($x =3D~ /([^\{]*)/) {
> -        $prototype .=3D $1;
> -    }
> -
> -    if (($x =3D~ /\{/) || ($x =3D~ /\#\s*define/) || ($x =3D~ /;/)) {
> -        $prototype =3D~ s@/\*.*?\*/@@gos;        # strip comments.
> -        $prototype =3D~ s@[\r\n]+@ @gos; # strip newlines/cr's.
> -        $prototype =3D~ s@^\s+@@gos; # strip leading spaces
> -
> -        # Handle prototypes for function pointers like:
> -        # int (*pcs_config)(struct foo)
> -        $prototype =3D~ s@^(\S+\s+)\(\s*\*(\S+)\)@$1$2@gos;
> -
> -        if ($prototype =3D~ /SYSCALL_DEFINE/) {
> -            syscall_munge();
> -        }
> -        if ($prototype =3D~ /TRACE_EVENT/ || $prototype =3D~ /DEFINE_EVE=
NT/ ||
> -            $prototype =3D~ /DEFINE_SINGLE_EVENT/)
> -        {
> -            tracepoint_munge($file);
> -        }
> -        dump_function($prototype, $file);
> -        reset_state();
> -    }
> -}
> -
> -sub process_proto_type($$) {
> -    my $x =3D shift;
> -    my $file =3D shift;
> -
> -    $x =3D~ s@[\r\n]+@ @gos; # strip newlines/cr's.
> -    $x =3D~ s@^\s+@@gos; # strip leading spaces
> -    $x =3D~ s@\s+$@@gos; # strip trailing spaces
> -    $x =3D~ s@\/\/.*$@@gos; # strip C99-style comments to end of line
> -
> -    if ($x =3D~ /^#/) {
> -        # To distinguish preprocessor directive from regular declaration=
 later.
> -        $x .=3D ";";
> -    }
> -
> -    while (1) {
> -        if ( $x =3D~ /([^\{\};]*)([\{\};])(.*)/ ) {
> -            if( length $prototype ) {
> -                $prototype .=3D " "
> -            }
> -            $prototype .=3D $1 . $2;
> -            ($2 eq '{') && $brcount++;
> -            ($2 eq '}') && $brcount--;
> -            if (($2 eq ';') && ($brcount =3D=3D 0)) {
> -                dump_declaration($prototype, $file);
> -                reset_state();
> -                last;
> -            }
> -            $x =3D $3;
> -        } else {
> -            $prototype .=3D $x;
> -            last;
> -        }
> -    }
> -}
> -
> -
> -sub map_filename($) {
> -    my $file;
> -    my ($orig_file) =3D @_;
> -
> -    if (defined($ENV{'SRCTREE'})) {
> -        $file =3D "$ENV{'SRCTREE'}" . "/" . $orig_file;
> -    } else {
> -        $file =3D $orig_file;
> -    }
> -
> -    return $file;
> -}
> -
> -sub process_export_file($) {
> -    my ($orig_file) =3D @_;
> -    my $file =3D map_filename($orig_file);
> -
> -    if (!open(IN,"<$file")) {
> -        print STDERR "Error: Cannot open file $file\n";
> -        ++$errors;
> -        return;
> -    }
> -
> -    while (<IN>) {
> -        if (/$export_symbol/) {
> -            next if (defined($nosymbol_table{$2}));
> -            $function_table{$2} =3D 1;
> -        }
> -        if (/$export_symbol_ns/) {
> -            next if (defined($nosymbol_table{$2}));
> -            $function_table{$2} =3D 1;
> -        }
> -    }
> -
> -    close(IN);
> -}
> -
> -#
> -# Parsers for the various processing states.
> -#
> -# STATE_NORMAL: looking for the /** to begin everything.
> -#
> -sub process_normal() {
> -    if (/$doc_start/o) {
> -        $state =3D STATE_NAME;        # next line is always the function=
 name
> -        $declaration_start_line =3D $. + 1;
> -    }
> -}
> -
> -#
> -# STATE_NAME: Looking for the "name - description" line
> -#
> -sub process_name($$) {
> -    my $file =3D shift;
> -    my $descr;
> -
> -    if (/$doc_block/o) {
> -        $state =3D STATE_DOCBLOCK;
> -        $contents =3D "";
> -        $new_start_line =3D $.;
> -
> -        if ( $1 eq "" ) {
> -            $section =3D $section_intro;
> -        } else {
> -            $section =3D $1;
> -        }
> -    } elsif (/$doc_decl/o) {
> -        $identifier =3D $1;
> -        my $is_kernel_comment =3D 0;
> -        my $decl_start =3D qr{$doc_com};
> -        # test for pointer declaration type, foo * bar() - desc
> -        my $fn_type =3D qr{\w+\s*\*\s*};
> -        my $parenthesis =3D qr{\(\w*\)};
> -        my $decl_end =3D qr{[-:].*};
> -        if (/^$decl_start([\w\s]+?)$parenthesis?\s*$decl_end?$/) {
> -            $identifier =3D $1;
> -        }
> -        if ($identifier =3D~ m/^(struct|union|enum|typedef)\b\s*(\S*)/) {
> -            $decl_type =3D $1;
> -            $identifier =3D $2;
> -            $is_kernel_comment =3D 1;
> -        }
> -        # Look for foo() or static void foo() - description; or misspelt
> -        # identifier
> -        elsif (/^$decl_start$fn_type?(\w+)\s*$parenthesis?\s*$decl_end?$=
/ ||
> -            /^$decl_start$fn_type?(\w+[^-:]*)$parenthesis?\s*$decl_end$/=
) {
> -            $identifier =3D $1;
> -            $decl_type =3D 'function';
> -            $identifier =3D~ s/^define\s+//;
> -            $is_kernel_comment =3D 1;
> -        }
> -        $identifier =3D~ s/\s+$//;
> -
> -        $state =3D STATE_BODY;
> -        # if there's no @param blocks need to set up default section
> -        # here
> -        $contents =3D "";
> -        $section =3D $section_default;
> -        $new_start_line =3D $. + 1;
> -        if (/[-:](.*)/) {
> -            # strip leading/trailing/multiple spaces
> -            $descr=3D $1;
> -            $descr =3D~ s/^\s*//;
> -            $descr =3D~ s/\s*$//;
> -            $descr =3D~ s/\s+/ /g;
> -            $declaration_purpose =3D $descr;
> -            $state =3D STATE_BODY_MAYBE;
> -        } else {
> -            $declaration_purpose =3D "";
> -        }
> -
> -        if (!$is_kernel_comment) {
> -            emit_warning("${file}:$.", "This comment starts with '/**', =
but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rs=
t\n$_");
> -            $state =3D STATE_NORMAL;
> -        }
> -
> -        if (($declaration_purpose eq "") && $Wshort_desc) {
> -            emit_warning("${file}:$.", "missing initial short descriptio=
n on line:\n$_");
> -        }
> -
> -        if ($identifier eq "" && $decl_type ne "enum") {
> -            emit_warning("${file}:$.", "wrong kernel-doc identifier on l=
ine:\n$_");
> -            $state =3D STATE_NORMAL;
> -        }
> -
> -        if ($verbose) {
> -            print STDERR "${file}:$.: info: Scanning doc for $decl_type =
$identifier\n";
> -        }
> -    } else {
> -        emit_warning("${file}:$.", "Cannot understand $_ on line $. - I =
thought it was a doc line\n");
> -        $state =3D STATE_NORMAL;
> -    }
> -}
> -
> -
> -#
> -# STATE_BODY and STATE_BODY_MAYBE: the bulk of a kerneldoc comment.
> -#
> -sub process_body($$) {
> -    my $file =3D shift;
> -
> -    if ($state =3D=3D STATE_BODY_WITH_BLANK_LINE && /^\s*\*\s?\S/) {
> -        dump_section($file, $section, $contents);
> -        $section =3D $section_default;
> -        $new_start_line =3D $.;
> -        $contents =3D "";
> -    }
> -
> -    if (/$doc_sect/i) { # case insensitive for supported section names
> -        $newsection =3D $1;
> -        $newcontents =3D $2;
> -
> -        # map the supported section names to the canonical names
> -        if ($newsection =3D~ m/^description$/i) {
> -            $newsection =3D $section_default;
> -        } elsif ($newsection =3D~ m/^context$/i) {
> -            $newsection =3D $section_context;
> -        } elsif ($newsection =3D~ m/^returns?$/i) {
> -            $newsection =3D $section_return;
> -        } elsif ($newsection =3D~ m/^\@return$/) {
> -            # special: @return is a section, not a param description
> -            $newsection =3D $section_return;
> -        }
> -
> -        if (($contents ne "") && ($contents ne "\n")) {
> -            dump_section($file, $section, $contents);
> -            $section =3D $section_default;
> -        }
> -
> -        $state =3D STATE_BODY;
> -        $contents =3D $newcontents;
> -        $new_start_line =3D $.;
> -        while (substr($contents, 0, 1) eq " ") {
> -            $contents =3D substr($contents, 1);
> -        }
> -        if ($contents ne "") {
> -            $contents .=3D "\n";
> -        }
> -        $section =3D $newsection;
> -        $leading_space =3D undef;
> -    } elsif (/$doc_end/) {
> -        if (($contents ne "") && ($contents ne "\n")) {
> -            dump_section($file, $section, $contents);
> -            $section =3D $section_default;
> -            $contents =3D "";
> -        }
> -        # look for doc_com + <text> + doc_end:
> -        if ($_ =3D~ m'\s*\*\s*[a-zA-Z_0-9:\.]+\*/') {
> -            emit_warning("${file}:$.", "suspicious ending line: $_");
> -        }
> -
> -        $prototype =3D "";
> -        $state =3D STATE_PROTO;
> -        $brcount =3D 0;
> -        $new_start_line =3D $. + 1;
> -    } elsif (/$doc_content/) {
> -        if ($1 eq "") {
> -            if ($section eq $section_context) {
> -                dump_section($file, $section, $contents);
> -                $section =3D $section_default;
> -                $contents =3D "";
> -                $new_start_line =3D $.;
> -                $state =3D STATE_BODY;
> -            } else {
> -                if ($section ne $section_default) {
> -                    $state =3D STATE_BODY_WITH_BLANK_LINE;
> -                } else {
> -                    $state =3D STATE_BODY;
> -                }
> -                $contents .=3D "\n";
> -            }
> -        } elsif ($state =3D=3D STATE_BODY_MAYBE) {
> -            # Continued declaration purpose
> -            chomp($declaration_purpose);
> -            $declaration_purpose .=3D " " . $1;
> -            $declaration_purpose =3D~ s/\s+/ /g;
> -        } else {
> -            my $cont =3D $1;
> -            if ($section =3D~ m/^@/ || $section eq $section_context) {
> -                if (!defined $leading_space) {
> -                    if ($cont =3D~ m/^(\s+)/) {
> -                        $leading_space =3D $1;
> -                    } else {
> -                        $leading_space =3D "";
> -                    }
> -                }
> -                $cont =3D~ s/^$leading_space//;
> -            }
> -            $contents .=3D $cont . "\n";
> -        }
> -    } else {
> -        # i dont know - bad line?  ignore.
> -        emit_warning("${file}:$.", "bad line: $_");
> -    }
> -}
> -
> -
> -#
> -# STATE_PROTO: reading a function/whatever prototype.
> -#
> -sub process_proto($$) {
> -    my $file =3D shift;
> -
> -    if (/$doc_inline_oneline/) {
> -        $section =3D $1;
> -        $contents =3D $2;
> -        if ($contents ne "") {
> -            $contents .=3D "\n";
> -            dump_section($file, $section, $contents);
> -            $section =3D $section_default;
> -            $contents =3D "";
> -        }
> -    } elsif (/$doc_inline_start/) {
> -        $state =3D STATE_INLINE;
> -        $inline_doc_state =3D STATE_INLINE_NAME;
> -    } elsif ($decl_type eq 'function') {
> -        process_proto_function($_, $file);
> -    } else {
> -        process_proto_type($_, $file);
> -    }
> -}
> -
> -#
> -# STATE_DOCBLOCK: within a DOC: block.
> -#
> -sub process_docblock($$) {
> -    my $file =3D shift;
> -
> -    if (/$doc_end/) {
> -        dump_doc_section($file, $section, $contents);
> -        $section =3D $section_default;
> -        $contents =3D "";
> -        $function =3D "";
> -        %parameterdescs =3D ();
> -        %parametertypes =3D ();
> -        @parameterlist =3D ();
> -        %sections =3D ();
> -        @sectionlist =3D ();
> -        $prototype =3D "";
> -        $state =3D STATE_NORMAL;
> -    } elsif (/$doc_content/) {
> -        if ( $1 eq "" )        {
> -            $contents .=3D $blankline;
> -        } else {
> -            $contents .=3D $1 . "\n";
> -        }
> -    }
> -}
> -
> -#
> -# STATE_INLINE: docbook comments within a prototype.
> -#
> -sub process_inline($$) {
> -    my $file =3D shift;
> -
> -    # First line (state 1) needs to be a @parameter
> -    if ($inline_doc_state =3D=3D STATE_INLINE_NAME && /$doc_inline_sect/=
o) {
> -        $section =3D $1;
> -        $contents =3D $2;
> -        $new_start_line =3D $.;
> -        if ($contents ne "") {
> -            while (substr($contents, 0, 1) eq " ") {
> -                $contents =3D substr($contents, 1);
> -            }
> -            $contents .=3D "\n";
> -        }
> -        $inline_doc_state =3D STATE_INLINE_TEXT;
> -        # Documentation block end */
> -    } elsif (/$doc_inline_end/) {
> -        if (($contents ne "") && ($contents ne "\n")) {
> -            dump_section($file, $section, $contents);
> -            $section =3D $section_default;
> -            $contents =3D "";
> -        }
> -        $state =3D STATE_PROTO;
> -        $inline_doc_state =3D STATE_INLINE_NA;
> -        # Regular text
> -    } elsif (/$doc_content/) {
> -        if ($inline_doc_state =3D=3D STATE_INLINE_TEXT) {
> -            $contents .=3D $1 . "\n";
> -            # nuke leading blank lines
> -            if ($contents =3D~ /^\s*$/) {
> -                $contents =3D "";
> -            }
> -        } elsif ($inline_doc_state =3D=3D STATE_INLINE_NAME) {
> -            $inline_doc_state =3D STATE_INLINE_ERROR;
> -            emit_warning("${file}:$.", "Incorrect use of kernel-doc form=
at: $_");
> -        }
> -    }
> -}
> -
> -
> -sub process_file($) {
> -    my $file;
> -    my ($orig_file) =3D @_;
> -
> -    $file =3D map_filename($orig_file);
> -
> -    if (!open(IN_FILE,"<$file")) {
> -        print STDERR "Error: Cannot open file $file\n";
> -        ++$errors;
> -        return;
> -    }
> -
> -    $. =3D 1;
> -
> -    $section_counter =3D 0;
> -    while (<IN_FILE>) {
> -        while (!/^ \*/ && s/\\\s*$//) {
> -            $_ .=3D <IN_FILE>;
> -        }
> -        # Replace tabs by spaces
> -        while ($_ =3D~ s/\t+/' ' x (length($&) * 8 - length($`) % 8)/e) =
{};
> -        # Hand this line to the appropriate state handler
> -        if ($state =3D=3D STATE_NORMAL) {
> -            process_normal();
> -        } elsif ($state =3D=3D STATE_NAME) {
> -            process_name($file, $_);
> -        } elsif ($state =3D=3D STATE_BODY || $state =3D=3D STATE_BODY_MA=
YBE ||
> -                 $state =3D=3D STATE_BODY_WITH_BLANK_LINE) {
> -            process_body($file, $_);
> -        } elsif ($state =3D=3D STATE_INLINE) { # scanning for inline par=
ameters
> -            process_inline($file, $_);
> -        } elsif ($state =3D=3D STATE_PROTO) {
> -            process_proto($file, $_);
> -        } elsif ($state =3D=3D STATE_DOCBLOCK) {
> -            process_docblock($file, $_);
> -        }
> -    }
> -
> -    # Make sure we got something interesting.
> -    if (!$section_counter && $output_mode ne "none") {
> -        if ($output_selection =3D=3D OUTPUT_INCLUDE) {
> -            emit_warning("${file}:1", "'$_' not found\n")
> -                for keys %function_table;
> -        } else {
> -            emit_warning("${file}:1", "no structured comments found\n");
> -        }
> -    }
> -    close IN_FILE;
> -}
> -
> -$kernelversion =3D get_kernel_version();
> -
> -# generate a sequence of code that will splice in highlighting informati=
on
> -# using the s// operator.
> -for (my $k =3D 0; $k < @highlights; $k++) {
> -    my $pattern =3D $highlights[$k][0];
> -    my $result =3D $highlights[$k][1];
> -#   print STDERR "scanning pattern:$pattern, highlight:($result)\n";
> -    $dohighlight .=3D  "\$contents =3D~ s:$pattern:$result:gs;\n";
> -}
> -
> -if ($output_selection =3D=3D OUTPUT_EXPORTED ||
> -    $output_selection =3D=3D OUTPUT_INTERNAL) {
> -
> -    push(@export_file_list, @ARGV);
> -
> -    foreach (@export_file_list) {
> -        chomp;
> -        process_export_file($_);
> -    }
> -}
> -
> -foreach (@ARGV) {
> -    chomp;
> -    process_file($_);
> -}
> -if ($verbose && $errors) {
> -    print STDERR "$errors errors\n";
> -}
> -if ($verbose && $warnings) {
> -    print STDERR "$warnings warnings\n";
> -}
> -
> -if ($Werror && $warnings) {
> -    print STDERR "$warnings warnings as Errors\n";
> -    exit($warnings);
> -} else {
> -    exit($output_mode eq "none" ? 0 : $errors)
> -}
> -
> -__END__
> -
> -=3Dhead1 OPTIONS
> -
> -=3Dhead2 Output format selection (mutually exclusive):
> -
> -=3Dover 8
> -
> -=3Ditem -man
> -
> -Output troff manual page format.
> -
> -=3Ditem -rst
> -
> -Output reStructuredText format. This is the default.
> -
> -=3Ditem -none
> -
> -Do not output documentation, only warnings.
> -
> -=3Dback
> -
> -=3Dhead2 Output format modifiers
> -
> -=3Dhead3 reStructuredText only
> -
> -=3Dhead2 Output selection (mutually exclusive):
> -
> -=3Dover 8
> -
> -=3Ditem -export
> -
> -Only output documentation for the symbols that have been exported using
> -EXPORT_SYMBOL() and related macros in any input FILE or -export-file FIL=
E.
> -
> -=3Ditem -internal
> -
> -Only output documentation for the symbols that have NOT been exported us=
ing
> -EXPORT_SYMBOL() and related macros in any input FILE or -export-file FIL=
E.
> -
> -=3Ditem -function NAME
> -
> -Only output documentation for the given function or DOC: section title.
> -All other functions and DOC: sections are ignored.
> -
> -May be specified multiple times.
> -
> -=3Ditem -nosymbol NAME
> -
> -Exclude the specified symbol from the output documentation.
> -
> -May be specified multiple times.
> -
> -=3Dback
> -
> -=3Dhead2 Output selection modifiers:
> -
> -=3Dover 8
> -
> -=3Ditem -no-doc-sections
> -
> -Do not output DOC: sections.
> -
> -=3Ditem -export-file FILE
> -
> -Specify an additional FILE in which to look for EXPORT_SYMBOL informatio=
n.
> -
> -To be used with -export or -internal.
> -
> -May be specified multiple times.
> -
> -=3Dback
> -
> -=3Dhead3 reStructuredText only
> -
> -=3Dover 8
> -
> -=3Ditem -enable-lineno
> -
> -Enable output of .. LINENO lines.
> -
> -=3Dback
> -
> -=3Dhead2 Other parameters:
> -
> -=3Dover 8
> -
> -=3Ditem -h, -help
> -
> -Print this help.
> -
> -=3Ditem -v
> -
> -Verbose output, more warnings and other information.
> -
> -=3Ditem -Werror
> -
> -Treat warnings as errors.
> -
> -=3Dback
> -
> -=3Dcut



Thanks,
Mauro


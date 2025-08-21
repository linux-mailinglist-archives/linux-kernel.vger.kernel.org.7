Return-Path: <linux-kernel+bounces-780044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E5AB2FCD1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A890F6403A6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EED2EDD5C;
	Thu, 21 Aug 2025 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYKypHZ/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0AE28AB0B;
	Thu, 21 Aug 2025 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786100; cv=none; b=RR/CP2Eup3K6XuXBQa0T4hI3JHLaWsK9A9U+teEGhYGW60J5ZKfsZFppLFTCQQMnWpA6PDYxrOFTILlLWmS9eGsqFf49K50d8MDiI7n6nkmEOmZ6rORfJa3vhm1NRHoxnF51wuSVtkzYzEps0Qn1PSOW0BkycRKFei2tQpxZDN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786100; c=relaxed/simple;
	bh=uYEK1a2ZG5UzKHVraa8W5O9cCQbPaE3FbRWgQy8mxrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VM6Bgr1A/iQu7NqVe/bNMmW06GQmJ+GGLa+j6DIhtTzh7OD7E53r9XLf6hqVP+9O3wUIbJYnlIGaDpNc/SG2a86mSU0AacSoJKrOzaUvfGwmFZPZaZCOoE/75lN/2FkOeZVaeKshrjYeesngUR36b2+wqzJtlsiHIFrXzXK5/i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYKypHZ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5FFC16AAE;
	Thu, 21 Aug 2025 14:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755786100;
	bh=uYEK1a2ZG5UzKHVraa8W5O9cCQbPaE3FbRWgQy8mxrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BYKypHZ/p75IMUVHV2u1aeOlh/lFPeeUMsCfZP8rey7YwoACZ0n8h3ZQh1cZxNNIt
	 u9+y8UykM5RNnBnG9A6UqEVNuf6umgGmEeblRhJQ0ciUFv8IVJxEHVGdqHSJ3HkD6/
	 RlfgexA0Fq47+1g/jP2bBx4/pZ3GN2tokd9NdiY/gc91beWj5dO0OYR28yEYbX389n
	 F0EfglEi0Pb/7mn0Ffyq1HAkXkWuPs8eM4YG9fbXgd09yHwSUXseVGYta1CZUM81li
	 nXetHbQCfzUvgEw+tt6J6+ZKmBw15zHKVbLUyRFh7iP8CBBhXBaMiPytWizJqKRxmo
	 FdCLGFrrfFbtQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1up6Ab-0000000BT9Y-2XwE;
	Thu, 21 Aug 2025 16:21:37 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 24/24] docs: sphinx: drop parse-headers.pl
Date: Thu, 21 Aug 2025 16:21:30 +0200
Message-ID: <cd825f90abec4828725e8143af010bd0d802c3ca.1755784930.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755784929.git.mchehab+huawei@kernel.org>
References: <cover.1755784929.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Now that we have a replacement in place, drop the old version.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/parse-headers.pl | 419 --------------------------
 1 file changed, 419 deletions(-)
 delete mode 100755 Documentation/sphinx/parse-headers.pl

diff --git a/Documentation/sphinx/parse-headers.pl b/Documentation/sphinx/parse-headers.pl
deleted file mode 100755
index 560685926cdb..000000000000
--- a/Documentation/sphinx/parse-headers.pl
+++ /dev/null
@@ -1,419 +0,0 @@
-#!/usr/bin/env perl
-# SPDX-License-Identifier: GPL-2.0
-# Copyright (c) 2016 by Mauro Carvalho Chehab <mchehab@kernel.org>.
-
-use strict;
-use Text::Tabs;
-use Getopt::Long;
-use Pod::Usage;
-
-my $debug;
-my $help;
-my $man;
-
-GetOptions(
-	"debug" => \$debug,
-	'usage|?' => \$help,
-	'help' => \$man
-) or pod2usage(2);
-
-pod2usage(1) if $help;
-pod2usage(-exitstatus => 0, -verbose => 2) if $man;
-pod2usage(2) if (scalar @ARGV < 2 || scalar @ARGV > 3);
-
-my ($file_in, $file_out, $file_exceptions) = @ARGV;
-
-my $data;
-my %ioctls;
-my %defines;
-my %typedefs;
-my %enums;
-my %enum_symbols;
-my %structs;
-
-#
-# read the file and get identifiers
-#
-
-my $is_enum = 0;
-my $is_comment = 0;
-open IN, $file_in or die "Can't open $file_in";
-while (<IN>) {
-	$data .= $_;
-
-	my $ln = $_;
-	if (!$is_comment) {
-		$ln =~ s,/\*.*(\*/),,g;
-
-		$is_comment = 1 if ($ln =~ s,/\*.*,,);
-	} else {
-		if ($ln =~ s,^(.*\*/),,) {
-			$is_comment = 0;
-		} else {
-			next;
-		}
-	}
-
-	if ($is_enum && $ln =~ m/^\s*([_\w][\w\d_]+)\s*[\,=]?/) {
-		my $s = $1;
-		my $n = $1;
-		$n =~ tr/A-Z/a-z/;
-		$n =~ tr/_/-/;
-
-		$enum_symbols{$s} =  "\\ :ref:`$s <$n>`\\ ";
-
-		$is_enum = 0 if ($is_enum && m/\}/);
-		next;
-	}
-	$is_enum = 0 if ($is_enum && m/\}/);
-
-	if ($ln =~ m/^\s*#\s*define\s+([_\w][\w\d_]+)\s+_IO/) {
-		my $s = $1;
-		my $n = $1;
-		$n =~ tr/A-Z/a-z/;
-
-		$ioctls{$s} = "\\ :ref:`$s <$n>`\\ ";
-		next;
-	}
-
-	if ($ln =~ m/^\s*#\s*define\s+([_\w][\w\d_]+)\s+/) {
-		my $s = $1;
-		my $n = $1;
-		$n =~ tr/A-Z/a-z/;
-		$n =~ tr/_/-/;
-
-		$defines{$s} = "\\ :ref:`$s <$n>`\\ ";
-		next;
-	}
-
-	if ($ln =~ m/^\s*typedef\s+([_\w][\w\d_]+)\s+(.*)\s+([_\w][\w\d_]+);/) {
-		my $s = $2;
-		my $n = $3;
-
-		$typedefs{$n} = "\\ :c:type:`$n <$s>`\\ ";
-		next;
-	}
-	if ($ln =~ m/^\s*enum\s+([_\w][\w\d_]+)\s+\{/
-	    || $ln =~ m/^\s*enum\s+([_\w][\w\d_]+)$/
-	    || $ln =~ m/^\s*typedef\s*enum\s+([_\w][\w\d_]+)\s+\{/
-	    || $ln =~ m/^\s*typedef\s*enum\s+([_\w][\w\d_]+)$/) {
-		my $s = $1;
-
-		$enums{$s} =  "enum :c:type:`$s`\\ ";
-
-		$is_enum = $1;
-		next;
-	}
-	if ($ln =~ m/^\s*struct\s+([_\w][\w\d_]+)\s+\{/
-	    || $ln =~ m/^\s*struct\s+([[_\w][\w\d_]+)$/
-	    || $ln =~ m/^\s*typedef\s*struct\s+([_\w][\w\d_]+)\s+\{/
-	    || $ln =~ m/^\s*typedef\s*struct\s+([[_\w][\w\d_]+)$/
-	    ) {
-		my $s = $1;
-
-		$structs{$s} = "struct $s\\ ";
-		next;
-	}
-}
-close IN;
-
-#
-# Handle multi-line typedefs
-#
-
-my @matches = ($data =~ m/typedef\s+struct\s+\S+?\s*\{[^\}]+\}\s*(\S+)\s*\;/g,
-	       $data =~ m/typedef\s+enum\s+\S+?\s*\{[^\}]+\}\s*(\S+)\s*\;/g,);
-foreach my $m (@matches) {
-	my $s = $m;
-
-	$typedefs{$s} = "\\ :c:type:`$s`\\ ";
-	next;
-}
-
-#
-# Handle exceptions, if any
-#
-
-my %def_reftype = (
-	"ioctl"   => ":ref",
-	"define"  => ":ref",
-	"symbol"  => ":ref",
-	"typedef" => ":c:type",
-	"enum"    => ":c:type",
-	"struct"  => ":c:type",
-);
-
-if ($file_exceptions) {
-	open IN, $file_exceptions or die "Can't read $file_exceptions";
-	while (<IN>) {
-		next if (m/^\s*$/ || m/^\s*#/);
-
-		# Parsers to ignore a symbol
-
-		if (m/^ignore\s+ioctl\s+(\S+)/) {
-			delete $ioctls{$1} if (exists($ioctls{$1}));
-			next;
-		}
-		if (m/^ignore\s+define\s+(\S+)/) {
-			delete $defines{$1} if (exists($defines{$1}));
-			next;
-		}
-		if (m/^ignore\s+typedef\s+(\S+)/) {
-			delete $typedefs{$1} if (exists($typedefs{$1}));
-			next;
-		}
-		if (m/^ignore\s+enum\s+(\S+)/) {
-			delete $enums{$1} if (exists($enums{$1}));
-			next;
-		}
-		if (m/^ignore\s+struct\s+(\S+)/) {
-			delete $structs{$1} if (exists($structs{$1}));
-			next;
-		}
-		if (m/^ignore\s+symbol\s+(\S+)/) {
-			delete $enum_symbols{$1} if (exists($enum_symbols{$1}));
-			next;
-		}
-
-		# Parsers to replace a symbol
-		my ($type, $old, $new, $reftype);
-
-		if (m/^replace\s+(\S+)\s+(\S+)\s+(\S+)/) {
-			$type = $1;
-			$old = $2;
-			$new = $3;
-		} else {
-			die "Can't parse $file_exceptions: $_";
-		}
-
-		if ($new =~ m/^\:c\:(data|func|macro|type)\:\`(.+)\`/) {
-			$reftype = ":c:$1";
-			$new = $2;
-		} elsif ($new =~ m/\:ref\:\`(.+)\`/) {
-			$reftype = ":ref";
-			$new = $1;
-		} else {
-			$reftype = $def_reftype{$type};
-		}
-		if (!$reftype) {
-		    print STDERR "Warning: can't find ref type for $type";
-		}
-		$new = "$reftype:`$old <$new>`";
-
-		if ($type eq "ioctl") {
-			$ioctls{$old} = $new if (exists($ioctls{$old}));
-			next;
-		}
-		if ($type eq "define") {
-			$defines{$old} = $new if (exists($defines{$old}));
-			next;
-		}
-		if ($type eq "symbol") {
-			$enum_symbols{$old} = $new if (exists($enum_symbols{$old}));
-			next;
-		}
-		if ($type eq "typedef") {
-			$typedefs{$old} = $new if (exists($typedefs{$old}));
-			next;
-		}
-		if ($type eq "enum") {
-			$enums{$old} = $new if (exists($enums{$old}));
-			next;
-		}
-		if ($type eq "struct") {
-			$structs{$old} = $new if (exists($structs{$old}));
-			next;
-		}
-
-		die "Can't parse $file_exceptions: $_";
-	}
-}
-
-if ($debug) {
-	my @all_hashes = (
-		{ioctl      => \%ioctls},
-		{typedef    => \%typedefs},
-		{enum       => \%enums},
-		{struct     => \%structs},
-		{define     => \%defines},
-		{symbol     => \%enum_symbols}
-	);
-
-	foreach my $hash (@all_hashes) {
-		while (my ($name, $hash_ref) = each %$hash) {
-			next unless %$hash_ref;  # Skip empty hashes
-
-			print "$name:\n";
-			for my $key (sort keys %$hash_ref) {
-				print "  $key -> $hash_ref->{$key}\n";
-			}
-			print "\n";
-		}
-	}
-}
-
-#
-# Align block
-#
-$data = expand($data);
-$data = "    " . $data;
-$data =~ s/\n/\n    /g;
-$data =~ s/\n\s+$/\n/g;
-$data =~ s/\n\s+\n/\n\n/g;
-
-#
-# Add escape codes for special characters
-#
-$data =~ s,([\_\`\*\<\>\&\\\\:\/\|\%\$\#\{\}\~\^]),\\$1,g;
-
-$data =~ s,DEPRECATED,**DEPRECATED**,g;
-
-#
-# Add references
-#
-
-my $start_delim = "[ \n\t\(\=\*\@]";
-my $end_delim = "(\\s|,|\\\\=|\\\\:|\\;|\\\)|\\}|\\{)";
-
-foreach my $r (keys %ioctls) {
-	my $s = $ioctls{$r};
-
-	$r =~ s,([\_\`\*\<\>\&\\\\:\/]),\\\\$1,g;
-
-	print "$r -> $s\n" if ($debug);
-
-	$data =~ s/($start_delim)($r)$end_delim/$1$s$3/g;
-}
-
-foreach my $r (keys %defines) {
-	my $s = $defines{$r};
-
-	$r =~ s,([\_\`\*\<\>\&\\\\:\/]),\\\\$1,g;
-
-	print "$r -> $s\n" if ($debug);
-
-	$data =~ s/($start_delim)($r)$end_delim/$1$s$3/g;
-}
-
-foreach my $r (keys %enum_symbols) {
-	my $s = $enum_symbols{$r};
-
-	$r =~ s,([\_\`\*\<\>\&\\\\:\/]),\\\\$1,g;
-
-	print "$r -> $s\n" if ($debug);
-
-	$data =~ s/($start_delim)($r)$end_delim/$1$s$3/g;
-}
-
-foreach my $r (keys %enums) {
-	my $s = $enums{$r};
-
-	$r =~ s,([\_\`\*\<\>\&\\\\:\/]),\\\\$1,g;
-
-	print "$r -> $s\n" if ($debug);
-
-	$data =~ s/enum\s+($r)$end_delim/$s$2/g;
-}
-
-foreach my $r (keys %structs) {
-	my $s = $structs{$r};
-
-	$r =~ s,([\_\`\*\<\>\&\\\\:\/]),\\\\$1,g;
-
-	print "$r -> $s\n" if ($debug);
-
-	$data =~ s/struct\s+($r)$end_delim/$s$2/g;
-}
-
-foreach my $r (keys %typedefs) {
-	my $s = $typedefs{$r};
-
-	$r =~ s,([\_\`\*\<\>\&\\\\:\/]),\\\\$1,g;
-
-	print "$r -> $s\n" if ($debug);
-	$data =~ s/($start_delim)($r)$end_delim/$1$s$3/g;
-}
-
-$data =~ s/\\ ([\n\s])/\1/g;
-
-#
-# Generate output file
-#
-
-my $title = $file_in;
-$title =~ s,.*/,,;
-
-open OUT, "> $file_out" or die "Can't open $file_out";
-print OUT ".. -*- coding: utf-8; mode: rst -*-\n\n";
-print OUT "$title\n";
-print OUT "=" x length($title);
-print OUT "\n\n.. parsed-literal::\n\n";
-print OUT $data;
-close OUT;
-
-__END__
-
-=head1 NAME
-
-parse_headers.pl - parse a C file, in order to identify functions, structs,
-enums and defines and create cross-references to a Sphinx book.
-
-=head1 SYNOPSIS
-
-B<parse_headers.pl> [<options>] <C_FILE> <OUT_FILE> [<EXCEPTIONS_FILE>]
-
-Where <options> can be: --debug, --help or --usage.
-
-=head1 OPTIONS
-
-=over 8
-
-=item B<--debug>
-
-Put the script in verbose mode, useful for debugging.
-
-=item B<--usage>
-
-Prints a brief help message and exits.
-
-=item B<--help>
-
-Prints a more detailed help message and exits.
-
-=back
-
-=head1 DESCRIPTION
-
-Convert a C header or source file (C_FILE), into a ReStructured Text
-included via ..parsed-literal block with cross-references for the
-documentation files that describe the API. It accepts an optional
-EXCEPTIONS_FILE with describes what elements will be either ignored or
-be pointed to a non-default reference.
-
-The output is written at the (OUT_FILE).
-
-It is capable of identifying defines, functions, structs, typedefs,
-enums and enum symbols and create cross-references for all of them.
-It is also capable of distinguish #define used for specifying a Linux
-ioctl.
-
-The EXCEPTIONS_FILE contain two rules to allow ignoring a symbol or
-to replace the default references by a custom one.
-
-Please read Documentation/doc-guide/parse-headers.rst at the Kernel's
-tree for more details.
-
-=head1 BUGS
-
-Report bugs to Mauro Carvalho Chehab <mchehab@kernel.org>
-
-=head1 COPYRIGHT
-
-Copyright (c) 2016 by Mauro Carvalho Chehab <mchehab@kernel.org>.
-
-License GPLv2: GNU GPL version 2 <https://gnu.org/licenses/gpl.html>.
-
-This is free software: you are free to change and redistribute it.
-There is NO WARRANTY, to the extent permitted by law.
-
-=cut
-- 
2.50.1



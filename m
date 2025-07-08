Return-Path: <linux-kernel+bounces-721290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 900FEAFC72E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3AB3B8955
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D42725A320;
	Tue,  8 Jul 2025 09:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="B4S6XLk2"
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E2222A7FC
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 09:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751967426; cv=none; b=s6fZ43krq4yR54PnWUjMN3XqmclPhgW9QEUP+VVRG1Y+/6Ws0EQB3iQYt+O9Oa5dePtbB1pgtCwVEpFaWW8MOW6gqLGzO3L4jQOXBaU8h9i9XFDrH71XZ1/IJDFfn6wwdSVBaYOMrj164kEot130tbBoR1qyRK6q3ryj50wCPlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751967426; c=relaxed/simple;
	bh=Sp3m4dJ6Sq8EmMvQ9cxzNKFQFMaqfGHocfCcG7CgQA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fp9JBZhyMf3dRc7lhxv5gre+UZ5UXNqYTBkvWUo0byO/kpcGZB9WZCckBeFBZs5CP8L4Fm68P1qgex6mGLw58mnra9kKqk1aB8R6P/lUEYGDrZQ5CFgUfjwaEPiXTJI6qxbOulXWNESnO0wIbX6ScGTvwt5vkAtRes9LU/Jz+iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=B4S6XLk2; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1751967388;
	bh=BK22JqGvIVhaZ6AE7O0dYtJVDVL/TvyEbIHbe21FTrs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=B4S6XLk29NXSoFHVP85z5fV4Udk2T6h+75AWlFKUT16pcJ0EsxSDyCEjUJ1QlK09E
	 r6Y62brXlXpO+MVcI9AH/IoIn188abAHBZCwbDm0vcwCIH4K0L5l4Nt3oFuhJQfVZR
	 O9BG3TNCAmnycQeNp+vTgqMAyr+1am5JOLMZrz+c=
X-QQ-mid: zesmtpip4t1751967343td8940b67
X-QQ-Originating-IP: 3nGj+yU5VxqykL1EA0WV60BWCOuINA14BKu6Pf7ezsE=
Received: from avenger-e500 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 08 Jul 2025 17:35:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5465229485389365988
EX-QQ-RecipientCnt: 9
From: WangYuli <wangyuli@uniontech.com>
To: apw@canonical.com,
	joe@perches.com,
	dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com
Cc: linux-kernel@vger.kernel.org,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	guanwentao@uniontech.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH] checkpatch: Add full-width character detection
Date: Tue,  8 Jul 2025 17:34:58 +0800
Message-ID: <2804E0A754F9E415+20250708093458.1230294-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OMnP0zidhno0r3Q2kZABQRuTwgFKrkcNu67Kbw8eSU1vHLZrWbmBajKd
	zUTdiNjSmGq23p9WNJaTJWJRpwE0Xm/iGyNxprbz4nXS/HmBpPKmGgEz8EZBtHEDujFB7Ib
	eANobVLNg0v+RM/sVZmNboT8oPyh4wAcWVPnRsdWx4URB8Qv1PrZlO/LmF2AZZuMBfhNcVO
	25F9M2s74puvU8E5waWjyLiHf1AEKDTbP4c0B4A7NWvCupITMwaWxHrvppBo0ukwvGhx4TC
	kmh4EUEjwfgv/0YY5oXFuvIa2uTffMNRXalBQac113R2ZpLf7lVsQa3tPe9aWrV+qcZWEyT
	FQBbfBNBWDEXR8IbxqaPneAkiPbk13Vlw/3t1DgW5WiPKpSUNfEHHy1IZ9IKAi9B9gSgzsn
	hcLYjPkoDKt6o57WFSVw42E2jbpF0rdUjTiGk2MJrhHY6ZGMdxKQ7C3rVhMVt9VpnjWpOxD
	G227dwr++solyjJACqy72SLffZeCXWGX3S0jrblrS8xwCN44+4zxVBL0XSMtHdhX+BYhuuA
	4mOyDOugiWLi6UR/I/G1QlXTHW8EgzNlrFCwn43LzQJik60qctM3NlWejyVS+sxrme8KANU
	LM31wDkWAQoiVVF6jIbuY20zFsL3Ndm3UXXqMc3lS0KJ7mCwL2XPZIZoXPLC9WwFkGeXypb
	3sILonspCqGpEAVRxQQO87N4aPDmXRkG2Dh5QSlhGaAh5RlYb3rvttniUDCbzhF+vEke7nD
	aRqRQ4aAYs7UJHwl9+1EgdI46QY/uZ3oEHcbEfeBnWA3cLF6MOMwsFV2d8cPOSR1coA9/ZZ
	gXb/zls6GXrJZigHBUCVFAZi8ZpzWRMN2j+gz5ebdm7Fsu/ZwD6vQ5nALQ0IRBP+PTXhOgQ
	huky4ZGeCC3En4pEFM/fLyPqedu8bPl+d2nbb38Xh2H7HzDGJbB7RN8GRv3gSXTIiBZfvRs
	BN25OkbMdFytASgG0KuABrD+etCOHvzYJoyNW9tbzJimlHcpQsU2thdNL2cThwK+zXlfayR
	e0HRE1ELCJ2J46HZ/hCVL7wxjG8U3UYP4Ezk8CB9lEs8QHYh9/fI5U2EoMoZLmcrdfAN+9n
	A==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Add comprehensive detection and automatic fixing capability for full-width
(Unicode) characters that are commonly mistaken for ASCII punctuation marks.
This helps catch input method editor artifacts that can cause compilation
errors or formatting issues.

The implementation detects 25 types of full-width characters:
- Basic punctuation: ；，。（）！？：　
- Programming brackets: ［］｛｝＜＞
- Assignment and comparison: ＝
- Arithmetic operators: ＋－＊／＼
- Other programming symbols: ％＃＆｜

Detection covers three areas:
1. Code lines (lines starting with '+') - FULLWIDTH_CHARS
2. Commit messages - FULLWIDTH_CHARS_COMMIT
3. Subject lines - FULLWIDTH_CHARS_SUBJECT

Example usage:
  ./scripts/checkpatch.pl my_patch.patch
  ./scripts/checkpatch.pl --fix my_patch.patch
  ./scripts/checkpatch.pl --fix-inplace my_source.c

Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 scripts/checkpatch.pl | 84 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 664f7b7a622c..bd691dc848a2 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -75,6 +75,41 @@ my $git_command ='export LANGUAGE=en_US.UTF-8; git';
 my $tabsize = 8;
 my ${CONFIG_} = "CONFIG_";
 
+# Full-width character mappings (UTF-8 byte sequences to ASCII)
+my %fullwidth_chars = (
+	# Basic punctuation
+	"\xef\xbc\x9b" => [";", "semicolon", "；"],
+	"\xef\xbc\x8c" => [",", "comma", "，"],
+	"\xe3\x80\x82" => [".", "period", "。"],
+	"\xef\xbc\x88" => ["(", "opening parenthesis", "（"],
+	"\xef\xbc\x89" => [")", "closing parenthesis", "）"],
+	"\xef\xbc\x81" => ["!", "exclamation mark", "！"],
+	"\xef\xbc\x9f" => ["?", "question mark", "？"],
+	"\xef\xbc\x9a" => [":", "colon", "："],
+	"\xe3\x80\x80" => [" ", "space", "　"],
+	# Programming brackets
+	"\xef\xbc\xbb" => ["[", "left square bracket", "［"],
+	"\xef\xbc\xbd" => ["]", "right square bracket", "］"],
+	"\xef\xbd\x9b" => ["{", "left curly bracket", "｛"],
+	"\xef\xbd\x9d" => ["}", "right curly bracket", "｝"],
+	"\xef\xbc\x9c" => ["<", "less-than sign", "＜"],
+	"\xef\xbc\x9e" => [">", "greater-than sign", "＞"],
+	# Assignment and comparison
+	"\xef\xbc\x9d" => ["=", "equals sign", "＝"],
+	# Arithmetic operators
+	"\xef\xbc\x8b" => ["+", "plus sign", "＋"],
+	"\xef\xbc\x8d" => ["-", "minus sign", "－"],
+	"\xef\xbc\x8a" => ["*", "asterisk", "＊"],
+	"\xef\xbc\x8f" => ["/", "solidus", "／"],
+	"\xef\xbc\xbc" => ["\\", "reverse solidus", "＼"],
+	# Other programming symbols
+	"\xef\xbc\x85" => ["%", "percent sign", "％"],
+	"\xef\xbc\x83" => ["#", "number sign", "＃"],
+	"\xef\xbc\x86" => ["&", "ampersand", "＆"],
+	"\xef\xbd\x9c" => ["|", "vertical line", "｜"],
+);
+my $fullwidth_pattern = join('|', map { quotemeta($_) } keys %fullwidth_chars);
+
 my %maybe_linker_symbol; # for externs in c exceptions, when seen in *vmlinux.lds.h
 
 sub help {
@@ -1018,6 +1053,40 @@ sub read_words {
 	return 0;
 }
 
+# Check for full-width characters and optionally fix them
+sub check_fullwidth_chars {
+	my ($line, $context, $warning_type, $apply_fix, $fixlinenr, $fixed_ref, $herecurr) = @_;
+	my @found_chars = ();
+	my $fixed_line = $line;
+	my $has_fixes = 0;
+
+	return 0 unless $line =~ /$fullwidth_pattern/o;
+
+	if ($apply_fix) {
+		$fixed_line =~ s/($fullwidth_pattern)/$fullwidth_chars{$1}[0]/ge;
+		$has_fixes = ($fixed_line ne $line);
+	}
+
+	while ($line =~ /($fullwidth_pattern)/go) {
+		my $fullwidth_byte_seq = $1;
+		if (exists $fullwidth_chars{$fullwidth_byte_seq}) {
+			my ($ascii_char, $name, $fullwidth_char) = @{$fullwidth_chars{$fullwidth_byte_seq}};
+			push @found_chars, "Full-width $name ($fullwidth_char) found$context, use ASCII $name ($ascii_char) instead";
+		}
+	}
+
+	if (@found_chars) {
+		foreach my $msg (@found_chars) {
+			WARN($warning_type, $msg . "\n" . $herecurr);
+		}
+		if ($apply_fix && $has_fixes && defined $fixed_ref) {
+			$fixed_ref->[$fixlinenr] = $fixed_line;
+		}
+	}
+
+	return scalar @found_chars;
+}
+
 my $const_structs;
 if (show_type("CONST_STRUCT")) {
 	read_words(\$const_structs, $conststructsfile)
@@ -2960,6 +3029,11 @@ sub process {
 			$commit_log_has_diff = 1;
 		}
 
+# Check for full-width characters in commit message
+		if ($in_commit_log && show_type("FULLWIDTH_CHARS_COMMIT")) {
+			check_fullwidth_chars($rawline, " in commit message", "FULLWIDTH_CHARS_COMMIT", 0, 0, undef, $herecurr);
+		}
+
 # Check for incorrect file permissions
 		if ($line =~ /^new (file )?mode.*[7531]\d{0,2}$/) {
 			my $permhere = $here . "FILE: $realfile\n";
@@ -3265,6 +3339,11 @@ sub process {
 			     "A patch subject line should describe the change not the tool that found it\n" . $herecurr);
 		}
 
+# Check for full-width characters in Subject line
+		if ($in_header_lines && $line =~ /^Subject:/i && show_type("FULLWIDTH_CHARS_SUBJECT")) {
+			check_fullwidth_chars($rawline, " in subject line", "FULLWIDTH_CHARS_SUBJECT", 0, 0, undef, $herecurr);
+		}
+
 # Check for Gerrit Change-Ids not in any patch context
 		if ($realfile eq '' && !$has_patch_separator && $line =~ /^\s*change-id:/i) {
 			if (ERROR("GERRIT_CHANGE_ID",
@@ -3960,6 +4039,11 @@ sub process {
 			}
 		}
 
+# check for full-width characters (full-width punctuation marks, etc.)
+		if ($rawline =~ /^\+/ && show_type("FULLWIDTH_CHARS")) {
+			check_fullwidth_chars($rawline, "", "FULLWIDTH_CHARS", $fix, $fixlinenr, \@fixed, $herecurr);
+		}
+
 # check multi-line statement indentation matches previous line
 		if ($perl_version_ok &&
 		    $prevline =~ /^\+([ \t]*)((?:$c90_Keywords(?:\s+if)\s*)|(?:$Declare\s*)?(?:$Ident|\(\s*\*\s*$Ident\s*\))\s*|(?:\*\s*)*$Lval\s*=\s*$Ident\s*)\(.*(\&\&|\|\||,)\s*$/) {
-- 
2.50.0



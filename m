Return-Path: <linux-kernel+bounces-770408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AD5B27A69
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41B81C25DE4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F1129C346;
	Fri, 15 Aug 2025 07:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="ouF1keK8"
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A60442056
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755244556; cv=none; b=Vt0Jns1XlmIaArvcW/wSzCUdkNP+WDhGBYIwn/InBJiPC41imKklAlE0xx6XwhfGy3aWRqwn0sr9caPvtN4TqMoQjiLbieVzT5RGGggI7zP9W5ekUlLEc+J8BwaMr1z5kMlKRbNBSUnaxAEn/CCIaD7kKhnhULBcirZcF0hy0i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755244556; c=relaxed/simple;
	bh=FKp9qrGyxPb1wOmh93bDMiSLybMwM1BJkxyNYFEjBeY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nzMDMAemBF7KdUMvzuVfFd0FUtPVCKwg1rs1fBdTZ4HM8TyosMCauCsH70H7WK/03fe/qQGsd00Y3cmNBs3iexaNTXRqQ5ucwdCrNptPg1fKLxslXlNSiIOOzbySZDPKTXWAtADXPmxQlTYjkSwzq8QLoZMy0eU/5iSskWdUMNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=ouF1keK8; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1755244521;
	bh=8AjUIk/Zqh55PDDXuVmj0hJvuhDpc6oxkZ4dfmxlBmY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=ouF1keK8rbO9jv5Gq1DQdrtvEt72Pff7glk+oZ5Hx3sS1OJ4m4VasbQvVSwjTrOcF
	 1/wjc5753oud80td8D61rCpTfbdFxId6y34E/x+RppBaQV6Bdq41WfmOCM5GNN2qdT
	 mUWtbcz26M4teP/3dtg7EYWTofMpFcX5R2Uz34KE=
X-QQ-mid: zesmtpip2t1755244478t1e0948ec
X-QQ-Originating-IP: Cndmvw05UFEIzX8SCpYCEcyesNxf1IA6K4fsu7lRJvE=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 15 Aug 2025 15:54:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8067457830094247552
EX-QQ-RecipientCnt: 9
From: Morduang Zang <zhangdandan@uniontech.com>
To: apw@canonical.com,
	joe@perches.com,
	dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com
Cc: linux-kernel@vger.kernel.org,
	wangyuli@uniontech.com,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	Morduang Zang <zhangdandan@uniontech.com>
Subject: [PATCH RESEND] Add comprehensive detection and automatic fixing capability for full-width (Unicode) characters that are commonly mistaken for ASCII punctuation marks. This helps catch input method editor artifacts that can cause compilation errors or formatting issues.
Date: Fri, 15 Aug 2025 15:54:30 +0800
Message-Id: <20250815075430.135527-1-zhangdandan@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NzSDQCFWCzVTUyidjX0TOekERRNf8zpTRvzbrdn5mOqZCNSQrIjUJ4+F
	P9TgbALhjgOL4ogNHDB933CmQazLPipq9CEUJ1rf4+FuXfWY7SR/gTLIVx1xdeQjcI6jSHM
	tcqnzcWCpEWUgaZNpyawO7azfXoZ0khx/6KGYidd5tG2BE3j07adhbJlY/CJQsU130Nw5aW
	UgqRm5C0k8SKOoKtS3qdPvz54lKes+JsLr32qeTDiL89fbFiWq28+Jfsk6QOzZ1847EdHq9
	u6TfYTeji2v09NReGe8zzzb+ndijq1zD18TLZBkdUEHC3GvKlc4z6yUrmcNZszQ/bsBB0pY
	WOGpxNbaAjFUiYo+i0bnKTzt54CDOlVl/9pm3NzZAwIB+JtszDvR2PWehqiPk2xyVWY93UB
	f9pF0k2k5eZFNitw4ftoPeKcP2rSIPcS9+q2AERFMb/0kXtWxpe8stYN4wn0+Ccf8PJL/P8
	abBlgGnr3995acUbxWz1+MAU4QY1VIy2RacHBeGxUiAMCYbzfv882X53tEOuAfk7ELEI7Xb
	B3Ze2f2ANQcbskFvkiJv6u0nEZl3/iqNIPUnON10OR9J2+j2F6yVYQ7kUQeeUqwP9zEZ6qG
	HCCmuIO92pYtCp6pMAwyf/CUMZaEjED94THPHwu3vVUMBuVscomb94qrtY+vnVBrYN4pT4a
	nmWK3DI72I6srpIp2OfO40mq+RYi0ERdfgW142MChhW1oiQyPiRsQsd76qCaTXCjNyRHNdZ
	Rdv4ur+FdQzfAwRw4+KqPvt5moRjsYcw5yCVi0wrtpDW4I0eZGv9grn8+2ZASoQ3tcyRlhT
	eKywlDB9s4nZRtMNfwL3PmPiqyoFOe5OIZxEiBCrc7hJJYnbGOQJt3094qOICXxcgCLyV0l
	7R8BvvCV7x9buQVD5UJGuLffiCfBK9gpJ4HzVZiLgDKrNTx0EaslT4+eCW/BXxmOWJtR2AD
	Q+gkAYRF0+pknGyWp99UhUnL2aekYuLLum6P2BU6IRz/7i/Ry5vlyEa/pb5zEQbKZLSMAsW
	qX4lAaIhJSEQ7MjHX/TAi4kkKkZUmzF2lF9qQdFD3tVGOKntuE
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

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

Signed-off-by: Morduang Zang <zhangdandan@uniontech.com>
Signed-off-by: Wangyuli <wangyuli@uniontech.com>
---
 scripts/checkpatch.pl | 84 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e722dd6fa8ef..f4cb547a470b 100755
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
@@ -1019,6 +1054,40 @@ sub read_words {
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
@@ -2961,6 +3030,11 @@ sub process {
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
@@ -3266,6 +3340,11 @@ sub process {
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
@@ -3974,6 +4053,11 @@ sub process {
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
2.20.1



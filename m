Return-Path: <linux-kernel+bounces-770421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AB7B27A8F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24FBD3B9B0F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C32C2BE7AF;
	Fri, 15 Aug 2025 08:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="I/IqmJGq"
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E0A1E3DFE
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 08:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755245226; cv=none; b=WIgza7+p9vMUfoHpSDMFyUbsYMVxdUG1hMonlMSKpZrZ8978COhthhBdZi+dI9LkJPwUdW156cakWckS44RPF6jZwOAXfL1WzqWrQ6BqYEeEGeprgiK8hfVLndDdZI1ERXUD4/KnKGrpdmHp8TM/8dz1PJKdXcYDzBqCCdPhh7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755245226; c=relaxed/simple;
	bh=Y6/KP8SnFn8kYOdnzmcBxBAOm8byDhvWCnaIwn7lidw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=R4/o3FbTkLKwcN+nGV/cXXQkX6TuuCu6ytpwmV6XBn7tuEtBlW5pqwbS1ouPgQSQY2VwRVzBXA9MqqKRupadyNq4ngBYuAmOSxRvBLl0MJ+vqkUqqttLLP5MUnO2thKXB679MQV74JutnS58lk7hWxAw0zrA6yWc6pRXWNYcxCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=I/IqmJGq; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1755245184;
	bh=5EE70agYu97ffuNpv7fzYjOIQxPAG4AygdOEE1kVgNw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=I/IqmJGqSzvvCscrqtOZwMVCFjrqSHcaYgV5c+NwOaQPYwZiOATZx4+EYKhZxpMfw
	 KJopDCQIM3XPUXVEUtr2oamFeKtOaKYMKnU11KPcHYlVb4Ql/Ln8DXNvADC0WJ0Hlk
	 BGCwRdEWokmVgv8ktolrChwvmAPAKHZ1KSVSFQ9s=
X-QQ-mid: zesmtpip4t1755245144t981c0aa4
X-QQ-Originating-IP: 98xEkdIS87v/KEyvFWxjMEUYAp1ewusHfqXMMPR3CdM=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 15 Aug 2025 16:05:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 18301434015980025460
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
Subject: [PATCH RESEND] checkpatch: Add full-width character detection
Date: Fri, 15 Aug 2025 16:05:40 +0800
Message-Id: <20250815080540.136786-1-zhangdandan@uniontech.com>
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
X-QQ-XMAILINFO: OSB2dnkaylaqyliZs9rSDORPGyVb1pKsF+0vdM3RP+LqOe4aZgOhjc3V
	8YK0Fkk2psrcnKAa0365iAHsvC4wbcVN3vc3qApN7/w7nG9WG7XySRMqMyK8ndqE9bojQWQ
	qIxhRsOkNhfPI9ouIGKFPT1gSyFkcLpyn42ZFicy0AbckfaOP34pWObrUOZD1Ej8TfIGM9q
	jlywrT/cjZO73VGqMuj94vwxcVnlixALRJE06RwUHOJZ1ORQrub6hA4DRYHJVulsIJsba+Q
	L2UKt0H7PiRJ0XZj2RQhNixacF+9S6vZrgbGLjo4kTcPiuYxH4JwwkPWljuZr9yyUNQ2ZBN
	ZYJmvucnBTucNWruAvy98Wz0n6GaQgDI/VNSJ30jc4xGaXqvArpLTpsZkD8yCXmVO8tpIYt
	x8Tayr5uowzUPFG8OlbLsEdHFAkHHqla3DgH2SUykE/18gYI2hMW3yr65PlgSGjOlxWiXRA
	ixa1ddBFuAzs1AaSkUBgRM8tJHr5NSW1EKCFE05cLN/vFoPo81SJcuqmyy0KpkcKAw3OJs7
	esfd1QIDOYyhVPsreUJOD5kGfHFCyOJi0PjnhS3UHvXwQeEiBspfCevlGzlfmE/ScsLlCy+
	artBvkRMoEj+0vHNUOXmp5KBAdj1bcZRvvLrFoeptNTwj1VmM4ucIQ0CXyC2IM1y6eI2Q/j
	FqmIoKmy/WAWmoRaW9bUtfG7ydLIdCCc2sNrKeCny7x1J9BQP2QPYD4VUka3S2y3xYFPE+d
	MYYVQWMi+tRtsWo8RRuKxKXv3gtROcX/iMLdECdryrpSUEjM5HBG/+1AsvZPX7Yrfm3J10p
	MSSlZLMTWzks533q68xvO8XlBT8cJ6lMmrDHIoI1ZDMKkJvpC9xVlNJTyeDwvHIfaYoB1LW
	hRAiMQopBsn5QQQM0jG+lE206oRr2wiN4ivxRlTRF18SUmN282qA2Kau846+OAWVEY2HxNp
	Y/wQPULuoXnxvqgKpKutNVyGxUECvjHz2JWTZ61yQ2JY4D4Fhb5PTJyIdmb3ZbOLCUDFddv
	eldMSAau5X7eMZLeggDSAoEQ6SHN+2LS4rra/K0/ZAbDPa+yHtjikFwu0+BISnHANvfwVrb
	Akx9dLrfseSyjejqXxOZ4ktVnWAbJjwPtQy81q7CHjtpMPYcULy/wMFV/TKp/KQEcIcIIpn
	AhNO7OpILknFbkOi3uGpChs78Xo3imD+lJDo
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

From: WangYuli <wangyuli@uniontech.com>

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
Signed-off-by: Morduang Zang <zhangdandan@uniontech.com>
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



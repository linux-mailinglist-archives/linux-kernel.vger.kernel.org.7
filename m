Return-Path: <linux-kernel+bounces-770417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F40B9B27A7A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7571C24442
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2E429D26C;
	Fri, 15 Aug 2025 07:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="QenBqeol"
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6BE29AB1B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755244725; cv=none; b=M/RDZhFohr2+auuoK0TFbAzIKhveZtrlA6ynDSx8+FhPMwR7u1bI+PEaqLDUD1ou4VJgg52Rp/dlAd5xyQatGmLNyf58mg5RaurUkH48u1Y5qnYS6BdoJclP5ymtB7KpdonRtNQQK8IwSeImK+QDqLxVifIyDiAj2bY4a8/+dmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755244725; c=relaxed/simple;
	bh=FKp9qrGyxPb1wOmh93bDMiSLybMwM1BJkxyNYFEjBeY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Y6tvXv1YTVThoHyQ9FcSi8VHOSGfVYyHj7aFOZMxOzJ9mZTlzjugxb+EX1uaKl9KXhlhONp+s1YgCdhI4lCiUVzby8rlgJkGM2+z9iesU4JEgLYw+WY5R06siGzILK4IEMCwG1ILdZ+26WlO0eBcyDPXWyHd8yAytzVApm0kkCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=QenBqeol; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1755244690;
	bh=8AjUIk/Zqh55PDDXuVmj0hJvuhDpc6oxkZ4dfmxlBmY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=QenBqeolsuCykJcKoZ4Bit4KhpFXDSynbCFwtGhx74J5FF6nz0eZlajT/IaObgxUj
	 3PDwowO2fA4Q66vc1KNt0YNjeqH7BRwNN61bIj+Ajf56pewd28Y9oXltHIr/Sp9H9s
	 TRx0gULiVkaKrum35vMYA5RXJHk11yklcIquVltY=
X-QQ-mid: zesmtpip3t1755244650t9a6cc0a4
X-QQ-Originating-IP: D3mhnDDD++5phpOcEBSfJQQPlTejr7s/2VX4/YJcayM=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 15 Aug 2025 15:57:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2021490923635856652
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
Subject: [PATCH RESEND] checkpatch: Add full-width character detection Add comprehensive detection and automatic fixing capability for full-width (Unicode) characters that are commonly mistaken for ASCII punctuation marks. This helps catch input method editor artifacts that can cause compilation errors or formatting issues.
Date: Fri, 15 Aug 2025 15:57:26 +0800
Message-Id: <20250815075726.135806-1-zhangdandan@uniontech.com>
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
X-QQ-XMAILINFO: MfMKp/VE+ZXdI4n4V1+mEUyIXN5Ki9d+mwY/OJr1gq1LUFj2TTS3RELm
	yjo4W5ER5b3NrAI4q/I00OJUr+8YR4azU35sxbglW6vrkACCYrrRsQUFXyKVTl4aA2IVmbC
	yhfN9BhxlGUJZ1kbMW2a9fwo9A8o1q/f4InSPMIbqHJNqddlj4TcuEs4lVm4zNGaUO/mzyu
	FDRjpWwnhMLkFZCKs3OsVcXixINlXve3FhtFQMvs4FUHd1o/du9a4MWijg2MKXT15QUayKl
	dKe9bygMmt1yTQZ81HBoht8llTKsZvLdrJQUv3NZvR/BPbiLyPLPpBYjkU7eKpvj05uVOys
	IbWeKj5Fi7k2Vyh0FU+eslU9Hjsu6iM7P3FyJQGbzXfUoG0p44lengTk72JBywjVbGJ82mH
	a+P9pk5Q1RHk7LUaSALPSuyT1jg71ithF4rYe6IcCztevlGnfNzqTk3/kwR5MyNSyEF2by2
	6pBiyrDZLxNcGl/LYH1hrCzE6+Z9j4eimCMreDvEBLvee64ZjNb5/AQS/w/AFJ58VCqXg9j
	Lkmv5x8K/JOSrCa8F0aPosn9OYO3/1tjdH7Lbh2CQ2SOblSs2bjOsMonRLiVLFPbEkyqJ6n
	IQRzV3Z4g2Vocdz1w28p0PosugR5MqNAkhYrMVRWD5WzJgnEdRQ9kUDsW85xg2z0RDZtWCv
	mcXNz2UwOKBi01TDLumi97oYG3ir6THGjhjibUtihgshsCegZpIwFUCQT8U26dwxqPKIh1R
	Q2diRtKeC/qhDcio+bhhdNA2CJcVdak3gxdGHytTYcvupJ++LHvXwwpYapmOtGU2KN5xyQl
	5cLRxXUwGRWUJtd+/9r5VHd1aVX5jQFylZVic+JTjhxwU5OUCzkuBSoaS0qyLLNrStqf/fv
	ylfoLkb3aPtSosuq3GybxGtvyZ93uMhtmbXzkIdpGDvavKPHBvaRd6juwVfGfIwK27+F+0n
	K/Z9+iqQ2o0Wyukaix71YBYFYFJ2EE9Jl62DeK/Fdmi2zWj2svOWLFZTH0b2dJ77FRDkqCP
	Kf4uOT0hVQ3t3INetwPmR9R+YPS9gGCHt2ziuzxsXQCZRXVlUckePzXMpRlLLw90gNMJafs
	wKWKEskZK7oTFi+Zt2a+pX0qdamHJ00ejXHTswkdfa02jhqz804NAwfPJW78Tl+Zg==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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



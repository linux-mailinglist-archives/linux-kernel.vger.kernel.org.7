Return-Path: <linux-kernel+bounces-806247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2867B49432
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E395F7B766C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB5630FF28;
	Mon,  8 Sep 2025 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+oy4xKY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E5F30FC3F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346155; cv=none; b=sQgkgjPv5vsn0uSrzjJaswUFz0wo17zvFTypDuiEGTtGbN79m7TWPPwM4UqyRKA2F9L4/zJFTj5hVYs87ssLcZzaepyw2N4XUbPlkFXH6tIS1pVgCjSiwfuVnnInAJIlIAziPePxtoA/lueOY1vzDaZkgS3sKkpf8hBQnKE39Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346155; c=relaxed/simple;
	bh=QMfWFEcxtesZWCLxtNH+3FIBjKsP9cVYMB+YWbCzGto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kt1QG8ZEkZrtNZuZY+WdalMVF6dFXtTs0HQoRRwZTfiLPmSUNZgJa7P9TWLO8nFYaKCL8UnEI9Sa5S6xV0e9p4Z/BsmLVrctT/tvzQkcNdufzZHBkdZ4/NQcT+K2yj6AUqjWjy6xmU64/lryCxkwIdoPVTRKnYhRCzlM7Zhq2Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+oy4xKY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71513C4CEF7;
	Mon,  8 Sep 2025 15:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757346154;
	bh=QMfWFEcxtesZWCLxtNH+3FIBjKsP9cVYMB+YWbCzGto=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=f+oy4xKYtgjX092rF+4IlYSUJe8NrUVCsZR0NuNWoXFGz20iZTSx1QgM8UNplV8MR
	 JFeDa6GqVr3ikveLL6NSYm+FjKq9PBhb9aG8jc6P75h1gZVVcPPlJOn5ljA33fKI1x
	 UP2sfV+ao+ApaYZWT7gIUhdbaoOVhVyjqzgDB5yAQwFI2A6I5c74zo70AYljvEfBmK
	 AF4S26KNVs75bK2uujGUfFwbKgJwgQ1dLsFU5xEYP+2sUeBFL91KplhOZSpomMENRa
	 Z1YW9fAdamRyP4jY3Wv2roTC0lF0p+6usHwgOmRtqWZ+CPf3NDas2pL9URqqdNub++
	 xTSUP+aLutEEw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 08 Sep 2025 17:41:58 +0200
Subject: [PATCH 2/3] scripts/decode_stacktrace.sh: symbol: preserve
 alignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-decode_strace_indent-v1-2-28e5e4758080@kernel.org>
References: <20250908-decode_strace_indent-v1-0-28e5e4758080@kernel.org>
In-Reply-To: <20250908-decode_strace_indent-v1-0-28e5e4758080@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Carlos Llamas <cmllamas@google.com>, 
 Elliot Berman <quic_eberman@quicinc.com>, 
 Stephen Boyd <swboyd@chromium.org>, Breno Leitao <leitao@debian.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4143; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=QMfWFEcxtesZWCLxtNH+3FIBjKsP9cVYMB+YWbCzGto=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL2/Ux+VPll9csF1qFpeSGHo4xMTXxOdD7QdLPi/Bu84
 otjo8LRjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgInkv2f4w32u9umX+w+sD91e
 I1K6ukxUedGfhKNHFriLlGT7HFxvep2RYdfDNz9vpc9kF330y9SruldwKsvFdzUcXpNm3VVy2O7
 3igcA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

With lines having a symbol to decode, the script was only trying to
preserve the alignment for the timestamps, but not the rest, nor when
the caller was set (CONFIG_PRINTK_CALLER=y).

With this sample ...

  [   52.080924] Call Trace:
  [   52.080926]  <TASK>
  [   52.080931]  dump_stack_lvl+0x6f/0xb0

... the script was producing the following output:

  [   52.080924] Call Trace:
  [   52.080926]  <TASK>
  [   52.080931] dump_stack_lvl (arch/x86/include/asm/irqflags.h:19)

  (dump_stack_lvl is no longer aligned with <TASK>: one missing space)

With this other sample ...

  [   52.080924][   T48] Call Trace:
  [   52.080926][   T48]  <TASK>
  [   52.080931][   T48]  dump_stack_lvl+0x6f/0xb0

... the script was producing the following output:

  [   52.080924][   T48] Call Trace:
  [   52.080926][   T48]  <TASK>
  [ 52.080931][ T48] dump_stack_lvl (arch/x86/include/asm/irqflags.h:19)

  (the misalignment is clearer here)

That's because the script had a workaround for CONFIG_PRINTK_TIME=y
only, see the previous comment called "Format timestamps with tabs".

To always preserve spaces, they need to be recorded along the words.
That is what is now done with the new 'spaces' array.

Some notes:

- 'extglob' is needed only for this operation, and that's why it is set
  in a dedicated subshell.

- 'read' is used with '-r' not to treat a <backslash> character in any
  special way, e.g. when followed by a space.

- When a word is removed from the 'words' array, the corresponding space
  needs to be removed from the 'spaces' array as well.

With the last sample, we now have:

  [   52.080924][   T48] Call Trace:
  [   52.080926][   T48]  <TASK>
  [   52.080931][   T48]  dump_stack_lvl (arch/x86/include/asm/irqflags.h:19)

  (the alignment is preserved)

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 scripts/decode_stacktrace.sh | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index c6b5c14412f0f6f78fb60b0b042d6e22bbb46b79..0c92d6a7f777e1b2d5452dd894a13a71e3d58051 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -255,10 +255,11 @@ handle_line() {
 		basepath=${basepath%/init/main.c:*)}
 	fi
 
-	local words
+	local words spaces
 
-	# Tokenize
-	read -a words <<<"$1"
+	# Tokenize: words and spaces to preserve the alignment
+	read -ra words <<<"$1"
+	IFS='#' read -ra spaces <<<"$(shopt -s extglob; echo "${1//+([^[:space:]])/#}")"
 
 	# Remove hex numbers. Do it ourselves until it happens in the
 	# kernel
@@ -270,19 +271,13 @@ handle_line() {
 	for i in "${!words[@]}"; do
 		# Remove the address
 		if [[ ${words[$i]} =~ \[\<([^]]+)\>\] ]]; then
-			unset words[$i]
-		fi
-
-		# Format timestamps with tabs
-		if [[ ${words[$i]} == \[ && ${words[$i+1]} == *\] ]]; then
-			unset words[$i]
-			words[$i+1]=$(printf "[%13s\n" "${words[$i+1]}")
+			unset words[$i] spaces[$i]
 		fi
 	done
 
 	if [[ ${words[$last]} =~ ^[0-9a-f]+\] ]]; then
 		words[$last-1]="${words[$last-1]} ${words[$last]}"
-		unset words[$last]
+		unset words[$last] spaces[$last]
 		last=$(( $last - 1 ))
 	fi
 
@@ -294,7 +289,7 @@ handle_line() {
 	local info_str=""
 	if [[ ${words[$last]} =~ \([A-Z]*\) ]]; then
 		info_str=${words[$last]}
-		unset words[$last]
+		unset words[$last] spaces[$last]
 		last=$(( $last - 1 ))
 	fi
 
@@ -311,7 +306,7 @@ handle_line() {
 			modbuildid=
 		fi
 		symbol=${words[$last-1]}
-		unset words[$last-1]
+		unset words[$last-1] spaces[$last-1]
 	else
 		# The symbol is the last element, process it
 		symbol=${words[$last]}
@@ -323,7 +318,10 @@ handle_line() {
 	parse_symbol # modifies $symbol
 
 	# Add up the line number to the symbol
-	echo "${words[@]}" "${symbol}${module:+ ${module}}${info_str:+ ${info_str}}"
+	for i in "${!words[@]}"; do
+		echo -n "${spaces[i]}${words[i]}"
+	done
+	echo "${spaces[$last]}${symbol}${module:+ ${module}}${info_str:+ ${info_str}}"
 }
 
 while read line; do

-- 
2.51.0



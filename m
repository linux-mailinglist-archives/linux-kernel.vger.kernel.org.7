Return-Path: <linux-kernel+bounces-877381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E62C1DFB0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 02:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 677F4189B28E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 01:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B7E238C0F;
	Thu, 30 Oct 2025 01:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1x9FWZip"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D4E17A318
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761786234; cv=none; b=n/fvozr7tMqyrR/4jw7+o1oA7I6Aa2FkPATC/T0qHHFBQ/9YKqTCwMKVdntKgxI8BFgDf/UWa9nKoLY9wEUc2v7ZbtB+D8j8+VKSOZXLDTItgYfHC4/KDNcV6K9I1oGUpBe50mZuPYQP9Ksxga6qxspxu/3oTVcZbveSoR2wQsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761786234; c=relaxed/simple;
	bh=vNCSoAMNWuJCTQJR1KfBsytl5MDFWTI8Dj8pLkRDTgA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=r2p5Hv9PsZjnEqDiqWZ3NurHXe4F8C5Osm4wVPvhmyAMMi7ZnOyIFIwEiUmnSX+B2nedhxicJDqeP9SFtaeUxIO7S5OdVIO54BnJa3R3ov7EApoTtaeIhPt8s6L/ctF4wQShguu/iryV50lPmyf++GBRNYJq8R7637bRRDn+iZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1x9FWZip; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3405e02ff45so2426a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 18:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761786231; x=1762391031; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0KlJNGgynhgZfuiSx925fMjE0dT236FJrdb3tjO33xE=;
        b=1x9FWZip1aMDi9dJTY2SIxC0MCStt5WC342MfJeJsDKM9IDEVJcMPLzVhSYr5Dk5e3
         SbJ9P5NOBUU4BkDlP/BZzr3k2sU7l+SRXAkunlcs3yNQMCqYcPP3SyUWF47CkM/OuRvw
         AlW3baYn0XBgbZTHTD5Pl34YjULX/jjFeFTxiWEPOXiLj0UV/AtX+iKW66suzFDol9BD
         d5eP5qOnw4MpalrnjuaEUnpmaDX64KDXWHlUnFFeM+bT/RXJimuCG+OPomK40irF4blZ
         oYKotB+0CqIZ40cX8M0TW0oycaQuwaFGwle135Vwlokms7o2dnKqw6oITzAJ4AOoMLpR
         JRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761786231; x=1762391031;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0KlJNGgynhgZfuiSx925fMjE0dT236FJrdb3tjO33xE=;
        b=FOEvsdibORaqWsV83Hn3JTTbF7jsShB3IhfVFy+qAVm3jL2A7cGw5gd4+CfslwFkU/
         yb5AWpi/Z/eajn08J6wN8pd8/rNf8fjcXNaMP1lt+LwjJhrx5O4VlMQzEPtLb+X7MqMo
         FEi2Epbq0GJJ+fQXw74YLwUELAxvelT8nu05ILbaOfVep/SIcyQ/Yx9T2J/gnnnwn0xx
         ZlHmY4irkKrmchf1mZiXD2m9JpTbsetGzm6Ci8DwBSDioicb5Xz8/puSO6i5F7cjwV7H
         9kEWFsWqXQim/cA6HEcVKlhtLGWBFy6y8gE6YDmIOHf02ppkw1NgZcbIKJiUADYe9s+3
         blQw==
X-Forwarded-Encrypted: i=1; AJvYcCWFaW4Ybd/N+CjMdit5T6r8EPcPo63A5grOkjW0nL/78jDu+B2uJdNiUjoPb96/jEXAOLH7y1WeMVCUSQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR6DNGcL9YaUiPFZT7+FlPxHnY3fKaLU1uuFmoS/guH3o+cEds
	or5cGfFHkKwLIR5Lo7zbfNp/p0Pm13r/jBIFkdIypCw7sE7R0O9RMYs072eWwquWfxD8O21y7zj
	WAuYj69FI1jrrDw==
X-Google-Smtp-Source: AGHT+IH1c1zNELOJE3UON7A2LKtXUC/SQSkxzmN5Dgsn+k+KuzEVk+mbODJVZ0d5XeRTYfZQHH3nVXxazD8pTg==
X-Received: from pjbbh20.prod.google.com ([2002:a17:90b:494:b0:33e:287b:a4a6])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2e10:b0:32e:a54a:be53 with SMTP id 98e67ed59e1d1-3403a260b03mr6277528a91.16.1761786231012;
 Wed, 29 Oct 2025 18:03:51 -0700 (PDT)
Date: Thu, 30 Oct 2025 01:03:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251030010347.2731925-1-cmllamas@google.com>
Subject: [PATCH] scripts/decode_stacktrace.sh: fix build ID and PC source parsing
From: Carlos Llamas <cmllamas@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
	Breno Leitao <leitao@debian.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Miroslav Benes <mbenes@suse.cz>, Mark Brown <broonie@kernel.org>, 
	Puranjay Mohan <puranjay@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Support for parsing PC source info in stacktraces (e.g. '(P)') was
added in commit 2bff77c665ed ("scripts/decode_stacktrace.sh: fix
decoding of lines with an additional info"). However, this logic was
placed after the build ID processing. This incorrect order fails to
parse lines containing both elements, e.g.:

  drm_gem_mmap_obj+0x114/0x200 [drm 03d0564e0529947d67bb2008c3548be77279fd27] (P)

This patch fixes the problem by extracting the PC source info first and
then processing the module build ID. With this change, the line above is
now properly parsed as such:

  drm_gem_mmap_obj (./include/linux/mmap_lock.h:212 ./include/linux/mm.h:811 drivers/gpu/drm/drm_gem.c:1177) drm (P)

While here, also add a brief explanation the build ID section.

Fixes: bdf8eafbf7f5 ("arm64: stacktrace: report source of unwind data")
Fixes: 2bff77c665ed ("scripts/decode_stacktrace.sh: fix decoding of lines with an additional info")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 scripts/decode_stacktrace.sh | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index c73cb802a0a3..8d01b741de62 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -277,12 +277,6 @@ handle_line() {
 		fi
 	done
 
-	if [[ ${words[$last]} =~ ^[0-9a-f]+\] ]]; then
-		words[$last-1]="${words[$last-1]} ${words[$last]}"
-		unset words[$last] spaces[$last]
-		last=$(( $last - 1 ))
-	fi
-
 	# Extract info after the symbol if present. E.g.:
 	# func_name+0x54/0x80 (P)
 	#                     ^^^
@@ -295,6 +289,14 @@ handle_line() {
 		last=$(( $last - 1 ))
 	fi
 
+	# Join module name with its build id if present, as these were
+	# split during tokenization (e.g. "[module" and "modbuildid]").
+	if [[ ${words[$last]} =~ ^[0-9a-f]+\] ]]; then
+		words[$last-1]="${words[$last-1]} ${words[$last]}"
+		unset words[$last] spaces[$last]
+		last=$(( $last - 1 ))
+	fi
+
 	if [[ ${words[$last]} =~ \[([^]]+)\] ]]; then
 		module=${words[$last]}
 		# some traces format is "(%pS)", which like "(foo+0x0/0x1 [bar])"
-- 
2.51.1.851.g4ebd6896fd-goog



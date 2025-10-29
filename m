Return-Path: <linux-kernel+bounces-876500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE7BC1BDC9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A6F45C1250
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4100830C60F;
	Wed, 29 Oct 2025 15:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="T22IUOzV"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E072F6912
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751247; cv=none; b=Z5xXdG9b9inymXsjO5XlIJyIj+fhesB1b2dXssa4+Ly4jj5RmDe5BLufE6DeBTLfj+n0hpuiZD7j96Q2BEIF+g0Wj3FGYKjMclBCTjs/MgJXhVBpCccVkOsZu23O71H1X1SJ5pK8sGPJh4Irg9KrISUF8ioqefaBDZUh1FwPlYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751247; c=relaxed/simple;
	bh=HsqIx8+IJ0E/PCaCWQFdxj3WXjldedE9WdTaVKu8Mzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CWMno6Xpo6pwXxPq+2Wz/+0YNtjTAn7LSykLrlQjWaZ40KhNfXKfEXxyrKYl7LqK0blOOu0N9N+9cA1CA6by94mM9zXHNbx/XlG8bIRO9ceqIuACKckyuyFT6zw9cMCH69YOUI1qJ1v/kpt9HleDrzaqc9Hc1DuzfZlcmWcrczo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=T22IUOzV; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761751242;
	bh=HsqIx8+IJ0E/PCaCWQFdxj3WXjldedE9WdTaVKu8Mzs=;
	h=From:Date:Subject:To:Cc:From;
	b=T22IUOzV/MsCEGMHkrD5VbnbP7/xZR0Rk4JduAqAJb4uU0gEjZFI2KHDMheeadKy0
	 Gdp9NkeTyt2rl8pGUK+7AkOLJ2Jfbjoo6+WS4/Dw8afsrRkykPM2aDi5ERJvghF5vu
	 xS8cB3U7TAcDC1gWg2n3zGdCsRmJxb2MjLtDlnPg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 29 Oct 2025 16:20:34 +0100
Subject: [PATCH] LoongArch: ptrace: Use UAPI types in UAPI header
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251029-loongarch-uapi-ptrace-types-v1-1-5c84855a348d@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAMEwAmkC/x3MQQqEMAwAwK9IzgZqocr6FdlDiVEDS1tSV5Ti3
 y0e5zIFMqtwhrEpoHxIlhgqurYB2nxYGWWuBmus64z94C/GsHqlDf8+CaZdPTHuV+KMhhz1g+u
 XgQ3UISkvcr779L3vB4uWWa5tAAAA
X-Change-ID: 20251029-loongarch-uapi-ptrace-types-0c5c6756f7e0
To: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761751240; l=2467;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=HsqIx8+IJ0E/PCaCWQFdxj3WXjldedE9WdTaVKu8Mzs=;
 b=iRGJc3xKWpH8P8tHfaNUxQgjaPLqEMXyIUdYMwkHmnUIDlVkOxJKQd8MbhR2Pb4O9f7J3yvU8
 qCeHgSmlM/5BoDUlgE1aB0wVgdYcHKtrv01J4B/PlkUphgBZ54+WYqc
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The kernel UAPI headers already contain fixed-width integer types,
there is no need to rely on libc types. There may not be a libc
available or it may not provide <stdint.h>, like for example on nolibc.

This also aligns the header with the rest of the LoongArch UAPI headers.

Fixes: 803b0fc5c3f2 ("LoongArch: Add process management")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
I'd like to take this through the nolibc tree, as this currently breaks
the upcoming nolibc ptrace support.
---
 arch/loongarch/include/uapi/asm/ptrace.h | 40 ++++++++++++++------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/arch/loongarch/include/uapi/asm/ptrace.h b/arch/loongarch/include/uapi/asm/ptrace.h
index aafb3cd9e943..215e0f9e8aa3 100644
--- a/arch/loongarch/include/uapi/asm/ptrace.h
+++ b/arch/loongarch/include/uapi/asm/ptrace.h
@@ -10,10 +10,6 @@
 
 #include <linux/types.h>
 
-#ifndef __KERNEL__
-#include <stdint.h>
-#endif
-
 /*
  * For PTRACE_{POKE,PEEK}USR. 0 - 31 are GPRs,
  * 32 is syscall's original ARG0, 33 is PC, 34 is BADVADDR.
@@ -41,44 +37,44 @@ struct user_pt_regs {
 } __attribute__((aligned(8)));
 
 struct user_fp_state {
-	uint64_t fpr[32];
-	uint64_t fcc;
-	uint32_t fcsr;
+	__u64 fpr[32];
+	__u64 fcc;
+	__u32 fcsr;
 };
 
 struct user_lsx_state {
 	/* 32 registers, 128 bits width per register. */
-	uint64_t vregs[32*2];
+	__u64 vregs[32*2];
 };
 
 struct user_lasx_state {
 	/* 32 registers, 256 bits width per register. */
-	uint64_t vregs[32*4];
+	__u64 vregs[32*4];
 };
 
 struct user_lbt_state {
-	uint64_t scr[4];
-	uint32_t eflags;
-	uint32_t ftop;
+	__u64 scr[4];
+	__u32 eflags;
+	__u32 ftop;
 };
 
 struct user_watch_state {
-	uint64_t dbg_info;
+	__u64 dbg_info;
 	struct {
-		uint64_t    addr;
-		uint64_t    mask;
-		uint32_t    ctrl;
-		uint32_t    pad;
+		__u64    addr;
+		__u64    mask;
+		__u32    ctrl;
+		__u32    pad;
 	} dbg_regs[8];
 };
 
 struct user_watch_state_v2 {
-	uint64_t dbg_info;
+	__u64 dbg_info;
 	struct {
-		uint64_t    addr;
-		uint64_t    mask;
-		uint32_t    ctrl;
-		uint32_t    pad;
+		__u64    addr;
+		__u64    mask;
+		__u32    ctrl;
+		__u32    pad;
 	} dbg_regs[14];
 };
 

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251029-loongarch-uapi-ptrace-types-0c5c6756f7e0

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>



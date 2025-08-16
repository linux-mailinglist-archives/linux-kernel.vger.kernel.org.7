Return-Path: <linux-kernel+bounces-772139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD131B28F28
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 17:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA6315C71DD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 15:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018E82F7458;
	Sat, 16 Aug 2025 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PYbwC6m9"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADA58462
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755358202; cv=none; b=GrQuIGX2Shy4G/mOpSOKbA+OKMFya1YW6y9otSv6N4InaeSUdHdoi8Mme4xo8ghsMrh81UASGMbLuz/sQ32wkXQrqvXHEXFw1sxXLYhb7wcgTlsGYduvJ05qg9mELWQCasGg3/F1mu+01pws/BC9TQJ2SLMKZKLRzNpmI27yYSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755358202; c=relaxed/simple;
	bh=+Spv1PsNit21/PUVejo5UL7D6iAmgNLhXurHkYoE/e8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mIoNqbTvX3sNdAbGnEYkVNDtsInWrdpC5zS2hvkaOOPcbPkp5dUv4cW6DkNn2Lkm2KWuYOP3Fgs0z+K3PKVQSKydfdh2sMZ+Miwoowq9e7oHx+JqD0kKNnEnae6UUJ3Zf1ZZAqwg/F9hUnUJoDe8tCkIHGS5hj4/dL9WdUn/zaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PYbwC6m9; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755358198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VO9LFrcZyjmUCjNxK9HB911t9pQCKhf3yh5jBn/3GgQ=;
	b=PYbwC6m9zDUptb5cBKZz1HsIx28Ara6mWX5/xGGImnr9PWMBt/f1mZwJFAjkoGyPIb417f
	zZoLm135hcsXefHkgkI8TzhWD/HkUcyDOJWrQPhx7EYzX292YNxfB7fxMwR45SZhwOgdAA
	ZPM16G2LRFXg3k8mDa+1VD3lAi1bnBA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Russell Senior <russell@personaltelco.net>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Ingo Molnar <mingo@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/cyrix: Replace deprecated strcpy() with strscpy()
Date: Sat, 16 Aug 2025 17:29:15 +0200
Message-ID: <20250816152916.427883-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead.

Remove the local variable 'char *buf' and call strscpy() directly with
'c->x86_model_id', allowing the compiler to infer the fixed size of the
destination buffer using sizeof().

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Note: I already submitted this in April as part of another patch [1]
which doesn't apply anymore. Submitting this again as a separate patch.
[1]: https://lore.kernel.org/lkml/20250425074917.1531-3-thorsten.blum@linux.dev/
---
 arch/x86/kernel/cpu/cyrix.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/cyrix.c b/arch/x86/kernel/cpu/cyrix.c
index dfec2c61e354..07521e3f94d8 100644
--- a/arch/x86/kernel/cpu/cyrix.c
+++ b/arch/x86/kernel/cpu/cyrix.c
@@ -192,7 +192,6 @@ static void early_init_cyrix(struct cpuinfo_x86 *c)
 static void init_cyrix(struct cpuinfo_x86 *c)
 {
 	unsigned char dir0, dir0_msn, dir0_lsn, dir1 = 0;
-	char *buf = c->x86_model_id;
 	const char *p = NULL;
 
 	/*
@@ -352,9 +351,9 @@ static void init_cyrix(struct cpuinfo_x86 *c)
 		dir0_msn = 7;
 		break;
 	}
-	strcpy(buf, Cx86_model[dir0_msn & 7]);
+	strscpy(c->x86_model_id, Cx86_model[dir0_msn & 7]);
 	if (p)
-		strcat(buf, p);
+		strcat(c->x86_model_id, p);
 	return;
 }
 
@@ -416,7 +415,7 @@ static void cyrix_identify(struct cpuinfo_x86 *c)
 	if (c->x86 == 4 && test_cyrix_52div()) {
 		unsigned char dir0, dir1;
 
-		strcpy(c->x86_vendor_id, "CyrixInstead");
+		strscpy(c->x86_vendor_id, "CyrixInstead");
 		c->x86_vendor = X86_VENDOR_CYRIX;
 
 		/* Actually enable cpuid on the older cyrix */
-- 
2.50.1



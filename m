Return-Path: <linux-kernel+bounces-839515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 214B0BB1C53
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 23:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE2424E124E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 21:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95E2313530;
	Wed,  1 Oct 2025 21:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KP/r1dsr"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B983128C8
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 21:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759352654; cv=none; b=PhaQJTB9FOh2J2ZgI71ROyVCJyB2Squ0D0vd9UmiL7k2mE/pIbgvgoq+pDVhiR+RHQF0AvuCDVH8pkdg/632u8CjGLhHEC/aLpTtefg/xgyUkIgAlr2osnFjM4Be/sy6slesRX/Rsicd4bIVpt/lWYHh14GB9GxLOCu4e8NexkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759352654; c=relaxed/simple;
	bh=jNAe/V4zNi6LpOPWatt40NoZhMnHLRvmHGAaaO4Ly1s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iJcnZivqO5UV32e0FrhiovZXi9lhS6tz0mbnoqvhFlYV47mqTl/StWLy9/xTBrgG1kEvkQHgmrnlrEc9zEICUQsAvHdx2RyMuiIWtU+PTkZvIrNteE3kedBxwLXZp78+IsVfpg0uuI6rNzrkegS7TxluD5lrtlTuaiwj2hwhDvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KP/r1dsr; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e3a049abaso1239965e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 14:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759352651; x=1759957451; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NhER74UBpIhoIb7wn4zkF28t+zv1ftYCaNbghO5GaF0=;
        b=KP/r1dsryPzrDFOHsD3a8VegYS59PvdVwxOHHDFaHBi+Xe5isVSAHmWemHxR5ph1db
         F3dBd6fiNpqOL42WlD7XUqT0iUe6jnE2MHoZaILPK921Ql1nH20yhnJEXQ83MSVpy0tS
         pqIk9MrlnPswG/mgETtk1ke+j716WHlRh5ybBW1MIMuvAIsCcVczLTKZtDPlY8OcEKuk
         aeHSGbENAZCWz33JFlSI5eC+JSrk0Ippp4ryh1h4RRoM8ZPXeKol76ZArw6M5zjC2NCn
         AsJUxs0SYXgWmZWuAkOHiE9uSDaOPNLf32tkgYgTHW9aIobxuR7q3+ma5Np5yeR7XlU4
         q8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759352651; x=1759957451;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NhER74UBpIhoIb7wn4zkF28t+zv1ftYCaNbghO5GaF0=;
        b=K+g9U9YA09SIDYcUJzbF7vT/svGY6XflqJbXPqNCXwEY9U23D2a8W4G3mMAvRuM5DE
         WA8d/YGYIwNFs2Ce1RZjACeUIRC13NzLAziFN7f7zhqW/sjUDbMScf+rOuvk87OzjFED
         5BajM3/1xS/Q9AR1nt//lmrCATfXBbEXWnGb59iydh6UWZ2H5AW9D+0jJmbzn05F7gr1
         rfwQWEC0lTdqmbs1MrWW8EJ+bEvj/PDIwvsWm6xPJsYvwKgvMXUUarLX4kRBGUFOoXAA
         e3ug7aJkTn219EU3MM6IC935bRMfiq2/oMMbn2o/6Q6CHmeJrr5iTZrXOP+nimg9kO+/
         g7HQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+xLts0rukWEz2vM5PskqeVGRdiUb+AyteybM1/MX02s6DmlB4P5ZhE1puery7q/LxwNfVsenyj9b1P8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZf9L9St3nRtddxAc/DGvQzK8hkj+vWorl6CE+XcERkAfxHAyd
	RbtCT6NglGXtenvgn7d9k6ol+h8sYpARU02kuTrjoyLL2E1vdOyxthF8a6HcLaEmoh5EbnsIYw=
	=
X-Google-Smtp-Source: AGHT+IHOlHJXU9hXA0ZmAXl6mlRNCJKkb1Gcp+5ssLGIRuoPhjvb1Emmd8X4cPDWubbLQ9YjO7PB9gsQ
X-Received: from wmcq27.prod.google.com ([2002:a05:600c:c11b:b0:46e:1f26:9212])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:6692:b0:46e:502c:8d6a
 with SMTP id 5b1f17b1804b1-46e64641e65mr29454385e9.25.1759352651235; Wed, 01
 Oct 2025 14:04:11 -0700 (PDT)
Date: Wed,  1 Oct 2025 23:02:19 +0200
In-Reply-To: <20251001210201.838686-22-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251001210201.838686-22-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2860; i=ardb@kernel.org;
 h=from:subject; bh=nxbcY1qMUcCM5Jp3a99oXHHwAeI3LF7dd8KEKxZdHZ4=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIePudKH2XdeuGB133c2V2KjV5uU9u09ni9zLgvJw7qCF0
 9Z8LXjSUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACaS0M7I8OxoakasXPVCVm6x
 mvWzfBYxuO7SO7rQoEMsbF7GoxkqCxj+cNsr7Pt+bLaWpqps/7OPbIU9G7oT7rhfTTy33L9yhcN 5XgA=
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251001210201.838686-39-ardb+git@google.com>
Subject: [PATCH v2 17/20] crypto/arm64: sm3 - Switch to 'ksimd' scoped guard API
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	herbert@gondor.apana.org.au, linux@armlinux.org.uk, 
	Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
	Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/crypto/sm3-ce-glue.c   | 15 ++++++++-------
 arch/arm64/crypto/sm3-neon-glue.c | 16 ++++++----------
 2 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/crypto/sm3-ce-glue.c b/arch/arm64/crypto/sm3-ce-glue.c
index eac6f5fa0abe..24c1fcfae072 100644
--- a/arch/arm64/crypto/sm3-ce-glue.c
+++ b/arch/arm64/crypto/sm3-ce-glue.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2018 Linaro Ltd <ard.biesheuvel@linaro.org>
  */
 
-#include <asm/neon.h>
 #include <crypto/internal/hash.h>
 #include <crypto/sm3.h>
 #include <crypto/sm3_base.h>
@@ -13,6 +12,8 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 
+#include <asm/simd.h>
+
 MODULE_DESCRIPTION("SM3 secure hash using ARMv8 Crypto Extensions");
 MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
 MODULE_LICENSE("GPL v2");
@@ -25,18 +26,18 @@ static int sm3_ce_update(struct shash_desc *desc, const u8 *data,
 {
 	int remain;
 
-	kernel_neon_begin();
-	remain = sm3_base_do_update_blocks(desc, data, len, sm3_ce_transform);
-	kernel_neon_end();
+	scoped_ksimd() {
+		remain = sm3_base_do_update_blocks(desc, data, len, sm3_ce_transform);
+	}
 	return remain;
 }
 
 static int sm3_ce_finup(struct shash_desc *desc, const u8 *data,
 			unsigned int len, u8 *out)
 {
-	kernel_neon_begin();
-	sm3_base_do_finup(desc, data, len, sm3_ce_transform);
-	kernel_neon_end();
+	scoped_ksimd() {
+		sm3_base_do_finup(desc, data, len, sm3_ce_transform);
+	}
 	return sm3_base_finish(desc, out);
 }
 
diff --git a/arch/arm64/crypto/sm3-neon-glue.c b/arch/arm64/crypto/sm3-neon-glue.c
index 6c4611a503a3..15f30cc24f32 100644
--- a/arch/arm64/crypto/sm3-neon-glue.c
+++ b/arch/arm64/crypto/sm3-neon-glue.c
@@ -5,7 +5,7 @@
  * Copyright (C) 2022 Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
  */
 
-#include <asm/neon.h>
+#include <asm/simd.h>
 #include <crypto/internal/hash.h>
 #include <crypto/sm3.h>
 #include <crypto/sm3_base.h>
@@ -20,20 +20,16 @@ asmlinkage void sm3_neon_transform(struct sm3_state *sst, u8 const *src,
 static int sm3_neon_update(struct shash_desc *desc, const u8 *data,
 			   unsigned int len)
 {
-	int remain;
-
-	kernel_neon_begin();
-	remain = sm3_base_do_update_blocks(desc, data, len, sm3_neon_transform);
-	kernel_neon_end();
-	return remain;
+	scoped_ksimd()
+		return sm3_base_do_update_blocks(desc, data, len,
+						 sm3_neon_transform);
 }
 
 static int sm3_neon_finup(struct shash_desc *desc, const u8 *data,
 			  unsigned int len, u8 *out)
 {
-	kernel_neon_begin();
-	sm3_base_do_finup(desc, data, len, sm3_neon_transform);
-	kernel_neon_end();
+	scoped_ksimd()
+		sm3_base_do_finup(desc, data, len, sm3_neon_transform);
 	return sm3_base_finish(desc, out);
 }
 
-- 
2.51.0.618.g983fd99d29-goog



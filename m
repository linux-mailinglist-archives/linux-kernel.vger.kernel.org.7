Return-Path: <linux-kernel+bounces-879978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 623E7C248AD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DA7CD3500A1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216A1345CD4;
	Fri, 31 Oct 2025 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NN/ZPy/Y"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356CE345CBA
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761907201; cv=none; b=hIjzjgkD5wUDdzlO3ooGIgjAxI0bNkjlsZbVpyOfloEkByGlEuf5uzTggojE1K6UmrtxDvx1Fu4mi6s4tIqDRBbAbtlo6b2jZPmsOtWvA4fmVFa/PJpz95fJZ+3Rm+ATR0PWFCLK2qzrpKAKSX0GDZptKPiPYw5cLEJyMbUURgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761907201; c=relaxed/simple;
	bh=TVw+CnmJFmWZrxBaJk6VSGgwnVZfUbIi3slBCLmlOJo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n/6F3l7+dBYGjGwwut5Ajqq3b9P+tURkGYFunEqUJNw0a/DJM6zXQpMCtxnTD2VIt/AMiGWiPGkJQAoqPURHDHTBa+kfcc3x3X5K6rlIwXa5bDZVsXj6Q1iVUzeS2u0pW7sSINu1xdviY8/dJRL1soZINrwVPreHXcQ8V7NK1gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NN/ZPy/Y; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-475db4369b1so11286745e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761907197; x=1762511997; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fnEn/zNYGpYeH2kzoRoKsGDEwWWCiCH27FEc88gwnrM=;
        b=NN/ZPy/YHW05bB1f0x/k4KuwUKqqnGnzlJn+vIvkv07JNMGWdtK/jp8opg3tezW4zX
         CWFRpSPhpnlOEXrkMng9KNh3VfhBLatMNWloubj8eWPAtb5pjuDsMB2rn32nUi82zT3a
         QuEItZwS4PMZz3TUWrEll71C5vU1c7FbKFYZIuuUYyJxL4BQEWmJZXKQydHKllR6FDxe
         +7av51x+HXBTxHEgTjkbh9+molTAoN90YvTLPxSoZrnNX7bZ0ja37/BN5d0K0Lxs9s5c
         522n8edQchcEVqcO6yMCO0B6sVANnxOEXs756k9A8fghCmFt3zDmCxnINUj1FMLTEzyN
         iI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761907197; x=1762511997;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fnEn/zNYGpYeH2kzoRoKsGDEwWWCiCH27FEc88gwnrM=;
        b=hXluNC2q3SQ51/zgLtJ5vL3mr4V9UvWBhdXhGKwd4qlSp+IPnXGTvq4UyB4rwMehXx
         3BdjSPE2grKUK5zViVuq2eky1JqJ8juXNy0LkDH8XpJJ9dtNXJtyl4wvNiJNvFfie5xQ
         0StqE4wwUKwemWbG3dYW1nzxytJXR/XiY9LnhjC6iB5kd+1Rz4D+eUQTM99MgTfo0rC2
         YdDOTji5Am3QAcYREGpwAg/bkfXyAQ3GB3JyhNXAEmbj0EIrD5HDxGIxh29DNHNQMkjB
         u9gf+hc82gxm17iPpBSFWE2nEtfrdD41L1DMVqiZvKRw0uImN57K5/RVtjWu4QidhT+/
         qZfA==
X-Gm-Message-State: AOJu0Yww93nseE3mEUc5s8quAqAg2mdnIhvW++qpQSVT/dxypzkPo5zo
	omRGtuzA/AG49kH1vrfAKITzTV0aSXPnFkHA8NZLYNU5VWJFhV0tE8brZwUUb5XWwJ5atdHhBg=
	=
X-Google-Smtp-Source: AGHT+IHCyP4IoqlcDxNTDlmIlfwEjZNFju0cobcumYETAExfBlb7/GHCab1JzpZ/nMQ3mxmWwEU6aIlU
X-Received: from wmbz25.prod.google.com ([2002:a05:600c:c099:b0:477:1449:b093])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4e43:b0:477:e66:406e
 with SMTP id 5b1f17b1804b1-4773088be60mr32292295e9.29.1761907197646; Fri, 31
 Oct 2025 03:39:57 -0700 (PDT)
Date: Fri, 31 Oct 2025 11:39:11 +0100
In-Reply-To: <20251031103858.529530-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251031103858.529530-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2613; i=ardb@kernel.org;
 h=from:subject; bh=yue2NgA2zOFgSdHmsGEDM3WvkPWdV3V1tFnMJXN62q8=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIZNl4pXDLztqpIo6hLcsd73t7SATYpg2w/73MaM52isPZ
 9sdCFrbUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACayZCLD/+hF9jw8SjcfLluw
 8djdsI+hFpuVv2Ue7+59fDNvX+yWHa8Z/vvtjXpyx0itOtrFvyVh5VYhrwPVWY/3XEn/972AqXr +Gx4A
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251031103858.529530-35-ardb+git@google.com>
Subject: [PATCH v4 12/21] crypto/arm64: aes-gcm - Switch to 'ksimd' scoped
 guard API
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	herbert@gondor.apana.org.au, ebiggers@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Switch to the more abstract 'scoped_ksimd()' API, which will be modified
in a future patch to transparently allocate a kernel mode FP/SIMD state
buffer on the stack, so that kernel mode FP/SIMD code remains
preemptible in principe, but without the memory overhead that adds 528
bytes to the size of struct task_struct.

Reviewed-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/crypto/ghash-ce-glue.c | 27 ++++++++++----------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/crypto/ghash-ce-glue.c b/arch/arm64/crypto/ghash-ce-glue.c
index 4995b6e22335..7951557a285a 100644
--- a/arch/arm64/crypto/ghash-ce-glue.c
+++ b/arch/arm64/crypto/ghash-ce-glue.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2014 - 2018 Linaro Ltd. <ard.biesheuvel@linaro.org>
  */
 
-#include <asm/neon.h>
 #include <crypto/aes.h>
 #include <crypto/b128ops.h>
 #include <crypto/gcm.h>
@@ -22,6 +21,8 @@
 #include <linux/string.h>
 #include <linux/unaligned.h>
 
+#include <asm/simd.h>
+
 MODULE_DESCRIPTION("GHASH and AES-GCM using ARMv8 Crypto Extensions");
 MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
 MODULE_LICENSE("GPL v2");
@@ -74,9 +75,8 @@ void ghash_do_simd_update(int blocks, u64 dg[], const char *src,
 					      u64 const h[][2],
 					      const char *head))
 {
-	kernel_neon_begin();
-	simd_update(blocks, dg, src, key->h, head);
-	kernel_neon_end();
+	scoped_ksimd()
+		simd_update(blocks, dg, src, key->h, head);
 }
 
 /* avoid hogging the CPU for too long */
@@ -329,11 +329,10 @@ static int gcm_encrypt(struct aead_request *req, char *iv, int assoclen)
 			tag = NULL;
 		}
 
-		kernel_neon_begin();
-		pmull_gcm_encrypt(nbytes, dst, src, ctx->ghash_key.h,
-				  dg, iv, ctx->aes_key.key_enc, nrounds,
-				  tag);
-		kernel_neon_end();
+		scoped_ksimd()
+			pmull_gcm_encrypt(nbytes, dst, src, ctx->ghash_key.h,
+					  dg, iv, ctx->aes_key.key_enc, nrounds,
+					  tag);
 
 		if (unlikely(!nbytes))
 			break;
@@ -399,11 +398,11 @@ static int gcm_decrypt(struct aead_request *req, char *iv, int assoclen)
 			tag = NULL;
 		}
 
-		kernel_neon_begin();
-		ret = pmull_gcm_decrypt(nbytes, dst, src, ctx->ghash_key.h,
-					dg, iv, ctx->aes_key.key_enc,
-					nrounds, tag, otag, authsize);
-		kernel_neon_end();
+		scoped_ksimd()
+			ret = pmull_gcm_decrypt(nbytes, dst, src,
+						ctx->ghash_key.h,
+						dg, iv, ctx->aes_key.key_enc,
+						nrounds, tag, otag, authsize);
 
 		if (unlikely(!nbytes))
 			break;
-- 
2.51.1.930.gacf6e81ea2-goog



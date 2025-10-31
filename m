Return-Path: <linux-kernel+bounces-879973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE248C248B0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F9B4464D18
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29D234405F;
	Fri, 31 Oct 2025 10:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dMc2SK5J"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5165B342144
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761907195; cv=none; b=sVqB2NxaH6BkXMKGnM/jfp4/41gdFpK08xd+wCrYH5lssaNoFSEV5rKV6xxo4v2bQtlSXLSzCbPDL4vpP83VkwkRA/tYrpyY/Yx0ba9jBcoflew3UN4REGuVGHkrpx2r3lGghKHlG0BNMSUlcnQftzwV7Qqd2pxPzFBaYzzDrOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761907195; c=relaxed/simple;
	bh=vUXH7DcR4nX0nxx2PrHhmTkIgCH0oDmfEkfMRuToev4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QMoXEChpQ4zlGA1jkz1eM/+lqaJwgISiWYAVUtGBw0G+zKnG4h58VPuU+6ySjqihD+u3iTZnefPkBkAVAqIQ6f4zevrKr1FtTAJI32TNw8dNiE9c5m15nIvosBO9qMOtre3uHSrJvonDE6tb74qyK0nigccY2tD7jvboZHVjQ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dMc2SK5J; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-4298da9effcso2007652f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761907192; x=1762511992; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1zhuLLYlhoehauqY+PeyFZRU+wyZ+pjJLV9U014lhCY=;
        b=dMc2SK5JD4iYpHh9zw35kjvENtOANH+G1130Zj8dizM96rB6KyPmjj/FU6FMhpYpGs
         wvbhm9EpHomMbrRxHUSNnqCI+fImjIqi7EvTUPzceSK4WPNFTqPLtKCrGyXuUUwlsbha
         isjoNZsSVlDXehMyztsbQdD9i79mn9nplTI8BKRFBEH1pZnLrQLPCEKI4M9hcHyUeYeE
         h9Mdi7WLNPlQHO5Z6yVnIRQlMCXL34hoPit+3IulddAHZTBTCiDyEqyEb0+fTQsg/swg
         pEzAH5EpuZwXcT5u6qBdnzoh1P7rECdPnXndeM21h1+aQPIUVx6dEgWjl19DS/wXWrTt
         c5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761907192; x=1762511992;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1zhuLLYlhoehauqY+PeyFZRU+wyZ+pjJLV9U014lhCY=;
        b=Af2FUDubl1yma6zXB4s5uF8ur8lKTQEIrWE12IZEjzzMyO591OkMx35f1zc0Rbepa4
         p2LOXdx/zupkmysU56DWbjeG+Fq221nuS0dCJjbWo8NnNsYDI0DKH6QKet6CxC6et5GD
         Fo7EPYiDNu5we2Jwp1hSP3y21ZR26kuDfeffGlRRHTJsqM+sIW1xpLLiI6Zvdd0KKjM9
         uEtmAANMtXKWegzn3lOV2jW0igsJ8tCJfyuMM8wV5KO/recw939y0KYo8BFmK1CuhHpM
         3estF4dbgmsahjElAMb5Muy1LHZl/JvMhDjcmLAS/YES6HGARBxc6gtlILUtjzMbIe3q
         c53w==
X-Gm-Message-State: AOJu0YwDzrYp9o8TU6y6aVeT+zgisoahRCAqOv0LsgMESrvmZqBKq3BV
	39YOkxDOYgwq9oo2ItR06DID5SPlu8SISpyYOzmnYeHoEaskuVpeVQhqu46Jvl+NpKoWR6fmpA=
	=
X-Google-Smtp-Source: AGHT+IG6mde3U+6HS4EOdxS/vl1RSdlu3ot1nl7+xIt1bPeQcqvsk9Gp/rEaM6G2Vof1hCgp+HjwgorY
X-Received: from wmwd10.prod.google.com ([2002:a05:600d:62ea:b0:475:df4b:95a9])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:1aca:b0:428:3c66:a016
 with SMTP id ffacd0b85a97d-429bd6ada02mr2121666f8f.30.1761907191819; Fri, 31
 Oct 2025 03:39:51 -0700 (PDT)
Date: Fri, 31 Oct 2025 11:39:05 +0100
In-Reply-To: <20251031103858.529530-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251031103858.529530-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2508; i=ardb@kernel.org;
 h=from:subject; bh=u5CQYJMAl0uvqTErnR5m9YSNYVrAtGuRx032f0bmEYY=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIZNl4pk+g01R4vvZplxhs3o/+6dfHc/NXfrTjWIU/s+tS
 lKyNlzdUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACaioszwP+bq49duhVzc05/o
 6NkGR2xf1dcgcuPS8osTiyUCo/03+zL8M2EzWHp57e95q5cvNfibOWFVobTthIJoz1VHZ+tu87J U4QYA
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251031103858.529530-29-ardb+git@google.com>
Subject: [PATCH v4 06/21] crypto: aegis128-neon - Move to more abstract
 'ksimd' guard API
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	herbert@gondor.apana.org.au, ebiggers@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Move away from calling kernel_neon_begin() and kernel_neon_end()
directly, and instead, use the newly introduced scoped_ksimd() API. This
permits arm64 to modify the kernel mode NEON API without affecting code
that is shared between ARM and arm64.

Reviewed-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 crypto/aegis128-neon.c | 33 +++++++-------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/crypto/aegis128-neon.c b/crypto/aegis128-neon.c
index 9ee50549e823..b41807e63bd3 100644
--- a/crypto/aegis128-neon.c
+++ b/crypto/aegis128-neon.c
@@ -4,7 +4,7 @@
  */
 
 #include <asm/cpufeature.h>
-#include <asm/neon.h>
+#include <asm/simd.h>
 
 #include "aegis.h"
 #include "aegis-neon.h"
@@ -24,32 +24,28 @@ void crypto_aegis128_init_simd(struct aegis_state *state,
 			       const union aegis_block *key,
 			       const u8 *iv)
 {
-	kernel_neon_begin();
-	crypto_aegis128_init_neon(state, key, iv);
-	kernel_neon_end();
+	scoped_ksimd()
+		crypto_aegis128_init_neon(state, key, iv);
 }
 
 void crypto_aegis128_update_simd(struct aegis_state *state, const void *msg)
 {
-	kernel_neon_begin();
-	crypto_aegis128_update_neon(state, msg);
-	kernel_neon_end();
+	scoped_ksimd()
+		crypto_aegis128_update_neon(state, msg);
 }
 
 void crypto_aegis128_encrypt_chunk_simd(struct aegis_state *state, u8 *dst,
 					const u8 *src, unsigned int size)
 {
-	kernel_neon_begin();
-	crypto_aegis128_encrypt_chunk_neon(state, dst, src, size);
-	kernel_neon_end();
+	scoped_ksimd()
+		crypto_aegis128_encrypt_chunk_neon(state, dst, src, size);
 }
 
 void crypto_aegis128_decrypt_chunk_simd(struct aegis_state *state, u8 *dst,
 					const u8 *src, unsigned int size)
 {
-	kernel_neon_begin();
-	crypto_aegis128_decrypt_chunk_neon(state, dst, src, size);
-	kernel_neon_end();
+	scoped_ksimd()
+		crypto_aegis128_decrypt_chunk_neon(state, dst, src, size);
 }
 
 int crypto_aegis128_final_simd(struct aegis_state *state,
@@ -58,12 +54,7 @@ int crypto_aegis128_final_simd(struct aegis_state *state,
 			       unsigned int cryptlen,
 			       unsigned int authsize)
 {
-	int ret;
-
-	kernel_neon_begin();
-	ret = crypto_aegis128_final_neon(state, tag_xor, assoclen, cryptlen,
-					 authsize);
-	kernel_neon_end();
-
-	return ret;
+	scoped_ksimd()
+		return crypto_aegis128_final_neon(state, tag_xor, assoclen,
+						  cryptlen, authsize);
 }
-- 
2.51.1.930.gacf6e81ea2-goog



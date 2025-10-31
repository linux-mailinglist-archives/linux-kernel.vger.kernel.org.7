Return-Path: <linux-kernel+bounces-879979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78785C248C8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18AF41A2071D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D23E346FB4;
	Fri, 31 Oct 2025 10:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xJSWJmoi"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE3233BBA0
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761907201; cv=none; b=nX5Y2MFUMq8FL3zBsOC5W9x7iHwituSKZYwPCS02F16ANLJWgapKy+1VhnGMntQMUB1CVBVHcYLsOHDRyi0/9BtDK59PxsdSakAdcbFEsIvPkY3TeGjE08AWctspaKp5pgToNxooBvDHiGX4jOHo0fmG6hHSsqLF7CMeQeIG1EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761907201; c=relaxed/simple;
	bh=LJep+y4ATnNVUskfDNp0lQuGBZD2EP4g979aUfeXIPk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZH7A8XMTcpkTCq1zcujpsqNAkqxBwz3kGxAZ66HmUvAv0YB4n9E7PfpcqGZ/43ZBR1mnRd+fWasg3jyWcvX5E9JXp2UgJtCgbuTQv8LwUeKyX+Mdw+kg4WvWGRcg0Sor6n3Znm5yDL3xd8/C+cp1ir7av51REbTZhOdu0MDUJ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xJSWJmoi; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-429c2f6a5adso132254f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761907197; x=1762511997; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vW/4HMHRiwaJ6EVSFpt6OOUDjFOC/wmRBK5AoFPty4Y=;
        b=xJSWJmoicoxZsHSIvNqa/BNqq7L7ZItZ3HOABbn2wo5Q0V0aPY9G53HwOeWTuVFlz6
         wGtTNR28YXkGepbFABYhpOzoIXJUVAYLYcCy1rHbGDy08siTnFxpJCnp1wumHHsEJLXW
         dDczrrOqqanI4do2rUzZKwavLIoFbL+uFsHsEu6wL+GlXVxIT8HGiTW+yrf1aEGQaNSM
         QWI0Xc5QNIMDmDWoQZBufqX6OftJxiDLmDnglSiDSjzDtZCZjP4n7UnPoa0gcdRVXXRY
         eHJqRJo4lLhZmXjswF+w6zOz8YOxYf5FjrZtRhmLGiJJgEROfnVhtMLZ2hZ4PkLvcl4x
         +X+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761907197; x=1762511997;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vW/4HMHRiwaJ6EVSFpt6OOUDjFOC/wmRBK5AoFPty4Y=;
        b=m7qoVTqpwAAJiKdiobIQisPnF/54NmlE4Ca9Xj7IEFQ9kMXIbTSZkaJSkMdV0P7Y7c
         ovvDzc+S65P3D9NMw9QoZ301Ca/zsXC3UTurjPalm8//HnJA+ZX5vMuAiLzTkbNZ0J3P
         9C2iqd2nwioixWMgljlwYrnJ+pqT3iQnFhM2uixQMqT6Jz7G0fop+p+ETaZP6hzXJ+g6
         rX/3uEuOK6uYgb1Cr6liBZS4GCmaWV64VUMBtQw0JfERNoK3EIDlw1hpGweYQbdd16NX
         z2hFG+TFH4+dKmHbKgMCqgw5/N8AdJ0t2R+Iip1Hr0SyKlrobznDMLxfGjFwQfEoQf9U
         R+GA==
X-Gm-Message-State: AOJu0YxLUttQmCCMMZZxAoy2yhsqVKp9nt61S4gY9sytSYSVG7FOwILn
	10AfIFSrAnFy5mP06DEEZwd5LZN6qlGz7e3X0Mi2Q3sQCQ06y/AuJbG4oZ6z/tZC0bVzU7BFkg=
	=
X-Google-Smtp-Source: AGHT+IGpykGfTzt+UMgehQVa+X/CIbWFhM4CD7YwyHd7ft0MjQCcnZ1F4YBYBw/qaiFCQGs74a7PjyhA
X-Received: from wrsz9.prod.google.com ([2002:a5d:4c89:0:b0:427:53e:a421])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2005:b0:428:4354:aa27
 with SMTP id ffacd0b85a97d-429bd6a8df9mr2532656f8f.46.1761907196795; Fri, 31
 Oct 2025 03:39:56 -0700 (PDT)
Date: Fri, 31 Oct 2025 11:39:10 +0100
In-Reply-To: <20251031103858.529530-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251031103858.529530-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=20750; i=ardb@kernel.org;
 h=from:subject; bh=GyvDP6RYmRurKRktBsz1r+elH0Fzi+2wFgZdad4GjgQ=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIZNl4uVdDmeN3vy/c4SPaV/1nBkhITkMEpqJV3WUHPSyk
 t6aLjzaUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbi58Pwz6xu0qz1tkULOlkS
 H+rOqlcx637eMuuxWAtffMin/XxWGxj+aaj94Qg+e+RdZ2zVId6Ac1uqn3To2M3/02Zvs6dyo+F iRgA=
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251031103858.529530-34-ardb+git@google.com>
Subject: [PATCH v4 11/21] crypto/arm64: aes-blk - Switch to 'ksimd' scoped
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
 arch/arm64/crypto/aes-ce-glue.c     |  87 ++++++------
 arch/arm64/crypto/aes-glue.c        | 139 ++++++++----------
 arch/arm64/crypto/aes-neonbs-glue.c | 150 ++++++++++----------
 3 files changed, 181 insertions(+), 195 deletions(-)

diff --git a/arch/arm64/crypto/aes-ce-glue.c b/arch/arm64/crypto/aes-ce-glue.c
index 00b8749013c5..a4dad370991d 100644
--- a/arch/arm64/crypto/aes-ce-glue.c
+++ b/arch/arm64/crypto/aes-ce-glue.c
@@ -52,9 +52,8 @@ static void aes_cipher_encrypt(struct crypto_tfm *tfm, u8 dst[], u8 const src[])
 		return;
 	}
 
-	kernel_neon_begin();
-	__aes_ce_encrypt(ctx->key_enc, dst, src, num_rounds(ctx));
-	kernel_neon_end();
+	scoped_ksimd()
+		__aes_ce_encrypt(ctx->key_enc, dst, src, num_rounds(ctx));
 }
 
 static void aes_cipher_decrypt(struct crypto_tfm *tfm, u8 dst[], u8 const src[])
@@ -66,9 +65,8 @@ static void aes_cipher_decrypt(struct crypto_tfm *tfm, u8 dst[], u8 const src[])
 		return;
 	}
 
-	kernel_neon_begin();
-	__aes_ce_decrypt(ctx->key_dec, dst, src, num_rounds(ctx));
-	kernel_neon_end();
+	scoped_ksimd()
+		__aes_ce_decrypt(ctx->key_dec, dst, src, num_rounds(ctx));
 }
 
 int ce_aes_expandkey(struct crypto_aes_ctx *ctx, const u8 *in_key,
@@ -94,47 +92,48 @@ int ce_aes_expandkey(struct crypto_aes_ctx *ctx, const u8 *in_key,
 	for (i = 0; i < kwords; i++)
 		ctx->key_enc[i] = get_unaligned_le32(in_key + i * sizeof(u32));
 
-	kernel_neon_begin();
-	for (i = 0; i < sizeof(rcon); i++) {
-		u32 *rki = ctx->key_enc + (i * kwords);
-		u32 *rko = rki + kwords;
-
-		rko[0] = ror32(__aes_ce_sub(rki[kwords - 1]), 8) ^ rcon[i] ^ rki[0];
-		rko[1] = rko[0] ^ rki[1];
-		rko[2] = rko[1] ^ rki[2];
-		rko[3] = rko[2] ^ rki[3];
-
-		if (key_len == AES_KEYSIZE_192) {
-			if (i >= 7)
-				break;
-			rko[4] = rko[3] ^ rki[4];
-			rko[5] = rko[4] ^ rki[5];
-		} else if (key_len == AES_KEYSIZE_256) {
-			if (i >= 6)
-				break;
-			rko[4] = __aes_ce_sub(rko[3]) ^ rki[4];
-			rko[5] = rko[4] ^ rki[5];
-			rko[6] = rko[5] ^ rki[6];
-			rko[7] = rko[6] ^ rki[7];
+	scoped_ksimd() {
+		for (i = 0; i < sizeof(rcon); i++) {
+			u32 *rki = ctx->key_enc + (i * kwords);
+			u32 *rko = rki + kwords;
+
+			rko[0] = ror32(__aes_ce_sub(rki[kwords - 1]), 8) ^
+				 rcon[i] ^ rki[0];
+			rko[1] = rko[0] ^ rki[1];
+			rko[2] = rko[1] ^ rki[2];
+			rko[3] = rko[2] ^ rki[3];
+
+			if (key_len == AES_KEYSIZE_192) {
+				if (i >= 7)
+					break;
+				rko[4] = rko[3] ^ rki[4];
+				rko[5] = rko[4] ^ rki[5];
+			} else if (key_len == AES_KEYSIZE_256) {
+				if (i >= 6)
+					break;
+				rko[4] = __aes_ce_sub(rko[3]) ^ rki[4];
+				rko[5] = rko[4] ^ rki[5];
+				rko[6] = rko[5] ^ rki[6];
+				rko[7] = rko[6] ^ rki[7];
+			}
 		}
-	}
 
-	/*
-	 * Generate the decryption keys for the Equivalent Inverse Cipher.
-	 * This involves reversing the order of the round keys, and applying
-	 * the Inverse Mix Columns transformation on all but the first and
-	 * the last one.
-	 */
-	key_enc = (struct aes_block *)ctx->key_enc;
-	key_dec = (struct aes_block *)ctx->key_dec;
-	j = num_rounds(ctx);
-
-	key_dec[0] = key_enc[j];
-	for (i = 1, j--; j > 0; i++, j--)
-		__aes_ce_invert(key_dec + i, key_enc + j);
-	key_dec[i] = key_enc[0];
+		/*
+		 * Generate the decryption keys for the Equivalent Inverse
+		 * Cipher.  This involves reversing the order of the round
+		 * keys, and applying the Inverse Mix Columns transformation on
+		 * all but the first and the last one.
+		 */
+		key_enc = (struct aes_block *)ctx->key_enc;
+		key_dec = (struct aes_block *)ctx->key_dec;
+		j = num_rounds(ctx);
+
+		key_dec[0] = key_enc[j];
+		for (i = 1, j--; j > 0; i++, j--)
+			__aes_ce_invert(key_dec + i, key_enc + j);
+		key_dec[i] = key_enc[0];
+	}
 
-	kernel_neon_end();
 	return 0;
 }
 EXPORT_SYMBOL(ce_aes_expandkey);
diff --git a/arch/arm64/crypto/aes-glue.c b/arch/arm64/crypto/aes-glue.c
index 5e207ff34482..b087b900d279 100644
--- a/arch/arm64/crypto/aes-glue.c
+++ b/arch/arm64/crypto/aes-glue.c
@@ -5,8 +5,6 @@
  * Copyright (C) 2013 - 2017 Linaro Ltd <ard.biesheuvel@linaro.org>
  */
 
-#include <asm/hwcap.h>
-#include <asm/neon.h>
 #include <crypto/aes.h>
 #include <crypto/ctr.h>
 #include <crypto/internal/hash.h>
@@ -20,6 +18,9 @@
 #include <linux/module.h>
 #include <linux/string.h>
 
+#include <asm/hwcap.h>
+#include <asm/simd.h>
+
 #include "aes-ce-setkey.h"
 
 #ifdef USE_V8_CRYPTO_EXTENSIONS
@@ -186,10 +187,9 @@ static int __maybe_unused ecb_encrypt(struct skcipher_request *req)
 	err = skcipher_walk_virt(&walk, req, false);
 
 	while ((blocks = (walk.nbytes / AES_BLOCK_SIZE))) {
-		kernel_neon_begin();
-		aes_ecb_encrypt(walk.dst.virt.addr, walk.src.virt.addr,
-				ctx->key_enc, rounds, blocks);
-		kernel_neon_end();
+		scoped_ksimd()
+			aes_ecb_encrypt(walk.dst.virt.addr, walk.src.virt.addr,
+					ctx->key_enc, rounds, blocks);
 		err = skcipher_walk_done(&walk, walk.nbytes % AES_BLOCK_SIZE);
 	}
 	return err;
@@ -206,10 +206,9 @@ static int __maybe_unused ecb_decrypt(struct skcipher_request *req)
 	err = skcipher_walk_virt(&walk, req, false);
 
 	while ((blocks = (walk.nbytes / AES_BLOCK_SIZE))) {
-		kernel_neon_begin();
-		aes_ecb_decrypt(walk.dst.virt.addr, walk.src.virt.addr,
-				ctx->key_dec, rounds, blocks);
-		kernel_neon_end();
+		scoped_ksimd()
+			aes_ecb_decrypt(walk.dst.virt.addr, walk.src.virt.addr,
+					ctx->key_dec, rounds, blocks);
 		err = skcipher_walk_done(&walk, walk.nbytes % AES_BLOCK_SIZE);
 	}
 	return err;
@@ -224,10 +223,9 @@ static int cbc_encrypt_walk(struct skcipher_request *req,
 	unsigned int blocks;
 
 	while ((blocks = (walk->nbytes / AES_BLOCK_SIZE))) {
-		kernel_neon_begin();
-		aes_cbc_encrypt(walk->dst.virt.addr, walk->src.virt.addr,
-				ctx->key_enc, rounds, blocks, walk->iv);
-		kernel_neon_end();
+		scoped_ksimd()
+			aes_cbc_encrypt(walk->dst.virt.addr, walk->src.virt.addr,
+					ctx->key_enc, rounds, blocks, walk->iv);
 		err = skcipher_walk_done(walk, walk->nbytes % AES_BLOCK_SIZE);
 	}
 	return err;
@@ -253,10 +251,9 @@ static int cbc_decrypt_walk(struct skcipher_request *req,
 	unsigned int blocks;
 
 	while ((blocks = (walk->nbytes / AES_BLOCK_SIZE))) {
-		kernel_neon_begin();
-		aes_cbc_decrypt(walk->dst.virt.addr, walk->src.virt.addr,
-				ctx->key_dec, rounds, blocks, walk->iv);
-		kernel_neon_end();
+		scoped_ksimd()
+			aes_cbc_decrypt(walk->dst.virt.addr, walk->src.virt.addr,
+					ctx->key_dec, rounds, blocks, walk->iv);
 		err = skcipher_walk_done(walk, walk->nbytes % AES_BLOCK_SIZE);
 	}
 	return err;
@@ -322,10 +319,9 @@ static int cts_cbc_encrypt(struct skcipher_request *req)
 	if (err)
 		return err;
 
-	kernel_neon_begin();
-	aes_cbc_cts_encrypt(walk.dst.virt.addr, walk.src.virt.addr,
-			    ctx->key_enc, rounds, walk.nbytes, walk.iv);
-	kernel_neon_end();
+	scoped_ksimd()
+		aes_cbc_cts_encrypt(walk.dst.virt.addr, walk.src.virt.addr,
+				    ctx->key_enc, rounds, walk.nbytes, walk.iv);
 
 	return skcipher_walk_done(&walk, 0);
 }
@@ -379,10 +375,9 @@ static int cts_cbc_decrypt(struct skcipher_request *req)
 	if (err)
 		return err;
 
-	kernel_neon_begin();
-	aes_cbc_cts_decrypt(walk.dst.virt.addr, walk.src.virt.addr,
-			    ctx->key_dec, rounds, walk.nbytes, walk.iv);
-	kernel_neon_end();
+	scoped_ksimd()
+		aes_cbc_cts_decrypt(walk.dst.virt.addr, walk.src.virt.addr,
+				    ctx->key_dec, rounds, walk.nbytes, walk.iv);
 
 	return skcipher_walk_done(&walk, 0);
 }
@@ -399,11 +394,11 @@ static int __maybe_unused essiv_cbc_encrypt(struct skcipher_request *req)
 
 	blocks = walk.nbytes / AES_BLOCK_SIZE;
 	if (blocks) {
-		kernel_neon_begin();
-		aes_essiv_cbc_encrypt(walk.dst.virt.addr, walk.src.virt.addr,
-				      ctx->key1.key_enc, rounds, blocks,
-				      req->iv, ctx->key2.key_enc);
-		kernel_neon_end();
+		scoped_ksimd()
+			aes_essiv_cbc_encrypt(walk.dst.virt.addr,
+					      walk.src.virt.addr,
+					      ctx->key1.key_enc, rounds, blocks,
+					      req->iv, ctx->key2.key_enc);
 		err = skcipher_walk_done(&walk, walk.nbytes % AES_BLOCK_SIZE);
 	}
 	return err ?: cbc_encrypt_walk(req, &walk);
@@ -421,11 +416,11 @@ static int __maybe_unused essiv_cbc_decrypt(struct skcipher_request *req)
 
 	blocks = walk.nbytes / AES_BLOCK_SIZE;
 	if (blocks) {
-		kernel_neon_begin();
-		aes_essiv_cbc_decrypt(walk.dst.virt.addr, walk.src.virt.addr,
-				      ctx->key1.key_dec, rounds, blocks,
-				      req->iv, ctx->key2.key_enc);
-		kernel_neon_end();
+		scoped_ksimd()
+			aes_essiv_cbc_decrypt(walk.dst.virt.addr,
+					      walk.src.virt.addr,
+					      ctx->key1.key_dec, rounds, blocks,
+					      req->iv, ctx->key2.key_enc);
 		err = skcipher_walk_done(&walk, walk.nbytes % AES_BLOCK_SIZE);
 	}
 	return err ?: cbc_decrypt_walk(req, &walk);
@@ -461,10 +456,9 @@ static int __maybe_unused xctr_encrypt(struct skcipher_request *req)
 		else if (nbytes < walk.total)
 			nbytes &= ~(AES_BLOCK_SIZE - 1);
 
-		kernel_neon_begin();
-		aes_xctr_encrypt(dst, src, ctx->key_enc, rounds, nbytes,
-						 walk.iv, byte_ctr);
-		kernel_neon_end();
+		scoped_ksimd()
+			aes_xctr_encrypt(dst, src, ctx->key_enc, rounds, nbytes,
+							 walk.iv, byte_ctr);
 
 		if (unlikely(nbytes < AES_BLOCK_SIZE))
 			memcpy(walk.dst.virt.addr,
@@ -506,10 +500,9 @@ static int __maybe_unused ctr_encrypt(struct skcipher_request *req)
 		else if (nbytes < walk.total)
 			nbytes &= ~(AES_BLOCK_SIZE - 1);
 
-		kernel_neon_begin();
-		aes_ctr_encrypt(dst, src, ctx->key_enc, rounds, nbytes,
-				walk.iv);
-		kernel_neon_end();
+		scoped_ksimd()
+			aes_ctr_encrypt(dst, src, ctx->key_enc, rounds, nbytes,
+					walk.iv);
 
 		if (unlikely(nbytes < AES_BLOCK_SIZE))
 			memcpy(walk.dst.virt.addr,
@@ -562,11 +555,10 @@ static int __maybe_unused xts_encrypt(struct skcipher_request *req)
 		if (walk.nbytes < walk.total)
 			nbytes &= ~(AES_BLOCK_SIZE - 1);
 
-		kernel_neon_begin();
-		aes_xts_encrypt(walk.dst.virt.addr, walk.src.virt.addr,
-				ctx->key1.key_enc, rounds, nbytes,
-				ctx->key2.key_enc, walk.iv, first);
-		kernel_neon_end();
+		scoped_ksimd()
+			aes_xts_encrypt(walk.dst.virt.addr, walk.src.virt.addr,
+					ctx->key1.key_enc, rounds, nbytes,
+					ctx->key2.key_enc, walk.iv, first);
 		err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
 	}
 
@@ -584,11 +576,10 @@ static int __maybe_unused xts_encrypt(struct skcipher_request *req)
 	if (err)
 		return err;
 
-	kernel_neon_begin();
-	aes_xts_encrypt(walk.dst.virt.addr, walk.src.virt.addr,
-			ctx->key1.key_enc, rounds, walk.nbytes,
-			ctx->key2.key_enc, walk.iv, first);
-	kernel_neon_end();
+	scoped_ksimd()
+		aes_xts_encrypt(walk.dst.virt.addr, walk.src.virt.addr,
+				ctx->key1.key_enc, rounds, walk.nbytes,
+				ctx->key2.key_enc, walk.iv, first);
 
 	return skcipher_walk_done(&walk, 0);
 }
@@ -634,11 +625,10 @@ static int __maybe_unused xts_decrypt(struct skcipher_request *req)
 		if (walk.nbytes < walk.total)
 			nbytes &= ~(AES_BLOCK_SIZE - 1);
 
-		kernel_neon_begin();
-		aes_xts_decrypt(walk.dst.virt.addr, walk.src.virt.addr,
-				ctx->key1.key_dec, rounds, nbytes,
-				ctx->key2.key_enc, walk.iv, first);
-		kernel_neon_end();
+		scoped_ksimd()
+			aes_xts_decrypt(walk.dst.virt.addr, walk.src.virt.addr,
+					ctx->key1.key_dec, rounds, nbytes,
+					ctx->key2.key_enc, walk.iv, first);
 		err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
 	}
 
@@ -657,11 +647,10 @@ static int __maybe_unused xts_decrypt(struct skcipher_request *req)
 		return err;
 
 
-	kernel_neon_begin();
-	aes_xts_decrypt(walk.dst.virt.addr, walk.src.virt.addr,
-			ctx->key1.key_dec, rounds, walk.nbytes,
-			ctx->key2.key_enc, walk.iv, first);
-	kernel_neon_end();
+	scoped_ksimd()
+		aes_xts_decrypt(walk.dst.virt.addr, walk.src.virt.addr,
+				ctx->key1.key_dec, rounds, walk.nbytes,
+				ctx->key2.key_enc, walk.iv, first);
 
 	return skcipher_walk_done(&walk, 0);
 }
@@ -808,10 +797,9 @@ static int cmac_setkey(struct crypto_shash *tfm, const u8 *in_key,
 		return err;
 
 	/* encrypt the zero vector */
-	kernel_neon_begin();
-	aes_ecb_encrypt(ctx->consts, (u8[AES_BLOCK_SIZE]){}, ctx->key.key_enc,
-			rounds, 1);
-	kernel_neon_end();
+	scoped_ksimd()
+		aes_ecb_encrypt(ctx->consts, (u8[AES_BLOCK_SIZE]){},
+				ctx->key.key_enc, rounds, 1);
 
 	cmac_gf128_mul_by_x(consts, consts);
 	cmac_gf128_mul_by_x(consts + 1, consts);
@@ -837,10 +825,10 @@ static int xcbc_setkey(struct crypto_shash *tfm, const u8 *in_key,
 	if (err)
 		return err;
 
-	kernel_neon_begin();
-	aes_ecb_encrypt(key, ks[0], ctx->key.key_enc, rounds, 1);
-	aes_ecb_encrypt(ctx->consts, ks[1], ctx->key.key_enc, rounds, 2);
-	kernel_neon_end();
+	scoped_ksimd() {
+		aes_ecb_encrypt(key, ks[0], ctx->key.key_enc, rounds, 1);
+		aes_ecb_encrypt(ctx->consts, ks[1], ctx->key.key_enc, rounds, 2);
+	}
 
 	return cbcmac_setkey(tfm, key, sizeof(key));
 }
@@ -860,10 +848,9 @@ static void mac_do_update(struct crypto_aes_ctx *ctx, u8 const in[], int blocks,
 	int rem;
 
 	do {
-		kernel_neon_begin();
-		rem = aes_mac_update(in, ctx->key_enc, rounds, blocks,
-				     dg, enc_before, !enc_before);
-		kernel_neon_end();
+		scoped_ksimd()
+			rem = aes_mac_update(in, ctx->key_enc, rounds, blocks,
+					     dg, enc_before, !enc_before);
 		in += (blocks - rem) * AES_BLOCK_SIZE;
 		blocks = rem;
 	} while (blocks);
diff --git a/arch/arm64/crypto/aes-neonbs-glue.c b/arch/arm64/crypto/aes-neonbs-glue.c
index c4a623e86593..d496effb0a5b 100644
--- a/arch/arm64/crypto/aes-neonbs-glue.c
+++ b/arch/arm64/crypto/aes-neonbs-glue.c
@@ -85,9 +85,8 @@ static int aesbs_setkey(struct crypto_skcipher *tfm, const u8 *in_key,
 
 	ctx->rounds = 6 + key_len / 4;
 
-	kernel_neon_begin();
-	aesbs_convert_key(ctx->rk, rk.key_enc, ctx->rounds);
-	kernel_neon_end();
+	scoped_ksimd()
+		aesbs_convert_key(ctx->rk, rk.key_enc, ctx->rounds);
 
 	return 0;
 }
@@ -110,10 +109,9 @@ static int __ecb_crypt(struct skcipher_request *req,
 			blocks = round_down(blocks,
 					    walk.stride / AES_BLOCK_SIZE);
 
-		kernel_neon_begin();
-		fn(walk.dst.virt.addr, walk.src.virt.addr, ctx->rk,
-		   ctx->rounds, blocks);
-		kernel_neon_end();
+		scoped_ksimd()
+			fn(walk.dst.virt.addr, walk.src.virt.addr, ctx->rk,
+			   ctx->rounds, blocks);
 		err = skcipher_walk_done(&walk,
 					 walk.nbytes - blocks * AES_BLOCK_SIZE);
 	}
@@ -146,9 +144,8 @@ static int aesbs_cbc_ctr_setkey(struct crypto_skcipher *tfm, const u8 *in_key,
 
 	memcpy(ctx->enc, rk.key_enc, sizeof(ctx->enc));
 
-	kernel_neon_begin();
-	aesbs_convert_key(ctx->key.rk, rk.key_enc, ctx->key.rounds);
-	kernel_neon_end();
+	scoped_ksimd()
+		aesbs_convert_key(ctx->key.rk, rk.key_enc, ctx->key.rounds);
 	memzero_explicit(&rk, sizeof(rk));
 
 	return 0;
@@ -167,11 +164,11 @@ static int cbc_encrypt(struct skcipher_request *req)
 		unsigned int blocks = walk.nbytes / AES_BLOCK_SIZE;
 
 		/* fall back to the non-bitsliced NEON implementation */
-		kernel_neon_begin();
-		neon_aes_cbc_encrypt(walk.dst.virt.addr, walk.src.virt.addr,
-				     ctx->enc, ctx->key.rounds, blocks,
-				     walk.iv);
-		kernel_neon_end();
+		scoped_ksimd()
+			neon_aes_cbc_encrypt(walk.dst.virt.addr,
+					     walk.src.virt.addr,
+					     ctx->enc, ctx->key.rounds, blocks,
+					     walk.iv);
 		err = skcipher_walk_done(&walk, walk.nbytes % AES_BLOCK_SIZE);
 	}
 	return err;
@@ -193,11 +190,10 @@ static int cbc_decrypt(struct skcipher_request *req)
 			blocks = round_down(blocks,
 					    walk.stride / AES_BLOCK_SIZE);
 
-		kernel_neon_begin();
-		aesbs_cbc_decrypt(walk.dst.virt.addr, walk.src.virt.addr,
-				  ctx->key.rk, ctx->key.rounds, blocks,
-				  walk.iv);
-		kernel_neon_end();
+		scoped_ksimd()
+			aesbs_cbc_decrypt(walk.dst.virt.addr, walk.src.virt.addr,
+					  ctx->key.rk, ctx->key.rounds, blocks,
+					  walk.iv);
 		err = skcipher_walk_done(&walk,
 					 walk.nbytes - blocks * AES_BLOCK_SIZE);
 	}
@@ -220,30 +216,32 @@ static int ctr_encrypt(struct skcipher_request *req)
 		const u8 *src = walk.src.virt.addr;
 		u8 *dst = walk.dst.virt.addr;
 
-		kernel_neon_begin();
-		if (blocks >= 8) {
-			aesbs_ctr_encrypt(dst, src, ctx->key.rk, ctx->key.rounds,
-					  blocks, walk.iv);
-			dst += blocks * AES_BLOCK_SIZE;
-			src += blocks * AES_BLOCK_SIZE;
-		}
-		if (nbytes && walk.nbytes == walk.total) {
-			u8 buf[AES_BLOCK_SIZE];
-			u8 *d = dst;
-
-			if (unlikely(nbytes < AES_BLOCK_SIZE))
-				src = dst = memcpy(buf + sizeof(buf) - nbytes,
-						   src, nbytes);
-
-			neon_aes_ctr_encrypt(dst, src, ctx->enc, ctx->key.rounds,
-					     nbytes, walk.iv);
+		scoped_ksimd() {
+			if (blocks >= 8) {
+				aesbs_ctr_encrypt(dst, src, ctx->key.rk,
+						  ctx->key.rounds, blocks,
+						  walk.iv);
+				dst += blocks * AES_BLOCK_SIZE;
+				src += blocks * AES_BLOCK_SIZE;
+			}
+			if (nbytes && walk.nbytes == walk.total) {
+				u8 buf[AES_BLOCK_SIZE];
+				u8 *d = dst;
+
+				if (unlikely(nbytes < AES_BLOCK_SIZE))
+					src = dst = memcpy(buf + sizeof(buf) -
+							   nbytes, src, nbytes);
+
+				neon_aes_ctr_encrypt(dst, src, ctx->enc,
+						     ctx->key.rounds, nbytes,
+						     walk.iv);
 
-			if (unlikely(nbytes < AES_BLOCK_SIZE))
-				memcpy(d, dst, nbytes);
+				if (unlikely(nbytes < AES_BLOCK_SIZE))
+					memcpy(d, dst, nbytes);
 
-			nbytes = 0;
+				nbytes = 0;
+			}
 		}
-		kernel_neon_end();
 		err = skcipher_walk_done(&walk, nbytes);
 	}
 	return err;
@@ -320,33 +318,33 @@ static int __xts_crypt(struct skcipher_request *req, bool encrypt,
 		in = walk.src.virt.addr;
 		nbytes = walk.nbytes;
 
-		kernel_neon_begin();
-		if (blocks >= 8) {
-			if (first == 1)
-				neon_aes_ecb_encrypt(walk.iv, walk.iv,
-						     ctx->twkey,
-						     ctx->key.rounds, 1);
-			first = 2;
-
-			fn(out, in, ctx->key.rk, ctx->key.rounds, blocks,
-			   walk.iv);
-
-			out += blocks * AES_BLOCK_SIZE;
-			in += blocks * AES_BLOCK_SIZE;
-			nbytes -= blocks * AES_BLOCK_SIZE;
+		scoped_ksimd() {
+			if (blocks >= 8) {
+				if (first == 1)
+					neon_aes_ecb_encrypt(walk.iv, walk.iv,
+							     ctx->twkey,
+							     ctx->key.rounds, 1);
+				first = 2;
+
+				fn(out, in, ctx->key.rk, ctx->key.rounds, blocks,
+				   walk.iv);
+
+				out += blocks * AES_BLOCK_SIZE;
+				in += blocks * AES_BLOCK_SIZE;
+				nbytes -= blocks * AES_BLOCK_SIZE;
+			}
+			if (walk.nbytes == walk.total && nbytes > 0) {
+				if (encrypt)
+					neon_aes_xts_encrypt(out, in, ctx->cts.key_enc,
+							     ctx->key.rounds, nbytes,
+							     ctx->twkey, walk.iv, first);
+				else
+					neon_aes_xts_decrypt(out, in, ctx->cts.key_dec,
+							     ctx->key.rounds, nbytes,
+							     ctx->twkey, walk.iv, first);
+				nbytes = first = 0;
+			}
 		}
-		if (walk.nbytes == walk.total && nbytes > 0) {
-			if (encrypt)
-				neon_aes_xts_encrypt(out, in, ctx->cts.key_enc,
-						     ctx->key.rounds, nbytes,
-						     ctx->twkey, walk.iv, first);
-			else
-				neon_aes_xts_decrypt(out, in, ctx->cts.key_dec,
-						     ctx->key.rounds, nbytes,
-						     ctx->twkey, walk.iv, first);
-			nbytes = first = 0;
-		}
-		kernel_neon_end();
 		err = skcipher_walk_done(&walk, nbytes);
 	}
 
@@ -369,14 +367,16 @@ static int __xts_crypt(struct skcipher_request *req, bool encrypt,
 	in = walk.src.virt.addr;
 	nbytes = walk.nbytes;
 
-	kernel_neon_begin();
-	if (encrypt)
-		neon_aes_xts_encrypt(out, in, ctx->cts.key_enc, ctx->key.rounds,
-				     nbytes, ctx->twkey, walk.iv, first);
-	else
-		neon_aes_xts_decrypt(out, in, ctx->cts.key_dec, ctx->key.rounds,
-				     nbytes, ctx->twkey, walk.iv, first);
-	kernel_neon_end();
+	scoped_ksimd() {
+		if (encrypt)
+			neon_aes_xts_encrypt(out, in, ctx->cts.key_enc,
+					     ctx->key.rounds, nbytes, ctx->twkey,
+					     walk.iv, first);
+		else
+			neon_aes_xts_decrypt(out, in, ctx->cts.key_dec,
+					     ctx->key.rounds, nbytes, ctx->twkey,
+					     walk.iv, first);
+	}
 
 	return skcipher_walk_done(&walk, 0);
 }
-- 
2.51.1.930.gacf6e81ea2-goog



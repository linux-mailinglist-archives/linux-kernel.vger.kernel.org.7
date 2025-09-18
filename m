Return-Path: <linux-kernel+bounces-783411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B29B32D4A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 05:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2CC485D35
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 03:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73741E573F;
	Sun, 24 Aug 2025 02:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9Jgwf2d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2964F1E7660;
	Sun, 24 Aug 2025 02:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756004351; cv=none; b=T3pcb1xe1SHRHU9isq+W5vCdBq/SRpNJTQpxYpGhK1Y7jXpsdaVx9ZPG238I5YHVLtytIxiOB/jtGizrL8eodCvqBzrzZKuWwfu2yUksA+6xWmPb/bPhEpMx13m5EXueMu07dP4B2OjD//ybuxb3EXwtGYafc7kboqVQ74HQaHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756004351; c=relaxed/simple;
	bh=6I+Wb/aEB8jPWbBTlpEsierId3E1MIMBuEPA7Zmdpeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpI2cw1nky+44WVcUB04Q79Fle/XM6q1LXRESR/2b0wblX+10lsfmjQbO56WfEI0kJz9v7f4+YqtWRx/XR8qaOKheMUexMwhizDnxHv/LpOC0O7/bqrXcUwFlpYSBWcx06DwlK3ruH1TADvXQrcovMIF+0ruxdLniRssIz+3eX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9Jgwf2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A052C116B1;
	Sun, 24 Aug 2025 02:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756004351;
	bh=6I+Wb/aEB8jPWbBTlpEsierId3E1MIMBuEPA7Zmdpeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q9Jgwf2dahBHK7QB1UlBBmvD09yEwdctfpft608eGK67w1uhxaN/5vIew833kANH+
	 9Q9hDmDrl2M/8RDsIyY0LzIL3sefKEfriTax/r8bD+WGu8f4zCSkxfErYSsgsL6qSh
	 8TdvgJr4HXdZ8qmG58tkliIURL0Q2YlLHkhDYz1oa6Y5pXHAxu8IM9DQ6u7lpNfue3
	 AaZqnYfyHKS7dfb0moTqIaxmYNiK/SrekP5Kb5o0uPefO0GRi0NDQtoN3s+g8jHjGK
	 jkNXACxDF6u1e2ygZAgZOrko1O9/HUsKOSyeOL0JXA7eHEf4t+CtlVY/9Ht6j7ckm7
	 JkYvHGoE2MIDw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Zhihang Shao <zhihang.shao.iscas@gmail.com>,
	Andy Polyakov <appro@cryptogams.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v2 1/3] lib/crypto: poly1305: Remove unused function poly1305_is_arch_optimized()
Date: Sat, 23 Aug 2025 22:57:34 -0400
Message-ID: <20250824025736.148576-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250824025736.148576-1-ebiggers@kernel.org>
References: <20250824025736.148576-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

poly1305_is_arch_optimized() is unused, so remove it.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 include/crypto/poly1305.h              | 9 ---------
 lib/crypto/arm/poly1305-glue.c         | 7 -------
 lib/crypto/arm64/poly1305-glue.c       | 7 -------
 lib/crypto/mips/poly1305-glue.c        | 6 ------
 lib/crypto/powerpc/poly1305-p10-glue.c | 6 ------
 lib/crypto/x86/poly1305_glue.c         | 6 ------
 6 files changed, 41 deletions(-)

diff --git a/include/crypto/poly1305.h b/include/crypto/poly1305.h
index e54abda8cfe95..d4daeec8da19d 100644
--- a/include/crypto/poly1305.h
+++ b/include/crypto/poly1305.h
@@ -62,15 +62,6 @@ void poly1305_init(struct poly1305_desc_ctx *desc,
 		   const u8 key[POLY1305_KEY_SIZE]);
 void poly1305_update(struct poly1305_desc_ctx *desc,
 		     const u8 *src, unsigned int nbytes);
 void poly1305_final(struct poly1305_desc_ctx *desc, u8 *digest);
 
-#if IS_ENABLED(CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305)
-bool poly1305_is_arch_optimized(void);
-#else
-static inline bool poly1305_is_arch_optimized(void)
-{
-	return false;
-}
-#endif
-
 #endif
diff --git a/lib/crypto/arm/poly1305-glue.c b/lib/crypto/arm/poly1305-glue.c
index 2d86c78af8837..9e513e319e37c 100644
--- a/lib/crypto/arm/poly1305-glue.c
+++ b/lib/crypto/arm/poly1305-glue.c
@@ -49,17 +49,10 @@ void poly1305_blocks_arch(struct poly1305_block_state *state, const u8 *src,
 	} else
 		poly1305_blocks_arm(state, src, len, padbit);
 }
 EXPORT_SYMBOL_GPL(poly1305_blocks_arch);
 
-bool poly1305_is_arch_optimized(void)
-{
-	/* We always can use at least the ARM scalar implementation. */
-	return true;
-}
-EXPORT_SYMBOL(poly1305_is_arch_optimized);
-
 static int __init arm_poly1305_mod_init(void)
 {
 	if (IS_ENABLED(CONFIG_KERNEL_MODE_NEON) &&
 	    (elf_hwcap & HWCAP_NEON))
 		static_branch_enable(&have_neon);
diff --git a/lib/crypto/arm64/poly1305-glue.c b/lib/crypto/arm64/poly1305-glue.c
index 31aea21ce42f7..d4a522e7d25a9 100644
--- a/lib/crypto/arm64/poly1305-glue.c
+++ b/lib/crypto/arm64/poly1305-glue.c
@@ -48,17 +48,10 @@ void poly1305_blocks_arch(struct poly1305_block_state *state, const u8 *src,
 	} else
 		poly1305_blocks(state, src, len, padbit);
 }
 EXPORT_SYMBOL_GPL(poly1305_blocks_arch);
 
-bool poly1305_is_arch_optimized(void)
-{
-	/* We always can use at least the ARM64 scalar implementation. */
-	return true;
-}
-EXPORT_SYMBOL(poly1305_is_arch_optimized);
-
 static int __init neon_poly1305_mod_init(void)
 {
 	if (cpu_have_named_feature(ASIMD))
 		static_branch_enable(&have_neon);
 	return 0;
diff --git a/lib/crypto/mips/poly1305-glue.c b/lib/crypto/mips/poly1305-glue.c
index 764a38a652002..002f50f710aba 100644
--- a/lib/crypto/mips/poly1305-glue.c
+++ b/lib/crypto/mips/poly1305-glue.c
@@ -21,13 +21,7 @@ EXPORT_SYMBOL_GPL(poly1305_blocks_arch);
 asmlinkage void poly1305_emit_arch(const struct poly1305_state *state,
 				   u8 digest[POLY1305_DIGEST_SIZE],
 				   const u32 nonce[4]);
 EXPORT_SYMBOL_GPL(poly1305_emit_arch);
 
-bool poly1305_is_arch_optimized(void)
-{
-	return true;
-}
-EXPORT_SYMBOL(poly1305_is_arch_optimized);
-
 MODULE_DESCRIPTION("Poly1305 transform (MIPS accelerated");
 MODULE_LICENSE("GPL v2");
diff --git a/lib/crypto/powerpc/poly1305-p10-glue.c b/lib/crypto/powerpc/poly1305-p10-glue.c
index 3f1664a724b65..184a71f9c1dee 100644
--- a/lib/crypto/powerpc/poly1305-p10-glue.c
+++ b/lib/crypto/powerpc/poly1305-p10-glue.c
@@ -70,16 +70,10 @@ void poly1305_emit_arch(const struct poly1305_state *state,
 		return poly1305_emit_generic(state, digest, nonce);
 	poly1305_emit_64(state, nonce, digest);
 }
 EXPORT_SYMBOL_GPL(poly1305_emit_arch);
 
-bool poly1305_is_arch_optimized(void)
-{
-	return static_key_enabled(&have_p10);
-}
-EXPORT_SYMBOL(poly1305_is_arch_optimized);
-
 static int __init poly1305_p10_init(void)
 {
 	if (cpu_has_feature(CPU_FTR_ARCH_31))
 		static_branch_enable(&have_p10);
 	return 0;
diff --git a/lib/crypto/x86/poly1305_glue.c b/lib/crypto/x86/poly1305_glue.c
index 856d48fd422b0..deb5841cb0ada 100644
--- a/lib/crypto/x86/poly1305_glue.c
+++ b/lib/crypto/x86/poly1305_glue.c
@@ -139,16 +139,10 @@ void poly1305_emit_arch(const struct poly1305_state *ctx,
 	else
 		poly1305_emit_avx(ctx, mac, nonce);
 }
 EXPORT_SYMBOL_GPL(poly1305_emit_arch);
 
-bool poly1305_is_arch_optimized(void)
-{
-	return static_key_enabled(&poly1305_use_avx);
-}
-EXPORT_SYMBOL(poly1305_is_arch_optimized);
-
 static int __init poly1305_simd_mod_init(void)
 {
 	if (boot_cpu_has(X86_FEATURE_AVX) &&
 	    cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL))
 		static_branch_enable(&poly1305_use_avx);
-- 
2.50.1



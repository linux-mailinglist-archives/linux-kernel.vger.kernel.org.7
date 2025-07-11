Return-Path: <linux-kernel+bounces-727931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AFCB0218B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8807D542D8B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808A72F1FD8;
	Fri, 11 Jul 2025 16:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pK+Ugg/R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF5D2F19B6
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250681; cv=none; b=qIfyqa5ibqYZyT+1qZdLtTn/LcfDNoQJJfK+iWaKcunbYtrVbiEp/P6D9qS58pd845buFqo/cpbAqiaNm0ctrAh36uumoEJdNjqD6czIzc6yP5U0CtYWsP1EeRuoWpJG2c2/8rtWBvZxUMzRK6efI8K1DTAW83DMwbYEpJbQ7Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250681; c=relaxed/simple;
	bh=buXKCURD0rDg9LCeJR6ajdKTgsrB7TdGsFPHuLOxDsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jemMX5nF6kdc1ZI9z3EgYGNBFI1bKUmBmlZTbgNc9a+PIs/osCFidhtWUdCejuZkLpMUaGek1VddAogvOS3NTJeXVC04yjB0e+o1ZhYwrHRfDrxixPdnqcsOIjQ4S2VCQQ4c3CIeuelZLyv8E0PTsTLB5kMQl3z8RtcR4mM8kx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pK+Ugg/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8AC8C4CEED;
	Fri, 11 Jul 2025 16:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752250680;
	bh=buXKCURD0rDg9LCeJR6ajdKTgsrB7TdGsFPHuLOxDsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pK+Ugg/ROm1qkMd7IQzB6dWQZbn/qW5fG74SQ6NyZHiYOBAjT8B6TB7oEI8/XPysF
	 Y46suYS74Kyqm88XLKPHlOta0+rbDOjtiyV4oPyOuxH4VBNhWu8mZIbM+DYfxDSitA
	 Fg4bbtpMosIb+YB1qCgAeOInjmsfJEL4DZmg0i3DYxxXc3Phjf36cr1w2FLqNQayNn
	 89Qfc3uYCIQJtaXNWDIfv/8eV7uZUiiP38f58VzBoBYtGPYRwnmdisAXWhUZXZpTXO
	 NDuQPkpM/S+FV836EOWXeJ19qS6oDPZcDsBOjWEbhHXLq+Nwne6ZqhCQwYHhrfSWwc
	 TRAsmm4j8HUNw==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH 08/10] arm64: mm: Inline __TLBI_VADDR_RANGE() into __tlbi_range()
Date: Fri, 11 Jul 2025 17:17:30 +0100
Message-Id: <20250711161732.384-9-will@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250711161732.384-1-will@kernel.org>
References: <20250711161732.384-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The __TLBI_VADDR_RANGE() macro is only used in one place and isn't
something that's generally useful outside of the low-level range
invalidation gubbins.

Inline __TLBI_VADDR_RANGE() into the __tlbi_range() function so that the
macro can be removed entirely.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/tlbflush.h | 32 +++++++++++++------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 434b9fdb340a..8618a85d5cd3 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -185,19 +185,6 @@ static inline void __tlbi_level(const enum tlbi_op op, u64 addr, u32 level)
 #define TLBIR_TTL_MASK		GENMASK_ULL(38, 37)
 #define TLBIR_BADDR_MASK	GENMASK_ULL(36,  0)
 
-#define __TLBI_VADDR_RANGE(baddr, asid, scale, num, ttl)		\
-	({								\
-		unsigned long __ta = 0;					\
-		unsigned long __ttl = (ttl >= 1 && ttl <= 3) ? ttl : 0;	\
-		__ta |= FIELD_PREP(TLBIR_BADDR_MASK, baddr);		\
-		__ta |= FIELD_PREP(TLBIR_TTL_MASK, __ttl);		\
-		__ta |= FIELD_PREP(TLBIR_NUM_MASK, num);		\
-		__ta |= FIELD_PREP(TLBIR_SCALE_MASK, scale);		\
-		__ta |= FIELD_PREP(TLBIR_TG_MASK, get_trans_granule());	\
-		__ta |= FIELD_PREP(TLBIR_ASID_MASK, asid);		\
-		__ta;							\
-	})
-
 /* These macros are used by the TLBI RANGE feature. */
 #define __TLBI_RANGE_PAGES(num, scale)	\
 	((unsigned long)((num) + 1) << (5 * (scale) + 1))
@@ -426,8 +413,19 @@ static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 		__tlbi_user(r ## op, arg);				\
 		break
 
-static __always_inline void __tlbi_range(const enum tlbi_op op, u64 arg)
+static __always_inline void __tlbi_range(const enum tlbi_op op, u64 addr,
+					 u16 asid, int scale, int num,
+					 u32 level, bool lpa2)
 {
+	u64 arg = 0;
+
+	arg |= FIELD_PREP(TLBIR_BADDR_MASK, addr >> (lpa2 ? 16 : PAGE_SHIFT));
+	arg |= FIELD_PREP(TLBIR_TTL_MASK, level > 3 ? 0 : level);
+	arg |= FIELD_PREP(TLBIR_NUM_MASK, num);
+	arg |= FIELD_PREP(TLBIR_SCALE_MASK, scale);
+	arg |= FIELD_PREP(TLBIR_TG_MASK, get_trans_granule());
+	arg |= FIELD_PREP(TLBIR_ASID_MASK, asid);
+
 	switch (op) {
 	__GEN_TLBI_OP_ASID_CASE(vae1is);
 	__GEN_TLBI_OP_ASID_CASE(vale1is);
@@ -448,8 +446,6 @@ do {									\
 	typeof(pages) __flush_pages = pages;				\
 	int num = 0;							\
 	int scale = 3;							\
-	int shift = lpa2 ? 16 : PAGE_SHIFT;				\
-	unsigned long addr;						\
 									\
 	while (__flush_pages > 0) {					\
 		if (!system_supports_tlb_range() ||			\
@@ -463,9 +459,7 @@ do {									\
 									\
 		num = __TLBI_RANGE_NUM(__flush_pages, scale);		\
 		if (num >= 0) {						\
-			addr = __TLBI_VADDR_RANGE(__flush_start >> shift, asid, \
-						scale, num, tlb_level);	\
-			__tlbi_range(op, addr);				\
+			__tlbi_range(op, __flush_start, asid, scale, num, tlb_level, lpa2); \
 			__flush_start += __TLBI_RANGE_PAGES(num, scale) << PAGE_SHIFT; \
 			__flush_pages -= __TLBI_RANGE_PAGES(num, scale);\
 		}							\
-- 
2.50.0.727.gbf7dc18ff4-goog



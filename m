Return-Path: <linux-kernel+bounces-727930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C22B9B0218A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33E3418855E8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DA62EF64F;
	Fri, 11 Jul 2025 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irmQpPh0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04BB21C186
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250678; cv=none; b=Hi+LXTW5wrhdcQO3AmEYlKpt2mGJN4C7kBajJaEjNOQXLU7JR5b1Z2IU2qwOEsMbgNZ7M7HxsUF69thYJNIQVQUtB06zJBoSfKrmYHGFAgWWG1U0d5yPcIEwyczrpmQgCsgiR7R3CpPDEjiu4VQ4eMXiSIbGAqpSmHIZrmTt1y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250678; c=relaxed/simple;
	bh=LMvMiVr8imwSxfMPioAfx2yF722cKWt6LDwVcW9+tc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dsc9Qxq3GtWG5aSqGF8n7C6ZW1vmSwdScRl2G9lZ+n04bPz0QcY2YoUqSsctdUYJTfOOe8/sA93KyOQDxOsYfZUEHcyBnqoUND40GlXSLO91v8/AZ7Gr56lG3SoamiO8/KgosHUYvvzsT9akZ3Kj60wLIqCivFyzMlM9AUfprrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irmQpPh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA6CC4CEF5;
	Fri, 11 Jul 2025 16:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752250678;
	bh=LMvMiVr8imwSxfMPioAfx2yF722cKWt6LDwVcW9+tc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=irmQpPh0ukhYGhD3/z2Ca8EgS4PotewgF87LD8sxI5OTQ9i7FjNqoGmH0xDEqTQGg
	 DIzUYkrPh17m+lP1WCMHSt76s7ILKZUv0IgQ6M47f0A2AVrrEbBZJ6A/DmZTKexfT1
	 RM+Xvt656cmaKYDw+F+erL1lMiMn8X3TTatTk7sO0Mi7oFffUWyoSPkWS6WJYMRETk
	 qohSOsmIYEMuzfGEiHTp/n56JYCSEoWc3yQyxB9vPNPwqDY13DCLRc56lRmn/pmIpH
	 JWACO2zveIEBTiuUBLfM/pOdOt52/U9m+paPaXup0u/y77RgwQSO9K1QDWyhCsaJlo
	 6bt+Aw4Gn4ccg==
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
Subject: [PATCH 07/10] arm64: mm: Push __TLBI_VADDR() into __tlbi_level()
Date: Fri, 11 Jul 2025 17:17:29 +0100
Message-Id: <20250711161732.384-8-will@kernel.org>
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

The __TLBI_VADDR() macro takes an ASID and an address and converts them
into a single argument formatted correctly for a TLB invalidation
instruction.

Rather than have callers worry about this (especially in the case where
the ASID is zero), push the macro down into __tlbi_level() via a new
__tlbi_level_asid() helper.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/tlbflush.h | 14 ++++++++++----
 arch/arm64/kernel/sys_compat.c    |  2 +-
 arch/arm64/kvm/hyp/nvhe/mm.c      |  2 +-
 arch/arm64/kvm/hyp/pgtable.c      |  4 ++--
 4 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index a8d21e52ef3a..434b9fdb340a 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -128,9 +128,10 @@ enum tlbi_op {
 	___GEN_TLBI_OP_CASE(op);					\
 		break
 
-static __always_inline void __tlbi_level(const enum tlbi_op op, u64 addr, u32 level)
+static __always_inline void __tlbi_level_asid(const enum tlbi_op op, u64 addr,
+					      u32 level, u16 asid)
 {
-	u64 arg = addr;
+	u64 arg = __TLBI_VADDR(addr, asid);
 
 	if (alternative_has_cap_unlikely(ARM64_HAS_ARMv8_4_TTL) && level <= 3) {
 		u64 ttl = level | (get_trans_granule() << 2);
@@ -154,6 +155,11 @@ static __always_inline void __tlbi_level(const enum tlbi_op op, u64 addr, u32 le
 #undef __GEN_TLBI_OP_ASID_CASE
 #undef ___GEN_TLBI_OP_CASE
 
+static inline void __tlbi_level(const enum tlbi_op op, u64 addr, u32 level)
+{
+	__tlbi_level_asid(op, addr, level, 0);
+}
+
 /*
  * This macro creates a properly formatted VA operand for the TLB RANGE. The
  * value bit assignments are:
@@ -449,8 +455,7 @@ do {									\
 		if (!system_supports_tlb_range() ||			\
 		    __flush_pages == 1 ||				\
 		    (lpa2 && __flush_start != ALIGN(__flush_start, SZ_64K))) {	\
-			addr = __TLBI_VADDR(__flush_start, asid);	\
-			__tlbi_level(op, addr, tlb_level);		\
+			__tlbi_level_asid(op, __flush_start, tlb_level, asid);	\
 			__flush_start += stride;			\
 			__flush_pages -= stride >> PAGE_SHIFT;		\
 			continue;					\
@@ -580,6 +585,7 @@ static inline void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *b
 	__flush_tlb_range_nosync(mm, start, end, PAGE_SIZE, true, 3);
 }
 
+#undef __TLBI_VADDR
 #undef __tlbi_user
 #endif
 #endif
diff --git a/arch/arm64/kernel/sys_compat.c b/arch/arm64/kernel/sys_compat.c
index 4a609e9b65de..ad4857df4830 100644
--- a/arch/arm64/kernel/sys_compat.c
+++ b/arch/arm64/kernel/sys_compat.c
@@ -36,7 +36,7 @@ __do_compat_cache_op(unsigned long start, unsigned long end)
 			 * The workaround requires an inner-shareable tlbi.
 			 * We pick the reserved-ASID to minimise the impact.
 			 */
-			__tlbi(aside1is, __TLBI_VADDR(0, 0));
+			__tlbi(aside1is, 0UL);
 			dsb(ish);
 		}
 
diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
index ae8391baebc3..581385b21826 100644
--- a/arch/arm64/kvm/hyp/nvhe/mm.c
+++ b/arch/arm64/kvm/hyp/nvhe/mm.c
@@ -270,7 +270,7 @@ static void fixmap_clear_slot(struct hyp_fixmap_slot *slot)
 	 * https://lore.kernel.org/kvm/20221017115209.2099-1-will@kernel.org/T/#mf10dfbaf1eaef9274c581b81c53758918c1d0f03
 	 */
 	dsb(ishst);
-	__tlbi_level(vale2is, __TLBI_VADDR(addr, 0), level);
+	__tlbi_level(vale2is, addr, level);
 	dsb(ish);
 	isb();
 }
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index c351b4abd5db..540691987e13 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -472,14 +472,14 @@ static int hyp_unmap_walker(const struct kvm_pgtable_visit_ctx *ctx,
 
 		kvm_clear_pte(ctx->ptep);
 		dsb(ishst);
-		__tlbi_level(vae2is, __TLBI_VADDR(ctx->addr, 0), TLBI_TTL_UNKNOWN);
+		__tlbi_level(vae2is, ctx->addr, TLBI_TTL_UNKNOWN);
 	} else {
 		if (ctx->end - ctx->addr < granule)
 			return -EINVAL;
 
 		kvm_clear_pte(ctx->ptep);
 		dsb(ishst);
-		__tlbi_level(vale2is, __TLBI_VADDR(ctx->addr, 0), ctx->level);
+		__tlbi_level(vale2is, ctx->addr, ctx->level);
 		*unmapped += granule;
 	}
 
-- 
2.50.0.727.gbf7dc18ff4-goog



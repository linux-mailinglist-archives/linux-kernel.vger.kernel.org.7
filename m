Return-Path: <linux-kernel+bounces-727926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAA2B02182
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127A21887357
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EED2EF9DF;
	Fri, 11 Jul 2025 16:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Re+Ll/b2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2652EF9B6
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250669; cv=none; b=Pg/mibayqAEIgFVT7TXkgV4qOAp6FEt+jLK3HqYL1N6HVD8NUJQo4tld0iKP+0CgCtu7uunYUfcGYh196FkbIwTp5UbTzQ/AOq+otCZ8WkTLGP7BI+hPZttjx5Sj0GE7NKiBLGooRkQuBpEhPVkC6WSQDFpSgpaHoJeqdFi5j9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250669; c=relaxed/simple;
	bh=omASSf5AodAZJuWCX0tb4hiAUdVWa3UIK9zu/g/yffM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kh5xFaUReZx9C0hR/tsJ9ZDCDrH3FzGNM+u4X2IpHMrM22imbZJPqjRZYrhZoVopstBLfhmIK9zVWaKWV7I7AKKqSb49BHfOsrDQYg+akymo9gjmfLeA9CuW6A49/gp5g3sI5Aix2L7ClELtDk2u9WvT0IFbgay2grTVC/ACq7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Re+Ll/b2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9494C4CEF6;
	Fri, 11 Jul 2025 16:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752250668;
	bh=omASSf5AodAZJuWCX0tb4hiAUdVWa3UIK9zu/g/yffM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Re+Ll/b20qk+1VLbHfZ5OgRv+ruiurQeg34El3ijBhRwVEuLWOzCvdykuUxfM5ZBz
	 jTntl/TgmN96C2gaTttrPyIJNq0WeKoWLArhVnfPg55PzxH0HdKFmIMY7RZobP3rSG
	 nchrEZc+GzmEe8lyrGGXd1SCqKNZZketyEosEYXL4Ak/RBhJjpCUWHcsJj6NQF3wlG
	 IyWd5cQjZJIwFb0vlTURT5D5fsLVLnVqg5FKIK3vDopE16AYmRG3nkRGA/awhxnYAW
	 KddjqQU4qYmWvEITZCztmNASX02ty/ZgBGK4xldyubNezUMbOkMbyGxe0B1ER1nU3C
	 GEL4T+GhNpXLQ==
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
Subject: [PATCH 03/10] arm64: mm: Implicitly invalidate user ASID based on TLBI operation
Date: Fri, 11 Jul 2025 17:17:25 +0100
Message-Id: <20250711161732.384-4-will@kernel.org>
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

When kpti is enabled, separate ASIDs are used for userspace and
kernelspace, requiring ASID-qualified TLB invalidation by virtual
address to invalidate both of them.

Push the logic for invalidating the two ASIDs down into the low-level
__tlbi_level_op() function based on the TLBI operation and remove the
burden from the caller to handle the kpti-specific behaviour.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/tlbflush.h | 45 ++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 4408aeebf4d5..08e509f37b28 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -115,17 +115,25 @@ enum tlbi_op {
 
 #define TLBI_TTL_UNKNOWN	INT_MAX
 
-#define __GEN_TLBI_OP_CASE(op)						\
+#define ___GEN_TLBI_OP_CASE(op)						\
 	case op:							\
-		__tlbi(op, arg);					\
+		__tlbi(op, arg)
+
+#define __GEN_TLBI_OP_ASID_CASE(op)					\
+	___GEN_TLBI_OP_CASE(op);					\
+		__tlbi_user(op, arg);					\
+		break
+
+#define __GEN_TLBI_OP_CASE(op)						\
+	___GEN_TLBI_OP_CASE(op);					\
 		break
 
 static __always_inline void __tlbi_level_op(const enum tlbi_op op, u64 arg)
 {
 	switch (op) {
-	__GEN_TLBI_OP_CASE(vae1is);
+	__GEN_TLBI_OP_ASID_CASE(vae1is);
 	__GEN_TLBI_OP_CASE(vae2is);
-	__GEN_TLBI_OP_CASE(vale1is);
+	__GEN_TLBI_OP_ASID_CASE(vale1is);
 	__GEN_TLBI_OP_CASE(vale2is);
 	__GEN_TLBI_OP_CASE(vaale1is);
 	__GEN_TLBI_OP_CASE(ipas2e1);
@@ -134,7 +142,8 @@ static __always_inline void __tlbi_level_op(const enum tlbi_op op, u64 arg)
 		BUILD_BUG();
 	}
 }
-#undef __GEN_TLBI_OP_CASE
+#undef __GEN_TLBI_OP_ASID_CASE
+#undef ___GEN_TLBI_OP_CASE
 
 #define __tlbi_level(op, addr, level) do {				\
 	u64 arg = addr;							\
@@ -150,11 +159,6 @@ static __always_inline void __tlbi_level_op(const enum tlbi_op op, u64 arg)
 	__tlbi_level_op(op, arg);					\
 } while(0)
 
-#define __tlbi_user_level(op, arg, level) do {				\
-	if (arm64_kernel_unmapped_at_el0())				\
-		__tlbi_level(op, (arg | USER_ASID_FLAG), level);	\
-} while (0)
-
 /*
  * This macro creates a properly formatted VA operand for the TLB RANGE. The
  * value bit assignments are:
@@ -418,22 +422,28 @@ static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
  *    operations can only span an even number of pages. We save this for last to
  *    ensure 64KB start alignment is maintained for the LPA2 case.
  */
-#define __GEN_TLBI_OP_CASE(op)						\
+#define ___GEN_TLBI_OP_CASE(op)						\
 	case op:							\
-		__tlbi(r ## op, arg);					\
+		__tlbi(r ## op, arg)
+
+#define __GEN_TLBI_OP_ASID_CASE(op)					\
+	___GEN_TLBI_OP_CASE(op);					\
+		__tlbi_user(r ## op, arg);				\
 		break
 
 static __always_inline void __tlbi_range(const enum tlbi_op op, u64 arg)
 {
 	switch (op) {
-	__GEN_TLBI_OP_CASE(vae1is);
-	__GEN_TLBI_OP_CASE(vale1is);
+	__GEN_TLBI_OP_ASID_CASE(vae1is);
+	__GEN_TLBI_OP_ASID_CASE(vale1is);
 	__GEN_TLBI_OP_CASE(vaale1is);
 	__GEN_TLBI_OP_CASE(ipas2e1is);
 	default:
 		BUILD_BUG();
 	}
 }
+#undef __GEN_TLBI_OP_ASID_CASE
+#undef ___GEN_TLBI_OP_CASE
 #undef __GEN_TLBI_OP_CASE
 
 #define __flush_tlb_range_op(op, start, pages, stride,			\
@@ -452,8 +462,6 @@ do {									\
 		    (lpa2 && __flush_start != ALIGN(__flush_start, SZ_64K))) {	\
 			addr = __TLBI_VADDR(__flush_start, asid);	\
 			__tlbi_level(op, addr, tlb_level);		\
-			if (tlbi_user)					\
-				__tlbi_user_level(op, addr, tlb_level);	\
 			__flush_start += stride;			\
 			__flush_pages -= stride >> PAGE_SHIFT;		\
 			continue;					\
@@ -464,8 +472,6 @@ do {									\
 			addr = __TLBI_VADDR_RANGE(__flush_start >> shift, asid, \
 						scale, num, tlb_level);	\
 			__tlbi_range(op, addr);				\
-			if (tlbi_user)					\
-				__tlbi_user(r##op, addr);		\
 			__flush_start += __TLBI_RANGE_PAGES(num, scale) << PAGE_SHIFT; \
 			__flush_pages -= __TLBI_RANGE_PAGES(num, scale);\
 		}							\
@@ -584,6 +590,7 @@ static inline void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *b
 {
 	__flush_tlb_range_nosync(mm, start, end, PAGE_SIZE, true, 3);
 }
-#endif
 
+#undef __tlbi_user
+#endif
 #endif
-- 
2.50.0.727.gbf7dc18ff4-goog



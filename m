Return-Path: <linux-kernel+bounces-727933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 644B6B0218C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F33D544511
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBB62F2372;
	Fri, 11 Jul 2025 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUUS7ykY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3C02F2359
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250686; cv=none; b=WLtMV39q18/cstCVw7kf+QQmcHvmqXedvjY8P3p5AG4Le4DqTataOUA3+SYKfUWCg22GqDKzzMoX0UoHJCaIFT/SHZ8AnBUFgHEucrR64p8pv8Gqvh6j21hyq87oB7/T2zClaPoyNmnak86VfWEH1nJMffDyZWFAc0QHPm0hULc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250686; c=relaxed/simple;
	bh=dlETiSCP0bE/7Eo8LNeRjL0vHF3yV9EuAqXo0Nii9Qo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lOGgQeNN3c7Q1Vhn4VW0WK7zZVT4vMhDQcvpJz8u8Y2z7JK15XDiBL5dTTea505XI/ZkGJqrEZpGfNmfX4UdU1VzzjRBJADpOyPxoL3du7h+Ne6/W9KjB8lreMQpcjXmOiNtvrFX7hvn5Ppz3HXyMxa+eMKM+i8BWY7PN4ZE/8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUUS7ykY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A8AC4CEEF;
	Fri, 11 Jul 2025 16:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752250685;
	bh=dlETiSCP0bE/7Eo8LNeRjL0vHF3yV9EuAqXo0Nii9Qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gUUS7ykYexH4zJ5LeQzrknTtSpvDTGSrjRCCI3ivPvxM00SmGnWwhhvuHWCGpkXT9
	 gt0hJzVqbFvq5jJt7orVDYOtf5INnTQKdfDvPshlFZ98vgfC6TbjPzuB0PBlpiuEW5
	 vlJseJ8qKce72EIX9QuzcGs2zn0QybPYFhidA1fNQAyDJYWNym6hZQwpRwfoNBddyg
	 FCkxwyVGD6yhLGX5Cctw1oizVqPJ+36kchYXqKd/Ou4NQafNI6z1Y4Dxu43XQtq88a
	 JGgYX9NbtwPXMaRInCfT0//2bLgSpQIrzjVCvPMFJwDAUz8DwVfaagxMbG6vJoUO0p
	 6VNKKoKwp5yfQ==
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
Subject: [PATCH 10/10] arm64: mm: Re-implement the __flush_tlb_range_op macro in C
Date: Fri, 11 Jul 2025 17:17:32 +0100
Message-Id: <20250711161732.384-11-will@kernel.org>
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

The __flush_tlb_range_op() macro is horrible and has been a previous
source of bugs thanks to multiple expansions of its arguments (see
commit f7edb07ad7c6 ("Fix mmu notifiers for range-based invalidates")).

Rewrite the thing in C.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/tlbflush.h | 63 +++++++++++++++++--------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 2541863721af..ee69efdc12ab 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -376,12 +376,12 @@ static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 /*
  * __flush_tlb_range_op - Perform TLBI operation upon a range
  *
- * @op:	TLBI instruction that operates on a range (has 'r' prefix)
+ * @op:		TLBI instruction that operates on a range
  * @start:	The start address of the range
  * @pages:	Range as the number of pages from 'start'
  * @stride:	Flush granularity
  * @asid:	The ASID of the task (0 for IPA instructions)
- * @tlb_level:	Translation Table level hint, if known
+ * @level:	Translation Table level hint, if known
  * @lpa2:	If 'true', the lpa2 scheme is used as set out below
  *
  * When the CPU does not support TLB range operations, flush the TLB
@@ -439,33 +439,38 @@ static __always_inline void __tlbi_range(const enum tlbi_op op, u64 addr,
 #undef ___GEN_TLBI_OP_CASE
 #undef __GEN_TLBI_OP_CASE
 
-#define __flush_tlb_range_op(op, start, pages, stride,			\
-				asid, tlb_level, lpa2)			\
-do {									\
-	typeof(start) __flush_start = start;				\
-	typeof(pages) __flush_pages = pages;				\
-	int num = 0;							\
-	int scale = 3;							\
-									\
-	while (__flush_pages > 0) {					\
-		if (!system_supports_tlb_range() ||			\
-		    __flush_pages == 1 ||				\
-		    (lpa2 && __flush_start != ALIGN(__flush_start, SZ_64K))) {	\
-			__tlbi_level_asid(op, __flush_start, tlb_level, asid);	\
-			__flush_start += stride;			\
-			__flush_pages -= stride >> PAGE_SHIFT;		\
-			continue;					\
-		}							\
-									\
-		num = __TLBI_RANGE_NUM(__flush_pages, scale);		\
-		if (num >= 0) {						\
-			__tlbi_range(op, __flush_start, asid, scale, num, tlb_level, lpa2); \
-			__flush_start += __TLBI_RANGE_PAGES(num, scale) << PAGE_SHIFT; \
-			__flush_pages -= __TLBI_RANGE_PAGES(num, scale);\
-		}							\
-		scale--;						\
-	}								\
-} while (0)
+static __always_inline void __flush_tlb_range_op(const enum tlbi_op op,
+						 u64 start, size_t pages,
+						 u64 stride, u16 asid,
+						 u32 level, bool lpa2)
+{
+	u64 addr = start, end = start + pages * PAGE_SIZE;
+	int scale = 3;
+
+	while (addr != end) {
+		int num;
+
+		pages = (end - addr) >> PAGE_SHIFT;
+
+		if (!system_supports_tlb_range() || pages == 1)
+			goto invalidate_one;
+
+		if (lpa2 && !IS_ALIGNED(addr, SZ_64K))
+			goto invalidate_one;
+
+		num = __TLBI_RANGE_NUM(pages, scale);
+		if (num >= 0) {
+			__tlbi_range(op, addr, asid, scale, num, level, lpa2);
+			addr += __TLBI_RANGE_PAGES(num, scale) << PAGE_SHIFT;
+		}
+
+		scale--;
+		continue;
+invalidate_one:
+		__tlbi_level_asid(op, addr, level, asid);
+		addr += stride;
+	}
+}
 
 #define __flush_s2_tlb_range_op(op, start, pages, stride, tlb_level) \
 	__flush_tlb_range_op(op, start, pages, stride, 0, tlb_level, kvm_lpa2_is_enabled());
-- 
2.50.0.727.gbf7dc18ff4-goog



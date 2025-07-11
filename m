Return-Path: <linux-kernel+bounces-727927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 944AAB02183
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4990B3B4727
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CC52EF2A6;
	Fri, 11 Jul 2025 16:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1HVFDmh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551F62EF9DC
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250671; cv=none; b=Mk+9UKGeRGBUf5QnVcfNFZ7dQz9bSZKp+Gdaz/cgTR15wnGtgaFq5tKiqXenZA2Tbunj14JLWCKCD0LNxMUKygYe4953arxCm5dJNCxey9AH3Ys+2x0q1HwA305XQvt5bJH3jOia2ri4VmMn+CvK1z2a+N5+3XmjxjCUg5Q4xXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250671; c=relaxed/simple;
	bh=srwRxatt1MHTQ063/JWIF6OtD3mvYAP76oIaQp4djOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FOyBStOnFPs8FmFg+85L2zB8/RH6SW+kHxOk3ObdJKtYd6hcZ/GMYv42WCPR6vlux8OKbJInxVCcONzQYXjChOUDfkPMY+QdB6U9zZLNzzqWHoNjiAGayX1SELGw0eFBzqrzn3zBROjjXNqpGJN5NSs/zE7va/tvDvJd5e+2UG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1HVFDmh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12AAEC4CEED;
	Fri, 11 Jul 2025 16:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752250671;
	bh=srwRxatt1MHTQ063/JWIF6OtD3mvYAP76oIaQp4djOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d1HVFDmh76WvWr0qWzacxcWvB9yIcL9py/Z4Fag1+P39XUrlCCOzRyMV7xXrLy6df
	 IuAnt3WLFD1KalgCwcK1DtlOozoV2AuCeikXbjWHxRh3GnylKq1xQsLj/Sl3hXEOI8
	 L4MUswDDY/RcH3zKr0DvP+v7XuVFSpBLi3Z5oG7n4sZtaNcHzQ8diTIR0VymqoUzji
	 p8QM6RSpd08sopjO9aLJbPT+kHzZWi3hjA+09eJCX8+mIVomFNlFXGnTVXVZINoeQg
	 nMR64LxIIsAQfM4HKr3lQlJhOyhR0KrQdBxwbqaeYSA51kEvJVhsqYYkcTkLH2W1Gr
	 GuGjYR7ccqjbw==
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
Subject: [PATCH 04/10] arm64: mm: Remove unused 'tlbi_user' argument from __flush_tlb_range_op()
Date: Fri, 11 Jul 2025 17:17:26 +0100
Message-Id: <20250711161732.384-5-will@kernel.org>
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

The 'tlbi_user' argument to __flush_tlb_range_op() is unused. Drop it.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/tlbflush.h | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 08e509f37b28..728b00f3e1f4 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -398,8 +398,6 @@ static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
  * @stride:	Flush granularity
  * @asid:	The ASID of the task (0 for IPA instructions)
  * @tlb_level:	Translation Table level hint, if known
- * @tlbi_user:	If 'true', call an additional __tlbi_user()
- *              (typically for user ASIDs). 'flase' for IPA instructions
  * @lpa2:	If 'true', the lpa2 scheme is used as set out below
  *
  * When the CPU does not support TLB range operations, flush the TLB
@@ -447,7 +445,7 @@ static __always_inline void __tlbi_range(const enum tlbi_op op, u64 arg)
 #undef __GEN_TLBI_OP_CASE
 
 #define __flush_tlb_range_op(op, start, pages, stride,			\
-				asid, tlb_level, tlbi_user, lpa2)	\
+				asid, tlb_level, lpa2)			\
 do {									\
 	typeof(start) __flush_start = start;				\
 	typeof(pages) __flush_pages = pages;				\
@@ -480,7 +478,7 @@ do {									\
 } while (0)
 
 #define __flush_s2_tlb_range_op(op, start, pages, stride, tlb_level) \
-	__flush_tlb_range_op(op, start, pages, stride, 0, tlb_level, false, kvm_lpa2_is_enabled());
+	__flush_tlb_range_op(op, start, pages, stride, 0, tlb_level, kvm_lpa2_is_enabled());
 
 static inline bool __flush_tlb_range_limit_excess(unsigned long start,
 		unsigned long end, unsigned long pages, unsigned long stride)
@@ -520,10 +518,10 @@ static inline void __flush_tlb_range_nosync(struct mm_struct *mm,
 
 	if (last_level)
 		__flush_tlb_range_op(vale1is, start, pages, stride, asid,
-				     tlb_level, true, lpa2_is_enabled());
+				     tlb_level, lpa2_is_enabled());
 	else
 		__flush_tlb_range_op(vae1is, start, pages, stride, asid,
-				     tlb_level, true, lpa2_is_enabled());
+				     tlb_level, lpa2_is_enabled());
 
 	mmu_notifier_arch_invalidate_secondary_tlbs(mm, start, end);
 }
@@ -566,7 +564,7 @@ static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end
 
 	dsb(ishst);
 	__flush_tlb_range_op(vaale1is, start, pages, stride, 0,
-			     TLBI_TTL_UNKNOWN, false, lpa2_is_enabled());
+			     TLBI_TTL_UNKNOWN, lpa2_is_enabled());
 	dsb(ish);
 	isb();
 }
-- 
2.50.0.727.gbf7dc18ff4-goog



Return-Path: <linux-kernel+bounces-792020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FB1B3BF89
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710835875CC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4412632778A;
	Fri, 29 Aug 2025 15:35:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51555326D50
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756481727; cv=none; b=aGy65Lch4FYS9UCvUTVOb++7OVk6jQQ6dNGBcabN6tOPgEOVIregu2eS446F+I9Pcggo5VN0LTjkY/Yvd4kSgN2yHPW/Xap1M1ggaHJNqBpQXbPJngYG0Lj4yZJyIbQWv0vyAjLF/LlXLIukmmPanUoC2QsQdJnMTXjpyHQBrNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756481727; c=relaxed/simple;
	bh=U5Kjn8+U65K64jo6d5IeiEJVJ+xj6L5MEGQARPcWqMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PW4oHJ+ipCvit4evVZLisYdWnxf9B2lkUOqD+k9jEC+tDC6hpITVb5KBX7+OOuJ861sb53bHQCuR89l296XzDo2koyFfkUzZvPTkFrH+gsZOki/WLveHnSKncrH3UT+wjYuplZ9xKfk/FM7smTgqF3Ci45aj/D7a2WYSjP1nCNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 390C91BD0;
	Fri, 29 Aug 2025 08:35:17 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6828E3F738;
	Fri, 29 Aug 2025 08:35:24 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	James Morse <james.morse@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 1/2] arm64: tlbflush: Move invocation of __flush_tlb_range_op() to a macro
Date: Fri, 29 Aug 2025 16:35:07 +0100
Message-ID: <20250829153510.2401161-2-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829153510.2401161-1-ryan.roberts@arm.com>
References: <20250829153510.2401161-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__flush_tlb_range_op() is a pre-processor macro that takes the TLBI
operation as a string, and builds the instruction from it. This prevents
passing the TLBI operation around as a variable. __flush_tlb_range_op()
also takes 7 other arguments.

Adding extra invocations for different TLB operations means duplicating
the whole thing, but those 7 extra arguments are the same each time.

Add an enum for the TLBI operations that __flush_tlb_range() uses, and a
macro to pass the operation name as a string to __flush_tlb_range_op(),
and the rest of the arguments using __VA_ARGS_.

The result is easier to add new TLBI operations to, and to modify any of
the other arguments as they only appear once.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/tlbflush.h | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 18a5dc0c9a54..f66b8c4696d0 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -11,6 +11,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/bitfield.h>
+#include <linux/build_bug.h>
 #include <linux/mm_types.h>
 #include <linux/sched.h>
 #include <linux/mmu_notifier.h>
@@ -433,12 +434,32 @@ static inline bool __flush_tlb_range_limit_excess(unsigned long start,
 	return false;
 }
 
+enum tlbi_op {
+	TLBI_VALE1IS,
+	TLBI_VAE1IS,
+};
+
+#define flush_tlb_range_op(op, ...)					\
+do {									\
+	switch (op) {							\
+	case TLBI_VALE1IS:						\
+		__flush_tlb_range_op(vale1is, __VA_ARGS__);		\
+		break;							\
+	case TLBI_VAE1IS:						\
+		__flush_tlb_range_op(vae1is, __VA_ARGS__);		\
+		break;							\
+	default:							\
+		BUILD_BUG_ON_MSG(1, "Unknown TLBI op");			\
+	}								\
+} while (0)
+
 static inline void __flush_tlb_range_nosync(struct mm_struct *mm,
 				     unsigned long start, unsigned long end,
 				     unsigned long stride, bool last_level,
 				     int tlb_level)
 {
 	unsigned long asid, pages;
+	enum tlbi_op tlbi_op;
 
 	start = round_down(start, stride);
 	end = round_up(end, stride);
@@ -452,12 +473,9 @@ static inline void __flush_tlb_range_nosync(struct mm_struct *mm,
 	dsb(ishst);
 	asid = ASID(mm);
 
-	if (last_level)
-		__flush_tlb_range_op(vale1is, start, pages, stride, asid,
-				     tlb_level, true, lpa2_is_enabled());
-	else
-		__flush_tlb_range_op(vae1is, start, pages, stride, asid,
-				     tlb_level, true, lpa2_is_enabled());
+	tlbi_op = last_level ? TLBI_VALE1IS : TLBI_VAE1IS;
+	flush_tlb_range_op(tlbi_op, start, pages, stride, asid, tlb_level,
+			   true, lpa2_is_enabled());
 
 	mmu_notifier_arch_invalidate_secondary_tlbs(mm, start, end);
 }
-- 
2.43.0



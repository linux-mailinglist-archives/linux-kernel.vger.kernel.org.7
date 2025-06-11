Return-Path: <linux-kernel+bounces-681827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 872C8AD57D0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 16:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7B443A7265
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 13:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEFD28C855;
	Wed, 11 Jun 2025 13:58:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190BF2BCF7B;
	Wed, 11 Jun 2025 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749650311; cv=none; b=DScYmZdQqMj9mhc/ejyJh3R0pbZ12SiIwhWlxnZsZL4XTMiTZ5VEGolyL+n+JeqS6HCX2PHUkfzRCZEd9VkZYdMVliW5YXHY4P7p8tmdMyBYWjm6IkOqqhIClwUnigDHbFaoBHjuu3G3gavYLqVSjidBy3jwixxXp5X1L7ZBthE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749650311; c=relaxed/simple;
	bh=lZcme6EZOiFwausy0fDDHN8k2UrB/zOliPaOELdtWII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MvUXegFrX0/GcMtfN59wu6ehguDFjiqpFENZNchAulF4kOJLjvKZ5MqTg5JxPCs6RfaC5Bz2rPBt8MbE7oElI09FIX8wXoDWwoX8CLc6dy4d2d4tnJkaAFnKzt+bBN2bdrPBoW9k/36dxE0zDwzwY/5eWrzE2yKuvpzk08199vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD7BE15A1;
	Wed, 11 Jun 2025 06:58:09 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 351483F673;
	Wed, 11 Jun 2025 06:58:27 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: catalin.marinas@arm.com,
	pcc@google.com,
	will@kernel.org,
	broonie@kernel.org,
	anshuman.khandual@arm.com,
	joey.gouly@arm.com,
	yury.khrustalev@arm.com,
	maz@kernel.org,
	oliver.upton@linux.dev,
	frederic@kernel.org,
	akpm@linux-foundation.org,
	surenb@google.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v7 2/9] arm64: report address tag when FEAT_MTE_TAGGED_FAR is supported
Date: Wed, 11 Jun 2025 14:58:11 +0100
Message-Id: <20250611135818.31070-3-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611135818.31070-1-yeoreum.yun@arm.com>
References: <20250611135818.31070-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If FEAT_MTE_TAGGED_FAR (Armv8.9) is supported, bits 63:60 of the fault address
are preserved in response to synchronous tag check faults (SEGV_MTESERR).

This patch modifies below to support this feature:
  - Use the original FAR_EL1 value when an MTE tag check fault occurs,
    if ARM64_MTE_FAR is supported so that not only logical tag
    (bits 59:56) but also address tag (bits 63:60] being reported too.

  - Add HWCAP for mtefar to let user know bits 63:60 includes
    address tag information when when FEAT_MTE_TAGGED_FAR is supported.

Applications that require this information should install
a signal handler with the SA_EXPOSE_TAGBITS flag.
While this introduces a minor ABI change,
most applications do not set this flag and therefore will not be affected.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 Documentation/arch/arm64/elf_hwcaps.rst      |  3 +++
 Documentation/arch/arm64/tagged-pointers.rst | 11 ++++++-----
 arch/arm64/include/asm/hwcap.h               |  1 +
 arch/arm64/include/uapi/asm/hwcap.h          |  1 +
 arch/arm64/kernel/cpufeature.c               |  1 +
 arch/arm64/kernel/cpuinfo.c                  |  1 +
 arch/arm64/mm/fault.c                        |  7 +++++--
 7 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/Documentation/arch/arm64/elf_hwcaps.rst b/Documentation/arch/arm64/elf_hwcaps.rst
index 69d7afe56853..358f5af035ff 100644
--- a/Documentation/arch/arm64/elf_hwcaps.rst
+++ b/Documentation/arch/arm64/elf_hwcaps.rst
@@ -435,6 +435,9 @@ HWCAP2_SME_SF8DP4
 HWCAP2_POE
     Functionality implied by ID_AA64MMFR3_EL1.S1POE == 0b0001.
 
+HWCAP3_MTE_FAR
+    Functionality implied by ID_AA64PFR2_EL1.MTEFAR == 0b0001.
+
 4. Unused AT_HWCAP bits
 -----------------------
 
diff --git a/Documentation/arch/arm64/tagged-pointers.rst b/Documentation/arch/arm64/tagged-pointers.rst
index 81b6c2a770dd..f87a925ca9a5 100644
--- a/Documentation/arch/arm64/tagged-pointers.rst
+++ b/Documentation/arch/arm64/tagged-pointers.rst
@@ -60,11 +60,12 @@ that signal handlers in applications making use of tags cannot rely
 on the tag information for user virtual addresses being maintained
 in these fields unless the flag was set.
 
-Due to architecture limitations, bits 63:60 of the fault address
-are not preserved in response to synchronous tag check faults
-(SEGV_MTESERR) even if SA_EXPOSE_TAGBITS was set. Applications should
-treat the values of these bits as undefined in order to accommodate
-future architecture revisions which may preserve the bits.
+If FEAT_MTE_TAGGED_FAR (Armv8.9) is supported, bits 63:60 of the fault address
+are preserved in response to synchronous tag check faults (SEGV_MTESERR)
+otherwise not preserved even if SA_EXPOSE_TAGBITS was set.
+Applications should interpret the values of these bits based on
+the support for the HWCAP3_MTE_FAR. If the support is not present,
+the values of these bits should be considered as undefined otherwise valid.
 
 For signals raised in response to watchpoint debug exceptions, the
 tag information will be preserved regardless of the SA_EXPOSE_TAGBITS
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index 1c3f9617d54f..28dd1ac29ecc 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -176,6 +176,7 @@
 #define KERNEL_HWCAP_POE		__khwcap2_feature(POE)
 
 #define __khwcap3_feature(x)		(const_ilog2(HWCAP3_ ## x) + 128)
+#define KERNEL_HWCAP_MTE_FAR		__khwcap3_feature(MTE_FAR)
 
 /*
  * This yields a mask that user programs can use to figure out what
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index 705a7afa8e58..7d22527a7975 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -143,5 +143,6 @@
 /*
  * HWCAP3 flags - for AT_HWCAP3
  */
+#define HWCAP3_MTE_FAR		(1UL << 0)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index af6a6924a3e8..8a5284c733b7 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -3219,6 +3219,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 #ifdef CONFIG_ARM64_MTE
 	HWCAP_CAP(ID_AA64PFR1_EL1, MTE, MTE2, CAP_HWCAP, KERNEL_HWCAP_MTE),
 	HWCAP_CAP(ID_AA64PFR1_EL1, MTE, MTE3, CAP_HWCAP, KERNEL_HWCAP_MTE3),
+	HWCAP_CAP(ID_AA64PFR2_EL1, MTEFAR, IMP, CAP_HWCAP, KERNEL_HWCAP_MTE_FAR),
 #endif /* CONFIG_ARM64_MTE */
 	HWCAP_CAP(ID_AA64MMFR0_EL1, ECV, IMP, CAP_HWCAP, KERNEL_HWCAP_ECV),
 	HWCAP_CAP(ID_AA64MMFR1_EL1, AFP, IMP, CAP_HWCAP, KERNEL_HWCAP_AFP),
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index c1f2b6b04b41..e552cb305641 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -160,6 +160,7 @@ static const char *const hwcap_str[] = {
 	[KERNEL_HWCAP_SME_SFEXPA]	= "smesfexpa",
 	[KERNEL_HWCAP_SME_STMOP]	= "smestmop",
 	[KERNEL_HWCAP_SME_SMOP4]	= "smesmop4",
+	[KERNEL_HWCAP_MTE_FAR]		= "mtefar",
 };
 
 #ifdef CONFIG_COMPAT
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index ec0a337891dd..f21d972f99b1 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -837,9 +837,12 @@ static int do_tag_check_fault(unsigned long far, unsigned long esr,
 	/*
 	 * The architecture specifies that bits 63:60 of FAR_EL1 are UNKNOWN
 	 * for tag check faults. Set them to corresponding bits in the untagged
-	 * address.
+	 * address if ARM64_MTE_FAR isn't supported.
+	 * Otherwise, bits 63:60 of FAR_EL1 are KNOWN.
 	 */
-	far = (__untagged_addr(far) & ~MTE_TAG_MASK) | (far & MTE_TAG_MASK);
+	if (!cpus_have_cap(ARM64_MTE_FAR))
+		far = (__untagged_addr(far) & ~MTE_TAG_MASK) | (far & MTE_TAG_MASK);
+
 	do_bad_area(far, esr, regs);
 	return 0;
 }
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}



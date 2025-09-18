Return-Path: <linux-kernel+bounces-770520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A18B27C0C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36747623240
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BB02E6122;
	Fri, 15 Aug 2025 08:56:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB2E2E36F3;
	Fri, 15 Aug 2025 08:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248162; cv=none; b=cc6AGDRaJB9JXHl3vT6njL+y/2xCXRKayHzBmSz4GabsxzsymJnBF+gtVFDuMEPaJu1rw1US2OtBtFX5+CFfGiaJTxXyYLzcDl5wEyrOQ23+Dz4JiBK0J3YV+GUtwgUz30p99jmn+lWQcEW0zqnH/HNqdieyXRoVC/hkeTxa0aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248162; c=relaxed/simple;
	bh=q03YaUF8+LrADLsj+GAMBkSRmOXh1tilKr7kebO7eUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tyxihR+BYloPK4SzSxdz7fzT8uHIjltJ2vzDtZJu2UMP1PO3/J3f7N2QEzcibT63g/xk353Js01koiPWQlsu+mpBjLx61P1RYKJxMCQLUdkj3rpYtTFzZiQijZsUZ8guHumJ+JBhaOA8mMQrtZvPMd5sXMe+i1HduEldML9jpHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B7B31E32;
	Fri, 15 Aug 2025 01:55:52 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D84FA3F63F;
	Fri, 15 Aug 2025 01:55:55 -0700 (PDT)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@chromium.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Kees Cook <kees@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Maxwell Bland <mbland@motorola.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Pierre Langlois <pierre.langlois@arm.com>,
	Quentin Perret <qperret@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [RFC PATCH v5 07/18] arm64: Reset POR_EL1 on exception entry
Date: Fri, 15 Aug 2025 09:55:01 +0100
Message-ID: <20250815085512.2182322-8-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250815085512.2182322-1-kevin.brodsky@arm.com>
References: <20250815085512.2182322-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

POR_EL1 will be modified, through the kpkeys framework, in order to
grant temporary RW access to certain keys. If an exception occurs
in the middle of a "critical section" where POR_EL1 is set to a
privileged value, it is preferable to reset it to its default value
upon taking the exception to minimise the amount of code running at
higher kpkeys level.

This patch implements the reset of POR_EL1 on exception entry,
storing the original value in a new pt_regs field and restoring on
exception return. To avoid an expensive ISB, the register is only
reset if the interrupted value isn't the default. No check is made
on the return path as an ISB occurs anyway as part of ERET.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/kpkeys.h | 10 ++++++++++
 arch/arm64/include/asm/por.h    |  4 ++++
 arch/arm64/include/asm/ptrace.h |  4 ++++
 arch/arm64/kernel/asm-offsets.c |  3 +++
 arch/arm64/kernel/entry.S       | 24 +++++++++++++++++++++++-
 5 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kpkeys.h b/arch/arm64/include/asm/kpkeys.h
index 3b0ab5e7dd22..79ae33388088 100644
--- a/arch/arm64/include/asm/kpkeys.h
+++ b/arch/arm64/include/asm/kpkeys.h
@@ -8,6 +8,14 @@
 
 #include <asm-generic/kpkeys.h>
 
+/*
+ * Equivalent to por_set_kpkeys_level(0, KPKEYS_LVL_DEFAULT), but can also be
+ * used in assembly.
+ */
+#define POR_EL1_INIT	POR_ELx_PERM_PREP(KPKEYS_PKEY_DEFAULT, POE_RWX)
+
+#ifndef __ASSEMBLY__
+
 static inline bool arch_kpkeys_enabled(void)
 {
 	return system_supports_poe();
@@ -46,4 +54,6 @@ static __always_inline void arch_kpkeys_restore_pkey_reg(u64 pkey_reg)
 
 #endif /* CONFIG_ARM64_POE */
 
+#endif	/* __ASSEMBLY__ */
+
 #endif	/* __ASM_KPKEYS_H */
diff --git a/arch/arm64/include/asm/por.h b/arch/arm64/include/asm/por.h
index bffb4d2b1246..58dce4b8021b 100644
--- a/arch/arm64/include/asm/por.h
+++ b/arch/arm64/include/asm/por.h
@@ -10,6 +10,8 @@
 
 #define POR_EL0_INIT	POR_ELx_PERM_PREP(0, POE_RWX)
 
+#ifndef __ASSEMBLY__
+
 static inline bool por_elx_allows_read(u64 por, u8 pkey)
 {
 	u8 perm = POR_ELx_PERM_GET(pkey, por);
@@ -38,4 +40,6 @@ static inline u64 por_elx_set_pkey_perms(u64 por, u8 pkey, u64 perms)
 	return (por & ~(POE_MASK << shift)) | (perms << shift);
 }
 
+#endif	/* __ASSEMBLY__ */
+
 #endif /* _ASM_ARM64_POR_H */
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 47ff8654c5ec..e907df4225d4 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -166,6 +166,10 @@ struct pt_regs {
 	u64 orig_x0;
 	s32 syscallno;
 	u32 pmr;
+#ifdef CONFIG_ARM64_POE
+	u64 por_el1;
+	u64 __unused;
+#endif
 
 	u64 sdei_ttbr1;
 	struct frame_record_meta stackframe;
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 30d4bbe68661..8ae5cc3c203b 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -75,6 +75,9 @@ int main(void)
   DEFINE(S_SYSCALLNO,		offsetof(struct pt_regs, syscallno));
   DEFINE(S_SDEI_TTBR1,		offsetof(struct pt_regs, sdei_ttbr1));
   DEFINE(S_PMR,			offsetof(struct pt_regs, pmr));
+#ifdef CONFIG_ARM64_POE
+  DEFINE(S_POR_EL1,		offsetof(struct pt_regs, por_el1));
+#endif
   DEFINE(S_STACKFRAME,		offsetof(struct pt_regs, stackframe));
   DEFINE(S_STACKFRAME_TYPE,	offsetof(struct pt_regs, stackframe.type));
   DEFINE(PT_REGS_SIZE,		sizeof(struct pt_regs));
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index f8018b5c1f9a..0dd6f7fbb669 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -20,6 +20,7 @@
 #include <asm/errno.h>
 #include <asm/esr.h>
 #include <asm/irq.h>
+#include <asm/kpkeys.h>
 #include <asm/memory.h>
 #include <asm/mmu.h>
 #include <asm/processor.h>
@@ -277,6 +278,19 @@ alternative_else_nop_endif
 	.else
 	add	x21, sp, #PT_REGS_SIZE
 	get_current_task tsk
+#ifdef CONFIG_ARM64_POE
+alternative_if_not ARM64_HAS_S1POE
+	b	1f
+alternative_else_nop_endif
+	mrs_s	x0, SYS_POR_EL1
+	str	x0, [sp, #S_POR_EL1]
+	mov	x1, #POR_EL1_INIT
+	cmp	x0, x1
+	b.eq	1f
+	msr_s	SYS_POR_EL1, x1
+	isb
+1:
+#endif /* CONFIG_ARM64_POE */
 	.endif /* \el == 0 */
 	mrs	x22, elr_el1
 	mrs	x23, spsr_el1
@@ -407,7 +421,15 @@ alternative_else_nop_endif
 	mte_set_user_gcr tsk, x0, x1
 
 	apply_ssbd 0, x0, x1
-	.endif
+	.else
+#ifdef CONFIG_ARM64_POE
+alternative_if ARM64_HAS_S1POE
+	ldr	x0, [sp, #S_POR_EL1]
+	msr_s	SYS_POR_EL1, x0
+	/* No explicit ISB; we rely on ERET */
+alternative_else_nop_endif
+#endif /* CONFIG_ARM64_POE */
+	.endif /* \el == 0 */
 
 	msr	elr_el1, x21			// set up the return data
 	msr	spsr_el1, x22
-- 
2.47.0



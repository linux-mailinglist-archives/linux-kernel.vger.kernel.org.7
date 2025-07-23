Return-Path: <linux-kernel+bounces-742319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0A0B0EFD9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2811D583B44
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF77F2BF010;
	Wed, 23 Jul 2025 10:29:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2342900A8
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753266562; cv=none; b=QtqIN/iIZQ+DXSpmyCuG8V+BuDH6iteQiMV2SH7QNfqm++u5ytPo8jw/eLOsdqx2ebiSGGLrP8AejsPTZ9iRQ2EYIrRdaC1Vz/DND1xsJA1N2DE0fs0ws/qHwX+2mi3yHFPANSXR0X4i/SiWRlZ53dg00AZu+4u6N9dn0ypueJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753266562; c=relaxed/simple;
	bh=5unb6AYmquuXIID8CRRZS78axzvSwe4B3V9HE0QHVV8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I11yIW3vnGlw9hzKelmwqky8x9K7qzgAuRv7upSK/hrozXXC90D1hBNusYfmngMYjtP0l4Ex7kAQkvClSjkQqYb/zkUWB6nWblqq/u0XAPMhyqz5XJAaGi4PwCFe+nz0dvrmIhxyvYI4pKys/eO9yQ6xM9s1g/ibO5c5Qmp15F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A962022E6;
	Wed, 23 Jul 2025 03:29:11 -0700 (PDT)
Received: from MacBook-Pro.blr.arm.com (unknown [10.164.18.48])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BEA573F5A1;
	Wed, 23 Jul 2025 03:29:13 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: anshuman.khandual@arm.com,
	quic_zhenhuah@quicinc.com,
	ryan.roberts@arm.com,
	kevin.brodsky@arm.com,
	yangyicong@hisilicon.com,
	joey.gouly@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	david@redhat.com,
	mark.rutland@arm.com,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v5] arm64: Enable vmalloc-huge with ptdump
Date: Wed, 23 Jul 2025 15:59:05 +0530
Message-Id: <20250723102905.7894-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our goal is to move towards enabling vmalloc-huge by default on arm64 so
as to reduce TLB pressure. Therefore, we need a way to analyze the portion
of block mappings in vmalloc space we can get on a production system; this
can be done through ptdump, but currently we disable vmalloc-huge if
CONFIG_PTDUMP_DEBUGFS is on. The reason is that lazy freeing of kernel
pagetables via vmap_try_huge_pxd() may race with ptdump, so ptdump
may dereference a bogus address.

To solve this, we need to synchronize ptdump_walk_pgd() with
pud_free_pmd_page() and pmd_free_pte_page().

Since this race is very unlikely to happen in practice, we do not want to
penalize other code paths taking the init_mm mmap_lock. Therefore, we use
static keys. ptdump will enable the static key - upon observing that, the
vmalloc table freeing path will get patched in with an
mmap_read_lock/unlock sequence. A code comment explains in detail, how
a combination of acquire sematics of static_branch_enable() and the
barriers in __flush_tlb_kernel_pgtable() ensures that ptdump will never
get a hold on the address of a freed PMD or PTE table.

For an (almost) rigorous proof of correctness, one may look at:
https://lore.kernel.org/all/e1e87f16-1c48-481b-8f7c-9333ac5d13e7@arm.com/

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
Rebased on 6.16-rc7.

mm-selfests pass. No issues were observed while parallelly running
test_vmalloc.sh (which stresses the vmalloc subsystem) and dumping the
kernel pagetable through sysfs in a loop.

v4->v5:
 - The arch_vmap_pxd_supported() changes were dropped by mistake in between
   the revisions, add them back (Anshuman)
 - Rewrite cover letter, drop stray change, add arm64_ptdump_walk_pgd()
   helper, rename ptdump_lock_key -> arm64_ptdump_lock_key, add comment
   above __pmd_free_pte_page() to explain when the lock won't
   be taken (Anshuman)
 - Rewrite the comment explaining the synchronization logic (Catalin)

v3->v4:
 - Lock-unlock immediately
 - Simplify includes

v2->v3:
 - Use static key mechanism

v1->v2:
 - Take lock only when CONFIG_PTDUMP_DEBUGFS is on
 - In case of pud_free_pmd_page(), isolate the PMD table to avoid taking
   the lock 512 times again via pmd_free_pte_page()

 arch/arm64/include/asm/ptdump.h  |  2 +
 arch/arm64/include/asm/vmalloc.h |  6 +--
 arch/arm64/mm/mmu.c              | 86 ++++++++++++++++++++++++++++++--
 arch/arm64/mm/ptdump.c           | 12 ++++-
 4 files changed, 96 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
index fded5358641f..baff24004459 100644
--- a/arch/arm64/include/asm/ptdump.h
+++ b/arch/arm64/include/asm/ptdump.h
@@ -7,6 +7,8 @@
 
 #include <linux/ptdump.h>
 
+DECLARE_STATIC_KEY_FALSE(arm64_ptdump_lock_key);
+
 #ifdef CONFIG_PTDUMP
 
 #include <linux/mm_types.h>
diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
index 12f534e8f3ed..e835fd437ae0 100644
--- a/arch/arm64/include/asm/vmalloc.h
+++ b/arch/arm64/include/asm/vmalloc.h
@@ -12,15 +12,13 @@ static inline bool arch_vmap_pud_supported(pgprot_t prot)
 	/*
 	 * SW table walks can't handle removal of intermediate entries.
 	 */
-	return pud_sect_supported() &&
-	       !IS_ENABLED(CONFIG_PTDUMP_DEBUGFS);
+	return pud_sect_supported();
 }
 
 #define arch_vmap_pmd_supported arch_vmap_pmd_supported
 static inline bool arch_vmap_pmd_supported(pgprot_t prot)
 {
-	/* See arch_vmap_pud_supported() */
-	return !IS_ENABLED(CONFIG_PTDUMP_DEBUGFS);
+	return true;
 }
 
 #define arch_vmap_pte_range_map_size arch_vmap_pte_range_map_size
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 00ab1d648db6..49932c1dd34e 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -46,6 +46,8 @@
 #define NO_CONT_MAPPINGS	BIT(1)
 #define NO_EXEC_MAPPINGS	BIT(2)	/* assumes FEAT_HPDS is not used */
 
+DEFINE_STATIC_KEY_FALSE(arm64_ptdump_lock_key);
+
 enum pgtable_type {
 	TABLE_PTE,
 	TABLE_PMD,
@@ -1267,7 +1269,12 @@ int pmd_clear_huge(pmd_t *pmdp)
 	return 1;
 }
 
-int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
+/*
+ * If PMD has been isolated via pud_free_pmd_page(), ptdump cannot get
+ * a hold to it, so no need to serialize with mmap_lock, hence lock
+ * will be passed as false here. Otherwise, lock will be true.
+ */
+static int __pmd_free_pte_page(pmd_t *pmdp, unsigned long addr, bool lock)
 {
 	pte_t *table;
 	pmd_t pmd;
@@ -1279,13 +1286,24 @@ int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
 		return 1;
 	}
 
+	/* See comment in pud_free_pmd_page for static key logic */
 	table = pte_offset_kernel(pmdp, addr);
 	pmd_clear(pmdp);
 	__flush_tlb_kernel_pgtable(addr);
+	if (static_branch_unlikely(&arm64_ptdump_lock_key) && lock) {
+		mmap_read_lock(&init_mm);
+		mmap_read_unlock(&init_mm);
+	}
+
 	pte_free_kernel(NULL, table);
 	return 1;
 }
 
+int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
+{
+	return __pmd_free_pte_page(pmdp, addr, true);
+}
+
 int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
 {
 	pmd_t *table;
@@ -1301,16 +1319,76 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
 	}
 
 	table = pmd_offset(pudp, addr);
+
+	/*
+	 * Our objective is to prevent ptdump from reading a PMD table which has
+	 * been freed.  Assume that ptdump_walk_pgd() (call this thread T1)
+	 * executes completely on CPU1 and pud_free_pmd_page() (call this thread
+	 * T2) executes completely on CPU2. Let the region sandwiched by the
+	 * mmap_write_lock/unlock in T1 be called CS (the critical section).
+	 *
+	 * Claim: The CS of T1 will never operate on a freed PMD table.
+	 *
+	 * Proof:
+	 *
+	 * Case 1: The static branch is visible to T2.
+	 *
+	 * Case 1 (a): T1 acquires the lock before T2 can.
+	 * T2 will block until T1 drops the lock, so pmd_free() will only be
+	 * executed after T1 exits CS.
+	 *
+	 * Case 1 (b): T2 acquires the lock before T1 can.
+	 * The sequence of barriers issued in __flush_tlb_kernel_pgtable()
+	 * ensures that an empty PUD (via pud_clear()) is visible to T1 before
+	 * T1 can enter CS, therefore it is impossible for the CS to get hold
+	 * of the address of the isolated PMD table.
+	 *
+	 * Case 2: The static branch is not visible to T2.
+	 *
+	 * Since static_branch_enable() (via dmb(ish)) and mmap_write_lock()
+	 * have acquire semantics, it is guaranteed that the static branch
+	 * will be visible to all CPUs before T1 can enter CS. The static
+	 * branch not being visible to T2 therefore guarantees that T1 has
+	 * not yet entered CS .... (i)
+	 * The sequence of barriers via __flush_tlb_kernel_pgtable() in T2
+	 * implies that if the invisibility of the static branch has been
+	 * observed by T2 (i.e static_branch_unlikely() is observed as false),
+	 * then all CPUs will have observed an empty PUD ... (ii)
+	 * Combining (i) and (ii), we conclude that T1 observes an empty PUD
+	 * before entering CS => it is impossible for the CS to get hold of
+	 * the address of the isolated PMD table. Q.E.D
+	 *
+	 * We have proven that the claim is true on the assumption that
+	 * there is no context switch for T1 and T2. Note that the reasoning
+	 * of the proof uses barriers operating on the inner shareable domain,
+	 * which means that they will affect all CPUs, and also a context switch
+	 * will insert extra barriers into the code paths => the claim will
+	 * stand true even if we drop the assumption.
+	 *
+	 * It is also worth reasoning whether something can go wrong via
+	 * pud_free_pmd_page() -> __pmd_free_pte_page(), since the latter
+	 * will be called locklessly on this code path.
+	 *
+	 * For Case 1 (a), T2 will block until CS is finished, so we are safe.
+	 * For Case 1 (b) and Case 2, the PMD table will be isolated before
+	 * T1 can enter CS, therefore it is safe for T2 to operate on the
+	 * PMD table locklessly.
+	 */
+	pud_clear(pudp);
+	__flush_tlb_kernel_pgtable(addr);
+	if (static_branch_unlikely(&arm64_ptdump_lock_key)) {
+		mmap_read_lock(&init_mm);
+		mmap_read_unlock(&init_mm);
+	}
+
 	pmdp = table;
 	next = addr;
 	end = addr + PUD_SIZE;
 	do {
 		if (pmd_present(pmdp_get(pmdp)))
-			pmd_free_pte_page(pmdp, next);
+			__pmd_free_pte_page(pmdp, next, false);
 	} while (pmdp++, next += PMD_SIZE, next != end);
 
-	pud_clear(pudp);
-	__flush_tlb_kernel_pgtable(addr);
 	pmd_free(NULL, table);
 	return 1;
 }
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 421a5de806c6..507792fa22de 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -283,6 +283,14 @@ void note_page_flush(struct ptdump_state *pt_st)
 	note_page(pt_st, 0, -1, pte_val(pte_zero));
 }
 
+static void arm64_ptdump_walk_pgd(struct ptdump_state *st,
+				  struct mm_struct *mm, pgd_t *pgd)
+{
+	static_branch_enable(&arm64_ptdump_lock_key);
+	ptdump_walk_pgd(&st.ptdump, &init_mm, NULL);
+	static_branch_disable(&arm64_ptdump_lock_key);
+}
+
 void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
 {
 	unsigned long end = ~0UL;
@@ -311,7 +319,7 @@ void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
 		}
 	};
 
-	ptdump_walk_pgd(&st.ptdump, info->mm, NULL);
+	arm64_ptdump_walk_pgd(&st.ptdump, info->mm, NULL);
 }
 
 static void __init ptdump_initialize(void)
@@ -353,7 +361,7 @@ bool ptdump_check_wx(void)
 		}
 	};
 
-	ptdump_walk_pgd(&st.ptdump, &init_mm, NULL);
+	arm64_ptdump_walk_pgd(&st.ptdump, info->mm, NULL);
 
 	if (st.wx_pages || st.uxn_pages) {
 		pr_warn("Checked W+X mappings: FAILED, %lu W+X pages found, %lu non-UXN pages found\n",
-- 
2.30.2



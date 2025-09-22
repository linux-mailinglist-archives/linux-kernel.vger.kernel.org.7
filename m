Return-Path: <linux-kernel+bounces-826719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38170B8F2EB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB416179132
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 06:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4322F0670;
	Mon, 22 Sep 2025 06:41:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0FE2475C7
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758523299; cv=none; b=Id5BEscXgXB+RfcjC9mJIULc4dOyTTrVA3OORFHQd7ge+HIb9F1tVr1uXz/O98/3YJBXLc2MzEeP52ckqZaLTgSd+hJTWkq9WkXEfQ4P8DlQkqCE1viChylhSXmqKUC4QxN2tIjIADdzTPddn8iTDu25eza6pJipx4GvoavosM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758523299; c=relaxed/simple;
	bh=RJm3hGQ/y4dCLATL2eyTpq8/p3BYK/UFzGLjeommE2I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SFavPAmxpxLWJyKO6vH9x6Z5Kq0ztqTxagicQOp4hpoW/IM3vPLgL5s+vMADjSGSCIZ/BvgrKlo/sZHTySMVpaLNtZd2ngkizQHsWLqsPF1tVAKDR+Dxnkv5H30RBuU9XDXYMA+a5wYvJiGoF9AQ6YOS2DfAaV9ES4stry+Sh38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB3C21515;
	Sun, 21 Sep 2025 23:41:27 -0700 (PDT)
Received: from MacBook-Pro.blr.arm.com (MacBook-Pro.blr.arm.com [10.164.18.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EF7113F66E;
	Sun, 21 Sep 2025 23:41:31 -0700 (PDT)
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
	urezki@gmail.com,
	jthoughton@google.com,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v6] arm64: Enable vmalloc-huge with ptdump
Date: Mon, 22 Sep 2025 12:11:26 +0530
Message-Id: <20250922064126.63016-1-dev.jain@arm.com>
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

To solve this, we need to synchronize ptdump_walk() and ptdump_check_wx()
with pud_free_pmd_page() and pmd_free_pte_page().

Since this race is very unlikely to happen in practice, we do not want to
penalize the vmalloc pagetable tearing path by taking the init_mm
mmap_lock. Therefore, we use static keys. ptdump_walk() and
ptdump_check_wx() are the pagetable walkers; they will enable the static
key - upon observing that, the vmalloc pagetable tearing path will get
patched in with an mmap_read_lock/unlock sequence. A combination of the
patched-in mmap_read_lock/unlock, the acquire semantics of
static_branch_inc(), and the barriers in __flush_tlb_kernel_pgtable()
ensures that ptdump will never get a hold on the address of a freed PMD
or PTE table.

We can verify the correctness of the algorithm via the following litmus
test (thanks to James Houghton and Will Deacon):

AArch64 ptdump
Variant=Ifetch
{
uint64_t pud=0xa110c;
uint64_t pmd;

0:X0=label:"P1:L0"; 0:X1=instr:"NOP"; 0:X2=lock; 0:X3=pud; 0:X4=pmd;
                    1:X1=0xdead;      1:X2=lock; 1:X3=pud; 1:X4=pmd;
}
 P0				| P1				;
 (* static_key_enable *)	| (* pud_free_pmd_page *)	;
 STR	W1, [X0]		| LDR	X9, [X3]		;
 DC	CVAU,X0			| STR	XZR, [X3]		;
 DSB	ISH			| DSB	ISH			;
 IC	IVAU,X0			| ISB				;
 DSB	ISH			|				;
 ISB				| (* static key *)		;
				| L0:				;
 (* mmap_lock *)		| B	out1			;
 Lwlock:			|				;
 MOV	W7, #1			| (* mmap_lock *)		;
 SWPA	W7, W8, [X2]		| Lrlock:			;
				| MOV	W7, #1			;
				| SWPA	W7, W8, [X2]		;
 (* walk pgtable *)		|				;
 LDR	X9, [X3]		| (* mmap_unlock *)		;
 CBZ	X9, out0		| STLR	WZR, [X2]		;
 EOR	X10, X9, X9		|				;
 LDR	X11, [X4, X10]		| out1:				;
				| EOR	X10, X9, X9		;
 out0:				| STR	X1, [X4, X10]		;

exists (0:X8=0 /\ 1:X8=0 /\	(* Lock acquisitions succeed *)
	0:X9=0xa110c /\		(* P0 sees the valid PUD ...*)
	0:X11=0xdead)		(* ... but the freed PMD *)

For an approximate written proof of why this algorithm works, please read
the code comment in [1], which is now removed for the sake of simplicity.

mm-selftests pass. No issues were observed while parallelly running
test_vmalloc.sh (which stresses the vmalloc subsystem),
and cat /sys/kernel/debug/{kernel_page_tables, check_wx_pages} in a loop.

[1] https://lore.kernel.org/all/20250723161827.15802-1-dev.jain@arm.com/

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
v5->v6:
 - Put litmus test in patch description, summarize the code comment, use
   static_branch_inc/dec to handle race from ptdump_check_wx() (Will)
 - Split lock comment, rename lock parameter, drop now-obsolete comment
   in arch_vmap_pud_supported (Anshuman)

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


 arch/arm64/include/asm/ptdump.h  |  2 ++
 arch/arm64/include/asm/vmalloc.h |  9 ++-----
 arch/arm64/mm/mmu.c              | 43 +++++++++++++++++++++++++++++---
 arch/arm64/mm/ptdump.c           | 11 ++++++--
 4 files changed, 52 insertions(+), 13 deletions(-)

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
index 12f534e8f3ed..4ec1acd3c1b3 100644
--- a/arch/arm64/include/asm/vmalloc.h
+++ b/arch/arm64/include/asm/vmalloc.h
@@ -9,18 +9,13 @@
 #define arch_vmap_pud_supported arch_vmap_pud_supported
 static inline bool arch_vmap_pud_supported(pgprot_t prot)
 {
-	/*
-	 * SW table walks can't handle removal of intermediate entries.
-	 */
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
index 183801520740..feda73165025 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -47,6 +47,8 @@
 #define NO_CONT_MAPPINGS	BIT(1)
 #define NO_EXEC_MAPPINGS	BIT(2)	/* assumes FEAT_HPDS is not used */
 
+DEFINE_STATIC_KEY_FALSE(arm64_ptdump_lock_key);
+
 u64 kimage_voffset __ro_after_init;
 EXPORT_SYMBOL(kimage_voffset);
 
@@ -1261,7 +1263,8 @@ int pmd_clear_huge(pmd_t *pmdp)
 	return 1;
 }
 
-int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
+static int __pmd_free_pte_page(pmd_t *pmdp, unsigned long addr,
+			       bool acquire_mmap_lock)
 {
 	pte_t *table;
 	pmd_t pmd;
@@ -1273,13 +1276,25 @@ int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
 		return 1;
 	}
 
+	/* See comment in pud_free_pmd_page for static key logic */
 	table = pte_offset_kernel(pmdp, addr);
 	pmd_clear(pmdp);
 	__flush_tlb_kernel_pgtable(addr);
+	if (static_branch_unlikely(&arm64_ptdump_lock_key) && acquire_mmap_lock) {
+		mmap_read_lock(&init_mm);
+		mmap_read_unlock(&init_mm);
+	}
+
 	pte_free_kernel(NULL, table);
 	return 1;
 }
 
+int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
+{
+	/* If ptdump is walking the pagetables, acquire init_mm.mmap_lock */
+	return __pmd_free_pte_page(pmdp, addr, /* acquire_mmap_lock = */ true);
+}
+
 int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
 {
 	pmd_t *table;
@@ -1295,16 +1310,36 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
 	}
 
 	table = pmd_offset(pudp, addr);
+
+	/*
+	 * Our objective is to prevent ptdump from reading a PMD table which has
+	 * been freed. In this race, if pud_free_pmd_page observes the key on
+	 * (which got flipped by ptdump) then the mmap lock sequence here will,
+	 * as a result of the mmap write lock/unlock sequence in ptdump, give
+	 * us the correct synchronization. If not, this means that ptdump has
+	 * yet not started walking the pagetables - the sequence of barriers
+	 * issued by __flush_tlb_kernel_pgtable() guarantees that ptdump will
+	 * observe an empty PUD.
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
+			/*
+			 * PMD has been isolated, so ptdump won't see it. No
+			 * need to acquire init_mm.mmap_lock.
+			 */
+			__pmd_free_pte_page(pmdp, next, /* acquire_mmap_lock = */ false);
 	} while (pmdp++, next += PMD_SIZE, next != end);
 
-	pud_clear(pudp);
-	__flush_tlb_kernel_pgtable(addr);
 	pmd_free(NULL, table);
 	return 1;
 }
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 421a5de806c6..ab9899ca1e5f 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -283,6 +283,13 @@ void note_page_flush(struct ptdump_state *pt_st)
 	note_page(pt_st, 0, -1, pte_val(pte_zero));
 }
 
+static void arm64_ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm)
+{
+	static_branch_inc(&arm64_ptdump_lock_key);
+	ptdump_walk_pgd(st, mm, NULL);
+	static_branch_dec(&arm64_ptdump_lock_key);
+}
+
 void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
 {
 	unsigned long end = ~0UL;
@@ -311,7 +318,7 @@ void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
 		}
 	};
 
-	ptdump_walk_pgd(&st.ptdump, info->mm, NULL);
+	arm64_ptdump_walk_pgd(&st.ptdump, info->mm);
 }
 
 static void __init ptdump_initialize(void)
@@ -353,7 +360,7 @@ bool ptdump_check_wx(void)
 		}
 	};
 
-	ptdump_walk_pgd(&st.ptdump, &init_mm, NULL);
+	arm64_ptdump_walk_pgd(&st.ptdump, &init_mm);
 
 	if (st.wx_pages || st.uxn_pages) {
 		pr_warn("Checked W+X mappings: FAILED, %lu W+X pages found, %lu non-UXN pages found\n",
-- 
2.30.2



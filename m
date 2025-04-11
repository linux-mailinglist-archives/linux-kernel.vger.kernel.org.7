Return-Path: <linux-kernel+bounces-599783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EECAA857D8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 11:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B085B9C1814
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 09:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45390298CB6;
	Fri, 11 Apr 2025 09:17:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F406298CA4
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744363059; cv=none; b=OwIVDkb6seWCVpqvwYGiODR8qyvLbNkTjNmTm4wLWNAuxo8l5qtiLZBdnUf56itvaIWjQ5EEYxgNRIuvBB3x5l9USKy4gKWVaeDf2paVzUWJC/QzN1QvDtpxOVgJmBnYgUr3+iblz2QVS0GPp9kH1jLj1vYst8qzsU0qurLAJBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744363059; c=relaxed/simple;
	bh=qixUW3CgZwLJUrAuBD+8XoY+t3aifaZ2mTO7uPYATng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZctXJzk7AqNmbJ4ytFWbufe0A3VLy4l6Bqvm07Or7AHHNAoZkKiJ7wabYz62JusP4Y0FoESj3wTke4PhK6GiePZcYUodK3GDMNTB5qCRAjUNpsn/oZv+Gw9sX1BgBrL9g2UAYAPUbeitghibcmnv+pTOjb/A8H0zLqLD2iUOgx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD61A1596;
	Fri, 11 Apr 2025 02:17:37 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 286563F6A8;
	Fri, 11 Apr 2025 02:17:34 -0700 (PDT)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@chromium.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Kees Cook <kees@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andy Lutomirski <luto@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Pierre Langlois <pierre.langlois@arm.com>,
	Quentin Perret <qperret@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org
Subject: [RFC PATCH v4 10/18] mm: Introduce kernel_pgtables_set_pkey()
Date: Fri, 11 Apr 2025 10:16:23 +0100
Message-ID: <20250411091631.954228-11-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250411091631.954228-1-kevin.brodsky@arm.com>
References: <20250411091631.954228-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel_pgtables_set_pkey() allows setting the pkey of all page table
pages in swapper_pg_dir, recursively. This will be needed by
kpkeys_hardened_pgtables, as it relies on all PTPs being mapped with
a non-default pkey. Those initial kernel page tables cannot
practically be assigned a non-default pkey right when they are
allocated, so mutating them during (early) boot is required.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 include/linux/mm.h |   2 +
 mm/memory.c        | 137 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 139 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ef420f4dc72c..dd1b918dc294 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4240,6 +4240,8 @@ int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *st
 int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status);
 int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
 
+int kernel_pgtables_set_pkey(int pkey);
+
 
 /*
  * mseal of userspace process's system mappings.
diff --git a/mm/memory.c b/mm/memory.c
index 2d8c265fc7d6..37c2bb35faea 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -76,6 +76,8 @@
 #include <linux/ptrace.h>
 #include <linux/vmalloc.h>
 #include <linux/sched/sysctl.h>
+#include <linux/kpkeys.h>
+#include <linux/set_memory.h>
 
 #include <trace/events/kmem.h>
 
@@ -7376,3 +7378,138 @@ void vma_pgtable_walk_end(struct vm_area_struct *vma)
 	if (is_vm_hugetlb_page(vma))
 		hugetlb_vma_unlock_read(vma);
 }
+
+static int __init set_page_pkey(void *p, int pkey)
+{
+	unsigned long addr = (unsigned long)p;
+
+	/*
+	 * swapper_pg_dir itself will be made read-only by mark_rodata_ro()
+	 * so there is no point in changing its pkey.
+	 */
+	if (p == swapper_pg_dir)
+		return 0;
+
+	return set_memory_pkey(addr, 1, pkey);
+}
+
+static int __init set_pkey_pte(pmd_t *pmd, int pkey)
+{
+	pte_t *pte;
+	int err;
+
+	pte = pte_offset_kernel(pmd, 0);
+	err = set_page_pkey(pte, pkey);
+
+	return err;
+}
+
+static int __init set_pkey_pmd(pud_t *pud, int pkey)
+{
+	pmd_t *pmd;
+	int i, err = 0;
+
+	pmd = pmd_offset(pud, 0);
+
+	err = set_page_pkey(pmd, pkey);
+	if (err)
+		return err;
+
+	for (i = 0; i < PTRS_PER_PMD; i++) {
+		if (pmd_none(pmd[i]) || pmd_bad(pmd[i]) || pmd_leaf(pmd[i]))
+			continue;
+		err = set_pkey_pte(&pmd[i], pkey);
+		if (err)
+			break;
+	}
+
+	return err;
+}
+
+static int __init set_pkey_pud(p4d_t *p4d, int pkey)
+{
+	pud_t *pud;
+	int i, err = 0;
+
+	if (mm_pmd_folded(&init_mm))
+		return set_pkey_pmd((pud_t *)p4d, pkey);
+
+	pud = pud_offset(p4d, 0);
+
+	err = set_page_pkey(pud, pkey);
+	if (err)
+		return err;
+
+	for (i = 0; i < PTRS_PER_PUD; i++) {
+		if (pud_none(pud[i]) || pud_bad(pud[i]) || pud_leaf(pud[i]))
+			continue;
+		err = set_pkey_pmd(&pud[i], pkey);
+		if (err)
+			break;
+	}
+
+	return err;
+}
+
+static int __init set_pkey_p4d(pgd_t *pgd, int pkey)
+{
+	p4d_t *p4d;
+	int i, err = 0;
+
+	if (mm_pud_folded(&init_mm))
+		return set_pkey_pud((p4d_t *)pgd, pkey);
+
+	p4d = p4d_offset(pgd, 0);
+
+	err = set_page_pkey(p4d, pkey);
+	if (err)
+		return err;
+
+	for (i = 0; i < PTRS_PER_P4D; i++) {
+		if (p4d_none(p4d[i]) || p4d_bad(p4d[i]) || p4d_leaf(p4d[i]))
+			continue;
+		err = set_pkey_pud(&p4d[i], pkey);
+		if (err)
+			break;
+	}
+
+	return err;
+}
+
+/**
+ * kernel_pgtables_set_pkey - set pkey for all kernel page table pages
+ * @pkey: pkey to set the page table pages to
+ *
+ * Walks swapper_pg_dir setting the protection key of every page table page (at
+ * all levels) to @pkey. swapper_pg_dir itself is left untouched as it is
+ * expected to be mapped read-only by mark_rodata_ro().
+ *
+ * No-op if the architecture does not support kpkeys.
+ */
+int __init kernel_pgtables_set_pkey(int pkey)
+{
+	pgd_t *pgd = swapper_pg_dir;
+	int i, err = 0;
+
+	if (!arch_kpkeys_enabled())
+		return 0;
+
+	spin_lock(&init_mm.page_table_lock);
+
+	if (mm_p4d_folded(&init_mm)) {
+		err = set_pkey_p4d(pgd, pkey);
+		goto out;
+	}
+
+	for (i = 0; i < PTRS_PER_PGD; i++) {
+		if (pgd_none(pgd[i]) || pgd_bad(pgd[i]) || pgd_leaf(pgd[i]))
+			continue;
+		err = set_pkey_p4d(&pgd[i], pkey);
+		if (err)
+			break;
+	}
+
+out:
+	spin_unlock(&init_mm.page_table_lock);
+	return err;
+}
-- 
2.47.0



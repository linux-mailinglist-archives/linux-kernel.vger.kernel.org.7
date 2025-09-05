Return-Path: <linux-kernel+bounces-802113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E631B44DB8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504E54888AD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 05:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339C7279DB4;
	Fri,  5 Sep 2025 05:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VbYQttwt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E1727817F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 05:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757051622; cv=none; b=bty7rhNUgtJFppLRqn3V/z1gPLLYjNz4z01thXwZVhF4UsyR4hsF2pyQWMixga98501RvGga6/frdpv2HT96hYSI7WVycTcbkffzdtXWW4i0G/2D200wZ07472hjl4vBkgMrPA+r3Ss+uebddDXP4DPPrRpMA0EUg+LCqIKl/lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757051622; c=relaxed/simple;
	bh=P5JIGWb9iyY68T6yIl818j1UQ6wwXyHZGcqrfTEb9vQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LzTXtjDPXNeDqjcHT8TNvRvl5aWqUKsoam9cv9HfpswmruovzGfx4JBhngYpNlwYiaC3f8XoSi1BKiSwVY7EXhf0ryh0D0jYIlxuY9OoSjVgI6Qnt/8+dDz5K/woh8crgvf/ILuaNZpGa+egWboEfqLO1FZnov1pWDY2yE6yuLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VbYQttwt; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757051621; x=1788587621;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P5JIGWb9iyY68T6yIl818j1UQ6wwXyHZGcqrfTEb9vQ=;
  b=VbYQttwt1WC9GTVfGl3rarb0pzuzWLyZRze8Wycr5dtK/e+RzgcMR7Jn
   9JZtjHMw3pLK/5wy9CLLWrfd1pbVEaSPX3YDVy8nK1H8gysSO6PDSTsxB
   /mTl0fI1TSawOwaIgCzavsVz+anqPZnB/zWRBcUVi/YUx/zk4yyIUmdNP
   meMD4U+nmKjeJmkw314V1Q/Sh+tYvWNKymkNU9QCAeK8Xca3la8ecDVIy
   WBKQ+Jrhu7sLbDQC+5CpvBGZMtA561oOPoHcSduMcd819Zg5BVHrx5Os2
   bjWQVcnOsGLYTq3Fz6wQdNO5tI9z+X6uoKoiBcPvT8f3+JCUaxhvrmmhH
   w==;
X-CSE-ConnectionGUID: n8mCuprHSvqy+Lir5dBydA==
X-CSE-MsgGUID: vIVGszFdRdG7UWT4mOaJrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="70015153"
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="70015153"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 22:53:40 -0700
X-CSE-ConnectionGUID: wOiXTeePT1eXARJ/B23wag==
X-CSE-MsgGUID: WvaM95+WTbCD7Ulx+jogRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="209257761"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa001.jf.intel.com with ESMTP; 04 Sep 2025 22:53:36 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>,
	Yi Lai <yi1.lai@intel.com>
Cc: iommu@lists.linux.dev,
	security@kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 6/8] mm: Introduce deferred freeing for kernel page tables
Date: Fri,  5 Sep 2025 13:51:01 +0800
Message-ID: <20250905055103.3821518-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905055103.3821518-1-baolu.lu@linux.intel.com>
References: <20250905055103.3821518-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Hansen <dave.hansen@linux.intel.com>

On x86 and other architectures that map the kernel's virtual address space
into the upper portion of every process's page table, the IOMMU's paging
structure caches can become stale when the CPU page table is shared with
IOMMU in the Shared Virtual Address (SVA) context. This occurs when a page
used for the kernel's page tables is freed and reused without the IOMMU
being notified.

While the IOMMU driver is notified of changes to user virtual address
mappings, there is no similar notification mechanism for kernel page
table changes. This can lead to data corruption or system instability
when Shared Virtual Address (SVA) is enabled, as the IOMMU's internal
caches may retain stale entries for kernel virtual addresses.

This introduces a conditional asynchronous mechanism, enabled by
CONFIG_ASYNC_PGTABLE_FREE. When enabled, this mechanism defers the freeing
of pages that are used as page tables for kernel address mappings. These
pages are now queued to a work struct instead of being freed immediately.

This deferred freeing provides a safe context for a future patch to add
an IOMMU-specific callback, which might be expensive on large-scale
systems. This ensures the necessary IOMMU cache invalidation is performed
before the page is finally returned to the page allocator outside of any
critical, non-sleepable path.

In the current kernel, some page table pages are allocated with an
associated struct ptdesc, while others are not. Those without a ptdesc are
freed using free_pages() and its variants, which bypasses the destructor
that pagetable_dtor_free() would run. While the long-term plan is to
convert all page table pages to use struct ptdesc, this uses a temporary
flag within ptdesc to indicate whether a page needs a destructor,
considering that this aims to fix a potential security issue in IOMMU SVA.
The flag and its associated logic can be removed once the conversion is
complete.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/mm.h   | 16 +++++++++++++---
 mm/pgtable-generic.c | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 668d519edc0f..6d10715ecbb0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2891,6 +2891,14 @@ static inline void __pagetable_free(struct ptdesc *pt)
 	__free_pages(page, compound_order(page));
 }
 
+#ifdef CONFIG_ASYNC_PGTABLE_FREE
+void pagetable_free_async(struct ptdesc *pt);
+#else
+static inline void pagetable_free_async(struct ptdesc *pt)
+{
+	__pagetable_free(pt);
+}
+#endif
 /**
  * pagetable_free - Free pagetables
  * @pt:	The page table descriptor
@@ -2900,10 +2908,12 @@ static inline void __pagetable_free(struct ptdesc *pt)
  */
 static inline void pagetable_free(struct ptdesc *pt)
 {
-	if (ptdesc_test_kernel(pt))
+	if (ptdesc_test_kernel(pt)) {
 		ptdesc_clear_kernel(pt);
-
-	__pagetable_free(pt);
+		pagetable_free_async(pt);
+	} else {
+		__pagetable_free(pt);
+	}
 }
 
 #if defined(CONFIG_SPLIT_PTE_PTLOCKS)
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 567e2d084071..cf884e8300ca 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -406,3 +406,42 @@ pte_t *__pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
 	pte_unmap_unlock(pte, ptl);
 	goto again;
 }
+
+#ifdef CONFIG_ASYNC_PGTABLE_FREE
+static void kernel_pgtable_work_func(struct work_struct *work);
+
+static struct {
+	struct list_head list;
+	/* protect above ptdesc lists */
+	spinlock_t lock;
+	struct work_struct work;
+} kernel_pgtable_work = {
+	.list = LIST_HEAD_INIT(kernel_pgtable_work.list),
+	.lock = __SPIN_LOCK_UNLOCKED(kernel_pgtable_work.lock),
+	.work = __WORK_INITIALIZER(kernel_pgtable_work.work, kernel_pgtable_work_func),
+};
+
+static void kernel_pgtable_work_func(struct work_struct *work)
+{
+	struct ptdesc *pt, *next;
+	LIST_HEAD(page_list);
+
+	spin_lock(&kernel_pgtable_work.lock);
+	list_splice_tail_init(&kernel_pgtable_work.list, &page_list);
+	spin_unlock(&kernel_pgtable_work.lock);
+
+	list_for_each_entry_safe(pt, next, &page_list, pt_list) {
+		list_del(&pt->pt_list);
+		__pagetable_free(pt);
+	}
+}
+
+void pagetable_free_async(struct ptdesc *pt)
+{
+	spin_lock(&kernel_pgtable_work.lock);
+	list_add(&pt->pt_list, &kernel_pgtable_work.list);
+	spin_unlock(&kernel_pgtable_work.lock);
+
+	schedule_work(&kernel_pgtable_work.work);
+}
+#endif
-- 
2.43.0



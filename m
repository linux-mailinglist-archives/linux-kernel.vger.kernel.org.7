Return-Path: <linux-kernel+bounces-756369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC2BB1B329
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F9518A2970
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992D626C3BC;
	Tue,  5 Aug 2025 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M8wrCYB/"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34AC238C16
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 12:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754396057; cv=none; b=b0Q/MqL06nP4d50ySTEKuWWl+ndbV0QCscY5/3inRrV9p4cbA/I9iiilk+XTnhkpHTxe4Ygc2P6zjHW63beNN8zCVPIzH2oaQWr+W6UVKTPKXSir/+tiMwSWXgBHC2HgI6OlK5bLRv57QCuVw8qsBXKnOQ0UL9AphjcUdxFrb40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754396057; c=relaxed/simple;
	bh=aTLAUulJIvJgSyzlUdmFO/9rEiTuo56QdAsuinqrIAA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AXhSMey7QAsj+c1EEPsguRpPfJN29U9KSMJtg9+8XcFN5zQ8FYitWiLzzJbEXzIZlkdzyYzH+CvMX0s4KlPrAvhjWlcMIZYHv6G6UaI//QTOnOCmxJbkao88fataPv14ZqGtobDQgR1o26Jrq/EsLrxtjYI2E9aiuum0GuRs54A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M8wrCYB/; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b427c287cdfso352172a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 05:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754396055; x=1755000855; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZzF7DGeEUFEW73nufhH2gRERAerFhddc4J1uzX/Ul1Q=;
        b=M8wrCYB/tSeEeW0MLl/uPryJ7r1Sl2/rhTx/4CpqoKVKstj5Ag6aoeCJ4Xq3JsJuef
         QbIZQN3a8MvIrQjZwFFWiROfMytRSBZ0ut6G+SmdTbw0/P2WLo73+mjz3a1+uGQWG3sN
         qi2fQ1Ez72UNYi9E1iUVWHZ9NoFMAxrTkrB+YwhXc1tmCFsh2E2HLUw2XHSpbKxFJZ8p
         CxeaLB7NYQCG5rRPVAhT1mYs/w6Ny9zQYdXjOB1uYKiUwXTptjNYAWdYcwwL8p5IMq/0
         Zp4ULRvwOvb87Bndu3m8lSQPuO3N6PqZQ9wBftrt3UuVzJbdIovoiRoTDTaAdZAR1KWV
         9LhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754396055; x=1755000855;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZzF7DGeEUFEW73nufhH2gRERAerFhddc4J1uzX/Ul1Q=;
        b=iHL6dcGEd8SUzLxXcsP9gwIa5rIPD85/sBaHYRmaDxUghwxpGuy1h3KP6R28Vw/jW8
         u8Ex4fgNFCoHsOntP9OCfOUU58OP4W/ohDVFn0qRmV0MXwlA9CxuiLrNug+AAuiCp89z
         7P8lNF72O3nHy3slALeuJeROvslUejf0DJQ7xdRlZK85LE/zFB1F2wWVCT2wx2AWeVQz
         C3k3lWgTsz0AJV427vagkCgMibdMc1DoIEyea9A477qbLaFImhQxTZGV7KsvQ8dkVwAB
         EhLIi8yFpl9FXGGfD08+uKENUZg/oXKpm4TNeZuRPz/amgFjeJkxe+DQimctnBc/kEwn
         EBDw==
X-Forwarded-Encrypted: i=1; AJvYcCUnHq1GTmmiGcLVkkOUoMxYvlxgUraR3I6ELNqmMUX/lxJZXoCvZCQ8d8uu5fGp1oVEWKQmkYuZPxdRphs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3gob+U3OnQmfbvpYTWwJW9jrosLb+E2dk7ixtrjk1NQFnPTiL
	yBebpjfqgS2tUhmTQsGbagq8uvSkKZJSlDm+hEETynpCAwWMzYxE/5hxBawJszsD2XSD/Z4eKeB
	1y1M4DcSNE2X+u5m82ZrcUyEBKw==
X-Google-Smtp-Source: AGHT+IF8Oi619hEHx5HgrY25vqiCr2U0ETURa4UydnVdkhJVp1qynSccgxjHXkhCHze+LNmVGPqSRpBTb8yD1JmeGQ==
X-Received: from ploc12.prod.google.com ([2002:a17:902:848c:b0:240:770f:72d2])
 (user=lokeshgidra job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e547:b0:240:3bb7:fdc3 with SMTP id d9443c01a7336-24246feb25dmr173782505ad.28.1754396054997;
 Tue, 05 Aug 2025 05:14:14 -0700 (PDT)
Date: Tue,  5 Aug 2025 05:14:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250805121410.1658418-1-lokeshgidra@google.com>
Subject: [PATCH v2] userfaultfd: opportunistic TLB-flush batching for present
 pages in MOVE
From: Lokesh Gidra <lokeshgidra@google.com>
To: akpm@linux-foundation.org
Cc: aarcange@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	21cnbao@gmail.com, ngeoffray@google.com, 
	Lokesh Gidra <lokeshgidra@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, Barry Song <v-songbaohua@oppo.com>, 
	David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"

MOVE ioctl's runtime is dominated by TLB-flush cost, which is required
for moving present pages. Mitigate this cost by opportunistically
batching present contiguous pages for TLB flushing.

Without batching, in our testing on an arm64 Android device with UFFD GC,
which uses MOVE ioctl for compaction, we observed that out of the total
time spent in move_pages_pte(), over 40% is in ptep_clear_flush(), and
~20% in vm_normal_folio().

With batching, the proportion of vm_normal_folio() increases to over
70% of move_pages_pte() without any changes to vm_normal_folio().
Furthermore, time spent within move_pages_pte() is only ~20%, which
includes TLB-flush overhead.

Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: Barry Song <v-songbaohua@oppo.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
---
Changes since v1 [1]
- Removed flush_tlb_batched_pending(), per Barry Song
- Unified single and multi page case, per Barry Song

[1] https://lore.kernel.org/all/20250731104726.103071-1-lokeshgidra@google.com/

 mm/userfaultfd.c | 171 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 119 insertions(+), 52 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index cbed91b09640..0ab51bcf264c 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1026,18 +1026,61 @@ static inline bool is_pte_pages_stable(pte_t *dst_pte, pte_t *src_pte,
 	       pmd_same(dst_pmdval, pmdp_get_lockless(dst_pmd));
 }
 
-static int move_present_pte(struct mm_struct *mm,
-			    struct vm_area_struct *dst_vma,
-			    struct vm_area_struct *src_vma,
-			    unsigned long dst_addr, unsigned long src_addr,
-			    pte_t *dst_pte, pte_t *src_pte,
-			    pte_t orig_dst_pte, pte_t orig_src_pte,
-			    pmd_t *dst_pmd, pmd_t dst_pmdval,
-			    spinlock_t *dst_ptl, spinlock_t *src_ptl,
-			    struct folio *src_folio)
+/*
+ * Checks if the two ptes and the corresponding folio are eligible for batched
+ * move. If so, then returns pointer to the folio, after locking it. Otherwise,
+ * returns NULL.
+ */
+static struct folio *check_ptes_for_batched_move(struct vm_area_struct *src_vma,
+						 unsigned long src_addr,
+						 pte_t *src_pte, pte_t *dst_pte)
+{
+	pte_t orig_dst_pte, orig_src_pte;
+	struct folio *folio;
+
+	orig_dst_pte = ptep_get(dst_pte);
+	if (!pte_none(orig_dst_pte))
+		return NULL;
+
+	orig_src_pte = ptep_get(src_pte);
+	if (pte_none(orig_src_pte) || !pte_present(orig_src_pte) ||
+	    is_zero_pfn(pte_pfn(orig_src_pte)))
+		return NULL;
+
+	folio = vm_normal_folio(src_vma, src_addr, orig_src_pte);
+	if (!folio || !folio_trylock(folio))
+		return NULL;
+	if (!PageAnonExclusive(&folio->page) || folio_test_large(folio)) {
+		folio_unlock(folio);
+		return NULL;
+	}
+	return folio;
+}
+
+static long move_present_ptes(struct mm_struct *mm,
+			      struct vm_area_struct *dst_vma,
+			      struct vm_area_struct *src_vma,
+			      unsigned long dst_addr, unsigned long src_addr,
+			      pte_t *dst_pte, pte_t *src_pte,
+			      pte_t orig_dst_pte, pte_t orig_src_pte,
+			      pmd_t *dst_pmd, pmd_t dst_pmdval,
+			      spinlock_t *dst_ptl, spinlock_t *src_ptl,
+			      struct folio *src_folio, unsigned long len)
 {
 	int err = 0;
+	unsigned long src_start = src_addr;
+	unsigned long addr_end;
 
+	if (len > PAGE_SIZE) {
+		addr_end = (dst_addr + PMD_SIZE) & PMD_MASK;
+		if (dst_addr + len > addr_end)
+			len = addr_end - dst_addr;
+
+		addr_end = (src_addr + PMD_SIZE) & PMD_MASK;
+		if (src_addr + len > addr_end)
+			len = addr_end - src_addr;
+	}
+	flush_cache_range(src_vma, src_addr, src_addr + len);
 	double_pt_lock(dst_ptl, src_ptl);
 
 	if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_src_pte,
@@ -1051,31 +1094,53 @@ static int move_present_pte(struct mm_struct *mm,
 		err = -EBUSY;
 		goto out;
 	}
+	arch_enter_lazy_mmu_mode();
+
+	addr_end = src_start + len;
+	while (true) {
+		orig_src_pte = ptep_get_and_clear(mm, src_addr, src_pte);
+		/* Folio got pinned from under us. Put it back and fail the move. */
+		if (folio_maybe_dma_pinned(src_folio)) {
+			set_pte_at(mm, src_addr, src_pte, orig_src_pte);
+			err = -EBUSY;
+			break;
+		}
 
-	orig_src_pte = ptep_clear_flush(src_vma, src_addr, src_pte);
-	/* Folio got pinned from under us. Put it back and fail the move. */
-	if (folio_maybe_dma_pinned(src_folio)) {
-		set_pte_at(mm, src_addr, src_pte, orig_src_pte);
-		err = -EBUSY;
-		goto out;
-	}
-
-	folio_move_anon_rmap(src_folio, dst_vma);
-	src_folio->index = linear_page_index(dst_vma, dst_addr);
+		folio_move_anon_rmap(src_folio, dst_vma);
+		src_folio->index = linear_page_index(dst_vma, dst_addr);
 
-	orig_dst_pte = folio_mk_pte(src_folio, dst_vma->vm_page_prot);
-	/* Set soft dirty bit so userspace can notice the pte was moved */
+		orig_dst_pte = folio_mk_pte(src_folio, dst_vma->vm_page_prot);
+		/* Set soft dirty bit so userspace can notice the pte was moved */
 #ifdef CONFIG_MEM_SOFT_DIRTY
-	orig_dst_pte = pte_mksoft_dirty(orig_dst_pte);
+		orig_dst_pte = pte_mksoft_dirty(orig_dst_pte);
 #endif
-	if (pte_dirty(orig_src_pte))
-		orig_dst_pte = pte_mkdirty(orig_dst_pte);
-	orig_dst_pte = pte_mkwrite(orig_dst_pte, dst_vma);
+		if (pte_dirty(orig_src_pte))
+			orig_dst_pte = pte_mkdirty(orig_dst_pte);
+		orig_dst_pte = pte_mkwrite(orig_dst_pte, dst_vma);
+		set_pte_at(mm, dst_addr, dst_pte, orig_dst_pte);
+
+		src_addr += PAGE_SIZE;
+		if (src_addr == addr_end)
+			break;
+		src_pte++;
+		dst_pte++;
+
+		folio_unlock(src_folio);
+		src_folio = check_ptes_for_batched_move(src_vma, src_addr, src_pte, dst_pte);
+		if (!src_folio)
+			break;
+		dst_addr += PAGE_SIZE;
+	}
+
+	arch_leave_lazy_mmu_mode();
+	if (src_addr > src_start)
+		flush_tlb_range(src_vma, src_start, src_addr);
 
-	set_pte_at(mm, dst_addr, dst_pte, orig_dst_pte);
 out:
 	double_pt_unlock(dst_ptl, src_ptl);
-	return err;
+	if (src_folio)
+		folio_unlock(src_folio);
+	return src_addr > src_start ? src_addr - src_start : err;
 }
 
 static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
@@ -1140,7 +1205,7 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
 	set_pte_at(mm, dst_addr, dst_pte, orig_src_pte);
 	double_pt_unlock(dst_ptl, src_ptl);
 
-	return 0;
+	return PAGE_SIZE;
 }
 
 static int move_zeropage_pte(struct mm_struct *mm,
@@ -1154,6 +1219,7 @@ static int move_zeropage_pte(struct mm_struct *mm,
 {
 	pte_t zero_pte;
 
+	flush_cache_range(src_vma, src_addr, src_addr + PAGE_SIZE);
 	double_pt_lock(dst_ptl, src_ptl);
 	if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_src_pte,
 				 dst_pmd, dst_pmdval)) {
@@ -1167,20 +1233,19 @@ static int move_zeropage_pte(struct mm_struct *mm,
 	set_pte_at(mm, dst_addr, dst_pte, zero_pte);
 	double_pt_unlock(dst_ptl, src_ptl);
 
-	return 0;
+	return PAGE_SIZE;
 }
 
 
 /*
- * The mmap_lock for reading is held by the caller. Just move the page
- * from src_pmd to dst_pmd if possible, and return true if succeeded
- * in moving the page.
+ * The mmap_lock for reading is held by the caller. Just move the page(s)
+ * from src_pmd to dst_pmd if possible, and return number of bytes moved.
  */
-static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
-			  struct vm_area_struct *dst_vma,
-			  struct vm_area_struct *src_vma,
-			  unsigned long dst_addr, unsigned long src_addr,
-			  __u64 mode)
+static long move_pages_ptes(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
+			    struct vm_area_struct *dst_vma,
+			    struct vm_area_struct *src_vma,
+			    unsigned long dst_addr, unsigned long src_addr,
+			    unsigned long len, __u64 mode)
 {
 	swp_entry_t entry;
 	struct swap_info_struct *si = NULL;
@@ -1196,9 +1261,8 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 	struct mmu_notifier_range range;
 	int err = 0;
 
-	flush_cache_range(src_vma, src_addr, src_addr + PAGE_SIZE);
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
-				src_addr, src_addr + PAGE_SIZE);
+				src_addr, src_addr + len);
 	mmu_notifier_invalidate_range_start(&range);
 retry:
 	/*
@@ -1257,7 +1321,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 		if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES))
 			err = -ENOENT;
 		else /* nothing to do to move a hole */
-			err = 0;
+			err = PAGE_SIZE;
 		goto out;
 	}
 
@@ -1375,10 +1439,13 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 			}
 		}
 
-		err = move_present_pte(mm,  dst_vma, src_vma,
-				       dst_addr, src_addr, dst_pte, src_pte,
-				       orig_dst_pte, orig_src_pte, dst_pmd,
-				       dst_pmdval, dst_ptl, src_ptl, src_folio);
+		err = move_present_ptes(mm, dst_vma, src_vma,
+					dst_addr, src_addr, dst_pte, src_pte,
+					orig_dst_pte, orig_src_pte, dst_pmd,
+					dst_pmdval, dst_ptl, src_ptl, src_folio, len);
+		/* folio is already unlocked by move_present_ptes() */
+		folio_put(src_folio);
+		src_folio = NULL;
 	} else {
 		struct folio *folio = NULL;
 
@@ -1732,7 +1799,7 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 {
 	struct mm_struct *mm = ctx->mm;
 	struct vm_area_struct *src_vma, *dst_vma;
-	unsigned long src_addr, dst_addr;
+	unsigned long src_addr, dst_addr, src_end;
 	pmd_t *src_pmd, *dst_pmd;
 	long err = -EINVAL;
 	ssize_t moved = 0;
@@ -1775,8 +1842,8 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 	if (err)
 		goto out_unlock;
 
-	for (src_addr = src_start, dst_addr = dst_start;
-	     src_addr < src_start + len;) {
+	for (src_addr = src_start, dst_addr = dst_start, src_end = src_start + len;
+	     src_addr < src_end;) {
 		spinlock_t *ptl;
 		pmd_t dst_pmdval;
 		unsigned long step_size;
@@ -1857,10 +1924,10 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 				break;
 			}
 
-			err = move_pages_pte(mm, dst_pmd, src_pmd,
-					     dst_vma, src_vma,
-					     dst_addr, src_addr, mode);
-			step_size = PAGE_SIZE;
+			err = move_pages_ptes(mm, dst_pmd, src_pmd,
+					      dst_vma, src_vma, dst_addr,
+					      src_addr, src_end - src_addr, mode);
+			step_size = err;
 		}
 
 		cond_resched();
@@ -1872,7 +1939,7 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 			break;
 		}
 
-		if (err) {
+		if (err < 0) {
 			if (err == -EAGAIN)
 				continue;
 			break;

base-commit: 7e161a991ea71e6ec526abc8f40c6852ebe3d946
-- 
2.50.1.565.gc32cd1483b-goog



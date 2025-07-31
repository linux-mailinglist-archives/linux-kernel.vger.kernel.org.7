Return-Path: <linux-kernel+bounces-751951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A315B16FCC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62425475A7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C08F29CB58;
	Thu, 31 Jul 2025 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wl3XsVZx"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8411F22E3E8
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753958857; cv=none; b=WZWwooqGSCfXp3rA8pnkVSYmuLST+nX+vT19FIdLn832+yHdVp/QsuybNkzHtv9RmRmYYyFr66eS1r6C1TBONVUNRqz3FRrCre+wv5yYSEzCWfbut/gxL37sQ4q2n7+qV0Q7eK9/p8f3ryktVXJlLTss+63bmQISC4484qhQx+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753958857; c=relaxed/simple;
	bh=g3Ji6mc+7HJFKKbFy1du3tjzOXrEqLV0XIgaK2MY9lE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pF1sThQlbiOmFwG9CdAioGhKxR0l9Wd1iXePrCHicHsN52xy0vxq/qW6dDxMj3vPWOa4trSz1axnL+U7JW8leBkuz2flkkpt2ySIwv7L4dvMUv3ln9Lk7H+wR+sPYf4N9M1mpl9hlU8PzGwTCihsFMEFDMNJ80PGwCfF3CL249Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wl3XsVZx; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4225b9c0d8so625703a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753958855; x=1754563655; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jmVmMC4y8g0rdBTUdQ+rlpniSResHrgoYPF/jK8n4hk=;
        b=wl3XsVZx0OBRhKU1uSOp8Alk+hMfpORbu+U1qdHbTXBZHeAGe+HeE5OY2NSu7halGU
         07iQTIN0j2RSZaXrB4ajOuViu4Erv8IJsrH9zyd7Fa+is6WSyNzM7bBs6H0n0rXqa07j
         4Pxk/e+ZwxY1MFbxLU0j0JpFQcE7AqAAr/VK7ZEcKb6D2x+yu8p69b4ZhFSaW7iDrwRK
         snzDKJuOq6eH2584PAU3j4EqbwKe7yOnqWzze7uFCUmfw4SgNpdE9LwVsg9DeZ70Qzpn
         ujm3HTe4HwHp3Qs6PArrkQLtEUlPrDFvuA8Ob/Jexq9XJsHCcQ8klMnU51FwW30cztex
         xyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753958855; x=1754563655;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jmVmMC4y8g0rdBTUdQ+rlpniSResHrgoYPF/jK8n4hk=;
        b=nd2ntzbPqAPgnlo/FhoBH96vJyMeVOwhGp2IBLDXqihHCDZlYrkotNcY/GdKyOwemc
         Fzu5z5y1aiRIPUpVgD+XI13EPAvx9OZyGsolYjiFZ97t2n6wd6CKC0o3VSq3kR+UHqcN
         msUNQmxb66CZ2xp3ZOP83E47RyFxrDtIr/596e+JWnbLjnG+UrYNrtVQW0vRhn0d+6Qg
         44pB3Kx08bOtTvId6fn44FZuu5qRSizLhfNf+XqrS7MIv3nTRNtGrbSeNfGvh2mwgmPd
         y8ccjJcrccEyMF4eTXGB4bZsCiQ5Trv28WycaO7/ice11s54gBzKXmIqUCYy8vV0TtGc
         oo2w==
X-Forwarded-Encrypted: i=1; AJvYcCUu1L1kVn7fLBs2hxXjqjZgqsw+5APqhPqGPZYmd1a+gMH68fYg3jxnG7a36tNP7I83q17Ki3lHhl4A0e0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn9VZbhgBr3B6pEhM2K6Ihp/aG0QI5O3BFlg47WjSqZeOryECE
	DFD3hF/IjFihuFyBrQyJAi2BjTguAfnVzPBliR67dE18q8SqGM9sQxF3hR2bbD0TZsIAVttF033
	cpQ2Pat7NVMLomv7NBwoJYi5fXQ==
X-Google-Smtp-Source: AGHT+IE1/tQaotfDerxo0Akpv/ZrF2UBnAJanrDy28VEqq5hoeuwi3AYJLinngOd7YlfzatpVqskhQvBnkPQaOEXLQ==
X-Received: from plbjc17.prod.google.com ([2002:a17:903:25d1:b0:23f:fa41:1de3])
 (user=lokeshgidra job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f70a:b0:240:1f19:d35c with SMTP id d9443c01a7336-24096bc750amr86995275ad.39.1753958854671;
 Thu, 31 Jul 2025 03:47:34 -0700 (PDT)
Date: Thu, 31 Jul 2025 03:47:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250731104726.103071-1-lokeshgidra@google.com>
Subject: [PATCH] userfaultfd: opportunistic TLB-flush batching for present
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
 mm/userfaultfd.c | 179 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 127 insertions(+), 52 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 8253978ee0fb..2465fb234671 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1026,18 +1026,62 @@ static inline bool is_pte_pages_stable(pte_t *dst_pte, pte_t *src_pte,
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
+	if (pte_none(orig_src_pte))
+		return NULL;
+	if (!pte_present(orig_src_pte) || is_zero_pfn(pte_pfn(orig_src_pte)))
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
+
+	if (len > PAGE_SIZE) {
+		addr_end = (dst_addr + PMD_SIZE) & PMD_MASK;
+		if (dst_addr + len > addr_end)
+			len = addr_end - dst_addr;
 
+		addr_end = (src_addr + PMD_SIZE) & PMD_MASK;
+		if (src_addr + len > addr_end)
+			len = addr_end - src_addr;
+	}
+	flush_cache_range(src_vma, src_addr, src_addr + len);
 	double_pt_lock(dst_ptl, src_ptl);
 
 	if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_src_pte,
@@ -1051,31 +1095,60 @@ static int move_present_pte(struct mm_struct *mm,
 		err = -EBUSY;
 		goto out;
 	}
+	/* Avoid batching overhead for single page case */
+	if (len > PAGE_SIZE) {
+		flush_tlb_batched_pending(mm);
+		arch_enter_lazy_mmu_mode();
+		orig_src_pte = ptep_get_and_clear(mm, src_addr, src_pte);
+	} else
+		orig_src_pte = ptep_clear_flush(src_vma, src_addr, src_pte);
+
+	addr_end = src_start + len;
+	do {
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
 
-	set_pte_at(mm, dst_addr, dst_pte, orig_dst_pte);
+		folio_unlock(src_folio);
+		src_folio = check_ptes_for_batched_move(src_vma, src_addr, src_pte, dst_pte);
+		if (!src_folio)
+			break;
+		orig_src_pte = ptep_get_and_clear(mm, src_addr, src_pte);
+		dst_addr += PAGE_SIZE;
+	} while (true);
+
+	if (len > PAGE_SIZE) {
+		arch_leave_lazy_mmu_mode();
+		if (src_addr > src_start)
+			flush_tlb_range(src_vma, src_start, src_addr);
+	}
 out:
 	double_pt_unlock(dst_ptl, src_ptl);
-	return err;
+	if (src_folio)
+		folio_unlock(src_folio);
+	return src_addr > src_start ? src_addr - src_start : err;
 }
 
 static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
@@ -1140,7 +1213,7 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
 	set_pte_at(mm, dst_addr, dst_pte, orig_src_pte);
 	double_pt_unlock(dst_ptl, src_ptl);
 
-	return 0;
+	return PAGE_SIZE;
 }
 
 static int move_zeropage_pte(struct mm_struct *mm,
@@ -1154,6 +1227,7 @@ static int move_zeropage_pte(struct mm_struct *mm,
 {
 	pte_t zero_pte;
 
+	flush_cache_range(src_vma, src_addr, src_addr + PAGE_SIZE);
 	double_pt_lock(dst_ptl, src_ptl);
 	if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_src_pte,
 				 dst_pmd, dst_pmdval)) {
@@ -1167,20 +1241,19 @@ static int move_zeropage_pte(struct mm_struct *mm,
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
@@ -1196,9 +1269,8 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 	struct mmu_notifier_range range;
 	int err = 0;
 
-	flush_cache_range(src_vma, src_addr, src_addr + PAGE_SIZE);
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
-				src_addr, src_addr + PAGE_SIZE);
+				src_addr, src_addr + len);
 	mmu_notifier_invalidate_range_start(&range);
 retry:
 	/*
@@ -1257,7 +1329,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 		if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES))
 			err = -ENOENT;
 		else /* nothing to do to move a hole */
-			err = 0;
+			err = PAGE_SIZE;
 		goto out;
 	}
 
@@ -1375,10 +1447,13 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
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
 
@@ -1732,7 +1807,7 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 {
 	struct mm_struct *mm = ctx->mm;
 	struct vm_area_struct *src_vma, *dst_vma;
-	unsigned long src_addr, dst_addr;
+	unsigned long src_addr, dst_addr, src_end;
 	pmd_t *src_pmd, *dst_pmd;
 	long err = -EINVAL;
 	ssize_t moved = 0;
@@ -1777,8 +1852,8 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 	if (err)
 		goto out_unlock;
 
-	for (src_addr = src_start, dst_addr = dst_start;
-	     src_addr < src_start + len;) {
+	for (src_addr = src_start, dst_addr = dst_start, src_end = src_start + len;
+	     src_addr < src_end;) {
 		spinlock_t *ptl;
 		pmd_t dst_pmdval;
 		unsigned long step_size;
@@ -1865,10 +1940,10 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
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
@@ -1880,7 +1955,7 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 			break;
 		}
 
-		if (err) {
+		if (err < 0) {
 			if (err == -EAGAIN)
 				continue;
 			break;

base-commit: 260f6f4fda93c8485c8037865c941b42b9cba5d2
-- 
2.50.1.552.g942d659e1b-goog



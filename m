Return-Path: <linux-kernel+bounces-761345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B205B1F89B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 08:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22F0F178647
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 06:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0242224AFA;
	Sun, 10 Aug 2025 06:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0hBnlO+Z"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAAA2E3712
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 06:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754807360; cv=none; b=QtPSp1nfPJexixhsVAFj3wGgkd8pQSzx59qgp8RzadgxJ9xCAQ8QCYrXrJ6MK/eJ5+EVLag8eMbQjJzl9WgQz0Gk0ZEManHqL7sdjC+U1cLdCzq7o1uf4O9H5Nb9CMi0JwW8qvrU94G27H/yVZ5liWzV0T5UBYrdmBF0oZ1o7Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754807360; c=relaxed/simple;
	bh=Pxbtuk2Z6xGV1/Z0OJmCy7WImBuw5HeqXQPgXqXQOio=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jQLUIGG/N5CXp+jLiYb091RGRxD6HvjLOHz0KiuCfXIGFo8S0nZCzD1dcDXYTmGhk+hD8vk05SsWQsgwv5EBZAKY2am3hBdGxVKf6lZKKAzWB2Vnt9q+gJe/J3ENSYka7IMjpWiat5Rjh1KKeg5v2o+HBnO7HaJ6NGTjdkOa86U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0hBnlO+Z; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23fed1492f6so53378545ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 23:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754807357; x=1755412157; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LvqkHo491TO4CfV7vACR5Ox7Hqn3CkZaS6CXJLveDig=;
        b=0hBnlO+ZdbN7vQhvoi9V+V0XAQ6At+2XZmEsX4L/yXaM/Avjfw2Jqa/IIrsZcaBzkI
         LXy8PwoJSKfuJ0n/DxWjMSvX82NaC5F6tFe4NgvXdeVaujXBSYuEh2+wM0Pam38KCFJI
         LAGFrqQGvy+RizgyDVpFiKN/8DWnQvfUrYt5gBbX2EXnFLFEulc+M6O/TAodLScimOf1
         UyGHMxtkBogM9xmRgXKqV8HLNXEewaCoPc0hZM8U4upwXQMQYMGXfFh3NPqtYm7GBtQP
         qqvRf7/VLxW4ilng8Qduxgc6EWgv0hap+REP3ydGpEdqXuCImTa9esz5QDo2g/1/annN
         HswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754807357; x=1755412157;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LvqkHo491TO4CfV7vACR5Ox7Hqn3CkZaS6CXJLveDig=;
        b=xGPVHt1vOX0oooCOLNwUHItK5EZoaOZZ/3mzEvQ6qd39rPsl62p3CDG+SBaptVIlFI
         Eo+FAnr1iIPshfNWx189m7F5PFgjqNjeDS4c+08MdIoA9o2APKAdo/oAm5X70UQS8Pz+
         bO+urQJLfxKDNLzsHd3iB8A9GafUyftfaO015Yf8vs0RhNDRocx6bAWa0FhI+VUU+wLF
         LzLqZPcd8zlo0UrlqaBZ08UlBRJ2r3sLHfSQUaCHQms4RCnkctp/ipR7BScLwBA9LyuF
         1JSU0vy9uMW/oGp8wyw9b55JuWAit+UO6JrX/6fOCfqDt7xHtk2BwFfRCPqKshOgWMsF
         FV1w==
X-Forwarded-Encrypted: i=1; AJvYcCWhjF6N9hqqNe2f3XGGguMFsRCZaEHhhC3Jlxx4157kuq7buTvLGpfTLzPnmVdnCiUQ4z1DAfRZgVNfX94=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbAV67CrxBG8xmjsRBRCdI5zlls3tK0x4NvhLcsRn6/SzoW8T8
	p/yvNFt5hhNrIpSdeoq/tZorwindz88lTaq/avLhTGjSy2Sj5i19fhzHZWsftS17mVSiH7JxShH
	xsqlKwZUhFau/eo72D4tFdgeN1w==
X-Google-Smtp-Source: AGHT+IF6ha+C4h/6VsCb5VyOyXNQfdzEspiOgpCSC6ANnbuoLac2T5tFdfi6fcZIyZDuq0JEpinBxeh8+Y2crauzQg==
X-Received: from ploq6.prod.google.com ([2002:a17:903:1aa6:b0:23e:3914:f342])
 (user=lokeshgidra job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:da82:b0:23f:adfa:3a63 with SMTP id d9443c01a7336-242c20a34d7mr137414275ad.16.1754807356659;
 Sat, 09 Aug 2025 23:29:16 -0700 (PDT)
Date: Sat,  9 Aug 2025 23:29:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250810062912.1096815-1-lokeshgidra@google.com>
Subject: [PATCH v4] userfaultfd: opportunistic TLB-flush batching for present
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
Changes since v3 [1]
- Fix unintialized 'step_size' warning, per Dan Carpenter
- Removed pmd_none() from check_ptes_for_batched_move(), per Peter Xu
- Removed flush_cache_range() in zero-page case, per Peter Xu
- Added comment to explain why folio reference for batched pages is not
  required, per Peter Xu
- Use MIN() in calculation of largest extent that can be batched under
  the same src and dst PTLs, per Peter Xu
- Release first folio's reference in move_present_ptes(), per Peter Xu

Changes since v2 [2]
- Addressed VM_WARN_ON failure, per Lorenzo Stoakes
- Added check to ensure all batched pages share the same anon_vma

Changes since v1 [3]
- Removed flush_tlb_batched_pending(), per Barry Song
- Unified single and multi page case, per Barry Song

[1] https://lore.kernel.org/all/20250807103902.2242717-1-lokeshgidra@google.com/
[2] https://lore.kernel.org/all/20250805121410.1658418-1-lokeshgidra@google.com/
[3] https://lore.kernel.org/all/20250731104726.103071-1-lokeshgidra@google.com/

 mm/userfaultfd.c | 178 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 127 insertions(+), 51 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index cbed91b09640..39d81d2972db 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1026,18 +1026,64 @@ static inline bool is_pte_pages_stable(pte_t *dst_pte, pte_t *src_pte,
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
+ * move. If so, then returns pointer to the locked folio. Otherwise, returns NULL.
+ *
+ * NOTE: folio's reference is not required as the whole operation is within
+ * PTL's critical section.
+ */
+static struct folio *check_ptes_for_batched_move(struct vm_area_struct *src_vma,
+						 unsigned long src_addr,
+						 pte_t *src_pte, pte_t *dst_pte,
+						 struct anon_vma *src_anon_vma)
+{
+	pte_t orig_dst_pte, orig_src_pte;
+	struct folio *folio;
+
+	orig_dst_pte = ptep_get(dst_pte);
+	if (!pte_none(orig_dst_pte))
+		return NULL;
+
+	orig_src_pte = ptep_get(src_pte);
+	if (!pte_present(orig_src_pte) || is_zero_pfn(pte_pfn(orig_src_pte)))
+		return NULL;
+
+	folio = vm_normal_folio(src_vma, src_addr, orig_src_pte);
+	if (!folio || !folio_trylock(folio))
+		return NULL;
+	if (!PageAnonExclusive(&folio->page) || folio_test_large(folio) ||
+	    folio_anon_vma(folio) != src_anon_vma) {
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
+			      struct folio **first_src_folio, unsigned long len,
+			      struct anon_vma *src_anon_vma)
 {
 	int err = 0;
+	struct folio *src_folio = *first_src_folio;
+	unsigned long src_start = src_addr;
+	unsigned long addr_end;
+
+	if (len > PAGE_SIZE) {
+		addr_end = (dst_addr + PMD_SIZE) & PMD_MASK;
+		len = MIN(addr_end - dst_addr, len);
 
+		addr_end = (src_addr + PMD_SIZE) & PMD_MASK;
+		len = MIN(addr_end - src_addr, len);
+	}
+	flush_cache_range(src_vma, src_addr, src_addr + len);
 	double_pt_lock(dst_ptl, src_ptl);
 
 	if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_src_pte,
@@ -1051,31 +1097,57 @@ static int move_present_pte(struct mm_struct *mm,
 		err = -EBUSY;
 		goto out;
 	}
+	/* It's safe to drop the reference now as the page-table is holding one. */
+	folio_put(*first_src_folio);
+	*first_src_folio = NULL;
+	arch_enter_lazy_mmu_mode();
+
+	addr_end = src_addr + len;
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
+		dst_addr += PAGE_SIZE;
+		dst_pte++;
+		src_pte++;
+
+		folio_unlock(src_folio);
+		src_folio = check_ptes_for_batched_move(src_vma, src_addr, src_pte,
+							dst_pte, src_anon_vma);
+		if (!src_folio)
+			break;
+	}
+
+	arch_leave_lazy_mmu_mode();
+	if (src_addr > src_start)
+		flush_tlb_range(src_vma, src_start, src_addr);
 
-	set_pte_at(mm, dst_addr, dst_pte, orig_dst_pte);
+	if (src_folio)
+		folio_unlock(src_folio);
 out:
 	double_pt_unlock(dst_ptl, src_ptl);
-	return err;
+	return src_addr > src_start ? src_addr - src_start : err;
 }
 
 static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
@@ -1140,7 +1212,7 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
 	set_pte_at(mm, dst_addr, dst_pte, orig_src_pte);
 	double_pt_unlock(dst_ptl, src_ptl);
 
-	return 0;
+	return PAGE_SIZE;
 }
 
 static int move_zeropage_pte(struct mm_struct *mm,
@@ -1167,20 +1239,19 @@ static int move_zeropage_pte(struct mm_struct *mm,
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
@@ -1196,9 +1267,8 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 	struct mmu_notifier_range range;
 	int err = 0;
 
-	flush_cache_range(src_vma, src_addr, src_addr + PAGE_SIZE);
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
-				src_addr, src_addr + PAGE_SIZE);
+				src_addr, src_addr + len);
 	mmu_notifier_invalidate_range_start(&range);
 retry:
 	/*
@@ -1257,7 +1327,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 		if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES))
 			err = -ENOENT;
 		else /* nothing to do to move a hole */
-			err = 0;
+			err = PAGE_SIZE;
 		goto out;
 	}
 
@@ -1375,10 +1445,11 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 			}
 		}
 
-		err = move_present_pte(mm,  dst_vma, src_vma,
-				       dst_addr, src_addr, dst_pte, src_pte,
-				       orig_dst_pte, orig_src_pte, dst_pmd,
-				       dst_pmdval, dst_ptl, src_ptl, src_folio);
+		err = move_present_ptes(mm, dst_vma, src_vma,
+					dst_addr, src_addr, dst_pte, src_pte,
+					orig_dst_pte, orig_src_pte, dst_pmd,
+					dst_pmdval, dst_ptl, src_ptl, &src_folio,
+					len, src_anon_vma);
 	} else {
 		struct folio *folio = NULL;
 
@@ -1732,7 +1803,7 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 {
 	struct mm_struct *mm = ctx->mm;
 	struct vm_area_struct *src_vma, *dst_vma;
-	unsigned long src_addr, dst_addr;
+	unsigned long src_addr, dst_addr, src_end;
 	pmd_t *src_pmd, *dst_pmd;
 	long err = -EINVAL;
 	ssize_t moved = 0;
@@ -1775,8 +1846,8 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 	if (err)
 		goto out_unlock;
 
-	for (src_addr = src_start, dst_addr = dst_start;
-	     src_addr < src_start + len;) {
+	for (src_addr = src_start, dst_addr = dst_start, src_end = src_start + len;
+	     src_addr < src_end;) {
 		spinlock_t *ptl;
 		pmd_t dst_pmdval;
 		unsigned long step_size;
@@ -1841,6 +1912,8 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 						  dst_addr, src_addr);
 			step_size = HPAGE_PMD_SIZE;
 		} else {
+			long ret;
+
 			if (pmd_none(*src_pmd)) {
 				if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES)) {
 					err = -ENOENT;
@@ -1857,10 +1930,13 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 				break;
 			}
 
-			err = move_pages_pte(mm, dst_pmd, src_pmd,
-					     dst_vma, src_vma,
-					     dst_addr, src_addr, mode);
-			step_size = PAGE_SIZE;
+			ret = move_pages_ptes(mm, dst_pmd, src_pmd,
+					      dst_vma, src_vma, dst_addr,
+					      src_addr, src_end - src_addr, mode);
+			if (ret < 0)
+				err = ret;
+			else
+				step_size = ret;
 		}
 
 		cond_resched();

base-commit: 561c80369df0733ba0574882a1635287b20f9de2
-- 
2.50.1.703.g449372360f-goog



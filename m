Return-Path: <linux-kernel+bounces-772227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1D4B2902E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 21:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FDAA5A7C8A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 19:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C53201266;
	Sat, 16 Aug 2025 19:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ujoDL0xy"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C431F4703
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 19:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755371501; cv=none; b=tx930EvPiBmoiKxexCFNmOMZLldlqsG0320eD3BzzfpU1b7tzfwL5IC9SAXP9agwWgexy67NSeto5tjdCNnuVrGlEVV5ep0OMTasvGxSBoNG3+5Ty2ypXdL26xkNwf46MGIoW9Sej+gs2AWQRrr64LYyCkcqDBRq/lXer8rQTck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755371501; c=relaxed/simple;
	bh=BpTELHwFBv6TO3y6SLHhoUWZ+rTdMBy8AnJJ4eUxABY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GYSvh2W6Q8L5jG85I5dUuca+OVCq+nkuWYQHoB4LidzPUKvvcAuMES+g6zzxOACHA0k3uiiYzeRW+96xD9Un07j1gdDQW9PEKOYKGJXMrcCzWXX9rR87Aziu5LzhJrUOIEbEW3rX2HoKi4lBxlO/zRlgawHYUHVjYyixmEqOEpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ujoDL0xy; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-244581953b8so31858335ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 12:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755371496; x=1755976296; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D2b4I74l91nF0HRNssQ7bSgGkLbdaG7n4udVN8wFuGU=;
        b=ujoDL0xyxZ1xr9bzvwqloKR3OyMasC7mmGDAwgoYbJevJSRIwbdw09rtq80hrAgOT9
         GQrb/5EQSDtL6QwMidf4ogwRdxX384Om31dW9mpZnUuRrr7jvHXVvfJe2AiQ06I4b0/6
         qjHO+VCe364Bh7V4P3Vi+r+YFMcaBUA6XGG/ahso6zFQBVEVz+mBXeGnSnjLnYOX5pLU
         VgBqQQNuW2ZrVkUvKsXZpj3RWGlpBib2DLCQI78/8VtBCDPopsHMAR2yrvtmoRgBs/9W
         JpIZR829kaittLUm7Ovz93m9R5LBR9qUCniaD9Y/RBS64swl4Rrg5GhhWkq80JPcmEoC
         Z7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755371496; x=1755976296;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D2b4I74l91nF0HRNssQ7bSgGkLbdaG7n4udVN8wFuGU=;
        b=UHcnRzT1Q9y/J+WAYtXK5pTaCPY0gPJqfZ+eyhWq2Q7m2oGF0YzDJlNBVh2tgAr7al
         dK0oTTAPfyZi4QxRGK0kKvQVAxM2XEEnGB+KGvELhhvfnvfflNjqvCOGYKqpdshFmpHB
         8cuPPT2QAULvTxhetCpDcb9RPNHW4KAuYDSAxifmYrZbeuIV5S6edplq5+zs1UZWutXe
         mDnsisIr3hzPq42nRtss+3GNuA/nWQA+8n4ezNjFv6sA8qdPVtKO8is+WEiSICLe4/j/
         EpsG3WYRq1F4THwJZZycLeBXIb636ODKRRah+3cjazH4Ug9DHYXIaSqvAWAPzawdZZ1x
         +wPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbKUuAfiOjDTGlMJebtauEppCGVOXriGtYkZfFptkX9yb6sKO6yYEf/5vtzr3HlkMlpkGLRsaoQhs9pUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybr6KkNulquttirRsIinT8uvsKlKpj2XkujpabR4htTByXJej7
	JbhJsp5kSmWpa5aoW3r4XkfowMEdksF6qZC+EKCOLLzxpvjpMPwJazDDv1SffsvXbKUrkWuFHmj
	Qe2O16Gnd+co203D3Wo+rDrDQyA==
X-Google-Smtp-Source: AGHT+IEv7ZdU4wvYCo/SVKfigEVmFu/5ziUfJ5s1mjOpawzYxvJHEyoQC3Uidz0JBv5hO62anh8pwHoDhmRHvpQd5g==
X-Received: from plbkh16.prod.google.com ([2002:a17:903:650:b0:240:718d:564a])
 (user=lokeshgidra job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:187:b0:234:aa9a:9e0f with SMTP id d9443c01a7336-24478f6356amr42485355ad.23.1755371496139;
 Sat, 16 Aug 2025 12:11:36 -0700 (PDT)
Date: Sat, 16 Aug 2025 12:11:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250816191123.3601561-1-lokeshgidra@google.com>
Subject: [PATCH v6] userfaultfd: opportunistic TLB-flush batching for present
 pages in MOVE
From: Lokesh Gidra <lokeshgidra@google.com>
To: akpm@linux-foundation.org
Cc: aarcange@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	ngeoffray@google.com, Lokesh Gidra <lokeshgidra@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>, 
	Barry Song <baohua@kernel.org>
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

When the GC intensive benchmark, which was used to gather the above
numbers, is run on cuttlefish (qemu android instance on x86_64), the
completion time of the benchmark went down from ~45mins to ~20mins.

Furthermore, system_server, one of the most performance critical system
processes on android, saw over 50% reduction in GC compaction time on an
arm64 android device.

Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: Barry Song <v-songbaohua@oppo.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Barry Song <baohua@kernel.org>
---
Changes since v5 [1]
- Make calculation of largest extent that can be batched unconditional
  on length, per Barry Song

Chagnes since v4 [2]
- Replaced 'err' with 'ret' in move_pages_ptes(), per Barry Song
- Use pmd_addr_end() for calculating largest extent that can be
  batched under the same src and dst PTLs, per Barry Song
- Add a description comment for move_present_ptes() explaining what
  conditions are to be met by folios to be batched, per Barry Song

Changes since v3 [3]
- Fix unintialized 'step_size' warning, per Dan Carpenter
- Removed pmd_none() from check_ptes_for_batched_move(), per Peter Xu
- Removed flush_cache_range() in zero-page case, per Peter Xu
- Added comment to explain why folio reference for batched pages is not
  required, per Peter Xu
- Use MIN() in calculation of largest extent that can be batched under
  the same src and dst PTLs, per Peter Xu
- Release first folio's reference in move_present_ptes(), per Peter Xu

Changes since v2 [4]
- Addressed VM_WARN_ON failure, per Lorenzo Stoakes
- Added check to ensure all batched pages share the same anon_vma

Changes since v1 [5]
- Removed flush_tlb_batched_pending(), per Barry Song
- Unified single and multi page case, per Barry Song

[1] https://lore.kernel.org/all/20250813193024.2279805-1-lokeshgidra@google.com/
[2] https://lore.kernel.org/all/20250810062912.1096815-1-lokeshgidra@google.com/
[3] https://lore.kernel.org/all/20250807103902.2242717-1-lokeshgidra@google.com/
[4] https://lore.kernel.org/all/20250805121410.1658418-1-lokeshgidra@google.com/
[5] https://lore.kernel.org/all/20250731104726.103071-1-lokeshgidra@google.com/

 mm/userfaultfd.c | 222 +++++++++++++++++++++++++++++++----------------
 1 file changed, 149 insertions(+), 73 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 45e6290e2e8b..bd7053673a3b 100644
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
+/*
+ * Moves src folios to dst in a batch as long as they share the same
+ * anon_vma as the first folio, are not large, and can successfully
+ * take the lock via folio_trylock().
+ */
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
+	unsigned long src_end;
 
+	len = pmd_addr_end(dst_addr, dst_addr + len) - dst_addr;
+	src_end = pmd_addr_end(src_addr, src_addr + len);
+	flush_cache_range(src_vma, src_addr, src_end);
 	double_pt_lock(dst_ptl, src_ptl);
 
 	if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_src_pte,
@@ -1051,31 +1097,56 @@ static int move_present_pte(struct mm_struct *mm,
 		err = -EBUSY;
 		goto out;
 	}
+	/* It's safe to drop the reference now as the page-table is holding one. */
+	folio_put(*first_src_folio);
+	*first_src_folio = NULL;
+	arch_enter_lazy_mmu_mode();
+
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
+		if (src_addr == src_end)
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
 
-	set_pte_at(mm, dst_addr, dst_pte, orig_dst_pte);
+	arch_leave_lazy_mmu_mode();
+	if (src_addr > src_start)
+		flush_tlb_range(src_vma, src_start, src_addr);
+
+	if (src_folio)
+		folio_unlock(src_folio);
 out:
 	double_pt_unlock(dst_ptl, src_ptl);
-	return err;
+	return src_addr > src_start ? src_addr - src_start : err;
 }
 
 static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
@@ -1140,7 +1211,7 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
 	set_pte_at(mm, dst_addr, dst_pte, orig_src_pte);
 	double_pt_unlock(dst_ptl, src_ptl);
 
-	return 0;
+	return PAGE_SIZE;
 }
 
 static int move_zeropage_pte(struct mm_struct *mm,
@@ -1167,20 +1238,20 @@ static int move_zeropage_pte(struct mm_struct *mm,
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
+ * On failure, an error code is returned.
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
@@ -1194,11 +1265,10 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 	struct folio *src_folio = NULL;
 	struct anon_vma *src_anon_vma = NULL;
 	struct mmu_notifier_range range;
-	int err = 0;
+	long ret = 0;
 
-	flush_cache_range(src_vma, src_addr, src_addr + PAGE_SIZE);
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
-				src_addr, src_addr + PAGE_SIZE);
+				src_addr, src_addr + len);
 	mmu_notifier_invalidate_range_start(&range);
 retry:
 	/*
@@ -1212,7 +1282,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 
 	/* Retry if a huge pmd materialized from under us */
 	if (unlikely(!dst_pte)) {
-		err = -EAGAIN;
+		ret = -EAGAIN;
 		goto out;
 	}
 
@@ -1231,14 +1301,14 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 	 * transparent huge pages under us.
 	 */
 	if (unlikely(!src_pte)) {
-		err = -EAGAIN;
+		ret = -EAGAIN;
 		goto out;
 	}
 
 	/* Sanity checks before the operation */
 	if (pmd_none(*dst_pmd) || pmd_none(*src_pmd) ||
 	    pmd_trans_huge(*dst_pmd) || pmd_trans_huge(*src_pmd)) {
-		err = -EINVAL;
+		ret = -EINVAL;
 		goto out;
 	}
 
@@ -1246,7 +1316,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 	orig_dst_pte = ptep_get(dst_pte);
 	spin_unlock(dst_ptl);
 	if (!pte_none(orig_dst_pte)) {
-		err = -EEXIST;
+		ret = -EEXIST;
 		goto out;
 	}
 
@@ -1255,21 +1325,21 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 	spin_unlock(src_ptl);
 	if (pte_none(orig_src_pte)) {
 		if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES))
-			err = -ENOENT;
+			ret = -ENOENT;
 		else /* nothing to do to move a hole */
-			err = 0;
+			ret = PAGE_SIZE;
 		goto out;
 	}
 
 	/* If PTE changed after we locked the folio them start over */
 	if (src_folio && unlikely(!pte_same(src_folio_pte, orig_src_pte))) {
-		err = -EAGAIN;
+		ret = -EAGAIN;
 		goto out;
 	}
 
 	if (pte_present(orig_src_pte)) {
 		if (is_zero_pfn(pte_pfn(orig_src_pte))) {
-			err = move_zeropage_pte(mm, dst_vma, src_vma,
+			ret = move_zeropage_pte(mm, dst_vma, src_vma,
 					       dst_addr, src_addr, dst_pte, src_pte,
 					       orig_dst_pte, orig_src_pte,
 					       dst_pmd, dst_pmdval, dst_ptl, src_ptl);
@@ -1292,14 +1362,14 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 			spin_lock(src_ptl);
 			if (!pte_same(orig_src_pte, ptep_get(src_pte))) {
 				spin_unlock(src_ptl);
-				err = -EAGAIN;
+				ret = -EAGAIN;
 				goto out;
 			}
 
 			folio = vm_normal_folio(src_vma, src_addr, orig_src_pte);
 			if (!folio || !PageAnonExclusive(&folio->page)) {
 				spin_unlock(src_ptl);
-				err = -EBUSY;
+				ret = -EBUSY;
 				goto out;
 			}
 
@@ -1313,7 +1383,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 			 */
 			if (!locked && folio_test_large(folio)) {
 				spin_unlock(src_ptl);
-				err = -EAGAIN;
+				ret = -EAGAIN;
 				goto out;
 			}
 
@@ -1332,7 +1402,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 			}
 
 			if (WARN_ON_ONCE(!folio_test_anon(src_folio))) {
-				err = -EBUSY;
+				ret = -EBUSY;
 				goto out;
 			}
 		}
@@ -1343,8 +1413,8 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 			pte_unmap(src_pte);
 			pte_unmap(dst_pte);
 			src_pte = dst_pte = NULL;
-			err = split_folio(src_folio);
-			if (err)
+			ret = split_folio(src_folio);
+			if (ret)
 				goto out;
 			/* have to reacquire the folio after it got split */
 			folio_unlock(src_folio);
@@ -1362,7 +1432,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 			src_anon_vma = folio_get_anon_vma(src_folio);
 			if (!src_anon_vma) {
 				/* page was unmapped from under us */
-				err = -EAGAIN;
+				ret = -EAGAIN;
 				goto out;
 			}
 			if (!anon_vma_trylock_write(src_anon_vma)) {
@@ -1375,10 +1445,11 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 			}
 		}
 
-		err = move_present_pte(mm,  dst_vma, src_vma,
-				       dst_addr, src_addr, dst_pte, src_pte,
-				       orig_dst_pte, orig_src_pte, dst_pmd,
-				       dst_pmdval, dst_ptl, src_ptl, src_folio);
+		ret = move_present_ptes(mm, dst_vma, src_vma,
+					dst_addr, src_addr, dst_pte, src_pte,
+					orig_dst_pte, orig_src_pte, dst_pmd,
+					dst_pmdval, dst_ptl, src_ptl, &src_folio,
+					len, src_anon_vma);
 	} else {
 		struct folio *folio = NULL;
 
@@ -1389,20 +1460,20 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 				pte_unmap(dst_pte);
 				src_pte = dst_pte = NULL;
 				migration_entry_wait(mm, src_pmd, src_addr);
-				err = -EAGAIN;
+				ret = -EAGAIN;
 			} else
-				err = -EFAULT;
+				ret = -EFAULT;
 			goto out;
 		}
 
 		if (!pte_swp_exclusive(orig_src_pte)) {
-			err = -EBUSY;
+			ret = -EBUSY;
 			goto out;
 		}
 
 		si = get_swap_device(entry);
 		if (unlikely(!si)) {
-			err = -EAGAIN;
+			ret = -EAGAIN;
 			goto out;
 		}
 		/*
@@ -1422,7 +1493,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 					swap_cache_index(entry));
 		if (!IS_ERR_OR_NULL(folio)) {
 			if (folio_test_large(folio)) {
-				err = -EBUSY;
+				ret = -EBUSY;
 				folio_put(folio);
 				goto out;
 			}
@@ -1439,7 +1510,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 				goto retry;
 			}
 		}
-		err = move_swap_pte(mm, dst_vma, dst_addr, src_addr, dst_pte, src_pte,
+		ret = move_swap_pte(mm, dst_vma, dst_addr, src_addr, dst_pte, src_pte,
 				orig_dst_pte, orig_src_pte, dst_pmd, dst_pmdval,
 				dst_ptl, src_ptl, src_folio, si, entry);
 	}
@@ -1461,7 +1532,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 	if (si)
 		put_swap_device(si);
 
-	return err;
+	return ret;
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
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
@@ -1844,6 +1915,8 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 						  dst_addr, src_addr);
 			step_size = HPAGE_PMD_SIZE;
 		} else {
+			long ret;
+
 			if (pmd_none(*src_pmd)) {
 				if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES)) {
 					err = -ENOENT;
@@ -1860,10 +1933,13 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
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

base-commit: 90d970cade8e67e20b09bbfdc2f0b52064322921
-- 
2.51.0.rc1.163.g2494970778-goog



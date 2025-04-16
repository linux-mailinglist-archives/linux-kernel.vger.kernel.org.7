Return-Path: <linux-kernel+bounces-604054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D50AA89006
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 01:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 705C31899F02
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 23:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5F21F542A;
	Mon, 14 Apr 2025 23:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JSQfY5Q3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B151F417D
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 23:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744672749; cv=none; b=O59KsqXVruh89tEb5zW+54YeHr79mZyfMP12leJm93oLJ8dukctAhSjOyOgYgO+Mk11wB9sbbYSY5d9EV+1Uob6rphgCGUnSHSlfg1I89qPkCQS7wBu8/pcoMmoALSRqX4HR+3pV92jjYk3xF233hI0BkXqO7Uz3wa25pnAgPzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744672749; c=relaxed/simple;
	bh=xEIihxbI+FTPru/LW27iF/Zjhw9no4LCsocXrNkL3pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HnrPWI4QE/Io4nILQgTiWu9EjkJWkFVGK9knUW3Yb20zivto5Bca7cdoXSdeZUkpzI9KpPmgZ7kXyt+r+SOb5CGHvDw08DCmisbGj/9QEOZXzEns7Zb/98kDqQfuaaZFT/8k+5IEnpmmjc95kMHsWsO5zhE2BE6zb/+tT1f3AtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JSQfY5Q3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744672746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YVJ94Wo++luEDfBJ10vF1ZAy+1c1gj6+UjUhyT0DGdY=;
	b=JSQfY5Q3uSUgIMmyXRDzA5RArC9Eh/uKVVAycyP4OVLrWhNaXpTvc4oX8z82f1BaX9O54k
	mb/qlVBb2dzKQq6AQLt2t7KShG9Kawa43//AfC9DNtfAlpViPks9kptfflu8qskx/uUo1V
	iQ9+XPLXllfB96JSt9+VBc63JYKcP5Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-V9I0c9EqMA-gOKifst0DgQ-1; Mon,
 14 Apr 2025 19:18:59 -0400
X-MC-Unique: V9I0c9EqMA-gOKifst0DgQ-1
X-Mimecast-MFC-AGG-ID: V9I0c9EqMA-gOKifst0DgQ_1744672736
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13B511800349;
	Mon, 14 Apr 2025 23:18:54 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.64.91])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 09A731808867;
	Mon, 14 Apr 2025 23:18:43 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: npache@redhat.com
Cc: aarcange@redhat.com,
	akpm@linux-foundation.org,
	anshuman.khandual@arm.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	catalin.marinas@arm.com,
	cl@gentwo.org,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	david@redhat.com,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	jack@suse.cz,
	jglisse@google.com,
	kirill.shutemov@linux.intel.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	mhocko@suse.com,
	peterx@redhat.com,
	raquini@redhat.com,
	rientjes@google.com,
	rostedt@goodmis.org,
	ryan.roberts@arm.com,
	sunnanyong@huawei.com,
	surenb@google.com,
	thomas.hellstrom@linux.intel.com,
	tiwai@suse.de,
	usamaarif642@gmail.com,
	vishal.moola@gmail.com,
	wangkefeng.wang@huawei.com,
	will@kernel.org,
	willy@infradead.org,
	yang@os.amperecomputing.com,
	ziy@nvidia.com,
	zokeefe@google.com
Subject: [PATCH v4 06/12] khugepaged: introduce khugepaged_scan_bitmap for mTHP support
Date: Mon, 14 Apr 2025 17:18:28 -0600
Message-ID: <20250414231828.59151-1-npache@redhat.com>
In-Reply-To: <20250414220557.35388-7-npache@redhat.com>
References: <20250414220557.35388-7-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

khugepaged scans PMD ranges for potential collapse to a hugepage. To add
mTHP support we use this scan to instead record chunks of utilized
sections of the PMD.

khugepaged_scan_bitmap uses a stack struct to recursively scan a bitmap
that represents chunks of utilized regions. We can then determine what
mTHP size fits best and in the following patch, we set this bitmap while
scanning the PMD.

max_ptes_none is used as a scale to determine how "full" an order must
be before being considered for collapse.

When attempting to collapse an order that has its order set to "always"
lets always collapse to that order in a greedy manner without
considering the number of bits set.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 include/linux/khugepaged.h |  4 ++
 mm/khugepaged.c            | 94 ++++++++++++++++++++++++++++++++++----
 2 files changed, 89 insertions(+), 9 deletions(-)

diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index 1f46046080f5..18fe6eb5051d 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -1,6 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _LINUX_KHUGEPAGED_H
 #define _LINUX_KHUGEPAGED_H
+#define KHUGEPAGED_MIN_MTHP_ORDER	2
+#define KHUGEPAGED_MIN_MTHP_NR	(1<<KHUGEPAGED_MIN_MTHP_ORDER)
+#define MAX_MTHP_BITMAP_SIZE  (1 << (ilog2(MAX_PTRS_PER_PTE) - KHUGEPAGED_MIN_MTHP_ORDER))
+#define MTHP_BITMAP_SIZE  (1 << (HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MTHP_ORDER))
 
 extern unsigned int khugepaged_max_ptes_none __read_mostly;
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index dfecedc6a515..5a3be30096fc 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -94,6 +94,11 @@ static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS);
 
 static struct kmem_cache *mm_slot_cache __ro_after_init;
 
+struct scan_bit_state {
+	u8 order;
+	u16 offset;
+};
+
 struct collapse_control {
 	bool is_khugepaged;
 
@@ -102,6 +107,18 @@ struct collapse_control {
 
 	/* nodemask for allocation fallback */
 	nodemask_t alloc_nmask;
+
+	/*
+	 * bitmap used to collapse mTHP sizes.
+	 * 1bit = order KHUGEPAGED_MIN_MTHP_ORDER mTHP
+	 */
+	DECLARE_BITMAP(mthp_bitmap, MAX_MTHP_BITMAP_SIZE);
+	DECLARE_BITMAP(mthp_bitmap_temp, MAX_MTHP_BITMAP_SIZE);
+	struct scan_bit_state mthp_bitmap_stack[MAX_MTHP_BITMAP_SIZE];
+};
+
+struct collapse_control khugepaged_collapse_control = {
+	.is_khugepaged = true,
 };
 
 /**
@@ -851,10 +868,6 @@ static void khugepaged_alloc_sleep(void)
 	remove_wait_queue(&khugepaged_wait, &wait);
 }
 
-struct collapse_control khugepaged_collapse_control = {
-	.is_khugepaged = true,
-};
-
 static bool khugepaged_scan_abort(int nid, struct collapse_control *cc)
 {
 	int i;
@@ -1118,7 +1131,8 @@ static int alloc_charge_folio(struct folio **foliop, struct mm_struct *mm,
 
 static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 			      int referenced, int unmapped,
-			      struct collapse_control *cc)
+			      struct collapse_control *cc, bool *mmap_locked,
+				  u8 order, u16 offset)
 {
 	LIST_HEAD(compound_pagelist);
 	pmd_t *pmd, _pmd;
@@ -1137,8 +1151,12 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	 * The allocation can take potentially a long time if it involves
 	 * sync compaction, and we do not need to hold the mmap_lock during
 	 * that. We will recheck the vma after taking it again in write mode.
+	 * If collapsing mTHPs we may have already released the read_lock.
 	 */
-	mmap_read_unlock(mm);
+	if (*mmap_locked) {
+		mmap_read_unlock(mm);
+		*mmap_locked = false;
+	}
 
 	result = alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
 	if (result != SCAN_SUCCEED)
@@ -1273,12 +1291,72 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 out_up_write:
 	mmap_write_unlock(mm);
 out_nolock:
+	*mmap_locked = false;
 	if (folio)
 		folio_put(folio);
 	trace_mm_collapse_huge_page(mm, result == SCAN_SUCCEED, result);
 	return result;
 }
 
+// Recursive function to consume the bitmap
+static int khugepaged_scan_bitmap(struct mm_struct *mm, unsigned long address,
+			int referenced, int unmapped, struct collapse_control *cc,
+			bool *mmap_locked, unsigned long enabled_orders)
+{
+	u8 order, next_order;
+	u16 offset, mid_offset;
+	int num_chunks;
+	int bits_set, threshold_bits;
+	int top = -1;
+	int collapsed = 0;
+	int ret;
+	struct scan_bit_state state;
+	bool is_pmd_only = (enabled_orders == (1 << HPAGE_PMD_ORDER));
+
+	cc->mthp_bitmap_stack[++top] = (struct scan_bit_state)
+		{ HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MTHP_ORDER, 0 };
+
+	while (top >= 0) {
+		state = cc->mthp_bitmap_stack[top--];
+		order = state.order + KHUGEPAGED_MIN_MTHP_ORDER;
+		offset = state.offset;
+		num_chunks = 1 << (state.order);
+		// Skip mTHP orders that are not enabled
+		if (!test_bit(order, &enabled_orders))
+			goto next;
+
+		// copy the relavant section to a new bitmap
+		bitmap_shift_right(cc->mthp_bitmap_temp, cc->mthp_bitmap, offset,
+				  MTHP_BITMAP_SIZE);
+
+		bits_set = bitmap_weight(cc->mthp_bitmap_temp, num_chunks);
+		threshold_bits = (HPAGE_PMD_NR - khugepaged_max_ptes_none - 1)
+				>> (HPAGE_PMD_ORDER - state.order);
+
+		//Check if the region is "almost full" based on the threshold
+		if (bits_set > threshold_bits || is_pmd_only
+			|| test_bit(order, &huge_anon_orders_always)) {
+			ret = collapse_huge_page(mm, address, referenced, unmapped, cc,
+					mmap_locked, order, offset * KHUGEPAGED_MIN_MTHP_NR);
+			if (ret == SCAN_SUCCEED) {
+				collapsed += (1 << order);
+				continue;
+			}
+		}
+
+next:
+		if (state.order > 0) {
+			next_order = state.order - 1;
+			mid_offset = offset + (num_chunks / 2);
+			cc->mthp_bitmap_stack[++top] = (struct scan_bit_state)
+				{ next_order, mid_offset };
+			cc->mthp_bitmap_stack[++top] = (struct scan_bit_state)
+				{ next_order, offset };
+			}
+	}
+	return collapsed;
+}
+
 static int khugepaged_scan_pmd(struct mm_struct *mm,
 				   struct vm_area_struct *vma,
 				   unsigned long address, bool *mmap_locked,
@@ -1445,9 +1523,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 	pte_unmap_unlock(pte, ptl);
 	if (result == SCAN_SUCCEED) {
 		result = collapse_huge_page(mm, address, referenced,
-					    unmapped, cc);
-		/* collapse_huge_page will return with the mmap_lock released */
-		*mmap_locked = false;
+					    unmapped, cc, mmap_locked, HPAGE_PMD_ORDER, 0);
 	}
 out:
 	trace_mm_khugepaged_scan_pmd(mm, &folio->page, writable, referenced,
-- 
2.48.1



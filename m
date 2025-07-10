Return-Path: <linux-kernel+bounces-724861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0509AFF7A4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7864C1C47D63
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90BA28640C;
	Thu, 10 Jul 2025 03:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnX4kUCU"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6B9285CA2
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 03:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752118682; cv=none; b=PTo0uGqprRO7QJJnW9fJJ7FWhlZ5DjofuYJx8hSGI9OeQd1xjCIYd3ZgFoW/0d/8t+rYtbKAvJJc1SnxabzDHIoEXqmGaI7dYQ1Ox9OcHpyaRtUQ9z4MyelzXX9ZF5aFLcDlkr6wTbZUmVRyrruqTJXu1azfPCR/l1BwGb6NL7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752118682; c=relaxed/simple;
	bh=LYVd8e8AGZUjcgypR4lE+LJaT9OX+S4x9XEiHJ1xmNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWtAApN0I4A7nJVwEdoCHR/BpYAkAwqoeekWjNN7P3/daYHeITG8Y1mCPxjzKRIRtioPgZ9PTWvk8NkpK/JmVZzH+LmG/4mIYfjtDajyr7DosT37VyuDv03FDgkv+f0chntj27os7eb5YPe8CDmvGhlGt/V7aJ58nmZJb2KTx1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnX4kUCU; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b34ab678931so473063a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 20:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752118680; x=1752723480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zLyM92xjF/qE8PKYeKzMy6+qx0MOrSpvWpyzMUmH5dc=;
        b=nnX4kUCUq2UIkNOELVk4F9BZJCcLrwGKJalqdKF5DzHxuyxVLSEsEqdf1NIBPG+Wlq
         UCU6m5NvvC/qALnpnzJvTCrXEgLKJ6tlnw/QKbKjIU5Tf8Pz+HMx0TCk7fZA+oOb/VU7
         aoHrh9CQe8Ua0p90IEGwLK8oNHZpjfEJrTDt9NefEu/jepZfkeJ6Au2muxr6TJtAIy8X
         0rjRvFsjJPv3+CjNqwDwuAV6pN7Ot0mC5wQ3TC+pU5fWl7XtG6I3EbxoYGYdHkMlj9Ni
         Jmsb20sCY6FrupWZyFZcd6eomTtxAI9BX52ASe5V50zZ9YcUzaaG29wFMOVK9aHy00BB
         98UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752118680; x=1752723480;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zLyM92xjF/qE8PKYeKzMy6+qx0MOrSpvWpyzMUmH5dc=;
        b=J4KJ6nlVHhiP/1yFESc23yLXJ/Llv9jW/J+Bo5JqnzHtmFhvOuB+drx0HEeEF3SEke
         VDkPQ26LSYWu0/Q670S6XsB4maT9yvbMzvV78IJETVhVtV25xZBzBI/wC0i54vnWJVKD
         AGQpFhPCHO1uAI5CaZNaNHej65pXvQQ/qMZAKk9I0LfSqPYWrimC73ITxHIvhK13C1u+
         yt0B1FmJ11c9EcBfzrG6oFjaLmDPdqGlc16QS9afvEzwvjbk9F23QHqmTsBQ4KUl5lNJ
         +937TjjTNksTZ6UxIVrqMk9VaveCNbN9onNIRg61ib4QJPfdnVR/9wsHtI/yJmguYPQP
         XH1g==
X-Forwarded-Encrypted: i=1; AJvYcCWsubcfYVoAI5IaIdmF8qgMu2NEurNkBBdIHh6H4Hw8HaVuQ3XeA2TdLKtFmkLZPSzX6MSHwJosIaEE7zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwRrLauEFWGSAEpn3JqGS2+o8A4JkVt7HoMLKDPF9s/EQE9p86
	KnxbTJj1npy/e1BTac3wfGHIuMgmg7HimUgBNonjj3pvGe88oIqOtUJ9
X-Gm-Gg: ASbGnctfvACqSbwxfN/YJalcO9/VA7aJlmmq4ALnfq1oKMHIkvrLd9nc6kyoh9XSWAT
	U9Xl97TK0B/EZCFSvmL07n05C1rWTyGVJ9gAnLhQdoxBYot4H0oGvCv66dXqkSMY5oU+K5/TSgU
	PL3MpwaVf1pL60PYLY5Khlnc+d3AORdacN1JXhksqtfVoMiZL/HQCEvnyO4t2tjeXSR6NMLHtyY
	c035yHeLjexj9y0qAAo6k8mdnh7ORbCO5b/0CWYMKIwGG4y1HQw2J9PIsu5HAEsmjwVKvZgs+R3
	NUvr+T3WruE8I/qsogrcICV3fYcGRoTdMEVNdKGlIs/kmpn60LtOdfrHRDYJDdl7RxpuIbzsARQ
	O
X-Google-Smtp-Source: AGHT+IGMdjnBHsobKiw3IFD0J93kBWsIfXdtph/gYTDQk8Jc7sEx6r4eioU+JuxSODPnP116JqFVNg==
X-Received: by 2002:a17:90b:4c09:b0:311:eb85:96f0 with SMTP id 98e67ed59e1d1-31c3c2f3dc0mr3518018a91.29.1752118679531;
        Wed, 09 Jul 2025 20:37:59 -0700 (PDT)
Received: from KASONG-MC4 ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c300689aasm3716320a91.13.2025.07.09.20.37.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Jul 2025 20:37:58 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Matthew Wilcox <willy@infradead.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Chris Li <chrisl@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v5 7/8] mm/shmem, swap: rework swap entry and index calculation for large swapin
Date: Thu, 10 Jul 2025 11:37:05 +0800
Message-ID: <20250710033706.71042-8-ryncsn@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250710033706.71042-1-ryncsn@gmail.com>
References: <20250710033706.71042-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Instead of calculating the swap entry differently in different swapin
paths, calculate it early before the swap cache lookup and use that
for the lookup and later swapin. And after swapin have brought a folio,
simply round it down against the size of the folio.

This is simple and effective enough to verify the swap value. A folio's
swap entry is always aligned by its size. Any kind of parallel split or
race is acceptable because the final shmem_add_to_page_cache ensures
that all entries covered by the folio are correct, and thus there
will be no data corruption.

This also prevents false positive cache lookup. If a shmem read
request's index points to the middle of a large swap entry,
previously, shmem will try the swap cache lookup using the large swap
entry's starting value (which is the first sub swap entry of this
large entry). This will lead to false positive lookup results if only
the first few swap entries are cached but the actual requested swap
entry pointed by the index is uncached. This is not a rare event,
as swap readahead always tries to cache order 0 folios when possible.

And this shouldn't cause any increased repeated faults. Instead, no
matter how the shmem mapping is split in parallel, as long as the
mapping still contains the right entries, the swapin will succeed.

The final object size and stack usage are also reduced due to
simplified code:

./scripts/bloat-o-meter mm/shmem.o.old mm/shmem.o
add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-233 (-233)
Function                                     old     new   delta
shmem_swapin_folio                          4040    3807    -233
Total: Before=33152, After=32919, chg -0.70%

Stack usage (Before vs After):
mm/shmem.c:2277:12:shmem_swapin_folio   264     static
mm/shmem.c:2277:12:shmem_swapin_folio   256     static

And while at it, round down the index too if swap entry is round down.
The index is used either for folio reallocation or confirming the
mapping content. In either case, it should be aligned with the swap
folio.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/shmem.c | 66 ++++++++++++++++++++++++++----------------------------
 1 file changed, 32 insertions(+), 34 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 80f5b8c73eb8..9c50607ac455 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2265,7 +2265,7 @@ static int shmem_split_large_entry(struct inode *inode, pgoff_t index,
 	if (xas_error(&xas))
 		return xas_error(&xas);
 
-	return entry_order;
+	return 0;
 }
 
 /*
@@ -2286,7 +2286,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	struct swap_info_struct *si;
 	struct folio *folio = NULL;
 	bool skip_swapcache = false;
-	int error, nr_pages, order, split_order;
+	int error, nr_pages, order;
 	pgoff_t offset;
 
 	VM_BUG_ON(!*foliop || !xa_is_value(*foliop));
@@ -2294,11 +2294,11 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	swap = index_entry;
 	*foliop = NULL;
 
-	if (is_poisoned_swp_entry(swap))
+	if (is_poisoned_swp_entry(index_entry))
 		return -EIO;
 
-	si = get_swap_device(swap);
-	order = shmem_confirm_swap(mapping, index, swap);
+	si = get_swap_device(index_entry);
+	order = shmem_confirm_swap(mapping, index, index_entry);
 	if (unlikely(!si)) {
 		if (order < 0)
 			return -EEXIST;
@@ -2310,6 +2310,12 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 		return -EEXIST;
 	}
 
+	/* index may point to the middle of a large entry, get the sub entry */
+	if (order) {
+		offset = index - round_down(index, 1 << order);
+		swap = swp_entry(swp_type(swap), swp_offset(swap) + offset);
+	}
+
 	/* Look it up and read it in.. */
 	folio = swap_cache_get_folio(swap, NULL, 0);
 	if (!folio) {
@@ -2322,7 +2328,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 
 		if (data_race(si->flags & SWP_SYNCHRONOUS_IO)) {
 			/* Direct mTHP swapin skipping swap cache & readhaed */
-			folio = shmem_swap_alloc_folio(inode, vma, index, swap, order, gfp);
+			folio = shmem_swap_alloc_folio(inode, vma, index,
+						       index_entry, order, gfp);
 			if (IS_ERR(folio)) {
 				error = PTR_ERR(folio);
 				folio = NULL;
@@ -2330,16 +2337,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			}
 			skip_swapcache = true;
 		} else {
-			/*
-			 * Cached swapin only supports order 0 folio, it is
-			 * necessary to recalculate the new swap entry based on
-			 * the offset, as the swapin index might be unalgined.
-			 */
-			if (order) {
-				offset = index - round_down(index, 1 << order);
-				swap = swp_entry(swp_type(swap), swp_offset(swap) + offset);
-			}
-
+			/* Cached swapin only supports order 0 folio */
 			folio = shmem_swapin_cluster(swap, gfp, info, index);
 			if (!folio) {
 				error = -ENOMEM;
@@ -2356,23 +2354,25 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 		 * large swap entries. In such cases, we should split the
 		 * large swap entry to prevent possible data corruption.
 		 */
-		split_order = shmem_split_large_entry(inode, index, index_entry, gfp);
-		if (split_order < 0) {
-			error = split_order;
+		error = shmem_split_large_entry(inode, index, index_entry, gfp);
+		if (error)
 			goto failed_nolock;
-		}
+	}
 
-		/*
-		 * If the large swap entry has already been split, it is
-		 * necessary to recalculate the new swap entry based on
-		 * the old order alignment.
-		 */
-		if (split_order > 0) {
-			offset = index - round_down(index, 1 << split_order);
-			swap = swp_entry(swp_type(swap), swp_offset(index_entry) + offset);
-		}
-	} else if (order < folio_order(folio)) {
-		swap.val = round_down(swap.val, 1 << folio_order(folio));
+	/*
+	 * If the folio is large, round down swap and index by folio size.
+	 * No matter what race occurs, the swap layer ensures we either get
+	 * a valid folio that has its swap entry aligned by size, or a
+	 * temporarily invalid one which we'll abort very soon and retry.
+	 *
+	 * shmem_add_to_page_cache ensures the whole range contains expected
+	 * entries and prevents any corruption, so any race split is fine
+	 * too, it will succeed as long as the entries are still there.
+	 */
+	nr_pages = folio_nr_pages(folio);
+	if (nr_pages > 1) {
+		swap.val = round_down(swap.val, nr_pages);
+		index = round_down(index, nr_pages);
 	}
 
 	/* We have to do this with folio locked to prevent races */
@@ -2387,7 +2387,6 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 		goto failed;
 	}
 	folio_wait_writeback(folio);
-	nr_pages = folio_nr_pages(folio);
 
 	/*
 	 * Some architectures may have to restore extra metadata to the
@@ -2401,8 +2400,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			goto failed;
 	}
 
-	error = shmem_add_to_page_cache(folio, mapping,
-					round_down(index, nr_pages),
+	error = shmem_add_to_page_cache(folio, mapping, index,
 					swp_to_radix_entry(swap), gfp);
 	if (error)
 		goto failed;
-- 
2.50.0



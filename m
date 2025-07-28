Return-Path: <linux-kernel+bounces-747613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E24FAB135E9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1830B17815C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D6B238C35;
	Mon, 28 Jul 2025 07:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5izHkHL"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC7323535E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 07:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753689243; cv=none; b=THjrPP0xVSQlZNQhBY9VyW/gQP8ni75MY6tA4n33fNp+eSgEHX3eq2552Zi0etmDvM8AtlJeTe+UTXd72RQrnBfZ8Jdt/1pLn5BVIrFkJAYDjM3IxuYqaTLt0Cf4QUnlqftINvmBtuDRhRVf6iV7f0lrU4E4Sll9NLKHAcw8dK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753689243; c=relaxed/simple;
	bh=1LAApRAhqQF9gkekwujSLp9eafdwKIlOc3CkNYjxtPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ynpww5r3eserXpOQK3kS/x4RJ2x+WdEz45sA/hpTYi8gF+Ppbnfslrx2qmtKQ+IaNwjEWoL587g9KgQXsIuhtNQ7/hNUBhs3XJACRn1ju/yUUcU9LDKRIrstrBiaX+VoQlHYvZ1Yr+HlyXdGs+rwald13qAJVKAEC+pDncWgcWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5izHkHL; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2401248e4aaso9246115ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 00:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753689241; x=1754294041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=knGBd5jfLpxYWqvJFei/yT6Q+eb8VZoGgCefpAHxX/Y=;
        b=E5izHkHLXVs4Rrz8T2erY1gwdZhIlqUaQfw6qZ52UMAPXjW+EplJigEbdS2ek62k1A
         UXJOa/KiBb+x8AVuYTa/9ycp5+Rc0slYR4G1OJWy7l4YhH2azdaL8JOav7haCwV0qspc
         b1evLUXQL7ecDm0BjMYBWP7lqk+ttqnLG9daQ9a1H1jCVMA8rOICfc4wDYtnTe+62Ip7
         an6wPfjPoLV9ej6BnprKTsF7dLxNkt3qm94ivhb4LQXbOSQuCBIjZ+r5QQkFYNzXcaid
         or/YIrnoRH+tip5/qUbAatuFUZ1h/kauV0asPjowCrqfRP+MRqzqctSoiYiNk4ewxvR2
         0fJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753689241; x=1754294041;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=knGBd5jfLpxYWqvJFei/yT6Q+eb8VZoGgCefpAHxX/Y=;
        b=cHZ4u/TXU3QbKneZE4gD4YbRtD0VyoqauR3HywjjRqjGnEv3abSjXRLcSokb0kMVxz
         7ouyRtKQSUkrIn/GZUO12IFujT/JHD+YvUTz2ys6CTai7jlxQjAodH0qsLGHRNLQtDHP
         nOtdc1zx/03PlNqbFfFWFn+PK8pE9gX+2vQHXxhOXZ4r6sCun7fKt6PNWxUQBZl3zH3p
         1vJxPZQqk1/ZiTOHDs6Zjsx8ASxcEA9L022xgTgNxUG+z3zqgwVCy/qZ71N93I+m1cQC
         FQ6mwYHlrmG2b3VsvxJ6KEpxGFIZs96e9zzuxGaSkWxlfuQmb4Etz+rTZ0Mx/HAPsC2N
         OMPg==
X-Forwarded-Encrypted: i=1; AJvYcCUEHwAkuIKpXBs79aYcO2YQItVpfkVjE0V8OG+xMHT57+vK1Hb7dhthvQ6Vfuzzw5L+u0YgNMU2OFZHQHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxElk3faYt98nn2IJsXq3KAkmyM/QI1y4upSyN0Z1XpsB63yZkf
	AJLE0feJ9GHshPj05GOwk7msGF/OGVD5InIGFX0wM+qMIOcbj790aiWfVWyln8hRtKI=
X-Gm-Gg: ASbGncvSCr2+aX1cSunoMDqJ5gSuAj1Iz8Qml9qXdfjsO7X6pXbAVFlVyb37Qzn0ACu
	GvmNRtaGDIbeNj0VkkNYX3hoYcV1N3fvK5aJH5WK7rH4wRLXRrUoAC+lj3HGMpVscIbgrrB66ez
	J33DtPQRvqb37R60tnxuMjJJrk0s4UdyEK25aBLfsspgyIx3AQNFCL6OMyfLzjC5+X4vv2wmxvY
	I9bAiHc0Zeuy5SHWdn6hdjtRkJ1TXfrLox9GpHNfrxR54bRorA6FD/0JHdg7ucYD1gscVPqUXe1
	RjotGRPpiq8/SkYBxboLg+oNXMUWsJ3K+QSNPhuJ9zTyLW+aHqxIsDaXi4wTuB4H0mnEul2YV22
	BTeybFWtFRlG1x4uYPlvHkSxU+d5RS0s7fv0W
X-Google-Smtp-Source: AGHT+IHbEgSCz7muxEaP14OZPu7wIZ7iP6SbFhHsXB9PfuHrCICAOPtunkQ6Vt7Sy0XqXlLfDh2N9Q==
X-Received: by 2002:a17:902:f54f:b0:240:1ed3:fc1f with SMTP id d9443c01a7336-2401ed3ff16mr52388515ad.12.1753689240203;
        Mon, 28 Jul 2025 00:54:00 -0700 (PDT)
Received: from KASONG-MC4 ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2401866c2a1sm20272305ad.4.2025.07.28.00.53.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Jul 2025 00:53:59 -0700 (PDT)
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
Subject: [PATCH v6 7/8] mm/shmem, swap: rework swap entry and index calculation for large swapin
Date: Mon, 28 Jul 2025 15:53:05 +0800
Message-ID: <20250728075306.12704-8-ryncsn@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250728075306.12704-1-ryncsn@gmail.com>
References: <20250728075306.12704-1-ryncsn@gmail.com>
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
paths, calculate it early before the swap cache lookup and use that for
the lookup and later swapin.  And after swapin have brought a folio,
simply round it down against the size of the folio.

This is simple and effective enough to verify the swap value.  A folio's
swap entry is always aligned by its size.  Any kind of parallel split or
race is acceptable because the final shmem_add_to_page_cache ensures that
all entries covered by the folio are correct, and thus there will be no
data corruption.

This also prevents false positive cache lookup.  If a shmem read request's
index points to the middle of a large swap entry, previously, shmem will
try the swap cache lookup using the large swap entry's starting value
(which is the first sub swap entry of this large entry).  This will lead
to false positive lookup results if only the first few swap entries are
cached but the actual requested swap entry pointed by the index is
uncached.  This is not a rare event, as swap readahead always tries to
cache order 0 folios when possible.

And this shouldn't cause any increased repeated faults.  Instead, no
matter how the shmem mapping is split in parallel, as long as the mapping
still contains the right entries, the swapin will succeed.

The final object size and stack usage are also reduced due to simplified
code:

./scripts/bloat-o-meter mm/shmem.o.old mm/shmem.o
add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-145 (-145)
Function                                     old     new   delta
shmem_swapin_folio                          4056    3911    -145
Total: Before=33242, After=33097, chg -0.44%

Stack usage (Before vs After):
mm/shmem.c:2314:12:shmem_swapin_folio   264     static
mm/shmem.c:2314:12:shmem_swapin_folio   256     static

And while at it, round down the index too if swap entry is round down.
The index is used either for folio reallocation or confirming the
mapping content. In either case, it should be aligned with the swap
folio.

Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 67 +++++++++++++++++++++++++++---------------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 72b6370a8e81..aed5da693855 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2302,7 +2302,7 @@ static int shmem_split_large_entry(struct inode *inode, pgoff_t index,
 	if (xas_error(&xas))
 		return xas_error(&xas);
 
-	return entry_order;
+	return 0;
 }
 
 /*
@@ -2323,7 +2323,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	struct swap_info_struct *si;
 	struct folio *folio = NULL;
 	bool skip_swapcache = false;
-	int error, nr_pages, order, split_order;
+	int error, nr_pages, order;
 	pgoff_t offset;
 
 	VM_BUG_ON(!*foliop || !xa_is_value(*foliop));
@@ -2331,11 +2331,11 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
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
@@ -2347,6 +2347,12 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
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
@@ -2359,7 +2365,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 
 		if (data_race(si->flags & SWP_SYNCHRONOUS_IO)) {
 			/* Direct swapin skipping swap cache & readahead */
-			folio = shmem_swap_alloc_folio(inode, vma, index, swap, order, gfp);
+			folio = shmem_swap_alloc_folio(inode, vma, index,
+						       index_entry, order, gfp);
 			if (IS_ERR(folio)) {
 				error = PTR_ERR(folio);
 				folio = NULL;
@@ -2367,16 +2374,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
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
@@ -2384,6 +2382,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			}
 		}
 	}
+
 	if (order > folio_order(folio)) {
 		/*
 		 * Swapin may get smaller folios due to various reasons:
@@ -2393,24 +2392,25 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
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
-		index = round_down(index, 1 << folio_order(folio));
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
 
 	/*
@@ -2446,8 +2446,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			goto failed;
 	}
 
-	error = shmem_add_to_page_cache(folio, mapping,
-					round_down(index, nr_pages),
+	error = shmem_add_to_page_cache(folio, mapping, index,
 					swp_to_radix_entry(swap), gfp);
 	if (error)
 		goto failed;
-- 
2.50.1



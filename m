Return-Path: <linux-kernel+bounces-755571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDC6B1A897
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 19:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D660617F5E2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D823928B7F9;
	Mon,  4 Aug 2025 17:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0uowsUf"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9303428B7E2
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754328294; cv=none; b=XQ1L2VXlpOy8fUyqL7qiCPpzBFkUxj7jr6+zxw+fat/rXdWJqhPNmG+4k7SGMNNspt1uuCSK7x7u0mfA3CncLZ5vYZ7HHjJCgHjjIG40099DZjKvy/vkBbBwdSvi/xDy8L3WUhHgSqTz3QiGK0dtfXMC4TpXUfIvxeX9V8mpz9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754328294; c=relaxed/simple;
	bh=D0j65UqNmlMIxf+Evr42Bqzpf4M4hsTguikwzCdh9SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iamwUWAeqqkODnUfLWBOcZ9mZBylsYLzguZUqMW6Ad4y0geGM5flf0yIC6hfVpiGPKvmNery1d7rOW92BJp4gcCjLWmkJdK/Mom4rl56cT9GmYKz/L8/yuHLJ6u0GSvwOliDh7xBglKP5+XoI2L25ADZKaSJgo4Rafhd8THaucI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0uowsUf; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76bd202ef81so5063554b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 10:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754328292; x=1754933092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vVDJaCuMrELPMFvvynT19e8hRXhozD/bO9trI2Q8I4s=;
        b=Y0uowsUftozLz8dRmYjIfjGr7bnmXL+BPcXFfZ4wFyUlc9RaloapegIKOS/nWX+Paq
         RNwj5tOZaM7DcgryOmbph+wmzEbUvucXEaOxm9rLk9/iJMhrJhAX8bRsY6cbhT4h0XxR
         DDwLixhsenP78h57S4DngPkJa7SqjnopwPbOsKIVyYD0iq+k8JSJwDZg1feaNbU+lpPK
         d5eGRYkK1TE/qWNoQG7Pd9N2g/RlW+pk0VZkEKkeOBYzQZaz4xWU5FrTftFEsBLIfyXk
         CS0wHYQ4DTnKc9/S4RN7RyE3eupMsbAi7v23zBmzN2+rAT9cXxROPReMzPTseUyD08BL
         xkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754328292; x=1754933092;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vVDJaCuMrELPMFvvynT19e8hRXhozD/bO9trI2Q8I4s=;
        b=W9uv5FZdEfIMZKzHe1X20ohZ7lj1cI7SohydztnNpPhsZMAJJ1JkcGFMjcskVyyqgU
         aVyx1wFfitz9hXIc9oZzfPNsnE6tzIaMwHuP5qxHHBuTGRk43RXA191xeP8YatNoUtII
         b74BRKTtjH6WUZ5BnGSig7lUnCYNeZhAKa5rYqRqcQQzu2O1siZBGaRXydofh+8VgvM+
         SnCos4azUmwWudE6TmGvtaZMI743R9cypoRAMnpsn1GL476Zq2xRmF2cTNA1x1PX2uWS
         K7QAkARtysbSKOWROLCn1jeVeHBfWSv1XvhrEZ+sUYit/IliSWmJ9/e2/cZl6r5nONlB
         AeyQ==
X-Forwarded-Encrypted: i=1; AJvYcCV75E6GcIMiAzgClCcb9uigMc3kzZ5vhkZ+My7KwIk9l+Acddr82fw3ZC79O4CRDjDPaXAeBCrdfB7yWpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ4vlbZ56/E9Nbqm9ywajZI/qXt3dGOT2HbaVgxqQNOtL6PM52
	ZJvGOpwbRTam/glAJPcL6cjS8QQuxTLs6koTfsAc7nVotukZ3qyKQuv/
X-Gm-Gg: ASbGncu745+LG5ztBUmyzd27j5enDiJiWAVXp1idpdak2jrmfo8h17QQaG30ZQ0FuOW
	yHKfejnjFca6xYtYllb248ofs1Y7FhEGLWQXx8TfyMRcm5VqaBxSPeg0kgG84X7zl76h6IYIWtb
	2NHwJyMohTxJ3O9SJSIbCAk7oAsZeW0ITlZ1RwVBPweMNn3X1S1GE0Gs7Z+/6HqY5LHNMEXzOTj
	eYyTe49pBAYVMchiU8TTSwFohafj+YSuFpQuL+QOq5vST5KNyRRnmu9/ctX9JbFvQ5z40oY7WIu
	bhHYdaiCCSYOlkOroUlKXVFL0UHLBomER3/bEZB5jrSFFtgE0r77i+i9ZFCNbSbPJ6XKtTE8oqV
	CozqtZXPyFVXb7baFp/fRoPaOvbc=
X-Google-Smtp-Source: AGHT+IGniJ0lx0Qlax8eOfu84RbBgv9hJ3X1mPcI10TaxeI90rF9axLNnX5byim17EjKyI1ryfWq7Q==
X-Received: by 2002:a05:6a00:3a10:b0:76b:e144:1d91 with SMTP id d2e1a72fcca58-76bec4be949mr12302420b3a.16.1754328291655;
        Mon, 04 Aug 2025 10:24:51 -0700 (PDT)
Received: from KASONG-MC4 ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bfcb26905sm4194530b3a.123.2025.08.04.10.24.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Aug 2025 10:24:51 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Chris Li <chrisl@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 1/2] mm, swap: don't scan every fragment cluster
Date: Tue,  5 Aug 2025 01:24:38 +0800
Message-ID: <20250804172439.2331-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250804172439.2331-1-ryncsn@gmail.com>
References: <20250804172439.2331-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Fragment clusters were mostly failing high order allocation already.
The reason we scan it now is that a swap slot may get freed without
releasing the swap cache, so a swap map entry will end up in HAS_CACHE
only status, and the cluster won't be moved back to non-full or free
cluster list.

Usually this only happens for !SWP_SYNCHRONOUS_IO devices when the swap
device usage is low (!vm_swap_full()) since swap will try to lazy free
the swap cache.

It's unlikely to cause any real issue. Fragmentation is only an issue
when the device is getting full, and by  that time, swap will already
be releasing the swap cache aggressively. And swap cache reclaim happens
when the allocator scans a cluster too. Scanning one fragment cluster
should be good enough to reclaim these pinned slots.

And besides, only high order allocation requires iterating over a
cluster list, order 0 allocation will succeed on the first attempt.
And high order allocation failure isn't a serious problem.

So the iteration of fragment clusters is trivial, but it will slow down
mTHP allocation by a lot when the fragment cluster list is long.
So it's better to drop this fragment cluster iteration design. Only
scanning one fragment cluster is good enough in case any cluster is
stuck in the fragment list; this ensures order 0 allocation never
falls, and large allocations still have an acceptable success rate.

Test on a 48c96t system, build linux kernel using 10G ZRAM, make -j48,
defconfig with 768M cgroup memory limit, on top of tmpfs, 4K folio
only:

Before: sys time: 4407.28s
After:  sys time: 4425.22s

Change to make -j96, 2G memory limit, 64kB mTHP enabled, and 10G ZRAM:

Before: sys time: 10230.22s  64kB/swpout: 1793044  64kB/swpout_fallback: 17653
After:  sys time: 5527.90s   64kB/swpout: 1789358  64kB/swpout_fallback: 17813

Change to 8G ZRAM:

Before: sys time: 21929.17s  64kB/swpout: 1634681  64kB/swpout_fallback: 173056
After:  sys time: 6121.01s   64kB/swpout: 1638155  64kB/swpout_fallback: 189562

Change to use 10G brd device with SWP_SYNCHRONOUS_IO flag removed:

Before: sys time: 7368.41s  64kB/swpout:1787599  swpout_fallback: 0
After:  sys time: 7338.27s  64kB/swpout:1783106  swpout_fallback: 0

Change to use 8G brd device with SWP_SYNCHRONOUS_IO flag removed:

Before: sys time: 28139.60s 64kB/swpout:1645421  swpout_fallback: 148408
After:  sys time: 8941.90s  64kB/swpout:1592973  swpout_fallback: 265010

The performance is a lot better and large order allocation failure rate
is only very slightly higher or unchanged.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/swap.h |  1 -
 mm/swapfile.c        | 30 ++++++++----------------------
 2 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 2fe6ed2cc3fd..a060d102e0d1 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -310,7 +310,6 @@ struct swap_info_struct {
 					/* list of cluster that contains at least one free slot */
 	struct list_head frag_clusters[SWAP_NR_ORDERS];
 					/* list of cluster that are fragmented or contented */
-	atomic_long_t frag_cluster_nr[SWAP_NR_ORDERS];
 	unsigned int pages;		/* total of usable pages of swap */
 	atomic_long_t inuse_pages;	/* number of those currently in use */
 	struct swap_sequential_cluster *global_cluster; /* Use one global cluster for rotating device */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index b4f3cc712580..5fdb3cb2b8b7 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -470,11 +470,6 @@ static void move_cluster(struct swap_info_struct *si,
 	else
 		list_move_tail(&ci->list, list);
 	spin_unlock(&si->lock);
-
-	if (ci->flags == CLUSTER_FLAG_FRAG)
-		atomic_long_dec(&si->frag_cluster_nr[ci->order]);
-	else if (new_flags == CLUSTER_FLAG_FRAG)
-		atomic_long_inc(&si->frag_cluster_nr[ci->order]);
 	ci->flags = new_flags;
 }
 
@@ -926,32 +921,25 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 		swap_reclaim_full_clusters(si, false);
 
 	if (order < PMD_ORDER) {
-		unsigned int frags = 0, frags_existing;
-
 		while ((ci = isolate_lock_cluster(si, &si->nonfull_clusters[order]))) {
 			found = alloc_swap_scan_cluster(si, ci, cluster_offset(si, ci),
 							order, usage);
 			if (found)
 				goto done;
-			/* Clusters failed to allocate are moved to frag_clusters */
-			frags++;
 		}
 
-		frags_existing = atomic_long_read(&si->frag_cluster_nr[order]);
-		while (frags < frags_existing &&
-		       (ci = isolate_lock_cluster(si, &si->frag_clusters[order]))) {
-			atomic_long_dec(&si->frag_cluster_nr[order]);
-			/*
-			 * Rotate the frag list to iterate, they were all
-			 * failing high order allocation or moved here due to
-			 * per-CPU usage, but they could contain newly released
-			 * reclaimable (eg. lazy-freed swap cache) slots.
-			 */
+		/*
+		 * Scan only one fragment cluster is good enough. Order 0
+		 * allocation will surely success, and large allocation
+		 * failure is not critical. Scanning one cluster still
+		 * keeps the list rotated and reclaimed (for HAS_CACHE).
+		 */
+		ci = isolate_lock_cluster(si, &si->frag_clusters[order]);
+		if (ci) {
 			found = alloc_swap_scan_cluster(si, ci, cluster_offset(si, ci),
 							order, usage);
 			if (found)
 				goto done;
-			frags++;
 		}
 	}
 
@@ -972,7 +960,6 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 		 * allocation, but reclaim may drop si->lock and race with another user.
 		 */
 		while ((ci = isolate_lock_cluster(si, &si->frag_clusters[o]))) {
-			atomic_long_dec(&si->frag_cluster_nr[o]);
 			found = alloc_swap_scan_cluster(si, ci, cluster_offset(si, ci),
 							0, usage);
 			if (found)
@@ -3224,7 +3211,6 @@ static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
 	for (i = 0; i < SWAP_NR_ORDERS; i++) {
 		INIT_LIST_HEAD(&si->nonfull_clusters[i]);
 		INIT_LIST_HEAD(&si->frag_clusters[i]);
-		atomic_long_set(&si->frag_cluster_nr[i], 0);
 	}
 
 	/*
-- 
2.50.1



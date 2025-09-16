Return-Path: <linux-kernel+bounces-819216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 215ABB59CEC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D34E1BC03DF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC9F2C0F73;
	Tue, 16 Sep 2025 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZzYvLF9"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7B6374281
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038560; cv=none; b=Qcpx/h4cmiWTRWqYxwA1Z3bu9XI1sVNxCFwMUX+eKs2SyM5cJUgSB3/zGCGIXBV6oQznVuBP4K84Vpns4hpADSaVR0X1nXDn0g14bVov7+12XGZvkXjKh8qSNDeLJgCHMCcPRzGt9Yuu8//j2HnWilrHEUfgBxuOuAWB2H4fcVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038560; c=relaxed/simple;
	bh=pT8bHTlnarO/NBkk+DAGsSr9yj2JTR304/MkutpXs78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SfnECSpc+uUr5+2LlTlzTx+hD907pH/WL2PnLZJFWtQMW0RLsGtdLE+RaVKIF3GtCbqJTzsCpfHtNzJBvzMase6ijnsnV+OdmwYHAUKP8ejpbFfMVUsozx2L4jah86Pp7CciMXHSKWGVDhsfInRpyPFZxEGgsosqdgO3os3ghug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZzYvLF9; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-826311c1774so401948585a.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758038558; x=1758643358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pkwwb9fXA+gLzNSIgeAnWPrfVwxN4Hwjf/rN/U/6eIw=;
        b=jZzYvLF95/uq9bDrOGKicpgRTqqQEvrcpQbh7mGWHISmh35bXX5ITXb6zAuPPkP4Ta
         4SwLLzXvnK7+/q03PedeHJs4WM81SZ/2l3lSFnhz6/UDmUZ/x62vM2eh2G06DKvF84iV
         qgLDQHk0Rixwc+CH2UjwSgeh9zEOseOAW7Gef+E97zEWvlN7K93FZVMP5MOReSWL7A0l
         6jrnZZxdJmQRJsqOCqeEW9eI2jBrHePOHwC03l83LrztKQW8t9RMrYZQFXdfAbGV3yl5
         GjIS4by3haxNu5beNEGja/Qnfb2m9KMpK2qCuj9R7M5WbAdvP44JBoiKVeasRTUnJ34J
         IV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758038558; x=1758643358;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pkwwb9fXA+gLzNSIgeAnWPrfVwxN4Hwjf/rN/U/6eIw=;
        b=L94FafYnDEgN2GC138NFzzd6rRCmO/QbgFHx+CVaw/hCZKM94+0coDh9nyJXbtxNC9
         GKxgwqslwipeub66JDdEYgX0gUKKR3gOlog1x59Pw407PKoSN2Xq0QxOAd43p9Fl4y4/
         vmkpop6olrno5K+cboZ1kn/ZjChMBm9dsY4WsmbYqkEqbNsJkaxkauW24w/1kSIRLIip
         MtwVwjPwnCdRmgW1ZyoGANhL+rRjmjt4p5sFNi+CPenIfmweC+4JEH9XRxiR1UUBLwJC
         +Rc7YVs5ueKkQyZpv0Mk+TWkrdg8lhjiEs88rCY5jxLu0mJmD7RGJZ6TsCIgix7ItxOx
         tXCA==
X-Forwarded-Encrypted: i=1; AJvYcCV1FRqZZoo6145edPBiYncdNxzT1EVGFt8QpNhZv5n50Tyb5DCCXdM3m0gKYur5eF0muJwpgMj2NWWjtTI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp3Ri452q8RBk+ZmMQjqFSrWNG/n02OXKOxH6Ca72YDRJMIsdk
	nHYGmExealMsOun7eoGunTXwPm68m0GCo769gWEy4qEkAWknCtY5kpFO
X-Gm-Gg: ASbGnctjONxIQR3+jzfkSU5ndH9OIa7kk4EgA7SjHEIyJDaIyu4Y79bZesJrPxZf5+L
	L0PNkz/XpmixIYH2dzDoCl6zsCtdfa51LehwI4fLQlHpqoRsiLfuZSqS3icbJW+ckkunSxbSJ0N
	ugw85DQBSr0ymljB8X1sEwoJHsR7q9zyMlFd1uAsfqjIOsTExGYysKHgkbijyBkRBiFdfMchy0A
	ghACSyL+YtgB1rGI2YIWBrX7y4uD5oHv/UN7rM8SNXrMnAAqwnr4ydsuHN7+pk6cYuKy3q+Wd0f
	nYl7YPrwM0+hQhK7BChYD3n3bmqvPnSC4yoi3i+DJi8SeyDC1Yvd3NxcEAbYChD3YXs5OYA3VQo
	pcbHLeRlxcOgKk6wF+q6U1D+ilHHTk84Wsx+b1xXwRaa37HI=
X-Google-Smtp-Source: AGHT+IF8fLd2lfO76mR7R/AGarFeTdp4W9G3W6ewW3fPGy6m/l7ACES3YArLw4+tmP3lQvR1ygglaQ==
X-Received: by 2002:a05:620a:a48d:b0:811:bc35:7016 with SMTP id af79cd13be357-82400753708mr2020881185a.58.1758038557353;
        Tue, 16 Sep 2025 09:02:37 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820cd703f54sm969765485a.37.2025.09.16.09.02.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 16 Sep 2025 09:02:36 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Kairui Song <ryncsn@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <baohua@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v4 13/15] mm, swap: remove contention workaround for swap cache
Date: Wed, 17 Sep 2025 00:00:58 +0800
Message-ID: <20250916160100.31545-14-ryncsn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916160100.31545-1-ryncsn@gmail.com>
References: <20250916160100.31545-1-ryncsn@gmail.com>
Reply-To: Kairui Song <ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Swap cluster setup will try to shuffle the clusters on initialization.
It was helpful to avoid contention for the swap cache space. The cluster
size (2M) was much smaller than each swap cache space (64M), so
shuffling the cluster means the allocator will try to allocate swap
slots that are in different swap cache spaces for each CPU, reducing the
chance of two CPUs using the same swap cache space, and hence reducing
the contention.

Now, swap cache is managed by swap clusters, this shuffle is pointless.
Just remove it, and clean up related macros.

This also improves the HDD swap performance as shuffling IO is a bad
idea for HDD, and now the shuffling is gone. Test have shown a ~40%
performance gain for HDD [1]:

Doing sequential swap in of 8G data using 8 processes with usemem,
average of 3 test runs:

Before: 1270.91 KB/s per process
After:  1849.54 KB/s per process

Link: https://lore.kernel.org/linux-mm/CAMgjq7AdauQ8=X0zeih2r21QoV=-WWj1hyBxLWRzq74n-C=-Ng@mail.gmail.com/ [1]
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202504241621.f27743ec-lkp@intel.com
Signed-off-by: Kairui Song <kasong@tencent.com>
Acked-by: Chris Li <chrisl@kernel.org>
Reviewed-by: Barry Song <baohua@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/swap.h     |  4 ----
 mm/swapfile.c | 32 ++++++++------------------------
 mm/zswap.c    |  7 +++++--
 3 files changed, 13 insertions(+), 30 deletions(-)

diff --git a/mm/swap.h b/mm/swap.h
index adcd85fa8538..fe5c20922082 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -198,10 +198,6 @@ int swap_writeout(struct folio *folio, struct swap_iocb **swap_plug);
 void __swap_writepage(struct folio *folio, struct swap_iocb **swap_plug);
 
 /* linux/mm/swap_state.c */
-/* One swap address space for each 64M swap space */
-#define SWAP_ADDRESS_SPACE_SHIFT	14
-#define SWAP_ADDRESS_SPACE_PAGES	(1 << SWAP_ADDRESS_SPACE_SHIFT)
-#define SWAP_ADDRESS_SPACE_MASK		(SWAP_ADDRESS_SPACE_PAGES - 1)
 extern struct address_space swap_space __ro_after_init;
 static inline struct address_space *swap_address_space(swp_entry_t entry)
 {
diff --git a/mm/swapfile.c b/mm/swapfile.c
index b183e96be289..314c5c10d3bd 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3204,21 +3204,14 @@ static int setup_swap_map(struct swap_info_struct *si,
 	return 0;
 }
 
-#define SWAP_CLUSTER_INFO_COLS						\
-	DIV_ROUND_UP(L1_CACHE_BYTES, sizeof(struct swap_cluster_info))
-#define SWAP_CLUSTER_SPACE_COLS						\
-	DIV_ROUND_UP(SWAP_ADDRESS_SPACE_PAGES, SWAPFILE_CLUSTER)
-#define SWAP_CLUSTER_COLS						\
-	max_t(unsigned int, SWAP_CLUSTER_INFO_COLS, SWAP_CLUSTER_SPACE_COLS)
-
 static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
 						union swap_header *swap_header,
 						unsigned long maxpages)
 {
 	unsigned long nr_clusters = DIV_ROUND_UP(maxpages, SWAPFILE_CLUSTER);
 	struct swap_cluster_info *cluster_info;
-	unsigned long i, j, idx;
 	int err = -ENOMEM;
+	unsigned long i;
 
 	cluster_info = kvcalloc(nr_clusters, sizeof(*cluster_info), GFP_KERNEL);
 	if (!cluster_info)
@@ -3267,22 +3260,13 @@ static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
 		INIT_LIST_HEAD(&si->frag_clusters[i]);
 	}
 
-	/*
-	 * Reduce false cache line sharing between cluster_info and
-	 * sharing same address space.
-	 */
-	for (j = 0; j < SWAP_CLUSTER_COLS; j++) {
-		for (i = 0; i < DIV_ROUND_UP(nr_clusters, SWAP_CLUSTER_COLS); i++) {
-			struct swap_cluster_info *ci;
-			idx = i * SWAP_CLUSTER_COLS + j;
-			ci = cluster_info + idx;
-			if (idx >= nr_clusters)
-				continue;
-			if (ci->count) {
-				ci->flags = CLUSTER_FLAG_NONFULL;
-				list_add_tail(&ci->list, &si->nonfull_clusters[0]);
-				continue;
-			}
+	for (i = 0; i < nr_clusters; i++) {
+		struct swap_cluster_info *ci = &cluster_info[i];
+
+		if (ci->count) {
+			ci->flags = CLUSTER_FLAG_NONFULL;
+			list_add_tail(&ci->list, &si->nonfull_clusters[0]);
+		} else {
 			ci->flags = CLUSTER_FLAG_FREE;
 			list_add_tail(&ci->list, &si->free_clusters);
 		}
diff --git a/mm/zswap.c b/mm/zswap.c
index 1b1edecde6a7..c1af782e54ec 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -225,10 +225,13 @@ static bool zswap_has_pool;
 * helpers and fwd declarations
 **********************************/
 
+/* One swap address space for each 64M swap space */
+#define ZSWAP_ADDRESS_SPACE_SHIFT 14
+#define ZSWAP_ADDRESS_SPACE_PAGES (1 << ZSWAP_ADDRESS_SPACE_SHIFT)
 static inline struct xarray *swap_zswap_tree(swp_entry_t swp)
 {
 	return &zswap_trees[swp_type(swp)][swp_offset(swp)
-		>> SWAP_ADDRESS_SPACE_SHIFT];
+		>> ZSWAP_ADDRESS_SPACE_SHIFT];
 }
 
 #define zswap_pool_debug(msg, p)			\
@@ -1674,7 +1677,7 @@ int zswap_swapon(int type, unsigned long nr_pages)
 	struct xarray *trees, *tree;
 	unsigned int nr, i;
 
-	nr = DIV_ROUND_UP(nr_pages, SWAP_ADDRESS_SPACE_PAGES);
+	nr = DIV_ROUND_UP(nr_pages, ZSWAP_ADDRESS_SPACE_PAGES);
 	trees = kvcalloc(nr, sizeof(*tree), GFP_KERNEL);
 	if (!trees) {
 		pr_err("alloc failed, zswap disabled for swap type %d\n", type);
-- 
2.51.0



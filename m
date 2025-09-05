Return-Path: <linux-kernel+bounces-803656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 538FEB46367
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B4CAA15B8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16402798E6;
	Fri,  5 Sep 2025 19:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOPXy72b"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770AC2BE7B5
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 19:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099725; cv=none; b=HZHZYRu1tjePFsMfDj8wDngINHq/a1lK2+PSgXEuZbnq6Zksq0c1QMRoBrQAmgbqP+SwFeHlH5V6rXPv04h6n7NaIlPMTeisNYCgRNczhjX+Blnhvq0T3mYr0VYt9fv5RfMyz/de7IQTNryifuJ1cK0pF2xXUbGJGm9JmZuLm6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099725; c=relaxed/simple;
	bh=JMGQF9ss8ceQsMt/AnYp4G62XcoIhrBz/bqWmU3BMDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dTGHQ2nG7TFHZLvQyfhzkQIMllgz7INU9nSU/tTRR8O8R5JMPS2W8+YBqbvc9/rOik5of8hpuaioAXP0GkKcyP5tgXfVbh2DNV634uoOkvM6tl+PoAPFqgx+O3xEScKDUYDBZhkm0zyF44MrMghMDHP7d58sTigtqWjfFhrt1FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOPXy72b; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77251d7cca6so2091920b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 12:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757099722; x=1757704522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NTNtn8bp73dj8smpZWVlmgVZUs77+apTLTbhCM2474w=;
        b=LOPXy72bXfi7KecAdQHaG7wLQw2qPi2h/HSI/giNbq8WlgyJd3MaZXK5ju3Iy44KYQ
         0hZ/qJvuUcxTpX5naQGpp7TANnJksdZ492lhUWchVKSVHmwWvtmesz9pM+F6IYBfaTl8
         4xCKE7mnsAxZw8uaJyEMP/Cbws/8sLyqrjzALNYSsC5oMdFzqYhb5kZfy/czn/vdH8HC
         n8j575zpsou++fuoRle/l6btAtPM0x9Vyx/zYFBCzlGjJXCll3EVPz0MRjwYhIFnipwW
         oaRRgiRKoVMOQ5fGzRhEn+pLQMY6AmLRL6RZr+UI2/Zi8uQgO6p10kwSnPi6+RCWgu+C
         WG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757099722; x=1757704522;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NTNtn8bp73dj8smpZWVlmgVZUs77+apTLTbhCM2474w=;
        b=o49TxnDs5sjkKBNVeOSB5mErTh5EUpWXtXqff9+jnMBzQHqg1wdikIOjiqJ8602eip
         5RPWlSblBnnK60tV2UctPtUNBqcMJjOQXG4iLPqrZc9tkvGp81RejhbgX7ekZ26/TkZ6
         cngJFWCukno2aDfhGyYeILp/QLyi6d0yQjC0PY//3tdIf4oxnH29KNm/sEVaz2kuCnkY
         Rlj9bi29BN5bRAK39ISwhI2keRxCuKZqr4b9zbiBL100koPMnekSpliZaEorv++J6Czu
         j5uOw9q7ylWu+KCvWPDQwazyWfddIDB/7Kw9mvwe11GMB8w280JbtV1SNd4OB9tfcqSZ
         2jsg==
X-Forwarded-Encrypted: i=1; AJvYcCWmF4MEMUkBRf09ogx7Ih/6a8BxQrXNVwiyV5lAUhdbYV5Vqv6bAKuO4Vs1fgLyutUYN/y4KKXhna3GV5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqK+19a2G0G130uJ5PLpELAtUA9D3CDQMPN6a6zNLcZJTt+i1u
	SMw6kCU4tOYiMdiY+J49Rai5+wi+1cdUjok1I0cEH+4MMxvJSSgrt+8f
X-Gm-Gg: ASbGncuZ9aunUNeG+nOJvCbraOOupHFUcKTuj1PrIbzKxPQHMVAsORNiwiq9giAt6Xg
	17UQ+yCrVB6ya7fSSgbrNOs8Yt/PlJ09DUMRwdvdBd07Eqb1NIJ12g0aPByhZ0aewcIWf+PAT0M
	omGddWaRzk7rA9sa89u6Dc0m4xRrs1LPd21P0I0uQMJuY89U/ONrnNz05fTEFTS61EsPDRYTwxw
	atkN6sauFqJK96/JPRzpatFXmSO7CGsAmFD/LkczhFC0gNjbUFTua575ROoEUJWHYcYcdQijYTE
	q1LqFYgnPr9ixzDlrEmeulxFz7bRyA9+6xaUiTpnvqsGWJeS8OfHQhDnu+l3EPMjLqT/UZOgK5S
	rVWRuObx5Fxr+/f7mtibtjHFMNuc04FvikCl1athvEOxnNW/2LlvaeVZethIZspNXRFCX
X-Google-Smtp-Source: AGHT+IH96qTgWSibnaaMdWjrVapYmHypSxAQB9nXdv+S9Q7X6ROZXhBXtRtbecK0Xwab4dhhHrwjCg==
X-Received: by 2002:a05:6300:218a:b0:243:9587:a743 with SMTP id adf61e73a8af0-243d6e06239mr30146256637.23.1757099721686;
        Fri, 05 Sep 2025 12:15:21 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77256a0f916sm15871442b3a.63.2025.09.05.12.15.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 05 Sep 2025 12:15:21 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
Subject: [PATCH v2 13/15] mm, swap: remove contention workaround for swap cache
Date: Sat,  6 Sep 2025 03:13:55 +0800
Message-ID: <20250905191357.78298-14-ryncsn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905191357.78298-1-ryncsn@gmail.com>
References: <20250905191357.78298-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
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
---
 mm/swap.h     |  4 ----
 mm/swapfile.c | 32 ++++++++------------------------
 mm/zswap.c    |  7 +++++--
 3 files changed, 13 insertions(+), 30 deletions(-)

diff --git a/mm/swap.h b/mm/swap.h
index e48431a26f89..c4fb28845d77 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -197,10 +197,6 @@ int swap_writeout(struct folio *folio, struct swap_iocb **swap_plug);
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
index cbb7d4c0773d..6b3b35a7ddd9 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3202,21 +3202,14 @@ static int setup_swap_map(struct swap_info_struct *si,
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
@@ -3265,22 +3258,13 @@ static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
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
index 3dda4310099e..cba7077fda40 100644
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



Return-Path: <linux-kernel+bounces-782619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B417B322C1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A4AD6280EB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373BA2D0C91;
	Fri, 22 Aug 2025 19:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iltl/WoK"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83CD2C3761
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 19:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755890490; cv=none; b=eKTm0ER1vVf5vLV0W0tQJdHQmHH0cIKcQW0bW8ggPEtIBjXqZ7HKj8mHfqO970GAKNQU7IpaywefWFfwaaGVHqEmx94mT4d9i7xwE1yif7TqNTjZ2xcUPsoAgCmv0FfvUX2R9luyfBeBTgJm9fpUw6uwllXt3LwmxC5aH0Ks4OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755890490; c=relaxed/simple;
	bh=UYlL7KajnNY98PmVMNm3u6UyJPjQoJ31OKSOgyflwVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6wFwSO4W63q760N7B24HYLWA3R7a1yOAGujRNWqTfFIiqxITYbo4oYqLipiWebbJWC6TTBdec9BcxRvlcUXg5LDrYMW/COWK7KVMLF3FsIQHddwYe+bMJ6GQXZW9gralTTWmjSfpMqwB/tEGFzhsQdFnA+ePfuEGRLzhCbyiaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iltl/WoK; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b0faa6601cso44220191cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755890487; x=1756495287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r+1HQ2TlvwxlBkr62a2H4qwZSY6nsOPwAVU1BBwtoJE=;
        b=iltl/WoKY1/Nu6wgujrQNwFJCPGlxtwwjcT98+V78Tfrzu8j2qXfW8UEEROBMYVHEH
         XHbOwRuaYj0lTuz40woQ33NR2kyZI9WMJRIwWO3Xox1ZaMoM7BJ/GXF8bbyEvT3POlKT
         vRusq3mYwLGwTfQCiq5Zl0oI+UJM2ix77OBbWPDJZzlTqi9+1i8lVmNtBnvoDU2vMOzJ
         o86LvpZvan2OvblcOkBePiRPlYmMVHz4er5em0FDojkh24fjrLF2Y4I/2LIJZafMuMPH
         Rwy2NB7/reSSU3LWhnAxTz31KalUvbwaEQOEBTTvJ/teDlElkCKDr425+1dahwJ5kZJv
         wxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755890487; x=1756495287;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r+1HQ2TlvwxlBkr62a2H4qwZSY6nsOPwAVU1BBwtoJE=;
        b=Rtd/v2H1ytS1ZkHhD/BXchXhbM2BfFbzCUVq8NVU8YZZNF7iHC+T0RcPkmdIwug4Fh
         NlwnBp0Y0U5YxBsuo1iZE8YNWlneY3frQmGfKHkX4f8H9lqYYDThvxJnTNSnY8UxZNF/
         ttlYyBlROotiiH0EzIpdVyycmvzH8PrZPEAhipXqzqCdbjnO0kuKR2LqoFmb7DEte4S+
         1oz0YBNbZow6EES/jtptfCOv71DuH5T5KcfhDvTeTlAarxd+QdM0haTNt653YMOlM2cM
         Me7+YcEislW2AT5260N5pl1gE34Ic7HGJ6UX+INeHc1LkpsAuhI/4AKLFNzr9D/bdE2Z
         venQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUXMxFCtaV4sTk+F9o4uahVvhwDY1rXNeYxz2kwX33O3ak1f+WehSU5TXdSMjaRAmkDOQoI5LI62vkjRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6nX2Nxvj4wKnLfvVB833Razs0TBm9fAex4g+QPJablBEmcDYP
	Z2lETO2YxhXMQgYiZCz6qeQspuHOV0Yu2i80X6GSKoElXURPd2TZeFjQ
X-Gm-Gg: ASbGncsguJ8HWpS1pZMpwu8tTKTOljUUFbMQksF1t6kfXDOIs+AKZFWnevc1u8HgU9L
	v9F8E3sIaCfdyJ6Ut9JQN767vsIXPeT8m75G36Lv089hyMnxCKAWFNhuZR4z4cWSIIOh1sNySyL
	hjUHiOXLEAhdSv12Kuw43NMNPDSmND3kcfsWmKZotBo6uUrL3Ycv3scRrNzUiAyQrZG3UE6NIY/
	vM9k9LxlMl2a/m1fH/1hupvSR0f465981KFiswKA7zMKQ9BfmgZCeDOIYq1t57NeyCKpcEfOegU
	z/EHI291nfBGm5Io0I6dwmdCVNE0G8brYvbkOboIxnxW5mh8P/9+GFAG8z5rHI57kapfgLBxVaQ
	GZUGZ/++wyNz5u0cKWevOQ8acMEFTKdkflcBOJS7ck8Q=
X-Google-Smtp-Source: AGHT+IH2C/F6240WS4qBX1hA2FSLdhdG7hDUn141EwNBrggCl5LiHjq5wCWAwNtJS6EQdWBtk4nPzQ==
X-Received: by 2002:a05:6214:1d2b:b0:70b:ab14:d827 with SMTP id 6a1803df08f44-70d89327451mr75340296d6.7.1755890487565;
        Fri, 22 Aug 2025 12:21:27 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da72b04a6sm3843656d6.52.2025.08.22.12.21.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 22 Aug 2025 12:21:27 -0700 (PDT)
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
Subject: [PATCH 7/9] mm, swap: remove contention workaround for swap cache
Date: Sat, 23 Aug 2025 03:20:21 +0800
Message-ID: <20250822192023.13477-8-ryncsn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250822192023.13477-1-ryncsn@gmail.com>
References: <20250822192023.13477-1-ryncsn@gmail.com>
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
size (2M) was much smaller than each swap cache space (64M), so shuffling
the cluster means the allocator will try to allocate swap slots that are
in different swap cache spaces for each CPU, reducing the chance of two
CPUs using the same swap cache space, and hence reducing the contention.

Now, swap cache is managed by swap clusters, this shuffle is pointless.
Just remove it, and clean up related macros.

This should also improve the HDD swap performance as shuffling IO is a
bad idea for HDD, and now the shuffling is gone.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202504241621.f27743ec-lkp@intel.com
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap.h     |  4 ----
 mm/swapfile.c | 32 ++++++++------------------------
 mm/zswap.c    |  7 +++++--
 3 files changed, 13 insertions(+), 30 deletions(-)

diff --git a/mm/swap.h b/mm/swap.h
index 4af42bc2cd72..ce3ec62cc05e 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -153,10 +153,6 @@ int swap_writeout(struct folio *folio, struct swap_iocb **swap_plug);
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
index df68b5e242a6..0c8001c99f30 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3203,21 +3203,14 @@ static int setup_swap_map(struct swap_info_struct *si,
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
@@ -3266,22 +3259,13 @@ static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
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
index c869859eec77..c0a9be14a725 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -237,10 +237,13 @@ static bool zswap_has_pool;
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
 
 #define zswap_pool_debug(msg, p)				\
@@ -1771,7 +1774,7 @@ int zswap_swapon(int type, unsigned long nr_pages)
 	struct xarray *trees, *tree;
 	unsigned int nr, i;
 
-	nr = DIV_ROUND_UP(nr_pages, SWAP_ADDRESS_SPACE_PAGES);
+	nr = DIV_ROUND_UP(nr_pages, ZSWAP_ADDRESS_SPACE_PAGES);
 	trees = kvcalloc(nr, sizeof(*tree), GFP_KERNEL);
 	if (!trees) {
 		pr_err("alloc failed, zswap disabled for swap type %d\n", type);
-- 
2.51.0



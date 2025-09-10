Return-Path: <linux-kernel+bounces-810634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D81B51D25
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B60E94810BB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8ED340D84;
	Wed, 10 Sep 2025 16:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcfMHYcQ"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6582033EB18
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520593; cv=none; b=o162a6/u/qC+1ArfWHkvqBGYkHiMEczlIF3vne14+H9FQxvrK3QVx8NpV5KPrUrDcx1OxaeeMpa2XR0/o4zytSXCqChKFQdZaiWJz0FqJO1hEJUOgJkvBAUQVKYh8Zd0ch7WTVAbMGeaJUNMSqimRYqj08EbCvvZW1EEkho//hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520593; c=relaxed/simple;
	bh=gzjZTwxGbEP21GLGwFbxoi6pwA4ybOJR49Hf3hcPCNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LgUFGtIbmIyssVbMH9NMn1svCQmu/wwsFSVByBMl/OGjy03KppklYkA7izV0+wvl6pkq8oVMA4ATSUBOXj3xFv6v6Pw0hxC9jwDZ3Bwry5qASD20wSFUmm2sbkBOsrY0qfhQ3wLwODXihrFf/Fb+Neg9htQ3mV9VlSQU5Bm8y94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcfMHYcQ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77264a94031so4816611b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757520591; x=1758125391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=su4PnDYf8OUfLgI2Lrokhalmhp7VgFbGjYZtLVCSA2o=;
        b=KcfMHYcQjpEWSJWWgpKWlMTwqn6z1Ie1NeaNNiKB9G6X2xugN/+0SMfBCh8L0twPGY
         FQ0MCLEOEH+VTCdaHdUVDlNwV3/0pQ6UkBshQiKCfPGtsSHLo9HgPzpGL09nSgkW6Xmu
         nedX2qsrwDaF4dBa7fKckTDdejqZv9SzolB0Wc3pNZbk9WY/hw+GFn2RyHJyMT2j5Jn+
         JkXUUm8I/J41H+qRhNQTMgTjB+J4ouJ1XMzxKrCJWpgFBkLpHWvxJ5EnKmgqKtmXPRQg
         y+dAODlkWSZLg7IOplLCzhBdCaHVH7s8FX7sfM6Rkv6PqYdp6ymGUnwM6Vd6sAQAe9Eu
         2R7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757520591; x=1758125391;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=su4PnDYf8OUfLgI2Lrokhalmhp7VgFbGjYZtLVCSA2o=;
        b=KjU7mjDEhXfYM6c2gxUq+H05tMTbBeJ4PCBC58JoKqWwkwTaBZtklBp7Ub/0bX4JpQ
         dGqz/8ujc3I3GXX8jXeSBcSly5uG1rGE6BhyHlnIvHJ8C2Pz1NQRcrGxmPVROWMY5udC
         REukL2hqnEsFOT0vosMp9rxdQSco64CcU5FjwzGXtR4Uj5cCQksUUuoEYjF/eaxoBrjE
         zZORWBpmuArnOHVLnv/G9HSuqaSEk2AZwfaPxcCSbLXxnghyyk+oeleyH3G0+kO+u8VA
         WM+i97E3ZDYCq7LhRw9iXHMjafuUK0cAbCm+2FHOHkLN1kN8CO9JOQM7ZfuUXfD01gWs
         RINQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+PatyGQAPfkBQqNfh+t1Zz61kUJihZ8kegG98QSaIttIWFLf72yTeT31+OrZIVfFY8BwPOo/WQ2erwjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTU9020zfieYpPFkpEk9X4HfOkoqpe0jPNCAHlJKJc/S1Ab8mE
	EfZmsscsfYrOC5JGKC9lrIjOjFBngbxg6HaPZjCoPUwGD7dyMaUrfnxA
X-Gm-Gg: ASbGncv8cf0LnGxULReqq1r3OgxdWNPhCp0Nw0JcrYVg2+j9mU7mPDoyN3P1GQXaPIR
	VOVi3s2bvM6P2RH2YaxK0yw6ApR6Ji9//zh8wMgGxRSeXXdfOAMqo5mlTqfwgAHyQscVI8Bl3gS
	OIguQn5NLz2zH8NIG3HnOJG5jbc2p99VdEiwvGhNMuzUiZtQt+cWxX5RaBLepEliNcMBdAaTqJa
	q/jyD4Wn/61TgYYPfJOYps1lbkwIeeLEq9R7qExX6olOFH7mJC0AajbJLXQdnS/GN7rGbXZl7Jj
	O5+s+PFsdj2O652K+qmgR5PptrYw9t4qkWEWGQ0t74T+Ir3UO4dK/StFugYAXAqjSOsV4t+X5dO
	0xeKYx9BTYyxZnY00/wUsa1RkjJRNhPA/ll3kDXI/cIldXYU=
X-Google-Smtp-Source: AGHT+IEXDaG6nULakGwHLuDrhEcX+0zJ4/JSzZr8GFi2sn5vxnMvwdyigmF9NkrFHeceSC2DScxt2A==
X-Received: by 2002:a05:6a20:1584:b0:246:1e3:1f6f with SMTP id adf61e73a8af0-2533dcc0596mr25473628637.12.1757520590541;
        Wed, 10 Sep 2025 09:09:50 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54998a1068sm1000142a12.31.2025.09.10.09.09.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Sep 2025 09:09:50 -0700 (PDT)
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
Subject: [PATCH v3 13/15] mm, swap: remove contention workaround for swap cache
Date: Thu, 11 Sep 2025 00:08:31 +0800
Message-ID: <20250910160833.3464-14-ryncsn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910160833.3464-1-ryncsn@gmail.com>
References: <20250910160833.3464-1-ryncsn@gmail.com>
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
index a81ada4a361d..89659928465e 100644
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



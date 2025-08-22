Return-Path: <linux-kernel+bounces-782616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 542C3B322BE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED0C640925
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9E32D1F4E;
	Fri, 22 Aug 2025 19:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKTPg9wq"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6F92D12E1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 19:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755890471; cv=none; b=qFI4o9mghWswo7YNkshS0TiPbDA7F0ypTs4pCnB5a36n1V3hfhUZdwibNH8gUONkf+Kg1zfkcME31VoKI0Zb/ns7QG9YrtozGhAtyvwJAwj+ZkCOWw1UUzMSSx+aNaibLUqxyeAUz7sslZdbKX3q7Vd16DWEDQsrt7h+6Unwb14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755890471; c=relaxed/simple;
	bh=POLs5ipBOXXV/ebWFaZVhpJOdmaVUojkXhzuNkbkVsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+IeJ+IPYZWZVPLLeP+uBwGYyAvbHDiqk50rVbgjyWhCEj4qmLNBWYlFbYwBvnxwVdGrMG3cNl+D+GS8f5mpOxrbEgD4+CK/7UIGzApu9kcP0RepQCwWo0HmzOtfyZGWCKaH6TMcjxXGvCkEtJH8RgkHH0RP8GmKuRYeOEZXGvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKTPg9wq; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-70d9eb2e976so6682046d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755890468; x=1756495268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9KKlr1vdm+W9XSUyQPRVxPSMfJ3nwxE8pge88LauYMw=;
        b=LKTPg9wqHXGt9vndIj8hxKLYzQYJ41g7G4dHyLbmKpj/6+KoozLV38OrqlC9Nul9Kk
         t9Fy9W01xvh+8r45BpMsoqWW0l7ehh33tGpwjOczAWQCuxliTbiOqpEH0SopUwHY7IQx
         +4DCSQCXuPfl0WJWGHdnzGlaSA4wRHWYdc+aueso2FJ414rzHPlRMU1xQz6pRAc95VZb
         hBGMWyQq6ynZ2i+JG12b8bRsMwdLLkXq72nKmuD1O8zuRjnMdgv7ZWkRxwHbFICauOrp
         lli8RJeT02SZJq241M6h215CJ/t2nhhtnz+DZ54dYtyTBuzJ328MpOJ7hRgF3wyR1kdG
         6fBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755890468; x=1756495268;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9KKlr1vdm+W9XSUyQPRVxPSMfJ3nwxE8pge88LauYMw=;
        b=sR0kojEjH8R+10l3gzULX8ZpCifIo4l7Xb6FHvRdf3eJQrkh17jvGoN6SmzhpoK4Og
         aDDmYRpVbDr4JztLliO2cYqvCNCqtSOzu4+Xbs6f9Z7OrBm48+NmRq2GVPnCxe5JCks4
         BJnPDLeCqOdbdICP7CLN1IPLZ6DQVNTKnSNbO3y6P1+ShlqqMvnJkgv7KrMwyrCTJFf8
         khc1P2t93VdsvDg/Efj7G5aOMOXh+Em45gZJ3USDsxgmVlSaNibSsDM7Bxfc1b3+vPqS
         620eWDa68mypWdVYUvwPfNGG84t4vLZ1ApM7QzdCs1afCLMD/DaZAuaQJQEsl5i7cn+5
         RUPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0HcAg0SHTpAQjiGQdGhA9ixR+zUX5yDs+65Z2jqhgm7LbjPkEooLP2fiY0kkz27gyN5yLS1eD1HwwEZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8KK1DPUy+M1Mm/fLsJKoRnmvRhivMZzn1zqRox28sWqZREeEX
	ABxXLA256uiADM20N44/oiSC47TbahFukT7zYXGD6axKIbWTRJcp3rFR
X-Gm-Gg: ASbGncuruTTAiCGeUodslFb+PTThlpkx8YlxEhM0wrW5fApvn1beFn8V01Oqe4OGGwQ
	ykGt1w9/HwSgJKHit/Tomawh4sfeL9KxDvUSnXTXBlplS/Xkt/5i7oxLClkmF3l0uEkRTLu4RVW
	z6LbHObwx6AnVhUPVFskLcJPtdBthv6VMKNbcc/0aEL5y6S+2y01Stmn/k3GWnthBXzuBB3MV6i
	s2LkjU3+DFaJRPGFkTpLKlloabIxzJYzPwtDD6QqT435hMb2EFqpTgXC8iskOB/gsgrfUc1hqpZ
	R7XCPItI7qIj3y4FQG+Ulfy2AqAtGDHcnOMdkIUwXN7IiLNFTs64Wm3zU9758U7FtdA/4PZNp6C
	Vv8iLt8Nim7SDSpZPFq/o1Vsckn9Mtt+4KNzJSRa971s=
X-Google-Smtp-Source: AGHT+IHgYS0Hlci+j0Mlm6zl7ZxCN8MaCGGQNiHPLXTtkunhsWsiLD4KH7akKu/0X+oTS5atNzCeRg==
X-Received: by 2002:a05:6214:6211:b0:70d:9e0a:5ab1 with SMTP id 6a1803df08f44-70d9e0a5f2dmr17911516d6.22.1755890468302;
        Fri, 22 Aug 2025 12:21:08 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da72b04a6sm3843656d6.52.2025.08.22.12.21.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 22 Aug 2025 12:21:07 -0700 (PDT)
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
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 4/9] mm, swap: tidy up swap device and cluster info helpers
Date: Sat, 23 Aug 2025 03:20:18 +0800
Message-ID: <20250822192023.13477-5-ryncsn@gmail.com>
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

swp_swap_info is the most commonly used helper for retrieving swap info.
It has an internal check that may lead to a NULL return value, but
almost none of its caller checks the return value, making the internal
check pointless. In fact, most of these callers already ensured the
entry is valid and never expect a NULL value.

Tidy this up and shorten the name. If the caller can make sure the
swap entry/type is valid and the device is pinned, use the new introduced
swp_info/swp_type_info instead. They have more debug sanity checks and
lower overhead as they are inlined.

Callers that may expect a NULL value should use
swp_get_info/swp_type_get_info instead.

No feature change. The rearranged codes should have had no effect, or
they should have been hitting NULL de-ref bugs already. Some new sanity
checks have been added to the debug build to catch potential misuse.
And the new helpers will be used by swap cache when working with locked
swap cache folios, as a locked swap cache ensures the entries are valid
and stable.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/swap.h |  6 ------
 mm/page_io.c         | 12 ++++++------
 mm/swap.h            | 33 ++++++++++++++++++++++++++++++---
 mm/swap_state.c      |  4 ++--
 mm/swapfile.c        | 35 ++++++++++++++++++-----------------
 5 files changed, 56 insertions(+), 34 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 20efd9a34034..cb59c13fef42 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -469,7 +469,6 @@ extern sector_t swapdev_block(int, pgoff_t);
 extern int __swap_count(swp_entry_t entry);
 extern bool swap_entry_swapped(struct swap_info_struct *si, swp_entry_t entry);
 extern int swp_swapcount(swp_entry_t entry);
-struct swap_info_struct *swp_swap_info(swp_entry_t entry);
 struct backing_dev_info;
 extern int init_swap_address_space(unsigned int type, unsigned long nr_pages);
 extern void exit_swap_address_space(unsigned int type);
@@ -482,11 +481,6 @@ static inline void put_swap_device(struct swap_info_struct *si)
 }
 
 #else /* CONFIG_SWAP */
-static inline struct swap_info_struct *swp_swap_info(swp_entry_t entry)
-{
-	return NULL;
-}
-
 static inline struct swap_info_struct *get_swap_device(swp_entry_t entry)
 {
 	return NULL;
diff --git a/mm/page_io.c b/mm/page_io.c
index a2056a5ecb13..bc164677d70b 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -204,7 +204,7 @@ static bool is_folio_zero_filled(struct folio *folio)
 static void swap_zeromap_folio_set(struct folio *folio)
 {
 	struct obj_cgroup *objcg = get_obj_cgroup_from_folio(folio);
-	struct swap_info_struct *sis = swp_swap_info(folio->swap);
+	struct swap_info_struct *sis = swp_info(folio->swap);
 	int nr_pages = folio_nr_pages(folio);
 	swp_entry_t entry;
 	unsigned int i;
@@ -223,7 +223,7 @@ static void swap_zeromap_folio_set(struct folio *folio)
 
 static void swap_zeromap_folio_clear(struct folio *folio)
 {
-	struct swap_info_struct *sis = swp_swap_info(folio->swap);
+	struct swap_info_struct *sis = swp_info(folio->swap);
 	swp_entry_t entry;
 	unsigned int i;
 
@@ -374,7 +374,7 @@ static void sio_write_complete(struct kiocb *iocb, long ret)
 static void swap_writepage_fs(struct folio *folio, struct swap_iocb **swap_plug)
 {
 	struct swap_iocb *sio = swap_plug ? *swap_plug : NULL;
-	struct swap_info_struct *sis = swp_swap_info(folio->swap);
+	struct swap_info_struct *sis = swp_info(folio->swap);
 	struct file *swap_file = sis->swap_file;
 	loff_t pos = swap_dev_pos(folio->swap);
 
@@ -446,7 +446,7 @@ static void swap_writepage_bdev_async(struct folio *folio,
 
 void __swap_writepage(struct folio *folio, struct swap_iocb **swap_plug)
 {
-	struct swap_info_struct *sis = swp_swap_info(folio->swap);
+	struct swap_info_struct *sis = swp_info(folio->swap);
 
 	VM_BUG_ON_FOLIO(!folio_test_swapcache(folio), folio);
 	/*
@@ -537,7 +537,7 @@ static bool swap_read_folio_zeromap(struct folio *folio)
 
 static void swap_read_folio_fs(struct folio *folio, struct swap_iocb **plug)
 {
-	struct swap_info_struct *sis = swp_swap_info(folio->swap);
+	struct swap_info_struct *sis = swp_info(folio->swap);
 	struct swap_iocb *sio = NULL;
 	loff_t pos = swap_dev_pos(folio->swap);
 
@@ -608,7 +608,7 @@ static void swap_read_folio_bdev_async(struct folio *folio,
 
 void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 {
-	struct swap_info_struct *sis = swp_swap_info(folio->swap);
+	struct swap_info_struct *sis = swp_info(folio->swap);
 	bool synchronous = sis->flags & SWP_SYNCHRONOUS_IO;
 	bool workingset = folio_test_workingset(folio);
 	unsigned long pflags;
diff --git a/mm/swap.h b/mm/swap.h
index 223b40f2d37e..7b3efaa51624 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -15,6 +15,8 @@ extern int page_cluster;
 #define swap_entry_order(order)	0
 #endif
 
+extern struct swap_info_struct *swap_info[];
+
 /*
  * We use this to track usage of a cluster. A cluster is a block of swap disk
  * space with SWAPFILE_CLUSTER pages long and naturally aligns in disk. All
@@ -53,9 +55,28 @@ enum swap_cluster_flags {
 #include <linux/swapops.h> /* for swp_offset */
 #include <linux/blk_types.h> /* for bio_end_io_t */
 
+/*
+ * Callers of all swp_* helpers here must ensure the entry is valid, and
+ * pin the swap device by reference or in other ways.
+ */
+static inline struct swap_info_struct *swp_type_info(int type)
+{
+	struct swap_info_struct *si;
+
+	si = READ_ONCE(swap_info[type]); /* rcu_dereference() */
+	VM_WARN_ON_ONCE(percpu_ref_is_zero(&si->users)); /* race with swapoff */
+	return si;
+}
+
+static inline struct swap_info_struct *swp_info(swp_entry_t entry)
+{
+	return swp_type_info(swp_type(entry));
+}
+
 static inline struct swap_cluster_info *swp_offset_cluster(
 		struct swap_info_struct *si, pgoff_t offset)
 {
+	VM_WARN_ON_ONCE(percpu_ref_is_zero(&si->users)); /* race with swapoff */
 	return &si->cluster_info[offset / SWAPFILE_CLUSTER];
 }
 
@@ -65,6 +86,7 @@ static inline struct swap_cluster_info *swap_cluster_lock(
 {
 	struct swap_cluster_info *ci = swp_offset_cluster(si, offset);
 
+	VM_WARN_ON_ONCE(percpu_ref_is_zero(&si->users)); /* race with swapoff */
 	spin_lock(&ci->lock);
 	return ci;
 }
@@ -164,7 +186,7 @@ void swap_update_readahead(struct folio *folio, struct vm_area_struct *vma,
 
 static inline unsigned int folio_swap_flags(struct folio *folio)
 {
-	return swp_swap_info(folio->swap)->flags;
+	return swp_info(folio->swap)->flags;
 }
 
 /*
@@ -175,7 +197,7 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
 static inline int swap_zeromap_batch(swp_entry_t entry, int max_nr,
 		bool *is_zeromap)
 {
-	struct swap_info_struct *sis = swp_swap_info(entry);
+	struct swap_info_struct *sis = swp_info(entry);
 	unsigned long start = swp_offset(entry);
 	unsigned long end = start + max_nr;
 	bool first_bit;
@@ -194,7 +216,7 @@ static inline int swap_zeromap_batch(swp_entry_t entry, int max_nr,
 
 static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
 {
-	struct swap_info_struct *si = swp_swap_info(entry);
+	struct swap_info_struct *si = swp_info(entry);
 	pgoff_t offset = swp_offset(entry);
 	int i;
 
@@ -213,6 +235,11 @@ static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
 
 #else /* CONFIG_SWAP */
 struct swap_iocb;
+static inline struct swap_info_struct *swp_info(swp_entry_t entry)
+{
+	return NULL;
+}
+
 static inline void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 {
 }
diff --git a/mm/swap_state.c b/mm/swap_state.c
index be0d96494dc1..721ff1a5e73a 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -330,7 +330,7 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		struct mempolicy *mpol, pgoff_t ilx, bool *new_page_allocated,
 		bool skip_if_exists)
 {
-	struct swap_info_struct *si = swp_swap_info(entry);
+	struct swap_info_struct *si = swp_info(entry);
 	struct folio *folio;
 	struct folio *new_folio = NULL;
 	struct folio *result = NULL;
@@ -554,7 +554,7 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	unsigned long offset = entry_offset;
 	unsigned long start_offset, end_offset;
 	unsigned long mask;
-	struct swap_info_struct *si = swp_swap_info(entry);
+	struct swap_info_struct *si = swp_info(entry);
 	struct blk_plug plug;
 	struct swap_iocb *splug = NULL;
 	bool page_allocated;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 618cf4333a3d..85606fbebf0f 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -102,7 +102,7 @@ static PLIST_HEAD(swap_active_head);
 static struct plist_head *swap_avail_heads;
 static DEFINE_SPINLOCK(swap_avail_lock);
 
-static struct swap_info_struct *swap_info[MAX_SWAPFILES];
+struct swap_info_struct *swap_info[MAX_SWAPFILES];
 
 static DEFINE_MUTEX(swapon_mutex);
 
@@ -124,14 +124,20 @@ static DEFINE_PER_CPU(struct percpu_swap_cluster, percpu_swap_cluster) = {
 	.lock = INIT_LOCAL_LOCK(),
 };
 
-static struct swap_info_struct *swap_type_to_swap_info(int type)
+/* May return NULL on invalid type, caller must check for NULL return */
+static struct swap_info_struct *swp_type_get_info(int type)
 {
 	if (type >= MAX_SWAPFILES)
 		return NULL;
-
 	return READ_ONCE(swap_info[type]); /* rcu_dereference() */
 }
 
+/* May return NULL on invalid entry, caller must check for NULL return */
+static struct swap_info_struct *swp_get_info(swp_entry_t entry)
+{
+	return swp_type_get_info(swp_type(entry));
+}
+
 static inline unsigned char swap_count(unsigned char ent)
 {
 	return ent & ~SWAP_HAS_CACHE;	/* may include COUNT_CONTINUED flag */
@@ -343,7 +349,7 @@ offset_to_swap_extent(struct swap_info_struct *sis, unsigned long offset)
 
 sector_t swap_folio_sector(struct folio *folio)
 {
-	struct swap_info_struct *sis = swp_swap_info(folio->swap);
+	struct swap_info_struct *sis = swp_info(folio->swap);
 	struct swap_extent *se;
 	sector_t sector;
 	pgoff_t offset;
@@ -1301,7 +1307,7 @@ static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
 
 	if (!entry.val)
 		goto out;
-	si = swp_swap_info(entry);
+	si = swp_get_info(entry);
 	if (!si)
 		goto bad_nofile;
 	if (data_race(!(si->flags & SWP_USED)))
@@ -1416,7 +1422,7 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
 
 	if (!entry.val)
 		goto out;
-	si = swp_swap_info(entry);
+	si = swp_get_info(entry);
 	if (!si)
 		goto bad_nofile;
 	if (!get_swap_device_info(si))
@@ -1597,7 +1603,7 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
 
 int __swap_count(swp_entry_t entry)
 {
-	struct swap_info_struct *si = swp_swap_info(entry);
+	struct swap_info_struct *si = swp_info(entry);
 	pgoff_t offset = swp_offset(entry);
 
 	return swap_count(si->swap_map[offset]);
@@ -1828,7 +1834,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
 
 swp_entry_t get_swap_page_of_type(int type)
 {
-	struct swap_info_struct *si = swap_type_to_swap_info(type);
+	struct swap_info_struct *si = swp_type_get_info(type);
 	unsigned long offset;
 	swp_entry_t entry = {0};
 
@@ -1909,7 +1915,7 @@ int find_first_swap(dev_t *device)
  */
 sector_t swapdev_block(int type, pgoff_t offset)
 {
-	struct swap_info_struct *si = swap_type_to_swap_info(type);
+	struct swap_info_struct *si = swp_type_get_info(type);
 	struct swap_extent *se;
 
 	if (!si || !(si->flags & SWP_WRITEOK))
@@ -2837,7 +2843,7 @@ static void *swap_start(struct seq_file *swap, loff_t *pos)
 	if (!l)
 		return SEQ_START_TOKEN;
 
-	for (type = 0; (si = swap_type_to_swap_info(type)); type++) {
+	for (type = 0; (si = swp_type_get_info(type)); type++) {
 		if (!(si->flags & SWP_USED) || !si->swap_map)
 			continue;
 		if (!--l)
@@ -2858,7 +2864,7 @@ static void *swap_next(struct seq_file *swap, void *v, loff_t *pos)
 		type = si->type + 1;
 
 	++(*pos);
-	for (; (si = swap_type_to_swap_info(type)); type++) {
+	for (; (si = swp_type_get_info(type)); type++) {
 		if (!(si->flags & SWP_USED) || !si->swap_map)
 			continue;
 		return si;
@@ -3531,7 +3537,7 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
 	unsigned char has_cache;
 	int err, i;
 
-	si = swp_swap_info(entry);
+	si = swp_get_info(entry);
 	if (WARN_ON_ONCE(!si)) {
 		pr_err("%s%08lx\n", Bad_file, entry.val);
 		return -EINVAL;
@@ -3646,11 +3652,6 @@ void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry, int nr)
 	swap_entries_put_cache(si, entry, nr);
 }
 
-struct swap_info_struct *swp_swap_info(swp_entry_t entry)
-{
-	return swap_type_to_swap_info(swp_type(entry));
-}
-
 /*
  * add_swap_count_continuation - called when a swap count is duplicated
  * beyond SWAP_MAP_MAX, it allocates a new page and links that to the entry's
-- 
2.51.0



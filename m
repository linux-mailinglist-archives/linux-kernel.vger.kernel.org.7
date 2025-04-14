Return-Path: <linux-kernel+bounces-602043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F81FA875BC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 04:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8978517004B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 02:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2FC18A953;
	Mon, 14 Apr 2025 02:06:41 +0000 (UTC)
Received: from invmail3.skhynix.com (exvmail3.skhynix.com [166.125.252.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5A2AD21
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 02:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744596401; cv=none; b=YRW+rGmj+YVzySBe7KHQn/gQTMVuYmftld9BiKlXsfa+SlhKuB5BL5yW1RtvOlaJYHlX+I2n9vFd5oKnPr/4wQMAtM4wxm+pET4VHH/Py9dr39hYBTSMsxamhDQQvdvQMOjAEIK9r22OZMyc9AFGTn2GpPVNpNMjEKTrMasoVeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744596401; c=relaxed/simple;
	bh=qvmh/BcGD8D8QuDIhq+D3R+/IbUatd6hFPA96UAUZ6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y61ZA1AXPJONauUMPpkeI5pw9iL+8NfbStlROD9C6Da3f57K9uHFuCke3NJZh6/H3GYphy793IUfwI+yuGmoI+G8z3A2jCtoOQW9ZNhLT+1e0X9+7y+fB6H3WTNKiy2DdOs9hPxAlHCekLMbxkOqtFDiL+7lu/RIesUKsmEKCZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc59-057ff7000000aab6-98-67fc6da203e9
From: "yohan.joung" <yohan.joung@sk.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	pilhyun.kim@sk.com,
	"yohan.joung" <yohan.joung@sk.com>
Subject: [PATCH v2] f2fs: Improve large section GC by locating valid block segments
Date: Mon, 14 Apr 2025 11:06:08 +0900
Message-ID: <20250414020609.1962-1-yohan.joung@sk.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42LhesuzUHdR7p90g6v9Whanp55lsniyfhaz
	xaVF7haXd81hc2Dx2LSqk81j94LPTB6fN8kFMEdx2aSk5mSWpRbp2yVwZZx6MJe94KNzxafZ
	b9gbGJ+bdzFyckgImEhcbNvFCmN/nX6AHcRmE9CQ+NPbywxiiwhoShzpnAkWZxZoY5S49dcX
	xBYWCJbouniSqYuRg4NFQFXiyXQFkDCvgJnElWf9LBAjNSV2fDnPBBEXlDg58wkLxBh5ieat
	s4HGcwHV3GWVWP/pGCNEg6TEwRU3WCYw8s5C0jMLSc8CRqZVjCKZeWW5iZk5xnrF2RmVeZkV
	esn5uZsYgcG0rPZP5A7GbxeCDzEKcDAq8fAmHP6dLsSaWFZcmXuIUYKDWUmEl8v5V7oQb0pi
	ZVVqUX58UWlOavEhRmkOFiVxXqNv5SlCAumJJanZqakFqUUwWSYOTqkGxjlX/moZfL9nvMz3
	+7SXZyOenl3nJLuw+dwc3UcP7ktePryz11Fl0+5Z15a+5Hefu+fuqs2bVrZFWUpYlDvf21Gu
	dPqfud+ryXmHV7TYNahMOLx1F0Oy/+kEr9M6DEzrdiyv+Th7/tLqzR4Ox+TKPVy085eyPPCJ
	Zzvx8F+96oRrKpkhfDO8Tn5UYinOSDTUYi4qTgQAZmBDgyICAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBJMWRmVeSWpSXmKPExsXCNUNlju6i3D/pBjtbuS1OTz3LZPFk/Sxm
	i0uL3C0u75rDZjFh7lUmi/db7zE6sHlsWtXJ5rF7wWcmj2+3PTw+b5ILYInisklJzcksSy3S
	t0vgyjj1YC57wUfnik+z37A3MD4372Lk5JAQMJH4Ov0AO4jNJqAh8ae3lxnEFhHQlDjSORMs
	zizQxihx668viC0sECzRdfEkUxcjBweLgKrEk+kKIGFeATOJK8/6WSBGakrs+HKeCSIuKHFy
	5hMWiDHyEs1bZzNPYOSahSQ1C0lqASPTKkaRzLyy3MTMHDO94uyMyrzMCr3k/NxNjMDwWFb7
	Z9IOxm+X3Q8xCnAwKvHwJhz+nS7EmlhWXJl7iFGCg1lJhJfL+Ve6EG9KYmVValF+fFFpTmrx
	IUZpDhYlcV6v8NQEIYH0xJLU7NTUgtQimCwTB6dUA2O9kZH53ltOW+sZzhsf0uwMloraPf2x
	VsBf/yKW4pzQb2Lq3SKFJ/n12H3jtI8ckA9d2Tv968PHaonbWHcXrg26JnlzV+iT6XIBrT+b
	snbpr/LL/9h17eRqZfYrCfuESwJNUnIif/w92bZoxe67+3bxpPmsmr7YtIVBdP+E/b3Lki7F
	C52KtldiKc5INNRiLipOBADr501sCwIAAA==
X-CFilter-Loop: Reflected

Change the large section GC to locate valid block segments instead of
performing a sequential search. This modification enhances performance
by reducing unnecessary block scanning in large storage sections.

example :
[invalid seg 0] [invalid seg 1] [invalid seg 2]
[  valid seg 3] [  valid seg 4] [  valid seg 5]

Current: In the first GC, nothing is moved,
but in the second GC, segments 3, 4, and 5 are moved.
Change: In the first GC, segments 3, 4, and 5 are moved.

Signed-off-by: yohan.joung <yohan.joung@sk.com>
---
 fs/f2fs/f2fs.h  |  2 ++
 fs/f2fs/gc.c    | 89 +++++++++++++++++++++++++++++++++++++------------
 fs/f2fs/gc.h    |  6 ++++
 fs/f2fs/super.c |  8 ++++-
 4 files changed, 82 insertions(+), 23 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f1576dc6ec67..348417edac25 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4008,6 +4008,8 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 int f2fs_resize_fs(struct file *filp, __u64 block_count);
 int __init f2fs_create_garbage_collection_cache(void);
 void f2fs_destroy_garbage_collection_cache(void);
+int __init f2fs_init_garbage_collection_summary_cache(void);
+void f2fs_destroy_garbage_collection_summary_cache(void);
 /* victim selection function for cleaning and SSR */
 int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
 			int gc_type, int type, char alloc_mode,
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 2b8f9239bede..fcd2cf68612d 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -24,6 +24,7 @@
 #include <trace/events/f2fs.h>
 
 static struct kmem_cache *victim_entry_slab;
+static struct kmem_cache *gc_page_entry_slab;
 
 static unsigned int count_bits(const unsigned long *addr,
 				unsigned int offset, unsigned int len);
@@ -711,6 +712,30 @@ static void release_victim_entry(struct f2fs_sb_info *sbi)
 	f2fs_bug_on(sbi, !list_empty(&am->victim_list));
 }
 
+static struct gc_page_entry *add_gc_page_entry(struct list_head *gc_page_list,
+					struct page *sum_page, unsigned int segno)
+{
+	struct gc_page_entry *gpe;
+
+	gpe = f2fs_kmem_cache_alloc(gc_page_entry_slab, GFP_NOFS, true, NULL);
+	gpe->segno = segno;
+	gpe->sum_page = sum_page;
+	list_add_tail(&gpe->list, gc_page_list);
+	return gpe;
+}
+
+static void release_gc_page_entry(struct list_head *gc_page_list, bool putpage)
+{
+	struct gc_page_entry *gpe, *tmp;
+
+	list_for_each_entry_safe(gpe, tmp, gc_page_list, list) {
+		if (putpage)
+			f2fs_put_page(gpe->sum_page, 0);
+		list_del(&gpe->list);
+		kmem_cache_free(gc_page_entry_slab, gpe);
+	}
+}
+
 static bool f2fs_pin_section(struct f2fs_sb_info *sbi, unsigned int segno)
 {
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
@@ -1721,14 +1746,18 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 	struct page *sum_page;
 	struct f2fs_summary_block *sum;
 	struct blk_plug plug;
+	struct gc_page_entry *gpe;
 	unsigned int segno = start_segno;
 	unsigned int end_segno = start_segno + SEGS_PER_SEC(sbi);
 	unsigned int sec_end_segno;
+	unsigned int window_granularity = 1;
 	int seg_freed = 0, migrated = 0;
 	unsigned char type = IS_DATASEG(get_seg_entry(sbi, segno)->type) ?
 						SUM_TYPE_DATA : SUM_TYPE_NODE;
 	unsigned char data_type = (type == SUM_TYPE_DATA) ? DATA : NODE;
 	int submitted = 0;
+	int gc_list_count = 0;
+	LIST_HEAD(gc_page_list);
 
 	if (__is_large_section(sbi)) {
 		sec_end_segno = rounddown(end_segno, SEGS_PER_SEC(sbi));
@@ -1744,7 +1773,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 					f2fs_usable_segs_in_sec(sbi);
 
 		if (gc_type == BG_GC || one_time) {
-			unsigned int window_granularity =
+			window_granularity =
 				sbi->migration_window_granularity;
 
 			if (f2fs_sb_has_blkzoned(sbi) &&
@@ -1752,8 +1781,6 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 					sbi->gc_thread->boost_zoned_gc_percent))
 				window_granularity *=
 					BOOST_GC_MULTIPLE;
-
-			end_segno = start_segno + window_granularity;
 		}
 
 		if (end_segno > sec_end_segno)
@@ -1762,37 +1789,38 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 
 	sanity_check_seg_type(sbi, get_seg_entry(sbi, segno)->type);
 
-	/* readahead multi ssa blocks those have contiguous address */
-	if (__is_large_section(sbi))
+	for (segno = start_segno; segno < end_segno; segno++) {
+		if (!get_valid_blocks(sbi, segno, false))
+			continue;
+
+		/* readahead multi ssa blocks those have contiguous address */
 		f2fs_ra_meta_pages(sbi, GET_SUM_BLOCK(sbi, segno),
-					end_segno - segno, META_SSA, true);
+				window_granularity, META_SSA, true);
 
-	/* reference all summary page */
-	while (segno < end_segno) {
-		sum_page = f2fs_get_sum_page(sbi, segno++);
+		/* reference all summary page */
+		sum_page = f2fs_get_sum_page(sbi, segno);
 		if (IS_ERR(sum_page)) {
 			int err = PTR_ERR(sum_page);
-
-			end_segno = segno - 1;
-			for (segno = start_segno; segno < end_segno; segno++) {
-				sum_page = find_get_page(META_MAPPING(sbi),
-						GET_SUM_BLOCK(sbi, segno));
-				f2fs_put_page(sum_page, 0);
-				f2fs_put_page(sum_page, 0);
-			}
+			release_gc_page_entry(&gc_page_list, true);
 			return err;
 		}
+		add_gc_page_entry(&gc_page_list, sum_page, segno);
 		unlock_page(sum_page);
+		if (++gc_list_count >= window_granularity)
+			break;
 	}
 
 	blk_start_plug(&plug);
 
-	for (segno = start_segno; segno < end_segno; segno++) {
+	list_for_each_entry(gpe, &gc_page_list, list) {
 
 		/* find segment summary of victim */
-		sum_page = find_get_page(META_MAPPING(sbi),
-					GET_SUM_BLOCK(sbi, segno));
-		f2fs_put_page(sum_page, 0);
+		sum_page = gpe->sum_page;
+		segno = gpe->segno;
+		if (!sum_page) {
+			f2fs_err(sbi, "Failed to get summary page for segment %u", segno);
+			goto skip;
+		}
 
 		if (get_valid_blocks(sbi, segno, false) == 0)
 			goto freed;
@@ -1838,15 +1866,20 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 		if (__is_large_section(sbi))
 			sbi->next_victim_seg[gc_type] =
 				(segno + 1 < sec_end_segno) ?
-					segno + 1 : NULL_SEGNO;
+				segno + 1 : NULL_SEGNO;
+
 skip:
 		f2fs_put_page(sum_page, 0);
 	}
 
+	if (__is_large_section(sbi) && list_empty(&gc_page_list))
+		sbi->next_victim_seg[gc_type] = NULL_SEGNO;
+
 	if (submitted)
 		f2fs_submit_merged_write(sbi, data_type);
 
 	blk_finish_plug(&plug);
+	release_gc_page_entry(&gc_page_list, false);
 
 	if (migrated)
 		stat_inc_gc_sec_count(sbi, data_type, gc_type);
@@ -2008,6 +2041,18 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 	return ret;
 }
 
+int __init f2fs_init_garbage_collection_summary_cache(void)
+{
+	gc_page_entry_slab = f2fs_kmem_cache_create("f2fs_gc_page_entry",
+					sizeof(struct gc_page_entry));
+	return gc_page_entry_slab ? 0 : -ENOMEM;
+}
+
+void f2fs_destroy_garbage_collection_summary_cache(void)
+{
+	kmem_cache_destroy(gc_page_entry_slab);
+}
+
 int __init f2fs_create_garbage_collection_cache(void)
 {
 	victim_entry_slab = f2fs_kmem_cache_create("f2fs_victim_entry",
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index 5c1eaf55e127..9c8695efe394 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -82,6 +82,12 @@ struct victim_entry {
 	struct list_head list;
 };
 
+struct gc_page_entry {
+	unsigned int segno;
+	struct page *sum_page;
+	struct list_head list;
+};
+
 /*
  * inline functions
  */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f087b2b71c89..a3241730fe4f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -5090,9 +5090,12 @@ static int __init init_f2fs_fs(void)
 	err = f2fs_create_garbage_collection_cache();
 	if (err)
 		goto free_extent_cache;
-	err = f2fs_init_sysfs();
+	err = f2fs_init_garbage_collection_summary_cache();
 	if (err)
 		goto free_garbage_collection_cache;
+	err = f2fs_init_sysfs();
+	if (err)
+		goto free_garbage_collection_summary_cache;
 	err = f2fs_init_shrinker();
 	if (err)
 		goto free_sysfs;
@@ -5141,6 +5144,8 @@ static int __init init_f2fs_fs(void)
 	f2fs_exit_shrinker();
 free_sysfs:
 	f2fs_exit_sysfs();
+free_garbage_collection_summary_cache:
+	f2fs_destroy_garbage_collection_summary_cache();
 free_garbage_collection_cache:
 	f2fs_destroy_garbage_collection_cache();
 free_extent_cache:
@@ -5172,6 +5177,7 @@ static void __exit exit_f2fs_fs(void)
 	f2fs_destroy_root_stats();
 	f2fs_exit_shrinker();
 	f2fs_exit_sysfs();
+	f2fs_destroy_garbage_collection_summary_cache();
 	f2fs_destroy_garbage_collection_cache();
 	f2fs_destroy_extent_cache();
 	f2fs_destroy_recovery_cache();
-- 
2.33.0



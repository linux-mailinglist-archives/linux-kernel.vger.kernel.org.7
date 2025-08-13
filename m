Return-Path: <linux-kernel+bounces-765878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C34B9B23F6F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 06:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E399B188EB61
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 04:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ADA2857CA;
	Wed, 13 Aug 2025 04:21:55 +0000 (UTC)
Received: from mta21.hihonor.com (mta21.hihonor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375D3155CB3
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 04:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755058915; cv=none; b=hGEVBqUsGLqKACqWcABuNsuRvBBtPxbE5YxRoXJ5uufmEa/AiY59HjSOTbtqYThVN2Mv1ug+vFC7heiFbuQLip7SvfxLuf40DRTjaZ9nwNr4gaUGucoKdXz8YCYomWUtdWzoGXR8AJMxgTpdWGNGMsT+d3eteAUnFdkMizO3mGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755058915; c=relaxed/simple;
	bh=y5M1qlNNbnj83LWlFycNGvBRQSIQuRp195Dd/RD9S2E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vDwuRqtG64XNQoCDRq0Nlthu+79VW+HC/41Q0BmoozWCqx3s0s7MuriVjXb8vEYKwdwaIIqUHJQM7YkzEfA3xCGBvnt1qqlsl3Gh/0vDcf/FvmPpzeUSba58KBncEkKGMpw1yZLGE21yvoZ00mrpE8KylMZRxsggGOWe6WOIOKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w012.hihonor.com (unknown [10.68.27.189])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4c1vsG14q2zYlKMn;
	Wed, 13 Aug 2025 12:04:50 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w012.hihonor.com
 (10.68.27.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 13 Aug
 2025 12:04:57 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 13 Aug
 2025 12:04:56 +0800
From: wangzijie <wangzijie1@honor.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	<bintian.wang@honor.com>, <feng.han@honor.com>, wangzijie
	<wangzijie1@honor.com>
Subject: [f2fs-dev] [PATCH] f2fs: reduce nat_tree_lock hold time when flush nat entries
Date: Wed, 13 Aug 2025 12:04:55 +0800
Message-ID: <20250813040455.3900073-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: w012.hihonor.com (10.68.27.189) To a011.hihonor.com
 (10.68.31.243)

Sometimes I suffered the nat_tree_lock contention between f2fs_write_checkpoint
and f2fs_get_node_info. Commit a9419b6("f2fs: do not bother checkpoint by
f2fs_get_node_info") also mentioned that situation.

My idea is, when flush nat entries, we can use some structures to record nat
pages we may read, and readahead them before hold nat_tree_lock. Before
impletement code, I did some survey and found a submittion in community.

Subject: f2fs: use bucket sort to avoid tree lookup and list sort when nat flushing
Link: https://lore.kernel.org/linux-f2fs-devel/20170520122435.17574-2-houpengyang@huawei.com/
This patch aims to improve nat entry set sort by using bucket.
I steal that structure and readahead nat pages contain nat entry set which cannot be moved
to journal according to dirty nat entry set bucket.

By doing this, I think there are two benefits to reducing nat_tree_lock hold time when
when flush nat entries.
1. avoid nat set tree lookup and sort
2. readahead nat pages before holding nat_tree_lock

Signed-off-by: wangzijie <wangzijie1@honor.com>
---
 fs/f2fs/f2fs.h |  1 +
 fs/f2fs/node.c | 70 ++++++++++++++++++++++++--------------------------
 fs/f2fs/node.h |  2 +-
 3 files changed, 35 insertions(+), 38 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 46be75605..b27cc059f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -975,6 +975,7 @@ struct f2fs_nm_info {
 	struct radix_tree_root nat_set_root;/* root of the nat set cache */
 	struct f2fs_rwsem nat_tree_lock;	/* protect nat entry tree */
 	struct list_head nat_entries;	/* cached nat entry list (clean) */
+	struct list_head nat_dirty_set[NAT_ENTRY_PER_BLOCK + 1];	/* store dirty nat set */
 	spinlock_t nat_list_lock;	/* protect clean nat entry list */
 	unsigned int nat_cnt[MAX_NAT_STATE]; /* the # of cached nat entries */
 	unsigned int nat_blocks;	/* # of nat blocks */
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 27743b93e..87c975ee8 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -244,6 +244,12 @@ static void __del_from_nat_cache(struct f2fs_nm_info *nm_i, struct nat_entry *e)
 	__free_nat_entry(e);
 }
 
+static void __relocate_nat_entry_set(struct f2fs_nm_info *nm_i,
+							struct nat_entry_set *set)
+{
+	list_move_tail(&set->set_list, &nm_i->nat_dirty_set[set->entry_cnt]);
+}
+
 static struct nat_entry_set *__grab_nat_entry_set(struct f2fs_nm_info *nm_i,
 							struct nat_entry *ne)
 {
@@ -260,6 +266,7 @@ static struct nat_entry_set *__grab_nat_entry_set(struct f2fs_nm_info *nm_i,
 		head->set = set;
 		head->entry_cnt = 0;
 		f2fs_radix_tree_insert(&nm_i->nat_set_root, set, head);
+		__relocate_nat_entry_set(nm_i, head);
 	}
 	return head;
 }
@@ -279,8 +286,10 @@ static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,
 	 * 2. update old block address to new one;
 	 */
 	if (!new_ne && (get_nat_flag(ne, IS_PREALLOC) ||
-				!get_nat_flag(ne, IS_DIRTY)))
+				!get_nat_flag(ne, IS_DIRTY))) {
 		head->entry_cnt++;
+		__relocate_nat_entry_set(nm_i, head);
+	}
 
 	set_nat_flag(ne, IS_PREALLOC, new_ne);
 
@@ -309,6 +318,7 @@ static void __clear_nat_cache_dirty(struct f2fs_nm_info *nm_i,
 
 	set_nat_flag(ne, IS_DIRTY, false);
 	set->entry_cnt--;
+	__relocate_nat_entry_set(nm_i, set);
 	nm_i->nat_cnt[DIRTY_NAT]--;
 	nm_i->nat_cnt[RECLAIMABLE_NAT]++;
 }
@@ -2976,24 +2986,6 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
 	up_write(&curseg->journal_rwsem);
 }
 
-static void __adjust_nat_entry_set(struct nat_entry_set *nes,
-						struct list_head *head, int max)
-{
-	struct nat_entry_set *cur;
-
-	if (nes->entry_cnt >= max)
-		goto add_out;
-
-	list_for_each_entry(cur, head, set_list) {
-		if (cur->entry_cnt >= nes->entry_cnt) {
-			list_add(&nes->set_list, cur->set_list.prev);
-			return;
-		}
-	}
-add_out:
-	list_add_tail(&nes->set_list, head);
-}
-
 static void __update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
 		const struct f2fs_nat_block *nat_blk)
 {
@@ -3095,6 +3087,7 @@ static int __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 
 	/* Allow dirty nats by node block allocation in write_begin */
 	if (!set->entry_cnt) {
+		list_del(&set->set_list);
 		radix_tree_delete(&NM_I(sbi)->nat_set_root, set->set);
 		kmem_cache_free(nat_entry_set_slab, set);
 	}
@@ -3109,11 +3102,8 @@ int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
 	struct f2fs_journal *journal = curseg->journal;
-	struct nat_entry_set *setvec[NAT_VEC_SIZE];
 	struct nat_entry_set *set, *tmp;
-	unsigned int found;
-	nid_t set_idx = 0;
-	LIST_HEAD(sets);
+	int i;
 	int err = 0;
 
 	/*
@@ -3129,6 +3119,16 @@ int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	if (!nm_i->nat_cnt[DIRTY_NAT])
 		return 0;
 
+	/* readahead sets which cannot be moved to journal */
+	if (!__has_cursum_space(journal, nm_i->nat_cnt[DIRTY_NAT], NAT_JOURNAL)) {
+		for (i = MAX_NAT_JENTRIES(journal); i <= NAT_ENTRY_PER_BLOCK; i++) {
+			list_for_each_entry_safe(set, tmp, &nm_i->nat_dirty_set[i], set_list) {
+				f2fs_ra_meta_pages(sbi, set->set, 1,
+								META_NAT, true);
+			}
+		}
+	}
+
 	f2fs_down_write(&nm_i->nat_tree_lock);
 
 	/*
@@ -3141,21 +3141,13 @@ int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 			nm_i->nat_cnt[DIRTY_NAT], NAT_JOURNAL))
 		remove_nats_in_journal(sbi);
 
-	while ((found = __gang_lookup_nat_set(nm_i,
-					set_idx, NAT_VEC_SIZE, setvec))) {
-		unsigned idx;
-
-		set_idx = setvec[found - 1]->set + 1;
-		for (idx = 0; idx < found; idx++)
-			__adjust_nat_entry_set(setvec[idx], &sets,
-						MAX_NAT_JENTRIES(journal));
-	}
-
 	/* flush dirty nats in nat entry set */
-	list_for_each_entry_safe(set, tmp, &sets, set_list) {
-		err = __flush_nat_entry_set(sbi, set, cpc);
-		if (err)
-			break;
+	for (i = 0; i <= NAT_ENTRY_PER_BLOCK; i++) {
+		list_for_each_entry_safe(set, tmp, &nm_i->nat_dirty_set[i], set_list) {
+			err = __flush_nat_entry_set(sbi, set, cpc);
+			if (err)
+				break;
+		}
 	}
 
 	f2fs_up_write(&nm_i->nat_tree_lock);
@@ -3249,6 +3241,7 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	unsigned char *version_bitmap;
 	unsigned int nat_segs;
+	int i;
 	int err;
 
 	nm_i->nat_blkaddr = le32_to_cpu(sb_raw->nat_blkaddr);
@@ -3275,6 +3268,9 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
 	INIT_LIST_HEAD(&nm_i->nat_entries);
 	spin_lock_init(&nm_i->nat_list_lock);
 
+	for (i = 0; i <= NAT_ENTRY_PER_BLOCK; i++)
+		INIT_LIST_HEAD(&nm_i->nat_dirty_set[i]);
+
 	mutex_init(&nm_i->build_lock);
 	spin_lock_init(&nm_i->nid_list_lock);
 	init_f2fs_rwsem(&nm_i->nat_tree_lock);
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 030390543..d805d4ce7 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -158,7 +158,7 @@ enum mem_type {
 };
 
 struct nat_entry_set {
-	struct list_head set_list;	/* link with other nat sets */
+	struct list_head set_list;	/* link with nat sets which have same entry_cnt */
 	struct list_head entry_list;	/* link with dirty nat entries */
 	nid_t set;			/* set number*/
 	unsigned int entry_cnt;		/* the # of nat entries in set */
-- 
2.25.1



Return-Path: <linux-kernel+bounces-747443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95870B133E0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53FF3175DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 05:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8785D214807;
	Mon, 28 Jul 2025 05:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="KBer5ip3"
Received: from mta22.hihonor.com (mta22.honor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63D81482E7
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 05:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753678969; cv=none; b=IAPw9GRQnJR922gb++XO/taOeYUNql+g6/qgWx586sHGVahcdbi2gzsbEMK0EYm7w7qC69lQ6f8Pw5//XY6m29xPm3UBWzcE3P+cT8nFW5QQhrVdG1HsOopPGbErUtxVg3tB7WvyCS8oLJKV2vQLgHzdij1wBcMVHiGoFfSIu7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753678969; c=relaxed/simple;
	bh=xdJuB93bOiE5zx7VLWWHdU3jA+aQrTXqxcu1Tgix2Yw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZEw76+DSjg8WDGaR7W7driKX0aw47JOeLohzQpLgGaAoe+BCR5BrLQ4JeZ6dL/wgPlkpJXHDbHsbSPxiIUV5CTspex8Ln1aEMtEhbJY416PoFB0E9ZOHy0XowXvpS+qw7CWC834oi8pFLjA5HUaubHbsJVmN+wCX0IRytd2QWTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=KBer5ip3; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=nDdINhIjAkJL+7QCcUa96oSDnkdBKol2udnKvnllCiM=;
	b=KBer5ip3GkmtSypJHJQC/3wr+GRAos/5n2Br5C9sNM4JGbl7BgXVQP6/CZGPPUt8/5n6kicir
	mEKKwr9+UAelfypbn29dFe9QB+IB3tQYEJ0xrevVwzt+4G8PvD9A7aNXzYzQxlbqTeNbpE1+qHj
	buvn26KMjO13hTIRdld33P8=
Received: from w003.hihonor.com (unknown [10.68.17.88])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4br5qX25VPzYl0VP;
	Mon, 28 Jul 2025 12:59:20 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w003.hihonor.com
 (10.68.17.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 28 Jul
 2025 13:02:38 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 28 Jul
 2025 13:02:38 +0800
From: wangzijie <wangzijie1@honor.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	<bintian.wang@honor.com>, <feng.han@honor.com>, wangzijie
	<wangzijie1@honor.com>
Subject: [f2fs-dev] [PATCH v3 2/2] f2fs: directly add newly allocated pre-dirty nat entry to dirty set list
Date: Mon, 28 Jul 2025 13:02:36 +0800
Message-ID: <20250728050237.1563560-2-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250728050237.1563560-1-wangzijie1@honor.com>
References: <20250728050237.1563560-1-wangzijie1@honor.com>
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

When we need to alloc nat entry and set it dirty, we can directly add it to
dirty set list(or initialize its list_head for new_ne) instead of adding it
to clean list and make a move. Introduce init_dirty flag to do it.

Signed-off-by: wangzijie <wangzijie1@honor.com>
---
v3:
- followed by Chao's suggestion to clean up code
---
 fs/f2fs/node.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 940b52d38..27743b93e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -185,7 +185,7 @@ static void __free_nat_entry(struct nat_entry *e)
 
 /* must be locked by nat_tree_lock */
 static struct nat_entry *__init_nat_entry(struct f2fs_nm_info *nm_i,
-	struct nat_entry *ne, struct f2fs_nat_entry *raw_ne, bool no_fail)
+	struct nat_entry *ne, struct f2fs_nat_entry *raw_ne, bool no_fail, bool init_dirty)
 {
 	if (no_fail)
 		f2fs_radix_tree_insert(&nm_i->nat_root, nat_get_nid(ne), ne);
@@ -195,6 +195,12 @@ static struct nat_entry *__init_nat_entry(struct f2fs_nm_info *nm_i,
 	if (raw_ne)
 		node_info_from_raw_nat(&ne->ni, raw_ne);
 
+	if (init_dirty) {
+		INIT_LIST_HEAD(&ne->list);
+		nm_i->nat_cnt[TOTAL_NAT]++;
+		return ne;
+	}
+
 	spin_lock(&nm_i->nat_list_lock);
 	list_add_tail(&ne->list, &nm_i->nat_entries);
 	spin_unlock(&nm_i->nat_list_lock);
@@ -259,7 +265,7 @@ static struct nat_entry_set *__grab_nat_entry_set(struct f2fs_nm_info *nm_i,
 }
 
 static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,
-						struct nat_entry *ne)
+		struct nat_entry *ne, bool init_dirty)
 {
 	struct nat_entry_set *head;
 	bool new_ne = nat_get_blkaddr(ne) == NEW_ADDR;
@@ -282,7 +288,8 @@ static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,
 		goto refresh_list;
 
 	nm_i->nat_cnt[DIRTY_NAT]++;
-	nm_i->nat_cnt[RECLAIMABLE_NAT]--;
+	if (!init_dirty)
+		nm_i->nat_cnt[RECLAIMABLE_NAT]--;
 	set_nat_flag(ne, IS_DIRTY, true);
 refresh_list:
 	spin_lock(&nm_i->nat_list_lock);
@@ -444,7 +451,7 @@ static void cache_nat_entry(struct f2fs_sb_info *sbi, nid_t nid,
 	f2fs_down_write(&nm_i->nat_tree_lock);
 	e = __lookup_nat_cache(nm_i, nid, false);
 	if (!e)
-		e = __init_nat_entry(nm_i, new, ne, false);
+		e = __init_nat_entry(nm_i, new, ne, false, false);
 	else
 		f2fs_bug_on(sbi, nat_get_ino(e) != le32_to_cpu(ne->ino) ||
 				nat_get_blkaddr(e) !=
@@ -461,11 +468,13 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct nat_entry *e;
 	struct nat_entry *new = __alloc_nat_entry(sbi, ni->nid, true);
+	bool init_dirty = false;
 
 	f2fs_down_write(&nm_i->nat_tree_lock);
 	e = __lookup_nat_cache(nm_i, ni->nid, true);
 	if (!e) {
-		e = __init_nat_entry(nm_i, new, NULL, true);
+		init_dirty = true;
+		e = __init_nat_entry(nm_i, new, NULL, true, true);
 		copy_node_info(&e->ni, ni);
 		f2fs_bug_on(sbi, ni->blk_addr == NEW_ADDR);
 	} else if (new_blkaddr == NEW_ADDR) {
@@ -501,7 +510,7 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
 	nat_set_blkaddr(e, new_blkaddr);
 	if (!__is_valid_data_blkaddr(new_blkaddr))
 		set_nat_flag(e, IS_CHECKPOINTED, false);
-	__set_nat_cache_dirty(nm_i, e);
+	__set_nat_cache_dirty(nm_i, e, init_dirty);
 
 	/* update fsync_mark if its inode nat entry is still alive */
 	if (ni->nid != ni->ino)
@@ -2927,6 +2936,7 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
 	struct f2fs_journal *journal = curseg->journal;
 	int i;
+	bool init_dirty;
 
 	down_write(&curseg->journal_rwsem);
 	for (i = 0; i < nats_in_cursum(journal); i++) {
@@ -2937,12 +2947,15 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
 		if (f2fs_check_nid_range(sbi, nid))
 			continue;
 
+		init_dirty = false;
+
 		raw_ne = nat_in_journal(journal, i);
 
 		ne = __lookup_nat_cache(nm_i, nid, true);
 		if (!ne) {
+			init_dirty = true;
 			ne = __alloc_nat_entry(sbi, nid, true);
-			__init_nat_entry(nm_i, ne, &raw_ne, true);
+			__init_nat_entry(nm_i, ne, &raw_ne, true, true);
 		}
 
 		/*
@@ -2957,7 +2970,7 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
 			spin_unlock(&nm_i->nid_list_lock);
 		}
 
-		__set_nat_cache_dirty(nm_i, ne);
+		__set_nat_cache_dirty(nm_i, ne, init_dirty);
 	}
 	update_nats_in_cursum(journal, -i);
 	up_write(&curseg->journal_rwsem);
-- 
2.25.1



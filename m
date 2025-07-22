Return-Path: <linux-kernel+bounces-741025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0986B0DF22
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8740AC6A8F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622602EAB73;
	Tue, 22 Jul 2025 14:36:45 +0000 (UTC)
Received: from mta21.hihonor.com (mta21.hihonor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064382EAB6B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195004; cv=none; b=p0OP9DrFDN47r/UkJ7ojCqyeR3ejBuTocP6DFdmilyFGp9vNJaLpACDbIVFTk3cEApSJMATJtop8lBPVqx61cwZ2VN6m6hq3ioHw8z4z1UeHx/uRiTmbJvPK4sUejyyhcuOXp4QZcVPjvDANMjxZof9JZyjS/AvEEywGynFwyl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195004; c=relaxed/simple;
	bh=AhHy+holbRSbZdxLeHNnqmsPtgdPJycHAsQ0l8KCYM8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hngvHQ6i3uNMgdeiSF8yS+aTgE+FWmMV4au+9l5Vs5jKx/zyuVX7sx65oflOw5TDD2BkqUAq1dbNIySgBDPArwqA5H4oK/Lc4dwn2o4l+xCFPDQlST3yasrNULlcoC3R+wX0MHCr7lAF+ANYJWooxrKPEoMF3gG/8tnkL2AzRek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4bmfsH1P2GzYlDjP;
	Tue, 22 Jul 2025 22:33:55 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 22 Jul
 2025 22:36:31 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 22 Jul
 2025 22:36:31 +0800
From: wangzijie <wangzijie1@honor.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	<bintian.wang@honor.com>, <feng.han@honor.com>, wangzijie
	<wangzijie1@honor.com>
Subject: [f2fs-dev] [PATCH v2 2/2] f2fs: directly add newly allocated pre-dirty nat entry to dirty set list
Date: Tue, 22 Jul 2025 22:36:28 +0800
Message-ID: <20250722143628.430776-2-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250722143628.430776-1-wangzijie1@honor.com>
References: <20250722143628.430776-1-wangzijie1@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: w001.hihonor.com (10.68.25.235) To a011.hihonor.com
 (10.68.31.243)

When we need to alloc nat entry and set it dirty, we can directly add it to
dirty set list(or initialize its list_head for new_ne) instead of adding it
to clean list and make a move. Introduce init_dirty flag to do it.

Signed-off-by: wangzijie <wangzijie1@honor.com>
---
 fs/f2fs/node.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index a23db6238..20bcf8559 100644
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
@@ -195,6 +195,11 @@ static struct nat_entry *__init_nat_entry(struct f2fs_nm_info *nm_i,
 	if (raw_ne)
 		node_info_from_raw_nat(&ne->ni, raw_ne);
 
+	if (init_dirty) {
+		nm_i->nat_cnt[TOTAL_NAT]++;
+		return ne;
+	}
+
 	spin_lock(&nm_i->nat_list_lock);
 	list_add_tail(&ne->list, &nm_i->nat_entries);
 	spin_unlock(&nm_i->nat_list_lock);
@@ -256,7 +261,7 @@ static struct nat_entry_set *__grab_nat_entry_set(struct f2fs_nm_info *nm_i,
 }
 
 static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,
-						struct nat_entry *ne)
+					struct nat_entry *ne, bool init_dirty)
 {
 	struct nat_entry_set *head;
 	bool new_ne = nat_get_blkaddr(ne) == NEW_ADDR;
@@ -275,6 +280,18 @@ static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,
 
 	set_nat_flag(ne, IS_PREALLOC, new_ne);
 
+	if (init_dirty) {
+		nm_i->nat_cnt[DIRTY_NAT]++;
+		set_nat_flag(ne, IS_DIRTY, true);
+		spin_lock(&nm_i->nat_list_lock);
+		if (new_ne)
+			INIT_LIST_HEAD(&ne->list);
+		else
+			list_add_tail(&ne->list, &head->entry_list);
+		spin_unlock(&nm_i->nat_list_lock);
+		return;
+    }
+
 	if (get_nat_flag(ne, IS_DIRTY))
 		goto refresh_list;
 
@@ -441,7 +458,7 @@ static void cache_nat_entry(struct f2fs_sb_info *sbi, nid_t nid,
 	f2fs_down_write(&nm_i->nat_tree_lock);
 	e = __lookup_nat_cache(nm_i, nid, false);
 	if (!e)
-		e = __init_nat_entry(nm_i, new, ne, false);
+		e = __init_nat_entry(nm_i, new, ne, false, false);
 	else
 		f2fs_bug_on(sbi, nat_get_ino(e) != le32_to_cpu(ne->ino) ||
 				nat_get_blkaddr(e) !=
@@ -458,11 +475,13 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
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
@@ -498,7 +517,7 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
 	nat_set_blkaddr(e, new_blkaddr);
 	if (!__is_valid_data_blkaddr(new_blkaddr))
 		set_nat_flag(e, IS_CHECKPOINTED, false);
-	__set_nat_cache_dirty(nm_i, e);
+	__set_nat_cache_dirty(nm_i, e, init_dirty);
 
 	/* update fsync_mark if its inode nat entry is still alive */
 	if (ni->nid != ni->ino)
@@ -2924,6 +2943,7 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
 	struct f2fs_journal *journal = curseg->journal;
 	int i;
+	bool init_dirty;
 
 	down_write(&curseg->journal_rwsem);
 	for (i = 0; i < nats_in_cursum(journal); i++) {
@@ -2934,12 +2954,15 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
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
@@ -2954,7 +2977,7 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
 			spin_unlock(&nm_i->nid_list_lock);
 		}
 
-		__set_nat_cache_dirty(nm_i, ne);
+		__set_nat_cache_dirty(nm_i, ne, init_dirty);
 	}
 	update_nats_in_cursum(journal, -i);
 	up_write(&curseg->journal_rwsem);
-- 
2.25.1



Return-Path: <linux-kernel+bounces-747462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA739B1341C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF5187A346E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 05:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58B021A436;
	Mon, 28 Jul 2025 05:22:46 +0000 (UTC)
Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60C52E3708
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 05:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753680166; cv=none; b=qAN+ZaJPM3pLDhUZ8JZv8JEtoLuKCbXYFiP7MhQzAmcuWd9fcbxsmFZg9f4sTRRNSAdOZC3in2q1zuCifQCaMRcaZVZcryjaAR8dNhR9luO3BkjK9Jaoeh3V79N8ny9PLxDpAPvxTR93Md9NkdQVc/O0EfXznJPaY/W+FNU9wYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753680166; c=relaxed/simple;
	bh=e5j4iuQohy5wg7UlX4pjB0wO7gRMfWDH/M3ln/a1Rkk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r9SpHmO2+rBgJM0cTlvxZNr4QNXdunf4Y9/0nUdWVzGDAVKHOfsxnUSVkzNYMItRsjpHMSiTHkImU1FeQcnVlAkW64YSP24vuzunOZb9YcLn81kCpmWQcjD2DagY+pUhwNtqdUJceaAZPBTsERykmiGCkf2mD+aEF9ODqguS55M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w013.hihonor.com (unknown [10.68.26.19])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4br5qz0j8TzYl6X4;
	Mon, 28 Jul 2025 12:59:43 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w013.hihonor.com
 (10.68.26.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 28 Jul
 2025 13:02:38 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 28 Jul
 2025 13:02:37 +0800
From: wangzijie <wangzijie1@honor.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	<bintian.wang@honor.com>, <feng.han@honor.com>, wangzijie
	<wangzijie1@honor.com>
Subject: [f2fs-dev] [PATCH v3 1/2] f2fs: avoid redundant clean nat entry move in lru list
Date: Mon, 28 Jul 2025 13:02:35 +0800
Message-ID: <20250728050237.1563560-1-wangzijie1@honor.com>
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

__lookup_nat_cache follows LRU manner to move clean nat entry, when nat
entries are going to be dirty, no need to move them to tail of lru list.
Introduce a parameter 'for_dirty' to avoid it.

Signed-off-by: wangzijie <wangzijie1@honor.com>
---
v3:
- followed by Chao's suggestion to update comments
v2:
- followed by Jaegeuk's suggestion to add a parameter in __lookup_nat_cache
---
 fs/f2fs/node.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 76aba1961..940b52d38 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -204,14 +204,17 @@ static struct nat_entry *__init_nat_entry(struct f2fs_nm_info *nm_i,
 	return ne;
 }
 
-static struct nat_entry *__lookup_nat_cache(struct f2fs_nm_info *nm_i, nid_t n)
+static struct nat_entry *__lookup_nat_cache(struct f2fs_nm_info *nm_i, nid_t n, bool for_dirty)
 {
 	struct nat_entry *ne;
 
 	ne = radix_tree_lookup(&nm_i->nat_root, n);
 
-	/* for recent accessed nat entry, move it to tail of lru list */
-	if (ne && !get_nat_flag(ne, IS_DIRTY)) {
+	/*
+	 * for recent accessed nat entry which will not be dirtied soon
+	 * later, move it to tail of lru list.
+	 */
+	if (ne && !get_nat_flag(ne, IS_DIRTY) && !for_dirty) {
 		spin_lock(&nm_i->nat_list_lock);
 		if (!list_empty(&ne->list))
 			list_move_tail(&ne->list, &nm_i->nat_entries);
@@ -383,7 +386,7 @@ int f2fs_need_dentry_mark(struct f2fs_sb_info *sbi, nid_t nid)
 	bool need = false;
 
 	f2fs_down_read(&nm_i->nat_tree_lock);
-	e = __lookup_nat_cache(nm_i, nid);
+	e = __lookup_nat_cache(nm_i, nid, false);
 	if (e) {
 		if (!get_nat_flag(e, IS_CHECKPOINTED) &&
 				!get_nat_flag(e, HAS_FSYNCED_INODE))
@@ -400,7 +403,7 @@ bool f2fs_is_checkpointed_node(struct f2fs_sb_info *sbi, nid_t nid)
 	bool is_cp = true;
 
 	f2fs_down_read(&nm_i->nat_tree_lock);
-	e = __lookup_nat_cache(nm_i, nid);
+	e = __lookup_nat_cache(nm_i, nid, false);
 	if (e && !get_nat_flag(e, IS_CHECKPOINTED))
 		is_cp = false;
 	f2fs_up_read(&nm_i->nat_tree_lock);
@@ -414,7 +417,7 @@ bool f2fs_need_inode_block_update(struct f2fs_sb_info *sbi, nid_t ino)
 	bool need_update = true;
 
 	f2fs_down_read(&nm_i->nat_tree_lock);
-	e = __lookup_nat_cache(nm_i, ino);
+	e = __lookup_nat_cache(nm_i, ino, false);
 	if (e && get_nat_flag(e, HAS_LAST_FSYNC) &&
 			(get_nat_flag(e, IS_CHECKPOINTED) ||
 			 get_nat_flag(e, HAS_FSYNCED_INODE)))
@@ -439,7 +442,7 @@ static void cache_nat_entry(struct f2fs_sb_info *sbi, nid_t nid,
 		return;
 
 	f2fs_down_write(&nm_i->nat_tree_lock);
-	e = __lookup_nat_cache(nm_i, nid);
+	e = __lookup_nat_cache(nm_i, nid, false);
 	if (!e)
 		e = __init_nat_entry(nm_i, new, ne, false);
 	else
@@ -460,7 +463,7 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
 	struct nat_entry *new = __alloc_nat_entry(sbi, ni->nid, true);
 
 	f2fs_down_write(&nm_i->nat_tree_lock);
-	e = __lookup_nat_cache(nm_i, ni->nid);
+	e = __lookup_nat_cache(nm_i, ni->nid, true);
 	if (!e) {
 		e = __init_nat_entry(nm_i, new, NULL, true);
 		copy_node_info(&e->ni, ni);
@@ -502,7 +505,7 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
 
 	/* update fsync_mark if its inode nat entry is still alive */
 	if (ni->nid != ni->ino)
-		e = __lookup_nat_cache(nm_i, ni->ino);
+		e = __lookup_nat_cache(nm_i, ni->ino, false);
 	if (e) {
 		if (fsync_done && ni->nid == ni->ino)
 			set_nat_flag(e, HAS_FSYNCED_INODE, true);
@@ -562,7 +565,7 @@ int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
 retry:
 	/* Check nat cache */
 	f2fs_down_read(&nm_i->nat_tree_lock);
-	e = __lookup_nat_cache(nm_i, nid);
+	e = __lookup_nat_cache(nm_i, nid, false);
 	if (e) {
 		ni->ino = nat_get_ino(e);
 		ni->blk_addr = nat_get_blkaddr(e);
@@ -2371,7 +2374,7 @@ static bool add_free_nid(struct f2fs_sb_info *sbi,
 		 *   - __remove_nid_from_list(PREALLOC_NID)
 		 *                         - __insert_nid_to_list(FREE_NID)
 		 */
-		ne = __lookup_nat_cache(nm_i, nid);
+		ne = __lookup_nat_cache(nm_i, nid, false);
 		if (ne && (!get_nat_flag(ne, IS_CHECKPOINTED) ||
 				nat_get_blkaddr(ne) != NULL_ADDR))
 			goto err_out;
@@ -2936,7 +2939,7 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
 
 		raw_ne = nat_in_journal(journal, i);
 
-		ne = __lookup_nat_cache(nm_i, nid);
+		ne = __lookup_nat_cache(nm_i, nid, true);
 		if (!ne) {
 			ne = __alloc_nat_entry(sbi, nid, true);
 			__init_nat_entry(nm_i, ne, &raw_ne, true);
-- 
2.25.1



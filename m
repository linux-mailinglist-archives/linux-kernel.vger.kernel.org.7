Return-Path: <linux-kernel+bounces-892848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B00AC45F01
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2EE3B6DEF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD49A30748C;
	Mon, 10 Nov 2025 10:29:20 +0000 (UTC)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6027030217E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762770560; cv=none; b=lpOw7tc4+faJU7OniyeYwfzJggbjo0znyKBx1R13pEw+lKUoNBKnud4r7J6gxjrok3+vFIXuAbfV+e8bVYO3PJTCWGTxD71beFxMr1au8zc9BqQLWPE7nQnfbb71Jg+kjnzSxs0+DIeUFrP4t58jeKtpD+cqMeSQGK2dsftRwkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762770560; c=relaxed/simple;
	bh=y44t1JLP/XXRyHvAbXy4b3d9pNO4A/0WTPlAhegwJ78=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nKbQTyf77g2CbExse8DqtC0AAg5MC4WERNkZCu8kYXe76iEO+DFertv9cLCJjYskmSuX6mgFdB6u6vgpF5SS1Micq7ow03NTwwTY/P0hW6ozo36ynBwyFJ2VxAZBDLBZkm0elBOiKu2vh+E+ItPVxVx6/w0NYqFjk7n3lqMBs/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d4m7r4rLWznTV9;
	Mon, 10 Nov 2025 18:27:36 +0800 (CST)
Received: from kwepemf100009.china.huawei.com (unknown [7.202.181.223])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E1C41A016C;
	Mon, 10 Nov 2025 18:29:09 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemf100009.china.huawei.com (7.202.181.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Nov 2025 18:29:08 +0800
From: Tian Tao <tiantao6@hisilicon.com>
To: <brauner@kernel.org>, <jack@suse.cz>, <cyphar@cyphar.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] userns: use acquire/release semantics for idmap nr_extents
Date: Mon, 10 Nov 2025 18:29:08 +0800
Message-ID: <20251110102908.3634466-1-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100009.china.huawei.com (7.202.181.223)

Replace plain loads followed by smp_rmb() with smp_load_acquire() when
reading uid/gid/projid map->nr_extents, and replace the writer side
sequence of smp_wmb(); map->nr_extents = val with an explicit
smp_store_release(&map->nr_extents, val) when installing a new idmap.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 kernel/user_namespace.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 03cb63883d04..213f7814dc45 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -318,8 +318,11 @@ map_id_range_down_base(unsigned extents, struct uid_gid_map *map, u32 id, u32 co
 static u32 map_id_range_down(struct uid_gid_map *map, u32 id, u32 count)
 {
 	struct uid_gid_extent *extent;
-	unsigned extents = map->nr_extents;
-	smp_rmb();
+/* Acquire semantics: pair with the writer's smp_store_release()
+ * when publishing a new map->nr_extents so that readers see the
+ * extent array contents that were written before nr_extents.
+ */
+	unsigned int extents = smp_load_acquire(&map->nr_extents);
 
 	if (extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
 		extent = map_id_range_down_base(extents, map, id, count);
@@ -384,8 +387,11 @@ map_id_range_up_max(unsigned extents, struct uid_gid_map *map, u32 id, u32 count
 u32 map_id_range_up(struct uid_gid_map *map, u32 id, u32 count)
 {
 	struct uid_gid_extent *extent;
-	unsigned extents = map->nr_extents;
-	smp_rmb();
+/* Acquire semantics: pair with the writer's smp_store_release()
+ * when publishing a new map->nr_extents so that readers see the
+ * extent array contents that were written before nr_extents.
+ */
+	unsigned int extents = smp_load_acquire(&map->nr_extents);
 
 	if (extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
 		extent = map_id_range_up_base(extents, map, id, count);
@@ -677,8 +683,11 @@ static void *m_start(struct seq_file *seq, loff_t *ppos,
 		     struct uid_gid_map *map)
 {
 	loff_t pos = *ppos;
-	unsigned extents = map->nr_extents;
-	smp_rmb();
+/* Acquire semantics: pair with the writer's smp_store_release()
+ * when publishing a new map->nr_extents so that readers see the
+ * extent array contents that were written before nr_extents.
+ */
+	unsigned int extents = smp_load_acquire(&map->nr_extents);
 
 	if (pos >= extents)
 		return NULL;
@@ -1099,8 +1108,12 @@ static ssize_t map_write(struct file *file, const char __user *buf,
 		map->forward = new_map.forward;
 		map->reverse = new_map.reverse;
 	}
-	smp_wmb();
-	map->nr_extents = new_map.nr_extents;
+	/* Release semantics: publish the extent arrays (map->forward/map->reverse
+	 * or map->extent) and then update map->nr_extents. Readers use
+	 * smp_load_acquire(&map->nr_extents) so they will see the array contents
+	 * written before this store.
+	 */
+	smp_store_release(&map->nr_extents, new_map.nr_extents);
 
 	*ppos = count;
 	ret = count;
-- 
2.33.0



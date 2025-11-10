Return-Path: <linux-kernel+bounces-893107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 562E1C46904
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050F84223E7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008C130EF6A;
	Mon, 10 Nov 2025 12:13:15 +0000 (UTC)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6B83081D7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776794; cv=none; b=cwe8RAVx1yvZju0WYEOlSDUNAXqmOVTyF5YUD1e4quH/tlizb00uYore+dRbKVLPo1xiz+SI153qMJUvOYcuud7/af0JdbxJvHYi1a9rhfFFABDIeNopN2QrnHr1pEZEDN1R7FybZc3isUQI0cM4kw9OHukn08vCMFTe8ovO0Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776794; c=relaxed/simple;
	bh=y44t1JLP/XXRyHvAbXy4b3d9pNO4A/0WTPlAhegwJ78=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VAisLWkq/xLbP2+HaIkLXQv8HO0hHDio6a34/wLv1Y5NeXDXJaiGDX+vMfOCQWR+Dq8oWnoxri61I/tuALa3t1/no6ZiY7/f8FSF10h8Pw/edJw4vcZfTEB+Ndou/LzrtT8Z959jqWcJwvC4t4gUMkOY6WsJM+cI1Eek33uSXhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4d4pS33fr0z1T4Fv;
	Mon, 10 Nov 2025 20:11:47 +0800 (CST)
Received: from kwepemf100009.china.huawei.com (unknown [7.202.181.223])
	by mail.maildlp.com (Postfix) with ESMTPS id 303361402C7;
	Mon, 10 Nov 2025 20:13:08 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemf100009.china.huawei.com (7.202.181.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Nov 2025 20:13:07 +0800
From: Tian Tao <tiantao6@hisilicon.com>
To: <brauner@kernel.org>, <jack@suse.cz>, <cyphar@cyphar.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] userns: use acquire/release semantics for idmap nr_extents
Date: Mon, 10 Nov 2025 20:13:07 +0800
Message-ID: <20251110121307.3716263-1-tiantao6@hisilicon.com>
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



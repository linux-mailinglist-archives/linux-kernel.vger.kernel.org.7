Return-Path: <linux-kernel+bounces-819890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5739B7C80F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E23F1B24060
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 02:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08E6221F0A;
	Wed, 17 Sep 2025 02:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="IUaW5o+7"
Received: from mta22.hihonor.com (mta22.hihonor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04443101F2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758076590; cv=none; b=bKNDwqXoc+NnLpketWOf+q7Rckuc4NTDLXXUhGzGYYDK7QAfnfJa8Z3xuaJEoiRDZENJbF47qrpMHAd7S4FApA5qY7xiq1+mgZVYfqHGwqbjKAdhGxhvvTWLFFHCWfJQqkJ4UNi+TRJdW1e5a8E70Aie74a8DSTgDdVyDI1WT1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758076590; c=relaxed/simple;
	bh=OMrF60UrFESswdQqNKZ+KlKOqtgQLchhCNczyKVJCZA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=djHbDLKD9cx1ImEFINi8cwscw9vHyZ0MMp3qcNA16cSMPIRRDD/HHhApz4+JvXRT008YFqXE75h0rhUIs2syIWVAhpmTrNuhqvjXvD4awDAF+aPGANIVa0Swh+DoyG6Fma+FJegPiyd+rlumltttqMMighOJLnQ3BTx261/VVgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=IUaW5o+7; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=V8jRf/XdzOZu8DRuETfgfqD98J9cKAQM69d4lnejfFs=;
	b=IUaW5o+7/875Ti9Fg/iLLZ6Ikhs2FXhAk4m6zwtOWvE8QtULP2OWF9hpyS9Gl2xodHOqz03A4
	gVYwu1BgChHy9G3U343ajZbOlwVRL/GuODDSdDxCK0eaazHe6BtMi6O95yS2Ot+HeIQ5RMGGJ1m
	VDmUoWERgF51PRJAOoauq0E=
Received: from w003.hihonor.com (unknown [10.68.17.88])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4cRNDh5vbhzYl1N1;
	Wed, 17 Sep 2025 10:36:04 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w003.hihonor.com
 (10.68.17.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 17 Sep
 2025 10:36:24 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 17 Sep
 2025 10:36:24 +0800
From: wangzijie <wangzijie1@honor.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	<bintian.wang@honor.com>, <feng.han@honor.com>, wangzijie
	<wangzijie1@honor.com>
Subject: [f2fs-dev] [PATCH v3 1/2] f2fs: fix zero-sized extent for precache extents
Date: Wed, 17 Sep 2025 10:36:21 +0800
Message-ID: <20250917023622.516052-1-wangzijie1@honor.com>
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

Script to reproduce:
f2fs_io write 1 0 1881 rand dsync testfile
f2fs_io fallocate 0 7708672 4096 testfile
f2fs_io write 1 1881 1 rand buffered testfile
fsync testfile
umount
mount
f2fs_io precache_extents testfile

When the data layout is something like this:
dnode1:                     dnode2:
[0]      A                  [0]    NEW_ADDR
[1]      A+1                [1]    0x0
...
[1016]   A+1016
[1017]   B (B!=A+1017)      [1017] 0x0

During precache_extents, we map the last block(valid blkaddr) in dnode1:
map->m_flags |= F2FS_MAP_MAPPED;
map->m_pblk = blkaddr(valid blkaddr);
map->m_len = 1;
then we goto next_dnode, meet the first block in dnode2(hole), goto sync_out:
map->m_flags & F2FS_MAP_MAPPED == true, and we make zero-sized extent:

map->m_len = 1
ofs = start_pgofs - map->m_lblk = 1882 - 1881 = 1
ei.fofs = start_pgofs = 1882
ei.len = map->m_len - ofs = 1 - 1 = 0


Rebased on patch[1], this patch can cover these cases to avoid zero-sized extent:
A,B,C is valid blkaddr
case1:
dnode1:                     dnode2:
[0]      A                  [0]    NEW_ADDR
[1]      A+1                [1]    0x0
...                         ....
[1016]   A+1016
[1017]   B (B!=A+1017)      [1017] 0x0

case2:
dnode1:                     dnode2:
[0]      A                  [0]    C (C!=B+1)
[1]      A+1                [1]    C+1
...                         ....
[1016]   A+1016
[1017]   B (B!=A+1017)      [1017] 0x0

case3:
dnode1:                     dnode2:
[0]      A                  [0]    C (C!=B+2)
[1]      A+1                [1]    C+1
...                         ....
[1015]   A+1015
[1016]   B (B!=A+1016)
[1017]   B+1                [1017] 0x0

[1] https://lore.kernel.org/linux-f2fs-devel/20250912081250.44383-1-chao@kernel.org/

Fixes: c4020b2da4c9 ("f2fs: support F2FS_IOC_PRECACHE_EXTENTS")
Signed-off-by: wangzijie <wangzijie1@honor.com>
---
Rebased on:
https://lore.kernel.org/linux-f2fs-devel/20250912081250.44383-1-chao@kernel.org/
v2:
https://lore.kernel.org/linux-f2fs-devel/20250915035246.98055-1-wangzijie1@honor.com/
---
 fs/f2fs/data.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 838eae39d..7a5170b32 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1778,9 +1778,10 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 		if (map->m_flags & F2FS_MAP_MAPPED) {
 			unsigned int ofs = start_pgofs - map->m_lblk;
 
-			f2fs_update_read_extent_cache_range(&dn,
-				start_pgofs, map->m_pblk + ofs,
-				map->m_len - ofs);
+			if (map->m_len - ofs > 0)
+				f2fs_update_read_extent_cache_range(&dn,
+					start_pgofs, map->m_pblk + ofs,
+					map->m_len - ofs);
 		}
 		if (map->m_next_extent)
 			*map->m_next_extent = is_hole ? pgofs + 1 : pgofs;
-- 
2.25.1



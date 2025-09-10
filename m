Return-Path: <linux-kernel+bounces-810305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9494DB51885
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE7873B88FA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2293B320CBC;
	Wed, 10 Sep 2025 13:58:48 +0000 (UTC)
Received: from mta20.hihonor.com (mta20.hihonor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A49289358
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757512727; cv=none; b=JCC/8cQLQjNreCx4ndacgO/1DaShy/t6M346/NVzy6a1SVIQKVDoWz/krrRaUxK4eW6arwomTBnX8Y/qy4dqFtUMClvHtr6qg9+nfbwafAhoHQjedgkByL/UU7LzAAIqZe070Y/LsnocG9LeRsSgftI2fLZQz+8FAo5M71Xzbx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757512727; c=relaxed/simple;
	bh=DpvF38gUJ5DtN5E7SdXMNP56dtPSa5qmoO+Jz/crDRo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iHIvmrG8OnOA1t/dzSJQnaHtGJdedl5nAHri8w17WW6k4Kjcw5pztt6WdQCGWWsvHwbKpZOO+XqOuB9Qw/WJvxxv64s23kLxRPPkDkloR+MEZP0xayBFJDmAqB3AxWQxITDYU8RnBsAxbBQFKT2VOI6fg9/Xw1JkyVC9Isu03FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w013.hihonor.com (unknown [10.68.26.19])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4cMMhy5mjNzYkxhK;
	Wed, 10 Sep 2025 21:58:10 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w013.hihonor.com
 (10.68.26.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 10 Sep
 2025 21:58:37 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 10 Sep
 2025 21:58:36 +0800
From: wangzijie <wangzijie1@honor.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <bintian.wang@honor.com>, <feng.han@honor.com>,
	<linux-kernel@vger.kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>,
	wangzijie <wangzijie1@honor.com>
Subject: [f2fs-dev] [PATCH 1/2] f2fs: fix wrong extent_info data for precache extents
Date: Wed, 10 Sep 2025 21:58:34 +0800
Message-ID: <20250910135835.2751574-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
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

When the data layout is like this:
dnode1:                     dnode2:
[0]      A                  [0]    NEW_ADDR
[1]      A+1                [1]    0x0
...                         ....
[1016]   A+1016
[1017]   B (B!=A+1017)      [1017] 0x0

We can build this kind of layout by following steps(with i_extra_isize:36):
./f2fs_io write 1 0 1881 rand dsync testfile
./f2fs_io write 1 1881 1 rand buffered testfile
./f2fs_io fallocate 0 7708672 4096 testfile

And when we map first data block in dnode2, we will get wrong extent_info data:
map->m_len = 1
ofs = start_pgofs - map->m_lblk = 1882 - 1881 = 1

ei.fofs = start_pgofs = 1882
ei.len = map->m_len - ofs = 1 - 1 = 0

Fix it by skipping updating this kind of extent info.

Signed-off-by: wangzijie <wangzijie1@honor.com>
---
 fs/f2fs/data.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7961e0ddf..b8bb71852 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1649,6 +1649,9 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 
 		switch (flag) {
 		case F2FS_GET_BLOCK_PRECACHE:
+			if (__is_valid_data_blkaddr(map->m_pblk) &&
+				start_pgofs - map->m_lblk == map->m_len)
+				map->m_flags &= ~F2FS_MAP_MAPPED;
 			goto sync_out;
 		case F2FS_GET_BLOCK_BMAP:
 			map->m_pblk = 0;
-- 
2.25.1



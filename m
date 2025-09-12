Return-Path: <linux-kernel+bounces-813600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F28BB5480F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DFE71CC4F19
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3122765EA;
	Fri, 12 Sep 2025 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3GZr48l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FBC274B23
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757669931; cv=none; b=g4pJt+5SOsQaHlMY12z6KF+LIz5Ron1f5DFcyl52GGQ19Fpt0c84JPfuPNZSusI79bzHt98uwSTkKMx/9lt8M3ODkyAIjr82ssZ9CkbsCrJ3hpzA639So1kob92vVBZv45R2/vWcprx+cEVT4Eh/tdNk8p7pjuOst2bn8YIcU+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757669931; c=relaxed/simple;
	bh=C2C7RcRgI+D6tUKplepFjuIGNKR+l3pPP2sgq1FegGs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bNEDmDUn+vECLsX41Fse3WAMuVCtPVgS9Gf5Z0zeDRrGhVsSNGISN6AOFdl8klVEBtr1B5hH71Z68Zz7gI2xHuaaFH87Imto4pSUN1ptALe70ZcDxfBpDHrQOvdiOW53LmD5Gx8fqumsVzxl6ku3Mu9azVgOtbcCrQ1c/5POH+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3GZr48l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87B1C4CEF1;
	Fri, 12 Sep 2025 09:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757669930;
	bh=C2C7RcRgI+D6tUKplepFjuIGNKR+l3pPP2sgq1FegGs=;
	h=From:To:Cc:Subject:Date:From;
	b=L3GZr48lQ48DqpOQds2/ux8pi30yfFwp6lMWAKNU33jL0GOujdt4zW+qs1tu2yB2O
	 TJDufuG8i1SDQPae5lPD7tvKrIWBbn20JyZxcyNkBj+4hfbr4Rr0Dsq1AjYj6rTvg3
	 b5AF6aupMKeZe7jvhdz2qZSubqtORlb18uC893UeIAtg7mKYi039/ywcbHCsBiwBBk
	 yPvmN6EfBmrXOrDL/ET/zC/d1/kolJW+Zvk8VJXcAqVa55x5St416xpgh2Kycfnve0
	 hishI/KsPfRcfEBoHR8QRPWLHLo1NVJk739O8lh3ZZOAJPg1/vXre3VwRHHo9HpF9a
	 /FL2qx+PYnzLw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2] f2fs: fix to update map->m_next_extent correctly in f2fs_map_blocks()
Date: Fri, 12 Sep 2025 16:12:50 +0800
Message-Id: <20250912081250.44383-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Script to reproduce:
mkfs.f2fs -O extra_attr,compression /dev/vdb -f
mount /dev/vdb /mnt/f2fs -o mode=lfs,noextent_cache
cd /mnt/f2fs
f2fs_io write 1 0 1024 rand dsync testfile
xfs_io testfile -c "fsync"
f2fs_io write 1 0 512 rand dsync testfile
xfs_io testfile -c "fsync"
cd /
umount /mnt/f2fs
mount /dev/vdb /mnt/f2fs
f2fs_io precache_extents /mnt/f2fs/testfile
umount /mnt/f2fs

Tracepoint output:
f2fs_update_read_extent_tree_range: dev = (253,16), ino = 4, pgofs = 0, len = 512, blkaddr = 1055744, c_len = 0
f2fs_update_read_extent_tree_range: dev = (253,16), ino = 4, pgofs = 513, len = 351, blkaddr = 17921, c_len = 0
f2fs_update_read_extent_tree_range: dev = (253,16), ino = 4, pgofs = 864, len = 160, blkaddr = 18272, c_len = 0

During precache_extents, there is off-by-one issue, we should update
map->m_next_extent to pgofs rather than pgofs + 1, if last blkaddr is
valid and not contiguous to previous extent.

Fixes: c4020b2da4c9 ("f2fs: support F2FS_IOC_PRECACHE_EXTENTS")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- clean up codes
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6bb03add93fe..d747850e765f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1782,7 +1782,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 				map->m_len - ofs);
 		}
 		if (map->m_next_extent)
-			*map->m_next_extent = pgofs + 1;
+			*map->m_next_extent = is_hole ? pgofs + 1 : pgofs;
 	}
 	f2fs_put_dnode(&dn);
 unlock_out:
-- 
2.40.1



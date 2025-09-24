Return-Path: <linux-kernel+bounces-829958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EABB98523
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 264DA2A38A6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 05:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64B323B63C;
	Wed, 24 Sep 2025 05:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZOUvDTiK"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A07C141
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758693524; cv=none; b=N5ZQuC0+D0vicEsRnTWalT64E3nT0EbMGWWuk20NO1a8JnT/v6Ac3Dy1UZwpWYYoNfzASupTzLJ71eeJPyah6mUIuDUlxvzQqjJ5SQWu2ksNMqnOSf9RbT8GeOCOVxBKw2q7D2LZRheiXrjIp2+d8UhXm8xwZgDAROcPGkCVdYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758693524; c=relaxed/simple;
	bh=dDp91U+AQmtz2SpNwgR5/+4xhufd3qCL9uGrROhCQ+c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=mHOJVKpSuwfF5H1lJv6R91Y/UqGaQG8Qkvw05M6i4sRWwk+o30Gi2QS3kcf2tpjFqVYMmyPslH7RBB6g3btb826sSIGHkNWp1Nh0hKCTyKm2HD8ZdVhXo3ySczaEmsSj5dFE9oZmWSgpyc+XpN8NFG3o+/NbBV7GN+QT8g9+2iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZOUvDTiK; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250924055839epoutp01ee274255b7a02d764d2f9c145c2ee3d4~oInAWe_Hl0168501685epoutp01m
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:58:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250924055839epoutp01ee274255b7a02d764d2f9c145c2ee3d4~oInAWe_Hl0168501685epoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758693519;
	bh=UCB1XxSfKnxXgnA8T6WAHTu29rC7boLUIOja/oPIJzk=;
	h=From:To:Cc:Subject:Date:References:From;
	b=ZOUvDTiKPXqM8uzigFbD39ZV3UkVpx9SIuOVoUF9RK+fFcl64IemB/2MSS0hbcvlk
	 eUGoGvHuNMphHWCQsdOFt7ylstLElZO018As23ESHiw/KMZZZ7uYPGq4i8ddQbu1c9
	 v1tYb0hGGsOaAX2t8SBNP9RpZ5LhBBUklFBhFEuQ=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPS id
	20250924055838epcas1p262a95f248cb818206ee30ab7e42c3a0c~oIm-kGRQN0075700757epcas1p2o;
	Wed, 24 Sep 2025 05:58:38 +0000 (GMT)
Received: from epcas1p1.samsung.com (unknown [182.195.36.223]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4cWmPB27fXz2SSKj; Wed, 24 Sep
	2025 05:58:38 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20250924055837epcas1p460d67d7f1c900f5cc25c865cb636e950~oIm_3mWWB2706327063epcas1p4z;
	Wed, 24 Sep 2025 05:58:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [10.253.100.173]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250924055837epsmtip14f3381069af90a29232b03eb53e37f1e~oIm_1Ej8f2471124711epsmtip1b;
	Wed, 24 Sep 2025 05:58:37 +0000 (GMT)
From: Yunji Kang <yunji0.kang@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Yunji Kang <yunji0.kang@samsung.com>, Sungjong Seo <sj1557.seo@samsung.com>,
	Sunmin Jeong <s_min.jeong@samsung.com>
Subject: [PATCH v3] f2fs: readahead node blocks in F2FS_GET_BLOCK_PRECACHE
 mode
Date: Wed, 24 Sep 2025 14:58:31 +0900
Message-Id: <20250924055831.250805-1-yunji0.kang@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250924055837epcas1p460d67d7f1c900f5cc25c865cb636e950
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-711,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250924055837epcas1p460d67d7f1c900f5cc25c865cb636e950
References: <CGME20250924055837epcas1p460d67d7f1c900f5cc25c865cb636e950@epcas1p4.samsung.com>

In f2fs_precache_extents(), For large files, It requires reading many
node blocks. Instead of reading each node block with synchronous I/O,
this patch applies readahead so that node blocks can be fetched in
advance.

It reduces the overhead of repeated sync reads and improves efficiency
when precaching extents of large files.

I created a file with the same largest extent and executed the test.
For this experiment, I set the file's largest extent with an offset of 0
and a size of 1GB. I configured the remaining area with 100MB extents.

5GB test file:
dd if=/dev/urandom of=test1 bs=1m count=5120
cp test1 test2
fsync test1
dd if=test1 of=test2 bs=1m skip=1024 seek=1024 count=100 conv=notrunc
dd if=test1 of=test2 bs=1m skip=1224 seek=1224 count=100 conv=notrunc
...
dd if=test1 of=test2 bs=1m skip=5024 seek=5024 count=100 conv=notrunc
reboot

I also created 10GB and 20GB files with large extents using the same
method.

ioctl(F2FS_IOC_PRECACHE_EXTENTS) test results are as follows:
  +-----------+---------+---------+-----------+
  | File size | Before  | After   | Reduction |
  +-----------+---------+---------+-----------+
  | 5GB       | 101.8ms | 37.0ms  | 72.1%     |
  | 10GB      | 222.9ms | 56.0ms  | 74.9%     |
  | 20GB      | 446.2ms | 116.4ms | 73.9%     |
  +-----------+---------+---------+-----------+
Tested on a 256GB mobile device with an SM8750 chipset.

Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Reviewed-by: Sunmin Jeong <s_min.jeong@samsung.com>
Signed-off-by: Yunji Kang <yunji0.kang@samsung.com>
---
v2:
 - Modify the readahead condition check routine for better code
readability.
 - Update the title from 'node block' to 'node blocks'.

v3:
 - Bug fix to allow more node pages to be readahead.
 - Updated with test results.

 fs/f2fs/data.c | 3 +++
 fs/f2fs/f2fs.h | 1 +
 fs/f2fs/node.c | 4 +++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7961e0ddfca3..ab3117e3b24a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1572,6 +1572,9 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 	pgofs =	(pgoff_t)map->m_lblk;
 	end = pgofs + maxblocks;
 
+	if (flag == F2FS_GET_BLOCK_PRECACHE)
+		mode = LOOKUP_NODE_PRECACHE;
+
 next_dnode:
 	if (map->m_may_create) {
 		if (f2fs_lfs_mode(sbi))
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9d3bc9633c1d..3ce41528d48e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -651,6 +651,7 @@ enum {
 					 * look up a node with readahead called
 					 * by get_data_block.
 					 */
+	LOOKUP_NODE_PRECACHE,		/* look up a node for F2FS_GET_BLOCK_PRECACHE */
 };
 
 #define DEFAULT_RETRY_IO_COUNT	8	/* maximum retry read IO or flush count */
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 4254db453b2d..63e9ee7ab911 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -860,7 +860,9 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 			set_nid(parent, offset[i - 1], nids[i], i == 1);
 			f2fs_alloc_nid_done(sbi, nids[i]);
 			done = true;
-		} else if (mode == LOOKUP_NODE_RA && i == level && level > 1) {
+		} else if ((mode == LOOKUP_NODE_RA ||
+                (mode == LOOKUP_NODE_PRECACHE))
+                && i == level && level > 1) {
 			nfolio[i] = f2fs_get_node_folio_ra(parent, offset[i - 1]);
 			if (IS_ERR(nfolio[i])) {
 				err = PTR_ERR(nfolio[i]);
-- 
2.34.1



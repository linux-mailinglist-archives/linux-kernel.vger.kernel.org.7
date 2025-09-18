Return-Path: <linux-kernel+bounces-822306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5169EB83809
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B453AFC7F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF67B2EC562;
	Thu, 18 Sep 2025 08:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KFxbazDx"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F078239E6F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758183643; cv=none; b=dFUxuq7vMYbOYumjXLhc8C+MMichwqi5Fo0NrAPRf4Trlr0rp9HsYUA8NOrILDO0kk8veKJunY49TP4VZyxEwehWdf/0WrQrBPTuxOfYUt4AOVS45TfbZAEV5XSSbbnAahk0KI3/mFR1tt4mHTAHSMEeN5IEigHklqCCLfJpc/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758183643; c=relaxed/simple;
	bh=wcF9GB1rMAVm5TCm+RmVvx4DtcHPo9o/GOtT/VP5vXg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=b5mirJC8JKcMmxxPS2pV30n8TCys6D+N7Zf+HEz5onuFtX+WVN3/8D0rsU8/tInhLxAee6V4xTC9pN4O7t0BA/WIYxP5pvFrnx+Dahz4daLI0c1H25AHOF2ji4NEniP5wQpQr6I3dSZu2ECr+b7PFd4v3HKgFUB6sAxMGp1iV58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KFxbazDx; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250918082039epoutp03e0830f4ee5355985ed156859c93c5642~mUrRgHP7j1349213492epoutp03d
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:20:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250918082039epoutp03e0830f4ee5355985ed156859c93c5642~mUrRgHP7j1349213492epoutp03d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758183639;
	bh=G1sAa6fcz6csqtPywTkaHuC/J9PhwCV/rwBo//lJ5yY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=KFxbazDxKjLAE/14WthMr6fuZTIMiVQ5G8GsoSxp1ePwe7gY8WeU92Aqyvu9SMjsy
	 i3fyPg/Xh1DwIujxxx4pFvjf2BLcvv1Pzl7G7BJwl3lO23snogVnH9VncGS6ISCOH8
	 giER9UItmVYMQcvPCX1yTzWbGq2iNQoNwDcMvQ64=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPS id
	20250918082038epcas1p19c4e495928afed9bb8ed26c9829ef1ab~mUrQ-kf9d2767627676epcas1p1N;
	Thu, 18 Sep 2025 08:20:38 +0000 (GMT)
Received: from epcas1p3.samsung.com (unknown [182.195.38.248]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cS7qp3H3kz3hhTB; Thu, 18 Sep
	2025 08:20:38 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250918082037epcas1p1eb201d3b6d5780c0bff3ba32740ccdcf~mUrQUeeYQ2767627676epcas1p1I;
	Thu, 18 Sep 2025 08:20:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [10.253.100.173]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250918082037epsmtip2806780d30bdff83afa286d5fa7e42f86~mUrQR31l_0085600856epsmtip2k;
	Thu, 18 Sep 2025 08:20:37 +0000 (GMT)
From: Yunji Kang <yunji0.kang@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Yunji Kang <yunji0.kang@samsung.com>, Sungjong Seo <sj1557.seo@samsung.com>,
	Sunmin Jeong <s_min.jeong@samsung.com>
Subject: [PATCH v2] f2fs: readahead node blocks in F2FS_GET_BLOCK_PRECACHE
 mode
Date: Thu, 18 Sep 2025 17:20:23 +0900
Message-Id: <20250918082023.57381-1-yunji0.kang@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250918082037epcas1p1eb201d3b6d5780c0bff3ba32740ccdcf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-711,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250918082037epcas1p1eb201d3b6d5780c0bff3ba32740ccdcf
References: <CGME20250918082037epcas1p1eb201d3b6d5780c0bff3ba32740ccdcf@epcas1p1.samsung.com>

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
  | 5GB       | 101.8ms | 72.1ms  | 29.2%     |
  | 10GB      | 222.9ms | 149.5ms | 32.9%     |
  | 20GB      | 446.2ms | 276.3ms | 38.1%     |
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

 fs/f2fs/data.c | 3 +++
 fs/f2fs/f2fs.h | 1 +
 fs/f2fs/node.c | 5 ++++-
 3 files changed, 8 insertions(+), 1 deletion(-)

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
index 4254db453b2d..d4bf3ce715c5 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -860,7 +860,10 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 			set_nid(parent, offset[i - 1], nids[i], i == 1);
 			f2fs_alloc_nid_done(sbi, nids[i]);
 			done = true;
-		} else if (mode == LOOKUP_NODE_RA && i == level && level > 1) {
+		} else if ((i == level && level > 1) &&
+				(mode == LOOKUP_NODE_RA ||
+				(mode == LOOKUP_NODE_PRECACHE &&
+				offset[i - 1] % MAX_RA_NODE == 0))) {
 			nfolio[i] = f2fs_get_node_folio_ra(parent, offset[i - 1]);
 			if (IS_ERR(nfolio[i])) {
 				err = PTR_ERR(nfolio[i]);
-- 
2.34.1



Return-Path: <linux-kernel+bounces-820006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41088B7F424
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D051048831F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 05:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80B4263C7F;
	Wed, 17 Sep 2025 05:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NTr8Blgo"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B5B28682
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 05:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758088363; cv=none; b=X8hBF4j5VG22R7qOa/Y+gUiioQp4/l2ZXPjegggsOkU1gHxAdfcJz/mBa/visSzMvdbwmL/X51uFYMLsGLovWmdF0rUkIWJu9t9xTAeXtITVceaccSralXGPkqq5iM0Ji7yo3YbwF7NClnUGSsOHDOHNP1sPnqBm0EMHF3BFavw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758088363; c=relaxed/simple;
	bh=D1VwGpRGGOHhDjb4p2FbNu26w6PmteDtWfGYCTufDNM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=MKEDi+Qs0Jv5YyoBJKkJdJQ388tPE11/D1g3YnifhsunH2VMsygbNreNuqJFWFJ0xQOjB+9KqQIJOsoU/r7lIaEIDySlUmHI3Vkq+aRlBc+pt/+17M9gbrgDQe7y6Vj2m5oEF49JhYVuXq2dZjspxLrDxvuaoGuT5KkjhwcuwBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=NTr8Blgo; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250917055238epoutp02a1fa027538e90af1eca11711edea90c9~l-AwO_Ufo2621326213epoutp02w
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 05:52:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250917055238epoutp02a1fa027538e90af1eca11711edea90c9~l-AwO_Ufo2621326213epoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758088358;
	bh=FIHatTlibLLh16hHQHEctRLLB7pivQHEPVqoNGkWAPA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=NTr8BlgocE/zaQWk8ZZ2mFYBRczo4XGhlKa3+RLVcCx5ehcSLcJUk15LVuhMK2kdm
	 NP0stTESA+0hp/n56Zgvou6s6OaRB0rg03PnRWj3UIcYMgiKuiGWBTaI21VOrZ802W
	 Sa070zAYo4f2Zvh4GCU9X+zkgVz7los5HhKm4QLQ=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPS id
	20250917055237epcas1p2728fe4ef5ee7a67644f0bc448e83c8d9~l-Av7Rmdh2807128071epcas1p2O;
	Wed, 17 Sep 2025 05:52:37 +0000 (GMT)
Received: from epcas1p1.samsung.com (unknown [182.195.36.222]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cRSbT63D7z3hhTC; Wed, 17 Sep
	2025 05:52:37 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250917055237epcas1p2faa1b3d6555ffc5179c700e7a2afd448~l-AvTGf_J2855228552epcas1p2D;
	Wed, 17 Sep 2025 05:52:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [10.253.100.173]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250917055237epsmtip17cc01ffc22713629349cd524c3e86451~l-AvQyvjr1881018810epsmtip1y;
	Wed, 17 Sep 2025 05:52:37 +0000 (GMT)
From: Yunji Kang <yunji0.kang@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Yunji Kang <yunji0.kang@samsung.com>, Sungjong Seo <sj1557.seo@samsung.com>,
	Sunmin Jeong <s_min.jeong@samsung.com>
Subject: [PATCH] f2fs: readahead node block in F2FS_GET_BLOCK_PRECACHE mode
Date: Wed, 17 Sep 2025 14:52:17 +0900
Message-Id: <20250917055217.39960-1-yunji0.kang@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250917055237epcas1p2faa1b3d6555ffc5179c700e7a2afd448
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-711,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250917055237epcas1p2faa1b3d6555ffc5179c700e7a2afd448
References: <CGME20250917055237epcas1p2faa1b3d6555ffc5179c700e7a2afd448@epcas1p2.samsung.com>

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
index 4254db453b2d..50be167e5c59 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -860,7 +860,9 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 			set_nid(parent, offset[i - 1], nids[i], i == 1);
 			f2fs_alloc_nid_done(sbi, nids[i]);
 			done = true;
-		} else if (mode == LOOKUP_NODE_RA && i == level && level > 1) {
+		} else if ((mode == LOOKUP_NODE_RA ||
+				(mode == LOOKUP_NODE_PRECACHE && offset[i - 1] % MAX_RA_NODE == 0))
+				&& i == level && level > 1) {
 			nfolio[i] = f2fs_get_node_folio_ra(parent, offset[i - 1]);
 			if (IS_ERR(nfolio[i])) {
 				err = PTR_ERR(nfolio[i]);
-- 
2.34.1



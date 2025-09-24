Return-Path: <linux-kernel+bounces-830062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E581FB98972
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C3453B3E3F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8631827E060;
	Wed, 24 Sep 2025 07:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OdtYy9Et"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF9F1C84C7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699851; cv=none; b=Ul/MgoBd2AKY+6kgAC1JyOo2+0OWWc5eAT4474mGl4XbAcSFe+ujxb7NmlKvgzRu/g2HmTH0b9AcMM8uhb7ts00DaOEyVvKzwNSI7FwoUo1r9jVSfYbtqO9qg0b/kOWTRq6dr1vsKeUIgpvdqyv8B7894EoLhdpq+teao2qM0SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699851; c=relaxed/simple;
	bh=y52NIEdvB6H89kVa5Bf6kIfLO3o2wxq5rA7muF6Ttus=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=Y+5t7AihIapFyJOgyMRh+e6wEzvver161p/NQk1+l/uOXEHsGVWW7GfSE0HqxKSjaiX1qC46qo5JGigrKnHZEqCwXMBUrTtF+VgFC9cNzlMY1A9d0w9/G33OQH7UDZhnoPifzrj2JVJ4pZEAMCD4GWG3fnFKBBmP10nFyjGF5Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OdtYy9Et; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250924074406epoutp0223d2a6aba0299953aa85458da375a222~oKDFPcmSs1617616176epoutp02i
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:44:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250924074406epoutp0223d2a6aba0299953aa85458da375a222~oKDFPcmSs1617616176epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758699846;
	bh=8MznWO4Eakb7UroODORiUGViNhVOOaZtf1/76Z7mtVo=;
	h=From:To:Cc:Subject:Date:References:From;
	b=OdtYy9EtTxX0ClBlwSBHAfJiMjh591NMxorM12M+Fp96G8/T6v+UQw6JQDsSvnxUB
	 N7zUog/ZWauV5clBOc9EsHZ4sQQoHqN5bCA67mnze1lUiYpMu7tUruZKT/VGqFC2PF
	 fFmPg4j8vY69vNXqmTi94EjgXmI9oHsc4PJb828s=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPS id
	20250924074406epcas1p28ce30bf68c0c86eb826f9e4e656ef121~oKDEt-O_F0096100961epcas1p2D;
	Wed, 24 Sep 2025 07:44:06 +0000 (GMT)
Received: from epcas1p1.samsung.com (unknown [182.195.36.225]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4cWpkt0d3hz6B9mL; Wed, 24 Sep
	2025 07:44:06 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20250924074405epcas1p3a116daa0efa4a22d1741437b0cf59f8d~oKDD03zKW0502905029epcas1p3S;
	Wed, 24 Sep 2025 07:44:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [10.253.100.173]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250924074405epsmtip279e9ba81d4b06213adb5f19ab45fe0f4~oKDDyWMfv2576525765epsmtip2i;
	Wed, 24 Sep 2025 07:44:05 +0000 (GMT)
From: Yunji Kang <yunji0.kang@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Yunji Kang <yunji0.kang@samsung.com>, Sungjong Seo <sj1557.seo@samsung.com>,
	Sunmin Jeong <s_min.jeong@samsung.com>
Subject: [PATCH v4] f2fs: readahead node blocks in F2FS_GET_BLOCK_PRECACHE
 mode
Date: Wed, 24 Sep 2025 16:43:58 +0900
Message-Id: <20250924074358.253759-1-yunji0.kang@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250924074405epcas1p3a116daa0efa4a22d1741437b0cf59f8d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-711,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250924074405epcas1p3a116daa0efa4a22d1741437b0cf59f8d
References: <CGME20250924074405epcas1p3a116daa0efa4a22d1741437b0cf59f8d@epcas1p3.samsung.com>

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

v4:
 - Removed a specific condition for precache, 
as using the existing mode (LOOKUP_NODE_RA) is sufficient.


 fs/f2fs/data.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7961e0ddfca3..a20a99d7ba5b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1572,6 +1572,9 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 	pgofs =	(pgoff_t)map->m_lblk;
 	end = pgofs + maxblocks;
 
+	if (flag == F2FS_GET_BLOCK_PRECACHE)
+		mode = LOOKUP_NODE_RA;
+
 next_dnode:
 	if (map->m_may_create) {
 		if (f2fs_lfs_mode(sbi))
-- 
2.34.1



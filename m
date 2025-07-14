Return-Path: <linux-kernel+bounces-729777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F47B03B6A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD1AC7A037C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C547242D6A;
	Mon, 14 Jul 2025 09:53:06 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CF124113C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752486785; cv=none; b=KVZj9Jyn/wrLp9WHfRlvzrm0/Ji1ALixEx9UXzScJZ3xe7nj9s9wZyNyl8ZfBlKqqlmLdOelnofYl+XqgdgGXH9yN+EFyFgwN3bEBS0UaJuCvxHBB+OtULKmNoYQhn6nc/98sGOCZEPCnpVwhGNSbOgwPU7DNAXevI8R/6ExfzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752486785; c=relaxed/simple;
	bh=CbCiqUTDXRnf2WGJYUeAhnYK/yEw5vjK8Gq97oCe900=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CfUZzbT8jWK9x3t1MFeMuE7Dzz0gZJj5kMg1fwJAWToJ/1tIA3eOazVoRRa8c1nljCeW4Ev8SD0F/p+jdn5YXICN6IQIs0xV5G6u5K2ppagSmFzBydha3aI71RifGuwvVCXJx+6ots5QdjeJxOL5DQQNcd+chnoPFN3E84vDlz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 56E9qJXt091864;
	Mon, 14 Jul 2025 17:52:19 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4bgcv93yF0z2Q79s5;
	Mon, 14 Jul 2025 17:48:05 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Mon, 14 Jul 2025 17:52:17 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <Hao_hao.Wang@unisoc.com>
Subject: [PATCH] mkfs.f2fs: adjust zone alignment check to correct position
Date: Mon, 14 Jul 2025 17:51:45 +0800
Message-ID: <1752486705-9498-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 56E9qJXt091864

Should check these after c.devices[1].start_blkaddr is assigned
when c.ndevs > 1.

Fixes: 316e128fe3dc ("mkfs.f2fs: adjust zone alignment when using multi-partitions")
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 mkfs/f2fs_format.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 2680bd3..3a899e6 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -339,17 +339,6 @@ static int f2fs_prepare_super_block(void)
 	MSG(0, "Info: zone aligned segment0 blkaddr: %u\n",
 					get_sb(segment0_blkaddr));
 
-	if (c.zoned_mode &&
-		((c.ndevs == 1 &&
-			(get_sb(segment0_blkaddr) + c.start_sector /
-			DEFAULT_SECTORS_PER_BLOCK) % c.zone_blocks) ||
-		(c.ndevs > 1 &&
-			c.devices[1].start_blkaddr % c.zone_blocks))) {
-		MSG(1, "\tError: Unaligned segment0 block address %u\n",
-				get_sb(segment0_blkaddr));
-		return -1;
-	}
-
 	for (i = 0; i < c.ndevs; i++) {
 		if (i == 0) {
 			c.devices[i].total_segments =
@@ -390,6 +379,18 @@ static int f2fs_prepare_super_block(void)
 
 		c.total_segments += c.devices[i].total_segments;
 	}
+
+	if (c.zoned_mode &&
+		((c.ndevs == 1 &&
+			(get_sb(segment0_blkaddr) + c.start_sector /
+			DEFAULT_SECTORS_PER_BLOCK) % c.zone_blocks) ||
+		(c.ndevs > 1 &&
+			c.devices[1].start_blkaddr % c.zone_blocks))) {
+		MSG(1, "\tError: Unaligned segment0 block address %u\n",
+				get_sb(segment0_blkaddr));
+		return -1;
+	}
+
 	set_sb(segment_count, c.total_segments);
 	set_sb(segment_count_ckpt, F2FS_NUMBER_OF_CHECKPOINT_PACK);
 
-- 
1.9.1



Return-Path: <linux-kernel+bounces-733207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3896B0718A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0C717F978
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEF02F1983;
	Wed, 16 Jul 2025 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="m4Zc/ixF"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5B82F1FF4
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752657787; cv=none; b=UHWgH15t04cTQm2uz3lUrkizQGy9kXuXFCQMG7Rz1CTn5LjqEDZNCXjrajkV06KGgx84BJuqp34ZHFVQTCuzEkahQo3B4sA/84ZP8aA2a+j5ns2nEebPCaik+g5dgI6aVhgfebwIGg2viJLxO6+YmSKzYUO0PNxDs3VyhX39Wck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752657787; c=relaxed/simple;
	bh=DdkpaP3zWqzNKWwedXzH0thTe+J2eOPHl6Lt4jjzkJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SNJYPykZbv2sm63ijO732V3W8FiqsNvN+Ht8Zu2f41cxhKP9Vv7Fz0WFkWE2CplcDgZs4gpoyQ3muK1LtLKpajkWzlSu4/Ce6x7S2qq+V0RmLQuMKGz8GiTZjq8TwI+RUKHrtAe9cRBv1jbzbvfiGcWfE4VALBbR8NZFMOoUl44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=m4Zc/ixF; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752657781; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=oRq1da1ShbWLicICYakMfFg739TWglB9aY30Dnetp14=;
	b=m4Zc/ixFSvAPtPmcyybzbsCFKeq+8PC4Z0Qp4THIGfabslKfj9MSKeTRUXu+HLQbPmAZVVgkXUe2Q6kS2OiH/j4z94wu6PFobQQrGSFwX0ZJMsq3OEqr9j5mNokRIbDR4eJpf1e7+7Ja1h5my+25W3uMs0RbnZRrdIwQrQj+ewA=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj3WLvn_1752657776 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Jul 2025 17:23:01 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: refine erofs_iomap_begin()
Date: Wed, 16 Jul 2025 17:22:54 +0800
Message-ID: <20250716092254.3826715-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 - Avoid calling erofs_map_dev() for unmapped extents;

 - Assign `iomap->addr` for inline extents too (since they have physical
   location).

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index dd7d86809c18..383c1337e157 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -269,6 +269,16 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	if (ret < 0)
 		return ret;
 
+	iomap->offset = map.m_la;
+	iomap->length = map.m_llen;
+	iomap->flags = 0;
+	iomap->private = NULL;
+	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
+		iomap->type = IOMAP_HOLE;
+		iomap->addr = IOMAP_NULL_ADDR;
+		return 0;
+	}
+
 	mdev = (struct erofs_map_dev) {
 		.m_deviceid = map.m_deviceid,
 		.m_pa = map.m_pa,
@@ -277,22 +287,14 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	if (ret)
 		return ret;
 
-	iomap->offset = map.m_la;
 	if (flags & IOMAP_DAX)
 		iomap->dax_dev = mdev.m_dif->dax_dev;
 	else
 		iomap->bdev = mdev.m_bdev;
-	iomap->length = map.m_llen;
-	iomap->flags = 0;
-	iomap->private = NULL;
 
-	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
-		iomap->type = IOMAP_HOLE;
-		iomap->addr = IOMAP_NULL_ADDR;
-		if (!iomap->length)
-			iomap->length = length;
-		return 0;
-	}
+	iomap->addr = mdev.m_dif->fsoff + mdev.m_pa;
+	if (flags & IOMAP_DAX)
+		iomap->addr += mdev.m_dif->dax_part_off;
 
 	if (map.m_flags & EROFS_MAP_META) {
 		void *ptr;
@@ -306,9 +308,6 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		iomap->private = buf.base;
 	} else {
 		iomap->type = IOMAP_MAPPED;
-		iomap->addr = mdev.m_dif->fsoff + mdev.m_pa;
-		if (flags & IOMAP_DAX)
-			iomap->addr += mdev.m_dif->dax_part_off;
 	}
 	return 0;
 }
-- 
2.43.5



Return-Path: <linux-kernel+bounces-829894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04860B9822E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 05:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41173BDD4F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 03:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29340227E95;
	Wed, 24 Sep 2025 03:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vUsGSFCb"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EC84D599
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758684517; cv=none; b=GUk1poSRYpzZ5MmDw16xEEkHRExfJQZkD8Hc3Ng4bD3uwGE89k72Xwhz3IysiVnTsgNcuPkfqbszuYdkhOGH64I+a8+X2/SD5qODKCSnjBBHkR2U2PjWpcjV0xZCEZA/+H5lsrnwr0ylWf78dKiGxeLE4nu6UtDseilCAKuHKf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758684517; c=relaxed/simple;
	bh=+Fb5k3zgDrErZCtlf/Kf6tEcnR+bj3jBojDEKDUw9UY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PBwip59cgBmPgsTE8I8+ns4Mtrb+K8qTvcFEPQHWpP5Us9EWOn3QoRLt7jH980sRxgDk/HEvsqH8/mF89XEdTvTG0c4jtW+anAMZjGY3jz5F6vCWW3VMcuPK16CR8jlixG5csn8tDEFZoPPGMlaWjimCXlZoit1yN8skvzqKS/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vUsGSFCb; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758684512; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=XyAFB3WArWSNB/CYfgIoegXyVO5beOL4xews09LfXLg=;
	b=vUsGSFCbR/rqfpUZ0gYB1hYGA8/Ym3X91z4elGq69g9ANJhALwqnclTDlvohlwWRMcoNFFHqetg/ux3h9huj30di9LmmvfUQR+kMrFAQtj3sEkxtY0kYmosduZO9z5k7RdVSHUZG6+VWvyKkSzpn64RcRB8nYvLfLTokH5WkKr8=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wohs6I0_1758684507 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 24 Sep 2025 11:28:32 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: drop redundant sanity check for ztailpacking inline
Date: Wed, 24 Sep 2025 11:28:26 +0800
Message-ID: <20250924032826.3410404-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is already performed in z_erofs_map_blocks_fo().

Also align the error message with that used for the uncompressed
inline layout.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 3 ---
 fs/erofs/zmap.c  | 4 ++--
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 625b8ae8f67f..bc80cfe482f7 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -823,9 +823,6 @@ static int z_erofs_pcluster_begin(struct z_erofs_frontend *fe)
 			}
 			rcu_read_unlock();
 		}
-	} else if ((map->m_pa & ~PAGE_MASK) + map->m_plen > PAGE_SIZE) {
-		DBG_BUGON(1);
-		return -EFSCORRUPTED;
 	}
 
 	if (pcl) {
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 798223e6da9c..e5581dbeb4c2 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -462,8 +462,8 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
 		map->m_pa = vi->z_fragmentoff;
 		map->m_plen = vi->z_idata_size;
 		if (erofs_blkoff(sb, map->m_pa) + map->m_plen > sb->s_blocksize) {
-			erofs_err(sb, "invalid tail-packing pclustersize %llu",
-				  map->m_plen);
+			erofs_err(sb, "ztailpacking inline data across blocks @ nid %llu",
+				  vi->nid);
 			err = -EFSCORRUPTED;
 			goto unmap_out;
 		}
-- 
2.43.5



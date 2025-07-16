Return-Path: <linux-kernel+bounces-732956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4932B06E22
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D3A03AE88D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CD62882D3;
	Wed, 16 Jul 2025 06:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TFVD3IS8"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5195B10A1E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 06:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752648123; cv=none; b=WmTkfbPRLVbSDbeE6OM7DOOaQhvQuSortUciFLxx0q14DRZN15i1iSKZRyH1XtLbMaE5PBziXx18Zwk/fTrwBIXq4kPR4DCUEHoRtHDSxcR7WLszjSa+SXywJXNhc55Ajnmdo36f1mbUqd+kGDM06KUXXE50DrT2rnnWXTaBnRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752648123; c=relaxed/simple;
	bh=Z7iNevFVY+VbBQlJbu5BrGs7A7QTEjsU3i6fiE5DfPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2ODICY1pEvar3U0TMqK0N36+HSuAP3W+b2IautkjG1cIGCrQhpaBaOiQDmeFZyaOa7D096i6u8Me8JWg0aNV0F7ukMZpCs0XMQo3u5HmNIz9MZnSKkas8cAfxcscSwakxp9wJCgNPAWzzQHEoz2JEE2aFNaCe7/jZtPDlxQx7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TFVD3IS8; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752648117; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=RYcHHDGKG22FuVlkAHRB4rfI+ekqEKqG/7U15GMIscY=;
	b=TFVD3IS8ar/F+3BO3x+noCX27Rf2eLkG1plZxq+Sc188FjySyPP/GU/wJ3+lIkoPY9tuNMiacVXxM4qfxp/hn3OdOVTav8v0g1UBbjL0JF3dvsWKQlzhUr9x9eBgCwCGp33X0HrWdCn9a7PUmGemWtVop+80LMciDbLJJo7Ue/g=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj33g3N_1752648113 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Jul 2025 14:41:57 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LMKL <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 2/2] erofs: unify meta buffers in z_erofs_fill_inode()
Date: Wed, 16 Jul 2025 14:41:52 +0800
Message-ID: <20250716064152.3537457-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250714090907.4095645-2-hsiangkao@linux.alibaba.com>
References: <20250714090907.4095645-2-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to keep additional local metabufs since we already
have one in `struct erofs_map_blocks`.

This was actually a leftover when applying meta buffers to zmap
operations, see commit 09c543798c3c ("erofs: use meta buffers for
zmap operations").

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v1: https://lore.kernel.org/r/20250714090907.4095645-2-hsiangkao@linux.alibaba.com
change since v1:
 - Fix a regresssion since EROFS_GET_BLOCKS_FINDTAIL will update the
   original map to the tail extent so just keep using a new `map`.

 fs/erofs/zmap.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index ff1d0751fc61..b72a0e3f9362 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -620,13 +620,12 @@ static int z_erofs_map_blocks_ext(struct inode *inode,
 	return 0;
 }
 
-static int z_erofs_fill_inode_lazy(struct inode *inode)
+static int z_erofs_fill_inode(struct inode *inode, struct erofs_map_blocks *map)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
 	struct super_block *const sb = inode->i_sb;
 	int err, headnr;
 	erofs_off_t pos;
-	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	struct z_erofs_map_header *h;
 
 	if (test_bit(EROFS_I_Z_INITED_BIT, &vi->flags)) {
@@ -646,7 +645,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		goto out_unlock;
 
 	pos = ALIGN(erofs_iloc(inode) + vi->inode_isize + vi->xattr_isize, 8);
-	h = erofs_read_metabuf(&buf, sb, pos);
+	h = erofs_read_metabuf(&map->buf, sb, pos);
 	if (IS_ERR(h)) {
 		err = PTR_ERR(h);
 		goto out_unlock;
@@ -684,7 +683,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		erofs_err(sb, "unknown HEAD%u format %u for nid %llu, please upgrade kernel",
 			  headnr + 1, vi->z_algorithmtype[headnr], vi->nid);
 		err = -EOPNOTSUPP;
-		goto out_put_metabuf;
+		goto out_unlock;
 	}
 
 	if (!erofs_sb_has_big_pcluster(EROFS_SB(sb)) &&
@@ -693,7 +692,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		erofs_err(sb, "per-inode big pcluster without sb feature for nid %llu",
 			  vi->nid);
 		err = -EFSCORRUPTED;
-		goto out_put_metabuf;
+		goto out_unlock;
 	}
 	if (vi->datalayout == EROFS_INODE_COMPRESSED_COMPACT &&
 	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1) ^
@@ -701,27 +700,25 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		erofs_err(sb, "big pcluster head1/2 of compact indexes should be consistent for nid %llu",
 			  vi->nid);
 		err = -EFSCORRUPTED;
-		goto out_put_metabuf;
+		goto out_unlock;
 	}
 
 	if (vi->z_idata_size ||
 	    (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)) {
-		struct erofs_map_blocks map = {
+		struct erofs_map_blocks tm = {
 			.buf = __EROFS_BUF_INITIALIZER
 		};
 
-		err = z_erofs_map_blocks_fo(inode, &map,
+		err = z_erofs_map_blocks_fo(inode, &tm,
 					    EROFS_GET_BLOCKS_FINDTAIL);
-		erofs_put_metabuf(&map.buf);
+		erofs_put_metabuf(&tm.buf);
 		if (err < 0)
-			goto out_put_metabuf;
+			goto out_unlock;
 	}
 done:
 	/* paired with smp_mb() at the beginning of the function */
 	smp_mb();
 	set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
-out_put_metabuf:
-	erofs_put_metabuf(&buf);
 out_unlock:
 	clear_and_wake_up_bit(EROFS_I_BL_Z_BIT, &vi->flags);
 	return err;
@@ -739,7 +736,7 @@ int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
 		map->m_la = inode->i_size;
 		map->m_flags = 0;
 	} else {
-		err = z_erofs_fill_inode_lazy(inode);
+		err = z_erofs_fill_inode(inode, map);
 		if (!err) {
 			if (vi->datalayout == EROFS_INODE_COMPRESSED_FULL &&
 			    (vi->z_advise & Z_EROFS_ADVISE_EXTENTS))
-- 
2.43.5



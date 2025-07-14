Return-Path: <linux-kernel+bounces-729685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F75B03A5B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5E2178EF1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A032723C4FF;
	Mon, 14 Jul 2025 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kTat4hT8"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A660B23D29D
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752484165; cv=none; b=Acbt4NdaI2A20QHmmIH0HKDNotsYibJGg07MOGEY7dGWbSv8DYh2nLinx56w4Rf1KLHkLot3WZ9qE7TNoEvs+Up2qPSB3h+UKuqhQKbyI0waYqwXI5rk7Z7uUQEvLjH4Qxcg7hmx3qJrBnlcMx0SmJvB1IIB7Dl19HfgxrDbDAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752484165; c=relaxed/simple;
	bh=+KF0tdS39jv8LMaQQiu2dUmsA0i3U4gA0tQsso+a6yI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XEMDyVMiV6Rx6W1GoxEqPWZHjJd86Hzogvd1xcc3Fv+Ak+gA648OfhATS8vHjgnNbdsUR8HQdTDvrxslbO867/gxhrXp3EOiAT2zxlXgxeGrWWhnJWc+eHLonfAq+wiB+qzxNw+1NIkDBh3LHv1UEhv5cOrsay3YBAYWiIbRwwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kTat4hT8; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752484154; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=eW36RIA3QHI60sWmZ+PaXRGfXltJSG358ob9Xx4SKNI=;
	b=kTat4hT8jLh5QITlDt18cowsxkASIhfPXiqatUePakzZVOY96tJBH/1nmAv1lt3JbzBKMTNaCQ6mV3CvYcbOnP7SZvTxJt+UoQLUsP/OjhzOPs232QYyXp4hVcRHyPVfyNdfd67ntIV8tMiETnxM2H/T/nkrSWpHW40FMpSxQPE=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WissJ87_1752484152 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Jul 2025 17:09:13 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/2] erofs: unify meta buffers in z_erofs_fill_inode()
Date: Mon, 14 Jul 2025 17:09:07 +0800
Message-ID: <20250714090907.4095645-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250714090907.4095645-1-hsiangkao@linux.alibaba.com>
References: <20250714090907.4095645-1-hsiangkao@linux.alibaba.com>
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
 fs/erofs/zmap.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index ff1d0751fc61..9afc8a68bacb 100644
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
@@ -701,27 +700,20 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		erofs_err(sb, "big pcluster head1/2 of compact indexes should be consistent for nid %llu",
 			  vi->nid);
 		err = -EFSCORRUPTED;
-		goto out_put_metabuf;
+		goto out_unlock;
 	}
 
 	if (vi->z_idata_size ||
 	    (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)) {
-		struct erofs_map_blocks map = {
-			.buf = __EROFS_BUF_INITIALIZER
-		};
-
-		err = z_erofs_map_blocks_fo(inode, &map,
+		err = z_erofs_map_blocks_fo(inode, map,
 					    EROFS_GET_BLOCKS_FINDTAIL);
-		erofs_put_metabuf(&map.buf);
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
@@ -739,7 +731,7 @@ int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
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



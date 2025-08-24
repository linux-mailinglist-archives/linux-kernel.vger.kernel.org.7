Return-Path: <linux-kernel+bounces-783431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A166B32D85
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 06:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50A1D7B47D8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 04:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DC81A5B8D;
	Sun, 24 Aug 2025 04:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oPjlEyiP"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D934E84E07
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 04:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756009301; cv=none; b=gq49V/cl9lh/+OIZvIk6b22Pk15OAeL4NcVGuWC1QN7WcpI17pF73QGMjzTav4/6GWDUje/fl741ENbjxDwrBZOYJn32eghfPv0/vSo1CAVQ2gRchpL5lNyK26o4mVu5QWyBJLX9QKlCjpzR/Ps70xD7FI/QnvL7NjjkK2obH+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756009301; c=relaxed/simple;
	bh=mM2BnztytC70NWM+4YWw3NtpHpBtwkh4r8oNVtFu+cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NEyHlQHytOr9eSK+S36NGzdeSVMMgwoDXMphvqOTRnve2BaQi2UZ+/NxcNcJ6Lg5HykTXisOkF+nrJHglymEWkwj+G5ByEngXapIIe2Rye5F/K7g25HXF3QXaSeH9vHwXLrH4YvrBSgCHDx4TX10r4KJAmBxImEh1lR9UV+29cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oPjlEyiP; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756009290; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=FWNcMrqa7fea4DWK3k+kaYsa2tiNCaroVzz0Etqf4Ws=;
	b=oPjlEyiPQ517cCJoZZK+HZ/+eH+emAP3y3wAVc6clqC0Fpl7BseNa/atNUTg5Mmcu8FuKfgv8VLV0LFMSXn4kkoZFXmuAPsUrntjA9PdZz84McxVlkBY3CRQU2kl+HNTnWhrs/vIZo6hH5XUVEt45zVZR1x7rdIRqvXBM/ptClk=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmNjkWY_1756009284 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 24 Aug 2025 12:21:29 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com
Subject: [PATCH v2] erofs: fix invalid algorithm for encoded extents
Date: Sun, 24 Aug 2025 12:21:23 +0800
Message-ID: <20250824042123.333183-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250823093018.3117864-1-hsiangkao@linux.alibaba.com>
References: <20250823093018.3117864-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current algorithm sanity checks do not properly apply to new
encoded extents.

Unify the algorithm format check with Z_EROFS_COMPRESSION_RUNTIME_MAX
and ensure consistency with sbi->available_compr_algs.

Reported-and-tested-by: syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/68a8bd20.050a0220.37038e.005a.GAE@google.com
Fixes: 1d191b4ca51d ("erofs: implement encoded extent metadata")
Thanks-to: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v2:
 - should be checked with Z_EROFS_COMPRESSION_RUNTIME_MAX instead.

 fs/erofs/zmap.c | 66 +++++++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index a93efd95c555..dcbc83ebd636 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -394,10 +394,10 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
 		.map = map,
 		.in_mbox = erofs_inode_in_metabox(inode),
 	};
-	int err = 0;
-	unsigned int endoff, afmt;
+	unsigned int endoff;
 	unsigned long initial_lcn;
 	unsigned long long ofs, end;
+	int err;
 
 	ofs = flags & EROFS_GET_BLOCKS_FINDTAIL ? inode->i_size - 1 : map->m_la;
 	if (fragment && !(flags & EROFS_GET_BLOCKS_FINDTAIL) &&
@@ -482,20 +482,15 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
 			err = -EFSCORRUPTED;
 			goto unmap_out;
 		}
-		afmt = vi->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER ?
-			Z_EROFS_COMPRESSION_INTERLACED :
-			Z_EROFS_COMPRESSION_SHIFTED;
+		if (vi->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER)
+			map->m_algorithmformat = Z_EROFS_COMPRESSION_INTERLACED;
+		else
+			map->m_algorithmformat = Z_EROFS_COMPRESSION_SHIFTED;
+	} else if (m.headtype == Z_EROFS_LCLUSTER_TYPE_HEAD2) {
+		map->m_algorithmformat = vi->z_algorithmtype[1];
 	} else {
-		afmt = m.headtype == Z_EROFS_LCLUSTER_TYPE_HEAD2 ?
-			vi->z_algorithmtype[1] : vi->z_algorithmtype[0];
-		if (!(EROFS_I_SB(inode)->available_compr_algs & (1 << afmt))) {
-			erofs_err(sb, "inconsistent algorithmtype %u for nid %llu",
-				  afmt, vi->nid);
-			err = -EFSCORRUPTED;
-			goto unmap_out;
-		}
+		map->m_algorithmformat = vi->z_algorithmtype[0];
 	}
-	map->m_algorithmformat = afmt;
 
 	if ((flags & EROFS_GET_BLOCKS_FIEMAP) ||
 	    ((flags & EROFS_GET_BLOCKS_READMORE) &&
@@ -626,9 +621,9 @@ static int z_erofs_fill_inode(struct inode *inode, struct erofs_map_blocks *map)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
 	struct super_block *const sb = inode->i_sb;
-	int err, headnr;
-	erofs_off_t pos;
 	struct z_erofs_map_header *h;
+	erofs_off_t pos;
+	int err = 0;
 
 	if (test_bit(EROFS_I_Z_INITED_BIT, &vi->flags)) {
 		/*
@@ -642,7 +637,6 @@ static int z_erofs_fill_inode(struct inode *inode, struct erofs_map_blocks *map)
 	if (wait_on_bit_lock(&vi->flags, EROFS_I_BL_Z_BIT, TASK_KILLABLE))
 		return -ERESTARTSYS;
 
-	err = 0;
 	if (test_bit(EROFS_I_Z_INITED_BIT, &vi->flags))
 		goto out_unlock;
 
@@ -679,15 +673,6 @@ static int z_erofs_fill_inode(struct inode *inode, struct erofs_map_blocks *map)
 	else if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER)
 		vi->z_idata_size = le16_to_cpu(h->h_idata_size);
 
-	headnr = 0;
-	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX ||
-	    vi->z_algorithmtype[++headnr] >= Z_EROFS_COMPRESSION_MAX) {
-		erofs_err(sb, "unknown HEAD%u format %u for nid %llu, please upgrade kernel",
-			  headnr + 1, vi->z_algorithmtype[headnr], vi->nid);
-		err = -EOPNOTSUPP;
-		goto out_unlock;
-	}
-
 	if (!erofs_sb_has_big_pcluster(EROFS_SB(sb)) &&
 	    vi->z_advise & (Z_EROFS_ADVISE_BIG_PCLUSTER_1 |
 			    Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
@@ -726,6 +711,29 @@ static int z_erofs_fill_inode(struct inode *inode, struct erofs_map_blocks *map)
 	return err;
 }
 
+static int z_erofs_map_sanity_check(struct inode *inode,
+				    struct erofs_map_blocks *map)
+{
+	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
+
+	if (!(map->m_flags & EROFS_MAP_ENCODED))
+		return 0;
+	if (unlikely(map->m_algorithmformat >= Z_EROFS_COMPRESSION_RUNTIME_MAX)) {
+		erofs_err(inode->i_sb, "unknown algorithm %d @ pos %llu for nid %llu, please upgrade kernel",
+			  map->m_algorithmformat, map->m_la, EROFS_I(inode)->nid);
+		return -EOPNOTSUPP;
+	}
+	if (unlikely(!(sbi->available_compr_algs & (1 << map->m_algorithmformat)))) {
+		erofs_err(inode->i_sb, "inconsistent algorithmtype %u for nid %llu",
+			  map->m_algorithmformat, EROFS_I(inode)->nid);
+		return -EFSCORRUPTED;
+	}
+	if (unlikely(map->m_plen > Z_EROFS_PCLUSTER_MAX_SIZE ||
+		     map->m_llen > Z_EROFS_PCLUSTER_MAX_DSIZE))
+		return -EOPNOTSUPP;
+	return 0;
+}
+
 int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
 			    int flags)
 {
@@ -746,10 +754,8 @@ int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
 			else
 				err = z_erofs_map_blocks_fo(inode, map, flags);
 		}
-		if (!err && (map->m_flags & EROFS_MAP_ENCODED) &&
-		    unlikely(map->m_plen > Z_EROFS_PCLUSTER_MAX_SIZE ||
-			     map->m_llen > Z_EROFS_PCLUSTER_MAX_DSIZE))
-			err = -EOPNOTSUPP;
+		if (!err)
+			err = z_erofs_map_sanity_check(inode, map);
 		if (err)
 			map->m_llen = 0;
 	}
-- 
2.43.5



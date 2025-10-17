Return-Path: <linux-kernel+bounces-857465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C067BE6E07
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F59400CAA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75783112A0;
	Fri, 17 Oct 2025 07:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mljrpGyt"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3172222C4
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 07:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760684754; cv=none; b=lisaKutBP9U7cd7pYM4GsgIDXs4kY0ZPdXA+MBlePLtfQ1G0Q6cspsKpZmckXLGlYGlNWpsSmmsQs9SaOSK/8NYmyJWQgSi3YofgGAU9BvQjhRkNBQv41bK67/UtbJch34YMZLhhaCCKJOdm30OZ8zkIOp6Xw7LmXaQVSBs5Zng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760684754; c=relaxed/simple;
	bh=aN/adSg86Z/2K3CsfOHuhlwfWvy9MERo85FrklqoiUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GUu/bF+xrE58jLh9GOmhXTABoO9ko1z0nJKvxRXfqDhdo/0tLCERoMCSBh4qHXwKU+p9QBB/p8L9ZRkACZEHCMHC3N11z6Do73vwlTd4E9II6L4qpAmQfzzJrKfaxNRShjKq/+08s4EZ/HJdwC9A0fBifCzTJTkgYTMTRa5YpYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mljrpGyt; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760684745; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=HQ7W+r503Iw+EOno8tbHH25ahpTKxYi2lcfSqIDRr1E=;
	b=mljrpGytJhJTasL21Ll5C9vY9qx+zcZ1AkMsh91zIpl52F0rEaookBTS8YgEEZkn1RZkXEpuR6h3AytNdHvasgDW6GItKrfh4AAIFXOLLPtuUrmAPbd5OfN/l6ki8y8dJr5ygL5Lxh7gyuBwem9iQU5y6uKGgL3BTx77kwQAVNk=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WqOynSt_1760684740 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Oct 2025 15:05:45 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Robert Morris <rtm@csail.mit.edu>
Subject: [PATCH 1/2] erofs: avoid infinite loops due to corrupted subpage compact indexes
Date: Fri, 17 Oct 2025 15:05:38 +0800
Message-ID: <20251017070539.901367-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Robert reported an infinite loop observed by two crafted images.

The root cause is that `clusterofs` can be larger than `lclustersize`
for !NONHEAD `lclusters` in corrupted subpage compact indexes, e.g.:

  blocksize = lclustersize = 512   lcn = 6   clusterofs = 515

Move the corresponding check for full compress indexes to
`z_erofs_load_lcluster_from_disk()` to also cover subpage compact
compress indexes.

It also fixes the position of `m->type >= Z_EROFS_LCLUSTER_TYPE_MAX`
check, since it should be placed right after
`z_erofs_load_{compact,full}_lcluster()`.

Fixes: 8d2517aaeea3 ("erofs: fix up compacted indexes for block size < 4096")
Fixes: 1a5223c182fd ("erofs: do sanity check on m->type in z_erofs_load_compact_lcluster()")
Reported-by: Robert Morris <rtm@csail.mit.edu>
Closes: https://lore.kernel.org/r/35167.1760645886@localhost
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zmap.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index e5581dbeb4c2..6aca228cd2a5 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -55,10 +55,6 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 	} else {
 		m->partialref = !!(advise & Z_EROFS_LI_PARTIAL_REF);
 		m->clusterofs = le16_to_cpu(di->di_clusterofs);
-		if (m->clusterofs >= 1 << vi->z_lclusterbits) {
-			DBG_BUGON(1);
-			return -EFSCORRUPTED;
-		}
 		m->pblk = le32_to_cpu(di->di_u.blkaddr);
 	}
 	return 0;
@@ -240,21 +236,29 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
 static int z_erofs_load_lcluster_from_disk(struct z_erofs_maprecorder *m,
 					   unsigned int lcn, bool lookahead)
 {
+	struct erofs_inode *vi = EROFS_I(m->inode);
+	int err;
+
+	if (vi->datalayout == EROFS_INODE_COMPRESSED_COMPACT) {
+		err = z_erofs_load_compact_lcluster(m, lcn, lookahead);
+	} else {
+		DBG_BUGON(vi->datalayout != EROFS_INODE_COMPRESSED_FULL);
+		err = z_erofs_load_full_lcluster(m, lcn);
+	}
+	if (err)
+		return err;
+
 	if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
 		erofs_err(m->inode->i_sb, "unknown type %u @ lcn %u of nid %llu",
-				m->type, lcn, EROFS_I(m->inode)->nid);
+			  m->type, lcn, EROFS_I(m->inode)->nid);
 		DBG_BUGON(1);
 		return -EOPNOTSUPP;
+	} else if (m->type != Z_EROFS_LCLUSTER_TYPE_NONHEAD &&
+		   m->clusterofs >= (1 << vi->z_lclusterbits)) {
+		DBG_BUGON(1);
+		return -EFSCORRUPTED;
 	}
-
-	switch (EROFS_I(m->inode)->datalayout) {
-	case EROFS_INODE_COMPRESSED_FULL:
-		return z_erofs_load_full_lcluster(m, lcn);
-	case EROFS_INODE_COMPRESSED_COMPACT:
-		return z_erofs_load_compact_lcluster(m, lcn, lookahead);
-	default:
-		return -EINVAL;
-	}
+	return 0;
 }
 
 static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
-- 
2.43.5



Return-Path: <linux-kernel+bounces-728040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5459FB022E7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D89A6594D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9732F0C67;
	Fri, 11 Jul 2025 17:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="U5Yb194A"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3606A2AE66
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255796; cv=none; b=qTiEvTsDnfB9VstC5AF1i5IVGYN9VQ0Glo4ozSUABqIHO5cpQkSuRYvdyHU6k4gdcJT9aX+hgcam8KlIq2JIvTWGcEHuP4zvIx4MI+8h0KprGe2O+hJRLfc3QUSroSquXjSkeee0NkA78JT24D4UL+ksGz8vRT3+htNUV5d3cI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255796; c=relaxed/simple;
	bh=6oz42lfA0Olv9qz4s/Oun+cbKA+sVqYBaeyP5Szy22c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F0wokaXslEPu/GpB6k8z+1CaiXSNe6QcMzyzqbP3mweHMI1Mp9N0nu6LXdtV9MM2IXSDMYjvPCP1DUDGGJTgZKdBcvtQQUMniBL08eIrUXri1ZIDR02FIz+8252nUkAO4/HaZqBMATZFkJVIXa1QYK9zccl19i1gZ1YD/iGgoA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=U5Yb194A; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752255785; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=v+obGjGNZ7DcaJP0+2r+47ioTeGjRbyq9DzXi0xXDoY=;
	b=U5Yb194ALRS0g73A2CZApMmaY1x9eMi8XemNoLghvP5+qbsumGPDznKlX8NlpqYJ42Czzr8neGSKAkBIohqVXvWZekxenxx3BzWB3DWdh5eutZJl1FA7cRcZDPOuL+24dbIFdlv8Nwjn02Umrd0PRyWqh3ykF7pWZACsS1BqF4s=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WihkUVt_1752255778 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 12 Jul 2025 01:43:05 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Axel Fontaine <axel@axelfontaine.com>
Subject: [PATCH] erofs: fix large fragment handling
Date: Sat, 12 Jul 2025 01:42:57 +0800
Message-ID: <20250711174257.3427562-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fragments aren't limited by Z_EROFS_PCLUSTER_MAX_DSIZE. However, if
a fragment's logical length is larger than Z_EROFS_PCLUSTER_MAX_DSIZE
but the fragment is not the whole inode, it currently returns
-EOPNOTSUPP because m_flags has the wrong EROFS_MAP_ENCODED flag set.
It is not intended by design but should be rare, as it can only be
reproduced by mkfs with `-Eall-fragments` in a specific case.

Let's normalize fragment m_flags using the new EROFS_MAP_FRAGMENT.

Reported-by: Axel Fontaine <axel@axelfontaine.com>
Closes: https://github.com/erofs/erofs-utils/issues/23
Fixes: 7c3ca1838a78 ("erofs: restrict pcluster size limitations")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/internal.h | 4 +++-
 fs/erofs/zmap.c     | 7 +++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 0d19bde8c094..06b867d2fc3b 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -315,10 +315,12 @@ static inline struct folio *erofs_grab_folio_nowait(struct address_space *as,
 /* The length of extent is full */
 #define EROFS_MAP_FULL_MAPPED	0x0008
 /* Located in the special packed inode */
-#define EROFS_MAP_FRAGMENT	0x0010
+#define __EROFS_MAP_FRAGMENT	0x0010
 /* The extent refers to partial decompressed data */
 #define EROFS_MAP_PARTIAL_REF	0x0020
 
+#define EROFS_MAP_FRAGMENT	(EROFS_MAP_MAPPED | __EROFS_MAP_FRAGMENT)
+
 struct erofs_map_blocks {
 	struct erofs_buf buf;
 
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 431199452542..07a6810a076b 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -403,8 +403,7 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
 	    !vi->z_tailextent_headlcn) {
 		map->m_la = 0;
 		map->m_llen = inode->i_size;
-		map->m_flags = EROFS_MAP_MAPPED |
-			EROFS_MAP_FULL_MAPPED | EROFS_MAP_FRAGMENT;
+		map->m_flags = EROFS_MAP_FRAGMENT;
 		return 0;
 	}
 	initial_lcn = ofs >> lclusterbits;
@@ -468,7 +467,7 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
 			goto unmap_out;
 		}
 	} else if (fragment && m.lcn == vi->z_tailextent_headlcn) {
-		map->m_flags |= EROFS_MAP_FRAGMENT;
+		map->m_flags = EROFS_MAP_FRAGMENT;
 	} else {
 		map->m_pa = erofs_pos(sb, m.pblk);
 		err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
@@ -596,7 +595,7 @@ static int z_erofs_map_blocks_ext(struct inode *inode,
 	if (lstart < lend) {
 		map->m_la = lstart;
 		if (last && (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)) {
-			map->m_flags |= EROFS_MAP_MAPPED | EROFS_MAP_FRAGMENT;
+			map->m_flags = EROFS_MAP_FRAGMENT;
 			vi->z_fragmentoff = map->m_plen;
 			if (recsz > offsetof(struct z_erofs_extent, pstart_lo))
 				vi->z_fragmentoff |= map->m_pa << 32;
-- 
2.43.5



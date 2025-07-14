Return-Path: <linux-kernel+bounces-729684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84926B03A59
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6DDC3A54C5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F48623C516;
	Mon, 14 Jul 2025 09:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vcnU6tIl"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C6423816E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752484159; cv=none; b=jLrf2aPwODj/sdwvIpmwqVR23MsPwb2kVsx3ANmJ23VzM+WZGgOegzAnBTm/eBKhMqR2ZSFv81K1YTEhdKMs2b44hnBWvg2HoVvm5BJiXd/KP6aut6wbahC6n5f3idN0AFTXomW2ySN8DCdxyKw4Vyq8PgZKaDdIYWOX8YvWLLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752484159; c=relaxed/simple;
	bh=n/ZHWAY5iKibAe40NQK08GBUTVBst/Fd3eWeQbW1bA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C5dBvUI/EsY2/lJHO3s1dxLqHxO+AMPcSH6LxlcO1L7J4xiMgklxC2OGLkHyLDSvu++Hnu6KXVU9GzDsztFvz1BpWCzMwxW1nDN89pJb8BnYWn2E+ZBTMnOmunfxC4QLiOgvQ1/MbnQUq/DOZsxOC2QIf19FOsG6t0M+BZv8wW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vcnU6tIl; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752484153; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=6hju1e4Rlp6xKizj0BSYY0eCoMH5DY60nTCownhr7H8=;
	b=vcnU6tIlWyOCzOKYcxt5GJovCtzOCT54CoVO+TZCCKmXFOhWRkdIXqf2gAOWSlPyZaXJvJhskVPjJ7zGJ8G08Tp09piEnGmEbw+IvhwVmqYoD8ICJAiso1mYu69USxG6tCIPGmGXIRdO6yfg2UJlyuLZ7vV/uBJV4V8Hx2IRq7Q=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WissJ6D_1752484148 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Jul 2025 17:09:12 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/2] erofs: remove need_kmap in erofs_read_metabuf()
Date: Mon, 14 Jul 2025 17:09:06 +0800
Message-ID: <20250714090907.4095645-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 - need_kmap is always true except for a ztailpacking case; thus, just
   open-code that one;

 - The upcoming metadata compression will add a new boolean, so simplify
   this first.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c     |  8 ++++----
 fs/erofs/fileio.c   |  2 +-
 fs/erofs/fscache.c  |  2 +-
 fs/erofs/inode.c    |  8 ++++----
 fs/erofs/internal.h |  2 +-
 fs/erofs/super.c    |  4 ++--
 fs/erofs/zdata.c    |  5 +++--
 fs/erofs/zmap.c     | 12 ++++++------
 8 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 16e4a6bd9b97..dd7d86809c18 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -65,10 +65,10 @@ void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
 }
 
 void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
-			 erofs_off_t offset, bool need_kmap)
+			 erofs_off_t offset)
 {
 	erofs_init_metabuf(buf, sb);
-	return erofs_bread(buf, offset, need_kmap);
+	return erofs_bread(buf, offset, true);
 }
 
 int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
@@ -118,7 +118,7 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
 	pos = ALIGN(erofs_iloc(inode) + vi->inode_isize +
 		    vi->xattr_isize, unit) + unit * chunknr;
 
-	idx = erofs_read_metabuf(&buf, sb, pos, true);
+	idx = erofs_read_metabuf(&buf, sb, pos);
 	if (IS_ERR(idx)) {
 		err = PTR_ERR(idx);
 		goto out;
@@ -299,7 +299,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 
 		iomap->type = IOMAP_INLINE;
-		ptr = erofs_read_metabuf(&buf, sb, mdev.m_pa, true);
+		ptr = erofs_read_metabuf(&buf, sb, mdev.m_pa);
 		if (IS_ERR(ptr))
 			return PTR_ERR(ptr);
 		iomap->inline_data = ptr;
diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index 91781718199e..3ee082476c8c 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -115,7 +115,7 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
 			void *src;
 
 			src = erofs_read_metabuf(&buf, inode->i_sb,
-						 map->m_pa + ofs, true);
+						 map->m_pa + ofs);
 			if (IS_ERR(src)) {
 				err = PTR_ERR(src);
 				break;
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 34517ca9df91..9a8ee646e51d 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -274,7 +274,7 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_rq *req)
 		size_t size = map.m_llen;
 		void *src;
 
-		src = erofs_read_metabuf(&buf, sb, map.m_pa, true);
+		src = erofs_read_metabuf(&buf, sb, map.m_pa);
 		if (IS_ERR(src))
 			return PTR_ERR(src);
 
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index a0ae0b4f7b01..47215c5e3385 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -39,10 +39,10 @@ static int erofs_read_inode(struct inode *inode)
 	void *ptr;
 	int err = 0;
 
-	ptr = erofs_read_metabuf(&buf, sb, erofs_pos(sb, blkaddr), true);
+	ptr = erofs_read_metabuf(&buf, sb, erofs_pos(sb, blkaddr));
 	if (IS_ERR(ptr)) {
 		err = PTR_ERR(ptr);
-		erofs_err(sb, "failed to get inode (nid: %llu) page, err %d",
+		erofs_err(sb, "failed to read inode meta block (nid: %llu): %d",
 			  vi->nid, err);
 		goto err_out;
 	}
@@ -78,10 +78,10 @@ static int erofs_read_inode(struct inode *inode)
 
 			memcpy(&copied, dic, gotten);
 			ptr = erofs_read_metabuf(&buf, sb,
-					erofs_pos(sb, blkaddr + 1), true);
+					erofs_pos(sb, blkaddr + 1));
 			if (IS_ERR(ptr)) {
 				err = PTR_ERR(ptr);
-				erofs_err(sb, "failed to get inode payload block (nid: %llu), err %d",
+				erofs_err(sb, "failed to read inode payload block (nid: %llu): %d",
 					  vi->nid, err);
 				goto err_out;
 			}
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 06b867d2fc3b..a7699114f6fe 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -385,7 +385,7 @@ void erofs_put_metabuf(struct erofs_buf *buf);
 void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap);
 void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb);
 void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
-			 erofs_off_t offset, bool need_kmap);
+			 erofs_off_t offset);
 int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *dev);
 int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		 u64 start, u64 len);
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index e1e9f06e8342..bc27fa3bd678 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -141,7 +141,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 	struct erofs_deviceslot *dis;
 	struct file *file;
 
-	dis = erofs_read_metabuf(buf, sb, *pos, true);
+	dis = erofs_read_metabuf(buf, sb, *pos);
 	if (IS_ERR(dis))
 		return PTR_ERR(dis);
 
@@ -258,7 +258,7 @@ static int erofs_read_superblock(struct super_block *sb)
 	void *data;
 	int ret;
 
-	data = erofs_read_metabuf(&buf, sb, 0, true);
+	data = erofs_read_metabuf(&buf, sb, 0);
 	if (IS_ERR(data)) {
 		erofs_err(sb, "cannot read erofs superblock");
 		return PTR_ERR(data);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 5e0240b7b7db..0d1ddd9b15de 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -855,10 +855,11 @@ static int z_erofs_pcluster_begin(struct z_erofs_frontend *fe)
 		/* bind cache first when cached decompression is preferred */
 		z_erofs_bind_cache(fe);
 	} else {
-		ptr = erofs_read_metabuf(&map->buf, sb, map->m_pa, false);
+		erofs_init_metabuf(&map->buf, sb);
+		ptr = erofs_bread(&map->buf, map->m_pa, false);
 		if (IS_ERR(ptr)) {
 			ret = PTR_ERR(ptr);
-			erofs_err(sb, "failed to get inline data %d", ret);
+			erofs_err(sb, "failed to get inline folio %d", ret);
 			return ret;
 		}
 		folio_get(page_folio(map->buf.page));
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 312ec54668aa..ff1d0751fc61 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -31,7 +31,7 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 	struct z_erofs_lcluster_index *di;
 	unsigned int advise;
 
-	di = erofs_read_metabuf(&m->map->buf, inode->i_sb, pos, true);
+	di = erofs_read_metabuf(&m->map->buf, inode->i_sb, pos);
 	if (IS_ERR(di))
 		return PTR_ERR(di);
 	m->lcn = lcn;
@@ -146,7 +146,7 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
 	else
 		return -EOPNOTSUPP;
 
-	in = erofs_read_metabuf(&m->map->buf, m->inode->i_sb, pos, true);
+	in = erofs_read_metabuf(&m->map->buf, m->inode->i_sb, pos);
 	if (IS_ERR(in))
 		return PTR_ERR(in);
 
@@ -530,7 +530,7 @@ static int z_erofs_map_blocks_ext(struct inode *inode,
 	map->m_flags = 0;
 	if (recsz <= offsetof(struct z_erofs_extent, pstart_hi)) {
 		if (recsz <= offsetof(struct z_erofs_extent, pstart_lo)) {
-			ext = erofs_read_metabuf(&map->buf, sb, pos, true);
+			ext = erofs_read_metabuf(&map->buf, sb, pos);
 			if (IS_ERR(ext))
 				return PTR_ERR(ext);
 			pa = le64_to_cpu(*(__le64 *)ext);
@@ -543,7 +543,7 @@ static int z_erofs_map_blocks_ext(struct inode *inode,
 		}
 
 		for (; lstart <= map->m_la; lstart += 1 << vi->z_lclusterbits) {
-			ext = erofs_read_metabuf(&map->buf, sb, pos, true);
+			ext = erofs_read_metabuf(&map->buf, sb, pos);
 			if (IS_ERR(ext))
 				return PTR_ERR(ext);
 			map->m_plen = le32_to_cpu(ext->plen);
@@ -563,7 +563,7 @@ static int z_erofs_map_blocks_ext(struct inode *inode,
 		for (l = 0, r = vi->z_extents; l < r; ) {
 			mid = l + (r - l) / 2;
 			ext = erofs_read_metabuf(&map->buf, sb,
-						 pos + mid * recsz, true);
+						 pos + mid * recsz);
 			if (IS_ERR(ext))
 				return PTR_ERR(ext);
 
@@ -646,7 +646,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		goto out_unlock;
 
 	pos = ALIGN(erofs_iloc(inode) + vi->inode_isize + vi->xattr_isize, 8);
-	h = erofs_read_metabuf(&buf, sb, pos, true);
+	h = erofs_read_metabuf(&buf, sb, pos);
 	if (IS_ERR(h)) {
 		err = PTR_ERR(h);
 		goto out_unlock;
-- 
2.43.5



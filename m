Return-Path: <linux-kernel+bounces-851899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8C7BD7904
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21BFB4F14E2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4582C324D;
	Tue, 14 Oct 2025 06:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaZ6TgJu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800DD2C11F9
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760423232; cv=none; b=DUZI7w3YnWH+ki0Sv2nboLkfudIvGcpXq4ixHGT0qWadJqceZPGPBryhdvMclSyisQ8vNmf2lHIuMY0nVg0CC7HBr7HNNa9WFUNY4FZJ1bfSBNshwYbsV2ErhKVWgZPXzHErRZJNsFNH1h4jUbu9YV4NeXvV0Da9ZuDfLMNayQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760423232; c=relaxed/simple;
	bh=FKeXO7u7xjtZC8nA3BNJBVR9SkDTyf5HtbxaG86K0r4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9/rqwPZ0qrNa8vcDOiAH2FTKa+AEr1PkHIQi4dDT16MEJOIWcgC1BM8yBE9+IBCrO31VTOLwNhlbl6EZ2uEtmX1vsAjfB1AG5vbsmViSigDRYe2FrR0a1xM0nAAQIpxpTF39hQK3sy+kvoYDt1zzvmwo96mkz3YOOV5aGDi8ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaZ6TgJu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7656DC4CEE7;
	Tue, 14 Oct 2025 06:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760423232;
	bh=FKeXO7u7xjtZC8nA3BNJBVR9SkDTyf5HtbxaG86K0r4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KaZ6TgJuTxtTogKbk/smzJmxCkIsq3XoxrF8WBgvZgjmf8aK+VUmnPTUEzUS+V3QJ
	 9AJYg48JwTtrar5fydC/ZebVt86Sl0fAZeYnIxR9JHLxhU7LCDqMBV7LkmTA0FzHH8
	 JexTQEe0D2E9D2utBRlKUawEjYj33omFYqk2IKNZPiv+FdBmjp7Bz46qM5/UOcEakz
	 otFfl0J1zWm5lvHo30IyuKlrSATq1r7LaRKH5mN+qdspIjJoZDqpFpmEfHCZfo2sPQ
	 6OA/ykZZR3mYKC+ExUua4o7MVxRT8vv03FTZ6AeSbyznCWa3xxdB3zGNIHYfP/cEf5
	 GQIACdMci0vhg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 3/4] f2fs: use f2fs_filemap_get_folio() instead of f2fs_pagecache_get_page()
Date: Tue, 14 Oct 2025 14:27:03 +0800
Message-ID: <20251014062704.1734984-3-chao@kernel.org>
X-Mailer: git-send-email 2.51.0.760.g7b8bcc2412-goog
In-Reply-To: <20251014062704.1734984-1-chao@kernel.org>
References: <20251014062704.1734984-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's use f2fs_filemap_get_folio() instead of f2fs_pagecache_get_page() in
ra_data_block() and move_data_block(), then remove f2fs_pagecache_get_page()
since it has no user.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h | 10 ----------
 fs/f2fs/gc.c   | 23 +++++++++++++----------
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b6e35fdd5fd3..9cc3b83b8d10 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2961,16 +2961,6 @@ static inline struct folio *f2fs_filemap_get_folio(
 	return __filemap_get_folio(mapping, index, fgp_flags, gfp_mask);
 }
 
-static inline struct page *f2fs_pagecache_get_page(
-				struct address_space *mapping, pgoff_t index,
-				fgf_t fgp_flags, gfp_t gfp_mask)
-{
-	if (time_to_inject(F2FS_M_SB(mapping), FAULT_PAGE_GET))
-		return NULL;
-
-	return pagecache_get_page(mapping, index, fgp_flags, gfp_mask);
-}
-
 static inline void f2fs_folio_put(struct folio *folio, bool unlock)
 {
 	if (IS_ERR_OR_NULL(folio))
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 8abf521530ff..22fe6e2c6d5c 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1211,7 +1211,7 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
 	struct address_space *mapping = f2fs_is_cow_file(inode) ?
 				F2FS_I(inode)->atomic_inode->i_mapping : inode->i_mapping;
 	struct dnode_of_data dn;
-	struct folio *folio;
+	struct folio *folio, *efolio;
 	struct f2fs_io_info fio = {
 		.sbi = sbi,
 		.ino = inode->i_ino,
@@ -1266,14 +1266,15 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
 
 	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
 
-	fio.encrypted_page = f2fs_pagecache_get_page(META_MAPPING(sbi),
-					dn.data_blkaddr,
+	efolio = f2fs_filemap_get_folio(META_MAPPING(sbi), dn.data_blkaddr,
 					FGP_LOCK | FGP_CREAT, GFP_NOFS);
-	if (!fio.encrypted_page) {
-		err = -ENOMEM;
+	if (IS_ERR(efolio)) {
+		err = PTR_ERR(efolio);
 		goto put_folio;
 	}
 
+	fio.encrypted_page = &efolio->page;
+
 	err = f2fs_submit_page_bio(&fio);
 	if (err)
 		goto put_encrypted_page;
@@ -1313,7 +1314,7 @@ static int move_data_block(struct inode *inode, block_t bidx,
 	struct dnode_of_data dn;
 	struct f2fs_summary sum;
 	struct node_info ni;
-	struct folio *folio, *mfolio;
+	struct folio *folio, *mfolio, *efolio;
 	block_t newaddr;
 	int err = 0;
 	bool lfs_mode = f2fs_lfs_mode(fio.sbi);
@@ -1407,14 +1408,16 @@ static int move_data_block(struct inode *inode, block_t bidx,
 		goto up_out;
 	}
 
-	fio.encrypted_page = f2fs_pagecache_get_page(META_MAPPING(fio.sbi),
-				newaddr, FGP_LOCK | FGP_CREAT, GFP_NOFS);
-	if (!fio.encrypted_page) {
-		err = -ENOMEM;
+	efolio = f2fs_filemap_get_folio(META_MAPPING(fio.sbi), newaddr,
+					FGP_LOCK | FGP_CREAT, GFP_NOFS);
+	if (IS_ERR(efolio)) {
+		err = PTR_ERR(efolio);
 		f2fs_folio_put(mfolio, true);
 		goto recover_block;
 	}
 
+	fio.encrypted_page = &efolio->page;
+
 	/* write target block */
 	f2fs_wait_on_page_writeback(fio.encrypted_page, DATA, true, true);
 	memcpy(page_address(fio.encrypted_page),
-- 
2.49.0



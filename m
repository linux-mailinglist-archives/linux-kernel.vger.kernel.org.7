Return-Path: <linux-kernel+bounces-755983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 341CAB1AE5F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E900D3BB782
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 06:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D828823A562;
	Tue,  5 Aug 2025 06:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+UsNfcl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBD6238C1A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 06:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754375363; cv=none; b=Cs6I/NuDz2urAaNVigZIEsK865RVAEcq1A614eVs0kKz7V0xHEu9UeqGbYal1kKy6TuhWGz8r5HyIXPcP6WroUgEDr7iSpJFhj0cdUvke9S1ZQGge/JDYCdATL0uNtFPBJGh3cz8RIPjeXZWkQnVZpnY5YlFoBTRAK2HBYLetjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754375363; c=relaxed/simple;
	bh=Vb/Dm0dQFvdRHWdK+5sVG86+h2p/gCamzKl892mrR6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cX/7einUgDP+k3N+XoH+A7aoX+kmqUFo+QhWngKkGTdjjRmtsaxxnAURDTczfxiMgcjU8q3+c7gJKw+1HwjyLOSdqMfsZAVVpzk2jRRodFZlCFpM6Aw83YwIULD4+nTrHyK1boM+zQgQyn3B4FaoKvFY+IBwf4ktCmVmz1J6Dqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+UsNfcl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0254C4AF0D;
	Tue,  5 Aug 2025 06:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754375362;
	bh=Vb/Dm0dQFvdRHWdK+5sVG86+h2p/gCamzKl892mrR6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D+UsNfclfl5Wxh/F0HCdm7OiPUTaUri5qTrqt1DalNxK3eX4BW3NlatLVPRMJ3v7j
	 ig1Q/BZC+BX1uirRkc7oJKlZa8cDI2Q7W7Hmxrk7HvHg7+IGS7QWlmEyhGXVcOvhYh
	 IWO1R8szbJoReO1MbU62YRzd86+/6LUywY/i8Kw0rHFb2dzteg8zZiRCDgudUH4YPZ
	 lMU8WSyYkJHqx/kvuzEO02PfAv4t5tBhmGJ+rEYI70LDQCuMesljnJaavNfyz3CJvx
	 pWUVpbVCHshB/LGQLAsWpzw4SsSgrvXi0zcU5BnxypVM2PjZ5WT2H0xuUBegBWpAEh
	 3E0BztPbEO60Q==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v3 3/3] f2fs: clean up f2fs_truncate_partial_cluster()
Date: Tue,  5 Aug 2025 14:29:12 +0800
Message-ID: <20250805062912.3070949-3-chao@kernel.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250805062912.3070949-1-chao@kernel.org>
References: <20250805062912.3070949-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up codes as below:
- avoid unnecessary "err > 0" check condition
- use "1 << log_cluster_size" instead of F2FS_I(inode)->i_cluster_size

No logic changes.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- reorder patch 2 and patch 3
 fs/f2fs/compress.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 72bc05b913af..6ad8d3bc6df7 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1215,9 +1215,11 @@ int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock)
 {
 	void *fsdata = NULL;
 	struct page *pagep;
+	struct page **rpages;
 	int log_cluster_size = F2FS_I(inode)->i_log_cluster_size;
 	pgoff_t start_idx = from >> (PAGE_SHIFT + log_cluster_size) <<
 							log_cluster_size;
+	int i;
 	int err;
 
 	err = f2fs_is_compressed_cluster(inode, start_idx);
@@ -1238,36 +1240,30 @@ int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock)
 	if (err <= 0)
 		return err;
 
-	if (err > 0) {
-		struct page **rpages = fsdata;
-		int cluster_size = F2FS_I(inode)->i_cluster_size;
-		int i;
+	rpages = fsdata;
 
-		for (i = cluster_size - 1; i >= 0; i--) {
-			struct folio *folio = page_folio(rpages[i]);
-			loff_t start = (loff_t)folio->index << PAGE_SHIFT;
-			loff_t offset = from > start ? from - start : 0;
+	for (i = (1 << log_cluster_size) - 1; i >= 0; i--) {
+		struct folio *folio = page_folio(rpages[i]);
+		loff_t start = (loff_t)folio->index << PAGE_SHIFT;
+		loff_t offset = from > start ? from - start : 0;
 
-			folio_zero_segment(folio, offset, folio_size(folio));
+		folio_zero_segment(folio, offset, folio_size(folio));
 
-			if (from >= start)
-				break;
-		}
+		if (from >= start)
+			break;
+	}
 
-		f2fs_compress_write_end(inode, fsdata, start_idx, true);
+	f2fs_compress_write_end(inode, fsdata, start_idx, true);
 
-		err = filemap_write_and_wait_range(inode->i_mapping,
-				round_down(from, cluster_size << PAGE_SHIFT),
-				LLONG_MAX);
-		if (err)
-			return err;
+	err = filemap_write_and_wait_range(inode->i_mapping,
+			round_down(from, 1 << log_cluster_size << PAGE_SHIFT),
+			LLONG_MAX);
+	if (err)
+		return err;
 
-		truncate_pagecache(inode, from);
+	truncate_pagecache(inode, from);
 
-		err = f2fs_do_truncate_blocks(inode,
-				round_up(from, PAGE_SIZE), lock);
-	}
-	return err;
+	return f2fs_do_truncate_blocks(inode, round_up(from, PAGE_SIZE), lock);
 }
 
 static int f2fs_write_compressed_pages(struct compress_ctx *cc,
-- 
2.49.0



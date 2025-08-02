Return-Path: <linux-kernel+bounces-753940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2894B18A67
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 04:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 444C31C27B5F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 02:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9F017B505;
	Sat,  2 Aug 2025 02:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0ULzKrQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B92D149C51
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 02:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754101120; cv=none; b=my7/Ej/75GhE3PI6k4vcqKORjVeoMVIQiJS0NIB8Mqqk6Fb90z2YN4cwo1cfdgDGpc454Jcy2KZd8sg669mvyCWgw4I7m8xvKYyEzYraC0T2+Kzxw2MmmuizuQACdvtDtHNoSPwXVcACuXxjPire55BdIzc2kfQ+uQrVPnzESfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754101120; c=relaxed/simple;
	bh=kaagW9dCMsb7y1ucHeMk+t7TtIVB1BcK8b6ccYWtXKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twXf7wflSt83jLuUht50IYQk5yxv7weZqDEUCvEu6FBkpaVNq9T34yzVnMzZ/SyWpBmlv/i+jIb1fPhV5+jp/N6yD3Yz6kQf+7hYGYk29R6QxSn+1IKN3+K5m4NdlhON2Mr+zBb5Hp8mRtlUBlJj7MKQ200J59jlFE7JZcs1rYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0ULzKrQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17814C4CEEB;
	Sat,  2 Aug 2025 02:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754101120;
	bh=kaagW9dCMsb7y1ucHeMk+t7TtIVB1BcK8b6ccYWtXKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s0ULzKrQMOZ1TiWPi4rX330kc4BLPqMn7LnPzne8TmtVfQRSFTsIjCqKQTPHYsqSv
	 oWe8BuMV1/FwwcN95vEsQAcvAhUaZR6tI3CnvnctRBAdZv3/klbiv8VvFjDdGFXrie
	 gF9SZVg6RPTtx1R6cuxUEVpxyXt/IYvr0p3804wrfafymoRUAjboOQtSvISJRbEu96
	 2aiYXjW+5ryld16DEEDIk4ufP8lWI4YPeDT2wHWZvs0fWo26aoC+zq2/VF6WS+mmwL
	 5d1B6J7shoMboPBYvrsTNVU+uwNRGlT2pQVPJc/zSFhNWiQTSlT3NeAilf/sA2PV71
	 ICrqy+8PKA2Zw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/3] f2fs: clean up f2fs_truncate_partial_cluster()
Date: Sat,  2 Aug 2025 10:18:31 +0800
Message-ID: <20250802021832.1882302-2-chao@kernel.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250802021832.1882302-1-chao@kernel.org>
References: <20250802021832.1882302-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up codes as below:
- avoid unnecessary "err > 0" check condition
- simply if-else condition in the loop
- use "1 << log_cluster_size" instead of F2FS_I(inode)->i_cluster_size

No logic changes.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/compress.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 6cd8902849cf..e37a7ed801e5 100644
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
@@ -1238,26 +1240,21 @@ int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock)
 	if (err <= 0)
 		return err;
 
-	if (err > 0) {
-		struct page **rpages = fsdata;
-		int cluster_size = F2FS_I(inode)->i_cluster_size;
-		int i;
-
-		for (i = cluster_size - 1; i >= 0; i--) {
-			struct folio *folio = page_folio(rpages[i]);
-			loff_t start = (loff_t)folio->index << PAGE_SHIFT;
-
-			if (from <= start) {
-				folio_zero_segment(folio, 0, folio_size(folio));
-			} else {
-				folio_zero_segment(folio, from - start,
-						folio_size(folio));
-				break;
-			}
-		}
+	rpages = fsdata;
+
+	for (i = (1 << log_cluster_size) - 1; i >= 0; i--) {
+		struct folio *folio = page_folio(rpages[i]);
+		loff_t start = (loff_t)folio->index << PAGE_SHIFT;
 
-		f2fs_compress_write_end(inode, fsdata, start_idx, true);
+		if (from > start) {
+			folio_zero_segment(folio, from - start,
+					folio_size(folio));
+			break;
+		}
+		folio_zero_segment(folio, 0, folio_size(folio));
 	}
+
+	f2fs_compress_write_end(inode, fsdata, start_idx, true);
 	return 0;
 }
 
-- 
2.49.0



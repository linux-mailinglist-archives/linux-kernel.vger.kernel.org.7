Return-Path: <linux-kernel+bounces-754603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5897FB199F7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 03:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091411895AA7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 01:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3A71FC0EA;
	Mon,  4 Aug 2025 01:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wj9/VBmW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA78B1F55FA
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 01:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754271831; cv=none; b=MEcvZzzbbZ9bf9FiRe7Ybf9DPK/F/yKL0GXLQ9NlAvEmhV/koDBeCEO/yFho7xX9joaEe8Zf4QoKqzL6Rijt+RqkIVVJ5SsinxmhR2LmM8E0jbSdKqI+kZSY/VBAjPANKno1BStyY85HBjjMaF4QM7T5Hvt1/YkmhN1oOKxqUJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754271831; c=relaxed/simple;
	bh=kaagW9dCMsb7y1ucHeMk+t7TtIVB1BcK8b6ccYWtXKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1DsWFgw5QyGvFr5u0Y5MuUWNyMjxY5dBeLqeUQ3F6fK1jTASPM1DZCCheNAUDzVzh94djBKgh4s+Vcya4SZkexORm3G0D7uqz85GrFval9FH/OhvCLGJNxIC08zej889jl52r4iJZeNB7MXss+epAku+rJM4i2O9pRpAgSgmHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wj9/VBmW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40131C4CEEB;
	Mon,  4 Aug 2025 01:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754271831;
	bh=kaagW9dCMsb7y1ucHeMk+t7TtIVB1BcK8b6ccYWtXKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wj9/VBmW6pgYO07LM2+g+xm61XPEJQLpgHEl6j8yNi8h1HEXtJGOhUd6aq51Mq55e
	 K6S06Gf5PI7FZDo7TXqQXOn5I8HolnzHIsqZwQwVAKt29nokoPyz/ernPKWHGoWEzp
	 GuM0Ow3BBBjOM0pm77mhv9YuFr3OSW5Dgf4RQVUg/aHlYDeJnNo1qBky2Qats5mgZZ
	 QNqxnG0cVwrVLBESic3h9bpJVqu2y0nBDomPHHVaHi9xsw9lpXqfhVBi5EpX0MmNpY
	 otGle+jHYc1e188voKNaKuL+f24kFHlLadwVjNmvXSdembqd+5umc68Q7FiVFN7GeN
	 idc3zfBFaKVug==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2 2/3] f2fs: clean up f2fs_truncate_partial_cluster()
Date: Mon,  4 Aug 2025 09:43:38 +0800
Message-ID: <20250804014340.2537172-2-chao@kernel.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250804014340.2537172-1-chao@kernel.org>
References: <20250804014340.2537172-1-chao@kernel.org>
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



Return-Path: <linux-kernel+bounces-725123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8978CAFFB0A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9725679E0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B85A28A1D3;
	Thu, 10 Jul 2025 07:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igEJIall"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B485289E26
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752132994; cv=none; b=fPSANL7ynQyAqg7+0qFJjgwsuzphXjcCZGcVg2r+IM+lqX8QrxJ+S3I2UVjS65rVQErV0oL7gYGs0tT0hePd8ed0cepogNrVMmR+Mx0+nJIO/ossArkKYTz2Ve/mnecVKdecgd5S+0WPzqpb9/X4JSw4gdVmbe7MrVVGt6jA6ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752132994; c=relaxed/simple;
	bh=EyfNAvh03CoAn/icz+i7RWD8ZeXI4bLQ/a7yMcGGBy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5q+NX0ohGx6qOP1h27zUO62y4n7ZQ0Np9yNIaEIDaJddTltOAY2P7OxpnZlq7cOqpYSStmNbzXAroo52c36hmoPS/EK3xddUA6R077mcW62mXnrVj+2AmFTRs3HuEYap4cM2EmTc1A6Qo3369KKvR8xzw/Jg8t1STcr5d9/DTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igEJIall; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCE9C4CEF5;
	Thu, 10 Jul 2025 07:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752132993;
	bh=EyfNAvh03CoAn/icz+i7RWD8ZeXI4bLQ/a7yMcGGBy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=igEJIallJCrdIn96SU3cVYajFQXJCQuXtKrVSyO2h5y6VvcUn/vg41J7bdrQX4FAD
	 8Acf0wMNYtwxilaLBlrNYyOEydp9u2nl3UbSF3eqCJFuQPkvj5UUHZhuKn1GJ8Z26u
	 zkUH+/9OpqRENbtE1bgdLEEQLHSgZ0Kp8bcuUlhM9i0AZF8tour+G/qvMZTriRKTWb
	 mny/0Knc4KawiHib5ND0ee8tBPu97Yw77WQujh9FkwGNq7EltHrmKN1DZapmiL97Xv
	 rO1lx6jlslt6EOleeN05QGSi+LuUpjIPy6PRVkcBftGRHkzJHL5Z4jCoZ6RSM8zkWd
	 f4s/RaQYyboNA==
From: Chao Yu <chao@kernel.org>
To: xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] erofs: support to readahead dirent blocks in erofs_readdir()
Date: Thu, 10 Jul 2025 15:36:19 +0800
Message-ID: <20250710073619.4083422-2-chao@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250710073619.4083422-1-chao@kernel.org>
References: <20250710073619.4083422-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch supports to readahead more blocks in erofs_readdir(),
it can enhance performance in large direcotry.

readdir test in a large directory which contains 12000 sub-files.

		files_per_second
Before:		926385.54
After:		2380435.562

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/erofs/dir.c      | 8 ++++++++
 fs/erofs/internal.h | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index cff61c5a172b..04113851fc0f 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -47,8 +47,10 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 	struct inode *dir = file_inode(f);
 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	struct super_block *sb = dir->i_sb;
+	struct file_ra_state *ra = &f->f_ra;
 	unsigned long bsz = sb->s_blocksize;
 	unsigned int ofs = erofs_blkoff(sb, ctx->pos);
+	unsigned long nr_pages = DIV_ROUND_UP_POW2(dir->i_size, PAGE_SIZE);
 	int err = 0;
 	bool initial = true;
 
@@ -65,6 +67,12 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 		}
 		cond_resched();
 
+		/* readahead blocks to enhance performance in large directory */
+		if (nr_pages - dbstart > 1 && !ra_has_index(ra, dbstart))
+			page_cache_sync_readahead(dir->i_mapping, ra, f,
+				dbstart, min(nr_pages - dbstart,
+				(pgoff_t)MAX_DIR_RA_PAGES));
+
 		de = erofs_bread(&buf, dbstart, true);
 		if (IS_ERR(de)) {
 			erofs_err(sb, "failed to readdir of logical block %llu of nid %llu",
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index a32c03a80c70..ef9d1ee8c688 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -238,6 +238,9 @@ EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
 #define EROFS_I_BL_XATTR_BIT	(BITS_PER_LONG - 1)
 #define EROFS_I_BL_Z_BIT	(BITS_PER_LONG - 2)
 
+/* maximum readahead pages of directory */
+#define MAX_DIR_RA_PAGES	4
+
 struct erofs_inode {
 	erofs_nid_t nid;
 
-- 
2.49.0



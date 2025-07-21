Return-Path: <linux-kernel+bounces-738552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A73B0B9EE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 04:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22031888EF4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 02:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B651DA10B;
	Mon, 21 Jul 2025 02:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hN63Xhh9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAE312B93
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 02:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753064049; cv=none; b=k+yuyzei97r+NdLQB1KxpXkrtizLj5danu+7/jttsNgECavyARMy/YZbP8FqeLs9iUNvwXKIKxmfU0Owy3px/XnunGmLCeRNkGrvzsHRm3QOLGG2WJCeb3Iiwm7lGDHSFt2Ks/EYEALD58s4CZaNuzyjAhQCK7d6XsZqe2cjeXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753064049; c=relaxed/simple;
	bh=bXdrSCzVGyERWLaj+SxFuNiWIdAvQDaET3Ilr8mDXME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jRgUBg2n7oOOF9YykdjB5MxOgc0dLSfQtbOiKMo/JUE1ZgRjnnbVmW2+mXdu3tGYOLFbDKXp8EFsaEo/b5rICXHEMe1SnR26gObHXLVGVaH8dnCoX/zh344Bk2RA2rP1COcRsV2Q4lp0NmF9ghYwVrftzTcyjhWeuDYEHynWoB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hN63Xhh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A9FC4CEE7;
	Mon, 21 Jul 2025 02:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753064049;
	bh=bXdrSCzVGyERWLaj+SxFuNiWIdAvQDaET3Ilr8mDXME=;
	h=From:To:Cc:Subject:Date:From;
	b=hN63Xhh9JT+U1GvHxt65UyY7zvku4uKdxAQbtNBBsa7VcwvlIhS591PS3ph6gJksB
	 YJ1gG0Wd6XyGIHMJgKcRCBx1KH3Kn42L/iunnlGiA+wHcjya/vR4SAL+/LsZnxksvu
	 V0nT3Dx1Qg7erFFv2QF9+ltnBUPfPTY89pmHIHHffTOB01dUxtxiljw+ZOuYWzvsk6
	 XOpBJNOCjVLAWsYGNmtQHe/IN857NaeDfF32zPAb7JayiKi9acVqY196mP1eJG1HVu
	 QPySSZH1kKVo8VReU03vWwp44sFfuD5ptQ+eCJnGsXsbXPFYz6/qYdcLwc85BjwQ4J
	 b5b6IAuzuocKA==
From: Chao Yu <chao@kernel.org>
To: xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v4] erofs: support to readahead dirent blocks in erofs_readdir()
Date: Mon, 21 Jul 2025 10:13:52 +0800
Message-ID: <20250721021352.2495371-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch supports to readahead more blocks in erofs_readdir(), it can
enhance readdir performance in large direcotry.

readdir test in a large directory which contains 12000 sub-files.

		files_per_second
Before:		926385.54
After:		2380435.562

Meanwhile, let's introduces a new sysfs entry to control readahead
bytes to provide more flexible policy for readahead of readdir().
- location: /sys/fs/erofs/<disk>/dir_ra_bytes
- default value: 16384
- disable readahead: set the value to 0

Signed-off-by: Chao Yu <chao@kernel.org>
---
v4:
- clean up codes and comments
 Documentation/ABI/testing/sysfs-fs-erofs |  8 ++++++++
 fs/erofs/dir.c                           | 14 ++++++++++++++
 fs/erofs/internal.h                      |  4 ++++
 fs/erofs/super.c                         |  2 ++
 fs/erofs/sysfs.c                         |  2 ++
 5 files changed, 30 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
index bf3b6299c15e..85fa56ca092c 100644
--- a/Documentation/ABI/testing/sysfs-fs-erofs
+++ b/Documentation/ABI/testing/sysfs-fs-erofs
@@ -35,3 +35,11 @@ Description:	Used to set or show hardware accelerators in effect
 		and multiple accelerators are separated by '\n'.
 		Supported accelerator(s): qat_deflate.
 		Disable all accelerators with an empty string (echo > accel).
+
+What:		/sys/fs/erofs/<disk>/dir_ra_bytes
+Date:		July 2025
+Contact:	"Chao Yu" <chao@kernel.org>
+Description:	Used to set or show readahead bytes during readdir(), by
+		default the value is 16384.
+
+		- 0: disable readahead.
diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index 3e4b38bec0aa..99745c272b60 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -47,8 +47,12 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 	struct inode *dir = file_inode(f);
 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	struct super_block *sb = dir->i_sb;
+	struct file_ra_state *ra = &f->f_ra;
 	unsigned long bsz = sb->s_blocksize;
 	unsigned int ofs = erofs_blkoff(sb, ctx->pos);
+	pgoff_t ra_pages = DIV_ROUND_UP_POW2(
+			EROFS_I_SB(dir)->dir_ra_bytes, PAGE_SIZE);
+	pgoff_t nr_pages = DIV_ROUND_UP_POW2(dir->i_size, PAGE_SIZE);
 	int err = 0;
 	bool initial = true;
 
@@ -63,6 +67,16 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 			break;
 		}
 
+		/* readahead blocks to enhance performance in large directory */
+		if (ra_pages) {
+			pgoff_t idx = DIV_ROUND_UP(ctx->pos, PAGE_SIZE);
+			pgoff_t pages = min(nr_pages - idx, ra_pages);
+
+			if (pages > 1 && !ra_has_index(ra, idx))
+				page_cache_sync_readahead(dir->i_mapping, ra,
+							f, idx, pages);
+		}
+
 		de = erofs_bread(&buf, dbstart, true);
 		if (IS_ERR(de)) {
 			erofs_err(sb, "failed to readdir of logical block %llu of nid %llu",
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 0d19bde8c094..8b1372521790 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -157,6 +157,7 @@ struct erofs_sb_info {
 	/* sysfs support */
 	struct kobject s_kobj;		/* /sys/fs/erofs/<devname> */
 	struct completion s_kobj_unregister;
+	erofs_off_t dir_ra_bytes;
 
 	/* fscache support */
 	struct fscache_volume *volume;
@@ -238,6 +239,9 @@ EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
 #define EROFS_I_BL_XATTR_BIT	(BITS_PER_LONG - 1)
 #define EROFS_I_BL_Z_BIT	(BITS_PER_LONG - 2)
 
+/* default readahead size of directories */
+#define EROFS_DIR_RA_BYTES	16384
+
 struct erofs_inode {
 	erofs_nid_t nid;
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index e1e9f06e8342..38fc4813a896 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -715,6 +715,8 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		return err;
 
+	sbi->dir_ra_bytes = EROFS_DIR_RA_BYTES;
+
 	erofs_info(sb, "mounted with root inode @ nid %llu.", sbi->root_nid);
 	return 0;
 }
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index eed8797a193f..9d9f820a5621 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -65,12 +65,14 @@ EROFS_ATTR_FUNC(drop_caches, 0200);
 #ifdef CONFIG_EROFS_FS_ZIP_ACCEL
 EROFS_ATTR_FUNC(accel, 0644);
 #endif
+EROFS_ATTR_RW_UI(dir_ra_bytes, erofs_sb_info);
 
 static struct attribute *erofs_sb_attrs[] = {
 #ifdef CONFIG_EROFS_FS_ZIP
 	ATTR_LIST(sync_decompress),
 	ATTR_LIST(drop_caches),
 #endif
+	ATTR_LIST(dir_ra_bytes),
 	NULL,
 };
 ATTRIBUTE_GROUPS(erofs_sb);
-- 
2.49.0



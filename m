Return-Path: <linux-kernel+bounces-786465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A0AB35A2A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2676B189095C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B20F2FF176;
	Tue, 26 Aug 2025 10:39:42 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E285120B22
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 10:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756204782; cv=none; b=Jj7Ua3iwwcpOWHdyEuSM1PXVEvtjZ0bvVD5rKjPNJKBcU0e0LKC+/6+uZW9w9nDD4uuAzJrF4jw1CCKXTcLcbveJDqdz1FrBi4iit3GFKR1ta10eeENv39pSNmQHc2qG2sBguxoVgvnbICILbFHZ4spt6LWUBNPpcx8aukgxj7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756204782; c=relaxed/simple;
	bh=94FpHnOJO/xTpAm5TN/xDeTv//UxhMoa6IgsDty9zss=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K1C4bOUQxqu2uWffI8PCaE9NrN4kciTMr8LMB60GyvHBOP41V2SCDH7yrIjNlJFFBTl5MhUJBVwW2IADrYGiYPQRVsL7Opza7a2zvrqWq/pWoD3mZg0NqPjEvKJM+GnlR4E3vkDNyRCpG2cOSgxLIE+OWX8PCQ1osXBO5ZU24sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201601.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202508261839287025;
        Tue, 26 Aug 2025 18:39:28 +0800
Received: from localhost.localdomain (10.94.6.48) by
 jtjnmail201601.home.langchao.com (10.100.2.1) with Microsoft SMTP Server id
 15.1.2507.57; Tue, 26 Aug 2025 18:39:30 +0800
From: Bo Liu <liubo03@inspur.com>
To: <xiang@kernel.org>, <chao@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH v2] erofs: Add support for FS_IOC_GETFSLABEL
Date: Tue, 26 Aug 2025 06:39:26 -0400
Message-ID: <20250826103926.4424-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
tUid: 202582618392863bbf128605b82da469d21ea9f0abba2
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

From: Bo Liu (OpenAnolis) <liubo03@inspur.com>

Add support for reading to the erofs volume label from the
FS_IOC_GETFSLABEL ioctls.

Signed-off-by: Bo Liu (OpenAnolis) <liubo03@inspur.com>
---

v1: https://lore.kernel.org/linux-erofs/63904ade56634923ba734dcdab3c45d0@inspur.com/T/#t
Changes since v1:
- use erofs_file_fops instead
- change volume_label to volume_name

 fs/erofs/Makefile   |  2 +-
 fs/erofs/data.c     | 26 +++++++++++++++++++++++---
 fs/erofs/dir.c      |  4 ++++
 fs/erofs/inode.c    |  5 +----
 fs/erofs/internal.h |  7 +++++++
 fs/erofs/ioctl.c    | 41 +++++++++++++++++++++++++++++++++++++++++
 fs/erofs/super.c    |  8 ++++++++
 7 files changed, 85 insertions(+), 8 deletions(-)
 create mode 100644 fs/erofs/ioctl.c

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 549abc424763..5be6cc4acc1c 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 obj-$(CONFIG_EROFS_FS) += erofs.o
-erofs-objs := super.o inode.o data.o namei.o dir.o sysfs.o
+erofs-objs := super.o inode.o data.o namei.o dir.o sysfs.o ioctl.o
 erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
 erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o zutil.o
 erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 3b1ba571c728..048051aa5fba 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -391,6 +391,13 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
 
+	if (erofs_inode_is_data_compressed(EROFS_I(inode)->datalayout))
+#ifdef CONFIG_EROFS_FS_ZIP
+		return generic_file_read_iter(iocb, to);
+#else
+		return -EIO;
+#endif
+
 	/* no need taking (shared) inode lock since it's a ro filesystem */
 	if (!iov_iter_count(to))
 		return 0;
@@ -434,7 +441,16 @@ static const struct vm_operations_struct erofs_dax_vm_ops = {
 
 static int erofs_file_mmap_prepare(struct vm_area_desc *desc)
 {
-	if (!IS_DAX(file_inode(desc->file)))
+	struct inode *inode = file_inode(desc->file);
+
+	if (erofs_inode_is_data_compressed(EROFS_I(inode)->datalayout))
+#ifdef CONFIG_EROFS_FS_ZIP
+		return generic_file_readonly_mmap_prepare(desc);
+#else
+		return -EOPNOTSUPP;
+#endif
+
+	if (!IS_DAX(inode))
 		return generic_file_readonly_mmap_prepare(desc);
 
 	if ((desc->vm_flags & VM_SHARED) && (desc->vm_flags & VM_MAYWRITE))
@@ -455,9 +471,9 @@ static loff_t erofs_file_llseek(struct file *file, loff_t offset, int whence)
 
 	if (erofs_inode_is_data_compressed(EROFS_I(inode)->datalayout))
 #ifdef CONFIG_EROFS_FS_ZIP
-		ops = &z_erofs_iomap_report_ops;
-#else
 		return generic_file_llseek(file, offset, whence);
+#else
+		ops = &z_erofs_iomap_report_ops;
 #endif
 
 	if (whence == SEEK_HOLE)
@@ -475,6 +491,10 @@ static loff_t erofs_file_llseek(struct file *file, loff_t offset, int whence)
 const struct file_operations erofs_file_fops = {
 	.llseek		= erofs_file_llseek,
 	.read_iter	= erofs_file_read_iter,
+	.unlocked_ioctl = erofs_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl   = erofs_compat_ioctl,
+#endif
 	.mmap_prepare	= erofs_file_mmap_prepare,
 	.get_unmapped_area = thp_get_unmapped_area,
 	.splice_read	= filemap_splice_read,
diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index debf469ad6bd..32b4f5aa60c9 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -123,4 +123,8 @@ const struct file_operations erofs_dir_fops = {
 	.llseek		= generic_file_llseek,
 	.read		= generic_read_dir,
 	.iterate_shared	= erofs_readdir,
+	.unlocked_ioctl = erofs_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl   = erofs_compat_ioctl,
+#endif
 };
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 9a2f59721522..a7ec17eec4b2 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -213,10 +213,7 @@ static int erofs_fill_inode(struct inode *inode)
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFREG:
 		inode->i_op = &erofs_generic_iops;
-		if (erofs_inode_is_data_compressed(vi->datalayout))
-			inode->i_fop = &generic_ro_fops;
-		else
-			inode->i_fop = &erofs_file_fops;
+		inode->i_fop = &erofs_file_fops;
 		break;
 	case S_IFDIR:
 		inode->i_op = &erofs_dir_iops;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4ccc5f0ee8df..311346a017a7 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -166,6 +166,9 @@ struct erofs_sb_info {
 	struct erofs_domain *domain;
 	char *fsid;
 	char *domain_id;
+
+	/* volume name */
+	char *volume_name;
 };
 
 #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
@@ -535,6 +538,10 @@ static inline struct bio *erofs_fscache_bio_alloc(struct erofs_map_dev *mdev) {
 static inline void erofs_fscache_submit_bio(struct bio *bio) {}
 #endif
 
+long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
+long erofs_compat_ioctl(struct file *filp, unsigned int cmd,
+			unsigned long arg);
+
 #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
 
 #endif	/* __EROFS_INTERNAL_H */
diff --git a/fs/erofs/ioctl.c b/fs/erofs/ioctl.c
new file mode 100644
index 000000000000..fbcbf820c4d7
--- /dev/null
+++ b/fs/erofs/ioctl.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/fs.h>
+#include <linux/compat.h>
+#include <linux/file.h>
+
+#include "internal.h"
+
+static int erofs_ioctl_get_volume_label(struct inode *inode, void __user *arg)
+{
+	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
+	int ret;
+
+	if (!sbi->volume_name)
+		ret = clear_user(arg, 1);
+	else
+		ret = copy_to_user(arg, sbi->volume_name,
+				   strlen(sbi->volume_name));
+
+	return ret ? -EFAULT : 0;
+}
+
+long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	void __user *argp = (void __user *)arg;
+
+	switch (cmd) {
+	case FS_IOC_GETFSLABEL:
+		return erofs_ioctl_get_volume_label(inode, argp);
+	default:
+		return -ENOTTY;
+	}
+}
+
+#ifdef CONFIG_COMPAT
+long erofs_compat_ioctl(struct file *filp, unsigned int cmd,
+			unsigned long arg)
+{
+	return erofs_ioctl(filp, cmd, (unsigned long)compat_ptr(arg));
+}
+#endif
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 1b529ace4db0..6ca30889b07d 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -343,6 +343,13 @@ static int erofs_read_superblock(struct super_block *sb)
 	sbi->fixed_nsec = le32_to_cpu(dsb->fixed_nsec);
 	super_set_uuid(sb, (void *)dsb->uuid, sizeof(dsb->uuid));
 
+	if (dsb->volume_name[0]) {
+		sbi->volume_name = kstrndup(dsb->volume_name,
+					    strlen(dsb->volume_name), GFP_KERNEL);
+		if (!sbi->volume_name)
+			return -ENOMEM;
+	}
+
 	/* parse on-disk compression configurations */
 	ret = z_erofs_parse_cfgs(sb, dsb);
 	if (ret < 0)
@@ -822,6 +829,7 @@ static void erofs_sb_free(struct erofs_sb_info *sbi)
 	kfree(sbi->domain_id);
 	if (sbi->dif0.file)
 		fput(sbi->dif0.file);
+	kfree(sbi->volume_name);
 	kfree(sbi);
 }
 
-- 
2.31.1



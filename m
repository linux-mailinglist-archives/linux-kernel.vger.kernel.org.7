Return-Path: <linux-kernel+bounces-862725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A479EBF5FDD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998CC18C8919
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EDF2F361A;
	Tue, 21 Oct 2025 11:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Q7u3xP+e"
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAB02F2603
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761045482; cv=none; b=o8Be2sC/H0iuodfNPjixRepnfn8QqNTGabocbIgSIt8EzMLCe9Kn3kTmWoVv3pI6LH2x84RiSppMjjI5JbAB/LT31e/sANq+9uBEG/p+LPaOPCUiXPjseEEg4cICQo0tzWlLkafjtYHmQorWLi4HJZa21ZreBt+cAZpNfg+fmkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761045482; c=relaxed/simple;
	bh=ZYvoAl0sRHnijm6GN2cHxE8OKKohFQQy3T+gkIOGs6U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FXo3nVl184VRhSQhaQL8v0NJ4QXaZUahycJTd4vzqVPoVdgsdItZeO+3vEJzCxzBLqvFEK9EteHpn3Dt/T53mjTyfrurA3koOpk6IaQkgtz8hRuXAL/XSHxSIXMj7lwMhZzTqoORwwV56tnwsLJz8mDXk7Xp3wIU9C8dJWRHGIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Q7u3xP+e; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from canpmsgout07.his.huawei.com (unknown [172.19.92.160])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4crThg0pdZzTh5t
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:54:59 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=BFZfK/0YEQSEtzV8IiT0VSkhYfjw4vZsWKJaCKfBT2g=;
	b=Q7u3xP+ePgjovL7GhSaB+3IoAuz0C5D15GorwS1Yy3Ehlgm7qMmyeK1hp9fb+W5ka2igmPaYk
	Yu961IQe1GNU8GjXkxnGuBfdbr3zyJdvBqutkXVe30Y4rdWssRtJx4VEYrHzoF6RoUAiyfvtWeL
	fxTxrXn63TG0Q0Htnc3cvBI=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4crTnV2bcdzLlVc;
	Tue, 21 Oct 2025 18:59:10 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C0F51A0188;
	Tue, 21 Oct 2025 18:59:34 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 21 Oct
 2025 18:59:33 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<hongzhen@linux.alibaba.com>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH RFC v7 4/7] erofs: introduce the page cache share feature
Date: Tue, 21 Oct 2025 10:48:12 +0000
Message-ID: <20251021104815.70662-5-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251021104815.70662-1-lihongbo22@huawei.com>
References: <20251021104815.70662-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500015.china.huawei.com (7.202.195.162)

From: Hongzhen Luo <hongzhen@linux.alibaba.com>

Currently, reading files with different paths (or names) but the same
content will consume multiple copies of the page cache, even if the
content of these page caches is the same. For example, reading
identical files (e.g., *.so files) from two different minor versions of
container images will cost multiple copies of the same page cache,
since different containers have different mount points. Therefore,
sharing the page cache for files with the same content can save memory.

This introduces the page cache share feature in erofs. It allocate a
deduplicated inode and use its page cache as shared. Reads for files
with identical content will ultimately be routed to the page cache of
the deduplicated inode. In this way, a single page cache satisfies
multiple read requests for different files with the same contents.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
[hongbo: forward port,  minor fixes and cleanup]
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/Makefile   |   1 +
 fs/erofs/internal.h |  25 +++++
 fs/erofs/ishare.c   | 236 ++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/ishare.h   |  28 ++++++
 fs/erofs/super.c    |  30 +++++-
 fs/erofs/xattr.c    |  14 +--
 6 files changed, 326 insertions(+), 8 deletions(-)
 create mode 100644 fs/erofs/ishare.c
 create mode 100644 fs/erofs/ishare.h

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 549abc424763..102a23bf5dec 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -10,3 +10,4 @@ erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
 erofs-$(CONFIG_EROFS_FS_ZIP_ACCEL) += decompressor_crypto.o
 erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
 erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
+erofs-$(CONFIG_EROFS_FS_INODE_SHARE) += ishare.o
\ No newline at end of file
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 245b9e3897bc..158bda6ba784 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -199,6 +199,14 @@ static inline bool erofs_is_fscache_mode(struct super_block *sb)
 			!erofs_is_fileio_mode(EROFS_SB(sb)) && !sb->s_bdev;
 }
 
+extern struct file_system_type erofs_anon_fs_type;
+
+static inline bool erofs_is_ishare_inode(struct inode *inode)
+{
+	return !erofs_is_fscache_mode(inode->i_sb) &&
+		inode->i_sb->s_type == &erofs_anon_fs_type;
+}
+
 enum {
 	EROFS_ZIP_CACHE_DISABLED,
 	EROFS_ZIP_CACHE_READAHEAD,
@@ -306,6 +314,22 @@ struct erofs_inode {
 		};
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	};
+#ifdef CONFIG_EROFS_FS_INODE_SHARE
+	union {
+		/* internal dedup inode */
+		struct {
+			char *fingerprint;
+			spinlock_t lock;
+			/* all backing inodes */
+			struct list_head backing_head;
+		};
+
+		struct {
+			struct inode *ishare;
+			struct list_head backing_link;
+		};
+	};
+#endif
 	/* the corresponding vfs inode */
 	struct inode vfs_inode;
 };
@@ -412,6 +436,7 @@ extern const struct inode_operations erofs_dir_iops;
 
 extern const struct file_operations erofs_file_fops;
 extern const struct file_operations erofs_dir_fops;
+extern const struct file_operations erofs_ishare_fops;
 
 extern const struct iomap_ops z_erofs_iomap_report_ops;
 
diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
new file mode 100644
index 000000000000..910b732bf8e7
--- /dev/null
+++ b/fs/erofs/ishare.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024, Alibaba Cloud
+ */
+#include <linux/xxhash.h>
+#include <linux/refcount.h>
+#include <linux/mount.h>
+#include <linux/mutex.h>
+#include <linux/ramfs.h>
+#include "ishare.h"
+#include "internal.h"
+#include "xattr.h"
+
+static DEFINE_MUTEX(erofs_ishare_lock);
+static struct vfsmount *erofs_ishare_mnt;
+static refcount_t erofs_ishare_supers;
+
+int erofs_ishare_init(struct super_block *sb)
+{
+	struct vfsmount *mnt = NULL;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+
+	if (!sbi->ishare_key)
+		return 0;
+
+	mutex_lock(&erofs_ishare_lock);
+	if (erofs_ishare_mnt) {
+		refcount_inc(&erofs_ishare_supers);
+	} else {
+		mnt = kern_mount(&erofs_anon_fs_type);
+		if (!IS_ERR(mnt)) {
+			erofs_ishare_mnt = mnt;
+			refcount_set(&erofs_ishare_supers, 1);
+		}
+	}
+	mutex_unlock(&erofs_ishare_lock);
+	return IS_ERR(mnt) ? PTR_ERR(mnt) : 0;
+}
+
+void erofs_ishare_exit(struct super_block *sb)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	struct vfsmount *tmp;
+
+	if (!sbi->ishare_key || !erofs_ishare_mnt)
+		return;
+
+	mutex_lock(&erofs_ishare_lock);
+	if (refcount_dec_and_test(&erofs_ishare_supers)) {
+		tmp = erofs_ishare_mnt;
+		erofs_ishare_mnt = NULL;
+		mutex_unlock(&erofs_ishare_lock);
+		kern_unmount(tmp);
+		mutex_lock(&erofs_ishare_lock);
+	}
+	mutex_unlock(&erofs_ishare_lock);
+	kfree(sbi->ishare_key);
+	sbi->ishare_key = NULL;
+}
+
+static int erofs_ishare_iget5_eq(struct inode *inode, void *data)
+{
+	struct erofs_inode *vi = EROFS_I(inode);
+
+	return vi->fingerprint && memcmp(vi->fingerprint, data,
+			sizeof(size_t) + *(size_t *)data) == 0;
+}
+
+static int erofs_ishare_iget5_set(struct inode *inode, void *data)
+{
+	struct erofs_inode *vi = EROFS_I(inode);
+
+	vi->fingerprint = data;
+	INIT_LIST_HEAD(&vi->backing_head);
+	spin_lock_init(&vi->lock);
+	return 0;
+}
+
+bool erofs_ishare_fill_inode(struct inode *inode)
+{
+	struct erofs_inode *vi = EROFS_I(inode);
+	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
+	struct inode *idedup;
+	/*
+	 * fingerprint layout:
+	 * fingerprint length + fingerprint content (xattr_value + domain_id)
+	 */
+	char *ishare_key = sbi->ishare_key, *fingerprint;
+	ssize_t ishare_vlen;
+	unsigned long hash;
+	int key_idx;
+
+	if (!sbi->domain_id || !ishare_key)
+		return false;
+
+	key_idx = sbi->ishare_key_idx;
+	ishare_vlen = erofs_getxattr(inode, key_idx, ishare_key, NULL, 0);
+	if (ishare_vlen <= 0 || ishare_vlen > (1 << sbi->blkszbits))
+		return false;
+
+	fingerprint = kmalloc(sizeof(ssize_t) + ishare_vlen +
+			      strlen(sbi->domain_id), GFP_KERNEL);
+	if (!fingerprint)
+		return false;
+
+	*(ssize_t *)fingerprint = ishare_vlen + strlen(sbi->domain_id);
+	if (ishare_vlen != erofs_getxattr(inode, key_idx, ishare_key,
+					  fingerprint + sizeof(ssize_t),
+					  ishare_vlen)) {
+		kfree(fingerprint);
+		return false;
+	}
+
+	memcpy(fingerprint + sizeof(ssize_t) + ishare_vlen,
+	       sbi->domain_id, strlen(sbi->domain_id));
+	hash = xxh32(fingerprint + sizeof(ssize_t),
+		     ishare_vlen + strlen(sbi->domain_id), hash);
+	idedup = iget5_locked(erofs_ishare_mnt->mnt_sb, hash,
+			      erofs_ishare_iget5_eq, erofs_ishare_iget5_set,
+			      fingerprint);
+	if (!idedup) {
+		kfree(fingerprint);
+		return false;
+	}
+
+	INIT_LIST_HEAD(&vi->backing_link);
+	vi->ishare = idedup;
+	spin_lock(&EROFS_I(idedup)->lock);
+	list_add(&vi->backing_link, &EROFS_I(idedup)->backing_head);
+	spin_unlock(&EROFS_I(idedup)->lock);
+
+	if (!(idedup->i_state & I_NEW)) {
+		kfree(fingerprint);
+		return true;
+	}
+
+	if (erofs_inode_is_data_compressed(vi->datalayout))
+		idedup->i_mapping->a_ops = &z_erofs_aops;
+	else
+		idedup->i_mapping->a_ops = &erofs_aops;
+	idedup->i_mode = vi->vfs_inode.i_mode;
+	i_size_write(idedup, vi->vfs_inode.i_size);
+	unlock_new_inode(idedup);
+	return true;
+}
+
+void erofs_ishare_free_inode(struct inode *inode)
+{
+	struct erofs_inode *vi = EROFS_I(inode);
+	struct inode *idedup = vi->ishare;
+
+	if (!idedup)
+		return;
+
+	spin_lock(&EROFS_I(idedup)->lock);
+	list_del(&vi->backing_link);
+	spin_unlock(&EROFS_I(idedup)->lock);
+	iput(idedup);
+	vi->ishare = NULL;
+}
+
+static int erofs_ishare_file_open(struct inode *inode, struct file *file)
+{
+	struct file *realfile;
+	struct inode *dedup;
+
+	dedup = EROFS_I(inode)->ishare;
+	if (!dedup)
+		return -EINVAL;
+
+	realfile = alloc_file_pseudo(dedup, erofs_ishare_mnt, "erofs_ishare_file",
+				     O_RDONLY, &erofs_file_fops);
+	if (IS_ERR(realfile))
+		return PTR_ERR(realfile);
+
+	file_ra_state_init(&realfile->f_ra, file->f_mapping);
+	realfile->private_data = EROFS_I(inode);
+	file->private_data = realfile;
+	return 0;
+}
+
+static int erofs_ishare_file_release(struct inode *inode, struct file *file)
+{
+	struct file *realfile = file->private_data;
+
+	if (!realfile)
+		return -EINVAL;
+	fput(realfile);
+	realfile->private_data = NULL;
+	return 0;
+}
+
+static ssize_t erofs_ishare_file_read_iter(struct kiocb *iocb,
+						    struct iov_iter *to)
+{
+	struct file *realfile = iocb->ki_filp->private_data;
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct kiocb dedup_iocb;
+	ssize_t nread;
+
+	if (!realfile)
+		return -EINVAL;
+	if (!iov_iter_count(to))
+		return 0;
+
+	/* fallback to the original file in DAX or DIRECT mode */
+	if (IS_DAX(inode) || (iocb->ki_flags & IOCB_DIRECT))
+		realfile = iocb->ki_filp;
+
+	kiocb_clone(&dedup_iocb, iocb, realfile);
+	nread = filemap_read(&dedup_iocb, to, 0);
+	iocb->ki_pos = dedup_iocb.ki_pos;
+	touch_atime(&iocb->ki_filp->f_path);
+	return nread;
+}
+
+static int erofs_ishare_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct file *realfile = file->private_data;
+
+	if (!realfile)
+		return -EINVAL;
+
+	vma_set_file(vma, realfile);
+	return generic_file_readonly_mmap(file, vma);
+}
+
+const struct file_operations erofs_ishare_fops = {
+	.open		= erofs_ishare_file_open,
+	.llseek		= generic_file_llseek,
+	.read_iter	= erofs_ishare_file_read_iter,
+	.mmap		= erofs_ishare_mmap,
+	.release	= erofs_ishare_file_release,
+	.get_unmapped_area = thp_get_unmapped_area,
+	.splice_read	= filemap_splice_read,
+};
diff --git a/fs/erofs/ishare.h b/fs/erofs/ishare.h
new file mode 100644
index 000000000000..54f2251c8179
--- /dev/null
+++ b/fs/erofs/ishare.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024, Alibaba Cloud
+ */
+#ifndef __EROFS_ISHARE_H
+#define __EROFS_ISHARE_H
+
+#include <linux/fs.h>
+#include <linux/spinlock.h>
+#include "internal.h"
+
+#ifdef CONFIG_EROFS_FS_INODE_SHARE
+
+int erofs_ishare_init(struct super_block *sb);
+void erofs_ishare_exit(struct super_block *sb);
+bool erofs_ishare_fill_inode(struct inode *inode);
+void erofs_ishare_free_inode(struct inode *inode);
+
+#else
+
+static inline int erofs_ishare_init(struct super_block *sb) { return 0; }
+static inline void erofs_ishare_exit(struct super_block *sb) {}
+static inline bool erofs_ishare_fill_inode(struct inode *inode) { return false; }
+static inline void erofs_ishare_free_inode(struct inode *inode) {}
+
+#endif // CONFIG_EROFS_FS_INODE_SHARE
+
+#endif
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 93cc24542405..f067633c0072 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -13,6 +13,7 @@
 #include <linux/backing-dev.h>
 #include <linux/pseudo_fs.h>
 #include "xattr.h"
+#include "ishare.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/erofs.h>
@@ -77,10 +78,25 @@ static struct inode *erofs_alloc_inode(struct super_block *sb)
 	return &vi->vfs_inode;
 }
 
+#ifdef CONFIG_EROFS_FS_INODE_SHARE
+static void erofs_free_dedup_inode(struct erofs_inode *vi)
+{
+	kfree(vi->fingerprint);
+	kmem_cache_free(erofs_inode_cachep, vi);
+};
+#else
+static void erofs_free_dedup_inode(struct erofs_inode *vi)
+{}
+#endif
+
 static void erofs_free_inode(struct inode *inode)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
 
+	if (erofs_is_ishare_inode(inode)) {
+		erofs_free_dedup_inode(vi);
+		return;
+	}
 	if (inode->i_op == &erofs_fast_symlink_iops)
 		kfree(inode->i_link);
 	kfree(vi->xattr_shared_xattrs);
@@ -924,9 +940,21 @@ static struct file_system_type erofs_fs_type = {
 };
 MODULE_ALIAS_FS("erofs");
 
+static const struct super_operations erofs_anon_sops = {
+	.statfs = simple_statfs,
+	.alloc_inode = erofs_alloc_inode,
+	.free_inode = erofs_free_inode,
+};
+
 static int erofs_anon_init_fs_context(struct fs_context *fc)
 {
-	return init_pseudo(fc, EROFS_SUPER_MAGIC) ? 0 : -ENOMEM;
+	struct pseudo_fs_context *ctx;
+
+	ctx = init_pseudo(fc, EROFS_SUPER_MAGIC);
+	if (ctx)
+		ctx->ops = &erofs_anon_sops;
+
+	return ctx ? 0 : -ENOMEM;
 }
 
 struct file_system_type erofs_anon_fs_type = {
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 6610c007ee4c..4b39db939135 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -571,6 +571,7 @@ void erofs_xattr_set_ishare_key(struct super_block *sb)
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	struct xattr_handler const *handler;
+	bool found = false;
 	erofs_off_t pos;
 	char *key;
 	int len, i;
@@ -582,28 +583,27 @@ void erofs_xattr_set_ishare_key(struct super_block *sb)
 
 	buf.mapping = sbi->packed_inode->i_mapping;
 	pos = sbi->ishare_key_start << 2;
-	(void)erofs_init_metabuf(&buf, sb, false);
 	ptr = erofs_read_metadata(sb, &buf, &pos, &len);
 
 	if (IS_ERR(ptr))
 		goto out;
 
-	for (i = 0; ARRAY_SIZE(erofs_xattr_handlers) - 1; i++) {
+	for (i = 0; ARRAY_SIZE(erofs_xattr_handlers); i++) {
 		handler = erofs_xattr_handlers[i];
 		if (!handler)
+			continue;
+		if (!memcmp(handler->prefix, ptr, strlen(handler->prefix))) {
+			found = true;
 			break;
-		if (!memcmp(handler->prefix, ptr, strlen(handler->prefix)))
-			break;
+		}
 	}
 
-	if (!handler)
+	if (!found)
 		goto out;
-
 	len -= strlen(handler->prefix);
 	key = kzalloc(len + 1, GFP_KERNEL);
 	if (!key)
 		goto out;
-
 	memcpy(key, ptr + strlen(handler->prefix), len);
 	sbi->ishare_key = key;
 	sbi->ishare_key_idx = handler->flags;
-- 
2.22.0



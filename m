Return-Path: <linux-kernel+bounces-874678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6270C16D62
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C19224E2BDB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF2F350A17;
	Tue, 28 Oct 2025 21:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="cYM02BSe"
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5288E34F498
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761685207; cv=none; b=Hj0xRjWxdXVX7LOuv0PJKmZjew/ie00FBwhru2eEJ0soY298bDJGqgFVd1eXRxVt90CSA41UvZYMB29U8zILk7UvuaQhhZsrVMBq1196LwfDUTh5gFPrtzOxITWDgS5wVshoYiJYMqdUccvJi+Q58i7SBO/50jYSDzsYkNLqc7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761685207; c=relaxed/simple;
	bh=haO62HY7g3Y3li2nzdiOAIA18zm4c9H4mVPNM46hp24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qshNK0hiQ0RvjWiZ1Z0S/MD24Oy7umB7gDXCDtvT3I25i8/RuD8+cd/SItOHwW6a+ual7stlvLnNGo/fBwb3kAq/2Vqja4vTOgw4U0yy84VvcNsqoi1foj3TkpaEPsh6C0WkcAQkNDrHZIMeut1dkiu1dLxNNmfV+ZxEb45UTIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=cYM02BSe; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: f5583d8b-b440-11f0-84a0-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id f5583d8b-b440-11f0-84a0-005056abad63;
	Tue, 28 Oct 2025 21:59:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=pH2TFgTn6/J2bBxJjQCiygjfMnxONmo9yOZe4v2bZTI=;
	b=cYM02BSe3x7fDcWB+u5Ps47O2+EArcPhvYaHIooCExAa3azIOxlb4InRJ8wYJQgmjTykqropfj8mG
	 kO1+jn8FjW0cCpAtIg4SbLnIbAgTi+DVZ6QKqtmurBlGlum8p1Mw8TsgR8F1G6GNVCO0P+GGCJR0gF
	 LJ+q0FuDdqd7fiaACaFuzKKiv/ZCwWwgm/ppph6iMD37fpY447YuU+7OLJS6YczivDSrmjgD46a4M3
	 h6mXP4fiylTFeaLDakSHkHY2MkqN9SspWw/Y9lO5SlWJ+H+fHNjvSR3nzwVExgpT6BeawIGbF0ua8p
	 7HPGCnk02rgjh1t88BBtD2IE2F7AviA==
X-KPN-MID: 33|g+VRnRkT5wnLeWpMLtCCN5KxrYfbXPSQO3dMdqhHmWWbhxs2caM4m2Dc1mrYii+
 nFymvAUGRm092FiO4z6KGpoDAd78vmgQ4V/4KKAoruNQ=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|rYq3TUzMnsEQA64Xe0oC7fQTW0ZGsvnD3rMts1qeuK82FT4VgOsq9hkXJTVi1g7
 v6gRgqdDM+sSzVFG28Rw1Cg==
Received: from daedalus.home (unknown [178.231.9.54])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id e7f95c13-b440-11f0-bd9d-005056ab1411;
	Tue, 28 Oct 2025 21:58:52 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Taotao Chen <chentaotao@didiglobal.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Cc: jkoolstra@xs4all.nl,
	linux-kernel@vger.kernel.org,
	syzbot+4e49728ec1cbaf3b91d2@syzkaller.appspotmail.com
Subject: [PATCH] Add error handling to minix filesystem similar to ext4
Date: Tue, 28 Oct 2025 21:58:57 +0100
Message-ID: <20251028205857.386719-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch sets up generic handling of errors such as filesystem
corruption which are frequently raised by syzbot. Towards this aim it
adds the following mount options to the minix filesystem: errors=
continue/panic/remount-ro and (no)warn-on-error, with semantics
similar to ext4fs. When a minix_error() or minix_error_inode() is
raised, the error is reported and action is taken according to which of
these mount options is set (errors=continue,nowarn-on-error are the
default).

As an examle, this patch fixes a drop_nlink warning in rmdir exposed by
syzbot, originating from a corrupted nlink field of a directory.

The changes were tested using the syzbot reproducer with the various new
mount options. I also handcrafted a similar corrupted fs but with the
minix v3 format (the reproducer uses v1).

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
Reported-by: syzbot+4e49728ec1cbaf3b91d2@syzkaller.appspotmail.com
Closes: https://syzbot.org/bug?extid=4e49728ec1cbaf3b91d2
---
 fs/minix/inode.c        | 237 ++++++++++++++++++++++++++++++++++++----
 fs/minix/itree_common.c |   2 +-
 fs/minix/minix.h        |  43 ++++++++
 fs/minix/namei.c        |  25 +++--
 4 files changed, 275 insertions(+), 32 deletions(-)

diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index 32db676127a9..62159b7526a2 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -21,10 +21,16 @@
 #include <linux/vfs.h>
 #include <linux/writeback.h>
 #include <linux/fs_context.h>
+#include <linux/fs_parser.h>
+#include <linux/fsnotify.h>
 
 static int minix_write_inode(struct inode *inode,
-		struct writeback_control *wbc);
+			     struct writeback_control *wbc);
 static int minix_statfs(struct dentry *dentry, struct kstatfs *buf);
+static int minix_init_fs_context(struct fs_context *fc);
+static void minix_handle_error(struct super_block *sb, int error,
+			       const char *func, unsigned int line);
+static bool system_going_down(void);
 
 static void minix_evict_inode(struct inode *inode)
 {
@@ -113,17 +119,121 @@ static const struct super_operations minix_sops = {
 	.statfs		= minix_statfs,
 };
 
+void __minix_error(struct super_block *sb, const char *function,
+		   unsigned int line, int error, const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
+	printk(KERN_CRIT "minix-fs error (device %s): %s:%d: comm %s: %pV\n",
+	       sb->s_id, function, line, current->comm, &vaf);
+	va_end(args);
+
+	fsnotify_sb_error(sb, NULL, error ? error : EFSCORRUPTED);
+
+	minix_handle_error(sb, error, function, line);
+}
+
+void __minix_error_inode(struct inode *inode, const char *function,
+			 unsigned int line, int error, u32 block,
+			 const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
+	if (block)
+		printk(KERN_CRIT "minix-fs error (device %s): %s:%d: "
+		       "inode #%lu: block %du: comm %s: %pV\n",
+		       inode->i_sb->s_id, function, line, inode->i_ino,
+		       block, current->comm, &vaf);
+	else
+		printk(KERN_CRIT "minix-fs error (device %s): %s:%d: "
+		       "inode #%lu: comm %s: %pV\n",
+		       inode->i_sb->s_id, function, line, inode->i_ino,
+		       current->comm, &vaf);
+	va_end(args);
+
+	fsnotify_sb_error(inode->i_sb, NULL, error ? error : EFSCORRUPTED);
+
+	minix_handle_error(inode->i_sb, error, function, line);
+}
+
+static void minix_handle_error(struct super_block *sb, int error,
+			       const char *func, unsigned int line)
+{
+	struct minix_sb_info *sbi = minix_sb(sb);
+
+	if (sbi->s_version != MINIX_V3) {
+		sbi->s_mount_state |= MINIX_ERROR_FS;
+		mark_buffer_dirty(sbi->s_sbh);
+	}
+
+	if (test_opt(sb, WARN_ON_ERROR))
+		WARN_ON_ONCE(1);
+
+	/* Do not panic during 'reboot -f' */
+	if (test_opt(sb, ERRORS_PANIC) && !system_going_down()) {
+		panic("minix-fs (device %s): panic forced after error\n",
+		      sb->s_id);
+	}
+
+	if (test_opt(sb, ERRORS_CONT) || sb_rdonly(sb))
+		return;
+
+	minix_msg(sb, KERN_CRIT, "Remounting filesystem read-only");
+
+	sb->s_flags |= SB_RDONLY;
+}
+
+void __minix_msg(struct super_block *sb,
+		 const char *prefix, const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
+	if (sb)
+		printk("%sminix-fs (%s): %pV\n", prefix, sb->s_id, &vaf);
+	else
+		printk("%sminix-fs: %pV\n", prefix, &vaf);
+	va_end(args);
+}
+
+static bool system_going_down(void)
+{
+	return system_state == SYSTEM_HALT || system_state == SYSTEM_POWER_OFF
+		|| system_state == SYSTEM_RESTART;
+}
+
+struct minix_fs_context {
+	unsigned int s_mount_opt;
+	unsigned int s_def_mount_opt;
+};
+
 static int minix_reconfigure(struct fs_context *fc)
 {
-	struct minix_super_block * ms;
+	struct minix_fs_context *ctx = fc->fs_private;
 	struct super_block *sb = fc->root->d_sb;
-	struct minix_sb_info * sbi = sb->s_fs_info;
+	unsigned int flags = fc->sb_flags;
+	struct minix_sb_info *sbi = minix_sb(sb);
+	struct minix_super_block *ms;
+
+	sbi->s_mount_opt = ctx->s_mount_opt;
 
 	sync_filesystem(sb);
 	ms = sbi->s_ms;
-	if ((bool)(fc->sb_flags & SB_RDONLY) == sb_rdonly(sb))
+
+	if ((bool)(flags & SB_RDONLY) == sb_rdonly(sb))
 		return 0;
-	if (fc->sb_flags & SB_RDONLY) {
+	if (flags & SB_RDONLY) {
 		if (ms->s_state & MINIX_VALID_FS ||
 		    !(sbi->s_mount_state & MINIX_VALID_FS))
 			return 0;
@@ -172,6 +282,7 @@ static bool minix_check_superblock(struct super_block *sb)
 
 static int minix_fill_super(struct super_block *s, struct fs_context *fc)
 {
+	struct minix_fs_context *ctx = fc->fs_private;
 	struct buffer_head *bh;
 	struct buffer_head **map;
 	struct minix_super_block *ms;
@@ -198,6 +309,8 @@ static int minix_fill_super(struct super_block *s, struct fs_context *fc)
 
 	ms = (struct minix_super_block *) bh->b_data;
 	sbi->s_ms = ms;
+	sbi->s_mount_opt = ctx->s_mount_opt;
+	sbi->s_def_mount_opt = ctx->s_def_mount_opt;
 	sbi->s_sbh = bh;
 	sbi->s_mount_state = ms->s_state;
 	sbi->s_ninodes = ms->s_ninodes;
@@ -226,7 +339,7 @@ static int minix_fill_super(struct super_block *s, struct fs_context *fc)
 		s->s_max_links = MINIX2_LINK_MAX;
 	} else if (s->s_magic == MINIX2_SUPER_MAGIC2) {
 		sbi->s_version = MINIX_V2;
-		sbi->s_nzones = ms->s_zones;
+	sbi->s_nzones = ms->s_zones;
 		sbi->s_dirsize = 32;
 		sbi->s_namelen = 30;
 		s->s_max_links = MINIX2_LINK_MAX;
@@ -367,8 +480,8 @@ static int minix_fill_super(struct super_block *s, struct fs_context *fc)
 out_bad_sb:
 	printk("MINIX-fs: unable to read superblock\n");
 out:
-	s->s_fs_info = NULL;
 	kfree(sbi);
+	fc->s_fs_info = NULL;
 	return ret;
 }
 
@@ -377,18 +490,6 @@ static int minix_get_tree(struct fs_context *fc)
 	 return get_tree_bdev(fc, minix_fill_super);
 }
 
-static const struct fs_context_operations minix_context_ops = {
-	.get_tree	= minix_get_tree,
-	.reconfigure	= minix_reconfigure,
-};
-
-static int minix_init_fs_context(struct fs_context *fc)
-{
-	fc->ops = &minix_context_ops;
-
-	return 0;
-}
-
 static int minix_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct super_block *sb = dentry->d_sb;
@@ -518,11 +619,15 @@ static struct inode *V1_minix_iget(struct inode *inode)
 		return ERR_PTR(-EIO);
 	}
 	if (raw_inode->i_nlinks == 0) {
-		printk("MINIX-fs: deleted inode referenced: %lu\n",
-		       inode->i_ino);
+		minix_error_inode(inode, "deleted inode referenced");
 		brelse(bh);
 		iget_failed(inode);
 		return ERR_PTR(-ESTALE);
+	} else if (S_ISDIR(raw_inode->i_mode) && raw_inode->i_nlinks == 1) {
+		minix_error_inode(inode, "directory inode has corrupted nlink");
+		brelse(bh);
+		iget_failed(inode);
+		return ERR_PTR(-EFSCORRUPTED);
 	}
 	inode->i_mode = raw_inode->i_mode;
 	i_uid_write(inode, raw_inode->i_uid);
@@ -556,11 +661,15 @@ static struct inode *V2_minix_iget(struct inode *inode)
 		return ERR_PTR(-EIO);
 	}
 	if (raw_inode->i_nlinks == 0) {
-		printk("MINIX-fs: deleted inode referenced: %lu\n",
-		       inode->i_ino);
+		minix_error_inode(inode, "deleted inode referenced");
 		brelse(bh);
 		iget_failed(inode);
 		return ERR_PTR(-ESTALE);
+	} else if (S_ISDIR(raw_inode->i_mode) && raw_inode->i_nlinks == 1) {
+		minix_error_inode(inode, "directory inode has corrupted nlink");
+		brelse(bh);
+		iget_failed(inode);
+		return ERR_PTR(-EFSCORRUPTED);
 	}
 	inode->i_mode = raw_inode->i_mode;
 	i_uid_write(inode, raw_inode->i_uid);
@@ -705,13 +814,95 @@ void minix_truncate(struct inode * inode)
 		V2_minix_truncate(inode);
 }
 
+enum {
+	Opt_errors, Opt_warn_on_error, Opt_nowarn_on_error
+};
+
+static const struct constant_table minix_param_errors[] = {
+	{"continue",	MINIX_MOUNT_ERRORS_CONT},
+	{"panic",	MINIX_MOUNT_ERRORS_PANIC},
+	{"remount-ro",	MINIX_MOUNT_ERRORS_RO},
+	{}
+};
+
+/*
+ * Mount option specification
+ */
+static const struct fs_parameter_spec minix_param_specs[] = {
+	fsparam_enum	("errors",		Opt_errors, minix_param_errors),
+	fsparam_flag	("warn-on-error",	Opt_warn_on_error),
+	fsparam_flag	("nowarn-on-error",	Opt_nowarn_on_error),
+	{}
+};
+
+static int minix_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct minix_fs_context *ctx = fc->fs_private;
+	struct fs_parse_result result;
+
+	int token;
+
+	token = fs_parse(fc, minix_param_specs, param, &result);
+	if (token < 0)
+		return token;
+
+	switch (token) {
+	case Opt_errors:
+		ctx->s_mount_opt &= ~MINIX_MOUNT_ERRORS_MASK;
+		ctx->s_mount_opt |= result.uint_32;
+		break;
+	case Opt_warn_on_error:
+		ctx->s_mount_opt |= MINIX_MOUNT_WARN_ON_ERROR;
+		break;
+	case Opt_nowarn_on_error:
+		ctx->s_mount_opt &= ~MINIX_MOUNT_WARN_ON_ERROR;
+		break;
+	}
+	return 0;
+}
+
+static void minix_fc_free(struct fs_context *fc)
+{
+	struct minix_fs_context *ctx = fc->fs_private;
+
+	if (!ctx)
+		return;
+	kfree(ctx);
+}
+
+static const struct fs_context_operations minix_context_ops = {
+	.get_tree	= minix_get_tree,
+	.reconfigure	= minix_reconfigure,
+	.parse_param	= minix_parse_param,
+	.free		= minix_fc_free,
+};
+
+int minix_init_fs_context(struct fs_context *fc)
+{
+	struct minix_fs_context *ctx;
+
+	ctx = kzalloc(sizeof(struct minix_fs_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	fc->fs_private = ctx;
+	fc->ops = &minix_context_ops;
+
+	ctx->s_def_mount_opt |= MINIX_MOUNT_ERRORS_DEF;
+	ctx->s_mount_opt = ctx->s_def_mount_opt;
+
+	return 0;
+}
+
 static struct file_system_type minix_fs_type = {
 	.owner			= THIS_MODULE,
 	.name			= "minix",
 	.kill_sb		= kill_block_super,
 	.fs_flags		= FS_REQUIRES_DEV,
 	.init_fs_context	= minix_init_fs_context,
+	.parameters		= minix_param_specs,
 };
+
 MODULE_ALIAS_FS("minix");
 
 static int __init init_minix_fs(void)
diff --git a/fs/minix/itree_common.c b/fs/minix/itree_common.c
index dad131e30c05..6832c671125e 100644
--- a/fs/minix/itree_common.c
+++ b/fs/minix/itree_common.c
@@ -188,7 +188,7 @@ static int get_block(struct inode * inode, sector_t block,
 	/*
 	 * Indirect block might be removed by truncate while we were
 	 * reading it. Handling of that case (forget what we've got and
-	 * reread) is taken out of the main path.
+	 * reread) is taken out of the msb_breadain path.
 	 */
 	if (err == -EAGAIN)
 		goto changed;
diff --git a/fs/minix/minix.h b/fs/minix/minix.h
index d54273c3c9ff..254220ffbf39 100644
--- a/fs/minix/minix.h
+++ b/fs/minix/minix.h
@@ -11,6 +11,22 @@
 #define MINIX_V2		0x0002		/* minix V2 fs */
 #define MINIX_V3		0x0003		/* minix V3 fs */
 
+#define MINIX_MOUNT_ERRORS_CONT		0x00001	/* Continue on errors */
+#define MINIX_MOUNT_ERRORS_RO		0x00002	/* Remount fs ro on errors */
+#define MINIX_MOUNT_ERRORS_PANIC	0x00004	/* Panic on errors */
+#define MINIX_MOUNT_WARN_ON_ERROR	0x00008 /* Trigger WARN_ON on error */
+
+#define MINIX_MOUNT_ERRORS_MASK		0x00007
+
+#define MINIX_MOUNT_ERRORS_DEF		MINIX_MOUNT_ERRORS_CONT
+
+#define clear_opt(sb, opt)		minix_sb(sb)->s_mount_opt &= \
+						~MINIX_MOUNT_##opt
+#define set_opt(sb, opt)		minix_sb(sb)->s_mount_opt |= \
+						MINIX_MOUNT_##opt
+#define test_opt(sb, opt)		(minix_sb(sb)->s_mount_opt & \
+						MINIX_MOUNT_##opt)
+
 /*
  * minix fs inode data in memory
  */
@@ -39,6 +55,8 @@ struct minix_sb_info {
 	struct buffer_head * s_sbh;
 	struct minix_super_block * s_ms;
 	unsigned short s_mount_state;
+	unsigned short s_mount_opt;
+	unsigned short s_def_mount_opt;
 	unsigned short s_version;
 };
 
@@ -55,6 +73,13 @@ int minix_getattr(struct mnt_idmap *, const struct path *,
 		struct kstat *, u32, unsigned int);
 int minix_prepare_chunk(struct folio *folio, loff_t pos, unsigned len);
 
+extern __printf(3, 4)
+void __minix_msg(struct super_block *, const char *, const char *, ...);
+void __minix_error(struct super_block *, const char *, unsigned int, int,
+		   const char *, ...);
+void __minix_error_inode(struct inode *, const char *, unsigned int, int, u32,
+			 const char *, ...);
+
 extern void V1_minix_truncate(struct inode *);
 extern void V2_minix_truncate(struct inode *);
 extern void minix_truncate(struct inode *);
@@ -168,4 +193,22 @@ static inline int minix_test_bit(int nr, const void *vaddr)
 
 #endif
 
+#define minix_error(sb, fmt, ...)						\
+	__minix_error((sb), __func__, __LINE__, 0, (fmt), ##__VA_ARGS__)
+#define minix_error_err(sb, err, fmt, ...)					\
+	__minix_error((sb), __func__, __LINE__, (err), (fmt), ##__VA_ARGS__)
+#define minix_error_inode(inode, fmt, ...)					\
+	__minix_error_inode((inode), __func__, __LINE__, 0, 0,			\
+			    (fmt), ##__VA_ARGS__)
+#define minix_error_inode_err(inode, err, fmt, ...)				\
+	__minix_error_inode((inode), __func__, __LINE__, (err), 0,		\
+			    (fmt), ##__VA_ARGS__)
+#define minix_error_inode_block(inode, block, err, fmt, ...)			\
+	__minix_error_inode((inode), __func__, __LINE__, (err), (block),	\
+			    (fmt), ##__VA_ARGS__)
+#define minix_msg(sb, level, fmt, ...)				\
+	__minix_msg(sb, level, fmt, ##__VA_ARGS__)
+
+#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
+
 #endif /* FS_MINIX_H */
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 8938536d8d3c..23f98f44e262 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -161,15 +161,24 @@ static int minix_unlink(struct inode * dir, struct dentry *dentry)
 static int minix_rmdir(struct inode * dir, struct dentry *dentry)
 {
 	struct inode * inode = d_inode(dentry);
-	int err = -ENOTEMPTY;
-
-	if (minix_empty_dir(inode)) {
-		err = minix_unlink(dir, dentry);
-		if (!err) {
-			inode_dec_link_count(dir);
-			inode_dec_link_count(inode);
-		}
+	int err = -EFSCORRUPTED;
+
+	if (dir->i_nlink <= 2) {
+		minix_error_inode(inode, "directory inode has corrupted nlink");
+		goto out;
 	}
+
+	err = -ENOTEMPTY;
+	if (!minix_empty_dir(inode))
+		goto out;
+
+	err = minix_unlink(dir, dentry);
+	if (!err) {
+		inode_dec_link_count(dir);
+		inode_dec_link_count(inode);
+ 	}
+
+out:
 	return err;
 }
 
-- 
2.51.1.dirty



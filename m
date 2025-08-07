Return-Path: <linux-kernel+bounces-758605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E3FB1D14E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 05:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEAB85804D2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 03:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271451CDFD5;
	Thu,  7 Aug 2025 03:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJMINS3b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA0E3208
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 03:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754538547; cv=none; b=gmRP5B8FyZK+FmYNBn3CjZ34i4LKy8L1WeTJ73NMQYcF4Kos0DJx7qgSS1JnXa4jDPIWPy0lOJMM9DT2nNb3udTBxPWQHB4Ns+0Uc4Nef8DVL9wRVbjXGw+R5uVBrcDWXPWVP6Cf88eLGGsfG/0PvEPOWGrBv9mm644hF38DTDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754538547; c=relaxed/simple;
	bh=SbpUgiLSvOk5VbTy5pMfwtfuSKiO5V83JTSvH4O/kIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LyKvjoyEyUkDbXqzgmBQqoFYzjzjF+F1sKkqUQ585md8FBjzD5wlrqZjUj5OwrhAfaTfh/WPHdFPK7yKJUFHkA6DUYyY98V1Qb40pQScquUQUOKHdLH0s+dV6l+pGM5ARv1kbb2EokG2/rCQ0c8ED220Jn5VXWfdoa+izTu17I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJMINS3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81997C4CEEB;
	Thu,  7 Aug 2025 03:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754538547;
	bh=SbpUgiLSvOk5VbTy5pMfwtfuSKiO5V83JTSvH4O/kIw=;
	h=From:To:Cc:Subject:Date:From;
	b=KJMINS3bie/RxRGwQq252u+wpXE5WZEuaTW3a7ep0vtgj80c/AEPLDttD8tfz+a22
	 n5f6LX8qwn9UEarOv8JKja3Dir8eV50DLKqEvUulj3TKu2xqIwXf3h9ewTccStAJi3
	 0MroHDSykUDV/84xHg6GuvMlm4vue2Vy0oMmZKU9jqs3JJVNhkoSbDmjaFWwoGHBKj
	 q1x44agwYruzf6xNcf3ec82S/+r8vGM6RtGJZWeeNZWOncwDMqsukQZB1zcqOEIEtG
	 k4M4s5rqi9P02SeLHFrAaaYWJ8BVzxFSxY/1QZKAcUwg5hPnrh6d3GVbZF4jJ2utMq
	 rg1zFvoyYELqQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v3] f2fs: introduce flush_policy sysfs entry
Date: Thu,  7 Aug 2025 11:48:38 +0800
Message-ID: <20250807034838.3829794-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces a new sysfs entry /sys/fs/f2fs/<disk>/flush_policy
in order to tune performance of f2fs data flush flow.

For example, checkpoint will use REQ_FUA to persist CP metadata, however,
some kind device has bad performance on REQ_FUA command, result in that
checkpoint being blocked for long time, w/ this sysfs entry, we can give
an option to use REQ_PREFLUSH command instead of REQ_FUA during checkpoint,
it can help to mitigate long latency of checkpoint.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- export f2fs_submit_flush_wait()
 Documentation/ABI/testing/sysfs-fs-f2fs |  9 +++++++++
 fs/f2fs/checkpoint.c                    | 11 ++++++++++-
 fs/f2fs/f2fs.h                          |  9 +++++++++
 fs/f2fs/segment.c                       |  8 ++++----
 fs/f2fs/sysfs.c                         |  9 +++++++++
 5 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index bc0e7fefc39d..2fedb44b713b 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -883,3 +883,12 @@ Date:		June 2025
 Contact:	"Daeho Jeong" <daehojeong@google.com>
 Description:	Control GC algorithm for boost GC. 0: cost benefit, 1: greedy
 		Default: 1
+
+What:		/sys/fs/f2fs/<disk>/flush_policy
+Date:		July 2025
+Contact:	"Chao Yu" <chao@kernel.org>
+Description:	Device has different performance for the same flush methods, this node
+		can be used to tune performance by setting different flush methods.
+
+		policy value		description
+		0x00000001		Use preflush instead of fua during checkpoint
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index db3831f7f2f5..2450e382fe6b 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1419,7 +1419,9 @@ static void commit_checkpoint(struct f2fs_sb_info *sbi,
 	f2fs_folio_put(folio, false);
 
 	/* submit checkpoint (with barrier if NOBARRIER is not set) */
-	f2fs_submit_merged_write(sbi, META_FLUSH);
+	f2fs_submit_merged_write(sbi,
+		sbi->flush_policy & BIT(FLUSH_POLICY_CP_NO_FUA) ?
+		META : META_FLUSH);
 }
 
 static inline u64 get_sectors_written(struct block_device *bdev)
@@ -1594,6 +1596,13 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	__set_cp_next_pack(sbi);
 
+	/* flush device cache to make sure last cp pack can be persisted */
+	if (sbi->flush_policy & BIT(FLUSH_POLICY_CP_NO_FUA)) {
+		err = f2fs_submit_flush_wait(sbi, sbi->sb->s_bdev);
+		if (err)
+			return err;
+	}
+
 	/*
 	 * redirty superblock if metadata like node page or inode cache is
 	 * updated during writing checkpoint.
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 46be7560548c..e7b866a98c92 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1594,6 +1594,11 @@ struct decompress_io_ctx {
 #define MAX_COMPRESS_LOG_SIZE		8
 #define MAX_COMPRESS_WINDOW_SIZE(log_size)	((PAGE_SIZE) << (log_size))
 
+enum flush_policy {
+	FLUSH_POLICY_CP_NO_FUA,
+	FLUSH_POLICY_MAX,
+};
+
 struct f2fs_sb_info {
 	struct super_block *sb;			/* pointer to VFS super block */
 	struct proc_dir_entry *s_proc;		/* proc entry */
@@ -1845,6 +1850,8 @@ struct f2fs_sb_info {
 	/* carve out reserved_blocks from total blocks */
 	bool carve_out;
 
+	unsigned int flush_policy;		/* flush policy */
+
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	struct kmem_cache *page_array_slab;	/* page array entry */
 	unsigned int page_array_slab_size;	/* default page array slab size */
@@ -3821,6 +3828,8 @@ int f2fs_commit_atomic_write(struct inode *inode);
 void f2fs_abort_atomic_write(struct inode *inode, bool clean);
 void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need);
 void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi, bool from_bg);
+int f2fs_submit_flush_wait(struct f2fs_sb_info *sbi,
+				struct block_device *bdev);
 int f2fs_issue_flush(struct f2fs_sb_info *sbi, nid_t ino);
 int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi);
 int f2fs_flush_device_cache(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index cc82d42ef14c..d68c903f1ad3 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -544,7 +544,7 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi, bool from_bg)
 	f2fs_sync_fs(sbi->sb, 1);
 }
 
-static int __submit_flush_wait(struct f2fs_sb_info *sbi,
+int f2fs_submit_flush_wait(struct f2fs_sb_info *sbi,
 				struct block_device *bdev)
 {
 	int ret = blkdev_issue_flush(bdev);
@@ -562,12 +562,12 @@ static int submit_flush_wait(struct f2fs_sb_info *sbi, nid_t ino)
 	int i;
 
 	if (!f2fs_is_multi_device(sbi))
-		return __submit_flush_wait(sbi, sbi->sb->s_bdev);
+		return f2fs_submit_flush_wait(sbi, sbi->sb->s_bdev);
 
 	for (i = 0; i < sbi->s_ndevs; i++) {
 		if (!f2fs_is_dirty_device(sbi, ino, i, FLUSH_INO))
 			continue;
-		ret = __submit_flush_wait(sbi, FDEV(i).bdev);
+		ret = f2fs_submit_flush_wait(sbi, FDEV(i).bdev);
 		if (ret)
 			break;
 	}
@@ -748,7 +748,7 @@ int f2fs_flush_device_cache(struct f2fs_sb_info *sbi)
 			continue;
 
 		do {
-			ret = __submit_flush_wait(sbi, FDEV(i).bdev);
+			ret = f2fs_submit_flush_wait(sbi, FDEV(i).bdev);
 			if (ret)
 				f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
 		} while (ret && --count);
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index f736052dea50..b69015f1dc67 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -852,6 +852,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "flush_policy")) {
+		if (t >= BIT(FLUSH_POLICY_MAX))
+			return -EINVAL;
+		*ui = (unsigned int)t;
+		return count;
+	}
+
 	if (!strcmp(a->attr.name, "gc_boost_gc_multiple")) {
 		if (t < 1 || t > SEGS_PER_SEC(sbi))
 			return -EINVAL;
@@ -1175,6 +1182,7 @@ F2FS_SBI_GENERAL_RW_ATTR(blkzone_alloc_policy);
 #endif
 F2FS_SBI_GENERAL_RW_ATTR(carve_out);
 F2FS_SBI_GENERAL_RW_ATTR(reserved_pin_section);
+F2FS_SBI_GENERAL_RW_ATTR(flush_policy);
 
 /* STAT_INFO ATTR */
 #ifdef CONFIG_F2FS_STAT_FS
@@ -1371,6 +1379,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(max_read_extent_count),
 	ATTR_LIST(carve_out),
 	ATTR_LIST(reserved_pin_section),
+	ATTR_LIST(flush_policy),
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs);
-- 
2.49.0



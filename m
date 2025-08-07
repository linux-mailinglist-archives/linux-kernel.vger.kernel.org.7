Return-Path: <linux-kernel+bounces-758596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDF5B1D133
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 05:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EFC97274F3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 03:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FC91B4257;
	Thu,  7 Aug 2025 03:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AN3/K/p/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFBB189
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 03:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754537051; cv=none; b=Fxy13gstmZIGyybxvNEyWKhcqf3CsK0xXVkSZlFypnoW3WQUqtMT1hufCDw3Fh0DtNqLUjEzxIM1UW39wP8o7Qpm/hVbkrxAftG+JQ9qiL8/IXs3NQac3saSdLEPFfMnRd9yp4deRpVwWo3F6MPv5qyYm9UnS5koxWTSkkBDFLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754537051; c=relaxed/simple;
	bh=VZg+A97lIc31uU4nMDdnhG8fEBnd5GwgB8vqJ5BOkV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MlvDH3mF5RkH073ZFT5zxCJgfcs+0+hfuppnWR+UO2tyS2gYh8C12CIuDiMuzj2zTBNdTP7dt6+q1fPm3W0LDrHzIt39CCUzNc/wDF+wasfefsDMOrn6v1WTctRUkUfJUyDyDLdxBxJbge8Ha7okJEfclfmQu3kTt4ofmaOesrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AN3/K/p/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5658CC4CEE7;
	Thu,  7 Aug 2025 03:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754537050;
	bh=VZg+A97lIc31uU4nMDdnhG8fEBnd5GwgB8vqJ5BOkV8=;
	h=From:To:Cc:Subject:Date:From;
	b=AN3/K/p/n6zbfF+ISLrDgpAvVHZhW+tDXvdEq9IwNUWqTLVxa0DRTx0gVNUFdOKzq
	 meZrQb7uRc1Ka6rsMgpRRlgyBjErqSrI2Pz6vr2xNb6DtN1QaSoHJPEblQ6gl2LIwR
	 qNwjBaJa1kA3kYxU8U90ihzdgOIqIj504oIAFUiftS+w9vgWte6u4m+pWxgVXwWxha
	 FKsGj3ixoniv+ZjVXnSsx9ofmAzaL2sNlpOBBAUqut+5tcuiupZqKSC1Mtd4xkWTnH
	 5aRZNXhDPHeChXtbmIIK1DiwUrnnP6dlBIUaVI0D8Ia6aTVqJ73D87P5wDr6HVGsyx
	 bmvj6qh4ehTCA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2] f2fs: introduce flush_policy sysfs entry
Date: Thu,  7 Aug 2025 11:24:06 +0800
Message-ID: <20250807032406.3817056-1-chao@kernel.org>
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
v2:
- use __submit_flush_wait() instead of f2fs_flush_device_cache() to
just flush primary device cache
 Documentation/ABI/testing/sysfs-fs-f2fs |  9 +++++++++
 fs/f2fs/checkpoint.c                    | 11 ++++++++++-
 fs/f2fs/f2fs.h                          |  7 +++++++
 fs/f2fs/sysfs.c                         |  9 +++++++++
 4 files changed, 35 insertions(+), 1 deletion(-)

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
index db3831f7f2f5..fafa2156732d 100644
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
+		err = __submit_flush_wait(sbi, sbi->sb->s_bdev);
+		if (err)
+			return err;
+	}
+
 	/*
 	 * redirty superblock if metadata like node page or inode cache is
 	 * updated during writing checkpoint.
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 46be7560548c..5db5eba4cbd7 100644
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



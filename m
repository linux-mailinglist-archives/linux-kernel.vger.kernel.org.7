Return-Path: <linux-kernel+bounces-721502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC546AFCA11
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D5BF564B5C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6862D8DC8;
	Tue,  8 Jul 2025 12:06:16 +0000 (UTC)
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B3F2D3206
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 12:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751976375; cv=none; b=LjHJyWRHVG2liNw70ZpkUF5p2dT5FjIeSHFrF0xdkI9CwliJpe9WCes4wy/qwIU9olklM2zv+FBOu268nyCHsI2KzZW2NEVbYFA4t3vxaxFIcOWeTPGT8a77jKubUqlnbbClDOAWmG7Y9xH6HbggpNv0bmu5aX/RoZ0Ng+1MXOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751976375; c=relaxed/simple;
	bh=t+WJwxPkODL2E6JX2lsUG2PpKcpJXeK+83BK2XJFyAo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TQQR3grH0CH3sGt/jCO7flDQRw5nX1U/UGJ1xwNq7FQ+PEf6hewIK2HyLObTrA0XoRzm4TyG2YrtIvErumXPaxrd8+nAkPKB5r1ikjOdPkjhYfHkTpn2Q7pmoxeaMykoHCUt7Zu+/qcvxQOpnEi9bC69FroqttETQhgSch5wNL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201610.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202507082004536617;
        Tue, 08 Jul 2025 20:04:53 +0800
Received: from localhost.localdomain (10.94.5.51) by
 jtjnmail201610.home.langchao.com (10.100.2.10) with Microsoft SMTP Server id
 15.1.2507.57; Tue, 8 Jul 2025 20:04:55 +0800
From: Bo Liu <liubo03@inspur.com>
To: <xiang@kernel.org>, <chao@kernel.org>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH] erofs: support metadata compression
Date: Tue, 8 Jul 2025 08:01:43 -0400
Message-ID: <20250708120143.3572-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
tUid: 202570820045303427c2756c5b6d41fb4883f4037d374
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Filesystem metadata has a high degree of redundancy, so
should compress well in the general case.
To implement this feature, we make a special on-disk inode
which keeps all metadata as its data, and then compress the
special on-disk inode with the given algorithm.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 fs/erofs/data.c     |  4 +++-
 fs/erofs/erofs_fs.h |  2 +-
 fs/erofs/internal.h |  7 +++++++
 fs/erofs/super.c    | 10 ++++++++++
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 6a329c329f43..34c82421af4c 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -55,7 +55,9 @@ void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
 
 	buf->file = NULL;
 	buf->off = sbi->dif0.fsoff;
-	if (erofs_is_fileio_mode(sbi)) {
+	if (erofs_is_metadata_comp_mode(sbi))
+		buf->mapping = sbi->meta_inode->i_mapping;
+	else if (erofs_is_fileio_mode(sbi)) {
 		buf->file = sbi->dif0.file;	/* some fs like FUSE needs it */
 		buf->mapping = buf->file->f_mapping;
 	} else if (erofs_is_fscache_mode(sb))
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 767fb4acdc93..bf1ef306ca3c 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -82,7 +82,7 @@ struct erofs_super_block {
 	__u8 reserved[3];
 	__le32 build_time;	/* seconds added to epoch for mkfs time */
 	__le64 rootnid_8b;	/* (48BIT on) nid of root directory */
-	__u8 reserved2[8];
+	__le64 meta_nid;	/* meta data nid */
 };
 
 /*
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index a32c03a80c70..a2437e5eada2 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -125,6 +125,7 @@ struct erofs_sb_info {
 	struct erofs_sb_lz4_info lz4;
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	struct inode *packed_inode;
+	struct inode *meta_inode;
 	struct erofs_dev_context *devs;
 	u64 total_blocks;
 
@@ -148,6 +149,7 @@ struct erofs_sb_info {
 	/* what we really care is nid, rather than ino.. */
 	erofs_nid_t root_nid;
 	erofs_nid_t packed_nid;
+	erofs_nid_t meta_nid;
 	/* used for statfs, f_files - f_favail */
 	u64 inos;
 
@@ -190,6 +192,11 @@ static inline bool erofs_is_fscache_mode(struct super_block *sb)
 			!erofs_is_fileio_mode(EROFS_SB(sb)) && !sb->s_bdev;
 }
 
+static inline bool erofs_is_metadata_comp_mode(struct erofs_sb_info *sbi)
+{
+	return sbi->meta_inode;
+}
+
 enum {
 	EROFS_ZIP_CACHE_DISABLED,
 	EROFS_ZIP_CACHE_READAHEAD,
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index e1e9f06e8342..9bc40083cd00 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -324,6 +324,7 @@ static int erofs_read_superblock(struct super_block *sb)
 	sbi->epoch = (s64)le64_to_cpu(dsb->epoch);
 	sbi->fixed_nsec = le32_to_cpu(dsb->fixed_nsec);
 	super_set_uuid(sb, (void *)dsb->uuid, sizeof(dsb->uuid));
+	sbi->meta_nid = le64_to_cpu(dsb->meta_nid);
 
 	/* parse on-disk compression configurations */
 	ret = z_erofs_parse_cfgs(sb, dsb);
@@ -691,6 +692,13 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		sbi->packed_inode = inode;
 	}
 
+	if (sbi->meta_nid) {
+		inode = erofs_iget(sb, sbi->meta_nid);
+		if (IS_ERR(inode))
+			return PTR_ERR(inode);
+		sbi->meta_inode = inode;
+	}
+
 	inode = erofs_iget(sb, sbi->root_nid);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
@@ -845,6 +853,8 @@ static void erofs_drop_internal_inodes(struct erofs_sb_info *sbi)
 {
 	iput(sbi->packed_inode);
 	sbi->packed_inode = NULL;
+	iput(sbi->meta_inode);
+	sbi->meta_inode = NULL;
 #ifdef CONFIG_EROFS_FS_ZIP
 	iput(sbi->managed_cache);
 	sbi->managed_cache = NULL;
-- 
2.31.1



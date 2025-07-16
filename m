Return-Path: <linux-kernel+bounces-734022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C91B07C1E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8C3B7B7F88
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C857A2F6F89;
	Wed, 16 Jul 2025 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ETdidkg6"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB022F273C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 17:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752687206; cv=none; b=R9kbk9YpoPDvrRAmfTOjh5z5HdFznBw98E3jRKFVAKetxnZklay4HFOjNHuFUwmbiRJnLOka/4FPtSws1iW9t56njOZJaTLPomvwCR3rX/kSMc2k75t/8nus2OMRbReNd93HKmEjQVlPuFcTOWFvYQGql+uiunTrVS6zr5ka89s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752687206; c=relaxed/simple;
	bh=FuK8DttPfjSWS55Mk5TD10h4xNht8EH7lfxxUr6zm0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkZiQkYVA1a8+4TnD2AOfZiOv5HE0L2se7/eO5SoHL0Rfnfy2Z1RIdQLTcDNQtV2hInnsPrYsHfBA2xUtRTOFWZG1qj3JVSOIz4zoZbmptuwiiyf0xuCgiAgGICOwa9wW1vEi68afWL2n7Id+RkCJa9e4EMx2GuygMfoxmFF1bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ETdidkg6; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752687201; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=6w8O6RweXULv3ifzkRKQqUGQ5ARREZ9DZcDovLN/Qng=;
	b=ETdidkg6ukNKKSDWOPsLL3pWIs/zIKycqiiMJUNFwn+EqEMFKqzUJmixM0U27tq1AwfeccDSkZQIh7l5OC8rqmS6nlGwjLT6GT0WGmLDg5DA3Q+xOwBi999a6hBPqz2e475qk1Q/I2v8BTHh8kVeNW0ZcEuEddhOZzGiKabm0sM=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj5Vb6t_1752687199 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Jul 2025 01:33:20 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v3 1/2] erofs: add on-disk definition for metadata compression
Date: Thu, 17 Jul 2025 01:33:13 +0800
Message-ID: <20250716173314.308744-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250716173314.308744-1-hsiangkao@linux.alibaba.com>
References: <20250716173314.308744-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Filesystem metadata has a high degree of redundancy, so it should
compress well in the general case.

Although metadata compression can increase overall I/O latency, many
users care more about minimized image sizes than extreme runtime
performance.  Let's implement metadata compression in response to user
requests [1].

Actually, it's quite simple to implement metadata compression: since
EROFS already supports per-inode compression, we can simply treat a
special inode (called `the metabox inode`) as a container for compressed
inode metadata.  Since EROFS supports multiple algorithms, users can
even specify LZ4 for metadata and LZMA for data.

To better support incremental builds, the MSB of NIDs indicates where
the inode metadata is located: if bit 63 is set, the inode itself should
be read from `the metabox inode`.

Optionally, shared xattrs can also be kept in `the metabox inode` if
COMPAT_SHARED_EA_IN_METABOX is set.

[1] https://issues.redhat.com/browse/RHEL-75783
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/erofs_fs.h | 13 ++++++++++---
 fs/erofs/internal.h |  2 ++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 767fb4acdc93..0c9047e4a295 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -15,6 +15,7 @@
 #define EROFS_FEATURE_COMPAT_SB_CHKSUM          0x00000001
 #define EROFS_FEATURE_COMPAT_MTIME              0x00000002
 #define EROFS_FEATURE_COMPAT_XATTR_FILTER	0x00000004
+#define EROFS_FEATURE_COMPAT_SHARED_EA_IN_METABOX	0x00000008
 
 /*
  * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
@@ -31,6 +32,7 @@
 #define EROFS_FEATURE_INCOMPAT_DEDUPE		0x00000020
 #define EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES	0x00000040
 #define EROFS_FEATURE_INCOMPAT_48BIT		0x00000080
+#define EROFS_FEATURE_INCOMPAT_METABOX		0x00000100
 #define EROFS_ALL_FEATURE_INCOMPAT		\
 	((EROFS_FEATURE_INCOMPAT_48BIT << 1) - 1)
 
@@ -46,7 +48,7 @@ struct erofs_deviceslot {
 };
 #define EROFS_DEVT_SLOT_SIZE	sizeof(struct erofs_deviceslot)
 
-/* erofs on-disk super block (currently 128 bytes) */
+/* erofs on-disk super block (currently 144 bytes at maximum) */
 struct erofs_super_block {
 	__le32 magic;           /* file system magic number */
 	__le32 checksum;        /* crc32c to avoid unexpected on-disk overlap */
@@ -82,7 +84,9 @@ struct erofs_super_block {
 	__u8 reserved[3];
 	__le32 build_time;	/* seconds added to epoch for mkfs time */
 	__le64 rootnid_8b;	/* (48BIT on) nid of root directory */
-	__u8 reserved2[8];
+	__le64 reserved2;
+	__le64 metabox_nid;     /* (METABOX on) nid of the metabox inode */
+	__le64 reserved3;	/* [align to extslot 1] */
 };
 
 /*
@@ -267,6 +271,9 @@ struct erofs_inode_chunk_index {
 	__le32 startblk_lo;	/* starting block number of this chunk */
 };
 
+#define EROFS_DIRENT_NID_METABOX_BIT	63
+#define EROFS_DIRENT_NID_MASK		(BIT(EROFS_DIRENT_NID_METABOX_BIT) - 1)
+
 /* dirent sorts in alphabet order, thus we can do binary search */
 struct erofs_dirent {
 	__le64 nid;     /* node number */
@@ -434,7 +441,7 @@ static inline void erofs_check_ondisk_layout_definitions(void)
 		.h_clusterbits = 1 << Z_EROFS_FRAGMENT_INODE_BIT
 	};
 
-	BUILD_BUG_ON(sizeof(struct erofs_super_block) != 128);
+	BUILD_BUG_ON(sizeof(struct erofs_super_block) != 144);
 	BUILD_BUG_ON(sizeof(struct erofs_inode_compact) != 32);
 	BUILD_BUG_ON(sizeof(struct erofs_inode_extended) != 64);
 	BUILD_BUG_ON(sizeof(struct erofs_xattr_ibody_header) != 12);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index a7699114f6fe..ad932f670bb6 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -227,8 +227,10 @@ EROFS_FEATURE_FUNCS(fragments, incompat, INCOMPAT_FRAGMENTS)
 EROFS_FEATURE_FUNCS(dedupe, incompat, INCOMPAT_DEDUPE)
 EROFS_FEATURE_FUNCS(xattr_prefixes, incompat, INCOMPAT_XATTR_PREFIXES)
 EROFS_FEATURE_FUNCS(48bit, incompat, INCOMPAT_48BIT)
+EROFS_FEATURE_FUNCS(metabox, incompat, INCOMPAT_METABOX)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
+EROFS_FEATURE_FUNCS(shared_ea_in_metabox, compat, COMPAT_SHARED_EA_IN_METABOX)
 
 /* atomic flag definitions */
 #define EROFS_I_EA_INITED_BIT	0
-- 
2.43.5



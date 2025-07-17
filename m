Return-Path: <linux-kernel+bounces-734772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50010B08639
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9B2176A60
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5782621A447;
	Thu, 17 Jul 2025 07:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JZ2MLZPa"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BDCFBF6
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752736101; cv=none; b=p/2vV4dLNFtaAs0zU5mRxleJXhXHZBN2qmGx/+Lvd8D+qcvzzzyo2wGRzSO+dUjDrTyI9olDeWMM26acF9GCRaklmHNcWYPNwcTDJTKPMIiWp1oj2riiPlT2LGm33wUbL5p2YwHUE9Hu83wHGc3JAjYCWEHQef+rgQ/iG1QsQwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752736101; c=relaxed/simple;
	bh=zUT9KU7Dx+xgQAD7xrXjg70wfwW8pG6VvLQCUew42jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uukgadli2pRSWJ6cKoBITK5pXUdKysJdT9dEw+rzvifo1RbBqpHJpNGxI1y4MPkNsfV33bViHJaz7nDzv4NTUh0adbZpk2TjdEO2/FzwoppWk2yUC+UnBno50fHhda6gFgV5zUJIbaGz6u9qgELl51V3yN6lPncj8hcvQ/yz94g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JZ2MLZPa; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752736096; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Cb3feXgviGMzdQwYcgHxk5CDMQwohzJIr1oowKwCh7Q=;
	b=JZ2MLZPaNtETzK1mHYxcMpfiiiQjiWenzURoKqwAx/tb2L7I4/oMaOSFDLVmS5++HEEnQnO/RtQKCQynxlpdbggj/5J15dM7Mw9P9TjoxJqBZtKjMwXk4iQAp5w4942Fx7XJXlUjiYpY0zNvjS3dJGp1+UtaQMTKaHzvukS71rE=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj791lz_1752736094 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Jul 2025 15:08:15 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v5 1/2] erofs: add on-disk definition for metadata compression
Date: Thu, 17 Jul 2025 15:08:03 +0800
Message-ID: <20250717070804.1446345-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250717070804.1446345-1-hsiangkao@linux.alibaba.com>
References: <20250716173314.308744-1-hsiangkao@linux.alibaba.com>
 <20250717070804.1446345-1-hsiangkao@linux.alibaba.com>
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
index 767fb4acdc93..7b150ac64742 100644
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
+#define EROFS_DIRENT_NID_MASK	(BIT_ULL(EROFS_DIRENT_NID_METABOX_BIT) - 1)
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



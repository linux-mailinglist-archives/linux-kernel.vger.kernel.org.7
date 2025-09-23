Return-Path: <linux-kernel+bounces-829712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4F0B97B16
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 00:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 049F62A6EE7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5047230F522;
	Tue, 23 Sep 2025 22:14:14 +0000 (UTC)
Received: from sxb1plsmtpa01-03.prod.sxb1.secureserver.net (sxb1plsmtpa01-03.prod.sxb1.secureserver.net [188.121.53.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADAC288C8B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 22:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758665653; cv=none; b=SbPgM0hZRKG7YACUHDxKk2kUUwb315fn0DER7igD2R9O3L7oWFO56GaI+vBMc9kVI8AH0KjeM6A/DP0ZQtrlhykBOa+Y3PoXzFWG9Hw81oM3hX6NEIKdq0gWtfJEOSs7VWUlRha+sGeMv7mvP+6CF0JCjqXYEZGGG543oLjnVaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758665653; c=relaxed/simple;
	bh=WUP0gLZZhYvaPyUD0UMhst8lpJlJkhpbcn69k5v/iSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lu8OmMWDcIrbqXpFDdfpJuUSsnLgf+hOCqUdzz9/bfgNDj7Q2qKwwad3HF3Cg3OY45OThWLAfoni7dLEasvA46GITH9wBy5ae9BcHEodCRQPUNrYieGNtmIYHHxw8WKHZQdaCPh9F/D7ESuOjCVpHDJQ7hiwED/Hc2fFy9KYEgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from phoenix.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id 1B9IvdJrlRKdg1B9Yvhvt4; Tue, 23 Sep 2025 15:06:29 -0700
X-CMAE-Analysis: v=2.4 cv=cL65cleN c=1 sm=1 tr=0 ts=68d319e6
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=FXvPX3liAAAA:8
 a=PmvtE5NTWYoDmZ2mIecA:9 a=UObqyxdv-6Yh2QiB9mM_:22 a=irvUdcZYBsSKPCvlqN3O:22
Feedback-ID: e4ba3dcc65f267fca773178bb1f8c56e:squashfs.org.uk:ssnet
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH 2/2] Squashfs: add SEEK_DATA/SEEK_HOLE support
Date: Tue, 23 Sep 2025 23:06:52 +0100
Message-Id: <20250923220652.568416-3-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250923220652.568416-1-phillip@squashfs.org.uk>
References: <20250923220652.568416-1-phillip@squashfs.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFzgAGs/sxXFVE9lZdAnY+CuxBiOxHex/bXKVsLtYWDr7c7WHCSJKyDlLmE5fkACUJFckEwMpEQf5UnePwsUiyRaaFN3sXNJFKVWNcNw8sj/W71So3Mq
 5xy6L+8P6uXLJpLBqmx2hiyxe75EZDhngl6CbpL4STnrrO6vjjqEyUvThlRlmE7wIFDEbh6+jfI5I3Ew5GZzpCxOpFdUNIoeFK+DaLGejcXDsBjt19hCDL6r
 rjYBlJoi5N8UY80ywA9L5bQRvmD72FiLVwh9RIdNGSyY25xEIypExPIzzy5OOmqs

Add support for SEEK_DATA and SEEK_HOLE lseek() whence values.

These allow much faster searches for holes and data in sparse files,
which can significantly speed up file copying, e.g.

before (GNU coreutils, Debian 13):

cp --sparse=always big-file /

took real 11m58s, user 0m5.764s, sys 11m48s

after:

real 0.047s, user 0.000s, sys 0.027s

Where big-file has a 256 GB hole followed by 47 KB of data.

Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
 fs/squashfs/file.c        | 137 +++++++++++++++++++++++++++++++++++---
 fs/squashfs/inode.c       |   4 +-
 fs/squashfs/squashfs.h    |   1 +
 fs/squashfs/squashfs_fs.h |   1 +
 4 files changed, 130 insertions(+), 13 deletions(-)

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index ce7d661d5ad8..1582e0637a7e 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -307,7 +307,8 @@ static int fill_meta_index(struct inode *inode, int index,
 all_done:
 	*index_block = cur_index_block;
 	*index_offset = cur_offset;
-	*data_block = cur_data_block;
+	if (data_block)
+		*data_block = cur_data_block;
 
 	/*
 	 * Scale cache index (cache slot entry) to index
@@ -324,17 +325,15 @@ static int fill_meta_index(struct inode *inode, int index,
  * Get the on-disk location and compressed size of the datablock
  * specified by index.  Fill_meta_index() does most of the work.
  */
-static int read_blocklist(struct inode *inode, int index, u64 *block)
+static int read_blocklist_ptrs(struct inode *inode, int index, u64 *start,
+	int *offset, u64 *block)
 {
-	u64 start;
 	long long blks;
-	int offset;
 	__le32 size;
-	int res = fill_meta_index(inode, index, &start, &offset, block);
+	int res = fill_meta_index(inode, index, start, offset, block);
 
-	TRACE("read_blocklist: res %d, index %d, start 0x%llx, offset"
-		       " 0x%x, block 0x%llx\n", res, index, start, offset,
-			*block);
+	TRACE("read_blocklist: res %d, index %d, start 0x%llx, offset 0x%x, block 0x%llx\n",
+				res, index, *start, *offset, block ? *block : 0);
 
 	if (res < 0)
 		return res;
@@ -346,22 +345,31 @@ static int read_blocklist(struct inode *inode, int index, u64 *block)
 	 * extra block indexes needed.
 	 */
 	if (res < index) {
-		blks = read_indexes(inode->i_sb, index - res, &start, &offset);
+		blks = read_indexes(inode->i_sb, index - res, start, offset);
 		if (blks < 0)
 			return (int) blks;
-		*block += blks;
+		if (block)
+			*block += blks;
 	}
 
 	/*
 	 * Read length of block specified by index.
 	 */
-	res = squashfs_read_metadata(inode->i_sb, &size, &start, &offset,
+	res = squashfs_read_metadata(inode->i_sb, &size, start, offset,
 			sizeof(size));
 	if (res < 0)
 		return res;
 	return squashfs_block_size(size);
 }
 
+static inline int read_blocklist(struct inode *inode, int index, u64 *block)
+{
+	u64 start;
+	int offset;
+
+	return read_blocklist_ptrs(inode, index, &start, &offset, block);
+}
+
 static bool squashfs_fill_page(struct folio *folio,
 		struct squashfs_cache_entry *buffer, size_t offset,
 		size_t avail)
@@ -658,7 +666,114 @@ static void squashfs_readahead(struct readahead_control *ractl)
 	kfree(pages);
 }
 
+static loff_t seek_hole_data(struct file *file, loff_t offset, int whence)
+{
+	struct inode *inode = file->f_mapping->host;
+	struct super_block *sb = inode->i_sb;
+	struct squashfs_sb_info *msblk = sb->s_fs_info;
+	u64 start, index = offset >> msblk->block_log;
+	u64 file_end = (i_size_read(inode) + msblk->block_size - 1) >> msblk->block_log;
+	int s_offset, length;
+	__le32 *blist = NULL;
+
+	/* reject offset if negative or beyond file end */
+	if ((unsigned long long)offset >= i_size_read(inode))
+		return -ENXIO;
+
+	/* is offset within tailend and is tailend packed into a fragment? */
+	if (index + 1 == file_end &&
+			squashfs_i(inode)->fragment_block != SQUASHFS_INVALID_BLK) {
+		if (whence == SEEK_DATA)
+			return offset;
+
+		/* there is an implicit hole at the end of any file */
+		return i_size_read(inode);
+	}
+
+	length = read_blocklist_ptrs(inode, index, &start, &s_offset, NULL);
+	if (length < 0)
+		return length;
+
+	/* nothing more to do if offset matches desired whence value */
+	if ((length == 0 && whence == SEEK_HOLE) ||
+					(length && whence == SEEK_DATA))
+		return offset;
+
+	/* skip scanning forwards if we're at file end */
+	if (++ index == file_end)
+		goto not_found;
+
+	blist = kmalloc(SQUASHFS_SCAN_INDEXES << 2, GFP_KERNEL);
+	if (blist == NULL) {
+		ERROR("%s: Failed to allocate block_list\n", __func__);
+		return -ENOMEM;
+	}
+
+	while (index < file_end) {
+		int i, indexes = min(file_end - index, SQUASHFS_SCAN_INDEXES);
+
+		offset = squashfs_read_metadata(sb, blist, &start, &s_offset, indexes << 2);
+		if (offset < 0)
+			goto finished;
+
+		for (i = 0; i < indexes; i++) {
+			length = squashfs_block_size(blist[i]);
+			if (length < 0) {
+				offset = length;
+				goto finished;
+			}
+
+			/* does this block match desired whence value? */
+			if ((length == 0 && whence == SEEK_HOLE) ||
+					(length && whence == SEEK_DATA)) {
+				offset = (index + i) << msblk->block_log;
+				goto finished;
+			}
+		}
+
+		index += indexes;
+	}
+
+not_found:
+	/* whence value determines what happens */
+	if (whence == SEEK_DATA)
+		offset = -ENXIO;
+	else
+		/* there is an implicit hole at the end of any file */
+		offset = i_size_read(inode);
+
+finished:
+	kfree(blist);
+	return offset;
+}
+
+static loff_t squashfs_llseek(struct file *file, loff_t offset, int whence)
+{
+	struct inode *inode = file->f_mapping->host;
+
+	switch (whence) {
+	default:
+		return generic_file_llseek(file, offset, whence);
+	case SEEK_DATA:
+	case SEEK_HOLE:
+		offset = seek_hole_data(file, offset, whence);
+		break;
+	}
+
+	if (offset < 0)
+		return offset;
+
+	return vfs_setpos(file, offset, inode->i_sb->s_maxbytes);
+}
+
 const struct address_space_operations squashfs_aops = {
 	.read_folio = squashfs_read_folio,
 	.readahead = squashfs_readahead
 };
+
+const struct file_operations squashfs_file_operations = {
+	.llseek		= squashfs_llseek,
+	.read_iter	= generic_file_read_iter,
+	.mmap_prepare	= generic_file_readonly_mmap_prepare,
+	.splice_read	= filemap_splice_read
+};
diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index 77eec1772998..5920a33e44a1 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -164,7 +164,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		}
 
 		set_nlink(inode, 1);
-		inode->i_fop = &generic_ro_fops;
+		inode->i_fop = &squashfs_file_operations;
 		inode->i_mode |= S_IFREG;
 		inode->i_blocks = ((inode->i_size - 1) >> 9) + 1;
 		squashfs_i(inode)->fragment_block = frag_blk;
@@ -217,7 +217,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		xattr_id = le32_to_cpu(sqsh_ino->xattr);
 		set_nlink(inode, le32_to_cpu(sqsh_ino->nlink));
 		inode->i_op = &squashfs_inode_ops;
-		inode->i_fop = &generic_ro_fops;
+		inode->i_fop = &squashfs_file_operations;
 		inode->i_mode |= S_IFREG;
 		inode->i_blocks = (inode->i_size -
 				le64_to_cpu(sqsh_ino->sparse) + 511) >> 9;
diff --git a/fs/squashfs/squashfs.h b/fs/squashfs/squashfs.h
index 218868b20f16..4851bd964502 100644
--- a/fs/squashfs/squashfs.h
+++ b/fs/squashfs/squashfs.h
@@ -107,6 +107,7 @@ extern const struct address_space_operations squashfs_aops;
 
 /* inode.c */
 extern const struct inode_operations squashfs_inode_ops;
+extern const struct file_operations squashfs_file_operations;
 
 /* namei.c */
 extern const struct inode_operations squashfs_dir_inode_ops;
diff --git a/fs/squashfs/squashfs_fs.h b/fs/squashfs/squashfs_fs.h
index 95f8e8901768..a955d9369749 100644
--- a/fs/squashfs/squashfs_fs.h
+++ b/fs/squashfs/squashfs_fs.h
@@ -208,6 +208,7 @@ static inline int squashfs_block_size(__le32 raw)
 #define SQUASHFS_META_INDEXES	(SQUASHFS_METADATA_SIZE / sizeof(unsigned int))
 #define SQUASHFS_META_ENTRIES	127
 #define SQUASHFS_META_SLOTS	8
+#define SQUASHFS_SCAN_INDEXES	1024
 
 struct meta_entry {
 	u64			data_block;
-- 
2.39.5



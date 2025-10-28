Return-Path: <linux-kernel+bounces-873530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F00C2C14252
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56665E29A1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAEC3093AE;
	Tue, 28 Oct 2025 10:40:15 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BCC305946
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648010; cv=none; b=jnoHqsagaB/ZugIHYUpKtvpi1W2dYaKOxrpo3RhOb4aywuEIM24RpUxxThK8e0uMXYgAETVz6MQfhm1bVVOnrqPFQEBTT0DPGyZd3Lk3ithHRbsh7FTs0iJxyNMG8qkqBfAevXStWCv0wxDZQjTyHF5YQKAA65pxddwmpPKo588=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648010; c=relaxed/simple;
	bh=eia3MzCulBXgWlM80LrVbombzhvBPwEgz+Dk8WeAkJM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GsLYcFKOWEvmCrgiUfhj4/Pl+ufswlsx8ZfDOtcs83QK/DrtW1oAbinoC307IBYISAvDRh5zckV4X0st92I7JR2kLCyoqF6OmWQM4065PgLcVvYbjt/bIUuP4KIeCpZmYqZ32WOcCoZGoJna0n1xKpkdPUbjrEo5OUWPOzLTR5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8870219dce3so544768439f.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648007; x=1762252807;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aGCoNnu8Gzz3TZey/bkoQ4adSRU1D7w6+FPQKCfJ/6A=;
        b=EPXgUlG3ZVctGpG2xkJL8w5PLn78A2BaMVdCYK4KearOY7++6kzz+6S+WQvOePF23/
         OBUkqdA3SzV1WpEwssAFwVdS1w6fDPsXKF7oaO/Pvb3pG98R4NPx9X3FcCmJvFFyqx6I
         v+SDnGRVZboZ4TtaqCXSCqPmYoSc7EIQxxtsl6PWjJ0myWwJzGcOx3Ig1q6vU9Zv4lej
         oAv7E2JTEwr1UG3z41EShRUBh42oV1OomUmxdCEiCGPMSwWgYfHWmwZ8RawT/BCPhh3B
         Un2RkWA3yJdnjaKJ4l4a/MZys4PLxK2GEAxMfZSgiRlJqKcupGqv3Lr6K3mduO7Dy1Y0
         z89Q==
X-Gm-Message-State: AOJu0YxtpFuQ2CgDezUFNzpuPgq3pcm5Zcx94fHtLYn9k0i/kXlau4CO
	FtT8Uao9j13E1E78PR5hgew2zigVmai3KmzwXqoBcZYHDYtZZ+4NgXCDeoaNpFQN21NnpC573ur
	/DfWysN84N92MDURoq4fYxvFQEd9vU4nG/NAgT5HGHH/jWpFErjEeFlZVa+Q=
X-Google-Smtp-Source: AGHT+IFvoQ36xquT/0AxRBxMnDA5Ydm5T+0Z1Wev76h8C5A3BW8aYY8/Umb9Bogx2dVa4CvUAxsirUXtawxQ9s2Te9C8CgT5swz8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2183:b0:431:d6fa:6c49 with SMTP id
 e9e14a558f8ab-4320f79b5b1mr39967965ab.24.1761648007353; Tue, 28 Oct 2025
 03:40:07 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:40:07 -0700
In-Reply-To: <68ef030a.050a0220.91a22.022b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69009d87.050a0220.32483.016f.GAE@google.com>
Subject: Forwarded: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 linux-5.10.y
From: syzbot <syzbot+77026564530dbc29b854@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-5.10.y
Author: dmantipov@yandex.ru

diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index 94c7acfebe18..0e0a4742b8a6 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -6155,6 +6155,9 @@ static int ocfs2_get_truncate_log_info(struct ocfs2_super *osb,
 	int status;
 	struct inode *inode = NULL;
 	struct buffer_head *bh = NULL;
+	struct ocfs2_dinode *di;
+	struct ocfs2_truncate_log *tl;
+	unsigned int tl_count, tl_used;
 
 	inode = ocfs2_get_system_file_inode(osb,
 					   TRUNCATE_LOG_SYSTEM_INODE,
@@ -6172,6 +6175,19 @@ static int ocfs2_get_truncate_log_info(struct ocfs2_super *osb,
 		goto bail;
 	}
 
+	di = (struct ocfs2_dinode *)bh->b_data;
+	tl = &di->id2.i_dealloc;
+	tl_used = le16_to_cpu(tl->tl_used);
+	tl_count = le16_to_cpu(tl->tl_count);
+	if (unlikely(tl_count > ocfs2_truncate_recs_per_inode(osb->sb) ||
+		     tl_count == 0 || tl_used > tl_count)) {
+		status = -EFSCORRUPTED;
+		iput(inode);
+		brelse(bh);
+		mlog_errno(status);
+		goto bail;
+	}
+
 	*tl_inode = inode;
 	*tl_bh    = bh;
 bail:
diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
index 195515eefd33..869cc09e86a8 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -304,8 +304,21 @@ static int ocfs2_check_dir_entry(struct inode *dir,
 				 unsigned long offset)
 {
 	const char *error_msg = NULL;
-	const int rlen = le16_to_cpu(de->rec_len);
-	const unsigned long next_offset = ((char *) de - buf) + rlen;
+	unsigned long next_offset;
+	int rlen;
+
+	if (offset > size - OCFS2_DIR_REC_LEN(1)) {
+		/* Dirent is (maybe partially) beyond the buffer
+		 * boundaries so touching 'de' members is unsafe.
+		 */
+		mlog(ML_ERROR, "directory entry (#%llu: offset=%lu) "
+		     "too close to end or out-of-bounds",
+		     (unsigned long long)OCFS2_I(dir)->ip_blkno, offset);
+		return 0;
+	}
+
+	rlen = le16_to_cpu(de->rec_len);
+	next_offset = ((char *) de - buf) + rlen;
 
 	if (unlikely(rlen < OCFS2_DIR_REC_LEN(1)))
 		error_msg = "rec_len is smaller than minimal";
@@ -780,6 +793,14 @@ static int ocfs2_dx_dir_lookup_rec(struct inode *inode,
 	struct ocfs2_extent_block *eb;
 	struct ocfs2_extent_rec *rec = NULL;
 
+	if (le16_to_cpu(el->l_count) !=
+	    ocfs2_extent_recs_per_dx_root(inode->i_sb)) {
+		ret = ocfs2_error(inode->i_sb,
+				  "Inode %lu has invalid extent list length %u\n",
+				  inode->i_ino, le16_to_cpu(el->l_count));
+		goto out;
+	}
+
 	if (el->l_tree_depth) {
 		ret = ocfs2_find_leaf(INODE_CACHE(inode), el, major_hash,
 				      &eb_bh);
@@ -3418,6 +3439,14 @@ static int ocfs2_find_dir_space_id(struct inode *dir, struct buffer_head *di_bh,
 		offset += le16_to_cpu(de->rec_len);
 	}
 
+	if (!last_de) {
+		ret = ocfs2_error(sb, "Directory entry (#%llu: size=%lld) "
+				  "is unexpectedly short",
+				  (unsigned long long)OCFS2_I(dir)->ip_blkno,
+				  i_size_read(dir));
+		goto out;
+	}
+
 	/*
 	 * We're going to require expansion of the directory - figure
 	 * out how many blocks we'll need so that a place for the
@@ -4109,10 +4138,15 @@ static int ocfs2_expand_inline_dx_root(struct inode *dir,
 	}
 
 	dx_root->dr_flags &= ~OCFS2_DX_FLAG_INLINE;
-	memset(&dx_root->dr_list, 0, osb->sb->s_blocksize -
-	       offsetof(struct ocfs2_dx_root_block, dr_list));
+
+	dx_root->dr_list.l_tree_depth = 0;
 	dx_root->dr_list.l_count =
 		cpu_to_le16(ocfs2_extent_recs_per_dx_root(osb->sb));
+	dx_root->dr_list.l_next_free_rec = 0;
+	memset(&dx_root->dr_list.l_recs, 0,
+	       osb->sb->s_blocksize -
+	       (offsetof(struct ocfs2_dx_root_block, dr_list) +
+		offsetof(struct ocfs2_extent_list, l_recs)));
 
 	/* This should never fail considering we start with an empty
 	 * dx_root. */
diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 7c9dfd50c1c1..17f4106a15df 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1418,6 +1418,31 @@ int ocfs2_validate_inode_block(struct super_block *sb,
 		goto bail;
 	}
 
+	if (le32_to_cpu(di->i_flags) & OCFS2_CHAIN_FL) {
+		struct ocfs2_chain_list *cl = &di->id2.i_chain;
+
+		if (le16_to_cpu(cl->cl_count) != ocfs2_chain_recs_per_inode(sb)) {
+			rc = ocfs2_error(sb, "Invalid dinode %llu: chain list count %u\n",
+					 (unsigned long long)bh->b_blocknr,
+					 le16_to_cpu(cl->cl_count));
+			goto bail;
+		}
+		if (le16_to_cpu(cl->cl_next_free_rec) > le16_to_cpu(cl->cl_count)) {
+			rc = ocfs2_error(sb, "Invalid dinode %llu: chain list index %u\n",
+					 (unsigned long long)bh->b_blocknr,
+					 le16_to_cpu(cl->cl_next_free_rec));
+			goto bail;
+		}
+	}
+
+	if ((le16_to_cpu(di->i_dyn_features) & OCFS2_INLINE_DATA_FL) &&
+	    le32_to_cpu(di->i_clusters)) {
+		rc = ocfs2_error(sb, "Invalid dinode %llu: %u clusters\n",
+				 (unsigned long long)bh->b_blocknr,
+				 le32_to_cpu(di->i_clusters));
+		goto bail;
+	}
+
 	rc = 0;
 
 bail:
diff --git a/fs/ocfs2/localalloc.c b/fs/ocfs2/localalloc.c
index fc8252a28cb1..f60a2f286392 100644
--- a/fs/ocfs2/localalloc.c
+++ b/fs/ocfs2/localalloc.c
@@ -912,13 +912,11 @@ static int ocfs2_local_alloc_find_clear_bits(struct ocfs2_super *osb,
 static void ocfs2_clear_local_alloc(struct ocfs2_dinode *alloc)
 {
 	struct ocfs2_local_alloc *la = OCFS2_LOCAL_ALLOC(alloc);
-	int i;
 
 	alloc->id1.bitmap1.i_total = 0;
 	alloc->id1.bitmap1.i_used = 0;
 	la->la_bm_off = 0;
-	for(i = 0; i < le16_to_cpu(la->la_size); i++)
-		la->la_bitmap[i] = 0;
+	memset(la->la_bitmap, 0, le16_to_cpu(la->la_size));
 }
 
 #if 0
diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
index 98e77ea957ff..8732965760d2 100644
--- a/fs/ocfs2/move_extents.c
+++ b/fs/ocfs2/move_extents.c
@@ -100,7 +100,13 @@ static int __ocfs2_move_extent(handle_t *handle,
 
 	rec = &el->l_recs[index];
 
-	BUG_ON(ext_flags != rec->e_flags);
+	if (ext_flags != rec->e_flags) {
+		ret = ocfs2_error(inode->i_sb,
+				  "Inode %llu has corrupted extent %d with flags 0x%x at cpos %u\n",
+				  (unsigned long long)ino, index, rec->e_flags, cpos);
+		goto out;
+	}
+
 	/*
 	 * after moving/defraging to new location, the extent is not going
 	 * to be refcounted anymore.
@@ -1034,6 +1040,12 @@ int ocfs2_ioctl_move_extents(struct file *filp, void __user *argp)
 	if (range.me_threshold > i_size_read(inode))
 		range.me_threshold = i_size_read(inode);
 
+	if (range.me_flags & ~(OCFS2_MOVE_EXT_FL_AUTO_DEFRAG |
+			       OCFS2_MOVE_EXT_FL_PART_DEFRAG)) {
+		status = -EINVAL;
+		goto out_free;
+	}
+
 	if (range.me_flags & OCFS2_MOVE_EXT_FL_AUTO_DEFRAG) {
 		context->auto_defrag = 1;
 
diff --git a/fs/ocfs2/ocfs2_fs.h b/fs/ocfs2/ocfs2_fs.h
index 19137c6d087b..91f660ce3098 100644
--- a/fs/ocfs2/ocfs2_fs.h
+++ b/fs/ocfs2/ocfs2_fs.h
@@ -470,7 +470,8 @@ struct ocfs2_extent_list {
 	__le16 l_reserved1;
 	__le64 l_reserved2;		/* Pad to
 					   sizeof(ocfs2_extent_rec) */
-/*10*/	struct ocfs2_extent_rec l_recs[];	/* Extent records */
+					/* Extent records */
+/*10*/	struct ocfs2_extent_rec l_recs[] __counted_by_le(l_count);
 };
 
 /*
@@ -484,7 +485,8 @@ struct ocfs2_chain_list {
 	__le16 cl_count;		/* Total chains in this list */
 	__le16 cl_next_free_rec;	/* Next unused chain slot */
 	__le64 cl_reserved1;
-/*10*/	struct ocfs2_chain_rec cl_recs[];	/* Chain records */
+					/* Chain records */
+/*10*/	struct ocfs2_chain_rec cl_recs[] __counted_by_le(cl_count);
 };
 
 /*
@@ -496,7 +498,8 @@ struct ocfs2_truncate_log {
 /*00*/	__le16 tl_count;		/* Total records in this log */
 	__le16 tl_used;			/* Number of records in use */
 	__le32 tl_reserved1;
-/*08*/	struct ocfs2_truncate_rec tl_recs[];	/* Truncate records */
+					/* Truncate records */
+/*08*/	struct ocfs2_truncate_rec tl_recs[] __counted_by_le(tl_count);
 };
 
 /*
@@ -640,7 +643,7 @@ struct ocfs2_local_alloc
 	__le16 la_size;		/* Size of included bitmap, in bytes */
 	__le16 la_reserved1;
 	__le64 la_reserved2;
-/*10*/	__u8   la_bitmap[];
+/*10*/	__u8   la_bitmap[] __counted_by_le(la_size);
 };
 
 /*
@@ -653,7 +656,7 @@ struct ocfs2_inline_data
 				 * for data, starting at id_data */
 	__le16	id_reserved0;
 	__le32	id_reserved1;
-	__u8	id_data[];	/* Start of user data */
+	__u8	id_data[] __counted_by_le(id_count);	/* Start of user data */
 };
 
 /*
@@ -798,9 +801,10 @@ struct ocfs2_dx_entry_list {
 					 * possible in de_entries */
 	__le16		de_num_used;	/* Current number of
 					 * de_entries entries */
-	struct	ocfs2_dx_entry		de_entries[];	/* Indexed dir entries
-							 * in a packed array of
-							 * length de_num_used */
+					/* Indexed dir entries in a packed
+					 * array of length de_num_used.
+					 */
+	struct	ocfs2_dx_entry		de_entries[] __counted_by_le(de_count);
 };
 
 #define OCFS2_DX_FLAG_INLINE	0x01
@@ -935,7 +939,8 @@ struct ocfs2_refcount_list {
 	__le16 rl_used;		/* Current number of used records */
 	__le32 rl_reserved2;
 	__le64 rl_reserved1;	/* Pad to sizeof(ocfs2_refcount_record) */
-/*10*/	struct ocfs2_refcount_rec rl_recs[];	/* Refcount records */
+				/* Refcount records */
+/*10*/	struct ocfs2_refcount_rec rl_recs[] __counted_by_le(rl_count);
 };
 
 
@@ -1021,7 +1026,8 @@ struct ocfs2_xattr_header {
 						    buckets.  A block uses
 						    xb_check and sets
 						    this field to zero.) */
-	struct ocfs2_xattr_entry xh_entries[]; /* xattr entry list. */
+						/* xattr entry list. */
+	struct ocfs2_xattr_entry xh_entries[] __counted_by_le(xh_count);
 };
 
 /*


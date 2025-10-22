Return-Path: <linux-kernel+bounces-864894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C65F1BFBC9D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01802189F165
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABA2342151;
	Wed, 22 Oct 2025 12:11:40 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3094B3126BA
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761135100; cv=none; b=vEwf7KWkMOXMwc+HjX4XncBevQEPLrIJEAuOHpijknM6TUDpmVWbN1rVYFE2L7I38Rfay3U1CS9KoEMY07ce2gB4miXcFDf3hwjTpFfylPT8ezluxobVfhJm3Bq8On7Zks0j2aA9ZyCr+0PGD7DC2OGgrs9qDdahK4zJwvP7TNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761135100; c=relaxed/simple;
	bh=Sm4GWPNeJcL5gEwJZRJ5PrguqKuzIn1kzPolyeVZzsY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=U3ds+RgD2vzoncRDRnZAk/f1QMJFTCP30UgNc1rSO+PQSd0J85PYgb6iupQSbhFoylcGxElnkx4Ow+LZG8CGNWwL58p2yj35rMEbLVP2/HxPHyhsGOw6x5YHuHLhp/mBnammh3hOTm6myrZeO/AdX1UF3pYI2U2/s8s/BtO8vYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-940dc0d7a38so99532939f.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761135097; x=1761739897;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wOrJBT4oSmGN7Bwjcc4GP8AOfbxTb3nBv75gJrMjeOQ=;
        b=Tn+Nqu83+glk7ouRlNhvIbBNYOKJlL4KUFogUVDap5d50iIm3kFnGVBviW329ZrdfF
         2oRCdBicHbRQOoJhRiiV3sbDD0Li9E0A88DfmZnyzFAzM6j6bwjDHQiejMVcgZBPQRh3
         bLVBF+ES1LyihIhKQzL6jlntsbYUlq8bZ3TYxkVntoV1aP2lcQSriOcgqA3MNnvuhTcP
         EQftN6acxp0mCC/JAhWDq/ogvTnGWyhBzCj7NyDwb4PbnCVoYWOmzsCHC7ojmUZQFALj
         cGeGcwwh+0onA8TAkK4wQ9kYm6VEid6I75RjS1tNLbT9OdHA+Nt4wA39cFP3b7UVg7uL
         uz9g==
X-Gm-Message-State: AOJu0YzDHwLGGFb0DAlrC2srwYf2nAB4zJTpWOProNDtHzgAKFfx+Mv/
	lwhiMZ5lJvfOtV3chMDTe8J++b0xx4DLCeOcbIDe/8T4elcsdp6LYh+lsWcUvucR+/CXYyBc5lO
	OGvipWfEeuyW+Z7Z1EJagCqS1+3ItKQy9eyHAKhCq93LXIa5AivG03ZTkBIc=
X-Google-Smtp-Source: AGHT+IGuZqnda8/Lo4UxbSZeSf07G2zcTCtLmvMnrRPPnjJnzk5GtYZZW/qvut/Zqw4yPNsmoAD073lCE/wBt9e70vawisGs4Cir
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1988:b0:424:805a:be98 with SMTP id
 e9e14a558f8ab-431d31b765emr33179365ab.9.1761135097344; Wed, 22 Oct 2025
 05:11:37 -0700 (PDT)
Date: Wed, 22 Oct 2025 05:11:37 -0700
In-Reply-To: <68e48f33.a00a0220.298cc0.046e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f8c9f9.050a0220.346f24.0044.GAE@google.com>
Subject: Forwarded: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 552c50713f273b494ac6c77052032a49bc9255e2
From: syzbot <syzbot+727d161855d11d81e411@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 552c50713f273b494ac6c77052032a49bc9255e2
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 552c50713f273b494ac6c77052032a49bc9255e2

diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index 162711cc5b20..ce38505a823c 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -6164,7 +6164,7 @@ static int ocfs2_get_truncate_log_info(struct ocfs2_super *osb,
 	struct buffer_head *bh = NULL;
 	struct ocfs2_dinode *di;
 	struct ocfs2_truncate_log *tl;
-	unsigned int tl_count;
+	unsigned int tl_count, tl_used;
 
 	inode = ocfs2_get_system_file_inode(osb,
 					   TRUNCATE_LOG_SYSTEM_INODE,
@@ -6184,9 +6184,10 @@ static int ocfs2_get_truncate_log_info(struct ocfs2_super *osb,
 
 	di = (struct ocfs2_dinode *)bh->b_data;
 	tl = &di->id2.i_dealloc;
+	tl_used = le16_to_cpu(tl->tl_used);
 	tl_count = le16_to_cpu(tl->tl_count);
 	if (unlikely(tl_count > ocfs2_truncate_recs_per_inode(osb->sb) ||
-		     tl_count == 0)) {
+		     tl_count == 0 || tl_used > tl_count)) {
 		status = -EFSCORRUPTED;
 		iput(inode);
 		brelse(bh);
diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
index 8c9c4825f984..2785ff245e79 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -302,8 +302,21 @@ static int ocfs2_check_dir_entry(struct inode *dir,
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
@@ -778,6 +791,14 @@ static int ocfs2_dx_dir_lookup_rec(struct inode *inode,
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
@@ -3423,6 +3444,14 @@ static int ocfs2_find_dir_space_id(struct inode *dir, struct buffer_head *di_bh,
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
@@ -4104,10 +4133,15 @@ static int ocfs2_expand_inline_dx_root(struct inode *dir,
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
diff --git a/fs/ocfs2/localalloc.c b/fs/ocfs2/localalloc.c
index d1aa04a5af1b..56be21c695d6 100644
--- a/fs/ocfs2/localalloc.c
+++ b/fs/ocfs2/localalloc.c
@@ -905,13 +905,11 @@ static int ocfs2_local_alloc_find_clear_bits(struct ocfs2_super *osb,
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
index 86f2631e6360..ba4952b41602 100644
--- a/fs/ocfs2/move_extents.c
+++ b/fs/ocfs2/move_extents.c
@@ -98,7 +98,13 @@ static int __ocfs2_move_extent(handle_t *handle,
 
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
@@ -1031,6 +1037,12 @@ int ocfs2_ioctl_move_extents(struct file *filp, void __user *argp)
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
index ae0e44e5f2ad..c501eb3cdcda 100644
--- a/fs/ocfs2/ocfs2_fs.h
+++ b/fs/ocfs2/ocfs2_fs.h
@@ -468,7 +468,8 @@ struct ocfs2_extent_list {
 	__le16 l_reserved1;
 	__le64 l_reserved2;		/* Pad to
 					   sizeof(ocfs2_extent_rec) */
-/*10*/	struct ocfs2_extent_rec l_recs[];	/* Extent records */
+					/* Extent records */
+/*10*/	struct ocfs2_extent_rec l_recs[] __counted_by_le(l_count);
 };
 
 /*
@@ -482,7 +483,8 @@ struct ocfs2_chain_list {
 	__le16 cl_count;		/* Total chains in this list */
 	__le16 cl_next_free_rec;	/* Next unused chain slot */
 	__le64 cl_reserved1;
-/*10*/	struct ocfs2_chain_rec cl_recs[];	/* Chain records */
+					/* Chain records */
+/*10*/	struct ocfs2_chain_rec cl_recs[] __counted_by_le(cl_count);
 };
 
 /*
@@ -494,7 +496,8 @@ struct ocfs2_truncate_log {
 /*00*/	__le16 tl_count;		/* Total records in this log */
 	__le16 tl_used;			/* Number of records in use */
 	__le32 tl_reserved1;
-/*08*/	struct ocfs2_truncate_rec tl_recs[];	/* Truncate records */
+					/* Truncate records */
+/*08*/	struct ocfs2_truncate_rec tl_recs[] __counted_by_le(tl_count);
 };
 
 /*
@@ -638,7 +641,7 @@ struct ocfs2_local_alloc
 	__le16 la_size;		/* Size of included bitmap, in bytes */
 	__le16 la_reserved1;
 	__le64 la_reserved2;
-/*10*/	__u8   la_bitmap[];
+/*10*/	__u8   la_bitmap[] __counted_by_le(la_size);
 };
 
 /*
@@ -651,7 +654,7 @@ struct ocfs2_inline_data
 				 * for data, starting at id_data */
 	__le16	id_reserved0;
 	__le32	id_reserved1;
-	__u8	id_data[];	/* Start of user data */
+	__u8	id_data[] __counted_by_le(id_count);	/* Start of user data */
 };
 
 /*
@@ -796,9 +799,10 @@ struct ocfs2_dx_entry_list {
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
@@ -934,7 +938,8 @@ struct ocfs2_refcount_list {
 	__le16 rl_used;		/* Current number of used records */
 	__le32 rl_reserved2;
 	__le64 rl_reserved1;	/* Pad to sizeof(ocfs2_refcount_record) */
-/*10*/	struct ocfs2_refcount_rec rl_recs[];	/* Refcount records */
+				/* Refcount records */
+/*10*/	struct ocfs2_refcount_rec rl_recs[] __counted_by_le(rl_count);
 };
 
 
@@ -1020,7 +1025,8 @@ struct ocfs2_xattr_header {
 						    buckets.  A block uses
 						    xb_check and sets
 						    this field to zero.) */
-	struct ocfs2_xattr_entry xh_entries[]; /* xattr entry list. */
+						/* xattr entry list. */
+	struct ocfs2_xattr_entry xh_entries[] __counted_by_le(xh_count);
 };
 
 /*
diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
index 6ac4dcd54588..9969a041ab18 100644
--- a/fs/ocfs2/suballoc.c
+++ b/fs/ocfs2/suballoc.c
@@ -649,6 +649,16 @@ ocfs2_block_group_alloc_discontig(handle_t *handle,
 	return status ? ERR_PTR(status) : bg_bh;
 }
 
+static int ocfs2_check_chain_list(struct ocfs2_chain_list *cl,
+				  struct super_block *sb)
+{
+	if (le16_to_cpu(cl->cl_count) != ocfs2_chain_recs_per_inode(sb))
+		return -EINVAL;
+	if (le16_to_cpu(cl->cl_next_free_rec) > le16_to_cpu(cl->cl_count))
+		return -EINVAL;
+	return 0;
+}
+
 /*
  * We expect the block group allocator to already be locked.
  */
@@ -671,6 +681,10 @@ static int ocfs2_block_group_alloc(struct ocfs2_super *osb,
 	BUG_ON(ocfs2_is_cluster_bitmap(alloc_inode));
 
 	cl = &fe->id2.i_chain;
+	status = ocfs2_check_chain_list(cl, alloc_inode->i_sb);
+	if (status)
+		goto bail;
+
 	status = ocfs2_reserve_clusters_with_limit(osb,
 						   le16_to_cpu(cl->cl_cpg),
 						   max_block, flags, &ac);
@@ -1992,6 +2006,9 @@ static int ocfs2_claim_suballoc_bits(struct ocfs2_alloc_context *ac,
 	}
 
 	cl = (struct ocfs2_chain_list *) &fe->id2.i_chain;
+	status = ocfs2_check_chain_list(cl, ac->ac_inode->i_sb);
+	if (status)
+		goto bail;
 
 	victim = ocfs2_find_victim_chain(cl);
 	ac->ac_chain = victim;


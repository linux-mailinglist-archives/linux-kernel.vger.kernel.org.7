Return-Path: <linux-kernel+bounces-875212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95690C18734
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A3F404753
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C283090CD;
	Wed, 29 Oct 2025 06:25:51 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9868E30506D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761719151; cv=none; b=dG0tRssGuUqkxcZJ8oekXbgUZaJtzsFzXVjhZTBQU9Z7mnh/elE3UH86IOVfTv44FLaSFIFDSOPUYH0PZyhTLYvpGaK2v+aF/JDV93gz2QH9zsohw75SOUO5NS4tPketjD6cfubfdt/jqm3huSM/H2pPOff1r/UadTu7D4aPAik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761719151; c=relaxed/simple;
	bh=0/cXk4L8l+PKQK3eP9r+eSHA25lHvBxV0Dgp5J8pIbw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cz42P/7qHiu2q7s6x+miGX/RrvSGAIm0tInoSBR692GVYMOeH6A/U5NIIVAu5TGyK2irsMyBdacLBoOa2veSIZGdQMIYa9SjneehcHL0u812coz6TCxlrw/teZZPnMLHutp7WZOa1ciFqae+XdFw1tGUE+JFfoWUsCHsiaNa5iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430ced58cd2so255119385ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 23:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761719149; x=1762323949;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hmh5hlKO2coyotqBK5FXPA+mevXm+xNh+/bb4ZVq+As=;
        b=Lwv1nP2T/LoWyFAcRbqq8tmmp1pbF+nXgkxcGl1VVdKMLKWC58GTqRzErGKFbHcDXh
         Yclyl84XUtiUV8is6hGCkeZdh4fesDKw49aE8IX412FJog4f4ZO2Da7Z+02We5bBFh/L
         gyULkmVwn+bfPpQcxemF/CjcQ4mS39AMa2zPEXKa+0FuY/wn+8VF7/By+ZkSKpFoPAGa
         Yxo3WhgVbVXnKQB/lgHcMUESTBTCwPNgvbFTT+WayYcImTI/5uYsU46wKQn1Tb3sevy/
         Bk2tx7S+LYLFl/6M8WDC/rp6/eh3d+GtDiWFqm1t2JH6FytnCe3fh6ieGBsHG6u8zul7
         Kxmw==
X-Gm-Message-State: AOJu0YyaRo5XOX8V7UCnG2AcudoJd7nDfEe4Ei1HQe8n+wXkjsgugcsH
	RwOWb8D1/arFVpY1aGdEGywdYesqnIKxi//XcyT74J38s2h2FR3QMf260ZlY9PPbalVJo9P2UiG
	dQV7j4d4SNXxMuFld3RTX1RxVgJC/KgiqJXMayc9XkkqhaOnPLZopcp/mxHI=
X-Google-Smtp-Source: AGHT+IErYjNAEvBh+45LoLTO2aCD2xgju6OkIpbZprCCEJi7wIweC7ScAYrlY+JpvucmcGaY/BlI3bRXgTPSjEEHdad8Sc4KzHxU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3042:b0:42d:8acf:a6e2 with SMTP id
 e9e14a558f8ab-432f9028b7emr25057535ab.15.1761719148848; Tue, 28 Oct 2025
 23:25:48 -0700 (PDT)
Date: Tue, 28 Oct 2025 23:25:48 -0700
In-Reply-To: <68ef030a.050a0220.91a22.022b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901b36c.050a0220.32483.01f2.GAE@google.com>
Subject: Forwarded: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
 linux-6.1.y
From: syzbot <syzbot+77026564530dbc29b854@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.1.y
Author: dmantipov@yandex.ru

diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index 7f11ffacc915..e606826045b5 100644
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
index de6fd4a09ffd..10d0618a0ddf 100644
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
@@ -3416,6 +3437,14 @@ static int ocfs2_find_dir_space_id(struct inode *dir, struct buffer_head *di_bh,
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
diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index a1f3b25ce612..eed39aae08ba 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1419,6 +1419,39 @@ int ocfs2_validate_inode_block(struct super_block *sb,
 		goto bail;
 	}
 
+	if (le32_to_cpu(di->i_flags) & OCFS2_CHAIN_FL) {
+		struct ocfs2_chain_list *cl = &di->id2.i_chain;
+		u16 bpc = 1 << (OCFS2_SB(sb)->s_clustersize_bits -
+				sb->s_blocksize_bits);
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
+		if (le16_to_cpu(cl->cl_bpc) != bpc) {
+			rc = ocfs2_error(sb, "Invalid dinode %llu: bits per cluster %u\n",
+					 (unsigned long long)bh->b_blocknr,
+					 le16_to_cpu(cl->cl_bpc));
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
diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
index b1e32ec4a9d4..6acf13adfb55 100644
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
@@ -1032,6 +1038,12 @@ int ocfs2_ioctl_move_extents(struct file *filp, void __user *argp)
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
 


Return-Path: <linux-kernel+bounces-868203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DD7C04A2C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F8C94E9CB1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017B529D26E;
	Fri, 24 Oct 2025 07:11:55 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A379017C21B
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761289915; cv=none; b=uYhHizJlhOS3KIy3C64sGEZlY3e1l7+3mBGY0354xF0x+GKeHJqMMTghHBv8d4U91PB71RCxVpBGoH2bMc/ZqS/DtNssmee+Esk0S65tK/E6hiLNa3xpaH/JWQ0mVrndqSUSWEytC8jxAFLnwYnRQlMJ21uqk8z5U5hO/NOTy9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761289915; c=relaxed/simple;
	bh=SXJfJtiE5Ky3tGlLfbtaV1tKKsFiqotPd5Cl/z6zKdY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TkuddUwR873viSnYJ1ElrvkLXY4P2GXCWoUdvPuNP//SzXQSDpoRJTDWIDeWiFJM6DstLxqFowl54TYY24sHfnwaeiBO+8qxWbczeUFqaeA4kI0jnF1h0E5wvEtE4TMdLXAv8+BURUZ5neSYVLSiqddaDBA1pKBZkpBrWcEvis0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430d082fc3dso57456705ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:11:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761289913; x=1761894713;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QIQY9VFqEri0OxFmGZz0WjavuIEMClhC7PHFAuUsZYE=;
        b=APADQ7mBsvYHkrD63gQm3RM9hRiMXBrHtgMQQA/Q6+lYyIXovLMypzsBh8ctwQtJwx
         JiP37/BaVPWharPspmjEzbUjjJBrFeTvcEai1KvEuu0xVwjFQ3VmkFjppZSNyvNMrXkY
         JOsdsy0Jln9NdOAXBLJkMwJMFdq77bsjfnt6jMtVJtxewQVmt2PwzKzTLwWZ4j2PPc//
         9h+7L9Tkfc3+Lif0Ch44uv/SD46aU1d+Tpjilt0v4/IfH6KEqlzYvOdWiF/rNDnTa3sQ
         x1LjM3SgPuPhqY+zSGnvrOctUh1jzXfik6n7JfHefrIBsJRIAfAnNM/b6JxF/jOkzh8w
         osQg==
X-Gm-Message-State: AOJu0Yw5rZKl50HSPRcmh7RLTAv/iKxZhqNZtPmB/w//+O9vFMaL6M6W
	5BDikgNuvwUYJJYO4Vqxb8M7FX/33P9QIkoiUu5TELYNF5EtHdFdJEK/g5+zULyHOAYstqWJKwc
	ByvaD0a6ewGSLH4a/vo4k1jnHXGcmnjidRQzYuNKveBQWAYGLKDKsfeU6Kgg=
X-Google-Smtp-Source: AGHT+IG41QY96JeCthIsoVxnTuoeGLv5/D+PTuS2alSVQ9ARc6OeuVozgL6lpLBpuehh4tT2xZ4wABuAAj/GwkPagTBKhfLvSLkX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c248:0:b0:430:b05a:ecbe with SMTP id
 e9e14a558f8ab-431ebeb3a9bmr19220535ab.4.1761289912833; Fri, 24 Oct 2025
 00:11:52 -0700 (PDT)
Date: Fri, 24 Oct 2025 00:11:52 -0700
In-Reply-To: <68d913e1.050a0220.1696c6.0003.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb26b8.050a0220.346f24.0096.GAE@google.com>
Subject: Forwarded: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
 linux-5.10.y
From: syzbot <syzbot+30b53487d00b4f7f0922@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-5.10.y
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
index 195515eefd33..364c7e5f23c5 100644
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
diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 7c9dfd50c1c1..a25af01463cf 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1418,6 +1418,14 @@ int ocfs2_validate_inode_block(struct super_block *sb,
 		goto bail;
 	}
 
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
 
diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
index 4f48003e4327..41254d625691 100644
--- a/fs/ocfs2/suballoc.c
+++ b/fs/ocfs2/suballoc.c
@@ -647,6 +647,16 @@ ocfs2_block_group_alloc_discontig(handle_t *handle,
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
@@ -669,6 +679,10 @@ static int ocfs2_block_group_alloc(struct ocfs2_super *osb,
 	BUG_ON(ocfs2_is_cluster_bitmap(alloc_inode));
 
 	cl = &fe->id2.i_chain;
+	status = ocfs2_check_chain_list(cl, alloc_inode->i_sb);
+	if (status)
+		goto bail;
+
 	status = ocfs2_reserve_clusters_with_limit(osb,
 						   le16_to_cpu(cl->cl_cpg),
 						   max_block, flags, &ac);
@@ -1925,6 +1939,9 @@ static int ocfs2_claim_suballoc_bits(struct ocfs2_alloc_context *ac,
 	}
 
 	cl = (struct ocfs2_chain_list *) &fe->id2.i_chain;
+	status = ocfs2_check_chain_list(cl, ac->ac_inode->i_sb);
+	if (status)
+		goto bail;
 
 	victim = ocfs2_find_victim_chain(cl);
 	ac->ac_chain = victim;


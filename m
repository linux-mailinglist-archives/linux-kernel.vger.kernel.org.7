Return-Path: <linux-kernel+bounces-868233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC1DC04AC1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077301AA7111
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1692E4278;
	Fri, 24 Oct 2025 07:15:36 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B122DFA24
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761290135; cv=none; b=t7/CEHYRRLHmYkjdZB8xHdfw/xd4r9IQlle+ieHqLJDM4xizVSAybgfOWvhQIDIXu8n+vFdtnWy+Vu8EVB3IKWV9+00rA6C5P7Cd9+5wIa3s7VHynrin8zSL02vxnH9gTf/EdMx7elTJTxw7JVZYlEu2+PDvo7IVUx68BIR8cRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761290135; c=relaxed/simple;
	bh=7Sdc4uebgehtj4hi7UcMKz/mN6yMMjbMXMDZOAUi5Eo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cmCnWJiNGjN0x4x2Ici09j/Nvq0p/5kZwVelCBr8LeTPfBPvYvyGQrlolLTC1yW92LjyrWxJZF9lEXBhQTv/BQ96Zv6d0N63IRJEurpn14Wtn1c7M8F/kiFUpwh5WnWT3xFExdoaqBfLTH/inBg+9yPH3mkgWmxjvGWW14eiX6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-93e8d8d227bso506522839f.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761290133; x=1761894933;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O3cg6x2q5zImhN00OrsLOUsagO0FWbKewBvQIPvJjzY=;
        b=YJmVZXO55Jz9T9K8xJqW1xscxyqxhFgMGppuzoYfzQIB3GMuxV+rW0OHLjmx6T0dE5
         bzEa92sLC1jY7bibaOCgdzSGQhSSma1uUo7ppS1vqWhT4rdDtwl3X/I94t8xd7+jR5P5
         ai+lZnZkRotmUGuLTQ9BmGG67GzgGMB9NvJQAex2tDzYdvLUR9RRbFyhqwFeDCSrDp7W
         pWiDDRNBzh497GizJU5KaTkY/vkOSyWadOTeLxvTGMa0wTGEwFtv8yM6Zo2qd5oCSzgH
         bLlQBW96cmEpAN2lnrUXGeJszVk28XciFBaY3Z8XKfpdlpdmCRAhVIqxCwi6wmYwUErb
         wsUA==
X-Gm-Message-State: AOJu0YyNbwDK1kHUMPVlyOmZqZ9fx1ZXO1WYRLMDC2FeuWHXZ8Ry9ukS
	VyJw1jAwOSwCTwdUuDiBvzRJWnrq/ao1BZdKfgAxJljdHk72nZonV3Jmm/dFbrH2uj6wj1j+gDu
	QEax6yhpZquWO/NgnTcKBnLxytDIo33dCPFV1GJGT0/JYvtR1LCQGkxHg/2Q=
X-Google-Smtp-Source: AGHT+IFIN6iO9d3jMVziejI+P2wRe/+cYv6koMEThmCDchOZePIgT7bSouGO8/SbnpG7Rs2sm2wwUk18q8fTL6V7wXVquVOZEliW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b8e:b0:93e:8d3c:7ceb with SMTP id
 ca18e2360f4ac-93e8d3c7fe5mr3157386839f.9.1761290132562; Fri, 24 Oct 2025
 00:15:32 -0700 (PDT)
Date: Fri, 24 Oct 2025 00:15:32 -0700
In-Reply-To: <68e48f33.a00a0220.298cc0.046e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb2794.a70a0220.3bf6c6.0143.GAE@google.com>
Subject: Forwarded: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
 linux-6.12.y
From: syzbot <syzbot+727d161855d11d81e411@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.12.y
Author: dmantipov@yandex.ru

diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index 5d9388b44e5b..b84e164c6314 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -6162,6 +6162,9 @@ static int ocfs2_get_truncate_log_info(struct ocfs2_super *osb,
 	int status;
 	struct inode *inode = NULL;
 	struct buffer_head *bh = NULL;
+	struct ocfs2_dinode *di;
+	struct ocfs2_truncate_log *tl;
+	unsigned int tl_count, tl_used;
 
 	inode = ocfs2_get_system_file_inode(osb,
 					   TRUNCATE_LOG_SYSTEM_INODE,
@@ -6179,6 +6182,19 @@ static int ocfs2_get_truncate_log_info(struct ocfs2_super *osb,
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
index 7799f4d16ce9..46f392374388 100644
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
@@ -3415,6 +3436,14 @@ static int ocfs2_find_dir_space_id(struct inode *dir, struct buffer_head *di_bh,
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
index 4a7509389cf3..41310d2b937c 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1419,6 +1419,14 @@ int ocfs2_validate_inode_block(struct super_block *sb,
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
index f9d6a4f9ca92..b10c8acd469b 100644
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


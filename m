Return-Path: <linux-kernel+bounces-833540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA90BA244C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 04:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9CF1C28144
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 02:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40305239594;
	Fri, 26 Sep 2025 02:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ErkBwIxn"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8F68287E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758855454; cv=none; b=rnzqDZuvpSLaQ3XXnP40K+ROgwCqM8v8pfQ55bdBgsf0bpMfR6zuF5oLuUa3AwwGT7za9Q9YrSIr7t1XmC4KAr1PP2h/gUy60bNVL2AXsuhpNO4Ug+P9kLmUIo3TPLqq84sTeJ9mLkhvUQCtCXctLPzMI27SijMIJsyjPGA70Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758855454; c=relaxed/simple;
	bh=0seR/PPCeNmqCqEO+CWxl4vQFh/Swbrz7dNPOFg2U8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NYu/52SFRbTi2hDMxcbRlP9Q43BkjduHqS8K1XJxF4P7vjkGG/isM6OqotNjuwPPpttwFQuZxZqyDrTR4cmlie1S9QRIHB4vrkAWy1GPS7qYcnta1FtIDGgvkOe5GHZxtRBPJrt/AU9xRBrLmum/ZtWuRYeukGwKE3kYgwb8jwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ErkBwIxn; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758855449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KMI3PZUF0sh3zSd/02iYpfvXrjt5XLvTI4LxgYH0VXg=;
	b=ErkBwIxniq2ZxzhmdPHgOou7mR8kgIHkwtskgQaDy9V/FGhbFnOyVVnrBzuT+F4NiFAiI7
	+jSJd3wxQJbdNeefgRygLePWLrxMkSj/OvrNAH2WsWKnwT3Bs2jLOo0ZO1RgXlMZfgQZ2y
	LJEPJyPfI0IOwlSrcJ6X9WNFd5M6gao=
From: Youling Tang <youling.tang@linux.dev>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH] gfs2: Move i_nlink checks from gfs2_{link,rename,mkdir} to VFS layer
Date: Fri, 26 Sep 2025 10:56:04 +0800
Message-ID: <20250926025604.500713-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

vfs_{link, rename, mkdir} will check i_nlink. When sb->s_max_links is set,
set sb->s_max_links in gfs2 to simplify the code.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 fs/gfs2/gfs2.h       |  1 +
 fs/gfs2/inode.c      | 10 ----------
 fs/gfs2/ops_fstype.c |  1 +
 3 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/gfs2/gfs2.h b/fs/gfs2/gfs2.h
index ed78e5f20f41..06a7f731d34c 100644
--- a/fs/gfs2/gfs2.h
+++ b/fs/gfs2/gfs2.h
@@ -18,6 +18,7 @@ enum {
 };
 
 #define GFS2_FAST_NAME_SIZE 8
+#define GFS2_LINK_MAX	0xffffffff
 
 #endif /* __GFS2_DOT_H__ */
 
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 8760e7e20c9d..f2a6420e1fa8 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -373,8 +373,6 @@ static int create_ok(struct gfs2_inode *dip, const struct qstr *name,
 
 	if (dip->i_entries == (u32)-1)
 		return -EFBIG;
-	if (S_ISDIR(mode) && dip->i_inode.i_nlink == (u32)-1)
-		return -EMLINK;
 
 	return 0;
 }
@@ -1079,9 +1077,6 @@ static int gfs2_link(struct dentry *old_dentry, struct inode *dir,
 	error = -EPERM;
 	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
 		goto out_gunlock;
-	error = -EMLINK;
-	if (ip->i_inode.i_nlink == (u32)-1)
-		goto out_gunlock;
 
 	error = gfs2_diradd_alloc_required(dir, &dentry->d_name, &da);
 	if (error < 0)
@@ -1623,11 +1618,6 @@ static int gfs2_rename(struct inode *odir, struct dentry *odentry,
 				error = -EFBIG;
 				goto out_gunlock;
 			}
-			if (S_ISDIR(ip->i_inode.i_mode) &&
-			    ndip->i_inode.i_nlink == (u32)-1) {
-				error = -EMLINK;
-				goto out_gunlock;
-			}
 		}
 	}
 
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index efe99b732551..823f3d987d6c 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1152,6 +1152,7 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb_dqopt(sb)->flags |= DQUOT_QUOTA_SYS_FILE;
 	sb->s_time_gran = 1;
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
+	sb->s_max_links = GFS2_LINK_MAX;
 
 	/* Set up the buffer cache and fill in some fake block size values
 	   to allow us to read-in the on-disk superblock. */
-- 
2.43.0



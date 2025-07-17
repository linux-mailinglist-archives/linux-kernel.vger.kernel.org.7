Return-Path: <linux-kernel+bounces-734600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9B8B083BB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0DC27B7F48
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 04:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470681DF256;
	Thu, 17 Jul 2025 04:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kcT22tuW"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8787810E3
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 04:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752726217; cv=none; b=FPvXZA5WS3pqu9bbkwFsMg2UsnVcf4JkUDbhxiwDsfa6PyiyJhRF949gxW7Ho4W5wx6Dgl0cqgtRA1+sbCluSwt7UbFT7rTWBXBmvcbtJ3uqaa8tViZUeXvfy7Nf+Hqe6Kkr3rUQq/OhcmX2d70UYU1tV4NNjGgYvhrj/2fmuQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752726217; c=relaxed/simple;
	bh=Im9FeDXQAUHxP9VLKg9BHpwXuY8l9GyoobCQSMnOqhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tqfKx7BrqEMR4MUxHhwLDSewTq+VbHiauYoK9UJxt4mzb9C6IKFsGFL9Wi+K9B1TtWLtCktP+Rs4tsXfriEi/EN5Tht4n0A0sAvgcOnn6gnNoIJjAsIKWYQgXTInYYWg6EzdjflVSC8fOvN29laxJ66adAWeEwZlDEFzbF9oLXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kcT22tuW; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752726205; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=rVocjUTMdqY3F7MTEp23/vxTEANqAcDzbPzEjqdDKQw=;
	b=kcT22tuWP3US5ACSB+UlgTlaFzxhchuNBSH4fBqWz75JwulUnXobXaFvrXQE4MME93z8avhjCjzWPFGnHN9SMosIIR6txt7PIb2fjbubmuVrZ9ByGP2XaOvjvLACwifnpeGq5ae/D6hUArjVWQuwQN4rpTS3G1nys7mJRHnDL2c=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj6ptJp_1752726199 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Jul 2025 12:23:25 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: remove ENOATTR definition
Date: Thu, 17 Jul 2025 12:23:17 +0800
Message-ID: <20250717042317.1218597-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ENOATTR is not defined in Linux; use ENODATA instead.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/xattr.c | 32 ++++++++++++++++----------------
 fs/erofs/xattr.h |  3 ---
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 9cf84717a92e..d61110f511e0 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -72,7 +72,7 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 			ret = -EFSCORRUPTED;
 			goto out_unlock;	/* xattr ondisk layout error */
 		}
-		ret = -ENOATTR;
+		ret = -ENODATA;
 		goto out_unlock;
 	}
 
@@ -266,20 +266,20 @@ static int erofs_getxattr_foreach(struct erofs_xattr_iter *it)
 			(entry.e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
 
 		if (pf >= sbi->xattr_prefixes + sbi->xattr_prefix_count)
-			return -ENOATTR;
+			return -ENODATA;
 
 		if (it->index != pf->prefix->base_index ||
 		    it->name.len != entry.e_name_len + pf->infix_len)
-			return -ENOATTR;
+			return -ENODATA;
 
 		if (memcmp(it->name.name, pf->prefix->infix, pf->infix_len))
-			return -ENOATTR;
+			return -ENODATA;
 
 		it->infix_len = pf->infix_len;
 	} else {
 		if (it->index != entry.e_name_index ||
 		    it->name.len != entry.e_name_len)
-			return -ENOATTR;
+			return -ENODATA;
 
 		it->infix_len = 0;
 	}
@@ -295,7 +295,7 @@ static int erofs_getxattr_foreach(struct erofs_xattr_iter *it)
 				entry.e_name_len - processed);
 		if (memcmp(it->name.name + it->infix_len + processed,
 			   it->kaddr, slice))
-			return -ENOATTR;
+			return -ENODATA;
 		it->pos += slice;
 	}
 
@@ -323,7 +323,7 @@ static int erofs_xattr_iter_inline(struct erofs_xattr_iter *it,
 			  sizeof(u32) * vi->xattr_shared_count;
 	if (xattr_header_sz >= vi->xattr_isize) {
 		DBG_BUGON(xattr_header_sz > vi->xattr_isize);
-		return -ENOATTR;
+		return -ENODATA;
 	}
 
 	remaining = vi->xattr_isize - xattr_header_sz;
@@ -347,7 +347,7 @@ static int erofs_xattr_iter_inline(struct erofs_xattr_iter *it,
 			ret = erofs_getxattr_foreach(it);
 		else
 			ret = erofs_listxattr_foreach(it);
-		if ((getxattr && ret != -ENOATTR) || (!getxattr && ret))
+		if ((getxattr && ret != -ENODATA) || (!getxattr && ret))
 			break;
 
 		it->pos = next_pos;
@@ -362,7 +362,7 @@ static int erofs_xattr_iter_shared(struct erofs_xattr_iter *it,
 	struct super_block *const sb = it->sb;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	unsigned int i;
-	int ret = -ENOATTR;
+	int ret = -ENODATA;
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
 		it->pos = erofs_pos(sb, sbi->xattr_blkaddr) +
@@ -375,7 +375,7 @@ static int erofs_xattr_iter_shared(struct erofs_xattr_iter *it,
 			ret = erofs_getxattr_foreach(it);
 		else
 			ret = erofs_listxattr_foreach(it);
-		if ((getxattr && ret != -ENOATTR) || (!getxattr && ret))
+		if ((getxattr && ret != -ENODATA) || (!getxattr && ret))
 			break;
 	}
 	return ret;
@@ -403,7 +403,7 @@ int erofs_getxattr(struct inode *inode, int index, const char *name,
 				EROFS_XATTR_FILTER_SEED + index);
 		hashbit &= EROFS_XATTR_FILTER_BITS - 1;
 		if (vi->xattr_name_filter & (1U << hashbit))
-			return -ENOATTR;
+			return -ENODATA;
 	}
 
 	it.index = index;
@@ -419,7 +419,7 @@ int erofs_getxattr(struct inode *inode, int index, const char *name,
 	it.buffer_ofs = 0;
 
 	ret = erofs_xattr_iter_inline(&it, inode, true);
-	if (ret == -ENOATTR)
+	if (ret == -ENODATA)
 		ret = erofs_xattr_iter_shared(&it, inode, true);
 	erofs_put_metabuf(&it.buf);
 	return ret ? ret : it.buffer_ofs;
@@ -432,7 +432,7 @@ ssize_t erofs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 	struct inode *inode = d_inode(dentry);
 
 	ret = erofs_init_inode_xattrs(inode);
-	if (ret == -ENOATTR)
+	if (ret == -ENODATA)
 		return 0;
 	if (ret)
 		return ret;
@@ -446,9 +446,9 @@ ssize_t erofs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 	it.buffer_ofs = 0;
 
 	ret = erofs_xattr_iter_inline(&it, inode, false);
-	if (!ret || ret == -ENOATTR)
+	if (!ret || ret == -ENODATA)
 		ret = erofs_xattr_iter_shared(&it, inode, false);
-	if (ret == -ENOATTR)
+	if (ret == -ENODATA)
 		ret = 0;
 	erofs_put_metabuf(&it.buf);
 	return ret ? ret : it.buffer_ofs;
@@ -539,7 +539,7 @@ struct posix_acl *erofs_get_acl(struct inode *inode, int type, bool rcu)
 		rc = erofs_getxattr(inode, prefix, "", value, rc);
 	}
 
-	if (rc == -ENOATTR)
+	if (rc == -ENODATA)
 		acl = NULL;
 	else if (rc < 0)
 		acl = ERR_PTR(rc);
diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
index b246cd0e135e..6317caa8413e 100644
--- a/fs/erofs/xattr.h
+++ b/fs/erofs/xattr.h
@@ -10,9 +10,6 @@
 #include <linux/posix_acl_xattr.h>
 #include <linux/xattr.h>
 
-/* Attribute not found */
-#define ENOATTR         ENODATA
-
 #ifdef CONFIG_EROFS_FS_XATTR
 extern const struct xattr_handler erofs_xattr_user_handler;
 extern const struct xattr_handler erofs_xattr_trusted_handler;
-- 
2.43.5



Return-Path: <linux-kernel+bounces-793532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB903B3D4DD
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 21:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8634B171577
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 19:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E24277026;
	Sun, 31 Aug 2025 19:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="FcU/8u0a";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="c9+p4grr"
Received: from e2i440.smtp2go.com (e2i440.smtp2go.com [103.2.141.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A59A2765CF
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 19:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756667892; cv=none; b=PhcTEGLkmcTSf/LakQOp4QITwDB/UZCCwOWThGmFoV1jtMe3ldsgtDL5JeEV5ughuY2ETtQ3eoiI8WIWf+8rEcQ0HWqRgAJMektl3MtIFZPhy8JTjt+PRVaNiorZPnz5hP7yYNKitrIyLGY4dXr5/vNeLidKLrfOiwJWQ3EPKIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756667892; c=relaxed/simple;
	bh=noS+kgMmxX8muhCHIL4ebldoM9H0GvBRTQfjg8aEObA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rAChl0hcZ0TZW3S1uvWwuRAXkbUJ6qxZPBcgKa/Zrd+kOo/HmjPMPt+OXK236ubkuv5RCgyUESR0He5lGrttb9jyX9IPCq70M6Jxbb+0qUfkZ58Qr/qkw6QAf26clJptOkf2z6/MAa2eRZomzj8a9mhS8U/RPg1LfyIyjiKrcj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=FcU/8u0a reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=c9+p4grr; arc=none smtp.client-ip=103.2.141.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1756668791; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=AuxgjfyP3UBc+gUkj22v5jGjbDAYXrisj6AZ7faAvo0=; b=FcU/8u0aZ0W+pP0GusvL8AEkby
	YJ/oHjwj2LfRFUziqkfE+TW1ygVcd4BF9bQOEW8zRRcctBs3qaA6EXJyeefgFyQv0gVWeh4imGq8I
	MktFq24f8W7FaC5SCHuYChPp4C7qy1YJywXINsvW5bylhnxkzBBG04tKfDnnqhQrZxD2O87sLzVgl
	Cu7r20vWtR/CRsnW9V7HdoFbQQJKCq0hYN4SCVjHboJsjAEOmkFpzTOEl1Bkgppq66XhSaby7kBb/
	LbllkLhjI9o37XxVo7+/9ab+y11DdFNjhw2QfxnF2zMFqnitpY4lZDxcZVoz8rc6/zT8rGVCrNBbn
	ArcxFECg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1756667891; h=from : subject
 : to : message-id : date;
 bh=AuxgjfyP3UBc+gUkj22v5jGjbDAYXrisj6AZ7faAvo0=;
 b=c9+p4grrbRcdJnzc9JygixYE576mkZqwl5b2ZqlaUh1ZR3RNddNLLvWKtefhxQ7AmC3LB
 UfZoO52ugcq41slaufFmduw02ls8O3U2g1TdJ9hx0PNfFiGB75vesfLqUYjfI3zIuA3j+FH
 MsqLf9YsDn+Hz9q3kBIqeuQ0gkwevsbnZ+nez93q72IhYGlSkhaErTInv/IrMiNQYRbWvvi
 MTNJZ5JqWrumbgWRtmI7PKSWiTvmr+E8MfdRNE2pQqKt6dzsNvVAegaQCURVCUIJjMwPrYt
 M0soPseBcDR9XeTDhlmamxV3Qzac8CyOmGq+gAL5l4GlTWgtBmNMK6UqDzyQ==
Received: from [10.172.233.58] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1usnYs-TRk4P7-3h; Sun, 31 Aug 2025 19:17:58 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1usnYr-FnQW0hPx3P7-nSON; Sun, 31 Aug 2025 19:17:57 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [RFC PATCH 3/5] 9p: Enable symlink caching in page cache
Date: Sun, 31 Aug 2025 21:03:41 +0200
Message-ID: <52e0e743e006801cb4bcf8322e80704964cf6e25.1756635044.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1756635044.git.repk@triplefau.lt>
References: <cover.1756635044.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: 2M6nbK3eKMXE.uJVbJ8JZOjW4.GMVGSgDBV1N
Feedback-ID: 510616m:510616apGKSTK:510616sApJDVklct
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Currently, when cache=loose is enabled, file reads are cached in the
page cache, but symlink reads are not. This patch allows the results
of p9_client_readlink() to be stored in the page cache, eliminating
the need for repeated 9P transactions on subsequent symlink accesses.

This change improves performance for workloads that involve frequent
symlink resolution.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 fs/9p/v9fs.h           |  1 +
 fs/9p/vfs_inode.c      |  7 +++-
 fs/9p/vfs_inode_dotl.c | 94 +++++++++++++++++++++++++++++++++++++-----
 3 files changed, 90 insertions(+), 12 deletions(-)

diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index 8c5fa0f7ba71..f48a85b610e3 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -186,6 +186,7 @@ extern struct inode *v9fs_inode_from_fid(struct v9fs_session_info *v9ses,
 					 struct super_block *sb, int new);
 extern const struct inode_operations v9fs_dir_inode_operations_dotl;
 extern const struct inode_operations v9fs_file_inode_operations_dotl;
+extern const struct address_space_operations v9fs_symlink_aops_dotl;
 extern const struct inode_operations v9fs_symlink_inode_operations_dotl;
 extern const struct netfs_request_ops v9fs_req_ops;
 extern struct inode *v9fs_inode_from_fid_dotl(struct v9fs_session_info *v9ses,
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 89eeb2b3ba43..362e39b3e7eb 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -302,10 +302,13 @@ int v9fs_init_inode(struct v9fs_session_info *v9ses,
 			goto error;
 		}
 
-		if (v9fs_proto_dotl(v9ses))
+		if (v9fs_proto_dotl(v9ses)) {
 			inode->i_op = &v9fs_symlink_inode_operations_dotl;
-		else
+			inode->i_mapping->a_ops = &v9fs_symlink_aops_dotl;
+			inode_nohighmem(inode);
+		} else {
 			inode->i_op = &v9fs_symlink_inode_operations;
+		}
 
 		break;
 	case S_IFDIR:
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 5b5fda617b80..2e2119be1d49 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -126,8 +126,10 @@ static struct inode *v9fs_qid_iget_dotl(struct super_block *sb,
 		goto error;
 
 	v9fs_stat2inode_dotl(st, inode, 0);
-	v9fs_set_netfs_context(inode);
-	v9fs_cache_inode_get_cookie(inode);
+	if (inode->i_mapping->a_ops == &v9fs_addr_operations) {
+		v9fs_set_netfs_context(inode);
+		v9fs_cache_inode_get_cookie(inode);
+	}
 	retval = v9fs_get_acl(inode, fid);
 	if (retval)
 		goto error;
@@ -858,24 +860,23 @@ v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct inode *dir,
 }
 
 /**
- * v9fs_vfs_get_link_dotl - follow a symlink path
+ * v9fs_vfs_get_link_nocache_dotl - Resolve a symlink directly.
+ *
+ * To be used when symlink caching is not enabled.
+ *
  * @dentry: dentry for symlink
  * @inode: inode for symlink
  * @done: destructor for return value
  */
-
 static const char *
-v9fs_vfs_get_link_dotl(struct dentry *dentry,
-		       struct inode *inode,
-		       struct delayed_call *done)
+v9fs_vfs_get_link_nocache_dotl(struct dentry *dentry,
+			       struct inode *inode,
+			       struct delayed_call *done)
 {
 	struct p9_fid *fid;
 	char *target;
 	int retval;
 
-	if (!dentry)
-		return ERR_PTR(-ECHILD);
-
 	p9_debug(P9_DEBUG_VFS, "%pd\n", dentry);
 
 	fid = v9fs_fid_lookup(dentry);
@@ -889,6 +890,75 @@ v9fs_vfs_get_link_dotl(struct dentry *dentry,
 	return target;
 }
 
+/**
+ * v9fs_symlink_read_folio_dotl - Fetch a symlink path and store it in buffer
+ * cache.
+ * @file: file associated to symlink (NULL)
+ * @folio: folio where to store the symlink resolve result
+ */
+static int v9fs_symlink_read_folio_dotl(struct file *file,
+					struct folio *folio)
+{
+	struct inode *inode = folio->mapping->host;
+	struct dentry *dentry;
+	struct p9_fid *fid;
+	char *target;
+	size_t len;
+	int ret = -EIO;
+
+	/* Does not expect symlink inode to have a fid as it as not been
+	 * opened>
+	 */
+	dentry = d_find_alias(inode);
+	if (!dentry)
+		goto out;
+
+	fid = v9fs_fid_lookup(dentry);
+	dput(dentry);
+	if (IS_ERR(fid)) {
+		ret = PTR_ERR(fid);
+		goto out;
+	}
+
+	ret = p9_client_readlink(fid, &target);
+	p9_fid_put(fid);
+	if (ret)
+		goto out;
+
+	len = strnlen(target, PAGE_SIZE - 1);
+	target[len] = '\0';
+	memcpy_to_folio(folio, 0, target, len);
+	kfree(target);
+
+	ret = 0;
+out:
+	folio_end_read(folio, ret == 0);
+	return ret;
+}
+
+/**
+ * v9fs_vfs_get_link_dotl - follow a symlink path
+ * @dentry: dentry for symlink
+ * @inode: inode for symlink
+ * @done: destructor for return value
+ */
+static const char *
+v9fs_vfs_get_link_dotl(struct dentry *dentry,
+		       struct inode *inode,
+		       struct delayed_call *done)
+{
+	struct v9fs_session_info *v9ses;
+
+	if (!dentry)
+		return ERR_PTR(-ECHILD);
+
+	v9ses = v9fs_inode2v9ses(inode);
+	if (v9ses->cache & (CACHE_META|CACHE_LOOSE))
+		return page_get_link(dentry, inode, done);
+
+	return v9fs_vfs_get_link_nocache_dotl(dentry, inode, done);
+}
+
 int v9fs_refresh_inode_dotl(struct p9_fid *fid, struct inode *inode)
 {
 	struct p9_stat_dotl *st;
@@ -945,6 +1015,10 @@ const struct inode_operations v9fs_file_inode_operations_dotl = {
 	.set_acl = v9fs_iop_set_acl,
 };
 
+const struct address_space_operations v9fs_symlink_aops_dotl = {
+	.read_folio = v9fs_symlink_read_folio_dotl,
+};
+
 const struct inode_operations v9fs_symlink_inode_operations_dotl = {
 	.get_link = v9fs_vfs_get_link_dotl,
 	.getattr = v9fs_vfs_getattr_dotl,
-- 
2.50.1



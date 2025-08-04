Return-Path: <linux-kernel+bounces-755323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D695B1A4ED
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 027F9188573D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9948685C4A;
	Mon,  4 Aug 2025 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b="V3RCaURJ"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C1E271454
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 14:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754317813; cv=none; b=S1R53d4E++5NGUkIpYR5gMhvs1OikcKMoOM83JsuLSb9EIGVScFcmMeN3HR04vbEI7ci5MATRGMutONo2P7Y9WXvf3iSsmUlaTaZjMj+E+304OT8NkAjqXr9nmhK5ZzunHKGiuu0Y7wyan+LT+WiisTO6G+P5BtPEAuJcX3MrtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754317813; c=relaxed/simple;
	bh=vOhM1WDwKbxtwP6MWTAYZPPXSuvwL3HbHvgqmozT4so=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YL2FD7Mun/Wvnl2nC4DQ9A2hEXboJiaLd70yYK4cZoR3Df3oWv86Nz3zhecU/SQJcL6RkQQemKIAwlHWzpGzV2ZERyXb77nLO0n6Wh6hBLPxyajVN/ghZm9HQfcrg48DibQ2vF4prYr6c6NHirO5caB9Ddti3LP1OI1G8cHTd/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b=V3RCaURJ; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 8C2D1240027
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 16:30:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
	s=1984.ea087b; t=1754317804;
	bh=FX/9UQVkeDjyPuGF6cc+lI3qMAx7TkJ3KE7l6pdC5nA=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:From;
	b=V3RCaURJXuCRplRp5sKAGLBgEHofzoF9XJB5NRAsfwT87+q9lcdVYhJGUiHjFvcxT
	 qzLmTlu+ES09hVqUE0nyCTQRi4n2B56qBnmLNvfnXaaB3RfY8N4gyWdB0EOMn+4JZn
	 z5L/no1Fs/t1Wa9awnHicb+dCKo29c51sDSRiAQXjCL9QuchVAYl+IHh8DMVnGXp77
	 LtdpUcamT2l9izHwLWJoL6nB1YIZtYoH4Fneh+PGFSXH5M0L8e5AOsqVWn3nCMr4Qg
	 J6uXsx5pMqt+2/b6P/fx9CU+IPIiXFPUB0Jf+eA3HjohoqIlMKngchnEYr54OV1rQI
	 2/M3d+PN7S0i1Cpr37QRGoXAMTP1KjQPeNNen6HKZGGQo1stiSSmOC96d+BIz7QM72
	 6HuApHwWDIudX6r9fjZqmvDBVaBl7dzKcIJaSFB9OdLQnzYCWJY2lJG5/5NIfkQrsv
	 XirU7LibnfPtu1+uIq0SBL0EgqmqkwHtFLgZaeRANBLfI0+KDig
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4bwf8q2G3yz9rxF;
	Mon,  4 Aug 2025 16:30:03 +0200 (CEST)
From: Charalampos Mitrodimas <charmitro@posteo.net>
Date: Mon, 04 Aug 2025 14:30:04 +0000
Subject: [PATCH] debugfs: fix mount options not being applied
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-debugfs-mount-opts-v1-1-bc05947a80b5@posteo.net>
X-B4-Tracking: v=1; b=H4sIAOrDkGgC/x3MQQ5AMBBA0avIrE1SjSKuIhbotGahlQ4iEXfXW
 L7F/w8IJSaBvngg0cXCMWRUZQHLOgVPyDYbtNJGdapGS/PpneAWz3Bg3A9BPTWdbdu6cspADvd
 Eju9/Oozv+wERHb99ZAAAAA==
X-Change-ID: 20250804-debugfs-mount-opts-2a68d7741f05
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
 Eric Sandeen <sandeen@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
 Charalampos Mitrodimas <charmitro@posteo.net>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754317803; l=2543;
 i=charmitro@posteo.net; s=20250727; h=from:subject:message-id;
 bh=vOhM1WDwKbxtwP6MWTAYZPPXSuvwL3HbHvgqmozT4so=;
 b=k2OqEw9TfWMSFMZu5uCENR7MNVYuMjL2EfTVC9RcfC1tbiDfne3GZevpY3TvF8ZGvNVQsXZS6
 pPlBVJctWyRCjG82wKpuvCV5Q+cxzL/ASxjWTYq6rS3gFhgwIeLhX/6
X-Developer-Key: i=charmitro@posteo.net; a=ed25519;
 pk=/tpM70o3uGkbo2oePEdVimUYLyVTgpnPq4nwoG0pFsM=

Mount options (uid, gid, mode) are silently ignored when debugfs is
mounted. This is a regression introduced during the conversion to the
new mount API.

When the mount API conversion was done, the line that sets
sb->s_fs_info to the parsed options was removed. This causes
debugfs_apply_options() to operate on a NULL pointer.

As an example, with the bug the "mode" mount option is ignored:

  $ mount -o mode=0666 -t debugfs debugfs /tmp/debugfs_test
  $ mount | grep debugfs_test
  debugfs on /tmp/debugfs_test type debugfs (rw,relatime)
  $ ls -ld /tmp/debugfs_test
  drwx------ 25 root root 0 Aug  4 14:16 /tmp/debugfs_test

With the fix applied, it works as expected:

  $ mount -o mode=0666 -t debugfs debugfs /tmp/debugfs_test
  $ mount | grep debugfs_test
  debugfs on /tmp/debugfs_test type debugfs (rw,relatime,mode=666)
  $ ls -ld /tmp/debugfs_test
  drw-rw-rw- 37 root root 0 Aug  2 17:28 /tmp/debugfs_test

Fix this by restoring the missing sb->s_fs_info assignment in
debugfs_fill_super() and by calling debugfs_reconfigure() in
debugfs_get_tree() to apply options when reusing an existing
superblock.

Fixes: a20971c18752 ("vfs: Convert debugfs to use the new mount API")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220406
Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
---
 fs/debugfs/inode.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index a0357b0cf362d8ac47ff810e162402d6a8ae2cb9..ffe6402c77126b2a23beaa85160dfe578f59599c 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -275,6 +275,7 @@ static int debugfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	set_default_d_op(sb, &debugfs_dops);
 	sb->s_d_flags |= DCACHE_DONTCACHE;
 
+	sb->s_fs_info = fc->s_fs_info;
 	debugfs_apply_options(sb);
 
 	return 0;
@@ -282,10 +283,15 @@ static int debugfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 static int debugfs_get_tree(struct fs_context *fc)
 {
+	int err;
+
 	if (!(debugfs_allow & DEBUGFS_ALLOW_API))
 		return -EPERM;
 
-	return get_tree_single(fc, debugfs_fill_super);
+	err = get_tree_single(fc, debugfs_fill_super);
+	if (!err)
+		err = debugfs_reconfigure(fc);
+	return err;
 }
 
 static void debugfs_free_fc(struct fs_context *fc)

---
base-commit: 3c4a063b1f8ab71352df1421d9668521acb63cd9
change-id: 20250804-debugfs-mount-opts-2a68d7741f05

Best regards,
-- 
Charalampos Mitrodimas <charmitro@posteo.net>



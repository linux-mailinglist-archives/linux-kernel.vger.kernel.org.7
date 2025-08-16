Return-Path: <linux-kernel+bounces-772066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0CDB28E68
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 16:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9AD561482
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 14:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD7F2EAB9C;
	Sat, 16 Aug 2025 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="eYzHQyb+"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2CA2116E0
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755353687; cv=none; b=E3RG7LtpdtPGJkdF32nX6TNCY10i3j/PIEFtK5BPztojBcbeBJznUyJ1zDcOqGZrjMG28vk6mH3WEMj0dKUb3VjHcwtLx7uZkcfP7JsBUeYeFfV/v9JuYPsllxTmRm5WbgiJ69Le7d9dGuhNT0d/7iT1ETyMe4Tp4seDkFw67Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755353687; c=relaxed/simple;
	bh=NcJ8LwHh3X7ee/tDUAZszrsp3afTB1rWbCZa3b73x+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KUCyDo3PFad63gArBF10brX63Sb2F2dfB/b2RB1u5zcUQzrWfY6vrtDs9zXXgywcw1JqjmDDM5vSp5nkNvnTHDykXUNpHeSqLww3UhUd7e9Y8Clg97WhsKgy8fjuMk30o9dij+ctfRvR3KaH+yt++YwdDnWaCp+G5UYjs2pDh1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=eYzHQyb+; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id F0E88240101
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 16:14:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1755353677; bh=Mpo2T6N9jQpcLimTJ5GBjW8DKYRI/lr1kRh0Hkt1PyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:From;
	b=eYzHQyb+38nn1wg10un15QUgjEpREWCKnRbKqkonMDmFjfO7yO9oYVq7L9LQgrPU8
	 evVuiH+S6c9ODW8aPsekEwEMud8leBFrYzjQVcm8/zEMsPhIZI6B2P5vRLjPr/RZPm
	 SExrWACGw+h3hYt8ANH5O6Z7GwmHKxkq/4SFzb2w0EoqrUjuaA9RXW/Nb/jHIge4aI
	 fAR1urfjFNSZ20hhe5zhjY7c7qxGzA3uPATSZaz8LCGIpqNCsrr3qml6Hx8qnGuMMd
	 l12goOJXrCmGA8cW2p3dI7o14Fv4Py6hAGBvKPFq2XxlguLLApkOo/TS9cnSgzHjuq
	 c7+95UEf/XnOg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4c41FT0YDnz9rxf;
	Sat, 16 Aug 2025 16:14:37 +0200 (CEST)
From: Charalampos Mitrodimas <charmitro@posteo.net>
Date: Sat, 16 Aug 2025 14:14:37 +0000
Subject: [PATCH v3] debugfs: fix mount options not being applied
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250816-debugfs-mount-opts-v3-1-d271dad57b5b@posteo.net>
X-B4-Tracking: v=1; b=H4sIAEeSoGgC/33NQQ6DIBCF4asY1qUZUES76j2aLhBGZVExgKSN8
 e5FV23SdPm/ZL5ZSUBvMZBLsRKPyQbrphzlqSB6VNOA1JrchAMX0EBFDXbL0Af6cMsUqZtjoFz
 VjZGyYj0Ikg9nj719Hujtnnu0ITr/On4ktq9/ucQoo50G0VZSNdCJ6+xCRHeeMJLdS/zDYOVPg
 2cDtJKt5IBG11/Gtm1vsJhQp/kAAAA=
X-Change-ID: 20250804-debugfs-mount-opts-2a68d7741f05
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
 Eric Sandeen <sandeen@redhat.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Charalampos Mitrodimas <charmitro@posteo.net>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755353677; l=3131;
 i=charmitro@posteo.net; s=20250727; h=from:subject:message-id;
 bh=NcJ8LwHh3X7ee/tDUAZszrsp3afTB1rWbCZa3b73x+Y=;
 b=Np9txrvzbD3/1Z6vvurRIstaz2gF3yJO/cd78K8BssuwehJUiB6EhVduCZFRyGT8tfxCBJEoC
 srOeCfwcvvjBoISeZaznN4mzqlogCzXUwS8G+bZ6PokXr83mmkZ6wmW
X-Developer-Key: i=charmitro@posteo.net; a=ed25519;
 pk=/tpM70o3uGkbo2oePEdVimUYLyVTgpnPq4nwoG0pFsM=

Mount options (uid, gid, mode) are silently ignored when debugfs is
mounted. This is a regression introduced during the conversion to the
new mount API.

When the mount API conversion was done, the parsed options were never
applied to the superblock when it was reused. As a result, the mount
options were ignored when debugfs was mounted.

Fix this by following the same pattern as the tracefs fix in commit
e4d32142d1de ("tracing: Fix tracefs mount options"). Call
debugfs_reconfigure() in debugfs_get_tree() to apply the mount options
to the superblock after it has been created or reused.

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

Fixes: a20971c18752 ("vfs: Convert debugfs to use the new mount API")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220406
Cc: stable@vger.kernel.org
Reviewed-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
---
Changes in v3:
- Reworded patch description to avoid confusion about OOPs
- Link to v2: https://lore.kernel.org/r/20250813-debugfs-mount-opts-v2-1-0ca79720edc6@posteo.net

Changes in v2:
- Follow the same pattern as e4d32142d1de ("tracing: Fix tracefs mount options")
- Add Cc: stable tag
- Link to v1: https://lore.kernel.org/r/20250804-debugfs-mount-opts-v1-1-bc05947a80b5@posteo.net
---
 fs/debugfs/inode.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index a0357b0cf362d8ac47ff810e162402d6a8ae2cb9..c12d649df6a5435050f606c2828a9a7cc61922e4 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -183,6 +183,9 @@ static int debugfs_reconfigure(struct fs_context *fc)
 	struct debugfs_fs_info *sb_opts = sb->s_fs_info;
 	struct debugfs_fs_info *new_opts = fc->s_fs_info;
 
+	if (!new_opts)
+		return 0;
+
 	sync_filesystem(sb);
 
 	/* structure copy of new mount options to sb */
@@ -282,10 +285,16 @@ static int debugfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 static int debugfs_get_tree(struct fs_context *fc)
 {
+	int err;
+
 	if (!(debugfs_allow & DEBUGFS_ALLOW_API))
 		return -EPERM;
 
-	return get_tree_single(fc, debugfs_fill_super);
+	err = get_tree_single(fc, debugfs_fill_super);
+	if (err)
+		return err;
+
+	return debugfs_reconfigure(fc);
 }
 
 static void debugfs_free_fc(struct fs_context *fc)

---
base-commit: 3c4a063b1f8ab71352df1421d9668521acb63cd9
change-id: 20250804-debugfs-mount-opts-2a68d7741f05

Best regards,
-- 
Charalampos Mitrodimas <charmitro@posteo.net>



Return-Path: <linux-kernel+bounces-885875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B02C34190
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 07:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B1D421C22
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 06:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9843F2D47E2;
	Wed,  5 Nov 2025 06:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+1oKU3d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F335C2D3EDD
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 06:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762325434; cv=none; b=ME+AkDDZCT1fpSlHF56IFeH/g1rS8EpLMZkUQOh9OcP/V7NzgqgcZmUymZKGZaJa+eW9L5IdVdUJpFxJQTXUk+9fAFaOQOGOXgZBTV3cQ528d/EJ4HkhRQEeRvAc4DyG+QffVShvhpp5yZ1z9iqJXkL+WEXzvLSd6cgxCPIOe7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762325434; c=relaxed/simple;
	bh=NaK4PXfltxCANI2HClt3ILDvtjo1EaevjW47jUDeLsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HILdSrN/K3b4Uwb/AxpiPhTBy0PdpX8/R8YGojsxHtWGlWpn1++jKuA6WfI1LmqHa/lInt7qE1SBdTll4RyxZSqaFegrKd2Ih5soM1pLvOWeCJ4r+yVmQF60Kcr9Ttd4hUnNhoPhTzDb+kTNmZPBMI+bNPvlQz3v+hbco9nppog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+1oKU3d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8E9C116B1;
	Wed,  5 Nov 2025 06:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762325432;
	bh=NaK4PXfltxCANI2HClt3ILDvtjo1EaevjW47jUDeLsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b+1oKU3d+/yxXpoB9UvL9E3obpa54VqjQF72OvWc00+js1KygAmCU1Q+EF6GnIJk7
	 j5d9OB9wGryaoPybwEm4hS00hi5s3aKBIbWipAJq24NlvKguiyALHniNyDhlnaPZfA
	 yfCuw6TkX85c5iBE9QwnBRP6foRlhqL56j6avr1XtiVZfGfCJ9uzNeVHXb9HzmtJ5P
	 I1+8UGSWK2uSCZYMSNimHrYOlG5+JVfsbONu6GcyMu/r6c9Eu9eVtoMtGSwsvE0GNu
	 k2+Ggx43GhnDtQjXDCtq5bINL7VVFE+z11Ac0GXJdF0CWEeFZ/cRHunUqfKBPjC1XA
	 Crdmu5qeg7rdQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	stable@kernel.org
Subject: [PATCH 2/2] f2fs: fix to detect recoverable inode during dryrun of find_fsync_dnodes()
Date: Wed,  5 Nov 2025 14:50:23 +0800
Message-ID: <20251105065023.3656975-2-chao@kernel.org>
X-Mailer: git-send-email 2.51.2.1006.ga50a493c49-goog
In-Reply-To: <20251105065023.3656975-1-chao@kernel.org>
References: <20251105065023.3656975-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mkfs.f2fs -f /dev/vdd
mount /dev/vdd /mnt/f2fs
touch /mnt/f2fs/foo
sync		# avoid CP_UMOUNT_FLAG in last f2fs_checkpoint.ckpt_flags
touch /mnt/f2fs/bar
f2fs_io fsync /mnt/f2fs/bar
f2fs_io shutdown 2 /mnt/f2fs
umount /mnt/f2fs
blockdev --setro /dev/vdd
mount /dev/vdd /mnt/f2fs
mount: /mnt/f2fs: WARNING: source write-protected, mounted read-only.

For the case if we create and fsync a new inode before sudden power-cut,
without norecovery or disable_roll_forward mount option, the following
mount will succeed w/o recovering last fsynced inode.

The problem here is that we only check inode_list list after
find_fsync_dnodes() in f2fs_recover_fsync_data() to find out whether
there is recoverable data in the iamge, but there is a missed case, if
last fsynced inode is not existing in last checkpoint, then, we will
fail to get its inode due to nat of inode node is not existing in last
checkpoint, so the inode won't be linked in inode_list.

Let's detect such case in dyrun mode to fix this issue.

After this change, mount will fail as expected below:
mount: /mnt/f2fs: cannot mount /dev/vdd read-only.
       dmesg(1) may have more information after failed mount system call.
demsg:
F2FS-fs (vdd): Need to recover fsync data, but write access unavailable, please try mount w/ disable_roll_forward or norecovery

Cc: stable@kernel.org
Fixes: 6781eabba1bd ("f2fs: give -EINVAL for norecovery and rw mount")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/recovery.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 215e442db72c..d7faebaa3c6b 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -399,7 +399,7 @@ static int sanity_check_node_chain(struct f2fs_sb_info *sbi, block_t blkaddr,
 }
 
 static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
-				bool check_only)
+				bool check_only, bool *new_inode)
 {
 	struct curseg_info *curseg;
 	block_t blkaddr, blkaddr_fast;
@@ -447,16 +447,19 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 				quota_inode = true;
 			}
 
-			/*
-			 * CP | dnode(F) | inode(DF)
-			 * For this case, we should not give up now.
-			 */
 			entry = add_fsync_inode(sbi, head, ino_of_node(folio),
 								quota_inode);
 			if (IS_ERR(entry)) {
 				err = PTR_ERR(entry);
-				if (err == -ENOENT)
+				/*
+				 * CP | dnode(F) | inode(DF)
+				 * For this case, we should not give up now.
+				 */
+				if (err == -ENOENT) {
+					if (check_only)
+						*new_inode = true;
 					goto next;
+				}
 				f2fs_folio_put(folio, true);
 				break;
 			}
@@ -875,6 +878,7 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	int ret = 0;
 	unsigned long s_flags = sbi->sb->s_flags;
 	bool need_writecp = false;
+	bool new_inode = false;
 
 	f2fs_notice(sbi, "f2fs_recover_fsync_data: recovery fsync data, "
 					"check_only: %d", check_only);
@@ -890,8 +894,8 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	f2fs_down_write(&sbi->cp_global_sem);
 
 	/* step #1: find fsynced inode numbers */
-	err = find_fsync_dnodes(sbi, &inode_list, check_only);
-	if (err || list_empty(&inode_list))
+	err = find_fsync_dnodes(sbi, &inode_list, check_only, &new_inode);
+	if (err < 0 || (list_empty(&inode_list) && (!check_only || !new_inode)))
 		goto skip;
 
 	if (check_only) {
-- 
2.49.0



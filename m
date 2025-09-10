Return-Path: <linux-kernel+bounces-809756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4E1B511A2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 313B73B18D5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB6E310624;
	Wed, 10 Sep 2025 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQdZ+NyV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6873081C6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493632; cv=none; b=q20xDRnsgmWy6Y9Lt765xO0+qJi970/1IzDxyhYNiYMeQHwTZLFXcJqm+VH3FtLK4JXpxCAULE2VBMY2m3biJt5j/yeyFWreO766YruQ6/NNY+dRBpQ64TK27/AJ8hmI3mOZAZtx8w5m2azNuzQvakKYBbmyw5LMKj0kKpd5QEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493632; c=relaxed/simple;
	bh=GPDaP11QrembyBGG0diAjU9KLEUd1GQl7AIT0DvpbQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t/E09yKP1fkon03aI2mL483ZytEcQwRoWGKuoBf2XmPBz3AYeclmmiq8nwzowgusKZuRTJGfQ42tDS0lDVAf+kB1MSKehYxbL3rplC8lPaHWXW9sGMBdHnremCZFG8FDYYdZl6NpsH4BvYXJmnuQ7a0YXD5ZBtzszRd820Xc8ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQdZ+NyV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592A3C4CEFA;
	Wed, 10 Sep 2025 08:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757493632;
	bh=GPDaP11QrembyBGG0diAjU9KLEUd1GQl7AIT0DvpbQE=;
	h=From:To:Cc:Subject:Date:From;
	b=kQdZ+NyVUhBogJAYXdPGo+VWUjQne8Ir5gG8JfDRnff6xNlkjbxgoKDIEDVa8WAI4
	 e//oUTN/W437niexorIoyMa2Ykp/WY8GLo/+EIxCSKiEGzOXCdb8GgCtOMVt+YnD+5
	 UCHzHpohkAmRh4WlYJi79lcWRTNaJa5lTgx2YCwJwKWm6tNfIfIU1JaVSoT8QnQWYl
	 ADgPo1jlMPV5cVN0QWJ4netH4SCigWg9JyCUzPifTGgqwvg7s32WuAFo9DezFPuZKb
	 2KJS77qTxECcsvF/QASe0E7/ddNgx4/i25TvKnqS6mYa1L6YNs3NhHvlBSGEvWeOBI
	 i2jJKax5CjDGQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	syzbot+90266696fe5daacebd35@syzkaller.appspotmail.com
Subject: [PATCH] f2fs: fix to truncate first page in error path of f2fs_truncate()
Date: Wed, 10 Sep 2025 16:40:24 +0800
Message-ID: <20250910084024.1722790-1-chao@kernel.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reports a bug as below:

loop0: detected capacity change from 0 to 40427
F2FS-fs (loop0): Wrong SSA boundary, start(3584) end(4096) blocks(3072)
F2FS-fs (loop0): Can't find valid F2FS filesystem in 1th superblock
F2FS-fs (loop0): invalid crc value
F2FS-fs (loop0): f2fs_convert_inline_folio: corrupted inline inode ino=3, i_addr[0]:0x1601, run fsck to fix.
------------[ cut here ]------------
kernel BUG at fs/inode.c:753!
RIP: 0010:clear_inode+0x169/0x190 fs/inode.c:753
Call Trace:
 <TASK>
 evict+0x504/0x9c0 fs/inode.c:810
 f2fs_fill_super+0x5612/0x6fa0 fs/f2fs/super.c:5047
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1692
 vfs_get_tree+0x8f/0x2b0 fs/super.c:1815
 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3808
 do_mount fs/namespace.c:4136 [inline]
 __do_sys_mount fs/namespace.c:4347 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4324
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

During f2fs_evict_inode(), clear_inode() detects that we missed to truncate
all page cache before destorying inode, that is because in below path, we
will create page #0 in cache, but missed to drop it in error path, let's fix
it.

- evict
 - f2fs_evict_inode
  - f2fs_truncate
   - f2fs_convert_inline_inode
    - f2fs_grab_cache_folio
    : create page #0 in cache
    - f2fs_convert_inline_folio
    : sanity check failed, return -EFSCORRUPTED
  - clear_inode detects that inode->i_data.nrpages is not zero

Fixes: 92dffd01790a ("f2fs: convert inline_data when i_size becomes large")
Reported-by: syzbot+90266696fe5daacebd35@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-f2fs-devel/68c09802.050a0220.3c6139.000e.GAE@google.com
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 42faaed6a02d..1aae4361d0a8 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -904,8 +904,16 @@ int f2fs_truncate(struct inode *inode)
 	/* we should check inline_data size */
 	if (!f2fs_may_inline_data(inode)) {
 		err = f2fs_convert_inline_inode(inode);
-		if (err)
+		if (err) {
+			/*
+			 * Always truncate page #0 to avoid page cache
+			 * leak in evict() path.
+			 */
+			truncate_inode_pages_range(inode->i_mapping,
+					F2FS_BLK_TO_BYTES(0),
+					F2FS_BLK_END_BYTES(0));
 			return err;
+		}
 	}
 
 	err = f2fs_truncate_blocks(inode, i_size_read(inode), true);
-- 
2.49.0



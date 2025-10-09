Return-Path: <linux-kernel+bounces-846514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B622BC8373
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 11:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454A93BD2EC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 09:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248272D6E7F;
	Thu,  9 Oct 2025 09:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/JRXv8I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806F82D47F4
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760001018; cv=none; b=TilUZ0FMn+BnaqUhicq59vNFmx5yw22eMC4w4u6LPGMXOLiTaczy6Hp2LjA/BvHIOqKuOlipS9nBONfoAwhfGc9jzJHTN75Twh1chtNVbyDK0RktXEv6dNVNMFGngsJ7TcdlQs1cGPHSgl8FD6F7p3j6kIMBz9BTHBpBpnoOxUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760001018; c=relaxed/simple;
	bh=cQmyOA1kdsDXT6q0amBPUls1NNiXk6QdOgjeKYuRvB0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ptFUzDPnNGi9axs1vqfyFJrS4KW5FoUZag5lGI+ftkkq+R7OG44SNhPUbnzuwwbvnbjf6XiZ7gCTd81Q6TTJre0YzmNeRTqzvy8x/6qaMRMWGQ3iO1YCUSBoMzdDmQ+loSoG/FyCZ8o0rKMQUx0RlGkP4jYQX6HCQksd39SQYfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/JRXv8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A42C4CEF9;
	Thu,  9 Oct 2025 09:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760001018;
	bh=cQmyOA1kdsDXT6q0amBPUls1NNiXk6QdOgjeKYuRvB0=;
	h=From:To:Cc:Subject:Date:From;
	b=D/JRXv8I6v9O04pRy64kW+PaTp1lVj8R3x4mwsrA7lzrzjEDHfjUjhwSuSoUBMKiM
	 z9KgsCvzwbJ/CoWpN6fDcrF0DaUPwwdO2+F9v+NTolaj6t5mNuL4v2l6gv94w8rFuc
	 cefaoPU4J16ywJ3VWWoN29V9awNcsoB8GudrUKemKbNjCBg1zqjZj7IISbEes85hiI
	 B3hhOBeshcMMaV87IjAsy0Hx3KTq8XJdm/+Y0KnREFgmMrIrRCDPrfxJiZTNozeM45
	 nWjXQnECJ0xk8EAS/LYT8ZZow6M/Lul5fXD9gv634wI9lX4NxywfqCxtEv/I6C6sIE
	 Ov9Ipq7CH9q0w==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	syzbot+24124df3170c3638b35f@syzkaller.appspotmail.com
Subject: [PATCH] f2fs: fix to avoid updating zero-sized extent in extent cache
Date: Thu,  9 Oct 2025 16:52:30 +0800
Message-Id: <20251009085230.17146-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As syzbot reported:

F2FS-fs (loop0): __update_extent_tree_range: extent len is zero, type: 0, extent [0, 0, 0], age [0, 0]
------------[ cut here ]------------
kernel BUG at fs/f2fs/extent_cache.c:678!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5336 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__update_extent_tree_range+0x13bc/0x1500 fs/f2fs/extent_cache.c:678
Call Trace:
 <TASK>
 f2fs_update_read_extent_cache_range+0x192/0x3e0 fs/f2fs/extent_cache.c:1085
 f2fs_do_zero_range fs/f2fs/file.c:1657 [inline]
 f2fs_zero_range+0x10c1/0x1580 fs/f2fs/file.c:1737
 f2fs_fallocate+0x583/0x990 fs/f2fs/file.c:2030
 vfs_fallocate+0x669/0x7e0 fs/open.c:342
 ioctl_preallocate fs/ioctl.c:289 [inline]
 file_ioctl+0x611/0x780 fs/ioctl.c:-1
 do_vfs_ioctl+0xb33/0x1430 fs/ioctl.c:576
 __do_sys_ioctl fs/ioctl.c:595 [inline]
 __se_sys_ioctl+0x82/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f07bc58eec9

In error path of f2fs_zero_range(), it may add a zero-sized extent
into extent cache, it should be avoided.

Fixes: 6e9619499f53 ("f2fs: support in batch fzero in dnode page")
Reported-by: syzbot+24124df3170c3638b35f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-f2fs-devel/68e5d698.050a0220.256323.0032.GAE@google.com
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ffa045b39c01..c045e38e60ee 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1654,8 +1654,11 @@ static int f2fs_do_zero_range(struct dnode_of_data *dn, pgoff_t start,
 		f2fs_set_data_blkaddr(dn, NEW_ADDR);
 	}
 
-	f2fs_update_read_extent_cache_range(dn, start, 0, index - start);
-	f2fs_update_age_extent_cache_range(dn, start, index - start);
+	if (index > start) {
+		f2fs_update_read_extent_cache_range(dn, start, 0,
+							index - start);
+		f2fs_update_age_extent_cache_range(dn, start, index - start);
+	}
 
 	return ret;
 }
-- 
2.40.1



Return-Path: <linux-kernel+bounces-859997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEDABEF1D0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE68C3B03EE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 02:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33BF29B228;
	Mon, 20 Oct 2025 02:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMBKhNlV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0524A946A
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760928140; cv=none; b=jSefiETcCAlrGE1uj7xnQ7OfIRfwRDgPPs3rSL1v3iPM+I79ggON1P2s1iCVUXZDUfQhR2TMsn9AhBzk0C3qFl7pJtEUiCp4tqkJvwagOwEJXD0GfHrwl3yhtCHLX1DYQdTywfB9jfbN1GAK2CodcHr4NsnqEZw9PH8Wbcf3ZVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760928140; c=relaxed/simple;
	bh=2Dvy7Pqb4UHZzIXbGPiDVAGI8fjvHm+1MTOwiicyTL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l0Z0A95GhSfC5Dz10P2yF4ks8Us6iKF5LAmmKIpaM1SvbDPc82YULxJNMsWosy+vl7bHYRTF0ZWfyMFkSB1fb9nBa+9U1IC/Y91VJbYVnZPkN4SO19XcDMZuhx9yTeAdySWbix6JnR21QcRpjx+fTMDWBXSuBcieeuTj1RR+PSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMBKhNlV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1BEC4CEE7;
	Mon, 20 Oct 2025 02:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760928139;
	bh=2Dvy7Pqb4UHZzIXbGPiDVAGI8fjvHm+1MTOwiicyTL8=;
	h=From:To:Cc:Subject:Date:From;
	b=NMBKhNlVk5Zim2UFv+s4FQaBUw5GVafaNWWvsZUl2hbu2zZjlEbVCsKTJ/Y62QhZN
	 9wGTtyidFB2iX4Ehk72ZKM1OfvR9rLkSkoW3x6l/5igElJoZYl32t7oKoVNb45EVJN
	 8JKQXtwerxyYUEPKNm1kVC8/X1qtHADR87YLoZjn9LXwKrrP2rnmxxqecHXWn+88og
	 BYYXpGOnyyV/Lnr7hG1B2vKSZ4amqkBpQxNbd58bnBDjz+GRJMkJyhGmj13Je9DUdP
	 jtgQ30X9qPi1WovnQSWDZRHi/g8+tINvKFnO6ilk3Qd7gJRq6Dwu7k0RMyEJPKWyEf
	 0OzG53iSSKErg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	syzbot+24124df3170c3638b35f@syzkaller.appspotmail.com
Subject: [PATCH v2] f2fs: fix to avoid updating zero-sized extent in extent cache
Date: Mon, 20 Oct 2025 10:42:12 +0800
Message-ID: <20251020024213.332873-1-chao@kernel.org>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
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
Cc: stable@kernel.org
Reported-by: syzbot+24124df3170c3638b35f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-f2fs-devel/68e5d698.050a0220.256323.0032.GAE@google.com
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- add missing "Cc: stable" flag
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
2.49.0



Return-Path: <linux-kernel+bounces-885874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8201BC3418D
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 07:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E761046663D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 06:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31852C21CC;
	Wed,  5 Nov 2025 06:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3pq6pt0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAC32C027A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 06:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762325431; cv=none; b=sKrdetf//rsbg9El2z1Kvk8nWpnyj/54UwCNx1k0uQudgCum3e/fP7Ymehq2Xrd9jaawyIYNccBu6v4YvTSFkR3WaJQKkX2D2e+mdv2vdqo0YLOCHQftLkRnb2iOskd/T6mdaIv71EDG7EjlxC8UERe5NKDMxLIcf1AnDliPE2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762325431; c=relaxed/simple;
	bh=zOjevuavXoiG4HR4C5SvsaUWivLa1l0J3fg1J1tkK/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GGGlEx3F7qMulmFa4seWYRQ90QHWOscgsSZNCpu+ePOr+sc0tPkxLQ/VrArQhh4bK5A423U2HYRZlCmjqaGd/AOiX8C7wbkdQgTj4k28eGUD/O1u+zRVRFeuB8Fy6E0aucT+X3QCSVxN5rSLQO0sfYUp59EQDdAU9TwadTLUCFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3pq6pt0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE19AC4CEF8;
	Wed,  5 Nov 2025 06:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762325431;
	bh=zOjevuavXoiG4HR4C5SvsaUWivLa1l0J3fg1J1tkK/4=;
	h=From:To:Cc:Subject:Date:From;
	b=l3pq6pt0PJQKQ1XCwIuT/KM+fNfSLMffuloGLCeMGfuv6EVrvi5N1USxKtD9lFygt
	 vAkcst1waQteooWo1/S4N+zLwLwOMHDvo1bvo0AGWLNpQkxHNE2BXELZpQv0FL+sHz
	 0ZEYTBV7WZHSLCn5xRywb2I30VRtIUexNxNP0kOkeyBXz627SregOCwhIZ89HylHYx
	 y6cYn1kvA09Ey0/3vaXIIPhlrZZITtsjv8azvO8Fd5wEaQygRne27Mb00GXCIR+S6G
	 oLLYo8tU7KlPPsj1uSz8OGI1g0ox7M5jTTrZ7VFoyGz0sG0unnHQY6zjS2aLx8YRqt
	 w785PaPYIQeBw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	stable@kernel.org
Subject: [PATCH 1/2] f2fs: fix return value of f2fs_recover_fsync_data()
Date: Wed,  5 Nov 2025 14:50:22 +0800
Message-ID: <20251105065023.3656975-1-chao@kernel.org>
X-Mailer: git-send-email 2.51.2.1006.ga50a493c49-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With below scripts, it will trigger panic in f2fs:

mkfs.f2fs -f /dev/vdd
mount /dev/vdd /mnt/f2fs
touch /mnt/f2fs/foo
sync
echo 111 >> /mnt/f2fs/foo
f2fs_io fsync /mnt/f2fs/foo
f2fs_io shutdown 2 /mnt/f2fs
umount /mnt/f2fs
mount -o ro,norecovery /dev/vdd /mnt/f2fs
or
mount -o ro,disable_roll_forward /dev/vdd /mnt/f2fs

F2FS-fs (vdd): f2fs_recover_fsync_data: recovery fsync data, check_only: 0
F2FS-fs (vdd): Mounted with checkpoint version = 7f5c361f
F2FS-fs (vdd): Stopped filesystem due to reason: 0
F2FS-fs (vdd): f2fs_recover_fsync_data: recovery fsync data, check_only: 1
Filesystem f2fs get_tree() didn't set fc->root, returned 1
------------[ cut here ]------------
kernel BUG at fs/super.c:1761!
Oops: invalid opcode: 0000 [#1] SMP PTI
CPU: 3 UID: 0 PID: 722 Comm: mount Not tainted 6.18.0-rc2+ #721 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:vfs_get_tree.cold+0x18/0x1a
Call Trace:
 <TASK>
 fc_mount+0x13/0xa0
 path_mount+0x34e/0xc50
 __x64_sys_mount+0x121/0x150
 do_syscall_64+0x84/0x800
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7fa6cc126cfe

The root cause is we missed to handle error number returned from
f2fs_recover_fsync_data() when mounting image w/ ro,norecovery or
ro,disable_roll_forward mount option, result in returning a positive
error number to vfs_get_tree(), fix it.

Cc: stable@kernel.org
Fixes: 6781eabba1bd ("f2fs: give -EINVAL for norecovery and rw mount")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0b0ef8ba243b..8cf98c40b160 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -5211,11 +5211,15 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 		}
 	} else {
 		err = f2fs_recover_fsync_data(sbi, true);
-
-		if (!f2fs_readonly(sb) && err > 0) {
-			err = -EINVAL;
-			f2fs_err(sbi, "Need to recover fsync data");
-			goto free_meta;
+		if (err > 0) {
+			if (!f2fs_readonly(sb)) {
+				f2fs_err(sbi, "Need to recover fsync data");
+				err = -EINVAL;
+				goto free_meta;
+			} else {
+				f2fs_info(sbi, "drop all fsynced data");
+				err = 0;
+			}
 		}
 	}
 
-- 
2.49.0



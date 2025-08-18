Return-Path: <linux-kernel+bounces-772716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D96B296BE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CF864E685B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 02:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F9C244675;
	Mon, 18 Aug 2025 02:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6Elxozu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3901A4F12
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755482985; cv=none; b=sxEpWpavA2h/PM0siB6rOLZzGnoSKjjJ01u/ITZa+7hFWSDVJnddkyckG7uru7mEgNHu/28kjFm/cxkJSG7QiTdt7w4CFYfXi/KvCQXp9q1wTK51z5pCiIoSqEibopiXUMMZNyDmtXMgzvbVQHBL1jZbUe4Dub7hBr23bejIrVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755482985; c=relaxed/simple;
	bh=RZoPX6qoxbaE7E4S76HF9R2kVzcEwoopEK600mDDAeo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tv44e2wfgLVWqMimQFnXs+/1OeYnO4Nx0pbKpgSErj0q+xzA615gT4um0DLOJoN35ZGpwibABo40Ll55c2oo+YLB6s6RTZruudCa8vdXkn8slHjMQwD1AtucXF9S9yndGNNHEwIOeA1PVXEowXt7feJ2Zp2h9gzGLOpccxxzl64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6Elxozu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243E8C4CEEB;
	Mon, 18 Aug 2025 02:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755482984;
	bh=RZoPX6qoxbaE7E4S76HF9R2kVzcEwoopEK600mDDAeo=;
	h=From:To:Cc:Subject:Date:From;
	b=a6ElxozupGkH49ZesF/SDDHgg+UdIkv4eZSoMFFBVwogpBXnbu9NOM37hYrrEKIFt
	 7njlMU/k4ITbOKzlMgguRKo73PFXmVdjH+SC5t22mGZgVx2Bv6riQh9gIKQ0nobJWT
	 h5jrrn0yRDtA28tPeHQpHA6eBSIWu+btQlnnmQijzq2vASBTCpdVNHIB/wjPCYAH/W
	 1l2WmMp81rFRp5W06BWpQz4Q5UwSmA739DgXBs3oJBNEEcPYjTsPsKsOCuldbI4axk
	 WBFseR1RhSEN4aBUu4EvaXCElq5QK1npNo1GFXhr3LYBDtX3Z/7irgjPb1ycPBvySO
	 Pwo+vbZ+P9wYg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	syzbot+d371efea57d5aeab877b@syzkaller.appspotmail.com,
	Hongbo Li <lihongbo22@huawei.com>
Subject: [PATCH 1/2] f2fs: fix to avoid NULL pointer dereference in f2fs_check_quota_consistency()
Date: Mon, 18 Aug 2025 10:09:38 +0800
Message-ID: <20250818020939.3529802-1-chao@kernel.org>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a f2fs bug as below:

Oops: gen[  107.736417][ T5848] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 UID: 0 PID: 5848 Comm: syz-executor263 Tainted: G        W           6.17.0-rc1-syzkaller-00014-g0e39a731820a #0 PREEMPT_{RT,(full)}
RIP: 0010:strcmp+0x3c/0xc0 lib/string.c:284
Call Trace:
 <TASK>
 f2fs_check_quota_consistency fs/f2fs/super.c:1188 [inline]
 f2fs_check_opt_consistency+0x1378/0x2c10 fs/f2fs/super.c:1436
 __f2fs_remount fs/f2fs/super.c:2653 [inline]
 f2fs_reconfigure+0x482/0x1770 fs/f2fs/super.c:5297
 reconfigure_super+0x224/0x890 fs/super.c:1077
 do_remount fs/namespace.c:3314 [inline]
 path_mount+0xd18/0xfe0 fs/namespace.c:4112
 do_mount fs/namespace.c:4133 [inline]
 __do_sys_mount fs/namespace.c:4344 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4321
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The direct reason is f2fs_check_quota_consistency() may suffer null-ptr-deref
issue in strcmp().

The bug can be reproduced w/ below scripts:
mkfs.f2fs -f /dev/vdb
mount -t f2fs -o usrquota /dev/vdb /mnt/f2fs
quotacheck -uc /mnt/f2fs/
umount /mnt/f2fs
mount -t f2fs -o usrjquota=aquota.user,jqfmt=vfsold /dev/vdb /mnt/f2fs
mount -t f2fs -o remount,usrjquota=,jqfmt=vfsold /dev/vdb /mnt/f2fs
umount /mnt/f2fs

So, before old_qname and new_qname comparison, we need to check whether
they are all valid pointers, fix it.

Reported-by: syzbot+d371efea57d5aeab877b@syzkaller.appspotmail.com
Fixes: d18535132523 ("f2fs: separate the options parsing and options checking")
Closes: https://lore.kernel.org/linux-f2fs-devel/689ff889.050a0220.e29e5.0037.GAE@google.com
Cc: Hongbo Li <lihongbo22@huawei.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 5aa9d650512d..465604fdc5dd 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1219,7 +1219,8 @@ static int f2fs_check_quota_consistency(struct fs_context *fc,
 				goto err_jquota_change;
 
 			if (old_qname) {
-				if (strcmp(old_qname, new_qname) == 0) {
+				if (new_qname &&
+					strcmp(old_qname, new_qname) == 0) {
 					ctx->qname_mask &= ~(1 << i);
 					continue;
 				}
-- 
2.49.0



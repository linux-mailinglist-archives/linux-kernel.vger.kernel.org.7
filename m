Return-Path: <linux-kernel+bounces-861785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA1DBF3A7B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFD054EE1F0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021B6333756;
	Mon, 20 Oct 2025 21:07:31 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2BF333731
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 21:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760994450; cv=none; b=IxYz4vd0bE1simrp5zq+EfEtsuTGfBay0x/T9qZ7R5NoYQWtCmuVQ4GTzLOXVSbwh229y8Q4uZy2wZ47hhBCspAEJEyG9P356gb8hJcwD75M8OGSyxjf7qE1eaITFjjRKHFft9zDREmJdGlNZj5D/4QJD//wVPn2D0v7Ods/z98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760994450; c=relaxed/simple;
	bh=2fzI6eQZv69sdwa+zF1ACUy4yB+wx/Nz7T0iwEXG1JA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=M2Gj3HUTqJYBk2aJce470A78Udx1c6e25f0bSE2TgKChZWiEgJeiItznnZ3bzMP+gVJvMEqKmkFk+Q8RkWTOkz9nALVV+KM7lO47qLq6jYjbYJwLGCPXzC6Py41A3q+DziI1MbFH/f6uAIx7gA0wnIA3MSGc/zqe7PAcuOlYrPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-940e4cf730aso187008839f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760994447; x=1761599247;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hGR0ijAPrAH6TWqkzBXespXSeoBVhQeb1XJKmix8FAY=;
        b=TWhg++tzZG4nh6QDJtY1mnx9VPDZDe0wih7ozJvVE5g2GD2QIv19YaHQkw8DkrMt+G
         jbMjhfetbnsT4e/xNOTJV1pTJSJjP0/75hmrsIfhsnmgRGt0kebBKGkKiubMMRR7aiRV
         So2n/qs29WaAmfvSpJpchXO83mWYAM49Qr4vWWp/HVarZ6/P6lKtdUiCoDnKMYEl606p
         Coc29ktbEobJ3Z5ZzMrAPxlH7G9BT2OVJUwSdXvaiuwMGFXFPixM7oWjI/OjVD91ZsJ8
         uT7RoPvzUTDxrAZ/cQBCcLzHuwb7A5B5wrVEN2fCuFLLvv2GSpxaKSMvRQtI1LeO7ZkY
         zTEg==
X-Forwarded-Encrypted: i=1; AJvYcCVsZdaGbkMeXfTmVXWytsXBM5CXAeri+bwPTB4kpOG3MBTKdnau5c2S74gylW+ixONve99VtQ5FpQgZfTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFVfka9Ubxfy/JqM1Av6mCf/LYkCXBsWkXgyRJoS5dpTA1v/CV
	4FP0XeL/bilzhLioUa2uscQ7IrlPeHZUjh9A3cAZmEyQ1+URawkN0P0LW4Je0eVMgiYaUUJT8SO
	iPwL/f0CkAzakMs+pXkFlYXGG88olJIVW1M/ZX699syGas2gImndEUQqdotg=
X-Google-Smtp-Source: AGHT+IFbSHwUur2DVvYQM8+EDbXYVi7Ub9ddES87Glkw5iF9RFWPb9a9xnfwJxW8Rdv8sKAi0wPFfOGxYc2zPqasdpEx1o5AM2Pa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:440a:10b0:430:c90d:10ae with SMTP id
 e9e14a558f8ab-430c90dcb95mr168265295ab.32.1760994447213; Mon, 20 Oct 2025
 14:07:27 -0700 (PDT)
Date: Mon, 20 Oct 2025 14:07:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f6a48f.050a0220.91a22.0451.GAE@google.com>
Subject: [syzbot] [gfs2?] WARNING: ODEBUG bug in gfs2_fill_super
From: syzbot <syzbot+19e0be39cc25dfcb0858@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    93f3bab4310d Add linux-next specific files for 20251017
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=136b6492580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=408308c229eef498
dashboard link: https://syzkaller.appspot.com/bug?extid=19e0be39cc25dfcb0858
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11963de2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1784b52f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c955a9337646/disk-93f3bab4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/843962ea5283/vmlinux-93f3bab4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/42360a7c5734/bzImage-93f3bab4.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/545c6975baec/mount_3.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=1679f5e2580000)

The issue was bisected to:

commit 8fdd8a28fe5cd5045a43ac1093f2d07325fd9fcb
Author: Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue Aug 5 21:12:06 2025 +0000

    gfs2: Asynchronous withdraw

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1752e492580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14d2e492580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10d2e492580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+19e0be39cc25dfcb0858@syzkaller.appspotmail.com
Fixes: 8fdd8a28fe5c ("gfs2: Asynchronous withdraw")

R10: 0000000000200001 R11: 0000000000000246 R12: 0000200000012500
R13: 00007ffe544d9030 R14: 00000000000125bf R15: 0000200000000680
 </TASK>
gfs2: fsid=syz:syz.0: about to withdraw this file system
gfs2: fsid=syz:syz.0: can't lookup journal index: 0
------------[ cut here ]------------
ODEBUG: free active (active state 0) object: ffff888026c285a0 object type: work_struct hint: gfs2_withdraw_func+0x0/0x430 fs/gfs2/util.c:-1
WARNING: lib/debugobjects.c:615 at debug_print_object+0x16b/0x1e0 lib/debugobjects.c:612, CPU#1: syz.0.17/6010
Modules linked in:
CPU: 1 UID: 0 PID: 6010 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:debug_print_object+0x16b/0x1e0 lib/debugobjects.c:612
Code: 4c 89 ff e8 47 99 8a fd 4d 8b 0f 48 c7 c7 80 86 c0 8b 48 8b 34 24 4c 89 ea 89 e9 4d 89 f0 41 54 e8 8a f5 e7 fc 48 83 c4 08 90 <0f> 0b 90 90 ff 05 c7 d0 02 0b 48 83 c4 08 5b 41 5c 41 5d 41 5e 41
RSP: 0018:ffffc90003bdf8a0 EFLAGS: 00010296
RAX: ef320fd336e0b300 RBX: dffffc0000000000 RCX: ffff88807b605ac0
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfa6c0 R12: ffffffff8404d890
R13: ffffffff8bc08800 R14: ffff888026c285a0 R15: ffffffff8b69e000
FS:  000055557497a500(0000) GS:ffff888125dfd000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe544da000 CR3: 000000002e3c8000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __debug_check_no_obj_freed lib/debugobjects.c:1099 [inline]
 debug_check_no_obj_freed+0x3a2/0x470 lib/debugobjects.c:1129
 slab_free_hook mm/slub.c:2461 [inline]
 slab_free mm/slub.c:6619 [inline]
 kfree+0x115/0x6d0 mm/slub.c:6826
 free_sbd fs/gfs2/ops_fstype.c:72 [inline]
 gfs2_fill_super+0x1552/0x2230 fs/gfs2/ops_fstype.c:1317
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1691
 gfs2_get_tree+0x51/0x1e0 fs/gfs2/ops_fstype.c:1333
 vfs_get_tree+0x92/0x2b0 fs/super.c:1751
 fc_mount fs/namespace.c:1208 [inline]
 do_new_mount_fc fs/namespace.c:3651 [inline]
 do_new_mount+0x302/0xa10 fs/namespace.c:3727
 do_mount fs/namespace.c:4050 [inline]
 __do_sys_mount fs/namespace.c:4238 [inline]
 __se_sys_mount+0x313/0x410 fs/namespace.c:4215
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbee1f9076a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe544d8fe8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffe544d9070 RCX: 00007fbee1f9076a
RDX: 0000200000000000 RSI: 0000200000012500 RDI: 00007ffe544d9030
RBP: 0000200000000000 R08: 00007ffe544d9070 R09: 0000000000200001
R10: 0000000000200001 R11: 0000000000000246 R12: 0000200000012500
R13: 00007ffe544d9030 R14: 00000000000125bf R15: 0000200000000680
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup


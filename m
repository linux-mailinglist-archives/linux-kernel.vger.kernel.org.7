Return-Path: <linux-kernel+bounces-751668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5F0B16C1B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 323357B2D40
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 06:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431E9266573;
	Thu, 31 Jul 2025 06:36:42 +0000 (UTC)
Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598E925F986
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 06:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753943801; cv=none; b=E+/yoMGQs/LuG1gZ1piM4HE8nTODEhUJaTwiohkR7Gw1QjaD5q4Fz66PwhZ9yG92NZSZint0h4Ga6irulTxvqCVGALT0YRENcaAP5/0NdZZ88cMzUAtGlbASbivBba2+JO4xjp/QP14hTOr57B+9cA+kfxJRi/oMoier+vewkuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753943801; c=relaxed/simple;
	bh=FMUEz3kyF6fRRppi9amB0j1l46ys6lLiLGlQan8pkMw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=r+ORdWoOS8HFc6aaFqlmlSi/FdChbprfy/K2375ksw/wSovfcMNgD03MEUerxl1v/khhkQsnStiafxyCspbTtgyg3d/xqSNWugVsK/qWmwl+KQDwvIdMVDrGxYbFAGAvNgMiJA8SvXTe0LToBEtvCcPj+ikd/Rg/G7AOrQToeA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-73e8ddac4d2so978688a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 23:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753943795; x=1754548595;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OHacPjXHmhT4gSFFAUsf+PSG0JpJkx0CNYn0jXCCrJk=;
        b=tkisUDs2DSq4rhOsgQdyJtS70hoMVJJyVRu5Q8MjFxgZlwScC7YT+8y1hAm8uydyXt
         SD1dYWm6/yRHVdKLW0m7v9RTWsmO4bBaQfwx3RLxfCke3tjdeFFU+fnMrYKHjxTF4vEc
         iq/5aK9lzGz6bY7/sfJw91Ekz1lDwjMiS1PZDW4ULIOTfLZxJCJMX3/nem8sGlRQDRsg
         v4Su3yiJXwXaSxhA3kqrq/ffN2bfShAo0KUh1CzYijmY2GMS7gbdeFku3NSl/IBpfmq8
         DcqKKV2paU08DO5iYHKV6V82YjpBgUg/WNfSBa4cMfjSLMemaoGpBaZju+x97FjTS1/a
         cxEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoaoFVG3KNNcwSUSxyDv5qhle1djTx/vNAFfdRHPLBo1O54y06AdpwFTdzbJq5332gwOe0SMXvszcBgmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0/OPGpqPUHkIL4ULkvr6tSNpjk0HAfVURVhJJhQTwULRBDLqK
	gXM/Kacxqf6V2dRdl+Pl2es0eUeJq1J6Z0pWcYKlGn7HlCfZgEK1MKnXyB2x9dYbvahZ+HN+B6X
	NTunR5F0UIyvF6gYox7T+VH/G7v4LHmZUcXa09bdP/56JCA8Y+pnuuwbINKE=
X-Google-Smtp-Source: AGHT+IEeVII6Nr0rcVGr0qWvBULevzjLKnmb8lk2m6/X6rSx/Y/eF5oMsEBhzBa8B4iYZ0Gu0ho/Q99ZjfvDsj08YId7m16SL7Cy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6830:3483:b0:73e:643f:5b29 with SMTP id
 46e09a7af769-74177a4aaafmr4973749a34.3.1753943795474; Wed, 30 Jul 2025
 23:36:35 -0700 (PDT)
Date: Wed, 30 Jul 2025 23:36:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688b0ef3.a00a0220.26d0e1.0038.GAE@google.com>
Subject: [syzbot] [udf?] WARNING in __getblk_slow
From: syzbot <syzbot+89fa933c2012e808890e@syzkaller.appspotmail.com>
To: jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ced1b9e0392d Merge tag 'ata-6.17-rc1' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=154e9782580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a6d3e67bfa86ec9a
dashboard link: https://syzkaller.appspot.com/bug?extid=89fa933c2012e808890e
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11da74a2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12af8cf0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7992028cc1d8/disk-ced1b9e0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/21e8b1538aee/vmlinux-ced1b9e0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/04d1cab11b26/bzImage-ced1b9e0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+89fa933c2012e808890e@syzkaller.appspotmail.com

syz.1.17: attempt to access beyond end of device
nbd1: rw=0, sector=64, nr_sectors = 1 limit=0
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6081 at fs/buffer.c:1125 __getblk_slow+0x4cc/0x560 fs/buffer.c:1125
Modules linked in:
CPU: 1 UID: 0 PID: 6081 Comm: syz.1.17 Not tainted 6.16.0-syzkaller-00857-gced1b9e0392d #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:__getblk_slow+0x4cc/0x560 fs/buffer.c:1125
Code: c0 8b 48 89 df e8 04 43 bc ff 90 0f 0b e8 4c 7f 74 ff 48 c7 c6 e0 49 c0 8b 48 89 df e8 ed 42 bc ff 90 0f 0b e8 35 7f 74 ff 90 <0f> 0b 90 8b 74 24 0c 89 ea 48 c7 c7 40 4b c0 8b 31 db e8 4d 92 53
RSP: 0018:ffffc90003a3f7f0 EFLAGS: 00010293

RAX: 0000000000000000 RBX: 0000000000000200 RCX: ffffffff824775a6
RDX: ffff88802d388000 RSI: ffffffff824779eb RDI: 0000000000000005
RBP: 0000000000000400 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000200 R11: 0000000000000001 R12: ffff8880240db980
R13: 0000000000000100 R14: 0000000000000200 R15: ffff8880240db980
FS:  00007fc5345f26c0(0000) GS:ffff8881247f9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000004a00 CR3: 00000000638a0000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 bdev_getblk+0xd4/0xe0 fs/buffer.c:1461
 __bread_gfp+0x86/0x3c0 fs/buffer.c:1515
 sb_bread include/linux/buffer_head.h:346 [inline]
 udf_read_tagged+0xae/0x740 fs/udf/misc.c:199
 udf_check_anchor_block+0x89/0x4b0 fs/udf/super.c:1912
 udf_scan_anchors fs/udf/super.c:1952 [inline]
 udf_load_vrs+0x3b8/0x1070 fs/udf/super.c:2033
 udf_fill_super+0x791/0x1df0 fs/udf/super.c:2201
 get_tree_bdev_flags+0x389/0x620 fs/super.c:1692
 vfs_get_tree+0x8e/0x340 fs/super.c:1815
 do_new_mount fs/namespace.c:3805 [inline]
 path_mount+0x1482/0x1fd0 fs/namespace.c:4120
 do_mount fs/namespace.c:4133 [inline]
 __do_sys_mount fs/namespace.c:4344 [inline]
 __se_sys_mount fs/namespace.c:4321 [inline]
 __x64_sys_mount+0x28d/0x310 fs/namespace.c:4321
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc53378e9a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc5345f2038 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fc5339b5fa0 RCX: 00007fc53378e9a9
RDX: 0000200000000080 RSI: 0000200000004a00 RDI: 0000200000000000
RBP: 00007fc533810d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000014 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fc5339b5fa0 R15: 00007ffcecbba4c8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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


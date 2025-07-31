Return-Path: <linux-kernel+bounces-751850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59901B16E33
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CE061C2094E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7242BD031;
	Thu, 31 Jul 2025 09:11:32 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20D723FC74
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753953092; cv=none; b=fkmiTiC6oGYj/GftrKy08CGW2CFkDdPaQZYytsqqRCTn2fon0Z9k3WCpRR6qnBhoKJ4r44iuwMG3KEEiRNVhtEy5U9n6HOaKhvS0irU7sd51UozEv5hj95UKyRfOLVbjoUKeqgZx06DLaCkhpbKkMa8iEvBn+M7UFHs0XKukm28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753953092; c=relaxed/simple;
	bh=/6wpYbx1yfgiU0nhUxzTJxoanFU4paHotl55QuRmp+k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PgC1/9X7Vtp2eTgWsX9BR/KGKh+m6P+D7oAJsmzs4iM4f1kujGYIb03vBB77STFqFaT1xV0oU/tQIlTKS/7r30mK2ROX3J9tA2aM5TJV/xxKZ3Gdyikcvq8Pk/gKsU78E0JKs19qxqf1fxmZFq2Z38YTHcg9umt2ukvl/C8unpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3e3ecc7278bso17890915ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 02:11:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753953090; x=1754557890;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JRCI2U7Kkc4jz6gKI0XWRAE5bSKqFJzWtfqnLGzNIjI=;
        b=mIJqh124mu6LFjxCPp0wwccMUDHUua789chCmeVuMKVGq+KqtH9v9C57jdYmlmrJZl
         6u8jeCXZjdbB1bMUYL7nCCJvF8DeA/B8DS4tB5oZYx8JwcsOfKhbB30//HZcsVGOKdDH
         EeSCBAfl1i4fe6VYoXlHBqd38MjV6zpYNLsx+AvOBIIhcbQkWpoc9QcFu9e1YbU0toog
         jzNjZ0mwXS/XSkr6rb6owLz+T/RQlA8LlJB7HBxthyn9UOuacLD67+tg+yvNsFUwGIr6
         za6fN22CxiGXOA11EHouYzvMrSBEwiR/faGwCf+ZDX+0cvKEz1MXl6wuoxzx5Kr3kRvy
         Ze5g==
X-Forwarded-Encrypted: i=1; AJvYcCW65A2SSRDOKz6UMCFkTz4yuxBbJo9FwHVsBDwMG6iiZQg8H1RJ35xVSM5pdBR1ttXfFIeXIzKqOyLtrQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT2KhMoVERNIXJzMUZtMGwTtCQCeihMQshUkikKUnRteTc1ARg
	+V9P9pK82iGKAxQgGC54ZQtmmdis0QR54L77ascu4Vl2MddSjbTjnbH/LdAdj3/GftyMq6wISbT
	tg43IsaaQSZiWiMnEO9oDC6fJpkq2DqmJLm1RvvCv31WgkQtc6fDa+H7qxic=
X-Google-Smtp-Source: AGHT+IEA/OycrB3Vk7W+bBJ+CaFgswYDoBnpzEfP6dJ3Tpxp4PqYxxU+0AI7z3U1UjHNxA9VJuYZoaCbhXhKC2KbsD2qL8v0+/6U
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:480c:b0:3e3:d515:cf98 with SMTP id
 e9e14a558f8ab-3e3f6284b41mr116822065ab.20.1753953089821; Thu, 31 Jul 2025
 02:11:29 -0700 (PDT)
Date: Thu, 31 Jul 2025 02:11:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688b3341.a00a0220.26d0e1.003b.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in bch2_btree_repair_topology_recurse
From: syzbot <syzbot+9eb4c69fd4d4a1934f3a@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    260f6f4fda93 Merge tag 'drm-next-2025-07-30' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=154669bc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e6923811cbcd88f
dashboard link: https://syzkaller.appspot.com/bug?extid=9eb4c69fd4d4a1934f3a
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d0c834580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10961ca2580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-260f6f4f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/28b1dc006a89/vmlinux-260f6f4f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dcbc50612705/bzImage-260f6f4f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f8e958cdbaf9/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9eb4c69fd4d4a1934f3a@syzkaller.appspotmail.com

  btree=alloc level=1 u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq 3a29d24e27fd9a2e written 65534 min_key R 0:0:16777215 durability: 1 ptr: 0:178:0 gen 0
  btree topology error: 
------------[ cut here ]------------
kernel BUG at fs/bcachefs/btree_gc.c:528!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5534 Comm: syz.0.16 Not tainted 6.16.0-syzkaller-08685-g260f6f4fda93 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:bch2_btree_repair_topology_recurse+0x52dc/0x52e0 fs/bcachefs/btree_gc.c:528
Code: fd 90 0f 0b e8 05 e1 9c fd 90 0f 0b e8 fd e0 9c fd 90 0f 0b e8 f5 e0 9c fd 90 0f 0b e8 ed e0 9c fd 90 0f 0b e8 e5 e0 9c fd 90 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f
RSP: 0018:ffffc9000240ea60 EFLAGS: 00010293
RAX: ffffffff8422bbdb RBX: 00000000fffff6e8 RCX: ffff888000292440
RDX: 0000000000000000 RSI: 00000000fffff6e8 RDI: 0000000000000000
RBP: ffffc9000240ef90 R08: ffffffff8fa09237 R09: 1ffffffff1f41246
R10: dffffc0000000000 R11: fffffbfff1f41247 R12: ffff888011db2e00
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff88804137c000
FS:  0000555570dd9500(0000) GS:ffff88808d26e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1344372eb8 CR3: 000000001e88d000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 bch2_check_topology+0x692/0xe00 fs/bcachefs/btree_gc.c:602
 bch2_run_recovery_pass fs/bcachefs/recovery_passes.c:484 [inline]
 __bch2_run_recovery_passes+0x392/0x1010 fs/bcachefs/recovery_passes.c:539
 bch2_run_recovery_passes+0x184/0x210 fs/bcachefs/recovery_passes.c:610
 bch2_fs_recovery+0x2690/0x3a50 fs/bcachefs/recovery.c:1016
 bch2_fs_start+0xaaf/0xda0 fs/bcachefs/super.c:1213
 bch2_fs_get_tree+0xb39/0x1520 fs/bcachefs/fs.c:2488
 vfs_get_tree+0x8f/0x2b0 fs/super.c:1815
 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3805
 do_mount fs/namespace.c:4133 [inline]
 __do_sys_mount fs/namespace.c:4344 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4321
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f91ded9014a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff349f3738 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fff349f37c0 RCX: 00007f91ded9014a
RDX: 0000200000001000 RSI: 0000200000001040 RDI: 00007fff349f3780
RBP: 0000200000001000 R08: 00007fff349f37c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000200000001040
R13: 00007fff349f3780 R14: 0000000000004914 R15: 0000200000001080
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bch2_btree_repair_topology_recurse+0x52dc/0x52e0 fs/bcachefs/btree_gc.c:528
Code: fd 90 0f 0b e8 05 e1 9c fd 90 0f 0b e8 fd e0 9c fd 90 0f 0b e8 f5 e0 9c fd 90 0f 0b e8 ed e0 9c fd 90 0f 0b e8 e5 e0 9c fd 90 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f
RSP: 0018:ffffc9000240ea60 EFLAGS: 00010293
RAX: ffffffff8422bbdb RBX: 00000000fffff6e8 RCX: ffff888000292440
RDX: 0000000000000000 RSI: 00000000fffff6e8 RDI: 0000000000000000
RBP: ffffc9000240ef90 R08: ffffffff8fa09237 R09: 1ffffffff1f41246
R10: dffffc0000000000 R11: fffffbfff1f41247 R12: ffff888011db2e00
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff88804137c000
FS:  0000555570dd9500(0000) GS:ffff88808d26e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9b6a72b720 CR3: 000000001e88d000 CR4: 0000000000352ef0


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


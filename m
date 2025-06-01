Return-Path: <linux-kernel+bounces-669304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED53AC9DD8
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jun 2025 08:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7771F3A480D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jun 2025 06:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F02A18785D;
	Sun,  1 Jun 2025 06:11:35 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4539D40849
	for <linux-kernel@vger.kernel.org>; Sun,  1 Jun 2025 06:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748758294; cv=none; b=F/7YNB1ScZqTbJ3wzHFZ79Qf36zrFetxiljdCg4zGupYsyjqYZPtsUafQBR1WwsUPub61iM5AHZ2DvxupaaOJBwC2N5CnLz4EPKVwOO4awVs9DQcqCPvEWCHVsAZuXdh0Sfv+AFJFYT8TpdeC4vuGZcwL34erkkCXMXxuoifmng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748758294; c=relaxed/simple;
	bh=pyYX3C8LRSCyKiZKrsYikOuwL0FXhAHaGB3wCJUs2gI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Z8v9wrONJCUlRYX+9rHvYG4f5z2VuhP2W6hUV3EagGabKMss7renjWPxzqU3mzWg+q9/Jt+taAjrBvrQQvfqWhI2IQBe6amuGmF92daO3Vzlm0a9vg2UEV8SP8CRcvMSMX4irAluPReLWxVgSX9BV84wO6dqR+EsXWaefK2CuCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3dc9c1970daso34179925ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 May 2025 23:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748758292; x=1749363092;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uKbrcYgaP0mV7rHUaP9NAXtsAF8fMuJ66KpOzH9NbFY=;
        b=RlQ86YDnY4p6ER8q5to5p7a3vAP1dPpLVK5gk0wgaEO+cO2oap+59DyR0yW5fXuB4U
         XuEzUR8ib9qRSpZVCjamIi9ey7l89JxjcvXyJgY+tAgCiJkpw3fYIDRRaw6872rn0VMu
         zZdKE0L0ZuKHdLVqjH9sHGyzBAV/7UrsrkaJdkDq2UU7cdUlDeWka2odrBWH/wAH9ZEd
         Vtnz9Fcgkfx0KahMrxBoVnqji089+snkPzlP/XvudNjE1VGHvaFH1Tin9Bohcb7ibCm5
         C/HVYhfXTKAA2TIMwRSEK9I9cPPd9Z+iAwGB/R/Mh8NSGnpgmSiVThvdgwVktI+EQP5W
         sBrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlmTmo5IZcsIrH0nxdU56eK0ieNCrZLLxfQwI1vGCjHpFRunJgf1gmUXQscLM+348PXxuGfPrrPIVpVn0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkk7G1euhovrlIcyLybo3Z6Bc2zdhGzNlQOV5sFn3+ffPUmVb/
	2KBUI9ut9tN70OHpPhaSUN6jyeV2NtDr67Abnljyo5vDv0A1BcNgy5BqHWlcAqfdkmu+A+Xa/D+
	XmQU0S7OLD6OeKOGXv9dBgdZmhD51NWj6VgChRaKjmVkmsE2Uzs46GrQAiaI=
X-Google-Smtp-Source: AGHT+IGEB48SJoEvUugDnc6WtVV9IlSJIaZN9+CA2+QdNtOFbh4pJR020KDj1Q+gI/oLXRZ4FCx2C8FoQ0usKzovONWdH2MVE1yN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:972:b0:3dd:a270:37b2 with SMTP id
 e9e14a558f8ab-3dda27037cbmr30509905ab.1.1748758292411; Sat, 31 May 2025
 23:11:32 -0700 (PDT)
Date: Sat, 31 May 2025 23:11:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683bef14.a70a0220.1a6ae.0011.GAE@google.com>
Subject: [syzbot] [ocfs2?] kernel BUG in ocfs2_remove_extent
From: syzbot <syzbot+8882b2f5f48a7170a726@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c89756bcf406 Merge tag 'pm-6.16-rc1' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15fae6d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ded97a85afe9a6c8
dashboard link: https://syzkaller.appspot.com/bug?extid=8882b2f5f48a7170a726
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-c89756bc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b21d74e73303/vmlinux-c89756bc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b778ededeb75/bzImage-c89756bc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8882b2f5f48a7170a726@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/ocfs2/alloc.c:5581!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5320 Comm: syz.0.0 Not tainted 6.15.0-syzkaller-03478-gc89756bcf406 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ocfs2_remove_extent+0x1ecf/0x2020 fs/ocfs2/alloc.c:5581
Code: fa ff ff 48 8b 4c 24 08 80 e1 07 fe c1 38 c1 0f 8c 95 fa ff ff 48 8b 7c 24 08 e8 4c e8 8f fe e9 86 fa ff ff e8 22 08 2d fe 90 <0f> 0b f3 0f 1e fa 44 89 6c 24 10 65 8b 1d f3 25 06 0f bf 07 00 00
RSP: 0018:ffffc9000d3ee980 EFLAGS: 00010287
RAX: ffffffff8392ea2e RBX: ffffc9000d3ef178 RCX: 0000000000100000
RDX: ffffc9000ee94000 RSI: 000000000004f2da RDI: 000000000004f2db
RBP: ffffc9000d3eecd0 R08: ffff88803c8c4880 R09: 0000000000000006
R10: 00000000fffffffc R11: 0000000000000002 R12: 1ffff1100abcf048
R13: 0000000000000007 R14: ffff888055e78240 R15: dffffc0000000000
FS:  00007f98ae9896c0(0000) GS:ffff88808d28f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb0dc3a17e0 CR3: 000000003e12a000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ocfs2_remove_btree_range+0xdef/0x1540 fs/ocfs2/alloc.c:5778
 ocfs2_commit_truncate+0xb64/0x21d0 fs/ocfs2/alloc.c:7373
 ocfs2_truncate_file+0xca2/0x1420 fs/ocfs2/file.c:509
 ocfs2_setattr+0x1520/0x1b40 fs/ocfs2/file.c:1212
 notify_change+0xb33/0xe40 fs/attr.c:552
 do_truncate+0x1a4/0x220 fs/open.c:68
 handle_truncate fs/namei.c:3508 [inline]
 do_open fs/namei.c:3891 [inline]
 path_openat+0x306c/0x3830 fs/namei.c:4046
 do_filp_open+0x1fa/0x410 fs/namei.c:4073
 do_sys_openat2+0x121/0x1c0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_creat fs/open.c:1530 [inline]
 __se_sys_creat fs/open.c:1524 [inline]
 __x64_sys_creat+0x8f/0xc0 fs/open.c:1524
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f98adb8e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f98ae989038 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007f98addb6160 RCX: 00007f98adb8e969
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000200000000040
RBP: 00007f98adc10ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f98addb6160 R15: 00007ffd2df48568
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ocfs2_remove_extent+0x1ecf/0x2020 fs/ocfs2/alloc.c:5581
Code: fa ff ff 48 8b 4c 24 08 80 e1 07 fe c1 38 c1 0f 8c 95 fa ff ff 48 8b 7c 24 08 e8 4c e8 8f fe e9 86 fa ff ff e8 22 08 2d fe 90 <0f> 0b f3 0f 1e fa 44 89 6c 24 10 65 8b 1d f3 25 06 0f bf 07 00 00
RSP: 0018:ffffc9000d3ee980 EFLAGS: 00010287
RAX: ffffffff8392ea2e RBX: ffffc9000d3ef178 RCX: 0000000000100000
RDX: ffffc9000ee94000 RSI: 000000000004f2da RDI: 000000000004f2db
RBP: ffffc9000d3eecd0 R08: ffff88803c8c4880 R09: 0000000000000006
R10: 00000000fffffffc R11: 0000000000000002 R12: 1ffff1100abcf048
R13: 0000000000000007 R14: ffff888055e78240 R15: dffffc0000000000
FS:  00007f98ae9896c0(0000) GS:ffff88808d28f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffcc92d0d90 CR3: 000000003e12a000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup


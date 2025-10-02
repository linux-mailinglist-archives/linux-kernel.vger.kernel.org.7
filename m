Return-Path: <linux-kernel+bounces-840441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD343BB46F1
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F91C170750
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653361F2C45;
	Thu,  2 Oct 2025 16:01:31 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2793A8F7D
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759420890; cv=none; b=IUYGzkQ4zVz/qijvcyb72kVFrBsqq8MmYHBX9lSu8E6Q6+wah5/oIAEiKZoXRd1HsvHot2N4tOK7iGop+y2aBJUnKEjV64xJJEDRLJueePPHH5623qmCdEocjZnxnO7rxidUuQotto8BVcpxQjSy9wNNFN0DLh1dwQXcTKA80YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759420890; c=relaxed/simple;
	bh=w2Y2QF2llxGF8shdV8sbkQl9VQBi962VNSCw5q7OYcs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=S2ZOXi34hx3VsQBE+tAZogqxUQdG2Qu52hcdeRNpsUxv3LhLIOa0B6dm+fc5EMzH7zdoeBJ0t2ZwepnNTMtTacRfZD4TRluzi9ueF+MaTUHMA36fkIeLm07IaFK8+IScLBmDDL/eN3/Tx/vjl1fdOh9v6AP8twMuyTJ2rk245lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-9374627bb7eso295763639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 09:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759420888; x=1760025688;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Jz1T9sSuQKTB6Iy2gijMr4H81ISh/9XX5h9fzwPqRg=;
        b=e5Vgr9Wx8g4MA1sVs3vaK7oh9/CWc+6MP9xhsWmIfY3tpyXXKZfbwZEOgdf3MCTDZi
         eUm+KmgJtFvu+/w2CIaZrOibw1mt4uHop9bxLOZOdvLVS7mQ2TpvKJT//Y13lBvW1wNR
         ZCbZhSX5vLY53QtDY6nkyyhFYv+EmRb1mD4Z3XwUkNXNhRSzVoJmBsR0apuOIhxhrI/2
         HbSxoH/GIHFF311i6OHK7YXQ64jwFZLfhy3hxPG/b+5kSAiq3OuGodUBM6zQyg0IeALx
         YXXfS/Q0JFftR4dSuCp757BxafKgK534VMX3o9QHs4IlVOLCt7Nc6MSF0jCF500bGyzV
         G13g==
X-Forwarded-Encrypted: i=1; AJvYcCXGBQmCXD5haKwokg/jzp8d7xl7Sa5MQTjACPMNWV0EoMhhqT7saoif22J5li83glH+nhN3OANtxcJvFKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw471Ce4yfAEsstsKpUOUu8T+d7TIzV4jBmWqgFTGzfrvIcfR3q
	ps3Tz5Lon+eog0PQlTwUFOq4QinbT8F2asp48qya2nXRjqDM44AH9cR16v0ImZdcQbMnZ+RHJUu
	UwTGW+WVkncsjVp73aThKenPDU4WjpVRama2qjo/es240esUfj4VpBmUBWas=
X-Google-Smtp-Source: AGHT+IHffKavk02Gbend6tu0ZvbYDE2ugTDl2b4vE30bJvYlN+ntr9RClO6SL6k1O2AbMbbG9hI2WRr4z1uSBD9hUQYev1uKiqnu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c265:0:b0:428:cd3c:6a3c with SMTP id
 e9e14a558f8ab-42d8b192b01mr35614035ab.1.1759420887768; Thu, 02 Oct 2025
 09:01:27 -0700 (PDT)
Date: Thu, 02 Oct 2025 09:01:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dea1d7.050a0220.25d7ab.07bc.GAE@google.com>
Subject: [syzbot] [ntfs3?] [usb?] general protection fault in rtlock_slowlock_locked
From: syzbot <syzbot+08df3e4c9b304b37cb04@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    99bade344cfa Merge tag 'rust-fixes-6.17' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f513a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98e114f4eb77e551
dashboard link: https://syzkaller.appspot.com/bug?extid=08df3e4c9b304b37cb04
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/309f13a7cc12/disk-99bade34.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0d782186486b/vmlinux-99bade34.xz
kernel image: https://storage.googleapis.com/syzbot-assets/174f592d16e2/bzImage-99bade34.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+08df3e4c9b304b37cb04@syzkaller.appspotmail.com

loop7: detected capacity change from 0 to 4096
Oops: general protection fault, probably for non-canonical address 0xffdffc0000000148: 0000 [#1] SMP KASAN PTI
KASAN: maybe wild-memory-access in range [0xff00000000000a40-0xff00000000000a47]
CPU: 0 UID: 0 PID: 11227 Comm: syz.7.607 Tainted: G        W           6.17.0-rc1-syzkaller-00214-g99bade344cfa #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:debug_spin_lock_before kernel/locking/spinlock_debug.c:86 [inline]
RIP: 0010:do_raw_spin_lock+0x78/0x290 kernel/locking/spinlock_debug.c:115
Code: aa 9c 81 48 8d 4c 24 20 48 c1 e9 03 48 b8 f1 f1 f1 f1 04 f3 f3 f3 48 89 4c 24 18 4a 89 04 39 4c 8d 77 04 4c 89 f0 48 c1 e8 03 <42> 0f b6 04 38 84 c0 0f 85 9f 01 00 00 41 8b 06 3d ad 4e ad de 0f
RSP: 0018:ffffc900049ff4c0 EFLAGS: 00010807
RAX: 1fe0000000000148 RBX: ff00000000000a40 RCX: 1ffff9200093fe9c
RDX: 0000000000000000 RSI: ffffffff8b620b60 RDI: ff00000000000a40
RBP: ffffc900049ff570 R08: 0000000000000001 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed10053788b9 R12: ffff88808316a1b0
R13: ff00000000000000 R14: ff00000000000a44 R15: dffffc0000000000
FS:  00007f7f773fe6c0(0000) GS:ffff8881268c5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7f79182020 CR3: 000000005aace000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 task_blocks_on_rt_mutex kernel/locking/rtmutex.c:1265 [inline]
 rtlock_slowlock_locked+0x8ef/0x4010 kernel/locking/rtmutex.c:1851
 rtlock_slowlock kernel/locking/rtmutex.c:1895 [inline]
 rtlock_lock kernel/locking/spinlock_rt.c:43 [inline]
 __rt_spin_lock kernel/locking/spinlock_rt.c:49 [inline]
 rt_spin_lock+0x152/0x2c0 kernel/locking/spinlock_rt.c:57
 spin_lock include/linux/spinlock_rt.h:44 [inline]
 iput_final fs/inode.c:1886 [inline]
 iput+0x5c1/0x9d0 fs/inode.c:1923
 ntfs_fill_super+0x38fa/0x40b0 fs/ntfs3/super.c:1514
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1692
 vfs_get_tree+0x8f/0x2b0 fs/super.c:1815
 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3805
 do_mount fs/namespace.c:4133 [inline]
 __do_sys_mount fs/namespace.c:4344 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4321
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7f791a038a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7f773fde68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f7f773fdef0 RCX: 00007f7f791a038a
RDX: 0000200000000080 RSI: 0000200000000000 RDI: 00007f7f773fdeb0
RBP: 0000200000000080 R08: 00007f7f773fdef0 R09: 0000000002010c10
R10: 0000000002010c10 R11: 0000000000000246 R12: 0000200000000000
R13: 00007f7f773fdeb0 R14: 000000000001f743 R15: 0000200000000380
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:debug_spin_lock_before kernel/locking/spinlock_debug.c:86 [inline]
RIP: 0010:do_raw_spin_lock+0x78/0x290 kernel/locking/spinlock_debug.c:115
Code: aa 9c 81 48 8d 4c 24 20 48 c1 e9 03 48 b8 f1 f1 f1 f1 04 f3 f3 f3 48 89 4c 24 18 4a 89 04 39 4c 8d 77 04 4c 89 f0 48 c1 e8 03 <42> 0f b6 04 38 84 c0 0f 85 9f 01 00 00 41 8b 06 3d ad 4e ad de 0f
RSP: 0018:ffffc900049ff4c0 EFLAGS: 00010807
RAX: 1fe0000000000148 RBX: ff00000000000a40 RCX: 1ffff9200093fe9c
RDX: 0000000000000000 RSI: ffffffff8b620b60 RDI: ff00000000000a40
RBP: ffffc900049ff570 R08: 0000000000000001 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed10053788b9 R12: ffff88808316a1b0
R13: ff00000000000000 R14: ff00000000000a44 R15: dffffc0000000000
FS:  00007f7f773fe6c0(0000) GS:ffff8881268c5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7f79182020 CR3: 000000005aace000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	aa                   	stos   %al,%es:(%rdi)
   1:	9c                   	pushf
   2:	81 48 8d 4c 24 20 48 	orl    $0x4820244c,-0x73(%rax)
   9:	c1 e9 03             	shr    $0x3,%ecx
   c:	48 b8 f1 f1 f1 f1 04 	movabs $0xf3f3f304f1f1f1f1,%rax
  13:	f3 f3 f3
  16:	48 89 4c 24 18       	mov    %rcx,0x18(%rsp)
  1b:	4a 89 04 39          	mov    %rax,(%rcx,%r15,1)
  1f:	4c 8d 77 04          	lea    0x4(%rdi),%r14
  23:	4c 89 f0             	mov    %r14,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 38       	movzbl (%rax,%r15,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 9f 01 00 00    	jne    0x1d6
  37:	41 8b 06             	mov    (%r14),%eax
  3a:	3d ad 4e ad de       	cmp    $0xdead4ead,%eax
  3f:	0f                   	.byte 0xf


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


Return-Path: <linux-kernel+bounces-720217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5839AFB8AB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145C54A250D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A67A2222C2;
	Mon,  7 Jul 2025 16:32:35 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB0818035
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751905954; cv=none; b=V1DbE8QUV7CKDi9DntFQkIq0pWgKgNPV7i+98bN4ebZLExhmfFCdTYaT3nLoFFbZI6v2t486dkhG3R3tYiUMQCBaqdGdQT5c4luW/QlvAryOdDZCQEbJfwb4is97cEqUW2iNHyqf2egXIBogB0VwlG5aQHeaNRmw5I0/c6lI4hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751905954; c=relaxed/simple;
	bh=QhkoOpOrc2KLKM25CBxZwojNZdqTPjmpwHqKnkWvU5Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZX7N4P3M7tMbCvb2aYwb5oq9kmLydDbrd+OhFQG/rtD0IanFIh4Oy48E5kR82IYkQksuwKX3boN/HARYVks8vKXSGTWFX8fviEG3OC6gmVhiGumXez+IYsdToYWdNsqGCJSqmePa1wot4f58slyqPHOPES8aGpRjbTmhylZAQ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3df33827a8cso79757565ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 09:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751905952; x=1752510752;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4shpgMrHUYMpQvEavxw27uw1dfjEvqrEkx31vuHqsqo=;
        b=K/vUdYTcyG9HpQnNjlI6cYP6Vw3ClNrPdBWTaioY9wXxV9PMnd18S6tlK7HahJISH0
         JocuBWbOYEew26WLAAXqxn3CWmIueO4HY0mn5XJfeKp94enBfkfGfW7h1iQDnCuRO7N3
         gzEeElt4Rzh7zS3XDq3DZq1LKxiotEoHqAJ0srckxfwVTWuYPI0jjW2NAZYH5RMyhSso
         XJDo5+OfGgq/cAc8B6pFDr/bySwE+qK1K+au2/fxGqDZpEjZNViyITota1+Zr2gHefxT
         6JvIAfHNizlFU7Wl6wiV6oKQM1564wY9eLDpTMLcyU4sl61iUX6fa4JUMq8MkzoLLZNZ
         4Zjg==
X-Forwarded-Encrypted: i=1; AJvYcCUzUJt6r3YcxCDt1itC5U3oQtbbxdIWl1tU0D/RrpR2rfkcsoCzs+GKQqeFqaXrcXZ10tZ4eeadaGYuJ4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrxFTK35re5aK2cECA9DDF2xADvMzeiLphoIS1uz/EAkXVmvAn
	FhfgCEJ5BzwK76nbYjhQmgY0a7apWNhfpZwhZzAzDIkbpsYBVXgKs+INorouhAY5gBKXVZknuM9
	9Xr0P6TvZ8GOrVarCwiEVqZJN22lyLJHsDghSaRwflYj6meU2c4HeMM0im9g=
X-Google-Smtp-Source: AGHT+IG/yY2tnVRcPfFcaDTdrKQFfM+7kNsqwvSq0QP+BT0pdomiGxwky12gfOre/q2dA7ifHV3FqVgPED92RH8BXVBscnyG32Kg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219c:b0:3dd:b523:7abe with SMTP id
 e9e14a558f8ab-3e137218e14mr122114395ab.18.1751905952163; Mon, 07 Jul 2025
 09:32:32 -0700 (PDT)
Date: Mon, 07 Jul 2025 09:32:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686bf6a0.a00a0220.b087d.01f1.GAE@google.com>
Subject: [syzbot] [kernel?] BUG: unable to handle kernel paging request in parport_attach
From: syzbot <syzbot+c47f45cfb7fc1640ced7@syzkaller.appspotmail.com>
To: abbotti@mev.co.uk, hsweeten@visionengravers.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a79a588fc176 Merge tag 'pm-6.16-rc5' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1466cf70580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=729bc2714205b7c8
dashboard link: https://syzkaller.appspot.com/bug?extid=c47f45cfb7fc1640ced7
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e21c8c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b62c8c580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/98a89b9f34e4/non_bootable_disk-a79a588f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bf35a246f739/vmlinux-a79a588f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8e0e99375077/zImage-a79a588f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c47f45cfb7fc1640ced7@syzkaller.appspotmail.com

8<--- cut here ---
Unable to handle kernel paging request at virtual address fee000f0 when write
[fee000f0] *pgd=80000080007003, *pmd=00000000
Internal error: Oops: a06 [#1] SMP ARM
Modules linked in:
CPU: 0 UID: 0 PID: 4088 Comm: syz.2.16 Not tainted 6.16.0-rc4-syzkaller #0 PREEMPT 
Hardware name: ARM-Versatile Express
PC is at __raw_writeb arch/arm/include/asm/io.h:88 [inline]
PC is at parport_attach drivers/comedi/drivers/comedi_parport.c:289 [inline]
PC is at parport_attach+0x174/0x1d0 drivers/comedi/drivers/comedi_parport.c:224
LR is at parport_attach drivers/comedi/drivers/comedi_parport.c:289 [inline]
LR is at parport_attach+0x164/0x1d0 drivers/comedi/drivers/comedi_parport.c:224
pc : [<81398ba8>]    lr : [<81398b98>]    psr: 60000013
sp : e05e1d38  ip : e05e1d38  fp : e05e1d5c
r10: 82b15078  r9 : 00000003  r8 : 841493c0
r7 : e05e1d98  r6 : 841493c0  r5 : 00000000  r4 : 00000000
r3 : fee000f0  r2 : 81e14f0c  r1 : 00000001  r0 : 81398818
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 30c5387d  Table: 85588d40  DAC: fffffffd
Register r0 information: non-slab/vmalloc memory
Register r1 information: non-paged memory
Register r2 information: non-slab/vmalloc memory
Register r3 information: 0-page vmalloc region starting at 0xfee00000 allocated at pci_reserve_io+0x0/0x38 arch/arm/mm/mmu.c:1055
Register r4 information: NULL pointer
Register r5 information: NULL pointer
Register r6 information: slab kmalloc-192 start 841493c0 pointer offset 0 size 192
Register r7 information: 2-page vmalloc region starting at 0xe05e0000 allocated at kernel_clone+0xac/0x3e4 kernel/fork.c:2599
Register r8 information: slab kmalloc-192 start 841493c0 pointer offset 0 size 192
Register r9 information: non-paged memory
Register r10 information: non-slab/vmalloc memory
Register r11 information: 2-page vmalloc region starting at 0xe05e0000 allocated at kernel_clone+0xac/0x3e4 kernel/fork.c:2599
Register r12 information: 2-page vmalloc region starting at 0xe05e0000 allocated at kernel_clone+0xac/0x3e4 kernel/fork.c:2599
Process syz.2.16 (pid: 4088, stack limit = 0xe05e0000)
Stack: (0xe05e1d38 to 0xe05e2000)
1d20:                                                       823f88f8 841493c0
1d40: 829c4b18 829c4b18 81e153cc 00000000 e05e1d94 e05e1d60 81394c60 81398a40
1d60: b5403587 00000000 83308000 20000080 841493c0 b5403587 20000080 83308000
1d80: 40946400 00000003 e05e1e4c e05e1d98 813908f0 81394b68 656d6f63 705f6964
1da0: 6f707261 00007472 00000000 000000f0 80008000 00000001 0000000a 00000000
1dc0: 00000000 10000001 00000001 00001000 00000001 00000008 00000001 00000006
1de0: 00000004 0000ffff 00000006 ffffffa7 00000009 fffffffd 00000005 000003ff
1e00: 00010000 00000800 0000e2df 00000009 000000ff 00000000 00000003 00000007
1e20: 00000005 00000005 00000000 444c0355 00000000 84fb0240 841493c0 20000080
1e40: e05e1f14 e05e1e50 813918a4 81390824 00000000 00000000 00000000 444c0355
1e60: 00000000 00000000 8246a3fc 0000005f 83ff3458 841493f0 8419275c 83308000
1e80: e05e1ee4 e05e1e90 8079688c 8078cb7c 00000064 00000001 00000000 e05e1eac
1ea0: 84e83490 8357be58 00006400 0000000b e05e1ea0 00000000 00000000 444c0355
1ec0: 84fb0240 40946400 20000080 20000080 00000003 84fb0240 e05e1ef4 e05e1ee8
1ee0: 807969ac 444c0355 e05e1f14 40946400 00000000 84fb0240 20000080 00000003
1f00: 84fb0240 83308000 e05e1fa4 e05e1f18 8056f16c 813912d4 e05e1f4c e05e1f28
1f20: 80349a98 8034cdb4 81a2db68 81a2da38 e05e1f54 e05e1f40 8026203c 7ead2920
1f40: e05e1fa4 e05e1f50 8034a2e0 803499a4 00000000 7ead2920 ffffffff 80234128
1f60: 00000000 00000000 00000000 00000000 00000000 444c0355 e05e1fac 00000000
1f80: 00000000 002f6300 00000036 8020029c 83308000 00000036 00000000 e05e1fa8
1fa0: 80200060 8056f048 00000000 00000000 00000003 40946400 20000080 00000000
1fc0: 00000000 00000000 002f6300 00000036 00000000 002f62d4 0000047b 00000000
1fe0: 7ead2780 7ead2770 000193a4 00131f40 60000010 00000003 00000000 00000000
Call trace: 
[<81398a34>] (parport_attach) from [<81394c60>] (comedi_device_attach+0x104/0x240 drivers/comedi/drivers.c:996)
 r6:00000000 r5:81e153cc r4:829c4b18
[<81394b5c>] (comedi_device_attach) from [<813908f0>] (do_devconfig_ioctl+0xd8/0x1e0 drivers/comedi/comedi_fops.c:855)
 r10:00000003 r9:40946400 r8:83308000 r7:20000080 r6:b5403587 r5:841493c0
 r4:20000080
[<81390818>] (do_devconfig_ioctl) from [<813918a4>] (comedi_unlocked_ioctl+0x5dc/0x1b94 drivers/comedi/comedi_fops.c:2136)
 r6:20000080 r5:841493c0 r4:84fb0240
[<813912c8>] (comedi_unlocked_ioctl) from [<8056f16c>] (vfs_ioctl fs/ioctl.c:51 [inline])
[<813912c8>] (comedi_unlocked_ioctl) from [<8056f16c>] (do_vfs_ioctl fs/ioctl.c:861 [inline])
[<813912c8>] (comedi_unlocked_ioctl) from [<8056f16c>] (__do_sys_ioctl fs/ioctl.c:905 [inline])
[<813912c8>] (comedi_unlocked_ioctl) from [<8056f16c>] (sys_ioctl+0x130/0xdc8 fs/ioctl.c:893)
 r10:83308000 r9:84fb0240 r8:00000003 r7:20000080 r6:84fb0240 r5:00000000
 r4:40946400
[<8056f03c>] (sys_ioctl) from [<80200060>] (ret_fast_syscall+0x0/0x1c arch/arm/mm/proc-v7.S:67)
Exception stack(0xe05e1fa8 to 0xe05e1ff0)
1fa0:                   00000000 00000000 00000003 40946400 20000080 00000000
1fc0: 00000000 00000000 002f6300 00000036 00000000 002f62d4 0000047b 00000000
1fe0: 7ead2780 7ead2770 000193a4 00131f40
 r10:00000036 r9:83308000 r8:8020029c r7:00000036 r6:002f6300 r5:00000000
 r4:00000000
Code: e596306c e3a04000 e7f33053 e2433612 (e5c34000) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	e596306c 	ldr	r3, [r6, #108]	@ 0x6c
   4:	e3a04000 	mov	r4, #0
   8:	e7f33053 	ubfx	r3, r3, #0, #20
   c:	e2433612 	sub	r3, r3, #18874368	@ 0x1200000
* 10:	e5c34000 	strb	r4, [r3] <-- trapping instruction


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


Return-Path: <linux-kernel+bounces-720216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5284BAFB8AA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12FC73ACAFF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CDC226D16;
	Mon,  7 Jul 2025 16:31:32 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5BA1F75A6
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 16:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751905891; cv=none; b=mbBuCIejQ8KH2nJD1q/7xjTAQQssmu7U5b9GMJNOnN8VMQ8MlJ7EhkvLWvYR3B62GScleQqV8+YJzZHNFbp28c1dpASN7JlgkfKapb5HYYNSKdKE36fIzCWTn/WxF94pbwur1jCPm8O4UFkWU8tlzStzs2i3qmKS78hT2v4j/wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751905891; c=relaxed/simple;
	bh=K/LdWLscriTPQVJbSYuVzlFVPfi0UGsNsCb+7Coxmcs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VUkLXuEh3e1T15pL0fpO6lzj6hBRnOjqHFhV6QDmLdTV5+pJYDNfnuExAfjn3UdjrX3H95zlvg19Y0WtuV+aHTFbLcuZt/TETrGG/l3jM+Kh57Wh/meI2QOFeNFKIC3a2Nad3+T7v3b1p7Mp35OBx0O4Nz7OgzIzunm4dCxiTA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-879489ddf11so57635239f.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 09:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751905888; x=1752510688;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zmNwU2HJfIZWI+m5X2I0t32gpP175F9jNGk5ucbmrOg=;
        b=StDDrqS4ynwstsJIb7YQiHDraWtbzg9RCvyOcfR+lixFy9X9Vtr2Pa0dbiwaFcpDdL
         0Gtr3HwdPjqPSRj8hea9/1vJ1vb32wsgIZY1FT8oKhRPgJ0tm2Mke6Imx/3jrs18/1QU
         RcQkahs5OfJUQ5nAt2E4jGkBrvGBaS9rzqPMw038MUtxbwqIpJg7+FVMRtm48irW4a0p
         HBjsttRwEJ3agko7EH3wLzcMuwUuDQOGM8e9YVFfXNueQisLkGbeo4DMiRkT0NZYxszM
         yvtl3spn9JDI4hZp3Zfdc6Ei+Wixhgam7oQp9fgnZ7dDhMJloU0vhs79+BKUMePpU0qe
         FYmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcThxqcpl8byvMP6uB+DHredDpVrUJ5In7IsqqA688NszLcF7/iXLm3UYLlsROfg+bu93A+VC8cMTpmAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtNZ2+LevuUSFhhgPEcTPH7fIT+dU41MOQvAqg4CbqYIaLOeu+
	c6HLpeglUyROmF5HYhjVm3vniHuawbMxzYUYUTApBQBAOm7Ma5p6/aSEglyB5614e2Hk2UOqTBu
	Mraum3vByhYymkB+vo+aSOdAjUOXfeUUZ0Z1mFPFCcSv9UaJfbqIMt30emMY=
X-Google-Smtp-Source: AGHT+IH9iH/cXjg8TaPAYmSdCkgNYtdUHzF/4OG1zfC/b9RZvhCasVOVPBYYGfs0HyUaVXI44jgddMPSONa6deTeRlq1RO04i5fn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1353:b0:876:c8e9:8b11 with SMTP id
 ca18e2360f4ac-8794a3c7257mr34552139f.8.1751905887678; Mon, 07 Jul 2025
 09:31:27 -0700 (PDT)
Date: Mon, 07 Jul 2025 09:31:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686bf65f.a70a0220.29fe6c.0b0f.GAE@google.com>
Subject: [syzbot] [kernel?] BUG: unable to handle kernel paging request in subdev_8255_io
From: syzbot <syzbot+f7ad508e3c76c097483f@syzkaller.appspotmail.com>
To: abbotti@mev.co.uk, hsweeten@visionengravers.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a79a588fc176 Merge tag 'pm-6.16-rc5' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17e21c8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=729bc2714205b7c8
dashboard link: https://syzkaller.appspot.com/bug?extid=f7ad508e3c76c097483f
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e6cf70580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10121c8c580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/98a89b9f34e4/non_bootable_disk-a79a588f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bf35a246f739/vmlinux-a79a588f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8e0e99375077/zImage-a79a588f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f7ad508e3c76c097483f@syzkaller.appspotmail.com

8<--- cut here ---
Unable to handle kernel paging request at virtual address fee0000f when write
[fee0000f] *pgd=80000080007003, *pmd=00000000
Internal error: Oops: a06 [#1] SMP ARM
Modules linked in:
CPU: 1 UID: 0 PID: 4085 Comm: syz.2.16 Not tainted 6.16.0-rc4-syzkaller #0 PREEMPT 
Hardware name: ARM-Versatile Express
PC is at __raw_writeb arch/arm/include/asm/io.h:88 [inline]
PC is at subdev_8255_io drivers/comedi/drivers/comedi_8255.c:47 [inline]
PC is at subdev_8255_io+0x60/0x6c drivers/comedi/drivers/comedi_8255.c:43
LR is at subdev_8255_io drivers/comedi/drivers/comedi_8255.c:47 [inline]
LR is at subdev_8255_io+0x4c/0x6c drivers/comedi/drivers/comedi_8255.c:43
pc : [<813a5ab0>]    lr : [<813a5a9c>]    psr: 60000013
sp : dfc95cc0  ip : dfc95cc0  fp : dfc95cdc
r10: 00000000  r9 : 00000000  r8 : 00000084
r7 : 0000000c  r6 : 0000009b  r5 : 84064900  r4 : 0000000f
r3 : 0000009b  r2 : fee0000f  r1 : 00000001  r0 : 84064900
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 30c5387d  Table: 848edb00  DAC: 00000000
Register r0 information: slab kmalloc-192 start 84064900 pointer offset 0 size 192
Register r1 information: non-paged memory
Register r2 information: 0-page vmalloc region starting at 0xfee00000 allocated at pci_reserve_io+0x0/0x38 arch/arm/mm/mmu.c:1055
Register r3 information: non-paged memory
Register r4 information: non-paged memory
Register r5 information: slab kmalloc-192 start 84064900 pointer offset 0 size 192
Register r6 information: non-paged memory
Register r7 information: non-paged memory
Register r8 information: non-paged memory
Register r9 information: NULL pointer
Register r10 information: NULL pointer
Register r11 information: 2-page vmalloc region starting at 0xdfc94000 allocated at kernel_clone+0xac/0x3e4 kernel/fork.c:2599
Register r12 information: 2-page vmalloc region starting at 0xdfc94000 allocated at kernel_clone+0xac/0x3e4 kernel/fork.c:2599
Process syz.2.16 (pid: 4085, stack limit = 0xdfc94000)
Stack: (0xdfc95cc0 to 0xdfc96000)
5cc0: 813a5a50 84064900 0000000c 0000000c dfc95cfc dfc95ce0 813a5788 813a5a5c
5ce0: 0000000c 80508714 85761800 85761800 dfc95d1c dfc95d00 813a5b48 813a573c
5d00: 85761800 84064900 dfc95dac 0000000c dfc95d5c dfc95d20 813a5d3c 813a5ac8
5d20: 20000013 8543a780 82822670 00000000 00000000 829c52b0 84064900 00000000
5d40: dfc95d98 84064900 00000000 82b15078 dfc95d94 dfc95d60 81394c60 813a5c8c
5d60: 20000140 00000000 dfc95d84 20000140 84064900 b5403587 20000140 85400c00
5d80: 40946400 00000003 dfc95e4c dfc95d98 813908f0 81394b68 35353238 00000000
5da0: 00000000 00000000 00000000 0000000c 00002166 00000002 00000010 000088d6
5dc0: 00000b45 00000008 00000010 00000000 ffffffff 00000200 00000fff 00000344
5de0: 00000001 00000002 00000200 00000009 00000003 00000003 00000001 00000004
5e00: 00000000 00000080 00000004 00000001 00000001 0000b0c4 000007df 00000008
5e20: 000000f3 00000001 00000000 4c54bfda 00000000 8497b000 84064900 20000140
5e40: dfc95f14 dfc95e50 813918a4 81390824 00000000 00000000 00000000 4c54bfda
5e60: 00000000 00000000 8246a3fc 0000005f 83ec1858 84064930 842b4174 85400c00
5e80: dfc95ee4 dfc95e90 8079688c 8078cb7c 00000064 00000001 00000000 dfc95eac
5ea0: 85639850 8342b5d8 00006400 0000000b dfc95ea0 00000000 00000000 4c54bfda
5ec0: 8497b000 40946400 20000140 20000140 00000003 8497b000 dfc95ef4 dfc95ee8
5ee0: 807969ac 4c54bfda dfc95f14 40946400 00000000 8497b000 20000140 00000003
5f00: 8497b000 85400c00 dfc95fa4 dfc95f18 8056f16c 813912d4 dfc95f4c dfc95f28
5f20: 80349a98 8034cdb4 81a2db68 81a2da38 dfc95f54 dfc95f40 8026203c 7edec920
5f40: dfc95fa4 dfc95f50 8034a2e0 803499a4 00000000 7edec920 ffffffff 80234128
5f60: 00000000 00000000 00000000 00000000 00000000 4c54bfda dfc95fac 00000000
5f80: 00000000 002f6300 00000036 8020029c 85400c00 00000036 00000000 dfc95fa8
5fa0: 80200060 8056f048 00000000 00000000 00000003 40946400 20000140 00000000
5fc0: 00000000 00000000 002f6300 00000036 00000000 002f62d4 0000047b 00000000
5fe0: 7edec780 7edec770 000193a4 00131f40 60000010 00000003 00000000 00000000
Call trace: 
[<813a5a50>] (subdev_8255_io) from [<813a5788>] (subdev_8255_do_config+0x58/0x60 drivers/comedi/drivers/comedi_8255.c:115)
 r7:0000000c r6:0000000c r5:84064900 r4:813a5a50
[<813a5730>] (subdev_8255_do_config) from [<813a5b48>] (__subdev_8255_init drivers/comedi/drivers/comedi_8255.c:172 [inline])
[<813a5730>] (subdev_8255_do_config) from [<813a5b48>] (subdev_8255_io_init+0x8c/0x9c drivers/comedi/drivers/comedi_8255.c:192)
 r4:85761800
[<813a5abc>] (subdev_8255_io_init) from [<813a5d3c>] (dev_8255_attach drivers/comedi/drivers/8255.c:83 [inline])
[<813a5abc>] (subdev_8255_io_init) from [<813a5d3c>] (dev_8255_attach+0xbc/0x114 drivers/comedi/drivers/8255.c:46)
 r7:0000000c r6:dfc95dac r5:84064900 r4:85761800
[<813a5c80>] (dev_8255_attach) from [<81394c60>] (comedi_device_attach+0x104/0x240 drivers/comedi/drivers.c:996)
 r10:82b15078 r9:00000000 r8:84064900 r7:dfc95d98 r6:00000000 r5:84064900
 r4:829c52b0
[<81394b5c>] (comedi_device_attach) from [<813908f0>] (do_devconfig_ioctl+0xd8/0x1e0 drivers/comedi/comedi_fops.c:855)
 r10:00000003 r9:40946400 r8:85400c00 r7:20000140 r6:b5403587 r5:84064900
 r4:20000140
[<81390818>] (do_devconfig_ioctl) from [<813918a4>] (comedi_unlocked_ioctl+0x5dc/0x1b94 drivers/comedi/comedi_fops.c:2136)
 r6:20000140 r5:84064900 r4:8497b000
[<813912c8>] (comedi_unlocked_ioctl) from [<8056f16c>] (vfs_ioctl fs/ioctl.c:51 [inline])
[<813912c8>] (comedi_unlocked_ioctl) from [<8056f16c>] (do_vfs_ioctl fs/ioctl.c:861 [inline])
[<813912c8>] (comedi_unlocked_ioctl) from [<8056f16c>] (__do_sys_ioctl fs/ioctl.c:905 [inline])
[<813912c8>] (comedi_unlocked_ioctl) from [<8056f16c>] (sys_ioctl+0x130/0xdc8 fs/ioctl.c:893)
 r10:85400c00 r9:8497b000 r8:00000003 r7:20000140 r6:8497b000 r5:00000000
 r4:40946400
[<8056f03c>] (sys_ioctl) from [<80200060>] (ret_fast_syscall+0x0/0x1c arch/arm/mm/proc-v7.S:67)
Exception stack(0xdfc95fa8 to 0xdfc95ff0)
5fa0:                   00000000 00000000 00000003 40946400 20000140 00000000
5fc0: 00000000 00000000 002f6300 00000036 00000000 002f62d4 0000047b 00000000
5fe0: 7edec780 7edec770 000193a4 00131f40
 r10:00000036 r9:85400c00 r8:8020029c r7:00000036 r6:002f6300 r5:00000000
 r4:00000000
Code: e6ef3076 e0842002 e7f32052 e2422612 (e5c23000) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	e6ef3076 	uxtb	r3, r6
   4:	e0842002 	add	r2, r4, r2
   8:	e7f32052 	ubfx	r2, r2, #0, #20
   c:	e2422612 	sub	r2, r2, #18874368	@ 0x1200000
* 10:	e5c23000 	strb	r3, [r2] <-- trapping instruction


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


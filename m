Return-Path: <linux-kernel+bounces-720218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABB3AFB8AD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 401DD420242
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9739F22424E;
	Mon,  7 Jul 2025 16:32:35 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F5172606
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 16:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751905955; cv=none; b=Y/vghi8ZBoR7huc3lnZzO7BijKA5lVs5fUbQGurt2hWezOkE/2x0PAB+YM4otdoOMlIO5xSqvOyXsgnQZ3qAWUQ0CiNZeSUwmzAvGH16vKh0sU+s3aF2Wi7eHqVaXsUyHJ1KnFXN8N9GwuIiZxfwl4FsHA1KMbt+HDJIt3HQWHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751905955; c=relaxed/simple;
	bh=W/cESdpal0+aRH6FijR4mrjH9vnRB+jK2Q+9mI6NpmY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VQobT46hBcqP6U3CztGIvuLiE1c+2OlLgbtE+DXvLdnL3TkZcfbqHIwKsZrzL7dyZ4GscBirSMXUP9a4ajYWfbqob+UAEZnWCY/L60XfV+2FUmRmPk1nc/B3AFXkxc10qsfX1iujtpKoqiL5jR4/KuUAFKF3kb48C1FoUTrnQUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3df40226ab7so79305965ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 09:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751905952; x=1752510752;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ndE3wqK/4T/8inqY41BAo34YwVTH1tympJR9v8r4fYk=;
        b=IIx/+nq2866MjnZ2D+POjgGYR6husCNayGGCmd4mSnirZ5DbRz8thqPiKi4wBCZXTC
         xohp2GNV6ArahUh1g1jlxo03Ju3Z69XNBhYDJsZD4FVs+0xVIagnN2R841IyV8+Y7AAH
         /clx99aiN1ZtvARWgMgAU2Z9Z1bw1nqjL+u7aiUTAdsZwRrnuuzRugfL02H2D8ADG8FQ
         wKBjhz+b1jAPXq76OSfsOUBzzzD+Te18L88zRAldlsyktNm/FdA199Nr0rttKY1GTteh
         TJgX4AwM+Y6Vd94xG0VM44IZL4kBmWlkrhDtNdjfnVLV9CxmI/jks/Os1AgMPRLkFf0k
         Jr3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwvSAqORJ50V8VAAPlvRK/ILKJVr/GddqL6N6pzQEwsksbRDTURpR4rMrCDonqkGlOxLoEJzw9njMVk1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyzUHiEiTyUveAtfxdawknrDeh1tZm6QA27c0oenKz+RXMgBCt
	sllcgqARvfQsEbZh+nlDHNBve7GW4F3I8WlwXhysfBNkitrF3mDyBEzhDbTEmLqM+0xNTkRjutZ
	G1XtCN8q9rVPrdX+23TnexmEJdYjObvpJ8DBHpFuq2kEmHz7m0je26f5wVH0=
X-Google-Smtp-Source: AGHT+IFr6MCBEVM5VTrKxUkpCz04m4ptd5n9tkKiyJv0xVc0BbC47glLukZw9tC9lqqcbW+7R7tp9ORVyiyHIn4IbQK+dVrf2oRS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1607:b0:3dd:f3e1:2899 with SMTP id
 e9e14a558f8ab-3e153916ed4mr2907965ab.2.1751905952369; Mon, 07 Jul 2025
 09:32:32 -0700 (PDT)
Date: Mon, 07 Jul 2025 09:32:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686bf6a0.a00a0220.b087d.01f2.GAE@google.com>
Subject: [syzbot] [kernel?] UBSAN: shift-out-of-bounds in aio_iiro_16_attach
From: syzbot <syzbot+f1bb7e4ea47ea12b535c@syzkaller.appspotmail.com>
To: abbotti@mev.co.uk, hsweeten@visionengravers.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a79a588fc176 Merge tag 'pm-6.16-rc5' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a4ac8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5ba6cef8f153bfeb
dashboard link: https://syzkaller.appspot.com/bug?extid=f1bb7e4ea47ea12b535c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a4ac8c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13fc9c8c580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-a79a588f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c7aa4e6d68b0/vmlinux-a79a588f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5d71f2c64f29/bzImage-a79a588f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f1bb7e4ea47ea12b535c@syzkaller.appspotmail.com

UBSAN: shift-out-of-bounds in drivers/comedi/drivers/aio_iiro_16.c:180:9
shift exponent 8550 is too large for 32-bit type 'int'
CPU: 2 UID: 0 PID: 6096 Comm: syz.0.16 Not tainted 6.16.0-rc4-syzkaller-00308-ga79a588fc176 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:233 [inline]
 __ubsan_handle_shift_out_of_bounds+0x27f/0x420 lib/ubsan.c:494
 aio_iiro_16_attach drivers/comedi/drivers/aio_iiro_16.c:180 [inline]
 aio_iiro_16_attach.cold+0x19/0x1e drivers/comedi/drivers/aio_iiro_16.c:164
 comedi_device_attach+0x3b3/0x900 drivers/comedi/drivers.c:996
 do_devconfig_ioctl+0x1a7/0x580 drivers/comedi/comedi_fops.c:855
 comedi_unlocked_ioctl+0x15bb/0x2e90 drivers/comedi/comedi_fops.c:2136
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3eb858e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc84ea1e58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f3eb87b5fa0 RCX: 00007f3eb858e929
RDX: 0000200000000140 RSI: 0000000040946400 RDI: 0000000000000003
RBP: 00007f3eb8610b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3eb87b5fa0 R14: 00007f3eb87b5fa0 R15: 0000000000000003
 </TASK>
---[ end trace ]---


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


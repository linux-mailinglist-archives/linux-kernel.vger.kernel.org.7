Return-Path: <linux-kernel+bounces-720215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FA4AFB8A9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F273ABA5C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1DE21E08D;
	Mon,  7 Jul 2025 16:31:31 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647732248B3
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 16:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751905891; cv=none; b=Gad/2PITZtz3wlWHCCkzg++46OhX8lkE0UyB1+A3X3J35tw8XTIZxk9KRRmAJqTs5MLzWjOtjmsoJyhW/YQ2qwGILfOlagUSGQKrFRSdOTpIVas6Yz5hGQj0EFagFaaYsNMKOanYA7BJRAit8Lo7QrPVbW3tn7JW2cuH+dfFszE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751905891; c=relaxed/simple;
	bh=nx0ix0kAeXrK8D/rGumN2eynSywKPmsN3hCddgP4Bao=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JrspIg4jpgfLwvLvmeG7OaxMoBBrAHO44QZ+ri157sY5WqGJPm/WmGhQzSyd4vnL5X0iMRJhyKJ1bAKWy3hBAj2I4NpxrcDUQt0C9XSvafI/YVVrfMeivmaRzyS5xTsAbY74KOtK3kL2VnbC4bBt2F0lFMZT+jQymoYE4KH1JtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-86d07944f29so718239839f.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 09:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751905888; x=1752510688;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zbO2dakWzESc0yUSXM130g1sseC4O+HT/s/+ETg3Pjc=;
        b=q65VjGh1rvTkGXo19xidsw9mqjpHacd0nyLjpisbxVIXLaofqJz8MAe2R8DA12jQd/
         TXuNfGt7qdg/BPG1oG3WFqSryO+dbb+rcJ/r3UwpNaWjfYVll4YYYKl8NxaD9433dW+i
         EwEEJo4XSujBMtq3iUinD8YSS+y9477IKLN3zYxP3VXoPTJpXms51oRWFEdurAQDS7gG
         YP38H1P3LFBMxyBSpNaJUGWQIdtDJIAJ/jATmj9MtoLtNBllVr9Q6Zb6oV2TKdbOB9LP
         0R3Pnv4JUqj1PxH7oAB5hhZPS1eRh9f8jwXy2lM/LAMVNU5UmF+fga+PX592TWWs8phW
         vUcw==
X-Forwarded-Encrypted: i=1; AJvYcCUealhFV5UvxFaa7L6TShdlwkpoOYwujst2SeWEk+0ru20v62UTztxOr7dRgWAmG/Wm43m1ElKRKufs4Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjv+BVr22T8IXZdpPvoiMEbjCFeJV/ZdrB5OEj9QwyONnKz4r2
	eNNxwB9MkYqAVjLI7vhSimXwujzJike0IRmtAxFOej7ju2BG+cODK+g7peWZ+2kYyQwCPh+HLA1
	FceMHyPypUuE4CHCA4sLaGJiKKS7PybSXHiSQ0Wx7M6Q/LW5pQpsjfbkr/+I=
X-Google-Smtp-Source: AGHT+IF2qbBL00Stxqo1BPAe5haPJrn+ESg3sAEA0VA+VZsA8KYykPqhG2qvGdIiKs+zGI/FIBwuvh4t7a13m78DdR5e/xC98y1I
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:388e:b0:864:4aa2:d796 with SMTP id
 ca18e2360f4ac-876e47b4e4emr1233191939f.8.1751905888368; Mon, 07 Jul 2025
 09:31:28 -0700 (PDT)
Date: Mon, 07 Jul 2025 09:31:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686bf660.a70a0220.29fe6c.0b10.GAE@google.com>
Subject: [syzbot] [kernel?] INFO: trying to register non-static key in waveform_detach
From: syzbot <syzbot+eec47f88bae8951c6afd@syzkaller.appspotmail.com>
To: abbotti@mev.co.uk, hsweeten@visionengravers.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4c06e63b9203 Merge tag 'for-6.16-rc4-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16528f70580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b29b1a0d7330d4a8
dashboard link: https://syzkaller.appspot.com/bug?extid=eec47f88bae8951c6afd
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a66c8c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11528f70580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-4c06e63b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ff61efc838cb/vmlinux-4c06e63b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dea44d0d14bb/bzImage-4c06e63b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+eec47f88bae8951c6afd@syzkaller.appspotmail.com

RBP: 00007ffc832acc70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fa16e5b5fa0 R14: 00007fa16e5b5fa0 R15: 0000000000000003
 </TASK>
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 UID: 0 PID: 5518 Comm: syz.0.16 Not tainted 6.16.0-rc4-syzkaller-00123-g4c06e63b9203 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 assign_lock_key+0x133/0x150 kernel/locking/lockdep.c:987
 register_lock_class+0x105/0x320 kernel/locking/lockdep.c:1302
 __lock_acquire+0x99/0xd20 kernel/locking/lockdep.c:5115
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
 __timer_delete_sync+0x11f/0x2d0 kernel/time/timer.c:1602
 waveform_detach+0x45/0x60 drivers/comedi/drivers/comedi_test.c:796
 comedi_device_detach+0x137/0x720 drivers/comedi/drivers.c:207
 comedi_device_attach+0x568/0x670 drivers/comedi/drivers.c:1000
 do_devconfig_ioctl drivers/comedi/comedi_fops.c:855 [inline]
 comedi_unlocked_ioctl+0x686/0xf40 drivers/comedi/comedi_fops.c:2136
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa16e38e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc832acc18 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fa16e5b5fa0 RCX: 00007fa16e38e929
RDX: 0000200000000140 RSI: 0000000040946400 RDI: 0000000000000003
RBP: 00007ffc832acc70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fa16e5b5fa0 R14: 00007fa16e5b5fa0 R15: 0000000000000003
 </TASK>
------------[ cut here ]------------
ODEBUG: assert_init not available (active state 0) object: ffff888059fb4800 object type: timer_list hint: 0x0
WARNING: CPU: 0 PID: 5518 at lib/debugobjects.c:615 debug_print_object+0x16b/0x1e0 lib/debugobjects.c:612
Modules linked in:
CPU: 0 UID: 0 PID: 5518 Comm: syz.0.16 Not tainted 6.16.0-rc4-syzkaller-00123-g4c06e63b9203 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:debug_print_object+0x16b/0x1e0 lib/debugobjects.c:612
Code: 4c 89 ff e8 27 c2 5b fd 4d 8b 0f 48 c7 c7 60 99 e2 8b 48 8b 34 24 4c 89 ea 89 e9 4d 89 f0 41 54 e8 ca e7 bb fc 48 83 c4 08 90 <0f> 0b 90 90 ff 05 c7 ef d9 0a 48 83 c4 08 5b 41 5c 41 5d 41 5e 41
RSP: 0018:ffffc90002d9f858 EFLAGS: 00010282
RAX: 475940cc4ed76c00 RBX: dffffc0000000000 RCX: ffff8880003f4880
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
RBP: 0000000000000000 R08: ffff88801fc24293 R09: 1ffff11003f84852
R10: dffffc0000000000 R11: ffffed1003f84853 R12: 0000000000000000
R13: ffffffff8be29b20 R14: ffff888059fb4800 R15: ffffffff8b8ce0a0
FS:  0000555582b99500(0000) GS:ffff88808d21c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1afde3743c CR3: 0000000059f57000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 debug_object_assert_init+0x2db/0x380 lib/debugobjects.c:1020
 debug_timer_assert_init kernel/time/timer.c:803 [inline]
 debug_assert_init kernel/time/timer.c:848 [inline]
 __try_to_del_timer_sync+0x29/0x3a0 kernel/time/timer.c:1457
 __timer_delete_sync+0x1fe/0x2d0 kernel/time/timer.c:1620
 waveform_detach+0x45/0x60 drivers/comedi/drivers/comedi_test.c:796
 comedi_device_detach+0x137/0x720 drivers/comedi/drivers.c:207
 comedi_device_attach+0x568/0x670 drivers/comedi/drivers.c:1000
 do_devconfig_ioctl drivers/comedi/comedi_fops.c:855 [inline]
 comedi_unlocked_ioctl+0x686/0xf40 drivers/comedi/comedi_fops.c:2136
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa16e38e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc832acc18 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fa16e5b5fa0 RCX: 00007fa16e38e929
RDX: 0000200000000140 RSI: 0000000040946400 RDI: 0000000000000003
RBP: 00007ffc832acc70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fa16e5b5fa0 R14: 00007fa16e5b5fa0 R15: 0000000000000003
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


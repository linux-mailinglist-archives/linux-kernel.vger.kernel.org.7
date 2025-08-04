Return-Path: <linux-kernel+bounces-754871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB6BB19DC6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8EBE7A1917
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E042417C2;
	Mon,  4 Aug 2025 08:38:30 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C900D1E412A
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 08:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754296710; cv=none; b=Ck0oCRmNKRn4lMM/ScPNzNKlmVshIH1JGC5RQ9RTOhCLRzFVt+JvBiF+k694uy7wN0acgaOZqkb8AAdYWKNzhfUtV1STE/jxNgIIr5PhxKZ4/IABl5+qGJ7yGrxqe9oPw5WfRp0xYJ1rUbh/lXBl3R9kz3gCtpnE5LWUvM3T0fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754296710; c=relaxed/simple;
	bh=B6D2Jw1a192dM7cWkBfIpMYBxQk3UyYgMDjSpBTOVhc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AZSskn24OkvBNpmMe0VojHl2Vq4a4Fdtuko2G1NJeUmkeo9rtf6hc+DG1fAeS6fPwdtd7SuekDOenCFqaWf/xF9WxVxA2PpOcFd1jzG7RB1uQTQ467ShlQT8v9ILNmNAvcaeuJWiLGt8aoM/gqwrcFzVWNEHGelbWui6TofowHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-88183648765so126530739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 01:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754296708; x=1754901508;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z/vPotG2b9l+KXw1WBVaiCqdoATqnmE0DFANnuH3Swo=;
        b=k+uNCH9IcsfY7F5og5T+WCaj5Kwsvdbb62Sbrkxi3HLgZMtyOBdWkGZI1eguZZAws3
         9wzsssY81EN27RnACIVsh6Xuu1aBjMgGkhs7M/Czdeb41UfD+gipTJl4LhB/YBzVD8qT
         4NqHPZ3mHOm7DAgVmL46LdSh0uVrXPXe004Jb9+04i6HJ06HQEDYe/bhF4rEH5Q3K1NY
         8exdIFoNaA+TqQ4w+rvm/a6vfiB2eqK6idHqZpWTfQQTTmmLpLf6ZTyr4o55EwRUlN4S
         4mBsvlLQH3ekHU3XGrJWf+A9qlAbCVRIr05rUkqFBhlAFRZdM434g7Lsc1kMj7Gc332Y
         IL6g==
X-Forwarded-Encrypted: i=1; AJvYcCU4eIVt0XyvSv4ehLf7uZAuCrU7gwuwybgMmdHVFNUbdc+ONft3G2XvOz68iQECT1fdW+MWp6iiK5Qjkhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIGC2vjXxfGvzHgNo7cx+31AllvyvqyHXJFu8h+iQ9UV9j5mok
	KC7WBnIukW0d1qulvWcsvsLUvAST4Z6SMnGYAzegaqYWyWWfIZQkVE6Do8giyUkPTXAsN6/sg+H
	c8Xs7v/EkcMp17JQRn4JPBk4DCtagJzJQaKqSUIu6xcpY6XI+rOPs0d8feUc=
X-Google-Smtp-Source: AGHT+IGUm+uhzIKU9z4ovg6nzr4nztSLk2f/Rcbc6TrXvn35RUC8GeBfHCkdEYcA7YKIXhja9q4AfknYD5HtsErDE+RPOFMIpOK9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14c7:b0:87c:3417:cc11 with SMTP id
 ca18e2360f4ac-881683361a5mr1386552039f.1.1754296707841; Mon, 04 Aug 2025
 01:38:27 -0700 (PDT)
Date: Mon, 04 Aug 2025 01:38:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68907183.050a0220.7f033.0006.GAE@google.com>
Subject: [syzbot] [kernfs?] BUG: unable to handle kernel paging request in kernfs_remove_by_name_ns
From: syzbot <syzbot+4faa3fd832279bd35a81@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5f33ebd2018c Merge tag 'drm-fixes-2025-07-26' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10908034580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=186272c644ef9aa3
dashboard link: https://syzkaller.appspot.com/bug?extid=4faa3fd832279bd35a81
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-5f33ebd2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/582eb02b72dc/vmlinux-5f33ebd2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ce6a4956089e/bzImage-5f33ebd2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4faa3fd832279bd35a81@syzkaller.appspotmail.com

comedi comedi3: c6xdigio: I/O port conflict (0xcf7,3)
BUG: unable to handle page fault for address: ffffffff9ee57158
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD e387067 P4D e387067 PUD e388063 PMD 0 
Oops: Oops: 0000 [#1] SMP KASAN NOPTI
CPU: 1 UID: 0 PID: 8309 Comm: syz.5.701 Not tainted 6.16.0-rc7-syzkaller-00120-g5f33ebd2018c #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:variable_test_bit arch/x86/include/asm/bitops.h:227 [inline]
RIP: 0010:arch_test_bit arch/x86/include/asm/bitops.h:239 [inline]
RIP: 0010:_test_bit include/asm-generic/bitops/instrumented-non-atomic.h:142 [inline]
RIP: 0010:__lock_acquire+0x46e/0x1c90 kernel/locking/lockdep.c:5210
Code: 78 5d 3f 03 0f b6 54 24 28 85 c0 74 10 44 8b 1d 48 0b 11 0f 45 85 db 0f 84 db 05 00 00 90 31 c9 e9 8a fe ff ff 48 63 44 24 10 <48> 0f a3 05 0a 5c 3e 14 0f 82 7b ff ff ff 90 e8 3e 5d 3f 03 85 c0
RSP: 0018:ffffc9000336f7a0 EFLAGS: 00010046
RAX: 00000000487561e4 RBX: 0000000000000003 RCX: 0000000000000008
RDX: 0000000000000000 RSI: ffff888029e02fa8 RDI: ffff888029e02440
RBP: ffff888029e02440 R08: ffffffff95d842a8 R09: 0000000000000001
R10: 0000000000000010 R11: 0000000000000005 R12: ffff888029e02f30
R13: ffff888029e02fa8 R14: 0000000000000003 R15: 0000000000000003
FS:  00007f603693a6c0(0000) GS:ffff8880d6820000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffff9ee57158 CR3: 000000006039a000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5871 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5828
 down_write+0x92/0x200 kernel/locking/rwsem.c:1577
 kernfs_remove_by_name_ns+0x3d/0x110 fs/kernfs/dir.c:1712
 sysfs_remove_file include/linux/sysfs.h:777 [inline]
 driver_remove_file drivers/base/driver.c:201 [inline]
 driver_remove_file+0x4a/0x60 drivers/base/driver.c:197
 remove_bind_files drivers/base/bus.c:605 [inline]
 bus_remove_driver+0x224/0x2c0 drivers/base/bus.c:743
 driver_unregister+0x76/0xb0 drivers/base/driver.c:277
 comedi_device_detach+0x13d/0x9e0 drivers/comedi/drivers.c:207
 comedi_device_attach+0x43d/0x900 drivers/comedi/drivers.c:1003
 do_devconfig_ioctl+0x1a7/0x580 drivers/comedi/comedi_fops.c:855
 comedi_unlocked_ioctl+0x165d/0x2f00 drivers/comedi/comedi_fops.c:2156
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6035b8e9a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f603693a038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f6035db5fa0 RCX: 00007f6035b8e9a9
RDX: 00002000000000c0 RSI: 0000000040946400 RDI: 0000000000000003
RBP: 00007f6035c10d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f6035db5fa0 R15: 00007ffe08e77888
 </TASK>
Modules linked in:
CR2: ffffffff9ee57158
---[ end trace 0000000000000000 ]---
RIP: 0010:variable_test_bit arch/x86/include/asm/bitops.h:227 [inline]
RIP: 0010:arch_test_bit arch/x86/include/asm/bitops.h:239 [inline]
RIP: 0010:_test_bit include/asm-generic/bitops/instrumented-non-atomic.h:142 [inline]
RIP: 0010:__lock_acquire+0x46e/0x1c90 kernel/locking/lockdep.c:5210
Code: 78 5d 3f 03 0f b6 54 24 28 85 c0 74 10 44 8b 1d 48 0b 11 0f 45 85 db 0f 84 db 05 00 00 90 31 c9 e9 8a fe ff ff 48 63 44 24 10 <48> 0f a3 05 0a 5c 3e 14 0f 82 7b ff ff ff 90 e8 3e 5d 3f 03 85 c0
RSP: 0018:ffffc9000336f7a0 EFLAGS: 00010046
RAX: 00000000487561e4 RBX: 0000000000000003 RCX: 0000000000000008
RDX: 0000000000000000 RSI: ffff888029e02fa8 RDI: ffff888029e02440
RBP: ffff888029e02440 R08: ffffffff95d842a8 R09: 0000000000000001
R10: 0000000000000010 R11: 0000000000000005 R12: ffff888029e02f30
R13: ffff888029e02fa8 R14: 0000000000000003 R15: 0000000000000003
FS:  00007f603693a6c0(0000) GS:ffff8880d6820000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffff9ee57158 CR3: 000000006039a000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess), 3 bytes skipped:
   0:	03 0f                	add    (%rdi),%ecx
   2:	b6 54                	mov    $0x54,%dh
   4:	24 28                	and    $0x28,%al
   6:	85 c0                	test   %eax,%eax
   8:	74 10                	je     0x1a
   a:	44 8b 1d 48 0b 11 0f 	mov    0xf110b48(%rip),%r11d        # 0xf110b59
  11:	45 85 db             	test   %r11d,%r11d
  14:	0f 84 db 05 00 00    	je     0x5f5
  1a:	90                   	nop
  1b:	31 c9                	xor    %ecx,%ecx
  1d:	e9 8a fe ff ff       	jmp    0xfffffeac
  22:	48 63 44 24 10       	movslq 0x10(%rsp),%rax
* 27:	48 0f a3 05 0a 5c 3e 	bt     %rax,0x143e5c0a(%rip)        # 0x143e5c39 <-- trapping instruction
  2e:	14
  2f:	0f 82 7b ff ff ff    	jb     0xffffffb0
  35:	90                   	nop
  36:	e8 3e 5d 3f 03       	call   0x33f5d79
  3b:	85 c0                	test   %eax,%eax


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


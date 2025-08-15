Return-Path: <linux-kernel+bounces-770902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3655B28031
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398D0AE5E57
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7463009C0;
	Fri, 15 Aug 2025 12:51:32 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC48C28724D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 12:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755262292; cv=none; b=UPjK/zL5x/YLZQCMfeISRJKRJzBOpiULlMCq7+Sw0YX+29qXfMNZqPW4/Fcga8hO9gExqrybdHf8hifMQtsSFNHngY0hlb214FC+XByZniAfWSRsnImAYbX45ayq1nh9mFPAOh6xtVj1Kzt+1zivmAYiYfd0vPug1+Wii32CYY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755262292; c=relaxed/simple;
	bh=i+aPcss7VmJoxOpuwmVgNxkJ/VMR9F7dWDLf7/Yu7hI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kt1lPEchgK5h3H8tF0+3FrTlG8gcuDYiknkVedBm2O0pJwPmWx0Nt8gjGo0GjIQdUGTzTQGHh3Tg40a3eWC5l5Mx9CsznZ6HgO34lscWRi49s3sBbXrDrkanu1i+S9+jNasD8xJH6z8jDwBq01+vyAZrPwaoa0O5KaZqw8/JDZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-88432cccc80so193466339f.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 05:51:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755262290; x=1755867090;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=enP3JEntlzGXIDabS54nyj311LpxKS5EFVJv1n3Cq7g=;
        b=KgQxunQ+/wKbAn8jNiFaTlcijJ5hqigY/UQMs4jucz3j6RUqFLhcrOhV8plE+XVYj5
         H25mIVb/iN12cYnhbecyQUGe5+8u1AtOZ96RS2p9wYKE23zMUapBLRCOxWLfGyiStTsE
         DytP50JBabrm0NZ8R21KQjgLT9nmNTk/j/F4k+PdAgow4uBG9GAeXP0hs5F1ug7RTO2T
         dHZWV5YuEPuOlPRUWC9xQuvEAoC8qw3zTKjqYUG0StdoTRp5oVb33s6hKKEsvy8k7vFV
         ten5vOPVlVNJB2odqmNHVnl+nbcip5EnfegRA4VU66zz6kELMLFCINtzF2dWzaANSwJo
         fA4w==
X-Forwarded-Encrypted: i=1; AJvYcCVij7bBry6anB/v5wD+iWajoBnlE4jemo5pIj8EUV5rx4lrp4NAxF/GqrrL6wxo56GG7z7KPhc8i6r0Aco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy46lVgXDd4QogXyZ1UR+/UkUFdmWnFVdcuteUdOV9YF1Jy4awf
	SjqaHtbtz/x1gzY1ud2LQMdH4cvaZrzw4Yr4QexdUV2es5P3qiUVI88pP2AUYcKTImYzauAS7SX
	q7xTZIMcYUw5VkxIUgsBGO96GtqYM5AfxvB2zL8o4MtYGz0TBEuC/cVWxREI=
X-Google-Smtp-Source: AGHT+IHqBSx4L/1FPdmSjhhRJsJ/AP4pMbB0NFfEOJvkHaOuCInbmYTKe5z/92Ht/AX71HVk6+1eX3B7X/es6u6N5LSjXPcQDyTc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:29cf:b0:884:456:c08f with SMTP id
 ca18e2360f4ac-8843e51a08fmr410497839f.13.1755262290097; Fri, 15 Aug 2025
 05:51:30 -0700 (PDT)
Date: Fri, 15 Aug 2025 05:51:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689f2d52.050a0220.e29e5.0015.GAE@google.com>
Subject: [syzbot] [gfs2?] WARNING in vfs_setxattr (3)
From: syzbot <syzbot+5ce48a14916462cec450@syzkaller.appspotmail.com>
To: brauner@kernel.org, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    24ea63ea3877 Merge tag 'acpi-6.17-rc2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13353da2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d67d3af29f50297e
dashboard link: https://syzkaller.appspot.com/bug?extid=5ce48a14916462cec450
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=100883a2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1329d842580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-24ea63ea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/307e082b78f2/vmlinux-24ea63ea.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a771414670e3/bzImage-24ea63ea.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6d33fef85cee/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=15353da2580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5ce48a14916462cec450@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): count = 0x0, magic = 0xffff8880422768f8, owner = 0x0, curr 0xffff88803304c880, list empty
WARNING: CPU: 0 PID: 5726 at kernel/locking/rwsem.c:1381 __up_write kernel/locking/rwsem.c:1380 [inline]
WARNING: CPU: 0 PID: 5726 at kernel/locking/rwsem.c:1381 up_write+0x3a2/0x420 kernel/locking/rwsem.c:1643
Modules linked in:
CPU: 0 UID: 0 PID: 5726 Comm: syz.0.47 Not tainted 6.17.0-rc1-syzkaller-00111-g24ea63ea3877 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__up_write kernel/locking/rwsem.c:1380 [inline]
RIP: 0010:up_write+0x3a2/0x420 kernel/locking/rwsem.c:1643
Code: d0 48 c7 c7 60 ec 8a 8b 48 c7 c6 80 ee 8a 8b 48 8b 14 24 4c 89 f1 4d 89 e0 4c 8b 4c 24 08 41 52 e8 d3 56 e6 ff 48 83 c4 08 90 <0f> 0b 90 90 e9 6d fd ff ff 48 c7 c1 74 cf a3 8f 80 e1 07 80 c1 03
RSP: 0018:ffffc9000d99fa50 EFLAGS: 00010296
RAX: 1cf7ff1b0c410100 RBX: ffff8880422768f8 RCX: ffff88803304c880
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: dffffc0000000000 R08: ffff88801fc24253 R09: 1ffff11003f8484a
R10: dffffc0000000000 R11: ffffed1003f8484b R12: 0000000000000000
R13: ffff888042276950 R14: ffff8880422768f8 R15: 1ffff1100844ed20
FS:  00007f3d8169c6c0(0000) GS:ffff88808d210000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3d8169bfc8 CR3: 0000000033237000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 inode_unlock include/linux/fs.h:879 [inline]
 vfs_setxattr+0x17a/0x2f0 fs/xattr.c:323
 do_setxattr fs/xattr.c:636 [inline]
 filename_setxattr+0x274/0x600 fs/xattr.c:665
 path_setxattrat+0x364/0x3a0 fs/xattr.c:713
 __do_sys_setxattr fs/xattr.c:747 [inline]
 __se_sys_setxattr fs/xattr.c:743 [inline]
 __x64_sys_setxattr+0xbc/0xe0 fs/xattr.c:743
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3d8078ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3d8169c038 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 00007f3d809b6090 RCX: 00007f3d8078ebe9
RDX: 0000200000000100 RSI: 0000200000000540 RDI: 00002000000003c0
RBP: 00007f3d80811e19 R08: 0000000000000001 R09: 0000000000000000
R10: 00000000000000a6 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3d809b6128 R14: 00007f3d809b6090 R15: 00007ffdbb0ae248
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


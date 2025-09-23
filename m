Return-Path: <linux-kernel+bounces-828659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97535B951CB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6041A1896059
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB93B3203BC;
	Tue, 23 Sep 2025 09:03:33 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828D931E887
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758618213; cv=none; b=LUvMqBQ/+Z5ePQ9aceIxxRMEiTUYRdIYz3i9KKhSqBzvW5QFuNV8k2xXnkN5jnIXlaUCMwHe7hoO1cvtaJI6zDLw6T+sZudam8+xSCNJleKOghstoLjQ9isBbhJrDwyTsQyWQyNH6918brO0dBIMjB4byxdWdPbyUiI4UwS5h6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758618213; c=relaxed/simple;
	bh=mg3r2npI7bw50hq57IGL+e3lX0kkSaoEgdvYztM1T+c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dkfFD02QzSYCBNsEm5SdOOXsRFVo5QShx2fs74dHpmuqPCu9rhl1vcavPy2tWPwZBAMPjAAqKjXTM4O2Ce+iqwbJeIzVR1UhPYhcr91aQ/n3NgzU9Xr0Dd4CpBOZiNQERRIkc5HarbajN71AwdPPw+L2hrLTonet1fGVRuWtRBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3f736aa339aso117441595ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758618209; x=1759223009;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qawIWc6HWAuv7hppdrKNRGMrCqrgNjhh6jQdGpOVwNo=;
        b=IlRBpydsUmA+FT4kOvtiR0Pcb9BQuQRenaDWOtvrlVPO4CHyuTsPChSFWIpzDxbZpF
         vO5QUl3MOJSFUhLjw5q0WGs+1Bx/QSZo90kueDTkUWGU6hRze+VLPuYUss938/S7L8cI
         lGzL553NDEtgm+DRsSbMpjp7MYUs9azFY2SCZs5M9obPRUfVKLZNBD7lI8silni7fM4f
         cnvz+45Kwk5SfFn3McldHvkz+XN15Ztq4hf1ZoCg6c/7qqZMsTJO5ZFRMQlbYrwcPtei
         QgXSrXfka3T93Lei7D1TU5rfl/lte/j8rpuacCNoLjgJDZowa3eMVk1bRAEPhrQGbdy4
         qPdw==
X-Forwarded-Encrypted: i=1; AJvYcCUkrNaxTwFDkSqJxb8rPb5fHe4RqXg6g//PSMwjlhRn8iDBeJ+Dn1eZs4Hw1nE5Cns9rUU41U7DgrjrJ5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhjNDJNnUhOQ9Sda5I/ZY3XBReWXX86K5gM9CtKfEJ2xLIMLXd
	P2AiPUeOCZPcMHxzy79l3b/XJzNKikr1vCrGxIrRCv312Te6vuKCB5UgNcaOYqcBqY4g46/O73z
	KOofjCqVf9HJ+kOLGf20E5pORuNiCr2iLN+dv1b4t9styC6AnwJqirqgJbkk=
X-Google-Smtp-Source: AGHT+IHJlQAz5UGV5R9SQO4x/bEQmDqd47KX/iH2j0vkgz8h1aDacoLJGydUzrLZxCA2KDvIrVwKxzCeP+1pywKQVSp7kcRis0tr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3f0f:b0:424:8d44:a261 with SMTP id
 e9e14a558f8ab-42581e2509cmr27390335ab.11.1758618209571; Tue, 23 Sep 2025
 02:03:29 -0700 (PDT)
Date: Tue, 23 Sep 2025 02:03:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d26261.a70a0220.4f78.0004.GAE@google.com>
Subject: [syzbot] [fs?] [mm?] WARNING: bad unlock balance in hugetlb_vmdelete_list
From: syzbot <syzbot+62edf7e27b2e8f754525@syzkaller.appspotmail.com>
To: david@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, muchun.song@linux.dev, 
	osalvador@suse.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    846bd2225ec3 Add linux-next specific files for 20250919
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13263534580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=135377594f35b576
dashboard link: https://syzkaller.appspot.com/bug?extid=62edf7e27b2e8f754525
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a118e2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e204e2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c53d48022f8a/disk-846bd222.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/483534e784c8/vmlinux-846bd222.xz
kernel image: https://storage.googleapis.com/syzbot-assets/721b36eec9b3/bzImage-846bd222.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+62edf7e27b2e8f754525@syzkaller.appspotmail.com

=====================================
WARNING: bad unlock balance detected!
syzkaller #0 Not tainted
-------------------------------------
syz.0.8060/30977 is trying to release lock (&vma_lock->rw_sema) at:
[<ffffffff82903959>] hugetlb_vmdelete_list+0x179/0x1c0 fs/hugetlbfs/inode.c:501
but there are no more locks to release!

other info that might help us debug this:
3 locks held by syz.0.8060/30977:
 #0: ffff88807d8da420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:508
 #1: ffff888034404648 (&sb->s_type->i_mutex_key#20){+.+.}-{4:4}, at: inode_lock_killable include/linux/fs.h:985 [inline]
 #1: ffff888034404648 (&sb->s_type->i_mutex_key#20){+.+.}-{4:4}, at: do_truncate+0x171/0x220 fs/open.c:63
 #2: ffff888034404918 (&hugetlbfs_i_mmap_rwsem_key){+.+.}-{4:4}, at: i_mmap_lock_write include/linux/fs.h:548 [inline]
 #2: ffff888034404918 (&hugetlbfs_i_mmap_rwsem_key){+.+.}-{4:4}, at: hugetlb_vmtruncate fs/hugetlbfs/inode.c:639 [inline]
 #2: ffff888034404918 (&hugetlbfs_i_mmap_rwsem_key){+.+.}-{4:4}, at: hugetlbfs_setattr+0x489/0x6d0 fs/hugetlbfs/inode.c:879

stack backtrace:
CPU: 1 UID: 0 PID: 30977 Comm: syz.0.8060 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_unlock_imbalance_bug+0xdc/0xf0 kernel/locking/lockdep.c:5298
 __lock_release kernel/locking/lockdep.c:5537 [inline]
 lock_release+0x269/0x3e0 kernel/locking/lockdep.c:5889
 up_write+0x2d/0x420 kernel/locking/rwsem.c:1642
 hugetlb_vmdelete_list+0x179/0x1c0 fs/hugetlbfs/inode.c:501
 hugetlb_vmtruncate fs/hugetlbfs/inode.c:641 [inline]
 hugetlbfs_setattr+0x4d1/0x6d0 fs/hugetlbfs/inode.c:879
 notify_change+0xc1a/0xf40 fs/attr.c:546
 do_truncate+0x1a4/0x220 fs/open.c:68
 handle_truncate fs/namei.c:3516 [inline]
 do_open fs/namei.c:3899 [inline]
 path_openat+0x306c/0x3830 fs/namei.c:4054
 do_filp_open+0x1fa/0x410 fs/namei.c:4081
 do_sys_openat2+0x121/0x1c0 fs/open.c:1435
 do_sys_open fs/open.c:1450 [inline]
 __do_sys_open fs/open.c:1458 [inline]
 __se_sys_open fs/open.c:1454 [inline]
 __x64_sys_open+0x11e/0x150 fs/open.c:1454
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdea5b8eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdea6945038 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007fdea5de5fa0 RCX: 00007fdea5b8eec9
RDX: 0000000000000100 RSI: 000000000014927e RDI: 0000200000000340
RBP: 00007fdea5c11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fdea5de6038 R14: 00007fdea5de5fa0 R15: 00007ffe42e704f8
 </TASK>
------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): count = 0x0, magic = 0xffff8880295a5408, owner = 0x1, curr 0xffff8880260d9e40, list empty
WARNING: kernel/locking/rwsem.c:1381 at __up_write kernel/locking/rwsem.c:1380 [inline], CPU#1: syz.0.8060/30977
WARNING: kernel/locking/rwsem.c:1381 at up_write+0x3a2/0x420 kernel/locking/rwsem.c:1643, CPU#1: syz.0.8060/30977
Modules linked in:
CPU: 1 UID: 0 PID: 30977 Comm: syz.0.8060 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:__up_write kernel/locking/rwsem.c:1380 [inline]
RIP: 0010:up_write+0x3a2/0x420 kernel/locking/rwsem.c:1643
Code: d0 48 c7 c7 00 f0 aa 8b 48 c7 c6 20 f2 aa 8b 48 8b 14 24 4c 89 f1 4d 89 e0 4c 8b 4c 24 08 41 52 e8 b3 39 e6 ff 48 83 c4 08 90 <0f> 0b 90 90 e9 6d fd ff ff 48 c7 c1 74 0b e5 8f 80 e1 07 80 c1 03
RSP: 0018:ffffc900051076c8 EFLAGS: 00010282
RAX: b37f99c54516e500 RBX: ffff8880295a5408 RCX: ffff8880260d9e40
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: dffffc0000000000 R08: ffffc900051073e7 R09: 1ffff92000a20e7c
R10: dffffc0000000000 R11: fffff52000a20e7d R12: 0000000000000001
R13: ffff8880295a5460 R14: ffff8880295a5408 R15: 1ffff110052b4a82
FS:  00007fdea69456c0(0000) GS:ffff8881258a2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdea51fed58 CR3: 00000000779ba000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 hugetlb_vmdelete_list+0x179/0x1c0 fs/hugetlbfs/inode.c:501
 hugetlb_vmtruncate fs/hugetlbfs/inode.c:641 [inline]
 hugetlbfs_setattr+0x4d1/0x6d0 fs/hugetlbfs/inode.c:879
 notify_change+0xc1a/0xf40 fs/attr.c:546
 do_truncate+0x1a4/0x220 fs/open.c:68
 handle_truncate fs/namei.c:3516 [inline]
 do_open fs/namei.c:3899 [inline]
 path_openat+0x306c/0x3830 fs/namei.c:4054
 do_filp_open+0x1fa/0x410 fs/namei.c:4081
 do_sys_openat2+0x121/0x1c0 fs/open.c:1435
 do_sys_open fs/open.c:1450 [inline]
 __do_sys_open fs/open.c:1458 [inline]
 __se_sys_open fs/open.c:1454 [inline]
 __x64_sys_open+0x11e/0x150 fs/open.c:1454
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdea5b8eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdea6945038 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007fdea5de5fa0 RCX: 00007fdea5b8eec9
RDX: 0000000000000100 RSI: 000000000014927e RDI: 0000200000000340
RBP: 00007fdea5c11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fdea5de6038 R14: 00007fdea5de5fa0 R15: 00007ffe42e704f8
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


Return-Path: <linux-kernel+bounces-815379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD71B5638A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 00:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0C51B23FB7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 22:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692072BD590;
	Sat, 13 Sep 2025 22:07:33 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3C92BD031
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 22:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757801252; cv=none; b=Z/aAaGx3cgtXeZTUC87ArbCl5ntnn4YSzGy6mYAQ3+q5ZkfzFWekNnMIqtxX7tcyPbhb0CcU2GHO90Uj9+/HMeLmqdrxNJmohaj1CU13r+fiXhwxk4O51rX3lwuN4DaRSRiWYVfmA9ZKkjhYlY9JJNHu7Ze+gxjIfZ+ygqfToBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757801252; c=relaxed/simple;
	bh=XBm+QAU6E5Vf+StkFQKgNrO37zdQvvasSkw7BGvkEtg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VdioO1X2VtQL9acg0s/HVghHc9KuDxTCocEgXPgE7JIq6ccY3TrxeYeuQteUdc/LmRo9r8LRnsNpQ5cfT12sZabqgchOFYqsojc4o/i4M22oS31M6HsaG95J5rYGldVMgYLU6+RnIZqwHYwPr5Aje3wpNKuUMJjAQJrpu5T4nCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-88dc85f09ddso287998239f.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 15:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757801250; x=1758406050;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yF9uYGBZLVHQGSSLMby7UhnsVpgtGJ/H/vT0dHayKxQ=;
        b=DcVInPn70+74ReAeJrx5+5O7D+EHqKe68XTQuKYXe/Tj0lfjvvDSVndQTF9y8rN4OB
         RCwo3jVcnA5MMkwOnqLLgeKv3inAPPnonL55vd6fBdLh4RQLngffOh3gOozZHtmdaN9B
         tc+G7WUF7FXRgvzKWCFaFR6pA6JeUL9VrJCcmmZXNaK8eN8jI/bPC2QVyq/1RDdnBVQA
         JPi2vMDwBwG0g/cJHqwmNhjGnJAtXHR8DgrgKxj/cpNEHcJs6sOhI8V00xuGolMwczxh
         FVDQnESWSk2KGZOvxRQDFJ7UzpcqG9YJwPMJ09o/HhLK4dyCQJmR2z5z/kasUBaO7eo4
         +H0w==
X-Forwarded-Encrypted: i=1; AJvYcCWAFI37f8O8gLywRjra3VES6/JpF0c49ne5kc3+Jdir7FepEkjOxgBfGaY4zwaKKyCLJIY6dXMlhK6GeFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSM8FmFm712i0F17w58rc5u0IKh1HzEUexYos0/owSf4nrkWmp
	o1Z5UQrwLGu8o4PpF+VkSsA5Ev7MgsP7o7GpWJ2TD8bM5G/Q3CEwSYUGBM+pg2YRmlnqDd7ZemD
	ctw6j0IrWXHnguEp6cIW+9V4Jb58NcNG3GYr1upWFrLKhH3Gjz2x+LKxrNwc=
X-Google-Smtp-Source: AGHT+IFnm6nh6bjqMk2d7vnQw3hzTEXNAn6xP1CEVuQEmATzX71D9Tms4HjFI3rnXlMKmamivzQQCGMWXlKNZob7t/V2FLLOUJ9H
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154e:b0:419:de32:2cf7 with SMTP id
 e9e14a558f8ab-4209d40feabmr99535375ab.3.1757801250372; Sat, 13 Sep 2025
 15:07:30 -0700 (PDT)
Date: Sat, 13 Sep 2025 15:07:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c5eb22.050a0220.2ff435.037c.GAE@google.com>
Subject: [syzbot] [gfs2?] BUG: sleeping function called from invalid context
 in gfs2_withdraw (2)
From: syzbot <syzbot+2c1d8759af67dedac957@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9dd1835ecda5 Merge tag 'dma-mapping-6.17-2025-09-09' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=158dcb12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7f605fd273c8220
dashboard link: https://syzkaller.appspot.com/bug?extid=2c1d8759af67dedac957
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-9dd1835e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4657190ff75d/vmlinux-9dd1835e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2c21590a37de/bzImage-9dd1835e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2c1d8759af67dedac957@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
gfs2: fsid=syz:syz: Trying to join cluster "lock_nolock", "syz:syz"
gfs2: fsid=syz:syz: Now mounting FS (format 1801)...
gfs2: fsid=syz:syz.0: journal 0 mapped with 1 extents in 0ms
gfs2: fsid=syz:syz.0: first mount done, others may mount
loop0: detected capacity change from 32768 to 4160
gfs2: fsid=syz:syz.0: fatal: I/O error - block = 9377, function = gfs2_pin, file = fs/gfs2/lops.c, line = 52
gfs2: fsid=syz:syz.0: about to withdraw this file system
BUG: sleeping function called from invalid context at fs/gfs2/util.c:159
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5357, name: syz.0.0
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
6 locks held by syz.0.0/5357:
 #0: ffff888032e42428 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:557
 #1: ffff8880446147f8 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:915 [inline]
 #1: ffff8880446147f8 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: filename_create+0x1f8/0x3c0 fs/namei.c:4139
 #2: ffff888032e42618 (sb_internal#2){.+.+}-{0:0}, at: gfs2_trans_begin+0x6f/0xe0 fs/gfs2/trans.c:118
 #3: ffff888011a4cdb8 (&sdp->sd_log_flush_lock){++++}-{4:4}, at: __gfs2_trans_begin+0x515/0x890 fs/gfs2/trans.c:87
 #4: ffff888011a4cbe0 (&sdp->sd_log_lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #4: ffff888011a4cbe0 (&sdp->sd_log_lock){+.+.}-{3:3}, at: gfs2_log_lock fs/gfs2/log.h:32 [inline]
 #4: ffff888011a4cbe0 (&sdp->sd_log_lock){+.+.}-{3:3}, at: gfs2_trans_add_meta+0x156/0xa10 fs/gfs2/trans.c:265
 #5: ffff888011a4cfa0 (&sdp->sd_freeze_mutex){+.+.}-{4:4}, at: signal_our_withdraw fs/gfs2/util.c:152 [inline]
 #5: ffff888011a4cfa0 (&sdp->sd_freeze_mutex){+.+.}-{4:4}, at: gfs2_withdraw+0x444/0x1430 fs/gfs2/util.c:333
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 UID: 0 PID: 5357 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 __might_resched+0x495/0x610 kernel/sched/core.c:8957
 signal_our_withdraw fs/gfs2/util.c:157 [inline]
 gfs2_withdraw+0x492/0x1430 fs/gfs2/util.c:333
 gfs2_pin+0x129/0x380 fs/gfs2/lops.c:52
 gfs2_trans_add_meta+0x693/0xa10 fs/gfs2/trans.c:302
 do_init_dirent+0xd0/0x370 fs/gfs2/dir.c:721
 gfs2_init_dirent fs/gfs2/dir.c:742 [inline]
 gfs2_dir_add+0x1cce/0x2270 fs/gfs2/dir.c:1814
 link_dinode+0x32e/0x500 fs/gfs2/inode.c:640
 gfs2_create_inode+0x126e/0x1560 fs/gfs2/inode.c:875
 gfs2_mknod+0x33/0x50 fs/gfs2/inode.c:1353
 vfs_mknod+0x37c/0x3c0 fs/namei.c:4235
 do_mknodat+0x385/0x4d0 fs/namei.c:-1
 __do_sys_mknodat fs/namei.c:4313 [inline]
 __se_sys_mknodat fs/namei.c:4310 [inline]
 __x64_sys_mknodat+0xa7/0xc0 fs/namei.c:4310
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f23fc78eba9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f23fd5da038 EFLAGS: 00000246 ORIG_RAX: 0000000000000103
RAX: ffffffffffffffda RBX: 00007f23fc9d5fa0 RCX: 00007f23fc78eba9
RDX: 0000000000001000 RSI: 0000200000000040 RDI: ffffffffffffff9c
RBP: 00007f23fc811e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000103 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f23fc9d6038 R14: 00007f23fc9d5fa0 R15: 00007ffc28f5c228
 </TASK>
BUG: scheduling while atomic: syz.0.0/5357/0x00000002
6 locks held by syz.0.0/5357:
 #0: ffff888032e42428 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:557
 #1: ffff8880446147f8 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:915 [inline]
 #1: ffff8880446147f8 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: filename_create+0x1f8/0x3c0 fs/namei.c:4139
 #2: ffff888032e42618 (sb_internal#2){.+.+}-{0:0}, at: gfs2_trans_begin+0x6f/0xe0 fs/gfs2/trans.c:118
 #3: ffff888011a4cdb8 (&sdp->sd_log_flush_lock){++++}-{4:4}, at: __gfs2_trans_begin+0x515/0x890 fs/gfs2/trans.c:87
 #4: ffff888011a4cbe0 (&sdp->sd_log_lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #4: ffff888011a4cbe0 (&sdp->sd_log_lock){+.+.}-{3:3}, at: gfs2_log_lock fs/gfs2/log.h:32 [inline]
 #4: ffff888011a4cbe0 (&sdp->sd_log_lock){+.+.}-{3:3}, at: gfs2_trans_add_meta+0x156/0xa10 fs/gfs2/trans.c:265
 #5: ffff888011a4cfa0 (&sdp->sd_freeze_mutex){+.+.}-{4:4}, at: signal_our_withdraw fs/gfs2/util.c:152 [inline]
 #5: ffff888011a4cfa0 (&sdp->sd_freeze_mutex){+.+.}-{4:4}, at: gfs2_withdraw+0x444/0x1430 fs/gfs2/util.c:333
Modules linked in:
Preemption disabled at:
[<0000000000000000>] 0x0


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


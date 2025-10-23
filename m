Return-Path: <linux-kernel+bounces-867797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A8FC03840
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 23:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 660E03B3710
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 21:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2492741DA;
	Thu, 23 Oct 2025 21:21:37 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A994239E97
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761254496; cv=none; b=VLPctZpkVHHYA27xfE/X7hD/5sgqY6Bk2PKqh9LivpDWsObcg+5FYgMJGIJRxXCUS9LBEgr8p6v4H+IIYxOJazl8u/fSP4GSrVxNgq867Hm63ZR4Eo2ioOTB/B4RZx1zVW2tJLckiE9nzpzY6E4etto5NXsyAdY8CpAH3QlmmXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761254496; c=relaxed/simple;
	bh=iVRTsi4B1jh3cOcWEoBqF5+JzXBosIRa9YmukIftfRM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DKrmTjt6H3hZkfL+qYUfmtNUHH338UdL79vNlx3JQ0Y8AB/MN375v+3hsTSQqyuTZnKR84WdlUh3iqTQdr2hXun4dy6gL6IZqwcJOFYCUbmU7BC28OIXNkmZnZaYbHtcfjOtDaH6TepcQWTdM+A1LvSpOeTmFUqjR3X/af+BkdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-430c8321bc1so18915815ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761254494; x=1761859294;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AOksONKvXlOJL0U+M1alTbSSRb56wH0mYv1Iv86tjks=;
        b=AoEvW+XD49Q/JpRCJQ4mXY/B0lkGE04Zha2FzgbYSLQKSBliDlhUwgi/EsNWVBH5LB
         EMNM5Oxqy87Muuo7rHhbpca8ZWAe9Z9qGyVEOGGIeW6BugEsN3WjRH3stilU5IcIKWtH
         lfwOHLkjoupYrHHCPBp5Kda1OcsraIK2AtRjuE3X2MAd5m2etSrcHO625X5mSMQUqm0j
         dGkwV43KchKIuyCu2CU7u0jEPG98JSNh9nq+sSvAcn9uHzbEAnhFpK3x5qysBaKZivf1
         dykVKI9/jyevzpooYuehom1sJ/3PE92kt4hrzlNLGtMaN7nzbRTRlzsZYtf+Z901a/KF
         c8Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWpG2fcRf9LA1x3fCBswrfWlVgX0bZEFVJBdIqQF+GuRsyTCTM65l2GOXS6zwhg9LiIN3DPrWTigSJOBdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK5xKpV0JocbU9OOuO5Dl6nuSNK3U3unsasq69rDiByYxj7sRB
	wssWOcH7nDldYxl8TryGr/WhxgbeoM1U9JIUu+ZC2fA9NLGhZxcdy/3DCVsHqoxECqC7QleEiI2
	4tWH7rWurlg8M31ULXv129RSwXEDIjx65KMJVhPXRxc+I7So4vNylgPTvrLo=
X-Google-Smtp-Source: AGHT+IGq1ziE4QfwS05WZeuA/5dvup9r6hn+2TI+K69/pAA9DbdRAJPUknKxKhaDL/jrXKeGM0ECOcEPMJODOWAYk0pG62ASvf/e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:380f:b0:42e:72ee:cde6 with SMTP id
 e9e14a558f8ab-430c525f609mr412692255ab.12.1761254494372; Thu, 23 Oct 2025
 14:21:34 -0700 (PDT)
Date: Thu, 23 Oct 2025 14:21:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fa9c5e.a70a0220.3bf6c6.00ca.GAE@google.com>
Subject: [syzbot] [jfs?] INFO: task hung in dbAlloc
From: syzbot <syzbot+a2bef7ebecf9cb8b880a@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    aaa9c3550b60 Add linux-next specific files for 20251022
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16dd13e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8b911aebadf6410
dashboard link: https://syzkaller.appspot.com/bug?extid=a2bef7ebecf9cb8b880a
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120ecd2f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13506d42580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/44f7af9b7ca1/disk-aaa9c355.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9d09b0a9994d/vmlinux-aaa9c355.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ae729ccb2c5c/bzImage-aaa9c355.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7922e49d0401/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=16cba3cd980000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a2bef7ebecf9cb8b880a@syzkaller.appspotmail.com

INFO: task syz.2.19:6102 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.19        state:D
 stack:24744 pid:6102  tgid:6101  ppid:5966   task_flags:0x400140 flags:0x00080003
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5254 [inline]
 __schedule+0x17c4/0x4d60 kernel/sched/core.c:6862
 __down_read_common kernel/locking/rwsem.c:1261 [inline]
 __down_read kernel/locking/rwsem.c:1274 [inline]
 down_read_nested+0x9a/0x2f0 kernel/locking/rwsem.c:1663
 dbAlloc+0x3a7/0xba0 fs/jfs/jfs_dmap.c:790
 diNewExt+0x9af/0x3150 fs/jfs/jfs_imap.c:2261
 diAllocExt fs/jfs/jfs_imap.c:1952 [inline]
 diAllocAG+0xe86/0x1df0 fs/jfs/jfs_imap.c:1669
 diAlloc+0x1d5/0x1680 fs/jfs/jfs_imap.c:1590
 ialloc+0x8c/0x8f0 fs/jfs/jfs_inode.c:56
 jfs_mkdir+0x193/0xa70 fs/jfs/namei.c:225
 vfs_mkdir+0x306/0x510 fs/namei.c:4453
 do_mkdirat+0x247/0x590 fs/namei.c:4486
 __do_sys_mkdirat fs/namei.c:4503 [inline]
 __se_sys_mkdirat fs/namei.c:4501 [inline]
 __x64_sys_mkdirat+0x87/0xa0 fs/namei.c:4501
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8089b8efc9
RSP: 002b:00007f808aa1e038 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007f8089de5fa0 RCX: 00007f8089b8efc9
RDX: 0000000000000408 RSI: 0000200000000300 RDI: 0000000000000004
RBP: 00007f8089c11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f8089de6038 R14: 00007f8089de5fa0 R15: 00007ffd7baf80e8
 </TASK>
INFO: task syz.0.17:6104 blocked for more than 149 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.17        state:D stack:24584 pid:6104  tgid:6103  ppid:5962   task_flags:0x400140 flags:0x00080003
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5254 [inline]
 __schedule+0x17c4/0x4d60 kernel/sched/core.c:6862
 __schedule_loop kernel/sched/core.c:6944 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6959
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7016
 rwsem_down_read_slowpath+0x5fd/0x8f0 kernel/locking/rwsem.c:1086
 __down_read_common kernel/locking/rwsem.c:1261 [inline]
 __down_read kernel/locking/rwsem.c:1274 [inline]
 down_read_nested+0x9a/0x2f0 kernel/locking/rwsem.c:1663
 dbAlloc+0x3a7/0xba0 fs/jfs/jfs_dmap.c:790
 diNewExt+0x9af/0x3150 fs/jfs/jfs_imap.c:2261
 diAllocExt fs/jfs/jfs_imap.c:1952 [inline]
 diAllocAG+0xe86/0x1df0 fs/jfs/jfs_imap.c:1669
 diAlloc+0x1d5/0x1680 fs/jfs/jfs_imap.c:1590
 ialloc+0x8c/0x8f0 fs/jfs/jfs_inode.c:56
 jfs_mkdir+0x193/0xa70 fs/jfs/namei.c:225
 vfs_mkdir+0x306/0x510 fs/namei.c:4453
 do_mkdirat+0x247/0x590 fs/namei.c:4486
 __do_sys_mkdirat fs/namei.c:4503 [inline]
 __se_sys_mkdirat fs/namei.c:4501 [inline]
 __x64_sys_mkdirat+0x87/0xa0 fs/namei.c:4501
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f54be18efc9
RSP: 002b:00007f54bf04c038 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007f54be3e5fa0 RCX: 00007f54be18efc9
RDX: 0000000000000408 RSI: 0000200000000300 RDI: 0000000000000004
RBP: 00007f54be211f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f54be3e6038 R14: 00007f54be3e5fa0 R15: 00007ffc81bd5328
 </TASK>
INFO: task syz.3.20:6107 blocked for more than 150 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.20        state:D stack:25064 pid:6107  tgid:6106  ppid:5970   task_flags:0x400140 flags:0x00080003
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5254 [inline]
 __schedule+0x17c4/0x4d60 kernel/sched/core.c:6862
 __schedule_loop kernel/sched/core.c:6944 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6959
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7016
 rwsem_down_read_slowpath+0x5fd/0x8f0 kernel/locking/rwsem.c:1086
 __down_read_common kernel/locking/rwsem.c:1261 [inline]
 __down_read kernel/locking/rwsem.c:1274 [inline]
 down_read_nested+0x9a/0x2f0 kernel/locking/rwsem.c:1663
 dbAlloc+0x3a7/0xba0 fs/jfs/jfs_dmap.c:790
 diNewExt+0x9af/0x3150 fs/jfs/jfs_imap.c:2261
 diAllocExt fs/jfs/jfs_imap.c:1952 [inline]
 diAllocAG+0xe86/0x1df0 fs/jfs/jfs_imap.c:1669


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


Return-Path: <linux-kernel+bounces-869599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8431AC0846E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 01:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB0F4010AE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB93A30DEB8;
	Fri, 24 Oct 2025 23:11:31 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C818735B14E
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 23:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761347491; cv=none; b=NHr5WKIPFQtETkAGX4OsydMa+6pmZYRSqRBFLl7zUh9/ju1sAFqV4+A+56i+1/JQnM5J2j/KCYLGsd2uwZ1PrMJpwpCzucQg/DZELsGQ70Bxq6E0ZKAjljQDyiUCwl6i0BjHJ6tu6aFM8KfDNWvTgLkNPMquIp3gEXIquw3MFYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761347491; c=relaxed/simple;
	bh=F6bX8jTi3iBZGgd0s36ESJ6b0192LfXp0ic+oc1EIcw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mKw0RFVQe3Xh1tRp8KsB0HlDzdLcMs43MDLOF0EqvsutR5t2sDGHT91x9TFYEoX1/M8/DCxNU4xH5QscYjeNb7R4P3hDVKAqvgJB3pPNpGOaLLMvMA6UI9OCOhaEls5309vYfbphj6SPN686E1LXyNsKbSQ8TnKLu6HwVMLOz7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-430db6d36c6so86338565ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 16:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761347489; x=1761952289;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XqBBgxVBsFH4u7N5X46wOvLNJ7mwegv88sf3EJg/LxA=;
        b=dmXujMG1E+XUUDWeTc39ERlmyKGUDxIF+ggCfp9plzFM6Uo2c5EJaSqnoYzPrX06QT
         4lAjUjQ3MAoQNpyrN5HIwOhL//oPQGwO9/TBeaT/gM0JlUx6ngbJh1b/HXATTS8b57Lj
         3eScO/0c4zLq8t45pi35RvotFGT3TTMWiK7KB8j2/nm/Hd6fMNK7hC98qxLUwSWa2ESd
         38FnSwuSnJ8AhaHxIDSICn4BomwVhpoEdsyCIN8ZPJeCfHK2EN/XM0epxHLBgh8MaEEa
         iabbaKkxppdyWY4ZalwxK8fPryxP+c9+vfFQQQq03VDnUWwOrYi/+sfbSA2rLbw+DvEV
         8a5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHax/fC62ud6s7KISFwkV3IwveFnLsXL2M6LpbVUdYChblK2JsxIoA/+XX8l/opmYTcJrI1lvbsRSuno8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXlDREb/ermHaIUKpGajAzAbcTpeXe4eo3Pg+M+yPC9pAmY3/O
	uWpG6Q8dtR/yjT4TrEC9RvkCExp7TONqkHYDj7gSd/gRdaL5Ap5kbHr+yJ11mIrlBWPTDrjC83W
	5THL8d85RunJq7X9pBad4qT+QqzpMOOLvnQnUMTCSEdRqvJD8s6Wh7UxBlX8=
X-Google-Smtp-Source: AGHT+IFjKUKwUjlZowPyjQpjxNFd2FO6cEPJm8HOaTb4Xb7i8to9enS9HgElHQN2d6snsaXybh1+b2QLlqHwYfo6sY/7dS+IEuCO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2b:b0:42f:95af:9594 with SMTP id
 e9e14a558f8ab-430c527e5bbmr429245885ab.23.1761347488944; Fri, 24 Oct 2025
 16:11:28 -0700 (PDT)
Date: Fri, 24 Oct 2025 16:11:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fc07a0.a70a0220.3bf6c6.01ac.GAE@google.com>
Subject: [syzbot] [jfs?] INFO: task hung in diNewExt
From: syzbot <syzbot+b367cace420c21becba6@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    aaa9c3550b60 Add linux-next specific files for 20251022
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17ebcd2f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8b911aebadf6410
dashboard link: https://syzkaller.appspot.com/bug?extid=b367cace420c21becba6
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161adb04580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123c9be2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/44f7af9b7ca1/disk-aaa9c355.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9d09b0a9994d/vmlinux-aaa9c355.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ae729ccb2c5c/bzImage-aaa9c355.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/41800c75cd89/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=156e6d42580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b367cace420c21becba6@syzkaller.appspotmail.com

INFO: task syz.2.19:6098 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.19        state:D stack:24120 pid:6098  tgid:6097  ppid:5976   task_flags:0x400140 flags:0x00080003
Call Trace:
 context_switch kernel/sched/core.c:5254 [inline]
 __schedule+0x17c4/0x4d60 kernel/sched/core.c:6862
 __schedule_loop kernel/sched/core.c:6944 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6959
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7016
 rwsem_down_read_slowpath+0x5fd/0x8f0 kernel/locking/rwsem.c:1086
 __down_read_common kernel/locking/rwsem.c:1261 [inline]
 __down_read kernel/locking/rwsem.c:1274 [inline]
 down_read_nested+0x9a/0x2f0 kernel/locking/rwsem.c:1663
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
RIP: 0033:0x7fa19698efc9
RSP: 002b:00007fa197895038 EFLAGS: 00000246
RBP: 00007fa196a11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
INFO: task syz.0.17:6103 blocked for more than 148 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.17        state:D
 stack:25592 pid:6103  tgid:6102  ppid:5971   task_flags:0x400140 flags:0x00080003
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


Return-Path: <linux-kernel+bounces-761245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6674BB1F60A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 21:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 592187B0B58
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 19:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AFA277CAD;
	Sat,  9 Aug 2025 19:41:33 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B07204C0C
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 19:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754768493; cv=none; b=MgY9o546gdCHziGhag5wN5Z3r6OTlSkrElfp6PGID1pDON2Hq5486blbhnSIUAKYt3I1xnfdTxi28w/taBYohHo1+u4R2s6NoOjvhbIPQqWgEUs/drPdxdXyFm6I9MA6BRnVuqrXDashI0GkECSsZTOLQxlQ6pIFQfbGlSU6+tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754768493; c=relaxed/simple;
	bh=gs+umVz5DXUYgs8sKiV2YUaNc8vqfgJM2yK2MPlxLcE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tcNHCWzcOY9a4sUfdgQjcZupnaDuf/bYtBnlQyTsRyhQyoekk2yqgzxWdWgGBej2Jy+6NnikB7pg2IvPbuuVJxeO5Gd0dzvxYJLnZgxeau31oR3HHU3JS/bmCkvziWsABuKREXSWiAV7oabtFFTEjoN1ROE00nxHtnj2GNCDQyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-881814e7585so754203639f.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 12:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754768490; x=1755373290;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OgnsKqgdg8KHbIaPtAEJLaW7GNhj8FQY7KHELqVFdsI=;
        b=hRNXwJ/SpIp1zDXZPRkNhfZrmA6W37RchIe3MkQmshOeVNofpV9P3Q7h5AjdgxN9v5
         hwy0/MML9xSBWkRvL8oO9DSEn6+VkE9TRjaxicJZqxu+cxr+mDvmUQtSk9vup60oMcB8
         sWgxuE03feIBAJriDy/BOkIfm6eWZ+xJ56xlpBTML2pbbDrhFx+Rq5hwsSqjcIUGGx4o
         mukQaeTEn7zJt5ao5Ie6kvLRio5W21finw0woNM2rLGitLxu/QpFtUXppgDXCvBR0g0U
         kL90dxru2Qugh2MCM3fiQ2mWa64IBItm5eOna+4ie+R8szzHwctRLF0Eo6tOS393/1nJ
         r2IQ==
X-Forwarded-Encrypted: i=1; AJvYcCULcpnhwpylekoIxFv4J6xgxqZ5CbNZSteuWkH0w8ckH41CrkfIkonUL2rC8ESPpyICJZeb2re/uM2/iaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyptcnlSpDwZ7iwdrlq4TujR5K+IrNlgwzKvo7hkONJi0FokrB1
	/xkhha3crABA8R6wxM5B24H015QVQu+99rIJNNavyoHGIYY0RKG5fbls/dX9GpqjC9tFRAq0bDL
	iL/IbzMXTGbVjnxB2OkvJRWcvFHaIj5rAg9aQ7oMtx2XrFjKZB3cQ03GDtCA=
X-Google-Smtp-Source: AGHT+IGYAND1nnrKT2Hlnq+qc/fRL4Lk3Fut1R2I6pNf4Vz4soPo/XBzSpJjAis8RUlFf310jbz0Z5Rrq5mLWjq9AhZ1pn85Zb/f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3425:b0:876:b8a0:6a16 with SMTP id
 ca18e2360f4ac-883f126997cmr1420574839f.13.1754768490664; Sat, 09 Aug 2025
 12:41:30 -0700 (PDT)
Date: Sat, 09 Aug 2025 12:41:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6897a46a.050a0220.51d73.0080.GAE@google.com>
Subject: [syzbot] [ocfs2?] INFO: trying to register non-static key in ocfs2_trim_fs
From: syzbot <syzbot+7bb33d470124d76b4709@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7e161a991ea7 Merge tag 'i2c-for-6.17-rc1-part2' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10ad86a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=943d6f7b1ddd8799
dashboard link: https://syzkaller.appspot.com/bug?extid=7bb33d470124d76b4709
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/63fcd4da7120/disk-7e161a99.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7e74f50fce60/vmlinux-7e161a99.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3fd0451f9d02/bzImage-7e161a99.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7bb33d470124d76b4709@syzkaller.appspotmail.com

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 UID: 0 PID: 9474 Comm: syz.6.500 Tainted: G        W           6.16.0-syzkaller-11699-g7e161a991ea7 #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 assign_lock_key+0x133/0x150 kernel/locking/lockdep.c:984
 register_lock_class+0x105/0x320 kernel/locking/lockdep.c:1299
 __lock_acquire+0x99/0xd20 kernel/locking/lockdep.c:5112
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 __mutex_lock_common kernel/locking/rtmutex_api.c:535 [inline]
 mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:547
 ocfs2_trim_fs_lock_res_init+0x25/0xa0 fs/ocfs2/dlmglue.c:703
 ocfs2_trim_fs+0x129/0x2380 fs/ocfs2/alloc.c:7682
 ocfs2_ioctl+0x697/0x750 fs/ocfs2/ioctl.c:936
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1858e9eb69
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1856cdd038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffff[  634.504324][ T9474] RAX: ffffffffffffffda RBX: 00007f18590c6080 RCX: 00007f1858e9eb69
RDX: 0000200000000080 RSI: 00000000c0185879 RDI: 0000000000000006
RBP: 00007f1858f21df1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f18590c6080 R15: 00007ffeb2455fe8
 </TASK>
(syz.6.500,9474,0):ocfs2_trim_fs:7689 ERROR: status = -30


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


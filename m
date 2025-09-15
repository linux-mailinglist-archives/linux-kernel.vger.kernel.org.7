Return-Path: <linux-kernel+bounces-817602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B03B58462
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8552D7AE39D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23D02BDC2B;
	Mon, 15 Sep 2025 18:17:36 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4C41DED49
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757960256; cv=none; b=rJI4tLokha+e4pQ8zUOSYaXlXQSUzuBKav5LJsynOTtoEDdPM8ltg32iOdHONu04SPon3OnuY6p3OjqUwwpoFfs2sNCnJ9eGSY0vW3NMrDJZh4/fe4UMXxLCPbitFsQ2FU2wfBTIDUgN+w++he3UsUz4BPkFpamb7aUjWxK39aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757960256; c=relaxed/simple;
	bh=Jjg2hMj25U0w9kzHueLMZM5Y7zcp/6sgHfxlLGx0WA4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pZ0RedwQeUscRXsHOuUCokdxwZ37RkmplSsxEGIH7rTi/cRZxzog8WD5y0bb3xVQM95Sx327ekVkbQSer22oRBWqwCZi7C2uNdhhrBYp6OSPV9+wEc/CFgka9WiQgv4p+nfpST1pbym3hf81h0YClQoqk67FOKpN4H71CzMiHIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-40f7be8ecf2so128455695ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757960253; x=1758565053;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8h+44VfvFMVv7i2X/IhaTHCIaRTeDzshijo2lVVhBjs=;
        b=Kb8KKFZqrpFsfsudsGzh8+zfyHQ15mt179qOFtVcf2i+DAQcpAgm009vlbah+DK7R6
         0f/vVUdgFH7Seyvbi4pYEShm8+AcZc+6Q0JMX/elpbfye8s0U7IUOqqqCXXZFgSTI2o2
         RVk3UPe0aohyzLWobGrsN02NYbmh7kR34av9mi/UDDHk92l8xjJfNjJrGi+XT0gqNT58
         mmIfwFX+/LIlgyh7LnGjE+B5hCk1t1l/c6ONXkPCKYZRc9K2hE0OOtOewRKPHbSr0aPJ
         Emv6luNs/7u6XLeHMBnqm/n7DVZ0CzVNjrKejVRaVEjL9UpsOZJ0HsUdvyGRKRJhdNgk
         E8eA==
X-Forwarded-Encrypted: i=1; AJvYcCWqqWROxrRLafw0D0qZQmvjYWORRNe5rABUpVK/hg81zYUq/2OmwBspG1YG7FlNYEQU8o8uiMLy5ut4gqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtefrrkY5WMXIya9x7hVJygofBgzXJxkcaky5rKRQIMHtpGG2/
	Pg4OK5PvQpk4w99TTDovzOI+0TiPvhD/rNI6Nsn9HBhCHx+aSvRiueGZlbwh/A+BOc4i8B5ntdX
	mKvyFZz+5OtNr4Sa+AtEEPIyasvF3L6VuaU2ZDNAWGK/3cO4TK+JMSQfWRAo=
X-Google-Smtp-Source: AGHT+IEcmws6unQyv9+1SLk4+xB92pn5iQD0AoKP5pZ734+i1mV7n5tR5HLcr5uINrbEO/pnzguq7EaLlx8wc2vKFmHj+tVGqVXW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1985:b0:424:2d4:5844 with SMTP id
 e9e14a558f8ab-42402d45b3bmr39874415ab.5.1757960253220; Mon, 15 Sep 2025
 11:17:33 -0700 (PDT)
Date: Mon, 15 Sep 2025 11:17:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c8583d.050a0220.2ff435.03a1.GAE@google.com>
Subject: [syzbot] [ntfs3?] INFO: trying to register non-static key in ntfs_set_size
From: syzbot <syzbot+bdeb22a4b9a09ab9aa45@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, penguin-kernel@I-love.SAKURA.ne.jp, 
	penguin-kernel@i-love.sakura.ne.jp, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    590b221ed425 Add linux-next specific files for 20250912
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1379b934580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12a1d1f3a8199632
dashboard link: https://syzkaller.appspot.com/bug?extid=bdeb22a4b9a09ab9aa45
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=144aa762580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117c8762580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/63a963fc26db/disk-590b221e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0c2013d30830/vmlinux-590b221e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7ee4d3a8e8f6/bzImage-590b221e.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/0f2061b3352a/mount_0.gz

The issue was bisected to:

commit 4e8011ffec79717e5fdac43a7e79faf811a384b7
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date:   Tue Sep 2 10:43:24 2025 +0000

    ntfs3: pretend $Extend records as regular files

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10d9947c580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12d9947c580000
console output: https://syzkaller.appspot.com/x/log.txt?x=14d9947c580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bdeb22a4b9a09ab9aa45@syzkaller.appspotmail.com
Fixes: 4e8011ffec79 ("ntfs3: pretend $Extend records as regular files")

loop0: detected capacity change from 0 to 4096
ntfs3(loop0): Different NTFS sector size (4096) and media sector size (512).
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 1 UID: 0 PID: 6038 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 assign_lock_key+0x133/0x150 kernel/locking/lockdep.c:984
 register_lock_class+0x105/0x320 kernel/locking/lockdep.c:1299
 __lock_acquire+0x99/0xd20 kernel/locking/lockdep.c:5112
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 down_write+0x96/0x1f0 kernel/locking/rwsem.c:1590
 ntfs_set_size+0x140/0x200 fs/ntfs3/inode.c:860
 ntfs_extend+0x1d9/0x970 fs/ntfs3/file.c:387
 ntfs_setattr+0x2e8/0xbe0 fs/ntfs3/file.c:808
 notify_change+0xc1a/0xf40 fs/attr.c:546
 do_truncate+0x1a4/0x220 fs/open.c:68
 vfs_truncate+0x493/0x520 fs/open.c:118
 do_sys_truncate+0xdb/0x190 fs/open.c:141
 __do_sys_truncate fs/open.c:153 [inline]
 __se_sys_truncate fs/open.c:151 [inline]
 __x64_sys_truncate+0x5b/0x70 fs/open.c:151
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f037f38eba9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffff0b0c318 EFLAGS: 00000246 ORIG_RAX: 000000000000004c
RAX: ffffffffffffffda RBX: 00007f037f5d5fa0 RCX: 00007f037f38eba9
RDX: 0000000000000000 RSI: 00000000000003ff RDI: 0000200000000140
RBP: 00007f037f411e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f037f5d5fa0 R14: 00007f037f5d5fa0 R15: 0000000000000002
 </TASK>
ntfs3(loop0): ino=19, "file1" attr_set_size
------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON(sem->magic != sem): count = 0x1, magic = 0x0, owner = 0xffff888075e03c80, curr 0xffff888075e03c80, list not empty
WARNING: kernel/locking/rwsem.c:1375 at __up_write kernel/locking/rwsem.c:1375 [inline], CPU#1: syz.0.17/6038
WARNING: kernel/locking/rwsem.c:1375 at up_write+0x2d1/0x420 kernel/locking/rwsem.c:1643, CPU#1: syz.0.17/6038
Modules linked in:
CPU: 1 UID: 0 PID: 6038 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:__up_write kernel/locking/rwsem.c:1375 [inline]
RIP: 0010:up_write+0x2d1/0x420 kernel/locking/rwsem.c:1643
Code: c7 c7 00 ea aa 8b 48 c7 c6 60 eb aa 8b 48 8b 54 24 08 48 8b 0c 24 4c 8b 44 24 10 4d 89 e1 41 52 e8 54 57 e6 ff 48 83 c4 08 90 <0f> 0b 90 90 e9 a4 fd ff ff 90 0f 0b 90 e9 8c fe ff ff c6 05 09 ed
RSP: 0018:ffffc90002f878b8 EFLAGS: 00010286
RAX: 01d3ee795f15c600 RBX: ffff888058e20140 RCX: ffff888075e03c80
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: dffffc0000000000 R08: ffffc90002f875c7 R09: 1ffff920005f0eb8
R10: dffffc0000000000 R11: fffff520005f0eb9 R12: ffff888075e03c80
R13: ffff888058e201a8 R14: 1ffff1100b1c4035 R15: ffff888058e20198
FS:  00005555647f8500(0000) GS:ffff888125ae8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32563fff CR3: 0000000073aba000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ntfs_set_size+0x172/0x200 fs/ntfs3/inode.c:865
 ntfs_extend+0x1d9/0x970 fs/ntfs3/file.c:387
 ntfs_setattr+0x2e8/0xbe0 fs/ntfs3/file.c:808
 notify_change+0xc1a/0xf40 fs/attr.c:546
 do_truncate+0x1a4/0x220 fs/open.c:68
 vfs_truncate+0x493/0x520 fs/open.c:118
 do_sys_truncate+0xdb/0x190 fs/open.c:141
 __do_sys_truncate fs/open.c:153 [inline]
 __se_sys_truncate fs/open.c:151 [inline]
 __x64_sys_truncate+0x5b/0x70 fs/open.c:151
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f037f38eba9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffff0b0c318 EFLAGS: 00000246 ORIG_RAX: 000000000000004c
RAX: ffffffffffffffda RBX: 00007f037f5d5fa0 RCX: 00007f037f38eba9
RDX: 0000000000000000 RSI: 00000000000003ff RDI: 0000200000000140
RBP: 00007f037f411e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f037f5d5fa0 R14: 00007f037f5d5fa0 R15: 0000000000000002
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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


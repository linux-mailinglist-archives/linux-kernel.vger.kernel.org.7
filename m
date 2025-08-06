Return-Path: <linux-kernel+bounces-757370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 315E8B1C15A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF4633B8E8E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 07:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B7821146C;
	Wed,  6 Aug 2025 07:32:36 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88742189905
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 07:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754465556; cv=none; b=sZTVJrYMhqrvJXJwmIBIqukcB6OB9mgER7ROS+gERDqXtgPpmvChQIyEba/xeOmc7nphEHbUyuXn9s0/A7QU3HAMb0a7HtMrM4Oew6+ivJRU/+ImSvkhdEcKAgUNBTMMe40tbFtadLq344zOdObqBpDpyN/gqI383s0vFpBy6oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754465556; c=relaxed/simple;
	bh=l/kHojOXenc6cht0E1zvmIHSO7W3QGMX5lWugAi/ib4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WOPVs+8T0ZDeT93gx3vuxVsT67ewkjPfdOzNRY70TSyMBcdG3ZmfF3FKVZ+1FkzyVrGnDq2xMgTMdJGqjHZvI7nQwH0QrUiTKX7Kx0zxCJgBZcrVf3oY2ZEll6MHcSjFEBDaWlBqS1RZP1IoPEOzFJ0EMj3SMZTubooo0DkHnXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-8649be94fa1so1106588539f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 00:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754465553; x=1755070353;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lb9tA21seyZSy4XhKxCHf9LJoOjlvOlQuRKxHDQlfRE=;
        b=n9PiaafjOCGjIHADimmrW4ng34iXVf4C5MYG294ftCfj/iSVhHIIDd4ZjJdz7Ii6jb
         PbWmgce6C61frbS9u2odOG2l8275A6K+Qe2SEULRFppAxMMIY0r31OBQ9lxnEk5FKiEl
         g8mmfn99hmn9DY0tDv3ZfW8/tDVVoX5hGUkzWJyc/CGBQFaTkB9aSiQ+FXGVw+g9Gul1
         jv7XwKkatmZig2OwdnHMfG5KsWN5BcUs/RY2qhtMPF9QDbAC2a9C8aA3c78IpLZmjA0y
         HF421PhXw8/hgLS1RVJJQnet97WyF2i/MXeLmXGC1gT5z49QmbG9iQGRs7vdpMceFJRj
         7yiA==
X-Forwarded-Encrypted: i=1; AJvYcCX8xReiVutMFSrS0rz3S/CZmi2Xl9J4+07SKY6274ss4jIIgNks+6VtdqLIzFczdB04rEEOdmA8aRCyLmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqyLdQjGX+cL958BKg9he19mGQjqRPjG3WJAyc9wHfLJ/Dsji4
	yGqzivX5Fa4RK04Z0TSaE3IjLLqS4GBEp9vhq3xipEgw9oVf3nbIePFUznY8K6vbNaNZGAdfsMk
	+Q2oZHmkNjeK1a13bEcW1xTbB1rQ59xmHMGV6DwzBRoxQwJSzMzIR+9lTNuA=
X-Google-Smtp-Source: AGHT+IHgMkj4ehltobXHJlvSAm1aoN3egrOJIG7HfILy/IDX3U6of4rQHz1yGGGKmj/O/EjJEf/tyMnbW6EkkcHnEkidxuwKQNhA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6b07:b0:881:81b7:1058 with SMTP id
 ca18e2360f4ac-8819f070216mr349259439f.7.1754465553553; Wed, 06 Aug 2025
 00:32:33 -0700 (PDT)
Date: Wed, 06 Aug 2025 00:32:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68930511.050a0220.7f033.003a.GAE@google.com>
Subject: [syzbot] [mm?] WARNING in follow_page_pte
From: syzbot <syzbot+57bcc752f0df8bb1365c@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, david@redhat.com, jgg@ziepe.ca, 
	jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	peterx@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7e161a991ea7 Merge tag 'i2c-for-6.17-rc1-part2' of git://g..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16d385bc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=75e522434dc68cb9
dashboard link: https://syzkaller.appspot.com/bug?extid=57bcc752f0df8bb1365c
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13fa96a2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1083c434580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/85ce789ac77a/disk-7e161a99.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4d1fd8fed61a/vmlinux-7e161a99.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9bd5f709ed6f/bzImage-7e161a99.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+57bcc752f0df8bb1365c@syzkaller.appspotmail.com

 do_initcall_level+0x104/0x190 init/main.c:1331
 do_initcalls+0x59/0xa0 init/main.c:1347
 kernel_init_freeable+0x334/0x4b0 init/main.c:1579
 kernel_init+0x1d/0x1d0 init/main.c:1469
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5866 at mm/gup.c:869 follow_page_pte+0xe3c/0x13e0 mm/gup.c:868
Modules linked in:
CPU: 0 UID: 0 PID: 5866 Comm: syz-executor302 Not tainted 6.16.0-syzkaller-11699-g7e161a991ea7 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:follow_page_pte+0xe3c/0x13e0 mm/gup.c:868
Code: ff e8 f8 7a b7 ff 48 ff cb e9 a2 fc ff ff e8 eb 7a b7 ff 4c 89 f7 48 c7 c6 c0 11 96 8b e8 5c cb 1f ff c6 05 75 f7 84 0d 01 90 <0f> 0b 90 e9 0c fd ff ff e8 d7 46 70 09 89 d9 80 e1 07 80 c1 03 38
RSP: 0018:ffffc90003ddf8a0 EFLAGS: 00010246
RAX: 308c9254a9bba300 RBX: 0000000000000000 RCX: 308c9254a9bba300
RDX: 0000000000000004 RSI: ffffffff8dba2d77 RDI: ffff8880322c9e00
RBP: ffffc90003ddf988 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfa1ec R12: dffffc0000000000
R13: 0000000000080101 R14: ffffea0001c20240 R15: 0000000070809867
FS:  0000555557f15380(0000) GS:ffff888125c24000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000004340 CR3: 0000000072ff4000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 follow_pmd_mask mm/gup.c:-1 [inline]
 follow_pud_mask mm/gup.c:981 [inline]
 follow_p4d_mask mm/gup.c:998 [inline]
 follow_page_mask mm/gup.c:1041 [inline]
 __get_user_pages+0xa8e/0x2ce0 mm/gup.c:1444
 __get_user_pages_locked mm/gup.c:1712 [inline]
 __gup_longterm_locked+0x3dc/0x1660 mm/gup.c:2493
 pin_user_pages+0x9e/0xd0 mm/gup.c:3406
 xdp_umem_pin_pages+0x117/0x340 net/xdp/xdp_umem.c:105
 xdp_umem_reg net/xdp/xdp_umem.c:230 [inline]
 xdp_umem_create+0x677/0x8e0 net/xdp/xdp_umem.c:263
 xsk_setsockopt+0x7b0/0x8d0 net/xdp/xsk.c:1409
 do_sock_setsockopt+0x179/0x1b0 net/socket.c:2344
 __sys_setsockopt net/socket.c:2369 [inline]
 __do_sys_setsockopt net/socket.c:2375 [inline]
 __se_sys_setsockopt net/socket.c:2372 [inline]
 __x64_sys_setsockopt+0x13f/0x1b0 net/socket.c:2372
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9ea1cc05b9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc94f86308 EFLAGS: 00000206 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9ea1cc05b9
RDX: 0000000000000004 RSI: 000000000000011b RDI: 0000000000000004
RBP: 00007f9ea1d335f0 R08: 000000000000001c R09: 0000000000000006
R10: 00002000000000c0 R11: 0000000000000206 R12: 0000000000000001
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
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


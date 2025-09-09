Return-Path: <linux-kernel+bounces-809037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01859B507C8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 23:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A3D462C1A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A3724C692;
	Tue,  9 Sep 2025 21:10:33 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C3C2512FC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 21:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757452233; cv=none; b=O5WHR3ZQ0GjeGxNXfVpyRU1EBJYgO+XIbolS/vJnxoWiTGBeJLONiHYR5zlJMnAvrYWhxkLm9+hCBArjvJdbxAhE85BXR1L8x1CnMXQ225hg7j8/jgx/nIAoem0k9Gbo1yfgyVE7leXuEfS/+jpqVuX/3R9bGW/o+Zfmm91EjFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757452233; c=relaxed/simple;
	bh=OzgSK9E87Ojka9/phKOHarFwumy+GWTeCy2ETYUOiNY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZrGUOppGpcFsLE1slVW5osGqpp1FIblsKJckMQqtJ7vjdMc1g23cjGeF3JHeocmeZyC5UoZFAFNz72v86NOW7MMKp0TtPUVDOingJS+xLvbC50pptJn91l9O5rX+d6MBBWVhY6h7IGOagC4unaakl2TlB8x+jS7kCBCCPIbOI5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-414c47fbe8eso12077875ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 14:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757452230; x=1758057030;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QdCUk6/i806tq9cAoWlUqBA7Jf2cackfMam7zEwSTvI=;
        b=h8jzY/5DweiHjNBZwE04ELqNy34Sd7uhsPtbB7PUA+wKc5ucfmLaYkCQ9hmBGXSgS8
         SG3WU3gEtSgVzvxiLDLSBOTw741DzrzU2eLtgwk7+RTPMGpGJS2Y0Qd0QchCdFC4JZKB
         qmrathx34hV9WqfHY7aDssUsNycoHWowm3foDYbbQdANyv6BWRNxIUyQVUr0FqUteGS7
         4U1ykNcU4UaprbwxwK/IMyS8GBn2DPI/fBtO9emLhJwGrv5DWyUl4EUHvy18Hq7+mnSK
         KefhyNm+Pg1XPdhqz1T9K8LI3u9HHYWi3r3IksPgEp6aqieym6XhY78wX81DSVT2RmMw
         zG1A==
X-Forwarded-Encrypted: i=1; AJvYcCWeo5szhhYdSUsVM+SaxgPyrfunfvdDxpQbAK+Yy8J8xRUTqwaOLc2NFe2HWr2HCf6SGqEFhSw6IiLdIJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzejdHQ15/KPV3uBPV+5mBR7D/2g8BxSocDQSdm9GVadjCNmd7Y
	EEp5ueCtdG1W97bvTGU27brxIYbb30qkkP7f7uoXk55fMjsri01znT4P0fKfAqyTm7YafMBAl77
	HeenfWoOKfPG7SHzJ3JEG/0sI1T71Vm7hyB2lTHUUqOunb1u0XimbagvmoW0=
X-Google-Smtp-Source: AGHT+IHKMIXCfa3298eqbkMurUnvDMP+iByaLckTqP5ryvDUhOd3YSQWbpKmztxDjFKTQPVkMPqjCGmDHiGt8BMKFFB2xCZxIMJr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa1:b0:3f6:56a4:1e13 with SMTP id
 e9e14a558f8ab-3fd806a3222mr186081115ab.1.1757452230440; Tue, 09 Sep 2025
 14:10:30 -0700 (PDT)
Date: Tue, 09 Sep 2025 14:10:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c097c6.050a0220.3c6139.000c.GAE@google.com>
Subject: [syzbot] [io-uring?] WARNING in __vmap_pages_range_noflush (2)
From: syzbot <syzbot+42d478f812698fed9f41@syzkaller.appspotmail.com>
To: axboe@kernel.dk, io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    be5d4872e528 Add linux-next specific files for 20250905
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1458a962580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=114fb6eb337a294b
dashboard link: https://syzkaller.appspot.com/bug?extid=42d478f812698fed9f41
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1510d312580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1258a962580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fb814704342a/disk-be5d4872.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4f4366b3c12b/vmlinux-be5d4872.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7b2472ced6f9/bzImage-be5d4872.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+42d478f812698fed9f41@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: mm/vmalloc.c:538 at vmap_pages_pte_range mm/vmalloc.c:538 [inline], CPU#0: syz.0.17/6034
WARNING: mm/vmalloc.c:538 at vmap_pages_pmd_range mm/vmalloc.c:569 [inline], CPU#0: syz.0.17/6034
WARNING: mm/vmalloc.c:538 at vmap_pages_pud_range mm/vmalloc.c:587 [inline], CPU#0: syz.0.17/6034
WARNING: mm/vmalloc.c:538 at vmap_pages_p4d_range mm/vmalloc.c:605 [inline], CPU#0: syz.0.17/6034
WARNING: mm/vmalloc.c:538 at vmap_small_pages_range_noflush mm/vmalloc.c:627 [inline], CPU#0: syz.0.17/6034
WARNING: mm/vmalloc.c:538 at __vmap_pages_range_noflush+0xdf1/0xf30 mm/vmalloc.c:656, CPU#0: syz.0.17/6034
Modules linked in:
CPU: 0 UID: 0 PID: 6034 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:vmap_pages_pte_range mm/vmalloc.c:538 [inline]
RIP: 0010:vmap_pages_pmd_range mm/vmalloc.c:569 [inline]
RIP: 0010:vmap_pages_pud_range mm/vmalloc.c:587 [inline]
RIP: 0010:vmap_pages_p4d_range mm/vmalloc.c:605 [inline]
RIP: 0010:vmap_small_pages_range_noflush mm/vmalloc.c:627 [inline]
RIP: 0010:__vmap_pages_range_noflush+0xdf1/0xf30 mm/vmalloc.c:656
Code: eb 7b e8 92 1e ad ff eb 2f e8 8b 1e ad ff eb 6d e8 84 1e ad ff 31 ed eb 64 e8 7b 1e ad ff 90 0f 0b 90 eb 14 e8 70 1e ad ff 90 <0f> 0b 90 eb 09 e8 65 1e ad ff 90 0f 0b 90 bd f4 ff ff ff 44 8b 74
RSP: 0018:ffffc90003dff950 EFLAGS: 00010293
RAX: ffffffff8213e750 RBX: dffffc0000000000 RCX: ffff888030da3c80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff8213e9c5
R10: fffff520014d3800 R11: ffffed10170c7fa9 R12: ffff888028890828
R13: ffff88802e700d08 R14: 0000000000000000 R15: 1ffff11005ce01a1
FS:  0000555592944500(0000) GS:ffff8881257ba000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32163fff CR3: 0000000077ab6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 vmap_pages_range_noflush mm/vmalloc.c:681 [inline]
 vmap_pages_range mm/vmalloc.c:701 [inline]
 vmap+0x1ca/0x310 mm/vmalloc.c:3515
 io_region_init_ptr+0x24d/0x350 io_uring/memmap.c:125
 io_create_region+0x3a4/0x480 io_uring/memmap.c:228
 io_allocate_scq_urings+0x2b0/0x870 io_uring/io_uring.c:3626
 io_uring_create+0x591/0xba0 io_uring/io_uring.c:3867
 io_uring_setup io_uring/io_uring.c:3963 [inline]
 __do_sys_io_uring_setup io_uring/io_uring.c:3997 [inline]
 __se_sys_io_uring_setup+0x264/0x270 io_uring/io_uring.c:3988
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3093f8ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffcd7235a8 EFLAGS: 00000206 ORIG_RAX: 00000000000001a9
RAX: ffffffffffffffda RBX: 00007f30941c5fa0 RCX: 00007f3093f8ebe9
RDX: 0000000000000000 RSI: 0000200000000040 RDI: 0000000000007688
RBP: 0000200000000040 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000007688 R15: 0000000000000000
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


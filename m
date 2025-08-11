Return-Path: <linux-kernel+bounces-763348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2E0B213B8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9123A1A22C87
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F90A2C21D7;
	Mon, 11 Aug 2025 17:54:30 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE29296BDC
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754934869; cv=none; b=FDIj1nCHnK2RcV0rT848DkYKnNOGWsSVLil8JcovPOKNfgjvytLp56fCIqGLIphmp0d+MxmHb2ILtffMWPuGQbBH+oNYBMbhbZxTVfB+H+++2WVPbyFfE2hIhA5T+sAxTGIlRg2zczrUu7WRq9V9wp3fSQ0MSnnO/TAUl6ZLiDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754934869; c=relaxed/simple;
	bh=K8HK3LeDujyGDPXSW9Aw2DJ+0z4MHcTBgoCieOpNleA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YRZNAm9/7acKxe6M+SwobnimY/JCN+zYN4JVcWTNVuHOp8PNyO2d7DWain1BNPjnJs4ev2vJNaqC0On94xFwZta81Q76Lhfofnu7bFOKfylCABLeuxe2v+14kxkvLCS9uPDkFI1sWXsGvm6q+5teGfqkhMA5jIzDvFIxa/8EeQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-881776a2c22so1165000639f.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754934867; x=1755539667;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kg0sEt9Qd63Uea/fJk77XuMQqlvmjKoGqP4UdO9qWRQ=;
        b=TjSpiZYqtoL4wY5O7etNdlqnx3RcAb8yeG5s/WPULI4ZI5viBJSY7mep7PiJ0oZ/Zo
         AuUBCoe9LuDeIaWJzRls73LcV6FMnQBd4zPGYAMEyMCYv3vdJ3CM62KiVQvkb+jE1KON
         inF0aw3oeLBDDrvzX/2+Z90WriVTcyaSdy+/Xv2HJcDaGuoomwGlKyHCPOzShVG4/0f1
         TqPPPg0lkqZCbFE7mR7JXBCJQb2pfxgYbYdsG8tTNhXnKhFUtCBw8c4owFgLUYRU9LfU
         qhdGK5gnYbJtNNATmGkqltAwXALC4rNl8IGwtWiRxx5lhT4Vdy69J8FTHwEL0ZBNspPe
         WRnA==
X-Forwarded-Encrypted: i=1; AJvYcCWEof1Pmk9YKSOFpTvADJaO/V5wLQBwVsuJd8gOQBE1E0AAh/rEknDcAD/4g+TcbUSl6ldDKzk9tTEDxtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCqePJAvzhMP49IK2W8gh0iUIHES92ctcocNagFne1mVy3RFY2
	JtaOG5tXnVEeMRO4J65LhPOUZANfE+ke7rn9U9KcnqxvOzXRG2RudZzy1pIs+gLo0m37YZbto+L
	2ReHdrj00DfFkoFjZYq/j9aoFn2/hEwrS4xyqWI/NN0PnLzBsFKbuJRjuCbs=
X-Google-Smtp-Source: AGHT+IH1GomdFKNp3ljhaRWRiZBZDvsA9Kjtkb6MmS3GgDX5Q3EjEUQs8fxb+jkQL4uuCK9XT8kjA0/AAgnZJHQ9OH+Ng+eOnXlo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:7198:b0:87c:3d17:6608 with SMTP id
 ca18e2360f4ac-8841bcd5326mr118113139f.0.1754934867552; Mon, 11 Aug 2025
 10:54:27 -0700 (PDT)
Date: Mon, 11 Aug 2025 10:54:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689a2e53.050a0220.51d73.00a1.GAE@google.com>
Subject: [syzbot] [io-uring?] WARNING in vmap_small_pages_range_noflush
From: syzbot <syzbot+7f04e5b3fea8b6c33d39@syzkaller.appspotmail.com>
To: asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6e64f4580381 Merge tag 'input-for-v6.17-rc0' of git://git...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10850ea2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5f2996d42fef6c09
dashboard link: https://syzkaller.appspot.com/bug?extid=7f04e5b3fea8b6c33d39
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10ec9042580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14850ea2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5166c0e1d4f0/disk-6e64f458.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0d6654192cf8/vmlinux-6e64f458.xz
kernel image: https://storage.googleapis.com/syzbot-assets/239aaa681481/bzImage-6e64f458.xz

The issue was bisected to:

commit 087f997870a948820ec366701d178f402c6a23a3
Author: Pavel Begunkov <asml.silence@gmail.com>
Date:   Fri Nov 29 13:34:32 2024 +0000

    io_uring/memmap: implement mmap for regions

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=157afea2580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=177afea2580000
console output: https://syzkaller.appspot.com/x/log.txt?x=137afea2580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7f04e5b3fea8b6c33d39@syzkaller.appspotmail.com
Fixes: 087f997870a9 ("io_uring/memmap: implement mmap for regions")

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5851 at mm/vmalloc.c:542 vmap_pages_pte_range mm/vmalloc.c:542 [inline]
WARNING: CPU: 1 PID: 5851 at mm/vmalloc.c:542 vmap_pages_pmd_range mm/vmalloc.c:569 [inline]
WARNING: CPU: 1 PID: 5851 at mm/vmalloc.c:542 vmap_pages_pud_range mm/vmalloc.c:587 [inline]
WARNING: CPU: 1 PID: 5851 at mm/vmalloc.c:542 vmap_pages_p4d_range mm/vmalloc.c:605 [inline]
WARNING: CPU: 1 PID: 5851 at mm/vmalloc.c:542 vmap_small_pages_range_noflush+0x984/0xc90 mm/vmalloc.c:627
Modules linked in:
CPU: 1 UID: 0 PID: 5851 Comm: syz-executor194 Not tainted 6.16.0-syzkaller-11952-g6e64f4580381 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:vmap_pages_pte_range mm/vmalloc.c:542 [inline]
RIP: 0010:vmap_pages_pmd_range mm/vmalloc.c:569 [inline]
RIP: 0010:vmap_pages_pud_range mm/vmalloc.c:587 [inline]
RIP: 0010:vmap_pages_p4d_range mm/vmalloc.c:605 [inline]
RIP: 0010:vmap_small_pages_range_noflush+0x984/0xc90 mm/vmalloc.c:627
Code: 4d 89 f4 4d 21 ec 4c 89 e7 e8 98 6c ab ff 4d 39 ec 75 68 e8 de 71 ab ff 4c 09 eb e9 c8 fd ff ff 4c 8b 34 24 e8 cd 71 ab ff 90 <0f> 0b 90 e9 fc fe ff ff e8 bf 71 ab ff 4c 89 e7 e8 07 00 f7 ff 31
RSP: 0018:ffffc90002ea7990 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffea0003000000 RCX: ffffffff82101e9f
RDX: ffff888025be2440 RSI: ffffffff82102153 RDI: 0000000000000005
RBP: ffff8880505c4508 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 8000000000000163 R14: 1ffff920005d4f47 R15: ffffc900602a1000
FS:  000055557d51e380(0000) GS:ffff8881247c4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055dad0a404b0 CR3: 0000000071b22000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __vmap_pages_range_noflush mm/vmalloc.c:656 [inline]
 vmap_pages_range_noflush mm/vmalloc.c:681 [inline]
 vmap_pages_range mm/vmalloc.c:701 [inline]
 vmap+0x1aa/0x320 mm/vmalloc.c:3515
 io_region_init_ptr io_uring/memmap.c:125 [inline]
 io_create_region+0x605/0xd40 io_uring/memmap.c:228
 io_create_region_mmap_safe+0xb2/0x170 io_uring/memmap.c:245
 io_register_mem_region io_uring/register.c:616 [inline]
 __io_uring_register+0x59f/0x2440 io_uring/register.c:836
 __do_sys_io_uring_register io_uring/register.c:929 [inline]
 __se_sys_io_uring_register io_uring/register.c:906 [inline]
 __x64_sys_io_uring_register+0x169/0x280 io_uring/register.c:906
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff9c19ee429
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffec21487c8 EFLAGS: 00000246 ORIG_RAX: 00000000000001ab
RAX: ffffffffffffffda RBX: 0000000000000045 RCX: 00007ff9c19ee429
RDX: 0000200000000200 RSI: 0000000000000022 RDI: 0000000000000003
RBP: 0000000000000003 R08: 0000000000000000 R09: 00007ff9c1a66220
R10: 0000000000000001 R11: 0000000000000246 R12: 0000200000000300
R13: 0000200000000100 R14: 0000000000000001 R15: 0000000000000001
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


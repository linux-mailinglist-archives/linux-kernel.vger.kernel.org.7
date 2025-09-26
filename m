Return-Path: <linux-kernel+bounces-833654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50610BA2905
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 377EF7ADA8B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 06:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE2E27AC3A;
	Fri, 26 Sep 2025 06:45:32 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37ECD8F6F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758869131; cv=none; b=guhYO86/SLuQBpWvQgNFCFdcGSg4lzYU5P2QXUxJZKFs1UkQRyHmZJ3GY1544EnRRqj0GEkfd/DcKyrxj/MUbaQCk1xwSGyqhBpJ0grLGU0spj1lC+T3z4+m2Z2oszSal0eTi7i7vU0slc4gqYgNt3vkiKUJLx5RJdSekxUyHa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758869131; c=relaxed/simple;
	bh=gecowTKj8gdi5IDxs66slsUPgLRG9Dhxu+cope5L4zw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=seDotn6uGercNgHYrjf21OddSF5twXlsfH9ldFBfa40Wf4MB+dZpeMWBWp+wMU8lILEl1BjwIFGgoF7hjyXj/x/MLnO0/xh5CzS+ihk4CtsfOoaVfUQPB48uTuyhBwRHQcD+u73jJNrmW/ze7j2arYJcAFKh70Lj27jnUtXCCq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-42571c700d2so41502575ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 23:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758869129; x=1759473929;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1veCcU3mH9oLnhdNlf6mJUGV7a4TAFPi+gLi5uVhv0M=;
        b=MCrPOBFta2BPO4bLlXxhZFYDDkWOWVt4gOh/J/X13mBBrh7yY4xSzgLP0ALx9CaSJY
         X7ADs3JXbGZCIejhCUd571hfqqGFkMROLrMQUSrTUOHh0qzqrJBNhm067xydJu9xjniK
         LjK/mBD3PP6q4G5OueAuYYlCPPIiLdSnwkSgS2msdn2UPyXujjRT0mghNGAn2h/1JTXD
         revcjLghq0iJB+1QOTVt/41TsuhdrMKtN0Y0E1ZvYqlPLz/AD+dal8zW0BjlppwOizCp
         qSti91B1dUlEjMiT3rhhqLrDcyfLR/csz1G923/gpH7GT62kvVAjtLpLB3wEUGaNF2Tc
         lG5A==
X-Forwarded-Encrypted: i=1; AJvYcCVnZ5kujuZaaMV7WNuT95qqq647JLJHOrKVSqsehdYn2OtU2uWZxXnVhtIJvf8XkVDkX4y5YuvB0HCAj/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK9PwR1bniay+dq35vg+NNh1l76jtwfXgPK6tZByUo4gbrS2fy
	X5rETcZGQLQRklPfRwebOrYixTWo0iaeCKvkunBIeO6SnEjpZC93lOQFGmV1LYH/4urVANzoA5x
	A55ZXrr5l986NO+Bc/XGN7a+ikLCc+Bim8/VSm257AGAu9ajB21FUZUwjQtA=
X-Google-Smtp-Source: AGHT+IGt9fmY+fMre+iBYy4LP8OBoS/OyInBYpNKNG9zH0SZ97oV98zut4bI7DGrK0yZbXbA8dni2nbYBirwgoVX3tXsVCJw/Ahb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:490d:b0:418:84eb:ea20 with SMTP id
 e9e14a558f8ab-4259562f43bmr90064995ab.15.1758869129365; Thu, 25 Sep 2025
 23:45:29 -0700 (PDT)
Date: Thu, 25 Sep 2025 23:45:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d63689.050a0220.25d7ab.00d9.GAE@google.com>
Subject: [syzbot] [mm?] KCSAN: data-race in try_to_compact_pages / try_to_compact_pages
From: syzbot <syzbot+20dd68d4ba19e8242c26@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, hannes@cmpxchg.org, jackmanb@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com, 
	surenb@google.com, syzkaller-bugs@googlegroups.com, vbabka@suse.cz, 
	ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cec1e6e5d1ab Merge tag 'sched_ext-for-6.17-rc7-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12448f12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6e0c213d0735f5dd
dashboard link: https://syzkaller.appspot.com/bug?extid=20dd68d4ba19e8242c26
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/10b7c8fdfdec/disk-cec1e6e5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cbecc36962db/vmlinux-cec1e6e5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/214f107d0a3e/bzImage-cec1e6e5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+20dd68d4ba19e8242c26@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in try_to_compact_pages / try_to_compact_pages

read-write to 0xffff88823fffacf0 of 4 bytes by task 6757 on cpu 1:
 compaction_deferred mm/compaction.c:149 [inline]
 try_to_compact_pages+0x1be/0x940 mm/compaction.c:2838
 __alloc_pages_direct_compact+0x65/0x1d0 mm/page_alloc.c:4066
 __alloc_pages_slowpath+0x360/0x5f0 mm/page_alloc.c:4787
 __alloc_frozen_pages_noprof+0x270/0x360 mm/page_alloc.c:5161
 alloc_pages_mpol+0xb3/0x250 mm/mempolicy.c:2416
 alloc_frozen_pages_noprof+0x90/0x110 mm/mempolicy.c:2487
 ___kmalloc_large_node+0x52/0x100 mm/slub.c:4317
 __kmalloc_large_node_noprof+0x16/0xa0 mm/slub.c:4348
 __do_kmalloc_node mm/slub.c:4364 [inline]
 __kmalloc_noprof+0x2ab/0x3e0 mm/slub.c:4388
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kmalloc_array_noprof include/linux/slab.h:948 [inline]
 io_vec_realloc io_uring/rsrc.c:1327 [inline]
 io_import_reg_vec+0x645/0xe80 io_uring/rsrc.c:1520
 io_sendmsg_zc+0x91/0x550 io_uring/net.c:1545
 __io_issue_sqe+0xfb/0x2e0 io_uring/io_uring.c:1771
 io_issue_sqe+0x53/0x970 io_uring/io_uring.c:1794
 io_queue_sqe io_uring/io_uring.c:2023 [inline]
 io_submit_sqe io_uring/io_uring.c:2283 [inline]
 io_submit_sqes+0x675/0x1060 io_uring/io_uring.c:2396
 __do_sys_io_uring_enter io_uring/io_uring.c:3463 [inline]
 __se_sys_io_uring_enter+0x1c1/0x1b70 io_uring/io_uring.c:3397
 __x64_sys_io_uring_enter+0x78/0x90 io_uring/io_uring.c:3397
 x64_sys_call+0x2de1/0x2ff0 arch/x86/include/generated/asm/syscalls_64.h:427
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

write to 0xffff88823fffacf0 of 4 bytes by task 6696 on cpu 0:
 compaction_deferred mm/compaction.c:150 [inline]
 try_to_compact_pages+0x207/0x940 mm/compaction.c:2838
 __alloc_pages_direct_compact+0x65/0x1d0 mm/page_alloc.c:4066
 __alloc_pages_slowpath+0x360/0x5f0 mm/page_alloc.c:4787
 __alloc_frozen_pages_noprof+0x270/0x360 mm/page_alloc.c:5161
 alloc_pages_mpol+0xb3/0x250 mm/mempolicy.c:2416
 alloc_frozen_pages_noprof+0x90/0x110 mm/mempolicy.c:2487
 ___kmalloc_large_node+0x52/0x100 mm/slub.c:4317
 __kmalloc_large_node_noprof+0x16/0xa0 mm/slub.c:4348
 __do_kmalloc_node mm/slub.c:4364 [inline]
 __kmalloc_noprof+0x2ab/0x3e0 mm/slub.c:4388
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kmalloc_array_noprof include/linux/slab.h:948 [inline]
 io_vec_realloc io_uring/rsrc.c:1327 [inline]
 io_import_reg_vec+0x645/0xe80 io_uring/rsrc.c:1520
 io_sendmsg_zc+0x91/0x550 io_uring/net.c:1545
 __io_issue_sqe+0xfb/0x2e0 io_uring/io_uring.c:1771
 io_issue_sqe+0x53/0x970 io_uring/io_uring.c:1794
 io_queue_sqe io_uring/io_uring.c:2023 [inline]
 io_submit_sqe io_uring/io_uring.c:2283 [inline]
 io_submit_sqes+0x675/0x1060 io_uring/io_uring.c:2396
 __do_sys_io_uring_enter io_uring/io_uring.c:3463 [inline]
 __se_sys_io_uring_enter+0x1c1/0x1b70 io_uring/io_uring.c:3397
 __x64_sys_io_uring_enter+0x78/0x90 io_uring/io_uring.c:3397
 x64_sys_call+0x2de1/0x2ff0 arch/x86/include/generated/asm/syscalls_64.h:427
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00000005 -> 0x00000004

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 6696 Comm: syz.2.1234 Not tainted syzkaller #0 PREEMPT(voluntary) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
==================================================================


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


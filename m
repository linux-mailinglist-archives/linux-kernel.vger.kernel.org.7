Return-Path: <linux-kernel+bounces-823151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC85B85AED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC481886259
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B70A311C01;
	Thu, 18 Sep 2025 15:34:35 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A789730E0C7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209674; cv=none; b=lqGO5fd3BYXhEJ+0foriunIylG+Hy5XrLyBbwI7sfmeuDbscSEqMjpghqeB3I38usQOhWmVvPgO7Ej0iHN9gbZhkzOEWuoxXfDKDzp4qJmebzsWnSyY84h/W9leG1FAQcOYZ6p8CKylcLPzo9V2LdnIxphPENByjvC9AXmLdFPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209674; c=relaxed/simple;
	bh=sf8inLcyyURrqrt8I1aE6XtRdQnfMf3aVhy6JYqE0AQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=e2MK+A4B4NkWp+Gjbi5TJfs8F5cd+JM4XbSqP0kqdm2uq3frO8wmBvo+H0VfvEvUnwtqjQQUJ2V8JVhvzMIJmsIdPMf+4ftbW0R6F+OHiEYT7rpK1ufeZXxIDW0dhvvkSd1ywGtbP0/5g+SqfDJJHQZvrrInoZuTdbyvxWmHuFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-42404bb4284so13509955ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758209672; x=1758814472;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rfgUaO3w0Y6SX1N7OWUD+f8H1k2Nfi1/FrpQdNYlp7o=;
        b=l2y51S6h1VXccg3KBk5t4n6bRDijZD3VWbKNCRyW4l6T7Db8oOYVjhtYtYnClTEg4v
         Kxm9cMUXVhMiX3jvO6AP4OFmPsqjw2qF1n3RD3b0rm+fL5PbwLbnauQprhAvs52RD3u9
         n9FP5Ad5i+AhK8oVwLUJbgUTK+718ZQHPxMI8xtfuU0rrZwgiDFDHxrwcbk+h0wOjJ1Y
         Bhe+5E7huv3Dhv0vUsFsr6AOC41ZKkgA8+U0ADypCoKGZCkmKr60Lkj6z/bnJshnGJhE
         RYvdq08bZwakse7yM82Y9xL13eP6jqKetOHtjZx4J3UM2Qr7PxC5Q1h/ZT0QRZhne3Ul
         mz5A==
X-Forwarded-Encrypted: i=1; AJvYcCWSSuyvp1yeYtUAVC/y2BL2+YoVj2bj4gPdLlqZhUPkgBKN3NZfInoj7K3pKW81jdjp9Oq9Zg2rT0cYpuU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8d49CjF4FOQJouwml51AH0tUngYQ8ePTl8IFInh+nAG3/A/kv
	/OIqOF6i8RiTlIx+0RDAvEWphl6WzXQpKkBXRv1r+tQREX72ABmP6afuBGjjH9tO5f4UzKLhyk3
	tOrGT3OZVLey1cJVm9TBxHZbMr61hHA2ntsrDWR//Gt+g2OPw89DR2DwWNcw=
X-Google-Smtp-Source: AGHT+IFw/d224B4mdYFn2HHT8wVIgibnc1Ve50CWbh2u+uRMAr6GY5xyjsDN4Bt/hH/FB8t0SDtH3v9ZmrnDhi5xzfLM+Mnkzx26
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19ca:b0:3f2:a771:9fb3 with SMTP id
 e9e14a558f8ab-4241a56dbedmr90996165ab.27.1758209671826; Thu, 18 Sep 2025
 08:34:31 -0700 (PDT)
Date: Thu, 18 Sep 2025 08:34:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cc2687.050a0220.139b6.0005.GAE@google.com>
Subject: [syzbot] [io-uring?] KASAN: slab-use-after-free Read in
 __io_req_task_work_add (2)
From: syzbot <syzbot+baa2e0f4e02df602583e@syzkaller.appspotmail.com>
To: axboe@kernel.dk, io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8b789f2b7602 Merge tag 'mm-hotfixes-stable-2025-09-17-21-1..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10154f62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d8792ecb6308d0f
dashboard link: https://syzkaller.appspot.com/bug?extid=baa2e0f4e02df602583e
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2c5815e2639f/disk-8b789f2b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1e6e9e88f96c/vmlinux-8b789f2b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e1f2a1d87f1f/bzImage-8b789f2b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+baa2e0f4e02df602583e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in io_req_local_work_add io_uring/io_uring.c:1219 [inline]
BUG: KASAN: slab-use-after-free in __io_req_task_work_add+0x589/0x950 io_uring/io_uring.c:1287
Read of size 4 at addr ffff888032ab9904 by task iou-wrk-12380/12382

CPU: 0 UID: 0 PID: 12382 Comm: iou-wrk-12380 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 io_req_local_work_add io_uring/io_uring.c:1219 [inline]
 __io_req_task_work_add+0x589/0x950 io_uring/io_uring.c:1287
 io_req_task_work_add io_uring/io_uring.h:157 [inline]
 io_req_complete_post io_uring/io_uring.c:961 [inline]
 io_issue_sqe+0x643/0xfd0 io_uring/io_uring.c:1802
 io_wq_submit_work+0x6e9/0xb90 io_uring/io_uring.c:1908
 io_worker_handle_work+0x7cd/0x1180 io_uring/io-wq.c:650
 io_wq_worker+0x42f/0xeb0 io_uring/io-wq.c:704
 ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 12382:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:330 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:356
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4191 [inline]
 slab_alloc_node mm/slub.c:4240 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4247
 io_msg_get_kiocb io_uring/msg_ring.c:117 [inline]
 io_msg_data_remote io_uring/msg_ring.c:126 [inline]
 __io_msg_ring_data+0x47b/0xa80 io_uring/msg_ring.c:151
 io_msg_ring_data io_uring/msg_ring.c:173 [inline]
 io_msg_ring+0x134/0xa00 io_uring/msg_ring.c:314
 __io_issue_sqe+0x17e/0x4b0 io_uring/io_uring.c:1773
 io_issue_sqe+0x165/0xfd0 io_uring/io_uring.c:1796
 io_wq_submit_work+0x6e9/0xb90 io_uring/io_uring.c:1908
 io_worker_handle_work+0x7cd/0x1180 io_uring/io-wq.c:650
 io_wq_worker+0x42f/0xeb0 io_uring/io-wq.c:704
 ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 12380:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_mempool_poison_object+0xad/0x130 mm/kasan/common.c:533
 kasan_mempool_poison_object include/linux/kasan.h:360 [inline]
 io_alloc_cache_put io_uring/alloc_cache.h:23 [inline]
 io_msg_tw_complete+0x12c/0x4f0 io_uring/msg_ring.c:80
 __io_run_local_work_loop io_uring/io_uring.c:1330 [inline]
 __io_run_local_work+0x350/0x810 io_uring/io_uring.c:1363
 io_run_local_work_locked io_uring/io_uring.c:1385 [inline]
 __do_sys_io_uring_enter io_uring/io_uring.c:3478 [inline]
 __se_sys_io_uring_enter+0x1725/0x2b20 io_uring/io_uring.c:3399
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0xb6/0x2b0 arch/x86/entry/syscall_32.c:306
 do_fast_syscall_32+0x34/0x80 arch/x86/entry/syscall_32.c:331
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

The buggy address belongs to the object at ffff888032ab98c0
 which belongs to the cache io_kiocb of size 248
The buggy address is located 68 bytes inside of
 freed 248-byte region [ffff888032ab98c0, ffff888032ab99b8)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x32ab9
memcg:ffff8880334ee901
ksm flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff8881413b9c80 ffffea0001f63740 dead000000000003
raw: 0000000000000000 00000000800c000c 00000000f5000000 ffff8880334ee901
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 12143, tgid 12142 (syz.1.1033), ts 466289495240, free_ts 459260987318
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:2492 [inline]
 allocate_slab+0x8a/0x370 mm/slub.c:2660
 new_slab mm/slub.c:2714 [inline]
 ___slab_alloc+0xbeb/0x1420 mm/slub.c:3901
 __kmem_cache_alloc_bulk mm/slub.c:5346 [inline]
 kmem_cache_alloc_bulk_noprof+0x20e/0x790 mm/slub.c:5418
 __io_alloc_req_refill+0x9d/0x280 io_uring/io_uring.c:1007
 io_alloc_req io_uring/io_uring.h:453 [inline]
 io_submit_sqes+0xbfd/0x1d30 io_uring/io_uring.c:2387
 __do_sys_io_uring_enter io_uring/io_uring.c:3465 [inline]
 __se_sys_io_uring_enter+0x2df/0x2b20 io_uring/io_uring.c:3399
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0xb6/0x2b0 arch/x86/entry/syscall_32.c:306
 do_fast_syscall_32+0x34/0x80 arch/x86/entry/syscall_32.c:331
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
page last free pid 15 tgid 15 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0xcab/0x1770 kernel/rcu/tree.c:2861
 handle_softirqs+0x283/0x870 kernel/softirq.c:579
 run_ksoftirqd+0x9b/0x100 kernel/softirq.c:968
 smpboot_thread_fn+0x53f/0xa60 kernel/smpboot.c:160
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff888032ab9800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc
 ffff888032ab9880: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
>ffff888032ab9900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888032ab9980: fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc
 ffff888032ab9a00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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


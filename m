Return-Path: <linux-kernel+bounces-858068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A59BE8C4E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 427D34F506E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2346345759;
	Fri, 17 Oct 2025 13:13:37 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFA8345725
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760706817; cv=none; b=Gj36rDN5mOQIxS0MKu6dYVfFRNf0EjLvPiDuNlG+tLKsOT5j+9R06qNAOdaNP9fD7GVMbBbjkKE5UlWKrf3yV5mXO+Pv0/pmuxo1unh4YEyENNaDJzpGnwQsYHuR7TA84/0pTq4dGt2MNIhSr42vG0nOlFEo3OXzVvFzQK24zuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760706817; c=relaxed/simple;
	bh=EfGGseb4tK/aZo/BQIEXgtsaRuh1loxFj7mF9jYFufo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=X6BnqgOoJk1YOJ7NkvYBAeCmPp0KsQhlz3bIKLW1pVKXEOqJ4FWg5Bf5q1EjJKUm+8v2uucAGM0Gmo7c55P4bVgVpKF7QeGAE/D3LOJqwk/+2k9XQH0ooCi8HxiGmbgCM53s0usu02HK3AXCAgAnRExsA2VyhGrXbQfz9iWFADM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-427811cad57so56569935ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760706814; x=1761311614;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XaW0KohH6m9nMtE6syaVpsUAGQ5vS481dJIVMfKZMA4=;
        b=WagOg9ZQtCcik13f2oPdgM5oHgyOg9fyhfsGcCKWlHpINDzD0OjhM6Y7HsaBvb898E
         V4kYsEeM4De71fOAvtDnKQmc3cXRtDIOAG7T6rFDm1SCLNuSF66CfHeF6J3bfiUCe/Uh
         2wGhAdr2sAkvQbpy/4Jd9yYvVdQqnoGQQQMMxSKup3VmFOI3A03vssZVcYT8/20x3Ae8
         99/jOihUymSfm4rsXTMzAb/ZEf4/j5xSRfNuLZs1ZVd+Bkpkig5xL1IaDg66RRF97NGE
         0gKl3WOwMK8zBcKnJ0b+hPXbpMDyGT5RqecGe3ZJJESxwFqz+BawPJjVtL+ovtVN6dM8
         YpIw==
X-Forwarded-Encrypted: i=1; AJvYcCUcGu5kST1mSV30SI+Z/EL2NfAvocPmrlbfksfYrakICQ1Mh4W0elXZ7ucOE414dDtaQAupTUt0bGidreE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNne2cqLY2IXIJbXgHcjQgOk4butPHceLJFYkWWJLPhNYovDHW
	PxLUAcGQ21ssrS296N3CxAk19hxdZkA5MoxzcQeYH9dT/QMXZ7TbTW0SLCNdxMi38C2SzMR4qH3
	dL4UPgUDp5ZayF1QqWt+fjATbjjjqgQ8EGF8OP/2CBItzQiBTQr68GKVgbt4=
X-Google-Smtp-Source: AGHT+IFT533WooJwUxxXKh7D/GVz4Sl1wIZHPtn8xZNaKgrwgBTKJGVpXoKYZrCdpxyR8UDu8uMMQTCiUtCjEGduvg9tywe9Sz/d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e06:b0:42f:9501:69e with SMTP id
 e9e14a558f8ab-430c5295023mr40647905ab.20.1760706814179; Fri, 17 Oct 2025
 06:13:34 -0700 (PDT)
Date: Fri, 17 Oct 2025 06:13:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f240fe.050a0220.91a22.0420.GAE@google.com>
Subject: [syzbot] [kernel?] KASAN: unknown-crash Read in copy_mc_to_kernel
From: syzbot <syzbot+d155b4893773c196cdd9@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3a8660878839 Linux 6.18-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10109542580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
dashboard link: https://syzkaller.appspot.com/bug?extid=d155b4893773c196cdd9
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b39e59492185/disk-3a866087.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a9f71abd3189/vmlinux-3a866087.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a8ee0fb986c2/bzImage-3a866087.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d155b4893773c196cdd9@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: unknown-crash in instrument_memcpy_before include/linux/instrumented.h:163 [inline]
BUG: KASAN: unknown-crash in copy_mc_to_kernel+0x35/0xb0 arch/x86/lib/copy_mc.c:74
Read of size 4096 at addr ffff8880af860000 by task syz.5.1091/9436

CPU: 1 UID: 0 PID: 9436 Comm: syz.5.1091 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x2b0/0x2c0 mm/kasan/generic.c:200
 instrument_memcpy_before include/linux/instrumented.h:163 [inline]
 copy_mc_to_kernel+0x35/0xb0 arch/x86/lib/copy_mc.c:74
 dump_page_copy fs/coredump.c:1321 [inline]
 dump_user_range+0x2e4/0xc90 fs/coredump.c:1372
 elf_core_dump+0x3369/0x3960 fs/binfmt_elf.c:2111
 coredump_write+0x116c/0x1900 fs/coredump.c:1049
 vfs_coredump+0x1db5/0x2a60 fs/coredump.c:1170
 get_signal+0x1108/0x1340 kernel/signal.c:3019
 arch_do_signal_or_restart+0xa0/0x790 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:40 [inline]
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 irqentry_exit_to_user_mode+0x7e/0x110 kernel/entry/common.c:73
 exc_page_fault+0xab/0x100 arch/x86/mm/fault.c:1535
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
RIP: 0033:0x7f97dd38eed1
Code: 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 48 3d 01 f0 ff ff 73 01 <c3> 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
RSP: 002b:00000000fffffd10 EFLAGS: 00010217
RAX: 0000000000000000 RBX: 00007f97dd5e6090 RCX: 00007f97dd38eec9
RDX: 0000000000000000 RSI: 00000000fffffd10 RDI: 0000000001000000
RBP: 00007f97dd411f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 00007f97dd5e6128 R14: 00007f97dd5e6090 R15: 00007ffcef26f528
 </TASK>

The buggy address belongs to the physical page:
page: refcount:3 mapcount:1 mapping:ffff888064726de8 index:0x14f pfn:0xaf860
memcg:ffff88801aea1a00
aops:ext4_da_aops ino:7f0 dentry name(?):"syz.IuCCpi"
flags: 0xfff6800000002c(referenced|uptodate|lru|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff6800000002c ffffea0002c0b3c8 ffffea0002be1848 ffff888064726de8
raw: 000000000000014f 0000000000000000 0000000300000000 ffff88801aea1a00
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Movable, gfp_mask 0x152c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_MOVABLE|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL), pid 7122, tgid 7122 (syz.3.435), ts 155471149983, free_ts 153032620682
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1850
 prep_new_page mm/page_alloc.c:1858 [inline]
 get_page_from_freelist+0x2365/0x2440 mm/page_alloc.c:3884
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5183
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_frozen_pages_noprof mm/mempolicy.c:2487 [inline]
 alloc_pages_noprof+0xa9/0x190 mm/mempolicy.c:2507
 folio_alloc_noprof+0x1e/0x30 mm/mempolicy.c:2517
 filemap_alloc_folio_noprof+0xdf/0x470 mm/filemap.c:1020
 ractl_alloc_folio mm/readahead.c:189 [inline]
 page_cache_ra_unbounded+0x35d/0x9a0 mm/readahead.c:275
 do_async_mmap_readahead mm/filemap.c:3376 [inline]
 filemap_fault+0x62d/0x12b0 mm/filemap.c:3475
 __do_fault+0x138/0x390 mm/memory.c:5280
 do_read_fault mm/memory.c:5698 [inline]
 do_fault mm/memory.c:5832 [inline]
 do_pte_missing mm/memory.c:4361 [inline]
 handle_pte_fault mm/memory.c:6177 [inline]
 __handle_mm_fault+0x35e3/0x5400 mm/memory.c:6318
 handle_mm_fault+0x40a/0x8e0 mm/memory.c:6487
 faultin_page mm/gup.c:1126 [inline]
 __get_user_pages+0x165c/0x2a00 mm/gup.c:1428
 __get_user_pages_locked mm/gup.c:1692 [inline]
 get_dump_page+0x1ac/0x3f0 mm/gup.c:2192
 dump_user_range+0x1de/0xc90 fs/coredump.c:1366
 elf_core_dump+0x3369/0x3960 fs/binfmt_elf.c:2111
page last free pid 7072 tgid 7068 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1394 [inline]
 free_unref_folios+0xdb3/0x14f0 mm/page_alloc.c:2963
 folios_put_refs+0x584/0x670 mm/swap.c:1002
 folio_batch_release include/linux/pagevec.h:101 [inline]
 shmem_undo_range+0x49e/0x14b0 mm/shmem.c:1120
 shmem_truncate_range mm/shmem.c:1232 [inline]
 shmem_evict_inode+0x272/0xa70 mm/shmem.c:1360
 evict+0x504/0x9c0 fs/inode.c:810
 __dentry_kill+0x209/0x660 fs/dcache.c:669
 dput+0x19f/0x2b0 fs/dcache.c:911
 __fput+0x68e/0xa70 fs/file_table.c:476
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x6b5/0x2300 kernel/exit.c:966
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1107
 get_signal+0x1285/0x1340 kernel/signal.c:3034
 arch_do_signal_or_restart+0xa0/0x790 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x72/0x130 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880af85ff00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880af85ff80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff8880af860000: 00 c9 2b 58 80 88 ff ff 00 00 00 00 00 00 00 00
                      ^
 ffff8880af860080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880af860100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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


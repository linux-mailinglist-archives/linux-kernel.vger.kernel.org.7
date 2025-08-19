Return-Path: <linux-kernel+bounces-776108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 369E4B2C8AB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B805F1C20E03
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0BF28688A;
	Tue, 19 Aug 2025 15:42:35 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86533283FCF
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755618155; cv=none; b=s7YpZLQyTFE0AhKhxLZq511scKUwz0+xdct9jaOxUjW7Z0oFM2IZADuzMpFPDwyVIx6OUvLEIqZ64elALhwxANXxKl0FsyJBEyIB5wbYRDj9/cc4LmnH4wn4tRzLVBDflwCTuluOy5OjRaFVc+OtglSgLmZ88yBaI2U6vCM8EKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755618155; c=relaxed/simple;
	bh=Q6pzctpHSsj3Nm1LrBD7GVaL6gZ2vK0vOjTzvPodgOU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fU/Dndf632VoyJYFZ/lns+EJSvCo/dpq8NZc4rpDXmbSKNq9U4HFfB9V2rD5Knt6E1oFqy1C0XQqAo13QincVCDFqC+tI7Lz70ImNvtTwAWV3vEdZ09noXANW6unBTiQkSu4WxA9Kl5xeZkTxih8ei8KpzzeDoYx8I328fZ8Uv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-88432e1eaa5so1409409639f.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 08:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755618152; x=1756222952;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0HL7wTUtFP7GQ3Hb9WESu6y45UDSW3hpLYzJaxbTTrQ=;
        b=HvG+vDsH2p3WekOwbAtc2V66xU2lqsByfAO4gtv5eebpHZWvC6yDR06BiQRQEhb1nh
         Q5C/5K4R56bcKKB3VMP8VvHqlgc6vwxQd5G+8LT/8+rqfe06TbYTj8elRQavXHlISnuU
         buZU4M/BQ89CbVUmDeA2tRcU/XUJtjocWczucEmAevX8aQNNDC9f/bfDQDHmGk48Ksbj
         osMy6/k1H7RfyMy82rLefcrO+cl6rJmY0yZXPihwrDy0Q0/1ebg5T2f4409AnVm75t9m
         4xRIgHdtxRwIkNrb/9bRbTvnwTFokfWesqLqYWrCBblF8paBq0t3NdF967D9ci6TBEI5
         FB+g==
X-Forwarded-Encrypted: i=1; AJvYcCVsjwjh9JikB8ERMeHNFZEPboa1uvscDquzY9ljMnDeim+SufqQXh845TjMoDYg/IooKSH2q2Z1tTKsI80=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFz3dWRKm6FHl51e3wNuY3B5AFgUttU7rPDJt5F758abKr6wd5
	3V6+T3d738enH4yei+BWfo9zO7HLjdc3cMbxS2O6229/mDQ95nupmpZyk89KSpNkZ5EC1zz2Tef
	TQRaEPRdgo4ZvoyRjOyX+0wfFcDBgQ2q9GY19xYyRvPLotsDSoCQJSLV3DgA=
X-Google-Smtp-Source: AGHT+IE2vxgjtkhomDGTHN4QekbTP1ZHZVl9nBTHjHvFAue1qwRSWoW+09Ps+eG8P4QclDD1KbUV0qR2kmzjZc8bNc4rvlY7BSTC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190c:b0:3e5:3a15:93ae with SMTP id
 e9e14a558f8ab-3e6765e28ecmr53592875ab.6.1755618152444; Tue, 19 Aug 2025
 08:42:32 -0700 (PDT)
Date: Tue, 19 Aug 2025 08:42:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a49b68.050a0220.e29e5.00ca.GAE@google.com>
Subject: [syzbot] [ntfs3?] KASAN: stack-out-of-bounds Write in filemap_get_entry
From: syzbot <syzbot+3d4a7c1cd1446719a55a@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8742b2d8935f Merge tag 'pull-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1379ac34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=13f39c6a0380a209
dashboard link: https://syzkaller.appspot.com/bug?extid=3d4a7c1cd1446719a55a
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/47aace7570df/disk-8742b2d8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/989b90a9e8b2/vmlinux-8742b2d8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cdfe3946040e/bzImage-8742b2d8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3d4a7c1cd1446719a55a@syzkaller.appspotmail.com

loop3: detected capacity change from 0 to 4096
==================================================================
BUG: KASAN: stack-out-of-bounds in filemap_get_entry+0xa1/0x2f0 mm/filemap.c:1865
Write of size 24 at addr ffffc9000c5e7740 by task syz.3.520/9784

CPU: 1 UID: 0 PID: 9784 Comm: syz.3.520 Tainted: G        W           6.17.0-rc1-syzkaller-00016-g8742b2d8935f #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G[  478.477403][ T9784] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x2b0/0x2c0 mm/kasan/generic.c:189
 __asan_memset+0x22/0x50 mm/kasan/shadow.c:84
 filemap_get_entry+0xa1/0x2f0 mm/filemap.c:1865
 __filemap_get_folio+0x37/0xa40 mm/filemap.c:1916
 filemap_get_folio include/linux/pagemap.h:794 [inline]
 do_read_cache_folio+0x9e/0x560 mm/filemap.c:3917
 do_read_cache_page mm/filemap.c:4023 [inline]
 read_cache_page+0x5d/0x170 mm/filemap.c:4032
 read_mapping_page include/linux/pagemap.h:985 [inline]
 inode_read_data+0xa7/0x480 fs/ntfs3/inode.c:1054
 ntfs_fill_super+0x39c8/0x40b0 fs/ntfs3/super.c:1533
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1692
 vfs_get_tree+0x8f/0x2b0 fs/super.c:1815
 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3805
 do_mount fs/namespace.c:4133 [inline]
 __do_sys_mount fs/namespace.c:4344 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4321
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f162654038a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f16247a5e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f16247a5ef0 RCX: 00007f162654038a
RDX: 0000200000000100 RSI: 0000200000000140 RDI: 00007f16247a5eb0
RBP: 0000200000000100 R08: 00007f16247a5ef0 R09: 0000000003800011
R10: 0000000003800011 R11: 0000000000000246 R12: 0000200000000140
R13: 00007f16247a5eb0 R14: 000000000001f7a0 R15: 00002000000001c0
 </TASK>

The buggy address belongs to stack of task syz.3.520/9784
 and is located at offset 64 in frame:
 filemap_get_entry+0x0/0x2f0 mm/filemap.c:-1

This frame has 1 object:
 [32, 88) 'xas'

The buggy address belongs to a 8-page vmalloc region starting at 0xffffc9000c5e0000 allocated at copy_process+0x545/0x3ae0 kernel/fork.c:2004
The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x73bff
memcg:ffff888032963502
flags: 0x80000000000000(node=0|zone=1)
raw: 0080000000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff ffff888032963502
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2dc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_ZERO|__GFP_NOWARN), pid 9781, tgid 9781 (syz.3.520), ts 478064035811, free_ts 478008644692
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x2119/0x21b0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
 alloc_pages_mpol+0xd1/0x380 mm/mempolicy.c:2416
 alloc_frozen_pages_noprof mm/mempolicy.c:2487 [inline]
 alloc_pages_noprof+0xcf/0x1e0 mm/mempolicy.c:2507
 vm_area_alloc_pages mm/vmalloc.c:3642 [inline]
 __vmalloc_area_node mm/vmalloc.c:3720 [inline]
 __vmalloc_node_range_noprof+0x97d/0x12f0 mm/vmalloc.c:3893
 __vmalloc_node_noprof+0xc2/0x110 mm/vmalloc.c:3956
 alloc_thread_stack_node kernel/fork.c:311 [inline]
 dup_task_struct+0x3e7/0x860 kernel/fork.c:882
 copy_process+0x545/0x3ae0 kernel/fork.c:2004
 kernel_clone+0x224/0x7c0 kernel/fork.c:2605
 __do_sys_clone3 kernel/fork.c:2909 [inline]
 __se_sys_clone3+0x256/0x2d0 kernel/fork.c:2888
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 1231 tgid 1231 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xb59/0xce0 mm/page_alloc.c:2895
 vfree+0x2ad/0x470 mm/vmalloc.c:3434
 delayed_vfree_work+0x55/0x80 mm/vmalloc.c:3353
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffffc9000c5e7600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc9000c5e7680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc9000c5e7700: f1 f1 f1 f1 00 00 00 00 00 00 00 f3 f3 f3 f3 f3
                                                    ^
 ffffc9000c5e7780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc9000c5e7800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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


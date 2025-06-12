Return-Path: <linux-kernel+bounces-683146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4042CAD6991
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 09:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EBFE1BC3536
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 07:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2754A21CA14;
	Thu, 12 Jun 2025 07:51:36 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766FC220F47
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 07:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749714695; cv=none; b=BjDufhs9/rmvVG1pcru8Fwp6CCqDJj/u5BpYPJSOSfnPucJzS3pb4dcBoWlAiOAluJgPe6VzvD7D/FSoCn0spEUFRF+Pe6jmPlREkXPND3Slzmach75S8z0d5Q6cPkCIVUYy/W89JbNgC8RCGewzdTHG9zzfrorV0o9k+rU+4dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749714695; c=relaxed/simple;
	bh=w5TT4m3zfD2dx9uqkw4v8vvnrgDS+699AzjAa3fe/jQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Vf1uFD3ioQGgq5ZWAJwf5wv8+dMSftKtKMEI++x0jOf2rfWGRhyyQKCCCu2+Le6SH9OA8vo5OIIiH41aKShBz7RrtzI/MFT40ASgfEYEphEKKvDTrC+hKCqc/cVooyeyWE3X52Mi9BIqNWhvIQu8lQ/Qgl15cfIPzOtMTd/olWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-86f4e2434b6so74870939f.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 00:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749714692; x=1750319492;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9knaw7GofitXPZ55hQMX15kXFQFfgRboSJs3AOPvBX4=;
        b=hv1ODLPMEz7kKYklF8dLtGriIb5o1d0InOYwbuLxFXFdY1JdEJbR23UUw5uZxB9FzA
         RA2cCaPFIMsiBG1MJSK4slUXkoUEXdXS8CReUBeSmgfQQsESG/X/QlrLZTTV9ls+plTf
         UXVgRpQwFJuIn/hh2n45xZdlIJSNR3IlGWzyqDsoKP+NW6a4sXvIgNDgPjaS5e5R+dX3
         CiLQB9ksVv1mXPxEvX2KWCXgyO6r98wbaQG6Zt/5cLEoQMUc2CqruMj71Lh7A7+vYayK
         QafMfSJ6Lmh8frbD1nBIlJlObgXZPsUtdmfJNg0yGZfEwgmMf7SjDreSKuAfzmOP6V39
         MUHg==
X-Forwarded-Encrypted: i=1; AJvYcCXIHPM9+jQSdhXGUk70X3XlmwRNY1RnmjJZwIUL1OIoQKUikyf3G8BYz8Gjl4jL5tqOOrNh3jjPT00Qfzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3p/l4n8KmjnmcmdGDw3FiXFNTfJpOedcAB5jt+5MqH7nOO75j
	XH4xJ8MeJFtFf7+HR3MdG08X1VjZB3moFQNM928/ule4awEE5/0IRPdpfpxF64zatjL3kYereCB
	dxcQ9DiTu19YVRYZ8uO/sE+q5VtPddTX9Ho7FiZTF9nTNuvTIUM5kSHAIaRk=
X-Google-Smtp-Source: AGHT+IHoVHsOgSNEviLUbWX/wlDBWJ01H6UFiWyKW/8WyTGQ6OBmsnEpMKtZqoF0N9vRUEZNcgyBXw/0c8IT6xjhUaZ+ZSyZp3M9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b02:b0:3dd:f745:1c1a with SMTP id
 e9e14a558f8ab-3ddfa80c119mr33154425ab.4.1749714692658; Thu, 12 Jun 2025
 00:51:32 -0700 (PDT)
Date: Thu, 12 Jun 2025 00:51:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <684a8704.a00a0220.1eb5f5.00fb.GAE@google.com>
Subject: [syzbot] [bcachefs?] KASAN: slab-use-after-free Read in bch2_bucket_alloc_trans
From: syzbot <syzbot+2887a13a5c387e616a68@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    19a60293b992 Add linux-next specific files for 20250611
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15eb660c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=76ed3656d7159e27
dashboard link: https://syzkaller.appspot.com/bug?extid=2887a13a5c387e616a68
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102f4e0c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178f460c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c453c11565fa/disk-19a60293.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4034ded42b2e/vmlinux-19a60293.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5355903cdb8f/bzImage-19a60293.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e4f3a815594e/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2887a13a5c387e616a68@syzkaller.appspotmail.com

    need_inc_gen         0
    dirty_sectors        256
    stripe_sectors       0
    cached_sectors       0
    stripe               0
    stripe_redundancy    0
    io_time[READ]        0
    io_time[WRITE]       0
    fragmentation     0
    bp_start          8
  
  incorrectly set at freespace:0:30:0 (free 0, genbits 0 should be 0), fixing
==================================================================
BUG: KASAN: slab-use-after-free in bch2_bucket_alloc_trans+0x1aa0/0x2410 fs/bcachefs/alloc_foreground.c:547
Read of size 8 at addr ffff88802fe9fd20 by task kworker/u8:5/1153

CPU: 0 UID: 0 PID: 1153 Comm: kworker/u8:5 Not tainted 6.16.0-rc1-next-20250611-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: btree_node_rewrite async_btree_node_rewrite_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xd2/0x2b0 mm/kasan/report.c:521
 kasan_report+0x118/0x150 mm/kasan/report.c:634
 bch2_bucket_alloc_trans+0x1aa0/0x2410 fs/bcachefs/alloc_foreground.c:547
 bch2_bucket_alloc_set_trans+0x5a6/0xe70 fs/bcachefs/alloc_foreground.c:728
 __open_bucket_add_buckets+0x1437/0x1e40 fs/bcachefs/alloc_foreground.c:925
 open_bucket_add_buckets+0x2ee/0x440 fs/bcachefs/alloc_foreground.c:957
 bch2_alloc_sectors_start_trans+0xd26/0x1e80 fs/bcachefs/alloc_foreground.c:-1
 __bch2_btree_node_alloc fs/bcachefs/btree_update_interior.c:318 [inline]
 bch2_btree_reserve_get+0x618/0x1510 fs/bcachefs/btree_update_interior.c:526
 bch2_btree_update_start+0x147e/0x1dc0 fs/bcachefs/btree_update_interior.c:1261
 bch2_btree_node_rewrite+0x17e/0x1120 fs/bcachefs/btree_update_interior.c:2236
 bch2_btree_node_rewrite_key fs/bcachefs/btree_update_interior.c:2302 [inline]
 async_btree_node_rewrite_work+0x370/0x840 fs/bcachefs/btree_update_interior.c:2359
 process_one_work kernel/workqueue.c:3235 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3318
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3399
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 1153:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4328 [inline]
 __kmalloc_node_track_caller_noprof+0x271/0x4e0 mm/slub.c:4347
 __do_krealloc mm/slub.c:4905 [inline]
 krealloc_noprof+0x124/0x340 mm/slub.c:4958
 __bch2_trans_kmalloc+0x26c/0xc80 fs/bcachefs/btree_iter.c:3187
 bch2_trans_kmalloc_nomemzero_ip fs/bcachefs/btree_iter.h:586 [inline]
 bch2_trans_kmalloc_nomemzero fs/bcachefs/btree_iter.h:621 [inline]
 bch2_alloc_sectors_start_trans+0x1d59/0x1e80 fs/bcachefs/alloc_foreground.c:1250
 __bch2_btree_node_alloc fs/bcachefs/btree_update_interior.c:318 [inline]
 bch2_btree_reserve_get+0x618/0x1510 fs/bcachefs/btree_update_interior.c:526
 bch2_btree_update_start+0x147e/0x1dc0 fs/bcachefs/btree_update_interior.c:1261
 bch2_btree_node_rewrite+0x17e/0x1120 fs/bcachefs/btree_update_interior.c:2236
 bch2_btree_node_rewrite_key fs/bcachefs/btree_update_interior.c:2302 [inline]
 async_btree_node_rewrite_work+0x370/0x840 fs/bcachefs/btree_update_interior.c:2359
 process_one_work kernel/workqueue.c:3235 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3318
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3399
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 1153:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2381 [inline]
 slab_free mm/slub.c:4643 [inline]
 kfree+0x18e/0x440 mm/slub.c:4842
 krealloc_noprof+0x1cd/0x340 mm/slub.c:-1
 __bch2_trans_kmalloc+0x26c/0xc80 fs/bcachefs/btree_iter.c:3187
 bch2_trans_kmalloc_nomemzero_ip fs/bcachefs/btree_iter.h:586 [inline]
 bch2_trans_kmalloc_nomemzero fs/bcachefs/btree_iter.h:621 [inline]
 __bch2_trans_subbuf_alloc+0x2da/0x460 fs/bcachefs/btree_update.c:557
 bch2_trans_subbuf_alloc fs/bcachefs/btree_update.h:148 [inline]
 bch2_trans_jset_entry_alloc fs/bcachefs/btree_update.h:168 [inline]
 __bch2_trans_log_str fs/bcachefs/btree_update.c:814 [inline]
 bch2_trans_log_str+0xd5/0x3c0 fs/bcachefs/btree_update.c:827
 __bch2_fsck_err+0xc11/0xfb0 fs/bcachefs/error.c:625
 bch2_check_discard_freespace_key+0x71b/0xce0 fs/bcachefs/alloc_background.c:1436
 try_alloc_bucket fs/bcachefs/alloc_foreground.c:272 [inline]
 bch2_bucket_alloc_freelist fs/bcachefs/alloc_foreground.c:420 [inline]
 bch2_bucket_alloc_trans+0x1333/0x2410 fs/bcachefs/alloc_foreground.c:544
 bch2_bucket_alloc_set_trans+0x5a6/0xe70 fs/bcachefs/alloc_foreground.c:728
 __open_bucket_add_buckets+0x1437/0x1e40 fs/bcachefs/alloc_foreground.c:925
 open_bucket_add_buckets+0x2ee/0x440 fs/bcachefs/alloc_foreground.c:957
 bch2_alloc_sectors_start_trans+0xd26/0x1e80 fs/bcachefs/alloc_foreground.c:-1
 __bch2_btree_node_alloc fs/bcachefs/btree_update_interior.c:318 [inline]
 bch2_btree_reserve_get+0x618/0x1510 fs/bcachefs/btree_update_interior.c:526
 bch2_btree_update_start+0x147e/0x1dc0 fs/bcachefs/btree_update_interior.c:1261
 bch2_btree_node_rewrite+0x17e/0x1120 fs/bcachefs/btree_update_interior.c:2236
 bch2_btree_node_rewrite_key fs/bcachefs/btree_update_interior.c:2302 [inline]
 async_btree_node_rewrite_work+0x370/0x840 fs/bcachefs/btree_update_interior.c:2359
 process_one_work kernel/workqueue.c:3235 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3318
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3399
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88802fe9fc00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 288 bytes inside of
 freed 512-byte region [ffff88802fe9fc00, ffff88802fe9fe00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2fe9c
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801a441c80 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801a441c80 0000000000000000 dead000000000001
head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffea0000bfa701 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5210, tgid 5210 (udevd), ts 52772311742, free_ts 47887520110
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1704
 prep_new_page mm/page_alloc.c:1712 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3669
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:4959
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2419
 alloc_slab_page mm/slub.c:2451 [inline]
 allocate_slab+0x8a/0x3b0 mm/slub.c:2619
 new_slab mm/slub.c:2673 [inline]
 ___slab_alloc+0xbfc/0x1480 mm/slub.c:3859
 __slab_alloc mm/slub.c:3949 [inline]
 __slab_alloc_node mm/slub.c:4024 [inline]
 slab_alloc_node mm/slub.c:4185 [inline]
 __kmalloc_cache_noprof+0x296/0x3d0 mm/slub.c:4354
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 kernfs_fop_open+0x397/0xca0 fs/kernfs/file.c:623
 do_dentry_open+0xdf3/0x1970 fs/open.c:964
 vfs_open+0x3b/0x340 fs/open.c:1094
 do_open fs/namei.c:3887 [inline]
 path_openat+0x2ee5/0x3830 fs/namei.c:4046
 do_filp_open+0x1fa/0x410 fs/namei.c:4073
 do_sys_openat2+0x121/0x1c0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5220 tgid 5220 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1248 [inline]
 __free_frozen_pages+0xc71/0xe70 mm/page_alloc.c:2706
 __slab_free+0x326/0x400 mm/slub.c:4554
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4148 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4204
 getname_flags+0xb8/0x540 fs/namei.c:146
 getname include/linux/fs.h:2905 [inline]
 do_sys_openat2+0xbc/0x1c0 fs/open.c:1431
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88802fe9fc00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802fe9fc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802fe9fd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff88802fe9fd80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802fe9fe00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


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


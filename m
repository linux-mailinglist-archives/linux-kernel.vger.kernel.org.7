Return-Path: <linux-kernel+bounces-836317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06355BA94FA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC893A83B4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF33307499;
	Mon, 29 Sep 2025 13:20:33 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9F0304BB9
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759152033; cv=none; b=bvFAKLGqcy05F2T1kNJqJwcGasL27fXnGlmXYMkScINf+fc+B07y27WB1SYNltoXqHxi2yFgfX9WtnNufA74VKyvvRnOvbS8gy8YeGyv1V2DI9Uq5zXqub7YrI9ahkoof6Ebp8+yLwf/dUnUM3HCsNboRC/7toRKwNBWI5PpYiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759152033; c=relaxed/simple;
	bh=HKvZIGOqeIUYVMj1cGxHXLowe+1ZVaTDkOdiAtCaC5Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pAm3dSwnk7647k0p1hS2kE751xk61KUO3XoOEMUzqReplogpgoYVIWhL8EQ+c1qb80L9a5XnCEqJAJ5m5eKYjVm0N3chJA0Iww9v72CLbsRCxJ8JQY1yEfEWq2g/qUA2TPl2au5mDRg0CS/I2NDOLEwWJe7Kx20amm4ys1DdTro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-4257ae42790so71041435ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759152031; x=1759756831;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Bal2VsMjT21p0Tev5bkNqFCC3htaywVSwOGlI/eF8k=;
        b=vwDpZetJ/njvtWkl8EWAIUKlRILlsu2KwFfEwUBV3BxqYaMbEZEPlSDLNpFBM5gwr4
         j//k3UGAv0F4R3u3ehrKFdl4EthPqpaCLgcYkXgpMUzhGRVGfNkfw9G2rguJEaqVm/8j
         OhTO8KeEQrkrqGK5K77sjQRz6trCOHoomWFPKUOKtqeAXUaNTd3f0hQ2gFN4vgtMiFHn
         aR0EtrM3DsxMBacUz8dIDDpIS/NFIKFO0+SUmQPMRdi7HqXjtP82j8HztJhH5F4ckrUp
         e6i1ouhcyivqUJAJrfzAJ1Wn9h48whjTQS1nHPRGogvc2AWT8NlWo31CBbNPJhWouy/k
         rwdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBt8w+sJ5F/tpfdKpvYXK+jDyfXzfdKf6HEl6p4XdxAfB2UlY2rkNaswPxq+LMMMmGsMDkqEDD+lltys4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc8lPGudenZemJIEJJ01DBOvL1P7Z6XMdNPnC1ND7rxTojWl2I
	upkOgkceP9dPJLo/Qy7YDtxO6xa9radODF+0zTXreJn+i+cxFztXGykxmenfCxLMc+RfZgiic8p
	/oQR7fpwsoRFomtVDc1DT+oHPwpmnpDGJpDJMW5bCZd2rzMkTLpqNQTMitOc=
X-Google-Smtp-Source: AGHT+IF49mKEf6oY8K0ieqzEI1UGwX4+WzFRiyqsEaAgrcuyPlEeovuu+LEqZfjKxiHCJ83WnykxYsFj+CJPit+JGHDAbCyKG3Ue
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca45:0:b0:429:5f74:3bad with SMTP id
 e9e14a558f8ab-4295f83a1c9mr100261555ab.30.1759152030672; Mon, 29 Sep 2025
 06:20:30 -0700 (PDT)
Date: Mon, 29 Sep 2025 06:20:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68da879e.050a0220.1696c6.0016.GAE@google.com>
Subject: [syzbot] [jfs?] KASAN: slab-use-after-free Read in lbmIODone
From: syzbot <syzbot+ecf51a7ccb6b1394e90c@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0f3be52b8e37 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17509ce2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=714d45b6135c308e
dashboard link: https://syzkaller.appspot.com/bug?extid=ecf51a7ccb6b1394e90c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a2c3b345c3da/disk-0f3be52b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/54368457365a/vmlinux-0f3be52b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3544cf9b3f24/Image-0f3be52b.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ecf51a7ccb6b1394e90c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in lbmIODone+0xf68/0x12e8 fs/jfs/jfs_logmgr.c:2184
Read of size 4 at addr ffff0000fa465408 by task ksoftirqd/1/23

CPU: 1 UID: 0 PID: 23 Comm: ksoftirqd/1 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 print_address_description+0xa8/0x238 mm/kasan/report.c:378
 print_report+0x68/0x84 mm/kasan/report.c:482
 kasan_report+0xb0/0x110 mm/kasan/report.c:595
 __asan_report_load4_noabort+0x20/0x2c mm/kasan/report_generic.c:380
 lbmIODone+0xf68/0x12e8 fs/jfs/jfs_logmgr.c:2184
 bio_endio+0x858/0x894 block/bio.c:1651
 blk_update_request+0x474/0xba8 block/blk-mq.c:989
 blk_mq_end_request+0x54/0x88 block/blk-mq.c:1151
 lo_complete_rq+0x124/0x274 drivers/block/loop.c:314
 blk_complete_reqs block/blk-mq.c:1226 [inline]
 blk_done_softirq+0x11c/0x168 block/blk-mq.c:1231
 handle_softirqs+0x328/0xc88 kernel/softirq.c:579
 run_ksoftirqd+0x70/0xc0 kernel/softirq.c:968
 smpboot_thread_fn+0x4d8/0x9cc kernel/smpboot.c:160
 kthread+0x5fc/0x75c kernel/kthread.c:463
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844

Allocated by task 6893:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:68
 kasan_save_alloc_info+0x44/0x54 mm/kasan/generic.c:562
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0x9c/0xb4 mm/kasan/common.c:405
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x2a4/0x3fc mm/slub.c:4407
 kmalloc_noprof include/linux/slab.h:905 [inline]
 lbmLogInit fs/jfs/jfs_logmgr.c:1822 [inline]
 lmLogInit+0x690/0x1a9c fs/jfs/jfs_logmgr.c:1270
 open_inline_log fs/jfs/jfs_logmgr.c:1175 [inline]
 lmLogOpen+0x41c/0xd5c fs/jfs/jfs_logmgr.c:1069
 jfs_mount_rw+0xe4/0x548 fs/jfs/jfs_mount.c:257
 jfs_fill_super+0x5d4/0xb6c fs/jfs/super.c:532
 get_tree_bdev_flags+0x360/0x414 fs/super.c:1692
 get_tree_bdev+0x2c/0x3c fs/super.c:1715
 jfs_get_tree+0x28/0x38 fs/jfs/super.c:635
 vfs_get_tree+0x90/0x28c fs/super.c:1815
 do_new_mount+0x278/0x7f4 fs/namespace.c:3808
 path_mount+0x5b4/0xde0 fs/namespace.c:4123
 do_mount fs/namespace.c:4136 [inline]
 __do_sys_mount fs/namespace.c:4347 [inline]
 __se_sys_mount fs/namespace.c:4324 [inline]
 __arm64_sys_mount+0x3e8/0x468 fs/namespace.c:4324
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x5c/0x254 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:763
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

Freed by task 6536:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:68
 kasan_save_free_info+0x58/0x70 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x74/0x98 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2422 [inline]
 slab_free mm/slub.c:4695 [inline]
 kfree+0x17c/0x474 mm/slub.c:4894
 lbmLogShutdown fs/jfs/jfs_logmgr.c:1865 [inline]
 lmLogShutdown+0x36c/0x700 fs/jfs/jfs_logmgr.c:1684
 lmLogClose+0x244/0x4c4 fs/jfs/jfs_logmgr.c:1460
 jfs_umount+0x26c/0x350 fs/jfs/jfs_umount.c:114
 jfs_put_super+0x90/0x188 fs/jfs/super.c:194
 generic_shutdown_super+0x12c/0x2b8 fs/super.c:643
 kill_block_super+0x44/0x90 fs/super.c:1766
 deactivate_locked_super+0xc4/0x12c fs/super.c:474
 deactivate_super+0xe0/0x100 fs/super.c:507
 cleanup_mnt+0x31c/0x3ac fs/namespace.c:1375
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1382
 task_work_run+0x1dc/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xfc/0x168 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 arm64_exit_to_user_mode arch/arm64/kernel/entry-common.c:103 [inline]
 el0_svc+0x170/0x254 arch/arm64/kernel/entry-common.c:745
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:763
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

The buggy address belongs to the object at ffff0000fa465400
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 8 bytes inside of
 freed 192-byte region [ffff0000fa465400, ffff0000fa4654c0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x13a465
flags: 0x5ffc00000000000(node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 05ffc00000000000 ffff0000c00013c0 fffffdffc3070180 0000000000000004
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000fa465300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff0000fa465380: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
>ffff0000fa465400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff0000fa465480: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff0000fa465500: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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


Return-Path: <linux-kernel+bounces-729518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4040FB037D2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59EF5189B15A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 07:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A4D234984;
	Mon, 14 Jul 2025 07:23:36 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2929B23315A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752477815; cv=none; b=sZ+VFjSXwz0xgMb5HoHIAuWKdVEfuwyWOPPHjFZjx5kpuOUroAQ1Nl9NG5E27YDENqMXOuzVWVGq+Gjt+qgzxu13YjRYsetaYLK/iogbVI8iVHAFi1flUPzIMLyXUv9vI42WbQzs4kT5VUd8RjOJ00+kVj85zKHnV8RvhYeEidA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752477815; c=relaxed/simple;
	bh=MDOumUOfD+Sbutdy+OHKt6Pfy+ObnjIh6kPNXIC9umw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rMG2OGPP2aM+RWmplFuFUVEih8FowplGMVDuAXsi8VjxleI5pXVSZBJuqysGqO2n6nv9rNc4UYeFCyZYnnv9kOXZ5IQVNzMPDQy9xInRhQ24Yj3ir7u1tdvM7nkJfL2ajmaNmg+BRTwbYlF2HRE/w5pyCuxi7VUXzIVXmKaNKOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-86cf89ff625so359906639f.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752477813; x=1753082613;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TbX0TanH8ZujVRSZDU1r+4wCCvFPrFiZx4j6cqySHSs=;
        b=HWsL2iKEye/W2P/uW4HBLwNJh5hnH65W2qWE04Kz6LFGa38Kl/miFHbMp2NrqrFT0v
         uqb79dIjMwH76qMhup+cV1slx79An1Wm9CDTig+/aXhp0yuzlN3V9TZNUzo4VKxMlLUg
         UjOg+OyuSKrccQwDq1EhYE+NbcflyIZXT6xWTIUjRe7sn6+b4nhQPVbgK3Z9wNR5e1YX
         myjPQOFf8Psz27fDoEhbIBrN2921vn3xW18vseHPgO5FWTWhuxlAZZchplrJiOQ+sEcv
         Q6Ntpvcz4xYTl6B9slgHjwP4YNBKWJhWg3xntlQKapV3d5VdoSVri/4/gtP1LZ+C6LpU
         ZcSg==
X-Gm-Message-State: AOJu0YxdAXSTHofcN0Lw+5hQPWZ4KPONk5q5m3BmENHUpPaTlNjBcMWO
	WbG7hiPl64yHkzpfyoWaOSCKWJfAGfmKa46iX/e6O/QgpoalpOF1N2lRSCQcgMAuhh3KP8+V5vc
	yMsyhAcdUl80ayW6rGvIzxY/5OVAVafacy2uVr2qOyoX19nf7IGsfuvi2PDh4ng==
X-Google-Smtp-Source: AGHT+IGidUOieKSn2EKNqHmhJRDs7xfSo8g2NzJd7t9AklKkdFIYcjKAgkDR/0o5E44FVamiZEH16rrHVklVADqZrqZnhcOZAmkO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6b8b:b0:875:ba1e:4d7e with SMTP id
 ca18e2360f4ac-879787dd810mr1367573639f.6.1752477813237; Mon, 14 Jul 2025
 00:23:33 -0700 (PDT)
Date: Mon, 14 Jul 2025 00:23:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6874b075.a70a0220.3b380f.004c.GAE@google.com>
Subject: [syzbot] [media?] KASAN: vmalloc-out-of-bounds Write in
 tpg_fill_plane_buffer (4)
From: syzbot <syzbot+dac8f5eaa46837e97b89@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	mchehab@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d006330be3f7 Merge tag 'sound-6.16-rc6' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=100c4a8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b309c907eaab29da
dashboard link: https://syzkaller.appspot.com/bug?extid=dac8f5eaa46837e97b89
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a7742a7d4ef9/disk-d006330b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cab6a3e4daf1/vmlinux-d006330b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ba08de346f9a/bzImage-d006330b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dac8f5eaa46837e97b89@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in tpg_fill_plane_pattern drivers/media/common/v4l2-tpg/v4l2-tpg-core.c:-1 [inline]
BUG: KASAN: vmalloc-out-of-bounds in tpg_fill_plane_buffer+0x1b9b/0x5ec0 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c:2705
Write of size 1280 at addr ffffc9000d6bcb40 by task vivid-000-vid-c/13312

CPU: 0 UID: 0 PID: 13312 Comm: vivid-000-vid-c Not tainted 6.16.0-rc5-syzkaller-00025-gd006330be3f7 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xd2/0x2b0 mm/kasan/report.c:521
 kasan_report+0x118/0x150 mm/kasan/report.c:634
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x2b0/0x2c0 mm/kasan/generic.c:189
 __asan_memcpy+0x40/0x70 mm/kasan/shadow.c:106
 tpg_fill_plane_pattern drivers/media/common/v4l2-tpg/v4l2-tpg-core.c:-1 [inline]
 tpg_fill_plane_buffer+0x1b9b/0x5ec0 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c:2705
 vivid_fillbuff drivers/media/test-drivers/vivid/vivid-kthread-cap.c:470 [inline]
 vivid_thread_vid_cap_tick+0xfff/0x5fd0 drivers/media/test-drivers/vivid/vivid-kthread-cap.c:629
 vivid_thread_vid_cap+0x8da/0x10d0 drivers/media/test-drivers/vivid/vivid-kthread-cap.c:767
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

The buggy address belongs to the virtual mapping at
 [ffffc9000d6b9000, ffffc9000d6be000) created by:
 vb2_vmalloc_alloc+0xef/0x340 drivers/media/common/videobuf2/videobuf2-vmalloc.c:47

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x340ad
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2dc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_ZERO|__GFP_NOWARN), pid 13311, tgid 13309 (syz.2.1746), ts 561160274327, free_ts 561138068490
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1704
 prep_new_page mm/page_alloc.c:1712 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3669
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:4959
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2419
 alloc_frozen_pages_noprof mm/mempolicy.c:2490 [inline]
 alloc_pages_noprof+0xa9/0x190 mm/mempolicy.c:2510
 vm_area_alloc_pages mm/vmalloc.c:3634 [inline]
 __vmalloc_area_node mm/vmalloc.c:3712 [inline]
 __vmalloc_node_range_noprof+0x97d/0x12f0 mm/vmalloc.c:3885
 vmalloc_user_noprof+0xad/0xf0 mm/vmalloc.c:4038
 vb2_vmalloc_alloc+0xef/0x340 drivers/media/common/videobuf2/videobuf2-vmalloc.c:47
 __vb2_buf_mem_alloc drivers/media/common/videobuf2/videobuf2-core.c:242 [inline]
 __vb2_queue_alloc+0x9bf/0x15a0 drivers/media/common/videobuf2/videobuf2-core.c:523
 vb2_core_reqbufs+0xc31/0x1420 drivers/media/common/videobuf2/videobuf2-core.c:964
 __vb2_init_fileio+0x318/0xff0 drivers/media/common/videobuf2/videobuf2-core.c:2895
 vb2_core_poll+0x4c1/0x840 drivers/media/common/videobuf2/videobuf2-core.c:2729
 vb2_poll drivers/media/common/videobuf2/videobuf2-v4l2.c:979 [inline]
 vb2_fop_poll+0x168/0x380 drivers/media/common/videobuf2/videobuf2-v4l2.c:1244
 v4l2_poll+0x144/0x2c0 drivers/media/v4l2-core/v4l2-dev.c:350
 vfs_poll include/linux/poll.h:82 [inline]
 do_pollfd fs/select.c:870 [inline]
 do_poll fs/select.c:913 [inline]
 do_sys_poll+0x8c6/0x1070 fs/select.c:1009
 __do_sys_ppoll fs/select.c:1115 [inline]
 __se_sys_ppoll+0x1ff/0x260 fs/select.c:1095
page last free pid 23 tgid 23 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1248 [inline]
 __free_frozen_pages+0xc71/0xe70 mm/page_alloc.c:2706
 pagetable_free include/linux/mm.h:2879 [inline]
 pagetable_dtor_free include/linux/mm.h:2977 [inline]
 __tlb_remove_table+0x2d2/0x3b0 include/asm-generic/tlb.h:220
 __tlb_remove_table_free mm/mmu_gather.c:227 [inline]
 tlb_remove_table_rcu+0x85/0x100 mm/mmu_gather.c:290
 rcu_do_batch kernel/rcu/tree.c:2576 [inline]
 rcu_core+0xca8/0x1710 kernel/rcu/tree.c:2832
 handle_softirqs+0x286/0x870 kernel/softirq.c:579
 run_ksoftirqd+0x9b/0x100 kernel/softirq.c:968
 smpboot_thread_fn+0x53f/0xa60 kernel/smpboot.c:164
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffffc9000d6bcf00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc9000d6bcf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc9000d6bd000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                   ^
 ffffc9000d6bd080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc9000d6bd100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
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


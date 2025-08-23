Return-Path: <linux-kernel+bounces-782858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF920B3261D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 03:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69894AE430D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 01:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C696017A2EC;
	Sat, 23 Aug 2025 01:09:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8693013BC3F
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 01:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755911347; cv=none; b=j62QK+AEMrW8lLn+ECPBKTqjDKQ8Izm1rXPe+MY8g1HMyjQmq833AEKpOyuR4LF6UdFg2qjyRV592EIJL3jPZcF/pEu3gpFsvVNKAiuunq20vVKNZNVAoYpVrfqSAm26FqhO89W/zngaIXTO3MIOdUNakjnafCgJKW+8lszLo4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755911347; c=relaxed/simple;
	bh=odnOril9ScLB8K/45m5I/w8p1M6v+jfdYpf0O8sDKg8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BiEqhawbBpvUmdzaFPEtePVCfVvuaZXbiZ4UhpwwtznL99kWarZWA+yB0pZ/2a1k7qqj7SbwWxzgEeO6lXEiXp/OXWsH2o34Vq5rfOlywBZP02m8ztz0fBKrEfLodl7H+hwLh4mfqhR3Jfk0HnA0xOvXWCceipSp3TO0VTmuhPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3e6688959easo23320575ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 18:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755911344; x=1756516144;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=76KpbvCww3SU5ISfwI7dxRCKj9cQP7bZk1EccDwIHvM=;
        b=EKPbNdNYP85aVwp9QS/MqXaT7iyfkGn70s/GTHUzxCY0nHz7SV+8pLsKaLL7ToV2oa
         IOi5mGXPpkrk/hZ+/INP4vMCJ+yKJpJCQzI3mdCESiJ9H14kgpFWwDFh8yPCBEn+bcxz
         Ek78zAKCA+OrL1z0GTDUXheAU+l18+Vy6eG54Ci75b8ggnwdey+BN7HlM5Jf6LlOiVt5
         klkqdstn44Prpp0JTr0XR8MAOHbaubLRlUOfEbP4qLI19HPi8A5U2MRTHC0cAhJUQ6iU
         dlmZwMwO5mbEBmXqjlUa8KCWQhSfxrfi1AeIqrwPJqrAfMbZTdZs+rDCSUxXe/OV3qBp
         xxrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAKmpwf8GrLh6/FF9f+JGaNQuxDEe6f4xfyRmlNtFyYs7kEHhxKg96rb/+j3ft9GHUUIzyFG5CMXd4gAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvJBgwWdsy27lTdnhKXVtuS5ApDmjl5BOKTU9l0a4okImo0mJG
	1v74WjtWbM8rlHvMUa5uk5o61/M7xngAn5xv2Lqy3BJrCgNmjVIpbUBuKKP2LvLzXEwfsns6RXE
	DTdCzq7dfsXjU8qQyS73KzYWDmXBt1kLYvsazJDWYEjv5yy1+lOZDcoMfu5Q=
X-Google-Smtp-Source: AGHT+IHtNdl5VXqPSkwaM2urHW6uZpUMdcv1s3HskG0bkB5UjR46xWkio1FZpdUiROMn995MwlsRcWF9adxJl6M9BXmRTaIal99J
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17cc:b0:3e2:9977:bebb with SMTP id
 e9e14a558f8ab-3e921a5c7bamr73084145ab.13.1755911344694; Fri, 22 Aug 2025
 18:09:04 -0700 (PDT)
Date: Fri, 22 Aug 2025 18:09:04 -0700
In-Reply-To: <tencent_2BECEECECC7B926C782CC96EB897BCE8DE0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a914b0.a00a0220.33401d.02f1.GAE@google.com>
Subject: Re: [syzbot] [erofs?] KASAN: global-out-of-bounds Read in z_erofs_decompress_queue
From: syzbot <syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: invalid-free in z_erofs_scan_folio

erofs (device loop0): mounted with root inode @ nid 36.
erofs (device loop0): readahead error at folio 7 @ nid 36
erofs (device loop0): readahead error at folio 6 @ nid 36
erofs (device loop0): readahead error at folio 5 @ nid 36
erofs (device loop0): readahead error at folio 4 @ nid 36
erofs (device loop0): readahead error at folio 3 @ nid 36
==================================================================
BUG: KASAN: invalid-free in z_erofs_free_pcluster fs/erofs/zdata.c:281 [inline]
BUG: KASAN: invalid-free in z_erofs_register_pcluster fs/erofs/zdata.c:804 [inline]
BUG: KASAN: invalid-free in z_erofs_pcluster_begin fs/erofs/zdata.c:840 [inline]
BUG: KASAN: invalid-free in z_erofs_scan_folio+0x1e4a/0x4540 fs/erofs/zdata.c:1056
Free of addr ffff8880565609d8 by task syz.0.17/6607

CPU: 1 UID: 0 PID: 6607 Comm: syz.0.17 Tainted: G        W           syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report_invalid_free+0xea/0x110 mm/kasan/report.c:557
 check_slab_allocation+0xe1/0x130 include/linux/page-flags.h:-1
 kasan_slab_pre_free include/linux/kasan.h:198 [inline]
 slab_free_hook mm/slub.c:2362 [inline]
 slab_free mm/slub.c:4680 [inline]
 kmem_cache_free+0x146/0x510 mm/slub.c:4782
 z_erofs_free_pcluster fs/erofs/zdata.c:281 [inline]
 z_erofs_register_pcluster fs/erofs/zdata.c:804 [inline]
 z_erofs_pcluster_begin fs/erofs/zdata.c:840 [inline]
 z_erofs_scan_folio+0x1e4a/0x4540 fs/erofs/zdata.c:1056
 z_erofs_readahead+0x672/0xb40 fs/erofs/zdata.c:1922
 read_pages+0x177/0x580 mm/readahead.c:160
 page_cache_ra_unbounded+0x63b/0x740 mm/readahead.c:297
 page_cache_sync_readahead include/linux/pagemap.h:1369 [inline]
 erofs_readdir+0x567/0x1020 fs/erofs/dir.c:77
 iterate_dir+0x3a2/0x580 fs/readdir.c:108
 __do_sys_getdents fs/readdir.c:326 [inline]
 __se_sys_getdents+0xe4/0x250 fs/readdir.c:312
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2826aaebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2826116038 EFLAGS: 00000246 ORIG_RAX: 000000000000004e
RAX: ffffffffffffffda RBX: 00007f2826cd5fa0 RCX: 00007f2826aaebe9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f2826b31e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f2826cd6038 R14: 00007f2826cd5fa0 R15: 00007ffd944ac938
 </TASK>

Allocated by task 6607:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:330 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:356
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4180 [inline]
 slab_alloc_node mm/slub.c:4229 [inline]
 kmem_cache_alloc_noprof+0x143/0x310 mm/slub.c:4236
 z_erofs_alloc_pcluster fs/erofs/zdata.c:262 [inline]
 z_erofs_register_pcluster fs/erofs/zdata.c:749 [inline]
 z_erofs_pcluster_begin fs/erofs/zdata.c:840 [inline]
 z_erofs_scan_folio+0x162e/0x4540 fs/erofs/zdata.c:1056
 z_erofs_readahead+0x672/0xb40 fs/erofs/zdata.c:1922
 read_pages+0x177/0x580 mm/readahead.c:160
 page_cache_ra_unbounded+0x63b/0x740 mm/readahead.c:297
 page_cache_sync_readahead include/linux/pagemap.h:1369 [inline]
 erofs_readdir+0x567/0x1020 fs/erofs/dir.c:77
 iterate_dir+0x3a2/0x580 fs/readdir.c:108
 __do_sys_getdents fs/readdir.c:326 [inline]
 __se_sys_getdents+0xe4/0x250 fs/readdir.c:312
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880565609d8
 which belongs to the cache erofs_pcluster-128 of size 2392
The buggy address is located 0 bytes inside of
 2392-byte region [ffff8880565609d8, ffff888056561330)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x56560
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x80000000000040(head|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000040 ffff88802030f000 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800d000d 00000000f5000000 0000000000000000
head: 0080000000000040 ffff88802030f000 dead000000000122 0000000000000000
head: 0000000000000000 00000000800d000d 00000000f5000000 0000000000000000
head: 0080000000000003 ffffea0001595801 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0xd2050(__GFP_RECLAIMABLE|__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 6607, tgid 6606 (syz.0.17), ts 171069705490, free_ts 99313462986
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x2119/0x21b0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
 alloc_pages_mpol+0xd1/0x380 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:2487 [inline]
 allocate_slab+0x8a/0x370 mm/slub.c:2655
 new_slab mm/slub.c:2709 [inline]
 ___slab_alloc+0x8d1/0xdd0 mm/slub.c:3891
 __slab_alloc mm/slub.c:3981 [inline]
 __slab_alloc_node mm/slub.c:4056 [inline]
 slab_alloc_node mm/slub.c:4217 [inline]
 kmem_cache_alloc_noprof+0xe6/0x310 mm/slub.c:4236
 z_erofs_alloc_pcluster fs/erofs/zdata.c:262 [inline]
 z_erofs_register_pcluster fs/erofs/zdata.c:749 [inline]
 z_erofs_pcluster_begin fs/erofs/zdata.c:840 [inline]
 z_erofs_scan_folio+0x162e/0x4540 fs/erofs/zdata.c:1056
 z_erofs_readahead+0x672/0xb40 fs/erofs/zdata.c:1922
 read_pages+0x177/0x580 mm/readahead.c:160
 page_cache_ra_unbounded+0x63b/0x740 mm/readahead.c:297
 page_cache_sync_readahead include/linux/pagemap.h:1369 [inline]
 erofs_readdir+0x567/0x1020 fs/erofs/dir.c:77
 iterate_dir+0x3a2/0x580 fs/readdir.c:108
 __do_sys_getdents fs/readdir.c:326 [inline]
 __se_sys_getdents+0xe4/0x250 fs/readdir.c:312
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5917 tgid 5917 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xb59/0xce0 mm/page_alloc.c:2895
 vfree+0x2ad/0x470 mm/vmalloc.c:3434
 kcov_put kernel/kcov.c:439 [inline]
 kcov_close+0x2e/0x60 kernel/kcov.c:535
 __fput+0x45b/0xa80 fs/file_table.c:468
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x6b5/0x2300 kernel/exit.c:961
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1102
 get_signal+0x125e/0x1310 kernel/signal.c:3034
 arch_do_signal_or_restart+0x9a/0x750 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x75/0x110 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888056560880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888056560900: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
>ffff888056560980: fc fc fc fc fc fc fc fc fc fc fc 00 00 00 00 00
                                                    ^
 ffff888056560a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888056560a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


Tested on:

commit:         6debb690 Merge tag 'drm-fixes-2025-08-23-1' of https:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=111d8062580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
dashboard link: https://syzkaller.appspot.com/bug?extid=5a398eb460ddaa6f242f
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14ce8c42580000



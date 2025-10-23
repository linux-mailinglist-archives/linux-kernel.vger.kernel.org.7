Return-Path: <linux-kernel+bounces-867604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8147C0317E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6C3B3A1884
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701B9328621;
	Thu, 23 Oct 2025 18:55:33 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4D635B120
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761245732; cv=none; b=XSTRwLlp2aaPMXblwE0M1UaKfUH6JqhjS4VkMjH6yKJ/K38Lkhf7tCENbmTmKSEu99yz4M+QNnAVYsAT/l3uIHaihHBtZKHlWMZD5jMVGToYEuI4zGXTwcgtXz4hRMdmO61z2Dqt+mTuwv1GJANjk6+EAnMKADaIrm2lBiMEHcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761245732; c=relaxed/simple;
	bh=yq3fanGmV11jU/mTbRRO7PUNLRK6U75NWpB6IhGAv3U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZjuUbUdeiGMHhKb7LL0V7knaTCJZzeTy7tDzdL1MgOO6gv5Wlbh1mOlDZcMkDDHyDQkVerjnX57hoL5o+iiG8GWSGQmPQfU7beCrla977x8OH61lifHo8n0QKM8yFesXkIhoVZhScrMBE9JKGjMZSm4hP1Pu2vk5W6DVINfPi50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-430d0cf9b85so48246445ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761245730; x=1761850530;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yp64SrrNyXr3IOcihuQQ34InSrPi6D2nab+6v3l0xWw=;
        b=vltoBd4hof/2UDU3EKXEqChknArG/iQ9U746C4obctYk/UCm6qI7oqoteHPHBvy1Fp
         S5DJSGApu38aew+oyWGM560IdAfYOu44d2w3I7O5/Xa9O5Acg/sc0ty8FP19NJdKn6tP
         PjZzT+PAyjHyiEPe8jJqHwjhH1bV6WZ7vbpYD2hm57r3ys68NGIklfiBH5SDS9/tGjme
         xgof3oABxwy9xt1yppUv+C14+M485Lb3z53Uq+I0j6DqEPlgV0tD85A5xHkaVIs+I8Ah
         GAxYb/Gi7tFOhW+azZWheiZnVvopPnfZQw53j0zYlAYYXSdKHN19NqLGvVbM0ihUhHei
         Sh6g==
X-Forwarded-Encrypted: i=1; AJvYcCX220/8nwWF53djg32AJ/aCLiXM1gjqDAnsel8Ue9f6j3AtRHjfxNXQNOCEAMIiVTZb8n9rfdyY4/cqBx8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx72luEjtQ51MVhKH2oqdwzcdHFwgf+b+zP5+k5ki8yUy6+4VG+
	ZYt+InKzNoMQD9eIgQZrtU+AaizB43ZhQF92ZrjWFgM/RL9QCh/RLxX7EF9+3acvX7i3D73dSYz
	T/apxBnhXAAT6UNDVFf1o7nl1mV2csqdIHwcg5TZUZWvUqm4L3OQFpnrjIX0=
X-Google-Smtp-Source: AGHT+IGDBUj//uEB+mOzZuEVbCWygJXGr/WGmYXx4gzmIneq2Ac0cYajUm9g1Ozki+1doQu7K3v5++muMLZe96MzAv21GhkIwGwP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c05:b0:430:ac49:b3b1 with SMTP id
 e9e14a558f8ab-430c5247174mr418277835ab.12.1761245730181; Thu, 23 Oct 2025
 11:55:30 -0700 (PDT)
Date: Thu, 23 Oct 2025 11:55:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fa7a22.a70a0220.3bf6c6.008b.GAE@google.com>
Subject: [syzbot] [kvm?] KASAN: slab-use-after-free Write in kvm_gmem_release
From: syzbot <syzbot+2479e53d0db9b32ae2aa@syzkaller.appspotmail.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    aaa9c3550b60 Add linux-next specific files for 20251022
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1021c3e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ad8f5526e5acd067
dashboard link: https://syzkaller.appspot.com/bug?extid=2479e53d0db9b32ae2aa
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10dd0c92580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1152c614580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2fe0a8f92a64/disk-aaa9c355.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/199d2e804802/vmlinux-aaa9c355.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9371d55e359e/bzImage-aaa9c355.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2479e53d0db9b32ae2aa@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in kvm_gmem_release+0x176/0x440 virt/kvm/guest_memfd.c:353
Write of size 8 at addr ffff88807befa508 by task syz.0.17/6022

CPU: 0 UID: 0 PID: 6022 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 kvm_gmem_release+0x176/0x440 virt/kvm/guest_memfd.c:353
 __fput+0x44c/0xa70 fs/file_table.c:468
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xe9/0x130 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbeeff8efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffffdf1e2c8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007fbef01e7da0 RCX: 00007fbeeff8efc9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007fbef01e7da0 R08: 0000000000000000 R09: 00000004fdf1e5bf
R10: 00007fbef01e7cb0 R11: 0000000000000246 R12: 0000000000019ff7
R13: 00007ffffdf1e3c0 R14: ffffffffffffffff R15: 00007ffffdf1e3e0
 </TASK>

Allocated by task 6023:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 poison_kmalloc_redzone mm/kasan/common.c:397 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:414
 kasan_kmalloc include/linux/kasan.h:262 [inline]
 __kmalloc_cache_noprof+0x3e2/0x700 mm/slub.c:5758
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 kvm_set_memory_region+0x747/0xb90 virt/kvm/kvm_main.c:2104
 kvm_vm_ioctl_set_memory_region+0x6f/0xd0 virt/kvm/kvm_main.c:2154
 kvm_vm_ioctl+0x957/0xc60 virt/kvm/kvm_main.c:5201
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6023:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2533 [inline]
 slab_free mm/slub.c:6622 [inline]
 kfree+0x19a/0x6d0 mm/slub.c:6829
 kvm_set_memory_region+0x9c4/0xb90 virt/kvm/kvm_main.c:2130
 kvm_vm_ioctl_set_memory_region+0x6f/0xd0 virt/kvm/kvm_main.c:2154
 kvm_vm_ioctl+0x957/0xc60 virt/kvm/kvm_main.c:5201
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88807befa400
 which belongs to the cache kmalloc-cg-512 of size 512
The buggy address is located 264 bytes inside of
 freed 512-byte region [ffff88807befa400, ffff88807befa600)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7bef8
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888077513701
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88813fe30140 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000100010 00000000f5000000 ffff888077513701
head: 00fff00000000040 ffff88813fe30140 0000000000000000 dead000000000001
head: 0000000000000000 0000000000100010 00000000f5000000 ffff888077513701
head: 00fff00000000002 ffffea0001efbe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5203, tgid 5203 (udevd), ts 35020479428, free_ts 30283368313
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x2365/0x2440 mm/page_alloc.c:3920
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5214
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2418
 alloc_slab_page mm/slub.c:3049 [inline]
 allocate_slab+0x96/0x3a0 mm/slub.c:3222
 new_slab mm/slub.c:3276 [inline]
 ___slab_alloc+0xe94/0x18a0 mm/slub.c:4646
 __slab_alloc+0x65/0x100 mm/slub.c:4765
 __slab_alloc_node mm/slub.c:4841 [inline]
 slab_alloc_node mm/slub.c:5263 [inline]
 __do_kmalloc_node mm/slub.c:5636 [inline]
 __kmalloc_node_track_caller_noprof+0x5d0/0x810 mm/slub.c:5746
 kmalloc_reserve+0x136/0x290 net/core/skbuff.c:604
 __alloc_skb+0x142/0x2d0 net/core/skbuff.c:673
 alloc_skb include/linux/skbuff.h:1383 [inline]
 alloc_skb_with_frags+0xca/0x890 net/core/skbuff.c:6685
 sock_alloc_send_pskb+0x84d/0x980 net/core/sock.c:2987
 unix_dgram_sendmsg+0x461/0x1850 net/unix/af_unix.c:2153
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:742
 sock_write_iter+0x279/0x360 net/socket.c:1195
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5c9/0xb30 fs/read_write.c:686
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc8/0xd30 mm/page_alloc.c:2948
 __free_pages mm/page_alloc.c:5333 [inline]
 free_contig_range+0x1bd/0x4a0 mm/page_alloc.c:7176
 destroy_args+0x69/0x660 mm/debug_vm_pgtable.c:958
 debug_vm_pgtable+0x39f/0x3b0 mm/debug_vm_pgtable.c:1345
 do_one_initcall+0x236/0x820 init/main.c:1283
 do_initcall_level+0x104/0x190 init/main.c:1345
 do_initcalls+0x59/0xa0 init/main.c:1361
 kernel_init_freeable+0x334/0x4b0 init/main.c:1593
 kernel_init+0x1d/0x1d0 init/main.c:1483
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff88807befa400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807befa480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807befa500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff88807befa580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807befa600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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


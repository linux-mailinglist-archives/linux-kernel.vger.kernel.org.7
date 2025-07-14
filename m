Return-Path: <linux-kernel+bounces-730551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37881B0462D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 19:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 418843B9477
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1EE264612;
	Mon, 14 Jul 2025 17:09:34 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469FB2609F7
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 17:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752512974; cv=none; b=URZKh9VCP57y0yRzPy9dX5MZnhbeP7GgRm3riHCfP59gjvz7qx+R/MWW30KWMa6HfdRDPjCO8fC1rTGxKAx48GtvF6OVDs5RprihXcsaitu8kSNYR4onHpldSLWW9eyxsN3Ykkkgj1H1zbSmi+RCYFQqUahOrIklvvhHgvkIVuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752512974; c=relaxed/simple;
	bh=AoYcGZMRKn774E02RpjgqBq806G5BNmE8J7tHutpv78=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZCqtfM6p0v7wMrAty8iH6IBBt355EQvEYTThZQCNV4MEcYTRtxXKwaA3kh4g/eH346Ec5uiA2hIY5783P/rbiY6WzGEpQfIiKZPyJsu76EVmBoYTgw07MWNQ84fS33foKSbpyv3CR8kdcP3xF2WPsYiEuZM5zYKInLf75ZUX6zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-876afa8b530so504843239f.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752512971; x=1753117771;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ph4jwtVPUY38p2br9m/79m3kUk8POab4D/QRBPRr/uY=;
        b=qwxdCKmQ713XbyO8X7obPmV8lY6h/RuqAybRkTig+5mHWdTY46XSglovzDnLP2pDY5
         MCh8kct6llZnybd+dl+RJH+ckJfmFMsMAA9UeSWFMuhKB6tiA9bY+upg/8N7/BDESZUW
         ZSTK5VYy5z5CzGaw9OkiOS/10Gj6jEzikWdKuEwsC8NfXiiLbxmDUw2+s4IEsc6xBNmn
         yKbWRkPH8AgVHmOKPLVsqXEHswqGwTyXEj3cq54GN00z/RrbHdD1CKEz7S8RdBJnccWa
         tpaAIzfPn2MHtju5pscvy6/VUbpM+A7pFTaRJ4sKSV/3q2zM0ZcbACj/SfCURrUCJh4s
         8pkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTt8LAcCgFMXl/JvzAN8pj85SGfKrojUMY/YX72swbbnmB4HQmDChQpTu7TGts21xAi/wvkYo1X7aj62E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZzJ71TaiHodnJuZAcgnAaC0KFHTaGktvXkdhcB9g8YdLV/8gg
	D50I44HqR/4i39kuMZX6aL/1A3+yQHMQAhTwEJ53hSj9ICErdVemEgRiZTSvWDjFggggxnj/Lum
	5ezyWeHw7LU3CaB/4pdA4WMAUMHa+t75Xg+lm+KAsUWCumcjfHoV7Jfr7dbY=
X-Google-Smtp-Source: AGHT+IFZdc52eJhvwKb+D6XHgS/ZI3aYVyMikJlI3OhRdWsiEdoTqDXSkHHnj9t8WGOc8SqONfbnlB0xh5+JUa/TSbGSQGB3iW6c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:60c6:b0:86a:84f:7a45 with SMTP id
 ca18e2360f4ac-87977f8bfa8mr1510833139f.8.1752512971430; Mon, 14 Jul 2025
 10:09:31 -0700 (PDT)
Date: Mon, 14 Jul 2025 10:09:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687539cb.a70a0220.18f9d4.0005.GAE@google.com>
Subject: [syzbot] [bluetooth?] [bcachefs?] KASAN: slab-use-after-free Read in hci_uart_write_work
From: syzbot <syzbot+fde6bd779f78e6e0992e@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3f31a806a62e Merge tag 'mm-hotfixes-stable-2025-07-11-16-1..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=174b07d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b309c907eaab29da
dashboard link: https://syzkaller.appspot.com/bug?extid=fde6bd779f78e6e0992e
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=127ece8c580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-3f31a806.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7304d62ced97/vmlinux-3f31a806.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4913df6ab730/bzImage-3f31a806.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/bb03f46b9e61/mount_5.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fde6bd779f78e6e0992e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in hci_uart_write_work+0x2ca/0x550 drivers/bluetooth/hci_ldisc.c:165
Read of size 8 at addr ffff8880555a35d8 by task kworker/0:7/5631

CPU: 0 UID: 0 PID: 5631 Comm: kworker/0:7 Not tainted 6.16.0-rc5-syzkaller-00266-g3f31a806a62e #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events hci_uart_write_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x230 mm/kasan/report.c:480
 kasan_report+0x118/0x150 mm/kasan/report.c:593
 hci_uart_write_work+0x2ca/0x550 drivers/bluetooth/hci_ldisc.c:165
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 54:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4148 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 kmem_cache_alloc_node_noprof+0x1bb/0x3c0 mm/slub.c:4249
 __alloc_skb+0x112/0x2d0 net/core/skbuff.c:660
 alloc_skb include/linux/skbuff.h:1336 [inline]
 h5_prepare_pkt+0x184/0x530 drivers/bluetooth/hci_h5.c:702
 h5_dequeue+0x197/0x790 drivers/bluetooth/hci_h5.c:761
 hci_uart_dequeue drivers/bluetooth/hci_ldisc.c:107 [inline]
 hci_uart_write_work+0x24a/0x550 drivers/bluetooth/hci_ldisc.c:161
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff8880555a3500
 which belongs to the cache skbuff_head_cache of size 240
The buggy address is located 216 bytes inside of
 freed 240-byte region [ffff8880555a3500, ffff8880555a35f0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x555a3
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000000 ffff8880304e0b40 dead000000000100 dead000000000122
raw: 0000000000000000 00000000000c000c 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5474, tgid 5474 (syz-executor), ts 183992405509, free_ts 181552341552
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
 kmem_cache_alloc_node_noprof+0x280/0x3c0 mm/slub.c:4249
 __alloc_skb+0x112/0x2d0 net/core/skbuff.c:660
 alloc_skb include/linux/skbuff.h:1336 [inline]
 nlmsg_new include/net/netlink.h:1041 [inline]
 inet_netconf_notify_devconf+0x173/0x240 net/ipv4/devinet.c:2210
 __devinet_sysctl_register+0x3f6/0x470 net/ipv4/devinet.c:2684
 devinet_sysctl_register+0x187/0x200 net/ipv4/devinet.c:2718
 inetdev_init+0x2b4/0x500 net/ipv4/devinet.c:291
 inetdev_event+0x301/0x15b0 net/ipv4/devinet.c:1591
 notifier_call_chain+0x1b3/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
 call_netdevice_notifiers net/core/dev.c:2282 [inline]
 register_netdevice+0x1608/0x1ae0 net/core/dev.c:11143
 team_newlink+0x114/0x160 drivers/net/team/team_core.c:2231
page last free pid 5407 tgid 5407 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1248 [inline]
 __free_frozen_pages+0xc71/0xe70 mm/page_alloc.c:2706
 vfree+0x25a/0x400 mm/vmalloc.c:3434
 kcov_put kernel/kcov.c:439 [inline]
 kcov_close+0x28/0x50 kernel/kcov.c:535
 __fput+0x449/0xa70 fs/file_table.c:465
 task_work_run+0x1d1/0x260 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x6b5/0x22e0 kernel/exit.c:964
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1105
 get_signal+0x1286/0x1340 kernel/signal.c:3034
 arch_do_signal_or_restart+0x9a/0x750 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x75/0x110 kernel/entry/common.c:111
 exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880555a3480: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
 ffff8880555a3500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880555a3580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
                                                    ^
 ffff8880555a3600: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
 ffff8880555a3680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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


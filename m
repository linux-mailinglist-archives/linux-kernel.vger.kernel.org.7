Return-Path: <linux-kernel+bounces-731007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E34B04D73
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 03:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF8D3B8B39
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 01:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167C21B6CE9;
	Tue, 15 Jul 2025 01:31:09 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB06085260
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 01:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752543068; cv=none; b=Odgsdi+0yDKrmhJKkk+/7ScQjbAQ6u1Ct5Z2Ct90G0xZpSAvix8oAC/PJLk+iKmeOaPj677s9C2+pEFOGhi1I4InjdAjHBI5pmFnY21TwdK1A/U4/fa77E/eS2gNKYg0nC6pMLzwrQYLt8hLdDw0dvypzAc1O1LMwpNHXibT1GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752543068; c=relaxed/simple;
	bh=1HfN/hbVvIALqmF9hQLJNDZDbzEy0PetiYHfUdFspBc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TNxkVWW/FZnqFWNxuUci3+c3/y8LTPoRultMWrY/nGeN8izzUUKq8JRCShiBjsMPgLPfqnVaQdQQHX1VDuZ1twbXv7+brIfnesLRvCEHWoEYWZv8iXhSSExYbeaZADzjbwmvFHw7kgTGQ7JY6g8hCYDdCegsweuRFZPWqTmk2JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-86a5def8869so994210739f.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 18:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752543066; x=1753147866;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ulqc7cO4LCB9hZN4vo6VOQUr/x1HMcGgJBERTs4OHXY=;
        b=wxURaMrk8meyJ0N0XZt9Swzy/Z9F2IJE0+aVrArKbe7gs3TBD0zLru68T9H/Dkmw+O
         7aEzn4jMeIYGjBjFVX2AlJxA1wm+lGpE0dJntQFDyxJYLhKdAHPJ+jNJdiOpIwu2f5R1
         K7T7foTRQYw4gFAYJ9iBaEdJVnwIvRtOyHBhJvY4gEzvnZTFdcC+NEEZ4/2lfZ3fk83m
         DUsMllT7tENwSjtVuc40Tns0AP6NHpVDawkzKGogkzvWNHWnqLK29zPAd4/n98SBGyC0
         MlH0Lfd+PU3Xqd5AybCmd75XOOkKEx8R06PmhwiakV4csqS8Tls+NWJk5xstAwpnWGGe
         E6Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUAxAO2Psx1SVmVP4gJqWEeJlBFQUP2v1UxJ20rzXyJmsxYhNza3gJp7rdQRFNvFGegh9mfkqypa7c58P4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7wX/voe99u3vhnA2EmLBQVKMHdl5XDcvheRF9qYC19YK9Je9+
	ULmUTC+LCZbQYMiObtFv+SJihDby6Kh22C/BHNErBvsXEaT0iA4oYwSjEoPsJhHo6I19+GsfhIn
	bz/bKL9vHJ+rB6dGujFOYkTL5lNrNvkgmftwQL985flApfAIEuADetwZPias=
X-Google-Smtp-Source: AGHT+IF2W0XA8VqE8lg4fnYCKQxbTVlqntwzzKeG+ZQ4SjIwCBDOwUKSEjRo5DPOWGKALKI3ewUUsoK6i99j2Zw82fujXgHAOEdA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c95:b0:861:d8ca:3587 with SMTP id
 ca18e2360f4ac-87977f7198dmr1907365839f.4.1752543066100; Mon, 14 Jul 2025
 18:31:06 -0700 (PDT)
Date: Mon, 14 Jul 2025 18:31:06 -0700
In-Reply-To: <20250715010923.4075-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6875af5a.a70a0220.5f69f.0006.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] [bcachefs?] KASAN: slab-use-after-free Read
 in hci_uart_write_work
From: syzbot <syzbot+fde6bd779f78e6e0992e@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in hci_uart_write_work

==================================================================
BUG: KASAN: slab-use-after-free in hci_uart_write_work+0x337/0x5c0 drivers/bluetooth/hci_ldisc.c:166
Read of size 8 at addr ffff888011e31c18 by task kworker/0:8/6224

CPU: 0 UID: 0 PID: 6224 Comm: kworker/0:8 Not tainted 6.16.0-rc6-syzkaller-g347e9f5043c8-dirty #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events hci_uart_write_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x230 mm/kasan/report.c:480
 kasan_report+0x118/0x150 mm/kasan/report.c:593
 hci_uart_write_work+0x337/0x5c0 drivers/bluetooth/hci_ldisc.c:166
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 55:
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
 hci_uart_write_work+0x2ad/0x5c0 drivers/bluetooth/hci_ldisc.c:162
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff888011e31b40
 which belongs to the cache skbuff_head_cache of size 240
The buggy address is located 216 bytes inside of
 freed 240-byte region [ffff888011e31b40, ffff888011e31c30)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11e31
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801bef7b40 dead000000000100 dead000000000122
raw: 0000000000000000 00000000000c000c 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5346, tgid 5346 (syz-executor), ts 93020059691, free_ts 92682760557
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1704
 prep_new_page mm/page_alloc.c:1712 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3669
 __alloc_pages_slowpath+0x2fe/0xce0 mm/page_alloc.c:4490
 __alloc_frozen_pages_noprof+0x319/0x370 mm/page_alloc.c:4972
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
 inet6_rt_notify+0x165/0x430 net/ipv6/route.c:6334
 fib6_del_route net/ipv6/ip6_fib.c:2058 [inline]
 fib6_del+0x1094/0x1550 net/ipv6/ip6_fib.c:2093
 fib6_clean_node+0x29f/0x590 net/ipv6/ip6_fib.c:2255
 fib6_walk_continue+0x67b/0x910 net/ipv6/ip6_fib.c:2177
 fib6_walk+0x149/0x290 net/ipv6/ip6_fib.c:2225
 fib6_clean_tree net/ipv6/ip6_fib.c:2305 [inline]
 __fib6_clean_all+0x234/0x380 net/ipv6/ip6_fib.c:2321
 rt6_sync_down_dev net/ipv6/route.c:5004 [inline]
 rt6_disable_ip+0x120/0x720 net/ipv6/route.c:5009
page last free pid 5360 tgid 5360 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1248 [inline]
 __free_frozen_pages+0xc71/0xe70 mm/page_alloc.c:2706
 discard_slab mm/slub.c:2717 [inline]
 __put_partials+0x161/0x1c0 mm/slub.c:3186
 put_cpu_partial+0x17c/0x250 mm/slub.c:3261
 __slab_free+0x2f7/0x400 mm/slub.c:4513
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4148 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 __do_kmalloc_node mm/slub.c:4327 [inline]
 __kmalloc_noprof+0x224/0x4f0 mm/slub.c:4340
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 tomoyo_encode2 security/tomoyo/realpath.c:45 [inline]
 tomoyo_encode+0x28b/0x550 security/tomoyo/realpath.c:80
 tomoyo_mount_acl security/tomoyo/mount.c:150 [inline]
 tomoyo_mount_permission+0x44d/0x970 security/tomoyo/mount.c:237
 security_sb_mount+0xec/0x350 security/security.c:1570
 path_mount+0xbc/0xfe0 fs/namespace.c:4168
 do_mount fs/namespace.c:4239 [inline]
 __do_sys_mount fs/namespace.c:4450 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4427
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888011e31b00: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
 ffff888011e31b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888011e31c00: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
                            ^
 ffff888011e31c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888011e31d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc
==================================================================


Tested on:

commit:         347e9f50 Linux 6.16-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15a770f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f62a2ef17395702a
dashboard link: https://syzkaller.appspot.com/bug?extid=fde6bd779f78e6e0992e
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12e00382580000



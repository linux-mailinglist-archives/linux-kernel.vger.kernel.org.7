Return-Path: <linux-kernel+bounces-784841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A07B3424E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E773C179A63
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7281275AED;
	Mon, 25 Aug 2025 13:51:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FBBA927
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129865; cv=none; b=O0T9UE68S6TwVNUwN7NvD01hSlzJstw1ulhSdWTuWwuzMFw5i0S94bq5tzDMqKonBUhi5Ups82Jqa2gW2fh0XQVcdchJxS45IB+bQvGPGpVHlYatFA3zZRlgpAidHhIRkNALJlHS+qUz2qeihZzzFYvOoIhTSy1M6YpJoMUWZac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129865; c=relaxed/simple;
	bh=rtQJZw0gEJuyehtbQbmSKucNHl1wH7VH9OE5FP3pxRw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YdGsBCBVxCYB7xvpuhHeFQoPdBycgGWU0grzglJl3DPtP/uLLGUPxtDv5TpLfGIsm8YdVuZgLZJiapIKpgZ8P2TlgA16OAxcKLgxbc0P39zfbPXIMfRcXYNvg6iZihUAEl9HyoHM6hMMpauDRXD10FuI5UpvD0doIvRs/cyDXfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-88432e1d004so408594639f.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 06:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756129862; x=1756734662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+/ZZkB1ZLyEpOKeQLt+6AMcK17R5UZO5DTg9n0+xomY=;
        b=GARpsEwkTE1cQToK+ykn1+QibKSTw0wI0KdIws/pd4oJTmbKMWwB5W1l4oioVJ0QGo
         ut7YWI2Bp9xmvf33PGvuT6CjgwhoZEua8p6X2pJ0duzPsL6F0FjdzqAruN4SnhcJR5Ma
         6PxuHujgS5ALIbZt02hG+m5TikIWdT38/kCwenBNXwlEaFwcwdC44fuuCHeiZWCthw4F
         ZyrRA1ahVFzZ7D/s7EatocdmM/Qi2KwEQLM5cctjt409a7RtZ+xVvIUiThRw+fXC0hvs
         S8oD1eeql0sI9uJxm96Fkp2hrxjAF+Lx6wzTqGQY9l4kp1CLbpecrJXPsMBKhuWjdcPO
         CTMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeblyLVUtuGuYGwhUBw9Ya342qxpkgcx7Rl0aapf8ZOcXOfR3KhSySfXxZg1lVBBl/mJ3eMxdDJcGX/qM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3ELqLjDb2BCqpYQBa/DBOYWV13Yppb/2nke14mOzVRjh7mGIP
	xYUcaQX70cn9Gf+Ak08grG1bE8Zazkh7EWiGbJIJMFmcCsu9fk7f+S3yGiG1GknpMnMFUiN+i/P
	MSZUnQfLF0c0n9mf9YYDy8bZY88cqn7FMKOg0SsBca4FGYNLkMN2qggoyEic=
X-Google-Smtp-Source: AGHT+IG9aEYyqTBc5X/SrKeEokeoqAENPDCZWc3lEDqES4Y2/R9JjGkDYjeBtJwj+efpOAHVjcWgWKjFXlJJqGcjfgkd/JONRk78
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2582:b0:3ed:256a:d680 with SMTP id
 e9e14a558f8ab-3ed256ad943mr37017855ab.13.1756129862726; Mon, 25 Aug 2025
 06:51:02 -0700 (PDT)
Date: Mon, 25 Aug 2025 06:51:02 -0700
In-Reply-To: <20250825123519.5453-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ac6a46.a70a0220.303e5.0004.GAE@google.com>
Subject: Re: [syzbot] [net?] unregister_netdevice: waiting for DEV to become
 free (8)
From: syzbot <syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: use-after-free Read in j1939_netdev_stop

==================================================================
BUG: KASAN: use-after-free in read_pnet include/net/net_namespace.h:409 [inline]
BUG: KASAN: use-after-free in dev_net include/linux/netdevice.h:2718 [inline]
BUG: KASAN: use-after-free in j1939_can_rx_unregister net/can/j1939/main.c:202 [inline]
BUG: KASAN: use-after-free in __j1939_rx_release net/can/j1939/main.c:218 [inline]
BUG: KASAN: use-after-free in kref_put_mutex include/linux/kref.h:86 [inline]
BUG: KASAN: use-after-free in j1939_netdev_stop+0x2ab/0x2d0 net/can/j1939/main.c:311
Read of size 8 at addr ffff888023f80108 by task syz.0.17/6524

CPU: 0 UID: 0 PID: 6524 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcd/0x630 mm/kasan/report.c:482
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 read_pnet include/net/net_namespace.h:409 [inline]
 dev_net include/linux/netdevice.h:2718 [inline]
 j1939_can_rx_unregister net/can/j1939/main.c:202 [inline]
 __j1939_rx_release net/can/j1939/main.c:218 [inline]
 kref_put_mutex include/linux/kref.h:86 [inline]
 j1939_netdev_stop+0x2ab/0x2d0 net/can/j1939/main.c:311
 j1939_sk_release+0x5c3/0x8e0 net/can/j1939/socket.c:651
 __sock_release+0xb3/0x270 net/socket.c:649
 sock_close+0x1c/0x30 net/socket.c:1439
 __fput+0x402/0xb70 fs/file_table.c:468
 task_work_run+0x14d/0x240 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x86f/0x2bf0 kernel/exit.c:961
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1102
 get_signal+0x2673/0x26d0 kernel/signal.c:3034
 arch_do_signal_or_restart+0x8f/0x7d0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x84/0x110 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x3f6/0x4c0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f408338ebe9
Code: Unable to access opcode bytes at 0x7f408338ebbf.
RSP: 002b:00007f4084235038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: 0000000000000024 RBX: 00007f40835b5fa0 RCX: 00007f408338ebe9
RDX: 0000000000000000 RSI: 0000200000000200 RDI: 0000000000000003
RBP: 00007f4083411e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f40835b6038 R14: 00007f40835b5fa0 R15: 00007ffd085a2ed8
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888023f80000 pfn:0x23f80
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea000174f608 ffffea0000c2c208 0000000000000000
raw: ffff888023f80000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x446dc0(GFP_KERNEL_ACCOUNT|__GFP_ZERO|__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_COMP), pid 6440, tgid 6440 (syz-executor), ts 122667010586, free_ts 125938931446
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1c0/0x230 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x132b/0x38e0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x261/0x23f0 mm/page_alloc.c:5148
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2416
 ___kmalloc_large_node+0xed/0x160 mm/slub.c:4306
 __kmalloc_large_node_noprof+0x1c/0x70 mm/slub.c:4337
 __do_kmalloc_node mm/slub.c:4353 [inline]
 __kvmalloc_node_noprof.cold+0xb/0x65 mm/slub.c:5052
 alloc_netdev_mqs+0xd2/0x1530 net/core/dev.c:11812
 rtnl_create_link+0xc08/0xf90 net/core/rtnetlink.c:3633
 vxcan_newlink+0x2f8/0x640 drivers/net/can/vxcan.c:208
 rtnl_newlink_create net/core/rtnetlink.c:3825 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3942 [inline]
 rtnl_newlink+0xc45/0x2000 net/core/rtnetlink.c:4057
 rtnetlink_rcv_msg+0x95e/0xe90 net/core/rtnetlink.c:6946
 netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x5a7/0x870 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg net/socket.c:729 [inline]
 __sys_sendto+0x4a3/0x520 net/socket.c:2228
page last free pid 6524 tgid 6523 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0x7d5/0x10f0 mm/page_alloc.c:2895
 device_release+0xa1/0x240 drivers/base/core.c:2565
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1e7/0x5a0 lib/kobject.c:737
 netdev_run_todo+0x7e9/0x1320 net/core/dev.c:11513
 rtnl_unlock net/core/rtnetlink.c:157 [inline]
 rtnl_net_unlock include/linux/rtnetlink.h:135 [inline]
 rtnl_dellink+0x3da/0xa80 net/core/rtnetlink.c:3563
 rtnetlink_rcv_msg+0x95e/0xe90 net/core/rtnetlink.c:6946
 netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x5a7/0x870 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg net/socket.c:729 [inline]
 ____sys_sendmsg+0xa95/0xc70 net/socket.c:2614
 ___sys_sendmsg+0x134/0x1d0 net/socket.c:2668
 __sys_sendmsg+0x16d/0x220 net/socket.c:2700
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888023f80000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888023f80080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888023f80100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                      ^
 ffff888023f80180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888023f80200: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


Tested on:

commit:         1b237f19 Linux 6.17-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10b66862580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4703ac89d9e185a
dashboard link: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1417b862580000



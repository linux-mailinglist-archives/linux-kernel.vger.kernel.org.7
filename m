Return-Path: <linux-kernel+bounces-785860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5CEB351E1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 04:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC653B5DF5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 02:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80F028A1F1;
	Tue, 26 Aug 2025 02:48:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839012877D4
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756176487; cv=none; b=EbEPp27gOrDthTNzfCmihgi6IexXia0wwAnVpkswE8LpmxJREjofHSmRQ4Wy9IpMxFKuyb9/brTiPZd4iinnNbnDkSPkqt3B6ymcbjIRMJUVjKo18WlXjgVFyr/Yi6b5aSNu512tmVGezenGV0qqOPXNOGoi9axeYolflGIZ1bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756176487; c=relaxed/simple;
	bh=IN1a0yewUcS+IfDpY+MtN4m6Kum1Zp33/vix8ukorLo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SRjARVzt5FqO9kbDclmpJ2FKqHBOchPdBXTOHpFBCGWBWGFhEARVAov0but16a2BPYmSsrzENmGB5L0JcWf8mIttwHRQtCymFt4Gy+fqcIpoTuhr33vs5z/O+Lcc+Euu0iDvYUBA7UMWM5IKNZH39IgXw2ll0ulVBOLdlkzt2QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ee05b9a323so12842515ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 19:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756176484; x=1756781284;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6dVjRncimMYQRVsn/lRqwwRo7h4nLYoqygCKmIrs+go=;
        b=HvcgrutLSJYP4f5QArQn7r9DDTVwBsaNTBT5SGhjP2sBzPg7S1IhZ/HNs776IOm4Hu
         9AoTeW9Gy4mpiq9mpa4HmYTS6k06WDg9RBFXLjWBC4PkjcX95t4sXWHbpntLYQOY+4Pp
         RxTqzTV60QD5i9MGWapxZPtYxgjVazoKfosTf8EIfsc9mVHoznwsrmXREg0bLLtzplkt
         9vau8tOtvRLyv6EOseLfj/x0VwTe84IljZHhDNXTYWPXclpsLuiqSYkVNpDo9fnt53AH
         8hT7xcvIksfYnBW8dGBRKQmvOIZ79B3AEAJfGaIEnDi1glbPGVlifAXG5jko6Sp+JSBC
         ot5w==
X-Forwarded-Encrypted: i=1; AJvYcCWL7S/fRdLaigXVjKD2kH8XjxDvL0BRvX1APy4JrtOi6L6DgLyWW1i7O7f7l/vlA/fwtRXJQ0LJv2fFHAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWQhqa759EF+8xCfj/GrrpcRl8JlnvJ1IpyK7KOU32PqpsfEcL
	0wdbaRb2Le1R8YsI2mISUI52UOd2fdngluVRvqROTgwSuVO97c+8IHiZulEnoSusGd4t571H7Em
	BOZpZQSpx9vz/xDNLb2rmhO6v9ptUCES4qOpKwGhRGGqtukh2UV1U6e3hp5I=
X-Google-Smtp-Source: AGHT+IF3291bKt8EJF5/PoO2EP3BMtBN+sIDTft7rfL0/8/9XYfXJlCMR3rHEPVUQ7uRQSuHffFVAAWJhiXo7tcMkSAI+RsXn4SW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3813:b0:3ed:d368:48b0 with SMTP id
 e9e14a558f8ab-3eeb30f7886mr11442445ab.0.1756176484591; Mon, 25 Aug 2025
 19:48:04 -0700 (PDT)
Date: Mon, 25 Aug 2025 19:48:04 -0700
In-Reply-To: <20250826015036.5513-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ad2064.050a0220.37038e.00a0.GAE@google.com>
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
BUG: KASAN: use-after-free in netdev_get_ml_priv include/linux/netdevice.h:2692 [inline]
BUG: KASAN: use-after-free in can_get_ml_priv include/linux/can/can-ml.h:71 [inline]
BUG: KASAN: use-after-free in j1939_priv_set net/can/j1939/main.c:150 [inline]
BUG: KASAN: use-after-free in __j1939_rx_release net/can/j1939/main.c:221 [inline]
BUG: KASAN: use-after-free in kref_put_mutex include/linux/kref.h:86 [inline]
BUG: KASAN: use-after-free in j1939_netdev_stop+0x2df/0x320 net/can/j1939/main.c:312
Read of size 4 at addr ffff888062a506b0 by task syz.0.17/6467

CPU: 0 UID: 0 PID: 6467 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcd/0x630 mm/kasan/report.c:482
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 netdev_get_ml_priv include/linux/netdevice.h:2692 [inline]
 can_get_ml_priv include/linux/can/can-ml.h:71 [inline]
 j1939_priv_set net/can/j1939/main.c:150 [inline]
 __j1939_rx_release net/can/j1939/main.c:221 [inline]
 kref_put_mutex include/linux/kref.h:86 [inline]
 j1939_netdev_stop+0x2df/0x320 net/can/j1939/main.c:312
 j1939_sk_release+0x5c3/0x8e0 net/can/j1939/socket.c:651
 __sock_release+0xb0/0x270 net/socket.c:649
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
RIP: 0033:0x7f15b7b8ebe9
Code: Unable to access opcode bytes at 0x7f15b7b8ebbf.
RSP: 002b:00007f15b899d038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: 0000000000000024 RBX: 00007f15b7db5fa0 RCX: 00007f15b7b8ebe9
RDX: 0000000000000000 RSI: 0000200000000200 RDI: 0000000000000003
RBP: 00007f15b7c11e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f15b7db6038 R14: 00007f15b7db5fa0 R15: 00007ffec48e9178
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x62a50
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea0001db7008 ffffea00018a9208 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x446dc0(GFP_KERNEL_ACCOUNT|__GFP_ZERO|__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_COMP), pid 6357, tgid 6357 (syz-executor), ts 118494889601, free_ts 123112554125
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
 rtnetlink_rcv_msg+0x95b/0xe90 net/core/rtnetlink.c:6946
 netlink_rcv_skb+0x155/0x420 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg net/socket.c:729 [inline]
 __sys_sendto+0x4a0/0x520 net/socket.c:2228
page last free pid 6467 tgid 6466 stack trace:
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
 rtnetlink_rcv_msg+0x95b/0xe90 net/core/rtnetlink.c:6946
 netlink_rcv_skb+0x155/0x420 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg net/socket.c:729 [inline]
 ____sys_sendmsg+0xa98/0xc70 net/socket.c:2614
 ___sys_sendmsg+0x134/0x1d0 net/socket.c:2668
 __sys_sendmsg+0x16d/0x220 net/socket.c:2700
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888062a50580: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888062a50600: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888062a50680: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                     ^
 ffff888062a50700: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888062a50780: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


Tested on:

commit:         fab1beda Merge tag 'devicetree-fixes-for-6.17-1' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16049c42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4703ac89d9e185a
dashboard link: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=142de862580000



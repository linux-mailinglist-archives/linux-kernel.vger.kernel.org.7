Return-Path: <linux-kernel+bounces-875902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8ADC1A171
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F11A23BF478
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E0C32ED3A;
	Wed, 29 Oct 2025 11:35:08 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9192ECD37
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737707; cv=none; b=omCuDuo0FgHHQyz2w5jVl8+2ALaQ7gETYcwtPBgMG7Nd5iAgB4e90YWe4UZuInNvy/WMDzSBiUpVeZVO3hzeXC/Cd9Ob+grVjhhcimtDad47iROyDgbRb1fius+ihx8DSeJfMiwrdfwjomKhMiypw8owWsZCU2Z0UETymnYs17E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737707; c=relaxed/simple;
	bh=cycjCEmer8CF69McwOOJYETSxlUEifPjL3eEryiXWWs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aObmKj3yqUUHunVgW6pN+ID/mXvDl7Q/YOrMLjZFDDmLGMyY7GLUohHYHQDce/eL1GZL64KowWQVA2n9DvoYpMa4AwRdzZOWrnYAhhMqM8ELc2fKvCovUyhKnOK/Vs6QzLurmafUU8Mml2U9eFIPFtoiLCUFBun3aiSkADZbd1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430da49fb0aso197530545ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737703; x=1762342503;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x3ap6J21l7WRnVdZ+fP4h2wyxFYZwrCB+m43maOPG98=;
        b=NAbn0ViFGsl4N40W61bXMyhNhrlb216fVZWzEGAacNx2ajUQqsi8alHwyFSWr00fLi
         Vrkl/GhLQ9usYpYx9FxfkdQY+BxhMqEA0su29ACxW9sndn7rq6VeNb+dJPbjBXDFlMxZ
         3OV3c3795eZ7xCMI52SMpa8EEJzkVPFa2Qv2b3Y3tEwaVaTyJj+pqSBfm70r4CoPwkTR
         yyNevCno6xOmPlC9VgaPvfGnh5BV6awFkqqZTxR+CSv5ZnwUlALo8DFnjxgUTKQDFB4P
         8kXccwX2FQGinKCttYbZd+l6aQCLyFy2zZ7y+BRKWXcZSCAnI48oEcM/CN9/2s/czURp
         reGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1AT6Slvl6ilfgDiyK8tcPtRIU177ap407C4Rqaf/TtaVeYcIYVqWj2DHGwze5PfjlnC76yiH1rKQGN/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNiYm3cP7bfkzW24Ds6vQc0oOXIS2kdPi6Wukyk+MizIf/vi+P
	5xUTRC3dG7LxKEtkm6EIUQqiOyI7pgCBJ96+/Xtl0QeZ+tuDIgnTsgtDZHTiFzlQsxEsnyhWaPq
	KE7fBc3bYMoUtKyjobY9jJZEaODi/3Zy4E9CbgYeDqQPlXerZFOCUBq88Faw=
X-Google-Smtp-Source: AGHT+IHhkFGecbOljndc9gBDF4nmm+PlhncrG7Qcw7c4zhKIScLeCG1d5JpQU0EgjyjoL+ZhS5biDPXFmyZMmwRAvVpnmx0T9gBy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:c:b0:430:a8c5:fdad with SMTP id
 e9e14a558f8ab-432f8f8719dmr36160185ab.6.1761737703397; Wed, 29 Oct 2025
 04:35:03 -0700 (PDT)
Date: Wed, 29 Oct 2025 04:35:03 -0700
In-Reply-To: <20251029062155.ZlWxZ%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901fbe7.050a0220.3344a1.041d.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: slab-use-after-free Read in ocfs2_fault
From: syzbot <syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: signed-integer-overflow in ip_idents_reserve

================================================================================
UBSAN: signed-integer-overflow in ./arch/x86/include/asm/atomic.h:165:11
1495198172 + 1093622763 cannot be represented in type 'int'
CPU: 0 PID: 7104 Comm: syz-executor Not tainted syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <IRQ>
 dump_stack+0xfd/0x16e lib/dump_stack.c:118
 ubsan_epilogue+0xa/0x30 lib/ubsan.c:148
 handle_overflow+0x192/0x1b0 lib/ubsan.c:180
 arch_atomic_add_return arch/x86/include/asm/atomic.h:165 [inline]
 atomic_add_return include/asm-generic/atomic-instrumented.h:73 [inline]
 ip_idents_reserve+0x14a/0x170 net/ipv4/route.c:521
 __ip_select_ident+0xe4/0x1c0 net/ipv4/route.c:538
 iptunnel_xmit+0x466/0x7b0 net/ipv4/ip_tunnel_core.c:80
 udp_tunnel_xmit_skb+0x1ba/0x290 net/ipv4/udp_tunnel_core.c:190
 geneve_xmit_skb drivers/net/geneve.c:1004 [inline]
 geneve_xmit+0x1d05/0x2140 drivers/net/geneve.c:1117
 __netdev_start_xmit include/linux/netdevice.h:4824 [inline]
 netdev_start_xmit include/linux/netdevice.h:4838 [inline]
 xmit_one net/core/dev.c:3601 [inline]
 dev_hard_start_xmit+0x294/0x780 net/core/dev.c:3617
 __dev_queue_xmit+0x1678/0x28b0 net/core/dev.c:4203
 neigh_output include/net/neighbour.h:509 [inline]
 ip6_finish_output2+0x1020/0x1490 net/ipv6/ip6_output.c:130
 NF_HOOK+0x45/0x2c0 include/linux/netfilter.h:297
 mld_sendpack+0x5f9/0xa70 net/ipv6/mcast.c:1676
 mld_send_cr net/ipv6/mcast.c:1972 [inline]
 mld_ifc_timer_expire+0x7e1/0x990 net/ipv6/mcast.c:2471
 call_timer_fn+0x105/0x440 kernel/time/timer.c:1444
 expire_timers kernel/time/timer.c:1489 [inline]
 __run_timers+0x5d8/0x7a0 kernel/time/timer.c:1783
 run_timer_softirq+0x19/0x30 kernel/time/timer.c:1796
 __do_softirq+0x23c/0x8ae kernel/softirq.c:298
 asm_call_irq_on_stack+0xf/0x20
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:26 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:77 [inline]
 do_softirq_own_stack+0x6d/0xb0 arch/x86/kernel/irq_64.c:77
 do_softirq+0xa9/0xf0 kernel/softirq.c:343
 __local_bh_enable_ip+0x10e/0x170 kernel/softirq.c:195
 spin_unlock_bh include/linux/spinlock.h:399 [inline]
 netif_addr_unlock_bh include/linux/netdevice.h:4425 [inline]
 dev_uc_add+0xbe/0x110 net/core/dev_addr_lists.c:593
 vlan_dev_set_mac_address+0x1b3/0x530 net/8021q/vlan_dev.c:322
 dev_set_mac_address+0x1d4/0x330 net/core/dev.c:8784
 dev_set_mac_address_user+0x2d/0x50 net/core/dev.c:8802
 do_setlink+0x6c2/0x39b0 net/core/rtnetlink.c:2687
 __rtnl_newlink net/core/rtnetlink.c:3410 [inline]
 rtnl_newlink+0x1195/0x1530 net/core/rtnetlink.c:3530
 rtnetlink_rcv_msg+0x9b8/0xe40 net/core/rtnetlink.c:5610
 netlink_rcv_skb+0x187/0x390 net/netlink/af_netlink.c:2503
 netlink_unicast_kernel net/netlink/af_netlink.c:1314 [inline]
 netlink_unicast+0x7b7/0x9b0 net/netlink/af_netlink.c:1340
 netlink_sendmsg+0x968/0xb50 net/netlink/af_netlink.c:1914
 sock_sendmsg_nosec net/socket.c:651 [inline]
 __sock_sendmsg+0x15c/0x170 net/socket.c:663
 __sys_sendto+0x323/0x430 net/socket.c:2005
 __do_sys_sendto net/socket.c:2017 [inline]
 __se_sys_sendto net/socket.c:2013 [inline]
 __x64_sys_sendto+0xda/0xf0 net/socket.c:2013
 do_syscall_64+0x34/0x50 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x67/0xd1
RIP: 0033:0x7fab23a02a3c
Code: 2a 5f 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 70 5f 02 00 48 8b
RSP: 002b:00007ffdf0a7a370 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fab24776620 RCX: 00007fab23a02a3c
RDX: 000000000000002c RSI: 00007fab24776670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffdf0a7a3c4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007fab24776670 R15: 0000000000000000
================================================================================


Tested on:

commit:         d3d0b4e2 Linux 5.10.245
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-5.10.y
console output: https://syzkaller.appspot.com/x/log.txt?x=138c4fe2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=39182a54870857eb
dashboard link: https://syzkaller.appspot.com/bug?extid=a49010a0e8fcdeea075f
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14d89c92580000



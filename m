Return-Path: <linux-kernel+bounces-875663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFADC198CB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14F15547305
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B64326D69;
	Wed, 29 Oct 2025 09:59:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C44274B27
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731947; cv=none; b=S4KreFLG0N54gz0/lCtHM4kPuYWTo8TAs2SNBFBt62LycXRREIq4s3ijWPzj8XvdGHtjbuMPhAMFjAZOGCFIVS9hh0u5hgR7wc8irpFSR3FHiPxx1Jm8tdcEspWvt7gm266XCuDGnLXt4DQ3Jmug3yjbfJnv1ZgWN62lmqlpg4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731947; c=relaxed/simple;
	bh=YQzoQ5yAdi23Tt9qQAqr0i4nxw4iZuUM9kmUcKA9p9I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QycuydC9wuSkkWK/9mMz2uvuXZFPflEKE7Byemh5ncD4zPqdVr9TT3zIj2glBj7kbdlSZKwHbu6fzGUILV3KUD4QDob7bYWwUInvhpj7kqdVT8flLpcaJZGVUvljTGvPMzAsfUDW02oiAgw2Tdkf/4vY3xkD+gogLq30iCj8NUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-945c705df24so95373939f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761731943; x=1762336743;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mY4oJZDSqNwJvUB9XSL+gSw5nf+tolM73YPDnIuRbTo=;
        b=myoBvUMyUfqhBkDf/hS5QYhlmd08FOyDh22PuIRzsTnScQEMFdJMwoJors/KsOQxt3
         EVvrL2299o+FERmiLqEOfZlffQ1SbE3zMOWBmO7SrxvcNwqZ6DMo9fGscPzZSo9kVwQp
         vy2zPvxxhJ/kiA6gkYQ9c1cnsv2VMCt2w89g3FlIipwjJtO6/5DtkhF0QKhvJEQfJot0
         r3LnwUjlc+yog4wCuHOZL+W0NbhsymRmNmIyQBCPbFNP8972pz+VYtjy5LfFRzYCxrAo
         HkSDxzeWVDWo1FYvzwldRP1HBZMLx7GHtlzUQ1mvjBPpwzXnqiYxUGewi/RUUafHXZun
         /r2g==
X-Forwarded-Encrypted: i=1; AJvYcCXISy8jlWS0wxO5/2+kPWMmbVibg3QzMUl9LxxvNrGTZzF0DWhyxZuYGzWeJr0kYSvH6oYTK7W6CoPYVvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP556MG4o6kMLc0yMAMlAk5D1Cx77s/F2rDpELFmt4X6oSmX7Z
	MpSCsKfs9f9HBl13yfMeRvxHC6VU80eiRsW3hQCVGZloDqR+YZFaZrwvY+zobAMU1ZVOHAYfXpG
	ul2xTZN2QYOAM/i8Ri8OJ/WiDjtTncwmV+y+PjaXbgM6sG2mM/qp2CnuuJcM=
X-Google-Smtp-Source: AGHT+IHUze1QF6x+6wGRo8TN/YAQqiH5CPERIW5NXlyuNkMBaIQERBys+uFYzgDOpAF2Q82Adt4D7zdWH9+Ev/2pPh/oQEVcE14j
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1888:b0:430:b4e1:bcb8 with SMTP id
 e9e14a558f8ab-432f8e49782mr32118225ab.13.1761731943680; Wed, 29 Oct 2025
 02:59:03 -0700 (PDT)
Date: Wed, 29 Oct 2025 02:59:03 -0700
In-Reply-To: <20251029062155.3faRf%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901e567.050a0220.32483.0209.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_commit_truncate
From: syzbot <syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: signed-integer-overflow in ip_idents_reserve

================================================================================
UBSAN: signed-integer-overflow in ./arch/x86/include/asm/atomic.h:165:11
1823136308 + 1553543319 cannot be represented in type 'int'
CPU: 1 PID: 234 Comm: kworker/u4:4 Not tainted syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: phy9 ieee80211_iface_work
Call Trace:
 <IRQ>
 dump_stack+0xfd/0x16e lib/dump_stack.c:118
 ubsan_epilogue+0xa/0x30 lib/ubsan.c:148
 handle_overflow+0x192/0x1b0 lib/ubsan.c:180
 arch_atomic_add_return arch/x86/include/asm/atomic.h:165 [inline]
 atomic_add_return include/asm-generic/atomic-instrumented.h:73 [inline]
 ip_idents_reserve+0x14a/0x170 net/ipv4/route.c:521
 __ip_select_ident+0xe4/0x1c0 net/ipv4/route.c:538
 iptunnel_xmit+0x465/0x840 net/ipv4/ip_tunnel_core.c:80
 udp_tunnel_xmit_skb+0x1b7/0x280 net/ipv4/udp_tunnel_core.c:190
 geneve_xmit_skb drivers/net/geneve.c:1004 [inline]
 geneve_xmit+0x1d00/0x2130 drivers/net/geneve.c:1117
 __netdev_start_xmit include/linux/netdevice.h:4824 [inline]
 netdev_start_xmit include/linux/netdevice.h:4838 [inline]
 xmit_one net/core/dev.c:3601 [inline]
 dev_hard_start_xmit+0x2aa/0x7f0 net/core/dev.c:3617
 __dev_queue_xmit+0x1684/0x2960 net/core/dev.c:4203
 neigh_output include/net/neighbour.h:509 [inline]
 ip6_finish_output2+0x101a/0x1480 net/ipv6/ip6_output.c:130
 rcu_read_lock include/linux/rcupdate.h:718 [inline]
 nf_hook include/linux/netfilter.h:220 [inline]
 NF_HOOK+0x45/0x2c0 include/linux/netfilter.h:294
 mld_sendpack+0x5f1/0xa50 net/ipv6/mcast.c:1676
 mld_send_cr net/ipv6/mcast.c:1972 [inline]
 mld_ifc_timer_expire+0x7e1/0x990 net/ipv6/mcast.c:2471
 call_timer_fn+0x105/0x490 kernel/time/timer.c:1444
 expire_timers kernel/time/timer.c:1489 [inline]
 __run_timers+0x5d5/0x7a0 kernel/time/timer.c:1783
 run_timer_softirq+0x63/0xf0 kernel/time/timer.c:1796
 __do_softirq+0x267/0x92e kernel/softirq.c:298
 asm_call_irq_on_stack+0xf/0x20
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:26 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:77 [inline]
 do_softirq_own_stack+0x9b/0xe0 arch/x86/kernel/irq_64.c:77
 invoke_softirq kernel/softirq.c:393 [inline]
 __irq_exit_rcu+0x227/0x230 kernel/softirq.c:423
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:435
 sysvec_apic_timer_interrupt+0xea/0x100 arch/x86/kernel/apic/apic.c:1106
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:635
RIP: 0010:console_unlock+0xbb0/0xfc0 kernel/printk/printk.c:2548
Code: 00 00 48 83 7c 24 28 00 48 8b 5c 24 30 75 07 e8 76 5d 18 00 eb 0a e8 6f 5d 18 00 e8 ba 5b 1e 00 48 89 5c 24 58 ff 74 24 58 9d <f6> 44 24 07 01 0f 84 08 f6 ff ff e8 50 5d 18 00 48 c7 c7 40 1c 4a
RSP: 0018:ffffc9000197f9b0 EFLAGS: 00000293
RAX: fa4294196ff25300 RBX: 0000000000000293 RCX: ffff888019648000
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffffffff81594776
RBP: ffffc9000197fb00 R08: dffffc0000000000 R09: fffffbfff191fb2e
R10: fffffbfff191fb2e R11: 1ffffffff191fb2d R12: 0000000000000057
R13: ffffc9000197fa20 R14: 1ffffffff179392d R15: dffffc0000000000
 vprintk_emit+0x160/0x240 kernel/printk/printk.c:2060
 printk+0x76/0xa0 kernel/printk/printk.c:2108
 ieee80211_sta_find_ibss net/mac80211/ibss.c:1486 [inline]
 ieee80211_ibss_work+0x1054/0x1180 net/mac80211/ibss.c:1712
 process_one_work+0x85b/0xfe0 kernel/workqueue.c:2282
 worker_thread+0xa9b/0x1430 kernel/workqueue.c:2428
 kthread+0x384/0x410 kernel/kthread.c:328
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
================================================================================
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	48 83 7c 24 28 00    	cmpq   $0x0,0x28(%rsp)
   8:	48 8b 5c 24 30       	mov    0x30(%rsp),%rbx
   d:	75 07                	jne    0x16
   f:	e8 76 5d 18 00       	call   0x185d8a
  14:	eb 0a                	jmp    0x20
  16:	e8 6f 5d 18 00       	call   0x185d8a
  1b:	e8 ba 5b 1e 00       	call   0x1e5bda
  20:	48 89 5c 24 58       	mov    %rbx,0x58(%rsp)
  25:	ff 74 24 58          	push   0x58(%rsp)
  29:	9d                   	popf
* 2a:	f6 44 24 07 01       	testb  $0x1,0x7(%rsp) <-- trapping instruction
  2f:	0f 84 08 f6 ff ff    	je     0xfffff63d
  35:	e8 50 5d 18 00       	call   0x185d8a
  3a:	48                   	rex.W
  3b:	c7                   	.byte 0xc7
  3c:	c7                   	.byte 0xc7
  3d:	40 1c 4a             	rex sbb $0x4a,%al


Tested on:

commit:         d3d0b4e2 Linux 5.10.245
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-5.10.y
console output: https://syzkaller.appspot.com/x/log.txt?x=126abd42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1734393bfd41d2b
dashboard link: https://syzkaller.appspot.com/bug?extid=c16daba279a1161acfb0
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=142bf614580000



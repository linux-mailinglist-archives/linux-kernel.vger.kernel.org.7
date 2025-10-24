Return-Path: <linux-kernel+bounces-868798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 21ACCC0624C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B66114E2648
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E372D63F8;
	Fri, 24 Oct 2025 12:02:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2D630E847
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 12:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761307326; cv=none; b=NykTLtEspLAfGoxJoe7R+DrDqKTSHSGeVaowvo5xvRyYVHk3GgJUgA2hn6yz3XBPPhjE6ELmn3YI92aHh8Anz54/NnfDkMpEKt+f0qY/tPhVJgQOLnGIhZizmYzX6fzOcgyWvDYJ5O6zSDnxAGb3jUf58mgAhbiptorwj39We5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761307326; c=relaxed/simple;
	bh=M6vnTguf5+5QbhD97Lb8+FsZrJhK+xeedoIWszpjk6E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MysVyhBX+PzKeTXzAWfv2QRJmhY91LDvo3x9Zlc6bd0Cq4bAmbEVr3Y3rDndLDtJTHgiLL5As3EzuWZyB9pQ0aXgQ5hsKQJ6WVSp31BMirQHQxFvgb3NNs/4hKmZPd3/J7pdZirkVQGjiBf5vxyFOeWR30tuzQGH8Qj5wAQL1/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-93e7d299abfso195359639f.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 05:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761307324; x=1761912124;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rhFPVX9TkF3jS7G43c7+7qdcN50s8kjncPGkU5AA94Y=;
        b=JiV82PpjdoYHGKDS7r7CVKCCWDJnLddwaqsA63f6T07LJwDgD8fcsaIjODhNtcoc9T
         42kUcJLYKrnWHAQD1YV0THhJZNsctVostngXAkyxB8k3lVf/4t5XeeQpAYCyrXm3sF2H
         DliNuyHCvSEMH1QZboEXOlGlNHtIuw9cgfIWJxpTr9N68Sk+QLLuqX4mVCJqJzGt+5nZ
         qxzOMuiPyeLe+9bapfUC5SdYqSa2d2hsjMmohJm45yq1eDAulqG0nD5XAxZd47XXDmEP
         4JvKMrqO66QoRn4XUzKA7bRQuzVbGlfBR6k/0Is3NTKOFeLnhgvwAPfvlRkQvKw+DvJT
         HOag==
X-Forwarded-Encrypted: i=1; AJvYcCWKkrI6M4VGUQO3hgwdixmbOQKiArosMdfXugqFcadJUxRnBL/6okdEoAEU8T1edrf9LAqWTWEioBb23Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg9+ImwEzarNqNINekmCZiKiFq4PR4Pzu31BNoG7lqJoCPGqeE
	RqEbLA+NsMB5VLS5L0kOc80IlFocXjqeF4OyrANRp2Si30wDs6PV9DEeZrjQdFYYP7kRK9Lqkc+
	MFrYlvheIUX8nTt+BY/mreMvM81HPDCI0mT9zuKH9E/hj6J3NDIxw9rlCCkw=
X-Google-Smtp-Source: AGHT+IHBj4pVWRjjMhR1eHm44QME8NeKaH8/HJjmP3YrPUBxWPrbrwmGIAqWU0dnZDJBIINmYnmu4inpgTMxdKkFWU9p8rfZJ/+S
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aaa:b0:42f:6790:476c with SMTP id
 e9e14a558f8ab-430c52d5323mr387975085ab.23.1761307324311; Fri, 24 Oct 2025
 05:02:04 -0700 (PDT)
Date: Fri, 24 Oct 2025 05:02:04 -0700
In-Reply-To: <20251024071157.OCQj0%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb6abc.050a0220.346f24.00c9.GAE@google.com>
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
1767536091 + 1282837187 cannot be represented in type 'int'
CPU: 0 PID: 7041 Comm: modprobe Not tainted syzkaller #0
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
 invoke_softirq kernel/softirq.c:393 [inline]
 __irq_exit_rcu+0x1e1/0x1f0 kernel/softirq.c:423
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:435
 sysvec_apic_timer_interrupt+0x9d/0xb0 arch/x86/kernel/apic/apic.c:1106
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:635
RIP: 0010:check_kcov_mode kernel/kcov.c:174 [inline]
RIP: 0010:write_comp_data kernel/kcov.c:218 [inline]
RIP: 0010:__sanitizer_cov_trace_const_cmp1+0x32/0x90 kernel/kcov.c:270
Code: 14 ba 92 7e 65 8b 0d 19 ba 92 7e f7 c1 00 01 ff 00 74 11 f7 c1 00 01 00 00 74 5b 83 ba 8c 14 00 00 00 74 52 8b 8a 68 14 00 00 <83> f9 03 75 47 48 8b 8a 70 14 00 00 44 8b 8a 6c 14 00 00 49 c1 e1
RSP: 0000:ffffc90001bcfcc0 EFLAGS: 00000246
RAX: ffffffff8191dbec RBX: ffffea0002e49201 RCX: 0000000000000000
RDX: ffff88802fad0000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffea0002e49280 R08: dffffc0000000000 R09: fffff940005c9251
R10: fffff940005c9251 R11: 1ffffd40005c9250 R12: ffffea0002e49288
R13: dffffc0000000000 R14: ffffc90001bcfd18 R15: 0000000000000000
 filemap_map_pages+0x59c/0xa30 mm/filemap.c:2877
 do_fault_around mm/memory.c:4089 [inline]
 do_read_fault mm/memory.c:4123 [inline]
 do_fault mm/memory.c:4256 [inline]
 handle_pte_fault mm/memory.c:4497 [inline]
 __handle_mm_fault mm/memory.c:4632 [inline]
 handle_mm_fault+0x16b8/0x2930 mm/memory.c:4730
 do_user_addr_fault+0x468/0xa50 arch/x86/mm/fault.c:1345
 handle_page_fault arch/x86/mm/fault.c:1402 [inline]
 exc_page_fault+0x67/0x100 arch/x86/mm/fault.c:1458
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:571
RIP: 0033:0x7fca3eee22d0
Code: 48 89 05 f3 11 19 00 f0 48 83 0c 24 00 48 8b 0d de 11 19 00 4c 8b 5c 24 30 4c 8b 54 24 28 4c 01 f9 e9 60 fe ff ff 0f 1f 40 00 <40> 84 ff 74 3b 53 48 83 ec 40 48 8b 1d c7 eb 18 00 48 8b 83 28 03
RSP: 002b:00007ffdb7892c28 EFLAGS: 00010202
RAX: 0000000000000275 RBX: 0000000000000001 RCX: 00007fca3f177300
RDX: 00007fca3ef2ccd0 RSI: 00000000000013a8 RDI: 0000000000000001
RBP: 00007ffdb7892f00 R08: 00007fca3f1786a8 R09: 0000000000000000
R10: 00007ffdb7892c30 R11: 0000000000000246 R12: fffffffffffffff8
R13: 0000002adadffe44 R14: 0000000000000000 R15: 00007fca3f17a310
================================================================================
----------------
Code disassembly (best guess):
   0:	14 ba                	adc    $0xba,%al
   2:	92                   	xchg   %eax,%edx
   3:	7e 65                	jle    0x6a
   5:	8b 0d 19 ba 92 7e    	mov    0x7e92ba19(%rip),%ecx        # 0x7e92ba24
   b:	f7 c1 00 01 ff 00    	test   $0xff0100,%ecx
  11:	74 11                	je     0x24
  13:	f7 c1 00 01 00 00    	test   $0x100,%ecx
  19:	74 5b                	je     0x76
  1b:	83 ba 8c 14 00 00 00 	cmpl   $0x0,0x148c(%rdx)
  22:	74 52                	je     0x76
  24:	8b 8a 68 14 00 00    	mov    0x1468(%rdx),%ecx
* 2a:	83 f9 03             	cmp    $0x3,%ecx <-- trapping instruction
  2d:	75 47                	jne    0x76
  2f:	48 8b 8a 70 14 00 00 	mov    0x1470(%rdx),%rcx
  36:	44 8b 8a 6c 14 00 00 	mov    0x146c(%rdx),%r9d
  3d:	49                   	rex.WB
  3e:	c1                   	.byte 0xc1
  3f:	e1                   	.byte 0xe1


Tested on:

commit:         d3d0b4e2 Linux 5.10.245
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-5.10.y
console output: https://syzkaller.appspot.com/x/log.txt?x=12ef6d42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=39182a54870857eb
dashboard link: https://syzkaller.appspot.com/bug?extid=a49010a0e8fcdeea075f
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=101a93e2580000



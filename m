Return-Path: <linux-kernel+bounces-727681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F19B01E68
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5746AB6025E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6D52E5432;
	Fri, 11 Jul 2025 13:39:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684A82DFA2D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752241146; cv=none; b=C4H1ADBRi5VkbKeMeAy7QORPR3z+ozeTFqM1W2hLMpRX+ynIsIkA9M0NWcbaj51tbTvfEMavzyEd4qEin3Wnr1IfdAEu+EN8DxawUZ+VBYKkU+7CxIGgw6jNNEj2zlPC50M9nIa20b/yRGo3K/puY5CmClFNcT/k39LwkfkwEIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752241146; c=relaxed/simple;
	bh=/a59s7j3jYMVobJdnaPXbVsU++F4p1a0TDigxt2Vnkw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sPbsMwYC7eJS+NvX9JDATvb40t38I7+1DKPudP6kEV9Dx5vRPOATuAF13rT4Gfz1DNKv1R2qukUtTW5N5jgjU0U/Uqo6mkQl3vPMqwm0iN+UrFxez0WNw4eRA2VumbcdbXCoq7m0E4Y5CBWvA2ZAho8DA732LJRqrDrkAj6M3Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-86d01ff56ebso339310639f.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 06:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752241143; x=1752845943;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qqk/evHXRGwj4kfWhWrk65pWOIwizwMJGTD9aUJYVQ4=;
        b=TiFELpIHg2w9wD3XMog1a8hfhr3ODRnlej5PpKVi9M9UTttBseRyTEEzKpjWgSV+CI
         Yh6DyAu1nKuKHAeSSiMYUnDasihOonAkbW+/akP1NllYQbNdEEvsA72KwhPZ//Piz5Oo
         +2gP+tgWSFIPCRf+5s8EYV3bdDu0iiakBCaPyJ1OV0N1mzL52br2aEpOpCT5V/AOPBjp
         r3Ar3hTSvpDDUVwFdiqaW+pfKAyEQrCIP3NKBtHKVuoa7vvOIYh3dDsZ3gOYw2XlIJK/
         tUBKsUI3kkfKd4Z/3ZrcePa5dnOqRU4+dDJ8mVJl+t4R3ddRkT23Uu81lY8Xbxo5i6mG
         3R6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXVANaA7GdpoeN+eogoB74JqWpl3PTORJTuPG6LJaWKMGOAEBhuCtTulcV03OqDAnhZUeWfZMz/3XE6Kms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4bfnWcMyaP1vTKiqyi1uU3boSTmEiPmrxKhwX/LQIfRMqCGV4
	kUrB1r00PyeMthr1JLIVIOL1/y1KS3XqcsMS/M5W/7GLthD8HjYNPi+/NWG9siqphiwLd13U+cG
	y6A2qRkBlwbD60rkD01az97Ys3bWlkWc3nOfT/i6qXxBgmOxMLhZmwp05u5s=
X-Google-Smtp-Source: AGHT+IG97HX53JB1HI6Zs66SMjw1bY1fPRasa94KM6h/XTGv0hdS6yWvkHngQXZb1NqIL7RIivKJUGq0dWwoP9IjaZrvxm6YbB3g
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6426:b0:876:b8a0:6a16 with SMTP id
 ca18e2360f4ac-8797886bf6cmr370386739f.13.1752241143403; Fri, 11 Jul 2025
 06:39:03 -0700 (PDT)
Date: Fri, 11 Jul 2025 06:39:03 -0700
In-Reply-To: <20250711130450.3505-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687113f7.a00a0220.26a83e.004e.GAE@google.com>
Subject: Re: [syzbot] [lsm?] [net?] WARNING in kvfree_call_rcu
From: syzbot <syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: unable to handle kernel paging request in cipso_v4_delopt

Unable to handle kernel paging request at virtual address eee6b3e8e00000b5
KASAN: maybe wild-memory-access in range [0x77399f47000005a8-0x77399f47000005af]
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[eee6b3e8e00000b5] address between user and kernel address ranges
Internal error: Oops: 0000000096000004 [#1]  SMP
Modules linked in:
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G    B               6.16.0-rc5-syzkaller-00067-gec4801305969-dirty #0 PREEMPT 
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : cipso_v4_delopt+0x6c/0x67c net/ipv4/cipso_ipv4.c:2015
lr : cipso_v4_delopt+0x5c/0x67c net/ipv4/cipso_ipv4.c:2014
sp : ffff800080006a30
x29: ffff800080006a50 x28: 1fffe00019b9b916 x27: 0ee733e8e00000b5
x26: dfff800000000000 x25: 1fffe00019b9b885 x24: dfff800000000000
x23: 0000000000000005 x22: ffff0000c5154d08 x21: ffff0000cdcdc8b0
x20: 77399f47000005aa x19: 77399f470000058c x18: 1fffe000337d4076
x17: 39770a0802048c05 x16: ffff80008052c6a8 x15: ffff700010000d2c
x14: 1ffff00010000d2c x13: 0000000000000004 x12: ffffffffffffffff
x11: ffff700010000d2c x10: dfff800000000000 x9 : ffff8000974017a0
x8 : 0000000000000001 x7 : 0000000000000000 x6 : ffff800089bfec00
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff800089bfec1c
x2 : 0000000000000000 x1 : 0000000000000008 x0 : 0000000000000000
Call trace:
 cipso_v4_delopt+0x6c/0x67c net/ipv4/cipso_ipv4.c:2015 (P)
 cipso_v4_req_delattr+0x20/0x30 net/ipv4/cipso_ipv4.c:2089
 netlbl_req_delattr net/netlabel/netlabel_kapi.c:1287 [inline]
 netlbl_req_setattr+0x32c/0x4a4 net/netlabel/netlabel_kapi.c:-1
 smack_inet_conn_request+0x55c/0x6ac security/smack/smack_lsm.c:4429
 security_inet_conn_request+0xa8/0x2f0 security/security.c:4945
 tcp_v4_route_req+0x220/0x38c net/ipv4/tcp_ipv4.c:1697
 tcp_conn_request+0x908/0x286c net/ipv4/tcp_input.c:7307
 tcp_v4_conn_request+0x1a8/0x210 net/ipv4/tcp_ipv4.c:1739
 tcp_rcv_state_process+0x137c/0x362c net/ipv4/tcp_input.c:6813
 tcp_v4_do_rcv+0x704/0xbc4 net/ipv4/tcp_ipv4.c:1948
 tcp_v4_rcv+0x1dd4/0x28bc net/ipv4/tcp_ipv4.c:2353
 ip_protocol_deliver_rcu+0x1f8/0x484 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x27c/0x4e8 net/ipv4/ip_input.c:233
 NF_HOOK+0x2c4/0x358 include/linux/netfilter.h:317
 ip_local_deliver+0x120/0x194 net/ipv4/ip_input.c:254
 dst_input include/net/dst.h:469 [inline]
 ip_sublist_rcv_finish net/ipv4/ip_input.c:579 [inline]
 ip_list_rcv_finish net/ipv4/ip_input.c:628 [inline]
 ip_sublist_rcv+0x8a0/0xb68 net/ipv4/ip_input.c:636
 ip_list_rcv+0x398/0x3ec net/ipv4/ip_input.c:670
 __netif_receive_skb_list_ptype net/core/dev.c:6020 [inline]
 __netif_receive_skb_list_core+0x4e4/0x67c net/core/dev.c:6067
 __netif_receive_skb_list net/core/dev.c:6119 [inline]
 netif_receive_skb_list_internal+0x74c/0x9e0 net/core/dev.c:6210
 gro_normal_list include/net/gro.h:532 [inline]
 napi_complete_done+0x250/0x614 net/core/dev.c:6580
 gve_napi_poll+0x1f4/0x3ac drivers/net/ethernet/google/gve/gve_main.c:389
 __napi_poll+0xb4/0x3fc net/core/dev.c:7414
 napi_poll net/core/dev.c:7478 [inline]
 net_rx_action+0x5f4/0xd58 net/core/dev.c:7605
 handle_softirqs+0x328/0xc88 kernel/softirq.c:579
 __do_softirq+0x14/0x20 kernel/softirq.c:613
 ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:68
 call_on_irq_stack+0x24/0x30 arch/arm64/kernel/entry.S:887
 do_softirq_own_stack+0x20/0x2c arch/arm64/kernel/irq.c:73
 invoke_softirq kernel/softirq.c:460 [inline]
 __irq_exit_rcu+0x1b0/0x478 kernel/softirq.c:680
 irq_exit_rcu+0x14/0x84 kernel/softirq.c:696
 __el1_irq arch/arm64/kernel/entry-common.c:654 [inline]
 el1_interrupt+0x38/0x54 arch/arm64/kernel/entry-common.c:668
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:673
 el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:592
 __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:26 [inline] (P)
 arch_local_irq_enable+0x8/0xc arch/arm64/include/asm/irqflags.h:48 (P)
 cpuidle_idle_call kernel/sched/idle.c:185 [inline]
 do_idle+0x1d8/0x454 kernel/sched/idle.c:325
 cpu_startup_entry+0x5c/0x74 kernel/sched/idle.c:423
 rest_init+0x2d8/0x2f4 init/main.c:745
 start_kernel+0x450/0x4ac init/main.c:1102
 __primary_switched+0x8c/0x94 arch/arm64/kernel/head.S:246
Code: f94002b3 b40002d3 91007a74 d343fe9b (38fa6b68) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	f94002b3 	ldr	x19, [x21]
   4:	b40002d3 	cbz	x19, 0x5c
   8:	91007a74 	add	x20, x19, #0x1e
   c:	d343fe9b 	lsr	x27, x20, #3
* 10:	38fa6b68 	ldrsb	w8, [x27, x26] <-- trapping instruction


Tested on:

commit:         ec480130 Merge branches 'for-next/core' and 'for-next/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1274dbd4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9e99b6fcd403d050
dashboard link: https://syzkaller.appspot.com/bug?extid=40bf00346c3fe40f90f2
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11e3ba8c580000



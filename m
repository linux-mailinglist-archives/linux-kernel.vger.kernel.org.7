Return-Path: <linux-kernel+bounces-707224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A50FAEC16E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 22:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FF153B4449
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 20:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256BD2EE617;
	Fri, 27 Jun 2025 20:46:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED01F223DEE
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 20:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751057165; cv=none; b=o+prtYqPj+8SCK79mDFqrYP5spcHDvY4w917yCnTf5/oXz6qGzGaFRtYXsRHaphyI+2wQaU0qCbdbY5uHFVzBlVjOb6QbwR7ahPvWxqxpW6X4YxvAMOb1wjWRv0xKo/H6gqKZo45jBIiDZ6OdJFEJMczzOU2gYQnk9N1RgkoW+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751057165; c=relaxed/simple;
	bh=TmaijBzvcXFkUGMpnMPN+z+LEjRYnQbYBF7QdKkwaJU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eruiTJRWaqQ9HLe+bJkqhHltRYJqtf56gc33Tf5LGGlN0BexrW9AoPcP9tUWje1EkfAOYKtSe4Ba7fzNGC8sz5dN/FGYToW9b0MiubN3NQgGhU4kT0PpVPUOhIKKcA3+3C51IIF5a4NGtqjGv3Uq9vtq7RBaxW4AZV0Pwkim89E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3df309d9842so6563985ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 13:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751057163; x=1751661963;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oRm0qcBk4afDT7slNTJNM2b9Ewsq2dOHeRONJZ5bpV4=;
        b=NDWjMM895xW+MFCSuSJT3vZADHRNLv5U20gTVt3gbeEi9muUo8HByVuECKtcDCkz7R
         irm6ZkigdSDHYbrVdpDMtOiO0EcSFQRNvBlA5wKcp/XzgLfvfr2k/E9BB+hl79mEsaly
         jTr5HswPwDwltYM9coHjcCxemfy3DS7lg5vGT6dL3NNFKktUOPdeXJJfR9NOmERahn96
         z5RpW0eZV7WgMfbQ2HsLBu7E7Wnrc4RAhRYDT4GwkJpBc2TmW3dVFnOZ4OdcS9HhHTHT
         W2gt4yNPzkiDmDmDVp7ayPvUwcV7cD3q4dpGRHWj0BJrROWc1OVyC8SAUgKOUs3YuuoF
         Xtgw==
X-Gm-Message-State: AOJu0Yz2BKM3uIjW6/7tiypuz0i6ctbZhoZDyg5iwAW5vaXnpLekHvj8
	LporgrhTv3t9pzMc9xifpGxVq+myrP020anE7D2TwrQ1I5+jBdbvWUDJYqw358vZEhRREXRbq7Z
	Pla9BZpNEEHNIgGjFBbVl0ZkIBhgZC9qXLLqMnC6HvliuKrBNVZ8SZVgID6o=
X-Google-Smtp-Source: AGHT+IGnABw5MzFRNYgQXsQPwPwvKjExeZ350LKBLpRnacnRhW1+gvf1Y6eiGrhaCUkor8FF2OntoxzMWik7nInD2+Z4oyR7+wom
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2c:b0:3dd:fad4:7c61 with SMTP id
 e9e14a558f8ab-3df4ab6cb1emr62468745ab.8.1751057163230; Fri, 27 Jun 2025
 13:46:03 -0700 (PDT)
Date: Fri, 27 Jun 2025 13:46:03 -0700
In-Reply-To: <ea44d9c8-23c3-4bb0-b867-0adf26b330e8@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685f030b.a00a0220.3efde.0002.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in rxe_skb_tx_dtor
From: syzbot <syzbot+8425ccfb599521edb153@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	yanjun.zhu@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in rxe_skb_tx_dtor

Oops: general protection fault, probably for non-canonical address 0xe000bc000000006c: 0000 [#1] SMP KASAN NOPTI
KASAN: maybe wild-memory-access in range [0x0006000000000360-0x0006000000000367]
CPU: 0 UID: 0 PID: 1039 Comm: kworker/u4:7 Not tainted 6.16.0-rc3-syzkaller-gc0e71fcff378 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: rxe_wq do_work
RIP: 0010:rxe_skb_tx_dtor+0x78/0x240 drivers/infiniband/sw/rxe/rxe_net.c:364
Code: 03 42 80 3c 28 00 74 08 4c 89 f7 e8 72 65 81 f9 4d 8b 36 4d 85 f6 0f 84 c3 00 00 00 4d 8d be 60 03 00 00 4c 89 f8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 0f 85 77 01 00 00 41 8b 2f 31 ff 89 ee e8 bf
RSP: 0018:ffffc900000079e8 EFLAGS: 00010206
RAX: 0000c0000000006c RBX: ffff8880122848c0 RCX: ffff8880330a8000
RDX: 0000000000000100 RSI: 0000000000000000 RDI: ffff8880122848c0
RBP: 0000000000000000 R08: ffffffff8fa10ef7 R09: 1ffffffff1f421de
R10: dffffc0000000000 R11: ffffffff88a26c60 R12: dffffc0000000000
R13: dffffc0000000000 R14: 0006000000000000 R15: 0006000000000360
FS:  0000000000000000(0000) GS:ffff88808d250000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb0aec28fc8 CR3: 000000004f814000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 skb_release_head_state+0x101/0x250 net/core/skbuff.c:1139
 napi_consume_skb+0xd2/0x1e0 net/core/skbuff.c:-1
 e1000_unmap_and_free_tx_resource drivers/net/ethernet/intel/e1000/e1000_main.c:1972 [inline]
 e1000_clean_tx_irq drivers/net/ethernet/intel/e1000/e1000_main.c:3864 [inline]
 e1000_clean+0x49d/0x2b00 drivers/net/ethernet/intel/e1000/e1000_main.c:3805
 __napi_poll+0xc7/0x480 net/core/dev.c:7414
 napi_poll net/core/dev.c:7478 [inline]
 net_rx_action+0x707/0xe30 net/core/dev.c:7605
 handle_softirqs+0x286/0x870 kernel/softirq.c:579
 do_softirq+0xec/0x180 kernel/softirq.c:480
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x17d/0x1c0 kernel/softirq.c:407
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 __neigh_event_send+0x9b/0x1560 net/core/neighbour.c:1194
 neigh_event_send_probe include/net/neighbour.h:463 [inline]
 neigh_event_send include/net/neighbour.h:469 [inline]
 neigh_resolve_output+0x198/0x750 net/core/neighbour.c:1496
 neigh_output include/net/neighbour.h:539 [inline]
 ip6_finish_output2+0x11fb/0x16a0 net/ipv6/ip6_output.c:141
 __ip6_finish_output net/ipv6/ip6_output.c:-1 [inline]
 ip6_finish_output+0x234/0x7d0 net/ipv6/ip6_output.c:226
 rxe_send drivers/infiniband/sw/rxe/rxe_net.c:390 [inline]
 rxe_xmit_packet+0x79e/0xa30 drivers/infiniband/sw/rxe/rxe_net.c:449
 rxe_requester+0x1fea/0x3d20 drivers/infiniband/sw/rxe/rxe_req.c:805
 rxe_sender+0x16/0x50 drivers/infiniband/sw/rxe/rxe_req.c:839
 do_task drivers/infiniband/sw/rxe/rxe_task.c:127 [inline]
 do_work+0x1b1/0x6c0 drivers/infiniband/sw/rxe/rxe_task.c:187
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:rxe_skb_tx_dtor+0x78/0x240 drivers/infiniband/sw/rxe/rxe_net.c:364
Code: 03 42 80 3c 28 00 74 08 4c 89 f7 e8 72 65 81 f9 4d 8b 36 4d 85 f6 0f 84 c3 00 00 00 4d 8d be 60 03 00 00 4c 89 f8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 0f 85 77 01 00 00 41 8b 2f 31 ff 89 ee e8 bf
RSP: 0018:ffffc900000079e8 EFLAGS: 00010206
RAX: 0000c0000000006c RBX: ffff8880122848c0 RCX: ffff8880330a8000
RDX: 0000000000000100 RSI: 0000000000000000 RDI: ffff8880122848c0
RBP: 0000000000000000 R08: ffffffff8fa10ef7 R09: 1ffffffff1f421de
R10: dffffc0000000000 R11: ffffffff88a26c60 R12: dffffc0000000000
R13: dffffc0000000000 R14: 0006000000000000 R15: 0006000000000360
FS:  0000000000000000(0000) GS:ffff88808d250000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb0aec28fc8 CR3: 000000004f814000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	03 42 80             	add    -0x80(%rdx),%eax
   3:	3c 28                	cmp    $0x28,%al
   5:	00 74 08 4c          	add    %dh,0x4c(%rax,%rcx,1)
   9:	89 f7                	mov    %esi,%edi
   b:	e8 72 65 81 f9       	call   0xf9816582
  10:	4d 8b 36             	mov    (%r14),%r14
  13:	4d 85 f6             	test   %r14,%r14
  16:	0f 84 c3 00 00 00    	je     0xdf
  1c:	4d 8d be 60 03 00 00 	lea    0x360(%r14),%r15
  23:	4c 89 f8             	mov    %r15,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 77 01 00 00    	jne    0x1ae
  37:	41 8b 2f             	mov    (%r15),%ebp
  3a:	31 ff                	xor    %edi,%edi
  3c:	89 ee                	mov    %ebp,%esi
  3e:	e8                   	.byte 0xe8
  3f:	bf                   	.byte 0xbf


Tested on:

commit:         c0e71fcf RDNA/rxe: Fix rxe_skb_tx_dtor problem
git tree:       https://github.com/zhuyj/linux.git v6.16_fix_rxe_skb_tx_dtor
console output: https://syzkaller.appspot.com/x/log.txt?x=13d9708c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79da270cec5ffd65
dashboard link: https://syzkaller.appspot.com/bug?extid=8425ccfb599521edb153
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Note: no patches were applied.


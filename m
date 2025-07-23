Return-Path: <linux-kernel+bounces-742157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9955B0EE18
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C7BB1AA0EE9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285D528467F;
	Wed, 23 Jul 2025 09:09:41 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A05427FB1F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 09:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261780; cv=none; b=flEODe79YREXwl1NSiZN6RHjMkDZ2T/an0kLk27d/WSNsDBPOfCbF/d4oe6ADHZdm/KYKt/jr8RhodEwHmNDMjiuFcBag9ewMYMRtZ2QilZSpicuiroqCs0EaMjcpbqs4kl1xXJoW+Wyql2/3Kx+jSkVm+EDg1v1bN/CN5746NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261780; c=relaxed/simple;
	bh=/yGUGKAhGBPBrwTTEOjI9B+HkXKztIO+0eBa5uesc3s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=CbNf5CQhGhDImV196at2/ixs5iBBuT7Gz4FB6BnURzwYFT0m9DCTxWZAyxxcNSzeH/h0hOGHeww3DBi662/Mq9gljsDdTOsJUi/CNMf1znDdyGv6sZAL/KEmtrxoeG/JVYvxP2laaRzEhwGRz+eEw7aMXm0x9TleDPMOY6zI0No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-86d1218df67so650231739f.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 02:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753261775; x=1753866575;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TvFG3sQTKMwo29OtOJz9i/cr+68WnmlBBDZAn9btd1A=;
        b=MfZVwGGbCvrYlTtkjz1MIohJmnCRVTSEmROwPpl3L3wQO0v6+U9VZi2fbQSnwV6laT
         QqKfAZQlZGqik1htHU7glfH+ONco+8mfSPxsJJfN6ChkD0Jpeihp87ymM/SAY9pGxaeb
         bt7k9I2u5sNKn7WQVW73cLhTlPO85jO/su1DgptH5JE2AVLlX6gpOgPf1uU5CY+6Uo2M
         bsG/15cEMcWfGU0RecNn/02UR8Rd9OmqPQhitqrYA+FvlrvllJRksxT3Q2y1dUS0JDVx
         ebjgij9xh+1kGgSpG545Ol3s3WWZuc4XywzO4FjmGugq850GnYRlLA8SofiZX8vdID+u
         b7RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVck0dlil4z1F4BK8Mi48jQ43FhkQi9EhWM5ew8jgr4VoDJm6JK3NhjMrx3q4EqB+TcOJptrKUBETIjI1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YydYK8La2DLXk1fzKoQiCPAEMNHV1rk1KZ59DJrNzIlCnksEmJo
	adGpl6beyR8fKcx+NXUQ1Pqc8oTXZmzKEBXAFRjoMDZgsm/NXc9LYkoE4E89ZbIu9vfd7j+jFDf
	8tP4z/+IRtM9Ogh8pPySmE1bqFwQshTvx7xem2MclmNC9EwCQ0SxmidX1mxM=
X-Google-Smtp-Source: AGHT+IFAeZxnWZN6oyV6j+V0s/nOmFK6pRexyplCpc2+fX0UQLepZSpXUWTIKp0c4WkSDYL6cj51kYBhiyyzzpLl/WkoydOWc6oG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3a0d:b0:875:ba1e:4d7e with SMTP id
 ca18e2360f4ac-87c64fbb367mr491673439f.6.1753261775276; Wed, 23 Jul 2025
 02:09:35 -0700 (PDT)
Date: Wed, 23 Jul 2025 02:09:35 -0700
In-Reply-To: <20250722210256.143208-1-sdf@fomichev.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6880a6cf.050a0220.40ccf.0000.GAE@google.com>
Subject: [syzbot ci] Re: vrf: Drop existing dst reference in vrf_ip6_input_dst
From: syzbot ci <syzbot+ci7bed65dd2de1adbd@syzkaller.appspotmail.com>
To: andrew@lunn.ch, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	sdf@fomichev.me
Cc: syzbot@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] vrf: Drop existing dst reference in vrf_ip6_input_dst
https://lore.kernel.org/all/<20250722210256.143208-1-sdf@fomichev.me>
* [PATCH net 1/2] vrf: Drop existing dst reference in vrf_ip6_input_dst
* [PATCH net 2/2] net: Warn when overriding referenced dst entry

and found the following issue:
WARNING in nf_reject_fill_skb_dst

Full report is available here:
https://ci.syzbot.org/series/c92e1af5-3b8b-4c26-8104-acca93ad8939

***

WARNING in nf_reject_fill_skb_dst

tree:      net
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net.git
base:      cf074eca0065bc5142e6004ae236bb35a2687fdf
arch:      amd64
compiler:  Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
config:    https://ci.syzbot.org/builds/235c4af3-77ea-4670-9c9e-9de1ef0a5aa6/config
syz repro: https://ci.syzbot.org/findings/1038832f-72d8-4491-9ac9-28339d31f0f7/syz_repro

------------[ cut here ]------------
WARNING: CPU: 1 PID: 12 at ./include/linux/skbuff.h:1165 nf_reject_fill_skb_dst+0x313/0x3b0
Modules linked in:
CPU: 1 UID: 0 PID: 12 Comm: kworker/u8:0 Not tainted 6.16.0-rc6-syzkaller-00135-gcf074eca0065-dirty #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: ipv6_addrconf addrconf_dad_work
RIP: 0010:nf_reject_fill_skb_dst+0x313/0x3b0
Code: 8b 0d f1 35 98 08 48 3b 8c 24 e0 00 00 00 75 6b 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d e9 54 19 69 01 cc e8 9e 7e b8 f7 90 <0f> 0b 90 e9 43 ff ff ff e8 90 7e b8 f7 90 0f 0b 90 e9 e3 fe ff ff
RSP: 0018:ffffc900001e0360 EFLAGS: 00010246
RAX: ffffffff8a07aa52 RBX: ffff888110f75500 RCX: ffff88801c2f5640
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900001e0490 R08: ffffffff8fa1d6f7 R09: 1ffffffff1f43ade
R10: dffffc0000000000 R11: fffffbfff1f43adf R12: ffff888110f75501
R13: dffffc0000000001 R14: 1ffff9200003c070 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881a3c22000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002000000000c0 CR3: 000000001ff6e000 CR4: 00000000000006f0
Call Trace:
 <IRQ>
 nf_send_unreach+0x17b/0x700
 nft_reject_inet_eval+0x4bc/0x690
 nft_do_chain+0x40c/0x1920
 nft_do_chain_inet+0x25d/0x340
 nf_hook_slow+0xc5/0x220
 NF_HOOK+0x206/0x3a0
 __netif_receive_skb+0x143/0x380
 process_backlog+0x60e/0x14f0
 __napi_poll+0xc7/0x480
 net_rx_action+0x707/0xe30
 handle_softirqs+0x286/0x870
 do_softirq+0xec/0x180
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x17d/0x1c0
 __dev_queue_xmit+0x1cd7/0x3a70
 ip6_finish_output2+0x11fe/0x16a0
 ndisc_send_skb+0xc77/0x1500
 ndisc_send_ns+0xcb/0x150
 addrconf_dad_work+0xaae/0x14b0
 process_scheduled_works+0xae1/0x17b0
 worker_thread+0x8a0/0xda0
 kthread+0x711/0x8a0
 ret_from_fork+0x3fc/0x770
 ret_from_fork_asm+0x1a/0x30
 </TASK>


---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.


Return-Path: <linux-kernel+bounces-893983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A09C49029
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B6463AB38A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605382DE718;
	Mon, 10 Nov 2025 19:22:29 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505F1280A5B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762802548; cv=none; b=TvbrbvtKdEMD1sHplMd6o2ZeZPE5uWtKwdQMFVgXKB91DVGtRgzvqSKv29QHos7bi9q3F/HSi17XatCwOyqdRe+pZ1PmI2CQfPBxUMr6OBEw1r1od1l8UG+1ngIb60BDf9XSB2AVbkjgSMZjrPNEZO9de+0ZqZyc8xjCb7o0oNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762802548; c=relaxed/simple;
	bh=CP2l1GND9XmDlVmNP4ysESiaq2gHQkWz2iLVxiWjVnQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=bxjIQCXKYcreq0Yj3K7/evOlN0VwWiJRYGtVr/67+w5oYMueD2INvH/qgCKccyxuBD58D1iptRNwulO88YiR/UWBEba7xJmLcVOXY07nnvDrPlGZTmsN1UV6rNItzBhvcaVJDoJvk8xLJFshGoMh04H1L7dmSaI4NI5vPZReldY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-433795a17c1so35856605ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:22:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762802546; x=1763407346;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wl+H9Mj/MNZGwgtImdJWrasH0O/1gigXnZt/x9DQ9fY=;
        b=caerXUKPO8BPBjh0XJLElEDzCgxhA3KDNdgUZI9osaR2lh95denQEfPV9vM6Hk+Xo8
         hKAk/Vwq5YV3K4YzW5fm6+6Y5eVrKINmXsvr6560z8dqLNKddOqr8b0nlydUd/AxuBRF
         PCzF8LHLZ0a+aR0quTPLPENsQFupGqueS/gfvCLGGxmolwTjw/qcWugo4eWRFi6/rqv7
         6M3ZYgWo23N3Pw3g02IWP5Wmh4dllVxIW2tzklzFj6cOXY6nvPniOcuRfYwEzIgvu9Dx
         C+M0sh6n8Y9e1fA9YrYUmDatVfhNk+3VMVvAmobdVbXCC5ycFqZNSTY9Thkfa9gQCw2n
         WhSg==
X-Forwarded-Encrypted: i=1; AJvYcCU9yH8Ojy7Bfcf6iMg1hZFj748byOqxKXd26IM4+FKDHQQj3pXf6QmrG0CY2MCns1bqBB4/anQMSJlLqQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxozwB2HTCuWINBSpKzAKhFBT8dMFHq39JBJQHsHvxx7hZDq6nB
	dTQDULGEl48D2GgpLZP/zYcIFfmx9vuiMtcCXO2UscmYYkb4Vt1KSWDo7vom6aLZiXrdTzTlUCN
	nmLZ6uJwNKcNjjT2jcpPfgD16BYZzFNcG09UkWeQQqkmlI7mri/KxHItjENU=
X-Google-Smtp-Source: AGHT+IEbPdtGfgRJqMVL2hawbUBqJT/8sv4vcnWwmm+eidH11LbtU0FVRNEsxsMeyGyMPxe7lShMhaEsnQrv4B9yHqEap8KA1zuM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:248f:b0:433:7a5f:943a with SMTP id
 e9e14a558f8ab-4337a5f94e7mr79790175ab.19.1762802546481; Mon, 10 Nov 2025
 11:22:26 -0800 (PST)
Date: Mon, 10 Nov 2025 11:22:26 -0800
In-Reply-To: <20251110160457.61791-1-vishal.moola@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69123b72.a70a0220.22f260.0105.GAE@google.com>
Subject: [syzbot ci] Re: make vmalloc gfp flags usage more apparent
From: syzbot ci <syzbot+ci9989da8336cb2bc7@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, hch@infradead.org, hch@lst.de, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, urezki@gmail.com, 
	vishal.moola@gmail.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] make vmalloc gfp flags usage more apparent
https://lore.kernel.org/all/20251110160457.61791-1-vishal.moola@gmail.com
* [PATCH 1/4] mm/vmalloc: warn on invalid vmalloc gfp flags
* [PATCH 2/4] mm/vmalloc: Add a helper to optimize vmalloc allocation gfps
* [PATCH 3/4] mm/vmalloc: cleanup large_gfp in vm_area_alloc_pages()
* [PATCH 4/4] mm/vmalloc: cleanup gfp flag use in new_vmap_block()

and found the following issue:
WARNING: kmalloc bug in bpf_prog_alloc_no_stats

Full report is available here:
https://ci.syzbot.org/series/488ab7c0-de91-4749-bbb2-ca76c3fb798b

***

WARNING: kmalloc bug in bpf_prog_alloc_no_stats

tree:      mm-new
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/akpm/mm.git
base:      02dafa01ec9a00c3758c1c6478d82fe601f5f1ba
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/2334ae39-552d-4ca2-8562-7adc18ce2cb0/config

can: broadcast manager protocol
can: netlink gateway - max_hops=1
can: SAE J1939
can: isotp protocol (max_pdu_size 8300)
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM ver 1.11
Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Bluetooth: BNEP filters: protocol multicast
Bluetooth: BNEP socket layer initialized
Bluetooth: HIDP (Human Interface Emulation) ver 1.2
Bluetooth: HIDP socket layer initialized
NET: Registered PF_RXRPC protocol family
Key type rxrpc registered
Key type rxrpc_s registered
NET: Registered PF_KCM protocol family
lec:lane_module_init: lec.c: initialized
mpoa:atm_mpoa_init: mpc.c: initialized
l2tp_core: L2TP core driver, V2.0
l2tp_ppp: PPPoL2TP kernel driver, V2.0
l2tp_ip: L2TP IP encapsulation support (L2TPv3)
l2tp_netlink: L2TP netlink interface
l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2TPv3)
NET: Registered PF_PHONET protocol family
8021q: 802.1Q VLAN Support v1.8
sctp: Hash tables configured (bind 32/56)
NET: Registered PF_RDS protocol family
Registered RDS/infiniband transport
Registered RDS/tcp transport
tipc: Activated (version 2.0.0)
NET: Registered PF_TIPC protocol family
tipc: Started in single node mode
smc: adding smcd device lo without pnetid
NET: Registered PF_SMC protocol family
9pnet: Installing 9P2000 support
NET: Registered PF_CAIF protocol family
NET: Registered PF_IEEE802154 protocol family
Key type dns_resolver registered
Key type ceph registered
libceph: loaded (mon/osd proto 15/24)
batman_adv: B.A.T.M.A.N. advanced 2025.4 (compatibility version 15) loaded
openvswitch: Open vSwitch switching datapath
NET: Registered PF_VSOCK protocol family
mpls_gso: MPLS GSO support
IPI shorthand broadcast: enabled
sched_clock: Marking stable (21550045890, 115271513)->(21677757748, -12440345)
registered taskstats version 1
------------[ cut here ]------------
Unexpected gfp: 0x100000 (__GFP_HARDWALL). Fixing up to gfp: 0xdc0 (GFP_KERNEL|__GFP_ZERO). Fix your code!
WARNING: CPU: 1 PID: 1 at mm/vmalloc.c:3936 vmalloc_fix_flags+0x9c/0xe0
Modules linked in:
CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:vmalloc_fix_flags+0x9c/0xe0
Code: 81 e6 1f 52 fe ff 89 74 24 30 81 e3 e0 ad 01 00 89 5c 24 20 90 48 c7 c7 80 b9 76 8b 4c 89 fa 89 d9 4d 89 f0 e8 85 31 6e ff 90 <0f> 0b 90 90 8b 44 24 20 48 c7 04 24 0e 36 e0 45 4b c7 04 2c 00 00
RSP: 0000:ffffc90000066d60 EFLAGS: 00010246
RAX: 50a201fad922ca00 RBX: 0000000000000dc0 RCX: ffff888160a80000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: ffffc90000066df8 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bba678 R12: 1ffff9200000cdac
R13: dffffc0000000000 R14: ffffc90000066d80 R15: ffffc90000066d90
FS:  0000000000000000(0000) GS:ffff8882a9f32000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000dd38000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 __vmalloc_noprof+0xf2/0x120
 bpf_prog_alloc_no_stats+0x4a/0x4d0
 bpf_prog_alloc+0x3c/0x1a0
 bpf_prog_load+0x735/0x19e0
 __sys_bpf+0x507/0x860
 kern_sys_bpf+0x17d/0x6b0
 load+0x39e/0x940
 do_one_initcall+0x236/0x820
 do_initcall_level+0x104/0x190
 do_initcalls+0x59/0xa0
 kernel_init_freeable+0x334/0x4b0
 kernel_init+0x1d/0x1d0
 ret_from_fork+0x4bc/0x870
 ret_from_fork_asm+0x1a/0x30
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.


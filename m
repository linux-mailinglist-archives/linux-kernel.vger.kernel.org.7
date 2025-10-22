Return-Path: <linux-kernel+bounces-864112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63024BF9F10
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A2FF3B015A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E581FF7B3;
	Wed, 22 Oct 2025 04:29:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E0F1E5B68
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761107345; cv=none; b=aMVS1oDho+ztF27FGfI41GdluRBDJAaz1u9/ZUu4SKceFCKJMDoHR6QF8TzIwUI7r3wnG6sX6gGGv1Gis7iiyiUpkyl92NooixM/stYfP/JcW+0/Uc0pI9ZfHQIR1NdXkcc2ECdKXT2dofr6zWQq/kCIRry7TlDpYzfsLy743uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761107345; c=relaxed/simple;
	bh=jEmkwEUsoYdoq45jpvQ5gwbOnltLBCljy1lwipao2a8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hN/r8UoSCAGgBee/BbrQqyK/L50YkoR0k1DmiX/Q3JH/mk8+DW4OBbnRPg1OD9xtS4CwUu6r+c7TXRz7VUgXOgc4N04nXej7EZ/puBJdKf2KzKcdCDFDVQuuKqXGUimO9NtjtdsCDQmwh7fphapHxb6Ak65PO2Vswzf7fgW6LAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430e1a4a129so40631125ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761107343; x=1761712143;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tDnRUPY27CcbvuQRF7H0Aai0NtnQM8sjDlN4wblAq3E=;
        b=aUU7FlpIpZNv20+hXzWBgg3OcrlU00uXfb9Jmr1RTaQG7aZpd4eF8eMY4cM+qfg3gn
         gk52zDxaU8XObHbRSjkXjSeo+sodxvzDajp+NO4JIMQbfCmbpQ/TzygfVgeM8z7CouUw
         6zQmHVzTb30dHaBYAeHvDw8zScNAtsK/GewGV5Vp+4o1mQH9yQv3cPf44souJ1Qiga+t
         F7zMB9Rz+LDwaUNV7AsKiZ8jn8PC/VpXpXbzMfqkj5HYRj9htaW1g5XxpTtcDvn4usZn
         4YQoTHm8qWCppWfYHWhQCANlegLcJCZ2KXS16uwE/lYPB9VY6hZnyKSwCMIEz5IaEkXd
         DjWw==
X-Gm-Message-State: AOJu0YzvyXPptlz1O5kFzWlEzy3Z18Eb2ZOFOOrnu4SgwM6TMJGiY3A1
	gsHbRsY2FxdnRgdZAQ+bo6yuEtxNWIxRrOaIhos2WZe1Pv2ZQr3llV6M/UCfPp6ijj52hEHcoH9
	c2Yi+rhoAeqoPBJBj1i6TnvqoFTO8Znnamuc+y7LXPb88gFp5T4J7Xq2N/lY=
X-Google-Smtp-Source: AGHT+IFqsPovTyQqNCbf6/qpIjvnmIuvQlqaBrXyh5jPFOoF7DQAmNHVzQiRUI0Rweke00hBlPyCiU+eiOq42mBU7RJX96f6scRh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3:b0:431:d093:758d with SMTP id
 e9e14a558f8ab-431d0937867mr51071975ab.22.1761107342906; Tue, 21 Oct 2025
 21:29:02 -0700 (PDT)
Date: Tue, 21 Oct 2025 21:29:02 -0700
In-Reply-To: <upjjyn33ilectirauf64oi6xxes7esatropyat6jtah7m5bupj@oeg67dns7bt6>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f85d8e.a70a0220.3bf6c6.000f.GAE@google.com>
Subject: Re: [syzbot] [wireless?] KMSAN: uninit-value in cfg80211_classify8021d
From: syzbot <syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, listout@listout.xyz, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in cfg80211_classify8021d

RBP: 00007f2e3fe11f91 R08: 00002000000001c0 R09: 0000000000000014
R10: 0000000000000040 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f2e3ffe6038 R14: 00007f2e3ffe5fa0 R15: 00007fff6dff3448
 </TASK>
---[ end trace 0000000000000000 ]---
=====================================================
BUG: KMSAN: uninit-value in cfg80211_classify8021d+0xc2f/0x1580 net/wireless/util.c:1035
 cfg80211_classify8021d+0xc2f/0x1580 net/wireless/util.c:1035
 ieee80211_select_queue+0x37a/0x9e0 net/mac80211/wme.c:180
 __ieee80211_subif_start_xmit+0x60f/0x1d90 net/mac80211/tx.c:4304
 ieee80211_subif_start_xmit+0xa8/0x6d0 net/mac80211/tx.c:4538
 __netdev_start_xmit include/linux/netdevice.h:5248 [inline]
 netdev_start_xmit include/linux/netdevice.h:5257 [inline]
 xmit_one net/core/dev.c:3845 [inline]
 dev_hard_start_xmit+0x22f/0xa30 net/core/dev.c:3861
 __dev_queue_xmit+0x3c51/0x5e60 net/core/dev.c:4763
 dev_queue_xmit include/linux/netdevice.h:3365 [inline]
 packet_xmit+0x8f/0x710 net/packet/af_packet.c:275
 packet_snd net/packet/af_packet.c:3076 [inline]
 packet_sendmsg+0x9173/0xa2a0 net/packet/af_packet.c:3108
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x333/0x3d0 net/socket.c:742
 __sys_sendto+0x593/0x720 net/socket.c:2244
 __do_sys_sendto net/socket.c:2251 [inline]
 __se_sys_sendto net/socket.c:2247 [inline]
 __x64_sys_sendto+0x130/0x200 net/socket.c:2247
 x64_sys_call+0x3924/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:45
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4969 [inline]
 slab_alloc_node mm/slub.c:5272 [inline]
 kmem_cache_alloc_node_noprof+0x989/0x16b0 mm/slub.c:5324
 kmalloc_reserve+0x13c/0x4b0 net/core/skbuff.c:579
 __alloc_skb+0x347/0x7d0 net/core/skbuff.c:670
 alloc_skb include/linux/skbuff.h:1383 [inline]
 alloc_skb_with_frags+0xc5/0xa60 net/core/skbuff.c:6671
 sock_alloc_send_pskb+0xacc/0xc60 net/core/sock.c:2965
 packet_alloc_skb net/packet/af_packet.c:2926 [inline]
 packet_snd net/packet/af_packet.c:3019 [inline]
 packet_sendmsg+0x743d/0xa2a0 net/packet/af_packet.c:3108
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x333/0x3d0 net/socket.c:742
 __sys_sendto+0x593/0x720 net/socket.c:2244
 __do_sys_sendto net/socket.c:2251 [inline]
 __se_sys_sendto net/socket.c:2247 [inline]
 __x64_sys_sendto+0x130/0x200 net/socket.c:2247
 x64_sys_call+0x3924/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:45
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 6494 Comm: syz.0.17 Tainted: G        W           syzkaller #0 PREEMPT(none) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
=====================================================


Tested on:

commit:         552c5071 Merge tag 'vfio-v6.18-rc3' of https://github...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=101e8d2f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bbd3e7f3c2e28265
dashboard link: https://syzkaller.appspot.com/bug?extid=878ddc3962f792e9af59
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1328d734580000



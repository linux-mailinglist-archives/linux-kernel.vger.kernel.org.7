Return-Path: <linux-kernel+bounces-830081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9D6B98B00
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12B384E2584
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3730280CF6;
	Wed, 24 Sep 2025 07:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVndi3mW"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C643227E05F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758700070; cv=none; b=DVg89xxQbmn0Uz124Uic/Kp7sN0BeMsi+sJagSgmr7IhVD+yo47STrrD+y91IJ1RbZNHHohsZFovfWDwOgYTyrjKCpxJY6j6Nn6YtovJFCDxiVZECDXK0U8X/FJPBuS95lNgncEd2XHCa82JE5WH9PylqMI17LHYEeI7dZ5/fQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758700070; c=relaxed/simple;
	bh=Z+vCoNdBMvuFeQgv/9edk+YvTT+7IoVHX3zaZJkyQk8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XgmNk/A13Df5wC0uRAJ1Ih1tgwBLKHd9LPSlwZ136dYHUe3W1pvFF41uyEhmL/MPdV04nm0SG03VK6JQXQc/t2Y5uNDMyU6mu8O9kJI7vzp/Z1emROv9vdlqwl4lBBNpl2QEAw3fCUcwZvfi4jxy5xRNPCShjKie0CmU1UfSJHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVndi3mW; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-579d7104c37so5980325e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 00:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758700067; x=1759304867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCAbY5J9TVOpKMtUVutIq51AeK08EZi5hcnzWE/qk4k=;
        b=WVndi3mWEu7D8tFMlRPKJ5HnltmiMDvoW6L5Q86pv+CRnUnUl2qGwMV2GkjtPDfotW
         o/Z1o9s1uIYD8gqhcfxXmMVZYmGgmmGQvTE5+nHMj8ARMQchKhbfap1XxvFqGMgiRvm1
         /HaJ2l+91WNcngNxmNAsNmV5cmsdGC4+hBBL2Wm0RobzX9QrdLKkHJ7fS2rTTcyYr/qC
         1MlzpbF64HjwbVNxmVpV8eydKVGJePpNVkrGGIMoFkCd7fG+4qwdyyWhxBPnHucnhO9O
         BaxakSKs/ZYpTfrlv+cgeljc63QkCf7JImrAWRrvYcF42QxB6PRXiLkjIRq1dd6P9dSp
         NEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758700067; x=1759304867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCAbY5J9TVOpKMtUVutIq51AeK08EZi5hcnzWE/qk4k=;
        b=uQEkzKM+hFz/XOPLeLBwpkL4ZmiTnKVPWxt35l5M3Yjb+lILxLi9LaPK4v4fydOBQq
         05P9jsyVU6RbYV5O1FUv4JIJiD7aTY7RkqKVLK37lUcvMkn32PbZBZ3v3EBD+e9ueJld
         32gj5UMgmEed1BQ36KGyRLG8jZsTf/Sq+o7rIBC8Y8OimQDeRX5RMhEFeWjwTGksW1oy
         /C5kdOkXp7MFiB0qfxYOiO5oVpxZfJjN3Atgizb025Nh5ggpvVYejVxS2x5epfdUiO38
         rUGGHo93zhv5R8JMAvG7oZg1sYKX+2ba6fuhTAF230qj1I2tm92dob0VVgoIOptWcTSh
         lnzg==
X-Forwarded-Encrypted: i=1; AJvYcCVRnK+WVD8A41brWN8Jvg+j1+q9t8Awgeo7DeRlGzToJnjci/8AhTRFHjs9dKnHh/ibC3E1gySKG4IBl1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp4QIXUe2ospsUqZcatTu/xNwwSgrp1zt9kB8LzJtyYI5K/Seq
	omk9YXR5lK6Qf+a8mQzWTJfDYAP1D8OM9/eJVxMpcjaOcfowt1xw+lJp
X-Gm-Gg: ASbGnctryXwVtFwSS7UOoFsXUlgKfmIb/vgQbLx5dxO7XoxXw2c2hxmjy3zUrAcasFg
	lowRRuLFOQE/keY1M/hRjkvVTzyCMHnWajCrZ8Hke8A7+EtCIr0DqM1TnzjLLPdk6lLV9Y8qQIJ
	ryywLlbni/pPs07J/2ToYjvgNY+nxid2D3xe8Ln4DCRiFmvnwdY7pRUZ07h+U1YIiwGXGgsfA+W
	xlxP5lIXdPVkpM+zhX0tLJv7KDyq7rLhrthUrPMOCEim6h3H1tD8JBKYHabA8PMCxqGgDgiU3ap
	AFLRyge3AVc6FAxqux7067AIYE2JEjJT9RrtNqQO5GUXBY2t2wzVE0bMXRTnkAG0Z85Kcv4f1l4
	DOby/y6SAB63XdARd7zgvGk9SqEQhe0p/xd0=
X-Google-Smtp-Source: AGHT+IEbgdfhaSVwYw/hXIWU4C46EY3Pxhpiy1aKwy2RIdIiClgIYWPgTKxgS7oHeI7zJZkGYI3r6Q==
X-Received: by 2002:a2e:be27:0:b0:36d:3113:63ac with SMTP id 38308e7fff4ca-36d311365c5mr18771751fa.7.1758700066521;
        Wed, 24 Sep 2025 00:47:46 -0700 (PDT)
Received: from foxbook (bfe191.neoplus.adsl.tpnet.pl. [83.28.42.191])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36a13c0d94dsm24008991fa.49.2025.09.24.00.47.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Sep 2025 00:47:46 -0700 (PDT)
Date: Wed, 24 Sep 2025 09:47:41 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: I Viswanath <viswanathiyyappan@gmail.com>
Cc: andrew@lunn.ch, andrew+netdev@lunn.ch, davem@davemloft.net,
 david.hunter.linux@gmail.com, edumazet@google.com, kuba@kernel.org,
 linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 petkan@nucleusys.com, skhan@linuxfoundation.org,
 syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] net: usb: Remove disruptive netif_wake_queue in
 rtl8150_set_multicast
Message-ID: <20250924094741.65e12028.michal.pecio@gmail.com>
In-Reply-To: <20250920181852.18164-1-viswanathiyyappan@gmail.com>
References: <83171a57-cb40-4c97-b736-0e62930b9e5c@lunn.ch>
	<20250920181852.18164-1-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Sep 2025 23:48:52 +0530, I Viswanath wrote:
> syzbot reported WARNING in rtl8150_start_xmit/usb_submit_urb.
> This is the sequence of events that leads to the Warning:
> 
>     CPU0 (in rtl8150_start_xmit)   CPU1 (in rtl8150_start_xmit)    CPU2 (in rtl8150_set_multicast)
>     netif_stop_queue();
>                                                                     netif_stop_queue();
>     usb_submit_urb();
>                                                                     netif_wake_queue();  <-- Wakes up TX queue before it's ready
>                                     netif_stop_queue();
>                                     usb_submit_urb();                                    <-- Warning
> 	freeing urb

It's not freeing which matters but URB completion in USB subsystem.
I think this description is needlessly complex, the essence is:

rtl8150_start_xmit() {
	netif_stop_queue();
	usb_submit_urb(dev->tx_urb);
}

rtl8150_set_multicast() {
	netif_stop_queue();
	netif_wake_queue();  <-- wakes up TX queue before URB is done
}

rtl8150_start_xmit() {
	netif_stop_queue();
	usb_submit_urb(dev->tx_urb);	<-- double submission
}


> rtl8150_set_multicast is rtl8150's implementation of ndo_set_rx_mode and
> should not be calling netif_stop_queue and notif_start_queue as these handle 
> TX queue synchronization.
> 
> The net core function dev_set_rx_mode handles the synchronization
> for rtl8150_set_multicast making it safe to remove these locks.
> 
> Reported-and-tested-by: syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=78cae3f37c62ad092caa
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>

Tested-by: Michal Pecio <michal.pecio@gmail.com>

This is instantly triggered on HW simply by running:

ncat remote-host port < /dev/zero &
ifconfig ethX allmulti

and results in:

[ 1253.338536] URB ffff88810ad01240 submitted while active
[ 1253.338616] WARNING: CPU: 2 PID: 2785 at drivers/usb/core/urb.c:379 usb_submit_urb+0x5f1/0x640 [usbcore]
[ 1253.338686] Modules linked in: usbhid uvcvideo rtl8150 xhci_pci xhci_hcd usbcore ext2 uvc videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videodev videobuf2_common snd_pcsp usb_common serio_raw ppdev dm_mod nfnetlink [last unloaded: usbcore]
[ 1253.338724] CPU: 2 UID: 0 PID: 2785 Comm: ifconfig Tainted: G        W           6.17.0-rc4 #1 PREEMPT 
[ 1253.338734] Tainted: [W]=WARN
[ 1253.338737] Hardware name: HP HP EliteDesk 705 G3 MT/8265, BIOS P06 Ver. 02.45 07/16/2024
[ 1253.338740] RIP: 0010:usb_submit_urb+0x5f1/0x640 [usbcore]
[ 1253.338791] Code: 56 23 a0 e8 b1 17 3f e1 eb da b8 fe ff ff ff e9 fc fd ff ff 48 89 fe 48 c7 c7 88 20 25 a0 c6 05 c0 30 e1 ff 01 e8 cf 3a f0 e0 <0f> 0b eb a0 b8 f8 ff ff ff e9 d8 fd ff ff b8 ea ff ff ff c3 66 2e
[ 1253.338798] RSP: 0018:ffffc90000154e28 EFLAGS: 00010282
[ 1253.338804] RAX: 000000000000002b RBX: ffff88810ad01240 RCX: 0000000000000027
[ 1253.338808] RDX: ffff888226f17e08 RSI: 0000000000000001 RDI: ffff888226f17e00
[ 1253.338812] RBP: ffff88810be0ff00 R08: 00000000fff7ffff R09: ffffffff85a4d628
[ 1253.338816] R10: ffffffff82e4d680 R11: 0000000000000002 R12: ffff888125e19e00
[ 1253.338820] R13: 00000000000005ea R14: ffff88810be0ff00 R15: ffff8881326b4000
[ 1253.338824] FS:  00007fbb30220740(0000) GS:ffff88829ff7d000(0000) knlGS:0000000000000000
[ 1253.338830] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1253.338834] CR2: 00007fbb301e5e38 CR3: 000000010be04000 CR4: 00000000001506f0
[ 1253.338838] Call Trace:
[ 1253.338846]  <IRQ>
[ 1253.338855]  rtl8150_start_xmit+0xa1/0x100 [rtl8150]
[ 1253.338865]  dev_hard_start_xmit+0x59/0x1c0
[ 1253.338875]  sch_direct_xmit+0x117/0x280
[ 1253.338883]  __qdisc_run+0x136/0x590
[ 1253.338890]  net_tx_action+0x1bb/0x2c0
[ 1253.338898]  handle_softirqs+0xcd/0x270
[ 1253.338907]  do_softirq+0x3b/0x50
[ 1253.338914]  </IRQ>
[ 1253.338916]  <TASK>
[ 1253.338919]  __local_bh_enable_ip+0x54/0x60
[ 1253.338927]  __dev_change_flags+0x9a/0x1e0
[ 1253.338933]  ? filemap_map_pages+0x3f3/0x620
[ 1253.338941]  netif_change_flags+0x22/0x60
[ 1253.338946]  dev_change_flags+0x3d/0x70
[ 1253.338951]  devinet_ioctl+0x388/0x710
[ 1253.338959]  inet_ioctl+0x145/0x190
[ 1253.338966]  ? netdev_name_node_lookup_rcu+0x59/0x70
[ 1253.338971]  ? netdev_name_node_lookup_rcu+0x59/0x70
[ 1253.338976]  ? dev_get_by_name_rcu+0xa/0x20
[ 1253.338982]  ? dev_ioctl+0x2fc/0x4b0
[ 1253.338989]  sock_do_ioctl+0x2f/0xd0
[ 1253.338996]  __x64_sys_ioctl+0x76/0xc0
[ 1253.339005]  do_syscall_64+0x42/0x180
[ 1253.339013]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[ 1253.339019] RIP: 0033:0x7fbb3013fced
[ 1253.339024] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
[ 1253.339028] RSP: 002b:00007ffdc876a850 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[ 1253.339035] RAX: ffffffffffffffda RBX: 00007ffdc876a960 RCX: 00007fbb3013fced
[ 1253.339039] RDX: 00007ffdc876a8b0 RSI: 0000000000008914 RDI: 0000000000000004
[ 1253.339042] RBP: 00007ffdc876a8a0 R08: 000000000000000a R09: 000000000000000b
[ 1253.339045] R10: fffffffffffff8cb R11: 0000000000000246 R12: 00007ffdc876a8b0
[ 1253.339048] R13: 0000000000000004 R14: 0000000000000200 R15: 0000000000000000
[ 1253.339054]  </TASK>
[ 1253.339056] ---[ end trace 0000000000000000 ]---
[ 1253.339062] net eth1: failed tx_urb -16
[ 1253.339068] net eth1: failed tx_urb -16
[ 1253.339072] net eth1: failed tx_urb -16
[ 1253.339075] net eth1: failed tx_urb -16
[ 1253.339078] net eth1: failed tx_urb -16
[ 1253.339081] net eth1: failed tx_urb -16
[ 1253.339084] net eth1: failed tx_urb -16
[ 1253.339088] net eth1: failed tx_urb -16
[ 1253.339091] net eth1: failed tx_urb -16
[ 1253.339094] net eth1: failed tx_urb -16
[ 1253.339097] net eth1: failed tx_urb -16
[ 1253.339204] net eth1: failed tx_urb -16
[ 1253.339209] net eth1: failed tx_urb -16
[ 1253.339212] net eth1: failed tx_urb -16
[ 1253.339215] net eth1: failed tx_urb -16
[ 1253.339218] net eth1: failed tx_urb -16
[ 1253.339221] net eth1: failed tx_urb -16
[ 1253.339224] net eth1: failed tx_urb -16
[ 1253.339226] net eth1: failed tx_urb -16
[ 1253.339229] net eth1: failed tx_urb -16
[ 1253.339232] net eth1: failed tx_urb -16
[ 1253.339235] net eth1: failed tx_urb -16
[ 1253.339237] net eth1: failed tx_urb -16
[ 1253.339240] net eth1: failed tx_urb -16
[ 1253.339243] net eth1: failed tx_urb -16
[ 1253.339246] net eth1: failed tx_urb -16
[ 1253.339249] net eth1: failed tx_urb -16
[ 1253.339252] net eth1: failed tx_urb -16
[ 1253.339255] net eth1: failed tx_urb -16
[ 1253.339258] net eth1: failed tx_urb -16
[ 1253.339261] net eth1: failed tx_urb -16
[ 1253.339263] net eth1: failed tx_urb -16
[ 1253.339266] net eth1: failed tx_urb -16
[ 1253.339268] net eth1: failed tx_urb -16
[ 1253.339348] rtl8150 1-1:1.0 eth1: entered allmulticast mode


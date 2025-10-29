Return-Path: <linux-kernel+bounces-875248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEA3C18855
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E54D04F0CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B03030AAD6;
	Wed, 29 Oct 2025 06:50:12 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9A13090D5
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761720611; cv=none; b=Tgi+ui1dg3qyjlqcEA7pnoZj91tp7zn3CfWmSYMmgJX23v8OM/ffYwzLdVHQRnISCPg+CVtSDKlxTHDMXMYdbcDzYHH04uYwvinozEINtjeX6yMk9sklY15u4A6uarc8HkPEHKoStJ3zBCZ/G8H2CqYqLLFYZQImiXc9S9bJy2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761720611; c=relaxed/simple;
	bh=QMbjbpo/OxkFgYQ5J5UKRAHx4vPrqNLW7+nH3ohfA0A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XvlzjonH0LrsJIXDncoApKLan6vK03Tbq7W4iTfnA9k2qJvU43veXbV1s63A6Fz5h+Ht+u74tdYpAGfAJBuTVXxOAGIptf6x58XLePM5nfmSznC8Q2+t7GC5cBxr3gZgfxqt03E4eKla6DVNIBFh/gB6akh+QQnkMM4kjgUBTWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430d83d262fso275869535ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 23:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761720606; x=1762325406;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lscauzHfe4I8WrTUvHRmFskGNpdy61yNXPbjC7EXvq8=;
        b=Ltlu7SOGzeR4BNFHGQ5AdRagtrakR1MuNbXWX7qiATCaa/IoixuiXn4mn/XM+LzrU2
         x62oX/Do8InVXXtrS3juoPH5ceq5nH9Gz382iDepxY3vCHzFt0trxvnZfZUh1E1WpG4/
         3Bo1zKv5mSLycx17ghglF1yDvwHnVF44+e/xZc+7zeNstTd6V4+ar6ZXOHsqFJWvBJPP
         Gr4lDKH2T6Ksv+FB+RtELQM61HwuvL8tH8/fp0/8QXFCFJMze1wpAjPo8tERw1fvHfIN
         7GcDi2b2SbcnqbX9Z6avUHzomZEIt+nCDqMnmxFHRCXB1WRhIzSMiFJwCMPWvYT78qjs
         USZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCbP/A2380lfiRGeswKf8dBKKcLt+xERqFNcm836YefgRheZAh5IJg1nhwYiaSWSd995YoF2FIRCcKlmM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5XEOpfQzs+4YAz4jZ3tQuyeJvtHLa1KTEXIfgap0aAy5q0+ri
	Xtynv2a71LbPEkPGdD+Y0go3CdYyMUB6yIKMmq8dunlQo8S38NBt8VzIyCg5xFxV6A03ZnasrMn
	qbfp+TD2+F/WpFFGRQbgqKxIV4K+4ZWBRxjqkQwAs7Vxm5JOdekC5sLZHcf4=
X-Google-Smtp-Source: AGHT+IE4sMXJzmdkirKubvDhLQdfx+wNGXOgHeb0zw8eU/H0eIGrOmxXJIKEcxyr5SM2MUXuNM7SbdIl7LdjWFrz+k0tNNLVFxDO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:328a:b0:42f:946f:8eb4 with SMTP id
 e9e14a558f8ab-432f906495dmr23586125ab.21.1761720606306; Tue, 28 Oct 2025
 23:50:06 -0700 (PDT)
Date: Tue, 28 Oct 2025 23:50:06 -0700
In-Reply-To: <20251029062153.SsmMa%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901b91e.050a0220.32483.01fe.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_truncate_log_needs_flush (2)
From: syzbot <syzbot+c24237f0eee59c0c2abb@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: signed-integer-overflow in ip_idents_reserve

================================================================================
UBSAN: signed-integer-overflow in ./arch/x86/include/asm/atomic.h:165:11
1231360813 + 2090395797 cannot be represented in type 'int'
CPU: 0 PID: 3029 Comm: kworker/u2:4 Not tainted syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: wg-kex-wg0 wg_packet_handshake_send_worker
Call Trace:
 <IRQ>
 dump_stack+0xfd/0x16e lib/dump_stack.c:118
 ubsan_epilogue+0xa/0x30 lib/ubsan.c:148
 handle_overflow+0x192/0x1b0 lib/ubsan.c:180
 arch_atomic_add_return arch/x86/include/asm/atomic.h:165 [inline]
 atomic_add_return include/asm-generic/atomic-instrumented.h:73 [inline]
 ip_idents_reserve+0x14a/0x170 net/ipv4/route.c:521
 __ip_select_ident+0xe4/0x1c0 net/ipv4/route.c:538
 ip_select_ident_segs include/net/ip.h:525 [inline]
 ip_select_ident include/net/ip.h:532 [inline]
 __ip_make_skb+0xf7b/0x19c0 net/ipv4/ip_output.c:1551
 ip_finish_skb include/net/ip.h:244 [inline]
 ip_push_pending_frames+0x2c/0x150 net/ipv4/ip_output.c:1606
 __icmp_send+0xc28/0xf70 net/ipv4/icmp.c:776
 icmp_send include/net/icmp.h:43 [inline]
 __udp4_lib_rcv+0x14f7/0x2080 net/ipv4/udp.c:2438
 ip_protocol_deliver_rcu+0x405/0x7e0 net/ipv4/ip_input.c:204
 ip_local_deliver_finish+0x1d8/0x330 net/ipv4/ip_input.c:231
 NF_HOOK+0x25b/0x2d0 include/linux/netfilter.h:296
 NF_HOOK+0x25b/0x2d0 include/linux/netfilter.h:296
 __netif_receive_skb_one_core net/core/dev.c:5395 [inline]
 __netif_receive_skb+0x144/0x380 net/core/dev.c:5509
 process_backlog+0x4ef/0x6e0 net/core/dev.c:6416
 napi_poll net/core/dev.c:6867 [inline]
 net_rx_action+0x4b3/0xc30 net/core/dev.c:6937
 __do_softirq+0x267/0x92e kernel/softirq.c:298
 asm_call_irq_on_stack+0xf/0x20
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:26 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:77 [inline]
 do_softirq_own_stack+0x9b/0xe0 arch/x86/kernel/irq_64.c:77
 do_softirq+0xc4/0x100 kernel/softirq.c:343
 __local_bh_enable_ip+0x121/0x160 kernel/softirq.c:195
 wg_socket_send_skb_to_peer+0x167/0x1c0 drivers/net/wireguard/socket.c:184
 wg_packet_send_handshake_initiation drivers/net/wireguard/send.c:40 [inline]
 wg_packet_handshake_send_worker+0x16b/0x280 drivers/net/wireguard/send.c:51
 process_one_work+0x85e/0xff0 kernel/workqueue.c:2282
 worker_thread+0xa9b/0x1430 kernel/workqueue.c:2428
 kthread+0x386/0x410 kernel/kthread.c:328
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
================================================================================


Tested on:

commit:         d3d0b4e2 Linux 5.10.245
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-5.10.y
console output: https://syzkaller.appspot.com/x/log.txt?x=14df8fe2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=768d3f2193745e75
dashboard link: https://syzkaller.appspot.com/bug?extid=c24237f0eee59c0c2abb
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1063dfe2580000



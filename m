Return-Path: <linux-kernel+bounces-868310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7470C04D90
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95C121895D31
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65CF2F6569;
	Fri, 24 Oct 2025 07:48:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F2F2F657E
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761292086; cv=none; b=uZ3pSM0/gSTv4esQrpDU/fEp7H9MVhKQ1FHdmwYPqOpzCEhDNe8ah8kZ65NtZnHYCGz/4HwKE7dNKOCIZhC67hAny2OV3JOtO+XFDsYMSSoYQ87GQq95dDnGCUfdBZq+RwxNI5i2jatTQaCv+51V2ciHBKZ6EuYPE/5ltKZWA5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761292086; c=relaxed/simple;
	bh=EKEQIMOrcb7Ztnps+pZI9ctc3VGwqQfG6yRSJonJUIQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=s9NVIh1k5nUg2FNt4pCVqJ8G9IxpSN+OtBenORx0wCLhubjG3cTiohgwIApTbObdEajoQq3zNezhzEsK4m56+fE/HDfIoCUYa3DQjdSYCiHQc5XabCq4tJ1aQZYZ51fnbmPtbah89iV5KGee1gy7VFYvCaepuqOdmDWgoq2ptdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430b0adb3e2so23085565ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761292084; x=1761896884;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=noK9cXL2MYi1dpu888y3aKP2nskMyrBvezjo9TBgU3g=;
        b=jeeTXfQepE1xhPTMRqjqrst6eHgfRWB4pOhyOO+W9+s6aLTFKq07gqMbWrDOJQkIa7
         MECc021lcsHxdK94iZTU5c73yOhxNe+L2Ozg7cGo+g71rhEz4a/FiNx1qOanqCYJ2f2M
         8gZFLvFzCPOS0fC+nBcixTpfR2j1sIpSr/vc290Nhz5a7X0/kGOzFKRAMItY7T4zXOON
         cN3UwI6L1qxlZWx/RiNG5tVsAeZ8GSYCwZqrtaGP5Q+gm5EnwBNOB/ET5EashDOU6CZ9
         YQp85g+vWgaZv12Emtc+WZSkKuwzXO0st9vQRD2k+FLMJg09cbFjRN7QnwZHYID8VPtf
         QN2w==
X-Forwarded-Encrypted: i=1; AJvYcCVShW6VQiliLJ1f1UgkgfbLPR5DCCjaqbtutQNTsHxcMoEI4ek6OfZ4WRB5r+itKxcXCJNuZn0ll2txODE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZaxB1q7G473k9VGz/O78rqpJLtpj7a7dQYZ3hNG7ElVVyz6Py
	euLoozpK3qJk54PMd/SxXzkS9pyIq1ywta1M02P8FNCjzvdq7I0Fr7yReqEpfR4v419YJe7brhm
	aswhzVZt7myJXXKvGcD+wJjuhK7HI6l5zhT97KHpDK6oyLKYhRI4RaZgyL6M=
X-Google-Smtp-Source: AGHT+IHV+3tXYnybCMgpz3RYArbwmJN8nTfGofHxGY70QPVLkZQVFzRFHT030qm49UYN29RdHnGfMfzJnlrPU3j06FJiZa/2Iwyh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b46:b0:430:e5a4:6f26 with SMTP id
 e9e14a558f8ab-431eb5fe0ffmr24894245ab.6.1761292083970; Fri, 24 Oct 2025
 00:48:03 -0700 (PDT)
Date: Fri, 24 Oct 2025 00:48:03 -0700
In-Reply-To: <20251024071151.6PBhO%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb2f33.050a0220.346f24.00ae.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in __ocfs2_flush_truncate_log
From: syzbot <syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: signed-integer-overflow in ip_idents_reserve

================================================================================
UBSAN: signed-integer-overflow in ./arch/x86/include/asm/atomic.h:165:11
895131917 + 1491632920 cannot be represented in type 'int'
CPU: 0 PID: 127 Comm: kworker/u4:3 Not tainted syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
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
 __ip_make_skb+0xf78/0x19b0 net/ipv4/ip_output.c:1551
 ip_finish_skb include/net/ip.h:244 [inline]
 ip_push_pending_frames+0x2c/0x150 net/ipv4/ip_output.c:1606
 __icmp_send+0xc22/0xf70 net/ipv4/icmp.c:776
 icmp_send include/net/icmp.h:43 [inline]
 __udp4_lib_rcv+0x14e9/0x2070 net/ipv4/udp.c:2438
 ip_protocol_deliver_rcu+0x405/0x7e0 net/ipv4/ip_input.c:204
 ip_local_deliver_finish+0x1d5/0x330 net/ipv4/ip_input.c:231
 NF_HOOK+0x258/0x2c0 include/linux/netfilter.h:296
 NF_HOOK+0x258/0x2c0 include/linux/netfilter.h:296
 __netif_receive_skb_one_core net/core/dev.c:5395 [inline]
 __netif_receive_skb+0x144/0x380 net/core/dev.c:5509
 process_backlog+0x4ef/0x6e0 net/core/dev.c:6416
 napi_poll net/core/dev.c:6867 [inline]
 net_rx_action+0x4b1/0xc30 net/core/dev.c:6937
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
 process_one_work+0x85b/0xfe0 kernel/workqueue.c:2282
 worker_thread+0xa9b/0x1430 kernel/workqueue.c:2428
 kthread+0x384/0x410 kernel/kthread.c:328
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
================================================================================


Tested on:

commit:         d3d0b4e2 Linux 5.10.245
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-5.10.y
console output: https://syzkaller.appspot.com/x/log.txt?x=14627734580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf23b541eb2e03cb
dashboard link: https://syzkaller.appspot.com/bug?extid=4d55dad3a9e8e9f7d2b5
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11ba8c92580000



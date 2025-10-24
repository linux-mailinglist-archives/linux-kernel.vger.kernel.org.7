Return-Path: <linux-kernel+bounces-868261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1885AC04BA5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5EFF3A2FB7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625212E2DDC;
	Fri, 24 Oct 2025 07:32:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D612E284A
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291125; cv=none; b=SsKu54dNWxv20zZGaboFV91UYW2w3v9vVRyuCD+o9Hs5cookq4rNNNJ4+IIENyvowLesyjvqFAiJcxO9aOWdX0LRvRNRTB1RmXtiBTfJa8swCrGqvnHgE5uO1MyprLTMQujCx7tTAkvJl1mBZ38WFrIsqtZj0eRO2MHcFvgqTWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291125; c=relaxed/simple;
	bh=CfDkgAurg4mQtlzTOlpZKnE8KYq3O46AsHvh0Jx1pv8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TIs9Jj4UqCC0sxveGNAyHfHcJqVjK/pwlKDPumfRQ4jqW8YMdrsjleV59kQix7y3l+GgEYBJ1UWsdrwl1dSa7mwI4sqv7OtIhEdRIND8LGnWF9BXMEhFlVht9xA1hfLGri4gdAGYy6dp6XRe5in3kTnV2Y8GeRE+QelGsjXlJBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430ca53080bso18356695ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761291122; x=1761895922;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s9Uo9uwyKWgolTsOO44obO3+I2BEDzAvVobdYdbj2DY=;
        b=pqr+niOIJ9wYUorms7SSCyp95y+GRYFai66mb5T/JMWYUiY2SZFiQzoh1RhWSLiSgj
         UwKn9//jlDHco0RA48rTWCIkTmmQsK9WcUQv9HC9cd7nXx1T+8BiucDQBzHocrh3qaQR
         X6LKN+FJwE9FnpAX8q01o3oFfHNZjNBGJBimfmN06KDyF/LCHRNLM5z8thltqRdpl9rL
         z060qMFIaDPAe5CtRYCW4628a1D209vGGw2jmP7uFXBSRpHCMNe+b98l3VQSsgLQEozv
         n+BYXTOTIshrY1eNYZfaEBtQ16mL2JagDnNpLi2fl5U2qz8FTHSHuO5EY/tr7BZ4yvpO
         PyRw==
X-Forwarded-Encrypted: i=1; AJvYcCUCdAYi+iy1lV6IefDFcb1WDmtsLGmh2HxYQAbYC9AA54ArFzFGIHGR1G3r8ewXcm+8Uo3dSTzcpMR/vcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPV3NkoM6hK6Pd0Nq6ZYm+LkOh+fcCFht57e346c72HG0T9E7r
	uX4Bozo+3orjv0Q0Nf8Ch8o4/UycIz3qB1MUAKhi2w+TN9Q/i6nb4WJ7TOWK8R3sjaVgXky8WiQ
	P0Lt5R/BGmRa/NqjKtIKhyZw87NxGMobjQqLMCwLomdb/AvxWoVF+5AjyEiA=
X-Google-Smtp-Source: AGHT+IHPbKPQjh/YUdg3y+2vUz4Vk6qZOJC5spvmeV8PgK9xspEZ0QdRZTdWmV+DrJ2D/8MezQF8eD83qCw/g3SBj0zB4SlHzTr7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1605:b0:430:a7d5:235f with SMTP id
 e9e14a558f8ab-430c52b5a72mr382891285ab.15.1761291122497; Fri, 24 Oct 2025
 00:32:02 -0700 (PDT)
Date: Fri, 24 Oct 2025 00:32:02 -0700
In-Reply-To: <20251024071152.RMTIq%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb2b72.050a0220.346f24.00ac.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in __ocfs2_move_extent
From: syzbot <syzbot+727d161855d11d81e411@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: signed-integer-overflow in ip_idents_reserve

================================================================================
UBSAN: signed-integer-overflow in ./arch/x86/include/asm/atomic.h:165:11
-481196967 + -1672998446 cannot be represented in type 'int'
CPU: 0 PID: 3019 Comm: kworker/u2:4 Not tainted syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: wg-kex-wg0 wg_packet_handshake_send_worker
Call Trace:
 dump_stack+0xfd/0x16e lib/dump_stack.c:118
 ubsan_epilogue+0xa/0x30 lib/ubsan.c:148
 handle_overflow+0x192/0x1b0 lib/ubsan.c:180
 arch_atomic_add_return arch/x86/include/asm/atomic.h:165 [inline]
 atomic_add_return include/asm-generic/atomic-instrumented.h:73 [inline]
 ip_idents_reserve+0x14a/0x170 net/ipv4/route.c:521
 __ip_select_ident+0xe4/0x1c0 net/ipv4/route.c:538
 iptunnel_xmit+0x468/0x850 net/ipv4/ip_tunnel_core.c:80
 udp_tunnel_xmit_skb+0x1ba/0x290 net/ipv4/udp_tunnel_core.c:190
 send4+0x5d4/0xaf0 drivers/net/wireguard/socket.c:85
 wg_socket_send_skb_to_peer+0xcd/0x1c0 drivers/net/wireguard/socket.c:175
 wg_packet_send_handshake_initiation drivers/net/wireguard/send.c:40 [inline]
 wg_packet_handshake_send_worker+0x16b/0x280 drivers/net/wireguard/send.c:51
 process_one_work+0x85e/0xff0 kernel/workqueue.c:2282
 worker_thread+0xa9b/0x1430 kernel/workqueue.c:2428
 kthread+0x386/0x410 kernel/kthread.c:328
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
================================================================================
Kernel panic - not syncing: UBSAN: panic_on_warn set ...
CPU: 0 PID: 3019 Comm: kworker/u2:4 Not tainted syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: wg-kex-wg0 wg_packet_handshake_send_worker
Call Trace:
 dump_stack+0xfd/0x16e lib/dump_stack.c:118
 panic+0x2f0/0x9c0 kernel/panic.c:308
 check_panic_on_warn+0x95/0xe0 kernel/panic.c:228
 handle_overflow+0x192/0x1b0 lib/ubsan.c:180
 arch_atomic_add_return arch/x86/include/asm/atomic.h:165 [inline]
 atomic_add_return include/asm-generic/atomic-instrumented.h:73 [inline]
 ip_idents_reserve+0x14a/0x170 net/ipv4/route.c:521
 __ip_select_ident+0xe4/0x1c0 net/ipv4/route.c:538
 iptunnel_xmit+0x468/0x850 net/ipv4/ip_tunnel_core.c:80
 udp_tunnel_xmit_skb+0x1ba/0x290 net/ipv4/udp_tunnel_core.c:190
 send4+0x5d4/0xaf0 drivers/net/wireguard/socket.c:85
 wg_socket_send_skb_to_peer+0xcd/0x1c0 drivers/net/wireguard/socket.c:175
 wg_packet_send_handshake_initiation drivers/net/wireguard/send.c:40 [inline]
 wg_packet_handshake_send_worker+0x16b/0x280 drivers/net/wireguard/send.c:51
 process_one_work+0x85e/0xff0 kernel/workqueue.c:2282
 worker_thread+0xa9b/0x1430 kernel/workqueue.c:2428
 kthread+0x386/0x410 kernel/kthread.c:328
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
Kernel Offset: disabled
Rebooting in 86400 seconds..


Tested on:

commit:         d3d0b4e2 Linux 5.10.245
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-5.10.y
console output: https://syzkaller.appspot.com/x/log.txt?x=17aeae7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=26c538ce4091baa9
dashboard link: https://syzkaller.appspot.com/bug?extid=727d161855d11d81e411
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16369be2580000



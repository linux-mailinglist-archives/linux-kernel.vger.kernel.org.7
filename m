Return-Path: <linux-kernel+bounces-875246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53434C1881C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80DF3188A662
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF2D2206AC;
	Wed, 29 Oct 2025 06:41:11 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E9C2FC031
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761720070; cv=none; b=VRppw0fq7KCiwWee9SGPqhXp9Ne/jQ0pcro3U5g0h0zYB9iv/8Ajk21LhqAMk2qFsSmJj5RQXRlIL55ClsORRCsUQ5+w1ABc18f25asDXFjuivBu46fK+IzYYgnVJT7uavYoYbO0IWUELZBHWWkDpZPXQ28GRLMbfSQ+LRkJpKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761720070; c=relaxed/simple;
	bh=Le+TVohEAcAni0UpxrwskgNo1tETuv5FtTvGjAy5QKM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KKJ7B2hW70xNnEN0xl1vpcFbGRsy9YIuELTXCLhssxqeL6lU8IGqCeku1zaGKMPTdyPjnvQLiR9rac0g0KJLQdzvSNn9o8Hfkt5iG/ToWIyPxz+UsdWZAKBNRV2/tDVUAFyHn1gnwZ1KvcbF5m/d9dO/h8k0r+V2wawW26LxXbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430afaea1beso90775175ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 23:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761720066; x=1762324866;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RVo2Pi50SFkiNg6Hg4Fw2wPVVZKLp4xfhPtD5dCYkDQ=;
        b=uOZoxrY88lY+L+XLVhR9PkKR3lhbNeSeD1ZywkeLjCIsz7fjzpAumM7hPI/ej3kqgp
         evakeFniY0GEKa3HO1/XVeDmJPpuOpUQX2uT5jUIaENEs5xrq6ms4f/aBU0ycCL8WGge
         hjkkfJtxtH8T34RiNiCCYIMOHlFE//ZZy5HGFeG9t3Gku8DqMctG6x46Wxw3i0aDk/Q0
         ctPIqOViM7IEaWjndM5CrvpfPa7U3uznAa5hLnPmMaDbdhKUy11Y+S3wfr0nHdoZYAW9
         bbuHRzkOetIunlR59GZ1ORm5OnjaG0deANEDs+OsUEvpDgQ4bQLeyvT28J16kZKaeRbK
         1lVg==
X-Forwarded-Encrypted: i=1; AJvYcCU5FAzRXtMpwmJenFLQcOg5PZdEf2Z1gnv5ORTDe31kHIxp0uJFIWqTTUygriCMg11lX5TqI3ML4yb8h6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTAbZTHOOOZKtcfNm7OL/urt0VBsqB1uY0NKToY77DYoh+DytT
	gBdCLuEM2eZFmiX2mN2VD14Z3NnqlLCMGTUueo8GXp23WdBcnd96AU03EoO78ezG235j8riXP+p
	EK6ruj8JmqJa6+hEbH73iiDLaqhYDkFVTuTkUZdBOEJcfTXhAZ+EWubJ/0tA=
X-Google-Smtp-Source: AGHT+IG5KUoZMPQ8aU2cnH7dbrhTiDNdjRHOufxS2pDLTfsxwsorQif4PJE7xiDMr8Jh3euwAU3WREOYByi0etkDuEd/rjNQmhZa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1708:b0:431:d726:9efd with SMTP id
 e9e14a558f8ab-432f8fad5ecmr30124615ab.12.1761720066203; Tue, 28 Oct 2025
 23:41:06 -0700 (PDT)
Date: Tue, 28 Oct 2025 23:41:06 -0700
In-Reply-To: <20251029062152.SGmfc%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901b702.050a0220.3344a1.040f.GAE@google.com>
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
1000441129 + 1465752830 cannot be represented in type 'int'
CPU: 0 PID: 3020 Comm: kworker/u2:5 Not tainted syzkaller #0
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
CPU: 0 PID: 3020 Comm: kworker/u2:5 Not tainted syzkaller #0
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
console output: https://syzkaller.appspot.com/x/log.txt?x=11dbf614580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=26c538ce4091baa9
dashboard link: https://syzkaller.appspot.com/bug?extid=727d161855d11d81e411
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15cbf614580000



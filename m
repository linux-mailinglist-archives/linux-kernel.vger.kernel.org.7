Return-Path: <linux-kernel+bounces-868420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D14EC052EC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24DB55601B5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00450307AC6;
	Fri, 24 Oct 2025 08:41:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E1A2D5955
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295266; cv=none; b=faZCaOJu0M6VJq2WLgNxKCFKiV/iv+WJrsj2CSFpguoGwninxr0QC4o2CSIPbiDWxsgqaocE1VrOCosm3yrAppdFvyW/sawCUUuz6Yhvpe0Zn2khTvKJNOVP+7HYqSs3RjMb4fjHtUMNNcCsBOog+PTyP4TmD25wsq9P5wI2qeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295266; c=relaxed/simple;
	bh=51bDM1qa8BItlnUQX5Os5L9Ior2I7LHIGJyobMXALS4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iRWBYp3RUR4DGzJtG0JSNm4NcBILRCWnnmwXHK6SYTgI/67Dd2XUXgBhdcDZ/UrbnwLvpqFU9jNQrYT2jam7gE0YO4VXKVJ3PRsFzP65qVK5zPTSAJua9oV9gufX/2kDcJhs90LUBMapaRMHKmmOAgCYjq27qMkYfD6mSty3oyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-940f5d522efso500929839f.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761295264; x=1761900064;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RDpRcRc/IPC6st5gY9RQJhjdRm0RHvAjCE6lye43DSk=;
        b=BQ+CM280ByC1hDKjw9+0WpIGtiBVUvaTHhqQzkq/P6LXLF8RbmdrQ/yym+ZdApnUJn
         MPpFhdNg4VZoxdP0eJP+iG2vJuWB8u5wCV/XPfo0j/6qnaUGQfmzt960KnCIVo0IuoDu
         uvvE7L/DbhoJ5n4L4B5OtIuS+yk7Ax6bDnWucmwUW6oKXz1LSws53+PSOa8zaUf4pzNP
         fqLNag/2WeEepQsr2K3R24vBSkzGFZuErh0cVQvoGlpQr4/uBopOYbsyc3qqZqJLMceL
         hrr11NF28xtqnt8nRQUarVEMDLSEZ6+VMtVTAT2+v9un9Gf1jA+eq9M60SLY8eJ6R09p
         8VxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyPTCBvdKlg25pc7/TFvoQd5X8xl0RhXTdjrqxm8VwUX9jQpX8/Xf+ePBM/nTGtLvaAVAgSC4P4kbhD3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5paM2N9earNkZ5wQekF8tuRP4qiJvRYBPyGtVLeiae+z0u1Io
	+eCu7nVGXUvFRXoJQ4UkJMdkWXfbVA3kGO7l6KFsPQvOgiZWB+9sH48Car6KxqVEZnww2WjsT2C
	fVybcyITkKntBUQ7BUpCTut02ySC61gOborP1oI04ssFz/PDTox2JDLNYfk4=
X-Google-Smtp-Source: AGHT+IHN+sL717YgZ3fKcmwA2H9HvGKhDsS62XreSeWwXL0YSdBCYPPX9YOqzTbdSNcAQ1i5dlhuezq+Qd5eCwgcw+ZQQ+Fizy3M
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdaa:0:b0:431:d763:193a with SMTP id
 e9e14a558f8ab-431dc1e2702mr64771695ab.21.1761295264160; Fri, 24 Oct 2025
 01:41:04 -0700 (PDT)
Date: Fri, 24 Oct 2025 01:41:04 -0700
In-Reply-To: <20251024071152.j81M3%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb3ba0.a70a0220.3bf6c6.0166.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_claim_suballoc_bits
From: syzbot <syzbot+5054473a31f78f735416@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: signed-integer-overflow in ip_idents_reserve

================================================================================
UBSAN: signed-integer-overflow in ./arch/x86/include/asm/atomic.h:165:11
-2082307266 + -1738913672 cannot be represented in type 'int'
CPU: 0 PID: 43 Comm: kworker/u4:2 Not tainted syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: wg-kex-wg0 wg_packet_handshake_send_worker
Call Trace:
 dump_stack+0xfd/0x16e lib/dump_stack.c:118
 ubsan_epilogue+0xa/0x30 lib/ubsan.c:148
 handle_overflow+0x192/0x1b0 lib/ubsan.c:180
 arch_atomic_add_return arch/x86/include/asm/atomic.h:165 [inline]
 atomic_add_return include/asm-generic/atomic-instrumented.h:73 [inline]
 ip_idents_reserve+0x14a/0x170 net/ipv4/route.c:521
 __ip_select_ident+0xe4/0x1c0 net/ipv4/route.c:538
 iptunnel_xmit+0x466/0x7b0 net/ipv4/ip_tunnel_core.c:80
 udp_tunnel_xmit_skb+0x1ba/0x290 net/ipv4/udp_tunnel_core.c:190
 send4+0x5d4/0xaf0 drivers/net/wireguard/socket.c:85
 wg_socket_send_skb_to_peer+0xcd/0x1c0 drivers/net/wireguard/socket.c:175
 wg_packet_send_handshake_initiation drivers/net/wireguard/send.c:40 [inline]
 wg_packet_handshake_send_worker+0x16b/0x280 drivers/net/wireguard/send.c:51
 process_one_work+0x85c/0xfa0 kernel/workqueue.c:2282
 worker_thread+0xa9b/0x1430 kernel/workqueue.c:2428
 kthread+0x360/0x3e0 kernel/kthread.c:328
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
================================================================================
Kernel panic - not syncing: UBSAN: panic_on_warn set ...
CPU: 0 PID: 43 Comm: kworker/u4:2 Not tainted syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
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
 iptunnel_xmit+0x466/0x7b0 net/ipv4/ip_tunnel_core.c:80
 udp_tunnel_xmit_skb+0x1ba/0x290 net/ipv4/udp_tunnel_core.c:190
 send4+0x5d4/0xaf0 drivers/net/wireguard/socket.c:85
 wg_socket_send_skb_to_peer+0xcd/0x1c0 drivers/net/wireguard/socket.c:175
 wg_packet_send_handshake_initiation drivers/net/wireguard/send.c:40 [inline]
 wg_packet_handshake_send_worker+0x16b/0x280 drivers/net/wireguard/send.c:51
 process_one_work+0x85c/0xfa0 kernel/workqueue.c:2282
 worker_thread+0xa9b/0x1430 kernel/workqueue.c:2428
 kthread+0x360/0x3e0 kernel/kthread.c:328
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
Kernel Offset: disabled
Rebooting in 86400 seconds..


Tested on:

commit:         d3d0b4e2 Linux 5.10.245
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-5.10.y
console output: https://syzkaller.appspot.com/x/log.txt?x=165e9be2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=39182a54870857eb
dashboard link: https://syzkaller.appspot.com/bug?extid=5054473a31f78f735416
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15ba8c92580000



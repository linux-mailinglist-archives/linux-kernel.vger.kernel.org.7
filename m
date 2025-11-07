Return-Path: <linux-kernel+bounces-890249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 219A6C3F9AD
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDB83188FB54
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486D331BC90;
	Fri,  7 Nov 2025 10:58:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A463631B13B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762513084; cv=none; b=lULg0/IP2nmD5gKRVJleGpYgbkalWMCZCfu4xKI44uFHFf18UIqGaq1CxkyRq1yztMyz0Z7X0vjqRl/DyC5HBOUsrltNvXkbHYfs7o6iGIAzEnOmkUu1Sjo19e/azs72lhDW+5CMJv40eyvRozUxeKC76jxHJaO2Lm8IvBr3q1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762513084; c=relaxed/simple;
	bh=4YbVw0AgRZjAngcRNC1Wt3otfhTCgRkRjoCQrhx+Zm0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JWf8b9+pfXTqUqC9m5IbSYNmIjLybqwKecCdaC3i52vDQubtsMOWPgGl/An1bV5+8u2KuERbsLCFsD/Dn7KtuGN8T976oh8WE+Hl3VFklkCzhOhNLvzo0wuVLrOnhoJfKqz4ToaAoCyGs2Cr/L/7FEzK3EmBUyQ0nFyxQgAlVC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43300f41682so5518885ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 02:58:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762513082; x=1763117882;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=isMYi1wc0diU1UL9pjVODOGB8DHtRhKdfpGMXJvlBVo=;
        b=BnLSGXw0RZGwhdhgL94S+pBv9qJs9k9WMDDU9gX6Dp0D2IT33VFW1HWniKo+RQViR4
         d6bNsgsynG59zQf7iwcr2ip9vEsAEv+qVJby/1ffTTHhHu1ocTsIvlELtJ6ExULBDa62
         cRWYd3KkDErn+Z7F9gQd37E5DEPjmKs7jRZPwx2NH7uGJvb351EdNWRso2Xz135Y0pNg
         4zc7tWcjUUubp3q3RLF2dtxtJ2S/JDkmw8LKia0KJiMn9oJkhwQFDE/6M6DjXxOj9mSa
         xKt7xIdtbw9B44Kkm6hI52hl61so8C3dhaZV2B5drPnT/Arg6iq/XZY8pX3AMwn94Id+
         wJTA==
X-Forwarded-Encrypted: i=1; AJvYcCVVWxj0NVPIVcQ0HMyKVR+X9oCQHthLRJNeBSsXgjEXQZO+3vL4HEVSrHFnY7G69924foJ02id0yTytCVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywic5AW1WVnSm97Utja1R1HvPdlhJM+noTm2jEQ15RjzRn0QBZy
	MRCJ7doMoB+6qEHcEBSIN38A2hbH3OVq1TuKAErBmk7ZiU8CrBr9gW0zQONQUv0d1M1EMeJUe1b
	ktTsOD/mzOBACuX5sF/7o/tt4hVDvOJTy6d62eqk2x4DyKSiPodQHppM1Ptw=
X-Google-Smtp-Source: AGHT+IGeEo5gRzg6XyBLAyi+Vr1GdthS8LGLIfU+LPdUhTRw3vh3rH2LlCqcI3iErCRWUtOgiqZLODH3ezCexwPbpBPcCSduAWPk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3981:b0:430:be92:b60d with SMTP id
 e9e14a558f8ab-4335f4413c5mr38635555ab.26.1762513081877; Fri, 07 Nov 2025
 02:58:01 -0800 (PST)
Date: Fri, 07 Nov 2025 02:58:01 -0800
In-Reply-To: <CABBwEEhHeCq3Ry-6JoG1ruTTbfeRUKcYxTobQd88O8wYvOQBUQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690dd0b9.a70a0220.22f260.003b.GAE@google.com>
Subject: Re: [syzbot] [tipc?] KMSAN: uninit-value in tipc_rcv (2)
From: syzbot <syzbot+9a4fbb77c9d4aacd3388@syzkaller.appspotmail.com>
To: hariconscious@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in tipc_rcv

tipc: Started in network mode
tipc: Node identity a287e0d4fc68, cluster identity 4711
tipc: tipc_buf_acquire data len: 0
tipc: Enabled bearer <eth:syzkaller0>, priority 0
=====================================================
BUG: KMSAN: uninit-value in tipc_rcv+0x17fa/0x1ea0 net/tipc/node.c:2132
 tipc_rcv+0x17fa/0x1ea0 net/tipc/node.c:2132
 tipc_l2_rcv_msg+0x213/0x320 net/tipc/bearer.c:668
 __netif_receive_skb_list_ptype net/core/dev.c:6127 [inline]
 __netif_receive_skb_list_core+0x133e/0x16b0 net/core/dev.c:6169
 __netif_receive_skb_list net/core/dev.c:6221 [inline]
 netif_receive_skb_list_internal+0xee7/0x1530 net/core/dev.c:6312
 gro_normal_list include/net/gro.h:524 [inline]
 gro_flush_normal include/net/gro.h:532 [inline]
 napi_complete_done+0x3fb/0x7d0 net/core/dev.c:6681
 napi_complete include/linux/netdevice.h:589 [inline]
 tun_get_user+0x5953/0x6d70 drivers/net/tun.c:1924
 tun_chr_write_iter+0x3e9/0x5c0 drivers/net/tun.c:1999
 do_iter_readv_writev+0x9e1/0xc20 fs/read_write.c:-1
 vfs_writev+0x52a/0x1500 fs/read_write.c:1057
 do_writev+0x1b5/0x580 fs/read_write.c:1103
 __do_sys_writev fs/read_write.c:1171 [inline]
 __se_sys_writev fs/read_write.c:1168 [inline]
 __x64_sys_writev+0x99/0xf0 fs/read_write.c:1168
 x64_sys_call+0x24b1/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:21
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4977 [inline]
 slab_alloc_node mm/slub.c:5280 [inline]
 kmem_cache_alloc_node_noprof+0x989/0x16b0 mm/slub.c:5332
 kmalloc_reserve+0x13c/0x4b0 net/core/skbuff.c:579
 __alloc_skb+0x347/0x7d0 net/core/skbuff.c:670
 napi_alloc_skb+0xc1/0x740 net/core/skbuff.c:812
 napi_get_frags+0xab/0x250 net/core/gro.c:681
 tun_napi_alloc_frags drivers/net/tun.c:1404 [inline]
 tun_get_user+0x1352/0x6d70 drivers/net/tun.c:1784
 tun_chr_write_iter+0x3e9/0x5c0 drivers/net/tun.c:1999
 do_iter_readv_writev+0x9e1/0xc20 fs/read_write.c:-1
 vfs_writev+0x52a/0x1500 fs/read_write.c:1057
 do_writev+0x1b5/0x580 fs/read_write.c:1103
 __do_sys_writev fs/read_write.c:1171 [inline]
 __se_sys_writev fs/read_write.c:1168 [inline]
 __x64_sys_writev+0x99/0xf0 fs/read_write.c:1168
 x64_sys_call+0x24b1/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:21
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 6569 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
=====================================================


Tested on:

commit:         4a0c9b33 Merge tag 'probes-fixes-v6.18-rc4' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1365ca92580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2901a6a99b67fbcc
dashboard link: https://syzkaller.appspot.com/bug?extid=9a4fbb77c9d4aacd3388
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13631114580000



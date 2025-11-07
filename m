Return-Path: <linux-kernel+bounces-889836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DF5C3EA53
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 07:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1AFC7347BFC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 06:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25A0299ABF;
	Fri,  7 Nov 2025 06:46:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED38E20B7ED
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 06:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762497964; cv=none; b=bDme8vgXcwniV+IJMAymvyiMLOMSaj8GNlamjtVn2KCZHL7oujoJ2gFrzfLD3vigk/nGvQsgBMRLnCbRlWpq8verDB4VY6mlZLMxnDlj2kAQuxGBQXPuiL4Z6l0XQwPnXmQJBzF+baFeq+uf8efdL35sR6LUzSRIqvy+1lzfKkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762497964; c=relaxed/simple;
	bh=ZRcH2wZM81xB7xfgzDQBygtQj3uS5zhX61xICgxrFgg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qSF3EY+JFzZD1XZ7uu6+XTCj1M01LUf2RnHj28o7Cjt1da9eLdHR5K4pHNV6avufFfW6byOFRlBuBGduAu9+h/TCqQYobbrOG1sGOK9bX1aUxooXIqWAqIrmXczmPBLd6kgnJBCyqlj4XgRaJoG/QQkZzzI/zHdBH0JstRcO268=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4335b48ad16so5222625ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 22:46:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762497962; x=1763102762;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Ene69KxQbGVwBiIed9Xw4dLUusaWeN1R2moKCOeTP0=;
        b=UdD6Miv2XFXcsD0pLWwu5yIoe5LLZz2NOoIeHYbF/Zy+OkDu7ne0D70Ty7Wkq2Zd2v
         rOaUJELa1oxgqkQ2CU8M7nXrKnnxavkLrMZ9PnH9q/Bwd+TEjsorRKXuu4AEg1Oiaill
         F6uK5/S81PBUTPwxCen0yVGbXQZzN6gnuhCoTOs6l8o4+8EKnUfDejCnhHUMzpoFlfmG
         KqeX5Blj8RENNqwevib5vBB3O/WclGOq662yaQfGbmyE+cLefuqzz7inEc+FuO1Dyj8Z
         5Mm6Fk4McL0cUP83T/m31YF6623fh3fA22exo88RkB0y1YmeEEW/IhOOgijvx4kb7L/p
         0QkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtXtsUBwG+QYgOv0bppFUrNxSAkWrawRHZRQzsnjmgWIOspmVh8qM8BdaSXnc+31rt2TOGVcApYGoCJsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCBwqIPPPZ20doJ90rEbqoS/A9kN3Dq/9nGEn7by2PVbp1X5ob
	+nCW7m2RDy1TFtmXV1FSHsfJcXZNOkw8Xn7Abro02piJLKbtl3mudNSt+h6DxbkDs+2ZPuB3aF0
	nm+w+OiYs0JR23nyXuDFO8XokctV3ZudROJ4or0voaViunQXcJ7ANI8oI+Nk=
X-Google-Smtp-Source: AGHT+IGIRXuAFJjjB+GzUqJCWeaRPwIqICtPhzxQiwdIDYDGEqzEs40vA28xFnbxOatp9+Ej3L936x5VsPc7jNyCl85RqHl+V81j
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:98:b0:433:5e33:d427 with SMTP id
 e9e14a558f8ab-4335f3e17c3mr29675255ab.3.1762497962172; Thu, 06 Nov 2025
 22:46:02 -0800 (PST)
Date: Thu, 06 Nov 2025 22:46:02 -0800
In-Reply-To: <e8b78334-cb9f-900b-f05a-23a0d0ee902a@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690d95aa.a70a0220.22f260.001f.GAE@google.com>
Subject: Re: [syzbot] [tipc?] KMSAN: uninit-value in tipc_rcv (2)
From: syzbot <syzbot+9a4fbb77c9d4aacd3388@syzkaller.appspotmail.com>
To: hariconscious@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in tipc_rcv

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

CPU: 1 UID: 0 PID: 6553 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
=====================================================


Tested on:

commit:         4a0c9b33 Merge tag 'probes-fixes-v6.18-rc4' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=123c7012580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2901a6a99b67fbcc
dashboard link: https://syzkaller.appspot.com/bug?extid=9a4fbb77c9d4aacd3388
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=104a332f980000



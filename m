Return-Path: <linux-kernel+bounces-863100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40662BF702A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3163B5429B4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0125A283C83;
	Tue, 21 Oct 2025 14:17:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4951624C0
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056225; cv=none; b=UNHJTRbhMhdnf4Dto8sXMzBP9wKKnlSM8lMPi4AvDBDeFIm7j5QDxOlF3huwm4yTfLITob88URHX/ycasGPwCUHIOSvgndYGDskZJHjNH0Jv0ULw0a8YDdPFgG2HrbH26WbZvxbdBQ/gGkeupbGtFScQxS2r5fMuR3zBCyfLmRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056225; c=relaxed/simple;
	bh=LAhit4dLaQBeaZfWPUv57oDPPeF1JGwkHWAxl3wAMGQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KPW0qf7dAm+KU+pJos5KYW4XtXWz+ZiL8vtPfOqbo+Vm/CLBOdzETO8t8QV0XKZgfgHdulj7fzeyiODKLhoZh/ggFaRw/vCWqroRK5YF5dHpptAfd0efFzsEj4JwmYZR+VV8E5iTeK31RBSpbS3I+xE3Bq8D2p81GiqL9zvXTjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-940d3efe58bso273995239f.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761056223; x=1761661023;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NfrSgQ32bFaTalGj62QX9vovctmokLdOJHXQqUA1PZk=;
        b=dzOECDzLnFe/gKt+JgC8iIN8kpT7IXiDEf31ULlxQUP4nFtW7maKiBgbTTFHJHYRln
         QYScrQEFkyxe/TPQ8EJM3r08j7brFXmh/q6NofCUnnX/BqiPhJaacjPweIrY5Nnr7IdI
         R6qri5g3pFf+I5wwli9/KsybzXkyWKY9h/9f07CKk0dFQRGVROBNYzo2s7vtqAfFDnDa
         LvjD/eY8ZUIVYiEQ+iFl1yZwUccs97dBW/WFcFJtGUQn5jYvW0a1Z3fd47xoKnap25Tz
         NwKa0lCqeBG2G14m7sTYN5bi+7OfNuszeMVIjvp2GChFQOAAv7/t2CsAzRS65Wb5KNa1
         047w==
X-Gm-Message-State: AOJu0YxUxxgzSvje2wfFJY5LZ6KSzj41uHMuq1zI7LOSXKMElurgCGED
	iYMhmEMQYJAUnTBxGZqmu2NmXwJYwqJ6PF9LU8YF+FRpdi4CMrjvHgQAENHyLZPeB3Cx9mlp9Go
	pmq1lKSbEuAL5JxQxwdfYGnspjE+PpRHspa99EE5IpUY7ykPWn84Il7MHHNA=
X-Google-Smtp-Source: AGHT+IE9E0zvFw8ZIrJdN6LTNXmfa9h3D38KlQrtVoBo3KttdG6C4sqbmNfhKTmcxDgEUMk1/2cMfChM2qrhKb74qssrJzfdXPWU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda3:0:b0:430:b4ca:2696 with SMTP id
 e9e14a558f8ab-430c514e290mr258314665ab.0.1761056222788; Tue, 21 Oct 2025
 07:17:02 -0700 (PDT)
Date: Tue, 21 Oct 2025 07:17:02 -0700
In-Reply-To: <e22jzcxyc6o2gng7lx6bskmpxhejatjm7x7q3rzlk33ji6dqhh@r4jqd66ocktj>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f795de.050a0220.346f24.001d.GAE@google.com>
Subject: Re: [syzbot] [wireless?] KMSAN: uninit-value in cfg80211_classify8021d
From: syzbot <syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, listout@listout.xyz, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in cfg80211_classify8021d

mac80211_hwsim hwsim9 wlan1: entered allmulticast mode
=====================================================
BUG: KMSAN: uninit-value in cfg80211_classify8021d+0x99d/0x12b0 net/wireless/util.c:1027
 cfg80211_classify8021d+0x99d/0x12b0 net/wireless/util.c:1027
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

CPU: 1 UID: 0 PID: 6608 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
=====================================================


Tested on:

commit:         6548d364 Merge tag 'cgroup-for-6.18-rc2-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15830d2f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bbd3e7f3c2e28265
dashboard link: https://syzkaller.appspot.com/bug?extid=878ddc3962f792e9af59
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14e3fde2580000



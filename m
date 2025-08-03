Return-Path: <linux-kernel+bounces-754355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A19B19339
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 11:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 387A0173265
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 09:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF7E287511;
	Sun,  3 Aug 2025 09:39:32 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8B4242D79
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 09:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754213971; cv=none; b=VVhInji5l/RPaaoYrhBU5+WEJ0RQImkCuq/daxBmwN36Pw0Ta4nerVVJCeFACecUZ71gxqOimrn46yqF67PYGFdKkLC9e1M4NbfpXhPF7/EiA1rMRZj6DBcsoH6JSMFTB9cpYBh6UNWmrZT7q7l9dyoeMo/wwrNcIr7q2SzwObU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754213971; c=relaxed/simple;
	bh=me+MDMUhWRUOn6twry0ANbpGXGMjQncaO7/NSz6OS9k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jmKlPrCWquDayHWsUex3UdjApW89pF7EQyA1eA+lZNh0pF67L/vbulm9tee/rEL02CL6ueh+Gib+80zwtuGpyVMXfnT+1S9f04gQJlawSBWD1Li+ANQcz8emuh7COxVnvvYgY67heHarQNuYYHjyjBw8UsjrP28aKgCfF1YfCL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-88177d99827so36972939f.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 02:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754213969; x=1754818769;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U0LWSoiEUjnDRuPcXhZsxJI/YVjUTAHuiFyMIyM36SQ=;
        b=icDvEAKeCog/vLS/+Pwx7IM0KPiUaGH//Z0QSA8W3J3NeP7gB3E/v6OiRnOFTPzh0e
         Qyc38xvtTwBni+b+298RSeVhKQ6IW38HFYzkdegRtuV4qGVPHYQ5yEIU9hsHD57wBEko
         c8Bj06YU0QWt1XKPs90g1ouXGdwcal80s+VeRyPjn9/wUFcbKJOJflaga9TpmhdjTcY+
         0Fbzxiz3ksm/Y3BLc+aApvTi1MH1N47Mw6QUEqxkGbbV/2QrpSKPgEEW2X89K+tuDgtu
         eIKPeHmEv7tkgGl076hhSZtbk6nGxabN0+qpCGhiYHLKaVudBdKa7TBRhJndzKzvhowv
         la2w==
X-Forwarded-Encrypted: i=1; AJvYcCX0jiPWxJB8HtXmtjgXp+C0xmmciykt5SUurVeJ62iOJaSThuhvwpkdO+H60cIk5nFdKqpq8s4VfPpCFOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAa6igRBPIMjSE0HzCKCym6mdFMSFfVXcgs1LOtPpFDg189im1
	EzrxlEyVn5Ms2ROJrdHujnCTrCsKiL2Tus90mRpix7+zEqkSHx5TPe46F7jL9Zuu2ul5qn2gdWM
	lpdCErzkgrlv6kNmJ7N/ck0fs2a1H3YfR3tjbcwfz7Udw0LKtfUcV4z9Az74=
X-Google-Smtp-Source: AGHT+IFlNsObHPzdzv2suMhd+3PPDPLZO8uF5MVEeqlO7lgZa0M6JGbqSTtaoNkHax1Z8ldtkc+MQUSdBwQDdEgHF+wtCm1FAJux
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:26ca:b0:87c:1d65:3aeb with SMTP id
 ca18e2360f4ac-88168318805mr1125317139f.2.1754213969260; Sun, 03 Aug 2025
 02:39:29 -0700 (PDT)
Date: Sun, 03 Aug 2025 02:39:29 -0700
In-Reply-To: <6880f58e.050a0220.248954.0001.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688f2e51.050a0220.1fc43d.0002.GAE@google.com>
Subject: Re: [syzbot] [tipc?] KMSAN: uninit-value in tipc_rcv (2)
From: syzbot <syzbot+9a4fbb77c9d4aacd3388@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jmaloy@redhat.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tipc-discussion@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    89748acdf226 Merge tag 'drm-next-2025-08-01' of https://gi..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1395bcf0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7ff65239b4835001
dashboard link: https://syzkaller.appspot.com/bug?extid=9a4fbb77c9d4aacd3388
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1625ff82580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=131bb834580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ce090dd92dc2/disk-89748acd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/32b5903a7759/vmlinux-89748acd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dc68a867773d/bzImage-89748acd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9a4fbb77c9d4aacd3388@syzkaller.appspotmail.com

tipc: Started in network mode
tipc: Node identity 4689370d27fe, cluster identity 4711
tipc: Enabled bearer <eth:syzkaller0>, priority 0
=====================================================
BUG: KMSAN: uninit-value in tipc_rcv+0x17fa/0x1ea0 net/tipc/node.c:2132
 tipc_rcv+0x17fa/0x1ea0 net/tipc/node.c:2132
 tipc_l2_rcv_msg+0x213/0x320 net/tipc/bearer.c:668
 __netif_receive_skb_list_ptype net/core/dev.c:6027 [inline]
 __netif_receive_skb_list_core+0x133b/0x16b0 net/core/dev.c:6069
 __netif_receive_skb_list net/core/dev.c:6121 [inline]
 netif_receive_skb_list_internal+0xee7/0x1530 net/core/dev.c:6212
 gro_normal_list include/net/gro.h:532 [inline]
 gro_flush_normal include/net/gro.h:540 [inline]
 napi_complete_done+0x3fb/0x7d0 net/core/dev.c:6581
 napi_complete include/linux/netdevice.h:589 [inline]
 tun_get_user+0x4c0d/0x6ca0 drivers/net/tun.c:1921
 tun_chr_write_iter+0x3e9/0x5c0 drivers/net/tun.c:1996
 do_iter_readv_writev+0x947/0xba0 fs/read_write.c:-1
 vfs_writev+0x52a/0x1500 fs/read_write.c:1057
 do_writev+0x1b5/0x580 fs/read_write.c:1103
 __do_sys_writev fs/read_write.c:1171 [inline]
 __se_sys_writev fs/read_write.c:1168 [inline]
 __x64_sys_writev+0x99/0xf0 fs/read_write.c:1168
 x64_sys_call+0x24b1/0x3e20 arch/x86/include/generated/asm/syscalls_64.h:21
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4186 [inline]
 slab_alloc_node mm/slub.c:4229 [inline]
 kmem_cache_alloc_node_noprof+0x818/0xf00 mm/slub.c:4281
 kmalloc_reserve+0x13c/0x4b0 net/core/skbuff.c:578
 __alloc_skb+0x347/0x7d0 net/core/skbuff.c:669
 napi_alloc_skb+0xc1/0x740 net/core/skbuff.c:811
 napi_get_frags+0xab/0x250 net/core/gro.c:673
 tun_napi_alloc_frags drivers/net/tun.c:1404 [inline]
 tun_get_user+0x134f/0x6ca0 drivers/net/tun.c:1784
 tun_chr_write_iter+0x3e9/0x5c0 drivers/net/tun.c:1996
 do_iter_readv_writev+0x947/0xba0 fs/read_write.c:-1
 vfs_writev+0x52a/0x1500 fs/read_write.c:1057
 do_writev+0x1b5/0x580 fs/read_write.c:1103
 __do_sys_writev fs/read_write.c:1171 [inline]
 __se_sys_writev fs/read_write.c:1168 [inline]
 __x64_sys_writev+0x99/0xf0 fs/read_write.c:1168
 x64_sys_call+0x24b1/0x3e20 arch/x86/include/generated/asm/syscalls_64.h:21
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 5808 Comm: syz-executor123 Not tainted 6.16.0-syzkaller-10499-g89748acdf226 #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


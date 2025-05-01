Return-Path: <linux-kernel+bounces-628430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD119AA5DA9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 13:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6615F3AB4BD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 11:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996918828;
	Thu,  1 May 2025 11:15:37 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2111DE8B4
	for <linux-kernel@vger.kernel.org>; Thu,  1 May 2025 11:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746098137; cv=none; b=OrfBhKiRm+i8qYDdZjDmYshxuJD2FL5h0Bbi60zfErtoLPMQTO4eqLR9rAD2YGGkj6jQYdgaLWZcnMfLMCqPQZAVkeEYNA0RR5FPJ4rSgviENH/m0XS2gqWgg/EKbFicqZa0iZRvoVzrRos6k3VfJ9xXNtT0Xle6EXhwcTNXvB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746098137; c=relaxed/simple;
	bh=AdCnrHlckiLY9w50M2RlnW6B4F1N+rctOdeW1iF/YIY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qG7HMySd/T6O/jjJFUF2hG5JoAH1NVQ99H+OiJUtSkhFFI/Hd575Qpi6X9omcsibOfX6wpZBK+8Ah6U43qe/B1iwbOzbfMSoMhTrORD8x07Mpkh3P+f3GmjFSlBGxDSvgs6t64sg3EuaObJABk/QBsytmdtjX+H8jxPyI0rE4HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-85e7f5129d5so81704139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 May 2025 04:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746098134; x=1746702934;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SQJrXJqX12ekCJI9r32k9hMJcJ8Y6oUBGGTUv5VbCSU=;
        b=OpaM0wuj2YSPSYrx24dWfV2FujzOWESNkrZaNgDmdSVnrmRRYHY3eHNcQ5qNZCrQDm
         QDu3SN+olMRk/kBa/HfdvhkWx8bYhdKfwdvMmwbO+ZJEKLL6F96V774JtfLB9+pezUFV
         FSTE4UrjOlpGZLU4Pq9d10g76hHouE1Dw1n9wsmg4o2NWvahdQUrtxqoY4/Wu1HlQyJQ
         r7AksdibVSi+J6s302S17dUTGgA1uDghAY9igSw5oq1FQmYbs4dd1CU3pwCGooNJjCVr
         a8uLYmyBcIPXBEbTfS9pJiCaP2C+om3MzCO/byMhOYIxfKSC69B0PrJGiWAOtvYgdpgq
         eGxw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ+2RI7iEO2qnfIGvl0bdwmC8PVISVatC57vW0rETGBoSmKznqx8NDsJkYeAS35xAX7t3HhImg+nmjPbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHB9fltjOvfAsW8SJILxulYPhpzP8q9mv+vZkcPxFcD2QNhycR
	pyIjWqaa5QkAWvNW3AqvS/ATPcIPQgHnn2iaUw7sMOXcKS8TvvZrk3fRP2a+TaIZ6kdc9gGTkp+
	ISGd6BWaYP/SAwQJCdS24WNTJqqDeVVwbBlSkPpgPzERROVH1eQADg5g=
X-Google-Smtp-Source: AGHT+IEvJble2/n4Ejv3r+vofsmt0pigGSfoyD5BKOPJZO8jt7mTTxdmmVYbeyiFJlwxDdVDbrzWuPGpyPvJZeIs7vOdtmPh2qZy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2989:b0:864:9cc7:b847 with SMTP id
 ca18e2360f4ac-864a22de042mr320149839f.14.1746098134682; Thu, 01 May 2025
 04:15:34 -0700 (PDT)
Date: Thu, 01 May 2025 04:15:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <681357d6.050a0220.14dd7d.000d.GAE@google.com>
Subject: [syzbot] [net?] upstream test error: KMSAN: use-after-free in mctp_dump_addrinfo
From: syzbot <syzbot+1065a199625a388fce60@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jk@codeconstruct.com.au, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	matt@codeconstruct.com.au, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4f79eaa2ceac kbuild: Properly disable -Wunterminated-strin..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15bc71b3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53c85d265a8f3692
dashboard link: https://syzkaller.appspot.com/bug?extid=1065a199625a388fce60
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3594998c29f0/disk-4f79eaa2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2cd908ac5281/vmlinux-4f79eaa2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5ea15b7bacde/bzImage-4f79eaa2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1065a199625a388fce60@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: use-after-free in mctp_dump_addrinfo+0x208/0xac0 net/mctp/device.c:128
 mctp_dump_addrinfo+0x208/0xac0 net/mctp/device.c:128
 rtnl_dump_all+0x3ec/0x5b0 net/core/rtnetlink.c:4380
 rtnl_dumpit+0xd5/0x2f0 net/core/rtnetlink.c:6824
 netlink_dump+0x97b/0x1690 net/netlink/af_netlink.c:2309
 __netlink_dump_start+0x716/0xd60 net/netlink/af_netlink.c:2424
 netlink_dump_start include/linux/netlink.h:340 [inline]
 rtnetlink_dump_start net/core/rtnetlink.c:6853 [inline]
 rtnetlink_rcv_msg+0x1262/0x14b0 net/core/rtnetlink.c:6920
 netlink_rcv_skb+0x54a/0x680 net/netlink/af_netlink.c:2534
 rtnetlink_rcv+0x35/0x40 net/core/rtnetlink.c:6982
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0xed5/0x1290 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x10b3/0x1250 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x330/0x3d0 net/socket.c:727
 __sys_sendto+0x590/0x710 net/socket.c:2180
 __do_sys_sendto net/socket.c:2187 [inline]
 __se_sys_sendto net/socket.c:2183 [inline]
 __x64_sys_sendto+0x130/0x200 net/socket.c:2183
 x64_sys_call+0x3c0b/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:45
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_free_hook mm/slub.c:2324 [inline]
 slab_free mm/slub.c:4656 [inline]
 kmem_cache_free+0x286/0xf00 mm/slub.c:4758
 skb_kfree_head net/core/skbuff.c:1056 [inline]
 skb_free_head net/core/skbuff.c:1070 [inline]
 skb_release_data+0xe56/0x1110 net/core/skbuff.c:1097
 skb_release_all net/core/skbuff.c:1162 [inline]
 __kfree_skb+0x6b/0x260 net/core/skbuff.c:1176
 consume_skb+0x83/0x230 net/core/skbuff.c:1408
 netlink_broadcast_filtered+0x21b6/0x2370 net/netlink/af_netlink.c:1524
 nlmsg_multicast_filtered include/net/netlink.h:1129 [inline]
 nlmsg_multicast include/net/netlink.h:1148 [inline]
 nlmsg_notify+0x15b/0x2f0 net/netlink/af_netlink.c:2577
 rtnl_notify+0xba/0x100 net/core/rtnetlink.c:958
 inet6_rt_notify+0x27d/0x4a0 net/ipv6/route.c:6270
 fib6_add_rt2node net/ipv6/ip6_fib.c:1259 [inline]
 fib6_add+0x33c7/0x6c70 net/ipv6/ip6_fib.c:1488
 __ip6_ins_rt net/ipv6/route.c:1351 [inline]
 ip6_ins_rt+0xc0/0x170 net/ipv6/route.c:1361
 __ipv6_ifa_notify+0x851/0x1990 net/ipv6/addrconf.c:6283
 ipv6_ifa_notify net/ipv6/addrconf.c:6322 [inline]
 add_addr+0x301/0x4c0 net/ipv6/addrconf.c:3206
 init_loopback net/ipv6/addrconf.c:3289 [inline]
 addrconf_init_auto_addrs+0xb53/0x10e0 net/ipv6/addrconf.c:3564
 addrconf_notify+0x1643/0x1d10 net/ipv6/addrconf.c:3741
 notifier_call_chain kernel/notifier.c:85 [inline]
 raw_notifier_call_chain+0xdd/0x410 kernel/notifier.c:453
 call_netdevice_notifiers_info+0x1ac/0x2b0 net/core/dev.c:2176
 call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
 call_netdevice_notifiers net/core/dev.c:2228 [inline]
 __dev_notify_flags+0x20d/0x3c0 net/core/dev.c:-1
 netif_change_flags+0x162/0x1e0 net/core/dev.c:9434
 dev_change_flags+0x18c/0x320 net/core/dev_api.c:68
 devinet_ioctl+0x1186/0x2500 net/ipv4/devinet.c:1200
 inet_ioctl+0x4c0/0x6f0 net/ipv4/af_inet.c:1001
 sock_do_ioctl+0x9c/0x480 net/socket.c:1190
 sock_ioctl+0x70b/0xd60 net/socket.c:1311
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0x239/0x400 fs/ioctl.c:892
 __x64_sys_ioctl+0x97/0xe0 fs/ioctl.c:892
 x64_sys_call+0x1ebe/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 5440 Comm: dhcpcd Not tainted 6.15.0-rc4-syzkaller-00052-g4f79eaa2ceac #0 PREEMPT(undef) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/19/2025
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup


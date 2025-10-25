Return-Path: <linux-kernel+bounces-870044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7BDC09CF2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 19:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C28874FCC2E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD3B303A33;
	Sat, 25 Oct 2025 16:40:24 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6F82F5A2D
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410424; cv=none; b=c6KeVP53XMXIcTYY5FWQbwVpqyRk3t41XtR7kR3E7sVx/6b7HkhxZ5HrmMDdW6HzxOCzXvSdiTfh2aBxvenKXJojrCAaeihoWGlrhkZcqQvuH52SkQ072+Flsn7hP3xFKmFYk+9G7oGQgY3SQ1IFQJLaPU6KIZg6jJJoC6VkVlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410424; c=relaxed/simple;
	bh=IRBVnuQ2FKr6cm1CrZpwpIEDNABcXIhOzTRZSSkbA4o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=udSwRoPlPSOelmb864QeJ2lKwCJqCTUBTsynltIlpX/yS1MuG8uRKazaj3kLo1KaKagvjfgSwIOKjdjNz+g21JERbMMBnMvp9wC+AG+ZagvQqR/20pjImIpbC5PGIXXP9Yp9T8YVlvP2O7gqOL9gapQw9NOSSyLHhM/yhoNq8/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-430b3c32f75so32991975ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410422; x=1762015222;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f09ReGk/rcCE84mTMJ810aYtA5hb5qGQWaYl+no6AWs=;
        b=dlHZJTYAebzNP6QMOw194iVQeqqcf3/e+s0rvgvpttxq7Z/t7+8RU+IIT3/w/GhfrQ
         v1gwtBSkEZ/UlwYLszjSXpHMsSW352va7RlRzordhGVGC6C8R7B72qfW2G/UuGg59WNm
         gC1sFkFs/Ijt+5aafm6oHQE8yYk0Vn4YipbgHdnLa6QVOr6s70ZYc/pBDLgDBkZbAcPI
         8Tt+oL8d84NZUDwmaevi/2qtiHxawqI4Xionm1bBvWvyj+fi4A0kqUKP81LvpfqaIfjp
         iDtT/9WrRJRQuYKeGlGBnBA/Ix9hlHX4iSSb9/QlfGSrV2XQ5lXZgKcz1BUmbWUCxkZ8
         4GUA==
X-Forwarded-Encrypted: i=1; AJvYcCXDnG+XR7ZQBxngF7V2Gg8eIdq3Q/L/t+mgjbLWt3hfMcsHqVTCMP2i7j/WrZMVCem2IB1B7dfVyP/toqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy6Slm3qWwPm1UmoWDpaT++stTLNC9hBmwUwHeia7oDGjfStKl
	B3bCDsFKketNr6RpdQ1So2Dyh5aEpA9Yrrn8rFeVDBWzv+MALSLHYeWvr9J1qMA8rpdl7jnTvN8
	6BYxCygpMLunjTdZ5Ie4NUe7tOyA+DZoHaCT9+CTRTVQHgfoKit6vRXApcTE=
X-Google-Smtp-Source: AGHT+IEizQRhbwzsT0ggg2NbSvLb9A6mZiSSmAn0Yfk/ZQAxOcHAEaCQbj3upjiHzCayK+nIiXCaAoQeo8YggenpKLKisWYRQsuC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2197:b0:42f:87c1:cc3f with SMTP id
 e9e14a558f8ab-430c526b099mr477214245ab.18.1761410421784; Sat, 25 Oct 2025
 09:40:21 -0700 (PDT)
Date: Sat, 25 Oct 2025 09:40:21 -0700
In-Reply-To: <68dc3dac.a00a0220.102ee.004f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fcfd75.050a0220.346f24.02ff.GAE@google.com>
Subject: Re: [syzbot] [rdma?] KMSAN: uninit-value in ib_nl_handle_ip_res_resp
From: syzbot <syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com>
To: enjuk@amazon.com, jgg@ziepe.ca, leon@kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yanjun.zhu@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    566771afc7a8 Merge tag 'v6.18-rc2-smb-server-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12f017e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dce7eac4016da338
dashboard link: https://syzkaller.appspot.com/bug?extid=938fcd548c303fe33c1a
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13714be2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=100b5d2f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bc5e0bc7a5d9/disk-566771af.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6b2be7ad3b45/vmlinux-566771af.xz
kernel image: https://storage.googleapis.com/syzbot-assets/09a4929333f1/bzImage-566771af.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com

netlink: 8 bytes leftover after parsing attributes in process `syz.0.18'.
=====================================================
BUG: KMSAN: uninit-value in hex_byte_pack include/linux/hex.h:13 [inline]
BUG: KMSAN: uninit-value in ip6_string+0xef4/0x13a0 lib/vsprintf.c:1490
 hex_byte_pack include/linux/hex.h:13 [inline]
 ip6_string+0xef4/0x13a0 lib/vsprintf.c:1490
 ip6_addr_string+0x18a/0x3e0 lib/vsprintf.c:1509
 ip_addr_string+0x245/0xee0 lib/vsprintf.c:1633
 pointer+0xc09/0x1bd0 lib/vsprintf.c:2542
 vsnprintf+0xf8a/0x1bd0 lib/vsprintf.c:2930
 vprintk_store+0x3ae/0x1530 kernel/printk/printk.c:2252
 vprintk_emit+0x21a/0xb60 kernel/printk/printk.c:2399
 vprintk_default+0x3f/0x50 kernel/printk/printk.c:2438
 vprintk+0x36/0x50 kernel/printk/printk_safe.c:82
 _printk+0x17e/0x1b0 kernel/printk/printk.c:2448
 ib_nl_process_good_ip_rsep drivers/infiniband/core/addr.c:128 [inline]
 ib_nl_handle_ip_res_resp+0x963/0x9d0 drivers/infiniband/core/addr.c:141
 rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:-1 [inline]
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0xefa/0x11c0 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0xf04/0x12b0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x10b3/0x1250 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x333/0x3d0 net/socket.c:742
 ____sys_sendmsg+0x7e0/0xd80 net/socket.c:2630
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2684
 __sys_sendmsg net/socket.c:2716 [inline]
 __do_sys_sendmsg net/socket.c:2721 [inline]
 __se_sys_sendmsg net/socket.c:2719 [inline]
 __x64_sys_sendmsg+0x211/0x3e0 net/socket.c:2719
 x64_sys_call+0x1dfd/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable gid.i created at:
 ib_nl_process_good_ip_rsep drivers/infiniband/core/addr.c:102 [inline]
 ib_nl_handle_ip_res_resp+0x254/0x9d0 drivers/infiniband/core/addr.c:141
 rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:-1 [inline]
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0xefa/0x11c0 drivers/infiniband/core/netlink.c:259

CPU: 0 UID: 0 PID: 6093 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


Return-Path: <linux-kernel+bounces-889408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0B9C3D7E6
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 22:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 662694E5571
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 21:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B013306497;
	Thu,  6 Nov 2025 21:26:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C3C1D432D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 21:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762464366; cv=none; b=LwpxS9kOB+z4WROpbPp/cGDcmzphy3o1D6NKVE5NuJNEfev2/c6bR/Ejf+atR8GClFBKVMHS8XX2IaG9qxd300fsbfJT4klvKfXB8/4JX5mYm60whx/1WrkAADzA3GgeR1ElLiI7VFfFnP1Qa2C/kfljan7DU8JeFgXymfsfjr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762464366; c=relaxed/simple;
	bh=ckGsULZOqfyN7BeKL403VyI5J/k6AYgxRGh2pbJYtCE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=j9J8SPtC+UlS03pJpZgCID195voi40axxSBnmeMp4Xr92KHMf7swNXd+MK+bcn5H//GGT+UGtlbwL2um1uZ1LoeyJVFq+GgF/8NY635Q5lLul44/M6EBeEqsOUxZvyAf0bzO3ONzZ0Dxx0SSBUoFipgp/E+bd6HVvlm9cmLFrSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-945aa9e086eso11990539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 13:26:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762464363; x=1763069163;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jz2S59Y0zDXFTl3UUURkpOx0+XGNCrEVIltRFIbAnkU=;
        b=RgkRs4ABaksQ51fKs56msNL4oxcqzX61d6sC6PFklP3C5c86+l09M0UmI8s64ybYjg
         L/2gUoI26xPi/0q8KML+WK3U3MHgFnvtti0Jc5wQhAjGyDkf+Pe6N8yooCyldNArm1M3
         yqPVLgIvC6KkwIzj3Qe4XiLhfsJl4Itcg1fxgdv0wAgTuP6TEMQZlMFd+xC7sTlq+ee5
         OooqAl1z06cm0xP0ZCRrf79OT6pV8ev1kr7BxRKyb/0vz5p0EFcGOFf90s0d7Z+7ew6M
         +jYkOEW9OpX7v36MCmPw3n2uLLb3cehsQfiynP56aZHGY1+Jaq6dNX7FUfXZuCjU8Sk6
         kIDg==
X-Forwarded-Encrypted: i=1; AJvYcCUMXX5u9WWVP5lMNoREm2SWOMedU4tnDAPIO3AAJTi24iha5BaxTT4Qq22kwOuEYx10dj/oy2eXzDAPbW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLRC8uH1cq/3+KScFFZMBbw9iKE2kzG83Wz3LuI+LNjQUAth1F
	psE1jr5t+Ku1SnDw4lpSLoWSW+Lh5jvVHiwPMSq1/4Y0WeMKPoZyGJf4EljmdFHabh2xWV9xSm7
	c5crZWJwukPrZJ9T5AdVIp8owQihzkxqE0i8HW+RTOqzB6BI+SSvucSfPpOY=
X-Google-Smtp-Source: AGHT+IH6Rlakky+B1FMKFGDMdZIb9kKUWczhDAqTuYn1LVDKzP3s3DyNNbsFnmRhptU/HQAAA+/9ZbMPJxJ/bnTjWWB31/jiONDQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:728d:b0:918:46b7:4d35 with SMTP id
 ca18e2360f4ac-94879612d89mr679029539f.6.1762464363574; Thu, 06 Nov 2025
 13:26:03 -0800 (PST)
Date: Thu, 06 Nov 2025 13:26:03 -0800
In-Reply-To: <CAL4kbROgTGYT2WQH7ZqEirdHgduUFpixG1rStnQ-5pPaUbA-0w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690d126b.a70a0220.22f260.000b.GAE@google.com>
Subject: Re: [syzbot] [rdma?] KMSAN: uninit-value in ib_nl_handle_ip_res_resp
From: syzbot <syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com>
To: kriish.sharma2006@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in ib_nl_handle_ip_res_resp

netlink: 8 bytes leftover after parsing attributes in process `syz.0.17'.
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

CPU: 0 UID: 0 PID: 6563 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
=====================================================


Tested on:

commit:         566771af Merge tag 'v6.18-rc2-smb-server-fixes' of git..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=1748e17c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dce7eac4016da338
dashboard link: https://syzkaller.appspot.com/bug?extid=938fcd548c303fe33c1a
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.


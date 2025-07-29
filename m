Return-Path: <linux-kernel+bounces-749054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D8DB14967
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB9457A7556
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4574D26B093;
	Tue, 29 Jul 2025 07:51:37 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B8E246BDE
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 07:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753775496; cv=none; b=E4OHW2MmKAhjIAI1KLicbWa407Zxa9QB9iWSWd72cM0WTKS/h/zcTQx5ys1TgYXjVo7iCT8Not+PKhh1wSmz3dcX9HmhaXscEOXU+twW82FoAGUk8Ok3/Es6Q57mFY+OJotNNsg7RGU6YnYkvK3Wa84hie+y7foB4R0BiFoG6vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753775496; c=relaxed/simple;
	bh=jcxsM0Frh3Bu1OpIClqfqFLeWmFMomNBaKrHAHVKiRA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pUF4xYobLklNd+7d4blM7/hSmNvKENZrtgPmXGnnZ1IONLSjhtjDBTxzVkse0CC5blFt+LugBOQ7LjsuHA147CSk73PD4vO+7v9lfNNfzuYKFqHfZsSVIC75Blv7FDWAG2rX+D8yNm0DxxW6wa2suItpLoewGqqB/mSRhwv9XGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-87c30329a56so1131410039f.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 00:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753775494; x=1754380294;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nwiZttZ/udedfdRnutqiHE6++E8ELPKNs9T/xXTO6LQ=;
        b=E3FRg1MvrZ/3CxXRcoubalV2hVRq1FDvu24AOt55HSxI0UJ70LtLjkPySwo4hPiyuX
         iNz8yVn/6Nr8t3krgfAH92/c1RS6dh67iddqZ4N7LPNEidzu110vRqF78cJxb3xb6oMK
         +zH3LgN3LQDh3GzUr2SDrqJJNjeJVi3+gP/yO44PrKHhqYD2OCdWlAt6Q61lTziCO1qj
         cK/Ndh8vLuk091m0XDQQvji7aaOpJhGH0/HqoL0kdEJ73z74qgg2lR8ZKhqyfABrxa+k
         3LVOkF/yv+ggSS/xbKRjdngTQdKWFxO4HdSEzvFDny+/hL0oX1fJ4e2ABEfYSBhTqwSV
         pxHw==
X-Forwarded-Encrypted: i=1; AJvYcCWHQPkRXQFTgIze3Q3MGlqzrawk9KouKGgzf92arI7KJCbav2E/+h5H86XiJc0qH5Ec8Sfz/Hlda1aN1nM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCAR2Q8W3fG9Z9anA/2F32HMizMrpvkEVUkY/H5iVURncmyTqP
	ODcq1WhDYXMW4L4fOKv7jiDXs5ySHIVW3Tvy+JXy61csEQeC8lndOrZhBh4EOxn2LMhkiWSppLN
	wzo52ZYGr+F5qAVvuT0SEQ5/rfX9/VA9W+r7YGpGePamQOj+rekIy1+iA9dg=
X-Google-Smtp-Source: AGHT+IFvSSfKpB1q9X+Ujg9aloTRo5257ymL4mV23VlrgioSXaYg5es+1vpGB7rHN1kHE0qJ2ukqwaigKEw8BM3gEYQI9XwyAY6x
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:260b:b0:3e3:d246:55fb with SMTP id
 e9e14a558f8ab-3e3d2465d5cmr194963115ab.15.1753775494338; Tue, 29 Jul 2025
 00:51:34 -0700 (PDT)
Date: Tue, 29 Jul 2025 00:51:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68887d86.a00a0220.b12ec.00cd.GAE@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in pptp_xmit (3)
From: syzbot <syzbot+afad90ffc8645324afe5@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    038d61fd6422 Linux 6.16
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=139e9034580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc98b07dbc3d5a34
dashboard link: https://syzkaller.appspot.com/bug?extid=afad90ffc8645324afe5
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=163b84a2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a594a2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/58944a2f9bd3/disk-038d61fd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c9a849a27d33/vmlinux-038d61fd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0de16772849a/bzImage-038d61fd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+afad90ffc8645324afe5@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in pptp_xmit+0xc34/0x2720 drivers/net/ppp/pptp.c:193
 pptp_xmit+0xc34/0x2720 drivers/net/ppp/pptp.c:193
 ppp_channel_bridge_input drivers/net/ppp/ppp_generic.c:2290 [inline]
 ppp_input+0x1d6/0xe60 drivers/net/ppp/ppp_generic.c:2314
 pppoe_rcv_core+0x1e8/0x760 drivers/net/ppp/pppoe.c:379
 sk_backlog_rcv+0x142/0x420 include/net/sock.h:1148
 __release_sock+0x1d3/0x330 net/core/sock.c:3213
 release_sock+0x6b/0x270 net/core/sock.c:3767
 pppoe_sendmsg+0x15d/0xcb0 drivers/net/ppp/pppoe.c:904
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x330/0x3d0 net/socket.c:727
 ____sys_sendmsg+0x893/0xd80 net/socket.c:2566
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2620
 __sys_sendmmsg+0x2d9/0x7c0 net/socket.c:2709
 __do_sys_sendmmsg net/socket.c:2736 [inline]
 __se_sys_sendmmsg net/socket.c:2733 [inline]
 __x64_sys_sendmmsg+0xc6/0x150 net/socket.c:2733
 x64_sys_call+0x3ce7/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:308
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4154 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 __do_kmalloc_node mm/slub.c:4327 [inline]
 __kmalloc_node_track_caller_noprof+0x96d/0x12f0 mm/slub.c:4347
 kmalloc_reserve+0x22f/0x4b0 net/core/skbuff.c:601
 pskb_expand_head+0x1fc/0x1610 net/core/skbuff.c:2241
 skb_realloc_headroom+0x152/0x2d0 net/core/skbuff.c:2321
 pptp_xmit+0x9d4/0x2720 drivers/net/ppp/pptp.c:181
 ppp_channel_bridge_input drivers/net/ppp/ppp_generic.c:2290 [inline]
 ppp_input+0x1d6/0xe60 drivers/net/ppp/ppp_generic.c:2314
 pppoe_rcv_core+0x1e8/0x760 drivers/net/ppp/pppoe.c:379
 sk_backlog_rcv+0x142/0x420 include/net/sock.h:1148
 __release_sock+0x1d3/0x330 net/core/sock.c:3213
 release_sock+0x6b/0x270 net/core/sock.c:3767
 pppoe_sendmsg+0x15d/0xcb0 drivers/net/ppp/pppoe.c:904
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x330/0x3d0 net/socket.c:727
 ____sys_sendmsg+0x893/0xd80 net/socket.c:2566
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2620
 __sys_sendmmsg+0x2d9/0x7c0 net/socket.c:2709
 __do_sys_sendmmsg net/socket.c:2736 [inline]
 __se_sys_sendmmsg net/socket.c:2733 [inline]
 __x64_sys_sendmmsg+0xc6/0x150 net/socket.c:2733
 x64_sys_call+0x3ce7/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:308
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 5830 Comm: syz-executor110 Not tainted 6.16.0-syzkaller #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup


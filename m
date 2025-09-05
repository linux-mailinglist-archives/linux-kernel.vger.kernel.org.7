Return-Path: <linux-kernel+bounces-802993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 071CAB45934
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 999EA16BB50
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302CA352FCC;
	Fri,  5 Sep 2025 13:36:31 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1235334AB08
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 13:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079390; cv=none; b=uQ1DslM3zsnqc2AmMtrGFQa0PQg4xtnh6AbIOuRtzLyKwdF9xswJdwecaRlVBu3pHw8KU9NSHXoEuXO9kQdegXIeTvj/+gUgkhHL2tDWv+pPRr/RKVgYFmqiJxtRFU6DuFGUC34eBfBt97DG6kWhNWnBCyg/wfjmEq+1LQWXiZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079390; c=relaxed/simple;
	bh=Av/nK/cYljEPwiyv8ZfHsiZPvmNiGk9BJ2W9AMz6G6c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=n/pti22c2PjM/LoyU2qOw6pqFCaeC4l+Tja/QxEgYzpM9W+prGK0GLQfqKh10czoq7g1OFc81UpKpGMrIdQF6tIKCafTqlYwyw5Y7dgJ9ZK4VCZZXrgYjkiofyl2aO0Crq3pOxMzHOF5moHyBGfAKQgxU3zsFU/0L5bBqn82u34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-8870ba3d52cso491034739f.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 06:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757079388; x=1757684188;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JrKB0+Gsj8rZ/9JD9shqaOFSNFNI+9Llfdd8Yr5/NIs=;
        b=myXlUnOlhFttyZGpQTSxWQ8WwDvBexBx0tOFtkZlu0exnin8UVYu6ThrkKfcHErW55
         42hoL+YiiIccqxsTAxNbCurrOppTj+o5Hed7fnq9Opj1bnh38g3umVCgI9Cr1wSsMpPf
         9ypJ0iL3UXV/+yH7rQ06iYuvfeRHPSZv2dsRTamS4qA12kfOOTY4hqFpb52xWy4yGd2L
         S8nKLthc9fNl0rzy0QRAU8Y2vBCwpEKBj4OZ+MM5NF4AsIiXENhWROeecSDV6ugMjAHd
         sKMgI1cd7izPA1vUtkRRuVGvXwnoq6CygHM1a9kmmHRUflq7bIdlMJbwnj3Wt8Jhl6vn
         XY4g==
X-Forwarded-Encrypted: i=1; AJvYcCXwFaNgvr/2T/AzupNAnXlvu62+qhNDZpQPckNzUoyPDOQuRS11fS/uBCKaA7J7xJSM4C52zRW7WA+YFDU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz83pgoz0Z+Nsla2tqoTf/tGX6YAZZ06ANGK1dp3ahV/UvgKvLh
	dC0LLUDnp4A4ehHluy82KN7sxT3BbvlgCy4Zd1tSMHNsPf3ak36CUZp6UyCJfs3pLt+ibyTECDY
	9IqVcQtQrynu6B65jeSKtTXWM34SfWMoPVvI1tWmc3/6td2LSj1ITCnKXV5U=
X-Google-Smtp-Source: AGHT+IHzFn9mkJRbGMDk8f5AnVrVb3hEZbJmkp9h2d2OEJNStmOu6q3m/w4XKj+gd+DexP4UYBGXu6GkDvQ+cazt+LHzSqC6tK/5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4a:0:b0:3eb:87a2:aead with SMTP id
 e9e14a558f8ab-3f401bee16dmr415822065ab.18.1757079387957; Fri, 05 Sep 2025
 06:36:27 -0700 (PDT)
Date: Fri, 05 Sep 2025 06:36:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bae75b.050a0220.192772.0190.GAE@google.com>
Subject: [syzbot] [can?] KMSAN: uninit-value in can_receive (3)
From: syzbot <syzbot+4b8a1e4690e64b018227@syzkaller.appspotmail.com>
To: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mkl@pengutronix.de, socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c3812b15000c Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=144ece64580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9c31a1485dceb8e
dashboard link: https://syzkaller.appspot.com/bug?extid=4b8a1e4690e64b018227
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177841f8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124ece64580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7736716fa3f9/disk-c3812b15.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/170d88657b1e/vmlinux-c3812b15.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b06f49d4c006/bzImage-c3812b15.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4b8a1e4690e64b018227@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in can_receive+0x219/0x5d0 net/can/af_can.c:654
 can_receive+0x219/0x5d0 net/can/af_can.c:654
 can_rcv+0x209/0x3a0 net/can/af_can.c:688
 __netif_receive_skb_one_core net/core/dev.c:5704 [inline]
 __netif_receive_skb+0x42b/0xa00 net/core/dev.c:5817
 process_backlog+0x4ad/0xa50 net/core/dev.c:6149
 __napi_poll+0xe7/0x980 net/core/dev.c:6902
 napi_poll net/core/dev.c:6971 [inline]
 net_rx_action+0xa5a/0x19b0 net/core/dev.c:7093
 handle_softirqs+0x1a0/0x7c0 kernel/softirq.c:561
 __do_softirq+0x14/0x1a kernel/softirq.c:595
 do_softirq+0x9a/0x100 kernel/softirq.c:462
 __local_bh_enable_ip+0x9f/0xb0 kernel/softirq.c:389
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:919 [inline]
 __dev_queue_xmit+0x2758/0x57d0 net/core/dev.c:4493
 dev_queue_xmit include/linux/netdevice.h:3168 [inline]
 can_send+0xf1c/0x13b0 net/can/af_can.c:277
 isotp_sendmsg+0x1afc/0x2340 net/can/isotp.c:1087
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:726
 ____sys_sendmsg+0x903/0xb60 net/socket.c:2583
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2637
 __sys_sendmmsg+0x2ff/0x880 net/socket.c:2726
 __do_sys_sendmmsg net/socket.c:2753 [inline]
 __se_sys_sendmmsg net/socket.c:2750 [inline]
 __x64_sys_sendmmsg+0xbc/0x120 net/socket.c:2750
 x64_sys_call+0x33c2/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:308
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4125 [inline]
 slab_alloc_node mm/slub.c:4168 [inline]
 __do_kmalloc_node mm/slub.c:4297 [inline]
 __kmalloc_node_track_caller_noprof+0x945/0x1240 mm/slub.c:4317
 kmalloc_reserve+0x23e/0x4a0 net/core/skbuff.c:609
 pskb_expand_head+0x226/0x1a60 net/core/skbuff.c:2275
 netif_skb_check_for_xdp net/core/dev.c:5081 [inline]
 netif_receive_generic_xdp net/core/dev.c:5112 [inline]
 do_xdp_generic+0x9e3/0x15a0 net/core/dev.c:5180
 __netif_receive_skb_core+0x25c3/0x6f10 net/core/dev.c:5524
 __netif_receive_skb_one_core net/core/dev.c:5702 [inline]
 __netif_receive_skb+0xca/0xa00 net/core/dev.c:5817
 process_backlog+0x4ad/0xa50 net/core/dev.c:6149
 __napi_poll+0xe7/0x980 net/core/dev.c:6902
 napi_poll net/core/dev.c:6971 [inline]
 net_rx_action+0xa5a/0x19b0 net/core/dev.c:7093
 handle_softirqs+0x1a0/0x7c0 kernel/softirq.c:561
 __do_softirq+0x14/0x1a kernel/softirq.c:595

CPU: 1 UID: 0 PID: 5804 Comm: syz-executor907 Not tainted 6.13.0-rc7-syzkaller-00039-gc3812b15000c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
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


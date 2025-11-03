Return-Path: <linux-kernel+bounces-882209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D716C29E34
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 03:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5DE13A9911
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 02:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA84D286887;
	Mon,  3 Nov 2025 02:52:10 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B671286D72
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 02:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762138330; cv=none; b=Ohw1QKJ/EK3vjggIbaWkibjl1sE/bCsUogS8g2cznqL2hn28FzQazsIbgnrGe2/r9IeG/mlN4GgNwWUj07G1fFy6jFeGaGDtGO98aHR5fdmfAtin77xxGDamMvpkUJKCSaBnHnrSdkpYvy3XqTZm4/3MordsAmvmWir+306x1uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762138330; c=relaxed/simple;
	bh=AKm1eDfm4vrJy9UzclTedS0o4SzDhmX5z52znmkolFw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ko1wP8tcAdHXCZc03f9OJyAr3jcbpqKE4eQTY5TtH8TXAz/dmG4ymT5ymHCBC65TaVS0ctgWOYuuR47yqMw66ecRnVSVYdtyMvw6DuYHUiks1GkGAAPHdq9hF8sNr7brxhoFXRiZ2Y/clYSWa1SPioem1nVdrDLCVnT9g8ybHYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-433154d39abso96187525ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 18:52:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762138324; x=1762743124;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0ib0GI7YBqHUoaBFW24SeLxo39i60dohl9Ef+pCTnY=;
        b=l8AjexuMiixa6IgWa3whSHo+Z0YXHL3JSdS3xg/rJ+0qB9sQ6PyzmphmUQmVOwy9af
         nc2tUf3w/bwhlSjYoABD95Vj8yKEr4KaHw93NSdn2xTfjXdql+CWmYlHGPBPPlzQY4db
         eI5dH+HbLdaUmOAbbdEmUTElMo8jfvzxVTASHkfcbvpF9NXWg1bw/3tiUC54KMR1jRyq
         cBmB/Mpm5s1v23SdH/T4EJfJay8jJ320NOdIt7m/rmw6MfxhCJnZe/B4PVBTQVGf4uT1
         PXU5RO8UHj4WL2ThAKVbNGZ6Ldm944FBVtPw2T057YBfUQC4ZMecvkwx/6cJ4NorpoU6
         aUoA==
X-Gm-Message-State: AOJu0YxlP9vnyhnicTk8vZcVL9+njGI9bnnaKRedWY3Pz3iJJ0UvfAtT
	/rbikfI9qDbOwp/iBkPTz/v/BSRKLeG6E72YVO6gJ5SS3Z1yPOJ2j1D3ocng5K8B6D+oUZ1m9aQ
	4Fq1btvuHxyaYX4c2GW55CA3N+bhXuDSd4V2pWz/WTPie04WYyv9vi13OZE8=
X-Google-Smtp-Source: AGHT+IFlWch3SxGVX3Po4u+UUw/JjFTk55EgaM/VGZh3h86bC9I5bY2aDUtVMCeAH7+Wpunad35MoKMb4+N3yuJMaE4E9OdMI/me
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:349d:b0:430:ac49:b3b1 with SMTP id
 e9e14a558f8ab-4330d14376dmr186339755ab.12.1762138324279; Sun, 02 Nov 2025
 18:52:04 -0800 (PST)
Date: Sun, 02 Nov 2025 18:52:04 -0800
In-Reply-To: <20251103021018.2052011-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690818d4.a70a0220.37351b.0015.GAE@google.com>
Subject: Re: [syzbot] [nbd?] KASAN: slab-use-after-free Write in recv_work (3)
From: syzbot <syzbot+56fbf4c7ddf65e95c7cc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in get_data

------------[ cut here ]------------
WARNING: kernel/printk/printk_ringbuffer.c:1278 at get_data+0x48a/0x840 kernel/printk/printk_ringbuffer.c:1278, CPU#1: syz.0.527/8152
Modules linked in:
CPU: 1 UID: 0 PID: 8152 Comm: syz.0.527 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:get_data+0x48a/0x840 kernel/printk/printk_ringbuffer.c:1278
Code: 83 c4 f8 48 b8 00 00 00 00 00 fc ff df 41 0f b6 04 07 84 c0 0f 85 ee 01 00 00 44 89 65 00 49 83 c5 08 eb 13 e8 b7 d6 1e 00 90 <0f> 0b 90 eb 05 e8 ac d6 1e 00 45 31 ed 4c 89 e8 48 83 c4 28 5b 41
RSP: 0018:ffffc9000d8f6760 EFLAGS: 00010293
RAX: ffffffff81a1ff09 RBX: 00003fffffffffff RCX: ffff888027288000
RDX: 0000000000000000 RSI: 00003fffffffffff RDI: 0000000000000000
RBP: 0000000000000012 R08: 00000000000010f0 R09: 00000030039f1912
R10: 00000030039f1912 R11: 00001fd8c200001e R12: 0000000000000012
R13: 0000000000000000 R14: ffffc9000d8f68a8 R15: 1ffffffff1c4ab06
FS:  00007f678b3656c0(0000) GS:ffff888125b9c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f678b343f98 CR3: 000000002b512000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 copy_data kernel/printk/printk_ringbuffer.c:1857 [inline]
 prb_read kernel/printk/printk_ringbuffer.c:1966 [inline]
 _prb_read_valid+0x672/0xa90 kernel/printk/printk_ringbuffer.c:2143
 prb_read_valid+0x3c/0x60 kernel/printk/printk_ringbuffer.c:2215
 printk_get_next_message+0x15c/0x7b0 kernel/printk/printk.c:2978
 console_emit_next_record kernel/printk/printk.c:3062 [inline]
 console_flush_one_record kernel/printk/printk.c:3194 [inline]
 console_flush_all+0x4cc/0xb10 kernel/printk/printk.c:3268
 __console_flush_and_unlock kernel/printk/printk.c:3298 [inline]
 console_unlock+0xbb/0x190 kernel/printk/printk.c:3338
 vprintk_emit+0x4c5/0x590 kernel/printk/printk.c:2423
 dev_vprintk_emit+0x337/0x3f0 drivers/base/core.c:4914
 dev_printk_emit+0xe0/0x130 drivers/base/core.c:4925
 _dev_info+0x10a/0x160 drivers/base/core.c:4983
 nbd_genl_reconfigure+0x106d/0x1a50 drivers/block/nbd.c:2439
 genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:746
 ____sys_sendmsg+0x505/0x830 net/socket.c:2634
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2688
 __sys_sendmsg net/socket.c:2720 [inline]
 __do_sys_sendmsg net/socket.c:2725 [inline]
 __se_sys_sendmsg net/socket.c:2723 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2723
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f678a58efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f678b365038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f678a7e5fa0 RCX: 00007f678a58efc9
RDX: 0000000000000000 RSI: 00002000000002c0 RDI: 0000000000000008
RBP: 00007f678a611f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f678a7e6038 R14: 00007f678a7e5fa0 R15: 00007fffd7aaf958
 </TASK>


Tested on:

commit:         98bd8b16 Add linux-next specific files for 20251031
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15ad4532580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=55e89517f3847929
dashboard link: https://syzkaller.appspot.com/bug?extid=56fbf4c7ddf65e95c7cc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=153ba012580000



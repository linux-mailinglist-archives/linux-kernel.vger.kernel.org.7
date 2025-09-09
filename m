Return-Path: <linux-kernel+bounces-807172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B4EB4A12D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B53874E7161
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 05:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C683002D5;
	Tue,  9 Sep 2025 05:13:35 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22902FFDD5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 05:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757394815; cv=none; b=LN0wXbeAKHJa7gp808kPIQ7VF9cOXZJruOXfeqvWQblTo6V6OAz0QyU0VkCW8nFgLNwpXPEqvDDzV8n2tp4+lNtEau7PON/NER/aMewpiJB5/N+2auDPXlian16AueIRrNGtbIxmSMtGcc/s4fbxpjdV3vGdol/RGWlffWwmbsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757394815; c=relaxed/simple;
	bh=qHBwNJiEIrhAZSsXUk5F3O1/3DlTmok1+B3EGO2k+9o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qkhTna2JvVNl332eh7C+F8ecKCfY7oPgMK/izFu6toClXH7q/f+OG8tNsrqucuOtzG9cLgceSm0fW5Jf73Be5AW6bxF8GJ8HLCRBcTL3rYgG5pxV32xWhKSA1lSBccy+Zt4N9p2tcbgj8kdiPLX0G8aEU424wJr38sgWvAm8WHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3fb2a3ca471so36105815ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 22:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757394812; x=1757999612;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H5peZDX8n96leXmY4994Qh1nagNgXKKzgkojoG9FJrE=;
        b=XaM9hBeY3OZjlgvs6MWBftlrH7FjzYj86akylyxab9XaX8padWB3sCx04KU0FsifZR
         bGmYB5dkXtuFCdbRd6m16ED8rcfzaJFYT3zukA7xfBDHcuXbFRyGRWlyBFPKJl5YsXmF
         2T58OIWnaiIoq7PhHTdeOXoMg+xXJ8e8FkoZiAY050svEETcQWOiDRRfpv3wqgYJJeBi
         xPAt8c9p78Z7K2OimbSrgbHCCZdBqTQs7WUmwB9w4TgpRavPK5yc3gM5bHqqCVSv5LCS
         eozIqnkMGDL0dV8LV2d4AjvvyXO3Ng59pwBBlAJw/1IOmXgP3q3MedIUtkPpAn+HOuyW
         4xcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQbwrmI40D+LGuKDFAmC6k7DGAUN0Ejehu4oK1HeQj7g3V0FBgpsgzDQqxnUbQAruxF5Ffvux8F/A7WBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmHHl/2dcaYleuuFzxUok3JgdQJKacCvqyw4Md6V7w9CQbgpmT
	IdUe7omARfXA4dnMY6MVy0vB2uqsPlNK8iAt88Jla2muX7jyYdWQnOMBoAPSJVzU/SqW8ks9+bb
	k+bUdz7blJhT7cDHYyOL5gvANa9Bj6C7HoGPIYLIDkY17vITlh4HDOSaxYpc=
X-Google-Smtp-Source: AGHT+IHzavfrAlBXO5FpzJmMgsLXa1kd+8/ge+pWP6Ec0BswrfdfQswCRq5zCRd1BnH+AP3XtF7CkkYzPn9lcZCV0VwzcSMz9IZ6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218e:b0:3f0:40fd:9d1c with SMTP id
 e9e14a558f8ab-3fd7f6657bdmr151260385ab.9.1757394811938; Mon, 08 Sep 2025
 22:13:31 -0700 (PDT)
Date: Mon, 08 Sep 2025 22:13:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bfb77b.a00a0220.eb3d.003f.GAE@google.com>
Subject: [syzbot] [bridge?] [netfilter?] WARNING in br_nf_local_in
From: syzbot <syzbot+aa8e2b2bfec0dd8e7e81@syzkaller.appspotmail.com>
To: bridge@lists.linux.dev, coreteam@netfilter.org, davem@davemloft.net, 
	edumazet@google.com, fw@strlen.de, horms@kernel.org, idosch@nvidia.com, 
	kadlec@netfilter.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pabeni@redhat.com, 
	pablo@netfilter.org, razor@blackwall.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    08b06c30a445 Merge tag 'v6.17-rc4-ksmbd-fix' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12e3087c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7511150b112b9c3
dashboard link: https://syzkaller.appspot.com/bug?extid=aa8e2b2bfec0dd8e7e81
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-08b06c30.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0e152fe53de2/vmlinux-08b06c30.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5a1bd9f48488/bzImage-08b06c30.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aa8e2b2bfec0dd8e7e81@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 3 PID: 8841 at net/bridge/br_netfilter_hooks.c:630 br_nf_local_in+0x714/0x7f0 net/bridge/br_netfilter_hooks.c:630
Modules linked in:
CPU: 3 UID: 0 PID: 8841 Comm: syz.0.801 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:br_nf_local_in+0x714/0x7f0 net/bridge/br_netfilter_hooks.c:630
Code: 12 f7 4b f7 90 0f 0b 90 e9 e1 fb ff ff e8 04 f7 4b f7 be 03 00 00 00 48 89 ef e8 87 e8 73 fa e9 39 fa ff ff e8 ed f6 4b f7 90 <0f> 0b 90 e9 dc fd ff ff 4c 89 f7 e8 2c 56 b2 f7 e9 48 f9 ff ff 4c
RSP: 0018:ffffc9000500efc0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8a6f9520
RDX: ffff8880255b4880 RSI: ffffffff8a6f9743 RDI: 0000000000000001
RBP: ffff88803a6b2900 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000008
R13: ffff88803a6b29c0 R14: 0000000000000000 R15: ffff88803608d874
FS:  00007faf552176c0(0000) GS:ffff8880d69b8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007faf55216f98 CR3: 000000001fa82000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
 nf_hook_slow+0xbe/0x200 net/netfilter/core.c:623
 nf_hook.constprop.0+0x3e7/0x6b0 include/linux/netfilter.h:273
 NF_HOOK include/linux/netfilter.h:316 [inline]
 br_pass_frame_up+0x307/0x490 net/bridge/br_input.c:70
 br_handle_frame_finish+0xf5a/0x1ca0 net/bridge/br_input.c:227
 br_nf_hook_thresh+0x307/0x410 net/bridge/br_netfilter_hooks.c:1170
 br_nf_pre_routing_finish+0x8a1/0x1810 net/bridge/br_netfilter_hooks.c:425
 NF_HOOK include/linux/netfilter.h:318 [inline]
 NF_HOOK include/linux/netfilter.h:312 [inline]
 br_nf_pre_routing+0xf7b/0x15b0 net/bridge/br_netfilter_hooks.c:534
 nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
 nf_hook_bridge_pre net/bridge/br_input.c:283 [inline]
 br_handle_frame+0xad5/0x14b0 net/bridge/br_input.c:434
 __netif_receive_skb_core.constprop.0+0xa22/0x48c0 net/core/dev.c:5878
 __netif_receive_skb_one_core+0xb0/0x1e0 net/core/dev.c:5989
 __netif_receive_skb+0x1d/0x160 net/core/dev.c:6104
 netif_receive_skb_internal net/core/dev.c:6190 [inline]
 netif_receive_skb+0x137/0x7b0 net/core/dev.c:6249
 tun_rx_batched.isra.0+0x3ee/0x740 drivers/net/tun.c:1509
 tun_get_user+0x28e4/0x3ce0 drivers/net/tun.c:1950
 tun_chr_write_iter+0xdc/0x210 drivers/net/tun.c:1996
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x7d3/0x11d0 fs/read_write.c:686
 ksys_write+0x12a/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7faf5438d69f
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 f9 92 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 4c 93 02 00 48
RSP: 002b:00007faf55217000 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007faf545c5fa0 RCX: 00007faf5438d69f
RDX: 000000000000002a RSI: 0000200000000000 RDI: 00000000000000c8
RBP: 00007faf54411e19 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000002a R11: 0000000000000293 R12: 0000000000000000
R13: 00007faf545c6038 R14: 00007faf545c5fa0 R15: 00007fffb9e76588
 </TASK>


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


Return-Path: <linux-kernel+bounces-799482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19324B42C57
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07AAA3A00E9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C203A2EE262;
	Wed,  3 Sep 2025 21:59:36 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C902ECD14
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 21:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756936776; cv=none; b=FkR9H10gYXZS/SRkaNTgwpgIigxjteopVhXc2fg51gNuwW/daA/GaWAK1Z+KBt5iLu5f26OTibxZY66MqYIvslRcz7OSOYi5LH98FAnrPKXqzwVQvZ5rm7OKn/9JPCm6fiapw1+Ks4FXei4NcghtAUQn7f5oH8hFdD4nBe8Cufo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756936776; c=relaxed/simple;
	bh=NwVj406V4TwvuPh5xM9Oec9iDk8bz4jidfLNkykXQEY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=O9dE5qi9w8rok75aqbm4RrOsT/agSM5cAz3i+MFtH6UGTonStRknjCl/TS9iLiFd/li4/Gtco9zfktoxD/ttZqvlXRio4E05N1dIf0Q6p4iCZWWbYo/9GtOeohjyKgUwTJ2dj8v5TUkpheION9ItNTESE3fDTiAu38B5u1ofOTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3f340e9b5c5so7996775ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 14:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756936774; x=1757541574;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vvREjoNhJvWcP41gPEUmdvfF/ct/gOeHH14aV5CBgZg=;
        b=Ummsv/FUg8Knk1FEGm9Sg6pE/xOM2kd7/xDj6lUfxbfc3ma7fHQg6ZBNhpjIuFKRkG
         rQwChI1/up7i4ZVf85Jy6XsbLAl0SVde/zMX2uy4BuAwxoaamzuunhvG3hqfF4ICSJ1U
         RRd/xkeZKxJFqtFwZ5ZVpv5kAhucZ1c2UAGn2pNHv7h5RzQgb06UcSOBZNHBgVEBe1YW
         B2w39MDSvBXEtlxGCPx0P0r0OOywUzLFYZSBl0GkBmYsDIZwJj40vZxttLAEFncpPNN2
         lGhw9A0yQkQJ+/shEt5x1zuXDw7qnbeUZEe1fmBmGWcS/A1kfajGeYkAVGqYryJ3SoeB
         vuWw==
X-Forwarded-Encrypted: i=1; AJvYcCVDHWOZDPbGbt/hqktNiAIi4tYWfaxLekGWxj91PgsJh44gDmjSdIYS4x0e4A/dgJI02VDeqoYLckdKt0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YynFkkre7azz+MblNz2VPEn0OfRHRK9rXUQEc3V3+xv16Hjg8DS
	bbE16UaNpMT2Fh9Rl8ewny1shBBojkybj6rnM5b8XN0HC5h4MX3SFlxjbhKluEpGG/7YkRg75q7
	TsNhZC7As0d0yczh8PHYZjLnedadrGDFByC7MjP9/pC54ztGBLfYl7jQ9xMI=
X-Google-Smtp-Source: AGHT+IEipArVliy8O8RLTBKXMg+A8oIFDpmVHnmW+k3cfGmCLbT4YJNpK09pK+zLxTMzX5ZTH7MUhLLO1Vd+Dq+/MLEcjtreRmwQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cb:b0:3ed:8fef:f855 with SMTP id
 e9e14a558f8ab-3f4021c1ef3mr269963805ab.26.1756936773887; Wed, 03 Sep 2025
 14:59:33 -0700 (PDT)
Date: Wed, 03 Sep 2025 14:59:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b8ba45.050a0220.3db4df.0207.GAE@google.com>
Subject: [syzbot] [net?] BUG: corrupted list in nsim_bpf_verifier_prep (2)
From: syzbot <syzbot+530656d6f93f3af256f3@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    788bc43d8330 Merge branch 'microchip-lan865x-fix-probing-i..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=116cc242580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c302bcfb26a48af
dashboard link: https://syzkaller.appspot.com/bug?extid=530656d6f93f3af256f3
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c958eee3370d/disk-788bc43d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/615040093399/vmlinux-788bc43d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/91377e9f5c93/bzImage-788bc43d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+530656d6f93f3af256f3@syzkaller.appspotmail.com

 slab kmalloc-64 start ffff888023c23980 pointer offset 40 size 64
list_add corruption. prev->next should be next (ffff88805628d3c0), but was ffff8880285b2a28. (prev=ffff888023c239a8).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:34!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 12095 Comm: syz.2.1692 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:__list_add_valid_or_report+0x123/0x130 lib/list_debug.c:32
Code: e8 a2 eb 31 fd 43 80 3c 2c 00 74 08 4c 89 f7 e8 83 df 52 fd 49 8b 16 48 c7 c7 40 3a e3 8b 48 89 de 4c 89 f1 e8 5e 65 57 fc 90 <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000d1cf4a8 EFLAGS: 00010246
RAX: 0000000000000075 RBX: ffff88805628d3c0 RCX: b8e30b4d65b25b00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 1ffff1100ac51a79 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfa1ec R12: 1ffff11004784735
R13: dffffc0000000000 R14: ffff888023c239a8 R15: ffff8880285b24a8
FS:  00007fdac22936c0(0000) GS:ffff888125c18000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000002400 CR3: 000000007459a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __list_add_valid include/linux/list.h:88 [inline]
 __list_add include/linux/list.h:150 [inline]
 list_add_tail include/linux/list.h:183 [inline]
 nsim_bpf_create_prog drivers/net/netdevsim/bpf.c:247 [inline]
 nsim_bpf_verifier_prep+0x397/0x530 drivers/net/netdevsim/bpf.c:262
 bpf_prog_offload_verifier_prep+0xd0/0x140 kernel/bpf/offload.c:305
 bpf_check+0x1cf6/0x1d2d0 kernel/bpf/verifier.c:24678
 bpf_prog_load+0x1318/0x1930 kernel/bpf/syscall.c:2979
 __sys_bpf+0x528/0x870 kernel/bpf/syscall.c:6029
 __do_sys_bpf kernel/bpf/syscall.c:6139 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6137 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6137
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdac138ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdac2293038 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fdac15c6090 RCX: 00007fdac138ebe9
RDX: 0000000000000094 RSI: 0000200000000640 RDI: 0000000000000005
RBP: 00007fdac1411e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fdac15c6128 R14: 00007fdac15c6090 R15: 00007fff0483c898
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_add_valid_or_report+0x123/0x130 lib/list_debug.c:32
Code: e8 a2 eb 31 fd 43 80 3c 2c 00 74 08 4c 89 f7 e8 83 df 52 fd 49 8b 16 48 c7 c7 40 3a e3 8b 48 89 de 4c 89 f1 e8 5e 65 57 fc 90 <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000d1cf4a8 EFLAGS: 00010246
RAX: 0000000000000075 RBX: ffff88805628d3c0 RCX: b8e30b4d65b25b00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 1ffff1100ac51a79 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfa1ec R12: 1ffff11004784735
R13: dffffc0000000000 R14: ffff888023c239a8 R15: ffff8880285b24a8
FS:  00007fdac22936c0(0000) GS:ffff888125d18000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555873675c8 CR3: 000000007459a000 CR4: 00000000003526f0


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


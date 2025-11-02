Return-Path: <linux-kernel+bounces-881966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9787C29539
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 19:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC3054E79F7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 18:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AED2367D7;
	Sun,  2 Nov 2025 18:41:08 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4382B34D3BA
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 18:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762108867; cv=none; b=kRKOAqLhfUfQ25ep3iQnYvyssK7P899x7CdVGAwwwtl1z3jXJfQHZmn33SEl/IYRZDtmL4vKyGToGRGvF1+2yR7/Fj9wexiMvu272wLZ3A5h+s0ghO8Um3HfPQsTRVe0YdoXSGZDnqG/S8b1eMP4iQtNpomE4E9rj+65S1Jk9ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762108867; c=relaxed/simple;
	bh=aa4uux4N24ehPcM5tEIBD+vjT6QwfyTgscF6BPVat90=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Lz6ImVbeI6MTKneA/SLfKcgJnklcc+UwU1eS0NHvjycPFyzU0a4+5QFdQEXH42zZh8L3isAjqWNhgR4g0GmXJXSYMtAdX4SWa9DIN91WyQK3T40PtqOJiy6c7vTz7v9tfamX6ECkmTkPBYI5iGFSmm0kC9tJid3iAtmY7eQnlfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-433299e5160so5175705ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 10:41:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762108865; x=1762713665;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OHD8NiRY3L3KvtTTvynC2RrvBYjjx8imUQFsXeQdGag=;
        b=WntpUr+BxrFu4qYw98fzA7XMqH1DDY7di3f7u9zCw5H1LPMiioqhg5p3SvTIYUyfyW
         aemVIVzdNM4vSpSHqpAdsx8LQeCMh2Zb65EfUCbX1LVeH1GRktCtRhvvbdrZZrLJqLIZ
         dKJTEQ+YKfNWODaigKQLr0/xMUZa+y9RBZ66k5d9dVH4E5oPQm/MAdisEW1O8FlKllTw
         VfBa3QG8ae10esDU9DTqpihj99wRm3hDvpTF7Lf14LJUvaE/QzM6JhARIyoIvItvE74B
         Yh4JdlSkjBVYp9yZI+kboo0+hcJQ2cKXQ0wRWMghqR9U+Mxt+0s8X7cSBv4aL2X61uTw
         tdfA==
X-Forwarded-Encrypted: i=1; AJvYcCW1Lw/MKQApn+ipNIxTEFawMYg1ONwy+koQXSlMUyHKNI63zAfuMWxCprRN2Qteff/sijf6fWJ0DVqGINo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0MeGlGXUG2nBahmkNL4nUGcQrYhbghv/F5/31FudnMIyDSGiE
	Q1/9Ec5286JZ8hSHoCDMFoq1rC9L7D2PqBX7CLzTkPl8BM398kS7z7v/MFiXzmf1Yev2SQJty3U
	fjYtXcPnCfSuvbyFfKKyZB5DR4h+60tRPJlMyBRNxx8DVm4kp5E5JULelISc=
X-Google-Smtp-Source: AGHT+IGkh+HPFOmF0Eae9mMPN/4r58JM8UIeGVt67sRGFDy3pd5iX6MGIC9Am3UTWoPoTwMmNFyaEctEPgxCKELpRyXPIf3vZxAi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4405:20b0:433:2341:bc13 with SMTP id
 e9e14a558f8ab-4332341ce8cmr56976165ab.11.1762108865333; Sun, 02 Nov 2025
 10:41:05 -0800 (PST)
Date: Sun, 02 Nov 2025 10:41:05 -0800
In-Reply-To: <1699488975.3511177.1762106869912@kpc.webmail.kpnmail.nl>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6907a5c1.a70a0220.37351b.000d.GAE@google.com>
Subject: Re: [syzbot] [hfs?] kernel BUG in hfs_new_inode
From: syzbot <syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com>
To: jkoolstra@xs4all.nl, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
VFS: Busy inodes after unmount (use-after-free)

VFS: Busy inodes after unmount of loop0 (hfs)
------------[ cut here ]------------
kernel BUG at fs/super.c:652!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 6456 Comm: syz-executor Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:generic_shutdown_super+0x2bc/0x2c0 fs/super.c:650
Code: 03 42 80 3c 28 00 74 08 4c 89 f7 e8 1e 14 f3 ff 49 8b 16 48 81 c3 c8 07 00 00 48 c7 c7 c0 ce f8 8a 48 89 de e8 c5 89 f9 fe 90 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f
RSP: 0018:ffffc90004b07d20 EFLAGS: 00010246
RAX: 000000000000002d RBX: ffff888032f747c8 RCX: 49dab819c755c300
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 1ffff110065ee91a R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffff52000960f49 R12: 0000000000000000
R13: dffffc0000000000 R14: ffffffff8d9ce5e0 R15: ffff888032f748d0
FS:  00005555664c8500(0000) GS:ffff888126cbf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f7155aa950 CR3: 0000000031628000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 kill_block_super+0x44/0x90 fs/super.c:1722
 deactivate_locked_super+0xbc/0x130 fs/super.c:473
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1327
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xe9/0x130 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9992a402f7
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffcd2add748 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007f9992ac1d7d RCX: 00007f9992a402f7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffcd2add800
RBP: 00007ffcd2add800 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffcd2ade890
R13: 00007f9992ac1d7d R14: 00000000000297ad R15: 00007ffcd2ade8d0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:generic_shutdown_super+0x2bc/0x2c0 fs/super.c:650
Code: 03 42 80 3c 28 00 74 08 4c 89 f7 e8 1e 14 f3 ff 49 8b 16 48 81 c3 c8 07 00 00 48 c7 c7 c0 ce f8 8a 48 89 de e8 c5 89 f9 fe 90 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f
RSP: 0018:ffffc90004b07d20 EFLAGS: 00010246
RAX: 000000000000002d RBX: ffff888032f747c8 RCX: 49dab819c755c300
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 1ffff110065ee91a R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffff52000960f49 R12: 0000000000000000
R13: dffffc0000000000 R14: ffffffff8d9ce5e0 R15: ffff888032f748d0
FS:  00005555664c8500(0000) GS:ffff888126cbf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f7155aa950 CR3: 0000000031628000 CR4: 00000000003526f0


Tested on:

commit:         691d401c Merge tag 'spi-fix-v6.18-rc3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10baee14580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=72f4d1bb6e3e45a2
dashboard link: https://syzkaller.appspot.com/bug?extid=17cc9bb6d8d69b4139f0
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15cebf34580000



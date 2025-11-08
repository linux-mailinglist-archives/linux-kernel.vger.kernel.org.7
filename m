Return-Path: <linux-kernel+bounces-891465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4404FC42B73
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 11:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C8E53B3041
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 10:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51E5287253;
	Sat,  8 Nov 2025 10:47:28 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FEBA41
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762598848; cv=none; b=t96OfCQovnjticKILhL/zdfr5u5sdu44VxPNfExGLD/gWj4PU3p/Mv2so4RpgrOhMUX2CBaFgoJmgGdfbZmlbh9cNRFF9/LbyZ7MoSu6eDVfuFm+uSMDTSYo+6HWBsxjEsOXD3h9yDls6rKPphHWN4oCjxpqW1UAKda/8hpzEyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762598848; c=relaxed/simple;
	bh=nfAyGD8aJ1z6s06mDiRAlmDN0OmCWTp9N9Cb/rttEJw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EWWFhxYQ3EFQ43TkPB5DRy4Kjbv7sn34v8OTtnqPuUe5tx+2S9/TeZSx4FLIxmN+gVOC5g4Ai8Q5qZWt6LuxKlqqHhNuzWQolqy9K1crkfPD5tz3Jq5dg9clnGCzyvYn05cst5QOarGSLOnQ8nb5nCxSYwrogEGwOpcOECi3anY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-43327c30cb1so14331765ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 02:47:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762598846; x=1763203646;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ru9blyctQS2YXBRkFgASHgL8mYMoiGtLH+vMKDPKhdw=;
        b=siDrfbuJqjnidfLhFXey9HbIJWrBze61f9WmATkIJo075o1UZoQ9SiO2Bu8JAuWIMr
         5ndPvXQEk+5iYCnT2iYSN8iDAlidMaWdwMHG2ZHunAXKBXoUQnV9astyccxa2yhwN0XI
         HfrKULLZhZKeQQRH+nDFT14ZMRZlu5ULu7+LNLiBBYldFoai7U4V6/Hm/JAd06E3C2Ut
         fZ5FVf5hbiIrBDsH7gLQ6ukf5hEQXf4gWU4GocmwE2kzYn7+tKDifmyyKSkfgYKtYSfr
         2DsFEapMmfFqOZh8wyjLMrsSj2RDfMExlAh/WdMxO68bLGtNza6caSvKQwzm5yit0jUY
         tnLg==
X-Gm-Message-State: AOJu0Yz6Gmr/pz+5jKzkxUc6xSlUsVdMKgkcn+VTl91u7l7vw7HSZlkg
	ogP9IhUdb+lkZjKOOS7JnjTgHaIQbqmikUWNikSfEjj6+uYoQ4eu7ns7B8XeiR6GTBKjmM9izSM
	qzRUucvUZTIn7MfNTp72MNZhFvDjaUnI2BwLcmu+kdb9W8gngf9y3fS9AkfPjMw==
X-Google-Smtp-Source: AGHT+IFvhCyfDgJ4JZt8w8MpJnaHvgqU50hgHhtfzu3dcXoBDUE5pziqZORRbMStkGZWX9tyfsnxYqprp7ZTOHt9Zzsx38yhB37k
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219d:b0:433:2b83:340b with SMTP id
 e9e14a558f8ab-43367ddc25dmr32147515ab.2.1762598845921; Sat, 08 Nov 2025
 02:47:25 -0800 (PST)
Date: Sat, 08 Nov 2025 02:47:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690f1fbd.a70a0220.22f260.007c.GAE@google.com>
Subject: [syzbot] [kernel?] WARNING in free_nsproxy
From: syzbot <syzbot+18ca16805765b88f983b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9c0826a5d9aa Add linux-next specific files for 20251107
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13e5117c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4f8fcc6438a785e7
dashboard link: https://syzkaller.appspot.com/bug?extid=18ca16805765b88f983b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6b76dc0ec17f/disk-9c0826a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/522b6d2a1d1d/vmlinux-9c0826a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4a58225d70f3/bzImage-9c0826a5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+18ca16805765b88f983b@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: ./include/linux/ns_common.h:255 at __ns_ref_put include/linux/ns_common.h:255 [inline], CPU#0: syz.0.1748/11884
WARNING: ./include/linux/ns_common.h:255 at put_uts_ns include/linux/uts_namespace.h:37 [inline], CPU#0: syz.0.1748/11884
WARNING: ./include/linux/ns_common.h:255 at free_nsproxy+0x415/0x560 kernel/nsproxy.c:193, CPU#0: syz.0.1748/11884
Modules linked in:
CPU: 0 UID: 0 PID: 11884 Comm: syz.0.1748 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:__ns_ref_put include/linux/ns_common.h:255 [inline]
RIP: 0010:put_uts_ns include/linux/uts_namespace.h:37 [inline]
RIP: 0010:free_nsproxy+0x415/0x560 kernel/nsproxy.c:193
Code: 85 ed 0f 8e be 00 00 00 e8 48 4d 33 00 48 8b 3d 71 71 32 11 48 89 de 5b 41 5c 41 5e 41 5f 5d e9 01 77 8e 00 e8 2c 4d 33 00 90 <0f> 0b 90 e9 ba fc ff ff e8 1e 4d 33 00 4c 89 ff be 03 00 00 00 e8
RSP: 0018:ffffc9000aae7a90 EFLAGS: 00010293
RAX: ffffffff818e8304 RBX: ffff88801d29b7b8 RCX: ffff888058b19e80
RDX: 0000000000000000 RSI: 00000000fffffffe RDI: 0000000000000000
RBP: 00000000fffffffe R08: ffff88807ee2852b R09: 1ffff1100fdc50a5
R10: dffffc0000000000 R11: ffffed100fdc50a6 R12: dffffc0000000000
R13: 0000000000000009 R14: ffff88807ee282d8 R15: ffff88807ee28528
FS:  0000000000000000(0000) GS:ffff888125a79000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0bce3c3df0 CR3: 0000000079622000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 000000000000000c DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_exit+0x6b8/0x2300 kernel/exit.c:969
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1111
 get_signal+0x1285/0x1340 kernel/signal.c:3034
 arch_do_signal_or_restart+0x9a/0x7a0 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:41 [inline]
 exit_to_user_mode_loop+0x87/0x4f0 kernel/entry/common.c:75
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
 do_syscall_64+0x2e9/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe49bbc1f85
Code: Unable to access opcode bytes at 0x7fe49bbc1f5b.
RSP: 002b:00007fe49c9eef80 EFLAGS: 00000293 ORIG_RAX: 00000000000000e6
RAX: fffffffffffffdfc RBX: 00007fe49bde5fa0 RCX: 00007fe49bbc1f85
RDX: 00007fe49c9eefc0 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007fe49bc11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 00007fe49bde6038 R14: 00007fe49bde5fa0 R15: 00007ffc4ce98bc8
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


Return-Path: <linux-kernel+bounces-891741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB699C435CA
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 23:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA99188B964
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 22:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77862248886;
	Sat,  8 Nov 2025 22:59:08 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DFE18E1F
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 22:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762642748; cv=none; b=RUPU6xwxLVVPLDyBgJ9iKrQ7jGayLKJiKweTNWZselwEqaWit5qYf43KWPR18cHCIXd3+vFTFd1hGdU3EWt6LR0C8OB/Kl7n/BtPX9RxGG8q8M/XMUcfptrfqN/DdMJLK6xD1P4w8mcjqtTvUCGjrPATXQe415YAkcNFLysD4dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762642748; c=relaxed/simple;
	bh=FsKiw1P9B7UnMPLZqRZkjt9gyx01uTg4TKsCCdCA6GI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gKhNLUU3CTGIYk4DB/FT0hI+9arclfgsrywjIO4iUy1xx8vB7nU0Y+sf/t/C9JmxtPFPHBVxrCjAZnaFpvpE8AJ2nipAXQMKARW5Jr43UNfqjSka8jnOA6WFIHQxUQy79bs+52+NC0O7OrViMLUfVs9/2wrVVkQVG+ZMzG2+aNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-948610ae935so152301339f.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 14:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762642742; x=1763247542;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Q6RGTfP37+XoemsYNAa43r9yphIgY2XCSrARXAD8IY=;
        b=aWagLRHoVyVv/Z1r5kLyZzF6vGTYov5d7X0xSDJu/MmEKxanEtizW9woCBz6m4t2eI
         meEe2xxnt+6C+THE2FewVlWdtTMu+YI2xuqY2R3txfXfqc8t3qn9D/KNZwcCSVF39O4w
         GsDa4VKUzzmlUuQUWzFOReqi7Q1EbJB3K0Tcv2wfNVf5BRDaFyB/TYgKTiLC68Gd+LxR
         LM+nIeJGRZEvOxOW7QHAjVpRBcpoGIgNSgfKk99LGvYmCzZXmmHb12C8gexLFDAmgjTl
         aXrvFqtAnXakThh2IhMYdtKhAH8l06Bz/vLmtPcG5K4MilNL8E3UnK70lJNMLYDoItaG
         feRA==
X-Forwarded-Encrypted: i=1; AJvYcCXgF37UjDl7rKjb7G4OUQabmm/U10HAL7/iKKCGHeLJYBszU3cW7FeYw3zrIZ/1rQP+fMotfC5epWZQ69k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhVpjju+qSfIFg4HCHsAnVdlnA89gm884bZh4nRhMX0+O+4BeU
	N7LaYhqYf5mWRpqQK0IrVXKF1Gw5cXJ0ywrUnp7lbFKDKEO8eQ519HKNBHhB6HhgoNrOb27UL9y
	FUmnlQaY7kv1K7mMXScsPFNazjjsgDB1djXIQBA1zi1a/wIPUV6Zs+RjcaB0=
X-Google-Smtp-Source: AGHT+IFwU5vONS4ZrT3DMl8Gj3nlYJNaScCmR03ghxo2oz5bhvduoy9iw+/mi1myljro7ZPWq4gk5JEgNghehAkWOTOZLkqDO7Cy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216d:b0:431:d864:366a with SMTP id
 e9e14a558f8ab-43367dda177mr57978315ab.2.1762642742573; Sat, 08 Nov 2025
 14:59:02 -0800 (PST)
Date: Sat, 08 Nov 2025 14:59:02 -0800
In-Reply-To: <CAHc6FU7F7SQs-qq6vwaB+xTCcBPs3Hn53JPEL7w=-W6X8PSCcg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690fcb36.a70a0220.22f260.008e.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] memory leak in gfs2_trans_begin (2)
From: syzbot <syzbot+63ba84f14f62e61a5fd0@syzkaller.appspotmail.com>
To: agruenba@redhat.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in do_xmote

gfs2: fsid=syz:syz.0:  H: s:EX f:nW e:0 p:7821 [syz.6.189] gfs2_iomap_begin_write fs/gfs2/bmap.c:1040 [inline]
gfs2: fsid=syz:syz.0:  H: s:EX f:nW e:0 p:7821 [syz.6.189] gfs2_iomap_begin+0x3e6/0x8a0 fs/gfs2/bmap.c:1133
gfs2: fsid=syz:syz.0:  R: n:8336 f:80000000 b:70/70 i:7 q:0 r:0 e:7055
------------[ cut here ]------------
kernel BUG at fs/gfs2/glock.c:674!
Oops: invalid opcode: 0000 [#1] SMP PTI
CPU: 0 UID: 0 PID: 7389 Comm: kworker/0:2H Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: gfs2-glock/syz:syz glock_work_func
RIP: 0010:do_xmote+0x33d/0x360 fs/gfs2/glock.c:674
Code: 03 00 e9 cf fd ff ff e8 c1 85 09 ff 83 43 24 01 e9 53 ff ff ff e8 b3 85 09 ff ba 01 00 00 00 48 89 de 31 ff e8 f4 c9 ff ff 90 <0f> 0b e8 9c 85 09 ff ba 01 00 00 00 48 89 de 31 ff e8 dd c9 ff ff
RSP: 0018:ffffc9000a073d88 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88812e8a7728 RCX: ffffffff825ac696
RDX: ffff888102c61180 RSI: ffffffff8257e401 RDI: ffff88812d388afc
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 205d393833375420 R12: ffff8881087d0000
R13: 0000000000000001 R14: ffffffff857d0580 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8881b25c4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000c1b000 CR3: 0000000119f7c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 run_queue+0x21a/0x310 fs/gfs2/glock.c:793
 glock_work_func+0xac/0x280 fs/gfs2/glock.c:1002
 process_one_work+0x26b/0x620 kernel/workqueue.c:3263
 process_scheduled_works kernel/workqueue.c:3346 [inline]
 worker_thread+0x2c4/0x4f0 kernel/workqueue.c:3427
 kthread+0x15b/0x310 kernel/kthread.c:463
 ret_from_fork+0x210/0x240 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:do_xmote+0x33d/0x360 fs/gfs2/glock.c:674
Code: 03 00 e9 cf fd ff ff e8 c1 85 09 ff 83 43 24 01 e9 53 ff ff ff e8 b3 85 09 ff ba 01 00 00 00 48 89 de 31 ff e8 f4 c9 ff ff 90 <0f> 0b e8 9c 85 09 ff ba 01 00 00 00 48 89 de 31 ff e8 dd c9 ff ff
RSP: 0018:ffffc9000a073d88 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88812e8a7728 RCX: ffffffff825ac696
RDX: ffff888102c61180 RSI: ffffffff8257e401 RDI: ffff88812d388afc
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 205d393833375420 R12: ffff8881087d0000
R13: 0000000000000001 R14: ffffffff857d0580 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8881b25c4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000c1b000 CR3: 0000000119f7c000 CR4: 00000000003526f0


Tested on:

commit:         17448d78 gfs2: Clean up SDF_JOURNAL_LIVE flag handling
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git withdraw
console output: https://syzkaller.appspot.com/x/log.txt?x=12da8b42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb128cd5cb439809
dashboard link: https://syzkaller.appspot.com/bug?extid=63ba84f14f62e61a5fd0
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.


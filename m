Return-Path: <linux-kernel+bounces-778693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 255DCB2E905
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCAB9725B9D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4302DBF51;
	Wed, 20 Aug 2025 23:50:40 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC862727E3
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755733840; cv=none; b=Tz1q/jkuVNxUXFen7R2ER+F59ymvnFi7KI9WJIhdPCSv0A4keGu011eDC14t38YRn1xqCqZ/MPOb/yD1X9o+tSmxXzIOyqt91angkaujy5C//fHhL9RdUAkLb4WZ6J3ZnZwCzZDNSekBBaXg4N6JuKbpyHaPkE3FEsndgpnO96o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755733840; c=relaxed/simple;
	bh=+3KoXlNx3WrWJ/5JsMCHdKN2i6P9n/O4aCtS23ojPU8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nGzYKMpd3tyLAxask6TuK9gsqybEz7AGObTWNKRWbqtegjdlPbTsCnds47pMmyxTwJRYcsOa8ZN7UhOnRFsryivGVpR+nW9VJPqCR9B1ib3Zg5uDTEOnWV6+tH47qevC7YdbpYKhRfZLcp6ShuTuaWt0fMUomSxRju/7hasy+W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-88432dc61d9so90092839f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 16:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755733836; x=1756338636;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D086v0Rs3v+RLCz3bkRMPpZaf+JhG94433lHZdw/Rts=;
        b=hSj1+hWqQ3dtO0JVcEN/pWiIodMuiXTWJRLp2bjRDhOVVioFppyAHb/Aon+ry8J9my
         WEvRDhYw1nxvps0xTn9xVdUpkxTPryIa/B64vB8dg4XUlGfViRR7luWyaK3WTYUPmh4B
         0bEj2hPv9YX7uNd3SEQPgCrFmrPDicLPq1hzsNsBq2xBHVVcbleckJcF7QZwUYUCARUj
         ajgxU8PZ1I4rM+88AWhmV0HLuiIGnyRzTYxDnL74mqmi+eXWbuyfCCeQpz0WYTE9OuRs
         V2ckQFstT6NLUqp+vvxuluJx/N2rZ0bdgeHocc8pw7QbHiiBS9YC3DZixFgi5sdrHdsM
         wYcw==
X-Forwarded-Encrypted: i=1; AJvYcCUtbil7OuFPYph5CcNV4u9VpEyQJ/R7TWQG01nXjf8XH41n3y5MZ6yDsVfPepuDAJyTzqQxWnRa5rrrD84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc0MCSLw1d9hekLKGW0JYBWFKP+ffBCZU9j9LWTCpqs4SVOjCk
	WWhYQmIKPPY1CFV/+E5v4WzletNAL1B6dMaNiqHczzgb9oPVafm4o1bL/pqAJwbsrdhdPHenK/A
	ZhiOgmpyjwygSlbswoopMruI68OjmnPWe4R1n3R91GjybNN8+D5bdl2F35QM=
X-Google-Smtp-Source: AGHT+IEol/67olrEtfvGrg4UJl8gG4giFewisK5YgIL16sHEbuUOlPsTM4sjoEl1wJKuqaDR6qQEVAU25iyh8ZzTgJ+xBBS2bSV9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e89:b0:3e5:6313:4562 with SMTP id
 e9e14a558f8ab-3e6d69d9a48mr7400695ab.14.1755733835907; Wed, 20 Aug 2025
 16:50:35 -0700 (PDT)
Date: Wed, 20 Aug 2025 16:50:35 -0700
In-Reply-To: <684c0d76.050a0220.be214.029f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a65f4b.050a0220.3d78fd.000f.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] kernel BUG in gfs2_jindex_free (2)
From: syzbot <syzbot+150563285f78ac3e9bd4@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    5303936d609e Add linux-next specific files for 20250820
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16775442580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4602df3fd8f406ec
dashboard link: https://syzkaller.appspot.com/bug?extid=150563285f78ac3e9bd4
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e597a2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/57c3527e418a/disk-5303936d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7f1e146ea30f/vmlinux-5303936d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/55bebb5dd947/bzImage-5303936d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/5e2270ee146f/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=159c16f0580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+150563285f78ac3e9bd4@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/gfs2/super.c:76!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 7296 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:gfs2_jindex_free+0x43e/0x440 fs/gfs2/super.c:76
Code: cc cc cc cc cc 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c ea fd ff ff e8 22 e7 25 fe e9 e0 fd ff ff e8 88 e4 7f 07 e8 b3 1f c2 fd 90 <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00
RSP: 0018:ffffc9000b737a40 EFLAGS: 00010293
RAX: ffffffff83fda7cd RBX: dead000000000122 RCX: ffff88802c6c9e00
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 00000000ffffffff
RBP: ffffc9000b737b00 R08: ffff888078520de7 R09: 1ffff1100f0a41bc
R10: dffffc0000000000 R11: ffffed100f0a41bd R12: ffff8880785208b0
R13: dffffc0000000000 R14: ffff888033122800 R15: ffff888033122878
FS:  0000000000000000(0000) GS:ffff888125a05000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff329e51000 CR3: 0000000030646000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 gfs2_put_super+0x8af/0x950 fs/gfs2/super.c:636
 generic_shutdown_super+0x132/0x2c0 fs/super.c:643
 kill_block_super+0x44/0x90 fs/super.c:1723
 deactivate_locked_super+0xbc/0x130 fs/super.c:474
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1375
 task_work_run+0x1d1/0x260 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x6b5/0x2300 kernel/exit.c:961
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1102
 __do_sys_exit_group kernel/exit.c:1113 [inline]
 __se_sys_exit_group kernel/exit.c:1111 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1111
 x64_sys_call+0x21f7/0x2200 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fed18f8ebe9
Code: Unable to access opcode bytes at 0x7fed18f8ebbf.
RSP: 002b:00007ffc2c3ee178 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fed19011c2a RCX: 00007fed18f8ebe9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000005 R08: 00007ffc2c3ebf17 R09: 00007ffc2c3ef3d0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc2c3ef3d0
R13: 00007fed19011c05 R14: 0000000000053df0 R15: 00007ffc2c3ef410
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:gfs2_jindex_free+0x43e/0x440 fs/gfs2/super.c:76
Code: cc cc cc cc cc 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c ea fd ff ff e8 22 e7 25 fe e9 e0 fd ff ff e8 88 e4 7f 07 e8 b3 1f c2 fd 90 <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00
RSP: 0018:ffffc9000b737a40 EFLAGS: 00010293
RAX: ffffffff83fda7cd RBX: dead000000000122 RCX: ffff88802c6c9e00
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 00000000ffffffff
RBP: ffffc9000b737b00 R08: ffff888078520de7 R09: 1ffff1100f0a41bc
R10: dffffc0000000000 R11: ffffed100f0a41bd R12: ffff8880785208b0
R13: dffffc0000000000 R14: ffff888033122800 R15: ffff888033122878
FS:  0000000000000000(0000) GS:ffff888125b05000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fece4332000 CR3: 00000000584a4000 CR4: 00000000003526f0


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


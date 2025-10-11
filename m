Return-Path: <linux-kernel+bounces-849136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0ABBCF474
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 13:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640C53BC1CB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 11:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1CC220F5C;
	Sat, 11 Oct 2025 11:31:01 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D6B79CD
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 11:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760182261; cv=none; b=ODQ6+1m61cJCGjraiQ2p1CTbymzErGTdT7zJRbA3KJf0gPnuxWIc5jw3xkEh8lfz8AS/biHFF48f5zhLq/ycSYbEt6xaVfcfLk8I9ZFHAlkq1X34kd7QByNDe2OC4QCewqD6cKaRbLqKb+l6ht57Yghu7XYFhF6G/rxjlSlREb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760182261; c=relaxed/simple;
	bh=WWOqqlfSifYJ8dmhByqoEckwadNKIf3bOMBC8pOphXY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GWFWQ0q7lXamEEW6TV6QUSet49joTJs0A069xYcDJexWrCQYlGYC4cm+hVZGl1XBWrqIEIXX2RYyd8WcjVMEkPPLvi7/ImJcVjhiSafNmmSbNSNacris3lHVh+YehtJNIbGC70y1gDyN1VsbwagNonLh+2Dy9yLoZjMellGSG24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-93bbd28b4f3so981539839f.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 04:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760182255; x=1760787055;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oRtaqqxKRjhstnVyhdIHSVn0l7POjO8zHan2vGb0vbA=;
        b=aiN4nwhLRmonJkj1gT0cNnIoqvSYdRjIw8uvapI30lj8tBUvEdFaA7D6Te0R8kyUQK
         xuOs40IDu85RHyJiMYHzLX8UO+AGZtALPzqVVOF4IG2wqGWbZaLukLIH4XO01Ed0Ke1K
         erYIUNe9U1sddZfK9vkgvQmjw4PiamGxxqlaEkt29uEYTfIW7DKSAvJ6CH6IDXiOtPFa
         JKVoTGD0BGdJvZsduWsjXFJ9SUtMzMgMWOIy7F5I0yfdoZf9FeoGbHnXT35nnX2lFIBN
         8oivOfC/MBKmkQ/q+xllnG4CJBtfBPP7uAdUdrARA5P3PjT+bEnuG/GqSpbHwnop/NUx
         RGSA==
X-Gm-Message-State: AOJu0YzeoprjU4XDPfTUpsDQn92x5rpNuUM9x+hmuj97gSUzI7Mjznbf
	6rXNq7x/jtT5P3Rkxd8S8+9WcNfSgPB9sRDucouVWqUk0o1V28rWnBjkFceXXzqjTfB4KUxksXU
	hFmfCnSMACTOL5AzRaoNt/Flkc32XXLa1z7FHRDyhz/H97udljJrbkJLEViInJQ==
X-Google-Smtp-Source: AGHT+IHXDNKvS72bz2S10qMFqoCN9lbFtGU8rfwZWouwIYC88ggWJAs1uJjLFbsIXASheCBpF8+/40sSn5sTm/sdlA7Q18OVPNYQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c8d:b0:93b:da4c:632c with SMTP id
 ca18e2360f4ac-93bda4c648bmr1654751939f.14.1760182254942; Sat, 11 Oct 2025
 04:30:54 -0700 (PDT)
Date: Sat, 11 Oct 2025 04:30:54 -0700
In-Reply-To: <67ec7e14.050a0220.31979b.0031.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ea3fee.a70a0220.b3ac9.0009.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [f2fs?] kernel BUG in f2fs_write_end_io
From: syzbot <syzbot+803dd716c4310d16ff3a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [f2fs?] kernel BUG in f2fs_write_end_io
Author: chao@kernel.org

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git bugfix/syzbot

On 4/15/25 22:14, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    834a4a689699 Merge tag 'for-linus' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10051a3f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a972ee73c2fcf8ca
> dashboard link: https://syzkaller.appspot.com/bug?extid=803dd716c4310d16ff3a
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145a2fe4580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13382470580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-834a4a68.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/4454365a3050/vmlinux-834a4a68.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/2d99dbd9f6f4/bzImage-834a4a68.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/89819a66cafe/mount_0.gz
>   fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=13420b98580000)
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+803dd716c4310d16ff3a@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> kernel BUG at fs/f2fs/data.c:358!
> Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> CPU: 0 UID: 0 PID: 1033 Comm: kworker/u4:5 Not tainted 6.15.0-rc2-syzkaller-00037-g834a4a689699 #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Workqueue: loop0 loop_rootcg_workfn
> RIP: 0010:f2fs_write_end_io+0x77a/0x790 fs/f2fs/data.c:357
> Code: e8 fb d8 f0 fd e9 a2 fa ff ff 89 d9 80 e1 07 38 c1 0f 8c fe fa ff ff 48 89 df e8 81 d8 f0 fd e9 f1 fa ff ff e8 d7 9e 86 fd 90 <0f> 0b e8 9f 0a f4 07 66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00
> RSP: 0000:ffffc90002597320 EFLAGS: 00010093
> RAX: ffffffff843cb659 RBX: 0000000000000000 RCX: ffff888035d74880
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000000a
> RBP: ffffc90002597430 R08: ffffffff843cb306 R09: 1ffffd4000219d7d
> R10: dffffc0000000000 R11: fffff94000219d7e R12: 0000000000000001
> R13: dffffc0000000000 R14: 000000000000000a R15: ffffea00010cebc0
> FS:  0000000000000000(0000) GS:ffff88808c593000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f7f3f420000 CR3: 00000000430fc000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  blk_update_request+0x5e5/0x1160 block/blk-mq.c:983
>  blk_mq_end_request+0x3e/0x70 block/blk-mq.c:1145
>  blk_flush_complete_seq+0x6bd/0xcf0 block/blk-flush.c:191
>  flush_end_io+0xab4/0xdc0 block/blk-flush.c:250
>  __blk_mq_end_request+0x492/0x5d0 block/blk-mq.c:1135
>  loop_handle_cmd drivers/block/loop.c:1960 [inline]
>  loop_process_work+0x1bdf/0x21d0 drivers/block/loop.c:1978
>  process_one_work kernel/workqueue.c:3238 [inline]
>  process_scheduled_works+0xac3/0x18e0 kernel/workqueue.c:3319
>  worker_thread+0x870/0xd50 kernel/workqueue.c:3400
>  kthread+0x7b7/0x940 kernel/kthread.c:464
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:f2fs_write_end_io+0x77a/0x790 fs/f2fs/data.c:357
> Code: e8 fb d8 f0 fd e9 a2 fa ff ff 89 d9 80 e1 07 38 c1 0f 8c fe fa ff ff 48 89 df e8 81 d8 f0 fd e9 f1 fa ff ff e8 d7 9e 86 fd 90 <0f> 0b e8 9f 0a f4 07 66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00
> RSP: 0000:ffffc90002597320 EFLAGS: 00010093
> RAX: ffffffff843cb659 RBX: 0000000000000000 RCX: ffff888035d74880
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000000a
> RBP: ffffc90002597430 R08: ffffffff843cb306 R09: 1ffffd4000219d7d
> R10: dffffc0000000000 R11: fffff94000219d7e R12: 0000000000000001
> R13: dffffc0000000000 R14: 000000000000000a R15: ffffea00010cebc0
> FS:  0000000000000000(0000) GS:ffff88808c593000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f7f3f420000 CR3: 00000000430fc000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.



Return-Path: <linux-kernel+bounces-748182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FA4B13D98
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73D587A94B7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0EF269D16;
	Mon, 28 Jul 2025 14:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1bp9LFRj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="po27wi1u"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BEC1C862C
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753714004; cv=none; b=dIRNkJzLY02aEo5rYAwUyoyk2VO9vZb6xgdP6nFZEIP2fS+P6yYBsvz0C1R7zinQxYRktoAFy3mhtIW2wyNEOPfvR+obZ0l0a1Sz9Wf49knAjg8TvOsHpxSkG1UmqHCuWMs2wp1Z0yQ1B1OF93CA14DlAwxUgfnKC0K0SmznNqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753714004; c=relaxed/simple;
	bh=lAg1smOYF7Dbh8ExcRXb+yXOQV/Z7kSgn8Us1d5ttX8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rDwsNSNQs/i2L9jxrBc6VHyZIG/qIQQTVqFbNVAiA0PDnm03AuAkalv2K3DgsY4xXocyXu4NFPt/thWaIzc2CaSe3tp/e+bamKwHAF7pT00h9YUAY+2WuDFPiVPQzauY75TtN855bfVYcxnBbDzZHEPH4f67z5fD5/OcQuxiuJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1bp9LFRj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=po27wi1u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753713999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rGRLzTUBR37RB7ZFX+iCaiA4xfKqVJunDIGo5ZMzdLo=;
	b=1bp9LFRjKLuicYWRxhHf0UUvF5Dvs7wH5Gi1GRcW+sm3yBl4vmmtU2dn0RRMq2nsyLH26y
	pSCsHnuLcQ89E5IQtrWL2umHrs5e6h04jTTfpj7gLJVVSI7dQFJh0IlnUnLwUSGX50V9V1
	a15+o+gp12txwooDzO6jQSCZRwVdpbxBsz2Z3JctfivnylYp7QSvLS8zJ74d8Q9esWPvVj
	Iz2QzlBFGTCvtwvRFSERZ/I9ppu2qBg7oCerv9XJ6l+gAYxs7Xb8OvhPk/4mOzxJAA0NIE
	WHwVqO9JTmNaJBochBxKyYkL17zWIHlk9xHDla+b0UxzB6X6bp3Ql8m3dl64zA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753713999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rGRLzTUBR37RB7ZFX+iCaiA4xfKqVJunDIGo5ZMzdLo=;
	b=po27wi1u+WiOpiZCj+LIEtuESWCVVz/tQ+hxwzy/76ltxBWu3Bg2dlqcTVVHmeFc/9magM
	JfhZ1F1avAhef6Aw==
To: syzbot <syzbot+c3be4001853e1add0a03@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org,
 syzkaller-bugs@googlegroups.com
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [syzbot] [kernel?] WARNING in sched_mm_cid_remote_clear (3)
In-Reply-To: <68877998.050a0220.1a379b.0005.GAE@google.com>
References: <68877998.050a0220.1a379b.0005.GAE@google.com>
Date: Mon, 28 Jul 2025 16:46:38 +0200
Message-ID: <87bjp4pe41.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 28 2025 at 06:22, syzbot wrote:

CC+ Mathieu and leaving the context intact.

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    25fae0b93d1d Merge tag 'drm-fixes-2025-07-24' of https://g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=136930a2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9f175a9275d2cdd7
> dashboard link: https://syzkaller.appspot.com/bug?extid=c3be4001853e1add0a03
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/7acf9d19f311/disk-25fae0b9.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/532080ae9996/vmlinux-25fae0b9.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/47473831ee3b/bzImage-25fae0b9.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c3be4001853e1add0a03@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 12208 at ./include/linux/cpumask.h:135 cpu_max_bits_warn include/linux/cpumask.h:135 [inline]

That means __mm_cid_put() is invoked with cid >= nr_cpu_ids ....

> WARNING: CPU: 1 PID: 12208 at ./include/linux/cpumask.h:135 cpumask_check include/linux/cpumask.h:142 [inline]
> WARNING: CPU: 1 PID: 12208 at ./include/linux/cpumask.h:135 cpumask_clear_cpu include/linux/cpumask.h:620 [inline]
> WARNING: CPU: 1 PID: 12208 at ./include/linux/cpumask.h:135 __mm_cid_put kernel/sched/sched.h:3622 [inline]
> WARNING: CPU: 1 PID: 12208 at ./include/linux/cpumask.h:135 sched_mm_cid_remote_clear+0x488/0x4f0 kernel/sched/core.c:10543
> Modules linked in:
> CPU: 1 UID: 0 PID: 12208 Comm: syz.4.2719 Not tainted 6.16.0-rc7-syzkaller-00034-g25fae0b93d1d #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
> RIP: 0010:cpu_max_bits_warn include/linux/cpumask.h:135 [inline]
> RIP: 0010:cpumask_check include/linux/cpumask.h:142 [inline]
> RIP: 0010:cpumask_clear_cpu include/linux/cpumask.h:620 [inline]
> RIP: 0010:__mm_cid_put kernel/sched/sched.h:3622 [inline]
> RIP: 0010:sched_mm_cid_remote_clear+0x488/0x4f0 kernel/sched/core.c:10543
> Code: 0f 01 e8 3b 71 0e 00 eb 9d 4c 89 ef e8 f1 73 97 00 e9 67 fc ff ff e8 e7 73 97 00 e9 47 fd ff ff 89 44 24 48 e9 17 fe ff ff 90 <0f> 0b 90 e9 f0 fd ff ff e8 8b b3 fc 09 e9 06 ff ff ff 48 89 d6 48
> RSP: 0018:ffffc9000480fcc8 EFLAGS: 00010012
> RAX: 0000000000000093 RBX: ffffe8ffffc476c0 RCX: ffffffff8189c611
> RDX: 00000000ffffffff RSI: 0000000000000004 RDI: ffffc9000480fd10
> RBP: 1ffff92000901f9a R08: 0000000000000001 R09: fffff52000901fa2
> R10: 0000000000000003 R11: 0000000000000001 R12: ffff88807b22ed50
> R13: ffffe8ffffc476c8 R14: 0000000000000200 R15: ffff8880b843a2c0
> FS:  000055556f5a3500(0000) GS:ffff888124820000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055558d727588 CR3: 00000000668d0000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  sched_mm_cid_remote_clear_old kernel/sched/core.c:10576 [inline]
>  task_mm_cid_work+0x3b4/0x910 kernel/sched/core.c:10626
>  task_work_run+0x14d/0x240 kernel/task_work.c:227
>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>  exit_to_user_mode_loop+0xeb/0x110 kernel/entry/common.c:114
>  exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
>  syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
>  syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
>  do_syscall_64+0x3f6/0x4c0 arch/x86/entry/syscall_64.c:100
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f8ef99c1265
> Code: 24 0c 89 3c 24 48 89 4c 24 18 e8 f6 54 ff ff 4c 8b 54 24 18 48 8b 54 24 10 41 89 c0 8b 74 24 0c 8b 3c 24 b8 e6 00 00 00 0f 05 <44> 89 c7 48 89 04 24 e8 4f 55 ff ff 48 8b 04 24 48 83 c4 28 f7 d8
> RSP: 002b:00007ffe741fc2d0 EFLAGS: 00000293 ORIG_RAX: 00000000000000e6
> RAX: 0000000000000000 RBX: 00007f8ef9bb5fa0 RCX: 00007f8ef99c1265
> RDX: 00007ffe741fc310 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 00007f8ef9bb7ba0 R08: 0000000000000000 R09: 00007f8efa7eb000
> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000048110
> R13: 00007f8ef9bb6080 R14: ffffffffffffffff R15: 00007ffe741fc450
>  </TASK>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup


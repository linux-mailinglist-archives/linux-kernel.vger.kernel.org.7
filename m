Return-Path: <linux-kernel+bounces-797377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40164B40F98
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 23:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13ABE547423
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 21:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717972F744C;
	Tue,  2 Sep 2025 21:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qx1PuQgq"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6701E51D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 21:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756849603; cv=none; b=P43qHSOrDQD2C0NyDBCO/z9tDnxUnicIqD4a6e2wKjR1YxjdR3wADFwdTYE0nOlZThmmz0DOMBWv0I3nijaeKx4OQZJZbjN4thQa0BaBfjinNRlq1gY4b12RxQyZsB0OsB4HOjral+sFMtg2XhMcskE0YtayfZ7FheIJ8hPb2Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756849603; c=relaxed/simple;
	bh=AwF70zVoPxPFHbgMFP/g4nfv4ChgkPXzUCs+JC2Fz3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzHf9Rx0ZXcSv7KLOg2H+KgI5vFb0xWJyWuZZIVmKANlGGARBDIfmJTq3RlbM9OZL/EqAqplGQGc4xfOnsd2CObxPDVwLGhqsWaJ/9SeYz/f9Jsu34sRXSvQLmniwVUWl4smyRcnKksuQrYxvwNfYIZJrRebXu8+YkVYhtcogBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qx1PuQgq; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KJAMV6NrT8yOikKizgtOc925UlXi8jRM8kpRuSXZ9Og=; b=qx1PuQgqz23OMToUTsN7ldegKC
	r+yBxNds3QjlZ6f8nLxOOggGt0T+6lup1A/48p3M5BcbOraV9gSR8AjQPraorVjECeTLJChRpLLRg
	HXtXk6toxWlVIBorD7Uc/hYw8QB9HTjzPQzwFQYMMf0Qj2BlK4/Rd4l91x39a6ksZ9onyDGGXbz7A
	hhgVisUaw5J6Oy6jvY1rj1sW1CldNMp7DHtVWYZaDB5iTLj381qCpUyi9DtHsxsfcVdl8GHUfiUDx
	UoWl4rr0etKsIrMXtrvdZ0Z23tVaXolqIq5h/QyF7WC51NOD8d9oK+LkIYRtz9hDamjwB5/EE0OmL
	VKTXAZWQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utYph-000000044XY-40Rl;
	Tue, 02 Sep 2025 21:46:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C542730039F; Tue, 02 Sep 2025 23:46:28 +0200 (CEST)
Date: Tue, 2 Sep 2025 23:46:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: syzbot <syzbot+034246a838a10d181e78@syzkaller.appspotmail.com>
Cc: andrealmeid@igalia.com, dave@stgolabs.net, dvhart@infradead.org,
	linux-kernel@vger.kernel.org, mingo@redhat.com,
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [syzbot] [kernel?] general protection fault in try_to_wake_up (3)
Message-ID: <20250902214628.GL4067720@noisy.programming.kicks-ass.net>
References: <68b75989.050a0220.3db4df.01dd.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68b75989.050a0220.3db4df.01dd.GAE@google.com>

On Tue, Sep 02, 2025 at 01:54:33PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    5c3b3264e585 Merge tag 'x86_urgent_for_v6.17_rc4' of git:/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12e1ae34580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bd9738e00c1bbfb4
> dashboard link: https://syzkaller.appspot.com/bug?extid=034246a838a10d181e78
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f6a1f0580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/37953b384dff/disk-5c3b3264.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/df5cc1c4e51d/vmlinux-5c3b3264.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/2ed6195eae9f/bzImage-5c3b3264.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+034246a838a10d181e78@syzkaller.appspotmail.com
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc000000014b: 0000 [#1] SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000a58-0x0000000000000a5f]

When I build the provided .config with clang-20, that a58 offset is
exactly task_struct::pi_lock::lockdep_map, which nicely corresponds with
the below stacktrace, and seems to suggest someone did:
try_to_wake_up(NULL).

> CPU: 1 UID: 0 PID: 6293 Comm: syz.0.60 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
> RIP: 0010:kasan_byte_accessible+0x12/0x30 mm/kasan/generic.c:199
> Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 48 c1 ef 03 48 b8 00 00 00 00 00 fc ff df <0f> b6 04 07 3c 08 0f 92 c0 e9 d0 9f dc 08 cc 66 66 66 66 66 66 2e
> RSP: 0018:ffffc9000157f7e0 EFLAGS: 00010006
> RAX: dffffc0000000000 RBX: ffffffff8af9dfe7 RCX: e1dbfc1ee2ae4a00
> RDX: 0000000000000000 RSI: ffffffff8af9dfe7 RDI: 000000000000014b
> RBP: ffffffff81908477 R08: 0000000000000001 R09: 0000000000000000
> R10: dffffc0000000000 R11: fffffbfff1e3a947 R12: 0000000000000000
> R13: 0000000000000a58 R14: 0000000000000a58 R15: 0000000000000001
> FS:  00007ff6ed61d6c0(0000) GS:ffff8881269c2000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ff6ed61cf40 CR3: 0000000027554000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  __kasan_check_byte+0x12/0x40 mm/kasan/common.c:567
>  kasan_check_byte include/linux/kasan.h:399 [inline]
>  lock_acquire+0x8d/0x360 kernel/locking/lockdep.c:5842
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>  _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
>  class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:557 [inline]
>  try_to_wake_up+0x67/0x12b0 kernel/sched/core.c:4216
>  requeue_pi_wake_futex+0x24b/0x2f0 kernel/futex/requeue.c:249

Trouble is, we've not changed the requeue bits in a fair while... So I'm
somewhat confused on how this happens now ?!

>  futex_proxy_trylock_atomic kernel/futex/requeue.c:340 [inline]
>  futex_requeue+0x135f/0x1870 kernel/futex/requeue.c:498
>  do_futex+0x362/0x420 kernel/futex/syscalls.c:-1
>  __do_sys_futex kernel/futex/syscalls.c:179 [inline]
>  __se_sys_futex+0x36f/0x400 kernel/futex/syscalls.c:160
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f


Return-Path: <linux-kernel+bounces-886364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67162C355CA
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 12:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 738C03AC65A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 11:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B54630F7F8;
	Wed,  5 Nov 2025 11:25:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69309304BB7
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 11:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762341903; cv=none; b=i07XVjw46bO+jpln6uyc+myj1F7ejkdll8ApBbC6WIeSLziQLcnIjhVJdn3rZfDWfebMaAOOxByZCta9NxCSXc5Q0A7zx6ns5lTIYRE9hXoIEVHf+aAxjXF5oqljRFX34qlP1L0nAYPLHQP6j2ZXbHpME5TLdMv3XjGaNwmVjh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762341903; c=relaxed/simple;
	bh=hmU/qaIXwsENiD16foyteDE2erGI0Q+ynMc9NW62fCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWL11Y2UYlXtsRyWEvGOV8ojz5UdZHaboU1oB9Fe43Ea0qjsAcBezJn/Si8/Vyi2Xn3NSz86QqPnA0K4HKUn1xAUtwKLMTeDWiRRmFWT5W/QsexSFcLi6kLgeayN4PQRDgJpKIYjXfMkBwmn2Re0r9efPnuajM1mn2d0KRPY/aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E44B0169C;
	Wed,  5 Nov 2025 03:24:52 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7DC23F63F;
	Wed,  5 Nov 2025 03:24:59 -0800 (PST)
Date: Wed, 5 Nov 2025 11:24:54 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: syzbot <syzbot+d4ab35af21e99d07ce67@syzkaller.appspotmail.com>
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	will@kernel.org
Subject: Re: [syzbot] [arm?] WARNING in fpsimd_restore_current_state
Message-ID: <aQs0Bkrbnqinlqss@J2N7QTR9R3>
References: <690a8dc2.050a0220.3d0d33.0018.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <690a8dc2.050a0220.3d0d33.0018.GAE@google.com>

On Tue, Nov 04, 2025 at 03:35:30PM -0800, syzbot wrote:
> Hello,

Hi,

Initial analysis / holding-reply below.

> syzbot found the following issue on:
> 
> HEAD commit:    dcb6fa37fd7b Linux 6.18-rc3
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=11a79704580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b8b659f0cab27b22
> dashboard link: https://syzkaller.appspot.com/bug?extid=d4ab35af21e99d07ce67
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115fdf34580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1441d258580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ae6bec0d0398/disk-dcb6fa37.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/dcc732da66c3/vmlinux-dcb6fa37.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/301d1bbdecc2/Image-dcb6fa37.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d4ab35af21e99d07ce67@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 6720 at arch/arm64/kernel/fpsimd.c:370 task_fpsimd_load arch/arm64/kernel/fpsimd.c:370 [inline]
> WARNING: CPU: 0 PID: 6720 at arch/arm64/kernel/fpsimd.c:370 fpsimd_restore_current_state+0x4cc/0x708 arch/arm64/kernel/fpsimd.c:1746

This warning is due to the saved state being in SVE format unexpectedly (with
TIF_SVE clear and PSTATE.SM clear). Within task_fpsimd_load() we have:

	switch (current->thread.fp_type) {
	...
	case FP_STATE_SVE:
		if (!thread_sm_enabled(&current->thread))
			WARN_ON_ONCE(!test_and_set_thread_flag(TIF_SVE));

There's definitely some bug that allowed the task to get into a state that
should be forbidden.

I see that the repro has:

	ptrace$setregset(0x4205, r0, 0x405, &(0x7f0000000000)={0x0, 0x300})

... which looks to be a write to NT_ARM_SVE.

That suggests there's some path through sve_set_common() that leaves the task
in an inconsistent state.

From a qucik look, it appears that's possible as a result of a partial SVE
write; I'll go check and see what we can do to fix that.

Mark.

> Modules linked in:
> CPU: 0 UID: 0 PID: 6720 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/03/2025
> pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> pc : task_fpsimd_load arch/arm64/kernel/fpsimd.c:370 [inline]
> pc : fpsimd_restore_current_state+0x4cc/0x708 arch/arm64/kernel/fpsimd.c:1746
> lr : task_fpsimd_load arch/arm64/kernel/fpsimd.c:370 [inline]
> lr : fpsimd_restore_current_state+0x4cc/0x708 arch/arm64/kernel/fpsimd.c:1746
> sp : ffff8000a1047de0
> x29: ffff8000a1047de0 x28: ffff0000dcfd9ec0 x27: 0000000000000000
> x26: 0000000000000000 x25: 0000000000000008 x24: 0000000000000040
> x23: 00000000000020ff x22: dfff800000000000 x21: 1fffe0001b9fb3d8
> x20: 0000000000000000 x19: ffff0000dcfd9ec0 x18: 1fffe000337db690
> x17: ffff80008ae011f8 x16: ffff80008052ae04 x15: 0000000000000001
> x14: 1fffe0001b9fb3d8 x13: 0000000000000000 x12: 0000000000000000
> x11: ffff60001b9fb3d9 x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : ffff0000dcfd9ec0 x7 : 0000000000000000 x6 : 0000000000000000
> x5 : 0000000000000001 x4 : 0000000000000008 x3 : ffff8000801f8344
> x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
>  task_fpsimd_load arch/arm64/kernel/fpsimd.c:370 [inline] (P)
>  fpsimd_restore_current_state+0x4cc/0x708 arch/arm64/kernel/fpsimd.c:1746 (P)
>  arch_exit_to_user_mode_work arch/arm64/include/asm/entry-common.h:25 [inline]
>  exit_to_user_mode_loop+0xe4/0x178 kernel/entry/common.c:46
>  exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
>  arm64_exit_to_user_mode arch/arm64/kernel/entry-common.c:103 [inline]
>  el0_svc+0x170/0x254 arch/arm64/kernel/entry-common.c:747
>  el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:765
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
> irq event stamp: 129
> hardirqs last  enabled at (127): [<ffff80008ae151bc>] __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
> hardirqs last  enabled at (127): [<ffff80008ae151bc>] _raw_spin_unlock_irq+0x30/0x80 kernel/locking/spinlock.c:202
> hardirqs last disabled at (129): [<ffff80008adecb80>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:434
> softirqs last  enabled at (8): [<ffff8000801f95fc>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
> softirqs last disabled at (128): [<ffff8000801f95c8>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
> ---[ end trace 0000000000000000 ]---
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
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
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
> 


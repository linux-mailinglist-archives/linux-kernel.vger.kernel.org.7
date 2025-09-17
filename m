Return-Path: <linux-kernel+bounces-819789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A352AB7D5AD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AED634E49A7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 00:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5481D5ABA;
	Wed, 17 Sep 2025 00:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QmDskpRi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7BB1CEADB
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 00:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758069359; cv=none; b=BwJUqKB2eFGvyS+e/VA/pVQblSg5a8qFDRUTpTridQNyGx5+BUDWOWBAMfHHs7MG0ViKqdVdk5D3xptaeV7ajnPm0EK1KiaPExMlDn0vOUw86FAaSNoW0IUtM07MMzlgpD7umQgLwLmE/TcJY4xzpL+b3m8aSMpBNHSZja4kbtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758069359; c=relaxed/simple;
	bh=b6EDHQBLsyrVIP0TxL+zPufHeo/CggP32M+Tq2y/M5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOyEJj4DKBZDmM+OwyjbKGLHvaiuc+JbLq12JFTObAVMXlgRlSDJD77SL3zHiZXcn7ELDe47qHqjftDGfcPzmlZPt6mgnznfezbA78VaJLevqeHRAEn2o5jD+Sa3SewNWC+FtieqejFFsqznUb0nvSsxJc90lvW9gShLlRL1tao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QmDskpRi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758069354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=unXRLvM1TxOfalUS+vT3Rs0LbksjKu+IOcTVgG5tswg=;
	b=QmDskpRi2Sf9X6COsj+5RQCIq6Hf+Q4yRscmLEcUwbwhiWlZ2vYS75Nw0lR1qR1NFTlmWr
	iqPoIug4NeRZiNAwiAP5Cl/zJv8TlE6aqNUedtsEWV6dr7EBANbVPBlYuvwqy1Cn7zDlRo
	L7CRry7FkSZ2p2wTL0Gwxau8E7kUcg0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-dy2Z1e5yMLaAqKHNqwyatQ-1; Tue,
 16 Sep 2025 20:35:50 -0400
X-MC-Unique: dy2Z1e5yMLaAqKHNqwyatQ-1
X-Mimecast-MFC-AGG-ID: dy2Z1e5yMLaAqKHNqwyatQ_1758069349
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A7645180034F;
	Wed, 17 Sep 2025 00:35:48 +0000 (UTC)
Received: from localhost (unknown [10.22.80.155])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 71E16195608E;
	Wed, 17 Sep 2025 00:35:47 +0000 (UTC)
Date: Tue, 16 Sep 2025 21:35:45 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	aubrey.li@linux.intel.com, yu.c.chen@intel.com
Subject: Re: [linus:master] [sched]  8671bad873:
 INFO:task_blocked_for_more_than#seconds
Message-ID: <aMoCYelz87V8bSzA@uudg.org>
References: <202509051010.e06823ab-lkp@intel.com>
 <aL8NGXiYUAukMCGY@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL8NGXiYUAukMCGY@uudg.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Sep 08, 2025 at 02:06:37PM -0300, Luis Claudio R. Goncalves wrote:
> On Fri, Sep 05, 2025 at 10:49:35AM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "INFO:task_blocked_for_more_than#seconds" on:
> > 
> > commit: 8671bad873ebeb082afcf7b4501395c374da6023 ("sched: Do not call __put_task_struct() on rt if pi_blocked_on is set")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > [test failed on      linus/master 08b06c30a44555a8b1d14950e4462a52bfa0758b]
> > [test failed on linux-next/master 5d50cf9f7cf20a17ac469c20a2e07c29c1f6aab7]
> > 
> > in testcase: rcutorture
> > version: 
> > with following parameters:
> > 
> > 	runtime: 300s
> > 	test: cpuhotplug
> > 	torture_type: tasks-rude
> 
> I ran tests with the boxes I had at hand, x86_64 and arm64, and was unable
> to reproduce the problem. Tomorrow, when I am back from a holiday,, I will
> try to reproduce the problem with x86 (32 bits) VMs and x86 baremetal as it
> seems to be the case on the report.

I have been trying to reproduce the problem for a week now, on both
baremetal and VMs, x86 32 bits, without success. I tried to limit the
amount of CPUs and memory, to mimic as well as possible the test
environment but that has not changed the test results at all.

Are there any other pointers to reproduce this problem? Other than what can
be extracted from the log excerpts available, I mean.

Best regards.
Luis

> In any case, I sent a follow-up patch that isolated those changes to
> kernels with PREEMPT_RT enabled, as initially intended. That should solve
> this case (if really caused by the commit in question). The patch I
> mentioned is:
> 
>     [RESEND PATCH] sched: restore the behavior of put_task_struct() for non-rt
>     https://lore.kernel.org/all/aKxqGLNOp2sWJwnZ@uudg.org/
> 
> Best regards,
> Luis
>  
> > 
> > 
> > config: i386-randconfig-017-20250830
> > compiler: gcc-12
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > the issue happens randomly and we observed various issues in tests by this
> > commit, while parent keeps clean.
> > 
> > =========================================================================================
> > tbox_group/testcase/rootfs/kconfig/compiler/runtime/test/torture_type:
> >   vm-snb/rcutorture/debian-11.1-i386-20220923.cgz/i386-randconfig-017-20250830/gcc-12/300s/cpuhotplug/tasks-rude
> > 
> > 7de9d4f946383f48 8671bad873ebeb082afcf7b4501
> > ---------------- ---------------------------
> >        fail:runs  %reproduction    fail:runs
> >            |             |             |
> >            :200         16%          32:200   dmesg.BUG:kernel_hang_in_boot_stage
> >            :200          0%           1:200   dmesg.BUG:soft_lockup-CPU##stuck_for#s![swapper:#]
> >            :200          1%           2:200   dmesg.BUG:workqueue_lockup-pool
> >            :200          0%           1:200   dmesg.EIP:kthread_affine_preferred
> >            :200          0%           1:200   dmesg.EIP:lock_release
> >            :200          0%           1:200   dmesg.EIP:tick_clock_notify
> >            :200         12%          23:200   dmesg.INFO:task_blocked_for_more_than#seconds
> >            :200         12%          23:200   dmesg.Kernel_panic-not_syncing:hung_task:blocked_tasks
> >            :200          0%           1:200   dmesg.Kernel_panic-not_syncing:softlockup:hung_tasks
> >            :200          0%           1:200   dmesg.WARNING:at_kernel/kthread.c:#kthread_affine_preferred
> > 
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202509051010.e06823ab-lkp@intel.com
> > 
> > 
> > [  994.935251][   T26] INFO: task swapper/0:1 blocked for more than 491 seconds.
> > [  994.947414][   T26]       Not tainted 6.16.0-rc6-00086-g8671bad873eb #1
> > [  994.951523][   T26] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > [  994.960576][   T26] task:swapper/0       state:D stack:5016  pid:1     tgid:1     ppid:0      task_flags:0x0140 flags:0x00004000
> > [  994.972581][   T26] Call Trace:
> > [ 994.998429][ T26] __schedule (kernel/sched/core.c:5354 kernel/sched/core.c:6954) 
> > [ 995.035758][ T26] schedule (kernel/sched/core.c:7037 kernel/sched/core.c:7051) 
> > [ 995.044863][ T26] async_synchronize_cookie_domain (kernel/async.c:317 kernel/async.c:310) 
> > [ 995.050698][ T26] ? do_wait_intr (kernel/sched/wait.c:384) 
> > [ 995.059798][ T26] wait_for_initramfs (init/initramfs.c:778) 
> > [ 995.067798][ T26] populate_rootfs (init/initramfs.c:789) 
> > [ 995.070767][ T26] do_one_initcall (init/main.c:1274) 
> > [ 995.074441][ T26] ? initramfs_async_setup (init/initramfs.c:782) 
> > [ 995.098384][ T26] do_initcalls (init/main.c:1335 init/main.c:1352) 
> > [ 995.136744][ T26] kernel_init_freeable (init/main.c:1588) 
> > [ 995.136744][ T26] ? rest_init (init/main.c:1466) 
> > [ 995.158663][ T26] kernel_init (init/main.c:1476) 
> > [ 995.177750][ T26] ret_from_fork (arch/x86/kernel/process.c:154) 
> > [ 995.178146][ T26] ? rest_init (init/main.c:1466) 
> > [ 995.230129][ T26] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
> > [ 995.230129][ T26] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
> > [  995.268743][   T26]
> > [  995.268743][   T26] Showing all locks held in the system:
> > [  995.336987][   T26] 1 lock held by khungtaskd/26:
> > [ 995.446697][ T26] #0: 830cce10 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks (kernel/locking/lockdep.c:6768 (discriminator 1)) 
> > [  995.464546][   T26] 4 locks held by kworker/u4:2/29:
> > [  995.470758][   T26] 2 locks held by kworker/0:3/38:
> > [  995.498593][   T26]
> > [  995.599251][   T26] =============================================
> > [  995.599251][   T26]
> > [  995.729940][   T26] Kernel panic - not syncing: hung_task: blocked tasks
> > [  995.729940][   T26] CPU: 0 UID: 0 PID: 26 Comm: khungtaskd Not tainted 6.16.0-rc6-00086-g8671bad873eb #1 PREEMPT(full)
> > [  995.729940][   T26] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > [  995.729940][   T26] Call Trace:
> > [ 995.729940][ T26] dump_stack_lvl (lib/dump_stack.c:124) 
> > [ 995.729940][ T26] dump_stack (lib/dump_stack.c:130) 
> > [ 995.729940][ T26] panic (kernel/panic.c:382) 
> > [ 995.729940][ T26] check_hung_uninterruptible_tasks (kernel/hung_task.c:311) 
> > [ 995.729940][ T26] watchdog (kernel/hung_task.c:470) 
> > [ 995.729940][ T26] kthread (kernel/kthread.c:464) 
> > [ 995.729940][ T26] ? check_hung_uninterruptible_tasks (kernel/hung_task.c:453) 
> > [ 995.729940][ T26] ? kthread_complete_and_exit (kernel/kthread.c:413) 
> > [ 995.729940][ T26] ret_from_fork (arch/x86/kernel/process.c:154) 
> > [ 995.729940][ T26] ? kthread_complete_and_exit (kernel/kthread.c:413) 
> > [ 995.729940][ T26] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
> > [ 995.729940][ T26] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
> > 
> > 
> > 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20250905/202509051010.e06823ab-lkp@intel.com
> > 
> > 
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> > 
> ---end quoted text---
---end quoted text---



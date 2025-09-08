Return-Path: <linux-kernel+bounces-806417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22073B49684
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 033801B280DE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85959311955;
	Mon,  8 Sep 2025 17:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HvhVXtQ/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F0D311942
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757351205; cv=none; b=taVeVwC1C075nOJwFPH6XrYAqPKTAH5GRvJU2eiAUvgLF4qzFEP2jwupbhgKJ/OhSoRzQpTkOorLpF0XRK/hcLgptOWznPV4rg5vl8+3rxvTfw77l7nogjte2QEV7hol9BcaPYkuucRKLW0TBeknYLaaPnqNhy7Bf4cmrfT1n5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757351205; c=relaxed/simple;
	bh=JJg2F4dKkZ474YGYf/6mVgGNeAM7bxblYqH00xRjThI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttH7ejBKCYGAmzv4DgKsShaGiXP29ztzBIin98/843MRQ8ZOCBmbt0q6Yhv8aijdyHU6lsXWqqS2v4lYeqQ2KuC7rKpmKLmuTEnSt6dRdvTf7CZFV5WoRFo6ouNRuMqI83jYBfuJPc+li/7hUXEE4EMmWt9WFmrQukX5EzxC6+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HvhVXtQ/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757351202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uO4dtOB+K9su3ctwDU/FfSPhq7glTMVzAzGp80NdDh4=;
	b=HvhVXtQ/V/2IsDwtfKfpAPH2ek7mJydHQQUusSwLJc+rQqMsD9QfK/WfziuxvK+41NdNNj
	uKcoY99NSjiVV+CNz3TSHhWDsrb93VgLeSdVCa3/1LyOYWG8wBFZrSfd6HSt9rB9lc2ogV
	lCkKguKK3hikBPVBkKlDDyMeIyA5clw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-4YJmdseDMfujEAgV4gAtjw-1; Mon,
 08 Sep 2025 13:06:39 -0400
X-MC-Unique: 4YJmdseDMfujEAgV4gAtjw-1
X-Mimecast-MFC-AGG-ID: 4YJmdseDMfujEAgV4gAtjw_1757351197
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8E6F19560B0;
	Mon,  8 Sep 2025 17:06:36 +0000 (UTC)
Received: from localhost (unknown [10.22.64.69])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 794A0300018D;
	Mon,  8 Sep 2025 17:06:35 +0000 (UTC)
Date: Mon, 8 Sep 2025 14:06:33 -0300
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
Message-ID: <aL8NGXiYUAukMCGY@uudg.org>
References: <202509051010.e06823ab-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202509051010.e06823ab-lkp@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Sep 05, 2025 at 10:49:35AM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "INFO:task_blocked_for_more_than#seconds" on:
> 
> commit: 8671bad873ebeb082afcf7b4501395c374da6023 ("sched: Do not call __put_task_struct() on rt if pi_blocked_on is set")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on      linus/master 08b06c30a44555a8b1d14950e4462a52bfa0758b]
> [test failed on linux-next/master 5d50cf9f7cf20a17ac469c20a2e07c29c1f6aab7]
> 
> in testcase: rcutorture
> version: 
> with following parameters:
> 
> 	runtime: 300s
> 	test: cpuhotplug
> 	torture_type: tasks-rude

I ran tests with the boxes I had at hand, x86_64 and arm64, and was unable
to reproduce the problem. Tomorrow, when I am back from a holiday,, I will
try to reproduce the problem with x86 (32 bits) VMs and x86 baremetal as it
seems to be the case on the report.

In any case, I sent a follow-up patch that isolated those changes to
kernels with PREEMPT_RT enabled, as initially intended. That should solve
this case (if really caused by the commit in question). The patch I
mentioned is:

    [RESEND PATCH] sched: restore the behavior of put_task_struct() for non-rt
    https://lore.kernel.org/all/aKxqGLNOp2sWJwnZ@uudg.org/

Best regards,
Luis
 
> 
> 
> config: i386-randconfig-017-20250830
> compiler: gcc-12
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> the issue happens randomly and we observed various issues in tests by this
> commit, while parent keeps clean.
> 
> =========================================================================================
> tbox_group/testcase/rootfs/kconfig/compiler/runtime/test/torture_type:
>   vm-snb/rcutorture/debian-11.1-i386-20220923.cgz/i386-randconfig-017-20250830/gcc-12/300s/cpuhotplug/tasks-rude
> 
> 7de9d4f946383f48 8671bad873ebeb082afcf7b4501
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :200         16%          32:200   dmesg.BUG:kernel_hang_in_boot_stage
>            :200          0%           1:200   dmesg.BUG:soft_lockup-CPU##stuck_for#s![swapper:#]
>            :200          1%           2:200   dmesg.BUG:workqueue_lockup-pool
>            :200          0%           1:200   dmesg.EIP:kthread_affine_preferred
>            :200          0%           1:200   dmesg.EIP:lock_release
>            :200          0%           1:200   dmesg.EIP:tick_clock_notify
>            :200         12%          23:200   dmesg.INFO:task_blocked_for_more_than#seconds
>            :200         12%          23:200   dmesg.Kernel_panic-not_syncing:hung_task:blocked_tasks
>            :200          0%           1:200   dmesg.Kernel_panic-not_syncing:softlockup:hung_tasks
>            :200          0%           1:200   dmesg.WARNING:at_kernel/kthread.c:#kthread_affine_preferred
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202509051010.e06823ab-lkp@intel.com
> 
> 
> [  994.935251][   T26] INFO: task swapper/0:1 blocked for more than 491 seconds.
> [  994.947414][   T26]       Not tainted 6.16.0-rc6-00086-g8671bad873eb #1
> [  994.951523][   T26] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  994.960576][   T26] task:swapper/0       state:D stack:5016  pid:1     tgid:1     ppid:0      task_flags:0x0140 flags:0x00004000
> [  994.972581][   T26] Call Trace:
> [ 994.998429][ T26] __schedule (kernel/sched/core.c:5354 kernel/sched/core.c:6954) 
> [ 995.035758][ T26] schedule (kernel/sched/core.c:7037 kernel/sched/core.c:7051) 
> [ 995.044863][ T26] async_synchronize_cookie_domain (kernel/async.c:317 kernel/async.c:310) 
> [ 995.050698][ T26] ? do_wait_intr (kernel/sched/wait.c:384) 
> [ 995.059798][ T26] wait_for_initramfs (init/initramfs.c:778) 
> [ 995.067798][ T26] populate_rootfs (init/initramfs.c:789) 
> [ 995.070767][ T26] do_one_initcall (init/main.c:1274) 
> [ 995.074441][ T26] ? initramfs_async_setup (init/initramfs.c:782) 
> [ 995.098384][ T26] do_initcalls (init/main.c:1335 init/main.c:1352) 
> [ 995.136744][ T26] kernel_init_freeable (init/main.c:1588) 
> [ 995.136744][ T26] ? rest_init (init/main.c:1466) 
> [ 995.158663][ T26] kernel_init (init/main.c:1476) 
> [ 995.177750][ T26] ret_from_fork (arch/x86/kernel/process.c:154) 
> [ 995.178146][ T26] ? rest_init (init/main.c:1466) 
> [ 995.230129][ T26] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
> [ 995.230129][ T26] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
> [  995.268743][   T26]
> [  995.268743][   T26] Showing all locks held in the system:
> [  995.336987][   T26] 1 lock held by khungtaskd/26:
> [ 995.446697][ T26] #0: 830cce10 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks (kernel/locking/lockdep.c:6768 (discriminator 1)) 
> [  995.464546][   T26] 4 locks held by kworker/u4:2/29:
> [  995.470758][   T26] 2 locks held by kworker/0:3/38:
> [  995.498593][   T26]
> [  995.599251][   T26] =============================================
> [  995.599251][   T26]
> [  995.729940][   T26] Kernel panic - not syncing: hung_task: blocked tasks
> [  995.729940][   T26] CPU: 0 UID: 0 PID: 26 Comm: khungtaskd Not tainted 6.16.0-rc6-00086-g8671bad873eb #1 PREEMPT(full)
> [  995.729940][   T26] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [  995.729940][   T26] Call Trace:
> [ 995.729940][ T26] dump_stack_lvl (lib/dump_stack.c:124) 
> [ 995.729940][ T26] dump_stack (lib/dump_stack.c:130) 
> [ 995.729940][ T26] panic (kernel/panic.c:382) 
> [ 995.729940][ T26] check_hung_uninterruptible_tasks (kernel/hung_task.c:311) 
> [ 995.729940][ T26] watchdog (kernel/hung_task.c:470) 
> [ 995.729940][ T26] kthread (kernel/kthread.c:464) 
> [ 995.729940][ T26] ? check_hung_uninterruptible_tasks (kernel/hung_task.c:453) 
> [ 995.729940][ T26] ? kthread_complete_and_exit (kernel/kthread.c:413) 
> [ 995.729940][ T26] ret_from_fork (arch/x86/kernel/process.c:154) 
> [ 995.729940][ T26] ? kthread_complete_and_exit (kernel/kthread.c:413) 
> [ 995.729940][ T26] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
> [ 995.729940][ T26] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250905/202509051010.e06823ab-lkp@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
---end quoted text---



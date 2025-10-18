Return-Path: <linux-kernel+bounces-859452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C50E9BEDB1C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 21:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85CD64E25C1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C64A28688D;
	Sat, 18 Oct 2025 19:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PvS1b0V8"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176C11E51EA
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 19:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760817533; cv=none; b=ktWJObNU1M8ZoIwLKcfX5tTpLDTvmDi9LUk8bkDRGKiHp/t9iYJEkoPurdjlOK6wgXtQzObCmzU2TUeHaMaOGXxo4RriKDHcGl7mwtqA0n7QT7zt4fbc8Wgdc0h1R/Me/6nufaOkOH+XmN2eTQRWa/TcMMjcGiLvpjSh3kMjhdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760817533; c=relaxed/simple;
	bh=xVKfd1veqpJZpq8rjw+tfHez0zGUxzC0qPUQVJRQyVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUZJyVs89Z3KJiRosKrXDb9rxijjOf4JjKAxQB1h9zQ6o9tOLJ0upYU4u0FFqbVIjjSjG/mL8MWudKdr/wud667Y1qUmpVnlvW6b6UFyVRfGvLit9a0oI9GpV7Ta9eXxDonc6Xs0VGOikwmQqz1uAU3r0I2Bbydl1c5noIuKbcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PvS1b0V8; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2f8X4O+RUN/lM3mSmCBS9J9+Sn/0NyyGaY17wDnTykw=; b=PvS1b0V8Rv4mYHpukqhfbKe2+m
	Np27gaF9T3zWftN56Nf1DZ5bcEqP/aF4M0d1Qx3CNhkFM1mOvWfbJXMLoTfXjSpRoj4E5b3ZWdvLG
	1l3ShtnFZ4ByJLj/HQkY/HBYic3BgiaxvKcfwWQ3D5BE9nCPx9CDnPsHgF423bwaBhW7N2fELZsUF
	MA5kthfKX0jyWwpTKBHp8mLMfiu1x5Lfi+hvTINui0cOLPAFjFezKefvxwN7L90a2iUJpHbx2N8Ea
	JIxscLZN779SHc7ge7M4TCOD5cpqq1P9j3sjlxGSRvY6gxddSL0Bv8A8QBRhZRFOmQpaAl94enczd
	DABjJDvg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAD3U-00000008YsL-13BP;
	Sat, 18 Oct 2025 19:58:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C919530036B; Sat, 18 Oct 2025 21:57:30 +0200 (CEST)
Date: Sat, 18 Oct 2025 21:57:30 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Phil Auld <pauld@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Shizhao Chen <shichen@redhat.com>, linux-kernel@vger.kernel.org,
	Omar Sandoval <osandov@fb.com>, Xuewen Yan <xuewen.yan@unisoc.com>
Subject: Re: sched: update_entity_lag does not handle corner case with task
 in PI chain
Message-ID: <20251018195730.GJ3419281@noisy.programming.kicks-ass.net>
References: <aPN7XBJbGhdWJDb2@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPN7XBJbGhdWJDb2@uudg.org>

On Sat, Oct 18, 2025 at 08:34:52AM -0300, Luis Claudio R. Goncalves wrote:
> Hello!
> 

> While running sched_group_migration test from CKI repository[1], which

What's a CKI ?

> migrates tasks between cpusets, Shizhao Chen reports hitting the warning
> in update_entity_lag():
> 
>     WARN_ON_ONCE(!se->on_rq);
> 
> In short, update_entity_lag() is acting on a task that is waiting on a lock,
> sleeping, with both on_rq and se->on_rq equal to zero.

You can't get to where you are with p->on_rq being zero.

> When a stalled RCU grace period occurs, rcu_boost_kthread() is called. If an
> rt_mutex is involved in the process, rt_mutex_setprio() is called and may
> eventually walk down a Priority Inheritance chain, adjusting the priorities
> of the waiters in the chain. In such cases update_entity_lag() may be called.
> 
> What is the expected behavior for this case, to bail out of update_entity_lag()
> or avoid calling the function entirely?
> 
> 
> --[ Additional Notes:
> 
> Reproducing the Problem:
> 
>   - Install sched_group_migration[1] and run it on a loop.
>     (while : ;  do runtest.sh; done)
>   - In my experience, running the test with 4 CPUs reproduces the problem
>     within 15 minutes. Setting "nr_cpus=4 max_cpus=4" on boot does the trick.
> 
> 
> The scenario below is a simplification of the cases I observed while
> investigating the problem:
> 
>     CPUn					CPUx
> 
>     task01 has rcu-state lock
>     contends on another lock		
>     (goes to sleep)
>     --> on_rq=0 se.on_rq=0
> 					rcub/x contends on rcu-state lock
> 					  rcu_boost_kthread()
> 					    rt_set_prio()
> 					      update_entity_lag(task01->se)
> 					        WARNING()

There is a whole lot wrong with this, firstly there is no rt_set_prio()
function, and update_entity_lag() isn't directly called by it.
Additionally, you should never get to update_entity_lag() if !p->on_rq,
see below:

> [ 1805.450470] ------------[ cut here ]------------
> [ 1805.450474] WARNING: CPU: 2 PID: 19 at kernel/sched/fair.c:697 update_entity_lag+0x5b/0x70
> [ 1805.463366] Modules linked in: intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common skx_edac skx_edac_common nfit libnvdimm x86_pkg_temp_th
> ermal intel_powerclamp coretemp kvm_intel kvm platform_profile dell_wmi sparse_keymap rfkill irqbypass iTCO_wdt video mgag200 rapl iTCO_vendor_support dell_smbios ipmi_ssif in
> tel_cstate vfat dcdbas wmi_bmof intel_uncore dell_wmi_descriptor pcspkr fat i2c_algo_bit lpc_ich mei_me i2c_i801 i2c_smbus mei intel_pch_thermal ipmi_si acpi_power_meter acpi_
> ipmi ipmi_devintf ipmi_msghandler sg fuse loop xfs sd_mod i40e ghash_clmulni_intel libie libie_adminq ahci libahci tg3 libata wmi sunrpc dm_mirror dm_region_hash dm_log dm_mod
>  nfnetlink
> [ 1805.525160] CPU: 2 UID: 0 PID: 19 Comm: rcub/0 Kdump: loaded Not tainted 6.17.1-rt5 #1 PREEMPT_RT 
> [ 1805.534113] Hardware name: Dell Inc. PowerEdge R440/0WKGTH, BIOS 2.21.1 03/07/2024
> [ 1805.541678] RIP: 0010:update_entity_lag+0x5b/0x70
> [ 1805.546385] Code: 42 f8 48 81 3b 00 00 10 00 75 23 48 89 fa 48 f7 da 48 39 ea 48 0f 4c d5 48 39 fd 48 0f 4d d7 48 89 53 78 5b 5d c3 cc cc cc cc <0f> 0b eb b1 48 89 de e8 b9
>  8c ff ff 48 89 c7 eb d0 0f 1f 40 00 90
> [ 1805.565130] RSP: 0000:ffffcc9e802f7b90 EFLAGS: 00010046
> [ 1805.570358] RAX: 0000000000000000 RBX: ffff8959080c0080 RCX: 0000000000000000
> [ 1805.577488] RDX: 0000000000000000 RSI: ffff8959080c0080 RDI: ffff895592cc1c00
> [ 1805.584622] RBP: ffff895592cc1c00 R08: 0000000000008800 R09: 0000000000000000
> [ 1805.591756] R10: 0000000000000001 R11: 0000000000200b20 R12: 000000000000000e
> [ 1805.598886] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [ 1805.606020] FS:  0000000000000000(0000) GS:ffff895947da2000(0000) knlGS:0000000000000000
> [ 1805.614107] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1805.619853] CR2: 00007f655816ed40 CR3: 00000004ab854006 CR4: 00000000007726f0
> [ 1805.626985] PKRU: 55555554
> [ 1805.629696] Call Trace:
> [ 1805.632150]  <TASK>
> [ 1805.634258]  dequeue_entity+0x90/0x4f0
> [ 1805.638012]  dequeue_entities+0xc9/0x6b0
> [ 1805.641935]  dequeue_task_fair+0x8a/0x190
> [ 1805.645949]  ? sched_clock+0x10/0x30
> [ 1805.649527]  rt_mutex_setprio+0x318/0x4b0

So we have:

rt_mutex_setprio()

  rq = __task_rq_lock(p, ..); // this asserts p->pi_lock is held

  ...

  queued = task_on_rq_queued(rq); // basically reads p->on_rq
  running = task_current_donor()
  if (queued)
    dequeue_task(rq, p, queue_flags);
      dequeue_task_fair()
        dequeue_entities()
	  dequeue_entity()
	    update_entity_lag()
	      WARN_ON_ONCE(se->on_rq);

So the only way to get here is if: rq->on_rq is in fact !0 *and*
se->on_rq is zero.

And I'm not at all sure how one would get into such a state.




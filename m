Return-Path: <linux-kernel+bounces-860689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADBABF0B4E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 439A34F2756
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A3D2D9EEA;
	Mon, 20 Oct 2025 11:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HjsDBnDN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D61242910
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760958019; cv=none; b=kEq30zwX0v2ZBSZin9qOXq81OWiDO5wW+Ps4NVXEQI8Y2dgCFIf8fx2F1rJB9mx2lf93+p3JvK9Xi8kinJoCp55aD3yMox9FtFZAVDIcwW3ryuxvS2vGRyvFmQVqrYVHbcrqAvPebTup9loO6CuuCzicqNI2JI6I74nhU9gEUfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760958019; c=relaxed/simple;
	bh=kpUHEdBZvjoJIOR5sKFRSpTMR5xCgrG9uDsTK6cK26I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOIFfq7yMddbHcGAdKGoZSAaAe8LNXXqO/wdUh6JIZNdboreAml/z5NNcSHp9xXCskMFElqrTqK5kT6I+qeeLCQRke6qCz0yx9p7z66aLKdiBNThGlAExdzEvEIcm2y15s17x/bwnDqdLrx8cSlK2W+IUjlozk4vYEuJ1L/SHwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HjsDBnDN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760958015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z88Gx9BymTLPsBIsD4RUaH/1l0Vw9d/+nv1r7FFb0CQ=;
	b=HjsDBnDNyo9+kjRQit2ASzS2xssAcIHkZAYu+v/bp+Kw1lAQEZ2pQ1JKyH0Ne43mQ6QS5g
	U2/CP6uvcqKlQcJdRufWGnc0vVMzYEZg/l3ooX7FloRuVvlMHjSrSBuR8kvPILaAaGp/xX
	3iWmHW3PXDoO+M6pna9jELSGc0WnpmM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637--rELkR8iM2yxpWnTqV4Kuw-1; Mon,
 20 Oct 2025 07:00:12 -0400
X-MC-Unique: -rELkR8iM2yxpWnTqV4Kuw-1
X-Mimecast-MFC-AGG-ID: -rELkR8iM2yxpWnTqV4Kuw_1760958010
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 876171956058;
	Mon, 20 Oct 2025 11:00:10 +0000 (UTC)
Received: from localhost (unknown [10.22.88.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F3DC530001BC;
	Mon, 20 Oct 2025 11:00:08 +0000 (UTC)
Date: Mon, 20 Oct 2025 08:00:07 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <aPYWNxnVVLZ8AzXa@uudg.org>
References: <aPN7XBJbGhdWJDb2@uudg.org>
 <20251018195730.GJ3419281@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018195730.GJ3419281@noisy.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sat, Oct 18, 2025 at 09:57:30PM +0200, Peter Zijlstra wrote:
> On Sat, Oct 18, 2025 at 08:34:52AM -0300, Luis Claudio R. Goncalves wrote:
> > Hello!
> > 
> 
> > While running sched_group_migration test from CKI repository[1], which
> 
> What's a CKI ?

Continuous Kernel Integration (https://cki-project.org/). That's not
relevant to the problem, I just wanted to mention the source of the test in
case there were other tests with the same name or other versions in different
repositories.

> > migrates tasks between cpusets, Shizhao Chen reports hitting the warning
> > in update_entity_lag():
> > 
> >     WARN_ON_ONCE(!se->on_rq);
> > 
> > In short, update_entity_lag() is acting on a task that is waiting on a lock,
> > sleeping, with both on_rq and se->on_rq equal to zero.
> 
> You can't get to where you are with p->on_rq being zero.

I can check the other vmcores I have, but I am certain that I saw this in
at least two of the vmcores I analyzed:


   crash> task -R pi_blocked_on,prio,rt_priority,on_rq,se.on_rq 0xffff8955813c2180 0xffff895926cb4300
   PID: 19       TASK: ffff8955813c2180  CPU: 2    COMMAND: "rcub/0"
     pi_blocked_on = 0xffffcc9e802f7de0,       <------- held by the thread below
     prio = 98,
     rt_priority = 1,
     on_rq = 1,
     se.on_rq = 0 '\000',

   PID: 445515   TASK: ffff895926cb4300  CPU: 0    COMMAND: "bz1738415-test"
     pi_blocked_on = 0xffffcc9ea19f7b70,       <------- waiting on a lock
     prio = 98,
     rt_priority = 0,
     on_rq = 0,                                <------- 
     se.on_rq = 0 '\000',                      <-------


In the vmcores I collected the thread blocking rcub/X (holding the lock) is
blocked on another test thread, waiting on a different lock. As in some of
the vmcores this second lock has no owner, this looks like the lock had just
been released. The timing was perfect to hit this apparent corner case.

> > When a stalled RCU grace period occurs, rcu_boost_kthread() is called. If an
> > rt_mutex is involved in the process, rt_mutex_setprio() is called and may
> > eventually walk down a Priority Inheritance chain, adjusting the priorities
> > of the waiters in the chain. In such cases update_entity_lag() may be called.
> > 
> > What is the expected behavior for this case, to bail out of update_entity_lag()
> > or avoid calling the function entirely?
> > 
> > 
> > --[ Additional Notes:
> > 
> > Reproducing the Problem:
> > 
> >   - Install sched_group_migration[1] and run it on a loop.
> >     (while : ;  do runtest.sh; done)
> >   - In my experience, running the test with 4 CPUs reproduces the problem
> >     within 15 minutes. Setting "nr_cpus=4 max_cpus=4" on boot does the trick.
> > 
> > 
> > The scenario below is a simplification of the cases I observed while
> > investigating the problem:
> > 
> >     CPUn					CPUx
> > 
> >     task01 has rcu-state lock
> >     contends on another lock		
> >     (goes to sleep)
> >     --> on_rq=0 se.on_rq=0
> > 					rcub/x contends on rcu-state lock
> > 					  rcu_boost_kthread()
> > 					    rt_set_prio()
> > 					      update_entity_lag(task01->se)
> > 					        WARNING()
> 
> There is a whole lot wrong with this, firstly there is no rt_set_prio()
> function, and update_entity_lag() isn't directly called by it.
> Additionally, you should never get to update_entity_lag() if !p->on_rq,
> see below:

Sorry, I meant rt_mutex_setprio(). My mistake. And yes, I oversimplified
the note. The idea is that rt_mutex_setprio() could eventually result in
a call to update_entity_lag() down the chain.

> > [ 1805.450470] ------------[ cut here ]------------
> > [ 1805.450474] WARNING: CPU: 2 PID: 19 at kernel/sched/fair.c:697 update_entity_lag+0x5b/0x70
> > [ 1805.463366] Modules linked in: intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common skx_edac skx_edac_common nfit libnvdimm x86_pkg_temp_th
> > ermal intel_powerclamp coretemp kvm_intel kvm platform_profile dell_wmi sparse_keymap rfkill irqbypass iTCO_wdt video mgag200 rapl iTCO_vendor_support dell_smbios ipmi_ssif in
> > tel_cstate vfat dcdbas wmi_bmof intel_uncore dell_wmi_descriptor pcspkr fat i2c_algo_bit lpc_ich mei_me i2c_i801 i2c_smbus mei intel_pch_thermal ipmi_si acpi_power_meter acpi_
> > ipmi ipmi_devintf ipmi_msghandler sg fuse loop xfs sd_mod i40e ghash_clmulni_intel libie libie_adminq ahci libahci tg3 libata wmi sunrpc dm_mirror dm_region_hash dm_log dm_mod
> >  nfnetlink
> > [ 1805.525160] CPU: 2 UID: 0 PID: 19 Comm: rcub/0 Kdump: loaded Not tainted 6.17.1-rt5 #1 PREEMPT_RT 
> > [ 1805.534113] Hardware name: Dell Inc. PowerEdge R440/0WKGTH, BIOS 2.21.1 03/07/2024
> > [ 1805.541678] RIP: 0010:update_entity_lag+0x5b/0x70
> > [ 1805.546385] Code: 42 f8 48 81 3b 00 00 10 00 75 23 48 89 fa 48 f7 da 48 39 ea 48 0f 4c d5 48 39 fd 48 0f 4d d7 48 89 53 78 5b 5d c3 cc cc cc cc <0f> 0b eb b1 48 89 de e8 b9
> >  8c ff ff 48 89 c7 eb d0 0f 1f 40 00 90
> > [ 1805.565130] RSP: 0000:ffffcc9e802f7b90 EFLAGS: 00010046
> > [ 1805.570358] RAX: 0000000000000000 RBX: ffff8959080c0080 RCX: 0000000000000000
> > [ 1805.577488] RDX: 0000000000000000 RSI: ffff8959080c0080 RDI: ffff895592cc1c00
> > [ 1805.584622] RBP: ffff895592cc1c00 R08: 0000000000008800 R09: 0000000000000000
> > [ 1805.591756] R10: 0000000000000001 R11: 0000000000200b20 R12: 000000000000000e
> > [ 1805.598886] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > [ 1805.606020] FS:  0000000000000000(0000) GS:ffff895947da2000(0000) knlGS:0000000000000000
> > [ 1805.614107] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 1805.619853] CR2: 00007f655816ed40 CR3: 00000004ab854006 CR4: 00000000007726f0
> > [ 1805.626985] PKRU: 55555554
> > [ 1805.629696] Call Trace:
> > [ 1805.632150]  <TASK>
> > [ 1805.634258]  dequeue_entity+0x90/0x4f0
> > [ 1805.638012]  dequeue_entities+0xc9/0x6b0
> > [ 1805.641935]  dequeue_task_fair+0x8a/0x190
> > [ 1805.645949]  ? sched_clock+0x10/0x30
> > [ 1805.649527]  rt_mutex_setprio+0x318/0x4b0
> 
> So we have:
> 
> rt_mutex_setprio()
> 
>   rq = __task_rq_lock(p, ..); // this asserts p->pi_lock is held
> 
>   ...
> 
>   queued = task_on_rq_queued(rq); // basically reads p->on_rq
>   running = task_current_donor()
>   if (queued)
>     dequeue_task(rq, p, queue_flags);
>       dequeue_task_fair()
>         dequeue_entities()
> 	  dequeue_entity()
> 	    update_entity_lag()
> 	      WARN_ON_ONCE(se->on_rq);
> 
> So the only way to get here is if: rq->on_rq is in fact !0 *and*
> se->on_rq is zero.

Assuming the vmcores I collected are not damaged and that the simple crash
command I used earlier to display the thread on_rq and se->on_rq fields is
correct, is there a chance that the sequence above could be tampered by
the thread being concurrently moved from one cpuset to another?

> And I'm not at all sure how one would get into such a state.

Sorry again for the convoluted report, but I am also trying to make sense
of the results observed. Is there anything I could do in terms of tests or
information that could help shed a light here?

Best,
Luis



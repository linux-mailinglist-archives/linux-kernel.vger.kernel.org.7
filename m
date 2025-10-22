Return-Path: <linux-kernel+bounces-863905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C769BF97BD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 02:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458663B3407
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 00:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1203819E82A;
	Wed, 22 Oct 2025 00:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/1W2KCV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3611A267
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761093368; cv=none; b=sgnOWJJ3f08DxInl/l3RN1wezjihwIx8YNnH4fWCPwi1pX7QwAqJxC25NvkDPRs3oEdb8Pvtrh0+V65uX6/xiE2bNe3y8TtG9G3uEw9mOrAnSDK2SqlwUufuzB+iEDtr3E0S8rxWoDWdScFCwR25Yn+SMGNmSb1wtB4fGCf/NSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761093368; c=relaxed/simple;
	bh=qGdg2hTNbv4eDVYuRLmW61WEm0UkZVbz2VN1w7WAcds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thoZHL0dRuvU3l8pzlB2QwlWVQpB6D/KcNW7+diGvHDnnoMSN6Q1VQn5FUemHx8PN0jKXtyly0VqCS1g6yduZES8MIS9M3C8YbTQyTLAPa/pnkEauoRSe2hFaMnQx9Yjm5aRi+l3KfPDMTGLLgNuJRmZ9MiO86YpRP+ZASheoXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F/1W2KCV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761093362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8rddT85Vybs6AukEERIZlyr/IwXipynLaLs4KMySCzo=;
	b=F/1W2KCVFIwbMPs/o0lGFyNQ5/9mtXiPTWO8HwaGc6iUyI/jvGQIDl/3Arz8m3dw9UtYJY
	IeKHc78d0E5m3M+l22ppMb1QdAbH2vWBZrGqh6Q+Au5FvAPjMfjPR57rvX+uS0LGTofowT
	WrAAMEYBPpfUAjR250QLffKMRLMZUN8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-2AB8zcQnNNe7vIm2ZWtnzA-1; Tue,
 21 Oct 2025 20:35:59 -0400
X-MC-Unique: 2AB8zcQnNNe7vIm2ZWtnzA-1
X-Mimecast-MFC-AGG-ID: 2AB8zcQnNNe7vIm2ZWtnzA_1761093357
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 001781800345;
	Wed, 22 Oct 2025 00:35:56 +0000 (UTC)
Received: from localhost (unknown [10.22.88.12])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B4CC319541B2;
	Wed, 22 Oct 2025 00:35:53 +0000 (UTC)
Date: Tue, 21 Oct 2025 21:35:52 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>, Phil Auld <pauld@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Shizhao Chen <shichen@redhat.com>, linux-kernel@vger.kernel.org,
	Omar Sandoval <osandov@fb.com>, Xuewen Yan <xuewen.yan@unisoc.com>
Subject: Re: sched: update_entity_lag does not handle corner case with task
 in PI chain
Message-ID: <aPgm6KvDx5Os2oJS@uudg.org>
References: <aPN7XBJbGhdWJDb2@uudg.org>
 <20251018195730.GJ3419281@noisy.programming.kicks-ass.net>
 <c10f6fda-aa8c-4d8e-a315-3c084af08862@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c10f6fda-aa8c-4d8e-a315-3c084af08862@amd.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Oct 21, 2025 at 12:38:17PM +0530, K Prateek Nayak wrote:
> Hello Peter, Luis,
> 
> On 10/19/2025 1:27 AM, Peter Zijlstra wrote:
> >> [ 1805.450470] ------------[ cut here ]------------
> >> [ 1805.450474] WARNING: CPU: 2 PID: 19 at kernel/sched/fair.c:697 update_entity_lag+0x5b/0x70
> >> [ 1805.463366] Modules linked in: intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common skx_edac skx_edac_common nfit libnvdimm x86_pkg_temp_th
> >> ermal intel_powerclamp coretemp kvm_intel kvm platform_profile dell_wmi sparse_keymap rfkill irqbypass iTCO_wdt video mgag200 rapl iTCO_vendor_support dell_smbios ipmi_ssif in
> >> tel_cstate vfat dcdbas wmi_bmof intel_uncore dell_wmi_descriptor pcspkr fat i2c_algo_bit lpc_ich mei_me i2c_i801 i2c_smbus mei intel_pch_thermal ipmi_si acpi_power_meter acpi_
> >> ipmi ipmi_devintf ipmi_msghandler sg fuse loop xfs sd_mod i40e ghash_clmulni_intel libie libie_adminq ahci libahci tg3 libata wmi sunrpc dm_mirror dm_region_hash dm_log dm_mod
> >>  nfnetlink
> >> [ 1805.525160] CPU: 2 UID: 0 PID: 19 Comm: rcub/0 Kdump: loaded Not tainted 6.17.1-rt5 #1 PREEMPT_RT 
> >> [ 1805.534113] Hardware name: Dell Inc. PowerEdge R440/0WKGTH, BIOS 2.21.1 03/07/2024
> >> [ 1805.541678] RIP: 0010:update_entity_lag+0x5b/0x70
> >> [ 1805.546385] Code: 42 f8 48 81 3b 00 00 10 00 75 23 48 89 fa 48 f7 da 48 39 ea 48 0f 4c d5 48 39 fd 48 0f 4d d7 48 89 53 78 5b 5d c3 cc cc cc cc <0f> 0b eb b1 48 89 de e8 b9
> >>  8c ff ff 48 89 c7 eb d0 0f 1f 40 00 90
> >> [ 1805.565130] RSP: 0000:ffffcc9e802f7b90 EFLAGS: 00010046
> >> [ 1805.570358] RAX: 0000000000000000 RBX: ffff8959080c0080 RCX: 0000000000000000
> >> [ 1805.577488] RDX: 0000000000000000 RSI: ffff8959080c0080 RDI: ffff895592cc1c00
> >> [ 1805.584622] RBP: ffff895592cc1c00 R08: 0000000000008800 R09: 0000000000000000
> >> [ 1805.591756] R10: 0000000000000001 R11: 0000000000200b20 R12: 000000000000000e
> >> [ 1805.598886] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> >> [ 1805.606020] FS:  0000000000000000(0000) GS:ffff895947da2000(0000) knlGS:0000000000000000
> >> [ 1805.614107] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> [ 1805.619853] CR2: 00007f655816ed40 CR3: 00000004ab854006 CR4: 00000000007726f0
> >> [ 1805.626985] PKRU: 55555554
> >> [ 1805.629696] Call Trace:
> >> [ 1805.632150]  <TASK>
> >> [ 1805.634258]  dequeue_entity+0x90/0x4f0
> >> [ 1805.638012]  dequeue_entities+0xc9/0x6b0
> >> [ 1805.641935]  dequeue_task_fair+0x8a/0x190
> >> [ 1805.645949]  ? sched_clock+0x10/0x30
> >> [ 1805.649527]  rt_mutex_setprio+0x318/0x4b0
> > 
> > So we have:
> > 
> > rt_mutex_setprio()
> > 
> >   rq = __task_rq_lock(p, ..); // this asserts p->pi_lock is held
> > 
> >   ...
> > 
> >   queued = task_on_rq_queued(rq); // basically reads p->on_rq
> >   running = task_current_donor()
> >   if (queued)
> >     dequeue_task(rq, p, queue_flags);
> >       dequeue_task_fair()
> >         dequeue_entities()
> > 	  dequeue_entity()
> > 	    update_entity_lag()
> > 	      WARN_ON_ONCE(se->on_rq);
> > 
> > So the only way to get here is if: rq->on_rq is in fact !0 *and*
> > se->on_rq is zero.
> > 
> > And I'm not at all sure how one would get into such a state.
> 
> This looks like something that can happen when a delayed task is
> dequeued from a throttled hierarchy. Matt had reported similar
> problem with wait_task_inactive() in
> https://lore.kernel.org/all/20250925133310.1843863-1-matt@readmodwrite.com/
> 
> rt_mutex_setprio()
>   ...
>   if (prev_class != next_class && p->se.sched_delayed)
>     dequeue_task(rq, p, DEQUEUE_DELAYED)
>       dequeue_entities(se = &p->se)
>         dequeue_entity(se)
>           se->on_rq = 0; /* se->on_rq turns 0 here */
>         ...
>         if (cfs_rq_throttled(cfs_rq))
>           return 0; /* Early return brfore __block_task() */
>   ...
> 
>   /* __block_task() not called; task_on_rq_queued() returns true. */
>   queued = task_on_rq_queued(p);
>   ...
> 
>   if (queued)
>     dequeue_task(rq, p, queue_flag)
>       dequeue_entities(se = &p->se)
>         dequeue_entity(se)
>           update_entity_lag(se)
>             WARN_ON_ONCE(!se->on_rq)
> 
> 
> v6.18 kernels will get rid of this issue as a part of per-task throttle
> feature and stable should pick up the fix for same on the thread soon. 

Thank you! You were right, your patch in that thread seems to have fixed
the issue I reported.

I read the thread you mentioned, built a test kernel with the patch and have
been running tests for more than 6h now without a single backtrace. As reported
earlier, I was able to hit the bug within 15 minutes without the patch.

Best regards,
Luis

> 
> -- 
> Thanks and Regards,
> Prateek
> 
---end quoted text---



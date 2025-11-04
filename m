Return-Path: <linux-kernel+bounces-884037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A03FC2F2C3
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 04:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35D4C4E4357
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 03:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AC928EA56;
	Tue,  4 Nov 2025 03:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IIpcdKJW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39E2284B2F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 03:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762227281; cv=none; b=El7gMmrPfe6dXSqQCp3UJVWJy5G3b0RBqE8a0OCbEaiw05vWwv8Bk2WK4zmPCwl7L/AI+hJuOGDgRhVgj7c9zvg6QQOxVmNEr1wTlC8qoh9qmEcEm/YCHF18PnZtom17uPGAffyBNTwp5FKYIkw3tOkCYuAb1wEMWOrepmrygBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762227281; c=relaxed/simple;
	bh=p2z9f1xP/GXQS/3DqI7XwLENf2PKPkUL/8Xk8aa+4tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xw0M8LceRwX85zIOkxMDBfmO0M/fGb8rOQm2shR/vzY0wv+FaQ6blvf51aM9tCfNw2yuHc8/WwgIOv0aXLjQeM9O6KoCxy3HGup3HgSkfiIRMstJglWKnSlnmJh4jX7e+oMgqHzkkdM0lCMwZHKVTcme/o4gg0BXPjKwT7/jGGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IIpcdKJW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762227277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UcG7b9I0JBUcKATIvCgBPM48eafhReejQQ3oHIGYGOs=;
	b=IIpcdKJWXQ2yDEPrH2AAybkvIc4f1ftS88vim544oSHPK6ZvQS0HmaimnmzoyzsQS8tBJs
	zKvGcOh0HUvCiUuv1y6SQyAf3M+76gOhBAyMm+MnXwIoRDhvaMmpn50lffThiVxjRVbugd
	B81Mnu1B62Rz7csI4+xv//uE2SspjPI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-VlNrvbVAN3qwF90Tjw_gjQ-1; Mon,
 03 Nov 2025 22:34:35 -0500
X-MC-Unique: VlNrvbVAN3qwF90Tjw_gjQ-1
X-Mimecast-MFC-AGG-ID: VlNrvbVAN3qwF90Tjw_gjQ_1762227270
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC639180120B;
	Tue,  4 Nov 2025 03:34:28 +0000 (UTC)
Received: from localhost (unknown [10.72.112.97])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 317E919560A2;
	Tue,  4 Nov 2025 03:34:25 +0000 (UTC)
Date: Tue, 4 Nov 2025 11:34:23 +0800
From: Pingfan Liu <piliu@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Waiman Long <llong@redhat.com>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCHv4 2/2] sched/deadline: Walk up cpuset hierarchy to decide
 root domain when hot-unplug
Message-ID: <aQl0P90Q7X7fG5q-@fedora>
References: <20251028034357.11055-1-piliu@redhat.com>
 <20251028034357.11055-2-piliu@redhat.com>
 <52252077-30cb-4a71-ba2a-1c4ecb36df37@redhat.com>
 <aQizF0hBnM_f1nQg@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQizF0hBnM_f1nQg@jlelli-thinkpadt14gen4.remote.csb>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Nov 03, 2025 at 02:50:15PM +0100, Juri Lelli wrote:
> On 29/10/25 11:31, Waiman Long wrote:
> > On 10/27/25 11:43 PM, Pingfan Liu wrote:
> 
> ...
> 
> > > @@ -2891,16 +2893,32 @@ void dl_add_task_root_domain(struct task_struct *p)
> > >   		return;
> > >   	}
> > > -	rq = __task_rq_lock(p, &rf);
> > > -
> > > +	/* prevent race among cpu hotplug, changing of partition_root_state */
> > > +	lockdep_assert_cpus_held();
> > > +	/*
> > > +	 * If @p is in blocked state, task_cpu() may be not active. In that
> > > +	 * case, rq->rd does not trace a correct root_domain. On the other hand,
> > > +	 * @p must belong to an root_domain at any given time, which must have
> > > +	 * active rq, whose rq->rd traces the valid root domain.
> > > +	 */
> > > +	cpuset_get_task_effective_cpus(p, &msk);
> > > +	cpu = cpumask_first_and(cpu_active_mask, &msk);
> > > +	/*
> > > +	 * If a root domain reserves bandwidth for a DL task, the DL bandwidth
> > > +	 * check prevents CPU hot removal from deactivating all CPUs in that
> > > +	 * domain.
> > > +	 */
> > > +	BUG_ON(cpu >= nr_cpu_ids);
> > > +	rq = cpu_rq(cpu);
> > > +	/*
> > > +	 * This point is under the protection of cpu_hotplug_lock. Hence
> > > +	 * rq->rd is stable.
> > > +	 */
> > 
> > So you trying to find a active sched domain with some dl bw to use for
> > checking. I don't know enough about this dl bw checking code to know if it
> > is valid or not. I will let Juri comment on that.
> 
> So, just to refresh my understanding of this issue, the task was
> sleeping/blocked while the cpu it was running on before blocking has
> been turned off. dl_add_task_root_domain() wrongly adds its bw
> contribution to def_root_domain as it's where offline cpus are attached
> to while off. We instead want to attach the sleeping task contribution
> to the root domain that once comprised also the cpu it was running on
> before blocking. Correct?
> 

Yes, that's correct.

> If that is the case, and assuming nobody touched the sleeping task
> affinity (p->cpus_ptr), can't we just use another online cpu from

In fact, IIUC, the change will be always propagated through the cpuset
hier into cpus_ptr by cpuset_update_tasks_cpumask() in cpuset v2.
(Ridong, please correct me if my understanding is wrong)

But for cpuset v1, due to async, it is not reliable at this point [1].

> current task affinity to get to the right root domain? Somewhat similar
> to what dl_task_offline_migration() is doing in the (!later_rq) case,
> I'm thinking.
> 

Sorry, I don't quite understand what you mean. Do you mean something
like cpumask_any_and(cpu_active_mask, p->cpus_ptr) in
dl_task_offline_migration()?

If so, that will run into the async challenge discussed in [1], where
p->cpus_ptr becomes stale with no active CPUs. However, in fact, there
are still active CPUs in the root domain.


So my plan is to follow Waiman's suggestion. Any further comments or
suggestion?

[1]: https://lore.kernel.org/all/aQge00u94JKGF9Tb@fedora/


Best Regards,

Pingfan



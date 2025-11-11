Return-Path: <linux-kernel+bounces-895321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1D1C4D832
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9FEA4FC59F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D020A359703;
	Tue, 11 Nov 2025 11:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Esh1xndh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FAE359701
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861244; cv=none; b=hmXK15Wk+EXxSTmF4rZIiF/dkpvM11uiNJiqqdw9RUldY7uzhIvbL7dSqafyHvJ791vL2/OBNYv3iFyeQNshTm4WD8r5YFaHZJ+E4rSz1yZL6klCYD6ZNw06w5FtiG82JQdE6CfejZzwlotMySMtkUgmzHOcmTikKwaajjdmBn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861244; c=relaxed/simple;
	bh=3s82MD6md8lIZ4jP7QmLgx9ib2Ee6ZW1Vem42sRQwTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsxs6OYLfnhCRmwuGELcdaq3c2L7L5Ya4sKBv5URtfJfa1JH+PcR4VHzFKbaUUNVd+UNRDpEEnpUrNN/fJUuh2Vyg9kwZTLcPr4h7tfjJUmR/3LiWLQ3SgjUsrAAG55wfH8oPhbIzxPEukE66GvgTVjFsItMatyzCy1xQx4it6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Esh1xndh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762861241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=COiLb7RNZ04NFBfQ8iT/p1YoCtMA6keD7KkqHWMXjZI=;
	b=Esh1xndh9kukS/V/2COBHIMUIa5Iajsp7ijHlqSL0BfNsQtjYp1ANtILj+hHvo6ZMJ0XpF
	z6CA7D2DwU4EsAM+m66mIx76a/u3JP82HsG2rIa/g9DtfonNVAk9v7pk7xhZ8OcrFC9yrq
	If4+pGW/8DNSLNgMnjkE7fo65Qy8kGI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-oqAjKWKEM1eU3fRI3TXULg-1; Tue,
 11 Nov 2025 06:40:37 -0500
X-MC-Unique: oqAjKWKEM1eU3fRI3TXULg-1
X-Mimecast-MFC-AGG-ID: oqAjKWKEM1eU3fRI3TXULg_1762861236
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3997D180048E;
	Tue, 11 Nov 2025 11:40:35 +0000 (UTC)
Received: from localhost (unknown [10.72.112.8])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A44341800378;
	Tue, 11 Nov 2025 11:40:32 +0000 (UTC)
Date: Tue, 11 Nov 2025 19:40:29 +0800
From: Pingfan Liu <piliu@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCHv5] sched/deadline: Walk up cpuset hierarchy to decide
 root domain when hot-unplug
Message-ID: <aRMgrQRqpwvBSPC6@fedora>
References: <20251110014706.8118-1-piliu@redhat.com>
 <aRHJHxfEI-tnotRe@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRHJHxfEI-tnotRe@jlelli-thinkpadt14gen4.remote.csb>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi Juri,

Thanks for your review. Please see the comments below.

On Mon, Nov 10, 2025 at 12:14:39PM +0100, Juri Lelli wrote:
> Hi,
> 
> Looks like this has two issues.
> 
> On 10/11/25 09:47, Pingfan Liu wrote:
> 
> ...
> 
> > +/*
> > + * This function always returns a non-empty bitmap in @cpus. This is because
> > + * if a root domain has reserved bandwidth for DL tasks, the DL bandwidth
> > + * check will prevent CPU hotplug from deactivating all CPUs in that domain.
> > + */
> > +static void dl_get_task_effective_cpus(struct task_struct *p, struct cpumask *cpus)
> > +{
> > +	const struct cpumask *hk_msk;
> > +
> > +	hk_msk = housekeeping_cpumask(HK_TYPE_DOMAIN);
> > +	if (housekeeping_enabled(HK_TYPE_DOMAIN)) {
> > +		if (!cpumask_intersects(p->cpus_ptr, hk_msk)) {
> > +			/*
> > +			 * CPUs isolated by isolcpu="domain" always belong to
> > +			 * def_root_domain.
> > +			 */
> > +			cpumask_andnot(cpus, cpu_active_mask, hk_msk);
> > +			return;
> > +		}
> > +	}
> > +
> > +	/*
> > +	 * If a root domain holds a DL task, it must have active CPUs. So
> > +	 * active CPUs can always be found by walking up the task's cpuset
> > +	 * hierarchy up to the partition root.
> > +	 */
> > +	cpuset_cpus_allowed(p, cpus);
> 
> Grabs callbak_lock spin_lock (sleepable on RT) under pi_lock
> raw_spin_lock.
> 

Yes, it should be fixed. I'll discuss it in my reply to Waiman's email later.

> > +}
> > +
> > +/* The caller should hold cpuset_mutex */
> >  void dl_add_task_root_domain(struct task_struct *p)
> >  {
> >  	struct rq_flags rf;
> >  	struct rq *rq;
> >  	struct dl_bw *dl_b;
> > +	unsigned int cpu;
> > +	struct cpumask msk;
> 
> Potentially huge mask allocated on the stack.
> 

Since there's no way to handle memory allocation failures, could it be
done by using alloc_cpumask_var() in init_sched_dl_class() to reserve
the memory for this purpose?

Best Regards,

Pingfan
> >  	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
> >  	if (!dl_task(p) || dl_entity_is_special(&p->dl)) {
> > @@ -2891,16 +2923,22 @@ void dl_add_task_root_domain(struct task_struct *p)
> >  		return;
> >  	}
> >  
> > -	rq = __task_rq_lock(p, &rf);
> > -
> > +	/*
> > +	 * Get an active rq, whose rq->rd traces the correct root
> > +	 * domain.
> > +	 * And the caller should hold cpuset_mutex, which gurantees
> > +	 * the cpu remaining in the cpuset until rq->rd is fetched.
> > +	 */
> > +	dl_get_task_effective_cpus(p, &msk);
> > +	cpu = cpumask_first_and(cpu_active_mask, &msk);
> > +	BUG_ON(cpu >= nr_cpu_ids);
> > +	rq = cpu_rq(cpu);
> >  	dl_b = &rq->rd->dl_bw;
> > -	raw_spin_lock(&dl_b->lock);
> >  
> > +	raw_spin_lock(&dl_b->lock);
> >  	__dl_add(dl_b, p->dl.dl_bw, cpumask_weight(rq->rd->span));
> > -
> >  	raw_spin_unlock(&dl_b->lock);
> > -
> > -	task_rq_unlock(rq, p, &rf);
> > +	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
> 
> Thanks,
> Juri
> 



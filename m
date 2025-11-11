Return-Path: <linux-kernel+bounces-895337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AD6C4D87A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA3F1886D1E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA62338929;
	Tue, 11 Nov 2025 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTuZV3g4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E811D2F7479
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861825; cv=none; b=I+5wynOaQuOAxwqAshCByd3/xYJaTt/P1MugYHCMrNJrAv2FWie+Kk2hqElnPhl7bSkmbv1WH7Mpolud0bwBKV+pe5bBvGHAOhZc/KF1f9+oK34+JmvRx1uuIUm/M5PrcgIv481EZ5KnD9kxjX7JtEVyZdFgKfMCUY+Tcl8skjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861825; c=relaxed/simple;
	bh=yUg6mLveKkgsbvHwSLdk5zJc2NwHslq99MOoswr7hu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNmDW+os9KKk+wyIR9xY5RBDoDytLOgNn5bGRRqnHlYE6f7xdbw2vvnA62+sdQYp2PxKbPDONIFgem6HXpLKwFi9P2t37uwlN13u0f7Rzw08Ancz4+mZcn0Q+pdTYR3ntqLElmIupapkD1qn2TLcStjekEG0Bi8MwRFJmc992UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KTuZV3g4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762861823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=af/vdsbkNHKyZ9Q3FelUrd/CXKaaHhNvaFzhXhpSVus=;
	b=KTuZV3g4hXCgr1aGE1YYFX2srv+H8xu5RE2Lqy1CCVZeCI42wr0xvmmR4+BJh8MZa5hsig
	mDMUV/rNUrZ+8Q7B9e5TtSmTof0oKkNV0nPk36TXmUKiD93ieFt6QVHGRXLYrXUaHOkVmU
	qZQfvI2/auXy3B5LPXjePXKVKQYL/yA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-k5iC15sRNZinPTy4TGhDHQ-1; Tue,
 11 Nov 2025 06:50:21 -0500
X-MC-Unique: k5iC15sRNZinPTy4TGhDHQ-1
X-Mimecast-MFC-AGG-ID: k5iC15sRNZinPTy4TGhDHQ_1762861820
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53980180123A;
	Tue, 11 Nov 2025 11:50:19 +0000 (UTC)
Received: from localhost (unknown [10.72.112.8])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D70D219560A2;
	Tue, 11 Nov 2025 11:50:17 +0000 (UTC)
Date: Tue, 11 Nov 2025 19:50:05 +0800
From: Pingfan Liu <piliu@redhat.com>
To: Waiman Long <llong@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
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
Message-ID: <aRMi7R3_7U0MyUZB@fedora>
References: <20251110014706.8118-1-piliu@redhat.com>
 <aRHJHxfEI-tnotRe@jlelli-thinkpadt14gen4.remote.csb>
 <5e0bb3f1-2efc-4302-aff0-80d5999c7700@redhat.com>
 <d42cd14d-46da-41b4-b580-f112baf0dfdb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d42cd14d-46da-41b4-b580-f112baf0dfdb@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Nov 10, 2025 at 05:08:56PM -0500, Waiman Long wrote:
> On 11/10/25 4:07 PM, Waiman Long wrote:
> > On 11/10/25 6:14 AM, Juri Lelli wrote:
> > > Hi,
> > > 
> > > Looks like this has two issues.
> > > 
> > > On 10/11/25 09:47, Pingfan Liu wrote:
> > > 
> > > ...
> > > 
> > > > +/*
> > > > + * This function always returns a non-empty bitmap in @cpus.
> > > > This is because
> > > > + * if a root domain has reserved bandwidth for DL tasks, the DL
> > > > bandwidth
> > > > + * check will prevent CPU hotplug from deactivating all CPUs in
> > > > that domain.
> > > > + */
> > > > +static void dl_get_task_effective_cpus(struct task_struct *p,
> > > > struct cpumask *cpus)
> > > > +{
> > > > +    const struct cpumask *hk_msk;
> > > > +
> > > > +    hk_msk = housekeeping_cpumask(HK_TYPE_DOMAIN);
> > > > +    if (housekeeping_enabled(HK_TYPE_DOMAIN)) {
> > > > +        if (!cpumask_intersects(p->cpus_ptr, hk_msk)) {
> > > > +            /*
> > > > +             * CPUs isolated by isolcpu="domain" always belong to
> > > > +             * def_root_domain.
> > > > +             */
> > > > +            cpumask_andnot(cpus, cpu_active_mask, hk_msk);
> > > > +            return;
> > > > +        }
> > > > +    }
> > > > +
> > > > +    /*
> > > > +     * If a root domain holds a DL task, it must have active CPUs. So
> > > > +     * active CPUs can always be found by walking up the task's cpuset
> > > > +     * hierarchy up to the partition root.
> > > > +     */
> > > > +    cpuset_cpus_allowed(p, cpus);
> > > Grabs callbak_lock spin_lock (sleepable on RT) under pi_lock
> > > raw_spin_lock.
> > I have been thinking about changing callback_lock to a raw_spinlock_t,
> > but need to find a good use case for this change. So it is a solvable
> > problem.
> 

Thank you very much for your accommodation.

> Actually, we don't need to acquire the callback_lock if cpuset_mutex is
> held. So another possibility is to create a cpuset_cpus_allowed() variant
> that doesn't acquire the callback_mutex but assert that cpuset_mutex is
> held.
> 

The real requirement is a reader protection section starting from
dl_get_task_effective_cpus() to dl_b = &rq->rd->dl_bw;
But there is no handy lock which can spread across
cpuset_cpus_allowed(), I choose the write-lock "cpuset_mutex".

It would be perfect if cpuset_cpus_allowed() had a
cpuset_cpus_allowed_nolock() variant, and if callback_lock could be
changed to a raw_spinlock_t.

But if this is too trivial, I could move dl_get_task_effective_cpus()
outside the pi_lock and re-check task_cs(task) as an alternative.


Best Regards,

Pingfan



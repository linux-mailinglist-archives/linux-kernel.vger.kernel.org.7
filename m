Return-Path: <linux-kernel+bounces-854431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7961EBDE58B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0437A3A52C9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC1B324B1F;
	Wed, 15 Oct 2025 11:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XVdMYIC1"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3779C3233ED
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760529319; cv=none; b=a8fOTGX5OmrhswaczUP2jjXRhHuO/PHdotE87rt3lMDTqxlEEfaj2tm8clohKtRWCRyq3uGps60BP3zg70vSuBAQQ4YYZvIAxEPkDvHix/jTzeaqb9LEc3+S9daL+WUgOwzFvkDyyV1dPqYQL/oBxZi56sU37L9N1L9sK487/dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760529319; c=relaxed/simple;
	bh=RW3IU+/IPwx3hCoTIal0ym8LMTKKDSaaYoxANH79LL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jL1GXNbziomxJ9Eiws5/1QHGoW2fPmUCxrK4L8ABswUN5jZYsg7wML7j13k6xvjKEu5YpX65CWYpDxmlsxWCfXZ7H/C1uo4f5K9k3yx8w/uvKgKtP0ZJmUjiRxTYvh+ywmPTHkda3hGoViLg2xVxqdYrVsHZDGjauwsUVCjvJ9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XVdMYIC1; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lhZ21Nfwnbx0+2MBt6R1KkdR0PbJfqLC0g0CCa6o1HU=; b=XVdMYIC1awXTStDmyaGhboTUzn
	nYilDEpZo+k6m1mwlVDHksjn1UObgGMZD3oI4GAjwyoSD3hPuTho5lkUhLfXL6HbGwheCh5Dgt8hn
	DcV9O2nUz++Gg13qqDayeK9zeQnWeaoGdTP2Kj+4yj+P0bhxuFX/LbfZzcwbjVt4/UHhaYG/CvZkA
	YdHPnl60QuqfnHcTm5ZoGFStH5yEYCpLLZvFIVSKL/ngZLjzGKqzNghnEt7FWvNSVBKYw9FuG/JUY
	4gHwbfgZizQvrxPYobYSGtMJL6IlEBmfY5OQi0fvEKcHsLyVc6nNMMEs83dKstn4ihLVBFtZgXGnY
	zjVARJDg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v905e-00000005ulA-1V54;
	Wed, 15 Oct 2025 11:54:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6373030023C; Wed, 15 Oct 2025 13:54:45 +0200 (CEST)
Date: Wed, 15 Oct 2025 13:54:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Hillf Danton <hdanton@sina.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Jianyong Wu <jianyong.wu@outlook.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Tingyin Duan <tingyin.duan@gmail.com>,
	Vern Hao <vernhao@tencent.com>, Len Brown <len.brown@intel.com>,
	Aubrey Li <aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
	Chen Yu <yu.chen.surf@gmail.com>, Chen Yu <yu.c.chen@intel.com>,
	Libo Chen <libo.chen@oracle.com>,
	Adam Li <adamli@os.amperecomputing.com>,
	Tim Chen <tim.c.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/19] sched/fair: Add infrastructure for cache-aware
 load balancing
Message-ID: <20251015115445.GR3289052@noisy.programming.kicks-ass.net>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <865b852e3fdef6561c9e0a5be9a94aec8a68cdea.1760206683.git.tim.c.chen@linux.intel.com>
 <22750d4a-fdd6-48ad-a2ca-aa0c12af329c@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22750d4a-fdd6-48ad-a2ca-aa0c12af329c@linux.ibm.com>

On Wed, Oct 15, 2025 at 12:42:48AM +0530, Madadi Vineeth Reddy wrote:
> > +static void get_scan_cpumasks(cpumask_var_t cpus, int cache_cpu,
> > +			      int pref_nid, int curr_cpu)
> > +{
> > +#ifdef CONFIG_NUMA_BALANCING
> > +	/* First honor the task's preferred node. */
> > +	if (pref_nid != NUMA_NO_NODE)
> > +		cpumask_or(cpus, cpus, cpumask_of_node(pref_nid));
> > +#endif
> > +
> > +	/* Next honor the task's cache CPU if it is not included. */
> > +	if (cache_cpu != -1 && !cpumask_test_cpu(cache_cpu, cpus))
> > +		cpumask_or(cpus, cpus,
> > +			   cpumask_of_node(cpu_to_node(cache_cpu)));
> > +
> > +	/*
> > +	 * Lastly make sure that the task's current running node is
> > +	 * considered.
> > +	 */
> > +	if (!cpumask_test_cpu(curr_cpu, cpus))
> > +		cpumask_or(cpus, cpus, cpumask_of_node(cpu_to_node(curr_cpu)));
> > +}
> > +
> > +static void __no_profile task_cache_work(struct callback_head *work)
> > +{
> > +	struct task_struct *p = current;
> > +	struct mm_struct *mm = p->mm;
> > +	unsigned long m_a_occ = 0;
> > +	unsigned long curr_m_a_occ = 0;
> > +	int cpu, m_a_cpu = -1, cache_cpu,
> > +	    pref_nid = NUMA_NO_NODE, curr_cpu;
> > +	cpumask_var_t cpus;
> > +
> > +	WARN_ON_ONCE(work != &p->cache_work);
> > +
> > +	work->next = work;
> > +
> > +	if (p->flags & PF_EXITING)
> > +		return;
> > +
> > +	if (!zalloc_cpumask_var(&cpus, GFP_KERNEL))
> > +		return;
> > +
> > +	curr_cpu = task_cpu(p);
> > +	cache_cpu = mm->mm_sched_cpu;
> > +#ifdef CONFIG_NUMA_BALANCING
> > +	if (static_branch_likely(&sched_numa_balancing))
> > +		pref_nid = p->numa_preferred_nid;
> > +#endif
> > +
> > +	scoped_guard (cpus_read_lock) {
> > +		get_scan_cpumasks(cpus, cache_cpu,
> > +				  pref_nid, curr_cpu);
> > +
> 
> IIUC, `get_scan_cpumasks` ORs together the preferred NUMA node, cache CPU's node,
> and current CPU's node. This could result in scanning multiple nodes, not preferring
> the NUMA preferred node.

So this used to be online_mask, and is now magically changed to this
more limited mask.

Could you split this change out and have it have a justification?


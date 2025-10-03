Return-Path: <linux-kernel+bounces-841527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21348BB795C
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 912BF3472E5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E3E2C1786;
	Fri,  3 Oct 2025 16:41:25 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE6DBA3D
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759509685; cv=none; b=JUmMS/UGwAJbX72WxcYDlFv6sSn2Qc5MVzwPEce+hsBcfP1YReBGMEXMPTcWH6w7F86B+jO1fkvMQjpAufYkcmQxfk/pJ1QA0G8uslAAvX2zk980ZDTQIAAxKw3orek5ClVF8sDFPkWAaumb/gOz/IjIC6+XmFFpBVEn9PzS6OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759509685; c=relaxed/simple;
	bh=1JZJBIO5HCqVtfCWw2up3YHgDZGrTy8K5fbpoE/sBLg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tr4v+uu3UNZWVqslhAOZmoMfk78zWqztqX9CD2+dN0etkKQBvIF2G0rRqx3GUi1sDYFTN8LxrB7W6RbuBqFKWvDp9YYjlRgQDZ7SVGuHs/zjv4UmrEqwQpNC8oPw/lyrQKAAvfdE4NzJPTqW7DEXzKIYpgSU8waTRTIUXHvgP3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id CB316452A8;
	Fri,  3 Oct 2025 16:41:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 1175D2D;
	Fri,  3 Oct 2025 16:41:17 +0000 (UTC)
Date: Fri, 3 Oct 2025 12:43:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>, Johannes
 Weiner <hannes@cmpxchg.org>, Michal =?UTF-8?B?S291dG7DvQ==?=
 <mkoutny@suse.com>, Julia Lawall <Julia.Lawall@inria.fr>, "Luis Claudio R.
 Goncalves" <lgoncalv@redhat.com>, Joseph Salisbury
 <joseph.salisbury@oracle.com>
Subject: Re: [PATCH] sched: cgroup: Move task_can_attach() to cpuset.c
Message-ID: <20251003124300.4698dd18@gandalf.local.home>
In-Reply-To: <aN_7iDbWQq3HXvd3@gpd4>
References: <20251003121421.0cf4372d@gandalf.local.home>
	<aN_7iDbWQq3HXvd3@gpd4>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: dsesnafynggxwgjhuacgjtgfxp8zxykt
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 1175D2D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/EAGUAe87D4c7HJge1NenN/yxPd+B0h+g=
X-HE-Tag: 1759509677-445104
X-HE-Meta: U2FsdGVkX18G2bG6mmaWzU+itgMX70y+zIqNiJesZjqdcc6IewPT6/KIPIO7oehB7jhmoPkQeWXf8z+DQEnP+M6LDJeS1T5Qd6lAeM/XrNWC7SoZZj+OhsLHDGNKhItMc4CLu7QSqgvHsp0M23O0FfVbLod2bR0M8qw25Ar9fZ/m6fe8ihiZw07sZhmdDddz411/fOs915Xv90UkvuweYiRn4iW+L94ZW2a5RDD42cv/GQq3IvOiDHoIPL9aCW+Gs9MU7NxXgfX3cw5mUDc2bTpiAEPd1g6bFd60MI6Nvl2Q4sOUtYiG+mCgA13/EUFxy8aMXxSpNFC+fP+NaNnDwCWu4WF1cLdI4GDKNZgcgmErg2a2SM5pXjlkKf2mVVSw/TPyHUgK8llbkzKoXFcgFQ==

On Fri, 3 Oct 2025 18:36:24 +0200
Andrea Righi <arighi@nvidia.com> wrote:

> Hi Steven,
> 
> On Fri, Oct 03, 2025 at 12:14:21PM -0400, Steven Rostedt wrote:
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > At our monthly stable meeting, we were talking about documenting non
> > static functions and randomly picked a function to look at. That was
> > task_can_attach(). It was then noticed that it's only used by
> > cgroup/cpuset.c and nothing else. It's a simple function that doesn't
> > reference anything unique to sched/core.c, hence there's no reason that
> > function should be there.
> > 
> > Move it to cgroup/cpuset.c as that's the only place it is used. Also make
> > it a static inline as it is so small.
> > 
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>  
> 
> Nice cleanup. :)

Thanks, since you also were the first to notice it is only used in one spot.

> 
> Apparently it became that small with commit 2ef269ef1ac00 ("cgroup/cpuset:
> Free DL BW in case can_attach() fails"), maybe we can mention that in the
> commit message?

Sure.

> 
> > ---
> >  include/linux/sched.h  |  1 -
> >  kernel/cgroup/cpuset.c | 19 +++++++++++++++++++
> >  kernel/sched/core.c    | 19 -------------------
> >  3 files changed, 19 insertions(+), 20 deletions(-)
> > 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index e4ce0a76831e..4ee4fa973eda 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1849,7 +1849,6 @@ current_restore_flags(unsigned long orig_flags, unsigned long flags)
> >  }
> >  
> >  extern int cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
> > -extern int task_can_attach(struct task_struct *p);
> >  extern int dl_bw_alloc(int cpu, u64 dl_bw);
> >  extern void dl_bw_free(int cpu, u64 dl_bw);
> >  
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > index 27adb04df675..21fe872803e8 100644
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -3009,6 +3009,25 @@ static void reset_migrate_dl_data(struct cpuset *cs)
> >  	cs->sum_migrate_dl_bw = 0;
> >  }
> >  
> > +static inline int task_can_attach(struct task_struct *p)
> > +{
> > +	int ret = 0;
> > +
> > +	/*
> > +	 * Kthreads which disallow setaffinity shouldn't be moved
> > +	 * to a new cpuset; we don't want to change their CPU
> > +	 * affinity and isolating such threads by their set of
> > +	 * allowed nodes is unnecessary.  Thus, cpusets are not
> > +	 * applicable for such threads.  This prevents checking for
> > +	 * success of set_cpus_allowed_ptr() on all attached tasks
> > +	 * before cpus_mask may be changed.
> > +	 */
> > +	if (p->flags & PF_NO_SETAFFINITY)
> > +		ret = -EINVAL;
> > +
> > +	return ret;  
> 
> As we're cleaning up, we could just return -EINVAL and 0 directly and get
> rid of that ret variable.

That should be a separate patch. Moves should really not do much else. I
even wondered about making it a static inline too, but figured that wasn't
touching the logic, and the function was going to become static anyway.

-- Steve


> 
> > +}
> > +
> >  /* Called by cgroups to determine if a cpuset is usable; cpuset_mutex held */
> >  static int cpuset_can_attach(struct cgroup_taskset *tset)
> >  {
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index ccba6fc3c3fe..a195c4b25475 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -8070,25 +8070,6 @@ int cpuset_cpumask_can_shrink(const struct cpumask *cur,
> >  	return ret;
> >  }
> >  
> > -int task_can_attach(struct task_struct *p)
> > -{
> > -	int ret = 0;
> > -
> > -	/*
> > -	 * Kthreads which disallow setaffinity shouldn't be moved
> > -	 * to a new cpuset; we don't want to change their CPU
> > -	 * affinity and isolating such threads by their set of
> > -	 * allowed nodes is unnecessary.  Thus, cpusets are not
> > -	 * applicable for such threads.  This prevents checking for
> > -	 * success of set_cpus_allowed_ptr() on all attached tasks
> > -	 * before cpus_mask may be changed.
> > -	 */
> > -	if (p->flags & PF_NO_SETAFFINITY)
> > -		ret = -EINVAL;
> > -
> > -	return ret;
> > -}
> > -
> >  bool sched_smp_initialized __read_mostly;
> >  
> >  #ifdef CONFIG_NUMA_BALANCING
> > -- 
> > 2.50.1
> >   
> 
> Thanks,
> -Andrea



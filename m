Return-Path: <linux-kernel+bounces-651623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D58ABA0D1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 18:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B26021B63DDD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 16:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DF51D5CD4;
	Fri, 16 May 2025 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwAouU+s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4635786359;
	Fri, 16 May 2025 16:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747413228; cv=none; b=S8uG3JLAQIaRWR/43GmRC8EgHu7I4p3xGeLUBFrF5KgtsF5T6FFK58uHTBD1fmMq6DetzkUi7oOE04ob8Dji/Mh7/KPZsFqzHDqqYct2YlK2/MnJh5PNVjBZyx+YXdfYgBe22fff7erTsC+5buw9/hFQ89kRO7Bb39pRPjhyDB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747413228; c=relaxed/simple;
	bh=pO+WYUdorIAA/wn5K2BoNtnV+5/Wyl9eJSmmHjfAOtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9bewSLKDHQ2QXoOL4KpvTBFxGsOePgY5Pempuy1T7SZMLLTBELSD/tZPvkwQzaCXhy2eh8/bmRYnDP7IWAtROr+hjS7ggtgyKNYpGGiX3bz8+WF2oCFxLSQN2YlpfM8inSuS89XtUBdlX0rwal+QutwnsmSImTVwNQA07koHzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwAouU+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9E4C4CEE4;
	Fri, 16 May 2025 16:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747413227;
	bh=pO+WYUdorIAA/wn5K2BoNtnV+5/Wyl9eJSmmHjfAOtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fwAouU+sJOaCpdzXylMzuVVETwUbdjKXIcrv7boPyM4xY7wt1F0SBLgTsJ6ka1MZT
	 YV/E/S1vVh7wOQr6PHT58S5ZFs4Rh3ufrLN/ygf7ao1prf+oLtqqZyOGg4wicNEYl7
	 Om1uD+yKVtG1S8iRFcGDdaLOM/RvrGIEeS4P0WysEtmEg4zqGph29o8tVLqxcpg+CI
	 DQwiOn3DuaTwm0kWHcc3xGzpkQawksuIeZKEkrckGEIKUuuD+jy02ODf+qKVN58NCl
	 yJ/v3do3iJFQuA/+XbaftyxkMCrglvWgzAsGtQMHK8KimgDbOjOtyowXL3RQYzNpvW
	 lpbuk2BkTtsVg==
Date: Fri, 16 May 2025 09:33:45 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC/PATCH] perf report: Support latency profiling in
 system-wide mode
Message-ID: <aCdo6Vz2MVv3N0kk@google.com>
References: <20250503003620.45072-1-namhyung@kernel.org>
 <CACT4Y+Yr7vffLYG+YmyB=9Vn_oxdQqR_6U4d-_WeQoOtPXZ6iw@mail.gmail.com>
 <aBmei7cMf-MzzX5W@google.com>
 <CACT4Y+ameQFd3n=u+bjd+vKR6svShp3NNQzjsUo_UUBCZPzrBw@mail.gmail.com>
 <aBmvmmRKpeVd6aT3@google.com>
 <CACT4Y+bm4gCO_sGvEkxLQfw8JyrWvCzqV_H5h+oebt8kk1_Hwg@mail.gmail.com>
 <aBm1x2as1fraHXHz@google.com>
 <CACT4Y+aiU-dHVgTKEpyJtn=RUUyYJp8U5BjyWSOHm6b2ODp9cA@mail.gmail.com>
 <aBvwFPRwA2LVQJkO@google.com>
 <CACT4Y+YacgzrUL1uTqxkPOjQm6ryn2R_nPs8dgnrP_iKA9yasQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+YacgzrUL1uTqxkPOjQm6ryn2R_nPs8dgnrP_iKA9yasQ@mail.gmail.com>

Hello,

Sorry for the delay.

On Thu, May 08, 2025 at 02:24:08PM +0200, Dmitry Vyukov wrote:
> On Thu, 8 May 2025 at 01:43, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Tue, May 06, 2025 at 09:40:52AM +0200, Dmitry Vyukov wrote:
> > > On Tue, 6 May 2025 at 09:10, Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > > > Where does the patch check that this mode is used only for system-wide profiles?
> > > > > > > Is it that PERF_SAMPLE_CPU present only for system-wide profiles?
> > > > > >
> > > > > > Basically yes, but you can use --sample-cpu to add it.
> > > > >
> > > > > Are you sure? --sample-cpu seems to work for non-system-wide profiles too.
> > > >
> > > > Yep, that's why I said "Basically".  So it's not 100% guarantee.
> > > >
> > > > We may disable latency column by default in this case and show warning
> > > > if it's requested.  Or we may add a new attribute to emit sched-switch
> > > > records only for idle tasks and enable the latency report only if the
> > > > data has sched-switch records.
> > > >
> > > > What do you think?
> > >
> > > Depends on what problem we are trying to solve:
> > >
> > > 1. Enabling latency profiling for system-wide mode.
> > >
> > > 2. Switch events bloating trace too much.
> > >
> > > 3. Lost switch events lead to imprecise accounting.
> > >
> > > The patch mentions all 3 :)
> > > But I think 2 and 3 are not really specific to system-wide mode.
> > > An active single process profile can emit more samples than a
> > > system-wide profile on a lightly loaded system.
> >
> > True.  But we don't need to care about lightly loaded systems as they
> > won't cause problems.
> >
> >
> > > Similarly, if we rely on switch events for system-wide mode, then it's
> > > equally subject to the lost events problem.
> >
> > Right, but I'm afraid practically it'll increase the chance of lost
> > in system-wide mode.  The default size of the sample for system-wide
> > is 56 byte and the size of the switch is 48 byte.  And the default
> > sample frequency is 4000 Hz but it cannot control the rate of the
> > switch.  I saw around 10000 Hz of switches per CPU on my work env.
> >
> > >
> > > For problem 1: we can just permit --latency for system wide mode and
> > > fully rely on switch events.
> > > It's not any worse than we do now (wrt both profile size and lost events).
> >
> > This can be an option and it'd work well on lightly loaded systems.
> > Maybe we can just try it first.  But I think it's better to have an
> > option to make it work on heavily loaded systems.
> >
> > >
> > > For problem 2: yes, we could emit only switches to idle tasks. Or
> > > maybe just a fake CPU sample for an idle task? That's effectively what
> > > we want, then your current accounting code will work w/o any changes.
> > > This should help wrt trace size only for system-wide mode (provided
> > > that user already enables CPU accounting for other reasons, otherwise
> > > it's unclear what's better -- attaching CPU to each sample, or writing
> > > switch events).
> >
> > I'm not sure how we can add the fake samples.  The switch events will be
> > from the kernel and we may add the condition in the attribute.
> >
> > And PERF_SAMPLE_CPU is on by default in system-wide mode.
> >
> > >
> > > For problem 3: switches to idle task won't really help. There can be
> > > lots of them, and missing any will lead to wrong accounting.
> >
> > I don't know how severe the situation will be.  On heavily loaded
> > systems, the idle task won't run much and data size won't increase.
> > On lightly loaded systems, increased data will likely be handled well.
> >
> >
> > > A principled approach would be to attach a per-thread scheduler
> > > quantum sequence number to each CPU sample. The sequence number would
> > > be incremented on every context switch. Then any subset of CPU should
> > > be enough to understand when a task was scheduled in and out
> > > (scheduled in on the first CPU sample with sequence number N, and
> > > switched out on the last sample with sequence number N).
> >
> > I'm not sure how it can help.  We don't need the switch info itself.
> > What's needed is when the CPU was idle, right?
> 
> I mean the following.
> Each sample has a TID.
> We add a SEQ field, which is per-thread and is incremented after every
> rescheduling of the thread.
> 
> When we see the last sample for (TID,SEQ), we pretend there is SCHED
> OUT event for this thread at this timestamp. When we see the first
> sample for (TID,SEQ+1), we pretend there is SCHED IN event for this
> thread at this timestamp.
> 
> These SCHED IN/OUT events are not injected by the kernel. We just
> pretend they happen for accounting purposes. We may actually
> materialize them in the perf tool, or me may just update parallelism
> as if they happen.

Thanks for the explanation.  But I don't think it needs the SEQ and
SCHED IN/OUT generated from it to track lost records.  Please see below.

> 
> With this scheme we can lose absolutely any subset of samples, and
> still get very precise accounting. When we lose samples, the profile
> of course becomes a bit less precise, but the effect is local and
> recoverable.
> 
> If we lose the last/first event for (TID,SEQ), then we slightly
> shorten/postpone the thread accounting in the process parallelism
> level. If we lose a middle (TID,SEQ), then parallelism is not
> affected.

I'm afraid it cannot check parallelism by just seeing the current thread.
I guess it would need information from other threads even if it has same
SEQ.

Also postpone thread accounting can be complex.  I think it should wait
for all other threads to get a sample.  Maybe some threads exited and
lost too.

In my approach, I can clear the current thread from all CPUs when it
sees a LOST record and restart calculation of parallelism.

> 
> The switches from a thread to itself is not a problem. We will just
> inject a SCHED OUT followed by SCHED IN. But exactly the same happens
> now when the kernel injects these events.
> 
> But if we switch to idle task and got no samples for some period of
> time on the CPU, then we properly inject SCHED OUT/IN that will
> account for the thread not actually running.

Hmm.. ok.  Maybe we can save the timestamp of the last sample on each
CPU and clear the current thread after some period (2x of given freq?).
But it may slow down perf report as it'd check all CPUs for each sample.

Thanks,
Namhyung



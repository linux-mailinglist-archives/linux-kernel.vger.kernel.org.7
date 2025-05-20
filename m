Return-Path: <linux-kernel+bounces-655031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DF0ABCFC2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 08:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CAAE18925E6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 06:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4270E25D1E3;
	Tue, 20 May 2025 06:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MEgmHkdN"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C4425D1EA
	for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 06:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747723567; cv=none; b=pdKMBgMqviQ1HCVhRNnCy46AWVlVY4mvivYA0q9VGlzo2V7hk28n8r7fTXRCngY6xYPknu46Z8mdMFLhoFcVvvlW5qmbHraRaaIbuDmwuzhC8bbXQf2rgkHf81aDWw3/x59oxzMClDqGTV/b2ksyujJJsqa3oXCoqjn5MpbC26g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747723567; c=relaxed/simple;
	bh=7dFcpXzoMhDPmapILvqvqqslgVEbg8FBhVPRbfSd5KU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IvBF0Ynq9U2u9cSFD8wZO0cjr9qKVZDiqY/oUc4caVkQsvO1xZOXAk45TGaknLd2hwjTFsuXs8vcsOWXEoYYS88d3VajRhaIObCLE6HOqw4aXxkwxBXoEakbG3eEkMiHCBs33OIU/g/nh3mocXVkiqEfzw02yCbnvzIHm6jyQqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MEgmHkdN; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54ea69e9352so6767668e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 23:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747723563; x=1748328363; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XEscknlu0WPibPrm55AVy8FsseHSHUo+KXViZ4nJwrY=;
        b=MEgmHkdNbCMoKzJcbiZGdPJGKm1TOL2bL427jaB6jPYqqm/djQ9VNqwPCWKHGR3cg0
         p1RSVMVRFUaX5eCFFZt89j3hrvfH74C69rruOJlfqLixyiM7b1GJg1KKkPHOsbK27jZF
         RDuX5lZBxjwHHWO1osfC316RvcjvworEShIZEDGRU8Ln5kNzwrNDQBQqEe0NVkuLHO28
         A3+BPR8MauiGo+U4kxPBd4kQIbO7LhwCv3iRQosGfep5iy9ZGkyxFRpRyuiGOguMjIUq
         08g91AH7DEdwas6nErmy/2KBrCJy8IAy0opgCu/3gFBRQlpWgm+eqeBGyChUKhvCu+Ac
         pMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747723563; x=1748328363;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XEscknlu0WPibPrm55AVy8FsseHSHUo+KXViZ4nJwrY=;
        b=IXGMtLLfxUQetqmFjZoCKQGbxz7ZBZCMCpNGEWb1z8vguRmHKcqQPhk+cXXNssBvKA
         DxYvrqMaiCEq3PBHM6BJ+ieQxOpJPuwF4SiWGemJyechI/lJ+KGhtADvodINYj5YJrQV
         dN4WeAU452PBbLDuTYwIaISkyBz7ynfvfCIpPS2GMzLBbBvaNwlqwj/AncV992ZdwcUP
         i4HeE6yRWasAj3TeKG45DMVwAj0AlrMd16mAYXD4zSeqniSHy9ozBu/nqbE0YtVcSNJY
         MY9r1QwJRueGy+jrIhAebOA5pddVOfp0j39TxQdIeV9ftapzRf6yLdQxgL+HUmHS6z47
         5RUg==
X-Forwarded-Encrypted: i=1; AJvYcCVd8kxj1bTuLGVkeib3qfSyCx4tsQfkQj1LtR6NEy3pRDzjXd69/f/MEk3mwmiKPd/inlpzs5TAcl+4xQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YygP9RXcJZ90He1TphXhj1fnckwbkKsWxUcU6WI6ECW2pLFe0kf
	l9Ng28bOJKWsfjeVOz5az7EvX9OspmwQaJQplou5CUziUnG/tRjYmnrGprk4GTmQlKlQZ2Px0J4
	cW5FNU4iA4/y0s60KoTTeKzeknW0nM/wI2FsFIQwB
X-Gm-Gg: ASbGncuCxLtd9mJY/2cXqqcjUIlzcAq8iSjOachMs1luKz0G543B35sn8tMNOTcl/xh
	XMEsJJcc/ITgKoLArDB4Ye8ztZue+ottdD9Sj8RlxypIAhphbkS1Wf9gGX/NBXCw6Y6z6/kQ0yH
	/scGU9oDOjML1lEEvb0F1DJLH4Oqtm09AwWRVIwBrpOJIzvVxb+OVyFits1wshGEL/plELIwCDN
	EiJ
X-Google-Smtp-Source: AGHT+IGrYL4QvinCB5HgJ5HkA6eossHBvn+dYCxUaELh4Eh2fewnluQwzz+btR/dTm7W0Ve1UGuoHfDKZxq9qu7iUVI=
X-Received: by 2002:a05:6512:3d91:b0:549:7354:e4d1 with SMTP id
 2adb3069b0e04-550e98fca76mr4492829e87.38.1747723562774; Mon, 19 May 2025
 23:46:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aBmei7cMf-MzzX5W@google.com> <CACT4Y+ameQFd3n=u+bjd+vKR6svShp3NNQzjsUo_UUBCZPzrBw@mail.gmail.com>
 <aBmvmmRKpeVd6aT3@google.com> <CACT4Y+bm4gCO_sGvEkxLQfw8JyrWvCzqV_H5h+oebt8kk1_Hwg@mail.gmail.com>
 <aBm1x2as1fraHXHz@google.com> <CACT4Y+aiU-dHVgTKEpyJtn=RUUyYJp8U5BjyWSOHm6b2ODp9cA@mail.gmail.com>
 <aBvwFPRwA2LVQJkO@google.com> <CACT4Y+YacgzrUL1uTqxkPOjQm6ryn2R_nPs8dgnrP_iKA9yasQ@mail.gmail.com>
 <aCdo6Vz2MVv3N0kk@google.com> <CACT4Y+YHxXjCU2jySTUO5kH=xC8scdzTTuP2qEBc5zMber44Aw@mail.gmail.com>
 <aCveO4qQGy03ow5p@google.com>
In-Reply-To: <aCveO4qQGy03ow5p@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 20 May 2025 08:45:51 +0200
X-Gm-Features: AX0GCFt6kuazUMi1HHsonhi3PXMwv4ckzIBmVYwKEQLE4hJRGbY88fLOglLbUlk
Message-ID: <CACT4Y+YdnQebkGTQJ9yhLs2j12WBYk2ReiBAq5cE+wtu1RRU5A@mail.gmail.com>
Subject: Re: [RFC/PATCH] perf report: Support latency profiling in system-wide mode
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 May 2025 at 03:43, Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Mon, May 19, 2025 at 08:00:49AM +0200, Dmitry Vyukov wrote:
> > On Fri, 16 May 2025 at 18:33, Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > Hello,
> > >
> > > Sorry for the delay.
> > >
> > > On Thu, May 08, 2025 at 02:24:08PM +0200, Dmitry Vyukov wrote:
> > > > On Thu, 8 May 2025 at 01:43, Namhyung Kim <namhyung@kernel.org> wrote:
> > > > >
> > > > > On Tue, May 06, 2025 at 09:40:52AM +0200, Dmitry Vyukov wrote:
> > > > > > On Tue, 6 May 2025 at 09:10, Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > > > > > > Where does the patch check that this mode is used only for system-wide profiles?
> > > > > > > > > > Is it that PERF_SAMPLE_CPU present only for system-wide profiles?
> > > > > > > > >
> > > > > > > > > Basically yes, but you can use --sample-cpu to add it.
> > > > > > > >
> > > > > > > > Are you sure? --sample-cpu seems to work for non-system-wide profiles too.
> > > > > > >
> > > > > > > Yep, that's why I said "Basically".  So it's not 100% guarantee.
> > > > > > >
> > > > > > > We may disable latency column by default in this case and show warning
> > > > > > > if it's requested.  Or we may add a new attribute to emit sched-switch
> > > > > > > records only for idle tasks and enable the latency report only if the
> > > > > > > data has sched-switch records.
> > > > > > >
> > > > > > > What do you think?
> > > > > >
> > > > > > Depends on what problem we are trying to solve:
> > > > > >
> > > > > > 1. Enabling latency profiling for system-wide mode.
> > > > > >
> > > > > > 2. Switch events bloating trace too much.
> > > > > >
> > > > > > 3. Lost switch events lead to imprecise accounting.
> > > > > >
> > > > > > The patch mentions all 3 :)
> > > > > > But I think 2 and 3 are not really specific to system-wide mode.
> > > > > > An active single process profile can emit more samples than a
> > > > > > system-wide profile on a lightly loaded system.
> > > > >
> > > > > True.  But we don't need to care about lightly loaded systems as they
> > > > > won't cause problems.
> > > > >
> > > > >
> > > > > > Similarly, if we rely on switch events for system-wide mode, then it's
> > > > > > equally subject to the lost events problem.
> > > > >
> > > > > Right, but I'm afraid practically it'll increase the chance of lost
> > > > > in system-wide mode.  The default size of the sample for system-wide
> > > > > is 56 byte and the size of the switch is 48 byte.  And the default
> > > > > sample frequency is 4000 Hz but it cannot control the rate of the
> > > > > switch.  I saw around 10000 Hz of switches per CPU on my work env.
> > > > >
> > > > > >
> > > > > > For problem 1: we can just permit --latency for system wide mode and
> > > > > > fully rely on switch events.
> > > > > > It's not any worse than we do now (wrt both profile size and lost events).
> > > > >
> > > > > This can be an option and it'd work well on lightly loaded systems.
> > > > > Maybe we can just try it first.  But I think it's better to have an
> > > > > option to make it work on heavily loaded systems.
> > > > >
> > > > > >
> > > > > > For problem 2: yes, we could emit only switches to idle tasks. Or
> > > > > > maybe just a fake CPU sample for an idle task? That's effectively what
> > > > > > we want, then your current accounting code will work w/o any changes.
> > > > > > This should help wrt trace size only for system-wide mode (provided
> > > > > > that user already enables CPU accounting for other reasons, otherwise
> > > > > > it's unclear what's better -- attaching CPU to each sample, or writing
> > > > > > switch events).
> > > > >
> > > > > I'm not sure how we can add the fake samples.  The switch events will be
> > > > > from the kernel and we may add the condition in the attribute.
> > > > >
> > > > > And PERF_SAMPLE_CPU is on by default in system-wide mode.
> > > > >
> > > > > >
> > > > > > For problem 3: switches to idle task won't really help. There can be
> > > > > > lots of them, and missing any will lead to wrong accounting.
> > > > >
> > > > > I don't know how severe the situation will be.  On heavily loaded
> > > > > systems, the idle task won't run much and data size won't increase.
> > > > > On lightly loaded systems, increased data will likely be handled well.
> > > > >
> > > > >
> > > > > > A principled approach would be to attach a per-thread scheduler
> > > > > > quantum sequence number to each CPU sample. The sequence number would
> > > > > > be incremented on every context switch. Then any subset of CPU should
> > > > > > be enough to understand when a task was scheduled in and out
> > > > > > (scheduled in on the first CPU sample with sequence number N, and
> > > > > > switched out on the last sample with sequence number N).
> > > > >
> > > > > I'm not sure how it can help.  We don't need the switch info itself.
> > > > > What's needed is when the CPU was idle, right?
> > > >
> > > > I mean the following.
> > > > Each sample has a TID.
> > > > We add a SEQ field, which is per-thread and is incremented after every
> > > > rescheduling of the thread.
> > > >
> > > > When we see the last sample for (TID,SEQ), we pretend there is SCHED
> > > > OUT event for this thread at this timestamp. When we see the first
> > > > sample for (TID,SEQ+1), we pretend there is SCHED IN event for this
> > > > thread at this timestamp.
> > > >
> > > > These SCHED IN/OUT events are not injected by the kernel. We just
> > > > pretend they happen for accounting purposes. We may actually
> > > > materialize them in the perf tool, or me may just update parallelism
> > > > as if they happen.
> > >
> > > Thanks for the explanation.  But I don't think it needs the SEQ and
> > > SCHED IN/OUT generated from it to track lost records.  Please see below.
> > >
> > > >
> > > > With this scheme we can lose absolutely any subset of samples, and
> > > > still get very precise accounting. When we lose samples, the profile
> > > > of course becomes a bit less precise, but the effect is local and
> > > > recoverable.
> > > >
> > > > If we lose the last/first event for (TID,SEQ), then we slightly
> > > > shorten/postpone the thread accounting in the process parallelism
> > > > level. If we lose a middle (TID,SEQ), then parallelism is not
> > > > affected.
> > >
> > > I'm afraid it cannot check parallelism by just seeing the current thread.
> > > I guess it would need information from other threads even if it has same
> > > SEQ.
> >
> > Yes, we still count parallelism like you do in this patch, we just use
> > the SEQ info instead of CPU numbers and explicit switch events.
>
> I mean after record lost, let's say
>
>   t1: SAMPLE for TID 1234, seq 10  (parallelism = 4)
>   t2: LOST
>   t3: SAMPLE for TID 1234, seq 10  (parallelism = ?)
>
> I don't think we can continue to use parallelism of 4 after LOST even if
> it has the same seq because it cannot know if other threads switched on
> other CPUs.  Then do we need really the seq?

I do not understand the problem you describe.
We just keep updating parallelism according to the algorithm I
described. It works fine in the presence of lost events.


> > > Also postpone thread accounting can be complex.  I think it should wait
> > > for all other threads to get a sample.  Maybe some threads exited and
> > > lost too.
> >
> > Yes, in order to understand what's the last event for (TID,SEQ) we
> > need to look ahead and find the event (TID,SEQ+1). The easiest way to
> > do it would be to do 2 passes over the trace. That's the cost of
> > saving trace space + being resilient to lost events.
> >
> > Do you see any other issues with this scheme besides requiring 2 passes?
>
> Well.. 2 pass itself can be a problem due to slowness it'd bring.  Some
> people complain about the speed of perf report as of now.

Is trace processing CPU-bound or memory-bound? If it's CPU-bound, then
the second pass may be OK-ish, since we will need minimal CPU
processing during the first pass.


> I think we can simply reset the parallelism in all processes after LOST
> and set current process to the idle task.  It'll catch up as soon as it
> sees samples from all CPUs.

I guess we can approximate parallelism as you described here:

> Hmm.. ok.  Maybe we can save the timestamp of the last sample on each
> CPU and clear the current thread after some period (2x of given freq?).

We probably don't need to do anything special for lost events in this
scheme at all. If the gap caused by lost events is tiny, then we
consider nothing happened. If the gap is large enough, then we
consider the CPU as idle for the duration of the gap. Either way it
will be handled on common grounds.

But tuning of these heuristics + testing and verification may be a bit
of a problem. I would hate to end up with a tool which I won't trust.

Here:
"after some period (2x of given freq?)"
do you mean 2x average/median period, or 1/2 average/median period?
(2x freq is 1/2 period)

Ideally, we consider a CPU idle after 1/2 period after it switched to
the idle task and we stop receiving samples.
But on the other hand, we don't want to consider it constantly
becoming idle, when it's just doing normal sampling with the normal
period...

So ideally the algorithm should be something like:
let's say average/median sampling period is P
we got last sample for CPU X at time T
if by time T+2P we have not seen any other sample on CPU X, then
consider CPU X idle since T+0.5P

But this would also require either 2 passes over the data, or some
kind of look ahead similar to the algo I proposed...

Also, do we take the median period? or average? do we update it over
time (say, if CPU freq changes)? do we count it globally, or per CPU
(in case CPUs run at different freqs)?









> > > In my approach, I can clear the current thread from all CPUs when it
> > > sees a LOST record and restart calculation of parallelism.
> > >
> > > >
> > > > The switches from a thread to itself is not a problem. We will just
> > > > inject a SCHED OUT followed by SCHED IN. But exactly the same happens
> > > > now when the kernel injects these events.
> > > >
> > > > But if we switch to idle task and got no samples for some period of
> > > > time on the CPU, then we properly inject SCHED OUT/IN that will
> > > > account for the thread not actually running.
> > >
> > > Hmm.. ok.  Maybe we can save the timestamp of the last sample on each
> > > CPU and clear the current thread after some period (2x of given freq?).
> > > But it may slow down perf report as it'd check all CPUs for each sample.
> > >
> > > Thanks,
> > > Namhyung
> > >


Return-Path: <linux-kernel+bounces-656955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97717ABED10
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 09:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEA461BA56F7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 07:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B60C2356CE;
	Wed, 21 May 2025 07:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xAZ86eZS"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE879235079
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 07:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747812616; cv=none; b=ab+BGB+JCdyGxawiVixGLgGteac8jd3Q1lVzQ/Azx3s73GuWikpjIMJCzeqfzqR7nWULZb2vI1vR0tn526BdpT5USPFOju7/P/boZ9B6xnchiVHzIVKt3+91u4+QWDo5u1gNKxrM+tKCfWTG5dWN/xFUaBYg/vVJ3KxUw/Sdpdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747812616; c=relaxed/simple;
	bh=jWTBHPiY2LJpSPN5cLKpwiRnaGqWoKhlVu027p//pHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/Feyi8NZR6OjJlvxuy1HMG9AArn9zXcMlJrYaXR/k73pwcBEiS7FhYqMbIkDBUXhIERLN7MuRVByqd+XDHznJiRylGBBF+ed9DwVB+d9NBPZEc0CMRS8aypVfGeoVnCpfS0nSYm3u0wQNzU4UM5jMk+ljobBrjyqtejXUP5tKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xAZ86eZS; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54d6f933152so9928044e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 00:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747812612; x=1748417412; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A1+3inoKrUzfO+YHkCsiBNm62kM9H+CVu38LISaGbNE=;
        b=xAZ86eZSoPZDmxLSVDstmYCsDrdM4/TMaJQsDAQkitOHwVm0I+epdWMitrwITUFx4c
         DjTPPcEKqWtKO+ebxw0GqdSTHJUUP6Plrs4UmceUTl6boMc8DHG5VVXGRnMaA3woTL7U
         0BrDumb2ljOF0gouCJHvYrmt+3ggjTVtlSpR59SKugqw6njZIqyFihLmiw/kxwMimf4f
         91ZgDqm2Uhyo5I99psVkiPkxpy2Hw2YHEkP9KIrHoMX3AF7KKQd13C7vTAsWrOiRy4DS
         JmNvHC1UQiJ6W9tzADYrTyD3bLv1rzENbaJq6jXOItgmqA+TQfLPk8QBd9fkyIMneAFy
         eZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747812612; x=1748417412;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A1+3inoKrUzfO+YHkCsiBNm62kM9H+CVu38LISaGbNE=;
        b=wx2teVgsmpg8ws37NRteL0KN1AlrHp++3vamJVPlL+wsfbDu8F3H6cR2iVsFufYEoO
         fua9jqtZB8zW1Ptjd2MpCpgqtxA+QhWy8+MZ9Q0sSDknP2/VgSrXfGDp7O4Ber6pT7rv
         w+g6JIzx/1Z9u/1oo+YcYpOx/D2v08XvhHSqU5da2/3c5xE0FWQ3CLixdAijEupUKq+H
         ZJviJos15r+ia3GpQzLSzskA+Hc7tU6TZjPmm2L7aQFgN+jIWEHR4aRUkUDasA71t1E2
         2D4kxQd+xHpkB6z3Z6m1DB/FfyQb6iFbtzWysqzw2WU67hGibeOwYkZbQ6lHGsPoQK7U
         ny6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX82woE/t0HmkSkC7CnApYi1yG//hFoh0qz3Q3LjlGnUg6jJsh1jPeQ5d6iTpPHbIIFDogSanzej/iMvXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPh0weND4QtMNt4NOF40dmDOHRq3KAxtLgWFv78t6ojgOtNHrP
	sV/+s4XZqMlF/J5GYOuQBkZ988ysSgQUlCBdbcoC6B/SsP9WBUEtAWW9hfsw6clOC4BYew/8b77
	+7hhjYzWzxbsABEL8GVKJT2t8ceRclkn0aI9cOSBy
X-Gm-Gg: ASbGncs96ZUu13rzQC3QRfaoqqc3dnyhVaP/xGK/tQub6exbfVlbE0Cj5m970rvaBoo
	DU1znHnOC9jaEGyQ/FTKbimbIJ0WyNRwlw3gPQ4typJmCqAT+M6voBVB0XEaPCfR9JoXoj3Ae6+
	cWMuf8KPSvNrmrMOfp2YZiYpfQ94rH7CC5LBOVAUuLOjrGwAZtmWWm9x+2m8h9dNjNpJdMnzLRg
	XQ=
X-Google-Smtp-Source: AGHT+IGSvy7Siu4AiaNik05iCJBy5qiUsIzD79e1PIP+TnkhvIZ2A36VRc2qp5O4NTJAEt/EefTF8bQwhmUoUmIJ4hU=
X-Received: by 2002:a05:651c:3131:b0:30c:2d44:c212 with SMTP id
 38308e7fff4ca-328096b5832mr74124961fa.9.1747812611407; Wed, 21 May 2025
 00:30:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aBmvmmRKpeVd6aT3@google.com> <CACT4Y+bm4gCO_sGvEkxLQfw8JyrWvCzqV_H5h+oebt8kk1_Hwg@mail.gmail.com>
 <aBm1x2as1fraHXHz@google.com> <CACT4Y+aiU-dHVgTKEpyJtn=RUUyYJp8U5BjyWSOHm6b2ODp9cA@mail.gmail.com>
 <aBvwFPRwA2LVQJkO@google.com> <CACT4Y+YacgzrUL1uTqxkPOjQm6ryn2R_nPs8dgnrP_iKA9yasQ@mail.gmail.com>
 <aCdo6Vz2MVv3N0kk@google.com> <CACT4Y+YHxXjCU2jySTUO5kH=xC8scdzTTuP2qEBc5zMber44Aw@mail.gmail.com>
 <aCveO4qQGy03ow5p@google.com> <CACT4Y+YdnQebkGTQJ9yhLs2j12WBYk2ReiBAq5cE+wtu1RRU5A@mail.gmail.com>
 <aC0HH45JCBTchZMc@google.com>
In-Reply-To: <aC0HH45JCBTchZMc@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 21 May 2025 09:30:00 +0200
X-Gm-Features: AX0GCFt3rThHgR-m1qIaYUr-PDVwjL6sHjrGM4Xsu7psCVibkIamwFzNDSZJU_s
Message-ID: <CACT4Y+apAJ_m9W=P2hsGvWrGZnTzxB+9qgJg=ujjU8OWCVcUoQ@mail.gmail.com>
Subject: Re: [RFC/PATCH] perf report: Support latency profiling in system-wide mode
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 May 2025 at 00:50, Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > Hello,
> > > > >
> > > > > Sorry for the delay.
> > > > >
> > > > > On Thu, May 08, 2025 at 02:24:08PM +0200, Dmitry Vyukov wrote:
> > > > > > On Thu, 8 May 2025 at 01:43, Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > > >
> > > > > > > On Tue, May 06, 2025 at 09:40:52AM +0200, Dmitry Vyukov wrote:
> > > > > > > > On Tue, 6 May 2025 at 09:10, Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > > > > > > > > Where does the patch check that this mode is used only for system-wide profiles?
> > > > > > > > > > > > Is it that PERF_SAMPLE_CPU present only for system-wide profiles?
> > > > > > > > > > >
> > > > > > > > > > > Basically yes, but you can use --sample-cpu to add it.
> > > > > > > > > >
> > > > > > > > > > Are you sure? --sample-cpu seems to work for non-system-wide profiles too.
> > > > > > > > >
> > > > > > > > > Yep, that's why I said "Basically".  So it's not 100% guarantee.
> > > > > > > > >
> > > > > > > > > We may disable latency column by default in this case and show warning
> > > > > > > > > if it's requested.  Or we may add a new attribute to emit sched-switch
> > > > > > > > > records only for idle tasks and enable the latency report only if the
> > > > > > > > > data has sched-switch records.
> > > > > > > > >
> > > > > > > > > What do you think?
> > > > > > > >
> > > > > > > > Depends on what problem we are trying to solve:
> > > > > > > >
> > > > > > > > 1. Enabling latency profiling for system-wide mode.
> > > > > > > >
> > > > > > > > 2. Switch events bloating trace too much.
> > > > > > > >
> > > > > > > > 3. Lost switch events lead to imprecise accounting.
> > > > > > > >
> > > > > > > > The patch mentions all 3 :)
> > > > > > > > But I think 2 and 3 are not really specific to system-wide mode.
> > > > > > > > An active single process profile can emit more samples than a
> > > > > > > > system-wide profile on a lightly loaded system.
> > > > > > >
> > > > > > > True.  But we don't need to care about lightly loaded systems as they
> > > > > > > won't cause problems.
> > > > > > >
> > > > > > >
> > > > > > > > Similarly, if we rely on switch events for system-wide mode, then it's
> > > > > > > > equally subject to the lost events problem.
> > > > > > >
> > > > > > > Right, but I'm afraid practically it'll increase the chance of lost
> > > > > > > in system-wide mode.  The default size of the sample for system-wide
> > > > > > > is 56 byte and the size of the switch is 48 byte.  And the default
> > > > > > > sample frequency is 4000 Hz but it cannot control the rate of the
> > > > > > > switch.  I saw around 10000 Hz of switches per CPU on my work env.
> > > > > > >
> > > > > > > >
> > > > > > > > For problem 1: we can just permit --latency for system wide mode and
> > > > > > > > fully rely on switch events.
> > > > > > > > It's not any worse than we do now (wrt both profile size and lost events).
> > > > > > >
> > > > > > > This can be an option and it'd work well on lightly loaded systems.
> > > > > > > Maybe we can just try it first.  But I think it's better to have an
> > > > > > > option to make it work on heavily loaded systems.
> > > > > > >
> > > > > > > >
> > > > > > > > For problem 2: yes, we could emit only switches to idle tasks. Or
> > > > > > > > maybe just a fake CPU sample for an idle task? That's effectively what
> > > > > > > > we want, then your current accounting code will work w/o any changes.
> > > > > > > > This should help wrt trace size only for system-wide mode (provided
> > > > > > > > that user already enables CPU accounting for other reasons, otherwise
> > > > > > > > it's unclear what's better -- attaching CPU to each sample, or writing
> > > > > > > > switch events).
> > > > > > >
> > > > > > > I'm not sure how we can add the fake samples.  The switch events will be
> > > > > > > from the kernel and we may add the condition in the attribute.
> > > > > > >
> > > > > > > And PERF_SAMPLE_CPU is on by default in system-wide mode.
> > > > > > >
> > > > > > > >
> > > > > > > > For problem 3: switches to idle task won't really help. There can be
> > > > > > > > lots of them, and missing any will lead to wrong accounting.
> > > > > > >
> > > > > > > I don't know how severe the situation will be.  On heavily loaded
> > > > > > > systems, the idle task won't run much and data size won't increase.
> > > > > > > On lightly loaded systems, increased data will likely be handled well.
> > > > > > >
> > > > > > >
> > > > > > > > A principled approach would be to attach a per-thread scheduler
> > > > > > > > quantum sequence number to each CPU sample. The sequence number would
> > > > > > > > be incremented on every context switch. Then any subset of CPU should
> > > > > > > > be enough to understand when a task was scheduled in and out
> > > > > > > > (scheduled in on the first CPU sample with sequence number N, and
> > > > > > > > switched out on the last sample with sequence number N).
> > > > > > >
> > > > > > > I'm not sure how it can help.  We don't need the switch info itself.
> > > > > > > What's needed is when the CPU was idle, right?
> > > > > >
> > > > > > I mean the following.
> > > > > > Each sample has a TID.
> > > > > > We add a SEQ field, which is per-thread and is incremented after every
> > > > > > rescheduling of the thread.
> > > > > >
> > > > > > When we see the last sample for (TID,SEQ), we pretend there is SCHED
> > > > > > OUT event for this thread at this timestamp. When we see the first
> > > > > > sample for (TID,SEQ+1), we pretend there is SCHED IN event for this
> > > > > > thread at this timestamp.
> > > > > >
> > > > > > These SCHED IN/OUT events are not injected by the kernel. We just
> > > > > > pretend they happen for accounting purposes. We may actually
> > > > > > materialize them in the perf tool, or me may just update parallelism
> > > > > > as if they happen.
> > > > >
> > > > > Thanks for the explanation.  But I don't think it needs the SEQ and
> > > > > SCHED IN/OUT generated from it to track lost records.  Please see below.
> > > > >
> > > > > >
> > > > > > With this scheme we can lose absolutely any subset of samples, and
> > > > > > still get very precise accounting. When we lose samples, the profile
> > > > > > of course becomes a bit less precise, but the effect is local and
> > > > > > recoverable.
> > > > > >
> > > > > > If we lose the last/first event for (TID,SEQ), then we slightly
> > > > > > shorten/postpone the thread accounting in the process parallelism
> > > > > > level. If we lose a middle (TID,SEQ), then parallelism is not
> > > > > > affected.
> > > > >
> > > > > I'm afraid it cannot check parallelism by just seeing the current thread.
> > > > > I guess it would need information from other threads even if it has same
> > > > > SEQ.
> > > >
> > > > Yes, we still count parallelism like you do in this patch, we just use
> > > > the SEQ info instead of CPU numbers and explicit switch events.
> > >
> > > I mean after record lost, let's say
> > >
> > >   t1: SAMPLE for TID 1234, seq 10  (parallelism = 4)
> > >   t2: LOST
> > >   t3: SAMPLE for TID 1234, seq 10  (parallelism = ?)
> > >
> > > I don't think we can continue to use parallelism of 4 after LOST even if
> > > it has the same seq because it cannot know if other threads switched on
> > > other CPUs.  Then do we need really the seq?
> >
> > I do not understand the problem you describe.
> > We just keep updating parallelism according to the algorithm I
> > described. It works fine in the presence of lost events.
>
> Do you think it's ok to use 4 if seq is the same?  I'm afraid it'd be
> inaccurate.

It will be inaccurate briefly for the period of 1 sample if we lost
specifically the last/first sample of a thread scheduling quantum. And
then it will recover and will be precise.

But it's exactly the same in your scheme, right. If we stopped seeing
events on a CPU due to lost events, we will assume it's not running.

And generally lost events will always lead to imprecision. That's
unavoidable. It's only important if the imprecision is limited and
proportional to the number of lost events. And this is the case for
the SEQ scheme.


> > > > > Also postpone thread accounting can be complex.  I think it should wait
> > > > > for all other threads to get a sample.  Maybe some threads exited and
> > > > > lost too.
> > > >
> > > > Yes, in order to understand what's the last event for (TID,SEQ) we
> > > > need to look ahead and find the event (TID,SEQ+1). The easiest way to
> > > > do it would be to do 2 passes over the trace. That's the cost of
> > > > saving trace space + being resilient to lost events.
> > > >
> > > > Do you see any other issues with this scheme besides requiring 2 passes?
> > >
> > > Well.. 2 pass itself can be a problem due to slowness it'd bring.  Some
> > > people complain about the speed of perf report as of now.
> >
> > Is trace processing CPU-bound or memory-bound? If it's CPU-bound, then
> > the second pass may be OK-ish, since we will need minimal CPU
> > processing during the first pass.
>
> It depends on the size of data, but I guess it's CPU-bound in most cases.
>
> >
> >
> > > I think we can simply reset the parallelism in all processes after LOST
> > > and set current process to the idle task.  It'll catch up as soon as it
> > > sees samples from all CPUs.
> >
> > I guess we can approximate parallelism as you described here:
> >
> > > Hmm.. ok.  Maybe we can save the timestamp of the last sample on each
> > > CPU and clear the current thread after some period (2x of given freq?).
> >
> > We probably don't need to do anything special for lost events in this
> > scheme at all. If the gap caused by lost events is tiny, then we
> > consider nothing happened. If the gap is large enough, then we
> > consider the CPU as idle for the duration of the gap. Either way it
> > will be handled on common grounds.
>
> How do you know if it's tiny?  Do you mean the seq remains after lost?

I was talking about your scheme based on CPU numbers.


> > But tuning of these heuristics + testing and verification may be a bit
> > of a problem. I would hate to end up with a tool which I won't trust.
> >
> > Here:
> > "after some period (2x of given freq?)"
> > do you mean 2x average/median period, or 1/2 average/median period?
> > (2x freq is 1/2 period)
>
> Oh, sorry.  It's 2x period.
>
> >
> > Ideally, we consider a CPU idle after 1/2 period after it switched to
> > the idle task and we stop receiving samples.
> > But on the other hand, we don't want to consider it constantly
> > becoming idle, when it's just doing normal sampling with the normal
> > period...
> >
> > So ideally the algorithm should be something like:
> > let's say average/median sampling period is P
> > we got last sample for CPU X at time T
> > if by time T+2P we have not seen any other sample on CPU X, then
> > consider CPU X idle since T+0.5P
> >
> > But this would also require either 2 passes over the data, or some
> > kind of look ahead similar to the algo I proposed...
>
> I think we can do it in 1 pass.  For each sample,
>
>   for_each_cpu(cpu) {
>       if (current[cpu]->last_timestamp + 2*period < sample->timestamp) {
>           if (current[cpu]->thread != idle) {
>               current[cpu]->thread->parallelism--;
>               current[cpu]->thread = idle;
>           }
>       }
>   }
>
>   leader = machine__findnew_thread(machine, sample->pid);
>   current[sample->cpu]->last_timestamp = sample->timestamp;
>
>   if (current[sample->cpu]->thread != leader) {
>       if (current[sample->cpu]->thread != idle)
>           current[sample->cpu]->thread->parallelism--;
>
>       current[sample->cpu]->thread = leader;
>       leader->parallelism++;
>   }
>
>   sample->parallelism = leader->parallelism;

As I described, for this simple 1 pass algorithm, I am afraid of imprecision.
The thread has not continued to run for 2 periods. I run for 0-1 period.



> > Also, do we take the median period? or average? do we update it over
> > time (say, if CPU freq changes)? do we count it globally, or per CPU
> > (in case CPUs run at different freqs)?
>
> Oh, perf tools use default frequency of 4000 Hz.

Is the actual sample rate reasonably precise across time/CPUs?

> Maybe we can use this
> only for the frequency mode which means user didn't use -c option or
> similar in the event description.
>
> Thanks,
> Namhyung
>


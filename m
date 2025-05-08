Return-Path: <linux-kernel+bounces-639614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D775CAAF9C8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 14:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58AAD9C71B1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 12:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4068422540F;
	Thu,  8 May 2025 12:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bo+NAqAs"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD07B221725
	for <linux-kernel@vger.kernel.org>; Thu,  8 May 2025 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746707064; cv=none; b=P58uqJYaDiFiiYlfVqQFEgAUKoXqETCFPYyImzIByZT94MJEnoofO3KIBohvgPJGLz9+Aqd8fz6VTXjH8s4VYfK21x/WkHX1SHyotTBUjTaoMqdrizGPx6DM1weQdD29/vjInxLd4Ej0RIUlAuHSDgxBSJZt14dixAgnCEQwZp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746707064; c=relaxed/simple;
	bh=euuXHiLbWHlXdD01r1NgpXkzti+uOFQDaY5u0OFhkLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7O9hOZCkGVszzE+p0oXSET5sookNxbSPvaWspLMOjFFkvDtrFD+7FJ1lohVrTjMFGD8GXHs3YAT4xeF6t4KQiY3k7kVx2Bdl36F/rL6pw/fM/P6d5fhzIoaUIFmAC9etMKwvgESY3Y0ir6BkCDxGYDPyVdQTZuDTMeIDI0PSlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bo+NAqAs; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54b09cb06b0so1133749e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 May 2025 05:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746707061; x=1747311861; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bYq9UdbXkspTJzU3jmebisflnUZ0+YdudwLiQZEMhwo=;
        b=bo+NAqAscalhccSn5X2VMDJQU1TebCb06glaJ29SYdh0pZWajib7W0W1YR2VadQ5To
         4M+RKzEmAxsY4OnyR+Q0In75uxXx9Wj/kG8veOU8aTDaTpAzKPZTY/+IWCRhmNr6lW1O
         B4UmqWKgjfaxSVUN7PumAAkz8bCMeCZbAK0uCfTVWUPJpuwyopkzyDriS2xcrHl0J+Ow
         qV41ECuC4VGKl0RJBmY1A+grJpKykHl/2AlLTg+kArMfw2CWzKnGkDfLeUWhJxcKGGaW
         xlOQK4KydOLyvCobV8uiW5XQXvubvPbRBi+uqRjJrsUMtzlYzDyK0b4cg/jldBJ7fKwN
         4U9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746707061; x=1747311861;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bYq9UdbXkspTJzU3jmebisflnUZ0+YdudwLiQZEMhwo=;
        b=ubHGHbrMwPBofTv/HyweY1uwGlsgoOEvQb9lNGgwUOH5VXVgd5GjA+XyxRWVQ9mTeo
         PMKZaLxhFzXj5V3/c/bgD6BGVZdjFKQS3PqRuCT3KjiGXZT3BOnCG3/zcBHLrGFHhxwD
         mPsTeTZRbOhjawPfgqFf1EURgo1NDk1QbRyYt3lfMcwIZHMZ+pMsw+KsEJP1S5QtBoaF
         Jfhsd6wBtSe+PKCSjODSNAPVORlozU0B2kgsyZOZbYfPX9ALQ/7Z26Hak1kio8ySlO9W
         P7aR2aFgMfb8KviIkiQzSVvr/hZajXgOT8m4/S/IEuR7FwIzxMVDdy6UNlCSr0XYK6Jb
         LnhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDgB9+i8gah6LW8uRQM3TAA6p+BFNpzSfCSmgSoPurw7F2HflvJxqAxMbkzEqCJbzI11Nco6BZbHj016Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyf4a34RCOWdsxAJQOLtnBpHOfCgSu/nCl6miB//NEqob16SMT
	U50pDlvrZaA0MNgKpTceSFx7UxW4JFxPgzG8qx7UCUn6VHB1dthpmpQUmml3GWe34Zyo+Fg+ps5
	EpQX8mahhQyBSlyZ0K2ExS1p3J2CTcdqRIX5zJu5n7uvu3tRSiLBR9JE=
X-Gm-Gg: ASbGnct9JaFO53qHr7rusamVsU3i99hMnlMGXgh0UUAvHlpdJzRcld+mZogUz54cbFe
	mdXeYZYS6aZuCkygEkdd4xN2qf1Fv9QC1iwvRjtoLNIiH059AtcSvzIhM//eF/UKYZeZ2zwQGgf
	8WJFtJ3OWgGX6faZCMqXO9DuPluFn1DJi7n89DxyjgduRjXSAT1oUu
X-Google-Smtp-Source: AGHT+IHPoJzLIhtFpzN/1sdhJyeU+LjrmCDNcg6Q3CdDJNa61d9LsaQZ5H7HHpgfMKAjEBI/JJxSi01QEQ+VLyZX92Q=
X-Received: by 2002:a2e:a10f:0:b0:30d:e104:b67c with SMTP id
 38308e7fff4ca-326b890cc7fmr11091271fa.39.1746707060441; Thu, 08 May 2025
 05:24:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250503003620.45072-1-namhyung@kernel.org> <CACT4Y+Yr7vffLYG+YmyB=9Vn_oxdQqR_6U4d-_WeQoOtPXZ6iw@mail.gmail.com>
 <aBmei7cMf-MzzX5W@google.com> <CACT4Y+ameQFd3n=u+bjd+vKR6svShp3NNQzjsUo_UUBCZPzrBw@mail.gmail.com>
 <aBmvmmRKpeVd6aT3@google.com> <CACT4Y+bm4gCO_sGvEkxLQfw8JyrWvCzqV_H5h+oebt8kk1_Hwg@mail.gmail.com>
 <aBm1x2as1fraHXHz@google.com> <CACT4Y+aiU-dHVgTKEpyJtn=RUUyYJp8U5BjyWSOHm6b2ODp9cA@mail.gmail.com>
 <aBvwFPRwA2LVQJkO@google.com>
In-Reply-To: <aBvwFPRwA2LVQJkO@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 8 May 2025 14:24:08 +0200
X-Gm-Features: ATxdqUGsP-cGz5xol7t0MUfWkbJwMTGTSs06jyX6wDkhPuAbKmxfVW9d0Ia1KLE
Message-ID: <CACT4Y+YacgzrUL1uTqxkPOjQm6ryn2R_nPs8dgnrP_iKA9yasQ@mail.gmail.com>
Subject: Re: [RFC/PATCH] perf report: Support latency profiling in system-wide mode
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 May 2025 at 01:43, Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Tue, May 06, 2025 at 09:40:52AM +0200, Dmitry Vyukov wrote:
> > On Tue, 6 May 2025 at 09:10, Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > > Where does the patch check that this mode is used only for system-wide profiles?
> > > > > > Is it that PERF_SAMPLE_CPU present only for system-wide profiles?
> > > > >
> > > > > Basically yes, but you can use --sample-cpu to add it.
> > > >
> > > > Are you sure? --sample-cpu seems to work for non-system-wide profiles too.
> > >
> > > Yep, that's why I said "Basically".  So it's not 100% guarantee.
> > >
> > > We may disable latency column by default in this case and show warning
> > > if it's requested.  Or we may add a new attribute to emit sched-switch
> > > records only for idle tasks and enable the latency report only if the
> > > data has sched-switch records.
> > >
> > > What do you think?
> >
> > Depends on what problem we are trying to solve:
> >
> > 1. Enabling latency profiling for system-wide mode.
> >
> > 2. Switch events bloating trace too much.
> >
> > 3. Lost switch events lead to imprecise accounting.
> >
> > The patch mentions all 3 :)
> > But I think 2 and 3 are not really specific to system-wide mode.
> > An active single process profile can emit more samples than a
> > system-wide profile on a lightly loaded system.
>
> True.  But we don't need to care about lightly loaded systems as they
> won't cause problems.
>
>
> > Similarly, if we rely on switch events for system-wide mode, then it's
> > equally subject to the lost events problem.
>
> Right, but I'm afraid practically it'll increase the chance of lost
> in system-wide mode.  The default size of the sample for system-wide
> is 56 byte and the size of the switch is 48 byte.  And the default
> sample frequency is 4000 Hz but it cannot control the rate of the
> switch.  I saw around 10000 Hz of switches per CPU on my work env.
>
> >
> > For problem 1: we can just permit --latency for system wide mode and
> > fully rely on switch events.
> > It's not any worse than we do now (wrt both profile size and lost events).
>
> This can be an option and it'd work well on lightly loaded systems.
> Maybe we can just try it first.  But I think it's better to have an
> option to make it work on heavily loaded systems.
>
> >
> > For problem 2: yes, we could emit only switches to idle tasks. Or
> > maybe just a fake CPU sample for an idle task? That's effectively what
> > we want, then your current accounting code will work w/o any changes.
> > This should help wrt trace size only for system-wide mode (provided
> > that user already enables CPU accounting for other reasons, otherwise
> > it's unclear what's better -- attaching CPU to each sample, or writing
> > switch events).
>
> I'm not sure how we can add the fake samples.  The switch events will be
> from the kernel and we may add the condition in the attribute.
>
> And PERF_SAMPLE_CPU is on by default in system-wide mode.
>
> >
> > For problem 3: switches to idle task won't really help. There can be
> > lots of them, and missing any will lead to wrong accounting.
>
> I don't know how severe the situation will be.  On heavily loaded
> systems, the idle task won't run much and data size won't increase.
> On lightly loaded systems, increased data will likely be handled well.
>
>
> > A principled approach would be to attach a per-thread scheduler
> > quantum sequence number to each CPU sample. The sequence number would
> > be incremented on every context switch. Then any subset of CPU should
> > be enough to understand when a task was scheduled in and out
> > (scheduled in on the first CPU sample with sequence number N, and
> > switched out on the last sample with sequence number N).
>
> I'm not sure how it can help.  We don't need the switch info itself.
> What's needed is when the CPU was idle, right?

I mean the following.
Each sample has a TID.
We add a SEQ field, which is per-thread and is incremented after every
rescheduling of the thread.

When we see the last sample for (TID,SEQ), we pretend there is SCHED
OUT event for this thread at this timestamp. When we see the first
sample for (TID,SEQ+1), we pretend there is SCHED IN event for this
thread at this timestamp.

These SCHED IN/OUT events are not injected by the kernel. We just
pretend they happen for accounting purposes. We may actually
materialize them in the perf tool, or me may just update parallelism
as if they happen.

With this scheme we can lose absolutely any subset of samples, and
still get very precise accounting. When we lose samples, the profile
of course becomes a bit less precise, but the effect is local and
recoverable.

If we lose the last/first event for (TID,SEQ), then we slightly
shorten/postpone the thread accounting in the process parallelism
level. If we lose a middle (TID,SEQ), then parallelism is not
affected.

The switches from a thread to itself is not a problem. We will just
inject a SCHED OUT followed by SCHED IN. But exactly the same happens
now when the kernel injects these events.

But if we switch to idle task and got no samples for some period of
time on the CPU, then we properly inject SCHED OUT/IN that will
account for the thread not actually running.


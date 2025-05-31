Return-Path: <linux-kernel+bounces-668957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B38EFAC9993
	for <lists+linux-kernel@lfdr.de>; Sat, 31 May 2025 08:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83D091BA47C3
	for <lists+linux-kernel@lfdr.de>; Sat, 31 May 2025 06:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D722F20E033;
	Sat, 31 May 2025 06:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bUKubEWP"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4FDEAD0
	for <linux-kernel@vger.kernel.org>; Sat, 31 May 2025 06:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748673083; cv=none; b=Rba6ZdJFm7VhYMmznC7sdZNroZVb6PwpyYY+SgH3mTePJwM/MLVV1CulIr0z6HnxzR2h3GHWTBlVKMpgR3byEMPeBEYa4zZ2LSscFHdoiLy8TIyLfEL5hV/mGRnDdan89LpwWX//BvRADuDdb4QISXA6iWWolCrSeQmUKRLn8k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748673083; c=relaxed/simple;
	bh=CoXc0dCTOqLMCSZiQCdApcQAWyCSGk0wug+xWpDaT0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nAoOij45FvUBT9H/VAD2JTfPfhXVoEF+3dciGIodZ/6c38f2kHmjT8UwZrqsrnmIj4nnF9PWgMN4+fL3XRFRhka2Vb0Vd50lTqDk0n4yau+Pi//7eR9anYyJXod5stxSxp8naKE065yACNoo8xc4pdGmjEBXBHzB/Aaqrhhmydk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bUKubEWP; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-31062172698so27970011fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 23:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748673079; x=1749277879; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wWFXw3UdeTmdyAQraXFf2yqqkKSC8Rgoldk84MrVeHA=;
        b=bUKubEWPFBycap9GfZ9dW2SJIFpcEbAYCWQbDmN9mRK0SNG2mT2DZJP+a9ZPsBe/yX
         POJkfEdI0H5WKPJRh6aanNGWAzihWaFbM2eK4cuggMH2DH/sqHl88Y8gJsqEsv9IdSCP
         leTnxz45/eaVhL6Y7jC2dLsDUX4yhc51EufN5oPPLOoxgtSXpTXAK8V33gRLOl1uK+rs
         4r+5kOiU+WsrTugKJ9MlVWDyEpRns9oVKqf0N/eLZH82iiXOxuaKmlhuxpT8K2VT1ba9
         SBkF92rNQ4pGEf8rig8ZgPQ65W8tYddQUQ85w6DhpUBOfK0Zc+B7S7eMrU/+n202t9la
         +h4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748673079; x=1749277879;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wWFXw3UdeTmdyAQraXFf2yqqkKSC8Rgoldk84MrVeHA=;
        b=UDtu15ajaj0vJ/J3aDObeglUcTU/wc4yzi4C7b5tIM67afr9SmHMkA+ZhozZhabKJj
         mgUX65lCadlOiStOXQVPwxS5/8E76S7ykayJ6Ontc9pIVz8f8YiuzlSvHKGNiicyDnwL
         lwrSzOPcn6b5rwtj0IYnsLjwsVx2FcOQVv2pbh6hOTG4xi/PclShpZleetIRCw3CdyRd
         5X+gsAx2ES3MeqMbSOdx3nKgXdIRK07w8FilQeLZBKEv7RF2Tjk4aVgLWopQzPEV8enO
         y8iQYugDudqXZzjV3AFlNUSFvlbGM8857ualJg0p/zZU6pTzIYdyEhC7QIPNTy0XgiK7
         PRpA==
X-Forwarded-Encrypted: i=1; AJvYcCXg7XqPYwmG0HQVumR22doY5KH64cXQYdlpUmNBz1db2Son2hJvSCFTTsS2+qjlZrFOBPNgLkln4fCwZTk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8X+DiQws0seDaWN29AYrzDKzeeh56/300y0kcPBoTbEIuT5/m
	EXfMpiLdRAYSm1UKuWVrjFi3RBZUpe0eub0oWI0EBMeBhFVbpuhtYVt8v6Zm45KpZOHhoW9segt
	vIwnGBJ5IrOpdfUV0NyKU6z/proWa6C0eOglWeDCh
X-Gm-Gg: ASbGncsPJ2jvSNq+CLHRpEWRwSlJRVqKxFcy5uNoGWbxe544JFxojaez30TUNP0NQsZ
	yvNds/Ya2xwZbGifALvHy4FP92sgZOE5R2pHy8mLbfKZzga97ztbhFU0cUTVI4fIoVJg6pEt1oi
	CKfA/jWVAc4uLwGTULQhtBUg6m03vrGElfrwC4ma6w0uF6l8jrrGHYyD1rCV+kcmxptJ/FFqYX8
	kbt
X-Google-Smtp-Source: AGHT+IHdLWbK7BMIbV54SHtKp6nI8Lx6kIibmwBh1RypY+YX9tUCTbr5mxcKqccGQisd29DGMy40FlXzf8vMWGvDJ7M=
X-Received: by 2002:a05:651c:1470:b0:32a:88b8:9bb with SMTP id
 38308e7fff4ca-32a9e9ce1c1mr2742301fa.11.1748673079299; Fri, 30 May 2025
 23:31:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACT4Y+YacgzrUL1uTqxkPOjQm6ryn2R_nPs8dgnrP_iKA9yasQ@mail.gmail.com>
 <aCdo6Vz2MVv3N0kk@google.com> <CACT4Y+YHxXjCU2jySTUO5kH=xC8scdzTTuP2qEBc5zMber44Aw@mail.gmail.com>
 <aCveO4qQGy03ow5p@google.com> <CACT4Y+YdnQebkGTQJ9yhLs2j12WBYk2ReiBAq5cE+wtu1RRU5A@mail.gmail.com>
 <aC0HH45JCBTchZMc@google.com> <CACT4Y+apAJ_m9W=P2hsGvWrGZnTzxB+9qgJg=ujjU8OWCVcUoQ@mail.gmail.com>
 <CACT4Y+Z3Bbn3KcwhjOYAmzHWqRSZ4ywCrw8FNNxj5MrDUzFtVg@mail.gmail.com>
 <aDdYEH3lIYHAB-lk@google.com> <CACT4Y+Y=1aXG_25ONnfD4TxMbsrnW3uFOOL9yrcP+LYeh4pHpg@mail.gmail.com>
 <aDormwKnOYm_-Jgs@google.com>
In-Reply-To: <aDormwKnOYm_-Jgs@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sat, 31 May 2025 08:31:07 +0200
X-Gm-Features: AX0GCFviC7XJS3BaHNpqUb4Z5Ty9Rd3yiY1UkSqSOuXvQPCVo1G2J50a8_DnJ94
Message-ID: <CACT4Y+Z4Yr_jNV56NvdiJeUzMDmubFL5BtkACDXWaTGxZC2deg@mail.gmail.com>
Subject: Re: [RFC/PATCH] perf report: Support latency profiling in system-wide mode
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 31 May 2025 at 00:05, Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Fri, May 30, 2025 at 07:50:45AM +0200, Dmitry Vyukov wrote:
> > On Wed, 28 May 2025 at 20:38, Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > Hello,
> > >
> > > On Tue, May 27, 2025 at 09:14:34AM +0200, Dmitry Vyukov wrote:
> > > > On Wed, 21 May 2025 at 09:30, Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > >
> > > > > > Maybe we can use this
> > > > > > only for the frequency mode which means user didn't use -c option or
> > > > > > similar in the event description.
> > > >
> > > >
> > > > All-in-all I think the best option for now is using CPU IDs to track
> > > > parallelism as you suggested, but be more precise with idle detection.
> > > > 2 passes over the trace may be fine to detect idle points. I see the
> > > > most time now spent in hist_entry__cmp, which accesses other entries
> > > > and is like a part of O(N*logN) processing, so a simple O(N) pass
> > > > shouldn't slow it down much.
> > > > That's what I would try. But I would also try to assess the precision
> > > > of this approach by comparing with results of using explicit switch
> > > > events.
> > >
> > > It's not clear to me how you want to maintain the idle info in the 2
> > > pass approach.  Please feel free to propose something based on this
> > > work.
> >
> >
> > What part of it is unclear?
> >
> > Basically, in the first pass we only mark events as sched_out/in.
> > When we don't see samples on a CPU for 2*period, we mark the previous
> > sample on the CPU as sched_out:
> >
> >   // Assuming the period is stable across time and CPUs.
> >   for_each_cpu(cpu) {
> >       if (current[cpu]->last_timestamp + 2*period < sample->timestamp) {
> >           if (current[cpu]->thread != idle)
> >               current[cpu]->last_sample->sched_out = true;
> >       }
> >   }
> >
> >   leader = machine__findnew_thread(machine, sample->pid);
> >   if (current[sample->cpu]->thread != leader) {
> >     current[sample->cpu]->last_sample->sched_out = true;
> >     sample->sched_in = true;
> >   }
> >   current[sample->cpu]->thread = leader;
> >   current[sample->cpu]->last_sample = sample;
> >   current[sample->cpu]->last_timestamp = sample->timestamp;
>
> Oh, you wanted to save the info in the sample.  But I'm afraid it won't
> work since it's stack allocated for one-time use in the
> perf_session__deliver_event().

No, I just showed the algorithm. I don't know perf well enough to say
how to implement it.

> > On the second pass we use the precomputed sched_in/out to calculate parallelism:
> >
> >   leader = machine__findnew_thread(machine, sample->pid);
> >   if (sample->sched_in)
> >     leader->parallelism++;
> >   sample->parallelism = leader->parallelism;
> >   if (sample->sched_out)
> >     leader->parallelism--;
> >
> > This is more precise b/c we don't consider a thread running for
> > 2*period after it stopped running.
>
> IIUC it can make some samples have less parallelism right before
> they go to idle.
>
> > A more precise approach would probably be to consider the thread
> > running for 0.5*period after the last sample (and similarly for
> > 0.5*period before the first sample), but it would require injecting
> > sched_in/out events into the trace at these points.
>
> Yep, that will fix the issue.  But then how to inject the events is the
> problem.

Yes, but incorrect data is incomparably worse problem than writing a
bit of code.


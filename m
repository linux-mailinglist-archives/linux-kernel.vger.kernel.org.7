Return-Path: <linux-kernel+bounces-775942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5DFB2C6A4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 387EC3ABAC4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C61217723;
	Tue, 19 Aug 2025 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HBYBBqlg"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30412153D3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612528; cv=none; b=Ek0W1nUyBbgnQvg2McgatRNMDuP64tx9JdnHBFwolxfZtcrCq/eIQ754v7iCt7XD3gOiEH/sdEtIx3+YK7KWdsBb8HFlflHN+9+ZpMwcXMAeOQ0cZ8Gv538OrBKSU4nj2u2PaTlHgi0moVDbeU+Gx6OOlcNdTvWnrsakAmlYDQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612528; c=relaxed/simple;
	bh=YmKxBdkvufyyo8ZkIIj4RGzpR0abl6MPElpTI5WwpAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cDP6601Ki5WDpJQXHPiUKXqFjHatkT3ZRYOPJSyf2lSCgEmIvsSd1+9RH08D0WG92BUNrVP4hgwhjVa27FYZfxkcehS6dYKpMGcVHoZBug7SpmhSUcdhSd6KyViOxbuhwqEVSbC4zuvNK1o+s8hnct+D3gk0C4yIIjf/DMzIJR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HBYBBqlg; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so714018366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755612524; x=1756217324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmKxBdkvufyyo8ZkIIj4RGzpR0abl6MPElpTI5WwpAs=;
        b=HBYBBqlgoEmRHI0wVl33fVOq9j9PNKqphkT5LnMgRC4gTPD7YwWxGvLRM5mJGaeSAs
         Ix35hjqlsnN8du0iX3xLtQwWCs6cTMQCLDp50QIKWxKvqI2Cjx59h6IkLMKic2LlI5T2
         VhVMH/Yu9SV7oNooAUhQRDEojFujtrDFvCrh5aqjFSsOqLM3IyFTZhkthFTWgdc3EITW
         f+Xcw2gOO/vGzNYmLuFBfX0isQF1IeKtKoyBZ1hZjbF8hwYtcpdFyuJu2uQ9W8cFJ5KX
         /yMje55ECs9SSMgpoUEEq+lN6xr4tgKhg9YKHTUuOdvn63mDK3NCqPkQCussys0+BHji
         y5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755612524; x=1756217324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmKxBdkvufyyo8ZkIIj4RGzpR0abl6MPElpTI5WwpAs=;
        b=droXuVwuw6E9tJPtSxWKPMeGpDDGb39DuvEWq6zERvJ3hY3ZG1mb/syTWVoyzpb9U7
         nfPz9wCTMVyXJJUxFcUPEzKh2qf+euw131PJ0gk/+/Zynjo5LoU/1ANAcZtWMUuNiq36
         yuC75x3ruTxLS9YsG0fj+4NfN0k+JRVBs7uADVOIP43c9aKziqpmCWs1+VdQX3sXfvtb
         GRwUgcKGEQpT890cD9770dDDdI+BezsAIrq/WTe49BqZi8jR/FLocqHMad+Qb30SxXhK
         sPIH85FRLeOYEzrJCW18dZa7BMB7yGFD+icuf4xRrYmQN/3tmORvY53/nHZXPY+oN6tK
         J7Gg==
X-Forwarded-Encrypted: i=1; AJvYcCVPM1ygGDH5pQt+Fu0+hlojzMxMu1hmjFpRJiWfpaDS9FLbojXBCOfhqBGFitQnvZPebalgfUlmW0Yn4fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRUvFYmzGiXFKkuwzFsG0pvwGSBUtRCkR/YAsbUOs/WYcWJV5/
	yn7qlgfD2Pba/eJzmuodH5Xb45YXjmIzrMVyD2aE7W3U93eE7Pe1zlcHDXw9fx4ADr2FgMQkhkE
	ZzFHZENvZgHpRk3Y6fHJXWrRtEv4pf2XiD8Ttqbdy
X-Gm-Gg: ASbGncuU2RBkACM8oG+Eq8OpguimzqDs2l6Ca39NiY44LS0c3RRcbTvHS3aJXZqEpR6
	XRfyvYLvIrLdnEA4BKAa2OOvIX3qmggDU9VPqt1yr8MyMRjRLYexJoMBhVIiapnzG5l4KsqzaoE
	deNuyBy0s2oCgjN3jAOTH97F4yefzlfKVJgVFTAmfluycqXNwvd1cpw4KWs2xNMJUap6ImOsMTi
	dYNpQqwLEU6H0m6i5/HtY4j25T5psZCBCOuKFycd2FP
X-Google-Smtp-Source: AGHT+IFw28CWZF77aFR19foUdm87rfZFzM+buPcAajoGabJZvk5r1emAswxpDbQ2lVWuu5ol35ADCS8hFuS4ILkqQhE=
X-Received: by 2002:a17:907:969f:b0:ad8:87a1:4da8 with SMTP id
 a640c23a62f3a-afddcb710ebmr245729666b.14.1755612523906; Tue, 19 Aug 2025
 07:08:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808200250.2016584-1-jpiecuch@google.com> <20250811083609.GB1613200@noisy.programming.kicks-ass.net>
 <CABCx4RDTq6x5=dqiROM6GYU21heaCYwOkerUxvf9ENaEM3+BtQ@mail.gmail.com> <20250814145308.GB4067720@noisy.programming.kicks-ass.net>
In-Reply-To: <20250814145308.GB4067720@noisy.programming.kicks-ass.net>
From: Kuba Piecuch <jpiecuch@google.com>
Date: Tue, 19 Aug 2025 16:08:32 +0200
X-Gm-Features: Ac12FXwSZCVf9iEDGvR0gJhDS6FDMw0sBFvARpr4IZKvPrxz3f-WlY6KkKdVzGA
Message-ID: <CABCx4RC2e09tUYC+B025MC0oHMrifJdax=n=8Q8mLmuF=bW4MA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] sched: add ability to throttle sched_yield()
 calls to reduce contention
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	joshdon@google.com, linux-kernel@vger.kernel.org, 
	david.laight.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 4:53=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Aug 11, 2025 at 03:35:35PM +0200, Kuba Piecuch wrote:
> > On Mon, Aug 11, 2025 at 10:36=E2=80=AFAM Peter Zijlstra <peterz@infrade=
ad.org> wrote:
> > >
> > > On Fri, Aug 08, 2025 at 08:02:47PM +0000, Kuba Piecuch wrote:
> > > > Problem statement
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > Calls to sched_yield() can touch data shared with other threads.
> > > > Because of this, userspace threads could generate high levels of co=
ntention
> > > > by calling sched_yield() in a tight loop from multiple cores.
> > > >
> > > > For example, if cputimer is enabled for a process (e.g. through
> > > > setitimer(ITIMER_PROF, ...)), all threads of that process
> > > > will do an atomic add on the per-process field
> > > > p->signal->cputimer->cputime_atomic.sum_exec_runtime inside
> > > > account_group_exec_runtime(), which is called inside update_curr().
> > > >
> > > > Currently, calling sched_yield() will always call update_curr() at =
least
> > > > once in schedule(), and potentially one more time in yield_task_fai=
r().
> > > > Thus, userspace threads can generate quite a lot of contention for =
the
> > > > cacheline containing cputime_atomic.sum_exec_runtime if multiple th=
reads of
> > > > a process call sched_yield() in a tight loop.
> > > >
> > > > At Google, we suspect that this contention led to a full machine lo=
ckup in
> > > > at least one instance, with ~50% of CPU cycles spent in the atomic =
add
> > > > inside account_group_exec_runtime() according to
> > > > `perf record -a -e cycles`.
> > >
> > > I've gotta ask, WTH is your userspace calling yield() so much?
> >
> > The code calling sched_yield() was in the wait loop for a spinlock. It
> > would repeatedly yield until the compare-and-swap instruction succeeded
> > in acquiring the lock. This code runs in the SIGPROF handler.
>
> Well, then don't do that... userspace spinlocks are terrible, and
> bashing yield like that isn't helpful either.
>
> Throttling yield seems like entirely the wrong thing to do. Yes, yield()
> is poorly defined (strictly speaking UB for anything not FIFO/RR) but
> making it actively worse doesn't seem helpful.
>
> The whole itimer thing is not scalable -- blaming that on yield seems
> hardly fair.
>
> Why not use timer_create(), with CLOCK_THREAD_CPUTIME_ID and
> SIGEV_SIGNAL instead?

I agree that there are userspace changes we can make to reduce contention
and prevent future lockups. What that doesn't address is the potential for
userspace to trigger kernel lockups, maliciously or unintentionally, via
spamming yield(). This patch series introduces a way to reduce contention
and risk of userspace-induced lockups regardless of userspace behavior
-- that's the value proposition.


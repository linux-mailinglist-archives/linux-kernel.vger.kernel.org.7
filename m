Return-Path: <linux-kernel+bounces-778116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79406B2E187
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8EBC584402
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A69322741;
	Wed, 20 Aug 2025 15:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jjcB5c87"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C603F320CCC
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 15:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755704987; cv=none; b=KWu22zoRqHjFVhcyq6qLzm9sBxOoixFVaQxCutWG3wA5FsFLAnu7ky6/ZpCIuL8yBk6YLkZZv54JwjN8PZvquI+EUCzcM7jAJdtk6vJfMCNb+8tLwZHB8l0+5PYebP8kXTJqYzYOG7JoQP4y4Y4fcCtkBG3RWj6ipvobAlXNT5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755704987; c=relaxed/simple;
	bh=cSj9TEAGDAwKpnOFUoGQVT7Q/M3530peytn4UFe5Z+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rEZD+jabmA1B6/mo36gz3/IoNhqfcWBSZLAoxYnoGtBgdfBhR0QOTfpArhbXucplI40AzemGiVVYKjb+j2SX/eSKt1uQyV3/ZXe9Is+Ina7XJRfIF8mEd67VTnCOjnLYcwdLt4nfugyENyrOJo1atTPK4uzX8wo6JpBwJxCcqIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jjcB5c87; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61a8b640e34so91231a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755704984; x=1756309784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwTo+n9iwb6eQLcMTMNvUsVJ2caoKtYPecozCLXntmM=;
        b=jjcB5c87D8Q2o3FcDurqhSybs9MmaGW8tjY+DgKqHbEXawpuf0BIzWDtot2AiipSnq
         pvikh4H91RnxY/LYWjqmiOZXYCZmYliC7X4NiHlfYeR5xENDY02/Dao7XzG2rSZHZuvU
         StpW/vJKv8GBd0J+NJ5RWF9OFrrwXSLdM915jHtUY3PkVLSOCI+gePTzLN04nr9F5GiM
         0og6xlFFU94frHzg1j1mCKFeBNpdpZ1geSLM7YUZ8L1aRuqFcxSKhZ/OvXEUiLfbBxhp
         aNzLzn0jsBQke7JKwSBFejscnG91rbl5OQ2rTgeXuFlAUvjM+WrQISiVcmCTNDvUpyIz
         PGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755704984; x=1756309784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwTo+n9iwb6eQLcMTMNvUsVJ2caoKtYPecozCLXntmM=;
        b=a63M3spueV91nYrfWbCHPTOo2ikkzEFdTNdKGLXOBwJTBVWDZ7cI0PIhX2Nl1LnBF2
         j0EnqEkAIomr3c9HcDZ4zL3aZwko0AFMFzf06JGL5usY4hL4XraqTqEz3s/bF2brp0Pt
         aZeQnumW+mSuKT78aP80MgjXI8Eovx23SkYgQBRSIuvWMbLquLNbMlnIXV1kywsqeKCi
         6XeP6O4AjAzh8BMKCVhZO2+/LBlvamY2tbZb6TJkH3q8SqYiI4ZaQU8Ucm6onmcQa3Lc
         HVL1jj+ZoxJ3/tmceP6AG0TGSlcYLjGwlx7cYvzGkYoQkF3o4YKKUESgu3C/ap7405n1
         zRBg==
X-Forwarded-Encrypted: i=1; AJvYcCWdS4Oc3cFsz1KwqYKs+JDDWLCw81bdoqYU6i+lCRHtigguE3F0McxzASGY0siyipuBXMKtKkU25fmR8Cg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/GkygianbvyaJKT0qviCIB07tPacHmZYcgf+fc5gX9CMlCPMf
	xy62rhofs/yd3KexXCrV7Oz7nPKyRnsg3YCVxUS145IwWEvreflkIcPiOlBQxPkqSjplKPxTMfh
	5sv+ipTCpV36w3Jp3Myz6YPwZJ/45qqNQcvnxkxVyjlFRKKT6VWjyGwAR7Qc=
X-Gm-Gg: ASbGncty2TrjPGXsg0mffS73jKNPj3aV1DnFf5Tw9TfZ4U5ig0kOPFvlA3MCAXO6Nnv
	UD3lmorEDNEKZsrn2KzrLsagYSYZRPMDGaDIXHObQ0QOYr5z7bQU/XzA4JRhakG2vZrEk3zqa2p
	99395lHgWh4vf0g6Znt40qVDW5AXOSrSiEaJh2I3J/oR4BVS1GOq4ZLWJ4t5YEEShOIwNAznCGk
	FNMMie4e4bl5un5u0wdH2fgxnp1RattFJqV0k3tFDf37OYYcHLumy0=
X-Google-Smtp-Source: AGHT+IG0ZqOUdyH4lo/ZKmY/36GuMPjIVrplHbH7L8St+eNufeCVziT1yQjnDxHQSBAzqkkqfE0Z9fvDjMwp5Ehw4VQ=
X-Received: by 2002:a05:6402:3806:b0:61a:3236:22b5 with SMTP id
 4fb4d7f45d1cf-61a97824c9cmr3021802a12.25.1755704983876; Wed, 20 Aug 2025
 08:49:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808200250.2016584-1-jpiecuch@google.com> <20250811083609.GB1613200@noisy.programming.kicks-ass.net>
 <CABCx4RDTq6x5=dqiROM6GYU21heaCYwOkerUxvf9ENaEM3+BtQ@mail.gmail.com>
 <20250814145308.GB4067720@noisy.programming.kicks-ass.net> <CABCx4RC2e09tUYC+B025MC0oHMrifJdax=n=8Q8mLmuF=bW4MA@mail.gmail.com>
In-Reply-To: <CABCx4RC2e09tUYC+B025MC0oHMrifJdax=n=8Q8mLmuF=bW4MA@mail.gmail.com>
From: Kuba Piecuch <jpiecuch@google.com>
Date: Wed, 20 Aug 2025 17:49:32 +0200
X-Gm-Features: Ac12FXwWoB3L0g3j2l18D_XaooNZpSj_q1dpIcOdAh1nx-vl7t9usZ1Mrb90HgA
Message-ID: <CABCx4RDbxy+htBEF=cNGyv3ZYJ6bJrF735fmPdO5bW3YDNaFKA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] sched: add ability to throttle sched_yield()
 calls to reduce contention
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	joshdon@google.com, linux-kernel@vger.kernel.org, 
	david.laight.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 4:08=E2=80=AFPM Kuba Piecuch <jpiecuch@google.com> =
wrote:
>
> On Thu, Aug 14, 2025 at 4:53=E2=80=AFPM Peter Zijlstra <peterz@infradead.=
org> wrote:
> >
> > On Mon, Aug 11, 2025 at 03:35:35PM +0200, Kuba Piecuch wrote:
> > > On Mon, Aug 11, 2025 at 10:36=E2=80=AFAM Peter Zijlstra <peterz@infra=
dead.org> wrote:
> > > >
> > > > On Fri, Aug 08, 2025 at 08:02:47PM +0000, Kuba Piecuch wrote:
> > > > > Problem statement
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >
> > > > > Calls to sched_yield() can touch data shared with other threads.
> > > > > Because of this, userspace threads could generate high levels of =
contention
> > > > > by calling sched_yield() in a tight loop from multiple cores.
> > > > >
> > > > > For example, if cputimer is enabled for a process (e.g. through
> > > > > setitimer(ITIMER_PROF, ...)), all threads of that process
> > > > > will do an atomic add on the per-process field
> > > > > p->signal->cputimer->cputime_atomic.sum_exec_runtime inside
> > > > > account_group_exec_runtime(), which is called inside update_curr(=
).
> > > > >
> > > > > Currently, calling sched_yield() will always call update_curr() a=
t least
> > > > > once in schedule(), and potentially one more time in yield_task_f=
air().
> > > > > Thus, userspace threads can generate quite a lot of contention fo=
r the
> > > > > cacheline containing cputime_atomic.sum_exec_runtime if multiple =
threads of
> > > > > a process call sched_yield() in a tight loop.
> > > > >
> > > > > At Google, we suspect that this contention led to a full machine =
lockup in
> > > > > at least one instance, with ~50% of CPU cycles spent in the atomi=
c add
> > > > > inside account_group_exec_runtime() according to
> > > > > `perf record -a -e cycles`.
> > > >
> > > > I've gotta ask, WTH is your userspace calling yield() so much?
> > >
> > > The code calling sched_yield() was in the wait loop for a spinlock. I=
t
> > > would repeatedly yield until the compare-and-swap instruction succeed=
ed
> > > in acquiring the lock. This code runs in the SIGPROF handler.
> >
> > Well, then don't do that... userspace spinlocks are terrible, and
> > bashing yield like that isn't helpful either.
> >
> > Throttling yield seems like entirely the wrong thing to do. Yes, yield(=
)
> > is poorly defined (strictly speaking UB for anything not FIFO/RR) but
> > making it actively worse doesn't seem helpful.
> >
> > The whole itimer thing is not scalable -- blaming that on yield seems
> > hardly fair.
> >
> > Why not use timer_create(), with CLOCK_THREAD_CPUTIME_ID and
> > SIGEV_SIGNAL instead?
>
> I agree that there are userspace changes we can make to reduce contention
> and prevent future lockups. What that doesn't address is the potential fo=
r
> userspace to trigger kernel lockups, maliciously or unintentionally, via
> spamming yield(). This patch series introduces a way to reduce contention
> and risk of userspace-induced lockups regardless of userspace behavior
> -- that's the value proposition.

At a more basic level, we need to agree that there's a kernel issue here
that should be resolved: userspace potentially being able to trigger a hard
lockup via suboptimal/inappropriate use of syscalls.

Not long ago, there was a similar issue involving getrusage() [1]: a
process with many threads was causing hard lockups when the threads were
calling getrusage() too frequently.  You could've said "don't call
getrusage() so much", but that would be addressing a symptom, not the
cause.

Granted, the fix in that case [2] was more elegant and less hacky than
what I'm proposing here, but there are alternative approaches that we can
pursue. We just need to agree that there's a problem in the kernel that
needs to be solved.

[1]: https://lore.kernel.org/all/20240117192534.1327608-1-dylanbhatch@googl=
e.com/
[2]: https://lore.kernel.org/all/20240122155023.GA26169@redhat.com/


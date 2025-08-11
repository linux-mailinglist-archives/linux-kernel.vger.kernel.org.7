Return-Path: <linux-kernel+bounces-762738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DECB20A69
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4C8171385
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035D02D2390;
	Mon, 11 Aug 2025 13:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V5+TYzps"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943AB21CA1F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 13:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754919350; cv=none; b=Ind47+jAShPrwg1BAvlKM/cNLjiIM4rk1gcNPYcbY4IJSMYare4TYfN1c0rK4ipxTyqzpZeGeYwB6L6dW5z+NtVJ573PcN+Z2vwMSs4vlZFasdi2TCB4886zp3ID7TcNEHe3GeMHGfasALLexF9FGtL6C37itonjExghp2ZDqU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754919350; c=relaxed/simple;
	bh=NOLlylZjzQUb9xKJx2Hx2JTobj/7UiKnvpVXU7FIVaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bj6iuwpUerIKKmtA739WDQcj0zXQnbCv3MX5YWMZ8lTYwPaWiqRZZcOjy6kETmqGDJwrNX40ONpvD8XjErp6fFt/hWHO43J5rKIlflchJQxcTdttZ/9a3Kh/0q4x+kwaxAj7YLEchiKkQxS/D2RuZw524wbqE0+ajZeOoEOrvbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V5+TYzps; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-af93381a1d2so701998766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754919347; x=1755524147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOLlylZjzQUb9xKJx2Hx2JTobj/7UiKnvpVXU7FIVaU=;
        b=V5+TYzpsM83XZNgIaZPoTilrdG9hE+Pogldsx03uxPN+By2WC9IZFyKKifX0/Kzctu
         ghqxuFxjkbcbN8mr2y780n6l8aOGP6Ju2HDm5H+9Np/v4khZw5N+fzr5TF0LXzkTuVwl
         pFsqpDJQW2Owb/i50CToe3NI6JJU4o8bZBWWkqRNeRUSvuIPTTFShMm129t1/Lkb2p3J
         wCXBI/IP1QXl5HxMpcHRgHSdJISboGoe4N+bKO7HU1mGLVd4hMuTMkDVDJGiT5vklQkr
         IqIWpdmG0llYIcxE3MDrZxfLJaO0+tDrcXGoU63cdqMlRv0AQ9nmCUwj3fNzsA3YHMKv
         dETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754919347; x=1755524147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOLlylZjzQUb9xKJx2Hx2JTobj/7UiKnvpVXU7FIVaU=;
        b=rSZZIepaKhDw/Zm2CsrsCcVHZGbzj8ZbmV7QXHAWle8am7K2wJBVNMjwnFxulVH1+X
         zTy16BlmNtWu1xRez1xITKuQ95HFWcSbQEkJM8isRcvYxcQLgPEOtH1UFfxkzij1pTpc
         6QU2Gszi6g20SMYKkHk48fr7EYUs3GwzuxabkI1VPJ6el6BeVmm1P9Y3qj21Ty4GM6uX
         PvDimlvZ4ABwAkSVxWrqSmaTnFuSROnd8HhP8TOtH7cHQPfHj8A6MXXUU4txNW7uN3mO
         8OT+wT4CgWodPYmyeSjhBINGGh9i2BBLkeTyuh36pzVSGBvjuf1N7nSoQC3JFa224tzq
         LVhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5EVYtcfzjZODZROLJNxMr3LWucsJWojTF65cdZcDnjNFqS690WPmWweefE4ESL8d4Z20+9Vc2NzkBBgU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5IvviR62HYRaAHMbSFK/1098Bjj/kRr3iR75cYsq+ELoNLPHz
	eDv0dR9FajmCjZQDxSefw0w7Cm7aev9/l50wT3K1JZf5EaRk6I8EPDaIftk3cXUDgpvCNqRJaTQ
	SFfkVsgSuTZ3W1TKs5APUlEKuA5kCUGASovzP7Hpx
X-Gm-Gg: ASbGncsKAJqzuOVoKCiH0TkMirkvM0uabJQ85c6NaN+zBtF8mc624lXkxLjXFe3vDgz
	a6cYx1Yd8t1g3Jmc2lZSJ4FhF7oG2tG12X/zwws1RjsFrchH3dpAcDWkJ3RT1pFiIpLBd87ZA3Q
	KOVHY7Wd79r7ufPJzmVUKNJVe5HcSTtXfupU636z1y9VKCGtcxnQeCw3o6mB8emLkrsgRtAqo9V
	6cyRDt2RB+TwtdGOfkgNOpZy+q10yhS1+gxfA==
X-Google-Smtp-Source: AGHT+IEMtjza3TqJyxfAJQyh/g//yT0fd/jmtnJvyR6WS2pLIzy4wk0OcH9xcPI9BD7giTYgWv7HB5G+dXSRgt0snm4=
X-Received: by 2002:a17:906:4787:b0:af9:2002:c18a with SMTP id
 a640c23a62f3a-af9c6373b46mr1283907966b.16.1754919346635; Mon, 11 Aug 2025
 06:35:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808200250.2016584-1-jpiecuch@google.com> <20250811083609.GB1613200@noisy.programming.kicks-ass.net>
In-Reply-To: <20250811083609.GB1613200@noisy.programming.kicks-ass.net>
From: Kuba Piecuch <jpiecuch@google.com>
Date: Mon, 11 Aug 2025 15:35:35 +0200
X-Gm-Features: Ac12FXxK4ZD6s-7VYdbjoueF6PsaOpuLOwBBRHilnnM34Pojh_ruezo5yGtwTLw
Message-ID: <CABCx4RDTq6x5=dqiROM6GYU21heaCYwOkerUxvf9ENaEM3+BtQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] sched: add ability to throttle sched_yield()
 calls to reduce contention
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	joshdon@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 10:36=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Fri, Aug 08, 2025 at 08:02:47PM +0000, Kuba Piecuch wrote:
> > Problem statement
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Calls to sched_yield() can touch data shared with other threads.
> > Because of this, userspace threads could generate high levels of conten=
tion
> > by calling sched_yield() in a tight loop from multiple cores.
> >
> > For example, if cputimer is enabled for a process (e.g. through
> > setitimer(ITIMER_PROF, ...)), all threads of that process
> > will do an atomic add on the per-process field
> > p->signal->cputimer->cputime_atomic.sum_exec_runtime inside
> > account_group_exec_runtime(), which is called inside update_curr().
> >
> > Currently, calling sched_yield() will always call update_curr() at leas=
t
> > once in schedule(), and potentially one more time in yield_task_fair().
> > Thus, userspace threads can generate quite a lot of contention for the
> > cacheline containing cputime_atomic.sum_exec_runtime if multiple thread=
s of
> > a process call sched_yield() in a tight loop.
> >
> > At Google, we suspect that this contention led to a full machine lockup=
 in
> > at least one instance, with ~50% of CPU cycles spent in the atomic add
> > inside account_group_exec_runtime() according to
> > `perf record -a -e cycles`.
>
> I've gotta ask, WTH is your userspace calling yield() so much?

The code calling sched_yield() was in the wait loop for a spinlock. It
would repeatedly yield until the compare-and-swap instruction succeeded
in acquiring the lock. This code runs in the SIGPROF handler.


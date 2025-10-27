Return-Path: <linux-kernel+bounces-872325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AADE0C0FEF9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 903044E5F4F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8413191BF;
	Mon, 27 Oct 2025 18:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CzTzYsmR"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47306FBF
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 18:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761590184; cv=none; b=d9xplThUB6AvIop+13/7x928e/xO8BtbccG0CNXJlDXtqoJfFzDrgmIrU+nvrkyV/yrzkdUeh8bXU19Dd4XVG6Y2EL4r6I+xnmeXq5sirhAWaGb0QVS6rAVplovZR+ENqZ+IZ3QSR3wc35FDs/hDzNmUiSQfbNsyjHYra+8R6DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761590184; c=relaxed/simple;
	bh=ZOwRdq5M1dlQoQp9lG51OLqKoqkwMBEDLxwqQawgzXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ufjB18JQtOA96RChBmJGQWU1E7u69QBC3EWy4LM7R7TOYsTjP2HP3i4StdV5TyFXXg6YQSRup0LIZogogQF3PvxkAf7DD6gF42LHILXGZjqfAt4IKUkIyJTXQjWBiEhNhZVN8Lz2EjHCYFZ/3UUE1yHPFDvXVn4fA1rI5YYhmmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CzTzYsmR; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4eccff716f4so53041cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761590181; x=1762194981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xq6G+u7Mv77qfaJS2gzpOCja2SPSkCLWRcJsgep2UA=;
        b=CzTzYsmRWOtPiQ1D8CgK6JzyCw3MWyhcqebPMKOA5XWIT1/Y6GtCb0SGR+FVwpQ44b
         ir0JfNl99leoM/ytHiZrQR5aMOPo8DH1tbnTzv6tPkmqXpGp6N2rjyelSXazgFIe7dQP
         YHDixlXJHO8as17QbP4CAgje5dPU/fZyMYzG7mzsT6Ih4v+4ALIfrywr/7vdKl7DP0Qa
         c0/F5E+gKvvUOcDfedeZQaT2Cz0Z/hBQIkNwV4JnpciJO08q7B8KWy7j/Ry6E8KTNCoM
         D9PRl9swH0vEW99Ti0ZO1KeH5B0PhjTDgH5NajWDm3fuT1irgB24PIyP9ngXMU2FujWG
         pLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761590181; x=1762194981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1xq6G+u7Mv77qfaJS2gzpOCja2SPSkCLWRcJsgep2UA=;
        b=P44cjRjpQNF5z+WrChGwLILp5Y20qc+WpRbNRxdRBMcckEYRIJNoi3HtzGqfjVbxt6
         KZyGyd/rQTPLa5gtxMx+lo0mOw6j9IHEK6B72Dda+c4Ro5EgwMVLKCmJfxghuVuTET5L
         6944D1cR7sWGlbI+nJlJ/RQueoK0v8zKp01o6e1TBaRd61mXY2sWNDARiRkSTqJHjWgH
         oE3v6MMctX8Gic6eMWWkpSPCsHnYD6wH9EagUeTk7TIye77Y92fPTY8ti3r9duwwiP3Z
         htPryuRHnjtMLvOO6aVVVM8oH02hFxSsFlppAHOoJW2osb+eWpMmVblHMZ4uxDCNTi0Z
         VuRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMmb8F2oxk1X0B/YSrt5aSf7jaSqVzNGMXBtFVe11X/tMVVrPIEdk9KYXhXd1K+xBM+CKkOWQZN4PMGg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLcRalQJcejuhxHwm8bIf61lb3/0iEkB0FX0Zh1lYKfjIATDIu
	jyYTqq76+lh/+bSFNOqkQX7vi/HVlR8x8m0CvJiwCYyIBJh0K6xbZcVgBeUz6QCrqOVK6N0QSGf
	6P5iOaUi4d3FUd3toMISuqIwi3lfjq+j+KdgkHfOB
X-Gm-Gg: ASbGncsiT/7t3nMGXwXwsl3QHUzT4+CmQDkOOCIA4wdciFuM78x9UyvBPQ6bE1TNI0M
	+CYCIIGkKIBGmzP7AAZ6sELN+X6zzx27LCtrxtFRgHE9ydrARRfhCm6wQY59+40EdCWqYTRH+Vw
	FNFs7WkHGwTvjfLeM9loZi34Q299Uf7Z7t9NNUZ6+PMQxDnPowvAijPuMpDG660GrZeR8UDLSNL
	8VvbU4fMSFqee+CUFpRQaQtqGfrS6U3+ezMLQDfuw9pHYKztbrD+K6ZxhRVhA==
X-Google-Smtp-Source: AGHT+IElpJjCAG8/FRUMHt7bqVIwzkE9VRWUkg0eb9I3Keo3gBEzc6H7MLuebBvjLENKbJ2B4lYx4d6kp0IWlmdw8rs=
X-Received: by 2002:ac8:7fcb:0:b0:4e8:b04a:82e3 with SMTP id
 d75a77b69052e-4ed08f1af35mr843001cf.10.1761590180483; Mon, 27 Oct 2025
 11:36:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <006c9df2-b691-47f1-82e6-e233c3f91faf@oracle.com> <28340138-a00e-47bc-a36f-270a01ac83b4@meta.com>
In-Reply-To: <28340138-a00e-47bc-a36f-270a01ac83b4@meta.com>
From: Josh Don <joshdon@google.com>
Date: Mon, 27 Oct 2025 11:36:08 -0700
X-Gm-Features: AWmQ_bmxfrHEy7fCuXVJiRa0yPduu_wqZu9H-9jpEHZmSss1dVZ2O2Z0pUpkbxw
Message-ID: <CABk29Nt6ovn0Ltsqx82X_nciQJemBvLimzi=0k+DN1BbJ3+R+A@mail.gmail.com>
Subject: Re: [REGRESSION][v6.17-rc1]sched/fair: Bump sd->max_newidle_lb_cost
 when newidle balance fails
To: Chris Mason <clm@meta.com>
Cc: Joseph Salisbury <joseph.salisbury@oracle.com>, clm@fb.com, 
	Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>, dietmar.eggemann@arm.com, 
	Steven Rostedt <rostedt@goodmis.org>, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Chris,

On Mon, Oct 6, 2025 at 2:25=E2=80=AFPM Chris Mason <clm@meta.com> wrote:
>
> On 10/6/25 4:23 PM, Joseph Salisbury wrote:
> > Hi Chris,
> >
> > During testing, we are seeing a ~6% performance regression with the
> > upstream stable v6.12.43 kernel (And Oracle UEK
> > 6.12.0-104.43.4.el9uek.x86_64 kernel) when running the Phoronix
> > pts/apache benchmark with 100 concurrent requests [0].  The regression
> > is seen with the following hardware:
> >
> > PROCESSOR: Intel Xeon Platinum 8167M Core Count: 8 Thread Count: 16
> > Extensions: SSE 4.2 + AVX512CD + AVX2 + AVX + RDRAND + FSGSBASE Cache
> > Size: 16 MB Microcode: 0x1 Core Family: Cascade Lake
> >
> > After performing a bisect, we found that the performance regression was
> > introduced by the following commit:
> >
> > Stable v6.12.43: fc4289233e4b ("sched/fair: Bump sd->max_newidle_lb_cos=
t
> > when newidle balance fails")
> > Mainline v6.17-rc1: 155213a2aed4 ("sched/fair: Bump
> > sd->max_newidle_lb_cost when newidle balance fails")
> >
> > Reverting this commit causes the performance regression to not exist.
> >
> > I was hoping to get your feedback, since you are the patch author.  Do
> > you think gathering any additional data will help diagnose this issue?
>
> Hi everyone,
>
> Peter, we've had a collection of regression reports based on this
> change, so it sounds like we need to make it less aggressive, or maybe
> we need to make the degrading of the cost number more aggressive?
>
> Joe (and everyone else who has hit this), can I talk you into trying the
> drgn from
> https://lore.kernel.org/lkml/2fbf24bc-e895-40de-9ff6-5c18b74b4300@meta.co=
m/
>
> I'm curious if it degrades at all or just gets stuck up high.
>
> -chris
>

Adding another +1 to seeing this regression (for us, it's with a low
level storage system).

Historically it has been difficult to tune newidle balance in a single
way to support multiple different types of workloads. I'm wondering if
it might make sense to put a sched feature on toggling the cost
scaling for newidle balance, or otherwise making the aggressiveness
tunable.

Best,
Josh


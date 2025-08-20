Return-Path: <linux-kernel+bounces-777145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72AFB2D5DE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D2DEA02E7F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631062D9498;
	Wed, 20 Aug 2025 08:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUEli+qR"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A302D8763;
	Wed, 20 Aug 2025 08:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677649; cv=none; b=EC1IQVt1vsNAYxwHg/I5xhu+1w6w4Swl/ZINUnwEzyt6j/k8Ys6CKIbbfFiA7kLjNwDXxbGYePaXVQpezPA54XdnHgZKOsjW58o3gAEV+bl7ZFYkvcROu/GccHM0Cp3mh71H8dD7m71U4ctEvYvRVEwWnCpPv/KJFTR8zzIGYZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677649; c=relaxed/simple;
	bh=ZpCtAzS4tzwuzApjtumUN65a/Suv8wxPH+MzhX7js1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uX83LOLyqbdTt/T395HghArUbmtE9kPsSHuGYM/j4U/NfFGZN+tlrBsfbGIoPL/BQ2ikOBx6O/W4NIxvpH+6wAQPpqo4s7+5HbnE6NrIYEO63sdjuKt9Yt1T3vVqS1cnRND96ARf6HxkKhyNp8f5mNufy2eBHvcQyX1bOj+SiF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUEli+qR; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3e67d83ee4bso1891745ab.1;
        Wed, 20 Aug 2025 01:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755677647; x=1756282447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHdHc+vgGOidBhtPb6TotK5pN0fo9oM/+Sw3uOBxNOQ=;
        b=MUEli+qRKeSF9n6Asfj3ArWbISbJPo/xBeFFmN+iHTNN0a4Vde3E3mXewrSa691qFG
         yLbxONEBsz4+63oWR0T9ytw1kkcUEtwPM3o//q7t3FO8vtppPb9fUPgzi+nPbylrrTNX
         itsw28itLA3bLyUjXLsOIbdurefN+OwlCplJiPJ0RLQIvDHg5Sn156sxkJXDSjWQKg+C
         ek5w7IBRGNE+K5BOa95yz48NUUlnsZf+N1GS4I4jZmZZTfxS/cHbkydEbv7qJBVI/wsH
         24IFCFdkRMiV5YAhTZphnZjfiS4tCRCXeGRTelXoV1go9Qb0B1/8bq4tqXam9nZx0AT6
         wd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755677647; x=1756282447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHdHc+vgGOidBhtPb6TotK5pN0fo9oM/+Sw3uOBxNOQ=;
        b=uTshnjWYTZO0I48s+nQl16jCwSAfJ757evhnTv/anxm8FlkvGYbOqRAuzdiSEsqO22
         Nba2yz1vXs7OyYYBxYTgrODNn/ysVB9s6J6C79rS5RqzSmBauBOpCO3DuaJs89bLI8o8
         uQ7VLwsTLbq+NTCYzssdmLRlmoFXIUW/oRnvMIwr+z8XcKTJ/hXmt1zB6vdlzSv7S2v4
         24PjPgbbCagXT8hu+edHzX4HN2AeVVyX9sjZvxV90ksrAskanclLkXtb5RKsiMWU1UsC
         Q77MyTsYpcdk8KJ5Jr7A75hWbnsqYp/Lb5xRELfRZn/IQvgSG3CPSymHCWPErul+m+yb
         asIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn4bakxe13Jj4Xzm5nOr4Sk6BPrkGyOoxVmsbsqf+vtERUyzzJQhFMRnD/xhAreql4tPAHjovmk3E=@vger.kernel.org, AJvYcCWIWY9Qpx8yaWRKrW8aB/Xj9Z393tt8XyEKPIPHQtROC0BRLKOcVuNfjZ7gIPUpo/uKyaE9vJ7UcApvqdUp@vger.kernel.org
X-Gm-Message-State: AOJu0YwpwAf2xEEuyLQyZoS4Y/6lKNthLKdFkbY2T8s07r/JZhFWUoR4
	F7s0T2NlrUB7d5pclX8ppN5wlsqGL2IpsyWgnfKaB0ddLNJVRa9pvm8nSkT+Nv6Y2Op/gv63if5
	x9MwVnu6pIofZDckkx+OxkX+Zc6uvLWw=
X-Gm-Gg: ASbGncsNKnC/74gC0WfWaSSX702lnpSJZIZ5foc6graC2Sph7YmYEP88rg0F8WXfOeT
	AkaalyjV/omsPsFnZ6ZWIY2ltbcVCdlhYyazo5z6zs1abIgAwUHOnqkHvfjljWFubrrayBPGSzi
	cFp03CxIVkzD0QLkREht+et4N4gzMY57t6BvswAsLv3a2raQQwQgnvqb1PgjkGAfL1pE3y3HUSe
	JE36y0Zhujlinmxiw==
X-Google-Smtp-Source: AGHT+IHCT2tGzbMXEdi3gemb6CiCmK8a60ILAjzEUkta7Borm89v7rF8AZTQkWnJv4wFfOqcg3xMPuu+rNrOCI9ulg0=
X-Received: by 2002:a6b:e90a:0:b0:881:81cb:57de with SMTP id
 ca18e2360f4ac-88471b1e791mr341650039f.12.1755677647382; Wed, 20 Aug 2025
 01:14:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819092739.GA31177@didi-ThinkCentre-M930t-N000> <20250819101411.GG4067720@noisy.programming.kicks-ass.net>
In-Reply-To: <20250819101411.GG4067720@noisy.programming.kicks-ass.net>
From: Tio Zhang <zyhtheonly@gmail.com>
Date: Wed, 20 Aug 2025 16:13:55 +0800
X-Gm-Features: Ac12FXyDvPHhpL6dkIODj_7Gvsy1T8HJ1e-pyafiHot7ZIFOA6SeRG-8-Np1zDo
Message-ID: <CAEQmJ=gwOBn5bTY0n1c1c1zu2Gk-peKERCzrW5i+S-4erd7y5Q@mail.gmail.com>
Subject: Re: [PATCH] delayacct/sched: add SOFTIRQ delay
To: Peter Zijlstra <peterz@infradead.org>
Cc: akpm@linux-foundation.org, wang.yaxin@zte.com.cn, fan.yu9@zte.com.cn, 
	corbet@lwn.net, bsingharora@gmail.com, yang.yang29@zte.com.cn, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mingo@redhat.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	jiang.kun2@zte.com.cn, xu.xin16@zte.com.cn, zyhtheonly@yeah.net, 
	=?UTF-8?B?5byg5YWD54CaIFRpbyBaaGFuZw==?= <tiozhang@didiglobal.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Peter Zijlstra <peterz@infradead.org> =E4=BA=8E2025=E5=B9=B48=E6=9C=8819=E6=
=97=A5=E5=91=A8=E4=BA=8C 18:14=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Aug 19, 2025 at 05:27:39PM +0800, Tio Zhang wrote:
> > Intro SOFTIRQ delay, so we can separate softirq as SOFTIRQ delay
> > and hardirq as {IRQ - SOFTIRQ} delay.
> >
> > A typical scenario is when tasks delayed by network,
> > if they delayed by rx net packets, i.e, net_rx_action(),
> > SOFTIRQ delay is almost same as IRQ delay;
> > if they delayed by, e.g, bad driver or broken hardware,
> > SOFTIRQ delay is almost 0 while IRQ delay remains big.
> >
> > Examples tool usage could be found in
> > Documentation/accounting/delay-accounting.rst
>
> accounting will be the death of us :/
>
> How do you account ksoftirqd ?

delay accounting should count delay within the task's own context,
so ksoftirqd should not be take into consideration in "SOFTIRQ delay".

When a task is delayed by ksoftirqd, the task is exactly delayed
by ksoftirqd's preemption, not softirq context:
---------------------------------------------------------------------------=
-----------------
              TASK A
    <runs in A's context>
    <IRQ context>
        | -------------------------------------------------------
        |              counts in A's IRQ delay               |
        | -------------------------------------------------------
    <SOFTIRQ context>
        | -------------------------------------------------------
        |              counts in A's SOFTIRQ delay      |
        | -------------------------------------------------------
     wakeup_softirqd
     preempted by ksoftirqd
     <A in rq waiting>
        | -----------------------------------------------------------------=
-------
        |  counts in A's CPU delay (A->sched_info.run_delay) |
        | -----------------------------------------------------------------=
-------
     ksoftirqd gives the cpu
     <runs in A's context>
---------------------------------------------------------------------------=
-----------------

So when ksoftirqd plays a significant role, we will FISRT see
SOFTIRQ delay increasing in task's delay, THEN see CPU delay
increasing.
We should always find out the task delayed by softirq.

Though not working in PRERMPT_RT (No IRQ delay but always CPU delay).

Btw, I did miss exclude ksoftirqd in irqtime_account_irq, will add in V2.


Return-Path: <linux-kernel+bounces-640215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 695F8AB01D0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 19:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 550683BC9FD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 17:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4303F21D3F9;
	Thu,  8 May 2025 17:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DOw85hl3"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58FE28688F
	for <linux-kernel@vger.kernel.org>; Thu,  8 May 2025 17:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746726702; cv=none; b=sENzLvq8G6b2q11vlfTlq1HcBOUOT2jDhu+yDOKZM+Vf6KkP9tihhbsWtIbSbqyiJqwkYncBLr9TtN0l5/IC5TDQXM9/P5HEk5gh859BC+uHxFXKew2tg/+Sy4BWoZo+yI2P8kjRql1OwF/ywY1AZc+mwNu2bii28cp8sumE00g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746726702; c=relaxed/simple;
	bh=9vAzFk3ej36C8l8EyjCCniQrUpBP+z4T56uDvNxUQm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GPm6UkFUj20UsiGOVqSKLzM0bl7CV79AvygnjGsk6mUL+D2pVc2ckQDypztcDGljuXPp4Seq7wBuwLXThjjmghJ9KT5Le3k28X5fwD6Va2y33APniNMC3rA+5ncHpM89ruuwflL/+sFDtXXXVWyyEjWUkYNB2AQ2v839jc22kXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DOw85hl3; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ace333d5f7bso215094466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 May 2025 10:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746726699; x=1747331499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vAzFk3ej36C8l8EyjCCniQrUpBP+z4T56uDvNxUQm0=;
        b=DOw85hl3AJ61w+hMVetrqM15WFIxyi6c5SkG/BUGeAdLUM49oEoxmBmQ3KbmzGitCe
         ImS9/9S9dH2fN6wz0WBe2t3IbyI8Lj9J4+9Ea2ShmG2rIkHSw/alcG+U6UrhDobsCvn3
         wCsPWd6s58h77KiZ7XvHvOoXaxBSXpysxmGNu2i7giheelUX8I4aQESYbXee67KjFepr
         0Afahb28Mq/VPWXvHBR+q2nLgxRJUOCDsGfQHwzbwzMFeYRN0cbGLW0a+EeqUckjfAlH
         4gzmKKnG9u6W7eHwBXQT8D17GIGRMwNhZxyA/EfzGUrCNETVFIjcow5Bhppt3Z/m7AGR
         hICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746726699; x=1747331499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vAzFk3ej36C8l8EyjCCniQrUpBP+z4T56uDvNxUQm0=;
        b=gDZ3NgJDECqzBylcKa5j1EPMUIbK5DPljkL5PO3qvpm5GK6vZBPvHzxosDKJM3AJ6x
         Vn/G4Q6bqIl7zkA6gmOOJxDft6CDpZgXN6Gy+tC3YFDqhbxzlb1I0N14EFTfa0wnSDWQ
         SHH1j4lKyNz44JrvPGTQ9OvMoubBYi2HY2xsQyn4+/iToFh2pnU2xuKzJTzJxyJPiq9Y
         cpEuj2vupCn06dyOi+pWbbWifHjyZ9aed2fdTvFItljh999l8OEUAqgb825cgdnJzcp9
         qH7t14jjmHvZYfYJyQlWr6j8Gucc2UYrZJb8I6M7qtc/VdKJLyUdoy5n8YiB2OazgyWx
         r1Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUNeTgrHvppDE3DeZjWGa5htZGEnaZC5CHwB30wLI/Ora+96GR1vMUFYKzgO307tbGLfBW15v7FQK+k5eU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFFasmunmL8zV1IHqITdNAlIvEr9dDoJq4aVa9r1g+4+OZneaJ
	NuErFbf2LdWNa1gW4jrGFYLLhFBhZW/KhPgZZBOG9GRuHvTzloL1D6e89OFPDMqYcpYvBcyb4MX
	UhTMTZ6DO3WQcEYCAr0kmzeumaPlJxxyP0lPi
X-Gm-Gg: ASbGncsEPGCrWtAU5lYnQylPE2jostAPnyc57ibW32x+RV7i1vNpn41s4PDTaPCRPsB
	/DyaDyF0NREmfUDVeWhmzbGNwXkIakB7l+FGrnUIdHuehtcF+EsP2qd13ewXqTJfPeoFG+1jDG8
	0XHAJhYNUMosoLv89V3FfCvMSgptIsl8OKV+ugTSf4zpGKzQA8RZbRnw05
X-Google-Smtp-Source: AGHT+IFiG34ocNaePZQu/GwsnHYMExr9loCqHISwhlhRSjlrs+ftDtZwnqSmiOG2ytHr2NPo/xMxS/swhzKAA8M9jhY=
X-Received: by 2002:a17:907:97d6:b0:ad1:fa32:b608 with SMTP id
 a640c23a62f3a-ad219170628mr57695466b.42.1746726698675; Thu, 08 May 2025
 10:51:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506183533.1917459-1-xii@google.com> <aBqmmtST-_9oM9rF@slm.duckdns.org>
 <CAOBoifh4BY1f4B3EfDvqWCxNSV8zwmJPNoR3bLOA7YO11uGBCQ@mail.gmail.com>
 <aBtp98E9q37FLeMv@localhost.localdomain> <CAOBoifgp=oEC9SSgFC+4_fYgDgSH_Z_TMgwhOxxaNZmyD-ijig@mail.gmail.com>
 <aBuaN-xtOMs17ers@slm.duckdns.org> <CAOBoifiv2GCeeDjax8Famu7atgkGNV0ZxxG-cfgvC857-dniqA@mail.gmail.com>
 <aBv2AG-VbZ4gcWpi@pavilion.home>
In-Reply-To: <aBv2AG-VbZ4gcWpi@pavilion.home>
From: Xi Wang <xii@google.com>
Date: Thu, 8 May 2025 10:51:26 -0700
X-Gm-Features: ATxdqUGmHNfwE-8VkB6qpw0w9vEhgm8bSSonqkVq6btmJis37oJqz-zs928L9ro
Message-ID: <CAOBoifhWNi-j6jbP6B9CofTrT+Kr6TCSYYPMv7SQdbY5s930og@mail.gmail.com>
Subject: Re: [RFC/PATCH] sched: Support moving kthreads into cpuset cgroups
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, David Rientjes <rientjes@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Waiman Long <longman@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Dan Carpenter <dan.carpenter@linaro.org>, Chen Yu <yu.c.chen@intel.com>, 
	Kees Cook <kees@kernel.org>, Yu-Chun Lin <eleanor15x@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	jiangshanlai@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 5:08=E2=80=AFPM Frederic Weisbecker <frederic@kernel=
.org> wrote:
>
> Le Wed, May 07, 2025 at 01:07:16PM -0700, Xi Wang a =C3=A9crit :
> > On Wed, May 7, 2025 at 10:36=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote=
:
> > >
> > > Hello,
> > >
> > > On Wed, May 07, 2025 at 10:23:24AM -0700, Xi Wang wrote:
> > > > Overall I think your arguments depend on kernel and application thr=
eads are
> > > > significantly different for cpu affinity management, but there isn'=
t enough
> > > > evidence for it. If cpuset is a bad idea for kernel threads it's pr=
obably not
> > > > a good idea for user threads either. Maybe we should just remove cp=
uset from
> > > > kernel and let applications threads go with boot time global variab=
les and
> > > > set their own cpu affinities.
> > >
> > > I can't tell whether you're making a good faith argument. Even if you=
 are,
> > > you're making one bold claim without much substance and then jumping =
to the
> > > other extreme based on that. This isn't a productive way to discuss t=
hese
> > > things.
> > >
> > > Thanks.
> > >
> > > --
> > > tejun
> >
> > Yes this is still serious technical discussion. Frederic made several "=
we can't
> > have b because we already have / are working on a" statements which wer=
e not
> > very actionable. Deducing to a particular case is a quick way to simpli=
fy.
>
> I referred to a particular case (isolation) because you said this is your
> usecase. You still haven't explained us why the current affinity manageme=
nt for
> kthreads doesn't work for you.
>
> > I'd prefer to focus more on higher level technical tradeoffs.
> >
> > Overall compartmentalization limits resource (cpu) sharing which limits
> > overcommit thus efficiency.
> > cpumask restrictions are not ideal but sometimes
> > necessary. Dynamically configurable cpumasks are better than statically
> > reserved cpus.
>
> For which usecase?
>
> > I do think the cgroup tree structure sometimes helps and we don't have =
to use
> > it for all cases.
>
> Also kernel threads are special beasts, even some !PF_NO_SETAFFINTIY kthr=
eads
> have actual affinity preferences. If they can go through cpusets, this mu=
st be
> dealt with. And admins will need to know about those affinity preferences=
 for
> each kthreads.
>
> Also do we want to be able to expose all the cgroup limits to kthreads? E=
ven
> if only cpusets is allowed to have kthreads, does cpusets.mems make
> sense to be exposed for example?
>
> If your issue is ever resolved through cpusets, this will have to be main=
tained
> forever with all those subtleties in mind.
>
> I tend to think that CPU isolation is a very straightforward cpusets usec=
ase:
> no load balancing, NULL domains and tasks usually don't compete much for =
the
> CPU since the point is to not be disturbed anyway.
>
> And NULL domains already exclude kernel threads, dynamically. So please g=
ive
> us a compelling reason for doing this.
>
> Thanks.
>
> --
> Frederic Weisbecker
> SUSE Labs

I think our problem spaces are different. Perhaps your problems are closer =
to
hard real-time systems but our problems are about improving latency of exis=
ting
systems while maintaining efficiency (max supported cpu util).

For hard real-time systems we sometimes throw cores at the problem and run =
no
more than one thread per cpu. But if we want efficiency we have to share cp=
us
with scheduling policies. Disconnecting the cpu scheduler with isolcpus res=
ults
in losing too much of the machine capacity. CPU scheduling is needed for bo=
th
kernel and userspace threads.

For our use case we need to move kernel threads away from certain vcpu thre=
ads,
but other vcpu threads can share cpus with kernel threads. The ratio change=
s
from time to time. Permanently putting aside a few cpus results in a reduct=
ion
in machine capacity.

The PF_NO_SETAFFINTIY case is already handled by the patch. These threads w=
ill
run in root cgroup with affinities just like before.

The original justifications for the cpuset feature is here and the reasons =
are
still applicable:

"The management of large computer systems, with many processors (CPUs), com=
plex
memory cache hierarchies and multiple Memory Nodes having non-uniform acces=
s
times (NUMA) presents additional challenges for the efficient scheduling an=
d
memory placement of processes."

"But larger systems, which benefit more from careful processor and memory
placement to reduce memory access times and contention.."

"These subsets, or =E2=80=9Csoft partitions=E2=80=9D must be able to be dyn=
amically adjusted, as
the job mix changes, without impacting other concurrently executing jobs."

https://docs.kernel.org/admin-guide/cgroup-v1/cpusets.html

-Xi


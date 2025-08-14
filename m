Return-Path: <linux-kernel+bounces-768496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B84AB26199
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61331892748
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC01C2F60A8;
	Thu, 14 Aug 2025 09:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQokmL5m"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7C02F60A0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755165141; cv=none; b=gLHXiG5sJKen6JFtx7cAjavLjfRwktJHgmdUOAAfGd9RiN+HdLPvPbRCJqPfiUi2NKnObTUEqMlUPkzve5VuHrTyDriVfr/HkJ3HXWYdi2YR/hr3VNlcpeS3s4n/nLu+P7YqFp93g0kete63lBCsodF3lxVec/H8uW+87l0llm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755165141; c=relaxed/simple;
	bh=B3ZrqvxvM/ZQiT0DjVwHog/5nuP7h5z28xQs7YB0NQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5NCz33jZ1vO0eSY6aB94SVFuKxCgUuXaqnF/QoMO1mgRvqZNGGRQTdLM/QuNYFgejywudvMeW1RGfC40dLl9nh3cmDQky/Im2loAKvyPJJXrGWsviRJ/Yok7ONP49zGNs1gReL1rsr/0PcU9BEvM/k9IErQPKfPkCITADzdzPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQokmL5m; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b109912545so8373151cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755165137; x=1755769937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPiLD8ykj7DoY53h0B06TC3SvyYRiKt2OXcQb142PrE=;
        b=GQokmL5mBzcz2Zt+Do4bqmvovwHR296hshFZZjfd72vrOyT+tGG3rT3RliR+Z1qeJJ
         GbduIof4kh3L7xzXds9TVkGBjNlLlFuH4eiZlibHqfqbv3SOVIgFJksSfbtNxkExff0j
         H1jacCbp9ays9I/qpjCai90yYf8u2/HzM5cGSb/G0gO3BIT+zHKavT6NJ1L7R4c8q+RD
         dcyOSdfae0DY8TAwHPxyrsbbs0Bh92nFnGB3W8qwzndo3aCW8rTV78HNALqWKTTo8wk4
         GLDoO4cZJuBzU80yAqPHwUwcG5wOBJSKunhJ5izSO4jeV6Dh1flkJdTtKiRxWahmY1eF
         7AOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755165137; x=1755769937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPiLD8ykj7DoY53h0B06TC3SvyYRiKt2OXcQb142PrE=;
        b=kMVIpokHgEnj7R6p/wNtFxCcaH0xC79CuQGsO7iT3d1YP1SiB6gBxBXg86FqcmU2Gf
         Rl80CRbD52I5VxrB6cTB9A8OQ5IstUMS7NJAYMvBAcUgYWGhfe5f3tM5dpkURkVNWsJT
         njKSvbXdR1aVzX8sXPotqPbFU5Q715toabKs0TqK0EopQV35ZvQrKOzN4yRrWlOfxdTu
         HYoD26fVtrEejnNcDWcUvCOOmz7FXKe9jUbDbtBAoPwmjWfqGAdzTA8cjoh/wW+lCmqX
         ZrDroUe5R19TGSSCeswPL7lDS5SU7dWgwEZhOQlepBa/L30UX8TmIkEcVCjk05lCKb13
         O5NQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzRI/jVvnro87kmUKE3vhPFTBMYZahEDD8CdqnQ4I06qgsacSXT/SdF67mX+xTF5znobcf1iJB9+3V2Wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA4cFFEQHUgRfefgN73eagDoVHA0Mqh3SNFGZUjgWxYUodbY22
	xKa/B7DQ3JL2/3Kbxn3CQZyfmwG8yCu3zWjQElTgEpfCkSWs89djlEpLbz7NNJYKqYdOwTO2V4D
	9jiuYxfYPmaBqRIfAkyEFeHmVWSLyvD27ZZff
X-Gm-Gg: ASbGncumWYnnmSh2ZrFEKPWwnyaca88JuBgpOwnYdI+YA4JaiXXB0MXfsgcWJ+F2KZT
	uM8+Y0Mhiq1qCQyMoenRDETunDonJX0PDN4oRu2RM8p5M8SzArFf7Ybv/rkvLhfF0DKDoUqz358
	kfxrhOJw7l9mw3KRL1QgFlBFI0twlamFOk79w4FgUVTGR9zp3GMgx4gWKAklgJKPY4RbloAXCVJ
	Kp2961UId9ijs58f3K2iYtxOz4MkA==
X-Google-Smtp-Source: AGHT+IGR9hE0y5k0De6WQ5U5xxibY6CumY+hM2bGX2zOWrdTtkzcJlyqoWvWqLBs9QZKAFZJhIz/SnYpzAWcyzggZ7M=
X-Received: by 2002:ac8:5d52:0:b0:4af:1cd4:d782 with SMTP id
 d75a77b69052e-4b10aab6eddmr41977531cf.45.1755165136898; Thu, 14 Aug 2025
 02:52:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812093339.8895-1-xuewen.yan@unisoc.com> <cf7847e4-78a6-4286-baba-60ace0c3d507@arm.com>
In-Reply-To: <cf7847e4-78a6-4286-baba-60ace0c3d507@arm.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Thu, 14 Aug 2025 17:52:05 +0800
X-Gm-Features: Ac12FXx6YYeLwJJwTekS1Tg2nd3jDTeRASoqt0xnwTCXqawfhAuCSVbttZa2tFU
Message-ID: <CAB8ipk9BDzsTTcdRKc9R_Hc72cOY8YyUfrCoY3_9hPJ8D-Fg_Q@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/feec: Simplify the traversal of pd'cpus
To: Dietmar Eggemann <dietmar.eggemann@arm.com>, Christian Loehle <christian.loehle@arm.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	vdonnefort@google.com, ke.wang@unisoc.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dietmar,

On Thu, Aug 14, 2025 at 4:46=E2=80=AFPM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
>
>
> On 12.08.25 10:33, Xuewen Yan wrote:
> > Now we use for_each_cpu() to traversal all pd's cpus,
> > it is in order to compute the pd_cap. This approach may
> > result in some unnecessary judgments.
> > We can simply calculate pd_cap as follows:
> >
> > pd_cap =3D cpu_actual_cap * cpumask_weight(pd_cpus);
> >
> > Then we can AND pd'scpus, sd's cpus and task's cpus_ptr
> > before traversing, which can save some unnecessary judgment.
> >
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > ---
> >  kernel/sched/fair.c | 14 ++++----------
> >  1 file changed, 4 insertions(+), 10 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index b173a059315c..e47fe94d6889 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8330,18 +8330,12 @@ static int find_energy_efficient_cpu(struct tas=
k_struct *p, int prev_cpu)
>
> Just a thought ...
>
> for (; pd; pd =3D pd->next)
>
>   cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);    <-- (1)
>   cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
>
>
>   if (cpumask_empty(cpus))
>     continue;                                               <-- (2)
>
> Can you not mask cpus already early in the pd loop (1) and then profit
> from (2) in these rare cases?

I do not think the cpus_ptr chould place before the pd_cap calc,
because the following scenario should be considered:
the task's cpus_ptr cpus=EF=BC=9A 0,1,2,3
pd's cpus: 0,1,2,3,4,5,6
the pd's cap =3D cpu_cap * 6;
if we cpumask_and(pd'scpus, p->cpus_ptr),
the cpumask_weight =3D 4,
the pd's cap =3D cpu_cap *4.


> IIRC, the sd only plays a role here in
> exclusive cpusets scenarios which I don't thing anybody deploys with EAS?

I am also wondering if the check for SD's CPUs could be removed...

Thanks!
>
> >               cpu_actual_cap =3D get_actual_cpu_capacity(cpu);
> >
> >               eenv.cpu_cap =3D cpu_actual_cap;
> > -             eenv.pd_cap =3D 0;
> > +             eenv.pd_cap =3D cpu_actual_cap * cpumask_weight(cpus);
> >
> > -             for_each_cpu(cpu, cpus) {
> > -                     struct rq *rq =3D cpu_rq(cpu);
> > -
> > -                     eenv.pd_cap +=3D cpu_actual_cap;
> > -
> > -                     if (!cpumask_test_cpu(cpu, sched_domain_span(sd))=
)
> > -                             continue;
> > +             cpumask_and(cpus, cpus, sched_domain_span(sd));
> >
> > -                     if (!cpumask_test_cpu(cpu, p->cpus_ptr))
> > -                             continue;
> > +             for_each_cpu_and(cpu, cpus, p->cpus_ptr) {
> > +                     struct rq *rq =3D cpu_rq(cpu);
> >
> >                       util =3D cpu_util(cpu, p, cpu, 0);
> >                       cpu_cap =3D capacity_of(cpu);
>


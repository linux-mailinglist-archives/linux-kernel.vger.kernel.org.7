Return-Path: <linux-kernel+bounces-848167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D951EBCCC9A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 13:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD281A6240C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 11:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5C32857F6;
	Fri, 10 Oct 2025 11:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOFlzOEg"
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042701E7C12
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 11:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760096254; cv=none; b=hHugXnVCGGu284kYN8NascrixmepiYe3ms4zjnjIqcur8pkJHtDC3bYk9ouTicu9r1qsDCORf43M2knTvnf29LSjuevevUa9tRAbIKt6rEjp5jG2BnMZtHqmH2vvwVEbBg/K2Dxw+GPGTuc28ny0NVMlAQqAdyvRYF3KJbcGEfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760096254; c=relaxed/simple;
	bh=tu7CHFcv8NXWSg1jXKb9aylTFPPW+h9hgce2xBf6Y9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LjIZ8NO/SucgAD04AaR7aalFZhuqExOhV1CBjB2SJfU/rDbIIgb2JHcKiFNZ0OHX/lPmyHM+V+A+0vFLzjaOd7G4SQDqxmmUzzW1zbansI9K6fACjHZjSJAjP/Ueqhx1Np2CMvMJpQWPfc7eS38IMgw8eR85/BdwsLldC2Tl28Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOFlzOEg; arc=none smtp.client-ip=209.85.208.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f193.google.com with SMTP id 38308e7fff4ca-36a6a3974fdso20620421fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 04:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760096251; x=1760701051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/XA7NS0vsEk3cN/YAVwXXOlWiiJ4B+of+ksUnO/7Z0=;
        b=IOFlzOEgDZUePc/JRbkmDAPwbZLzrcGUyz0Ng6NZWqbKJbkgAi69cCl23XOCUfNLC7
         Z+BiH9e3kJOPXUx/OrVSZs51+r7rBddbfG98SIX+Dv5+JpO5Onc6e8Em+V44sYzhf7FV
         e/Cbl5W2jcrmVaEtCr8yy4rnz3O5qvRiRxdAS9dHfOn0JLUfzy4z8+bTZVApGQ1CqyhL
         AzrJiv/Lu7h7U8v4jOa/QKx4Zta7HnTWoqj2D3XUibSbS6/wRJhnRsuCcCflI988D8Vs
         c5PxfNenqIzhZXG1Z1nSko1ZwmXXCoeFSD6Q2siEL3s/Sa/Ehf2aHqy9nVqfvCRyBb8e
         vvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760096251; x=1760701051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/XA7NS0vsEk3cN/YAVwXXOlWiiJ4B+of+ksUnO/7Z0=;
        b=nMXQ5BID9gMfsAm2nRo1NCRfwsKoTTo89u+iSyPUTju6ESVCtw3C80JzirHBmFDfhc
         R6uBUVZcFArJtHMUv8FGMb0CHj8ijxlkT7YsK2Trd+y7F71N97GhrLf34oDyR8NBB+lH
         2O5O9Q1A0zTiS6iHYbRMZXwwgsIVhGWerX2KjZ7doqdOOS1/u/QDQJbu/5T5Y++G5Wx8
         Rc2HdIQ620k2akD28a8tWEnfVJ+dmG/S0YMYnEAExpwvw9GkN2y/xaubSlk1d4+3JiLe
         vDbo0/nMglAWbxoC8dQE+njPfd0KqPp+MtAqnnyY563aZnlofTB6BLiP7Uz2HZWMeLqe
         AU4w==
X-Forwarded-Encrypted: i=1; AJvYcCXq5HDoMhUG7wrkqYjGprAY41X7NwB1UG2SmhuwDzx5OEU2uWsCs54jBh8jOBAEqmtgzTTpjm/H/ZMSGAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6a/IvABkz7G/OkasK6v3PJ2rliPpNFcGvFRM8wvOgAyE8GsME
	ui6aqC5g1b2jv9qrAggnx67P2++deRvrXM2z2/C6VmjazEFahdPo1AyxSOXajb0q4rc/vov+3Vk
	amc5oQoog/wysMv0EREekAEE6HzU+qRs=
X-Gm-Gg: ASbGncuDjxkyklWq4qTMIeA8DcZ3halmGyePoGwv4exw2OyvrnJ3LTK10h0KF26GNo1
	90DkmBTIV4s0UYxW0bBO9HT1GxgYC8KCwwXpE5i4di7S+CbgOeAtunUzVPhISduxZCqyTOawbkd
	vDpMwKFvsgfIjYjqTZAxkEB3o2a1cBwHAH6F7Ig8tfEkP9dRCl60BNZ7xpbSoiysysV304R3xbb
	Iioi6SVPhCN5fzzgbKsE83IhyzdKPNcwvvbpQ==
X-Google-Smtp-Source: AGHT+IHWoeDLCNVK8GZgZ3+ysWCGWbA3Vq7KFs0ot0ItXSxvUIF+xrvo0wUOe61rwPf1xrvjcr4elJgfRKWfCRpEwjY=
X-Received: by 2002:a05:651c:1b96:b0:375:db6e:fac9 with SMTP id
 38308e7fff4ca-37609ee9960mr25670741fa.31.1760096250825; Fri, 10 Oct 2025
 04:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910084316.356169-1-hupu.gm@gmail.com> <1081f8ca-3c1b-46fe-a7d4-31303e5e2298@arm.com>
In-Reply-To: <1081f8ca-3c1b-46fe-a7d4-31303e5e2298@arm.com>
From: hupu <hupu.gm@gmail.com>
Date: Fri, 10 Oct 2025 19:37:19 +0800
X-Gm-Features: AS18NWDsaBQOalzBU5G47pMRnXvggtjx21-grwMceLfF7cYweXjgG0czRoJVADI
Message-ID: <CADHxFxQTGRHuu82YK25UCcF2NCxyU_HrFik-jKY23eUMTfft7Q@mail.gmail.com>
Subject: Re: [RESEND][RFC] sched: Introduce removed.load_sum for precise load propagation
To: Pierre Gondois <pierre.gondois@arm.com>, vincent.guittot@linaro.org
Cc: peterz@infradead.org, juri.lelli@redhat.com, mingo@redhat.com, 
	rostedt@goodmis.org, dietmar.eggemann@arm.com, vschneid@redhat.com, 
	bsegall@google.com, linux-kernel@vger.kernel.org, mgorman@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pierre Gondois,
Thank you very much for your reply, and I=E2=80=99m sorry for getting back =
to
you late as I was away on vacation recently.

On Tue, Sep 30, 2025 at 3:46=E2=80=AFPM Pierre Gondois <pierre.gondois@arm.=
com> wrote:
>
> Hello Hupu,
>
> On 9/10/25 10:43, hupu wrote:
> > Currently, load_sum to be propagated is estimated from
> > (removed_runnable * divider) >> SCHED_CAPACITY_SHIFT, which relies on
> > runnable_avg as an approximation. This approach can introduce precision
> > loss due to the shift operation, and the error may become more visible
> > when small tasks frequently enter and leave the queue.
> >
> > This patch introduces removed.load_sum to directly accumulate
> > se->avg.load_sum when tasks dequeue, and uses it during load
> > propagation. By doing so:
> >
> >    a) Avoid relying on runnable_avg-based approximation and obtain
> >       higher precision in load_sum propagation;
> (runnable_sum =3D=3D load_sum) is not exactly accurate anymore since:
> static inline long se_runnable(struct sched_entity *se)
> {
>      if (se->sched_delayed)
>          return false;
>
>      return !!se->on_rq;
> }
>
> So obtaining load_[sum|avg] from the runnable_avg signal seems compromise=
d.
>

I agree with your point that when a task is in a delayed state
(se->sched_delayed =3D 1), it still resides on the runqueue and
continues to contribute to the load_sum, but no longer contributes to
the runnable_sum.

Moreover, based on the mathematical relationship, it is also evident
that the two are not equal. As analyzed in my previous email, for a
given se:

    runnable_sum =3D decay(history) + contrib(running + runnable) * 1024
    load_sum =3D decay(history) + contrib(running + runnable)

Here, decay() represents the decayed contribution from history, and
contrib() represents the new contribution from the running/runnable
state. Due to the difference in these formulas, estimating load_avg
from runnable_avg is inherently inaccurate.


> It is possible to compute load_sum value without the runnable_signal, cf.
> 40f5aa4c5eae ("sched/pelt: Fix attach_entity_load_avg() corner case")
> https://lore.kernel.org/all/20220414090229.342-1-kuyo.chang@mediatek.com/=
T/#u
>
> I.e.:
> +       se->avg.load_sum =3D se->avg.load_avg * divider;
> +       if (se_weight(se) < se->avg.load_sum)
> +               se->avg.load_sum =3D div_u64(se->avg.load_sum, se_weight(=
se));
> +       else
> +               se->avg.load_sum =3D 1;
>
> As a side note, as a counterpart of the above patch, the lower the nicene=
ss,
> the lower the weight (in sched_prio_to_weight[]) and the lower the task
> load signal.
> This means that the unweighted load_sum value looses granularity.
> E.g.:
> A task with weight=3D15 can have load_avg values in [0:15]. So all the va=
lues
> for load_sum in the range [X * (47742/15) : (X + 1) * (47742/15)]
> are floored to load_avg=3DX, but load_sum is not reset when computing
> load_avg.
> attach_entity_load_avg() however resets load_sum to X * (47742/15).
>

From a mathematical perspective, deriving load_sum from load_avg is
indeed feasible.

However, as you pointed out, integer arithmetic may introduce
significant quantization errors, particularly for tasks with low
weights.

For instance, if a task=E2=80=99s weight is 15 and its load_sum values are
3183 and 6364 respectively, both would result in the same load_avg =3D 1
under this method =E2=80=94 resulting in an error of 6364 - 3183 =3D 3181. =
This
error increases as the task=E2=80=99s weight decreases.

Therefore, I believe that recomputing the propagated load_sum from
load_avg within update_cfs_rq_load_avg() is not an ideal approach.
Instead, my proposal is to record the load_sum of dequeued tasks
directly in cfs_rq->removed, rather than inferring it indirectly from
other signals such as runnable_sum or load_avg.

> >    b) Eliminate precision loss from the shift operation, especially
> >       with frequent short-lived tasks;
>
> It might also help aggregating multiple tasks. Right now, if 1.000 tasks
> with load_sum=3D1 and load_avg=3D0 are removed, the rq's load signal will
> not be impacted at all.
>

Exactly. As I mentioned in previous email, this is also one of the key
motivations behind this PATCH.

> On the other side, there might also be questions about the PELT windows
> of all these tasks and the rq being aligned, cf.
> https://lore.kernel.org/all/20170512171336.148578996@infradead.org/
>

To be honest, I=E2=80=99m not entirely sure I fully understand the potentia=
l
issue you are referring to here. I assume your concern is that the
load_sum values stored in cfs_rq->removed may belong to a different
PELT window than the current rq window during propagation.

I understand the necessity of PELT window alignment.
In attach_entity_load_avg(), when an se is enqueued into a cfs_rq, its
PELT window is aligned with that of the cfs_rq, and its *_sum values
are recalculated to keep both in sync.

However, in this PATCH, the cfs_rq->removed mechanism only relates to
the dequeue path =E2=80=94 it records the load_sum of a task when it leaves
the runqueue, and later propagates it appropriately. Therefore, I
don=E2=80=99t think window alignment needs to be considered at dequeue time
(at least based on my current understanding), since this
synchronization has already been handled during enqueue.

That said, I may have missed some corner cases, so I=E2=80=99d really
appreciate further discussion on this point.

Thanks,
hupu


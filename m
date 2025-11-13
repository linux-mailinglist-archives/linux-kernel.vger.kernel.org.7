Return-Path: <linux-kernel+bounces-898921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C3AC56509
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2F05B351EA5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D97D335097;
	Thu, 13 Nov 2025 08:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bC9lajH9"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78FA334C1F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763022849; cv=none; b=OJfW23A1egrGlFJqU+GCJLKvPKLE7iGzkWD2/oDjnneiFXm0CKy+t8HQhsFi/iGFY2GisxykcRzwor/0AFCA8b1myXjnxa70DD5HmF9wAU3u3jpy75tnZa9uqK/SL6ezmHSuctaeS8IWSD9TxcYt4/QQwGRJEh6x8oR5IqftcJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763022849; c=relaxed/simple;
	bh=Yxcu7/KUCWyU777GRqO1bMQ6Ax1NjVKJEGuZpno+whY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B6//XU0mrf48w1gC7ohQJ9Qr+cf9vgx0CTGXjpVojLjLewstmUzTRVoYhg2R8FSybZLrMR5jcdcqUOV8hCJ0q8vH6NE01EGjme39AcJN/8ulaEj6B51RRr2SRywXBE7ENiflxG7sY+lUTbXgkFJAaGEzw6+4Zlz3cErUcAbA408=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bC9lajH9; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-343514c7854so539952a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763022847; x=1763627647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfufakeYQV6Eei1VDjFOp/g9ltD15I/RsjxykQDBAqM=;
        b=bC9lajH9ZFKXNrNSoLM1GE1ZP4vpzhSqRpDXgR66fKoZ1jPmkYryU9Aw3lFR6nOPdK
         KfP/93zt4dklhKVDr5ka0/6Uy9kFHzWJBN4xVHVt0sPzB9KDieqAlD2fRDUrUaYHgz7N
         EilhicH/lC/2Lic+UshlNNBzuhUapUhtpS5tgc87MLhEQ12uNKy2ci3zhJennpzAKPuT
         LQIdrMcXxmK5pqUiHPW85hyi1WGjMD2tF4276sD6S5K8LCnqbpBPkiTc9GWsvSQQ9UaS
         F/tg60d9v2Oy9E0z8Jbzlq3QyfPIqFJ2oJNpAwgybmSTgsIoYd+KJC0a9f4RRmfhbSgq
         UhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763022847; x=1763627647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VfufakeYQV6Eei1VDjFOp/g9ltD15I/RsjxykQDBAqM=;
        b=jxeGtDq+aaz26rNS5U4cyBJakAJoZaWG8HlKdIkiTuAU0O25ntEeI5nh8fkxjmDJVg
         2XFAcFnp5aargJJqH+QUqI9lrJzrUBAmyu478nSSXpClS/Brc26GJ58YwhvH5ObwG76c
         iT2id3eUxc3ZPX8t0/piaqk5rdxzBI4B1cu4S1QjNMSCi3OBkpuQgcjdxv37KIYgYNEL
         VOFQ2MS5XaAg3uxIxpKTbnSl316KtC+De6p07Hrq9q5dhO1qoP9SCSyroWp/UZ5+6zlB
         q67yhvrOTz8NDgiOdslo3ET8B27YfmBuhVXSH4CuBS8coqyNUROBjjN8E+kFS/8kaxxb
         3lvg==
X-Forwarded-Encrypted: i=1; AJvYcCV6nZ4QWler3jd3ukvwUw4o+buyRNs80YTQz9OAEcYp2o5KPR8L8gLIpXV/5OUQHpLcy44+cXA7zJbGCSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKTnEYbrfC409Malkr/cP26uEOBluboZhtMCQVZyQ/wPqGkLdA
	1YmVacsS2kgAofR2sVRBC+RDui3Tsov8bI9D7OsinAwCZtqLJ9JrsvZlfltau72lTX4SN9VpYSD
	zLymbVeGLt8K68oZokuugnW3MiWQRPms=
X-Gm-Gg: ASbGncvPlNhuz0U0/66i4uX+8JHe9ZJvJzYvL9qYruHjGF6z4JzbNoYhWyWS3E+bHrV
	b4RK7dsZZ6Xi2UhsP54maewbcBYnbxbuhr9C2g1+zObfFuA93Flm/bgt15UdUiG/ySrGmS50Lx6
	A8V03ZCQXIpSgMaVabyyvS4m+WWhtrS+nrpvQxs/XTM1nCgw/qGDJYpCFX8MmQn3zmBzKU3Fxji
	HpNOdlGb9DgJBZoW4OAoXGTEtwdN8uGuk/J5QYfJt2AdV6cSnffek7cu45x
X-Google-Smtp-Source: AGHT+IF5k9bRBw6aUvmMV9a5V3ovOi3p+Dv/JFpSd4YAX7k2lQXxjPgszX9upu1ck3Dp2nEU0kQr1BDf0CdUmHFmCVk=
X-Received: by 2002:a17:90b:1e07:b0:340:dd63:3fd5 with SMTP id
 98e67ed59e1d1-343eacd0972mr3230974a91.17.1763022846898; Thu, 13 Nov 2025
 00:34:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110033232.12538-1-kernellwp@gmail.com> <7bc4b0b7-42ea-42fc-ae96-3084f44bdc81@amd.com>
 <CANRm+CxZfFVk=dX3Koi_RUH6ppr_zc6fs3HHPaYkRGwV7h9L7w@mail.gmail.com> <079d48d9-a663-49d5-9bc6-f6518eb54810@amd.com>
In-Reply-To: <079d48d9-a663-49d5-9bc6-f6518eb54810@amd.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Thu, 13 Nov 2025 16:33:54 +0800
X-Gm-Features: AWmQ_bkcRk45qp8zPBFOlSHohDQtsVbxrxDqJ_rGnpK03CjKPK1a3mzqSOJAb88
Message-ID: <CANRm+Cy2O9j_itDmJcAwUebV2h=2hvfZxuxtHqKD-vF1XohGAw@mail.gmail.com>
Subject: Re: [PATCH 00/10] sched/kvm: Semantics-aware vCPU scheduling for
 oversubscribed KVM
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Wanpeng Li <wanpengli@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prateek,

On Thu, 13 Nov 2025 at 12:42, K Prateek Nayak <kprateek.nayak@amd.com> wrot=
e:
>
> Hello Wanpeng,
>
> On 11/12/2025 10:24 AM, Wanpeng Li wrote:
> >>
> >> ( Only build and boot tested on top of
> >>     git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/cor=
e
> >>   at commit f82a0f91493f "sched/deadline: Minor cleanup in
> >>   select_task_rq_dl()" )
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index b4617d631549..87560f5a18b3 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -8962,10 +8962,28 @@ static void yield_task_fair(struct rq *rq)
> >>          * which yields immediately again; without the condition the v=
runtime
> >>          * ends up quickly running away.
> >>          */
> >> -       if (entity_eligible(cfs_rq, se)) {
> >> +       do {
> >> +               cfs_rq =3D cfs_rq_of(se);
> >> +
> >> +               /*
> >> +                * Another entity will be selected at next pick.
> >> +                * Single entity on cfs_rq can never be ineligible.
> >> +                */
> >> +               if (!entity_eligible(cfs_rq, se))
> >> +                       break;
> >> +
> >>                 se->vruntime =3D se->deadline;
> >
> > Setting vruntime =3D deadline zeros out lag. Does this cause fairness
> > drift with repeated yields? We explicitly recalculate vlag after
> > adjustment to preserve EEVDF invariants.
>
> We only push deadline when the entity is eligible. Ineligible entity
> will break out above. Also I don't get how adding a penalty to an
> entity in the cgroup hierarchy of the yielding task when there are
> other runnable tasks considered as "preserve(ing) EEVDF invariants".

Our penalty preserves EEVDF invariants by recalculating all scheduler state=
:
   se->vruntime =3D new_vruntime;
   se->deadline =3D se->vruntime + calc_delta_fair(se->slice, se);
   se->vlag =3D avg_vruntime(cfs_rq) - se->vruntime;
   update_min_vruntime(cfs_rq); // maintains cfs_rq consistency
This is the same update pattern used in update_curr(). The EEVDF
relationship lag =3D (V - v) * w remains valid=E2=80=94vlag becomes more
negative as vruntime increases. The presence of other runnable tasks
doesn't affect the mathematical correctness; each entity's lag is
computed independently relative to avg_vruntime.

>
> >
> >>                 se->deadline +=3D calc_delta_fair(se->slice, se);
> >> -       }
> >> +
> >> +               /*
> >> +                * If we have more than one runnable task queued below
> >> +                * this cfs_rq, the next pick will likely go for a
> >> +                * different entity now that we have advanced the
> >> +                * vruntime and the deadline of the running entity.
> >> +                */
> >> +               if (cfs_rq->h_nr_runnable > 1)
> >
> > Stopping at h_nr_runnable > 1 may not handle cross-cgroup yield_to()
> > correctly. Shouldn't the penalty apply at the LCA of yielder and
> > target? Otherwise the vruntime adjustment might not affect the level
> > where they actually compete.
>
> So here is the case I'm going after - consider the following
> hierarchy:
>
>      root
>     /    \
>   CG0   CG1
>    |     |
>    A     B
>
>   CG* are cgroups and, [A-Z]* are tasks
>
> A decides to yield to B, and advances its deadline on CG0's timeline.
> Currently, if CG0 is eligible and CG1 isn't, pick will still select
> CG0 which will in-turn select task A and it'll yield again. This
> cycle repeates until vruntime of CG0 turns large enough to make itself
> ineligible and route the EEVDF pick to CG1.

Yes, natural convergence works, but requires multiple cycles. Your
h_nr_runnable > 1 stops propagation when another entity might be
picked, but "might" depends on vruntime ordering which needs time to
develop. Our penalty forces immediate ineligibility at the LCA. One
penalty application vs N natural yield cycles.

>
> Now consider:
>
>
>        root
>       /    \
>     CG0   CG1
>    /   \   |
>   A     C  B
>
> Same scenario: A yields to B. A advances its vruntime and deadline
> as a prt of yield. Now, why should CG0 sacrifice its fair share of
> runtime for A when task B is runnable? Just because one task decided
> to yield to another task in a different cgroup doesn't mean other
> waiting tasks on that hierarchy suffer.

You're right that C suffers unfairly if it's independent work. This is
a known tradeoff. The rationale: when A spins on B's lock, we apply
the penalty at the LCA (root in your example) because that's where A
and B compete. This ensures B gets scheduled. The side effect is C
loses CPU time even though it's not involved in the dependency. In
practice: VMs typically put all vCPUs in one cgroup=E2=80=94no independent =
C
exists. If C exists and is affected by the same lock, the penalty
helps overall progress. If C is truly independent, it loses one
scheduling slice worth of time.

>
> >
> >> +                       break;
> >> +       } while ((se =3D parent_entity(se)));
> >>  }
> >>
> >>  static bool yield_to_task_fair(struct rq *rq, struct task_struct *p)
> >> ---
> >
> > Fixed one-slice penalties underperformed in our testing (dbench:
> > +14.4%/+9.8%/+6.7% for 2/3/4 VMs). We found adaptive scaling (6.0=C3=97
> > down to 1.0=C3=97 based on queue size) necessary to balance effectivene=
ss
> > against starvation.
>
> If all vCPUs of a VM are in the same cgroup - yield_to() should work
> just fine. If this "target" task is not selected then either some
> entity in the hierarchy, or the task is ineligible and EEVDF pick has
> decided to go with something else.
>
> It is not "starvation" but rather you've received you for fair share
> of "proportional runtime" and now you wait. If you really want to
> follow EEVDF maybe you compute the vlag and if it is behind the
> avg_vruntime, you account it to the "target" task - that would be
> in the spirit of the EEVDF algorithm.

You're right about the terminology=E2=80=94it's priority inversion, not
starvation. On crediting the target: this is philosophically
interesting but has practical issues. 1) Only helps if the target's
vlag < 0 (already lagging). If the lock holder is ahead (vlag > 0), no
effect. 2) Doesn't prevent the yielder from being re-picked at the LCA
if it's still most eligible. Accounting-wise: the spinner consumes
real CPU cycles. Our penalty charges that consumption. Crediting the
target gives service it didn't receive=E2=80=94arguably less consistent wit=
h
proportional fairness.

Regards,
Wanpeng


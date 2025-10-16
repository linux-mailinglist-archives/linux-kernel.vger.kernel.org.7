Return-Path: <linux-kernel+bounces-855391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E54BE1152
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 02:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31BA31888D35
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 00:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B89B38DDB;
	Thu, 16 Oct 2025 00:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rIosVHeB"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0A6749C
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 00:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760573775; cv=none; b=kpwSqOpQluFERY36RHCeJnIZBS/nSdq1xYRdhhU2WNFKP8XdurhTbwh4Dn5RbPnraEF7UY5l6E+AUPFA+xxfFkrRhZv9RdvqsZNN0CzBKlqEFJjBdEjnL7LlgPX2Xsn5l5i3TiXBUVeYNsttqdqugoZ13Qi9i4/7yGFuEF//z1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760573775; c=relaxed/simple;
	bh=wz5XixhR11Kmyh2yHWgQoZfslE7mx9x6iHIpGuNHJ9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GBbNERIvPiP85twoB/5NWZP4z9kvNyYUeRrHy3Y14hQa1L3spSkl4FhGejdZRfUUqymiTIIPThE9D3MEi2AWYrBq3WoQ+MFtmCN3lOn4CaHvrz4xK80a4AhTo/W924OyLO9+s+n38pbLMMk0G6MvNPiN5EJi3GAooCqCKxqJwuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rIosVHeB; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso23998966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760573772; x=1761178572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPJlbUcN/wmESRogeT7T0Nbc8HSsMNUIvlri3ltQrGY=;
        b=rIosVHeBh6YUCxntHSLwqTPGNixjUmWLp/ePN7wK/oEbcg2TonQ6fsGZpNSG3pMNu1
         p6UfWZFDsRQsEji519xXgAC0k8rTCNOWQc3JFDVZotjkBvkGuSuTpDDditNUrLa51iiu
         /hSAlnpAqll68m6Dc61DktkaMTKAPWjQBeume8TF6HwxybhvbAeTWzQ9/9YsPJ0MfhK1
         2gws75W3dLOuSKJo9UTVXECcvmf48aflSrYWCJFALBQvSs9gQVzRIMedtkH2kc2jBUIa
         Q5EMuCHqEvj8gOnT/P/WwEi99QJN0PoRjBATXsBqnzUReq0GXMWBdpmUu618v9br33St
         5GCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760573772; x=1761178572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPJlbUcN/wmESRogeT7T0Nbc8HSsMNUIvlri3ltQrGY=;
        b=ZWpjpo2qfVeiQnQ+9ARUqSwteOnTSrPuM95OicNgac1aiBNeMvAg/L5gkJXx9QGVZb
         /2OQJuqRFG9DLCvMCt1WIGgf0OoCz1AD/5xDMMamv2apUIWyYH1jbEFX4IJjpX7JlwM2
         SFUlWs6LkI+Qx+x4qmKbq4NDqM1zxADOTPYt51Zesa1nih8qROWhbgOrzEuh9J2Rc1/e
         A5rXSgdt3ob+hHZOSQXzLCoJlI03ojwwc+Z6kk4SZzVjD6IFfiH62A83LrxkkGBj+4k3
         g3+7XDwqZqFuXqrbITjdcH9mnp24pWYZgvpsg+N32nQirIjmEB7fg/FNo3i9qMZ5pJAc
         1jnA==
X-Gm-Message-State: AOJu0YyzdhWRXIa8hX+QdFMYb2/cK3TY3NbdPy2KlsWwDn3vDCwB3UE2
	LhBdkT029RvLH2kXeEACsW1LMMQlZ3A26ltS/oPnTAtDmFYA3WDv/Hsgfp6OnAc5+o0wwstCmaQ
	PaAG7lHFdJ8EIHtWLDIqdERG2BYYcHMxhEZNhu7A=
X-Gm-Gg: ASbGncsBdwL9nWsSAeIJAI68eEELq7vFznGgWoSvZGi7jBEIVXgv590WQDgOveOSQmP
	mNQYXaacFHq9sMbHATankGtXcH4p/3t3uAtfZ7EumQsZRxquNg1tTIzuU7o5hkgKC0clPlEyiRs
	hWuNRrGyiXtzFU+0/SNty3JKyCrXi8MzBlZ8Qe1z2b1vJXKYgqtRM8y+zdf0O6hM/sIty4jcxUO
	nAA7AIHYWu0AOd+iUfyy5IOgysP4O/d7TICMKaFaOXg48DUtzPQH4I1IdFsn/YsG3MBxBej1Lxs
	p8NcJnyNz/ap81Dt6cgNv0DhnUP/zW9l
X-Google-Smtp-Source: AGHT+IHwWTc410ODyjkVJpF9USltdGAmRIGWm7UvosB9LeI1kLLjueWQ/lQC+TyF1tkOEAurMaeMMu0DG2PHIJBSNnc=
X-Received: by 2002:a17:907:3e8c:b0:b40:f7dd:f8e8 with SMTP id
 a640c23a62f3a-b50aba9da8cmr3401894766b.38.1760573771595; Wed, 15 Oct 2025
 17:16:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926032931.27663-1-jstultz@google.com> <20250926032931.27663-5-jstultz@google.com>
 <20251008133223.GT4067720@noisy.programming.kicks-ass.net>
In-Reply-To: <20251008133223.GT4067720@noisy.programming.kicks-ass.net>
From: John Stultz <jstultz@google.com>
Date: Wed, 15 Oct 2025 17:15:59 -0700
X-Gm-Features: AS18NWBYcr2BITRynlCZDBw5E1gnL8KK__oxQHo-zSOvnX_CsYHHJiZo4XmDKqo
Message-ID: <CANDhNCqH4rsnME4gVd2thSTnvSs3WvHXc=zWMPZcCEBF=vzxkg@mail.gmail.com>
Subject: Re: [PATCH v22 4/6] sched: Handle blocked-waiter migration (and
 return migration)
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Suleiman Souhlal <suleiman@google.com>, kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 6:32=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Fri, Sep 26, 2025 at 03:29:12AM +0000, John Stultz wrote:
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 7bba05c07a79d..d063d2c9bd5aa 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3157,6 +3157,14 @@ static int __set_cpus_allowed_ptr_locked(struct =
task_struct *p,
> >
> >       __do_set_cpus_allowed(p, ctx);
> >
> > +     /*
> > +      * It might be that the p->wake_cpu is no longer
> > +      * allowed, so set it to the dest_cpu so return
> > +      * migration doesn't send it to an invalid cpu
> > +      */
>
> This comment isn't quite right; ->wake_cpu is a mere preference, it does
> not have correctness concerns. That is, it is okay for ->wake_cpu to not
> be inside cpus_allowed.

Oh! This is actually left over from earlier in the revisions where
return migration would migrate specifically to the wake_cpu, I thought
it was still important, but looking again, since the return migration
now does a block_task/wake_up_process(), I think we can drop this
whole chunk.  Thanks for catching that!

> > +#ifdef CONFIG_SCHED_PROXY_EXEC
> > +static inline void proxy_set_task_cpu(struct task_struct *p, int cpu)
> > +{
> > +     unsigned int wake_cpu;
> > +
> > +     /*
> > +      * Since we are enqueuing a blocked task on a cpu it may
> > +      * not be able to run on, preserve wake_cpu when we
> > +      * __set_task_cpu so we can return the task to where it
> > +      * was previously runnable.
> > +      */
> > +     wake_cpu =3D p->wake_cpu;
> > +     __set_task_cpu(p, cpu);
> > +     p->wake_cpu =3D wake_cpu;
>
> Humm, perhaps add an argument to __set_task_cpu() to not set ->wake_cpu
> instead?

Hrm. I can rework it that way, but I do always feel that bool
arguments to functions makes the code less readable (since it's not
always clear from the usage what true/false means).  Making it an enum
 or defined flags argument help a bit with that, but it still seems it
would have much more impact to the source than this small helper
that's only called from the proxy related logic in two places at the
end of the day.

> > @@ -4215,8 +4294,15 @@ int try_to_wake_up(struct task_struct *p, unsign=
ed int state, int wake_flags)
> >        */
> >       scoped_guard (raw_spinlock_irqsave, &p->pi_lock) {
> >               smp_mb__after_spinlock();
> > -             if (!ttwu_state_match(p, state, &success))
> > -                     break;
> > +             if (!ttwu_state_match(p, state, &success)) {
> > +                     /*
> > +                      * If we're already TASK_RUNNING, and BO_WAKING
> > +                      * continue on to ttwu_runnable check to force
> > +                      * proxy_needs_return evaluation
> > +                      */
> > +                     if (!proxy_task_runnable_but_waking(p))
> > +                             break;
> > +             }
> >
> >               trace_sched_waking(p);
>
> Oh gawd :-( why !?!?
>
> So AFAICT this makes ttwu() do dequeue when it finds WAKING, and then it
> falls through to do the normal wakeup. So why can't we do dequeue to
> begin with -- instead of setting WAKING in the first place?

So hopefully the earlier discussion cleared that one up, but let me
know if you still object to this or have questions.

thanks
-john


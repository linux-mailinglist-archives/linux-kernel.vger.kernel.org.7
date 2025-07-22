Return-Path: <linux-kernel+bounces-740419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68230B0D3EE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C6711882DD6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1D62989AD;
	Tue, 22 Jul 2025 07:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OTn7LxPL"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6733B28A730
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753170829; cv=none; b=TYZ9JlM2ThgORoQMCxXhrVeHQZzStCsIsMp9py3jJJYzppHm6XTlIW51MLm/aD6BmwgQ2R9xhhVxOosdiBDn4IRZRC9toHHpr2s/+dHmaprA0aJEzo16FWnt6CsS4Qc91ITLs4vw8h94Je39HwuC7Tkw7qFXsFuWz0j/9d65A/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753170829; c=relaxed/simple;
	bh=bpMC0keOZ1LpoXcls3CZGH4Ou8XRWAIJZKNc48Ta0MQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjdoZ5tXH+xE6n3qKVOTzZYdl26aj0teYio9mbtghmzzUvQYMsm3TH1yUCB9rwx4mwaVCPNWDNVdcWwB6TH51ANBQSpvNO5nx73UtYiIhl/KxFe+Qms2oyhrXC40snYUNjUAqfzezLa0lqlrW4PI6nbLPoiA6V948XQVV4CO5Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OTn7LxPL; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6077dea37easo8069356a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753170826; x=1753775626; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0a1q31uBbSC6qxSX1DMJMT91okS7Zx9m/cQ4GTm5heE=;
        b=OTn7LxPLSc2kk7UFdpo56BQn2IhznLdmUAkz5fVURu0kRfrlcrLwKQXRLhg/A48hxk
         qZlTfhw9Jy3wxg7tQjAdqFgggKZIBHM69i2OENrb9z+kj7Sbu74FtXVd/SjKtfq1O+z5
         KwYyz1FriHnfS+Xwm9fvmPBLtGNv4L9o4fRm+5/1QGA0PkkILTetNvrpChQ5z34+TVYB
         jit/RmeYpE0AstN9HTirpmxHJnt3FYBZQMVzshpezGpfyjJu3CvETgKnPjfEueHMaqOE
         MdiEp6ERyJqFWUSASgjhQU8GU3/lWwLkC4N2JcEUke2QiZB8DV5lKWfeqTayYG1qwKlK
         sPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753170826; x=1753775626;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0a1q31uBbSC6qxSX1DMJMT91okS7Zx9m/cQ4GTm5heE=;
        b=XuePvLFPr2oOjuLmoc/KYTRsfvYdlC+NQIAaAKWFYDYjgryTUKQZ4ex+yULvGmH1gm
         uF+y2032fg7c92uyhN4s5gqmX1AB3sSwyNgLw+cmoXTMiMATNGoUykXhKDjvuBgMOKOG
         g2YUxwe22Ig7S2bGUtEc21AZ2PRhRDQNGNb+wHNNUl5CPTCTZ/gWymtr6eptuk5gpX3G
         fJ+QyzaoBpMWV3GkkRwEsmFTZWposAOeatLc2ACTEZg3p9WtJyp8h/AylJlRZAGSNY8B
         VK9qUHNag8Cj1YrxynCb7wyDO+fsgLdsiNcAbpH1MWJdc/6JyLzK3moTxowt6L92Z9za
         Kplg==
X-Forwarded-Encrypted: i=1; AJvYcCXu1J4+EXrTe9MZManx7BJcs7Rnq4TtXPwtUEKwurI0JKPh1a7ZusI8WwQyhNi2zJjlUpcvK1/Mb/Wh+R0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXjLJToUsceK+Ai6XwcfZqlmaf7oc0pyu8Ht+bSdg4hT9I94bs
	JjqKN835djfpuka1ub880lB66W17ehB7aQ5Ja0ERP1JdlV+6nGDJLYeLgEL97wg0qOEBdhtsQZD
	CZt6E4GHqfxLJUklj2oU/uHeZBfGeEFN+y8i9ABfF7A==
X-Gm-Gg: ASbGncuoRSHWBTI6OUcHJizpwNSAIp1artaK7NqeDqCPhMSVZWYTkD295fbUhiruhG/
	e7cwdg01tsftEfgu2EiZjW9G+PMRoDhLyxQacUAGsWScCvYvYg9sVctm2NgiTVD1tH7ZCI2AA9x
	AmK5Wsi+PyUqdp8g7vDm8rPHzrE6hqErArPt0a7kXjZhxcFyylFW6fgNqFR5k+mEaYa5c2jQVE4
	3f81nuIhwTse77sFU++eoDjcrzK57xcge3Qb0kp
X-Google-Smtp-Source: AGHT+IFWHJ65Rj9b3lXirYWdn/pU16csi+ZndAp3wB+oWRTXPsbVpRtkEJrveOHNFvgus5NhiS2sl4hgQ+4AWwEyuZ8=
X-Received: by 2002:a17:907:da0:b0:af0:3bac:4f88 with SMTP id
 a640c23a62f3a-af03bac510fmr529302066b.26.1753170825533; Tue, 22 Jul 2025
 00:53:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721023939.19703-1-shijie@os.amperecomputing.com>
 <CAKfTPtC7+V6ubaGDPy0MW2MFG7w_yrnYCPQ-b2=3uYgeM+-+EA@mail.gmail.com>
 <xhsmhv7nleqfl.mognet@vschneid-thinkpadt14sgen2i.remote.csb> <CAKfTPtD8uF=6kr=RpduggahJRztH4DtQFQ5Q5zM6PWY8EESfxg@mail.gmail.com>
In-Reply-To: <CAKfTPtD8uF=6kr=RpduggahJRztH4DtQFQ5Q5zM6PWY8EESfxg@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 22 Jul 2025 09:53:33 +0200
X-Gm-Features: Ac12FXyJkPTOgGFTNVN9ArHrUh_1tDQsyLOQ0Z76i49CCLnygAh7lLPnbryYBec
Message-ID: <CAKfTPtBxtAu1=p22Z5N7_EMeTMyRvN-gQDa_G==dTDDKtPdYzA@mail.gmail.com>
Subject: Re: [PATCH v4] sched/fair: do not scan twice in detach_tasks()
To: Valentin Schneider <vschneid@redhat.com>
Cc: Huang Shijie <shijie@os.amperecomputing.com>, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, patches@amperecomputing.com, cl@linux.com, 
	Shubhang@os.amperecomputing.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Jul 2025 at 09:49, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Mon, 21 Jul 2025 at 13:25, Valentin Schneider <vschneid@redhat.com> wrote:
> >
> > On 21/07/25 11:40, Vincent Guittot wrote:
> > > On Mon, 21 Jul 2025 at 04:40, Huang Shijie
> > > <shijie@os.amperecomputing.com> wrote:
> > >>
> > >> detach_tasks() uses struct lb_env.loop_max as an env.src_rq->cfs_tasks
> > >> iteration count limit. It is however set without the source RQ lock held,
> > >> and besides detach_tasks() can be re-invoked after releasing and
> > >> re-acquiring the RQ lock per LBF_NEED_BREAK.
> > >>
> > >> This means that env.loop_max and the actual length of env.src_rq->cfs_tasks
> > >> as observed within detach_tasks() can differ. This can cause some tasks to
> > >
> > > why not setting env.loop_max only once rq lock is taken in this case ?
> > >
> > > side note : by default loop_max <= loop_break
> > >
> >
> > I thought so too and dismissed that due to LBF_NEED_BREAK, but I guess we
> > could still do something like:
> >
> > ---
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index b9b4bbbf0af6f..eef3a0d341661 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -11643,6 +11643,7 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
> >                 .dst_grpmask    = group_balance_mask(sd->groups),
> >                 .idle           = idle,
> >                 .loop_break     = SCHED_NR_MIGRATE_BREAK,
> > +               .loop_max       = UINT_MAX,
> >                 .cpus           = cpus,
> >                 .fbq_type       = all,
> >                 .tasks          = LIST_HEAD_INIT(env.tasks),
> > @@ -11681,18 +11682,19 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
> >         /* Clear this flag as soon as we find a pullable task */
> >         env.flags |= LBF_ALL_PINNED;
> >         if (busiest->nr_running > 1) {
> > +more_balance:
> >                 /*
> >                  * Attempt to move tasks. If sched_balance_find_src_group has found
> >                  * an imbalance but busiest->nr_running <= 1, the group is
> >                  * still unbalanced. ld_moved simply stays zero, so it is
> >                  * correctly treated as an imbalance.
> >                  */
> > -               env.loop_max  = min(sysctl_sched_nr_migrate, busiest->nr_running);
> > -
> > -more_balance:
> >                 rq_lock_irqsave(busiest, &rf);
> >                 update_rq_clock(busiest);
> >
> > +
> > +               env.loop_max = min3(env.loop_max, sysctl_sched_nr_migrate, busiest->h_nr_running);
> > +
> >                 /*
> >                  * cur_ld_moved - load moved in current iteration
> >                  * ld_moved     - cumulative load moved across iterations
> >
>
> I would prefer something like below:
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1b3879850a9e..636798d53798 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11702,12 +11702,16 @@ static int sched_balance_rq(int this_cpu,
> struct rq *this_rq,
>                  * still unbalanced. ld_moved simply stays zero, so it is
>                  * correctly treated as an imbalance.
>                  */
> -               env.loop_max  = min(sysctl_sched_nr_migrate,
> busiest->nr_running);
>
>  more_balance:
>                 rq_lock_irqsave(busiest, &rf);
>                 update_rq_clock(busiest);
>
> +               if (!env.loop_max)
> +                       env.loop_max = min(sysctl_sched_nr_migrate,
> busiest->cfs.h_nr_runnable);

it should be h_nr_queued as mentioned by Huang and my patch has been
messed up by my web browser

> +               else
> +                       env.loop_max = min(env.loop_max,
> busiest->cfs.h_nr_runnable);
> +
>                 /*
>                  * cur_ld_moved - load moved in current iteration
>                  * ld_moved     - cumulative load moved across iterations


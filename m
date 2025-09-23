Return-Path: <linux-kernel+bounces-828381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6737B94814
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9C0A7ACD48
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59A430E829;
	Tue, 23 Sep 2025 06:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBjTZ4c/"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7374C25B1CE
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758607666; cv=none; b=auwklhwEXcbWfhCqJEtZMD7ahQXRCErMcjRaey5LuH1RdTycadzllYYKsX3K5SNT69MYB84MYLc9Espn6V1+d4Whr5ppPxU93VWRTpTpeC5NTYS327SY2qeyn0fyReJ345MgooUZABc7CnAJhYtPY1DJcSCLDOnLrJFRib5BZOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758607666; c=relaxed/simple;
	bh=arDVeJ781a5JY4lU0Jvx71uXG6RVAnB7CUja4/NHmNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MKvoFhSVttg+PpOyjZTtfn6724CLfmlMQENVpzVMAErBiqD758iCRARYWuRWKfmgc59KeqMPUJXzdFC1wHhMivtRChJZHdPAdw4JopanEdn2g9D2NOBx7IQ5bJns/aDUeWjxsSVTntf4gpOT9r10e71tD9lmq2c+thwqwUnsLs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBjTZ4c/; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4d21a3da5d8so10781761cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 23:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758607663; x=1759212463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBw+oV2t8lt0sCTnWqXxyFqdNrsWHoU6HwpFH6UzjX0=;
        b=HBjTZ4c/qzYcvSyEi9LKjg52ue2hHwdUgyQGqe82Jyc6Jy1Lj4wtGwbNT9BSlksOTS
         jbnNEAJlro0XWsh7t8iNTbEv4RVk2qIbPwCKpqgKkUvkOxWYcUuaSq5ZQ9bnZqogSRmV
         SJHChwgJawFNo+dZWNyyIEK1awivlnFBojD1ttrnFbcUFJj7bbabj3kuKwyVpXXYD+m9
         tWmSFErSCEZSWj5Fm6IgowXHW8Wstvzt1NDVrcMyQicL9v2mOm8u2iak7lGrsF+Y0prJ
         OyNaQ987t+p9ZKqcjzOY/lV8xXk6RHozvI4cNhONiKwmiH/VQrfAn2FQrsIvhwaWHNIc
         Asjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758607663; x=1759212463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EBw+oV2t8lt0sCTnWqXxyFqdNrsWHoU6HwpFH6UzjX0=;
        b=dG351kN5KQzVuxS5sfA/IJ/WxdQkSvJRnLK1OrwBmGcFz7MFRa87YkTJiSw2cVVGiS
         qitlxxawUAzAW+Y2FdiyYriOkyOIynPzHCFFyp2qXUMK/KyrydcseTK4z8MUr20+UWSh
         v9QfJ2MxvKr1BtHIbA4yS4XOr0YEBaRniYWucsjy405x1kyA6bzkQQFzOM39o6c8ITT1
         iQsYI4V5myCOv2WoinMxb69KSZZTxhlLNbS7BdZuyiHqrK63MdbSQqq6T+C+N2zj4Wto
         kaE/Q4tsKyY80++FqR7EL3n+Z2J2yqpuNChqaODahH7m2/szv94pcoA/jNJMffM0FDxF
         qECA==
X-Forwarded-Encrypted: i=1; AJvYcCUK7L+1qcXmGw20ZGkyRyvPZLA262Es7oiRdR90VDCocmns3ZN4/8J9tJdNzpW04O71ICrmLXfQHEUcykA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf5FgqhLSJ6fnsNZWO3Ka1XIIUY9O0QJRoNKWj0ncOj5QdY4Hv
	H8W97zngpcTF5wj6zsQrKLlUjpGRNT8Tq2yuPVvGOKOMhBTGjJZF2u+RbRFllytehOymTXP7lJw
	f7Sr/353HhXq2ZN6kKH/ybuR76IouYOvvYV3p
X-Gm-Gg: ASbGncsVEKIKO2uXkfnkEyEmwIusmO3PWFKJtv8MjvG8n6VqVz+/mk2uFBAjUpznp3r
	2PAWyx1mnjJnp+LSlPF/bQ0S2LNgEueYOhPp6kenKYkdFqTYhHgGxYsmGc4lMS1du//1YOU+NW2
	iYFrUg4eXHLrm6zBkzo8SYZgcMYuQpm/Cn1+iHM5flV0woercQMEXidKQAGX6zosFQb2riA+Hnw
	mjqKLht
X-Google-Smtp-Source: AGHT+IHhWRqdPSNilQ7NDnUa+avCQNXPtnb6Fc5TbS5XEzojG+bYtzwzS9TIxtwMvX3/Xea6oZTCTsf/6qwe2opyx8s=
X-Received: by 2002:ac8:7dc5:0:b0:4d1:89c4:822 with SMTP id
 d75a77b69052e-4d36fc044c4mr15282621cf.41.1758607663111; Mon, 22 Sep 2025
 23:07:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911032823.19064-1-xuewen.yan@unisoc.com> <CAB8ipk-xqbsNh6EQ42JFV8CqPeJR0gjObOKvSs=-b=qcuLQxfg@mail.gmail.com>
 <CAJuCfpHVjDrng2=bCh=DBdn_LBK3-qVF46Jwm3_TFzCjQhn9CA@mail.gmail.com>
In-Reply-To: <CAJuCfpHVjDrng2=bCh=DBdn_LBK3-qVF46Jwm3_TFzCjQhn9CA@mail.gmail.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Tue, 23 Sep 2025 14:07:32 +0800
X-Gm-Features: AS18NWBffMFJu4JOI5B0Q8gjJRvpvqantKvpvb0ig8H71YWrBOUW7-N7WP6ubeI
Message-ID: <CAB8ipk-cCLWUg8A6tSMZW43fHj10XAzBU2O4Ed5TbDk73J8QBw@mail.gmail.com>
Subject: Re: [RFC PATCH V3] sched: psi: Add psi events trace point
To: Suren Baghdasaryan <surenb@google.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, hannes@cmpxchg.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, peterz@infradead.org, 
	rostedt@goodmis.org, mingo@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, ke.wang@unisoc.com, yuming.han@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 11:31=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Mon, Sep 22, 2025 at 7:58=E2=80=AFPM Xuewen Yan <xuewen.yan94@gmail.co=
m> wrote:
> >
> > A very gentle ping on this patch.
> > Best regards,
> > Thanks!
>
> Thanks! Sorry I missed it.
Not at all, thanks for your reply:)

>
> >
> > On Thu, Sep 11, 2025 at 11:30=E2=80=AFAM Xuewen Yan <xuewen.yan@unisoc.=
com> wrote:
> > >
> > > Add trace point to psi triggers. This is useful to
> > > observe the psi events in the kernel space.
> > >
> > > One use of this is to monitor memory pressure.
> > > When the pressure is too high, we can kill the process
> > > in the kernel space to prevent OOM.
> > >
> > > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > > ---
> > > V3:
> > > -export it in the tracefs;
> > > ---
> > > v2:
> > > -fix compilation error;
> > > -export the tp;
> > > -add more commit message;
> > > ---
> > >  include/trace/events/sched.h | 27 +++++++++++++++++++++++++++
> > >  kernel/sched/psi.c           |  4 ++++
> > >  2 files changed, 31 insertions(+)
> > >
> > > diff --git a/include/trace/events/sched.h b/include/trace/events/sche=
d.h
> > > index 7b2645b50e78..db8b8f25466e 100644
> > > --- a/include/trace/events/sched.h
> > > +++ b/include/trace/events/sched.h
> > > @@ -826,6 +826,33 @@ TRACE_EVENT(sched_wake_idle_without_ipi,
> > >         TP_printk("cpu=3D%d", __entry->cpu)
> > >  );
> > >
> > > +#ifdef CONFIG_PSI
> > > +TRACE_EVENT(psi_event,
> > > +
> > > +       TP_PROTO(int aggregator, int state, u64 threshold, u64 win_si=
ze),
> > > +
> > > +       TP_ARGS(aggregator, state, threshold, win_size),
> > > +
> > > +       TP_STRUCT__entry(
> > > +               __field(int,    aggregator)
> > > +               __field(int,    state)
> > > +               __field(u64,    threshold)
> > > +               __field(u64,    win_size)
> > > +       ),
> > > +
> > > +       TP_fast_assign(
> > > +               __entry->aggregator     =3D aggregator;
> > > +               __entry->state          =3D state;
> > > +               __entry->threshold      =3D threshold;
> > > +               __entry->win_size       =3D win_size;
> > > +       ),
> > > +
> > > +       TP_printk("aggregator=3D%d state=3D%d threshold=3D%llu window=
_size=3D%llu",
> > > +               __entry->aggregator, __entry->state, __entry->thresho=
ld,
> > > +               __entry->win_size)
> > > +);
> > > +#endif /* CONFIG_PSI */
> > > +
> > >  /*
> > >   * Following tracepoints are not exported in tracefs and provide hoo=
king
> > >   * mechanisms only for testing and debugging purposes.
> > > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > > index 59fdb7ebbf22..5b7954b653ed 100644
> > > --- a/kernel/sched/psi.c
> > > +++ b/kernel/sched/psi.c
> > > @@ -141,6 +141,8 @@
> > >  #include <linux/psi.h>
> > >  #include "sched.h"
> > >
> > > +EXPORT_TRACEPOINT_SYMBOL_GPL(psi_event);
> > > +
> > >  static int psi_bug __read_mostly;
> > >
> > >  DEFINE_STATIC_KEY_FALSE(psi_disabled);
> > > @@ -509,6 +511,8 @@ static void update_triggers(struct psi_group *gro=
up, u64 now,
> > >                 if (now < t->last_event_time + t->win.size)
> > >                         continue;
> > >
> > > +               trace_psi_event(aggregator, t->state, t->threshold, t=
->win.size);
>
> Again, this trace event should be generated only after cmpxchg()
> passes the check. Otherwise trace events might be generated when
> actual PSI events are not (false positives). That disconnect is not
> acceptable.

You=E2=80=99re absolutely right. I=E2=80=99ll resolve it in the next patch.

Thanks!

BR
---
xuewen

>
> > > +
> > >                 /* Generate an event */
> > >                 if (cmpxchg(&t->event, 0, 1) =3D=3D 0) {
> > >                         if (t->of)
> > > --
> > > 2.25.1
> > >


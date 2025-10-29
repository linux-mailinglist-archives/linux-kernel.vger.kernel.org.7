Return-Path: <linux-kernel+bounces-875555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E3AC1947D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD8755607ED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664283203A0;
	Wed, 29 Oct 2025 08:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxXGbBL2"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E998431D754
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761728026; cv=none; b=N98WyFmGB0wXSKx484s911o+G6oUJKcgy64nwCnMaRP4jN0T/Sp0gAr7LwVG5GMwRU2cHbXNKIdUG/OMpo1FgGzYSoVPkKigsZQE5LwcQt6YomtPmnvmwbFCCJqVYyTkIk52wtZ5uAO9Z8EOTtE45aBMASGwjmAFmRLIlOtNIqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761728026; c=relaxed/simple;
	bh=GgXi3IFD4khMbRVUgDdokPq8T2ol3b+mHwrZvtY/Whk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FDukDMKlLN+4ER5cthvJ6ZY/92zqSfYSQ1wqbr2S8NNEV30z0xLepb0D+RZqiifxrPaNYEUUp9iBRjWVc82kwP598MvUkcNJhWe4KwMS/yyVYXlWa3N0SmBASXUO0zciWzm+jpyZgsr+0zFmk+Z7TD7B3aBkkSZ8KUMFTiDxajI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxXGbBL2; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8a479c772cfso188260785a.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761728024; x=1762332824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0YC9aHtn6/N8JWKIzKhjnVeYntMBazlO129ehfMxK8=;
        b=FxXGbBL2mmd0P6U0Qegizfc5dM1+pLGGQQuFdmw+1UbHI7KBow/S3HV05o45eMIqRN
         l9qm33AkZgB8mfRvUWv39/6XwPzkLWcOBy5eVX0VHnn5QENCltKqZ4RxrypZbReb/aCM
         ddactJAb38iN2PX50eTpJnmjiS43B2BB5DmDvZap9E3nMP7VXGrxQiKvmP3PsZ/I4W1B
         /BBLwkuek6P6i/HYCAaS9wRrPEbt7vR5rOItdKO37kYVgt6cjQPn/ouT93rLwu79jEuO
         gqTygLDMRhCiEf9PQb53rd4dx4ceYwCKZ7+v4194l6ldxwkJbjss+UlY4pIb1ubkSOsG
         Ckyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761728024; x=1762332824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0YC9aHtn6/N8JWKIzKhjnVeYntMBazlO129ehfMxK8=;
        b=clWrsJH/3odWArwir73J/ZbJ98ESt2Nld48ZUJtv5hPYkj2QdYdpccAdIyCQQ0b1YQ
         KDjDixk3Ts27rwICSRYW5mubQmyZbyjbo7FVkDzT66XdhAEKVxJWWtfCa3JTfPEVBXv+
         /hE7yQC779Y9dr1zORbTOVTe+n13k7IvegNW5w4gimvyV8j/jJWN+2TVb4cfe7IrDf3d
         7Cn/0ym16zVFsGMP3GDgIJp4LM5OFvgqiOJGsiZEiDu5svYjE2M2T1W2IUZGx3D0n6WY
         iFflXuIo8KO4yfPex24pQzTPcLPs2Fr1gLVWgClUuQFbtDAaRWReErDUFPZb4BQJev1B
         pgFA==
X-Forwarded-Encrypted: i=1; AJvYcCUiJdUpxITlQ3rkcRNtfMt1oSp4F1Z+l6tpQuT92HjsyhYNPm/O2bluBOn0gQia/B+DAM5Ln5rg4Z+BtNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMuSUNRC7IUQ0oHiBIbiRELGJo2d5b6/5Net8ELjoL1HFVICHq
	VMsrEVYbPqX1XR1DaV5p5QOVgup1sJjh7viVG71j9VJ2ruCIYEJVo9F2iz3p+IkVuxAalJYYQPH
	TWjRtjWTg4ZhRrB6xBo53YgZi333dru8=
X-Gm-Gg: ASbGnctXXRViCxQ3kQup0CGO+O85FhbTo5sGkwqOycYVmXi5R3Ev6R7iA3JyoRP3eL0
	KA7EhEa/NPJ+FG5XA9XZxlLK3ySOdZ5TqH+1myWUVjvD/yZpHrLEVzFWsPSYnNfUwMimEe9o3OK
	ZkZYabPfVUw6Ie0r7DnsLAIZKdeTsmw7Zk1uzvE6lnKr0U1k2V0duvYAdyC6+N/npNEWWadZem1
	w2X341g8Prm8Dq30TRsQecRu5Oi8X6fCvb1fVrtB87h4GvFm3Wjk9fg0uTQlIh6IFmYvqJM
X-Google-Smtp-Source: AGHT+IH2B71/kc3HTyrPDh6Hr+KNmlZBKPsEB4Hh7UI6P8U+vDSp58QstAz7xx2CpuAEy42lac+d50QOuygrOB+PcvA=
X-Received: by 2002:a05:622a:8b:b0:4eb:d84d:f8a8 with SMTP id
 d75a77b69052e-4ed15c765b8mr29495401cf.83.1761728023822; Wed, 29 Oct 2025
 01:53:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929014227.430-1-xuewen.yan@unisoc.com> <CAJuCfpE_aZKFB8O=KPq5uTv=WeJf6TCmneMnr8pp88SNWy3K-Q@mail.gmail.com>
In-Reply-To: <CAJuCfpE_aZKFB8O=KPq5uTv=WeJf6TCmneMnr8pp88SNWy3K-Q@mail.gmail.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Wed, 29 Oct 2025 16:53:32 +0800
X-Gm-Features: AWmQ_bmmTUubVChVT-s2F8my_b3J_ptOUDR5Ybt9Nm3uomq03x8MMOcNrj2dLYU
Message-ID: <CAB8ipk8oC2UKJu6f6qun3PYFwrzGZUT=YjQhfNGaVrF4GM2wdA@mail.gmail.com>
Subject: Re: [RFC PATCH V4] sched: psi: Add psi events trace point
To: Suren Baghdasaryan <surenb@google.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, hannes@cmpxchg.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, ke.wang@unisoc.com, yuming.han@unisoc.com, 
	Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle ping....

Sorry to ask, but may I know if this patch can be merged into the mainline?

Thanks!

On Tue, Sep 30, 2025 at 7:17=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Sun, Sep 28, 2025 at 6:43=E2=80=AFPM Xuewen Yan <xuewen.yan@unisoc.com=
> wrote:
> >
> > Add trace point to psi triggers. This is useful to
> > observe the psi events in the kernel space.
> >
> > One use of this is to monitor memory pressure.
> > When the pressure is too high, we can kill the process
> > in the kernel space to prevent OOM.
>
> Just FYI, Roman is working on a BPF-based oom-killer solution [1]
> which might be also interesting for you and this tracepoint might be
> useful for Roman as well. CC'ing him here.
>
> [1] https://lore.kernel.org/all/20250818170136.209169-1-roman.gushchin@li=
nux.dev/
> >
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
>
> Acked-by: Suren Baghdasaryan <surenb@google.com>
>
> > ---
> > V4:
> > -generate the event only after cmpxchg() passes the check
> > ---
> > V3:
> > -export it in the tracefs;
> > ---
> > v2:
> > -fix compilation error;
> > -export the tp;
> > -add more commit message;
> > ---
> >  include/trace/events/sched.h | 27 +++++++++++++++++++++++++++
> >  kernel/sched/psi.c           |  5 +++++
> >  2 files changed, 32 insertions(+)
> >
> > diff --git a/include/trace/events/sched.h b/include/trace/events/sched.=
h
> > index 7b2645b50e78..db8b8f25466e 100644
> > --- a/include/trace/events/sched.h
> > +++ b/include/trace/events/sched.h
> > @@ -826,6 +826,33 @@ TRACE_EVENT(sched_wake_idle_without_ipi,
> >         TP_printk("cpu=3D%d", __entry->cpu)
> >  );
> >
> > +#ifdef CONFIG_PSI
> > +TRACE_EVENT(psi_event,
> > +
> > +       TP_PROTO(int aggregator, int state, u64 threshold, u64 win_size=
),
> > +
> > +       TP_ARGS(aggregator, state, threshold, win_size),
> > +
> > +       TP_STRUCT__entry(
> > +               __field(int,    aggregator)
> > +               __field(int,    state)
> > +               __field(u64,    threshold)
> > +               __field(u64,    win_size)
> > +       ),
> > +
> > +       TP_fast_assign(
> > +               __entry->aggregator     =3D aggregator;
> > +               __entry->state          =3D state;
> > +               __entry->threshold      =3D threshold;
> > +               __entry->win_size       =3D win_size;
> > +       ),
> > +
> > +       TP_printk("aggregator=3D%d state=3D%d threshold=3D%llu window_s=
ize=3D%llu",
> > +               __entry->aggregator, __entry->state, __entry->threshold=
,
> > +               __entry->win_size)
> > +);
> > +#endif /* CONFIG_PSI */
> > +
> >  /*
> >   * Following tracepoints are not exported in tracefs and provide hooki=
ng
> >   * mechanisms only for testing and debugging purposes.
> > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > index 59fdb7ebbf22..e8a7fd04ba9f 100644
> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -141,6 +141,8 @@
> >  #include <linux/psi.h>
> >  #include "sched.h"
> >
> > +EXPORT_TRACEPOINT_SYMBOL_GPL(psi_event);
> > +
> >  static int psi_bug __read_mostly;
> >
> >  DEFINE_STATIC_KEY_FALSE(psi_disabled);
> > @@ -515,6 +517,9 @@ static void update_triggers(struct psi_group *group=
, u64 now,
> >                                 kernfs_notify(t->of->kn);
> >                         else
> >                                 wake_up_interruptible(&t->event_wait);
> > +
> > +                       trace_psi_event(aggregator, t->state, t->thresh=
old,
> > +                                       t->win.size);
> >                 }
> >                 t->last_event_time =3D now;
> >                 /* Reset threshold breach flag once event got generated=
 */
> > --
> > 2.25.1
> >
> >


Return-Path: <linux-kernel+bounces-787446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D15B37653
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 02:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53F637AFB56
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 00:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD5D1F1306;
	Wed, 27 Aug 2025 00:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hAgvLoXN"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBC61D7995
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 00:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756256225; cv=none; b=ClYQNSwq6koBnlaY6QFCJOlV+Y7wuKm5+YE2BBHLsazzFa9NCwypP2RuP8U1kNShDwBH7jeTrcNfwyWfjRujds+I1vlby3Ak9GC6utJ0corXYITp9HNussNYY5BCnd5XZ3Zqy92DVWA47/1ZWOrjFNml3/tCBTheoiq9kFiavzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756256225; c=relaxed/simple;
	bh=Bt4kleOlMeoVIFsVHutd3DVwPInBA+RbnShS5/WY1oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RL/idIxRiLd28kFQkSf0QbhaXXE0YVOGuEXiwlAk+mT7FQz9d1m6GhEitZzRucgrk4vFMfHW79LSIXWGCzBETxb98nIYtAf3J0XmZpoeSGq6hCl2/DicQlf+tP6tq6GI4bGt7Jdwzf8GW/cJJIgYJ7thnZBOzYVKTylrj+8TXEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hAgvLoXN; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b29b715106so86301cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 17:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756256222; x=1756861022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyB0nMPsGsHLvBDgDRvjEn7HJuHzUpfEwwindsu9uAw=;
        b=hAgvLoXNsDTmKBV6J3ho6+NzHi870w2dfERJOlGaSERePLOMNu29w2o6KM6zpnwmNa
         qe0a1RPdeiZi0ddd0ZmPaXI292XgRQivvEgDHPrNld4+5UACfK81atsLPV6TVp2m6kJK
         /iWmhVv7TwNduY7KWs6ItjJeGdsON5vokhppuX44d1gOodG1l2/s1gA6judTqMBR9GjH
         xkeMX9TiAwP2iFBrPjRecTHBuKO0tbSQS2gynfOmUZNXpHLW53tRJerwLV6UqEJBOVr4
         pGsPYkGddcGTW0OXC8SVlD89KKVhiUhd0NRp48mKOjztLV2F+ccrCc3LkoHOgvrhQqBc
         8wTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756256222; x=1756861022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GyB0nMPsGsHLvBDgDRvjEn7HJuHzUpfEwwindsu9uAw=;
        b=Gg74Q5FsdZpy9CoEwZwpFtLOwvmcEdPMgo2/kbGvc8+8W5fyR07LvdboZ69l0RtbRG
         pVS0y/0kOeAraiyRkMKYPEFZoANCdhnn1v7rNQpEVRmlZs8ylGLUfqLu4DEz/vjZcrry
         C/eKBVjnW+yvMPG+AX46ngkm+0eOvwh6Z+J8f7cAXo2+wRrKcyoj71Y8STPwlqlURV8L
         /v6lA6uEjvp+ghaI2V0dBmMK7ZOP2L78qypFeu03L1rQJWaV3djIZ2twS1Tx8YCMTQOY
         6fBscAqVvJMf9zXsx908wreF5uBH1F31v8wDsD05PJRg9vbMaId8UDYA83bCxCut129I
         Qfbg==
X-Forwarded-Encrypted: i=1; AJvYcCUfiLk2dn0lks0q4rchlqyhBz8tFGLFGv/EeCntzKcpjyY/6HvWnIkNs8cGd/+52Qmzn/34z0PzY3nPzWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb/1N1vWZOe8UunAaq6QxOebmwVBCndqqYC8+TyzoTpL2kt5h0
	hKox4S67A8/DHfVJLsqVsdwxNykSmiGvbbG8paWDWi2d21clodk5gacUVv0w7SYGdolm7577fUt
	wIDsdCIPdwf5lQKVWbW8DKJRTEOq62EVsCoVPEGOp
X-Gm-Gg: ASbGncvB+Fljzwob614Ch1s2fKBH+cFE4/tYaBPA7IAybgUBhmA+hrUpvlyrKqamNcW
	wswYY7K2LJK+ZylEyIXaQMCl2qgUM2L0cQ63aYu+NvyT4zc/ezvfxI81UYBm6Y+qS7u8SNkHoz0
	QZ77XwxDKJDXdbfmgwDWAWvjsgj1qDJhUvgKd/nhkKcAaTR9LclJzd4Z37svW1CABW3CTlCve3g
	ghjbWWsR9iy
X-Google-Smtp-Source: AGHT+IF2RNqmMTGnuHEfygZt2E+RUopmUgxctnsuqMfRd3K+vRPpBT2sbgGshWXMhTnpEUqGl/OSf9a3d3dlDmFZUzg=
X-Received: by 2002:a05:622a:90:b0:4a6:f577:19bc with SMTP id
 d75a77b69052e-4b2e1d41dd5mr8757081cf.18.1756256221811; Tue, 26 Aug 2025
 17:57:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820112621.4045-1-xuewen.yan@unisoc.com> <CAJuCfpE1pJ8qhHgqvExktsMeTBbtVSK2rkE5SfeTE2nOYrNozQ@mail.gmail.com>
 <CAB8ipk8ywWv8j8OGugXjhwcZXj567LKULhLz7HS8Btx-_27yBQ@mail.gmail.com>
In-Reply-To: <CAB8ipk8ywWv8j8OGugXjhwcZXj567LKULhLz7HS8Btx-_27yBQ@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 26 Aug 2025 17:56:48 -0700
X-Gm-Features: Ac12FXx3zyQ4jOXFPysBzLfN6oFFk1WgxgFiwrnM6ZEE13jAo5NVfx1bXv2938o
Message-ID: <CAJuCfpGH4UKmuaVMAE-CCPo-J-Qzufs55_DDR0bPbzyOC8-deg@mail.gmail.com>
Subject: Re: [RFC PATCH V2] sched: psi: Add psi events trace point
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, hannes@cmpxchg.org, peterz@infradead.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, ke.wang@unisoc.com, yuming.han@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 6:51=E2=80=AFPM Xuewen Yan <xuewen.yan94@gmail.com>=
 wrote:
>
> Hi Suren,
>
> Thanks for your review:)
>
> On Thu, Aug 21, 2025 at 3:51=E2=80=AFAM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Wed, Aug 20, 2025 at 4:28=E2=80=AFAM Xuewen Yan <xuewen.yan@unisoc.c=
om> wrote:
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
> > > v2:
> > > -fix compilation error;
> > > -export the tp;
> > > -add more commit message;
> > > ---
> > >  include/trace/events/sched.h | 5 +++++
> > >  kernel/sched/psi.c           | 4 ++++
> > >  2 files changed, 9 insertions(+)
> > >
> > > diff --git a/include/trace/events/sched.h b/include/trace/events/sche=
d.h
> > > index 7b2645b50e78..d54db5fcbca2 100644
> > > --- a/include/trace/events/sched.h
> > > +++ b/include/trace/events/sched.h
> > > @@ -896,6 +896,11 @@ DECLARE_TRACE(sched_set_need_resched,
> > >         TP_PROTO(struct task_struct *tsk, int cpu, int tif),
> > >         TP_ARGS(tsk, cpu, tif));
> > >
> > > +struct psi_trigger;
> > > +DECLARE_TRACE(psi_event,
> >
> > DECLARE_TRACE will create a tracepoint but will not export it in the
> > tracefs. Why should we not have it in the tracefs?
>
> I haven't figured out what content should be displayed in the trace yet.
> Until this is fully determined, I think it might be a better option to
> just export the tracepoint and let users add their own hooks to print
> the content they need.

You can report what you think makes sense today for this tracepoint.
Tracepoints can be enhanced later if needed since their format is
exported to the userspace and well-designed userspace parsers should
be able to parse new fields.

>
> >
> > > +       TP_PROTO(struct psi_trigger *t),
> > > +       TP_ARGS(t));
> > > +
> > >  #endif /* _TRACE_SCHED_H */
> > >
> > >  /* This part must be outside protection */
> > > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > > index 59fdb7ebbf22..f06eb91a1250 100644
> > > --- a/kernel/sched/psi.c
> > > +++ b/kernel/sched/psi.c
> > > @@ -141,6 +141,8 @@
> > >  #include <linux/psi.h>
> > >  #include "sched.h"
> > >
> > > +EXPORT_TRACEPOINT_SYMBOL_GPL(psi_event_tp);
> >
> > So, are you planning to attach some handler to this trace event in your=
 driver?
>
> Yes, our modules would attach a handler to observe the memory pressure.
>
> >
> > > +
> > >  static int psi_bug __read_mostly;
> > >
> > >  DEFINE_STATIC_KEY_FALSE(psi_disabled);
> > > @@ -509,6 +511,8 @@ static void update_triggers(struct psi_group *gro=
up, u64 now,
> > >                 if (now < t->last_event_time + t->win.size)
> > >                         continue;
> > >
> > > +               trace_psi_event_tp(t);
> >
> > This should only be done if the below cmpxchg() check is true, right?
> > Otherwise it will not match with what userspace is receiving.
>
> If we put it below cmpxchg() check, we may lose some event before the
> user space repose the signal.
> Because the t->event needs to be set to 0 again.
> In order to ensure that all events are displayed, it is better to put
> it before the cmpxchg.

Huh? Are you modifying the t->event inside your handler?! If so, that
is unacceptable and I will NAK this change. A driver should not
interfere with core kernel mechanisms.

>
> Thanks!
>
> >
> > > +
> > >                 /* Generate an event */
> > >                 if (cmpxchg(&t->event, 0, 1) =3D=3D 0) {
> > >                         if (t->of)
> > > --
> > > 2.25.1
> > >


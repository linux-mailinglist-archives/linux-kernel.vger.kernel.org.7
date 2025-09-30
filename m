Return-Path: <linux-kernel+bounces-837041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F4ABAB24C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 05:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D78316467C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 03:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322CE2264CD;
	Tue, 30 Sep 2025 03:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iho6XU27"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04091E1A17
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 03:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759202368; cv=none; b=cNZvYS1SuA7LyHZhmd1ueALMATaLgvL3Ndbq+OY3pPs0u7XoaSjLCfb/Cf+KedsHq+UD/b2MT7d4MXXsxXQyamoOa61++lKiTaEzWee+3hvfCtH+LOiRidaTAkUQx9dysyzKlQA4LvIO1yorWyEewhUOho4NHsp7M3jQslAkAgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759202368; c=relaxed/simple;
	bh=EWb9mcMhPLwVON+FMrosPILezBfZreUUY4XVEf2hUEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iv0eVcIDJyApW/cj1roUig87zldcebTa64RLdY89HUw2cZ1nLPx2CZ97L5THHBrGrUdS67BMAKcyO0ZwSq/nI5vlmmaYTNpLSOoKt+XvAh/x/cBrRxoMu+mvrB4vb3tpyWSdsWMsDAGGAXOOSA9XFQQyeyeebDsk0vQOfkFMAEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iho6XU27; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4db385e046dso45705581cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 20:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759202366; x=1759807166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gLvWskKO9NISSvH7QfBj9yELCdtGhaDVZxapYCTDYM=;
        b=iho6XU27U1+lTVPV80ALwhC0dbbgdlJ7AmZ2q9Kx6mIgCivadXEHmkObO11ILNuPc1
         /kS+/B+8zKOmJm2qYwbBfKThGo3Mw9YWdXOyvxdQqPZ1M//vzHMOMHsDGS/75UeFHf6Y
         mspJ+V/jpNdvAz7S79uGDPWBCLR7XB4CySWTEkv2qupr0k1ar1jUiSTEX72x2h5ndOxx
         hJcwqAkTV356IcSjg4rbAXbwAqY60YtqJBjJ+guhZEVbUiXZLsuS7oJOoo3NDDP80MQh
         SnfoBOKnDMO4ZPhG6DNeP4XhqC1MGE7dTDpAKrgblDtDEpL1fAsjBExKF9g6Jyle+u2N
         wtFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759202366; x=1759807166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gLvWskKO9NISSvH7QfBj9yELCdtGhaDVZxapYCTDYM=;
        b=fd6TRMVQT0UntP+cgbxVE5/0VPpz3h/xI5Na89fwOKp8RxQPKtYggejfx5LC1aN+R/
         byyrl7cDIlE/cOCVTeLKtJasAgjich1ux7cpYs/eSN0rygs/7cW3sgPmOeNC5aNlG60Z
         cNvASPvVNWElcA01kLURBehMedjDpeQY1jHYHYr4RG+gwB+bI+tcYsvEKkHox4r8tC5w
         LlkAzpj+OTZ6k48mWxprLt773vuV/OCdfCz8ixRNqrC4DiC3o6ySpimG1Z+/poKT7GZ/
         S1Wqte6gmnLV0qBR5obte1+08Zj9nKEUaTHcZLq/9U8ihZ102jbCpdEcZ6S6jtGmUWii
         sa5g==
X-Forwarded-Encrypted: i=1; AJvYcCUyf7MpaRpaP3SKiaenoJsEIMFSbqquLpayCFIX9YhUmK2T97pjxgsqzNI3cl/T/js4QdR0I0j+lQ5fkUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz145d0YJidFSr2bQ6JNbFmJsU2dI/wl/AP+WHS+3Sf/9iN/D5y
	Jvyl0M1FX1BqeqXXrMLcX4DJpUr9AEmkgw0i1L3kKjdz7Wq8hWJTbjqgEGEh1YcRKxFd8PTom+3
	ETsZ78En0pzx3DZRnqSm3lDeL1MvIJ3s=
X-Gm-Gg: ASbGncsom+QYDeJ1JeQ7Kpg7Neb7e05456ru2B8aRNIVPZxWPX+gETokXn2b0E9c1qG
	cxCh/c0uet7mBvZqGCKMdPTs5S/DDa+NvulGKTdrsqzfB7XIVHrQ1Q0WAm/yDYyGUOYlE3m3Myt
	sVnhDSlK7Z+uaoDS8M/Lru03KBlnumFRTSpcI6CWvCQOnmvBq2onnRD9g9Ocj7ABMFFwFvydS74
	92K5poQAiCdMGUKp0AYyDlhpcfiDe8l
X-Google-Smtp-Source: AGHT+IGd4Yt2CfWqJpq73k06OIwopaib1H87KJ3xzxIVLa34fX7JZb5rHIKDJ+TX2zdm4gbM+lnCpPq/Chw0xggLkGQ=
X-Received: by 2002:ac8:580d:0:b0:4da:3218:e8da with SMTP id
 d75a77b69052e-4da478290d2mr252791301cf.17.1759202365587; Mon, 29 Sep 2025
 20:19:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929014227.430-1-xuewen.yan@unisoc.com> <CAJuCfpE_aZKFB8O=KPq5uTv=WeJf6TCmneMnr8pp88SNWy3K-Q@mail.gmail.com>
In-Reply-To: <CAJuCfpE_aZKFB8O=KPq5uTv=WeJf6TCmneMnr8pp88SNWy3K-Q@mail.gmail.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Tue, 30 Sep 2025 11:19:14 +0800
X-Gm-Features: AS18NWBcqZ0NvhkmG_UM6sVIJIDnxhwqtC9zPgp_yOox7W3dyUMwGXcx07PRGdA
Message-ID: <CAB8ipk-xw-wcCB=rSv5-aEANefww_JiB4nKRW1iFXxGOA3tW-Q@mail.gmail.com>
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

Thanks for the review and the bpf patch, I'm interested in these.
> >
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
>
> Acked-by: Suren Baghdasaryan <surenb@google.com>

Thanks!
---
BR
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


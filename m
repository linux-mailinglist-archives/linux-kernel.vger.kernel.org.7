Return-Path: <linux-kernel+bounces-828176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C5DB941BA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02BE51656C9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F81D25A63D;
	Tue, 23 Sep 2025 03:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mDvZiprr"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E371CAB3
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758598291; cv=none; b=ihmSaXmWc3YSeHdmYm/0zzuCFOlGKvIQMMvvo52zhzsWYCKGL3c05K3mxdfRH/xlnQDgb7i5TXdHDJeIqUkcdaPirh9Y08NhYsblcTuKSY4GymsjXSyyox64HWjph7IA5k4T1+6CgMBj0B7V5exojUo7uvXs9L1RNrvGAn5jBXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758598291; c=relaxed/simple;
	bh=rYtPIrmt0kZAQBBjvwr5VGhzxQCcEQBloCf401OHtGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FIqOVGOK23NVTvWxDyQn/fFIhEpk71Hz6H8ocGzF7PDvp4AVdKAUSTx5RKdPqqNKCHOZ5AzMetRvC5uAto+ZHu5ITBoNbvW0v++iGblZ/yuF9HMhSXV/8J7OhAuh7xMjflRsA3aRithhhDNMxe9qXJuM9kjKZQEc2HbVbsqmomc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mDvZiprr; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4c73047a75cso84641cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 20:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758598287; x=1759203087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WGJa7y47hpmLiB7kWkPwOGe9BYScK1xQQ88jtOYi+8=;
        b=mDvZiprrzsPwOMuwlT3f1b73QgW3Vm7Vl3oYoXvUl8cCLIh/JemNc0V9KtrvnljYhF
         h3t7OP7uwCwxoGRQXFpP3CAq6q8fPBB9BZz5WNNykS/MTnSsAkpX0m9xUjz06NzzaFKz
         71cFka9+DVrS3dJRaq2hA/yE2ynwZuaK5o/72fbIO5JDLp1CGDc3jxkjq6BZIb/lQQzv
         8HswoESEJrN5Ef82sfWV4YQYD4+/IxQjYfcj9SzASHy7bNwDO1XZ7LvmNi5/qBAQAwuC
         nUp8prEag6MMvupFcSCB9iGFOJAxuf7GwW9TyhWmrtYHcCCxMHHuf+syNKNXhvTDqBMc
         EFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758598287; x=1759203087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WGJa7y47hpmLiB7kWkPwOGe9BYScK1xQQ88jtOYi+8=;
        b=Fh7mj/4CY/tbQNZD0tal2u+US17prUiQ6S/2me1thxn+XZOK4A5Nc5d1XPKnnkPByk
         /V5Jsm478algUAIsYQ7xF0DUcGYBNCfA2HaglboOjlRonxb/KPXM/F9k+ovDrMbeic8U
         Qoz3jC9m2CJImcTVFjBvjtiMiL5F2DPepLOtF5T/f1R2vw9gMs3/wk+C3/vwoxQJhA/a
         4NOxIaisE0imHRAcCTk6aI0tjd/FRCUTgQTO77zDGnhZv99aX4KXRj/hV/CZBnv6uw7P
         P+AnXU8QDs7pbu/+WiHVzlhmUMlJCOZ3JHbG372lAtUdvTzqykhd3VgYeFaAcyVS885e
         5VsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9r37MfRwHRO5E3QiUwXHL52zvKy7PgLpqpeFVwyoPefnFCPSt8OFs4mKexKyqojTPjXEdLmApxMRUZkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWfTb7nJ0E5ZYAcP+n7JWfAtjrRl/FFIA3W3CV/IwsLlbUkGx1
	EEc98j6E3w+BHDE7jZeMqzP0QMkHUiRJyx77Lxd3lSv6lDNdCi88iPUeh/wTXfgspegDQ+Muno7
	tNVYA7OcH8a58qMocUYikgc0gMpf6iP6idGf5nLh9
X-Gm-Gg: ASbGncto7KXDnfvLjPzV5N907MDY1KJArH8S/xTXqU6uCqmIwTsyvazrG2GCy1wznjx
	izH9hPw/GawNTqZvgRRJK6o63zn1beIY3Gm0unRL4imreQZ3qh87m6gIoQD0R7D5/jsm3id21zn
	paKRwQIJsnwy0e5WGrphAKXHGdiCQgwoCgdac5422883UNFbLpRqKii+LAZUHb2npykF+6Rte10
	TpOCw==
X-Google-Smtp-Source: AGHT+IG9M9qI4Nu6K1UD7ZOVSyvPnjLxqQLvz9ibrnDfMGEymJWCboEwdEn7EdGDxZDLpHlNav/cGzt8JE8iiHnlja8=
X-Received: by 2002:a05:622a:1884:b0:4ca:c49a:549d with SMTP id
 d75a77b69052e-4d369607c85mr2577381cf.9.1758598287031; Mon, 22 Sep 2025
 20:31:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911032823.19064-1-xuewen.yan@unisoc.com> <CAB8ipk-xqbsNh6EQ42JFV8CqPeJR0gjObOKvSs=-b=qcuLQxfg@mail.gmail.com>
In-Reply-To: <CAB8ipk-xqbsNh6EQ42JFV8CqPeJR0gjObOKvSs=-b=qcuLQxfg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 22 Sep 2025 20:31:16 -0700
X-Gm-Features: AS18NWD0RZyd0dPQFmRzUC2-5ppOObz4yGCVgzRrO6RKH_SNijZZPS9mJqUNjg0
Message-ID: <CAJuCfpHVjDrng2=bCh=DBdn_LBK3-qVF46Jwm3_TFzCjQhn9CA@mail.gmail.com>
Subject: Re: [RFC PATCH V3] sched: psi: Add psi events trace point
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, hannes@cmpxchg.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, peterz@infradead.org, 
	rostedt@goodmis.org, mingo@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, ke.wang@unisoc.com, yuming.han@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 7:58=E2=80=AFPM Xuewen Yan <xuewen.yan94@gmail.com>=
 wrote:
>
> A very gentle ping on this patch.
> Best regards,
> Thanks!

Thanks! Sorry I missed it.

>
> On Thu, Sep 11, 2025 at 11:30=E2=80=AFAM Xuewen Yan <xuewen.yan@unisoc.co=
m> wrote:
> >
> > Add trace point to psi triggers. This is useful to
> > observe the psi events in the kernel space.
> >
> > One use of this is to monitor memory pressure.
> > When the pressure is too high, we can kill the process
> > in the kernel space to prevent OOM.
> >
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
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
> >  kernel/sched/psi.c           |  4 ++++
> >  2 files changed, 31 insertions(+)
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
> > index 59fdb7ebbf22..5b7954b653ed 100644
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
> > @@ -509,6 +511,8 @@ static void update_triggers(struct psi_group *group=
, u64 now,
> >                 if (now < t->last_event_time + t->win.size)
> >                         continue;
> >
> > +               trace_psi_event(aggregator, t->state, t->threshold, t->=
win.size);

Again, this trace event should be generated only after cmpxchg()
passes the check. Otherwise trace events might be generated when
actual PSI events are not (false positives). That disconnect is not
acceptable.

> > +
> >                 /* Generate an event */
> >                 if (cmpxchg(&t->event, 0, 1) =3D=3D 0) {
> >                         if (t->of)
> > --
> > 2.25.1
> >


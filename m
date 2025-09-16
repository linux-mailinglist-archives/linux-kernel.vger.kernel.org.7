Return-Path: <linux-kernel+bounces-817982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5078B58AF6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 03:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87D122A85CB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 01:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEF71F4168;
	Tue, 16 Sep 2025 01:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t3yX9JVb"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20461A9FA1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 01:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757985608; cv=none; b=mB04p/q9SGr0f/KZSxqJLBTWMVXCkp5akUZ4YSKPx+WDcjPr9A4Wg+rOvu3XtNrhmb+rR9vEKquiUHAGdU0qb72WT+blr2ViVX06REKEwT9WU3j45U4eXGQVEWGvs5JcPgiA/dpGyfHk6remDQoZnxdi8bus7tIFNXtuSP41Trs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757985608; c=relaxed/simple;
	bh=cM01dnJgl02gEB+Phpru3MuVElFaY7DE57Wpqf4bhF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFgNu1nKbtQy6rehwyTdRVp3Uyyj+vDrnf0otVNJRipamnzhZylWsEx3hvpTpRG4wAHkvqyftD+DaRQC0EgecRkCDnMolyJHlCHomCHOqCKm00dM/5dwpAk5nWOBymrliZaK9htF9A9PL98OdzQhjUSbJ078T+hY0NhJmNJ3DXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t3yX9JVb; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2637b6e9149so59205ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757985606; x=1758590406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oc+YeAQI9jR6qkHLGj/AqXsrGbk3uwxOS3oQGgb06Q=;
        b=t3yX9JVbsIp6PrRcKdGyGXvQay+V8nnFhsTTaf5l9/jqxO1qFuMbIepI02gcCktWev
         kwAaM23yLDrO5hJxRaAhat1GGs/3KOCwkmPpXfcVyhGyvfFW31LSS8mSr5DrePCRr8bP
         GGA9HKXeXdhUjEYiT5LkKQkQN6KaSCwJJx69l2uzigPSoy7F/oGqajy7oKn7RheZ63l1
         PvGWg4+riI3SpHUCr0O/usbSPbg3fiaJIYihBuNoJ/8KUDF5vcg/jEyamReExWHb/4eS
         iMJCOL9XyrrSleN9bao9DZdj2rZ7NeLjIfUE4tiLoGv081mOwhS+6buL8hXLe0sNYP3h
         mW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757985606; x=1758590406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7oc+YeAQI9jR6qkHLGj/AqXsrGbk3uwxOS3oQGgb06Q=;
        b=c5NHSvxKR7hHTfY50rpikftO1OKJvl3C6NwFQ3IqBRP97b5UZrgRub+OFK7gjpNxH8
         bG2HB4FlWMOasqIwWaG8Px049sughJgrQas6Yb0rnmpcrNADNLPq0EXIaYlxAz91mAs8
         zCXiGgbQG+C94CoJBOegcBbpM9ObL39RdpVl6Hvhx1r1sHHczMT/HJuSw3yBdVvIgufu
         nKMdh/q4v86zyL2eKQ0uCPYKCa1JFmTXyrqZj/doIvouCqXK8nkCP7X7Ty1RdlCGAyBY
         DDzf0p7ZzGypgBIbGWIxnCfttvqy+iD1WIWenmFgN8ULsf4Ge4Yk4RNofpAbXC7dTZEc
         v7pQ==
X-Forwarded-Encrypted: i=1; AJvYcCVc48W4ln334GXKPd/jde4VN8De+PECvDYQZy7M9L/lv/Cx697kaCJfVJDFIRYntJ0XFwa45Kmo/roZHuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVo9uniYKlS74TUNSMCkT5KPwr0oFTs1PVWN0j4MzpH4blJ/6J
	g68vltwVvy+CSi4TVSg1/BTl3P3B6xi5RY5zF3+FerSd2NKfM7M8VASqpKeSNb8lKt4SQRrEdz9
	7xVo+XBOXIvIgQuJokplyAmbkaTwpfjpttugMf2bW
X-Gm-Gg: ASbGncsa6sFq24CVFej9Khl0MrqZ3a34Sbq4sI95jOIdcwIFIn0Fi9neBkn648NdlyN
	OV0zsp39yqrfnPbxizg/5rcmXwet09LoG8X4BrAtgJoDoVN4e9d+xO4CG8U3by3pBPlcjQRmGCG
	Z+hQHKgmSW/+DNwhrtFCpYi4RlRIcMH0OJVeIohRnOcQ+0n0RJIyiB9dGQrGCVzraLIHIJrMqDP
	ynBnC9DUlcS+z9TL3eRDVWJ5iJBF2BLWZHpq4Avom7u
X-Google-Smtp-Source: AGHT+IGwZ42ey53/Z1K5ZBDUQkGoZ+OwR1FjybKwy+/iwpTMAHOkHJQAI64NHEH+hr7wN2JIw+Y3z5X+5jsNmO1nwh4=
X-Received: by 2002:a17:903:2c0b:b0:267:d7f8:4054 with SMTP id
 d9443c01a7336-267d7f84826mr65945ad.16.1757985605754; Mon, 15 Sep 2025
 18:20:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-8-kaleshsingh@google.com> <20250915194158.472edea5@gandalf.local.home>
In-Reply-To: <20250915194158.472edea5@gandalf.local.home>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Mon, 15 Sep 2025 18:19:53 -0700
X-Gm-Features: Ac12FXyOHF1j3BB1NncU7x-UTlGuAAFshnZvp_tnlmREINkio1gvvq5R2YkXEUw
Message-ID: <CAC_TJvconNNKPboAbsfXFBboiRCYgE2AN23ask1gdaj9=wuHAQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] mm/tracing: introduce max_vma_count_exceeded trace event
To: Steven Rostedt <rostedt@goodmis.org>
Cc: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	david@redhat.com, Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de, 
	kernel-team@android.com, android-mm@google.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 4:41=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Mon, 15 Sep 2025 09:36:38 -0700
> Kalesh Singh <kaleshsingh@google.com> wrote:
>
> > Needed observability on in field devices can be collected with minimal
> > overhead and can be toggled on and off. Event driven telemetry can be
> > done with tracepoint BPF programs.
> >
> > The process comm is provided for aggregation across devices and tgid is
> > to enable per-process aggregation per device.
>
> What do you mean about comm being used to aggregation across devices?
> What's special about this trace event that will make it used across devic=
es?
>
> Note, if BPF is being used, can't the BPF program just add the current
> comm? Why waste space in the ring buffer for it?
>
>
>
> > +
> > +TRACE_EVENT(max_vma_count_exceeded,
> > +
> > +     TP_PROTO(struct task_struct *task),
>
> Why pass in the task if it's always going to be current?
>
> > +
> > +     TP_ARGS(task),
> > +
> > +     TP_STRUCT__entry(
> > +             __string(comm,  task->comm)
>
> This could be:
>
>                 __string(comm, current)
>
> But I still want to know what makes this trace event special over other
> trace events to store this, and can't it be retrieved another way,
> especially if BPF is being used to hook to it?

Hi Steve,

Thanks for the comments and suggestion you are right we can use bpf to
get the comm. There is nothing special about this trace event.  I will
drop comm in the next revision.

The reason I did the task_struct parameter (current): I believe there
is a limitation that we must  specify at least 1 parameter to the
TRACE_EVENT()  PROTO and ARGS macros.

Is there some way to use this without needing a parameter?

I hit the build failure below, with no parameters:

In file included from mm/vma.c:10:
./include/trace/events/vma.h:10:1: error: expected parameter declarator
   10 | TRACE_EVENT(max_vma_count_exceeded,
      | ^
...

Below is the code for reference:

/* SPDX-License-Identifier: GPL-2.0 */
#undef TRACE_SYSTEM
#define TRACE_SYSTEM vma

#if !defined(_TRACE_VMA_H) || defined(TRACE_HEADER_MULTI_READ)
#define _TRACE_VMA_H

#include <linux/tracepoint.h>

TRACE_EVENT(max_vma_count_exceeded,

TP_PROTO(),

TP_ARGS(),

TP_STRUCT__entry(
__field(pid_t, tgid)
),

TP_fast_assign(
__entry->tgid =3D current->tgid;
),

TP_printk("tgid=3D%d", __entry->tgid)
);

#endif /*  _TRACE_VMA_H */

/* This part must be outside protection */
#include <trace/define_trace.h>

Thanks,
Kalesh

>
> -- Steve
>
>
> > +             __field(pid_t,  tgid)
> > +     ),
> > +
> > +     TP_fast_assign(
> > +             __assign_str(comm);
> > +             __entry->tgid =3D task->tgid;
> > +     ),
> > +
> > +     TP_printk("comm=3D%s tgid=3D%d", __get_str(comm), __entry->tgid)
> > +);
> > +


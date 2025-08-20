Return-Path: <linux-kernel+bounces-778449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D69AB2E5DD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 21:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E75B55E3EDC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 19:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30E426F2B2;
	Wed, 20 Aug 2025 19:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1eqanLi9"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834862F4A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 19:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755719512; cv=none; b=m4UYVimow4BB2FEAliZn+RjCYg4r3XaX5igviMG7CZNTrRtl71gEztBjeYPB1KLiTn7ZZUAUn6zaqwzitQA12afcrL0smTyNUSQee9yQcPXrJhm/5339VAT5QSMnmXpPsc89Cpz5y2KS1fY4cQcyogstAr4LoxaPWZmq0+Zwxyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755719512; c=relaxed/simple;
	bh=oVhGTM1znDO6F7FjpKVLrhKRWRws+kg+AB55yVd7m6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCQYIjoM8FMn32feH2I/W1Up8PTQVWr+AZYcJwHOWOhBQcc+IScpZy4HOqHDwuALE2fwoJn9Ebc2wcHixgKQYX6m2VjrG+kHHCXpbqVm/dafpvPmTSG+Nr/4F1S8s43Od7Eo05s2nb1jHtdOBbLpNrwRkv1VvMk61OKkvvLDLjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1eqanLi9; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b29b715106so13021cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 12:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755719509; x=1756324309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5vWw0dImYJhGaYdSw1CwEfTyC3R0fK1vETd+qU82OY=;
        b=1eqanLi9LOFZF6Wn5dJCE/efembwHyb/5z2eoRdp4ewMvspIoCJ++TrTVUZn6XUqeF
         qjBF8lK42F9W03wjTAA+V+/CyAERTIWrp/UXiXwT6a6msDppZDDPH3ImPjx07Sgm7Lqk
         SXZ2xSi8K5s+Ho5kNYcT1LDnU5JrbzaEHGzP/Dlt6w85YqFJdWqwV2hz9Z2evhOBT3tu
         U+c44Hl5gZLfEF8lYCkkfzEEZtngZ5axmIR/uie5SUUWl6xiwj7jHusIxibTqsJ5KuGb
         1/DumzJyvHYBtepsFj82oHAWIrJrb8tMzvCRipP50ZoEkl4tGq00PuOoiNSQOTQaYD1E
         25fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755719509; x=1756324309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5vWw0dImYJhGaYdSw1CwEfTyC3R0fK1vETd+qU82OY=;
        b=IuIwMU3hLmT01SXrsuE00sjbBBnkxQ+8/rSLSz4PhuLpy2RhpiB1T64GWXfr9rHyry
         FZ4fbFIQGGvf5xJ8f1BpgfyOdVRsRhz+RtkeDaAt1TsgAE19iDBzRTNe3xXvVD3gkjhZ
         F1R7bRbayp6HlVYJpE0ZXYi+V3Tt2fwF/RxGHrhKsAb3g6eYwn6nbcauohzQBlZaVPhU
         w8YScJNdhzCGQeqwP54Ur4zcz5jfVye+mU54oiH+DsKdtUOxqgUGq2RRHf5PoFu+Mb1O
         Fa4oOwrV9WFqSJ7g3JmPVxqGzFOQ+goY3mIvezlTUQINi2CJu4di2NaQC0yt1WLUnkOU
         W1yA==
X-Forwarded-Encrypted: i=1; AJvYcCU//LY0guxRSLGRQg0dzZuZGR25sg2sUYZG6ltaQ5NFFJLZ6q/yNrnnx+2Ui//TORPhlLGYFM0Qlb1dcL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMa5+OQbGkvEQO4Ebe61Oeu27PVlPl8ENihozwE474Nj+n5sD1
	sifzDVeac0kgSMGLe5XdgBEr+78irbJsS+uumZSsWR8lRYgkcK51GYgo/RtqfbKWyKnci7OHd8E
	y0SgRBjanbhACA0tTONI59He+Lzo2/C/guQhUsmIh
X-Gm-Gg: ASbGncvTENrS1L3d/5fN8vhxmtRM3NIZDBUQp/KeALTh3n4QXLhCaDy/IrME/sleG7W
	QIBIb67nSrEFneTLKRWmeK440fAcmt1/fTYKcOvGeDYqUHWf4ntid2yQjaQk9+QWgxS1z1FPD+k
	dUUsdljtMpkN9Zi8wV1Cfk9opkelG0TyvRMHP9/7iFDtrBwgdyHpToVX3wgDRi8k5IdwEkqoEv/
	aAQY5E1S3xNmywKejZv+MfLSPMSdcVzVYxa5cScTeJ5cGCrS4CVJ6k=
X-Google-Smtp-Source: AGHT+IFmZUSJrytsqPuwgDUy5DVDYRM42MCGIpeE67tmDdymvz8+SUmA2EGbfjRmGrougCGhxdFfnLTZ28Cybkub2ek=
X-Received: by 2002:a05:622a:1107:b0:4b2:9d13:e973 with SMTP id
 d75a77b69052e-4b29f242890mr96511cf.0.1755719508942; Wed, 20 Aug 2025 12:51:48
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820112621.4045-1-xuewen.yan@unisoc.com>
In-Reply-To: <20250820112621.4045-1-xuewen.yan@unisoc.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 20 Aug 2025 12:51:37 -0700
X-Gm-Features: Ac12FXwTo9rcFuIY0Vp0Ru30qbyMNYeq28H_AtMTQxUiAB3kpq5P_3A0q3lX588
Message-ID: <CAJuCfpE1pJ8qhHgqvExktsMeTBbtVSK2rkE5SfeTE2nOYrNozQ@mail.gmail.com>
Subject: Re: [RFC PATCH V2] sched: psi: Add psi events trace point
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: hannes@cmpxchg.org, peterz@infradead.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, rostedt@goodmis.org, mingo@redhat.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, yuming.han@unisoc.com, xuewen.yan94@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 4:28=E2=80=AFAM Xuewen Yan <xuewen.yan@unisoc.com> =
wrote:
>
> Add trace point to psi triggers. This is useful to
> observe the psi events in the kernel space.
>
> One use of this is to monitor memory pressure.
> When the pressure is too high, we can kill the process
> in the kernel space to prevent OOM.
>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
> v2:
> -fix compilation error;
> -export the tp;
> -add more commit message;
> ---
>  include/trace/events/sched.h | 5 +++++
>  kernel/sched/psi.c           | 4 ++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index 7b2645b50e78..d54db5fcbca2 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -896,6 +896,11 @@ DECLARE_TRACE(sched_set_need_resched,
>         TP_PROTO(struct task_struct *tsk, int cpu, int tif),
>         TP_ARGS(tsk, cpu, tif));
>
> +struct psi_trigger;
> +DECLARE_TRACE(psi_event,

DECLARE_TRACE will create a tracepoint but will not export it in the
tracefs. Why should we not have it in the tracefs?

> +       TP_PROTO(struct psi_trigger *t),
> +       TP_ARGS(t));
> +
>  #endif /* _TRACE_SCHED_H */
>
>  /* This part must be outside protection */
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 59fdb7ebbf22..f06eb91a1250 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -141,6 +141,8 @@
>  #include <linux/psi.h>
>  #include "sched.h"
>
> +EXPORT_TRACEPOINT_SYMBOL_GPL(psi_event_tp);

So, are you planning to attach some handler to this trace event in your dri=
ver?

> +
>  static int psi_bug __read_mostly;
>
>  DEFINE_STATIC_KEY_FALSE(psi_disabled);
> @@ -509,6 +511,8 @@ static void update_triggers(struct psi_group *group, =
u64 now,
>                 if (now < t->last_event_time + t->win.size)
>                         continue;
>
> +               trace_psi_event_tp(t);

This should only be done if the below cmpxchg() check is true, right?
Otherwise it will not match with what userspace is receiving.

> +
>                 /* Generate an event */
>                 if (cmpxchg(&t->event, 0, 1) =3D=3D 0) {
>                         if (t->of)
> --
> 2.25.1
>


Return-Path: <linux-kernel+bounces-828145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA6FB940CF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 04:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 862DE7A35AC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 02:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8912749E5;
	Tue, 23 Sep 2025 02:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwC+vmJB"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6259273D8A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758596317; cv=none; b=TpyUikF7jkVhjp9uRo0uQtl6LFosTEYGZr5nmtaPjlPvohNskIofBm5H8vfk2xsd+wNXJgnctjDSDkhLKoOJyR9Rk+b/uNHr0m/j4zwXxGtsfiH0AuQNDjGf+UiEW30FxlDrNs1MbONuDTP09diLbDvBgDbMfRoeb8CahSP3f5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758596317; c=relaxed/simple;
	bh=fpYR4QW2wW4FCm4U/+NZJ7rN2EAA7+srDce8CyXSl8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QcLMd/P83EKdAc+CMV1300Z9mfKMNVB832504rBVzSpuiTNX2ni/1zisUFEnbZBFMXInPuqh9Yb8CK+JzQtam29sn14JYT9H1l4UbVZ4RpSBSSnuyceDDnbxdNFBoIOBk2+lQCefuz7O5c2VrE1WMRxZSmhqBiNy2GhRLzt+bRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwC+vmJB; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b7a8ceaad3so49676631cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 19:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758596314; x=1759201114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgmFE8NyPxtWNVbnJjQRIewsFcDLkEA59+rLxuhJGiU=;
        b=LwC+vmJBhmXpRIHgL1OAhwJIH3uhKOHXvRHNnuVpd9l7quIFb9BJJqc1Ekg5K6D8yr
         c8h6Zoan9Ra4iAjFhLQ0sO1XM24k2xh/ffCWxxwCSg9XzV5nluKWCXa/mSQExNP/9eft
         DZ+QEOFXND6VT1ueQwr3Q2GvBhL0jLoAZxvyNaRdDnsS5WGsbVuln9Z1h6GSZIAfuT2H
         z9rporeVkKoafep3IwsK5uci5cylcXJFxfu2qeUKDoLgcyacAg7o6XrnyzQau1uf4suK
         /YBUdH8yRLzDT7VfiaFjC96jtWl/uejU2NSr9i4OaObFGplcTAlWnxW0jXZu3q1K+yow
         ep/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758596314; x=1759201114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgmFE8NyPxtWNVbnJjQRIewsFcDLkEA59+rLxuhJGiU=;
        b=KCx5b3aQrH+I+iSsWiy61KBfGmEStDqzfuJ74dgASTcA402BHALmCOtKzNftxxosqZ
         DmyH/juQI9ZXPEiels/SwE73/9pTZ29R911a6ET2NBTXZPv+ZueqPhwtHabi1ckK9ZpB
         9hhLM6iqYTwkusd3Q8p60wx/CN7ICycHgONZo4a+6hXcq55YS1jgMTwiO6w3pT85L6hy
         k1/x7KXyaCDQZa/7J5MZPY8Ftz7OFjCPISaJ0BtTTNFf8zMkaYt5AvE3gGMrFMgrhkWD
         au9IwlI0Jvxo74AIUhRXzd+ryE/OML4L2V2fdRPJjLCr8WworhluCVkevNImHbgwIjd+
         X3Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXvxhxLEGAIakctXkwuym9k1MCxa6FE5KRzvbJI/N48WvExb2CUXhopVOvXBK9VPt4aGZKp2AhMYzsztVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB03RfEWgL49oYvOYJy/glv+izgLnEslo72P9eGZDrAhFr0Ws3
	bmf1pZyALppOxQLXif/nVO1SyfYee4qsAqJMX2s8CWL9PAqw9kc0q2Wxc7l4th9z+5TYXttRyTs
	5Kfo2kU4gzbV49MAMt7X2DOJU1kxWBDc=
X-Gm-Gg: ASbGncvFw6xNnLVUb7iEfDzTmBDxFVx+DuA5V3L0eHQNB28RqX32aShjxcHVXnrhGJh
	on2KjGmOIAvtvKqSLHevojLgY9aLab3RW95m5/nHYdTXZ6J2tNcuzcoDzfJV6UJBnSvoon46NyX
	URJuUk+nnMcRR+6IZ+VUJDyOkROF3bOJzokKpeFA3Duy4IU/UMHCzeZm2EvP7A7AZ71don46/gj
	OhPq21a
X-Google-Smtp-Source: AGHT+IFZW7WjRGmacqszORYavQA2IQYjlmSFmAfp6CW27838ZxITwERU2my/dBd3yJuqWIRGlMZ7Z0AQrAQtSyA5Hg8=
X-Received: by 2002:a05:622a:180f:b0:4d3:5418:d53d with SMTP id
 d75a77b69052e-4d36e5df14cmr11781191cf.49.1758596314495; Mon, 22 Sep 2025
 19:58:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911032823.19064-1-xuewen.yan@unisoc.com>
In-Reply-To: <20250911032823.19064-1-xuewen.yan@unisoc.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Tue, 23 Sep 2025 10:58:23 +0800
X-Gm-Features: AS18NWCCUIeAZ-4H_0obSn-5cwL3SUq_PYAXZiA-NZ_PXafNwbJKkb_7jDbCEak
Message-ID: <CAB8ipk-xqbsNh6EQ42JFV8CqPeJR0gjObOKvSs=-b=qcuLQxfg@mail.gmail.com>
Subject: Re: [RFC PATCH V3] sched: psi: Add psi events trace point
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: surenb@google.com, hannes@cmpxchg.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, peterz@infradead.org, rostedt@goodmis.org, 
	mingo@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, yuming.han@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

A very gentle ping on this patch.
Best regards,
Thanks!

On Thu, Sep 11, 2025 at 11:30=E2=80=AFAM Xuewen Yan <xuewen.yan@unisoc.com>=
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
> V3:
> -export it in the tracefs;
> ---
> v2:
> -fix compilation error;
> -export the tp;
> -add more commit message;
> ---
>  include/trace/events/sched.h | 27 +++++++++++++++++++++++++++
>  kernel/sched/psi.c           |  4 ++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index 7b2645b50e78..db8b8f25466e 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -826,6 +826,33 @@ TRACE_EVENT(sched_wake_idle_without_ipi,
>         TP_printk("cpu=3D%d", __entry->cpu)
>  );
>
> +#ifdef CONFIG_PSI
> +TRACE_EVENT(psi_event,
> +
> +       TP_PROTO(int aggregator, int state, u64 threshold, u64 win_size),
> +
> +       TP_ARGS(aggregator, state, threshold, win_size),
> +
> +       TP_STRUCT__entry(
> +               __field(int,    aggregator)
> +               __field(int,    state)
> +               __field(u64,    threshold)
> +               __field(u64,    win_size)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->aggregator     =3D aggregator;
> +               __entry->state          =3D state;
> +               __entry->threshold      =3D threshold;
> +               __entry->win_size       =3D win_size;
> +       ),
> +
> +       TP_printk("aggregator=3D%d state=3D%d threshold=3D%llu window_siz=
e=3D%llu",
> +               __entry->aggregator, __entry->state, __entry->threshold,
> +               __entry->win_size)
> +);
> +#endif /* CONFIG_PSI */
> +
>  /*
>   * Following tracepoints are not exported in tracefs and provide hooking
>   * mechanisms only for testing and debugging purposes.
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 59fdb7ebbf22..5b7954b653ed 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -141,6 +141,8 @@
>  #include <linux/psi.h>
>  #include "sched.h"
>
> +EXPORT_TRACEPOINT_SYMBOL_GPL(psi_event);
> +
>  static int psi_bug __read_mostly;
>
>  DEFINE_STATIC_KEY_FALSE(psi_disabled);
> @@ -509,6 +511,8 @@ static void update_triggers(struct psi_group *group, =
u64 now,
>                 if (now < t->last_event_time + t->win.size)
>                         continue;
>
> +               trace_psi_event(aggregator, t->state, t->threshold, t->wi=
n.size);
> +
>                 /* Generate an event */
>                 if (cmpxchg(&t->event, 0, 1) =3D=3D 0) {
>                         if (t->of)
> --
> 2.25.1
>


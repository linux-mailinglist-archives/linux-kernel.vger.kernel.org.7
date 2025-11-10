Return-Path: <linux-kernel+bounces-894200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC7BC49769
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5397934BBC8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B85330B1F;
	Mon, 10 Nov 2025 21:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="BCuXwaGw"
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5419F32ED4C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 21:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762811793; cv=none; b=btwg94b4+qPYmDiEYIaNq63U0LW4aSE9HCXwjoQtITJAH5tpvt28Be2VXy/IFwfy+WPGapmVvb+fmPe4kI6AmzNhZSqTsREMFoYApZaOQ7iOJRPHrAv51EDws6qpoRcKYBUt67lj3js702zNt8dY7UrjDSVgwRbQhoRpF27g6Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762811793; c=relaxed/simple;
	bh=YdQkEd7BN6+h/jC85fJP17qHcLGxJekDZ7ZotjlxRiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CbwY/+ehGXmX4vUEgYbV+M+1r1qWgQdp2Q3e7Jq7lK5qDXKWeX2Fb8JAee8DbEYPlL94cTw4bq4yWXgRWcPO/x2UeZM8AsvXu/zdFeGQw2DBB5teu0US6uTsjVx2OxEt/ELyQYmvoKhLJCy+KvpBAFvRDhsQ/cLhQAw20i76vlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=BCuXwaGw; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-640daf41b19so354013d50.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1762811790; x=1763416590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBGv/ezsu5Nu8Kia5+lyxOyM9iwDFkTudN57nfIGJNs=;
        b=BCuXwaGw/DPj56kh5xFrevdWP3PNzRdK1DQ9R4CjgLSYAf2lqEZX2D45KiwUr1Lk5F
         O+n6GweTK2Y2O0baSB0l4Rg5RPyNv0wQArX1+5I4eV5bm7N3tl+Nxj7mcbjb2I3H0dRK
         yvabOnJs8+mHpZKF4MgAEidRiV3IYBG4b5PUx4yd7fG4ajl4+nsKXoZoKauU81wpHy0z
         HUZfhjOe8PVoGd93GdDn6R4TFyuOtm5mViWdPfe+6QjpsKO1PYL+TmG61UGEO7bUNVOy
         yziw3DKcujJ0kRoNmiYVJzjm6BBobOTE75h/VJg4ME61L2XCX/cAm4qTZ/qLMUES03an
         mtkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762811790; x=1763416590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HBGv/ezsu5Nu8Kia5+lyxOyM9iwDFkTudN57nfIGJNs=;
        b=xFvzvMsfCBssSjM4iZgz5+nfDvsXQJ8CGiMjH0828UtNy6G8fDFS4qtUoYomizw0zy
         FMqXVjZuUc8Zoc273h43uVizv7pjD6WKQ5+wGzhcWrZeDJdQKlb1jG084OVRAImMUQk8
         i4EN1qCFz+YyUtV+vH3ecs6F/n0L7lTHKL+2gN4LOYkX0ibz6ZLq6KvF65dW+a+nqxiW
         263nXAo8jE2C2PKjg6s4Vy58uy00/rV5oGDplPsFZQaK+UkgXz1awtlbWmtgJqDH98vZ
         MNtB/CL7TCQ8j9ViT7iDxxcJ+7hMCDl1WV6i/zVHvwbo2G2q9HRskoYhElpXmkoq8ybC
         bhVw==
X-Forwarded-Encrypted: i=1; AJvYcCX3+h0BpTsrPYY3JptU0qkRN3VT9k4G26l9pv/ZEbScAY//ZlllrxbEhTgkzHnswm6w3uAUVkb1BN42qs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnHGj2hqe+dYPD++lW9gVg//keJYXHanMWc35Ff4DhuT+0ncxk
	FZonF13WI8JtwEsagqmBpVRyo5wXxvWV55iWjuQCehzqaIplXBKRFjc2/lON5z3guB3IUkQIzRI
	8OhgUFbGCO1FYHbyMqXuijH5nEeQ5iXauqPPWJrYPHQ==
X-Gm-Gg: ASbGncs//A3ySCDlAPLfjbQmLnKqs92AcusZq3zLKQSIy7XQHXbwqR8vBnJlHwfvYo4
	B6zAwMoBobqn8/yFYvpav/8o5uEdVgp8JeMpHP3UPzrUGYl2b5lJFun/4YqUaICt4FFyuc1cUuF
	NLDxwW3k6ed/pDHD/SjgJi/0VFiOyh9GyF4EQz+rroXmV9i0O590fsaD36ST7wgxKjE9CFpTLpP
	Ty3vnNbleY/QHhXXzLu7vyncrNQqPRVi6k7MgLgB6Y/aRXD2omEtXNHAAUDYv4=
X-Google-Smtp-Source: AGHT+IHCr6GIvLHDQyg/etbAgX3Qx1oJCVQraKrWlGLG42IF0yIv0gzfVCym/QH5ldNJLYjcKXYRDL8/olyRiOOPhr8=
X-Received: by 2002:a05:690e:140d:b0:63f:bb1b:b63a with SMTP id
 956f58d0204a3-640f735ece7mr855546d50.11.1762811790007; Mon, 10 Nov 2025
 13:56:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110205636.405592-1-tj@kernel.org> <20251110205636.405592-3-tj@kernel.org>
In-Reply-To: <20251110205636.405592-3-tj@kernel.org>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Mon, 10 Nov 2025 16:56:19 -0500
X-Gm-Features: AWmQ_blHcJtCFoKEPJw7CGCr7uwdPwo4N7tnDQSFaLHmTAvc-H5jhOXiPJsQi0I
Message-ID: <CABFh=a4FndcB1-Fimh68uQqXtHCXkGt4vgLb1SmCVW7D7nU-aQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] sched_ext: Make slice values tunable and use
 shorter slice in bypass mode
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <andrea.righi@linux.dev>, 
	Changwoo Min <changwoo@igalia.com>, Dan Schatzberg <schatzberg.dan@gmail.com>, 
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 3:57=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> There have been reported cases of bypass mode not making forward progress=
 fast
> enough. The 20ms default slice is unnecessarily long for bypass mode wher=
e the
> primary goal is ensuring all tasks can make forward progress.
>
> Introduce SCX_SLICE_BYPASS set to 5ms and make the scheduler automaticall=
y
> switch to it when entering bypass mode. Also make the bypass slice value
> tunable through the slice_bypass_us module parameter (adjustable between =
100us
> and 100ms) to make it easier to test whether slice durations are a factor=
 in
> problem cases.
>
> v2: Removed slice_dfl_us module parameter. Fixed typos (Andrea).
>
> Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
> Cc: Emil Tsalapatis <etsal@meta.com>
> Cc: Andrea Righi <andrea.righi@linux.dev>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  include/linux/sched/ext.h | 11 +++++++++++
>  kernel/sched/ext.c        | 34 +++++++++++++++++++++++++++++++---
>  2 files changed, 42 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> index eb776b094d36..60285c3d07cf 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -17,7 +17,18 @@
>  enum scx_public_consts {
>         SCX_OPS_NAME_LEN        =3D 128,
>
> +       /*
> +        * %SCX_SLICE_DFL is used to refill slices when the BPF scheduler=
 misses
> +        * to set the slice for a task that is selected for execution.
> +        * %SCX_EV_REFILL_SLICE_DFL counts the number of times the defaul=
t slice
> +        * refill has been triggered.
> +        *
> +        * %SCX_SLICE_BYPASS is used as the slice for all tasks in the by=
pass
> +        * mode. As making forward progress for all tasks is the main goa=
l of
> +        * the bypass mode, a shorter slice is used.
> +        */
>         SCX_SLICE_DFL           =3D 20 * 1000000, /* 20ms */
> +       SCX_SLICE_BYPASS        =3D  5 * 1000000, /*  5ms */
>         SCX_SLICE_INF           =3D U64_MAX,      /* infinite, implies no=
hz */
>  };
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index cf8d86a2585c..abf2075f174f 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -143,6 +143,32 @@ static struct scx_dump_data scx_dump_data =3D {
>  /* /sys/kernel/sched_ext interface */
>  static struct kset *scx_kset;
>
> +/*
> + * Parameters that can be adjusted through /sys/module/sched_ext/paramet=
ers.
> + * There usually is no reason to modify these as normal scheduler operat=
ion
> + * shouldn't be affected by them. The knobs are primarily for debugging.
> + */
> +static u64 scx_slice_dfl =3D SCX_SLICE_DFL;
> +static unsigned int scx_slice_bypass_us =3D SCX_SLICE_BYPASS / NSEC_PER_=
USEC;
> +
> +static int set_slice_us(const char *val, const struct kernel_param *kp)
> +{
> +       return param_set_uint_minmax(val, kp, 100, 100 * USEC_PER_MSEC);
> +}
> +
> +static const struct kernel_param_ops slice_us_param_ops =3D {
> +       .set =3D set_slice_us,
> +       .get =3D param_get_uint,
> +};
> +
> +#undef MODULE_PARAM_PREFIX
> +#define MODULE_PARAM_PREFIX    "sched_ext."
> +
> +module_param_cb(slice_bypass_us, &slice_us_param_ops, &scx_slice_bypass_=
us, 0600);
> +MODULE_PARM_DESC(slice_bypass_us, "bypass slice in microseconds, applied=
 on [un]load (100us to 100ms)");
> +
> +#undef MODULE_PARAM_PREFIX
> +
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/sched_ext.h>
>
> @@ -919,7 +945,7 @@ static void dsq_mod_nr(struct scx_dispatch_q *dsq, s3=
2 delta)
>
>  static void refill_task_slice_dfl(struct scx_sched *sch, struct task_str=
uct *p)
>  {
> -       p->scx.slice =3D SCX_SLICE_DFL;
> +       p->scx.slice =3D scx_slice_dfl;
>         __scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
>  }
>
> @@ -2892,7 +2918,7 @@ void init_scx_entity(struct sched_ext_entity *scx)
>         INIT_LIST_HEAD(&scx->runnable_node);
>         scx->runnable_at =3D jiffies;
>         scx->ddsp_dsq_id =3D SCX_DSQ_INVALID;
> -       scx->slice =3D SCX_SLICE_DFL;
> +       scx->slice =3D scx_slice_dfl;
>  }
>
>  void scx_pre_fork(struct task_struct *p)
> @@ -3770,6 +3796,7 @@ static void scx_bypass(bool bypass)
>                 WARN_ON_ONCE(scx_bypass_depth <=3D 0);
>                 if (scx_bypass_depth !=3D 1)
>                         goto unlock;
> +               scx_slice_dfl =3D scx_slice_bypass_us * NSEC_PER_USEC;
>                 bypass_timestamp =3D ktime_get_ns();
>                 if (sch)
>                         scx_add_event(sch, SCX_EV_BYPASS_ACTIVATE, 1);
> @@ -3778,6 +3805,7 @@ static void scx_bypass(bool bypass)
>                 WARN_ON_ONCE(scx_bypass_depth < 0);
>                 if (scx_bypass_depth !=3D 0)
>                         goto unlock;
> +               scx_slice_dfl =3D SCX_SLICE_DFL;
>                 if (sch)
>                         scx_add_event(sch, SCX_EV_BYPASS_DURATION,
>                                       ktime_get_ns() - bypass_timestamp);
> @@ -4776,7 +4804,7 @@ static int scx_enable(struct sched_ext_ops *ops, st=
ruct bpf_link *link)
>                         queue_flags |=3D DEQUEUE_CLASS;
>
>                 scoped_guard (sched_change, p, queue_flags) {
> -                       p->scx.slice =3D SCX_SLICE_DFL;
> +                       p->scx.slice =3D scx_slice_dfl;
>                         p->sched_class =3D new_class;
>                 }
>         }
> --
> 2.51.2
>
>


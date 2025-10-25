Return-Path: <linux-kernel+bounces-870155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE751C0A102
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 01:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 608403AECFC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 23:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1347A2DAFA8;
	Sat, 25 Oct 2025 23:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="v/Xafbn6"
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7081E32CF
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 23:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761434237; cv=none; b=UoIiyBp+e11sJ3XSQ5S1SX2fEqsRu1lzl6iZM+OlaF0X+vTjlCxzuAdDCFjvO+71mGao2mdZIghHglQiKBh1nd9+zs/XXrHEZ7E+2rQvtdQULSOnWRn1+BjThFeYAFKYkrbvhHR44Nqytab23vHcQuPgt731ZW3FyBHqwGxDbSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761434237; c=relaxed/simple;
	bh=pwPK/2SaTSzIG6JsYkEuwkznjmpXv6O29jp/nG6rXFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VrLGiWnQEw79bEt6/HtdSsgEFLMdbW50Z+QAgFHZoOWhm4NMv8jbohZIID1nV+TRyntvllXi86WgSGZyALy5Ti56KAYEE29BFA3hlWuaYtcKoYJGJcCu9eut59DmUJS261aV1sM9kDTSBw94xrCba+U1v2CzhHhgGQiedM9GXBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=v/Xafbn6; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-63e18577613so3416349d50.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1761434234; x=1762039034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Is1zpHnQGeBcCGpOoP92nGMnAqo9+w2bQCU7loHSWoo=;
        b=v/Xafbn6SidTxWOOq7o7jypzzPxFNG3SA1yRB83jNvdRxRCRLHnlbdfi6Y+xhC/P0h
         s0LfUdrluBmlYrT2iyYGHhJPhcq1vlayiYpBsD+Yw5cPWEsbejyV3vgrvhBVTCcmHXdH
         e9sfTTYG2fYRQpanP641MGAjMzF/jE9J19Oz084yzT0qxL/ykvDXl1z01YjfFBsfVhB3
         oFSVYoyHe7BGTp/QP2AG1xsp+lOgHz/Ylw+hnqg1dUdylCXysAiALwFtNWL5qpuhBv7r
         h5Zu3mRkhHKZgd16zPf+ccAR1ija3RQLUq+2YN5ciKgVsp7PHGayRSJjX21maZUaGhOr
         WcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761434234; x=1762039034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Is1zpHnQGeBcCGpOoP92nGMnAqo9+w2bQCU7loHSWoo=;
        b=LT0JSPPr4DSB2A4oVt7k6F10BhoNlw5zpemmk/Eh0cWrmHEz4WD7JmOTtjSD7M+E/U
         oZ1Ym1YAoJVKKV14Gyc5Rd00DrQ30X2OM6j5mf5ZVfXjJAOJfXBzOsmljkRp8BYBVI5F
         vD9IZ090b8oLZo+eimhMps9Ay7pUIgTf6K8qiOn0uEYrKR4gihl8G/xL/KDxSB+N3Mvw
         11VAIcPOGhz+43VuuTj5xu/yCtF3/EVT4LN2dvZfFzgyMa3plba4C300M0dgfUa0TOaK
         khr6yfSaF5lVg1ZuURzVP+7IEqBToumm9ekn0XxRMb5MZvUsL7Vu5UYQ4j/YSa6mbHAF
         Yg0g==
X-Forwarded-Encrypted: i=1; AJvYcCU1dxiwEhTBccpAIKRYeU5zGzYDGv0hi+KYXTL5YFdtrHEVTSbw3VINhAN4rFYziTnNDDKNqnvgQJkYopU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy9VnAnKRG6xUrFFNpWiy98OiCDjoLFbKVVetFjPpobqh/DSrl
	1Xi8Vbios7aN0L/gzVbIDHlFdMusAdFfNi5EyLbaCsrWY6s0Jai74xvKsfWMVL08oYxII/Mk2FB
	M8/WiiUXdU6DHox6uEDITxccOnaM4s6iE3x47dY67vg==
X-Gm-Gg: ASbGncvVTxR1A2SRO5dtSao+APZJdfE5rxy7EP1107PBRnb/fvq3CNGD38zMSE5dvYN
	IB390BrnwzrvycnplVaeZYP8DlQ2BamTxEdqR5kmbCgklSHirdiDEP6QW8T3CyLuU9xmLN112l3
	pxw66JtY0rWuRLLcn9EH+ZtAfYmhZxT53TyiTjPArrAKJ3VMuA5NJORlTXBT04O62FvCCGs3Pl/
	JrQpMk6rxFIggwf5DlzYkNdzKZp/NMPjmleNYPUTzShPExLgm8ceqZKembAibE=
X-Google-Smtp-Source: AGHT+IFnZfRhn/WCV55iETc9hoxuumH+Oiddyh5cq60hBfpxfH6eutR6B09THJYqpfUb4g0f/WxZ1l7W+Yn/aqCPvT8=
X-Received: by 2002:a05:690e:1483:b0:63e:2959:9f66 with SMTP id
 956f58d0204a3-63e29599fd6mr20541585d50.62.1761434234033; Sat, 25 Oct 2025
 16:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025001849.1915635-1-tj@kernel.org> <20251025001849.1915635-2-tj@kernel.org>
In-Reply-To: <20251025001849.1915635-2-tj@kernel.org>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Sat, 25 Oct 2025 19:17:03 -0400
X-Gm-Features: AWmQ_blZHqBCs6hg_fqxPsQWGrDJYGQQBCt1UgcV30-Y5DSrgamg-z2nSXz9sUI
Message-ID: <CABFh=a4gb7GcbMP-gB0tWXtsFtgYkpVz9NtBA1f-Ne5VWzSpmw@mail.gmail.com>
Subject: Re: [PATCH 1/3] sched_ext: Split schedule_deferred() into locked and
 unlocked variants
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <andrea.righi@linux.dev>, 
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org, 
	sched-ext@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>, 
	Wen-Fang Liu <liuwenfang@honor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 8:18=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> schedule_deferred() currently requires the rq lock to be held so that it =
can
> use scheduler hooks for efficiency when available. However, there are cas=
es
> where deferred actions need to be scheduled from contexts that don't hold=
 the
> rq lock.
>
> Split into schedule_deferred() which can be called from any context and j=
ust
> queues irq_work, and schedule_deferred_locked() which requires the rq loc=
k and
> can optimize by using scheduler hooks when available. Update the existing=
 call
> site to use the _locked variant.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

I assume we don't really care about ba

>  kernel/sched/ext.c | 33 ++++++++++++++++++++++++---------
>  1 file changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 000000000000..111111111111 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -775,12 +775,28 @@ static void deferred_irq_workfn(struct irq_work *ir=
q_work)
>   * schedule_deferred - Schedule execution of deferred actions on an rq
>   * @rq: target rq
>   *
> - * Schedule execution of deferred actions on @rq. Must be called with @r=
q
> - * locked. Deferred actions are executed with @rq locked but unpinned, a=
nd thus
> - * can unlock @rq to e.g. migrate tasks to other rqs.
> + * Schedule execution of deferred actions on @rq. Deferred actions are e=
xecuted
> + * with @rq locked but unpinned, and thus can unlock @rq to e.g. migrate=
 tasks
> + * to other rqs.
>   */
>  static void schedule_deferred(struct rq *rq)
>  {
> +       /*
> +        * Queue an irq work. They are executed on IRQ re-enable which ma=
y take
> +        * a bit longer than the scheduler hook in schedule_deferred_lock=
ed().
> +        */
> +       irq_work_queue(&rq->scx.deferred_irq_work);
> +}
> +
> +/**
> + * schedule_deferred_locked - Schedule execution of deferred actions on =
an rq
> + * @rq: target rq
> + *
> + * Schedule execution of deferred actions on @rq. Equivalent to
> + * schedule_deferred() but requires @rq to be locked and can be more eff=
icient.
> + */
> +static void schedule_deferred_locked(struct rq *rq)
> +{
>         lockdep_assert_rq_held(rq);
>
>         /*
> @@ -812,12 +828,11 @@ static void schedule_deferred(struct rq *rq)
>         }
>
>         /*
> -        * No scheduler hooks available. Queue an irq work. They are exec=
uted on
> -        * IRQ re-enable which may take a bit longer than the scheduler h=
ooks.
> -        * The above WAKEUP and BALANCE paths should cover most of the ca=
ses and
> -        * the time to IRQ re-enable shouldn't be long.
> +        * No scheduler hooks available. Use the generic irq_work path. T=
he
> +        * above WAKEUP and BALANCE paths should cover most of the cases =
and the
> +        * time to IRQ re-enable shouldn't be long.
>          */
> -       irq_work_queue(&rq->scx.deferred_irq_work);
> +       schedule_deferred(rq);
>  }
>
>  /**
> @@ -1211,7 +1226,7 @@ static void direct_dispatch(struct scx_sched *sch, =
struct task_struct *p,
>                 WARN_ON_ONCE(p->scx.dsq || !list_empty(&p->scx.dsq_list.n=
ode));
>                 list_add_tail(&p->scx.dsq_list.node,
>                               &rq->scx.ddsp_deferred_locals);
> -               schedule_deferred(rq);
> +               schedule_deferred_locked(rq);
>                 return;
>         }
>
> --
> 2.47.1
>


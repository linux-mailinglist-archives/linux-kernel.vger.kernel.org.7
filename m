Return-Path: <linux-kernel+bounces-894188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D93AC49703
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1BF0A4E97D9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5443E330330;
	Mon, 10 Nov 2025 21:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="TxP2d+gZ"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03351FF61E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 21:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762811017; cv=none; b=lhla2Ll5JXUSbS5AHPgI6vUvlZHSW69Dp602eYCfgtZknVpie/gj9qSCV/xqKeaCw2TLAbbQ1bY+zdgEp2Xeb9hAeqwTFDzLKNAIg5KBSTLvjKTxG58K5aa1H7DZfnEz8YJo2Xg2XLC4RwVNNqcqI9bMjw1YqkSNYOkvC+PTagE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762811017; c=relaxed/simple;
	bh=ly0mOtDUxX4tWKt/IjWg13ihHqNVJ1ciiWMf2fJAHVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hip4LXGm/Q9Zzlk2sKHffSrOUOIzNQv57RgdK6VflZbznpSQfEdmfGyJk0S+D9fxNYadYi/ZvflQdSjLrf1/Y6X2JrJXUeSo0Nf+gMqBal+u+WplZ0l8keOcO41upL8ueKI8wq6yu9j+WDHcCOIAkESUsM1ssSUDujJqbCR7XbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=TxP2d+gZ; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-780fe76f457so35011767b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1762811014; x=1763415814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R91J38Rt95DFLbNanTrQ2Sogh6MvPxM64piJrtd8qMs=;
        b=TxP2d+gZumAI/cmx88p89yIuNWZO59UguD235gK+WdZrfW12+lMRoj6S+W7J6rZ0yA
         baj0vbqmE6oQtxCffo9ofMLQS1uEq0uUj7GoyHhadwccgpz/ifQNZYpH3/bmKZRW53uH
         ZT/Wot3U3B0j0N33AO5zk96oJRDuGON43OV67eHaQp3S5Xgyd0wB7uzVfTjw83i70HAD
         sCFgKH85ggzwuhwbemt0NlM1wqNkDjN/CCLX5XkFzp01jkujY1Gb+N4iddbo132stFOm
         IpAyAHWP6nG9IwqazHWcZQkpOTi3BicjA91p3zPNdCkHprrxo8Y27l4wvHMCMrBDkrAg
         gp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762811014; x=1763415814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R91J38Rt95DFLbNanTrQ2Sogh6MvPxM64piJrtd8qMs=;
        b=NY9atxWh3VdUOFvMUdksxLZDPagfiARXUAEqNvUWuK62fm3kHmULToKmDmUkwJlI22
         IHrl9wGeFYPM+7QTzTLJdTr/yfQAHXjsgIGGGmMjbLDDOegbXcATXAD6B0Uyqgzn2GG6
         7GmtEiKvnHpFMqmPNFV8ml7TxKkxrnI8WdbJQ0iC6jBqVkVQtVagi6sgEN/LbTE2juzG
         vMgMYhykCiARDwPRvR0U0u/urUQcPn4TBtX0vKF6Gqf5oxaN1Qs2pn3noCsVcBoZu28c
         n4myoBdv/dw2ho4oYMeOGeGGeTY8Da8XK3wMIkOq79/QS+YRKWiZW8I103CGFWb4ePQE
         uIdw==
X-Forwarded-Encrypted: i=1; AJvYcCUCOMEk9X2I6yWYu4qgqIw4j8SKk5V/mmUdDsawMBSmq/e5vm9ZAJYiIOIyqrsBi9+z89S6DgfUzjIeDj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvJXkPboH0Jx/hKpWAHipYzyJlKV4ubgSmMY5NiHdjxaaRCDnL
	sJTyFRnA25r1pIYOz19jBvhle7mybXIauCeOQi/RNXgC+WtDDCqQI8hZb5N3PpiqQU6UQr+x06x
	1yl8y3N/yBHT34xoSULz8kAHg6VgxDmSubb+EJnzgKA==
X-Gm-Gg: ASbGncvWeUZzbz2YklJxw9ifRexf5MTGI5Qf1+FEKBY0lGuLmG3y7tHfRx/uiaqSe15
	ZlQ3JbsWYBhX50EcPRLY6mt4cYZQydFw25jfAxm1i80Sc5750+Vs7A5qhZW5fnU7ImLdCRARGyE
	eFmUwyopdy/6mc35lLiPVGZZzvIpq1fn1n8CeUBNtxfKW8k10k1xAMs2VZlbUhEAUIL9+BZ3M1J
	MzMYTX26Oxmj6GgaK8aYZ9pgtcaOycKCYkchStIGNI1KgqbylDHKZRlozNryx85VTsYi/RsEQ==
X-Google-Smtp-Source: AGHT+IFm7fT23uFvjsyYyTFiMGYENtJY5fIpQe9drynzp+/2LbShu0VQNgJLN7iovx2xtPyFQG/WqLQIy+6ziKMWBtw=
X-Received: by 2002:a05:690c:6ac9:b0:787:ca87:595c with SMTP id
 00721157ae682-787d53527cemr163023057b3.9.1762811014498; Mon, 10 Nov 2025
 13:43:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110205636.405592-1-tj@kernel.org> <20251110205636.405592-5-tj@kernel.org>
In-Reply-To: <20251110205636.405592-5-tj@kernel.org>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Mon, 10 Nov 2025 16:43:23 -0500
X-Gm-Features: AWmQ_blnzkBg837GPO32wah8Id-a_1xg9pBvasKGI39IKeqxzCA1Y_g3Kae1WzY
Message-ID: <CABFh=a6rP08+vsK11Ubi5qv2o2yOYFSoiMMM8ZahSVy=LzXpow@mail.gmail.com>
Subject: Re: [PATCH v2 04/14] sched_ext: Use per-CPU DSQs instead of per-node
 global DSQs in bypass mode
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <andrea.righi@linux.dev>, 
	Changwoo Min <changwoo@igalia.com>, Dan Schatzberg <schatzberg.dan@gmail.com>, 
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Andrea Righi <arighi@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 3:56=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Bypass mode routes tasks through fallback dispatch queues. Originally a s=
ingle
> global DSQ, b7b3b2dbae73 ("sched_ext: Split the global DSQ per NUMA node"=
)
> changed this to per-node DSQs to resolve NUMA-related livelocks.
>
> Dan Schatzberg found per-node DSQs can still livelock when many threads a=
re
> pinned to different small CPU subsets: each CPU must scan many incompatib=
le
> tasks to find runnable ones, causing severe contention with high CPU coun=
ts.
>
> Switch to per-CPU bypass DSQs. Each task queues on its current CPU. Defau=
lt
> idle CPU selection and direct dispatch handle most cases well.
>
> This introduces a failure mode when tasks concentrate on one CPU in
> over-saturated systems. If the BPF scheduler severely skews placement bef=
ore
> triggering bypass, that CPU's queue may be too long to drain, causing RCU
> stalls. A load balancer in a future patch will address this. The bypass D=
SQ is
> separate from local DSQ to enable load balancing: local DSQs use rq locks=
,
> preventing efficient scanning and transfer across CPUs, especially proble=
matic
> when systems are already contended.
>
> v2: Clarified why bypass DSQ is separate from local DSQ (Andrea Righi).
>
> Reported-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> Cc: Emil Tsalapatis <etsal@meta.com>
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  include/linux/sched/ext.h |  1 +
>  kernel/sched/ext.c        | 16 +++++++++++++---
>  kernel/sched/sched.h      |  1 +
>  3 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> index 60285c3d07cf..3d3216ff9188 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -57,6 +57,7 @@ enum scx_dsq_id_flags {
>         SCX_DSQ_INVALID         =3D SCX_DSQ_FLAG_BUILTIN | 0,
>         SCX_DSQ_GLOBAL          =3D SCX_DSQ_FLAG_BUILTIN | 1,
>         SCX_DSQ_LOCAL           =3D SCX_DSQ_FLAG_BUILTIN | 2,
> +       SCX_DSQ_BYPASS          =3D SCX_DSQ_FLAG_BUILTIN | 3,
>         SCX_DSQ_LOCAL_ON        =3D SCX_DSQ_FLAG_BUILTIN | SCX_DSQ_FLAG_L=
OCAL_ON,
>         SCX_DSQ_LOCAL_CPU_MASK  =3D 0xffffffffLLU,
>  };
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index b18864655d3a..4e128b139e7c 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1298,7 +1298,7 @@ static void do_enqueue_task(struct rq *rq, struct t=
ask_struct *p, u64 enq_flags,
>
>         if (scx_rq_bypassing(rq)) {
>                 __scx_add_event(sch, SCX_EV_BYPASS_DISPATCH, 1);

Nit: The bypass label has a single statement, and there is no fallthrough t=
o it.
Can we just add the logic here:

dsq =3D &task_rq(p)->scx.bypass_dsq;
goto enqueue;

and remove the new label?

> -               goto global;
> +               goto bypass;
>         }
>
>         if (p->scx.ddsp_dsq_id !=3D SCX_DSQ_INVALID)
> @@ -1356,6 +1356,9 @@ static void do_enqueue_task(struct rq *rq, struct t=
ask_struct *p, u64 enq_flags,
>  global:
>         dsq =3D find_global_dsq(sch, p);
>         goto enqueue;
> +bypass:
> +       dsq =3D &task_rq(p)->scx.bypass_dsq;

Nit: If we keep the bypass label, we can remove the goto since the
label is right below. Otherwise, we could remove it

> +       goto enqueue;
>
>  enqueue:
>         /*
> @@ -2154,8 +2157,14 @@ static int balance_one(struct rq *rq, struct task_=
struct *prev)
>         if (consume_global_dsq(sch, rq))
>                 goto has_tasks;
>
> -       if (unlikely(!SCX_HAS_OP(sch, dispatch)) ||
> -           scx_rq_bypassing(rq) || !scx_rq_online(rq))
> +       if (scx_rq_bypassing(rq)) {
> +               if (consume_dispatch_q(sch, rq, &rq->scx.bypass_dsq))
> +                       goto has_tasks;
> +               else
> +                       goto no_tasks;
> +       }
> +
> +       if (unlikely(!SCX_HAS_OP(sch, dispatch)) || !scx_rq_online(rq))
>                 goto no_tasks;
>
>         dspc->rq =3D rq;
> @@ -5367,6 +5376,7 @@ void __init init_sched_ext_class(void)
>                 int  n =3D cpu_to_node(cpu);
>
>                 init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL);
> +               init_dsq(&rq->scx.bypass_dsq, SCX_DSQ_BYPASS);
>                 INIT_LIST_HEAD(&rq->scx.runnable_list);
>                 INIT_LIST_HEAD(&rq->scx.ddsp_deferred_locals);
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 27aae2a298f8..5991133a4849 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -808,6 +808,7 @@ struct scx_rq {
>         struct balance_callback deferred_bal_cb;
>         struct irq_work         deferred_irq_work;
>         struct irq_work         kick_cpus_irq_work;
> +       struct scx_dispatch_q   bypass_dsq;
>  };
>  #endif /* CONFIG_SCHED_CLASS_EXT */
>
> --
> 2.51.2
>
>


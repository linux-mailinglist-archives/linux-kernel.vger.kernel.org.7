Return-Path: <linux-kernel+bounces-726187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA15B00929
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2CD95A33D7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8432EFDAA;
	Thu, 10 Jul 2025 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f46xC+zk"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF6A2727FD
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166100; cv=none; b=SKUVL8wtIUw8dZZvMRi679kXJzTGXrPpKN5UfJG7f2i1y6XXkqArOgpV+lhpW7xHBvVb7AbkrXYyQOZN1T0i0+goAdI6QB4zgYdqxDMP6AFFeu4EyF9hafs3Wbz/dkE9SM9SucFSLaHGfXKyXfdipOS/zwFCGSq0i8cdSno09wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166100; c=relaxed/simple;
	bh=Wh6+xbipHtUv5xJ5arUELHyT6W+rt+9X5nUdz6cniuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8txModcVrwqF2ASKWSQbwEMU2uyY8Pi9EjBhPvdUhvcUG2hRgnUtGwQ97qWP6tUc7eNCvb8JYWyaue01zxMvPaWd8nuKN1P0YCWPaEQsQ6XnEBJs8lUfX2bXfdVayS4rjtX4XWTcTsCXJp8qbtR9llm2D2X7MFP5fQzHgjUXVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f46xC+zk; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae0e0271d82so215649166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752166096; x=1752770896; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rj3RwN/1WJKw7qBk/ARs2t435NgKryvor9qjN025iMs=;
        b=f46xC+zk1Pj2xsrYgVIzeA2cX8BzD034UF3AC6XuU8pyjjFvBwTMP5QzDwRyvreop7
         /SepfSpWGNUMrnKYEiGJ9S795oWtsXKgkfIef9ScN/HsPtk50KeoJSJLocbDK5nEqNuu
         hHoQ/S7L5AMb/xCc2wwgeOo/rk7QGAmTM8A97Oq0sC9vLKtje6OfPqnTe5pHOjiMerEY
         nxywevwe+3Wy1smzRXdikJhez5f3Cz9+pGMT7CmJ4Vz8VkEnY7IgBNweZpTFqozmHlAp
         MqAD84OX5YiFC+4UcBvWxblY2NEFyamyjXzg9vLgh6EEbf3e+nptxZY9l+Pj5+Akfh6x
         +YSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752166096; x=1752770896;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rj3RwN/1WJKw7qBk/ARs2t435NgKryvor9qjN025iMs=;
        b=qn6JRpYSnuTzBmFbRGl22x4fKQsMR0YU0bQF+3K/VK9yOWoTtac1Oy5mg7A2WduIX+
         5Pg+cslQEnfcB6K0yejQ0PM/rH6wKTR1uNDp2yY2nMcVb2HIJv54rSJWBuIov06PtSl4
         4ejsYmaMue5PAHB/HEKknZHhs2z0zC7p5NOLYMd+UbTnPgKY0wakvGQQ2AgkVqu05xsj
         YIhVLUQ0ApeDyGTuJwDjPcRriz5goeS9fIGhuBaF3QOUtkjhJ8YmMoRoL2CX5A0Kvefo
         t1voZVFrSNnrxuOj466ROLhOgYOS4/RhCD1gG9eknP8QitsycNX3elEUsMGRpofWy3KE
         fuUA==
X-Forwarded-Encrypted: i=1; AJvYcCV434kQbcFfmqYlt4c77lyxm1Rtxb69PkMfShl9MV08eSJi5IBklCFsEZlnSZrgejjud90Bzf8ROSYdSqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIvytvWuH8NgjoxpN3uwGqOifaS61E+GfDhI7D3JdHbqrMCuS+
	9Tx3sCOyLchXJ+6/ASne/iI/wQJ7j4byNsdigY99OrPOQc9CYoUvp/qY03kw7fZkjnNBelQ1Hp2
	TmmiouQ/5qmvkI9GT0h8BKqwtblIedxMUka6KUbHqHQ==
X-Gm-Gg: ASbGncsq0vIo3XgGpuye9jdmBtPVaYdRbRvjGUYhIxtE5Zapr0x9/1pt3s4DBl8cM5P
	wHkcA50E1kBBRdSNhaZjlD8c+5QOFcojsvHyuaDgTFuMQH5ppizrjFQmuBRaiEbRdvECW6P+FKC
	gqCeZacb+izOLiA65lexCKk7RBzRXJcHbOQrDD/KcviuxqCGJsYSD+InLRZo7Tqxp4Z/1vTGuf
X-Google-Smtp-Source: AGHT+IGg8Bmy3qkYJO1x9ayjF+sKD4rIxrtJenWhv+TCKT/Jr8yb+vWIO7ZPBkyqnN5ll1ySEySP9fKtnAGpzllb+K4=
X-Received: by 2002:a17:907:9444:b0:ae0:da2d:1a53 with SMTP id
 a640c23a62f3a-ae6cf7716d8mr781541466b.42.1752166095907; Thu, 10 Jul 2025
 09:48:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702114924.091581796@infradead.org> <20250702121158.703344062@infradead.org>
In-Reply-To: <20250702121158.703344062@infradead.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 10 Jul 2025 18:48:04 +0200
X-Gm-Features: Ac12FXyYYfd8U-orNvzb_norEYQz6ux05uoOeqtkWfi7Bj62mxLZOUPxLJXAYRI
Message-ID: <CAKfTPtCQFCW++Rbhn=Oiq1_B7GdgfCM9BnGH+-BZ17FhXTHR9A@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] sched: Use lock guard in ttwu_runnable()
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	clm@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Jul 2025 at 14:12, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Reflow and get rid of 'ret' variable.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20250520101727.732703833@infradead.org

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>


> ---
>  kernel/sched/core.c  |   36 ++++++++++++++++--------------------
>  kernel/sched/sched.h |    5 +++++
>  2 files changed, 21 insertions(+), 20 deletions(-)
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3754,28 +3754,24 @@ ttwu_do_activate(struct rq *rq, struct t
>   */
>  static int ttwu_runnable(struct task_struct *p, int wake_flags)
>  {
> -       struct rq_flags rf;
> -       struct rq *rq;
> -       int ret = 0;
> +       CLASS(__task_rq_lock, guard)(p);
> +       struct rq *rq = guard.rq;
>
> -       rq = __task_rq_lock(p, &rf);
> -       if (task_on_rq_queued(p)) {
> -               update_rq_clock(rq);
> -               if (p->se.sched_delayed)
> -                       enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_DELAYED);
> -               if (!task_on_cpu(rq, p)) {
> -                       /*
> -                        * When on_rq && !on_cpu the task is preempted, see if
> -                        * it should preempt the task that is current now.
> -                        */
> -                       wakeup_preempt(rq, p, wake_flags);
> -               }
> -               ttwu_do_wakeup(p);
> -               ret = 1;
> -       }
> -       __task_rq_unlock(rq, &rf);
> +       if (!task_on_rq_queued(p))
> +               return 0;
>
> -       return ret;
> +       update_rq_clock(rq);
> +       if (p->se.sched_delayed)
> +               enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_DELAYED);
> +       if (!task_on_cpu(rq, p)) {
> +               /*
> +                * When on_rq && !on_cpu the task is preempted, see if
> +                * it should preempt the task that is current now.
> +                */
> +               wakeup_preempt(rq, p, wake_flags);
> +       }
> +       ttwu_do_wakeup(p);
> +       return 1;
>  }
>
>  void sched_ttwu_pending(void *arg)
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1806,6 +1806,11 @@ task_rq_unlock(struct rq *rq, struct tas
>         raw_spin_unlock_irqrestore(&p->pi_lock, rf->flags);
>  }
>
> +DEFINE_LOCK_GUARD_1(__task_rq_lock, struct task_struct,
> +                   _T->rq = __task_rq_lock(_T->lock, &_T->rf),
> +                   __task_rq_unlock(_T->rq, &_T->rf),
> +                   struct rq *rq; struct rq_flags rf)
> +
>  DEFINE_LOCK_GUARD_1(task_rq_lock, struct task_struct,
>                     _T->rq = task_rq_lock(_T->lock, &_T->rf),
>                     task_rq_unlock(_T->rq, _T->lock, &_T->rf),
>
>


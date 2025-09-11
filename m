Return-Path: <linux-kernel+bounces-811659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FF9B52C32
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C183C7AF214
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD0C2E54A7;
	Thu, 11 Sep 2025 08:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JTaHCvM2"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2811A275
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757580643; cv=none; b=ZNAxqgOdcrSrKf3k8wp07hQnSxvJCr3isGeBATBj6MWgvaab52Z3muCJsJeS41vJv1ESUm1Kwsyo6SVq8CMSFqlLisLcyM5bKG62eTig7Z3e6wnUitKcinkdqO5Yfcl2D29OSX45gNzOwP1UoZRkeSMlC2FjD5zZN1QJ+TU+Y9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757580643; c=relaxed/simple;
	bh=B4BFaEw0Ji83jiGAcJeizX9fxb4Q0H98Gqxjxm7nsb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WY0rh/NJoRsMxbWZIZ3wXDcrRb3v41PbucrEXyduhRyVQSR5EDKdQ1wffwCILLgX8b6e/mxS1IdaKTNyGr4W7bDLxVl+b/aLdtkKh5+LrTp6eqMFqI1kDhdrP+uspabaxzjQNdN3tE3/FQYR+4bewA+OIQ+oTcFzW2z3lPH4dNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JTaHCvM2; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-623720201fdso935711a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 01:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757580640; x=1758185440; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h/0SiCS810MWmGjIJxRGJCi2HtkXECp9NXxbtge8H0o=;
        b=JTaHCvM2rNp+cbYWTqMdEkFcZxo9KheIlIXv/sA8wg6VvtBNUT8ORoGBFPrTe25/5f
         7U5u9jMI4GonFOe7x+J1O1l6JssREziihvhCVz81GtLaM1NqBZzY9R58jIkURazpx3iQ
         VxEKDCFevtzYwL9f3db5wk+yLo5+yOZBzuBIYt4nxdRLzW26Bw9jb+UgHQF1LXAgN8mI
         Eo8hLbn++UxxbQfZBQ6+yRpRZRnIyqcfPG5NC8K7lF5axdcp3EQGdqKRmLDUwnt0l+UJ
         /+ncjsA4Ks82IFjYtw2fTaK5kd+b+EvqTA/m/XOZXgk9uAfu6gpBPLHwRV+hEV2jZwwA
         +HUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757580640; x=1758185440;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/0SiCS810MWmGjIJxRGJCi2HtkXECp9NXxbtge8H0o=;
        b=ZU0IxoxflMG7hh34V3HGnianZF96lSypuVL/Sb8YCQeRcDhXFZNhIuNvEGAdO8p56J
         TLWaWyYmCNlm9l7mlubfeyqVx6/HYlviVWw77ovoTJqLqd8F6/45IK5hVDDKhM23PVS0
         VYoHnEjQo+4IWEMvtdLFXoA9Tw3Amp9agmwRXwZ0uAqPYr+MWt5FQKnYTATropvehwuI
         nt7MIMQxxWrWAnPar1lhcZQJxUjoG7gb4RrSvVUw+QzQEa6M/mIj1Ex8/tYhCkLWX9MN
         5boyCefBfMFAJBLYSFtIwa0WXve+/ctJSWOvl3jPGIthq39kC1flIWJYwhY0ag+moRjD
         ippQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9dZtBvtETLFuU1ZAId5+2lt6vHWey0yTd30TKNFEEE0Rj62EYRbxeAzqsfEAiB4bj86QbWKg7bzvfaWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhhger/I/3ZMFR3/PD83kXdzYvH8CoxmTl3rqozLclZd9uvFTO
	yyvVqtDwIrCoQBPcY7OHSOzg0CmNkXswzS47UFbfG92DdwFr+wfw24qIamKe6ZfZkyF9s6+aKmY
	ebAeONmgfkUSovuh3o9AhpZGJEkHHjjCX3z4IMZ88nQ==
X-Gm-Gg: ASbGncsbWRg1LPZUzk3ed+lGrF3mHvSnKqYmg6xAs01z6/6SDvt0b1qiCMyFXsFGGtx
	xmYPyMpPhboL/lTK/e5sxexxx9mnm2VH4IPasMxQFLd5Ujt2w6O0iRP/a2kLoofzd5B2w9HZTEM
	WDyF0WRCATnMrYL/2yM36y7eKm42dIaxHuERjnS81ryeRJNXm0SToZ0iMPR6MW9AyQ+a/N5vNpM
	2RqZNezXERSqckhtVLb9q2VpRv37BQeETtZwnxxtec71TshICO2azh6Iw==
X-Google-Smtp-Source: AGHT+IFe1hf0rduKugNkN67Z0RrKV5q1qOs+LZnehMx6pnwS3d7EaUV8836Na9SIYPHtPK26Gu9nMlVC6b2pLGVxgvs=
X-Received: by 2002:a05:6402:42cb:b0:628:eb99:982c with SMTP id
 4fb4d7f45d1cf-628eb9999d6mr13442363a12.28.1757580640365; Thu, 11 Sep 2025
 01:50:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911034454.494852-1-yury.norov@gmail.com>
In-Reply-To: <20250911034454.494852-1-yury.norov@gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 11 Sep 2025 10:50:28 +0200
X-Gm-Features: Ac12FXyimcbfyl94hkzh5EL7ZnLYXD_tTc8diOQ7-_H2yV5LTbcNQNixho3Phx4
Message-ID: <CAKfTPtCHhWGfR7ew0vf=3c2euWaHjTMZpAmwiYcq5eMEmauKAg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: use cpumask_weight_and() in sched_balance_find_dst_group()
To: Yury Norov <yury.norov@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Sept 2025 at 05:44, Yury Norov <yury.norov@gmail.com> wrote:
>
> From: Yury Norov (NVIDIA) <yury.norov@gmail.com>
>
> In the group_has_spare case, the function creates a temporary cpumask
> to just calculate weight of (p->cpus_ptr & sched_group_span(local)).
>
> We've got a dedicated helper for it.
>
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7229339cbb1b..4ec012912cd1 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10821,10 +10821,9 @@ sched_balance_find_dst_group(struct sched_domain *sd, struct task_struct *p, int
>                          * take care of it.
>                          */
>                         if (p->nr_cpus_allowed != NR_CPUS) {
> -                               struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
> -
> -                               cpumask_and(cpus, sched_group_span(local), p->cpus_ptr);
> -                               imb_numa_nr = min(cpumask_weight(cpus), sd->imb_numa_nr);
> +                               unsigned w = cpumask_weight_and(p->cpus_ptr,
> +                                                               sched_group_span(local));
> +                               imb_numa_nr = min(w, sd->imb_numa_nr);
>                         }
>
>                         imbalance = abs(local_sgs.idle_cpus - idlest_sgs.idle_cpus);
> --
> 2.43.0
>


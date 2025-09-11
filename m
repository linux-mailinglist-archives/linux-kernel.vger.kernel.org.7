Return-Path: <linux-kernel+bounces-811576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00943B52B13
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79EC75856B1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02862BEC55;
	Thu, 11 Sep 2025 08:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mw/sdP1I"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF738228C9D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757577719; cv=none; b=mWV06+6hocCn13bADas0aZuIM29GTTC2h3v/NLFrnpoOA5P2sIFg+OntQ77UBkPnYSrE69jCg83Od9MnVhCjGWK3Ink5rvtQN4NMwQ2Fdr/ha6qeKr5YOhxyH3V+becKjCxoyjGzXkyjTWWnSGPwIbXL4YzTjboZQD2avMf7Gc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757577719; c=relaxed/simple;
	bh=r3nlowwjMaQ/DTsh1EREqs/rZLGp/Bbjxj968KhOW0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tGQKy0+MYo0E+TCIKNXK7b2Fwxv6D3omtrbUUROhHDV6NfgBofziYZ2oJkQI7z7DwISzwRJAUcR7yX6WbREregmqoERgBgocQ+Tys8PQ4OgOulaoqjzvzD3D4U+j2tmovu0N5Z/KrNUaSOX/UXB5K2S5nUXKRIlXb5JDiu69ig0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mw/sdP1I; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-622b4b14a75so798914a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 01:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757577716; x=1758182516; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nbq7CnHUsLvzkU9CVJEXqvGteh0jaX1oE3HpDJf7OoQ=;
        b=mw/sdP1IfpcVWfEhxI3/IOa3klXWuPkGIdAnAd0+obyAAPjPwvM0rSBRdlW9fQC/rJ
         y6nzrwBNqoP1JmzaO5pOmDb9tqa239IBa9eXBYdbApXljVEhTrmEKzmmXgUVTauE5AJ3
         U34bXCalZZwNl4m6h47DhqWAp2CcX6w4PwwCKDpaDcXRB1t6kI0wa8F0dFM900jZ75tE
         8rx6va3yAviZOoMeCRc7hUY2JjsGeOU+Qom4iHsA+MY815eSw/J9190I981GaTF4rEpE
         piZgN23Q26DszJqOEq2y+PCtWpwSVgdRilhPFq8QHnw2IG2GssrO2KRPdkWCmMwFzft5
         /Lrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757577716; x=1758182516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nbq7CnHUsLvzkU9CVJEXqvGteh0jaX1oE3HpDJf7OoQ=;
        b=AzdRpukUjgm4aMsYCaCIQddqE2dqS3QJfQiTZnh9o4sqioK492foiqstuZYSOhmTiO
         /mFyKFOSm2wmj2IWzwFgvBy3ESOFhxDR82iHgu6sWyyvurnI/kfRWKLGJ3O2ewrtZMxp
         P/BGnx5mJCGagMy0AvH7PKN1vodjoe/kqFgbFmVXevwBMoL37eDUaKiCSxUxEgwqm78w
         uDrqLP8cqE4m6lCyAMLM5oTO02mIFwZFtz/p6Wa1jEurPVsj9yUpZc4jg/5e5oswlTsJ
         bZgtjHw/CD/9Ton80mC7CC4BgYd5e2GQrRbjtVduSOK4b3Vywd4fdNXETw078PDvpHHv
         zWAg==
X-Forwarded-Encrypted: i=1; AJvYcCX/Z5MIVvCGWJYUMVIe1ipaiVbnzb7fJHBF4uTcem5LWEmwuud+5FcxItANQHLw3Ury9Prw0dtGzsZ7aOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyADbhU4Ts/DDHBpQQ3z1NtC6KkRgCDRYo+KnNo3PRPOMkLPZ84
	25119xjWZxAceKyzVjn8iCv26I4V5XTnZkoW8oJHOR/lB5ScQUNj8kVD5vr3ASRceVwdaNdz0lL
	HJt8zbDSrLPLjVcyMQPudp1XHFgjFoqY9Na+u2DEgYw==
X-Gm-Gg: ASbGnctIwIDRDgFVMnjvZbWvkGj/t+dspoERla8jQoA82VfixK+AV9u2qebr7EmtdIh
	P5oQ1Rxj4XiVAiCM3X844pdWQAw0fNMI6nj3GyO9uCozf4nst9kNyXa50UyBwAhchHMTkhHuxHH
	HtOLNLmbs85XxMIkKKO3gGX1wGVbsfxwR3gUsgA06Bh+UEA97766UBtogrG5KLYag+J2Zpi60hG
	BwEnFHU1Q1P/7zfsX2rzxvtddqSyOX0kicCdSBYv+RU3RU=
X-Google-Smtp-Source: AGHT+IG6zpt4N2ZLviN0xhWnmdqEQNtahumwSKyotYHAFlM4fGkZBmGF2YsB5/O6QD1jrpKptqRXXFl9OuxHXljCReE=
X-Received: by 2002:a05:6402:24cd:b0:61c:9852:bbb0 with SMTP id
 4fb4d7f45d1cf-6237ebc6f49mr15900698a12.19.1757577716167; Thu, 11 Sep 2025
 01:01:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910084316.356169-1-hupu.gm@gmail.com>
In-Reply-To: <20250910084316.356169-1-hupu.gm@gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 11 Sep 2025 10:01:44 +0200
X-Gm-Features: Ac12FXwgSPXMa-9RpAyKZYVfc4fDEfTkurE60V5IY_jArDjaBcp7KI0zMxkxXnw
Message-ID: <CAKfTPtCyL=ofg4yLtfG7zsoBMDnP48KCeUELT_Hddd3gnWeYEw@mail.gmail.com>
Subject: Re: [RESEND][RFC] sched: Introduce removed.load_sum for precise load propagation
To: hupu <hupu.gm@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Sept 2025 at 10:43, hupu <hupu.gm@gmail.com> wrote:
>
> Currently, load_sum to be propagated is estimated from
> (removed_runnable * divider) >> SCHED_CAPACITY_SHIFT, which relies on
> runnable_avg as an approximation. This approach can introduce precision
> loss due to the shift operation, and the error may become more visible
> when small tasks frequently enter and leave the queue.

Do you have a level of error ? Do you have a typical use case ?

>
> This patch introduces removed.load_sum to directly accumulate
> se->avg.load_sum when tasks dequeue, and uses it during load
> propagation. By doing so:
>
>   a) Avoid relying on runnable_avg-based approximation and obtain
>      higher precision in load_sum propagation;
>   b) Eliminate precision loss from the shift operation, especially
>      with frequent short-lived tasks;
>   c) Reduce one multiplication and shift in the hotpath, which
>      theoretically lowers overhead (though the impact is minor).

This doesn't work because rq's load_sum tracks current weight whereas
se's load_sum doesn't include the weight which is only applied on se's
load_avg. So you can't directly add/sub se's load_sum and rq's
load_sum. Only load_avg of both se and rq use the same unit.

Also we don't want to track both load_sum and load_avg, only one is
enough and by the above it is load_avg

Then, why is it a problem only for load and not util or runnable ?

>
> Signed-off-by: hupu <hupu.gm@gmail.com>
> ---
>  kernel/sched/fair.c  | 8 +++++---
>  kernel/sched/sched.h | 1 +
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b173a059315c..b8cf3687804b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4561,7 +4561,8 @@ static void migrate_se_pelt_lag(struct sched_entity *se) {}
>  static inline int
>  update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>  {
> -       unsigned long removed_load = 0, removed_util = 0, removed_runnable = 0;
> +       unsigned long removed_load_sum = 0, removed_load = 0;
> +       unsigned long removed_util = 0, removed_runnable = 0;
>         struct sched_avg *sa = &cfs_rq->avg;
>         int decayed = 0;
>
> @@ -4572,6 +4573,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>                 raw_spin_lock(&cfs_rq->removed.lock);
>                 swap(cfs_rq->removed.util_avg, removed_util);
>                 swap(cfs_rq->removed.load_avg, removed_load);
> +               swap(cfs_rq->removed.load_sum, removed_load_sum);
>                 swap(cfs_rq->removed.runnable_avg, removed_runnable);
>                 cfs_rq->removed.nr = 0;
>                 raw_spin_unlock(&cfs_rq->removed.lock);
> @@ -4609,8 +4611,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>                  * removed_runnable is the unweighted version of removed_load so we
>                  * can use it to estimate removed_load_sum.
>                  */
> -               add_tg_cfs_propagate(cfs_rq,
> -                       -(long)(removed_runnable * divider) >> SCHED_CAPACITY_SHIFT);
> +               add_tg_cfs_propagate(cfs_rq, -(long)removed_load_sum);
>
>                 decayed = 1;
>         }
> @@ -4792,6 +4793,7 @@ static void remove_entity_load_avg(struct sched_entity *se)
>         ++cfs_rq->removed.nr;
>         cfs_rq->removed.util_avg        += se->avg.util_avg;
>         cfs_rq->removed.load_avg        += se->avg.load_avg;
> +       cfs_rq->removed.load_sum        += se->avg.load_sum;
>         cfs_rq->removed.runnable_avg    += se->avg.runnable_avg;
>         raw_spin_unlock_irqrestore(&cfs_rq->removed.lock, flags);
>  }
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index be9745d104f7..659935a5c694 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -682,6 +682,7 @@ struct cfs_rq {
>         struct {
>                 raw_spinlock_t  lock ____cacheline_aligned;
>                 int             nr;
> +               unsigned long   load_sum;
>                 unsigned long   load_avg;
>                 unsigned long   util_avg;
>                 unsigned long   runnable_avg;
> --
> 2.43.0
>


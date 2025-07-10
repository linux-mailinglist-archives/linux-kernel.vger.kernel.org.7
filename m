Return-Path: <linux-kernel+bounces-726195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC5AB0093D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E37C4E6C92
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEA72F0C60;
	Thu, 10 Jul 2025 16:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uRczlfol"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD0C2F0C48
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166319; cv=none; b=URhA8zQ/UNwAVjTq/deNrFYXk9nnAsK4h0vopTPyNGY1C+q9/7z2figMqH+U69wH18ZEH8U/36u8BUptHQx/gR5pb1L57TH6MUEPUhOeQHUh9kkZ6wc1D11Z+/OLrOXZLrPKlKrv3tKIs4cZ8G+YoyBQ43LO1Q04aGDsWN18wS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166319; c=relaxed/simple;
	bh=DsQ+jstixBFAuQaz054VcKZdaBP0fDVkYL84D0KF5X8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2jFtpkou3WqE4ju4zfjWJnQ96EHRWx248snnmV64UIuYbRaJx5puKICT37ni7MIav8TyXHH2OR3r2zPRyP/GQtbnqErBRFLFnAwKFeYr0s5NOIg1UYxMneH/L4WmgXWGCoWXCl4pFWhkn2YgnGhYppv/xwPMIALxaHKog8o1OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uRczlfol; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae6f8d3bcd4so37668566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752166316; x=1752771116; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mouzB1wCH7DM1yDvT3RlcGONddhN7EoRR+9ZTjW/haE=;
        b=uRczlfolOeRgv5jRErV6RhbGoDdoRYWJegjgbftQdfITRMe6ECuBCFf8Y3L2JACClw
         aMqUNC7FCRsLRGvqWt3vbWTFvBOMpGMwu0AxuVYpufAIAUV3KJyFR71NzRbdaoVkH4tF
         jSMW90xfr4sq1ofDW2k7ZwVLP5nL5MzkGDOQIcnNVWHjEhTWzFIMRGjie0Ld/mJzQB9A
         wEjUqnROZoe1VG3UOEcGYebaPBTv+4wDnen2Z8XEke1qutccK1n0li/BYkE2T3gOKLpn
         teBQ5gnYZXQqYe812ZDyIkFfoafm9FEKHVtlIChm/QLkANggtdd7I3LYhbKk2pJ5JD4I
         dVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752166316; x=1752771116;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mouzB1wCH7DM1yDvT3RlcGONddhN7EoRR+9ZTjW/haE=;
        b=XWgX1PzMkWnUowOmv1Ps2Y76zWkcr4fPWXseaTu0atZVLb2f2yh9T7L78mgAB2Fhwd
         BoXakp7y/jyaGdwkqHbDfHbdDCvL0udYjgSEGoxGsInfq74hDXluvrjqoJ6DvNpPM1Nj
         EpW05KmA4YYAxfM6KXC/h0zTueCBd38RfaJfHuiANCEhi5nS7y/38KaAv5iq8s18P73U
         I8oV06CfDMT02/xDNuVyrXj6KJoLoqhURC21gckF+GRTA6VRUcyCdm4fuIxFztp7j1Cp
         X8Dj3Wg7iyVe22PtHTpC/v9St483duJFaFIDXoJg/2daFsB077eEh/eAENhKuc3RGMjR
         eegg==
X-Forwarded-Encrypted: i=1; AJvYcCW5iMKydjtsyB8/KSCxO7Ss6qKKkJlA8SDESwZYrzyBHNIbEYY+KC/btWujynybEACiC4kjVThIdW5qJhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTuQ8SgbhNUpJaWzZPWcvCoxlgQuO3aALJWpWJhQGDsZhqMkmD
	wbV+8GS4487a8QfQrsUQ7wASD+CaHQUbT6C4Mug1IyUYacfrsH3KVrMvgNCiqF+njVlzWOhAb7U
	i1PpKATsJIcS+VCsSowk+3arPfwVYe4riz51Y65zy0w==
X-Gm-Gg: ASbGncu6dQpDtdJXlqy5OKXhXW/FRzm7OXjeon3moieqbd6L5gxc4ufc2HdpTTPFQng
	Oa9b+I4vT4bY1cBquKSoGFjHeO9KcnjU5xC2yUaUR7wfl5O6wlidOA+sR32BcQAvEKCLM+OJmdm
	MT3vgB0RQdeJ5bT8XVfOX+rUFuZ+T053XYPb4eVQUszOvkPEM2gcNUvzEQNjMh+qVjb+B+bizs
X-Google-Smtp-Source: AGHT+IG6w9gpNb7HU42CGtW+BjgUxQKdeemDnKwk6tAsrfncWys/ap9QfMo+y4MahYys+c+7GcqGnN12hEapiDjYwek=
X-Received: by 2002:a17:907:971c:b0:ae0:ad5c:4185 with SMTP id
 a640c23a62f3a-ae6cfbc6e4fmr769026266b.57.1752166314958; Thu, 10 Jul 2025
 09:51:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702114924.091581796@infradead.org> <20250702121158.932926181@infradead.org>
In-Reply-To: <20250702121158.932926181@infradead.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 10 Jul 2025 18:51:42 +0200
X-Gm-Features: Ac12FXwcGGlcW8-iy1t2eqFys-uUv3VzKKimNBvU65BXCdLZHC33RI-eEcJmUfk
Message-ID: <CAKfTPtDtjovwscum-DRD9OJbS1mo-NAmfe7h6iU3cTNJi=fQrw@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] sched: Introduce ttwu_do_migrate()
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	clm@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Jul 2025 at 14:12, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Split out the migration related bits into their own function for later
> re-use.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>


> ---
>  kernel/sched/core.c |   26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3774,6 +3774,21 @@ static int ttwu_runnable(struct task_str
>         return 1;
>  }
>
> +static inline bool ttwu_do_migrate(struct task_struct *p, int cpu)
> +{
> +       if (task_cpu(p) == cpu)
> +               return false;
> +
> +       if (p->in_iowait) {
> +               delayacct_blkio_end(p);
> +               atomic_dec(&task_rq(p)->nr_iowait);
> +       }
> +
> +       psi_ttwu_dequeue(p);
> +       set_task_cpu(p, cpu);
> +       return true;
> +}
> +
>  void sched_ttwu_pending(void *arg)
>  {
>         struct llist_node *llist = arg;
> @@ -4268,17 +4283,8 @@ int try_to_wake_up(struct task_struct *p
>                  * their previous state and preserve Program Order.
>                  */
>                 smp_cond_load_acquire(&p->on_cpu, !VAL);
> -
> -               if (task_cpu(p) != cpu) {
> -                       if (p->in_iowait) {
> -                               delayacct_blkio_end(p);
> -                               atomic_dec(&task_rq(p)->nr_iowait);
> -                       }
> -
> +               if (ttwu_do_migrate(p, cpu))
>                         wake_flags |= WF_MIGRATED;
> -                       psi_ttwu_dequeue(p);
> -                       set_task_cpu(p, cpu);
> -               }
>
>                 ttwu_queue(p, cpu, wake_flags);
>         }
>
>


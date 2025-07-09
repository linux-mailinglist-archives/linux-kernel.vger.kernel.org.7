Return-Path: <linux-kernel+bounces-723510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1128AFE7CB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B8C3B13E7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED7C253340;
	Wed,  9 Jul 2025 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MrPQv+8N"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107A72D5C89
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752060680; cv=none; b=b556I2q1HUE8JS5MbCqiAIryapCkjD2W6a4zBmObYBwHKQyoauc+AishKETHOjqvllAbSZaAWDBU74zMlPd5Yzz9J9DWTN0u7oiX0gQS79gQLdoH+/iRav02yNAlY41K8abHFYtq/QlC/3iGJeYzInhkDie3NhLVTDJ2IeGsVlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752060680; c=relaxed/simple;
	bh=4Hkk5OuwSgpa8ZVz2A9112tSYqvhkuQtD4oQV2IJQgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4jDZwyPkC/X6lrFlSAPJ50IFKS8UseTVtURTYT/97Pb+5KGX12H9NDoyg/xpW1ENE315Eh0ClsW2VKLXR6up9Jc5k2WgMcio5kvjvejLJXKcHzW51PuKV0aLwNYKpXHlTT3L5TufpVNMIUFz6jLrNTuEmkWWxhW/EY8oiYO+FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MrPQv+8N; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7170344c100so35018907b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 04:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752060678; x=1752665478; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vhinRnC2KgbrCAQjb5GrNdfbvaAbJYEqjJK/1IzV5G8=;
        b=MrPQv+8NX70FYkTMV4RTftqbDYYQklA2tp0odqaQtpTNjPt+3tMwzgpqUS1gwxEChA
         B7btfrilPobCCIcEvY4ha4QHRvSnHhIfIF1yjeSI9XdvPdTJP1L4kdooVJGAFD2bFFHT
         aKH1LIU1iJquesfGs15pezsI+wf/NHBP4zwHKKUbymBc9hzcooJJF5GltWCwzjJqNKqF
         qMbE+dlxTbJ2WjYkBWVgG3f/OX8l0wH5A4aYlDG0I0/l0uRp9woh04GXopJwtO1Fu1l+
         ZjeF5ftkFT4iLiQbfoqESHfgikdEMyMRZUBVJnHU4TK/mXj8xt34JQ3LgX10zG0fOz9e
         OPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752060678; x=1752665478;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vhinRnC2KgbrCAQjb5GrNdfbvaAbJYEqjJK/1IzV5G8=;
        b=uWpz6Tauu0dAiJWuJWgK3lw/1Shnjf65e9Nu7yeSkcNXD7NPgpWHiFL7ZndrZUV3NS
         Z6A11ZtsHYoOJuxD5Mhtmal27uuTvvrF/ajwnKtZdOO9JTxilXImvGZLllZIZegkDAXU
         JjJxwUKehDbsITttVUZ9YGG0W+GmfTh6MVW2D3BZ3AQTs06W8M4zI3i65vOqBaopacyw
         5FtD7LY87DKfDCiueILsCx/8tgD+aYb+ocRmnOsJIJD1lyH0Ne1DC9tS3q3y/wwrvzda
         SSaXbjdVNJ+WAxYQmNoTgRhQ8G6QNj8xRq6UlaUbXNsSS3W2l3/60xFtVWiL5QE4l6lH
         QvPg==
X-Forwarded-Encrypted: i=1; AJvYcCWDW7vSLHH9QMSdRh/GI0sNyC0WN5qwwv/rr3swzFYArzWhax/87CMiX5+9XMyoS1okr3PSsWd/ZD+hJUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMwES0ZpKPAlo3pGfUyho9LbwdQNwNT6DVrxoi3IohXAwTZLkC
	045uux8ZDRgnk3VjXBxcz/pONV7nx5YPe8JXz5R6eHAFY/KqFfp3qMmGItSxpIzUvZJx/RAAOMf
	j4FXJZbFs+DWXAOzg3n1U4z0QkIQo2+/Y1qYmqf0Y5cG9eIxDNK34
X-Gm-Gg: ASbGncuQhQFOI7fNdGAEPYpHYTdvxK+jL8sjwwYVSlrLcMe1YQXebsFMSyZ6jpVQdkk
	t9w8CK4WeABIfUIKofPzYcgJD56JU1gXyrcY9wdTORi+RnQeluOf4LRgoDV4T0PWK8e2bYixLr6
	26pO1rklcuhkZxVlpmLqUwK0E9Zqj1Bg3ABi+gaCa3jxYu
X-Google-Smtp-Source: AGHT+IGH/F6xYLHPIoC6QZpCT/W5DUlQY8P9zi7qkAmnI0IUChUcZNLBvcHsqWHGEgSnYu/SEZC21ND0ucUUVBJryNo=
X-Received: by 2002:a05:690c:311:b0:70e:2ced:6f5f with SMTP id
 00721157ae682-717b1a0cdb7mr31460677b3.37.1752060677687; Wed, 09 Jul 2025
 04:31:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-pmdomain_qos-v2-1-976b12257899@oss.qualcomm.com>
In-Reply-To: <20250709-pmdomain_qos-v2-1-976b12257899@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Jul 2025 13:30:40 +0200
X-Gm-Features: Ac12FXwikg22mOAGpboGSZcxhcTM_ZXNIAi7032DsK4OuPilgCtD8TpPeVBGJ18
Message-ID: <CAPDyKFpjPLrM04uoWAT1m6WCt7WKh-e6gycNbjo4wjQQyv=96A@mail.gmail.com>
Subject: Re: [PATCH v2] pmdomain: governor: Consider CPU latency tolerance
 from pm_domain_cpu_gov
To: Maulik Shah <maulik.shah@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Jul 2025 at 10:30, Maulik Shah <maulik.shah@oss.qualcomm.com> wrote:
>
> pm_domain_cpu_gov is selecting a cluster idle state but does not consider
> latency tolerance of child CPUs. This results in deeper cluster idle state
> whose latency does not meet latency tolerance requirement.
>
> Select deeper idle state only if global and device latency tolerance of all
> child CPUs meet.
>
> Test results on SM8750 with 300 usec PM-QoS on CPU0 which is less than
> domain idle state entry (2150) + exit (1983) usec latency mentioned in
> devicetree, demonstrate the issue.
>
>         # echo 300 > /sys/devices/system/cpu/cpu0/power/pm_qos_resume_latency_us
>
> Before: (Usage is incrementing)
> ======
>         # cat /sys/kernel/debug/pm_genpd/power-domain-cluster0/idle_states
>         State          Time Spent(ms) Usage      Rejected   Above      Below
>         S0             29817          537        8          270        0
>
>         # cat /sys/kernel/debug/pm_genpd/power-domain-cluster0/idle_states
>         State          Time Spent(ms) Usage      Rejected   Above      Below
>         S0             30348          542        8          271        0
>
> After: (Usage is not incrementing due to latency tolerance)
> ======
>         # cat /sys/kernel/debug/pm_genpd/power-domain-cluster0/idle_states
>         State          Time Spent(ms) Usage      Rejected   Above      Below
>         S0             39319          626        14         307        0
>
>         # cat /sys/kernel/debug/pm_genpd/power-domain-cluster0/idle_states
>         State          Time Spent(ms) Usage      Rejected   Above      Below
>         S0             39319          626        14         307        0
>
> Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>

Applied for fixes and by adding fixes/table-tags, thanks!

Kind regards
Uffe



> ---
> Changes in v2:
> - Rename device pointer to cpu_dev
> - Replace dev_pm_qos_read_value() with dev_pm_qos_raw_resume_latency()
> - Link to v1: https://lore.kernel.org/all/20250708-pmdomain_qos-v1-1-7c502f4c901a@oss.qualcomm.com
> ---
>  drivers/pmdomain/governor.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
> index c1e148657c873a6b5b4d9c0f058d54cb020c56e2..39359811a93047b36443a1b9583962726f24b88b 100644
> --- a/drivers/pmdomain/governor.c
> +++ b/drivers/pmdomain/governor.c
> @@ -8,6 +8,7 @@
>  #include <linux/pm_domain.h>
>  #include <linux/pm_qos.h>
>  #include <linux/hrtimer.h>
> +#include <linux/cpu.h>
>  #include <linux/cpuidle.h>
>  #include <linux/cpumask.h>
>  #include <linux/ktime.h>
> @@ -349,6 +350,8 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
>         struct cpuidle_device *dev;
>         ktime_t domain_wakeup, next_hrtimer;
>         ktime_t now = ktime_get();
> +       struct device *cpu_dev;
> +       s64 cpu_constraint, global_constraint;
>         s64 idle_duration_ns;
>         int cpu, i;
>
> @@ -359,6 +362,7 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
>         if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN))
>                 return true;
>
> +       global_constraint = cpu_latency_qos_limit();
>         /*
>          * Find the next wakeup for any of the online CPUs within the PM domain
>          * and its subdomains. Note, we only need the genpd->cpus, as it already
> @@ -372,8 +376,16 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
>                         if (ktime_before(next_hrtimer, domain_wakeup))
>                                 domain_wakeup = next_hrtimer;
>                 }
> +
> +               cpu_dev = get_cpu_device(cpu);
> +               if (cpu_dev) {
> +                       cpu_constraint = dev_pm_qos_raw_resume_latency(cpu_dev);
> +                       if (cpu_constraint < global_constraint)
> +                               global_constraint = cpu_constraint;
> +               }
>         }
>
> +       global_constraint *= NSEC_PER_USEC;
>         /* The minimum idle duration is from now - until the next wakeup. */
>         idle_duration_ns = ktime_to_ns(ktime_sub(domain_wakeup, now));
>         if (idle_duration_ns <= 0)
> @@ -389,8 +401,10 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
>          */
>         i = genpd->state_idx;
>         do {
> -               if (idle_duration_ns >= (genpd->states[i].residency_ns +
> -                   genpd->states[i].power_off_latency_ns)) {
> +               if ((idle_duration_ns >= (genpd->states[i].residency_ns +
> +                   genpd->states[i].power_off_latency_ns)) &&
> +                   (global_constraint >= (genpd->states[i].power_on_latency_ns +
> +                   genpd->states[i].power_off_latency_ns))) {
>                         genpd->state_idx = i;
>                         genpd->gd->last_enter = now;
>                         genpd->gd->reflect_residency = true;
>
> ---
> base-commit: 26ffb3d6f02cd0935fb9fa3db897767beee1cb2a
> change-id: 20250708-pmdomain_qos-29077f8b622e
>
> Best regards,
> --
> Maulik Shah <maulik.shah@oss.qualcomm.com>
>


Return-Path: <linux-kernel+bounces-729892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3057B03D0F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E06217EBBA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE31246774;
	Mon, 14 Jul 2025 11:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d9+90KlZ"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0CF23A6
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752491608; cv=none; b=PrZgrDoi45QsADmr8CPDQmoJulJ0T4LU6SnSddJEsJyGsuEOM2al0Gzy1aU8J5/XgJAzsTpcAOPNSW0gJ7rON3cKhVXaubMl0ujUivghe5lbflLUwg1RFKAzK2bhL8TZCNcFqUOjmHc3yZNMIu/P+Ju3LdzSVttBjHGeZAiHIyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752491608; c=relaxed/simple;
	bh=ZA5jvG8pGJZD7/FvjspI+R76IwjgXaVGgj+MLHimBqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iHjKFAmuuG+s99SZ2FWs8zdFZEciTT+dqadfHKZhIJZ7X4QURTW49HGCgdCqfJE9kcoAYsZJBnKN/Ihsu0mJp8oE2cU0xEjhVEyjJ1r6P/PwJ9hftJbleeHkEID8H2dJAwbYvLHPA1x4q1vNS6f5VynGb7DH+Vgo0wWUgOQNl/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d9+90KlZ; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e7d9d480e6cso3214118276.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 04:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752491604; x=1753096404; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iYsZgpGyc92tylgoOl1ueE7I+vTEL4X4JFlPanY31ls=;
        b=d9+90KlZTNhEkbRePV8b79DVkIpZB1prC6b7Q6d6bJLi6v2PTmfpw/r58fWKWJqpo1
         q3V63iRbDQDjJd7LU7ZmDYqZKzGsWjPmE9cZnkyNoB1MQpnbtdseWlSvZlNCrGvwEIz5
         xwfJ4rXEZtR03/Gg6HDUr3IW0ereXNCnrn5FnocHQ/TZ9ZaHvXRAURfnngGvpUVU0Y/I
         1IHSp8dxnaTjHAN7Q2wMFzv5mlo0T+8yzbGuYH8aTJxCTsv8yEf1El/QDLoOBJ2kL8oS
         8i3d1Qw5328OahATc8Z9uOt6a+Ktr3XLJELVAx0jkHRenMSahIUOHg9CKe9EO4sk0Dsy
         ouSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752491604; x=1753096404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYsZgpGyc92tylgoOl1ueE7I+vTEL4X4JFlPanY31ls=;
        b=XsSpiqxkcm48JYwvX14f/EcyhDHtG47uuW0IuV14UnYj5hiMCdRdmfQg2qZwLZ6sS0
         bYqKSasBl7kFezmtLhjP9XSTK4OlTt0ol8RuTKmX6p0dOdUn9HWWPlqDiNJZ9B005dqj
         +Hidia4UCPuMEhGS8sE4Wj0DHnd9Z5dXE0/Cu9TVP7bs7oqX34g6zL9s64mEwjBIKZ5P
         oY6ja0RZg8pT8Nrs/UGuVZrm/bnSyZpYxs4A53RwDyXmpqThGpwi3aUru1CLA76fbg0z
         eTikw/ZvhuPWxzkAO+A/VPR7z89XoJ6XvcSWBQe/foj40LbJKEXiz3J7nqTtvPOI/I8+
         XshQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuCuxojOFJj2oW01bTfHk0HkuwrqkKnxKlox40EBzb3TJYf6U01w8MWiSnhzn4ky9j9s2SI31xkjQ2qVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8fpysSCTXO8uetomB8qanQuA+U9t8HG3smjsmrUlxMv7VWES6
	H1m5iIHTvhqTYDRHwbQYh+zyIXgSq3v7Lt1BMFSzTSxYXAa9JKlD5NEDD2vCLP/8DAtIwIe0j+u
	nDe7RW3Fc7XSkhZNF/IuIUbYM0UFqNmN2QaI+QTvCwA==
X-Gm-Gg: ASbGncsRXSNt6YFFC3sbW4+J6gTFvpq9wgXiho8H7F4vgCMuI5lLyJ10cxDXsQF4iDF
	2R9MmSj0/tnXDp4LKRlATL04h/yzpa7p6nG5TcKIO85ydAASQdlVFxMHuq5F7wxQV6bV/5IIYSW
	Lprs+pdelP3TI75GsyeJPZGxrvAOYgINDwLKS/vhf1lo5IF1K4eJa3rJYNgUIuv/c0xhyOZYPHG
	AH2bicC
X-Google-Smtp-Source: AGHT+IEo5nowTE/kmucDEHrishTa1XrYiiyuTFtayRgTTm+E8uO5OzwI/Scst1QOoi4vBiyg+Oy6sxmd+YJaGyA1WnM=
X-Received: by 2002:a05:690c:d19:b0:70d:ffaf:48df with SMTP id
 00721157ae682-717d786dda1mr175760437b3.3.1752491603539; Mon, 14 Jul 2025
 04:13:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709154728.733920-1-daniel.lezcano@linaro.org>
In-Reply-To: <20250709154728.733920-1-daniel.lezcano@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 14 Jul 2025 13:12:47 +0200
X-Gm-Features: Ac12FXxaeX7OXBuCkXJ-j03hUCK21Ze9ZEebSgiQ5mn7RsuZUrOhhvlhJZv3Zm8
Message-ID: <CAPDyKFp9up-okoVZf5j+LFvpCOFgLjS8FY1eEqoaDU8remD8Hg@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: psci: Fix cpuhotplug routine with PREEMPT_RT=y
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rafael@kernel.org, sudeep.holla@arm.com, linux-pm@vger.kernel.org, 
	linux-rt-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Raghavendra Kakarla <quic_rkakarla@quicinc.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	"open list:Real-time Linux (PREEMPT_RT)" <linux-rt-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Jul 2025 at 17:47, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> Currently cpu hotplug with the PREEMPT_RT option set in the kernel is
> not supported because the underlying generic power domain functions
> used in the cpu hotplug callbacks are incompatible from a lock point
> of view. This situation prevents the suspend to idle to reach the
> deepest idle state for the "cluster" as identified in the
> undermentioned commit.
>
> Use the compatible ones when PREEMPT_RT is enabled and remove the
> boolean disabling the hotplug callbacks with this option.
>
> With this change the platform can reach the deepest idle state
> allowing at suspend time to consume less power.
>
> Tested-on Lenovo T14s with the following script:
>
> echo 0 > /sys/devices/system/cpu/cpu3/online
> BEFORE=$(cat /sys/kernel/debug/pm_genpd/power-domain-cpu-cluster0/idle_states | grep S0 | awk '{ print $3 }') ;
> rtcwake -s 1 -m mem;
> AFTER=$(cat /sys/kernel/debug/pm_genpd/power-domain-cpu-cluster0/idle_states | grep S0 | awk '{ print $3 }');
> if [ $BEFORE -lt $AFTER ]; then
>     echo "Test successful"
> else
>     echo "Test failed"
> fi
> echo 1 > /sys/devices/system/cpu/cpu3/online
>
> Fixes: 1c4b2932bd62 ("cpuidle: psci: Enable the hierarchical topology for s2idle on PREEMPT_RT")
> Cc: Raghavendra Kakarla <quic_rkakarla@quicinc.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Applied for fixes and by adding a stable-tag, thanks!

Kind regards
Uffe

> ---
>  drivers/cpuidle/cpuidle-psci.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index 4e1ba35deda9..b19bc60cc627 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -45,7 +45,6 @@ struct psci_cpuidle_domain_state {
>  static DEFINE_PER_CPU_READ_MOSTLY(struct psci_cpuidle_data, psci_cpuidle_data);
>  static DEFINE_PER_CPU(struct psci_cpuidle_domain_state, psci_domain_state);
>  static bool psci_cpuidle_use_syscore;
> -static bool psci_cpuidle_use_cpuhp;
>
>  void psci_set_domain_state(struct generic_pm_domain *pd, unsigned int state_idx,
>                            u32 state)
> @@ -124,8 +123,12 @@ static int psci_idle_cpuhp_up(unsigned int cpu)
>  {
>         struct device *pd_dev = __this_cpu_read(psci_cpuidle_data.dev);
>
> -       if (pd_dev)
> -               pm_runtime_get_sync(pd_dev);
> +       if (pd_dev) {
> +               if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +                       pm_runtime_get_sync(pd_dev);
> +               else
> +                       dev_pm_genpd_resume(pd_dev);
> +       }
>
>         return 0;
>  }
> @@ -135,7 +138,11 @@ static int psci_idle_cpuhp_down(unsigned int cpu)
>         struct device *pd_dev = __this_cpu_read(psci_cpuidle_data.dev);
>
>         if (pd_dev) {
> -               pm_runtime_put_sync(pd_dev);
> +               if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +                       pm_runtime_put_sync(pd_dev);
> +               else
> +                       dev_pm_genpd_suspend(pd_dev);
> +
>                 /* Clear domain state to start fresh at next online. */
>                 psci_clear_domain_state();
>         }
> @@ -196,9 +203,6 @@ static void psci_idle_init_cpuhp(void)
>  {
>         int err;
>
> -       if (!psci_cpuidle_use_cpuhp)
> -               return;
> -
>         err = cpuhp_setup_state_nocalls(CPUHP_AP_CPU_PM_STARTING,
>                                         "cpuidle/psci:online",
>                                         psci_idle_cpuhp_up,
> @@ -259,10 +263,8 @@ static int psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
>          * s2ram and s2idle.
>          */
>         drv->states[state_count - 1].enter_s2idle = psci_enter_s2idle_domain_idle_state;
> -       if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +       if (!IS_ENABLED(CONFIG_PREEMPT_RT))
>                 drv->states[state_count - 1].enter = psci_enter_domain_idle_state;
> -               psci_cpuidle_use_cpuhp = true;
> -       }
>
>         return 0;
>  }
> @@ -339,7 +341,6 @@ static void psci_cpu_deinit_idle(int cpu)
>
>         dt_idle_detach_cpu(data->dev);
>         psci_cpuidle_use_syscore = false;
> -       psci_cpuidle_use_cpuhp = false;
>  }
>
>  static int psci_idle_init_cpu(struct device *dev, int cpu)
> --
> 2.43.0
>


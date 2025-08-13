Return-Path: <linux-kernel+bounces-766563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9530AB24856
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D9341A26870
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6D72F656E;
	Wed, 13 Aug 2025 11:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pZEeUlg7"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C908A2D47FF
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 11:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755083882; cv=none; b=Lb0hcGaAf3bVux6gUkOwD7Q370b4Pi7+kgX1ntDVAB5elOUob+X7HlWQleg1OZG6Xl59KVbMc1puYX+rV+AQaMvpdfItzB+MKtyb4F4b7NXRga0k0Wb9wg9gXiOS41vta5uz78w2F3gJrMYqEck8EFN6N2Tz5y/VT/3mhK2W+GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755083882; c=relaxed/simple;
	bh=RyRDckRflIvigbMK4BKJe6kv1H6Avr2M4Juoxfr73+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sD6WJwfirn9Grrbd8MDeXDIA04LANNhkCJ3Uk9TQY3Ji0NwvrqxTb/oaIddNPe2PMvBy61bCtXel7tyXn+dunk+xHJI/onRZ/e0qYDaqDa19dUC3kyKo2QX9Oxh5n4qB3/PaWHYP/InQBXuJ1l67h7M6OpR3h4rSkAYF11O0MJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pZEeUlg7; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e905a3de7a0so3158488276.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 04:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755083880; x=1755688680; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UQn0ud8P/exClfh8nwi+p3iZczWgk30lvs9ZzrOzyjs=;
        b=pZEeUlg7fKmBYbrYn3J/fH2eoND1Ky6zItzzpQXFiVc46OnmSpQcbjNRbHJnvEe3rK
         pGjxcZ3VWcQbpHSzHz9RDmNim932rlpQVlrS0qnRZxCuug6V9zC48LO3H9K2phT/1wTm
         ME7FLFX4CTojhJEObpaRncUWksh4FdTwwhmdpw6E1Se0dPIJyqYST0Biz0w8249z/xXr
         9nhYsOXG1/ziVYzBaRGoNCq+138pWKPFaIWBt9CGMFlfc/m7T2VJaEc67Hxu6OHHvuYp
         qP3iqKwkwWls4vCGfax3NymMqTsTFEoD5z87huio5Y/SHvvDqFQBBA5ckHLmWiSI6WIe
         q6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755083880; x=1755688680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQn0ud8P/exClfh8nwi+p3iZczWgk30lvs9ZzrOzyjs=;
        b=dllUhNDdH62RoShC0GkYBnBJkwSzhqUKYzx+7NwkiYUj4qDiN5ZUHFLgyJd1UVaFnJ
         cfiyWY6pnhMzDRmx91dyErWOQfJ+WT5tDNiJPqbiRI06JsjpI0GXA/ypOfI46RoZ0awf
         /GtCvQnyhy08E73RhlQDt6dMwUGYuzy+rGHTnpkYOJM0SK9OlYwC8UX4CvSMBsITtvXD
         7JMXeXbmB6D/41vc1l+XUdxr234pfTmW7tFr657ItOZ11jIscz5Iz4kZrJYkxEz0Ehhv
         IPS3aWk0lFaAJTFYpl4+VxM3JBkwSeF2Ot3/ki3FSDHvybiDPKSs1ks6Tbr8vFVUf4B8
         3LEw==
X-Forwarded-Encrypted: i=1; AJvYcCUKLYacSnIxz/whRv0z0oFhJ2hLRnNebpyg27JohOOhOmKZk5GP06hErBX5F+Uv3GR0s7TIiTPnvioMUBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuxxajdF1lNeadiVET69Eh42C7Gtpi3pxiPUT2AME3VM9qbOyW
	MHB6JgvHFJ/M+mBU7MVCUVdIECSb0mnnOW71H3tgDIWk/GytvvFc5tY5aovuEZdvB+wukD6LSUD
	/PffW+sU8SmlwLqlNAZo1P7eHY3zh7UofSHzbfGx/Tg==
X-Gm-Gg: ASbGncsu8UF2LuB+YHnyL0R+UEECaDwtvQgEIOBAR2VfoQA3A5Sf1b7GRRlO5ShUUuZ
	appgp4pHiEr1DAYT+lN8E7OkG1bx8YxKDu7UWM3xVB7BoEwsO0sAKEiA3j3TLMZRnA7PphBV55N
	ey6+RerjUW/t6U4/lYfpg8VwL+tLj1Awp4jVH8BrJNqQdG5f8BATlnrnZJMZgbqpujzh9aNKCiy
	jNz3Pcv
X-Google-Smtp-Source: AGHT+IG052VMXccj//iGRu0wrLb2Y8MwTk9cbYCNNk3fvvneFhZ02VT0QHUekplN/0z2vyPr5RH0oPrEgIPeeW8/eko=
X-Received: by 2002:a05:690c:4b93:b0:71c:1673:7bd4 with SMTP id
 00721157ae682-71d4e52cb3dmr29653857b3.23.1755083879749; Wed, 13 Aug 2025
 04:17:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <81ef5f8d5d31374b7852b05453c52d2f735062a2.1755073087.git.geert+renesas@glider.be>
In-Reply-To: <81ef5f8d5d31374b7852b05453c52d2f735062a2.1755073087.git.geert+renesas@glider.be>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 13 Aug 2025 13:17:23 +0200
X-Gm-Features: Ac12FXxID4SAvN1nQwTTkwzxcE_ncFRuux2gIUE7FTXR5LTWY5TdT46TbnCNXb4
Message-ID: <CAPDyKFrCQdPAiDQyHm05mS7avOq6GPr0Ke4rZ2eaOhm37KGjfw@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: mstp: Add genpd OF provider at postcore_initcall()
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Lubomir Rintel <lkundrak@v3.sk>, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Aug 2025 at 10:20, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Genpd OF providers must now be registered after genpd bus registration.
> However, cpg_mstp_add_clk_domain() is only called from CLK_OF_DECLARE(),
> which is too early.  Hence on R-Car M1A, R-Car H1, and RZ/A1, the
> CPG/MSTP Clock Domain fails to register, and any devices residing in
> that clock domain fail to probe.
>
> Fix this by splitting initialization into two steps:
>   - The first part keeps on registering the PM domain with genpd at
>     CLK_OF_DECLARE(),
>   - The second and new part moves the registration of the genpd OF
>     provider to a postcore_initcall().
>
> See also commit c5ae5a0c61120d0c ("pmdomain: renesas: rcar-sysc: Add
> genpd OF provider at postcore_initcall").
>
> Fixes: 18a3a510ecfd0e50 ("pmdomain: core: Add the genpd->dev to the genpd provider bus")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

I assume there is a good reason to have one early part and one later
part for the OF provider registration, otherwise we might as well do
all the genpd registration at postcore_initcall, right?

In any case, please add:
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
> To be queued as a fix in renesas-clk-for-v6.17.
>
> drivers/clk/mmp/clk-of-mmp2.c:mmp2_pm_domain_init() has the same issue.
>
> Note that R-Car H1 still booted fine, as the CPG/MSTP Clock Domain is no
> longer used directly on that SoC: all devices were moved to the R-Car
> SYSC PM Domain in commits 751e29bbb64ad091 ("ARM: dts: r8a7779: Use SYSC
> "always-on" PM Domain") and commit a03fa77d85a736d3 ("ARM: dts: r8a7779:
> Use SYSC "always-on" PM Domain for HSCIF"), and use the clock domain
> only indirectly from rcar-sysc through cpg_mstp_{at,de}tach_dev()).
> ---
>  drivers/clk/renesas/clk-mstp.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/renesas/clk-mstp.c b/drivers/clk/renesas/clk-mstp.c
> index 6b47bb5eee45f75b..5fcc81b92a973771 100644
> --- a/drivers/clk/renesas/clk-mstp.c
> +++ b/drivers/clk/renesas/clk-mstp.c
> @@ -305,6 +305,9 @@ void cpg_mstp_detach_dev(struct generic_pm_domain *unused, struct device *dev)
>                 pm_clk_destroy(dev);
>  }
>
> +static struct device_node *cpg_mstp_pd_np __initdata = NULL;
> +static struct generic_pm_domain *cpg_mstp_pd_genpd __initdata = NULL;
> +
>  void __init cpg_mstp_add_clk_domain(struct device_node *np)
>  {
>         struct generic_pm_domain *pd;
> @@ -326,5 +329,20 @@ void __init cpg_mstp_add_clk_domain(struct device_node *np)
>         pd->detach_dev = cpg_mstp_detach_dev;
>         pm_genpd_init(pd, &pm_domain_always_on_gov, false);
>
> -       of_genpd_add_provider_simple(np, pd);
> +       cpg_mstp_pd_np = of_node_get(np);
> +       cpg_mstp_pd_genpd = pd;
> +}
> +
> +static int __init cpg_mstp_pd_init_provider(void)
> +{
> +       int error;
> +
> +       if (!cpg_mstp_pd_np)
> +               return -ENODEV;
> +
> +       error = of_genpd_add_provider_simple(cpg_mstp_pd_np, cpg_mstp_pd_genpd);
> +
> +       of_node_put(cpg_mstp_pd_np);
> +       return error;
>  }
> +postcore_initcall(cpg_mstp_pd_init_provider);
> --
> 2.43.0
>


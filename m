Return-Path: <linux-kernel+bounces-863064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 499C5BF6E8A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAC1619A0BB3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50032339708;
	Tue, 21 Oct 2025 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z7MiLYc9"
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63A6338935
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054894; cv=none; b=hYzc3I0u12M/eJ/VMBWCWse0kvrbTJo84OmIgdursxNQvP+VI3WKtL8YGLfb4fwTIHLhz5gs5J1H0grBGzE3TLasCWnityIZ6JexYgFDsm3MVaDulD+cnmJm2n5nhy1fGLH6MqgyOTlil3A+hGPGz+0/0fL4MSgDtOkWVGojTNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054894; c=relaxed/simple;
	bh=WjXVc6EHp/g4iSC0dgl+mBlijG+pJ2E1MMjbyg07e+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o3A0E8cxYd7/1fu/FRrXR49/xXJ3i7/4V8QXuRqhlkarIZO91OLZbFuMujESeKqOaJEl9Egw7O9YwOzZA1EkCRpYRxcmOVoMWoCsD+n4cRmeURZemg8UGS1QnTvT7rUT1MKn+Q++0IIJAbww/KWQ55q29JsdlB5Gwp+BvABPyO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z7MiLYc9; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-63bcfcb800aso6037827d50.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761054892; x=1761659692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7l2S0fTu5SAF3VSsMCSsLrp+bmdGs9v0RGyTD+mw5o=;
        b=Z7MiLYc94MoWtpRRdN94cauHSrYJHA2B/Y6/IEgd5CgGX96YFHY3fVWOtro0a4Gaaa
         41wtWTBU/Aeo13JTK860LTl8Is3s5pnxRuIa5yayhMDPjkCjVD1UFfBo+pNaqQAx+Di7
         +zM1UpZBKht2heAxtX4OZ1oeIdb5SfzogJ0pfrbcwaz0thc4EOWL4K1OgpnajXudnKR9
         K0qVRXO3gytM2LZRHcib8v/LBLYc97EjKP/schY7KPeJ3AvK81cCBI1zccA7cceTIMal
         K+zRA1QAe7rCu1HNMXgi05P9J9exSmXwqQ7eMoVWBygUVXRVmwsmX0J+qkBDIhITDbTj
         3HiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761054892; x=1761659692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7l2S0fTu5SAF3VSsMCSsLrp+bmdGs9v0RGyTD+mw5o=;
        b=XkGydXHARpP0x4EGVwlMtzVx9SZnP2KoHx4CxDc7FCLkomdHmlk9U5Q/kqiuDf3aL9
         WQxYG3272oqsGSPmv/mvfGPC/mA848DBqQ83At5Sh4WzmuF/i0gfsjCt45rdPsmC9yWf
         FgLODpuagiup9+USFZZq3554jVFUA90iUENeFNSMxtuWounnWu4BKkRZWGkFFGPKJ1Lp
         41/vbgASJ7PXsR+0PD3XeZruEqefo9Gw/Clm0X6OnrczE94/zDXugJXpBNi+G0nvyeqO
         b3Lwltp8G1tI71Pd6y4jhh32bTozxQ+bxQ0ln3oVxeTL7X7EDWNCFaPszXIaBIqz5SnA
         M/UA==
X-Forwarded-Encrypted: i=1; AJvYcCXPxYeu7F2uov/YFoZOOXhlM7/SYHKsaCcxaGSiguQSbSCvTuhhKgK9IUnrupUElm2xiBi6Iqn42GeHE4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCZdYixA+k5yynsvkvEC+d4J79hjctmvXJOl0S4bOVyZBt63Ks
	l9DDgWaG0ivyNE39aPqn8RilabNItVgZU8NAxS38TUFtvAgbX6ULGTJ6Y/lc2yPkqyygQUzpnPu
	+EJszhZ4Vz8K/VEsq4/MRwDcXfd15Xm3PtzhM5rG+fg==
X-Gm-Gg: ASbGncuKGdzysm4MONzatMjykfvV7AC7bM966qmH6d6oY6TMbrHb7i1UVkkmLWKl7Wp
	TqVpnZSyowXhXLR/LdOUI/G+3OXUHpvHTJJSunDad6JCFaq2HNxwnj4jdKMsghbKgw3FHS6anCk
	14rXMHhI/6gnBMHGkf/GJZbrDmoj+EeaEeCmAs+gZgPkSTFm4lpCPY+rfOd4UhaXgSfIHSqLc1j
	L0AU7Aqc0a1ZhtVQw5MH9Ck98Pgr5bcKvHlHYNNYudqeJgrbC0vHkyPBMGwhAlcvImTGmAh
X-Google-Smtp-Source: AGHT+IHBbKVNcuM7l9dFMzW3m4txAHgl/oBl0HllzJAJ6dzOGjsTsg6Juv5F+fWERMC7Ma504B1opcnGXEPDICN6WPQ=
X-Received: by 2002:a05:690e:134a:b0:63e:34ed:a131 with SMTP id
 956f58d0204a3-63e34eda971mr6291641d50.31.1761054891971; Tue, 21 Oct 2025
 06:54:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org> <20251016-gs101-pd-v3-4-7b30797396e7@linaro.org>
In-Reply-To: <20251016-gs101-pd-v3-4-7b30797396e7@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 21 Oct 2025 15:54:16 +0200
X-Gm-Features: AS18NWDpF262ybo6_Emnnj0aCX8cQdB1lik5qoOWoSB0z0MgCBOGMTnmDv5nouE
Message-ID: <CAPDyKFpH2p=JhkuXOxL4V3QMH8GObh0qSphPCK=OM9cNe+QmJg@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] pmdomain: samsung: plug potential memleak during probe
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, stable@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Oct 2025 at 17:58, Andr=C3=A9 Draszik <andre.draszik@linaro.org>=
 wrote:
>
> of_genpd_add_provider_simple() could fail, in which case this code
> leaks the domain name, pd->pd.name.
>
> Use devm_kstrdup_const() to plug this leak. As a side-effect, we can
> simplify existing error handling.
>
> Fixes: c09a3e6c97f0 ("soc: samsung: pm_domains: Convert to regular platfo=
rm driver")
> Cc: stable@vger.kernel.org
> Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> v2:
> mark as fix, as this isn't a pure simplification
> ---
>  drivers/pmdomain/samsung/exynos-pm-domains.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdom=
ain/samsung/exynos-pm-domains.c
> index 5d478bb37ad68afc7aed7c6ae19b5fefc94a9035..f53e1bd2479807988f969774b=
4b7b4c5739c1aba 100644
> --- a/drivers/pmdomain/samsung/exynos-pm-domains.c
> +++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
> @@ -92,13 +92,14 @@ static const struct of_device_id exynos_pm_domain_of_=
match[] =3D {
>         { },
>  };
>
> -static const char *exynos_get_domain_name(struct device_node *node)
> +static const char *exynos_get_domain_name(struct device *dev,
> +                                         struct device_node *node)
>  {
>         const char *name;
>
>         if (of_property_read_string(node, "label", &name) < 0)
>                 name =3D kbasename(node->full_name);
> -       return kstrdup_const(name, GFP_KERNEL);
> +       return devm_kstrdup_const(dev, name, GFP_KERNEL);
>  }
>
>  static int exynos_pd_probe(struct platform_device *pdev)
> @@ -115,15 +116,13 @@ static int exynos_pd_probe(struct platform_device *=
pdev)
>         if (!pd)
>                 return -ENOMEM;
>
> -       pd->pd.name =3D exynos_get_domain_name(np);
> +       pd->pd.name =3D exynos_get_domain_name(dev, np);
>         if (!pd->pd.name)
>                 return -ENOMEM;
>
>         pd->base =3D of_iomap(np, 0);
> -       if (!pd->base) {
> -               kfree_const(pd->pd.name);
> +       if (!pd->base)
>                 return -ENODEV;
> -       }
>
>         pd->pd.power_off =3D exynos_pd_power_off;
>         pd->pd.power_on =3D exynos_pd_power_on;
>
> --
> 2.51.0.788.g6d19910ace-goog
>


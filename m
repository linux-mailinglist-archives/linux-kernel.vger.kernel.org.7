Return-Path: <linux-kernel+bounces-867076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD63C01888
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76C73189B9A8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEC231329E;
	Thu, 23 Oct 2025 13:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ja2Eu7OG"
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22059274FCB
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227254; cv=none; b=Gr4Y6o0CJiZobX8zWA9DCLEqpOTShEuphxyNhBdRCB0dsPlx1BCbGrds7bW8B4SyVmzh4wSrFAqVXDMYaOzxXJsEhEwEI3RekiHBJzfDB2dE1TqpJm17Zh0GuQOLcaD3XaABhuLSLM2JIbBKn1VI+4R3v9FIj8dx5pgcNnELHsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227254; c=relaxed/simple;
	bh=2YtJ6LRyOGedFxwzkzDH/Zo54OflUP87J7mbaNdzMkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MMM5qEmiwyQZZlv12OhSs0mrm1p0lGMW2O0AEwRFLaj7Syc3XFC4ee5ZthOLgQo5xTjdxaKrRaWWp7iXxR/ZjmZydvSvWgKxkqw+JHGBPTDiyQ/WkJevflUtKUQb0yBm4jVSc4UyE46HvFSCrUjIgQiHoEvUFnn9zxMlYyKfl1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ja2Eu7OG; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-63d0692136bso998526d50.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761227251; x=1761832051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgz0MPvCEEIvnpRdxEKizmyGPKxuxFkbXXBpVNZQA2U=;
        b=Ja2Eu7OGV8fmhnZdia+rMmYTql6h0cSvLZ32B2KTgdoKGSfCUrOd5PdlnRkD4SoMna
         lTgyFTfMO5+GqKljBviRqhve2HNNApKaiyJ6WsWvQKozV3672XhyO1bl+n1YStYlbdq/
         eklTNaJkrAYYDNcizz/7nofFYIZuEOvEEAC8utmkroV0QA71++AFBtAEBRugVJFQwNEr
         utLzuUCDIOjHiJaoAsnrgldc56ocllALnqJ2BQcMNl+nFPfJ0dWEAmczAcQO4EPWqZ4l
         f4Bi9X/drxki7yaSIgxRzsDhQoYVhdWRvpHHCvWPXnewJnaK7y45dgtpJimU89K7vLzK
         1mrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761227251; x=1761832051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hgz0MPvCEEIvnpRdxEKizmyGPKxuxFkbXXBpVNZQA2U=;
        b=crUKCJJoeOSLY63fatON8FtPiFx29fRh9jz+OAdpRdVKDlOjCm87v5xP5RDYSDhNpy
         9KikdXSVaEsW3RaVyXQbmRhFXFPqn4mKmJ0KLlw5r1uH630YsPmS3F9/Nq2NU+Us2e4s
         NfbsLOVSmKAqZECszxd9ThoMYY67YnBiiWtzzYDRO0p9njaIfP9LwLW7x1qyIRiWmhRM
         M8S2OooEZciy3H+hSq6VHeQnpSZvvp7zL25cOmW88w+ptdW4AqjJ4wL8MnZZJtVZBo2/
         +41uj3GgbDvh/IoyuVVmkhXWqXTlLWBeCl41XsUx1ng+OuUXQei8xza950JoI2Y85T5Q
         aOQg==
X-Forwarded-Encrypted: i=1; AJvYcCXQNaXXoPDk/q1fh7oZAeRt1WM8df1SzE99qKRn+hWZKmUO4pOat5YN1bzEJTpeh0AywRDMR9FhXDG0oSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSxN6qTLPEBzpIq2yeSfgBeItASmWbGvHU0ffuricPgxQC4xx7
	wtx7N+c+Ean8LKC9nJkzi9L4t8SW2X1JRd9bFuAPtoEzOBPijdmujTWrRIVM9GJfUn17vSnZzk8
	voTzjENrAcJlvaD11NHVB5a7XQc63K1fFcAYNnZk58tsd9mCjF/qqKB0=
X-Gm-Gg: ASbGncumpqN/LhbvblAmVGOSEvtMsA6yXZCkauhcKYK7v6/Ma5XKU+ZhDx6Od/QTpVs
	HJC22nMCkE+6Vjbf57nhblye2N3k5jKmUZOrZwuK+YLXu9PluCy9e1MToJgsbF4oLpO4YiPNt0b
	OiuVjotHQZk8oNa3KVrUj1BDx20POzSvKOfjB8bmAigrLj8LD2Zgi/8loF2Ub79mQUz6afx6SIM
	MTkP/P5DmsBJ9kEaLUZRFj8HCgTLiRCJo5hnhOwB8aGEQDnwFYRFnzg5ZT3CQ==
X-Google-Smtp-Source: AGHT+IEDCfqv4pG4v0i8RCV2WYShTzR+pW/qVzfUKwEjCpv3rEpG8LtgRQWNRSjF/bG233OV5m2cMcbi37urgECEqnQ=
X-Received: by 2002:a05:690e:1598:10b0:63c:e90c:a6dc with SMTP id
 956f58d0204a3-63e160d9059mr18376155d50.8.1761227250806; Thu, 23 Oct 2025
 06:47:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org>
 <20251016-gs101-pd-v3-8-7b30797396e7@linaro.org> <CGME20251022110738eucas1p2cee28096ca5c9c6a802e2190d88ccf21@eucas1p2.samsung.com>
 <CAPDyKFq2esPos=D-eVz6w1VXq=4LYi6fx54K4TvsUi4JqUJOaQ@mail.gmail.com>
 <57bacc06-8a5e-4284-a520-c5d2a56545e9@samsung.com> <CAPDyKFrCS1PGwPeZd2ahZ=wKXCqPj93qAJ7V-ELELLA_OwgdSw@mail.gmail.com>
 <cca286f5-bb43-4914-864c-b5e5c73270c8@samsung.com>
In-Reply-To: <cca286f5-bb43-4914-864c-b5e5c73270c8@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 23 Oct 2025 15:46:54 +0200
X-Gm-Features: AS18NWABfjM36klv5hIIGT-5MwjE_SPbRGTiI4LQB-iSMF8Ct_lzzibZCZxPGQY
Message-ID: <CAPDyKFppte-Rh-xNybEz8dshrD2gfqJHUpiL1bPWzZ6pBig6+g@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] pmdomain: samsung: selectively handle enforced sync_state
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Oct 2025 at 14:17, Marek Szyprowski <m.szyprowski@samsung.com> w=
rote:
>
> On 23.10.2025 12:02, Ulf Hansson wrote:
> > On Wed, 22 Oct 2025 at 20:39, Marek Szyprowski <m.szyprowski@samsung.co=
m> wrote:
> >> On 22.10.2025 13:06, Ulf Hansson wrote:
> >>> On Thu, 16 Oct 2025 at 17:58, Andr=C3=A9 Draszik <andre.draszik@linar=
o.org> wrote:
> >>>> Unconditionally calling of_genpd_sync_state() causes issues on
> >>>> platforms with child domains as the parent domain will be turned off
> >>>> before the child domain was even registered during boot.
> >>>>
> >>>> This in particular is an issue for the upcoming Google gs101 support=
 -
> >>>> all operations on child domains registered after the parent domain
> >>>> misbehave.
> >>>>
> >>>> Add a flag to the probe data to be able to sync_state conditionally
> >>>> only, and enable that flag on the two platforms currently supported =
by
> >>>> this driver.
> >>>>
> >>>> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> >>>>
> >>>> ---
> >>>> v2:
> >>>> * use bool for need_early_sync_state (Krzysztof)
> >>>> ---
> >>>>    drivers/pmdomain/samsung/exynos-pm-domains.c | 5 ++++-
> >>>>    1 file changed, 4 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/=
pmdomain/samsung/exynos-pm-domains.c
> >>>> index 638d286b57f716140b2401092415644a6805870e..15a1582aa92103a07335=
eb681600d9415369fefd 100644
> >>>> --- a/drivers/pmdomain/samsung/exynos-pm-domains.c
> >>>> +++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
> >>>> @@ -20,6 +20,7 @@
> >>>>    struct exynos_pm_domain_config {
> >>>>           /* Value for LOCAL_PWR_CFG and STATUS fields for each doma=
in */
> >>>>           u32 local_pwr_cfg;
> >>>> +       bool need_early_sync_state;
> >>>>    };
> >>>>
> >>>>    /*
> >>>> @@ -69,10 +70,12 @@ static int exynos_pd_power_off(struct generic_pm=
_domain *domain)
> >>>>
> >>>>    static const struct exynos_pm_domain_config exynos4210_cfg =3D {
> >>>>           .local_pwr_cfg          =3D 0x7,
> >>>> +       .need_early_sync_state  =3D true,
> >>>>    };
> >>>>
> >>>>    static const struct exynos_pm_domain_config exynos5433_cfg =3D {
> >>>>           .local_pwr_cfg          =3D 0xf,
> >>>> +       .need_early_sync_state  =3D true,
> >>>>    };
> >>>>
> >>>>    static const struct of_device_id exynos_pm_domain_of_match[] =3D =
{
> >>>> @@ -179,7 +182,7 @@ static int exynos_pd_probe(struct platform_devic=
e *pdev)
> >>>>            * reset during boot. As a temporary hack to manage this, =
let's enforce
> >>>>            * a sync_state.
> >>>>            */
> >>>> -       if (!ret)
> >>>> +       if (pm_domain_cfg->need_early_sync_state && !ret)
> >>>>                   of_genpd_sync_state(np);
> >>> The call to of_genpd_sync_state() was intended as a temporary solutio=
n here.
> >>>
> >>> Potentially, if we would be able to distinguish what PM domain that i=
s
> >>> causing the problem on the Exynos platforms, we could set
> >>> GENPD_FLAG_NO_STAY_ON for that genpd instead.
> >> Well, this of_genpd_sync_state() "workaround" has to be applied only t=
o
> >> the power domain of the display controller device. It can be replaced =
by
> >> the following check on the legacy Exynos systems:
> >>
> >> if (IS_ENABLED(CONFIG_ARM) &&
> >> of_device_is_compatible(np, "samsung,exynos4210-pd") &&
> >> (strstr(pd->pd.name, "LCD") || strstr(pd->pd.name, "DISP")))
> >> pd->pd.flags =3D GENPD_FLAG_NO_STAY_ON;
> > Oh wait, perhaps better to just power-off these PM domains before
> > calling pm_genpd_init(), if that can be done safely?
> >
> > At least that would guarantee the reset to happen before the display
> > driver gets probed. Instead of relying on genpd_power_off_unused()
> > (late_initcall_sync) to do it.
>
> Well, yes, this works too:
>
> if ((of_device_is_compatible(np, "samsung,exynos4210-pd") &&
>      (strstr(pd->pd.name, "LCD") || strstr(pd->pd.name, "DISP"))))
>           exynos_pd_power_off(&pd->pd);

Okay!

Should we (you or me?) send a patch and change the code like this?

>
> >> I assume that this information cannot be coded in device tree to make =
it
> >> somehow generic...
> > Right, in principle we would need a new DT property for a power-domain
> > provider, like "broken-hw-reset", because we don't have a reset-line
> > to pull.
>
> It is not a matter of broken reset at all. It is a matter of software
> configuration and the lack of 'protocol' to pass the information that
> the display controller is configured to display splash screen from the
> system memory at given address and newly instantiated drivers must to be
> aware of that.
>
> Turning display-related power domain off simply resets all that
> configuration, so drivers can start from good known 'unconfigured' state.

Alright, thanks for clarifying! Yeah, a DT property would be wrong for this=
.

In fact, there are some drivers [1] that make use of the genpd on/off
notifiers to manage a reset of its device's PM domain. It works, but
it's a bit messy. Perhaps it could be simplified with some new helper
functions, if more consumers drivers need something similar.

Kind regards
Uffe

[1]
commit c11fa1204fe9 ("drm/msm/a6xx: Use genpd notifier to ensure
cx-gdsc collapse")


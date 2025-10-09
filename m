Return-Path: <linux-kernel+bounces-846367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 28509BC7BA8
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 09:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F22E4F1974
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 07:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72641F4606;
	Thu,  9 Oct 2025 07:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jFGnBWyj"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BADC3FF1
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 07:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759995217; cv=none; b=TSoS4AYlfZ4GNI1BfTQs+V+JndGGxQz2Zkptz2QSyuKjluaVWOH8XDREwUlG+RR8f4TNV2cbK+61ufseqw+3A9fHJImh+9P0ktGlbmbOkFbBR8o14XF6U7tpPn1LF+67XTr+uwMtCIJl487kj8jZcu0TPZGMmn7ipJKUhpZBe6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759995217; c=relaxed/simple;
	bh=G8OoxQLaFK2PaPDhEJDRVm1b1vFwiUVvBv4LPzwja2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qs2OI2WbKb8aMJnh/i/OHau6nEDfE5rlde2xYbJ498ihspblqwe5o8bXEntOc1vzg0nrW7BcsuCJSmso1reYiTFLvA5y7IvOLxjU5YaU/F61l9hcbOj5jIotXi34o9TdUKMzTN8ZZYgbX9lhPt6sFvoD6mDICfCZro5s/svycP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jFGnBWyj; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-36453927ffaso4820261fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 00:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759995213; x=1760600013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NATA04lG9cqYNuKN4V/mGz7RayXhel8O3qk+QILIDN0=;
        b=jFGnBWyjp8PPlIsG3UmFz50ei1x5BzvUhm1lYGWJkUwbSh+M/jmRzjeqXlEZ0iglKw
         PPbKitcRVD8+tucaDaoWNlLeTkG+7KOk3FmGZVujJ60+Ao2vCwouNXiYwc69PO5M/hho
         oMgeZv1oihZa/K5+XiuWeldp4WSVIGlLigJFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759995213; x=1760600013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NATA04lG9cqYNuKN4V/mGz7RayXhel8O3qk+QILIDN0=;
        b=uG22Mcj2yLEibl8XVgJ+meBQav3UP5PrrPTvuHeUjHUE8ImjLUPTbwu8hSEmS1cUGS
         ZsBIwMudVzvh9mT0pk1nuf5Cv6jmkIOf3DGw2dRed42Zh7M7AfupqFMDN56OQ1GVaVKm
         CguK/r9gBeRR66aJXGuCxAOk8bDM/y0ZwCeHWskciQqFaMq5/FQYvnjm/3lGqArucNgj
         KHw7MoRNw8ImoMJZNxtsNUd7qTzJgtaxN89H7YqqJ+h3qYpeW8aLb/oa5JeWpX2unAne
         +eT+yZaz4N3c9vR9g3e/JN3Zl7RnzxiaiNJ0/h7buiz3KqdSUt1Hj851K9v5v4WgFfZZ
         OlCw==
X-Forwarded-Encrypted: i=1; AJvYcCXrMIGQzrbRKqUTE7kpJzxECh8gi9EJm1kXoFpv/0zLenrId2YLGbTS1wZN92HwrQLg8Ty5xCgEkzi3EeM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzqw28ibqpTugy1U6kkYnGoSGiPW63OkfLF6uvbWS+ZZkPu7wJ
	pfAQW71boBWEOJXx3XSZ5IHaLayJ1TPHFUIobluMzxLyBMfu4bqBGTz/FlPpCCOaRfHda3w1MZU
	eCzOqrR+ifBeIFQK5mpQ0s2jBkXpq8yVXKgzszA1F
X-Gm-Gg: ASbGncvskwSivr9VoNyDivCH7pV2jrFVzeBK886V57W34VtFDzz8vz6+cm/tGFWyn1n
	9fpXMhvqHZG5g3pmw1/HGq6yxTmwCjglAAFRyAA/CZQ5jc8dvMItnjKeCZuIOevCrnDBkVsVdPE
	He03h5xz8biz4lfbG6VCl6JpbOeju+0bIguhfsVgASLi2DjJIq5POoxWzdE+YVTK3GQdcsdunA0
	6ztf1mdV5XhHb39yVDsRcuCqPKryog6xLKFjvE2HhGIQh338KN0uH/7d7Gh4g==
X-Google-Smtp-Source: AGHT+IF6m8ACDaU9hzMk8xdqL2Q2Hbks2uUt6Iy3PDX+KKlJyzdC/zfk13eIYMHbsDIcLqn07l/Zwc+Zn356g2up4Tk=
X-Received: by 2002:a2e:be9a:0:b0:337:f1d7:d500 with SMTP id
 38308e7fff4ca-37609d953b8mr16127351fa.18.1759995213025; Thu, 09 Oct 2025
 00:33:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008-mtk-pll-rpm-v2-0-170ed0698560@collabora.com> <20251008-mtk-pll-rpm-v2-4-170ed0698560@collabora.com>
In-Reply-To: <20251008-mtk-pll-rpm-v2-4-170ed0698560@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 9 Oct 2025 15:33:22 +0800
X-Gm-Features: AS18NWDCKGPR4MxJLy6Y5o4fyCGycMwSUzGQZN0AhucPrjjtAqoX3WiLmZowTiU
Message-ID: <CAGXv+5Hpndq09cbudofSvkNE6w+tHb85VCqDb3P920S8vwonHQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] clk: mediatek: Refactor pllfh registration to pass device
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Dong Aisheng <aisheng.dong@nxp.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Yassine Oudjana <y.oudjana@protonmail.com>, Laura Nao <laura.nao@collabora.com>, 
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Chia-I Wu <olvaffe@gmail.com>, kernel@collabora.com, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Stephen Boyd <sboyd@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 12:06=E2=80=AFAM Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> After refactoring all of PLL to pass the device, it's now fairly easy to
> refactor pllfh and its users, as pllfh registration wraps PLL
> registration.
>
> Do this refactor and move all of the pllfh users to pass the device as
> well.
>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/clk/mediatek/clk-mt6795-apmixedsys.c |  2 +-
>  drivers/clk/mediatek/clk-mt8173-apmixedsys.c | 14 +++++++-------
>  drivers/clk/mediatek/clk-mt8186-apmixedsys.c |  2 +-
>  drivers/clk/mediatek/clk-mt8192-apmixedsys.c |  2 +-
>  drivers/clk/mediatek/clk-mt8195-apmixedsys.c |  2 +-
>  drivers/clk/mediatek/clk-pllfh.c             | 13 ++++++++-----
>  drivers/clk/mediatek/clk-pllfh.h             |  2 +-
>  7 files changed, 20 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mt6795-apmixedsys.c b/drivers/clk/m=
ediatek/clk-mt6795-apmixedsys.c
> index 91665d7f125efde4941cc4de881c5b503a935529..123d5d7fea8554676364dc56f=
5c023e43325d516 100644
> --- a/drivers/clk/mediatek/clk-mt6795-apmixedsys.c
> +++ b/drivers/clk/mediatek/clk-mt6795-apmixedsys.c
> @@ -152,7 +152,7 @@ static int clk_mt6795_apmixed_probe(struct platform_d=
evice *pdev)
>                 return -ENOMEM;
>
>         fhctl_parse_dt(fhctl_node, pllfhs, ARRAY_SIZE(pllfhs));
> -       ret =3D mtk_clk_register_pllfhs(node, plls, ARRAY_SIZE(plls),
> +       ret =3D mtk_clk_register_pllfhs(dev, plls, ARRAY_SIZE(plls),
>                                       pllfhs, ARRAY_SIZE(pllfhs), clk_dat=
a);
>         if (ret)
>                 goto free_clk_data;
> diff --git a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c b/drivers/clk/m=
ediatek/clk-mt8173-apmixedsys.c
> index 95385bb67d5511eda3a851f81986e67eaf81e5fb..d7d416172ab35bc027ae67c16=
3c1dc20dee857b6 100644
> --- a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
> +++ b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
> @@ -140,13 +140,13 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8173_apmixed=
);
>  static int clk_mt8173_apmixed_probe(struct platform_device *pdev)
>  {
>         const u8 *fhctl_node =3D "mediatek,mt8173-fhctl";
> -       struct device_node *node =3D pdev->dev.of_node;
>         struct clk_hw_onecell_data *clk_data;
> +       struct device *dev =3D &pdev->dev;
>         void __iomem *base;
>         struct clk_hw *hw;
>         int r;
>
> -       base =3D of_iomap(node, 0);
> +       base =3D of_iomap(dev->of_node, 0);
>         if (!base)
>                 return -ENOMEM;
>
> @@ -157,25 +157,25 @@ static int clk_mt8173_apmixed_probe(struct platform=
_device *pdev)
>         }
>
>         fhctl_parse_dt(fhctl_node, pllfhs, ARRAY_SIZE(pllfhs));
> -       r =3D mtk_clk_register_pllfhs(node, plls, ARRAY_SIZE(plls),
> -                                   pllfhs, ARRAY_SIZE(pllfhs), clk_data)=
;
> +       r =3D mtk_clk_register_pllfhs(dev, plls, ARRAY_SIZE(plls), pllfhs=
,
> +                                   ARRAY_SIZE(pllfhs), clk_data);
>         if (r)
>                 goto free_clk_data;
>
>         hw =3D mtk_clk_register_ref2usb_tx("ref2usb_tx", "clk26m", base +=
 REGOFF_REF2USB);
>         if (IS_ERR(hw)) {
>                 r =3D PTR_ERR(hw);
> -               dev_err(&pdev->dev, "Failed to register ref2usb_tx: %d\n"=
, r);
> +               dev_err(dev, "Failed to register ref2usb_tx: %d\n", r);
>                 goto unregister_plls;
>         }
>         clk_data->hws[CLK_APMIXED_REF2USB_TX] =3D hw;
>
> -       hw =3D devm_clk_hw_register_divider(&pdev->dev, "hdmi_ref", "tvdp=
ll_594m", 0,
> +       hw =3D devm_clk_hw_register_divider(dev, "hdmi_ref", "tvdpll_594m=
", 0,
>                                           base + REGOFF_HDMI_REF, 16, 3,
>                                           CLK_DIVIDER_POWER_OF_TWO, NULL)=
;
>         clk_data->hws[CLK_APMIXED_HDMI_REF] =3D hw;
>
> -       r =3D of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_dat=
a);
> +       r =3D of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,=
 clk_data);
>         if (r)
>                 goto unregister_ref2usb;
>
> diff --git a/drivers/clk/mediatek/clk-mt8186-apmixedsys.c b/drivers/clk/m=
ediatek/clk-mt8186-apmixedsys.c
> index 4b2b16578232d986f78deed4778c5fab7f460184..d35dd2632e43ab535b32b8b99=
f8d75de02d56fe2 100644
> --- a/drivers/clk/mediatek/clk-mt8186-apmixedsys.c
> +++ b/drivers/clk/mediatek/clk-mt8186-apmixedsys.c
> @@ -151,7 +151,7 @@ static int clk_mt8186_apmixed_probe(struct platform_d=
evice *pdev)
>
>         fhctl_parse_dt(fhctl_node, pllfhs, ARRAY_SIZE(pllfhs));
>
> -       r =3D mtk_clk_register_pllfhs(node, plls, ARRAY_SIZE(plls),
> +       r =3D mtk_clk_register_pllfhs(&pdev->dev, plls, ARRAY_SIZE(plls),
>                                     pllfhs, ARRAY_SIZE(pllfhs), clk_data)=
;
>         if (r)
>                 goto free_apmixed_data;
> diff --git a/drivers/clk/mediatek/clk-mt8192-apmixedsys.c b/drivers/clk/m=
ediatek/clk-mt8192-apmixedsys.c
> index 0b66a27e4d5ac68f09dc6a4197fd84ef82342df9..b0563a285bd666d492a7fa940=
733aad1ab1a0bae 100644
> --- a/drivers/clk/mediatek/clk-mt8192-apmixedsys.c
> +++ b/drivers/clk/mediatek/clk-mt8192-apmixedsys.c
> @@ -162,7 +162,7 @@ static int clk_mt8192_apmixed_probe(struct platform_d=
evice *pdev)
>
>         fhctl_parse_dt(fhctl_node, pllfhs, ARRAY_SIZE(pllfhs));
>
> -       r =3D mtk_clk_register_pllfhs(node, plls, ARRAY_SIZE(plls),
> +       r =3D mtk_clk_register_pllfhs(&pdev->dev, plls, ARRAY_SIZE(plls),
>                                     pllfhs, ARRAY_SIZE(pllfhs), clk_data)=
;
>         if (r)
>                 goto free_clk_data;
> diff --git a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c b/drivers/clk/m=
ediatek/clk-mt8195-apmixedsys.c
> index 282a3137dc89419a6d0b574fd549cee941687900..44917ab034c56f01ef02d1957=
f17eb0655438d75 100644
> --- a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
> +++ b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
> @@ -181,7 +181,7 @@ static int clk_mt8195_apmixed_probe(struct platform_d=
evice *pdev)
>
>         fhctl_parse_dt(fhctl_node, pllfhs, ARRAY_SIZE(pllfhs));
>
> -       r =3D mtk_clk_register_pllfhs(node, plls, ARRAY_SIZE(plls),
> +       r =3D mtk_clk_register_pllfhs(&pdev->dev, plls, ARRAY_SIZE(plls),
>                                     pllfhs, ARRAY_SIZE(pllfhs), clk_data)=
;
>         if (r)
>                 goto free_apmixed_data;
> diff --git a/drivers/clk/mediatek/clk-pllfh.c b/drivers/clk/mediatek/clk-=
pllfh.c
> index 62bfe4a480f14a0a742fb094aff0e6d1a79fe0c3..8ad11023d91127e88900bc6bc=
abbaeafb1e00664 100644
> --- a/drivers/clk/mediatek/clk-pllfh.c
> +++ b/drivers/clk/mediatek/clk-pllfh.c
> @@ -10,6 +10,7 @@
>  #include <linux/slab.h>
>  #include <linux/clkdev.h>
>  #include <linux/delay.h>
> +#include <linux/device.h>

This shouldn't be needed, as you aren't using any of the APIs.

A forward declaration of |struct device| in the header should suffice.
It should be added anyway, since the header defines data structures that
have a |struct device *| field.


ChenYu


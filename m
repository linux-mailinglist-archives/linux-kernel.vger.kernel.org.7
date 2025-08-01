Return-Path: <linux-kernel+bounces-752998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 730B6B17D99
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DBF31C27F7A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 07:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96553204C07;
	Fri,  1 Aug 2025 07:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jZJpcpU4"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1301EB9EB
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 07:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754033468; cv=none; b=gKBVbrQtjQURocsbRMZBt+VidevYKre6xB7ZuQM4D7fpoQ+nrq6PSXPlMo1f1Bu8THPkrA/WOwRAFQ+s8VV7bTekJ65QacPEWHQJeEgaU6WAFwBoNsLm1ErXyF+rchfYRNim286GDWkkW8FOR7b+5OgPqIsDjddf0mxJEfAvluw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754033468; c=relaxed/simple;
	bh=nzHAzvndooAUlHdbUGqWPeN2rAYKeokoZYbDwjOskq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gtv94wBy6epdq/rAgiZrybBMLnQNhBtl3NYiOwoyTfMpJM1Glg+F7JWOA+0x8xx57X8dArZibVZyo+gPvaSos0oNHVvw7masn94Fm8csXboaEaYnpwaQ6m/H0S3USYrCpeyXWmZm4OMzMscmPUB4FrY3Ni0b6xrVCGupV8CZ0Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jZJpcpU4; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55b827aba01so576456e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 00:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754033465; x=1754638265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htF75GZq0w8gN2mFjIxAXyCVQ/hkCUtjFwdvPNYh4nE=;
        b=jZJpcpU4Gz5og0PVLcm+2nnc3UdBwGnV+pi6qpVfDtwLTdEi82QfZBlCuFEsGwPc1N
         IGaONEnvDGcpYiamtW3ubeYNxGqC7lI5wlGdtAIVYC0Ahz5R7sGYfqq3TmDKSJmoQepf
         Ol8V9McCGvxi9awJGXv7i59jil/qKmI+z/l7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754033465; x=1754638265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htF75GZq0w8gN2mFjIxAXyCVQ/hkCUtjFwdvPNYh4nE=;
        b=E4QGez6AhPznkh1Co+IKFUXYakhBvaZp/bzNuUHC97ofELI9GbkO67NV9c7d73jba5
         x7F3xEsliRJurUScrJDHP3PSpmlzz4sUIGsz/jPT8oNizazupk6dfWsSsxACbb8cser8
         uVeysJRoznMXsVKW6MeV/PNZd8jK9C/LDbmnGL5GjKmpAHlDV5QXEHEcAEiD1V3fTw4v
         saWU2gSFR650R0GjUDRvilDp8pOfAc4b8Jq/Dp4+ZYGpQVX+53XlvlhAR3Z4JzRe7TKL
         8IwiOODbnHekWVd6qeH2ZSeXsAvJb0tF1brrNSiKEUisWbT7L1eMgOqkrmbXAwjsxnN1
         O9QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUt4fWSbkx4P18iv2hRH5Os+CuQpF90JfXlI/9Fi0FCt5U/FJgfsdlFRM1iKXeaBmGkg7Op7b2+7qr/dM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXTWwbB8p4Rga0CZXEXWzvZjj87fgRx0BbjS2m8Luh0ntdpdEv
	Zs4i2BrO8kzokdh+LuYRdvxJLnw7ceeX9uoVyApKGNnXfs9x6Sei5gCv45qEajK1w7E6WC1DfCO
	CcSallHvIz9d8lFgkX+rPpFTa449EvzGQsJz/vYgo
X-Gm-Gg: ASbGncsskgEI19fhdr0EGHFlwcDs75tFvJ8IDJB9FYNWhWqX6X3F4sD3niOWRup3y3p
	Ii3DCY1T/at9qAQW8C2tG8zhY30FgpeWE0Xgw36+CqTQkIo5fBRNmgnT2lXYvPc1YJ7JN8uCLrH
	InxdXZ4UJ8Qz0H40RPwbbJg3NsXAV//rzb5F+Hzp2x11P3E57xDZVxQH+jkxJguKnSqcQnn6TNL
	G+1HhTup8SHez9VwxLN/DOcLUluK/FPNRE=
X-Google-Smtp-Source: AGHT+IGf+XWnJSS1ofdtRG4xXIiHJgHkwfLVUEtsoVjwZ6AcLoQT6SI+5n+wdM88xlKeQgIZ3eNKpD6h6k9lnfP4oTc=
X-Received: by 2002:a05:6512:3e17:b0:55a:32b7:6273 with SMTP id
 2adb3069b0e04-55b7c08a13amr3066799e87.39.1754033465235; Fri, 01 Aug 2025
 00:31:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801070913.3109-1-niklaus.liu@mediatek.com> <20250801070913.3109-4-niklaus.liu@mediatek.com>
In-Reply-To: <20250801070913.3109-4-niklaus.liu@mediatek.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 1 Aug 2025 15:30:53 +0800
X-Gm-Features: Ac12FXywJYCGCnChotG_esGvBZERmatIw20FKLlBH7Yl4ATPob-8dBgyN2iGj1M
Message-ID: <CAGXv+5ELHjc_egKVyNn4kqGfoj0jRxcmzP7H5VnE3dSv-YcERw@mail.gmail.com>
Subject: Re: [PATCH 3/3] regulator: Modify mt6315 regulator mode mask
To: "niklaus.liu" <niklaus.liu@mediatek.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Flora Fu <flora.fu@mediatek.com>, Alexandre Mergnat <amergnat@baylibre.com>, 
	Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 3:20=E2=80=AFPM niklaus.liu <niklaus.liu@mediatek.co=
m> wrote:
>
> Modify mt6315 regulator mode mask, compatible with all 6315 models
>
> Signed-off-by: niklaus.liu <niklaus.liu@mediatek.com>
> ---
>  drivers/regulator/mt6315-regulator.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/regulator/mt6315-regulator.c b/drivers/regulator/mt6=
315-regulator.c
> index 2608a6652d77..092ff748fe21 100644
> --- a/drivers/regulator/mt6315-regulator.c
> +++ b/drivers/regulator/mt6315-regulator.c
> @@ -218,8 +218,10 @@ static int mt6315_regulator_probe(struct spmi_device=
 *pdev)
>         struct regmap *regmap;
>         struct mt6315_chip *chip;
>         struct mt_regulator_init_data *init_data;
> +       struct device_node *node =3D pdev->dev.of_node;
>         struct regulator_config config =3D {};
>         struct regulator_dev *rdev;
> +       unsigned int val =3D 0;
>         int i;
>
>         regmap =3D devm_regmap_init_spmi_ext(pdev, &mt6315_regmap_config)=
;
> @@ -247,6 +249,10 @@ static int mt6315_regulator_probe(struct spmi_device=
 *pdev)
>                 init_data->modeset_mask[MT6315_VBUCK1] =3D BIT(MT6315_VBU=
CK1);
>                 break;
>         }
> +
> +       if (!of_property_read_u32(node, "buck1-modeset-mask", &val))
> +               init_data->modeset_mask[MT6315_VBUCK1] =3D val;
> +

This needs a matching change to the DT bindings.

However, please take a look at Angelo's recent series [1] for MT8196
PMICs that also adds variants of the MT6316 series regulators and how
it adds compatible strings for various parts to cover 2-phase, 3-phase,
and 4-phase settings.

Now personally I think a better way would be if we could somehow read back
a) the part number, or b) the multi-phase settings from the chip itself,
and derive `modeset_mask` automatically. Is that possible? Can MediaTek
share this information?


ChenYu

[1] https://lore.kernel.org/all/20250715140224.206329-1-angelogioacchino.de=
lregno@collabora.com/


>         for (i =3D MT6315_VBUCK2; i < MT6315_VBUCK_MAX; i++)
>                 init_data->modeset_mask[i] =3D BIT(i);
>
> --
> 2.46.0
>
>


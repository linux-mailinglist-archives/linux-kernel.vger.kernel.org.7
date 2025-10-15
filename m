Return-Path: <linux-kernel+bounces-853548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B9EBDBF31
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E35373B5062
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0374E2459E7;
	Wed, 15 Oct 2025 01:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RScvWVMS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7811A9F90
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760490253; cv=none; b=iT6lfHhBoDXmZF+BHQzK01oXZf4agvvaRNsP29Xp9KMxGAGlwFDRuG/UcwW22S7GsfcVuZUDkhoEjSkj6DRIpL5ggMNxGnf6mVGaAQuPQmr9GndpOY62vVbOhI81uH+AqkwGcYWpquxLmk8n3fGqQXW0Lqgy97um80rZ1OOWhig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760490253; c=relaxed/simple;
	bh=hsP+f9cKGhA88vButIz4+UBSyVEnqSK6E16OcnngsCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XUiACk4ii2KRIFxTpMg8jq0b+FbjgSfHA4Q6D30uwicW0OK9Tl6yyJlatpmnpevOQQvysjI51vBvSV3/olmD29+OhC6PrwejHLDe+GrcszWQEm944YcXKzYaWvAiBnjR127TAWbrgDTOfrzguY/YFE70VGJIOkxrLbJyNObpK6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RScvWVMS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDDFC113D0
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760490252;
	bh=hsP+f9cKGhA88vButIz4+UBSyVEnqSK6E16OcnngsCg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RScvWVMSY7LwI4DvLXrvKvCMUx+Pa0fQ9pfHrDJnU7cpom2caBFT6YqNg7BX0vP/r
	 Kk9QOORPmOp6h9fRkyYMYoGh7NS5bHztTUHtsgF643UwzC/UHSJdPhyMVKcQ6xlnEv
	 KqN2S5dkh76oSkrBZ4AtHZSjt1OmTOQkFnKTK+snQR7scNbb5VIL/oJSuOoBDZJ3UQ
	 +grCV5TOyjRx/SfHCIh9YwvHk/46zihKgNtKkRaxve3oQ0sVA549zTEUaiCkOYoz90
	 /kt8yz2B3Diy/LVSHMonak8PQIvAhvJpnfRP6z7laSuBKAyKz6lSqhE+woynmysvpQ
	 8pM/Jj9x+BScQ==
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e6674caa5so2241655e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 18:04:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWbT0N88dKuicezIsr/J33akxTV11x+JlzMpdzZLwWkKBx0kXqVUV+J+XCsQWg2tQZewyr8HrqpDsbqfaE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3QDdjF+youl5UyLXto0/iAUQxtrpocK03H+j6dyCfvb6AFykv
	sDQHmMgL6tIGOVfhmmojTmBsTXN3WYul++wvI7o6JM9uvx0rillYnV3aQTNC6zj2SaaRQnXDrXJ
	yikW6dcLfCyq4A3ZA47CaF+cpKK0KDNA=
X-Google-Smtp-Source: AGHT+IFSO4RoH0+0MmecaoWwkdhHUj1tFSX/MI8r9stNS3G36xBF5yBb2moTJwxkgO/lNRID4MrzmosTYGharRKmJds=
X-Received: by 2002:a7b:cc06:0:b0:46e:7dbf:6cc2 with SMTP id
 5b1f17b1804b1-46fa296e763mr154188005e9.8.1760490251277; Tue, 14 Oct 2025
 18:04:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014131032.49616-1-ziyao@disroot.org> <20251014131032.49616-4-ziyao@disroot.org>
In-Reply-To: <20251014131032.49616-4-ziyao@disroot.org>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 15 Oct 2025 09:03:59 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTdY+dhCH1BVVDaeqZxotxeu6q4NrurBK6Ro4oc3LWwcw@mail.gmail.com>
X-Gm-Features: AS18NWDLo0_MxIYOl-8Amf-z1eZpjh4scWWAn9vzIu7fB631vLox-a9ZNXNTSA0
Message-ID: <CAJF2gTTdY+dhCH1BVVDaeqZxotxeu6q4NrurBK6Ro4oc3LWwcw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] reset: th1520: Prepare for supporting multiple controllers
To: Yao Zi <ziyao@disroot.org>
Cc: Drew Fustini <fustini@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Icenowy Zheng <uwu@icenowy.me>, Han Gao <rabenda.cn@gmail.com>, Han Gao <gaohan@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yao,

On Tue, Oct 14, 2025 at 9:12=E2=80=AFPM Yao Zi <ziyao@disroot.org> wrote:
>
> TH1520 SoC is divided into several subsystems, shipping distinct reset
> controllers with similar control logic. Let's make reset signal mapping
> a data structure specific to one compatible to prepare for introduction
> of more reset controllers in the future.
Move th1520_resets to .priv data makes sense, LGTM.

Acked-by: Guo Ren <guoren@kernel.org>

>
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  drivers/reset/reset-th1520.c | 42 +++++++++++++++++++++++++-----------
>  1 file changed, 30 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/reset/reset-th1520.c b/drivers/reset/reset-th1520.c
> index 14d964a9c6b6..2b65a95ed021 100644
> --- a/drivers/reset/reset-th1520.c
> +++ b/drivers/reset/reset-th1520.c
> @@ -29,14 +29,20 @@
>  #define TH1520_HDMI_SW_MAIN_RST                BIT(0)
>  #define TH1520_HDMI_SW_PRST            BIT(1)
>
> +struct th1520_reset_map {
> +       u32 bit;
> +       u32 reg;
> +};
> +
>  struct th1520_reset_priv {
>         struct reset_controller_dev rcdev;
>         struct regmap *map;
> +       const struct th1520_reset_map *resets;
>  };
>
> -struct th1520_reset_map {
> -       u32 bit;
> -       u32 reg;
> +struct th1520_reset_data {
> +       const struct th1520_reset_map *resets;
> +       size_t num;
>  };
>
>  static const struct th1520_reset_map th1520_resets[] =3D {
> @@ -90,7 +96,7 @@ static int th1520_reset_assert(struct reset_controller_=
dev *rcdev,
>         struct th1520_reset_priv *priv =3D to_th1520_reset(rcdev);
>         const struct th1520_reset_map *reset;
>
> -       reset =3D &th1520_resets[id];
> +       reset =3D &priv->resets[id];
>
>         return regmap_update_bits(priv->map, reset->reg, reset->bit, 0);
>  }
> @@ -101,7 +107,7 @@ static int th1520_reset_deassert(struct reset_control=
ler_dev *rcdev,
>         struct th1520_reset_priv *priv =3D to_th1520_reset(rcdev);
>         const struct th1520_reset_map *reset;
>
> -       reset =3D &th1520_resets[id];
> +       reset =3D &priv->resets[id];
>
>         return regmap_update_bits(priv->map, reset->reg, reset->bit,
>                                   reset->bit);
> @@ -120,11 +126,14 @@ static const struct regmap_config th1520_reset_regm=
ap_config =3D {
>
>  static int th1520_reset_probe(struct platform_device *pdev)
>  {
> +       const struct th1520_reset_data *data;
>         struct device *dev =3D &pdev->dev;
>         struct th1520_reset_priv *priv;
>         void __iomem *base;
>         int ret;
>
> +       data =3D device_get_match_data(dev);
> +
>         priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>         if (!priv)
>                 return -ENOMEM;
> @@ -138,22 +147,31 @@ static int th1520_reset_probe(struct platform_devic=
e *pdev)
>         if (IS_ERR(priv->map))
>                 return PTR_ERR(priv->map);
>
> -       /* Initialize GPU resets to asserted state */
> -       ret =3D regmap_update_bits(priv->map, TH1520_GPU_RST_CFG,
> -                                TH1520_GPU_RST_CFG_MASK, 0);
> -       if (ret)
> -               return ret;
> +       if (of_device_is_compatible(dev->of_node, "thead,th1520-reset")) =
{
> +               /* Initialize GPU resets to asserted state */
> +               ret =3D regmap_update_bits(priv->map, TH1520_GPU_RST_CFG,
> +                                        TH1520_GPU_RST_CFG_MASK, 0);
> +               if (ret)
> +                       return ret;
> +       }
>
>         priv->rcdev.owner =3D THIS_MODULE;
> -       priv->rcdev.nr_resets =3D ARRAY_SIZE(th1520_resets);
> +       priv->rcdev.nr_resets =3D data->num;
>         priv->rcdev.ops =3D &th1520_reset_ops;
>         priv->rcdev.of_node =3D dev->of_node;
>
> +       priv->resets =3D data->resets;
> +
>         return devm_reset_controller_register(dev, &priv->rcdev);
>  }
>
> +static const struct th1520_reset_data th1520_reset_data =3D {
> +       .resets =3D th1520_resets,
> +       .num =3D ARRAY_SIZE(th1520_resets),
> +};
> +
>  static const struct of_device_id th1520_reset_match[] =3D {
> -       { .compatible =3D "thead,th1520-reset" },
> +       { .compatible =3D "thead,th1520-reset", .data =3D &th1520_reset_d=
ata },
>         { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, th1520_reset_match);
> --
> 2.50.1
>


--=20
Best Regards
 Guo Ren


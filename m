Return-Path: <linux-kernel+bounces-886911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A067FC36CEC
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA99A685421
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C02332ED1;
	Wed,  5 Nov 2025 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="B0MH5FsU"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562C030EF7C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359723; cv=none; b=nqrHBZVf7aad1T0VumP+VFkZ7Fh61j8wmJ7m0Y5ue9LVJKLFgAK47yQ1fr7abc6fpXeCsEomrp3z3g4SZv3tJsuVw8ogHjWSidwFnVDQJBznBz4O8mQPl2VFzPV7ot64bfvcqZZcGuEiXPsDWsvSdq5Z0TDJbbYFpem4vTuHnM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359723; c=relaxed/simple;
	bh=FmLX7J25rDa0sDpnK8PyjFiuLnrtWhbfdsiypYmH0H4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b3TkyGyFZFXIYyi7cuJg+b2vbQ/oGXpZE+GbmbwJ3OTocKhfnYEfduvkVfg1FcAq5EaQ+yhinVjZhKN3Zp3FgR4Hxf3CiRVjv/BSpTF7qvLdt8j9kXuWnMie7MD6oPaxhDYF1m3Vx9h3F9xIXZL18AgPxXxAeL9dn7gLfBGkn80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=B0MH5FsU; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3717780ea70so76570131fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762359718; x=1762964518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70ORLyPxlhnDgCvsyxrQcNXPF2cgzUwFaBuwCIGbTrg=;
        b=B0MH5FsU/ayGL8d3a7IwScLQvaU1EkTn5iXcfLpNJAJ6WFiALgxsuF0JboP2SQ+/89
         EQ8Dt7XbTnjrE8ODWcBwVAx/h21k+N2ZpVgFjeYq3CLy+8sARyurxU96x1fB2IzBArqS
         Or812YljRtWBtXyfa3C/rrpgFF+r0y5FMYq4+MUuASrMOofiDr+ZMQxDlaKQGaZqAx9t
         yjZDjbjL0fF4Gs4TSkUbRwfBC5QBUTXnNRG5GEZnOewba+7sAa+qzwUloMjM1PewlRiR
         t5+32XHylDFK2+st0ScqzUbo/WnQR+9oSJ3fgwX/t38rddmvzi3AVVtEQsHRKv96wrBd
         1gsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762359718; x=1762964518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=70ORLyPxlhnDgCvsyxrQcNXPF2cgzUwFaBuwCIGbTrg=;
        b=ouAXBJwggJLZEiUkZj+YK/WPHafmg07wq/5Hel/ka40JyXB5cr81SkY1O3/vFfXZlJ
         etVXaanN8e+Hg0liCJtlqFxJAnPYlDzu2kNSFdj+ktUuCg2BcR/3/V1z+IQZ0lkl1A4z
         99VizG+UTjqngWuBcD1yOP0U1NEOs7qckhJLLBl0bGfejGk5COPa3V9JGjSAPWWwCKV4
         pG+K5TGk4zvM8GRapvUHHzs/zCHY++ih11s3hb6jpanaS45rZqhqY26zCEq932VEsjOC
         3gqoG3hVymSOMd4skS1OimnQuLifVL8QsjdrKlUWSMAm6Mv4TTBX7yIpkajmjMjC6/xi
         dHAA==
X-Forwarded-Encrypted: i=1; AJvYcCXZ1w6KUnGcSBjw/5lgCPzvHbj1U8efpML8wKqV2veVJMrg3CuJ8b1dEv9yHms6a5aX+lTAHQsFb6m1sMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcwNZJ4qiBQmOCR989dsVDKlTOIrFz/HJy9pyco5kQOhcUCYC0
	mhqoMiOXu5lCSmgcsMKAZrjfGfHEweKEwewz993SGINRtwXs87dgSydj3cBEDUSUteXMkyYuARn
	RidkeUg2fm0Wruwec9aFHGjYGS2h5RvP38QL4J7NSOemrTSSfbLCKLVOm7ev5
X-Gm-Gg: ASbGncv1iuCU+YXwiu+Ep7Q2N0exkwzC2VlZI2ZyGG4rRkTo/PyEkHdVz1FNQrGCLmD
	C7LoZuYH7oW29EFK6yexnDdgOcXflKq4/O1gH5s+gaJha2+3Mxat/JINbFvQ+kV292QZySa+HWQ
	1sBAMZc1rtc207LfBG7YJmjMr4w7tJJlHmTJuu8JHACT45Aossg+9W4g6xnwJoXlhI9kKGFpY+K
	ZBu2Y0Ik0H7/yOMRO5zS+9qyvS38CagWg8y+HtRhmaBdFWh4wni8xmtjmYcUQ8/NXRF9HlDrEof
	qMWp+zuwQ6lybZ98Slhk2hYl5Do=
X-Google-Smtp-Source: AGHT+IGd9nOOO8Cu1iw6z8yTqdKaQ4LRnOY+7cfjhpscr/G2FIDhws1M/PZvAH1qCj7J40uiFyV1gKfF0cHDfmGqY00=
X-Received: by 2002:a2e:a015:0:b0:37a:3132:fe34 with SMTP id
 38308e7fff4ca-37a514a1d6bmr10033881fa.48.1762359718227; Wed, 05 Nov 2025
 08:21:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105-pci-m2-v1-0-84b5f1f1e5e8@oss.qualcomm.com> <20251105-pci-m2-v1-4-84b5f1f1e5e8@oss.qualcomm.com>
In-Reply-To: <20251105-pci-m2-v1-4-84b5f1f1e5e8@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 5 Nov 2025 17:21:46 +0100
X-Gm-Features: AWmQ_bniXnoc6lr9i63gxHMeq3DQpk_25xCcVxF2Y4yU4HxZNRN69fcND_aCeYc
Message-ID: <CAMRc=McB4Zk8WuSPL=7+7kX4RJbdFBNReWZyiFnH8vfVx3DxAg@mail.gmail.com>
Subject: Re: [PATCH 4/4] power: sequencing: Add the Power Sequencing driver
 for the PCIe M.2 connectors
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 10:17=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@oss.qualcomm.com> wrote:
>
> This driver is used to control the PCIe M.2 connectors of different
> Mechanical Keys attached to the host machines and supporting different
> interfaces like PCIe/SATA, USB/UART etc...
>
> Currently, this driver supports only the Mechanical Key M connectors with
> PCIe interface. The driver also only supports driving the mandatory 3.3v
> and optional 1.8v power supplies. The optional signals of the Key M
> connectors are not currently supported.
>

I'm assuming you followed some of the examples from the existing WCN
power sequencing driver. Not all of them are good or matching this
one, please see below.

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>
> ---
>  MAINTAINERS                               |   7 ++
>  drivers/power/sequencing/Kconfig          |   8 ++
>  drivers/power/sequencing/Makefile         |   1 +
>  drivers/power/sequencing/pwrseq-pcie-m2.c | 138 ++++++++++++++++++++++++=
++++++
>  4 files changed, 154 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 46126ce2f968e4f9260263f1574ee29f5ff0de1c..9b3f689d1f50c62afa3772a0c=
6802f99a98ac2de 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20474,6 +20474,13 @@ F:     Documentation/driver-api/pwrseq.rst
>  F:     drivers/power/sequencing/
>  F:     include/linux/pwrseq/
>
> +PCIE M.2 POWER SEQUENCING
> +M:     Manivannan Sadhasivam <mani@kernel.org>
> +L:     linux-pci@vger.kernel.org
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/connector/pcie-m2-m-connector.y=
aml
> +F:     drivers/power/sequencing/pwrseq-pcie-m2.c
> +
>  POWER STATE COORDINATION INTERFACE (PSCI)
>  M:     Mark Rutland <mark.rutland@arm.com>
>  M:     Lorenzo Pieralisi <lpieralisi@kernel.org>
> diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/=
Kconfig
> index 280f92beb5d0ed524e67a28d1c5dd264bbd6c87e..f5fff84566ba463b55d3cd0c0=
7db34c82f9f1e31 100644
> --- a/drivers/power/sequencing/Kconfig
> +++ b/drivers/power/sequencing/Kconfig
> @@ -35,4 +35,12 @@ config POWER_SEQUENCING_TH1520_GPU
>           GPU. This driver handles the complex clock and reset sequence
>           required to power on the Imagination BXM GPU on this platform.
>
> +config POWER_SEQUENCING_PCIE_M2
> +       tristate "PCIe M.2 connector power sequencing driver"
> +       depends on OF || COMPILE_TEST

The OF dependency in the WCN driver is there because we're doing some
phandle parsing and inspecting the parent-child relationships of the
associated nodes. It doesn't look like you need it here. On the other
hand, if you add more logic to the match() callback, this may come
into play.

> +       help
> +         Say Y here to enable the power sequencing driver for PCIe M.2
> +         connectors. This driver handles the power sequencing for the M.=
2
> +         connectors exposing multiple interfaces like PCIe, SATA, UART, =
etc...
> +
>  endif
> diff --git a/drivers/power/sequencing/Makefile b/drivers/power/sequencing=
/Makefile
> index 96c1cf0a98ac54c9c1d65a4bb4e34289a3550fa1..0911d461829897c5018e26dbe=
475b28f6fb6914c 100644
> --- a/drivers/power/sequencing/Makefile
> +++ b/drivers/power/sequencing/Makefile
> @@ -5,3 +5,4 @@ pwrseq-core-y                           :=3D core.o
>
>  obj-$(CONFIG_POWER_SEQUENCING_QCOM_WCN)        +=3D pwrseq-qcom-wcn.o
>  obj-$(CONFIG_POWER_SEQUENCING_TH1520_GPU) +=3D pwrseq-thead-gpu.o
> +obj-$(CONFIG_POWER_SEQUENCING_PCIE_M2) +=3D pwrseq-pcie-m2.o
> diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/se=
quencing/pwrseq-pcie-m2.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..b9f68ee9c5a377ce900a88de8=
6a3e269f9c99e51
> --- /dev/null
> +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com=
>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwrseq/provider.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +
> +struct pwrseq_pcie_m2_pdata {
> +       const struct pwrseq_target_data **targets;
> +};
> +
> +struct pwrseq_pcie_m2_ctx {
> +       struct pwrseq_device *pwrseq;
> +       const struct pwrseq_pcie_m2_pdata *pdata;
> +       struct regulator_bulk_data *regs;
> +       size_t num_vregs;
> +       struct notifier_block nb;
> +};
> +
> +static int pwrseq_pcie_m2_m_vregs_enable(struct pwrseq_device *pwrseq)
> +{
> +       struct pwrseq_pcie_m2_ctx *ctx =3D pwrseq_device_get_drvdata(pwrs=
eq);
> +
> +       return regulator_bulk_enable(ctx->num_vregs, ctx->regs);
> +}
> +
> +static int pwrseq_pcie_m2_m_vregs_disable(struct pwrseq_device *pwrseq)
> +{
> +       struct pwrseq_pcie_m2_ctx *ctx =3D pwrseq_device_get_drvdata(pwrs=
eq);
> +
> +       return regulator_bulk_disable(ctx->num_vregs, ctx->regs);
> +}
> +
> +static const struct pwrseq_unit_data pwrseq_pcie_m2_vregs_unit_data =3D =
{
> +       .name =3D "regulators-enable",
> +       .enable =3D pwrseq_pcie_m2_m_vregs_enable,
> +       .disable =3D pwrseq_pcie_m2_m_vregs_disable,
> +};
> +
> +static const struct pwrseq_unit_data *pwrseq_pcie_m2_m_unit_deps[] =3D {
> +       &pwrseq_pcie_m2_vregs_unit_data,
> +       NULL
> +};
> +
> +static const struct pwrseq_unit_data pwrseq_pcie_m2_m_pcie_unit_data =3D=
 {
> +       .name =3D "pcie-enable",
> +       .deps =3D pwrseq_pcie_m2_m_unit_deps,
> +};
> +
> +static const struct pwrseq_target_data pwrseq_pcie_m2_m_pcie_target_data=
 =3D {
> +       .name =3D "pcie",
> +       .unit =3D &pwrseq_pcie_m2_m_pcie_unit_data,
> +};
> +
> +static const struct pwrseq_target_data *pwrseq_pcie_m2_m_targets[] =3D {
> +       &pwrseq_pcie_m2_m_pcie_target_data,
> +       NULL
> +};
> +
> +static const struct pwrseq_pcie_m2_pdata pwrseq_pcie_m2_m_of_data =3D {
> +       .targets =3D pwrseq_pcie_m2_m_targets,
> +};
> +
> +static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
> +                                struct device *dev)
> +{
> +       return PWRSEQ_MATCH_OK;

Eek! That will match any device we check. I'm not sure this is what
you want. Looking at the binding example, I assume struct device *
here will be the endpoint? If so, you should resolve it and confirm
it's the one referenced from the connector node.

> +}
> +
> +static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct pwrseq_pcie_m2_ctx *ctx;
> +       struct pwrseq_config config;
> +       int ret;
> +
> +       ctx =3D devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +       if (!ctx)
> +               return -ENOMEM;
> +
> +       ctx->pdata =3D of_device_get_match_data(dev);

I should probably address it in the WCN driver - you don't need to use
the OF variant, use device_get_match_data().

> +       if (!ctx->pdata)
> +               return dev_err_probe(dev, -ENODEV,
> +                                    "Failed to obtain platform data\n");
> +
> +       ret =3D of_regulator_bulk_get_all(dev, dev_of_node(dev), &ctx->re=
gs);

Same here, you already have the device, no need to get the regulators
through the OF node. Just use devm_regulator_bulk_get()

> +       if (ret < 0)
> +               return dev_err_probe(dev, ret,
> +                                    "Failed to get all regulators\n");
> +
> +       ctx->num_vregs =3D ret;
> +
> +       memset(&config, 0, sizeof(config));

Just do config =3D { }; above?


> +
> +       config.parent =3D dev;
> +       config.owner =3D THIS_MODULE;
> +       config.drvdata =3D ctx;
> +       config.match =3D pwrseq_pcie_m2_match;
> +       config.targets =3D ctx->pdata->targets;
> +
> +       ctx->pwrseq =3D devm_pwrseq_device_register(dev, &config);
> +       if (IS_ERR(ctx->pwrseq))
> +               return dev_err_probe(dev, PTR_ERR(ctx->pwrseq),
> +                                    "Failed to register the power sequen=
cer\n");
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id pwrseq_pcie_m2_of_match[] =3D {
> +       {
> +               .compatible =3D "pcie-m2-m-connector",
> +               .data =3D &pwrseq_pcie_m2_m_of_data,
> +       },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, pwrseq_pcie_m2_of_match);
> +
> +static struct platform_driver pwrseq_pcie_m2_driver =3D {
> +       .driver =3D {
> +               .name =3D "pwrseq-pcie-m2",
> +               .of_match_table =3D pwrseq_pcie_m2_of_match,
> +       },
> +       .probe =3D pwrseq_pcie_m2_probe,
> +};
> +module_platform_driver(pwrseq_pcie_m2_driver);
> +
> +MODULE_AUTHOR("Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm=
.com>");
> +MODULE_DESCRIPTION("Power Sequencing driver for PCIe M.2 connector");
> +MODULE_LICENSE("GPL");
>
> --
> 2.48.1
>

Bartosz


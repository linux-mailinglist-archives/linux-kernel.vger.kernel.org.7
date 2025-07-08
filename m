Return-Path: <linux-kernel+bounces-720898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9747DAFC1D7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 06:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 390FB7AFFD3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 04:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A55F2192F9;
	Tue,  8 Jul 2025 04:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xwk6umjj"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826231E5705
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 04:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751950677; cv=none; b=DzjDRguI5wPdevjdb0Klg87m9ylCYpr7x/WGXf0TkfVEMPLsY65x6LaLTFpM5YpyZrJe7URQdGMyHWUbvm4DpcCGxHZOy4PTX47Qktwx0yzXtA41lAMfabbTMCmCzjjBuL/xCGdbeUtYtbwFgxwHWFujYlHd71EtFAfdUROWDDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751950677; c=relaxed/simple;
	bh=nwGhH6xhkLdjP9u4mplrlzeNjq7sGact2Xr7G5UTzrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJym6Vy4yWuMbU5pnkzWCbbwBRVXVJIHW3zTTC8FKPdrdDBM8akzya2Nmz3xcn9G3lENJ+JtZMxBHkac66jmXPw851alGyy05HWCoGcL7coMeVXRgJeujIoPcZY/W2GhU4Z72F9OmBi/ep/1rGnUne8vs73MJlyxDVZJBCCQNB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xwk6umjj; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5561ab55c4dso4137850e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 21:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751950673; x=1752555473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vr5j3HktXmdBuql9hRLpcA8htD63sRgEruV9zFxQJSk=;
        b=Xwk6umjjws3+OkDpI76uwIt6lnJKwGVOM/ZP4KtzghpNaoU77DsOwD+Y6cVIb2lys8
         Q0jwFMV49/IOySrJFtunbbNIasmqGjhSpXC9qktUNq6/T1iCqYQrWd4OU57vijxtOegG
         04ZsXdivfhmiadQoC1TceIQuxbs6wul/4fwM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751950673; x=1752555473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vr5j3HktXmdBuql9hRLpcA8htD63sRgEruV9zFxQJSk=;
        b=CqAEfIfGgfKKEHONhm6EoTmm1yO2PgrvTflLcb2TMGy0pYgz1yhs4NiqurDkSY11Wf
         Vd+RpNhtvAKyjLAUOoF0iisz6RLALXUgM0Qt4hdgf315pf2I3/+zERFm3c4N7gcqvZDc
         pbtvMRZQFL6/UuB0KR5ypMfBSHHnGp+4qBWg+humVtMzbSu9SvPMzKJw+0a7d+LWL8hl
         vdx5Skzxid549LfxKug/Q8vGT4dtGIgh15hW3e1lGrIir09Ac+/7StMukX4CbC6Un83k
         bWVELdaYBcLRIYi3XYp0Hr/zGSM24nldj598J5dQCpNk09PU2WeIzMW6Qi6XJIsd86wD
         fqAw==
X-Forwarded-Encrypted: i=1; AJvYcCVxXcyoFkgMEB7IGLQ4L6SxH9XpWgZS/fAQNlJEedafMyTUJvUXQzsz+CKl+caYETqDvPcvgBHo4Jz8zi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YznbMYkxcbPVZ0AZhdTvYGzRUruXHokc7IZbKLs6nSiZEESX5L0
	/xamYVIekcyCLgAeTqX8G6NmuKhOJjWeQKsy+ipdEdvEHMsqtDGCY8dyBTP50ptzHHYSPw3Quhk
	UzzdG8/T33PaYBdRuh0MG1JzdRe2PoXz0ZUH7tIe+
X-Gm-Gg: ASbGncvqJ2iO7atSxpwMkN1jMOTV8LCD0tikb1edlB9GT8UPqOdLEF0Pe5cRWk7vo5E
	tlZs20KeXgy3eK8Z/dSZ/kZIcKepDHI9+zSs+7BGbiyAOGPnDD2djTWn8kHpkzSqU0bgiJ4sq/s
	cr2yj9FH0Vz4NaED0OrjE6WKshCVhIYihOjXyVZU3hqkdfYEcnNGw1vGoCvrDoJlCa9lV29IU=
X-Google-Smtp-Source: AGHT+IGiKmRVVctKEN/87vc8xFNDgCG4gqbvI6NjBIPAZYuz9GsA3JMVpKP+W+7I3VmAlOaA1Oceumi0sItLoIdM0rg=
X-Received: by 2002:a05:6512:ad2:b0:553:a456:a0d4 with SMTP id
 2adb3069b0e04-557f830d866mr441986e87.15.1751950672522; Mon, 07 Jul 2025
 21:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707134451.154346-1-angelogioacchino.delregno@collabora.com> <20250707134451.154346-5-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250707134451.154346-5-angelogioacchino.delregno@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 8 Jul 2025 12:57:41 +0800
X-Gm-Features: Ac12FXxoiikXF1-TFEleSvh2qQAz2WaU9ADuyjClvcWDyJXjaLPqVQRaBRPRGBU
Message-ID: <CAGXv+5GbcyEEBaEhB1QY5uZ-CnKpvRgOYhqv==d72KXkVSSB3g@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] regulator: Add support for MediaTek MT6363 SPMI
 PMIC Regulators
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, lee@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	lgirdwood@gmail.com, broonie@kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 7, 2025 at 10:29=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add a driver for the regulators found on the MT6363 PMIC, fully
> controlled by SPMI interface.
> This PMIC regulates voltage with an input range of 2.6-5.0V, and
> features 10 buck converters and 26 LDOs.
>
> Link: https://lore.kernel.org/r/20250624073548.29732-5-angelogioacchino.d=
elregno@collabora.com
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/regulator/Kconfig                  |    9 +
>  drivers/regulator/Makefile                 |    1 +
>  drivers/regulator/mt6363-regulator.c       | 1076 ++++++++++++++++++++
>  include/linux/regulator/mt6363-regulator.h |  326 ++++++
>  4 files changed, 1412 insertions(+)
>  create mode 100644 drivers/regulator/mt6363-regulator.c
>  create mode 100644 include/linux/regulator/mt6363-regulator.h
>
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index 81f2acd0f960..d770e51f7ad1 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -936,6 +936,15 @@ config REGULATOR_MT6360
>           2-channel buck with Thermal Shutdown and Overload Protection
>           6-channel High PSRR and Low Dropout LDO.
>
> +config REGULATOR_MT6363
> +       tristate "MT6363 SPMI PMIC regulator driver"
> +       depends on SPMI || COMPILE_TEST
> +       help
> +          Say Y here to enable support for regulators found in the Media=
Tek
> +          MT6363 SPMI PMIC.
> +         This driver supports the control of different power rails of de=
vice
> +         through regulator interface.
> +
>  config REGULATOR_MT6370
>         tristate "MT6370 SubPMIC Regulator"
>         depends on MFD_MT6370
> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
> index 46c0e75f6107..41eaeac5547d 100644
> --- a/drivers/regulator/Makefile
> +++ b/drivers/regulator/Makefile
> @@ -111,6 +111,7 @@ obj-$(CONFIG_REGULATOR_MT6357)      +=3D mt6357-regul=
ator.o
>  obj-$(CONFIG_REGULATOR_MT6358) +=3D mt6358-regulator.o
>  obj-$(CONFIG_REGULATOR_MT6359) +=3D mt6359-regulator.o
>  obj-$(CONFIG_REGULATOR_MT6360) +=3D mt6360-regulator.o
> +obj-$(CONFIG_REGULATOR_MT6363) +=3D mt6363-regulator.o
>  obj-$(CONFIG_REGULATOR_MT6370) +=3D mt6370-regulator.o
>  obj-$(CONFIG_REGULATOR_MT6380) +=3D mt6380-regulator.o
>  obj-$(CONFIG_REGULATOR_MT6397) +=3D mt6397-regulator.o
> diff --git a/drivers/regulator/mt6363-regulator.c b/drivers/regulator/mt6=
363-regulator.c
> new file mode 100644
> index 000000000000..ea7d4e4f38cb
> --- /dev/null
> +++ b/drivers/regulator/mt6363-regulator.c
> @@ -0,0 +1,1076 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (c) 2024 MediaTek Inc.
> +// Copyright (c) 2025 Collabora Ltd
> +//                    AngeloGioacchino Del Regno <angelogioacchino.delre=
gno@collabora.com>
> +
> +#include <linux/delay.h>
> +#include <linux/devm-helpers.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/regulator/mt6363-regulator.h>
> +#include <linux/regulator/of_regulator.h>
> +
> +#define MT6363_REGULATOR_MODE_NORMAL   0
> +#define MT6363_REGULATOR_MODE_FCCM     1
> +#define MT6363_REGULATOR_MODE_LP       2
> +#define MT6363_REGULATOR_MODE_ULP      3
> +
> +#define EN_SET_OFFSET  0x1
> +#define EN_CLR_OFFSET  0x2
> +#define OP_CFG_OFFSET  0x5
> +
> +#define NORMAL_OP_CFG  0x10
> +#define NORMAL_OP_EN   0x800000
> +
> +#define OC_IRQ_ENABLE_DELAY_MS         10
> +
> +/* Unlock keys for TMA and BUCK_TOP */
> +#define MT6363_TMA_UNLOCK_VALUE                0x9c9c
> +#define MT6363_BUCK_TOP_UNLOCK_VALUE   0x5543
> +
> +#define MT6363_RG_BUCK_EFUSE_RSV1      0x1447
> +#define MT6363_RG_BUCK_EFUSE_RSV1_MASK GENMASK(7, 4)
> +
> +enum {
> +       MT6363_ID_VS2,
> +       MT6363_ID_VBUCK1,
> +       MT6363_ID_VBUCK2,
> +       MT6363_ID_VBUCK3,
> +       MT6363_ID_VBUCK4,
> +       MT6363_ID_VBUCK5,
> +       MT6363_ID_VBUCK6,
> +       MT6363_ID_VBUCK7,
> +       MT6363_ID_VS1,
> +       MT6363_ID_VS3,

This ordering is a bit weird. Is there any particular reason for this?
Order of the registers perhaps?

> +       MT6363_ID_VBUCK1_SSHUB,
> +       MT6363_ID_VBUCK2_SSHUB,
> +       MT6363_ID_VBUCK4_SSHUB,
> +       MT6363_ID_VSRAM_DIGRF,
> +       MT6363_ID_VSRAM_MDFE,
> +       MT6363_ID_VSRAM_MODEM,
> +       MT6363_ID_VSRAM_CPUB,
> +       MT6363_ID_VSRAM_CPUM,
> +       MT6363_ID_VSRAM_CPUL,
> +       MT6363_ID_VSRAM_APU,
> +       MT6363_ID_VEMC,
> +       MT6363_ID_VCN13,
> +       MT6363_ID_VTREF18,
> +       MT6363_ID_VAUX18,
> +       MT6363_ID_VCN15,
> +       MT6363_ID_VUFS18,
> +       MT6363_ID_VIO18,
> +       MT6363_ID_VM18,
> +       MT6363_ID_VA15,
> +       MT6363_ID_VRF18,
> +       MT6363_ID_VRFIO18,
> +       MT6363_ID_VIO075,
> +       MT6363_ID_VUFS12,
> +       MT6363_ID_VA12_1,
> +       MT6363_ID_VA12_2,
> +       MT6363_ID_VRF12,
> +       MT6363_ID_VRF13,
> +       MT6363_ID_VRF09,
> +       MT6363_ID_ISINK_LOAD
> +};
> +

[...]

> +#define MT6363_LDO_LINEAR_OPS(match, vreg, vops, min, max, step,       \
> +                             en_reg, en_bit, vs_reg, vs_mask,          \
> +                             lp_reg, lp_bit)                           \
> +[MT6363_ID_##vreg] =3D {                                                =
 \
> +       .desc =3D {                                                      =
 \
> +               .name =3D match,                                         =
 \
> +               .of_match =3D of_match_ptr(match),                       =
 \
> +               .ops =3D &vops,                                          =
 \
> +               .type =3D REGULATOR_VOLTAGE,                             =
 \
> +               .id =3D MT6363_ID_##vreg,                                =
 \
> +               .owner =3D THIS_MODULE,                                  =
 \
> +               .n_voltages =3D (max - min) / step + 1,                  =
 \
> +               .min_uV =3D min,                                         =
 \
> +               .uV_step =3D step,                                       =
 \
> +               .enable_reg =3D en_reg,                                  =
 \
> +               .enable_mask =3D BIT(en_bit),                            =
 \
> +               .vsel_reg =3D vs_reg,                                    =
 \
> +               .vsel_mask =3D vs_mask,                                  =
 \
> +               .of_map_mode =3D mt6363_map_mode,                        =
 \
> +       },                                                              \
> +       .lp_mode_reg =3D lp_reg,                                         =
 \
> +       .lp_mode_mask =3D BIT(lp_bit),                                   =
 \
> +       .hw_lp_mode_reg =3D MT6363_LDO_##vreg##_HW_LP_MODE,              =
 \
> +       .hw_lp_mode_mask =3D 0x4,                                        =
 \
> +}

Some of the LDOs have an extra "calibration" setting that can tweak
the output in 0.01V intervals. Could we support that. At least for
VRF12, VRF13, VRF18, the default is an extra 0.04V. It would be
misleading for the DT to specify 1.8V while the regulator is actually
outputting 1.84V.

You could look at the MT6358 driver to see how I implemented it.

[...]

> +static irqreturn_t mt6363_oc_isr(int irq, void *data)
> +{
> +       struct regulator_dev *rdev =3D (struct regulator_dev *)data;
> +       struct mt6363_regulator_info *info =3D rdev_get_drvdata(rdev);
> +
> +       disable_irq_nosync(info->irq);
> +
> +       if (regulator_is_enabled_regmap(rdev))
> +               regulator_notifier_call_chain(rdev, REGULATOR_EVENT_OVER_=
CURRENT, NULL);
> +
> +       schedule_delayed_work(&info->oc_work, msecs_to_jiffies(OC_IRQ_ENA=
BLE_DELAY_MS));

Is this needed for debouncing?

> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int mt6363_set_ocp(struct regulator_dev *rdev, int lim, int sever=
ity, bool enable)
> +{
> +       struct mt6363_regulator_info *info =3D rdev_get_drvdata(rdev);
> +
> +       /* MT6363 supports only enabling protection and does not support =
limits */
> +       if (lim || severity !=3D REGULATOR_SEVERITY_PROT || !enable)
> +               return -EINVAL;
> +
> +       /* If there is no OCP interrupt, there's nothing to set */
> +       if (info->irq <=3D 0)
> +               return -EINVAL;

-EOPNOTSUPP instead? One gives an error while the other gives a warning.

> +
> +       return devm_request_threaded_irq(&rdev->dev, info->irq, NULL,
> +                                        mt6363_oc_isr, IRQF_ONESHOT,
> +                                        info->desc.name, rdev);
> +}
> +

[...]

> +/* The array is indexed by id(MT6363_ID_XXX) */
> +static struct mt6363_regulator_info mt6363_regulators[] =3D {
> +       MT6363_BUCK("buck-vs2", VS2, 0, 1600000, 12500,
> +                   MT6363_RG_BUCK0_EN_ADDR,
> +                   MT6363_RG_BUCK_VS2_EN_BIT,
> +                   MT6363_RG_BUCK_VS2_VOSEL_ADDR,
> +                   MT6363_RG_BUCK_VS2_VOSEL_MASK,
> +                   MT6363_RG_BUCK0_LP_ADDR,
> +                   MT6363_RG_BUCK_VS2_LP_BIT,
> +                   MT6363_RG_BUCK0_FCCM_ADDR,
> +                   MT6363_RG_VS2_FCCM_BIT),

All this doesn't need to be spelled out. Perhaps you could use some
preprocessor magic to assemble all the register names so that the
entry could be simplified to just

        MT6363_BUCK("buck-vs2", VS2, 0, 1600000, 12500,
MT6363_RG_BUCK0_FCCM_ADDR),

[...]

> +       MT6363_SSHUB("buck-sshub1", VBUCK1_SSHUB, 0, 1193750, 6250,
> +                    MT6363_RG_BUCK_VBUCK1_SSHUB_EN_ADDR,
> +                    MT6363_RG_BUCK_VBUCK1_SSHUB_VOSEL_ADDR,
> +                    MT6363_RG_BUCK_VBUCK1_SSHUB_VOSEL_MASK),
> +       MT6363_SSHUB("buck-sshub2", VBUCK2_SSHUB, 0, 1193750, 6250,
> +                    MT6363_RG_BUCK_VBUCK2_SSHUB_EN_ADDR,
> +                    MT6363_RG_BUCK_VBUCK2_SSHUB_VOSEL_ADDR,
> +                    MT6363_RG_BUCK_VBUCK2_SSHUB_VOSEL_MASK),
> +       MT6363_SSHUB("buck-sshub4", VBUCK4_SSHUB, 0, 1193750, 6250,
> +                    MT6363_RG_BUCK_VBUCK4_SSHUB_EN_ADDR,
> +                    MT6363_RG_BUCK_VBUCK4_SSHUB_VOSEL_ADDR,
> +                    MT6363_RG_BUCK_VBUCK4_SSHUB_VOSEL_MASK),

As mentioned in my reply to the binding patch, these aren't real regulators=
.

> +       MT6363_LDO_L_SC("ldo-vsram-digrf", VSRAM_DIGRF, 400000, 1193750, =
6250,
> +                       MT6363_RG_BUCK1_EN_ADDR,
> +                       MT6363_RG_LDO_VSRAM_DIGRF_EN_BIT,
> +                       MT6363_RG_LDO_VSRAM_DIGRF_VOSEL_ADDR,
> +                       MT6363_RG_LDO_VSRAM_DIGRF_VOSEL_MASK,
> +                       MT6363_RG_BUCK1_LP_ADDR,
> +                       MT6363_RG_LDO_VSRAM_DIGRF_LP_BIT),

Same here, these could be compressed smaller with some preprocessor magic.

[...]

ChenYu


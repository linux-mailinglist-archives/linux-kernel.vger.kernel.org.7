Return-Path: <linux-kernel+bounces-731937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCF3B05E11
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA413B7FD6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151F72E8DF2;
	Tue, 15 Jul 2025 13:37:19 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5879B1B4231
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586638; cv=none; b=QiElUvkMGKwJRt+/CL93m+s3QG321h0yxU3BeCYwiEl51lflDAQHq3XZKkbK4ashhe/qk21Yexh2EffdIIF2InGVQiTVfVLZmHGlak6FxzLPxTXrTD2Tjp56IiDH6WSoKY9+Oa+K1W2q6cvb77sfA1xs9/bZuqcm5BWPk1KxRxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586638; c=relaxed/simple;
	bh=ntXQqV4wWwLrySk9XkfXcxliMWY+qjCh/d8rjgZTXEY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fwMDjIMy156FG51m/3lU7RRf/9zOuCPS7iZAHTUsoGNqzl12HTRgERetylbJkIyzJgNb5GL6dy3tDMxuN9TU3VKBJ79U9Jd30B72sYg21bAMHZkDMYl51Y9LB5hgtLjwunBhOIVrd/7ZYyrE5QbBEdaxQO8XdtsS6xsyBL35ty0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1ubfqB-00018b-Q2; Tue, 15 Jul 2025 15:37:03 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1ubfqA-008aVC-0t;
	Tue, 15 Jul 2025 15:37:02 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1ubfqA-000LW6-0c;
	Tue, 15 Jul 2025 15:37:02 +0200
Message-ID: <91f8e6f6a4b47204bf6a4915b802f86fa3f42afe.camel@pengutronix.de>
Subject: Re: [PATCH v4 2/2] reset: eswin: Add eic7700 reset driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: dongxuyang@eswincomputing.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com, 
	huangyifeng@eswincomputing.com, pinkesh.vaghela@einfochips.com
Date: Tue, 15 Jul 2025 15:37:02 +0200
In-Reply-To: <20250715121547.1579-1-dongxuyang@eswincomputing.com>
References: <20250715121427.1466-1-dongxuyang@eswincomputing.com>
	 <20250715121547.1579-1-dongxuyang@eswincomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Di, 2025-07-15 at 20:15 +0800, dongxuyang@eswincomputing.com wrote:
> From: Xuyang Dong <dongxuyang@eswincomputing.com>
>=20
> Add support for reset controller in eic7700 series chips.
> Provide functionality for asserting and deasserting resets
> on the chip.
>=20
> Signed-off-by: Yifeng Huang <huangyifeng@eswincomputing.com>
> Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>
> ---
>  drivers/reset/Kconfig         |  10 +
>  drivers/reset/Makefile        |   1 +
>  drivers/reset/reset-eic7700.c | 454 ++++++++++++++++++++++++++++++++++
>  3 files changed, 465 insertions(+)
>  create mode 100644 drivers/reset/reset-eic7700.c
>=20
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index d85be5899da6..82f829f4c9f0 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -66,6 +66,16 @@ config RESET_BRCMSTB_RESCAL
>  	  This enables the RESCAL reset controller for SATA, PCIe0, or PCIe1 on
>  	  BCM7216.
> =20
> +config RESET_EIC7700
> +	bool "Reset controller driver for ESWIN SoCs"
> +	depends on ARCH_ESWIN || COMPILE_TEST
> +	default ARCH_ESWIN
> +	help
> +	  This enables the reset controller driver for ESWIN SoCs. This driver =
is
> +	  specific to ESWIN SoCs and should only be enabled if using such hardw=
are.
> +	  The driver supports eic7700 series chips and provides functionality f=
or
> +	  asserting and deasserting resets on the chip.
> +
>  config RESET_EYEQ
>  	bool "Mobileye EyeQ reset controller"
>  	depends on MACH_EYEQ5 || MACH_EYEQ6H || COMPILE_TEST
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 91e6348e3351..ceafbad0555c 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_RESET_BCM6345) +=3D reset-bcm6345.o
>  obj-$(CONFIG_RESET_BERLIN) +=3D reset-berlin.o
>  obj-$(CONFIG_RESET_BRCMSTB) +=3D reset-brcmstb.o
>  obj-$(CONFIG_RESET_BRCMSTB_RESCAL) +=3D reset-brcmstb-rescal.o
> +obj-$(CONFIG_RESET_EIC7700) +=3D reset-eic7700.o
>  obj-$(CONFIG_RESET_EYEQ) +=3D reset-eyeq.o
>  obj-$(CONFIG_RESET_GPIO) +=3D reset-gpio.o
>  obj-$(CONFIG_RESET_HSDK) +=3D reset-hsdk.o
> diff --git a/drivers/reset/reset-eic7700.c b/drivers/reset/reset-eic7700.=
c
> new file mode 100644
> index 000000000000..1acc531343b0
> --- /dev/null
> +++ b/drivers/reset/reset-eic7700.c
> @@ -0,0 +1,454 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2025, Beijing ESWIN Computing Technology Co., Ltd..
> + * All rights reserved.
> + *
> + * ESWIN Reset Driver
> + *
> + * Authors:
> + *	Yifeng Huang <huangyifeng@eswincomputing.com>
> + *	Xuyang Dong <dongxuyang@eswincomputing.com>
> + */
> +
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset-controller.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +#include <dt-bindings/reset/eswin,eic7700-reset.h>
> +
> +#define SYSCRG_CLEAR_BOOT_INFO_OFFSET 0x30C
> +#define CLEAR_BOOT_FLAG_BIT BIT(0)
> +#define SYSCRG_RESET_OFFSET 0x400
> +
> +/**
> + * struct eswin_reset_data - reset controller information structure
> + * @rcdev: reset controller entity
> + * @regmap: regmap handle containing the memory-mapped reset registers
> + */
> +struct eswin_reset_data {
> +	struct reset_controller_dev rcdev;
> +	struct regmap *regmap;
> +};
> +
> +static const struct regmap_config eswin_regmap_config =3D {
> +	.reg_bits =3D 32,
> +	.val_bits =3D 32,
> +	.max_register =3D 0x8000000,

That doesn't look correct. According to the device tree example, the
register space is only 0x80000 bytes. This should be the address offset
of the last valid register, so I'd expect at most 0x7fffc.

> +};
> +
> +struct eic7700_reg {
> +	u32 reg;
> +	u32 bit;
> +};
> +
> +#define to_eswin_reset_data(p) container_of((p), struct eswin_reset_data=
, rcdev)

Please make this an inline function.

> +
> +#define EIC7700_RESET_OFFSET(id, reg, bit)[id] =3D \
> +		{ SYSCRG_RESET_OFFSET + (reg) * sizeof(u32), BIT(bit) }

I suggest calling this macro EIC7700_RESET().
It's shorter and the "bit" field is not an offset.

> +
> +/* mapping table for reset ID to register offset */
> +static const struct eic7700_reg eic7700_register_offset[] =3D {

You could make this eic7700_register_offset[EIC7700_RESET_MAX].

Same as above, there might be a better name than _register_offset.
How about eic7700_resets[]?

> +	EIC7700_RESET_OFFSET(EIC7700_RESET_NOC_NSP, 0, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_NOC_CFG, 0, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_RNOC_NSP, 0, 2),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_SNOC_TCU, 0, 3),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_SNOC_U84, 0, 4),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_SNOC_PCIE_XSR, 0, 5),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_SNOC_PCIE_XMR, 0, 6),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_SNOC_PCIE_PR, 0, 7),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_SNOC_NPU, 0, 8),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_SNOC_JTAG, 0, 9),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_SNOC_DSP, 0, 10),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_SNOC_DDRC1_P2, 0, 11),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_SNOC_DDRC1_P1, 0, 12),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_SNOC_DDRC0_P2, 0, 13),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_SNOC_DDRC0_P1, 0, 14),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_SNOC_D2D, 0, 15),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_SNOC_AON, 0, 16),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_GPU_AXI, 1, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_GPU_CFG, 1, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_GPU_GRAY, 1, 2),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_GPU_JONES, 1, 3),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_GPU_SPU, 1, 4),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_DSP_AXI, 2, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_DSP_CFG, 2, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_DSP_DIV4, 2, 2),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_DSP_DIV0, 2, 4),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_DSP_DIV1, 2, 5),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_DSP_DIV2, 2, 6),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_DSP_DIV3, 2, 7),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_D2D_AXI, 3, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_D2D_CFG, 3, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_D2D_PRST, 3, 2),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_D2D_RAW_PCS, 3, 4),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_D2D_RX, 3, 5),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_D2D_TX, 3, 6),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_D2D_CORE, 3, 7),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_DDR1_ARST, 4, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_DDR1_TRACE, 4, 6),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_DDR0_ARST, 4, 16),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_DDR_CFG, 4, 21),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_DDR0_TRACE, 4, 22),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_DDR_CORE, 4, 23),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_DDR_PRST, 4, 26),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TCU_AXI, 5, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TCU_CFG, 5, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TCU_TBU0, 5, 4),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TCU_TBU1, 5, 5),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TCU_TBU2, 5, 6),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TCU_TBU3, 5, 7),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TCU_TBU4, 5, 8),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TCU_TBU5, 5, 9),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TCU_TBU6, 5, 10),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TCU_TBU7, 5, 11),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TCU_TBU8, 5, 12),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TCU_TBU9, 5, 13),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TCU_TBU10, 5, 14),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TCU_TBU11, 5, 15),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TCU_TBU12, 5, 16),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TCU_TBU13, 5, 17),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TCU_TBU14, 5, 18),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TCU_TBU15, 5, 19),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TCU_TBU16, 5, 20),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_NPU_AXI, 6, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_NPU_CFG, 6, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_NPU_CORE, 6, 2),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_NPU_E31CORE, 6, 3),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_NPU_E31BUS, 6, 4),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_NPU_E31DBG, 6, 5),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_NPU_LLC, 6, 6),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_HSP_AXI, 7, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_HSP_CFG, 7, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_HSP_POR, 7, 2),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_MSHC0_PHY, 7, 3),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_MSHC1_PHY, 7, 4),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_MSHC2_PHY, 7, 5),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_MSHC0_TXRX, 7, 6),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_MSHC1_TXRX, 7, 7),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_MSHC2_TXRX, 7, 8),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_SATA_ASIC0, 7, 9),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_SATA_OOB, 7, 10),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_SATA_PMALIVE, 7, 11),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_SATA_RBC, 7, 12),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_DMA0, 7, 13),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_HSP_DMA, 7, 14),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_USB0_VAUX, 7, 15),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_USB1_VAUX, 7, 16),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_HSP_SD1_PRST, 7, 17),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_HSP_SD0_PRST, 7, 18),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_HSP_EMMC_PRST, 7, 19),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_HSP_DMA_PRST, 7, 20),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_HSP_SD1_ARST, 7, 21),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_HSP_SD0_ARST, 7, 22),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_HSP_EMMC_ARST, 7, 23),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_HSP_DMA_ARST, 7, 24),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_HSP_ETH1_ARST, 7, 25),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_HSP_ETH0_ARST, 7, 26),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_SATA_ARST, 7, 27),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_PCIE_CFG, 8, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_PCIE_POWEUP, 8, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_PCIE_PERST, 8, 2),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_I2C0, 9, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_I2C1, 9, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_I2C2, 9, 2),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_I2C3, 9, 3),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_I2C4, 9, 4),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_I2C5, 9, 5),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_I2C6, 9, 6),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_I2C7, 9, 7),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_I2C8, 9, 8),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_I2C9, 9, 9),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_FAN, 10, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_PVT0, 11, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_PVT1, 11, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_MBOX0, 12, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_MBOX1, 12, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_MBOX2, 12, 2),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_MBOX3, 12, 3),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_MBOX4, 12, 4),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_MBOX5, 12, 5),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_MBOX6, 12, 6),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_MBOX7, 12, 7),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_MBOX8, 12, 8),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_MBOX9, 12, 9),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_MBOX10, 12, 10),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_MBOX11, 12, 11),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_MBOX12, 12, 12),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_MBOX13, 12, 13),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_MBOX14, 12, 14),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_MBOX15, 12, 15),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_UART0, 13, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_UART1, 13, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_UART2, 13, 2),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_UART3, 13, 3),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_UART4, 13, 4),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_GPIO0, 14, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_GPIO1, 14, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER, 15, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_SSI0, 16, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_SSI1, 16, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_WDT0, 17, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_WDT1, 17, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_WDT2, 17, 2),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_WDT3, 17, 3),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_LSP_CFG, 18, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_U84_CORE0, 19, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_U84_CORE1, 19, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_U84_CORE2, 19, 2),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_U84_CORE3, 19, 3),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_U84_BUS, 19, 4),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_U84_DBG, 19, 5),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_U84_TRACECOM, 19, 6),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_U84_TRACE0, 19, 8),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_U84_TRACE1, 19, 9),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_U84_TRACE2, 19, 10),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_U84_TRACE3, 19, 11),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_SCPU_CORE, 20, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_SCPU_BUS, 20, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_SCPU_DBG, 20, 2),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_LPCPU_CORE, 21, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_LPCPU_BUS, 21, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_LPCPU_DBG, 21, 2),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_VC_CFG, 22, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_VC_AXI, 22, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_VC_MONCFG, 22, 2),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_JD_CFG, 23, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_JD_AXI, 23, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_JE_CFG, 24, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_JE_AXI, 24, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_VD_CFG, 25, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_VD_AXI, 25, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_VE_AXI, 26, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_VE_CFG, 26, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_G2D_CORE, 27, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_G2D_CFG, 27, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_G2D_AXI, 27, 2),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_VI_AXI, 28, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_VI_CFG, 28, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_VI_DWE, 28, 2),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_DVP, 29, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_ISP0, 30, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_ISP1, 31, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_SHUTTR0, 32, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_SHUTTR1, 32, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_SHUTTR2, 32, 2),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_SHUTTR3, 32, 3),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_SHUTTR4, 32, 4),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_SHUTTR5, 32, 5),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_VO_MIPI, 33, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_VO_PRST, 33, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_VO_HDMI_PRST, 33, 3),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_VO_HDMI_PHY, 33, 4),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_VO_HDMI, 33, 5),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_VO_I2S, 34, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_VO_I2S_PRST, 34, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_VO_AXI, 35, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_VO_CFG, 35, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_VO_DC, 35, 2),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_VO_DC_PRST, 35, 3),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_BOOTSPI_HRST, 36, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_BOOTSPI, 36, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_ANO1, 37, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_ANO0, 38, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_DMA1_ARST, 39, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_DMA1_HRST, 39, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_FPRT, 40, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_HBLOCK, 41, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_SECSR, 42, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_OTP, 43, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_PKA, 44, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_SPACC, 45, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TRNG, 46, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER0_0, 48, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER0_1, 48, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER0_2, 48, 2),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER0_3, 48, 3),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER0_4, 48, 4),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER0_5, 48, 5),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER0_6, 48, 6),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER0_7, 48, 7),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER0_N, 48, 8),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER1_0, 49, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER1_1, 49, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER1_2, 49, 2),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER1_3, 49, 3),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER1_4, 49, 4),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER1_5, 49, 5),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER1_6, 49, 6),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER1_7, 49, 7),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER1_N, 49, 8),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER2_0, 50, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER2_1, 50, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER2_2, 50, 2),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER2_3, 50, 3),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER2_4, 50, 4),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER2_5, 50, 5),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER2_6, 50, 6),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER2_7, 50, 7),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER2_N, 50, 8),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER3_0, 51, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER3_1, 51, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER3_2, 51, 2),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER3_3, 51, 3),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER3_4, 51, 4),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER3_5, 51, 5),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER3_6, 51, 6),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER3_7, 51, 7),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_TIMER3_N, 51, 8),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_RTC, 52, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_MNOC_SNOC_NSP, 53, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_MNOC_VC, 53, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_MNOC_CFG, 53, 2),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_MNOC_HSP, 53, 3),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_MNOC_GPU, 53, 4),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_MNOC_DDRC1_P3, 53, 5),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_MNOC_DDRC0_P3, 53, 6),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_RNOC_VO, 54, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_RNOC_VI, 54, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_RNOC_SNOC_NSP, 54, 2),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_RNOC_CFG, 54, 3),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_MNOC_DDRC1_P4, 54, 4),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_MNOC_DDRC0_P4, 54, 5),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_CNOC_VO_CFG, 55, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_CNOC_VI_CFG, 55, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_CNOC_VC_CFG, 55, 2),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_CNOC_TCU_CFG, 55, 3),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_CNOC_PCIE_CFG, 55, 4),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_CNOC_NPU_CFG, 55, 5),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_CNOC_LSP_CFG, 55, 6),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_CNOC_HSP_CFG, 55, 7),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_CNOC_GPU_CFG, 55, 8),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_CNOC_DSPT_CFG, 55, 9),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_CNOC_DDRT1_CFG, 55, 10),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_CNOC_DDRT0_CFG, 55, 11),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_CNOC_D2D_CFG, 55, 12),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_CNOC_CFG, 55, 13),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_CNOC_CLMM_CFG, 55, 14),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_CNOC_AON_CFG, 55, 15),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_LNOC_CFG, 56, 0),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_LNOC_NPU_LLC, 56, 1),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_LNOC_DDRC1_P0, 56, 2),
> +	EIC7700_RESET_OFFSET(EIC7700_RESET_LNOC_DDRC0_P0, 56, 3),
> +};
> +
> +/**
> + * eswin_reset_set() - program a device's reset
> + * @rcdev: reset controller entity
> + * @id: ID of the reset to toggle
> + * @assert: boolean flag to indicate assert or deassert
> + *
> + * This is a common internal function used to assert or deassert a devic=
e's
> + * reset by clear and set the reset bit. The device's reset is asserted =
if the
> + * @assert argument is true, or deasserted if @assert argument is false.
> + *
> + * Return: 0 for successful request, else a corresponding error value
> + */
> +static int eswin_reset_set(struct reset_controller_dev *rcdev, unsigned =
long id,
> +			   bool assert)
> +{
> +	struct eswin_reset_data *data =3D to_eswin_reset_data(rcdev);
> +	int ret;
> +
> +	if (assert)
> +		ret =3D regmap_clear_bits(data->regmap,
> +					eic7700_register_offset[id].reg,
> +					eic7700_register_offset[id].bit);
> +	else
> +		ret =3D regmap_set_bits(data->regmap,
> +				      eic7700_register_offset[id].reg,
> +				      eic7700_register_offset[id].bit);
> +
> +	return ret;
> +}

Please just fold this into the eswin_reset_assert/deassert() functions.
There is no need to have a common helper function where the only common
line of code is the data variable assignment.

> +
> +static int eswin_reset_assert(struct reset_controller_dev *rcdev,
> +			      unsigned long id)
> +{
> +	return eswin_reset_set(rcdev, id, true);
> +}
> +
> +static int eswin_reset_deassert(struct reset_controller_dev *rcdev,
> +				unsigned long id)
> +{
> +	return eswin_reset_set(rcdev, id, false);
> +}
> +
> +static int eswin_reset_reset(struct reset_controller_dev *rcdev,
> +			     unsigned long id)
> +{
> +	int ret;
> +
> +	ret =3D eswin_reset_assert(rcdev, id);
> +	if (ret)
> +		return ret;

Does this work without delay for every IP core contained in this SoC?

> +	return eswin_reset_deassert(rcdev, id);
> +}
> +
> +static const struct reset_control_ops eswin_reset_ops =3D {
> +	.reset =3D eswin_reset_reset,
> +	.assert =3D eswin_reset_assert,
> +	.deassert =3D eswin_reset_deassert,
> +};
> +
> +static const struct of_device_id eswin_reset_dt_ids[] =3D {
> +	{
> +		.compatible =3D "eswin,eic7700-reset",
> +	},
> +	{ /* sentinel */ }
> +};
> +
> +static int eswin_reset_probe(struct platform_device *pdev)
> +{
> +	struct eswin_reset_data *data;
> +	struct device *dev =3D &pdev->dev;
> +	void __iomem *base;
> +
> +	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	data->regmap =3D devm_regmap_init_mmio(dev, base, &eswin_regmap_config)=
;
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(dev, PTR_ERR(data->regmap),
> +				     "failed to get regmap!\n");
> +
> +	platform_set_drvdata(pdev, data);
> +
> +	data->rcdev.owner =3D THIS_MODULE;
> +	data->rcdev.ops =3D &eswin_reset_ops;
> +	data->rcdev.of_node =3D pdev->dev.of_node;
> +	data->rcdev.of_reset_n_cells =3D 1;
> +	data->rcdev.dev =3D &pdev->dev;
> +	data->rcdev.nr_resets =3D EIC7700_RESET_MAX;

Better use ARRAY_SIZE(eic7700_register_offset).

> +
> +	/* clear boot flag so u84 and scpu could be reseted by software */
> +	regmap_set_bits(data->regmap, SYSCRG_CLEAR_BOOT_INFO_OFFSET,
> +			CLEAR_BOOT_FLAG_BIT);
> +	msleep(50);
> +
> +	return devm_reset_controller_register(&pdev->dev, &data->rcdev);
> +}
> +
> +static struct platform_driver eswin_reset_driver =3D {
> +	.probe	=3D eswin_reset_probe,
> +	.driver =3D {
> +		.name		=3D "eswin-reset",
> +		.of_match_table	=3D eswin_reset_dt_ids,
> +	},
> +};
> +
> +static int __init eswin_reset_init(void)
> +{
> +	return platform_driver_register(&eswin_reset_driver);
> +}
> +arch_initcall(eswin_reset_init);

Why does this have to be arch_initcall()?

regards
Philipp


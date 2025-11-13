Return-Path: <linux-kernel+bounces-899168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 068BBC56F91
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF19F4E4210
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083C633343B;
	Thu, 13 Nov 2025 10:45:14 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090972D73B4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030713; cv=none; b=C9T3ZeZV4NdkyDBmsdi5n486i3KA8FzjHDrJcbiDxvzRl4SBxN4otr4CcooqOyLeYPTYwkpoImMz+LoSNhZxOnlvK+WL5VGT2A1lOaBbgimsTQSW7l2ehSMKhNwAkP6KBLdEPpl/+HBy6tYWMv7uoNyhUKVip3Hn06vjacnG+kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030713; c=relaxed/simple;
	bh=4rgRuekFY/f5v8UarWrgIrVKImDTj9ox/JgwI9CtWv4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cBADSSOWA/JyBBiaTTyo/TPtMCqQK4nKIN1t2jsbLJsTMY4HaSemQ6Pi199vPzeroW+TlceL6aYOtFTAIUz493OjlZzxKyXoQbAvfd1gcrxSZaY8KyBJITKP97p4EDUTY6l+/lLc9gBzE2jMFotSJZ8wWYID9nOjmG2QKCOgPBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vJUp6-0007QK-KI; Thu, 13 Nov 2025 11:45:04 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vJUp6-000Ez2-0q;
	Thu, 13 Nov 2025 11:45:04 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vJUp6-000000005XD-0n6P;
	Thu, 13 Nov 2025 11:45:04 +0100
Message-ID: <5422542a5bc21edeb229006dc6776c590bb74410.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/3] reset: cix: add support for cix sky1 resets
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Gary Yang <gary.yang@cixtech.com>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, cix-kernel-upstream@cixtech.com
Date: Thu, 13 Nov 2025 11:45:04 +0100
In-Reply-To: <20251113075935.774359-3-gary.yang@cixtech.com>
References: <20251113075935.774359-1-gary.yang@cixtech.com>
	 <20251113075935.774359-3-gary.yang@cixtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
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

On Do, 2025-11-13 at 15:59 +0800, Gary Yang wrote:
> There are two reset controllers on Cix Sky1 Soc.
> One is located in S0 domain, and the other is located
> in S5 domain.
>=20
> Signed-off-by: Gary Yang <gary.yang@cixtech.com>
> ---
>  drivers/reset/Kconfig      |   7 +
>  drivers/reset/Makefile     |   1 +
>  drivers/reset/reset-sky1.c | 381 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 389 insertions(+)
>  create mode 100644 drivers/reset/reset-sky1.c
>=20
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 78b7078478d4..45768cd3b135 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -278,6 +278,13 @@ config RESET_SIMPLE
>  	   - SiFive FU740 SoCs
>  	   - Sophgo SoCs
> =20
> +config RESET_SKY1
> +	bool "Cix Sky1 reset controller"
> +	depends on HAS_IOMEM
> +	depends on ARCH_CIX || COMPILE_TEST
> +	help
> +	  This enables the reset controller for Cix Sky1.
> +
>  config RESET_SOCFPGA
>  	bool "SoCFPGA Reset Driver" if COMPILE_TEST && (!ARM || !ARCH_INTEL_SOC=
FPGA)
>  	default ARM && ARCH_INTEL_SOCFPGA
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index f7934f9fb90b..a878ac4a6e4b 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -36,6 +36,7 @@ obj-$(CONFIG_RESET_RZG2L_USBPHY_CTRL) +=3D reset-rzg2l-=
usbphy-ctrl.o
>  obj-$(CONFIG_RESET_RZV2H_USB2PHY) +=3D reset-rzv2h-usb2phy.o
>  obj-$(CONFIG_RESET_SCMI) +=3D reset-scmi.o
>  obj-$(CONFIG_RESET_SIMPLE) +=3D reset-simple.o
> +obj-$(CONFIG_RESET_SKY1) +=3D reset-sky1.o
>  obj-$(CONFIG_RESET_SOCFPGA) +=3D reset-socfpga.o
>  obj-$(CONFIG_RESET_SPACEMIT) +=3D reset-spacemit.o
>  obj-$(CONFIG_RESET_SUNPLUS) +=3D reset-sunplus.o
> diff --git a/drivers/reset/reset-sky1.c b/drivers/reset/reset-sky1.c
> new file mode 100644
> index 000000000000..b9e03e76736a
> --- /dev/null
> +++ b/drivers/reset/reset-sky1.c
> @@ -0,0 +1,381 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + *
> + * CIX System Reset Controller (SRC) driver
> + *
> + * Author: Jerry Zhu <jerry.zhu@cixtech.com>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/reset/cix,sky1-rst.h>
> +#include <dt-bindings/reset/cix,sky1-rst-fch.h>
> +
> +#define SKY1_RESET_SLEEP_MIN_US		50
> +#define SKY1_RESET_SLEEP_MAX_US		100
> +
> +struct sky1_src_signal {
> +	unsigned int offset, bit;
> +};
> +
> +struct sky1_src_variant {
> +	const struct sky1_src_signal *signals;
> +	unsigned int signals_num;
> +};
> +
> +struct sky1_src {
> +	struct reset_controller_dev rcdev;
> +	struct regmap *regmap;
> +	const struct sky1_src_signal *signals;
> +};
> +
> +enum {
> +	CSU_PM_RESET				=3D 0x304,
> +	SENSORHUB_RESET				=3D 0x308,
> +	SENSORHUB_NOC_RESET			=3D 0x30c,
> +
> +	RESET_GROUP0_S0_DOMAIN_0		=3D 0x400,
> +	RESET_GROUP0_S0_DOMAIN_1		=3D 0x404,
> +	RESET_GROUP1_USB_PHYS			=3D 0x408,
> +	RESET_GROUP1_USB_CONTROLLERS		=3D 0x40c,
> +
> +	RESET_GROUP0_RCSU			=3D 0x800,
> +	RESET_GROUP1_RCSU			=3D 0x804,
> +

Unnecessary empty line.

Please fix this and the other issues reported by

  scripts/checkpatch.pl --strict

regards
Philipp


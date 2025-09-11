Return-Path: <linux-kernel+bounces-811278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 027E9B526EF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE9456420A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E3020FAB2;
	Thu, 11 Sep 2025 03:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Iu2+ar6f"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8974414;
	Thu, 11 Sep 2025 03:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757560573; cv=none; b=W5Pxt8LejSb9ivcfcq1gnprA1nb624Fs0U3V9yWJJ7YgLJAAiFDJo3EeR7rq4nQoi9NWrQhPzhszbpk/zdAVBnSefkoyyUn1yRW4h6wkN/cqojVtHXaXj2zz+ANFnWRyP23LmCWP4bUzXtjTE00Sdvn2juR+qCpnHxLpRSTQm84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757560573; c=relaxed/simple;
	bh=5RU9K0ZqeBi6mxA1bWf3vNZQjh8NMxKm1C9xcTnVl/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWU/y/9g/xRumT2ELVTOzEgiIKYMW3rHcufQl21h9ojK4/e7D6ygq2yIrtNgrOr5c2bblzjYAczDiFNO6aTLIdq0GwyPJO3El/5CeCoyWH6AQf3vJbb4MwDNo2Lig4X8ZIFomBKpTzVFm7hEMneuj6WvT7qaAWg8oeANJHIkeRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Iu2+ar6f; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=ixyFk/mPVbulQ4uqtT21qMKNSvDLRazah5rKk0kSLi4=;
	b=Iu2+ar6fQlNutZuCJkF+3sJZ2IgG3mhmq63+GEblQ0bld8heODl7TTuf66RQoB
	HCTuHMqeLq4UapcHboJSS/CJoGzyOFIlqOBW4FsvgIoWOcxsXzsCD683Ho7Lawyg
	6FIZIzzgLL5DvfGg4OOpWbx/6Ht5StLH5S/LMhtnHtRYw=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgDnl8rVPsJoQ0FPBA--.49162S3;
	Thu, 11 Sep 2025 11:15:35 +0800 (CST)
Date: Thu, 11 Sep 2025 11:15:33 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Subject: Re: [PATCH v2 2/2] arm64: dts: freescale: add initial device tree
 for TQMa91xx/MBa91xxCA
Message-ID: <aMI-1QVqrQeG75y6@dragon>
References: <20250901100432.139163-1-alexander.stein@ew.tq-group.com>
 <20250901100432.139163-3-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901100432.139163-3-alexander.stein@ew.tq-group.com>
X-CM-TRANSID:Mc8vCgDnl8rVPsJoQ0FPBA--.49162S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFy5ZFy7CFW8AryxGrW3ZFb_yoW5ZF1Dp3
	WkCrZ5WrWfGFyxur9Iqw40gr98Jw4rJayDuryYgFW7KrZ5uryftwn8Krs3WryxXw4rX3yU
	WFn3ZrnxAF15WaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZ189UUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCwXFZWjCG0lVNgABs0

On Mon, Sep 01, 2025 at 12:04:30PM +0200, Alexander Stein wrote:
> This adds support for TQMa91xx module attached to MBa91xxCA board.
> TQMa91xx is a SOM series using i.MX91 SOC. The SOM features PMIC, RAM,
> e-MMC and some optional peripherals like SPI-NOR, RTC, EEPROM,
> gyroscope and secure element.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> Changes in v2:
> * TQMa91xx series includes both CA & LA variant (socket & LGA)
>   adjust commit message accordingly
> * Use JTAG pinctrl by GPIO controller
> * Rename DT node name 'imu' to 'accelerometer'
> 
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../freescale/imx91-tqma9131-mba91xxca.dts    | 739 ++++++++++++++++++
>  .../boot/dts/freescale/imx91-tqma9131.dtsi    | 295 +++++++
>  3 files changed, 1035 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx91-tqma9131-mba91xxca.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx91-tqma9131.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 947de7f125caf..3a937232d6f29 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -338,6 +338,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-tqma8xqps-mb-smarc-2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8ulp-9x9-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx91-11x11-evk.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx91-tqma9131-mba91xxca.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-9x9-qsb.dtb
>  
>  imx93-9x9-qsb-i3c-dtbs += imx93-9x9-qsb.dtb imx93-9x9-qsb-i3c.dtbo
> diff --git a/arch/arm64/boot/dts/freescale/imx91-tqma9131-mba91xxca.dts b/arch/arm64/boot/dts/freescale/imx91-tqma9131-mba91xxca.dts
> new file mode 100644
> index 0000000000000..d9e471e00d760
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx91-tqma9131-mba91xxca.dts
> @@ -0,0 +1,739 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
> +/*
> + * Copyright (c) 2022-2025 TQ-Systems GmbH <linux@ew.tq-group.com>,
> + * D-82229 Seefeld, Germany.
> + * Author: Markus Niebel
> + * Author: Alexander Stein
> + */
> +/dts-v1/;
> +
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/net/ti-dp83867.h>
> +#include <dt-bindings/pwm/pwm.h>
> +#include <dt-bindings/usb/pd.h>
> +#include "imx91-tqma9131.dtsi"
> +
> +/{
> +	model = "TQ-Systems i.MX91 TQMa91xxLA/TQMa91xxCA on MBa91xxCA starter kit";
> +	compatible = "tq,imx91-tqma9131-mba91xxca", "tq,imx91-tqma9131", "fsl,imx91";
> +	chassis-type = "embedded";
> +
> +	chosen {
> +		stdout-path = &lpuart1;
> +	};
> +
> +	aliases {
> +		eeprom0 = &eeprom0;
> +		ethernet0 = &eqos;
> +		ethernet1 = &fec;
> +		gpio0 = &gpio1;
> +		gpio1 = &gpio2;
> +		gpio2 = &gpio3;
> +		gpio3 = &gpio4;
> +		i2c0 = &lpi2c1;
> +		i2c1 = &lpi2c2;
> +		i2c2 = &lpi2c3;
> +		mmc0 = &usdhc1;
> +		mmc1 = &usdhc2;
> +		rtc0 = &pcf85063;
> +		rtc1 = &bbnsm_rtc;
> +		serial0 = &lpuart1;
> +		serial1 = &lpuart2;

serial should go before rtc right?  I fixed it up and applied both
patches.

Shawn



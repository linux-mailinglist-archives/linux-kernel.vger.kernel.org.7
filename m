Return-Path: <linux-kernel+bounces-778807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA614B2EB5E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 04:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2770A087CE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 02:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA342DAFA1;
	Thu, 21 Aug 2025 02:40:36 +0000 (UTC)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67F725E814;
	Thu, 21 Aug 2025 02:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755744035; cv=none; b=JIMKF5kYSScb/5ZE0uBaamivpZoPjyOiBUWRbKWQJqfuYizj624AtvN3hZI1gsszfcUh4dljzivoLz0+n/m/Q5TUCPTltk76s94++nmLkd7nxa5sRKjdifT+/HRIwXKUYyjSLittB5X8AmTfKwpBXzYnrH5nO7RhbZXYI+1Wz5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755744035; c=relaxed/simple;
	bh=XtEgcKNQAGzQQNVlVBAnaCEy/2+2n2owQn6xiBD7Y4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tw6zrcPPMPwnidwC5TNB0v0yCOHTW4Mx9IEjzsUbDgT9Qx1upp7aPoSa5tRngjlDM/rrkaDJ+C64sszfEn8DZNbD1CtqT9L9huDyHROLr+FpplzolnmZ8QaoJavFqAsnrnXuAcs/9LcMwaYYFUfvdyf3UYV8jkAuGj6eFa3nQCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=linux.starfivetech.com; spf=none smtp.mailfrom=linux.starfivetech.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=linux.starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.starfivetech.com
X-QQ-mid: esmtpgz12t1755744015tdf80e59d
X-QQ-Originating-IP: O6wBfJ/mxbSxcRE/MwEPz7eaNjXY68MXi0HQGF45vL4=
Received: from [192.168.125.98] ( [113.104.140.179])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 Aug 2025 10:40:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2970625901000882426
Message-ID: <257702B5AE6EE65A+20bf1aab-7fa4-45ba-a8ae-d3aeb5f6e9d9@linux.starfivetech.com>
Date: Thu, 21 Aug 2025 10:40:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] riscv: dts: starfive: add Milk-V Mars CM Lite
 system-on-module
To: E Shattow <e@freeshell.de>, Emil Renner Berthing <kernel@esmil.dk>,
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20250724094912.253723-1-e@freeshell.de>
 <20250724094912.253723-5-e@freeshell.de>
Content-Language: en-US
From: Hal Feng <hal.feng@linux.starfivetech.com>
In-Reply-To: <20250724094912.253723-5-e@freeshell.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.starfivetech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: M73dZ22rf3ldFg4O0MeBLYBuOqz0LIhlhXW3qJWkzJRFebW8KldGJhBe
	fzaJUkpmIAGC92ofh2o9J4A6TbsZgExNKwg55eKMjO26dZI6qcFZxYcJmHxOV0HGgtsId+0
	vKFNzM74TICJXCFm4rWu6tkaz19AoLErFCZ9pv3GjCtdEyxZ1+U+IbWUb35ma/vUvRYNqnj
	uuAKAlSCmjC+boWiom20fSJ4z1biIuFGbHGI/dzdXYmPP1e9D/o7Q8Do1Ls1XPc6Y4nAsSm
	Uwr86Ao/AadgPuw8Xfbg4nx80lLTt3KR6W4NmVz8EDHLfy2WAZgn0mcSbl+e0cV/AAwWVrh
	PxoV7nJMNcQxaRJEZ0oD1du51yJRcBaVOtE2PLngvBXbgOQsC8Wib0YVNvc/GywWwf6kRaS
	qJx+6YxGkUdRMbh79w3eP6NTUbNAM5v/35R85zspK/rHtAlk20T/PyhrS55bpzHVAEGNU8+
	9nWDsPNdCYpMEWpIfrWjUfCVS5rIXT0JLWDjPc2x5NpplPMqV86UeyAgVgKoI2XnwIpi7Tb
	QNKbNpXWACTa1ckhNQWPbrUj7ShURVjJaJqMSfkyWuk/6nrv/YBkBgK9oYciurLItStMPYT
	djqgeyd4Te9ITvINwNP/A3H2tKZ4w77oIkRrQjRXsAWCUPLaaL1I7yITl4PK7qjxJDWG2rr
	eP4hMBFdV8r3iXgGePROhpg12OZIJbVu57XpZbFXb50HlW7QZJjxhUjGSxAzTUtrBFu7X4k
	aMEqBuckxJCRcjAzP1re/rtvvWXVN8Vut6FVRwAYKudbV71DPtN8LpQZwDKWvKT23Wvbo7a
	N6xAQXoG4zlxykzmWWEiXC+mOen7wdRTeXjJwlSIb01uRQIwSvU11Fowky0h3aBWBH735ua
	GL0232Pi9Tv7iy0SKmhzA/mPnMYYgeIi22nfdteC7fTErRJpjqAiKDMEMp+KszN1+hVoVcZ
	fXTvp86Q4e/Ki2yo/YPlZFOUFIj+2vMXpZi1MM5Q5NNufIlc4P3RlxN5P+FXhtFnAcJe3Gc
	dCdiCpcLXITqDAbaG+
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

On 7/24/2025 5:48 PM, E Shattow wrote:
> Milk-V Mars CM Lite is a System-on-Module based on the Milk-V Mars CM
> without the onboard eMMC storage component populated and configured
> instead for SD3.0 Card Slot on that interface via 100-pin connector.
> 
> Link to Milk-V Mars CM Lite schematics: https://github.com/milkv-mars/mars-files/tree/main/Mars-CM_Hardware_Schematices
> Link to StarFive JH7110 Technical Reference Manual: https://doc-en.rvspace.org/JH7110/TRM/index.html
> Link to Raspberry Pi CM4IO datasheet: https://datasheets.raspberrypi.com/cm4io/cm4io-datasheet.pdf
> 
> Add the devicetree file to make use of StarFive JH7110 common supported
> features PMIC, EEPROM, UART, I2C, GPIO, PCIe, QSPI Flash, PWM, and
> Ethernet. Also configure the eMMC interface mmc0 for SD Card use and
> configure the common SD Card interface mmc1 for onboard SDIO BT+WiFi.
> 
> Signed-off-by: E Shattow <e@freeshell.de>
> ---
>  arch/riscv/boot/dts/starfive/Makefile         |   1 +
>  .../dts/starfive/jh7110-milkv-marscm-lite.dts | 176 ++++++++++++++++++
>  2 files changed, 177 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-lite.dts
> 
> diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
> index 79742617ddab..62b659f89ba7 100644
> --- a/arch/riscv/boot/dts/starfive/Makefile
> +++ b/arch/riscv/boot/dts/starfive/Makefile
> @@ -11,6 +11,7 @@ dtb-$(CONFIG_ARCH_STARFIVE) += jh7100-starfive-visionfive-v1.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-deepcomputing-fml13v01.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-mars.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-marscm-emmc.dtb
> +dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-marscm-lite.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-pine64-star64.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.2a.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.3b.dtb
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-lite.dts b/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-lite.dts
> new file mode 100644
> index 000000000000..e110146f0b76
> --- /dev/null
> +++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-lite.dts
> @@ -0,0 +1,176 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2025 E Shattow <e@freeshell.de>
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/pinctrl/starfive,jh7110-pinctrl.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include "jh7110-common.dtsi"

You can just include "jh7110-milkv-marscm-emmc.dts" instead of "jh7110-common.dtsi".
And then adding mmc0 changes will be enough.

Best regards,
Hal

...

> +&mmc0 {
> +	bus-width = <4>;
> +	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
> +};
> +
> +&mmc0_pins {
> +	pwren-pins {
> +		pinmux = <GPIOMUX(22, GPOUT_HIGH,
> +				      GPOEN_ENABLE,
> +				      GPI_NONE)>;
> +	};
> +};
> +
...



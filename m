Return-Path: <linux-kernel+bounces-868177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B2CC04942
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E37B3A3617
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 06:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A68B279346;
	Fri, 24 Oct 2025 06:52:09 +0000 (UTC)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6183D20D51C;
	Fri, 24 Oct 2025 06:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761288728; cv=none; b=IqF0BQv4xy0k4HkPCR9ha1Pm+eGWjW+Z5chcgQqhbBibhakGq/YnGKERuouOBzkqi5Ds2QDm7+13oHLas/TJPct4GzPq/JuhDMTSgaRDf6XUgCSg18tjtWt8Qgs89Lqvt3SwDIlf8J7/vXQH+HoJV603W0Mkpl0HbWEpUIsx18c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761288728; c=relaxed/simple;
	bh=LwJjK8BIN3iuXLiLPl1cjh3hailpI/V1XJ2Tf4eZRFQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=p1lliF+1Z5WD3LBIcgXwXGkB4w8hFOCSVo/J3lJhjEp7bA+ZOrU4LV7wNY5u3DJncYl5p4bqFEbmQrzbTcBQhA6p8rq/TMxymEuFe3YjdkwI6evyUSD6Hh33CSBTo8p0RcpUhJKpbtRUZFqSUzc7b0FhGhawkLqHEGGnQS6qgN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (ip-109-43-112-130.web.vodafone.de [109.43.112.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 4342B10C;
	Fri, 24 Oct 2025 08:51:56 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Oct 2025 08:51:55 +0200
Message-Id: <DDQCQPRRVOHB.1ENJWEGUOSBTR@kernel.org>
To: "Kumar, Udit" <u-kumar1@ti.com>, "Nishanth Menon" <nm@ti.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, "Tero Kristo" <kristo@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>
Subject: Re: [PATCH v3 2/3] arm64: dts: ti: Add support for Kontron
 SMARC-sAM67
Cc: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
X-Mailer: aerc 0.20.0
References: <20251017135116.548236-1-mwalle@kernel.org>
 <20251017135116.548236-3-mwalle@kernel.org>
 <9da776bc-3156-4f4b-9e64-6ada5b47fab3@ti.com>
In-Reply-To: <9da776bc-3156-4f4b-9e64-6ada5b47fab3@ti.com>

Hi Udit,

thanks for the thorough review!

On Fri Oct 24, 2025 at 7:13 AM CEST, Udit Kumar wrote:
> On 10/17/2025 7:20 PM, Michael Walle wrote:
>> Add device tree support for the Kontron SMARC-sAM67 module, which is
>> based on a TI AM67A SoC.
>>
>> The module features:
>>   * Quad-core AM67A94 at 1.4GHz with 8 GiB RAM
>>   * 64 GiB eMMC, 4 MiB SPI flash for failsafe booting
>>   * Dedicated RTC
>>   * Multiple interfaces: 4x UART, 2x USB 2.0/USB 3.2, 2x GBE, QSPI,
>>          7x I2C,
>>   * Display support: 2x LVDS, 1x DSI (*), 1x DP (*)
>>   * Camera support: 4x CSI (*)
>>   * Onboard microcontroller for boot control, failsafe booting and
>>     external watchdog
>>
>> (*) not yet supported by the kernel
>>
>> There is a base device tree and overlays which will add optional
>> features. At the moment there is one full featured variant of that
>> board whose device tree is generated during build by merging all the
>> device tree overlays.
>>
>> Signed-off-by: Michael Walle <mwalle@kernel.org>
>> ---
>>   arch/arm64/boot/dts/ti/Makefile               |    7 +
>>   .../dts/ti/k3-am67a-kontron-sa67-base.dts     | 1091 +++++++++++++++++
>>   .../dts/ti/k3-am67a-kontron-sa67-gbe1.dtso    |   26 +
>>   .../dts/ti/k3-am67a-kontron-sa67-gpios.dtso   |   61 +
>>   .../ti/k3-am67a-kontron-sa67-rtc-rv8263.dtso  |   31 +
>>   5 files changed, 1216 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/ti/k3-am67a-kontron-sa67-base.d=
ts
>>   create mode 100644 arch/arm64/boot/dts/ti/k3-am67a-kontron-sa67-gbe1.d=
tso
>>   create mode 100644 arch/arm64/boot/dts/ti/k3-am67a-kontron-sa67-gpios.=
dtso
>>   create mode 100644 arch/arm64/boot/dts/ti/k3-am67a-kontron-sa67-rtc-rv=
8263.dtso
>>
>> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Ma=
kefile
>> index 743115b849a7..d2a40ea642c4 100644
>> --- a/arch/arm64/boot/dts/ti/Makefile
>> +++ b/arch/arm64/boot/dts/ti/Makefile
>> @@ -137,7 +137,14 @@ dtb-$(CONFIG_ARCH_K3) +=3D k3-j721s2-evm-pcie1-ep.d=
tbo
>>   dtb-$(CONFIG_ARCH_K3) +=3D k3-j721s2-evm-usb0-type-a.dtbo
>>  =20
>>   # Boards with J722s SoC
>> +k3-am67a-kontron-sa67-dtbs :=3D k3-am67a-kontron-sa67-base.dtb \
>> +	k3-am67a-kontron-sa67-rtc-rv8263.dtbo k3-am67a-kontron-sa67-gbe1.dtbo
>>   dtb-$(CONFIG_ARCH_K3) +=3D k3-am67a-beagley-ai.dtb
>> +dtb-$(CONFIG_ARCH_K3) +=3D k3-am67a-kontron-sa67.dtb
>> +dtb-$(CONFIG_ARCH_K3) +=3D k3-am67a-kontron-sa67-base.dtb
>> +dtb-$(CONFIG_ARCH_K3) +=3D k3-am67a-kontron-sa67-gbe1.dtbo
>> +dtb-$(CONFIG_ARCH_K3) +=3D k3-am67a-kontron-sa67-gpios.dtbo
>> +dtb-$(CONFIG_ARCH_K3) +=3D k3-am67a-kontron-sa67-rtc-rv8263.dtbo
>>   dtb-$(CONFIG_ARCH_K3) +=3D k3-j722s-evm.dtb
>>   dtb-$(CONFIG_ARCH_K3) +=3D k3-j722s-evm-csi2-quad-rpi-cam-imx219.dtbo
>>   dtb-$(CONFIG_ARCH_K3) +=3D k3-j722s-evm-csi2-quad-tevi-ov5640.dtbo
>> diff --git a/arch/arm64/boot/dts/ti/k3-am67a-kontron-sa67-base.dts b/arc=
h/arm64/boot/dts/ti/k3-am67a-kontron-sa67-base.dts
>> new file mode 100644
>> index 000000000000..7169d934adac
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/ti/k3-am67a-kontron-sa67-base.dts
>> @@ -0,0 +1,1091 @@
>> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>> +/*
>> + * Kontron SMARC-sAM67 module
>> + *
>> + * Copyright (c) 2025 Kontron Europe GmbH
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/phy/phy.h>
>> +#include "k3-j722s.dtsi"
>> +#include "k3-serdes.h"
>> +
>> [..]+
>> +	ospi0_pins_default: ospi0-default-pins {
>> +		pinctrl-single,pins =3D <
>> +			J722S_IOPAD(0x000, PIN_OUTPUT, 0)	/* (L24) OSPI0_CLK */
>> +			J722S_IOPAD(0x02c, PIN_OUTPUT, 0)	/* (K26) OSPI0_CSn0 */
>> +			J722S_IOPAD(0x030, PIN_OUTPUT, 0)	/* (K23) OSPI0_CSn1 */
>> +			J722S_IOPAD(0x034, PIN_OUTPUT, 0)	/* (K22) OSPI0_CSn2 */
>
> I am not sure, which flash device is being used , could you check once=20
> if all three CS are supported.

Yes, all three are used. This board has one 4MiB on-board flash
W25Q32 (or similar) and the two others CS are routed to the edge
connector. They aren't multi purpose, so we can already set them
to the CS function.

>> +			J722S_IOPAD(0x00c, PIN_INPUT, 0)	/* (K27) OSPI0_D0 */
>> +			J722S_IOPAD(0x010, PIN_INPUT, 0)	/* (L27) OSPI0_D1 */
>> +			J722S_IOPAD(0x014, PIN_INPUT, 0)	/* (L26) OSPI0_D2 */
>> +			J722S_IOPAD(0x018, PIN_INPUT, 0)	/* (L25) OSPI0_D3 */
>> +		>;
>> +		bootph-all;
>> +	};
>> +
>> +	pcie0_rc_pins_default: pcie0-rc-default-pins {
>> +		pinctrl-single,pins =3D <
>> +			J722S_IOPAD(0x2ac, PIN_OUTPUT, 0)	/* (F25) PCIE0_CLKREQn */
>> +			J722S_IOPAD(0x1b4, PIN_OUTPUT, 7)	/* (B20) SPI0_CS0.GPIO1_15 */
>> +		>;
>> +	};
>> +
>> +	pmic_irq_pins_default: pmic-irq-default-pins {
>> +		pinctrl-single,pins =3D <
>> +			J722S_IOPAD(0x090, PIN_INPUT, 7)	/* (P27) GPMC0_BE0n_CLE.GPIO0_35 */
>> +		>;
>> +	};
>> +
>> [..]
>> +/* I2C_PM */
>> +&wkup_i2c0 {
>> +	pinctrl-names =3D "default";
>> +	pinctrl-0 =3D <&wkup_i2c0_pins_default>;
>> +	clock-frequency =3D <100000>;
>> +	status =3D "okay";
>
>
> This is more a question, I see all i2c controller you want to run at=20
> 100Kz, but most of devices are supporting 400Khz
>
> like tps652g1 over main_i2c0 , =C2=A0pca9546 over main_i2c1 , is there=20
> specific reason for this

Actually yes and it was at 400kHz at first. But it wont work with
the onboard management controller at that bus. Although it supports
400kHz, the mode in which we are using it, doesn't. In short, we
aren't using clock stretching as this might cause the whole bus to
hang without being able to recover it from the SoC. Therefore, the
i2c reply bytes have to be prepared just-in-time and it turn out
that 400kHz is too fast for that.

-michael

>> +};
>> +
>> +/* SER3 */
>> +&wkup_uart0 {
>> +	/* WKUP UART0 is used by Device Manager firmware */
>> +	pinctrl-names =3D "default";
>> +	pinctrl-0 =3D <&wkup_uart0_pins_default>;
>> +	bootph-all;
>> +	status =3D "reserved";
>> +};
> [..]



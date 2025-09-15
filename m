Return-Path: <linux-kernel+bounces-817064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE1CB57D97
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B83167434
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4DA3191D0;
	Mon, 15 Sep 2025 13:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="N2mUKg64"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8983D30E823
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943621; cv=none; b=BF0H2cxpyKoEt+eBwORrBSBpq8R0MaXI6xue/oM6Rfw+uQghTWowkMWNYygt3fjRhaelTfJKCBnNvrolnp6EVf9nLu37TxXH3dCVfmLVOQzj0s/zQ+LYlTYCAIOs0ezSeWKwYowADt//d9PBFOS6kkUSmoEWH57ORqRabiTpX10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943621; c=relaxed/simple;
	bh=gwbwO91bOoSE4JZaR8T48G6qaL5x/i7NOANaiN8rcN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUQEQWX/i+rq4OQrcijT87AgqGqsjlwtwpZ0giCqZ/9KGxLj0CIZLbNbMDaIeLiMCxcDv9R5aarrxqJJOGfPEi67Xow1emgy+mfK0vD4pdrOSLBF2O3Th1BSuMdZSmn7fBvjl5W9dmegYeXJzbY1jKPcVuXIgMPOv4xRG6LzOao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=N2mUKg64; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 1F369240104
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:40:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1757943616; bh=zPpCQPE4eMkTvvxsIdtpPEd1CfQJpfQRp57YufKsBb0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=N2mUKg64WNyJI3q802YHsTS8/IcI2Ea7tSFbvbDiTgGj504U4mpFgQt9zXFBny2m2
	 UTPWKoLs/KlFaVcZXk8ACWoT2z2IjO9xqLdy+z9p7QxRNKIJXP9GPq4hB/0L+1sF1n
	 ala3jjYFgm2tiKWfmWa4rzKNQHoRe0f601iie5PUqnk4AjBEZgeMkr3uinnnjXxbHh
	 9O7dw133aqVG811+w21fKN+WJ+t8Wpy95oCrVleOS7WFe1YPT3EqoC2SsmY3Org/G8
	 W9PMeyJshZP62O7SjqJdVIV1CqFt42MMpKmN0/JrjNDU6t9izbIctkgvCgNCLs9A7m
	 4q5RK1qa7PzQw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cQR3w2hDqz9rxV;
	Mon, 15 Sep 2025 15:40:12 +0200 (CEST)
Date: Mon, 15 Sep 2025 13:40:15 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Andre Przywara <andre.przywara@arm.com>
Cc: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= via B4 Relay <devnull+j.ne.posteo.net@kernel.org>,
	j.ne@posteo.net, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: allwinner: h313: Add Amediatech X96Q
Message-ID: <aMgXPPn3D3epmAua@probook>
References: <20250912-x96q-v1-0-8471daaf39db@posteo.net>
 <20250912-x96q-v1-2-8471daaf39db@posteo.net>
 <20250912105449.70717d80@donnerap>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250912105449.70717d80@donnerap>

On Fri, Sep 12, 2025 at 10:54:49AM +0100, Andre Przywara wrote:
> On Fri, 12 Sep 2025 01:52:10 +0200
> J. Neuschäfer via B4 Relay <devnull+j.ne.posteo.net@kernel.org> wrote:
> 
> Hi,
> 
> many thanks for posting the DT, I really wish more people would do that!
> 
> > From: "J. Neuschäfer" <j.ne@posteo.net>
> > 
> > The X96Q is a set-top box with an H313 SoC, AXP305 PMIC, 1 or 2 GiB RAM,
> > 8 or 16 GiB eMMC flash, 2x USB A, Micro-SD, HDMI, Ethernet, audio/video
> > output, and infrared input.
> > 
> >   https://x96mini.com/products/x96q-tv-box-android-10-set-top-box
> > 
> > Tested, works:
> > - debug UART
> > - status LED
> > - USB ports in host mode
> > - MicroSD
> > - eMMC
> > - recovery button hidden behind audio/video port
> > - analog audio (line out)
> > 
> > Does not work:
> > - Ethernet (requires AC200 MFD/EPHY driver)
> > - analog video output (requires AC200 driver)
> > - HDMI audio/video output
> > 
> > Untested:
> > - "OTG" USB port in device mode
> > - built-in IR receiver
> > - external IR receiver
> > - WLAN (requires out-of-tree XRadio driver)
> > 
> > Table of regulators on the downstream kernel, for reference:
> > 
> >  vcc-5v      1   15      0 unknown  5000mV     0mA  5000mV  5000mV
> >     dcdca    0    0      0 unknown   900mV     0mA     0mV     0mV
> >     dcdcb    0    0      0 unknown  1350mV     0mA     0mV     0mV
> >     dcdcc    0    0      0 unknown   900mV     0mA     0mV     0mV
> >     dcdcd    0    0      0 unknown  1500mV     0mA     0mV     0mV
> >     dcdce    0    0      0 unknown  3300mV     0mA     0mV     0mV
> >     aldo1    0    0      0 unknown  3300mV     0mA     0mV     0mV
> >     aldo2    0    0      0 unknown   700mV     0mA     0mV     0mV
> >     aldo3    0    0      0 unknown   700mV     0mA     0mV     0mV
> >     bldo1    0    0      0 unknown  1800mV     0mA     0mV     0mV
> >     bldo2    0    0      0 unknown  1800mV     0mA     0mV     0mV
> >     bldo3    0    0      0 unknown   700mV     0mA     0mV     0mV
> >     bldo4    0    0      0 unknown   700mV     0mA     0mV     0mV
> >     cldo1    0    0      0 unknown  2500mV     0mA     0mV     0mV
> >     cldo2    0    0      0 unknown   700mV     0mA     0mV     0mV
> >     cldo3    0    0      0 unknown   700mV     0mA     0mV     0mV
> > 
> > Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> > ---
> >  arch/arm64/boot/dts/allwinner/Makefile             |   1 +
> >  arch/arm64/boot/dts/allwinner/sun50i-h313-x96q.dts | 235 +++++++++++++++++++++
> >  2 files changed, 236 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
> > index 780aeba0f3a4e14d69c9602e37b8d299165507b9..2edfa7bf4ab31c4aa934da98e5e042edc9aaf600 100644
> > --- a/arch/arm64/boot/dts/allwinner/Makefile
> > +++ b/arch/arm64/boot/dts/allwinner/Makefile
> > @@ -41,6 +41,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6-mini.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h313-tanix-tx1.dtb
> > +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h313-x96q.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-cb1-manta.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-pi.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h313-x96q.dts b/arch/arm64/boot/dts/allwinner/sun50i-h313-x96q.dts
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..9534eb03b89557f2545af5af7cf43390be722cf0
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h313-x96q.dts
> > @@ -0,0 +1,235 @@
> > +// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
> > +/*
> > + * Copyright (C) 2025 J. Neuschäfer <j.ne@posteo.net>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "sun50i-h616.dtsi"
> > +#include "sun50i-h616-cpu-opp.dtsi"
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/input/linux-event-codes.h>
> > +#include <dt-bindings/leds/common.h>
> > +
> > +/ {
> > +	model = "X96Q";
> > +	compatible = "amediatech,x96q", "allwinner,sun50i-h616";
> > +
> > +	aliases {
> > +		mmc0 = &mmc0;
> > +		mmc1 = &mmc1;
> > +		mmc2 = &mmc2;
> 
> We don't do mmc aliases in the upstream DTs. Long story, but you should
> not need them. I guess you want to disagree ;-),

I've seen mmc aliases before, and I've seen the annoying effects of an
unstable probe order, so this is mostly of thing of habit.

> in this case U-Boot has
> you covered, by adding the aliases during build time: just use
> $fdtcontroladdr, as you should do anyway.

I'm using a recent upstream U-Boot with a FIT image ('make image.fit' in
the Linux source tree). In this case U-Boot does not add mmc aliases.
Is there a special Kconfig option I need to enable in U-Boot?

What do you mean by 'build time'? U-Boot's?


> 
> > +		serial0 = &uart0;
> > +	};
[...]
> > +&mmc0 {
> > +	vmmc-supply = <&reg_aldo1>;
> > +	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
> > +	disable-wp;
> > +	bus-width = <4>;
> > +	max-frequency = <150000000>;
> 
> That line is already in the .dtsi file, so redundant.

Good point, removing.
> 
> > +	status = "okay";
> > +	/* µSD */
> 
> If we really need this comment, it should be above, right after the
> "&mmc0 {". And I wonder if it should be "microSD" instead.

Good points, I'll do both.

> > +};
> > +
> > +&mmc1 {
> > +	/* TODO: XRadio XR819 WLAN */
> 
> Either you just keep the comment, an mention mmc1, but don't reference the
> node, or you add the properties that you know of already, like
> vmmc-supply, vqmmc-supply, mmc-pwrseq, bus-width, non-removable.
> But this "empty reference with a comment" is somewhat odd.

I'll change it to a pure comment for now.

> > +};
> > +
> > +&mmc2 {
> > +	vmmc-supply = <&reg_aldo1>;
> > +	vqmmc-supply = <&reg_bldo1>;
> > +	non-removable;
> > +	cap-mmc-hw-reset;
> > +	mmc-ddr-1_8v;
> > +	mmc-hs200-1_8v;
> > +	bus-width = <8>;
> > +	max-frequency = <100000000>;
> 
> Are you sure you need that?

I found it in the downstream DT. The eMMC probes fine without it, so
I'll remove it. The eMMC datasheet (assuming I found the right one),
claims a maximum of 200 MHz, so the 100 MHz restriction seems
unnecessary.

> 
> > +	status = "okay";
> > +	/* eMMC */
> 
> Please move that comment up.

Will do.


[...]
> > +		regulators {
> > +			reg_dcdca: dcdca {
> > +				regulator-always-on;
> > +				regulator-min-microvolt = <810000>;
> > +				regulator-max-microvolt = <1100000>;
> > +				regulator-name = "vdd-cpu";
> > +			};
> > +
> > +			dcdcb {
> > +				/* unused */
> > +			};
> > +
> > +			reg_dcdcc: dcdcc {
> > +				regulator-always-on;
> > +				regulator-min-microvolt = <810000>;
> > +				regulator-max-microvolt = <990000>;
> > +				regulator-name = "vdd-gpu-sys";
> > +			};
> > +
> > +			dcdcd {
> > +				regulator-always-on;
> 
> Why is this always on? What happens if you remove that line or turn it off?
> For always-on regulators we either need a comment saying why, or, better,
> have an explanatory regulator-name (like above).
> Is that for DRAM, by any chance (1.5V for DDR3 chips)?

The observed behavior is that the system halts when dcdcd is disabled.
The relationship is a bit hard to determine without schematics, but the
DDR3 chips (Micron MT41J256M4) do indeed use 1.5V. Since this is the
only source of 1.5V, I think it's a safe guess that this is indeed the
DRAM regulator.

> 
> Cheers,
> Andre

Thanks for the review!
J. Neuschäfer


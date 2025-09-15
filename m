Return-Path: <linux-kernel+bounces-817628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B87E7B584B3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188541A26DB7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8F6280037;
	Mon, 15 Sep 2025 18:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="fwQCF83w"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4E2E573
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757961425; cv=none; b=YZCiVyTdgbba6odvFHQzC4TSZgoO3n22AJSSepDze1m7DtZMfaZR7/jF0Y5RMBQavMBz7HpA+VyzRg6zczZyNjBW+rHqfZ1DPDptipGz1hTOW39p1DoeeYt6NyN6iA6dKFq6uvlO3W9WkGrp6HI1wkaDaylZLfaAP3yYb1q9gRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757961425; c=relaxed/simple;
	bh=209eci6aRzHWIwRyX/rgh7c2i1XYNBnkzbEzYmFDqlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnhG6VvKn+6LD/IHpyyhgHRffNjUChfXQ92YtbQwuh9CrDM916Anm09naBppfBJCOXz4bxP5A1EqYPahn7QfWe5hrN/0CnV7cEvp8ZkR2sl1hPVSqhgozI3kEGsLOILbY4rt20pfkmOTN4RbNDVPenUAGw2DBMlDNEpSHYMjWeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=fwQCF83w; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 25061240103
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 20:36:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1757961417; bh=8N8kahmaMK5yIdd2qUvMT4zY2+pJHodS9IL0e9aOgwo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=fwQCF83wJdr+KUbeDi1nA2IBUEJZ2khcpIGdfBDrGAGplQOaYAFZnvyZb0C2gAsNV
	 BReyAS17iwws8P4467xM+TM77Vju1guBecU4sCiz8bqxiWJg0A27/nS6I8AkWzBIJz
	 fBYMffyhzX7Tz8f2zz8y/xVphU3l22mB8uPiLKuqQKPl9doktBxkXiKBWLSqTe+N1k
	 mPFnkcyrIZAusw1BgBSlDrH0sqIrbgxreTy72c4AaTv9aqCsCHmAW2PtpOrrXbvt0z
	 1m02e60KVwdA4byZbFlX3bBtICD1aODJkOTPYPsNpEtmv0oQ4zHGgkx8bDC8QH41Zj
	 vmV81v5YCsJvw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cQYfF5ngLz6tvm;
	Mon, 15 Sep 2025 20:36:53 +0200 (CEST)
Date: Mon, 15 Sep 2025 18:36:56 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
	=?utf-8?Q?J=2E_Neusch=C3=A4fer?= via B4 Relay <devnull+j.ne.posteo.net@kernel.org>,
	j.ne@posteo.net, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: allwinner: h313: Add Amediatech X96Q
Message-ID: <aMhcxcBYF2vMjd5g@probook>
References: <20250912-x96q-v1-0-8471daaf39db@posteo.net>
 <20250912-x96q-v1-2-8471daaf39db@posteo.net>
 <20250912105449.70717d80@donnerap>
 <CAGb2v67dp8V4A86yyaixN9oOgBzMpLJ0ZxnDLng8mO2tkEqYUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGb2v67dp8V4A86yyaixN9oOgBzMpLJ0ZxnDLng8mO2tkEqYUg@mail.gmail.com>

On Sat, Sep 13, 2025 at 05:36:12PM +0800, Chen-Yu Tsai wrote:
> On Fri, Sep 12, 2025 at 5:54 PM Andre Przywara <andre.przywara@arm.com> wrote:
> >
> > On Fri, 12 Sep 2025 01:52:10 +0200
> > J. Neuschäfer via B4 Relay <devnull+j.ne.posteo.net@kernel.org> wrote:
> >
> > Hi,
> >
> > many thanks for posting the DT, I really wish more people would do that!
> >
> > > From: "J. Neuschäfer" <j.ne@posteo.net>
> > >
> > > The X96Q is a set-top box with an H313 SoC, AXP305 PMIC, 1 or 2 GiB RAM,
> > > 8 or 16 GiB eMMC flash, 2x USB A, Micro-SD, HDMI, Ethernet, audio/video
> > > output, and infrared input.
> > >
> > >   https://x96mini.com/products/x96q-tv-box-android-10-set-top-box
> > >
> > > Tested, works:
> > > - debug UART
> > > - status LED
> > > - USB ports in host mode
> > > - MicroSD
> > > - eMMC
> > > - recovery button hidden behind audio/video port
> > > - analog audio (line out)
> > >
> > > Does not work:
> > > - Ethernet (requires AC200 MFD/EPHY driver)
> > > - analog video output (requires AC200 driver)
> > > - HDMI audio/video output
> > >
> > > Untested:
> > > - "OTG" USB port in device mode
> > > - built-in IR receiver
> > > - external IR receiver
> > > - WLAN (requires out-of-tree XRadio driver)
> > >
> > > Table of regulators on the downstream kernel, for reference:
> > >
> > >  vcc-5v      1   15      0 unknown  5000mV     0mA  5000mV  5000mV
> > >     dcdca    0    0      0 unknown   900mV     0mA     0mV     0mV
> > >     dcdcb    0    0      0 unknown  1350mV     0mA     0mV     0mV
> > >     dcdcc    0    0      0 unknown   900mV     0mA     0mV     0mV
> > >     dcdcd    0    0      0 unknown  1500mV     0mA     0mV     0mV
> > >     dcdce    0    0      0 unknown  3300mV     0mA     0mV     0mV
> > >     aldo1    0    0      0 unknown  3300mV     0mA     0mV     0mV
> > >     aldo2    0    0      0 unknown   700mV     0mA     0mV     0mV
> > >     aldo3    0    0      0 unknown   700mV     0mA     0mV     0mV
> > >     bldo1    0    0      0 unknown  1800mV     0mA     0mV     0mV
> > >     bldo2    0    0      0 unknown  1800mV     0mA     0mV     0mV
> > >     bldo3    0    0      0 unknown   700mV     0mA     0mV     0mV
> > >     bldo4    0    0      0 unknown   700mV     0mA     0mV     0mV
> > >     cldo1    0    0      0 unknown  2500mV     0mA     0mV     0mV
> > >     cldo2    0    0      0 unknown   700mV     0mA     0mV     0mV
> > >     cldo3    0    0      0 unknown   700mV     0mA     0mV     0mV
> > >
> > > Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> > > ---
[...]
> > > +&mmc0 {
> > > +     vmmc-supply = <&reg_aldo1>;
> > > +     cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;  /* PF6 */
> > > +     disable-wp;
> > > +     bus-width = <4>;
> > > +     max-frequency = <150000000>;
> >
> > That line is already in the .dtsi file, so redundant.
> >
> > > +     status = "okay";
> > > +     /* µSD */
> >
> > If we really need this comment, it should be above, right after the
> > "&mmc0 {". And I wonder if it should be "microSD" instead.
> 
> Yes. Please use ASCII in the code if possible, since some of us have
> setups that don't quite work well with extended character sets.

ACK

> 
> > > +};
> > > +
> > > +&mmc1 {
> > > +     /* TODO: XRadio XR819 WLAN */
> >
> > Either you just keep the comment, an mention mmc1, but don't reference the
> > node, or you add the properties that you know of already, like
> > vmmc-supply, vqmmc-supply, mmc-pwrseq, bus-width, non-removable.
> > But this "empty reference with a comment" is somewhat odd.
> 
> I'd say just fill it in completely so that the mmc host is enabled and
> the SDIO card is detected. Missing driver support for the chip is a
> different issue, but since this is an enumerable bus it shouldn't prevent
> you from describing everything already.

I gave it a try just now, but I wasn't successful with enumeration:

	&mmc1 {
		/* XRadio XR819 WLAN */
		vmmc-supply = <&reg_aldo1>;
		vqmmc-supply = <&reg_bldo1>;
		mmc-pwrseq = <&wifi_pwrseq>;
		bus-width = <4>;
		non-removable;
		mmc-ddr-1_8v;
		status = "okay";
	};

The result is unsuccessful (with or without the questionable mmc-ddr-1_8v):

	[    1.607511] mmc1: Failed to initialize a non-removable card

The downstream DT mentions a few relevant properties:

	/wlan {
		wlan_regon = <&pio 6 18 GPIO_ACTIVE_LOW>;
		pinctrl-names = "default";
		pinctrl-0 = <&losc>;
	};
	...
	losc: clk_losc@0 {
		linux,phandle = <0xd3>;
		phandle = <0xd3>;
		allwinner,drive = <0x02>;
		allwinner,function = "x32kfout";
		allwinner,muxsel = <0x03>;
		allwinner,pins = "PG10";
		allwinner,pull = <0x01>;
	};

Translating this (roughly) into mainline bindings:

	mmc-pwrseq = <&wifi_pwrseq>;
	...

	wifi_pwrseq: pwrseq {
		compatible = "mmc-pwrseq-emmc";
		reset-gpios = <&pio 6 18 GPIO_ACTIVE_LOW>;
		clocks = <&rtc CLK_OSC32K_FANOUT>;
		clock-names = "ext_clock";
		pinctrl-names = "default";
		pinctrl-0 = <&x32clk_fanout_pin>;
	};

... it fails in drivers/reset/core.c, because __reset_add_reset_gpio_device
doesn't handle #gpio-cells = <3>, which is the case for &pio:

	/*
	 * Currently only #gpio-cells=2 is supported with the meaning of:
	 * args[0]: GPIO number
	 * args[1]: GPIO flags
	 * TODO: Handle other cases.
	 */
	if (args->args_count != 2)
		return -ENOENT;

Relatedly, I'd expect this limitation to break WiFi on sun50i-h313-tanix-tx1.dts
(upstreamed by Andre) as well.

> > > +};
> > > +
> > > +&mmc2 {
> > > +     vmmc-supply = <&reg_aldo1>;
> > > +     vqmmc-supply = <&reg_bldo1>;
> > > +     non-removable;
> > > +     cap-mmc-hw-reset;
> > > +     mmc-ddr-1_8v;
> > > +     mmc-hs200-1_8v;
> > > +     bus-width = <8>;
> > > +     max-frequency = <100000000>;
> >
> > Are you sure you need that?

After some more testing, it turns out that I do need to limit the
frequency to 100 MHz. At the default of 150 MHz, stable operation of
the eMMC isn't possible (all other properties being as they are).

> >
> > > +     status = "okay";
> > > +     /* eMMC */
> >
> > Please move that comment up.
> 
> I don't think it's necessary though. hs200 and 8-bit width would make
> it obvious that it's an eMMC.

Not necessary, but perhaps still useful for someone having a quick
glance at the devicetree, so I'd prefer to keep it in.


Best regards,
J. Neuschäfer


Return-Path: <linux-kernel+bounces-842651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCA7BBD3BD
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 09:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F9AA4E8D7C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 07:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9C4257AC6;
	Mon,  6 Oct 2025 07:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="GdF1hOpX"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE8D1DE4C2;
	Mon,  6 Oct 2025 07:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759736403; cv=pass; b=Xmg73J+M66rdbLTlS/JbsHt7C+4Lrpat5C+hqVgKmTqB4iD7/fpwT/8cUYVy6xT82URPS1zDx7Nz5MGpEaA9Ms/yGo8GpIGlpoct80r2MFsZIZIcBCh9Op4MFN/BZLbxxSvH82bF619rFhU1buWrES/dSgYGGV2cM3z8FKt4csA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759736403; c=relaxed/simple;
	bh=ifeD1V/OydxIYOlqq1CGyt3UyEIZCjP68IbdLsxz1MA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q2JwHzJMHEvXAEQ535QgvzytkjhRgIlk4Qnp4PaWmLFyQ8JujEOrDo6dM19AnkxyadcDGTBpIiBHjWHiZWcVccjWU32hhGrRXmuL8+DF9es8O91+4NMKC+Tm4PjISberL8jkZQGGbBecQHN+1H507M0XvqrJ44Of7gs8zOxMb0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=GdF1hOpX; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1759736368; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ntQ+Q3Zt7hjvwmAMc61+m55aPhnxvQ99FrjBKqw3np9sdBKLIzgkAoFwR8pWn1T5k6KYKKDPlRaLED5FKnKsJsfI3B7CtKCpqmJ+A8OmYnHJ9j65KEDknUeHxrRGNFvrHIlGZg6hoChedx8bsMqR4I5ViXLYbcPBiPorYAqAaPs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759736368; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ifeD1V/OydxIYOlqq1CGyt3UyEIZCjP68IbdLsxz1MA=; 
	b=U+fVHvZXtgLqIn3An9KyyjFm/Ty6mhYhD413v5FcfVF1Pp9Ffdf3GsU/1S+rZKunj9e25PgGBR0rkqX7VLFVeUpIx556EDgQETAQG8loDh5d2JrIV9gq2C2GYPwkN0DTOM2rAS52+cvmu8P8Xb3UYCRalzP2S+o0xIE8t2h0Eac=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759736368;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=ifeD1V/OydxIYOlqq1CGyt3UyEIZCjP68IbdLsxz1MA=;
	b=GdF1hOpX0ILWomAWJGPuV6sp8nrBeTf4tJrhMxW++vnx/i9qHd6PwVaPMhHWzzGa
	eV/74NaQM4t6trV2bn/ckbrITajoqXnmPCtKIGu5aM4cCG424ahFU9pc2vpREZ+EKkp
	6W0qlDT/pEih0sr/lEYLKKUUvTtJ42H2nCawVKLUkUs2YP5osfsmD4jwYUjHwU/sRgy
	htFJXOEZPeIQegZnSe67FTntg0IeYV7mEwr7adoA7gUs/N457kyj2u0Fb1nPulYIZpw
	4u7NSmYqWVZfxQNOdnqRGKBSive0HFaqCtTGAF+i0zx/jZBB4JGDxy/fnRvvINklo5E
	gwc2EUHz+g==
Received: by mx.zohomail.com with SMTPS id 1759736364875221.86100194966173;
	Mon, 6 Oct 2025 00:39:24 -0700 (PDT)
Message-ID: <2e6ce092996f2717bc274e1c82873c42b2ab18ce.camel@icenowy.me>
Subject: Re: [PATCH v2 2/2] riscv: dts: starfive: add DT for Orange Pi RV
From: Icenowy Zheng <uwu@icenowy.me>
To: E Shattow <e@freeshell.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Emil
 Renner Berthing <kernel@esmil.dk>, Michael Zhu
 <michael.zhu@starfivetech.com>, Drew Fustini <drew@beagleboard.org>, Yao Zi
 <ziyao@disroot.org>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 06 Oct 2025 15:39:16 +0800
In-Reply-To: <b8db0cdf-163e-416d-94b8-c9e1f10c8011@freeshell.de>
References: <20250930100318.2131968-1-uwu@icenowy.me>
	 <20250930100318.2131968-2-uwu@icenowy.me>
	 <579dad6b4ab0c981b8d51383af2db3a9f4394609.camel@icenowy.me>
	 <b8db0cdf-163e-416d-94b8-c9e1f10c8011@freeshell.de>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

=E5=9C=A8 2025-10-05=E6=98=9F=E6=9C=9F=E6=97=A5=E7=9A=84 11:47 -0700=EF=BC=
=8CE Shattow=E5=86=99=E9=81=93=EF=BC=9A
> Hi Icenowy,
>=20
> On 9/30/25 08:51, Icenowy Zheng wrote:
> > =E5=9C=A8 2025-09-30=E6=98=9F=E6=9C=9F=E4=BA=8C=E7=9A=84 18:03 +0800=EF=
=BC=8CIcenowy Zheng=E5=86=99=E9=81=93=EF=BC=9A
> > > Orange Pi RV is a newly released SBC with JH7110 SoC, single GbE
> > > port
> > > (connected to JH7110 GMAC0 via a YT8531 PHY), 4 USB ports (via a
> > > VL805
> > > PCIe USB controller connected to JH7110 PCIE0), a M.2 M-key slot
> > > (connected to JH7110 PCIE1), a HDMI video output, a 3.5mm audio
> > > output
> > > and a microSD slot.
> > >=20
> > > Other Onboard peripherals contain a SPI NOR (which contains the
> > > U-
> > > Boot
> > > firmware), a 24c02 EEPROM storing some StarFive-specific
> > > information
> > > (factory programmed and read only by default) and an Ampak AP6256
> > > SDIO
> > > Wi-Fi module.
> > >=20
> > > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > > ---
> > > Changes in v2:
> > > - Property order change mentioned in the review of v1.
> > > - Added Wi-Fi (along with the always on VCC3V3_PCIE regulator,
> > > which
> > > is
> > > =C2=A0 used to power up WIFI_3V3). The OOB IRQ is still not possible
> > > to
> > > use
> > > =C2=A0 because of some incompatibility between StarFive pinctrl drive=
r
> > > and
> > > =C2=A0 brcmfmac.
> > > - Removed the LED because it's in common DTSI.
> > >=20
> > > =C2=A0arch/riscv/boot/dts/starfive/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > =C2=A0.../boot/dts/starfive/jh7110-orangepi-rv.dts=C2=A0 | 87
> > > +++++++++++++++++++
> > > =C2=A02 files changed, 88 insertions(+)
> > > =C2=A0create mode 100644 arch/riscv/boot/dts/starfive/jh7110-orangepi=
-
> > > rv.dts
> > >=20
> > > diff --git a/arch/riscv/boot/dts/starfive/Makefile
> > > b/arch/riscv/boot/dts/starfive/Makefile
> > > index b3bb12f78e7d5..24f1a44828350 100644
> > > --- a/arch/riscv/boot/dts/starfive/Makefile
> > > +++ b/arch/riscv/boot/dts/starfive/Makefile
> > > @@ -10,6 +10,7 @@ dtb-$(CONFIG_ARCH_STARFIVE) +=3D jh7100-starfive-
> > > visionfive-v1.dtb
> > > =C2=A0
> > > =C2=A0dtb-$(CONFIG_ARCH_STARFIVE) +=3D jh7110-deepcomputing-fml13v01.=
dtb
> > > =C2=A0dtb-$(CONFIG_ARCH_STARFIVE) +=3D jh7110-milkv-mars.dtb
> > > +dtb-$(CONFIG_ARCH_STARFIVE) +=3D jh7110-orangepi-rv.dtb
> > > =C2=A0dtb-$(CONFIG_ARCH_STARFIVE) +=3D jh7110-pine64-star64.dtb
> > > =C2=A0dtb-$(CONFIG_ARCH_STARFIVE) +=3D jh7110-starfive-visionfive-2-
> > > v1.2a.dtb
> > > =C2=A0dtb-$(CONFIG_ARCH_STARFIVE) +=3D jh7110-starfive-visionfive-2-
> > > v1.3b.dtb
> > > diff --git a/arch/riscv/boot/dts/starfive/jh7110-orangepi-rv.dts
> > > b/arch/riscv/boot/dts/starfive/jh7110-orangepi-rv.dts
> > > new file mode 100644
> > > index 0000000000000..5a917b7db6f78
> > > --- /dev/null
> > > +++ b/arch/riscv/boot/dts/starfive/jh7110-orangepi-rv.dts
> > > @@ -0,0 +1,87 @@
> > > +// SPDX-License-Identifier: GPL-2.0 OR MIT
> > > +/*
> > > + * Copyright (C) 2025 Icenowy Zheng <uwu@icenowy.me>
> > > + */
> > > +
> > > +/dts-v1/;
> > > +#include "jh7110-common.dtsi"
> > > +
> > > +/ {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0model =3D "Xunlong Orange =
Pi RV";
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0compatible =3D "xunlong,or=
angepi-rv", "starfive,jh7110";
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* This regulator is alway=
s on by hardware */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reg_vcc3v3_pcie: regulator=
-vcc3v3-pcie {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0compatible =3D "regulator-fixed";
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0regulator-name =3D "vcc3v3-pcie";
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0regulator-min-microvolt =3D <3300000>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0regulator-max-microvolt =3D <3300000>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0regulator-always-on;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0wifi_pwrseq: wifi-pwrseq {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0compatible =3D "mmc-pwrseq-simple";
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0reset-gpios =3D <&sysgpio 62 GPIO_ACTIVE_LOW>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> > > +};
> > > +
> > > +&gmac0 {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0assigned-clocks =3D <&aonc=
rg JH7110_AONCLK_GMAC0_TX>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0assigned-clock-parents =3D=
 <&aoncrg
> > > JH7110_AONCLK_GMAC0_RMII_RTX>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0starfive,tx-use-rgmii-clk;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> > > +};
> > > +
> > > +&mmc0 {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#address-cells =3D <1>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#size-cells =3D <0>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cap-sd-highspeed;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mmc-pwrseq =3D <&wifi_pwrs=
eq>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vmmc-supply =3D <&reg_vcc3=
v3_pcie>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vqmmc-supply =3D <&vcc_3v3=
>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ap6256: wifi@1 {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0compatible =3D "brcm,bcm43456-fmac", "brcm,bcm4329-
> > > fmac";
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0reg =3D <1>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0/* TODO: out-of-band IRQ on GPIO21 */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> > > +};
> > > +
>=20
> > > +&mmc0_pins {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * As the MMC0 bus is used=
 to connect a SDIO Wi-Fi card
> > > instead of
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * an eMMC card, and the e=
MMC RST is repurposed to be an
> > > enablement
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * pin of the SDIO Wi-Fi, =
remove it from the pinctrl node
> > > and
> > > manage
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * it as a GPIO instead.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/delete-node/ rst-pins;
> > > +};
> > > +
>=20
> Listed on the schematic [1] as:
> Default function SDIO0 RSTn GPIO62 for eMMC:J9
> Highlighted (non-default?) function GPIO62 D17 << WIFI_EN_H_GPIO62
> WIFI_EN_H_GPIO62 >> WIFI_PWREN (pin 12 WL_REG_ON of module AP6256)
>=20
> I've sent a patch [2] to portion out mmc0 reset pins from jh7110-
> common.dtsi
>=20
> > > +&mmc1 {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/delete-property/ cd-gpios=
;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0broken-cd;
> >=20
> > Well it's found that the card detect is working, although with
> > different polarity with other boards.
> >=20
> > Here should be:
> > ```
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cd-gpios =3D <&sysgpio =
41 GPIO_ACTIVE_HIGH>;
> > ```
> >=20
> > Will be fixed in the next revision.
>=20
> Yes, listed on the schematic [1] as:
> SD SDIO0 CD GPIO41 for MicroSD:J10
>=20
> There is not a mention of active high or active low on the schematic
> label, however there is listed a 10Kohm pull-up to +Vdd1.833 for the
> circuit diagram of the Micro SD Card. The card holder is referenced
> to
> ground and could reasonably be N/O or N/C switch operation depending
> on
> the exact part selected for manufacture.
>=20
> >=20
> > > +};
> > > +
> > > +&pcie0 {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> > > +};
> > > +
> > > +&pcie1 {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> > > +};
> > > +
>=20
> > > +&phy0 {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rx-internal-delay-ps =3D <=
1500>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tx-internal-delay-ps =3D <=
1500>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0motorcomm,tx-clk-adj-enabl=
ed;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0motorcomm,tx-clk-10-invert=
ed;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0motorcomm,tx-clk-100-inver=
ted;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0motorcomm,tx-clk-1000-inve=
rted;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0motorcomm,rx-clk-drv-micro=
amp =3D <3970>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0motorcomm,rx-data-drv-micr=
oamp =3D <2910>;
> > > +};
>=20
> 'motorcomm,rx' before 'motorcomm,tx' in `LANG=3DC sort` of vendor-
> specific
> properties.
>=20
> > > +
> > > +&pwmdac {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> > > +};
> >=20
> Additional non-default GPIO as listed in the Orange Pi design:
> GPIO21 WIFI_WAKE_HOST_H /* default vf2 function PCIE_PWREN_H_GPIO21
> */
> GPIO22 >> BT_UART_RXD /* default vf2 function MIPI_PWR_EN */
> GPIO23 << BT_UART_TXD /* default vf2 function LCD RESET */
> GPIO24 << BT_UART_CTS /* default vf2 function MIPI_LCD_BL */
> GPIO25 << BT_UART_RTS /* default vf2 function TP_DET_GPIO25 */
> GPIO30 << BT_EN_H_GPIO30 /* default vf2 function TP_INT_L */
> GPIO31 << BT_WAKE_GPIO31 /* default vf2 function TP_RST_L */
>=20
> Of all the above, GPIO21 is defined in jh7110-common.dtsi
> &pcie1_pins/wake-pins and may need consideration.
>=20
> There is a note about "PMIC_PWRON as Key" and so does this have the
> meaning of it is used as an input device?
>=20
> Also noted is that the USB over-current circuit appears to be
> implemented, different than being absent in other VF2 designs.
>=20
> 1:
> http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/service=
-and-support/Orange-Pi-RV.html
> 2:
> https://lore.kernel.org/lkml/20251005174450.1949110-1-e@freeshell.de/
>=20
> With the card detect describing hardware corrected, and clean up the
> vendor property sort, then please confirm if you think GPIO21 is
> described correctly.

Well yes, GPIO21 should be splitted from PCIe pinctrl and assigned to
be the out-of-band IRQ of the Wi-Fi module. My DT omits this because
the jh7110 pinctrl driver is currently not compatible with brcmfmac
out-of-band IRQ code.

Should I add /delete-node/ for it?

>=20
> Acked-by: E Shattow <e@freeshell.de>
>=20



Return-Path: <linux-kernel+bounces-791199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1A4B3B350
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63D927A7720
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6838223BF91;
	Fri, 29 Aug 2025 06:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="UHU7S+XG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="DHgMwMjT"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6E3B652;
	Fri, 29 Aug 2025 06:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756448752; cv=none; b=Idj/fzl+bOXHPT+a/VooopHBSOmSrTulBFVsN0pwWoHZYzyvQ6/jnwuUbEF1Ck+7+QxjRk3DXlUvRCp4o/qTkqzSBfv9zXDioPmxiGgmyIF0bcC7MCTHOstrNf0H+9+AfJTG3MdTMwOot8nStY4tfa749+EANFbXCHHc/lyiRI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756448752; c=relaxed/simple;
	bh=4mASaNuyNpZq/uuuFH6EIKTUa8jjSy7U+2TegnBniOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZWgd+CboegWK7BC6ipl/v4t/SkFEC2HIJGCcR7r8ettbVqYfEdzQcsp4EBLBBN++DbLpW2DdVfgsE4haD07MD5J8+vqvMduOKP4zFmphG0vC8yy5/Ju9OyuQjUzKjyba6Htp30WyxBIuHobLXeexhxSpgSyfHCserXkikN55wvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=UHU7S+XG; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=DHgMwMjT reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1756448748; x=1787984748;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vujtl7k0J0xfsx/gk2sVAPp2kmuOquUNaPtzb/ZzXTI=;
  b=UHU7S+XGr9PiA9l01GZmkp2Z9Hc/VDjEHX1czUQqEh7yTpMzVe948c+9
   4tS647FnMNnS1CdHt63B7IS6c50wrOiAdAe+inxLQorHfF8PRsY1ZNHOe
   L7bHxoetn3MA3LDiHz+ua9/G0x3ZcUrl9I/Hf3UDKvwUVANIhmM+1O4H7
   laavDd/+pyswbcE//ZLIYhTQx2RN9xVV7Yc8f+pfHWGtQrbb4hujvSWbR
   tLDvr2VcNwvL1SikSB6eUAZGOioKPwVdGiDUNVJvhSudJq+jpfN7qobfm
   Rnu7Vt3HYQmojis+l5aGODwmtkaOzEMfjFJwvajOKJiZyWFMrD5k/9nMx
   Q==;
X-CSE-ConnectionGUID: 7Mte/+MUQ0aCJWgneVcnew==
X-CSE-MsgGUID: 4hhVDECaQGuUhjDia+aJiA==
X-IronPort-AV: E=Sophos;i="6.18,221,1751234400"; 
   d="scan'208";a="45969392"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 29 Aug 2025 08:25:45 +0200
X-CheckPoint: {68B147E9-A-299FBAB0-EF52EDE7}
X-MAIL-CPID: 0EBBB9024D966849B3550DCC2AF26C29_5
X-Control-Analysis: str=0001.0A002103.68B14809.0018,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 19848169E37;
	Fri, 29 Aug 2025 08:25:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1756448740;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vujtl7k0J0xfsx/gk2sVAPp2kmuOquUNaPtzb/ZzXTI=;
	b=DHgMwMjT3u7GRd6pIPJTSqLjyMt9OAO/Mk+hxfrNQAVZiv5jarK923RhXkfJ5GGeL2iBUJ
	2HkTAOlITvBZLYiM6nVl6tYrSLgxvNBOumVP4cGr36EL16JVSbwWCN3Y8GOKqIBFrjRRtW
	/9O9pTId20lCaATJGvyUmI0GeswDLGyvUYEStiaRc1OQ3R6yMWHWZEajSBoHCxGTLPr6z2
	GZWMON+INNJoT6NwOrk01aj5wJlltsdGoY1bQbWWecHpt/Lf8H3o6+BiOXf+JngENFTLmX
	+mynaiaeGNm97EZmPi1gk+uDp9WQLIr5/ryMNKMNEwJhYvfUDnmZJE6C/r5vZw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Subject:
 Re: [PATCH 2/2] arm64: dts: freescale: add initial device tree for
 TQMa91xxCA/MBa91xxCA
Date: Fri, 29 Aug 2025 08:25:37 +0200
Message-ID: <2674392.Lt9SDvczpP@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <aLCfTswvqXDLtAhm@lizhi-Precision-Tower-5810>
References:
 <20250828094745.3733533-1-alexander.stein@ew.tq-group.com>
 <20250828094745.3733533-3-alexander.stein@ew.tq-group.com>
 <aLCfTswvqXDLtAhm@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi Frank,

Am Donnerstag, 28. August 2025, 20:26:22 CEST schrieb Frank Li:
> On Thu, Aug 28, 2025 at 11:47:43AM +0200, Alexander Stein wrote:
> > This adds support for TQMa91xxCA module attached to MBa91xxCA board.
> > TQMa91xx is a SOM using i.MX91 SOC. The SOM features PMIC, RAM, e-MMC a=
nd
> > some optional peripherals like SPI-NOR, RTC, EEPROM, gyroscope and
> > secure element.
> >
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> >  arch/arm64/boot/dts/freescale/Makefile        |   1 +
> >  .../freescale/imx91-tqma9131-mba91xxca.dts    | 737 ++++++++++++++++++
> >  .../boot/dts/freescale/imx91-tqma9131.dtsi    | 295 +++++++
> >  3 files changed, 1033 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx91-tqma9131-mba91x=
xca.dts
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx91-tqma9131.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/d=
ts/freescale/Makefile
> > index 947de7f125caf..3a937232d6f29 100644
> > --- a/arch/arm64/boot/dts/freescale/Makefile
> > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > @@ -338,6 +338,7 @@ dtb-$(CONFIG_ARCH_MXC) +=3D imx8qxp-tqma8xqps-mb-sm=
arc-2.dtb
> >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8ulp-9x9-evk.dtb
> >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8ulp-evk.dtb
> >  dtb-$(CONFIG_ARCH_MXC) +=3D imx91-11x11-evk.dtb
> > +dtb-$(CONFIG_ARCH_MXC) +=3D imx91-tqma9131-mba91xxca.dtb
> >  dtb-$(CONFIG_ARCH_MXC) +=3D imx93-9x9-qsb.dtb
> >
> ...
> > +
> > +	pinctrl_jtag: jtaggrp {
> > +		fsl,pins =3D <MX91_PAD_DAP_TCLK_SWCLK__JTAG_MUX_TCK	0x051e>,
> > +			   <MX91_PAD_DAP_TDI__JTAG_MUX_TDI		0x1200>,
> > +			   <MX91_PAD_DAP_TDO_TRACESWO__JTAG_MUX_TDO	0x031e>,
> > +			   <MX91_PAD_DAP_TMS_SWDIO__JTAG_MUX_TMS	0x1200>;
> > +	};
>=20
> Any one use it?

You are right. There is no direct user in DT, but their connection is fixed
to JTAG. I'll hook it up to gpio3, as the GPIOs on these pads belong
to this controller.=20

>=20
> > +
> > +	pinctrl_lpi2c3: lpi2c3grp {
> > +		fsl,pins =3D /* SION | HYS | OD | FSEL_3 | DSE X4 */
> > +			   <MX91_PAD_GPIO_IO28__LPI2C3_SDA		0x4000199e>,
> > +			   <MX91_PAD_GPIO_IO29__LPI2C3_SCL		0x4000199e>;
> > +	};
> > +
> ...
> > +
> > +	/* protectable identification memory (part of M24C64-D @57) */
> > +	eeprom@5f {
> > +		compatible =3D "atmel,24c64d-wl";
> > +		reg =3D <0x5f>;
> > +		vcc-supply =3D <&buck4>;
> > +	};
> > +
> > +	imu@6a {
>=20
> I am not if "imu" is common node name.

Device tree spec name recommendation only mentions gyrometer, but this is a
gyroscope, so I will go with the latter one.

Best regards
Alexander

>=20
> Frank
> > +		compatible =3D "st,ism330dhcx";
> > +		reg =3D <0x6a>;
> > +		vdd-supply =3D <&buck4>;
> > +		vddio-supply =3D <&buck4>;
> > +	};
> > +};
> > +
> > +&usdhc1 {
> > +	pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> > +	pinctrl-0 =3D <&pinctrl_usdhc1>;
> > +	pinctrl-1 =3D <&pinctrl_usdhc1>;
> > +	pinctrl-2 =3D <&pinctrl_usdhc1>;
> > +	vmmc-supply =3D <&buck4>;
> > +	vqmmc-supply =3D <&buck5>;
> > +	bus-width =3D <8>;
> > +	non-removable;
> > +	no-sdio;
> > +	no-sd;
> > +	status =3D "okay";
> > +};
> > +
> ...
> > +};
> > --
> > 2.43.0
> >
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/




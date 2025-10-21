Return-Path: <linux-kernel+bounces-862571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 838CEBF5A36
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D31E83A506B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144BA2EA72C;
	Tue, 21 Oct 2025 09:50:39 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FC11A8F6D
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761040238; cv=none; b=Z7iiMvdvdVDuhWnw4BWGGSXw5g6s0cfWqKlr38anc9JfERRd2PawunjkRWc/02lR1LMywXFXWMRcUXcaLwvv+uMAiUsc/GWUFTdrBfcSnBDoH2eRJjSOgCDriEzwR2c4uIo1Nv2dN+gaZcgOpTg7F5l+zuv35NC5MmPwhkWh48g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761040238; c=relaxed/simple;
	bh=U59wPa1kpEXASCCSExiRaG74dGhaSNDe85YYYgBTIEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5BSJiYVbWHcfv2fcyh8tU0cUj16oqGa88uRE2qdW+DIN0M+sGSBmbOQuxghayI97+tS1rfMgs/sg2yiWSBEcjSG88V2E1x9EtXkTMh5O17eAWo2GQ0MBUbkgLtGBks7Etbylq0qn9FDOV979tozWtnYpzY+6pFwhURk7EUg/9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vB90U-0007Cl-PC; Tue, 21 Oct 2025 11:50:18 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vB90S-004hSx-16;
	Tue, 21 Oct 2025 11:50:16 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 087BF48BFEE;
	Tue, 21 Oct 2025 09:50:16 +0000 (UTC)
Date: Tue, 21 Oct 2025 11:50:13 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org, 
	upstream@lists.phytec.de, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH 2/2] arm64: dts: freescale: Add phyBOARD-Segin-i.MX91
 support
Message-ID: <20251021-bright-brave-dolphin-906891-mkl@pengutronix.de>
References: <20251021093704.690410-1-primoz.fiser@norik.com>
 <20251021093704.690410-2-primoz.fiser@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7y2hkmghfrzgq4ye"
Content-Disposition: inline
In-Reply-To: <20251021093704.690410-2-primoz.fiser@norik.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--7y2hkmghfrzgq4ye
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] arm64: dts: freescale: Add phyBOARD-Segin-i.MX91
 support
MIME-Version: 1.0

On 21.10.2025 11:37:04, Primoz Fiser wrote:
> Add initial support for the PHYTEC phyBOARD-Segin-i.MX91 board [1] based
> on the PHYTEC phyCORE-i.MX91 SoM (System-on-Module) [2].
>=20
> Supported features:
> * Audio
> * CAN
> * eMMC
> * Ethernet
> * I2C
> * RTC
> * SD-Card
> * UART
> * USB
>=20
> For more details see the product pages for the development board and the
> SoM:
>=20
> [1] https://www.phytec.eu/en/produkte/development-kits/phyboard-segin-kit/
> [2] https://www.phytec.eu/en/produkte/system-on-modules/phycore-imx-91-93/
>=20
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../dts/freescale/imx91-phyboard-segin.dts    | 344 ++++++++++++++++++
>  .../boot/dts/freescale/imx91-phycore-som.dtsi | 304 ++++++++++++++++
>  3 files changed, 649 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx91-phyboard-segin.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx91-phycore-som.dtsi
>=20
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts=
/freescale/Makefile
> index 525ef180481d..34a81d34de39 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -344,6 +344,7 @@ dtb-$(CONFIG_ARCH_MXC) +=3D imx8qxp-tqma8xqps-mb-smar=
c-2.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx8ulp-9x9-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx8ulp-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx91-11x11-evk.dtb
> +dtb-$(CONFIG_ARCH_MXC) +=3D imx91-phyboard-segin.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx91-tqma9131-mba91xxca.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx93-9x9-qsb.dtb
> =20
> diff --git a/arch/arm64/boot/dts/freescale/imx91-phyboard-segin.dts b/arc=
h/arm64/boot/dts/freescale/imx91-phyboard-segin.dts
> new file mode 100644
> index 000000000000..bb631439f9cf
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx91-phyboard-segin.dts
> @@ -0,0 +1,344 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2025 PHYTEC Messtechnik GmbH
> + * Author: Christoph Stoidner <c.stoidner@phytec.de>
> + *
> + * Product homepage:
> + * phyBOARD-Segin carrier board is reused for the i.MX91 design.
> + * https://www.phytec.eu/en/produkte/single-board-computer/phyboard-segi=
n-imx6ul/
> + */
> +/dts-v1/;
> +
> +#include "imx91-phycore-som.dtsi"
> +
> +/{
> +	model =3D "PHYTEC phyBOARD-Segin-i.MX91";
> +	compatible =3D "phytec,imx91-phyboard-segin", "phytec,imx91-phycore-som=
",
> +		     "fsl,imx91";
> +
> +	aliases {
> +		ethernet1 =3D &eqos;
> +		gpio0 =3D &gpio1;
> +		gpio1 =3D &gpio2;
> +		gpio2 =3D &gpio3;
> +		gpio3 =3D &gpio4;
> +		i2c0 =3D &lpi2c1;
> +		i2c1 =3D &lpi2c2;
> +		mmc0 =3D &usdhc1;
> +		mmc1 =3D &usdhc2;
> +		rtc0 =3D &i2c_rtc;
> +		rtc1 =3D &bbnsm_rtc;
> +		serial0 =3D &lpuart1;
> +	};
> +
> +	chosen {
> +		stdout-path =3D &lpuart1;
> +	};
> +
> +	flexcan1_tc: can-phy0 {
> +		compatible =3D "ti,tcan1043";
> +		#phy-cells =3D <0>;
> +		max-bitrate =3D <1000000>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&pinctrl_flexcan1_tc>;
> +		enable-gpios =3D <&gpio4 16 GPIO_ACTIVE_HIGH>;
> +	};

I think the tcan1043 is a CAN-FD transceiver. According to the datasheet
it support 2 MBit/s and 5 MBit/s in the "G" variant. However due to the
board layout, etc, the actual bit rate might still be limited to 1
MBit/s. Ask the HW engineers if in doubt.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--7y2hkmghfrzgq4ye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmj3V1IACgkQDHRl3/mQ
kZxWzAf/fxSz9NDY21Y3KxeV/w5epdWrucWsqqjsdEU0ACBO7vaDLgzQBWrWylM3
SbMwTG47o3YVQKQN9VZAz+niqnsspW+Zd5rka7aOkKN0m7omFZ0WZOqiLlURa1Xb
rXCDGM6ac6ZoCR9QBQkOvFjEEdPriF/nF5IUNiL+ks5846ZXclCTvoEjtDTuioxP
3Hjb3c3QyssbVWhUaHrSqnhqasjk54wRXEpnJjylB/Q2Qp5uuaETw2X4J1bowuDf
Z4GCVUwENM2y5kG7PW5Jz4fQgHc+AZJiMBPDQ3viDtZHBNlAJjybRdJE9k/p9ONq
gjwagBiM9rNg3GWhkkg0k8VTAv+5mw==
=pBli
-----END PGP SIGNATURE-----

--7y2hkmghfrzgq4ye--


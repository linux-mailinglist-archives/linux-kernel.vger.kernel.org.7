Return-Path: <linux-kernel+bounces-864414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5A4BFABFD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 513ED1881436
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A09E2FF15E;
	Wed, 22 Oct 2025 08:01:34 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D61D2F25FE
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120094; cv=none; b=F1A24C0qUHTTdKr1nZx8quZUzpxZdmj2mmNgNxGSQXakFaZmKvQ6LwIwLhbmy/iGwh5xsMirO1GA+QBbTEt/BP1thNoDSbjujZY9BjjQCBEdAJaHtJWlzKAW3pY1QVagG++Rr65Diuc0bmG4yezXVBBNfbODFanp+OASHIgu4sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120094; c=relaxed/simple;
	bh=DX3fYqXFMCDwWq5d4+1ozIUsfqgF2xvyZOQEEOGBk7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXNI8eSBjm15U7Q5cmfGIOZRY4Cd3cEjAcuF8MDdOkfEJ0cCiMoLRDmxi/AE/XApDDUOGatFaGcstGNlxOxBWC7S+y0v8BueuMBuOqgeFDdn0gQzcKl5EJRgrL/IxCoLAVPQRh8NoYFu0ycX1jmSM30V/HYMtMs/DRpggWxWUCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vBTmU-0003pK-Pu; Wed, 22 Oct 2025 10:01:14 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vBTmU-004r70-1R;
	Wed, 22 Oct 2025 10:01:14 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2C9EB48CD55;
	Wed, 22 Oct 2025 07:57:49 +0000 (UTC)
Date: Wed, 22 Oct 2025 09:57:48 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org, 
	Maud Spierings <maudspierings@gocontroll.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 4/5] arm64: dts: freescale: Add the GOcontroll
 Moduline IV
Message-ID: <20251022-innocent-micro-reindeer-5baf06-mkl@pengutronix.de>
References: <20251022-mini_iv-v2-0-20af8f9aac14@gocontroll.com>
 <20251022-mini_iv-v2-4-20af8f9aac14@gocontroll.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pxa4q2agib3drh4u"
Content-Disposition: inline
In-Reply-To: <20251022-mini_iv-v2-4-20af8f9aac14@gocontroll.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--pxa4q2agib3drh4u
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 4/5] arm64: dts: freescale: Add the GOcontroll
 Moduline IV
MIME-Version: 1.0

On 22.10.2025 09:22:40, Maud Spierings via B4 Relay wrote:
> +	can@2 { // reg vdd?

What about this comment?

> +		compatible =3D "microchip,mcp25625";
> +		reg =3D <2>;
> +		clocks =3D <&mcp_clock>;
> +		interrupt-parent =3D <&gpio3>;
> +		interrupts =3D <4 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-0 =3D <&pinctrl_can1>;
> +		pinctrl-names =3D "default";
> +		spi-max-frequency =3D <10000000>;
> +		xceiver-supply =3D <&reg_can1_stby>;
> +	};

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--pxa4q2agib3drh4u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmj4jnkACgkQDHRl3/mQ
kZxZwwf+KpjbQgWmUFLp56sny+5XAwlaxkBqCad+kiFnLVez+S26CcuzHSvGHkJk
0Ghc442UXJQhtvqR5HD1mJnVkNr0mTuFW50C+0pt1f1p2M9Efs96f1BVV8UHTS0b
zfsq0rqllhG/oXImasKHusL6OGuthVtZhAIzZAGexKQV6wurz/ZNIPuXpMubrJdP
ZgEMWQkqLXq7aY4H7mM+ly0/S7kVHfQiDTMLZioxAbmjx0iM+OcB47mtFcODM4a7
zbqWwNmXeTq4oVs5ZZgK5+pMPGr8fJpTjotJN+CDF6sv7FXruiOVaA4wXqdFZE7C
3dKbQGybI+GSDvh/u+LsI2bWiawG4w==
=MV+c
-----END PGP SIGNATURE-----

--pxa4q2agib3drh4u--


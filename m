Return-Path: <linux-kernel+bounces-862603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C6ABF5B99
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E0C3AF600
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9312432BF48;
	Tue, 21 Oct 2025 10:14:12 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B705E32BF3A
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041652; cv=none; b=a5PmQ9mdREgtQN6PGNIuOmWZClcyDUweOXdNjbMSfHmvnyHbBXHt0fbKDYYEgGpr+viye73mMQs59/fAa0SJlOk9fyODwGM/+kfxsunB2A9Exr4oIbRMHOqAcnKo1hb4/TFif47YY7TsJRQFP4FAdRR5H+ZK6R0fkAeTNl1vU+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041652; c=relaxed/simple;
	bh=dsc5Kj6LTTA3wr4ulCsW6/BDuF9Of8ATjNvMm2GI0ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMA5+ITDG+IdyXx1A7imOAedu3/tV4APpaAkU21Co66R5ZXM6x2srw+pOd+WGoI42ByEZXA6HmsqhBorvfF7/A/fWFXS1MmCMa59BvowOTeBh9z8sUVOsr+/nIbInmTpB28IhORpJw7YGP7arFBKulcQstCiDsn33nwV1AGT8wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vB9NJ-0002U2-Ke; Tue, 21 Oct 2025 12:13:53 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vB9NJ-004hl8-0p;
	Tue, 21 Oct 2025 12:13:53 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B872848C042;
	Tue, 21 Oct 2025 10:13:52 +0000 (UTC)
Date: Tue, 21 Oct 2025 12:13:52 +0200
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
Message-ID: <20251021-elite-crab-of-spirit-744926-mkl@pengutronix.de>
References: <20251021093704.690410-1-primoz.fiser@norik.com>
 <20251021093704.690410-2-primoz.fiser@norik.com>
 <20251021-bright-brave-dolphin-906891-mkl@pengutronix.de>
 <4979a32f-f938-4956-8293-eca5667bf1c4@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="633ncal4gpk4csrw"
Content-Disposition: inline
In-Reply-To: <4979a32f-f938-4956-8293-eca5667bf1c4@norik.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--633ncal4gpk4csrw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] arm64: dts: freescale: Add phyBOARD-Segin-i.MX91
 support
MIME-Version: 1.0

On 21.10.2025 12:07:13, Primoz Fiser wrote:
> >> +	flexcan1_tc: can-phy0 {
> >> +		compatible =3D "ti,tcan1043";
> >> +		#phy-cells =3D <0>;
> >> +		max-bitrate =3D <1000000>;
> >> +		pinctrl-names =3D "default";
> >> +		pinctrl-0 =3D <&pinctrl_flexcan1_tc>;
> >> +		enable-gpios =3D <&gpio4 16 GPIO_ACTIVE_HIGH>;
> >> +	};
> >=20
> > I think the tcan1043 is a CAN-FD transceiver. According to the datasheet
> > it support 2 MBit/s and 5 MBit/s in the "G" variant. However due to the
> > board layout, etc, the actual bit rate might still be limited to 1
> > MBit/s. Ask the HW engineers if in doubt.
>=20
> phyBOARD-Segin actually uses a TI SN65HVD234D CAN transceiver chip which
> supports up to 1MBps. See [1].
>=20
> However since there is no direct support for SN65HVD234D we model the
> enable signal with the generic PHY driver and use "ti,tcan1043" jsut as
> compatible. Suggested by Frank and you in [2].

hmmm, okay - I suggest to add a comment that mentions the actual
transceiver and that it's a 1 MBit/s CAN-CC transceiver.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--633ncal4gpk4csrw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmj3XNwACgkQDHRl3/mQ
kZy5jAgAs7oItdqTyJWADrxD5vFJF9S4BVEJ17u41fKIp+iMmT0qPT7dOZ20oVH6
UjhrIJmT1goI0Skggzr0Fs4vnhLPA7bsLqMqZM6ZnbawW2+g4iKd13dvR3hHqRSV
c2dE/r6/U+DjaPs+Ijz7zR7FVHd5jyKI83LsDSYBdqNC7QM3RfFYYPTVbURfdhUX
1Es2zmH18iWgSBG3A+Url9o1sWuWQVFNDi6ogNFb8+94kk8YJLnSNyn18Us5p08j
pRgH/U8mlYfziMPSjzvT4hFZNnK/g+Rvdp/VbTjtvY6T94CoQUtvAKod+CHkbcjd
ldrScN+ZDNKPIH6DM0xe4PFTFD5l2Q==
=CrZZ
-----END PGP SIGNATURE-----

--633ncal4gpk4csrw--


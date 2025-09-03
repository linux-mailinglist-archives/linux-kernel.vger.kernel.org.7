Return-Path: <linux-kernel+bounces-798944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA236B424F4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CECBC1BC360F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EAF22259E;
	Wed,  3 Sep 2025 15:17:23 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D27222593
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912643; cv=none; b=Kog4bYJk5J6snTePz9wVCj+qb7q3LAKFbeRbOSbgYjKebd2iTW04i80HI3Y/5f687R+2IS1exuiIb8pUDuiQcsKK9HNyhzmK3qf2JI7U+0d91J6DScuvi4AIwGE2Q/DBWWZb0K16d09dOKvXlaYWGSo4B6VeiaURE9XwjINN85o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912643; c=relaxed/simple;
	bh=fCwJaunZ6z4VKL23zFtkSSgKZVwna4t6if/azimFgS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKd7klKbvAY7Xoa1qsZAoCunLiipSia0hxQOLThNtphfeVDyj1sOrBvXYnwInMypLZqR9Wx1BA530EGdG74vGFbdaJthT4nMBIrB7ISKmUHohLTn9tWHTaF1slOPi0Mp+eRBeIMmjEN5CHfhmNmQRYWRgIAMsGjf0oCCTqZOEVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1utpEB-0006Li-Pb; Wed, 03 Sep 2025 17:16:51 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1utpE9-003a6L-2s;
	Wed, 03 Sep 2025 17:16:49 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 79C52465B63;
	Wed, 03 Sep 2025 15:16:49 +0000 (UTC)
Date: Wed, 3 Sep 2025 17:16:48 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Alexandre TORGUE <alexandre.torgue@foss.st.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ARM: dts: stm32: add resets property to m_can
 nodes in the stm32mp153
Message-ID: <20250903-uncovered-magnetic-marmot-dd7c37-mkl@pengutronix.de>
References: <20250807-stm32mp15-m_can-add-reset-v2-0-f69ebbfced1f@pengutronix.de>
 <20250807-stm32mp15-m_can-add-reset-v2-2-f69ebbfced1f@pengutronix.de>
 <59f25804-d310-4492-b95f-19c42cf3cd42@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="drmik7hqv5i24xa5"
Content-Disposition: inline
In-Reply-To: <59f25804-d310-4492-b95f-19c42cf3cd42@foss.st.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--drmik7hqv5i24xa5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/2] ARM: dts: stm32: add resets property to m_can
 nodes in the stm32mp153
MIME-Version: 1.0

On 03.09.2025 15:10:42, Alexandre TORGUE wrote:
> Hi Marc
>=20
> On 8/7/25 08:09, Marc Kleine-Budde wrote:
> > On the STM32MP153 the m_cam IP cores (a.k.a. FDCAN) have an external
> > shared reset in the RCC. Add the reset to both m_can nodes.
> >=20
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> >   arch/arm/boot/dts/st/stm32mp153.dtsi | 2 ++
> >   1 file changed, 2 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/st/stm32mp153.dtsi b/arch/arm/boot/dts/s=
t/stm32mp153.dtsi
> > index 4640dafb1598..92794b942ab2 100644
> > --- a/arch/arm/boot/dts/st/stm32mp153.dtsi
> > +++ b/arch/arm/boot/dts/st/stm32mp153.dtsi
> > @@ -40,6 +40,7 @@ m_can1: can@4400e000 {
> >   		interrupt-names =3D "int0", "int1";
> >   		clocks =3D <&rcc CK_HSE>, <&rcc FDCAN_K>;
> >   		clock-names =3D "hclk", "cclk";
> > +		resets =3D <&rcc FDCAN_R>;
> >   		bosch,mram-cfg =3D <0x0 0 0 32 0 0 2 2>;
> >   		access-controllers =3D <&etzpc 62>;
> >   		status =3D "disabled";
> > @@ -54,6 +55,7 @@ m_can2: can@4400f000 {
> >   		interrupt-names =3D "int0", "int1";
> >   		clocks =3D <&rcc CK_HSE>, <&rcc FDCAN_K>;
> >   		clock-names =3D "hclk", "cclk";
> > +		resets =3D <&rcc FDCAN_R>;
> >   		bosch,mram-cfg =3D <0x1400 0 0 32 0 0 2 2>;
> >   		access-controllers =3D <&etzpc 62>;
> >   		status =3D "disabled";
> >=20
>=20
> How those reset are handled at driver side ?

I've created a patch that adds a shared reset to the m_can driver:

| https://lore.kernel.org/all/20250812-m_can-fix-state-handling-v1-7-b739e0=
6c0a3b@pengutronix.de/

The reset is de-asserted during probe and when the interface does up,
otherwise it asserted. This way the IP gets reset only when both
interfaces are down.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--drmik7hqv5i24xa5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmi4W90ACgkQDHRl3/mQ
kZw7OQf+IAk77vePmsl5sa2RCJ64dVjof83jSrEidTOll5/fyIaPux6Y/xW/WlOl
r7Jiw9c8rTb66LdAl7QxlV9SthVj3iaD8qIRt3jFOTHtLOVOjuOh6UPP3rdoSSQS
rE/eve4ZibgRYje/9Uzey2lJ2Mybq/qDtexmqzygOngruvvWLe+4BdKHykjQPBXu
TnGA+vSAVZ7Gd0vmbSeL7OWBMLD4i6i5L0SW1O2L5vLVGr7eHSqHp+TAP4Qwd2ls
oJwojmqYInUMNjCsZyDpX+/O60KsA0wlWnp5JCoIM4JwuzDSruI6mBTeChvRdQc4
S2srAIKWU7ZOpyhRiJ0Sq0Jw2hY9Xg==
=u+QD
-----END PGP SIGNATURE-----

--drmik7hqv5i24xa5--


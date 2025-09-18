Return-Path: <linux-kernel+bounces-808433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07460B4FFAA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6226C1C24D76
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B443451B6;
	Tue,  9 Sep 2025 14:38:47 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4458274B35
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428727; cv=none; b=EcvTS5Nkl4qFBl/YTmAbYFMr39UresrY2ii1r5mT1CjRAPB4z6h3w0fL+otYQvWK+BsakwvCQ1CQjP9TEatL9LVJU/XczvT1zjRYNngIwUfopDK0MN9tYfx8g+gloIjkEoJV+I1NEAIiP+AgCrM+77EXyzTlnIG40VizSlGIuUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428727; c=relaxed/simple;
	bh=tJbcx/bk9C54Jm57BJ+fi7rGBD0k9Ovd/v5P+snaFx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJeUi4LFV7dl6FM+dUK9Bf+noh6YPcXmOSbfqetLftQiTE9wbNRX3FVc/NOohUmbhLKQNlJpKx3Z8MlJCNqtgMwln+J0dC+SlmpGjFNuCGwyWyJs45JHsJn86g5kvZiB4fGvnRn9r054sthvf2yQ7DPr7klyOkwWqjroDK1AEII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvzUT-0006Ij-GW; Tue, 09 Sep 2025 16:38:37 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvzUR-000REA-2b;
	Tue, 09 Sep 2025 16:38:35 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 70BAE46A182;
	Tue, 09 Sep 2025 14:38:35 +0000 (UTC)
Date: Tue, 9 Sep 2025 16:38:35 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Patrik Flykt <patrik.flykt@linux.intel.com>, 
	Dong Aisheng <b29396@freescale.com>, Fengguang Wu <fengguang.wu@intel.com>, 
	Varka Bhadram <varkabhadram@gmail.com>, Wu Bo <wubo.oduw@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH 3/7] can: m_can: m_can_handle_state_errors(): fix CAN
 state transition to Error Active
Message-ID: <20250909-curly-rousing-hyrax-d4eb4c-mkl@pengutronix.de>
References: <20250812-m_can-fix-state-handling-v1-0-b739e06c0a3b@pengutronix.de>
 <20250812-m_can-fix-state-handling-v1-3-b739e06c0a3b@pengutronix.de>
 <DC74JEKBB6HL.1LJ53UZJ0T0Q9@baylibre.com>
 <DC74YGSPTL16.KG2SWZD4L3YV@baylibre.com>
 <20250909-nightingale-of-strange-defense-631196-mkl@pengutronix.de>
 <20250909-bulky-wolverine-of-artistry-49749f-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ghylx5zynkmh56yl"
Content-Disposition: inline
In-Reply-To: <20250909-bulky-wolverine-of-artistry-49749f-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--ghylx5zynkmh56yl
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/7] can: m_can: m_can_handle_state_errors(): fix CAN
 state transition to Error Active
MIME-Version: 1.0

On 09.09.2025 16:31:29, Marc Kleine-Budde wrote:
> > > Also looking at all the users added for the function above, could you
> > > read the register inside the function? Currently you are adding a
> > > reg variable and a read call for each call to this function.
> > > m_can_handle_state_errors() also doesn't need the psr value with your
> > > refactoring.
> >=20
> > That makes sense.
>=20
> I'm also preparing the driver to have error handling for all register
> reads...so I'll have to return in case of an error and pass the state
> via a pointer.

This has to wait until a later patch.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ghylx5zynkmh56yl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjAO+gACgkQDHRl3/mQ
kZwNFAf/SxdJiEB4XBelMF6fV6G8aPDd0EYMka2gwKCymQSTVykivv5gfJH+MkQb
jXxjKS8fheQ1bYxbiFTqp6tcPjEuGbaquQj3Ds6w1DDaqYoGx11c7/HWv7w/D6GS
MBCfMGNJqN8m8cVYVsEMivp+2jIHmzm8VIllH4KmkyTZ1lYLVJoJlKAo2zSX1TVB
OKFQ7QArRO1vtpT2Fn9CiAU1fQp0DyeS0erQrHfjsfGdsJGMnUmUHu3YdenIPGzt
mv7/AUuTELlBJrYPkHVtPNyW5NnuwjgFfZ2gWjcxl8F/e8LYEXTIe5kxmH0C0fAn
PfuY4//X7OdD1g/KzxSVhGggrM7LxQ==
=6GXS
-----END PGP SIGNATURE-----

--ghylx5zynkmh56yl--


Return-Path: <linux-kernel+bounces-825124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABA2B8B0C5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170FD1C24B96
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3076727F4D5;
	Fri, 19 Sep 2025 19:08:40 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BC027B352
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 19:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758308919; cv=none; b=U97T/OaJN3171U1tZPZsh9idPFTS5XehX0UEZZPNKwHOKI6kobRfeAfDNjvcM0dyjQiJpjwe6TWhGA2lg6U7saWHg62THVsZMRu59AQu+Yqu4l5UFPEOQ/8v2C1sMnufRgP6gzLfksO5zZemLCbJZjOGPA6vVwTl86nfOFFgCGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758308919; c=relaxed/simple;
	bh=zukaVKtCam3T0s4P5Dx8x5fIeFUMjIn/NWf4ujlgXE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYRquReFru5pu2+bOAauPhRzoT0uSr09TRxD5QpOJPPvtPfM7ayJneKHaONc2YgL9LZZKHv82o1A6Q2k5uqu4oCMLxAnwLP/3yb2xQ5sKZ5IQlaJUfABOTOEuQ/rTckCnwsh7bvFmt6TVGbKCfjGBnCBA5DfqwSMvF32GnVjEe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uzgSv-0002ob-RX; Fri, 19 Sep 2025 21:08:17 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uzgSs-0029dN-2q;
	Fri, 19 Sep 2025 21:08:14 +0200
Received: from pengutronix.de (ip-185-104-138-125.ptr.icomera.net [185.104.138.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 425AF4751ED;
	Fri, 19 Sep 2025 19:08:13 +0000 (UTC)
Date: Fri, 19 Sep 2025 21:08:12 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Peng Fan <peng.fan@nxp.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Aswath Govindraju <a-govindraju@ti.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
	Haibo Chen <haibo.chen@nxp.com>, linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 2/9] phy: phy-can-transceiver: Introduce
 can_transceiver_priv
Message-ID: <20250919-tall-speedy-parrot-8510db-mkl@pengutronix.de>
References: <20250909-can-v6-0-1cc30715224c@nxp.com>
 <20250909-can-v6-2-1cc30715224c@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cd3z7kopob7ivfax"
Content-Disposition: inline
In-Reply-To: <20250909-can-v6-2-1cc30715224c@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--cd3z7kopob7ivfax
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 2/9] phy: phy-can-transceiver: Introduce
 can_transceiver_priv
MIME-Version: 1.0

On 09.09.2025 13:40:12, Peng Fan wrote:
> To prepare for dual-channel phy support, introduce can_transceiver_priv as
> a higher level encapsulation for phy and mux_state.
>=20
> No functional changes.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/phy/phy-can-transceiver.c | 41 ++++++++++++++++++++++++++-------=
------
>  1 file changed, 27 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-tran=
sceiver.c
> index f59caff4b3d4c267feca4220bf1547b6fad08f95..6415c6af0e8414a6cc8d15958=
a17ee749a3f28e9 100644
> --- a/drivers/phy/phy-can-transceiver.c
> +++ b/drivers/phy/phy-can-transceiver.c
> @@ -23,6 +23,11 @@ struct can_transceiver_phy {
>  	struct phy *generic_phy;
>  	struct gpio_desc *standby_gpio;
>  	struct gpio_desc *enable_gpio;
> +	struct can_transceiver_priv *priv;

Can you convert this into a flexible-array? This reduces the overhead of
a 2nd allocation.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--cd3z7kopob7ivfax
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjNqhkACgkQDHRl3/mQ
kZwACgf/b5xzS9pWKSdkZcmVns9SIHHO1d1PGZP3mJEVq1zZWfnBMx0PSJCfosmF
Z6vfc8EMPd+XZhNRcltvC56VojbtsS8DQceTIuWGcShPDtN6gFp5N6MTUXGESNe5
F8ttf96l1LrLZoCsUW+TrBBdHNh6OWxZaOMALi7i3Y9xAqBALu1XAiVZE4VIRpcm
OPENZKma3l0f3nnG7jHqXditf4Uc8Vs0Pjon4iQAvMqOPogZvwwsfi1aV0aBaICA
EBpB5Uk48XiZnSCaOMU1KFnUF+xLqr4IBh0hI4ni/9pazDxJRxQf1790YzHZ2bkF
BnzXsTZF/syHHEADDEP2WXU4PfjefQ==
=4N72
-----END PGP SIGNATURE-----

--cd3z7kopob7ivfax--


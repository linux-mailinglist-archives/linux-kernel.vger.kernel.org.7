Return-Path: <linux-kernel+bounces-731543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C60B05602
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3841A1C21B01
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39BB238C1B;
	Tue, 15 Jul 2025 09:13:51 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422A1277CB0
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752570831; cv=none; b=nPNg/6BNXhVK/D+Xmb0M9UN82XjM65XFJ3bJD3ShEp00UcwolPeqsgJb5U12KCCvonRavKnQoAf8UQOzsTRmoqzygEffGRmdKPBTXMyq6m6J+QDaZmrY6T5+GjlfzHFp4uSLsLD+la7pNl/eH7/SC1uLr5fXm0cZRr6FML8sMwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752570831; c=relaxed/simple;
	bh=xFlEsmZ13trPaTDcVFPmqTAuZfAV+1pOgMgvyjkEvzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jo2AuzY6vOGiextlVO0ScRg8fu59rK6fO9HBn3JrswOANTASLm9dhlsqGzd2xl0VnN5ETFmqBPfw0XUaVKYUazI/4FfbcfGxB8hDjko5HDUJDp0MHLcZKeOavyDjqOXdeMNih+7JMGdBurJASiSApk8eEzZtt1sKEGq6URFNcao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ubbjH-0002Nl-7D; Tue, 15 Jul 2025 11:13:39 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ubbjG-008YZP-2t;
	Tue, 15 Jul 2025 11:13:38 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 90338442245;
	Tue, 15 Jul 2025 09:13:38 +0000 (UTC)
Date: Tue, 15 Jul 2025 11:13:38 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] can: tscan1: Kconfig: add COMPILE_TEST
Message-ID: <20250715-mindful-terrestrial-kangaroo-fc81a1-mkl@pengutronix.de>
References: <20250713-can-compile-test-v1-0-b4485e057375@wanadoo.fr>
 <20250713-can-compile-test-v1-3-b4485e057375@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jpawero34m65362v"
Content-Disposition: inline
In-Reply-To: <20250713-can-compile-test-v1-3-b4485e057375@wanadoo.fr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--jpawero34m65362v
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/3] can: tscan1: Kconfig: add COMPILE_TEST
MIME-Version: 1.0

On 13.07.2025 17:02:45, Vincent Mailhol wrote:
> tscan1 depends on ISA. Add COMPILE_TEST so that this driver can also be
> built on other platforms.
>=20
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
>  drivers/net/can/sja1000/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja1000/Kc=
onfig
> index 2f516cc6d22c4028b1de383baa6b3d3a7605b791..fee9d6f84f5fb9d6a81df00be=
9d216219723a854 100644
> --- a/drivers/net/can/sja1000/Kconfig
> +++ b/drivers/net/can/sja1000/Kconfig
> @@ -105,7 +105,7 @@ config CAN_SJA1000_PLATFORM
> =20
>  config CAN_TSCAN1
>  	tristate "TS-CAN1 PC104 boards"
> -	depends on ISA
> +	depends on ISA || COMPILE_TEST
>  	help
>  	  This driver is for Technologic Systems' TSCAN-1 PC104 boards.
>  	  https://www.embeddedts.com/products/TS-CAN1
>=20

What about making it:

--- a/drivers/net/can/sja1000/Kconfig
+++ b/drivers/net/can/sja1000/Kconfig
@@ -105,7 +105,7 @@ config CAN_SJA1000_PLATFORM
=20
 config CAN_TSCAN1
         tristate "TS-CAN1 PC104 boards"
-        depends on ISA
+        depends on ISA || (COMPILE_TEST && HAS_IOPORT)
         help
           This driver is for Technologic Systems' TSCAN-1 PC104 boards.
           https://www.embeddedts.com/products/TS-CAN1

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--jpawero34m65362v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmh2G74ACgkQDHRl3/mQ
kZzqfAf/TcXcOvU/v+sVRndBbQCyKkNaogG9GlJGV9B5ei3KjSbDeqvjFRgyPg8D
JsJd4ORBkQdmxIJw1Ut+cGgtYFIW4l6DRQVan25MYYOvDll1dK7KP9GewmLgMmW5
GE9Mt9umdks6gz5985gBvQ2uYkxciMwye3LOwopkFQBJKVapCPDEaduKH/Eulkrl
aWwCcENLiMHUfcglIubrftLp88abM+sTHj4UhELRgvqqqiV45+5WJCGBCxlD5sTn
cyJe9LjzkdVaVzk6krNtdeRBDz4NBEIcF/cVEdEYxZOAiXqN0jLBRxx00MyFK+ew
ccz2FISULavsor6TZwfcMs9kBZFODA==
=Zw2z
-----END PGP SIGNATURE-----

--jpawero34m65362v--


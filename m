Return-Path: <linux-kernel+bounces-731628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD8EB05762
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B641C2030E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4378F2D6400;
	Tue, 15 Jul 2025 10:02:14 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20212275842
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573733; cv=none; b=bBnU5vqtUu/jG8QG1e70Rn/rA0gWrAxCeMsGuMx9uHDEG/2i3aO9EyLsL9OSlEoND0KoNUtn3Zq663vooZAN5xNBaJMsJ15yKsl98OXYFziG2U7eXPQVkeU7buw1quWzj7WZ1YoyJZEwoWgPYT3WcsbB/+ODBqOwhf+NUFQnLAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573733; c=relaxed/simple;
	bh=1A9AtEKtqyNojWbKx33p64sqyxzakVmACsMeQxa7Q3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjSV8iauO0WxVyPGPfl/HpOLReQYvt5CswJDAfqa9huXCCx7/faqY95O5sS86lyxWKYL/fxtzKV2nihh5os/0v7Kukazj4/xCRVGH/taXRuWs0HBTtTZ4QLTMQBN7TchtfdFGjt/nVJoafxADMY9C3WIeUkMAq51WwdQMVcdlbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ubcU9-0002y3-ND; Tue, 15 Jul 2025 12:02:05 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ubcU8-008YuP-2z;
	Tue, 15 Jul 2025 12:02:04 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 94B414422C9;
	Tue, 15 Jul 2025 10:02:04 +0000 (UTC)
Date: Tue, 15 Jul 2025 12:02:04 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Brett Werling <brett.werling@garmin.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, bwerl.dev@gmail.com
Subject: Re: [PATCH v2] can: tcan4x5x: fix reset gpio usage during probe
Message-ID: <20250715-eccentric-mussel-of-glee-bcdb1c-mkl@pengutronix.de>
References: <20250711141728.1826073-1-brett.werling@garmin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uhlfl7r7mit5ljul"
Content-Disposition: inline
In-Reply-To: <20250711141728.1826073-1-brett.werling@garmin.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--uhlfl7r7mit5ljul
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: tcan4x5x: fix reset gpio usage during probe
MIME-Version: 1.0

On 11.07.2025 09:17:28, Brett Werling wrote:
> Fixes reset GPIO usage during probe by ensuring we retrieve the GPIO and
> take the device out of reset (if it defaults to being in reset) before
> we attempt to communicate with the device. This is achieved by moving
> the call to tcan4x5x_get_gpios() before tcan4x5x_find_version() and
> avoiding any device communication while getting the GPIOs. Once we
> determine the version, we can then take the knowledge of which GPIOs we
> obtained and use it to decide whether we need to disable the wake or
> state pin functions within the device.
>=20
> This change is necessary in a situation where the reset GPIO is pulled
> high externally before the CPU takes control of it, meaning we need to
> explicitly bring the device out of reset before we can start
> communicating with it at all.
>=20
> This also has the effect of fixing an issue where a reset of the device
> would occur after having called tcan4x5x_disable_wake(), making the
> original behavior not actually disable the wake. This patch should now
> disable wake or state pin functions well after the reset occurs.
>=20
> Signed-off-by: Brett Werling <brett.werling@garmin.com>

Thanks for the patch, applied to linux-can, added stable on Cc.

regards,
Marc

PS: start a new thread for a new version of a patch, don't reply to the
old version.

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--uhlfl7r7mit5ljul
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmh2JxkACgkQDHRl3/mQ
kZyUKwf/fzgUhDq+R3SLvnlr3TrORtyBtTta83SV0nEe81bxBv30L0Kpf+vAwtr7
gRFoAJyWoeYdBOkU2AenukA/8nwV7Fj2T+FYebRDGhHJtuejE++M40rjN8AR11pi
H4COPafDMppkb9UHHufk8xZhmNs+ybDPmG5HJP9oWC1SrU1F+/geL/eLyQ2yD2pe
F0yxlALILnRi3mpl6566ms7TbLKxuCjh5FkLEmXUEC9SjE1qfmmV0jGm6bwqYIAC
qeMBCXJ60x09VoWCbleMks9qVEsKDW7uFG9h1pMTqsJUgC18cFCsCtnYd7o70bWG
pjs7RBsu+PGA6pmA+6ByOWRCZxduxA==
=P3PN
-----END PGP SIGNATURE-----

--uhlfl7r7mit5ljul--


Return-Path: <linux-kernel+bounces-808081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D68B4ACF0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF2027B6FB3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0243203BE;
	Tue,  9 Sep 2025 11:54:16 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F4330ACE8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 11:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418855; cv=none; b=F2P4gVgi4Qa/2Uw4daoIIcd7Sa/dXDQvkgbBhHUFmU2OzeTXrifgGMJmE4nzKNigfEkwEBij7U6/QWFOaFMpcCe4ZC+1t67a6iFBYMuMA6yTlldwLzQya66CMfdlGygE41SwaPcuBkmWmAfDVBxwd0d+EqaMXuiEUYZ7Vk7BmyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418855; c=relaxed/simple;
	bh=9ba5ex7bxof/jGqA6YT3kw+LuTDvHMYtOk7qPh7zAXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXWPIGjcGjfuMhEQ84KyjJFWrA2yYeyu2ZO0dF9zfCJ+jPqV21XT/wdlg04e9WoD+t2UQa3viZa+Nl5d9iRfh4UASMyjLY/OYiqbJUzcc3gOmQ0nwVjYl+GgnsfgU46gOm40LInzWwhGF5LpCwJVM+ccMS076bDNWy4ugPk/Pxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvwvI-00056N-I9; Tue, 09 Sep 2025 13:54:08 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvwvI-000PeB-07;
	Tue, 09 Sep 2025 13:54:08 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A38CB469E9B;
	Tue, 09 Sep 2025 11:54:07 +0000 (UTC)
Date: Tue, 9 Sep 2025 13:54:07 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Robin van der Gracht <robin@protonic.nl>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Maxime Jayat <maxime.jayat@mobile-devices.fr>, Elenita Hinds <ecathinds@gmail.com>, 
	Bastian Stender <bst@pengutronix.de>, linux-can@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] can: j1939: undo increment when j1939_local_ecu_get()
 fails
Message-ID: <20250909-debonair-imported-salamander-83976f-mkl@pengutronix.de>
References: <e7f80046-4ff7-4ce2-8ad8-7c3c678a42c9@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v2sis5grc7frigxp"
Content-Disposition: inline
In-Reply-To: <e7f80046-4ff7-4ce2-8ad8-7c3c678a42c9@I-love.SAKURA.ne.jp>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--v2sis5grc7frigxp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: j1939: undo increment when j1939_local_ecu_get()
 fails
MIME-Version: 1.0

On 24.08.2025 19:27:40, Tetsuo Handa wrote:
> Since j1939_sk_bind() and j1939_sk_release() call j1939_local_ecu_put()
> when J1939_SOCK_BOUND was already set, but the error handling path for
> j1939_sk_bind() will not set J1939_SOCK_BOUND when j1939_local_ecu_get()
> fails, j1939_local_ecu_get() needs to undo priv->ents[sa].nusers++ when
> j1939_local_ecu_get() returns an error.
>=20
> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Applied to linux-can.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--v2sis5grc7frigxp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjAFVwACgkQDHRl3/mQ
kZxtuQf9EhwJI5VXwsR+eR2lGqa0QJHSdvWhmvT8qZxHu6vLBFTMBVpwCrqrwNnZ
wELLEoLOtEX+0WBEBTQm8yQXUGO1fnF/DW52uZBnEilYLybi1bQbhXN+KFu2DCnT
Cef12zuUCte9ISH8gj/Coi988YNPycaA5apXW2tTbrYDwYX68OF/8jfTKXvtutkC
7kLrXccpWDcZvmHZEEvnZwado8J2avPRkMLbINv/CDVHlusJAhQGuXdvrLsC9/dI
kDPRQ8RmRjo/eQA2bCuewo9ldxztoaA+YJ0gNqTBPJVNC45ohlIUetECTiWW5B/U
nCzy8rNRgHcNzNMRbP3tvPx67h2DYA==
=bUhd
-----END PGP SIGNATURE-----

--v2sis5grc7frigxp--


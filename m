Return-Path: <linux-kernel+bounces-825114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 631E9B8B03A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 20:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331241C27A8D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D31E25C6FF;
	Fri, 19 Sep 2025 18:58:16 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5541E5B7B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758308296; cv=none; b=lK/McgDuKuAsHhZuCOvbgCCoEcNC9cdCJiwWZwFUJey3Zr0ZUYdobFroSda4Hv75X90PXR31l4hubcStB9Harui/l/P04X+7UYrW1nK7rUe0WznZwmqLXRD+1WwK7hL2nSNext03W+a/U9SdaOF4IEawWiiKoqqP6pKySQpJElo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758308296; c=relaxed/simple;
	bh=22xxRxgSEiW7bx4yw7KNmPDtMS1Y+vlZbxbxWt2b2Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAbPTI/XgOCv7dccNJ06wCOsRVj9njHokqzBNgKT0N674MA1Wxbf1XfCX6mmZm6O2XhRL73AHzHWEDqUdFkwICFJt0jC8RvJZ3+BrTrTseVEqfPHyiYJdo5w/VyvbG7BpHEErF95/5aoJHaWbcmrbd4O7MlaJ36oypW0jtuKy5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uzgJ4-00018c-C0; Fri, 19 Sep 2025 20:58:06 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uzgJ3-0029MG-2n;
	Fri, 19 Sep 2025 20:58:05 +0200
Received: from pengutronix.de (ip-185-104-138-125.ptr.icomera.net [185.104.138.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A5BEE4751CC;
	Fri, 19 Sep 2025 18:58:04 +0000 (UTC)
Date: Fri, 19 Sep 2025 20:57:59 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v2 0/3] can: raw: optimize the sizes of struct uniqframe
 and struct raw_sock
Message-ID: <20250919-tiger-of-angelic-fragrance-f0668e-mkl@pengutronix.de>
References: <20250917-can-raw-repack-v2-0-395e8b3a4437@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yss2kkbwctpngcbc"
Content-Disposition: inline
In-Reply-To: <20250917-can-raw-repack-v2-0-395e8b3a4437@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--yss2kkbwctpngcbc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/3] can: raw: optimize the sizes of struct uniqframe
 and struct raw_sock
MIME-Version: 1.0

On 17.09.2025 13:48:23, Vincent Mailhol wrote:
> A few bytes can be shaved out of can raw's struct uniqframe and struct
> raw_sock.
>=20
> Patch #1 reorders struct uniqframe fields to save 8 bytes.
>=20
> Patch #2 and #3 modify struct raw_sock to use bitfields and to reorder
> its fields to save 24 bytes in total.
>=20
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--yss2kkbwctpngcbc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjNp7MACgkQDHRl3/mQ
kZw0xAf/bE1DlddEsYjaj6ZylsJ6/TyZIt4ovZqmFntLwZiBPips/kLdEIQ6YlP4
Mp79cf/B02EEklCXmjxcTmdhwqZhuoYDY5MFioxoNvzS5/Dja2G4UwRn/LXAu+5P
dHJmBVTqRqXJyUr0pa41/Jzg2eTkkbh+IkJQMckn4cebFhz3ARpZn9lsw8LEeTSY
9mkMB3SP4oB57DaXavkw5hVRiyiZoZThZJZRCWA/RcUeeRlSePuuxKbYCh6AXKGL
u5X5KjEauOWOXZiukyV7YRg4i6jLiEFsSChi8KimZVPiQtImG9iwEw7+GaiteQxQ
IthKouXkA97d9wJ5mqBgA6nQXYkrfA==
=QMRM
-----END PGP SIGNATURE-----

--yss2kkbwctpngcbc--


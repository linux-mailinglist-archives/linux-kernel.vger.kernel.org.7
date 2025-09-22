Return-Path: <linux-kernel+bounces-827443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 169C6B91C80
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0F02A63C3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0431C281503;
	Mon, 22 Sep 2025 14:43:32 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D672727F010
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758552211; cv=none; b=GZ3ePZcffA+HqoyJea656eok02gSJ5Nn1AFvxKN1GBxHPjgbvi1JAuXWo7N2t7MOuUbk8IBqS5EmKpL18zh6/pbVPQkBFEQRh5ZM1jk7P82QA3ATnu2iZBeQqFKWmTjqHLm94zfI3RHFqw32+dcNjZvY9HYX3E6vewZaIBOVyis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758552211; c=relaxed/simple;
	bh=K3RBSQTM49KUNjw2CtBsyB/PryLCH1PizWHUGDJdndQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFE88x575hJ1JSEZbMzUSUjBfqUfZBwpics2hE63XDgz+6623kQLY0I/IYL5a34+siObk3pGkGPRI+DZYaRpsbIpsjaMvhx7+X9Nc2wXDAl/29rVbPQ8q8xE63hppjgSawb0LQ6fiep1QnCvhiANQ+HP3NML9pgddrLlw9WDBOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0hkx-0002M5-Lq; Mon, 22 Sep 2025 16:43:07 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0hkw-002bxt-0S;
	Mon, 22 Sep 2025 16:43:06 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B7A84477169;
	Mon, 22 Sep 2025 14:43:05 +0000 (UTC)
Date: Mon, 22 Sep 2025 16:43:05 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, 
	mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com, 
	Gregor Herburger <gregor.herburger@ew.tq-group.com>, mani@kernel.org, thomas.kopp@microchip.com, 
	mailhol.vincent@wanadoo.fr, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linus.walleij@linaro.org, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/6] can: mcp251xfd: add gpio functionality
Message-ID: <20250922-magnetic-dashing-piculet-97f38d-mkl@pengutronix.de>
References: <20250918064903.241372-1-viken.dadhaniya@oss.qualcomm.com>
 <20250918064903.241372-6-viken.dadhaniya@oss.qualcomm.com>
 <CAMRc=Mf2ycyKbL35bdy5m1WBEap7Bu8OO2Q9AdZYgc04Uynf8g@mail.gmail.com>
 <20250918-daffy-steady-griffin-5299ac-mkl@pengutronix.de>
 <CAMRc=Mfypwopu6daCBzg90i98dbO-7rwAehkiNkA-tF074fO5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ypln7uuzn6d5ihga"
Content-Disposition: inline
In-Reply-To: <CAMRc=Mfypwopu6daCBzg90i98dbO-7rwAehkiNkA-tF074fO5w@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--ypln7uuzn6d5ihga
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 5/6] can: mcp251xfd: add gpio functionality
MIME-Version: 1.0

On 22.09.2025 16:28:53, Bartosz Golaszewski wrote:
> > > You must be rebased on pre v6.17 code, this will not compile with cur=
rent
> > > mainline.
> >
> > You mean "post" v6.17? Best rebase to latest net-next/main, which
> > already contains the new signatures for the GPIO callbacks.
>=20
> No, you read that right. The signature of the set() and set_multiple()
> callbacks changed in v6.17-rc1 so Viken must have rebased his changes
> on v6.16 or earlier.

I'm not sure if I understand you correctly. This series must apply on
current net-next/main, which is v6.17-rc6.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ypln7uuzn6d5ihga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjRYHQACgkQDHRl3/mQ
kZzA6AgAj6Har03pBSaJ0EP40FYACFmmLHSn/M7nPaKldDVQIdZ9W+RoQqD2mH9W
XqbMfcRH1zvXHR0LKF+plVRcgDaZyU0vae0Ioo+gGk+2hMC3ii8oH29fwPioViKB
nRgCY0ml8TsXbiXI5h5M71ktH4fOU+73/hunXWEE9HyplHocxI42VKDsIezK+MTq
rKCpttTl/akUcwqrYdm7cUYnabY3SAueM+Cd3pOa0fgQeeazvdP2GHvNv/XYnou+
mah8lhU24Lw5uD8rHjgbT8T1eFz8QEK6JQP7NJwz9y9rG4NVEp6NsQz88nNCw8Hr
9YV7uShd8zrW30tshJnPoqACXO453A==
=bdKu
-----END PGP SIGNATURE-----

--ypln7uuzn6d5ihga--


Return-Path: <linux-kernel+bounces-861207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E07BF20FC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9116634DAD2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92843261B8A;
	Mon, 20 Oct 2025 15:19:41 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518FC24678F
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973581; cv=none; b=fyFRNcEJNdAYLZbwgPZCWuAseJPCqR75ZqU59SYOT1aO8TR9Pc2Fl9u/YVbb1gutbYPhR8P9y07twrWNigYDEe09YZF0EjRJIhKia1Rw8Anxhoz4TLrhyTIt6PmZKcSRzASL1JIlihESoC44zXgB2s3neHgmG/JL7m7Tu7wvEiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973581; c=relaxed/simple;
	bh=uMdCdtg2XwrNpIZ0CZDdsSCMjnFtL/9gXjdaZQV05ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjT2IwkV95TjzzzNnEWN/lKNhDg1KTwHA4vHIQkRustpkLslCA7eiNJJm5ChFIVIVdVRVM7M/UmdPdUV1QK9D92cjL4XtCL0ZgpWxdSe2ZoC9aXiHtQ2fuH6cpXpFnAugxcQCKNO6bBHyUNW11C094QrWpothpFy/7ZGIxiFQDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vArfT-0003vB-7G; Mon, 20 Oct 2025 17:19:27 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vArfS-004ZTW-1I;
	Mon, 20 Oct 2025 17:19:26 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1DBDB48B56C;
	Mon, 20 Oct 2025 15:19:26 +0000 (UTC)
Date: Mon, 20 Oct 2025 17:19:24 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
	Vincent Mailhol <mailhol@kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>, socketcan@esd.eu, Heiko Stuebner <heiko@sntech.de>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH can 0/3] can: drivers: drop skb in xmit if device is in
 listen only mode
Message-ID: <20251020-electric-dramatic-cow-e8178b-mkl@pengutronix.de>
References: <20251017-fix-skb-drop-check-v1-0-556665793fa4@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l5m4fvbx7vmqre5l"
Content-Disposition: inline
In-Reply-To: <20251017-fix-skb-drop-check-v1-0-556665793fa4@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--l5m4fvbx7vmqre5l
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can 0/3] can: drivers: drop skb in xmit if device is in
 listen only mode
MIME-Version: 1.0

On 17.10.2025 16:59:58, Marc Kleine-Budde wrote:
> I notived that 3 drivers (bxcan, esd and rockchip) use the function
> can_dropped_invalid_skb(), that doesn't check if the device is in listen
> only mode. This series converts these driver to use the new
> can_dev_dropped_skb() function.
>=20
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Applied to linux-can.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--l5m4fvbx7vmqre5l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmj2UvgACgkQDHRl3/mQ
kZwysQf7BA83gk3POJDewYtZEMQHNZnob1qHnopUO8DyF+bSAr7qCymLLwpj2R7p
shOie/EQ8QeEeWPeVYQS4u1kjbO5xRtQ8bmQCgDcOnpg6JXX/zZ9/8yGgeJhzMoo
aE7MnZEV1C9jA5MVXNVyfCGtAJizWWPHyf5R8mwDSqAJmm3UlXtx8UEL8b7tCaEB
Hhg/LmIL2BLWZC9l+IS78R8CUFRKVq3RjLK2nyzCb4SYGJfuxXzoF2rQUBGseTL+
MFPb1SW/15f2f2GJzdqPdgW2nhy2S7NxGrWCqs+J27GTySr20aW4poTMBtU7+KvL
U+/LpZDPJ1qd4ljdZ8WxHeUiaWQ++A==
=5pMM
-----END PGP SIGNATURE-----

--l5m4fvbx7vmqre5l--


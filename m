Return-Path: <linux-kernel+bounces-825006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74984B8AB12
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0C6D1BC36E7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2B23218A3;
	Fri, 19 Sep 2025 17:05:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C965320A29
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 17:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758301527; cv=none; b=GnwoOFewAmL+ek2ytq6N0UtzGhMzQgGWaQpkBRzwm2FOIOCi7i4Gz66+Wh268Pl2scUBoXE0VJ6aothegTLFQdjzeoLLk/0bqdLlsvoH62DRfDhC3M8QyymbVlfmRWtEjEc1t+kD5DQa+zUHrRZziFPz56JXfcQToG5kcLjxyq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758301527; c=relaxed/simple;
	bh=Mvxr5986z8SC05lluub2hgg11scs2HtbyBBn90Ioodg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lI7mc8IE1ivrUqpV9kbnAqmoxJwp/c/eU42oiFrM7U7uNj71CHzFJSlYH8aWP+Z3DzkD2aUTAbkTWytw45jWbuucfj0OIbOWQ/1GdU2TClqBlJmJAiAV2lkKbV//Hl6H8Kb302ft5gpQQ/r9wfg5j62PVHOPrua8opAOSdROHjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uzeXP-0001QP-4w; Fri, 19 Sep 2025 19:04:47 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uzeXK-0028ck-2G;
	Fri, 19 Sep 2025 19:04:42 +0200
Received: from pengutronix.de (ip-185-104-138-125.ptr.icomera.net [185.104.138.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BB2044750C5;
	Fri, 19 Sep 2025 17:04:40 +0000 (UTC)
Date: Fri, 19 Sep 2025 19:04:39 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
	Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>, Akshay Bhat <akshay.bhat@timesys.com>, 
	Wolfgang Grandegger <wg@grandegger.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Ripard <mripard@kernel.org>, Gerhard Bertelsmann <info@gerhard-bertelsmann.de>, 
	Yasushi SHOJI <yashi@spacecubics.com>, 
	Remigiusz =?utf-8?B?S2/FgsWCxIV0YWo=?= <remigiusz.kollataj@mobica.com>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 0/4] can: populate ndo_change_mtu() to prevent buffer
 overflow
Message-ID: <20250919-portable-rat-of-dew-32b5e9-mkl@pengutronix.de>
References: <20250918-can-fix-mtu-v1-0-0d1cada9393b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="idh7qp6reuygcmse"
Content-Disposition: inline
In-Reply-To: <20250918-can-fix-mtu-v1-0-0d1cada9393b@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--idh7qp6reuygcmse
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/4] can: populate ndo_change_mtu() to prevent buffer
 overflow
MIME-Version: 1.0

On 18.09.2025 18:00:23, Vincent Mailhol wrote:
> Four drivers, namely etas_es58x, hi311x, sun4i_can and mcba_usb forgot
> to populate their net_device_ops->ndo_change_mtu(). Because of that,
> the user is free to configure any MTU on these interfaces.
>=20
> This can be abused by an attacker who could craft some skbs and send
> them through PF_PACKET to perform a buffer overflow of up to 247 bytes
> in each of these drivers.
>=20
> This series contains four patches, one for each of the drivers, to add
> the missing ndo_change_mtu() callback. The descriptions contain
> detailed explanations of how the buffer overflow could be triggered.
>=20
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>

Added to linux-can.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--idh7qp6reuygcmse
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjNjSQACgkQDHRl3/mQ
kZybWwf/dkqGg8VI+ORuB/Iv9jFds/SZ0a+AmPu0ZAlenrV4u1OLUBbd2avtEd+T
KaYO6CuAzlpTZP6vx6S3XQ1M0qy4Z5EtQbgbrVETQ/Z6ZN106WXaOj7iYrGkWc4V
CvSbll8GBD2cP0qQrR+2DAV27Z7UHty6U1qOfqb8y0afoeqh1Bhq3ODivlAtejuE
azZd1kmiX5HdWUD2d7GQBiAZ6cBDWH70C5oMYaH7J9kiCiHKt4yqL1R1o2tlc6n7
WN3xrUIERmq9aM9x7Dh2+67tnEnfZdL10uFxUIq6Z9USZR8hn/oEI/2lOk5Fd3ZK
inQU0iQq8JWngpplUukaDeiKO/EitA==
=2zvn
-----END PGP SIGNATURE-----

--idh7qp6reuygcmse--


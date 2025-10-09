Return-Path: <linux-kernel+bounces-846449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48453BC80B2
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C99383A4EC8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938EA2C08C4;
	Thu,  9 Oct 2025 08:27:15 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7A22737F3
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 08:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759998435; cv=none; b=TlthDIeVwrTZFIg2Yw+Dvw9VpOxmYAQdDqzNWmn7ZgUUHsbd7OYrAcMldQ03gXTzrdBDnGz8pR+uFyiPMlSdgqmE3fPjjsOU1wp17pY5c8RqJ9kZkLZmlfhLWmC8YeAUAkVptweNV1iml5DlsREBU6R41WjFUDWta/miMibKGV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759998435; c=relaxed/simple;
	bh=4v03PRyya9H13ISccbgwKK2b0f7Dk91ukxlna6sRciQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jH9/ISbWdRsqntSumDGYCyolWqRXB5jETzK71bQPOkrgiCbT4MeskplGiZ6H7KWA4TfECyBIU+CCQQDKLg+I9goYX3r6fUXFidLG8ocvXTYjaL/Db2F9eQ4WIGtrh9YUXgCqieU754zS7Z+/VZ7ck/d+MAXj6r+PunODlw05Wzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v6lzP-0002mW-0m; Thu, 09 Oct 2025 10:27:07 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v6lzN-002hby-3B;
	Thu, 09 Oct 2025 10:27:06 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A5A59482712;
	Thu, 09 Oct 2025 08:27:05 +0000 (UTC)
Date: Thu, 9 Oct 2025 10:27:05 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH] can: m_can: replace Dong Aisheng's old email address
Message-ID: <20251009-beautiful-stallion-of-recreation-c94f09-mkl@pengutronix.de>
References: <20251009-m_can-update-email-address-v1-1-30a268587f69@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6givv3sh7ore44x3"
Content-Disposition: inline
In-Reply-To: <20251009-m_can-update-email-address-v1-1-30a268587f69@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--6givv3sh7ore44x3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: m_can: replace Dong Aisheng's old email address
MIME-Version: 1.0

On 09.10.2025 10:18:06, Marc Kleine-Budde wrote:
> Dong Aisheng's old Freescale email is not valid anymore and bounces,
> replace it by the new NXP one.
>=20
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Added to linux-can.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--6givv3sh7ore44x3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjncdYACgkQDHRl3/mQ
kZxqQwf/RH9vKamxKcmcom0mQFvdaahSjuhiJAM/l6rSzCxmW9HKn4GxjbJUjvGw
/M303eR1ITxwAvOWGay49CZzMgi5UW5iHPCEvy0ejwTFhaqU7KkuMRbObZeIsFFg
48QKtFRJWTqD0m7jQhkcY+5X/0pBplrPuNr/RRuvkjYOjOV10t/XXP4z29YNtIln
OJs02dyMlST/BuEiAZcA5KD3bwL8NH2sE/62ypxM7TLBdMoNRdS/s+AqSOGDPu6d
m3sSmnkzvw9jPSFT7Y8OWkY025bttm6oj8JkgStlzO+N9NZ68YclvfKG+Rr4hrAT
idOPsUjzayYB9TGGAGjh9qMMKVZeXQ==
=MjRP
-----END PGP SIGNATURE-----

--6givv3sh7ore44x3--


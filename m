Return-Path: <linux-kernel+bounces-845298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 54562BC44DE
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 12:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 14D1A3508FE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 10:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF8E2F5A27;
	Wed,  8 Oct 2025 10:26:16 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABF52E7BDC
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759919176; cv=none; b=AiTbBG+ObURvHA0iBbTwM8RxcnFysJ50gmLu+hBQcV6InGeg7I4wAcHsqBqvuA+C5KkNhUHpgAptuRlx+5q/cJZJaMeRGyfCNxeemW7DFPFK7YoZUmLDeV2hCigxpS8hjn9lkTEWGkuVyDJSL+Zf9uUWZmauM6oxoglB3tBXcOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759919176; c=relaxed/simple;
	bh=8e4GtOGwLNtNYMyRuJH/zOs6vcWAe0nSXiODYBZDqME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtKfY01SCzgM6NmZB+bBB3tysH00IDk/7+9QPXs66PSoCWJxEX82NdYC5qYdb2FdU+gfAyvYIc2w0fF94dfGfrSkQIMyD5Ae46NlUgrsduqOIEXE5xyjjwDtM0hKYjw5b9tnCE2loCcH1WErTmG07TloT0fiaf2GAicS3V5usS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v6RN0-0001Fs-AM; Wed, 08 Oct 2025 12:26:06 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v6RMz-002YHx-0a;
	Wed, 08 Oct 2025 12:26:05 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C90E9481DE0;
	Wed, 08 Oct 2025 10:26:04 +0000 (UTC)
Date: Wed, 8 Oct 2025 12:26:04 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@pengutronix.de, Markus Schneider-Pargmann <msp@baylibre.com>
Subject: Re: [PATCH can-next] can: m_can: add support for optional reset
Message-ID: <20251008-sweet-quartz-sambar-d0674c-mkl@pengutronix.de>
References: <20251008-m_can-add-reset-v1-1-49f0bbf820c4@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="peaurnzs33mpuzce"
Content-Disposition: inline
In-Reply-To: <20251008-m_can-add-reset-v1-1-49f0bbf820c4@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--peaurnzs33mpuzce
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next] can: m_can: add support for optional reset
MIME-Version: 1.0

On 08.10.2025 11:38:30, Marc Kleine-Budde wrote:
> This patch has been split from the original series [1].
>=20
> In some SoCs (observed on the STM32MP15) the M_CAN IP core keeps the CAN
> state and CAN error counters over an internal reset cycle. The STM32MP15
> SoC provides an external reset, which is shared between both M_CAN cores.
>=20
> Add support for an optional external reset. Take care of shared resets,
> de-assert reset during the probe phase in m_can_class_register() and while
> the interface is up, assert the reset otherwise.
>=20
> [1] https://lore.kernel.org/all/20250923-m_can-fix-state-handling-v3-0-06=
d8baccadbf@pengutronix.de
>=20
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Added to linux-can-next.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--peaurnzs33mpuzce
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjmPDkACgkQDHRl3/mQ
kZy3sAgAg4duD/j3/thQ5pBYAyXbDoi/i/moM87NTcaNAkYVcX4kYLHQWExURjxz
RLNqAeJLGFoSTl4gHWmK6PrgoaKam5uyQsZFks0N3jwr0/j/z9HIIvg5M2kMaoNY
keeMnAJAHmS/A9vv0TeXd4Fsv2YCbFKgEUEgqC0TX4+XaaVLJEHw07hWM0/otct8
twhCGSGvPd84FbKmtQW4ei4Fm2F/Rw98WH1GUGcwpmWw8H5eC2yASLlxRh57qZtj
sJ7Q8R9ByGiX5wvcSKb5sxgWXCC7j9s2RosEK+Yr1dwWhJSkPxRuyuPZRYbXsHTb
X8wXVokyP5/Xwkln+z+cyJV7HQrONw==
=symG
-----END PGP SIGNATURE-----

--peaurnzs33mpuzce--


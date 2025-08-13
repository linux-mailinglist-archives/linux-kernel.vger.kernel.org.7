Return-Path: <linux-kernel+bounces-766158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFE5B24301
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E93472679B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4B02DCF5A;
	Wed, 13 Aug 2025 07:44:59 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6255A2D0623
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755071098; cv=none; b=b6nOKOFzLyx0Fqjzr3lewlsOdDKGN9EiZ1gD4ambwYvnk2maAHCMOhaxwRfeM7LpXTKejUizvQOdFB6LoQEc4DsrvWVHO1AVC0CCp6Gt5plKLarX+DurqhObkhWU2T8r1tlr0lXirB7N4SgjqVHoA+lqSdq6GbW3oH+XQm4Axqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755071098; c=relaxed/simple;
	bh=koPY2s0L8sA1lIhOUhIScD7xdjwz5oz7ltE7vaBqHIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3R8PalceTCUnmCwVPxzjWUMdPGPMD9/I+yntqj/gA6u596JXHh5+U+rNqLPkjwl6ZfT3PxIBc96gzv+W9OBiSoZsefWUi+S2gZpZ7A2pmsfPOaFGT2FIV0/H2ApDOhnLDpC6ILrDk6ncBMNYsJUg6NFs6e3XSGSPylEoDSos14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1um6A1-0005h2-SD; Wed, 13 Aug 2025 09:44:37 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1um6A0-0003S0-02;
	Wed, 13 Aug 2025 09:44:36 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 95B80456809;
	Wed, 13 Aug 2025 07:44:35 +0000 (UTC)
Date: Wed, 13 Aug 2025 09:44:35 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Vishal Mahaveer <vishalm@ti.com>, 
	Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
	Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
	Simon Horman <horms@kernel.org>, Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, 
	linux-can@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/4] can: m_can: Support pinctrl wakeup state
Message-ID: <20250813-avocet-of-fascinating-honeydew-7700aa-mkl@pengutronix.de>
References: <20250812-topic-mcan-wakeup-source-v6-12-v8-0-6972a810d63b@baylibre.com>
 <20250812-topic-mcan-wakeup-source-v6-12-v8-4-6972a810d63b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y2xvuxnvm2747qii"
Content-Disposition: inline
In-Reply-To: <20250812-topic-mcan-wakeup-source-v6-12-v8-4-6972a810d63b@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--y2xvuxnvm2747qii
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 4/4] can: m_can: Support pinctrl wakeup state
MIME-Version: 1.0

On 12.08.2025 11:10:25, Markus Schneider-Pargmann wrote:
> am62 requires a wakeup flag being set in pinctrl when mcan pins acts as
> a wakeup source. Add support to select the wakeup state if WOL is
> enabled.

The driver makes already use of pinctrl_pm_select_default_state(dev),
does it make sense to use it here, too?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--y2xvuxnvm2747qii
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmicQmAACgkQDHRl3/mQ
kZy8zAgAhMrFoTPVzEul/U+GJkkt2qclG7S5R840RJwQEYXKPwMW9Hl/i7xKv0eI
cbMvwVySd+F9kWHPApDNlF8HZ2m01acDvKjq/LannFSKBVST8c0Bf4QeeJRNqxT7
ZtaSfRI3SWFANiQ/6Esi+bH4mhNJtDWE+pnkiZ/ZDY4wqrQZJkDv60yMHY+lM6/Q
/lW27P+jduTrdx1w/lp5vFSMs9XdTU3K5YwnS04/DGUGvmPfOaPZoFUZzX6BakHP
QppCMBuepKjWilH2pJYK1uzkzqeiQZYZHhlJ0+uuIcrEDtBclYhJ1X938j5ujAR5
WiTjckEcPHFm97BtnSEx0wn2XmQgmA==
=+1WX
-----END PGP SIGNATURE-----

--y2xvuxnvm2747qii--


Return-Path: <linux-kernel+bounces-766183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C929B24372
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A40418974F2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EA62E7BD4;
	Wed, 13 Aug 2025 07:55:12 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630F62E9725
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755071712; cv=none; b=jVxoY0gUj4G9O7M475fTzrVV2WpjIsrDJoXk8bXdCnHLXcASIRekCp+UN58aY9pqry8W+gDXqYK7a1Xa/no2JRhO8Pu6VoVTJg9voWk6WC9PwKR+VKohYz/Z2YBX9Ni2nHrXONzRY1H7jp7F145NS4qBc4NQruXaRxROoRWJqRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755071712; c=relaxed/simple;
	bh=17up/G/1laxbCJDZqY+UPD+ssU74UB4snWyS+1JKHnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YL85464N++AddJx+iD8pDSfSHN1zTc+nyVbyYp/JpxWcITdSYix7Gt3o81UZ+t6GSu+b0/reNHInOgcoo85qYSLJSwZaJeEb+ayJ5jmsAo435baRNPzNRpbsYvsB+lPkdJPXNryArOPI+VNeOUFfJDZadz3Gy4AC3P7Un2y18LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1um6Jt-00078r-Fc; Wed, 13 Aug 2025 09:54:49 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1um6Js-0003Sy-13;
	Wed, 13 Aug 2025 09:54:48 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id EC4D045683A;
	Wed, 13 Aug 2025 07:54:47 +0000 (UTC)
Date: Wed, 13 Aug 2025 09:54:47 +0200
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
Message-ID: <20250813-apricot-cicada-of-apotheosis-e8d5fa-mkl@pengutronix.de>
References: <20250812-topic-mcan-wakeup-source-v6-12-v8-0-6972a810d63b@baylibre.com>
 <20250812-topic-mcan-wakeup-source-v6-12-v8-4-6972a810d63b@baylibre.com>
 <20250813-avocet-of-fascinating-honeydew-7700aa-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p6jujqy3l2flf72n"
Content-Disposition: inline
In-Reply-To: <20250813-avocet-of-fascinating-honeydew-7700aa-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--p6jujqy3l2flf72n
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 4/4] can: m_can: Support pinctrl wakeup state
MIME-Version: 1.0

On 13.08.2025 09:44:35, Marc Kleine-Budde wrote:
> On 12.08.2025 11:10:25, Markus Schneider-Pargmann wrote:
> > am62 requires a wakeup flag being set in pinctrl when mcan pins acts as
> > a wakeup source. Add support to select the wakeup state if WOL is
> > enabled.
>=20
> The driver makes already use of pinctrl_pm_select_default_state(dev),
> does it make sense to use it here, too?

Every suspend/resume cycle will overwrite the pinctrl setting with the
default one.

| int m_can_class_resume(struct device *dev)
| {
| [...]
| 	pinctrl_pm_select_default_state(dev);

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--p6jujqy3l2flf72n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmicRMMACgkQDHRl3/mQ
kZwB7gf9Fq3xmxmg80kEAI/NPS2rUYeqccDab32rRGOQHTLBtpivL0ap3NULqf2Z
WGaFuODT5TBV1zJqSZ9oRc9SdhwfJOO1/17/A5uE6fLn+9i91fLLFPfvTwVCEAaQ
puX607lxWiJYUl9n/jE5/MlsSKZq2ba9aHevhQbr6YXYrG3tb6ITYe5DhQhp1D5n
5owIIdhQ0PJbGeaJLud/MjSd0y2X6AXY/npChic30GO80RmTMZDxqLm+VcwVoJgL
zSCec6NzxzJfaFNfVRpzf8cFq+HbWqM0ai+CnfEZD1SypOBVlD2j7g2zERHfvqi8
E/crEhvpJD0FEhRy/Lbo8W1u/mDY5Q==
=+ar3
-----END PGP SIGNATURE-----

--p6jujqy3l2flf72n--


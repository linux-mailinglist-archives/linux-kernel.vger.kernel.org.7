Return-Path: <linux-kernel+bounces-766265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EE5B24470
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34037189D8EC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC9E2F067D;
	Wed, 13 Aug 2025 08:34:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28602EFD98
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755074067; cv=none; b=leAmlxVsjymzX7mm/RJ8RuKdfH/l4TESG+UTbTFVZ//FkvTPS73+G35/wnp4OTQyGcR78RCtCUrVXEan2s8dzZ9GPrhJw/MiWTKMKTei1arvLhJ8GAF0tPF/yVGskRdr1N4KP/npP3OTF243Sy6+QAaAZdjS7Z31b9OX85dijus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755074067; c=relaxed/simple;
	bh=7V0hsOAK8I6Dr7++yTRQrv50Fi+TJwWA//b/oVxQ1rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDVtv1+zlEC77Sv2IDGqwefIummmvgblh1GdkyVED178TjoVXKzwPCEZwDlYjyieB8CiiUrXcgiqFEjsGuMqFGsOYolmGDclE+1hXNlg8NiGcqRjeNg11fcGlBi0qYpQmhHNYV5e4kEh/y9dMF8RJYbCuEgJd7uJ9/jSx+68zcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1um6w3-0005be-EZ; Wed, 13 Aug 2025 10:34:15 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1um6w1-0003pQ-1s;
	Wed, 13 Aug 2025 10:34:13 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 20C654568F7;
	Wed, 13 Aug 2025 08:34:13 +0000 (UTC)
Date: Wed, 13 Aug 2025 10:34:12 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Patrik Flykt <patrik.flykt@linux.intel.com>, 
	Dong Aisheng <b29396@freescale.com>, Fengguang Wu <fengguang.wu@intel.com>, 
	Varka Bhadram <varkabhadram@gmail.com>, Wu Bo <wubo.oduw@gmail.com>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH 7/7] can: m_can: add optional support for reset
Message-ID: <20250813-important-wisteria-toucan-35763e-mkl@pengutronix.de>
References: <20250812-m_can-fix-state-handling-v1-0-b739e06c0a3b@pengutronix.de>
 <20250812-m_can-fix-state-handling-v1-7-b739e06c0a3b@pengutronix.de>
 <6f138742fe92b6d26f0cd87d3c57e141d63c6f3b.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tltiqztgsbue64mt"
Content-Disposition: inline
In-Reply-To: <6f138742fe92b6d26f0cd87d3c57e141d63c6f3b.camel@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--tltiqztgsbue64mt
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 7/7] can: m_can: add optional support for reset
MIME-Version: 1.0

On 13.08.2025 10:17:52, Philipp Zabel wrote:
> On Di, 2025-08-12 at 19:36 +0200, Marc Kleine-Budde wrote:
> > In some SoCs (observed on the STM32MP15) the M_CAN IP core keeps the
> > CAN state and CAN error counters over an internal reset cycle. The
> > STM32MP15 SoC provides an external reset, which is shared between both
> > M_CAN cores.
> >=20
> > Add support for an optional external reset. Take care of shared
> > resets, de-assert reset during the probe phase in
> > m_can_class_register() and while the interface is up, assert the reset
> > otherwise.
> >
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> >  drivers/net/can/m_can/m_can.c | 26 +++++++++++++++++++++++---
> >  drivers/net/can/m_can/m_can.h |  1 +
> >  2 files changed, 24 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_ca=
n.c
> > index c24ea0e5599f..0a6d4b523c33 100644
> > --- a/drivers/net/can/m_can/m_can.c
> > +++ b/drivers/net/can/m_can/m_can.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/pinctrl/consumer.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/reset.h>
> > =20
> >  #include "m_can.h"
> > =20
> > @@ -1833,6 +1834,7 @@ static int m_can_close(struct net_device *dev)
> > =20
> >  	close_candev(dev);
> > =20
> > +	reset_control_assert(cdev->rsts);
>=20
> Nitpick, "rsts" as in plural?

fixed.

>=20
> [...]
> > @@ -2462,8 +2478,10 @@ int m_can_class_register(struct m_can_classdev *=
cdev)
> >  		 KBUILD_MODNAME, cdev->net->irq, cdev->version);
> > =20
> >  	/* Probe finished
> > -	 * Stop clocks. They will be reactivated once the M_CAN device is ope=
ned
> > +	 * Assert rest and stop clocks.
>=20
> Typo, s/rest/reset/.

fixed.

>=20
> Otherwise,
>=20
>=20
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

Thanks, hmmm, why doesn't b4 pick that up?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--tltiqztgsbue64mt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmicTgEACgkQDHRl3/mQ
kZxjhgf8DxdNmX3MuVO4rbWy1QzNdD3W0feliB7N03QYtbZo8QDXY+VlrFpegr39
dNdvxi3rAYf5EiSjSG9VKTuji/o4TG87ftLC5JX+bEe21ixTl6qcK5dNsod33dHR
ZZFFXK2c3BIDe932mJxqNCBe6kGzQgrldGuFo7B+rs3k3/t9dh1jPD6eY29LxgVU
98bo1tcp3VajmmtHB3FbLOSJWaehFeKqaLK37FJ+I8KLqs+ibB1ThYwoI8U1hLFl
lR78ivf+URSqkD6ndx93AelbuOsQgkTNqratWNhMjmvjuUUzOzppkwrAEDRvgeXe
lN/AFROLmKeyQtXHbeGhEnZUQLFytQ==
=0ohj
-----END PGP SIGNATURE-----

--tltiqztgsbue64mt--


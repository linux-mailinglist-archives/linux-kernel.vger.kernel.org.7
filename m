Return-Path: <linux-kernel+bounces-858087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A67EBE8D70
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39A36E2CA8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E55350D4C;
	Fri, 17 Oct 2025 13:28:10 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024E334F46B
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760707690; cv=none; b=rwn4XshKGyfXBDRbcwhYHv1uJT759S0hl+kYqcN0lbijOxKcGwGKtbaB503dusnBK3AfxF4lNyKN6xLGtFkDEZMF44fpM4LxyvMm4gpsTkDl44DsTZBmKRennw3EP//NIr7NiL9DPgNxZrNr3MeY82l50SZKSLnlYCsFtr3jSpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760707690; c=relaxed/simple;
	bh=A5bWtoCjcE3KSfxQyHBw3n1i7oJtoEpPjwfpCY7WRnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nH+wLaI6gpW4Cg9uufBb6A39IHgTuHGSFqCuAr6BdxM3CPa1MGfHmHc6dS3WHwuJzCu6r4pSECUqb7+Qyt+XGlFh+0BTNOO9BswHQi1mtcr0vBxEQlh2ca4lAxHzaMMwdaOyczvpE99vW8NYOptDxC8BNRnFC928EdpxQE4y9+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9kUv-0005Bi-Od; Fri, 17 Oct 2025 15:27:57 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9kUv-00448u-07;
	Fri, 17 Oct 2025 15:27:57 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A53524891AC;
	Fri, 17 Oct 2025 13:27:56 +0000 (UTC)
Date: Fri, 17 Oct 2025 15:27:56 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
	=?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@hms-networks.com>, Robert Nawrath <mbro1689@gmail.com>, 
	Minh Le <minh.le.aj@renesas.com>, Duy Nguyen <duy.nguyen.rh@renesas.com>, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] can: dev: can_dev_dropped_skb: drop CAN FD skbs if
 FD is off
Message-ID: <20251017-bizarre-enchanted-quokka-f3c704-mkl@pengutronix.de>
References: <20251013-canxl-netlink-v1-0-f422b7e2729f@kernel.org>
 <20251013-canxl-netlink-v1-1-f422b7e2729f@kernel.org>
 <20251017-determined-jackdaw-of-painting-e2ff64-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kukgz24an2ugwfuw"
Content-Disposition: inline
In-Reply-To: <20251017-determined-jackdaw-of-painting-e2ff64-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--kukgz24an2ugwfuw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/9] can: dev: can_dev_dropped_skb: drop CAN FD skbs if
 FD is off
MIME-Version: 1.0

On 17.10.2025 10:28:38, Marc Kleine-Budde wrote:
> On 13.10.2025 20:01:23, Vincent Mailhol wrote:
> > Currently, the CAN FD skb validation logic is based on the MTU: the
> > interface is deemed FD capable if and only if its MTU is greater or
> > equal to CANFD_MTU.
> >=20
> > This logic is showing its limit with the introduction of CAN XL. For
> > example, consider the two scenarios below:
> >=20
> >   1. An interface configured with CAN FD on and CAN XL on
> >=20
> >   2. An interface configured with CAN FD off and CAN XL on
> >=20
> > In those two scenarios, the interfaces would have the same MTU:
> >=20
> >   CANXL_MTU
> >=20
> > making it impossible to differentiate which one has CAN FD turned on
> > and which one has it off.
> >=20
> > Because of the limitation, the only non-UAPI-breaking workaround is to
> > do the check at the device level using the can_priv->ctrlmode flags.
> > Unfortunately, the virtual interfaces (vcan, vxcan), which do not have
> > a can_priv, are left behind.
> >=20
> > Add a check on the CAN_CTRLMODE_FD flag in can_dev_dropped_skb() and
> > drop FD frames whenever the feature is turned off.
> >=20
> > Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
>=20
> What about merging both can_dev_dropped_skb() an
> can_dropped_invalid_skb() in the skb.c, so that there is no stub in the
> header file anymore.

Ouch! Don't do this. We still need can_dropped_invalid_skb() for virtual
interfaces. See commit ae64438be192 ("can: dev: fix skb drop check").

But then I'm asking: Why is there the difference between virtual and
non-virtual interface in the first place? Can we get rid of it?

> Someone (i.e. me) used can_dropped_invalid_skb() in a driver, that means
> the check for CAN_CTRLMODE_LISTENONLY is missing :/ (I'll send a fix).

These drivers need this fix:

| drivers/net/can/bxcan.c:845:     if (can_dropped_invalid_skb(ndev, skb))
| drivers/net/can/esd/esdacc.c:257:        if (can_dropped_invalid_skb(netd=
ev, skb))
| drivers/net/can/rockchip/rockchip_canfd-tx.c:75: if (can_dropped_invalid_=
skb(ndev, skb))

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--kukgz24an2ugwfuw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjyRFcACgkQDHRl3/mQ
kZyC0gf8Cmqu+KY3qH0hjVVMNdhs2wwaTKwgMC8LTtL7xxJpMD2vYOY65agtvTUh
JnwvSV3FRM1HRhXnp1Gcv087RogGk1+cD9GqyMMmuMqPBFK2ZZf6FTskUSfI0yAP
TRVNbXk3m3MR+9GKUXuIwVZIzIj3ZZOzWKv6b6S42TCLFk/fVRDWjh9mgIWRLe1h
D8PwpaQQovNOzKAAu8R4878fYZpcUuZmHa0LC0jeA0n5ip8Wu1c+3vsHLIesC5kG
VY4gTmh75UcRblS95NKNQsFGW0jeKDjlSx4luiB07izE/vjcLRayv1voqZwHiBvz
76g/P8DbWOMf/13O8bYDqg8nhJp8yA==
=KkI2
-----END PGP SIGNATURE-----

--kukgz24an2ugwfuw--


Return-Path: <linux-kernel+bounces-858128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2BCBE9117
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DAB3F35B508
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00913570D6;
	Fri, 17 Oct 2025 13:53:34 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864F72E716A
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760709214; cv=none; b=eTHRu4OGbpZTFcGpE/KJE86PP7d7Krnss3XFzL791rEr2jTVEF2ZQi/fQq1hZJl/dZNTbX1pDsyFEgUhLpZDTDMIcgIcHQFLID1mnezDn9LsB/RhK2X/hH5eegxAwD74hgfvUAUWgUnhKvO3WSvNRYjL2ExPGV+RnmlsUDs7o5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760709214; c=relaxed/simple;
	bh=ACN+SxKx9MrLpT5sps5xl7hlVU59dkzrT5k268UeApQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0LbJc6QKZly9ZZ7wg2VIxYzaks37mXdEk5ZZndVaDsg5cknR5Dva9m4fXP8cKIFwkouFxJAt7+qCzww9p3cDEdY0wFcb6y5NwHb+PyX8RKLkSdwSNnB5hfzjxp2tfqB1cuDyUBszyrVdYm0thE3+X12AyJS1LV3PNA22Jaqhhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9ktW-0000hc-RG; Fri, 17 Oct 2025 15:53:22 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9ktW-0044FS-0D;
	Fri, 17 Oct 2025 15:53:22 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AF7644891D6;
	Fri, 17 Oct 2025 13:53:21 +0000 (UTC)
Date: Fri, 17 Oct 2025 15:53:19 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
	=?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@hms-networks.com>, Robert Nawrath <mbro1689@gmail.com>, 
	Minh Le <minh.le.aj@renesas.com>, Duy Nguyen <duy.nguyen.rh@renesas.com>, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] can: netlink: add CAN XL
Message-ID: <20251017-spectacular-xanthic-swan-9427e8-mkl@pengutronix.de>
References: <20251013-canxl-netlink-v1-0-f422b7e2729f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tdncbrcad6eo2wnj"
Content-Disposition: inline
In-Reply-To: <20251013-canxl-netlink-v1-0-f422b7e2729f@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--tdncbrcad6eo2wnj
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/9] can: netlink: add CAN XL
MIME-Version: 1.0

On 13.10.2025 20:01:22, Vincent Mailhol wrote:
> Following all the refactoring on the CAN netlink done in series [1],
> [2] and [3], this is now time to finally introduce the CAN XL netlink
> interface.
>=20
> Similarly to how CAN FD reuses the bittiming logic of Classical CAN,
> CAN XL also reuses the entirety of CAN FD features, and, on top of
> that, adds new features which are specific to CAN XL.
>=20
> Patch #1 adds a check in can_dev_dropped_skb() to drop CAN FD frames
> when CAN FD is turned off.
>=20
> Patch #2 adds CAN_CTRLMODE_RESTRICTED. Note that contrary to the other
> CAN_CTRL_MODE_XL_* that are introduced in the later patches, this
> control mode is not specific to CAN XL. The nuance is that because
> this restricted mode was only added in ISO 11898-1:2024, it is made
> mandatory for CAN XL devices but optional for other protocols. This is
> why this patch is added as a preparation before introducing the core
> CAN XL logic.

What about merging patches 1+2 now?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--tdncbrcad6eo2wnj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjySkwACgkQDHRl3/mQ
kZyIbgf/VM+jkxIR06HqwzHULp0Sumz2qr0evg0i52UHN1jlfwlRNJpES8HbXmdN
lJ2o4+7bOQdBUQ4XOh1tsY2JJGYmcYNV/YQkjR8kuEDcriBsHEvWQIFUfNhpA+Xy
czB6A0R4k22zSTneUDHqKWCxClYss4hQgmLPgz7dAXNe4mq4eM0ASftNYC2A3hcO
rsKvqZPhxIsArcDoBVlVooyCL/caLwSZGxVjIekAJy07vHfRhBOjyXD2tbV6f64W
8bT1ctD+O5EX6AlI5W/UUrT6oOODlms+gzUjjgla1ONw4dnkitYG3CqbP5rqsd9H
8VAHsnmDTiYssoaAw4yEEt/pAbha7g==
=SISr
-----END PGP SIGNATURE-----

--tdncbrcad6eo2wnj--


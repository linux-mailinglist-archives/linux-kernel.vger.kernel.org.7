Return-Path: <linux-kernel+bounces-828671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E2CB9525D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92D15446696
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732422F291B;
	Tue, 23 Sep 2025 09:09:07 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86522594B9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758618547; cv=none; b=UzTNNkOdO1HcqQTWxgGHH1GO2GmJP8aU6plk88WXWRIJJX+vBAg7ZZwPutFWTlDmGWsHyj9+4+hlvlRnQ40t2Z80S2u3HJH/49IFOqn8xqoxd0yvBhbhRQ/iM7B9gQwHcIUZ28m0JSidixzc0LU/jv10F61gxOJCiIyRnUNW0JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758618547; c=relaxed/simple;
	bh=9l5rDPf+Yv08IS8pKMTthDS13Skml5iTWKIX0UazaOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCal0grSC95njeg4T0UAGjUCfwuU4ex7soolaAu7R5RBECAFjo3eEtx1v7cLhwqxjk6WvBd9aN2531VRjjaAUHQXqHq26w1fjUQLCG0Y5U37/zSGUl3AbJu5kndLetT/0bruvxgEFo5n6rSyRu8fSvmANa/m4BRY9Bly6tYeWig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0z12-0005YT-Ek; Tue, 23 Sep 2025 11:08:52 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0z11-00049N-2M;
	Tue, 23 Sep 2025 11:08:51 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 53AD8477BE4;
	Tue, 23 Sep 2025 09:08:51 +0000 (UTC)
Date: Tue, 23 Sep 2025 11:08:49 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
	=?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@hms-networks.com>, Robert Nawrath <mbro1689@gmail.com>, 
	Minh Le <minh.le.aj@renesas.com>, Duy Nguyen <duy.nguyen.rh@renesas.com>, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/20] can: netlink: refactor
 CAN_CTRLMODE_TDC_{AUTO,MANUAL} flag reset logic
Message-ID: <20250923-bald-indigo-coati-2c3613-mkl@pengutronix.de>
References: <20250910-canxl-netlink-prep-v2-0-f128d4083721@kernel.org>
 <20250910-canxl-netlink-prep-v2-7-f128d4083721@kernel.org>
 <f9854748-78c1-4852-a610-e839e9c91df3@kernel.org>
 <20250922-amber-spider-of-control-90be7c-mkl@pengutronix.de>
 <9cfdcf56-2f47-4cfd-9fd6-2c6fa4476752@kernel.org>
 <20250922-rational-mastodon-of-sufficiency-6b49f1-mkl@pengutronix.de>
 <2528d3d7-2807-4ef6-8269-5e20de57cc41@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="svuz3wswyvazxfzz"
Content-Disposition: inline
In-Reply-To: <2528d3d7-2807-4ef6-8269-5e20de57cc41@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--svuz3wswyvazxfzz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 07/20] can: netlink: refactor
 CAN_CTRLMODE_TDC_{AUTO,MANUAL} flag reset logic
MIME-Version: 1.0

On 23.09.2025 16:04:41, Vincent Mailhol wrote:
> >> I will resend my two series in the next few days as soon as the MTU fi=
x appears
> >> in net-next.
> >=20
> > I don't know how much time we have between the merge of net into
> > net-next and the acceptance of the last PR by the network team for the
> > next merge window. We will see.
>=20
> With the pull request to net/main being delayed, I decided to finally rem=
ove the
> patch which was in conflict and send the rest:
>=20
> https://lore.kernel.org/linux-can/20250923-can-fix-mtu-v3-0-581bde113f52@=
kernel.org/
>=20
> and:
>=20
> https://lore.kernel.org/linux-can/20250923-canxl-netlink-prep-v4-0-e720d2=
8f66fe@kernel.org/
>=20
> These are my last two series for this development window (to be applied i=
n order).
>=20
> Also, sorry for the noise when sending those twice.

I've merged both series to linux-can-next. Thanks. b4 was a bit
confused, it took the canxl-netlink-prep when asked to merge the
can-fix-mtu series and it added the prerequisite patches when merging
canxl-netlink-prep on top of can-fix-mtu.

My next net-next PR is prepared as linux-can-next-for-6.18-20250923. Can
you check if I took the correct patches?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--svuz3wswyvazxfzz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjSY50ACgkQDHRl3/mQ
kZxIhwf+P7UZ+BrnJVOfZ9fSJJo0Uz+GJk1HWpNOiNe3xXviMsLYhMK/Ln3mMbhL
fzM/MaBGiZrLJO/ffLMnGU5dzqdkw7UlqywyjmF+o9bIVLOp6/csPd7BN3WjC8cQ
Ess+mdnP+AdWNR0HFF9klxV1gqoHeoepGPu0iCjUo8wl+vVkcejEIOZGbJNpz9V2
cd4tbfpry9qVPExd+EoYL80sy625D3TgAtB+okIPssPB78iT4/lhUN+JnX7z2JwH
bTot8hiGDdp4HkwPKZ3bNDhD1c3VG1k6mpGeP3uqIGSR6ZmX0lv3XwU9zWuLjECP
RzNlhZrK6ALxpGkbdznTQi2LZxOCww==
=syqg
-----END PGP SIGNATURE-----

--svuz3wswyvazxfzz--


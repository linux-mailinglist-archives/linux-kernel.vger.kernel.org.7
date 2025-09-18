Return-Path: <linux-kernel+bounces-787850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE60B37C2E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FCA53ACE00
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 07:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD88C320CCD;
	Wed, 27 Aug 2025 07:49:39 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECF62749D7
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756280979; cv=none; b=YIFZT5sCDY2/xeOiTxJmX/m2VMOyiroq+D2MiakgznqnaTL0+chUtpaB9jrN+X0pLqmFu8rD85+gGSSEIGlJjgh0HbASYiHgty0oY+LTxZnnSa5fxhrstVAGIrURn+cgMvW54CqC/AY/zeGRyXIoUS8o26zISs1+qxa7Z5a1sBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756280979; c=relaxed/simple;
	bh=VcO2mA3r3AuhPb3tjISs7ZOhpMjbS7Bm61eiWNbKoBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBXmB3NkiiC+l2NHGWNYjPX6YrRVxbNsuF78sQByoj0wz4LmWRXVLMvjZama4YVnFBPVIsup0FOXHtWHNLxAdERWF9DIsx/ZHw2rl8QMerES7CUGRDGJelJb5LH4ftKbbV40Go8k7t5lSK5OCm3x3dIN9fI6zk0Zz2wEGaXeiPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1urAuS-00025y-Hq; Wed, 27 Aug 2025 09:49:32 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1urAuS-002MHx-19;
	Wed, 27 Aug 2025 09:49:32 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AECC445ECD2;
	Wed, 27 Aug 2025 07:40:17 +0000 (UTC)
Date: Wed, 27 Aug 2025 09:40:16 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: mailhol@kernel.org
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update Vincent Mailhol's email address
Message-ID: <20250827-winged-bizarre-mackerel-a91272-mkl@pengutronix.de>
References: <20250826105255.35501-2-mailhol@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x7y5plluoqutyj6f"
Content-Disposition: inline
In-Reply-To: <20250826105255.35501-2-mailhol@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--x7y5plluoqutyj6f
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] MAINTAINERS: update Vincent Mailhol's email address
MIME-Version: 1.0

On 26.08.2025 19:48:39, mailhol@kernel.org wrote:
> From: Vincent Mailhol <mailhol@kernel.org>
>=20
> Now that I have received my kernel.org account, I am changing my email
> address from mailhol.vincent@wanadoo.fr to mailhol@kernel.org. The
> wanadoo.fr address was my first email which I created when I was a kid
> and has a special meaning to me, but it is restricted to a maximum of
> 50 messages per hour which starts to be problematic on threads where
> many people are CC-ed.
>=20
> Update all the MAINTAINERS entries accordingly and map the old address
> to the new one.
>=20
> I remain reachable from my old address. The different copyright
> notices mentioning my old address are kept as-is for the moment. I
> will update those one at a time only if I need to touch those files.
>=20
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>

Applied to linux-can-next.

BTW: The "From" header of your mail only contains you e-mail address,
not your real name.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--x7y5plluoqutyj6f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmiutl0ACgkQDHRl3/mQ
kZwuvggAsuU56iTV6Si4It0cvBLYDjjga6dcOWUJjkiTRtzcQQFVWogQ2Tvym4he
T5vjXXbcCrccNBvGhcpBqlhUbNK+5k5Jm8TxBnajFX7lZwq3RbJE+yKc3TT+Qpu3
b8LRrrLrFs9GyVYcSzoTYrQZQ1prNTcynqfonanyFj39mK5H5dkC08YttKHOO4jo
FzPJQeFHgJlhN8L4qzE0kCJlfVqYy8dt+dx7M3eUwxYoNTLPOFN5gXpc4iXL1dVl
Od3TRCDExLcByWP+reZq2BPtZcRmE5BMAt1cOLVvs4hYjHmGaloj+K51pcWtGPGW
0oNxuO9ZeHQ4LlyJPQqG1sidkmc0fA==
=ERBZ
-----END PGP SIGNATURE-----

--x7y5plluoqutyj6f--


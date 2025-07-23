Return-Path: <linux-kernel+bounces-741902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEA9B0EA73
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0B695800A4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 06:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F62A26B2A5;
	Wed, 23 Jul 2025 06:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="VDn3AtUR"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A95E26A0F8
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753251356; cv=none; b=YIqb+sZCCmc1682AGLWCBNIPKBlNgpMbDZQcnMNtDPH9AQ2Kcc+JncgjTEVQPA4UkaNvxKPPUcJ0bE0winHxAEZOmel2RECMBzZzIMXU5LRRgsCq3a1yZGguO4MWKOwzifp6+bga1GNz+peMW8XAwg+W/fWZjpM4DkpIH4NG2HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753251356; c=relaxed/simple;
	bh=ax9elkvCsJOS0FGzuk8JHuLaUt5FxSNMNiZ2uKmVR6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ft9jhUBfE+lWchzGiR0dVCe+Rgl/w0i/O7PdoOQCkUYq7ZHn/6Wd1nJeq+5KHi359nTm0X+clIKsQ0rxXSh/2IzKBKx1muj7eAYZ9gA+Tbco+CQYU81tZUI8Bz4+uxSwKWAMcM2d9wtp5kNH+OmRZl0/ZEgFiq6fqamSpbxyicw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=VDn3AtUR; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=ax9e
	lkvCsJOS0FGzuk8JHuLaUt5FxSNMNiZ2uKmVR6c=; b=VDn3AtURZBHqK8pGMmMV
	BRueHUOpGurWEyhbv57fBKCZDRXHV+ysRLL0ip//1LM4oVrg2+BJSsRmK4oeUIbm
	3iwG8ihdexQ7jYVtXGBu4YmvYd3qgjsjQGGQBC4ltLBcydA5bJXELv9cdG53AdkP
	dPaVw1ESZ1hwOuauraXvqRDDcm8i66watBV4XMMW+r3t14+31B34TBASOrbXCttA
	lck/FqiFyVYWgk1GfW4sz80dSuxxgtbmm4Ow7jSKeopa+sytiMdALR6Zb+X2382O
	l1J0ChihKc2fQcnaZZl2ySRO6jLaPGYRrBAYjiVWO9HgDSBQU9MAWyGSadURiZhV
	DA==
Received: (qmail 1589650 invoked from network); 23 Jul 2025 08:15:51 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 23 Jul 2025 08:15:51 +0200
X-UD-Smtp-Session: l3s3148p1@S5n1o5I6SSVtKPJT
Date: Wed, 23 Jul 2025 08:15:50 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	Romain Gantois <romain.gantois@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH -resend] misc: ti_fpc202: Switch to of_fwnode_handle()
Message-ID: <aIB-Fq9Wd1Eh-TZC@shikoro>
References: <20250723053516.1796097-1-jirislaby@kernel.org>
 <aIB345FIxUqpWWio@shikoro>
 <d58715df-b767-44d0-9f26-50c3458df27a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rpohx4Yq1XnaYEDP"
Content-Disposition: inline
In-Reply-To: <d58715df-b767-44d0-9f26-50c3458df27a@kernel.org>


--rpohx4Yq1XnaYEDP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> Well, who is supposed to pick this up? I thought you.
>=20
> But given you marked it as such -- Greg?

Technically, yes, Greg. I took the driver together with the I2C ATR
feature because it was its first user. But other than that, it doesn't
belong to the I2C realm. That being said, I can pick this patch to help
removing the deprecated function if Greg doesn't pick it in the next
days.


--rpohx4Yq1XnaYEDP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmiAfhYACgkQFA3kzBSg
KbZ2nQ//WlEbI1+hFyR2EeWVuKpTamNdni6Rr5lyFROsqFBjZ0WLTdqt2RxA7i6R
ysb4HGaf1WQZP1e6gvKl9pSxn9VjxOy2L9MS6LabIZFthfALGSHoBo/J3s13xWXV
WIb3Pqbn88JZoXR5Hp/MPrAEoPMTLezwRIM6h6K6cSk4wN1z7rrQwDxgTkNAoktd
aKg8IgGJ0AQjdzHlnZkNNIuAhvG+g2bo8K8OfFivRbU/4/ansiGzEyy2I/KMR+aX
Bu7utUO4civWJH6D+GCasJpBuSXqg30J/lNzUiutRPhcd+JOgqox5tUX/O9DKIxf
0j3WOZe/eoVUFLB1N2eLV1eVSF6+UALLRhxNUsniyzFg0ejWcn6Z86YOFyzIURAo
qBt8EiSvE11tG7nf+JvtLvlOaqUcW2T5Ja5reJJwzEmEEm32cBNnLvzpbMm8mzZF
B7bcMp+17QXVdOVYC+qp+AEcAOXbbOVGKAixcrrX5G6ZRsnegT0cebDxpTDb90pr
VEueql78QWlX+ZYY66Uwo88Ej1d9RuMgaAfXkUI4QthYKsd1OIdZqf+KXSrb32qG
i6eum0Xt6E68ZtA/dehMqhPHeZE7VTHqNV95ZDQN4w/siWWe/ZPlAoP/79/wZYJ1
dCQ2ijdFtC4QHHOZUDbmmVUtiwOY6gtlVpYVB71eb3AuaS8UXgk=
=BPXq
-----END PGP SIGNATURE-----

--rpohx4Yq1XnaYEDP--


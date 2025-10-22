Return-Path: <linux-kernel+bounces-864794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C238CBFB8F9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F254568731
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F774221DB9;
	Wed, 22 Oct 2025 11:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="Lrq7+uhH"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F4A32C93C;
	Wed, 22 Oct 2025 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131501; cv=none; b=rsOcOZgiT9dewcJFIFaOe4RKZnJLUzHjYJJPSbsco1hrke1XdsqDHJEoJhKGao7kr71HDrFPivCB2cbNXfiBSa3N8mqVqGolSXd1FWWIYxkuCZEh22u1GdnRFYLjCZyLAi9+HEtGUoalx73gQkdwS/HhN9wQYSTSg8E+MbPbNjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131501; c=relaxed/simple;
	bh=awrBL649S9Sm0PM7VBAIkW+cEYbtNLUZTFQ5hekfKOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttw1V5YV3/haP4Z9JYGG0r31J5xwUa5GLoBkKHHJzBzInillgoBcayhSEwEKd/7iXMVevNN7hyaHIa9kpun3XbejYbrpBd3OWlPTrR2I2kS2UTddkljjj+X5IpmYrNHU37FjnpWITt1ua1ffNYuAAxIrJXfb6coPGi1FfJBS5I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=Lrq7+uhH; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3E50B1C0088; Wed, 22 Oct 2025 13:11:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1761131497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=awrBL649S9Sm0PM7VBAIkW+cEYbtNLUZTFQ5hekfKOw=;
	b=Lrq7+uhHtpKyC857gievF88tNHyEYqyTn8nZD/MjIjPYm0c0ba/zpMVTy2/Qd6YpO5qE+k
	FSFKMIXW9BTA90M/jQ3gI6s5ZKCO6x6nIcfM0m/rNvKiFWgkrrCl7IgW225OdYvxBoMv3M
	GWNrtT2gDWj1kiaeeIsmfeRSe3gptII=
Date: Wed, 22 Oct 2025 13:11:36 +0200
From: Pavel Machek <pavel@ucw.cz>
To: guptarud@gmail.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Ondrej Jirman <megi@xff.cz>, Martijn Braam <martijn@brixit.nl>,
	Kamil =?utf-8?Q?Trzci=C5=84ski?= <ayufan@ayufan.eu>
Subject: Re: [PATCH v4 2/4] arm64: dts: rk3399-pinephone-pro: Add
 accelerometer sensor support
Message-ID: <aPi76OR8RJYWUSuj@duo.ucw.cz>
References: <20250929-ppp_light_accel_mag_vol-down-v4-0-6598f22d3451@gmail.com>
 <20250929-ppp_light_accel_mag_vol-down-v4-2-6598f22d3451@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kG/KRNe2a1V815DB"
Content-Disposition: inline
In-Reply-To: <20250929-ppp_light_accel_mag_vol-down-v4-2-6598f22d3451@gmail.com>


--kG/KRNe2a1V815DB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> // Put the phone face down so the screen is touching the table
> z: 16000
>=20
> Co-developed-by: Martijn Braam <martijn@brixit.nl>
> Signed-off-by: Martijn Braam <martijn@brixit.nl>
> Co-developed-by: Kamil Trzci=C5=84ski <ayufan@ayufan.eu>
> Signed-off-by: Kamil Trzci=C5=84ski <ayufan@ayufan.eu>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>

Reviewed-by: Pavel Machek <pavel@ucw.cz>

--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, Netanyahu and Musk!

--kG/KRNe2a1V815DB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaPi76AAKCRAw5/Bqldv6
8jD5AKCRomNj90PxMlQ8EJ1tMJuCwV32PACfaDakNiy6j4mT0JrZvpoKWX8m3+A=
=Uzhj
-----END PGP SIGNATURE-----

--kG/KRNe2a1V815DB--


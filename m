Return-Path: <linux-kernel+bounces-864798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 99866BFB911
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC10B4FDB2C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B62432D0F1;
	Wed, 22 Oct 2025 11:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="a588Lvii"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B8211CA9;
	Wed, 22 Oct 2025 11:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131603; cv=none; b=mcKdrqLksGmfYumNebtksYoieHdxxPpnmmwdfJwoKIu64K1HI3zd7+N493PLhcNfMoCJQRuz+5D4aNBePzMYH5nFfwtKiOPgthGuBoqzb7d9Esw61hSCvLmym2b4qDcn1Tg4PXR0qH5g5xbkthu96NZTNPTaHiSmquvUePRNHxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131603; c=relaxed/simple;
	bh=c+Xvrmg8Y2KUdExCPhWr42Wj06L4lT0cSVL0dFpL7G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLzKBrlcwvgVceWZeZYnCPfd1j+qpULABCe1rOzptQaEcoIJ/rN1j0U/Kj49PQ7n/XNeQBm276Nwz+V7dVQLmNE5hcEtHGFd0PlfLZxM3kX/8m0JFoDwKJWuTosE3VclfWRsZztM3OBs8mOQ3blGMDJ78DNblxkowGG82xeuYWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=a588Lvii; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 28A091C008F; Wed, 22 Oct 2025 13:13:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1761131599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RiHRtBrAUxWkpptBogGfntRkFVC2Xst6OAKpWS80aZI=;
	b=a588LviioKG46EL+W3kvhY+IVvHPjaXGB76s3z6DaTDNxOphPnyzslyjeIE7w98AsOMlm+
	ruJR2QRUtzIICO16MGJ/MtxuvfZ9/Ysc12i5CoL4tjLpLRoxaxq08nm00+b7wafFOcFC7q
	YCjZL4qDlHCVkE76ZFrNlOWoHABsR7E=
Date: Wed, 22 Oct 2025 13:13:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: guptarud@gmail.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Ondrej Jirman <megi@xff.cz>
Subject: Re: [PATCH v4 4/4] arm64: dts: rk3399-pinephone-pro: Fix voltage
 threshold for volume keys
Message-ID: <aPi8TsoarXJXvKuz@duo.ucw.cz>
References: <20250929-ppp_light_accel_mag_vol-down-v4-0-6598f22d3451@gmail.com>
 <20250929-ppp_light_accel_mag_vol-down-v4-4-6598f22d3451@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8eFsTqdRSFJMsawS"
Content-Disposition: inline
In-Reply-To: <20250929-ppp_light_accel_mag_vol-down-v4-4-6598f22d3451@gmail.com>


--8eFsTqdRSFJMsawS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Ondrej Jirman <megi@xff.cz>
>=20
> Previously sometimes pressing the volume-down button would register as
> a volume-up button. Match the thresholds as shown in the Pinephone Pro
> schematic.
>=20
> Tests:
>=20
> ~ $ evtest
>     // Mashed the volume down ~100 times with varying intensity
>     Event: time xxx, type 1 (EV_KEY), code 114 (KEY_VOLUMEDOWN), value 1
>     Event: time xxx, type 1 (EV_KEY), code 114 (KEY_VOLUMEDOWN), value 0
>     // Mashed the volume up ~100 times with varying intensity
>     Event: time xxx, type 1 (EV_KEY), code 115 (KEY_VOLUMEUP), value 1
>     Event: time xxx, type 1 (EV_KEY), code 115 (KEY_VOLUMEUP), value 0
>=20
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>

Reviewed-by: Pavel Machek <pavel@ucw.cz>

BR,
								Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, Netanyahu and Musk!

--8eFsTqdRSFJMsawS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaPi8TgAKCRAw5/Bqldv6
8oYXAJ9s4v0KB9wq1j3POu2TGNFDuabVrwCffytHlKiV39Y0bTN6VVIeuDzRjTg=
=r+hr
-----END PGP SIGNATURE-----

--8eFsTqdRSFJMsawS--


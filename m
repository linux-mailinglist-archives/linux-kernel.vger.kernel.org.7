Return-Path: <linux-kernel+bounces-864796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C440BFB90B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F90F3AD4A2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E489832D42E;
	Wed, 22 Oct 2025 11:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="HQgMT9LE"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C762F28F1;
	Wed, 22 Oct 2025 11:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131581; cv=none; b=qd22Jj4z15DCGqDZUSMSLg8KJalMdxuWEy7RE1r1LjfHoAz86/VGy0QCiq0Zw3qWoRW+yjTGgRaP4xmETG8ejxgQaQ4q7aJDei7asM/18yldaW/uzSnaR/xAW7cAPR6C1vM5lC8yxb+ZKplIL9gKXRKt7XPRxqNaC48XKA0Rw24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131581; c=relaxed/simple;
	bh=yBEPK/ItgXtL8RrOwEQxUimjZhkACX5vrovEaxJ0TvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EobWUXHIkyKlMb1qWpR6jpfr3H0QLOHV3swhC0oRJAVDvG1TkOTsXtV7qe57KnSo86rBSTSbKCbD01CIPoVx6iUVhcPCzROEMd/BaADSTl7j1s+1EC8vy3QD9JnbHbpDDsowN7JqSRKF50JuueqHoThoL3Fc18bngi7oFD4y1A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=HQgMT9LE; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3556F1C01AC; Wed, 22 Oct 2025 13:12:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1761131577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yBEPK/ItgXtL8RrOwEQxUimjZhkACX5vrovEaxJ0TvU=;
	b=HQgMT9LE6g77sHbrC/HhWVmziHofgn2BPC541hn8rKfSWz3cR2/O6Cnt4zeoIKCLNFjW4v
	96AyoSweu1fqhZPTiEA1k9tuDH5x/9xcDCJCPa50wsGJQdTrGbU+8aVI1hXSL+ufb9jrIF
	vbn3mL4s0q0r+g+3Qfvp3hX9RdOsUMc=
Date: Wed, 22 Oct 2025 13:12:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: guptarud@gmail.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Ondrej Jirman <megi@xff.cz>,
	"Leonardo G. Trombetta" <lgtrombetta@gmx.com>
Subject: Re: [PATCH v4 3/4] arm64: dts: rk3399-pinephone-pro: Add
 magnetometer sensor support
Message-ID: <aPi8OCA2OkvrGA+S@duo.ucw.cz>
References: <20250929-ppp_light_accel_mag_vol-down-v4-0-6598f22d3451@gmail.com>
 <20250929-ppp_light_accel_mag_vol-down-v4-3-6598f22d3451@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/IL2wEoASFvIAdD5"
Content-Disposition: inline
In-Reply-To: <20250929-ppp_light_accel_mag_vol-down-v4-3-6598f22d3451@gmail.com>


--/IL2wEoASFvIAdD5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> DEVICE=3D"/sys/bus/iio/devices/iio:device2"
>=20
> X=3D$(cat $DEVICE/in_magn_x_raw)
> Y=3D$(cat $DEVICE/in_magn_y_raw)
> Z=3D$(cat $DEVICE/in_magn_z_raw)
>=20
> X_MIN=3D$X; X_MAX=3D$X
> Y_MIN=3D$Y; Y_MAX=3D$Y
> Z_MIN=3D$Z; Z_MAX=3D$Z
>=20
> START_TIME=3D$(date +%s)

I wonder if we should create some simple gui tool for testing this and
accelerometer?

Anyway,

> Co-developed-by: Leonardo G. Trombetta <lgtrombetta@gmx.com>
> Signed-off-by: Leonardo G. Trombetta <lgtrombetta@gmx.com>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>

Reviewed-by: Pavel Machek <pavel@ucw.cz>


--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, Netanyahu and Musk!

--/IL2wEoASFvIAdD5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaPi8OAAKCRAw5/Bqldv6
8kxOAJwJ2rD4puXSmIpTlLg26wYcEZf5fQCgkJcbklr4Db1oSCPze/V0XUGuu/8=
=Z0vO
-----END PGP SIGNATURE-----

--/IL2wEoASFvIAdD5--


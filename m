Return-Path: <linux-kernel+bounces-874585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 835B7C16A10
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C74F1A25DD7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAF834F494;
	Tue, 28 Oct 2025 19:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVCLQu91"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AB2342C80;
	Tue, 28 Oct 2025 19:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761680107; cv=none; b=BCsP90rjM4L/pJ7irG46GDx8FGlZK1I8syBgxowoiXdUBAVjSZz3cXOnwrdXyYGC5DlIVCPUJv6fRRDYnRK0MhHv2aKdUUbJEiJV7WKN9Ud7aGdqhzzhWbYQsTgD/0m0R+deqY+7RPgUnGAjgOxvTxzmqndQglCoOjeMgSkVsgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761680107; c=relaxed/simple;
	bh=TduQ/dgw+UuyE9mcK4GdQk5Yb3BIZ3ZWL8E2yD0tmpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dL/E+eqW8n6CMFId++OdK5swGHJRiiOD2dNF1fzQFrQV3yuaxBUquHTSsQLBWXpxkmJltmfDLQwDSXsqvt7+XVfbt66hV5Lkx8j5PItp+jCaZLRg1Jk/xYxEiYT0v+AMIlO5XySaTHO+LYLWdHM6oQOsidaTSCiK89bZPLjcojI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVCLQu91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FDEC4CEE7;
	Tue, 28 Oct 2025 19:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761680105;
	bh=TduQ/dgw+UuyE9mcK4GdQk5Yb3BIZ3ZWL8E2yD0tmpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DVCLQu91cK4OpYffGRZamj+PPqPn5Gscu6EfUvTLNA37ubHqnxoEvi7lkRhEUGzDU
	 xL7ajaFSUyzXsA42/xVNQ4czWtB1MBMqhIvkJRa5prxJSIfw7Kp3H0aY6iGWN7cvqL
	 DU+ZyTgdHiNVEh+Qk5neaRJecK1qppidmbUgTxG/SAgKOouzYEupm1cElGJlXC0/wj
	 2E6l3/tTjg+U6Fn3iJozbSxLR97mwx/psasiVkUP0OIuaP5z2jOnFeBvBW90b/IXrU
	 qZAspKr2+91BJwhGzKLTFSBj6DP9hVzPDA6reyF6X5dxROzHoXO68NWvz2H5XBajRg
	 213VaXtJCbnKw==
Date: Tue, 28 Oct 2025 19:35:01 +0000
From: Conor Dooley <conor@kernel.org>
To: Coia Prant <coiaprant@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Dragan Simic <dsimic@manjaro.org>,
	Jonas Karlman <jonas@kwiboo.se>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: vendor-prefixes: Add NineTripod
Message-ID: <20251028-haste-amusing-78c28e834b5b@spud>
References: <20251026143645.917588-2-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Gl+av2e7HRT0n/2a"
Content-Disposition: inline
In-Reply-To: <20251026143645.917588-2-coiaprant@gmail.com>


--Gl+av2e7HRT0n/2a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 10:36:44PM +0800, Coia Prant wrote:
> Add NineTripod to the vendor prefixes.
>=20
> Signed-off-by: Coia Prant <coiaprant@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index f1d188200..37687737e 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1124,6 +1124,8 @@ patternProperties:
>      description: National Instruments
>    "^nicera,.*":
>      description: Nippon Ceramic Co., Ltd.
> +  "^ninetripod,.*":

Why ninetripod instead of 9tripod? That's what the company uses and in
the marketing fluff for the boards.

> +    description: Shenzhen 9Tripod Innovation and Development CO., LTD.
>    "^nintendo,.*":
>      description: Nintendo
>    "^nlt,.*":
> --=20
> 2.47.3
>=20

--Gl+av2e7HRT0n/2a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQEa5QAKCRB4tDGHoIJi
0lLpAQCEq5o2AIeBeKU/HTLGiRDFRwZsauzXLY1N19v7WOrccAEAk2K6wBMBRl7P
WXToJKSFpArrZz2WIkOYuL/UaqrZ8w4=
=1enS
-----END PGP SIGNATURE-----

--Gl+av2e7HRT0n/2a--


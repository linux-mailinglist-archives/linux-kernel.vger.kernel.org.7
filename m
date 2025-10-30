Return-Path: <linux-kernel+bounces-878931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BE3C21CB2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1D2E4E1CAC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9542E366FCB;
	Thu, 30 Oct 2025 18:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVJes9xZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C9F2D8779;
	Thu, 30 Oct 2025 18:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761849295; cv=none; b=Uq25sSXKeMy2tEpesXn133e/ONpOy5qw2tErwRMIqcqG34aWZCKX6jJafAAQwbCSxXTQkqH7iZPUKPwQn3U3Qj2wzFSSKJzRegbBnEttAAM0RcB7pzVEG/aEHuncuV/dy/tEtp+yKhPX/KnC33A01BPlPgHdn8L1WY1k0d1ZRBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761849295; c=relaxed/simple;
	bh=19dZGN/2hByWH5OvB7rCwr9tGLgsitN6UUruD1+2W6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crDb5GI6Ri+bd/FsREaXEArmI9/3b/ttZtY/mq6i6n6TR0iGqowNA3xZWqkGBpXhJqWmOau78ZXbrp7db5qnRBOO3toUoOLaRtsQ46Av6YIllIM+yim93hqgxxrDjWoJDzP8EsQNw4espVyJQC8wUUs1fkKpkIj0rPpfyycpWVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVJes9xZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E40C4CEF8;
	Thu, 30 Oct 2025 18:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761849294;
	bh=19dZGN/2hByWH5OvB7rCwr9tGLgsitN6UUruD1+2W6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EVJes9xZb67Y/8dNTIGJXu0HMKXdhgIVp91UY55fqScatzuvHuRVHU2rd5SOqqCso
	 KOiZQIADVLXJA7xmAGib3APWenetswqPARw+ZXduYiDdU0oMABqkRMsmdPKqiBWg7N
	 t9eRSZpu03Pm+u/fpkJiQ1A1nNqH6uFOdIc8P08zu5YNsUZeSH3xqe9ywXVHI5CtPK
	 gXx6JWTZg1SEN9Aevqu+ZjpovE3fm0ve0kQd5Hq5fWvvL+o8F9Zd+4SM6WcG2QTgk3
	 2bBZ0vjtLs19JJeQ0Yf97l5Mppsn6F7I1yE/wbwevsYoF6Nu20vZy9XN+EPe2yi1Bp
	 HN5B+vJ7HpPqw==
Date: Thu, 30 Oct 2025 18:34:49 +0000
From: Conor Dooley <conor@kernel.org>
To: maudspierings@gocontroll.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/6] dt-bindings: arm: fsl: Add GOcontroll Moduline
 IV/Mini
Message-ID: <20251030-unfailing-venue-e27a74ebab2d@spud>
References: <20251030-mini_iv-v3-0-ef56c4d9f219@gocontroll.com>
 <20251030-mini_iv-v3-1-ef56c4d9f219@gocontroll.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M5nFIgRaiFYSCzu6"
Content-Disposition: inline
In-Reply-To: <20251030-mini_iv-v3-1-ef56c4d9f219@gocontroll.com>


--M5nFIgRaiFYSCzu6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 07:35:37AM +0100, Maud Spierings via B4 Relay wrote:
> From: Maud Spierings <maudspierings@gocontroll.com>
>=20
> Document the compatible strings for the Moduline IV and Mini.

> Also add a compatible for the Ka-Ro Electronics TX8M-1610

This is not very helpful to say, makes what you've done seem accidental.
I assumed this was wrong, until I looked up this device and found out it
was a SoM. Please put that in the commit message.
With that info,
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: changes-requested

>=20
> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentati=
on/devicetree/bindings/arm/fsl.yaml
> index 00cdf490b0620..15000923b648a 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -996,6 +996,14 @@ properties:
>            - const: engicam,icore-mx8mm             # i.MX8MM Engicam i.C=
ore MX8M Mini SoM
>            - const: fsl,imx8mm
> =20
> +      - description: Ka-Ro Electronics TX8M-1610 based boards
> +        items:
> +          - enum:
> +              - gocontroll,moduline-iv-306-d
> +              - gocontroll,moduline-mini-111
> +          - const: karo,imx8mm-tx8m-1610
> +          - const: fsl,imx8mm
> +
>        - description: Kontron BL i.MX8MM (N801X S) Board
>          items:
>            - const: kontron,imx8mm-bl
>=20
> --=20
> 2.51.2
>=20
>=20
>=20

--M5nFIgRaiFYSCzu6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQOvyQAKCRB4tDGHoIJi
0pftAP4qv3RuQCQkYDQWrTB8t2YEBbGDaVO1XJqQOOzX/ElfLwD+O39KNZYTtmns
P40SiHPh/Xz+FOwiwDya6Zu/qAtzKQo=
=leRe
-----END PGP SIGNATURE-----

--M5nFIgRaiFYSCzu6--


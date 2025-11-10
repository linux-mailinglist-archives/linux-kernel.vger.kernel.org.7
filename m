Return-Path: <linux-kernel+bounces-893906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF8CC489EE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB5224E205F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AB930101C;
	Mon, 10 Nov 2025 18:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+1XNQ0g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077692E9EAE;
	Mon, 10 Nov 2025 18:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762800222; cv=none; b=oieMzv8XTSkwiGOsdzDezmqzcPPsT02tbX0a2VTUXSIrOdMAM57Jz3U2NGzk5QS1GfNpr/RyypL4x7iIMmNrS9w63OxjhyET2jdLz7DqUJYRAFGwFg5+uozZucmgTulPFdpt0lVDorSXEK6LxL70GYY1z1CHTSjyl9ofE8ermUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762800222; c=relaxed/simple;
	bh=DeBRnakymlJYR9KcihKOhaSs1gCeYKGx3st1JOBt6L0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1JYtpNhmgyTJT/ys8LiTdKJafqHfV8o4NzMNNmM5Ld83WUTm+UXy6Uyo9WwHcgtRc6pzDBlQTX/wYF4y1bJCreuK6dNh8wH0NFET/+4nTSVqIkRQqk5ncLpf1EcHUPEWDIfMf0MNpEroFPsPO9BUSxkud3TcjQD5QCW3qRU1TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+1XNQ0g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2DBEC16AAE;
	Mon, 10 Nov 2025 18:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762800221;
	bh=DeBRnakymlJYR9KcihKOhaSs1gCeYKGx3st1JOBt6L0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O+1XNQ0gCyIQm7z/Ot/HsJS1Wblv3dMU9feJOgYdjO746WBpTEKhJMnpsWnc4lR9F
	 t16MONTXdyF0V3HUmsOaLQIchNEXVgr013xYDlzA53CUsjwsBZcZk40dJBh4XvkZ3S
	 1bvOXLvzinRyVjWcTbhsNyqqpit00UnGmPE7b98aPvgeHhpHGrdzRoaBd0rJjh7taN
	 iWAwuw70sf4f+DxqMigT9VdVh71BIkPx/jFOGiVe7GzPt/+EIO8gZGNHbFHXSZfG5c
	 9yt/78OLUya7/Rr+wCO5JgYRxLVpJidG5mJeIDgxk/F5B9kYh6oIvAWtLwTrTeTrXn
	 iPA43mwiXAVWA==
Date: Mon, 10 Nov 2025 18:43:37 +0000
From: Conor Dooley <conor@kernel.org>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: phy: lan966x: Add optional
 microchip,sx-tx/rx-inverted
Message-ID: <20251110-unwound-award-a11d69b9da4f@spud>
References: <20251110110536.2596490-1-horatiu.vultur@microchip.com>
 <20251110110536.2596490-3-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rzGVrB2TxiTooTzC"
Content-Disposition: inline
In-Reply-To: <20251110110536.2596490-3-horatiu.vultur@microchip.com>


--rzGVrB2TxiTooTzC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 12:05:36PM +0100, Horatiu Vultur wrote:
> This allows to invert the N and P signals of the RX and TX Serdes
> signals. This option allows the board designer to trace their signals
> easier on the boards.

Why can't this just be done in software, debugfs or something like that?
Maybe it's just your description is poor, but sounds like the intention
here is to just switch things around for debug purposes.

>=20
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  .../phy/microchip,lan966x-serdes.yaml         | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/phy/microchip,lan966x-serd=
es.yaml b/Documentation/devicetree/bindings/phy/microchip,lan966x-serdes.ya=
ml
> index 6e914fbbac567..21b19e06a75aa 100644
> --- a/Documentation/devicetree/bindings/phy/microchip,lan966x-serdes.yaml
> +++ b/Documentation/devicetree/bindings/phy/microchip,lan966x-serdes.yaml
> @@ -41,6 +41,30 @@ properties:
>        - The macro to be used. The macros are defined in
>          dt-bindings/phy/phy-lan966x-serdes.
> =20
> +  microchip,s0-tx-inverted:
> +    type: boolean
> +    description: Invert the TX N and P signals for Serdes 0
> +
> +  microchip,s1-tx-inverted:
> +    type: boolean
> +    description: Invert the TX N and P signals for Serdes 1
> +
> +  microchip,s2-tx-inverted:
> +    type: boolean
> +    description: Invert the TX N and P signals for Serdes 2
> +
> +  microchip,s0-rx-inverted:
> +    type: boolean
> +    description: Invert the RX N and P signals for Serdes 0
> +
> +  microchip,s1-rx-inverted:
> +    type: boolean
> +    description: Invert the RX N and P signals for Serdes 1
> +
> +  microchip,s2-rx-inverted:
> +    type: boolean
> +    description: Invert the RX N and P signals for Serdes 2
> +
>  required:
>    - compatible
>    - reg
> --=20
> 2.34.1
>=20

--rzGVrB2TxiTooTzC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRIyWQAKCRB4tDGHoIJi
0ouDAPwJpjpkFjLf661KEAYdqJLgHmRtuR95WHAIW2ybif5l3AEAvATKO3J4SKQD
OIlE+Ps8vHUA9TAlvEeK+8+lNgi0zw4=
=hZdA
-----END PGP SIGNATURE-----

--rzGVrB2TxiTooTzC--


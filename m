Return-Path: <linux-kernel+bounces-851274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8CEBD5FE4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 21:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B207934FC9F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42992DAFA5;
	Mon, 13 Oct 2025 19:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="id2g8kpe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EEC2D3EC7;
	Mon, 13 Oct 2025 19:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760384693; cv=none; b=cGd51B7ES9zIqYpMmBY3ix461uK8sCKeAbBaKGIQ3vF3FrAMeOgt5rRhcc0nJRp/9LcOCkTF4U2Jm/oNVXIErKJUxNpVuxNKA3L4KCIebnDzROacWFd6N+SZyjMabDF0lfZOE9ZkGxz4GBVBF0CKVfxlzzP6+MIJAmsPAHHNeSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760384693; c=relaxed/simple;
	bh=E6/pf/UHO5d8TA7le9I1V6YxxiNG8tLSd+VRH9o46Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIYvPfTOUSyywpIXpPMHNWBYdmW6CMTiYexv8xAbt7+9N8SBMymu7FuxL98KMhESOKUq5AzAcaQnMuLf3X/oF+UpoOwt52pfK442wXdt58e9i3AU5vx38n0PW1OISFtv9yieMkC9oUXvYyc/4AkaYqfciCfDllwBh+yLnlgeCjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=id2g8kpe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C21C4CEFE;
	Mon, 13 Oct 2025 19:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760384692;
	bh=E6/pf/UHO5d8TA7le9I1V6YxxiNG8tLSd+VRH9o46Yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=id2g8kpeBR5QwQ6e0kXWljvUjTPSpyKdsb8J1BeAPFmyzUOGXSq6fs4e34eWqemi0
	 pED7RGJj7jmCfeuzJqxoaBGNiMrbw0JjlmQnGKfFg8fL4WoW5OjHCeKpmgka7jlVW0
	 Zlo6mcresiBg4OWQNhLXjIQ8SBWRX7eNTqA4gYRfgabt8CGCmRe8o+jV410mN8T3x2
	 KvctzSks6htq+3ZSw7K6mbTxlKBUY7/eKaICyrtXfSqxit5K5qCMngjJBv8e1tPBOk
	 qiRtX43mzj80iJqBWR1WdEqjgXUih6KELbeoiU4CqrjjFOWctVZV14jHDaT6Le/yIA
	 FxtB/0qGW3BEQ==
Date: Mon, 13 Oct 2025 20:44:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Richard Genoud <richard.genoud@bootlin.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Wentao Liang <vulab@iscas.ac.cn>, Johan Hovold <johan@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/15] dt-bindings: mtd: sunxi: Add H616 compatible
Message-ID: <20251013-parrot-sandpaper-4e31d2d1a6b3@spud>
References: <20251013152645.1119308-1-richard.genoud@bootlin.com>
 <20251013152645.1119308-15-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5/wzhoHrgV6FnNRe"
Content-Disposition: inline
In-Reply-To: <20251013152645.1119308-15-richard.genoud@bootlin.com>


--5/wzhoHrgV6FnNRe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 05:26:44PM +0200, Richard Genoud wrote:
> The H616 NAND controller is quite different from the A10 and A23 ones,
> some registers offset changed, and some new one are introduced.
> Also, the DMA handling is different (it uses chained descriptors)
>=20
> So, introduce a new compatible to represent this version of the IP.
>=20
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> ---
>  .../mtd/allwinner,sun4i-a10-nand.yaml         | 57 ++++++++++++++++---
>  1 file changed, 48 insertions(+), 9 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-na=
nd.yaml b/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.ya=
ml
> index 054b6b8bf9b9..4b82de9fae17 100644
> --- a/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
> +++ b/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
> @@ -6,9 +6,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
>  title: Allwinner A10 NAND Controller
> =20
> -allOf:
> -  - $ref: nand-controller.yaml
> -
>  maintainers:
>    - Chen-Yu Tsai <wens@csie.org>
>    - Maxime Ripard <mripard@kernel.org>
> @@ -18,6 +15,8 @@ properties:
>      enum:
>        - allwinner,sun4i-a10-nand
>        - allwinner,sun8i-a23-nand-controller
> +      - allwinner,sun50i-h616-nand-controller
> +
>    reg:
>      maxItems: 1
> =20
> @@ -25,14 +24,12 @@ properties:
>      maxItems: 1
> =20
>    clocks:
> -    items:
> -      - description: Bus Clock
> -      - description: Module Clock
> +    minItems: 2
> +    maxItems: 4
> =20
>    clock-names:
> -    items:
> -      - const: ahb
> -      - const: mod
> +    minItems: 2
> +    maxItems: 4

The clock descriptions and names should remain out here, with your new
min/max constraints, since they're identical at indices 0 and 1 to for
both types of device. The if/then should only set the min to 4 for the
new device and the max to 2 for the existing ones.

Cheers,
Conor.

pw-bot: changes-requested

> =20
>    resets:
>      maxItems: 1
> @@ -85,6 +82,48 @@ required:
> =20
>  unevaluatedProperties: false
> =20
> +allOf:
> +  - $ref: nand-controller.yaml
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - allwinner,sun4i-a10-nand
> +              - allwinner,sun8i-a23-nand-controller
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: Bus Clock
> +            - description: Module Clock
> +        clock-names:
> +          items:
> +            - const: ahb
> +            - const: mod
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - allwinner,sun50i-h616-nand-controller
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: Bus Clock
> +            - description: Module Clock
> +            - description: ECC Clock
> +            - description: MBus Clock
> +        clock-names:
> +          items:
> +            - const: ahb
> +            - const: mod
> +            - const: ecc
> +            - const: mbus
> +
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>

--5/wzhoHrgV6FnNRe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaO1WrgAKCRB4tDGHoIJi
0r4LAQDT8m+TkP4HrMMysI/Hu7Y+VtRgvMLmFVew9qCn3J+QbAD7BhGtjw9fUtP4
VHnuq+fhXnIRGUy0ntVx+tS+PGfOtgI=
=gy6j
-----END PGP SIGNATURE-----

--5/wzhoHrgV6FnNRe--


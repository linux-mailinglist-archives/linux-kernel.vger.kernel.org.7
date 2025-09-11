Return-Path: <linux-kernel+bounces-812655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE776B53AFF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37C8D1CC0092
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8190D35FC1D;
	Thu, 11 Sep 2025 18:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpEybyKX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D660032274C;
	Thu, 11 Sep 2025 18:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757613926; cv=none; b=A5pBCeaMo5BObwlZGQhek259OjaHfIvATfo6SHjxnPs4plQCp6yg8bJgztAZPyKLMisBqpQ4OYiLmpBnS5LdYL4Sluu9G8E25lQ3JTtluAySUyKSUvncct5y0mCmJpJ5IORbT7h3JJRB66RRWkdQ7N3kmE4QFlHZ0H0V/ia2KGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757613926; c=relaxed/simple;
	bh=2KNA9CUisSqGTNs+pjOvgziFv5NqIjtSrtlbLeja3pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhobPRSfMw7TE54yoH6x6uG/6jNK87VRdhUb8gps2YsAsApHXn3fsBzkPslQuAe95VkxTT0cNh1ICxCXtx0FwvjIilfFtMWI+1FxzjUqmmYaYwetux21/Qyp30ZY4Pq8AsPSG/kSWLTVX3A52nS49NV6HvHW/fw0feWGAftmJW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpEybyKX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2304CC4CEF0;
	Thu, 11 Sep 2025 18:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757613926;
	bh=2KNA9CUisSqGTNs+pjOvgziFv5NqIjtSrtlbLeja3pI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VpEybyKX/63+ZZb6qs2IoyyE4FvNCGP90GL62zJKk7I3msaMsZEF9Je3lm11LNcYl
	 3ilH5hwRhfIDQKRuUkuBJl6xw1xfSnqooP1IjChyM/T1GSdJCCbyJjRPHCdrQNcONe
	 sHVNKF6evlm9h5qWuTpxJzuU4gl7EkL++4SaavOhrhb2ruTMRu1P4AtSD448tGQ89n
	 ZLokA+XygCWCx9uGWyBQgLAPIztYDygimqgwZd8LtJCQg0Zfd+Pf8Jam9ZIOlbYaXO
	 kUVUXbfQ68Fpmk1J50JQrriEpRalPtv7ePIJhyA+zlPcTcEGzFIy5G1T1m35yYY7Vs
	 kpsxX79osoKpA==
Date: Thu, 11 Sep 2025 19:05:21 +0100
From: Conor Dooley <conor@kernel.org>
To: Cyrille Pitchen <cyrille.pitchen@microchip.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Russell King <linux@armlinux.org.uk>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] dt-bindings: gpu: add bindings for the Microchip
 GFX2D GPU
Message-ID: <20250911-iron-stadium-ea225e18bc42@spud>
References: <20250911-cpitchen-mainline_gfx2d-v1-0-d7fab1a381ee@microchip.com>
 <20250911-cpitchen-mainline_gfx2d-v1-1-d7fab1a381ee@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TFmC7SfvXiIlch8N"
Content-Disposition: inline
In-Reply-To: <20250911-cpitchen-mainline_gfx2d-v1-1-d7fab1a381ee@microchip.com>


--TFmC7SfvXiIlch8N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 05:26:25PM +0200, Cyrille Pitchen wrote:
> The Microchip GFX2D GPU is embedded in the SAM9X60 and SAM9X7 SoC family.
> Describe how the GFX2D GPU is integrated in these SoCs, including
> register space, interrupt and clock.
>=20
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@microchip.com>
> ---
>  .../devicetree/bindings/gpu/microchip,gfx2d.yaml   | 53 ++++++++++++++++=
++++++
>  1 file changed, 53 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/gpu/microchip,gfx2d.yaml b=
/Documentation/devicetree/bindings/gpu/microchip,gfx2d.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..e416e13bc6627a0fef3c70625=
a6a3e2d91636ffc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpu/microchip,gfx2d.yaml

Filename matching a compatible please.

> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpu/microchip,gfx2d.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip GFX2D GPU
> +
> +maintainers:
> +  - Cyrille Pitchen <cyrille.pitchen@microchip.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,sam9x60-gfx2d
> +      - microchip,sam9x7-gfx2d
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      const: periph_clk
> +    maxItems: 1

Why do you need clock-names if you only have one clock?
If there's a reason to keep it, drop the _clk - it's redundant.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/at91.h>
> +    gfx2d@f0018000 {

"gfx2d" is not a generic node name, I assume this should actually be
"gpu"?

Cheers,
Conor.

> +      compatible =3D "microchip,sam9x60-gfx2d";
> +      reg =3D <0xf0018000 0x4000>;
> +      interrupts =3D <36 IRQ_TYPE_LEVEL_HIGH 0>;
> +      clocks =3D <&pmc PMC_TYPE_PERIPHERAL 36>;
> +      clock-names =3D "periph_clk";
> +    };
> +
> +...
>=20
> --=20
> 2.48.1
>=20
>=20

--TFmC7SfvXiIlch8N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMMPYAAKCRB4tDGHoIJi
0mCPAQC6UaFapuUKAGnIg8753752/OZNLNqKf7dFbaRi37RaxwEAhSubE7nu3aOl
m3nlEqNOdGn2aVpzZhbXTywzoJ2zugg=
=NuVS
-----END PGP SIGNATURE-----

--TFmC7SfvXiIlch8N--


Return-Path: <linux-kernel+bounces-758080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7D3B1CA9A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C65F1755C4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF6D29AB1C;
	Wed,  6 Aug 2025 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOfxbTAo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5312F30;
	Wed,  6 Aug 2025 17:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754500957; cv=none; b=DLdW7ZcA9fFVgHoPiDm7cBKA0pO9vQeSSeKDbFguTtwLYyN7l6pIDTQ1kmyRwMM6G2k2myMhSKsrMDm0fEbYfBfLBME8HsWaq/825ygBlD47YLEBFHnc5NB7mxthjjxEA3nSy8a3Qby00MoIcIH32gucBcDJTMEZ7e14QsPFynY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754500957; c=relaxed/simple;
	bh=gYQ6c5dWzSfZxOgWBka1UO6gIcE9AQVGbQWooNNv3Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFZ6WzIBn6JPf0VPykeMhA4VRpb2Ctzp0E7QriHyBLfC2dXXcm+VYVUlBfnPqSRU56FvbTp5TlMlAM8PdJZfoY9p0zoLpA6fseMj3yjeFIc7Dz+Agfs5MMKFh7J77lQbxXvxrLON7yeDYhP8KUnxj7B6imlSn+4vxE7tkiiRi1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOfxbTAo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BBAC4CEE7;
	Wed,  6 Aug 2025 17:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754500957;
	bh=gYQ6c5dWzSfZxOgWBka1UO6gIcE9AQVGbQWooNNv3Tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AOfxbTAoG2YGp6j2BENEn/arpS/1dP3KamEWAaZ9w9o1+QUovQpw5cH9gP2szJyEC
	 xaMchNgDrWERluE/3baEOdMVQ97LmGXriveDnYcuQ2i/Bx1i94+vdWJwBR+c6cuEoH
	 CcX3YwvUswegmddUexuX95AZ0ZFvEIt3mrqiED2s8tQCO//Awhduj3DY66QDYQhcI8
	 fcTJpcLYA4iTzdH8m+e7rRDMy23wYd8V4et746RjY86oLnf8/KuQL5B/YwJ/Mf8K8O
	 eDIDkh0dG0ORioC3q4g0n9Gie5Pga5szbxWPiALr0I8XPeQbxfw6cyJXWftrnoVf0u
	 r61ssjfJxLdtA==
Date: Wed, 6 Aug 2025 18:22:32 +0100
From: Conor Dooley <conor@kernel.org>
To: Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: display: sitronix,st7920: Add DT schema
Message-ID: <20250806-contend-retread-066519296adc@spud>
References: <20250806-st7920-v1-0-64ab5a34f9a0@gmail.com>
 <20250806-st7920-v1-2-64ab5a34f9a0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1LYms6pz+HKcRlUi"
Content-Disposition: inline
In-Reply-To: <20250806-st7920-v1-2-64ab5a34f9a0@gmail.com>


--1LYms6pz+HKcRlUi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 06, 2025 at 02:48:10PM +0200, Iker Pedrosa wrote:
> Add binding for Sitronix ST7920 display.
>=20
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> ---
>  .../bindings/display/sitronix,st7920.yaml          | 55 ++++++++++++++++=
++++++
>  1 file changed, 55 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/sitronix,st7920.ya=
ml b/Documentation/devicetree/bindings/display/sitronix,st7920.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..caee85f98c6d242dfab737292=
10f8c34b23a3a99
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/sitronix,st7920.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/sitronix,st7920.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sitronix ST7920 LCD Display Controllers
> +
> +maintainers:
> +  - Iker Pedrosa <ikerpedrosam@gmail.com>
> +
> +description: |
> +  The Sitronix ST7920 is a controller for monochrome dot-matrix graphica=
l LCDs,
> +  most commonly used for 128x64 pixel displays.
> +  This binding supports connecting the display via a standard SPI bus.
> +
> +properties:
> +  compatible:
> +    const: sitronix,st7920
> +
> +  reg:
> +    description: The chip-select number for the device on the SPI bus.
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    description: Maximum SPI clock frequency in Hz.
> +    maximum: 600000
> +
> +  spi-cs-high:
> +    type: boolean
> +    description: Indicates the chip select is active high.

Don't redefine this, it's defined in spi-peripheral-props.yaml:
  spi-cs-high:
    $ref: /schemas/types.yaml#/definitions/flag
    description:
      The device requires the chip select active high.

spi-max-frequency's type comes from there, so you need it for that too.


> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    // Example: ST7920 connected to an SPI bus
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi0 {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        display@0 {
> +            compatible =3D "sitronix,st7920";
> +            reg =3D <0>; // Chip select 0
> +            spi-max-frequency =3D <600000>;
> +            spi-cs-high;
> +        };
> +    };
>=20
> --=20
> 2.50.1
>=20

--1LYms6pz+HKcRlUi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaJOPWAAKCRB4tDGHoIJi
0sA6AQCF0ossiP7vgh/45UnUA5I1avEKhd0F7ScxlmG+sn0wpwD+NHhKInkH4WMh
+ZgnvS3mmW0e0vj6/+mphoI7Nt9GyQQ=
=d4yO
-----END PGP SIGNATURE-----

--1LYms6pz+HKcRlUi--


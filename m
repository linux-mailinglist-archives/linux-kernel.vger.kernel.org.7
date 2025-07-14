Return-Path: <linux-kernel+bounces-730563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBC7B04655
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 19:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C604A6AC7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2224A264611;
	Mon, 14 Jul 2025 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/htzd6H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E97C2620EE;
	Mon, 14 Jul 2025 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752513606; cv=none; b=S6l9Qgnb24u4xD/ueSj4W9z7VjbkvZG7ToyZSWkBsTj5CqirMnoZBeNAy6AkfUEufkix7T4q8YQIkTlJgwYbEhudx1pXR9yo2+dmOpAC4RcrFQ0JG7Fwx0h5SeWDKt7PqzcdDtgJQzJ7adxpujm7fLUyP0lvGtFIQha4RN2SoBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752513606; c=relaxed/simple;
	bh=0ODI/jsAcxCH5rhpgaFia6B4eIQDi2ph6s1FsPgZ+6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jke0rhd/omxRaQkFWxpU2E/7dp9rzEWPzIzPJJ27gPaKe7HisvTA0yA5NpX8RQkDTyrD3v4K9gngE2ZpsOLsb8WR+XvD5WGsnvpPBBwg/QTEbGhiqbw1PuiXgEsi/DmbOMXY3iWrMxRN3VwQYsBBWRBb7/M89jXy9ZutE8mAOxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/htzd6H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B95C4CEED;
	Mon, 14 Jul 2025 17:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752513606;
	bh=0ODI/jsAcxCH5rhpgaFia6B4eIQDi2ph6s1FsPgZ+6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y/htzd6Hp6zny3Z+0zlKU2LkSYC76bHb05Wq+3xoKVaOXizVWaeKx79m9KlAg0eWr
	 38HivT9yRT+J95lxezSsdUdBAU9Xv4dX/ew7TC857vU3+olyDUVodEx67DORAhwX2X
	 Pkc47QNDSXTwi13IQNIhTNnId46gM4lA4vIuWMJZ8PlGy9VjyknYgIiGO2ASl3Ctnm
	 1mJnafp7fvCWICgt7QvRKXl60LgFd8cVBkKahKho3O/q3flFBSAbVKo9arNUrRs2Dj
	 CXRi4V3XqGOestTb+esKO9o+rTp8jKUWVY0cI9AmiinxsTO8oIfXu1YVcBuK1ntjH3
	 k4vJIEIvaC/3A==
Date: Mon, 14 Jul 2025 18:20:02 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] docs: dt: writing-bindings: Document compatible
 and filename naming
Message-ID: <20250714-espionage-overexert-c12cee88d1f4@spud>
References: <20250713-dt-bindings-docs-v2-0-672c898054ae@linaro.org>
 <20250713-dt-bindings-docs-v2-2-672c898054ae@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WLM5k3gfPFcYkZyK"
Content-Disposition: inline
In-Reply-To: <20250713-dt-bindings-docs-v2-2-672c898054ae@linaro.org>


--WLM5k3gfPFcYkZyK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 13, 2025 at 02:46:37PM +0200, Krzysztof Kozlowski wrote:
> Document established Devicetree bindings maintainers review practices:
>=20
> 1. Compatibles should not use bus suffixes to encode the type of
>    interface, because the parent bus node defines that interface, e.g.
>    "vendor,device" instead of "vendor,device-i2c" + "vendor,device-spi".
>=20
> 2. If the compatible represents the device as a whole, it should not
>    contain the type of device in the name.
>=20
> 3. Filenames should match compatible.  The best if match is 100%, but if
>    binding has multiple compatibles, then one of the fallbacks should be
>    used.  Alternatively a genericish name is allowed if it follows
>    "vendor,device" style.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

>=20
> ---
>=20
> Changes in v2:
> 1. New patch
> ---
>  Documentation/devicetree/bindings/writing-bindings.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/writing-bindings.rst b/Doc=
umentation/devicetree/bindings/writing-bindings.rst
> index a2d2afd099c0bd922cf12dcf49f5dffe6da748f1..e63de88385b5bc5859d8d9fca=
82bcf30380f3e73 100644
> --- a/Documentation/devicetree/bindings/writing-bindings.rst
> +++ b/Documentation/devicetree/bindings/writing-bindings.rst
> @@ -52,6 +52,10 @@ Properties
>       fallback if appropriate. SoC-specific compatibles are also preferre=
d for
>       the fallbacks.
> =20
> +   - DON'T use bus suffixes to encode the type of interface device is us=
ing.
> +     The parent bus node already implies that interface.  DON'T add the =
type of
> +     device, if the device cannot be anything else.
> +
>  - DO use a vendor prefix on device-specific property names. Consider if
>    properties could be common among devices of the same class. Check other
>    existing bindings for similar devices.
> @@ -101,6 +105,10 @@ Typical cases and caveats
>  - "syscon" is not a generic property. Use vendor and type, e.g.
>    "vendor,power-manager-syscon".
> =20
> +- Bindings files should be named like compatible: vendor,device.yaml. In=
 case
> +  of multiple compatibles in the binding, use one of the fallbacks or a =
more
> +  generic name, yet still matching compatible style.
> +
>  Board/SoC .dts Files
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
>=20
> --=20
> 2.43.0
>=20

--WLM5k3gfPFcYkZyK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaHU8QgAKCRB4tDGHoIJi
0kOeAQD/vwGwnRvBoukJ5yRUpP2Ses2/p9eO9KXrcWjZajGqmwD+OMxTN9Mpq9MC
R8oA+wmUmGh4nByOTBSpEKmu5EBN7Ag=
=x4W7
-----END PGP SIGNATURE-----

--WLM5k3gfPFcYkZyK--


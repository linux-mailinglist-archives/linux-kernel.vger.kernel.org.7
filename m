Return-Path: <linux-kernel+bounces-876827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2DFC1C754
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CC7CE34B6BF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43388351FA1;
	Wed, 29 Oct 2025 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKJO92+c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE4B34FF4E;
	Wed, 29 Oct 2025 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759232; cv=none; b=jw5MDLdeqEB0ykjjNar4q8WpbI/vfxuqMx0eYNst/nkTjg91ZOBzoZv2/tAql64+dNBbCJzfH/+CZrrknbEcTg5f1c+yxEAV/8DMjDdxB9fvBKuYDfTe91XwKwXQc0j120Wb7KnlLmfMhkEeXmKOTDdbrgNl8eObVxafRRf9fm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759232; c=relaxed/simple;
	bh=655Qm1zghE7kR+ommrUMLIsCzPbYJTWpOLztSRFlFN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXBMXHZvw3zoVQca0N+xhGM2PIG3rQwN1Usj4nXIOqzI9pJWtDpYNRa1ttN4+MT0HBK3q3UppXRpjybW5gYdaqTINbo/1ZoLEgJqrTxIIGQ9scpHVsAoA6ItVZe9KbqbkyQQKjgEE5BlEiAveS5tBUASNJxG9S7WM6/sqhVgb/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKJO92+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814A9C4CEF8;
	Wed, 29 Oct 2025 17:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761759232;
	bh=655Qm1zghE7kR+ommrUMLIsCzPbYJTWpOLztSRFlFN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QKJO92+cq1qPa3UJvnYzoK7NbmS0XK2eVnSUE5RtP2bllNcEGnkOjBVnXTgqECnTI
	 Gxfzb5P9REVV8qsE3vkPD/m61uX8C4+JXnzcyTvOrtGHisB5sye64Y/WhyNfJFgLaz
	 lz/RdZS3UR6S6lihCkzcbZhstijznfrIbLCmN3Cvx2QSwWHBM2QVAGyx5m99xfcg3a
	 ea89CBq19BSkoxP3yotmAkANcOQe/FvfNHKBN+H1QjDSGiB/MB11Wd/kXGCl59dk40
	 9jStJg6QcV1JLKUFWr19R5EutJeSYSh7s4MxGDGaXEXigHJItYjMUHaxoobrcYfCWp
	 TvY4yFQKoD8+A==
Date: Wed, 29 Oct 2025 17:33:48 +0000
From: Conor Dooley <conor@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mfd: syscon: introduce no-auto-mmio
 property for syscons
Message-ID: <20251029-ambiance-snooper-43dc00dcee68@spud>
References: <cover.1761753288.git.dan.carpenter@linaro.org>
 <230cf12861a4f0b9effc72522444d3e28c1de2c9.1761753288.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZqvK64s1Y52gkgpz"
Content-Disposition: inline
In-Reply-To: <230cf12861a4f0b9effc72522444d3e28c1de2c9.1761753288.git.dan.carpenter@linaro.org>


--ZqvK64s1Y52gkgpz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 08:27:05PM +0300, Dan Carpenter wrote:
> Generally, syscons are created automatically and accessed direclty via
> MMIO however sometimes syscons might only be accessible from the secure
> partition or through SCMI etc.  Introduce the no-auto-mmio property to
> tell the operating system that the syscon needs to be handled manually.

"System controller node represents a register region containing a set
of miscellaneous registers."

If this isn't actually a register region, but is instead an interface
provided by SCMI or whatever "secure partition" is (optee?), why is the
syscon compatible being used for the device in the first place?

Cheers,
Conor.

> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Document=
ation/devicetree/bindings/mfd/syscon.yaml
> index 657c38175fba..a0ad12ae0bee 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -245,6 +245,10 @@ properties:
>    resets:
>      maxItems: 1
> =20
> +  no-auto-mmio:
> +    type: boolean
> +    description: Prevents the syscon from being created automatically
> +
>  required:
>    - compatible
>    - reg
> --=20
> 2.51.0
>=20

--ZqvK64s1Y52gkgpz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQJP/AAKCRB4tDGHoIJi
0hI1AQDFYHdDflBdSUuSVwpprYoijqQftJFl+1trKx0ZwumahAEA2PUMhd44uvdk
Aq43laZ2VCzBECPTaog69xYYAPFwtw0=
=0Jsq
-----END PGP SIGNATURE-----

--ZqvK64s1Y52gkgpz--


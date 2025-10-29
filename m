Return-Path: <linux-kernel+bounces-876860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8FAC1C924
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D05884E3E3A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A701351FD6;
	Wed, 29 Oct 2025 17:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0p2IDbB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5EB2F6903;
	Wed, 29 Oct 2025 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759991; cv=none; b=Z4uEz7vEL5w091IuXJRKYYtqoqir3z2EMpI7XsNBKH7WndyvHz0QgiBaSJA4aSgt3qLQ2j8+irMNj6H6c65ZGvp/o4OQzDGf/rjkqo3Xxh86xb/cDadrT0VFEM/nIks2yGhWMgOZAumwMSAaJ/BKtPOLJEwPnvQpiGIvHg0c9iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759991; c=relaxed/simple;
	bh=0GcNG07yBfRtnGSr93AMWW49CLvHPWSaS1nz2iKTswE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqAKHeheeYm/avL9d60jp99WUfRewypk0H6LSJUACVJ5ZU6P88T6qqNzRcCnarjfr2Rx+MfRqsd/LdR3WkpH1LHm1Q+FrOqYZhebp2BbZJ8zYNWzYOIxoWghMTMkPuJ4zLXrD70DKLJY0BZRjzQesgYyAnXLraXYN6NcPTjtu24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0p2IDbB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789BBC4CEF7;
	Wed, 29 Oct 2025 17:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761759991;
	bh=0GcNG07yBfRtnGSr93AMWW49CLvHPWSaS1nz2iKTswE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K0p2IDbBJqpJmwtIeTEVsnYo0QJpsjZlqe1ZVIHj4PHCg86HDJmARAUin1VkOSR70
	 D+3GDz6085YArZjjDr5ZVy6oQiWazCfDa4kL5PZBZ+ei2Wxm8R5jcxF490I/id3K9D
	 inYQ+eDKiEBR+N3CsJqJBau+xaU42c+ZZLTCByn0PASfGZ6+V06JxSEukSFHWGsRXa
	 zVjZsZuBxs5Xkx+eKbCIq4fPurn122eBVrzpo6Kypo6nLI82svx11KeM1tmdEFa+q1
	 4tmaDL7xXdm9eitduCY3gPIm/j/wzqxxe1Wvm+yihqbX7o1MF4yHilK7GAYyIoe6NV
	 MpD3kNvRFiBnA==
Date: Wed, 29 Oct 2025 17:46:26 +0000
From: Conor Dooley <conor@kernel.org>
To: Ranganath V N <vnranganath.20@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
	khalid@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v3] dt_bindings: sound: ti,pcm186x: convert to dtschema
Message-ID: <20251029-figure-greeting-d2cd3b0106e1@spud>
References: <20251029-dtbs-v3-1-3cc162221c22@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wQDXzErXS/p83zou"
Content-Disposition: inline
In-Reply-To: <20251029-dtbs-v3-1-3cc162221c22@gmail.com>


--wQDXzErXS/p83zou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 10:53:04AM +0530, Ranganath V N wrote:
> convert the Texas Instruments PCM186x Universal audio ADC bindings
> to DT schema.
>=20
> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
> diff --git a/Documentation/devicetree/bindings/sound/ti,pcm186x.yaml b/Do=
cumentation/devicetree/bindings/sound/ti,pcm186x.yaml

> +properties:
> +  compatible:
> +    enum:
> +      - ti,pcm1862
> +      - ti,pcm1863
> +      - ti,pcm1864
> +      - ti,pcm1865

Usually we want the filename to match one of compatibles in the file,
rather than have wildcards.

Secondly, the subject is not really as expected for a binding, let alone
one in sound. It should be "ASoC: dt-bindings: ".

With those,
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: changes-requested

--wQDXzErXS/p83zou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQJS8gAKCRB4tDGHoIJi
0rY5AP9FCapP66GaWKhNgK2JNY0tM15uxn+NOJSXtxCTv+QGOwD/dW/JxlxLLUX0
JndN1+H6zOApYCqy9BE00Jy5enqN/Qw=
=tUb6
-----END PGP SIGNATURE-----

--wQDXzErXS/p83zou--


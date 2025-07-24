Return-Path: <linux-kernel+bounces-744698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67135B10FEC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 143187BA156
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42142E9EBA;
	Thu, 24 Jul 2025 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6Mui2C5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F831885AB;
	Thu, 24 Jul 2025 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753375910; cv=none; b=kzOBApAPxN9OWmCST61LlhyjCdycECr4URKOOwo+4c3GswZlwPEA3bSEpuzj4+pUiZZ6OLyBWYSz8AlQ0AKbnB3tVedMKM6UEGfssVQaPZU1O9wZjAG3KRitjHu4Iafj8Z2CY6d/JN0drvN5aqGboTW3G89dYjiky5JTUx+6NNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753375910; c=relaxed/simple;
	bh=/qsjcK1VomkE6apG8nnNlFvhA9m0+QqNzjR+5Fxg+Is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irPkGBjZ92oJ0e4NwW5fzsE8yosRle6aN6ZcL7B7S+lakZK6rBAGBC50sBsfnTbgWfut1Fh7i/CwSZx4J+YoxUfCcIMwSkL3uciZTLXGZqcC/+pBC1GLkSIbSmNpt484CFwByin/nzl14OnRW2SB4YhrWvX65Rj4SqLygw6va9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6Mui2C5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE55C4CEED;
	Thu, 24 Jul 2025 16:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753375909;
	bh=/qsjcK1VomkE6apG8nnNlFvhA9m0+QqNzjR+5Fxg+Is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y6Mui2C5tmXU92YDRwif2Mv8GN3Rww19l97ok3n4wucIqTW0YYNIzW3tVdnGxY3JX
	 xuAGIYiPsPaCOoXjQUWgIDrVFz/G8GxIBdEffgFAJ/YAaTadlAJIGX+917xzE2HtIo
	 E6kkxS3nQUm6udeXCgLtede73JjXH+MfRbN4X3HivD2rHdniDyPw/MwIXgM8GIjdFW
	 IG6zKKzjQeyzjqjkMvGNBpaYCNxyMXt4aGTPhacUpnLEpVEF7R5UNO8kgev+g6Us48
	 PgV86blSd9jc+illN6kiLcgvSrT4X+UGN4n7od+vVnebf53fqWMq9IAddqZADolhQe
	 Kxrxq6W+WlOLg==
Date: Thu, 24 Jul 2025 17:51:45 +0100
From: Conor Dooley <conor@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: starfive: jh7110-common: drop no-sdio
 property from mmc1
Message-ID: <20250724-equal-limb-2922f240961e@spud>
References: <20250724075600.239522-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cnNW1JdvRKUTQWKq"
Content-Disposition: inline
In-Reply-To: <20250724075600.239522-1-e@freeshell.de>


--cnNW1JdvRKUTQWKq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 12:55:53AM -0700, E Shattow wrote:
> Drop no-sdio property avoids a delete-property on variant board dts
> having an SDIO wireless module connected to mmc1.

I'm struggling to understand why this change is correct.

If there are specific boards that have wireless modules connected
instead of using sdcards, how come the no-sdio property isn't moved to the
the boards that do have sdcard slots?
The property was added for the visionfive 2, and only on mmc1, so should
it be retained for boards that match the visionfive 2 in terms of how
they use mmc?

Could you add an explanation for why removing this entirely is the right
thing to do, rather than only removing it for these variant boards?

Cheers,
Conor.

>=20
> Signed-off-by: E Shattow <e@freeshell.de>
> ---
>  arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv=
/boot/dts/starfive/jh7110-common.dtsi
> index 2eaf01775ef5..a315113840e5 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> @@ -299,7 +299,6 @@ &mmc1 {
>  	assigned-clock-rates =3D <50000000>;
>  	bus-width =3D <4>;
>  	bootph-pre-ram;
> -	no-sdio;
>  	no-mmc;
>  	cd-gpios =3D <&sysgpio 41 GPIO_ACTIVE_LOW>;
>  	disable-wp;
>=20
> base-commit: 28fa0dcb571ab8f3be4d919f0e20e01d4e44bcb1
> --=20
> 2.50.0
>=20

--cnNW1JdvRKUTQWKq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaIJkoQAKCRB4tDGHoIJi
0nruAP4xPM53+ej1ekU6nUQOQC/2pzo3n5HZ/BIJTBv4xIrFnwEA5r77WDc8ja6u
5CLU8h7EQVS/wCiiIrq3JkQUwk+NNww=
=QPBu
-----END PGP SIGNATURE-----

--cnNW1JdvRKUTQWKq--


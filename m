Return-Path: <linux-kernel+bounces-776314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A140EB2CBB1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C4E81BC842C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445A730F524;
	Tue, 19 Aug 2025 18:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bU/kEK1K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F684EEDE;
	Tue, 19 Aug 2025 18:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755627220; cv=none; b=QLBDpqq3RgfaI6eDxFS+htZhBPEJn+nKc6DQFn4pIME920DpBItD1Y9s1lhIasSpO+2SxPoiAv8rqtzq933ei/hI8i5q0a+fWNGmghjGqUNbl3k8FsVDLxs1LpY+/Ga/8YhmwMPrXQcEXsRJaSwalDUDtea5rgaIWzsfsogxOO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755627220; c=relaxed/simple;
	bh=KpvPL2aa1SINbF9+aQNQrZ61uMnyrWTf51xfQ5aKQRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8LPUACgtQBSf4gQ+t1QA7yEMIaQyLrKcrqAyVa0kSmx4EOzwN/9AMQxR3bakvYZ0HPQFHIfueHOeZqrjqqxkwAIdstE5fOX5qNeOGtbA6ybe6GA1Vkzb7g/yjiK3lFHmRKDczSb60VO1BqVEf1LHxSHDsZRYSeGksqU4R8I7tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bU/kEK1K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C64EC16AAE;
	Tue, 19 Aug 2025 18:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755627220;
	bh=KpvPL2aa1SINbF9+aQNQrZ61uMnyrWTf51xfQ5aKQRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bU/kEK1KAuwIyAzv3AUR7Zqhso85eaRZLKIgaj2rVHGE6tFvTO/ViepXxzzQDnqOX
	 jEPgFw3N2mtxEwVlFLGMv3HjfATY6f85xggSTgLuDslh8Jg+qmSAFnWosmxmp433Y3
	 OkBa/aYHSBE3gtdDWSk0emTgJ2THXPc2WeQ5pyRBpj/m5JcsZzfFAjXK6b4gk1nRor
	 Jj/7rUMrDYKmJL509RfvCKXbPrA+Ln/UNdzd6QKLEp3GaG4z88tdj8x2nLFwAOyGeX
	 obsQ3ryuo79NPNLm01A1HwIw1uomZkJWfgDCXc3ZIqJMCgWH5a0uiFsWonkqeMnHT/
	 j14dae9pUEQgA==
Date: Tue, 19 Aug 2025 19:13:35 +0100
From: Conor Dooley <conor@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hal Feng <hal.feng@starfivetech.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2] riscv: dts: starfive: jh7110-common: drop no-sdio
 property from mmc1
Message-ID: <20250819-sushi-change-1254c2d2a08d@spud>
References: <20250729141142.13907-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+sm/HGNSxtTF3UeQ"
Content-Disposition: inline
In-Reply-To: <20250729141142.13907-1-e@freeshell.de>


--+sm/HGNSxtTF3UeQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 07:11:35AM -0700, E Shattow wrote:
> Relax no-sdio restriction on mmc1 for jh7110 boards. Property was
> introduced for StarFive VisionFive2 dts to configure mmc1 for SD Card
> but this is not necessary, the restriction is only needed to block use of
> commands that would cause a device to malfunction.
>=20
> Signed-off-by: E Shattow <e@freeshell.de>

I'm going to apply this one to for-next, to give it more of a chance to
soak.

> ---
>  arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv=
/boot/dts/starfive/jh7110-common.dtsi
> index 4baeb981d4df..b156f8703016 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> @@ -290,7 +290,6 @@ &mmc1 {
>  	assigned-clock-rates =3D <50000000>;
>  	bus-width =3D <4>;
>  	bootph-pre-ram;
> -	no-sdio;
>  	no-mmc;
>  	cd-gpios =3D <&sysgpio 41 GPIO_ACTIVE_LOW>;
>  	disable-wp;
>=20
> base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
> --=20
> 2.50.0
>=20

--+sm/HGNSxtTF3UeQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKS+zgAKCRB4tDGHoIJi
0h8zAPsEZlSydbDhSSY6HK5fbO8Q2t/BWSTx9sJrPaJSoqzKxwD/cZmCHPLsQpJ1
LjxgMVRbqLLWQ0fpBuU/6TlManpKJQI=
=orR2
-----END PGP SIGNATURE-----

--+sm/HGNSxtTF3UeQ--


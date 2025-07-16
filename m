Return-Path: <linux-kernel+bounces-733856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE81AB079EF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ADE1188E888
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF712F4A16;
	Wed, 16 Jul 2025 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rARbwgUs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CAF2F3C2F;
	Wed, 16 Jul 2025 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679735; cv=none; b=AuuHf6aNl5eYAKqcQtxPbSvd8mR8D3Tf+pf6jS182OMLsMCDaZefNpAItAups1uqr8iSON7ThP2RZTiwzBBJMind20i9gwPyghBoY8kz4f4ImzaQUNnjEunbBnosqUjoMkSyDG20q5zFg9VCZc7d7SDs8KqpVkQ7fEWZ13mklJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679735; c=relaxed/simple;
	bh=W7/nF4nRS7uBsdUOXm4KZyyGIpg2xdza86j5sSDU6u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7cCAa0XjO1djM8dKyfqEo/jEqi6R1oBlIrLAp3CLM1YKLWSU8FKATnKsgf8ZHLucd0TODRrm4AXuU8UjIBeYXkqI1c58lGSBYW7sDebFlGicz9XcacgBzRBZuDCqH40zM0LDzCHwNye0XEU3dPA36N2Rj77LMbkP0AJSq14xRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rARbwgUs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87112C4CEFB;
	Wed, 16 Jul 2025 15:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752679734;
	bh=W7/nF4nRS7uBsdUOXm4KZyyGIpg2xdza86j5sSDU6u0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rARbwgUsAjng6lF/GLnPocNjSAEvIWzWDIlaoMOY6lk5eRuu1mRyksLfb8amzCXCC
	 2jVKGrVrLbjQoTnVkFhoIi8ZyevF6y6IukM6eTFtRZ7upaonmHbpc9upomkegDv4gO
	 zgn8wnHKjohTTblrvSBkoUBUgAaUKy0U83Vupbr/EZInnuwS8e+/sl08b93bC5vzBe
	 fO2SSUbZJMsps7xJcqjgG4uT2WP9NRZXf9jTMLnTqNZf8hs+9lPUnHoQIw6HzuFTOp
	 d9/k5WqPzS1hNOlVpf7uznqt+0qvVyiTi9yHBvuRm/kTkqg0pH8eVWNbAq/f5piROT
	 JalxIHcAwjfZg==
Date: Wed, 16 Jul 2025 16:28:48 +0100
From: Conor Dooley <conor@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: starfive: jh7110-common: add status power
 led node
Message-ID: <20250716-wind-slum-99dd6ea87f63@spud>
References: <20250716040500.178287-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gJsZFKFkJNRPOfmS"
Content-Disposition: inline
In-Reply-To: <20250716040500.178287-1-e@freeshell.de>


--gJsZFKFkJNRPOfmS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 09:04:54PM -0700, E Shattow wrote:
> Add status power led node for StarFive VisionFive2 and variant boards.
>=20
> Signed-off-by: E Shattow <e@freeshell.de>

Again, I'll grab this too but it may be too late for 6.17.

> ---
>  arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv=
/boot/dts/starfive/jh7110-common.dtsi
> index 4baeb981d4df..2eaf01775ef5 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> @@ -8,6 +8,7 @@
>  #include "jh7110.dtsi"
>  #include "jh7110-pinfunc.h"
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
>  #include <dt-bindings/pinctrl/starfive,jh7110-pinctrl.h>
> =20
>  / {
> @@ -38,6 +39,14 @@ gpio-restart {
>  		priority =3D <224>;
>  	};
> =20
> +	leds {
> +		compatible =3D "gpio-leds";
> +
> +		led_status_power: led-0 {
> +			gpios =3D <&aongpio 3 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
>  	pwmdac_codec: audio-codec {
>  		compatible =3D "linux,spdif-dit";
>  		#sound-dai-cells =3D <0>;
>=20
> base-commit: 155a3c003e555a7300d156a5252c004c392ec6b0
> --=20
> 2.50.0
>=20

--gJsZFKFkJNRPOfmS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaHfFMAAKCRB4tDGHoIJi
0nHrAQCuSUXdyXMzRbJ71XIKKoxszblhLou5bzCekA/VDn3EpgEAsM5AyvNBusEW
YY48xUFjRW0+f7RaTuMdbz+UgJdk5w4=
=cCou
-----END PGP SIGNATURE-----

--gJsZFKFkJNRPOfmS--


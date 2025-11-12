Return-Path: <linux-kernel+bounces-897979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BFBC54104
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E82703B0328
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E5A329C72;
	Wed, 12 Nov 2025 19:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcFvJEfK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E1F33B961;
	Wed, 12 Nov 2025 19:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762974407; cv=none; b=XV6W2cGLXQUF4q/sJ5p7SMYMwOvLyCZ11dKWFAR72ZQ7T8XaOn1EQ31kgyKCOp8XuIhznV1X9TcfHUIZVI4wui7M4O7yOMppjN9bMHBR9IMbNMgj4oce1o7jTcLbyWKkqCRuFPXzPtJlctTJBgfJslIVahcMGoJKvJbJyVTHdEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762974407; c=relaxed/simple;
	bh=GIbd6MD47NH11JySYSxBrFY7Iy0t51QXyCzM1GwsUlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErM4EpN+biGzms9WRycEQSLfUhbQqlvAusGAKA5HA7JrluABUNcipBld2eiHVOcTNmg5PBdKZHKT3VKFt62OXfBle6sRXHHtFgAGaZK88Fq1eQr9ScA3njzcwvwM0Es4QjEJ3mzp//j/TdfFEHcxVziFxCTgtZKsWmz7VbQwrAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcFvJEfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBAC9C113D0;
	Wed, 12 Nov 2025 19:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762974406;
	bh=GIbd6MD47NH11JySYSxBrFY7Iy0t51QXyCzM1GwsUlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WcFvJEfKxeJmLjevg1Z4Vyq2HsT8biL2rJ2rUzQzcvfvjuwb+MAWn5/n3UMo7hWvI
	 Bo6LTOBVB6zWLmVICckx9PDu01TJxtFnWX+EsOnfpPRHKzT9rVQVuFVoVCrdwpDkn3
	 /zxK2Rn0xycRpz8+MVGStA2WQcFSibvRY2h2wk1nb+QMywoo49n+8k4tNEoah99323
	 8gjF4+3m1gpKbUgqlGbecIldltjyxLmEqluawnABK+9wTpJ075lUQTBBdJdqaTvMo7
	 rRENs7vsPUoQSK6n6GPNSfyW1+tESPEzPJoSj4V789GLje7xNeoaVP9BBztfP8XnMt
	 T4yvbHU7HMOjQ==
Date: Wed, 12 Nov 2025 19:06:42 +0000
From: Conor Dooley <conor@kernel.org>
To: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Robin Gong <yibin.gong@nxp.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: regulator: pca9540: add debounce
 timer configuration
Message-ID: <20251112-battered-handful-35937a12aafe@spud>
References: <20251112163311.720331-1-martijn.de.gouw@prodrive-technologies.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="icvERwW864wMe76K"
Content-Disposition: inline
In-Reply-To: <20251112163311.720331-1-martijn.de.gouw@prodrive-technologies.com>


--icvERwW864wMe76K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 05:33:08PM +0100, Martijn de Gouw wrote:
> Make the different debounce timers configurable from the devicetree.
> Depending on the board design, these have to be set different than the
> default register values.
>=20
> Signed-off-by: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>
> ---
>  .../regulator/nxp,pca9450-regulator.yaml      | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regu=
lator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regula=
tor.yaml
> index a5486c36830f0..3d47390f13016 100644
> --- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.y=
aml
> +++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.y=
aml
> @@ -124,6 +124,30 @@ properties:
>        When WDOG_B signal is asserted a warm reset will be done instead o=
f cold
>        reset.
> =20
> +  nxp,pmic_on_req-on-debounce-us:
> +    enum: [ 120, 20000, 100000, 750000 ]
> +    description: Debounce time for PMIC_ON_REQ high.

I left some comments on v1, one a question and one a request for a
change. Please go take a look. Since you'll need a v3
pw-bot: changes-requested
(Please also give a bit more time between revisions for people to go
through their mail queues)

> +
> +  nxp,pmic_on_req-off-debounce-us:
> +    enum: [ 120, 2000 ]
> +    description: Debounce time for PMIC_ON_REQ is asserted low
> +
> +  nxp,power-on-step-ms:
> +    enum: [ 1, 2, 4, 8]
> +    description: Time step configuration during power on sequence
> +
> +  nxp,power-down-step-ms:
> +    enum: [ 2, 4, 8, 16 ]
> +    description: Time step configuration during power down sequence
> +
> +  nxp,restart-ms:
> +    enum: [ 250, 500 ]
> +    description: Time to stay off regulators during Cold reset
> +
> +  npx,pmic_rst_b-debounce-ms:
> +    enum: [ 10, 50, 100, 500, 1000, 2000, 4000, 8000 ]
> +    description: PMIC_RST_B debounce time
> +
>  required:
>    - compatible
>    - reg
> --=20
> 2.39.2
>=20

--icvERwW864wMe76K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRTawgAKCRB4tDGHoIJi
0r3aAP0WQQCt5EChIE1S/Okwx+DLZQ9g11O0ui3OlzppLB3M1AEAt2zDCRrcClvf
AGye5S2AfE1wQIb+4wC5fyyy99ha/wc=
=boMk
-----END PGP SIGNATURE-----

--icvERwW864wMe76K--


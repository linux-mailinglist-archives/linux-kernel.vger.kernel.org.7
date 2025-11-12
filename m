Return-Path: <linux-kernel+bounces-897963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E7BC54028
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 16CB53459C5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E476934B663;
	Wed, 12 Nov 2025 18:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2y+mAx5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314C934AAFB;
	Wed, 12 Nov 2025 18:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762973497; cv=none; b=HhFkG4IXYfJC+MRg17082Kcg89fHxcAN6utlnOx0IN3O/dtjprX4C4BBfDzXQi1Q/qBCPsVGIuaIJaYZGzkDD7ougihC6X0WHVXmeUcUQPlwYbQ9yQQsBahL7DQpli/Nt+VmRe+PMQn8A5muy0rpjNQamkxS4v2MC27T/fd0s4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762973497; c=relaxed/simple;
	bh=sBTcLveD/UZnNJ/cSBjDDlFv4bZw6V6Ta/fJPIfzI6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBSFR5NRhHAGgz3lkUY93bZZbCHz4gygG3L0cyBBnIV4y9pVco5wcwYngnaOeNJ/GARlSBEeoQW7N5C8vhu4U58xjFqk0ZTrZDUnKNnlwkucHtKlhr2WqVe1bq0Jy+xLKhjjB6TFsJP/C44Nek2RkYR9wf3qgUyBgp4V0p/jRqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2y+mAx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF00C16AAE;
	Wed, 12 Nov 2025 18:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762973496;
	bh=sBTcLveD/UZnNJ/cSBjDDlFv4bZw6V6Ta/fJPIfzI6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F2y+mAx5JIDbvtkmJ1/3FZnnja4tYEMxRM3xqpvwjrDS+iqh61Pxk0VqahwonfBu9
	 WPpkuEzO4BH0fjmuJKXY3vZ5UaR9yO1MOK75qb3mcQDCKXTHOc997b1LjWf5HGWbee
	 yaegsSP7F/OsVrYjuMJC40V0ZQ1Nd17tjHsRtiVAxeq5xwX+TxNeW+/IHgL5uI8GjN
	 cn36xftHOGmSMlovoYpzWGXOj0l37jktodgtgZ6jRu8XB92eUjkRRVfBQ1c8wo7JFt
	 Lz+C9XKC6bTbdygzPDxt/ikVA5ujv7WwOn5fG0htQkVjRBJZNCMFJockiSAJfFUcgA
	 +TOMMA+MLvPag==
Date: Wed, 12 Nov 2025 18:51:32 +0000
From: Conor Dooley <conor@kernel.org>
To: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Robin Gong <yibin.gong@nxp.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: regulator: pca9540: add debounce timer
 configuration
Message-ID: <20251112-cultivate-freehand-596455d47ee5@spud>
References: <20251112121710.2623143-1-martijn.de.gouw@prodrive-technologies.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="COxGVMI2WRe60wMC"
Content-Disposition: inline
In-Reply-To: <20251112121710.2623143-1-martijn.de.gouw@prodrive-technologies.com>


--COxGVMI2WRe60wMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 01:17:08PM +0100, Martijn de Gouw wrote:
> Make the different debounce timers configurable from the devicetree.
> Depending on the board design, these have to be set different than the
> default register values.
>=20
> Signed-off-by: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>
> ---
>  .../regulator/nxp,pca9450-regulator.yaml      | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regu=
lator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regula=
tor.yaml
> index a5486c36830f0..e49acadabc4b0 100644
> --- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.y=
aml
> +++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.y=
aml
> @@ -124,6 +124,36 @@ properties:
>        When WDOG_B signal is asserted a warm reset will be done instead o=
f cold
>        reset.
> =20
> +  nxp,pmic_on_req-on-debounce-us:

While you're solving the bot complaints, replace the _s with -s.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 120, 20000, 100000, 750000 ]
> +    description: Debounce time for PMIC_ON_REQ high.
> +
> +  nxp,pmic_on_req-off-debounce-us:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 120, 2000 ]
> +    description: Debounce time for PMIC_ON_REQ is asserted low

These enum values are kinda strange. The only two options are 120 and
2000 or are those max and min? Not super suspect since there's partial
matching with the req-on property but weird enough to ask about ;)

> +
> +  nxp,power-on-step-ms:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 1, 2, 4, 8]
> +    description: Time step configuration during power on sequence
> +
> +  nxp,power-down-step-ms:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 2, 4, 8, 16 ]
> +    description: Time step configuration during power down sequence
> +
> +  nxp,restart-ms:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 250, 500 ]
> +    description: Time to stay off regulators during Cold reset
> +
> +  npx,pmic_rst_b-debounce-ms:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 10, 50, 100, 500, 1000, 2000, 4000, 8000 ]
> +    description: PMIC_RST_B debounce time
> +
>  required:
>    - compatible
>    - reg
> --=20
> 2.39.2
>=20

--COxGVMI2WRe60wMC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRTXNAAKCRB4tDGHoIJi
0iX1AP0XQN/9RxGV3+VLMqObhhZ2ATmZpbdo/p/UEXby3trUugEA4B105k76+JRc
SnFbH8fUp+vQikMYpWw4tyhfRwqI+gE=
=ZiXN
-----END PGP SIGNATURE-----

--COxGVMI2WRe60wMC--


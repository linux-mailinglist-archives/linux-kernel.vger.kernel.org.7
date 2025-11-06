Return-Path: <linux-kernel+bounces-889188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B4782C3CEAE
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06A424ECB15
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 17:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACDE34EF04;
	Thu,  6 Nov 2025 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmQK3NK/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADEB30E0F7;
	Thu,  6 Nov 2025 17:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762451082; cv=none; b=ECPLwRaq4NQmBG3jsnzH1+WVHoeSOeevyZuVBi0pkfMBc+rgoBPsXIvNx2EWPWg0EA7HFrDIoF1UmjEA8AMXNOY/hm+tQcVUxkBP5VN41GhbkU5YFKjkVsljoyTmL+yB7Q2U4j/0SfuyTJK0LKqub7LmESqd6YuW2aNYK7PhSug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762451082; c=relaxed/simple;
	bh=s+hOfpwfVBSoBV09E+QkoZp1hloRIcTVQh6C7/aLE14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZU2w/tFCsSXCHZAJ8JHR3hN5ID0gRhzb+3X7R1sVHEcdoxq2Dk85A1JdyjAktUiy435YsmJmpV8RXrSURxht7tGgRzEQJweZfKw7d88viYsZaHsqsneJKceXHZoffW7MNWrsW2lLmcxw0Wl8HHNd+smNLFdF9UNWuOwrmPH/6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmQK3NK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537F2C4CEFB;
	Thu,  6 Nov 2025 17:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762451081;
	bh=s+hOfpwfVBSoBV09E+QkoZp1hloRIcTVQh6C7/aLE14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JmQK3NK/k9EkXb6/MfI17SXwa3NF/9LE4cGV9CXpIPVTWUS+D6maDS+Hx2v2sznsz
	 HPDK3oE6XYv0Ko4jBSUmTEq5KXI42A6XhKf5+y8S8NoUrRfk9RTifi/hi4LL4+Ib6T
	 ROb/8UmLf9vacQJtf1/v7sFTfUbPDFnvZJF23LHofZD9N1awX6mdrMU8OBmSz9ahhJ
	 oHJt3cjKYMsUfI1N1y7tsWMh3qAC0pK7zTIdU8edfMFD2ujG31k59FoMe37n08oS9P
	 OXehpgliJR8aVcQ6Ev1C8KOSytgbGaTFJ59R5Lo98ggdWJfUazHY5/ub1ZuGgjE2bK
	 l/lpaXuVZF3ww==
Date: Thu, 6 Nov 2025 17:44:36 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: clock: imx6ul-clock: add optional clock
 enet1_ref_pad
Message-ID: <20251106-seventeen-gilled-5146c6dc9720@spud>
References: <20251105-ccm_dts-v1-0-6aadcdf97cb8@nxp.com>
 <20251105-ccm_dts-v1-1-6aadcdf97cb8@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="faLTa5Z8RzHut49n"
Content-Disposition: inline
In-Reply-To: <20251105-ccm_dts-v1-1-6aadcdf97cb8@nxp.com>


--faLTa5Z8RzHut49n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 05, 2025 at 11:55:28AM -0500, Frank Li wrote:
> Add optional clock source enet1_ref_pad, which input from ENET ref pad.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/clock/imx6q-clock.yaml  | 4 ++++
>  Documentation/devicetree/bindings/clock/imx6ul-clock.yaml | 4 ++++
>  2 files changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.yaml b/D=
ocumentation/devicetree/bindings/clock/imx6q-clock.yaml
> index cd3c04c883df4ab02af29582369757df36269cb6..49475aec22a81ba87048eef58=
8368261cbb38465 100644
> --- a/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> @@ -29,20 +29,24 @@ properties:
>      const: 1
> =20
>    clocks:
> +    minItems: 4
>      items:
>        - description: 24m osc
>        - description: 32k osc
>        - description: ckih1 clock input
>        - description: anaclk1 clock input
>        - description: anaclk2 clock input
> +      - description: clock input from enet1 ref pad
> =20
>    clock-names:
> +    minItems: 4
>      items:
>        - const: osc
>        - const: ckil
>        - const: ckih1
>        - const: anaclk1
>        - const: anaclk2
> +      - const: enet1_ref_pad

I think you could drop the _pad from here, and just make it enet1_ref.
Only a suggestion though,
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

> =20
>    fsl,pmic-stby-poweroff:
>      $ref: /schemas/types.yaml#/definitions/flag
> diff --git a/Documentation/devicetree/bindings/clock/imx6ul-clock.yaml b/=
Documentation/devicetree/bindings/clock/imx6ul-clock.yaml
> index d57e18a210cc1d8a836b50058613dfb0308fbf11..035002721a3b3b65fe67734e1=
3b686b91539f328 100644
> --- a/Documentation/devicetree/bindings/clock/imx6ul-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/imx6ul-clock.yaml
> @@ -29,18 +29,22 @@ properties:
>      const: 1
> =20
>    clocks:
> +    minItems: 4
>      items:
>        - description: 32k osc
>        - description: 24m osc
>        - description: ipp_di0 clock input
>        - description: ipp_di1 clock input
> +      - description: clock input from enet1 ref pad
> =20
>    clock-names:
> +    minItems: 4
>      items:
>        - const: ckil
>        - const: osc
>        - const: ipp_di0
>        - const: ipp_di1
> +      - const: enet1_ref_pad
> =20
>  required:
>    - compatible
>=20
> --=20
> 2.34.1
>=20

--faLTa5Z8RzHut49n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQzehAAKCRB4tDGHoIJi
0li0AP0X6venSRgjjxG9X1+jQvK3e+ds+gItM0mvxCkUAiEFtQD+PyCxXMtSstG5
WwI6mPxRa8Fd/1QmOnlKcjMMfpH9Vgk=
=JAlp
-----END PGP SIGNATURE-----

--faLTa5Z8RzHut49n--


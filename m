Return-Path: <linux-kernel+bounces-869176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA79C073AB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0404258055B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E7B335BCC;
	Fri, 24 Oct 2025 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8OKaKEx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4992334394;
	Fri, 24 Oct 2025 16:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322241; cv=none; b=eEDjgv8NMkyL9j7QZ+xqGav2Y056t94BhAAsdEN1a2fSXGibKHuhSBNAEN4wyrtv/WJZEtso3oeP0FE9VsNLMtyNRpi6iqm5Jp91fJbk+xnLgfC5SfrpKPtITOLdPiMjROS0MG6oKj3mHfAZX6QZE5XIRHdbi+Y9Sc4WrY+ljBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322241; c=relaxed/simple;
	bh=4SoTri5W3H54+3tKwwPWDSe9QCJbhHeD6Hnf3WTJiIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FlmeNKnxQMAvtbqtFyWOCmZuTsYvKqxEXfHCHB5fBFrXx/O0JBGfSJZlpnadlpt1W40KnGFmnrRr2NB5nRMoOWImmAmE3pBUrPtRjZ92tA0J7mkVwJyt3F5CeTaEcrCbUtq6nXUTnf7SVZ7xhCWlXccVT61IO0mEHRqgZIpzDsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8OKaKEx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29727C4CEF1;
	Fri, 24 Oct 2025 16:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761322239;
	bh=4SoTri5W3H54+3tKwwPWDSe9QCJbhHeD6Hnf3WTJiIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D8OKaKExojQJsNa3/9XyDn/+qFCxUG4IW3oOapovBVahDQXpSGGiUn/3TY8C3U8Qj
	 yjAsT0gYQja4onOmMGtoUHTuJ09qyX8rRJtRdrnF4jAk3j07yIjC7jxegqXF2wkw2r
	 8Z1Ww/kgAB0hk5FZPZ9MTdqSCxMGf/RZDvS0aUnI0AQ8XnjonowgkyU8tmJPLK3+/b
	 ESx8BtMI9RTPuj7nSWTCJnxGD1EnHET4MuaSDgmS7YAQQaKlwqbp4arphUtbHi2mQk
	 AJWSzXWXo/Y8byU3465DdeUlLGrayDqWqJq09G9lusDJfdjAb6mZgJ2CRGb8qM3Fej
	 jNVRjCyg8tp6g==
Date: Fri, 24 Oct 2025 17:10:33 +0100
From: Conor Dooley <conor@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"Kirill A. Shutemov" <kas@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: arm: fsl: add Toradex SMARC iMX95
Message-ID: <20251024-stardom-salsa-8e52d241fbf2@spud>
References: <20251024144921.77714-1-francesco@dolcini.it>
 <20251024144921.77714-2-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UrG/VOuGoe/anPA6"
Content-Disposition: inline
In-Reply-To: <20251024144921.77714-2-francesco@dolcini.it>


--UrG/VOuGoe/anPA6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 04:49:20PM +0200, Francesco Dolcini wrote:
> From: Jo=E3o Paulo Gon=E7alves <joao.goncalves@toradex.com>
>=20
> Add DT compatible strings for Toradex SMARC iMX95 SoM and
> Toradex SMARC Development carrier board.
>=20
> Link: https://www.toradex.com/computer-on-modules/smarc-arm-family/nxp-im=
x95
> Link: https://www.toradex.com/products/carrier-board/smarc-development-bo=
ard-kit
> Signed-off-by: Jo=E3o Paulo Gon=E7alves <joao.goncalves@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentati=
on/devicetree/bindings/arm/fsl.yaml
> index 00cdf490b062..44dd93f1c674 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -1439,6 +1439,12 @@ properties:
>            - const: phytec,imx95-phycore-fpsc  # phyCORE-i.MX 95 FPSC
>            - const: fsl,imx95
> =20
> +      - description: Toradex Boards with SMARC iMX95 Modules
> +        items:
> +          - const: toradex,smarc-imx95-dev # Toradex SMARC iMX95 on Tora=
dex SMARC Development Board
> +          - const: toradex,smarc-imx95     # Toradex SMARC iMX95 Module
> +          - const: fsl,imx95
> +
>        - description: i.MXRT1050 based Boards
>          items:
>            - enum:
> --=20
> 2.39.5
>=20

--UrG/VOuGoe/anPA6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPuk9gAKCRB4tDGHoIJi
0oZGAP9MOTTaex3xtSgbAsqJCkx1oR8NC4KeZ1bRCfJdAhnhvQEAknH3HKjjcz1m
37Ble1U8GN0RBpbqJOzKd/5m34WT0gU=
=w/oi
-----END PGP SIGNATURE-----

--UrG/VOuGoe/anPA6--


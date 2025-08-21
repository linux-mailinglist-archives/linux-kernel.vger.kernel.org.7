Return-Path: <linux-kernel+bounces-780424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 145D0B301B8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A2657A9746
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBCD343203;
	Thu, 21 Aug 2025 18:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1DZM6QJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496A52E62A4;
	Thu, 21 Aug 2025 18:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755799749; cv=none; b=t/CN6AACNZ+Y2Vu75S3Rczf3VaxJXC3ymWCTwjsr17eSJzyVUMXuMPxoR6DCuvdm8lBJGdRoI6i/EziDgajg3Xl6VohoRBcLuHGqhLGUkLr8tCVBi7VvZdsfSXsoTcCzanTuzKG7/IKozv+hJvqH3IjufLZ0QB/Er65K23RZSUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755799749; c=relaxed/simple;
	bh=EJZmiyPbt2FW7J7B2uq5opO2n/Df0WYHvpZBf3tfFA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUIxaPbDDiFuzk60kEuf2fPX9F1ulOpuavWgY5YzIoj+em6QOfDtLtLOGpz3zRqJ6P1+Qckz94an+j0enqQ+6bVwXskVurcMVAh/z6+WwHhesPG29b3q+rk5uh/OQ6Lgdje03PIBlhYHxogExqYVmEqh6H4OSxMmm3QIpnas6AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1DZM6QJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A88C4CEEB;
	Thu, 21 Aug 2025 18:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755799748;
	bh=EJZmiyPbt2FW7J7B2uq5opO2n/Df0WYHvpZBf3tfFA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B1DZM6QJ70flQ25VkDsB8ZaRvn6p6tir2J+qFk1eGRgtwb9OkqoJ8opQPWsTfZOqZ
	 ifEAW9k6SKWCDs+3NrjwvtrLE1vtbla5HOnt0MJ8zxXsJb8iRndfb4KuyjN/3Me26z
	 pII+wpS+O98GVdBYf9wK61mWdN6bjfZyi3NVwn9T89gcWqQQff/aR4Y0KxsplXCECc
	 ffl30J8OOX1egfkTzAHKksslozYlO9UfZIQXn6G8wRDJJrOyPkjLBuCfYFuJ4ocEkq
	 NLo+etTUhhgyEf77+CS7XabLnSUhtQS/A4vhKPpnG6v9iB8Rv9PHSwQhoCWFMd6Zss
	 oRtFvdatJknBQ==
Date: Thu, 21 Aug 2025 19:09:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Nishanth Menon <nm@ti.com>, nfraprado@collabora.com,
	Taniya Das <quic_tdas@quicinc.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Eric Biggers <ebiggers@google.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, soc@lists.linux.dev,
	Mo Elbadry <elbadrym@google.com>,
	Rom Lemarchand <romlem@google.com>,
	William Kennington <wak@google.com>,
	Yuxiao Zhang <yuxiaozhang@google.com>, wthai@nvidia.com,
	leohu@nvidia.com, dkodihalli@nvidia.com, spuranik@nvidia.com
Subject: Re: [PATCH v4 1/5] dt-bindings: arm: aspeed: Add AST2700 board
 compatible
Message-ID: <20250821-nineteen-purveyor-a5fe7e86296c@spud>
References: <20250821080214.513090-1-ryan_chen@aspeedtech.com>
 <20250821080214.513090-2-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eFNKcWxN80Jeyx0s"
Content-Disposition: inline
In-Reply-To: <20250821080214.513090-2-ryan_chen@aspeedtech.com>


--eFNKcWxN80Jeyx0s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 04:02:10PM +0800, Ryan Chen wrote:
> Add device tree compatible string for AST2700 based boards
> ("aspeed,ast2700-evb" and "aspeed,ast2700") to the Aspeed SoC
> board bindings. This allows proper schema validation and
> enables support for AST2700 platforms.
>=20
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/D=
ocumentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index 01333ac111fb..660529c81af9 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -102,5 +102,10 @@ properties:
>                - quanta,s6q-bmc
>                - ufispace,ncplite-bmc
>            - const: aspeed,ast2600

Missing blank line here. Otherwisem
Acked-by: Conor Dooley <conor.dooley@microchip.com>

> +      - description: AST2700 based boards
> +        items:
> +          - enum:
> +              - aspeed,ast2700-evb
> +          - const: aspeed,ast2700
> =20
>  additionalProperties: true
> --=20
> 2.34.1
>=20

--eFNKcWxN80Jeyx0s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKdgvQAKCRB4tDGHoIJi
0rjNAP4oi5C9FbNOm/t79PDWG4cZleruMzdozxf6Qctl5HCZ1gEAqDbhG+pz7KL9
PdVRZR6lS8PNdFBwdqaDS4H3zzJ8Hgw=
=XlDw
-----END PGP SIGNATURE-----

--eFNKcWxN80Jeyx0s--


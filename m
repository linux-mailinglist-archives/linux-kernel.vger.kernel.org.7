Return-Path: <linux-kernel+bounces-836619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC97BAA2D8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0900F3B8F35
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421EF21257F;
	Mon, 29 Sep 2025 17:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2H/+TEk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9454D2AE8D;
	Mon, 29 Sep 2025 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759167102; cv=none; b=hucH74l680Eh3DKWoc7QSehSETZ0mfYNcDjSZC7HqzIF+a+rUjEWN++WcnekTlH5fP9/q3qGbtqG5eEES5ycQYfj5q988Iv4ecdwU3yxYBqedd1ZAlreVTqeqKmrTi61/aGmQT9woD9VD5uIdCMuWSsB5TF2y8mnQOtsRmVzpzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759167102; c=relaxed/simple;
	bh=L5taQOZ5fy1HPwxCZ3NhYxZGxI2dRfW/9CQ4Tx0pvww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUWPT+CcyuMaki5qYF5/81zo8uwV5/6oTXpPG4M24VBC2WM5HI/T3vVySgiii3Zw9yPAEo86Tx33r/6SOElvPbRz4ueHQ7rrPrY452zjjXkr3X6DAmJ1KsdvcgvSC5lbVSTjRAws2VIQd91rXXTDDg/Fg7xAjnIAkK/X/8dzeXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2H/+TEk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73DEC4CEF4;
	Mon, 29 Sep 2025 17:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759167102;
	bh=L5taQOZ5fy1HPwxCZ3NhYxZGxI2dRfW/9CQ4Tx0pvww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E2H/+TEkd8fEL8/p0gb75SpCX8X6iF6IxTCTi3qfbM2zU9bOFClp7xXuFFCOYQx32
	 ISexCizfVvTtpJlrJnLUj9FcyyMi1cZ+iLl5FMQWkLhjYkbLefB32LaJgI2aJWh3WQ
	 eyiv5rt6d1iELQ2nDhnJfWPB7dWasVAwYy2HSC2IP9f7LCq/RjzLsBJDdcRDOWyTDk
	 l958AiHye4QE5ChB8naMrouHvdgeGayukpBjRoZjt+1xvICR5d8CpeZZfQb6/vB+Fj
	 Af4+mAKLlgDZtD4Aygg7RYj2PiDr8JhDQqWEhiTXjU1/IrZ4Xy4pAYLulQRtTlJvOR
	 DZiiMip4bNMQA==
Date: Mon, 29 Sep 2025 18:31:36 +0100
From: Conor Dooley <conor@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Guangjie Song <guangjie.song@mediatek.com>,
	Laura Nao <laura.nao@collabora.com>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Yassine Oudjana <y.oudjana@protonmail.com>, kernel@collabora.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: clock: mediatek: Add clocks for MT8196
 mfgpll
Message-ID: <20250929-whoops-kennel-5f54fb6559a8@spud>
References: <20250929-mtk-pll-rpm-v1-0-49541777878d@collabora.com>
 <20250929-mtk-pll-rpm-v1-1-49541777878d@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u4M+BrM+qE9Xid1p"
Content-Disposition: inline
In-Reply-To: <20250929-mtk-pll-rpm-v1-1-49541777878d@collabora.com>


--u4M+BrM+qE9Xid1p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 02:13:20PM +0200, Nicolas Frattaroli wrote:
> The clock controllers for mfgpll, mfgpll-sc0, and mfgpll-sc1 all need
> CLK_TOP_MFG_EB to be on if their clock control registers are touched in
> any way.
>=20
> This was not known at the time this binding was written, as this
> dependency only came to light when I started poking at the MFlexGraphics
> hardware, where this undocumented peculiarity made itself known through
> SErrors being thrown during register reads.
>=20
> Add a clocks property to the binding to describe this relationship, and
> mark it as required for the affected clocks.
>=20
> Fixes: dd240e95f1be ("dt-bindings: clock: mediatek: Describe MT8196 clock=
 controllers")
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  .../bindings/clock/mediatek,mt8196-sys-clock.yaml  | 28 ++++++++++++++++=
++++++
>  1 file changed, 28 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8196-sys-=
clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8196-sys-cl=
ock.yaml
> index 660ab64f390d2e722b7d3e25cf057926da318bc0..41aacd8d5f69050eebdf8392f=
7b652427632f491 100644
> --- a/Documentation/devicetree/bindings/clock/mediatek,mt8196-sys-clock.y=
aml
> +++ b/Documentation/devicetree/bindings/clock/mediatek,mt8196-sys-clock.y=
aml
> @@ -45,6 +45,9 @@ properties:
>    reg:
>      maxItems: 1
> =20
> +  clocks:
> +    maxItems: 1
> +
>    '#clock-cells':
>      const: 1
> =20
> @@ -90,6 +93,23 @@ required:
> =20
>  additionalProperties: false
> =20
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt8196-mfgpll-pll-ctrl
> +              - mediatek,mt8196-mfgpll-sc0-pll-ctrl
> +              - mediatek,mt8196-mfgpll-sc1-pll-ctrl
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: mfg_eb clock
> +      required:
> +        - clocks

Don't you want an else: properties: clocks: false here?

> +
>  examples:
>    - |
>      apmixedsys_clk: syscon@10000800 {
> @@ -104,4 +124,12 @@ examples:
>          mediatek,hardware-voter =3D <&scp_hwv>;
>          #clock-cells =3D <1>;
>      };
> +  - |
> +    #include <dt-bindings/clock/mediatek,mt8196-clock.h>
> =20
> +    clock-controller@4b810000 {
> +        compatible =3D "mediatek,mt8196-mfgpll-pll-ctrl", "syscon";
> +        reg =3D <0x4b810000 0x400>;
> +        clocks =3D <&topckgen CLK_TOP_MFG_EB>;
> +        #clock-cells =3D <1>;
> +    };
>=20
> --=20
> 2.51.0
>=20

--u4M+BrM+qE9Xid1p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNrCeAAKCRB4tDGHoIJi
0iJxAP4mU6+C8Eh7IxIoYQL1Qb0tkSwfwCjYaPhrKJSDWD8nUwEAx0m/G5GfkzGq
vzTWSFTPy8nqiETYWXzWi/6gx3Yqpwo=
=JKYV
-----END PGP SIGNATURE-----

--u4M+BrM+qE9Xid1p--


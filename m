Return-Path: <linux-kernel+bounces-861427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6DEBF2B39
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F8618A2C94
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198C13314DE;
	Mon, 20 Oct 2025 17:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFc3d0W6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA86221FC8;
	Mon, 20 Oct 2025 17:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981195; cv=none; b=XiMMqhPycVTQkmCFShfSOdanfR8jT9VLyM/eHpsktdmp34pJ4we95eTX7/PXMKO1ohTUmRik8XuBE931Nqv7BiQ7CBHd/kUGgjWE9LwmZY01MVqJvI6sVjeTya2QMo8bzd6xWWujn7t9y23l2wfoAjX4Y+3r1WnAHX7L3XyWhPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981195; c=relaxed/simple;
	bh=aMGWLdDm/gNeBxI6lcRh8r6af68Cspylr2/fbbMhzzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4phK16Pt1hR6WfxZ87R0XL3BUMDQ40HcoCjnfCQmED6V7i79dWIVP2J+oh2CQP912xi1lRFbEupZGSAqLtDkKPdI0cALjn8+D5arL8L+SD29laejyQw+vO6SYJnfyCBvX0UfujcPHxHACLFaccjbkjYQWrligbC6RXMyge/fuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFc3d0W6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56787C4CEF9;
	Mon, 20 Oct 2025 17:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760981195;
	bh=aMGWLdDm/gNeBxI6lcRh8r6af68Cspylr2/fbbMhzzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rFc3d0W6O1ecq4SpW/YELQ+ZTpJ6BDbEAELpWrAyCHHA/TU0K1whNjA3Db5jUWU4y
	 F6pLQ88HLiWuWMRxWOABwNdFPFv20JHMpjZBXlVa+MlS1lvxbJE+3gekxg7B/Elv3/
	 6/h3xO/j15SU3bEshUj0kpt+NIbADUDluHa6HGFdFZYois6CndRsydgdKPjnaRdKvj
	 VOKLNbDjXK4kYCOjir9t+HmAuZGlsWV190qnL/SAzTSX87lOgCfjWohb9gapNOe9K3
	 TkzXWPMkbXIKrmqiurxsBgekDr4pSuHt0qfUYfOAjwds+vEpeEtMAvXaTnf+nczdGa
	 qbFM/JH1ch5NQ==
Date: Mon, 20 Oct 2025 18:26:30 +0100
From: Conor Dooley <conor@kernel.org>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, sugar.zhang@rock-chips.com,
	heiko@sntech.de, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	huangtao@rock-chips.com
Subject: Re: [PATCH v3 4/5] dt-bindings: clock: Add support for rockchip
 pvtpll
Message-ID: <20251020-dose-treason-2a0ac50c6bb4@spud>
References: <20251020023724.2723372-1-zhangqing@rock-chips.com>
 <20251020023724.2723372-5-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ryBOeWKUiYWTAeKK"
Content-Disposition: inline
In-Reply-To: <20251020023724.2723372-5-zhangqing@rock-chips.com>


--ryBOeWKUiYWTAeKK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 10:37:23AM +0800, Elaine Zhang wrote:
> Add pvtpll documentation for rockchip.
>=20
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  .../bindings/clock/rockchip,clk-pvtpll.yaml   | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,clk-=
pvtpll.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/clock/rockchip,clk-pvtpll.=
yaml b/Documentation/devicetree/bindings/clock/rockchip,clk-pvtpll.yaml
> new file mode 100644
> index 000000000000..8be34bcde7b0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/rockchip,clk-pvtpll.yaml
> @@ -0,0 +1,100 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/rockchip,clk-pvtpll.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip Pvtpll
> +
> +maintainers:
> +  - Elaine Zhang <zhangqing@rock-chips.com>
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - rockchip,rv1103b-core-pvtpll
> +          - rockchip,rv1103b-enc-pvtpll
> +          - rockchip,rv1103b-isp-pvtpll
> +          - rockchip,rv1103b-npu-pvtpll
> +          - rockchip,rv1126b-core-pvtpll
> +          - rockchip,rv1126b-isp-pvtpll
> +          - rockchip,rv1126b-enc-pvtpll
> +          - rockchip,rv1126b-aisp-pvtpll
> +          - rockchip,rv1126b-npu-pvtpll
> +          - rockchip,rk3506-core-pvtpll
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    const: 0
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-output-names:
> +    maxItems: 1
> +
> +  rockchip,cru:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: |
> +      Phandle to the main Clock and Reset Unit (CRU) controller.
> +      Required for PVTPLLs that need to interact with the main CRU
> +      for clock management operations.
> +

> +required:
> +  - "#clock-cells"
> +  - compatible
> +  - reg
> +  - clock-output-names

Please follow the property definition order here.
pw-bot: changes-requested

--ryBOeWKUiYWTAeKK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPZwxgAKCRB4tDGHoIJi
0lTjAP9DBWIql0smcCTv41AISicEcx32++9dYLGuZP2GnfVVvwEAqq9+B9akz4PS
l2ntUaeyTNhVEinlaBiupteZ3Yz4aA4=
=wj6X
-----END PGP SIGNATURE-----

--ryBOeWKUiYWTAeKK--


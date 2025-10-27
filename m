Return-Path: <linux-kernel+bounces-872167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64001C0F6D5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 100CC34F988
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBCD313525;
	Mon, 27 Oct 2025 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIRBPzyb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C74E30AAC8;
	Mon, 27 Oct 2025 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761583638; cv=none; b=PNLIELpLVCwcsRhYGkJXF7piB4v8lKI6WZEUH3nVkj7yd3ixmQ/SLwUkumQiGrVs1yJiTESMxdtvuBB3Fkh/z+uBgMbzV2x6fuW5Et2YhrOoZSq73SNv+cjETUMNl+shFRLNENlqwvMzV14nzZ4eUuoRvmRAc6r2yJ3oq5ajKfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761583638; c=relaxed/simple;
	bh=32yOyFVynkfVIvnGVgJ92i0Ip1krG1hpIICP4cn0SOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuhH1+9VceVb5qZGfi1t3v4vfrpRHCnxwfdwD5VTZeF9cR5VV8pFKhxAILC3CFdI09NcZn+SRNCYoc36k2LubsCbK4e6HCj7QMTawJm82b0oG4eroSBQvWJNl/sT98uRPpF9/uP8p9PCVj0GJXM6eNsxGzf7hxMKiW+HHqOfUHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIRBPzyb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CE3C113D0;
	Mon, 27 Oct 2025 16:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761583637;
	bh=32yOyFVynkfVIvnGVgJ92i0Ip1krG1hpIICP4cn0SOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nIRBPzybk9NCdARzw23obr4pZMzwR/6XNdofj1qMoexG/4DU8IIk2+PM8X5IDn/gG
	 /y1QthXqj9X6dblAsvAyIqeUiVOMpdrDk5BKx96RXacgKJFftP5+Z13HaYlb04F6gq
	 SrY6R7NHuQFVjki4d6xx9Wy63ZuftiRH6jf5zyzitCSlTM24JBfK9VMx58eDCqgeEb
	 odSzeccOojfaQ6ZC5gt0zyFnw20uNcDtwcX1cA3ifbaBMmhHwEa5G4hymHgg4yLhdk
	 2hNg51IkIJRIObKlWkpVtrQwI0MckKkOLBzJJR5Vw9swl3jZwaB3lIPodHTno/fNvH
	 B/GM2H8mSaPyw==
Date: Mon, 27 Oct 2025 16:47:11 +0000
From: Conor Dooley <conor@kernel.org>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, sugar.zhang@rock-chips.com,
	heiko@sntech.de, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	huangtao@rock-chips.com, finley.xiao@rock-chips.com
Subject: Re: [PATCH v5 6/7] dt-bindings: clock: rockchip: Add RK3506 clock
 and reset unit
Message-ID: <20251027-await-wound-0aee2d20e0a3@spud>
References: <20251027084147.4148739-1-zhangqing@rock-chips.com>
 <20251027084147.4148739-7-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eSWQ1Ctgvp2pmYfz"
Content-Disposition: inline
In-Reply-To: <20251027084147.4148739-7-zhangqing@rock-chips.com>


--eSWQ1Ctgvp2pmYfz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 04:41:46PM +0800, Elaine Zhang wrote:
> From: Finley Xiao <finley.xiao@rock-chips.com>
>=20
> Add device tree bindings for clock and reset unit on RK3506 SoC.
> Add clock and reset IDs for RK3506 SoC.
>=20
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> ---
>  .../bindings/clock/rockchip,rk3506-cru.yaml   |  51 ++++
>  .../dt-bindings/clock/rockchip,rk3506-cru.h   | 285 ++++++++++++++++++
>  .../dt-bindings/reset/rockchip,rk3506-cru.h   | 211 +++++++++++++
>  3 files changed, 547 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk35=
06-cru.yaml
>  create mode 100644 include/dt-bindings/clock/rockchip,rk3506-cru.h
>  create mode 100644 include/dt-bindings/reset/rockchip,rk3506-cru.h
>=20
> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3506-cru.=
yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3506-cru.yaml
> new file mode 100644
> index 000000000000..ecb5fa497747
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3506-cru.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/rockchip,rk3506-cru.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip RK3506 Clock and Reset Unit (CRU)
> +
> +maintainers:
> +  - Finley Xiao <finley.xiao@rock-chips.com>
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +description: |
> +  The RK3506 CRU generates the clock and also implements reset for SoC
> +  peripherals.
> +
> +properties:
> +  compatible:
> +    const: rockchip,rk3506-cru
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  "#reset-cells":
> +    const: 1
> +
> +  clocks:
> +    maxItems: 1

Can you explain somewhere why the input clock is not required?
Feels like it really should be required, if it is what the output clocks
are generated from, but I can also see why it might be optional either.
pw-bot: changes-requested

> +
> +  clock-names:
> +    const: xin24m
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#clock-cells"
> +  - "#reset-cells"

--eSWQ1Ctgvp2pmYfz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaP+iDwAKCRB4tDGHoIJi
0o54AP98UXzeSXPMJY9coqV6N4MEVJH9zwk04uZhVRES8i7hMgEAysyNVT4D/cF6
jLYYWNYeQbkblle37SMJSItJT554Rgc=
=vAfi
-----END PGP SIGNATURE-----

--eSWQ1Ctgvp2pmYfz--


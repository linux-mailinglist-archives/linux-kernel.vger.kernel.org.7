Return-Path: <linux-kernel+bounces-720316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A4CAFBA34
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 19:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701AF1890B9E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 17:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C6C18A6C4;
	Mon,  7 Jul 2025 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZK9sXsM8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ED8262FF9;
	Mon,  7 Jul 2025 17:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751910928; cv=none; b=Lv9Idxod27+g/j1OZQUil+SYqOYeq/N+4l4MyvzK10Ptt557sEvP+O7Ov35PU78ralfxDc84N3Wku3sEqc6w6Y52tjVgOs8Nz/GhrPZNGQ78/uMJm0uXhw5I3L/Nc7EwAdGOkirWHftcrJshe+HEWSYVJ8sz8QBBf2WhFkPLZHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751910928; c=relaxed/simple;
	bh=4i3GwwYmMwd8rgyfXHO3jnhHMlDIeHEAOL0OdWiCZs0=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=DwAO9ZwII/seu+66VnQO4dNZI8aPIHqPGESuG1mGNcyASmww1dTQtLdOUlwCDH3+z/8xrVPmKcotq9UCIhgbQYklLuJLLl7iVUbR3b8cNm7wsSddt6P1JLkq9p0m5u6q9JmlFIekvIKKez8MUIVtBNoGvPgi0cnfj8euvXgRoZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZK9sXsM8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0731EC4CEF1;
	Mon,  7 Jul 2025 17:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751910928;
	bh=4i3GwwYmMwd8rgyfXHO3jnhHMlDIeHEAOL0OdWiCZs0=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=ZK9sXsM8/2KLy4877qvvhXzU663uegkJK0fCwXksNxOOSx49qQic8lwOQ1jCddztZ
	 xkXUryp9zl0ZVQUAd5SWytFQCGbNBaAOpe+z9MMasq2x06hI2Cl+5Z37wj1fbAoZrh
	 55aHAfof3fOKnGn8LBjX1TWs7ZRHvZlgKUi2qh6vZdAJ/izndrVP68pvXxH21o85X5
	 /HaOtlzbWOQcTDCDvxPbCHh0PdRw9xJFDOQgcDqRwCygmjk+baWyPZms4NiUew8cHb
	 KdqSxP50knRFjCxQZIueoMEP8J/0vE12M3npqwyue4LEHAvIshFXbwEWIrToOEjJ/U
	 VQJpIfWB/ePdw==
Date: Mon, 07 Jul 2025 12:55:27 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 devicetree@vger.kernel.org, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Conor Dooley <conor+dt@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-sunxi@lists.linux.dev, 
 Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org
To: Lukas Schmid <lukas.schmid@netcube.li>
In-Reply-To: <20250706183601.157523-1-lukas.schmid@netcube.li>
References: <20250706183601.157523-1-lukas.schmid@netcube.li>
Message-Id: <175191074348.3364659.3018850166698272326.robh@kernel.org>
Subject: Re: [PATCH v2 0/5] Add support for NetCube Systems Nagami SoM and
 its carrier boards


On Sun, 06 Jul 2025 20:35:53 +0200, Lukas Schmid wrote:
> This series adds support for the NetCube Systems Nagami SoM and its
> associated carrier boards, the Nagami Basic Carrier and the Nagami Keypad
> Carrier.
> 
> Changes in v2:
>  - Squash the binding patches into one patch
>  - Fix formatting of the phy node in the SoM dtsi
>  - Add description on where the phy is located in the SoM dtsi
>  - Fix the phy address in the SoM dtsi
>  - Move the carrier bindings into the same description as enums
> 
> Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
> ---
> Lukas Schmid (5):
>   dt-bindings: arm: sunxi: Add NetCube Systems Nagami SoM and carrier
>     board bindings
>   riscv: dts: allwinner: d1s-t113: Add pinctrl's required by NetCube
>     Systems Nagami SoM
>   ARM: dts: sunxi: add support for NetCube Systems Nagami SoM
>   ARM: dts: sunxi: add support for NetCube Systems Nagami Basic Carrier
>   ARM: dts: sunxi: add support for NetCube Systems Nagami Keypad Carrier
> 
>  .../devicetree/bindings/arm/sunxi.yaml        |  17 ++
>  arch/arm/boot/dts/allwinner/Makefile          |   3 +
>  ...n8i-t113s-netcube-nagami-basic-carrier.dts |  63 +++++
>  ...8i-t113s-netcube-nagami-keypad-carrier.dts | 165 +++++++++++++
>  .../allwinner/sun8i-t113s-netcube-nagami.dtsi | 227 ++++++++++++++++++
>  .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    |  36 +++
>  6 files changed, 511 insertions(+)
>  create mode 100644 arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami-basic-carrier.dts
>  create mode 100644 arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami-keypad-carrier.dts
>  create mode 100644 arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami.dtsi
> 
> --
> 2.39.5
> 
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: attempting to guess base-commit...
 Base: tags/next-20250704 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/allwinner/' for 20250706183601.157523-1-lukas.schmid@netcube.li:

arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami-keypad-carrier.dtb: dcxo-clk (fixed-clock): 'clock-frequency' is a required property
	from schema $id: http://devicetree.org/schemas/clock/fixed-clock.yaml#
arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami-keypad-carrier.dtb: gpio@20 (microchip,mcp23008): Unevaluated properties are not allowed ('interrupt-names' was unexpected)
	from schema $id: http://devicetree.org/schemas/pinctrl/microchip,mcp23s08.yaml#
arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami-keypad-carrier.dtb: usb@4100000 (allwinner,sun20i-d1-musb): dr_mode:0: 'device' is not one of ['host', 'otg', 'peripheral']
	from schema $id: http://devicetree.org/schemas/usb/allwinner,sun4i-a10-musb.yaml#
arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami-keypad-carrier.dtb: status-led (leds-group-multicolor): $nodename:0: 'status-led' does not match '^multi-led(@[0-9a-f])?$'
	from schema $id: http://devicetree.org/schemas/leds/leds-group-multicolor.yaml#
arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami-keypad-carrier.dtb: status-led (leds-group-multicolor): Unevaluated properties are not allowed ('color', 'function' were unexpected)
	from schema $id: http://devicetree.org/schemas/leds/leds-group-multicolor.yaml#
arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami-basic-carrier.dtb: dcxo-clk (fixed-clock): 'clock-frequency' is a required property
	from schema $id: http://devicetree.org/schemas/clock/fixed-clock.yaml#







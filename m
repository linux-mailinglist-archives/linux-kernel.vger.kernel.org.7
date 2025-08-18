Return-Path: <linux-kernel+bounces-774237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5D1B2B030
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9A8565A7B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33253320395;
	Mon, 18 Aug 2025 18:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiSsISxC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B556311941;
	Mon, 18 Aug 2025 18:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755541484; cv=none; b=MPTpnmeiAX0V5XtcgFPJnirhaglO32Kk/7dnVZUBJqdtuNP6DndfONY8AD80H572nF0cUuVAlHpU1Rz2kdXFUwDOhmVGLB+3PITfgX+moNNAJssjfKcXLeLj41gzftZzZAMCXq08Gt7PJZO2ULb1R/lEow+my7WjofBfFin7Bo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755541484; c=relaxed/simple;
	bh=EtzxoV3mnhEERBKMayyfjmOhWE0QWt9AxeuBtdSTkTU=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=qi3O/SpduJgxSb614osLCicbZ7trTEjzGt5+0G7o+v+u/1JlHrYf72M3rDJy+rqYde18zuFUpCaW0WfxTLukAR6Ws6NAWncv/TRPHhJHN2znhkrF0aKKbw76cfneQyzYa2/U6ycPCvIG0JKuvdaRvEv1cE0ayJleHOF4exszBFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JiSsISxC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E943C4CEEB;
	Mon, 18 Aug 2025 18:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755541482;
	bh=EtzxoV3mnhEERBKMayyfjmOhWE0QWt9AxeuBtdSTkTU=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=JiSsISxCoILf8P8IAu4QEDM5/orNPxkhDcIKyvwzOprKYDkmqysLOl7K4C8nyeHb1
	 RF/MWQToWMreGNTumjzPAthTKMKdvP7v7J9iBb/Wh7tZk7atUDLXE0BhPOi6126AlY
	 fqsZrzEtbDprU/xUsWhDQUdKzGpipIBzeTJzfvHeTmHddD9A/JIOEUmcmz7OFJtKXZ
	 56Kw7YtqIQGmBTZdhO3H2KR/3Rc3Rq+XmHbe3YO/w3Ov+L2yBfVbCHXcU2z/oKgK3/
	 x/HkEztPyRgma5dqHg47MD0Ul2BiLQjfZwbqObKTvowX500w8SSOaZGgob2/hJhhSJ
	 nyCEzGZ0B50tQ==
Date: Mon, 18 Aug 2025 13:24:41 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Samuel Holland <samuel@sholland.org>, 
 linux-arm-kernel@lists.infradead.org, Vinod Koul <vkoul@kernel.org>, 
 linux-sunxi@lists.linux.dev, Andre Przywara <andre.przywara@arm.com>, 
 linux-clk@vger.kernel.org, linux-phy@lists.infradead.org, 
 Michael Turquette <mturquette@baylibre.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
To: iuncuim <iuncuim@gmail.com>
In-Reply-To: <20250816084700.569524-1-iuncuim@gmail.com>
References: <20250816084700.569524-1-iuncuim@gmail.com>
Message-Id: <175554055617.1719671.12698982859500685788.robh@kernel.org>
Subject: Re: [PATCH 0/7] arm64: allwinner: a523: add USB3.0 support


On Sat, 16 Aug 2025 16:46:53 +0800, iuncuim wrote:
> From: Mikhail Kalashnikov <iuncuim@gmail.com>
> 
> This series is a draft and does not include patches for dt-bindings.
> The first series is necessary for testing on other devices and
> initiating discussion.
> 
> This series of patches adds USB 3.0 functionality for the
> A523/A527/H728/T527 processor.Most of the code is derived from the BSP,
>  as the datasheet does not fully describe this feature.
> 
> I have verified functionality on two of my boards, walnutpi 2b (t527)
> and x96qproplus (h728). When testing usb3.0 on x96qproplus, I get
> reconnections of my nvme, it looks like the port does not provide enough
>  current to work. I have encountered similar complaints from users of the
>   device on Android. In the case of walnutpi, there is no such problem.
> 
> Based on 6.17-rc1
> 
> Mikhail Kalashnikov (7):
>   clk: sunxi-ng: a523: add missing usb related clocks
>   arm64: dts: allwinner: a523: add third usb2 phy
>   phy: sun4i-usb: a523: add support for the USB2 PHY
>   phy: allwinner: a523: add USB3/PCIe PHY driver
>   arm64: dts: allwinner: a523: add USB3.0 phy node
>   arm64: dts: allwinner: a523: add DWC3 USB3.0 node
>   arm64: dts: allwinner: a523: activate USB3 for all boards
> 
>  .../arm64/boot/dts/allwinner/sun55i-a523.dtsi |  52 +++-
>  .../dts/allwinner/sun55i-a527-cubie-a5e.dts   |   8 +
>  .../dts/allwinner/sun55i-h728-x96qpro+.dts    |   8 +
>  .../dts/allwinner/sun55i-t527-avaota-a1.dts   |   8 +
>  drivers/clk/sunxi-ng/ccu-sun55i-a523.c        |  32 +++
>  drivers/clk/sunxi-ng/ccu-sun55i-a523.h        |   2 +-
>  drivers/phy/allwinner/Kconfig                 |   9 +
>  drivers/phy/allwinner/Makefile                |   1 +
>  drivers/phy/allwinner/phy-sun4i-usb.c         |  10 +
>  drivers/phy/allwinner/phy-sun55i-usb3-pcie.c  | 267 ++++++++++++++++++
>  include/dt-bindings/clock/sun55i-a523-ccu.h   |   4 +
>  11 files changed, 392 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/phy/allwinner/phy-sun55i-usb3-pcie.c
> 
> --
> 2.50.1
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
 Base: remotes/korg/master-95-g90d970cade8e (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/allwinner/' for 20250816084700.569524-1-iuncuim@gmail.com:

arch/arm64/boot/dts/allwinner/sun55i-h728-x96qpro+.dtb: phy@4100400 (allwinner,sun55i-a523-usb-phy): clock-names: ['usb0_phy', 'usb1_phy', 'usb2_phy'] is too long
	from schema $id: http://devicetree.org/schemas/phy/allwinner,sun50i-a64-usb-phy.yaml#
arch/arm64/boot/dts/allwinner/sun55i-h728-x96qpro+.dtb: phy@4100400 (allwinner,sun55i-a523-usb-phy): clocks: [[5], [5], [2, 179]] is too long
	from schema $id: http://devicetree.org/schemas/phy/allwinner,sun50i-a64-usb-phy.yaml#
arch/arm64/boot/dts/allwinner/sun55i-h728-x96qpro+.dtb: phy@4100400 (allwinner,sun55i-a523-usb-phy): compatible: 'oneOf' conditional failed, one must be fixed:
	['allwinner,sun55i-a523-usb-phy'] is too short
	'allwinner,sun55i-a523-usb-phy' is not one of ['allwinner,sun20i-d1-usb-phy', 'allwinner,sun50i-a64-usb-phy']
	from schema $id: http://devicetree.org/schemas/phy/allwinner,sun50i-a64-usb-phy.yaml#
arch/arm64/boot/dts/allwinner/sun55i-h728-x96qpro+.dtb: phy@4100400 (allwinner,sun55i-a523-usb-phy): reg: [[68158464, 256], [68163584, 256], [69208064, 256], [81788928, 256]] is too long
	from schema $id: http://devicetree.org/schemas/phy/allwinner,sun50i-a64-usb-phy.yaml#
arch/arm64/boot/dts/allwinner/sun55i-h728-x96qpro+.dtb: phy@4100400 (allwinner,sun55i-a523-usb-phy): reg-names: ['phy_ctrl', 'pmu0', 'pmu1', 'pmu2'] is too long
	from schema $id: http://devicetree.org/schemas/phy/allwinner,sun50i-a64-usb-phy.yaml#
arch/arm64/boot/dts/allwinner/sun55i-h728-x96qpro+.dtb: phy@4100400 (allwinner,sun55i-a523-usb-phy): reset-names: ['usb0_reset', 'usb1_reset', 'usb2_reset'] is too long
	from schema $id: http://devicetree.org/schemas/phy/allwinner,sun50i-a64-usb-phy.yaml#
arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dtb: phy@4100400 (allwinner,sun55i-a523-usb-phy): clock-names: ['usb0_phy', 'usb1_phy', 'usb2_phy'] is too long
arch/arm64/boot/dts/allwinner/sun55i-h728-x96qpro+.dtb: phy@4100400 (allwinner,sun55i-a523-usb-phy): resets: [[2, 49], [2, 50], [2, 56]] is too long
	from schema $id: http://devicetree.org/schemas/phy/allwinner,sun50i-a64-usb-phy.yaml#
arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dtb: phy@4100400 (allwinner,sun55i-a523-usb-phy): clocks: [[5], [5], [2, 179]] is too long
	from schema $id: http://devicetree.org/schemas/phy/allwinner,sun50i-a64-usb-phy.yaml#
arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dtb: phy@4100400 (allwinner,sun55i-a523-usb-phy): compatible: 'oneOf' conditional failed, one must be fixed:
	['allwinner,sun55i-a523-usb-phy'] is too short
	'allwinner,sun55i-a523-usb-phy' is not one of ['allwinner,sun20i-d1-usb-phy', 'allwinner,sun50i-a64-usb-phy']
	from schema $id: http://devicetree.org/schemas/phy/allwinner,sun50i-a64-usb-phy.yaml#
arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dtb: phy@4100400 (allwinner,sun55i-a523-usb-phy): reg: [[68158464, 256], [68163584, 256], [69208064, 256], [81788928, 256]] is too long
	from schema $id: http://devicetree.org/schemas/phy/allwinner,sun50i-a64-usb-phy.yaml#
arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dtb: phy@4100400 (allwinner,sun55i-a523-usb-phy): reg-names: ['phy_ctrl', 'pmu0', 'pmu1', 'pmu2'] is too long
	from schema $id: http://devicetree.org/schemas/phy/allwinner,sun50i-a64-usb-phy.yaml#
arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dtb: phy@4100400 (allwinner,sun55i-a523-usb-phy): reset-names: ['usb0_reset', 'usb1_reset', 'usb2_reset'] is too long
	from schema $id: http://devicetree.org/schemas/phy/allwinner,sun50i-a64-usb-phy.yaml#
arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dtb: phy@4100400 (allwinner,sun55i-a523-usb-phy): resets: [[2, 49], [2, 50], [2, 56]] is too long
	from schema $id: http://devicetree.org/schemas/phy/allwinner,sun50i-a64-usb-phy.yaml#
arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dtb: phy@4100400 (allwinner,sun55i-a523-usb-phy): clock-names: ['usb0_phy', 'usb1_phy', 'usb2_phy'] is too long
	from schema $id: http://devicetree.org/schemas/phy/allwinner,sun50i-a64-usb-phy.yaml#
arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dtb: phy@4100400 (allwinner,sun55i-a523-usb-phy): clocks: [[5], [5], [2, 179]] is too long
	from schema $id: http://devicetree.org/schemas/phy/allwinner,sun50i-a64-usb-phy.yaml#
arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dtb: phy@4100400 (allwinner,sun55i-a523-usb-phy): compatible: 'oneOf' conditional failed, one must be fixed:
	['allwinner,sun55i-a523-usb-phy'] is too short
	'allwinner,sun55i-a523-usb-phy' is not one of ['allwinner,sun20i-d1-usb-phy', 'allwinner,sun50i-a64-usb-phy']
	from schema $id: http://devicetree.org/schemas/phy/allwinner,sun50i-a64-usb-phy.yaml#
arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dtb: phy@4100400 (allwinner,sun55i-a523-usb-phy): reg: [[68158464, 256], [68163584, 256], [69208064, 256], [81788928, 256]] is too long
	from schema $id: http://devicetree.org/schemas/phy/allwinner,sun50i-a64-usb-phy.yaml#
arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dtb: phy@4100400 (allwinner,sun55i-a523-usb-phy): reg-names: ['phy_ctrl', 'pmu0', 'pmu1', 'pmu2'] is too long
	from schema $id: http://devicetree.org/schemas/phy/allwinner,sun50i-a64-usb-phy.yaml#
arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dtb: phy@4100400 (allwinner,sun55i-a523-usb-phy): reset-names: ['usb0_reset', 'usb1_reset', 'usb2_reset'] is too long
	from schema $id: http://devicetree.org/schemas/phy/allwinner,sun50i-a64-usb-phy.yaml#
arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dtb: phy@4100400 (allwinner,sun55i-a523-usb-phy): resets: [[2, 49], [2, 50], [2, 56]] is too long
	from schema $id: http://devicetree.org/schemas/phy/allwinner,sun50i-a64-usb-phy.yaml#
arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dtb: phy@4100400 (allwinner,sun55i-a523-usb-phy): clock-names: ['usb0_phy', 'usb1_phy', 'usb2_phy'] is too long
	from schema $id: http://devicetree.org/schemas/phy/allwinner,sun50i-a64-usb-phy.yaml#
arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dtb: phy@4100400 (allwinner,sun55i-a523-usb-phy): clocks: [[5], [5], [2, 179]] is too long
	from schema $id: http://devicetree.org/schemas/phy/allwinner,sun50i-a64-usb-phy.yaml#
arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dtb: phy@4100400 (allwinner,sun55i-a523-usb-phy): compatible: 'oneOf' conditional failed, one must be fixed:
	['allwinner,sun55i-a523-usb-phy'] is too short
	'allwinner,sun55i-a523-usb-phy' is not one of ['allwinner,sun20i-d1-usb-phy', 'allwinner,sun50i-a64-usb-phy']
	from schema $id: http://devicetree.org/schemas/phy/allwinner,sun50i-a64-usb-phy.yaml#
arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dtb: phy@4100400 (allwinner,sun55i-a523-usb-phy): reg: [[68158464, 256], [68163584, 256], [69208064, 256], [81788928, 256]] is too long
	from schema $id: http://devicetree.org/schemas/phy/allwinner,sun50i-a64-usb-phy.yaml#
arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dtb: phy@4100400 (allwinner,sun55i-a523-usb-phy): reg-names: ['phy_ctrl', 'pmu0', 'pmu1', 'pmu2'] is too long
	from schema $id: http://devicetree.org/schemas/phy/allwinner,sun50i-a64-usb-phy.yaml#
arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dtb: phy@4100400 (allwinner,sun55i-a523-usb-phy): reset-names: ['usb0_reset', 'usb1_reset', 'usb2_reset'] is too long
	from schema $id: http://devicetree.org/schemas/phy/allwinner,sun50i-a64-usb-phy.yaml#
arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dtb: phy@4100400 (allwinner,sun55i-a523-usb-phy): resets: [[2, 49], [2, 50], [2, 56]] is too long
	from schema $id: http://devicetree.org/schemas/phy/allwinner,sun50i-a64-usb-phy.yaml#
arch/arm64/boot/dts/allwinner/sun55i-h728-x96qpro+.dtb: /soc/phy@4f00000: failed to match any schema with compatible: ['allwinner,sun55i-a523-usb3-pcie-phy']
arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dtb: /soc/phy@4f00000: failed to match any schema with compatible: ['allwinner,sun55i-a523-usb3-pcie-phy']
arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dtb: /soc/phy@4f00000: failed to match any schema with compatible: ['allwinner,sun55i-a523-usb3-pcie-phy']
arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dtb: /soc/phy@4f00000: failed to match any schema with compatible: ['allwinner,sun55i-a523-usb3-pcie-phy']







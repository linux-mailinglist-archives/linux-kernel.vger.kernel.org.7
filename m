Return-Path: <linux-kernel+bounces-771464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A6EB287A4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDCCB60327A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB2B2C0F99;
	Fri, 15 Aug 2025 21:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phFJpywg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471E32C08C3;
	Fri, 15 Aug 2025 21:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755292753; cv=none; b=XNyTB6UuaGPMiWfs8uQUjq6yAaPODAa42yLYUAF9BwfPo615/JPg7F2GXpRdLKhNoJPdLJD84e3HgSXgzhp8rEEO04PE2Wtp6MHV9DD7X+8EuxxGjTzrhXm+eb8GpPUV2yU+P7WZCADmHzsGgbXQiDtDAOPWRH4MGhj0FsTdXVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755292753; c=relaxed/simple;
	bh=SFuIvMcXySzIx6yuydmTiDrtSS+EI5n+sZ5HoAj+x0k=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=jyzZNOvaGbiq64FmAp66rdHYDDJN75ydYPB8/1j3WpmetP0fnV95/G6nPDC1wgQaf3FL5O8L1Kis9GRgBXunZdEvcv38cKj22TyrrdxJp2R1xHMC0+GubDQelGu2yuvLHQxauW3qQ7jv11AbLD5awoSQ2ydo/C1/NqJviOTH50Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phFJpywg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CF7C4CEEB;
	Fri, 15 Aug 2025 21:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755292752;
	bh=SFuIvMcXySzIx6yuydmTiDrtSS+EI5n+sZ5HoAj+x0k=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=phFJpywgeyQwzIyKIk+4Lh/bDlBiKZByUqRnjnYbPYVk3PX00e2+cGH6SyKH9x5Is
	 L4ejGwt/Kgi9F/PAdXPi6kq39L+a6NmqapYkKNXC4lvrZgaRTlVVyXQ9Sn1lPDPxkc
	 BuefW1nj6RUGcTz4yvJkk3VR/V5bv23/iEdTrs6uusRqFU9eyS+2ae5LZQ6dIV9RL5
	 eaLFEQgwYKgNjFXCLNDGuFg/CFbvlwXQrrA7fFZZAlWnDMFxL8VF+M8I/i6xLPGXVQ
	 jtkf6CPdG6AVQaJRZMT1yH6oRaxHi76MJbj5x4fwJOnBx0PnGpNiJApxyPTthU6zWX
	 x4V/MBF2+d+gw==
Date: Fri, 15 Aug 2025 16:19:12 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, 
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Luke Wang <ziniu.wang_1@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, Joy Zou <joy.zou@nxp.com>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
References: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
Message-Id: <175529260128.3212429.5776706257290268748.robh@kernel.org>
Subject: Re: [PATCH 00/13] arm64: dts: imx95: various updates


On Fri, 15 Aug 2025 17:03:46 +0800, Peng Fan wrote:
> This patchset is to upstream various downstream changes.
> - Correct edma channel for lpuart7/8
> - Add System Counter, SCMI LMM/CPU, V2X MU, coresight nodes
> - Update alias
> - Add phy supply for netc, pca9632, pf09/pf53 thermal, spidev, cma nodes
>   and etc.
> 
> dtbs_check will report a few failures, such as linux,code, db suffix.
> The failures are not related to this patchset.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> Joy Zou (1):
>       arm64: dts: imx95: Correct the lpuart7 and lpuart8 srcid
> 
> Luke Wang (1):
>       arm64: dts: imx95-15x15-evk: Change pinctrl settings for usdhc2
> 
> Peng Fan (10):
>       arm64: dts: imx95: Add System Counter node
>       arm64: dts: imx95: Add LMM/CPU nodes
>       arm64: dts: imx95: Add more V2X MUs
>       arm64: dts: imx95: Add OCOTP node
>       arm64: dts: imx95: Add coresight nodes
>       arm64: dts: imx95-evk: Update alias
>       arm64: dts: imx95-19x19-evk: Add phy supply for netc
>       arm64: dts: imx95-19x19-evk: Add pca9632 node
>       arm64: dts: imx95-19x19-evk: Add pf09 and pf53 thermal zones
>       arm64: dts: imx95-19x19-evk: Add spidev0
> 
> Richard Zhu (1):
>       arm64: dts: imx95-19x19-evk: Add Tsettle delay in m2 regulator
> 
>  arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts |  29 +++-
>  arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 120 ++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx95.dtsi          | 165 +++++++++++++++++++++-
>  3 files changed, 306 insertions(+), 8 deletions(-)
> ---
> base-commit: ff837884a4642382a24d10fd503acf2c3a472f10
> change-id: 20250813-imx9-dts-664f7ba66ae7
> 
> Best regards,
> --
> Peng Fan <peng.fan@nxp.com>
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
 Base: base-commit ff837884a4642382a24d10fd503acf2c3a472f10 not known, ignoring
 Base: attempting to guess base-commit...
 Base: tags/next-20250815 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/freescale/' for 20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com:

arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dtb: scmi (arm,scmi): Unevaluated properties are not allowed ('protocol@80', 'protocol@81', 'protocol@82', 'protocol@84' were unexpected)
	from schema $id: http://devicetree.org/schemas/firmware/arm,scmi.yaml#
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: mdio@0,0 (pci1131,ee00): Unevaluated properties are not allowed ('phy-supply' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/fsl,enetc-mdio.yaml#
arch/arm64/boot/dts/freescale/imx95-19x19-evk-sof.dtb: mdio@0,0 (pci1131,ee00): Unevaluated properties are not allowed ('phy-supply' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/fsl,enetc-mdio.yaml#







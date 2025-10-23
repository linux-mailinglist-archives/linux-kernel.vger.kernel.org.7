Return-Path: <linux-kernel+bounces-867088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DC5C018B5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C0D3835AAF6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4551931E10F;
	Thu, 23 Oct 2025 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0Ghzo5q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E47F30CDA9;
	Thu, 23 Oct 2025 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227518; cv=none; b=JAFbYJjI84yExhvEYsyUiXYnvHx9ThU03PHcsJPsx2LfWqYSBaxSF7FNPi0RJFyZsB0SKgrvwlu0WiQQp74k0vgR44sAeUxUCylOA/tjFu/sTP/+tYecH0IEsJKUAAXb/1InprHyljb6pQAYGnlWT1U0N7idMILmNMti3e9xLJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227518; c=relaxed/simple;
	bh=T6Q2aEP5PbzrJSzaFyZjXRnYX5iQKPyJsLn+R8QxcLg=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=H5gpwuHBAyLffvNZw5Nzb6UBTSEUx9l1pdS2sSv04ghc0cblpxOTJxGawTWXlZ2LF9hWh8ZZJZt6xbm+w8bKGYGSStXqokvJQpnwYX3dN3kRhq1FlwpAayAVJv5W0Y/RSbwO00Kx1oHTmx6efUFu1wHdVdgEVnuWUYozVcpegng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0Ghzo5q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8300C4CEF7;
	Thu, 23 Oct 2025 13:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761227518;
	bh=T6Q2aEP5PbzrJSzaFyZjXRnYX5iQKPyJsLn+R8QxcLg=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=t0Ghzo5qgQYwPXyP0oYkOO/O8+exGyUn//IoCTCfh9DNSzMI/nHti2h+v9O+FYjiA
	 FYzc+3IPNFADvafz8atB6AuTDDH/mm7zlsoyXh65mgkTm+ia0/UAJZ45BPsZpXrmyz
	 I+Wt9D7x2ziiwuVY7oZG+MmbgVDpAPyAiY103hrasBZ5R5dMLCnmPBeGPQG1Vw/5kC
	 P4pHsOWhDI0lXHyUKRBnW6YGFrLqxG2Kstea6cV4lLuBZFcwbpDOzAgOrR5y3tYxIV
	 rVOFFt/PFr/vfvFUoyxRBKLh2XShLaXyhClLDtoW3okHnojpVu8hdc0ihoAkf91f76
	 63uioq58gMQgA==
Date: Thu, 23 Oct 2025 08:51:56 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, Lei Xu <lei.xu@nxp.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, devicetree@vger.kernel.org, 
 Danwei Luo <danwei.luo@nxp.com>, Conor Dooley <conor+dt@kernel.org>, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Fabio Estevam <festevam@gmail.com>, Haidong Zheng <haidong.zheng@nxp.com>
To: Fabian Pflug <f.pflug@pengutronix.de>
In-Reply-To: <20251022-fpg-nxp-imx93-frdm-v3-0-03ec40a1ccc0@pengutronix.de>
References: <20251022-fpg-nxp-imx93-frdm-v3-0-03ec40a1ccc0@pengutronix.de>
Message-Id: <176122700666.2723251.16850924180146120380.robh@kernel.org>
Subject: Re: [PATCH v3 0/2] Add devicetree for NXP i.MX93 FRDM board


On Wed, 22 Oct 2025 16:05:21 +0200, Fabian Pflug wrote:
> I could not test all features of the board, therefore a lot of stuff is
> omitted from the devicetree. but this is enough to have the board boot
> via eMMC or SD-Card, debug via debug USB connector and have a network
> connection.
> 
> The FRDM i.MX 93 development board is a low-cost and compact development
> board featuring the i.MX93 applications processor.
> 
> It features:
> - Dual Cortex-A55
> - 2 GB LPDDR4X / LPDDR4
> - 32 GB eMMC5.1
> - MicroSD slot
> - GbE RJ45 x 2
> - USB2.0 1x Type C, 1x Type A
> 
> This file is based upon the one provided by nxp in their own kernel and
> yocto meta layer for the device, but adapted for mainline.
> 
> Signed-off-by: Fabian Pflug <f.pflug@pengutronix.de>
> ---
> Changes in v3:
> - Add Signed-off for original NXP contributors.
> - Fixed whitespace errors (Thanks Francesco Valla)
> - Added mu1 with status okay (Thanks Francesco Valla)
> - Removed address cells from lpi2c3 (Thanks Frank Li)
> - Configure pin for watchdog (Thanks Peng Fan)
> - Updated regulator config
> - Configure i2c0
> - Link to v2: https://lore.kernel.org/r/20250526-fpg-nxp-imx93-frdm-v2-0-e5ad0efaec33@pengutronix.de
> 
> Changes in v2:
> - 1/2: remove CAN node, as it has not been tested.
> - 1/2: ran dt-format (Thanks Frank Li)
> 	But also reordered some nodes afterwards again to have
> 	regulator-min before regulator-max, have the pinmux at the end
> 	of the file, and have the regulator-name as the first node
> 	inside the regulators.
> 	Re-added comments, that were deleted.
> - 1/2: changes subjet to ar64:dts (Thanks Fabio Estevan)
> - 1/2: removed reg_vdd_12v (Tanks Fabio Estevan)
> - 1/2: added aliases for rtc, emmc, serial (Thanks Fabio Estevan)
> - reordered the series to have documentation before dts. (Thanks
>   Krzystof Kozlowski)
> - Link to v1: https://lore.kernel.org/r/20250523-fpg-nxp-imx93-frdm-v1-0-546b2d342855@pengutronix.de
> 
> ---
> Fabian Pflug (2):
>       dt-bindings: arm: fsl: add i.MX93 11x11 FRDM board
>       arm64: dts: freescale: add support for NXP i.MX93 FRDM
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml     |   1 +
>  arch/arm64/boot/dts/freescale/Makefile             |   1 +
>  arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts | 658 +++++++++++++++++++++
>  3 files changed, 660 insertions(+)
> ---
> base-commit: 552c50713f273b494ac6c77052032a49bc9255e2
> change-id: 20250523-fpg-nxp-imx93-frdm-5cc180a1fda9
> 
> Best regards,
> --
> Fabian Pflug <f.pflug@pengutronix.de>
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
 Base: 552c50713f273b494ac6c77052032a49bc9255e2 (use --merge-base to override)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/freescale/' for 20251022-fpg-nxp-imx93-frdm-v3-0-03ec40a1ccc0@pengutronix.de:

arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dtb: hdmi@4c (ite,it6263): 'ports' is a required property
	from schema $id: http://devicetree.org/schemas/display/bridge/ite,it6263.yaml
arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dtb: hdmi@4c (ite,it6263): 'data-mapping' is a required property
	from schema $id: http://devicetree.org/schemas/display/bridge/ite,it6263.yaml







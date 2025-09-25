Return-Path: <linux-kernel+bounces-831554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1C5B9CFF3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 580C8383101
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8C22DF158;
	Thu, 25 Sep 2025 01:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slfRqWTw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07D72DF139;
	Thu, 25 Sep 2025 01:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758763098; cv=none; b=sWF3dOSWEa9mGPUjE7PZEtf6N8PdU1FSGbgy18ZUe0WMVJtYAdh0zxdh1x7ive1BzvlpiL7qE/8osNj8299E+6Q68g71aL48O3JS18eRlYxRDawfel+r1N4GAIlo4UI7JQjnRRnqTnkaV1x71rmNumsEwBt4YdUVKTLY7kUqyNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758763098; c=relaxed/simple;
	bh=C55DETOo2QRYteFXs2WfthXPbj+SvYWsU4QTXLEnsCU=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=GYV/4p5vEFPU+Bp8V7xYMQJ/c7pwaJa0vD0sq3AmXpoAYiMJsSR6Myoubzjfq7qi3OUoa0KsuoXfstQpBzQnYc7FxuqUsq2o7C4ohpjgqxLyMduEh92oh/QpyDVCEM0j6laFFm1jFQPn2LuQTpSmrUozOoQ4Edk+KSQT+IUMOWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slfRqWTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FAF6C4CEF8;
	Thu, 25 Sep 2025 01:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758763098;
	bh=C55DETOo2QRYteFXs2WfthXPbj+SvYWsU4QTXLEnsCU=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=slfRqWTwJpfzLeFqfHeCLJlKBQBLQPGGb1ZUd9Y9kH/UQ97KoztYe1RwAEXhYwcfM
	 l3DFn8PtKpRUp8zcqpNyUeN1NcG8MPrYDSaFSquI9szHDmRX57I4nnU3cbWloaTAhv
	 PhJfSTbsJVnUuUAnnVbBeit9E07nZiVNw3gEwkrkslW3cNQ6e56qcAaOrsK2tb6DZz
	 ZrSScpuFUDxDKqdnBt088LhEBqMAi13ZZU4Ih8/YHLJ1T7gMWUOp+lYuzW/lS+q6ZC
	 9hSEyGKDvPZ5dI+N6IFJlVSbwiY0QAuRbj+1bqD/KuONDJDzq10Z/w87tDvQvUu1Yb
	 luQ7zCdkOrHLQ==
Date: Wed, 24 Sep 2025 20:18:17 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 devicetree@vger.kernel.org, Srinivas Kandagatla <srini@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
In-Reply-To: <20250924-imx943-v1-0-0d32d7852ecb@oss.nxp.com>
References: <20250924-imx943-v1-0-0d32d7852ecb@oss.nxp.com>
Message-Id: <175876283151.3268828.13905899356593149136.robh@kernel.org>
Subject: Re: [PATCH 0/3] Add i.MX94 OCOTP support


On Wed, 24 Sep 2025 18:06:22 +0800, Alice Guo (OSS) wrote:
> This patch series adds support for the OCOTP controller on the i.MX94
> SoC. The OCOTP controller provides access to eFuse regions.
> 
> Tested on an i.MX943 EVK board with successful NVMEM read access via
> sysfs.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
> Alice Guo (3):
>       dt-bindings: nvmem: imx-ocotp: Add binding for i.MX94
>       nvmem: imx-ocotp-ele: Add support for i.MX94 OCOTP
>       arm64: dts: imx94: Add OCOTP node
> 
>  .../devicetree/bindings/nvmem/imx-ocotp.yaml         |  4 +++-
>  arch/arm64/boot/dts/freescale/imx94.dtsi             |  7 +++++++
>  drivers/nvmem/imx-ocotp-ele.c                        | 20 ++++++++++++++++++++
>  3 files changed, 30 insertions(+), 1 deletion(-)
> ---
> base-commit: cec1e6e5d1ab33403b809f79cd20d6aff124ccfe
> change-id: 20250924-imx943-b27ad75d14fa
> 
> Best regards,
> --
> Alice Guo <alice.guo@oss.nxp.com>
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
 Base: using specified base-commit cec1e6e5d1ab33403b809f79cd20d6aff124ccfe

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/freescale/' for 20250924-imx943-v1-0-0d32d7852ecb@oss.nxp.com:

arch/arm64/boot/dts/freescale/imx943-evk.dtb: efuse@47510000 (fsl,imx94-ocotp): compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx94-ocotp'] is too short
	'fsl,imx94-ocotp' is not one of ['fsl,imx8mn-ocotp', 'fsl,imx8mp-ocotp']
	from schema $id: http://devicetree.org/schemas/nvmem/imx-ocotp.yaml#
arch/arm64/boot/dts/freescale/imx943-evk.dtb: efuse@47510000 (fsl,imx94-ocotp): Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/nvmem/imx-ocotp.yaml#







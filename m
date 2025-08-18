Return-Path: <linux-kernel+bounces-774239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0109B2B038
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C293682E00
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7F23314AB;
	Mon, 18 Aug 2025 18:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUc8mv/l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2153570D9;
	Mon, 18 Aug 2025 18:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755541486; cv=none; b=UeafeAqxtDYroMc3P2YDxb9TTdfTFXZL24y4CnVGbY8yMpkHl3dPjhIWaVvw7eOtVHuC3FhxmPhN+iCrslf/AczmDl34aYT5p3L/hIbESlXxQO6mrtdYYKJowtddfac0o1r/w5UfS6uNwOrkih79MOVEg4sfL5+hDgQq2jzOxpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755541486; c=relaxed/simple;
	bh=IMZlLcdTbTR3iktUWRNqGf1wOuBejkJQOJ/LsettyZs=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=OYyAQf/8XqYrVb3ADQooefflbx6tyHp1Npx/5vIUXjZdDNGBFJk89us+KP0ahOXxk9/D57jAkT+TyLPL/R1v2b4/ymm2CJABZxnMfV2iEsIZ1W38UH89eYYMU7dIPhL7iLVolOPR1Ta3n1Jk0pfxZKjXQ+OzbN8gFaFqT/ZMrfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUc8mv/l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99635C116C6;
	Mon, 18 Aug 2025 18:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755541485;
	bh=IMZlLcdTbTR3iktUWRNqGf1wOuBejkJQOJ/LsettyZs=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=SUc8mv/lVOno1PAGFKwZuLSOoEzM3IW4grm4trlaunS9XR8J3BBX9MX20k9wvAWgn
	 sO4mwpW8v4tDrxWn0AMEKRMrKQMAY4d2DlRuxfEahCiWsrPZ/D8s01NIm77MIzOgH/
	 KXQFZLpxYpYgToyb8bPLcBRoVctG/RgRaLyzoz1OXucOa2HCHctO2Rn+NUSDGu8NL4
	 EgGAzLvu9WbkCuQZWYLEH/qjFuZd62k7UOglARMdB7jDVMYU+oB0wLYZ09mVN9dql0
	 Uaad7Pxu4liSsyvpPHmUS3X+mRl63TRBp35EyOTTPwLRdHsOlMjbjCQYq1F4eFOyLC
	 vXA0TwFsEDgYg==
Date: Mon, 18 Aug 2025 13:24:44 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, 
 Ciprian Costea <ciprianmarian.costea@nxp.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, devicetree@vger.kernel.org, 
 Fabio Estevam <festevam@gmail.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linaro-s32@linaro.org, 
 Matthias Brugger <mbrugger@suse.com>, Chester Lin <chester62515@gmail.com>, 
 Srinivas Kandagatla <srini@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
In-Reply-To: <cover.1755341000.git.dan.carpenter@linaro.org>
References: <cover.1755341000.git.dan.carpenter@linaro.org>
Message-Id: <175554055804.1719797.15716687112044430823.robh@kernel.org>
Subject: Re: [PATCH 0/3] nvmem: s32g-ocotp: Add driver for S32G OCOTP


On Sat, 16 Aug 2025 13:46:57 +0300, Dan Carpenter wrote:
> This driver provides a way to access the On Chip One-Time Programmable
> Controller (OCOTP) on the s32g chipset.  There are three versions of this
> chip but they're compatible.
> 
> Ciprian Costea (2):
>   dt-bindings: nvmem: Add the nxp,s32g-ocotp yaml file
>   nvmem: s32g-ocotp: Add driver for S32G OCOTP
> 
> Dan Carpenter (1):
>   arm64: dts: s32g: Add device tree information for the OCOTP driver
> 
>  .../bindings/nvmem/nxp,s32g-ocotp-nvmem.yaml  |  57 ++++++
>  arch/arm64/boot/dts/freescale/s32g2.dtsi      |   7 +
>  arch/arm64/boot/dts/freescale/s32g3.dtsi      |   7 +
>  drivers/nvmem/Kconfig                         |  10 +
>  drivers/nvmem/Makefile                        |   2 +
>  drivers/nvmem/s32g-ocotp-nvmem.c              | 171 ++++++++++++++++++
>  6 files changed, 254 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/nxp,s32g-ocotp-nvmem.yaml
>  create mode 100644 drivers/nvmem/s32g-ocotp-nvmem.c
> 
> --
> 2.47.2
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

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/freescale/' for cover.1755341000.git.dan.carpenter@linaro.org:

arch/arm64/boot/dts/freescale/s32g274a-evb.dtb: ocotp@400a4000 (nxp,s32g2-ocotp): compatible: 'oneOf' conditional failed, one must be fixed:
	['nxp,s32g2-ocotp'] is too short
	'nxp,s32g2-ocotp' is not one of ['nxp,s32g3-ocotp', 'nxp,s32r45-ocotp']
	from schema $id: http://devicetree.org/schemas/nvmem/nxp,s32g-ocotp-nvmem.yaml#
arch/arm64/boot/dts/freescale/s32g274a-evb.dtb: ocotp@400a4000 (nxp,s32g2-ocotp): Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/nvmem/nxp,s32g-ocotp-nvmem.yaml#
arch/arm64/boot/dts/freescale/s32g274a-rdb2.dtb: ocotp@400a4000 (nxp,s32g2-ocotp): compatible: 'oneOf' conditional failed, one must be fixed:
	['nxp,s32g2-ocotp'] is too short
	'nxp,s32g2-ocotp' is not one of ['nxp,s32g3-ocotp', 'nxp,s32r45-ocotp']
	from schema $id: http://devicetree.org/schemas/nvmem/nxp,s32g-ocotp-nvmem.yaml#
arch/arm64/boot/dts/freescale/s32g274a-rdb2.dtb: ocotp@400a4000 (nxp,s32g2-ocotp): Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/nvmem/nxp,s32g-ocotp-nvmem.yaml#







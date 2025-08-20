Return-Path: <linux-kernel+bounces-778411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A42AEB2E563
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 20:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A8973B8C35
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2797283CAA;
	Wed, 20 Aug 2025 18:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmbgBOMB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461CF2820CB;
	Wed, 20 Aug 2025 18:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755716225; cv=none; b=G4KLkcVjNS5Wr/AvCCIz6jLyhPFRQTpfthkUuc5KOIpF+ehI6KIzfbjh/2u9+uI0JVa7C302n+2/wukBuxq3j8fmVqljWhG2CKvAZX1YlA/anIr5fhcQi7hxhTjjW1h3xpSobGV6asETjyIH8cT1pFDZLqy26YAo6rF/n7y6jlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755716225; c=relaxed/simple;
	bh=xmH9ICu1+8c4k7z7aUw6QdF70bVyfaZxpW8X5Hd9OUE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=ZK8ll2Akp2mlMIB8imvPmRlFbbx9NF9CNSYBOuv7TexMBA4FAJzytx8GnDxAQ2FTQaOE5hI0okBt2cy46vFhOx0kqj82+0vECzSxyddlYOHMbV/eHgE/c/ZxqRBwt8p0gXGCDQbI1uWnOveiBPcEo1VGdpcRf7BHfjRuSDOvFcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmbgBOMB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5408C4CEE7;
	Wed, 20 Aug 2025 18:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755716224;
	bh=xmH9ICu1+8c4k7z7aUw6QdF70bVyfaZxpW8X5Hd9OUE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=fmbgBOMBWKy0U0kdm4mDpEMvbd+C/tGwAnJlGjtkDieL7UKWbPiedmQjJpuc8/Eab
	 0VzrsTdTJ/GY8KDcXXT1rybQJgjrb9Grg+wpI8WORFyMVpB9t98nKMz8WVcr16nrL3
	 VjjSTK+Wz8gxdcIC9fz9HHb6OsboihJk9HE4Gd36lDc1zRe9tHSZTW8UxaP1TFg/Xb
	 ORjkHSvsThBPlPX4/ql1dvNhUfXe3FR+XqNpcb2Nuh1OBIRQxA2enGdGN58Kcb0r4+
	 UyA2x8cG2Mzx7x8tPw4+vPDdlmhRQAmaQKRJIY7OsBIEIliTBDwKDBv0gXt1XaRR7l
	 BVPYAFSEb43Tg==
Date: Wed, 20 Aug 2025 13:57:03 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
To: Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20250820-ls1021a_dts_warning-v2-0-2e39648a32b7@nxp.com>
References: <20250820-ls1021a_dts_warning-v2-0-2e39648a32b7@nxp.com>
Message-Id: <175571287545.265879.1160274338030207211.robh@kernel.org>
Subject: Re: [PATCH v2 0/7] ARM: dts: clean up most ls1021a CHECK_DTB
 warning


On Wed, 20 Aug 2025 12:36:50 -0400, Frank Li wrote:
> clean up most ls1021a CHECK_DTB warning.
> 
> Old uboot check esdhc@1560000. The new uboot already switch to check both
> esdhc@1560000 and mmc@1560000. So we can rename it now.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes in v2:
> - squash rename to flash patches
> - remove duplicate patches already post in
> https://lore.kernel.org/linux-devicetree/20250725061339.266125-1-alexander.stein@ew.tq-group.com/
> - Link to v1: https://lore.kernel.org/r/20250818-ls1021a_dts_warning-v1-0-7a79b6b4a0e2@nxp.com
> 
> ---
> Frank Li (7):
>       ARM: dts: ls1021a: Rename node name nor to flash
>       ARM: dts: ls1021a: Rename 'mdio-mux-emi1' to 'mdio-mux@54'
>       ARM: dts: ls1021a: Rename esdhc@1560000 to mmc@1560000
>       ARM: dts: ls1021a: Rename node name power-controler to wakeup-controller
>       ARM: dts: ls1021a: remove big-endian for mmc modes
>       ARM: dts: ls1021a-tsn: Remove redundant #address-cells for ethernet-switch@1
>       ARM: dts: ls1021a-tqmls1021a-mbls1021a-rgb-cdtech: Remove fallback compatible string edt,edt-ft5x06
> 
>  arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts                          | 8 ++++----
>  .../dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-dc44.dtso  | 2 +-
>  .../dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-fc21.dtso  | 2 +-
>  arch/arm/boot/dts/nxp/ls/ls1021a-tsn.dts                          | 2 --
>  arch/arm/boot/dts/nxp/ls/ls1021a-twr.dts                          | 2 +-
>  arch/arm/boot/dts/nxp/ls/ls1021a.dtsi                             | 6 ++----
>  6 files changed, 9 insertions(+), 13 deletions(-)
> ---
> base-commit: 3ede6e44fad31f1c80dd01188683f0caa0f19247
> change-id: 20250818-ls1021a_dts_warning-fff933bd83da
> 
> Best regards,
> --
> Frank Li <Frank.Li@nxp.com>
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
 Base: base-commit 3ede6e44fad31f1c80dd01188683f0caa0f19247 not known, ignoring
 Base: attempting to guess base-commit...
 Base: tags/next-20250820 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/nxp/' for 20250820-ls1021a_dts_warning-v2-0-2e39648a32b7@nxp.com:

arch/arm/boot/dts/nxp/ls/ls1021a-qds.dtb: memory-controller@1530000 (fsl,ifc): board-control@3,0: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'bank-width', 'compatible', 'device-width', 'mdio-mux@54', 'ranges', 'reg' were unexpected)
	from schema $id: http://devicetree.org/schemas/memory-controllers/fsl/fsl,ifc.yaml#
arch/arm/boot/dts/nxp/ls/ls1021a-qds.dtb: flash@0 (atmel,at45db021d): Unevaluated properties are not allowed ('spi-cpha', 'spi-cpol' were unexpected)
	from schema $id: http://devicetree.org/schemas/mtd/atmel,dataflash.yaml#







Return-Path: <linux-kernel+bounces-730381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAA7B043E1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965D23ACF25
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7568264FB3;
	Mon, 14 Jul 2025 15:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oihjKSIi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220D026462B;
	Mon, 14 Jul 2025 15:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506673; cv=none; b=qo04Cca7T2ANUNbsyOhRlCAyrlpHh/+ZdOuVkeB/IE9NqmH4Wm7Rpv2qoz49RKIaDlpzj/whjDZCSXvW+ZU55F9IOxK4+vqmUutjDEKiIkxnNu9/cJAEpM93FDjgNB+xruiSINW254pOfp9WBHtIYJm+3wDh4vDicORr/vPa8qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506673; c=relaxed/simple;
	bh=97EuZvHvv4ugwMLOhUGF3QO1KrDIi3MQ4YL2KEQadRw=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=TEGjGyD2BkJYoGBKhtvO8tTH2bsTa5E7IgWDpUlSQL5h3BUuGMeeh+REX/wp5wUVWeCjXdPOzAwsWlvc+uwyMrlU+7DSsKLaIdVTRzKUVONA2psvllXbzAWVLRtEo4mL3NTF9fQXb0irgCl2SxT+eC1q6hhZS+B7mdIhSYLuM8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oihjKSIi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A59C4CEED;
	Mon, 14 Jul 2025 15:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752506672;
	bh=97EuZvHvv4ugwMLOhUGF3QO1KrDIi3MQ4YL2KEQadRw=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=oihjKSIi/U08U/aF0oUWpCIvcwpkg4fY55ayG74wWQprui21gdwqtombf2URQo2Tc
	 LN/GXPynytAMNsfWcmS4uHX6+SlBU9ibf+1V7tswTWHqOmpfuOhUqBSNdIaKNgofSV
	 vSwTzka19riEp3AEyvwm6Tod0tll9S+tiKkWC7PAJb+lzu1Dy/gRe/Ie9Vg75cWDqd
	 cc+LH9F0YDbuCqxy/iOJJp+r+7rUJY07sWBMdrTRElf8GR55C4EcnP2k/vZIcAj2u0
	 v+a0bPeqT+4xYBYNq/RJ0FQNBLbTk7ot9e/lfK0s7SAdoP3EA/zLqeHw6opRbnHqMc
	 m2bNRSUAGuYOw==
Date: Mon, 14 Jul 2025 10:24:32 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Rafal Milecki <zajec5@gmail.com>, Stefan Wahren <wahrenst@gmx.net>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>, Hauke Mehrtens <hauke@hauke-m.de>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
To: Taishi Shimizu <s.taishi14142@gmail.com>
In-Reply-To: <20250713071826.726682-1-s.taishi14142@gmail.com>
References: <20250713071826.726682-1-s.taishi14142@gmail.com>
Message-Id: <175250104141.2052760.5355993543096717369.robh@kernel.org>
Subject: Re: [PATCH v2 0/2] ARM: BCM5301X: Add support for Buffalo
 WXR-1750DHP


On Sun, 13 Jul 2025 16:18:23 +0900, Taishi Shimizu wrote:
> This patch series adds support for the Buffalo WXR-1750DHP router,
> based on the Broadcom BCM4708 SoC.
> 
> Patch 1 updates the device tree bindings documentation to list
> Buffalo WXR-1750DHP as a supported board under BCM4708.
> 
> Patch 2 introduces a device tree source file for the router.
> 
> Changes since v1:
>  - remove `chosen` node and `bootargs` (inherited from bcm4708.dtsi)
>  - replace `label` in LEDs with `color` and `function` properties
>  - change USB LED to use `LED_FUNCTION_USB` and added `trigger-sources`
>  - reorder GPIOs and clean up button node formatting
> 
> Taishi Shimizu (2):
>   dt-bindings: arm: bcm: Add support for Buffalo WXR-1750DHP
>   ARM: dts: BCM5301X: Add support for Buffalo WXR-1750DHP
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> # for patch 1
> 
>  .../bindings/arm/bcm/brcm,bcm4708.yaml        |   1 +
>  arch/arm/boot/dts/broadcom/Makefile           |   1 +
>  .../broadcom/bcm4708-buffalo-wxr-1750dhp.dts  | 138 ++++++++++++++++++
>  3 files changed, 140 insertions(+)
>  create mode 100644 arch/arm/boot/dts/broadcom/bcm4708-buffalo-wxr-1750dhp.dts
> 
> 
> base-commit: 379f604cc3dc2c865dc2b13d81faa166b6df59ec
> --
> 2.43.0
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
 Base: using specified base-commit 379f604cc3dc2c865dc2b13d81faa166b6df59ec

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/broadcom/' for 20250713071826.726682-1-s.taishi14142@gmail.com:

arch/arm/boot/dts/broadcom/bcm958305k.dtb: pwm@180aa500 (brcm,kona-pwm): compatible:0: 'brcm,kona-pwm' is not one of ['brcm,bcm11351-pwm']
	from schema $id: http://devicetree.org/schemas/pwm/brcm,kona-pwm.yaml#
arch/arm/boot/dts/broadcom/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@12000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm/boot/dts/broadcom/bcm4708-buffalo-wxr-1750dhp.dtb: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
arch/arm/boot/dts/broadcom/bcm4708-buffalo-wxr-1750dhp.dtb: pcie@12000: 'device_type' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm/boot/dts/broadcom/bcm4708-buffalo-wxr-1750dhp.dtb: pcie@12000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm/boot/dts/broadcom/bcm4708-buffalo-wxr-1750dhp.dtb: pcie@13000: 'device_type' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm/boot/dts/broadcom/bcm4708-buffalo-wxr-1750dhp.dtb: pcie@13000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm/boot/dts/broadcom/bcm4708-buffalo-wxr-1750dhp.dtb: pcie@14000: 'device_type' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm/boot/dts/broadcom/bcm4708-buffalo-wxr-1750dhp.dtb: pcie@14000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm/boot/dts/broadcom/bcm4708-buffalo-wxr-1750dhp.dtb: ethernet-switch@18007000 (brcm,bcm53011-srab): ports:port@5: 'phy-mode' is a required property
	from schema $id: http://devicetree.org/schemas/net/dsa/brcm,b53.yaml#
arch/arm/boot/dts/broadcom/bcm4708-buffalo-wxr-1750dhp.dtb: ethernet-switch@18007000 (brcm,bcm53011-srab): ports:port@5: 'oneOf' conditional failed, one must be fixed:
	'fixed-link' is a required property
	'phy-handle' is a required property
	'managed' is a required property
	from schema $id: http://devicetree.org/schemas/net/dsa/brcm,b53.yaml#
arch/arm/boot/dts/broadcom/bcm4708-buffalo-wxr-1750dhp.dtb: ethernet-switch@18007000 (brcm,bcm53011-srab): ports:port@7: 'phy-mode' is a required property
	from schema $id: http://devicetree.org/schemas/net/dsa/brcm,b53.yaml#
arch/arm/boot/dts/broadcom/bcm4708-buffalo-wxr-1750dhp.dtb: ethernet-switch@18007000 (brcm,bcm53011-srab): ports:port@7: 'oneOf' conditional failed, one must be fixed:
	'fixed-link' is a required property
	'phy-handle' is a required property
	'managed' is a required property
	from schema $id: http://devicetree.org/schemas/net/dsa/brcm,b53.yaml#
arch/arm/boot/dts/broadcom/bcm4708-buffalo-wxr-1750dhp.dtb: ethernet-switch@18007000 (brcm,bcm53011-srab): ports:port@8: 'phy-mode' is a required property
	from schema $id: http://devicetree.org/schemas/net/dsa/brcm,b53.yaml#
arch/arm/boot/dts/broadcom/bcm4708-buffalo-wxr-1750dhp.dtb: ethernet-switch@18007000 (brcm,bcm53011-srab): Unevaluated properties are not allowed ('ports' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/dsa/brcm,b53.yaml#







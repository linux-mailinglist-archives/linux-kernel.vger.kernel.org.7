Return-Path: <linux-kernel+bounces-782732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CAEB32499
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 23:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF4EAC65AC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D94C341650;
	Fri, 22 Aug 2025 21:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2SDqyJS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1CE33EB1D;
	Fri, 22 Aug 2025 21:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755898060; cv=none; b=FEWZeRIeUeDjPXf63Xtyx7XlCGKLAUUWJG4xrl0Gzjjfc9IvYD1P5JDlyCQK9YEggsRvDESDdhw1RGG6KmUJT/Yj3EmT0Ahdc1eLA4c3u4piVMel99k9wQxEkzWfBledT8NPFSUiG5J6J+D9r7Gs/5gqwtPf6zwQ5dnP5knO3zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755898060; c=relaxed/simple;
	bh=HpMSsYpyCPlFj74ZKEihN0J4dnJzaki8VEY4sa1qWsQ=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=PJF9Z9zRnHOoXCKHzzdfAq23jXiYpt4va1P8fyPx0H9X+cZviWLgV0X/VZXTwZCkgrUvztWVnifU6wlbJnbxW0TP6iQPgpvdQhWxLuAjY3HyOiwGBudlwtc550ksYJ/+7cCjK9fqjFlQkZwtLTh+VhoYPjr43wPPgTyhF5tX++E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2SDqyJS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DAEC4CEF1;
	Fri, 22 Aug 2025 21:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755898059;
	bh=HpMSsYpyCPlFj74ZKEihN0J4dnJzaki8VEY4sa1qWsQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=c2SDqyJScPESg1glrinrRFpy9UCxzbJCA6GcUNaYpTyIXMkZ5nhtCk/toPGPkQEe8
	 WRqxHBLe+21e5iEUMWMIpsGGMaD/G1gGR+tuB8JFuJliC76OQkMv16v+MxqiZA9h59
	 SZf2a/U7wfpeHpktuydgkejUFxMHFa9g6KOZpN2DbEgbW/o0kvMI86dj7uRV86D/hG
	 cRsAxOnaHhGR6BHovF0z47TkjrxS5+xlNZOnIiu+CxJ9o5XHGfrb+wCpTrhQi0FHMa
	 GcBiFFh6yQ/199NWzIfBD895L2/MGoXJyvN1vdiZCNquyo9ILoodvYZuFXhjUuy0pq
	 b7bh9BsfoALLg==
Date: Fri, 22 Aug 2025 16:27:39 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 devicetree@vger.kernel.org, Gregory Clement <gregory.clement@bootlin.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250822133329.312326-3-krzysztof.kozlowski@linaro.org>
References: <20250822133329.312326-3-krzysztof.kozlowski@linaro.org>
Message-Id: <175589786306.518460.17450425303264875357.robh@kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: marvell: armada-37xx: Add default PCI
 interrup controller address cells


On Fri, 22 Aug 2025 15:33:30 +0200, Krzysztof Kozlowski wrote:
> Add missing address-cells 0 to the PCI interrupt node to silence W=1
> warning:
> 
>   armada-37xx.dtsi:518.4-521.29: Warning (interrupt_map): /soc/pcie@d0070000:interrupt-map:
>     Missing property '#address-cells' in node /soc/pcie@d0070000/interrupt-controller, using 0 as fallback
> 
> Value '0' is correct because:
> 1. GIC interrupt controller does not have children,
> 2. interrupt-map property (in PCI node) consists of five components and
>    the fourth component "parent unit address", which size is defined by
>    '#address-cells' of the node pointed to by the interrupt-parent
>    component, is not used (=0)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 1 +
>  1 file changed, 1 insertion(+)
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
 Base: tags/next-20250822 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/marvell/' for 20250822133329.312326-3-krzysztof.kozlowski@linaro.org:

arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /soc/bus@f0000000/system-controller@6f8000/clock-cpu: failed to match any schema with compatible: ['marvell,ap807-cpu-clock']
arch/arm64/boot/dts/marvell/cn9130-db.dtb: interrupt-controller@1e0000 (marvell,cp110-icu): interrupt-controller@10: '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/marvell,cp110-icu.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: interrupt-controller@1e0000 (marvell,cp110-icu): interrupt-controller@10: '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/marvell,cp110-icu.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: interrupt-controller@1e0000 (marvell,cp110-icu): interrupt-controller@10: '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/marvell,cp110-icu.yaml#
arch/arm64/boot/dts/marvell/cn9131-db.dtb: interrupt-controller@1e0000 (marvell,cp110-icu): interrupt-controller@10: '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/marvell,cp110-icu.yaml#
arch/arm64/boot/dts/marvell/armada-7040-db.dtb: interrupt-controller@1e0000 (marvell,cp110-icu): interrupt-controller@10: '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/marvell,cp110-icu.yaml#
arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dtb: usb@58000 (marvell,armada3700-xhci): Unevaluated properties are not allowed ('marvell,usb-misc-reg' was unexpected)
	from schema $id: http://devicetree.org/schemas/usb/generic-xhci.yaml#
arch/arm64/boot/dts/marvell/armada-7040-mochabin.dtb: interrupt-controller@1e0000 (marvell,cp110-icu): interrupt-controller@10: '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/marvell,cp110-icu.yaml#
arch/arm64/boot/dts/marvell/cn9131-db.dtb: interrupt-controller@1e0000 (marvell,cp110-icu): interrupt-controller@10: '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/marvell,cp110-icu.yaml#
arch/arm64/boot/dts/marvell/cn9132-clearfog.dtb: interrupt-controller@1e0000 (marvell,cp110-icu): interrupt-controller@10: '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/marvell,cp110-icu.yaml#
arch/arm64/boot/dts/marvell/cn9132-clearfog.dtb: interrupt-controller@1e0000 (marvell,cp110-icu): interrupt-controller@10: '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/marvell,cp110-icu.yaml#
arch/arm64/boot/dts/marvell/cn9130-db-B.dtb: interrupt-controller@1e0000 (marvell,cp110-icu): interrupt-controller@10: '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/marvell,cp110-icu.yaml#
arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dtb: mmc@d8000 (marvell,armada-3700-sdhci): Unevaluated properties are not allowed ('marvell,xenon-emmc' was unexpected)
	from schema $id: http://devicetree.org/schemas/mmc/marvell,xenon-sdhci.yaml#
arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dtb: interrupt-controller@1e0000 (marvell,cp110-icu): interrupt-controller@10: '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/marvell,cp110-icu.yaml#
arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtb: interrupt-controller@1e0000 (marvell,cp110-icu): interrupt-controller@10: '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dtb: connector (usb-a-connector): Unevaluated properties are not allowed ('phy-supply' was unexpected)
	from schema $id: http://devicetree.org/schemas/connector/usb-connector.yaml#
arch/arm64/boot/dts/marvell/cn9131-db-B.dtb: interrupt-controller@1e0000 (marvell,cp110-icu): interrupt-controller@10: '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/marvell,cp110-icu.yaml#
arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dtb: interrupt-controller@1e0000 (marvell,cp110-icu): interrupt-controller@10: '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/marvell,cp110-icu.yaml#
arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtb: interrupt-controller@1e0000 (marvell,cp110-icu): interrupt-controller@10: '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/marvell,cp110-icu.yaml#
arch/arm64/boot/dts/marvell/cn9131-db-B.dtb: interrupt-controller@1e0000 (marvell,cp110-icu): interrupt-controller@10: '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/marvell,cp110-icu.yaml#
arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dtb: interrupt-controller@1e0000 (marvell,cp110-icu): interrupt-controller@10: '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/marvell,cp110-icu.yaml#
arch/arm64/boot/dts/marvell/cn9131-db-B.dtb: /cp1-bus/bus@f4000000/system-controller@440000/clock: failed to match any schema with compatible: ['marvell,cp110-clock']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: interrupt-controller@1e0000 (marvell,cp110-icu): interrupt-controller@10: '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/marvell,cp110-icu.yaml#
arch/arm64/boot/dts/marvell/cn9132-db-B.dtb: interrupt-controller@1e0000 (marvell,cp110-icu): interrupt-controller@10: '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/marvell,cp110-icu.yaml#
arch/arm64/boot/dts/marvell/armada-8040-mcbin-singleshot.dtb: interrupt-controller@1e0000 (marvell,cp110-icu): interrupt-controller@10: '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/marvell,cp110-icu.yaml#
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp0-bus/bus@f2000000/system-controller@400000/thermal-sensor@70: failed to match any schema with compatible: ['marvell,armada-cp110-thermal']
arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: interrupt-controller@1e0000 (marvell,cp110-icu): interrupt-controller@10: '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/marvell,cp110-icu.yaml#
arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dtb: interrupt-controller@1e0000 (marvell,cp110-icu): interrupt-controller@10: '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/marvell,cp110-icu.yaml#
arch/arm64/boot/dts/marvell/cn9132-db-B.dtb: interrupt-controller@1e0000 (marvell,cp110-icu): interrupt-controller@10: '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/marvell,cp110-icu.yaml#
arch/arm64/boot/dts/marvell/armada-8040-mcbin-singleshot.dtb: interrupt-controller@1e0000 (marvell,cp110-icu): interrupt-controller@10: '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/marvell,cp110-icu.yaml#
arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: interrupt-controller@1e0000 (marvell,cp110-icu): interrupt-controller@10: '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/marvell,cp110-icu.yaml#
arch/arm64/boot/dts/marvell/cn9132-db-B.dtb: interrupt-controller@1e0000 (marvell,cp110-icu): interrupt-controller@10: '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/marvell,cp110-icu.yaml#
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: interrupt-controller@1e0000 (marvell,cp110-icu): interrupt-controller@10: '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/marvell,cp110-icu.yaml#
arch/arm64/boot/dts/marvell/cn9132-db.dtb: interrupt-controller@1e0000 (marvell,cp110-icu): interrupt-controller@10: '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/marvell,cp110-icu.yaml#
arch/arm64/boot/dts/marvell/armada-8040-db.dtb: interrupt-controller@1e0000 (marvell,cp110-icu): interrupt-controller@10: '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/marvell,cp110-icu.yaml#
arch/arm64/boot/dts/marvell/cn9130-crb-B.dtb: interrupt-controller@1e0000 (marvell,cp110-icu): interrupt-controller@10: '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/marvell,cp110-icu.yaml#
arch/arm64/boot/dts/marvell/cn9130-crb-A.dtb: interrupt-controller@1e0000 (marvell,cp110-icu): interrupt-controller@10: '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/marvell,cp110-icu.yaml#
arch/arm64/boot/dts/marvell/armada-8040-db.dtb: interrupt-controller@1e0000 (marvell,cp110-icu): interrupt-controller@10: '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/marvell,cp110-icu.yaml#
arch/arm64/boot/dts/marvell/cn9132-db.dtb: interrupt-controller@1e0000 (marvell,cp110-icu): interrupt-controller@10: '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/marvell,cp110-icu.yaml#
arch/arm64/boot/dts/marvell/cn9132-db.dtb: interrupt-controller@1e0000 (marvell,cp110-icu): interrupt-controller@10: '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/marvell,cp110-icu.yaml#







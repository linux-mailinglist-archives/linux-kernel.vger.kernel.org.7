Return-Path: <linux-kernel+bounces-787381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D65B0B37571
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 01:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 976842A8695
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 23:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDFF2FA0F7;
	Tue, 26 Aug 2025 23:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyJRIJAl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2385E2264CE;
	Tue, 26 Aug 2025 23:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756250386; cv=none; b=M4U4ZiuL9GvKrvdc9D0W1Lqe3A+ZRFixN8H6RN5vmCYSHCM2/f6ng5P2w3iYsa8VKAvYyu9Mkq5M8Ral2ntSlM79wkYEpBtLW63ZUx33V9zfAb782VPsVxZR8e7J/QAsABU1Y8AN2sMldTmgYl+moKiNs+4dZrAtcY2FHweYpdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756250386; c=relaxed/simple;
	bh=V5+/7XEH4hLHcMPBz+Zh+CzV2IBqlOxEt53xo3DTfZE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=kc2UxtnwuEm7T8K2aXXSsNVfop12thJC8q1obxK9GD4WO2TuyHjwUL7aMQq1Vr8BoACKEcFbdSB57a8ydy4SGaFSAcdeR0Xd4lxyjBhopHhUK1MxSLzePMGL1FNQbd3C/nydVwoRcd+wU4iXjr0gcC/CvnIN+D7HuOt6JAuDIF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyJRIJAl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB81C4CEF1;
	Tue, 26 Aug 2025 23:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756250385;
	bh=V5+/7XEH4hLHcMPBz+Zh+CzV2IBqlOxEt53xo3DTfZE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=WyJRIJAltpcqF4H0kfN2dPHSy1g5gDlTD30riJD+bz0LI5HIkCp4PG6eLEylKLH+V
	 tQRMZ6ZAdMUBI7scoEmhOIR5r+fwcaTXC+6q0QuwCToO+fcmXzQ4d/dQsxdC35/OQm
	 nq2LMCYX39HlzrLUi3LVFmYjI0lMNjWZ4RRsXcHn4tai1BuNcHzjRwnQy6be9E/eKk
	 t4JQiV8YryEQfejroFA1Q4svIPRrhghBYXBqLCU0yIT/cFHtfI3Wkkh90lYIzqdbjZ
	 J0mkPpkPbx2qw93wdICGX6hWPI0RqE1ZAtD+SPyCID59a/YSI3RfnPIrtIysTNS/xd
	 Yk7PmgGd5ZDEQ==
Date: Tue, 26 Aug 2025 18:19:44 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
In-Reply-To: <20250826134259.2564191-1-alexander.stein@ew.tq-group.com>
References: <20250826134259.2564191-1-alexander.stein@ew.tq-group.com>
Message-Id: <175625023024.716358.4095639193170110202.robh@kernel.org>
Subject: Re: [PATCH 1/2] ARM: dts: tps65910: Add gpio & interrupt
 properties


On Tue, 26 Aug 2025 15:42:57 +0200, Alexander Stein wrote:
> The binding document ti,tps65910.yaml requires the controller and
> cells properties for both gpio and interrupts. As they have const and
> fixed values a default can be provided for all users.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  arch/arm/boot/dts/tps65910.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
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
 Base: tags/next-20250825 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/ti/' for 20250826134259.2564191-1-alexander.stein@ew.tq-group.com:

arch/arm/boot/dts/ti/omap/am335x-pdu001.dtb: tps@2d (ti,tps65910): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
arch/arm/boot/dts/ti/omap/am335x-base0033.dtb: tps@2d (ti,tps65910): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
arch/arm/boot/dts/ti/omap/am335x-baltos-ir5221.dtb: tps@2d (ti,tps65910): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
arch/arm/boot/dts/ti/omap/am335x-regor-rdk.dtb: pmic@2d (ti,tps65910): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
arch/arm/boot/dts/ti/omap/am335x-netcom-plus-8xx.dtb: tps@2d (ti,tps65910): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
arch/arm/boot/dts/ti/omap/am335x-evm.dtb: tps@2d (ti,tps65910): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
arch/arm/boot/dts/ti/omap/am335x-evmsk.dtb: tps@2d (ti,tps65910): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
arch/arm/boot/dts/ti/omap/omap3-echo.dtb: tps@2d (ti,tps65910): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
arch/arm/boot/dts/ti/omap/am335x-moxa-uc-8100-me-t.dtb: tps@2d (ti,tps65910): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
arch/arm/boot/dts/ti/omap/am335x-icev2.dtb: power-controller@2d (ti,tps65910): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
arch/arm/boot/dts/ti/omap/am335x-phycore-rdk.dtb: pmic@2d (ti,tps65910): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
arch/arm/boot/dts/ti/omap/am3517-craneboard.dtb: tps@2d (ti,tps65910): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
arch/arm/boot/dts/ti/omap/am335x-netcom-plus-2xx.dtb: tps@2d (ti,tps65910): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
arch/arm/boot/dts/ti/omap/am335x-netcan-plus-1xx.dtb: tps@2d (ti,tps65910): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
arch/arm/boot/dts/ti/omap/am335x-baltos-ir3220.dtb: tps@2d (ti,tps65910): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
arch/arm/boot/dts/ti/omap/am335x-wega-rdk.dtb: pmic@2d (ti,tps65910): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
arch/arm/boot/dts/ti/omap/am335x-baltos-ir2110.dtb: tps@2d (ti,tps65910): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
arch/arm/boot/dts/ti/omap/am335x-lxm.dtb: tps@2d (ti,tps65910): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#







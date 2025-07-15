Return-Path: <linux-kernel+bounces-732049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCB9B06144
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0FDD1C402E3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B108D204863;
	Tue, 15 Jul 2025 14:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTO9LMpp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1047B20296C;
	Tue, 15 Jul 2025 14:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589560; cv=none; b=UPtvFZu3Uhm/R3TlrLCGx2DG/hAp5SaAKRc6qKjlHLy2k1CMUsmmq1U1sDqLhrhGAyDA011lZ3CWvnEsXnnP1nTL3te4F5gbj9XYxvWA1hhoz61zqCeJGMPILhB/GUfvQztnZ0LnrM5A4K3ELspp8DSaCeAH3Oje162ZdlvUkCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589560; c=relaxed/simple;
	bh=4Iuh1W4p/GuvtYKXIWTDTZsm2HB078xwuI7VRYFOyrw=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=SS6IznmWgwWMBsmUZioH8Q+iYLC1eqjBm0MhiG0NQyC/N+qVRlluuDHBM2G1aT470p87NFCMfP6Fm24W7CgsoOHUY9evoVR43MYyZiIyz9Lfq7BLL0i8ClH0Q5EwZGrezVdr9XAhjBTCrYWU2m1Le3sheDzSDwTrqCQKqt7aKyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTO9LMpp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE2DC4CEE3;
	Tue, 15 Jul 2025 14:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752589559;
	bh=4Iuh1W4p/GuvtYKXIWTDTZsm2HB078xwuI7VRYFOyrw=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=kTO9LMpppBNDHQsBuRHRm7reVUOsGe4WX1YKctqv6iQWzbpNpKKQr3XuqAkSK85bq
	 qD5CJ4tAUv4cq0Nw/3C25mnl5K4VFYtuHHI8TV2w/b9GmIuoLhDXBUIySdpcLApvic
	 mZhp6F9t9M6TNAtr4xx4Stm8+7csKiPYehRn4VI17JPmZvDP9eycI3HkjLgv7VZP95
	 86VFSx/X1SJV5jLNwnTO40XUc1OapKhEI6IwCSntnvT6tvzmwpI9BxtnDbZGa23GR/
	 4HivpPBJIf/oE9L8cJ0GsWg2OI4gPGr8u/Jj9/LbezFz49+hdJ/20/ZgdzEBaeongY
	 YDjIAY54qI2GQ==
Date: Tue, 15 Jul 2025 09:25:58 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Frank Wang <frank.wang@rock-chips.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Chaoyi Chen <chaoyi.chen@rock-chips.com>, dri-devel@lists.freedesktop.org, 
 Thomas Zimmermann <tzimmermann@suse.de>, Conor Dooley <conor+dt@kernel.org>, 
 Amit Sunil Dhamne <amitsd@google.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Heiko Stuebner <heiko@sntech.de>, Johan Jonker <jbx6244@gmail.com>, 
 linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>, 
 Andy Yan <andy.yan@rock-chips.com>, linux-phy@lists.infradead.org, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Diederik de Haas <didi.debian@cknow.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dragan Simic <dsimic@manjaro.org>, linux-arm-kernel@lists.infradead.org, 
 Yubing Zhang <yubing.zhang@rock-chips.com>, Simona Vetter <simona@ffwll.ch>, 
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
 Sandy Huang <hjc@rock-chips.com>, Maxime Ripard <mripard@kernel.org>
To: Chaoyi Chen <kernel@airkyi.com>
In-Reply-To: <20250715112456.101-1-kernel@airkyi.com>
References: <20250715112456.101-1-kernel@airkyi.com>
Message-Id: <175258937557.1273563.1571687320229620719.robh@kernel.org>
Subject: Re: [PATCH 0/5] Add Type-C DP support for RK3399 EVB IND board


On Tue, 15 Jul 2025 19:24:51 +0800, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> The RK3399 EVB IND board has a Type-C interface DisplayPort. It use
> fusb302 chip as Type-C controller.
> 
> This series focuses on adding TCPM support for USBDP PHY and DP driver.
> Before this, the USBDP PHY and DP controller of RK3399 sensed state
> changes through extcon, and devices such as the RK3399 Gru-Chromebook
> rely on them. This series should not break them.
> 
> Patch1 add missing "displayport" prop for USB connector binding.
> Patch2 add new Type-C mode/orientation switch for RK3399 USBDP phy
> binding.
> Patch3 add TCPM support for RK3399 USBDP PHY.
> Patch4 add TCPM support for CDN-DP.
> Patch5 add Type-C DP support for RK3399 EVB IND board.
> 
> Chaoyi Chen (5):
>   dt-bindings: connector: Add displayport connector for hotplug notify
>   dt-bindings: phy: rockchip: rk3399-typec-phy: Support mode/orientation
>     switch
>   phy: rockchip: phy-rockchip-typec: Add support for Type-C TCPM
>   drm/rockchip: cdn-dp: Add support for Type-C TCPM
>   arm64: dts: rockchip: rk3399-evb-ind: Add support for DisplayPort
> 
>  .../bindings/connector/usb-connector.yaml     |   4 +
>  .../phy/rockchip,rk3399-typec-phy.yaml        |  14 +
>  .../boot/dts/rockchip/rk3399-evb-ind.dts      | 119 +++++++
>  drivers/gpu/drm/rockchip/cdn-dp-core.c        |  37 +-
>  drivers/phy/rockchip/phy-rockchip-typec.c     | 335 +++++++++++++++++-
>  5 files changed, 482 insertions(+), 27 deletions(-)
> 
> --
> 2.49.0
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
 Base: tags/next-20250715 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/rockchip/' for 20250715112456.101-1-kernel@airkyi.com:

arch/arm64/boot/dts/rockchip/rk3399-evb-ind.dtb: dp@fec00000 (rockchip,rk3399-cdn-dp): ports: 'port@0' is a required property
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,rk3399-cdn-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3399-evb-ind.dtb: dp@fec00000 (rockchip,rk3399-cdn-dp): ports: 'port@1' is a required property
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,rk3399-cdn-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3399-evb-ind.dtb: dp@fec00000 (rockchip,rk3399-cdn-dp): Unevaluated properties are not allowed ('ports' was unexpected)
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,rk3399-cdn-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3399-evb-ind.dtb: /sound: failed to match any schema with compatible: ['rockchip,rk3399-gru-sound']







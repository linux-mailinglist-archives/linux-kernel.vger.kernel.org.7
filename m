Return-Path: <linux-kernel+bounces-832625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1443B9FF2F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE0038156F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E723D2C15AA;
	Thu, 25 Sep 2025 14:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKHmwWPi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172092C11ED;
	Thu, 25 Sep 2025 14:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758809554; cv=none; b=VFKeV7BdY5aAcu/QE4QcNi+wQDkIiUMpgN1nGQuSrhsBrmFvmZnkNI9pDWmmbElrvLA7FQtJMHeTz2/Onm6uWekFxOH1vBQ5P9iSIqAQDFyAJDAEg4LS3jtqrYp3SuFoXT5ctq3OBxxVeDqhOzEfDTzpLjJeiAofAhw+Q3G8nfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758809554; c=relaxed/simple;
	bh=h7xLn3JbQ44tHSWjgTil1jBLnAigdCGXSZlWVSiK9lw=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=mdkAKUkh4E6jL6IGtRnUhgUAibf7GNE9h2KDLSFXCcxw2WK3MeWZ1wlKmU495lisnvxtiDXuXe48RlTQ35E88MqkI3EuW3Cu1FSFXXfaJ012PfkZLp8MGHiLSuPe2cJjXNRyF3TNFzx/rHtRUn995QGcMQSXo1ffGvBqj17rgrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKHmwWPi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C787FC4CEF0;
	Thu, 25 Sep 2025 14:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758809553;
	bh=h7xLn3JbQ44tHSWjgTil1jBLnAigdCGXSZlWVSiK9lw=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=uKHmwWPiAF26pecH3W9083RZX+cel1OzbqbxPPt9XyJNIippOCmR4KZyLlcoNab8O
	 7s3YmLQSeL4KJC4etojwVlSGD6mUVLbyKNfcLqdPU0KufuFFnQoelwStmvZQKH/EhY
	 vSAsFD6/FATRyQ87RSNOGE/zWgRNyI88bPI1PBUMw5xn4TGIXz3Dtx4z2wb3UJQBZN
	 /9o7gNeh+hVHspM8IRqskHmJhHqfxpe2a8D2uicY5ZDhoNEWf+oI9fyIp4D/z3SRDv
	 pl0GSB9flrxXRqnaa3fAEOyNHcLZunI1a/MgBWQ++2yFFv+WE3OAUMcC4EzdnLtRH2
	 +L359CtHBWxhQ==
Date: Thu, 25 Sep 2025 09:12:33 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: kever.yang@rock-chips.com, krzk+dt@kernel.org, heiko@sntech.de, 
 alchark@gmail.com, linux-rockchip@lists.infradead.org, 
 didi.debian@cknow.org, pbrobinson@gmail.com, honyuenkwun@gmail.com, 
 naoki@radxa.com, mani@kernel.org, neil.armstrong@linaro.org, 
 linux-arm-kernel@lists.infradead.org, quentin.schulz@cherry.de, 
 jbx6244@gmail.com, conor+dt@kernel.org, dsimic@manjaro.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, inindev@gmail.com, 
 ivan8215145640@gmail.com
To: Liangbin Lian <jjm2473@gmail.com>
In-Reply-To: <20250925092037.13582-1-jjm2473@gmail.com>
References: <20250925092037.13582-1-jjm2473@gmail.com>
Message-Id: <175880949051.820269.9096832740960574577.robh@kernel.org>
Subject: Re: [PATCH v2 0/3] arm64: dts: rockchip: introduce LinkEase EasePi
 R1


On Thu, 25 Sep 2025 17:20:34 +0800, Liangbin Lian wrote:
> LinkEase EasePi R1 [1] is a high-performance mini router.
> 
> Specification:
> - Rockchip RK3568
> - 2GB/4GB LPDDR4 RAM
> - 16GB on-board eMMC
> - 1x M.2 key for 2280 NVMe (PCIe 3.0)
> - 1x USB 3.0 Type-A
> - 1x USB 2.0 Type-C (for USB flashing)
> - 2x 1000 Base-T (native, RTL8211F)
> - 2x 2500 Base-T (PCIe, RTL8125B)
> - 1x HDMI 2.0 Output
> - 12v DC Jack
> - 1x Power key connected to PMIC
> - 2x LEDs (one static power supplied, one GPIO controlled)
> 
> [1] https://doc.linkease.com/zh/guide/easepi-r1/hardware.html
> 
> Signed-off-by: Liangbin Lian <jjm2473@gmail.com>
> ---
> Changes in v2:
> - Change deprecated "rockchip,system-power-controller" to "system-power-controller"
> - Link to v1: https://lore.kernel.org/r/20250925055906.83375-1-jjm2473@gmail.com/
> 
> ---
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
 Base: failed to guess base

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/rockchip/' for 20250925092037.13582-1-jjm2473@gmail.com:

arch/arm64/boot/dts/rockchip/rk3568-easepi-r1.dtb: mmc@fe000000 (rockchip,rk3568-dw-mshc): status: 'oneOf' conditional failed, one must be fixed:
	['disable'] is not of type 'object'
	'disable' is not one of ['okay', 'disabled', 'reserved', 'fail', 'fail-needs-probe']
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm64/boot/dts/rockchip/rk3568-easepi-r1.dtb: mmc@fe2b0000 (rockchip,rk3568-dw-mshc): status: 'oneOf' conditional failed, one must be fixed:
	['disable'] is not of type 'object'
	'disable' is not one of ['okay', 'disabled', 'reserved', 'fail', 'fail-needs-probe']
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#







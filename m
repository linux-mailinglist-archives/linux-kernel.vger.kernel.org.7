Return-Path: <linux-kernel+bounces-786748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4384B3677D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90BB88E7FD7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB9D350834;
	Tue, 26 Aug 2025 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fl+4kFLi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4A6341ABD;
	Tue, 26 Aug 2025 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216604; cv=none; b=EHIelAAQJpavMcWw/Yi/NU9s9zJs0sEYfHUe+CALf2q3ZPiZGDzf9c9m275mOPKjQilYPinwk+q5sdwK7tuw4qZj5vSgoK+61Y3dKIDK04Nv0S2uWmDprmHXhtJ4K/jPydw2pf/yTgNK9d/8V3QV5pprWRhEMMhRMNPQbdD3OGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216604; c=relaxed/simple;
	bh=xnXpnVUGFEd1h6mY4HxI1CfSHwBmj/DTXkzjf07zO3M=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=hZ+InbOboJVkcknUQb7aJljXmQazrqfkUVkJ41p/1c1Ix6IJ+MAgSuydmz2ARU2I3O0xv5roofXy18WHPaktOQK/w7qfh3H1qE39CvVvFyrcQvhQO4pBycdG6BTW0i8yWr9ONRmi3PMO12J/QJnOVTM44Qox4/Ch3n/g+D3+BrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fl+4kFLi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECD3C116B1;
	Tue, 26 Aug 2025 13:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756216604;
	bh=xnXpnVUGFEd1h6mY4HxI1CfSHwBmj/DTXkzjf07zO3M=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Fl+4kFLi9xi0OWLGHAm4VRn0IfkuXC0HUJqTXNN+bOCMxEQiXBhH6UKAVj3OB0+JU
	 R9dLFpZxnOvUCB+l3ocd/5YJKtNLBsQQ+ODsjdMGOOIa1rgu/W1yFa+vBWOpP87Xk5
	 WhwKSgq8R42zh1U0OLIEJs4tTMw9vg4o81ZgOj9gpn6crBdtb9G/ciA+XjwyKFywux
	 itfSWG/NX1sTzL5+eLtAQUuuAZrHk4t3dgfD+gR+uOrDduhC6gzmYvfn9w6YMqtytF
	 w4kl7LO5CyPJx6FptL8oVA1e45IiT4U8IC5cWAH+D5Mtodv0UDwwCOxQGWFAuJonV2
	 2HVI2GfQEBfwQ==
Date: Tue, 26 Aug 2025 08:56:43 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, 
 Stephen Rothwell <sfr@canb.auug.org.au>, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Fred Bloggs <f.blogs@napier.co.nz>, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Hsun Lai <i@chainsx.cn>
In-Reply-To: <20250826030818.3485927-1-i@chainsx.cn>
References: <20250826030818.3485927-1-i@chainsx.cn>
Message-Id: <175621649670.159455.15557432322730951360.robh@kernel.org>
Subject: Re: [PATCH v2 0/2] Add support for 100ASK DShanPi A1


On Tue, 26 Aug 2025 11:08:15 +0800, Hsun Lai wrote:
> This series add support for 100ASK DShanPi A1.
> 
> Info of device can be found at:
> https://wiki.dshanpi.org/en/docs/DshanPi-A1/intro/
> 
> Changes in v2:
> - Delete the pwm include file (Chukun Pan, v1)
> - Fix vcc3v3_pcie gpios (Chukun Pan, v1)
> - Adjust the order of some nodes (Chukun Pan, v1)
> - Fix sdmmc (Chukun Pan, v1)
> - Add phy-supply for u2phy0_otg (Chukun Pan, v1)
> 
> Changes in v1:
> - Add support for 100ASK DShanPi A1
> 
> Hsun Lai (2):
>   dt-bindings: arm: rockchip: Add 100ASK DShanPi A1
>   arm64: dts: rockchip: add DTs for 100ASK DShanPi A1
> 
>  .../devicetree/bindings/arm/rockchip.yaml     |   5 +
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../dts/rockchip/rk3576-100ask-dshanpi-a1.dts | 838 ++++++++++++++++++
>  3 files changed, 844 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dts
> 
> --
> 2.34.1
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
 Base: tags/v6.17-rc1-22-g7d11b8c260ea (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/rockchip/' for 20250826030818.3485927-1-i@chainsx.cn:

arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dtb: syscon@26034000 (rockchip,rk3576-dcphy-grf): clocks: False schema does not allow [[21, 492]]
	from schema $id: http://devicetree.org/schemas/soc/rockchip/grf.yaml#
arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dtb: /soc/dsi@27d80000: failed to match any schema with compatible: ['rockchip,rk3576-mipi-dsi2']







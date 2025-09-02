Return-Path: <linux-kernel+bounces-796568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289C6B40295
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B39597B38EF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512272F9C3D;
	Tue,  2 Sep 2025 13:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFqXKUei"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63383043BA;
	Tue,  2 Sep 2025 13:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819098; cv=none; b=A9QWnW7NYRFueDVUB+8QGFxa1ZCfs3ndVflzkZlBGd43qdjZvROmsZJk24fUmrnfJOG6xBxPYb/1f9bIsqyvY8c8APhN6rGckqGAIm3ncGaYk0uWTMIlvAS3Kq9J77zY7Vps9nO1bKDaXTO3a7GtFmTjGm2PiBfJDBPww9WEO9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819098; c=relaxed/simple;
	bh=K0GSdivUZWDBfPpkGbzM+dh5X2lVniJv3YjK1fZ5fEM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=twBGgAv+E8pHsWwm9HIhJctKfXDSfG/DQjWIy6bxhaY6vWkUaGZlLKF82CXaxOgchfcqn1sjw/ArhCxcRW/p02Hraq7Hi5cgNNMpzxRqmZG5yQNh/tJEDWuQT6OC4eYlT/ZRYbWNZhFKy1kfaqZx1P2wPqfmRnyCEqFGO50QArk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFqXKUei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BAFC4CEED;
	Tue,  2 Sep 2025 13:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756819098;
	bh=K0GSdivUZWDBfPpkGbzM+dh5X2lVniJv3YjK1fZ5fEM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=UFqXKUeicCIzvOluYdJkonrNBf/8NoPzAq1tQwdG8JSYZMnvVmrABd/iL+IF7QyHS
	 ft3YG30ij+cp5MBdJwKPNfJ15Ih3ZgTXTDD9wr9lB14ZlRrjJXvVVcTx5Te0rhKNso
	 4XdqqPIRU/OzfqghFsZ8tNSLOUi2kngMCdOvll0PwYGssKqoouM/oKpROgjayRMLvV
	 YPpdQkzGdmlQ+BZ+Fah1AeE8uLrW4N8Bn6LmfDUpDcB/0mB4tGhG65rfvjmKZFDq+w
	 hxQfjpHBa4uhvOyZpV3c3L0wKz4zHrk6rV4t2e16E4I/pTy/yI4ziyPCWU1xGXzs5f
	 uuZ4+yvT/+Y4A==
Date: Tue, 02 Sep 2025 08:18:00 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Fred Bloggs <f.blogs@napier.co.nz>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Heiko Stuebner <heiko@sntech.de>, Stephen Rothwell <sfr@canb.auug.org.au>, 
 linux-kernel@vger.kernel.org
To: Hsun Lai <i@chainsx.cn>
In-Reply-To: <20250901025037.81548-1-i@chainsx.cn>
References: <20250901025037.81548-1-i@chainsx.cn>
Message-Id: <175678731228.878036.16153642695383320999.robh@kernel.org>
Subject: Re: [PATCH v3 0/2] Add support for 100ASK DShanPi A1


On Mon, 01 Sep 2025 10:50:35 +0800, Hsun Lai wrote:
> This series add support for 100ASK DShanPi A1.
> 
> Info of device can be found at:
> https://wiki.dshanpi.org/en/docs/DshanPi-A1/intro/
> 
> Changes in v3:
> - Update the name of vcc_in regulator (Chukun Pan, v2)
> - Fix PCIE (Chukun Pan, v2)
> - Update the name of typec5v_pwren_h pinctrl (Chukun Pan, v2)
> - Fix USB3 (Chukun Pan, v2)
> - Remove i2c2 node, unsupported RTC model rs4c1338 (Chukun Pan, v2)
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
>  .../dts/rockchip/rk3576-100ask-dshanpi-a1.dts | 795 ++++++++++++++++++
>  3 files changed, 801 insertions(+)
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

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/rockchip/' for 20250901025037.81548-1-i@chainsx.cn:

arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dtb: syscon@26034000 (rockchip,rk3576-dcphy-grf): clocks: False schema does not allow [[21, 492]]
	from schema $id: http://devicetree.org/schemas/soc/rockchip/grf.yaml#
arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dtb: /soc/dsi@27d80000: failed to match any schema with compatible: ['rockchip,rk3576-mipi-dsi2']







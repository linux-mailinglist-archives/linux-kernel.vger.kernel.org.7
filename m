Return-Path: <linux-kernel+bounces-893389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F00C473BB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B87E4ECB53
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CAB22157B;
	Mon, 10 Nov 2025 14:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ni9jDhqG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0578C314B76;
	Mon, 10 Nov 2025 14:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762785276; cv=none; b=EmlBADx2J8Hy9iOf5H/YmNgxfh55+KJbYdwGGTg4ZaLR6FSbtx9P7Jnhmw4e+xfUk5jtUUSBjO0a9vP0dJkcH3GG73fqYbXp5No9PlqaDJzn87hKwEmGj9uPArjKXoiuFAf4IRkt1GAn4bwI+Ep4mk/EtV/o9H86Uq7FWaMnW5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762785276; c=relaxed/simple;
	bh=m8gTUwErcvUiLoD21fSkXdLe/TPUchJWC+DOnE/nmic=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=RqW5VYa0/+ZK9OVUG9WZNcxZqMNOIwL4pPVKrnG9BdYok5TpVbUdRBQzkr8471iZvsyW6NmqPv1z6d2hNNzlJ3iB2SRWWIc9X0lSdfPzdA+wCQv6RIVvHBVpqN5PAjHssSVOTziIWCWc+C16CfWaPASeLnigNF+EG7xl8Fe8dak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ni9jDhqG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4C8C2BC86;
	Mon, 10 Nov 2025 14:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762785275;
	bh=m8gTUwErcvUiLoD21fSkXdLe/TPUchJWC+DOnE/nmic=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Ni9jDhqGDQszcc6X8xP6kCNgsY3pkLqyvvt3nY7zUGfJv+22tOmMr9dM0wKbPm+j2
	 IU41u7pUlRJRySt/4TWVdKut8H2+rpqtQ27pb09TDhiRoq2qZbo0cxMFDz1iPL+7Fe
	 nm8Gvx4TlOx3VCzWTvJYWt7FffLO8XaJvMF37dOBwbjjABojf5vieP3hvoHP07dN7g
	 fxh7m1qEgS6dXsfT/ikz3bbb3OBjHroAE4lr9RE6SFDp0xOnsnQ27qZefYg6azy2Vj
	 uLE1RdCuZ+vuQg47Z7lUa+b6wwQDVuCyBWXq63TO7IGZvKjzotc3rE+n01QVOnBoU5
	 zGHca64JaUoJQ==
Date: Mon, 10 Nov 2025 08:34:34 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Joel Stanley <joel@jms.id.au>, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
To: Marc Olberding <molberding@nvidia.com>
In-Reply-To: <20251108-msx1_devicetree-v3-0-c7cb477ade27@nvidia.com>
References: <20251108-msx1_devicetree-v3-0-c7cb477ade27@nvidia.com>
Message-Id: <176278493385.154655.886985963575839587.robh@kernel.org>
Subject: Re: [PATCH v3 0/2] Add device tree for Nvidia BMC msx4 cx8
 switchboard


On Sat, 08 Nov 2025 14:24:33 -0800, Marc Olberding wrote:
> Patch 1 Adds the binding for the msx4 cx8 switchboard
> Patch 2 Adds the device tree for the msx4 cx8 switchboard reference implementation.
> 
> This is an Aspeed AST2600 based reference implementation for a BMC
> managing the nvidia mgx cx8 switchboard.
> 
> Reference to Ast2600 Soc [1].
> 
> Link: https://www.aspeedtech.com/server_ast2600/ [1]
> 
> Signed-off-by: Marc Olberding <molberding@nvidia.com>
> ---
> Changes in v3:
> - Removed mac and mdio node completely per Andrew Lunn's request. Will add back
>     once the mac driver is fixed
> - Link to v2: https://lore.kernel.org/r/20251107-msx1_devicetree-v2-0-6e36eb878db2@nvidia.com
> 
> Changes in v2:
> - Added ack by Conor Dooley on patch 1
> - Changed phy-mode attribute after discussion with Andrew Jeffery and feedback from Andrew Lunn
>     and added a comment with a better explanation
> - Link to v1: https://lore.kernel.org/r/20250918-msx1_devicetree-v1-1-18dc07e02118@nvidia.com
> 
> ---
> Marc Olberding (2):
>       dt-bindings: arm: aspeed: Add Nvidia msx4 board
>       dts: aspeed: Add a dts for the nvidia msx4 hpm
> 
>  .../devicetree/bindings/arm/aspeed/aspeed.yaml     |   1 +
>  arch/arm/boot/dts/aspeed/Makefile                  |   1 +
>  .../boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts | 235 +++++++++++++++++++++
>  3 files changed, 237 insertions(+)
> ---
> base-commit: 38a2c275c3d3f7d7180d012386cd6fcf87854400
> change-id: 20250908-msx1_devicetree-7af2c1fc15d0
> 
> Best regards,
> --
> Marc Olberding <molberding@nvidia.com>
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
 Base: 38a2c275c3d3f7d7180d012386cd6fcf87854400 (use --merge-base to override)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/aspeed/' for 20251108-msx1_devicetree-v3-0-c7cb477ade27@nvidia.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dtb: timer (arm,armv7-timer): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/timer/arm,arch_timer.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dtb: sdram@1e6e0000 (aspeed,ast2600-sdram-edac): compatible: ['aspeed,ast2600-sdram-edac', 'syscon'] is too long
	from schema $id: http://devicetree.org/schemas/edac/aspeed,ast2400-sdram-edac.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dtb: bus@1e600000 (aspeed,ast2600-ahbc): compatible: ['aspeed,ast2600-ahbc', 'syscon'] is too long
	from schema $id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dtb: syscon@1e6e2000 (aspeed,ast2600-scu): 'smp-memram@180' does not match any of the regexes: '^interrupt-controller@[0-9a-f]+$', '^p2a-control@[0-9a-f]+$', '^pinctrl(@[0-9a-f]+)?$', '^pinctrl-[0-9]+$', '^silicon-id@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dtb: /ahb/apb/syscon@1e6e2000/smp-memram@180: failed to match any schema with compatible: ['aspeed,ast2600-smpmem']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dtb: adc@1e6e9000 (aspeed,ast2600-adc0): 'interrupts' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dtb: adc@1e6e9100 (aspeed,ast2600-adc1): 'interrupts' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dtb: crypto@1e6fa000 (aspeed,ast2600-acry): 'aspeed,ahbc' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/crypto/aspeed,ast2600-acry.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dtb: /ahb/apb/lpc@1e789000/lhc@a0: failed to match any schema with compatible: ['aspeed,ast2600-lhc']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dtb: /ahb/apb/lpc@1e789000/ibt@140: failed to match any schema with compatible: ['aspeed,ast2600-ibt-bmc']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dtb: /ahb/apb/dma-controller@1e79e000: failed to match any schema with compatible: ['aspeed,ast2600-udma']







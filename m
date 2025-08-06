Return-Path: <linux-kernel+bounces-757877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BACB1C7C6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E66D164A24
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC1F28DF50;
	Wed,  6 Aug 2025 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDjRysBF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDDA28DB78;
	Wed,  6 Aug 2025 14:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754491232; cv=none; b=Gim8uBnvLO8/NC2B1A5e2PwLKJWxED+lzkSc+/HVLLi29Pp7oBH/HZVjtHQRcDEZkLHqAhpE/BJFk2frqMgsNS27L3eSuO7++4x6q1bXAfuK6D6VwMZgofUEJo/VP19hslWdQDPG8fo7fauiPUa+1H2iiQc05EzXSRUg4lYOKws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754491232; c=relaxed/simple;
	bh=EblJcM6UV2Fk655c6OrUU4cocp87gisfHSYUOgjEB6c=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=uCpXzDMQ5f6TGOrJ9R98n5rdTDB+QO0l7HWXRE9YlFjYQFhEbFaKS/fwhZUnloQv8B7GWJgY15d40eOI3TYClYp3eExN2ZkDvYOctt0A0r9DfP9B/IRxfEckG6t3ZCLAGJ4EBnm3EjjljjDnJNiJPnou0NtVbow5BXiNYRK4VZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDjRysBF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7447BC4CEFC;
	Wed,  6 Aug 2025 14:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754491231;
	bh=EblJcM6UV2Fk655c6OrUU4cocp87gisfHSYUOgjEB6c=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=oDjRysBFpjCnpdQr+LR9E3FtM2mhSTCDF8AFOG3eWTzY4LMn55igeqzirY52s/2+z
	 QvJ8OUxQXGCYRJTkcHE9TVMsXHFcIY3QDrVFPylIAcRl5bt8iWjir5EkxF5F9vZpan
	 ZmCANTDMcpw37Gy+41p2g3zWm4CdRzEW5hRxDbZWRrXydSYmot6lukP3W+IRzgyx0I
	 1vE3gIuC/9jujON+0CooH4zuC2OSGh2I6sMrWnJroyro7qvO0HSyya4gJIwEaixHb1
	 O5svdpx/kMUvILsphnrNMe/D8Zxd8aZAJ+t0xQhaNUcHBugKPgFxL4YJ7oKQ7Fke2A
	 NtB2edeP1lr7g==
Date: Wed, 06 Aug 2025 09:40:30 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, kernel@pengutronix.de, 
 devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-kernel@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
In-Reply-To: <20250806-stm32mp15-m_can-add-reset-v1-1-9d81f9c29d65@pengutronix.de>
References: <20250806-stm32mp15-m_can-add-reset-v1-1-9d81f9c29d65@pengutronix.de>
Message-Id: <175449112394.639563.13302025438302529927.robh@kernel.org>
Subject: Re: [PATCH] ARM: dts: stm32: add resets property to m_can nodes in
 the stm32mp153


On Wed, 06 Aug 2025 10:59:12 +0200, Marc Kleine-Budde wrote:
> On the STM32MP153 the m_cam IP cores (a.k.a. FDCAN) have an external
> shared reset in the RCC. Add the reset to both m_can nodes.
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  arch/arm/boot/dts/st/stm32mp153.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
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
 Base: using specified base-commit 1a32f7427eb3d1248bc64cd745b93f88cc838933

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/st/' for 20250806-stm32mp15-m_can-add-reset-v1-1-9d81f9c29d65@pengutronix.de:

arch/arm/boot/dts/st/stm32mp157c-ev1.dtb: can@4400e000 (bosch,m_can): Unevaluated properties are not allowed ('resets' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/can/bosch,m_can.yaml#
arch/arm/boot/dts/st/stm32mp153c-lxa-tac-gen3.dtb: can@4400e000 (bosch,m_can): Unevaluated properties are not allowed ('resets' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/can/bosch,m_can.yaml#
arch/arm/boot/dts/st/stm32mp153c-lxa-tac-gen3.dtb: can@4400f000 (bosch,m_can): Unevaluated properties are not allowed ('resets' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/can/bosch,m_can.yaml#
arch/arm/boot/dts/st/stm32mp153c-lxa-fairytux2-gen2.dtb: can@4400e000 (bosch,m_can): Unevaluated properties are not allowed ('resets' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/can/bosch,m_can.yaml#
arch/arm/boot/dts/st/stm32mp157c-dhcom-picoitx.dtb: can@4400e000 (bosch,m_can): Unevaluated properties are not allowed ('resets' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/can/bosch,m_can.yaml#
arch/arm/boot/dts/st/stm32mp157c-dhcom-picoitx.dtb: can@4400f000 (bosch,m_can): Unevaluated properties are not allowed ('resets' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/can/bosch,m_can.yaml#
arch/arm/boot/dts/st/stm32mp157c-phycore-stm32mp1-3.dtb: can@4400f000 (bosch,m_can): Unevaluated properties are not allowed ('resets' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/can/bosch,m_can.yaml#
arch/arm/boot/dts/st/stm32mp157c-dhcom-pdk2.dtb: can@4400e000 (bosch,m_can): Unevaluated properties are not allowed ('resets' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/can/bosch,m_can.yaml#
arch/arm/boot/dts/st/stm32mp153c-dhcor-drc-compact.dtb: can@4400e000 (bosch,m_can): Unevaluated properties are not allowed ('resets' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/can/bosch,m_can.yaml#
arch/arm/boot/dts/st/stm32mp153c-lxa-fairytux2-gen1.dtb: can@4400e000 (bosch,m_can): Unevaluated properties are not allowed ('resets' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/can/bosch,m_can.yaml#
arch/arm/boot/dts/st/stm32mp153c-mecio1r1.dtb: can@4400e000 (bosch,m_can): Unevaluated properties are not allowed ('resets' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/can/bosch,m_can.yaml#
arch/arm/boot/dts/st/stm32mp153c-dhcom-drc02.dtb: can@4400e000 (bosch,m_can): Unevaluated properties are not allowed ('resets' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/can/bosch,m_can.yaml#
arch/arm/boot/dts/st/stm32mp153c-dhcom-drc02.dtb: can@4400f000 (bosch,m_can): Unevaluated properties are not allowed ('resets' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/can/bosch,m_can.yaml#
arch/arm/boot/dts/st/stm32mp157c-ultra-fly-sbc.dtb: can@4400f000 (bosch,m_can): Unevaluated properties are not allowed ('resets' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/can/bosch,m_can.yaml#
arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dtb: can@4400e000 (bosch,m_can): Unevaluated properties are not allowed ('resets' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/can/bosch,m_can.yaml#
arch/arm/boot/dts/st/stm32mp157c-lxa-tac-gen2.dtb: can@4400e000 (bosch,m_can): Unevaluated properties are not allowed ('resets' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/can/bosch,m_can.yaml#
arch/arm/boot/dts/st/stm32mp157c-lxa-tac-gen2.dtb: can@4400f000 (bosch,m_can): Unevaluated properties are not allowed ('resets' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/can/bosch,m_can.yaml#
arch/arm/boot/dts/st/stm32mp157c-lxa-tac-gen1.dtb: can@4400e000 (bosch,m_can): Unevaluated properties are not allowed ('resets' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/can/bosch,m_can.yaml#
arch/arm/boot/dts/st/stm32mp157c-lxa-tac-gen1.dtb: can@4400f000 (bosch,m_can): Unevaluated properties are not allowed ('resets' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/can/bosch,m_can.yaml#
arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dtb: can@4400e000 (bosch,m_can): Unevaluated properties are not allowed ('resets' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/can/bosch,m_can.yaml#







Return-Path: <linux-kernel+bounces-771463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B78B287A2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 690C7AE5B4E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBBC2C08A8;
	Fri, 15 Aug 2025 21:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H86O9bnz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5085E2BE044;
	Fri, 15 Aug 2025 21:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755292752; cv=none; b=aJ6VbK3d95AQnSzv5efoLi3qm10V69ZnmAU6XhEw//PwcycimVAu37IgjZElsrouSjpW7lx+qbJo+xTvLx6I0pfIh/eSwy49zYfYNZGKWY81U3HeKX/HDUFbGGLURuuXwotlGI9XIl2Kt94TXqKoPhlEisE8WIsGVtFECgPC/Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755292752; c=relaxed/simple;
	bh=cJhl0OslGGxuBTiQrTRj+9aBCfXCW2Jm4WVhzEwl87Y=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=baKNowSYc2OdxN5tt6GFFgbTEcpHaRLpe0RFfyXuJtSW7V7I0/i9+03K+wLQcBL+mob47D3p8/x8gFTzKK8C3ssSoYb72hyboAZivxegl13HQ7aS8d39Kz423/Ez3rV8YGfyyuH246XiF6WP4vDaZX83qOpTxEAlQ2AeI9SRoDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H86O9bnz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B913CC4CEF8;
	Fri, 15 Aug 2025 21:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755292751;
	bh=cJhl0OslGGxuBTiQrTRj+9aBCfXCW2Jm4WVhzEwl87Y=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=H86O9bnz9X1b8H1xu/xBQtEiPymWyHyurxwQ884fE4MynR5nygyGrARiRtqulgDrM
	 4oz5B2gxZsExmYQYX/T4LcpD1h7Y8lFeTqLG9ofIcy8k6lmuuFpJc5tZfM60f3bxZ1
	 RufZaGvs9OfPz4z8Dm6Zp/y7cTI+RpIe7lM1evnwvhMYSMh8MGNmVQTKUmeaBSE14m
	 dlTfAtjLgbtH5S2pHCgKz7b5QhhtOHTPc5Gu7SPNocR8d+/LbREeeQP2jorVB1vu6G
	 b34hE7GpoD7V/kIaRl8rgy6UAsEgy/++Yr96cyrWb4IRG1dd2R48GXWBsHYprCrvQ+
	 vdLN2LNqTzoow==
Date: Fri, 15 Aug 2025 16:19:11 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: imx@lists.linux.dev, Fabio Estevam <festevam@gmail.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Shawn Guo <shawnguo@kernel.org>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Csaba Buday <buday.csaba@prolan.hu>, linux-arm-kernel@lists.infradead.org
To: =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
In-Reply-To: <20250815-b4-tx6ul-dt-phy-rst-v1-1-9b65e315d9d3@prolan.hu>
References: <20250815-b4-tx6ul-dt-phy-rst-v1-1-9b65e315d9d3@prolan.hu>
Message-Id: <175529260064.3212410.10009645356875369525.robh@kernel.org>
Subject: Re: [PATCH] ARM: dts: imx6ul-tx6ul: Switch away from deprecated
 `phy-reset-gpios`


On Fri, 15 Aug 2025 17:17:37 +0200, Bence Csókás wrote:
> The Ethernet PHY's reset GPIO should be specified in the node of the PHY
> itself, instead of the MAC (`fec`). The latter is deprecated, and was an
> i.MX-specific extension, incompatible with the new reset controller
> subsystem.
> 
> Co-developed-by: Csaba Buday <buday.csaba@prolan.hu>
> Signed-off-by: Csaba Buday <buday.csaba@prolan.hu>
> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
> ---
>  arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
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
 Base: using specified base-commit 0cc53520e68bea7fb80fdc6bdf8d226d1b6a98d9

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/nxp/' for 20250815-b4-tx6ul-dt-phy-rst-v1-1-9b65e315d9d3@prolan.hu:

arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul-0011.dtb: / (karo,imx6ul-tx6ul): i2c-gpio: {'compatible': ['i2c-gpio'], '#address-cells': 1, '#size-cells': 0, 'pinctrl-names': ['default'], 'pinctrl-0': [[69]], 'sda-gpios': [[48, 1, 0]], 'scl-gpios': [[48, 0, 0]], 'clock-frequency': 400000, 'status': ['okay'], 'rtc@68': {'compatible': ['dallas,ds1339'], 'reg': [[104]], 'status': ['disabled']}} is not of type 'array'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml#
arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul-0010.dtb: / (karo,imx6ul-tx6ul): i2c-gpio: {'compatible': ['i2c-gpio'], '#address-cells': 1, '#size-cells': 0, 'pinctrl-names': ['default'], 'pinctrl-0': [[68]], 'sda-gpios': [[48, 1, 0]], 'scl-gpios': [[48, 0, 0]], 'clock-frequency': 400000, 'status': ['okay'], 'rtc@68': {'compatible': ['dallas,ds1339'], 'reg': [[104]], 'status': ['disabled']}} is not of type 'array'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml#
arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul-0011.dtb: ethernet-phy@0 (ethernet-phy-ieee802.3-c22): 'resets' is a dependency of 'reset-names'
	from schema $id: http://devicetree.org/schemas/reset/reset.yaml#
arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul-0010.dtb: ethernet-phy@0 (ethernet-phy-ieee802.3-c22): 'resets' is a dependency of 'reset-names'
	from schema $id: http://devicetree.org/schemas/reset/reset.yaml#







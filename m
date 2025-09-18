Return-Path: <linux-kernel+bounces-823036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74646B855A2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B583AA2F2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38F530C0FA;
	Thu, 18 Sep 2025 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knajWF5j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B802D322C;
	Thu, 18 Sep 2025 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207018; cv=none; b=Tooh0DRTDbpHP15v2nPS7lqo9jwiu0I6lCR9E8bvXhFCYo9mNs1f1d/25C9t1iaqAjiYxCHU0WJ0i364JC4PkstF7z3AEnU7w+nn4Lc8zSxvxNCeKlcpWjXBL4BbhUBU+6zK4U9Gi3tAoDS9zruP1XQf9+UGIj7h0XPpiha6MEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207018; c=relaxed/simple;
	bh=dFFUTKsb5HmnpUVQ50VCJETlKPYAb86qPFm7HVjesZM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=IrUZ4PV1qGKP7ci5WKO9BlgNrEukMGfx/fVpf0IYmNpq+Bm8NPsWh63OJKg22DdKCRBe6NflNWTssQi0xA02i9KYytz5LK1qVY2PTGpXH0g/UOvkykJGDDDQUbcxPfAB0M7wm82ndNBw0OLfYbURIYR0S6C2vny+yoV8Mg1Vog4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knajWF5j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE42C4CEEB;
	Thu, 18 Sep 2025 14:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758207017;
	bh=dFFUTKsb5HmnpUVQ50VCJETlKPYAb86qPFm7HVjesZM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=knajWF5j1gTQ1MVKy8Gzhy257IxELviuKIwoockJVZbRYuzCOEdkHbpwCfEVytJvV
	 2InH+G5SioxlDQfSa7qqJadKvOtOApdmWqwff/Wj0TYA2OCUtDLZe9zOSlTbTHl+ou
	 YOKZi6cyOhZFOJsC7kanejGBQ5xJNg4Z5ZQ+bLtBKwRJ2ykWUUyHaU5r3njiFNhpLE
	 6Yx0/sCxMTo0bO7iqkzG8Z5P04ppv2lq/JSKQFn+QjSepki2frcL7lqJnszqLkEA4Z
	 T9I3NPNlXKpQfna1pxUw6uazMYgamdsuka2h3J7IbO4wfI29M2+hHNt32NJ4+DRYPc
	 /gWXGw4RLakPw==
Date: Thu, 18 Sep 2025 09:50:16 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org, 
 krzk+dt@kernel.org, alexandre.belloni@bootlin.com, 
 devicetree@vger.kernel.org, balamanikandan.gunasundar@microchip.com, 
 conor+dt@kernel.org, Frank.Li@nxp.com, nicolas.ferre@microchip.com
To: Durai Manickam KR <durai.manickamkr@microchip.com>
In-Reply-To: <20250918095429.232710-1-durai.manickamkr@microchip.com>
References: <20250918095429.232710-1-durai.manickamkr@microchip.com>
Message-Id: <175820686358.1653800.8373809331040324947.robh@kernel.org>
Subject: Re: [PATCH 0/4] Add microchip sama7d65 SoC I3C support


On Thu, 18 Sep 2025 15:24:25 +0530, Durai Manickam KR wrote:
> Add support for microchip sama7d65 SoC I3C master only IP which is based on
> mipi-i3c-hci from synopsys implementing version 1.0 specification. The platform
> specific changes are integrated in the existing mipi-i3c-hci driver by introducing
> a quirk and SoC specific config option.
> 
> I3C in master mode supports up to 12.5MHz, SDR mode data transfer in
> mixed bus mode (I2C and I3C target devices on same i3c bus).
> 
> Testing done:
> With this patch we are able to fully configure the lsm6dso I3C slave
> device. Unlike I2C, I hope there is no linux utility to check the
> various transactions supported in the host controller. These features
> will be tested later probably with I3C analyser KIT.
> 
> Durai Manickam KR (4):
>   clk: at91: sama7d65: add peripheral clock for I3C
>   i3c: mipi-i3c-hci: add microchip sama7d65 SoC
>   ARM: configs: at91: sama7: add sama7d65 i3c-hci
>   ARM: dts: microchip: add I3C controller
> 
>  arch/arm/boot/dts/microchip/sama7d65.dtsi     | 12 ++++++
>  arch/arm/configs/sama7_defconfig              |  2 +
>  drivers/clk/at91/sama7d65.c                   |  5 ++-
>  drivers/i3c/master/mipi-i3c-hci/Makefile      |  3 +-
>  drivers/i3c/master/mipi-i3c-hci/core.c        | 28 ++++++++++++
>  drivers/i3c/master/mipi-i3c-hci/hci.h         | 12 ++++++
>  .../i3c/master/mipi-i3c-hci/hci_quirks_mchp.c | 43 +++++++++++++++++++
>  7 files changed, 102 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/i3c/master/mipi-i3c-hci/hci_quirks_mchp.c
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
 Base: tags/v6.17-rc1-3-g0b9dcd02ea93 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/microchip/' for 20250918095429.232710-1-durai.manickamkr@microchip.com:

arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: /soc/i3c@e9000000: failed to match any schema with compatible: ['mchp,sama7d65-i3c-hci']







Return-Path: <linux-kernel+bounces-834375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD75BA4916
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88C7F16F407
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF7523BF9B;
	Fri, 26 Sep 2025 16:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdUSHO3h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F353623A99E;
	Fri, 26 Sep 2025 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758903107; cv=none; b=ovdqTBn/XIH+sO3jNfML2SJUZlx/+DJa0yk/hY25Setro6M7kHkNMw9j5hLxV+dq9RcENz/mbz7f6ds7t53FSUgEubNnPFFXbRBXgVnuZ6pQ38oZpZwDst/7AZx7KFqGX1lDaMQEvr5w1LL9mPN2DJDap+bkK1zC2IxkrL3Potg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758903107; c=relaxed/simple;
	bh=yRHrfjskk6KyPsMbNFVbtbGAg1RRUPZQnBS9srhXpvg=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=og89bX2kUIdsd+DFPdFEN5zrBOr3fKnxcrYUNpLDhvCnGTCzeBZE5g3yfNJE+71Z/jAjrXQVFbGiWPmW+0G7ajWG9kGAqZPB550lvJN7TUJ3KfrTatU6MKriJyBTU/dpWQtmOMxI8MNU945ioA0b03zy6woA//DBXCBWlRr/zYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdUSHO3h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2F4C4CEF4;
	Fri, 26 Sep 2025 16:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758903106;
	bh=yRHrfjskk6KyPsMbNFVbtbGAg1RRUPZQnBS9srhXpvg=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=EdUSHO3h2a1RJKHf8MMj7mPZcuufCtSoAaLqH8n0krh49mmpFo4x3CqD8QcbzYVj5
	 ZR+73ePW3C31DpO4Lu/xArmPcf2KRsXmsEQnZqzyEiSTpjWv4hUwdvN/AdSHdYSLF1
	 2S3xaQI6oRCF9x1Ul9O4qDwctXnVHjKowqnCBd1MO1PLF90gzXKNlhfRON8ZrQG6OU
	 yRHXisWEHUaZuxDi7xR+pnwqK4OsJHu892QvmsbmRrGOyLtasAqSDK04u/imiOeqai
	 yFgB8FafVjCxfc4X11D26y6/4YYCj+P8guoTtHlvKkgwkVnVGZctb34mQhxreiLhqM
	 kilQd5CrClt8g==
Date: Fri, 26 Sep 2025 11:11:39 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 venture@google.com, yuenn@google.com, openbmc@lists.ozlabs.org, 
 benjaminfair@google.com, joel@jms.id.au, krzk+dt@kernel.org, 
 tali.perry1@gmail.com, conor+dt@kernel.org, avifishman70@gmail.com
To: Tomer Maimon <tmaimon77@gmail.com>
In-Reply-To: <20250925200625.573902-1-tmaimon77@gmail.com>
References: <20250925200625.573902-1-tmaimon77@gmail.com>
Message-Id: <175890301752.880349.2331946518360447485.robh@kernel.org>
Subject: Re: [PATCH v3 0/3] arm64: dts: nuvoton: add NPCM845 SoC and EVB
 support


On Thu, 25 Sep 2025 23:06:22 +0300, Tomer Maimon wrote:
> This series fix warnings and adds device tree support for peripherals on
> the Nuvoton NPCM845 SoC and its Evaluation Board (EVB).
> The first patch fix warning and arrange node order.
> The second patch introduces peripheral nodes for Ethernet, MMC, SPI, USB,
> RNG, ADC, PWM-FAN, I2C, and OP-TEE firmware in the NPCM845 SoC device tree.
> The third patch enables these peripherals for the NPCM845-EVB, adding
> MDIO nodes, reserved memory, aliases, and board-specific configurations
> like PHY modes and SPI flash partitions.
> 
> The NPCM8XX device tree tested on NPCM845 evaluation board.
> 
> Addressed comments from:
> 	- Andrew Jeffery: https://patchwork.ozlabs.org/project/openbmc/patch/20250908125938.3584927-2-tmaimon77@gmail.com/
> 					  https://patchwork.ozlabs.org/project/openbmc/patch/20250908125938.3584927-3-tmaimon77@gmail.com/
> 
> Changes since version 2:
> 	- Fix dts warning
> 	- Arrange node order by ascending unit address.
> 
> Changes since version 1:
> 	- Fix commit message
> 	- Fix dtbs_check warnings.
> 
> Tomer Maimon (3):
>   arm64: dts: nuvoton: fix warning and nodes order
>   arm64: dts: nuvoton: npcm845: Add peripheral nodes
>   arm64: dts: nuvoton: npcm845-evb: Add peripheral nodes
> 
>  .../dts/nuvoton/nuvoton-common-npcm8xx.dtsi   | 732 +++++++++++++++++-
>  .../boot/dts/nuvoton/nuvoton-npcm845-evb.dts  | 440 +++++++++++
>  .../boot/dts/nuvoton/nuvoton-npcm845.dtsi     |   7 +
>  3 files changed, 1160 insertions(+), 19 deletions(-)
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
 Base: remotes/arm-soc/for-next-12027-gf60eaa447dab (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/nuvoton/' for 20250925200625.573902-1-tmaimon77@gmail.com:

arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/spi@fb000000: failed to match any schema with compatible: ['nuvoton,npcm845-fiu']
arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/spi@fb002000: failed to match any schema with compatible: ['nuvoton,npcm845-fiu']
arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/spi@c0000000: failed to match any schema with compatible: ['nuvoton,npcm845-fiu']
arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/spi@fb001000: failed to match any schema with compatible: ['nuvoton,npcm845-fiu']
arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/bus@f0000000/i2c@86000/tmp100@48: failed to match any schema with compatible: ['tmp100']
arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/bus@f0000000/pwm-fan-controller@103000: failed to match any schema with compatible: ['nuvoton,npcm845-pwm-fan']
arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/bus@f0000000/spi@201000: failed to match any schema with compatible: ['nuvoton,npcm845-pspi']







Return-Path: <linux-kernel+bounces-770915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D392BB2805C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7FD35872B2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CD83019CD;
	Fri, 15 Aug 2025 13:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e72r1Zka"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4F83002DC;
	Fri, 15 Aug 2025 13:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755263317; cv=none; b=L6gAoMKoqh9pUhL541WlraipCkFMVlQyVbrixKVaHFzcR/xYpoJWPMtoFfwZ7UjYUFuANjUC5M9yC2YIA1FWykKAPJD4X9ZoZicXuXwmHD+qsuaHLF2Z08GIIJy4Amv2WVoHXYvINf4xLP3nM8WY/cGr6r4SAJhjHKrpyo14434=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755263317; c=relaxed/simple;
	bh=yEAbtItrMUSwsbmLsQ1h3fvOKuTppfxoHtOpTlKH+bI=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=AqKHlXVldrCiA2j77VRx679wOE8k++25ZmUCohM/jf+kddUXqDn/kXPMTefTSFiDX8FutngPDIpY1ZZ4t9tTk9gmJLqrt2InMmXscLcskD35qAm2jsoD/j1wt8zmc2ELvMQRutInTadis4gkXDl/TS1Cv8gfS5u8Ech0aTzdSfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e72r1Zka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFA0C4CEEB;
	Fri, 15 Aug 2025 13:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755263317;
	bh=yEAbtItrMUSwsbmLsQ1h3fvOKuTppfxoHtOpTlKH+bI=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=e72r1ZkayaRwLfQ+nLTuFAxrdiNLa1aZYngD9qJdth7uJwXI2YL3T0HQHERtnjNwf
	 DkibBkwfKU3X64RWniNTd3NOLSRuJW62YxTC9WMTBvXyAi60wj+Htnca+SoZoVTNLX
	 o8HtH+IhGZ+BzXRX4g2FSTwpZ/5QNV/Wfb6QDr6DRuW1//Wr9VLWbS3PsOh7s8N4Rb
	 +znL6gijlnoUW95qJyYHmmW+37WBUjC4oaAUZU/v1pV+TGzzral8EUK9ZauTtaV/ZA
	 xzoxYPjJh9iPbRrciypX3GYWERE9FJbwZxLAzwZ9jPXTw5JZAYAh4BUNk+/0t+i4Pw
	 ChyYHH4H0+kKQ==
Date: Fri, 15 Aug 2025 08:08:36 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, 
 Alex Elder <elder@riscstar.com>, Stephen Boyd <sboyd@kernel.org>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Alex Elder <elder@kernel.org>, ~postmarketos/upstreaming@lists.sr.ht, 
 Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Ray Jui <rjui@broadcom.com>, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
To: Artur Weber <aweber.kernel@gmail.com>
In-Reply-To: <20250813-kona-bus-clock-v6-0-f5a63d4920a4@gmail.com>
References: <20250813-kona-bus-clock-v6-0-f5a63d4920a4@gmail.com>
Message-Id: <175526317070.1748815.1341247491221597696.robh@kernel.org>
Subject: Re: [PATCH v6 0/9] clk: bcm: kona: Add bus clock support, bus
 clocks for BCM21664/BCM281xx


On Wed, 13 Aug 2025 13:00:06 +0200, Artur Weber wrote:
> This patchset does the following:
> 
> - Introduce support for bus clocks. These are fairly similar to
>   peripheral clocks, but only implement policy, gate and hyst.
> 
> - Add matching bus clocks for BCM21664 and BCM281xx peripheral clocks
>   and update device tree bindings to match.
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
> Changes in v6:
> - Rebase on v6.16
> - Make kona_bus_clk_ops const, add a new commit to make kona_peri_clk_ops const as well
> - Link to v5: https://lore.kernel.org/r/20250430-kona-bus-clock-v5-0-46766b28b93a@gmail.com/
> 
> Changes in v5:
> - Pick up Reviewed-by trailer from Krzysztof on patch 3
> - Rebase on v6.14
> - No code changes since v4
> - Link to v4: https://lore.kernel.org/r/20250318-kona-bus-clock-v4-0-f54416e8328f@gmail.com
> 
> Changes in v4:
> - Rename moved CLOCK_COUNT defines to CLK_COUNT to avoid redefinition
> - Squash BCM21664/BCM281xx bus clock DT bindings commits together
> - Link to v3: https://lore.kernel.org/r/20250308-kona-bus-clock-v3-0-d6fb5bfc3b67@gmail.com
> 
> Changes in v3:
> - Fix DT schema example in BCM281xx bus clock bindings
> - Move CLOCK_COUNT defines from dt-bindings header to the driver
> - Fix BCM21664 UARTBx_APB IDs being out of order compared to clock
>   driver
> - Link to v2: https://lore.kernel.org/r/20250303-kona-bus-clock-v2-0-a363c6a6b798@gmail.com
> 
> Changes in v2:
> - Drop prerequisite clock patch
> - Move clock/bcm21664.h dt-bindings header change to dt-bindings patch
> - Add BCM281xx bus clocks
> - Link to v1: https://lore.kernel.org/r/20250216-kona-bus-clock-v1-0-e8779d77a6f2@gmail.com
> 
> ---
> Artur Weber (9):
>       clk: bcm: kona: Move CLOCK_COUNT defines into the driver
>       dt-bindings: clock: brcm,kona-ccu: Drop CLOCK_COUNT defines from DT headers
>       dt-bindings: clock: brcm,kona-ccu: Add BCM21664 and BCM281xx bus clocks
>       clk: bcm: kona: Make kona_peri_clk_ops const
>       clk: bcm: kona: Add support for bus clocks
>       clk: bcm21664: Add corresponding bus clocks for peripheral clocks
>       clk: bcm281xx: Add corresponding bus clocks for peripheral clocks
>       ARM: dts: bcm2166x-common: Add matching bus clocks for peripheral clocks
>       ARM: dts: bcm11351: Add corresponding bus clocks for peripheral clocks
> 
>  .../devicetree/bindings/clock/brcm,kona-ccu.yaml   |  49 ++++++-
>  arch/arm/boot/dts/broadcom/bcm11351.dtsi           |  33 +++--
>  arch/arm/boot/dts/broadcom/bcm2166x-common.dtsi    |  28 ++--
>  drivers/clk/bcm/clk-bcm21664.c                     |  99 ++++++++++++++-
>  drivers/clk/bcm/clk-bcm281xx.c                     | 141 ++++++++++++++++++++-
>  drivers/clk/bcm/clk-kona-setup.c                   | 116 +++++++++++++++++
>  drivers/clk/bcm/clk-kona.c                         |  64 +++++++++-
>  drivers/clk/bcm/clk-kona.h                         |  14 +-
>  include/dt-bindings/clock/bcm21664.h               |  17 ++-
>  include/dt-bindings/clock/bcm281xx.h               |  24 +++-
>  10 files changed, 540 insertions(+), 45 deletions(-)
> ---
> base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
> change-id: 20250212-kona-bus-clock-4297eefae940
> 
> Best regards,
> --
> Artur Weber <aweber.kernel@gmail.com>
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
 Base: using specified base-commit 038d61fd642278bab63ee8ef722c50d10ab01e8f

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/broadcom/' for 20250813-kona-bus-clock-v6-0-f5a63d4920a4@gmail.com:

arch/arm/boot/dts/broadcom/bcm94709.dtb: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']







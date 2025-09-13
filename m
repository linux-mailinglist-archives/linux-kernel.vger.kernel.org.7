Return-Path: <linux-kernel+bounces-815052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BF6B55EB4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 07:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 194FC1C871FC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 05:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF20B2E2F1F;
	Sat, 13 Sep 2025 05:55:35 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7173B2E2DD8;
	Sat, 13 Sep 2025 05:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757742935; cv=none; b=caGFun8RVS/5O3KrFPE0XHnEuQvSA5ig8qJkneNtr1hdZujRw2ekL28+uUOmfoiuH8OwDdA1Ltd8xVYd9tIA0mn3ZkkMiwV57CaI6loh3ueZnZljuWGv2Bv6UXR3V7cjoG61mXC+K1IzaNCOC0MF5e8FquFDvYnfz4DQSrQtTms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757742935; c=relaxed/simple;
	bh=DQfsESmj7Ce6z0+PXfSGkMPULcTYQxPru4tBSh4sXiA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WKo5BsYPsv7lVXv+LwV1xFW6Mg0AXjdWPXFq4Q/4B0aR6g+GTDnOTE314No0aMa6CiX74wUgC8P7sgoXju9vjy19jxK33bQkw+aMdKE5ptVSpYLqIciDU6rWW+oTLZpkT/+iH+jJH1X+Wd3XG+FIQu0Omoag2LTrN24rYOahu+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4F9C4CEEB;
	Sat, 13 Sep 2025 05:55:34 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id F1B455FBEB;
	Sat, 13 Sep 2025 13:55:31 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Stephen Boyd <sboyd@kernel.org>, Jernej Skrabec <jernej@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>, linux-sunxi@lists.linux.dev, 
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250911174710.3149589-1-wens@kernel.org>
References: <20250911174710.3149589-1-wens@kernel.org>
Subject: Re: [PATCH v2 0/7] arm64: allwinner: a523: Enable MCU PRCM and NPU
Message-Id: <175774293191.3795761.5114630927586047824.b4-ty@csie.org>
Date: Sat, 13 Sep 2025 13:55:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 12 Sep 2025 01:47:03 +0800, Chen-Yu Tsai wrote:
> This is v2 of my A523 MCU PRCM and NPU support series.
> 
> Changes since v1:
> - Dropped dual divider clock rate read-back fix that is already merged
> - DT binding
>   - Moved "r-ahb" clock to the end of the list and added "r-apb0" clock
> - Add NPU clk
>   - Move .num to after list of clks
> - MCU CCU clk driver
>   - Added comment for "fixed" dividers in audio PLL clock
>   - Corrected variable names for audio PLL divider clocks
>   - Added comment for the reversed order of some of the DSP clock's
>     parents when compared to the manual
>   - Added comments for clocks and resets only found in the BSP driver
>   - Corrected register offset for i2s3-asrc and bus-mcu-pwm0 clocks
>   - Made "r-ahb" and new "r-apb0" external bus clocks the parents of the
>     bus gate clocks, with comments if guessed which one applies
>   - Moved .num_clks to after the list of clocks, making it obvious that
>     the value needs to be added if more clocks are added to the list
> - MCU CCU DT node
>   - Enlarged MCU PRCM register range to 0x200
>   - Moved "r-ahb" clock to the end of the list and added "r-apb0" clock
> - Link to v1
>   https://lore.kernel.org/all/20250830170901.1996227-1-wens@kernel.org/
> 
> [...]

Applied to sunxi/shared-dt-headers-for-6.18 in local tree, thanks!

[1/7] dt-bindings: clock: sun55i-a523-ccu: Add missing NPU module clock
      commit: e9671ddd82eee96146a7359431a4e1f04ac2b076
[2/7] dt-bindings: clock: sun55i-a523-ccu: Add A523 MCU CCU clock controller
      commit: 0f610e650d4e979490ccfa4c22ca29ca547f41e7
[3/7] clk: sunxi-ng: sun55i-a523-ccu: Add missing NPU module clock
      (no commit info)
[4/7] clk: sunxi-ng: div: support power-of-two dividers
      (no commit info)
[5/7] clk: sunxi-ng: add support for the A523/T527 MCU CCU
      (no commit info)
[6/7] arm64: dts: allwinner: a523: Add MCU PRCM CCU node
      (no commit info)
[7/7] arm64: dts: allwinner: a523: Add NPU device node
      (no commit info)

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>



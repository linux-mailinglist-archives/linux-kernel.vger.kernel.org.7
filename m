Return-Path: <linux-kernel+bounces-815062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97394B55EE3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 08:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C87AF3B3784
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 06:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043762E7194;
	Sat, 13 Sep 2025 06:16:17 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D03F1CEAC2;
	Sat, 13 Sep 2025 06:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757744176; cv=none; b=RbziXZmyJqJdV1UprVuXiOZZCQmbowcRXbXxr6riMvC3NCirGaZtyWhWtdA0Vscmx06M3qVmFTbW936V0BabiUZU0Sq7TmLb1k3+Lh4i5xG2RvxDSxW3eTB4lxz63Mu6/sr3/q0tFNyCB1sjhUsfTknWqf+KDmmL3UweZVomV0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757744176; c=relaxed/simple;
	bh=rYv4Fr76t3a44M/s2LvUW75/HndXzjF+VNPnxzZh54s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j3Xl8ReqnmEvuCkq/JOR62Ryj+mnKEPYyxiK9+ekTXnsaC9zxYC2gfJwO2NCieCoBPtuqT73f0foI+fAmI/ngRZxnjaDP9Q8A1/bBCDXVxWhaGx1FBxcOShf5D5CFgxaMB33bTifMKkYsbHkqiWBwaSYkujd99mO5N5XpGO9xd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE707C4CEEB;
	Sat, 13 Sep 2025 06:16:14 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 344A95FBD7;
	Sat, 13 Sep 2025 14:16:12 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Stephen Boyd <sboyd@kernel.org>, Jernej Skrabec <jernej@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>, linux-sunxi@lists.linux.dev, 
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250911174710.3149589-1-wens@kernel.org>
References: <20250911174710.3149589-1-wens@kernel.org>
Subject: Re: (subset) [PATCH v2 0/7] arm64: allwinner: a523: Enable MCU
 PRCM and NPU
Message-Id: <175774417218.3827849.2965288836170499623.b4-ty@csie.org>
Date: Sat, 13 Sep 2025 14:16:12 +0800
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
> From: Chen-Yu Tsai <wens@csie.org>
> 
> Hi folks,
> 
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

Applied to sunxi/dt-for-6.18 in local tree, thanks!

[6/7] arm64: dts: allwinner: a523: Add MCU PRCM CCU node
      commit: edd63e54e516b54c0b7071463d6e839445efab68
[7/7] arm64: dts: allwinner: a523: Add NPU device node
      commit: a1845487afd06899502714a3500b60f815d98203

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>



Return-Path: <linux-kernel+bounces-722786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6D0AFDEC6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 06:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9640B4E2226
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 04:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA450265CB2;
	Wed,  9 Jul 2025 04:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="NvazntVA"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FB929D05;
	Wed,  9 Jul 2025 04:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752035152; cv=none; b=WHcJdL/L7drwOPzbgx/05oGAUuZYml4QW2sIXc3P7Xeunhaarzydu1Lh1zxYSlbkyQkNkWo6bRdwrA5MBCKwf3GOrKM7m0+Sij4WLv2Lp/zDmrTEVLPWQkkz6FwSlnGcNRpSVWta/01We/BwdlzNZBYMj1wuCTvpUAiX0RbAyJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752035152; c=relaxed/simple;
	bh=vhsZhBP/tmhB80J/KvDuaVinV3BhipYVeRoM5brC1XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eArZx6LteY+Qp9xyjVJO7roL9bv5s1mpzqvrp+6LUjpHVslJ2A8IpbDv32K0+13/DYX2CxTJtYjX8aEWCt2o0DidQBcmdKOXQKgPkj7PlFyIZn/a1pNzXqdv6ZAM+hw5vx63ZQU2t/WZKSVV5OerCSVYd1xRhf4ot1BrNSWnQco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=NvazntVA; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 03C1925D92;
	Wed,  9 Jul 2025 06:25:48 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id afcibFT-X543; Wed,  9 Jul 2025 06:25:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1752035147; bh=vhsZhBP/tmhB80J/KvDuaVinV3BhipYVeRoM5brC1XA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NvazntVAYt6ECuXArhY1cgQLkbCkUChinemwdo0ScEVv3S8BbGALGgD9rms54tl6v
	 BKaMQylL5IK9vcxr8Zi4jEVIX7Mst79bsoX32y8CL9OsJgHUvqG43cJX/1VOf5KvvI
	 SvDXjx8j0ONvmS8xtmaq1rfG/r6VlgJ3JARCS5jzTMIR3Y54wlItggk0Ko300U5KJ4
	 PBHJ1VFmuOaJliCSwLBAo/Yerq1fsS2w9YwqyOeu7yVhw7197FTfTnTpXQBORCCVBk
	 aTIESJ4bAGEwmTHOzPoJ/NHFrZmoS4wz56onKe38T0/ZIcHsARUbwXrQsSzBkXepYP
	 xEhnce5QYdSnA==
Date: Wed, 9 Jul 2025 04:25:34 +0000
From: Yao Zi <ziyao@disroot.org>
To: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Chukun Pan <amadeus@jmu.edu.cn>, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] arm64: dts: rockchip: Add Radxa ROCK 2A/2F
Message-ID: <aG3vPsUd-FPkhi-S@pie.lan>
References: <20250708224921.2254116-1-jonas@kwiboo.se>
 <20250708224921.2254116-3-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708224921.2254116-3-jonas@kwiboo.se>

On Tue, Jul 08, 2025 at 10:48:52PM +0000, Jonas Karlman wrote:
> The ROCK 2A and ROCK 2F is a high-performance single board computer
> developed by Radxa, based on the Rockchip RK3528A SoC.
> 
> Add initial device tree for the Radxa ROCK 2A and ROCK 2F boards.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> Schematics:
> - https://dl.radxa.com/rock2/2a/v1.2/radxa_rock_2a_v1.2_schematic.pdf
> - https://dl.radxa.com/rock2/2f/radxa_rock2f_v1.01_schematic.pdf
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   2 +
>  .../boot/dts/rockchip/rk3528-rock-2.dtsi      | 292 ++++++++++++++++++
>  .../boot/dts/rockchip/rk3528-rock-2a.dts      |  82 +++++
>  .../boot/dts/rockchip/rk3528-rock-2f.dts      |  10 +
>  4 files changed, 386 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2a.dts
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2f.dts
 
While testing the patch on my Rock 2A board, I noticed one of my SDcard
that works perfectly on Radxa E20C and NanoPi Zero 2 cannot be correctly
read out under UHS-125-SDR mode,

	# dd if=/dev/mmcblk1 of=/dev/null bs=4M count=4
	[   18.616828] mmc_host mmc1: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
	[   19.193315] mmc1: Skipping voltage switch
	[   19.202046] mmc1: tried to HW reset card, got error -110
	[   19.213312] mmcblk1: recovery failed!
	[   19.213709] I/O error, dev mmcblk1, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 256 prio class 0
	[   19.225201] mmcblk1: recovery failed!
	[   19.225530] I/O error, dev mmcblk1, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
	[   19.226283] Buffer I/O error on dev mmcblk1, logical block 0, async page read
	dd: /dev/mmcblk1: I/O error

which could be reproduced stably.

the SDMMC controller issued interesting messages during the tuning
process,

	[    0.665246] mmc_host mmc1: Bus speed (slot 0) = 148500000Hz (slot req 150000000Hz, actual 148500000HZ div = 0)
	[    0.851940] dwmmc_rockchip ffc30000.mmc: All phases work, using default phase 90.

but actually it doesn't work with phase = 90. If the frequency is
limited to 100MHz with max-frequency = <100000000> instead of the
default 150MHz, tuning results in a very different phase,

	[    0.665483] mmc_host mmc1: Bus speed (slot 0) = 99600000Hz (slot req 100000000Hz, actual 99600000HZ div = 0)
	[    1.166340] dwmmc_rockchip ffc30000.mmc: Successfully tuned phase to 141

and the card works, too. If I set rockchip,default-sample-phase to 141
in devicetree, the card could work at full 150MHz as well.

I think there's something wrong with the tuning process, or the board's
design cannot always run reliably at 150MHz.

Could you reproduce similar failures on Radxa 2A? If so, it may be
necessary to lower the SDMMC's maximum frequency for the board.

Regards,
Yao Zi


Return-Path: <linux-kernel+bounces-729065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F36B03140
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 15:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 187F33A78F9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 13:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45D51DD88F;
	Sun, 13 Jul 2025 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="TgFdNYAU"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F64C2AD20;
	Sun, 13 Jul 2025 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752414409; cv=none; b=gQW4wmW1tXl3PsM9IU0Gj0NftPGL3RdYkdhV4fBpMS13/JW6jCbsgbgGPz8fLwoDAq1eV9lgcYOgZB4AGX88Y27d52f2Tu4yFof+7XoMLQog6QHY+L4gJZV+c858ktFcX9abU9eXBeobrZiztfQ5KAS1bnDgsQToR2ckaiCZ7h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752414409; c=relaxed/simple;
	bh=ipxl4zfw0YG+RKZ7tPVA6e20g09wAN/2FpTRmkI4s4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDw1iYTBXSkK0NStah+WMTCxKaVzPVFJf9X1pXnrBh+Ph4hAaodZWeiO1MD+Ya61Dwk0vJ8iEn43/SgYl5Wz7zDfgo2bW8HvWwPp3fGrzMdnxLS98NDLbNTYc390jGcXp2Ea2C5GOOPakpzKVJQWWxMBje5mMWZdI/d0MeQlrqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=TgFdNYAU; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id C04C722C21;
	Sun, 13 Jul 2025 15:39:19 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ifD--ucc6E1n; Sun, 13 Jul 2025 15:39:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1752413958; bh=ipxl4zfw0YG+RKZ7tPVA6e20g09wAN/2FpTRmkI4s4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TgFdNYAUHEcFBuxzTSDNUnNhncmZAe6GQlUQlfQY/42yHIuSGVm9hY236iFYe41ex
	 W4tcGSwc+o0NhGlHWGM/t9xUadlWPIw6gGXN7Kz0IVQzEen3AcYZwQyKNk4xxl2myR
	 8qNNsnHrDsujTZkuQ7jlOHSGgtN4fduFqwUs7eYOSnwgByCmg0ddEX4xM6DK/n5i4d
	 LSsL2cSb9G8D85nziJlJ5tr/c2ANeFekmb/9snyyy9V3ETCst5zwfutSmG2o2096DQ
	 sYpS0B5ZVESxWbeftkAgPrStWxtgAIv81DkA9Jaig0UdVw4qMRWs/7Sq4sDHHxPZ6m
	 fy1FKRDkrGgcA==
Date: Sun, 13 Jul 2025 13:39:06 +0000
From: Yao Zi <ziyao@disroot.org>
To: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Chukun Pan <amadeus@jmu.edu.cn>, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] arm64: dts: rockchip: Add Radxa ROCK 2A/2F
Message-ID: <aHO2-l7MuaouBNmw@pie.lan>
References: <20250712173805.584586-1-jonas@kwiboo.se>
 <20250712173805.584586-3-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250712173805.584586-3-jonas@kwiboo.se>

On Sat, Jul 12, 2025 at 05:37:44PM +0000, Jonas Karlman wrote:
> The ROCK 2A and ROCK 2F is a high-performance single board computer
> developed by Radxa, based on the Rockchip RK3528A SoC.
> 
> Add initial device tree for the Radxa ROCK 2A and ROCK 2F boards.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Tested on my Radxa 2A board, the SD card could be read out at 45MB/s,
the GbE port reaches 942Mbps with iperf, and the EEPROM could be read
out correctly. I also saw the heartbeat LED blinking,

Tested-by: Yao Zi <ziyao@disroot.org>

> ---
> v3: Rename led nodes to led-0/led-1 (Chukun Pan)
> v2: Limit sdmmc max-frequency to 100 MHz (Yao Zi)
> 
> Schematics:
> - https://dl.radxa.com/rock2/2a/v1.2/radxa_rock_2a_v1.2_schematic.pdf
> - https://dl.radxa.com/rock2/2f/radxa_rock2f_v1.01_schematic.pdf
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   2 +
>  .../boot/dts/rockchip/rk3528-rock-2.dtsi      | 293 ++++++++++++++++++
>  .../boot/dts/rockchip/rk3528-rock-2a.dts      |  82 +++++
>  .../boot/dts/rockchip/rk3528-rock-2f.dts      |  10 +
>  4 files changed, 387 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2a.dts
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2f.dts


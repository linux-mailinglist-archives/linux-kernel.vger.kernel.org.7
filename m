Return-Path: <linux-kernel+bounces-725507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4730DB00001
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53CA21C87491
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902362E6D3D;
	Thu, 10 Jul 2025 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="sRuyTAuP"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565232E62C7;
	Thu, 10 Jul 2025 11:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752145305; cv=none; b=l8AqUtAVsbI8m/Mxwrs09mZYgmJX9hDyger9sAEGigCnzidnhwFhWcutebwEQ5BXk9IDxtwV/KO3gAJMGzoJLYq+UbGbbcKtwStU5j1g0KNJZ2N/zBjfl8fbb+JPo8C3YgR3TkCssZcOhlHogS8172Jg56jMj0rsRgiI3lG7Tfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752145305; c=relaxed/simple;
	bh=m3ih0CKiEAmyDyYGH55IGo3CEY7fXZGPt1nZbslEC8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OivHIz5nGdnaBAke50Wp1CeVEXCMH5Mh+EINyXdrcb07hT7G11x2r+JScAIxgMmLJVKltaS04zGLZOWT70IZO2wn3Ahypw/NvDi7G172UtmtNA+1desKqSbqeC/BWfbk5AigEKXXPm+JGIsJ4q6ey+NAvllltbKyGt6zqWr11KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=sRuyTAuP; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=h4qxOMkafipReLLQY48E2N29Bf543EIeVzEu7seHDok=; b=sRuyTAuP2+HBiTZ3U6hYz4/iEE
	+5iW1A76Q2fbx79u9N5t2SHaCcnERTj1epE6ohrcGqip/qMTV8R3nXifRpte8gDznit2ubRWEDylZ
	6FsbEP6IwKRlmc872peyToR5B4F7UC4N6g5YJBZZFTslgEvgIstu5rC1OE9Sdlw3jIjBWU8IWVLJL
	4vANeGIhfXKuwE+O+sLjPaenX8bI5TwIk66pVGatiVk0Mm+IiTxVcV+kg8NJqjknf5OVVUU96u3sY
	rf2W1T2roJ9gCzlsKwwlyAwoXjXqt8oxCiplsxcSBYiVxsQN33qeTHj8yOUoM9n7WsCMFlHjDOql2
	vI0jJqzA==;
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uZp1z-0004He-RL; Thu, 10 Jul 2025 13:01:35 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: John Clark <inindev@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] Add FriendlyElec NanoPi M5 support for Rockchip RK3576
Date: Thu, 10 Jul 2025 13:01:31 +0200
Message-ID: <175214509878.1901332.11810732138496211392.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250628143229.74460-1-inindev@gmail.com>
References: <20250628143229.74460-1-inindev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 28 Jun 2025 10:32:27 -0400, John Clark wrote:
> This series adds device tree support for the FriendlyElec NanoPi M5 board,
> powered by the Rockchip RK3576 SoC (4x Cortex-A72, 4x Cortex-A53, Mali-G52
> MC3 GPU, 6 TOPS NPU). The patches enable basic booting and connectivity,
> including dual 1Gbps Ethernet, USB 3.2, microSD, M.2 PCIe NVMe, and HDMI.
> 
> Changes in v5:
>  - Addressed Jonas Karlman's feedback:
>    - Added mmc0 alias for SD card
>    - Updated regulator names to match schematic (e.g., vcc12v_dcin,
>        vcc5v0_sys_s5, vcc3v3_m2_keym, vcc3v3_sd_s0, usb3_port2_5v,
>        vcc5v0_usb_otg0, vcc5v_hdmi_tx)
>    - Fixed vcc3v3_sd_s0 voltage to 3.3V
>    - Removed unnecessary regulator-state-mem for fixed regulators
>    - Removed vcc_5v0_device regulator
>    - Added pinctrl for Ethernet PHY reset GPIOs in mdio0 and mdio1
>    - Used correct pinctrl format for sdmmc and sfc1 (<&pin>)
>    - Increased SPI flash frequency to 50 MHz
>    - Updated LED colors (sys: red, led1/led2: green) and functions
>        (LED_FUNCTION_HEARTBEAT, LED_FUNCTION_LAN)
>    - Dropped rng node (enabled by default)
>    - Omitted HDMI mode-switching GPIO (to be added later with driver
>        support)
>    - Updated pinctrl names to match schematic (e.g., pcie0_pwren_h,
>        sdmmc0_pwren_h, usb3_host_pwren_h, usb_otg0_pwren_h, hp_det_l,
>        pcie0_perstn)
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: rockchip: add FriendlyElec NanoPi M5 board
      commit: d15e51907ef472d31af0a4f735d4597b53dc379e
[2/2] arm64: dts: rockchip: Add FriendlyElec NanoPi M5 support
      commit: f2a71544d56bc8de459e1df9eecf616d141cd633

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>


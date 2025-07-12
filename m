Return-Path: <linux-kernel+bounces-728713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B49AB02C32
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 19:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965BC4E3918
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 17:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553A928B4EC;
	Sat, 12 Jul 2025 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="AY0bwSBL"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31AC28B3F6
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752341903; cv=none; b=K1M8yBLKRZrivIzBAZzTD6vDwNmg7EOfSP5iONabxT/tUwWCpmoA7pr6vV9gQgYE1xMZyXsIMtPUuMe2QidKENLWBeWZK+pfURAE/fFgMwdDnfhitDPHL/t1ro29wpPeBHEltikkw6Y0wLEuzy5K08CVhyArEyyxPajZJRYRI/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752341903; c=relaxed/simple;
	bh=8YjM/Euc7ejdZlHdkhZM/imfuuVzbjRYiCOyg+FR128=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VrEyjbrYkjJu/EjZTBg6diCrU5786kvwa6T4rRYbHqE+rsfEQQLyyrP9VdelZQhPSH3FNFexf3tSmu6r2+nQakfZPS8M4mfwc6zb0xJcvq8w+5eCQg20gElmdFkIWeqpqvYY5a7OB+6ScqzW4xnizN6fu/9TKyR+tZ3/FLNrjPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=AY0bwSBL; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1752341895;
 bh=TilQ8i0bxzGSbTWKnj6uJy6hAD8gixd/aU3B3kF+KTo=;
 b=AY0bwSBLo2oqL9fUx8l93RWEQayWcyOO8tp4iBdVo47iKrv5AEmLoIXCCE4GUBKV1et7Qu9Xl
 WDRSej02TRV8TzKmgN2VE9yBQAaAJADuM77iuzG+yjM536fwZS9tsM8BPmqXVpuga8pyQxq4WAD
 1/ioArkM7lZ0FW9JpWlgRU17FLjqAvaPRS/0C2LXDXMR/uallILx4X4hQLrjBYeQ0A60lkcj18h
 xMk/1Hz3NYv4D1NLec3D/7gVwcJN4u2YpxSZWbqMzC6CpRvgaY7nRnxR9AKn8CqNvFbsu6GTCSy
 dCflUbpbTpc9RAPxh0tjxDLvqTjGwNQ0i2YCsqqzrVTw==
X-Forward-Email-ID: 68729d83d7dd91652d16c15f
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 0/6] arm64: dts: rockchip: Add ROCK 2A/2F, Sige1 and NanoPi Zero2
Date: Sat, 12 Jul 2025 17:37:42 +0000
Message-ID: <20250712173805.584586-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds dt-bindings and initial device tree for the following
Rockchip RK3528A boards:
- Radxa ROCK 2A/2F
- ArmSoM Sige1
- FriendlyElec NanoPi Zero2

The bt/wifi_reg_on pins are described in the device tree using
rfkill-gpio nodes.

Changes in v3:
- Rename led nodes to led-0/led-1
- Remove pinctrl* props from sdio0
- Collect a-b tags

Changes in v2:
- Limit sdmmc max-frequency to 100 MHz on ROCK 2A/2F
- Drop clock-output-names prop from rtc node on Sige1 and NanoPi Zero2
- Drop regulator-boot-on from usb 2.0 host regulators on Sige1
- Add bluetooth and wifi nodes on Sige1
- Collect t-b tag for NanoPi Zero2

These boards can be booted from emmc or sd-card using the U-Boot 2025.07
generic-rk3528 target or work-in-progress patches for these boards [1].

For working bluetooth on ArmSoM Sige1 the patch "arm64: dts: rockchip:
Fix UART DMA support for RK3528" [2] is required.

[1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3528
[2] https://lore.kernel.org/r/20250709210831.3170458-1-jonas@kwiboo.se

Jonas Karlman (6):
  dt-bindings: arm: rockchip: Add Radxa ROCK 2A/2F
  arm64: dts: rockchip: Add Radxa ROCK 2A/2F
  dt-bindings: arm: rockchip: Add ArmSoM Sige1
  arm64: dts: rockchip: Add ArmSoM Sige1
  dt-bindings: arm: rockchip: Add FriendlyElec NanoPi Zero2
  arm64: dts: rockchip: Add FriendlyElec NanoPi Zero2

 .../devicetree/bindings/arm/rockchip.yaml     |  17 +
 arch/arm64/boot/dts/rockchip/Makefile         |   4 +
 .../boot/dts/rockchip/rk3528-armsom-sige1.dts | 465 ++++++++++++++++++
 .../boot/dts/rockchip/rk3528-nanopi-zero2.dts | 340 +++++++++++++
 .../boot/dts/rockchip/rk3528-rock-2.dtsi      | 293 +++++++++++
 .../boot/dts/rockchip/rk3528-rock-2a.dts      |  82 +++
 .../boot/dts/rockchip/rk3528-rock-2f.dts      |  10 +
 7 files changed, 1211 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-armsom-sige1.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-nanopi-zero2.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2a.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2f.dts

-- 
2.49.0



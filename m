Return-Path: <linux-kernel+bounces-747114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88417B12FEF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 16:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2BD1898853
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 14:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E5F21A928;
	Sun, 27 Jul 2025 14:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="gYXjzAoK"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FEB4501A
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 14:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753627469; cv=none; b=GiPZC6XYoChkJ8ShY8dlcXcHMmRjC6wg/7Gz0H1U35zY7zzTDnEfDHElYi5gLdV8MwwaZiik+4XcC1djw45Uk5RHNmyuKFk7BBWE6fIMM7jnmcSI0BpQSgoIVtUnmIocG7H1cIoL5fgVtRYTqE2j4e3Gw5kFjSTRMHbGOaHIAXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753627469; c=relaxed/simple;
	bh=a0B/4uSRdzhCzLFxrVT8cPm1OPlAzhlHYbbmb/yMZg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AFts3JPIbELU5vwQO50blT8ie99DBcByePbrhfR23MTQctOaed9UdmAPCgdIHicIU8NbJ4FY4Lc8THPa8ZNcYbi8WHpS3MOrcj47tgMCBvFdcn04ffV0UBBQPujKwEa7UlX7F6BohvmpQzMMQD1gdUo+mKEIJJL00D5Oyq0dlp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=gYXjzAoK; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1753627459;
 bh=cHbYnH0ztRM4vrUIrRVJUpu82xoEnhr6aNYoNap29Zs=;
 b=gYXjzAoKEdGATAUVnUKfmGtN/6HPTqoPil1XJfL2LuFLSxYq0an+dK2+jyCkyEYxMnR+z6jDH
 5DyqnPJ69GM8jyGisdunAhycK+0W/7YZQHfHtXw+QO6IKQlxw9dbAFL+8KqB2qoEtdcWjOLaVED
 9ONArJuNZD5jgnQey8SJxxNbgcr7E1sps6HtejKG38dHoyQgex4USRGaFKN1q6JEsF93dMuXbzQ
 rNRdMI0sXsV6S7eiY/F+H3ynTJ6WOJd1WKRQK4ToFHOh63zebDFIWD+zdn8Z7QeItjcoSOoHCWR
 0bOJkWoCPzamX0mBGkxr8vxmA5DQlg7OwpDpupVz15qg==
X-Forward-Email-ID: 68863b3fc752737c6c097854
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.7
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
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/3] arm64: dts: rockchip: Add Radxa E24C
Date: Sun, 27 Jul 2025 14:44:00 +0000
Message-ID: <20250727144409.327740-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds dt-bindings and initial device tree for the Radxa E24C.

The product page for E24C mentions that onboard eMMC is optional and the
model I have come with SPI flash instead of eMMC.

On RK3528 the eMMC and SPI flash is muxed so only one of them can work.

I have included both SPI flash and eMMC nodes in the device tree,
however the sdhci node has been marked with status=fail. Something that
possible could be enabled using a DTBO or FDT fixup by the bootloader.

This also leaves out describing the RTL8367RB-VB switch as support for
the switch requires dt-binding and/or driver changes to make it work,
something that will be handled in a separate follow-up series.

This board can be booted from SD-card using the U-Boot 2025.07
generic-rk3528 target or preferably using work-in-progress patches [1].

This series depends on following series for a clean apply:
- arm64: dts: rockchip: Add ROCK 2A/2F, Sige1 and NanoPi Zero2 [2]
- rockchip: Add power controller support for RK3528 [3]
- rockchip: Add USB 2.0 support for RK3528 [4]

A branch with all these (and some more) patches can be found at [5].

[1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3528
[2] https://lore.kernel.org/r/20250717103720.2853031-1-jonas@kwiboo.se
[3] https://lore.kernel.org/r/20250723085654.2273324-1-jonas@kwiboo.se
[4] https://lore.kernel.org/r/20250723122323.2344916-1-jonas@kwiboo.se
[5] https://github.com/Kwiboo/linux-rockchip/commits/next-20250722-rk3528/

Jonas Karlman (3):
  arm64: dts: rockchip: Add SFC node for RK3528
  dt-bindings: arm: rockchip: Add Radxa E24C
  arm64: dts: rockchip: Add Radxa E24C

 .../devicetree/bindings/arm/rockchip.yaml     |   6 +-
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3528-radxa-e24c.dts   | 519 ++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3528.dtsi      |  12 +
 4 files changed, 536 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-radxa-e24c.dts

-- 
2.50.1



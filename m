Return-Path: <linux-kernel+bounces-877946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB5CC1F689
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A93B84E8B50
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D26234DCF5;
	Thu, 30 Oct 2025 09:59:01 +0000 (UTC)
Received: from mail-sh.amlogic.com (unknown [114.94.151.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C41334DB6B;
	Thu, 30 Oct 2025 09:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.94.151.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761818341; cv=none; b=f7zZ3EeUkjPRkoF78xCnWLuUGjavHA2jbNBgFxFa8s8/znon8MO9NcajQsC7r1BwGuzw84C0VgXC4kr1ztusfkpfATyY3Dk+4xJeaWMrrCvvT1p3Pg61CSe4sGGfnjFDjMOpIo5+ugCCx8ZC7ZvFzX+DPuVEBAdM4GyFnhgc4SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761818341; c=relaxed/simple;
	bh=gSVZiTnJFxeAUHBRo69f+mVxOGDN6h3cHEgWaFJthkQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QNVFFgIAG1xXsdYQtIzh4WoZd9wDI9Dg6PwzWNhgT4eFh5O7iJAKRjVG5OjH2ktY0aEDGcCM8Grn2fyQ9Tk6KkLyC3Q6FMvUcrOpeol6IWy3kB+jUTlj9olJukCKmNk454rbUB5nIw/i1xpSk0z1qdbwtfY6PYiPyiuMzs7oftM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; arc=none smtp.client-ip=114.94.151.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Received: from rd03-sz.software.amlogic (10.28.11.121) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.61; Thu, 30 Oct 2025
 17:43:48 +0800
From: Jian Hu <jian.hu@amlogic.com>
To: Jerome Brunet <jbrunet@baylibre.com>, Xianwei Zhao
	<xianwei.zhao@amlogic.com>, Chuan Liu <chuan.liu@amlogic.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, "Stephen
 Boyd" <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
	"Dmitry Rokosov" <ddrokosov@sberdevices.ru>, robh+dt <robh+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
CC: Jian Hu <jian.hu@amlogic.com>, devicetree <devicetree@vger.kernel.org>,
	linux-clk <linux-clk@vger.kernel.org>, linux-amlogic
	<linux-amlogic@lists.infradead.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-arm-kernel
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 0/5] add support for T7 family clock controller
Date: Thu, 30 Oct 2025 17:43:40 +0800
Message-ID: <20251030094345.2571222-1-jian.hu@amlogic.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

It introduces three clock controllers:
- SCMI clock controller: these clocks are managed by the SCP and handled through SCMI.
- PLL clock controller.
- peripheral clock controller.

Changes v4 since v4 at [2]:
- drop amlogic_t7_pll_probe, use meson_clkc_mmio_probe instead
- add CLK_DIVIDER_MAX_AT_ZERO for pcie_pll_od clk
- add frac for hifi_dco_pll_dco
- add l_detect for mclk_pll_dco
- drop v3 5/6 patch, and use MESON_PCLK
- drop SPI_PWM_CLK_XX macro and use MESON_COMP_XX
- drop the register's prefix

Changes v3 since v2 at [2]:
- update T7 PLL YAML
- add 't7_' prefix for t7 clock name and variable in t7-pll.c and t7-peripherals.c
- correct v1 patch link
- add new macro MESON_PCLK_V2
- update the driver,header,yaml file license

Changes v2 since v1 at [1]:
- add CLK_MESON import
- add const for clkc_regmap_config in PLL driver
- fix eth_rmii_sel parent
- update T7 PLL YAML file

[1]: https://lore.kernel.org/all/20241231060047.2298871-1-jian.hu@amlogic.com
[2]: https://lore.kernel.org/all/20250108094025.2664201-1-jian.hu@amlogic.com
[3]: https://lore.kernel.org/all/20250509074825.1933254-1-jian.hu@amlogic.com

Jian Hu (5):
  dt-bindings: clock: add Amlogic T7 PLL clock controller
  dt-bindings: clock: add Amlogic T7 SCMI clock controller
  dt-bindings: clock: add Amlogic T7 peripherals clock controller
  clk: meson: t7: add support for the T7 SoC PLL clock
  clk: meson: t7: add t7 clock peripherals controller driver

 .../clock/amlogic,t7-peripherals-clkc.yaml    |  112 ++
 .../bindings/clock/amlogic,t7-pll-clkc.yaml   |  114 ++
 drivers/clk/meson/Kconfig                     |   27 +
 drivers/clk/meson/Makefile                    |    2 +
 drivers/clk/meson/t7-peripherals.c            | 1734 +++++++++++++++++
 drivers/clk/meson/t7-pll.c                    | 1068 ++++++++++
 .../clock/amlogic,t7-peripherals-clkc.h       |  230 +++
 .../dt-bindings/clock/amlogic,t7-pll-clkc.h   |   56 +
 include/dt-bindings/clock/amlogic,t7-scmi.h   |   47 +
 9 files changed, 3390 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,t7-peripherals-clkc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,t7-pll-clkc.yaml
 create mode 100644 drivers/clk/meson/t7-peripherals.c
 create mode 100644 drivers/clk/meson/t7-pll.c
 create mode 100644 include/dt-bindings/clock/amlogic,t7-peripherals-clkc.h
 create mode 100644 include/dt-bindings/clock/amlogic,t7-pll-clkc.h
 create mode 100644 include/dt-bindings/clock/amlogic,t7-scmi.h

-- 
2.47.1



Return-Path: <linux-kernel+bounces-798757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FE8B42287
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22BD81B25FC5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4CD30DEA0;
	Wed,  3 Sep 2025 13:56:06 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69CA2FF150
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 13:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756907765; cv=none; b=C1GaYuB/lcVT1c/EdEZ0swARJPMzMgRzUb6vGCdBZq5TmBAYS4XLTX5p/GmLRkSFoRw+n17lLj+ZPwTGA/dYeBK93jVzeD1m+MbqVSVpoDpL48/EwsFbK2yeOeQj0ZnxZUbFeptU99S3l0ATKqzxNdpHwsJ0zBoOc65Qtg5HcFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756907765; c=relaxed/simple;
	bh=fTo/pKhkHizPHqoUnL2WzHA12NcPmmB+hWHggZRRSy0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gYtxmBTaNRzd7agkNjBDJRQUMDVbgrwdJW/8xJrCUIFTOnGgMEoUe//IferhcDRkwpC1G4GzJQ69MShPV+87lu5fsPMmqKp/iJdER2yP5ynZboYjkk8gCe0PFxmry0TG3M3ZMf97zoskRIvou+Vtn7amHnpGMdHnfo5CGywbBfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1utnxx-0007v9-36; Wed, 03 Sep 2025 15:56:01 +0200
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1utnxw-003ZMP-1v;
	Wed, 03 Sep 2025 15:56:00 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1utnxw-000000034Tm-25PX;
	Wed, 03 Sep 2025 15:56:00 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v6 0/2] clk: add support for TI CDCE6214
Date: Wed, 03 Sep 2025 15:55:44 +0200
Message-Id: <20250903-clk-cdce6214-v6-0-b2cc0a6f282b@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOBIuGgC/3XQTW7CMBCG4asgrzEaj//irnqPikVsj8EqSpBDI
 xDK3euwaRTS5TvSPIvvyQYqmQb2sXuyQmMect/VMPsdC+e2OxHPsTZDQA0KGh4u3zzEQAaF4hC
 sAiVjQGNZfbkWSvn+4r6Otc95uPXl8dJHMV//gUbBgfuoyILD1on0eaXu9HMrfZfvh0hs1kZcC
 m4lYBUUeNTeIlLwm4JcCAJWgqxCtDIkl5KMDWwKaiHItVAX4S4JTVagaYPZFPSfYMR6Bz0LTja
 +oQjeqTdhmqZfCdctOLUBAAA=
X-Change-ID: 20250408-clk-cdce6214-0c74043dc267
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@pengutronix.de, 
 Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756907760; l=3397;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=fTo/pKhkHizPHqoUnL2WzHA12NcPmmB+hWHggZRRSy0=;
 b=hL8uJrVr5lZfgRtcIAmFlgnVj2sE7TkxBrrqZYO9g9v53iUUxY4ipRd2Sye3dtS+A44xpoeoM
 OPigN2nOBM3DM4J3jSoHVd35BWChit5Cwlc2XQhVbn8QqgAGGN2LK7/
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The CDCE6214 is a Ultra-Low Power Clock Generator With One PLL, Four
Differential Outputs, Two Inputs, and Internal EEPROM.

This series adds a common clk framework driver for this chip along with
the dt-bindings document.

The most controversial part of this series was the binding I introduced
for configuring the pins of the CDCE6214. With v6 I have now integrated
a pinctrl driver into the driver in the hope that this silences the
discussion around the pins.

Sascha

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
Changes in v6:
- use pinctrl subsystem to configure pins
- Link to v5: https://lore.kernel.org/r/20250618-clk-cdce6214-v5-0-9938b8ed0b94@pengutronix.de

Changes in v5:
- Reword commit message for binding patch (Krzysztof)
- Make clock binding yaml simpler (Krzysztof)
- add link to datasheet to driver code (Stephen)
- Drop inclusion of linux/clk.h (Stephen)
- Add missing #include <linux/bitfield.h> (Kernel test robot)
- simplify cdce6214_clk_out0_get_parent() (Stephen)
- Use divider_get_val() where appropriate (Stephen)
- Add Rxx defines for registers (Stephen)
- Add define for magic value 24 (Stephen)
- introduce and use cdce6214_clk_psx_mask() (Stephen)
- Use clamp() instead of open code (Stephen)
- declare const arrays const (Stephen)
- more use of dev_err_probe() (Stephen)
- use determine_rate() instead of round_rate (Stephen)
- split out pin configuration to separate patches
- Link to v4: https://lore.kernel.org/r/20250430-clk-cdce6214-v4-0-9f15e7126ac6@pengutronix.de

Changes in v4:
- add missing '>' modifier in include/dt-bindings/clock/ti,cdce6214.h
- fix clocks maxItems should be 2
- add missing license in include/dt-bindings/clock/ti,cdce6214.h
- Fix checkpatch issues
- Link to v3: https://lore.kernel.org/r/20250410-clk-cdce6214-v3-0-d73cf9ff3d80@pengutronix.de

Changes in v3:
- Use string properties instead of int for enums
- Use units from property-units in dtschema
- Link to v2: https://lore.kernel.org/r/20250409-clk-cdce6214-v2-0-40b25b722ecb@pengutronix.de

Changes in v2:
- Use consistent quotes in binding document
- make clock-names an enum to make each clock fully optional
- drop '|' in binding description where not needed
- encode clock input mode into integer
- encode clock output mode into integer
- do not use defines for reg properties
- support setting load capacity for the oscillator via device tree
- support setting Bias current for the oscillator via device tree
- support setting polarities of CMOS outputs via device tree
- fix compatible string in driver
- remove unused struct cdce6214_config
- Link to v1: https://lore.kernel.org/r/20250408-clk-cdce6214-v1-0-bd4e7092a91f@pengutronix.de

---
Sascha Hauer (2):
      dt-bindings: clock: add TI CDCE6214 binding
      clk: add TI CDCE6214 clock driver

 .../devicetree/bindings/clock/ti,cdce6214.yaml     |  198 +++
 drivers/clk/Kconfig                                |    7 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-cdce6214.c                         | 1620 ++++++++++++++++++++
 include/dt-bindings/clock/ti,cdce6214.h            |   24 +
 5 files changed, 1850 insertions(+)
---
base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
change-id: 20250408-clk-cdce6214-0c74043dc267

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>



Return-Path: <linux-kernel+bounces-838569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FDABAF8FC
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 10:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FCC17AD654
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 08:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5354627B35B;
	Wed,  1 Oct 2025 08:13:04 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188A1258CD0
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 08:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759306383; cv=none; b=A2W0rAA8BzubIipxzMgIssFJBjkfvAVQeG52P8HhNJ73IAgd4RSFdveafMGskJ76vVHao8jZ6cFmORAMZERLusioeiEYUlOMApm1k7JeplRwawXQU3E6645Z36T4yLifaCyHzQ182kNrCIZh0vX6NUvXcj1sDXCiyQarnwBUpYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759306383; c=relaxed/simple;
	bh=TDsRwglB7S0kKASOBYYDyYjMX+Rrt5Kpmwy9OO9VQfo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mEBgjWdDf1O6lT+WrROlE3hSsVd4FdJjFYo+T+veu1g3DXr/JvGF9l9cx1ol3JV4DPbZ+C14WXT96ajfi9/dMIsXlbkDp+SWyzTK7n2OVQsa6/pAX5E4SG9+LLxmvexGktKyGavbNjIpm0MLVfTe/k+q6fpqp0LPLnuIXQoDAFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1v3rxH-0004Pd-AX; Wed, 01 Oct 2025 10:12:55 +0200
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1v3rxG-001NZg-2h;
	Wed, 01 Oct 2025 10:12:54 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1v3rxG-00000001m9N-375i;
	Wed, 01 Oct 2025 10:12:54 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v7 0/2] clk: add support for TI CDCE6214
Date: Wed, 01 Oct 2025 10:12:52 +0200
Message-Id: <20251001-clk-cdce6214-v7-0-5f8b44da95a5@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAITi3GgC/3XQQW7DIBCF4atErEs1DBhMVr1H1YUZhgS1siOcW
 qki3704m1iuu3wjzbf472LkknkUx8NdFJ7ymIe+DvdyEHTu+hPLHOsWCNiAgVbS16ekSGxRGQn
 kDBgdCa0T9eVSOOXbg3v/qPucx+tQfh76pJbrP9CkJMgQDTvw2HmV3i7cn76vZejz7TWyWLQJ1
 4LfCFgFAwGb4BCZwq6gV4KCjaCrEJ2m5FPSsYVdwawEvRVqEemTatgptB3ZXaF5ClZtOzSL4HU
 bWo4QvNkV7FPwoDeCXUoiEXQ2YYt/O8zz/AtJw4oD9wEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759306374; l=4139;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=TDsRwglB7S0kKASOBYYDyYjMX+Rrt5Kpmwy9OO9VQfo=;
 b=ntJeI/MMVNek8DI+zcjMCsscBzS0o6nUepZHg8yX175CT10S8mvbvM5u0NJv0QgFDEZyTI0D7
 eTTSVELoftjAdBx8g93OeH2F5m7ITOSkT/vbM5XVDl0zG43DfURGFw6
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The CDCE6214 is a Ultra-Low Power Clock Generator With One PLL, Four
Differential Outputs, Two Inputs, and Internal EEPROM.

This series adds a common clk framework driver for this chip along with
the dt-bindings document. The cdce6214 needs several pins to be
configured for different input/output modes which are abstracted with a
pinctrl driver.

In v5 I tried to split up the patch into a non controversial part (to be
applied) and a part which needs more discussion (to be applied later).
That was not very well received, so I merged it back in v6. I didn't
mention that explicitly in v6, so doing it now.

v7 contains only small changes, mostly binding updates requested by Rob.

Sascha

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
Changes in v7:
- add missing blank line between properties in binding (Rob)
- drop unnecessary #size-cells #address-cells in binding (Rob)
- add vendor prefix to custom properties (Rob)
- Use standard units where appropriate (Rob)
- add dependency to PINCTRL and select GENERIC_PINCONF (0day bot)
- re-add missing SPDX in ti,cdce6214.h
- Link to v6: https://lore.kernel.org/r/20250903-clk-cdce6214-v6-0-b2cc0a6f282b@pengutronix.de

Changes in v6:
- merge split up patches back together (forgot to mention when sending v6)
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

 .../devicetree/bindings/clock/ti,cdce6214.yaml     |  192 +++
 drivers/clk/Kconfig                                |    9 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-cdce6214.c                         | 1620 ++++++++++++++++++++
 include/dt-bindings/clock/ti,cdce6214.h            |   25 +
 5 files changed, 1847 insertions(+)
---
base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
change-id: 20250408-clk-cdce6214-0c74043dc267

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>



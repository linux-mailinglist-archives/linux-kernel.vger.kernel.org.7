Return-Path: <linux-kernel+bounces-837428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6678FBAC4FB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1746E321BC1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A5C2F8BC0;
	Tue, 30 Sep 2025 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9xxRbBB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91842F5305;
	Tue, 30 Sep 2025 09:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759225051; cv=none; b=H82mNCIkHAvznb9d2rB+rVrk9kKhebNDFQ0uK8LuK8KxvnB+YL6L4JanwsRPqHk3jQ/RipMoTXR3wisAGXfyXtQbE5w3ZxMNx2x19H6SkjJOeRu+7F3J+X5ahosubqzUURFs8ZGGOpK55eTzEyIEye225HUKACAwQphlaHo88ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759225051; c=relaxed/simple;
	bh=5o+htP+rM/HKQyGn1eH3S7+MzThwQ+uX1Hq8VqONr8g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qfAlzwfA4rot1qJjKmh0kXonbmBpLrgwUgUEbhgYW2mxxc66r2CTe75AHS/PT+7m+f+HlKlp+tGn4t6mLTt7n8qnoURQZZXq5Vnpt7fGiANIfh/X7gp5KDVr0kNGXFJWZGKz7NcUgBlL+4cvSF4WF/LbcDtMETxUIpWn0faYODc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9xxRbBB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44A39C4CEF0;
	Tue, 30 Sep 2025 09:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759225051;
	bh=5o+htP+rM/HKQyGn1eH3S7+MzThwQ+uX1Hq8VqONr8g=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=n9xxRbBBX96T9ogcvhLUVw8I8DhLBCLfbpk2dfxWWXyJ/khtsq8oqFcT7gGdJqit/
	 tWd6EgzlvC+0o6Bt7lHLfzDo/6yH7naAjRWQ7xfHiml1BS1hpIL3N9vAdcUGR7SpT3
	 Z0LNwuF6TBLCCfkRPe13i8SnOwGpuzl7LzdYjnvutHXqCzQ7mwHuxzuXC2EYyof6jH
	 edpVAsXoS8kubU08pHR5U9LT4zwEzvQQw1N81UnIzStZ03XlSFJL/og3k0UuUxff7b
	 zF4jiPEE3lZ5q0AOmAQgCMDSl+xXF5V2LJneUtv9+igBFiWrDje3RdijMcN/HiabZW
	 yZbBf/QEdRPfw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAB2CAC5BC;
	Tue, 30 Sep 2025 09:37:31 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Subject: [PATCH 00/19] clk: amlogic: Add PLLs and peripheral clocks for A4
 and A5 SoCs
Date: Tue, 30 Sep 2025 17:37:13 +0800
Message-Id: <20250930-a4_a5_add_clock_driver-v1-0-a9acf7951589@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMmk22gC/x3M0QoCIRBA0V9Z5jnBNC37lSXEnKmGYl1GkED89
 6TH83Bvh0rCVOG6dBBqXLlsE8fDAvmVticpxmkw2jgdzEWlU0wuJsSYPyW/Iwo3EmXu5xzQB+e
 thRnvQg/+/sfrbYwfl8Id9GgAAAA=
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759225047; l=4218;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=5o+htP+rM/HKQyGn1eH3S7+MzThwQ+uX1Hq8VqONr8g=;
 b=9UB/pSh4Qx25JQAEirqjDzvZLuzERi70Cm6gW7FIEkZawGXnWeEHArseYuIOn4cVV4sEtZAa/
 JbTQPGuAcNjD5619B0r6CFtJhOhE2icgF32q6i9IBU4mc7tmLmTgXXe
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

This patch series includes changes related to the PLL and peripheral
clocks for both the A4 and A5 SoCs.

The patches for A5 were previously submitted up to V3 by Xianwei.
https://lore.kernel.org/all/20250103-a5-clk-v3-0-a207ce83b9e9@amlogic.com/
After friendly coordination, I’ve taken over and continued the
submission as part of this series. The dt-bindings patch retains Rob's
original "Reviewed-by" tag, and I hope this hasn’t caused any
additional confusion.

Both A4 and A5 belong to the Audio series. Judging by their names, one
might assume that A5 is an upgrade to A4, but in fact, A5 was released
a year earlier than A4.

Since there are differences in the PLLs and peripheral clocks between
the A4 and A5 SoCs (especially the PLL), and taking into account factors
such as memory footprint and maintainability, this series does not
attempt to merge the two into a shared driver as was done for
G12A/G12B/SM1.

This patch series includes all related dt-bindings, driver, and dts
changes for the PLLs and peripheral clocks. Following our past convention
for clock-related submissions, the dts changes are placed at the end
and submitted separately. If this ordering makes it harder for
maintainers to review or pick patches, please feel free to point it out.

Co-developed-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
Chuan Liu (19):
      dt-bindings: clock: Add Amlogic A4 SCMI clock controller
      dt-bindings: clock: Add Amlogic A4 PLL clock controller
      dt-bindings: clock: Add Amlogic A4 peripherals clock controller
      clk: amlogic: Optimize PLL enable timing
      clk: amlogic: Correct l_detect bit control
      clk: amlogic: Fix out-of-range PLL frequency setting
      clk: amlogic: Add A4 PLL clock controller driver
      clk: amlogic: Add A4 clock peripherals controller driver
      arm64: dts: amlogic: A4: Add scmi-clk node
      arm64: dts: amlogic: A4: Add PLL controller node
      arm64: dts: amlogic: A4: Add peripherals clock controller node
      dt-bindings: clock: Add Amlogic A5 SCMI clock controller support
      dt-bindings: clock: Add Amlogic A5 PLL clock controller
      dt-bindings: clock: Add Amlogic A5 peripherals clock controller
      clk: amlogic: Add A5 PLL clock controller driver
      clk: amlogic: Add A5 clock peripherals controller driver
      arm64: dts: amlogic: A5: Add scmi-clk node
      arm64: dts: amlogic: A5: Add PLL controller node
      arm64: dts: amlogic: A5: Add peripheral clock controller node

 .../clock/amlogic,a4-peripherals-clkc.yaml         | 122 +++
 .../bindings/clock/amlogic,a4-pll-clkc.yaml        |  61 ++
 .../clock/amlogic,a5-peripherals-clkc.yaml         | 134 ++++
 .../bindings/clock/amlogic,a5-pll-clkc.yaml        |  63 ++
 arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi        |  80 ++
 arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi        |  87 ++
 drivers/clk/meson/Kconfig                          |  53 ++
 drivers/clk/meson/Makefile                         |   4 +
 drivers/clk/meson/a1-pll.c                         |   1 +
 drivers/clk/meson/a4-peripherals.c                 | 764 ++++++++++++++++++
 drivers/clk/meson/a4-pll.c                         | 242 ++++++
 drivers/clk/meson/a5-peripherals.c                 | 883 +++++++++++++++++++++
 drivers/clk/meson/a5-pll.c                         | 476 +++++++++++
 drivers/clk/meson/clk-pll.c                        |  76 +-
 drivers/clk/meson/clk-pll.h                        |   2 +
 .../clock/amlogic,a4-peripherals-clkc.h            | 129 +++
 include/dt-bindings/clock/amlogic,a4-pll-clkc.h    |  15 +
 include/dt-bindings/clock/amlogic,a4-scmi-clkc.h   |  42 +
 .../clock/amlogic,a5-peripherals-clkc.h            | 132 +++
 include/dt-bindings/clock/amlogic,a5-pll-clkc.h    |  24 +
 include/dt-bindings/clock/amlogic,a5-scmi-clkc.h   |  44 +
 21 files changed, 3406 insertions(+), 28 deletions(-)
---
base-commit: 01f3a6d1d59b8e25a6de243b0d73075cf0415eaf
change-id: 20250928-a4_a5_add_clock_driver-2b7c9d695633

Best regards,
-- 
Chuan Liu <chuan.liu@amlogic.com>




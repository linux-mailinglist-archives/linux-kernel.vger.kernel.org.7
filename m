Return-Path: <linux-kernel+bounces-793552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE401B3D514
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 22:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B85B18992A2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 20:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923DC23BF91;
	Sun, 31 Aug 2025 20:06:59 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B266F22F76F;
	Sun, 31 Aug 2025 20:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756670819; cv=none; b=A3ckPbOmX5UqYsYAPNeQ4gLWUBM7N9KJjVink8QBQ0pNgWOrrYgGSTZlI8aEdWSRYt8EV5kRyyM8FDpiUdJ+tbvCqzVeuLK8MboLiZBXvHHzfgWjCsQBkWmFbMsUsFDeap1BmtLYBtp/izxYf2QNiST22/fe2EwRqOoBXWe07Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756670819; c=relaxed/simple;
	bh=t5sABCz5RP+pwbVroWzgftkP8mogyDgoEiWiI8kqnxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i+EuOiyTG6gqM9M/4LuKlP7M6PbqSymB2V+43lfHpFRj726NgoEvUEspYsWuy1Cfc+8DWS6iKhx3HqvYp588FadY1MCka2pl10aatCqovzYKSvCrRpYR0u1HCFj/XF4lf+7+MTWGN5RVKYInDDvACX/YI7ydyOTWrF2uP4og6Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 7E21CB220079;
	Sun, 31 Aug 2025 22:06:44 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: E Shattow <e@freeshell.de>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v1] dts: arm64: freescale: move imx9*-clock.h imx9*-power.h into dt-bindings
Date: Sun, 31 Aug 2025 13:04:45 -0700
Message-ID: <20250831200516.522179-1-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move imx9*-{clock,power}.h headers into
include/dt-bindings/{clock,power}/ and fix up the DTs

Reported-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: E Shattow <e@freeshell.de>
---
 arch/arm64/boot/dts/freescale/imx94.dtsi                      | 4 ++--
 arch/arm64/boot/dts/freescale/imx95.dtsi                      | 4 ++--
 .../dts/freescale => include/dt-bindings/clock}/imx94-clock.h | 0
 .../dts/freescale => include/dt-bindings/clock}/imx95-clock.h | 0
 .../dts/freescale => include/dt-bindings/power}/imx94-power.h | 0
 .../dts/freescale => include/dt-bindings/power}/imx95-power.h | 0
 6 files changed, 4 insertions(+), 4 deletions(-)
 rename {arch/arm64/boot/dts/freescale => include/dt-bindings/clock}/imx94-clock.h (100%)
 rename {arch/arm64/boot/dts/freescale => include/dt-bindings/clock}/imx95-clock.h (100%)
 rename {arch/arm64/boot/dts/freescale => include/dt-bindings/power}/imx94-power.h (100%)
 rename {arch/arm64/boot/dts/freescale => include/dt-bindings/power}/imx95-power.h (100%)

diff --git a/arch/arm64/boot/dts/freescale/imx94.dtsi b/arch/arm64/boot/dts/freescale/imx94.dtsi
index 44dee2cbd42d..1fe6ef4518a8 100644
--- a/arch/arm64/boot/dts/freescale/imx94.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx94.dtsi
@@ -8,9 +8,9 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
-#include "imx94-clock.h"
+#include <dt-bindings/clock/imx94-clock.h>
 #include "imx94-pinfunc.h"
-#include "imx94-power.h"
+#include <dt-bindings/power/imx94-power.h>
 
 / {
 	#address-cells = <2>;
diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 4ca6a7ea586e..787d3f829816 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -10,9 +10,9 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/thermal.h>
 
-#include "imx95-clock.h"
+#include <dt-bindings/clock/imx95-clock.h>
 #include "imx95-pinfunc.h"
-#include "imx95-power.h"
+#include <dt-bindings/power/imx95-power.h>
 
 / {
 	interrupt-parent = <&gic>;
diff --git a/arch/arm64/boot/dts/freescale/imx94-clock.h b/include/dt-bindings/clock/imx94-clock.h
similarity index 100%
rename from arch/arm64/boot/dts/freescale/imx94-clock.h
rename to include/dt-bindings/clock/imx94-clock.h
diff --git a/arch/arm64/boot/dts/freescale/imx95-clock.h b/include/dt-bindings/clock/imx95-clock.h
similarity index 100%
rename from arch/arm64/boot/dts/freescale/imx95-clock.h
rename to include/dt-bindings/clock/imx95-clock.h
diff --git a/arch/arm64/boot/dts/freescale/imx94-power.h b/include/dt-bindings/power/imx94-power.h
similarity index 100%
rename from arch/arm64/boot/dts/freescale/imx94-power.h
rename to include/dt-bindings/power/imx94-power.h
diff --git a/arch/arm64/boot/dts/freescale/imx95-power.h b/include/dt-bindings/power/imx95-power.h
similarity index 100%
rename from arch/arm64/boot/dts/freescale/imx95-power.h
rename to include/dt-bindings/power/imx95-power.h

base-commit: 5c3b3264e5858813632031ba58bcd6e1eeb3b214
-- 
2.50.0



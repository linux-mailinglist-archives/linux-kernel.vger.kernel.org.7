Return-Path: <linux-kernel+bounces-836059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3A8BA8A26
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D8537B43B3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8593F2BEFF9;
	Mon, 29 Sep 2025 09:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4y8U2GGK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kzGdsuZW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CA02C11F0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138156; cv=none; b=YUY6ba43EB0UZW0W5hlXDfCbPOfKZPN6oyqGJgXd37x/CFMpsJAr+HkHuuN8N5hfsBqDLRuleEA78Sis8ACka6rTL0j8dGtCYASZ0Qr+VpzoIMNgKw522x9VengFQQNypj9HpwZpQU+x5OgRxWx2oywcvvndYkLpj7jroGe56IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138156; c=relaxed/simple;
	bh=k0vsOlG1ZN0fkYyMRkvWvP6l0df+E70O8QBk3EqrImQ=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=bNHTofF2kTslyNNk3d+b87/c2zWrUyx3Bsi4OhVuSzb07UF8oLc9Q0pSDMScoom9UwoB53rhKaU1sXtMziWphYWGSIZrX5/2MPwZbNDmteolmOcuJ0vwEfpNSiU19qU0U278VnKPd2sVlu+H8gMzlhKDY0AGSihKQfheaCZtcxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4y8U2GGK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kzGdsuZW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759138147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=PD8QP7ZpHVBTmz7lBUh+FrnvP+SRh/IH3S5jJoknhqo=;
	b=4y8U2GGKMcv80wdqPpVaprQYY5n9popLQiEiJyBZPU9UVqV+hGQZA/xJU+X221EIHCsPpb
	T9BHtAAq1fdSOh4cnChsgfZcPZOtwk9EBkm9qcsRzVWn2kTa50ukU4DMTrnh/KpP2hHPat
	B6B+JscWcBMUg9rBBoFlt0s110jgWRMvEGEm4kDvt+DrPd4CWTweciswhrAyPZ/gt+/9Cp
	j7d6IvqnmF1ijo5w4WFefs0LJc54HvlDwijo3Dl8mPPhdj6cFeb7Sq3O+eRhtMCjcChpc+
	1Yw6D1I9B+0Ol+TI4ZhbukIVXwyRWno3+wMAD8llfR8zQxsj12axOQb6thCBpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759138147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=PD8QP7ZpHVBTmz7lBUh+FrnvP+SRh/IH3S5jJoknhqo=;
	b=kzGdsuZW+od9lo8MSFkCJ10HZkoSAXW8ri8+O6Sh8+Fc821P/L0okDNg8u7G1F6Ciubg9E
	RoHuFvh1Er3XWZBQ==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/clocksource for v6.18-rc1
References: <175913807599.495041.10251515322736195577.tglx@xen13>
Message-ID: <175913808666.495041.8647163849236838852.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 29 Sep 2025 11:29:06 +0200 (CEST)

Linus,

please pull the latest timers/clocksource branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-clocksour=
ce-2025-09-29

up to:  749b61c2d6a9: Merge tag 'timers-v6.18-rc1' of git://git.kernel.org/pu=
b/scm/linux/kernel/git/daniel.lezcano/linux into timers/clocksource

Updates for the clocksource/clockevents drivers subsystem:

  - Further preparations for modular clocksource/event drivers

  - The usual device tree updates to support new chip variants and the
    related changes to thise drivers

  - Avoid a 64-bit division in the TEGRA186 driver, which caused a build
    fail on 32-bit machines.

  - Small fixes, improvements and cleanups all over the place

Thanks,

	tglx

------------------>
AngeloGioacchino Del Regno (1):
      dt-bindings: timer: mediatek,timer: Add MediaTek MT8196 compatible

Arnd Bergmann (1):
      clocksource/drivers/tegra186: Avoid 64-bit division

Brian Masney (1):
      clocksource/drivers/ingenic-sysost: Convert from round_rate() to determ=
ine_rate()

Chen Ni (1):
      clocksource/timer-econet-en751221: Convert comma to semicolon

Daniel Lezcano (27):
      clocksource/drivers/scx200: Add module owner
      clocksource/drivers/stm32-lp: Add module owner
      clocksource/drivers/sun5i: Add module owner
      clocksource/drivers/tegra186: Add module owner
      clocksource/drivers/stm: Add module owner
      clocksource/drivers/cs5535: Add module owner
      time/sched_clock: Export symbol for sched_clock register function
      clocksource/drivers/vf-pit: Replace raw_readl/writel to readl/writel
      clocksource/drivers/vf-pit: Add COMPILE_TEST option
      clocksource/drivers/vf-pit: Set the scene for multiple timers
      clocksource/drivers/vf-pit: Rework the base address usage
      clocksource/drivers/vf-pit: Pass the cpu number as parameter
      clocksource/drivers/vf-pit: Encapsulate the initialization of the cycle=
s_per_jiffy
      clocksource/drivers/vf-pit: Allocate the struct timer at init time
      clocksource/drivers/vf-pit: Convert raw values to BIT macros
      clocksource/drivers/vf-pit: Register the clocksource from the driver
      clocksource/drivers/vf-pit: Encapsulate the macros
      clocksource/drivers/vf-pit: Encapsulate the PTLCVAL macro
      clocksource/drivers/vf-pit: Use the node name for the interrupt and tim=
er names
      clocksource/drivers/vf-pit: Encapsulate clocksource enable / disable
      clocksource/drivers/vf-pit: Enable and disable module on error
      clocksource/drivers/vf-pit: Encapsulate set counter function
      clocksource/drivers/vf-pit: Consolidate calls to pit_*_disable/enable
      clocksource/drivers/vf-pit: Unify the function name for irq ack
      clocksource/drivers/vf-pit: Rename the VF PIT to NXP PIT
      dt: bindings: fsl,vf610-pit: Add compatible for s32g2 and s32g3
      clocksource/drivers/nxp-pit: Add NXP Automotive s32g2 / s32g3 support

Frank Li (2):
      dt-bindings: timer: fsl,ftm-timer: use items for reg
      dt-bindings: timer: Add fsl,timrot.yaml

Gokul Praveen (1):
      clocksource/drivers/timer-ti-dm : Capture functionality for OMAP DM tim=
er

Guenter Roeck (2):
      clocksource/drivers/timer-tegra186: Avoid 64-bit divide operation
      clocksource/drivers/timer-tegra186: Simplify calculating timeleft

Marc Zyngier (4):
      ACPI: GTDT: Generate platform devices for MMIO timers
      clocksource/drivers/arm_arch_timer: Add standalone MMIO driver
      clocksource/drivers/arm_arch_timer_mmio: Switch over to standalone driv=
er
      clocksource/drivers/arm_arch_timer_mmio: Add MMIO clocksource

Markus Schneider-Pargmann (1):
      clocksource/drivers/arm_global_timer: Add auto-detection for initial pr=
escaler values

Markus Stockhausen (4):
      clocksource/drivers/timer-rtl-otto: Work around dying timers
      clocksource/drivers/timer-rtl-otto: Drop set_counter function
      clocksource/drivers/timer-rtl-otto: Do not interfere with interrupts
      clocksource/drivers/timer-rtl-otto: Simplify documentation

Max Shevchenko (1):
      dt-bindings: timer: mediatek: add MT6572

Niklas S=C3=B6derlund (1):
      clocksource/drivers/sh_cmt: Split start/stop of clock source and events

Rob Herring (Arm) (1):
      dt-bindings: timer: Convert faraday,fttmr010 to DT schema

SungMin Park (1):
      dt-bindings: timer: exynos4210-mct: Add compatible for ARTPEC-9 SoC

Will McVicker (1):
      of/irq: Export of_irq_count for modules

Wolfram Sang (1):
      clocksource/drivers/timer-tegra186: Don't print superfluous errors

Zhen Ni (1):
      clocksource/drivers/clps711x: Fix resource leaks in error paths


 .../devicetree/bindings/timer/faraday,fttmr010.txt |  38 --
 .../bindings/timer/faraday,fttmr010.yaml           |  89 +++
 .../devicetree/bindings/timer/fsl,ftm-timer.yaml   |   7 +-
 .../devicetree/bindings/timer/fsl,timrot.yaml      |  48 ++
 .../devicetree/bindings/timer/fsl,vf610-pit.yaml   |   9 +-
 .../devicetree/bindings/timer/mediatek,timer.yaml  |   2 +
 .../bindings/timer/samsung,exynos4210-mct.yaml     |   2 +
 MAINTAINERS                                        |   1 +
 drivers/acpi/arm64/gtdt.c                          |  29 +-
 drivers/clocksource/Kconfig                        |  13 +-
 drivers/clocksource/Makefile                       |   3 +-
 drivers/clocksource/arm_arch_timer.c               | 686 ++-----------------=
--
 drivers/clocksource/arm_arch_timer_mmio.c          | 440 +++++++++++++
 drivers/clocksource/arm_global_timer.c             |  44 +-
 drivers/clocksource/clps711x-timer.c               |  23 +-
 drivers/clocksource/ingenic-sysost.c               |  27 +-
 drivers/clocksource/scx200_hrt.c                   |   1 +
 drivers/clocksource/sh_cmt.c                       |  84 ++-
 drivers/clocksource/timer-cs5535.c                 |   1 +
 drivers/clocksource/timer-econet-en751221.c        |   2 +-
 drivers/clocksource/timer-nxp-pit.c                | 382 ++++++++++++
 drivers/clocksource/timer-nxp-stm.c                |   2 +
 drivers/clocksource/timer-rtl-otto.c               |  42 +-
 drivers/clocksource/timer-stm32-lp.c               |   1 +
 drivers/clocksource/timer-sun5i.c                  |   2 +
 drivers/clocksource/timer-tegra186.c               |  38 +-
 drivers/clocksource/timer-ti-dm.c                  | 119 +++-
 drivers/clocksource/timer-vf-pit.c                 | 194 ------
 drivers/of/irq.c                                   |   1 +
 include/clocksource/arm_arch_timer.h               |   5 -
 include/linux/platform_data/dmtimer-omap.h         |   4 +
 kernel/time/sched_clock.c                          |   4 +-
 32 files changed, 1386 insertions(+), 957 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/faraday,fttmr010.=
txt
 create mode 100644 Documentation/devicetree/bindings/timer/faraday,fttmr010.=
yaml
 create mode 100644 Documentation/devicetree/bindings/timer/fsl,timrot.yaml
 create mode 100644 drivers/clocksource/arm_arch_timer_mmio.c
 create mode 100644 drivers/clocksource/timer-nxp-pit.c
 delete mode 100644 drivers/clocksource/timer-vf-pit.c

diff --git a/Documentation/devicetree/bindings/timer/faraday,fttmr010.txt b/D=
ocumentation/devicetree/bindings/timer/faraday,fttmr010.txt
deleted file mode 100644
index 3cb2f4c98d64..000000000000
--- a/Documentation/devicetree/bindings/timer/faraday,fttmr010.txt
+++ /dev/null
@@ -1,38 +0,0 @@
-Faraday Technology timer
-
-This timer is a generic IP block from Faraday Technology, embedded in the
-Cortina Systems Gemini SoCs and other designs.
-
-Required properties:
-
-- compatible : Must be one of
-  "faraday,fttmr010"
-  "cortina,gemini-timer", "faraday,fttmr010"
-  "moxa,moxart-timer", "faraday,fttmr010"
-  "aspeed,ast2400-timer"
-  "aspeed,ast2500-timer"
-  "aspeed,ast2600-timer"
-
-- reg : Should contain registers location and length
-- interrupts : Should contain the three timer interrupts usually with
-  flags for falling edge
-
-Optionally required properties:
-
-- clocks : a clock to provide the tick rate for "faraday,fttmr010"
-- clock-names : should be "EXTCLK" and "PCLK" for the external tick timer
-  and peripheral clock respectively, for "faraday,fttmr010"
-- syscon : a phandle to the global Gemini system controller if the compatible
-  type is "cortina,gemini-timer"
-
-Example:
-
-timer@43000000 {
-	compatible =3D "faraday,fttmr010";
-	reg =3D <0x43000000 0x1000>;
-	interrupts =3D <14 IRQ_TYPE_EDGE_FALLING>, /* Timer 1 */
-		   <15 IRQ_TYPE_EDGE_FALLING>, /* Timer 2 */
-		   <16 IRQ_TYPE_EDGE_FALLING>; /* Timer 3 */
-	clocks =3D <&extclk>, <&pclk>;
-	clock-names =3D "EXTCLK", "PCLK";
-};
diff --git a/Documentation/devicetree/bindings/timer/faraday,fttmr010.yaml b/=
Documentation/devicetree/bindings/timer/faraday,fttmr010.yaml
new file mode 100644
index 000000000000..39506323556c
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/faraday,fttmr010.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/faraday,fttmr010.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Faraday FTTMR010 timer
+
+maintainers:
+  - Joel Stanley <joel@jms.id.au>
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description:
+  This timer is a generic IP block from Faraday Technology, embedded in the
+  Cortina Systems Gemini SoCs and other designs.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: moxa,moxart-timer
+          - const: faraday,fttmr010
+      - enum:
+          - aspeed,ast2400-timer
+          - aspeed,ast2500-timer
+          - aspeed,ast2600-timer
+          - cortina,gemini-timer
+          - faraday,fttmr010
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 8
+    description: One interrupt per timer
+
+  clocks:
+    minItems: 1
+    items:
+      - description: Peripheral clock
+      - description: External tick clock
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: PCLK
+      - const: EXTCLK
+
+  resets:
+    maxItems: 1
+
+  syscon:
+    description: System controller phandle for Gemini systems
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: cortina,gemini-timer
+    then:
+      required:
+        - syscon
+    else:
+      properties:
+        syscon: false
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    timer@43000000 {
+        compatible =3D "faraday,fttmr010";
+        reg =3D <0x43000000 0x1000>;
+        interrupts =3D <14 IRQ_TYPE_EDGE_FALLING>, /* Timer 1 */
+                    <15 IRQ_TYPE_EDGE_FALLING>, /* Timer 2 */
+                    <16 IRQ_TYPE_EDGE_FALLING>; /* Timer 3 */
+        clocks =3D <&pclk>, <&extclk>;
+        clock-names =3D "PCLK", "EXTCLK";
+    };
diff --git a/Documentation/devicetree/bindings/timer/fsl,ftm-timer.yaml b/Doc=
umentation/devicetree/bindings/timer/fsl,ftm-timer.yaml
index 0e4a8ddc3de3..e3b61b62521e 100644
--- a/Documentation/devicetree/bindings/timer/fsl,ftm-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/fsl,ftm-timer.yaml
@@ -14,7 +14,9 @@ properties:
     const: fsl,ftm-timer
=20
   reg:
-    maxItems: 1
+    items:
+      - description: clock event device
+      - description: clock source device
=20
   interrupts:
     maxItems: 1
@@ -50,7 +52,8 @@ examples:
=20
     ftm@400b8000 {
         compatible =3D "fsl,ftm-timer";
-        reg =3D <0x400b8000 0x1000>;
+        reg =3D <0x400b8000 0x1000>,
+              <0x400b9000 0x1000>;
         interrupts =3D <0 44 IRQ_TYPE_LEVEL_HIGH>;
         clock-names =3D "ftm-evt", "ftm-src", "ftm-evt-counter-en", "ftm-src=
-counter-en";
         clocks =3D <&clks VF610_CLK_FTM2>, <&clks VF610_CLK_FTM3>,
diff --git a/Documentation/devicetree/bindings/timer/fsl,timrot.yaml b/Docume=
ntation/devicetree/bindings/timer/fsl,timrot.yaml
new file mode 100644
index 000000000000..d181f274ef9f
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/fsl,timrot.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/fsl,timrot.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale MXS Timer
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,imx23-timrot
+          - fsl,imx28-timrot
+      - const: fsl,timrot
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: irq for timer0
+      - description: irq for timer1
+      - description: irq for timer2
+      - description: irq for timer3
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    timer: timer@80068000 {
+        compatible =3D "fsl,imx28-timrot", "fsl,timrot";
+        reg =3D <0x80068000 0x2000>;
+        interrupts =3D <48>, <49>, <50>, <51>;
+        clocks =3D <&clks 26>;
+    };
diff --git a/Documentation/devicetree/bindings/timer/fsl,vf610-pit.yaml b/Doc=
umentation/devicetree/bindings/timer/fsl,vf610-pit.yaml
index bee2c35bd0e2..42e130654d58 100644
--- a/Documentation/devicetree/bindings/timer/fsl,vf610-pit.yaml
+++ b/Documentation/devicetree/bindings/timer/fsl,vf610-pit.yaml
@@ -15,8 +15,13 @@ description:
=20
 properties:
   compatible:
-    enum:
-      - fsl,vf610-pit
+    oneOf:
+      - enum:
+          - fsl,vf610-pit
+          - nxp,s32g2-pit
+      - items:
+          - const: nxp,s32g3-pit
+          - const: nxp,s32g2-pit
=20
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/timer/mediatek,timer.yaml b/Do=
cumentation/devicetree/bindings/timer/mediatek,timer.yaml
index f68fc7050c56..e3e38066c2cb 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,timer.yaml
+++ b/Documentation/devicetree/bindings/timer/mediatek,timer.yaml
@@ -26,6 +26,7 @@ properties:
       - items:
           - enum:
               - mediatek,mt2701-timer
+              - mediatek,mt6572-timer
               - mediatek,mt6580-timer
               - mediatek,mt6582-timer
               - mediatek,mt6589-timer
@@ -44,6 +45,7 @@ properties:
               - mediatek,mt8188-timer
               - mediatek,mt8192-timer
               - mediatek,mt8195-timer
+              - mediatek,mt8196-timer
               - mediatek,mt8365-systimer
           - const: mediatek,mt6765-timer
=20
diff --git a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.y=
aml b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
index 10578f544581..a4b229e0e78a 100644
--- a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
+++ b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
@@ -26,6 +26,7 @@ properties:
       - items:
           - enum:
               - axis,artpec8-mct
+              - axis,artpec9-mct
               - google,gs101-mct
               - samsung,exynos2200-mct-peris
               - samsung,exynos3250-mct
@@ -131,6 +132,7 @@ allOf:
           contains:
             enum:
               - axis,artpec8-mct
+              - axis,artpec9-mct
               - google,gs101-mct
               - samsung,exynos2200-mct-peris
               - samsung,exynos5260-mct
diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..2243b726edd7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1990,6 +1990,7 @@ S:	Maintained
 F:	arch/arm/include/asm/arch_timer.h
 F:	arch/arm64/include/asm/arch_timer.h
 F:	drivers/clocksource/arm_arch_timer.c
+F:	drivers/clocksource/arm_arch_timer_mmio.c
=20
 ARM GENERIC INTERRUPT CONTROLLER DRIVERS
 M:	Marc Zyngier <maz@kernel.org>
diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index 70f8290b659d..fd995a1d3d24 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -388,11 +388,11 @@ static int __init gtdt_import_sbsa_gwdt(struct acpi_gtd=
t_watchdog *wd,
 	return 0;
 }
=20
-static int __init gtdt_sbsa_gwdt_init(void)
+static int __init gtdt_platform_timer_init(void)
 {
 	void *platform_timer;
 	struct acpi_table_header *table;
-	int ret, timer_count, gwdt_count =3D 0;
+	int ret, timer_count, gwdt_count =3D 0, mmio_timer_count =3D 0;
=20
 	if (acpi_disabled)
 		return 0;
@@ -414,20 +414,41 @@ static int __init gtdt_sbsa_gwdt_init(void)
 		goto out_put_gtdt;
=20
 	for_each_platform_timer(platform_timer) {
+		ret =3D 0;
+
 		if (is_non_secure_watchdog(platform_timer)) {
 			ret =3D gtdt_import_sbsa_gwdt(platform_timer, gwdt_count);
 			if (ret)
-				break;
+				continue;
 			gwdt_count++;
+		} else 	if (is_timer_block(platform_timer)) {
+			struct arch_timer_mem atm =3D {};
+			struct platform_device *pdev;
+
+			ret =3D gtdt_parse_timer_block(platform_timer, &atm);
+			if (ret)
+				continue;
+
+			pdev =3D platform_device_register_data(NULL, "gtdt-arm-mmio-timer",
+							     gwdt_count, &atm,
+							     sizeof(atm));
+			if (IS_ERR(pdev)) {
+				pr_err("Can't register timer %d\n", gwdt_count);
+				continue;
+			}
+
+			mmio_timer_count++;
 		}
 	}
=20
 	if (gwdt_count)
 		pr_info("found %d SBSA generic Watchdog(s).\n", gwdt_count);
+	if (mmio_timer_count)
+		pr_info("found %d Generic MMIO timer(s).\n", mmio_timer_count);
=20
 out_put_gtdt:
 	acpi_put_table(table);
 	return ret;
 }
=20
-device_initcall(gtdt_sbsa_gwdt_init);
+device_initcall(gtdt_platform_timer_init);
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 645f517a1ac2..ffcd23668763 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -395,8 +395,7 @@ config ARM_GLOBAL_TIMER
=20
 config ARM_GT_INITIAL_PRESCALER_VAL
 	int "ARM global timer initial prescaler value"
-	default 2 if ARCH_ZYNQ
-	default 1
+	default 0
 	depends on ARM_GLOBAL_TIMER
 	help
 	  When the ARM global timer initializes, its current rate is declared
@@ -406,6 +405,7 @@ config ARM_GT_INITIAL_PRESCALER_VAL
 	  bounds about how much the parent clock is allowed to decrease or
 	  increase wrt the initial clock value.
 	  This affects CPU_FREQ max delta from the initial frequency.
+	  Use 0 to use auto-detection in the driver.
=20
 config ARM_TIMER_SP804
 	bool "Support for Dual Timer SP804 module"
@@ -474,11 +474,14 @@ config FSL_FTM_TIMER
 	help
 	  Support for Freescale FlexTimer Module (FTM) timer.
=20
-config VF_PIT_TIMER
-	bool
+config NXP_PIT_TIMER
+	bool "NXP Periodic Interrupt Timer" if COMPILE_TEST
 	select CLKSRC_MMIO
 	help
-	  Support for Periodic Interrupt Timer on Freescale Vybrid Family SoCs.
+	  Support for Periodic Interrupt Timer on Freescale / NXP
+	  SoCs. This periodic timer is found on the Vybrid Family and
+	  the Automotive S32G2/3 platforms. It contains 4 channels
+	  where two can be coupled to form a 64 bits channel.
=20
 config SYS_SUPPORTS_SH_CMT
 	bool
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 205bf3b0a8f3..ec4452ee958f 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -49,7 +49,7 @@ obj-$(CONFIG_CLKSRC_LPC32XX)	+=3D timer-lpc32xx.o
 obj-$(CONFIG_CLKSRC_MPS2)	+=3D mps2-timer.o
 obj-$(CONFIG_CLKSRC_SAMSUNG_PWM)	+=3D samsung_pwm_timer.o
 obj-$(CONFIG_FSL_FTM_TIMER)	+=3D timer-fsl-ftm.o
-obj-$(CONFIG_VF_PIT_TIMER)	+=3D timer-vf-pit.o
+obj-$(CONFIG_NXP_PIT_TIMER)	+=3D timer-nxp-pit.o
 obj-$(CONFIG_CLKSRC_QCOM)	+=3D timer-qcom.o
 obj-$(CONFIG_MTK_TIMER)		+=3D timer-mediatek.o
 obj-$(CONFIG_MTK_CPUX_TIMER)	+=3D timer-mediatek-cpux.o
@@ -64,6 +64,7 @@ obj-$(CONFIG_REALTEK_OTTO_TIMER)	+=3D timer-rtl-otto.o
=20
 obj-$(CONFIG_ARC_TIMERS)		+=3D arc_timer.o
 obj-$(CONFIG_ARM_ARCH_TIMER)		+=3D arm_arch_timer.o
+obj-$(CONFIG_ARM_ARCH_TIMER)		+=3D arm_arch_timer_mmio.o
 obj-$(CONFIG_ARM_GLOBAL_TIMER)		+=3D arm_global_timer.o
 obj-$(CONFIG_ARMV7M_SYSTICK)		+=3D armv7m_systick.o
 obj-$(CONFIG_ARM_TIMER_SP804)		+=3D timer-sp804.o
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_a=
rch_timer.c
index 80ba6a54248c..90aeff44a276 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -34,42 +34,12 @@
=20
 #include <clocksource/arm_arch_timer.h>
=20
-#define CNTTIDR		0x08
-#define CNTTIDR_VIRT(n)	(BIT(1) << ((n) * 4))
-
-#define CNTACR(n)	(0x40 + ((n) * 4))
-#define CNTACR_RPCT	BIT(0)
-#define CNTACR_RVCT	BIT(1)
-#define CNTACR_RFRQ	BIT(2)
-#define CNTACR_RVOFF	BIT(3)
-#define CNTACR_RWVT	BIT(4)
-#define CNTACR_RWPT	BIT(5)
-
-#define CNTPCT_LO	0x00
-#define CNTVCT_LO	0x08
-#define CNTFRQ		0x10
-#define CNTP_CVAL_LO	0x20
-#define CNTP_CTL	0x2c
-#define CNTV_CVAL_LO	0x30
-#define CNTV_CTL	0x3c
-
 /*
  * The minimum amount of time a generic counter is guaranteed to not roll ov=
er
  * (40 years)
  */
 #define MIN_ROLLOVER_SECS	(40ULL * 365 * 24 * 3600)
=20
-static unsigned arch_timers_present __initdata;
-
-struct arch_timer {
-	void __iomem *base;
-	struct clock_event_device evt;
-};
-
-static struct arch_timer *arch_timer_mem __ro_after_init;
-
-#define to_arch_timer(e) container_of(e, struct arch_timer, evt)
-
 static u32 arch_timer_rate __ro_after_init;
 static int arch_timer_ppi[ARCH_TIMER_MAX_TIMER_PPI] __ro_after_init;
=20
@@ -85,7 +55,6 @@ static struct clock_event_device __percpu *arch_timer_evt;
=20
 static enum arch_timer_ppi_nr arch_timer_uses_ppi __ro_after_init =3D ARCH_T=
IMER_VIRT_PPI;
 static bool arch_timer_c3stop __ro_after_init;
-static bool arch_timer_mem_use_virtual __ro_after_init;
 static bool arch_counter_suspend_stop __ro_after_init;
 #ifdef CONFIG_GENERIC_GETTIMEOFDAY
 static enum vdso_clock_mode vdso_default =3D VDSO_CLOCKMODE_ARCHTIMER;
@@ -121,76 +90,6 @@ static int arch_counter_get_width(void)
 /*
  * Architected system timer support.
  */
-
-static __always_inline
-void arch_timer_reg_write(int access, enum arch_timer_reg reg, u64 val,
-			  struct clock_event_device *clk)
-{
-	if (access =3D=3D ARCH_TIMER_MEM_PHYS_ACCESS) {
-		struct arch_timer *timer =3D to_arch_timer(clk);
-		switch (reg) {
-		case ARCH_TIMER_REG_CTRL:
-			writel_relaxed((u32)val, timer->base + CNTP_CTL);
-			break;
-		case ARCH_TIMER_REG_CVAL:
-			/*
-			 * Not guaranteed to be atomic, so the timer
-			 * must be disabled at this point.
-			 */
-			writeq_relaxed(val, timer->base + CNTP_CVAL_LO);
-			break;
-		default:
-			BUILD_BUG();
-		}
-	} else if (access =3D=3D ARCH_TIMER_MEM_VIRT_ACCESS) {
-		struct arch_timer *timer =3D to_arch_timer(clk);
-		switch (reg) {
-		case ARCH_TIMER_REG_CTRL:
-			writel_relaxed((u32)val, timer->base + CNTV_CTL);
-			break;
-		case ARCH_TIMER_REG_CVAL:
-			/* Same restriction as above */
-			writeq_relaxed(val, timer->base + CNTV_CVAL_LO);
-			break;
-		default:
-			BUILD_BUG();
-		}
-	} else {
-		arch_timer_reg_write_cp15(access, reg, val);
-	}
-}
-
-static __always_inline
-u32 arch_timer_reg_read(int access, enum arch_timer_reg reg,
-			struct clock_event_device *clk)
-{
-	u32 val;
-
-	if (access =3D=3D ARCH_TIMER_MEM_PHYS_ACCESS) {
-		struct arch_timer *timer =3D to_arch_timer(clk);
-		switch (reg) {
-		case ARCH_TIMER_REG_CTRL:
-			val =3D readl_relaxed(timer->base + CNTP_CTL);
-			break;
-		default:
-			BUILD_BUG();
-		}
-	} else if (access =3D=3D ARCH_TIMER_MEM_VIRT_ACCESS) {
-		struct arch_timer *timer =3D to_arch_timer(clk);
-		switch (reg) {
-		case ARCH_TIMER_REG_CTRL:
-			val =3D readl_relaxed(timer->base + CNTV_CTL);
-			break;
-		default:
-			BUILD_BUG();
-		}
-	} else {
-		val =3D arch_timer_reg_read_cp15(access, reg);
-	}
-
-	return val;
-}
-
 static noinstr u64 raw_counter_get_cntpct_stable(void)
 {
 	return __arch_counter_get_cntpct_stable();
@@ -424,7 +323,7 @@ void erratum_set_next_event_generic(const int access, uns=
igned long evt,
 	unsigned long ctrl;
 	u64 cval;
=20
-	ctrl =3D arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, clk);
+	ctrl =3D arch_timer_reg_read_cp15(access, ARCH_TIMER_REG_CTRL);
 	ctrl |=3D ARCH_TIMER_CTRL_ENABLE;
 	ctrl &=3D ~ARCH_TIMER_CTRL_IT_MASK;
=20
@@ -436,7 +335,7 @@ void erratum_set_next_event_generic(const int access, uns=
igned long evt,
 		write_sysreg(cval, cntv_cval_el0);
 	}
=20
-	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
+	arch_timer_reg_write_cp15(access, ARCH_TIMER_REG_CTRL, ctrl);
 }
=20
 static __maybe_unused int erratum_set_next_event_virt(unsigned long evt,
@@ -667,10 +566,10 @@ static __always_inline irqreturn_t timer_handler(const =
int access,
 {
 	unsigned long ctrl;
=20
-	ctrl =3D arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, evt);
+	ctrl =3D arch_timer_reg_read_cp15(access, ARCH_TIMER_REG_CTRL);
 	if (ctrl & ARCH_TIMER_CTRL_IT_STAT) {
 		ctrl |=3D ARCH_TIMER_CTRL_IT_MASK;
-		arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, evt);
+		arch_timer_reg_write_cp15(access, ARCH_TIMER_REG_CTRL, ctrl);
 		evt->event_handler(evt);
 		return IRQ_HANDLED;
 	}
@@ -692,28 +591,14 @@ static irqreturn_t arch_timer_handler_phys(int irq, voi=
d *dev_id)
 	return timer_handler(ARCH_TIMER_PHYS_ACCESS, evt);
 }
=20
-static irqreturn_t arch_timer_handler_phys_mem(int irq, void *dev_id)
-{
-	struct clock_event_device *evt =3D dev_id;
-
-	return timer_handler(ARCH_TIMER_MEM_PHYS_ACCESS, evt);
-}
-
-static irqreturn_t arch_timer_handler_virt_mem(int irq, void *dev_id)
-{
-	struct clock_event_device *evt =3D dev_id;
-
-	return timer_handler(ARCH_TIMER_MEM_VIRT_ACCESS, evt);
-}
-
 static __always_inline int arch_timer_shutdown(const int access,
 					       struct clock_event_device *clk)
 {
 	unsigned long ctrl;
=20
-	ctrl =3D arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, clk);
+	ctrl =3D arch_timer_reg_read_cp15(access, ARCH_TIMER_REG_CTRL);
 	ctrl &=3D ~ARCH_TIMER_CTRL_ENABLE;
-	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
+	arch_timer_reg_write_cp15(access, ARCH_TIMER_REG_CTRL, ctrl);
=20
 	return 0;
 }
@@ -728,23 +613,13 @@ static int arch_timer_shutdown_phys(struct clock_event_=
device *clk)
 	return arch_timer_shutdown(ARCH_TIMER_PHYS_ACCESS, clk);
 }
=20
-static int arch_timer_shutdown_virt_mem(struct clock_event_device *clk)
-{
-	return arch_timer_shutdown(ARCH_TIMER_MEM_VIRT_ACCESS, clk);
-}
-
-static int arch_timer_shutdown_phys_mem(struct clock_event_device *clk)
-{
-	return arch_timer_shutdown(ARCH_TIMER_MEM_PHYS_ACCESS, clk);
-}
-
 static __always_inline void set_next_event(const int access, unsigned long e=
vt,
 					   struct clock_event_device *clk)
 {
 	unsigned long ctrl;
 	u64 cnt;
=20
-	ctrl =3D arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, clk);
+	ctrl =3D arch_timer_reg_read_cp15(access, ARCH_TIMER_REG_CTRL);
 	ctrl |=3D ARCH_TIMER_CTRL_ENABLE;
 	ctrl &=3D ~ARCH_TIMER_CTRL_IT_MASK;
=20
@@ -753,8 +628,8 @@ static __always_inline void set_next_event(const int acce=
ss, unsigned long evt,
 	else
 		cnt =3D __arch_counter_get_cntvct();
=20
-	arch_timer_reg_write(access, ARCH_TIMER_REG_CVAL, evt + cnt, clk);
-	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
+	arch_timer_reg_write_cp15(access, ARCH_TIMER_REG_CVAL, evt + cnt);
+	arch_timer_reg_write_cp15(access, ARCH_TIMER_REG_CTRL, ctrl);
 }
=20
 static int arch_timer_set_next_event_virt(unsigned long evt,
@@ -771,60 +646,6 @@ static int arch_timer_set_next_event_phys(unsigned long =
evt,
 	return 0;
 }
=20
-static noinstr u64 arch_counter_get_cnt_mem(struct arch_timer *t, int offset=
_lo)
-{
-	u32 cnt_lo, cnt_hi, tmp_hi;
-
-	do {
-		cnt_hi =3D __le32_to_cpu((__le32 __force)__raw_readl(t->base + offset_lo +=
 4));
-		cnt_lo =3D __le32_to_cpu((__le32 __force)__raw_readl(t->base + offset_lo));
-		tmp_hi =3D __le32_to_cpu((__le32 __force)__raw_readl(t->base + offset_lo +=
 4));
-	} while (cnt_hi !=3D tmp_hi);
-
-	return ((u64) cnt_hi << 32) | cnt_lo;
-}
-
-static __always_inline void set_next_event_mem(const int access, unsigned lo=
ng evt,
-					   struct clock_event_device *clk)
-{
-	struct arch_timer *timer =3D to_arch_timer(clk);
-	unsigned long ctrl;
-	u64 cnt;
-
-	ctrl =3D arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, clk);
-
-	/* Timer must be disabled before programming CVAL */
-	if (ctrl & ARCH_TIMER_CTRL_ENABLE) {
-		ctrl &=3D ~ARCH_TIMER_CTRL_ENABLE;
-		arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
-	}
-
-	ctrl |=3D ARCH_TIMER_CTRL_ENABLE;
-	ctrl &=3D ~ARCH_TIMER_CTRL_IT_MASK;
-
-	if (access =3D=3D  ARCH_TIMER_MEM_VIRT_ACCESS)
-		cnt =3D arch_counter_get_cnt_mem(timer, CNTVCT_LO);
-	else
-		cnt =3D arch_counter_get_cnt_mem(timer, CNTPCT_LO);
-
-	arch_timer_reg_write(access, ARCH_TIMER_REG_CVAL, evt + cnt, clk);
-	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
-}
-
-static int arch_timer_set_next_event_virt_mem(unsigned long evt,
-					      struct clock_event_device *clk)
-{
-	set_next_event_mem(ARCH_TIMER_MEM_VIRT_ACCESS, evt, clk);
-	return 0;
-}
-
-static int arch_timer_set_next_event_phys_mem(unsigned long evt,
-					      struct clock_event_device *clk)
-{
-	set_next_event_mem(ARCH_TIMER_MEM_PHYS_ACCESS, evt, clk);
-	return 0;
-}
-
 static u64 __arch_timer_check_delta(void)
 {
 #ifdef CONFIG_ARM64
@@ -850,63 +671,41 @@ static u64 __arch_timer_check_delta(void)
 	return CLOCKSOURCE_MASK(arch_counter_get_width());
 }
=20
-static void __arch_timer_setup(unsigned type,
-			       struct clock_event_device *clk)
+static void __arch_timer_setup(struct clock_event_device *clk)
 {
+	typeof(clk->set_next_event) sne;
 	u64 max_delta;
=20
 	clk->features =3D CLOCK_EVT_FEAT_ONESHOT;
=20
-	if (type =3D=3D ARCH_TIMER_TYPE_CP15) {
-		typeof(clk->set_next_event) sne;
-
-		arch_timer_check_ool_workaround(ate_match_local_cap_id, NULL);
-
-		if (arch_timer_c3stop)
-			clk->features |=3D CLOCK_EVT_FEAT_C3STOP;
-		clk->name =3D "arch_sys_timer";
-		clk->rating =3D 450;
-		clk->cpumask =3D cpumask_of(smp_processor_id());
-		clk->irq =3D arch_timer_ppi[arch_timer_uses_ppi];
-		switch (arch_timer_uses_ppi) {
-		case ARCH_TIMER_VIRT_PPI:
-			clk->set_state_shutdown =3D arch_timer_shutdown_virt;
-			clk->set_state_oneshot_stopped =3D arch_timer_shutdown_virt;
-			sne =3D erratum_handler(set_next_event_virt);
-			break;
-		case ARCH_TIMER_PHYS_SECURE_PPI:
-		case ARCH_TIMER_PHYS_NONSECURE_PPI:
-		case ARCH_TIMER_HYP_PPI:
-			clk->set_state_shutdown =3D arch_timer_shutdown_phys;
-			clk->set_state_oneshot_stopped =3D arch_timer_shutdown_phys;
-			sne =3D erratum_handler(set_next_event_phys);
-			break;
-		default:
-			BUG();
-		}
+	arch_timer_check_ool_workaround(ate_match_local_cap_id, NULL);
=20
-		clk->set_next_event =3D sne;
-		max_delta =3D __arch_timer_check_delta();
-	} else {
-		clk->features |=3D CLOCK_EVT_FEAT_DYNIRQ;
-		clk->name =3D "arch_mem_timer";
-		clk->rating =3D 400;
-		clk->cpumask =3D cpu_possible_mask;
-		if (arch_timer_mem_use_virtual) {
-			clk->set_state_shutdown =3D arch_timer_shutdown_virt_mem;
-			clk->set_state_oneshot_stopped =3D arch_timer_shutdown_virt_mem;
-			clk->set_next_event =3D
-				arch_timer_set_next_event_virt_mem;
-		} else {
-			clk->set_state_shutdown =3D arch_timer_shutdown_phys_mem;
-			clk->set_state_oneshot_stopped =3D arch_timer_shutdown_phys_mem;
-			clk->set_next_event =3D
-				arch_timer_set_next_event_phys_mem;
-		}
-
-		max_delta =3D CLOCKSOURCE_MASK(56);
+	if (arch_timer_c3stop)
+		clk->features |=3D CLOCK_EVT_FEAT_C3STOP;
+	clk->name =3D "arch_sys_timer";
+	clk->rating =3D 450;
+	clk->cpumask =3D cpumask_of(smp_processor_id());
+	clk->irq =3D arch_timer_ppi[arch_timer_uses_ppi];
+	switch (arch_timer_uses_ppi) {
+	case ARCH_TIMER_VIRT_PPI:
+		clk->set_state_shutdown =3D arch_timer_shutdown_virt;
+		clk->set_state_oneshot_stopped =3D arch_timer_shutdown_virt;
+		sne =3D erratum_handler(set_next_event_virt);
+		break;
+	case ARCH_TIMER_PHYS_SECURE_PPI:
+	case ARCH_TIMER_PHYS_NONSECURE_PPI:
+	case ARCH_TIMER_HYP_PPI:
+		clk->set_state_shutdown =3D arch_timer_shutdown_phys;
+		clk->set_state_oneshot_stopped =3D arch_timer_shutdown_phys;
+		sne =3D erratum_handler(set_next_event_phys);
+		break;
+	default:
+		BUG();
 	}
=20
+	clk->set_next_event =3D sne;
+	max_delta =3D __arch_timer_check_delta();
+
 	clk->set_state_shutdown(clk);
=20
 	clockevents_config_and_register(clk, arch_timer_rate, 0xf, max_delta);
@@ -1029,7 +828,7 @@ static int arch_timer_starting_cpu(unsigned int cpu)
 	struct clock_event_device *clk =3D this_cpu_ptr(arch_timer_evt);
 	u32 flags;
=20
-	__arch_timer_setup(ARCH_TIMER_TYPE_CP15, clk);
+	__arch_timer_setup(clk);
=20
 	flags =3D check_ppi_trigger(arch_timer_ppi[arch_timer_uses_ppi]);
 	enable_percpu_irq(arch_timer_ppi[arch_timer_uses_ppi], flags);
@@ -1075,22 +874,12 @@ static void __init arch_timer_of_configure_rate(u32 ra=
te, struct device_node *np
 		pr_warn("frequency not available\n");
 }
=20
-static void __init arch_timer_banner(unsigned type)
+static void __init arch_timer_banner(void)
 {
-	pr_info("%s%s%s timer(s) running at %lu.%02luMHz (%s%s%s).\n",
-		type & ARCH_TIMER_TYPE_CP15 ? "cp15" : "",
-		type =3D=3D (ARCH_TIMER_TYPE_CP15 | ARCH_TIMER_TYPE_MEM) ?
-			" and " : "",
-		type & ARCH_TIMER_TYPE_MEM ? "mmio" : "",
+	pr_info("cp15 timer running at %lu.%02luMHz (%s).\n",
 		(unsigned long)arch_timer_rate / 1000000,
 		(unsigned long)(arch_timer_rate / 10000) % 100,
-		type & ARCH_TIMER_TYPE_CP15 ?
-			(arch_timer_uses_ppi =3D=3D ARCH_TIMER_VIRT_PPI) ? "virt" : "phys" :
-			"",
-		type =3D=3D (ARCH_TIMER_TYPE_CP15 | ARCH_TIMER_TYPE_MEM) ? "/" : "",
-		type & ARCH_TIMER_TYPE_MEM ?
-			arch_timer_mem_use_virtual ? "virt" : "phys" :
-			"");
+		(arch_timer_uses_ppi =3D=3D ARCH_TIMER_VIRT_PPI) ? "virt" : "phys");
 }
=20
 u32 arch_timer_get_rate(void)
@@ -1108,11 +897,6 @@ bool arch_timer_evtstrm_available(void)
 	return cpumask_test_cpu(raw_smp_processor_id(), &evtstrm_available);
 }
=20
-static noinstr u64 arch_counter_get_cntvct_mem(void)
-{
-	return arch_counter_get_cnt_mem(arch_timer_mem, CNTVCT_LO);
-}
-
 static struct arch_timer_kvm_info arch_timer_kvm_info;
=20
 struct arch_timer_kvm_info *arch_timer_get_kvm_info(void)
@@ -1120,42 +904,35 @@ struct arch_timer_kvm_info *arch_timer_get_kvm_info(vo=
id)
 	return &arch_timer_kvm_info;
 }
=20
-static void __init arch_counter_register(unsigned type)
+static void __init arch_counter_register(void)
 {
 	u64 (*scr)(void);
+	u64 (*rd)(void);
 	u64 start_count;
 	int width;
=20
-	/* Register the CP15 based counter if we have one */
-	if (type & ARCH_TIMER_TYPE_CP15) {
-		u64 (*rd)(void);
-
-		if ((IS_ENABLED(CONFIG_ARM64) && !is_hyp_mode_available()) ||
-		    arch_timer_uses_ppi =3D=3D ARCH_TIMER_VIRT_PPI) {
-			if (arch_timer_counter_has_wa()) {
-				rd =3D arch_counter_get_cntvct_stable;
-				scr =3D raw_counter_get_cntvct_stable;
-			} else {
-				rd =3D arch_counter_get_cntvct;
-				scr =3D arch_counter_get_cntvct;
-			}
+	if ((IS_ENABLED(CONFIG_ARM64) && !is_hyp_mode_available()) ||
+	    arch_timer_uses_ppi =3D=3D ARCH_TIMER_VIRT_PPI) {
+		if (arch_timer_counter_has_wa()) {
+			rd =3D arch_counter_get_cntvct_stable;
+			scr =3D raw_counter_get_cntvct_stable;
 		} else {
-			if (arch_timer_counter_has_wa()) {
-				rd =3D arch_counter_get_cntpct_stable;
-				scr =3D raw_counter_get_cntpct_stable;
-			} else {
-				rd =3D arch_counter_get_cntpct;
-				scr =3D arch_counter_get_cntpct;
-			}
+			rd =3D arch_counter_get_cntvct;
+			scr =3D arch_counter_get_cntvct;
 		}
-
-		arch_timer_read_counter =3D rd;
-		clocksource_counter.vdso_clock_mode =3D vdso_default;
 	} else {
-		arch_timer_read_counter =3D arch_counter_get_cntvct_mem;
-		scr =3D arch_counter_get_cntvct_mem;
+		if (arch_timer_counter_has_wa()) {
+			rd =3D arch_counter_get_cntpct_stable;
+			scr =3D raw_counter_get_cntpct_stable;
+		} else {
+			rd =3D arch_counter_get_cntpct;
+			scr =3D arch_counter_get_cntpct;
+		}
 	}
=20
+	arch_timer_read_counter =3D rd;
+	clocksource_counter.vdso_clock_mode =3D vdso_default;
+
 	width =3D arch_counter_get_width();
 	clocksource_counter.mask =3D CLOCKSOURCE_MASK(width);
 	cyclecounter.mask =3D CLOCKSOURCE_MASK(width);
@@ -1303,76 +1080,10 @@ static int __init arch_timer_register(void)
 	return err;
 }
=20
-static int __init arch_timer_mem_register(void __iomem *base, unsigned int i=
rq)
-{
-	int ret;
-	irq_handler_t func;
-
-	arch_timer_mem =3D kzalloc(sizeof(*arch_timer_mem), GFP_KERNEL);
-	if (!arch_timer_mem)
-		return -ENOMEM;
-
-	arch_timer_mem->base =3D base;
-	arch_timer_mem->evt.irq =3D irq;
-	__arch_timer_setup(ARCH_TIMER_TYPE_MEM, &arch_timer_mem->evt);
-
-	if (arch_timer_mem_use_virtual)
-		func =3D arch_timer_handler_virt_mem;
-	else
-		func =3D arch_timer_handler_phys_mem;
-
-	ret =3D request_irq(irq, func, IRQF_TIMER, "arch_mem_timer", &arch_timer_me=
m->evt);
-	if (ret) {
-		pr_err("Failed to request mem timer irq\n");
-		kfree(arch_timer_mem);
-		arch_timer_mem =3D NULL;
-	}
-
-	return ret;
-}
-
-static const struct of_device_id arch_timer_of_match[] __initconst =3D {
-	{ .compatible   =3D "arm,armv7-timer",    },
-	{ .compatible   =3D "arm,armv8-timer",    },
-	{},
-};
-
-static const struct of_device_id arch_timer_mem_of_match[] __initconst =3D {
-	{ .compatible   =3D "arm,armv7-timer-mem", },
-	{},
-};
-
-static bool __init arch_timer_needs_of_probing(void)
-{
-	struct device_node *dn;
-	bool needs_probing =3D false;
-	unsigned int mask =3D ARCH_TIMER_TYPE_CP15 | ARCH_TIMER_TYPE_MEM;
-
-	/* We have two timers, and both device-tree nodes are probed. */
-	if ((arch_timers_present & mask) =3D=3D mask)
-		return false;
-
-	/*
-	 * Only one type of timer is probed,
-	 * check if we have another type of timer node in device-tree.
-	 */
-	if (arch_timers_present & ARCH_TIMER_TYPE_CP15)
-		dn =3D of_find_matching_node(NULL, arch_timer_mem_of_match);
-	else
-		dn =3D of_find_matching_node(NULL, arch_timer_of_match);
-
-	if (dn && of_device_is_available(dn))
-		needs_probing =3D true;
-
-	of_node_put(dn);
-
-	return needs_probing;
-}
-
 static int __init arch_timer_common_init(void)
 {
-	arch_timer_banner(arch_timers_present);
-	arch_counter_register(arch_timers_present);
+	arch_timer_banner();
+	arch_counter_register();
 	return arch_timer_arch_init();
 }
=20
@@ -1421,13 +1132,11 @@ static int __init arch_timer_of_init(struct device_no=
de *np)
 	u32 rate;
 	bool has_names;
=20
-	if (arch_timers_present & ARCH_TIMER_TYPE_CP15) {
+	if (arch_timer_evt) {
 		pr_warn("multiple nodes in dt, skipping\n");
 		return 0;
 	}
=20
-	arch_timers_present |=3D ARCH_TIMER_TYPE_CP15;
-
 	has_names =3D of_property_present(np, "interrupt-names");
=20
 	for (i =3D ARCH_TIMER_PHYS_SECURE_PPI; i < ARCH_TIMER_MAX_TIMER_PPI; i++) {
@@ -1472,283 +1181,22 @@ static int __init arch_timer_of_init(struct device_n=
ode *np)
 	if (ret)
 		return ret;
=20
-	if (arch_timer_needs_of_probing())
-		return 0;
-
 	return arch_timer_common_init();
 }
 TIMER_OF_DECLARE(armv7_arch_timer, "arm,armv7-timer", arch_timer_of_init);
 TIMER_OF_DECLARE(armv8_arch_timer, "arm,armv8-timer", arch_timer_of_init);
=20
-static u32 __init
-arch_timer_mem_frame_get_cntfrq(struct arch_timer_mem_frame *frame)
-{
-	void __iomem *base;
-	u32 rate;
-
-	base =3D ioremap(frame->cntbase, frame->size);
-	if (!base) {
-		pr_err("Unable to map frame @ %pa\n", &frame->cntbase);
-		return 0;
-	}
-
-	rate =3D readl_relaxed(base + CNTFRQ);
-
-	iounmap(base);
-
-	return rate;
-}
-
-static struct arch_timer_mem_frame * __init
-arch_timer_mem_find_best_frame(struct arch_timer_mem *timer_mem)
-{
-	struct arch_timer_mem_frame *frame, *best_frame =3D NULL;
-	void __iomem *cntctlbase;
-	u32 cnttidr;
-	int i;
-
-	cntctlbase =3D ioremap(timer_mem->cntctlbase, timer_mem->size);
-	if (!cntctlbase) {
-		pr_err("Can't map CNTCTLBase @ %pa\n",
-			&timer_mem->cntctlbase);
-		return NULL;
-	}
-
-	cnttidr =3D readl_relaxed(cntctlbase + CNTTIDR);
-
-	/*
-	 * Try to find a virtual capable frame. Otherwise fall back to a
-	 * physical capable frame.
-	 */
-	for (i =3D 0; i < ARCH_TIMER_MEM_MAX_FRAMES; i++) {
-		u32 cntacr =3D CNTACR_RFRQ | CNTACR_RWPT | CNTACR_RPCT |
-			     CNTACR_RWVT | CNTACR_RVOFF | CNTACR_RVCT;
-
-		frame =3D &timer_mem->frame[i];
-		if (!frame->valid)
-			continue;
-
-		/* Try enabling everything, and see what sticks */
-		writel_relaxed(cntacr, cntctlbase + CNTACR(i));
-		cntacr =3D readl_relaxed(cntctlbase + CNTACR(i));
-
-		if ((cnttidr & CNTTIDR_VIRT(i)) &&
-		    !(~cntacr & (CNTACR_RWVT | CNTACR_RVCT))) {
-			best_frame =3D frame;
-			arch_timer_mem_use_virtual =3D true;
-			break;
-		}
-
-		if (~cntacr & (CNTACR_RWPT | CNTACR_RPCT))
-			continue;
-
-		best_frame =3D frame;
-	}
-
-	iounmap(cntctlbase);
-
-	return best_frame;
-}
-
-static int __init
-arch_timer_mem_frame_register(struct arch_timer_mem_frame *frame)
-{
-	void __iomem *base;
-	int ret, irq;
-
-	if (arch_timer_mem_use_virtual)
-		irq =3D frame->virt_irq;
-	else
-		irq =3D frame->phys_irq;
-
-	if (!irq) {
-		pr_err("Frame missing %s irq.\n",
-		       arch_timer_mem_use_virtual ? "virt" : "phys");
-		return -EINVAL;
-	}
-
-	if (!request_mem_region(frame->cntbase, frame->size,
-				"arch_mem_timer"))
-		return -EBUSY;
-
-	base =3D ioremap(frame->cntbase, frame->size);
-	if (!base) {
-		pr_err("Can't map frame's registers\n");
-		return -ENXIO;
-	}
-
-	ret =3D arch_timer_mem_register(base, irq);
-	if (ret) {
-		iounmap(base);
-		return ret;
-	}
-
-	arch_timers_present |=3D ARCH_TIMER_TYPE_MEM;
-
-	return 0;
-}
-
-static int __init arch_timer_mem_of_init(struct device_node *np)
-{
-	struct arch_timer_mem *timer_mem;
-	struct arch_timer_mem_frame *frame;
-	struct resource res;
-	int ret =3D -EINVAL;
-	u32 rate;
-
-	timer_mem =3D kzalloc(sizeof(*timer_mem), GFP_KERNEL);
-	if (!timer_mem)
-		return -ENOMEM;
-
-	if (of_address_to_resource(np, 0, &res))
-		goto out;
-	timer_mem->cntctlbase =3D res.start;
-	timer_mem->size =3D resource_size(&res);
-
-	for_each_available_child_of_node_scoped(np, frame_node) {
-		u32 n;
-		struct arch_timer_mem_frame *frame;
-
-		if (of_property_read_u32(frame_node, "frame-number", &n)) {
-			pr_err(FW_BUG "Missing frame-number.\n");
-			goto out;
-		}
-		if (n >=3D ARCH_TIMER_MEM_MAX_FRAMES) {
-			pr_err(FW_BUG "Wrong frame-number, only 0-%u are permitted.\n",
-			       ARCH_TIMER_MEM_MAX_FRAMES - 1);
-			goto out;
-		}
-		frame =3D &timer_mem->frame[n];
-
-		if (frame->valid) {
-			pr_err(FW_BUG "Duplicated frame-number.\n");
-			goto out;
-		}
-
-		if (of_address_to_resource(frame_node, 0, &res))
-			goto out;
-
-		frame->cntbase =3D res.start;
-		frame->size =3D resource_size(&res);
-
-		frame->virt_irq =3D irq_of_parse_and_map(frame_node,
-						       ARCH_TIMER_VIRT_SPI);
-		frame->phys_irq =3D irq_of_parse_and_map(frame_node,
-						       ARCH_TIMER_PHYS_SPI);
-
-		frame->valid =3D true;
-	}
-
-	frame =3D arch_timer_mem_find_best_frame(timer_mem);
-	if (!frame) {
-		pr_err("Unable to find a suitable frame in timer @ %pa\n",
-			&timer_mem->cntctlbase);
-		ret =3D -EINVAL;
-		goto out;
-	}
-
-	rate =3D arch_timer_mem_frame_get_cntfrq(frame);
-	arch_timer_of_configure_rate(rate, np);
-
-	ret =3D arch_timer_mem_frame_register(frame);
-	if (!ret && !arch_timer_needs_of_probing())
-		ret =3D arch_timer_common_init();
-out:
-	kfree(timer_mem);
-	return ret;
-}
-TIMER_OF_DECLARE(armv7_arch_timer_mem, "arm,armv7-timer-mem",
-		       arch_timer_mem_of_init);
-
 #ifdef CONFIG_ACPI_GTDT
-static int __init
-arch_timer_mem_verify_cntfrq(struct arch_timer_mem *timer_mem)
-{
-	struct arch_timer_mem_frame *frame;
-	u32 rate;
-	int i;
-
-	for (i =3D 0; i < ARCH_TIMER_MEM_MAX_FRAMES; i++) {
-		frame =3D &timer_mem->frame[i];
-
-		if (!frame->valid)
-			continue;
-
-		rate =3D arch_timer_mem_frame_get_cntfrq(frame);
-		if (rate =3D=3D arch_timer_rate)
-			continue;
-
-		pr_err(FW_BUG "CNTFRQ mismatch: frame @ %pa: (0x%08lx), CPU: (0x%08lx)\n",
-			&frame->cntbase,
-			(unsigned long)rate, (unsigned long)arch_timer_rate);
-
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int __init arch_timer_mem_acpi_init(int platform_timer_count)
-{
-	struct arch_timer_mem *timers, *timer;
-	struct arch_timer_mem_frame *frame, *best_frame =3D NULL;
-	int timer_count, i, ret =3D 0;
-
-	timers =3D kcalloc(platform_timer_count, sizeof(*timers),
-			    GFP_KERNEL);
-	if (!timers)
-		return -ENOMEM;
-
-	ret =3D acpi_arch_timer_mem_init(timers, &timer_count);
-	if (ret || !timer_count)
-		goto out;
-
-	/*
-	 * While unlikely, it's theoretically possible that none of the frames
-	 * in a timer expose the combination of feature we want.
-	 */
-	for (i =3D 0; i < timer_count; i++) {
-		timer =3D &timers[i];
-
-		frame =3D arch_timer_mem_find_best_frame(timer);
-		if (!best_frame)
-			best_frame =3D frame;
-
-		ret =3D arch_timer_mem_verify_cntfrq(timer);
-		if (ret) {
-			pr_err("Disabling MMIO timers due to CNTFRQ mismatch\n");
-			goto out;
-		}
-
-		if (!best_frame) /* implies !frame */
-			/*
-			 * Only complain about missing suitable frames if we
-			 * haven't already found one in a previous iteration.
-			 */
-			pr_err("Unable to find a suitable frame in timer @ %pa\n",
-				&timer->cntctlbase);
-	}
-
-	if (best_frame)
-		ret =3D arch_timer_mem_frame_register(best_frame);
-out:
-	kfree(timers);
-	return ret;
-}
-
-/* Initialize per-processor generic timer and memory-mapped timer(if present=
) */
 static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 {
-	int ret, platform_timer_count;
+	int ret;
=20
-	if (arch_timers_present & ARCH_TIMER_TYPE_CP15) {
+	if (arch_timer_evt) {
 		pr_warn("already initialized, skipping\n");
 		return -EINVAL;
 	}
=20
-	arch_timers_present |=3D ARCH_TIMER_TYPE_CP15;
-
-	ret =3D acpi_gtdt_init(table, &platform_timer_count);
+	ret =3D acpi_gtdt_init(table, NULL);
 	if (ret)
 		return ret;
=20
@@ -1790,10 +1238,6 @@ static int __init arch_timer_acpi_init(struct acpi_tab=
le_header *table)
 	if (ret)
 		return ret;
=20
-	if (platform_timer_count &&
-	    arch_timer_mem_acpi_init(platform_timer_count))
-		pr_err("Failed to initialize memory-mapped timer.\n");
-
 	return arch_timer_common_init();
 }
 TIMER_ACPI_DECLARE(arch_timer, ACPI_SIG_GTDT, arch_timer_acpi_init);
diff --git a/drivers/clocksource/arm_arch_timer_mmio.c b/drivers/clocksource/=
arm_arch_timer_mmio.c
new file mode 100644
index 000000000000..ebe1987d651e
--- /dev/null
+++ b/drivers/clocksource/arm_arch_timer_mmio.c
@@ -0,0 +1,440 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  ARM Generic Memory Mapped Timer support
+ *
+ *  Split from drivers/clocksource/arm_arch_timer.c
+ *
+ *  Copyright (C) 2011 ARM Ltd.
+ *  All Rights Reserved
+ */
+
+#define pr_fmt(fmt) 	"arch_timer_mmio: " fmt
+
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+
+#include <clocksource/arm_arch_timer.h>
+
+#define CNTTIDR		0x08
+#define CNTTIDR_VIRT(n)	(BIT(1) << ((n) * 4))
+
+#define CNTACR(n)	(0x40 + ((n) * 4))
+#define CNTACR_RPCT	BIT(0)
+#define CNTACR_RVCT	BIT(1)
+#define CNTACR_RFRQ	BIT(2)
+#define CNTACR_RVOFF	BIT(3)
+#define CNTACR_RWVT	BIT(4)
+#define CNTACR_RWPT	BIT(5)
+
+#define CNTPCT_LO	0x00
+#define CNTVCT_LO	0x08
+#define CNTFRQ		0x10
+#define CNTP_CVAL_LO	0x20
+#define CNTP_CTL	0x2c
+#define CNTV_CVAL_LO	0x30
+#define CNTV_CTL	0x3c
+
+enum arch_timer_access {
+	PHYS_ACCESS,
+	VIRT_ACCESS,
+};
+
+struct arch_timer {
+	struct clock_event_device	evt;
+	struct clocksource		cs;
+	struct arch_timer_mem		*gt_block;
+	void __iomem			*base;
+	enum arch_timer_access		access;
+	u32				rate;
+};
+
+#define evt_to_arch_timer(e) container_of(e, struct arch_timer, evt)
+#define cs_to_arch_timer(c) container_of(c, struct arch_timer, cs)
+
+static void arch_timer_mmio_write(struct arch_timer *timer,
+				  enum arch_timer_reg reg, u64 val)
+{
+	switch (timer->access) {
+	case PHYS_ACCESS:
+		switch (reg) {
+		case ARCH_TIMER_REG_CTRL:
+			writel_relaxed((u32)val, timer->base + CNTP_CTL);
+			return;
+		case ARCH_TIMER_REG_CVAL:
+			/*
+			 * Not guaranteed to be atomic, so the timer
+			 * must be disabled at this point.
+			 */
+			writeq_relaxed(val, timer->base + CNTP_CVAL_LO);
+			return;
+		}
+		break;
+	case VIRT_ACCESS:
+		switch (reg) {
+		case ARCH_TIMER_REG_CTRL:
+			writel_relaxed((u32)val, timer->base + CNTV_CTL);
+			return;
+		case ARCH_TIMER_REG_CVAL:
+			/* Same restriction as above */
+			writeq_relaxed(val, timer->base + CNTV_CVAL_LO);
+			return;
+		}
+		break;
+	}
+
+	/* Should never be here */
+	WARN_ON_ONCE(1);
+}
+
+static u32 arch_timer_mmio_read(struct arch_timer *timer, enum arch_timer_re=
g reg)
+{
+	switch (timer->access) {
+	case PHYS_ACCESS:
+		switch (reg) {
+		case ARCH_TIMER_REG_CTRL:
+			return readl_relaxed(timer->base + CNTP_CTL);
+		default:
+			break;
+		}
+		break;
+	case VIRT_ACCESS:
+		switch (reg) {
+		case ARCH_TIMER_REG_CTRL:
+			return readl_relaxed(timer->base + CNTV_CTL);
+		default:
+			break;
+		}
+		break;
+	}
+
+	/* Should never be here */
+	WARN_ON_ONCE(1);
+	return 0;
+}
+
+static noinstr u64 arch_counter_mmio_get_cnt(struct arch_timer *t)
+{
+	int offset_lo =3D t->access =3D=3D VIRT_ACCESS ? CNTVCT_LO : CNTPCT_LO;
+	u32 cnt_lo, cnt_hi, tmp_hi;
+
+	do {
+		cnt_hi =3D __le32_to_cpu((__le32 __force)__raw_readl(t->base + offset_lo +=
 4));
+		cnt_lo =3D __le32_to_cpu((__le32 __force)__raw_readl(t->base + offset_lo));
+		tmp_hi =3D __le32_to_cpu((__le32 __force)__raw_readl(t->base + offset_lo +=
 4));
+	} while (cnt_hi !=3D tmp_hi);
+
+	return ((u64) cnt_hi << 32) | cnt_lo;
+}
+
+static u64 arch_mmio_counter_read(struct clocksource *cs)
+{
+	struct arch_timer *at =3D cs_to_arch_timer(cs);
+
+	return arch_counter_mmio_get_cnt(at);
+}
+
+static int arch_timer_mmio_shutdown(struct clock_event_device *clk)
+{
+	struct arch_timer *at =3D evt_to_arch_timer(clk);
+	unsigned long ctrl;
+
+	ctrl =3D arch_timer_mmio_read(at, ARCH_TIMER_REG_CTRL);
+	ctrl &=3D ~ARCH_TIMER_CTRL_ENABLE;
+	arch_timer_mmio_write(at, ARCH_TIMER_REG_CTRL, ctrl);
+
+	return 0;
+}
+
+static int arch_timer_mmio_set_next_event(unsigned long evt,
+					  struct clock_event_device *clk)
+{
+	struct arch_timer *timer =3D evt_to_arch_timer(clk);
+	unsigned long ctrl;
+	u64 cnt;
+
+	ctrl =3D arch_timer_mmio_read(timer, ARCH_TIMER_REG_CTRL);
+
+	/* Timer must be disabled before programming CVAL */
+	if (ctrl & ARCH_TIMER_CTRL_ENABLE) {
+		ctrl &=3D ~ARCH_TIMER_CTRL_ENABLE;
+		arch_timer_mmio_write(timer, ARCH_TIMER_REG_CTRL, ctrl);
+	}
+
+	ctrl |=3D ARCH_TIMER_CTRL_ENABLE;
+	ctrl &=3D ~ARCH_TIMER_CTRL_IT_MASK;
+
+	cnt =3D arch_counter_mmio_get_cnt(timer);
+
+	arch_timer_mmio_write(timer, ARCH_TIMER_REG_CVAL, evt + cnt);
+	arch_timer_mmio_write(timer, ARCH_TIMER_REG_CTRL, ctrl);
+	return 0;
+}
+
+static irqreturn_t arch_timer_mmio_handler(int irq, void *dev_id)
+{
+	struct clock_event_device *evt =3D dev_id;
+	struct arch_timer *at =3D evt_to_arch_timer(evt);
+	unsigned long ctrl;
+
+	ctrl =3D arch_timer_mmio_read(at, ARCH_TIMER_REG_CTRL);
+	if (ctrl & ARCH_TIMER_CTRL_IT_STAT) {
+		ctrl |=3D ARCH_TIMER_CTRL_IT_MASK;
+		arch_timer_mmio_write(at, ARCH_TIMER_REG_CTRL, ctrl);
+		evt->event_handler(evt);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static struct arch_timer_mem_frame *find_best_frame(struct platform_device *=
pdev)
+{
+	struct arch_timer_mem_frame *frame, *best_frame =3D NULL;
+	struct arch_timer *at =3D platform_get_drvdata(pdev);
+	void __iomem *cntctlbase;
+	u32 cnttidr;
+
+	cntctlbase =3D ioremap(at->gt_block->cntctlbase, at->gt_block->size);
+	if (!cntctlbase) {
+		dev_err(&pdev->dev, "Can't map CNTCTLBase @ %pa\n",
+			&at->gt_block->cntctlbase);
+		return NULL;
+	}
+
+	cnttidr =3D readl_relaxed(cntctlbase + CNTTIDR);
+
+	/*
+	 * Try to find a virtual capable frame. Otherwise fall back to a
+	 * physical capable frame.
+	 */
+	for (int i =3D 0; i < ARCH_TIMER_MEM_MAX_FRAMES; i++) {
+		u32 cntacr =3D CNTACR_RFRQ | CNTACR_RWPT | CNTACR_RPCT |
+			     CNTACR_RWVT | CNTACR_RVOFF | CNTACR_RVCT;
+
+		frame =3D &at->gt_block->frame[i];
+		if (!frame->valid)
+			continue;
+
+		/* Try enabling everything, and see what sticks */
+		writel_relaxed(cntacr, cntctlbase + CNTACR(i));
+		cntacr =3D readl_relaxed(cntctlbase + CNTACR(i));
+
+		/* Pick a suitable frame for which we have an IRQ */
+		if ((cnttidr & CNTTIDR_VIRT(i)) &&
+		    !(~cntacr & (CNTACR_RWVT | CNTACR_RVCT)) &&
+		    frame->virt_irq) {
+			best_frame =3D frame;
+			at->access =3D VIRT_ACCESS;
+			break;
+		}
+
+		if ((~cntacr & (CNTACR_RWPT | CNTACR_RPCT)) ||
+		     !frame->phys_irq)
+			continue;
+
+		at->access =3D PHYS_ACCESS;
+		best_frame =3D frame;
+	}
+
+	iounmap(cntctlbase);
+
+	return best_frame;
+}
+
+static void arch_timer_mmio_setup(struct arch_timer *at, int irq)
+{
+	at->evt =3D (struct clock_event_device) {
+		.features		   =3D (CLOCK_EVT_FEAT_ONESHOT |
+					      CLOCK_EVT_FEAT_DYNIRQ),
+		.name			   =3D "arch_mem_timer",
+		.rating			   =3D 400,
+		.cpumask		   =3D cpu_possible_mask,
+		.irq 			   =3D irq,
+		.set_next_event		   =3D arch_timer_mmio_set_next_event,
+		.set_state_oneshot_stopped =3D arch_timer_mmio_shutdown,
+		.set_state_shutdown	   =3D arch_timer_mmio_shutdown,
+	};
+
+	at->evt.set_state_shutdown(&at->evt);
+
+	clockevents_config_and_register(&at->evt, at->rate, 0xf,
+					(unsigned long)CLOCKSOURCE_MASK(56));
+
+	enable_irq(at->evt.irq);
+
+	at->cs =3D (struct clocksource) {
+		.name	=3D "arch_mmio_counter",
+		.rating	=3D 300,
+		.read	=3D arch_mmio_counter_read,
+		.mask	=3D CLOCKSOURCE_MASK(56),
+		.flags	=3D CLOCK_SOURCE_IS_CONTINUOUS,
+	};
+
+	clocksource_register_hz(&at->cs, at->rate);
+}
+
+static int arch_timer_mmio_frame_register(struct platform_device *pdev,
+					  struct arch_timer_mem_frame *frame)
+{
+	struct arch_timer *at =3D platform_get_drvdata(pdev);
+	struct device_node *np =3D pdev->dev.of_node;
+	int ret, irq;
+	u32 rate;
+
+	if (!devm_request_mem_region(&pdev->dev, frame->cntbase, frame->size,
+				     "arch_mem_timer"))
+		return -EBUSY;
+
+	at->base =3D devm_ioremap(&pdev->dev, frame->cntbase, frame->size);
+	if (!at->base) {
+		dev_err(&pdev->dev, "Can't map frame's registers\n");
+		return -ENXIO;
+	}
+
+	/*
+	 * Allow "clock-frequency" to override the probed rate. If neither
+	 * lead to something useful, use the CPU timer frequency as the
+	 * fallback. The nice thing about that last point is that we woudn't
+	 * made it here if we didn't have a valid frequency.
+	 */
+	rate =3D readl_relaxed(at->base + CNTFRQ);
+
+	if (!np || of_property_read_u32(np, "clock-frequency", &at->rate))
+		at->rate =3D rate;
+
+	if (!at->rate)
+		at->rate =3D arch_timer_get_rate();
+
+	irq =3D at->access =3D=3D VIRT_ACCESS ? frame->virt_irq : frame->phys_irq;
+	ret =3D devm_request_irq(&pdev->dev, irq, arch_timer_mmio_handler,
+			       IRQF_TIMER | IRQF_NO_AUTOEN, "arch_mem_timer",
+			       &at->evt);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to request mem timer irq\n");
+		return ret;
+	}
+
+	/* Afer this point, we're not allowed to fail anymore */
+	arch_timer_mmio_setup(at, irq);
+	return 0;
+}
+
+static int of_populate_gt_block(struct platform_device *pdev,
+				struct arch_timer *at)
+{
+	struct resource res;
+
+	if (of_address_to_resource(pdev->dev.of_node, 0, &res))
+		return -EINVAL;
+
+	at->gt_block->cntctlbase =3D res.start;
+	at->gt_block->size =3D resource_size(&res);
+
+	for_each_available_child_of_node_scoped(pdev->dev.of_node, frame_node) {
+		struct arch_timer_mem_frame *frame;
+		u32 n;
+
+		if (of_property_read_u32(frame_node, "frame-number", &n)) {
+			dev_err(&pdev->dev, FW_BUG "Missing frame-number\n");
+			return -EINVAL;
+		}
+		if (n >=3D ARCH_TIMER_MEM_MAX_FRAMES) {
+			dev_err(&pdev->dev,
+				FW_BUG "Wrong frame-number, only 0-%u are permitted\n",
+			       ARCH_TIMER_MEM_MAX_FRAMES - 1);
+			return -EINVAL;
+		}
+
+		frame =3D &at->gt_block->frame[n];
+
+		if (frame->valid) {
+			dev_err(&pdev->dev, FW_BUG "Duplicated frame-number\n");
+			return -EINVAL;
+		}
+
+		if (of_address_to_resource(frame_node, 0, &res))
+			return -EINVAL;
+
+		frame->cntbase =3D res.start;
+		frame->size =3D resource_size(&res);
+
+		frame->phys_irq =3D irq_of_parse_and_map(frame_node, 0);
+		frame->virt_irq =3D irq_of_parse_and_map(frame_node, 1);
+
+		frame->valid =3D true;
+	}
+
+	return 0;
+}
+
+static int arch_timer_mmio_probe(struct platform_device *pdev)
+{
+	struct arch_timer_mem_frame *frame;
+	struct arch_timer *at;
+	struct device_node *np;
+	int ret;
+
+	np =3D pdev->dev.of_node;
+
+	at =3D devm_kmalloc(&pdev->dev, sizeof(*at), GFP_KERNEL | __GFP_ZERO);
+	if (!at)
+		return -ENOMEM;
+
+	if (np) {
+		at->gt_block =3D devm_kmalloc(&pdev->dev, sizeof(*at->gt_block),
+					    GFP_KERNEL | __GFP_ZERO);
+		if (!at->gt_block)
+			return -ENOMEM;
+		ret =3D of_populate_gt_block(pdev, at);
+		if (ret)
+			return ret;
+	} else {
+		at->gt_block =3D dev_get_platdata(&pdev->dev);
+	}
+
+	platform_set_drvdata(pdev, at);
+
+	frame =3D find_best_frame(pdev);
+	if (!frame) {
+		dev_err(&pdev->dev,
+			"Unable to find a suitable frame in timer @ %pa\n",
+			&at->gt_block->cntctlbase);
+		return -EINVAL;
+	}
+
+	ret =3D arch_timer_mmio_frame_register(pdev, frame);
+	if (!ret)
+		dev_info(&pdev->dev,
+			 "mmio timer running at %lu.%02luMHz (%s)\n",
+			 (unsigned long)at->rate / 1000000,
+			 (unsigned long)(at->rate / 10000) % 100,
+			 at->access =3D=3D VIRT_ACCESS ? "virt" : "phys");
+
+	return ret;
+}
+
+static const struct of_device_id arch_timer_mmio_of_table[] =3D {
+	{ .compatible =3D "arm,armv7-timer-mem", },
+	{}
+};
+
+static struct platform_driver arch_timer_mmio_drv =3D {
+	.driver	=3D {
+		.name =3D "arch-timer-mmio",
+		.of_match_table	=3D arch_timer_mmio_of_table,
+	},
+	.probe	=3D arch_timer_mmio_probe,
+};
+builtin_platform_driver(arch_timer_mmio_drv);
+
+static struct platform_driver arch_timer_mmio_acpi_drv =3D {
+	.driver	=3D {
+		.name =3D "gtdt-arm-mmio-timer",
+	},
+	.probe	=3D arch_timer_mmio_probe,
+};
+builtin_platform_driver(arch_timer_mmio_acpi_drv);
diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm=
_global_timer.c
index 2d86bbc2764a..5e3d6bb7e437 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -263,14 +263,13 @@ static void __init gt_delay_timer_init(void)
 	register_current_timer_delay(&gt_delay_timer);
 }
=20
-static int __init gt_clocksource_init(void)
+static int __init gt_clocksource_init(unsigned int psv)
 {
 	writel(0, gt_base + GT_CONTROL);
 	writel(0, gt_base + GT_COUNTER0);
 	writel(0, gt_base + GT_COUNTER1);
 	/* set prescaler and enable timer on all the cores */
-	writel(FIELD_PREP(GT_CONTROL_PRESCALER_MASK,
-			  CONFIG_ARM_GT_INITIAL_PRESCALER_VAL - 1) |
+	writel(FIELD_PREP(GT_CONTROL_PRESCALER_MASK, psv - 1) |
 	       GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
=20
 #ifdef CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
@@ -338,11 +337,45 @@ static int gt_clk_rate_change_cb(struct notifier_block =
*nb,
 	return NOTIFY_DONE;
 }
=20
+struct gt_prescaler_config {
+	const char *compatible;
+	unsigned long prescaler;
+};
+
+static const struct gt_prescaler_config gt_prescaler_configs[] =3D {
+	/*
+	 * On am43 the global timer clock is a child of the clock used for CPU
+	 * OPPs, so the initial prescaler has to be compatible with all OPPs
+	 * which are 300, 600, 720, 800 and 1000 with a fixed divider of 2, this
+	 * gives us a GCD of 10. Initial frequency is 1000, so the prescaler is
+	 * 50.
+	 */
+	{ .compatible =3D "ti,am43", .prescaler =3D 50 },
+	{ .compatible =3D "xlnx,zynq-7000", .prescaler =3D 2 },
+	{ .compatible =3D NULL }
+};
+
+static unsigned long gt_get_initial_prescaler_value(struct device_node *np)
+{
+	const struct gt_prescaler_config *config;
+
+	if (CONFIG_ARM_GT_INITIAL_PRESCALER_VAL !=3D 0)
+		return CONFIG_ARM_GT_INITIAL_PRESCALER_VAL;
+
+	for (config =3D gt_prescaler_configs; config->compatible; config++) {
+		if (of_machine_is_compatible(config->compatible))
+			return config->prescaler;
+	}
+
+	return 1;
+}
+
 static int __init global_timer_of_register(struct device_node *np)
 {
 	struct clk *gt_clk;
 	static unsigned long gt_clk_rate;
 	int err;
+	unsigned long psv;
=20
 	/*
 	 * In A9 r2p0 the comparators for each processor with the global timer
@@ -378,8 +411,9 @@ static int __init global_timer_of_register(struct device_=
node *np)
 		goto out_unmap;
 	}
=20
+	psv =3D gt_get_initial_prescaler_value(np);
 	gt_clk_rate =3D clk_get_rate(gt_clk);
-	gt_target_rate =3D gt_clk_rate / CONFIG_ARM_GT_INITIAL_PRESCALER_VAL;
+	gt_target_rate =3D gt_clk_rate / psv;
 	gt_clk_rate_change_nb.notifier_call =3D
 		gt_clk_rate_change_cb;
 	err =3D clk_notifier_register(gt_clk, &gt_clk_rate_change_nb);
@@ -404,7 +438,7 @@ static int __init global_timer_of_register(struct device_=
node *np)
 	}
=20
 	/* Register and immediately configure the timer on the boot CPU */
-	err =3D gt_clocksource_init();
+	err =3D gt_clocksource_init(psv);
 	if (err)
 		goto out_irq;
=20
diff --git a/drivers/clocksource/clps711x-timer.c b/drivers/clocksource/clps7=
11x-timer.c
index e95fdc49c226..bbceb0289d45 100644
--- a/drivers/clocksource/clps711x-timer.c
+++ b/drivers/clocksource/clps711x-timer.c
@@ -78,24 +78,33 @@ static int __init clps711x_timer_init(struct device_node =
*np)
 	unsigned int irq =3D irq_of_parse_and_map(np, 0);
 	struct clk *clock =3D of_clk_get(np, 0);
 	void __iomem *base =3D of_iomap(np, 0);
+	int ret =3D 0;
=20
 	if (!base)
 		return -ENOMEM;
-	if (!irq)
-		return -EINVAL;
-	if (IS_ERR(clock))
-		return PTR_ERR(clock);
+	if (!irq) {
+		ret =3D -EINVAL;
+		goto unmap_io;
+	}
+	if (IS_ERR(clock)) {
+		ret =3D PTR_ERR(clock);
+		goto unmap_io;
+	}
=20
 	switch (of_alias_get_id(np, "timer")) {
 	case CLPS711X_CLKSRC_CLOCKSOURCE:
 		clps711x_clksrc_init(clock, base);
 		break;
 	case CLPS711X_CLKSRC_CLOCKEVENT:
-		return _clps711x_clkevt_init(clock, base, irq);
+		ret =3D  _clps711x_clkevt_init(clock, base, irq);
+		break;
 	default:
-		return -EINVAL;
+		ret =3D -EINVAL;
+		break;
 	}
=20
-	return 0;
+unmap_io:
+	iounmap(base);
+	return ret;
 }
 TIMER_OF_DECLARE(clps711x, "cirrus,ep7209-timer", clps711x_timer_init);
diff --git a/drivers/clocksource/ingenic-sysost.c b/drivers/clocksource/ingen=
ic-sysost.c
index cb6fc2f152d4..e79cfb0b8e05 100644
--- a/drivers/clocksource/ingenic-sysost.c
+++ b/drivers/clocksource/ingenic-sysost.c
@@ -127,18 +127,23 @@ static u8 ingenic_ost_get_prescale(unsigned long rate, =
unsigned long req_rate)
 	return 2; /* /16 divider */
 }
=20
-static long ingenic_ost_round_rate(struct clk_hw *hw, unsigned long req_rate,
-		unsigned long *parent_rate)
+static int ingenic_ost_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
 {
-	unsigned long rate =3D *parent_rate;
+	unsigned long rate =3D req->best_parent_rate;
 	u8 prescale;
=20
-	if (req_rate > rate)
-		return rate;
+	if (req->rate > rate) {
+		req->rate =3D rate;
=20
-	prescale =3D ingenic_ost_get_prescale(rate, req_rate);
+		return 0;
+	}
+
+	prescale =3D ingenic_ost_get_prescale(rate, req->rate);
=20
-	return rate >> (prescale * 2);
+	req->rate =3D rate >> (prescale * 2);
+
+	return 0;
 }
=20
 static int ingenic_ost_percpu_timer_set_rate(struct clk_hw *hw, unsigned lon=
g req_rate,
@@ -175,14 +180,14 @@ static int ingenic_ost_global_timer_set_rate(struct clk=
_hw *hw, unsigned long re
=20
 static const struct clk_ops ingenic_ost_percpu_timer_ops =3D {
 	.recalc_rate	=3D ingenic_ost_percpu_timer_recalc_rate,
-	.round_rate		=3D ingenic_ost_round_rate,
-	.set_rate		=3D ingenic_ost_percpu_timer_set_rate,
+	.determine_rate =3D ingenic_ost_determine_rate,
+	.set_rate	=3D ingenic_ost_percpu_timer_set_rate,
 };
=20
 static const struct clk_ops ingenic_ost_global_timer_ops =3D {
 	.recalc_rate	=3D ingenic_ost_global_timer_recalc_rate,
-	.round_rate		=3D ingenic_ost_round_rate,
-	.set_rate		=3D ingenic_ost_global_timer_set_rate,
+	.determine_rate =3D ingenic_ost_determine_rate,
+	.set_rate	=3D ingenic_ost_global_timer_set_rate,
 };
=20
 static const char * const ingenic_ost_clk_parents[] =3D { "ext" };
diff --git a/drivers/clocksource/scx200_hrt.c b/drivers/clocksource/scx200_hr=
t.c
index c3536fffbe9a..5a99801a1657 100644
--- a/drivers/clocksource/scx200_hrt.c
+++ b/drivers/clocksource/scx200_hrt.c
@@ -52,6 +52,7 @@ static struct clocksource cs_hrt =3D {
 	.mask		=3D CLOCKSOURCE_MASK(32),
 	.flags		=3D CLOCK_SOURCE_IS_CONTINUOUS,
 	/* mult, shift are set based on mhz27 flag */
+	.owner		=3D THIS_MODULE,
 };
=20
 static int __init init_hrt_clocksource(void)
diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index b72b36e0abed..385eb94bbe7c 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -578,37 +578,74 @@ static irqreturn_t sh_cmt_interrupt(int irq, void *dev_=
id)
 	return IRQ_HANDLED;
 }
=20
-static int sh_cmt_start(struct sh_cmt_channel *ch, unsigned long flag)
+static int sh_cmt_start_clocksource(struct sh_cmt_channel *ch)
 {
 	int ret =3D 0;
 	unsigned long flags;
=20
-	if (flag & FLAG_CLOCKSOURCE)
-		pm_runtime_get_sync(&ch->cmt->pdev->dev);
+	pm_runtime_get_sync(&ch->cmt->pdev->dev);
=20
 	raw_spin_lock_irqsave(&ch->lock, flags);
=20
-	if (!(ch->flags & (FLAG_CLOCKEVENT | FLAG_CLOCKSOURCE))) {
-		if (flag & FLAG_CLOCKEVENT)
-			pm_runtime_get_sync(&ch->cmt->pdev->dev);
+	if (!(ch->flags & (FLAG_CLOCKEVENT | FLAG_CLOCKSOURCE)))
 		ret =3D sh_cmt_enable(ch);
-	}
=20
 	if (ret)
 		goto out;
-	ch->flags |=3D flag;
+
+	ch->flags |=3D FLAG_CLOCKSOURCE;
=20
 	/* setup timeout if no clockevent */
-	if (ch->cmt->num_channels =3D=3D 1 &&
-	    flag =3D=3D FLAG_CLOCKSOURCE && (!(ch->flags & FLAG_CLOCKEVENT)))
+	if (ch->cmt->num_channels =3D=3D 1 && !(ch->flags & FLAG_CLOCKEVENT))
 		__sh_cmt_set_next(ch, ch->max_match_value);
+out:
+	raw_spin_unlock_irqrestore(&ch->lock, flags);
+
+	return ret;
+}
+
+static void sh_cmt_stop_clocksource(struct sh_cmt_channel *ch)
+{
+	unsigned long flags;
+	unsigned long f;
+
+	raw_spin_lock_irqsave(&ch->lock, flags);
+
+	f =3D ch->flags & (FLAG_CLOCKEVENT | FLAG_CLOCKSOURCE);
+
+	ch->flags &=3D ~FLAG_CLOCKSOURCE;
+
+	if (f && !(ch->flags & (FLAG_CLOCKEVENT | FLAG_CLOCKSOURCE)))
+		sh_cmt_disable(ch);
+
+	raw_spin_unlock_irqrestore(&ch->lock, flags);
+
+	pm_runtime_put(&ch->cmt->pdev->dev);
+}
+
+static int sh_cmt_start_clockevent(struct sh_cmt_channel *ch)
+{
+	int ret =3D 0;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&ch->lock, flags);
+
+	if (!(ch->flags & (FLAG_CLOCKEVENT | FLAG_CLOCKSOURCE))) {
+		pm_runtime_get_sync(&ch->cmt->pdev->dev);
+		ret =3D sh_cmt_enable(ch);
+	}
+
+	if (ret)
+		goto out;
+
+	ch->flags |=3D FLAG_CLOCKEVENT;
  out:
 	raw_spin_unlock_irqrestore(&ch->lock, flags);
=20
 	return ret;
 }
=20
-static void sh_cmt_stop(struct sh_cmt_channel *ch, unsigned long flag)
+static void sh_cmt_stop_clockevent(struct sh_cmt_channel *ch)
 {
 	unsigned long flags;
 	unsigned long f;
@@ -616,22 +653,19 @@ static void sh_cmt_stop(struct sh_cmt_channel *ch, unsi=
gned long flag)
 	raw_spin_lock_irqsave(&ch->lock, flags);
=20
 	f =3D ch->flags & (FLAG_CLOCKEVENT | FLAG_CLOCKSOURCE);
-	ch->flags &=3D ~flag;
+
+	ch->flags &=3D ~FLAG_CLOCKEVENT;
=20
 	if (f && !(ch->flags & (FLAG_CLOCKEVENT | FLAG_CLOCKSOURCE))) {
 		sh_cmt_disable(ch);
-		if (flag & FLAG_CLOCKEVENT)
-			pm_runtime_put(&ch->cmt->pdev->dev);
+		pm_runtime_put(&ch->cmt->pdev->dev);
 	}
=20
 	/* adjust the timeout to maximum if only clocksource left */
-	if ((flag =3D=3D FLAG_CLOCKEVENT) && (ch->flags & FLAG_CLOCKSOURCE))
+	if (ch->flags & FLAG_CLOCKSOURCE)
 		__sh_cmt_set_next(ch, ch->max_match_value);
=20
 	raw_spin_unlock_irqrestore(&ch->lock, flags);
-
-	if (flag & FLAG_CLOCKSOURCE)
-		pm_runtime_put(&ch->cmt->pdev->dev);
 }
=20
 static struct sh_cmt_channel *cs_to_sh_cmt(struct clocksource *cs)
@@ -672,7 +706,7 @@ static int sh_cmt_clocksource_enable(struct clocksource *=
cs)
=20
 	ch->total_cycles =3D 0;
=20
-	ret =3D sh_cmt_start(ch, FLAG_CLOCKSOURCE);
+	ret =3D sh_cmt_start_clocksource(ch);
 	if (!ret)
 		ch->cs_enabled =3D true;
=20
@@ -685,7 +719,7 @@ static void sh_cmt_clocksource_disable(struct clocksource=
 *cs)
=20
 	WARN_ON(!ch->cs_enabled);
=20
-	sh_cmt_stop(ch, FLAG_CLOCKSOURCE);
+	sh_cmt_stop_clocksource(ch);
 	ch->cs_enabled =3D false;
 }
=20
@@ -696,7 +730,7 @@ static void sh_cmt_clocksource_suspend(struct clocksource=
 *cs)
 	if (!ch->cs_enabled)
 		return;
=20
-	sh_cmt_stop(ch, FLAG_CLOCKSOURCE);
+	sh_cmt_stop_clocksource(ch);
 	dev_pm_genpd_suspend(&ch->cmt->pdev->dev);
 }
=20
@@ -708,7 +742,7 @@ static void sh_cmt_clocksource_resume(struct clocksource =
*cs)
 		return;
=20
 	dev_pm_genpd_resume(&ch->cmt->pdev->dev);
-	sh_cmt_start(ch, FLAG_CLOCKSOURCE);
+	sh_cmt_start_clocksource(ch);
 }
=20
 static int sh_cmt_register_clocksource(struct sh_cmt_channel *ch,
@@ -740,7 +774,7 @@ static struct sh_cmt_channel *ced_to_sh_cmt(struct clock_=
event_device *ced)
=20
 static void sh_cmt_clock_event_start(struct sh_cmt_channel *ch, int periodic)
 {
-	sh_cmt_start(ch, FLAG_CLOCKEVENT);
+	sh_cmt_start_clockevent(ch);
=20
 	if (periodic)
 		sh_cmt_set_next(ch, ((ch->cmt->rate + HZ/2) / HZ) - 1);
@@ -752,7 +786,7 @@ static int sh_cmt_clock_event_shutdown(struct clock_event=
_device *ced)
 {
 	struct sh_cmt_channel *ch =3D ced_to_sh_cmt(ced);
=20
-	sh_cmt_stop(ch, FLAG_CLOCKEVENT);
+	sh_cmt_stop_clockevent(ch);
 	return 0;
 }
=20
@@ -763,7 +797,7 @@ static int sh_cmt_clock_event_set_state(struct clock_even=
t_device *ced,
=20
 	/* deal with old setting first */
 	if (clockevent_state_oneshot(ced) || clockevent_state_periodic(ced))
-		sh_cmt_stop(ch, FLAG_CLOCKEVENT);
+		sh_cmt_stop_clockevent(ch);
=20
 	dev_info(&ch->cmt->pdev->dev, "ch%u: used for %s clock events\n",
 		 ch->index, periodic ? "periodic" : "oneshot");
diff --git a/drivers/clocksource/timer-cs5535.c b/drivers/clocksource/timer-c=
s5535.c
index d47acfe848ae..8af666c39890 100644
--- a/drivers/clocksource/timer-cs5535.c
+++ b/drivers/clocksource/timer-cs5535.c
@@ -101,6 +101,7 @@ static struct clock_event_device cs5535_clockevent =3D {
 	.tick_resume =3D mfgpt_shutdown,
 	.set_next_event =3D mfgpt_next_event,
 	.rating =3D 250,
+	.owner =3D THIS_MODULE,
 };
=20
 static irqreturn_t mfgpt_tick(int irq, void *dev_id)
diff --git a/drivers/clocksource/timer-econet-en751221.c b/drivers/clocksourc=
e/timer-econet-en751221.c
index 3b449fdaafee..4008076b1a21 100644
--- a/drivers/clocksource/timer-econet-en751221.c
+++ b/drivers/clocksource/timer-econet-en751221.c
@@ -146,7 +146,7 @@ static int __init cevt_init(struct device_node *np)
 	for_each_possible_cpu(i) {
 		struct clock_event_device *cd =3D &per_cpu(econet_timer_pcpu, i);
=20
-		cd->rating		=3D 310,
+		cd->rating		=3D 310;
 		cd->features		=3D CLOCK_EVT_FEAT_ONESHOT |
 					  CLOCK_EVT_FEAT_C3STOP |
 					  CLOCK_EVT_FEAT_PERCPU;
diff --git a/drivers/clocksource/timer-nxp-pit.c b/drivers/clocksource/timer-=
nxp-pit.c
new file mode 100644
index 000000000000..2d0a3554b6bf
--- /dev/null
+++ b/drivers/clocksource/timer-nxp-pit.c
@@ -0,0 +1,382 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2012-2013 Freescale Semiconductor, Inc.
+ * Copyright 2018,2021-2025 NXP
+ */
+#include <linux/interrupt.h>
+#include <linux/clockchips.h>
+#include <linux/cpuhotplug.h>
+#include <linux/clk.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/sched_clock.h>
+#include <linux/platform_device.h>
+
+/*
+ * Each pit takes 0x10 Bytes register space
+ */
+#define PIT0_OFFSET	0x100
+#define PIT_CH(n)       (PIT0_OFFSET + 0x10 * (n))
+
+#define PITMCR(__base)	(__base)
+
+#define PITMCR_FRZ	BIT(0)
+#define PITMCR_MDIS	BIT(1)
+
+#define PITLDVAL(__base)	(__base)
+#define PITTCTRL(__base)	((__base) + 0x08)
+
+#define PITCVAL_OFFSET	0x04
+#define PITCVAL(__base)	((__base) + 0x04)
+
+#define PITTCTRL_TEN			BIT(0)
+#define PITTCTRL_TIE			BIT(1)
+
+#define PITTFLG(__base)	((__base) + 0x0c)
+
+#define PITTFLG_TIF			BIT(0)
+
+struct pit_timer {
+	void __iomem *clksrc_base;
+	void __iomem *clkevt_base;
+	struct clock_event_device ced;
+	struct clocksource cs;
+	int rate;
+};
+
+struct pit_timer_data {
+	int max_pit_instances;
+};
+
+static DEFINE_PER_CPU(struct pit_timer *, pit_timers);
+
+/*
+ * Global structure for multiple PITs initialization
+ */
+static int pit_instances;
+static int max_pit_instances =3D 1;
+
+static void __iomem *sched_clock_base;
+
+static inline struct pit_timer *ced_to_pit(struct clock_event_device *ced)
+{
+	return container_of(ced, struct pit_timer, ced);
+}
+
+static inline struct pit_timer *cs_to_pit(struct clocksource *cs)
+{
+	return container_of(cs, struct pit_timer, cs);
+}
+
+static inline void pit_module_enable(void __iomem *base)
+{
+	writel(0, PITMCR(base));
+}
+
+static inline void pit_module_disable(void __iomem *base)
+{
+	writel(PITMCR_MDIS, PITMCR(base));
+}
+
+static inline void pit_timer_enable(void __iomem *base, bool tie)
+{
+	u32 val =3D PITTCTRL_TEN | (tie ? PITTCTRL_TIE : 0);
+
+	writel(val, PITTCTRL(base));
+}
+
+static inline void pit_timer_disable(void __iomem *base)
+{
+	writel(0, PITTCTRL(base));
+}
+
+static inline void pit_timer_set_counter(void __iomem *base, unsigned int cn=
t)
+{
+	writel(cnt, PITLDVAL(base));
+}
+
+static inline void pit_timer_irqack(struct pit_timer *pit)
+{
+	writel(PITTFLG_TIF, PITTFLG(pit->clkevt_base));
+}
+
+static u64 notrace pit_read_sched_clock(void)
+{
+	return ~readl(sched_clock_base);
+}
+
+static u64 pit_timer_clocksource_read(struct clocksource *cs)
+{
+	struct pit_timer *pit =3D cs_to_pit(cs);
+
+	return (u64)~readl(PITCVAL(pit->clksrc_base));
+}
+
+static int pit_clocksource_init(struct pit_timer *pit, const char *name,
+				void __iomem *base, unsigned long rate)
+{
+	/*
+	 * The channels 0 and 1 can be chained to build a 64-bit
+	 * timer. Let's use the channel 2 as a clocksource and leave
+	 * the channels 0 and 1 unused for anyone else who needs them
+	 */
+	pit->clksrc_base =3D base + PIT_CH(2);
+	pit->cs.name =3D name;
+	pit->cs.rating =3D 300;
+	pit->cs.read =3D pit_timer_clocksource_read;
+	pit->cs.mask =3D CLOCKSOURCE_MASK(32);
+	pit->cs.flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
+
+	/* set the max load value and start the clock source counter */
+	pit_timer_disable(pit->clksrc_base);
+	pit_timer_set_counter(pit->clksrc_base, ~0);
+	pit_timer_enable(pit->clksrc_base, 0);
+
+	sched_clock_base =3D pit->clksrc_base + PITCVAL_OFFSET;
+	sched_clock_register(pit_read_sched_clock, 32, rate);
+
+	return clocksource_register_hz(&pit->cs, rate);
+}
+
+static int pit_set_next_event(unsigned long delta, struct clock_event_device=
 *ced)
+{
+	struct pit_timer *pit =3D ced_to_pit(ced);
+
+	/*
+	 * set a new value to PITLDVAL register will not restart the timer,
+	 * to abort the current cycle and start a timer period with the new
+	 * value, the timer must be disabled and enabled again.
+	 * and the PITLAVAL should be set to delta minus one according to pit
+	 * hardware requirement.
+	 */
+	pit_timer_disable(pit->clkevt_base);
+	pit_timer_set_counter(pit->clkevt_base, delta - 1);
+	pit_timer_enable(pit->clkevt_base, true);
+
+	return 0;
+}
+
+static int pit_shutdown(struct clock_event_device *ced)
+{
+	struct pit_timer *pit =3D ced_to_pit(ced);
+
+	pit_timer_disable(pit->clkevt_base);
+
+	return 0;
+}
+
+static int pit_set_periodic(struct clock_event_device *ced)
+{
+	struct pit_timer *pit =3D ced_to_pit(ced);
+
+	pit_set_next_event(pit->rate / HZ, ced);
+
+	return 0;
+}
+
+static irqreturn_t pit_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *ced =3D dev_id;
+	struct pit_timer *pit =3D ced_to_pit(ced);
+
+	pit_timer_irqack(pit);
+
+	/*
+	 * pit hardware doesn't support oneshot, it will generate an interrupt
+	 * and reload the counter value from PITLDVAL when PITCVAL reach zero,
+	 * and start the counter again. So software need to disable the timer
+	 * to stop the counter loop in ONESHOT mode.
+	 */
+	if (likely(clockevent_state_oneshot(ced)))
+		pit_timer_disable(pit->clkevt_base);
+
+	ced->event_handler(ced);
+
+	return IRQ_HANDLED;
+}
+
+static int pit_clockevent_per_cpu_init(struct pit_timer *pit, const char *na=
me,
+				       void __iomem *base, unsigned long rate,
+				       int irq, unsigned int cpu)
+{
+	int ret;
+
+	/*
+	 * The channels 0 and 1 can be chained to build a 64-bit
+	 * timer. Let's use the channel 3 as a clockevent and leave
+	 * the channels 0 and 1 unused for anyone else who needs them
+	 */
+	pit->clkevt_base =3D base + PIT_CH(3);
+	pit->rate =3D rate;
+
+	pit_timer_disable(pit->clkevt_base);
+
+	pit_timer_irqack(pit);
+
+	ret =3D request_irq(irq, pit_timer_interrupt, IRQF_TIMER | IRQF_NOBALANCING,
+			  name, &pit->ced);
+	if (ret)
+		return ret;
+
+	pit->ced.cpumask =3D cpumask_of(cpu);
+	pit->ced.irq =3D irq;
+
+	pit->ced.name =3D name;
+	pit->ced.features =3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
+	pit->ced.set_state_shutdown =3D pit_shutdown;
+	pit->ced.set_state_periodic =3D pit_set_periodic;
+	pit->ced.set_next_event	=3D pit_set_next_event;
+	pit->ced.rating	=3D 300;
+
+	per_cpu(pit_timers, cpu) =3D pit;
+
+	return 0;
+}
+
+static void pit_clockevent_per_cpu_exit(struct pit_timer *pit, unsigned int =
cpu)
+{
+	pit_timer_disable(pit->clkevt_base);
+	free_irq(pit->ced.irq, &pit->ced);
+	per_cpu(pit_timers, cpu) =3D NULL;
+}
+
+static int pit_clockevent_starting_cpu(unsigned int cpu)
+{
+	struct pit_timer *pit =3D per_cpu(pit_timers, cpu);
+	int ret;
+
+	if (!pit)
+		return 0;
+
+	ret =3D irq_force_affinity(pit->ced.irq, cpumask_of(cpu));
+	if (ret) {
+		pit_clockevent_per_cpu_exit(pit, cpu);
+		return ret;
+	}
+
+	/*
+	 * The value for the LDVAL register trigger is calculated as:
+	 * LDVAL trigger =3D (period / clock period) - 1
+	 * The pit is a 32-bit down count timer, when the counter value
+	 * reaches 0, it will generate an interrupt, thus the minimal
+	 * LDVAL trigger value is 1. And then the min_delta is
+	 * minimal LDVAL trigger value + 1, and the max_delta is full 32-bit.
+	 */
+	clockevents_config_and_register(&pit->ced, pit->rate, 2, 0xffffffff);
+
+	return 0;
+}
+
+static int pit_timer_init(struct device_node *np)
+{
+	struct pit_timer *pit;
+	struct clk *pit_clk;
+	void __iomem *timer_base;
+	const char *name =3D of_node_full_name(np);
+	unsigned long clk_rate;
+	int irq, ret;
+
+	pit =3D kzalloc(sizeof(*pit), GFP_KERNEL);
+	if (!pit)
+		return -ENOMEM;
+
+	ret =3D -ENXIO;
+	timer_base =3D of_iomap(np, 0);
+	if (!timer_base) {
+		pr_err("Failed to iomap\n");
+		goto out_kfree;
+	}
+
+	ret =3D -EINVAL;
+	irq =3D irq_of_parse_and_map(np, 0);
+	if (irq <=3D 0) {
+		pr_err("Failed to irq_of_parse_and_map\n");
+		goto out_iounmap;
+	}
+
+	pit_clk =3D of_clk_get(np, 0);
+	if (IS_ERR(pit_clk)) {
+		ret =3D PTR_ERR(pit_clk);
+		goto out_irq_dispose_mapping;
+	}
+
+	ret =3D clk_prepare_enable(pit_clk);
+	if (ret)
+		goto out_clk_put;
+
+	clk_rate =3D clk_get_rate(pit_clk);
+
+	pit_module_disable(timer_base);
+
+	ret =3D pit_clocksource_init(pit, name, timer_base, clk_rate);
+	if (ret) {
+		pr_err("Failed to initialize clocksource '%pOF'\n", np);
+		goto out_pit_module_disable;
+	}
+
+	ret =3D pit_clockevent_per_cpu_init(pit, name, timer_base, clk_rate, irq, p=
it_instances);
+	if (ret) {
+		pr_err("Failed to initialize clockevent '%pOF'\n", np);
+		goto out_pit_clocksource_unregister;
+	}
+
+	/* enable the pit module */
+	pit_module_enable(timer_base);
+
+	pit_instances++;
+
+	if (pit_instances =3D=3D max_pit_instances) {
+		ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "PIT timer:starting",
+					pit_clockevent_starting_cpu, NULL);
+		if (ret < 0)
+			goto out_pit_clocksource_unregister;
+	}
+
+	return 0;
+
+out_pit_clocksource_unregister:
+	clocksource_unregister(&pit->cs);
+out_pit_module_disable:
+	pit_module_disable(timer_base);
+	clk_disable_unprepare(pit_clk);
+out_clk_put:
+	clk_put(pit_clk);
+out_irq_dispose_mapping:
+	irq_dispose_mapping(irq);
+out_iounmap:
+	iounmap(timer_base);
+out_kfree:
+	kfree(pit);
+
+	return ret;
+}
+
+static int pit_timer_probe(struct platform_device *pdev)
+{
+	const struct pit_timer_data *pit_timer_data;
+
+	pit_timer_data =3D of_device_get_match_data(&pdev->dev);
+	if (pit_timer_data)
+		max_pit_instances =3D pit_timer_data->max_pit_instances;
+
+	return pit_timer_init(pdev->dev.of_node);
+}
+
+static struct pit_timer_data s32g2_data =3D { .max_pit_instances =3D 2 };
+
+static const struct of_device_id pit_timer_of_match[] =3D {
+	{ .compatible =3D "nxp,s32g2-pit", .data =3D &s32g2_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pit_timer_of_match);
+
+static struct platform_driver nxp_pit_driver =3D {
+	.driver =3D {
+		.name =3D "nxp-pit",
+		.of_match_table =3D pit_timer_of_match,
+	},
+	.probe =3D pit_timer_probe,
+};
+module_platform_driver(nxp_pit_driver);
+
+TIMER_OF_DECLARE(vf610, "fsl,vf610-pit", pit_timer_init);
diff --git a/drivers/clocksource/timer-nxp-stm.c b/drivers/clocksource/timer-=
nxp-stm.c
index d7ccf9001729..bbc40623728f 100644
--- a/drivers/clocksource/timer-nxp-stm.c
+++ b/drivers/clocksource/timer-nxp-stm.c
@@ -201,6 +201,7 @@ static int __init nxp_stm_clocksource_init(struct device =
*dev, struct stm_timer
 	stm_timer->cs.resume =3D nxp_stm_clocksource_resume;
 	stm_timer->cs.mask =3D CLOCKSOURCE_MASK(32);
 	stm_timer->cs.flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
+	stm_timer->cs.owner =3D THIS_MODULE;
=20
 	ret =3D clocksource_register_hz(&stm_timer->cs, stm_timer->rate);
 	if (ret)
@@ -314,6 +315,7 @@ static int __init nxp_stm_clockevent_per_cpu_init(struct =
device *dev, struct stm
 	stm_timer->ced.cpumask =3D cpumask_of(cpu);
 	stm_timer->ced.rating =3D 460;
 	stm_timer->ced.irq =3D irq;
+	stm_timer->ced.owner =3D THIS_MODULE;
=20
 	per_cpu(stm_timers, cpu) =3D stm_timer;
=20
diff --git a/drivers/clocksource/timer-rtl-otto.c b/drivers/clocksource/timer=
-rtl-otto.c
index 8a3068b36e75..6113d2fdd4de 100644
--- a/drivers/clocksource/timer-rtl-otto.c
+++ b/drivers/clocksource/timer-rtl-otto.c
@@ -38,14 +38,13 @@
 #define RTTM_BIT_COUNT		28
 #define RTTM_MIN_DELTA		8
 #define RTTM_MAX_DELTA		CLOCKSOURCE_MASK(28)
+#define RTTM_MAX_DIVISOR	GENMASK(15, 0)
=20
 /*
- * Timers are derived from the LXB clock frequency. Usually this is a fixed
- * multiple of the 25 MHz oscillator. The 930X SOC is an exception from that.
- * Its LXB clock has only dividers and uses the switch PLL of 2.45 GHz as its
- * base. The only meaningful frequencies we can achieve from that are 175.000
- * MHz and 153.125 MHz. The greatest common divisor of all explained possible
- * speeds is 3125000. Pin the timers to this 3.125 MHz reference frequency.
+ * Timers are derived from the lexra bus (LXB) clock frequency. This is 175 =
MHz
+ * on RTL930x and 200 MHz on the other platforms. With 3.125 MHz choose a co=
mmon
+ * divisor to have enough range and detail. This provides comparability betw=
een
+ * the different platforms.
  */
 #define RTTM_TICKS_PER_SEC	3125000
=20
@@ -55,11 +54,6 @@ struct rttm_cs {
 };
=20
 /* Simple internal register functions */
-static inline void rttm_set_counter(void __iomem *base, unsigned int counter)
-{
-	iowrite32(counter, base + RTTM_CNT);
-}
-
 static inline unsigned int rttm_get_counter(void __iomem *base)
 {
 	return ioread32(base + RTTM_CNT);
@@ -112,6 +106,22 @@ static irqreturn_t rttm_timer_interrupt(int irq, void *d=
ev_id)
 	return IRQ_HANDLED;
 }
=20
+static void rttm_bounce_timer(void __iomem *base, u32 mode)
+{
+	/*
+	 * When a running timer has less than ~5us left, a stop/start sequence
+	 * might fail. While the details are unknown the most evident effect is
+	 * that the subsequent interrupt will not be fired.
+	 *
+	 * As a workaround issue an intermediate restart with a very slow
+	 * frequency of ~3kHz keeping the target counter (>=3D8). So the follow
+	 * up restart will always be issued outside the critical window.
+	 */
+
+	rttm_disable_timer(base);
+	rttm_enable_timer(base, mode, RTTM_MAX_DIVISOR);
+}
+
 static void rttm_stop_timer(void __iomem *base)
 {
 	rttm_disable_timer(base);
@@ -120,7 +130,6 @@ static void rttm_stop_timer(void __iomem *base)
=20
 static void rttm_start_timer(struct timer_of *to, u32 mode)
 {
-	rttm_set_counter(to->of_base.base, 0);
 	rttm_enable_timer(to->of_base.base, mode, to->of_clk.rate / RTTM_TICKS_PER_=
SEC);
 }
=20
@@ -129,7 +138,8 @@ static int rttm_next_event(unsigned long delta, struct cl=
ock_event_device *clkev
 	struct timer_of *to =3D to_timer_of(clkevt);
=20
 	RTTM_DEBUG(to->of_base.base);
-	rttm_stop_timer(to->of_base.base);
+	rttm_bounce_timer(to->of_base.base, RTTM_CTRL_COUNTER);
+	rttm_disable_timer(to->of_base.base);
 	rttm_set_period(to->of_base.base, delta);
 	rttm_start_timer(to, RTTM_CTRL_COUNTER);
=20
@@ -141,7 +151,8 @@ static int rttm_state_oneshot(struct clock_event_device *=
clkevt)
 	struct timer_of *to =3D to_timer_of(clkevt);
=20
 	RTTM_DEBUG(to->of_base.base);
-	rttm_stop_timer(to->of_base.base);
+	rttm_bounce_timer(to->of_base.base, RTTM_CTRL_COUNTER);
+	rttm_disable_timer(to->of_base.base);
 	rttm_set_period(to->of_base.base, RTTM_TICKS_PER_SEC / HZ);
 	rttm_start_timer(to, RTTM_CTRL_COUNTER);
=20
@@ -153,7 +164,8 @@ static int rttm_state_periodic(struct clock_event_device =
*clkevt)
 	struct timer_of *to =3D to_timer_of(clkevt);
=20
 	RTTM_DEBUG(to->of_base.base);
-	rttm_stop_timer(to->of_base.base);
+	rttm_bounce_timer(to->of_base.base, RTTM_CTRL_TIMER);
+	rttm_disable_timer(to->of_base.base);
 	rttm_set_period(to->of_base.base, RTTM_TICKS_PER_SEC / HZ);
 	rttm_start_timer(to, RTTM_CTRL_TIMER);
=20
diff --git a/drivers/clocksource/timer-stm32-lp.c b/drivers/clocksource/timer=
-stm32-lp.c
index 6e7944ffd7c0..c2a699f5c1dd 100644
--- a/drivers/clocksource/timer-stm32-lp.c
+++ b/drivers/clocksource/timer-stm32-lp.c
@@ -211,6 +211,7 @@ static void stm32_clkevent_lp_init(struct stm32_lp_privat=
e *priv,
 	priv->clkevt.rating =3D STM32_LP_RATING;
 	priv->clkevt.suspend =3D stm32_clkevent_lp_suspend;
 	priv->clkevt.resume =3D stm32_clkevent_lp_resume;
+	priv->clkevt.owner =3D THIS_MODULE;
=20
 	clockevents_config_and_register(&priv->clkevt, rate, 0x1,
 					STM32_LPTIM_MAX_ARR);
diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-su=
n5i.c
index 6b48a9006444..f827d3f98f60 100644
--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -185,6 +185,7 @@ static int sun5i_setup_clocksource(struct platform_device=
 *pdev,
 	cs->clksrc.read =3D sun5i_clksrc_read;
 	cs->clksrc.mask =3D CLOCKSOURCE_MASK(32);
 	cs->clksrc.flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
+	cs->clksrc.owner =3D THIS_MODULE;
=20
 	ret =3D clocksource_register_hz(&cs->clksrc, rate);
 	if (ret) {
@@ -214,6 +215,7 @@ static int sun5i_setup_clockevent(struct platform_device =
*pdev,
 	ce->clkevt.rating =3D 340;
 	ce->clkevt.irq =3D irq;
 	ce->clkevt.cpumask =3D cpu_possible_mask;
+	ce->clkevt.owner =3D THIS_MODULE;
=20
 	/* Enable timer0 interrupt */
 	val =3D readl(base + TIMER_IRQ_EN_REG);
diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer=
-tegra186.c
index e5394f98a02e..355558893e5f 100644
--- a/drivers/clocksource/timer-tegra186.c
+++ b/drivers/clocksource/timer-tegra186.c
@@ -159,7 +159,7 @@ static void tegra186_wdt_enable(struct tegra186_wdt *wdt)
 	tmr_writel(wdt->tmr, TMRCSSR_SRC_USEC, TMRCSSR);
=20
 	/* configure timer (system reset happens on the fifth expiration) */
-	value =3D TMRCR_PTV(wdt->base.timeout * USEC_PER_SEC / 5) |
+	value =3D TMRCR_PTV(wdt->base.timeout * (USEC_PER_SEC / 5)) |
 		TMRCR_PERIODIC | TMRCR_ENABLE;
 	tmr_writel(wdt->tmr, value, TMRCR);
=20
@@ -231,7 +231,7 @@ static unsigned int tegra186_wdt_get_timeleft(struct watc=
hdog_device *wdd)
 {
 	struct tegra186_wdt *wdt =3D to_tegra186_wdt(wdd);
 	u32 expiration, val;
-	u64 timeleft;
+	u32 timeleft;
=20
 	if (!watchdog_active(&wdt->base)) {
 		/* return zero if the watchdog timer is not activated. */
@@ -266,21 +266,26 @@ static unsigned int tegra186_wdt_get_timeleft(struct wa=
tchdog_device *wdd)
 	 * Calculate the time remaining by adding the time for the
 	 * counter value to the time of the counter expirations that
 	 * remain.
+	 * Note: Since wdt->base.timeout is bound to 255, the maximum
+	 * value added to timeleft is
+	 *   255 * (1,000,000 / 5) * 4
+	 * =3D 255 * 200,000 * 4
+	 * =3D 204,000,000
+	 * TMRSR_PCV is a 29-bit field.
+	 * Its maximum value is 0x1fffffff =3D 536,870,911.
+	 * 204,000,000 + 536,870,911 =3D 740,870,911 =3D 0x2C28CAFF.
+	 * timeleft can therefore not overflow, and 64-bit calculations
+	 * are not necessary.
 	 */
-	timeleft +=3D (((u64)wdt->base.timeout * USEC_PER_SEC) / 5) * (4 - expirati=
on);
+	timeleft +=3D (wdt->base.timeout * (USEC_PER_SEC / 5)) * (4 - expiration);
=20
 	/*
 	 * Convert the current counter value to seconds,
-	 * rounding up to the nearest second. Cast u64 to
-	 * u32 under the assumption that no overflow happens
-	 * when coverting to seconds.
+	 * rounding to the nearest second.
 	 */
-	timeleft =3D DIV_ROUND_CLOSEST_ULL(timeleft, USEC_PER_SEC);
+	timeleft =3D DIV_ROUND_CLOSEST(timeleft, USEC_PER_SEC);
=20
-	if (WARN_ON_ONCE(timeleft > U32_MAX))
-		return U32_MAX;
-
-	return lower_32_bits(timeleft);
+	return timeleft;
 }
=20
 static const struct watchdog_ops tegra186_wdt_ops =3D {
@@ -328,16 +333,12 @@ static struct tegra186_wdt *tegra186_wdt_create(struct =
tegra186_timer *tegra,
 	wdt->base.parent =3D tegra->dev;
=20
 	err =3D watchdog_init_timeout(&wdt->base, 5, tegra->dev);
-	if (err < 0) {
-		dev_err(tegra->dev, "failed to initialize timeout: %d\n", err);
+	if (err < 0)
 		return ERR_PTR(err);
-	}
=20
 	err =3D devm_watchdog_register_device(tegra->dev, &wdt->base);
-	if (err < 0) {
-		dev_err(tegra->dev, "failed to register WDT: %d\n", err);
+	if (err < 0)
 		return ERR_PTR(err);
-	}
=20
 	return wdt;
 }
@@ -373,6 +374,7 @@ static int tegra186_timer_tsc_init(struct tegra186_timer =
*tegra)
 	tegra->tsc.read =3D tegra186_timer_tsc_read;
 	tegra->tsc.mask =3D CLOCKSOURCE_MASK(56);
 	tegra->tsc.flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
+	tegra->tsc.owner =3D THIS_MODULE;
=20
 	return clocksource_register_hz(&tegra->tsc, 31250000);
 }
@@ -392,6 +394,7 @@ static int tegra186_timer_osc_init(struct tegra186_timer =
*tegra)
 	tegra->osc.read =3D tegra186_timer_osc_read;
 	tegra->osc.mask =3D CLOCKSOURCE_MASK(32);
 	tegra->osc.flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
+	tegra->osc.owner =3D THIS_MODULE;
=20
 	return clocksource_register_hz(&tegra->osc, 38400000);
 }
@@ -411,6 +414,7 @@ static int tegra186_timer_usec_init(struct tegra186_timer=
 *tegra)
 	tegra->usec.read =3D tegra186_timer_usec_read;
 	tegra->usec.mask =3D CLOCKSOURCE_MASK(32);
 	tegra->usec.flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
+	tegra->usec.owner =3D THIS_MODULE;
=20
 	return clocksource_register_hz(&tegra->usec, USEC_PER_SEC);
 }
diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti=
-dm.c
index e9e32df6b566..793e7cdcb1b1 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -31,6 +31,7 @@
 #include <linux/platform_data/dmtimer-omap.h>
=20
 #include <clocksource/timer-ti-dm.h>
+#include <linux/delay.h>
=20
 /*
  * timer errata flags
@@ -836,6 +837,48 @@ static int omap_dm_timer_set_match(struct omap_dm_timer =
*cookie, int enable,
 	return 0;
 }
=20
+static int omap_dm_timer_set_cap(struct omap_dm_timer *cookie,
+					int autoreload, bool config_period)
+{
+	struct dmtimer *timer;
+	struct device *dev;
+	int rc;
+	u32 l;
+
+	timer =3D to_dmtimer(cookie);
+	if (unlikely(!timer))
+		return -EINVAL;
+
+	dev =3D &timer->pdev->dev;
+	rc =3D pm_runtime_resume_and_get(dev);
+	if (rc)
+		return rc;
+	/*
+	 *  1. Select autoreload mode. TIMER_TCLR[1] AR bit.
+	 *  2. TIMER_TCLR[14]: Sets the functionality of the TIMER IO pin.
+	 *  3. TIMER_TCLR[13] : Capture mode select bit.
+	 *  3. TIMER_TCLR[9-8] : Select transition capture mode.
+	 */
+
+	l =3D dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
+
+	if (autoreload)
+		l |=3D OMAP_TIMER_CTRL_AR;
+
+	l |=3D OMAP_TIMER_CTRL_CAPTMODE | OMAP_TIMER_CTRL_GPOCFG;
+
+	if (config_period =3D=3D true)
+		l |=3D OMAP_TIMER_CTRL_TCM_LOWTOHIGH; /* Time Period config */
+	else
+		l |=3D OMAP_TIMER_CTRL_TCM_BOTHEDGES; /* Duty Cycle config */
+
+	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l);
+
+	pm_runtime_put_sync(dev);
+
+	return 0;
+}
+
 static int omap_dm_timer_set_pwm(struct omap_dm_timer *cookie, int def_on,
 				 int toggle, int trigger, int autoreload)
 {
@@ -1023,23 +1066,92 @@ static unsigned int omap_dm_timer_read_counter(struct=
 omap_dm_timer *cookie)
 	return __omap_dm_timer_read_counter(timer);
 }
=20
+static inline unsigned int __omap_dm_timer_cap(struct dmtimer *timer, int id=
x)
+{
+	return idx =3D=3D 0 ? dmtimer_read(timer, OMAP_TIMER_CAPTURE_REG) :
+			  dmtimer_read(timer, OMAP_TIMER_CAPTURE2_REG);
+}
+
 static int omap_dm_timer_write_counter(struct omap_dm_timer *cookie, unsigne=
d int value)
 {
 	struct dmtimer *timer;
+	struct device *dev;
=20
 	timer =3D to_dmtimer(cookie);
-	if (unlikely(!timer || !atomic_read(&timer->enabled))) {
-		pr_err("%s: timer not available or enabled.\n", __func__);
+	if (unlikely(!timer)) {
+		pr_err("%s: timer not available.\n", __func__);
 		return -EINVAL;
 	}
=20
+	dev =3D &timer->pdev->dev;
+
+	pm_runtime_resume_and_get(dev);
 	dmtimer_write(timer, OMAP_TIMER_COUNTER_REG, value);
+	pm_runtime_put_sync(dev);
=20
 	/* Save the context */
 	timer->context.tcrr =3D value;
 	return 0;
 }
=20
+/**
+ * omap_dm_timer_cap_counter() - Calculate the high count or period count de=
pending on the
+ * configuration.
+ * @cookie:Pointer to OMAP DM timer
+ * @is_period:Whether to configure timer in period or duty cycle mode
+ *
+ * Return high count or period count if timer is enabled else appropriate er=
ror.
+ */
+static unsigned int omap_dm_timer_cap_counter(struct omap_dm_timer *cookie,	=
bool is_period)
+{
+	struct dmtimer *timer;
+	unsigned int cap1 =3D 0;
+	unsigned int cap2 =3D 0;
+	u32 l, ret;
+
+	timer =3D to_dmtimer(cookie);
+	if (unlikely(!timer || !atomic_read(&timer->enabled))) {
+		pr_err("%s:timer is not available or enabled.%p\n", __func__, (void *)time=
r);
+		return -EINVAL;
+	}
+
+	/* Stop the timer */
+	omap_dm_timer_stop(cookie);
+
+	/* Clear the timer counter value to 0 */
+	ret =3D omap_dm_timer_write_counter(cookie, 0);
+	if (ret)
+		return ret;
+
+	/* Sets the timer capture configuration for period/duty cycle calculation */
+	ret =3D omap_dm_timer_set_cap(cookie, true, is_period);
+	if (ret) {
+		pr_err("%s: Failed to set timer capture configuration.\n", __func__);
+		return ret;
+	}
+	/* Start the timer */
+	omap_dm_timer_start(cookie);
+
+	/*
+	 * 1 sec delay is given so as to provide
+	 * enough time to capture low frequency signals.
+	 */
+	msleep(1000);
+
+	cap1 =3D __omap_dm_timer_cap(timer, 0);
+	cap2 =3D __omap_dm_timer_cap(timer, 1);
+
+	/*
+	 *  Clears the TCLR configuration.
+	 *  The start bit must be set to 1 as the timer is already in start mode.
+	 */
+	l =3D dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
+	l &=3D ~(0xffff) | 0x1;
+	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l);
+
+	return (cap2-cap1);
+}
+
 static int __maybe_unused omap_dm_timer_runtime_suspend(struct device *dev)
 {
 	struct dmtimer *timer =3D dev_get_drvdata(dev);
@@ -1246,6 +1358,9 @@ static const struct omap_dm_timer_ops dmtimer_ops =3D {
 	.write_counter =3D omap_dm_timer_write_counter,
 	.read_status =3D omap_dm_timer_read_status,
 	.write_status =3D omap_dm_timer_write_status,
+	.set_cap =3D omap_dm_timer_set_cap,
+	.get_cap_status =3D omap_dm_timer_get_pwm_status,
+	.read_cap =3D omap_dm_timer_cap_counter,
 };
=20
 static const struct dmtimer_platform_data omap3plus_pdata =3D {
diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-v=
f-pit.c
deleted file mode 100644
index 911c92146eca..000000000000
--- a/drivers/clocksource/timer-vf-pit.c
+++ /dev/null
@@ -1,194 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright 2012-2013 Freescale Semiconductor, Inc.
- */
-
-#include <linux/interrupt.h>
-#include <linux/clockchips.h>
-#include <linux/clk.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/sched_clock.h>
-
-/*
- * Each pit takes 0x10 Bytes register space
- */
-#define PITMCR		0x00
-#define PIT0_OFFSET	0x100
-#define PITn_OFFSET(n)	(PIT0_OFFSET + 0x10 * (n))
-#define PITLDVAL	0x00
-#define PITCVAL		0x04
-#define PITTCTRL	0x08
-#define PITTFLG		0x0c
-
-#define PITMCR_MDIS	(0x1 << 1)
-
-#define PITTCTRL_TEN	(0x1 << 0)
-#define PITTCTRL_TIE	(0x1 << 1)
-#define PITCTRL_CHN	(0x1 << 2)
-
-#define PITTFLG_TIF	0x1
-
-static void __iomem *clksrc_base;
-static void __iomem *clkevt_base;
-static unsigned long cycle_per_jiffy;
-
-static inline void pit_timer_enable(void)
-{
-	__raw_writel(PITTCTRL_TEN | PITTCTRL_TIE, clkevt_base + PITTCTRL);
-}
-
-static inline void pit_timer_disable(void)
-{
-	__raw_writel(0, clkevt_base + PITTCTRL);
-}
-
-static inline void pit_irq_acknowledge(void)
-{
-	__raw_writel(PITTFLG_TIF, clkevt_base + PITTFLG);
-}
-
-static u64 notrace pit_read_sched_clock(void)
-{
-	return ~__raw_readl(clksrc_base + PITCVAL);
-}
-
-static int __init pit_clocksource_init(unsigned long rate)
-{
-	/* set the max load value and start the clock source counter */
-	__raw_writel(0, clksrc_base + PITTCTRL);
-	__raw_writel(~0UL, clksrc_base + PITLDVAL);
-	__raw_writel(PITTCTRL_TEN, clksrc_base + PITTCTRL);
-
-	sched_clock_register(pit_read_sched_clock, 32, rate);
-	return clocksource_mmio_init(clksrc_base + PITCVAL, "vf-pit", rate,
-			300, 32, clocksource_mmio_readl_down);
-}
-
-static int pit_set_next_event(unsigned long delta,
-				struct clock_event_device *unused)
-{
-	/*
-	 * set a new value to PITLDVAL register will not restart the timer,
-	 * to abort the current cycle and start a timer period with the new
-	 * value, the timer must be disabled and enabled again.
-	 * and the PITLAVAL should be set to delta minus one according to pit
-	 * hardware requirement.
-	 */
-	pit_timer_disable();
-	__raw_writel(delta - 1, clkevt_base + PITLDVAL);
-	pit_timer_enable();
-
-	return 0;
-}
-
-static int pit_shutdown(struct clock_event_device *evt)
-{
-	pit_timer_disable();
-	return 0;
-}
-
-static int pit_set_periodic(struct clock_event_device *evt)
-{
-	pit_set_next_event(cycle_per_jiffy, evt);
-	return 0;
-}
-
-static irqreturn_t pit_timer_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *evt =3D dev_id;
-
-	pit_irq_acknowledge();
-
-	/*
-	 * pit hardware doesn't support oneshot, it will generate an interrupt
-	 * and reload the counter value from PITLDVAL when PITCVAL reach zero,
-	 * and start the counter again. So software need to disable the timer
-	 * to stop the counter loop in ONESHOT mode.
-	 */
-	if (likely(clockevent_state_oneshot(evt)))
-		pit_timer_disable();
-
-	evt->event_handler(evt);
-
-	return IRQ_HANDLED;
-}
-
-static struct clock_event_device clockevent_pit =3D {
-	.name		=3D "VF pit timer",
-	.features	=3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.set_state_shutdown =3D pit_shutdown,
-	.set_state_periodic =3D pit_set_periodic,
-	.set_next_event	=3D pit_set_next_event,
-	.rating		=3D 300,
-};
-
-static int __init pit_clockevent_init(unsigned long rate, int irq)
-{
-	__raw_writel(0, clkevt_base + PITTCTRL);
-	__raw_writel(PITTFLG_TIF, clkevt_base + PITTFLG);
-
-	BUG_ON(request_irq(irq, pit_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
-			   "VF pit timer", &clockevent_pit));
-
-	clockevent_pit.cpumask =3D cpumask_of(0);
-	clockevent_pit.irq =3D irq;
-	/*
-	 * The value for the LDVAL register trigger is calculated as:
-	 * LDVAL trigger =3D (period / clock period) - 1
-	 * The pit is a 32-bit down count timer, when the counter value
-	 * reaches 0, it will generate an interrupt, thus the minimal
-	 * LDVAL trigger value is 1. And then the min_delta is
-	 * minimal LDVAL trigger value + 1, and the max_delta is full 32-bit.
-	 */
-	clockevents_config_and_register(&clockevent_pit, rate, 2, 0xffffffff);
-
-	return 0;
-}
-
-static int __init pit_timer_init(struct device_node *np)
-{
-	struct clk *pit_clk;
-	void __iomem *timer_base;
-	unsigned long clk_rate;
-	int irq, ret;
-
-	timer_base =3D of_iomap(np, 0);
-	if (!timer_base) {
-		pr_err("Failed to iomap\n");
-		return -ENXIO;
-	}
-
-	/*
-	 * PIT0 and PIT1 can be chained to build a 64-bit timer,
-	 * so choose PIT2 as clocksource, PIT3 as clockevent device,
-	 * and leave PIT0 and PIT1 unused for anyone else who needs them.
-	 */
-	clksrc_base =3D timer_base + PITn_OFFSET(2);
-	clkevt_base =3D timer_base + PITn_OFFSET(3);
-
-	irq =3D irq_of_parse_and_map(np, 0);
-	if (irq <=3D 0)
-		return -EINVAL;
-
-	pit_clk =3D of_clk_get(np, 0);
-	if (IS_ERR(pit_clk))
-		return PTR_ERR(pit_clk);
-
-	ret =3D clk_prepare_enable(pit_clk);
-	if (ret)
-		return ret;
-
-	clk_rate =3D clk_get_rate(pit_clk);
-	cycle_per_jiffy =3D clk_rate / (HZ);
-
-	/* enable the pit module */
-	__raw_writel(~PITMCR_MDIS, timer_base + PITMCR);
-
-	ret =3D pit_clocksource_init(clk_rate);
-	if (ret)
-		return ret;
-
-	return pit_clockevent_init(clk_rate, irq);
-}
-TIMER_OF_DECLARE(vf610, "fsl,vf610-pit", pit_timer_init);
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 74aaea61de13..d2b690857e58 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -519,6 +519,7 @@ int of_irq_count(struct device_node *dev)
=20
 	return nr;
 }
+EXPORT_SYMBOL_GPL(of_irq_count);
=20
 /**
  * of_irq_to_resource_table - Fill in resource table with node's IRQ info
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_a=
rch_timer.h
index ce6521ad04d1..2eda895f19f5 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -9,9 +9,6 @@
 #include <linux/timecounter.h>
 #include <linux/types.h>
=20
-#define ARCH_TIMER_TYPE_CP15		BIT(0)
-#define ARCH_TIMER_TYPE_MEM		BIT(1)
-
 #define ARCH_TIMER_CTRL_ENABLE		(1 << 0)
 #define ARCH_TIMER_CTRL_IT_MASK		(1 << 1)
 #define ARCH_TIMER_CTRL_IT_STAT		(1 << 2)
@@ -51,8 +48,6 @@ enum arch_timer_spi_nr {
=20
 #define ARCH_TIMER_PHYS_ACCESS		0
 #define ARCH_TIMER_VIRT_ACCESS		1
-#define ARCH_TIMER_MEM_PHYS_ACCESS	2
-#define ARCH_TIMER_MEM_VIRT_ACCESS	3
=20
 #define ARCH_TIMER_MEM_MAX_FRAMES	8
=20
diff --git a/include/linux/platform_data/dmtimer-omap.h b/include/linux/platf=
orm_data/dmtimer-omap.h
index 95d852aef130..726d89143842 100644
--- a/include/linux/platform_data/dmtimer-omap.h
+++ b/include/linux/platform_data/dmtimer-omap.h
@@ -36,9 +36,13 @@ struct omap_dm_timer_ops {
 	int	(*set_pwm)(struct omap_dm_timer *timer, int def_on,
 			   int toggle, int trigger, int autoreload);
 	int	(*get_pwm_status)(struct omap_dm_timer *timer);
+	int	(*set_cap)(struct omap_dm_timer *timer,
+			   int autoreload, bool config_period);
+	int	(*get_cap_status)(struct omap_dm_timer *timer);
 	int	(*set_prescaler)(struct omap_dm_timer *timer, int prescaler);
=20
 	unsigned int (*read_counter)(struct omap_dm_timer *timer);
+	unsigned int (*read_cap)(struct omap_dm_timer *timer, bool is_period);
 	int	(*write_counter)(struct omap_dm_timer *timer,
 				 unsigned int value);
 	unsigned int (*read_status)(struct omap_dm_timer *timer);
diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index cc15fe293719..cc1afec306b3 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -174,8 +174,7 @@ static enum hrtimer_restart sched_clock_poll(struct hrtim=
er *hrt)
 	return HRTIMER_RESTART;
 }
=20
-void __init
-sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
+void sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
 {
 	u64 res, wrap, new_mask, new_epoch, cyc, ns;
 	u32 new_mult, new_shift;
@@ -247,6 +246,7 @@ sched_clock_register(u64 (*read)(void), int bits, unsigne=
d long rate)
=20
 	pr_debug("Registered %pS as sched_clock source\n", read);
 }
+EXPORT_SYMBOL_GPL(sched_clock_register);
=20
 void __init generic_sched_clock_init(void)
 {



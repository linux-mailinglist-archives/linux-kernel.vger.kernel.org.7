Return-Path: <linux-kernel+bounces-747311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 995DFB13249
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 00:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E4D16B103
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 22:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEA725486A;
	Sun, 27 Jul 2025 22:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EGpx4NO9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/yifLXB7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0B6253957
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 22:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753655885; cv=none; b=b/7ZfjOeCHWshobfrUHn24YRejCCgfuYhxWi3L/bV2Mvof2Gb4YEDs+66zr2PLzmCq8sl2W5PTvsxvXPbp0997Q+i9b2wOP87AP5D3nEjwUef8Zr7dVeO1AApSdD1q5nUI+hcMwtQzH2KpkjnHDhpeqxq53hsbJQ+kjejuxL3hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753655885; c=relaxed/simple;
	bh=cfifdXi3yD7BFykFcT77B+8A/2BpJ8tbC1H+2uHrlH0=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=nEO0PFmVv8oFNA47pEOJ98h0t32J9s5zG7O6QZnEfuZWtEfoTe8uSFY+jgXTH6md8pwR+Dp489rDPElg04jsBMq8BgpsbPrfK0VSi0xPDBbd4eEritKXswd5wWAdiAT5G3ho4WBeWcFgw64xZYPHULuP+oQfDZowOKDz1GMonRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EGpx4NO9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/yifLXB7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753655880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=n+7QhmRGvIfG5VcR28UYBF/juLm+PghDOEkj/8rL930=;
	b=EGpx4NO9LsdlzPyY3oPpA22MgYYATrPu9Rv8PRvYN5d0C/4FYIkHTKn2qU+GAx0s1LlGZL
	+iRnXoiJ9CggvP+sZpUVFs1LNfUFTCYhZj2o5WIjL0SHiA85N2W80am19Ah4K2cOhPthXK
	FqQIYcmAB+4zzqvV3g3qFLKJeP9EQ1hXHxK/r1U0qYQ9hyDAn1wxHhAcOfMOSS1fSjZc92
	1GGYdspkdl4zHW+sHvyy/j4MNb9FHSFvgSJki63wVfUIPNgmFfOk/ALNFC88NBoJJvsTvQ
	ZZuKY/z/fUg2AqtZTyHIYN1GhXm8DM2blQwB3VuUHckVoB3TmMfuCBdQFlIvFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753655881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=n+7QhmRGvIfG5VcR28UYBF/juLm+PghDOEkj/8rL930=;
	b=/yifLXB7yv5Ncmcx26o/GYhd/5Hd3l9AvSW4L2/47SUKwVa+z2hTeMwiFnH/6UhIHobMG3
	oGdUsA/cGUWc84Bw==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/clocksource for v6.17-rc1
References: <175365567943.581055.6806236199247802443.tglx@xen13>
Message-ID: <175365568847.581055.10274659151998359690.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Jul 2025 00:38:00 +0200 (CEST)

Linus,

please pull the latest timers/clocksource branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-clocksour=
ce-2025-07-27

up to:  85198c87e484: clocksource/drivers/exynos_mct: Fix section mismatch fr=
om the module conversion


A set of clocksource/event driver updates:

 - Another set of changes to support modular drivers

 - The usual lump of device tree updates to support new variants and to
   cleanup the existing ones

 - The usual small fixes, improvement and cleanups all over the place

Note: All of these commits have been exposed to next with a different SHA
      for quite some time, but had to be rebased due to some late noticed
      S-O-B chain hickups a few days ago.

Thanks,

	tglx

------------------>
AngeloGioacchino Del Regno (1):
      dt-bindings: timer: mediatek,timer: Add MediaTek MT8196 compatible

Arnd Bergmann (1):
      clocksource/drivers/tegra186: Avoid 64-bit division

Ben Zong-You Xie (1):
      dt-bindings: timer: Add Andes machine timer

Chen Ni (1):
      clocksource/timer-econet-en751221: Convert comma to semicolon

Daniel Lezcano (8):
      clocksource/drivers/scx200: Add module owner
      clocksource/drivers/stm32-lp: Add module owner
      clocksource/drivers/sun5i: Add module owner
      clocksource/drivers/tegra186: Add module owner
      clocksource/drivers/stm: Add module owner
      clocksource/drivers/cs5535: Add module owner
      time/sched_clock: Export symbol for sched_clock_register() function
      clocksource/drivers/exynos_mct: Fix section mismatch from the module co=
nversion

Donghoon Yu (2):
      clocksource/drivers/exynos_mct: Don't register as a sched_clock on arm64
      clocksource/drivers/exynos_mct: Add module support

Frank Li (2):
      dt-bindings: timer: fsl,ftm-timer: Use 'items' for 'reg'
      dt-bindings: timer: Add fsl,timrot.yaml

Guenter Roeck (2):
      clocksource/drivers/timer-tegra186: Avoid 64-bit divide operation
      clocksource/drivers/timer-tegra186: Simplify calculating timeleft

Hosung Kim (1):
      clocksource/drivers/exynos_mct: Set local timer interrupts as percpu

Max Shevchenko (1):
      dt-bindings: timer: mediatek: Add MT6572

Rob Herring (Arm) (1):
      dt-bindings: timer: Convert faraday,fttmr010 to DT schema

Will McVicker (3):
      of/irq: Export of_irq_count() for modules
      clocksource/drivers/exynos_mct: Fix uninitialized IRQ name warning
      arm64: exynos: Drop select CLKSRC_EXYNOS_MCT


 .../devicetree/bindings/timer/andestech,plmt0.yaml | 53 +++++++++++++
 .../devicetree/bindings/timer/faraday,fttmr010.txt | 38 ---------
 .../bindings/timer/faraday,fttmr010.yaml           | 89 ++++++++++++++++++++=
++
 .../devicetree/bindings/timer/fsl,ftm-timer.yaml   |  7 +-
 .../devicetree/bindings/timer/fsl,timrot.yaml      | 48 ++++++++++++
 .../devicetree/bindings/timer/mediatek,timer.yaml  |  2 +
 arch/arm64/Kconfig.platforms                       |  1 -
 drivers/clocksource/Kconfig                        |  3 +-
 drivers/clocksource/exynos_mct.c                   | 75 ++++++++++++++----
 drivers/clocksource/scx200_hrt.c                   |  1 +
 drivers/clocksource/timer-cs5535.c                 |  1 +
 drivers/clocksource/timer-econet-en751221.c        |  2 +-
 drivers/clocksource/timer-nxp-stm.c                |  2 +
 drivers/clocksource/timer-stm32-lp.c               |  1 +
 drivers/clocksource/timer-sun5i.c                  |  2 +
 drivers/clocksource/timer-tegra186.c               | 30 +++++---
 drivers/of/irq.c                                   |  1 +
 kernel/time/sched_clock.c                          |  4 +-
 18 files changed, 290 insertions(+), 70 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/andestech,plmt0.y=
aml
 delete mode 100644 Documentation/devicetree/bindings/timer/faraday,fttmr010.=
txt
 create mode 100644 Documentation/devicetree/bindings/timer/faraday,fttmr010.=
yaml
 create mode 100644 Documentation/devicetree/bindings/timer/fsl,timrot.yaml

diff --git a/Documentation/devicetree/bindings/timer/andestech,plmt0.yaml b/D=
ocumentation/devicetree/bindings/timer/andestech,plmt0.yaml
new file mode 100644
index 000000000000..90b612096004
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/andestech,plmt0.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/andestech,plmt0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Andes machine-level timer
+
+description:
+  The Andes machine-level timer device (PLMT0) provides machine-level timer
+  functionality for a set of HARTs on a RISC-V platform. It has a single
+  fixed-frequency monotonic time counter (MTIME) register and a time compare
+  register (MTIMECMP) for each HART connected to the PLMT0. A timer interrup=
t is
+  generated if MTIME >=3D MTIMECMP.
+
+maintainers:
+  - Ben Zong-You Xie <ben717@andestech.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - andestech,qilai-plmt
+      - const: andestech,plmt0
+
+  reg:
+    maxItems: 1
+
+  interrupts-extended:
+    minItems: 1
+    maxItems: 32
+    description:
+      Specifies which harts are connected to the PLMT0. Each item must points
+      to a riscv,cpu-intc node, which has a riscv cpu node as parent. The
+      PLMT0 supports 1 hart up to 32 harts.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts-extended
+
+examples:
+  - |
+    interrupt-controller@100000 {
+      compatible =3D "andestech,qilai-plmt", "andestech,plmt0";
+      reg =3D <0x100000 0x100000>;
+      interrupts-extended =3D <&cpu0intc 7>,
+                            <&cpu1intc 7>,
+                            <&cpu2intc 7>,
+                            <&cpu3intc 7>;
+    };
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
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index a541bb029aa4..46825b02d099 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -109,7 +109,6 @@ config ARCH_BLAIZE
 config ARCH_EXYNOS
 	bool "Samsung Exynos SoC family"
 	select COMMON_CLK_SAMSUNG
-	select CLKSRC_EXYNOS_MCT
 	select EXYNOS_PM_DOMAINS if PM_GENERIC_DOMAINS
 	select EXYNOS_PMU
 	select PINCTRL
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 645f517a1ac2..d657c8ddc96b 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -451,7 +451,8 @@ config ATMEL_TCB_CLKSRC
 	  Support for Timer Counter Blocks on Atmel SoCs.
=20
 config CLKSRC_EXYNOS_MCT
-	bool "Exynos multi core timer driver" if COMPILE_TEST
+	tristate "Exynos multi core timer driver" if ARM64
+	default y if ARCH_EXYNOS || COMPILE_TEST
 	depends on ARM || ARM64
 	depends on ARCH_ARTPEC || ARCH_EXYNOS || COMPILE_TEST
 	help
diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mc=
t.c
index da09f467a6bb..80d263ee046d 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -15,9 +15,11 @@
 #include <linux/cpu.h>
 #include <linux/delay.h>
 #include <linux/percpu.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
+#include <linux/platform_device.h>
 #include <linux/clocksource.h>
 #include <linux/sched_clock.h>
=20
@@ -217,14 +219,21 @@ static struct clocksource mct_frc =3D {
 	.mask		=3D CLOCKSOURCE_MASK(32),
 	.flags		=3D CLOCK_SOURCE_IS_CONTINUOUS,
 	.resume		=3D exynos4_frc_resume,
+	.owner		=3D THIS_MODULE,
 };
=20
+/*
+ * Since ARM devices do not have an architected timer, they need to continue
+ * using the MCT as the main clocksource for timekeeping, sched_clock, and t=
he
+ * delay timer. For AARCH64 SoCs, the architected timer is the preferred
+ * clocksource due to it's superior performance.
+ */
+#if defined(CONFIG_ARM)
 static u64 notrace exynos4_read_sched_clock(void)
 {
 	return exynos4_read_count_32();
 }
=20
-#if defined(CONFIG_ARM)
 static struct delay_timer exynos4_delay_timer;
=20
 static cycles_t exynos4_read_current_timer(void)
@@ -235,7 +244,7 @@ static cycles_t exynos4_read_current_timer(void)
 }
 #endif
=20
-static int __init exynos4_clocksource_init(bool frc_shared)
+static int exynos4_clocksource_init(bool frc_shared)
 {
 	/*
 	 * When the frc is shared, the main processor should have already
@@ -250,12 +259,13 @@ static int __init exynos4_clocksource_init(bool frc_sha=
red)
 	exynos4_delay_timer.read_current_timer =3D &exynos4_read_current_timer;
 	exynos4_delay_timer.freq =3D clk_rate;
 	register_current_timer_delay(&exynos4_delay_timer);
+
+	sched_clock_register(exynos4_read_sched_clock, 32, clk_rate);
 #endif
=20
 	if (clocksource_register_hz(&mct_frc, clk_rate))
 		panic("%s: can't register clocksource\n", mct_frc.name);
=20
-	sched_clock_register(exynos4_read_sched_clock, 32, clk_rate);
=20
 	return 0;
 }
@@ -329,6 +339,7 @@ static struct clock_event_device mct_comp_device =3D {
 	.set_state_oneshot	=3D mct_set_state_shutdown,
 	.set_state_oneshot_stopped =3D mct_set_state_shutdown,
 	.tick_resume		=3D mct_set_state_shutdown,
+	.owner			=3D THIS_MODULE,
 };
=20
 static irqreturn_t exynos4_mct_comp_isr(int irq, void *dev_id)
@@ -458,8 +469,6 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
 		per_cpu_ptr(&percpu_mct_tick, cpu);
 	struct clock_event_device *evt =3D &mevt->evt;
=20
-	snprintf(mevt->name, sizeof(mevt->name), "mct_tick%d", cpu);
-
 	evt->name =3D mevt->name;
 	evt->cpumask =3D cpumask_of(cpu);
 	evt->set_next_event =3D exynos4_tick_set_next_event;
@@ -471,6 +480,7 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
 	evt->features =3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
 			CLOCK_EVT_FEAT_PERCPU;
 	evt->rating =3D MCT_CLKEVENTS_RATING;
+	evt->owner =3D THIS_MODULE;
=20
 	exynos4_mct_write(TICK_BASE_CNT, mevt->base + MCT_L_TCNTB_OFFSET);
=20
@@ -506,7 +516,7 @@ static int exynos4_mct_dying_cpu(unsigned int cpu)
 	return 0;
 }
=20
-static int __init exynos4_timer_resources(struct device_node *np)
+static int exynos4_timer_resources(struct device_node *np)
 {
 	struct clk *mct_clk, *tick_clk;
=20
@@ -534,7 +544,7 @@ static int __init exynos4_timer_resources(struct device_n=
ode *np)
  * @local_idx: array mapping CPU numbers to local timer indices
  * @nr_local: size of @local_idx array
  */
-static int __init exynos4_timer_interrupts(struct device_node *np,
+static int exynos4_timer_interrupts(struct device_node *np,
 					   unsigned int int_type,
 					   const u32 *local_idx,
 					   size_t nr_local)
@@ -560,6 +570,14 @@ static int __init exynos4_timer_interrupts(struct device=
_node *np,
 	for (i =3D MCT_L0_IRQ; i < nr_irqs; i++)
 		mct_irqs[i] =3D irq_of_parse_and_map(np, i);
=20
+	for_each_possible_cpu(cpu) {
+		struct mct_clock_event_device *mevt =3D
+		    per_cpu_ptr(&percpu_mct_tick, cpu);
+
+		snprintf(mevt->name, sizeof(mevt->name), "mct_tick%d",
+			 cpu);
+	}
+
 	if (mct_int_type =3D=3D MCT_INT_PPI) {
=20
 		err =3D request_percpu_irq(mct_irqs[MCT_L0_IRQ],
@@ -589,7 +607,8 @@ static int __init exynos4_timer_interrupts(struct device_=
node *np,
 			irq_set_status_flags(mct_irq, IRQ_NOAUTOEN);
 			if (request_irq(mct_irq,
 					exynos4_mct_tick_isr,
-					IRQF_TIMER | IRQF_NOBALANCING,
+					IRQF_TIMER | IRQF_NOBALANCING |
+					IRQF_PERCPU,
 					pcpu_mevt->name, pcpu_mevt)) {
 				pr_err("exynos-mct: cannot register IRQ (cpu%d)\n",
 									cpu);
@@ -638,7 +657,7 @@ static int __init exynos4_timer_interrupts(struct device_=
node *np,
 	return err;
 }
=20
-static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
+static __init_or_module int mct_init_dt(struct device_node *np, unsigned int=
 int_type)
 {
 	bool frc_shared =3D of_property_read_bool(np, "samsung,frc-shared");
 	u32 local_idx[MCT_NR_LOCAL] =3D {0};
@@ -686,15 +705,43 @@ static int __init mct_init_dt(struct device_node *np, u=
nsigned int int_type)
 	return exynos4_clockevent_init();
 }
=20
-
-static int __init mct_init_spi(struct device_node *np)
+static __init_or_module int mct_init_spi(struct device_node *np)
 {
 	return mct_init_dt(np, MCT_INT_SPI);
 }
=20
-static int __init mct_init_ppi(struct device_node *np)
+static __init_or_module int mct_init_ppi(struct device_node *np)
 {
 	return mct_init_dt(np, MCT_INT_PPI);
 }
-TIMER_OF_DECLARE(exynos4210, "samsung,exynos4210-mct", mct_init_spi);
-TIMER_OF_DECLARE(exynos4412, "samsung,exynos4412-mct", mct_init_ppi);
+
+static int exynos4_mct_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	int (*mct_init)(struct device_node *np);
+
+	mct_init =3D of_device_get_match_data(dev);
+	if (!mct_init)
+		return -EINVAL;
+
+	return mct_init(dev->of_node);
+}
+
+static const struct of_device_id exynos4_mct_match_table[] =3D {
+	{ .compatible =3D "samsung,exynos4210-mct", .data =3D &mct_init_spi, },
+	{ .compatible =3D "samsung,exynos4412-mct", .data =3D &mct_init_ppi, },
+	{}
+};
+MODULE_DEVICE_TABLE(of, exynos4_mct_match_table);
+
+static struct platform_driver exynos4_mct_driver =3D {
+	.probe		=3D exynos4_mct_probe,
+	.driver		=3D {
+		.name	=3D "exynos-mct",
+		.of_match_table =3D exynos4_mct_match_table,
+	},
+};
+module_platform_driver(exynos4_mct_driver);
+
+MODULE_DESCRIPTION("Exynos Multi Core Timer Driver");
+MODULE_LICENSE("GPL");
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
index e5394f98a02e..1ec7b38ff8c6 100644
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
@@ -373,6 +378,7 @@ static int tegra186_timer_tsc_init(struct tegra186_timer =
*tegra)
 	tegra->tsc.read =3D tegra186_timer_tsc_read;
 	tegra->tsc.mask =3D CLOCKSOURCE_MASK(56);
 	tegra->tsc.flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
+	tegra->tsc.owner =3D THIS_MODULE;
=20
 	return clocksource_register_hz(&tegra->tsc, 31250000);
 }
@@ -392,6 +398,7 @@ static int tegra186_timer_osc_init(struct tegra186_timer =
*tegra)
 	tegra->osc.read =3D tegra186_timer_osc_read;
 	tegra->osc.mask =3D CLOCKSOURCE_MASK(32);
 	tegra->osc.flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
+	tegra->osc.owner =3D THIS_MODULE;
=20
 	return clocksource_register_hz(&tegra->osc, 38400000);
 }
@@ -411,6 +418,7 @@ static int tegra186_timer_usec_init(struct tegra186_timer=
 *tegra)
 	tegra->usec.read =3D tegra186_timer_usec_read;
 	tegra->usec.mask =3D CLOCKSOURCE_MASK(32);
 	tegra->usec.flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
+	tegra->usec.owner =3D THIS_MODULE;
=20
 	return clocksource_register_hz(&tegra->usec, USEC_PER_SEC);
 }
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index f8ad79b9b1c9..5adda1dac3cf 100644
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



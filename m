Return-Path: <linux-kernel+bounces-836053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2411BA8A02
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C9D97B4B5E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEB6286438;
	Mon, 29 Sep 2025 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="taaxEP2Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MWwmd1NS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B382C08B6
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138149; cv=none; b=LJdfYQ1/CphA3oQiUhuWhTlZU3898ErGV4p03Mw3RFZTvpiyS5CvEBYEHDRSSiiVaQTm6J7GW06/8tg98aH7FPznH3F6sHM0/mNGOjHS0lV1L3FjM7M8Hgi+oPwSZT5t0s1/qRcT1AdT+VMV8znt0Lb4cgkVlfLDmkb/IhPpQsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138149; c=relaxed/simple;
	bh=oU0kmHLAhIa8Ce27epkcuqW77bHaV9d4sMIjY95KoLA=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=KRlFaYxTQ9uACkCoa0UM7W7m4x/gAmM2gb3dmzkdIwB7EzeNRWw9CXfCmd7y67YgSGjzuxwhQWrVxGjCoCI95RFsUXQsZB/+QX7CB/Pfm29cOv6vY3OuwhrCpV9EPTd2OZ390yLvNcobX1BQjD7zIPr6VxfUG2gv5hAwewaY0bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=taaxEP2Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MWwmd1NS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759138142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=nteEsCHVcWskM5COz3eO6xMJTZKvdTm+VUaWGzcbEQk=;
	b=taaxEP2Z73gP8AiUGSpnQxVOBJEbMQHqEpeMbNcUjyHLxfWOfcNLikxwyOy8yfMrr/roa8
	dxUlD0W7XNsVGSy3bPP0CkKIAGdEgDeav2066t0siYRtNuBYaTfDyjbrW3fvX2NMrS1BfM
	+WNILsM2dCSuORInVEfd44N8z7ofr7MJ5S6+pBV+v8D706UzyDA+3WlFq4SBStaIJRhofy
	dDTTI+4SH7kfnhC29GUNI4wo/PtmkHZGWlXtfTAzgx8Wnfh0p1UxUA0oilsXgg2JdvTse5
	BakVPKUl5OKPuNRtUfDf6ZEvvzUj0HxOVA6Zh/6VuOi/nQTEf34t7qR+V3J83w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759138142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=nteEsCHVcWskM5COz3eO6xMJTZKvdTm+VUaWGzcbEQk=;
	b=MWwmd1NSQGERfCVZ0n2jrB2MiD1wTf4aiWD0euB3jY9IzLZMKDUmj1yqTAqv42KQtHviYS
	OjslHWr/LW9wQ4Bg==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/drivers for v6.18-rc1
References: <175913807599.495041.10251515322736195577.tglx@xen13>
Message-ID: <175913808134.495041.9905645262400358240.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 29 Sep 2025 11:29:00 +0200 (CEST)

Linus,

please pull the latest irq/drivers branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-drivers-2025=
-09-29

up to:  c33c43f71bda: irqchip/loongson-pch-lpc: Use legacy domain for PCH-LPC=
 IRQ controller

Updates for interrupt chip drivers:

  - Use the startup/shutdown callbacks for the PCI/MSI per device interrupt
    domains.

    This allows to initialize the RISCV PLIC interrupt hierarchy correctly
    and provides a mechanism to decouple the masking and unmasking during
    run-time from the expensive PCI mask and unmask when the underlying MSI
    provider implementation allows the interrupt to be masked.

  - Initialize the RISCV PLIC MSI interrupt hierarchy correctly so that the
    affinity assignment works correctly by switching it over to the
    startup/shutdown scheme

  - Allow MSI providers to opt out from masking a PCI/MSI interrupt at the
    PCI device during operation when the provider can mask the interrupt at
    the underlying interrupt chip. This reduces the overhead in scenarios
    where disable_irq()/enable_irq() is utilized frequently by a driver.

    The PCI/MSI device level [un]masking is only required on startup and
    shutdown in this case.

  - Remove the conditional mask/unmask logic in the PCI/MSI layer as this
    is now handled unconditionally.

  - Replace the hardcoded interrupt routing in the Loongson EIOINTC
    interrupt driver to respect the firmware settings and spread them out
    to different CPU interrupt inputs so that the demultiplexing handler
    only needs to read only a single 64-bit status register instead of
    four, which significantly reduces the overhead in VMs as the status
    register access causes a VM exit.

  - Add support for the new AST2700 SCU interrupt controllers

  - Use the legacy interrupt domain setup for the Loongson PCH-LPC
    interrupt controller, which resembles the x86 legacy PIC setup and has
    the same hardcoded legacy requirements.

  - The usual set of cleanups, fixes and improvements all over the place

Thanks,

	tglx

------------------>
Bibo Mao (2):
      irqchip/loongson-eiointc: Route interrupt parsed from bios table
      irqchip/loongson-eiointc: Add multiple interrupt pin routing support

Chen Wang (3):
      riscv: sophgo: dts: sg2042: Change msi irq type to IRQ_TYPE_EDGE_RISING
      riscv: sophgo: dts: sg2044: Change msi irq type to IRQ_TYPE_EDGE_RISING
      irqchip/sg2042-msi: Set irq type according to DT configuration

Christian Bruel (1):
      irqchip/gic-v2m: Handle Multiple MSI base IRQ Alignment

Dan Carpenter (3):
      irqchip/gic-v5: Delete a stray tab
      irqchip/gic-v5: Fix loop in gicv5_its_create_itt_two_level() cleanup pa=
th
      irqchip/gic-v5: Fix error handling in gicv5_its_irq_domain_alloc()

Fushuai Wang (1):
      irqchip/sifive-plic: Use for_each_present_cpu() instead of for_each_cpu=
()

Inochi Amaoto (6):
      genirq: Add irq_chip_(startup/shutdown)_parent()
      PCI/MSI: Add startup/shutdown for per device domains
      irqchip/sg2042-msi: Fix broken affinity setting
      irqchip/sg2042-msi: Set MSI_FLAG_MULTI_PCI_MSI flags for SG2044
      irqchip/sifive-plic: Respect mask state when setting affinity
      PCI/MSI: Check MSI_FLAG_PCI_MSI_MASK_PARENT in cond_[startup|shutdown]_=
parent()

Marc Zyngier (1):
      irqchip/msi-lib: Honor the MSI_FLAG_PCI_MSI_MASK_PARENT flag

Ming Wang (1):
      irqchip/loongson-pch-lpc: Use legacy domain for PCH-LPC IRQ controller

Qianfeng Rong (1):
      irqchip: Use int type to store negative error codes

Ryan Chen (4):
      irqchip/aspeed-scu-ic: Refactor driver to support variant-based initial=
ization
      dt-bindings: mfd: aspeed: Add AST2700 SCU compatibles
      dt-bindings: interrupt-controller: aspeed: Add AST2700 SCU IC compatibl=
es
      irqchip/aspeed-scu-ic: Add support for AST2700 SCU interrupt controllers

Sebastian Andrzej Siewior (1):
      genirq: Remove GENERIC_IRQ_LEGACY

Thomas Gleixner (1):
      PCI/MSI: Remove the conditional parent [un]mask logic

Xichao Zhao (1):
      irqchip/renesas-rzg2l: Remove dev_err_probe() if error is -ENOMEM

Zenghui Yu (1):
      irqchip/gic-v5: Remove the redundant ITS cache invalidation


 .../aspeed,ast2500-scu-ic.yaml                     |   6 +-
 .../bindings/mfd/aspeed,ast2x00-scu.yaml           |   4 +
 arch/riscv/boot/dts/sophgo/sg2042.dtsi             |   2 +-
 arch/riscv/boot/dts/sophgo/sg2044.dtsi             |   2 +-
 drivers/irqchip/irq-aspeed-scu-ic.c                | 256 +++++++++++++------=
--
 drivers/irqchip/irq-gic-v2m.c                      |  13 +-
 drivers/irqchip/irq-gic-v3.c                       |   3 +-
 drivers/irqchip/irq-gic-v5-irs.c                   |   2 +-
 drivers/irqchip/irq-gic-v5-its.c                   |  26 ++-
 drivers/irqchip/irq-loongson-eiointc.c             | 105 ++++++++-
 drivers/irqchip/irq-loongson-pch-lpc.c             |   9 +-
 drivers/irqchip/irq-msi-lib.c                      |  14 ++
 drivers/irqchip/irq-nvic.c                         |   3 +-
 drivers/irqchip/irq-renesas-rza1.c                 |   3 +-
 drivers/irqchip/irq-renesas-rzg2l.c                |   2 +-
 drivers/irqchip/irq-sg2042-msi.c                   |  26 ++-
 drivers/irqchip/irq-sifive-plic.c                  |  10 +-
 drivers/pci/msi/irqdomain.c                        |  53 ++++-
 .../interrupt-controller/aspeed-scu-ic.h           |  14 ++
 include/linux/irq.h                                |   6 +-
 include/linux/msi.h                                |   2 +
 kernel/irq/Kconfig                                 |   4 -
 kernel/irq/chip.c                                  |  37 +++
 kernel/irq/irqdesc.c                               |   7 -
 24 files changed, 438 insertions(+), 171 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,as=
t2500-scu-ic.yaml b/Documentation/devicetree/bindings/interrupt-controller/as=
peed,ast2500-scu-ic.yaml
index d5287a2bf866..d998a9d69b91 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2500-s=
cu-ic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2500-s=
cu-ic.yaml
@@ -5,7 +5,7 @@
 $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2500-scu-i=
c.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
=20
-title: Aspeed AST25XX and AST26XX SCU Interrupt Controller
+title: Aspeed AST25XX, AST26XX, AST27XX SCU Interrupt Controller
=20
 maintainers:
   - Eddie James <eajames@linux.ibm.com>
@@ -16,6 +16,10 @@ properties:
       - aspeed,ast2500-scu-ic
       - aspeed,ast2600-scu-ic0
       - aspeed,ast2600-scu-ic1
+      - aspeed,ast2700-scu-ic0
+      - aspeed,ast2700-scu-ic1
+      - aspeed,ast2700-scu-ic2
+      - aspeed,ast2700-scu-ic3
=20
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml b/=
Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
index 5eccd10d95ce..67be6d095fe4 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
+++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
@@ -75,6 +75,10 @@ patternProperties:
             - aspeed,ast2500-scu-ic
             - aspeed,ast2600-scu-ic0
             - aspeed,ast2600-scu-ic1
+            - aspeed,ast2700-scu-ic0
+            - aspeed,ast2700-scu-ic1
+            - aspeed,ast2700-scu-ic2
+            - aspeed,ast2700-scu-ic3
=20
   '^silicon-id@[0-9a-f]+$':
     description: Unique hardware silicon identifiers within the SoC
diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sop=
hgo/sg2042.dtsi
index b3e4d3c18fdc..6430c6e25c00 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -190,7 +190,7 @@ msi: msi-controller@7030010304 {
 			reg-names =3D "clr", "doorbell";
 			msi-controller;
 			#msi-cells =3D <0>;
-			msi-ranges =3D <&intc 64 IRQ_TYPE_LEVEL_HIGH 32>;
+			msi-ranges =3D <&intc 64 IRQ_TYPE_EDGE_RISING 32>;
 		};
=20
 		rpgate: clock-controller@7030010368 {
diff --git a/arch/riscv/boot/dts/sophgo/sg2044.dtsi b/arch/riscv/boot/dts/sop=
hgo/sg2044.dtsi
index 6ec955744b0c..320c4d1d08e6 100644
--- a/arch/riscv/boot/dts/sophgo/sg2044.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2044.dtsi
@@ -214,7 +214,7 @@ msi: msi-controller@6d50000000 {
 			reg-names =3D "clr", "doorbell";
 			#msi-cells =3D <0>;
 			msi-controller;
-			msi-ranges =3D <&intc 352 IRQ_TYPE_LEVEL_HIGH 512>;
+			msi-ranges =3D <&intc 352 IRQ_TYPE_EDGE_RISING 512>;
 			status =3D "disabled";
 		};
=20
diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c b/drivers/irqchip/irq-aspeed=
-scu-ic.c
index 1c7045467c48..5584e0f82cce 100644
--- a/drivers/irqchip/irq-aspeed-scu-ic.c
+++ b/drivers/irqchip/irq-aspeed-scu-ic.c
@@ -1,61 +1,78 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Aspeed AST24XX, AST25XX, and AST26XX SCU Interrupt Controller
+ * Aspeed AST24XX, AST25XX, AST26XX, and AST27XX SCU Interrupt Controller
  * Copyright 2019 IBM Corporation
  *
  * Eddie James <eajames@linux.ibm.com>
  */
=20
 #include <linux/bitops.h>
+#include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
-#include <linux/mfd/syscon.h>
+#include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/regmap.h>
=20
-#define ASPEED_SCU_IC_REG		0x018
-#define ASPEED_SCU_IC_SHIFT		0
-#define ASPEED_SCU_IC_ENABLE		GENMASK(15, ASPEED_SCU_IC_SHIFT)
-#define ASPEED_SCU_IC_NUM_IRQS		7
 #define ASPEED_SCU_IC_STATUS		GENMASK(28, 16)
 #define ASPEED_SCU_IC_STATUS_SHIFT	16
+#define AST2700_SCU_IC_STATUS		GENMASK(15, 0)
+
+struct aspeed_scu_ic_variant {
+	const char	*compatible;
+	unsigned long	irq_enable;
+	unsigned long	irq_shift;
+	unsigned int	num_irqs;
+	unsigned long	ier;
+	unsigned long	isr;
+};
=20
-#define ASPEED_AST2600_SCU_IC0_REG	0x560
-#define ASPEED_AST2600_SCU_IC0_SHIFT	0
-#define ASPEED_AST2600_SCU_IC0_ENABLE	\
-	GENMASK(5, ASPEED_AST2600_SCU_IC0_SHIFT)
-#define ASPEED_AST2600_SCU_IC0_NUM_IRQS	6
+#define SCU_VARIANT(_compat, _shift, _enable, _num, _ier, _isr) {	\
+	.compatible		=3D	_compat,	\
+	.irq_shift		=3D	_shift,		\
+	.irq_enable		=3D	_enable,	\
+	.num_irqs		=3D	_num,		\
+	.ier			=3D	_ier,		\
+	.isr			=3D	_isr,		\
+}
=20
-#define ASPEED_AST2600_SCU_IC1_REG	0x570
-#define ASPEED_AST2600_SCU_IC1_SHIFT	4
-#define ASPEED_AST2600_SCU_IC1_ENABLE	\
-	GENMASK(5, ASPEED_AST2600_SCU_IC1_SHIFT)
-#define ASPEED_AST2600_SCU_IC1_NUM_IRQS	2
+static const struct aspeed_scu_ic_variant scu_ic_variants[]	__initconst =3D {
+	SCU_VARIANT("aspeed,ast2400-scu-ic",	0, GENMASK(15, 0),	7, 0x00, 0x00),
+	SCU_VARIANT("aspeed,ast2500-scu-ic",	0, GENMASK(15, 0),	7, 0x00, 0x00),
+	SCU_VARIANT("aspeed,ast2600-scu-ic0",	0, GENMASK(5, 0),	6, 0x00, 0x00),
+	SCU_VARIANT("aspeed,ast2600-scu-ic1",	4, GENMASK(5, 4),	2, 0x00, 0x00),
+	SCU_VARIANT("aspeed,ast2700-scu-ic0",	0, GENMASK(3, 0),	4, 0x00, 0x04),
+	SCU_VARIANT("aspeed,ast2700-scu-ic1",	0, GENMASK(3, 0),	4, 0x00, 0x04),
+	SCU_VARIANT("aspeed,ast2700-scu-ic2",	0, GENMASK(3, 0),	4, 0x04, 0x00),
+	SCU_VARIANT("aspeed,ast2700-scu-ic3",	0, GENMASK(1, 0),	2, 0x04, 0x00),
+};
=20
 struct aspeed_scu_ic {
-	unsigned long irq_enable;
-	unsigned long irq_shift;
-	unsigned int num_irqs;
-	unsigned int reg;
-	struct regmap *scu;
-	struct irq_domain *irq_domain;
+	unsigned long		irq_enable;
+	unsigned long		irq_shift;
+	unsigned int		num_irqs;
+	void __iomem		*base;
+	struct irq_domain	*irq_domain;
+	unsigned long		ier;
+	unsigned long		isr;
 };
=20
-static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
+static inline bool scu_has_split_isr(struct aspeed_scu_ic *scu)
+{
+	return scu->ier !=3D scu->isr;
+}
+
+static void aspeed_scu_ic_irq_handler_combined(struct irq_desc *desc)
 {
-	unsigned int sts;
-	unsigned long bit;
-	unsigned long enabled;
-	unsigned long max;
-	unsigned long status;
 	struct aspeed_scu_ic *scu_ic =3D irq_desc_get_handler_data(desc);
 	struct irq_chip *chip =3D irq_desc_get_chip(desc);
-	unsigned int mask =3D scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT;
+	unsigned long bit, enabled, max, status;
+	unsigned int sts, mask;
=20
 	chained_irq_enter(chip, desc);
=20
+	mask =3D scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT;
 	/*
 	 * The SCU IC has just one register to control its operation and read
 	 * status. The interrupt enable bits occupy the lower 16 bits of the
@@ -66,7 +83,7 @@ static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
 	 * shifting the status down to get the mapping and then back up to
 	 * clear the bit.
 	 */
-	regmap_read(scu_ic->scu, scu_ic->reg, &sts);
+	sts =3D readl(scu_ic->base);
 	enabled =3D sts & scu_ic->irq_enable;
 	status =3D (sts >> ASPEED_SCU_IC_STATUS_SHIFT) & enabled;
=20
@@ -74,43 +91,83 @@ static void aspeed_scu_ic_irq_handler(struct irq_desc *de=
sc)
 	max =3D scu_ic->num_irqs + bit;
=20
 	for_each_set_bit_from(bit, &status, max) {
-		generic_handle_domain_irq(scu_ic->irq_domain,
-					  bit - scu_ic->irq_shift);
+		generic_handle_domain_irq(scu_ic->irq_domain, bit - scu_ic->irq_shift);
+		writel((readl(scu_ic->base) & ~mask) | BIT(bit + ASPEED_SCU_IC_STATUS_SHIF=
T),
+		       scu_ic->base);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void aspeed_scu_ic_irq_handler_split(struct irq_desc *desc)
+{
+	struct aspeed_scu_ic *scu_ic =3D irq_desc_get_handler_data(desc);
+	struct irq_chip *chip =3D irq_desc_get_chip(desc);
+	unsigned long bit, enabled, max, status;
+	unsigned int sts, mask;
=20
-		regmap_write_bits(scu_ic->scu, scu_ic->reg, mask,
-				  BIT(bit + ASPEED_SCU_IC_STATUS_SHIFT));
+	chained_irq_enter(chip, desc);
+
+	mask =3D scu_ic->irq_enable;
+	sts =3D readl(scu_ic->base + scu_ic->isr);
+	enabled =3D sts & scu_ic->irq_enable;
+	sts =3D readl(scu_ic->base + scu_ic->isr);
+	status =3D sts & enabled;
+
+	bit =3D scu_ic->irq_shift;
+	max =3D scu_ic->num_irqs + bit;
+
+	for_each_set_bit_from(bit, &status, max) {
+		generic_handle_domain_irq(scu_ic->irq_domain, bit - scu_ic->irq_shift);
+		/* Clear interrupt */
+		writel(BIT(bit), scu_ic->base + scu_ic->isr);
 	}
=20
 	chained_irq_exit(chip, desc);
 }
=20
-static void aspeed_scu_ic_irq_mask(struct irq_data *data)
+static void aspeed_scu_ic_irq_mask_combined(struct irq_data *data)
 {
 	struct aspeed_scu_ic *scu_ic =3D irq_data_get_irq_chip_data(data);
-	unsigned int mask =3D BIT(data->hwirq + scu_ic->irq_shift) |
-		(scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT);
+	unsigned int bit =3D BIT(data->hwirq + scu_ic->irq_shift);
+	unsigned int mask =3D bit | (scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHI=
FT);
=20
 	/*
 	 * Status bits are cleared by writing 1. In order to prevent the mask
 	 * operation from clearing the status bits, they should be under the
 	 * mask and written with 0.
 	 */
-	regmap_update_bits(scu_ic->scu, scu_ic->reg, mask, 0);
+	writel(readl(scu_ic->base) & ~mask, scu_ic->base);
 }
=20
-static void aspeed_scu_ic_irq_unmask(struct irq_data *data)
+static void aspeed_scu_ic_irq_unmask_combined(struct irq_data *data)
 {
 	struct aspeed_scu_ic *scu_ic =3D irq_data_get_irq_chip_data(data);
 	unsigned int bit =3D BIT(data->hwirq + scu_ic->irq_shift);
-	unsigned int mask =3D bit |
-		(scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT);
+	unsigned int mask =3D bit | (scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHI=
FT);
=20
 	/*
 	 * Status bits are cleared by writing 1. In order to prevent the unmask
 	 * operation from clearing the status bits, they should be under the
 	 * mask and written with 0.
 	 */
-	regmap_update_bits(scu_ic->scu, scu_ic->reg, mask, bit);
+	writel((readl(scu_ic->base) & ~mask) | bit, scu_ic->base);
+}
+
+static void aspeed_scu_ic_irq_mask_split(struct irq_data *data)
+{
+	struct aspeed_scu_ic *scu_ic =3D irq_data_get_irq_chip_data(data);
+	unsigned int mask =3D BIT(data->hwirq + scu_ic->irq_shift);
+
+	writel(readl(scu_ic->base) & ~mask, scu_ic->base + scu_ic->ier);
+}
+
+static void aspeed_scu_ic_irq_unmask_split(struct irq_data *data)
+{
+	struct aspeed_scu_ic *scu_ic =3D irq_data_get_irq_chip_data(data);
+	unsigned int bit =3D BIT(data->hwirq + scu_ic->irq_shift);
+
+	writel(readl(scu_ic->base) | bit, scu_ic->base + scu_ic->ier);
 }
=20
 static int aspeed_scu_ic_irq_set_affinity(struct irq_data *data,
@@ -120,17 +177,29 @@ static int aspeed_scu_ic_irq_set_affinity(struct irq_da=
ta *data,
 	return -EINVAL;
 }
=20
-static struct irq_chip aspeed_scu_ic_chip =3D {
+static struct irq_chip aspeed_scu_ic_chip_combined =3D {
 	.name			=3D "aspeed-scu-ic",
-	.irq_mask		=3D aspeed_scu_ic_irq_mask,
-	.irq_unmask		=3D aspeed_scu_ic_irq_unmask,
-	.irq_set_affinity	=3D aspeed_scu_ic_irq_set_affinity,
+	.irq_mask		=3D aspeed_scu_ic_irq_mask_combined,
+	.irq_unmask		=3D aspeed_scu_ic_irq_unmask_combined,
+	.irq_set_affinity       =3D aspeed_scu_ic_irq_set_affinity,
+};
+
+static struct irq_chip aspeed_scu_ic_chip_split =3D {
+	.name			=3D "ast2700-scu-ic",
+	.irq_mask		=3D aspeed_scu_ic_irq_mask_split,
+	.irq_unmask		=3D aspeed_scu_ic_irq_unmask_split,
+	.irq_set_affinity       =3D aspeed_scu_ic_irq_set_affinity,
 };
=20
 static int aspeed_scu_ic_map(struct irq_domain *domain, unsigned int irq,
 			     irq_hw_number_t hwirq)
 {
-	irq_set_chip_and_handler(irq, &aspeed_scu_ic_chip, handle_level_irq);
+	struct aspeed_scu_ic *scu_ic =3D domain->host_data;
+
+	if (scu_has_split_isr(scu_ic))
+		irq_set_chip_and_handler(irq, &aspeed_scu_ic_chip_split, handle_level_irq);
+	else
+		irq_set_chip_and_handler(irq, &aspeed_scu_ic_chip_combined, handle_level_i=
rq);
 	irq_set_chip_data(irq, domain->host_data);
=20
 	return 0;
@@ -143,21 +212,21 @@ static const struct irq_domain_ops aspeed_scu_ic_domain=
_ops =3D {
 static int aspeed_scu_ic_of_init_common(struct aspeed_scu_ic *scu_ic,
 					struct device_node *node)
 {
-	int irq;
-	int rc =3D 0;
+	int irq, rc =3D 0;
=20
-	if (!node->parent) {
-		rc =3D -ENODEV;
+	scu_ic->base =3D of_iomap(node, 0);
+	if (IS_ERR(scu_ic->base)) {
+		rc =3D PTR_ERR(scu_ic->base);
 		goto err;
 	}
=20
-	scu_ic->scu =3D syscon_node_to_regmap(node->parent);
-	if (IS_ERR(scu_ic->scu)) {
-		rc =3D PTR_ERR(scu_ic->scu);
-		goto err;
+	if (scu_has_split_isr(scu_ic)) {
+		writel(AST2700_SCU_IC_STATUS, scu_ic->base + scu_ic->isr);
+		writel(0, scu_ic->base + scu_ic->ier);
+	} else {
+		writel(ASPEED_SCU_IC_STATUS, scu_ic->base);
+		writel(0, scu_ic->base);
 	}
-	regmap_write_bits(scu_ic->scu, scu_ic->reg, ASPEED_SCU_IC_STATUS, ASPEED_SC=
U_IC_STATUS);
-	regmap_write_bits(scu_ic->scu, scu_ic->reg, ASPEED_SCU_IC_ENABLE, 0);
=20
 	irq =3D irq_of_parse_and_map(node, 0);
 	if (!irq) {
@@ -166,75 +235,60 @@ static int aspeed_scu_ic_of_init_common(struct aspeed_s=
cu_ic *scu_ic,
 	}
=20
 	scu_ic->irq_domain =3D irq_domain_create_linear(of_fwnode_handle(node), scu=
_ic->num_irqs,
-						   &aspeed_scu_ic_domain_ops,
-						   scu_ic);
+						      &aspeed_scu_ic_domain_ops, scu_ic);
 	if (!scu_ic->irq_domain) {
 		rc =3D -ENOMEM;
 		goto err;
 	}
=20
-	irq_set_chained_handler_and_data(irq, aspeed_scu_ic_irq_handler,
+	irq_set_chained_handler_and_data(irq, scu_has_split_isr(scu_ic) ?
+					 aspeed_scu_ic_irq_handler_split :
+					 aspeed_scu_ic_irq_handler_combined,
 					 scu_ic);
=20
 	return 0;
=20
 err:
 	kfree(scu_ic);
-
 	return rc;
 }
=20
-static int __init aspeed_scu_ic_of_init(struct device_node *node,
-					struct device_node *parent)
+static const struct aspeed_scu_ic_variant *aspeed_scu_ic_find_variant(struct=
 device_node *np)
 {
-	struct aspeed_scu_ic *scu_ic =3D kzalloc(sizeof(*scu_ic), GFP_KERNEL);
-
-	if (!scu_ic)
-		return -ENOMEM;
-
-	scu_ic->irq_enable =3D ASPEED_SCU_IC_ENABLE;
-	scu_ic->irq_shift =3D ASPEED_SCU_IC_SHIFT;
-	scu_ic->num_irqs =3D ASPEED_SCU_IC_NUM_IRQS;
-	scu_ic->reg =3D ASPEED_SCU_IC_REG;
-
-	return aspeed_scu_ic_of_init_common(scu_ic, node);
+	for (int i =3D 0; i < ARRAY_SIZE(scu_ic_variants); i++) {
+		if (of_device_is_compatible(np, scu_ic_variants[i].compatible))
+			return &scu_ic_variants[i];
+	}
+	return NULL;
 }
=20
-static int __init aspeed_ast2600_scu_ic0_of_init(struct device_node *node,
-						 struct device_node *parent)
+static int __init aspeed_scu_ic_of_init(struct device_node *node, struct dev=
ice_node *parent)
 {
-	struct aspeed_scu_ic *scu_ic =3D kzalloc(sizeof(*scu_ic), GFP_KERNEL);
+	const struct aspeed_scu_ic_variant *variant;
+	struct aspeed_scu_ic *scu_ic;
=20
-	if (!scu_ic)
-		return -ENOMEM;
-
-	scu_ic->irq_enable =3D ASPEED_AST2600_SCU_IC0_ENABLE;
-	scu_ic->irq_shift =3D ASPEED_AST2600_SCU_IC0_SHIFT;
-	scu_ic->num_irqs =3D ASPEED_AST2600_SCU_IC0_NUM_IRQS;
-	scu_ic->reg =3D ASPEED_AST2600_SCU_IC0_REG;
-
-	return aspeed_scu_ic_of_init_common(scu_ic, node);
-}
-
-static int __init aspeed_ast2600_scu_ic1_of_init(struct device_node *node,
-						 struct device_node *parent)
-{
-	struct aspeed_scu_ic *scu_ic =3D kzalloc(sizeof(*scu_ic), GFP_KERNEL);
+	variant =3D aspeed_scu_ic_find_variant(node);
+	if (!variant)
+		return -ENODEV;
=20
+	scu_ic =3D kzalloc(sizeof(*scu_ic), GFP_KERNEL);
 	if (!scu_ic)
 		return -ENOMEM;
=20
-	scu_ic->irq_enable =3D ASPEED_AST2600_SCU_IC1_ENABLE;
-	scu_ic->irq_shift =3D ASPEED_AST2600_SCU_IC1_SHIFT;
-	scu_ic->num_irqs =3D ASPEED_AST2600_SCU_IC1_NUM_IRQS;
-	scu_ic->reg =3D ASPEED_AST2600_SCU_IC1_REG;
+	scu_ic->irq_enable	=3D variant->irq_enable;
+	scu_ic->irq_shift	=3D variant->irq_shift;
+	scu_ic->num_irqs	=3D variant->num_irqs;
+	scu_ic->ier		=3D variant->ier;
+	scu_ic->isr		=3D variant->isr;
=20
 	return aspeed_scu_ic_of_init_common(scu_ic, node);
 }
=20
 IRQCHIP_DECLARE(ast2400_scu_ic, "aspeed,ast2400-scu-ic", aspeed_scu_ic_of_in=
it);
 IRQCHIP_DECLARE(ast2500_scu_ic, "aspeed,ast2500-scu-ic", aspeed_scu_ic_of_in=
it);
-IRQCHIP_DECLARE(ast2600_scu_ic0, "aspeed,ast2600-scu-ic0",
-		aspeed_ast2600_scu_ic0_of_init);
-IRQCHIP_DECLARE(ast2600_scu_ic1, "aspeed,ast2600-scu-ic1",
-		aspeed_ast2600_scu_ic1_of_init);
+IRQCHIP_DECLARE(ast2600_scu_ic0, "aspeed,ast2600-scu-ic0", aspeed_scu_ic_of_=
init);
+IRQCHIP_DECLARE(ast2600_scu_ic1, "aspeed,ast2600-scu-ic1", aspeed_scu_ic_of_=
init);
+IRQCHIP_DECLARE(ast2700_scu_ic0, "aspeed,ast2700-scu-ic0", aspeed_scu_ic_of_=
init);
+IRQCHIP_DECLARE(ast2700_scu_ic1, "aspeed,ast2700-scu-ic1", aspeed_scu_ic_of_=
init);
+IRQCHIP_DECLARE(ast2700_scu_ic2, "aspeed,ast2700-scu-ic2", aspeed_scu_ic_of_=
init);
+IRQCHIP_DECLARE(ast2700_scu_ic3, "aspeed,ast2700-scu-ic3", aspeed_scu_ic_of_=
init);
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 24ef5af569fe..8a3410c2b7b5 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -153,14 +153,19 @@ static int gicv2m_irq_domain_alloc(struct irq_domain *d=
omain, unsigned int virq,
 {
 	msi_alloc_info_t *info =3D args;
 	struct v2m_data *v2m =3D NULL, *tmp;
-	int hwirq, offset, i, err =3D 0;
+	int hwirq, i, err =3D 0;
+	unsigned long offset;
+	unsigned long align_mask =3D nr_irqs - 1;
=20
 	spin_lock(&v2m_lock);
 	list_for_each_entry(tmp, &v2m_nodes, entry) {
-		offset =3D bitmap_find_free_region(tmp->bm, tmp->nr_spis,
-						 get_count_order(nr_irqs));
-		if (offset >=3D 0) {
+		unsigned long align_off =3D tmp->spi_start - (tmp->spi_start & ~align_mask=
);
+
+		offset =3D bitmap_find_next_zero_area_off(tmp->bm, tmp->nr_spis, 0,
+							nr_irqs, align_mask, align_off);
+		if (offset < tmp->nr_spis) {
 			v2m =3D tmp;
+			bitmap_set(v2m->bm, offset, nr_irqs);
 			break;
 		}
 	}
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index dbeb85677b08..3de351e66ee8 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1766,8 +1766,9 @@ static int gic_irq_domain_select(struct irq_domain *d,
 				 struct irq_fwspec *fwspec,
 				 enum irq_domain_bus_token bus_token)
 {
-	unsigned int type, ret, ppi_idx;
+	unsigned int type, ppi_idx;
 	irq_hw_number_t hwirq;
+	int ret;
=20
 	/* Not for us */
 	if (fwspec->fwnode !=3D d->fwnode)
diff --git a/drivers/irqchip/irq-gic-v5-irs.c b/drivers/irqchip/irq-gic-v5-ir=
s.c
index f845415f9143..ad1435a858a4 100644
--- a/drivers/irqchip/irq-gic-v5-irs.c
+++ b/drivers/irqchip/irq-gic-v5-irs.c
@@ -568,7 +568,7 @@ static void __init gicv5_irs_init_bases(struct gicv5_irs_=
chip_data *irs_data,
 			FIELD_PREP(GICV5_IRS_CR1_IST_RA, GICV5_NO_READ_ALLOC)	|
 			FIELD_PREP(GICV5_IRS_CR1_IC, GICV5_NON_CACHE)		|
 			FIELD_PREP(GICV5_IRS_CR1_OC, GICV5_NON_CACHE);
-			irs_data->flags |=3D IRS_FLAGS_NON_COHERENT;
+		irs_data->flags |=3D IRS_FLAGS_NON_COHERENT;
 	} else {
 		cr1 =3D FIELD_PREP(GICV5_IRS_CR1_VPED_WA, GICV5_WRITE_ALLOC)	|
 			FIELD_PREP(GICV5_IRS_CR1_VPED_RA, GICV5_READ_ALLOC)	|
diff --git a/drivers/irqchip/irq-gic-v5-its.c b/drivers/irqchip/irq-gic-v5-it=
s.c
index 9290ac741949..554485f0be1f 100644
--- a/drivers/irqchip/irq-gic-v5-its.c
+++ b/drivers/irqchip/irq-gic-v5-its.c
@@ -191,9 +191,9 @@ static int gicv5_its_create_itt_two_level(struct gicv5_it=
s_chip_data *its,
 					  unsigned int num_events)
 {
 	unsigned int l1_bits, l2_bits, span, events_per_l2_table;
-	unsigned int i, complete_tables, final_span, num_ents;
+	unsigned int complete_tables, final_span, num_ents;
 	__le64 *itt_l1, *itt_l2, **l2ptrs;
-	int ret;
+	int i, ret;
 	u64 val;
=20
 	ret =3D gicv5_its_l2sz_to_l2_bits(itt_l2sz);
@@ -768,8 +768,6 @@ static struct gicv5_its_dev *gicv5_its_alloc_device(struc=
t gicv5_its_chip_data *
 		goto out_dev_free;
 	}
=20
-	gicv5_its_device_cache_inv(its, its_dev);
-
 	its_dev->its_node =3D its;
=20
 	its_dev->event_map =3D (unsigned long *)bitmap_zalloc(its_dev->num_events, =
GFP_KERNEL);
@@ -949,15 +947,18 @@ static int gicv5_its_irq_domain_alloc(struct irq_domain=
 *domain, unsigned int vi
 	device_id =3D its_dev->device_id;
=20
 	for (i =3D 0; i < nr_irqs; i++) {
-		lpi =3D gicv5_alloc_lpi();
+		ret =3D gicv5_alloc_lpi();
 		if (ret < 0) {
 			pr_debug("Failed to find free LPI!\n");
-			goto out_eventid;
+			goto out_free_irqs;
 		}
+		lpi =3D ret;
=20
 		ret =3D irq_domain_alloc_irqs_parent(domain, virq + i, 1, &lpi);
-		if (ret)
-			goto out_free_lpi;
+		if (ret) {
+			gicv5_free_lpi(lpi);
+			goto out_free_irqs;
+		}
=20
 		/*
 		 * Store eventid and deviceid into the hwirq for later use.
@@ -977,8 +978,13 @@ static int gicv5_its_irq_domain_alloc(struct irq_domain =
*domain, unsigned int vi
=20
 	return 0;
=20
-out_free_lpi:
-	gicv5_free_lpi(lpi);
+out_free_irqs:
+	while (--i >=3D 0) {
+		irqd =3D irq_domain_get_irq_data(domain, virq + i);
+		gicv5_free_lpi(irqd->parent_data->hwirq);
+		irq_domain_reset_irq_data(irqd);
+		irq_domain_free_irqs_parent(domain, virq + i, 1);
+	}
 out_eventid:
 	gicv5_its_free_eventid(its_dev, event_id_base, nr_irqs);
 	return ret;
diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loo=
ngson-eiointc.c
index b2860eb2d32c..39e5a72ccd3c 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -46,6 +46,7 @@
 #define EIOINTC_ALL_ENABLE_VEC_MASK(vector)	(EIOINTC_ALL_ENABLE & ~BIT(vecto=
r & 0x1f))
 #define EIOINTC_REG_ENABLE_VEC(vector)		(EIOINTC_REG_ENABLE + ((vector >> 5)=
 << 2))
 #define EIOINTC_USE_CPU_ENCODE			BIT(0)
+#define EIOINTC_ROUTE_MULT_IP			BIT(1)
=20
 #define MAX_EIO_NODES		(NR_CPUS / CORES_PER_EIO_NODE)
=20
@@ -59,6 +60,14 @@
 #define EIOINTC_REG_ROUTE_VEC_MASK(vector)	(0xff << EIOINTC_REG_ROUTE_VEC_SH=
IFT(vector))
=20
 static int nr_pics;
+struct eiointc_priv;
+
+struct eiointc_ip_route {
+	struct eiointc_priv	*priv;
+	/* Offset Routed destination IP */
+	int			start;
+	int			end;
+};
=20
 struct eiointc_priv {
 	u32			node;
@@ -68,6 +77,8 @@ struct eiointc_priv {
 	struct fwnode_handle	*domain_handle;
 	struct irq_domain	*eiointc_domain;
 	int			flags;
+	irq_hw_number_t		parent_hwirq;
+	struct eiointc_ip_route	route_info[VEC_REG_COUNT];
 };
=20
 static struct eiointc_priv *eiointc_priv[MAX_IO_PICS];
@@ -188,6 +199,7 @@ static int eiointc_router_init(unsigned int cpu)
 {
 	int i, bit, cores, index, node;
 	unsigned int data;
+	int hwirq, mask;
=20
 	node =3D cpu_to_eio_node(cpu);
 	index =3D eiointc_index(node);
@@ -197,6 +209,13 @@ static int eiointc_router_init(unsigned int cpu)
 		return -EINVAL;
 	}
=20
+	/* Enable cpu interrupt pin from eiointc */
+	hwirq =3D eiointc_priv[index]->parent_hwirq;
+	mask =3D BIT(hwirq);
+	if (eiointc_priv[index]->flags & EIOINTC_ROUTE_MULT_IP)
+		mask |=3D BIT(hwirq + 1) | BIT(hwirq + 2) | BIT(hwirq + 3);
+	set_csr_ecfg(mask);
+
 	if (!(eiointc_priv[index]->flags & EIOINTC_USE_CPU_ENCODE))
 		cores =3D CORES_PER_EIO_NODE;
 	else
@@ -211,8 +230,31 @@ static int eiointc_router_init(unsigned int cpu)
 		}
=20
 		for (i =3D 0; i < eiointc_priv[0]->vec_count / 32 / 4; i++) {
-			bit =3D BIT(1 + index); /* Route to IP[1 + index] */
-			data =3D bit | (bit << 8) | (bit << 16) | (bit << 24);
+			/*
+			 * Route to interrupt pin, relative offset used here
+			 * Offset 0 means routing to IP0 and so on
+			 *
+			 * If flags is set with EIOINTC_ROUTE_MULT_IP,
+			 * every 64 vector routes to different consecutive
+			 * IPs, otherwise all vector routes to the same IP
+			 */
+			if (eiointc_priv[index]->flags & EIOINTC_ROUTE_MULT_IP) {
+				/* The first 64 vectors route to hwirq */
+				bit =3D BIT(hwirq++ - INT_HWI0);
+				data =3D bit | (bit << 8);
+
+				/* The second 64 vectors route to hwirq + 1 */
+				bit =3D BIT(hwirq++ - INT_HWI0);
+				data |=3D (bit << 16) | (bit << 24);
+
+				/*
+				 * Route to hwirq + 2/hwirq + 3 separately
+				 * in next loop
+				 */
+			} else  {
+				bit =3D BIT(hwirq - INT_HWI0);
+				data =3D bit | (bit << 8) | (bit << 16) | (bit << 24);
+			}
 			iocsr_write32(data, EIOINTC_REG_IPMAP + i * 4);
 		}
=20
@@ -241,15 +283,22 @@ static int eiointc_router_init(unsigned int cpu)
=20
 static void eiointc_irq_dispatch(struct irq_desc *desc)
 {
-	int i;
-	u64 pending;
-	bool handled =3D false;
+	struct eiointc_ip_route *info =3D irq_desc_get_handler_data(desc);
 	struct irq_chip *chip =3D irq_desc_get_chip(desc);
-	struct eiointc_priv *priv =3D irq_desc_get_handler_data(desc);
+	bool handled =3D false;
+	u64 pending;
+	int i;
=20
 	chained_irq_enter(chip, desc);
=20
-	for (i =3D 0; i < eiointc_priv[0]->vec_count / VEC_COUNT_PER_REG; i++) {
+	/*
+	 * If EIOINTC_ROUTE_MULT_IP is set, every 64 interrupt vectors in
+	 * eiointc interrupt controller routes to different cpu interrupt pins
+	 *
+	 * Every cpu interrupt pin has its own irq handler, it is ok to
+	 * read ISR for these 64 interrupt vectors rather than all vectors
+	 */
+	for (i =3D info->start; i < info->end; i++) {
 		pending =3D iocsr_read64(EIOINTC_REG_ISR + (i << 3));
=20
 		/* Skip handling if pending bitmap is zero */
@@ -262,7 +311,7 @@ static void eiointc_irq_dispatch(struct irq_desc *desc)
 			int bit =3D __ffs(pending);
 			int irq =3D bit + VEC_COUNT_PER_REG * i;
=20
-			generic_handle_domain_irq(priv->eiointc_domain, irq);
+			generic_handle_domain_irq(info->priv->eiointc_domain, irq);
 			pending &=3D ~BIT(bit);
 			handled =3D true;
 		}
@@ -462,8 +511,33 @@ static int __init eiointc_init(struct eiointc_priv *priv=
, int parent_irq,
 	}
=20
 	eiointc_priv[nr_pics++] =3D priv;
+	/*
+	 * Only the first eiointc device on VM supports routing to
+	 * different CPU interrupt pins. The later eiointc devices use
+	 * generic method if there are multiple eiointc devices in future
+	 */
+	if (cpu_has_hypervisor && (nr_pics =3D=3D 1)) {
+		priv->flags |=3D EIOINTC_ROUTE_MULT_IP;
+		priv->parent_hwirq =3D INT_HWI0;
+	}
+
+	if (priv->flags & EIOINTC_ROUTE_MULT_IP) {
+		for (i =3D 0; i < priv->vec_count / VEC_COUNT_PER_REG; i++) {
+			priv->route_info[i].start  =3D priv->parent_hwirq - INT_HWI0 + i;
+			priv->route_info[i].end    =3D priv->route_info[i].start + 1;
+			priv->route_info[i].priv   =3D priv;
+			parent_irq =3D get_percpu_irq(priv->parent_hwirq + i);
+			irq_set_chained_handler_and_data(parent_irq, eiointc_irq_dispatch,
+							 &priv->route_info[i]);
+		}
+	} else {
+		priv->route_info[0].start  =3D 0;
+		priv->route_info[0].end    =3D priv->vec_count / VEC_COUNT_PER_REG;
+		priv->route_info[0].priv   =3D priv;
+		irq_set_chained_handler_and_data(parent_irq, eiointc_irq_dispatch,
+						 &priv->route_info[0]);
+	}
 	eiointc_router_init(0);
-	irq_set_chained_handler_and_data(parent_irq, eiointc_irq_dispatch, priv);
=20
 	if (nr_pics =3D=3D 1) {
 		register_syscore_ops(&eiointc_syscore_ops);
@@ -495,7 +569,7 @@ int __init eiointc_acpi_init(struct irq_domain *parent,
=20
 	priv->vec_count =3D VEC_COUNT;
 	priv->node =3D acpi_eiointc->node;
-
+	priv->parent_hwirq =3D acpi_eiointc->cascade;
 	parent_irq =3D irq_create_mapping(parent, acpi_eiointc->cascade);
=20
 	ret =3D eiointc_init(priv, parent_irq, acpi_eiointc->node_map);
@@ -527,8 +601,9 @@ int __init eiointc_acpi_init(struct irq_domain *parent,
 static int __init eiointc_of_init(struct device_node *of_node,
 				  struct device_node *parent)
 {
-	int parent_irq, ret;
 	struct eiointc_priv *priv;
+	struct irq_data *irq_data;
+	int parent_irq, ret;
=20
 	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -544,6 +619,12 @@ static int __init eiointc_of_init(struct device_node *of=
_node,
 	if (ret < 0)
 		goto out_free_priv;
=20
+	irq_data =3D irq_get_irq_data(parent_irq);
+	if (!irq_data) {
+		ret =3D -ENODEV;
+		goto out_free_priv;
+	}
+
 	/*
 	 * In particular, the number of devices supported by the LS2K0500
 	 * extended I/O interrupt vector is 128.
@@ -552,7 +633,7 @@ static int __init eiointc_of_init(struct device_node *of_=
node,
 		priv->vec_count =3D 128;
 	else
 		priv->vec_count =3D VEC_COUNT;
-
+	priv->parent_hwirq =3D irqd_to_hwirq(irq_data);
 	priv->node =3D 0;
 	priv->domain_handle =3D of_fwnode_handle(of_node);
=20
diff --git a/drivers/irqchip/irq-loongson-pch-lpc.c b/drivers/irqchip/irq-loo=
ngson-pch-lpc.c
index 2d4c3ec128b8..912bf50a5c7c 100644
--- a/drivers/irqchip/irq-loongson-pch-lpc.c
+++ b/drivers/irqchip/irq-loongson-pch-lpc.c
@@ -200,8 +200,13 @@ int __init pch_lpc_acpi_init(struct irq_domain *parent,
 		goto iounmap_base;
 	}
=20
-	priv->lpc_domain =3D irq_domain_create_linear(irq_handle, LPC_COUNT,
-					&pch_lpc_domain_ops, priv);
+	/*
+	 * The LPC interrupt controller is a legacy i8259-compatible device,
+	 * which requires a static 1:1 mapping for IRQs 0-15.
+	 * Use irq_domain_create_legacy to establish this static mapping early.
+	 */
+	priv->lpc_domain =3D irq_domain_create_legacy(irq_handle, LPC_COUNT, 0, 0,
+						    &pch_lpc_domain_ops, priv);
 	if (!priv->lpc_domain) {
 		pr_err("Failed to create IRQ domain\n");
 		goto free_irq_handle;
diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index 908944009c21..d5eefc3d7215 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -112,6 +112,20 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struc=
t irq_domain *domain,
 	 */
 	if (!chip->irq_set_affinity && !(info->flags & MSI_FLAG_NO_AFFINITY))
 		chip->irq_set_affinity =3D msi_domain_set_affinity;
+
+	/*
+	 * If the parent domain insists on being in charge of masking, obey
+	 * blindly. The interrupt is un-masked at the PCI level on startup
+	 * and masked on shutdown to prevent rogue interrupts after the
+	 * driver freed the interrupt. Not masking it at the PCI level
+	 * speeds up operation for disable/enable_irq() as it avoids
+	 * getting all the way out to the PCI device.
+	 */
+	if (info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT) {
+		chip->irq_mask		=3D irq_chip_mask_parent;
+		chip->irq_unmask	=3D irq_chip_unmask_parent;
+	}
+
 	return true;
 }
 EXPORT_SYMBOL_GPL(msi_lib_init_dev_msi_info);
diff --git a/drivers/irqchip/irq-nvic.c b/drivers/irqchip/irq-nvic.c
index 76e11cac9631..2191a2b79578 100644
--- a/drivers/irqchip/irq-nvic.c
+++ b/drivers/irqchip/irq-nvic.c
@@ -73,8 +73,9 @@ static int __init nvic_of_init(struct device_node *node,
 			       struct device_node *parent)
 {
 	unsigned int clr =3D IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
-	unsigned int irqs, i, ret, numbanks;
+	unsigned int irqs, i, numbanks;
 	void __iomem *nvic_base;
+	int ret;
=20
 	numbanks =3D (readl_relaxed(V7M_SCS_ICTR) &
 		    V7M_SCS_ICTR_INTLINESNUM_MASK) + 1;
diff --git a/drivers/irqchip/irq-renesas-rza1.c b/drivers/irqchip/irq-renesas=
-rza1.c
index a697eb55ac90..6047a524ac77 100644
--- a/drivers/irqchip/irq-renesas-rza1.c
+++ b/drivers/irqchip/irq-renesas-rza1.c
@@ -142,11 +142,12 @@ static const struct irq_domain_ops rza1_irqc_domain_ops=
 =3D {
 static int rza1_irqc_parse_map(struct rza1_irqc_priv *priv,
 			       struct device_node *gic_node)
 {
-	unsigned int imaplen, i, j, ret;
 	struct device *dev =3D priv->dev;
+	unsigned int imaplen, i, j;
 	struct device_node *ipar;
 	const __be32 *imap;
 	u32 intsize;
+	int ret;
=20
 	imap =3D of_get_property(dev->of_node, "interrupt-map", &imaplen);
 	if (!imap)
diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesa=
s-rzg2l.c
index 360d88687e4f..2a54adeb4cc7 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -578,7 +578,7 @@ static int rzg2l_irqc_common_init(struct device_node *nod=
e, struct device_node *
 						 &rzg2l_irqc_domain_ops, rzg2l_irqc_data);
 	if (!irq_domain) {
 		pm_runtime_put(dev);
-		return dev_err_probe(dev, -ENOMEM, "failed to add irq domain\n");
+		return -ENOMEM;
 	}
=20
 	register_syscore_ops(&rzg2l_irqc_syscore_ops);
diff --git a/drivers/irqchip/irq-sg2042-msi.c b/drivers/irqchip/irq-sg2042-ms=
i.c
index bcfddc51bc6a..f7cf0dc72eab 100644
--- a/drivers/irqchip/irq-sg2042-msi.c
+++ b/drivers/irqchip/irq-sg2042-msi.c
@@ -30,6 +30,7 @@ struct sg204x_msi_chip_info {
  * @doorbell_addr:	see TRM, 10.1.32, GP_INTR0_SET
  * @irq_first:		First vectors number that MSIs starts
  * @num_irqs:		Number of vectors for MSIs
+ * @irq_type:		IRQ type for MSIs
  * @msi_map:		mapping for allocated MSI vectors.
  * @msi_map_lock:	Lock for msi_map
  * @chip_info:		chip specific infomations
@@ -41,6 +42,7 @@ struct sg204x_msi_chipdata {
=20
 	u32					irq_first;
 	u32					num_irqs;
+	unsigned int				irq_type;
=20
 	unsigned long				*msi_map;
 	struct mutex				msi_map_lock;
@@ -85,6 +87,8 @@ static void sg2042_msi_irq_compose_msi_msg(struct irq_data =
*d, struct msi_msg *m
=20
 static const struct irq_chip sg2042_msi_middle_irq_chip =3D {
 	.name			=3D "SG2042 MSI",
+	.irq_startup		=3D irq_chip_startup_parent,
+	.irq_shutdown		=3D irq_chip_shutdown_parent,
 	.irq_ack		=3D sg2042_msi_irq_ack,
 	.irq_mask		=3D irq_chip_mask_parent,
 	.irq_unmask		=3D irq_chip_unmask_parent,
@@ -114,6 +118,8 @@ static void sg2044_msi_irq_compose_msi_msg(struct irq_dat=
a *d, struct msi_msg *m
=20
 static struct irq_chip sg2044_msi_middle_irq_chip =3D {
 	.name			=3D "SG2044 MSI",
+	.irq_startup		=3D irq_chip_startup_parent,
+	.irq_shutdown		=3D irq_chip_shutdown_parent,
 	.irq_ack		=3D sg2044_msi_irq_ack,
 	.irq_mask		=3D irq_chip_mask_parent,
 	.irq_unmask		=3D irq_chip_unmask_parent,
@@ -133,14 +139,14 @@ static int sg204x_msi_parent_domain_alloc(struct irq_do=
main *domain, unsigned in
 	fwspec.fwnode =3D domain->parent->fwnode;
 	fwspec.param_count =3D 2;
 	fwspec.param[0] =3D data->irq_first + hwirq;
-	fwspec.param[1] =3D IRQ_TYPE_EDGE_RISING;
+	fwspec.param[1] =3D data->irq_type;
=20
 	ret =3D irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
 	if (ret)
 		return ret;
=20
 	d =3D irq_domain_get_irq_data(domain->parent, virq);
-	return d->chip->irq_set_type(d, IRQ_TYPE_EDGE_RISING);
+	return d->chip->irq_set_type(d, data->irq_type);
 }
=20
 static int sg204x_msi_middle_domain_alloc(struct irq_domain *domain, unsigne=
d int virq,
@@ -185,8 +191,10 @@ static const struct irq_domain_ops sg204x_msi_middle_dom=
ain_ops =3D {
 	.select	=3D msi_lib_irq_domain_select,
 };
=20
-#define SG2042_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS |	\
-				   MSI_FLAG_USE_DEF_CHIP_OPS)
+#define SG2042_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS |		\
+				   MSI_FLAG_USE_DEF_CHIP_OPS |		\
+				   MSI_FLAG_PCI_MSI_MASK_PARENT |	\
+				   MSI_FLAG_PCI_MSI_STARTUP_PARENT)
=20
 #define SG2042_MSI_FLAGS_SUPPORTED MSI_GENERIC_FLAGS_MASK
=20
@@ -200,10 +208,13 @@ static const struct msi_parent_ops sg2042_msi_parent_op=
s =3D {
 	.init_dev_msi_info	=3D msi_lib_init_dev_msi_info,
 };
=20
-#define SG2044_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS |	\
-				   MSI_FLAG_USE_DEF_CHIP_OPS)
+#define SG2044_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS |		\
+				   MSI_FLAG_USE_DEF_CHIP_OPS |		\
+				   MSI_FLAG_PCI_MSI_MASK_PARENT |	\
+				   MSI_FLAG_PCI_MSI_STARTUP_PARENT)
=20
-#define SG2044_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
+#define SG2044_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |		\
+				    MSI_FLAG_MULTI_PCI_MSI |		\
 				    MSI_FLAG_PCI_MSIX)
=20
 static const struct msi_parent_ops sg2044_msi_parent_ops =3D {
@@ -289,6 +300,7 @@ static int sg2042_msi_probe(struct platform_device *pdev)
 	}
=20
 	data->irq_first =3D (u32)args.args[0];
+	data->irq_type =3D (unsigned int)args.args[1];
 	data->num_irqs =3D (u32)args.args[args.nargs - 1];
=20
 	mutex_init(&data->msi_map_lock);
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-p=
lic.c
index bf69a4802b71..559fda8fb3a8 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -179,12 +179,14 @@ static int plic_set_affinity(struct irq_data *d,
 	if (cpu >=3D nr_cpu_ids)
 		return -EINVAL;
=20
-	plic_irq_disable(d);
+	/* Invalidate the original routing entry */
+	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 0);
=20
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
=20
+	/* Setting the new routing entry if irq is enabled */
 	if (!irqd_irq_disabled(d))
-		plic_irq_enable(d);
+		plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 1);
=20
 	return IRQ_SET_MASK_OK_DONE;
 }
@@ -257,7 +259,7 @@ static int plic_irq_suspend(void)
 			     readl(priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID));
 	}
=20
-	for_each_cpu(cpu, cpu_present_mask) {
+	for_each_present_cpu(cpu) {
 		struct plic_handler *handler =3D per_cpu_ptr(&plic_handlers, cpu);
=20
 		if (!handler->present)
@@ -289,7 +291,7 @@ static void plic_irq_resume(void)
 		       priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID);
 	}
=20
-	for_each_cpu(cpu, cpu_present_mask) {
+	for_each_present_cpu(cpu) {
 		struct plic_handler *handler =3D per_cpu_ptr(&plic_handlers, cpu);
=20
 		if (!handler->present)
diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index 0938ef7ebabf..dfb61f152702 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -148,20 +148,43 @@ static void pci_device_domain_set_desc(msi_alloc_info_t=
 *arg, struct msi_desc *d
 	arg->hwirq =3D desc->msi_index;
 }
=20
-static __always_inline void cond_mask_parent(struct irq_data *data)
+static void cond_shutdown_parent(struct irq_data *data)
 {
 	struct msi_domain_info *info =3D data->domain->host_data;
=20
-	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
+	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_STARTUP_PARENT))
+		irq_chip_shutdown_parent(data);
+	else if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
 		irq_chip_mask_parent(data);
 }
=20
-static __always_inline void cond_unmask_parent(struct irq_data *data)
+static unsigned int cond_startup_parent(struct irq_data *data)
 {
 	struct msi_domain_info *info =3D data->domain->host_data;
=20
-	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
+	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_STARTUP_PARENT))
+		return irq_chip_startup_parent(data);
+	else if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
 		irq_chip_unmask_parent(data);
+
+	return 0;
+}
+
+static void pci_irq_shutdown_msi(struct irq_data *data)
+{
+	struct msi_desc *desc =3D irq_data_get_msi_desc(data);
+
+	pci_msi_mask(desc, BIT(data->irq - desc->irq));
+	cond_shutdown_parent(data);
+}
+
+static unsigned int pci_irq_startup_msi(struct irq_data *data)
+{
+	struct msi_desc *desc =3D irq_data_get_msi_desc(data);
+	unsigned int ret =3D cond_startup_parent(data);
+
+	pci_msi_unmask(desc, BIT(data->irq - desc->irq));
+	return ret;
 }
=20
 static void pci_irq_mask_msi(struct irq_data *data)
@@ -169,14 +192,12 @@ static void pci_irq_mask_msi(struct irq_data *data)
 	struct msi_desc *desc =3D irq_data_get_msi_desc(data);
=20
 	pci_msi_mask(desc, BIT(data->irq - desc->irq));
-	cond_mask_parent(data);
 }
=20
 static void pci_irq_unmask_msi(struct irq_data *data)
 {
 	struct msi_desc *desc =3D irq_data_get_msi_desc(data);
=20
-	cond_unmask_parent(data);
 	pci_msi_unmask(desc, BIT(data->irq - desc->irq));
 }
=20
@@ -194,6 +215,8 @@ static void pci_irq_unmask_msi(struct irq_data *data)
 static const struct msi_domain_template pci_msi_template =3D {
 	.chip =3D {
 		.name			=3D "PCI-MSI",
+		.irq_startup		=3D pci_irq_startup_msi,
+		.irq_shutdown		=3D pci_irq_shutdown_msi,
 		.irq_mask		=3D pci_irq_mask_msi,
 		.irq_unmask		=3D pci_irq_unmask_msi,
 		.irq_write_msi_msg	=3D pci_msi_domain_write_msg,
@@ -210,15 +233,27 @@ static const struct msi_domain_template pci_msi_templat=
e =3D {
 	},
 };
=20
+static void pci_irq_shutdown_msix(struct irq_data *data)
+{
+	pci_msix_mask(irq_data_get_msi_desc(data));
+	cond_shutdown_parent(data);
+}
+
+static unsigned int pci_irq_startup_msix(struct irq_data *data)
+{
+	unsigned int ret =3D cond_startup_parent(data);
+
+	pci_msix_unmask(irq_data_get_msi_desc(data));
+	return ret;
+}
+
 static void pci_irq_mask_msix(struct irq_data *data)
 {
 	pci_msix_mask(irq_data_get_msi_desc(data));
-	cond_mask_parent(data);
 }
=20
 static void pci_irq_unmask_msix(struct irq_data *data)
 {
-	cond_unmask_parent(data);
 	pci_msix_unmask(irq_data_get_msi_desc(data));
 }
=20
@@ -234,6 +269,8 @@ EXPORT_SYMBOL_GPL(pci_msix_prepare_desc);
 static const struct msi_domain_template pci_msix_template =3D {
 	.chip =3D {
 		.name			=3D "PCI-MSIX",
+		.irq_startup		=3D pci_irq_startup_msix,
+		.irq_shutdown		=3D pci_irq_shutdown_msix,
 		.irq_mask		=3D pci_irq_mask_msix,
 		.irq_unmask		=3D pci_irq_unmask_msix,
 		.irq_write_msi_msg	=3D pci_msi_domain_write_msg,
diff --git a/include/dt-bindings/interrupt-controller/aspeed-scu-ic.h b/inclu=
de/dt-bindings/interrupt-controller/aspeed-scu-ic.h
index f315d5a7f5ee..7dd04424afcc 100644
--- a/include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
+++ b/include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
@@ -20,4 +20,18 @@
 #define ASPEED_AST2600_SCU_IC1_LPC_RESET_LO_TO_HI	0
 #define ASPEED_AST2600_SCU_IC1_LPC_RESET_HI_TO_LO	1
=20
+#define ASPEED_AST2700_SCU_IC0_PCIE_PERST_LO_TO_HI	3
+#define ASPEED_AST2700_SCU_IC0_PCIE_PERST_HI_TO_LO	2
+
+#define ASPEED_AST2700_SCU_IC1_PCIE_RCRST_LO_TO_HI	3
+#define ASPEED_AST2700_SCU_IC1_PCIE_RCRST_HI_TO_LO	2
+
+#define ASPEED_AST2700_SCU_IC2_PCIE_PERST_LO_TO_HI	3
+#define ASPEED_AST2700_SCU_IC2_PCIE_PERST_HI_TO_LO	2
+#define ASPEED_AST2700_SCU_IC2_LPC_RESET_LO_TO_HI	1
+#define ASPEED_AST2700_SCU_IC2_LPC_RESET_HI_TO_LO	0
+
+#define ASPEED_AST2700_SCU_IC3_LPC_RESET_LO_TO_HI	1
+#define ASPEED_AST2700_SCU_IC3_LPC_RESET_HI_TO_LO	0
+
 #endif /* _DT_BINDINGS_INTERRUPT_CONTROLLER_ASPEED_SCU_IC_H_ */
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 1d6b606a81ef..c67e76fbcc07 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -669,6 +669,8 @@ extern int irq_chip_set_parent_state(struct irq_data *dat=
a,
 extern int irq_chip_get_parent_state(struct irq_data *data,
 				     enum irqchip_irq_state which,
 				     bool *state);
+extern void irq_chip_shutdown_parent(struct irq_data *data);
+extern unsigned int irq_chip_startup_parent(struct irq_data *data);
 extern void irq_chip_enable_parent(struct irq_data *data);
 extern void irq_chip_disable_parent(struct irq_data *data);
 extern void irq_chip_ack_parent(struct irq_data *data);
@@ -976,10 +978,6 @@ static inline void irq_free_desc(unsigned int irq)
 	irq_free_descs(irq, 1);
 }
=20
-#ifdef CONFIG_GENERIC_IRQ_LEGACY
-void irq_init_desc(unsigned int irq);
-#endif
-
 /**
  * struct irq_chip_regs - register offsets for struct irq_gci
  * @enable:	Enable register offset to reg_base
diff --git a/include/linux/msi.h b/include/linux/msi.h
index e5e86a8529fb..3111ba95fbde 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -568,6 +568,8 @@ enum {
 	MSI_FLAG_PARENT_PM_DEV		=3D (1 << 8),
 	/* Support for parent mask/unmask */
 	MSI_FLAG_PCI_MSI_MASK_PARENT	=3D (1 << 9),
+	/* Support for parent startup/shutdown */
+	MSI_FLAG_PCI_MSI_STARTUP_PARENT	=3D (1 << 10),
=20
 	/* Mask for the generic functionality */
 	MSI_GENERIC_FLAGS_MASK		=3D GENMASK(15, 0),
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 1da5e9d9da71..36673640c4fc 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -6,10 +6,6 @@ menu "IRQ subsystem"
 config MAY_HAVE_SPARSE_IRQ
        bool
=20
-# Legacy support, required for itanic
-config GENERIC_IRQ_LEGACY
-       bool
-
 # Enable the generic irq autoprobe mechanism
 config GENERIC_IRQ_PROBE
 	bool
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 0d0276378c70..3ffa0d80ddd1 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1259,6 +1259,43 @@ int irq_chip_get_parent_state(struct irq_data *data,
 }
 EXPORT_SYMBOL_GPL(irq_chip_get_parent_state);
=20
+/**
+ * irq_chip_shutdown_parent - Shutdown the parent interrupt
+ * @data:	Pointer to interrupt specific data
+ *
+ * Invokes the irq_shutdown() callback of the parent if available or falls
+ * back to irq_chip_disable_parent().
+ */
+void irq_chip_shutdown_parent(struct irq_data *data)
+{
+	struct irq_data *parent =3D data->parent_data;
+
+	if (parent->chip->irq_shutdown)
+		parent->chip->irq_shutdown(parent);
+	else
+		irq_chip_disable_parent(data);
+}
+EXPORT_SYMBOL_GPL(irq_chip_shutdown_parent);
+
+/**
+ * irq_chip_startup_parent - Startup the parent interrupt
+ * @data:	Pointer to interrupt specific data
+ *
+ * Invokes the irq_startup() callback of the parent if available or falls
+ * back to irq_chip_enable_parent().
+ */
+unsigned int irq_chip_startup_parent(struct irq_data *data)
+{
+	struct irq_data *parent =3D data->parent_data;
+
+	if (parent->chip->irq_startup)
+		return parent->chip->irq_startup(parent);
+
+	irq_chip_enable_parent(data);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(irq_chip_startup_parent);
+
 /**
  * irq_chip_enable_parent - Enable the parent interrupt (defaults to unmask =
if
  * NULL)
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index b64c57b44c20..db714d3014b5 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -653,13 +653,6 @@ void irq_mark_irq(unsigned int irq)
 	irq_insert_desc(irq, irq_desc + irq);
 }
=20
-#ifdef CONFIG_GENERIC_IRQ_LEGACY
-void irq_init_desc(unsigned int irq)
-{
-	free_desc(irq);
-}
-#endif
-
 #endif /* !CONFIG_SPARSE_IRQ */
=20
 int handle_irq_desc(struct irq_desc *desc)



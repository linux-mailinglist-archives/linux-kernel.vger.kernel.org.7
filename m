Return-Path: <linux-kernel+bounces-747308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB4EB13246
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 00:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F831189362A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 22:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B0C248F57;
	Sun, 27 Jul 2025 22:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k5caCOBR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2BKlYtTF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E0922DA1C
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 22:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753655879; cv=none; b=sMEc1ND5zWzuaqXNlBm5UCXYgPbBgAoXDypIKcAOqzvnqMbpGmKmIRLMUzflIxQXOuZJMQIo0mw5P2EFrKBiKxA9NAr576v7zCfIfCsDhH/LuU4k195W6DM1ct91PzLE64S04ay7wYPpctHi1OZzb8PZzLekwym6No5RN2MlNog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753655879; c=relaxed/simple;
	bh=Pf3wfDqGhqdcQ9gzCfWC7U1LOh28TS6Esq5LW0hsXV8=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=VDHrinU3hhZ1D2gAX1DowQa1URsDvPewONaFBz4+y4yABmI1gLgl/QNbNDQH75v2VzlfHHIlra6SWJCrEgoQIhnpyojgZ2wjyB+2mAUcWHC4dQWm4uzK/BEse563OSu+jZBQVMCgZnjLwKbxTFezo8cJFS8Y+dT/HGWCHneTvVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k5caCOBR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2BKlYtTF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753655873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=CRuiA9HBqnOs88ZELy3CvqIP4fY8B2G+qtyZkLWW6uc=;
	b=k5caCOBRLGXyP/aIB4TRbYe/lpW6bNNXZL2MMi4n4bFRvn9WcLpgoJA0KKF9JX36iN6uvs
	I8SmxQAdtFhb0mr7rrXNlWIJs+zIP9DR63iDJVAmhlxaG0/uoqoaIFWV2XgS8Yap0hkoO0
	E8Rqe+HBo6LtiMQSP7ax/e7Ps0ILjGRwu6QSKhpO/4K1e6CngkLXJrQ9X/cVHDnwDiQkvC
	7HDyM5V/AOEUVddJMRw/+AmH0E30V7ORTvcwJfvIkddSLHbzkOn4H9URaf5/xRtI9BYl3G
	QZitCVAhq55v8Qf5d4zfS/+jzhA9BuinNXBsNg8fo59N6JNTnwej2vTowgiA8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753655873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=CRuiA9HBqnOs88ZELy3CvqIP4fY8B2G+qtyZkLWW6uc=;
	b=2BKlYtTFucBssDqv44SrkVRBsFtQj6wZhX783qOE6JnB9q1KpWKAzPHjqH96Z0X5j/eYpX
	022Ivi4WYwvMkpCQ==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/drivers for v6.17-rc1
References: <175365567943.581055.6806236199247802443.tglx@xen13>
Message-ID: <175365568123.581055.1675064982263600887.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Jul 2025 00:37:52 +0200 (CEST)

Linus,

please pull the latest irq/drivers branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-drivers-2025=
-07-27

up to:  2aad477b5b73: irqchip/renesas-irqc: Convert to DEFINE_SIMPLE_DEV_PM_O=
PS()


Updates for interrupt chip drivers:

 - Add support of forced affinity setting to yet offline CPUs for the
   MIPS-GIC to ensure that the affinity of per CPU interrupts can be set
   during the early bringup phase of a secondary CPU in the hotplug code
   before the CPU is set online and interrupts are enabled.\

 - Add support for the MIPS (RISC-V !?!?) P8700 SoC in the ACLINT_SSWI
   interrupt chip

 - Make the interrupt routing to RISV-V harts specification compliant so it
   supports arbitrary hart indices

 - Add a command line parameter and related handling to disable the generic
   RISCV IMSIC mechanism on platforms which use a trap-emulated IMSIC.
   Unfortunatly this is required because there is no mechanism available to
   discover this programatically.

 - Enable wakeup sources on the Renesas RZV2H driver

 - Convert interrupt chip drivers, which use a open coded variant of
   msi_create_parent_irq_domain() to use the new functionality

 - Convert interrupt chip drivers, which use the old style two level
   implementation of MSI support over to the MSI parent mechanism to
   prepare for removing at least one of the three PCI/MSI backend variants.

 - The usual cleanups and improvements all over the place

Thanks,

	tglx

------------------>
Anup Patel (1):
      irqchip/riscv-imsic: Add kernel parameter to disable IPIs

Biju Das (1):
      irqchip/renesas-rzv2h: Enable SKIP_SET_WAKE and MASK_ON_SUSPEND

Dan Carpenter (1):
      irqchip/ls-scfg-msi: Fix NULL dereference in error handling

Geert Uytterhoeven (3):
      irqchip/renesas-rzv2h: Remove unneeded includes
      irqchip/renesas-intc-irqpin: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
      irqchip/renesas-irqc: Convert to DEFINE_SIMPLE_DEV_PM_OPS()

Jiri Slaby (SUSE) (1):
      irqchip: Use dev_fwnode()

Marc Zyngier (2):
      irqchip/riscv-imsic: Convert to msi_create_parent_irq_domain() helper
      irqchip/imx-mu-msi: Convert to msi_create_parent_irq_domain() helper

Markus Stockhausen (1):
      irqchip/mips-gic: Allow forced affinity

Nam Cao (2):
      irqchip/armada-370-xp: Switch to msi_create_parent_irq_domain()
      irqchip/ls-scfg-msi: Switch to use msi_create_parent_irq_domain()

Thomas Gleixner (8):
      irqdomain: Add device pointer to irq_domain_info and msi_domain_info
      irqchip/bcm2712-mip: Switch to msi_create_parent_irq_domain()
      irqchip/loongson-pch-msi.c: Switch to msi_create_parent_irq_domain()
      irqchip/sg2042-msi: Switch to msi_create_parent_irq_domain()
      irqchip/alpine-msi: Clean up whitespace style
      irqchip/alpine-msi: Convert to lock guards
      irqchip/alpine-msi: Convert to __free
      irqchip/alpine-msi: Switch to msi_create_parent_irq_domain()

Vladimir Kondratiev (7):
      riscv: Helper to parse hart index
      irqchip/riscv-aplic: Use riscv_get_hart_index()
      dt-bindings: interrupt-controller: Add MIPS P8700 aclint-sswi
      irqchip/thead-c900-aclint-sswi: Generalize aclint-sswi driver and add M=
IPS P800 support
      irqchip/aclint-sswi: Remove unneeded includes
      irqchip/aclint-sswi: Reduce data scope
      irqchip/aslint-sswi: Resolve hart index

Zenghui Yu (1):
      irqchip/gic-v3: Fix GICD_CTLR register naming


 Documentation/admin-guide/kernel-parameters.txt    |   7 +
 .../thead,c900-aclint-sswi.yaml                    |  64 +++++++--
 arch/riscv/include/asm/irq.h                       |   2 +
 arch/riscv/kernel/irq.c                            |  34 +++++
 drivers/irqchip/Kconfig                            |  18 ++-
 drivers/irqchip/Makefile                           |   2 +-
 ...-thead-c900-aclint-sswi.c =3D> irq-aclint-sswi.c} | 114 +++++++++------
 drivers/irqchip/irq-alpine-msi.c                   | 155 ++++++++-----------=
--
 drivers/irqchip/irq-armada-370-xp.c                |  48 ++++---
 drivers/irqchip/irq-bcm2712-mip.c                  |  20 +--
 drivers/irqchip/irq-gic-v3.c                       |   6 +-
 drivers/irqchip/irq-imgpdc.c                       |   4 +-
 drivers/irqchip/irq-imx-irqsteer.c                 |   4 +-
 drivers/irqchip/irq-imx-mu-msi.c                   |  14 +-
 drivers/irqchip/irq-keystone.c                     |   4 +-
 drivers/irqchip/irq-loongson-pch-msi.c             |  25 ++--
 drivers/irqchip/irq-ls-scfg-msi.c                  |  50 +++----
 drivers/irqchip/irq-mips-gic.c                     |   8 +-
 drivers/irqchip/irq-mvebu-pic.c                    |   2 +-
 drivers/irqchip/irq-pruss-intc.c                   |   2 +-
 drivers/irqchip/irq-renesas-intc-irqpin.c          |  12 +-
 drivers/irqchip/irq-renesas-irqc.c                 |   8 +-
 drivers/irqchip/irq-renesas-rza1.c                 |   5 +-
 drivers/irqchip/irq-renesas-rzg2l.c                |   5 +-
 drivers/irqchip/irq-renesas-rzv2h.c                |   9 +-
 drivers/irqchip/irq-riscv-aplic-direct.c           |  16 +--
 drivers/irqchip/irq-riscv-imsic-early.c            |  20 ++-
 drivers/irqchip/irq-riscv-imsic-platform.c         |  12 +-
 drivers/irqchip/irq-riscv-imsic-state.c            |   7 +-
 drivers/irqchip/irq-riscv-imsic-state.h            |   1 +
 drivers/irqchip/irq-sg2042-msi.c                   |  20 ++-
 drivers/irqchip/irq-stm32mp-exti.c                 |   4 +-
 drivers/irqchip/irq-ti-sci-inta.c                  |   3 +-
 drivers/irqchip/irq-ti-sci-intr.c                  |   3 +-
 drivers/irqchip/irq-ts4800.c                       |   2 +-
 include/linux/cpuhotplug.h                         |   2 +-
 include/linux/irqdomain.h                          |   2 +
 include/linux/msi.h                                |   2 +
 kernel/irq/irqdomain.c                             |   1 +
 kernel/irq/msi.c                                   |   3 +-
 40 files changed, 402 insertions(+), 318 deletions(-)
 rename drivers/irqchip/{irq-thead-c900-aclint-sswi.c =3D> irq-aclint-sswi.c}=
 (62%)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/=
admin-guide/kernel-parameters.txt
index f1f2c0874da9..7f0e12d0d260 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2538,6 +2538,13 @@
 			requires the kernel to be built with
 			CONFIG_ARM64_PSEUDO_NMI.
=20
+	irqchip.riscv_imsic_noipi
+			[RISC-V,EARLY]
+			Force the kernel to not use IMSIC software injected MSIs
+			as IPIs. Intended for system where IMSIC is trap-n-emulated,
+			and thus want to reduce MMIO traps when triggering IPIs
+			to multiple harts.
+
 	irqfixup	[HW]
 			When an interrupt is not handled search all handlers
 			for it. Intended to get systems with badly broken
diff --git a/Documentation/devicetree/bindings/interrupt-controller/thead,c90=
0-aclint-sswi.yaml b/Documentation/devicetree/bindings/interrupt-controller/t=
head,c900-aclint-sswi.yaml
index 8d330906bbbd..c1ab865fcd64 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclin=
t-sswi.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclin=
t-sswi.yaml
@@ -4,23 +4,32 @@
 $id: http://devicetree.org/schemas/interrupt-controller/thead,c900-aclint-ss=
wi.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
=20
-title: T-HEAD C900 ACLINT Supervisor-level Software Interrupt Device
+title: ACLINT Supervisor-level Software Interrupt Device
=20
 maintainers:
   - Inochi Amaoto <inochiama@outlook.com>
=20
 description:
-  The SSWI device is a part of the THEAD ACLINT device. It provides
-  supervisor-level IPI functionality for a set of HARTs on a THEAD
-  platform. It provides a register to set an IPI (SETSSIP) for each
-  HART connected to the SSWI device.
+  The SSWI device is a part of the ACLINT device. It provides
+  supervisor-level IPI functionality for a set of HARTs on a supported
+  platforms. It provides a register to set an IPI (SETSSIP) for each
+  HART connected to the SSWI device. See draft specification
+  https://github.com/riscvarchive/riscv-aclint
+
+  Following variants of the SSWI ACLINT supported, using dedicated
+  compatible string
+  - THEAD C900
+  - MIPS P8700
=20
 properties:
   compatible:
-    items:
-      - enum:
-          - sophgo,sg2044-aclint-sswi
-      - const: thead,c900-aclint-sswi
+    oneOf:
+      - items:
+          - enum:
+              - sophgo,sg2044-aclint-sswi
+          - const: thead,c900-aclint-sswi
+      - items:
+          - const: mips,p8700-aclint-sswi
=20
   reg:
     maxItems: 1
@@ -34,6 +43,14 @@ properties:
     minItems: 1
     maxItems: 4095
=20
+  riscv,hart-indexes:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 4095
+    description:
+      A list of hart indexes that APLIC should use to address each hart
+      that is mentioned in the "interrupts-extended"
+
 additionalProperties: false
=20
 required:
@@ -43,8 +60,22 @@ required:
   - interrupt-controller
   - interrupts-extended
=20
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mips,p8700-aclint-sswi
+    then:
+      required:
+        - riscv,hart-indexes
+    else:
+      properties:
+        riscv,hart-indexes: false
+
 examples:
   - |
+    //Example 1
     interrupt-controller@94000000 {
       compatible =3D "sophgo,sg2044-aclint-sswi", "thead,c900-aclint-sswi";
       reg =3D <0x94000000 0x00004000>;
@@ -55,4 +86,19 @@ examples:
                             <&cpu3intc 1>,
                             <&cpu4intc 1>;
     };
+
+  - |
+    //Example 2
+    interrupt-controller@94000000 {
+      compatible =3D "mips,p8700-aclint-sswi";
+      reg =3D <0x94000000 0x00004000>;
+      #interrupt-cells =3D <0>;
+      interrupt-controller;
+      interrupts-extended =3D <&cpu1intc 1>,
+                            <&cpu2intc 1>,
+                            <&cpu3intc 1>,
+                            <&cpu4intc 1>;
+      riscv,hart-indexes =3D <0x0 0x1 0x10 0x11>;
+    };
+
 ...
diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index 7b038f3b7cb0..59c975f750c9 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -22,6 +22,8 @@ void arch_trigger_cpumask_backtrace(const cpumask_t *mask, =
int exclude_cpu);
 void riscv_set_intc_hwnode_fn(struct fwnode_handle *(*fn)(void));
=20
 struct fwnode_handle *riscv_get_intc_hwnode(void);
+int riscv_get_hart_index(struct fwnode_handle *fwnode, u32 logical_index,
+			 u32 *hart_index);
=20
 #ifdef CONFIG_ACPI
=20
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index 9ceda02507ca..b6af20bc300f 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -32,6 +32,40 @@ struct fwnode_handle *riscv_get_intc_hwnode(void)
 }
 EXPORT_SYMBOL_GPL(riscv_get_intc_hwnode);
=20
+/**
+ * riscv_get_hart_index() - get hart index for interrupt delivery
+ * @fwnode: interrupt controller node
+ * @logical_index: index within the "interrupts-extended" property
+ * @hart_index: filled with the hart index to use
+ *
+ * RISC-V uses term "hart index" for its interrupt controllers, for the
+ * purpose of the interrupt routing to destination harts.
+ * It may be arbitrary numbers assigned to each destination hart in context
+ * of the particular interrupt domain.
+ *
+ * These numbers encoded in the optional property "riscv,hart-indexes"
+ * that should contain hart index for each interrupt destination in the same
+ * order as in the "interrupts-extended" property. If this property
+ * not exist, it assumed equal to the logical index, i.e. index within the
+ * "interrupts-extended" property.
+ *
+ * Return: error code
+ */
+int riscv_get_hart_index(struct fwnode_handle *fwnode, u32 logical_index,
+			 u32 *hart_index)
+{
+	static const char *prop_hart_index =3D "riscv,hart-indexes";
+	struct device_node *np =3D to_of_node(fwnode);
+
+	if (!np || !of_property_present(np, prop_hart_index)) {
+		*hart_index =3D logical_index;
+		return 0;
+	}
+
+	return of_property_read_u32_index(np, prop_hart_index,
+					  logical_index, hart_index);
+}
+
 #ifdef CONFIG_IRQ_STACKS
 #include <asm/irq_stack.h>
=20
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 0d196e447142..ce7f7314b47d 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -79,12 +79,14 @@ config ARMADA_370_XP_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
 	select PCI_MSI if PCI
+	select IRQ_MSI_LIB if PCI
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
=20
 config ALPINE_MSI
 	bool
 	depends on PCI
 	select PCI_MSI
+	select IRQ_MSI_LIB
 	select GENERIC_IRQ_CHIP
=20
 config AL_FIC
@@ -434,6 +436,7 @@ config LS_SCFG_MSI
 	def_bool y if SOC_LS1021A || ARCH_LAYERSCAPE
 	select IRQ_MSI_IOMMU
 	depends on PCI_MSI
+	select IRQ_MSI_LIB
=20
 config PARTITION_PERCPU
 	bool
@@ -634,18 +637,25 @@ config STARFIVE_JH8100_INTC
=20
 	  If you don't know what to do here, say Y.
=20
-config THEAD_C900_ACLINT_SSWI
-	bool "THEAD C9XX ACLINT S-mode IPI Interrupt Controller"
+config ACLINT_SSWI
+	bool "RISC-V ACLINT S-mode IPI Interrupt Controller"
 	depends on RISCV
 	depends on SMP
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_IRQ_IPI_MUX
 	help
-	  This enables support for T-HEAD specific ACLINT SSWI device
-	  support.
+	  This enables support for variants of the RISC-V ACLINT-SSWI device.
+	  Supported variants are:
+	  - T-HEAD, with compatible "thead,c900-aclint-sswi"
+	  - MIPS P8700, with compatible "mips,p8700-aclint-sswi"
=20
 	  If you don't know what to do here, say Y.
=20
+# Backwards compatibility so oldconfig does not drop it.
+config THEAD_C900_ACLINT_SSWI
+	bool
+	select ACLINT_SSWI
+
 config EXYNOS_IRQ_COMBINER
 	bool "Samsung Exynos IRQ combiner support" if COMPILE_TEST
 	depends on (ARCH_EXYNOS && ARM) || COMPILE_TEST
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 23ca4959e6ce..0458d6c5d161 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -105,7 +105,7 @@ obj-$(CONFIG_RISCV_APLIC_MSI)		+=3D irq-riscv-aplic-msi.o
 obj-$(CONFIG_RISCV_IMSIC)		+=3D irq-riscv-imsic-state.o irq-riscv-imsic-earl=
y.o irq-riscv-imsic-platform.o
 obj-$(CONFIG_SIFIVE_PLIC)		+=3D irq-sifive-plic.o
 obj-$(CONFIG_STARFIVE_JH8100_INTC)	+=3D irq-starfive-jh8100-intc.o
-obj-$(CONFIG_THEAD_C900_ACLINT_SSWI)	+=3D irq-thead-c900-aclint-sswi.o
+obj-$(CONFIG_ACLINT_SSWI)		+=3D irq-aclint-sswi.o
 obj-$(CONFIG_IMX_IRQSTEER)		+=3D irq-imx-irqsteer.o
 obj-$(CONFIG_IMX_INTMUX)		+=3D irq-imx-intmux.o
 obj-$(CONFIG_IMX_MU_MSI)		+=3D irq-imx-mu-msi.o
diff --git a/drivers/irqchip/irq-thead-c900-aclint-sswi.c b/drivers/irqchip/i=
rq-aclint-sswi.c
similarity index 62%
rename from drivers/irqchip/irq-thead-c900-aclint-sswi.c
rename to drivers/irqchip/irq-aclint-sswi.c
index 8ff6e7a1363b..93e28e9f281f 100644
--- a/drivers/irqchip/irq-thead-c900-aclint-sswi.c
+++ b/drivers/irqchip/irq-aclint-sswi.c
@@ -3,87 +3,77 @@
  * Copyright (C) 2024 Inochi Amaoto <inochiama@gmail.com>
  */
=20
-#define pr_fmt(fmt) "thead-c900-aclint-sswi: " fmt
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
-#include <linux/io.h>
-#include <linux/irq.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
-#include <linux/module.h>
-#include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/pci.h>
 #include <linux/spinlock.h>
 #include <linux/smp.h>
 #include <linux/string_choices.h>
 #include <asm/sbi.h>
 #include <asm/vendorid_list.h>
=20
-#define THEAD_ACLINT_xSWI_REGISTER_SIZE		4
-
-#define THEAD_C9XX_CSR_SXSTATUS			0x5c0
-#define THEAD_C9XX_SXSTATUS_CLINTEE		BIT(17)
-
 static int sswi_ipi_virq __ro_after_init;
 static DEFINE_PER_CPU(void __iomem *, sswi_cpu_regs);
=20
-static void thead_aclint_sswi_ipi_send(unsigned int cpu)
+static void aclint_sswi_ipi_send(unsigned int cpu)
 {
 	writel(0x1, per_cpu(sswi_cpu_regs, cpu));
 }
=20
-static void thead_aclint_sswi_ipi_clear(void)
+static void aclint_sswi_ipi_clear(void)
 {
 	writel_relaxed(0x0, this_cpu_read(sswi_cpu_regs));
 }
=20
-static void thead_aclint_sswi_ipi_handle(struct irq_desc *desc)
+static void aclint_sswi_ipi_handle(struct irq_desc *desc)
 {
 	struct irq_chip *chip =3D irq_desc_get_chip(desc);
=20
 	chained_irq_enter(chip, desc);
=20
 	csr_clear(CSR_IP, IE_SIE);
-	thead_aclint_sswi_ipi_clear();
+	aclint_sswi_ipi_clear();
=20
 	ipi_mux_process();
=20
 	chained_irq_exit(chip, desc);
 }
=20
-static int thead_aclint_sswi_starting_cpu(unsigned int cpu)
+static int aclint_sswi_starting_cpu(unsigned int cpu)
 {
 	enable_percpu_irq(sswi_ipi_virq, irq_get_trigger_type(sswi_ipi_virq));
=20
 	return 0;
 }
=20
-static int thead_aclint_sswi_dying_cpu(unsigned int cpu)
+static int aclint_sswi_dying_cpu(unsigned int cpu)
 {
-	thead_aclint_sswi_ipi_clear();
+	aclint_sswi_ipi_clear();
=20
 	disable_percpu_irq(sswi_ipi_virq);
=20
 	return 0;
 }
=20
-static int __init thead_aclint_sswi_parse_irq(struct fwnode_handle *fwnode,
-					      void __iomem *reg)
+static int __init aclint_sswi_parse_irq(struct fwnode_handle *fwnode, void _=
_iomem *reg)
 {
-	struct of_phandle_args parent;
-	unsigned long hartid;
-	u32 contexts, i;
-	int rc, cpu;
+	u32 contexts =3D of_irq_count(to_of_node(fwnode));
=20
-	contexts =3D of_irq_count(to_of_node(fwnode));
 	if (!(contexts)) {
 		pr_err("%pfwP: no ACLINT SSWI context available\n", fwnode);
 		return -EINVAL;
 	}
=20
-	for (i =3D 0; i < contexts; i++) {
+	for (u32 i =3D 0; i < contexts; i++) {
+		struct of_phandle_args parent;
+		unsigned long hartid;
+		u32 hart_index;
+		int rc, cpu;
+
 		rc =3D of_irq_parse_one(to_of_node(fwnode), i, &parent);
 		if (rc)
 			return rc;
@@ -97,7 +87,12 @@ static int __init thead_aclint_sswi_parse_irq(struct fwnod=
e_handle *fwnode,
=20
 		cpu =3D riscv_hartid_to_cpuid(hartid);
=20
-		per_cpu(sswi_cpu_regs, cpu) =3D reg + i * THEAD_ACLINT_xSWI_REGISTER_SIZE;
+		rc =3D riscv_get_hart_index(fwnode, i, &hart_index);
+		if (rc) {
+			pr_warn("%pfwP: hart index [%d] not found\n", fwnode, i);
+			return -EINVAL;
+		}
+		per_cpu(sswi_cpu_regs, cpu) =3D reg + hart_index * 4;
 	}
=20
 	pr_info("%pfwP: register %u CPU%s\n", fwnode, contexts, str_plural(contexts=
));
@@ -105,17 +100,12 @@ static int __init thead_aclint_sswi_parse_irq(struct fw=
node_handle *fwnode,
 	return 0;
 }
=20
-static int __init thead_aclint_sswi_probe(struct fwnode_handle *fwnode)
+static int __init aclint_sswi_probe(struct fwnode_handle *fwnode)
 {
 	struct irq_domain *domain;
 	void __iomem *reg;
 	int virq, rc;
=20
-	/* If it is T-HEAD CPU, check whether SSWI is enabled */
-	if (riscv_cached_mvendorid(0) =3D=3D THEAD_VENDOR_ID &&
-	    !(csr_read(THEAD_C9XX_CSR_SXSTATUS) & THEAD_C9XX_SXSTATUS_CLINTEE))
-		return -ENOTSUPP;
-
 	if (!is_of_node(fwnode))
 		return -EINVAL;
=20
@@ -124,7 +114,7 @@ static int __init thead_aclint_sswi_probe(struct fwnode_h=
andle *fwnode)
 		return -ENOMEM;
=20
 	/* Parse SSWI setting */
-	rc =3D thead_aclint_sswi_parse_irq(fwnode, reg);
+	rc =3D aclint_sswi_parse_irq(fwnode, reg);
 	if (rc < 0)
 		return rc;
=20
@@ -146,22 +136,64 @@ static int __init thead_aclint_sswi_probe(struct fwnode=
_handle *fwnode)
 	}
=20
 	/* Register SSWI irq and handler */
-	virq =3D ipi_mux_create(BITS_PER_BYTE, thead_aclint_sswi_ipi_send);
+	virq =3D ipi_mux_create(BITS_PER_BYTE, aclint_sswi_ipi_send);
 	if (virq <=3D 0) {
 		pr_err("unable to create muxed IPIs\n");
 		irq_dispose_mapping(sswi_ipi_virq);
 		return virq < 0 ? virq : -ENOMEM;
 	}
=20
-	irq_set_chained_handler(sswi_ipi_virq, thead_aclint_sswi_ipi_handle);
+	irq_set_chained_handler(sswi_ipi_virq, aclint_sswi_ipi_handle);
=20
-	cpuhp_setup_state(CPUHP_AP_IRQ_THEAD_ACLINT_SSWI_STARTING,
-			  "irqchip/thead-aclint-sswi:starting",
-			  thead_aclint_sswi_starting_cpu,
-			  thead_aclint_sswi_dying_cpu);
+	cpuhp_setup_state(CPUHP_AP_IRQ_ACLINT_SSWI_STARTING,
+			  "irqchip/aclint-sswi:starting",
+			  aclint_sswi_starting_cpu,
+			  aclint_sswi_dying_cpu);
=20
 	riscv_ipi_set_virq_range(virq, BITS_PER_BYTE);
=20
+	return 0;
+}
+
+/* generic/MIPS variant */
+static int __init generic_aclint_sswi_probe(struct fwnode_handle *fwnode)
+{
+	int rc;
+
+	rc =3D aclint_sswi_probe(fwnode);
+	if (rc)
+		return rc;
+
+	/* Announce that SSWI is providing IPIs */
+	pr_info("providing IPIs using ACLINT SSWI\n");
+
+	return 0;
+}
+
+static int __init generic_aclint_sswi_early_probe(struct device_node *node,
+						  struct device_node *parent)
+{
+	return generic_aclint_sswi_probe(&node->fwnode);
+}
+IRQCHIP_DECLARE(generic_aclint_sswi, "mips,p8700-aclint-sswi", generic_aclin=
t_sswi_early_probe);
+
+/* THEAD variant */
+#define THEAD_C9XX_CSR_SXSTATUS			0x5c0
+#define THEAD_C9XX_SXSTATUS_CLINTEE		BIT(17)
+
+static int __init thead_aclint_sswi_probe(struct fwnode_handle *fwnode)
+{
+	int rc;
+
+	/* If it is T-HEAD CPU, check whether SSWI is enabled */
+	if (riscv_cached_mvendorid(0) =3D=3D THEAD_VENDOR_ID &&
+	    !(csr_read(THEAD_C9XX_CSR_SXSTATUS) & THEAD_C9XX_SXSTATUS_CLINTEE))
+		return -ENOTSUPP;
+
+	rc =3D aclint_sswi_probe(fwnode);
+	if (rc)
+		return rc;
+
 	/* Announce that SSWI is providing IPIs */
 	pr_info("providing IPIs using THEAD ACLINT SSWI\n");
=20
diff --git a/drivers/irqchip/irq-alpine-msi.c b/drivers/irqchip/irq-alpine-ms=
i.c
index a5289dc26dca..159d9ec7c0dd 100644
--- a/drivers/irqchip/irq-alpine-msi.c
+++ b/drivers/irqchip/irq-alpine-msi.c
@@ -14,6 +14,7 @@
=20
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic.h>
+#include <linux/irqchip/irq-msi-lib.h>
 #include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -29,84 +30,45 @@
 #define ALPINE_MSIX_SPI_TARGET_CLUSTER0		BIT(16)
=20
 struct alpine_msix_data {
-	spinlock_t msi_map_lock;
-	phys_addr_t addr;
-	u32 spi_first;		/* The SGI number that MSIs start */
-	u32 num_spis;		/* The number of SGIs for MSIs */
-	unsigned long *msi_map;
-};
-
-static void alpine_msix_mask_msi_irq(struct irq_data *d)
-{
-	pci_msi_mask_irq(d);
-	irq_chip_mask_parent(d);
-}
-
-static void alpine_msix_unmask_msi_irq(struct irq_data *d)
-{
-	pci_msi_unmask_irq(d);
-	irq_chip_unmask_parent(d);
-}
-
-static struct irq_chip alpine_msix_irq_chip =3D {
-	.name			=3D "MSIx",
-	.irq_mask		=3D alpine_msix_mask_msi_irq,
-	.irq_unmask		=3D alpine_msix_unmask_msi_irq,
-	.irq_eoi		=3D irq_chip_eoi_parent,
-	.irq_set_affinity	=3D irq_chip_set_affinity_parent,
+	spinlock_t	msi_map_lock;
+	phys_addr_t	addr;
+	u32		spi_first;	/* The SGI number that MSIs start */
+	u32		num_spis;	/* The number of SGIs for MSIs */
+	unsigned long	*msi_map;
 };
=20
 static int alpine_msix_allocate_sgi(struct alpine_msix_data *priv, int num_r=
eq)
 {
 	int first;
=20
-	spin_lock(&priv->msi_map_lock);
-
-	first =3D bitmap_find_next_zero_area(priv->msi_map, priv->num_spis, 0,
-					   num_req, 0);
-	if (first >=3D priv->num_spis) {
-		spin_unlock(&priv->msi_map_lock);
+	guard(spinlock)(&priv->msi_map_lock);
+	first =3D bitmap_find_next_zero_area(priv->msi_map, priv->num_spis, 0, num_=
req, 0);
+	if (first >=3D priv->num_spis)
 		return -ENOSPC;
-	}
=20
 	bitmap_set(priv->msi_map, first, num_req);
-
-	spin_unlock(&priv->msi_map_lock);
-
 	return priv->spi_first + first;
 }
=20
-static void alpine_msix_free_sgi(struct alpine_msix_data *priv, unsigned sgi,
-				 int num_req)
+static void alpine_msix_free_sgi(struct alpine_msix_data *priv, unsigned int=
 sgi, int num_req)
 {
 	int first =3D sgi - priv->spi_first;
=20
-	spin_lock(&priv->msi_map_lock);
-
+	guard(spinlock)(&priv->msi_map_lock);
 	bitmap_clear(priv->msi_map, first, num_req);
-
-	spin_unlock(&priv->msi_map_lock);
 }
=20
-static void alpine_msix_compose_msi_msg(struct irq_data *data,
-					struct msi_msg *msg)
+static void alpine_msix_compose_msi_msg(struct irq_data *data, struct msi_ms=
g *msg)
 {
 	struct alpine_msix_data *priv =3D irq_data_get_irq_chip_data(data);
 	phys_addr_t msg_addr =3D priv->addr;
=20
 	msg_addr |=3D (data->hwirq << 3);
-
 	msg->address_hi =3D upper_32_bits(msg_addr);
 	msg->address_lo =3D lower_32_bits(msg_addr);
 	msg->data =3D 0;
 }
=20
-static struct msi_domain_info alpine_msix_domain_info =3D {
-	.flags	=3D MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		  MSI_FLAG_PCI_MSIX,
-	.chip	=3D &alpine_msix_irq_chip,
-};
-
 static struct irq_chip middle_irq_chip =3D {
 	.name			=3D "alpine_msix_middle",
 	.irq_mask		=3D irq_chip_mask_parent,
@@ -116,8 +78,7 @@ static struct irq_chip middle_irq_chip =3D {
 	.irq_compose_msi_msg	=3D alpine_msix_compose_msi_msg,
 };
=20
-static int alpine_msix_gic_domain_alloc(struct irq_domain *domain,
-					unsigned int virq, int sgi)
+static int alpine_msix_gic_domain_alloc(struct irq_domain *domain, unsigned =
int virq, int sgi)
 {
 	struct irq_fwspec fwspec;
 	struct irq_data *d;
@@ -138,12 +99,10 @@ static int alpine_msix_gic_domain_alloc(struct irq_domai=
n *domain,
=20
 	d =3D irq_domain_get_irq_data(domain->parent, virq);
 	d->chip->irq_set_type(d, IRQ_TYPE_EDGE_RISING);
-
 	return 0;
 }
=20
-static int alpine_msix_middle_domain_alloc(struct irq_domain *domain,
-					   unsigned int virq,
+static int alpine_msix_middle_domain_alloc(struct irq_domain *domain, unsign=
ed int virq,
 					   unsigned int nr_irqs, void *args)
 {
 	struct alpine_msix_data *priv =3D domain->host_data;
@@ -161,7 +120,6 @@ static int alpine_msix_middle_domain_alloc(struct irq_dom=
ain *domain,
 		irq_domain_set_hwirq_and_chip(domain, virq + i, sgi + i,
 					      &middle_irq_chip, priv);
 	}
-
 	return 0;
=20
 err_sgi:
@@ -170,8 +128,7 @@ static int alpine_msix_middle_domain_alloc(struct irq_dom=
ain *domain,
 	return err;
 }
=20
-static void alpine_msix_middle_domain_free(struct irq_domain *domain,
-					   unsigned int virq,
+static void alpine_msix_middle_domain_free(struct irq_domain *domain, unsign=
ed int virq,
 					   unsigned int nr_irqs)
 {
 	struct irq_data *d =3D irq_domain_get_irq_data(domain, virq);
@@ -182,14 +139,35 @@ static void alpine_msix_middle_domain_free(struct irq_d=
omain *domain,
 }
=20
 static const struct irq_domain_ops alpine_msix_middle_domain_ops =3D {
+	.select	=3D msi_lib_irq_domain_select,
 	.alloc	=3D alpine_msix_middle_domain_alloc,
 	.free	=3D alpine_msix_middle_domain_free,
 };
=20
-static int alpine_msix_init_domains(struct alpine_msix_data *priv,
-				    struct device_node *node)
+#define ALPINE_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |		\
+				    MSI_FLAG_USE_DEF_CHIP_OPS |		\
+				    MSI_FLAG_PCI_MSI_MASK_PARENT)
+
+#define ALPINE_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |		\
+				    MSI_FLAG_PCI_MSIX)
+
+static struct msi_parent_ops alpine_msi_parent_ops =3D {
+	.supported_flags	=3D ALPINE_MSI_FLAGS_SUPPORTED,
+	.required_flags		=3D ALPINE_MSI_FLAGS_REQUIRED,
+	.chip_flags		=3D MSI_CHIP_FLAG_SET_EOI,
+	.bus_select_token	=3D DOMAIN_BUS_NEXUS,
+	.bus_select_mask	=3D MATCH_PCI_MSI,
+	.prefix			=3D "ALPINE-",
+	.init_dev_msi_info	=3D msi_lib_init_dev_msi_info,
+};
+
+static int alpine_msix_init_domains(struct alpine_msix_data *priv, struct de=
vice_node *node)
 {
-	struct irq_domain *middle_domain, *msi_domain, *gic_domain;
+	struct irq_domain_info info =3D {
+		.fwnode		=3D of_fwnode_handle(node),
+		.ops		=3D &alpine_msix_middle_domain_ops,
+		.host_data	=3D priv,
+	};
 	struct device_node *gic_node;
=20
 	gic_node =3D of_irq_find_parent(node);
@@ -198,40 +176,26 @@ static int alpine_msix_init_domains(struct alpine_msix_=
data *priv,
 		return -ENODEV;
 	}
=20
-	gic_domain =3D irq_find_host(gic_node);
+	info.parent =3D irq_find_host(gic_node);
 	of_node_put(gic_node);
-	if (!gic_domain) {
+	if (!info.parent) {
 		pr_err("Failed to find the GIC domain\n");
 		return -ENXIO;
 	}
=20
-	middle_domain =3D irq_domain_create_hierarchy(gic_domain, 0, 0, NULL,
-						    &alpine_msix_middle_domain_ops, priv);
-	if (!middle_domain) {
-		pr_err("Failed to create the MSIX middle domain\n");
-		return -ENOMEM;
-	}
-
-	msi_domain =3D pci_msi_create_irq_domain(of_fwnode_handle(node),
-					       &alpine_msix_domain_info,
-					       middle_domain);
-	if (!msi_domain) {
+	if (!msi_create_parent_irq_domain(&info, &alpine_msi_parent_ops)) {
 		pr_err("Failed to create MSI domain\n");
-		irq_domain_remove(middle_domain);
 		return -ENOMEM;
 	}
-
 	return 0;
 }
=20
-static int alpine_msix_init(struct device_node *node,
-			    struct device_node *parent)
+static int alpine_msix_init(struct device_node *node, struct device_node *pa=
rent)
 {
-	struct alpine_msix_data *priv;
+	struct alpine_msix_data *priv __free(kfree) =3D kzalloc(sizeof(*priv), GFP_=
KERNEL);
 	struct resource res;
 	int ret;
=20
-	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
=20
@@ -240,7 +204,7 @@ static int alpine_msix_init(struct device_node *node,
 	ret =3D of_address_to_resource(node, 0, &res);
 	if (ret) {
 		pr_err("Failed to allocate resource\n");
-		goto err_priv;
+		return ret;
 	}
=20
 	/*
@@ -255,35 +219,28 @@ static int alpine_msix_init(struct device_node *node,
=20
 	if (of_property_read_u32(node, "al,msi-base-spi", &priv->spi_first)) {
 		pr_err("Unable to parse MSI base\n");
-		ret =3D -EINVAL;
-		goto err_priv;
+		return -EINVAL;
 	}
=20
 	if (of_property_read_u32(node, "al,msi-num-spis", &priv->num_spis)) {
 		pr_err("Unable to parse MSI numbers\n");
-		ret =3D -EINVAL;
-		goto err_priv;
+		return -EINVAL;
 	}
=20
-	priv->msi_map =3D bitmap_zalloc(priv->num_spis, GFP_KERNEL);
-	if (!priv->msi_map) {
-		ret =3D -ENOMEM;
-		goto err_priv;
-	}
+	unsigned long *msi_map __free(kfree) =3D bitmap_zalloc(priv->num_spis, GFP_=
KERNEL);
=20
-	pr_debug("Registering %d msixs, starting at %d\n",
-		 priv->num_spis, priv->spi_first);
+	if (!msi_map)
+		return -ENOMEM;
+	priv->msi_map =3D msi_map;
+
+	pr_debug("Registering %d msixs, starting at %d\n", priv->num_spis, priv->sp=
i_first);
=20
 	ret =3D alpine_msix_init_domains(priv, node);
 	if (ret)
-		goto err_map;
+		return ret;
=20
+	retain_and_null_ptr(priv);
+	retain_and_null_ptr(msi_map);
 	return 0;
-
-err_map:
-	bitmap_free(priv->msi_map);
-err_priv:
-	kfree(priv);
-	return ret;
 }
 IRQCHIP_DECLARE(alpine_msix, "al,alpine-msix", alpine_msix_init);
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 67b672a78862..a44c49e985b7 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -20,6 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/irqchip/irq-msi-lib.h>
 #include <linux/cpu.h>
 #include <linux/io.h>
 #include <linux/of_address.h>
@@ -156,7 +157,6 @@
  * @parent_irq:		parent IRQ if MPIC is not top-level interrupt controller
  * @domain:		MPIC main interrupt domain
  * @ipi_domain:		IPI domain
- * @msi_domain:		MSI domain
  * @msi_inner_domain:	MSI inner domain
  * @msi_used:		bitmap of used MSI numbers
  * @msi_lock:		mutex serializing access to @msi_used
@@ -176,7 +176,6 @@ struct mpic {
 	struct irq_domain *ipi_domain;
 #endif
 #ifdef CONFIG_PCI_MSI
-	struct irq_domain *msi_domain;
 	struct irq_domain *msi_inner_domain;
 	DECLARE_BITMAP(msi_used, PCI_MSI_FULL_DOORBELL_NR);
 	struct mutex msi_lock;
@@ -234,18 +233,6 @@ static void mpic_irq_unmask(struct irq_data *d)
=20
 #ifdef CONFIG_PCI_MSI
=20
-static struct irq_chip mpic_msi_irq_chip =3D {
-	.name		=3D "MPIC MSI",
-	.irq_mask	=3D pci_msi_mask_irq,
-	.irq_unmask	=3D pci_msi_unmask_irq,
-};
-
-static struct msi_domain_info mpic_msi_domain_info =3D {
-	.flags	=3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX),
-	.chip	=3D &mpic_msi_irq_chip,
-};
-
 static void mpic_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
 {
 	unsigned int cpu =3D cpumask_first(irq_data_get_effective_affinity_mask(d));
@@ -314,6 +301,7 @@ static void mpic_msi_free(struct irq_domain *domain, unsi=
gned int virq, unsigned
 }
=20
 static const struct irq_domain_ops mpic_msi_domain_ops =3D {
+	.select	=3D msi_lib_irq_domain_select,
 	.alloc	=3D mpic_msi_alloc,
 	.free	=3D mpic_msi_free,
 };
@@ -331,6 +319,21 @@ static void mpic_msi_reenable_percpu(struct mpic *mpic)
 	writel(1, mpic->per_cpu + MPIC_INT_CLEAR_MASK);
 }
=20
+#define MPIC_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS | \
+				 MSI_FLAG_USE_DEF_CHIP_OPS)
+#define MPIC_MSI_FLAGS_SUPPORTED (MSI_FLAG_MULTI_PCI_MSI  | \
+				  MSI_FLAG_PCI_MSIX       | \
+				  MSI_GENERIC_FLAGS_MASK)
+
+static const struct msi_parent_ops mpic_msi_parent_ops =3D {
+	.required_flags		=3D MPIC_MSI_FLAGS_REQUIRED,
+	.supported_flags	=3D MPIC_MSI_FLAGS_SUPPORTED,
+	.bus_select_token	=3D DOMAIN_BUS_NEXUS,
+	.bus_select_mask	=3D MATCH_PCI_MSI,
+	.prefix			=3D "MPIC-",
+	.init_dev_msi_info	=3D msi_lib_init_dev_msi_info,
+};
+
 static int __init mpic_msi_init(struct mpic *mpic, struct device_node *node,
 				phys_addr_t main_int_phys_base)
 {
@@ -348,17 +351,16 @@ static int __init mpic_msi_init(struct mpic *mpic, stru=
ct device_node *node,
 		mpic->msi_doorbell_mask =3D PCI_MSI_FULL_DOORBELL_MASK;
 	}
=20
-	mpic->msi_inner_domain =3D irq_domain_create_linear(NULL, mpic->msi_doorbel=
l_size,
-						       &mpic_msi_domain_ops, mpic);
-	if (!mpic->msi_inner_domain)
-		return -ENOMEM;
+	struct irq_domain_info info =3D {
+		.fwnode		=3D of_fwnode_handle(node),
+		.ops		=3D &mpic_msi_domain_ops,
+		.host_data	=3D mpic,
+		.size		=3D mpic->msi_doorbell_size,
+	};
=20
-	mpic->msi_domain =3D pci_msi_create_irq_domain(of_fwnode_handle(node), &mpi=
c_msi_domain_info,
-						     mpic->msi_inner_domain);
-	if (!mpic->msi_domain) {
-		irq_domain_remove(mpic->msi_inner_domain);
+	mpic->msi_inner_domain =3D msi_create_parent_irq_domain(&info, &mpic_msi_pa=
rent_ops);
+	if (!mpic->msi_inner_domain)
 		return -ENOMEM;
-	}
=20
 	mpic_msi_reenable_percpu(mpic);
=20
diff --git a/drivers/irqchip/irq-bcm2712-mip.c b/drivers/irqchip/irq-bcm2712-=
mip.c
index 63de5ef6cf2d..9bd7bc0bf6d5 100644
--- a/drivers/irqchip/irq-bcm2712-mip.c
+++ b/drivers/irqchip/irq-bcm2712-mip.c
@@ -172,18 +172,18 @@ static const struct msi_parent_ops mip_msi_parent_ops =
=3D {
=20
 static int mip_init_domains(struct mip_priv *mip, struct device_node *np)
 {
-	struct irq_domain *middle;
-
-	middle =3D irq_domain_create_hierarchy(mip->parent, 0, mip->num_msis, of_fw=
node_handle(np),
-					     &mip_middle_domain_ops, mip);
-	if (!middle)
+	struct irq_domain_info info =3D {
+		.fwnode		=3D of_fwnode_handle(np),
+		.ops		=3D &mip_middle_domain_ops,
+		.host_data	=3D mip,
+		.size		=3D mip->num_msis,
+		.parent		=3D mip->parent,
+		.dev		=3D mip->dev,
+	};
+
+	if (!msi_create_parent_irq_domain(&info, &mip_msi_parent_ops))
 		return -ENOMEM;
=20
-	irq_domain_update_bus_token(middle, DOMAIN_BUS_GENERIC_MSI);
-	middle->dev =3D mip->dev;
-	middle->flags |=3D IRQ_DOMAIN_FLAG_MSI_PARENT;
-	middle->msi_parent_ops =3D &mip_msi_parent_ops;
-
 	/*
 	 * All MSI-X unmasked for the host, masked for the VPU, and edge-triggered.
 	 */
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index efc791c43d44..dbeb85677b08 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -190,12 +190,12 @@ static void __init gic_prio_init(void)
=20
 	/*
 	 * How priority values are used by the GIC depends on two things:
-	 * the security state of the GIC (controlled by the GICD_CTRL.DS bit)
+	 * the security state of the GIC (controlled by the GICD_CTLR.DS bit)
 	 * and if Group 0 interrupts can be delivered to Linux in the non-secure
 	 * world as FIQs (controlled by the SCR_EL3.FIQ bit). These affect the
 	 * way priorities are presented in ICC_PMR_EL1 and in the distributor:
 	 *
-	 * GICD_CTRL.DS | SCR_EL3.FIQ | ICC_PMR_EL1 | Distributor
+	 * GICD_CTLR.DS | SCR_EL3.FIQ | ICC_PMR_EL1 | Distributor
 	 * -------------------------------------------------------
 	 *      1       |      -      |  unchanged  |  unchanged
 	 * -------------------------------------------------------
@@ -223,7 +223,7 @@ static void __init gic_prio_init(void)
 		dist_prio_nmi =3D __gicv3_prio_to_ns(dist_prio_nmi);
 	}
=20
-	pr_info("GICD_CTRL.DS=3D%d, SCR_EL3.FIQ=3D%d\n",
+	pr_info("GICD_CTLR.DS=3D%d, SCR_EL3.FIQ=3D%d\n",
 		cpus_have_security_disabled,
 		!cpus_have_group0);
 }
diff --git a/drivers/irqchip/irq-imgpdc.c b/drivers/irqchip/irq-imgpdc.c
index f0410d5d7315..e9ef2f5a7207 100644
--- a/drivers/irqchip/irq-imgpdc.c
+++ b/drivers/irqchip/irq-imgpdc.c
@@ -372,8 +372,8 @@ static int pdc_intc_probe(struct platform_device *pdev)
 	priv->syswake_irq =3D irq;
=20
 	/* Set up an IRQ domain */
-	priv->domain =3D irq_domain_create_linear(of_fwnode_handle(node), 16, &irq_=
generic_chip_ops,
-					     priv);
+	priv->domain =3D irq_domain_create_linear(dev_fwnode(&pdev->dev), 16, &irq_=
generic_chip_ops,
+						priv);
 	if (unlikely(!priv->domain)) {
 		dev_err(&pdev->dev, "cannot add IRQ domain\n");
 		return -ENOMEM;
diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irq=
steer.c
index 6dc9ac48fee5..4682ce5bf8d3 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -212,8 +212,8 @@ static int imx_irqsteer_probe(struct platform_device *pde=
v)
 	/* steer all IRQs into configured channel */
 	writel_relaxed(BIT(data->channel), data->regs + CHANCTRL);
=20
-	data->domain =3D irq_domain_create_linear(of_fwnode_handle(np), data->reg_n=
um * 32,
-					     &imx_irqsteer_domain_ops, data);
+	data->domain =3D irq_domain_create_linear(dev_fwnode(&pdev->dev), data->reg=
_num * 32,
+						&imx_irqsteer_domain_ops, data);
 	if (!data->domain) {
 		dev_err(&pdev->dev, "failed to create IRQ domain\n");
 		ret =3D -ENOMEM;
diff --git a/drivers/irqchip/irq-imx-mu-msi.c b/drivers/irqchip/irq-imx-mu-ms=
i.c
index 137da1927d14..d2a4e8a61a42 100644
--- a/drivers/irqchip/irq-imx-mu-msi.c
+++ b/drivers/irqchip/irq-imx-mu-msi.c
@@ -223,21 +223,21 @@ static const struct msi_parent_ops imx_mu_msi_parent_op=
s =3D {
=20
 static int imx_mu_msi_domains_init(struct imx_mu_msi *msi_data, struct devic=
e *dev)
 {
-	struct fwnode_handle *fwnodes =3D dev_fwnode(dev);
+	struct irq_domain_info info =3D {
+		.ops		=3D &imx_mu_msi_domain_ops,
+		.fwnode		=3D dev_fwnode(dev),
+		.size		=3D IMX_MU_CHANS,
+		.host_data	=3D msi_data,
+	};
 	struct irq_domain *parent;
=20
 	/* Initialize MSI domain parent */
-	parent =3D irq_domain_create_linear(fwnodes, IMX_MU_CHANS,
-					  &imx_mu_msi_domain_ops, msi_data);
+	parent =3D msi_create_parent_irq_domain(&info, &imx_mu_msi_parent_ops);
 	if (!parent) {
 		dev_err(dev, "failed to create IRQ domain\n");
 		return -ENOMEM;
 	}
-
-	irq_domain_update_bus_token(parent, DOMAIN_BUS_NEXUS);
 	parent->dev =3D parent->pm_dev =3D dev;
-	parent->flags |=3D IRQ_DOMAIN_FLAG_MSI_PARENT;
-	parent->msi_parent_ops =3D &imx_mu_msi_parent_ops;
 	return 0;
 }
=20
diff --git a/drivers/irqchip/irq-keystone.c b/drivers/irqchip/irq-keystone.c
index c9e902b7bf48..922fff09354f 100644
--- a/drivers/irqchip/irq-keystone.c
+++ b/drivers/irqchip/irq-keystone.c
@@ -157,8 +157,8 @@ static int keystone_irq_probe(struct platform_device *pde=
v)
 	kirq->chip.irq_mask	=3D keystone_irq_setmask;
 	kirq->chip.irq_unmask	=3D keystone_irq_unmask;
=20
-	kirq->irqd =3D irq_domain_create_linear(of_fwnode_handle(np), KEYSTONE_N_IR=
Q,
-					      &keystone_irq_ops, kirq);
+	kirq->irqd =3D irq_domain_create_linear(dev_fwnode(dev), KEYSTONE_N_IRQ, &k=
eystone_irq_ops,
+					      kirq);
 	if (!kirq->irqd) {
 		dev_err(dev, "IRQ domain registration failed\n");
 		return -ENODEV;
diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loo=
ngson-pch-msi.c
index a0257c7bef10..4aedc9b90ff7 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -153,26 +153,21 @@ static struct msi_parent_ops pch_msi_parent_ops =3D {
 	.init_dev_msi_info	=3D msi_lib_init_dev_msi_info,
 };
=20
-static int pch_msi_init_domains(struct pch_msi_data *priv,
-				struct irq_domain *parent,
+static int pch_msi_init_domains(struct pch_msi_data *priv, struct irq_domain=
 *parent,
 				struct fwnode_handle *domain_handle)
 {
-	struct irq_domain *middle_domain;
-
-	middle_domain =3D irq_domain_create_hierarchy(parent, 0, priv->num_irqs,
-						    domain_handle,
-						    &pch_msi_middle_domain_ops,
-						    priv);
-	if (!middle_domain) {
+	struct irq_domain_info info =3D {
+		.ops		=3D &pch_msi_middle_domain_ops,
+		.size		=3D priv->num_irqs,
+		.parent		=3D parent,
+		.host_data	=3D priv,
+		.fwnode		=3D domain_handle,
+	};
+
+	if (!msi_create_parent_irq_domain(&info, &pch_msi_parent_ops)) {
 		pr_err("Failed to create the MSI middle domain\n");
 		return -ENOMEM;
 	}
-
-	irq_domain_update_bus_token(middle_domain, DOMAIN_BUS_NEXUS);
-
-	middle_domain->flags |=3D IRQ_DOMAIN_FLAG_MSI_PARENT;
-	middle_domain->msi_parent_ops =3D &pch_msi_parent_ops;
-
 	return 0;
 }
=20
diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-=
msi.c
index 84bc5e4b47cf..4910f364e568 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -14,6 +14,7 @@
 #include <linux/iommu.h>
 #include <linux/irq.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/irqchip/irq-msi-lib.h>
 #include <linux/irqdomain.h>
 #include <linux/of_irq.h>
 #include <linux/of_pci.h>
@@ -47,7 +48,6 @@ struct ls_scfg_msi {
 	spinlock_t		lock;
 	struct platform_device	*pdev;
 	struct irq_domain	*parent;
-	struct irq_domain	*msi_domain;
 	void __iomem		*regs;
 	phys_addr_t		msiir_addr;
 	struct ls_scfg_msi_cfg	*cfg;
@@ -57,17 +57,18 @@ struct ls_scfg_msi {
 	unsigned long		*used;
 };
=20
-static struct irq_chip ls_scfg_msi_irq_chip =3D {
-	.name =3D "MSI",
-	.irq_mask	=3D pci_msi_mask_irq,
-	.irq_unmask	=3D pci_msi_unmask_irq,
-};
-
-static struct msi_domain_info ls_scfg_msi_domain_info =3D {
-	.flags	=3D (MSI_FLAG_USE_DEF_DOM_OPS |
-		   MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_PCI_MSIX),
-	.chip	=3D &ls_scfg_msi_irq_chip,
+#define MPIC_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS | \
+				 MSI_FLAG_USE_DEF_CHIP_OPS)
+#define MPIC_MSI_FLAGS_SUPPORTED (MSI_FLAG_PCI_MSIX       | \
+				  MSI_GENERIC_FLAGS_MASK)
+
+static const struct msi_parent_ops ls_scfg_msi_parent_ops =3D {
+	.required_flags		=3D MPIC_MSI_FLAGS_REQUIRED,
+	.supported_flags	=3D MPIC_MSI_FLAGS_SUPPORTED,
+	.bus_select_token	=3D DOMAIN_BUS_NEXUS,
+	.bus_select_mask	=3D MATCH_PCI_MSI,
+	.prefix			=3D "MSI-",
+	.init_dev_msi_info	=3D msi_lib_init_dev_msi_info,
 };
=20
 static int msi_affinity_flag =3D 1;
@@ -185,6 +186,7 @@ static void ls_scfg_msi_domain_irq_free(struct irq_domain=
 *domain,
 }
=20
 static const struct irq_domain_ops ls_scfg_msi_domain_ops =3D {
+	.select	=3D msi_lib_irq_domain_select,
 	.alloc	=3D ls_scfg_msi_domain_irq_alloc,
 	.free	=3D ls_scfg_msi_domain_irq_free,
 };
@@ -214,23 +216,16 @@ static void ls_scfg_msi_irq_handler(struct irq_desc *de=
sc)
=20
 static int ls_scfg_msi_domains_init(struct ls_scfg_msi *msi_data)
 {
-	/* Initialize MSI domain parent */
-	msi_data->parent =3D irq_domain_create_linear(NULL,
-						    msi_data->irqs_num,
-						    &ls_scfg_msi_domain_ops,
-						    msi_data);
+	struct irq_domain_info info =3D {
+		.fwnode		=3D of_fwnode_handle(msi_data->pdev->dev.of_node),
+		.ops		=3D &ls_scfg_msi_domain_ops,
+		.host_data	=3D msi_data,
+		.size		=3D msi_data->irqs_num,
+	};
+
+	msi_data->parent =3D msi_create_parent_irq_domain(&info, &ls_scfg_msi_paren=
t_ops);
 	if (!msi_data->parent) {
-		dev_err(&msi_data->pdev->dev, "failed to create IRQ domain\n");
-		return -ENOMEM;
-	}
-
-	msi_data->msi_domain =3D pci_msi_create_irq_domain(
-				of_fwnode_handle(msi_data->pdev->dev.of_node),
-				&ls_scfg_msi_domain_info,
-				msi_data->parent);
-	if (!msi_data->msi_domain) {
 		dev_err(&msi_data->pdev->dev, "failed to create MSI domain\n");
-		irq_domain_remove(msi_data->parent);
 		return -ENOMEM;
 	}
=20
@@ -405,7 +400,6 @@ static void ls_scfg_msi_remove(struct platform_device *pd=
ev)
 	for (i =3D 0; i < msi_data->msir_num; i++)
 		ls_scfg_msi_teardown_hwirq(&msi_data->msir[i]);
=20
-	irq_domain_remove(msi_data->msi_domain);
 	irq_domain_remove(msi_data->parent);
=20
 	platform_set_drvdata(pdev, NULL);
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 34e8d09c12a0..19a57c5e2b2e 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -375,9 +375,13 @@ static int gic_set_affinity(struct irq_data *d, const st=
ruct cpumask *cpumask,
 	/*
 	 * The GIC specifies that we can only route an interrupt to one VP(E),
 	 * ie. CPU in Linux parlance, at a time. Therefore we always route to
-	 * the first online CPU in the mask.
+	 * the first forced or online CPU in the mask.
 	 */
-	cpu =3D cpumask_first_and(cpumask, cpu_online_mask);
+	if (force)
+		cpu =3D cpumask_first(cpumask);
+	else
+		cpu =3D cpumask_first_and(cpumask, cpu_online_mask);
+
 	if (cpu >=3D NR_CPUS)
 		return -EINVAL;
=20
diff --git a/drivers/irqchip/irq-mvebu-pic.c b/drivers/irqchip/irq-mvebu-pic.c
index 8db638aa21d2..cd8b73482b9f 100644
--- a/drivers/irqchip/irq-mvebu-pic.c
+++ b/drivers/irqchip/irq-mvebu-pic.c
@@ -150,7 +150,7 @@ static int mvebu_pic_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
=20
-	pic->domain =3D irq_domain_create_linear(of_fwnode_handle(node), PIC_MAX_IR=
QS,
+	pic->domain =3D irq_domain_create_linear(dev_fwnode(&pdev->dev), PIC_MAX_IR=
QS,
 					       &mvebu_pic_domain_ops, pic);
 	if (!pic->domain) {
 		dev_err(&pdev->dev, "Failed to allocate irq domain\n");
diff --git a/drivers/irqchip/irq-pruss-intc.c b/drivers/irqchip/irq-pruss-int=
c.c
index 87a5813fd835..81078d56f38d 100644
--- a/drivers/irqchip/irq-pruss-intc.c
+++ b/drivers/irqchip/irq-pruss-intc.c
@@ -555,7 +555,7 @@ static int pruss_intc_probe(struct platform_device *pdev)
=20
 	mutex_init(&intc->lock);
=20
-	intc->domain =3D irq_domain_create_linear(of_fwnode_handle(dev->of_node), m=
ax_system_events,
+	intc->domain =3D irq_domain_create_linear(dev_fwnode(dev), max_system_event=
s,
 						&pruss_intc_irq_domain_ops, intc);
 	if (!intc->domain)
 		return -ENOMEM;
diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-=
renesas-intc-irqpin.c
index 0959ed43b1a9..7951292d2d9b 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -513,10 +513,8 @@ static int intc_irqpin_probe(struct platform_device *pde=
v)
 	irq_chip->irq_set_wake =3D intc_irqpin_irq_set_wake;
 	irq_chip->flags	=3D IRQCHIP_MASK_ON_SUSPEND;
=20
-	p->irq_domain =3D irq_domain_create_simple(of_fwnode_handle(dev->of_node),
-						 nirqs, 0,
-						 &intc_irqpin_irq_domain_ops,
-						 p);
+	p->irq_domain =3D irq_domain_create_simple(dev_fwnode(dev), nirqs, 0,
+						 &intc_irqpin_irq_domain_ops, p);
 	if (!p->irq_domain) {
 		ret =3D -ENXIO;
 		dev_err(dev, "cannot initialize irq domain\n");
@@ -572,7 +570,7 @@ static void intc_irqpin_remove(struct platform_device *pd=
ev)
 	pm_runtime_disable(&pdev->dev);
 }
=20
-static int __maybe_unused intc_irqpin_suspend(struct device *dev)
+static int intc_irqpin_suspend(struct device *dev)
 {
 	struct intc_irqpin_priv *p =3D dev_get_drvdata(dev);
=20
@@ -582,7 +580,7 @@ static int __maybe_unused intc_irqpin_suspend(struct devi=
ce *dev)
 	return 0;
 }
=20
-static SIMPLE_DEV_PM_OPS(intc_irqpin_pm_ops, intc_irqpin_suspend, NULL);
+static DEFINE_SIMPLE_DEV_PM_OPS(intc_irqpin_pm_ops, intc_irqpin_suspend, NUL=
L);
=20
 static struct platform_driver intc_irqpin_device_driver =3D {
 	.probe		=3D intc_irqpin_probe,
@@ -590,7 +588,7 @@ static struct platform_driver intc_irqpin_device_driver =
=3D {
 	.driver		=3D {
 		.name		=3D "renesas_intc_irqpin",
 		.of_match_table	=3D intc_irqpin_dt_ids,
-		.pm		=3D &intc_irqpin_pm_ops,
+		.pm		=3D pm_sleep_ptr(&intc_irqpin_pm_ops),
 	}
 };
=20
diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas=
-irqc.c
index 5c3196e5a437..a20a6471b0e4 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -168,7 +168,7 @@ static int irqc_probe(struct platform_device *pdev)
=20
 	p->cpu_int_base =3D p->iomem + IRQC_INT_CPU_BASE(0); /* SYS-SPI */
=20
-	p->irq_domain =3D irq_domain_create_linear(of_fwnode_handle(dev->of_node), =
p->number_of_irqs,
+	p->irq_domain =3D irq_domain_create_linear(dev_fwnode(dev), p->number_of_ir=
qs,
 						 &irq_generic_chip_ops, p);
 	if (!p->irq_domain) {
 		ret =3D -ENXIO;
@@ -227,7 +227,7 @@ static void irqc_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
=20
-static int __maybe_unused irqc_suspend(struct device *dev)
+static int irqc_suspend(struct device *dev)
 {
 	struct irqc_priv *p =3D dev_get_drvdata(dev);
=20
@@ -237,7 +237,7 @@ static int __maybe_unused irqc_suspend(struct device *dev)
 	return 0;
 }
=20
-static SIMPLE_DEV_PM_OPS(irqc_pm_ops, irqc_suspend, NULL);
+static DEFINE_SIMPLE_DEV_PM_OPS(irqc_pm_ops, irqc_suspend, NULL);
=20
 static const struct of_device_id irqc_dt_ids[] =3D {
 	{ .compatible =3D "renesas,irqc", },
@@ -251,7 +251,7 @@ static struct platform_driver irqc_device_driver =3D {
 	.driver		=3D {
 		.name		=3D "renesas_irqc",
 		.of_match_table	=3D irqc_dt_ids,
-		.pm		=3D &irqc_pm_ops,
+		.pm		=3D pm_sleep_ptr(&irqc_pm_ops),
 	}
 };
=20
diff --git a/drivers/irqchip/irq-renesas-rza1.c b/drivers/irqchip/irq-renesas=
-rza1.c
index 0a9640ba0adb..a697eb55ac90 100644
--- a/drivers/irqchip/irq-renesas-rza1.c
+++ b/drivers/irqchip/irq-renesas-rza1.c
@@ -231,9 +231,8 @@ static int rza1_irqc_probe(struct platform_device *pdev)
 	priv->chip.irq_set_type =3D rza1_irqc_set_type;
 	priv->chip.flags =3D IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_SKIP_SET_WAKE;
=20
-	priv->irq_domain =3D irq_domain_create_hierarchy(parent, 0, IRQC_NUM_IRQ,
-						       of_fwnode_handle(np), &rza1_irqc_domain_ops,
-						       priv);
+	priv->irq_domain =3D irq_domain_create_hierarchy(parent, 0, IRQC_NUM_IRQ, d=
ev_fwnode(dev),
+						       &rza1_irqc_domain_ops, priv);
 	if (!priv->irq_domain) {
 		dev_err(dev, "cannot initialize irq domain\n");
 		ret =3D -ENOMEM;
diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesa=
s-rzg2l.c
index 1e861bd64f97..360d88687e4f 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -574,9 +574,8 @@ static int rzg2l_irqc_common_init(struct device_node *nod=
e, struct device_node *
=20
 	raw_spin_lock_init(&rzg2l_irqc_data->lock);
=20
-	irq_domain =3D irq_domain_create_hierarchy(parent_domain, 0, IRQC_NUM_IRQ,
-						 of_fwnode_handle(node), &rzg2l_irqc_domain_ops,
-						 rzg2l_irqc_data);
+	irq_domain =3D irq_domain_create_hierarchy(parent_domain, 0, IRQC_NUM_IRQ, =
dev_fwnode(dev),
+						 &rzg2l_irqc_domain_ops, rzg2l_irqc_data);
 	if (!irq_domain) {
 		pm_runtime_put(dev);
 		return dev_err_probe(dev, -ENOMEM, "failed to add irq domain\n");
diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesa=
s-rzv2h.c
index 69b32c19e8ff..9018d9c3911e 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -11,18 +11,15 @@
=20
 #include <linux/bitfield.h>
 #include <linux/cleanup.h>
-#include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/irq-renesas-rzv2h.h>
 #include <linux/irqdomain.h>
-#include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/spinlock.h>
-#include <linux/syscore_ops.h>
=20
 /* DT "interrupts" indexes */
 #define ICU_IRQ_START				1
@@ -427,7 +424,9 @@ static const struct irq_chip rzv2h_icu_chip =3D {
 	.irq_retrigger		=3D irq_chip_retrigger_hierarchy,
 	.irq_set_type		=3D rzv2h_icu_set_type,
 	.irq_set_affinity	=3D irq_chip_set_affinity_parent,
-	.flags			=3D IRQCHIP_SET_TYPE_MASKED,
+	.flags			=3D IRQCHIP_MASK_ON_SUSPEND |
+				  IRQCHIP_SET_TYPE_MASKED |
+				  IRQCHIP_SKIP_SET_WAKE,
 };
=20
 static int rzv2h_icu_alloc(struct irq_domain *domain, unsigned int virq, uns=
igned int nr_irqs,
@@ -558,7 +557,7 @@ static int rzv2h_icu_init_common(struct device_node *node=
, struct device_node *p
 	raw_spin_lock_init(&rzv2h_icu_data->lock);
=20
 	irq_domain =3D irq_domain_create_hierarchy(parent_domain, 0, ICU_NUM_IRQ,
-						 of_fwnode_handle(node), &rzv2h_icu_domain_ops,
+						 dev_fwnode(&pdev->dev), &rzv2h_icu_domain_ops,
 						 rzv2h_icu_data);
 	if (!irq_domain) {
 		dev_err(&pdev->dev, "failed to add irq domain\n");
diff --git a/drivers/irqchip/irq-riscv-aplic-direct.c b/drivers/irqchip/irq-r=
iscv-aplic-direct.c
index 205ad61d15e4..c2a75bf3d20c 100644
--- a/drivers/irqchip/irq-riscv-aplic-direct.c
+++ b/drivers/irqchip/irq-riscv-aplic-direct.c
@@ -219,20 +219,6 @@ static int aplic_direct_parse_parent_hwirq(struct device=
 *dev, u32 index,
 	return 0;
 }
=20
-static int aplic_direct_get_hart_index(struct device *dev, u32 logical_index,
-				       u32 *hart_index)
-{
-	const char *prop_hart_index =3D "riscv,hart-indexes";
-	struct device_node *np =3D to_of_node(dev->fwnode);
-
-	if (!np || !of_property_present(np, prop_hart_index)) {
-		*hart_index =3D logical_index;
-		return 0;
-	}
-
-	return of_property_read_u32_index(np, prop_hart_index, logical_index, hart_=
index);
-}
-
 int aplic_direct_setup(struct device *dev, void __iomem *regs)
 {
 	int i, j, rc, cpu, current_cpu, setup_count =3D 0;
@@ -279,7 +265,7 @@ int aplic_direct_setup(struct device *dev, void __iomem *=
regs)
 		cpumask_set_cpu(cpu, &direct->lmask);
=20
 		idc =3D per_cpu_ptr(&aplic_idcs, cpu);
-		rc =3D aplic_direct_get_hart_index(dev, i, &idc->hart_index);
+		rc =3D riscv_get_hart_index(dev->fwnode, i, &idc->hart_index);
 		if (rc) {
 			dev_warn(dev, "hart index not found for IDC%d\n", i);
 			continue;
diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-ri=
scv-imsic-early.c
index d9ae87808651..2709cacf4855 100644
--- a/drivers/irqchip/irq-riscv-imsic-early.c
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -8,6 +8,7 @@
 #include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
+#include <linux/init.h>
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
@@ -21,6 +22,14 @@
 #include "irq-riscv-imsic-state.h"
=20
 static int imsic_parent_irq;
+bool imsic_noipi __ro_after_init;
+
+static int __init imsic_noipi_cfg(char *buf)
+{
+	imsic_noipi =3D true;
+	return 0;
+}
+early_param("irqchip.riscv_imsic_noipi", imsic_noipi_cfg);
=20
 #ifdef CONFIG_SMP
 static void imsic_ipi_send(unsigned int cpu)
@@ -32,12 +41,18 @@ static void imsic_ipi_send(unsigned int cpu)
=20
 static void imsic_ipi_starting_cpu(void)
 {
+	if (imsic_noipi)
+		return;
+
 	/* Enable IPIs for current CPU. */
 	__imsic_id_set_enable(IMSIC_IPI_ID);
 }
=20
 static void imsic_ipi_dying_cpu(void)
 {
+	if (imsic_noipi)
+		return;
+
 	/* Disable IPIs for current CPU. */
 	__imsic_id_clear_enable(IMSIC_IPI_ID);
 }
@@ -46,6 +61,9 @@ static int __init imsic_ipi_domain_init(void)
 {
 	int virq;
=20
+	if (imsic_noipi)
+		return 0;
+
 	/* Create IMSIC IPI multiplexing */
 	virq =3D ipi_mux_create(IMSIC_NR_IPI, imsic_ipi_send);
 	if (virq <=3D 0)
@@ -88,7 +106,7 @@ static void imsic_handle_irq(struct irq_desc *desc)
 	while ((local_id =3D csr_swap(CSR_TOPEI, 0))) {
 		local_id >>=3D TOPEI_ID_SHIFT;
=20
-		if (local_id =3D=3D IMSIC_IPI_ID) {
+		if (!imsic_noipi && local_id =3D=3D IMSIC_IPI_ID) {
 			if (IS_ENABLED(CONFIG_SMP))
 				ipi_mux_process();
 			continue;
diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq=
-riscv-imsic-platform.c
index 1b9fbfce9581..74a2a28f9403 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -307,6 +307,11 @@ static const struct msi_parent_ops imsic_msi_parent_ops =
=3D {
=20
 int imsic_irqdomain_init(void)
 {
+	struct irq_domain_info info =3D {
+		.fwnode		=3D imsic->fwnode,
+		.ops		=3D &imsic_base_domain_ops,
+		.host_data	=3D imsic,
+	};
 	struct imsic_global_config *global;
=20
 	if (!imsic || !imsic->fwnode) {
@@ -320,16 +325,11 @@ int imsic_irqdomain_init(void)
 	}
=20
 	/* Create Base IRQ domain */
-	imsic->base_domain =3D irq_domain_create_tree(imsic->fwnode,
-						    &imsic_base_domain_ops, imsic);
+	imsic->base_domain =3D msi_create_parent_irq_domain(&info, &imsic_msi_paren=
t_ops);
 	if (!imsic->base_domain) {
 		pr_err("%pfwP: failed to create IMSIC base domain\n", imsic->fwnode);
 		return -ENOMEM;
 	}
-	imsic->base_domain->flags |=3D IRQ_DOMAIN_FLAG_MSI_PARENT;
-	imsic->base_domain->msi_parent_ops =3D &imsic_msi_parent_ops;
-
-	irq_domain_update_bus_token(imsic->base_domain, DOMAIN_BUS_NEXUS);
=20
 	global =3D &imsic->global;
 	pr_info("%pfwP:  hart-index-bits: %d,  guest-index-bits: %d\n",
diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-ri=
scv-imsic-state.c
index 77670dd645ac..dc95ad856d80 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -134,7 +134,7 @@ static bool __imsic_local_sync(struct imsic_local_priv *l=
priv)
 	lockdep_assert_held(&lpriv->lock);
=20
 	for_each_set_bit(i, lpriv->dirty_bitmap, imsic->global.nr_ids + 1) {
-		if (!i || i =3D=3D IMSIC_IPI_ID)
+		if (!i || (!imsic_noipi && i =3D=3D IMSIC_IPI_ID))
 			goto skip;
 		vec =3D &lpriv->vectors[i];
=20
@@ -419,7 +419,7 @@ void imsic_vector_debug_show(struct seq_file *m, struct i=
msic_vector *vec, int i
 	seq_printf(m, "%*starget_cpu      : %5u\n", ind, "", vec->cpu);
 	seq_printf(m, "%*starget_local_id : %5u\n", ind, "", vec->local_id);
 	seq_printf(m, "%*sis_reserved     : %5u\n", ind, "",
-		   (vec->local_id <=3D IMSIC_IPI_ID) ? 1 : 0);
+		   (!imsic_noipi && vec->local_id <=3D IMSIC_IPI_ID) ? 1 : 0);
 	seq_printf(m, "%*sis_enabled      : %5u\n", ind, "", is_enabled ? 1 : 0);
 	seq_printf(m, "%*sis_move_pending : %5u\n", ind, "", mvec ? 1 : 0);
 	if (mvec) {
@@ -583,7 +583,8 @@ static int __init imsic_matrix_init(void)
 	irq_matrix_assign_system(imsic->matrix, 0, false);
=20
 	/* Reserve IPI ID because it is special and used internally */
-	irq_matrix_assign_system(imsic->matrix, IMSIC_IPI_ID, false);
+	if (!imsic_noipi)
+		irq_matrix_assign_system(imsic->matrix, IMSIC_IPI_ID, false);
=20
 	return 0;
 }
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-ri=
scv-imsic-state.h
index 3202ffa4e849..57f951952b0c 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.h
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -61,6 +61,7 @@ struct imsic_priv {
 	struct irq_domain			*base_domain;
 };
=20
+extern bool imsic_noipi;
 extern struct imsic_priv *imsic;
=20
 void __imsic_eix_update(unsigned long base_id, unsigned long num_id, bool pe=
nd, bool val);
diff --git a/drivers/irqchip/irq-sg2042-msi.c b/drivers/irqchip/irq-sg2042-ms=
i.c
index af16bc5a3c8b..bcfddc51bc6a 100644
--- a/drivers/irqchip/irq-sg2042-msi.c
+++ b/drivers/irqchip/irq-sg2042-msi.c
@@ -219,20 +219,18 @@ static const struct msi_parent_ops sg2044_msi_parent_op=
s =3D {
 static int sg204x_msi_init_domains(struct sg204x_msi_chipdata *data,
 				   struct irq_domain *plic_domain, struct device *dev)
 {
-	struct fwnode_handle *fwnode =3D dev_fwnode(dev);
-	struct irq_domain *middle_domain;
-
-	middle_domain =3D irq_domain_create_hierarchy(plic_domain, 0, data->num_irq=
s, fwnode,
-						    &sg204x_msi_middle_domain_ops, data);
-	if (!middle_domain) {
+	struct irq_domain_info info =3D {
+		.ops		=3D &sg204x_msi_middle_domain_ops,
+		.parent		=3D plic_domain,
+		.size		=3D data->num_irqs,
+		.fwnode		=3D dev_fwnode(dev),
+		.host_data	=3D data,
+	};
+
+	if (!msi_create_parent_irq_domain(&info, data->chip_info->parent_ops)) {
 		pr_err("Failed to create the MSI middle domain\n");
 		return -ENOMEM;
 	}
-
-	irq_domain_update_bus_token(middle_domain, DOMAIN_BUS_NEXUS);
-
-	middle_domain->flags |=3D IRQ_DOMAIN_FLAG_MSI_PARENT;
-	middle_domain->msi_parent_ops =3D data->chip_info->parent_ops;
 	return 0;
 }
=20
diff --git a/drivers/irqchip/irq-stm32mp-exti.c b/drivers/irqchip/irq-stm32mp=
-exti.c
index c6b4407d05f9..a24f4f1a4f8f 100644
--- a/drivers/irqchip/irq-stm32mp-exti.c
+++ b/drivers/irqchip/irq-stm32mp-exti.c
@@ -683,9 +683,7 @@ static int stm32mp_exti_probe(struct platform_device *pde=
v)
 	}
=20
 	domain =3D irq_domain_create_hierarchy(parent_domain, 0, drv_data->bank_nr =
* IRQS_PER_BANK,
-					     of_fwnode_handle(np), &stm32mp_exti_domain_ops,
-					     host_data);
-
+					     dev_fwnode(dev), &stm32mp_exti_domain_ops, host_data);
 	if (!domain) {
 		dev_err(dev, "Could not register exti domain\n");
 		return -ENOMEM;
diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-i=
nta.c
index 7de59238e6b0..01963d36cfaf 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -701,8 +701,7 @@ static int ti_sci_inta_irq_domain_probe(struct platform_d=
evice *pdev)
 	if (ret)
 		return ret;
=20
-	domain =3D irq_domain_create_linear(of_fwnode_handle(dev_of_node(dev)),
-					  ti_sci_get_num_resources(inta->vint),
+	domain =3D irq_domain_create_linear(dev_fwnode(dev), ti_sci_get_num_resourc=
es(inta->vint),
 					  &ti_sci_inta_irq_domain_ops, inta);
 	if (!domain) {
 		dev_err(dev, "Failed to allocate IRQ domain\n");
diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-i=
ntr.c
index 07fff5ae5ce0..354613e74ad0 100644
--- a/drivers/irqchip/irq-ti-sci-intr.c
+++ b/drivers/irqchip/irq-ti-sci-intr.c
@@ -274,8 +274,7 @@ static int ti_sci_intr_irq_domain_probe(struct platform_d=
evice *pdev)
 		return PTR_ERR(intr->out_irqs);
 	}
=20
-	domain =3D irq_domain_create_hierarchy(parent_domain, 0, 0,
-					     of_fwnode_handle(dev_of_node(dev)),
+	domain =3D irq_domain_create_hierarchy(parent_domain, 0, 0, dev_fwnode(dev),
 					     &ti_sci_intr_irq_domain_ops, intr);
 	if (!domain) {
 		dev_err(dev, "Failed to allocate IRQ domain\n");
diff --git a/drivers/irqchip/irq-ts4800.c b/drivers/irqchip/irq-ts4800.c
index e625f4fb2bb8..1e236d5b7516 100644
--- a/drivers/irqchip/irq-ts4800.c
+++ b/drivers/irqchip/irq-ts4800.c
@@ -125,7 +125,7 @@ static int ts4800_ic_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
=20
-	data->domain =3D irq_domain_create_linear(of_fwnode_handle(node), 8, &ts480=
0_ic_ops, data);
+	data->domain =3D irq_domain_create_linear(dev_fwnode(&pdev->dev), 8, &ts480=
0_ic_ops, data);
 	if (!data->domain) {
 		dev_err(&pdev->dev, "cannot add IRQ domain\n");
 		return -ENOMEM;
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index df366ee15456..d381420bbd5f 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -145,7 +145,7 @@ enum cpuhp_state {
 	CPUHP_AP_IRQ_EIOINTC_STARTING,
 	CPUHP_AP_IRQ_AVECINTC_STARTING,
 	CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
-	CPUHP_AP_IRQ_THEAD_ACLINT_SSWI_STARTING,
+	CPUHP_AP_IRQ_ACLINT_SSWI_STARTING,
 	CPUHP_AP_IRQ_RISCV_IMSIC_STARTING,
 	CPUHP_AP_IRQ_RISCV_SBI_IPI_STARTING,
 	CPUHP_AP_ARM_MVEBU_COHERENCY,
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 7387d183029b..266b5e5bb8ce 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -279,6 +279,7 @@ struct irq_domain_chip_generic_info;
  *			domains are added using same fwnode
  * @ops:		Domain operation callbacks
  * @host_data:		Controller private data pointer
+ * @dev:		Device which creates the domain
  * @dgc_info:		Geneneric chip information structure pointer used to
  *			create generic chips for the domain if not NULL.
  * @init:		Function called when the domain is created.
@@ -298,6 +299,7 @@ struct irq_domain_info {
 	const char				*name_suffix;
 	const struct irq_domain_ops		*ops;
 	void					*host_data;
+	struct device				*dev;
 #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
 	/**
 	 * @parent: Pointer to the parent irq domain used in a hierarchy domain
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 6863540f4b71..77227d23ea84 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -488,6 +488,7 @@ struct msi_domain_ops {
  *			gets initialized to the maximum software index limit
  *			by the domain creation code.
  * @ops:		The callback data structure
+ * @dev:		Device which creates the domain
  * @chip:		Optional: associated interrupt chip
  * @chip_data:		Optional: associated interrupt chip data
  * @handler:		Optional: associated interrupt flow handler
@@ -501,6 +502,7 @@ struct msi_domain_info {
 	enum irq_domain_bus_token	bus_token;
 	unsigned int			hwsize;
 	struct msi_domain_ops		*ops;
+	struct device			*dev;
 	struct irq_chip			*chip;
 	void				*chip_data;
 	irq_flow_handler_t		handler;
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index c8b6de09047b..4afbd3ac532f 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -317,6 +317,7 @@ static struct irq_domain *__irq_domain_instantiate(const =
struct irq_domain_info
=20
 	domain->flags |=3D info->domain_flags;
 	domain->exit =3D info->exit;
+	domain->dev =3D info->dev;
=20
 #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
 	if (info->parent) {
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 9febe797a5f6..9b09ad3f9914 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -889,6 +889,7 @@ static struct irq_domain *__msi_create_irq_domain(struct =
fwnode_handle *fwnode,
=20
 	if (domain) {
 		irq_domain_update_bus_token(domain, info->bus_token);
+		domain->dev =3D info->dev;
 		if (info->flags & MSI_FLAG_PARENT_PM_DEV)
 			domain->pm_dev =3D parent->pm_dev;
 	}
@@ -1051,6 +1052,7 @@ bool msi_create_device_irq_domain(struct device *dev, u=
nsigned int domid,
 	bundle->info.data =3D domain_data;
 	bundle->info.chip_data =3D chip_data;
 	bundle->info.alloc_data =3D &bundle->alloc_info;
+	bundle->info.dev =3D dev;
=20
 	pops =3D parent->msi_parent_ops;
 	snprintf(bundle->name, sizeof(bundle->name), "%s%s-%s",
@@ -1089,7 +1091,6 @@ bool msi_create_device_irq_domain(struct device *dev, u=
nsigned int domid,
 	if (!domain)
 		return false;
=20
-	domain->dev =3D dev;
 	dev->msi.data->__domains[domid].domain =3D domain;
=20
 	if (msi_domain_prepare_irqs(domain, dev, hwsize, &bundle->alloc_info)) {



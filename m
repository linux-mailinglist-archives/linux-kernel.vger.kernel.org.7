Return-Path: <linux-kernel+bounces-829776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BC7B97CD0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 01:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498BE1883624
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 23:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6664D30FC1E;
	Tue, 23 Sep 2025 23:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QLIvTSXQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536E230FC0C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 23:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758670189; cv=none; b=E9ZzcRCNGPftkLYfy2gltNdebCHkV1G8/QqVakoMWPOTysH50Z7z1tguPd9Gtwhlsd3EREGgmUuUeKImLLAleG6KkjM3QhB0833WXFArxpsF3GvvWBCYCoVpnbxpX0VbjNdpvxwZ+9qNNihkHOnhMB4YCDbFwqFdmNBZm+l+jpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758670189; c=relaxed/simple;
	bh=l6J2hg0HHZ6oS+VbUh69Nea2mhAnLkPj6xLUKriEX90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTJmoqNsh8FDsE/0KGG15Eiamc58Ji8CeRnHp/ommBlpMRAh3mqn3U2sXwN8goThBR5gkeh4kM7iSbwHjeG9xhw2XPCMGsC9+qpJgB0KPAbH625x+2+SuSrlEfaClyGQFR4ibdih5gK6FWjAMJ9DhKpIsA8zwB3A33cxisGg9tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QLIvTSXQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758670185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2W21xVe5Wj7e2KxydhWpRo7AyVvlS2UhzN4VDUmaXFM=;
	b=QLIvTSXQAfqI/aBNOqP0go1htToOxTTFUnYLqA7r1jNJR7TEdJ6/Sm3kOuffwOM4lL5Gx1
	yI4l0JbvaK8Kpx5wx+LVMM+WX5RD+rONApzP6kHObW0BJ83ZFi2mP2JEtIRLkBcAoDW9bE
	sxLbmLmMRiR0FPWtG5NzCeO/YWHeipw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-pV8PSUBhP6SLrsIcD7iblQ-1; Tue,
 23 Sep 2025 19:29:41 -0400
X-MC-Unique: pV8PSUBhP6SLrsIcD7iblQ-1
X-Mimecast-MFC-AGG-ID: pV8PSUBhP6SLrsIcD7iblQ_1758670180
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1BF21800578;
	Tue, 23 Sep 2025 23:29:40 +0000 (UTC)
Received: from thinkpad-p1.kanata.rendec.net (unknown [10.22.66.88])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 848D01800451;
	Tue, 23 Sep 2025 23:29:39 +0000 (UTC)
From: Radu Rendec <rrendec@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Brian Masney <bmasney@redhat.com>,
	Eric Chanudet <echanude@redhat.com>
Subject: [PATCH 1/1] samples: Add irqchip test driver
Date: Tue, 23 Sep 2025 19:29:05 -0400
Message-ID: <20250923232905.1510547-2-rrendec@redhat.com>
In-Reply-To: <20250923232905.1510547-1-rrendec@redhat.com>
References: <20250923232905.1510547-1-rrendec@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add a test driver that demonstrates implementation of multiple IRQ chip
types and their domains. The driver implements:

- Root IRQ chip simulating direct CPU interrupt lines
- Hierarchical IRQ domain with 1:1 parent mapping
- Interrupt multiplexer domain with chained interrupts

The driver supports simulating interrupt handling by triggering fake
interrupts via sysfs parameter, with CPU affinity simulation using
targeted work items.

This serves as a reference implementation and testing sandbox for IRQ
chip driver development and debugging.

Signed-off-by: Radu Rendec <rrendec@redhat.com>
---
 samples/Kconfig             |  10 +
 samples/Makefile            |   1 +
 samples/irqchip/Makefile    |   1 +
 samples/irqchip/irqc_test.c | 576 ++++++++++++++++++++++++++++++++++++
 4 files changed, 588 insertions(+)
 create mode 100644 samples/irqchip/Makefile
 create mode 100644 samples/irqchip/irqc_test.c

diff --git a/samples/Kconfig b/samples/Kconfig
index 6e072a5f1ed86..6a4f696ca4311 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -320,6 +320,16 @@ config SAMPLE_HUNG_TASK
 	  Reading these files with multiple processes triggers hung task
 	  detection by holding locks for a long time (256 seconds).
 
+config SAMPLE_IRQCHIP
+	bool "Test IRQ chip driver"
+	help
+	  Build a driver that demonstrates the implementation of multiple IRQ
+	  chip types (root, hierarchical, multiplexing). It serves as a
+	  reference implementation for IRQ chip driver development, showcasing
+	  different domain management patterns and interrupt routing mechanisms.
+	  It supports simulation of interrupt handling with CPU affinity through
+	  sysfs parameters.
+
 source "samples/rust/Kconfig"
 
 source "samples/damon/Kconfig"
diff --git a/samples/Makefile b/samples/Makefile
index 07641e177bd8b..380168e6eae55 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_SAMPLE_CONNECTOR)		+= connector/
 obj-$(CONFIG_SAMPLE_FANOTIFY_ERROR)	+= fanotify/
 subdir-$(CONFIG_SAMPLE_HIDRAW)		+= hidraw
 obj-$(CONFIG_SAMPLE_HW_BREAKPOINT)	+= hw_breakpoint/
+obj-$(CONFIG_SAMPLE_IRQCHIP)		+= irqchip/
 obj-$(CONFIG_SAMPLE_KDB)		+= kdb/
 obj-$(CONFIG_SAMPLE_KFIFO)		+= kfifo/
 obj-$(CONFIG_SAMPLE_KOBJECT)		+= kobject/
diff --git a/samples/irqchip/Makefile b/samples/irqchip/Makefile
new file mode 100644
index 0000000000000..fb8600ee15e67
--- /dev/null
+++ b/samples/irqchip/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_SAMPLE_IRQCHIP) += irqc_test.o
diff --git a/samples/irqchip/irqc_test.c b/samples/irqchip/irqc_test.c
new file mode 100644
index 0000000000000..bd897f6a3b2fa
--- /dev/null
+++ b/samples/irqchip/irqc_test.c
@@ -0,0 +1,576 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IRQ chip driver sandbox
+ *
+ * This driver implements three different IRQ chips, each with its own IRQ
+ * domain. The following chips/domains are implemented:
+ *   - "root" - simulation of direct IRQ lines to the CPU. This is similar to
+ *     the APIC on x86 systems or GIC on ARM systems.
+ *   - "hier" - a hierarchical domain sitting on top of "root". This is similar
+ *     to a GPIO driver that implements the hierarchical IRQ API and where each
+ *     GPIO pin has a (distinct) parent IRQ.
+ *   - "imux" - an interrupt multiplexing domain sitting on top of "root". This
+ *     domain has a single parent interrupt and multiple downstream interrupts.
+ *     It uses the legacy IRQ API and chained interrupts.
+ *
+ * +------------+                  +------------+
+ * |            |  hwirq 0         |            |  hwirq 0
+ * |            +<-----------------+            +<----------------- virq #2
+ * |            |  hwirq 1         |    hier    |  hwirq 1
+ * |            +<-----------------+            +<----------------- virq #3
+ * |            |                  |            |
+ * |            |                  +------------+
+ * |    root    |
+ * |            |                  +------------+
+ * |            |                  |            |  hwirq 0
+ * |            |  hwirq 2         |            +<----------------- virq #4
+ * |            +<-----------------+    imux    |  hwirq 1
+ * |            |         virq #1  |            +<----------------- virq #5
+ * |            |                  |            |
+ * +------------+                  +------------+
+ *
+ * The arrows indicate how interrupt signals are routed from a (virtual)
+ * hardware perspective. In software, interrupt handlers are called in the
+ * opposite direction. With real hardware, each interrupt in "root" would
+ * have a CPU interrupt vector.
+ *
+ * The important thing to note is that virqs #2 and #3 are mapped end to end
+ * (the same virq is mapped in both "hier" and "root"), while virqs #4 and #5
+ * are terminated in "imux" and share a common chained interrupt (virq #1).
+ * Chained interrupts are still assigned a virq but do not show up in
+ * /proc/interrupts.
+ *
+ * The driver also supports simulating the interrupt handling path. Fake
+ * interrupts can be triggered by writing the corresponding virq number to a
+ * sysfs file. That simulates the corresponding hwirq occurring in the "root"
+ * domain. CPU affinity is simulated by running the interrupt handlers in a
+ * (CPU targeted) work item context, with local interrupts disabled. When
+ * the affinity mask contains multiple CPUs, the interrupt always runs on the
+ * first CPU in the mask.
+ */
+#define pr_fmt(fmt) "irqc_test: " fmt
+
+#include <linux/module.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/irqdomain.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/cpuhplock.h>
+
+/* Number of IRQs in the root IRQ domain */
+#define NUM_TOTAL_IRQS_ROOT	4
+
+/* Number of IRQs in the hierarchical IRQ domain */
+#define NUM_MAPPED_IRQS_HIER	2
+#define NUM_TOTAL_IRQS_HIER	8
+
+/* Number of IRQs in the multiplexer IRQ domain */
+#define NUM_MAPPED_IRQS_IMUX	2
+#define NUM_TOTAL_IRQS_IMUX	8
+
+/* Total number of mapped IRQs */
+#define NUM_MAPPED_IRQS (NUM_MAPPED_IRQS_HIER + NUM_MAPPED_IRQS_IMUX)
+
+static struct irq_domain *root_irqd;
+static struct irq_domain *hier_irqd;
+static struct irq_domain *imux_irqd;
+static int mapped_virq[NUM_MAPPED_IRQS];
+static int dummydev[NUM_MAPPED_IRQS];
+static int imux_parent_irq;
+static unsigned long imux_pending_hwirq;
+
+/*
+ * In case CONFIG_GENERIC_PENDING_IRQ is enabled, we rely on this callback to
+ * effectively set the affinity when the next IRQ occurs. This handler is
+ * called automatically by the IRQ subsystem. The irq_move_irq() function checks
+ * if the affinity move is pending and eventually calls our .irq_set_affinity
+ * handler.
+ *
+ * Note: CONFIG_GENERIC_PENDING_IRQ is not configurable directly by the user
+ *       and is enabled automatically on x86. It is NOT enabled on arm64.
+ *
+ * When CONFIG_GENERIC_PENDING_IRQ is not enabled, irq_can_move_pcntxt() is
+ * a stub that always returns true, and then irq_set_affinity_locked() calls
+ * the .irq_set_affinity handler directly.
+ */
+static void root_ack(struct irq_data *data)
+{
+	irq_move_irq(data);
+}
+
+/*
+ * This function exists for the sole purpose of keeping chained IRQ handlers
+ * happy. A chained IRQ handler typically calls chained_irq_enter() and
+ * chained_irq_exit(), and so does our imux_irq_dispatch() handler. These
+ * functions assume either .irq_eoi or .irq_mask/.irq_unmask are implemented.
+ * If none of those is implemented, there will be a NULL pointer dereference
+ * attempting to call .irq_mask/.irq_unmask.
+ *
+ * Keep in mind that the handler is called for the *parent* interrupt. In our
+ * case, `desc` describes the root domain virq, and irq_desc_get_chip(desc) is
+ * `root_chip`.
+ */
+static void root_eoi(struct irq_data *data)
+{
+}
+
+/*
+ * The effective affinity is not set automatically by the IRQ subsystem because
+ * only the irqchip driver knows when the affinity has been configured in the
+ * underlying hardware.
+ *
+ * The .irq_set_affinity handler is called automatically by the IRQ subsystem
+ * when a new IRQ is set up (and the affinity is set by default to all CPUs).
+ * If we don't update the effective affinity here, we may raise the pr_warn in
+ * irq_validate_effective_affinity() (called through irq_do_set_affinity())
+ * during that initial call to the .irq_set_affinity handler.
+ */
+static int root_set_affinity(struct irq_data *data, const struct cpumask *dest, bool force)
+{
+	pr_info("%s: set virq %u (irq %lu) affinity to 0x%*pb\n",
+		data->chip->name, data->irq, data->hwirq,
+		cpumask_pr_args(dest));
+	irq_data_update_effective_affinity(data, dest);
+	return IRQ_SET_MASK_OK;
+}
+
+static const struct irq_chip root_chip = {
+	.name = "TEST-ROOT-IC",
+	.irq_ack = root_ack,
+	.irq_set_affinity = root_set_affinity,
+	.irq_eoi = root_eoi,
+};
+
+static int root_alloc(struct irq_domain *irqd, unsigned int virq,
+		      unsigned int nr_irqs, void *data)
+{
+	struct irq_fwspec *fwspec = data;
+	irq_hw_number_t hwirq;
+	unsigned int type;
+	int ret, i;
+
+	pr_info("[%s] irq = %u, nr_irqs = %u\n", irqd->name, virq, nr_irqs);
+
+	ret = irq_domain_translate_onecell(irqd, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr_irqs; i++) {
+		pr_info("\tvirq = %u, hwirq = %lu\n", virq + i, hwirq + i);
+		irq_domain_set_info(irqd, virq, hwirq, &root_chip, NULL,
+				    handle_level_irq, NULL, NULL);
+	}
+
+	return 0;
+}
+
+/*
+ * Parent IRQ domains *must* use the new API (i.e. alloc/free vs. map) to
+ * support hierarchy, for the following reasons:
+ *   - The child .alloc() function calls irq_domain_alloc_irqs_parent().
+ *   - The irq_domain_alloc_irqs_hierarchy() is just a thin wrapper around
+ *     irq_domain_alloc_irqs_hierarchy().
+ *   - Finally, irq_domain_alloc_irqs_hierarchy() explicitly checks that
+ *     the (parent) domain implements the alloc() function and returns an
+ *     error otherwise.
+ *
+ * Furthermore, Documentation/core-api/irq/irq-domain.rst clearly states that
+ * the new API must be used for all domains to support hierarchy.
+ *
+ * Note: The .free() function is also part of the new API and is mandatory but
+ *       there is a default implementation that we can use. If we do not
+ *       implement this function and .alloc() fails for whatever reason, we get
+ *       an oops as the IRQ framework tries to rollback whatever has been done.
+ */
+static const struct irq_domain_ops root_ops = {
+	.alloc = root_alloc,
+	.free = irq_domain_free_irqs_common,
+	.translate = irq_domain_translate_onecell,
+};
+
+/*
+ * Since hierarchical interrupts are mapped 1:1 in all domains along the path,
+ * CPU affinity is not shared with other interrupts. Use the parent handlers to
+ * set the affinity in the root domain.
+ */
+static const struct irq_chip hier_chip = {
+	.name = "TEST-HIER-IC",
+	.irq_ack = irq_chip_ack_parent,
+	.irq_set_affinity = irq_chip_set_affinity_parent,
+};
+
+/*
+ * For a GPIO IRQ chip, this is gpiochip_hierarchy_irq_domain_alloc(), and the
+ * ops pointer is set in gpiochip_hierarchy_setup_domain_ops(), called from
+ * gpiochip_hierarchy_add_domain(). See full stack sample below in testirq_init().
+ *
+ * This function is called indirectly by irq_create_fwspec_mapping() through
+ * irq_domain_alloc_irqs_locked().
+ *
+ * How to search for other examples:
+ *   grep -rn '\.alloc\>' drivers/gpio/
+ *   grep -rn '\<irq_domain_alloc_irqs_parent\>' drivers/irqchip/
+ */
+static int hier_alloc(struct irq_domain *irqd, unsigned int virq,
+		      unsigned int nr_irqs, void *data)
+{
+	struct irq_fwspec *fwspec = data;
+	struct irq_fwspec parent_fwspec = {
+		.fwnode = irqd->parent->fwnode,
+		.param_count = 1,
+	};
+	irq_hw_number_t hwirq;
+	unsigned int type;
+	int ret, i;
+
+	pr_info("[%s] virq = %u, nr_irqs = %u\n", irqd->name, virq, nr_irqs);
+
+	ret = irq_domain_translate_onecell(irqd, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr_irqs; i++) {
+		struct irq_data *d = irq_get_irq_data(virq + i);
+
+		pr_info("\tvirq = %u, data = %pS, parent = %pS\n",
+			virq + i, d, d->parent_data);
+		irq_domain_set_hwirq_and_chip(irqd, virq + i, hwirq + i,
+					      &hier_chip, NULL);
+	}
+
+	/*
+	 * We're not done yet, we still need to allocate interrupts in the
+	 * parent domain. If we just "return 0" at this point, the upstream
+	 * call to irq_create_fwspec_mapping() fails with -EINVAL.
+	 *
+	 * By now, the framework has already allocated a struct irq_data for
+	 * each virq, for both our domain (hier) and the parent domain (root).
+	 * So, irq_get_irq_data(virq) and irq_get_irq_data(virq)->parent_data
+	 * are both non-null. The problem is that parent_data->chip is NULL,
+	 * and this fails the sanity checks in irq_domain_trim_hierarchy()
+	 * (called from irq_domain_alloc_irqs_locked()).
+	 */
+
+	parent_fwspec.param[0] = hwirq;
+
+	return irq_domain_alloc_irqs_parent(irqd, virq, nr_irqs, &parent_fwspec);
+}
+
+/*
+ * For a GPIO IRQ chip, the .free and .translate methods may be overridden by
+ * the driver and defaults are provided in gpiochip_hierarchy_setup_domain_ops(),
+ * gpiochip_hierarchy_add_domain(). See full stack example below in testirq_init().
+ *
+ * In the drivers/pinctrl/qcom/pinctrl-spmi-gpio.c driver, the .translate method
+ * is overridden in pmic_gpio_probe(), by setting child_irq_domain_ops.translate.
+ */
+static const struct irq_domain_ops hier_ops = {
+	.alloc = hier_alloc,
+	.free = irq_domain_free_irqs_common,
+	.translate = irq_domain_translate_onecell,
+};
+
+/*
+ * This function is needed in case another IRQ handler is chained below this
+ * irq_chip. See the note above for root_eoi().
+ */
+static void imux_eoi(struct irq_data *data)
+{
+}
+
+static struct irq_chip imux_chip = {
+	.name = "TEST-IMUX-IC",
+	.irq_eoi = imux_eoi,
+};
+
+static int imux_map(struct irq_domain *irqd, unsigned int virq, irq_hw_number_t hwirq)
+{
+	pr_info("[%s] virq = %u, hwirq = %lu\n", irqd->name, virq, hwirq);
+	irq_set_chip_data(virq, irqd->host_data);
+	irq_set_chip_and_handler(virq, &imux_chip, handle_level_irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops imux_ops = {
+	.map = imux_map,
+	.xlate = irq_domain_xlate_onecell,
+};
+
+static void imux_irq_dispatch(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct irq_domain *domain;
+	unsigned int hwirq;
+
+	chained_irq_enter(chip, desc);
+
+	if (!imux_pending_hwirq) {
+		pr_err("imux spurious interrupt\n");
+		goto out;
+	}
+
+	domain = irq_desc_get_handler_data(desc);
+	for_each_set_bit(hwirq, &imux_pending_hwirq, NUM_MAPPED_IRQS_IMUX) {
+		generic_handle_domain_irq(domain, hwirq);
+		clear_bit(hwirq, &imux_pending_hwirq);
+	}
+
+out:
+	chained_irq_exit(chip, desc);
+}
+
+
+static irqreturn_t consum_hdlr(int irq, void *data)
+{
+	struct irq_data *d = irq_get_irq_data(irq);
+
+	pr_info("IRQ handler: virq %u (hwirq %lu on chip %s)\n",
+		d->irq, d->hwirq, d->chip->name);
+	return IRQ_HANDLED;
+}
+
+static long trigger_irq(void *arg)
+{
+	unsigned long hwirq = (unsigned long)arg;
+
+	pr_info("trigger hwirq %lu on cpu %u\n", hwirq, smp_processor_id());
+	generic_handle_domain_irq_safe(root_irqd, hwirq);
+
+	return 0;
+}
+
+static int trigger_set(const char *val, const struct kernel_param *kp)
+{
+	unsigned int virq, cpu;
+	struct irq_data *data;
+	const struct cpumask *mask;
+	int ret;
+
+	ret = kstrtouint(val, 0, &virq);
+	if (ret)
+		return ret;
+
+	data = irq_domain_get_irq_data(imux_irqd, virq);
+	if (data) {
+		set_bit(data->hwirq, &imux_pending_hwirq);
+		virq = imux_parent_irq;
+	}
+
+	data = irq_domain_get_irq_data(root_irqd, virq);
+	if (!data)
+		return -ENOENT;
+
+	mask = irq_get_effective_affinity_mask(virq);
+
+	/*
+	 * For hierarchical IRQs, the affinity is not configured implicitly
+	 * when the IRQ is set up. In that case, use the first online CPU.
+	 *
+	 * Note: The affinity is configured implicitly only via request_irq()
+	 *       when the IRQ is mapped in the root domain directly or via
+	 *       irq_set_chained_handler_and_data() for chained IRQs.
+	 */
+	if (cpumask_empty(mask)) {
+		pr_warn("effective affinity not set for virq %u\n", virq);
+		mask = cpu_online_mask;
+	}
+
+	cpus_read_lock();
+	cpu = cpumask_first_and(mask, cpu_online_mask);
+	if (cpu >= nr_cpu_ids)
+		pr_warn("no target CPU available for virq %u\n", virq);
+	else
+		work_on_cpu(cpu, trigger_irq, (void *)data->hwirq);
+	cpus_read_unlock();
+
+	return 0;
+}
+
+static const struct kernel_param_ops trigger_ops = { .set = trigger_set };
+
+
+/*
+ * Dummy fwnode structures for each IRQ chip. We need them for irq_create_fwspec_mapping()
+ * below, because otherwise it can't look up the IRQ domain.
+ *
+ * The function that looks up the IRQ domain by the fwspec is irq_find_matching_fwspec().
+ * As a last resort, it compares the pointers to struct fwnode_handle.
+ */
+static struct fwnode_handle *root_fwnode;
+static struct fwnode_handle *hier_fwnode;
+static struct fwnode_handle *imux_fwnode;
+
+static int __init testirq_init(void)
+{
+	struct irq_fwspec fwspec = {.param_count = 1};
+	unsigned int i, j;
+	int ret = -EINVAL;
+
+	root_fwnode = irq_domain_alloc_named_fwnode("testirq-root");
+	if (!root_fwnode) {
+		pr_err("irq_domain_alloc_named_fwnode(root) failed\n");
+		return ret;
+	}
+
+	root_irqd = irq_domain_create_linear(root_fwnode, NUM_TOTAL_IRQS_ROOT,
+					     &root_ops, NULL);
+	if (!root_irqd) {
+		pr_err("irq_domain_add_simple(root) failed\n");
+		goto out_free_root_fwnode;
+	}
+
+	hier_fwnode = irq_domain_alloc_named_fwnode("testirq-hier");
+	if (!hier_fwnode) {
+		pr_err("irq_domain_alloc_named_fwnode(hier) failed\n");
+		goto out_root_domain_remove;
+	}
+
+	/*
+	 * For a GPIO IRQ chip, the domain hierarchy is created like so:
+	 * pmic_gpio_probe			drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+	 * gpiochip_add_data			include/linux/gpio/driver.h
+	 * gpiochip_add_data_with_key		drivers/gpio/gpiolib.c
+	 * gpiochip_add_irqchip			drivers/gpio/gpiolib.c
+	 * gpiochip_hierarchy_add_domain	drivers/gpio/gpiolib.c
+	 * irq_domain_create_hierarchy		kernel/irq/irqdomain.c
+	 */
+	hier_irqd = irq_domain_create_hierarchy(root_irqd, 0, NUM_TOTAL_IRQS_HIER,
+						hier_fwnode, &hier_ops, NULL);
+	if (!hier_irqd) {
+		pr_err("irq_domain_create_hierarchy(hier) failed\n");
+		goto out_free_hier_fwnode;
+	}
+
+	/*
+	 * Create an IRQ mapping in the parent (root) domain. Hierarchy domain
+	 * IRQs are mapped 1:1 in each domain along the chain. For that reason,
+	 * the first NUM_MAPPED_IRQS_HIER hwirqs in the root domain are used by
+	 * hierarchy IRQs, and the first available is NUM_MAPPED_IRQS_HIER.
+	 */
+	fwspec.fwnode = root_fwnode;
+	fwspec.param[0] = NUM_MAPPED_IRQS_HIER;
+	imux_parent_irq = irq_create_fwspec_mapping(&fwspec);
+	if (!imux_parent_irq) {
+		pr_err("irq_create_mapping(root) failed\n");
+		goto out_hier_domain_remove;
+	}
+
+	imux_fwnode = irq_domain_alloc_named_fwnode("testirq-imux");
+	if (!imux_fwnode) {
+		pr_err("irq_domain_alloc_named_fwnode(imux) failed\n");
+		goto out_remove_imux_mapping;
+	}
+
+	imux_irqd = irq_domain_create_linear(imux_fwnode, NUM_TOTAL_IRQS_IMUX,
+					     &imux_ops, NULL);
+	if (!imux_irqd) {
+		pr_err("irq_domain_add_simple(imux) failed\n");
+		goto out_free_imux_fwnode;
+	}
+
+	irq_set_chained_handler_and_data(imux_parent_irq, imux_irq_dispatch, imux_irqd);
+
+	/*
+	 * From this point on, this is what a consumer of the GPIO chip would do
+	 * to set up an IRQ through the GPIO chip. If the GPIO chip doesn't
+	 * provide irqchip support, a consumer can still call gpiod_to_irq(),
+	 * which in turn calls (struct gpio_chip).to_irq(). By default, this is
+	 * set to gpiochip_to_irq() (in gpiochip_add_irqchip()).
+	 *
+	 * In gpiochip_to_irq(), either irq_create_fwspec_mapping() is called if
+	 * the IRQ domain is hierarchical, or irq_create_mapping() otherwise.
+	 *
+	 * When the GPIO chip provides irqchip support, the IRQ is mapped in the
+	 * device tree, and the consumer can call irq_create_of_mapping().
+	 * Internally, this still ends up calling irq_create_fwspec_mapping().
+	 */
+	for (i = 0; i < NUM_MAPPED_IRQS; i++) {
+		if (i < NUM_MAPPED_IRQS_HIER) {
+			/* map this IRQ to the "hier" chip */
+			fwspec.fwnode = hier_fwnode;
+			fwspec.param[0] = i; // HW IRQ# at the leaf level
+		} else {
+			/* map this IRQ to the "imux" chip */
+			fwspec.fwnode = imux_fwnode;
+			fwspec.param[0] = i - NUM_MAPPED_IRQS_HIER;
+		};
+
+		mapped_virq[i] = irq_create_fwspec_mapping(&fwspec);
+		if (!mapped_virq[i]) {
+			pr_err("irq_create_mapping(hier, %u) failed\n", i);
+			goto out_dispose_and_free;
+		}
+
+		pr_info("mapped consumer virq %d\n", mapped_virq[i]);
+
+		/*
+		 * Don't use the IRQF_SHARED flag because it would trigger a
+		 * dummy call of the IRQ handler when the module is unloaded
+		 * in case CONFIG_DEBUG_SHIRQ is enabled, via free_irq() ->
+		 * __free_irq() -> action->handler().
+		 */
+		ret = request_irq(mapped_virq[i], consum_hdlr, 0, "test", &dummydev[i]);
+		if (ret < 0) {
+			pr_err("request_irq(%d) failed\n", mapped_virq[i]);
+			irq_dispose_mapping(mapped_virq[i]);
+			goto out_dispose_and_free;
+		}
+
+		pr_info("registered consumer virq %d\n", mapped_virq[i]);
+	}
+
+	return 0;
+
+out_dispose_and_free:
+	/*
+	 * The IRQ mapping must be removed explicitly. This is NOT done by
+	 * irq_domain_remove() automatically and that's documented in the
+	 * function comment block.
+	 */
+	for (j = 0; j < i; j++) {
+		irq_dispose_mapping(mapped_virq[j]);
+		free_irq(mapped_virq[j], &dummydev[j]);
+	}
+	irq_domain_remove(imux_irqd);
+out_free_imux_fwnode:
+	irq_domain_free_fwnode(imux_fwnode);
+out_remove_imux_mapping:
+	irq_dispose_mapping(imux_parent_irq);
+out_hier_domain_remove:
+	irq_domain_remove(hier_irqd);
+out_free_hier_fwnode:
+	irq_domain_free_fwnode(hier_fwnode);
+out_root_domain_remove:
+	irq_domain_remove(root_irqd);
+out_free_root_fwnode:
+	irq_domain_free_fwnode(root_fwnode);
+	return ret;
+}
+
+static void __exit testirq_exit(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < NUM_MAPPED_IRQS; i++) {
+		free_irq(mapped_virq[i], &dummydev[i]);
+		irq_dispose_mapping(mapped_virq[i]);
+	}
+	irq_domain_remove(imux_irqd);
+	irq_domain_free_fwnode(imux_fwnode);
+	irq_dispose_mapping(imux_parent_irq);
+	irq_domain_remove(hier_irqd);
+	irq_domain_free_fwnode(hier_fwnode);
+	irq_domain_remove(root_irqd);
+	irq_domain_free_fwnode(root_fwnode);
+}
+
+module_param_cb(trigger, &trigger_ops, NULL, 0440);
+MODULE_PARM_DESC(trigger, "Manually trigger the corresponding virq");
+
+module_init(testirq_init);
+module_exit(testirq_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Radu Rendec <rrendec@redhat.com>");
+MODULE_DESCRIPTION("IRQ chip driver sandbox");
-- 
2.51.0



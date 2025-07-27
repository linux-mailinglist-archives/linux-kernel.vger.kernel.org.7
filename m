Return-Path: <linux-kernel+bounces-747306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2422B13243
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 00:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 070D11893DB5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 22:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8215A24DD1E;
	Sun, 27 Jul 2025 22:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TI5THpaT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vB4IEgYm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6207313790B
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 22:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753655876; cv=none; b=GV8CuhNwlo+spQ/xkgqXYBhuQcWKcM2SgOKwh2kBxm08o4fxc4ciHeznfs3+jg6oB1G3tQLdxD93R+8F+tOnUS5/F8EJmyCvOPqtU2Rj9js82y5ZGoFtneR75meuBv7pANaCfxvLw3CYLdKIKK/VeyuLsSpnTvYfsLH5O6YLrr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753655876; c=relaxed/simple;
	bh=3Btw47NAVwHOvt4PTvNmse+4oujsUx6DQ+bxjsY0bwA=;
	h=From:To:Cc:Subject:Message-ID:Content-Type:MIME-Version:Date; b=PR4+Ul5OGTvwcXecZp6JdiG5L2c17jPIrOjHt6DB4822er/33TV6zdBvmQrsol9bWGYJUv4iqHnZoPtnCySeJIFriqPz0vZlZVoaQxKKmTriM0Hvmah4mYkqERuZ+cLXUvMDgYDP3DWtXNmTXpiuSnMQ21kURe15RVxOdo7Qt9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TI5THpaT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vB4IEgYm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753655871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VkSrNW9/DNDuLo5aEtvqnQQNh/z6f1agzNbIwunaaU4=;
	b=TI5THpaTfRDeTjdQwczLmtLwccvL/EfulojAmts1mD1f3OF4W4vjsqKsr7YoNnOSYbKMBd
	afl2ssvbuhFmfnPvghtfMK8jf1B7VWkn4srrz4kI8lBRBK7vOqI5fPhkU9n9bhNBVLhAw9
	j2uYRt8+YQvtZ9CsNy4OfY8G/EYrvelupVVXLHPJqFp1GRq2vAmx9lcO9EeLE/Zs5PseDN
	mOkxqmXpvxvy7pNYYlL0iLrOHIhm7slFhKdrC3E4iQ53jyh1hs8PRP21jcS5Nryoj/7X5Y
	ZhJoMpnfanTt3dBVcjTQSDbv8HkbN6dPPw2OhVbjjS/iPMOWO3NF/weIDUQm+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753655871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VkSrNW9/DNDuLo5aEtvqnQQNh/z6f1agzNbIwunaaU4=;
	b=vB4IEgYmzKpVEcLbdOL5L6oMjRPP/dudrmkOHoBLeXsI3K9rAYBScD2hTrTa66XZo09YYm
	cE89K7va7dynbYBw==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/core for v6.17-rc1
Message-ID: <175365567943.581055.6806236199247802443.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Jul 2025 00:37:50 +0200 (CEST)

Linus,

please pull the latest irq/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2025-07=
-27

up to:  8d39d6ec4db5: genirq: Prevent migration live lock in handle_edge_irq()

Updates for the interrupt core subsystem:

  - Prevent a interrupt migration related live lock in handle_edge_irq()

    If the interrupt affinity is moved to a new target CPU and the
    interrupt is currently handled on the previous target CPU for edge type
    interrupts the handler might get stuck on the previous target for a
    long time, which causes both involved CPUs to waste cycles and
    eventually run into a soft-lockup situation.

    Solve this by checking whether the interrupt is redirected to a new
    target CPU and if the interrupt is handled on that new target CPU, busy
    wait for completion instead of masking it and sending the pending but
    which would cause the old CPU to re-run the handler and in the worst
    case repeating this excercise for a long time.

    This only works on architectures which use single CPU interrupt
    targets, but that's so far the only ones where this behaviour has been
    observed.

  - Add a kunit test for interrupt disable depth counts

    The nested interrupt disable depth has been an issue in the past
    especially vs. free_irq(), interrupt shutdown and CPU hotplug and their
    interactions. The test exercises the combinations of these scenarios
    and checks for correctness.

Thanks,

	tglx

------------------>
Brian Norris (1):
      genirq: Add kunit tests for depth counts

Thomas Gleixner (4):
      genirq: Remove pointless local variable
      genirq: Move irq_wait_for_poll() to call site
      genirq: Split up irq_pm_check_wakeup()
      genirq: Prevent migration live lock in handle_edge_irq()


 kernel/irq/Kconfig     |  11 +++
 kernel/irq/Makefile    |   1 +
 kernel/irq/chip.c      |  72 +++++++++++++---
 kernel/irq/internals.h |   6 +-
 kernel/irq/irq_test.c  | 229 +++++++++++++++++++++++++++++++++++++++++++++++=
++
 kernel/irq/pm.c        |  16 ++--
 kernel/irq/spurious.c  |  37 +-------
 7 files changed, 313 insertions(+), 59 deletions(-)
 create mode 100644 kernel/irq/irq_test.c

diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 3f02a0e45254..1da5e9d9da71 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -144,6 +144,17 @@ config GENERIC_IRQ_DEBUGFS
 config GENERIC_IRQ_KEXEC_CLEAR_VM_FORWARD
 	bool
=20
+config IRQ_KUNIT_TEST
+	bool "KUnit tests for IRQ management APIs" if !KUNIT_ALL_TESTS
+	depends on KUNIT=3Dy
+	default KUNIT_ALL_TESTS
+	imply SMP
+	help
+	  This option enables KUnit tests for the IRQ subsystem API. These are
+	  only for development and testing, not for regular kernel use cases.
+
+	  If unsure, say N.
+
 endmenu
=20
 config GENERIC_IRQ_MULTI_HANDLER
diff --git a/kernel/irq/Makefile b/kernel/irq/Makefile
index c0f44c06d69d..6ab3a4055667 100644
--- a/kernel/irq/Makefile
+++ b/kernel/irq/Makefile
@@ -19,3 +19,4 @@ obj-$(CONFIG_GENERIC_IRQ_IPI_MUX) +=3D ipi-mux.o
 obj-$(CONFIG_SMP) +=3D affinity.o
 obj-$(CONFIG_GENERIC_IRQ_DEBUGFS) +=3D debugfs.o
 obj-$(CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR) +=3D matrix.o
+obj-$(CONFIG_IRQ_KUNIT_TEST) +=3D irq_test.o
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 2b274007e8ba..624106e886ad 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -457,22 +457,33 @@ void unmask_threaded_irq(struct irq_desc *desc)
 	unmask_irq(desc);
 }
=20
-static bool irq_check_poll(struct irq_desc *desc)
-{
-	if (!(desc->istate & IRQS_POLL_INPROGRESS))
-		return false;
-	return irq_wait_for_poll(desc);
+/* Busy wait until INPROGRESS is cleared */
+static bool irq_wait_on_inprogress(struct irq_desc *desc)
+{
+	if (IS_ENABLED(CONFIG_SMP)) {
+		do {
+			raw_spin_unlock(&desc->lock);
+			while (irqd_irq_inprogress(&desc->irq_data))
+				cpu_relax();
+			raw_spin_lock(&desc->lock);
+		} while (irqd_irq_inprogress(&desc->irq_data));
+
+		/* Might have been disabled in meantime */
+		return !irqd_irq_disabled(&desc->irq_data) && desc->action;
+	}
+	return false;
 }
=20
 static bool irq_can_handle_pm(struct irq_desc *desc)
 {
-	unsigned int mask =3D IRQD_IRQ_INPROGRESS | IRQD_WAKEUP_ARMED;
+	struct irq_data *irqd =3D &desc->irq_data;
+	const struct cpumask *aff;
=20
 	/*
 	 * If the interrupt is not in progress and is not an armed
 	 * wakeup interrupt, proceed.
 	 */
-	if (!irqd_has_set(&desc->irq_data, mask))
+	if (!irqd_has_set(irqd, IRQD_IRQ_INPROGRESS | IRQD_WAKEUP_ARMED))
 		return true;
=20
 	/*
@@ -480,13 +491,54 @@ static bool irq_can_handle_pm(struct irq_desc *desc)
 	 * and suspended, disable it and notify the pm core about the
 	 * event.
 	 */
-	if (irq_pm_check_wakeup(desc))
+	if (unlikely(irqd_has_set(irqd, IRQD_WAKEUP_ARMED))) {
+		irq_pm_handle_wakeup(desc);
+		return false;
+	}
+
+	/* Check whether the interrupt is polled on another CPU */
+	if (unlikely(desc->istate & IRQS_POLL_INPROGRESS)) {
+		if (WARN_ONCE(irq_poll_cpu =3D=3D smp_processor_id(),
+			      "irq poll in progress on cpu %d for irq %d\n",
+			      smp_processor_id(), desc->irq_data.irq))
+			return false;
+		return irq_wait_on_inprogress(desc);
+	}
+
+	/* The below works only for single target interrupts */
+	if (!IS_ENABLED(CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK) ||
+	    !irqd_is_single_target(irqd) || desc->handle_irq !=3D handle_edge_irq)
 		return false;
=20
 	/*
-	 * Handle a potential concurrent poll on a different core.
+	 * If the interrupt affinity was moved to this CPU and the
+	 * interrupt is currently handled on the previous target CPU, then
+	 * busy wait for INPROGRESS to be cleared. Otherwise for edge type
+	 * interrupts the handler might get stuck on the previous target:
+	 *
+	 * CPU 0			CPU 1 (new target)
+	 * handle_edge_irq()
+	 * repeat:
+	 *	handle_event()		handle_edge_irq()
+	 *			        if (INPROGESS) {
+	 *				  set(PENDING);
+	 *				  mask();
+	 *				  return;
+	 *				}
+	 *	if (PENDING) {
+	 *	  clear(PENDING);
+	 *	  unmask();
+	 *	  goto repeat;
+	 *	}
+	 *
+	 * This happens when the device raises interrupts with a high rate
+	 * and always before handle_event() completes and the CPU0 handler
+	 * can clear INPROGRESS. This has been observed in virtual machines.
 	 */
-	return irq_check_poll(desc);
+	aff =3D irq_data_get_effective_affinity_mask(irqd);
+	if (cpumask_first(aff) !=3D smp_processor_id())
+		return false;
+	return irq_wait_on_inprogress(desc);
 }
=20
 static inline bool irq_can_handle_actions(struct irq_desc *desc)
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index aebfe225c9a6..0164ca48da59 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -20,6 +20,7 @@
 #define istate core_internal_state__do_not_mess_with_it
=20
 extern bool noirqdebug;
+extern int irq_poll_cpu;
=20
 extern struct irqaction chained_action;
=20
@@ -112,7 +113,6 @@ irqreturn_t handle_irq_event(struct irq_desc *desc);
 int check_irq_resend(struct irq_desc *desc, bool inject);
 void clear_irq_resend(struct irq_desc *desc);
 void irq_resend_init(struct irq_desc *desc);
-bool irq_wait_for_poll(struct irq_desc *desc);
 void __irq_wake_thread(struct irq_desc *desc, struct irqaction *action);
=20
 void wake_threads_waitq(struct irq_desc *desc);
@@ -277,11 +277,11 @@ static inline bool irq_is_nmi(struct irq_desc *desc)
 }
=20
 #ifdef CONFIG_PM_SLEEP
-bool irq_pm_check_wakeup(struct irq_desc *desc);
+void irq_pm_handle_wakeup(struct irq_desc *desc);
 void irq_pm_install_action(struct irq_desc *desc, struct irqaction *action);
 void irq_pm_remove_action(struct irq_desc *desc, struct irqaction *action);
 #else
-static inline bool irq_pm_check_wakeup(struct irq_desc *desc) { return false=
; }
+static inline void irq_pm_handle_wakeup(struct irq_desc *desc) { }
 static inline void
 irq_pm_install_action(struct irq_desc *desc, struct irqaction *action) { }
 static inline void
diff --git a/kernel/irq/irq_test.c b/kernel/irq/irq_test.c
new file mode 100644
index 000000000000..5161b56a12f9
--- /dev/null
+++ b/kernel/irq/irq_test.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: LGPL-2.1+
+
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
+#include <linux/irqdomain.h>
+#include <linux/nodemask.h>
+#include <kunit/test.h>
+
+#include "internals.h"
+
+static irqreturn_t noop_handler(int irq, void *data)
+{
+	return IRQ_HANDLED;
+}
+
+static void noop(struct irq_data *data) { }
+static unsigned int noop_ret(struct irq_data *data) { return 0; }
+
+static int noop_affinity(struct irq_data *data, const struct cpumask *dest,
+			 bool force)
+{
+	irq_data_update_effective_affinity(data, dest);
+
+	return 0;
+}
+
+static struct irq_chip fake_irq_chip =3D {
+	.name           =3D "fake",
+	.irq_startup    =3D noop_ret,
+	.irq_shutdown   =3D noop,
+	.irq_enable     =3D noop,
+	.irq_disable    =3D noop,
+	.irq_ack        =3D noop,
+	.irq_mask       =3D noop,
+	.irq_unmask     =3D noop,
+	.irq_set_affinity =3D noop_affinity,
+	.flags          =3D IRQCHIP_SKIP_SET_WAKE,
+};
+
+static void irq_disable_depth_test(struct kunit *test)
+{
+	struct irq_desc *desc;
+	int virq, ret;
+
+	virq =3D irq_domain_alloc_descs(-1, 1, 0, NUMA_NO_NODE, NULL);
+	KUNIT_ASSERT_GE(test, virq, 0);
+
+	irq_set_chip_and_handler(virq, &dummy_irq_chip, handle_simple_irq);
+
+	desc =3D irq_to_desc(virq);
+	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
+
+	ret =3D request_irq(virq, noop_handler, 0, "test_irq", NULL);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, desc->depth, 0);
+
+	disable_irq(virq);
+	KUNIT_EXPECT_EQ(test, desc->depth, 1);
+
+	enable_irq(virq);
+	KUNIT_EXPECT_EQ(test, desc->depth, 0);
+
+	free_irq(virq, NULL);
+}
+
+static void irq_free_disabled_test(struct kunit *test)
+{
+	struct irq_desc *desc;
+	int virq, ret;
+
+	virq =3D irq_domain_alloc_descs(-1, 1, 0, NUMA_NO_NODE, NULL);
+	KUNIT_ASSERT_GE(test, virq, 0);
+
+	irq_set_chip_and_handler(virq, &dummy_irq_chip, handle_simple_irq);
+
+	desc =3D irq_to_desc(virq);
+	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
+
+	ret =3D request_irq(virq, noop_handler, 0, "test_irq", NULL);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, desc->depth, 0);
+
+	disable_irq(virq);
+	KUNIT_EXPECT_EQ(test, desc->depth, 1);
+
+	free_irq(virq, NULL);
+	KUNIT_EXPECT_GE(test, desc->depth, 1);
+
+	ret =3D request_irq(virq, noop_handler, 0, "test_irq", NULL);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, desc->depth, 0);
+
+	free_irq(virq, NULL);
+}
+
+static void irq_shutdown_depth_test(struct kunit *test)
+{
+	struct irq_desc *desc;
+	struct irq_data *data;
+	int virq, ret;
+	struct irq_affinity_desc affinity =3D {
+		.is_managed =3D 1,
+		.mask =3D CPU_MASK_ALL,
+	};
+
+	if (!IS_ENABLED(CONFIG_SMP))
+		kunit_skip(test, "requires CONFIG_SMP for managed shutdown");
+
+	virq =3D irq_domain_alloc_descs(-1, 1, 0, NUMA_NO_NODE, &affinity);
+	KUNIT_ASSERT_GE(test, virq, 0);
+
+	irq_set_chip_and_handler(virq, &dummy_irq_chip, handle_simple_irq);
+
+	desc =3D irq_to_desc(virq);
+	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
+
+	data =3D irq_desc_get_irq_data(desc);
+	KUNIT_ASSERT_PTR_NE(test, data, NULL);
+
+	ret =3D request_irq(virq, noop_handler, 0, "test_irq", NULL);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_TRUE(test, irqd_is_activated(data));
+	KUNIT_EXPECT_TRUE(test, irqd_is_started(data));
+	KUNIT_EXPECT_TRUE(test, irqd_affinity_is_managed(data));
+
+	KUNIT_EXPECT_EQ(test, desc->depth, 0);
+
+	disable_irq(virq);
+	KUNIT_EXPECT_EQ(test, desc->depth, 1);
+
+	irq_shutdown_and_deactivate(desc);
+
+	KUNIT_EXPECT_FALSE(test, irqd_is_activated(data));
+	KUNIT_EXPECT_FALSE(test, irqd_is_started(data));
+
+	KUNIT_EXPECT_EQ(test, irq_activate(desc), 0);
+#ifdef CONFIG_SMP
+	irq_startup_managed(desc);
+#endif
+
+	KUNIT_EXPECT_EQ(test, desc->depth, 1);
+
+	enable_irq(virq);
+	KUNIT_EXPECT_EQ(test, desc->depth, 0);
+
+	free_irq(virq, NULL);
+}
+
+static void irq_cpuhotplug_test(struct kunit *test)
+{
+	struct irq_desc *desc;
+	struct irq_data *data;
+	int virq, ret;
+	struct irq_affinity_desc affinity =3D {
+		.is_managed =3D 1,
+	};
+
+	if (!IS_ENABLED(CONFIG_SMP))
+		kunit_skip(test, "requires CONFIG_SMP for CPU hotplug");
+	if (!get_cpu_device(1))
+		kunit_skip(test, "requires more than 1 CPU for CPU hotplug");
+	if (!cpu_is_hotpluggable(1))
+		kunit_skip(test, "CPU 1 must be hotpluggable");
+
+	cpumask_copy(&affinity.mask, cpumask_of(1));
+
+	virq =3D irq_domain_alloc_descs(-1, 1, 0, NUMA_NO_NODE, &affinity);
+	KUNIT_ASSERT_GE(test, virq, 0);
+
+	irq_set_chip_and_handler(virq, &fake_irq_chip, handle_simple_irq);
+
+	desc =3D irq_to_desc(virq);
+	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
+
+	data =3D irq_desc_get_irq_data(desc);
+	KUNIT_ASSERT_PTR_NE(test, data, NULL);
+
+	ret =3D request_irq(virq, noop_handler, 0, "test_irq", NULL);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_TRUE(test, irqd_is_activated(data));
+	KUNIT_EXPECT_TRUE(test, irqd_is_started(data));
+	KUNIT_EXPECT_TRUE(test, irqd_affinity_is_managed(data));
+
+	KUNIT_EXPECT_EQ(test, desc->depth, 0);
+
+	disable_irq(virq);
+	KUNIT_EXPECT_EQ(test, desc->depth, 1);
+
+	KUNIT_EXPECT_EQ(test, remove_cpu(1), 0);
+	KUNIT_EXPECT_FALSE(test, irqd_is_activated(data));
+	KUNIT_EXPECT_FALSE(test, irqd_is_started(data));
+	KUNIT_EXPECT_GE(test, desc->depth, 1);
+	KUNIT_EXPECT_EQ(test, add_cpu(1), 0);
+
+	KUNIT_EXPECT_FALSE(test, irqd_is_activated(data));
+	KUNIT_EXPECT_FALSE(test, irqd_is_started(data));
+	KUNIT_EXPECT_EQ(test, desc->depth, 1);
+
+	enable_irq(virq);
+	KUNIT_EXPECT_TRUE(test, irqd_is_activated(data));
+	KUNIT_EXPECT_TRUE(test, irqd_is_started(data));
+	KUNIT_EXPECT_EQ(test, desc->depth, 0);
+
+	free_irq(virq, NULL);
+}
+
+static struct kunit_case irq_test_cases[] =3D {
+	KUNIT_CASE(irq_disable_depth_test),
+	KUNIT_CASE(irq_free_disabled_test),
+	KUNIT_CASE(irq_shutdown_depth_test),
+	KUNIT_CASE(irq_cpuhotplug_test),
+	{}
+};
+
+static struct kunit_suite irq_test_suite =3D {
+	.name =3D "irq_test_cases",
+	.test_cases =3D irq_test_cases,
+};
+
+kunit_test_suite(irq_test_suite);
+MODULE_DESCRIPTION("IRQ unit test suite");
+MODULE_LICENSE("GPL");
diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
index 445912d51033..f7394729cedc 100644
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -13,17 +13,13 @@
=20
 #include "internals.h"
=20
-bool irq_pm_check_wakeup(struct irq_desc *desc)
+void irq_pm_handle_wakeup(struct irq_desc *desc)
 {
-	if (irqd_is_wakeup_armed(&desc->irq_data)) {
-		irqd_clear(&desc->irq_data, IRQD_WAKEUP_ARMED);
-		desc->istate |=3D IRQS_SUSPENDED | IRQS_PENDING;
-		desc->depth++;
-		irq_disable(desc);
-		pm_system_irq_wakeup(irq_desc_get_irq(desc));
-		return true;
-	}
-	return false;
+	irqd_clear(&desc->irq_data, IRQD_WAKEUP_ARMED);
+	desc->istate |=3D IRQS_SUSPENDED | IRQS_PENDING;
+	desc->depth++;
+	irq_disable(desc);
+	pm_system_irq_wakeup(irq_desc_get_irq(desc));
 }
=20
 /*
diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
index 8f26982e7300..73280ccb74b0 100644
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -19,44 +19,9 @@ static int irqfixup __read_mostly;
 #define POLL_SPURIOUS_IRQ_INTERVAL (HZ/10)
 static void poll_spurious_irqs(struct timer_list *unused);
 static DEFINE_TIMER(poll_spurious_irq_timer, poll_spurious_irqs);
-static int irq_poll_cpu;
+int irq_poll_cpu;
 static atomic_t irq_poll_active;
=20
-/*
- * We wait here for a poller to finish.
- *
- * If the poll runs on this CPU, then we yell loudly and return
- * false. That will leave the interrupt line disabled in the worst
- * case, but it should never happen.
- *
- * We wait until the poller is done and then recheck disabled and
- * action (about to be disabled). Only if it's still active, we return
- * true and let the handler run.
- */
-bool irq_wait_for_poll(struct irq_desc *desc)
-{
-	lockdep_assert_held(&desc->lock);
-
-	if (WARN_ONCE(irq_poll_cpu =3D=3D smp_processor_id(),
-		      "irq poll in progress on cpu %d for irq %d\n",
-		      smp_processor_id(), desc->irq_data.irq))
-		return false;
-
-#ifdef CONFIG_SMP
-	do {
-		raw_spin_unlock(&desc->lock);
-		while (irqd_irq_inprogress(&desc->irq_data))
-			cpu_relax();
-		raw_spin_lock(&desc->lock);
-	} while (irqd_irq_inprogress(&desc->irq_data));
-	/* Might have been disabled in meantime */
-	return !irqd_irq_disabled(&desc->irq_data) && desc->action;
-#else
-	return false;
-#endif
-}
-
-
 /*
  * Recovery handler for misrouted interrupts.
  */



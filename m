Return-Path: <linux-kernel+bounces-836055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEE2BA8A44
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F28B57B4A3D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BB62C21FC;
	Mon, 29 Sep 2025 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oHZfak37";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wekJu7sI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB1528DB52
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138150; cv=none; b=cylIp4Uf9DiGvUksx4cJPtePwgZIWuV8vSICmk6PATBOWmLLpC6X6pKBtP4OQ9GEzWrWYxnsDnvteWJxRsA0VAQXjTMEmWWgTnGdLjBuOBlQcPSJtSdKszI/UWElncZWowKH0Ej0qdHFSp9FTSahheaUA5RQxL6kn22Zve0JxEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138150; c=relaxed/simple;
	bh=voDudYjvS3BUO7llitnvKwNJxOw+9yY9iTuk5ql5yXk=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=LMRWYR4vvft0uxb1+pfqzr4CUMmzyLYjWfnuJjnAMJvB8LVj9/8MOobXA5DL2BjxsoFxyZNxhJjTSKwNVdg6Eww6LqxDoJN/XGfeSgJLUwYagjnsaA6z3wYgVREp8dLsKweDbueO2wtaIsw+Pt4V8mdVgkThkBMxM6O3mzO+H7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oHZfak37; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wekJu7sI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759138139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=WJe+vUmFqfyqN54wLWZYs0t55MvlBKbYnUeH5aLz7aY=;
	b=oHZfak37hEFMMTaTdtyxoQZVyHKl8gmo7Y07eB2gMeKtLd5dU2/b4EMY3PaT2NABnR1mxO
	XKJGqB3V4ZhRDiGHAWCzFKg5Lo7siRnLuGRHZEQfnxb5ab1H7gibfM8CrwfyGkdDh2DXrG
	EkiSC1aAgkjG3pwkHuXZmvXwvk3U9pKs3o9zT2/C+KSMx7jpeyttTEZJeVP7U7X+uWOS9w
	fx8miILn7yElZJ+VSpWPC6mCdD4kbSronDyrQpipUwUj4aRX8tFMXlZzXwS6kpGtp7hnOF
	nZ9FG1QBvsJMrKOqh2le2TI6Mgr8KS7gjgy5/2VQTK6dfvTjDzKLox2T6qPilA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759138139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=WJe+vUmFqfyqN54wLWZYs0t55MvlBKbYnUeH5aLz7aY=;
	b=wekJu7sI0c9uTGrHJGg3vog53PtwhX7FbnK7PQFl6arzxkFpJ/I82uipVw8IKhgR0mDkB+
	vREb+p003cl35YBQ==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/core for v6.18-rc1
References: <175913807599.495041.10251515322736195577.tglx@xen13>
Message-ID: <175913807957.495041.15537657456860100631.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 29 Sep 2025 11:28:58 +0200 (CEST)

Linus,

please pull the latest irq/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2025-09=
-29

up to:  3253cb49cbad: softirq: Allow to drop the softirq-BKL lock on PREEMPT_=
RT

A set of updates for the interrupt core subsystem:

  - Introduce irq_chip_[startup|shutdown]_parent() to prepare for
    addressing a few short comings in the PCI/MSI interrupt subsystem.

    It allows to utilize the interrupt chip startup/shutdown callbacks for
    initializing the interrupt chip hierarchy properly on certain RISCV
    implementations and provides a mechanism to reduce the overhead of
    masking and unmasking PCI/MSI interrupts during operation when the
    underlying MSI provider can mask the interrupt.

    The actual usage comes with the interrupt driver pull request.

  - Add generic error handling for devm_request_*_irq()

    This allows to remove the zoo of random error printk's all over the
    usage sites.

  - Add a mechanism to warn about long-running interrupt handlers

    Long running interrupt handlers can introduce latencies and tracking
    them down is a tedious task. The tracking has to be enabled with a
    threshold on the kernel command line and utilizes a static branch to
    remove the overhead when disabled.

  - Update and extend the selftests which validate the CPU hotplug
    interrupt migration logic

  - Allow dropping the per CPU softirq lock on PREEMPT_RT kernels, which
    causes contention and latencies all over the place.

    The serialization requirements have been pushed down into the actual
    affected usage sites already.

  - The usual small cleanups and improvements

Thanks,

	tglx

------------------>
Brian Norris (6):
      genirq/test: Select IRQ_DOMAIN
      genirq/test: Factor out fake-virq setup
      genirq/test: Fail early if interrupt request fails
      genirq/test: Depend on SPARSE_IRQ
      genirq/test: Drop CONFIG_GENERIC_IRQ_MIGRATION assumptions
      genirq/test: Ensure CPU 1 is online for hotplug test

David Gow (1):
      genirq/test: Fix depth tests on architectures with NOREQUEST by default.

Inochi Amaoto (1):
      genirq: Add irq_chip_(startup/shutdown)_parent()

Pan Chuang (1):
      genirq/devres: Add error handling in devm_request_*_irq()

Sebastian Andrzej Siewior (3):
      genirq: Remove GENERIC_IRQ_LEGACY
      softirq: Provide a handshake for canceling tasklets via polling
      softirq: Allow to drop the softirq-BKL lock on PREEMPT_RT

Wladislav Wiebe (1):
      genirq: Add support for warning on long-running interrupt handlers


 Documentation/admin-guide/kernel-parameters.txt |   5 +
 include/linux/irq.h                             |   6 +-
 kernel/Kconfig.preempt                          |  13 +++
 kernel/irq/Kconfig                              |   6 +-
 kernel/irq/chip.c                               |  37 ++++++
 kernel/irq/devres.c                             | 127 ++++++++++++++-------
 kernel/irq/handle.c                             |  49 +++++++-
 kernel/irq/irq_test.c                           |  55 +++++----
 kernel/irq/irqdesc.c                            |   7 --
 kernel/softirq.c                                | 145 ++++++++++++++++++++--=
--
 10 files changed, 344 insertions(+), 106 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/=
admin-guide/kernel-parameters.txt
index 747a55abf494..bdbc44f52e4a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2606,6 +2606,11 @@
 			for it. Intended to get systems with badly broken
 			firmware running.
=20
+	irqhandler.duration_warn_us=3D [KNL]
+			Warn if an IRQ handler exceeds the specified duration
+			threshold in microseconds. Useful for identifying
+			long-running IRQs in the system.
+
 	irqpoll		[HW]
 			When an interrupt is not handled search all handlers
 			for it. Also check all handlers each timer
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
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 54ea59ff8fbe..da326800c1c9 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -103,6 +103,19 @@ config PREEMPT_RT
 	  Select this if you are building a kernel for systems which
 	  require real-time guarantees.
=20
+config PREEMPT_RT_NEEDS_BH_LOCK
+	bool "Enforce softirq synchronisation on PREEMPT_RT"
+	depends on PREEMPT_RT
+	help
+	  Enforce synchronisation across the softirqs context. On PREEMPT_RT
+	  the softirq is preemptible. This enforces the same per-CPU BLK
+	  semantic non-PREEMPT_RT builds have. This should not be needed
+	  because per-CPU locks were added to avoid the per-CPU BKL.
+
+	  This switch provides the old behaviour for testing reasons. Select
+	  this if you suspect an error with preemptible softirq and want test
+	  the old synchronized behaviour.
+
 config PREEMPT_COUNT
        bool
=20
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 1da5e9d9da71..1b4254d19a73 100644
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
@@ -147,7 +143,9 @@ config GENERIC_IRQ_KEXEC_CLEAR_VM_FORWARD
 config IRQ_KUNIT_TEST
 	bool "KUnit tests for IRQ management APIs" if !KUNIT_ALL_TESTS
 	depends on KUNIT=3Dy
+	depends on SPARSE_IRQ
 	default KUNIT_ALL_TESTS
+	select IRQ_DOMAIN
 	imply SMP
 	help
 	  This option enables KUnit tests for the IRQ subsystem API. These are
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
diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
index eb16a58e0322..b41188698622 100644
--- a/kernel/irq/devres.c
+++ b/kernel/irq/devres.c
@@ -30,29 +30,22 @@ static int devm_irq_match(struct device *dev, void *res, =
void *data)
 	return this->irq =3D=3D match->irq && this->dev_id =3D=3D match->dev_id;
 }
=20
-/**
- *	devm_request_threaded_irq - allocate an interrupt line for a managed devi=
ce
- *	@dev: device to request interrupt for
- *	@irq: Interrupt line to allocate
- *	@handler: Function to be called when the IRQ occurs
- *	@thread_fn: function to be called in a threaded interrupt context. NULL
- *		    for devices which handle everything in @handler
- *	@irqflags: Interrupt type flags
- *	@devname: An ascii name for the claiming device, dev_name(dev) if NULL
- *	@dev_id: A cookie passed back to the handler function
- *
- *	Except for the extra @dev argument, this function takes the
- *	same arguments and performs the same function as
- *	request_threaded_irq().  IRQs requested with this function will be
- *	automatically freed on driver detach.
- *
- *	If an IRQ allocated with this function needs to be freed
- *	separately, devm_free_irq() must be used.
- */
-int devm_request_threaded_irq(struct device *dev, unsigned int irq,
-			      irq_handler_t handler, irq_handler_t thread_fn,
-			      unsigned long irqflags, const char *devname,
-			      void *dev_id)
+static int devm_request_result(struct device *dev, int rc, unsigned int irq,
+			       irq_handler_t handler, irq_handler_t thread_fn,
+			       const char *devname)
+{
+	if (rc >=3D 0)
+		return rc;
+
+	return dev_err_probe(dev, rc, "request_irq(%u) %ps %ps %s\n",
+			     irq, handler, thread_fn, devname ? : "");
+}
+
+static int __devm_request_threaded_irq(struct device *dev, unsigned int irq,
+				       irq_handler_t handler,
+				       irq_handler_t thread_fn,
+				       unsigned long irqflags,
+				       const char *devname, void *dev_id)
 {
 	struct irq_devres *dr;
 	int rc;
@@ -78,28 +71,48 @@ int devm_request_threaded_irq(struct device *dev, unsigne=
d int irq,
=20
 	return 0;
 }
-EXPORT_SYMBOL(devm_request_threaded_irq);
=20
 /**
- *	devm_request_any_context_irq - allocate an interrupt line for a managed d=
evice
- *	@dev: device to request interrupt for
- *	@irq: Interrupt line to allocate
- *	@handler: Function to be called when the IRQ occurs
- *	@irqflags: Interrupt type flags
- *	@devname: An ascii name for the claiming device, dev_name(dev) if NULL
- *	@dev_id: A cookie passed back to the handler function
+ * devm_request_threaded_irq - allocate an interrupt line for a managed devi=
ce with error logging
+ * @dev:	Device to request interrupt for
+ * @irq:	Interrupt line to allocate
+ * @handler:	Function to be called when the interrupt occurs
+ * @thread_fn:	Function to be called in a threaded interrupt context. NULL
+ *		for devices which handle everything in @handler
+ * @irqflags:	Interrupt type flags
+ * @devname:	An ascii name for the claiming device, dev_name(dev) if NULL
+ * @dev_id:	A cookie passed back to the handler function
  *
- *	Except for the extra @dev argument, this function takes the
- *	same arguments and performs the same function as
- *	request_any_context_irq().  IRQs requested with this function will be
- *	automatically freed on driver detach.
+ * Except for the extra @dev argument, this function takes the same
+ * arguments and performs the same function as request_threaded_irq().
+ * Interrupts requested with this function will be automatically freed on
+ * driver detach.
+ *
+ * If an interrupt allocated with this function needs to be freed
+ * separately, devm_free_irq() must be used.
+ *
+ * When the request fails, an error message is printed with contextual
+ * information (device name, interrupt number, handler functions and
+ * error code). Don't add extra error messages at the call sites.
  *
- *	If an IRQ allocated with this function needs to be freed
- *	separately, devm_free_irq() must be used.
+ * Return: 0 on success or a negative error number.
  */
-int devm_request_any_context_irq(struct device *dev, unsigned int irq,
-			      irq_handler_t handler, unsigned long irqflags,
-			      const char *devname, void *dev_id)
+int devm_request_threaded_irq(struct device *dev, unsigned int irq,
+			      irq_handler_t handler, irq_handler_t thread_fn,
+			      unsigned long irqflags, const char *devname,
+			      void *dev_id)
+{
+	int rc =3D __devm_request_threaded_irq(dev, irq, handler, thread_fn,
+					     irqflags, devname, dev_id);
+
+	return devm_request_result(dev, rc, irq, handler, thread_fn, devname);
+}
+EXPORT_SYMBOL(devm_request_threaded_irq);
+
+static int __devm_request_any_context_irq(struct device *dev, unsigned int i=
rq,
+					  irq_handler_t handler,
+					  unsigned long irqflags,
+					  const char *devname, void *dev_id)
 {
 	struct irq_devres *dr;
 	int rc;
@@ -124,6 +137,40 @@ int devm_request_any_context_irq(struct device *dev, uns=
igned int irq,
=20
 	return rc;
 }
+
+/**
+ * devm_request_any_context_irq - allocate an interrupt line for a managed d=
evice with error logging
+ * @dev:	Device to request interrupt for
+ * @irq:	Interrupt line to allocate
+ * @handler:	Function to be called when the interrupt occurs
+ * @irqflags:	Interrupt type flags
+ * @devname:	An ascii name for the claiming device, dev_name(dev) if NULL
+ * @dev_id:	A cookie passed back to the handler function
+ *
+ * Except for the extra @dev argument, this function takes the same
+ * arguments and performs the same function as request_any_context_irq().
+ * Interrupts requested with this function will be automatically freed on
+ * driver detach.
+ *
+ * If an interrupt allocated with this function needs to be freed
+ * separately, devm_free_irq() must be used.
+ *
+ * When the request fails, an error message is printed with contextual
+ * information (device name, interrupt number, handler functions and
+ * error code). Don't add extra error messages at the call sites.
+ *
+ * Return: IRQC_IS_HARDIRQ or IRQC_IS_NESTED on success, or a negative error
+ * number.
+ */
+int devm_request_any_context_irq(struct device *dev, unsigned int irq,
+				 irq_handler_t handler, unsigned long irqflags,
+				 const char *devname, void *dev_id)
+{
+	int rc =3D __devm_request_any_context_irq(dev, irq, handler, irqflags,
+						devname, dev_id);
+
+	return devm_request_result(dev, rc, irq, handler, NULL, devname);
+}
 EXPORT_SYMBOL(devm_request_any_context_irq);
=20
 /**
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 9489f93b3db3..e103451243a0 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -136,6 +136,44 @@ void __irq_wake_thread(struct irq_desc *desc, struct irq=
action *action)
 	wake_up_process(action->thread);
 }
=20
+static DEFINE_STATIC_KEY_FALSE(irqhandler_duration_check_enabled);
+static u64 irqhandler_duration_threshold_ns __ro_after_init;
+
+static int __init irqhandler_duration_check_setup(char *arg)
+{
+	unsigned long val;
+	int ret;
+
+	ret =3D kstrtoul(arg, 0, &val);
+	if (ret) {
+		pr_err("Unable to parse irqhandler.duration_warn_us setting: ret=3D%d\n", =
ret);
+		return 0;
+	}
+
+	if (!val) {
+		pr_err("Invalid irqhandler.duration_warn_us setting, must be > 0\n");
+		return 0;
+	}
+
+	irqhandler_duration_threshold_ns =3D val * 1000;
+	static_branch_enable(&irqhandler_duration_check_enabled);
+
+	return 1;
+}
+__setup("irqhandler.duration_warn_us=3D", irqhandler_duration_check_setup);
+
+static inline void irqhandler_duration_check(u64 ts_start, unsigned int irq,
+					     const struct irqaction *action)
+{
+	u64 delta_ns =3D local_clock() - ts_start;
+
+	if (unlikely(delta_ns > irqhandler_duration_threshold_ns)) {
+		pr_warn_ratelimited("[CPU%u] long duration of IRQ[%u:%ps], took: %llu us\n=
",
+				    smp_processor_id(), irq, action->handler,
+				    div_u64(delta_ns, NSEC_PER_USEC));
+	}
+}
+
 irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc)
 {
 	irqreturn_t retval =3D IRQ_NONE;
@@ -155,7 +193,16 @@ irqreturn_t __handle_irq_event_percpu(struct irq_desc *d=
esc)
 			lockdep_hardirq_threaded();
=20
 		trace_irq_handler_entry(irq, action);
-		res =3D action->handler(irq, action->dev_id);
+
+		if (static_branch_unlikely(&irqhandler_duration_check_enabled)) {
+			u64 ts_start =3D local_clock();
+
+			res =3D action->handler(irq, action->dev_id);
+			irqhandler_duration_check(ts_start, irq, action);
+		} else {
+			res =3D action->handler(irq, action->dev_id);
+		}
+
 		trace_irq_handler_exit(irq, action, res);
=20
 		if (WARN_ONCE(!irqs_disabled(),"irq %u handler %pS enabled interrupts\n",
diff --git a/kernel/irq/irq_test.c b/kernel/irq/irq_test.c
index a75abebed7f2..e2d31914b3c4 100644
--- a/kernel/irq/irq_test.c
+++ b/kernel/irq/irq_test.c
@@ -41,21 +41,37 @@ static struct irq_chip fake_irq_chip =3D {
 	.flags          =3D IRQCHIP_SKIP_SET_WAKE,
 };
=20
-static void irq_disable_depth_test(struct kunit *test)
+static int irq_test_setup_fake_irq(struct kunit *test, struct irq_affinity_d=
esc *affd)
 {
 	struct irq_desc *desc;
-	int virq, ret;
+	int virq;
=20
-	virq =3D irq_domain_alloc_descs(-1, 1, 0, NUMA_NO_NODE, NULL);
+	virq =3D irq_domain_alloc_descs(-1, 1, 0, NUMA_NO_NODE, affd);
 	KUNIT_ASSERT_GE(test, virq, 0);
=20
-	irq_set_chip_and_handler(virq, &dummy_irq_chip, handle_simple_irq);
+	irq_set_chip_and_handler(virq, &fake_irq_chip, handle_simple_irq);
+
+	desc =3D irq_to_desc(virq);
+	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
+
+	/* On some architectures, IRQs are NOREQUEST | NOPROBE by default. */
+	irq_settings_clr_norequest(desc);
+
+	return virq;
+}
+
+static void irq_disable_depth_test(struct kunit *test)
+{
+	struct irq_desc *desc;
+	int virq, ret;
+
+	virq =3D irq_test_setup_fake_irq(test, NULL);
=20
 	desc =3D irq_to_desc(virq);
 	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
=20
 	ret =3D request_irq(virq, noop_handler, 0, "test_irq", NULL);
-	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_ASSERT_EQ(test, ret, 0);
=20
 	KUNIT_EXPECT_EQ(test, desc->depth, 0);
=20
@@ -73,16 +89,13 @@ static void irq_free_disabled_test(struct kunit *test)
 	struct irq_desc *desc;
 	int virq, ret;
=20
-	virq =3D irq_domain_alloc_descs(-1, 1, 0, NUMA_NO_NODE, NULL);
-	KUNIT_ASSERT_GE(test, virq, 0);
-
-	irq_set_chip_and_handler(virq, &dummy_irq_chip, handle_simple_irq);
+	virq =3D irq_test_setup_fake_irq(test, NULL);
=20
 	desc =3D irq_to_desc(virq);
 	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
=20
 	ret =3D request_irq(virq, noop_handler, 0, "test_irq", NULL);
-	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_ASSERT_EQ(test, ret, 0);
=20
 	KUNIT_EXPECT_EQ(test, desc->depth, 0);
=20
@@ -93,7 +106,7 @@ static void irq_free_disabled_test(struct kunit *test)
 	KUNIT_EXPECT_GE(test, desc->depth, 1);
=20
 	ret =3D request_irq(virq, noop_handler, 0, "test_irq", NULL);
-	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_ASSERT_EQ(test, ret, 0);
 	KUNIT_EXPECT_EQ(test, desc->depth, 0);
=20
 	free_irq(virq, NULL);
@@ -112,10 +125,7 @@ static void irq_shutdown_depth_test(struct kunit *test)
 	if (!IS_ENABLED(CONFIG_SMP))
 		kunit_skip(test, "requires CONFIG_SMP for managed shutdown");
=20
-	virq =3D irq_domain_alloc_descs(-1, 1, 0, NUMA_NO_NODE, &affinity);
-	KUNIT_ASSERT_GE(test, virq, 0);
-
-	irq_set_chip_and_handler(virq, &dummy_irq_chip, handle_simple_irq);
+	virq =3D irq_test_setup_fake_irq(test, &affinity);
=20
 	desc =3D irq_to_desc(virq);
 	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
@@ -124,7 +134,7 @@ static void irq_shutdown_depth_test(struct kunit *test)
 	KUNIT_ASSERT_PTR_NE(test, data, NULL);
=20
 	ret =3D request_irq(virq, noop_handler, 0, "test_irq", NULL);
-	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_ASSERT_EQ(test, ret, 0);
=20
 	KUNIT_EXPECT_TRUE(test, irqd_is_activated(data));
 	KUNIT_EXPECT_TRUE(test, irqd_is_started(data));
@@ -169,13 +179,12 @@ static void irq_cpuhotplug_test(struct kunit *test)
 		kunit_skip(test, "requires more than 1 CPU for CPU hotplug");
 	if (!cpu_is_hotpluggable(1))
 		kunit_skip(test, "CPU 1 must be hotpluggable");
+	if (!cpu_online(1))
+		kunit_skip(test, "CPU 1 must be online");
=20
 	cpumask_copy(&affinity.mask, cpumask_of(1));
=20
-	virq =3D irq_domain_alloc_descs(-1, 1, 0, NUMA_NO_NODE, &affinity);
-	KUNIT_ASSERT_GE(test, virq, 0);
-
-	irq_set_chip_and_handler(virq, &fake_irq_chip, handle_simple_irq);
+	virq =3D irq_test_setup_fake_irq(test, &affinity);
=20
 	desc =3D irq_to_desc(virq);
 	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
@@ -184,7 +193,7 @@ static void irq_cpuhotplug_test(struct kunit *test)
 	KUNIT_ASSERT_PTR_NE(test, data, NULL);
=20
 	ret =3D request_irq(virq, noop_handler, 0, "test_irq", NULL);
-	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_ASSERT_EQ(test, ret, 0);
=20
 	KUNIT_EXPECT_TRUE(test, irqd_is_activated(data));
 	KUNIT_EXPECT_TRUE(test, irqd_is_started(data));
@@ -196,13 +205,9 @@ static void irq_cpuhotplug_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, desc->depth, 1);
=20
 	KUNIT_EXPECT_EQ(test, remove_cpu(1), 0);
-	KUNIT_EXPECT_FALSE(test, irqd_is_activated(data));
-	KUNIT_EXPECT_FALSE(test, irqd_is_started(data));
 	KUNIT_EXPECT_GE(test, desc->depth, 1);
 	KUNIT_EXPECT_EQ(test, add_cpu(1), 0);
=20
-	KUNIT_EXPECT_FALSE(test, irqd_is_activated(data));
-	KUNIT_EXPECT_FALSE(test, irqd_is_started(data));
 	KUNIT_EXPECT_EQ(test, desc->depth, 1);
=20
 	enable_irq(virq);
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
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 513b1945987c..77198911b8dd 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -165,7 +165,11 @@ void __local_bh_disable_ip(unsigned long ip, unsigned in=
t cnt)
 	/* First entry of a task into a BH disabled section? */
 	if (!current->softirq_disable_cnt) {
 		if (preemptible()) {
-			local_lock(&softirq_ctrl.lock);
+			if (IS_ENABLED(CONFIG_PREEMPT_RT_NEEDS_BH_LOCK))
+				local_lock(&softirq_ctrl.lock);
+			else
+				migrate_disable();
+
 			/* Required to meet the RCU bottomhalf requirements. */
 			rcu_read_lock();
 		} else {
@@ -177,17 +181,34 @@ void __local_bh_disable_ip(unsigned long ip, unsigned i=
nt cnt)
 	 * Track the per CPU softirq disabled state. On RT this is per CPU
 	 * state to allow preemption of bottom half disabled sections.
 	 */
-	newcnt =3D __this_cpu_add_return(softirq_ctrl.cnt, cnt);
-	/*
-	 * Reflect the result in the task state to prevent recursion on the
-	 * local lock and to make softirq_count() & al work.
-	 */
-	current->softirq_disable_cnt =3D newcnt;
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_NEEDS_BH_LOCK)) {
+		newcnt =3D this_cpu_add_return(softirq_ctrl.cnt, cnt);
+		/*
+		 * Reflect the result in the task state to prevent recursion on the
+		 * local lock and to make softirq_count() & al work.
+		 */
+		current->softirq_disable_cnt =3D newcnt;
=20
-	if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && newcnt =3D=3D cnt) {
-		raw_local_irq_save(flags);
-		lockdep_softirqs_off(ip);
-		raw_local_irq_restore(flags);
+		if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && newcnt =3D=3D cnt) {
+			raw_local_irq_save(flags);
+			lockdep_softirqs_off(ip);
+			raw_local_irq_restore(flags);
+		}
+	} else {
+		bool sirq_dis =3D false;
+
+		if (!current->softirq_disable_cnt)
+			sirq_dis =3D true;
+
+		this_cpu_add(softirq_ctrl.cnt, cnt);
+		current->softirq_disable_cnt +=3D cnt;
+		WARN_ON_ONCE(current->softirq_disable_cnt < 0);
+
+		if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && sirq_dis) {
+			raw_local_irq_save(flags);
+			lockdep_softirqs_off(ip);
+			raw_local_irq_restore(flags);
+		}
 	}
 }
 EXPORT_SYMBOL(__local_bh_disable_ip);
@@ -195,23 +216,42 @@ EXPORT_SYMBOL(__local_bh_disable_ip);
 static void __local_bh_enable(unsigned int cnt, bool unlock)
 {
 	unsigned long flags;
+	bool sirq_en =3D false;
 	int newcnt;
=20
-	DEBUG_LOCKS_WARN_ON(current->softirq_disable_cnt !=3D
-			    this_cpu_read(softirq_ctrl.cnt));
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_NEEDS_BH_LOCK)) {
+		DEBUG_LOCKS_WARN_ON(current->softirq_disable_cnt !=3D
+				    this_cpu_read(softirq_ctrl.cnt));
+		if (softirq_count() =3D=3D cnt)
+			sirq_en =3D true;
+	} else {
+		if (current->softirq_disable_cnt =3D=3D cnt)
+			sirq_en =3D true;
+	}
=20
-	if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && softirq_count() =3D=3D cnt) {
+	if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && sirq_en) {
 		raw_local_irq_save(flags);
 		lockdep_softirqs_on(_RET_IP_);
 		raw_local_irq_restore(flags);
 	}
=20
-	newcnt =3D __this_cpu_sub_return(softirq_ctrl.cnt, cnt);
-	current->softirq_disable_cnt =3D newcnt;
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_NEEDS_BH_LOCK)) {
+		newcnt =3D this_cpu_sub_return(softirq_ctrl.cnt, cnt);
+		current->softirq_disable_cnt =3D newcnt;
=20
-	if (!newcnt && unlock) {
-		rcu_read_unlock();
-		local_unlock(&softirq_ctrl.lock);
+		if (!newcnt && unlock) {
+			rcu_read_unlock();
+			local_unlock(&softirq_ctrl.lock);
+		}
+	} else {
+		current->softirq_disable_cnt -=3D cnt;
+		this_cpu_sub(softirq_ctrl.cnt, cnt);
+		if (unlock && !current->softirq_disable_cnt) {
+			migrate_enable();
+			rcu_read_unlock();
+		} else {
+			WARN_ON_ONCE(current->softirq_disable_cnt < 0);
+		}
 	}
 }
=20
@@ -228,7 +268,10 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int=
 cnt)
 	lock_map_release(&bh_lock_map);
=20
 	local_irq_save(flags);
-	curcnt =3D __this_cpu_read(softirq_ctrl.cnt);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_NEEDS_BH_LOCK))
+		curcnt =3D this_cpu_read(softirq_ctrl.cnt);
+	else
+		curcnt =3D current->softirq_disable_cnt;
=20
 	/*
 	 * If this is not reenabling soft interrupts, no point in trying to
@@ -805,6 +848,58 @@ static bool tasklet_clear_sched(struct tasklet_struct *t)
 	return false;
 }
=20
+#ifdef CONFIG_PREEMPT_RT
+struct tasklet_sync_callback {
+	spinlock_t	cb_lock;
+	atomic_t	cb_waiters;
+};
+
+static DEFINE_PER_CPU(struct tasklet_sync_callback, tasklet_sync_callback) =
=3D {
+	.cb_lock	=3D __SPIN_LOCK_UNLOCKED(tasklet_sync_callback.cb_lock),
+	.cb_waiters	=3D ATOMIC_INIT(0),
+};
+
+static void tasklet_lock_callback(void)
+{
+	spin_lock(this_cpu_ptr(&tasklet_sync_callback.cb_lock));
+}
+
+static void tasklet_unlock_callback(void)
+{
+	spin_unlock(this_cpu_ptr(&tasklet_sync_callback.cb_lock));
+}
+
+static void tasklet_callback_cancel_wait_running(void)
+{
+	struct tasklet_sync_callback *sync_cb =3D this_cpu_ptr(&tasklet_sync_callba=
ck);
+
+	atomic_inc(&sync_cb->cb_waiters);
+	spin_lock(&sync_cb->cb_lock);
+	atomic_dec(&sync_cb->cb_waiters);
+	spin_unlock(&sync_cb->cb_lock);
+}
+
+static void tasklet_callback_sync_wait_running(void)
+{
+	struct tasklet_sync_callback *sync_cb =3D this_cpu_ptr(&tasklet_sync_callba=
ck);
+
+	if (atomic_read(&sync_cb->cb_waiters)) {
+		spin_unlock(&sync_cb->cb_lock);
+		spin_lock(&sync_cb->cb_lock);
+	}
+}
+
+#else /* !CONFIG_PREEMPT_RT: */
+
+static void tasklet_lock_callback(void) { }
+static void tasklet_unlock_callback(void) { }
+static void tasklet_callback_sync_wait_running(void) { }
+
+#ifdef CONFIG_SMP
+static void tasklet_callback_cancel_wait_running(void) { }
+#endif
+#endif /* !CONFIG_PREEMPT_RT */
+
 static void tasklet_action_common(struct tasklet_head *tl_head,
 				  unsigned int softirq_nr)
 {
@@ -816,6 +911,7 @@ static void tasklet_action_common(struct tasklet_head *tl=
_head,
 	tl_head->tail =3D &tl_head->head;
 	local_irq_enable();
=20
+	tasklet_lock_callback();
 	while (list) {
 		struct tasklet_struct *t =3D list;
=20
@@ -835,6 +931,7 @@ static void tasklet_action_common(struct tasklet_head *tl=
_head,
 					}
 				}
 				tasklet_unlock(t);
+				tasklet_callback_sync_wait_running();
 				continue;
 			}
 			tasklet_unlock(t);
@@ -847,6 +944,7 @@ static void tasklet_action_common(struct tasklet_head *tl=
_head,
 		__raise_softirq_irqoff(softirq_nr);
 		local_irq_enable();
 	}
+	tasklet_unlock_callback();
 }
=20
 static __latent_entropy void tasklet_action(void)
@@ -897,12 +995,9 @@ void tasklet_unlock_spin_wait(struct tasklet_struct *t)
 			/*
 			 * Prevent a live lock when current preempted soft
 			 * interrupt processing or prevents ksoftirqd from
-			 * running. If the tasklet runs on a different CPU
-			 * then this has no effect other than doing the BH
-			 * disable/enable dance for nothing.
+			 * running.
 			 */
-			local_bh_disable();
-			local_bh_enable();
+			tasklet_callback_cancel_wait_running();
 		} else {
 			cpu_relax();
 		}



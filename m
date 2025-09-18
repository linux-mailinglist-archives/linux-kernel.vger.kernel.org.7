Return-Path: <linux-kernel+bounces-823703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE584B873A1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 00:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD33558206E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 22:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E0831AF00;
	Thu, 18 Sep 2025 22:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTMSKmaH"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B251730FC25
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 22:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758234391; cv=none; b=YJpn9Yuijs3h837FODXZ1d9vfmMpiMviC2NPHWPv02D8FZSEhRr+z0UGkTzC6UF5uKOYrJykZ8HVChtsi1OIUoMq7WCB/DC+EzmCM+9jt3OtAmsnR7qBNyQer6fMZkyBOXDmm5KLv2Ojbqb4W1ckSRj1WOf4h0hYXTgfR4ns2B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758234391; c=relaxed/simple;
	bh=w42DmKJQJ732kdg3GWkZIxaq+JRMhebKM26e41ZUa+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZQZCLW9bCv2XZk7ky4AZIi42cNyPImAJQy8MpibmPWzLZ8+nRp+086abOBvaZptuv0PloXro2W7/RcW2gLofhwgb1Yv1l/XnTTCxRjTyf8dygS9una0IgBIqboVTNfVqKg8WkYHLpDrEXeY1oHGWZUKMEkRRzYXc1Be5j8jSRmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTMSKmaH; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77d64726e47so1043752b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758234388; x=1758839188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzZPK+tD8ua9mkD8VwlX20r11BOjtw6Um42qZGE0OrE=;
        b=JTMSKmaHGzwQmrFmG0TsiQQVWBWNioIrJ4CK4EO2VbsdECNlNyi5dAA7xJpNSKh1HX
         CpWn+1y0JCVs9/nwf7P62kXHGSyNivxefL4h13IqgiS0BYnsy4BRra/umDvk1Z9c07pU
         bD9mmJ9q5qt1iuoVMBIOaxzTRF6mqF1kRH38rEuQVcgEDQKq2Dllorsw6gv5A6vb7JrG
         Q2FgebpuCbKcazSjEjOKttmrdq02HIFFF8CGL+GorLevIQjxo0T5wLWwA9occ3kGG+lE
         STlFYApJmtFO9rqI3WQfQOk2cGzADiU6rl0AFk3E5PXHOkHXytyYXBliuFBVWz/47Fl/
         ZkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758234388; x=1758839188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzZPK+tD8ua9mkD8VwlX20r11BOjtw6Um42qZGE0OrE=;
        b=KyOful11XdwGkHDexqkVpNDy+7ec6yOrQlfH6v+syO5k8poobydpQCyYKwdxGNhT7m
         DWU1QUMtAWsOO5lwvuwdhIQaUgIz4zrKB5bSJ4EfWwYX3jlIKSx0bGUt+2FzwXoywaNm
         jtva7R8zjYQ35YZ0xnWYlxspzSk6LV7J4d0RKbsQqrrALWtB4m3cC4Yi/ucNK0V3DcJY
         WYEWDi19InTTT3PnkDHxecIHOVCxX6jjBas4fQAIc4gFomLiG1vgkTRU4eBpnDcGFMpi
         UQ8+6WoYaxIwnW+ADq3TQ4gHldoHcsxIyI/7qxWaYia9S9VgWgH2/esFpbHhf74iPkLm
         BhJQ==
X-Gm-Message-State: AOJu0Yyy7EUcUMXnV91X02H//G6RQQEOsqSpuCThYBkNMvaA/1tgfNvx
	T3oq4YkiRzxv5/g4mfaU+Wop2oBtDylVwNOehWHsBu6CAv4vefeNc0LGlIrhLQ==
X-Gm-Gg: ASbGncssKkTsT7QrWsq/RXEj7Qc56EJ6JuF59iGjHB17EXgltRYgmj4IQaWhX+Qrmb5
	K7s/AcXswb6h259cngo4S3zJxuhwVRiwQ9JJNFY2++ebQSC4E9RPK14Cxpj2Lx8sXc6NhWJNlp9
	ayuig1X38uQaWyCHHKZvUVb1s8E28NY0YqQpQCS1IT+k25dMtyWTeRrn/wak2oGBkbcPgCC37uV
	leM31KCVD2XvmoSKfbIhvBH0r/tUneGUn9+tuBfOvBumlR2Oe6CFeIl/hzQeZLtwvqIAhQXdvQR
	UugTs5wKIgrhCfGcpkObR+hXkrf4vPpuWX3fm6YTLUSDvWEdXSslmzYw7UNoZc1x9sQJ56++kr0
	1B08/J5BRdmebcXtWvMxros4ySpVP6a5M0R5XgPy95LsxdeA=
X-Google-Smtp-Source: AGHT+IEcmBpKgxWK65kqL+t4N9tpvg/YpMV9lF9NLfIoi4A5w/Hpr9vbHnSl2Ql5oJ01WR0BGA3tRA==
X-Received: by 2002:a05:6a00:cc7:b0:776:1804:6fe with SMTP id d2e1a72fcca58-77e4cc3c5e1mr1115624b3a.7.1758234387508;
        Thu, 18 Sep 2025 15:26:27 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:c5c1:2e33:6cf2:beed])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77e5fe6de75sm407542b3a.19.2025.09.18.15.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 15:26:26 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: pasha.tatashin@soleen.com,
	Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [RFC Patch 4/7] kernel: Introduce generic multikernel IPI communication framework
Date: Thu, 18 Sep 2025 15:26:03 -0700
Message-Id: <20250918222607.186488-5-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cwang@multikernel.io>

This patch implements a comprehensive IPI-based communication system
for multikernel environments, enabling data exchange between different
kernel instances running on separate CPUs.

Key features include:

- Generic IPI handler registration and callback mechanism allowing
  modules to register for multikernel communication events
- Shared memory infrastructure using either boot parameter-specified
  or dynamically allocated physical memory regions
- Per-CPU data buffers in shared memory for efficient IPI payload
  transfer up to 256 bytes per message
- IRQ work integration for safe callback execution in interrupt context
- PFN-based flexible shared memory APIs for page-level data sharing
- Resource tracking integration for /proc/iomem visibility

The implementation provides multikernel_send_ipi_data() for sending
typed data to target CPUs and multikernel_register_handler() for
receiving notifications. Shared memory is established during early
boot and mapped using memremap() for cache-coherent access.

This infrastructure enables heterogeneous computing scenarios where
multikernel instances can coordinate and share data while maintaining
isolation on their respective CPU cores.

Note, as a proof-of-concept, we have only implemented the x86 part.

Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 arch/x86/kernel/smp.c       |   5 +-
 include/linux/multikernel.h |  81 ++++++++++
 init/main.c                 |   2 +
 kernel/Makefile             |   2 +-
 kernel/multikernel.c        | 313 ++++++++++++++++++++++++++++++++++++
 5 files changed, 398 insertions(+), 5 deletions(-)
 create mode 100644 include/linux/multikernel.h
 create mode 100644 kernel/multikernel.c

diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 028cc423a772..3ee515e32383 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -272,10 +272,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_call_function_single)
 	trace_call_function_single_exit(CALL_FUNCTION_SINGLE_VECTOR);
 }
 
-static void generic_multikernel_interrupt(void)
-{
-	pr_info("Multikernel interrupt\n");
-}
+void generic_multikernel_interrupt(void);
 
 DEFINE_IDTENTRY_SYSVEC(sysvec_multikernel)
 {
diff --git a/include/linux/multikernel.h b/include/linux/multikernel.h
new file mode 100644
index 000000000000..12ed5e03f92e
--- /dev/null
+++ b/include/linux/multikernel.h
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Multikernel Technologies, Inc. All rights reserved
+ */
+#ifndef _LINUX_MULTIKERNEL_H
+#define _LINUX_MULTIKERNEL_H
+
+#include <linux/types.h>
+#include <linux/irq_work.h>
+
+/**
+ * Multikernel IPI interface
+ *
+ * This header provides declarations for the multikernel IPI interface,
+ * allowing modules to register callbacks for IPI events and pass data
+ * between CPUs.
+ */
+
+/* Maximum data size that can be transferred via IPI */
+#define MK_MAX_DATA_SIZE 256
+
+/* Data structure for passing parameters via IPI */
+struct mk_ipi_data {
+	int sender_cpu;          /* Which CPU sent this IPI */
+	unsigned int type;      /* User-defined type identifier */
+	size_t data_size;        /* Size of the data */
+	char buffer[MK_MAX_DATA_SIZE]; /* Actual data buffer */
+};
+
+/* Function pointer type for IPI callbacks */
+typedef void (*mk_ipi_callback_t)(struct mk_ipi_data *data, void *ctx);
+
+struct mk_ipi_handler {
+	mk_ipi_callback_t callback;
+	void *context;
+	struct mk_ipi_handler *next;
+	struct mk_ipi_data *saved_data;
+	struct irq_work work;
+};
+
+/**
+ * multikernel_register_handler - Register a callback for multikernel IPI
+ * @callback: Function to call when IPI is received
+ * @ctx: Context pointer passed to the callback
+ *
+ * Returns pointer to handler on success, NULL on failure
+ */
+struct mk_ipi_handler *multikernel_register_handler(mk_ipi_callback_t callback, void *ctx);
+
+/**
+ * multikernel_unregister_handler - Unregister a multikernel IPI callback
+ * @handler: Handler pointer returned from multikernel_register_handler
+ */
+void multikernel_unregister_handler(struct mk_ipi_handler *handler);
+
+/**
+ * multikernel_send_ipi_data - Send data to another CPU via IPI
+ * @cpu: Target CPU
+ * @data: Pointer to data to send
+ * @data_size: Size of data
+ * @type: User-defined type identifier
+ *
+ * This function copies the data to per-CPU storage and sends an IPI
+ * to the target CPU.
+ *
+ * Returns 0 on success, negative error code on failure
+ */
+int multikernel_send_ipi_data(int cpu, void *data, size_t data_size, unsigned long type);
+
+void generic_multikernel_interrupt(void);
+
+int __init multikernel_init(void);
+
+/* Flexible shared memory APIs (PFN-based) */
+int mk_send_pfn(int target_cpu, unsigned long pfn);
+int mk_receive_pfn(struct mk_ipi_data *data, unsigned long *out_pfn);
+void *mk_receive_map_page(struct mk_ipi_data *data);
+
+#define mk_receive_unmap_page(p) memunmap(p)
+
+#endif /* _LINUX_MULTIKERNEL_H */
diff --git a/init/main.c b/init/main.c
index 5753e9539ae6..46a199bcb389 100644
--- a/init/main.c
+++ b/init/main.c
@@ -103,6 +103,7 @@
 #include <linux/randomize_kstack.h>
 #include <linux/pidfs.h>
 #include <linux/ptdump.h>
+#include <linux/multikernel.h>
 #include <net/net_namespace.h>
 
 #include <asm/io.h>
@@ -955,6 +956,7 @@ void start_kernel(void)
 	vfs_caches_init_early();
 	sort_main_extable();
 	trap_init();
+	multikernel_init();
 	mm_core_init();
 	maple_tree_init();
 	poking_init();
diff --git a/kernel/Makefile b/kernel/Makefile
index c60623448235..e5216610a4e7 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -10,7 +10,7 @@ obj-y     = fork.o exec_domain.o panic.o \
 	    extable.o params.o \
 	    kthread.o sys_ni.o nsproxy.o \
 	    notifier.o ksysfs.o cred.o reboot.o \
-	    async.o range.o smpboot.o ucount.o regset.o ksyms_common.o
+	    async.o range.o smpboot.o ucount.o regset.o ksyms_common.o multikernel.o
 
 obj-$(CONFIG_MULTIUSER) += groups.o
 obj-$(CONFIG_VHOST_TASK) += vhost_task.o
diff --git a/kernel/multikernel.c b/kernel/multikernel.c
new file mode 100644
index 000000000000..74e2f84b7914
--- /dev/null
+++ b/kernel/multikernel.c
@@ -0,0 +1,313 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Multikernel Technologies, Inc. All rights reserved
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/percpu.h>
+#include <linux/spinlock.h>
+#include <linux/multikernel.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <asm/apic.h>
+#include <linux/memblock.h>
+
+/* Memory parameters for shared region */
+#define MK_IPI_DATA_SIZE  (sizeof(struct mk_ipi_data) * NR_CPUS)
+#define MK_MEM_BASE_SIZE  (sizeof(struct mk_shared_data))
+#define MK_MEM_SIZE       (MK_MEM_BASE_SIZE + PAGE_SIZE)
+
+/* Boot parameter for physical address */
+static unsigned long mk_phys_addr_param;
+
+/* Parse multikernel physical address from kernel command line */
+static int __init multikernel_phys_addr_setup(char *str)
+{
+	return kstrtoul(str, 0, &mk_phys_addr_param);
+}
+early_param("mk_shared_memory", multikernel_phys_addr_setup);
+
+/* Allocated/assigned physical address for shared memory */
+static phys_addr_t mk_phys_addr_base;
+
+/* Resource structure for tracking the memory in /proc/iomem */
+static struct resource mk_mem_res __ro_after_init = {
+	.name = "Multikernel Shared Memory",
+	.flags = IORESOURCE_MEM | IORESOURCE_BUSY,
+};
+
+/* Shared memory structures */
+struct mk_shared_data {
+	struct mk_ipi_data cpu_data[NR_CPUS];  /* Data area for each CPU */
+};
+
+/* Pointer to the shared memory area (remapped virtual address) */
+static struct mk_shared_data *mk_shared_mem;
+
+/* Callback management */
+static struct mk_ipi_handler *mk_handlers;
+static raw_spinlock_t mk_handlers_lock = __RAW_SPIN_LOCK_UNLOCKED(mk_handlers_lock);
+
+static void handler_work(struct irq_work *work)
+{
+    struct mk_ipi_handler *handler = container_of(work, struct mk_ipi_handler, work);
+    if (handler->callback)
+        handler->callback(handler->saved_data, handler->context);
+}
+
+/**
+ * multikernel_register_handler - Register a callback for multikernel IPI
+ * @callback: Function to call when IPI is received
+ * @ctx: Context pointer passed to the callback
+ *
+ * Returns pointer to handler on success, NULL on failure
+ */
+struct mk_ipi_handler *multikernel_register_handler(mk_ipi_callback_t callback, void *ctx)
+{
+	struct mk_ipi_handler *handler;
+	unsigned long flags;
+
+	if (!callback)
+		return NULL;
+
+	handler = kzalloc(sizeof(*handler), GFP_KERNEL);
+	if (!handler)
+		return NULL;
+
+	handler->callback = callback;
+	handler->context = ctx;
+
+	init_irq_work(&handler->work, handler_work);
+
+	raw_spin_lock_irqsave(&mk_handlers_lock, flags);
+	handler->next = mk_handlers;
+	mk_handlers = handler;
+	raw_spin_unlock_irqrestore(&mk_handlers_lock, flags);
+
+	return handler;
+}
+EXPORT_SYMBOL(multikernel_register_handler);
+
+/**
+ * multikernel_unregister_handler - Unregister a multikernel IPI callback
+ * @handler: Handler pointer returned from multikernel_register_handler
+ */
+void multikernel_unregister_handler(struct mk_ipi_handler *handler)
+{
+	struct mk_ipi_handler **pp, *p;
+	unsigned long flags;
+
+	if (!handler)
+		return;
+
+	raw_spin_lock_irqsave(&mk_handlers_lock, flags);
+	pp = &mk_handlers;
+	while ((p = *pp) != NULL) {
+		if (p == handler) {
+			*pp = p->next;
+			break;
+		}
+		pp = &p->next;
+	}
+	raw_spin_unlock_irqrestore(&mk_handlers_lock, flags);
+
+    /* Wait for pending work to complete */
+    irq_work_sync(&handler->work);
+    kfree(p);
+}
+EXPORT_SYMBOL(multikernel_unregister_handler);
+
+/**
+ * multikernel_send_ipi_data - Send data to another CPU via IPI
+ * @cpu: Target CPU
+ * @data: Pointer to data to send
+ * @data_size: Size of data
+ * @type: User-defined type identifier
+ *
+ * This function copies the data to per-CPU storage and sends an IPI
+ * to the target CPU.
+ *
+ * Returns 0 on success, negative error code on failure
+ */
+int multikernel_send_ipi_data(int cpu, void *data, size_t data_size, unsigned long type)
+{
+	struct mk_ipi_data *target;
+
+	if (cpu < 0 || cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	if (data_size > MK_MAX_DATA_SIZE)
+		return -EINVAL;  /* Data too large for buffer */
+
+	/* Ensure shared memory is initialized */
+	if (!mk_shared_mem)
+		return -ENOMEM;
+
+	/* Get target CPU's data area from shared memory */
+	target = &mk_shared_mem->cpu_data[cpu];
+
+	/* Set header information */
+	target->data_size = data_size;
+	target->sender_cpu = smp_processor_id();
+	target->type = type;
+
+	/* Copy the actual data into the buffer */
+	if (data && data_size > 0)
+		memcpy(target->buffer, data, data_size);
+
+	/* Send IPI to target CPU */
+	__apic_send_IPI(cpu, MULTIKERNEL_VECTOR);
+
+	return 0;
+}
+EXPORT_SYMBOL(multikernel_send_ipi_data);
+
+/**
+ * multikernel_interrupt_handler - Handle the multikernel IPI
+ *
+ * This function is called when a multikernel IPI is received.
+ * It invokes all registered callbacks with the per-CPU data.
+ */
+static void multikernel_interrupt_handler(void)
+{
+	struct mk_ipi_data *data;
+	struct mk_ipi_handler *handler;
+	int current_cpu = smp_processor_id();
+
+	/* Ensure shared memory is initialized */
+	if (!mk_shared_mem) {
+		pr_err("Multikernel IPI received but shared memory not initialized\n");
+		return;
+	}
+
+	/* Get this CPU's data area from shared memory */
+	data = &mk_shared_mem->cpu_data[current_cpu];
+
+	pr_debug("Multikernel IPI received on CPU %d from CPU %d, type=%u\n",
+		 current_cpu, data->sender_cpu, data->type);
+
+    raw_spin_lock(&mk_handlers_lock);
+    for (handler = mk_handlers; handler; handler = handler->next) {
+        handler->saved_data = data;
+        irq_work_queue(&handler->work);
+    }
+    raw_spin_unlock(&mk_handlers_lock);
+}
+
+/**
+ * Generic multikernel interrupt handler - called by the IPI vector
+ *
+ * This is the function that gets called by the IPI vector handler.
+ */
+void generic_multikernel_interrupt(void)
+{
+	multikernel_interrupt_handler();
+}
+
+/**
+ * setup_shared_memory - Initialize shared memory for inter-kernel communication
+ *
+ * Maps a fixed physical memory region for sharing IPI data between kernels
+ * Returns 0 on success, negative error code on failure
+ */
+static int __init setup_shared_memory(void)
+{
+	/* Check if a fixed physical address was provided via parameter */
+	if (mk_phys_addr_param) {
+		/* Use the provided physical address */
+		mk_phys_addr_base = (phys_addr_t)mk_phys_addr_param;
+		pr_info("Using specified physical address 0x%llx for multikernel shared memory\n",
+		       (unsigned long long)mk_phys_addr_base);
+	} else {
+		/* Dynamically allocate contiguous physical memory using memblock */
+		mk_phys_addr_base = memblock_phys_alloc(MK_MEM_SIZE, PAGE_SIZE);
+		if (!mk_phys_addr_base) {
+			pr_err("Failed to allocate physical memory for multikernel IPI data\n");
+			return -ENOMEM;
+		}
+	}
+
+	/* Map the physical memory region to virtual address space */
+	mk_shared_mem = memremap(mk_phys_addr_base, MK_MEM_SIZE, MEMREMAP_WB);
+	if (!mk_shared_mem) {
+		pr_err("Failed to map shared memory at 0x%llx for multikernel IPI data\n",
+		       (unsigned long long)mk_phys_addr_base);
+
+		/* Only free the memory if we allocated it dynamically */
+		if (!mk_phys_addr_param)
+			memblock_phys_free(mk_phys_addr_base, MK_MEM_SIZE);
+		return -ENOMEM;
+	}
+
+	/* Initialize the memory to zero */
+	memset(mk_shared_mem, 0, sizeof(struct mk_shared_data));
+
+	pr_info("Allocated and mapped multikernel shared memory: phys=0x%llx, virt=%px, size=%lu bytes\n",
+		(unsigned long long)mk_phys_addr_base, mk_shared_mem, MK_MEM_SIZE);
+
+	return 0;
+}
+
+int __init multikernel_init(void)
+{
+	int ret;
+
+	ret = setup_shared_memory();
+	if (ret < 0)
+		return ret;
+
+	pr_info("Multikernel IPI support initialized\n");
+	return 0;
+}
+
+static int __init init_shared_memory(void)
+{
+	/* Set up resource structure for /proc/iomem visibility */
+	mk_mem_res.start = mk_phys_addr_base;
+	mk_mem_res.end = mk_phys_addr_base + MK_MEM_SIZE - 1;
+
+	/* Register the resource in the global resource tree */
+	if (insert_resource(&iomem_resource, &mk_mem_res)) {
+		pr_warn("Could not register multikernel shared memory region in resource tracking\n");
+		/* Continue anyway as this is not fatal */
+		return -1;
+	}
+
+	pr_info("Registered multikernel shared memory in resource tree: 0x%llx-0x%llx\n",
+		(unsigned long long)mk_mem_res.start, (unsigned long long)mk_mem_res.end);
+	return 0;
+}
+core_initcall(init_shared_memory);
+
+/* ---- Flexible shared memory APIs (PFN-based) ---- */
+#define MK_PFN_IPI_TYPE 0x80000001U
+
+/* Send a PFN to another kernel via mk_ipi_data */
+int mk_send_pfn(int target_cpu, unsigned long pfn)
+{
+	return multikernel_send_ipi_data(target_cpu, &pfn, sizeof(pfn), MK_PFN_IPI_TYPE);
+}
+
+/* Receive a PFN from mk_ipi_data. Caller must check type. */
+int mk_receive_pfn(struct mk_ipi_data *data, unsigned long *out_pfn)
+{
+	if (!data || !out_pfn)
+		return -EINVAL;
+	if (data->type != MK_PFN_IPI_TYPE || data->data_size != sizeof(unsigned long))
+		return -EINVAL;
+	*out_pfn = *(unsigned long *)data->buffer;
+	return 0;
+}
+
+void *mk_receive_map_page(struct mk_ipi_data *data)
+{
+	unsigned long pfn;
+	int ret;
+
+	ret = mk_receive_pfn(data, &pfn);
+	if (ret < 0)
+		return NULL;
+	return memremap(pfn << PAGE_SHIFT, PAGE_SIZE, MEMREMAP_WB);
+}
-- 
2.34.1



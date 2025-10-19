Return-Path: <linux-kernel+bounces-859552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83836BEDEF8
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 08:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1713189C82A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 06:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E466227EAA;
	Sun, 19 Oct 2025 06:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0xFEl75"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F6023D7C2
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 06:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760854641; cv=none; b=oGr1bTFG3Y3ahXGmkv8u7+F+u3MbVwctz9Z/rCX6rDVSYSSpy7M/bHZ4KtIL+EzC7kc5mHSbEK2ZoeBOA3zPs2F3qJv+U0o5gIo0PCDHG/zW+psvQ3K49LkT5kea7WZc1KRLfK/ysxnQX5tgbPjhjxrfv9/Hu8cdURfFAi8w7EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760854641; c=relaxed/simple;
	bh=XcIgXdMdOs9hLRUuXh8KuvkgOtIDKwPU5rUCnltqnxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bio1vA+QhKjGp1aVOCg7ATsdpf5a30eMGQ0pzvtkunqnHxjVLUdPHzDhk+9Y9V2BFtvk11+Mp9nMLd37R7/z3F44DnwckKmcVn4VOX3rpo9VG0gZYPcSHblwnLf26z3fb3D86N0yzIBRfhA8mnBZsZMUlAD/pJzAhAOOn9tq1J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0xFEl75; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-339e71ccf48so4657591a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 23:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760854638; x=1761459438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7G7V2lDPyVtB8Vl6uN0jxj375YUrl6r66ag/KY1fjtA=;
        b=Z0xFEl75K+n8+/FHZmUWk5pwhomKPukHaKnScIZcSNn3zU7Bqsiw86bbJ1Q3Nepq3j
         fpKVAF3xtKPKdAKMUm33TVdlu0Tgyc5lDjj5W8LGoI3NfI21N9fSf5mrksxhZnuXO936
         +r+UpjkiGo9o+HzPbDAysYFJ5xyTpXhS2hpz7nFsK8Az8DWHcV+eKVg0sqz5GSvlql9J
         GyFnqH+2tS4jOGVIs4piXTBuVd+obeEmYEEim2vBpJcJfGBzemFFYXH2fN9biU0IH0F7
         edOmuJsFkVaaE3XTlWbitBY/cfr+bGHvivh5qWHnM6fjdWbc0jAmd/t2XZxZmbv56qlG
         FeuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760854638; x=1761459438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7G7V2lDPyVtB8Vl6uN0jxj375YUrl6r66ag/KY1fjtA=;
        b=lYCZZosytsb6p5o2Wgm3hN+rT+tF+I1CI0SQV147xX0vwD6wZxYKBnQKRQJGoclfEu
         SkJ3wSShNuiCnI12ISriadXdmzEgfIryV4RTfEbaNHvXMn4mNjRWMVWVr0znNauT+/Ze
         fWI6kc2jyoMV5yjyPYt6AeOWTIJFSgRH+Ahv6+5GX+mae476+roCtdyiYff+UdS36IJF
         6ZfqzY95D0VSu2XLOd+To1s/alM0y2C2a805ZfnliBgheecmvIhZ4XiKMQICIhIhuwh9
         llDr1XGBPygefE5+HB3RfMeJxhgFL26yuxb9vO+rIvgOYO1Ola+fzNhfrGqXJqTDUZkT
         vWIQ==
X-Gm-Message-State: AOJu0Yy4kHliLph3YDJl379jbSvPcIn22IJNUDCIP2JPumQdmHfnA3WH
	Y7SCDKyLyiqJSy3zbjw7RQfiNMp/SIgTF0Et42FcEG8k1M4FFUh/N/JO8aKASA==
X-Gm-Gg: ASbGncsVsWz2xAMn4gbFcl/jCyBhtOwnEXwpCBAY+QIFveUnlmRyQqyUN1Za+flTl7W
	LQSnyxW9Xo32ltC7yyxk3RNsVXUCUKsAleG8HfBJW4fbyuuqp8zK+8ioTn/K58yO6o/eX3izeX7
	UsKzCFH+fBfbJo/zmPZ0hojyucXKcxvfZcsFzG23fT8M46NSOwKvdOX7hWkBwRuhzLhnCODdbvC
	m6EoVYKmMq7qh4STfELTzWU9e4tTboEu128hIqYUClqncjcGy05DB/PjYH54eyzi6r4gbqekqZi
	pNaHYOsfNhnoOCGHyb/mWI8G2TDjE//EB8VitQ8WeIhyF3YqTYtlhJ4dGg0RwNaaT+EKalFgbA7
	/Abg3hD6oLSQCEZkh+tzru4aFNiJv8zZ4k9DYwKiKzTLOwpCTg9IXw6nildPuIFkRNVGJVtMPoX
	VUBnov
X-Google-Smtp-Source: AGHT+IEZPNwGCn+AJA9HvXAr3esIQDClPANaOupRBhLiMvPnsKQncqIOyoMxe8b/clUUmIYj68gmRg==
X-Received: by 2002:a17:90b:3911:b0:335:2eef:4ca8 with SMTP id 98e67ed59e1d1-33bcf91b8demr14755422a91.33.1760854638154;
        Sat, 18 Oct 2025 23:17:18 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:bc87:d8fe:3e55:7ffb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b6f302sm4332032a12.38.2025.10.18.23.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 23:17:17 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: jiri@resnulli.us,
	stefanha@redhat.com,
	multikernel@lists.linux.dev,
	pasha.tatashin@soleen.com,
	Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [RFC Patch v2 13/16] kernel: Introduce generic multikernel IPI communication framework
Date: Sat, 18 Oct 2025 23:16:27 -0700
Message-Id: <20251019061631.2235405-14-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
References: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
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
- Shared memory infrastructure on top of the general per-instance memory
  allocation infrastructure
- Per-instance data buffers in shared memory for efficient IPI payload
  transfer up to 256 bytes per message
- IRQ work integration for safe callback execution in interrupt context
- PFN-based flexible shared memory APIs for page-level data sharing
- Resource tracking integration for /proc/iomem visibility

It provides the key API multikernel_send_ipi_data() for sending
typed data to target kernel instance and multikernel_register_handler()
for registering IPI handler. Shared memory is established on top of the
per-instance memory allocation infra.

This infrastructure enables multikernel instances to coordinate and
share data while maintaining isolation on their respective CPU cores.

(Note, as a proof-of-concept, we have only implemented the x86 part.)

Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 arch/x86/kernel/smp.c       |   3 +
 include/linux/multikernel.h |  66 +++++
 kernel/multikernel/Makefile |   2 +-
 kernel/multikernel/ipi.c    | 471 ++++++++++++++++++++++++++++++++++++
 4 files changed, 541 insertions(+), 1 deletion(-)
 create mode 100644 kernel/multikernel/ipi.c

diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index e2eba09da7fc..2be7c1a777ef 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -273,10 +273,13 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_call_function_single)
 }
 
 #ifdef CONFIG_MULTIKERNEL
+void generic_multikernel_interrupt(void);
+
 DEFINE_IDTENTRY_SYSVEC(sysvec_multikernel)
 {
 	apic_eoi();
 	inc_irq_stat(irq_call_count);
+	generic_multikernel_interrupt();
 }
 #endif /* CONFIG_MULTIKERNEL */
 
diff --git a/include/linux/multikernel.h b/include/linux/multikernel.h
index 79611923649e..ee96bd2332b6 100644
--- a/include/linux/multikernel.h
+++ b/include/linux/multikernel.h
@@ -14,6 +14,72 @@
 #include <linux/cpumask.h>
 #include <linux/genalloc.h>
 
+/**
+ * Multikernel IPI interface
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
+	unsigned int ipi_type;       /* IPI type this handler is registered for */
+	struct mk_ipi_handler *next;
+	struct mk_ipi_data *saved_data;
+	struct irq_work work;
+};
+
+/**
+ * multikernel_register_handler - Register a callback for multikernel IPI
+ * @callback: Function to call when IPI is received
+ * @ctx: Context pointer passed to the callback
+ * @ipi_type: IPI type this handler should process
+ *
+ * Returns pointer to handler on success, NULL on failure
+ */
+struct mk_ipi_handler *multikernel_register_handler(mk_ipi_callback_t callback, void *ctx, unsigned int ipi_type);
+
+/**
+ * multikernel_unregister_handler - Unregister a multikernel IPI callback
+ * @handler: Handler pointer returned from multikernel_register_handler
+ */
+void multikernel_unregister_handler(struct mk_ipi_handler *handler);
+
+/**
+ * multikernel_send_ipi_data - Send data to another CPU via IPI
+ * @instance_id: Target multikernel instance ID
+ * @data: Pointer to data to send
+ * @data_size: Size of data
+ * @type: User-defined type identifier
+ *
+ * This function copies the data to per-CPU storage and sends an IPI
+ * to the target CPU.
+ *
+ * Returns 0 on success, negative error code on failure
+ */
+int multikernel_send_ipi_data(int instance_id, void *data, size_t data_size, unsigned long type);
+
+void generic_multikernel_interrupt(void);
+
+/* Flexible shared memory APIs (PFN-based) */
+int mk_send_pfn(int instance_id, unsigned long pfn);
+int mk_receive_pfn(struct mk_ipi_data *data, unsigned long *out_pfn);
+void *mk_receive_map_page(struct mk_ipi_data *data);
+
+#define mk_receive_unmap_page(p) memunmap(p)
+
 struct resource;
 
 extern phys_addr_t multikernel_alloc(size_t size);
diff --git a/kernel/multikernel/Makefile b/kernel/multikernel/Makefile
index d004c577f13d..b539acc656c6 100644
--- a/kernel/multikernel/Makefile
+++ b/kernel/multikernel/Makefile
@@ -3,7 +3,7 @@
 # Makefile for multikernel support
 #
 
-obj-y += core.o mem.o kernfs.o dts.o
+obj-y += core.o mem.o kernfs.o dts.o ipi.o
 
 # Add libfdt include path for device tree parsing
 CFLAGS_dts.o = -I $(srctree)/scripts/dtc/libfdt
diff --git a/kernel/multikernel/ipi.c b/kernel/multikernel/ipi.c
new file mode 100644
index 000000000000..b5c4a06747a2
--- /dev/null
+++ b/kernel/multikernel/ipi.c
@@ -0,0 +1,471 @@
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
+
+/* Per-instance IPI data - no more global variables */
+struct mk_instance_ipi_data {
+	void *instance_pool;           /* Instance pool handle */
+	struct mk_shared_data *shared_mem;  /* IPI shared memory for this instance */
+	size_t shared_mem_size;        /* Size of shared memory */
+};
+
+/* Shared memory structures - per-instance design */
+struct mk_shared_data {
+	struct mk_ipi_data cpu_data[NR_CPUS];  /* Data area for each CPU */
+};
+
+#define MK_MAX_INSTANCES 256
+static struct mk_instance_ipi_data *mk_instance_ipi_map[MK_MAX_INSTANCES];
+static DEFINE_SPINLOCK(mk_ipi_map_lock);
+
+static struct mk_shared_data *mk_this_kernel_ipi_data;
+static phys_addr_t mk_ipi_shared_phys_addr;
+
+/* Callback management */
+static struct mk_ipi_handler *mk_handlers;
+static raw_spinlock_t mk_handlers_lock = __RAW_SPIN_LOCK_UNLOCKED(mk_handlers_lock);
+
+static void *multikernel_alloc_ipi_buffer(void *pool_handle, size_t buffer_size);
+static void multikernel_free_ipi_buffer(void *pool_handle, void *virt_addr, size_t buffer_size);
+
+static void handler_work(struct irq_work *work)
+{
+    struct mk_ipi_handler *handler = container_of(work, struct mk_ipi_handler, work);
+    if (handler->callback)
+        handler->callback(handler->saved_data, handler->context);
+}
+
+/**
+ * mk_instance_ipi_create() - Create IPI data for a multikernel instance
+ * @instance: The multikernel instance
+ *
+ * Allocates and initializes IPI communication buffers for the given instance.
+ * Returns 0 on success, negative error code on failure.
+ */
+static int mk_instance_ipi_create(struct mk_instance *instance)
+{
+	struct mk_instance_ipi_data *ipi_data;
+	unsigned long flags;
+	int ret = 0;
+
+	if (!instance || instance->id < 0 || instance->id >= MK_MAX_INSTANCES)
+		return -EINVAL;
+
+	ipi_data = kzalloc(sizeof(*ipi_data), GFP_KERNEL);
+	if (!ipi_data)
+		return -ENOMEM;
+
+	/* Use the instance's own memory pool */
+	ipi_data->instance_pool = instance->instance_pool;
+	if (!ipi_data->instance_pool) {
+		pr_err("Instance %d has no memory pool for IPI allocation\n", instance->id);
+		kfree(ipi_data);
+		return -ENODEV;
+	}
+
+	/* Allocate IPI buffer from the instance pool */
+	ipi_data->shared_mem_size = sizeof(struct mk_shared_data);
+	ipi_data->shared_mem = multikernel_alloc_ipi_buffer(ipi_data->instance_pool,
+							    ipi_data->shared_mem_size);
+	if (!ipi_data->shared_mem) {
+		pr_err("Failed to allocate IPI shared memory for instance %d\n", instance->id);
+		kfree(ipi_data);
+		return -ENOMEM;
+	}
+
+	/* Initialize the shared memory structure */
+	memset(ipi_data->shared_mem, 0, ipi_data->shared_mem_size);
+
+	/* Register in the global map */
+	spin_lock_irqsave(&mk_ipi_map_lock, flags);
+	if (mk_instance_ipi_map[instance->id]) {
+		pr_err("IPI data already exists for instance %d\n", instance->id);
+		ret = -EEXIST;
+	} else {
+		mk_instance_ipi_map[instance->id] = ipi_data;
+	}
+	spin_unlock_irqrestore(&mk_ipi_map_lock, flags);
+
+	if (ret) {
+		multikernel_free_ipi_buffer(ipi_data->instance_pool,
+					    ipi_data->shared_mem,
+					    ipi_data->shared_mem_size);
+		kfree(ipi_data);
+		return ret;
+	}
+
+	pr_info("Created IPI data for instance %d (%s): virt=%px, size=%zu bytes\n",
+		instance->id, instance->name, ipi_data->shared_mem, ipi_data->shared_mem_size);
+
+	return 0;
+}
+
+/**
+ * mk_instance_ipi_destroy() - Destroy IPI data for a multikernel instance
+ * @instance_id: The instance ID
+ *
+ * Cleans up and frees IPI communication buffers for the given instance.
+ */
+static void mk_instance_ipi_destroy(int instance_id)
+{
+	struct mk_instance_ipi_data *ipi_data;
+	unsigned long flags;
+
+	if (instance_id < 0 || instance_id >= MK_MAX_INSTANCES)
+		return;
+
+	spin_lock_irqsave(&mk_ipi_map_lock, flags);
+	ipi_data = mk_instance_ipi_map[instance_id];
+	mk_instance_ipi_map[instance_id] = NULL;
+	spin_unlock_irqrestore(&mk_ipi_map_lock, flags);
+
+	if (!ipi_data)
+		return;
+
+	pr_debug("Destroying IPI data for instance %d\n", instance_id);
+
+	/* Free the shared memory buffer */
+	if (ipi_data->shared_mem) {
+		multikernel_free_ipi_buffer(ipi_data->instance_pool,
+					    ipi_data->shared_mem,
+					    ipi_data->shared_mem_size);
+	}
+
+	kfree(ipi_data);
+}
+
+/**
+ * mk_instance_ipi_get() - Get IPI data for a multikernel instance
+ * @instance_id: The instance ID
+ *
+ * Returns the IPI data for the given instance, or NULL if not found.
+ */
+static struct mk_instance_ipi_data *mk_instance_ipi_get(int instance_id)
+{
+	struct mk_instance_ipi_data *ipi_data;
+	unsigned long flags;
+
+	if (instance_id < 0 || instance_id >= MK_MAX_INSTANCES)
+		return NULL;
+
+	spin_lock_irqsave(&mk_ipi_map_lock, flags);
+	ipi_data = mk_instance_ipi_map[instance_id];
+	spin_unlock_irqrestore(&mk_ipi_map_lock, flags);
+
+	return ipi_data;
+}
+
+/**
+ * multikernel_register_handler - Register a callback for multikernel IPI
+ * @callback: Function to call when IPI is received
+ * @ctx: Context pointer passed to the callback
+ * @ipi_type: IPI type this handler should process
+ *
+ * Returns pointer to handler on success, NULL on failure
+ */
+struct mk_ipi_handler *multikernel_register_handler(mk_ipi_callback_t callback, void *ctx, unsigned int ipi_type)
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
+	handler->ipi_type = ipi_type;
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
+ * @instance_id: Target multikernel instance ID
+ * @data: Pointer to data to send
+ * @data_size: Size of data
+ * @type: User-defined type identifier
+ *
+ * This function copies the data to per-CPU storage and sends an IPI
+ * to the target CPU. The cpu parameter must be a physical CPU ID.
+ *
+ * Returns 0 on success, negative error code on failure
+ */
+int multikernel_send_ipi_data(int instance_id, void *data, size_t data_size, unsigned long type)
+{
+	struct mk_instance_ipi_data *ipi_data;
+	struct mk_ipi_data *target;
+	struct mk_instance *instance = mk_instance_find(instance_id);
+	int cpu ;
+
+	if (!instance)
+		return -EINVAL;
+	if (data_size > MK_MAX_DATA_SIZE)
+		return -EINVAL;
+
+	cpu = cpumask_first(instance->cpus);
+	/* Get the IPI data for the target instance */
+	ipi_data = mk_instance_ipi_get(instance_id);
+	if (!ipi_data || !ipi_data->shared_mem) {
+		pr_debug("Multikernel IPI shared memory not available for instance %d\n", instance_id);
+		return -ENODEV;
+	}
+
+	/* Get target CPU's data area from shared memory */
+	target = &ipi_data->shared_mem->cpu_data[cpu];
+
+	/* Initialize/clear the IPI data structure to prevent stale data */
+	memset(target, 0, sizeof(*target));
+
+	/* Set header information */
+	target->data_size = data_size;
+	target->sender_cpu = arch_cpu_physical_id(smp_processor_id());
+	target->type = type;
+
+	/* Copy the actual data into the buffer */
+	if (data && data_size > 0)
+		memcpy(target->buffer, data, data_size);
+
+	/* Send IPI to target CPU using physical CPU ID */
+	__apic_send_IPI(cpu, MULTIKERNEL_VECTOR);
+
+	return 0;
+}
+
+/**
+ * multikernel_interrupt_handler - Handle the multikernel IPI
+ *
+ * This function is called when a multikernel IPI is received.
+ * It invokes all registered callbacks with the per-CPU data.
+ *
+ * In spawned kernels, we use the shared IPI data passed via boot parameter.
+ * In host kernels, we may need to check instance mappings.
+ */
+static void multikernel_interrupt_handler(void)
+{
+	struct mk_ipi_data *data;
+	struct mk_ipi_handler *handler;
+	int current_cpu = smp_processor_id();
+	int current_physical_id = arch_cpu_physical_id(current_cpu);
+
+	if (!mk_this_kernel_ipi_data)
+		return;
+
+	data = &mk_this_kernel_ipi_data->cpu_data[current_physical_id];
+
+	if (data->data_size == 0 || data->data_size > MK_MAX_DATA_SIZE) {
+		pr_debug("Multikernel IPI received on CPU %d but no valid data\n", current_cpu);
+		return;
+	}
+
+	pr_info("Multikernel IPI received on CPU %d (physical id %d) from CPU %d type=%u\n",
+		current_cpu, current_physical_id, data->sender_cpu, data->type);
+
+	raw_spin_lock(&mk_handlers_lock);
+	for (handler = mk_handlers; handler; handler = handler->next) {
+		if (handler->ipi_type == data->type) {
+			handler->saved_data = data;
+			irq_work_queue(&handler->work);
+		}
+	}
+	raw_spin_unlock(&mk_handlers_lock);
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
+ * multikernel_alloc_ipi_buffer() - Allocate IPI communication buffer
+ * @pool_handle: Instance pool handle
+ * @buffer_size: Size of IPI buffer needed
+ *
+ * Allocates and maps a buffer suitable for IPI communication.
+ * Returns virtual address of mapped buffer, or NULL on failure.
+ */
+static void *multikernel_alloc_ipi_buffer(void *pool_handle, size_t buffer_size)
+{
+	phys_addr_t phys_addr;
+	void *virt_addr;
+
+	phys_addr = multikernel_instance_alloc(pool_handle, buffer_size, PAGE_SIZE);
+	if (!phys_addr) {
+		pr_err("Failed to allocate %zu bytes for IPI buffer\n", buffer_size);
+		return NULL;
+	}
+
+	/* Map to virtual address space */
+	virt_addr = memremap(phys_addr, buffer_size, MEMREMAP_WB);
+	if (!virt_addr) {
+		pr_err("Failed to map IPI buffer at 0x%llx\n", (unsigned long long)phys_addr);
+		multikernel_instance_free(pool_handle, phys_addr, buffer_size);
+		return NULL;
+	}
+
+	pr_debug("Allocated IPI buffer: phys=0x%llx, virt=%px, size=%zu\n",
+		 (unsigned long long)phys_addr, virt_addr, buffer_size);
+
+	return virt_addr;
+}
+
+/**
+ * multikernel_free_ipi_buffer() - Free IPI communication buffer
+ * @pool_handle: Instance pool handle
+ * @virt_addr: Virtual address returned by multikernel_alloc_ipi_buffer()
+ * @buffer_size: Size of the buffer
+ *
+ * Unmaps and frees an IPI buffer back to the instance pool.
+ */
+static void multikernel_free_ipi_buffer(void *pool_handle, void *virt_addr, size_t buffer_size)
+{
+	phys_addr_t phys_addr;
+
+	if (!virt_addr)
+		return;
+
+	/* Convert virtual address back to physical */
+	phys_addr = virt_to_phys(virt_addr);
+
+	/* Unmap virtual address */
+	memunmap(virt_addr);
+
+	/* Free back to instance pool */
+	multikernel_instance_free(pool_handle, phys_addr, buffer_size);
+
+	pr_debug("Freed IPI buffer: phys=0x%llx, virt=%px, size=%zu\n",
+		 (unsigned long long)phys_addr, virt_addr, buffer_size);
+}
+
+static int __init mk_ipi_shared_setup(char *str)
+{
+	if (!str)
+		return -EINVAL;
+
+	mk_ipi_shared_phys_addr = memparse(str, NULL);
+	if (!mk_ipi_shared_phys_addr) {
+		pr_err("Invalid multikernel IPI shared memory address: %s\n", str);
+		return -EINVAL;
+	}
+
+	pr_info("Multikernel IPI shared memory address: 0x%llx\n",
+		(unsigned long long)mk_ipi_shared_phys_addr);
+	return 0;
+}
+early_param("mk_ipi_shared", mk_ipi_shared_setup);
+
+/**
+ * multikernel_ipi_init - Initialize multikernel IPI subsystem
+ *
+ * Sets up IPI handling infrastructure.
+ * - In spawned kernels: IPI buffer is mapped from boot parameter address
+ * Returns 0 on success, negative error code on failure
+ */
+static int __init multikernel_ipi_init(void)
+{
+	/* Check if we're in a spawned kernel with IPI shared memory address */
+	if (mk_ipi_shared_phys_addr) {
+		/* Spawned kernel: Map the shared IPI memory */
+		mk_this_kernel_ipi_data = memremap(mk_ipi_shared_phys_addr,
+						   sizeof(struct mk_shared_data),
+						   MEMREMAP_WB);
+		if (!mk_this_kernel_ipi_data) {
+			pr_err("Failed to map multikernel IPI shared memory at 0x%llx\n",
+			       (unsigned long long)mk_ipi_shared_phys_addr);
+			return -ENOMEM;
+		}
+
+		pr_info("Multikernel IPI subsystem initialized (spawned kernel): virt=%px, phys=0x%llx\n",
+			mk_this_kernel_ipi_data, (unsigned long long)mk_ipi_shared_phys_addr);
+	}
+
+	return 0;
+}
+subsys_initcall(multikernel_ipi_init);
+
+/* ---- Flexible shared memory APIs (PFN-based) ---- */
+#define MK_PFN_IPI_TYPE 0x80000001U
+
+/* Send a PFN to another kernel via mk_ipi_data */
+int mk_send_pfn(int instance_id, unsigned long pfn)
+{
+	return multikernel_send_ipi_data(instance_id, &pfn, sizeof(pfn), MK_PFN_IPI_TYPE);
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



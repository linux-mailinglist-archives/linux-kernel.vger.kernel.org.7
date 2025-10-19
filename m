Return-Path: <linux-kernel+bounces-859553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD5FBEDEFB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 08:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 202EA189C8B7
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 06:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6145623ED5B;
	Sun, 19 Oct 2025 06:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFEKNO2D"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6107722A4F6
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 06:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760854643; cv=none; b=cTy7eJTY3Cjlg/e357DzbvnR2sQZtdOkq46p6frtFeZuNnGEygsd1P0T5Q5IuGXh4wjMzRIb8IAmz1FZMP+x2F1mqVBPRd5wQYPfizPfzPHzS/3Cxras5V8jJmGh149ClK+KeAa83ts8qqcfaRmQUsHt5NvlWIHHhhMhYyy5JPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760854643; c=relaxed/simple;
	bh=5oG/W7+AjQECFaMZeXzqwLytcSMcahei8cfhOku/1+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m8WnSf2hoeMlNcNMqDAr1cGEZRDn/e0gzfJbFTK0KCI2O3FMrJuwzeb4CnRWjW3h1eBmJYbLclhQUakfHInTYPIaLC1Wincx3Uqx/Kilds+jmzCtEThz9IY2sL2bMJC++QTzs21nzZz2guAQFSpZFtHBQJXdeGaLvbIzNqFkCV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFEKNO2D; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-33ba37b3ff7so3071769a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 23:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760854640; x=1761459440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGfWBR5gpu5BpcnPXBhslXXLKaWQISUn3yoh9fDkD14=;
        b=hFEKNO2DyD4Ljr2UIaT9WrlPRkYzgpvkwQM+e2OJ4kt0x6+u2qIOE64O8AOvSotpjx
         lOcR3sYSqK3AlgPhC3Eh9/I5hNGr1jv5/jVyJZcUdyZYvwa6ol44RwORvD92KBN2HwE6
         ZfNDRLiqBrvqycFHpNeprkIJ/oW3RSi4xMVvtreAYwLc6cMDUe7ckf/oFz6zpuRsKEBS
         KH53ZZPwyLrZsbShZhX+xAGinC0jIQFp9bfb/7uPo1HTNOackOmi/Ga+qbsPmu90ZREQ
         13YWCWchv9sF7D5mBW4GTWby3IY6LsT55SrAAngEiTnZFl4YyBLOCTt6YA4nlzwURtis
         uE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760854640; x=1761459440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGfWBR5gpu5BpcnPXBhslXXLKaWQISUn3yoh9fDkD14=;
        b=Kir5Pyqs3QRCNbz/tNmiLl/jQCYik2dtL+3GawCJ8DX/FqBlRbLysIqEC3WuV+AX2q
         zF8y06SaaYGQHha1vzN1Q/DNWzSaAgSGTq+E4BL+tnLGZuNDglctzkCUnpt9bioyFKI2
         wT+eL4a3m6sL8iyBob2HBGBBBukYwVX9wOCnupXiuT4gRDr2ReIqrSC53iK0AuA2K3Wj
         Mu6AIj2LLEYGslYxAee3YaB+z5YwsMi9X7j/rn6gWOFRsanG/I9RVSJ4VXmakeFXp9hO
         8nqWQYG7M3QJqwxGCeVB/79DqBHslUYNariarF/J9WyPFSkHbA/AXlZ6sX/CN0hbmbUY
         sXjg==
X-Gm-Message-State: AOJu0Yw+kmhJqt/KAtNqA7I0Dx9xSkaCv1DeP8UMsB0OtP2TK74bwqov
	+gY+CExSMr9YBIqVTy2fKwpzuKxyAPs5kKvdBfOVfsoblDLTD9XHsmXW01YxFQ==
X-Gm-Gg: ASbGncsQaJWjcIDoQ5uLQj9tNN5hRpchzviVvOSQRQBJb0owxvs5uRhGklhGQ93Epo3
	ivCHj/k/5KhqHrJ0CWP2yS92c7+M919tbpWBFDJLEFFgWZcIaX+R0+jqR4+4Kph2audReNxYaaE
	KxYbNLpviLmU1l7qAvYaiY/czzIZc7uHZrFJXHLFPb7iGH6drzNhc+fC/qXtFcVSoFSSYPP7YrR
	95CFy2mJqiFcBrZ25PXhUeTKHfcAjXhdeZ7sybc9rzf8k7VbfNTRhajpIDL9/XcfmgK9yP0+sUS
	UY8a1sXH1mXLt2RfwPk5Uq2wAkMfb7BoQEjsl1T9Jf2vsiWUgbVOwPKiuJHXNh+/IVJWRkh7zUv
	7TObkmE5g+gRZKOd6e25a9LFsjG465rYhmYSbVfkAz5z9hbq7pt4PNckLkcphl92pcDp46y1dE5
	vRAIMO
X-Google-Smtp-Source: AGHT+IFB/9N4hWxuPbcz7xQxYSDMcrE9Ap+mI0ELEadewX8FBE7rytwKC4P01IfgOC+LAL66fL2HMg==
X-Received: by 2002:a17:90b:3512:b0:32e:7ff6:6dbd with SMTP id 98e67ed59e1d1-33bc9aa6e69mr13206379a91.0.1760854640156;
        Sat, 18 Oct 2025 23:17:20 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:bc87:d8fe:3e55:7ffb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b6f302sm4332032a12.38.2025.10.18.23.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 23:17:19 -0700 (PDT)
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
Subject: [RFC Patch v2 14/16] multikernel: Add messaging layer for inter-kernel communication
Date: Sat, 18 Oct 2025 23:16:28 -0700
Message-Id: <20251019061631.2235405-15-xiyou.wangcong@gmail.com>
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

Introduce a structured messaging system built on top of the existing
multikernel IPI infrastructure to enable reliable communication between
kernel instances running on different CPUs.

The messaging layer provides:

* Simple message format with type/subtype hierarchy for extensibility
* Support for I/O interrupt forwarding between kernel instances
* Resource management messages for CPU and memory hotplug operations
* Type-safe payload structures with validation
* Handler registration system for message processing
* Convenient inline functions for common operations

Message types include:
- MK_MSG_IO: I/O interrupt forwarding and load balancing
- MK_MSG_RESOURCE: CPU/memory add/remove operations
- MK_MSG_SYSTEM: System-level coordination messages
- MK_MSG_USER: User-defined message types

The implementation leverages the reliable nature of intra-machine IPIs,
maintaining simplicity and performance. Messages are limited to the
existing 256-byte IPI buffer size, with larger data transfers handled
via the existing PFN-based shared memory mechanism.

This messaging foundation enables sophisticated multikernel coordination
scenarios including dynamic resource allocation, interrupt load
balancing, and system-wide state management.

Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 include/linux/multikernel.h    | 200 ++++++++++++++++++++++++
 kernel/multikernel/Makefile    |   2 +-
 kernel/multikernel/core.c      |   7 +
 kernel/multikernel/messaging.c | 278 +++++++++++++++++++++++++++++++++
 4 files changed, 486 insertions(+), 1 deletion(-)
 create mode 100644 kernel/multikernel/messaging.c

diff --git a/include/linux/multikernel.h b/include/linux/multikernel.h
index ee96bd2332b6..3bc07361145b 100644
--- a/include/linux/multikernel.h
+++ b/include/linux/multikernel.h
@@ -80,6 +80,206 @@ void *mk_receive_map_page(struct mk_ipi_data *data);
 
 #define mk_receive_unmap_page(p) memunmap(p)
 
+/*
+ * Multikernel Messaging System
+ */
+
+/**
+ * Message type definitions - organized by category
+ */
+
+/* Top-level message categories */
+#define MK_MSG_IO           0x1000
+#define MK_MSG_RESOURCE     0x2000
+#define MK_MSG_SYSTEM       0x3000
+#define MK_MSG_USER         0x4000
+
+/* I/O interrupt forwarding subtypes */
+#define MK_IO_IRQ_FORWARD   (MK_MSG_IO + 1)
+#define MK_IO_IRQ_BALANCE   (MK_MSG_IO + 2)
+#define MK_IO_IRQ_MASK      (MK_MSG_IO + 3)
+#define MK_IO_IRQ_UNMASK    (MK_MSG_IO + 4)
+
+/* Resource management subtypes */
+#define MK_RES_CPU_ADD      (MK_MSG_RESOURCE + 1)
+#define MK_RES_CPU_REMOVE   (MK_MSG_RESOURCE + 2)
+#define MK_RES_MEM_ADD      (MK_MSG_RESOURCE + 3)
+#define MK_RES_MEM_REMOVE   (MK_MSG_RESOURCE + 4)
+#define MK_RES_QUERY        (MK_MSG_RESOURCE + 5)
+
+/* System management subtypes */
+#define MK_SYS_HEARTBEAT    (MK_MSG_SYSTEM + 1)
+#define MK_SYS_SHUTDOWN     (MK_MSG_SYSTEM + 2)
+
+/**
+ * Core message structure
+ */
+struct mk_message {
+	u32 msg_type;           /* Message type identifier */
+	u32 msg_subtype;        /* Subtype for specific operations */
+	u64 msg_id;             /* Optional message ID for correlation */
+	u32 payload_len;        /* Length of payload data */
+	u8 payload[];           /* Variable payload (up to remaining IPI buffer) */
+};
+
+/**
+ * Payload structures for specific message types
+ */
+
+/* I/O interrupt forwarding */
+struct mk_io_irq_payload {
+	u32 irq_number;         /* Hardware IRQ number */
+	u32 vector;             /* Interrupt vector */
+	u32 device_id;          /* Device identifier (optional) */
+	u32 flags;              /* Control flags (priority, etc.) */
+};
+
+/* IRQ control flags */
+#define MK_IRQ_HIGH_PRIORITY    0x01
+#define MK_IRQ_LOW_LATENCY      0x02
+#define MK_IRQ_EDGE_TRIGGERED   0x04
+#define MK_IRQ_LEVEL_TRIGGERED  0x08
+
+/* CPU resource operations */
+struct mk_cpu_resource_payload {
+	u32 cpu_id;             /* Physical CPU ID */
+	u32 numa_node;          /* NUMA node (optional) */
+	u32 flags;              /* CPU capabilities/attributes */
+};
+
+/* CPU capability flags */
+#define MK_CPU_HAS_AVX512       0x01
+#define MK_CPU_HAS_TSX          0x02
+#define MK_CPU_HYPERTHREAD      0x04
+
+/* Memory resource operations */
+struct mk_mem_resource_payload {
+	u64 start_pfn;          /* Starting page frame number */
+	u64 nr_pages;           /* Number of pages */
+	u32 numa_node;          /* NUMA node */
+	u32 mem_type;           /* Memory type (normal/DMA/etc.) */
+};
+
+/* Memory types */
+#define MK_MEM_NORMAL           0x01
+#define MK_MEM_DMA              0x02
+#define MK_MEM_DMA32            0x04
+#define MK_MEM_HIGHMEM          0x08
+
+/**
+ * Message handler callback type
+ */
+typedef void (*mk_msg_handler_t)(u32 msg_type, u32 subtype,
+				 void *payload, u32 payload_len, void *ctx);
+
+/**
+ * Message API functions
+ */
+
+/**
+ * mk_send_message - Send a message to another CPU
+ * @instance_id: Target multikernel instance ID
+ * @msg_type: Message type identifier
+ * @subtype: Message subtype
+ * @payload: Pointer to payload data (can be NULL)
+ * @payload_len: Length of payload data
+ *
+ * Returns 0 on success, negative error code on failure
+ */
+int mk_send_message(int instance_id, u32 msg_type, u32 subtype,
+		    void *payload, u32 payload_len);
+
+/**
+ * mk_register_msg_handler - Register handler for specific message type
+ * @msg_type: Message type to handle
+ * @handler: Handler function
+ * @ctx: Context pointer passed to handler
+ *
+ * Returns 0 on success, negative error code on failure
+ */
+int mk_register_msg_handler(u32 msg_type, mk_msg_handler_t handler, void *ctx);
+
+/**
+ * mk_unregister_msg_handler - Unregister message handler
+ * @msg_type: Message type to unregister
+ * @handler: Handler function to remove
+ *
+ * Returns 0 on success, negative error code on failure
+ */
+int mk_unregister_msg_handler(u32 msg_type, mk_msg_handler_t handler);
+
+/**
+ * Convenience functions for common message types
+ */
+
+/* I/O interrupt forwarding */
+static inline int mk_send_irq_forward(int instance_id, u32 irq_number,
+				      u32 vector, u32 device_id, u32 flags)
+{
+	struct mk_io_irq_payload payload = {
+		.irq_number = irq_number,
+		.vector = vector,
+		.device_id = device_id,
+		.flags = flags
+	};
+	return mk_send_message(instance_id, MK_MSG_IO, MK_IO_IRQ_FORWARD,
+			       &payload, sizeof(payload));
+}
+
+/* CPU resource management */
+static inline int mk_send_cpu_add(int instance_id, u32 cpu_id,
+				  u32 numa_node, u32 flags)
+{
+	struct mk_cpu_resource_payload payload = {
+		.cpu_id = cpu_id,
+		.numa_node = numa_node,
+		.flags = flags
+	};
+	return mk_send_message(instance_id, MK_MSG_RESOURCE, MK_RES_CPU_ADD,
+			       &payload, sizeof(payload));
+}
+
+static inline int mk_send_cpu_remove(int instance_id, u32 cpu_id)
+{
+	struct mk_cpu_resource_payload payload = {
+		.cpu_id = cpu_id,
+		.numa_node = 0,
+		.flags = 0
+	};
+	return mk_send_message(instance_id, MK_MSG_RESOURCE, MK_RES_CPU_REMOVE,
+			       &payload, sizeof(payload));
+}
+
+/* Memory resource management */
+static inline int mk_send_mem_add(int instance_id, u64 start_pfn, u64 nr_pages,
+				  u32 numa_node, u32 mem_type)
+{
+	struct mk_mem_resource_payload payload = {
+		.start_pfn = start_pfn,
+		.nr_pages = nr_pages,
+		.numa_node = numa_node,
+		.mem_type = mem_type
+	};
+	return mk_send_message(instance_id, MK_MSG_RESOURCE, MK_RES_MEM_ADD,
+			       &payload, sizeof(payload));
+}
+
+static inline int mk_send_mem_remove(int instance_id, u64 start_pfn, u64 nr_pages)
+{
+	struct mk_mem_resource_payload payload = {
+		.start_pfn = start_pfn,
+		.nr_pages = nr_pages,
+		.numa_node = 0,
+		.mem_type = 0
+	};
+	return mk_send_message(instance_id, MK_MSG_RESOURCE, MK_RES_MEM_REMOVE,
+			       &payload, sizeof(payload));
+}
+
+/* Messaging system functions */
+int __init mk_messaging_init(void);
+void mk_messaging_cleanup(void);
+
 struct resource;
 
 extern phys_addr_t multikernel_alloc(size_t size);
diff --git a/kernel/multikernel/Makefile b/kernel/multikernel/Makefile
index b539acc656c6..f133e1eaf534 100644
--- a/kernel/multikernel/Makefile
+++ b/kernel/multikernel/Makefile
@@ -3,7 +3,7 @@
 # Makefile for multikernel support
 #
 
-obj-y += core.o mem.o kernfs.o dts.o ipi.o
+obj-y += core.o mem.o kernfs.o dts.o ipi.o messaging.o
 
 # Add libfdt include path for device tree parsing
 CFLAGS_dts.o = -I $(srctree)/scripts/dtc/libfdt
diff --git a/kernel/multikernel/core.c b/kernel/multikernel/core.c
index ee7a21327ea5..37dbf0cf4be6 100644
--- a/kernel/multikernel/core.c
+++ b/kernel/multikernel/core.c
@@ -505,9 +505,16 @@ static int __init multikernel_init(void)
 {
 	int ret;
 
+	ret = mk_messaging_init();
+	if (ret < 0) {
+		pr_err("Failed to initialize multikernel messaging: %d\n", ret);
+		return ret;
+	}
+
 	ret = mk_kernfs_init();
 	if (ret < 0) {
 		pr_err("Failed to initialize multikernel sysfs interface: %d\n", ret);
+		mk_messaging_cleanup();
 		return ret;
 	}
 
diff --git a/kernel/multikernel/messaging.c b/kernel/multikernel/messaging.c
new file mode 100644
index 000000000000..be1fba8778ec
--- /dev/null
+++ b/kernel/multikernel/messaging.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Multikernel Messaging System
+ * Copyright (C) 2025 Multikernel Technologies, Inc. All rights reserved
+ *
+ * Simple messaging layer on top of multikernel IPI infrastructure
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/multikernel.h>
+
+/* Per-type message handler registry */
+struct mk_msg_type_handler {
+	u32 msg_type;
+	struct mk_ipi_handler *ipi_handler;
+	mk_msg_handler_t msg_handler;
+	void *context;
+	struct mk_msg_type_handler *next;
+};
+
+static struct mk_msg_type_handler *mk_msg_type_handlers;
+static raw_spinlock_t mk_msg_type_handlers_lock = __RAW_SPIN_LOCK_UNLOCKED(mk_msg_type_handlers_lock);
+
+/**
+ * mk_message_type_ipi_callback - IPI callback to handle incoming messages for a specific type
+ * @data: IPI data containing the message
+ * @ctx: Context containing the message handler info
+ */
+static void mk_message_type_ipi_callback(struct mk_ipi_data *data, void *ctx)
+{
+	struct mk_msg_type_handler *type_handler = (struct mk_msg_type_handler *)ctx;
+	struct mk_message *msg;
+	u32 msg_type, msg_subtype;
+	void *payload;
+	u32 payload_len;
+
+	if (!type_handler || !type_handler->msg_handler) {
+		pr_warn("Multikernel message received but no handler registered\n");
+		return;
+	}
+
+	/* Verify this matches our expected message type */
+	if (data->type != type_handler->msg_type) {
+		pr_warn("Multikernel message type mismatch: expected 0x%x, got 0x%x\n",
+			type_handler->msg_type, data->type);
+		return;
+	}
+
+	/* Ensure we have at least a message header */
+	if (data->data_size < sizeof(struct mk_message)) {
+		pr_warn("Multikernel message too small: %zu bytes\n", data->data_size);
+		return;
+	}
+
+	msg = (struct mk_message *)data->buffer;
+
+	/* Validate message structure */
+	if (msg->payload_len > (data->data_size - sizeof(struct mk_message))) {
+		pr_warn("Multikernel message payload length invalid: %u > %zu\n",
+			msg->payload_len, data->data_size - sizeof(struct mk_message));
+		return;
+	}
+
+	msg_type = msg->msg_type;
+	msg_subtype = msg->msg_subtype;
+	payload = msg->payload_len > 0 ? msg->payload : NULL;
+	payload_len = msg->payload_len;
+
+	pr_debug("Multikernel message received: type=0x%x, subtype=0x%x, len=%u from CPU %d\n",
+		 msg_type, msg_subtype, payload_len, data->sender_cpu);
+
+	/* Call the registered handler for this message type */
+	type_handler->msg_handler(msg_type, msg_subtype, payload, payload_len, type_handler->context);
+}
+
+/**
+ * mk_send_message - Send a message to another CPU
+ * @instance_id: Target multikernel instance ID
+ * @msg_type: Message type identifier
+ * @subtype: Message subtype
+ * @payload: Pointer to payload data (can be NULL)
+ * @payload_len: Length of payload data
+ *
+ * Returns 0 on success, negative error code on failure
+ */
+int mk_send_message(int instance_id, u32 msg_type, u32 subtype,
+		    void *payload, u32 payload_len)
+{
+	struct mk_message *msg;
+	size_t total_size;
+	int ret;
+
+	/* Calculate total message size */
+	total_size = sizeof(struct mk_message) + payload_len;
+
+	/* Check if message fits in IPI buffer */
+	if (total_size > MK_MAX_DATA_SIZE) {
+		pr_err("Multikernel message too large: %zu > %d bytes\n",
+		       total_size, MK_MAX_DATA_SIZE);
+		return -EMSGSIZE;
+	}
+
+	/* Allocate temporary buffer for message */
+	msg = kzalloc(total_size, GFP_ATOMIC);
+	if (!msg)
+		return -ENOMEM;
+
+	/* Fill in message header */
+	msg->msg_type = msg_type;
+	msg->msg_subtype = subtype;
+	msg->msg_id = 0; /* Could be enhanced with unique IDs later */
+	msg->payload_len = payload_len;
+
+	/* Copy payload if provided */
+	if (payload && payload_len > 0)
+		memcpy(msg->payload, payload, payload_len);
+
+	/* Send via IPI using the message type as IPI type */
+	ret = multikernel_send_ipi_data(instance_id, msg, total_size, msg_type);
+
+	/* Clean up temporary buffer */
+	kfree(msg);
+
+	if (ret < 0) {
+		pr_err("Failed to send multikernel message: %d\n", ret);
+		return ret;
+	}
+
+	pr_debug("Multikernel message sent: type=0x%x, subtype=0x%x, len=%u to instance %d\n",
+		 msg_type, subtype, payload_len, instance_id);
+
+	return 0;
+}
+EXPORT_SYMBOL(mk_send_message);
+
+/**
+ * mk_register_msg_handler - Register handler for specific message type
+ * @msg_type: Message type to handle
+ * @handler: Handler function
+ * @ctx: Context pointer passed to handler
+ *
+ * Returns 0 on success, negative error code on failure
+ */
+int mk_register_msg_handler(u32 msg_type, mk_msg_handler_t handler, void *ctx)
+{
+	struct mk_msg_type_handler *type_handler;
+	unsigned long flags;
+
+	if (!handler)
+		return -EINVAL;
+
+	/* Check if handler for this type already exists */
+	raw_spin_lock_irqsave(&mk_msg_type_handlers_lock, flags);
+	for (type_handler = mk_msg_type_handlers; type_handler; type_handler = type_handler->next) {
+		if (type_handler->msg_type == msg_type) {
+			raw_spin_unlock_irqrestore(&mk_msg_type_handlers_lock, flags);
+			pr_warn("Handler for message type 0x%x already registered\n", msg_type);
+			return -EEXIST;
+		}
+	}
+	raw_spin_unlock_irqrestore(&mk_msg_type_handlers_lock, flags);
+
+	/* Allocate new type handler entry */
+	type_handler = kzalloc(sizeof(*type_handler), GFP_KERNEL);
+	if (!type_handler)
+		return -ENOMEM;
+
+	type_handler->msg_type = msg_type;
+	type_handler->msg_handler = handler;
+	type_handler->context = ctx;
+
+	/* Register IPI handler for this message type */
+	type_handler->ipi_handler = multikernel_register_handler(mk_message_type_ipi_callback,
+									 type_handler, msg_type);
+	if (!type_handler->ipi_handler) {
+		pr_err("Failed to register IPI handler for message type 0x%x\n", msg_type);
+		kfree(type_handler);
+		return -ENOMEM;
+	}
+
+	/* Add to type handler list */
+	raw_spin_lock_irqsave(&mk_msg_type_handlers_lock, flags);
+	type_handler->next = mk_msg_type_handlers;
+	mk_msg_type_handlers = type_handler;
+	raw_spin_unlock_irqrestore(&mk_msg_type_handlers_lock, flags);
+
+	pr_debug("Registered multikernel message handler for type 0x%x\n", msg_type);
+	return 0;
+}
+EXPORT_SYMBOL(mk_register_msg_handler);
+
+/**
+ * mk_unregister_msg_handler - Unregister message handler
+ * @msg_type: Message type to unregister
+ * @handler: Handler function to remove
+ *
+ * Returns 0 on success, negative error code on failure
+ */
+int mk_unregister_msg_handler(u32 msg_type, mk_msg_handler_t handler)
+{
+	struct mk_msg_type_handler **pp, *type_handler;
+	unsigned long flags;
+	int found = 0;
+
+	if (!handler)
+		return -EINVAL;
+
+	raw_spin_lock_irqsave(&mk_msg_type_handlers_lock, flags);
+	pp = &mk_msg_type_handlers;
+	while ((type_handler = *pp) != NULL) {
+		if (type_handler->msg_type == msg_type && type_handler->msg_handler == handler) {
+			*pp = type_handler->next;
+			found = 1;
+			break;
+		}
+		pp = &type_handler->next;
+	}
+	raw_spin_unlock_irqrestore(&mk_msg_type_handlers_lock, flags);
+
+	if (found) {
+		/* Unregister the IPI handler */
+		if (type_handler->ipi_handler) {
+			multikernel_unregister_handler(type_handler->ipi_handler);
+		}
+		kfree(type_handler);
+		pr_debug("Unregistered multikernel message handler for type 0x%x\n", msg_type);
+		return 0;
+	}
+
+	return -ENOENT;
+}
+EXPORT_SYMBOL(mk_unregister_msg_handler);
+
+/**
+ * mk_messaging_init - Initialize the messaging system
+ *
+ * Called during multikernel initialization to set up message handling
+ * Returns 0 on success, negative error code on failure
+ */
+int __init mk_messaging_init(void)
+{
+	/* No global IPI handler needed anymore - handlers are registered per message type */
+	pr_info("Multikernel messaging system initialized\n");
+	return 0;
+}
+
+/**
+ * mk_messaging_cleanup - Cleanup the messaging system
+ *
+ * Called during multikernel cleanup
+ */
+void mk_messaging_cleanup(void)
+{
+	struct mk_msg_type_handler *type_handler, *next;
+	unsigned long flags;
+
+	/* Clean up all registered message type handlers */
+	raw_spin_lock_irqsave(&mk_msg_type_handlers_lock, flags);
+	type_handler = mk_msg_type_handlers;
+	mk_msg_type_handlers = NULL;
+	raw_spin_unlock_irqrestore(&mk_msg_type_handlers_lock, flags);
+
+	while (type_handler) {
+		next = type_handler->next;
+
+		/* Unregister IPI handler */
+		if (type_handler->ipi_handler) {
+			multikernel_unregister_handler(type_handler->ipi_handler);
+		}
+
+		kfree(type_handler);
+		type_handler = next;
+	}
+
+	pr_info("Multikernel messaging system cleaned up\n");
+}
-- 
2.34.1



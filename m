Return-Path: <linux-kernel+bounces-629033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F722AA669D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 00:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F14819A5745
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 22:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6EF26B2CE;
	Thu,  1 May 2025 22:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qK5iZwkD"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E55274FEB
	for <linux-kernel@vger.kernel.org>; Thu,  1 May 2025 22:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140119; cv=none; b=MW/6KuxWjHBcucffbcrpVJmSxpERMtfpKDAo1OG2qieA+4XEzmlMDrMIA7W/cwOOvem2/R/J+s/K5qVbiSyMD75CAHAP3psHa44Pnm4qvhgSf2DgEL8j44LQrkwRsVHH8OqFqoIJLVknJT+zyhXrltPb4BUSwxR8VVY2pvCvAK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140119; c=relaxed/simple;
	bh=mNVLmvEsp7Y92TrZ0+VkTv7aWkuCTzNMNtjZ36rd/Vs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D7amMeXIT/O8tSi4b2Kc7OFKCQirldhys401kV1SnQFaTa2kuUN6N/zumwBHx1yjo/m7RUS8sI+tq7GXLdtwgi4bqTqwFgtUPe/lh+gmMBGESLjZfizMtUswFPIpKdb+qK269+5Ltsk75Z4yopY43KkyoxYdEypT2DZSBEhyTZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qK5iZwkD; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-227e2faab6dso11091805ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 May 2025 15:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746140116; x=1746744916; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zupl1H9aLf7G5k1hj5vm87fp47Gq/FC1Tr3FQey3N0A=;
        b=qK5iZwkDThpCN5vdjiq8Kx6iSXvoGRdQR3OE03Ym6okosqsqt73rbuFLfPGZrPYCmy
         TaBzbui2kjqHhRRkoSrVRXopq13bAOEGny/cUOoc9tO2w/Kvwq6sguRGYzh9/DR/nqj2
         X5yj5ngMp/xaaRiHoaKz77B5aMNZGmU/QtHuNKlrPBwbBle7b9ZkGldY2IC63293088J
         /DDAKeJHNnSjfp6N9cs3AnaM8E1+9JY+HqRy2JC/lHi5KBE2ucfYdIJrUDVPCQDinxQv
         1df/QkA1KT3nWm1HFfXz86JNHjkGf2ZIB2Xq3zxGDTxv52IOqdzMIMsXC1p0VOXnbVLD
         Jdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746140116; x=1746744916;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zupl1H9aLf7G5k1hj5vm87fp47Gq/FC1Tr3FQey3N0A=;
        b=rYdUMvRQbfahmXliC2X9Yb6KNFKu18vHpu4H/PtvZdxIwukzMG7V2HAMH7VdHQ92pn
         HWckdNxpnDEVWb9ffSv0zg2bG9WwUmTOHmuBhzIAO2bPj5kfnOGUok02Q8RwA4VY/8T1
         l7CNC5j0AcA46CVeN92WHf/xl0H2KEakk7Re6rUY8WoC35/d4BuIhBKO5kgyZ3loIS8K
         j6ashL2ukvOX/Dk0B3BhEmVwLg2acn/NQ59J1qsA29x9aaQS9JBkZL4bKGAsGV5lpfWN
         B7ULqkQooQXYyBvS/Ax5LoHS6QvADVPDFhi//yn/HXO+dPZj9DmBvz0k2bUx7dtH23XO
         msnw==
X-Gm-Message-State: AOJu0YzjOOLs5G2sx76x+fkZ9qQK0kgNCCh0+lwd/4qyCILlVVuaEuL5
	olxlC1p/DKAMdmKKvXhaIBJ/07JUxcO/vxq6lDXrthedaiPdF7KXvM0HAWWLc3h+1/k2MxOOhVj
	dpNF0XMXLYjk/QDJTFwolmiBvAVgW3KBZweGnRluWAgzS+6YykVCGa57WwRdCMuFQF4A05DoOEM
	X3YZnIWOT2zCNGFT5phQw19DXo+nZFwCdQ/QGUhAZS/T7Pp7bV4xWZy6vE9U98OA==
X-Google-Smtp-Source: AGHT+IGUaKwYD+ekicwR3fhjwfp0pcGkZlyxyUKmLzdPJuz77Z4qUX4s7GqpY+FI/e6+rctwZkVMPC4Dp59UybzV
X-Received: from plbx18.prod.google.com ([2002:a17:902:ea92:b0:220:e84e:350c])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e747:b0:21f:5cd8:c67 with SMTP id d9443c01a7336-22e1037fb6dmr9684975ad.31.1746140116224;
 Thu, 01 May 2025 15:55:16 -0700 (PDT)
Date: Thu,  1 May 2025 15:54:11 -0700
In-Reply-To: <20250501225425.635167-1-changyuanl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250501225425.635167-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250501225425.635167-5-changyuanl@google.com>
Subject: [PATCH v7 04/18] kexec: add Kexec HandOver (KHO) generation helpers
From: Changyuan Lyu <changyuanl@google.com>
To: linux-kernel@vger.kernel.org
Cc: changyuanl@google.com, akpm@linux-foundation.org, 
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com, 
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com, 
	corbet@lwn.net, dave.hansen@linux.intel.com, devicetree@vger.kernel.org, 
	dwmw2@infradead.org, ebiederm@xmission.com, graf@amazon.com, hpa@zytor.com, 
	jgowans@amazon.com, kexec@lists.infradead.org, krzk@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, luto@kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	pasha.tatashin@soleen.com, pbonzini@redhat.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh@kernel.org, rostedt@goodmis.org, rppt@kernel.org, 
	saravanak@google.com, skinsburskii@linux.microsoft.com, tglx@linutronix.de, 
	thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Alexander Graf <graf@amazon.com>

Add the infrastructure to generate Kexec HandOver metadata. Kexec
HandOver is a mechanism that allows Linux to preserve state - arbitrary
properties as well as memory locations - across kexec.

It does so using 2 concepts:

  1) KHO FDT - Every KHO kexec carries a KHO specific flattened device tree
     blob that describes preserved memory regions. Device drivers can
     register to KHO to serialize and preserve their states before kexec.

  2) Scratch Regions - CMA regions that we allocate in the first kernel.
     CMA gives us the guarantee that no handover pages land in those
     regions, because handover pages must be at a static physical memory
     location. We use these regions as the place to load future kexec
     images so that they won't collide with any handover data.

Signed-off-by: Alexander Graf <graf@amazon.com>
Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Co-developed-by: Pratyush Yadav <ptyadav@amazon.de>
Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
Co-developed-by: Changyuan Lyu <changyuanl@google.com>
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 MAINTAINERS                    |   9 +
 include/linux/kexec_handover.h |  59 ++++
 kernel/Makefile                |   1 +
 kernel/kexec_handover.c        | 557 +++++++++++++++++++++++++++++++++
 mm/mm_init.c                   |   8 +
 5 files changed, 634 insertions(+)
 create mode 100644 include/linux/kexec_handover.h
 create mode 100644 kernel/kexec_handover.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3cbf9ac0d83f6..5e2b121263437 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13138,6 +13138,15 @@ F:	include/linux/kexec.h
 F:	include/uapi/linux/kexec.h
 F:	kernel/kexec*
 
+KEXEC HANDOVER (KHO)
+M:	Alexander Graf <graf@amazon.com>
+M:	Mike Rapoport <rppt@kernel.org>
+M:	Changyuan Lyu <changyuanl@google.com>
+L:	kexec@lists.infradead.org
+S:	Maintained
+F:	include/linux/kexec_handover.h
+F:	kernel/kexec_handover.c
+
 KEYS-ENCRYPTED
 M:	Mimi Zohar <zohar@linux.ibm.com>
 L:	linux-integrity@vger.kernel.org
diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
new file mode 100644
index 0000000000000..2e19004776f6b
--- /dev/null
+++ b/include/linux/kexec_handover.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef LINUX_KEXEC_HANDOVER_H
+#define LINUX_KEXEC_HANDOVER_H
+
+#include <linux/types.h>
+#include <linux/errno.h>
+
+struct kho_scratch {
+	phys_addr_t addr;
+	phys_addr_t size;
+};
+
+/* KHO Notifier index */
+enum kho_event {
+	KEXEC_KHO_FINALIZE = 0,
+	KEXEC_KHO_ABORT = 1,
+};
+
+struct notifier_block;
+
+struct kho_serialization;
+
+#ifdef CONFIG_KEXEC_HANDOVER
+bool kho_is_enabled(void);
+
+int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt);
+
+int register_kho_notifier(struct notifier_block *nb);
+int unregister_kho_notifier(struct notifier_block *nb);
+
+void kho_memory_init(void);
+#else
+static inline bool kho_is_enabled(void)
+{
+	return false;
+}
+
+static inline int kho_add_subtree(struct kho_serialization *ser,
+				  const char *name, void *fdt)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int register_kho_notifier(struct notifier_block *nb)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int unregister_kho_notifier(struct notifier_block *nb)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void kho_memory_init(void)
+{
+}
+#endif /* CONFIG_KEXEC_HANDOVER */
+
+#endif /* LINUX_KEXEC_HANDOVER_H */
diff --git a/kernel/Makefile b/kernel/Makefile
index 434929de17ef2..97c09847db42f 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -80,6 +80,7 @@ obj-$(CONFIG_CRASH_DUMP) += crash_core.o
 obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_KEXEC_FILE) += kexec_file.o
 obj-$(CONFIG_KEXEC_ELF) += kexec_elf.o
+obj-$(CONFIG_KEXEC_HANDOVER) += kexec_handover.o
 obj-$(CONFIG_BACKTRACE_SELF_TEST) += backtracetest.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_CGROUPS) += cgroup/
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
new file mode 100644
index 0000000000000..e541d3d5003d1
--- /dev/null
+++ b/kernel/kexec_handover.c
@@ -0,0 +1,557 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * kexec_handover.c - kexec handover metadata processing
+ * Copyright (C) 2023 Alexander Graf <graf@amazon.com>
+ * Copyright (C) 2025 Microsoft Corporation, Mike Rapoport <rppt@kernel.org>
+ * Copyright (C) 2025 Google LLC, Changyuan Lyu <changyuanl@google.com>
+ */
+
+#define pr_fmt(fmt) "KHO: " fmt
+
+#include <linux/cma.h>
+#include <linux/debugfs.h>
+#include <linux/kexec.h>
+#include <linux/kexec_handover.h>
+#include <linux/libfdt.h>
+#include <linux/list.h>
+#include <linux/memblock.h>
+#include <linux/notifier.h>
+#include <linux/page-isolation.h>
+/*
+ * KHO is tightly coupled with mm init and needs access to some of mm
+ * internal APIs.
+ */
+#include "../mm/internal.h"
+
+#define KHO_FDT_COMPATIBLE "kho-v1"
+#define PROP_PRESERVED_MEMORY_MAP "preserved-memory-map"
+#define PROP_SUB_FDT "fdt"
+
+static bool kho_enable __ro_after_init;
+
+bool kho_is_enabled(void)
+{
+	return kho_enable;
+}
+EXPORT_SYMBOL_GPL(kho_is_enabled);
+
+static int __init kho_parse_enable(char *p)
+{
+	return kstrtobool(p, &kho_enable);
+}
+early_param("kho", kho_parse_enable);
+
+struct kho_serialization {
+	struct page *fdt;
+	struct list_head fdt_list;
+	struct dentry *sub_fdt_dir;
+};
+
+/*
+ * With KHO enabled, memory can become fragmented because KHO regions may
+ * be anywhere in physical address space. The scratch regions give us a
+ * safe zones that we will never see KHO allocations from. This is where we
+ * can later safely load our new kexec images into and then use the scratch
+ * area for early allocations that happen before page allocator is
+ * initialized.
+ */
+static struct kho_scratch *kho_scratch;
+static unsigned int kho_scratch_cnt;
+
+/*
+ * The scratch areas are scaled by default as percent of memory allocated from
+ * memblock. A user can override the scale with command line parameter:
+ *
+ * kho_scratch=N%
+ *
+ * It is also possible to explicitly define size for a lowmem, a global and
+ * per-node scratch areas:
+ *
+ * kho_scratch=l[KMG],n[KMG],m[KMG]
+ *
+ * The explicit size definition takes precedence over scale definition.
+ */
+static unsigned int scratch_scale __initdata = 200;
+static phys_addr_t scratch_size_global __initdata;
+static phys_addr_t scratch_size_pernode __initdata;
+static phys_addr_t scratch_size_lowmem __initdata;
+
+static int __init kho_parse_scratch_size(char *p)
+{
+	size_t len;
+	unsigned long sizes[3];
+	int i;
+
+	if (!p)
+		return -EINVAL;
+
+	len = strlen(p);
+	if (!len)
+		return -EINVAL;
+
+	/* parse nn% */
+	if (p[len - 1] == '%') {
+		/* unsigned int max is 4,294,967,295, 10 chars */
+		char s_scale[11] = {};
+		int ret = 0;
+
+		if (len > ARRAY_SIZE(s_scale))
+			return -EINVAL;
+
+		memcpy(s_scale, p, len - 1);
+		ret = kstrtouint(s_scale, 10, &scratch_scale);
+		if (!ret)
+			pr_notice("scratch scale is %d%%\n", scratch_scale);
+		return ret;
+	}
+
+	/* parse ll[KMG],mm[KMG],nn[KMG] */
+	for (i = 0; i < ARRAY_SIZE(sizes); i++) {
+		char *endp = p;
+
+		if (i > 0) {
+			if (*p != ',')
+				return -EINVAL;
+			p += 1;
+		}
+
+		sizes[i] = memparse(p, &endp);
+		if (!sizes[i] || endp == p)
+			return -EINVAL;
+		p = endp;
+	}
+
+	scratch_size_lowmem = sizes[0];
+	scratch_size_global = sizes[1];
+	scratch_size_pernode = sizes[2];
+	scratch_scale = 0;
+
+	pr_notice("scratch areas: lowmem: %lluMiB global: %lluMiB pernode: %lldMiB\n",
+		  (u64)(scratch_size_lowmem >> 20),
+		  (u64)(scratch_size_global >> 20),
+		  (u64)(scratch_size_pernode >> 20));
+
+	return 0;
+}
+early_param("kho_scratch", kho_parse_scratch_size);
+
+static void __init scratch_size_update(void)
+{
+	phys_addr_t size;
+
+	if (!scratch_scale)
+		return;
+
+	size = memblock_reserved_kern_size(ARCH_LOW_ADDRESS_LIMIT,
+					   NUMA_NO_NODE);
+	size = size * scratch_scale / 100;
+	scratch_size_lowmem = round_up(size, CMA_MIN_ALIGNMENT_BYTES);
+
+	size = memblock_reserved_kern_size(MEMBLOCK_ALLOC_ANYWHERE,
+					   NUMA_NO_NODE);
+	size = size * scratch_scale / 100 - scratch_size_lowmem;
+	scratch_size_global = round_up(size, CMA_MIN_ALIGNMENT_BYTES);
+}
+
+static phys_addr_t __init scratch_size_node(int nid)
+{
+	phys_addr_t size;
+
+	if (scratch_scale) {
+		size = memblock_reserved_kern_size(MEMBLOCK_ALLOC_ANYWHERE,
+						   nid);
+		size = size * scratch_scale / 100;
+	} else {
+		size = scratch_size_pernode;
+	}
+
+	return round_up(size, CMA_MIN_ALIGNMENT_BYTES);
+}
+
+/**
+ * kho_reserve_scratch - Reserve a contiguous chunk of memory for kexec
+ *
+ * With KHO we can preserve arbitrary pages in the system. To ensure we still
+ * have a large contiguous region of memory when we search the physical address
+ * space for target memory, let's make sure we always have a large CMA region
+ * active. This CMA region will only be used for movable pages which are not a
+ * problem for us during KHO because we can just move them somewhere else.
+ */
+static void __init kho_reserve_scratch(void)
+{
+	phys_addr_t addr, size;
+	int nid, i = 0;
+
+	if (!kho_enable)
+		return;
+
+	scratch_size_update();
+
+	/* FIXME: deal with node hot-plug/remove */
+	kho_scratch_cnt = num_online_nodes() + 2;
+	size = kho_scratch_cnt * sizeof(*kho_scratch);
+	kho_scratch = memblock_alloc(size, PAGE_SIZE);
+	if (!kho_scratch)
+		goto err_disable_kho;
+
+	/*
+	 * reserve scratch area in low memory for lowmem allocations in the
+	 * next kernel
+	 */
+	size = scratch_size_lowmem;
+	addr = memblock_phys_alloc_range(size, CMA_MIN_ALIGNMENT_BYTES, 0,
+					 ARCH_LOW_ADDRESS_LIMIT);
+	if (!addr)
+		goto err_free_scratch_desc;
+
+	kho_scratch[i].addr = addr;
+	kho_scratch[i].size = size;
+	i++;
+
+	/* reserve large contiguous area for allocations without nid */
+	size = scratch_size_global;
+	addr = memblock_phys_alloc(size, CMA_MIN_ALIGNMENT_BYTES);
+	if (!addr)
+		goto err_free_scratch_areas;
+
+	kho_scratch[i].addr = addr;
+	kho_scratch[i].size = size;
+	i++;
+
+	for_each_online_node(nid) {
+		size = scratch_size_node(nid);
+		addr = memblock_alloc_range_nid(size, CMA_MIN_ALIGNMENT_BYTES,
+						0, MEMBLOCK_ALLOC_ACCESSIBLE,
+						nid, true);
+		if (!addr)
+			goto err_free_scratch_areas;
+
+		kho_scratch[i].addr = addr;
+		kho_scratch[i].size = size;
+		i++;
+	}
+
+	return;
+
+err_free_scratch_areas:
+	for (i--; i >= 0; i--)
+		memblock_phys_free(kho_scratch[i].addr, kho_scratch[i].size);
+err_free_scratch_desc:
+	memblock_free(kho_scratch, kho_scratch_cnt * sizeof(*kho_scratch));
+err_disable_kho:
+	kho_enable = false;
+}
+
+struct fdt_debugfs {
+	struct list_head list;
+	struct debugfs_blob_wrapper wrapper;
+	struct dentry *file;
+};
+
+static int kho_debugfs_fdt_add(struct list_head *list, struct dentry *dir,
+			       const char *name, const void *fdt)
+{
+	struct fdt_debugfs *f;
+	struct dentry *file;
+
+	f = kmalloc(sizeof(*f), GFP_KERNEL);
+	if (!f)
+		return -ENOMEM;
+
+	f->wrapper.data = (void *)fdt;
+	f->wrapper.size = fdt_totalsize(fdt);
+
+	file = debugfs_create_blob(name, 0400, dir, &f->wrapper);
+	if (IS_ERR(file)) {
+		kfree(f);
+		return PTR_ERR(file);
+	}
+
+	f->file = file;
+	list_add(&f->list, list);
+
+	return 0;
+}
+
+/**
+ * kho_add_subtree - record the physical address of a sub FDT in KHO root tree.
+ * @ser: serialization control object passed by KHO notifiers.
+ * @name: name of the sub tree.
+ * @fdt: the sub tree blob.
+ *
+ * Creates a new child node named @name in KHO root FDT and records
+ * the physical address of @fdt. The pages of @fdt must also be preserved
+ * by KHO for the new kernel to retrieve it after kexec.
+ *
+ * A debugfs blob entry is also created at
+ * ``/sys/kernel/debug/kho/out/sub_fdts/@name``.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt)
+{
+	int err = 0;
+	u64 phys = (u64)virt_to_phys(fdt);
+	void *root = page_to_virt(ser->fdt);
+
+	err |= fdt_begin_node(root, name);
+	err |= fdt_property(root, PROP_SUB_FDT, &phys, sizeof(phys));
+	err |= fdt_end_node(root);
+
+	if (err)
+		return err;
+
+	return kho_debugfs_fdt_add(&ser->fdt_list, ser->sub_fdt_dir, name, fdt);
+}
+EXPORT_SYMBOL_GPL(kho_add_subtree);
+
+struct kho_out {
+	struct blocking_notifier_head chain_head;
+
+	struct dentry *dir;
+
+	struct mutex lock; /* protects KHO FDT finalization */
+
+	struct kho_serialization ser;
+	bool finalized;
+};
+
+static struct kho_out kho_out = {
+	.chain_head = BLOCKING_NOTIFIER_INIT(kho_out.chain_head),
+	.lock = __MUTEX_INITIALIZER(kho_out.lock),
+	.ser = {
+		.fdt_list = LIST_HEAD_INIT(kho_out.ser.fdt_list),
+	},
+	.finalized = false,
+};
+
+int register_kho_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&kho_out.chain_head, nb);
+}
+EXPORT_SYMBOL_GPL(register_kho_notifier);
+
+int unregister_kho_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&kho_out.chain_head, nb);
+}
+EXPORT_SYMBOL_GPL(unregister_kho_notifier);
+
+/* Handling for debug/kho/out */
+
+static struct dentry *debugfs_root;
+
+static int kho_out_update_debugfs_fdt(void)
+{
+	int err = 0;
+	struct fdt_debugfs *ff, *tmp;
+
+	if (kho_out.finalized) {
+		err = kho_debugfs_fdt_add(&kho_out.ser.fdt_list, kho_out.dir,
+					  "fdt", page_to_virt(kho_out.ser.fdt));
+	} else {
+		list_for_each_entry_safe(ff, tmp, &kho_out.ser.fdt_list, list) {
+			debugfs_remove(ff->file);
+			list_del(&ff->list);
+			kfree(ff);
+		}
+	}
+
+	return err;
+}
+
+static int kho_abort(void)
+{
+	int err;
+
+	err = blocking_notifier_call_chain(&kho_out.chain_head, KEXEC_KHO_ABORT,
+					   NULL);
+	err = notifier_to_errno(err);
+
+	if (err)
+		pr_err("Failed to abort KHO finalization: %d\n", err);
+
+	return err;
+}
+
+static int kho_finalize(void)
+{
+	int err = 0;
+	void *fdt = page_to_virt(kho_out.ser.fdt);
+
+	err |= fdt_create(fdt, PAGE_SIZE);
+	err |= fdt_finish_reservemap(fdt);
+	err |= fdt_begin_node(fdt, "");
+	err |= fdt_property_string(fdt, "compatible", KHO_FDT_COMPATIBLE);
+	if (err)
+		goto abort;
+
+	err = blocking_notifier_call_chain(&kho_out.chain_head,
+					   KEXEC_KHO_FINALIZE, &kho_out.ser);
+	err = notifier_to_errno(err);
+	if (err)
+		goto abort;
+
+	err |= fdt_end_node(fdt);
+	err |= fdt_finish(fdt);
+
+abort:
+	if (err) {
+		pr_err("Failed to convert KHO state tree: %d\n", err);
+		kho_abort();
+	}
+
+	return err;
+}
+
+static int kho_out_finalize_get(void *data, u64 *val)
+{
+	mutex_lock(&kho_out.lock);
+	*val = kho_out.finalized;
+	mutex_unlock(&kho_out.lock);
+
+	return 0;
+}
+
+static int kho_out_finalize_set(void *data, u64 _val)
+{
+	int ret = 0;
+	bool val = !!_val;
+
+	mutex_lock(&kho_out.lock);
+
+	if (val == kho_out.finalized) {
+		if (kho_out.finalized)
+			ret = -EEXIST;
+		else
+			ret = -ENOENT;
+		goto unlock;
+	}
+
+	if (val)
+		ret = kho_finalize();
+	else
+		ret = kho_abort();
+
+	if (ret)
+		goto unlock;
+
+	kho_out.finalized = val;
+	ret = kho_out_update_debugfs_fdt();
+
+unlock:
+	mutex_unlock(&kho_out.lock);
+	return ret;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_kho_out_finalize, kho_out_finalize_get,
+			 kho_out_finalize_set, "%llu\n");
+
+static int scratch_phys_show(struct seq_file *m, void *v)
+{
+	for (int i = 0; i < kho_scratch_cnt; i++)
+		seq_printf(m, "0x%llx\n", kho_scratch[i].addr);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(scratch_phys);
+
+static int scratch_len_show(struct seq_file *m, void *v)
+{
+	for (int i = 0; i < kho_scratch_cnt; i++)
+		seq_printf(m, "0x%llx\n", kho_scratch[i].size);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(scratch_len);
+
+static __init int kho_out_debugfs_init(void)
+{
+	struct dentry *dir, *f, *sub_fdt_dir;
+
+	dir = debugfs_create_dir("out", debugfs_root);
+	if (IS_ERR(dir))
+		return -ENOMEM;
+
+	sub_fdt_dir = debugfs_create_dir("sub_fdts", dir);
+	if (IS_ERR(sub_fdt_dir))
+		goto err_rmdir;
+
+	f = debugfs_create_file("scratch_phys", 0400, dir, NULL,
+				&scratch_phys_fops);
+	if (IS_ERR(f))
+		goto err_rmdir;
+
+	f = debugfs_create_file("scratch_len", 0400, dir, NULL,
+				&scratch_len_fops);
+	if (IS_ERR(f))
+		goto err_rmdir;
+
+	f = debugfs_create_file("finalize", 0600, dir, NULL,
+				&fops_kho_out_finalize);
+	if (IS_ERR(f))
+		goto err_rmdir;
+
+	kho_out.dir = dir;
+	kho_out.ser.sub_fdt_dir = sub_fdt_dir;
+	return 0;
+
+err_rmdir:
+	debugfs_remove_recursive(dir);
+	return -ENOENT;
+}
+
+static __init int kho_init(void)
+{
+	int err = 0;
+
+	if (!kho_enable)
+		return 0;
+
+	kho_out.ser.fdt = alloc_page(GFP_KERNEL);
+	if (!kho_out.ser.fdt) {
+		err = -ENOMEM;
+		goto err_free_scratch;
+	}
+
+	debugfs_root = debugfs_create_dir("kho", NULL);
+	if (IS_ERR(debugfs_root)) {
+		err = -ENOENT;
+		goto err_free_fdt;
+	}
+
+	err = kho_out_debugfs_init();
+	if (err)
+		goto err_free_fdt;
+
+	for (int i = 0; i < kho_scratch_cnt; i++) {
+		unsigned long base_pfn = PHYS_PFN(kho_scratch[i].addr);
+		unsigned long count = kho_scratch[i].size >> PAGE_SHIFT;
+		unsigned long pfn;
+
+		for (pfn = base_pfn; pfn < base_pfn + count;
+		     pfn += pageblock_nr_pages)
+			init_cma_reserved_pageblock(pfn_to_page(pfn));
+	}
+
+	return 0;
+
+err_free_fdt:
+	put_page(kho_out.ser.fdt);
+	kho_out.ser.fdt = NULL;
+err_free_scratch:
+	for (int i = 0; i < kho_scratch_cnt; i++) {
+		void *start = __va(kho_scratch[i].addr);
+		void *end = start + kho_scratch[i].size;
+
+		free_reserved_area(start, end, -1, "");
+	}
+	kho_enable = false;
+	return err;
+}
+late_initcall(kho_init);
+
+void __init kho_memory_init(void)
+{
+	kho_reserve_scratch();
+}
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 128c100fdb977..4918209735b42 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -30,6 +30,7 @@
 #include <linux/crash_dump.h>
 #include <linux/execmem.h>
 #include <linux/vmstat.h>
+#include <linux/kexec_handover.h>
 #include <linux/hugetlb.h>
 #include "internal.h"
 #include "slab.h"
@@ -2771,6 +2772,13 @@ void __init mm_core_init(void)
 	report_meminit();
 	kmsan_init_shadow();
 	stack_depot_early_init();
+
+	/*
+	 * KHO memory setup must happen while memblock is still active, but
+	 * as close as possible to buddy initialization
+	 */
+	kho_memory_init();
+
 	memblock_free_all();
 	mem_init();
 	kmem_cache_init();
-- 
2.49.0.906.g1f30a19c02-goog



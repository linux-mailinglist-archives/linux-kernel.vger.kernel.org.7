Return-Path: <linux-kernel+bounces-703583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7719DAE9238
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 01:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 785DC5A3684
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 23:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0822FC014;
	Wed, 25 Jun 2025 23:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="LXc5PIVR"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8FA2FBFFE
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 23:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893535; cv=none; b=sWt55R2BQNkJ3tuRm6fNLs3j+KomKm9sdTWflztPGBxXqr9nycvYkg/woBnnMhwjRlfIrF7MR/8UGAW3dcOcnR1qm87nC2582GzCW4Y93gXmWWlL4d8/aLqNrLkC1vobFQFHspr8wF54desJTxHVg52jJ/hfjk63H2SM7XyqR/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893535; c=relaxed/simple;
	bh=pZPVs3wNSmke5Ful54VmXWN7DgfJyhrekHxo42cMLiE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BfujDk6OzAt1i7ITEOFug6ir3uE0H9x41l0EwQcijO56L8CspyrRC3G+3DBxbf+QT5vm6EscPNgajCHHSmzvq2/v8y5old9o28HkrGmaNF0GTzsPTZShbzx0qVySBaWpYagNK05AckIskKnAXJSWBiqxMj2ZwmoynzjP/5kRltU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=LXc5PIVR; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e81826d5b72so297265276.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 16:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1750893532; x=1751498332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dumZCTdWbvhK37KWwIDI5JTRGiHuCsCef+VJnwQR+pQ=;
        b=LXc5PIVRZCaJB/0DpPJkyoiJwD4Y7s2bYjW5N7LzVLgM95oM/jO7x8wHCd8BYWqj4B
         me6eBhMXWY1B7F9Cc7jZ5iT3nWneM6EdfxV5y71RIlT7joX5swLoafS1EEm/7CooJ2Wm
         XLi/R85J5N+HBBG0tc/TCvryvtV8YKiwbKA77RY9Jsb54QEhbatxystZ77rEporgcqps
         xWULVpoagybxHxX8YDFPbIKAKzk8EajyMc7eT4qoyWBTr4AZZydfvkzydYk/AFwzRZLA
         n15bY7tHBO/xI7HOFILWfCulDSoIcgsIdJFgk9fsaqm2E4xC0FC9Y3Yl8XZawzruaNll
         SPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750893532; x=1751498332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dumZCTdWbvhK37KWwIDI5JTRGiHuCsCef+VJnwQR+pQ=;
        b=nVdJX5khsKPEXKcM6P9M41tSjRSTm0Blx+PDbGbURgtC7w0Hl7XtyK5MlA5EAlC0kJ
         7jH6ovqjP18CL3NEIItSsBcxDighj7mpHvcL870sP9xIiSeEua6xjLALqLT3nwUNWuMs
         ag/bt2xTz8igYcX+s1BDV61Kq04By1VdLCWR3a2HxIPUJPDLhqowXWroXT7FhUXdvBsp
         qTuSTohfbffhrwD/QgLRZKlELn6NdSEfgcB5DUIOEWdPluwmsQK8XeAxx6Ro9fc0PIYZ
         5B3WWHCQKIsTFePck5AvpXOD7KGECCPF2L6MYEvFkFSAm7UaYjqIH9JvipfcLtIQsPoG
         Ym/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2ajErsUVhFdN0W6zYjksKk8QPfjiqDz3K+u9Zl+E5xElPUg8n45hjEIKoTpAKr49roGPJvE+1iYYhX3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtwmrwv6H6yWFzMu0ysnqeK3kAQG5jyiH37QobIyPaLV0aiFjM
	AZNH3+HzqTGkguu7jCPENY00wgDEMk/JSfC9f2V3E1amzFa0VUn92L9meZA2PFNxZAQ=
X-Gm-Gg: ASbGncucqCpuWGATGrmcbUGBF1vXOKv+E0rEzlb+sESS31wyKWj2fw9SolhgSmphW7H
	KYEMshEE8EFau7D8lNvWuRH5Pfz76s4jr70wltnQlDAeicTTI922QTi9l9wlgBoH3tyVLUqzJ9p
	nVxGUX+16dbmdPSgOdClNbQL/9eZL0fHVGio/r1g9WpWO03NMj/jj7DDyNBhHGFc8853q+iNprB
	MpJ/SaON58eWOLGvT4ThdY0scs8fE6EKe/SX7g5Eqyp+ypkgV8BiZlmVxpJsk4cGrHdATRpdMzR
	zshcve1Tmy6ze3mawZFE+GfNDf+A9+1IUitw2vwTsKoJne8XZMt5kbxvQOxV0ZkxKVR69XoNgq0
	zunuOe4qdf0JPAGGFHV9rWbp1XYBCdm95iNWwkN5uVOEVaOGAT7v1
X-Google-Smtp-Source: AGHT+IFyFKsALyA0KkokSs0oiQ68Hbgi3tkJLo6jEj/wIJs+Ee8M7Kz8LkfX+DDtHK8ypURGMBW9Iw==
X-Received: by 2002:a05:6902:120c:b0:e84:cbc:6c86 with SMTP id 3f1490d57ef6-e860177bf6bmr6206247276.33.1750893531852;
        Wed, 25 Jun 2025 16:18:51 -0700 (PDT)
Received: from soleen.c.googlers.com.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842ac5c538sm3942684276.33.2025.06.25.16.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 16:18:51 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 05/32] kho: make debugfs interface optional
Date: Wed, 25 Jun 2025 23:17:52 +0000
Message-ID: <20250625231838.1897085-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
References: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, KHO is controlled via debugfs interface, but once LUO is
introduced, it can control KHO, and the debug interface becomes
optional.

Add a separate config CONFIG_KEXEC_HANDOVER_DEBUG that enables
the debugfs interface, and allows to inspect the tree.

Move all debugfs related code to a new file to keep the .c files
clear of ifdefs.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 MAINTAINERS                      |   3 +-
 kernel/Kconfig.kexec             |  10 ++
 kernel/Makefile                  |   1 +
 kernel/kexec_handover.c          | 278 ++++---------------------------
 kernel/kexec_handover_debug.c    | 218 ++++++++++++++++++++++++
 kernel/kexec_handover_internal.h |  44 +++++
 6 files changed, 311 insertions(+), 243 deletions(-)
 create mode 100644 kernel/kexec_handover_debug.c
 create mode 100644 kernel/kexec_handover_internal.h

diff --git a/MAINTAINERS b/MAINTAINERS
index efb51ee92683..8ef6df1c4611 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13346,13 +13346,14 @@ KEXEC HANDOVER (KHO)
 M:	Alexander Graf <graf@amazon.com>
 M:	Mike Rapoport <rppt@kernel.org>
 M:	Changyuan Lyu <changyuanl@google.com>
+M:	Pasha Tatashin <pasha.tatashin@soleen.com>
 L:	kexec@lists.infradead.org
 L:	linux-mm@kvack.org
 S:	Maintained
 F:	Documentation/admin-guide/mm/kho.rst
 F:	Documentation/core-api/kho/*
 F:	include/linux/kexec_handover.h
-F:	kernel/kexec_handover.c
+F:	kernel/kexec_handover*
 
 KEYS-ENCRYPTED
 M:	Mimi Zohar <zohar@linux.ibm.com>
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index ff8ab20f9228..2b18a06bc5b2 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -109,6 +109,16 @@ config KEXEC_HANDOVER
 	  to keep data or state alive across the kexec. For this to work,
 	  both source and target kernels need to have this option enabled.
 
+config KEXEC_HANDOVER_DEBUG
+	bool "kexec handover debug interface"
+	depends on KEXEC_HANDOVER
+	depends on DEBUG_FS
+	help
+	  Allow to control kexec handover device tree via debugfs
+	  interface, i.e. finalize the state or aborting the finalization.
+	  Also, enables inspecting the KHO fdt trees with the debugfs binary
+	  blobs.
+
 config CRASH_DUMP
 	bool "kernel crash dumps"
 	default ARCH_DEFAULT_CRASH_DUMP
diff --git a/kernel/Makefile b/kernel/Makefile
index 32e80dd626af..e4b4afa86a70 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -82,6 +82,7 @@ obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_KEXEC_FILE) += kexec_file.o
 obj-$(CONFIG_KEXEC_ELF) += kexec_elf.o
 obj-$(CONFIG_KEXEC_HANDOVER) += kexec_handover.o
+obj-$(CONFIG_KEXEC_HANDOVER_DEBUG) += kexec_handover_debug.o
 obj-$(CONFIG_BACKTRACE_SELF_TEST) += backtracetest.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_CGROUPS) += cgroup/
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index af6a11f48213..860046776c6c 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -10,7 +10,6 @@
 
 #include <linux/cma.h>
 #include <linux/count_zeros.h>
-#include <linux/debugfs.h>
 #include <linux/kexec.h>
 #include <linux/kexec_handover.h>
 #include <linux/libfdt.h>
@@ -27,6 +26,7 @@
  */
 #include "../mm/internal.h"
 #include "kexec_internal.h"
+#include "kexec_handover_internal.h"
 
 #define KHO_FDT_COMPATIBLE "kho-v1"
 #define PROP_PRESERVED_MEMORY_MAP "preserved-memory-map"
@@ -84,8 +84,6 @@ struct khoser_mem_chunk;
 
 struct kho_serialization {
 	struct page *fdt;
-	struct list_head fdt_list;
-	struct dentry *sub_fdt_dir;
 	struct kho_mem_track track;
 	/* First chunk of serialized preserved memory map */
 	struct khoser_mem_chunk *preserved_mem_map;
@@ -381,8 +379,8 @@ static void __init kho_mem_deserialize(const void *fdt)
  * area for early allocations that happen before page allocator is
  * initialized.
  */
-static struct kho_scratch *kho_scratch;
-static unsigned int kho_scratch_cnt;
+struct kho_scratch *kho_scratch;
+unsigned int kho_scratch_cnt;
 
 /*
  * The scratch areas are scaled by default as percent of memory allocated from
@@ -569,36 +567,24 @@ static void __init kho_reserve_scratch(void)
 	kho_enable = false;
 }
 
-struct fdt_debugfs {
-	struct list_head list;
-	struct debugfs_blob_wrapper wrapper;
-	struct dentry *file;
+struct kho_out {
+	struct blocking_notifier_head chain_head;
+	struct mutex lock; /* protects KHO FDT finalization */
+	struct kho_serialization ser;
+	bool finalized;
+	struct kho_debugfs dbg;
 };
 
-static int kho_debugfs_fdt_add(struct list_head *list, struct dentry *dir,
-			       const char *name, const void *fdt)
-{
-	struct fdt_debugfs *f;
-	struct dentry *file;
-
-	f = kmalloc(sizeof(*f), GFP_KERNEL);
-	if (!f)
-		return -ENOMEM;
-
-	f->wrapper.data = (void *)fdt;
-	f->wrapper.size = fdt_totalsize(fdt);
-
-	file = debugfs_create_blob(name, 0400, dir, &f->wrapper);
-	if (IS_ERR(file)) {
-		kfree(f);
-		return PTR_ERR(file);
-	}
-
-	f->file = file;
-	list_add(&f->list, list);
-
-	return 0;
-}
+static struct kho_out kho_out = {
+	.chain_head = BLOCKING_NOTIFIER_INIT(kho_out.chain_head),
+	.lock = __MUTEX_INITIALIZER(kho_out.lock),
+	.ser = {
+		.track = {
+			.orders = XARRAY_INIT(kho_out.ser.track.orders, 0),
+		},
+	},
+	.finalized = false,
+};
 
 /**
  * kho_add_subtree - record the physical address of a sub FDT in KHO root tree.
@@ -611,7 +597,8 @@ static int kho_debugfs_fdt_add(struct list_head *list, struct dentry *dir,
  * by KHO for the new kernel to retrieve it after kexec.
  *
  * A debugfs blob entry is also created at
- * ``/sys/kernel/debug/kho/out/sub_fdts/@name``.
+ * ``/sys/kernel/debug/kho/out/sub_fdts/@name`` when kernel is configured with
+ * CONFIG_KEXEC_HANDOVER_DEBUG
  *
  * Return: 0 on success, error code on failure
  */
@@ -628,33 +615,10 @@ int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt)
 	if (err)
 		return err;
 
-	return kho_debugfs_fdt_add(&ser->fdt_list, ser->sub_fdt_dir, name, fdt);
+	return kho_debugfs_fdt_add(&kho_out.dbg, name, fdt, false);
 }
 EXPORT_SYMBOL_GPL(kho_add_subtree);
 
-struct kho_out {
-	struct blocking_notifier_head chain_head;
-
-	struct dentry *dir;
-
-	struct mutex lock; /* protects KHO FDT finalization */
-
-	struct kho_serialization ser;
-	bool finalized;
-};
-
-static struct kho_out kho_out = {
-	.chain_head = BLOCKING_NOTIFIER_INIT(kho_out.chain_head),
-	.lock = __MUTEX_INITIALIZER(kho_out.lock),
-	.ser = {
-		.fdt_list = LIST_HEAD_INIT(kho_out.ser.fdt_list),
-		.track = {
-			.orders = XARRAY_INIT(kho_out.ser.track.orders, 0),
-		},
-	},
-	.finalized = false,
-};
-
 int register_kho_notifier(struct notifier_block *nb)
 {
 	return blocking_notifier_chain_register(&kho_out.chain_head, nb);
@@ -734,29 +698,6 @@ int kho_preserve_phys(phys_addr_t phys, size_t size)
 }
 EXPORT_SYMBOL_GPL(kho_preserve_phys);
 
-/* Handling for debug/kho/out */
-
-static struct dentry *debugfs_root;
-
-static int kho_out_update_debugfs_fdt(void)
-{
-	int err = 0;
-	struct fdt_debugfs *ff, *tmp;
-
-	if (kho_out.finalized) {
-		err = kho_debugfs_fdt_add(&kho_out.ser.fdt_list, kho_out.dir,
-					  "fdt", page_to_virt(kho_out.ser.fdt));
-	} else {
-		list_for_each_entry_safe(ff, tmp, &kho_out.ser.fdt_list, list) {
-			debugfs_remove(ff->file);
-			list_del(&ff->list);
-			kfree(ff);
-		}
-	}
-
-	return err;
-}
-
 static int __kho_abort(void)
 {
 	int err;
@@ -809,7 +750,8 @@ int kho_abort(void)
 		goto unlock;
 
 	kho_out.finalized = false;
-	ret = kho_out_update_debugfs_fdt();
+
+	kho_debugfs_cleanup(&kho_out.dbg);
 
 unlock:
 	mutex_unlock(&kho_out.lock);
@@ -860,7 +802,7 @@ static int __kho_finalize(void)
 abort:
 	if (err) {
 		pr_err("Failed to convert KHO state tree: %d\n", err);
-		kho_abort();
+		__kho_abort();
 	}
 
 	return err;
@@ -885,7 +827,8 @@ int kho_finalize(void)
 		goto unlock;
 
 	kho_out.finalized = true;
-	ret = kho_out_update_debugfs_fdt();
+	ret = kho_debugfs_fdt_add(&kho_out.dbg, "fdt",
+				  page_to_virt(kho_out.ser.fdt), true);
 
 unlock:
 	mutex_unlock(&kho_out.lock);
@@ -893,112 +836,24 @@ int kho_finalize(void)
 }
 EXPORT_SYMBOL_GPL(kho_finalize);
 
-static int kho_out_finalize_get(void *data, u64 *val)
+bool kho_finalized(void)
 {
-	mutex_lock(&kho_out.lock);
-	*val = kho_out.finalized;
-	mutex_unlock(&kho_out.lock);
-
-	return 0;
-}
-
-static int kho_out_finalize_set(void *data, u64 _val)
-{
-	int ret = 0;
-	bool val = !!_val;
+	bool ret;
 
 	mutex_lock(&kho_out.lock);
-
-	if (val == kho_out.finalized) {
-		if (kho_out.finalized)
-			ret = -EEXIST;
-		else
-			ret = -ENOENT;
-		goto unlock;
-	}
-
-	if (val)
-		ret = kho_finalize();
-	else
-		ret = kho_abort();
-
-	if (ret)
-		goto unlock;
-
-	kho_out.finalized = val;
-	ret = kho_out_update_debugfs_fdt();
-
-unlock:
+	ret = kho_out.finalized;
 	mutex_unlock(&kho_out.lock);
-	return ret;
-}
-
-DEFINE_DEBUGFS_ATTRIBUTE(fops_kho_out_finalize, kho_out_finalize_get,
-			 kho_out_finalize_set, "%llu\n");
-
-static int scratch_phys_show(struct seq_file *m, void *v)
-{
-	for (int i = 0; i < kho_scratch_cnt; i++)
-		seq_printf(m, "0x%llx\n", kho_scratch[i].addr);
-
-	return 0;
-}
-DEFINE_SHOW_ATTRIBUTE(scratch_phys);
-
-static int scratch_len_show(struct seq_file *m, void *v)
-{
-	for (int i = 0; i < kho_scratch_cnt; i++)
-		seq_printf(m, "0x%llx\n", kho_scratch[i].size);
-
-	return 0;
-}
-DEFINE_SHOW_ATTRIBUTE(scratch_len);
-
-static __init int kho_out_debugfs_init(void)
-{
-	struct dentry *dir, *f, *sub_fdt_dir;
-
-	dir = debugfs_create_dir("out", debugfs_root);
-	if (IS_ERR(dir))
-		return -ENOMEM;
-
-	sub_fdt_dir = debugfs_create_dir("sub_fdts", dir);
-	if (IS_ERR(sub_fdt_dir))
-		goto err_rmdir;
 
-	f = debugfs_create_file("scratch_phys", 0400, dir, NULL,
-				&scratch_phys_fops);
-	if (IS_ERR(f))
-		goto err_rmdir;
-
-	f = debugfs_create_file("scratch_len", 0400, dir, NULL,
-				&scratch_len_fops);
-	if (IS_ERR(f))
-		goto err_rmdir;
-
-	f = debugfs_create_file("finalize", 0600, dir, NULL,
-				&fops_kho_out_finalize);
-	if (IS_ERR(f))
-		goto err_rmdir;
-
-	kho_out.dir = dir;
-	kho_out.ser.sub_fdt_dir = sub_fdt_dir;
-	return 0;
-
-err_rmdir:
-	debugfs_remove_recursive(dir);
-	return -ENOENT;
+	return ret;
 }
 
 struct kho_in {
-	struct dentry *dir;
 	phys_addr_t fdt_phys;
 	phys_addr_t scratch_phys;
-	struct list_head fdt_list;
+	struct kho_debugfs dbg;
 };
 
 static struct kho_in kho_in = {
-	.fdt_list = LIST_HEAD_INIT(kho_in.fdt_list),
 };
 
 static const void *kho_get_fdt(void)
@@ -1042,56 +897,6 @@ int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
 }
 EXPORT_SYMBOL_GPL(kho_retrieve_subtree);
 
-/* Handling for debugfs/kho/in */
-
-static __init int kho_in_debugfs_init(const void *fdt)
-{
-	struct dentry *sub_fdt_dir;
-	int err, child;
-
-	kho_in.dir = debugfs_create_dir("in", debugfs_root);
-	if (IS_ERR(kho_in.dir))
-		return PTR_ERR(kho_in.dir);
-
-	sub_fdt_dir = debugfs_create_dir("sub_fdts", kho_in.dir);
-	if (IS_ERR(sub_fdt_dir)) {
-		err = PTR_ERR(sub_fdt_dir);
-		goto err_rmdir;
-	}
-
-	err = kho_debugfs_fdt_add(&kho_in.fdt_list, kho_in.dir, "fdt", fdt);
-	if (err)
-		goto err_rmdir;
-
-	fdt_for_each_subnode(child, fdt, 0) {
-		int len = 0;
-		const char *name = fdt_get_name(fdt, child, NULL);
-		const u64 *fdt_phys;
-
-		fdt_phys = fdt_getprop(fdt, child, "fdt", &len);
-		if (!fdt_phys)
-			continue;
-		if (len != sizeof(*fdt_phys)) {
-			pr_warn("node `%s`'s prop `fdt` has invalid length: %d\n",
-				name, len);
-			continue;
-		}
-		err = kho_debugfs_fdt_add(&kho_in.fdt_list, sub_fdt_dir, name,
-					  phys_to_virt(*fdt_phys));
-		if (err) {
-			pr_warn("failed to add fdt `%s` to debugfs: %d\n", name,
-				err);
-			continue;
-		}
-	}
-
-	return 0;
-
-err_rmdir:
-	debugfs_remove_recursive(kho_in.dir);
-	return err;
-}
-
 static __init int kho_init(void)
 {
 	int err = 0;
@@ -1106,27 +911,16 @@ static __init int kho_init(void)
 		goto err_free_scratch;
 	}
 
-	debugfs_root = debugfs_create_dir("kho", NULL);
-	if (IS_ERR(debugfs_root)) {
-		err = -ENOENT;
+	err = kho_debugfs_init();
+	if (err)
 		goto err_free_fdt;
-	}
 
-	err = kho_out_debugfs_init();
+	err = kho_out_debugfs_init(&kho_out.dbg);
 	if (err)
 		goto err_free_fdt;
 
 	if (fdt) {
-		err = kho_in_debugfs_init(fdt);
-		/*
-		 * Failure to create /sys/kernel/debug/kho/in does not prevent
-		 * reviving state from KHO and setting up KHO for the next
-		 * kexec.
-		 */
-		if (err)
-			pr_err("failed exposing handover FDT in debugfs: %d\n",
-			       err);
-
+		kho_in_debugfs_init(&kho_in.dbg, fdt);
 		return 0;
 	}
 
diff --git a/kernel/kexec_handover_debug.c b/kernel/kexec_handover_debug.c
new file mode 100644
index 000000000000..b88d138a97be
--- /dev/null
+++ b/kernel/kexec_handover_debug.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * kexec_handover.c - kexec handover metadata processing
+ * Copyright (C) 2023 Alexander Graf <graf@amazon.com>
+ * Copyright (C) 2025 Microsoft Corporation, Mike Rapoport <rppt@kernel.org>
+ * Copyright (C) 2025 Google LLC, Changyuan Lyu <changyuanl@google.com>
+ * Copyright (C) 2025 Google LLC, Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+#define pr_fmt(fmt) "KHO: " fmt
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/libfdt.h>
+#include <linux/mm.h>
+#include "kexec_handover_internal.h"
+
+static struct dentry *debugfs_root;
+
+struct fdt_debugfs {
+	struct list_head list;
+	struct debugfs_blob_wrapper wrapper;
+	struct dentry *file;
+};
+
+static int __kho_debugfs_fdt_add(struct list_head *list, struct dentry *dir,
+				 const char *name, const void *fdt)
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
+int kho_debugfs_fdt_add(struct kho_debugfs *dbg, const char *name,
+			const void *fdt, bool root)
+{
+	struct dentry *dir;
+
+	if (root)
+		dir = dbg->dir;
+	else
+		dir = dbg->sub_fdt_dir;
+
+	return __kho_debugfs_fdt_add(&dbg->fdt_list, dir, name, fdt);
+}
+
+void kho_debugfs_cleanup(struct kho_debugfs *dbg)
+{
+	struct fdt_debugfs *ff, *tmp;
+
+	list_for_each_entry_safe(ff, tmp, &dbg->fdt_list, list) {
+		debugfs_remove(ff->file);
+		list_del(&ff->list);
+		kfree(ff);
+	}
+}
+
+static int kho_out_finalize_get(void *data, u64 *val)
+{
+	*val = kho_finalized();
+
+	return 0;
+}
+
+static int kho_out_finalize_set(void *data, u64 _val)
+{
+	bool val = !!_val;
+
+	if (val)
+		return kho_finalize();
+
+	return kho_abort();
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(kho_out_finalize_fops, kho_out_finalize_get,
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
+__init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
+{
+	struct dentry *dir, *sub_fdt_dir;
+	int err, child;
+
+	INIT_LIST_HEAD(&dbg->fdt_list);
+
+	dir = debugfs_create_dir("in", debugfs_root);
+	if (IS_ERR(dir)) {
+		err = PTR_ERR(dir);
+		goto err_out;
+	}
+
+	sub_fdt_dir = debugfs_create_dir("sub_fdts", dir);
+	if (IS_ERR(sub_fdt_dir)) {
+		err = PTR_ERR(sub_fdt_dir);
+		goto err_rmdir;
+	}
+
+	err = __kho_debugfs_fdt_add(&dbg->fdt_list, dir, "fdt", fdt);
+	if (err)
+		goto err_rmdir;
+
+	fdt_for_each_subnode(child, fdt, 0) {
+		int len = 0;
+		const char *name = fdt_get_name(fdt, child, NULL);
+		const u64 *fdt_phys;
+
+		fdt_phys = fdt_getprop(fdt, child, "fdt", &len);
+		if (!fdt_phys)
+			continue;
+		if (len != sizeof(*fdt_phys)) {
+			pr_warn("node %s prop fdt has invalid length: %d\n",
+				name, len);
+			continue;
+		}
+		err = __kho_debugfs_fdt_add(&dbg->fdt_list, sub_fdt_dir, name,
+					    phys_to_virt(*fdt_phys));
+		if (err) {
+			pr_warn("failed to add fdt %s to debugfs: %d\n", name,
+				err);
+			continue;
+		}
+	}
+
+	dbg->dir = dir;
+	dbg->sub_fdt_dir = sub_fdt_dir;
+
+	return;
+err_rmdir:
+	debugfs_remove_recursive(dir);
+err_out:
+	/*
+	 * Failure to create /sys/kernel/debug/kho/in does not prevent
+	 * reviving state from KHO and setting up KHO for the next
+	 * kexec.
+	 */
+	if (err)
+		pr_err("failed exposing handover FDT in debugfs: %d\n", err);
+}
+
+__init int kho_out_debugfs_init(struct kho_debugfs *dbg)
+{
+	struct dentry *dir, *f, *sub_fdt_dir;
+
+	INIT_LIST_HEAD(&dbg->fdt_list);
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
+				&kho_out_finalize_fops);
+	if (IS_ERR(f))
+		goto err_rmdir;
+
+	dbg->dir = dir;
+	dbg->sub_fdt_dir = sub_fdt_dir;
+	return 0;
+
+err_rmdir:
+	debugfs_remove_recursive(dir);
+	return -ENOENT;
+}
+
+__init int kho_debugfs_init(void)
+{
+	debugfs_root = debugfs_create_dir("kho", NULL);
+	if (IS_ERR(debugfs_root))
+		return -ENOENT;
+	return 0;
+}
diff --git a/kernel/kexec_handover_internal.h b/kernel/kexec_handover_internal.h
new file mode 100644
index 000000000000..41e9616fcdd0
--- /dev/null
+++ b/kernel/kexec_handover_internal.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef LINUX_KEXEC_HANDOVER_INTERNAL_H
+#define LINUX_KEXEC_HANDOVER_INTERNAL_H
+
+#include <linux/kexec_handover.h>
+#include <linux/list.h>
+#include <linux/types.h>
+
+#ifdef CONFIG_KEXEC_HANDOVER_DEBUG
+#include <linux/debugfs.h>
+
+struct kho_debugfs {
+	struct dentry *dir;
+	struct dentry *sub_fdt_dir;
+	struct list_head fdt_list;
+};
+
+#else
+struct kho_debugfs {}
+#endif
+
+extern struct kho_scratch *kho_scratch;
+extern unsigned int kho_scratch_cnt;
+
+bool kho_finalized(void);
+
+#ifdef CONFIG_KEXEC_HANDOVER_DEBUG
+int kho_debugfs_init(void);
+void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt);
+int kho_out_debugfs_init(struct kho_debugfs *dbg);
+int kho_debugfs_fdt_add(struct kho_debugfs *dbg, const char *name,
+			const void *fdt, bool root);
+void kho_debugfs_cleanup(struct kho_debugfs *dbg);
+#else
+static inline int kho_debugfs_init(void) { return 0; }
+static inline void kho_in_debugfs_init(struct kho_debugfs *dbg,
+				       const void *fdt) { }
+static inline int kho_out_debugfs_init(struct kho_debugfs *dbg) { return 0; }
+static inline int kho_debugfs_fdt_add(struct kho_debugfs *dbg, const char *name,
+				      const void *fdt, bool root) { return 0; }
+static inline void kho_debugfs_cleanup(struct kho_debugfs *dbg) {}
+#endif /* CONFIG_KEXEC_HANDOVER_DEBUG */
+
+#endif /* LINUX_KEXEC_HANDOVER_INTERNAL_H */
-- 
2.50.0.727.gbf7dc18ff4-goog



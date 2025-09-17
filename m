Return-Path: <linux-kernel+bounces-819902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E372B7D0BE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF802A7FC4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 02:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8662F6192;
	Wed, 17 Sep 2025 02:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bf7gX+CU"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2192F6181
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758077447; cv=none; b=gwO3aR8XZE+kRulfNvIjQjeRPJeRoDyRbjd7y7yof1IrZLfXZJR4eBTVc2s2BdjoDhNbiS8SWMNpFvGRX6R+11rBzfcZ+WXU3gXeW3GcoK2BfrP9QP8+GL6bn28Jrz/Eb3Nbps0QiFbCVaXcLBs39ziXE3XTlwFlIM13bUFUQY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758077447; c=relaxed/simple;
	bh=jyztMEGoywuu6yjn5VQ7guEnx23P6qZwoB6xeLfCf7E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=WKov8Xu/O/d/HXqX3Ml0D+uzQe52/lcS9V8XmUTalg8bH/Xto1EdOIWruEKEYmbZ8kaKM591Oj2otj9EMB21q1vEOUOSJHon33dseIGu8Y0UdulDIpa4DQDBLDp4PGMRnE+usj9I9Hm+2hEzcipgpZ7riwu1MXgm9cgsIoqg6mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jasonmiu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bf7gX+CU; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jasonmiu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32eae48beaaso1045614a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 19:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758077445; x=1758682245; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lSn2CmdF8+yf4DtOsVnJBkMWdMtw6s5eBLN2Lm9vVpQ=;
        b=bf7gX+CUOT03XkBCViX0fQ/r/4ghv8BOfSit4Up9J8AUIW17CKMpkUoAFWf69Z1xPo
         KcY05KhcZJpOUDL53ZmgPvH4Avhz9s0+2UKEClDWOljVPpEUwEb7G/YZXlDqIVhXm12G
         gNenYHAjFhLEgzg/YCAomLHQYZy0yrJ/aHu+H0+rg/YqWyq7ko92xTGhqUd/udnaSe9j
         t6C8OHtq+/DXyM4KuCz0Ok7funseeejopTdQsQpewVLKRl0ZYMj+vAFXM6g0MWyj2gHq
         D6SbdhnnjOw6vm433dD+XQetN0ZPAQ9Z7shmKPz0HDJ5QM7S8cM2y5M5mHAt8jbhF0qZ
         Y4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758077445; x=1758682245;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lSn2CmdF8+yf4DtOsVnJBkMWdMtw6s5eBLN2Lm9vVpQ=;
        b=ASencYoHYuO5mQGzTyZpIOGXPkjTfvzBVYU+ZQnsHgGRPkZ/Oo7jeA2CHlD5QjOY7H
         oWt/J199jJDrJx6HTz8agRQHaNmS431sASFWIZrr0JI24P04BMQLJPKWlkIlaz0aMtyF
         AapWfK2LjVrjTz/8VaeoIvlPtF2DsOmO+knuvbpdh66BmqDBQtUycKS7gBKS8cDkW1Hx
         mVs1HHIsdiTNbx7maY6BSYpkO6Gc7+TmHA8dslU5cN4iviXU+BHyyBZNsLNuMcs7YfUk
         H2cyjf1IwLZl6xRcaBLJ57MsoIDujGVVgskEWow4mn/dLyFjWfKRz4IW+n+ynB/AF/1t
         HivA==
X-Forwarded-Encrypted: i=1; AJvYcCWJNmDaPi9tuPlZzHVQOgsR60oSP2Pd9RXOA3gZBh0Z2VRWfaiKjToJ93yPljhIWXKI57aHx7OSmzVbBOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXdDzCFCXJVVE0mO+UV2oW5GcIKwlPTpMQU+/GGm3OCmg1r3YK
	AoGTwpsuyxUNa7d4apoh1VVz9eFmCMgAUQgu5tuK26jCGLCfTGetw1sW07ilA1PlAnTD82ctZyO
	GXulCUyGPbLb1Ow==
X-Google-Smtp-Source: AGHT+IHQ74t+zzjdi8h+z/5IY48HHRSYodyFCrNO4puZo9tU2iy1v7RraJy6Ayld7eqRNTEp/i2TMXedcJZ7fA==
X-Received: from pjbdy13.prod.google.com ([2002:a17:90b:6cd:b0:32e:2c41:7def])
 (user=jasonmiu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4fcf:b0:32b:9774:d340 with SMTP id 98e67ed59e1d1-32ee3f65f8fmr715320a91.33.1758077443958;
 Tue, 16 Sep 2025 19:50:43 -0700 (PDT)
Date: Tue, 16 Sep 2025 19:50:18 -0700
In-Reply-To: <20250917025019.1585041-1-jasonmiu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250917025019.1585041-1-jasonmiu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917025019.1585041-4-jasonmiu@google.com>
Subject: [RFC v1 3/4] memblock: Remove KHO notifier usage
From: Jason Miu <jasonmiu@google.com>
To: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Miu <jasonmiu@google.com>, 
	Joel Granados <joel.granados@kernel.org>, Marcos Paulo de Souza <mpdesouza@suse.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Petr Mladek <pmladek@suse.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Steven Chen <chenste@linux.microsoft.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Update memblock to use direct KHO API calls for memory preservation.

Remove the KHO notifier registration and callbacks from the memblock
subsystem. These notifiers were tied to the former KHO finalize and
abort events, which are no longer used.

Memblock now preserves its `reserve_mem` regions and registers its
metadata by calling kho_preserve_phys(), kho_preserve_folio(), and
kho_add_subtree() directly within its initialization function. This is
made possible by changes in the KHO core to complete the FDT at a
later stage, during kexec.

Signed-off-by: Jason Miu <jasonmiu@google.com>
---
 include/linux/kexec_handover.h |  7 ++----
 kernel/kexec_core.c            |  4 +++
 kernel/kexec_handover.c        | 46 +++++++++++++++++++++-------------
 kernel/kexec_internal.h        |  2 ++
 mm/memblock.c                  | 46 ++++++++--------------------------
 5 files changed, 47 insertions(+), 58 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index c8229cb11f4b..e29dcf53de7e 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -19,15 +19,13 @@ enum kho_event {
 struct folio;
 struct notifier_block;
 
-struct kho_serialization;
-
 #ifdef CONFIG_KEXEC_HANDOVER
 bool kho_is_enabled(void);
 
 int kho_preserve_folio(struct folio *folio);
 int kho_preserve_phys(phys_addr_t phys, size_t size);
 struct folio *kho_restore_folio(phys_addr_t phys);
-int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt);
+int kho_add_subtree(const char *name, void *fdt);
 int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
 
 int register_kho_notifier(struct notifier_block *nb);
@@ -58,8 +56,7 @@ static inline struct folio *kho_restore_folio(phys_addr_t phys)
 	return NULL;
 }
 
-static inline int kho_add_subtree(struct kho_serialization *ser,
-				  const char *name, void *fdt)
+static inline int kho_add_subtree(const char *name, void *fdt)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 31203f0bacaf..3cf33aaded17 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1147,6 +1147,10 @@ int kernel_kexec(void)
 		goto Unlock;
 	}
 
+	error = kho_commit_fdt();
+	if (error)
+		goto Unlock;
+
 #ifdef CONFIG_KEXEC_JUMP
 	if (kexec_image->preserve_context) {
 		/*
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 578d1c1b9cea..f7933b434364 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -682,9 +682,21 @@ static int kho_debugfs_fdt_add(struct list_head *list, struct dentry *dir,
 	return 0;
 }
 
+struct kho_out {
+	struct blocking_notifier_head chain_head;
+	struct dentry *dir;
+	struct kho_serialization ser;
+};
+
+static struct kho_out kho_out = {
+	.chain_head = BLOCKING_NOTIFIER_INIT(kho_out.chain_head),
+	.ser = {
+		.fdt_list = LIST_HEAD_INIT(kho_out.ser.fdt_list),
+	},
+};
+
 /**
  * kho_add_subtree - record the physical address of a sub FDT in KHO root tree.
- * @ser: serialization control object passed by KHO notifiers.
  * @name: name of the sub tree.
  * @fdt: the sub tree blob.
  *
@@ -697,8 +709,9 @@ static int kho_debugfs_fdt_add(struct list_head *list, struct dentry *dir,
  *
  * Return: 0 on success, error code on failure
  */
-int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt)
+int kho_add_subtree(const char *name, void *fdt)
 {
+	struct kho_serialization *ser = &kho_out.ser;
 	int err = 0;
 	u64 phys = (u64)virt_to_phys(fdt);
 	void *root = page_to_virt(ser->fdt);
@@ -714,19 +727,6 @@ int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt)
 }
 EXPORT_SYMBOL_GPL(kho_add_subtree);
 
-struct kho_out {
-	struct blocking_notifier_head chain_head;
-	struct dentry *dir;
-	struct kho_serialization ser;
-};
-
-static struct kho_out kho_out = {
-	.chain_head = BLOCKING_NOTIFIER_INIT(kho_out.chain_head),
-	.ser = {
-		.fdt_list = LIST_HEAD_INIT(kho_out.ser.fdt_list),
-	},
-};
-
 int register_kho_notifier(struct notifier_block *nb)
 {
 	return blocking_notifier_chain_register(&kho_out.chain_head, nb);
@@ -952,6 +952,7 @@ static int kho_out_fdt_init(void)
 	void *fdt = page_to_virt(kho_out.ser.fdt);
 	u64 *preserved_order_table;
 
+	/* Do not close the root node and FDT until kho_commit_fdt() */
 	err |= fdt_create(fdt, PAGE_SIZE);
 	err |= fdt_finish_reservemap(fdt);
 	err |= fdt_begin_node(fdt, "");
@@ -965,9 +966,6 @@ static int kho_out_fdt_init(void)
 
 	*preserved_order_table = (u64)virt_to_phys(kho_order_table);
 
-	err |= fdt_end_node(fdt);
-	err |= fdt_finish(fdt);
-
 abort:
 	if (err)
 		pr_err("Failed to convert KHO state tree: %d\n", err);
@@ -1211,6 +1209,18 @@ int kho_fill_kimage(struct kimage *image)
 	return 0;
 }
 
+int kho_commit_fdt(void)
+{
+	int err = 0;
+	void *fdt = page_to_virt(kho_out.ser.fdt);
+
+	/* Close the root node and commit the FDT */
+	err = fdt_end_node(fdt);
+	err |= fdt_finish(fdt);
+
+	return err;
+}
+
 static int kho_walk_scratch(struct kexec_buf *kbuf,
 			    int (*func)(struct resource *, void *))
 {
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 228bb88c018b..490170911f5a 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -46,6 +46,7 @@ struct kexec_buf;
 int kho_locate_mem_hole(struct kexec_buf *kbuf,
 			int (*func)(struct resource *, void *));
 int kho_fill_kimage(struct kimage *image);
+int kho_commit_fdt(void);
 #else
 static inline int kho_locate_mem_hole(struct kexec_buf *kbuf,
 				      int (*func)(struct resource *, void *))
@@ -54,5 +55,6 @@ static inline int kho_locate_mem_hole(struct kexec_buf *kbuf,
 }
 
 static inline int kho_fill_kimage(struct kimage *image) { return 0; }
+static inline int kho_commit_fdt(void) { return 0; }
 #endif /* CONFIG_KEXEC_HANDOVER */
 #endif /* LINUX_KEXEC_INTERNAL_H */
diff --git a/mm/memblock.c b/mm/memblock.c
index 117d963e677c..978717d59a6f 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2001 Peter Bergner.
  */
 
+#include "asm-generic/memory_model.h"
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/init.h>
@@ -2510,39 +2511,6 @@ int reserve_mem_release_by_name(const char *name)
 #define RESERVE_MEM_KHO_NODE_COMPATIBLE "reserve-mem-v1"
 static struct page *kho_fdt;
 
-static int reserve_mem_kho_finalize(struct kho_serialization *ser)
-{
-	int err = 0, i;
-
-	for (i = 0; i < reserved_mem_count; i++) {
-		struct reserve_mem_table *map = &reserved_mem_table[i];
-
-		err |= kho_preserve_phys(map->start, map->size);
-	}
-
-	err |= kho_preserve_folio(page_folio(kho_fdt));
-	err |= kho_add_subtree(ser, MEMBLOCK_KHO_FDT, page_to_virt(kho_fdt));
-
-	return notifier_from_errno(err);
-}
-
-static int reserve_mem_kho_notifier(struct notifier_block *self,
-				    unsigned long cmd, void *v)
-{
-	switch (cmd) {
-	case KEXEC_KHO_FINALIZE:
-		return reserve_mem_kho_finalize((struct kho_serialization *)v);
-	case KEXEC_KHO_ABORT:
-		return NOTIFY_DONE;
-	default:
-		return NOTIFY_BAD;
-	}
-}
-
-static struct notifier_block reserve_mem_kho_nb = {
-	.notifier_call = reserve_mem_kho_notifier,
-};
-
 static int __init prepare_kho_fdt(void)
 {
 	int err = 0, i;
@@ -2583,7 +2551,7 @@ static int __init prepare_kho_fdt(void)
 
 static int __init reserve_mem_init(void)
 {
-	int err;
+	int err, i;
 
 	if (!kho_is_enabled() || !reserved_mem_count)
 		return 0;
@@ -2592,7 +2560,15 @@ static int __init reserve_mem_init(void)
 	if (err)
 		return err;
 
-	err = register_kho_notifier(&reserve_mem_kho_nb);
+	for (i = 0; i < reserved_mem_count; i++) {
+		struct reserve_mem_table *map = &reserved_mem_table[i];
+
+		err |= kho_preserve_phys(map->start, map->size);
+	}
+
+	err |= kho_preserve_folio(page_folio(kho_fdt));
+	err |= kho_add_subtree(MEMBLOCK_KHO_FDT, page_to_virt(kho_fdt));
+
 	if (err) {
 		put_page(kho_fdt);
 		kho_fdt = NULL;
-- 
2.51.0.384.g4c02a37b29-goog



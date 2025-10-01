Return-Path: <linux-kernel+bounces-838314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62051BAEF19
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 03:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C3E92A2347
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 01:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1AF1E5B88;
	Wed,  1 Oct 2025 01:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u4QSt/dG"
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E65F23C4F2
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 01:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759281592; cv=none; b=qpLP0X71b0JGHEWXI0pYM+rkYWqc8oLANlu2g7Q9IykybQdVQM2hJOMAEePsOIzWgt1WtOQNQBrD+2TNPfAQryvVJj6f9uCJKihsxTpbR4IiIlZ6Jj39J5yn2Hw5jlnBUJuYdUUEz9Fis092G8p4JN7/WcX009xwJqC6ku25AzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759281592; c=relaxed/simple;
	bh=wihiLfLip0evevk6YNvisggLUvvTyaQ0jFm7Qf/Wmic=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=e2332jh2n7lGucSP9TjRgEGhMQ0+HM0zy+tv+zyPuqLLpWWFxfgzaj9Igdi4I6OyN5iGiwpQ9R2QA+vb1a8Lq9NihrKnETUln7NvYjVkdIL0tUvzI+GwogBHaMLA9Bpru5YbihwYxufXEtR5mZDMFimp1ors39xv/WMHljd3/EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jasonmiu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u4QSt/dG; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jasonmiu.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-86df46fa013so528719085a.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 18:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759281590; x=1759886390; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ibfSbZvRgj9j6yQ0MCtEacyn1TcRaC1JpE6HwVQGXI=;
        b=u4QSt/dGmEpa1m+jsrcFcUx21Ql8H9lmxgDH14gnw3LMK09UBfAvBJSmcrTUCCKuJe
         VfmdJxJIgCSOzsVl2Smm8sehIh1PyNjRoOghnZ44N0P3GrMB9tfCxjBInMpBfLqMwD35
         rvf4T9z3IJRGTsMMBAaXpMgB5fKL3hjw8gyhYNLF26erxSYiO2OH8W1NReak7KWYQZZh
         ej26e3aeBjSX2SFBGTsE5rkkW5cAto42xEYLeIdsPs0g/sT/NxqosmTb/1DUNP+zx/kd
         iorZDhYBXO7ZuJV1PYVtv8pZPZjBbv0AoePMSs+ESldvS1rkmZAwrvf2ZkCKrKnI4Onz
         2bnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759281590; x=1759886390;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ibfSbZvRgj9j6yQ0MCtEacyn1TcRaC1JpE6HwVQGXI=;
        b=f8QHhdox1pjwkhYr8JWhgAHnySJqEFchBg0Vgdh2U5s09YiV/AiVRs3BIKyS6yjkf0
         Mdv7jQ78P77pNu/tscSaFmEvi4L+ueMPmggCuwD3CVfvj4rUBWCumJ/5/eFIdHgyxY7q
         8dqAaFppIQ+a3uVGaRzPafdg5R5u8Kb9B2VJ8TGGdTR4Wfqptnf7cgFvZBI6pBGnTjJ/
         lDihFkO1q3CSlfTATrbW15St/YM2Z4db9zq5creJ/G/RC68eQ+QaI30TNpnP0RnhUytB
         J/fpU2yH35MgmOf8MXRqauutSeEodiPE4a5J6p7fCTQlA9SAOZhGTqWDrIh7WQEEmM8H
         WM1A==
X-Forwarded-Encrypted: i=1; AJvYcCX6lHBAwM5K1FUNfF/cGsZUHZUE1HBYSRvKcYCvjwhFOx0VpRR3Tjiwx1/xvVNCnOPtnWskTFarKnuuNzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3wCGmRvVxsqF3ItCYCKiWwChuQpTgGmFKapCCnw7AGgw1LKb+
	mrWxWwviE/L5AZ2W/WgEnxYvXBIqdlXT/5Poy8aF0/Kv7OKH2ZQrkzkbCVG0ugMfXY3wRK6KQpc
	f6HN/ljjwpEqScA==
X-Google-Smtp-Source: AGHT+IGndh3BKmmwYu3HLjg8lqiwBwPnFbZVMWVM52TvRbv89JPU+RpTm1KO5ghpiMevFLIMLJgkTv9IkxTRLg==
X-Received: from qkpg1.prod.google.com ([2002:a05:620a:2781:b0:863:2d0a:f9a6])
 (user=jasonmiu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4723:b0:82e:6ec8:9887 with SMTP id af79cd13be357-87371172610mr285500485a.24.1759281589908;
 Tue, 30 Sep 2025 18:19:49 -0700 (PDT)
Date: Tue, 30 Sep 2025 18:19:40 -0700
In-Reply-To: <20251001011941.1513050-1-jasonmiu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251001011941.1513050-1-jasonmiu@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251001011941.1513050-3-jasonmiu@google.com>
Subject: [PATCH v1 2/3] memblock: Remove KHO notifier usage
From: Jason Miu <jasonmiu@google.com>
To: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Miu <jasonmiu@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Remove the KHO notifier registration and callbacks from the memblock
subsystem. These notifiers were tied to the former KHO finalize and
abort events, which are no longer used.

Memblock now preserves its `reserve_mem` regions and registers its
metadata by calling kho_preserve_phys(), kho_preserve_folio(), and
kho_add_subtree() directly within its initialization function.

Signed-off-by: Jason Miu <jasonmiu@google.com>
---
 include/linux/kexec_handover.h |  5 ++--
 kernel/kexec_handover.c        | 48 +++++++++++++++++++++-------------
 mm/memblock.c                  | 45 +++++++------------------------
 3 files changed, 42 insertions(+), 56 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index c8229cb11f4b..9566c90a3501 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -27,7 +27,7 @@ bool kho_is_enabled(void);
 int kho_preserve_folio(struct folio *folio);
 int kho_preserve_phys(phys_addr_t phys, size_t size);
 struct folio *kho_restore_folio(phys_addr_t phys);
-int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt);
+int kho_add_subtree(const char *name, void *fdt);
 int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
 
 int register_kho_notifier(struct notifier_block *nb);
@@ -58,8 +58,7 @@ static inline struct folio *kho_restore_folio(phys_addr_t phys)
 	return NULL;
 }
 
-static inline int kho_add_subtree(struct kho_serialization *ser,
-				  const char *name, void *fdt)
+static inline int kho_add_subtree(const char *name, void *fdt)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 34cf0ce4f359..ee4f430dfae0 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -640,9 +640,21 @@ static int kho_debugfs_fdt_add(struct list_head *list, struct dentry *dir,
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
@@ -655,16 +667,29 @@ static int kho_debugfs_fdt_add(struct list_head *list, struct dentry *dir,
  *
  * Return: 0 on success, error code on failure
  */
-int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt)
+int kho_add_subtree(const char *name, void *fdt)
 {
+	struct kho_serialization *ser = &kho_out.ser;
 	int err = 0;
+	int root_node_offset, subnode_offset;
 	u64 phys = (u64)virt_to_phys(fdt);
 	void *root = page_to_virt(ser->fdt);
 
-	err |= fdt_begin_node(root, name);
-	err |= fdt_property(root, PROP_SUB_FDT, &phys, sizeof(phys));
-	err |= fdt_end_node(root);
+	/* Reload the KHO root FDT to the same buffer */
+	err = fdt_open_into(root, root, PAGE_SIZE);
+	if (err)
+		return err;
+
+	root_node_offset = fdt_path_offset(fdt, "/");
+	if (root_node_offset < 0)
+		return root_node_offset;
+
+	subnode_offset = fdt_add_subnode(root, root_node_offset, name);
+	if (subnode_offset < 0)
+		return subnode_offset;
 
+	err = fdt_setprop(root, subnode_offset,
+			  PROP_SUB_FDT, &phys, sizeof(phys));
 	if (err)
 		return err;
 
@@ -672,19 +697,6 @@ int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt)
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
diff --git a/mm/memblock.c b/mm/memblock.c
index 117d963e677c..602a16cb467a 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2510,39 +2510,6 @@ int reserve_mem_release_by_name(const char *name)
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
@@ -2583,7 +2550,7 @@ static int __init prepare_kho_fdt(void)
 
 static int __init reserve_mem_init(void)
 {
-	int err;
+	int err, i;
 
 	if (!kho_is_enabled() || !reserved_mem_count)
 		return 0;
@@ -2592,7 +2559,15 @@ static int __init reserve_mem_init(void)
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
2.51.0.618.g983fd99d29-goog



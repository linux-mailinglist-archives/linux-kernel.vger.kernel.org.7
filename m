Return-Path: <linux-kernel+bounces-861949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB4EBF41B4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 02:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B61F634DA02
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 00:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C062137C52;
	Tue, 21 Oct 2025 00:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="bWwFgpFH"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E62273F9
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761005340; cv=none; b=ejK32tzKjtz16ALTh6MZaNOu75HPQzprikyMCSGhGN5/EjB8SKQk27AWZ4PdVRdWJ0HcR2dHYHOL7/SpN0GGUv/wwjxl/Lgj3Kz0yd7U6AHiz/kHbBn2zIWdT1mdVmXAww6WVSPA/o5Uw+3XtLEpFL93UCz6jRup+aqlH5hdhHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761005340; c=relaxed/simple;
	bh=WDnQ7yML0OCi7RtRqHYL6Y4X5Dr6aAb+8kQ+zx1g8z0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rg5bdSbvW39eghMfrku8yuIcCTPKCgpT0moPtjYSCc+PIBFfh7lX3XkjFHQSrAq/Q191RYLgqzXV56RSZt0l5pg6Hk/9g0yHtg+LL5qSfzhbkxx3NpNvUxVFJWAIEVcQJamXQrXBldbPMYRNoIuDKTlzckw4krBitkaEM9HhndM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=bWwFgpFH; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-554e726e5cfso1659208e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 17:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761005338; x=1761610138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RrUod6z9AaFkGeIJc9frhWccEivwV7gjE944YavE0C8=;
        b=bWwFgpFH1pI1SI+GzVHsrS5FPaSI5uSxIiy+lrX4pM3Pl5zPNf/rf4EKq9Zz3jOq0+
         /5NrgbtX5C9thIP6LgYKGIiQRIAdbrwwseNE1tmErB/LPyhA9pLtDwQgrPIancVCr9o6
         +cEf2X9WixQI1MUdSeai69IsWQznbYpA2V2gPF/R3AW9IBGPzZKKVtpbAMW2+iOXzTtY
         unDvKoqWpXGduuKljaMT1Yf55B4VSCpdSSZ0nSGnLK+H3K1iiHmpLGB4vpUvJinKd4IC
         34iGn3nwh2r8PpsYHUvY7NSx6LyZ4bnYQz5Nineot2T6J5dyT9fIIMiiXncLmi6/V+QS
         8aGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761005338; x=1761610138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RrUod6z9AaFkGeIJc9frhWccEivwV7gjE944YavE0C8=;
        b=F6xSPoxC8Rv5RJh4N8TLvbuO+tPWd7w3x+pWR5cOE7no9vXk3UrXlGhuwCU7dAR6WW
         /jfu+KY8N/M8IMLlwnMR6lb7GRl1Obu+DOXarJP+QM4wife51LUTUI8J5ddCX4SMQyWz
         957qS8OlZmj9VSfJaon4/CBMzupDoU+AtQi+RZ3zM1CZfmfs0RT7DXMvBp88FxsEbZrj
         Zz477sq1xrjICHzX0IfVpjnuc8q9vmV6ExeYKtU114L+BBr34ueQWXRwQQ7TrqecaWwT
         eAY7qjITxFdbR/uMjGtq3oE1VCzsY88hmi2qGiQ4P4lEefhIWcNc24VTETmdRdPvhUR0
         Eamw==
X-Forwarded-Encrypted: i=1; AJvYcCX+utKHP6jKVa82UkKPz7woeOaUUu4xpGzt88UvHNusANGqzNLnC8vjzIkpASu9btTMHbrLak/DEs8JqKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlKRVGBeTjPT6l2558vFS9B8iKBqYKQo93fE3y2Y34EpRA39Yz
	F7MvrmGxzSr3ziXB/tDRjYpmOs8dUZ34PMr3jqy0Sw0Os1CnRN5IG4Bc8ghzzw4stHc=
X-Gm-Gg: ASbGncsie6wvatW9TkvFhO1mxXvNIZ746CVA7jUw8eMnc7r048wIAwcApEapHsh8C9k
	POPzlTV4QkiXuY/n5BywMfQ7kypEowXgw36P/B3Dq3pOG+3xdfmrT6SbdcBrml8OTeD+MDQSQay
	3O0pNW8f6DzRibsLa2zGLTG/AuA1864oRkY0xGf1KrxC9hlxGeQDhz5D3XlFjqnwGsiSave2MbD
	WDoUPrImZMztmOZSEEaEEUe8sosRjSb1FnjtNso3ELLn1/eUAtPMTZ07Z+zxHdeRoCGoupr68my
	fC05gfwsPdYaLzdQlfl9Ptx3VkKRN7esp4ulNXEKSaQxBIyOQfJMdUiOOpl2MLf4mSLBMdF3YjE
	KxVmB4OnsJbydLtOHRUjeDpj2v8OmpnADCExMKpZ/u56Vo4jvmszSk7GOHI9IlIkO2i7u0j7mvu
	HFifDd1hdiwpb/4u7n9N8wvb1BY07+4aSd19w5KGLqC9CP5Oe9WsIzX0j8a+ilLnDsvJHeHNGpf
	N/bNuVw8demZKZS7c7b+16A/8OO3FSQ
X-Google-Smtp-Source: AGHT+IEXSBVMEN9foAesWnzieDCrIXltrdCTVWZ8zY0V+zYO9XF7MLbCmqXOk7hAXlRHd/2MI6iEIA==
X-Received: by 2002:a05:6122:1d13:b0:54b:bea6:a226 with SMTP id 71dfb90a1353d-5564ee6bfe3mr3839907e0c.11.1761005337567;
        Mon, 20 Oct 2025 17:08:57 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55661f6e351sm2822882e0c.4.2025.10.20.17.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 17:08:57 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	brauner@kernel.org,
	corbet@lwn.net,
	graf@amazon.com,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	masahiroy@kernel.org,
	ojeda@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	rppt@kernel.org,
	tj@kernel.org,
	jasonmiu@google.com,
	dmatlack@google.com,
	skhawaja@google.com
Subject: [PATCH v3 1/3] liveupdate: kho: warn and fail on metadata or preserved memory in scratch area
Date: Mon, 20 Oct 2025 20:08:50 -0400
Message-ID: <20251021000852.2924827-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.869.ge66316f041-goog
In-Reply-To: <20251021000852.2924827-1-pasha.tatashin@soleen.com>
References: <20251021000852.2924827-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is invalid for KHO metadata or preserved memory regions to be located
within the KHO scratch area, as this area is overwritten when the next
kernel is loaded, and used early in boot by the next kernel. This can
lead to memory corruption.

Adds checks to kho_preserve_* and KHO's internal metadata allocators
(xa_load_or_alloc, new_chunk) to verify that the physical address of the
memory does not overlap with any defined scratch region. If an overlap
is detected, the operation will fail and a WARN_ON is triggered. To
avoid performance overhead in production kernels, these checks are
enabled only when CONFIG_KEXEC_HANDOVER_DEBUG is selected.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/Kconfig.kexec             |  9 ++++++
 kernel/Makefile                  |  1 +
 kernel/kexec_handover.c          | 53 ++++++++++++++++++++++----------
 kernel/kexec_handover_debug.c    | 25 +++++++++++++++
 kernel/kexec_handover_internal.h | 16 ++++++++++
 5 files changed, 87 insertions(+), 17 deletions(-)
 create mode 100644 kernel/kexec_handover_debug.c
 create mode 100644 kernel/kexec_handover_internal.h

diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 422270d64820..c94d36b5fcd9 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -109,6 +109,15 @@ config KEXEC_HANDOVER
 	  to keep data or state alive across the kexec. For this to work,
 	  both source and target kernels need to have this option enabled.
 
+config KEXEC_HANDOVER_DEBUG
+	bool "Enable Kexec Handover debug checks"
+	depends on KEXEC_HANDOVER_DEBUGFS
+	help
+	  This option enables extra sanity checks for the Kexec Handover
+	  subsystem. Since, KHO performance is crucial in live update
+	  scenarios and the extra code might be adding overhead it is
+	  only optionally enabled.
+
 config CRASH_DUMP
 	bool "kernel crash dumps"
 	default ARCH_DEFAULT_CRASH_DUMP
diff --git a/kernel/Makefile b/kernel/Makefile
index df3dd8291bb6..9fe722305c9b 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_KEXEC_FILE) += kexec_file.o
 obj-$(CONFIG_KEXEC_ELF) += kexec_elf.o
 obj-$(CONFIG_KEXEC_HANDOVER) += kexec_handover.o
+obj-$(CONFIG_KEXEC_HANDOVER_DEBUG) += kexec_handover_debug.o
 obj-$(CONFIG_BACKTRACE_SELF_TEST) += backtracetest.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_CGROUPS) += cgroup/
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 76f0940fb485..7b460806ef4f 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt) "KHO: " fmt
 
+#include <linux/cleanup.h>
 #include <linux/cma.h>
 #include <linux/count_zeros.h>
 #include <linux/debugfs.h>
@@ -22,6 +23,7 @@
 
 #include <asm/early_ioremap.h>
 
+#include "kexec_handover_internal.h"
 /*
  * KHO is tightly coupled with mm init and needs access to some of mm
  * internal APIs.
@@ -133,26 +135,26 @@ static struct kho_out kho_out = {
 
 static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
 {
-	void *elm, *res;
+	void *res = xa_load(xa, index);
 
-	elm = xa_load(xa, index);
-	if (elm)
-		return elm;
+	if (res)
+		return res;
+
+	void *elm __free(kfree) = kzalloc(sz, GFP_KERNEL);
 
-	elm = kzalloc(sz, GFP_KERNEL);
 	if (!elm)
 		return ERR_PTR(-ENOMEM);
 
+	if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), sz)))
+		return ERR_PTR(-EINVAL);
+
 	res = xa_cmpxchg(xa, index, NULL, elm, GFP_KERNEL);
 	if (xa_is_err(res))
-		res = ERR_PTR(xa_err(res));
-
-	if (res) {
-		kfree(elm);
+		return ERR_PTR(xa_err(res));
+	else if (res)
 		return res;
-	}
 
-	return elm;
+	return no_free_ptr(elm);
 }
 
 static void __kho_unpreserve(struct kho_mem_track *track, unsigned long pfn,
@@ -345,15 +347,19 @@ static_assert(sizeof(struct khoser_mem_chunk) == PAGE_SIZE);
 static struct khoser_mem_chunk *new_chunk(struct khoser_mem_chunk *cur_chunk,
 					  unsigned long order)
 {
-	struct khoser_mem_chunk *chunk;
+	struct khoser_mem_chunk *chunk __free(kfree) = NULL;
 
 	chunk = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!chunk)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
+
+	if (WARN_ON(kho_scratch_overlap(virt_to_phys(chunk), PAGE_SIZE)))
+		return ERR_PTR(-EINVAL);
+
 	chunk->hdr.order = order;
 	if (cur_chunk)
 		KHOSER_STORE_PTR(cur_chunk->hdr.next, chunk);
-	return chunk;
+	return no_free_ptr(chunk);
 }
 
 static void kho_mem_ser_free(struct khoser_mem_chunk *first_chunk)
@@ -374,14 +380,17 @@ static int kho_mem_serialize(struct kho_serialization *ser)
 	struct khoser_mem_chunk *chunk = NULL;
 	struct kho_mem_phys *physxa;
 	unsigned long order;
+	int err = -ENOMEM;
 
 	xa_for_each(&ser->track.orders, order, physxa) {
 		struct kho_mem_phys_bits *bits;
 		unsigned long phys;
 
 		chunk = new_chunk(chunk, order);
-		if (!chunk)
+		if (IS_ERR(chunk)) {
+			err = PTR_ERR(chunk);
 			goto err_free;
+		}
 
 		if (!first_chunk)
 			first_chunk = chunk;
@@ -391,8 +400,10 @@ static int kho_mem_serialize(struct kho_serialization *ser)
 
 			if (chunk->hdr.num_elms == ARRAY_SIZE(chunk->bitmaps)) {
 				chunk = new_chunk(chunk, order);
-				if (!chunk)
+				if (IS_ERR(chunk)) {
+					err = PTR_ERR(chunk);
 					goto err_free;
+				}
 			}
 
 			elm = &chunk->bitmaps[chunk->hdr.num_elms];
@@ -409,7 +420,7 @@ static int kho_mem_serialize(struct kho_serialization *ser)
 
 err_free:
 	kho_mem_ser_free(first_chunk);
-	return -ENOMEM;
+	return err;
 }
 
 static void __init deserialize_bitmap(unsigned int order,
@@ -752,6 +763,9 @@ int kho_preserve_folio(struct folio *folio)
 	const unsigned int order = folio_order(folio);
 	struct kho_mem_track *track = &kho_out.ser.track;
 
+	if (WARN_ON(kho_scratch_overlap(pfn << PAGE_SHIFT, PAGE_SIZE << order)))
+		return -EINVAL;
+
 	return __kho_preserve_order(track, pfn, order);
 }
 EXPORT_SYMBOL_GPL(kho_preserve_folio);
@@ -775,6 +789,11 @@ int kho_preserve_pages(struct page *page, unsigned int nr_pages)
 	unsigned long failed_pfn = 0;
 	int err = 0;
 
+	if (WARN_ON(kho_scratch_overlap(start_pfn << PAGE_SHIFT,
+					nr_pages << PAGE_SHIFT))) {
+		return -EINVAL;
+	}
+
 	while (pfn < end_pfn) {
 		const unsigned int order =
 			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
diff --git a/kernel/kexec_handover_debug.c b/kernel/kexec_handover_debug.c
new file mode 100644
index 000000000000..6efb696f5426
--- /dev/null
+++ b/kernel/kexec_handover_debug.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * kexec_handover_debug.c - kexec handover optional debug functionality
+ * Copyright (C) 2025 Google LLC, Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+#define pr_fmt(fmt) "KHO: " fmt
+
+#include "kexec_handover_internal.h"
+
+bool kho_scratch_overlap(phys_addr_t phys, size_t size)
+{
+	phys_addr_t scratch_start, scratch_end;
+	unsigned int i;
+
+	for (i = 0; i < kho_scratch_cnt; i++) {
+		scratch_start = kho_scratch[i].addr;
+		scratch_end = kho_scratch[i].addr + kho_scratch[i].size;
+
+		if (phys < scratch_end && (phys + size) > scratch_start)
+			return true;
+	}
+
+	return false;
+}
diff --git a/kernel/kexec_handover_internal.h b/kernel/kexec_handover_internal.h
new file mode 100644
index 000000000000..05e9720ba7b9
--- /dev/null
+++ b/kernel/kexec_handover_internal.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef LINUX_KEXEC_HANDOVER_INTERNAL_H
+#define LINUX_KEXEC_HANDOVER_INTERNAL_H
+
+#include <linux/types.h>
+
+#ifdef CONFIG_KEXEC_HANDOVER_DEBUG
+bool kho_scratch_overlap(phys_addr_t phys, size_t size);
+#else
+static inline bool kho_scratch_overlap(phys_addr_t phys, size_t size)
+{
+	return false;
+}
+#endif /* CONFIG_KEXEC_HANDOVER_DEBUG */
+
+#endif /* LINUX_KEXEC_HANDOVER_INTERNAL_H */
-- 
2.51.0.869.ge66316f041-goog



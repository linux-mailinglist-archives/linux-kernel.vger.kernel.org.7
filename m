Return-Path: <linux-kernel+bounces-859551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2BABEDF0A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 08:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18EAF4E99F5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 06:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682C123D7D2;
	Sun, 19 Oct 2025 06:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msI7DX9w"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F168227E95
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 06:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760854638; cv=none; b=Vyc2BEleDKHeFUWn3mYBS2ejRvjrK8+QwKXZIW8J5vPyrG/LirGgRUXiGK1qJ55Z+iT9IBl6put1ILij33pCqluuH/20C9tRmaR6ry/JHTvIz2/izSDjxWp6yngE7gjgc/CpI26U8DO6WA07Vovy2E5KQH1RzbJRGq4D78RbTJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760854638; c=relaxed/simple;
	bh=zrBAJvFiT+CeBdAVAetTAzQV89CoIe6iukqirjunEs0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BkiZ13IppUoNGcn3CxpwqzwBovVyfEgDxWAj8uC7ijj38QHo6vIEzspVU+5VbY2Egf9AtTssPXW3MGnjof7yoHH0ed7Blfo3WcRfezsgF2NCFrlriWbKFguZ9EeLGNZ0Pvb6HthV3n3ntLAhpgO0D4gxG2R6w2s942zQdlxHEmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msI7DX9w; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-789fb76b466so2839480b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 23:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760854635; x=1761459435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIzBYAq5cauMEng/8nrVC1spI8sxNqVcm1FTDbL64Gs=;
        b=msI7DX9wOOv8lUuAocARZ0unaimtHlJPxbWxsF4eJJ9mXDCrsVap00Km3VoibDFbf8
         sUR8O7b5H8dlX1IuRFmXI+AgSTOpIH9T3u6ZrrdouKPkWhilcu3APk5JYPHZgICjbmC9
         gFPUPSHNS/g7sTUY6mBgEO6LJZRaRYs4AOiWvBXlvJXft3onrldRXMPkXXss2jHIHb3z
         1Sn1U4kG0d8Y2zwfa5Co3kHBqYJeZuRGudNVSkAEw1wxFmUB+T5hJ4beEeaNgOD7M+gq
         60JaxztuEWuhzM0UdkaDd0FUG/Wxk3Z3AxSvYZk9k2UEjcwp8CYIr4RQsuxCbhT8kB4H
         2gYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760854635; x=1761459435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SIzBYAq5cauMEng/8nrVC1spI8sxNqVcm1FTDbL64Gs=;
        b=mUlVCKzPb5zQh2RM3KQeAWrXyvFBZCuB8y54SSUgvIlpVWOOPOhq9sR8XvyoiF+Ya1
         loOtD5OoukWVdxM+s89XUTh/+EcDFhGn2xu0qIh5xuizl+NoGuYYnP+OUfP1dXA0e45E
         drEmIEfHaRwcXQXxHm4Tzl1FO3EQhEmyyFs6YriJsGb1mX1jSgJeZBKNCBpI4We5GJWB
         /VzdWbwTv001od9HYwi+nmgVjddrTk864QNwvneW5j3CvmfnbBtbEZ7UYDMBflHSasop
         Bj7/c8E8DBQOOpKZ4BwaqTTrRL7tsqYbHBgIbFeCFOxbLyaA4ItVQ6RP3n40johamv8m
         iTTA==
X-Gm-Message-State: AOJu0Ywg2MSHf5HykW4PqVlZC39GKaEQwZl732ykyXvHwWthPnJFsMVY
	Gj4R7zXvrKyOi4G8D2xyjwlzjkeGaMFZJUjDazRad/xwC7VhdjhnQq/Y5lcGSw==
X-Gm-Gg: ASbGncvjxNIS6RYXcqYiUHDZ37r8ZNQgyDNuLTf1cggOjKF+8qn8/JVg6T2orE8mW4s
	QrNApyKvST8c3+0FJ4iGPYER/vF2oqeReuUkKIsQ7+lImrzvzvEXieGZsTfYqZNntle9XG23GA3
	Gtqz+Selv5GPc4asP7nQEFxN0QlZrrpk4e4ez3UUVjGb6jR1/XETt5QvtgBFDS2tHRrlvL2vwIR
	B6v13Le8eEt9GLiWEO1xUbH7//zsI8SmE7Z7hyhYaCyESDUWvR29v5MabMIPA91F6qPGlkFnAIu
	RX8zbwRtdGcwJr70V+cxJ2MfhhS01InCU5xJI1PWCPItLoRPMpMmwXdG8+S6IBAxzk9ETcM8YiJ
	KYcBFE9s1sfQlsbV5il1ID3YovWd/rxnDw47j0ydkjbK8ViO5wOogwyuoWOIdBF8sGNsiALFcGu
	OhurDg
X-Google-Smtp-Source: AGHT+IHfF4hU8/QtsMDLLQvEjqsCa8w0BBb+2CNnqIZAGSLrLtnMeBv6KtywAED8Fp+17ZtBPczCAA==
X-Received: by 2002:a05:6a20:7355:b0:32d:b925:4a8 with SMTP id adf61e73a8af0-334a851519cmr11699864637.3.1760854635123;
        Sat, 18 Oct 2025 23:17:15 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:bc87:d8fe:3e55:7ffb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b6f302sm4332032a12.38.2025.10.18.23.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 23:17:14 -0700 (PDT)
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
Subject: [RFC Patch v2 12/16] multikernel: Introduce per-instance memory allocation interface
Date: Sat, 18 Oct 2025 23:16:26 -0700
Message-Id: <20251019061631.2235405-13-xiyou.wangcong@gmail.com>
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

Add virtual memory allocation interface for multikernel instances,
providing convenient high-level functions for memory management within
instance-specific memory pools with automatic virtual address mapping.

This commit introduces:

* Instance-based memory allocation functions (mk_instance_alloc() and
  mk_instance_free()) that provide virtual memory allocation from
  instance-specific memory pools with configurable alignment support
  and automatic physical-to-virtual address mapping using memremap().

* Kimage-based memory allocation wrappers (mk_kimage_alloc() and
  mk_kimage_free()) that provide convenient access to instance memory
  pools through kimage structures, commonly used in kexec code paths
  for multikernel operations.

* Automatic memory mapping infrastructure that uses memremap() with
  MEMREMAP_WB caching policy to provide write-back cached virtual
  addresses for allocated physical memory from instance pools.

* Proper error handling and cleanup with automatic rollback of
  physical allocations when virtual mapping fails, preventing memory
  leaks in error conditions.

The allocation functions complement the existing physical memory pool
management by providing a higher-level interface suitable for kernel
code that requires virtual addresses, such as buffer management, data
structure allocation, and inter-kernel communication buffers.

This interface enables multikernel subsystems to allocate kernel images,
initramfs etc., maintaining proper resource isolation between multikernel
instances.

Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 include/linux/multikernel.h |  6 +++
 kernel/multikernel/core.c   | 98 +++++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/include/linux/multikernel.h b/include/linux/multikernel.h
index c65d39a66b84..79611923649e 100644
--- a/include/linux/multikernel.h
+++ b/include/linux/multikernel.h
@@ -280,6 +280,12 @@ int mk_instance_reserve_resources(struct mk_instance *instance,
  */
 void mk_instance_free_memory(struct mk_instance *instance);
 
+void *mk_instance_alloc(struct mk_instance *instance, size_t size, size_t align);
+void mk_instance_free(struct mk_instance *instance, void *virt_addr, size_t size);
+
+void *mk_kimage_alloc(struct kimage *image, size_t size, size_t align);
+void mk_kimage_free(struct kimage *image, void *virt_addr, size_t size);
+
 /**
  * String conversion helpers
  */
diff --git a/kernel/multikernel/core.c b/kernel/multikernel/core.c
index 52bf8e38206a..ee7a21327ea5 100644
--- a/kernel/multikernel/core.c
+++ b/kernel/multikernel/core.c
@@ -7,7 +7,10 @@
 #include <linux/init.h>
 #include <linux/cpumask.h>
 #include <linux/cpu.h>
+#include <linux/io.h>
+#include <linux/kexec.h>
 #include <linux/multikernel.h>
+#include <asm/page.h>
 #include "internal.h"
 
 /**
@@ -403,6 +406,101 @@ int mk_instance_reserve_resources(struct mk_instance *instance,
 	return 0;
 }
 
+/**
+ * Per-instance memory pool management
+ */
+
+/**
+ * mk_instance_alloc() - Allocate memory from instance pool
+ * @instance: Instance to allocate from
+ * @size: Size to allocate
+ * @align: Alignment requirement (must be power of 2)
+ *
+ * Returns virtual address of allocated memory, or NULL on failure.
+ */
+void *mk_instance_alloc(struct mk_instance *instance, size_t size, size_t align)
+{
+	phys_addr_t phys_addr;
+	void *virt_addr;
+
+	if (!instance || !instance->instance_pool) {
+		pr_debug("mk_instance_alloc: instance %p has no pool\n", instance);
+		return NULL;
+	}
+
+	/* Allocate from instance pool with alignment */
+	phys_addr = multikernel_instance_alloc(instance->instance_pool, size, align);
+	if (!phys_addr) {
+		pr_debug("Failed to allocate %zu bytes from instance pool (align=0x%zx)\n", size, align);
+		return NULL;
+	}
+
+	/* Map to virtual address space */
+	virt_addr = memremap(phys_addr, size, MEMREMAP_WB);
+	if (!virt_addr) {
+		pr_err("Failed to map instance memory at 0x%llx\n", (unsigned long long)phys_addr);
+		multikernel_instance_free(instance->instance_pool, phys_addr, size);
+		return NULL;
+	}
+
+	return virt_addr;
+}
+
+/**
+ * mk_instance_free() - Free memory back to instance pool
+ * @instance: Instance to free to
+ * @virt_addr: Virtual address to free
+ * @size: Size to free
+ */
+void mk_instance_free(struct mk_instance *instance, void *virt_addr, size_t size)
+{
+	phys_addr_t phys_addr;
+
+	if (!instance || !instance->instance_pool || !virt_addr)
+		return;
+
+	phys_addr = virt_to_phys(virt_addr);
+	memunmap(virt_addr);
+	multikernel_instance_free(instance->instance_pool, phys_addr, size);
+}
+
+/**
+ * Kimage-based memory pool access functions
+ *
+ * These provide convenient wrappers for accessing instance memory pools
+ * through the kimage structure, commonly used in kexec code paths.
+ */
+
+/**
+ * mk_kimage_alloc() - Allocate memory from kimage's instance pool
+ * @image: kimage with associated mk_instance
+ * @size: Size to allocate
+ * @align: Alignment requirement (must be power of 2)
+ *
+ * Returns virtual address of allocated memory, or NULL on failure.
+ */
+void *mk_kimage_alloc(struct kimage *image, size_t size, size_t align)
+{
+	if (!image || !image->mk_instance)
+		return NULL;
+
+	return mk_instance_alloc(image->mk_instance, size, align);
+}
+
+/**
+ * mk_kimage_free() - Free memory back to kimage's instance pool
+ * @image: kimage with associated mk_instance
+ * @virt_addr: Virtual address to free
+ * @size: Size to free
+ */
+void mk_kimage_free(struct kimage *image, void *virt_addr, size_t size)
+{
+	if (!image || !image->mk_instance)
+		return;
+
+	mk_instance_free(image->mk_instance, virt_addr, size);
+}
+
 static int __init multikernel_init(void)
 {
 	int ret;
-- 
2.34.1



Return-Path: <linux-kernel+bounces-841585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 277B0BB7C0C
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 19:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09DEB19C615A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 17:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327F12DC329;
	Fri,  3 Oct 2025 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Azhuuh5S"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9509C2D8DAF
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759512769; cv=none; b=ZCBrKx1vfE3gakJoAzi2opfbXUO/O6qqjpZvDYGfQmpBQuN8dExd8seOf90aHnTXEzXZsilP+Co+VJRxfFA8M136bLJmlhInS6jso3UD2xUirolIqCdVArQ28uIbC+gZtgbwUwDX4KIiLWBc30k2je0/veaLQGxk6jVr3A9qHQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759512769; c=relaxed/simple;
	bh=s/PYXakXl6KqlrcIvciX5HalUknvMXRiakKCbQm7Wo4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E1xLomXTF7j4H1MWPEQAyCXeJneGFeOryQnchDQHzUUfkeRYEaYdUPPsP8DT74JTuHI8xbL1klr7QurXqF/SXgqkTjAvsZbFZRUjFeqUc4l0sE5aRuRN5beVIxoYnwZh3ltT3MVGmkcnq0LvJFSKs2qEoVW1bBbT4NewjRPVSb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Azhuuh5S; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e375dab7dso13299875e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 10:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759512766; x=1760117566; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zH+wdcZ5EVKOe0qHDw87x4CzKKpCZFkdrN8PVNJB6b4=;
        b=Azhuuh5SydWj16ep/xglqbw5m+AYh+zJ7zrrY8ROSt7PXHJu/M/JjG6HkAXsNLRjRl
         Slk/0cSXy/tw61c18Q22jBCpJfuTTfgUpNa4fcltcBZ25RAUtfCB3cjIh2XLR49weGoF
         QZ8HxZaSjy2HTHfWoe+jffO3M9Zq7yk8YMjHWn/1buDyIKCSQ16Gw3WMkCful3dUsTIj
         IRWdaIGTjNHtdPH6qMAvy/QEq2dFeB6mCRtggC3Sj5C0pAx4XoPbTzez+9UArmRDqqGl
         IMVSPbscg9D9wuQyMVlg9dyDm30gpcFHIv3QDiNr5Qw2XSfuylVGprLxb7t7Hx5EH7xn
         V15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759512766; x=1760117566;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zH+wdcZ5EVKOe0qHDw87x4CzKKpCZFkdrN8PVNJB6b4=;
        b=pD5t4agOo/xmHrh3USnHBuYYHSjDcXFsZfJdJq/BzMjxBBmxqN3boutYEuETx2BrSt
         7lJw2CV6p4Cac2u5zsPUQ4T7nXK/BqQNgiSBP9UUcrXBWRxxOaG7KCC1jtaPSUpLsMDQ
         eNqOhj3SH+A0LYZsNcHDPm3aedfSWyaBR6tpuDnzTSPLZOV6KWQy0dC1LvNqfWtM6+Ef
         KdiXJicUhq8+hNs0I8fPaNhGwuaXPfNh6eSOJFt7oQF3M9i7ADpADHCLuhlrW6HaLBSH
         5V+q9FD5jf069zVeXtAyUNQI+CvI+ZDQuLk7xC/OZQVnUlRxHlrlepua5+RCr4SMD/kK
         M6Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXZvtM7TVQ0+3+UB6Ubgclgm2GZ17Sj/Jdz7JQEvoCuA62eH1zJRGKqWbi7UdLWm0RA9M6CNZreUTfwS0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYkeTuHLo/qzF6AP0a5vvp/P88XZEgI5rN0NJk8giDoc6X+dun
	/VcCcmr6Xh5hp3pMVNGNNpFFO2hrP81KGDIZThB++nCgIe0wpOmQgK5Yj2E+JK4xTEZ28RVFCzZ
	Ak8JSBWvZZu2Llw==
X-Google-Smtp-Source: AGHT+IGYvWG9xmF2kfRie55mVv+1GfRjdSpkjQnJcV3+O9KPqIxqc19jwTdv3Ui/FR4E11nQtZ5ZDpq1J3nuCg==
X-Received: from wmbz22.prod.google.com ([2002:a05:600c:c096:b0:46e:6a75:2910])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a343:b0:459:d451:3364 with SMTP id 5b1f17b1804b1-46e71144103mr28980925e9.24.1759512766152;
 Fri, 03 Oct 2025 10:32:46 -0700 (PDT)
Date: Fri,  3 Oct 2025 17:32:26 +0000
In-Reply-To: <20251003173229.1533640-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003173229.1533640-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003173229.1533640-2-smostafa@google.com>
Subject: [RFC PATCH 1/4] drivers/iommu: Add page_ext for IOMMU_DEBUG_PAGEALLOC
From: Mostafa Saleh <smostafa@google.com>
To: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a new config IOMMU_DEBUG_PAGEALLOC, which registers new data to
page_ext.
This config will be used by the IOMMU API to track pages mapped in
the IOMMU to catch drivers trying to free kernel memory that they
still map in their domains, causing all types of memory corruption.
This behaviour is disabled by default and can be enabled using
kernel cmdline iommu.debug_pagealloc.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 ++++
 drivers/iommu/Kconfig                         | 14 ++++++++
 drivers/iommu/Makefile                        |  1 +
 drivers/iommu/iommu-debug.c                   | 32 +++++++++++++++++++
 include/linux/iommu-debug.h                   | 17 ++++++++++
 mm/page_ext.c                                 |  4 +++
 6 files changed, 74 insertions(+)
 create mode 100644 drivers/iommu/iommu-debug.c
 create mode 100644 include/linux/iommu-debug.h

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 74ca438d2d6d..b2691a5527dd 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2539,6 +2539,12 @@
 			1 - Bypass the IOMMU for DMA.
 			unset - Use value of CONFIG_IOMMU_DEFAULT_PASSTHROUGH.
 
+	iommu.debug_pagealloc=
+			[KNL,EARLY] When CONFIG_IOMMU_DEBUG_PAGEALLOC is set, this
+			parameter enables the feature at boot time. By default, it
+			is disabled and the system will work mostly the same as a
+			kernel built without CONFIG_IOMMU_DEBUG_PAGEALLOC.
+
 	io7=		[HW] IO7 for Marvel-based Alpha systems
 			See comment before marvel_specify_io7 in
 			arch/alpha/kernel/core_marvel.c.
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 70d29b14d851..5b40ec9b6e04 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -383,4 +383,18 @@ config SPRD_IOMMU
 
 	  Say Y here if you want to use the multimedia devices listed above.
 
+config IOMMU_DEBUG_PAGEALLOC
+	bool "Debug page memory allocations against IOMMU"
+	depends on DEBUG_PAGEALLOC && IOMMU_API && PAGE_EXTENSION
+	help
+		This config checks when a page is freed by the kernel
+		it's not mapped in any IOMMU domain. It can help with
+		debugging use-after-free from driver doing DMA.
+		This santaizer can have false-negative cases where some
+		problems won't be detected.
+		Expect overhead when enabling this + enabling the kernel
+		command line iommu.debug_pagealloc.
+
+		If unsure, say N here.
+
 endif # IOMMU_SUPPORT
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 355294fa9033..c834d3f70dfc 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -34,3 +34,4 @@ obj-$(CONFIG_IOMMU_SVA) += iommu-sva.o
 obj-$(CONFIG_IOMMU_IOPF) += io-pgfault.o
 obj-$(CONFIG_SPRD_IOMMU) += sprd-iommu.o
 obj-$(CONFIG_APPLE_DART) += apple-dart.o
+obj-$(CONFIG_IOMMU_DEBUG_PAGEALLOC) += iommu-debug.o
\ No newline at end of file
diff --git a/drivers/iommu/iommu-debug.c b/drivers/iommu/iommu-debug.c
new file mode 100644
index 000000000000..297a35137b38
--- /dev/null
+++ b/drivers/iommu/iommu-debug.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 - Google Inc
+ * Author: Mostafa Saleh <smostafa@google.com>
+ * IOMMU API santaizers and debug
+ */
+#include <linux/atomic.h>
+#include <linux/iommu-debug.h>
+#include <linux/kernel.h>
+#include <linux/page_ext.h>
+
+static bool needed;
+
+struct iommu_debug_metadate {
+	atomic_t ref;
+};
+
+static __init bool need_iommu_debug(void)
+{
+	return needed;
+}
+
+struct page_ext_operations page_iommu_debug_ops = {
+	.size = sizeof(struct iommu_debug_metadate),
+	.need = need_iommu_debug,
+};
+
+static int __init iommu_debug_pagealloc(char *str)
+{
+	return kstrtobool(str, &needed);
+}
+early_param("iommu.debug_pagealloc", iommu_debug_pagealloc);
diff --git a/include/linux/iommu-debug.h b/include/linux/iommu-debug.h
new file mode 100644
index 000000000000..a9c11855c4ed
--- /dev/null
+++ b/include/linux/iommu-debug.h
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 - Google Inc
+ * Author: Mostafa Saleh <smostafa@google.com>
+ * IOMMU API santaizers and debug
+ */
+
+#ifndef __LINUX_IOMMU_DEBUG_H
+#define __LINUX_IOMMU_DEBUG_H
+
+#ifdef CONFIG_IOMMU_DEBUG_PAGEALLOC
+
+extern struct page_ext_operations page_iommu_debug_ops;
+
+#endif /* CONFIG_IOMMU_DEBUG_PAGEALLOC */
+
+#endif /* __LINUX_IOMMU_DEBUG_H */
diff --git a/mm/page_ext.c b/mm/page_ext.c
index d7396a8970e5..37c764a55a0f 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -11,6 +11,7 @@
 #include <linux/page_table_check.h>
 #include <linux/rcupdate.h>
 #include <linux/pgalloc_tag.h>
+#include <linux/iommu-debug.h>
 
 /*
  * struct page extension
@@ -89,6 +90,9 @@ static struct page_ext_operations *page_ext_ops[] __initdata = {
 #ifdef CONFIG_PAGE_TABLE_CHECK
 	&page_table_check_ops,
 #endif
+#ifdef CONFIG_IOMMU_DEBUG_PAGEALLOC
+	&page_iommu_debug_ops,
+#endif
 };
 
 unsigned long page_ext_size;
-- 
2.51.0.618.g983fd99d29-goog



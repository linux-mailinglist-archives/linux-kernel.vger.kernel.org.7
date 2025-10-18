Return-Path: <linux-kernel+bounces-859320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B95BED4AE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69E0C4EEEA8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5302620C3;
	Sat, 18 Oct 2025 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="XjeXptLz"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E95E25CC4D
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 17:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760807889; cv=none; b=osQBBl2xh1egi83nVpDMIj0XkIuiSJqfaGXlHjqLylCy83ICc9NZDCQe2XFVOgHwtRO+aVUyFa9fg1pRMhhCHkDRd074UF5EEAtSoMyXtiUu5k8RVShBUWjsw3I91sM7+XqQSqnFxFQs1ik3AlhCNXRqhGryFzRID3U+iLN/Mnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760807889; c=relaxed/simple;
	bh=MTi0PLVYRQoSgU/xLE7NK8rQO/u6PQp/64/TJWga1Do=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hnNo9/BoNVhYw0TIMgNFv/Oj2Mdr9IAYIvL1b24OzROnZH4B05vC6CiA8kwcsL0vICliS+C37+GMuYbg9tiIz07fO47dvE1wdUk5tV8jJZgnhN6wvdhCbkfLMuaanxvcSmI6o/pd6qoqFRp7Q8X9KmXbgMbIxyXSKSu66EugvPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=XjeXptLz; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-791fd6bffbaso49428646d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 10:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760807886; x=1761412686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v0KGeztv4ESSWdWBh1iCylNw/kUGS87Mw2BS9HYjfV8=;
        b=XjeXptLzKhefRvc4jkE4ncJdGi5t4IxoAoBb/wzRNrugMrzODGfB3l2ogwcS4puAb+
         eHqxL1UnEKV8JF73W4dWWN/0YN+8l+Qo4+yeLwzbTRBkWEOwm7DpyCntm4DuthVR8fbc
         80hrT9L5Yve7FLwvisO2RsdCdu1+hVx6wWh51CS9Zr0vUxI+ZRTK4W5sJ7TmJuE4TCaX
         W62KGxM026Kk/zfq8+8QcXldjOOZPXoM45kvfv57m5CxgcrZgIsCVsxgOcNkISKcfBTM
         qi3e4B8Ji7FvzW60O3/swGuqtV7CFjvKlOpIF/AdLhkSctNLixpWWTD9jzEtcADtoQe0
         Qyxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760807886; x=1761412686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0KGeztv4ESSWdWBh1iCylNw/kUGS87Mw2BS9HYjfV8=;
        b=JBI8IcOdk7Xknk3FW/qmsBBxtFEi+tJuN8d8oJsTOEwlWuSBdx7aUBnx4uc9PLSh0R
         ITYiEfzZ+KypIfwHzHfDbS/yxe9ixqIZlRy4VRc5PbpwD2JpOUPk2VeHL1cAgJhKFkRm
         lchJOLS5rhONwCQByymgcX87W8XT24MnN7Qr4zAo4C64/BeZAluwpx6hFIsr8QX4sWUJ
         dcL1GI+4l7Pckpe5iVLbmmKYyUr4GgFVP56guKebguTqvfMpIwODH1KmmJhkyDMMydF9
         sQB3QBPN1CY0EC314PNCMBTedVzSsa0PezHL5CpGLv2LdArCgrVNbmW0oalqRSSarRHP
         DqYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/Fet3XvYzBEoAJL7QAMtjngSZWOIq3o7WGkwlpFFLN1NSiQe1Cb0qBJ3ZF+OQ1GHZEABp44rwPiTAV2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcr8peLhX19ezC4sAy8IK4PQRWJ8BvkUs9Ug/oT0HDda7lX/CJ
	EbfKOIpzuJSmZ8GgYzMB+J0A65NPePnC8JBIV4QhQASewRiNhRYralNwgWKVIBHdm0w=
X-Gm-Gg: ASbGncs6uAVi8rkd9GHby+Dlx756GG/hxjI8W6i6qVrqGIP9tl3GG0l5je6jzRUYBRH
	AqYY3+Kb6XXHZaKM6T6Vm1eNngYBJLvER/PkMVOQaa7bAB5uZwMQqKKvgUEuCseD36WLCCUlaD6
	1olCW91kXGIvaGtHGJGDLyd4AsX/Pj931/+Mh17HGAuADykaWWlw2k4gJB1RzWhb4ex8M5SFWrC
	pmd0DAfqLlPHh+KcxaogZYbyXxyfRzVt31SrO4z68VOHmdmogNuo6RkYlFciKAg8gqCYLo5uNoY
	dx10W13/niZHLCiVImMNb4JYAUncIKU2P1Yk4Jw4Fbhsg8+cpvuV1kjXpl9Z0E4+McB8IcnkNCg
	n/0nSYuAJgdj6LyoOWSH6xlcVK7k2Ec27oDqfcP7gA4xjVGkcIxRv9Pidj9ke6rWtxAA+YU39zN
	WkjDRWQKtjRGN/jL5F0QTOtbQaSYIyE5ILqG9SttURGfEGdIXrVnqIIRYFudX91au+gpi3cyrlm
	CXzadEmmZfg5HPt7vkq7KVeRWuYaQNZ33Dlyb2BM2o=
X-Google-Smtp-Source: AGHT+IErd3wQdsBbdwbR5WTIdnOJzNl17T2SsFZBA1bPXFw2Ejn8Q8idBkGg/OwcTd1BnjUf8btzoQ==
X-Received: by 2002:ad4:5ecb:0:b0:710:9995:ced4 with SMTP id 6a1803df08f44-87c2057f40amr111039536d6.17.1760807886240;
        Sat, 18 Oct 2025 10:18:06 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d02d8e909sm18478116d6.62.2025.10.18.10.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:18:05 -0700 (PDT)
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
Subject: [PATCH v6 06/10] liveupdate: kho: move to kernel/liveupdate
Date: Sat, 18 Oct 2025 13:17:52 -0400
Message-ID: <20251018171756.1724191-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
In-Reply-To: <20251018171756.1724191-1-pasha.tatashin@soleen.com>
References: <20251018171756.1724191-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move KHO to kernel/liveupdate/ in preparation of placing all Live Update
core kernel related files to the same place.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 Documentation/core-api/kho/concepts.rst       |  2 +-
 MAINTAINERS                                   |  2 +-
 init/Kconfig                                  |  2 ++
 kernel/Kconfig.kexec                          | 25 ----------------
 kernel/Makefile                               |  3 +-
 kernel/liveupdate/Kconfig                     | 30 +++++++++++++++++++
 kernel/liveupdate/Makefile                    |  4 +++
 kernel/{ => liveupdate}/kexec_handover.c      |  6 ++--
 .../{ => liveupdate}/kexec_handover_debugfs.c |  0
 .../kexec_handover_internal.h                 |  0
 10 files changed, 42 insertions(+), 32 deletions(-)
 create mode 100644 kernel/liveupdate/Kconfig
 create mode 100644 kernel/liveupdate/Makefile
 rename kernel/{ => liveupdate}/kexec_handover.c (99%)
 rename kernel/{ => liveupdate}/kexec_handover_debugfs.c (100%)
 rename kernel/{ => liveupdate}/kexec_handover_internal.h (100%)

diff --git a/Documentation/core-api/kho/concepts.rst b/Documentation/core-api/kho/concepts.rst
index 36d5c05cfb30..d626d1dbd678 100644
--- a/Documentation/core-api/kho/concepts.rst
+++ b/Documentation/core-api/kho/concepts.rst
@@ -70,5 +70,5 @@ in the FDT. That state is called the KHO finalization phase.
 
 Public API
 ==========
-.. kernel-doc:: kernel/kexec_handover.c
+.. kernel-doc:: kernel/liveupdate/kexec_handover.c
    :export:
diff --git a/MAINTAINERS b/MAINTAINERS
index 54f627a639b1..0e7fa104422c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13782,7 +13782,7 @@ S:	Maintained
 F:	Documentation/admin-guide/mm/kho.rst
 F:	Documentation/core-api/kho/*
 F:	include/linux/kexec_handover.h
-F:	kernel/kexec_handover*
+F:	kernel/liveupdate/kexec_handover*
 F:	tools/testing/selftests/kho/
 
 KEYS-ENCRYPTED
diff --git a/init/Kconfig b/init/Kconfig
index cab3ad28ca49..0605de5d96c0 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2138,6 +2138,8 @@ config TRACEPOINTS
 
 source "kernel/Kconfig.kexec"
 
+source "kernel/liveupdate/Kconfig"
+
 endmenu		# General setup
 
 source "arch/Kconfig"
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 03c3aa6263d3..15632358bcf7 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -94,31 +94,6 @@ config KEXEC_JUMP
 	  Jump between original kernel and kexeced kernel and invoke
 	  code in physical address mode via KEXEC
 
-config KEXEC_HANDOVER
-	bool "kexec handover"
-	depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXEC_FILE
-	depends on !DEFERRED_STRUCT_PAGE_INIT
-	select MEMBLOCK_KHO_SCRATCH
-	select KEXEC_FILE
-	select DEBUG_FS
-	select LIBFDT
-	select CMA
-	help
-	  Allow kexec to hand over state across kernels by generating and
-	  passing additional metadata to the target kernel. This is useful
-	  to keep data or state alive across the kexec. For this to work,
-	  both source and target kernels need to have this option enabled.
-
-config KEXEC_HANDOVER_DEBUGFS
-	bool "kexec handover debugfs interface"
-	depends on KEXEC_HANDOVER
-	depends on DEBUG_FS
-	help
-	  Allow to control kexec handover device tree via debugfs
-	  interface, i.e. finalize the state or aborting the finalization.
-	  Also, enables inspecting the KHO fdt trees with the debugfs binary
-	  blobs.
-
 config CRASH_DUMP
 	bool "kernel crash dumps"
 	default ARCH_DEFAULT_CRASH_DUMP
diff --git a/kernel/Makefile b/kernel/Makefile
index 06bfe691439b..e83669841b8c 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -52,6 +52,7 @@ obj-y += printk/
 obj-y += irq/
 obj-y += rcu/
 obj-y += livepatch/
+obj-y += liveupdate/
 obj-y += dma/
 obj-y += entry/
 obj-y += unwind/
@@ -82,8 +83,6 @@ obj-$(CONFIG_CRASH_DUMP_KUNIT_TEST) += crash_core_test.o
 obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_KEXEC_FILE) += kexec_file.o
 obj-$(CONFIG_KEXEC_ELF) += kexec_elf.o
-obj-$(CONFIG_KEXEC_HANDOVER) += kexec_handover.o
-obj-$(CONFIG_KEXEC_HANDOVER_DEBUGFS) += kexec_handover_debugfs.o
 obj-$(CONFIG_BACKTRACE_SELF_TEST) += backtracetest.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_CGROUPS) += cgroup/
diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
new file mode 100644
index 000000000000..cea287842475
--- /dev/null
+++ b/kernel/liveupdate/Kconfig
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+menu "Live Update and Kexec HandOver"
+
+config KEXEC_HANDOVER
+	bool "kexec handover"
+	depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXEC_FILE
+	depends on !DEFERRED_STRUCT_PAGE_INIT
+	select MEMBLOCK_KHO_SCRATCH
+	select KEXEC_FILE
+	select DEBUG_FS
+	select LIBFDT
+	select CMA
+	help
+	  Allow kexec to hand over state across kernels by generating and
+	  passing additional metadata to the target kernel. This is useful
+	  to keep data or state alive across the kexec. For this to work,
+	  both source and target kernels need to have this option enabled.
+
+config KEXEC_HANDOVER_DEBUGFS
+	bool "kexec handover debugfs interface"
+	depends on KEXEC_HANDOVER
+	depends on DEBUG_FS
+	help
+	  Allow to control kexec handover device tree via debugfs
+	  interface, i.e. finalize the state or aborting the finalization.
+	  Also, enables inspecting the KHO fdt trees with the debugfs binary
+	  blobs.
+
+endmenu
diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
new file mode 100644
index 000000000000..fcdf163b4b0e
--- /dev/null
+++ b/kernel/liveupdate/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o
+obj-$(CONFIG_KEXEC_HANDOVER_DEBUGFS)	+= kexec_handover_debugfs.o
diff --git a/kernel/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
similarity index 99%
rename from kernel/kexec_handover.c
rename to kernel/liveupdate/kexec_handover.c
index 89a8f839346b..c87d00c40c82 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -24,8 +24,8 @@
  * KHO is tightly coupled with mm init and needs access to some of mm
  * internal APIs.
  */
-#include "../mm/internal.h"
-#include "kexec_internal.h"
+#include "../../mm/internal.h"
+#include "../kexec_internal.h"
 #include "kexec_handover_internal.h"
 
 #define KHO_FDT_COMPATIBLE "kho-v1"
@@ -1124,7 +1124,7 @@ static int __kho_finalize(void)
 	err |= fdt_finish_reservemap(root);
 	err |= fdt_begin_node(root, "");
 	err |= fdt_property_string(root, "compatible", KHO_FDT_COMPATIBLE);
-	/**
+	/*
 	 * Reserve the preserved-memory-map property in the root FDT, so
 	 * that all property definitions will precede subnodes created by
 	 * KHO callers.
diff --git a/kernel/kexec_handover_debugfs.c b/kernel/liveupdate/kexec_handover_debugfs.c
similarity index 100%
rename from kernel/kexec_handover_debugfs.c
rename to kernel/liveupdate/kexec_handover_debugfs.c
diff --git a/kernel/kexec_handover_internal.h b/kernel/liveupdate/kexec_handover_internal.h
similarity index 100%
rename from kernel/kexec_handover_internal.h
rename to kernel/liveupdate/kexec_handover_internal.h
-- 
2.51.0.915.g61a8936c21-goog



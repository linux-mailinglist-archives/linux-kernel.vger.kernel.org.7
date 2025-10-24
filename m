Return-Path: <linux-kernel+bounces-869172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 38683C0736F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5EE52581315
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC373376A0;
	Fri, 24 Oct 2025 16:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="bCv0CBFE"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D5F3375A3
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 16:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322213; cv=none; b=Z+p5Vg2KQCc6MGczX1YIIDS3YhNlEKK2PCB7A8+LzVmVq0o28xErfwty0U7l9M1WtdQcKzpy3Y8OK0QvYZ/Y9SVh4th7k6OsP75ynZMNrP8WPTxXzh+8pVy0mxgoBOiH8dUFIUDFAdmf0hYBic/Ka9ybJcg82ldj1w0QsC/ngtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322213; c=relaxed/simple;
	bh=q4+9pj1LZkPHVsjDnnJgCMXpKmubt7lvzC50ITZTU3k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JtrgyhZEvhU01CUTd/dfCd3rTcvaCEpmJJjRK0MbvOtYo1Rpn8F/xPglOXTHbGYoFJVEvYQzYE/bTaVTN4ZSjTyZ1N8G1RSLbwyfpr2CvGh6vNFK7LPynKAppNVYeHXxoEMGl+GS1NV3wU4ZI1BbM3LXvEgkGYuZMt1Jt5rH6uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=bCv0CBFE; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-785db6b7484so11314397b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761322211; x=1761927011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sN3NXoZOBQaV0qk4GQkx+g1ZE3W0dyobKn95aWS8UQY=;
        b=bCv0CBFEWxh4vaJQrFBxMZVOqjISjA5+mpNAMUt6rdVsY/VGRkwAUqUt222Y1bE/Fy
         82ICQukormfU4kBQw7Yy/bmJjah+yJOQszVSDfFtsonbakcItmwXUs+ND+kAxNSiGZY6
         P/8svyI+Quwn8JOFfK18PD9GiTz9jBlHcofDvSHEBke/LioOfQLBCjpbifd640Bejokx
         MORLhRMZ7zc2TnO8RpgftWpcnABGKZvFejyZHfDWzfBi/jEtaFgQqRPEVuOVCzZ5ZdC3
         wCyVkj1qEiBj9p7ZyafJwF6qrySUBE+AxM0SVmmD+ixl5E/xs1m8syWZsEaQIzbRISJc
         eWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761322211; x=1761927011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sN3NXoZOBQaV0qk4GQkx+g1ZE3W0dyobKn95aWS8UQY=;
        b=ujCvyYiSyVoFY+KLj3qSddo0MeW+CZBAsiF/Wuk4EABsdbgpaM64hne+xN7T05gR1Q
         d7F2IMJBDeyj3kbsmkSikzT1W3H4BZQ1qZd5JFEDhQkipxAgknDNpCAiD2GKpFi0fcUh
         3NqkyjaY3MtrZhGEMMgM5ysoZp8zfhQBlvCJh6Mrxgc6EQLyzOvJbtvw5U87742bHpQn
         Xzzs4rA7pcdARC9jV2Ru4Zv98OI8MtfOt1c9I9vmuyKVNZrWTw/McV9FwVadPnT4IDv6
         LwJu0mNydVq+8zV2zmHls/lgBEWCZG8sC2JMSC/zMTILmjf4PqjOvBaGWXXoN23tHioh
         X4yg==
X-Forwarded-Encrypted: i=1; AJvYcCW/dKsFNcycgxYMTtLY8hmorSTeFGOoiCQwyjR14xiWLedeK23cMFXOORKlxC8joStzAXWeARXyOw86KbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnF6Gv9N7r7lJtKI2sCyVJe5kXNwIEttsuu4xHKIGzTWHFw07O
	greZEj90hrmFfkyivnv/UjKNDIm9feqM8BoWW2D3Z+RoZoqCgaHdZ8kZeei/LqkgMgk=
X-Gm-Gg: ASbGncufBG9kDLZhy6CcpJoWe0kzbZt+4I9129sHz+8PC/X86+SLwsY7OUvuFt2xqX5
	7YOkYEdnlvmoC2S+4glLrh+d4lTN1/gfxWN+P5etebIx+UgaLvEGHL1yyFf2l31n9bEnKhI/3R+
	qTzErTR8XvAH2DN04KJsq0Lh8harm2157wgLDXuhyAVIsBno7nB4uBr/yPyZqucv2g/GsWdTTV4
	kwbv/WKL314bbALkz8lOLWaoNJzwJxglxJtZ+64vbg++Dmuzil6fXxbVrQ86ifROl20CJ+5sGcV
	jSW5P8ssfpaD+53aqbQJNWBArEp2u+sjVYakVjSks+KZNyK8/rV/a+rIF3awjEk4UOwQaCuJG/e
	D6+emA/asmcFTihQW62J6BDcuMNF5aYuMsCx+39rSas2VBNTjFxpwms1LMDb+Mmy6fLoCl/WIT8
	s0y1mQWIc0ogFKgkCdlYOPwNMTR2CaGWeDEW06rKEfiskK6o86wUXFjr5STBk0A2moOm8IlQFdu
	JYw65PkBVG3HYEb5EIOSIumLRXCeRIVvQ==
X-Google-Smtp-Source: AGHT+IE2zX+p6Y3PDMVI3Fio8m3zVktQ5V7vVyOcKDfiGfYYf436D7pO0NOBbSVmVxYTK4k34aoLiQ==
X-Received: by 2002:a05:690c:4a06:b0:785:cf36:6b72 with SMTP id 00721157ae682-785cf366ba7mr65136627b3.50.1761322210780;
        Fri, 24 Oct 2025 09:10:10 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785cd6edd87sm14099197b3.51.2025.10.24.09.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 09:10:10 -0700 (PDT)
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
	tj@kernel.org
Subject: [PATCH v8 6/8] liveupdate: kho: move to kernel/liveupdate
Date: Fri, 24 Oct 2025 12:10:00 -0400
Message-ID: <20251024161002.747372-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
In-Reply-To: <20251024161002.747372-1-pasha.tatashin@soleen.com>
References: <20251024161002.747372-1-pasha.tatashin@soleen.com>
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
 init/Kconfig                                  |  2 +
 kernel/Kconfig.kexec                          | 34 ----------------
 kernel/Makefile                               |  4 +-
 kernel/liveupdate/Kconfig                     | 39 +++++++++++++++++++
 kernel/liveupdate/Makefile                    |  5 +++
 kernel/{ => liveupdate}/kexec_handover.c      |  4 +-
 .../{ => liveupdate}/kexec_handover_debug.c   |  0
 .../{ => liveupdate}/kexec_handover_debugfs.c |  0
 .../kexec_handover_internal.h                 |  0
 11 files changed, 51 insertions(+), 41 deletions(-)
 create mode 100644 kernel/liveupdate/Kconfig
 create mode 100644 kernel/liveupdate/Makefile
 rename kernel/{ => liveupdate}/kexec_handover.c (99%)
 rename kernel/{ => liveupdate}/kexec_handover_debug.c (100%)
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
index 35d7942b2082..400209b74d95 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13822,7 +13822,7 @@ S:	Maintained
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
index 9308a0fb1419..15632358bcf7 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -94,40 +94,6 @@ config KEXEC_JUMP
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
-config KEXEC_HANDOVER_DEBUG
-	bool "Enable Kexec Handover debug checks"
-	depends on KEXEC_HANDOVER_DEBUGFS
-	help
-	  This option enables extra sanity checks for the Kexec Handover
-	  subsystem. Since, KHO performance is crucial in live update
-	  scenarios and the extra code might be adding overhead it is
-	  only optionally enabled.
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
index 2cf7909a74e5..e83669841b8c 100644
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
@@ -82,9 +83,6 @@ obj-$(CONFIG_CRASH_DUMP_KUNIT_TEST) += crash_core_test.o
 obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_KEXEC_FILE) += kexec_file.o
 obj-$(CONFIG_KEXEC_ELF) += kexec_elf.o
-obj-$(CONFIG_KEXEC_HANDOVER) += kexec_handover.o
-obj-$(CONFIG_KEXEC_HANDOVER_DEBUG) += kexec_handover_debug.o
-obj-$(CONFIG_KEXEC_HANDOVER_DEBUGFS) += kexec_handover_debugfs.o
 obj-$(CONFIG_BACKTRACE_SELF_TEST) += backtracetest.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_CGROUPS) += cgroup/
diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
new file mode 100644
index 000000000000..ae8bdd87458a
--- /dev/null
+++ b/kernel/liveupdate/Kconfig
@@ -0,0 +1,39 @@
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
+config KEXEC_HANDOVER_DEBUG
+	bool "Enable Kexec Handover debug checks"
+	depends on KEXEC_HANDOVER_DEBUGFS
+	help
+	  This option enables extra sanity checks for the Kexec Handover
+	  subsystem. Since, KHO performance is crucial in live update
+	  scenarios and the extra code might be adding overhead it is
+	  only optionally enabled.
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
index 000000000000..f52ce1ebcf86
--- /dev/null
+++ b/kernel/liveupdate/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o
+obj-$(CONFIG_KEXEC_HANDOVER_DEBUG)	+= kexec_handover_debug.o
+obj-$(CONFIG_KEXEC_HANDOVER_DEBUGFS)	+= kexec_handover_debugfs.o
diff --git a/kernel/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
similarity index 99%
rename from kernel/kexec_handover.c
rename to kernel/liveupdate/kexec_handover.c
index 6aa25d304bad..20c7a985828c 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -26,8 +26,8 @@
  * KHO is tightly coupled with mm init and needs access to some of mm
  * internal APIs.
  */
-#include "../mm/internal.h"
-#include "kexec_internal.h"
+#include "../../mm/internal.h"
+#include "../kexec_internal.h"
 #include "kexec_handover_internal.h"
 
 #define KHO_FDT_COMPATIBLE "kho-v1"
diff --git a/kernel/kexec_handover_debug.c b/kernel/liveupdate/kexec_handover_debug.c
similarity index 100%
rename from kernel/kexec_handover_debug.c
rename to kernel/liveupdate/kexec_handover_debug.c
diff --git a/kernel/kexec_handover_debugfs.c b/kernel/liveupdate/kexec_handover_debugfs.c
similarity index 100%
rename from kernel/kexec_handover_debugfs.c
rename to kernel/liveupdate/kexec_handover_debugfs.c
diff --git a/kernel/kexec_handover_internal.h b/kernel/liveupdate/kexec_handover_internal.h
similarity index 100%
rename from kernel/kexec_handover_internal.h
rename to kernel/liveupdate/kexec_handover_internal.h
-- 
2.51.1.821.gb6fe4d2222-goog



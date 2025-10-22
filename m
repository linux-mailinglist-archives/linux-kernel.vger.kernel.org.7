Return-Path: <linux-kernel+bounces-863935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1BEBF98BF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 02:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AF3518C7AE4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 00:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4E921A457;
	Wed, 22 Oct 2025 00:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="lFRqTJQD"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AED51F5851
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761094650; cv=none; b=u8FuOtTooeiDbqTOJUaQVEi8C5dX2Q7zdkVm9JdnGMFmM2SR0g2i/sZJ8AS1LiDlZJDxoiz7l/HsSE6puM5X+yfzvYWnMbmVE9yQpyoRCSnkU8mzrgv++LrY+CpN3mljxSxzxMt7obdSSy0cGmQJBfWD4plbeaAPafz4T3B5DrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761094650; c=relaxed/simple;
	bh=NmbTUiBeJIAp3Sftn5nSMFfqUDzv5mGL6pZj0cOMllg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEgpiP1hYEKt4sn2Urs+dey83oMGHs8hd18foLbkoatVCPMPCATHdB8V2OSzNlIb8Pwcg6+cs57h65JOKjpksTDfM8LJi7csCEQMkpvcyTVokvztNa2nsW5do0mcHNKQHVA/4lZWXRxUg+54ZnPT65ou464HZGSp0rTzbBjEo7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=lFRqTJQD; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4e88cacc5d9so4612801cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761094647; x=1761699447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mkf+L3c0j3AWYDNtEMZGYy1f4Qen54RZIiHrdIXZ3Iw=;
        b=lFRqTJQDdisTf6d7Rqaba4I6QNt+aSqtFwpcD9nPvByFPkctF7bKExi+aPYQArmRH2
         X5KgELMLyBuqCTc0IZLf2HhgM3621A1C37h5UNKqKWYtcibwTOmiZFI/dv1bpnHnH/2d
         NisBpessdA94i8Uop5Ubfq8KBx+nQHkIeAqrdvYzauOPE7i3TboJ15Pl1lKj+XBA4jcR
         XoqncwSFPsZ3OYm6f8IWQ4WKPETncnTV2L3GnLVcRRalzWqbd194Mb9+GuUjavmXdvtP
         JxR4BD5SfMG/lQTRTlNGgqUYHDoAH4crqzOoWAMYz2iT+Qau6xFh+y8v5H1cOiKn3qL7
         hLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761094647; x=1761699447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mkf+L3c0j3AWYDNtEMZGYy1f4Qen54RZIiHrdIXZ3Iw=;
        b=LkM6Z0hIavTqrxe0/DQSO5nf3ZJzYPJB0owAVBxjnWBfs4XezGDuhzVa5q6LiVGjUu
         MksTkfmZhRUvWAYvsrrv5How8aANxNHxPm4tOOhClgbwzN7p9g3kqAp4q6QasCcK4OTv
         ATMpYxXIBLtDL7lxvyDuFaXZ67DEn16KWwgIW/QUqZyp3ruwjwWvN3G/jiAK1Lp+WMoz
         3yRkY0TRdziyA3uFw1ZiK2nbHOR8ZqLMvq6tG8P/4yIC762OtlahR8dwCyXurJBVQuee
         OdunACtq7g40mn/2Ns8vEzd7qTNxBLNdBJEk6zhtozrnYrSkJRoG2/Jskq88boTgf8hq
         SFvw==
X-Forwarded-Encrypted: i=1; AJvYcCVx70DnTyVkPOY95R3AqX0479IldQWH4LH0Ewnzt8wx9PCREZFgURHFy3Q+p4igYkhdwcA6ahYo1jiwWY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlAlZwnZfNV6wZ1QFmau+cVimeKqj6saYzL/wTxqD11UbabZra
	8M85o6sZCvRQfdQQqP3TCmctbWjIM6YtBOH/eFjlbudePMnKH8h/KWoUwI5SdMOCF8s=
X-Gm-Gg: ASbGncushVEcam2m5KJo7Ao1cVBYQ5zYXtPBFYYmZUrfZtiLbRp/0iaz1AdqxCHrP0U
	Tkwbl/yZwefUAmUSONBkgis40UDhTH7rYgbjPLuOuAZyoJwkgMWDWO0tLN5l4ihK7nY9qpSYPr0
	cif8XI/YDma33Qpp0cIuponEBd3+DlQbt6JVa3AWMi3CpE/YAD721JjJYuIN5iSvPDtsLRmqEGH
	1J9T9ZobPnR1eNo80S8QI1WNput05Z3e5o3vh4UlgZaT5IYh4UyeLbyqNX8suZYMaPMmdkR3+5a
	guH8LxS6rrNaM2l6Ss3s4hbAyms/ED7ItJjGa/PIOrz4QjsXuzDoMz4AqIACVygzOm3MeLjvly2
	DRIA0xygZNyj26QFnqDTWoAp9x7WlVfDszL+XVRTVH7oH9yNd1MLVtXDiISXYGde0ZivqZtjcsu
	sqJ4iwmn7MqkgMm4kQ2VCEBVE9cuIKzVdTK/KQ0hjZsjbKKxJEV9qibU9Sf27juOyImWJ14zru6
	0dM7dHmlkRKTfN9YUw5DcFNAHDMCt85
X-Google-Smtp-Source: AGHT+IEq405mhVu8WrJEowIq1Y0TON8S9urCYucYQMKi2jjKbXRB8hoU3h4s0GEYArtyzYzgjkDVKw==
X-Received: by 2002:ac8:57c2:0:b0:4b5:f6c5:cfc with SMTP id d75a77b69052e-4e89d274b1dmr235263421cf.19.1761094646848;
        Tue, 21 Oct 2025 17:57:26 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8aaf3432dsm84169501cf.2.2025.10.21.17.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 17:57:26 -0700 (PDT)
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
Subject: [PATCHv7 6/7] liveupdate: kho: move to kernel/liveupdate
Date: Tue, 21 Oct 2025 20:57:18 -0400
Message-ID: <20251022005719.3670224-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
In-Reply-To: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
References: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
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
index 0a6ba2717caa..eae55bb6ab4d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13781,7 +13781,7 @@ S:	Maintained
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
index 89a3fa89db0a..a1b97cc37cea 100644
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
2.51.0.915.g61a8936c21-goog



Return-Path: <linux-kernel+bounces-641023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CF4AB0C37
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 09:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70EC117D3AF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 07:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955772797BE;
	Fri,  9 May 2025 07:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hxB7BuzK"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A71278775
	for <linux-kernel@vger.kernel.org>; Fri,  9 May 2025 07:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746776848; cv=none; b=nm0eTzBhQXNEz0YI50vc8M/bjbRvcAORFtyo80PXjXc0NUDRj54WUgyNZ/GBzTSafpOTtfBVGEHcJQhkTerdrvfLZwK3P8i8kUkEEIASHykz8h8evnaUaVUPc6EiPt/IwBXbBxnjjHF/pvwUMnNIjgPhqifnrs9QLhjZ3A6+EV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746776848; c=relaxed/simple;
	bh=ObsPEGX+NhPTgP7vlB/gDzH3+fOUge8EEIL+9lyKplU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xtk96o/nTNv3Y4KiCadgYocg7HIS8/SS0Q7yK+dFo1zK0GaGg1UwrmsHu4IvZiZYeP0uHGUA5aXxlfcVbOcTfS2P23xG1fZNjJ0QLQZ39zgkJheFO7HAbwi6kYDQSXP88ULunZdJc/Ll/SXgYh9Dk9Fu1oiYDiIp3bu+zf1c31w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hxB7BuzK; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b115fb801bcso2071747a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 May 2025 00:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746776846; x=1747381646; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sb0xDDc7YSw9vlbf6vyh9gZiJJY31OMY2xg5VbrdlqY=;
        b=hxB7BuzKeeCWWssEv98K5fzby04JjljZOl85UP/QCsqYxxOMd9T0yvRrlsX9FE0DAd
         Me/XFy945lNGGHABWSequXVLGMT6FZHPErWZQYfKcECqkYi7gSDm7jZwmEWk+q6scv4k
         jW7MHoP1eT0Pe+5jIMwlJcyPQcazYhO0J38vqOKYgcfjbSiMBv/RZKgHePQ0s48G2oen
         IzZ7vjS9DYkuUwcKuv1gWcAkPoia1zPN8NJILbgWrHhitHsOxQNpiiWHDEJF9rCbVhwX
         xmnxwxqoxZ9eIzr04xStJRt7kihc6+FK50QeJDGMsKVLZeRzwVFacTr0lwAbM/TRWYLU
         qzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746776846; x=1747381646;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sb0xDDc7YSw9vlbf6vyh9gZiJJY31OMY2xg5VbrdlqY=;
        b=SCSlOMXTTNqJPWgbTuwBcGREV/gZi4tIK68XSo9xaFaEB9mgEhjAQOlDyzVa3//Z2x
         h37/1i5nFL+1Gci0w9qegFQkthkB9+ml9Idqp4TSgNGNrB2WttnP6jXISD0+MQ4Rd6N7
         fHWb03em0h91My42tjtFsTHWzvPQW12z11oI14aGvwpnsNk5eQrcWXtC+jBUUmNnK+UQ
         /rTVwyNN+yCQGx5gjEfcVXqs+JeVnC0KsOoXlRHO97sIKn1DEhDwnLYXX3RkqB6gvM0q
         CB+Ys1byMM5qAhqjMIZNqRYXgHVOnKlDmbz3fB9g0vFJchLlJGu2SX8JpVO4RH3x7oKw
         tBnA==
X-Forwarded-Encrypted: i=1; AJvYcCVrVFj8tN6+xCxXwHr6heoTFAqfsQKtke4m1PPGTK5laP9eC1pytElQ92rcBhB9CW+S6OWHw655lguIuy0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpk06KP6z1upqRNSZzZwIUIQ+EFNh/F4R+3y34fpRR3gExLpMW
	/4q22So1wSkEkqqR/5AekdhM+iggkBHuzMmtfY7FKPEYFFDXlu7PpnhQVrqNaKk+tUX9JAz07mV
	UVtBNaKlJdkA37mPnVg==
X-Google-Smtp-Source: AGHT+IE3UjCQdBNVzq/5rYyvWkxsWIxh1AeoKbe3XW7TUYj6kPT9RizggMaA5CyTUE66GTZU5ewpO0iiqdTsRvp7
X-Received: from pgbcr11.prod.google.com ([2002:a05:6a02:410b:b0:af2:54b0:c8d5])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3483:b0:1f5:59e5:8ada with SMTP id adf61e73a8af0-215abab9149mr3330178637.4.1746776845244;
 Fri, 09 May 2025 00:47:25 -0700 (PDT)
Date: Fri,  9 May 2025 00:46:34 -0700
In-Reply-To: <20250509074635.3187114-1-changyuanl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250509074635.3187114-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
Message-ID: <20250509074635.3187114-17-changyuanl@google.com>
Subject: [PATCH v8 16/17] Documentation: add documentation for KHO
From: Changyuan Lyu <changyuanl@google.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc: anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com, 
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com, 
	corbet@lwn.net, dave.hansen@linux.intel.com, devicetree@vger.kernel.org, 
	dwmw2@infradead.org, ebiederm@xmission.com, graf@amazon.com, hpa@zytor.com, 
	jgowans@amazon.com, kexec@lists.infradead.org, krzk@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, luto@kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	pasha.tatashin@soleen.com, pbonzini@redhat.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh@kernel.org, rostedt@goodmis.org, rppt@kernel.org, 
	saravanak@google.com, skinsburskii@linux.microsoft.com, tglx@linutronix.de, 
	thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org, 
	Changyuan Lyu <changyuanl@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Alexander Graf <graf@amazon.com>

With KHO in place, let's add documentation that describes what it is and
how to use it.

Signed-off-by: Alexander Graf <graf@amazon.com>
Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Co-developed-by: Changyuan Lyu <changyuanl@google.com>
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 .../admin-guide/kernel-parameters.txt         |  25 ++++
 Documentation/admin-guide/mm/index.rst        |   1 +
 Documentation/admin-guide/mm/kho.rst          | 115 ++++++++++++++++++
 Documentation/core-api/index.rst              |   1 +
 Documentation/core-api/kho/bindings/kho.yaml  |  43 +++++++
 .../core-api/kho/bindings/sub-fdt.yaml        |  27 ++++
 Documentation/core-api/kho/concepts.rst       |  74 +++++++++++
 Documentation/core-api/kho/fdt.rst            |  80 ++++++++++++
 Documentation/core-api/kho/index.rst          |  13 ++
 MAINTAINERS                                   |   2 +
 10 files changed, 381 insertions(+)
 create mode 100644 Documentation/admin-guide/mm/kho.rst
 create mode 100644 Documentation/core-api/kho/bindings/kho.yaml
 create mode 100644 Documentation/core-api/kho/bindings/sub-fdt.yaml
 create mode 100644 Documentation/core-api/kho/concepts.rst
 create mode 100644 Documentation/core-api/kho/fdt.rst
 create mode 100644 Documentation/core-api/kho/index.rst

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index d9fd26b95b340..54cb1d46e41f7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2725,6 +2725,31 @@
 	kgdbwait	[KGDB,EARLY] Stop kernel execution and enter the
 			kernel debugger at the earliest opportunity.
 
+	kho=		[KEXEC,EARLY]
+			Format: { "0" | "1" | "off" | "on" | "y" | "n" }
+			Enables or disables Kexec HandOver.
+			"0" | "off" | "n" - kexec handover is disabled
+			"1" | "on" | "y" - kexec handover is enabled
+
+	kho_scratch=	[KEXEC,EARLY]
+			Format: ll[KMG],mm[KMG],nn[KMG] | nn%
+			Defines the size of the KHO scratch region. The KHO
+			scratch regions are physically contiguous memory
+			ranges that can only be used for non-kernel
+			allocations. That way, even when memory is heavily
+			fragmented with handed over memory, the kexeced
+			kernel will always have enough contiguous ranges to
+			bootstrap itself.
+
+			It is possible to specify the exact amount of
+			memory in the form of "ll[KMG],mm[KMG],nn[KMG]"
+			where the first parameter defines the size of a low
+			memory scratch area, the second parameter defines
+			the size of a global scratch area and the third
+			parameter defines the size of additional per-node
+			scratch areas.  The form "nn%" defines scale factor
+			(in percents) of memory that was used during boot.
+
 	kmac=		[MIPS] Korina ethernet MAC address.
 			Configure the RouterBoard 532 series on-chip
 			Ethernet adapter MAC address.
diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-guide/mm/index.rst
index 8b35795b664be..2d2f6c222308f 100644
--- a/Documentation/admin-guide/mm/index.rst
+++ b/Documentation/admin-guide/mm/index.rst
@@ -42,3 +42,4 @@ the Linux memory management.
    transhuge
    userfaultfd
    zswap
+   kho
diff --git a/Documentation/admin-guide/mm/kho.rst b/Documentation/admin-guide/mm/kho.rst
new file mode 100644
index 0000000000000..6dc18ed4b8861
--- /dev/null
+++ b/Documentation/admin-guide/mm/kho.rst
@@ -0,0 +1,115 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+====================
+Kexec Handover Usage
+====================
+
+Kexec HandOver (KHO) is a mechanism that allows Linux to preserve memory
+regions, which could contain serialized system states, across kexec.
+
+This document expects that you are familiar with the base KHO
+:ref:`concepts <kho-concepts>`. If you have not read
+them yet, please do so now.
+
+Prerequisites
+=============
+
+KHO is available when the kernel is compiled with ``CONFIG_KEXEC_HANDOVER``
+set to y. Every KHO producer may have its own config option that you
+need to enable if you would like to preserve their respective state across
+kexec.
+
+To use KHO, please boot the kernel with the ``kho=on`` command line
+parameter. You may use ``kho_scratch`` parameter to define size of the
+scratch regions. For example ``kho_scratch=16M,512M,256M`` will reserve a
+16 MiB low memory scratch area, a 512 MiB global scratch region, and 256 MiB
+per NUMA node scratch regions on boot.
+
+Perform a KHO kexec
+===================
+
+First, before you perform a KHO kexec, you need to move the system into
+the :ref:`KHO finalization phase <kho-finalization-phase>` ::
+
+  $ echo 1 > /sys/kernel/debug/kho/out/finalize
+
+After this command, the KHO FDT is available in
+``/sys/kernel/debug/kho/out/fdt``. Other subsystems may also register
+their own preserved sub FDTs under
+``/sys/kernel/debug/kho/out/sub_fdts/``.
+
+Next, load the target payload and kexec into it. It is important that you
+use the ``-s`` parameter to use the in-kernel kexec file loader, as user
+space kexec tooling currently has no support for KHO with the user space
+based file loader ::
+
+  # kexec -l /path/to/bzImage --initrd /path/to/initrd -s
+  # kexec -e
+
+The new kernel will boot up and contain some of the previous kernel's state.
+
+For example, if you used ``reserve_mem`` command line parameter to create
+an early memory reservation, the new kernel will have that memory at the
+same physical address as the old kernel.
+
+Abort a KHO exec
+================
+
+You can move the system out of KHO finalization phase again by calling ::
+
+  $ echo 0 > /sys/kernel/debug/kho/out/active
+
+After this command, the KHO FDT is no longer available in
+``/sys/kernel/debug/kho/out/fdt``.
+
+debugfs Interfaces
+==================
+
+Currently KHO creates the following debugfs interfaces. Notice that these
+interfaces may change in the future. They will be moved to sysfs once KHO is
+stabilized.
+
+``/sys/kernel/debug/kho/out/finalize``
+    Kexec HandOver (KHO) allows Linux to transition the state of
+    compatible drivers into the next kexec'ed kernel. To do so,
+    device drivers will instruct KHO to preserve memory regions,
+    which could contain serialized kernel state.
+    While the state is serialized, they are unable to perform
+    any modifications to state that was serialized, such as
+    handed over memory allocations.
+
+    When this file contains "1", the system is in the transition
+    state. When contains "0", it is not. To switch between the
+    two states, echo the respective number into this file.
+
+``/sys/kernel/debug/kho/out/fdt``
+    When KHO state tree is finalized, the kernel exposes the
+    flattened device tree blob that carries its current KHO
+    state in this file. Kexec user space tooling can use this
+    as input file for the KHO payload image.
+
+``/sys/kernel/debug/kho/out/scratch_len``
+    Lengths of KHO scratch regions, which are physically contiguous
+    memory regions that will always stay available for future kexec
+    allocations. Kexec user space tools can use this file to determine
+    where it should place its payload images.
+
+``/sys/kernel/debug/kho/out/scratch_phys``
+    Physical locations of KHO scratch regions. Kexec user space tools
+    can use this file in conjunction to scratch_phys to determine where
+    it should place its payload images.
+
+``/sys/kernel/debug/kho/out/sub_fdts/``
+    In the KHO finalization phase, KHO producers register their own
+    FDT blob under this directory.
+
+``/sys/kernel/debug/kho/in/fdt``
+    When the kernel was booted with Kexec HandOver (KHO),
+    the state tree that carries metadata about the previous
+    kernel's state is in this file in the format of flattened
+    device tree. This file may disappear when all consumers of
+    it finished to interpret their metadata.
+
+``/sys/kernel/debug/kho/in/sub_fdts/``
+    Similar to ``kho/out/sub_fdts/``, but contains sub FDT blobs
+    of KHO producers passed from the old kernel.
diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index e9789bd381d80..7a4ca18ca6e2d 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -115,6 +115,7 @@ more memory-management documentation in Documentation/mm/index.rst.
    pin_user_pages
    boot-time-mm
    gfp_mask-from-fs-io
+   kho/index
 
 Interfaces for kernel debugging
 ===============================
diff --git a/Documentation/core-api/kho/bindings/kho.yaml b/Documentation/core-api/kho/bindings/kho.yaml
new file mode 100644
index 0000000000000..11e8ab7b219d9
--- /dev/null
+++ b/Documentation/core-api/kho/bindings/kho.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+title: Kexec HandOver (KHO) root tree
+
+maintainers:
+  - Mike Rapoport <rppt@kernel.org>
+  - Changyuan Lyu <changyuanl@google.com>
+
+description: |
+  System memory preserved by KHO across kexec.
+
+properties:
+  compatible:
+    enum:
+      - kho-v1
+
+  preserved-memory-map:
+    description: |
+      physical address (u64) of an in-memory structure describing all preserved
+      folios and memory ranges.
+
+patternProperties:
+  "$[0-9a-f_]+^":
+    $ref: sub-fdt.yaml#
+    description: physical address of a KHO user's own FDT.
+
+required:
+  - compatible
+  - preserved-memory-map
+
+additionalProperties: false
+
+examples:
+  - |
+    kho {
+        compatible = "kho-v1";
+        preserved-memory-map = <0xf0be16 0x1000000>;
+
+        memblock {
+                fdt = <0x80cc16 0x1000000>;
+        };
+    };
diff --git a/Documentation/core-api/kho/bindings/sub-fdt.yaml b/Documentation/core-api/kho/bindings/sub-fdt.yaml
new file mode 100644
index 0000000000000..b9a3d2d248501
--- /dev/null
+++ b/Documentation/core-api/kho/bindings/sub-fdt.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+title: KHO users' FDT address
+
+maintainers:
+  - Mike Rapoport <rppt@kernel.org>
+  - Changyuan Lyu <changyuanl@google.com>
+
+description: |
+  Physical address of an FDT blob registered by a KHO user.
+
+properties:
+  fdt:
+    description: |
+      physical address (u64) of an FDT blob.
+
+required:
+  - fdt
+
+additionalProperties: false
+
+examples:
+  - |
+    memblock {
+            fdt = <0x80cc16 0x1000000>;
+    };
diff --git a/Documentation/core-api/kho/concepts.rst b/Documentation/core-api/kho/concepts.rst
new file mode 100644
index 0000000000000..36d5c05cfb307
--- /dev/null
+++ b/Documentation/core-api/kho/concepts.rst
@@ -0,0 +1,74 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. _kho-concepts:
+
+=======================
+Kexec Handover Concepts
+=======================
+
+Kexec HandOver (KHO) is a mechanism that allows Linux to preserve memory
+regions, which could contain serialized system states, across kexec.
+
+It introduces multiple concepts:
+
+KHO FDT
+=======
+
+Every KHO kexec carries a KHO specific flattened device tree (FDT) blob
+that describes preserved memory regions. These regions contain either
+serialized subsystem states, or in-memory data that shall not be touched
+across kexec. After KHO, subsystems can retrieve and restore preserved
+memory regions from KHO FDT.
+
+KHO only uses the FDT container format and libfdt library, but does not
+adhere to the same property semantics that normal device trees do: Properties
+are passed in native endianness and standardized properties like ``regs`` and
+``ranges`` do not exist, hence there are no ``#...-cells`` properties.
+
+KHO is still under development. The FDT schema is unstable and would change
+in the future.
+
+Scratch Regions
+===============
+
+To boot into kexec, we need to have a physically contiguous memory range that
+contains no handed over memory. Kexec then places the target kernel and initrd
+into that region. The new kernel exclusively uses this region for memory
+allocations before during boot up to the initialization of the page allocator.
+
+We guarantee that we always have such regions through the scratch regions: On
+first boot KHO allocates several physically contiguous memory regions. Since
+after kexec these regions will be used by early memory allocations, there is a
+scratch region per NUMA node plus a scratch region to satisfy allocations
+requests that do not require particular NUMA node assignment.
+By default, size of the scratch region is calculated based on amount of memory
+allocated during boot. The ``kho_scratch`` kernel command line option may be
+used to explicitly define size of the scratch regions.
+The scratch regions are declared as CMA when page allocator is initialized so
+that their memory can be used during system lifetime. CMA gives us the
+guarantee that no handover pages land in that region, because handover pages
+must be at a static physical memory location and CMA enforces that only
+movable pages can be located inside.
+
+After KHO kexec, we ignore the ``kho_scratch`` kernel command line option and
+instead reuse the exact same region that was originally allocated. This allows
+us to recursively execute any amount of KHO kexecs. Because we used this region
+for boot memory allocations and as target memory for kexec blobs, some parts
+of that memory region may be reserved. These reservations are irrelevant for
+the next KHO, because kexec can overwrite even the original kernel.
+
+.. _kho-finalization-phase:
+
+KHO finalization phase
+======================
+
+To enable user space based kexec file loader, the kernel needs to be able to
+provide the FDT that describes the current kernel's state before
+performing the actual kexec. The process of generating that FDT is
+called serialization. When the FDT is generated, some properties
+of the system may become immutable because they are already written down
+in the FDT. That state is called the KHO finalization phase.
+
+Public API
+==========
+.. kernel-doc:: kernel/kexec_handover.c
+   :export:
diff --git a/Documentation/core-api/kho/fdt.rst b/Documentation/core-api/kho/fdt.rst
new file mode 100644
index 0000000000000..62505285d60d6
--- /dev/null
+++ b/Documentation/core-api/kho/fdt.rst
@@ -0,0 +1,80 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+=======
+KHO FDT
+=======
+
+KHO uses the flattened device tree (FDT) container format and libfdt
+library to create and parse the data that is passed between the
+kernels. The properties in KHO FDT are stored in native format.
+It includes the physical address of an in-memory structure describing
+all preserved memory regions, as well as physical addresses of KHO users'
+own FDTs. Interpreting those sub FDTs is the responsibility of KHO users.
+
+KHO nodes and properties
+========================
+
+Property ``preserved-memory-map``
+---------------------------------
+
+KHO saves a special property named ``preserved-memory-map`` under the root node.
+This node contains the physical address of an in-memory structure for KHO to
+preserve memory regions across kexec.
+
+Property ``compatible``
+-----------------------
+
+The ``compatible`` property determines compatibility between the kernel
+that created the KHO FDT and the kernel that attempts to load it.
+If the kernel that loads the KHO FDT is not compatible with it, the entire
+KHO process will be bypassed.
+
+Property ``fdt``
+----------------
+
+Generally, a KHO user serialize its state into its own FDT and instructs
+KHO to preserve the underlying memory, such that after kexec, the new kernel
+can recover its state from the preserved FDT.
+
+A KHO user thus can create a node in KHO root tree and save the physical address
+of its own FDT in that node's property ``fdt`` .
+
+Examples
+========
+
+The following example demonstrates KHO FDT that preserves two memory
+regions created with ``reserve_mem`` kernel command line parameter::
+
+  /dts-v1/;
+
+  / {
+  	compatible = "kho-v1";
+
+	preserved-memory-map = <0x40be16 0x1000000>;
+
+  	memblock {
+		fdt = <0x1517 0x1000000>;
+  	};
+  };
+
+where the ``memblock`` node contains an FDT that is requested by the
+subsystem memblock for preservation. The FDT contains the following
+serialized data::
+
+  /dts-v1/;
+
+  / {
+  	compatible = "memblock-v1";
+
+  	n1 {
+  		compatible = "reserve-mem-v1";
+  		start = <0xc06b 0x4000000>;
+  		size = <0x04 0x00>;
+  	};
+
+  	n2 {
+  		compatible = "reserve-mem-v1";
+  		start = <0xc067 0x4000000>;
+  		size = <0x04 0x00>;
+  	};
+  };
diff --git a/Documentation/core-api/kho/index.rst b/Documentation/core-api/kho/index.rst
new file mode 100644
index 0000000000000..0c63b0c5c1436
--- /dev/null
+++ b/Documentation/core-api/kho/index.rst
@@ -0,0 +1,13 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+========================
+Kexec Handover Subsystem
+========================
+
+.. toctree::
+   :maxdepth: 1
+
+   concepts
+   fdt
+
+.. only::  subproject and html
diff --git a/MAINTAINERS b/MAINTAINERS
index 5e2b121263437..72345ca65edda 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13144,6 +13144,8 @@ M:	Mike Rapoport <rppt@kernel.org>
 M:	Changyuan Lyu <changyuanl@google.com>
 L:	kexec@lists.infradead.org
 S:	Maintained
+F:	Documentation/admin-guide/mm/kho.rst
+F:	Documentation/core-api/kho/*
 F:	include/linux/kexec_handover.h
 F:	kernel/kexec_handover.c
 
-- 
2.49.0.1015.ga840276032-goog



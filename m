Return-Path: <linux-kernel+bounces-846155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6008BBC728C
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 04:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DC6CE34E46B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 02:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF58B212FB9;
	Thu,  9 Oct 2025 01:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Nar8BDH7"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573941A9FBA
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 01:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759975148; cv=none; b=Cbgw++r/cTosQn/h0Kfol3dBo3wizLzsk26TC13cClXM/H+CJUBRuRe3uWKwuof7qpIPnTWgnNJNaX4WIlQ4frFpQPR/mn6TmY7egoOpPmchOZIGIPmgQr0LW79mThIFZNiMErHDvWUAOkcyzWe4xdduQBF8AIZYG5VWRngV+JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759975148; c=relaxed/simple;
	bh=jf8ZZ2QTLngdYSbRm87h7uM6F8czWgbYRxr7b+eNIRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0QCJMMX2w/76OVQnjqbjRFFKhm+G6Kl1Yn9QZuFyg38is/kO1prj0SGWpFIo3FI+hfByV+HF+mJVfDDom4z70E5AvLlp8ltXz1iC+d28wBbKhxPXeRzZtT2rjdunJL7Xnt/ShLmEJmE3vrLTe+j7FMgLWrHKsIiUr1Kmgl3bDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Nar8BDH7; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-279e2554c8fso4062765ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 18:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1759975139; x=1760579939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRBm+Pg8TyGJGYp2jCQm+1zXWV7khrVi/kELEVhXf6I=;
        b=Nar8BDH7jNGC8rHtMRaFBcV02DQ+8V47EhkMi6UqvAF0PR6irM5M/QXU61pFyMHf9I
         3XKnUvQez0Sqz/tHFOow/tk44Pd8FsK1D2FXnVvEo7w+EX9/+abbvHYkButW7atU3wbF
         2KqOiafiNqQWbuHkpXnR1QNlHr0uErTyiAO4AFXUiGRkSmWtn3+6bILqizrSzbcel7/F
         2uDBEDein/jPuvKO1ARlk+6Xa5f8PqStb1UfheOu954xIBble+JxVb537MT/99Y7L7Zq
         N7/fNm8+hxeZIK+aUyP6M8hW+wUDdm8J6QFsCk4e1hHwlowueuszodK3xhOdMDq9sQxW
         nt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759975139; x=1760579939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRBm+Pg8TyGJGYp2jCQm+1zXWV7khrVi/kELEVhXf6I=;
        b=Q3hvrlT8URxHiKe7EeCgWXDagnHR3KSE5TknDh6W6jCHun0ntLGTsNd2KYOTPmb/Gm
         LamZal/EE5z2vSJlVh9+YNf2Zgv9e5ndw4EA4egbq9uKW1mFG1OEkKgYoGDaXgPfOA6x
         uKeZx55ijhJYjQQl9DNrlbIDbvgepXD/g3oFFiBzAJKOvfJ6RN7S6iiWVAfgjOJu1YiB
         sv6PBJirk3l4LZ/d3CC+dIX/fYyZWk4i5sQVNk0sgVtC+TkwKPZR9X18IxrAT+UzhSyE
         FWS06q2Q0gwRThNO20FTmYX/LC7I0bhiKo0pG25KVor2m5HXya78BFxKX6y5JJleYzoq
         GTrQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8+W1Clj0BL4DUJLUIudtvE6KoPgeTrJ0ib8sVdLM0JwlgR3YjjtTrAHIWccX/TRcJTb5MDd6fHO7NTOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO0jwhHFNRyUhfl7blBXy4mQhPKEWMX2ZEO3WOKu8j/kq07FkX
	BKGwWHTHcgZz+WpgsBrP2j9U4dlXUf+QorC59WFa0DcT/ze0v5YyWjdr6Ti+4tZ6FJM=
X-Gm-Gg: ASbGnctTH0kwPz3DNcsMa3jpY6OswOq2e8KjQGuqatFQDNhcwICOzCN1s2dHXEOBc5D
	tQg/ShuCLFs2gNDeXVdEfbqvjYqL8OprM6PJlvDMaMGCvLjAjO93m6KkT7ut536t49rN+mi0XD8
	ySBJ9v0OYvA+/ajPacjFqFbsrmpnrVl5wefezZ1JTWtZKWSaBjwwed5iGZvPzWKPg0q+SEmN1v2
	Xps2yvVxONlk2NvcjS61BRPNtIZRifqrfPRKzMD1Zzs+CF0zkOuYf3XIx04boHRitkHpwAe89MO
	EtyyZ5Lew/HIjc+J6PbQWRTx2kGicesH9hDgDyyYUyI96AGsh/Nn6DjdDMgoHEMZTBe+vtQ+AUh
	t9c9yaOqXtgzXE53ExDvtLA6x7bWOjx1zsbQv6nJ19hXM3Jq6pDFGUlKbmmNrGwFKvR/Y/ao/oN
	6BFRs=
X-Google-Smtp-Source: AGHT+IHnM19QNt+KVU6ihXNJt4W+kfmuE2lNld1taoppLPPH4Aa0tlEl4j47mz2vz9hZfmhsxUhEJQ==
X-Received: by 2002:a17:903:144f:b0:28e:9427:68f6 with SMTP id d9443c01a7336-29027262579mr68191475ad.27.1759975139512;
        Wed, 08 Oct 2025 18:58:59 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de53f9sm11033585ad.14.2025.10.08.18.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 18:58:59 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Conor Dooley <conor@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 15/18] dt-bindings: riscv: Describe physical memory regions
Date: Wed,  8 Oct 2025 18:57:51 -0700
Message-ID: <20251009015839.3460231-16-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251009015839.3460231-1-samuel.holland@sifive.com>
References: <20251009015839.3460231-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Information about physical memory regions is needed by both the kernel
and M-mode firmware. For example, the kernel needs to know about
noncacheable aliases of cacheable memory in order to allocate coherent
memory pages for DMA. M-mode firmware needs to know about those aliases
so it can protect itself from lower-privileged software.

The RISC-V Privileged Architecture delegates the description of Physical
Memory Attributes (PMAs) to the platform. On DT-based platforms, it
makes sense to put this information in the devicetree.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - Remove references to Physical Address Width (no longer part of Smmpt)
 - Remove special first entry from the list of physical memory regions
 - Fix compatible string in example

 .../bindings/riscv/physical-memory.yaml       | 91 +++++++++++++++++++
 include/dt-bindings/riscv/physical-memory.h   | 44 +++++++++
 2 files changed, 135 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/physical-memory.yaml
 create mode 100644 include/dt-bindings/riscv/physical-memory.h

diff --git a/Documentation/devicetree/bindings/riscv/physical-memory.yaml b/Documentation/devicetree/bindings/riscv/physical-memory.yaml
new file mode 100644
index 0000000000000..825b712a9fbae
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/physical-memory.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/physical-memory.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V Physical Memory Regions
+
+maintainers:
+  - Samuel Holland <samuel.holland@sifive.com>
+
+description:
+  The RISC-V Privileged Architecture defines a number of Physical Memory
+  Attributes (PMAs) which apply to a given region of memory. These include the
+  types of accesses (read, write, execute, LR/SC, and/or AMO) allowed within
+  a region, the supported access widths and alignments, the cacheability and
+  coherence of the region, and whether or not accesses to the region may have
+  side effects.
+
+  Some RISC-V platforms provide multiple physical address mappings for main
+  memory or certain peripherals. Each alias of a region generally has different
+  PMAs (e.g. cacheable vs non-cacheable), which allows software to dynamically
+  select the PMAs for an access by referencing the corresponding alias.
+
+  On DT-based RISC-V platforms, this information is provided by the
+  riscv,physical-memory-regions property of the root node.
+
+properties:
+  $nodename:
+    const: '/'
+
+  riscv,physical-memory-regions:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    description:
+      Each table entry provides PMAs for a specific physical memory region,
+      which must not overlap with any other table entry.
+    minItems: 1
+    maxItems: 256
+    items:
+      minItems: 4
+      maxItems: 6
+      additionalItems: true
+      items:
+        - description: CPU physical address (#address-cells)
+        - description: >
+            Size (#size-cells). For entry 0, if the size is zero, the size is
+            assumed to be 2^(32 * #size-cells).
+        - description: >
+            Flags describing the most restrictive PMAs for any address within
+            the region.
+
+            The least significant byte indicates the types of accesses allowed
+            for this region. Note that a memory region may support a type of
+            access (e.g. AMOs) even if the CPU does not.
+
+            The next byte describes the cacheability, coherence, idempotency,
+            and ordering PMAs for this region. It also includes a flag to
+            indicate that accesses to a region are unsafe and must be
+            prohibited by software (for example using PMPs or Smmpt).
+
+            The third byte is reserved for future PMAs.
+
+            The most significant byte is the index of the lowest-numbered entry
+            which this entry is an alias of, if any. Aliases need not be the
+            same size, for example if a smaller memory region repeats within a
+            larger alias.
+        - description: Reserved for describing future PMAs
+
+additionalProperties: true
+
+examples:
+  - |
+    #include <dt-bindings/riscv/physical-memory.h>
+
+    / {
+      compatible = "beagle,beaglev-starlight-jh7100-r0", "starfive,jh7100";
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      riscv,physical-memory-regions =
+          <0x00 0x18000000 0x00 0x00020000 (PMA_RWX | PMA_NONCACHEABLE_MEMORY) 0x0>,
+          <0x00 0x18080000 0x00 0x00020000 (PMA_RWX | PMA_NONCACHEABLE_MEMORY) 0x0>,
+          <0x00 0x41000000 0x00 0x1f000000 (PMA_RWX | PMA_NONCACHEABLE_MEMORY) 0x0>,
+          <0x00 0x61000000 0x00 0x1f000000 (PMA_RWXA | PMA_NONCOHERENT_MEMORY | PMR_ALIAS(3)) 0x0>,
+          <0x00 0x80000000 0x08 0x00000000 (PMA_RWXA | PMA_NONCOHERENT_MEMORY) 0x0>,
+          <0x10 0x00000000 0x08 0x00000000 (PMA_RWX | PMA_NONCACHEABLE_MEMORY | PMR_ALIAS(5)) 0x0>,
+          <0x20 0x00000000 0x10 0x00000000 (PMA_RWX | PMA_NONCACHEABLE_MEMORY) 0x0>,
+          <0x30 0x00000000 0x10 0x00000000 (PMA_RWXA | PMA_NONCOHERENT_MEMORY | PMR_ALIAS(7)) 0x0>;
+    };
+
+...
diff --git a/include/dt-bindings/riscv/physical-memory.h b/include/dt-bindings/riscv/physical-memory.h
new file mode 100644
index 0000000000000..7cb2e58fa8c1c
--- /dev/null
+++ b/include/dt-bindings/riscv/physical-memory.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_RISCV_PHYSICAL_MEMORY_H
+#define _DT_BINDINGS_RISCV_PHYSICAL_MEMORY_H
+
+#define PMA_READ			(1 << 0)
+#define PMA_WRITE			(1 << 1)
+#define PMA_EXECUTE			(1 << 2)
+#define PMA_AMO_MASK			(3 << 4)
+#define PMA_AMO_NONE			(0 << 4)
+#define PMA_AMO_SWAP			(1 << 4)
+#define PMA_AMO_LOGICAL			(2 << 4)
+#define PMA_AMO_ARITHMETIC		(3 << 4)
+#define PMA_RSRV_MASK			(3 << 6)
+#define PMA_RSRV_NONE			(0 << 6)
+#define PMA_RSRV_NON_EVENTUAL		(1 << 6)
+#define PMA_RSRV_EVENTUAL		(2 << 6)
+
+#define PMA_RW				(PMA_READ | PMA_WRITE)
+#define PMA_RWA				(PMA_RW | PMA_AMO_ARITHMETIC | PMA_RSRV_EVENTUAL)
+#define PMA_RWX				(PMA_RW | PMA_EXECUTE)
+#define PMA_RWXA			(PMA_RWA | PMA_EXECUTE)
+
+#define PMA_ORDER_MASK			(3 << 8)
+#define PMA_ORDER_IO_RELAXED		(0 << 8)
+#define PMA_ORDER_IO_STRONG		(1 << 8)
+#define PMA_ORDER_MEMORY		(2 << 8)
+#define PMA_READ_IDEMPOTENT		(1 << 10)
+#define PMA_WRITE_IDEMPOTENT		(1 << 11)
+#define PMA_CACHEABLE			(1 << 12)
+#define PMA_COHERENT			(1 << 13)
+
+#define PMA_UNSAFE			(1 << 15)
+
+#define PMA_IO				(PMA_ORDER_IO_RELAXED)
+#define PMA_NONCACHEABLE_MEMORY		(PMA_ORDER_MEMORY | PMA_READ_IDEMPOTENT | \
+						PMA_WRITE_IDEMPOTENT)
+#define PMA_NONCOHERENT_MEMORY		(PMA_NONCACHEABLE_MEMORY | PMA_CACHEABLE)
+#define PMA_NORMAL_MEMORY		(PMA_NONCOHERENT_MEMORY | PMA_COHERENT)
+
+#define PMR_ALIAS_MASK			(0xff << 24)
+#define PMR_ALIAS(n)			((n) << 24)
+
+#endif /* _DT_BINDINGS_RISCV_PHYSICAL_MEMORY_H */
-- 
2.47.2



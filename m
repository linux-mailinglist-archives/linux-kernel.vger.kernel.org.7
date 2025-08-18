Return-Path: <linux-kernel+bounces-772816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2092B297E7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A775E0212
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FDC264F99;
	Mon, 18 Aug 2025 04:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ERXBJMcl"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E34226159E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755490301; cv=none; b=blL+GVv7z8z/gKBLWTDP4x7UNz77Gk95MIRwZrgGODmyx1mELnMqyyZL+5FqWodjkFczq+JLVFYxZUGsEj86ZYEpmYJCLYg8a9DHWtebZ1A8bcjJWhZQAKfLWDhoKHDJ7mgznYJWPiw6V67dM6gDNNkEbb66TEi/M/j8/V4DFnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755490301; c=relaxed/simple;
	bh=sbelvMc++opfxCsxTvRuuhoDW5jErxOHLIiEYhi1zkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAW+mYrYUmocXbyGHnW4NbIr21hpucvPKRrCIGEeLy9eO2u+EKgFs85QYD6FzmMjNznf42cTvqAivVSnfsz2VfLzFCIaH6SgWwWxxVzC/wWcy60TnCjV5e6lJMzMMT5KJatuLVtCKQ92fVZVAw66yKdWihKZd68Xh+zXfGPrATs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ERXBJMcl; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32326bd4f4dso3220656a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 21:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755490298; x=1756095098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9cEkN+1nA6DRTpT1SF2rNqhyyXGV6gcs+oqiG40Gi8=;
        b=ERXBJMclsE4chFS0m76s5q7wvD+1Eunmjup2+QRL2wRs7WDMhNxZ1eUJbUWErokQPi
         1nNfHl6M1TQs8RkJvpQSW3EdGkz4Rzx0YQLetgM8abFL50F5ZNTNWYPiLEJiHMdjaYow
         2dmAxem/KAHk/nBdEo82Kg3avNXvboEYuq38zNSeR+4q5Z02XjDfSwgBH5iL+FlnfLZM
         4CkXVJK+SZPR9Onal7N5GTNp0zRgG7HZUEPuyKKBirMU7YSs18NE6T7zLHevYUEPLhco
         jTOBM5rDOmKi26QRfAku0nqaQFPTn6898v/LxN/ktj50lTwNy/+OhsLBQnRQLHqzn31T
         VlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755490298; x=1756095098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9cEkN+1nA6DRTpT1SF2rNqhyyXGV6gcs+oqiG40Gi8=;
        b=XeiZyuqHnij71r8LCycIuMILggzHqNDGUMAaNcJYJPceweVpduvExGZgjtn9K000eV
         PcKjfudaejUrUpz9btVyhj+5q8T9cYU2F2ehEheR85Dcek3GUZaYJQeamX58pXpRTe8q
         JyzgbXe0QjVdBCwk/P7yEc/y2USrNDS5AigT8po5I3/2dGo5E3EePDI8rjKenokbyBNA
         U7pOZhT+fKB5GT6UnhkMZQ75nYSwegvuu9GUz3hZma+KlWtf3vsxtEo87mDghiinxnd6
         /omP/bR1me9MzgByzJJ7jvvAm3Q/l98hCidv+EGN1az2iJ7lwvcI5gwVhRZvEMkk+She
         xB3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6fRRzslC4f2TYbeO31mWcgnekVfH//v0Cqb15G//M/4fBmKCr4u5isuos3VFImrVpH/ASvw/mrAekZUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG5V93tpLnurI83UcN/5PVh4Pdhrg9AdwtVTIYi21+N4swM3mJ
	j+X2nA3L3cniiSo08sEcYeW0CFJU1EMOMb/UqkHVnsk68RsR305HxRlrGUlnJk9s/p8=
X-Gm-Gg: ASbGnctfr8wGj5h0Hfh0p+JVEIxUuTmvFPjD1x3vuMtUBHvAcryPjOEATP6TPP9Fw1b
	zj4lXWHdyyTqUE9eT6PtD1G6BuMLxVBXtlZ1q+Hi2aTMrXsHkcbHWFIoDlD3axXo3L/IplU47Ik
	cJBm6I7TQkryPXPEcKyA4Pbi6wPGwCjgQ9RKpvzDChJnjCG8Cuzng1ptmU/56uTEJjW8D0zjudk
	YRN4oUwD19Htg6symZl0XqNmUaUONFUQuyejCdhTY8s9lAvKxfJN01i6isks+f/50ombiM6hs/E
	tQMuH0XDEAnkI1vU99xoY16sdaGV0AJTvW73Er6uDNUnWdOOWp9824fVfnKL30OhyNjwDbIWyzD
	1bT4O/6HjTRv23XI25t2wHLOzWcT1ow56NN6zHx0q1I4lD1IvZmWsbGFPe829/x6Q
X-Google-Smtp-Source: AGHT+IFtbujOl+Pcx84ey4TUZu9YiGYdI2B8x59/rDGP8fO39Jouq7TSzRgIg0yzVLZAS0ibf52XRQ==
X-Received: by 2002:a17:90b:28d0:b0:321:90c0:bc62 with SMTP id 98e67ed59e1d1-323402f2115mr13772005a91.5.1755490298256;
        Sun, 17 Aug 2025 21:11:38 -0700 (PDT)
Received: from localhost.localdomain ([122.171.17.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32343c70356sm6560972a91.25.2025.08.17.21.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:11:37 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Len Brown <lenb@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Rahul Pathak <rpathak@ventanamicro.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v10 11/24] dt-bindings: Add RPMI system MSI message proxy bindings
Date: Mon, 18 Aug 2025 09:39:07 +0530
Message-ID: <20250818040920.272664-12-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818040920.272664-1-apatel@ventanamicro.com>
References: <20250818040920.272664-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree bindings for the RPMI system MSI service group
based message proxy implemented by the SBI implementation (machine
mode firmware or hypervisor).

The RPMI system MSI service group is defined by the RISC-V
platform management interface (RPMI) specification.

Reviewed-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 .../riscv,rpmi-mpxy-system-msi.yaml           | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,rpmi-mpxy-system-msi.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,rpmi-mpxy-system-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,rpmi-mpxy-system-msi.yaml
new file mode 100644
index 000000000000..1991f5c7446a
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,rpmi-mpxy-system-msi.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/riscv,rpmi-mpxy-system-msi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V RPMI system MSI service group based message proxy
+
+maintainers:
+  - Anup Patel <anup@brainfault.org>
+
+description: |
+  The RISC-V Platform Management Interface (RPMI) [1] defines a
+  messaging protocol which is modular and extensible. The supervisor
+  software can send/receive RPMI messages via SBI MPXY extension [2]
+  or some dedicated supervisor-mode RPMI transport.
+
+  The RPMI specification [1] defines system MSI service group which
+  allow application processors to receive MSIs upon system events
+  such as P2A doorbell, graceful shutdown/reboot request, CPU hotplug
+  event, memory hotplug event, etc from the platform microcontroller.
+  The SBI implementation (machine mode firmware or hypervisor) can
+  implement an SBI MPXY channel to allow RPMI system MSI service
+  group access to the supervisor software.
+
+  ===========================================
+  References
+  ===========================================
+
+  [1] RISC-V Platform Management Interface (RPMI) v1.0 (or higher)
+      https://github.com/riscv-non-isa/riscv-rpmi/releases
+
+  [2] RISC-V Supervisor Binary Interface (SBI) v3.0 (or higher)
+      https://github.com/riscv-non-isa/riscv-sbi-doc/releases
+
+properties:
+  compatible:
+    description:
+      Intended for use by the SBI implementation.
+    const: riscv,rpmi-mpxy-system-msi
+
+  mboxes:
+    maxItems: 1
+    description:
+      Mailbox channel of the underlying RPMI transport.
+
+  riscv,sbi-mpxy-channel-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The SBI MPXY channel id to be used for providing RPMI access to
+      the supervisor software.
+
+required:
+  - compatible
+  - mboxes
+  - riscv,sbi-mpxy-channel-id
+
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-controller {
+        compatible = "riscv,rpmi-mpxy-system-msi";
+        mboxes = <&rpmi_shmem_mbox 0x2>;
+        riscv,sbi-mpxy-channel-id = <0x2000>;
+    };
+...
-- 
2.43.0



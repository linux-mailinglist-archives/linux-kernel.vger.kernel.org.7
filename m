Return-Path: <linux-kernel+bounces-772806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC1CB297C8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A050219605FC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4189218E97;
	Mon, 18 Aug 2025 04:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="B+u3T5/X"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A854825F98E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755490216; cv=none; b=lvx5prCdU4XLX3wxAoZbTWR+xJC5V1yrtQyL/jwj17o4SCixXW/Wo4dMdGPKsDQ+jdiu8cQsVrqBa7WNI9k46o2rUNJDmXXHSY3SUwou5hMKsqNlsPqG7A0tYvC3w2wNzfCkBh74711mK5DstOUH6fJcad6SMX8CjauElvVOvsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755490216; c=relaxed/simple;
	bh=B3l9G9xHfhvz8EaPHO3ldfTP94vcz4sc4fSmpOQNlnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYS2u2RfoZjPFjDASFWzlJKJoOLnDC1MH/eoCSgJ4g3kiWGWjyRoyzSW7yhIYDvnexHI5MLM7zTKx/mxNhOFiX5QJut80zPUcxcbsvuPVdDtXcqhVxfWADS+PFczDi+t5lqGpGe93yKu3cOAxS5aX+JSXyUz5puLnEj/wc9d8YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=B+u3T5/X; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-323267b98a4so3014062a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 21:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755490214; x=1756095014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ziNNelNAtU8Lu0O2/2Qc6bW/trdK9/SPi3ZGrwyyiyE=;
        b=B+u3T5/XSaigjDCpYmttYhPtbyFVQRN4oUwnwVHCSzM3YIMn6JqsvEZ6cSkNRDUb1d
         PyM6LKmZh709mx5pU/cE12uFDNvBc1m6/RCcTk+k9E9Qg+AwzEcr6mHhaK59EkB/kgWu
         hWV5CfvZComAUrG5bOmgYlwIj+qsLQC8QsUmd+kjKcYyC96liNkuBpDgS7X3jyrj4t7K
         JDa4dxNKH2AD2x9+fd9O7r9luDLwkPYbuK+ykIdafeP8IAY2pFesJwwkvPH4Hxy5gYij
         x4gLUx/gYnOzmNa4202+JgAHKSz4hfFITm7yTBnNjbv/+I4BgKcRFfvHZKMFeZAIcqkz
         6kxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755490214; x=1756095014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ziNNelNAtU8Lu0O2/2Qc6bW/trdK9/SPi3ZGrwyyiyE=;
        b=BmmJoPuDVeqf5IolR4CzdjPd7r3D4vxrthGQL4QlQk1ZZCiWuaksrdmBslnXBDqusn
         ErgBEEehV9iKuSRaF89DmmidAy9wXbVj7QvGkVZLA4Mz3EttfLLBCFqlkgHr0rsuCH4F
         aa2YkJWVBN+Af51c3W7VWuv8mWBu75+8TWP7JLBqLyZgD0Rx+15u32vPK4DlvJzi1tYK
         lQsDQnQz3ocDEiM66zbluAhKsauU6gAFHK8fF/zMvp4v+I2vFop4eKqHpQ+nbs7kjlYZ
         sPKS1fjJdHypRCxs9DcCnn/G4qUdwwEXgqCMLsncqxXLa4SokmPrhVa2ZmvBQvzLCV2B
         v11Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNAiMK3qoWOOyxanIqYt5Z+ZUqTqWDR64cSuwLcgiuYHD48kVvWQDpi2dM/9DwkW+gTYsWguWgYCG3YNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx16e7GNe27zLorREMB3brgAZ+OLfIdwS7QKXkEvFsD+t8BcVQW
	qimW+B5FOKGjGXeXCKDuku6e9LqDMHSeSSDdELCu3OenHLHGif/1lvFg/zYAhISigxg=
X-Gm-Gg: ASbGncvufT1LPqvjoImwhd9xEsf4c6CBP1pRanJ13IHG2TWDIMovetaNh5ge5vgdsa6
	sUzUKbVgotyTZZ6TOh5KNjB6unyyBQxNOZPvGV3yauTC2QVraUmfqRNFF4PFgTq4ODf9FsdPher
	tuzPZCysn20EfZ3+1y7Qx72dBCysM//TkoQ3TlosEQ3jb28hqeGFTyGkuJZGGQA3pgDxgNP7JX0
	HewH3bzP6VGnC2mL+6BqkXF+yxTyqugiZy5a4pmzRqbe+4GFEo9h1BJRHtUgsUHlnk2w678zBrp
	ioMxFhC12pI0FufrXRaxDY8kjEOvsaz+cQovUsgh/WNx4h4MwjdqBsBfQikY0gwmIslJgpefcOt
	ibhcM8NBE/uTsy1RtaCzilKCmeUuFYiVv1TXwa+OJqj7xcpCHZNUJ5A==
X-Google-Smtp-Source: AGHT+IHMNebFrKVgEbBD6mfihQGB/VR29QLpmoagvRz83lEg7IdszC5949YqyCiOGwslywTtFiY3Kg==
X-Received: by 2002:a17:90b:53c3:b0:31f:134:94ae with SMTP id 98e67ed59e1d1-3234db8e252mr10650482a91.11.1755490213616;
        Sun, 17 Aug 2025 21:10:13 -0700 (PDT)
Received: from localhost.localdomain ([122.171.17.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32343c70356sm6560972a91.25.2025.08.17.21.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:10:13 -0700 (PDT)
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
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v10 01/24] dt-bindings: mailbox: Add bindings for RPMI shared memory transport
Date: Mon, 18 Aug 2025 09:38:57 +0530
Message-ID: <20250818040920.272664-2-apatel@ventanamicro.com>
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

Add device tree bindings for the common RISC-V Platform Management
Interface (RPMI) shared memory transport as a mailbox controller.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 .../mailbox/riscv,rpmi-shmem-mbox.yaml        | 124 ++++++++++++++++++
 1 file changed, 124 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbox.yaml b/Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbox.yaml
new file mode 100644
index 000000000000..3aabc52a0c03
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbox.yaml
@@ -0,0 +1,124 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/riscv,rpmi-shmem-mbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V Platform Management Interface (RPMI) shared memory mailbox
+
+maintainers:
+  - Anup Patel <anup@brainfault.org>
+
+description: |
+  The RISC-V Platform Management Interface (RPMI) [1] defines a common shared
+  memory based RPMI transport. This RPMI shared memory transport integrates as
+  mailbox controller in the SBI implementation or supervisor software whereas
+  each RPMI service group is mailbox client in the SBI implementation and
+  supervisor software.
+
+  ===========================================
+  References
+  ===========================================
+
+  [1] RISC-V Platform Management Interface (RPMI) v1.0 (or higher)
+      https://github.com/riscv-non-isa/riscv-rpmi/releases
+
+properties:
+  compatible:
+    const: riscv,rpmi-shmem-mbox
+
+  reg:
+    minItems: 2
+    items:
+      - description: A2P request queue base address
+      - description: P2A acknowledgment queue base address
+      - description: P2A request queue base address
+      - description: A2P acknowledgment queue base address
+      - description: A2P doorbell address
+
+  reg-names:
+    minItems: 2
+    items:
+      - const: a2p-req
+      - const: p2a-ack
+      - enum: [ p2a-req, a2p-doorbell ]
+      - const: a2p-ack
+      - const: a2p-doorbell
+
+  interrupts:
+    maxItems: 1
+    description:
+      The RPMI shared memory transport supports P2A doorbell as a wired
+      interrupt and this property specifies the interrupt source.
+
+  msi-parent:
+    description:
+      The RPMI shared memory transport supports P2A doorbell as a system MSI
+      and this property specifies the target MSI controller.
+
+  riscv,slot-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 64
+    description:
+      Power-of-2 RPMI slot size of the RPMI shared memory transport.
+
+  riscv,a2p-doorbell-value:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0x1
+    description:
+      Value written to the 32-bit A2P doorbell register.
+
+  riscv,p2a-doorbell-sysmsi-index:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The RPMI shared memory transport supports P2A doorbell as a system MSI
+      and this property specifies system MSI index to be used for configuring
+      the P2A doorbell MSI.
+
+  "#mbox-cells":
+    const: 1
+    description:
+      The first cell specifies RPMI service group ID.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - riscv,slot-size
+  - "#mbox-cells"
+
+anyOf:
+  - required:
+      - interrupts
+  - required:
+      - msi-parent
+
+additionalProperties: false
+
+examples:
+  - |
+    // Example 1 (RPMI shared memory with only 2 queues):
+    mailbox@10080000 {
+        compatible = "riscv,rpmi-shmem-mbox";
+        reg = <0x10080000 0x10000>,
+              <0x10090000 0x10000>;
+        reg-names = "a2p-req", "p2a-ack";
+        msi-parent = <&imsic_mlevel>;
+        riscv,slot-size = <64>;
+        #mbox-cells = <1>;
+    };
+  - |
+    // Example 2 (RPMI shared memory with only 4 queues):
+    mailbox@10001000 {
+        compatible = "riscv,rpmi-shmem-mbox";
+        reg = <0x10001000 0x800>,
+              <0x10001800 0x800>,
+              <0x10002000 0x800>,
+              <0x10002800 0x800>,
+              <0x10003000 0x4>;
+        reg-names = "a2p-req", "p2a-ack", "p2a-req", "a2p-ack", "a2p-doorbell";
+        msi-parent = <&imsic_mlevel>;
+        riscv,slot-size = <64>;
+        riscv,a2p-doorbell-value = <0x00008000>;
+        #mbox-cells = <1>;
+    };
-- 
2.43.0



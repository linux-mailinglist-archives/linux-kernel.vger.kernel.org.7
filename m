Return-Path: <linux-kernel+bounces-772814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A28B297CF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A5A420442A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0A1263F4A;
	Mon, 18 Aug 2025 04:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="H+Nk7L+e"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97982627EC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755490284; cv=none; b=Z79voKIfX90lslIiNCWwEq+mOCu/naLQHD3vvoaHM5l/SmyNow5LGUThiJKV3dFqPJr7lsH2ZYt2AbmTM2pkqBbmc2lEzJOZdFnl33nSWTK1ZcurkIBf5BuHCa4wZmi7Dyea5O9Q9xQ0Tu0nqm7Y0hUCVyl5w6C2m3wJsGPTFE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755490284; c=relaxed/simple;
	bh=gqZpMXPd6DL/+kfXUibwUL8SSmPMehps7IgssTY7RG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2HLx99j0Trfy7xkSAXVHj5J//wMwTpwjh9ogxr8rd2GJosSBei4L9bgIKU64XTeYAAD/r2CYEQcbI2bc/vqf6gWq7Gnor/ZE0z+CsJqBtWU5v029lrqNpu+jOeiJrzAIpWmDVamxeAL7N266HIGnK0KnOGDuNRTaERhpMnwafk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=H+Nk7L+e; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32326793a85so2776447a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 21:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755490282; x=1756095082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMRC5c9xXUgo6eKv4jcoCHH6TENqo9cqAPQxW1Kbofo=;
        b=H+Nk7L+efF8m2lrCt/Ho1n/pSQasXvNVn+SehJrrfZ7YJP0hDvMEa6bXigGlfI9qPk
         p/Q0lUa1JrKxvSC4Qu9fs31uoXGBiTlKyfIL0ENWm0dGhSSO+cv2ucdfudOl/payrQ6O
         sofAfu/h3mqB9+YXD10TCmZMkP4hEt4kqU87sCw2NNZpTXzz6tgRYHPHdZ4xp3mdgi1V
         zOQrAJJfZFxkYW+IVHdp6Nxw5cxKF/DRfPV3XxVi2/kjhXDGJWqT1VkvVk9Zmrc/3iHm
         EDDO+2f9Z3z8txPBYEnkHNPxA8z7A4uRP+a718Y6LtmiqO9cy46nxqgzqT/8RRG/4T9m
         lang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755490282; x=1756095082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMRC5c9xXUgo6eKv4jcoCHH6TENqo9cqAPQxW1Kbofo=;
        b=c1cq3brYaz2N9g6an31laDi/U/z/pl5QMIP5xKlvJyLIgXeun4rC6cL62+mQqKs5Zr
         brtobJUgBAVklkau6lObiNgArFY7miewlVuEMUkpfzFxUavCootmLHrky224POJGIGg9
         HE9u1hwJr3fqVX9sYkAevQyMK5H1306e2jEghI6h+mOYC51FBfS1Gz95H1sD5Yiy7JF2
         ikvkaQeMIaIQZSLA0g4En0n5GbkWhotH4gpDIF5RQH3jFoJYFMqCMGuSx/HZbQdLOW4j
         lPnjAS7qh8ELgM41x4ERoWe5SVnkVFNB3BCWp14oq5SiikdooMERMYcw//gkbrO/Pz2x
         OL6w==
X-Forwarded-Encrypted: i=1; AJvYcCXzATyHF/zw+BsnILtltHft8+osgRBuS5z0tyFZxyFWWH71WL5GdHjXW/vsZGsxkJ9LDqM/Rlj5vbAsQpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR5gwCqHbRZLXbtgg1vxtSIcimi5CUAXziy9GU57zPi6U7cl3S
	PyvZNcdR3maWvQcwPEKrcm7et5oiPpe0+Selni396WIHASdn1+Q7zy0b6O+NNtLO14s=
X-Gm-Gg: ASbGncuS2KLTYMqe+Ng1lvGTQTw4yZ6qJphVwlWip9zyV5H/NAdwJNSn3QgMlmDPg2l
	z/7+7mMFRGPcC7ZwVQSlFro9dd2yb828Y5924N/y61fJKFWDnya164ggEtsvT1Nr+p+otfjkGFb
	fWAFEMQdq7OFkqEv93CQd7cOTqa4j1kvdh0JkJ0UL26tV/NeMLsROouOAG8Kwv+5D1du8v35YNx
	VzIrUCzSjuyH/A5xWOC/w3acAOBvRGUQWxFuA1Z7tYeSaUl0pRmESR3gKcGCbP5Xv5cqDPWMakn
	kUzNpkYkL1TLOG3oyE/LlqIASEYL3mBiU1ciSthWhaLE/N+YX+a/o/glZPbkN5KSOoNeVHSdQl7
	yEIfJeDebcJ53e7L/W7f/C6EcAepYw3SwoH6Q7/nKNYkM7mPn2VH2Ng==
X-Google-Smtp-Source: AGHT+IHP6UbREeetpnCWOLmWDeaEVguVbF9ClSYn1V6am/aKBqluAMuYoaNtdrC+UjrhiXEkm5ie1w==
X-Received: by 2002:a17:90b:180d:b0:315:c77b:37d6 with SMTP id 98e67ed59e1d1-3234dc7ba5fmr10093522a91.23.1755490282031;
        Sun, 17 Aug 2025 21:11:22 -0700 (PDT)
Received: from localhost.localdomain ([122.171.17.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32343c70356sm6560972a91.25.2025.08.17.21.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:11:21 -0700 (PDT)
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
Subject: [PATCH v10 09/24] dt-bindings: clock: Add RPMI clock service controller bindings
Date: Mon, 18 Aug 2025 09:39:05 +0530
Message-ID: <20250818040920.272664-10-apatel@ventanamicro.com>
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

Add device tree bindings for the RPMI clock service group based
controller for the supervisor software.

The RPMI clock service group is defined by the RISC-V platform
management interface (RPMI) specification.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 .../bindings/clock/riscv,rpmi-clock.yaml      | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/riscv,rpmi-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/riscv,rpmi-clock.yaml b/Documentation/devicetree/bindings/clock/riscv,rpmi-clock.yaml
new file mode 100644
index 000000000000..5d62bf8215c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/riscv,rpmi-clock.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/riscv,rpmi-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V RPMI clock service group based clock controller
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
+  The RPMI specification [1] defines clock service group for accessing
+  system clocks managed by a platform microcontroller. The supervisor
+  software can access RPMI clock service group via SBI MPXY channel or
+  some dedicated supervisor-mode RPMI transport.
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
+      Intended for use by the supervisor software.
+    const: riscv,rpmi-clock
+
+  mboxes:
+    maxItems: 1
+    description:
+      Mailbox channel of the underlying RPMI transport or SBI message proxy channel.
+
+  "#clock-cells":
+    const: 1
+    description:
+      Platform specific CLOCK_ID as defined by the RISC-V Platform Management
+      Interface (RPMI) specification.
+
+required:
+  - compatible
+  - mboxes
+  - "#clock-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller {
+        compatible = "riscv,rpmi-clock";
+        mboxes = <&mpxy_mbox 0x1000 0x0>;
+        #clock-cells = <1>;
+    };
+...
-- 
2.43.0



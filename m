Return-Path: <linux-kernel+bounces-747766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F427B137E0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B7103BD8BF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B671B259C83;
	Mon, 28 Jul 2025 09:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="E6Y5UYCz"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B88F253F2C
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695749; cv=none; b=bAcgg/6VFEIJ1dC7eVYgfNZy3TYxp355o+Dk0Sv7R4sUBhDn+N1mhAzrJ6J8yeKvZx87r6e3ikwhbeIy/ARF9nBRzq1kDtmG7e13Vs7Hf+USKyPA6zs7LQlOtxtkk7xJJkBk3Xm/qoVKmPMZt0RxKpWBlRapQuTFbw+zGhiMVEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695749; c=relaxed/simple;
	bh=gqZpMXPd6DL/+kfXUibwUL8SSmPMehps7IgssTY7RG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XlZZu1slyM1dPwv7i5QgjJBVxmKkrKJ5BWyTTsGl3ohZQ+8BrYmSkwLXYeEhJT+G38RS9m/7aWX/iKXR7G52nPg9jf0oyBhjPAl4DOZFC2ma6gcqrDLaL9maDY1pd0PpkTRFvDxh+mnfjS3yYssS0CYm8WHfZ6lGPclJorLhmEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=E6Y5UYCz; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3137c2021a0so3469776a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 02:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753695747; x=1754300547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMRC5c9xXUgo6eKv4jcoCHH6TENqo9cqAPQxW1Kbofo=;
        b=E6Y5UYCzp5TdNTw9k5ohUabkOSgaOQGqHbabmoP9W8SOJCwO3tlKfVR1SBT0DKepYc
         j/yts+CxP4oShUgoaeKNNWWnmc5IXx9u/5ie0hTRQEfj2OuCrx/nqrTZhk2oDpBb7I+F
         r+PEd/I12YiaIizmK8PsWW+Hr+wO88Xu9dC+nw0dHauiuQVpa9mkRdM+D/OEiDUGCDYD
         mIooCLQUSrZhhh6pIJKf/ysMBx2f+rt7BHoN80SQy1v+rY9WMO6ip6A1O6DCI7Bl5wma
         1l3n/vijVx5sSPXMWE6+xXku4d+WXCvWA3VnW15ulJO3G3NDTOKLepHzlMMC9z3sWaMM
         x5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753695747; x=1754300547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMRC5c9xXUgo6eKv4jcoCHH6TENqo9cqAPQxW1Kbofo=;
        b=MrmcBwMYSIxWJVao6rSeBocs8pwfjhXNRoGFm2j0/ZprxjTpdV+7ZyfhBAdIqgezKz
         xlxrqNwYdJ/q7Cix1otfRTGE9vo//zKO/tteh5lhDZ9UEpO6Y1CdJA7YXP8ylIUbJMgW
         lP96AuxPVgKLNFdz8szrQHNDygmPTibUzByNAnREF3V002Ew7G9wLpZSp9muZK2ekykF
         BVDIC4xWdqEbum1pGtkODAdi839HrtPAvMrqojEGUQ6IqqUYjRwQpKOAj107CHcmKfCU
         t5FNEL1+Len/6tQmoWsKLFnPMNOPhFmcuL+dJkS7he6ChmP01u/9Lv+uQM2+3htf7uSs
         VOXg==
X-Forwarded-Encrypted: i=1; AJvYcCUYO5FsFlTIkOZaHXUfz1TY7aCyavwSL8iS9BmgLjMeTruA2CirY0pqjxzoWkFqOWenQ5H37WDzNZfQfXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPYtwYD9NYNb9e1OnkyUT3ZNMxN+837Ekt+HFPOT0s6monNfZw
	6yBj1REuDjy4TFuy2nXQqzZj205txVOv2EU7Wd7exKKJpN6J8qU4N/RwImIOKu+v2EE=
X-Gm-Gg: ASbGncvr6GVGplSL1W6UiUZKb6LS0kt0JEepMSPg6T7pdWUJicEBxLpNL6jr8mymVZ9
	BRQKGFE0H89HSPqWCR62DulBOtdMF2MAKC6QQ7rJJDnxtfoP9ZC7ubKSyLwrV7+wTL1NzlWbEb3
	UWi4I1EM7iWPl2qkayEIKTKL7VkBZtLC4Xor0qTukqh0c9MUfwBXyoyzb0wM/SMoLd4ddA3QKyz
	+N9R+K+4kUZ7RiyjzAySQ76JnQSEK+JMBe6Xn8Ue6M51gR91BZEghHdbseWnp41HtAYkLZtnlwD
	jZ8mcj7z/+fUd7kpjGNntl5xPwR/QrxYcltUFPWgl52+F/6/2tfBpY/5Om9LaOv8pQUPguYStEw
	U4vbKdXc0j/llbL/Clw3hcbeuO3WR5CnCvpRiSYlSL+OAGa/DH1XeN10z5+E9
X-Google-Smtp-Source: AGHT+IET1sWMZD/6AnfrHKkMC7OglTaiVF3qSrY2in0HUadzd58C0Shm9ghMuxb6ibvRVRWuWVfN2w==
X-Received: by 2002:a17:90a:d2c3:b0:31e:d643:6cb9 with SMTP id 98e67ed59e1d1-31ed6436e56mr3137835a91.1.1753695746628;
        Mon, 28 Jul 2025 02:42:26 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([122.171.19.28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e832fbf99sm5396230a91.1.2025.07.28.02.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:42:26 -0700 (PDT)
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
Subject: [PATCH v9 09/24] dt-bindings: clock: Add RPMI clock service controller bindings
Date: Mon, 28 Jul 2025 15:10:17 +0530
Message-ID: <20250728094032.63545-10-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728094032.63545-1-apatel@ventanamicro.com>
References: <20250728094032.63545-1-apatel@ventanamicro.com>
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



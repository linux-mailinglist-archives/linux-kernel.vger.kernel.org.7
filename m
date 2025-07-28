Return-Path: <linux-kernel+bounces-747765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CE6B137DA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 061393BB6F0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F042566D9;
	Mon, 28 Jul 2025 09:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="cAXGc/H2"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D92B2566E8
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695738; cv=none; b=hcVl2hl4YPjhNnBtvvwW4308THIQNYqMvCHB3Qo1kGnl9SGJbLiY3R7TdH5uWnLGr82xIb0BeYJIRikt33ar1xNjJOaLb9MSj39ePmuLqbdyu0MnL9wGv0GSSmzmbpOM1lsecNgGJNvyhi9pumhcRypJtixKikT4PlaCfKt3t4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695738; c=relaxed/simple;
	bh=dNnAUr+2trSDmCnQ7YgS/ZuDyO2yPRTU4DJLikPf2R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aptXtMFRHL+ZrboLIx+zYAgQxyRY+QmLk6SoaTDShrZuPAP5sTjMOtdnHwqM+rzbLNirS30Op6vh9leB68veKTWeKv6LvNPAPgo//TWZrC44ZqUKkVBqv3X4wdKEkPrWtnl63ZrTZFkioGj2q+l7j65x4vDiebwKMc5oKw4SZsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=cAXGc/H2; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-31c4a546cc2so3454040a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 02:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753695736; x=1754300536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+ejybDVQT/aGz6Lcll3wkVRKaiK+174ISdzaVIOfkE=;
        b=cAXGc/H20wK0RQyxEaEfP7afvbchZxTmin8MaZLJmaNJ4/QlCeBX5yDuaSUgcNegrZ
         ifqc4WDaIUTU5A5rJzSOniSD+e45smpWwSgpp6eJOkWItm0C3IavvlbKsxTsHVlFzIjW
         dAMpBb81B7oBbFMG5DiNoZcVFOETVbF8uTVPVRq5OJg6sHFHqHyaWxlIYG5Qak8x+FMa
         ZmODj2LqIELQop8hajQMia4eqlY00GYEMSItnNRgrdFMY6TL+UYL7GDbN668e7MdPH7H
         bXbyOteI0yXraTKbEiLiJwVNm/X9ftBOrefA6sPolxQWNmsheRZM7jrOO/M+Pml4SIZv
         36fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753695736; x=1754300536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+ejybDVQT/aGz6Lcll3wkVRKaiK+174ISdzaVIOfkE=;
        b=kun17x+MNbtVnQZBpyF2qd8zvSSZbSh6ujzt7oQG70rNc1X0bOTMfGX/xmNmhhxx8V
         LpTDBr5Ip1WBmtbd7oUCGijl4cf1ACNL5alZO0i096zicWi5jbMHDPXXVgk8mrR6FJoo
         JA7SQ7T8RgotXUof7UcVqFkFrgNpKHEIEj5JEOZ9OYp8efQFmhxv4d7IOgmZ4roqwXPd
         7xfDBuVIYWayJzXnKvEWHgdMG2Zkp0vNb5tKWYYzOhLtsaisu6M1MO/imCvrA2+9Ct2l
         a2hxx43GHr7OQm2Ih72iGNK580VFRbmEvGTeKk1njj+2hVp0aHe3cfE2FFcUBTBVe4Er
         X8bw==
X-Forwarded-Encrypted: i=1; AJvYcCWd/uWQ1itI2cMr097UTbVnnXACM1SsLstalT5yXAsw4ThL7IgB/TYbhzQ4G7VO2CZ2/KgDym77phtJCMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbo9dzHy2oO8knGGMLy/iSK75o/WlOKnYT5PtIeKfqmXPtKf4l
	mZ3Y6LwOGbkXiIJ64UhKxPEZK9hPMMyCZx5YYVHhrRXD4xsqa9k7WxQuUI3kIl6JyaU=
X-Gm-Gg: ASbGncv5Uq5ukEP0CPOj3ruGfR5P2Z9c182ePGOfKNyOw7SMwL2i5HBWYJ9UmjIVkDr
	CkQ9EjAqqwpqsbQgbzU5EUbrk9sZit6ka20D7Cn8bQ61bxTDKqgSBk2LEE0BEZH89mG+TBt+kFD
	L/Ad9jgymDcc3d9kgz/UHzyqeUURfNcBDLyQRVLeMsU6AvwN7vvPJBx0nuLS4mZAE+YsBntCFIK
	B3aA0fJoib503ZlXdSUCPHej266TotLNoHjOmy/mXkMLISSYCs1VZ4iSEgBH4/xVJFue/UDkNEu
	h3Jerbf6sTcPuJg6pLhCUByDjea8reWjnefR1KShsvcU9Kf7/At1VQdW202s7vzc37tnegPbbh8
	pOXbqvZCqLNgdOumYt4lPPii6tDry3vo3rAH1T+rbk6OOUwzM6CCjBg0ZCFpX
X-Google-Smtp-Source: AGHT+IGMNexUFTZgfnglCwA8dHkB4ePGnpWD+DuX2cDV9JJRgC1BszN5eGUa1rBL9rVd8I8xmDxQIg==
X-Received: by 2002:a17:90b:1d88:b0:31f:d0:95bc with SMTP id 98e67ed59e1d1-31f00d09a88mr2516269a91.25.1753695736376;
        Mon, 28 Jul 2025 02:42:16 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([122.171.19.28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e832fbf99sm5396230a91.1.2025.07.28.02.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:42:15 -0700 (PDT)
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
Subject: [PATCH v9 08/24] dt-bindings: clock: Add RPMI clock service message proxy bindings
Date: Mon, 28 Jul 2025 15:10:16 +0530
Message-ID: <20250728094032.63545-9-apatel@ventanamicro.com>
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
message proxy implemented by the SBI implementation (machine mode
firmware or hypervisor).

The RPMI clock service group is defined by the RISC-V platform
management interface (RPMI) specification.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 .../bindings/clock/riscv,rpmi-mpxy-clock.yaml | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/riscv,rpmi-mpxy-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/riscv,rpmi-mpxy-clock.yaml b/Documentation/devicetree/bindings/clock/riscv,rpmi-mpxy-clock.yaml
new file mode 100644
index 000000000000..76f2a1b3d30d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/riscv,rpmi-mpxy-clock.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/riscv,rpmi-mpxy-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V RPMI clock service group based message proxy
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
+  system clocks managed by a platform microcontroller. The SBI implementation
+  (machine mode firmware or hypervisor) can implement an SBI MPXY channel
+  to allow RPMI clock service group access to the supervisor software.
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
+    const: riscv,rpmi-mpxy-clock
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
+    clock-service {
+        compatible = "riscv,rpmi-mpxy-clock";
+        mboxes = <&rpmi_shmem_mbox 0x8>;
+        riscv,sbi-mpxy-channel-id = <0x1000>;
+    };
+...
-- 
2.43.0



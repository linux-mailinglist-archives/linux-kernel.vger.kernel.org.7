Return-Path: <linux-kernel+bounces-772807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CA8B297CC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F13961962709
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D6F260592;
	Mon, 18 Aug 2025 04:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="IpdApLbx"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC08D25DAEA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755490224; cv=none; b=VTEoCDq7N71a6N+ERlGyk47XRNIEukEFpXjF4BkVGojv7A+r88JMRnnM2WnYp8HgeF67RD7WR3QDRfxvTa00HFrq+0NkYIPn3KYFhpDh9G9UpMJ6Kfhze4RogSlz6QijAJeMxVnUnaX+TB5Z02XjXrMVlrqymUJUdWCMb2v/aMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755490224; c=relaxed/simple;
	bh=wpGteD02sLvwEnKA7TBa2+SX4iYwOSU082ERtl6/Vjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0RZVTotwavaK/txEWvSOMS2V1dbsUEIPnr5UaYBN7ycq8UJcGhXr3Dwuox6tifyMR+ZIDkSm73B7gEhs8Zv6bzKQzf1BHIRex6fL5dQcFErjayckDpWOn6l9vsJcRIrsDh8Xy2NYOGBF3I9LiO9LfNm1MiT9UdeH7H8IsPNCG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=IpdApLbx; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-323267b7dfcso3423233a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 21:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755490222; x=1756095022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGFMyHcY75Un2ey32rj/OGQJrYLrfBUEB3tHZxTx41w=;
        b=IpdApLbxS69Eyfe6+HnnpMlZvFJ5FmA9oyvvnu/du1Y91/h/J+c1di2KXzAEszicuh
         L1antuCGAmZotSQNyty3804hh2R1ib4oQTphjRVM1W9vdSXxaWDditw1Z/7iqorgVUIn
         MyDRJxrUcH9sP0ALVC4eGkOJfGFqGNBO802smYxMHN3H0uoDNuyvb/TtAE9iPQ2U5bBt
         yz3+GhO5fpe+rOLstcoyHKfL07HjAf3We4ybLH1bA0BAL47+ZuAXAmgrh1Gean7MpmZZ
         g27fCnt9msIEzt/SHsKjBCrR3v7G6E5p/dPnOz4aUyPfz9bpI1gjvJgqBMUr8WGnUW1/
         +Yiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755490222; x=1756095022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EGFMyHcY75Un2ey32rj/OGQJrYLrfBUEB3tHZxTx41w=;
        b=nMqx6x7pVVxZoROOs274VbEdgoSYu8hwYt82qKhRL8mndqYVQ+Gk/RoKGDkptmyuZm
         d297jq96nhiv5YfrEkHf719oNWKPStioYAl9aWCclfaZEN+o9OiLuDbHu3L3GGZ1v60D
         MnONJ/HFKqH9bGSjZh8ewM3DOcSa3PKbIt5Er195gnguSflBpfy81DWzOtodn8z/zBIT
         +p6HnAsmElrSqommKStR+s/F4bDARfnIMNXOs9j1svY6WRlUF2aQ2egmMfsXQ3BD4ZIL
         R5OsDyMXEVq6wKFwwxM1eoy+Rzt2fHJFkYes5Z6cLqAkSeQZSdLbA+pd5r5LA7AqRaRw
         ZOZw==
X-Forwarded-Encrypted: i=1; AJvYcCV8MftwZTT2Qnyvb0XCUh4qBi7RWUESNUamLtJdiPOgwwfXP66XPq2ZaJ63IytIdodG6U2067CQLoVa54g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFd2GVM4pruqLjYbYt4+xrvTxmGuOQqxq83UpEQe53MI4FF7qJ
	WU62amhWTNL2Z+y1+XOpLzbT3DdPrxCWyTGDOQ9NiXDjajzzqIOCHeuVPHkNJ5sO0XU=
X-Gm-Gg: ASbGncs5DehkwVB+uRgIhkwONChlXFoFPZi2JT9ECn8BK8EYYG+r/pmyNZkMMa5gKAZ
	EG90zlVwTAlyOP5d80cOAzgFb6lGPr563ja0ZxkOFuIqgdcSnIoa+lj5+sqjDEOiG087JBtVY4x
	EtCiuJhrOQ0mnwwY7nUmshlsMt5YtoHNYJGagprlZHkE3Cs8hbct+5f6ZHQhOBBg1DZ61cHwzdU
	oKBAK5MfxKYIcFeiJGpNFgJvBVZzGOKYDVzaR3zSijSUKkzQ6odpeaRhY58SA0bJDXpRSRJLgOi
	xknEnB3I89R4nFLSiKR4XZbSY8u2YVtSf/ga0gDY0oS0tKTYXnmg+0RfpqldA7oMTSZI1xSwqs+
	4AB7uAYQac1rceIADStM6sbMUaILLFft+pJ8jh4uGlItbAiT+ANQE8w==
X-Google-Smtp-Source: AGHT+IFs4OXO3DnRijQR3jC6XXyoF6g88+AqqQwufWlSqx4yu9HzDyzVSqM84xSB3fWmoLTMC/EQwA==
X-Received: by 2002:a17:90b:5247:b0:311:f99e:7f57 with SMTP id 98e67ed59e1d1-32341ffece0mr13705525a91.23.1755490221961;
        Sun, 17 Aug 2025 21:10:21 -0700 (PDT)
Received: from localhost.localdomain ([122.171.17.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32343c70356sm6560972a91.25.2025.08.17.21.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:10:21 -0700 (PDT)
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
Subject: [PATCH v10 02/24] dt-bindings: mailbox: Add bindings for RISC-V SBI MPXY extension
Date: Mon, 18 Aug 2025 09:38:58 +0530
Message-ID: <20250818040920.272664-3-apatel@ventanamicro.com>
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

Add device tree bindings for the RISC-V SBI Message Proxy (MPXY)
extension as a mailbox controller.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 .../bindings/mailbox/riscv,sbi-mpxy-mbox.yaml | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/riscv,sbi-mpxy-mbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/riscv,sbi-mpxy-mbox.yaml b/Documentation/devicetree/bindings/mailbox/riscv,sbi-mpxy-mbox.yaml
new file mode 100644
index 000000000000..061437a0b45a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/riscv,sbi-mpxy-mbox.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/riscv,sbi-mpxy-mbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V SBI Message Proxy (MPXY) extension based mailbox
+
+maintainers:
+  - Anup Patel <anup@brainfault.org>
+
+description: |
+  The RISC-V SBI Message Proxy (MPXY) extension [1] allows supervisor
+  software to send messages through the SBI implementation (M-mode
+  firmware or HS-mode hypervisor). The underlying message protocol
+  and message format used by the supervisor software could be some
+  other standard protocol compatible with the SBI MPXY extension
+  (such as RISC-V Platform Management Interface (RPMI) [2]).
+
+  ===========================================
+  References
+  ===========================================
+
+  [1] RISC-V Supervisor Binary Interface (SBI) v3.0 (or higher)
+      https://github.com/riscv-non-isa/riscv-sbi-doc/releases
+
+  [2] RISC-V Platform Management Interface (RPMI) v1.0 (or higher)
+      https://github.com/riscv-non-isa/riscv-rpmi/releases
+
+properties:
+  compatible:
+    const: riscv,sbi-mpxy-mbox
+
+  "#mbox-cells":
+    const: 2
+    description:
+      The first cell specifies channel_id of the SBI MPXY channel,
+      the second cell specifies MSG_PROT_ID of the SBI MPXY channel
+
+required:
+  - compatible
+  - "#mbox-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    mailbox {
+          compatible = "riscv,sbi-mpxy-mbox";
+          #mbox-cells = <2>;
+    };
-- 
2.43.0



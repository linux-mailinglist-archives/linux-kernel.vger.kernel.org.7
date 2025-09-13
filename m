Return-Path: <linux-kernel+bounces-815342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F71CB56310
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 23:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E9BFA062A1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 21:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2893283153;
	Sat, 13 Sep 2025 21:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PR+9TKTm"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523D72571BD
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 21:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757798186; cv=none; b=h/ONRjt5iecArh83K4T1kVNewQmPetHI+0uhG/gQmu26Y2sGDKg3RPaLYbwBEMjJ+8CYPrDiu+G/H/zcZWDpefw6n5mMBqIHVdnBrle7tpGziONBGIDYBnJkpAZrMoxKdywxymvY4QJg9eBwSDVgE2wmLF4QDErpNcnxHX7N+KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757798186; c=relaxed/simple;
	bh=aCY6RxCHQrKIRW5QIMBN86rD5F6gGG9oJuEhO1S8+yA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BpBxZVgTidQ1AzhBfb9FZzlhZ4ohzVHBNME/GKW6AJQQ09Bx0N0gd9p4GDhhGQTcSVwdcIywI/RLnbTuwclNuyUvQcE0/Kfl/T8oAsYudyQq756hMPgJaq/L3RiNIPXbh/8eCJDzUXI9y4HmqV+s+JHpmIwyPWpWvj4YimmCRic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PR+9TKTm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b9814efbcso25622575e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 14:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757798182; x=1758402982; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K/SeeyRvYxEIsfGVZybU2qc9C9N7ZeMuzRETBp2zbnM=;
        b=PR+9TKTmAs317hptaKAj9tbcjQVc26RuppF0H5MzfKyvw+lKcsrcx3ETL+itWkO4QW
         bJlIDiFe2/lVoRreVWnGG5q9xZ2vL4Lw2psriGhDltYZlwD9jgnV1jBnLfBu06pm56E8
         g3Sdv/7iTeRnZdp9mMFCCS5LA2rXy4/pTu/oTCTOtrW0Fa941iaNiXqudJ+uQuTEHQKI
         dsI1MDTQXENru8WR/or3cOMopUyHTFyB0YndlyUNnznuz69596WkTGoZ5AI14sIQ6vyg
         UQwN6VxC1qnWQr0lCJ5E3dtoH7LLI2EaKoQtEGoRJLbEUkx+Ya7rpALf685oWz7MmvZs
         0VQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757798182; x=1758402982;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/SeeyRvYxEIsfGVZybU2qc9C9N7ZeMuzRETBp2zbnM=;
        b=NvCkQ+036jbLscsujc6CBC9EP1JF8Cm2Q6Srj4SJnutviO33ANp6TOIStaD6eCt9ic
         LHoz+lRFfXFJ6tv9JzujnFjuFtzddbpiS4J0sPE0t4ixFfLIBqxccnR+XbPfK6MAWKja
         C9m8l8GxytAHqniWf9dEfBUTi15J7KhyBhGJtlckKTzvJiluM64Z/mVmc9VOPLN3cw4k
         1D6xZEe5RFGdrBdl0haLnlhWm4BsxQx2G4ND5o6oN/RTcz/P9eWNgt+nJJ1RtDv7T1XR
         9VDtjB1s3dwiICp07HRNg8i5pjOxRSLuQQ1RAt1ogm2nGXXEyQFWYSNWQGebvkOa2lNT
         ZsQw==
X-Forwarded-Encrypted: i=1; AJvYcCUQgLLqGsS/BVjgv9QcAFRCctDmW1enNO9H1TDqgYBqIIzki9YfpIy9QV7r4PpK11r9y4qWU1eAvqoZwrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+7kj3v52IWkV8fDZb7HMUwKfJhqC9LtU0GBwI492ITFeWjMsd
	7iwpRURFB7DqeCxIFOPnWnm5/XLxKoXDyI7JrzPxWfjF6+cC1KswVBVVpGnNGxqv
X-Gm-Gg: ASbGncshs9bbHY6hQgNh3Aef6mdLg/bdr/ISFW99MMHhw1NwR2qTttXNwN//zdjnj+y
	JIlVRGMJWbxiaFi0Fqgw+zX+eTkWDDjLs8xDKWktykLiXjtIKLTKxg/EZWXwJ44ePLAY9Dmu1o9
	SzB4jm08LhDWyOZjW5GwzH20/AeVE+EZxo9B++J5b+FAEebs7Pdv1KTXNnz43AtFWaa0vh0Mqfb
	u2EG1UdIbvKj2Fj6q1RnEu1DX9vbvRruARpQZhmH5RY/5jpuCnBxBxKnGc1BeWMKmZNj870F4ZP
	IEdrQ+NQJsnnqaNyokr1+6Ojt8l1/n22JOzS2qjF8hz3A1gNyle7fFquQi2tR7X0aLPPQZ4aCQ/
	g2BXCNxoaolg+YjjKXVj+dQ4+qBy5PzzZHYYFQriFCg==
X-Google-Smtp-Source: AGHT+IENdqe6tFLJhgaKYNDsjgAqN3Bky9aI7BhYtkMmCPhOAUK8jcHMz4D/zkFC+NDqh4hUyO9H9A==
X-Received: by 2002:a05:600c:c3cf:b0:45b:8b95:7119 with SMTP id 5b1f17b1804b1-45dfd5c0dc5mr67761295e9.8.1757798182134;
        Sat, 13 Sep 2025 14:16:22 -0700 (PDT)
Received: from Radijator.localdomain ([93.140.65.23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e014ac468sm65403145e9.0.2025.09.13.14.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 14:16:21 -0700 (PDT)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <dujemihanovic32@gmail.com>
Date: Sat, 13 Sep 2025 23:12:48 +0200
Subject: [PATCH v4 1/4] dt-bindings: clock: marvell,pxa1908: Add syscon
 compatible to apmu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250913-pxa1908-genpd-v4-1-55e4cf32f619@dujemihanovic.xyz>
References: <20250913-pxa1908-genpd-v4-0-55e4cf32f619@dujemihanovic.xyz>
In-Reply-To: <20250913-pxa1908-genpd-v4-0-55e4cf32f619@dujemihanovic.xyz>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: David Wronek <david@mainlining.org>, Karel Balej <balejk@matfyz.cz>, 
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3482;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=kOa/aUOGsrnkhFr1peiUiieuFcP0VPi+VrVXV4Tn/1U=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBlH7yttDbZb+Le3+cKK2ZeWqipxNa3pOcUhyLc4dMmBw
 6FLfLrWd5SyMIhxMciKKbLk/ne8xvtZZOv27GUGMHNYmUCGMHBxCsBEum4yMmxjT5Itvzxl/oap
 ZiuLk4I/dfmt0Jtq8vRR83GfC7/XPitkZNgSrH0n8uXkD+8eFLFU7dliJ1n0tk3zbnmpXdc1Ne5
 uVWYA
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

From: Duje Mihanović <duje@dujemihanovic.xyz>

Add required syscon compatible and #power-domain-cells to the APMU
controller. This is required for the SoC's power domain controller as
the registers are shared.

Device tree bindings for said power domains are also added.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
v3:
- Squash power binding patch
- Update trailers

v2:
- Drop simple-mfd
- Add #power-domain-cells
---
 .../devicetree/bindings/clock/marvell,pxa1908.yaml | 30 +++++++++++++++++-----
 MAINTAINERS                                        |  1 +
 include/dt-bindings/power/marvell,pxa1908-power.h  | 17 ++++++++++++
 3 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/marvell,pxa1908.yaml b/Documentation/devicetree/bindings/clock/marvell,pxa1908.yaml
index 4e78933232b6b925811425f853bedf6e9f01a27d..6f3a8578fe2a6810911fec5879c07c9ddb34565a 100644
--- a/Documentation/devicetree/bindings/clock/marvell,pxa1908.yaml
+++ b/Documentation/devicetree/bindings/clock/marvell,pxa1908.yaml
@@ -19,11 +19,14 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - marvell,pxa1908-apbc
-      - marvell,pxa1908-apbcp
-      - marvell,pxa1908-mpmu
-      - marvell,pxa1908-apmu
+    oneOf:
+      - enum:
+          - marvell,pxa1908-apbc
+          - marvell,pxa1908-apbcp
+          - marvell,pxa1908-mpmu
+      - items:
+          - const: marvell,pxa1908-apmu
+          - const: syscon
 
   reg:
     maxItems: 1
@@ -31,6 +34,9 @@ properties:
   '#clock-cells':
     const: 1
 
+  '#power-domain-cells':
+    const: 1
+
 required:
   - compatible
   - reg
@@ -38,11 +44,23 @@ required:
 
 additionalProperties: false
 
+if:
+  not:
+    properties:
+      compatible:
+        contains:
+          const: marvell,pxa1908-apmu
+
+then:
+  properties:
+    '#power-domain-cells': false
+
 examples:
   # APMU block:
   - |
     clock-controller@d4282800 {
-      compatible = "marvell,pxa1908-apmu";
+      compatible = "marvell,pxa1908-apmu", "syscon";
       reg = <0xd4282800 0x400>;
       #clock-cells = <1>;
+      #power-domain-cells = <1>;
     };
diff --git a/MAINTAINERS b/MAINTAINERS
index cd7ff55b5d321752ac44c91d2d7e74de28e08960..6f1d29c42c2eccf7fad489fd6a9b2c74fb24e4ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2872,6 +2872,7 @@ S:	Maintained
 F:	arch/arm64/boot/dts/marvell/mmp/
 F:	drivers/clk/mmp/clk-pxa1908*.c
 F:	include/dt-bindings/clock/marvell,pxa1908.h
+F:	include/dt-bindings/power/marvell,pxa1908-power.h
 
 ARM/Mediatek RTC DRIVER
 M:	Eddie Huang <eddie.huang@mediatek.com>
diff --git a/include/dt-bindings/power/marvell,pxa1908-power.h b/include/dt-bindings/power/marvell,pxa1908-power.h
new file mode 100644
index 0000000000000000000000000000000000000000..19b088351af138823505a774ff27203429fe2d97
--- /dev/null
+++ b/include/dt-bindings/power/marvell,pxa1908-power.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Marvell PXA1908 power domains
+ *
+ * Copyright 2025, Duje Mihanović <duje@dujemihanovic.xyz>
+ */
+
+#ifndef __DTS_MARVELL_PXA1908_POWER_H
+#define __DTS_MARVELL_PXA1908_POWER_H
+
+#define PXA1908_POWER_DOMAIN_VPU	0
+#define PXA1908_POWER_DOMAIN_GPU	1
+#define PXA1908_POWER_DOMAIN_GPU2D	2
+#define PXA1908_POWER_DOMAIN_DSI	3
+#define PXA1908_POWER_DOMAIN_ISP	4
+
+#endif

-- 
2.51.0



Return-Path: <linux-kernel+bounces-874094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E8350C1582C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BED9560185
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2776A34405E;
	Tue, 28 Oct 2025 15:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ziptBQmz"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FEA33DEFF
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665541; cv=none; b=eRUXZrTUZA+8whtIKwWUVsh4txIUs+LrySZrZv477kTsjNN+5v9yPAGDKMSqMBNTsuU4jtrGS1988gxeMfjye/dfMjeVHi+4qNxtYdJ27g36qZ4ELM4vB/keSSWQtQFelS07plGhjA3RqqJ8xNMBnccIVXdP2eTWcoMBLc5XMO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665541; c=relaxed/simple;
	bh=bq0/AuBRe/Atd6ilL0O18VXPhLf+lkVoUl4gltp9IAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BSS8aOkk/SyIx6j/AqKGi3YBC2z3RtZnkzONHsWhQC1pbaO450oDUpVWCYplBNQZo0iPowIuG8nIUF2zYTnvYBq4ysZwPTr/UzWxeJxP8CB2U216MJ+bS2Qa1EmJG0bR9RI/qYKz7jw5+zpjaxFE4SJ7VIFUiM+kpOC1wwbv9Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ziptBQmz; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42708097bbdso467065f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761665537; x=1762270337; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+FjOns32ozZ86ZCE/qpPk7ZFAl0N+FBFxsMJbgK6odk=;
        b=ziptBQmzuP2Wn6v2bkIXT+BdI1ADKW9IvoNp38uc5gT2U24tsmryRBMrH7mGbiFSa+
         OIdQKGZPDLWOAzipQlMOlNu1TB1Kn3gNyYcVp6Erlk+kbG40YfEkhlxdGoSpKhVyWNmY
         4w+HcLgw0WnnhUb5+4xhgpkFfJ9cBIw/YFOtaLDmWvXrJ+Oo8B+EKIkTrEKBnCaRu7Ft
         5SCEABhsrEdh2/YkZn/mN/8FjGZ2KpBhpPSYoQKeynroLlLY9ZOz2ZCCs52O67mf852i
         H9Yh9mzE7co8pt9VlgYa8v0LHyHuqT4QqsyGGIHeKCaK03a/ZKvtyoZN/NJZh73R9WYZ
         iSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761665537; x=1762270337;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FjOns32ozZ86ZCE/qpPk7ZFAl0N+FBFxsMJbgK6odk=;
        b=C0zuEuEyfJ2mLJaDhTZB3XRw7YH1LL1zta+uYfxrmEBpzfvCsOcFcp/9qpgmgRlNUc
         1qNaI2pqXBA/zORMue12QY67K500ubXSeYYAD6FBKjniMGzLIX4ZGJtoAnQ/AejJRuS4
         ZX2F5UlGbuh5TPBu2/UN9PnIZDrw4AsCxj3H7jkfyhEWyHOOms+lhbrQjB1/c5e2Is6H
         NQGpVks+Jfv1t6ZYAuw0nZQX41l9Uzv6xiFrzthhwB6NYOuTWE1IS84p62aRkJEXQEQw
         ksmjNrZyM5T9+YKZmV5nY/MStw/fk55g09hoVnbhYEkxUKh0Z8VNGH4rDAqhRYRzp/Tb
         Csew==
X-Gm-Message-State: AOJu0YyTRSwDfNYo4prU0ODlNS4tGRdfU1HVazAGmR/yaU6Rf7fA6SfO
	NSqck/N+wL0M4KTZF2o759unQ71URM8MWaYb8j386maUykTUTdynibIUhp3wgDMlf6s=
X-Gm-Gg: ASbGncvox8iXPhgFHMSrPFyv6XAXYhb3rjikhxyc1adGNQXr3kvSMRQWOKTbqUrzs9z
	vji/XaAo1+b6fXcrpocuSQeuavM1aymE05RylYHQpKZB+Ig9kyzkN+avyBBIv2IkyJu/8QuZaTy
	g1pJiAjSrw1K9e/Z9yHAt/wg6Umx0cWJGumjtxMLEV0KwzpFbrZSDN7TlBb/hR3/18NyXEAfSuU
	M+j34REGcwyp9BFbtVMMNf19vHY1Pc8WyOeMs8TiEuzdzyuMYVTN2woyOBq+dNeWcUssj8G3L2v
	C7YaC9OYO/A0XBD4Lfh5UnwbECLEWE2/NR/Y3HUs4Sv/HZqJbCIvRerqD5kdsiJv98EIS5k1TmR
	nVcSF7ct1VPHojLgEUU39+dyPBj4FvjpumrTNeCQcCqT+7QYzY/9P0t4/cHOo56HLM7abH5hO10
	xWi2fGuuWgfY5Xkca1
X-Google-Smtp-Source: AGHT+IFfCe2WoDs7U2zmbXcweBOW9erwA5t7r1uofR9tmnpVUC8T4L1LFZQ8lspkeWdcDo4YWkGHtA==
X-Received: by 2002:a05:6000:2008:b0:425:6794:77fd with SMTP id ffacd0b85a97d-429a7e6f854mr2075596f8f.1.1761665536816;
        Tue, 28 Oct 2025 08:32:16 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d9e80sm20844417f8f.28.2025.10.28.08.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:32:16 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 28 Oct 2025 16:31:51 +0100
Subject: [PATCH 02/12] dt-bindings: bluetooth: qcom,qca2066-bt: Split to
 separate schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-dt-bindings-qcom-bluetooth-v1-2-524a978e3cda@linaro.org>
References: <20251028-dt-bindings-qcom-bluetooth-v1-0-524a978e3cda@linaro.org>
In-Reply-To: <20251028-dt-bindings-qcom-bluetooth-v1-0-524a978e3cda@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5484;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=bq0/AuBRe/Atd6ilL0O18VXPhLf+lkVoUl4gltp9IAo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAOHy47ueH6KoNK8qYnQhLLRyiX19E+C5ACR3j
 9mKRtgq5D6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQDh8gAKCRDBN2bmhouD
 13QlD/9nPCH8vaMFYjU/50yEr/Nrp7bAKZrgLVGQn04jwrKikED2RbjguRhjDkmQk6c153a05Of
 Tq5Mm52DLd+q2Mbv/hB+6DzD7i3Ybui7E+8tdytvQCMb5VIF83tdi+h4gWdLLcPgvztUmXw/gLT
 XafcCvz7O2Hd+vnRKUAz95dnaWPRI30wcDt6Fr3ej9D8lm6Ffhobownq4dwNzziLT4UHup5Xafx
 rrPr8np5yjEEx3VY9PyO1MHoaz7LM9EAKw6FJJorglFK6RLCeBLLaIW7sTXRVeeEoSXivXzHnt2
 BRQv2L1wmG9OFT0QvRQ9w6dEY9RUNr+Ox+xozIuXkXNgzPSeWVoCADx/g5U1yWxDSMHDHmOtQ3g
 slErLgxOcZqWjPGD2rwiIN8VMvUcXLwcrfoddyZz/xFrQ9uWgR2Nq64IMIrobDa+LxRFK0EEW1h
 ivUoI2sb1RLwXWblzayTrQn3r+uCDXoqLn56U4/9o1TaKsd/xCIscvNmTT7nCR4PA+pWJfaauX/
 B7luuZt4Kw3cc4jRZkz+gcdh3UwJ+u1Ry0pwf+Zm6b0y06ICl0uRDkLKTt3UWcgdt7s9yDSNxk2
 +Vy/n4R533L2+f+xudi/TYdwpS5aeQdnVqiFV8qHJMzGloOGWV+u05YWumlzl2NPimp5TCXIWuP
 FFv8NFFo1u97xKA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

One big Qualcomm Bluetooth schema is hardly manageable: it lists all
possible properties (19 supplies).  Split common part and
qcom,qca2066-bt to separate bindings, so each schema will be easier to
read/maintain and list only relevant properties.

The existing bindings do not mention interrupts, but
am335x-sancloud-bbe-extended-wifi.dts already defines such.  This issue
is not being fixed here.

Existing binding also did not mention any supplies (which do exist as
confirmed in datasheet) and Linux driver does not ask for any, thus keep
this state unchanged.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Expected warnings:
arch/arm/boot/dts/ti/omap/am335x-sancloud-bbe-extended-wifi.dts
---
 .../net/bluetooth/qcom,bluetooth-common.yaml       | 25 +++++++++++
 .../bindings/net/bluetooth/qcom,qca2066-bt.yaml    | 49 ++++++++++++++++++++++
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml | 24 -----------
 MAINTAINERS                                        |  1 +
 4 files changed, 75 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
new file mode 100644
index 000000000000..c8e9c55c1afb
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/bluetooth/qcom,bluetooth-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Bluetooth Common Properties
+
+maintainers:
+  - Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
+  - Rocky Liao <quic_rjliao@quicinc.com>
+
+properties:
+  firmware-name:
+    minItems: 1
+    items:
+      - description: specify the name of nvm firmware to load
+      - description: specify the name of rampatch firmware to load
+
+  qcom,local-bd-address-broken:
+    type: boolean
+    description:
+      boot firmware is incorrectly passing the address in big-endian order
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,qca2066-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,qca2066-bt.yaml
new file mode 100644
index 000000000000..d4f167c9b7e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,qca2066-bt.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/bluetooth/qcom,qca2066-bt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QCA2006 Bluetooth
+
+maintainers:
+  - Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
+  - Rocky Liao <quic_rjliao@quicinc.com>
+
+properties:
+  compatible:
+    enum:
+      - qcom,qca2066-bt
+      - qcom,qca6174-bt
+
+  clocks:
+    items:
+      - description: External low-power 32.768 kHz clock input
+
+  enable-gpios:
+    maxItems: 1
+
+required:
+  - compatible
+  - clocks
+  - enable-gpios
+
+allOf:
+  - $ref: bluetooth-controller.yaml#
+  - $ref: qcom,bluetooth-common.yaml
+  - $ref: /schemas/serial/serial-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    serial {
+        bluetooth {
+            compatible = "qcom,qca6174-bt";
+            clocks = <&divclk4>;
+            enable-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
+            firmware-name = "nvm_00440302.bin";
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index 6353a336f382..0e67abfc8528 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -16,8 +16,6 @@ description:
 properties:
   compatible:
     enum:
-      - qcom,qca2066-bt
-      - qcom,qca6174-bt
       - qcom,qca9377-bt
       - qcom,wcn3950-bt
       - qcom,wcn3988-bt
@@ -122,17 +120,6 @@ additionalProperties: false
 allOf:
   - $ref: bluetooth-controller.yaml#
   - $ref: /schemas/serial/serial-peripheral-props.yaml#
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,qca2066-bt
-              - qcom,qca6174-bt
-    then:
-      required:
-        - enable-gpios
-        - clocks
 
   - if:
       properties:
@@ -211,17 +198,6 @@ allOf:
         - vddrfa1p7-supply
 
 examples:
-  - |
-    #include <dt-bindings/gpio/gpio.h>
-    serial {
-
-        bluetooth {
-            compatible = "qcom,qca6174-bt";
-            enable-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
-            clocks = <&divclk4>;
-            firmware-name = "nvm_00440302.bin";
-        };
-    };
   - |
     serial {
 
diff --git a/MAINTAINERS b/MAINTAINERS
index be637b9dc7c0..66e9c1f86363 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21147,6 +21147,7 @@ F:	drivers/net/wwan/qcom_bam_dmux.c
 QUALCOMM BLUETOOTH DRIVER
 L:	linux-arm-msm@vger.kernel.org
 S:	Orphan
+F:	Documentation/devicetree/bindings/net/bluetooth/qcom,*
 F:	drivers/bluetooth/btqca.[ch]
 F:	drivers/bluetooth/btqcomsmd.c
 F:	drivers/bluetooth/hci_qca.c

-- 
2.48.1



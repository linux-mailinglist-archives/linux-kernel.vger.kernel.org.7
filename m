Return-Path: <linux-kernel+bounces-875351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 445C1C18BE0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7057A189CFC1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D698F31158A;
	Wed, 29 Oct 2025 07:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CIalLULP"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AE3310635
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761723856; cv=none; b=f2smnnt+7Y2YoBIgkIDhKpNROUUidyDc27VcxjLw6LSHdE9xAyL6LZrU3KoClcWMKSPLQUoLxrJ0jy79umiNIK2Fab0FcGbQb4BYdhc7rAAtjIUjiyEb2CFJOZJgNz/Bi1gf4hLHclYoQT9TwpC2ZEGCc4tMay2MzsQxx4xBQHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761723856; c=relaxed/simple;
	bh=1OEKBZd3Pxcn4NWZEVyg+zU+HrcwKqhnbfIn7kZHpl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e8vs3zS+EHjieJIM4P4eoxYmYF8gbsAMhC80ZKCs2xcQRh1uI7eiDKrFZmAezgb5WdM2w8hPr39RBzLuwpL4RubUFcawiXXnPSyTq8fpYQ0S8RPlBG8WVUa6xn6gQy3yIgLW3HZEjL0fsppiz3Fd2NRqsfw3OeLgQrV6IAtwolA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CIalLULP; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4285645fdfbso904788f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761723853; x=1762328653; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qQtkl382GI6bqhRyQP3r46W9x6QHG1RVELos4Msr/bw=;
        b=CIalLULPyB5JyiNdjEHfukgAQKRY6cK+HLGVVUNPWYfalASlfuev0XwVEKVptIxa0k
         ezkMdbOPL4V7eOfwQAouG7dROfCWmNOmnpUtcUNY5j1NR2cuL34HGGK4Y3lsGkL9TuXl
         LO4ocA9DwsX0rhRX/MIpULzji06/P2pTiAdCcahcauds+ROlEzCg/Y19ROiDHdU2wjK1
         9h3CXbWDWKpjOG4JGTkiP0ZmHWcjsdSo5ld8sY2aN9GFGeVqyW26EmabFu1tIhJavyS/
         3dazMLtXhYblT1w20FHld6MhXgmf9tPgQOTngYU8qrlSrTXeKN+B1w00sxRk9cmdCGWV
         HygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761723853; x=1762328653;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQtkl382GI6bqhRyQP3r46W9x6QHG1RVELos4Msr/bw=;
        b=lh1Y1IaLCmTQG+Jep/w5I9E8ty3vWneiq6Rm/7mg2jfzyEIk/TUPIs9LmVCXbNIBoM
         seJ7PDMZYVkFHXrD/8K97jDnW5kBPNbnGxzl3Dy1tUuHnLubJdSBY+r7SJAt0vEk+ED9
         aCP6gZkx5G2ouNOTzKZpkt4Hj+oEeSeqpLxBpDirDlzoBPXxSeQGQRWRo8IXoZGeY/3y
         2qvh3CjdFmXtw5LYB2Gb+mDkjBPlnJbgbtgJdxcuNWJie0EPjV7TihEvsoy+rG1hX69Y
         LdEzOE4vPsFXgcBHpWcbcJ1+ftZFY55utn+H6aGw/lY4dT+cjTVD+KAGBU7dpB2fgiHH
         3k5w==
X-Gm-Message-State: AOJu0YyZ36ev1eTZqW0pk453yw+xTWVQ1GuXlZpMGzBfIXqtE4uVoIDG
	Txse/Tb+aIZlm31ZeHGX5p1XJoaAEGb9dKZ9DP6XrFwTTkQjRMb0aGgQc+uWQlV3XZk=
X-Gm-Gg: ASbGncvEyd6vbKCL3B52uPOuQ2R3ru7ZhAcxfVBpG+2wgiaVteoshoyKwR1ehjABa4N
	vQAbRz/1MR+sC3bds5/Oms/M08R5HbZwVdcP4e0TpwFWvQvTF+fdFuonvKAa0A0FE8DgVbHS7Fa
	8ItDElKSdF2WPAlBV+oebdRfmHX4Xl8BoFRq2TKhyU8e4KTGQ0WMlWvsFh4Yc3ZkyovLTXJsVnN
	2IOF2GNIYuPzyTfp1nH8SbhlJ9eDAEpWI2SvzppACNE6WLqkPcoYCXkEENqzf2ZEhwlm+2WA9We
	5oIuKqqNwG62LusV5GlMFE7Fvpu2tK+VvzZQlTVSQmIgU5HilSF9fHenR7xhRZNYWbQ+fnBGBnd
	+3huY4kvHxvaLTPOFegkrp/q85w0nFKfxqOmanlFcgUB4C7sgmF2FjlIRh0qIx3QNgo+Eizwzio
	L7Jn1ApjACNj7DaY9b8GgGpea9G9k=
X-Google-Smtp-Source: AGHT+IF9tlp/gUwLaREffjpNOYFLqhCz/Qylsj2r8Gi1EKpFbT8FWh3U1tckMm7cYLoHyHP8MkC/GQ==
X-Received: by 2002:a05:6000:2203:b0:3f3:1be5:ecbf with SMTP id ffacd0b85a97d-429aefc04f4mr704992f8f.7.1761723853136;
        Wed, 29 Oct 2025 00:44:13 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d5c9dsm25861146f8f.26.2025.10.29.00.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 00:44:12 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 29 Oct 2025 08:43:51 +0100
Subject: [PATCH v2 01/11] dt-bindings: bluetooth: qcom,qca2066-bt: Split to
 separate schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-dt-bindings-qcom-bluetooth-v2-1-dd8709501ea1@linaro.org>
References: <20251029-dt-bindings-qcom-bluetooth-v2-0-dd8709501ea1@linaro.org>
In-Reply-To: <20251029-dt-bindings-qcom-bluetooth-v2-0-dd8709501ea1@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5731;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=1OEKBZd3Pxcn4NWZEVyg+zU+HrcwKqhnbfIn7kZHpl0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAcXAvOHjKIUVmIOeDNC6Pf4ysOIRtaQO34r3a
 UrMms5k+tSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQHFwAAKCRDBN2bmhouD
 1+tEEACAd2hnuYTluizIay3kgFgSStdHc2cu0LRGX2HUqZNNnLehz+eLNhGgROe5dgTnL28A9ha
 q6mi8Fe4370ACxcXkQbb3vSJHCcYEVS4X7r0VDZIChz54pGH8fwR6ps0VP8tzQ7QYbuxoEhiPrz
 FtyJVKzV1OsWFL9iq+FvvqReK+TCr4D93BCk2Ew/rhqqErmMbYy+t7GfEQ0/XcT/R5rOVcoQDA/
 FZRILv8UmAyzWTCX2QBLYRKnCEI8OZSgzRrdloPefeNDGUkZufLaHfL9SEnyyAexQpK8uo4/2td
 HCTtegnIKGvWpApCVkEKSZbwBtDVT75AMy02JXopFJKs3ej9tt/0p2emPlv4V0e/pzz7U04ma2o
 wx7ybY/FqAHKUlAaP1bGPYXVsKVPepC3RR6wxUODPSTdKRAEG9Q1NGuWNXZj3io+Gy1YOc1ZvCo
 d+Vt1VtH9n0yeDKBcU8hf5YCauxeAMtlZ9yfa721zBf9RtQvvoccre5QBxoED2fU+ehjXEzrjjZ
 fONOZqtb2WpIEHav4xYZ/Qn+wPFrjdT61kfCMfo2lzSU9kpz08vn73RrdQ7325R0gdX5/8RIUJx
 2tk+kCYzLhbtoecnomXeSa9FWeRULLgxWT8psemcNmsT0rr7XzuOSjqn+/xHTm7veCCvPv/jm/g
 2/2oWB7XX9sOffg==
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

Changes in v2:
1. Keep gpio.h header include for rest of the examples (fix build
   failure)
---
 .../net/bluetooth/qcom,bluetooth-common.yaml       | 25 +++++++++++
 .../bindings/net/bluetooth/qcom,qca2066-bt.yaml    | 49 ++++++++++++++++++++++
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml | 25 +----------
 MAINTAINERS                                        |  1 +
 4 files changed, 76 insertions(+), 24 deletions(-)

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
index 6353a336f382..85d10d94700f 100644
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
 
@@ -236,6 +212,7 @@ examples:
         };
     };
   - |
+    #include <dt-bindings/gpio/gpio.h>
     serial {
 
         bluetooth {
diff --git a/MAINTAINERS b/MAINTAINERS
index 8a2c5fb0ba55..c1889de94ad9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21148,6 +21148,7 @@ QUALCOMM BLUETOOTH DRIVER
 M:	Bartosz Golaszewski <brgl@bgdev.pl>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/bluetooth/qcom,*
 F:	drivers/bluetooth/btqca.[ch]
 F:	drivers/bluetooth/btqcomsmd.c
 F:	drivers/bluetooth/hci_qca.c

-- 
2.48.1



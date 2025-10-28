Return-Path: <linux-kernel+bounces-874098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E98BC1589E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F77564939
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F67342C96;
	Tue, 28 Oct 2025 15:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VBNFyUFd"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691AD345733
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665546; cv=none; b=fh/nHOqp19zD5Yr2mBnyC4NVGFJfdIqvbKiek9CszwMp6p1i6sOvObd8TfASL0yEAI6TZ+3j0Yyp2oOwY2rCca3G79k0fmym5Nl5QTXyrNuijtDhnoINxBTyOta903dxfrIDCGwqnj7ZHwARQS/8pDi2vWQvt3IFLKVULeZoUmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665546; c=relaxed/simple;
	bh=7rSGqGe5j/ajfYeyCLhr7KhXQYjjD+BB8KOQPiQ8lnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RIPwNudQUSmrvQzJLeprfqAQqou7RRpEpAhji05ftgjNCLo9I81jl5mihRqmzPeWKsohe/HN+l1uQaO4Fps8427Dk/fWSeDhKo5bQWC8vZ5xBfjmM39GaUNz6ISpaBlFxkPKSX19hjPklTn2NzSPy3pYx6rbuir8woqs3grJBGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VBNFyUFd; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4270900c887so696012f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761665543; x=1762270343; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CsNC6YXccurarSsTb8o/0+bYujRK2YI84C73y8iXHgw=;
        b=VBNFyUFdf442uucoRudgM99wI5awz10ZCTZH2DyeJlhbYZRtYguN/CuNrrjbwwRKrZ
         dGEr/dPswmyiMjhkxhnAhzlWzAKRJ/CeNumI72OciWCsAhZYraM/CLKEHt5IbJnuyYdG
         s1DdfAXzOISPby9OPJPOxk27NLdlz5d5Lj6dPfQ1dQJa8HYjfJ3Bpuwfz8rUNpPzu2hT
         +8GwagPTdDmeJaSN8u2dUaQblmXbfYzwTPYtfp6V3kYT8LXSDS9XaJCcemDKAviWiI62
         IYGmMGTNdKLZ97QbtUTvWHrV641duPjUri3UQURtVPNnvDd7mDnDl0GS0yAEIO57DeN+
         AmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761665543; x=1762270343;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CsNC6YXccurarSsTb8o/0+bYujRK2YI84C73y8iXHgw=;
        b=UyWeahWoSbZiMk34mPuJ9I3GbswNmvyWmarc8ut6mo/+DbrXbdNqok7/DRtQfh/CF2
         XkKj1u9fbIQYzFo0NmMFIutLVgYMPts3lbJtTlNaFTfZWQadjt8gzgCW4XWqpeXqHE2S
         oZNaYj48V2dOZJzDG47nlmNI6HqzRxYECfzvnUoxcAGw75H3+rbTVuczUYc1N8BMGYYp
         971ertzgid0HL/tD/0UePIEvanUGKga/gq3tCGOvua+BLEqKmNs4ekQu9+W4DRTF+sOF
         Z1+zu5dQAqx4cnYWSGRevgnLd2Pt2QIj4MmrQak8WVb09v5gIyEUoIaSAAo/wdz6ZgcX
         LmFQ==
X-Gm-Message-State: AOJu0YwdJl9o75My+aD2SZS+SH9Z648sv+3GZePojL3PIqxMxeNGq7Lb
	xrKyBtGCoxoMjjfSctrkkGz/gwvtKneFn8kHMko2la6YKyvf2MgFb+ubR2YNppn+IHw=
X-Gm-Gg: ASbGncuJ2gud8sRcGoDqu5WSoYw6qAKkPNUTzr+6RovetXd3lfZnl7imiPZ96l6odDS
	Y3hMZva7172VqsOKxDh7ldNLl7T9iiCeT8B62hQZKw7lJKz3i8O+DYVZ4byNL/A07XWUN9uzbM8
	9D2Km2+/9A2cEcIvWDywKsw7AGWXiIGsutStZ/uAvEMMuqVBWmDupa5XUpGX5IQB4+HLsYJCGMm
	+GbHCzpUoQy8qToT0HsnyI6u0Io59zx1Rt3wIY5yA3ffh9gQCT4yEiBG5JW+QXBeoirmp0ZeXKt
	B8ofKOl7NNKKu7BsQlhj+aT/8A9U2XCPYxPJJaKele6dV7HfAlZX2V2pQM+b+YkEt2hefu8DQGu
	nhww5c+Ka5gkykxtKz0QDkZN9IWlONTmzVomESYlwkO6zM670OJi4x5q3cmZX1nr4aplBrxyQFR
	IHQokachtmmNmXArquMp24CxFoE40=
X-Google-Smtp-Source: AGHT+IGSDPFEO84EzJhEbgPJhsjWHxZla1PTi6sHXxqFDlBLQOf82JsJ+IxGsLOGZ+ItlsDEYbcmgA==
X-Received: by 2002:a05:600c:1913:b0:475:d7b8:8505 with SMTP id 5b1f17b1804b1-47717e7f144mr17828925e9.7.1761665542485;
        Tue, 28 Oct 2025 08:32:22 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d9e80sm20844417f8f.28.2025.10.28.08.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:32:21 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 28 Oct 2025 16:31:55 +0100
Subject: [PATCH 06/12] dt-bindings: bluetooth: qcom,wcn3990-bt: Split to
 separate schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-dt-bindings-qcom-bluetooth-v1-6-524a978e3cda@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4686;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=7rSGqGe5j/ajfYeyCLhr7KhXQYjjD+BB8KOQPiQ8lnM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAOH23WY7iJvjwE7kM4BwHTiBQB+VonPPkyMkp
 /njZ6hJGUeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQDh9gAKCRDBN2bmhouD
 184YD/9HPBaijTAfvYa3A7YrZyNE3W7JFMLrGZReWZHzu3clH2fnrrW0AlKqT3yjhD5V2+jtXQZ
 7EHBGEA+pTvz644c771GVlqTsSc3DkpaZMbJOnUjgM7/5AcJfh8E/DR0UrgCrIO1rkkGnuyCGCq
 vR2XP56gAI1amgMKp+bKPwS5Z8ZjlpnfxPKjJDVESYc++Zluj8EPJKObjYcTh+pjU+sMzIIMOYO
 htD/6xNTeqo+swnWnXaLd2PLGUTZZGsrn8Rf+4WiaWQs+Cl1b49RVAbQk1sgKSnFEFtwwmtLTax
 zFD6cCC3zOCsraWTPu6WIk0lLmaF4fT7SAD63k0VuzbgIB/vk2twldvprS6Nfdk1rWNUBwmmBaX
 zq3Uu2Ano26Jtpbobgf8Y6xp0oAXawEXPDnTyKlGDI+RAivjb9D9dgI6ddSlkpPJ/I9EWvweIhE
 CXd3Fw1lJg/EbJpDYuz5i8qwWozZlB3ZaU+os39+HiG20d/wVgV7ahA1wQvxuuLwtbPq6Wkzjy5
 N67Pf6UmLvfA/VcTp1Z9jLW4gvQRpmi8lRl7NfObbB4Zb8f0g5oclbEDRPMi6U84TV1BtIfZ3UL
 gqp3qUFjMsfT1FSxHtwa1bZ/JZpNhNjG4fokQktUr3xofX9H1mamYbxJMnnokERPlwzEC0mdiIg
 7YqpXCAJfuVciFQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

One big Qualcomm Bluetooth schema is hardly manageable: it lists all
possible properties (19 supplies).  Split qcom,wcn3990-bt to separate
bindings, so device schema will be easier to read/maintain and list only
relevant properties.

This binding is very similar to qcom,wcn3950-bt, however devices have
additional VDD_CH1 supply.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/net/bluetooth/qcom,wcn3990-bt.yaml    | 66 ++++++++++++++++++++++
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml | 40 -------------
 2 files changed, 66 insertions(+), 40 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn3990-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn3990-bt.yaml
new file mode 100644
index 000000000000..89ceb1f7def0
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn3990-bt.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/bluetooth/qcom,wcn3990-bt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm WCN3990/WCN3991/WCN3998 Bluetooth
+
+maintainers:
+  - Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
+  - Rocky Liao <quic_rjliao@quicinc.com>
+
+properties:
+  compatible:
+    enum:
+      - qcom,wcn3990-bt
+      - qcom,wcn3991-bt
+      - qcom,wcn3998-bt
+
+  clocks:
+    items:
+      - description: External low-power 32.768 kHz clock input
+
+  vddch0-supply:
+    description: VDD_CH0 supply regulator handle
+
+  vddch1-supply:
+    description: VDD_CH1 supply regulator handle
+
+  vddio-supply:
+    description: VDD_IO supply regulator handle
+
+  vddrf-supply:
+    description: VDD_RF supply regulator handle
+
+  vddxo-supply:
+    description: VDD_XO supply regulator handle
+
+required:
+  - compatible
+  - vddch0-supply
+  - vddio-supply
+  - vddrf-supply
+  - vddxo-supply
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
+    serial {
+        bluetooth {
+            compatible = "qcom,wcn3990-bt";
+            firmware-name = "crnv21.bin";
+            max-speed = <3200000>;
+            vddio-supply = <&vreg_s4a_1p8>;
+            vddch0-supply = <&vreg_l25a_3p3>;
+            vddch1-supply = <&vreg_l23a_3p3>;
+            vddrf-supply = <&vreg_l17a_1p3>;
+            vddxo-supply = <&vreg_l7a_1p8>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index 0a532144f92e..93b5e0e38c37 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -16,9 +16,6 @@ description:
 properties:
   compatible:
     enum:
-      - qcom,wcn3990-bt
-      - qcom,wcn3991-bt
-      - qcom,wcn3998-bt
       - qcom,wcn6750-bt
       - qcom,wcn6855-bt
       - qcom,wcn7850-bt
@@ -42,15 +39,6 @@ properties:
   vddxo-supply:
     description: VDD_XO supply regulator handle
 
-  vddrf-supply:
-    description: VDD_RF supply regulator handle
-
-  vddch0-supply:
-    description: VDD_CH0 supply regulator handle
-
-  vddch1-supply:
-    description: VDD_CH1 supply regulator handle
-
   vddaon-supply:
     description: VDD_AON supply regulator handle
 
@@ -117,21 +105,6 @@ allOf:
   - $ref: bluetooth-controller.yaml#
   - $ref: /schemas/serial/serial-peripheral-props.yaml#
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,wcn3990-bt
-              - qcom,wcn3991-bt
-              - qcom,wcn3998-bt
-    then:
-      required:
-        - vddio-supply
-        - vddxo-supply
-        - vddrf-supply
-        - vddch0-supply
-
   - if:
       properties:
         compatible:
@@ -181,19 +154,6 @@ examples:
   - |
     serial {
 
-        bluetooth {
-            compatible = "qcom,wcn3990-bt";
-            vddio-supply = <&vreg_s4a_1p8>;
-            vddxo-supply = <&vreg_l7a_1p8>;
-            vddrf-supply = <&vreg_l17a_1p3>;
-            vddch0-supply = <&vreg_l25a_3p3>;
-            max-speed = <3200000>;
-            firmware-name = "crnv21.bin";
-        };
-    };
-  - |
-    serial {
-
         bluetooth {
             compatible = "qcom,wcn6750-bt";
             pinctrl-names = "default";

-- 
2.48.1



Return-Path: <linux-kernel+bounces-874099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A456C15874
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B762565468
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD8A346A12;
	Tue, 28 Oct 2025 15:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oVzkkrS7"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD553446CC
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665547; cv=none; b=VrxvlNZz6r69tAHWP3NNtd1an9HLMNBRf34kwZIgOlghooo9MhgNfkf3d0N3TIAJ4YAfx3jYiCf7Dfd0rgHagMgRjypDF77QKmbCKq2z+3auqBbuX65gLzXFCVdfRKOvtb/jID1PjsC62pjnRLpQjHwVEgLMpmPErUczXco7Rqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665547; c=relaxed/simple;
	bh=YgQDLq+1nOL6n6+e4lSBPghY2mQNsqIvPf3xLra7UBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=laBg+G8UsmHmfBx+VlnZ0ny2nz2QIwZPkM/VFMKEroPWTi9x57//8WqmqQZo7a0vwCIYKMfLoc5EYf8Q4HNkFSQpqOEschoX0PkbQ7z+YqYXVe2N4eFxiCHVpvIrRmy5C6WRehWS1trlgDZrl3bFXIcWH5tbcc535eta8LrX1LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oVzkkrS7; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42844985499so711579f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761665544; x=1762270344; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6pvnl+2vrU/cihcGSbVbOAtyDAoe0NEWTlAR9xmlQbY=;
        b=oVzkkrS74ENJux+W0GpydaKNVPk/k47yxUp7emS4lGT0vWhxfYP7Bg0jOJ3CHXGaIg
         tad+Yqh5i1uL4uMf9h686Xr6M5JdMwi6AJzQDD54KEgdZK7Z5p0z3BYnSnmiiqMlizvg
         e0xoYzg5aAnAiNvJ7FE6mp/sFBs3wVWXE3/k+s0VnQdCWULCH97GocX2C/u05ug7cfO0
         0qPrm4rrD91hPCec8BdN+s/DS+lslWXQYWdEcH2ulaU8s2GMcqtFy4XAVvR3xnNpeg8m
         /pR3ehDy9rYRzPdx04j/BQgn4mwlMSCVGc/LESnEdigVOYM+fO85Cugz0CCm6w7b224E
         r0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761665544; x=1762270344;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pvnl+2vrU/cihcGSbVbOAtyDAoe0NEWTlAR9xmlQbY=;
        b=tB8/1F5OOghAiEv7z0ypHX3jtowaw4B/kraHfEOsJdUMQtsS5/cPLAuVswTjstVUe0
         i5bQkaz5Jb+EgemGr4IFk0BVSi6iO+4lCaaovder+HlBrDIL4o9vDjBEXXzECQAbB0AO
         RSBasdnJjCHjEKABiMH5EwNF7W+j2yD01tplKtfiktkv8L6UYEAiSR+s4K2MVEn9JRL1
         NjG6rlBM2IPaWgqKd/y/wixrUlFSLZM4G3ZRD76IEZQq7M7uMoce+QgxvuaiHO0ZhVQJ
         3GcZKj2QLB68ZjBWGJSdTgR9J+AWRM2JNFugGK7Phqhn7rHn2zrVTqTVzmv5tmW5PJgi
         0rYA==
X-Gm-Message-State: AOJu0Ywl0rI5v3n0Hs8Y+36U9tz6e8kFUFqeA1XBUql6BVPmfR9vvgLa
	e5DF8lB4IBHN7AWre7IGti+qaremzFGcFDkRMDAUkfIn8DnoiTrzj29bDgmXkEot/08=
X-Gm-Gg: ASbGncvbz7doqEr4axdw3HAkfX9K0JWHYnC7F+q6e9SVApwv9fLN03agCib4xunU5Ba
	ZS1PGcGlqdhq0zH41gQkeHNJbQIIrp3p1ey7KcKaa/CnjxlcU68wAbMr4gWCT8Wgs2nzc423mAH
	UmxZ5DiLWDqvdtRd32HkaAqcu3MS1t6hIoTQIpcoldKvYKx3Edosh0/BdQNM9oGyoR251I+3aEE
	NKxhHTSFR3WbzXwwzgLfUm9dMcEkXf02yus7QAC6lSlZobQrwAYFQjRF2RpS+tvmj3N0gH+oJww
	rWo+AZuboXMLbUPtaVVEnIny7b77EAZpujkGurD32ReQyhieQSRr0fDV4JWq/I9SLnL1bymY5Z8
	H0y5m4gDUATh8ecdd8SyvfacIXQoWrDc9LGU/a0xS87FyQ4X72+YzMALYrRdSrpBQIvM+eLuv6t
	rXm/aEHYqg54RCk5l6
X-Google-Smtp-Source: AGHT+IGhARsnLHIkkgLv5LOo+7nRPTe+tHleQbp7mgXMyLxxF1a7mHxsNiZjjko7iE38ay0MIRp8Hw==
X-Received: by 2002:a05:6000:2382:b0:425:86cf:43bb with SMTP id ffacd0b85a97d-429a7e7212fmr1932655f8f.5.1761665543928;
        Tue, 28 Oct 2025 08:32:23 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d9e80sm20844417f8f.28.2025.10.28.08.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:32:23 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 28 Oct 2025 16:31:56 +0100
Subject: [PATCH 07/12] dt-bindings: bluetooth: qcom,wcn6750-bt: Split to
 separate schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-dt-bindings-qcom-bluetooth-v1-7-524a978e3cda@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5447;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=YgQDLq+1nOL6n6+e4lSBPghY2mQNsqIvPf3xLra7UBY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAOH2AZwbqtwjYhpOREGgP6ZMJ3WN/OrUuuX32
 m7ARv25I7aJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQDh9gAKCRDBN2bmhouD
 1+8UD/sF3dtk5eVFvbjoSTmOBoKtBAHywwiZUbvyGoMu+8AwHefBjiiV1SRZ1neUNgYD9eo1bWm
 tSJ3zkMzvEcqNKsyv6/cUygz4f3Mxmc4kY7dnBCTX7h3SWbsv3n5bFqknEGrakaZsOLWG/Dahwi
 VB7R4QXcBowg9UWBRPgDj1mBmGUAPStuYb/F5IE8BW6JzyH3fikaCkri9nHVlDQne/fRNKvnq71
 fgPVpHKI+LvR4JjnbXOPlo31JxBKwMWnHZRgszb0ihBNugjXiIYsIsobdYHKINkezLFx3UblyzS
 zOmCFO48Bfk4hRuUtfrSqq7P1LmPh+deBHPDiPRgNpjy11ssDXtXkGCzKAHrPOUfuV2scsdtImU
 cHK+gcXxLk6vW9EDMCLls8bXVcBxrU6LdnB3VxvEG5cQAtFUJKpY1+kh7z39yjDzokf6DYoVsCt
 tTv7HIsWwEzF6jAotqE6wMgIH48iK4kb+irX18UoG0EmfxWMUIWieV28CeZwKMZ4ouspe56EXbQ
 WcV0NBEpzM9a/YjMGeBdKuglLfscM0UOF/ilugDJg8XNHlsfeYiJID01eTb6jJ5n0Vgm5WzXPNE
 l/mUaTCnHEUfSi4yf7tkAWVGuY/JuolJ7RPCcnBqfwTGeX75UFtJA3o/ZIqkkxTXXR0XNYZIbDe
 dOXXdzjgySbbvaA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

One big Qualcomm Bluetooth schema is hardly manageable: it lists all
possible properties (19 supplies).  Split qcom,wcn6750-bt to separate
bindings, so device schema will be easier to read/maintain and list only
relevant properties.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/net/bluetooth/qcom,wcn6750-bt.yaml    | 88 ++++++++++++++++++++++
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml | 44 -----------
 2 files changed, 88 insertions(+), 44 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6750-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6750-bt.yaml
new file mode 100644
index 000000000000..d26ee82993d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6750-bt.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/bluetooth/qcom,wcn6750-bt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm WCN6750 Bluetooth
+
+maintainers:
+  - Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
+  - Rocky Liao <quic_rjliao@quicinc.com>
+
+properties:
+  compatible:
+    enum:
+      - qcom,wcn6750-bt
+
+  enable-gpios:
+    maxItems: 1
+
+  swctrl-gpios:
+    maxItems: 1
+    description: gpio specifier is used to find status
+                 of clock supply to SoC
+
+  vddaon-supply:
+    description: VDD_AON supply regulator handle
+
+  vddasd-supply:
+    description: VDD_ASD supply regulator handle
+
+  vddbtcmx-supply:
+    description: VDD_BT_CMX supply regulator handle
+
+  vddbtcxmx-supply:
+    description: VDD_BT_CXMX supply regulator handle
+
+  vddio-supply:
+    description: VDD_IO supply regulator handle
+
+  vddrfa0p8-supply:
+    description: VDD_RFA_0P8 supply regulator handle
+
+  vddrfa1p2-supply:
+    description: VDD_RFA_1P2 supply regulator handle
+
+  vddrfa1p7-supply:
+    description: VDD_RFA_1P7 supply regulator handle
+
+  vddrfa2p2-supply:
+    description: VDD_RFA_2P2 supply regulator handle
+
+  vddrfacmn-supply:
+    description: VDD_RFA_CMN supply regulator handle
+
+required:
+  - compatible
+  - vddaon-supply
+  - vddrfa0p8-supply
+  - vddrfa1p2-supply
+  - vddrfa1p7-supply
+  - vddrfacmn-supply
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
+            compatible = "qcom,wcn6750-bt";
+
+            firmware-name = "msnv11.bin";
+            max-speed = <3200000>;
+            vddaon-supply = <&vreg_pmu_aon_0p59>;
+            vddbtcmx-supply = <&vreg_pmu_btcmx_0p85>;
+            vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+            vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+            vddrfa1p7-supply = <&vreg_pmu_rfa_1p7>;
+            vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index 93b5e0e38c37..2ee6579aa02a 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -16,7 +16,6 @@ description:
 properties:
   compatible:
     enum:
-      - qcom,wcn6750-bt
       - qcom,wcn6855-bt
       - qcom,wcn7850-bt
 
@@ -69,12 +68,6 @@ properties:
   vddrfa1p9-supply:
     description: VDD_RFA_1P9 supply regulator handle
 
-  vddrfa2p2-supply:
-    description: VDD_RFA_2P2 supply regulator handle
-
-  vddasd-supply:
-    description: VDD_ASD supply regulator handle
-
   vddwlcx-supply:
     description: VDD_WLCX supply regulator handle
 
@@ -105,19 +98,6 @@ allOf:
   - $ref: bluetooth-controller.yaml#
   - $ref: /schemas/serial/serial-peripheral-props.yaml#
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,wcn6750-bt
-    then:
-      required:
-        - vddaon-supply
-        - vddrfacmn-supply
-        - vddrfa0p8-supply
-        - vddrfa1p7-supply
-        - vddrfa1p2-supply
   - if:
       properties:
         compatible:
@@ -149,27 +129,3 @@ allOf:
         - vddrfa0p8-supply
         - vddrfa1p2-supply
         - vddrfa1p8-supply
-
-examples:
-  - |
-    serial {
-
-        bluetooth {
-            compatible = "qcom,wcn6750-bt";
-            pinctrl-names = "default";
-            pinctrl-0 = <&bt_en_default>;
-            enable-gpios = <&tlmm 85 GPIO_ACTIVE_HIGH>;
-            swctrl-gpios = <&tlmm 86 GPIO_ACTIVE_HIGH>;
-            vddio-supply = <&vreg_l19b_1p8>;
-            vddaon-supply = <&vreg_s7b_0p9>;
-            vddbtcxmx-supply = <&vreg_s7b_0p9>;
-            vddrfacmn-supply = <&vreg_s7b_0p9>;
-            vddrfa0p8-supply = <&vreg_s7b_0p9>;
-            vddrfa1p7-supply = <&vreg_s1b_1p8>;
-            vddrfa1p2-supply = <&vreg_s8b_1p2>;
-            vddrfa2p2-supply = <&vreg_s1c_2p2>;
-            vddasd-supply = <&vreg_l11c_2p8>;
-            max-speed = <3200000>;
-            firmware-name = "msnv11.bin";
-        };
-    };

-- 
2.48.1



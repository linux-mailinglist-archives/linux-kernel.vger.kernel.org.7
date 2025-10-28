Return-Path: <linux-kernel+bounces-874101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EAAC158F2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F3E567757
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FA9347FF7;
	Tue, 28 Oct 2025 15:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qX6swmym"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726E8346A0A
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665550; cv=none; b=LQaXtsDO+p8hojuv/2QX903f6sgiprrRmFtiTb6oj9S067wzxgc3ux7l1G9vDQByQz8PX8t78SSQ0yqIz94LZ0uVGmrUobZ6iqSR8AM79luEOyljj5QJHa4ovNZeVD2GTe0jt6bk5fpE+orU+r5EJ52YapEo6k+Mm4ibQZ6fp30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665550; c=relaxed/simple;
	bh=+H2VE42VODmiM/EFuz7vS4TQ7Ft2ZHEBfZtt66rOpZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fZQnbcCuy+sQcK/xAHW32By1WDd4836jKc3sI/+sYqS1vvdwAVfKNe5Whj3hItyExjhB3qgvktqtXO4JVVW4hq6jK32rt2tI1gHbGqz2mtXwuAp9SDYP0sqLyIi+hHJ+IxviGCofQFlqd9FY6vkMPxbCTxH3/7Tuh2PEaqbPdHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qX6swmym; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42992e68ea3so332934f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761665547; x=1762270347; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4WtD1sb2KfvqdOU5mWhq+kpLjX1rGG7JVl5sVtw6qD0=;
        b=qX6swmymf+RNUSpxlPNdH22ml2G8VosuGFV9RQFPYulDuSWMkxhdGkX/1yJctKN1bH
         6Lrul+7oy9b53NIVIF9acvYwDjQeSxFsf5ai1NrQ6cBMBXNM3o9e/OlKlP99Sd6PQX8y
         uu+6LX4qnRm+4C2ZDJQvG2mThhaSlRTuHjUPfUAnmjo/gGLYXN1wQsOTYA/yo6ruYVcr
         42CaH/+OJb4NDnofRKio4FTPD0bpH3qZd3w8bFQyH+R1IBRtIOvd0s5IqMf3+nBz/o1p
         VTJZX53qABphZPE+Nh6Yn9xgTSA+EpACVrGgk9FyKKbXGbIN3R73cu0BvROK14fWhFhI
         mq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761665547; x=1762270347;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WtD1sb2KfvqdOU5mWhq+kpLjX1rGG7JVl5sVtw6qD0=;
        b=eJk7p2r3a9Oz5zPIEtTI0zVZLqtFKRzmlEJxTaZABuKEk3xAXwYRc4/PjarVdD7RM2
         5XygkXckzJ4uM83FTi4kBuUJF7ON6+Ef9/tyiUwRmdfMP/APo1ONJhQYvwu9nj40WHBw
         VHKpZ1NLwNUm0idV02wjp9CghR4aupCDzu4N9Ge7sp/Y8+cLXEC1py5GcAUIa1VaCqvA
         pc5O3OwhclcNhKslKxHhL7zQ5JpbeFWtxNY2KBFvKzrTYZFiZRAp663zMBxILrp1F09P
         c6eEC7sdeDwiz5o/4O9Ztn3KBVHyezfC7nTdPEg1mquedc+IFxjfKjrDH5TX/NsIOpVA
         3YTw==
X-Gm-Message-State: AOJu0YyAoBznijmUmFegfnV6PcC4Pg3y3PK5egJ7MAkqi/mLriNrsi2x
	MGT3Q3oyrkmerEcSgEwifwrKcRxSDvPQ2IzZUN5TQXjafaF2Du4ACAUeYVBVtUkVlLE=
X-Gm-Gg: ASbGncuaeYbVzEMDwiW+Nlztd0As+r3Trr9Z68kzZFZzbbu/Ms4q8oeuUE865LC0Rdh
	DgDaOs1bOq+g9HJ7OS4c5PdZTbcgK1m+JoKnO2VqaASyGXSkKtT3+3fo/ZHufO7dDJUO/xeMc54
	71/AMh9PMfQ4fedw6QmSFw1bGoZ9FUp8GS/cdpYRvY6lxKX3y+XSYinirZSeYUKhY6Rldda8A6M
	4xi5Ep/6YMHJD9YmNyH3K4dr8N449JL0ZfxbH881D7GIHFODWMXZr12OMphybCq1Nmc7VvkXtLj
	TUO/gDlzZVFWaetLiT4st/LAKkxmkVBzYkRyudpetNDj7s89p/egw9HcKfWcPUxsXNyuM/Zj90v
	Wfi4N4t+Q0gvC9BjSFONPG2dwoGgQHskxrtB4SR7/gzF8bwy/ismfFDiahRnvgDtvIDG0ghG+Qy
	6+VngMH2z+ZLlzPbSo
X-Google-Smtp-Source: AGHT+IGoT9UNlTxCEY9TLGJWBlT3OLe3n50lUaeK8zYU5NqE1P/LpbDF+VDmQRLumFLDZeelADygFw==
X-Received: by 2002:a05:6000:26c8:b0:429:8b52:828b with SMTP id ffacd0b85a97d-429a7ec333bmr1556776f8f.9.1761665546676;
        Tue, 28 Oct 2025 08:32:26 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d9e80sm20844417f8f.28.2025.10.28.08.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:32:26 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 28 Oct 2025 16:31:58 +0100
Subject: [PATCH 09/12] dt-bindings: bluetooth: qcom,wcn6855-bt: Split to
 separate schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-dt-bindings-qcom-bluetooth-v1-9-524a978e3cda@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5653;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=+H2VE42VODmiM/EFuz7vS4TQ7Ft2ZHEBfZtt66rOpZg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAOH4D4wd+4UYJ9IUhaHCnk1Wvu0RUOeLz7H6g
 rg2kwXb7nOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQDh+AAKCRDBN2bmhouD
 1/1KD/0aGocagrlIzLuwwsaEUIpFL/SQ9gZUrSyECNaLOpR7Te1zprcskW3+6dL2eMgzwp1fsAa
 Y2oKVH5CFATlExAvbklU47gEamJF/ObucsT4MuIUtA/LRtcri72CpD2NVANqxdYsdHR0lGrwhwe
 U1SJ4pOS4mCyHg9qy8ZHaOCAMNrOcjw433sPmRMNnaDra6hOtf5i3kghTDqlG3jjWD8on1DYXZ9
 oV58g06sFhmYZtlpHUofzO5ULx1S4wR3itPrhRS8kEyxNy3dLq5cCFispqPXX7p2fi9oVIe1HA5
 pQsaLDe2nnGE2OsjVDz2HugvYJsoh7H9L2f6xZ34M10hdoW6yG4Gn5gmx8eLvArTltiE8SnltWw
 74RTdd207nTNA+/IR8Yt90hI0ZTAYxAjeuhYkUHpr9S4XGbhumCAOEgCNsOngbeOLDTvwDjG2xr
 wXoD12o1Vovn61xFKeeKDlARwp06nmmyKpyJlEIVoP7fYCRwNDlC1G5ZmzvepdUrFGacKtnPoI6
 hQYbdDkRz6OhDqij2ZYvU/fjqXHM9AcLbtwZJzqbayAEfR46eg6pzOz02bkORvo0oqjv5JEsoap
 /tuamdn/OCfIgd+irCIVL8v1pXD4YX1pxwuG7fitxnOW8gDnGxr8mL8hxY9ZyOJKucts40FF4mB
 TzN9PHO/U3xia7w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

One big Qualcomm Bluetooth schema is hardly manageable: it lists all
possible properties (19 supplies).  Split qcom,wcn6855-bt to separate
bindings, so device schema will be easier to read/maintain and list only
relevant properties.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Expected existing warnings for:
qcs9100-ride-r3.dtb, qcs9100-ride.dtb, sa8775p-ride.dtb,
sa8775p-ride-r3.dtb, sc8280xp-microsoft-arcata*.dtb e.g.:

sc8280xp-microsoft-arcata.dtb: bluetooth (qcom,wcn6855-bt): 'vddaon-supply' is a required property
	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
sc8280xp-microsoft-arcata.dtb: bluetooth (qcom,wcn6855-bt): 'vddwlcx-supply' is a required property
	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
sc8280xp-microsoft-arcata.dtb: bluetooth (qcom,wcn6855-bt): 'vddwlmx-supply' is a required property
	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
sc8280xp-microsoft-arcata.dtb: bluetooth (qcom,wcn6855-bt): 'vddbtcmx-supply' is a required property
	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
sc8280xp-microsoft-arcata.dtb: bluetooth (qcom,wcn6855-bt): 'vddrfa1p8-supply' is a required property
---
 .../bindings/net/bluetooth/qcom,wcn6855-bt.yaml    | 93 ++++++++++++++++++++++
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml | 20 -----
 2 files changed, 93 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml
new file mode 100644
index 000000000000..fcc1df4b8364
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/bluetooth/qcom,wcn6855-bt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm WCN6855 Bluetooth
+
+maintainers:
+  - Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
+  - Rocky Liao <quic_rjliao@quicinc.com>
+
+properties:
+  compatible:
+    enum:
+      - qcom,wcn6855-bt
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
+  vddrfa1p8-supply:
+    description: VDD_RFA_1P8 supply regulator handle
+
+  vddrfacmn-supply:
+    description: VDD_RFA_CMN supply regulator handle
+
+  vddwlcx-supply:
+    description: VDD_WLCX supply regulator handle
+
+  vddwlmx-supply:
+    description: VDD_WLMX supply regulator handle
+
+required:
+  - compatible
+  - vddaon-supply
+  - vddbtcmx-supply
+  - vddrfa0p8-supply
+  - vddrfa1p2-supply
+  - vddrfa1p8-supply
+  - vddrfacmn-supply
+  - vddwlcx-supply
+  - vddwlmx-supply
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
+            compatible = "qcom,wcn6855-bt";
+
+            max-speed = <3000000>;
+            vddaon-supply = <&vreg_pmu_aon_0p8>;
+            vddbtcmx-supply = <&vreg_pmu_btcmx_0p8>;
+            vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+            vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+            vddrfa1p8-supply = <&vreg_pmu_rfa_1p7>;
+            vddrfacmn-supply = <&vreg_pmu_rfa_cmn_0p8>;
+            vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+            vddwlmx-supply = <&vreg_pmu_wlmx_0p8>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index 2ee6579aa02a..ff301798b50c 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -16,7 +16,6 @@ description:
 properties:
   compatible:
     enum:
-      - qcom,wcn6855-bt
       - qcom,wcn7850-bt
 
   enable-gpios:
@@ -47,9 +46,6 @@ properties:
   vddbtcmx-supply:
     description: VDD_BT_CMX supply regulator handle
 
-  vddbtcxmx-supply:
-    description: VDD_BT_CXMX supply regulator handle
-
   vddrfacmn-supply:
     description: VDD_RFA_CMN supply regulator handle
 
@@ -98,22 +94,6 @@ allOf:
   - $ref: bluetooth-controller.yaml#
   - $ref: /schemas/serial/serial-peripheral-props.yaml#
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,wcn6855-bt
-    then:
-      required:
-        - vddrfacmn-supply
-        - vddaon-supply
-        - vddwlcx-supply
-        - vddwlmx-supply
-        - vddbtcmx-supply
-        - vddrfa0p8-supply
-        - vddrfa1p2-supply
-        - vddrfa1p8-supply
   - if:
       properties:
         compatible:

-- 
2.48.1



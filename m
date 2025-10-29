Return-Path: <linux-kernel+bounces-875358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B77C18C46
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4708A403E13
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A236316911;
	Wed, 29 Oct 2025 07:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iAnlANWl"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFB2314A99
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761723867; cv=none; b=CqHN35bE66nP9xw3NxaoBGCEh1goFVyBGJ+eQIM7AEC7Zv0geUoLAlFgeYFCPa5a7ZaScwCqU5WqW/a3Q1aC2ovxG6mQPUunROndAsbVfOmfIpSSzPkbG3NYyTOneroj8C4/OdBOpBr/tu9iVspAek6FLd+r/f/Pd6yTIPO5fcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761723867; c=relaxed/simple;
	bh=a4U05UFZoUixBp5tGk4ntUP6N9avzN8UqAs346gQMTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kXVVlyHVrQDVO2adnuuSUHj7pcEoramT0udIZScxj/B1jd5jdG3G9uBTHRaqQtU0aden/57IKWe4/V1Ef/WirtiroZSAPLr10Z0LCIggP2PmEAYUjzUeB7+AgoURnVqYzNNajIytEzOQQsKtmEQ40ruQwiegU53sfp5YvQ+bCQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iAnlANWl; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-40d0c517f90so580801f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761723863; x=1762328663; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=unG+uv/ANVV0KDcPZEeUh7npYUktIDFl8vrzLiM2xKU=;
        b=iAnlANWlF0KEscOeV6epkHh8sGf8PeQgi7nJ9bbkvgfKV+GvGnEORmnOtvufnSXlrn
         MhoxhGmzMJyAAJevP9IRqogOscgaXZRcytgdl3a5XRx/Ngo0hqh/0PllLgxZrNiPPmM9
         3Mn24t64qFlo9ij7xb1ZOO2AW3McocOltdrEaDWhxqTdVYXRd6xoKeC7n3X5t6TF9Qi7
         xI1FvsQ7LaLLNgxWQ+gEb3LKCq4A28iHCser405JMzdsL5XkuOs8pE4y8Ymdq6/f4JKO
         gx7fZtf22MmVO0MnpJLZif5C+s74o5PKkt84iiK1TTIrY2G1wR2vwahEGalgxCNj8aN2
         vDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761723863; x=1762328663;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unG+uv/ANVV0KDcPZEeUh7npYUktIDFl8vrzLiM2xKU=;
        b=mp2VwpEzwoXOAs8oPcRWVxwHLGQ9cCzQvA1KoCwjvAXUIXCOl2BP6YRrVSfcRvJIn3
         YzKXAXLy1ZYiJcqCZY7xoGfBeWqN3LkOBb/PA3KZ31VhsUrlNkLy9yjvZ5j4OzY3PsmR
         bWTLqPyZ3NYSl7ht6NzkQjo9lcfIbg6jYAGFNB/dIdmSkp4+x6JwKIhNApq3C67RVBFQ
         P0+HgyQVMKp+OLVlHTK+D5U0kiasOdYG78PJ5okNik9ZkY8oqgJgrK3luiE2xGzNQmJy
         gj/j1PRMoapya1JbpstjYaE4k59266MAF+t11xcMS1bu10jdW4IZ4D8Da13IEkXuafPi
         EqTQ==
X-Gm-Message-State: AOJu0YyxlF9N4urMEuXQ//IOPpnzE9TKuLvwaM4Q7Vfhs5eaAtn1VTBE
	aFRA+/HIxbtWEwLnsyglxoawcsrS9PtOVxGgQmlIwQkN2HFNcfoxbc3jdYLMNaFvYWM=
X-Gm-Gg: ASbGncs95unWFN7FSyh9BWdgHPLyDoERpP6d26mRnSzTkP6+baVPZTeS/5HrhEwF2S3
	wjFhzI3QCUNEcAnHdbCZUW7j8EheeeDlZP1v9J8/dRbzLhlOJh1VILNzPSkzRNIJmxvDfy765fd
	BYg4ordp1kdzuGIgIdFszc8OuV2CwxenOHpmh2GMJWyOwZ3H0kTfBVvi2S0+8j4aXAhI26XkHFy
	wmls5fjUwbdd0J/0WiAPKpzUSp9DWOHjNiBQiWRvoPGDkvPWrkmItOn/a/8D0fhpLzgw7WTgPep
	FihC+CwZQhJYMODQE4sIndGA8m+RbM5TTzTBt2vEGc54lYVBU2nKq4zfDwdHo4W9FvnG+WIAilA
	5ZFkk4i33ZAAtb+u9w/aWnJ43kSmQ1gN0WIxzsSlUQSZH9D9pEkJVyGgguZ4WTijNHDjO7SNWLU
	J7bc7+8AcU1J/ipXEF
X-Google-Smtp-Source: AGHT+IH0ZtZl8YemjZED9cGywjUeLaiFbBmaFCsYhav0uDgc9ovXPRvAC3ZLG6zbs3z3/iovDHPaaA==
X-Received: by 2002:a5d:5f55:0:b0:3ee:11d1:29e6 with SMTP id ffacd0b85a97d-429aefb14bdmr702070f8f.6.1761723863028;
        Wed, 29 Oct 2025 00:44:23 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d5c9dsm25861146f8f.26.2025.10.29.00.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 00:44:22 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 29 Oct 2025 08:43:58 +0100
Subject: [PATCH v2 08/11] dt-bindings: bluetooth: qcom,wcn6855-bt: Split to
 separate schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-dt-bindings-qcom-bluetooth-v2-8-dd8709501ea1@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6218;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=a4U05UFZoUixBp5tGk4ntUP6N9avzN8UqAs346gQMTI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAcXG0YloIQ10ujw+eS238x3NvJ7Bg6yV2DjNP
 1jf7BzTYICJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQHFxgAKCRDBN2bmhouD
 1++AD/wKXeXxP0hNapEEimDWUhXYyYiskf7khbQmj64L0jbIk6YcKES3Is1pgaOkSppjwf324pB
 anZrfkQlweR/D5tPcpDfa7dmS5qTttXbFLm8neVJcmtqDK+0YIiqpza1gpKITEw50WY+7zsIDiT
 rTAMABzLrLmvJmFoE98KsrFZSwYmJxZ6abx+NsBl8nctFmNS0TG3jg2su5k1olInxBNMzvH/wyL
 YirITB914aCNS/IeTvXiWDC7+3tKV2/nY5NC4mCCQcJBThQTBHRTa4L3fpbOzUip2busYx8Gq6T
 BNhILBZ5g97h328Li5798K4jq1VAbOjpik6XolF2a4aNpLlt3UpghVsGvsheycYFtz0kA6jMGRS
 gyKtaeGELXqlaFpCW53XzNLHOLOt9tp5yuH1Gxjbc0TvuACj7eigMLW/s6MBPQ13eb34eYAsUuY
 eZ7Vzt96q9fYbS3yV79rJuMQQNEFm25cw66l5k9YBKK6TWqMthgNZNhgnZE1YEJTSnpkGt4VwGC
 dlL6GNfvD0U5I9pv1StmWPsH+FJ11gS4gl0i5tK4mCNoxfM5rNj4cO3nTDvscP2xOM5WYxZ7fMk
 3zu0xdZDx6jjCiBbXBc5ZYduvllQKz1+MrfvdDAyX7XBwn57u8uT6/ctBd9mWmoNvImuux/Q0ir
 Yef5YZ5GUzonJVg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

One big Qualcomm Bluetooth schema is hardly manageable: it lists all
possible properties (19 supplies).  Split qcom,wcn6855-bt to separate
bindings, so device schema will be easier to read/maintain and list only
relevant properties.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Drop few supplies from qualcomm-bluetooth.yaml which are not used by
   devices left there.
2. Add also Bartosz as maintainer because he was working with this
   device in the past.

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
 .../bindings/net/bluetooth/qcom,wcn6855-bt.yaml    | 94 ++++++++++++++++++++++
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml | 26 ------
 2 files changed, 94 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml
new file mode 100644
index 000000000000..a4a887a4dde1
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/bluetooth/qcom,wcn6855-bt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm WCN6855 Bluetooth
+
+maintainers:
+  - Bartosz Golaszewski <brgl@bgdev.pl>
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
index 1ee97089e1d5..62d7cdb67a3a 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -16,7 +16,6 @@ description:
 properties:
   compatible:
     enum:
-      - qcom,wcn6855-bt
       - qcom,wcn7850-bt
 
   enable-gpios:
@@ -37,21 +36,12 @@ properties:
   vdddig-supply:
     description: VDD_DIG supply regulator handle
 
-  vddbtcmx-supply:
-    description: VDD_BT_CMX supply regulator handle
-
-  vddbtcxmx-supply:
-    description: VDD_BT_CXMX supply regulator handle
-
   vddrfacmn-supply:
     description: VDD_RFA_CMN supply regulator handle
 
   vddrfa0p8-supply:
     description: VDD_RFA_0P8 supply regulator handle
 
-  vddrfa1p7-supply:
-    description: VDD_RFA_1P7 supply regulator handle
-
   vddrfa1p8-supply:
     description: VDD_RFA_1P8 supply regulator handle
 
@@ -91,22 +81,6 @@ allOf:
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



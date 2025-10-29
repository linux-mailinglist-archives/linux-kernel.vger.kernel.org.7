Return-Path: <linux-kernel+bounces-875353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A6AC18C52
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C5540689B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC77131282B;
	Wed, 29 Oct 2025 07:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CePGojr+"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131B0311978
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761723860; cv=none; b=ZWuQ3L86DiZWJmAK42+Ittr2eQXlicj/9jXxksdDsPVQvjcVX6f5GWGgI3EcMniFaPoZ1FmJi1ts/AQ2aAdBOHd05JbiFlIofyB6BoQGVG7nbvTJm3tZNZEnBGg4ixeiZia0k1/HakWvjcamsIT57Tw6gn7nPnCYr7as959A8fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761723860; c=relaxed/simple;
	bh=A6wYC3YEQsc+A5KYYaS1o/HAfHvcVlgDyvBeXhkpb9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NrEl9dzKxNct/Nhx+xNh3IkmbwWM8GcO/SaGBqWPXSEHWmTQEW7zr83NE2TpySKAN58Q5ksCFwVntfoodBPd8JluunVzZh3IDBfIzlvDxvkllPQizyLvt71mDRJP8gPmzPU5eTrBmsoaT4feRQREaxbHbhnIfePPUsQDJcjR190=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CePGojr+; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3f4319b8c03so828858f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761723856; x=1762328656; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WTr6a3CJwW930SrBwPOHA6kKG1ThC3Q7Tf/Wukt/A+w=;
        b=CePGojr+3Y80fusfu0Q/+0nLv1wrr8MKc9CTLa2F6Nuxvcx8wPTrhLko65QqekK41y
         8RFP5fObViC6ndndb1UzU344Nn2FQKBddZ+dfirw5QieJP5uV6tAt2pYHaAzE5d+9gp2
         0PY0EBOUu+bGkPLsWjiHaPLesvtza33dYFauViSidVBxVzLXyFOC5I2eXLM8JW2wSWIN
         cP73pnV0keIHSmubgc3qVtDmIuFtn/SNPbLaR12dfaoq5oVYE/PLm8NiVL/qhftx40mv
         DGo1CiE6bIdLdf2mnyXnq279KehBijFVXCg9LPp5LlEJ6mKHmiJDG5tRvtN7j0xFxNEW
         PqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761723856; x=1762328656;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTr6a3CJwW930SrBwPOHA6kKG1ThC3Q7Tf/Wukt/A+w=;
        b=rcVIlsFlIxswKEFjq1XliAdlimH3TRMVATyrKyEP2ngxm7zwXk0n0ctdc4+wPKvMGn
         vJuPUcYwpl+r3xWVjqk/0vEHLB82i2m/tGUg1fbT/5EusObDs3yYuQmP9dBmAnBLg4IJ
         Z2z/w4Ghe05uFouOofZmRTFEyHRrOIhXh7QWl9O+KYngIjUWhQIGrD9OxYZHZEwOIm9e
         RchwntQGerqL4wQ9l/HeIzmFenoe3q39KVQWCgdwxKR57S2UpNCuHgL92u0xoQ+GfVgU
         sfj5IgsCllrY2BtUAF0R2EORWN0WUCqRgl+QUYrMA8EE8SSfi84f+gAhlg0KJPxI3lJn
         8x8g==
X-Gm-Message-State: AOJu0YxUH1EEKvY0xlTXKPzywHsfi28GAv8/U+iVJKNS3sMlm1gxrsUf
	t3MBEF4RE/v4MOi/53hxuHACjlQGYEc2Ety32z2woUyqIvUsvKev/pQoCykraJLmS1g=
X-Gm-Gg: ASbGncsVcY9nW6ZuKvWlg/7FxwA2FVf8/ONGgAq1b0MZo4h+QtGnkyeUQGIvgAUNQUJ
	qyP8B0HNlUugOksXd/507RyupWmDaY1SvXk/oZCzXfw7yM0GAK4EfjArsIHHNbq0Ay7wvVEGZ5i
	HHop6BobVvg5dBPss2dZxa1SXXVA5gH9tl7DiZGgPJfxCy/Zu7Nx4CYzz1+Ytd+Debm8oa4uSyC
	g4RM6JBncXmK9sy2LOC3Ky0aquyTlYpBrt2uKK1Cutg8QX9SlIUW2ebxQHes12wgECWTD4s49XQ
	IKkIiWAej+WX4Jyh6LEcE3+nuoqdfJ2T8vMYEFLmKVabX/Rd+aTmnvtvTrA9YNii+RD1Mzqawp9
	kJCYy0NWB3z4GeL13CxJVxFTgMXVxow+lHyrHSsjq3Sbr7Bw1AgwenejANPLG5sgR3CLZCyV0g1
	u7Je97BvG5D681lSay
X-Google-Smtp-Source: AGHT+IFznjddPTN/INOLPnIpFAEawzIhJYkXVX98eg3ImXyR7cxMk+VQ3KLL3jicDV4R/Zj66sU9Kw==
X-Received: by 2002:a05:6000:2203:b0:3f3:1be5:ecbf with SMTP id ffacd0b85a97d-429aefc04f4mr705076f8f.7.1761723856178;
        Wed, 29 Oct 2025 00:44:16 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d5c9dsm25861146f8f.26.2025.10.29.00.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 00:44:15 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 29 Oct 2025 08:43:53 +0100
Subject: [PATCH v2 03/11] dt-bindings: bluetooth: qcom,qca6390-bt: Split to
 separate schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-dt-bindings-qcom-bluetooth-v2-3-dd8709501ea1@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3588;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=A6wYC3YEQsc+A5KYYaS1o/HAfHvcVlgDyvBeXhkpb9I=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAcXCkLTHsqaOd3nfpdLiExMY6LztYwyYCQbcS
 wnJ2mfAU6uJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQHFwgAKCRDBN2bmhouD
 17p5EACW1iIG1+1hnuwIspBZMqU/E7tYhaUZTcTwWXm0aPowFliIDP70MYFHA09jti32CPD+GBh
 Z9KlTJZDAvH+Qug5Zf7ZwxKvNeky0BZqo95XEAzuZuJjOFw2K9a15zA8O8uCN5ofV5BT+KRnB85
 dgJVmSkJO2Sl1i7c+RNoR7+t6qTNeG/G45rBwZW3twNmyHQ089iKvKLPSrC3yeG902vgCbebmJh
 y/mpEUKCD2wxI+VAqx7wEFDGzSKSFoulh9aX0N8n9cfP6K8HDdG3bRgivRV2oUOFdyDwpzf7GAU
 B91MSgkU7YHv6LhBytK0a6s6GSypnOsTqjC5Rb4PMJN5FvMtjn9tzMUfel1cR/jCfT+yZy0YPHk
 YotGAW97L8wesHzMkZjaVbTy0Kq4X8UpwUddZ3rUvOlsA5vI6mexT6+Pgs7bo8RcxOKSDHkc6O4
 T9QJ0PgdMVWP0EttuoHtWKOZRxu1zcbuZ04Chp9AnJ4xZNJ7fBbslhxG7f81N7CD4vmf8NhETxs
 MnTr+qDGf47TMEQ/Jf0oH766brziKKdTtkAS+uSAcv+LUToW9+inenoQzNeQwHT9LYnvQkp8TiL
 mBeFSJEHe7YftnVgSkr8YSVm51ODgSXpxlh4Zm1mdNSFDKJwEj3UdQvsPAZpFF4Zp36yZjfnMKY
 rlUhjgOi7+deGdg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

One big Qualcomm Bluetooth schema is hardly manageable: it lists all
possible properties (19 supplies).  Split qcom,qca6390-bt to separate
bindings, so device schema will be easier to read/maintain and list only
relevant properties.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/net/bluetooth/qcom,qca6390-bt.yaml    | 64 ++++++++++++++++++++++
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml | 15 -----
 2 files changed, 64 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,qca6390-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,qca6390-bt.yaml
new file mode 100644
index 000000000000..cffbc9e61cd6
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,qca6390-bt.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/bluetooth/qcom,qca6390-bt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QCA6390 Bluetooth
+
+maintainers:
+  - Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
+  - Rocky Liao <quic_rjliao@quicinc.com>
+
+properties:
+  compatible:
+    enum:
+      - qcom,qca6390-bt
+
+  vddaon-supply:
+    description: VDD_AON supply regulator handle
+
+  vddbtcmx-supply:
+    description: VDD_BT_CMX supply regulator handle
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
+  vddrfacmn-supply:
+    description: VDD_RFA_CMN supply regulator handle
+
+required:
+  - compatible
+  - vddaon-supply
+  - vddbtcmx-supply
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
+    serial {
+        bluetooth {
+            compatible = "qcom,qca6390-bt";
+            vddaon-supply = <&vreg_pmu_aon_0p59>;
+            vddbtcmx-supply = <&vreg_pmu_btcmx_0p85>;
+            vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+            vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+            vddrfa1p7-supply = <&vreg_pmu_rfa_1p7>;
+            vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index dba867ef3d06..ac58d6598091 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -21,7 +21,6 @@ properties:
       - qcom,wcn3990-bt
       - qcom,wcn3991-bt
       - qcom,wcn3998-bt
-      - qcom,qca6390-bt
       - qcom,wcn6750-bt
       - qcom,wcn6855-bt
       - qcom,wcn7850-bt
@@ -181,20 +180,6 @@ allOf:
         - vddrfa0p8-supply
         - vddrfa1p2-supply
         - vddrfa1p8-supply
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,qca6390-bt
-    then:
-      required:
-        - vddrfacmn-supply
-        - vddaon-supply
-        - vddbtcmx-supply
-        - vddrfa0p8-supply
-        - vddrfa1p2-supply
-        - vddrfa1p7-supply
 
 examples:
   - |

-- 
2.48.1



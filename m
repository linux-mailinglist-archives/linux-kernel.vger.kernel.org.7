Return-Path: <linux-kernel+bounces-875360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE589C18C60
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0502A4F743E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EF331961B;
	Wed, 29 Oct 2025 07:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mKhKCKSA"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CB43164D8
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761723870; cv=none; b=hbZNEC/eZvzLcaWvdBjrdp3JuL1EIoBKDHEhtY9mNyZAKePnMIO+aQ0u+OiO1FhJA0QGrBKobNX8chnPLV7lZ6F+qDSgfWoAFe7GcSD4jIS2cPfzUn31hOFzL7lBF5IY2UPX/YFrmJ6Y0CghUohVWnWy5zmT83CzYCGyzmBfDcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761723870; c=relaxed/simple;
	bh=VZm5kuE3Kea6ybn3OIoQ4NSNot4jy0OKZWVWGNJwq50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GsyPtW16IxrY/9CvQ33WrwoXLa4vTQXwkbp+g+w0IX7Eb+2tkz77ujSyNIPMFYLUKKXqDbTp0iTnM+PVnqRvnWnAjdK7hvh7WgWAPADsmnNkULY8Hp7+GsS3xrzJkzgBMiBAfgmXnjBJW/N6j3k7mcepoIitqGRg1oFQQ76vLpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mKhKCKSA; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-426ff579fbeso844603f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761723866; x=1762328666; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KGWpdtBAIo7kpBhOblZcipYGsmeu4jB30pQrjbjVir0=;
        b=mKhKCKSAJ/uAOtR4UlzYbCrD7muMNEzi01E32kbmDv+gzByXDvm7u+W6Xnq1AI9VNA
         u9MVwczoeRVS0QD0Wggjv6AMcvxNdkeSj6SxVu234mRvxniAe738xH8Uelup9mJf4Ihr
         7VNJAPEYoRvGlZzl1mL5qPLP/8M6w8q6JLJzKjYUnzZiClRN9+HEynHVfB9BIcAI3P4g
         ftVq3bG0rq8rVNfQifEUABjBsJ8aH6x0jJlEg2/X9kfZg6z3w7UG0UCZPBSXkshVwbuG
         TmTu/H1IRb1hF5/aysSbZkaQP0OUePY1fqAvAd1tw2BdnLV9VQAfKcC+FDAqEpbjCldC
         8DeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761723866; x=1762328666;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGWpdtBAIo7kpBhOblZcipYGsmeu4jB30pQrjbjVir0=;
        b=VNvzzEN1GF9N+bq2L+zpBlw8O/qNs80Z3r2zOn9iTVaV+hB4xZHKONUykx3nutL1Uy
         O26UCl+0r5NWIbKUduygFopLDqj84BpeKC9qGmihNDKFoewtJq9+6H8pPcAYbE50Kj50
         J42C2gT0qb/4hG04uOhpyZVaMXhABkp3mA5+jRfU7dwP/0+RGb6KjJmpKzOcu5cCqCe7
         31GFhgYhEOW43YHqA8SvpGfF4RW/uj362PHQig21//WQBrIug5+4SShvubcyGc1dfkcP
         mRX8EeyNZ1qy5WSE3DXcR0s7nEj5GL1tEe4rCus6lqxogo9U1i8ryltnMqsHJ7KTlkwr
         n50g==
X-Gm-Message-State: AOJu0YyiZZXWNWu1AqQiZ3T70ggvya59lcT2Kag9zsu0HTdfFy12omNa
	tg9K14NgfPgDDR7Y9jnX5bV+NPh4LJJbmtul/mFm0D/z6i2ls1dtQ+LM77NxKdzLVaI=
X-Gm-Gg: ASbGncsRnzVzx84pB+yQ1dWeWTMGFWM/RmtIiYHeS8xlqxXnerFWIg2bsqk+r7w5vzL
	cnC5EqOJ67zp8HwsBaz7bUWquSbR5GII7kWjCSht7hPRFezAQfyn/itzW7vpO++UQmVTioDtOKO
	2gHhrfFDmn59GGJ+eXQhM2H7KlYD0zw0+eR7HUZvwg8sjNqcSZbMKiq6vfI45EmzsfwUGxYDy4A
	0rXg8Clfqu8tPdvWpLFhZNLSYUOFgk1aVWsSm11Wqh+EOQZFEOPz6zvstsvm+dIk7Q+xrFgsRZ/
	WT/9W6qz+umujVQG+D/aWUiX0j2dXxDQAbUMoYTuMSvaUTG/3xExxtPhca0dp5ldsW2x72UQWmK
	ohJwWRQD7iF9IMjOqRoDTqtZ8DmU2cewr64PLq5e14EHSrWp1orJ37aHU+kRDVkNFp0liOEoVnS
	r5N59nh8PeB6UjKuAj
X-Google-Smtp-Source: AGHT+IFGXYqGnWhEJcsB0uGHdwlvwsarLABHC2JwB1BbHqpMb9PF2mXg+6SFCb2V3aFT4lfIyuSxSQ==
X-Received: by 2002:a05:6000:24c5:b0:429:8b99:6048 with SMTP id ffacd0b85a97d-429af00657dmr632122f8f.10.1761723865954;
        Wed, 29 Oct 2025 00:44:25 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d5c9dsm25861146f8f.26.2025.10.29.00.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 00:44:25 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 29 Oct 2025 08:44:00 +0100
Subject: [PATCH v2 10/11] dt-bindings: bluetooth: qcom,wcn7850-bt: Split to
 separate schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-dt-bindings-qcom-bluetooth-v2-10-dd8709501ea1@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4968;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=VZm5kuE3Kea6ybn3OIoQ4NSNot4jy0OKZWVWGNJwq50=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAcXIkunRjgubDBMaiSHGjIo38WUUm+PzyqE3n
 b80iFhgxBuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQHFyAAKCRDBN2bmhouD
 1yyYD/915ifPgW0a+wELvZCLfE4gWb8x+fVMyAV6oGRLy4V34bGzgMWUb6kK2BugblIaw9n/63m
 QHBU6LuF2FobuuWvSk2AOCC+ZyFQ+z1kymJdb1dyQ/frSuusgB/oOkUcsH4irAaQnIvd0f2+nRc
 8kPgnieMvvWbDnahfBjI6lpfwEbaMyo5NNeaolJ5Z4AVtemwSzdSMUtwQhUXHI8xDz7sFYDXHe2
 v7+UbLlfn9OB+Q0vfXeZvFVCygbvGkoh2gcBA2RGHRENt7rQSKsTO8mKE4Ll2viP7XZT0ZbGWUo
 CXJfpzE+QMsER/ZQQocuaKpSYrShd/goksuRL0VTauNSaPYoTHzhdxmHKmZLulloXn+IWBCyXeF
 OynZ9LjzO70vaLmEmRDubxmbmKXbdkw7pI8ZJjZp1XfB/yDzcd/wevhVCracP1vieeZoyv5Qo8a
 wSrTpacDQ53aUZduEOJB0NZmOgKsxW3uH4lnSYRPctwtmSFuT2ntKr4iAWoq8C1Vj6x9NsE4iGz
 8yf+byXPFlvoeM8IC0vP44lIZyVYlSJx+Be2X7KdShcRrPI0p8aNtxw5+3+uPcttvMYwFxYvUyJ
 d3el4+3vlkvi8WQHKGNbbr+k1Q7BHVNL26buehqKGYYXwBFI3I14ax9O1llYqu7eIdNuNTPptI4
 ZlEW3P+zNH+JlHQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

One big Qualcomm Bluetooth schema is hardly manageable: it lists all
possible properties (19 supplies).  Split qcom,wcn7850-bt to separate
bindings, so device schema will be easier to read/maintain and list only
relevant properties.  Re-shuffle few properties to alphabetical order
while moving them and drop redundant enable-gpios description.

This makes the source qualcomm-bluetooth.yaml binding empty, thus drop
it making entire change a variant of file rename.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Add also Bartosz as maintainer because he was working with this
   device in the past.
---
 ...ualcomm-bluetooth.yaml => qcom,wcn7850-bt.yaml} | 83 ++++++++++------------
 1 file changed, 37 insertions(+), 46 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn7850-bt.yaml
similarity index 57%
rename from Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
rename to Documentation/devicetree/bindings/net/bluetooth/qcom,wcn7850-bt.yaml
index 62d7cdb67a3a..bd628e48b4e1 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn7850-bt.yaml
@@ -1,18 +1,16 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
+$id: http://devicetree.org/schemas/net/bluetooth/qcom,wcn7850-bt.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm Bluetooth Chips
+title: Qualcomm WCN7850 Bluetooth
 
 maintainers:
+  - Bartosz Golaszewski <brgl@bgdev.pl>
   - Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
   - Rocky Liao <quic_rjliao@quicinc.com>
 
-description:
-  This binding describes Qualcomm UART-attached bluetooth chips.
-
 properties:
   compatible:
     enum:
@@ -20,79 +18,72 @@ properties:
 
   enable-gpios:
     maxItems: 1
-    description: gpio specifier used to enable chip
 
   swctrl-gpios:
     maxItems: 1
     description: gpio specifier is used to find status
                  of clock supply to SoC
 
-  vddio-supply:
-    description: VDD_IO supply regulator handle
-
   vddaon-supply:
     description: VDD_AON supply regulator handle
 
   vdddig-supply:
     description: VDD_DIG supply regulator handle
 
-  vddrfacmn-supply:
-    description: VDD_RFA_CMN supply regulator handle
+  vddio-supply:
+    description: VDD_IO supply regulator handle
 
   vddrfa0p8-supply:
     description: VDD_RFA_0P8 supply regulator handle
 
-  vddrfa1p8-supply:
-    description: VDD_RFA_1P8 supply regulator handle
-
   vddrfa1p2-supply:
     description: VDD_RFA_1P2 supply regulator handle
 
+  vddrfa1p8-supply:
+    description: VDD_RFA_1P8 supply regulator handle
+
   vddrfa1p9-supply:
     description: VDD_RFA_1P9 supply regulator handle
 
+  vddrfacmn-supply:
+    description: VDD_RFA_CMN supply regulator handle
+
   vddwlcx-supply:
     description: VDD_WLCX supply regulator handle
 
   vddwlmx-supply:
     description: VDD_WLMX supply regulator handle
 
-  max-speed: true
-
-  firmware-name:
-    minItems: 1
-    items:
-      - description: specify the name of nvm firmware to load
-      - description: specify the name of rampatch firmware to load
-
-  local-bd-address: true
-
-  qcom,local-bd-address-broken:
-    type: boolean
-    description:
-      boot firmware is incorrectly passing the address in big-endian order
-
 required:
   - compatible
-
-additionalProperties: false
+  - vddrfacmn-supply
+  - vddaon-supply
+  - vddwlcx-supply
+  - vddwlmx-supply
+  - vddrfa0p8-supply
+  - vddrfa1p2-supply
+  - vddrfa1p8-supply
 
 allOf:
   - $ref: bluetooth-controller.yaml#
+  - $ref: qcom,bluetooth-common.yaml
   - $ref: /schemas/serial/serial-peripheral-props.yaml#
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,wcn7850-bt
-    then:
-      required:
-        - vddrfacmn-supply
-        - vddaon-supply
-        - vddwlcx-supply
-        - vddwlmx-supply
-        - vddrfa0p8-supply
-        - vddrfa1p2-supply
-        - vddrfa1p8-supply
+unevaluatedProperties: false
+
+examples:
+  - |
+    serial {
+        bluetooth {
+            compatible = "qcom,wcn7850-bt";
+
+            max-speed = <3200000>;
+            vddaon-supply = <&vreg_pmu_aon_0p59>;
+            vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+            vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+            vddrfa1p8-supply = <&vreg_pmu_rfa_1p8>;
+            vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
+            vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+            vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
+        };
+    };

-- 
2.48.1



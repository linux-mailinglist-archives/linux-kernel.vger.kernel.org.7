Return-Path: <linux-kernel+bounces-817422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4054B58200
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF9F61663BD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D3428468E;
	Mon, 15 Sep 2025 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JcG67AXa"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6700427B4E4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953677; cv=none; b=jwFMK3/4yqvAB/fzJyk8R1lD9V0KlBnCSiLqvMU3LOZ5K8++EmiSF6c13vCkhfeq73pCSrM1qECAIu0qvXqckfRxNqH2F1Wdinm6pAaQdNYKBhmYL/H5EayRWB7vCzq9ZaZdLBceMYouTQmNNdgULGtLikoUpdVgMQDawS0HMis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953677; c=relaxed/simple;
	bh=dp3PdjDdnBCDNCoLo5pYI/FI1SjBH+7I+EFb+CU2Nb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kxakYhTmnmfanSu45BTTORdQktLlrbU/9oetWt4yReKYjHdolyKL2zxcsHiKZ2gmJA6oM4a33xcVK7o5SrA09yz1v9tXbnieu+sL9fHIB4yo0WvNTUuK4pmNqB55GQPIqMXWOgm+qccZHjs1sTSKHvV1ARVhC1iOgmL6upjcW9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JcG67AXa; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so39392705e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757953673; x=1758558473; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iiRzAGd5Bu7sXKaTAGDSR0/OTr/xNf1IsKHtXs+OV+4=;
        b=JcG67AXaTbFSqagsquxAd8ec/szdxgcgpcmr+tamhwtufryTXW1d3gqyskQYvS8zjx
         3KqsTv5NgoGIxuisTcN0QpHEBvPoQHb0E/gEivLLla/KsCGEA7SsbY8fu0vlPej8TjwQ
         G7x7MWBl7znyDJSiE2uDRezgM43/VHCgvQZyPWnyjahwORcFMnctBNsvOhQKU+aVue3g
         aMIHERTYPm2MwbcSrAt/wMVPkL7yrdKAgTPIDNWcPpa/+2lo1mNYV3yloQZjk2k7lv4V
         +0i+WMy0kQCatkaf38i76PoNINL7zgZJKWJZnApKarAPn7XB6NeS66arzn08WIHyVzob
         BUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757953673; x=1758558473;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iiRzAGd5Bu7sXKaTAGDSR0/OTr/xNf1IsKHtXs+OV+4=;
        b=H32N4aORHHyuQv6gPduFByMGjZlevn2ltKMjSlPVY7cqiLasAGFn1IB60+OyogG+us
         5a6ElxmEwEXnRDNNgnToGCZB/xZFPjVL6wOWSJYFdjLQMJxJR0wIlk6aPkrL7s1qprTz
         /oEyRsO+VtafNcZGw/18xYGIyi5czYHVHBqKjlWl3+gFAasnuL15zN6w/C9QFkOTLGuV
         rcUvr55fuh/JQ+klDy6k5BXS2SDyxFAMNjDP4hRuxTip2sEecaXxPcul7ksFOXrJ8rI3
         XKKMmaW7nGGccIK4ky1PnnpgrkGCqakuAQfojGCm6ay+fgpCf/ZIF2QS0Uku56hr53hE
         6yXg==
X-Forwarded-Encrypted: i=1; AJvYcCXM7OgqWd+GF7MVthm09UyZx4Kj40yQasU+0v4pcwwy8YspC7mbipzZFS+7qrC6sFs+I5G2iCNY5KcH5PM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK9MeMM6Ojm/0hSKbZsgODzkWQjBKdjzPomPdVCR7Y/u+iopEQ
	TRx3seFE8OKqRCjP3VutuqIBeIVA/x2bqCFlKug9IcOIBb0NUk1yH3oFFBjHede9XVi9PeOi2w4
	HSuxG
X-Gm-Gg: ASbGnctZ4vFwL1QKznTyYIa0A91yvOJbKPrGuIpXi1k+R/CfDY0+FRH2db8AQxuulVp
	fse8wI49Wm3TfSq9GG9UF3W9yOteVTyN9TTkgjoXpQ2lFbacK3+MMjRp1uynOcq+fPpuoMLvNqD
	1bPQ+CrA/j5j948eZkKx+NYjH+jKekNvpVyvE2wAYZ0FptHKc//aQDLcmKLdVWBKbMlEJkyGnwI
	BmmzQkTSuYdT+zEm+PAtnuRxNZZtbWZxS+jofH2gU5WHUfII51w4xySTomotVB1b58IXfc5Yzn1
	NWFPM/0doVBzjbISFrc2BFBsWf0dSgZlHMQgdl289TDZ7ueuAV8+MLLd+VXPLHg3de3+NkvRAQw
	JEUzM8U8jKoseVQKBrwayaVvs2RBWI6/iM7HS7LU=
X-Google-Smtp-Source: AGHT+IHCMUIWvbbbrjTN7JnsuSXMb9IngsbObevrB939xc8giHGGWQEsHkncW8Ue/c6n31Nvg8IviQ==
X-Received: by 2002:a05:600c:3506:b0:45f:2d7b:7953 with SMTP id 5b1f17b1804b1-45f2efdf77cmr28899635e9.18.1757953673398;
        Mon, 15 Sep 2025 09:27:53 -0700 (PDT)
Received: from orion.home ([2a02:c7c:7259:a00:e60f:4b6c:1734:808b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e9a066366fsm7857989f8f.44.2025.09.15.09.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:27:52 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Mon, 15 Sep 2025 17:27:48 +0100
Subject: [PATCH v4 1/4] dt-bindings: sound: add bindings for pm4125 audio
 codec
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-pm4125_audio_codec_v1-v4-1-b247b64eec52@linaro.org>
References: <20250915-pm4125_audio_codec_v1-v4-0-b247b64eec52@linaro.org>
In-Reply-To: <20250915-pm4125_audio_codec_v1-v4-0-b247b64eec52@linaro.org>
To: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>, 
 christophe.jaillet@wanadoo.fr, Alexey Klimov <alexey.klimov@linaro.org>
X-Mailer: b4 0.14.2

The audio codec IC is found on Qualcomm PM4125/PM2250 PMIC.
It has TX and RX soundwire slave devices hence two files are added.

Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 .../bindings/sound/qcom,pm4125-codec.yaml          | 134 +++++++++++++++++++++
 .../devicetree/bindings/sound/qcom,pm4125-sdw.yaml |  79 ++++++++++++
 2 files changed, 213 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,pm4125-codec.yaml b/Documentation/devicetree/bindings/sound/qcom,pm4125-codec.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..6e2f103be1d32479ebe3420e06d1ebedaf3bc379
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,pm4125-codec.yaml
@@ -0,0 +1,134 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,pm4125-codec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm PM4125 Audio Codec
+
+maintainers:
+  - Alexey Klimov <alexey.klimov@linaro.org>
+
+description:
+  The audio codec IC found on Qualcomm PM4125/PM2250 PMIC.
+  It has RX and TX Soundwire slave devices.
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,pm4125-codec
+
+  reg:
+    description:
+      Specifies the SPMI base address for the audio codec peripherals. The
+      address space contains reset register needed to power-on the codec.
+    maxItems: 1
+
+  reg-names:
+    maxItems: 1
+
+  vdd-io-supply:
+    description: A reference to the 1.8V I/O supply
+
+  vdd-cp-supply:
+    description: A reference to the charge pump I/O supply
+
+  vdd-mic-bias-supply:
+    description: A reference to the 3.3V mic bias supply
+
+  vdd-pa-vpos-supply:
+    description: A reference to the PA VPOS supply
+
+  qcom,tx-device:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: A reference to Soundwire tx device phandle
+
+  qcom,rx-device:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: A reference to Soundwire rx device phandle
+
+  qcom,micbias1-microvolt:
+    description: micbias1 voltage
+    minimum: 1800000
+    maximum: 2850000
+
+  qcom,micbias2-microvolt:
+    description: micbias2 voltage
+    minimum: 1800000
+    maximum: 2850000
+
+  qcom,micbias3-microvolt:
+    description: micbias3 voltage
+    minimum: 1800000
+    maximum: 2850000
+
+  qcom,mbhc-buttons-vthreshold-microvolt:
+    description:
+      Array of 8 Voltage threshold values corresponding to headset
+      button0 - button7
+    minItems: 8
+    maxItems: 8
+
+  '#sound-dai-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - vdd-io-supply
+  - vdd-cp-supply
+  - vdd-mic-bias-supply
+  - vdd-pa-vpos-supply
+  - qcom,tx-device
+  - qcom,rx-device
+  - qcom,micbias1-microvolt
+  - qcom,micbias2-microvolt
+  - qcom,micbias3-microvolt
+  - '#sound-dai-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/spmi/spmi.h>
+
+    spmi {
+        #address-cells = <2>;
+        #size-cells = <0>;
+
+        pmic {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            audio-codec@f000 {
+                compatible = "qcom,pm4125-codec";
+                reg = <0xf000>;
+                vdd-io-supply = <&pm4125_l15>;
+                vdd-cp-supply = <&pm4125_s4>;
+                vdd-pa-vpos-supply = <&pm4125_s4>;
+                vdd-mic-bias-supply = <&pm4125_l22>;
+                qcom,micbias1-microvolt = <1800000>;
+                qcom,micbias2-microvolt = <1800000>;
+                qcom,micbias3-microvolt = <1800000>;
+                qcom,rx-device = <&pm4125_rx>;
+                qcom,tx-device = <&pm4125_tx>;
+                #sound-dai-cells = <1>;
+            };
+        };
+    };
+
+    /* ... */
+
+    soundwire@a610000 {
+        reg = <0x0a610000 0x2000>;
+        #address-cells = <2>;
+        #size-cells = <0>;
+        pm4125_rx: audio-codec@0,4 {
+            compatible = "sdw20217010c00";
+            reg = <0 4>;
+            qcom,rx-port-mapping = <1 3>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/sound/qcom,pm4125-sdw.yaml b/Documentation/devicetree/bindings/sound/qcom,pm4125-sdw.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..23624f32ac305838da7b472ef25995197d42f2b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,pm4125-sdw.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,pm4125-sdw.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SoundWire Slave devices on PM4125/PM2250 PMIC audio codec.
+
+maintainers:
+  - Alexey Klimov <alexey.klimov@linaro.org>
+
+description:
+  The audio codec IC found on Qualcomm PM4125/PM2250 PMICs.
+  It has RX and TX Soundwire slave devices.
+
+properties:
+  compatible:
+    const: sdw20217010c00
+
+  reg:
+    maxItems: 1
+
+  qcom,tx-port-mapping:
+    description: |
+      Specifies static port mapping between device and host tx ports.
+      In the order of the device port index which are adc1_port, adc23_port,
+      dmic03_mbhc_port, dmic46_port.
+      Supports maximum 2 tx soundwire ports.
+
+      PM4125 TX Port 1 (ADC1,2 & DMIC0 & MBHC)    <=> SWR0 Port 1
+      PM4125 TX Port 2 (ADC1 & DMIC0,1,2 & MBHC)  <=> SWR0 Port 2
+
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 2
+    maxItems: 2
+    items:
+      enum: [1, 2, 3, 4]
+
+  qcom,rx-port-mapping:
+    description: |
+      Specifies static port mapping between device and host rx ports.
+      In the order of device port index which are hph_port, clsh_port,
+      comp_port, lo_port, dsd port.
+      Supports maximum 2 rx soundwire ports.
+
+      PM4125 RX Port 1 (HPH_L/R)       <==>    SWR1 Port 1 (HPH_L/R)
+      PM4125 RX Port 2 (COMP_L/R)      <==>    SWR1 Port 3 (COMP_L/R)
+
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 2
+    maxItems: 2
+    items:
+      enum: [1, 2, 3, 4, 5]
+
+required:
+  - compatible
+  - reg
+
+oneOf:
+  - required:
+      - qcom,tx-port-mapping
+  - required:
+      - qcom,rx-port-mapping
+
+additionalProperties: false
+
+examples:
+  - |
+    soundwire@a610000 {
+        reg = <0x0a610000 0x2000>;
+        #address-cells = <2>;
+        #size-cells = <0>;
+        pm4125_rx: codec@0,1 {
+            compatible = "sdw20217010c00";
+            reg = <0 1>;
+            qcom,rx-port-mapping = <1 3>;
+        };
+    };
+...

-- 
2.47.3



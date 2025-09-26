Return-Path: <linux-kernel+bounces-833624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FC8BA276B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 07:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2582A7A8B7A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 05:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCB5279DCD;
	Fri, 26 Sep 2025 05:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJ3al/3l"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CBE27990D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 05:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758865177; cv=none; b=LdxB2WfLI+cKvkGNf8uMKgZXCVLw9/sWJMgEfHH6OEnzII65fZexrfTtm3hj9T0ikWFlXlqipTA0Uyof66KpmP3Y9n7E5Iqnl6Pgz8aZxdZL8daSe0nSVNAc3GxMMQNMvtXDpFCSBhCpC81U6Osh+upaJVNalnr097/5l3w9ta0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758865177; c=relaxed/simple;
	bh=es2eQE3djkxxO7Qk3efIm3x2FtzFs1v6bsaNQwYnZRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nrn0nhRNZOeIgOoMep5IqY+rHaw1Ykxpd0uxBx2ooUrj9k1uudi3sCSf6Ko5p3kulkC1D+Z5rz0R3HVNmCM1xy8k7WNrreeGZo6zvgL37VIPqjkZiQfIn5Z335Vq+9hrLb/kYnf6POrE0xeGUXFMmuBNYLWmcW/UzgSZTslk6oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJ3al/3l; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso1524349a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 22:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758865175; x=1759469975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PY8OmxrnVOq+prHUYZH2nnjzosZ3Ye7L/hjac8Ucls=;
        b=hJ3al/3lJn/oqXyz13cnbzkMRXeFTkpUDWTQBELygGg6EtjnPiP9g8m0GfHvIF4Wvb
         zTy6U+yEbMe818Jw44uV46qvOUWJi3giYJEPzOVYAMUlWsEEqPqo3cmH9utXLFEZ40XV
         xu8LZizGfq29mQ9Nl1FkeE3MaN2gq2RPBpcbkM1LlyLTfH5mZVvjEp7xFpIbLGAbRQ1N
         dG3CwqeV6GjFoVMtnqz8EHE0ZhRLpfPVjwfYMIIWMqF+KG5+gFSZvFPW4CY5V1Lt7Yf2
         4mihp0PlCIeqVxQ49SXyyRR8G+XHsv25Ovi1iCPUsUmGFsjpmmU0t1eeaOgQO97TQRqi
         iXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758865175; x=1759469975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PY8OmxrnVOq+prHUYZH2nnjzosZ3Ye7L/hjac8Ucls=;
        b=knqDYY80iyfetGQTHDm4DjILnjGSh4/WkRKBkqVwNN+v1V7PtyfyPwRL5dljkrLbLu
         p9ON7BM6BNtYEQOYGovFtBtn8bZC/biht1WCKggNieffSd8OFIVpKNAVzENMRwaeaalW
         a9MddTu0o9xi7g5w2JRTAHHzIMYmeEQKTIGpHIOHjwIusqQm4mzJ7zpFfwxdx2bZKy7U
         GAt0+d3c+QQVGJgvagx8bplGWerbzSFc3IuwZvcbW9cFn4i7Y9AdiaQuaJcH9SEBbcID
         OTSNzdOzfeDEUMQ5FRVlMVdCdwt5tA34ZC4134kFtlJ/OnbCFVbluE5iMye7R17yRRIT
         cUUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+rMHk5ea8V4gXpdwFeTzGPnLXVlMdpp08XIV1naPwSK/cJ6tyFzsr2Gh6HgxKOvrxFz16LDXudSgfsck=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmThMRumCXQj1684ERFLFmO+t3EMdq1oJMtMA5si03rYXLLuzT
	s2eykitvzzmPSDTBok0FCntQvsmCmuinepNe7/gfGk0bZK1yUqShrRdoUVRyTjlu
X-Gm-Gg: ASbGncuLFgB4531J3RaXnPGQgnG1ZVhqF+ZofCaNb/DjL5PY28IIlDnx4VYcI1M63Li
	O/t+uBEjnwZcGp/sqGk6Qp6OHzWTIGfXlloRRwVRe2DjWOVPWtD064n8xtOxucyjdEGz1qbcX43
	hNcBf3yWoPio/Cvve0dwki/05lzFLJwLepx+0MZ3ZXalGUHOZpTZIUX9LxZxxt5gQUhffhyuJTn
	v+a1wMIkX2DHoykTtmdUvQnCZ7P+e/l6XIIKusHLhUN9Tt9F37JlE7ViE8TB56VBrwil/D71emU
	fkEYV2AFiQnWKEN4iVYm49YizKMxvD1xJn68HS5unhQ1gkWYOphRUUoBEuBks3Zg4KCvSULenwG
	HUxopq7oGbCzfI9Fa6xAJlTMPDJ0=
X-Google-Smtp-Source: AGHT+IHXXCiOJ87lACs1ryDg7uTbgoizv4IJqKAeO62UyNVH72OTM7dAbIlLZH3/ChmrrJEXwNlgHA==
X-Received: by 2002:a17:902:d50a:b0:267:da75:e0f with SMTP id d9443c01a7336-27ed4a06dd7mr75337155ad.11.1758865175138;
        Thu, 25 Sep 2025 22:39:35 -0700 (PDT)
Received: from HYB-iPCgmhaB8Cy.ad.analog.com ([59.9.235.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66fb07dsm41925025ad.36.2025.09.25.22.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 22:39:34 -0700 (PDT)
From: Joan-Na-adi <joan.na.devcode@gmail.com>
X-Google-Original-From: Joan-Na-adi <joan.na@analog.com>
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Joan Na <joan.na@analog.com>
Subject: [PATCH 3/3] dt-bindings: regulator: Add MAX77675 regulator binding
Date: Fri, 26 Sep 2025 14:37:57 +0900
Message-Id: <20250926053757.480086-4-joan.na@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926053757.480086-1-joan.na@analog.com>
References: <20250926053757.480086-1-joan.na@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Joan Na <joan.na@analog.com>

Add device tree binding YAML schema for the Maxim MAX77675 PMIC regulator.
This defines the node properties and supported regulator names for use
in device tree sources.

Signed-off-by: Joan Na <joan.na@analog.com>
---
 .../bindings/regulator/maxim,max77675.yaml    | 202 ++++++++++++++++++
 1 file changed, 202 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77675.yaml

diff --git a/Documentation/devicetree/bindings/regulator/maxim,max77675.yaml b/Documentation/devicetree/bindings/regulator/maxim,max77675.yaml
new file mode 100644
index 000000000000..f93dfdc499bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/maxim,max77675.yaml
@@ -0,0 +1,202 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/maxim,max77675.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX77675 PMIC Regulator
+
+maintainers:
+  - Joan Na <joan.na@analog.com>
+
+description: |
+  The MAX77675 is a PMIC providing multiple switching buck regulators
+  (SBB0–SBB3), accessible via I2C. Each SBB can be configured individually
+  in the Device Tree. Additional PMIC settings can be configured through
+  device-specific properties.
+  Users should use the macros from dt-bindings/regulator/maxim,max77675-regulator.h
+
+allOf:
+  - $ref: regulator.yaml#
+
+properties:
+  compatible:
+    const: maxim,max77675
+
+  reg:
+    maxItems: 1
+
+  maxim,dvs-slew-rate:
+    description: |
+      DVS slew rate setting.
+      0 (MAX77675_DVS_SLEW_5MV) - 5 mV/μs
+      1 (MAX77675_DVS_SLEW_10MV) - 10 mV/μs
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+
+  maxim,latency-mode:
+    description: |
+      Latency mode for voltage transition:
+      0 (MAX77675_LAT_MODE_HIGH_LATENCY) - Low quiescent current, high latency (~100μs)
+      1 (MAX77675_LAT_MODE_LOW_LATENCY) - High quiescent current, low latency (~10μs)
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+
+  maxim,drv-sbb-strength:
+    description: |
+      SIMO Buck-Boost Drive Strength Trim.
+      0 (MAX77675_DRV_SBB_FASTEST) - Fastest transition (~0.6 ns)
+      1 (MAX77675_DRV_SBB_FAST) - Faster transition (~1.2 ns)
+      2 (MAX77675_DRV_SBB_MEDIUM) - Moderate transition (~1.8 ns)
+      3 (MAX77675_DRV_SBB_SLOWEST) - Slowest transition (~8 ns)
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+
+  maxim,manual-reset-time:
+    description: |
+      Manual reset time in seconds:
+      0 (MAX77675_MRT_4S): 4 seconds
+      1 (MAX77675_MRT_8S): 8 seconds
+      2 (MAX77675_MRT_12S): 12 seconds
+      3 (MAX77675_MRT_16S): 16 seconds
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+
+  maxim,en-pullup-disable:
+    description: |
+      Disable internal pull-up for EN pin.
+      0 (MAX77675_PU_EN): Internal pull-up enabled (default).
+      1 (MAX77675_PU_DIS): Internal pull-up disabled.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+
+  maxim,bias-low-power-request:
+    description: |
+      Controls the bias low-power mode setting.
+      0 (MAX77675_BIAS_NORMAL): Normal bias operation
+      1 (MAX77675_BIAS_LPM_REQ): Request low-power bias mode
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+
+  maxim,simo-int-ldo-always-on:
+    description: |
+      SIMO internal channel disable configuration.
+      0 (MAX77675_SIMO_INT_NORMAL): SIMO channel enabled
+      1 (MAX77675_SIMO_INT_LDO): SIMO channel disabled
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+
+  maxim,en-mode:
+    description: |
+      Enable mode configuration.
+      0 (MAX77675_EN_PUSH_BUTTON): Push button
+      1 (MAX77675_EN_SLIDE_SWITCH): Slide switch
+      2 (MAX77675_EN_LOGIC): Logic mode
+      3 (MAX77675_EN_RESERVED): Reserved
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+
+  maxim,en-debounce-time:
+    description: |
+      Debounce timer enable.
+      0 (MAX77675_DBEN_100US): 100us
+      1 (MAX77675_DBEN_30MS): 30ms
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+
+  regulators:
+    type: object
+    description: Regulator child nodes
+    patternProperties:
+      "^sbb[0-3]$":
+        type: object
+        $ref: regulator.yaml#
+    properties:
+      maxim,fps-slot:
+        description: |
+          FPS slot selection.
+          0 (MAX77675_FPS_SLOT_0): FPS Slot 0
+          1 (MAX77675_FPS_SLOT_1): FPS Slot 1
+          2 (MAX77675_FPS_SLOT_2): FPS Slot 2
+          3 (MAX77675_FPS_SLOT_3): FPS Slot 3
+          4 (MAX77675_FPS_NONE): No FPS Slot (disabled)
+          5 (MAX77675_FPS_DEF): Use the defaul
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1, 2, 3, 4, 5]
+
+      maxim,slew-rate-use-dvs:
+        description: |
+          0 (MAX77675_SR_2MV_PER_US): Fixed slew rate of 2mV/μs.
+          1 (MAX77675_SR_USE_DVS): Uses maxim,dvs-slew-rate for dynamic voltage scaling.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1]
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/regulator/maxim,max77675-regulator.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      max77675: pmic@44 {
+        compatible = "maxim,max77675";
+        reg = <0x44>;
+
+        maxim,dvs-slew-rate = <MAX77675_DVS_SLEW_5MV>;
+        maxim,latency-mode = <MAX77675_LAT_MODE_HIGH_LATENCY>;
+        maxim,drv-sbb-strength = <MAX77675_DRV_SBB_FASTEST>;
+        maxim,manual-reset-time = <MAX77675_MRT_4S>;
+        maxim,en-pullup-disable = <MAX77675_PU_EN>;
+        maxim,bias-low-power-request = <MAX77675_BIAS_NORMAL>;
+        maxim,simo-int-ldo-always-on = <MAX77675_SIMO_INT_NORMAL>;
+        maxim,en-mode = <MAX77675_EN_PUSH_BUTTON>;
+        maxim,en-debounce-time = <MAX77675_DBEN_100US>;
+
+        regulators {
+          sbb0: sbb0 {
+            regulator-name = "sbb0";
+            regulator-min-microvolt = <500000>;
+            regulator-max-microvolt = <5500000>;
+            maxim,fps-slot = <MAX77675_FPS_DEF>;
+            maxim,slew-rate-use-dvs = <MAX77675_SR_2MV_PER_US>;
+          };
+
+          sbb1: sbb1 {
+            regulator-name = "sbb1";
+            regulator-min-microvolt = <500000>;
+            regulator-max-microvolt = <5500000>;
+            regulator-allow-set-voltage;
+            maxim,fps-slot = <MAX77675_FPS_DEF>;
+            maxim,slew-rate-use-dvs = <MAX77675_SR_2MV_PER_US>;
+          };
+
+          sbb2: sbb2 {
+            regulator-name = "sbb2";
+            regulator-min-microvolt = <500000>;
+            regulator-max-microvolt = <5500000>;
+            regulator-allow-set-voltage;
+            maxim,fps-slot = <MAX77675_FPS_DEF>;
+            maxim,slew-rate-use-dvs = <MAX77675_SR_2MV_PER_US>;
+          };
+
+          sbb3: sbb3 {
+            regulator-name = "sbb3";
+            regulator-min-microvolt = <500000>;
+            regulator-max-microvolt = <5500000>;
+            regulator-allow-set-voltage;
+            maxim,fps-slot = <MAX77675_FPS_DEF>;
+            maxim,slew-rate-use-dvs = <MAX77675_SR_2MV_PER_US>;
+          };
+        };
+      };
+    };
+
--
2.34.1



Return-Path: <linux-kernel+bounces-851849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5E6BD76E3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FB7B406F41
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B364F296BAF;
	Tue, 14 Oct 2025 05:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEOX6lXv"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1739D28D84F
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760419983; cv=none; b=DmgzMUYhAoHUqrzvHzu0+6WyO39XaL1P2Mq4zSmXg1Dl/8varCvQ2KPk6Yf3TnLw35GwiexUNtx4v0K5YuPWT4QaqMUtPHey8UET6X+HXcs83SjgTIUQhvwduWzfWW9GMSnbL6aw4dN4ZlKDy8SMlJG2l9KMp7th5zTlfGWvFmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760419983; c=relaxed/simple;
	bh=L4IWpUT1tu+22s1TJPENmdfGuR7+rrfCVl2+130p6ns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qXysC2Y87IJ+WgF+9iW4t4GynfjbaA/6z0K08XF0HkqFloGqwGYsXBoriXsVaYL4/ixmfSozxqOrBphrq1Fg2ZUqWx4lpyzIWGByEiZ+fr7yoUHQEsN0Q43rWBgYJfVzGlXf8Mrk0JW2x8+69hp5uRrJ7P1yo2GlNTFW0YTuCO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEOX6lXv; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-791c287c10dso4157610b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760419981; x=1761024781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnpCg/t/Khm10HtRlVhL990/eXBRCmOVH33yOfrVJ48=;
        b=YEOX6lXv22vp67L2960T4Hr04osU4bhbXCP3XZZHtAjBsV5Un0Uk3xLpaOSUEXPViY
         ghwV7Z0iXLv2lPWDJVCykt9pvxq5mtR+oK9nmndf3LIQtlM3/t+CSl4emBfuB2+xi5GN
         sKAxvi6hhAMebEzN74BtTkV7BeoHHYoa1jkFyEdeVEuR4oJCcuqnzDGor/Oqr3R2wlha
         7xrJWQKpd8gZI4b0u/2R/pySl0ptJS+NYXsTVHwVaIT5kIUGKdwQbabVsY9RcnAqmiuW
         3ccGk+GoTgWvA/5K4yfA6WFmKcreK70ofpW17tpIUCWuaJzZXfJV1RPjjebDddj+Eg4D
         il+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760419981; x=1761024781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnpCg/t/Khm10HtRlVhL990/eXBRCmOVH33yOfrVJ48=;
        b=J/suwkqtETSwyP/L4/8u3IY/C/xGcGlwlGjgfzOeuaKNAx1LjIxXY1MlZ8aSf322vK
         xlZnS7bHihCS13INFa6WW2qUyq7p1FTqjJInxP/2+FPaCGaSCXRj4IYvt2pcrHoCtB/4
         6+MkbBSwC/aZTL7rZDcD/5mjotEMne603EB8bhAeK3jiAhJ9FR09TQka7cw8JOWScaST
         Bn++P5Ehfwq/LB4I8IWUE0surspC8zGy/45v4Z43n0VBJAep6uZ3Fu5MOOa5sPaMopZ8
         /CkTS3fGqilG/Hg7yylSLdneEagKRH5nKyRVahv+W9CiPaDt/h6YoH8LFh1gOJo4AoMR
         QoBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHFjbi6v1nJarjTHRQDYvPtV/DRuNOz6mjNCD8A2RcW62E9CPN1GgHYaFTWUYTC/d3AXIr+ZriDqd1zSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbBo7Pzu+xXMOFVOZoO6twSpQMSWIu5dWijlRB97xK/DzxdyT/
	Zr7lJzj5Lw3xI5hbiEF04gaX6o8KTu+fPXKQv4JGcOWPcBekTJvkgN/T
X-Gm-Gg: ASbGncswfk0uTOJoiBmLfa5beJsIzZ/hclwozRdiVDE4R+A2PW7CiwOA4NmHBsxSxIv
	wYJXM7VNny/jn7VcgKnOWt8i/5KY3rts/eKDHoRv5HjoUBnVV4jcEJrf1ghZX3Ep5DzfCY43lfY
	LmEfmGCHjfxNiC55sPvFDSLAtIhhe4W3Ox3+8kk0KKc1hvhql30pPUEHgqj1Jk1DJzAXvxM0e+L
	pWbgGIBnOwejzpun10WCWwmZuEfe+0vxKrlb6BBCWdbFiqAo7UHtyjg883dYhREqDiY1hTifJsy
	V0Lv6/M8FcWSwJTuxPbQeLheDOvpGoKDuWot4QJiTkyGdtI5vuYnrKrFX3Zo7ZxoHpFNN9tsZSc
	eNxIC+gEm7PNaYWGvNB08O8O0v7MjRojcNgwIBbVC7dufdAo4uPudxjNYOblNzDc0OrFzwzk=
X-Google-Smtp-Source: AGHT+IHH6PKXbyw9C/xLYLyPoKQlnHQrTueCaiEP4hA278xAUbmnESZgWV2xXhtSHenWJKnrXmxUpA==
X-Received: by 2002:a05:6a00:1146:b0:77f:472b:bc73 with SMTP id d2e1a72fcca58-793859f31cemr29601385b3a.6.1760419981130;
        Mon, 13 Oct 2025 22:33:01 -0700 (PDT)
Received: from HYB-iPCgmhaB8Cy.ad.analog.com ([59.9.235.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992bb11ca0sm13707518b3a.32.2025.10.13.22.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 22:33:00 -0700 (PDT)
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
Subject: [PATCH v3 3/3] dt-bindings: regulator: Add MAX77675 regulator binding
Date: Tue, 14 Oct 2025 14:31:42 +0900
Message-Id: <20251014053142.15835-4-joan.na@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014053142.15835-1-joan.na@analog.com>
References: <20251014053142.15835-1-joan.na@analog.com>
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

Fixed:
- Missing explanation of `maxim,fps-slot` default value
- Updated DT binding enums to use string values (e.g., "low", "high") instead of integers
- Converted several binary properties to boolean type
- Renamed time-based properties to use standard unit suffixes (e.g., "-sec", "-us")
- Added default values for properties

Signed-off-by: Joan Na <joan.na@analog.com>
---
 .../bindings/regulator/maxim,max77675.yaml    | 205 ++++++++++++++++++
 1 file changed, 205 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77675.yaml

diff --git a/Documentation/devicetree/bindings/regulator/maxim,max77675.yaml b/Documentation/devicetree/bindings/regulator/maxim,max77675.yaml
new file mode 100644
index 000000000000..6be29eced039
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/maxim,max77675.yaml
@@ -0,0 +1,205 @@
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
+  maxim,en-mode:
+    description: |
+      Enable mode configuration.
+      "push-button"  - Push button
+      "slide-switch" - Slide switch
+      "logic" - Logic mode
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: ["push-button", "slide-switch", "logic"]
+    default: "slide-switch"
+
+  maxim,latency-mode:
+    description: |
+      Latency mode for voltage transition:
+      "high" - High latency (100μs)
+      "low"  - Low latency (10μs)
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: ["high", "low"]
+    default: "high"
+
+  maxim,drv-sbb-strength:
+    description: |
+      SIMO Buck-Boost Drive Strength Trim.
+      Controls the drive strength of the SIMO regulator's power MOSFETs.
+      This setting affects the switching speed, which impacts power efficiency and EMI.
+      "max"  – Maximum drive strength (~0.6 ns transition time)
+      "high" – High drive strength (~1.2 ns transition time)
+      "low"  – Low drive strength (~1.8 ns transition time)
+      "min"  – Minimum drive strength (~8 ns transition time)
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: ["max", "high", "low", "min"]
+    default: "max"
+
+  maxim,dvs-slew-rate-mv-per-us:
+    description: |
+      Dynamic rising slew rate for output voltage transitions, in mV/μs.
+      This setting is only used when 'maxim,fixed-slew-rate' is not present.
+    enum: [5, 10]
+    default: 5
+
+  maxim,en-debounce-time-us:
+    description: |
+      Debounce time for the enable pin, in microseconds
+    enum: [100, 30000]
+    default: 100
+
+  maxim,manual-reset-time-sec:
+    description: |
+      Manual reset time in seconds:
+    enum: [4, 8, 12, 16]
+    default: 4
+
+  maxim,en-pullup-disable:
+    type: boolean
+    description: |
+      Disable internal pull-up for EN pin.
+      When set, the internal pull-up is disabled.
+      Defaults to enabled if this property is not specified.
+    default: false
+
+  maxim,bias-low-power-request:
+    type: boolean
+    description: |
+      Request low-power bias mode.
+      When set, the device enters low-power bias mode.
+      Defaults to normal bias mode if this property is not specified.
+    default: false
+
+  maxim,simo-int-ldo-always-on:
+    type: boolean
+    description: |
+      Set internal LDO to always supply 1.8V
+      When set, the internal LDO always supplies 1.8V.
+      By default, the SIMO internal channel supplies 1.8V during low-power mode
+    default: false
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
+          FPS (Flexible Power Sequencer) slot selection.
+          The Flexible Power Sequencer allows resources to power up under hardware or software control.
+          Additionally, each resource can power up independently or among a group of other regulators
+          with adjustable power-up and power-down slots.
+          This device's regulators provide an additional property to configure the FPS parameters,
+          allowing each regulator to be assigned to an FPS slot for proper power management control.
+          "slot0"   - Assign to FPS Slot 0
+          "slot1"   - Assign to FPS Slot 1
+          "slot2"   - Assign to FPS Slot 2
+          "slot3"   - Assign to FPS Slot 3
+          "default" - Use the default FPS slot value stored in OTP and read from the register
+        $ref: /schemas/types.yaml#/definitions/string
+        enum: ["slot0", "slot1", "slot2", "slot3", "default"]
+        default: default
+
+      maxim,fixed-slew-rate:
+        type: boolean
+        description: |
+          Use fixed slew rate of 2 mV/μs for output voltage transitions.
+          When this property is present, the device uses a constant 2 mV/μs slew rate
+          and ignores any dynamic slew rate configuration.
+          When absent, the device uses the dynamic slew rate specified
+          by 'maxim,dvs-slew-rate-mv-per-us'
+        default: true
+
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
+        maxim,en-mode = "slide-switch";
+        maxim,latency-mode = "high";
+        maxim,drv-sbb-strength = "max";
+        maxim,dvs-slew-rate-mv-per-us = <5>;
+        maxim,manual-reset-time-sec = <4>;
+        maxim,en-debounce-time-us = <100>;
+
+        regulators {
+          sbb0: sbb0 {
+            regulator-name = "sbb0";
+            regulator-min-microvolt = <500000>;
+            regulator-max-microvolt = <5500000>;
+            maxim,fps-slot = "default";
+            maxim,slew-rate-use-dvs;
+          };
+
+          sbb1: sbb1 {
+            regulator-name = "sbb1";
+            regulator-min-microvolt = <500000>;
+            regulator-max-microvolt = <5500000>;
+            regulator-allow-set-voltage;
+            maxim,fps-slot = "default";
+            maxim,slew-rate-use-dvs;
+          };
+
+          sbb2: sbb2 {
+            regulator-name = "sbb2";
+            regulator-min-microvolt = <500000>;
+            regulator-max-microvolt = <5500000>;
+            regulator-allow-set-voltage;
+            maxim,fps-slot = "default";
+            maxim,slew-rate-use-dvs;
+          };
+
+          sbb3: sbb3 {
+            regulator-name = "sbb3";
+            regulator-min-microvolt = <500000>;
+            regulator-max-microvolt = <5500000>;
+            regulator-allow-set-voltage;
+            maxim,fps-slot = "default";
+            maxim,slew-rate-use-dvs;
+          };
+        };
+      };
+    };
+
--
2.34.1



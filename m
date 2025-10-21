Return-Path: <linux-kernel+bounces-862181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA818BF49E6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC37467042
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3101D516C;
	Tue, 21 Oct 2025 05:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8f9nX4z"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6343549620
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761023335; cv=none; b=mz7lv4hlO38GKxMrQLmLbd00XR/CRnqtoiAbEDb6ILUAMVunK2ErcQ08CO8a8BK/OYVJgeUUOjaLfrQnhBFWQPU85bEiZ0XtFAETfswQGyWOKdiVa2vUiY2t5xDZDwGySsy9TkFHqCOJd5qJbd4IpsJC3boq5KqM3gnMbofLFdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761023335; c=relaxed/simple;
	bh=+PZcenhsC/YIxfCu9W6rzvPwNrrzzVq9GUJWq12ONQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fvpKN5ql3j2ywLdSuAuuEoeXR7Pz3MyTkcgXVCG00vsTjwF1lrQBCG9yV/KmYZxsUhkmWV7rz9C6owclwy4fAYsUJb6z4lyeX/t/XKeUxl051KmohG2S5B/bFE849zJNKRW9Mis47dol2khybLywQqlTepujYXMOQ3X4Ce3zG0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8f9nX4z; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso4570576b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 22:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761023333; x=1761628133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4JoIaRMTRfosYpkNP3ghrjfuvk4jOVyjyykWDE/7NA=;
        b=W8f9nX4zdPDHXMmp5RpOQO5fZswouFc7D8i6Xe4nbzmYPLxwSj/AVlzYn2d0FSBjbo
         8QIVeFLkJmWbFSEFaWVRFuDTWMFoBh8CJdJ+0kG+3E+T2yIjmYgp9BKuSibmO03JhP4d
         Y9w4oidYSr0IkRZMESLdmuUZLN0sodkVpuiORPrRE/AEBSPGh3cfkCBArtXsEUdb25hW
         13U3exL+joosIZ5KRxru3togcgNKCL4vB1x1NXu8g8CcS60f5b1qGXWAIS4OPWnxfENd
         QlDD/bmx5IbYChUhCQGar18PQ6TJWBcgB+QLqGgdrrXQUWBdCJqy3K2X3gQ1Gs/IYvcf
         hCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761023333; x=1761628133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4JoIaRMTRfosYpkNP3ghrjfuvk4jOVyjyykWDE/7NA=;
        b=AEizsbFYjdM6V0YlJ6MqSq5aD4JXJMZb7+0MxrdHflhJtE1Xo1BKtdjV2/Z4c77by6
         nwx5jJoIaeC04E+pVVCIHjl474UsnbIzRupo30M1Es+KYpmxVCFjh53a2OP8LF4tN0U2
         QdFwTCq0YTH/eKr+Hw+MtiNO0cthjbGqrl+NHyH4HZ4hAaUbVvK8CxwZ80nqMxBtAm2Y
         jOabkTmNGkR19FuEKPQ4al5oHTEZw1RWvmPdtiklMW4eo3+SLM2PJDyqokvOG0pO7aT7
         c7YXeyPyPYzx00iVawcOwnpQQ7lat/gC8RrmO165YgcfDFf7EeJr8+oBfCDvlGCRhAUX
         ulYw==
X-Forwarded-Encrypted: i=1; AJvYcCVIU39s7PLFVUIvqbguRbdFIro/ncBtQCDo3w8rVItmmXAvgT6Bfq9ey5RHiaMmmEYStDgcNaqAIeis2Mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtE6DQ+47P3Cju0jmTjnI5VKjKXwdL+dLPGraSc+C+8v9SbrUX
	AtiwCq9cQLHKAhbkr20fjzCPsdS490KGKzzMWuAHDDomdtxWbE3LarF1
X-Gm-Gg: ASbGncvbaMCFHugWCZb3RyK4ylzO5kxgRzy3oH/jaz2QgHOURTRXnqkheuO67GFhsDj
	uyjUL4G2wm/53X0IKMzr77CZT7b56oouwXQQl7nZzrX7cMZmUr7olRMjBWOlNvI2kNOjNV8l9bT
	WwHp5jBGzuF9aPaWLcx7SddHs1W8AdUIJpRq1j7OfCJH7eP1ZWS3inLNHE9OF1eX2UxdCPCe2ry
	elDpOLPKO4/vpLqyg0L9yr5E+U4ZoqZUwgFQwl/REjLLLmGhQ4waAnC6LsoMsGo8ASGN+DApysG
	0viaSJuNS0Joq8L/Gy6k1ZDBJXgvsqCIVU5PqL2zchweztwCm5COs1RdzWQhJgHERyMNy9vAAEG
	niicrfju4tihdXg57/xxdF7fQAH0Q5qlERPonV8lRQ2qY7ZhO7Zb2kJSPvztEKpBypDnZ/QwoZi
	OK81F2HSlqsNizjRFtdulWSZpVxIxh5w==
X-Google-Smtp-Source: AGHT+IE1bEtUeBWZIbvd7m0Ci0KSKMVV56eR2vHGAmY02gXSGhznewk6zVtCen7lKi+TVGpZvLQgTg==
X-Received: by 2002:a05:6a20:918a:b0:32b:71e9:81ae with SMTP id adf61e73a8af0-334a850dcc4mr19966228637.8.1761023332481;
        Mon, 20 Oct 2025 22:08:52 -0700 (PDT)
Received: from HYB-iPCgmhaB8Cy.ad.analog.com ([59.9.235.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2300f254esm10113015b3a.45.2025.10.20.22.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 22:08:52 -0700 (PDT)
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
Subject: [PATCH v4 1/2] dt-bindings: regulator: Add MAX77675 regulator binding
Date: Tue, 21 Oct 2025 14:08:29 +0900
Message-Id: <20251021050830.185626-2-joan.na@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251021050830.185626-1-joan.na@analog.com>
References: <20251021050830.185626-1-joan.na@analog.com>
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
 .../bindings/regulator/maxim,max77675.yaml    | 195 ++++++++++++++++++
 1 file changed, 195 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77675.yaml

diff --git a/Documentation/devicetree/bindings/regulator/maxim,max77675.yaml b/Documentation/devicetree/bindings/regulator/maxim,max77675.yaml
new file mode 100644
index 000000000000..0ec0844b6d64
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/maxim,max77675.yaml
@@ -0,0 +1,195 @@
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
+      The debounce time set by 'maxim,en-debounce-time-us' applies to
+      both push-button and slide-switch modes.
+      "push-button"  - A long press triggers power-on or power-down
+      "slide-switch" - Low level powers on, high level powers down
+      "logic"        - Low level powers on, high level powers down (no debounce time)
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [push-button, slide-switch, logic]
+    default: slide-switch
+
+  maxim,voltage-change-latency-us:
+    description: |
+      Specifies the delay (in microseconds) between an output voltage change request
+      and the start of the SBB voltage ramp.
+      Use 10us for low-latency or 100us for high-latency (default).
+    enum: [10, 100]
+    default: 100
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
+    enum: [max, high, low, min]
+    default: max
+
+  maxim,dvs-slew-rate-mv-per-us:
+    description: |
+      Dynamic rising slew rate for output voltage transitions, in mV/μs.
+      This setting is only used when 'maxim,fixed-slew-rate' is not present.
+    enum: [5, 10]
+    default: 5
+
+  maxim,en-debounce-time-us:
+    description: Debounce time for the enable pin, in microseconds
+    enum: [100, 30000]
+    default: 100
+
+  maxim,manual-reset-time-sec:
+    description: Manual reset time in seconds
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
+        properties:
+          maxim,fps-slot:
+            description: |
+              FPS (Flexible Power Sequencer) slot selection.
+              The Flexible Power Sequencer allows resources to power up under hardware or software control
+              Additionally, each resource can power up independently or among a group of other regulators
+              with adjustable power-up and power-down slots.
+              This device's regulators provide an additional property to configure the FPS parameters,
+              allowing each regulator to be assigned to an FPS slot for proper power management control.
+              "slot0"   - Assign to FPS Slot 0
+              "slot1"   - Assign to FPS Slot 1
+              "slot2"   - Assign to FPS Slot 2
+              "slot3"   - Assign to FPS Slot 3
+              "default" - Use the default FPS slot value stored in OTP and read from the register
+            $ref: /schemas/types.yaml#/definitions/string
+            enum: [slot0, slot1, slot2, slot3, default]
+            default: default
+
+          maxim,fixed-slew-rate:
+            type: boolean
+            description: |
+              Use fixed slew rate of 2 mV/μs for output voltage transitions.
+              When this property is present, the device uses a constant 2 mV/μs slew rate
+              and ignores any dynamic slew rate configuration.
+              When absent, the device uses the dynamic slew rate specified
+              by 'maxim,dvs-slew-rate-mv-per-us'
+            default: true
+
+        unevaluatedProperties: false
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
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      max77675: pmic@44 {
+        compatible = "maxim,max77675";
+        reg = <0x44>;
+
+        maxim,en-mode = "slide-switch";
+        maxim,voltage-change-latency-us = <100>;
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
+            maxim,fixed-slew-rate;
+          };
+
+          sbb1: sbb1 {
+            regulator-name = "sbb1";
+            regulator-min-microvolt = <500000>;
+            regulator-max-microvolt = <5500000>;
+            maxim,fps-slot = "default";
+            maxim,fixed-slew-rate;
+          };
+
+          sbb2: sbb2 {
+            regulator-name = "sbb2";
+            regulator-min-microvolt = <500000>;
+            regulator-max-microvolt = <5500000>;
+            maxim,fps-slot = "default";
+            maxim,fixed-slew-rate;
+          };
+
+          sbb3: sbb3 {
+            regulator-name = "sbb3";
+            regulator-min-microvolt = <500000>;
+            regulator-max-microvolt = <5500000>;
+            maxim,fps-slot = "default";
+            maxim,fixed-slew-rate;
+          };
+        };
+      };
+    };
+
--
2.34.1



Return-Path: <linux-kernel+bounces-895174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1C4C4D21B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81A9C189F2E7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D193D34F468;
	Tue, 11 Nov 2025 10:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLVPssYf"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788F434F461
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762857775; cv=none; b=B5mCyxYQp+nCD0v9obvr7NTeESf3KNoyUUq5YqTDgDzuXFXp/kSDUBju75LsOzmQ4bMXmcCdULCSkgEYPq41O9yHrGJmKa+LZ92gkOjmU1sCVtwpNmW63TIqMTbyUDWarSHzz2vQ5mNvqVvgp+p8hquLLQzxJx5WIDqhYJmVJnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762857775; c=relaxed/simple;
	bh=07HBWmrT/H7zno+mG0Fc4iUEDkZr7DmZa2LvkHNFOQU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hSJ0kv+xuvDot+TlXSkI5tYk8metC7zcaN31chOxtgD7MO5Ertsaxe2zsMMFdJ9+q3dNV/ZeHh3W1WJdtGHksaEyg9FdCfmarUshHpiAIevYE9cG7YzNda0VspFgJ6skf4MoBPyYPX/rO4kNAc1f5Mr51ELWItgkkfJ5PGbWnjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLVPssYf; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-297f35be2ffso34285825ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762857773; x=1763462573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fYUsDbsuuzTOSOtHBw8aAUbI3zAG5zqYtHfT8rBYa7k=;
        b=HLVPssYftnHHNoapg3S2CqXrYMBkcu5mTq50K2WuFegHFT782sdFkBgXDclUscFsEB
         FVm8iLMyj4O+navQXXvrXBFtUJ23yXKkPZxc+9aPFXYIv5yoJcBAMj5H+v+Iyrk2y0hL
         /qSUdKroU9dP3tFuq4Mxm95FgMp/RF1VaqgRDSITHREpA1c/K5ptW6ZDKFhdgxpV11n4
         OXCc/sgrI071IkdjBTplSWL5z+VuSLUmnuuxBEGieNWrVHT0cSijpUERXHBlEC8/CTJ/
         XgTEj8OujyGezYSCfYM41EktMdo7PzOi4Nf7PekP3c++X7Ms5dziSdqyKEMS7SVqhSrN
         ITPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762857773; x=1763462573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYUsDbsuuzTOSOtHBw8aAUbI3zAG5zqYtHfT8rBYa7k=;
        b=Nzd23okMxr6euz4wOuJQ1ootejmIF0h0ZGTyx1MNUwRn9CJKDHOJ50Oe8JYC871veu
         7bEvTTnmCj3GXclKL3bz+iJB+bd4ZoL0hozz43sPCGMK5jdDql0yPU0+VEpjIpGSLrcf
         4lsseN4IS5fpj/+dFAjTBYLM/VB4xxUfMGEPOmS0NJnzIwdIu58zy1RjzPdOWFmdDKN4
         O1+RRTAxxQhDTmlaNGkfGBy/snb7cQ5Po+LImBDGeZ8lm8BU/uE/1HWtctlUQLqgy7q/
         BtyVZve2qBP8b5R8wqcKCs8qd15L3JEePS6ydxEJmxRgWcXJPfPSVHCgVfYVLqQIn4FA
         Fh1w==
X-Forwarded-Encrypted: i=1; AJvYcCUE+aIHJ3r+wg5IU0NkPAWaX47OxaxN2jOcQysgD0sWurDwyVYl7DNC/Z371o0VGJLK03fMcZJ6ys/SGFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzaKmq6+QqIYgclC0UZnMNnrFkm03OuEGzoyZ5rqnNCPegzbQT
	Gyb7jvzC7qIFkKra2EjCXacaKbfBVkl5Lj1whhQjLm8ATm1Do7sdWPzE
X-Gm-Gg: ASbGncvIpjW0lrxi+/fHSxfy6zRX/Eb3PTapU4NkDkKMgHIGa1Cd8Q2m5BMOcub1A8f
	kVCXDmR/DqdbkSymSy7gA/fORvDHXvWKapvOoGSWIPC46va5v94OVHDMOn2oylEt2L457gApcX5
	NNcbBKwfAh/DROKSA8LOAtxgf44LIpbfXBA7oZ93wTKCoj8e8l0w0jZXvkR8bJIkZoCcVemhojd
	C4PlPq3JImJDSH0PACcKCfUeOboxEM7a/iMl6MuzpFlDbf5goEyV4shJUoHsYCLYhqUYqqRwVZk
	bQFGFYFmWHx8hSiqwM0ofn81XWJPsCbCmhQ8weJfnrH0ZuPRYd493Rjhy9D/l/O+Ld5kyPz4SAn
	YZg1A3/auYlQMsAHPzPZ/CQZlhVC6ODONkR1cSA2AsIrN9+L6FQLzyqpWGm3lt2hxbT6fAoxGSm
	bfnUUFyPoV0hTRZeHlcm8bFBsYFg==
X-Google-Smtp-Source: AGHT+IHKKW8uq/mixyYVwcE/GpKbjkb15Z3bYzo5IdPyn+w9o2ptPT8ipRXj2MXgq6Fk0DjaNvvO6g==
X-Received: by 2002:a17:902:e78f:b0:28d:18d3:46ca with SMTP id d9443c01a7336-297e56df08emr157512625ad.49.1762857772692;
        Tue, 11 Nov 2025 02:42:52 -0800 (PST)
Received: from test-HP-Desktop-Pro-G3.. ([103.218.174.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29846334db5sm9875235ad.32.2025.11.11.02.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 02:42:52 -0800 (PST)
From: Sudarshan Shetty <tessolveupstream@gmail.com>
To: andersson@kernel.org,
	konradybcio@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudarshan Shetty <tessolveupstream@gmail.com>
Subject: [PATCH v1 1/2] dt-bindings: arm: qcom: Add waveshare MIPI-DSI panels support
Date: Tue, 11 Nov 2025 16:12:44 +0530
Message-Id: <20251111104245.3420041-1-tessolveupstream@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device tree bindings for Waveshare MIPI-DSI panels
of various sizes (5.0, 5.5, 7.0, 8.0, and 10.1).
These panels require proper power sequencing via an external
regulator and a backlight node for brightness control.

Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
---
 .../display/panel/waveshare,dsi-panel.yaml    | 84 +++++++++++++++++++
 ...waveshare,touchscreen-panel-regulator.yaml | 72 ++++++++++++++++
 2 files changed, 156 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/waveshare,dsi-panel.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/waveshare,touchscreen-panel-regulator.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/waveshare,dsi-panel.yaml b/Documentation/devicetree/bindings/display/panel/waveshare,dsi-panel.yaml
new file mode 100644
index 000000000000..a42ce065124f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/waveshare,dsi-panel.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/waveshare,dsi-panel.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Waveshare 10.1" DSI Touch Display Panel
+
+maintainers:
+  - Sudarshan Shetty <tessolveupstream@gmail.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - waveshare,12.3-dsi-touch-a,4lane
+      - waveshare,10.1-dsi-touch-a
+      - waveshare,10.1-dsi-touch-a-4lane
+      - waveshare,10.1-dsi-touch-b
+      - waveshare,10.1-dsi-touch-b,4lane
+      - waveshare,9.0-dsi-touch-b
+      - waveshare,9.0-dsi-touch-b,4lane
+      - waveshare,8.8-dsi-touch-a
+      - waveshare,8.0-dsi-touch-a
+      - waveshare,8.0-dsi-touch-a-4lane
+      - waveshare,7.0-dsi-touch-a
+      - waveshare,7.0-dsi-touch-b
+      - waveshare,5.5-dsi-touch-a
+      - waveshare,5.0-dsi-touch-a
+      - waveshare,4.0-dsi-touch-c
+      - waveshare,3.4-dsi-touch-c
+
+  reg:
+    description: DSI virtual channel
+    maxItems: 1
+
+  vdd-supply:
+    description: Power supply regulator for the panel
+
+  reset-gpios:
+    maxItems: 1
+    description: GPIO to control panel reset
+
+  enable-gpios:
+    maxItems: 1
+    description: GPIO to control panel power enable
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - reset-gpios
+  - enable-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi@ae94000 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@1 {
+            compatible = "waveshare,10.1-dsi-touch-a";
+            reg = <1>;
+            vdd-supply = <&vreg_l11a>;
+            reset-gpios = <&display_mcu 1 GPIO_ACTIVE_HIGH>;
+            enable-gpios = <&display_mcu 2 GPIO_ACTIVE_HIGH>;
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&mdss_dsi0_out>;
+                };
+            };
+        };
+    };
+
+    mdss_dsi0_out: endpoint {
+        remote-endpoint = <&panel_in>;
+    };
diff --git a/Documentation/devicetree/bindings/regulator/waveshare,touchscreen-panel-regulator.yaml b/Documentation/devicetree/bindings/regulator/waveshare,touchscreen-panel-regulator.yaml
new file mode 100644
index 000000000000..be81be5d2d74
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/waveshare,touchscreen-panel-regulator.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/waveshare,touchscreen-panel-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Waveshare Touchscreen Panel Regulator
+
+maintainers:
+  - Sudarshan Shetty <tessolveupstream@gmail.com>
+
+description: |
+  Regulator driver for Waveshare touchscreen display units.
+  This regulator enables and disables panel power and provides
+  backlight control over I2C.
+
+properties:
+  compatible:
+    const: waveshare,touchscreen-panel-regulator
+
+  reg:
+    maxItems: 1
+    description: I2C address of the regulator device
+
+  vin-supply:
+    description: Input supply regulator for the panel
+
+  enable-gpios:
+    maxItems: 1
+    description: GPIO to enable/disable regulator
+
+required:
+  - compatible
+  - reg
+  - vin-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    /dts-v1/;
+    /plugin/;
+
+    / {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        gpio: gpio-controller {
+            compatible = "test,gpio";
+            #gpio-cells = <2>;
+        };
+
+        vdd_3v3: regulator {
+            compatible = "regulator-fixed";
+            regulator-name = "vdd_3v3";
+            regulator-min-microvolt = <3300000>;
+            regulator-max-microvolt = <3300000>;
+        };
+
+        i2c@980000 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            compatible = "test,i2c";
+
+            panel-regulator@3c {
+                compatible = "waveshare,touchscreen-panel-regulator";
+                reg = <0x3c>;
+                vin-supply = <&vdd_3v3>;
+                enable-gpios = <&gpio 2 0>; /* active high */
+            };
+        };
+    };
-- 
2.34.1



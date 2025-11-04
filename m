Return-Path: <linux-kernel+bounces-884713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 430C8C30E0B
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 272C04F244A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7202F2613;
	Tue,  4 Nov 2025 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4tym+YM"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E124A2EDD50
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 12:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762257842; cv=none; b=M438rq4Mgbz7SQ9wCs7tOis4+PgPu+3TPR8MC9czhOub3cw49mRut2ZmkMstsc4J0GwoZwMr3MoyrHMFVdhs9XcPRBHgLdg4/OW9x0nOgPTviP8ODMME6G/517MawJjewcydzCK6sMsDWtPNdt+Oo9bieTD6Q8KbfXLTIBtnql8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762257842; c=relaxed/simple;
	bh=NlDVT84FRw/2mXN8rUhepff7GU8/kbx+go4sEcGg10w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XqkVm4Q8+ks/LMFMmR90/LJ9toeqm1/HvWHvhaXa/M8wDxL2BMgf8lhV6glQHOsdGgYUkQ/w5ObDyy5rW2B2Z70LWpMdZ4SP5i03o6zZJAEzaZO71S8xR7C4Bx3VgzDBjHkhm9pVPaSTC+/m2O6pxIPUuTQGfPncbNpduP0GdCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4tym+YM; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b50206773adso1117274566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 04:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762257839; x=1762862639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63ONXHD7xxtFJR0GpIWYvdgt2ZZqq/c+9blnPN26amc=;
        b=j4tym+YMaMVI0fvKjlzUx7nGZO4a8F0DoJiFo2AYKMNICwV2ASjOtbStnFEu9bdw7I
         LuO0/k5R3c7PK8zwNjzu+gW4RoPvdSi8zo2zGSHkcTWrNVu2v4PyvmkIPIyH6tXpGOXC
         NqmbozvL/vpLq9aSJZZa7nvc9Rywwf+ZgV4QqVpfWQb/P85af0CwiIbzWCxJpUEpdrRL
         DcX8xEUiN7oe7JDxXFXsKZ2t6cQzM3oi31rSjL61ve9KBycGcwchOI9tptxqp1NHfqGl
         UE5FRf+/8q5f0sbt7cC1SRVEhqphAZT4RAAWpBT5F2ZoxWR0C5CR+miSv17mPxFYvBnf
         SPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762257839; x=1762862639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63ONXHD7xxtFJR0GpIWYvdgt2ZZqq/c+9blnPN26amc=;
        b=DZ+tOCLKoy7fICyD8S73VRpmFPowPX32rcxelKg5xT9PMJewyfmKx3ndMgQqrko3u1
         rh0sTyo9fF5wwsr4A5XCKxnjXRKs2esyNtVpMTL5Ne8BPVoYs4ACGJiaHy5fOOVn2TNb
         r+VdAASuW8NG3kRRdxHEMqEPEpEv3HBs3+mI9iEjMKK5r+VQ8ykvahOT0Fpxqa2dW7Q0
         2yod62aX5HiqzByX8+A93FuuJ2HkL3fQ1xMS9kMWcZ1jhdE0RMUf6LmLjvGWL3T1xrJI
         II1S+1PoRJbKEsk2dB/LbGHZ9Gb90zw+3Xr1IK+rTnhhK6nnH0KIul4n4D4LvtcqepiZ
         lziw==
X-Forwarded-Encrypted: i=1; AJvYcCVOWjaxSCW7lsht5S7ZdAdSTdZjbpjvQfC4PZ124jLqJ+tkWBeY1zEi+xXwuKFgITw8yUQ5xREP0n0CmKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCwsQcmz9XnyHjxzBK3dWsDvROXr4JQLolqCMwYbWyvGIFlhcJ
	qpNpoGVlYHvBwJHVCQOzBLEM12R72yTsHsfNvKcCfWpNTKhFGsrmupfY
X-Gm-Gg: ASbGncv2gmyLut+5up80hGpuwU3IkUzbbypJYZANGGWcdFS+7uZxqjq9CReTnziXltT
	Ot6d+KkjCJ2vWo83FP0diJBKRoEIlYtU0nwXnc1Wq9sQ/yJj4s+VRKosDNx67WeAGAf5m6OTFqc
	/6FKO9wXoGOXOFI5+/Yx9eiBFRVzFquR4+Y/fVwg2ICk5KXl9ZxnPi0FFK3gfztGllM3DaLGe76
	aJr/8Ld+HFkGbEYHpU3IJu5yo+sSRPGw83FjZmEvYAx6s9BLWFmgcYM8OqzhaB2Q3sNopID9dNX
	fd05XOfDcFRqSsRJOrF7WzfSIYC/0NTp0VIbE4cJXLB1S9KSbRVuG4jGxEAh4rgSpYWBUH7TVps
	1PeP8bvHCWOikMoE4NRPnA/W/2lXYBi6BkFpQFxjUOcOhoyKVJGZbtP29j2Spe9ba5Sjruh5NTv
	BrOhp2/v25HvLLs2Ty2m/efHLsHg==
X-Google-Smtp-Source: AGHT+IG3QLmyCjtX5/Ko9tQsUxnNB5wR4XCiP6erukrj/bGwetEYdDQuHsOKUbEeVB4dKQgbNrFB5Q==
X-Received: by 2002:a17:907:72ce:b0:b6d:263c:22e1 with SMTP id a640c23a62f3a-b7217d7eb1dmr363856066b.31.1762257839139;
        Tue, 04 Nov 2025 04:03:59 -0800 (PST)
Received: from SMW024614.wbi.nxp.com ([128.77.115.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fa038e0sm200894166b.54.2025.11.04.04.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:03:58 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Cc: linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v4 2/8] dt-bindings: clock: document 8ULP's SIM LPAV
Date: Tue,  4 Nov 2025 04:02:55 -0800
Message-ID: <20251104120301.913-3-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104120301.913-1-laurentiumihalcea111@gmail.com>
References: <20251104120301.913-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Add documentation for i.MX8ULP's SIM LPAV module.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 .../bindings/clock/fsl,imx8ulp-sim-lpav.yaml  | 72 +++++++++++++++++++
 include/dt-bindings/clock/imx8ulp-clock.h     |  5 ++
 .../dt-bindings/reset/fsl,imx8ulp-sim-lpav.h  | 16 +++++
 3 files changed, 93 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx8ulp-sim-lpav.yaml
 create mode 100644 include/dt-bindings/reset/fsl,imx8ulp-sim-lpav.h

diff --git a/Documentation/devicetree/bindings/clock/fsl,imx8ulp-sim-lpav.yaml b/Documentation/devicetree/bindings/clock/fsl,imx8ulp-sim-lpav.yaml
new file mode 100644
index 000000000000..662e07528d76
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fsl,imx8ulp-sim-lpav.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/fsl,imx8ulp-sim-lpav.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX8ULP LPAV System Integration Module (SIM)
+
+maintainers:
+  - Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
+
+description:
+  The i.MX8ULP LPAV subsystem contains a block control module known as
+  SIM LPAV, which offers functionalities such as clock gating or reset
+  line assertion/de-assertion.
+
+properties:
+  compatible:
+    const: fsl,imx8ulp-sim-lpav
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: bus
+      - const: core
+      - const: plat
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+  mux-controller:
+    $ref: /schemas/mux/reg-mux.yaml#
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+  - '#reset-cells'
+  - mux-controller
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8ulp-clock.h>
+
+    clock-controller@2da50000 {
+        compatible = "fsl,imx8ulp-sim-lpav";
+        reg = <0x2da50000 0x10000>;
+        clocks = <&cgc2 IMX8ULP_CLK_LPAV_BUS_DIV>,
+                 <&cgc2 IMX8ULP_CLK_HIFI_DIVCORE>,
+                 <&cgc2 IMX8ULP_CLK_HIFI_DIVPLAT>;
+        clock-names = "bus", "core", "plat";
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+
+        mux-controller {
+            compatible = "reg-mux";
+            #mux-control-cells = <1>;
+            mux-reg-masks = <0x8 0x00000200>;
+        };
+    };
diff --git a/include/dt-bindings/clock/imx8ulp-clock.h b/include/dt-bindings/clock/imx8ulp-clock.h
index 827404fadf5c..c62d84d093a9 100644
--- a/include/dt-bindings/clock/imx8ulp-clock.h
+++ b/include/dt-bindings/clock/imx8ulp-clock.h
@@ -255,4 +255,9 @@
 
 #define IMX8ULP_CLK_PCC5_END		56
 
+/* LPAV SIM */
+#define IMX8ULP_CLK_SIM_LPAV_HIFI_CORE		0
+#define IMX8ULP_CLK_SIM_LPAV_HIFI_PBCLK		1
+#define IMX8ULP_CLK_SIM_LPAV_HIFI_PLAT		2
+
 #endif
diff --git a/include/dt-bindings/reset/fsl,imx8ulp-sim-lpav.h b/include/dt-bindings/reset/fsl,imx8ulp-sim-lpav.h
new file mode 100644
index 000000000000..adf95bb26d21
--- /dev/null
+++ b/include/dt-bindings/reset/fsl,imx8ulp-sim-lpav.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef DT_BINDING_RESET_IMX8ULP_SIM_LPAV_H
+#define DT_BINDING_RESET_IMX8ULP_SIM_LPAV_H
+
+#define IMX8ULP_SIM_LPAV_HIFI4_DSP_DBG_RST	0
+#define IMX8ULP_SIM_LPAV_HIFI4_DSP_RST		1
+#define IMX8ULP_SIM_LPAV_HIFI4_DSP_STALL	2
+#define IMX8ULP_SIM_LPAV_DSI_RST_BYTE_N		3
+#define IMX8ULP_SIM_LPAV_DSI_RST_ESC_N		4
+#define IMX8ULP_SIM_LPAV_DSI_RST_DPI_N		5
+
+#endif /* DT_BINDING_RESET_IMX8ULP_SIM_LPAV_H */
-- 
2.43.0



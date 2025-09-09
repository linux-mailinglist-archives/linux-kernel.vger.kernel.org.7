Return-Path: <linux-kernel+bounces-807403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5201B4A3FA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 751D3440EE8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE74309F16;
	Tue,  9 Sep 2025 07:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oa6wtvaH"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62753090CD;
	Tue,  9 Sep 2025 07:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757403527; cv=none; b=DUkGtlF1iMEqZXUsIIzXNpA0vru4Hq6I236zo5+lqIrjUgx9K4XfD5o69RFUTMPxaWhmvwXdiCTqwPqTDsWUaPjz5MeKqZb1DRDXKVZ2XlvRL+mXszui9s0MwCTO96xTDYNxG4A+v9OR8jJgLGjHvJEfE4hIdteWzh81heIUhiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757403527; c=relaxed/simple;
	bh=iTt7xqD3l84dwxyJM7RcMs1SC6szftVZRQU/JLL31+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TW04tYnLp0RC8bM4eEDH4Xx+RbJ8XWePFbkIgnVE+6H0jW4Iuibo7pGntn94RdrXpr1lfSC5U0fz4wOQjdIx9/9dH7vHu7NgViRg6WqBt9fF4m0W4GKCa6715YgDHsp44J/cs4vsotCV3MMTz0skEND0W1B9gR32qWpRzZubr9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oa6wtvaH; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55f7b6e4145so2683887e87.1;
        Tue, 09 Sep 2025 00:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757403524; x=1758008324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3lfcXfQwIS1q2h0Snb3/3x5fJy2fTu1tfuelexkpbAQ=;
        b=Oa6wtvaHgXrpCesxnhfjNA++29yLsLrm+BRHPBsFgkcFTmxx5ifJfzfgvzjT+S+5JP
         650Wyind3EppN98F0bpfkgRx2XJHdErvOns4P/ylMaAidb4yAHHP5yiaAgWN8IJVcfJ7
         aMbW506VouF23SEvxvLs/eJeCj/MlLef44ZCJm1fBABKuJhXoroMZQTTi6Gj5XmrsOOC
         h90sary5+gZbHkqLoli4bVwNafRwbpuNQdHFllV2vHBEpG6Y0GU6DYi9yrCIjibPHRxu
         J1HjEF+9KfqSAIDR00cdU5ZpdFa60chs2useRbmNU027AFJMNcYQN8hrmRGFkC66phkS
         JCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757403524; x=1758008324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3lfcXfQwIS1q2h0Snb3/3x5fJy2fTu1tfuelexkpbAQ=;
        b=CVok/wbBtgrZA0waquswuN5Rm2t9BVkfu1j6T8Szcfjqh1/TMdOM4vn58hktpuC/4h
         XID2GOC2MoGvHNhfqJRt4NMxLFT1OjYBUjEJh3uO4zLWVb5bzSul2WYe5GimFhj/oP1v
         puvt3rmhhmqBYxyuX+MWi48Lk1nAqk23IHlp6ZwzRLezDCYBIKki4wh2LfoX4bq9aulE
         KAvEpR4oWByrxDpCsaRPVE53RdnxlWEej6p3f84Qbg0hCFVlxJW91Gp6FKHG+xe/y548
         mOPVf/Y/2ijysaanEMKD/t2EGtuBqjYXBdxJjs0agZPkzNytcDdwlJqx5DJzTM7uRrTD
         dEwg==
X-Forwarded-Encrypted: i=1; AJvYcCWgXDU0Z0JEj54923SqzPYJipXrfnr/DTGdBgzK4xMNvsgyADftVAZuJOtT4r92SgLxS4pm3+MH8IRcoEiB@vger.kernel.org, AJvYcCX7ZOtdLuXlRR7YgaJ3Vz62qCF8lMhvPuGXf89xAb6kD8YmUiPSvGnPM/smrjU5KYGH/4OUZ0boW2dT@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7xEyUJn1I873m32/fXv1vCIr9dgkdtJtYdOtDb5onsvr5umUj
	ABpzW0E9dW8VTLbqvUsA9hWBoSZWYfsz5jkHTyQGHB5Cy+UK+c3hqxPP
X-Gm-Gg: ASbGncsTdAe09Dt31RliTwTk8/apjT6MZ8qQ76EZyMnxFuMvWiiG3pxTmdcg+BW+hN6
	7EALEBI28/NEj49y3usAJPGzCMYkH7f5AR9jcjM6KnY+0qpx0XGkVokC9NPeIiVEAKVivn/8g1o
	deZS6QrEoi5/2a8mxB1f1cPBNqmWgc3acy7ZP55XzkN+S387LHIapL2QLL3UXtVtlq9Njo2ZpKM
	pg378BipKYVoZy0mvNf4X0WBFu/A1vLCYmvfeqFW6CpsyBZGq++YlSv3zXGHvgp6J8e+n8VF/J2
	z5e1rctmIwORxZl8+9NbxCDskhqP9sBcCn9N5pGDJcnbOfJU8uPjQQ47gNR4gKODEFOEM20bWQa
	gYDiYbQr+KZ7+vw==
X-Google-Smtp-Source: AGHT+IEaVfapd5iBYsDenlEZ5XVTtYiiiy3FO4SXIJNtmFVMalV0u1BpsRCN0qcks6PSEkDajV97zA==
X-Received: by 2002:a05:6512:3d27:b0:55f:4efe:42d0 with SMTP id 2adb3069b0e04-56264167ac9mr2795515e87.41.1757403522236;
        Tue, 09 Sep 2025 00:38:42 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5680cfe2496sm342580e87.61.2025.09.09.00.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 00:38:41 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: display: panel: document Sharp LQ079L1SX01 panel
Date: Tue,  9 Sep 2025 10:38:30 +0300
Message-ID: <20250909073831.91881-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250909073831.91881-1-clamor95@gmail.com>
References: <20250909073831.91881-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Sharp LQ079L1SX01 panel found in Xiaomi Mi Pad.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../display/panel/sharp,lq079l1sx01.yaml      | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/sharp,lq079l1sx01.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/sharp,lq079l1sx01.yaml b/Documentation/devicetree/bindings/display/panel/sharp,lq079l1sx01.yaml
new file mode 100644
index 000000000000..1dbb4a4bb772
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/sharp,lq079l1sx01.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/sharp,lq079l1sx01.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sharp Microelectronics 7.9" WQXGA TFT LCD panel
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+description:
+  This panel requires a dual-channel DSI host to operate and it supports
+  only left-right split mode, where each channel drives the left or right
+  half of the screen and only video mode.
+
+  Each of the DSI channels controls a separate DSI peripheral.
+  The peripheral driven by the first link (DSI-LINK1), left one, is
+  considered the primary peripheral and controls the device.
+
+allOf:
+  - $ref: panel-common-dual.yaml#
+
+properties:
+  compatible:
+    const: sharp,lq079l1sx01
+
+  reg:
+    maxItems: 1
+
+  avdd-supply:
+    description: regulator that supplies the analog voltage
+
+  vddio-supply:
+    description: regulator that supplies the I/O voltage
+
+  vsp-supply:
+    description: positive boost supply regulator
+
+  vsn-supply:
+    description: negative boost supply regulator
+
+  reset-gpios:
+    maxItems: 1
+
+  backlight: true
+  ports: true
+
+required:
+  - compatible
+  - reg
+  - avdd-supply
+  - vddio-supply
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "sharp,lq079l1sx01";
+            reg = <0>;
+
+            reset-gpios = <&gpio 59 GPIO_ACTIVE_LOW>;
+
+            avdd-supply = <&avdd_lcd>;
+            vddio-supply = <&vdd_lcd_io>;
+            vsp-supply = <&vsp_5v5_lcd>;
+            vsn-supply = <&vsn_5v5_lcd>;
+
+            backlight = <&backlight>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    panel_in0: endpoint {
+                        remote-endpoint = <&dsi0_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    panel_in1: endpoint {
+                        remote-endpoint = <&dsi1_out>;
+                    };
+                };
+            };
+        };
+    };
+...
-- 
2.48.1



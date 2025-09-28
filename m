Return-Path: <linux-kernel+bounces-835253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FFABA695D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 08:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4BD27AB012
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 06:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E3F29B8D9;
	Sun, 28 Sep 2025 06:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTbhWJ39"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0237261B65
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 06:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759041697; cv=none; b=tPUsnGskf8Xv1biF4m2GTzUH++hQCQSwxr0PcA+2dGnhHORVLSNY23MzFpEcXrHmJC8GsX7uwxiqKTSbDJMRdV5+ScpCVHBzLQyS9wiym4XVkPiKZbicqWBQlgUVhQtudKaGmz0ZDI6FeejqRaydDkFMInEk5kRh94U1+llozRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759041697; c=relaxed/simple;
	bh=d2bpnqRWRaKMlDXz48t/UvVbIZb30QROCUWbbeCabLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NhuqK/m/oCapXF4QDYGDqX/K20yOm2DF637nt5GaHwRGEZ5r6UF3FivAzAKn21Z27aab6lUmeqK7cbMgLLjxEUKaPtLq6ccw5yFxu3Tu0Pbexu1HwhGmzX5o/atkzC2rOp5Fp/n8mmcPtlxdJEul+C0IfhnPZteC2Y222Ms+vNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTbhWJ39; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5688ac2f39dso4214238e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 23:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759041694; x=1759646494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FnFEZ5LGZZEO2hmpfl9TQ5ygFYB1UXSn1kYbGCnXkg=;
        b=cTbhWJ39NhJVVisTFwq+NoTsKjAbQLG7IHI3L4U6WICmUgLCHr+oZJkZ9pzxjc/976
         oJkEwUhVWnq2FAdjxhOoGfN6nHj+58V8+IJsDpxwxTmgkpVwruIsYxIx/Wlr3IGyIwyE
         0KrMSNqKYbIS1kdM9WbdaKhTGhCJuXq+nw8M6GG+TcvWBCMg4iZJVdQvqSXwpKjuCK4/
         A/qGDyrMKsCXlGZp41EYa2M/hnGUbyCZr5h8+HH0jWqnSgcTLpWQfvyplHls5c1+1bYS
         GfL9L084vTpJyIe4q+5A0cSE0f9bYUjXvJ76WIKFAc/8MXF+WdMwJf9mjJGg/k/MvbGC
         h7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759041694; x=1759646494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FnFEZ5LGZZEO2hmpfl9TQ5ygFYB1UXSn1kYbGCnXkg=;
        b=un8WnkJc1XTGL1CAv/p0hB2E2E0KlqY/1RrkCaca/ol6Uy6tUD8zFruhZy2O9ord97
         wT8O2wgRPlA1ExFlkK0kw1LGiC8eACkZppP7sssvIq1nKKoAe24GtQZm+FnZzxK9BlhX
         DJ7hofTQrLWZtzvpCwxyXURF+CffbuRG7hLWvPFmKXnkg9Xyr69nXIlRD7+GB1hbGH81
         7aGcbflEd72CYx4AMFUgoEjQHEecR9mvZuIJMot8A5e/PPvv/QB6E0VHujCvrOrkR+bp
         E1AiCWFVuTGadMDruoKpeNLxIqvSlBO/PZHxYsBtha3NnwcPPujDOwSoPFJUiOmooxSO
         ENTg==
X-Forwarded-Encrypted: i=1; AJvYcCUH7NcCBfp1+nOfEC8nilRPpesZsT+fy9MRLTlCs4j7272syUf6nkJLCxUXcHy7/16tZ5XD1gZkcktqpnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS1sghf078WpbJqcG8WlwtP4p9id8vi+u2DJY0WMJ5N7Egz659
	j3Gw6nAvE1mpAbxwfYm8uxZU/SBTNBvVi8qY0KXPoiGJgNhlh6JoU8PT
X-Gm-Gg: ASbGncvNBdeWhA4ulgNaHXETikZKHRSt20k3j2LMoFA/eC10cdWr0TSDW2JU3HvPDV8
	UKL5Udvsz7mMU1nU17gLaMFR8nKLEHtG+K8IMcGFwnXCa0PHIDWp+o7lRkvg7J7iMK4qSLT24Cc
	JcF40LqSIE3LiGUR+v+Uj9a8WjGsNjtYd4jT9dXSP3s++RzG09CeAYj+dnnH0B9xCzijS6AnDfE
	71CFp+xnF7WNEZ1awuTrL/sP0zzUeIyx5cOACzVIn/2oW8uzId/0bO1DdvmXHO6ue7L1nH8T5dU
	k71UzCR4R72LZe0W4ylVG9jfya7vrqRAA3Qm8ilkAMhL63kJv/jiH68Uu4YMLQdPwOgeIJ+SMKf
	DZBJD2MD0RbZSIw==
X-Google-Smtp-Source: AGHT+IH8xZzvLuvaCAObWM3V1fA70/Df62/NH3/n/3QYa3d0xT8JD5kels0Lf74NDzkm29Ip6iNCZQ==
X-Received: by 2002:a05:6512:2c07:b0:57f:42c8:409 with SMTP id 2adb3069b0e04-582d2b4a26dmr3042147e87.39.1759041693640;
        Sat, 27 Sep 2025 23:41:33 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58600043386sm973735e87.86.2025.09.27.23.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 23:41:33 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: display: panel: document Sharp LQ079L1SX01 panel
Date: Sun, 28 Sep 2025 09:41:05 +0300
Message-ID: <20250928064106.46756-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250928064106.46756-1-clamor95@gmail.com>
References: <20250928064106.46756-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Sharp LQ079L1SX01 panel found in Xiaomi Mi Pad.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../display/panel/sharp,lq079l1sx01.yaml      | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/sharp,lq079l1sx01.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/sharp,lq079l1sx01.yaml b/Documentation/devicetree/bindings/display/panel/sharp,lq079l1sx01.yaml
new file mode 100644
index 000000000000..1a52527eb614
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/sharp,lq079l1sx01.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/sharp,lq079l1sx01.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sharp Microelectronics 7.9" QXGA TFT LCD panel
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+description: >
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
+    dsi {
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



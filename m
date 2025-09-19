Return-Path: <linux-kernel+bounces-824877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65679B8A5A2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7777016FB4F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8DA31BCA5;
	Fri, 19 Sep 2025 15:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjb4qWsr"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D0431A817
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296353; cv=none; b=L5gzKWVBTuMFzDZ7HbThmZ3YcTzCkjkNDubxoXvQWunCRAZ7QTd1msu+HKy/WJW/AoKO0dnY+iq1DaFsTPc3SYMSObA/9idOQ9hJZ2u0hpYMLVkBHCaivDnmtYM8IKQlBqxtVuQDK3kTrwViVcwpvHaO3zPxQcNXqikN2zCDDCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296353; c=relaxed/simple;
	bh=n5TYoQjReppQnj7oa4KgUh80MYaRLfcqCr2v5bD0tYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQpyjvlPxFpZutNEJB1c6+ltNxOVtsFlB3P4RilEYSJPhi+vbBnROCReEaGBL8HANTEtmugKi3pJHWnT0DYKkzSst07995ixwcHwrDigIaZphK1ru1ZI4oL3epfDbckjokfLUhBnl+OW/0O3TIltZoxI0zQ0tjLd6CSmUprm8o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjb4qWsr; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-57b35e176dbso45102e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758296349; x=1758901149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awn/8X3LVfxIDjt817H/4r9cyEH+Oe+JPiZdfgLM5TU=;
        b=gjb4qWsrNkEMkbi1V/57QV04xKWhQrrIen0IeaU3UUem7PFafa1bQuXaeaAfsv4Prt
         xYJ62LtfXgQMcrsPif2lcwEZr2XJrlF62ZoISb1S4Hq67gFEojAaFDs8AsLzDQiSqFXE
         NXIRhPPAV7ZOlBIPY7wwe+lNZveCaqfqC2qjpUUvfrromH3LTPCDo3oJ+9KKZR3OJ34D
         LKHonVoA4MOO/sS6PV5W67jqxWNVdSaaon82TqhtWhVOWJaaDtCUW8Ql1iB3pba9o+0w
         MM4Fc+RZjsD97ltvhsc9Ml4aX6h57ByAgs5jApkTdj6DXc70nfZ0OJaHzT0Iqe/4zLZq
         b5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758296349; x=1758901149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awn/8X3LVfxIDjt817H/4r9cyEH+Oe+JPiZdfgLM5TU=;
        b=X/px6C836cOFPMszDsQ+Ba5Hs+K/eLBeZrAtTI7xXXg/VHe5mwliN8yKAjqfkPsIrq
         ikWSP466ggX12n/ah8DNTS7X48DiHeZW94JfhFzUQit6sGClCdpB04olD34JCo9IQtKz
         SCZh1QI/WEJf2fZA/1t607cq/wThG324ObtKAlaA9sQi8n6QOB2EotH1h8DmjGngLZ6U
         4ChLNiQKpv8FhIzf8jI0mWTkin61fzuG6agF4RLVB0+1BKmGDVISJlE65bPYMD36SJSE
         TXPiYiGquNH3PxiQGgjRsPnTgITRSw/NVqXzqoJSUQ2bOV1U+XwxZd1eOPyPMCB4I476
         yO6g==
X-Forwarded-Encrypted: i=1; AJvYcCUDxkZykiBwHIigRSwbvzTFJJn7BN4NOr4B9+iKRTEA0we5degwN2RE6ZWxlfjk0t7lsh4jHrT2Mz5YKkM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn9hAVGV/cu8b1EW/lvqUvPt3oh7nVyYcLzmSZhL8rZe7/cn+d
	X8bHEBJdXDB4YZgmxCR2GeKZnkl6BX01CYARlBzBA5XP5NcIWTftTd9G
X-Gm-Gg: ASbGncvcRCNCbdMa/LGH1ujyi8KHzzjKJ7Uo4Fqu86ztricLV+eSJ8GOQoWOwVqrxAI
	j14lR3tJL8A6Ku7c3ZRCDPt5+8FA5FknqQr7pQLdUO3AGkoh77lfl2JUZ8E6sAUW+ebEDl46oR4
	vOTcxIChXWZZuAewY+zRNmxuaK9GTsq+c9UsjYqBR5EIvUKMJQHTQxHsoViIgfIYAJ7Dh0tZmnX
	KWZ5lTsik8fpiCLLz8slR48VhKYJCmZBpQ8XdZm4HBITOpfGoFFmMGxGy6AYvOe1JGJNBcEzesA
	N7QHnJzXXnFJOVm0/fOLZSH2jrYDvbVDYed04Ku9vNX4oS+JVdBvGjxxgGMrphNpwNix09uDYpU
	ZrX0yu0lZ8/60+g==
X-Google-Smtp-Source: AGHT+IH8Sej1anu8ff21sWNo9vQs6p9Oxp87PrlzDoeciz0OvJm22lDYOfahd8YyFL6OT7sgWgEjTQ==
X-Received: by 2002:a19:6b09:0:b0:55f:439a:dafc with SMTP id 2adb3069b0e04-579e1f4136emr878221e87.27.1758296349419;
        Fri, 19 Sep 2025 08:39:09 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a5f44771sm1485769e87.20.2025.09.19.08.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:39:08 -0700 (PDT)
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
Subject: [PATCH v3 1/2] dt-bindings: display: panel: document Sharp LQ079L1SX01 panel
Date: Fri, 19 Sep 2025 18:38:38 +0300
Message-ID: <20250919153839.236241-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250919153839.236241-1-clamor95@gmail.com>
References: <20250919153839.236241-1-clamor95@gmail.com>
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
index 000000000000..08a35ebbbb3c
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



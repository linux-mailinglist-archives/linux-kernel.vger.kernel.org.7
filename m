Return-Path: <linux-kernel+bounces-750208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07466B15899
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 07:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3195471F8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 05:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05ACF1EFFB2;
	Wed, 30 Jul 2025 05:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPwuwCM+"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9712318DB0D;
	Wed, 30 Jul 2025 05:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753854909; cv=none; b=o1iARnTdpbhVs2ch+5I286Q1gug+x3Vn1KXFXml9VkEKB7ZWHjE980TRLQxbJ+248o4p7gLHcirwoBwwbcA+RtB5M05tLeWRwnxNBEunIJESoI2sUTf04tMmyBYigfEjCkwmUad49n0vaAcatNFi6Thw/b5tACwNZlsvxSj+8BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753854909; c=relaxed/simple;
	bh=Qnk8ApjKHe7cIi2nAfJHQjcWlleZ4gTm+u7X22VKTFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0Ac8E9SGiLowiAN41ucCa0a3jXLRNQ7rrISzCCRWs0lELAV8wr1xBxGo4YQy92R9nKwrOJiyIxGXIV9w0HGG45DtjJDy/cXY7/DtEwFHSdzxsgU0QY9Arc9u342PebP/74w8p90GX5Oq+osJFBmO/YdVf3cz8aE2Q+oExdEjBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPwuwCM+; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61521cd7be2so4482820a12.3;
        Tue, 29 Jul 2025 22:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753854906; x=1754459706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhA4vB5QX4cGx67rLq/kl8NrO4ybnOcVhUciXhl2JI0=;
        b=EPwuwCM+Xi1un6S6VkHZYOvWDjMYUN2JqkZnzOMHO8Hd8URTfdAYohdndRMUP9BlXZ
         LIK3R5WkJXYmHnj/CFzQcSzcMwxDxDYIII1GwgZ6OTsyi6sMtd0N7QK5XW3yP1oSDeyt
         aKL/aW9d9d4n4D3rLFMSPjfuOTwAEMqYXHuwuh1C2Nir9FmJ4r/7NxwTmJSdVQpAOmql
         JIUM5yDAj2mHVIWaPn5aDuRGSP2E8hQZJQt8tFqD/Yt9W+682kihtGI66xFd/Qv73D64
         Bl4PvXO6EA6xiavJ/FOmwzagEDU+KqN4H2vCWTct1CrKkzUB2Scs4EBhuVhyal6cfThZ
         QmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753854906; x=1754459706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhA4vB5QX4cGx67rLq/kl8NrO4ybnOcVhUciXhl2JI0=;
        b=nQNLgI2dZX85MQLydzfe+hAPB/ec2WRZMiFaXU2U2S6zbian95ZFKNHHq4mlveriRV
         n8SrRyuQK2RmFTil2Pz9TDwk/fVw5IQtYhiVXNLYkcsxmS6ftyC+wBWnySOU9VypGlk6
         UULXTrv+aWXbxo0oB56fUjIqa6ukaKSsAFbfPNBeQmFvCUsa9h9LVG1qXv61ud8CX6E2
         33bShbVnGyRxZsgwV85C2AsEfGbOLNVRZcqO3X2rySyswkjhleRjeOfcAdXKkG+cZRUw
         J2WbZy6dgdS7+rR1MvQVrTiY+IkN/O332AR6enbLRF6vEhZwXdrGfWFHRpzPJ3jgE4xO
         P0HA==
X-Forwarded-Encrypted: i=1; AJvYcCUCpcyZa1oWCVFNrsS7ewiEDJll3RphT4s58m9YdU5dmz6RhEvYBZkmETtWx7Kkb4npvIIuREs5rKjZelxY@vger.kernel.org, AJvYcCVp6nHZgyod24VjulGj2A7w6ga6EQRheE1oLqciiihzF249jrii/O6mQRUkdoEgDvQJLU+KLy5T4uKV@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlg4bi+RSYmPvhuo/w0tMKPa6cmOuAn4AeNfsReu8ySHKVkEtN
	4Y9AGB/GnO/uBXbUrZ3lxWZRnEadIslnTpXZQzgSa5QSAlXS4FcWs2YE
X-Gm-Gg: ASbGncs8CrLVnwTzUY4Fu9izF9Yin8JBfPfgLjtEioUCME631o/RSjQruGtGFx0IUdr
	XHt2aDR77LR/7QqjjbElTPLGaGzoxXKYIBs6PsaJbbkIEtsbzyngR+e+3+PUh6380gpjXGHvjFv
	KpWSU5AqO4OAPbLvh/FjIIDrjgHkPQ8MjkXwBSBsJyUzPPStcwj6aedSodhfZ/80eOCKTxntWMg
	xlhoscuL8hwpSEUW9hRRXOZ4Kyg0p19b3BfBunXZdtIulg+vERKirjLoZH/ufS1wazMAYx0TNpZ
	ah5W0A/j9wJDTQPHlhnYErIXmipIGnGANIzQDjWroPZenaTdmF+EYoRR7KjjDqowtGBsrZ0mior
	WXhe07ljiF6onbg==
X-Google-Smtp-Source: AGHT+IFaoDmYx7cvcFkPx/FkUm8P5NpJXgi+6mJ7HG79UybIPxMPQ/yqlRtz4qcA3hnPL9FsL5zQEg==
X-Received: by 2002:a17:907:720d:b0:af1:8336:6651 with SMTP id a640c23a62f3a-af8fd91a375mr220105366b.33.1753854905672;
        Tue, 29 Jul 2025 22:55:05 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6157f2d6b94sm1014803a12.57.2025.07.29.22.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 22:55:05 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Heidelberg <david@ixit.cz>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/2 RESEND] dt-bindings: display: bridge: Document Solomon SSD2825
Date: Wed, 30 Jul 2025 08:54:23 +0300
Message-ID: <20250730055424.6718-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250730055424.6718-1-clamor95@gmail.com>
References: <20250730055424.6718-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bindings for Solomon SSD2825 MIPI master bridge chip that connects an
application processor with traditional parallel LCD interface and an LCD
driver with MIPI slave interface. The SSD2825 supports both parallel RGB
interface and serial SPI interface.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../display/bridge/solomon,ssd2825.yaml       | 141 ++++++++++++++++++
 1 file changed, 141 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/solomon,ssd2825.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/solomon,ssd2825.yaml b/Documentation/devicetree/bindings/display/bridge/solomon,ssd2825.yaml
new file mode 100644
index 000000000000..e2d293d623b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/solomon,ssd2825.yaml
@@ -0,0 +1,141 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/solomon,ssd2825.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Solomon SSD2825 RGB to MIPI-DSI bridge
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: solomon,ssd2825
+
+  reg:
+    maxItems: 1
+
+  reset-gpios: true
+
+  dvdd-supply:
+    description: Regulator for 1.2V digital power supply.
+
+  avdd-supply:
+    description: Regulator for 1.2V analog power supply.
+
+  vddio-supply:
+    description: Regulator for 1.8V IO power supply.
+
+  spi-max-frequency:
+    maximum: 1000000
+
+  spi-cpha: true
+  spi-cpol: true
+
+  clocks:
+    maxItems: 1
+    description: Reference TX_CLK used before PLL is locked.
+
+  solomon,hs-zero-delay-ns:
+    description:
+      HS zero delay period
+    minimum: 0
+    maximum: 1700
+    default: 133
+
+  solomon,hs-prep-delay-ns:
+    description:
+      HS prep delay period
+    minimum: 0
+    maximum: 1728
+    default: 40
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description:
+          Video port for RGB input
+
+        properties:
+          endpoint:
+            $ref: /schemas/graph.yaml#/$defs/endpoint-base
+            unevaluatedProperties: false
+
+            properties:
+              bus-width:
+                enum: [ 16, 18, 24 ]
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Video port for DSI output (panel or connector)
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dsi@2 {
+            compatible = "solomon,ssd2825";
+            reg = <2>;
+
+            spi-max-frequency = <1000000>;
+
+            spi-cpha;
+            spi-cpol;
+
+            reset-gpios = <&gpio 114 GPIO_ACTIVE_LOW>;
+
+            dvdd-supply = <&vdd_1v2>;
+            avdd-supply = <&vdd_1v2>;
+            vddio-supply = <&vdd_1v8_io>;
+
+            solomon,hs-zero-delay-ns = <300>;
+            solomon,hs-prep-delay-ns = <65>;
+
+            clocks = <&ssd2825_tx_clk>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+
+                    bridge_input: endpoint {
+                        remote-endpoint = <&dpi_output>;
+                        bus-width = <24>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+
+                    bridge_output: endpoint {
+                        remote-endpoint = <&panel_input>;
+                    };
+                };
+            };
+        };
+    };
-- 
2.48.1



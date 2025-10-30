Return-Path: <linux-kernel+bounces-878153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A876C1FE53
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9F97F34D353
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4265B351FCF;
	Thu, 30 Oct 2025 11:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4n+qQKb"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A560B33F399
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761825509; cv=none; b=A6Wsbggx5GQHu/psUQOr1FUJOuvKI+1vozurrHiTNRZzrDqyBIHHMFu9IwBWTFiDcA3cYhxmebmx9AI6xQ1Y8baZuKDOwHoYXdFZIf3JVt1H4IDVQx3s5rtrqkzx/zP2w77h+OLGqkGweaDhMT4DGatC9CvBicm6ck71KqRw2OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761825509; c=relaxed/simple;
	bh=z8+/TiRnqkkKhbz/FE5y0ykIKcQoH6t739+vrrDNkVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njXI1VffWeaPdAiDiGJOrYW3bWLczT1Yyk816/JeBeoAE3DfmRnGYmeZX8VjoOBNQoidd5X1MdC+dP3F9kyvf0k+Ib1kcZ838AVnohJVXt7YDrq3qS1uiWDzDEKyWUjGDzHEwqZg75y8UuAvYW8NoCo2jhHWJieEhIwoP1bGy3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4n+qQKb; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so182232866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761825506; x=1762430306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LgqDr2FdByIC3kvKF2/wW7lARGVAOjJzTLXp8RXcVms=;
        b=f4n+qQKbUdgruadyC9rsrpYIT8MzHOEfRUbY99gNBF9cObAMO+IB+IuGaT9Rs5vsgY
         nDxFf/4XIoh5pZ/zhqoMlLW/905qrxTLYqfOiztRBrWDiwy2bMWQV/kMDXZ8bV0llv7C
         ElM3T0q1KpCj2xbYpkWLUubHzFkfy2WnsfJaAzfZODVYfIErgQvYqb0uHu6iXdM9rbaO
         AGnMDuMNZSNexAwophPhQtudTm/EQ3LIDgyt+TEyP9HXreTR8aKAjC5ph3lCPaLzQUKp
         R+OuO0IDPRq7xEdM29+hZzU/rq1lR0NwgpxN7ICZxEFwQ+AJCY4l/QlMaIqjxAcKR8Pe
         f7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761825506; x=1762430306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LgqDr2FdByIC3kvKF2/wW7lARGVAOjJzTLXp8RXcVms=;
        b=atY/ekmFYwL6lU/l9MCLkKuppEwCCzcPwC9vsqjHhADpQnNlV53aTyGiFmzZIx9fLg
         NVbGpLuBqJiMAFzyuDNICZoZjDnGfo67WviYdVYWKwUzszT6SB3JJheT4Cv3m/BSFUJ3
         BGGVKZgBK1KQjCmIELlGDiSQMLxtRf59vlr5CoYmg2/8CdVA60Lp7PXTpqW+IxXQgAYN
         rTyKb3y8IlSr/JSJ3bF/vrBprQOZqglD+oBEZ8JuCZC3dbn8x+tksqqgz/9LShbKoQs4
         WrwkHR3UF9i484cBWoUlWJ5BoER/EXcuc7fJYwQK7Jrueyl4oeQlS10FAPl7FR5OBEJW
         p4uA==
X-Forwarded-Encrypted: i=1; AJvYcCWfQCMO4GnEmTxlAJfni6iwBfo1ktVnhNS252Q3IeNVOeZbZwBElEBffE7JphsNE+Chhh9p2VyVcCqfNaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLTweS2zU9FK2pmFGaWkFnnL1Ucb2ZNJ3+qD/ETdKlmGjt/7tX
	NUt72IEh3ACnshtbuf7WxvG49Ora2LmbkvHAeNoDaw8+AUQV8uRvl8IK
X-Gm-Gg: ASbGncswSyYjPHMXw/Y4OgLwRE/9uQoP3C7bmtL2oxODIQ5dIGseWpF4nA8E3naqOj4
	UWHBJVMS/pX/mZbdThaNsb4g9L77w9EuLUW+1YcUdNrcWUdAGsN2pvNodF2uYLpuHOByWgv1Hw3
	sO75BWn+Qz6jLjLIKFnxiFvukzgGdc4BFC4Y0Tt3v5tz0XiP+3NcB8QzS0xLSgXXEmwCYjIGa81
	ZTxREBXb+B22qK9SicHPzzyCG4u/5sdZHN4w3sDGVMhyqQW1sbmt5/RIMcNnyxGEKPnkdcNFGGo
	9848IP6DOo4ivUcA8E2dsZSONqxFeLpokj6mBv3Y0HK+g64NnQ3TSXicfgiNij8jXQjPZ6XjeR1
	23r2BEGyMEHjB7YyPEak0+WyJYdXPrxuztQEYH9kKGArWzQz0A9GgxRk1bFC2I7q2ZD4=
X-Google-Smtp-Source: AGHT+IEOsIqXvX4XMDlcUuqmCWZeHt5WzeFQ5I60zX1ZWFQCMUMZGW0CUcXNsPFzkeC/WIVGiRU9Hg==
X-Received: by 2002:a17:907:934c:b0:b3f:ccac:af47 with SMTP id a640c23a62f3a-b703d4f7d94mr691571366b.31.1761825505841;
        Thu, 30 Oct 2025 04:58:25 -0700 (PDT)
Received: from xeon.. ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85308c82sm1752564566b.5.2025.10.30.04.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 04:58:25 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
	Sylvain Petinot <sylvain.petinot@foss.st.com>,
	Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
	Dongcheng Yan <dongcheng.yan@intel.com>,
	Heimir Thor Sverrisson <heimir.sverrisson@gmail.com>,
	Tarang Raval <tarang.raval@siliconsignals.io>
Cc: linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: media: i2c: document Sony IMX111 CMOS sensor
Date: Thu, 30 Oct 2025 13:57:56 +0200
Message-ID: <20251030115757.33695-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251030115757.33695-1-clamor95@gmail.com>
References: <20251030115757.33695-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bindings for Sony IMX111 CMOS Digital Image Sensor found in LG
Optimus 4X (P880) and Optimus Vu (P895) smartphones.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/media/i2c/sony,imx111.yaml       | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx111.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx111.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx111.yaml
new file mode 100644
index 000000000000..20f48d5e9b2d
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/sony,imx111.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/sony,imx111.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sony IMX111 8MP CMOS Digital Image Sensor
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+description:
+  IMX111 sensor is a Sony CMOS active pixel digital image sensor with an active
+  array size of 2464H x 3280V. It is programmable through I2C interface. Image
+  data is sent through MIPI CSI-2, through 1 or 2 lanes.
+
+allOf:
+  - $ref: /schemas/media/video-interface-devices.yaml#
+  - $ref: /schemas/nvmem/nvmem-consumer.yaml#
+
+properties:
+  compatible:
+    const: sony,imx111
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description: EXTCLK with possible frequency from 6 to 54 MHz
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  iovdd-supply:
+    description: Digital IO power supply (1.8V)
+
+  dvdd-supply:
+    description: Digital power supply (1.2V)
+
+  avdd-supply:
+    description: Analog power supply (2.7V)
+
+  port:
+    additionalProperties: false
+    $ref: /schemas/graph.yaml#/$defs/port-base
+
+    properties:
+      endpoint:
+        $ref: /schemas/media/video-interfaces.yaml#
+        unevaluatedProperties: false
+
+        required:
+          - data-lanes
+          - link-frequencies
+
+    required:
+      - endpoint
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - port
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/media/video-interfaces.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        camera@10 {
+            compatible = "sony,imx111";
+            reg = <0x10>;
+
+            clocks = <&imx111_clk>;
+
+            iovdd-supply = <&camera_vddio_1v8>;
+            dvdd-supply = <&camera_vddd_1v2>;
+            avdd-supply = <&camera_vdda_2v7>;
+
+            orientation = <1>;
+            rotation = <90>;
+
+            nvmem = <&eeprom>;
+            flash-leds = <&led>;
+            lens-focus = <&vcm>;
+
+            reset-gpios = <&gpio 84 GPIO_ACTIVE_LOW>;
+
+            port {
+                imx111_output: endpoint {
+                    data-lanes = <1 2>;
+                    link-frequencies = /bits/ 64 <542400000>;
+                    remote-endpoint = <&csi_input>;
+                };
+            };
+        };
+    };
+...
-- 
2.48.1



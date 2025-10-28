Return-Path: <linux-kernel+bounces-873371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC66BC13C98
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0773BC887
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F0A29ACD1;
	Tue, 28 Oct 2025 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fj0kaDs2"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64DC2EA493
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643354; cv=none; b=AYYF47M3t8GjEa/m7PNoWiXax7xTz0ni6HiwyJRfh831hy/FlG/hJG2XoRenQ9JN5XnMsUL80eAi2YcMCtNevHp74vC1EoxgsvTSr8IoO4z7pemXmrYPgZrtLPOmWce3jYNzih0Aa9MIWxhH21odDKfmASxpNcCG35xQDzKJ0F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643354; c=relaxed/simple;
	bh=RGJV+VuDp8KhpE/B0qdGxJZLvV3jaxtUrwVBEol2nZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxEJY2q9lNswgvp+u8TLyrCfIg02FauiSBVKDcFU5KVJ7obOgjnaQHzjuCQ8oPuZMLb09w5FOourLOHEkpPWCwZfuotwAfDCUM0Q9uAY1jG/W/ZkUn7ZgUP1HNi974KDdqb5aeb8dtpO5iOTLnzQpjzRevzsO2BFkNnrRKGes6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fj0kaDs2; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-421851bca51so5275445f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761643349; x=1762248149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUIomtzjCx3KBPBBPMA+6d2UdIXffn0+Q71ellevLW4=;
        b=Fj0kaDs2NurA62BBvc9rCHRSiXJVhwPMERAgRUKWV4DYhkn7zCpbYjDdwD3TBOfYzc
         Or8Lae576OLW/J4vepzzvPtlGI2Dap45twVwEvRD46fOa4fcJzQQUYvtYHvk2Ix7BvKF
         S6lfk3L8BiIii/1rTCdSWR/ia+O8XZZuvyEKvBHCQAkGrKM6JETYE7SYQ2MOPWCQcYuZ
         RQo7Hr1yHL/D8D4tjG+Sb2POFsbGG2asC6W8cgk45we2Qi34LswxfXooYzImOhYri83S
         ZFDW6JS0JPtKkCvBHqWDxZxJhU0CU7uzq5JHhkYiEcTRdMIbSOtON3YcgaP1f17XRixy
         dszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761643349; x=1762248149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUIomtzjCx3KBPBBPMA+6d2UdIXffn0+Q71ellevLW4=;
        b=FipK3lBt2To7sXoyE2G8uzYjuvpIcdpZPCyG0dfPm9uFlHcI589q80Kfpdy7iLwaHr
         QtW27CNZzakk/9QENHUcFkUcaMDhfxsQSXPkPvzgqWgNlNfFFZ0k154P2MGO1Ascz9zn
         GbLKK2M4vYOfo7ZNHDN2fEM7lEK/+12AFYwLc2QbhR8oc9ebhRT3ro7UxxPoCqDHWKrN
         loXqJ+ZUAr86eRPDIBYoh2WcKJIFa9pgdK9U1CVXCE4RyPs8o1jT7sCk8oXgHvLEmHEh
         jwV2NP2/n27Dw7FuHj2KTehHACmHN7vfAeAYHRHLtR3EdrVbI9LvAMzM1x1qtJPZOCgO
         iOKA==
X-Forwarded-Encrypted: i=1; AJvYcCWxRNzwUoRtrVa2rRqHCaWkunffoP8ALkab0g5X9iL5Kk466cfaRom/CeeZQUfRru+dZLAsLl0+4FlTK20=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW2tkkwWwCqghL7V3fJC9N6amXG8pvt/fRu+ZNyCEivLBQ8a8u
	r0hGt1lJt2+qAr/IO/lYZxgQxzaBAO6MGS4XE1Tck3Gv5R8bC8vr5UKQ
X-Gm-Gg: ASbGncuZ5lnGrOKDttuT3GiganRys1H4WLOYzVjN+6EYPb47An2s2s0bt6EFm+Htw/F
	pGQmu5hBcx5+X2byWhBKCAyuTocEM6vAsxTYWrhq8UOl3sJ8EVmlwOeHSYKTcD2zBs/a+Mvww6a
	8ezy+yv7F7hVKtXsxIk7PUzhU//FJkzcKAnsD/eCJDefuqVAKCq9UGPOOR+ZvTE4Htz2kfNuVbm
	ohi7Pqx5XUK5bpWrt+Ast6J5zbEfZ6H/rTPbmVL3mlza/Jpv2w6wiJDgXw+3gd7Qp4DoYmVeBsc
	WNSu3eX/DxJELnVGUfIWVNQpgvpZC1hZ7Cq131VALkymSLCbjSYSfHFb1t8dHKOXcf8lEVDucsm
	eXmQYFwjNcu/9b0GPSORnpuewLWM9FuUksnjn+XDdtGgNgdu/Sa484/tqx76FRdd1mmo=
X-Google-Smtp-Source: AGHT+IHmOBBRx0zEzXSCXq/mniWjQ9/2iDUrqoatjaHFQQtM0VmrFPDGHFBvKTRv8iGiIAXFScJZ2A==
X-Received: by 2002:a5d:5c8a:0:b0:429:8d46:fc40 with SMTP id ffacd0b85a97d-429a7e4f541mr2612304f8f.25.1761643349113;
        Tue, 28 Oct 2025 02:22:29 -0700 (PDT)
Received: from xeon.. ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7b22sm19162525f8f.9.2025.10.28.02.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 02:22:28 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Hans de Goede <hansg@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Dongcheng Yan <dongcheng.yan@intel.com>,
	=?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
	Sylvain Petinot <sylvain.petinot@foss.st.com>,
	Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
	Heimir Thor Sverrisson <heimir.sverrisson@gmail.com>
Cc: linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2 RESEND] dt-bindings: media: i2c: document Sony IMX111 CMOS sensor
Date: Tue, 28 Oct 2025 11:21:59 +0200
Message-ID: <20251028092200.7003-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251028092200.7003-1-clamor95@gmail.com>
References: <20251028092200.7003-1-clamor95@gmail.com>
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
 .../bindings/media/i2c/sony,imx111.yaml       | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx111.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx111.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx111.yaml
new file mode 100644
index 000000000000..a70017588891
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/sony,imx111.yaml
@@ -0,0 +1,112 @@
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
+        properties:
+          data-lanes: true
+          bus-type: true
+          link-frequencies: true
+
+        required:
+          - data-lanes
+          - bus-type
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
+                    bus-type = <MEDIA_BUS_TYPE_CSI2_DPHY>;
+                    link-frequencies = /bits/ 64 <271200000>;
+                    remote-endpoint = <&csi_input>;
+                };
+            };
+        };
+    };
+...
-- 
2.48.1



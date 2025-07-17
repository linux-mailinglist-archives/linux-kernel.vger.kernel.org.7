Return-Path: <linux-kernel+bounces-735390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CDFB08EA1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD681886F22
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499B72F6F98;
	Thu, 17 Jul 2025 13:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHjTqkdG"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B3F2EBBBD;
	Thu, 17 Jul 2025 13:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752760692; cv=none; b=ZQw9bRk021scYSLjviftmhd9gauU4xkkD8LODQcb8Rt+24xqB6Oh0AulmWxZ/zQR6DlIeXE0Abl5UQ94noE5UFWnO0xTCDqC7l08SkO7//UG2r3h6Ltkv6l/Nly0rhDD6QNMgw3WWUyVniSgM7y3aaiAsvT99zeGez2Y6nVoke0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752760692; c=relaxed/simple;
	bh=bVI/KpPkYyUicHG4qcdjM6iEDu36HaFk0dPbDUf0BTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eyDVqqqRIJWD4l4bFywNZUmJPCvjDuP8AVfNSAsntsKN8YXJW63eB2xWJLjXUQJE4/N+zDKeEX4Mr+pudRqkndnOGm/Zesr3QWXsHiPwNv1J8g28yD9isi1tizZ4liOkyatgGT88pOgxrFW+zUZ8kNRBkKqEqxY02jP9XGzVIlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHjTqkdG; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-553d771435fso1138604e87.3;
        Thu, 17 Jul 2025 06:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752760689; x=1753365489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsTpbv6UhxKMuPPt8c1WeoKOTOwLNGZvIDwyOaQY4Z8=;
        b=XHjTqkdGoORPHJJHcN8vv5IcGnIYnGorzACOXnIYpK1XL75YQ4c0gqbDr/kGc89Sja
         XTz4mFL3cyILx1fhxrg2fObl2QmplWUG6mc2+txXMqEMFq1JDf4ZKDutf48EhEag5F6P
         ycn2qzYlAELpRO+yEFOFgaFYp2NEjxuELXiEctAzUUWQO8CM9BvzK83KC6SDRgVPD5Pd
         I3lOe4dXNDD8ItuXi3eBhyzQ0N4QDa2ZR3t3/6mlCyamoBQ1vPUb5Ux8RWg8ynnyOxx9
         tVXSPz5g1SdWx68nJ7fwh7D5AYeZULiFWM1nhRTaqzg2k/WAFBfhChB7cnamYq8rE+RR
         Fkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752760689; x=1753365489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MsTpbv6UhxKMuPPt8c1WeoKOTOwLNGZvIDwyOaQY4Z8=;
        b=ihWYWcW8NyC1pgJHDFaLTyvTmvHX9kjrmUxcMEdEDSpQoLh/2zyDHeuYtyUuFmrf+R
         aNQVercdHrh5nOur8txy44HCSMBf3J9033kgLU4DD4tkeuyEoZwEZ530v2BfIOqTJ4TC
         Cw9KVffdk+oQMu/Xn9qyZUSUNEUdxQgPFmmSWjci/kNRde9QJ7Odim5pdCoucy126suX
         Kp+1jxxwkigzNvP+dmM0zMwnZS+ddM1l82Hib9KxFmFuYtfJcUYqBB4BgHXb9qz8jPEi
         EK0M5bVXnl4S9dDokEdeOTQ6SznlVDew5Qs1yOBfYyM9D5yD7pbka2edpoysFN8/VkrC
         ZagQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBVi4mc5db2176ta13A8zpPBAulPkGuy3Gf/E1I6KQZ8KG8DWKAtt4jyu5ae/BZ0AWYbNvXHuQ027T@vger.kernel.org, AJvYcCWqK3LmcdWlaGE4GDpPaw3Ur5g088jzrQHDScpJIcdUK/jACPhWNZbNZNcBiZ0UVwcpHC7sx57Nb4aIQxrg@vger.kernel.org
X-Gm-Message-State: AOJu0YwSIH85B7kDsUeZK2C4wEFf6gDm+yq4LPcbAGlJOwdERz05hKiy
	0J4lXItFIZN7ktYfkQO9tetTGj/eoJTscp61W/U/imW1BDHLXYbB+2o7
X-Gm-Gg: ASbGncvZwMj/vkdXYwHRs/HJAFI8cbT6y6+SD90ugzKwnZWY1Z+iGK0nclOs4U0ZE16
	uHkxoBAYaFYFuLeRqIEaL8+3Qev3ctK35itjj9SqvkH7ZF2e0r6E5U3sue1pzYJIDW7j7LlzAfY
	pDXEOWwkEDryrPaqWVeKC4OhiPUPxVhgxVZLfpWWmUmTnFR8L8BkeRZ6fZmhhOOSwA2UkyJHnfd
	uaGT8R10KKDajNdnhrV9N4DPCu1U0PXMmV+UNzq1QwPV7Y3LOj3rPvHxrlG9PrwUh7QdISnG91g
	LY+fDR0+I6KMlIH7TvjsLr6GpLaK2G2GB9kwyY2RcZ8nW420l+OX1u1D1LW/jBCgeigAsGiv2/Y
	8qHUFpeqgyVSntQ==
X-Google-Smtp-Source: AGHT+IHAHj2Dcw3e+LQI2BqY4QKo+tAAD3E6vOJyIWJ4OF4EwozF86/heR+YHoVNMqhicve7nqlGZw==
X-Received: by 2002:a2e:bc1c:0:b0:32b:541c:eae1 with SMTP id 38308e7fff4ca-3308e546e8cmr25168671fa.25.1752760688748;
        Thu, 17 Jul 2025 06:58:08 -0700 (PDT)
Received: from xeon.. ([188.163.112.60])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fa29134fcsm23794421fa.15.2025.07.17.06.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 06:58:08 -0700 (PDT)
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
Subject: [PATCH v1 1/2] dt-bindings: display: panel: Document Hydis HV101HD1 DSI panel
Date: Thu, 17 Jul 2025 16:57:51 +0300
Message-ID: <20250717135752.55958-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250717135752.55958-1-clamor95@gmail.com>
References: <20250717135752.55958-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hydis HV101HD1 is a 2-lane 1366x768 MIPI DSI panel found in ASUS VivoTab RT
TF600T tablet.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../display/panel/hydis,hv101hd1.yaml         | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/hydis,hv101hd1.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/hydis,hv101hd1.yaml b/Documentation/devicetree/bindings/display/panel/hydis,hv101hd1.yaml
new file mode 100644
index 000000000000..f429e84ee65d
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/hydis,hv101hd1.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/hydis,hv101hd1.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hydis HV101HD1 DSI Display Panel
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: hydis,hv101hd1
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+  vio-supply: true
+
+  backlight: true
+  port: true
+
+required:
+  - compatible
+  - vdd-supply
+  - vio-supply
+  - backlight
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
+            compatible = "hydis,hv101hd1";
+            reg = <0>;
+
+            vdd-supply = <&vdd_lcd>;
+            vio-supply = <&vddio_lcd>;
+
+            backlight = <&backlight>;
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&dsi_out>;
+                };
+            };
+        };
+    };
+...
-- 
2.48.1



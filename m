Return-Path: <linux-kernel+bounces-890420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B998C40049
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A419E4ED925
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D09271454;
	Fri,  7 Nov 2025 13:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KuLzNU32";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hda3PcoI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABEA29ACE5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762520599; cv=none; b=pz0pmDccUtU8KW9zdsrzgpSZTxB0mWsYsDWLWEh3nL1BaNkFklwyaZxUGZ6TqHm4kvhhU5EfUw+9Jkv598mURtCbYD3pAoCLy2s9BGRHzXTAzBywhVWPsLKaVku8S5a0UcEpzuMrRXMTgAnnX+pzsyejyyS0Agyz+cQ5vEGMLYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762520599; c=relaxed/simple;
	bh=gaAkl13+hLTaTFl4XxH8wVSJLs+i2Xf9TdiN3O4IE9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X6LOu3AR21xyXMDEXrsde68mlp3fcKn5R21aGZaW76wSvqZ6l9sohE+9G5H+TSeklfKXqZmYu7BbbCG61IfAZ0qZRp/N9phZeZ3Hb4Cgw34Zap0rTgYq/b4SJhLplYsGHfPTow7unPQzRbOng5WxJxyQqBg3CRPLUsbsU6LjVwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KuLzNU32; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hda3PcoI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A7B56da3174700
	for <linux-kernel@vger.kernel.org>; Fri, 7 Nov 2025 13:03:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G40SlKpdS7e4bW3M9vZNvOUg9wFUDrREVO2yeCjm1Ic=; b=KuLzNU32VFXX3PL/
	Ly7KFKRWsRRyLpP96a5isxEzitSNgTn5+T30TrrEwtIQib4Eeh4UGzXneti/Cv58
	ldMRMgT3Sw6BUmajVsmqgCth+M1q/sAYuqLh/soLPAK65vwH7G53GgLL/Z6YTZC3
	9iB/f777v+mjf51rXsrb2lSaJ3qNF3irGl96B/XwySGlbOpQxADN6jmo6W6FyoTG
	FfHIhyb66k5D3+IxyxFXn3yayLydpdWRlhJSl1X+8XU6rpgnydLF8M2uJonRjI9I
	ajux0KUL1zv03p9C+Q3M6nd45WJY5JV2yrDvKDK1lYSNLUZ2N/hW/gOb5j35JCGO
	tWtFFg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9fk8099t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 13:03:16 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29085106b99so14547685ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 05:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762520595; x=1763125395; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G40SlKpdS7e4bW3M9vZNvOUg9wFUDrREVO2yeCjm1Ic=;
        b=hda3PcoIPY4myvZQXIrOpqzb6wqiyFn+IbmZqKWgRLKdpsCRaRggkqDzoOcETk6G6+
         NTrXtqRCFEwRHcGBNMuOXwGIB9gttiGezWVsP2oJQooTHXqh26CRfgwP0K2RrUKfaggx
         ibDWs+FNnyOGOpBZrHRI+xCrc4vkA0i5kq45nsFOA6yhhrbTladl3BDJn+hBQhRJRdYJ
         DZxMAwKl1RjF7S0seINLty2x26meYWu0eDzka67MqlJArhaLtTkKWaD0S2l4MT2QVOY8
         zPdld8uueT2v56tA36G4jW0djdkuri2y6gJwyvF0jHRXrib0NMZYmudIgBvqPlzucTHm
         z0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762520595; x=1763125395;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G40SlKpdS7e4bW3M9vZNvOUg9wFUDrREVO2yeCjm1Ic=;
        b=qS1KMQ0tjzMVMOnRFA6ObTzNWGR0IIj7b4GhPPYzoknLBRuqAwDkJdjViAnbUCm71G
         mGr+AImWsAcXIxnvzzcQMfdFWxNbbxqOi+6dJ7SDfvqXAqUQEYjfB+UMaoAjAGmlrXJH
         PadtWHUDGUyoPoePLyPESGv9PvHSK7g+sbur1NlNlf03PMVhpzaf+kNyWS0dpykK6VjV
         VwXWzUYSoWcnJTCGENJDipYxah7j25CFT1be4NxocTIN4K2Z/tFqHh5kFivgF1cjSJfI
         8UJYYNUcjlvIxX5WALXOkScvrE9dFp7gOQXc8YyRfdCeousQZsPi7MBZw7z8QV6zI0NC
         MDIg==
X-Forwarded-Encrypted: i=1; AJvYcCXSJ+lsPXqaM7PG7bdT9SpYGcGOVJl3sSw0xGXh5Q/Vw/jJV/8hiytFkldFPqBc6hON3/qjSHdD94uFc5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGLcu1HN11c/mO2zKxmtNXF7CEXc+rzN+y/ZEFKxzAPRwHl9Xa
	bi6tHAu5ny5I2k018eC1C/3c6zSL61Apc+7FWKqtxdBt+RhaYa9by8OVQzLfBQr8Makt0/Y3zHq
	ugt3HAFz3pwJIj8g8BJhVWTUUKR06peTwQqRYYPIz0R3rz+sTS0J01kWtOywwkqytsA==
X-Gm-Gg: ASbGncuhFPxIWxQkm+33O6L6Xp7HKic8l/W2Cs0EnKYYT3irirORocMAkR2eH1zFnWL
	WHphWFpyYa5Z0n53c3RPk0WE9r0oggHdxpkQlEE0PFwJNaFWPEXpDPL7hq4Q6rZp6njWXhcnt6g
	PPUKhu7jZqJWC6yBaaPdtzD/nKBLhitA8IZteb8UrW6ej5/6s/3T2I/7G8MqtGqtq4a9ng5Pdh8
	hqbeRQVvFiOULO3WbZrQnyiwezKFGIfDDT/sMI8+4WvyxiA1s+AuxqkxCz4rA3or8foXxkB61ho
	jLYlUVgZicwoVPYia2aqjglQZ51T+ak5RzyB+mm8ixDkiYBGAhqUEL9DFjtnMAhxWEw2CrzocIQ
	6RL3z9VzZbuh5VjREAz78Cccr
X-Received: by 2002:a17:903:384f:b0:28d:18d3:46cb with SMTP id d9443c01a7336-297c03d8fcbmr44202315ad.20.1762520595194;
        Fri, 07 Nov 2025 05:03:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1NShUF3UtYHtrjbPiVmio0Nnbx07gYYOUbClFgiyLSaZbhV+891/JDNA6u3MCcjSBxwtjDw==
X-Received: by 2002:a17:903:384f:b0:28d:18d3:46cb with SMTP id d9443c01a7336-297c03d8fcbmr44201605ad.20.1762520594431;
        Fri, 07 Nov 2025 05:03:14 -0800 (PST)
Received: from hu-nlaad-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-296509680e5sm62477745ad.1.2025.11.07.05.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:03:13 -0800 (PST)
From: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
Date: Fri, 07 Nov 2025 18:32:58 +0530
Subject: [PATCH v2 1/2] dt-bindings: bridge: lt9211c: Add bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-add-lt9211c-bridge-v2-1-b0616e23407c@oss.qualcomm.com>
References: <20251107-add-lt9211c-bridge-v2-0-b0616e23407c@oss.qualcomm.com>
In-Reply-To: <20251107-add-lt9211c-bridge-v2-0-b0616e23407c@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nilesh Laad <nilesh.laad@oss.qualcomm.com>,
        venkata.valluru@oss.qualcomm.com, jessica.zhang@oss.qualcomm.com,
        Yi Zhang <zhanyi@qti.qualcomm.com>
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762520582; l=3387;
 i=nilesh.laad@oss.qualcomm.com; s=20250718; h=from:subject:message-id;
 bh=Cc83NWmW1/dAnYephO+V19Kl2afDLNqD9vMBq15QmpU=;
 b=xZrZ3hN+em7gs+lxlTPFVBXdsZC4IcKxjtImY2IMxTEIRL62qrDH8Z8INVgQpZxriJ4DSXywX
 oh1E1F9PH+QCQzv7eUv6jv5t3h/E8gq1HgY99ZjjtuxrMy2iSMe0I8h
X-Developer-Key: i=nilesh.laad@oss.qualcomm.com; a=ed25519;
 pk=MjLHvGipC16awutyYh0FnLpT1nPxL/Cs1dCevHMrrD4=
X-Proofpoint-ORIG-GUID: fzsYWDd-YxqCVFMA7ZPBAs7xlEPmxotZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDEwNiBTYWx0ZWRfX6yJTbP2Kj3B5
 Agj7l7pQacP6ZpUB9j1PMQQK6QxUqEQU7DzoRTqczrADVPeWDIKIkjjqSYgSJRIwpIh/FnCvEm9
 TYWIStBLV366vms1NJx7Mcmcf5h0k1Sp4QqS7t9lhj11sTf52PjOEkoCYx6nEmm5dK2pkeAC913
 IgGpJ49SyiUHetvmzDmmtIy+zyu4etUQXgDQTAAIZMbP5PPsDMnxV7zsPRSsA53rYWJILLtLv9S
 TQzegaYnfslLhC+q2VqIx9Bb4Jz848OKN/OVNsc7d5c8birFiIcIfl3SZgQSonuX9FDD9O7URU3
 MaVg0S/HNFSfdrIuNOfbO2ycBvD0Atm5gZkAU/5ANKmI+eEbcGJy7bXeZMOkSfzUrRRLxTkzghA
 Jl/0VBZgEtuEj3Ji+BHo/hjkHKKlgw==
X-Proofpoint-GUID: fzsYWDd-YxqCVFMA7ZPBAs7xlEPmxotZ
X-Authority-Analysis: v=2.4 cv=CPAnnBrD c=1 sm=1 tr=0 ts=690dee14 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=Xc6W96i5Xe6cDM1WBtQA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 malwarescore=0 suspectscore=0 phishscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511070106

From: Yi Zhang <zhanyi@qti.qualcomm.com>

Add bindings for lt9211c.

Signed-off-by: Yi Zhang <zhanyi@qti.qualcomm.com>
Signed-off-by: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
---
 .../bindings/display/bridge/lontium,lt9211c.yaml   | 113 +++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt9211c.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt9211c.yaml
new file mode 100644
index 000000000000..619f718618d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt9211c.yaml
@@ -0,0 +1,113 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/lontium,lt9211c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Lontium LT9211C DSI/LVDS/DPI to DSI/LVDS/DPI bridge.
+
+maintainers:
+  - Marek Vasut <marex@denx.de>
+
+description: |
+  The LT9211C are bridge devices which convert Single/Dual-Link DSI/LVDS
+  or Single DPI to Single/Dual-Link DSI/LVDS or Single DPI.
+
+properties:
+  compatible:
+    enum:
+      - lontium,lt9211c
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+    description: GPIO connected to active high RESET pin.
+
+  vccio-supply:
+    description: Regulator for 1.8V IO power.
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Primary MIPI DSI port-1 for MIPI input or
+          LVDS port-1 for LVDS input or DPI input.
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Additional MIPI port-2 for MIPI input or LVDS port-2
+          for LVDS input. Used in combination with primary
+          port-1 to drive higher resolution displays
+
+      port@2:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Primary MIPI DSI port-1 for MIPI output or
+          LVDS port-1 for LVDS output or DPI output.
+
+      port@3:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Additional MIPI port-2 for MIPI output or LVDS port-2
+          for LVDS output. Used in combination with primary
+          port-1 to drive higher resolution displays.
+
+    required:
+      - port@0
+      - port@2
+
+required:
+  - compatible
+  - reg
+  - vccio-supply
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      lvds-bridge@3b {
+        compatible = "lontium,lt9211c";
+        reg = <0x3b>;
+
+        reset-gpios = <&tlmm 128 GPIO_ACTIVE_HIGH>;
+
+        vccio-supply = <&lt9211c_1v8>;
+
+        ports {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          port@0 {
+            reg = <0>;
+
+            endpoint {
+              remote-endpoint = <&dsi0_out>;
+            };
+          };
+
+          port@2 {
+            reg = <2>;
+
+            endpoint {
+              remote-endpoint = <&panel_in_lvds>;
+            };
+          };
+        };
+      };
+    };
+
+...

-- 
2.50.1



Return-Path: <linux-kernel+bounces-809595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 448B9B50F99
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA3F7177003
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 07:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF40730BB8F;
	Wed, 10 Sep 2025 07:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UyqfSUix"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4228A30648B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757489862; cv=none; b=s/dtkXZ5dLeiWy2cI0fD+A2w27hZAXHXhC/vKKJF3dbVqV+G5RAlgwLRMwwJArqID6VM/IS6evb084kIgm1ooGpiYPq2k/yGSaDoatQQEH3lV5EHjInOreK/dvXFEMiqSAXGJDfu5fJ+qwY3rM//ltjod4DRqFzIYGu+ywRavik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757489862; c=relaxed/simple;
	bh=+Cchf+lYvptz6Mt4BoSPx+Nx2c+updx84177OmhwJK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PWEdN5xOHCYTSSirN3OjisqLTWPq1RKP5ItNPMJ3BNvbWM4b/IvEwRfza+PUYqVAsOeEhWaQFop9vxIz5zOJGIP6h4QJO/k3Zdnvlod94nlFfi/A+01hlYY3lRiWpbwskD5uFgAJjL0MZhZ7STu/nIwVB7OYTzwzXTgTh1gv+yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UyqfSUix; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58A6UvN3031532
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:37:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=qpH83xM68WBYwHeKrO4S/O
	WP4WBR11yqOxSj2QwNRQA=; b=UyqfSUixk903AbZxhV4O5Qnk+x7NRS0Z37KZ0U
	8i/OlnQqg60rlyjtOo5ExlygE85JJdpEsqbL8KrsXf8E9zgyerLhRYeFiPf8imw5
	BNT9y+Q4rC1+mEwyE54diVIm4Yy8yxNkTbV4Fp/+3rSCIxB0o54rmn4ZXUxOIDqF
	p0gCzErQlSvv2LLH0Z99E76NeHZjYXaQ+QMZLjIUSQUHhicX4aLXBWosOGHq5xOm
	+UsMUFOqh9LidkgqisUCdWfg4QMFhCQmQfVXkl4hy3aa6FFU/rwhJv71tElPE6ly
	C7xKN2xB6baP/Jgv85MnvsDjFp6UrDZAUKsQ4TTakhx9KCGg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490bwsb5fy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:37:40 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-772248bb841so11098505b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757489859; x=1758094659;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qpH83xM68WBYwHeKrO4S/OWP4WBR11yqOxSj2QwNRQA=;
        b=JUfHKLcjwWf1lJ2kMnWnGvFPyYnf99HkjPXJR/Daw8LyGUdHfTEuzHLD1p9I/0pLIR
         RUH+ybmK6Q5CTiQ8C0ubGDuY2mFfWepUb45ZqbN31uKAe5JXqAjRJE8R5jZs3ppMFXs0
         Bjl4kT6Y9HmmUgaCR0GLVIonYieKWJApKDbKz8UupHBuP9m7p3el3fsfLuu1of+ppjm7
         yShCzbGsAhUI1emBqbryeEMMB/HVHP+qCjmWxFVZ0ibRyAKy4Z18zlq6QyBWuvvN24j3
         rzJUWyuG7dJ44P7IHHi4r/uxm2fkXVkuSsKGIpWVryUcIfI3tXQ2PF4IKni2Y4JFLC0x
         pY9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWsGSBqxTkE0yb+XrtUctVpclPJ73Xp6wRZlMr0H7Smubw5cja/XcQZwQsfPnVxZPCTDcIXL9x7jVMsl00=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAdT8ZOenh3jUO9vM42wI6zMW7a9BvSCrgQJreW2MrG/RS6CLl
	D/hpHsIsZGSH04HWxnNSsN92qFXmFb1qd8zhOk0CzNFzcPdxIRrASh8Y2uIbPYzPYZqzOxXuvRf
	X7ienI0mJVaKLUkLBWSD+DTs5NvQaHyd3x7dnicvyJit3AsdfP52UBR2Wk/X0SIbfFw==
X-Gm-Gg: ASbGncud4pEcjnm364+TJeCOdxsKgJL/wIEXwbLCVqlnG0F24qA+76e4ZbM1HBV46M0
	rMhZIa2dGjXdgXp+e4WzdazV+Ktbhe+7lM9lRFByvEwTiuwsbxVN8tihnK+wkBoHPcUY3R+Pe2t
	dYjaHiUVQ5z4M8SNgXBZVBlRwkc1NP8vuz/2PJGEbN4Lz6aloW3HNs0GuNKJsJqFV9tLM01BjlI
	heJjLecodpFx4UEnVUTcnzPCi4OmSh76LShOgrV93LwKfr4z3D9M5hp+zaaRW7xWy17NAa588F7
	b07wlbc+NTKa5W8NtHYvYqjkv7ZdGefOB8tpAu2dqxQrx4pSLfuOpO1W08B/W1b98w==
X-Received: by 2002:a05:6a00:4b01:b0:770:4b1c:8155 with SMTP id d2e1a72fcca58-7742df2f3bamr19863533b3a.31.1757489859333;
        Wed, 10 Sep 2025 00:37:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLXL3v7N0gh33XG0PkJWPquXuIz/nB1XoVwRjBvYA1VOTk7oKc81QPqOi4OYMUY1vfrJuysQ==
X-Received: by 2002:a05:6a00:4b01:b0:770:4b1c:8155 with SMTP id d2e1a72fcca58-7742df2f3bamr19863519b3a.31.1757489858877;
        Wed, 10 Sep 2025 00:37:38 -0700 (PDT)
Received: from hu-nlaad-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774660e4ddasm4199822b3a.20.2025.09.10.00.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 00:37:38 -0700 (PDT)
From: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
Date: Wed, 10 Sep 2025 13:07:28 +0530
Subject: [PATCH] dt-bindings: bridge: lt9211c: Add bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-add-lt9211c-bridge-v1-1-4f23740fe101@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIALcqwWgC/x2MWwqAIBAArxL7neAaQnaV6MPHWgthoRGBdPekz
 4GZqVAoMxWYugqZbi58pAbYd+A3m1YSHBqDkkpLg1LYEMR+GYXohcscmqGtwugd+lEO0MIzU+T
 nn87L+34qz+loZAAAAA==
X-Change-ID: 20250910-add-lt9211c-bridge-5a21fcb1c803
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
        linux-kernel@vger.kernel.org, venkata.valluru@oss.qualcomm.com,
        jessica.zhang@oss.qualcomm.com, Yi Zhang <zhanyi@qti.qualcomm.com>,
        Nilesh Laad <nilesh.laad@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757489851; l=3554;
 i=nilesh.laad@oss.qualcomm.com; s=20250718; h=from:subject:message-id;
 bh=ArUraQTPQoIbSH/uDZ7dfoUv8bSRIlKaGZGF2p1zUDg=;
 b=RUUo6FwTn2Y+k2N60GUFyekAWwynzkKjZYdUtHk0SHoRk/k2Fl51ShyzN7rsCRM2gKuEeMXBf
 zXYSTbSAXtuCsOqj6oeHL3xPrH97miSSicjMritjDap8Puyv0Up9GLR
X-Developer-Key: i=nilesh.laad@oss.qualcomm.com; a=ed25519;
 pk=MjLHvGipC16awutyYh0FnLpT1nPxL/Cs1dCevHMrrD4=
X-Proofpoint-ORIG-GUID: 9V-CPTh4_-hso4WhsgswBC3XUrWL02U9
X-Proofpoint-GUID: 9V-CPTh4_-hso4WhsgswBC3XUrWL02U9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX76nIfICC0wK/
 yi9Q36JHN2zW1ZTaVpPrclmjRtat+koveNiBsRnDRGJOv9cqw/tlddqzprIEngBzYQgkVookfzv
 Y7f1O8IoCjC/U8MXa2jPJNiVgdPZX/wp7r6NXD0zT5QyMbeJJOvlbVGqEpvXBErQEWltY1J8l0m
 A2MtLx3AAr4YeLEk9lpDLLR8oEyihFjJvdB8o5jj983459JWAGCW+X8Nnt/s8iQifmNjgw79L9u
 YnYPtclpQ6fdDd90Lgt7jlNCq9uG85y1L/qPOP83p4Hj6DIo3uH15DNnhqEU2TC+OSWMHtazBWO
 S4LhUzPKYgec2gDmRxoKNZZyvVhaliFauoK/sIyGuKshIr5+A1wbyJ6oW+sU7klzEOb0UDCzdN1
 OoSnWmWy
X-Authority-Analysis: v=2.4 cv=G4kcE8k5 c=1 sm=1 tr=0 ts=68c12ac4 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=Xc6W96i5Xe6cDM1WBtQA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

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

---
base-commit: f50b969bafafb2810a07f376387350c4c0d72a21
change-id: 20250910-add-lt9211c-bridge-5a21fcb1c803

Best regards,
--  
Nilesh Laad <nilesh.laad@oss.qualcomm.com>



Return-Path: <linux-kernel+bounces-834136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18421BA3F95
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE3847B8F0F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD762FB977;
	Fri, 26 Sep 2025 13:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaiofGms"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BAF2F7ADA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758894755; cv=none; b=Iz+4F02NCGssVEsUP1SSPbcUtZ6bBv6gTiRQ40+1NzjJFv8IuAm7jMsVYAg6/6PFwilEMmq4eC7sfv7xEjMzbpWYmf56bjSTHcrVoc7q0L3xAVIMMZb9vRrwrmXI8P+XgCkuZg4lVtNPa8T+heewjoICfw78uSmtGNa0wJP3le0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758894755; c=relaxed/simple;
	bh=60sKW7i1vbbtY0FuzPNlPEuK/DTNRLiRrb1M3U5kNUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YubiFn3lxchpoWVkmrLfv+HFUuIhPINH8ubN0IMxM013U8dxrWNWNz5U72FMr1s6Nzc3xfqJCA8Bi7B2x7Mere5eC21zukbV+278gJMLrW1l03WonCJzQPdeATzltc6MxPSf1kwG+p5Xil9Xile90VhXel+EwaHG8ffR78wJl4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaiofGms; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-78115430134so685776b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758894752; x=1759499552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcC9XUY8FVCgBMwswacD7pUTLZ7aCAKIG4tpodOwdGI=;
        b=IaiofGmszXkvO6+MGSbKiGeq4zlrCwXOt4OmWc6DIW3BGQ3IGFMw2A1L4RL7N7KLHP
         yK5jDNIQ35q1Bkusc/NFDkmYKFdZSstJ9fIFImQjg4v1CIta4ndJ0XuYlI32yErd/l8B
         GV2MuYDdj+Ct8DJoWWkvBn8QvCj7y1UWA2AiNUt90Xrsb1kau6A0JZFk4/EGpJueGAV5
         CSzTkmlc3PHovuPqQpzDM5fdacvuCzQNUeT/UmHdsEL8aUOI3r11GR2aj+kSVLcqLllb
         4Sd/Xw/qF269iZa5kQce40kkcwsLmHoi1PN73PgkyBmVmLlOe3XPHWW/bDje33QRZUY4
         Putw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758894752; x=1759499552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hcC9XUY8FVCgBMwswacD7pUTLZ7aCAKIG4tpodOwdGI=;
        b=OTUYco+uTPqJLZz+yVm1iFHmxA92ImSuiedXpf/avdgrD55eaq4vHD36kgzEjVLF/N
         zqp8JovxS1FBmOBw2m/oDeKYcc6xmrfKyggYgMPxfw6hsUcj0sHDzemU7/YiUdr71dIE
         X6EPAT6zGvOKkZf0Jrilvd3GY3JfX0cPVwvcZWYFrrwamHhpYdMOX/syRSRGRZ1LrD8r
         uf3YwsBT0f4bh+PIvszbePUwuzgjh+fxMlSFlOJm8H9QVpAe/k2j+0bH5OU/L+hPNch+
         2ZAe4Gd4wDSevudF8/MgrNx6kIIc2xMYprIEDk/J1A29wTl8ApQC3VUGnxZ9QRc7Gb6d
         rv8g==
X-Forwarded-Encrypted: i=1; AJvYcCXpY9Y/wVuKQKs0uOsMkfGALJIYCV5ObUYVU1UIOp8aHg+NHw4jjgUMSsVVvevGjViZuHyQ2Epvzd7ctkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw7t1RE6i3Zwt+aQ8FqLt2KWTavxI4S9FH+Zmv6FUH2c0hopMI
	IUTcP3R0wEBd2Hi0PI23OT8UH2C2ToSHOxmaJLguuGAC8wdoSJ7OH1Nl
X-Gm-Gg: ASbGncv9OPs3NC7n5+g2X8USsbyyn5pGrHejrB+VhGS5pJm77rIHuTuQggyatu0zXwI
	SdIWBicCx6GoxDEMVHSXbH/HpXK+E9S7sOxbuCCfBvuQLAE4mXmr/lRBm8choEvKSGT3xLUn4XM
	5BAui3EFbVS9ZFZ+8JonYyqvhw5b0t0VQNb5d0taOJQw/3DRS0CJQ13OBu/wr2kM9noDRFz8H1+
	tUt4fluhOgpka1dKumcZBh2saabr+Nrp5YMscSG0BwVhftsP7xV5mjhMgaRQPtfLDuvL6FPo/sl
	x2IshZrwdRr2iVmJwjyk3K32YiU18BbarVh3Uc+UBuzOE9+q5PwnM8wLhVF5vmFCs1Oc7LKoyhh
	6exNo8zebXT7RwjoTUZs7fq1twQFa6g==
X-Google-Smtp-Source: AGHT+IGjI8lAarGLwnIu1zdZnbmHobEpS+B+TI9t9/aikJCWjSJvKbD1IHBJ60jCwfCNehiVgq8wZQ==
X-Received: by 2002:a17:90b:4a4c:b0:32e:8c14:5d09 with SMTP id 98e67ed59e1d1-3342a23718dmr6989994a91.7.1758894752256;
        Fri, 26 Sep 2025 06:52:32 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be2338csm8997217a91.22.2025.09.26.06.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:52:31 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next v12 3/5] dt-bindings: net: dsa: yt921x: Add Motorcomm YT921x switch support
Date: Fri, 26 Sep 2025 21:50:50 +0800
Message-ID: <20250926135057.2323738-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926135057.2323738-1-mmyangfl@gmail.com>
References: <20250926135057.2323738-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Motorcomm YT921x series is a family of Ethernet switches with up to
8 internal GbE PHYs and up to 2 GMACs.

Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/net/dsa/motorcomm,yt921x.yaml    | 169 ++++++++++++++++++
 1 file changed, 169 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml b/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
new file mode 100644
index 000000000000..ff03bff0be4f
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
@@ -0,0 +1,169 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/motorcomm,yt921x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Motorcomm YT921x Ethernet switch family
+
+maintainers:
+  - David Yang <mmyangfl@gmail.com>
+
+description: |
+  The Motorcomm YT921x series is a family of Ethernet switches with up to 8
+  internal GbE PHYs and up to 2 GMACs, including:
+
+    - YT9215S / YT9215RB / YT9215SC: 5 GbE PHYs (Port 0-4) + 2 GMACs (Port 8-9)
+    - YT9213NB: 2 GbE PHYs (Port 1/3) + 1 GMAC (Port 9)
+    - YT9214NB: 2 GbE PHYs (Port 1/3) + 2 GMACs (Port 8-9)
+    - YT9218N: 8 GbE PHYs (Port 0-7)
+    - YT9218MB: 8 GbE PHYs (Port 0-7) + 2 GMACs (Port 8-9)
+
+  Any port can be used as the CPU port.
+
+properties:
+  compatible:
+    const: motorcomm,yt9215
+
+  reg:
+    enum: [0x0, 0x1d]
+
+  reset-gpios:
+    maxItems: 1
+
+  mdio:
+    $ref: /schemas/net/mdio.yaml#
+    unevaluatedProperties: false
+    description:
+      Internal MDIO bus for the internal GbE PHYs. PHY 0-7 are used for Port
+      0-7 respectively.
+
+  mdio-external:
+    $ref: /schemas/net/mdio.yaml#
+    unevaluatedProperties: false
+    description:
+      External MDIO bus to access external components. External PHYs for GMACs
+      (Port 8-9) are expected to be connected to the external MDIO bus in
+      vendor's reference design, but that is not a hard limitation from the
+      chip.
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: dsa.yaml#/$defs/ethernet-ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        switch@1d {
+            compatible = "motorcomm,yt9215";
+            /* default 0x1d, alternate 0x0 */
+            reg = <0x1d>;
+            reset-gpios = <&tlmm 39 GPIO_ACTIVE_LOW>;
+
+            mdio {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                sw_phy0: phy@0 {
+                    reg = <0x0>;
+                };
+
+                sw_phy1: phy@1 {
+                    reg = <0x1>;
+                };
+
+                sw_phy2: phy@2 {
+                    reg = <0x2>;
+                };
+
+                sw_phy3: phy@3 {
+                    reg = <0x3>;
+                };
+
+                sw_phy4: phy@4 {
+                    reg = <0x4>;
+                };
+            };
+
+            mdio-external {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                phy1: phy@b {
+                    reg = <0xb>;
+                };
+            };
+
+            ethernet-ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                ethernet-port@0 {
+                    reg = <0>;
+                    label = "lan1";
+                    phy-mode = "internal";
+                    phy-handle = <&sw_phy0>;
+                };
+
+                ethernet-port@1 {
+                    reg = <1>;
+                    label = "lan2";
+                    phy-mode = "internal";
+                    phy-handle = <&sw_phy1>;
+                };
+
+                ethernet-port@2 {
+                    reg = <2>;
+                    label = "lan3";
+                    phy-mode = "internal";
+                    phy-handle = <&sw_phy2>;
+                };
+
+                ethernet-port@3 {
+                    reg = <3>;
+                    label = "lan4";
+                    phy-mode = "internal";
+                    phy-handle = <&sw_phy3>;
+                };
+
+                ethernet-port@4 {
+                    reg = <4>;
+                    label = "lan5";
+                    phy-mode = "internal";
+                    phy-handle = <&sw_phy4>;
+                };
+
+                /* CPU port */
+                ethernet-port@8 {
+                    reg = <8>;
+                    phy-mode = "rev-sgmii";
+                    ethernet = <&eth0>;
+
+                    fixed-link {
+                        speed = <1000>;
+                        full-duplex;
+                        pause;
+                        asym-pause;
+                    };
+                };
+
+                /* if external phy is connected to a MAC */
+                ethernet-port@9 {
+                    reg = <9>;
+                    label = "wan";
+                    phy-mode = "rgmii-id";
+                    phy-handle = <&phy1>;
+                };
+            };
+        };
+    };
-- 
2.51.0



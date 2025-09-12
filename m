Return-Path: <linux-kernel+bounces-813093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC22B5409F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 04:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1C6AAA14E8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 02:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D19422154F;
	Fri, 12 Sep 2025 02:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEVKSK30"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA29221CC59
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757645272; cv=none; b=m+0QsbR5+lA+y5hqYB1M3kThV2NTn0RgpIxzZBIQoqcWU6Fn5jTjoAQFMqLrdBulyzPrfTi9+37CAN4wCfrZarjGelCXASVaDr7/jelXsQXQ0BTJHdHeq/szSLfhXsblLsa/cbITUvBG0SazrNgWSKUXgzKhj5ib+kHqIfNiXUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757645272; c=relaxed/simple;
	bh=oJxaNca0ovdmuYmZjer2XkXA3TvMYmaEFZFdNaFPxw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c60UuDBRprHc1XAsH5xI7yO+BTT+A1b+S4p+G5jBWD5H3vQ1ME0cc5NMmHeu+M14J4fCyxyFyTg653k4UqM5bC95KrybjAvQma5hz+2oTlmGvl1fCTAqUflACPbo87F61vjIQAeqZD3JTITlPYOxL9V0AHZIWoBuu6Dkgm2EapA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEVKSK30; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24cd340377dso9940365ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 19:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757645270; x=1758250070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxozejcHmlMrgp5l/pyBiJVMbx034MAKbgCFUAbOzIw=;
        b=dEVKSK309CHrs/AT75t/sQIuNS8RluiLjVNL7uHlTt4WZW2j4R8jgD0FBNkJmjWH+E
         f1wC7oRo+9LzCthsdoefxdnfgCJ/G3UFI4NDEEo2zenExNOXstr7oFg1fAkf1O9UQwYU
         P55fxQvgLWCeaeSr5+Gh69L8kj5+j2Bkb26vdZMnRu2UtkEC+V89t3ASPrrFHHkjdNml
         7J7vxN6mIAUZ1KX0vpAVm3YVBb+NKdGaI474ClONXUH4nykndxYIAML5aojD5VgdMe6K
         D8Ir1ZK5llLbmVOW7Q0thh4Jk8+9eKDiysRuqgvbTw6I2dIySB+R/UwuKvCD0v6sPyMB
         yaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757645270; x=1758250070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxozejcHmlMrgp5l/pyBiJVMbx034MAKbgCFUAbOzIw=;
        b=lNMHNxE4QA15NPd6CPHtKDtk9KVlj+HpVO+o2xFkGugPnbYrt33S46pV9MroHQstlI
         6d/3yVZbAg2IcBMOpzy0CAQK0D1m1doQqXIiLE2BbDaPwPEOSWJZ1HTDMzykXJ8K8qoh
         mvtvib1+87P5SKtDhGnK0BkbHRimDVUyW7nEWD1TbyWDMu3mJYReKKoKgPk3NHOAX0DD
         x+23gXFrl3oqsO0h4pTEg4irojlh8VLH05OD33NoLDMmPtpEz6+3S4pYpU9RpUCGNGTU
         9fimDHu3ADeQj/hluck4CcDYDQcnphCTDTHk+VVXwNdHRqjri27Cqe0mF3VXra7OZ6IL
         rwKw==
X-Forwarded-Encrypted: i=1; AJvYcCVDQxsT9/Ub5zQtRT0ZxHNZ24qg0qE3by1/RRgCcJZy2fMoErICY4NZe/VZQCLI62qLfaaDwFRykIfv/tA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWwtl03VXYxBe0LGDlTkxlqHZDe517FKgRkl6GT3jxMIKOA4PC
	8RS+P3qkGyQaRdpytTSELK05VNUSLWysMWqBKf+YUA8D7PX8gcm/1thA
X-Gm-Gg: ASbGncugglRujNBUUDcygksKSeZKNOYPeRNyzmX2l3go04gbTIn6zX1p3EcvVKLg8xt
	rcv5Cuz6Zg7lEnm2rDAH3UbFChMmplzWhKE/s3sZb5OPlkeatzdMkMHutJaVnxZkaGkWYwwFuAy
	V/QUTw+LOBEKEg9vmGXc6zVt+bxYYFAxxy0QS63pLQX32xpyZcpbhCpK0CqAsa/3/dhl2MXyfHS
	ly7vNCkjpl29dLeHBeEwPveLpZbdszTMEhu7mHfGYGMLSh6qWhtwT962trtN43YMBL0HbIwXKz9
	A7f0Ti5mB4rrCTznzQ30DWISxJkP6FmL+t9P4dofhV8TlqiIeu3LQypTUxVpjSQRX97Y0I09mPB
	dKZ2uYY1GvRBtYvbMeh88KPULRljikPKF4rH2egz8A/opPqenL0c=
X-Google-Smtp-Source: AGHT+IEskqrWeBktd65hhkOD1q5+PE0GWr4nmLxSIvSHqdI2VxvU2aC9ILHlNHAU98YI7hdaK2Mlaw==
X-Received: by 2002:a17:902:d542:b0:25c:25f1:542d with SMTP id d9443c01a7336-25d260792a0mr16364675ad.36.1757645270036;
        Thu, 11 Sep 2025 19:47:50 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd61eaa42sm4349827a91.5.2025.09.11.19.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 19:47:49 -0700 (PDT)
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
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next v8 1/3] dt-bindings: net: dsa: yt921x: Add Motorcomm YT921x switch support
Date: Fri, 12 Sep 2025 10:46:15 +0800
Message-ID: <20250912024620.4032846-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912024620.4032846-1-mmyangfl@gmail.com>
References: <20250912024620.4032846-1-mmyangfl@gmail.com>
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
index 000000000000..7648aad073eb
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
+                    phy-mode = "sgmii";
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
2.50.1



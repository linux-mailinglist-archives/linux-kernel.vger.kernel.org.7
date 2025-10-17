Return-Path: <linux-kernel+bounces-857336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AE0BE6927
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0AD5625098
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575913101AD;
	Fri, 17 Oct 2025 06:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4pbPrIv"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C617130FC31
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681453; cv=none; b=L8DJD6SHuvKn9dwv3dsNo1LOmYJIeSd5yz1GDPZCAdwwmGngJmxIyYi2sdAaGKjmSmP4wJkbBpT6VP6N6nBQXWnXwdU4efr7f2To8jM6LRy6P/Jt0kyLDzXDSiJi6ijvZaLKjaBh3Jzjb/VubdHqeCKepVN+CMqIpq9jJ49Bp9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681453; c=relaxed/simple;
	bh=b6ISdhsQWDnAo4VTafE6aUOK0zWblvBU832ZglgHc1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJTiwJXiwwVemS8aQwucbY1VUzCmaq3PjOalTHelnKOBBXX5trETJ576kQI5ReoZMMxoBtbXEIuVujTCTGWp86ilMqU5DAW7Qg7jOke1mVuS7iiUJcy35qsfDGC4XgLh1J7yS4DmkeLANYuV6MmrNE+01FlU3AEzT92iLtWxbRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4pbPrIv; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-26a0a694ea8so11905095ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 23:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760681451; x=1761286251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFqmxzP975EbfL7QM6VF330m98TZjzZeICik0AHkBHU=;
        b=X4pbPrIvU28tvYvGPFqO/ZG9NHHbIPTiBTQRlx9K0FU8Wp20GeWdznKCrKOjj09Aw1
         xzYPGg/QFXqXN0NEimK9c7PURThozw2g6gtwKkRJoKGLeM9M1vTK4tFJruoOwyqFSAeu
         AmwyWXsaTePsJ5Psk+1xpN+REhdmlE9V1eYx0Rdb5AuzCRligQIncr2X/9TmCQU2x5AS
         rk9sLhXRoFpJzvPSD7ivkHeAIW+NqGjj7e26FyH3wEaBl62JQyQKQAactV8dFGuNmZCh
         P/IJBTFuekLcLu4uQYrOX5GOZudTqDTrOXlW2dfTK79drzkTAADY6oEeJq23zjUkEDPj
         GEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760681451; x=1761286251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFqmxzP975EbfL7QM6VF330m98TZjzZeICik0AHkBHU=;
        b=aslS25upa4PnO4odbHicdDldJG1zWG+7Upo6mbnytwfriVY3q7P+3uJmNWE9FSCIfy
         TGrBIIIUcjOXSd5pdWHSqReyKIVwAXBAByei1BUcYMBYIunm7CGJ2D2VdGjuRUColYSB
         29U8RNEh225XHZ/6oY4Z4bSvLIaDzTGgdR3VuYcCPJTFgy0TbjAhdgjUOg/jt5WBqSxK
         d+0GsxXRmg/MJxoTRm8lCbYzApPEC+PmN8ggDbUbhYhA6hNkh5fmCVfY5r9L1hxj8e+J
         iXdC0vTLC0BDBPFfm7e2j23NQ1pPyNuMuPA596ZoUftt//Ut8GzvRGnebnKBnYG2cHRk
         /QgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwLqaqvq/dyJiXHQa4E+cHfRNJ6kq54ZPOHbgARtTmvEm6GrEB5l+NR/3AlmpZTWbrGkzk9ffUnhLIcmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdW4hQz7Ns+13xR3j9b8oAP9gr0wI9BBE9c4RXXDUbGH/YQG8p
	99CBce1/yAWhf/5puF5GHUA2cqWH47aYv9P5HAE/snKSmDVBqWpzSp+4
X-Gm-Gg: ASbGncvxjqsQVWnAPJFyhnizJt1vQvtQq4Jl4IQS2Xb+Z8gXnQeYkzstZ8a9ZsbmLKU
	pYIlUcM69RDb0kdWpJjY0E0c7lSeFIQxWX5yhIcV7dxpjImuKp8o/kUOSsECQFZT813uGI/6AiF
	FTSovUPzDslx7JtE3I03ypA5MdvIAPxDqtLMUGnnoUzrhDnu3TXW7d1w5qj76qxIbnB6vF3nDGY
	A6p7AIh790QFfc8aWmi5Tj3ovEX7fd9hZxcGG/MveJNFY1180o6dhq6ZOsCJX42vGZp14rNUdUv
	No9ku53xdtZRQnHAnq1xQqHHqfsOQHNRc8IcmQiMRopOF5atRaqCF6QL/W4gfE+FDWoCa7Re5EA
	sGc81E6m5flIatzbQSw6cL8VqswZL9+kwHGGVWQCUWuyEkHktIiac2X9glcIA9B2VPBGUEga/F5
	O4eh9sKDEd58E2WMXg4Q==
X-Google-Smtp-Source: AGHT+IEbfafOqlHvmubzjeFhwMrRL++E4DsnlG2NaBtp2XHRb+HPHPG4L/g+P1Lb6TZAWQgcyCLU8A==
X-Received: by 2002:a17:902:d503:b0:290:91b0:def4 with SMTP id d9443c01a7336-290ca21635emr33066635ad.29.1760681450983;
        Thu, 16 Oct 2025 23:10:50 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909938759dsm51315475ad.49.2025.10.16.23.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 23:10:50 -0700 (PDT)
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
Subject: [PATCH net-next v14 1/4] dt-bindings: net: dsa: yt921x: Add Motorcomm YT921x switch support
Date: Fri, 17 Oct 2025 14:08:53 +0800
Message-ID: <20251017060859.326450-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017060859.326450-1-mmyangfl@gmail.com>
References: <20251017060859.326450-1-mmyangfl@gmail.com>
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
 .../bindings/net/dsa/motorcomm,yt921x.yaml    | 167 ++++++++++++++++++
 1 file changed, 167 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml b/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
new file mode 100644
index 000000000000..33a6552e46fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
@@ -0,0 +1,167 @@
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
+                    phy-mode = "2500base-x";
+                    ethernet = <&eth0>;
+
+                    fixed-link {
+                        speed = <2500>;
+                        full-duplex;
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



Return-Path: <linux-kernel+bounces-815038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FFBB55E78
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 06:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F941CC1FEE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 04:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D55C2E11B8;
	Sat, 13 Sep 2025 04:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awMIp+tk"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5132E0B60
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 04:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757739051; cv=none; b=GKHVLMBWxoUF6KPGk26IfPvPwBITGR4baa5MDhfBBpjhaKd7qqGlyW9Hm9lWCVnByPbSNL+YKn21j8B2GrtgUNK47bx2RMJajLi8F/6dEvCN4N7FBJ/Mt0DC9biiO41Zx5dzQaSkXBnnC9fbNipjd6ERJFFLiSiG4y6Mldzoytg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757739051; c=relaxed/simple;
	bh=HOk54y6OqjGQzjq2mDerj8pXhvjD5hU7XhoeSO8pNzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SvQttBExGKxIkx38LdYNNSa4ghbibncuq++QhHQe5gi2QqHt5i4TQ36Lme345qIqK+Dv6whpszH8MALE3MC0JLzHAbb1T2cE8Zb1Pm4jr/Qa6mm1QqTIMeOoEqodxd7SkCUqBP8fKhA5Q1xSQROhZj84K8s8Efyc3sV0KPExsP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awMIp+tk; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2445826fd9dso31240165ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 21:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757739049; x=1758343849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isdQKDzL0iCi7UVp//a5ZK7jk9WeZbzylsZwifxaWLk=;
        b=awMIp+tkyJsuTGBXQeDyWnbZUnuIMfRvsFgS6VKw7flXdY8bUrDst2wd5sVz1w9W5y
         8Khm7SaNUjRSx7Olzo6OpIb7avgv9BKKmup6ww/r9y52SDQWSz5uBAGr7SSoKHf7SbpS
         x/7Up7yYoxIGHKaWe7JvLgl/l8o1yoUEc8xQ1tFgMaZWHAx1XgnVa/Z9z9fc511uQUYM
         kwZCa7yBynNLw+KBkYlTFBWppMV4dgMj8SHRgXDnGo/HxXs76H/uMASQHSDc/jhHxAYc
         1qI/awNJE3jPwOLvoRyXCb1w+bJSVkhAdwh3Rj5aNyctsEnb/tW5JQ8VS+Yh2ZEY3KGm
         D1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757739049; x=1758343849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isdQKDzL0iCi7UVp//a5ZK7jk9WeZbzylsZwifxaWLk=;
        b=Y6nN17FmX7jgViMuZ/PQIWJHwpHSz5uLZk1EV8M12LL54A9w5284G6m8qcjwDpaPUM
         TxFvtrJjQ7JGP6P7NaT4jkdDYFuqMBeRXIHGBSi6uOi8GQckH64kc8g1mKSwUUtEsc4w
         PNBDl7dGayNdA+d3AZAJo/6p/5jHJggkYQ6JllU9K+vGrDdKODhRNSnBHe57hKtm/gH3
         QaHbHZHHGEHBUSbrRf7vaF4gCmUxjSXqg0PtDL2Xlf8MGSzk1aU5oReqvSusv7C2Hy7h
         sMk6qC5quz5jnhmwUVAC+WFPLJsmwy7jlhs5vunEZOkbCYLUgMr+ISUDtgQmkp/4Rffo
         WZoA==
X-Forwarded-Encrypted: i=1; AJvYcCWSHKyyT98flDeW4DuMrla5BxV3YyZOHi0a3h3O5jrBasd78rogB4U82QvWBWp8Gbf6VWgcJ/3PyL31MDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkXsmtZyv9DJ3Gu6CLS4pRMFy+svCO6jV2oi9nq/+uhUGMJ5NR
	GEfgFN/InyOmINLHWEcpHXrQEtN/a8vxf6rLVhxim0yuWgnENSja8/SD
X-Gm-Gg: ASbGncu1MlUNJB1/BYDdT7sGHoJFzoQDYjHiKHRKN+FVDYxk8aMCtHDZpVWxYc+xsVI
	QPYXCxibaL9hGptjWS0aUFAWAVrWpi7PmARH46kcDA03cCDSamsrZHkpJhnVM9DnOgQH3vZDQ1+
	+JrWE1QepLBeXs3+roxtsUtAkt6CEQz0XnZPs9SO4R+qXBd8bjbcLzvwfkHbzLhtPmLSRjgGR/t
	R+a29FBcHyYgvlntNDZlWFAaKIFtWZ2r+S8OMGuiEWGjNrvkzc/qyzDV1Ep/5kmuiZRHGH74+FS
	hwEONhuG4i50zAnd/k1KcnttJbZ4hc0oLInttl5yxdxgM5ehIG0lRq3O/QRj/Ou54b54pEm04Uk
	A5ENOEYwcWWHmHKJ7vPSrl3MzzcQxRw==
X-Google-Smtp-Source: AGHT+IGIKchvyXxLABK6VyTMeaLQRNxHbQkYh9SD6HjwQydzb/kzaB9YXIHqajNiGCv52c8thm+5bQ==
X-Received: by 2002:a17:902:d2c2:b0:248:96af:51e with SMTP id d9443c01a7336-25d27d20531mr72081065ad.45.1757739049494;
        Fri, 12 Sep 2025 21:50:49 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b20e01esm65139775ad.126.2025.09.12.21.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 21:50:49 -0700 (PDT)
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
Subject: [PATCH net-next v9 1/3] dt-bindings: net: dsa: yt921x: Add Motorcomm YT921x switch support
Date: Sat, 13 Sep 2025 12:43:59 +0800
Message-ID: <20250913044404.63641-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913044404.63641-1-mmyangfl@gmail.com>
References: <20250913044404.63641-1-mmyangfl@gmail.com>
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
2.51.0



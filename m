Return-Path: <linux-kernel+bounces-827273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EE6B91562
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9235B18A4D5C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F88930E820;
	Mon, 22 Sep 2025 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNFItJxS"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E5930E82C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546788; cv=none; b=XhtJF3fc0wT0vxMWdRZuIRz56FNev8Uo81g+0g45URVE4/ueEqfQSVTw8/YmkCN18apbuL7vBbSLvqQA5lIxs8YcdCPZfn+AGsSb4aRb9feZu+vlmzpLs/1vlgrUpEP2reWMcwCdkou4IX6YVdv81oUMpZTlLIt160/jW6GYRjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546788; c=relaxed/simple;
	bh=60sKW7i1vbbtY0FuzPNlPEuK/DTNRLiRrb1M3U5kNUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uitin39wHqx5OWyjKTUNtcCjsSNLaDomimoD7GMms2oV6oP1D5eJk40haRhs4w/+bfwYX6rDS4GO4vITJE3dRVAQhEMSpofwZ3uJo6tK+6dM+h0pUOIhYMSsv8mmCaNbzrFPfd85hXPMm8Zc1/8PMkLEVEbiHWJL6qJ63/vj6RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNFItJxS; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2698384978dso36694195ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758546786; x=1759151586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcC9XUY8FVCgBMwswacD7pUTLZ7aCAKIG4tpodOwdGI=;
        b=gNFItJxSCyvH0CpUxO9BR9dJ1CP8WL8cPSehUt2rsMkqUUXjZDB4+WqsAosmUVBw0H
         ra0QdJcEUEG/l6tazFgeHJDpuNg4bA+YVIKYQJ5RxCgL5MLuV55QZ/mWLPT6lpNhAnmA
         ZdqjBCINixkZZCm2QrRpGjwVcYfrU834dS2WE2jHw2WcDNUTATeH7Jy1ZEobrqBc0/DZ
         ibyfSZFX7r8CLj6bNmZ8Jx4ycueKTseIukcgGqEHf0myaWJQ1bh8kaRQjPfxKaZvzoKK
         56b1oJf351MRDZbtIRmG7uGyl7yeaqDTz45200PqI5i4zcpD/waopdZRdmY88S2JhJ3f
         hsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758546786; x=1759151586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hcC9XUY8FVCgBMwswacD7pUTLZ7aCAKIG4tpodOwdGI=;
        b=qszoRkSM5GqJ5L/3SHYppnqKf+1Pk6CabDPB7fMInWvtPECyPYuP5Q24sbkEq6IMyQ
         /bvb3j1QtPTLl14A1RGj3GBq8Z479usmm+Xx1kMbHWjiZfj0W61/nyAjmdM1HPq9P72X
         HxUwIsLsX0DOO42QaX5wdISHJqkKxo/+9yJYU20c4/YALKkU9TVZ212+LVk9wpHqR/Y2
         Gcg8F7UNMAovLJucKiZnO0o/0pSI2usvByn8Vmz23bNZrci1aHWINMsULAE/p/LAsn5P
         wvGr0o6cXWeIYrltJWgOi6+kfK1Bv6/DR8pBOjKqWRWooD2GRy9LiTyszYr8k7wa5Rne
         impQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRD+Ns1WCXaCg2mPmYGaacZ596GF0cRxGJDWyoFd9WvrEPJyh6tw6VVcD1TmviBMSLI/+KE8RZAGOMIrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YywOoJqVnZ3ygl4UjoVRrantSP4XYTWW4lPtv9UfSUPkPu5pQrS
	+EdZERNcl3G03njYW4NgavXiQDOiEiHQBUyrA8vWaqMpkEcOo53naF/5
X-Gm-Gg: ASbGncsb+58uszAzYkBaahcWCzN5dkwZRcwa7qc/ahwqIlnhwtViOBBWDAZSIBNYvVb
	GIISAQ11cSJGVze0WNuLH1XZufL1Da1pSRHqYwfW7l7Qx/ehAcyyeigqLUW4doMh/j1ngJEs3Ry
	h6rXzdOWoQMLRULZTrEfP+01waXGnKxY6ay8p82Iccyo1pUam+b12TruCKHhoHRMmXerVWLcSFD
	d86qD3ZxMqxI4RMS15W2EhBqP6JkCQP3hhJOI1PRe8ZJLDIQYHTX7gP7Fk173xMkJsjYCV7Ym3t
	38xgiscR8AqGbmrA+L3wslgQ9LEYGGrHCDGY2CpTUMkVjmp/VgYlKXyE6YSBSOqY9nop2SdmoaS
	8S1zmqtXI84e6KpSQ50dpnPXGkO04eQ==
X-Google-Smtp-Source: AGHT+IGFTJtSRX8IY/TBdGJa+aIaflKvJYjPnVoFytK6InI2+78W4kFt4SIKFk6Fxg0L8uAVRulAFA==
X-Received: by 2002:a17:903:1b10:b0:24d:64bc:1495 with SMTP id d9443c01a7336-269ba528961mr145240865ad.41.1758546786207;
        Mon, 22 Sep 2025 06:13:06 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016bff2sm130200055ad.35.2025.09.22.06.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 06:13:05 -0700 (PDT)
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
Subject: [PATCH net-next v11 3/5] dt-bindings: net: dsa: yt921x: Add Motorcomm YT921x switch support
Date: Mon, 22 Sep 2025 21:11:41 +0800
Message-ID: <20250922131148.1917856-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922131148.1917856-1-mmyangfl@gmail.com>
References: <20250922131148.1917856-1-mmyangfl@gmail.com>
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



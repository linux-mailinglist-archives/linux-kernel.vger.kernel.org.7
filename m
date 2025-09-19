Return-Path: <linux-kernel+bounces-824312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C52E8B88A1D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B481582F43
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1B6308F2A;
	Fri, 19 Sep 2025 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfqjmCok"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D1A308F1B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758275098; cv=none; b=mA324z67IR9aBxu2fwOHTGLUTHAJQ5/snMTK7XuAWyMLPYivdrR23azH4RJ0FXTjwxi3YTodlduq+rouIOzW47az3oHSDryi5YOujGG+nW1IA59nqQ1w2CkVjK+B1FPeZ0Jcsmjwqp1jHDC7v84rRAKKdBZYJ2AoqA6HnljMwtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758275098; c=relaxed/simple;
	bh=60sKW7i1vbbtY0FuzPNlPEuK/DTNRLiRrb1M3U5kNUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQUObZEYWgoCjIE+6wpLwLAzBy9CtPfJic1cnU67PAmIROlF40EfEggofTO1/L2uL0c0iW9Y7xO61wi+yXuuc8xvjk4K6VHNagni6TQkLSYdEjAwj5w/3c1VGXh7p5LwcAcrRpsU2erThJNbUVW2YYC3pDlVthZhtRnIrAwnRQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfqjmCok; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32ea10cab8eso1693928a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 02:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758275096; x=1758879896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcC9XUY8FVCgBMwswacD7pUTLZ7aCAKIG4tpodOwdGI=;
        b=GfqjmCokBENBrrKfls2ScbKI8UQrxQkbClD7ofsUnglnsQOLnbyZnc1ZFuwe/RDL2M
         bwIlglALGJowMcXPTl+ZzpkM1YXoJvOcUBVoa/RfFnEJoCLcfGw5Kp46IWds3u+yE89J
         sIWIzqGJY7AT8k3jXyhfjlkq32tpE/zkUsXhi7uCKg5i9ydOhFTdWGBqCgjeCB0k5oo8
         SxrAjO3XJdvrQccGO7LMC74jsgwNMdH8Q2H1ra3ZewEI+0djVG3lO1cKC17Z4YhHTS8G
         032GSLrqnxK4ftT83ts4IFNPTue29JP6fSTFy834EZVmwQ8waiWeipC+JD0djK0Nwv/E
         mf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758275096; x=1758879896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hcC9XUY8FVCgBMwswacD7pUTLZ7aCAKIG4tpodOwdGI=;
        b=gS9pS3qKE54cEz6yKTs4+8f8v+NXtrqn/1WgBNSJ/xn/d6aKWi3jeyFO7o5e6tQJhm
         tOiMCPBjnuU33gSY9tr6f2zhZvLpDtjirsIDwcsyOH+OhrvKc6WK/deSbJ3JnUKQm2wK
         ekmjJirOXm0eTIqQvHOQ6OXVDjVRksZnjdMlKrHabNYp5h9b7FKfDFSs5979apyhxNr7
         pbqu7UkCOjA8V4dtx0dvBI3Z/1ZEAtTEB3D39W5AWbz75Som2KJu5j4tV1nvyBuHN3IR
         DqCFuB0E7OwOcrEVT6mU9L9tjIde+sVkT63t96pHXUg/MZx5dn0UeinEj8BXP7CW7g1P
         z+hw==
X-Forwarded-Encrypted: i=1; AJvYcCWVH4nWKUhaUUoeTl9cx18pDP+HkcQL0DAqOy6XsdI8CZlSceGnxgY5heLOvZ7dDfBzXGU2nDXaz9oM6F0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx+nCxvdpVvuq8slPxzGNVIupRSNbJhdp4Mk7hjWrLbw/AsoBt
	/nHfRKAKDRTNdmxXST5rRD+GZxgR6aj83E4fzdwGkqMz793vWnOYGT4L
X-Gm-Gg: ASbGncsRRxnlgC3xJG+LMyJT15kDr0Uw5wfDDnROKesjnGNzYUTXslqzZqsD7IYRfna
	JrZ80Xpt5OvfH/axmL7FnO43o3dDtOL/Rr2x7iCLNAKrzGfE38bsrc2eIi4Sz2R44wEs31CYDWj
	hcVSmEmWsxq7QhtapKSeU5SxzJppROq8fMMWVWqxKw/rPz2QaSvL3evUJd2S0WQlbvHAt38xwLM
	exl3cfz1G5O/dSEdjKYsjycU66qyjlgfnZT4rLo3LEFZmD0bUixv/azAkSQukY5by3mecbq0uCG
	+4RCxCvlMDjJVuNj9mPw0SKNEtPMgFtosUyd/joerBs82qnvDxen9X/LktYPEHmJXhKAZwe4SZ+
	NCDr/OEmzBVKThxh8rPUyImDnCd7YzA==
X-Google-Smtp-Source: AGHT+IGJGLANn3BUV70y3PKTMOU/fMDBkbFttB9L9fQiojcYASW7crdwUuydD8hLGyCm/8YiUzIL5g==
X-Received: by 2002:a17:90b:3d8f:b0:330:72fb:ac13 with SMTP id 98e67ed59e1d1-33097fd56c8mr3153265a91.5.1758275096002;
        Fri, 19 Sep 2025 02:44:56 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3304a1d22cfsm6221873a91.7.2025.09.19.02.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 02:44:55 -0700 (PDT)
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
Subject: [PATCH net-next v10 3/5] dt-bindings: net: dsa: yt921x: Add Motorcomm YT921x switch support
Date: Fri, 19 Sep 2025 17:42:28 +0800
Message-ID: <20250919094234.1491638-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919094234.1491638-1-mmyangfl@gmail.com>
References: <20250919094234.1491638-1-mmyangfl@gmail.com>
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



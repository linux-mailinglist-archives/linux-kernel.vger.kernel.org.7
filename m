Return-Path: <linux-kernel+bounces-860713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6697BF0C14
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976A43A3C9B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5362FC866;
	Mon, 20 Oct 2025 11:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBLBrUou"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931802FB0A7
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760958706; cv=none; b=JGGoh3S5/a3cPAisAapxxLfgHmoCwuijAPSu5sU0Dj3TueHeLKZ5lyTgZKj33WTMPdnUbMhYzOKxcvviieBhh73jgx1rR1CUk9mk3WZuE8y/lv4GoMzQVbof+CS+ssaXdiF6jzRkUoK5f+GlrdmyIK8q9gYfn+Bjd3IRhveVXMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760958706; c=relaxed/simple;
	bh=crtsan/85sYEtw+IXIdIx1+xhGDC/R5MM3pBFiVg8CU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=To9q+BoTMKB88K4hbr4dVtFlSUfcrxsLdexD9fQWBTiFOMlNFFWxkj6RmtDjYjS945AeHdg3b/oTZIHziJ255Godk4+v3z5Dmo45DIjtiNx2TrjTCRP06QYrd2KxjTK5f9rvQ93jUan+tiiGfgbD2L+U+MAh44kkQJmTuyrkjLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBLBrUou; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-427015003eeso3084940f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760958701; x=1761563501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ET/WdgCX7blN4pSkYOyw5+NcHdAYpJFzGJ0hMhYQ6fk=;
        b=eBLBrUou5ESVx0C5jUOarV6hMOLQNpstgEby4j08LQkas9V6rSK3sAC8rFAU56Czco
         oLFAl01/GO09rqu2eyXkundb6kGDTbFXGC4Z3Pevylx8ONoDijxtVvoXnCufXoNRnpJh
         xlYDZo6hkOIrHvrkdVM/PLtGer8nNJoSmGOoZVtLSwm3xoCbffywppQtsre8Eizb+MF1
         Ub1qoxaT9dX4WW2F7abx9ZG0sJsYaRQOkvCC7v+SDMN1V58OpzapZwm6EoQd+rk/POS4
         qdmC1Tu+xOXPOKXs75dqKBJUbHCAHLqykd2D4xT2RKmEKK3gZCOJ8SCyknKcsPuiv3p5
         ZcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760958701; x=1761563501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ET/WdgCX7blN4pSkYOyw5+NcHdAYpJFzGJ0hMhYQ6fk=;
        b=loUd1RP9+jysYWoAyt03EwcgsUx3NKgmfYQXOTdAbP+BzIRQIyXMMnlVRT2Oltsb5v
         PZ9dXJFm2LLrUMmakSU2RFZsyoiCcnq7Ws6y1chqMHO2+hnfKssytQ/8nBxXhYHWvViX
         A1xz7JQmGXynYEMZJDzPbN/yrt1z4St2/8+nNko9Ythl8bYTQaIfEeUVUjORWxbbnhy0
         A0+R3S2HrCFVI7fl9SJv8OJRjfPk3weoeDNiiKVRjxMuyERkaz8Bv/Ga24mISiBC8DQJ
         GwouMMfEBAbh8UDXb1k0ljqizbR1LwLhNiV74epEhf3a1h+JePu2b6yiQ0xJff07X1pU
         jODw==
X-Forwarded-Encrypted: i=1; AJvYcCVDr3cWRSV2DRvL+2B3rcf3bDEFxWrCbLhIpS3MgBf4rNkFaxOrqKBpmEJ1MnYJtvpWIWBXgpOvVRtPbi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvilMqMJsuBFAhZvOfk1a5ek3ktI7pOox88cfwCzu4syd0neHr
	nMssbzTbGkRzMqPUX/P1yO69cI/iNy1h0MYzk4ym1TWa8WIiUz/JNdsd
X-Gm-Gg: ASbGncsauUyFS4sRPybFg28DO8d9o0mbPDRbgQ1GiSO6wvZX59L3YuDGDnH9xnvubZ5
	78G7vmKqav3fRtYaZT3lJ/PHbHH9IXXyB90gJl2Q48ZSqwy6F93cW+VaxxouhWYD70I/f6k9dvS
	I+3S62EjPBQoSQtQ7fq8J1RUrnW6el+AihYmmRREd2OOv9ial6WEa+Vzzmq4jTogDJQyDsatHt3
	SxXX2NBgOLllH0fy0H5kGsnq31XHl6LgM/tOnP8eLh1qNvjmXZkOb5M3KASScOjFweRp6n1nfl2
	COpbTq9PnCHPs3G9yGAdTkxxoXUmE+t0G6ftvP5F9NiunJAPoFm5Jqfu/mhtOrVXu5K0/uKgSJR
	A4032nPmQ412U7Z8IZz6XZOo861IEiRM1FOJuaywWAIiAr0LoqjY5L1man8LY6hcO7vpiycgUWy
	xOq2aUTeKpBXPWVFnqP81iTf6OsRc5aBgs4C3kaFneqbA=
X-Google-Smtp-Source: AGHT+IGsJGvpzKiDD8jBDErgrAbR7/9scZteiyrQ3aNod93FKhU/9cKG3+ipZMkoOjySRQFgqGSHww==
X-Received: by 2002:a05:6000:2389:b0:427:151:3db6 with SMTP id ffacd0b85a97d-42704d8e226mr8837205f8f.24.1760958701102;
        Mon, 20 Oct 2025 04:11:41 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-92-177.ip49.fastwebnet.it. [93.34.92.177])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4283e7804f4sm12692219f8f.10.2025.10.20.04.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 04:11:40 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	upstream@airoha.com
Subject: [PATCH v6 2/5] dt-bindings: PCI: mediatek: Add support for Airoha AN7583
Date: Mon, 20 Oct 2025 13:11:06 +0200
Message-ID: <20251020111121.31779-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020111121.31779-1-ansuelsmth@gmail.com>
References: <20251020111121.31779-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce Airoha AN7583 SoC compatible in mediatek PCIe controller
binding.

Similar to GEN3, the Airoha AN7583 GEN2 PCIe controller require the
PBUS csr property to permit the correct functionality of the PCIe
controller.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/pci/mediatek-pcie.yaml           | 120 ++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
index fca6cb20d18b..0b8c78ec4f91 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
@@ -13,6 +13,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - airoha,an7583-pcie
           - mediatek,mt2712-pcie
           - mediatek,mt7622-pcie
           - mediatek,mt7629-pcie
@@ -40,6 +41,12 @@ properties:
       - enum: [ obff_ck0, obff_ck1 ]
       - enum: [ pipe_ck0, pipe_ck1 ]
 
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: pcie-rst1
+
   interrupts:
     maxItems: 1
 
@@ -55,6 +62,17 @@ properties:
   power-domains:
     maxItems: 1
 
+  mediatek,pbus-csr:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to pbus-csr syscon
+          - description: offset of pbus-csr base address register
+          - description: offset of pbus-csr base address mask register
+    description:
+      Phandle with two arguments to the syscon node used to detect if
+      a given address is accessible on PCIe controller.
+
   '#interrupt-cells':
     const: 1
 
@@ -90,6 +108,33 @@ required:
 allOf:
   - $ref: /schemas/pci/pci-host-bridge.yaml#
 
+  - if:
+      properties:
+        compatible:
+          const: airoha,an7583-pcie
+    then:
+      properties:
+        reg-names:
+          const: port1
+
+        clocks:
+          maxItems: 1
+
+        clock-names:
+          const: sys_ck1
+
+        phy-names:
+          const: pcie-phy1
+
+        power-domain: false
+
+      required:
+        - resets
+        - reset-names
+        - phys
+        - phy-names
+        - mediatek,pbus-csr
+
   - if:
       properties:
         compatible:
@@ -104,8 +149,14 @@ allOf:
           minItems: 2
           maxItems: 2
 
+        reset: false
+
+        reset-names: false
+
         power-domains: false
 
+        mediatek,pbus-csr: false
+
       required:
         - phys
         - phy-names
@@ -119,10 +170,16 @@ allOf:
         clocks:
           minItems: 6
 
+        reset: false
+
+        reset-names: false
+
         phys: false
 
         phy-names: false
 
+        mediatek,pbus-csr: false
+
       required:
         - power-domains
 
@@ -135,6 +192,12 @@ allOf:
         clocks:
           minItems: 6
 
+        reset: false
+
+        reset-names: false
+
+        mediatek,pbus-csr: false
+
       required:
         - power-domains
 
@@ -151,12 +214,18 @@ allOf:
         clock-names:
           maxItems: 1
 
+        reset: false
+
+        reset-names: false
+
         phys: false
 
         phy-names: false
 
         power-domain: false
 
+        mediatek,pbus-csr: false
+
 unevaluatedProperties: false
 
 examples:
@@ -316,3 +385,54 @@ examples:
             };
         };
     };
+
+  # AN7583
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/en7523-clk.h>
+
+    soc_3 {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@1fa92000 {
+            compatible = "airoha,an7583-pcie";
+            device_type = "pci";
+            linux,pci-domain = <1>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+
+            reg = <0x0 0x1fa92000 0x0 0x1670>;
+            reg-names = "port1";
+
+            clocks = <&scuclk EN7523_CLK_PCIE>;
+            clock-names = "sys_ck1";
+
+            phys = <&pciephy>;
+            phy-names = "pcie-phy1";
+
+            ranges = <0x02000000 0 0x24000000 0x0 0x24000000 0 0x4000000>;
+
+            resets = <&scuclk>; /* AN7583_PCIE1_RST */
+            reset-names = "pcie-rst1";
+
+            mediatek,pbus-csr = <&pbus_csr 0x8 0xc>;
+
+            interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "pcie_irq";
+            bus-range = <0x00 0xff>;
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 7>;
+            interrupt-map = <0 0 0 1 &pcie_intc1 0>,
+                            <0 0 0 2 &pcie_intc1 1>,
+                            <0 0 0 3 &pcie_intc1 2>,
+                            <0 0 0 4 &pcie_intc1 3>;
+
+            pcie_intc1_4: interrupt-controller {
+                interrupt-controller;
+                #address-cells = <0>;
+                #interrupt-cells = <1>;
+            };
+        };
+    };
-- 
2.51.0



Return-Path: <linux-kernel+bounces-774893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C05ABB2B8DE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BE961968CD3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61942311957;
	Tue, 19 Aug 2025 05:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Fg5bO9GX"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D490F3112DE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755582152; cv=none; b=g2FG81lxYBIr+VJqtuM2HM3tmHnS/Mn2kRrU3V5FAtBnwZ13y2bvd7fkcPSNQPNVsAVPt7uJVr7ZlbnqJ8UFoegffhOTVgvqXNE1uIzI92SG9XVcAwS8fUNy00d8bzZbeNbviTmCd7G4hcClfDWeOcD3Yz0vmohDduu3/BEquFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755582152; c=relaxed/simple;
	bh=zvYLqAOarWrfDuYAx8SvRiKVQASWxN64GJJN+491o7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MlBETBaE/8gpC2oC7Qk22QexAO/hFDy1NsjhQlgT4Mo68mJJLzCKuNQ7e0tKqzcI2/Mi1I0dg2GJKqv+vjSUT4VsY9A5ziYkXkqdEUTaJVU2PVEKTI5JNiLbsf0oRNBxAZwz5ix/xcShCz4C9YCcG7RF67NDyPm1acfDfpu9ksk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Fg5bO9GX; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b9df0bffc3so3281511f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 22:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1755582149; x=1756186949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Cj5e9ujZibB123jMncpAMtWn8qKgxY22z4IJdc5luY=;
        b=Fg5bO9GXFziXR7XobPwKop66uGSO4CHdIheuMlus+rlSUWgLXeCXdZOv/nhuX50dUK
         iHHOVhAOMfez/Cq4VDfWmPdp47Gb4ompESpvkmyOTQrl8nAJGuvFeaW9fArBINyYQdPq
         qT5RLVbPUqes1wzJKC0MNsrnfagnCm9M58WS1eNwXdNmYLtcm4X1MxAOVPvvddIlQetZ
         DL9PaEB9rdIh5p7be1WQiV/4vndhO/7QXmTAScQE3jIgz7LZqW+eXuxxR/FIrIWk7Eej
         RNkj82/+4iNUnHiS/oAzDvlAK6ibwjct7HSyWc+ZxOjbF6AAh9kQFsWDMAIOXjgGCsfE
         C2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755582149; x=1756186949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Cj5e9ujZibB123jMncpAMtWn8qKgxY22z4IJdc5luY=;
        b=fSB6hsZAyGeoxc1fNUknW1mG235FVulQP/l6jMBG+Cs9qU6F4AtRJQfXjG3gQ5zrUo
         ORdLQ9eNEo4lxEWBBvGz43ooI6HMxMITjFrkcf59Xuth663CgkSxub/vPtdvUR4xsUKW
         KcQt45k+GxjGT5RiUx56+ik1oPQDEblUUK6jHlWJOui1S6dhu3nX0qxEKQU+/BxpORx/
         zuYmq9XmLOt67ORsTlFeZPOdpzVDBpmkLjnsY3R5+l6a6wl0+NthxgqrCGxdQjSQy242
         ix3RrObIuUw6i7x+3SBqGJ9DYHWNAg5RSAYhB14/aLT54ji/5GniMqJrTiecsbu0IOnE
         AmDw==
X-Forwarded-Encrypted: i=1; AJvYcCXtjjhQ+1pN9WFH/H4c0MHR28bnS36P+jyIpL4T639sRd02MbqNB1oCUEX67t898xrtpjyjtj8WtDJis/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ElsUwA7svQHLPFIgNaJA20sZo1yXy+gT/ATt3LmwU5UHExQw
	YohfFQQBCwDBs5SRFqDhb2QUP4meJm/+x6Sd7Js+Az1qduWeDK4+9dCq+4lzCJSvD+w=
X-Gm-Gg: ASbGncvLmcEXuKQTURK+/K3IMf4PL2TO142k+zmT5bMJPFg085FaXXcA+Oi/5X3r+vX
	N+etdDrpaPupTMwQeqlKbwQHkxRXnNI6N65+dnHcBd85KUIcDe2dD+KOM0H+1IWABz+pP5Ds0xN
	Wiz6z5AZZjGIwBSO1Jrs5lURe7gQYpuwXWb9IwMOt48XasZWfSIew70Vqs3cF4ZCF45AMWBA1fx
	xGdONcB0564qPphYR80a5paY59YcuaCXmDSlqyC455C+6QoQW/Cmx55fUm1Tje7H409GJuJRWGu
	vd3v0bN7qy1ZxKsYwzTkqJo0pFvzRGG4ie+EwWKjaDSotfDj+6fbMk0AoRzUnGbLwcf49R7QC02
	qKJKaRg++BstVAxGTNLXTglCxzulgOJ3Wtmawluhpe7vEAFEDKLC+jij9LZb2qI68HBqe9sRDBo
	gohbuwBV8=
X-Google-Smtp-Source: AGHT+IHFPZ1WYS1TRNOJs1PLvKhd+CAfSBA92Wzrc+e9qbctLs8+wOrzubrfZ9b75mBvHWVLfR187w==
X-Received: by 2002:a05:6000:288b:b0:3b7:8d33:81ea with SMTP id ffacd0b85a97d-3c0ebcc6e99mr669917f8f.29.1755582149270;
        Mon, 18 Aug 2025 22:42:29 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:620a:8b00:4343:2ee6:dba1:7917])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b42a9847fsm25097345e9.26.2025.08.18.22.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 22:42:28 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	yoshihiro.shimoda.uh@renesas.com,
	biju.das.jz@bp.renesas.com
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v5 6/7] arm64: dts: renesas: r9a08g045: Add USB support
Date: Tue, 19 Aug 2025 08:42:11 +0300
Message-ID: <20250819054212.486426-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250819054212.486426-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250819054212.486426-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add USB nodes for the Renesas RZ/G3S SoC. This consists of PHY reset,
host and device support.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- none

Changes in v4:
- dropped renesas,sysc-signals from usb2_phy0, usb2_phy1 nodes
- s/renesas,sysc-signals/renesas,sysc-pwrrdy/g

Changes in v3:
- changed the nodes order to keep similar nodes toghether

Changes in v2:
- this was patch 14/16 in v1
- added renesas,sysc-signal properties to USB PHYs
- collected tags
- Geert: I kept your tag; please let me know if you consider otherwise 

 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 118 +++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index 0364f89776e6..b7ad6db0174b 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -681,6 +681,124 @@ eth1: ethernet@11c40000 {
 			status = "disabled";
 		};
 
+		phyrst: usbphy-ctrl@11e00000 {
+			compatible = "renesas,r9a08g045-usbphy-ctrl";
+			reg = <0 0x11e00000 0 0x10000>;
+			clocks = <&cpg CPG_MOD R9A08G045_USB_PCLK>;
+			resets = <&cpg R9A08G045_USB_PRESETN>;
+			power-domains = <&cpg>;
+			#reset-cells = <1>;
+			renesas,sysc-pwrrdy = <&sysc 0xd70 0x1>;
+			status = "disabled";
+
+			usb0_vbus_otg: regulator-vbus {
+				regulator-name = "vbus";
+			};
+		};
+
+		ohci0: usb@11e10000 {
+			compatible = "generic-ohci";
+			reg = <0 0x11e10000 0 0x100>;
+			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A08G045_USB_PCLK>,
+				 <&cpg CPG_MOD R9A08G045_USB_U2H0_HCLK>;
+			resets = <&phyrst 0>,
+				 <&cpg R9A08G045_USB_U2H0_HRESETN>;
+			phys = <&usb2_phy0 1>;
+			phy-names = "usb";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		ohci1: usb@11e30000 {
+			compatible = "generic-ohci";
+			reg = <0 0x11e30000 0 0x100>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A08G045_USB_PCLK>,
+				 <&cpg CPG_MOD R9A08G045_USB_U2H1_HCLK>;
+			resets = <&phyrst 1>,
+				 <&cpg R9A08G045_USB_U2H1_HRESETN>;
+			phys = <&usb2_phy1 1>;
+			phy-names = "usb";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		ehci0: usb@11e10100 {
+			compatible = "generic-ehci";
+			reg = <0 0x11e10100 0 0x100>;
+			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A08G045_USB_PCLK>,
+				 <&cpg CPG_MOD R9A08G045_USB_U2H0_HCLK>;
+			resets = <&phyrst 0>,
+				 <&cpg R9A08G045_USB_U2H0_HRESETN>;
+			phys = <&usb2_phy0 2>;
+			phy-names = "usb";
+			companion = <&ohci0>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		ehci1: usb@11e30100 {
+			compatible = "generic-ehci";
+			reg = <0 0x11e30100 0 0x100>;
+			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A08G045_USB_PCLK>,
+				 <&cpg CPG_MOD R9A08G045_USB_U2H1_HCLK>;
+			resets = <&phyrst 1>,
+				 <&cpg R9A08G045_USB_U2H1_HRESETN>;
+			phys = <&usb2_phy1 2>;
+			phy-names = "usb";
+			companion = <&ohci1>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		usb2_phy0: usb-phy@11e10200 {
+			compatible = "renesas,usb2-phy-r9a08g045";
+			reg = <0 0x11e10200 0 0x700>;
+			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A08G045_USB_PCLK>,
+				 <&cpg CPG_MOD R9A08G045_USB_U2H0_HCLK>;
+			resets = <&phyrst 0>,
+				 <&cpg R9A08G045_USB_U2H0_HRESETN>;
+			#phy-cells = <1>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		usb2_phy1: usb-phy@11e30200 {
+			compatible = "renesas,usb2-phy-r9a08g045";
+			reg = <0 0x11e30200 0 0x700>;
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A08G045_USB_PCLK>,
+				 <&cpg CPG_MOD R9A08G045_USB_U2H1_HCLK>;
+			resets = <&phyrst 1>,
+				 <&cpg R9A08G045_USB_U2H1_HRESETN>;
+			#phy-cells = <1>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		hsusb: usb@11e20000 {
+			compatible = "renesas,usbhs-r9a08g045",
+				     "renesas,rzg2l-usbhs";
+			reg = <0 0x11e20000 0 0x10000>;
+			interrupts = <GIC_SPI 85 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A08G045_USB_PCLK>,
+				 <&cpg CPG_MOD R9A08G045_USB_U2P_EXR_CPUCLK>;
+			resets = <&phyrst 0>,
+				 <&cpg R9A08G045_USB_U2P_EXL_SYSRST>;
+			renesas,buswait = <7>;
+			phys = <&usb2_phy0 3>;
+			phy-names = "usb";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller@12400000 {
 			compatible = "arm,gic-v3";
 			#interrupt-cells = <3>;
-- 
2.43.0



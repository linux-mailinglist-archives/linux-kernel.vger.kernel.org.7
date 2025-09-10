Return-Path: <linux-kernel+bounces-810328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4E1B518C8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 905B37B29A5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FE532A81F;
	Wed, 10 Sep 2025 14:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="gKoR4mQp"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B16321444
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513016; cv=none; b=KPNy1dn0kagArRN838srfSfhQ2Erl/mxj2XPLOKd08b5epdSW+3RWvd+WCvsSZEDWpt3IT/hSLgEwtbSXVgmMmWPFlOYSj61MxzumaMDgPDN7LhcaZJZLUgFAetYHTCe1InJBkBAN/yvq5weSNq1LDY4POGd2U2zz8//9qxZKsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513016; c=relaxed/simple;
	bh=4uzoRYeyYANJD/+0zd2z9/U6fSZtKw3V2oWKfp9Fn60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nuPa8SvnDTcmXZUTdSKqabeL9IfiWKdXZJOPYRYvO0OH9MKlgqMz1FKnloDVm/cCg5X8J33VIEmc2aoOM9xVZu6BiI5cznaHHb0G07BgPCR/4pUWyuOiH4fDv5qtO/PeOsJPFRQBW0UL4PugrqJgKdYl802J41yi1LVowJ8lLfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=gKoR4mQp; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45deccb2c1eso17876225e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1757513013; x=1758117813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1/JpGQwXecoruLN45V+BbAr2VgKNoTTI3oUXs6eTYA=;
        b=gKoR4mQpe4c+zFJhacgRc5ocrSXM/gOsrG+O7P34Qkq7OP5Yk/e31KvMJIFE4G/9kJ
         rMOM+SxLEj9/O0VgeFNogZbBwX7HJ9OwaEX5fdQ3OHza7niHmH2OuIdW+3t0/h/IFY4g
         JpkcIC/UxK5mDaib1qFDKpPGsbSr9v/iagiF3RTNg9Wm7YF65ZRlCL1FrqoZmMNvBPx6
         LR6OjyPTatFl4iXno3EPdgs61guip/QHUj4JM0An8SybaEccHC0CcwY4fiBiTyfsmjUS
         622qDjTEW/DbISFAIBzg0DvQZkb0LwvCMr5UXe82PYQf/NKmPVPB0wNsRQYZM+rNxeHb
         yEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757513013; x=1758117813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1/JpGQwXecoruLN45V+BbAr2VgKNoTTI3oUXs6eTYA=;
        b=brF2fZ8EK8OLXPRXMWgCifT/a6NE5o3v8Tj2O+6OMvK+j9P6lq/eUeL651lehw+Qnz
         /30eygt1eZim+cmRQ9zuVJKb4FOfaEjEOH+E3cHqJTanlaOJe6F+Yre3lzmYj4DqzUAF
         3aQf3Wodt38OiyE/m2FkLCSSpWZ9oOhwE6x/4GenA6KftSuOrMSFy6W7UzAi75iWzy+e
         +DrQCoTYVCYbcNyWe3ryh/AarBIfIxUTQxuvXuHA2taL4tjZo+ws4e0hXu4dsD8rsEkv
         6z3hq4T+xdWU29wnyNgf/RgZNQT8+R0P3UN0CuCBt3R3wINe7TK9KQEMylTv2PmAVqz9
         XRUw==
X-Forwarded-Encrypted: i=1; AJvYcCVemUjH7sNba0PPb+1UIJXr2pHDCaS8VFYcSYEql72DQjxThdAIq0DQTJY3Tg2oRHu8oyidZkWeoMp1ZSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1UVsAS/uQgvDIPKfvBPAeY5Fwn1cxVx7utHh0d15FMUbrHz8z
	uWUawsgDYjJhlMyk6vEtfX9GWcwblKkmBaYDRRLuwjewbxtBlV3hbevt5I3ucX+apXA=
X-Gm-Gg: ASbGncuDSUqU0RoB346St6Det8h0Ln9/i6f4gM3QwmTWVyzdAxfGPNbrjGrbt8yHGVg
	bZpiALp0EE0JsT3tDumQ2AfR095kPhGyzXVcyk2z2OgBTTLfkdATd6pIdxI6t8MmuOkLZ+CE8ZW
	VhQ1F7ni/ZBoCp5eyJj+wxzdykChZrACtFsdu6d4mCoLHCPzxCoD05buvtxTcOw1U8pqMFp8QUW
	F0Fjd0JghwKZqeQQK6VLJszyQKy2Li7z+v8I6ROh6Mze9z9lxS2jagGoAJTVRdfPvSGf+U8OH4a
	cXB77weqOPU3854nTF0GllvbmGptZo/PQkRlir6gg+s94QKCEVZwFoLfXSYwOGsIl70wWbSXoYD
	Oy/hUGFTLustcTFWbThK+e96FMK10uwHxREn2QE27l318caLk/pSq
X-Google-Smtp-Source: AGHT+IF3lASbsV3g5yPF2pXLV5y1xrAF29cKuuJJ6sLpr54JprJ+ha7jj8SX8fRl8dFxLSd5fVw+IA==
X-Received: by 2002:a05:600c:c4ab:b0:45d:d505:a1c3 with SMTP id 5b1f17b1804b1-45dddef8c61mr132223995e9.37.1757513012584;
        Wed, 10 Sep 2025 07:03:32 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df804bce3sm29523875e9.0.2025.09.10.07.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 07:03:32 -0700 (PDT)
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
Cc: claudiu.beznea@tuxon.dev,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v6 6/7] arm64: dts: renesas: r9a08g045: Add USB support
Date: Wed, 10 Sep 2025 17:03:04 +0300
Message-ID: <20250910140305.541961-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910140305.541961-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250910140305.541961-1-claudiu.beznea.uj@bp.renesas.com>
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

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v6:
- collected tags

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
index 16e6ac614417..ab29b8365e26 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -717,6 +717,124 @@ eth1: ethernet@11c40000 {
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



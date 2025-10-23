Return-Path: <linux-kernel+bounces-867123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21652C01AD5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01A3C3B4A58
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0776B32BF48;
	Thu, 23 Oct 2025 13:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="dBRSuiGL"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A8A32AAC8
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227921; cv=none; b=MfIrP/9dCBk5jTa18Hd//A+sOu+SX/qA1+TKayYtPAE/Ph/msZPzFfBO2LWDI3+4hGjZRv3qQuRePJev4TF0ZFr9LpTY61mXA9FGOojhnn8uCUffZmAqb5u0lpZzaDzd0Vr0H8VCJEG9PaJGig8YrAomlgkDyZHuXKtueWrX9IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227921; c=relaxed/simple;
	bh=z87Wvt6YoFbSnJxC5WmES77DeHFkBXJ5qhn/nvHk1us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFSle5CQ3+CQoN44Rmjh6wGlSGOKlTXWJYBliI/TgDPt2Ny/Y7dipvBTSX8WNIrdj7tpthGkEnbENYfcit0y77u07mRJadjbdyLq2O+h6LW8NWoR4cUy0yJUfWzTs7GClXtHr6qtGkD2otJU6mVkeflrPW2d33QOZbcMVEughGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=dBRSuiGL; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b403bb7843eso176975666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1761227917; x=1761832717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7yahp7GEuZbCGPELhsza9+agCEdI0nJz4aKJxPM9QA=;
        b=dBRSuiGLfzphdCAytCMQgTw4T55+g/voWCCSMTk4tQe/ZHva2hDPDuwntdrO8mHB/O
         6G3KAq6DeuPpf93lxwdf5tGkiapxsTHK8Gl8LPtgy6jo0IkQ3c3v+L7sSO2RW3GhR+ys
         +9YxBhG1pd5cOSAjZAO0JM8ngCvxOqCS/GNAzuSMnaZofkVKPd/W9aYBbjqIxa25i6SG
         ijELBvkFhJL8Jfy5kNDsnWYrYw3B2iw0tmfyJlwg3PEojtR7s0Z7xM44TaERsncdnimc
         MCLfmwMNL9LDzB0d2OUKHIErjLrAbwGjBB+ePnL23ad+MIww/Bve160dI6vEoaD38ytr
         vViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761227917; x=1761832717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7yahp7GEuZbCGPELhsza9+agCEdI0nJz4aKJxPM9QA=;
        b=VBwZhIDsCWogNWgG5vYjpy7ZuBi6ofFJpoNbDtRd5BarmgEp1wwQvlMYTiGlF9adya
         0YCKEhjvhf0/fIYtnsSPHxFaBk+dppQAZUqKNIg2isZ+BydtP7YPOirAuqfkLHgezYM9
         9jDujLibOPNQQBpP/syXSS+ymOnpot0p7ckCT0zwwnLsP7sZqnP6vLgHlXra8rlvf6Jd
         45tRgB8La2AzTGFkd3c5HPURqUxaHRnoWYqBW00fMOGLMTVV1vws4nz1LJJ2XdpJoR+m
         Zi11WnqKE5iSUPiMcDd36ZDA2tcWv/nk4DJbH7Zad+Lp6bcGVBG4KKVTnM8ly+XETtuR
         3CjA==
X-Forwarded-Encrypted: i=1; AJvYcCW/fxHvZgobfEoSl2YcPJTJaYAJpSvg8KHL9+FAjk2nQ4/v76zmotHRPcMsB3KOsQ7gjI2prHJSZaxJvnw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8zNvRuZBHw9tW/aOyM1Wt4tYd3AwT6oYnO80LlYT7FnUQ7KMw
	zYc2EivLvmWTvaPTlE1x3bkvw0aXRfASwWU5gUOf0Ilf7YTRDduHsj3OMQ8bKwWjrNI=
X-Gm-Gg: ASbGncu8ILZU227GXMtkjI4dyWH98IPpG0JnTjwtmaCExHXfdvygc9XaVIi0iEhVQ8A
	YDEW1gCnWj3nTKxTAGBFxMl3Jq7m6Mz0GfFbH9Doo8iawWRw3zptyVSzfebT3tcms3ardcjCoD2
	X09SwALVX2+hwifBno2a4tg+MF4zr+UpxS8i+oEYvtQCSYD3sHk3LCuImNHI62v6UaVwwrtBKzL
	PfLRTUZAcAVBUp+/FQCM8//E+fIdgqiFOiuNBrxoveDeVoakMc/zbSYWsFMDR6cGkGZa3Hw27Yv
	rAKF9G+Sm8LE8heG1B7N4a4r4Gg0CQ1YIADcqhRdarDtE5mw4HxzvlrQ2vDlBmY2yiuSO6KRYti
	51uesHDRA9mNY6mrIEzFrsNBZe2W0ZiXU2z/riosAuCUgR3Qkl6ueBUYa8dL5nBmWMOE++jIDti
	3PaGt4tSQCOUYHacU2Wdeb0C6k0ZhQag==
X-Google-Smtp-Source: AGHT+IERQSaNZ8XWnCMAWS4myPYBzmO3iaaDa9WU1IStoe35MF/GtpgRwoWc/lAKsVo6nO1iKmmTLg==
X-Received: by 2002:a17:906:ef04:b0:b31:ec30:c678 with SMTP id a640c23a62f3a-b647482d9c3mr3234596766b.57.1761227917037;
        Thu, 23 Oct 2025 06:58:37 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d511f8634sm226114066b.29.2025.10.23.06.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 06:58:36 -0700 (PDT)
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
Subject: [PATCH v8 6/7] arm64: dts: renesas: r9a08g045: Add USB support
Date: Thu, 23 Oct 2025 16:58:09 +0300
Message-ID: <20251023135810.1688415-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023135810.1688415-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251023135810.1688415-1-claudiu.beznea.uj@bp.renesas.com>
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

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v8:
- none

Changes in v7:
- collected tags

Changes in v6:
- collected tags

Changes in v5:
- none

Changes in v4:
- dropped renesas,sysc-signals from usb2_phy0, usb2_phy1 nodes
- s/renesas,sysc-signals/renesas,sysc-pwrrdy/g

Changes in v3:
- changed the nodes order to keep similar nodes toghether

 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 118 +++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index dd9c9c33d9d6..876de634908e 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -727,6 +727,124 @@ eth1: ethernet@11c40000 {
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



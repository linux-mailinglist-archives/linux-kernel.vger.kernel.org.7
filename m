Return-Path: <linux-kernel+bounces-867124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBB8C01AB7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9074A3B974B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C4D32D0F1;
	Thu, 23 Oct 2025 13:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="jPwUFSeg"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55CF32B998
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227923; cv=none; b=C9/nfG6Yxlk7jvwZDP40lvYsyLt9jDPGXHpz88zQGeCHkEsnDxoSSGhliJZV7wxQBTx53e7NnzK8gAuj/pethrmRvoquPRBIE3RtgOABnS243anp33XoFuDCmpuDQbgCCCWiuuIVa2gibq3D9ZTO24uZItkKva1OUvbwPUM0Vnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227923; c=relaxed/simple;
	bh=50hw/72TpRU+0O/DF7+aRtgAC5bIC3qKK0GLCIJ0bWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1G6ik28iZeyll0hqcWXrrVRZxoeLR0RhCYx+5kZGYTnLDDynULi/xFFnX3iRo/IYjavI8lwvR4HUHmvAS2AgU/u/zxEwNtdWYpB/wWAjsEL1Vw6JVKJltHpIX3BUMZu2MgY8FrUDXiddajZ9wn1RKj4ek3xDz9BWJWKTmpP+lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=jPwUFSeg; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-63c45c11be7so1532846a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1761227919; x=1761832719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDOk3wzJ/Csdlnb+sDEwzVll8zo5EaNbS49j4wNtazc=;
        b=jPwUFSegNA5zL2D0GbNPVyGJVe5ioYTQn6Gb66hqPUcR24NIenJE3WyW+y0WmCbicr
         GNMwqksrzBLZDyhC5Zp/XFiC3X5I1M+DOHjAehpuHTNqH3awHZEFTMKYKz9UCXNAiayI
         nWJRMT5Ou4R9ICg20A/Gcrz4JVr5s4YKgXyT8Lk8kncrXkfmciT6InsvRvrWm3YckICB
         5Ep8Im8wdDFr5oB1tyIWTBVkFexPo8rRSzZ/wqaXXsGjSY11Ggenu8OroN3waldp58wv
         Rx0GmGLmSBVBM8JsUUijJOpEHPJb9eSDA8Ka5h7uzsXVo0sxUfoJQQiZ9xPHfaOUREZq
         UeXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761227919; x=1761832719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDOk3wzJ/Csdlnb+sDEwzVll8zo5EaNbS49j4wNtazc=;
        b=PDpoWjuHpIeehMYQnJodQh2OtbvUWJa1B57GfP5u4dUzUf/kKV4ooZcQ+XsagArQps
         HAMewk059IiplVDBntBRTYsXAmQdkbeH6U3WLLX9Zo5lpNRUElPMJn0HEwWDDGLYpUSL
         t0wl4pTLlYFC4bNEGdxHR/n5tKoFUG3LAmk1WKNIVNhOGgviRRhNjYkKqB2YHdZkCdWX
         1J7O3NSDAsyhD1VNOxanCHkv9J/ytbmxQ8RU5tCyElqdprzfNIHQbgTKTvxyHwGmtuy0
         ewMa22m+RZ2M1RXXkgShPyvLR1YLDm0crFakyyIMaVtqBmsCYjwmZv4buRvQqR40Szvq
         8SXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO2zawPvFWuTTmUnxBcOV1rSqMyEuprbxv6ERZ/LFDxyRJejWiBr2mM1QC96wBwczPmejfRytRyaqE73c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRy9XYM6TuyQvOYIyGdniw0QlKbXfSKEmpTeQyZYyODCYOM0tB
	QznnMlWOTXdgWpPq3c4hSRDkuRdF6umLk0Y+LF6nX7bIBdGQ2kafgcYAGeIhLfrwi28=
X-Gm-Gg: ASbGncvgHJIQVs3Sx+GVuZYMsor8gtvhQZZhnq1wDW7prrAB4corZOmJo/GO2jHsjim
	DVwYpOVqUavCEMvzXBun6+N+IngL50VJgwLH+zdFwali5q2lZ9YUbuMuV65lxZndTr97qva5kyR
	k21Jq1klPuzaamECprlF697sVBGKFLkNTZwdYnm+IfS8PtFJZX/XA9qzb6TowNs8W8rXMn8nm1f
	zSA+mGA6s0Nggh+eiaJL+wI3y0dIGvz9xQONpLcxsoHxBBD9xeDsFgRl0aA+Px88lKT//VMWzxP
	PDx28oTNlbZ9QQHcMCWlwGpK7Kv9gh4BLL2F+jc/7832aFCKd4p0VL0BYyRPTvvmDTrXL/3DxOj
	8akgc9+99Vygv4Pf/PYmUDB2/jgNXGjpeH6tijSsWddbHX4s6qDkedpma1GzHIDYBZe9x7ARV+m
	NxPtJ30Q8WXt7zoE1qljMODeQkk1v3xhAtO27/Sv+m
X-Google-Smtp-Source: AGHT+IFBx3dgJXH4lEpxnlJJFwOwoH+u/MOZe+M6OK+FLRB/x3UWGEvHv5qUZS/pYvr0WhrpOqUmSg==
X-Received: by 2002:a17:907:3d9e:b0:b3e:3c1c:d301 with SMTP id a640c23a62f3a-b64769cb8cfmr2888032566b.61.1761227918932;
        Thu, 23 Oct 2025 06:58:38 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d511f8634sm226114066b.29.2025.10.23.06.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 06:58:38 -0700 (PDT)
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
Subject: [PATCH v8 7/7] arm64: dts: renesas: rzg3s-smarc: Enable USB support
Date: Thu, 23 Oct 2025 16:58:10 +0300
Message-ID: <20251023135810.1688415-8-claudiu.beznea.uj@bp.renesas.com>
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

Enable USB support (host, device, USB PHYs).

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v8:
- none

Changes in v7:
- none

Changes in v6:
- collected tags

Changes in v5:
- none

Changes in v4:
- none

Changes in v3:
- collected tags

Changes in v2:
- this was patch 15/16 in v1:
- dropped sysc enablement as it is now done in SoC dtsi file

 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi | 57 ++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
index 5e044a4d0234..5586dd43c4d5 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -92,6 +92,20 @@ &audio_clk2 {
 	clock-frequency = <12288000>;
 };
 
+&ehci0 {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&hsusb {
+	dr_mode = "otg";
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -132,6 +146,15 @@ power-monitor@44 {
 	};
 };
 
+&ohci0 {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
 &pinctrl {
 	audio_clock_pins: audio-clock {
 		pins = "AUDIO_CLK1", "AUDIO_CLK2";
@@ -207,6 +230,27 @@ ssi3_pins: ssi3 {
 			 <RZG2L_PORT_PINMUX(18, 4, 8)>, /* TXD */
 			 <RZG2L_PORT_PINMUX(18, 5, 8)>; /* RXD */
 	};
+
+	usb0_pins: usb0 {
+		peri {
+			pinmux = <RZG2L_PORT_PINMUX(5, 0, 1)>, /* VBUS */
+				 <RZG2L_PORT_PINMUX(5, 2, 1)>; /* OVC */
+		};
+
+		otg {
+			pinmux = <RZG2L_PORT_PINMUX(5, 3, 1)>; /* OTG_ID */
+			bias-pull-up;
+		};
+	};
+
+	usb1_pins: usb1 {
+		pinmux = <RZG2L_PORT_PINMUX(5, 4, 5)>, /* OVC */
+			 <RZG2L_PORT_PINMUX(6, 0, 1)>; /* VBUS */
+	};
+};
+
+&phyrst {
+	status = "okay";
 };
 
 &scif0 {
@@ -242,3 +286,16 @@ &ssi3 {
 	pinctrl-0 = <&ssi3_pins>, <&audio_clock_pins>;
 	status = "okay";
 };
+
+&usb2_phy0 {
+	pinctrl-0 = <&usb0_pins>;
+	pinctrl-names = "default";
+	vbus-supply = <&usb0_vbus_otg>;
+	status = "okay";
+};
+
+&usb2_phy1 {
+	pinctrl-0 = <&usb1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
-- 
2.43.0



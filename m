Return-Path: <linux-kernel+bounces-759768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3756B1E22E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAFC9581AEA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 06:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD07246782;
	Fri,  8 Aug 2025 06:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="hL8cXAX6"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87130223DD9
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 06:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754633920; cv=none; b=uZV1xpVpHYcm9+KvZT4vaplhf2D15pRLlLHVDMuRgJejTC+QEIRifE8ro+AvBa6dvqoRaxWhpwzSKh+i7xlwdGRnpAecEmZjZsfp5H/XfJgr2f3zkavtV4rzxLe7BHbROFaPppuo0yB+LYwAaNhnslZqIvZxoGKD/N6hc8Awvy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754633920; c=relaxed/simple;
	bh=K7/71SKMMpzwaGFKFzf2Lv1zWIeCMhaFITEsUbXeAEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzbXyjzHAUmQXMLp4PAwZfCsFMfc9igB8UcQNpvM0u5Ba0RIolTN4j5HyDxeeQ4/SuOhGAlxraeMvNGwCPrpeTfpDadJ8NG1TsP2ALzzTu26rVltjwKJYnUPHJHisLqmw5r0fT6028tPbb7wipJvH8RG9JNVzyEpF+Z3/UD4nNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=hL8cXAX6; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-af98841b4abso308401266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 23:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1754633915; x=1755238715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pwCItUf8lochLUJYKKJUMt5Wr88pHOpjuGrG4FTd+I=;
        b=hL8cXAX6JvHkWgBov9Qrtvi9oOWD5EtKdxLeEAQg7TZufjXWItR5MWA8nzDvawIwNV
         TjFiDaN5ZLjHuDG6zC66VRBFt1dpWmsnI144JYq9ErZiwvXkbRjUTtvKBbtibx6nYmOT
         G8BrJk8KClGHJM7nw1WbibMxhwMoFRBHTVPoOiZhOw22dBvWO8i+Kf85W9lUwsa5HnvG
         1pPh7VETvO2gIsqbF898AUeDUmRujo9PsMxCau8H/Mn35Obq8HAE+cKDx2gFQN2VhTsD
         CiW94lcuiOiSqXC6wRncYmidRXspoSEpwLlgjIyyC2/4NleXIzYMyYKD7AghiVnJWuNS
         3x5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754633915; x=1755238715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pwCItUf8lochLUJYKKJUMt5Wr88pHOpjuGrG4FTd+I=;
        b=Hq8YcANmw5O+W8yp1Hyob6mMIPYWHuIxFjtu5RU5lPzPuATNujYJ5sY08d7lu3aqDq
         GceYZM2d/Hmt7DKgfvpfKaBQtAutLF6dq76lTF3Z1vls7EyvqGyOFLQhdztaSUAqy3N2
         uy/4fJHtSlf3QazOk0jwZJyRfVGcGGbpD1oN3mVonxrWDRPKr7vLuttt4tnqLOaEXcLD
         rqWPadtPF4F1ul0C4e/weFD6B+oMVIFRty/6uI9IzltAtuCXSj8ItTpFE2NHdpr3aza9
         +fMJNv4jFXWvLzwBxH2dp09O2raj1oX1RaO5nVA4pO9MzGqLxkN+1GRaT+N1g45Ehfkd
         1Kfg==
X-Forwarded-Encrypted: i=1; AJvYcCXwFf5SJYHitNy/W77AsOlFaa+ie5jEzXSdUTBHfq/lG/aRfTuroR16YXxluFqXpWqPibOP39A0OzE1Eg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw10InFswASH0AHlfeE6zEraiwBQd9u0B8r5qjDIXsqyX+pupgy
	zAEKvQl8VToIbI+JWhGp8CsNy6/W7URuZXep6g2VrAskYq28us8n0C5lTFDshi1bsZo=
X-Gm-Gg: ASbGncu4BdDL0lIbfGUSZuvxEaOTsXmI6IBfx9jKuv3Jx+sOh5Al7uVGY6QtMfuOGmO
	AlY3pP9ZH+V+TAPxu22Qx9cMTCpVMVeOT79kogUQduLdXbQ1gl+k9CnmsmphEVX/V8OWh+5UgQi
	LPkv5B8Hyb3RV/MV09dW+j3s3+vHAmTKrWNXUXJM/fpeGLWDHhppCORheSgpvVkJ91fZkmM/kSx
	K4f1ojwZOPjTgh41L0YfJinwOYdRue3tAx/tL/OM8EAMDtUlVwwhb/HBGDrWnzcAaDXjK3+O41i
	RLz4C2eQH3qrYI8eYZ+640uzJsVhCSUHhWmZDnNtUMQQ6SPxueXeR8Y7KGq6YfsR+HTqdnfiDC3
	Bf6vOHBP61WXxhWuF6xCQldmkFu4M4T3CVhpvnpt+GnT0VGTJbJKE
X-Google-Smtp-Source: AGHT+IEmiE/zbR2dVxwuOYRcd6Is9fffLfNLfVXgzHM7b0VqeTBk1rAyyw8ui+JOUCtHEfB6xw3DqQ==
X-Received: by 2002:a17:907:7f90:b0:af1:8be4:768 with SMTP id a640c23a62f3a-af9c6342033mr152769866b.5.1754633914828;
        Thu, 07 Aug 2025 23:18:34 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.188])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a218ab4sm1440488566b.92.2025.08.07.23.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 23:18:34 -0700 (PDT)
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
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 8/8] arm64: dts: renesas: rzg3s-smarc: Enable USB support
Date: Fri,  8 Aug 2025 09:18:06 +0300
Message-ID: <20250808061806.2729274-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250808061806.2729274-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250808061806.2729274-1-claudiu.beznea.uj@bp.renesas.com>
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
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

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



Return-Path: <linux-kernel+bounces-774894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69ADCB2B8E7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378F3581D03
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1C731197A;
	Tue, 19 Aug 2025 05:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="A9Mmit63"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61193311952
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755582155; cv=none; b=C8ZwqCLpfu5pzwnFCoWZK/NsqaOWlD3BNaxz43zwOvrxwQ4/7XXEQ9TPPu6KrcQYCeVLdkLU3cPjouSlGzIzqDt3ZVwtReFL3ZMq4athELdj9VmPMTvXmOjPhZAPu/ofzxyOWgIN6vW8XJqijbnMNV/rbBKy+qKibt3IL3u7KvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755582155; c=relaxed/simple;
	bh=kvFy3LXocIZtAiY7HYB5GP3F668Ojn0zyNNhkepFRqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nymwnpjv9bssxvRxcvqzQbK7oG+InKmVpDEVZUrLT3MlF2Qhr11NLmFZ8E1QJEcoRH0NpZ+PY6eFor1xs6k8maCXaYYX21+H5GJVLgtZSB4j03hNnmA1WckgGEmGAF/EJmj2pxSkQwxxV/bQKkV/tJFtFgi4K+38zUyhOyZR1zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=A9Mmit63; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b9edf504e6so2298735f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 22:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1755582151; x=1756186951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtAQijMNmiJzhR3iqNiWjZGtdKFV/63GEvGceN77QSk=;
        b=A9Mmit63NohErCi29m3/08+B9qgeDcdSnPcrVMmF8h+b0OW0nqGe+cqNTl9i3SByjN
         yKK3PJ1kjm5wuUbWNGcttouCw1IH0G/rX5IlBjS0uEGE/2KvulTeZOlO1nDj9f/sJsWw
         DFLZlcb4pcEKcUUq3Gje9OPpNlAml3DrLRb0/EmMOI/9Hvz/0J9aHc9anqhZupbkjyxy
         1183zTLxtGKnjBveEh5MsEmPuJaHhiWHea2HQcGBAPe1GhZnfT6BMMisRKucV8SZtQ9Z
         lmB5L2QTDheHPGRHuqYL0W3uW+KONOREi2D2l2s2rb/iJpQz7Tv7XpHsDdYqv/AAy1ul
         hfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755582151; x=1756186951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HtAQijMNmiJzhR3iqNiWjZGtdKFV/63GEvGceN77QSk=;
        b=mfrRj+47fq7Vr7eFKaInUmztBcefCvfKaKpfdMl9E7STIl5GBt8seXlvDx2qWxvzqn
         +btQUtacAYrl9sWawbqvBCtR1q5/WyZRe82Z5OueFDqUH8lm+hNM7Qo7N3dUcGBKSjZt
         P4SJY5J1l0kvpmD1MlFOkDczkRx/hLaMtSEuM3W+VXc37VY4WS2J4f+yfCAqQHVf/Vbu
         tXmgquI9Ad1ooADSSF6T7xbd181AEP+wWpBWJ5TL2bZknUBYMu4yfqUKI1Y350OEtSDr
         CoRfm7KCNWrNLVGhECnEdsmssqFRRvH9Octv7QVWQD6aLT31Asff+Ay2bN7tHGazNv+2
         fjlw==
X-Forwarded-Encrypted: i=1; AJvYcCXD5c8Bml3o+QADW6+aC2G2d4+TLI7+DB+MVHFxJVITQrBTmOAjhhfUZoojObQ23iOsSrd+MdnQZpYv9As=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCe33U/zr/h979AI9kWCi2aWdA4n5F9ODDtWGtqvssQGaBwV7k
	hHgUlyMR/PsvUkuWWouUeJiMlmjrr4LK/6LeigL2molO5OchDEYaVHFU0m/fP9TrpUI=
X-Gm-Gg: ASbGnctYuV1z11gNfl7hYFLwu7VWBBlVUpdof0ognGzihQKuQpL5wELccS+bhRlhpWB
	dC1Hy5p/suyppkKBzBv4kxir5Ligl9DCGL5YdY5qNH9eOSAY1d/3DufXu3UG82Y2wR+5kdFbS3u
	KNMvslxCoy2Xv9cDD5nkD0cWdxuPQMTGQ2Wk1BH48C1yXimf28qgY+AE0Ju8dCLO0WrEWQL1j5v
	YZHWZK24wTX/UKcU5PDOnNKVG3oGEtmuYIoJfJ5R1rSmcgy/7x7zkNVeGwd1Avs97s3CRDUJrNa
	F+n54g6uq3WcZ8LQmGIW8o94nc+65YXBkxTsTgrz4awOgml1OngNGWq5ZXHRL0SDghzgoOR6GG+
	MolkIK/+anE+oCEN3zkuQUE0pyaBO55P3dWTePLS799mg0do+4o3p27xLQlt+jbB4hjgIYRDKa0
	8RPm40Lwg=
X-Google-Smtp-Source: AGHT+IE5u/Ji4OtEHAFWDMwa8ifQPzNcFhg8RELcPq72j0sZQDTpHXAZjXky2s6jwXoajRxZMsRWhQ==
X-Received: by 2002:a05:6000:2085:b0:3b7:90db:aaba with SMTP id ffacd0b85a97d-3c0e8beb485mr952895f8f.24.1755582151506;
        Mon, 18 Aug 2025 22:42:31 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:620a:8b00:4343:2ee6:dba1:7917])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b42a9847fsm25097345e9.26.2025.08.18.22.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 22:42:30 -0700 (PDT)
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
Subject: [PATCH v5 7/7] arm64: dts: renesas: rzg3s-smarc: Enable USB support
Date: Tue, 19 Aug 2025 08:42:12 +0300
Message-ID: <20250819054212.486426-8-claudiu.beznea.uj@bp.renesas.com>
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

Enable USB support (host, device, USB PHYs).

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

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



Return-Path: <linux-kernel+bounces-832174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6D5B9E8D5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73C1F4E3042
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FB52EC0A4;
	Thu, 25 Sep 2025 10:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="HQ8X46xz"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C482EBB9C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758794655; cv=none; b=mLqG9sAPLZidbxRYsu0ZqTqgicewCOTDgPlQNwKIzl9t+kAxMfwydJH9AL47jj10vh2ZPSJ8bm1smOIpKcbZmLmFpm4dWqlvefCvO1g24EGnp5oAuz7P52S8h4DI7rN0G7s+Ewu5Rl6epCmfnvjJvX3D+LTx8qGziQoMqvz7Jn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758794655; c=relaxed/simple;
	bh=XpFBJey+ByIazsodLfpMhNdQ/WoR4c/GvaYbI6wtGhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/oIQr3pRAnxBRtEZBGyEy8lo+67y9ciwWe9utjwAS0O+H6SG9oyieov1Yvij7QAYczm9fWrPdvC3kUMdvypqv+rL5DgLK/JLK3APfdkqlsOiDNTc9ey2q2haLtOOx3cVMW26hRIqns5gQ9IjeEaTqrBTbODYhp19D5zRu6mtG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=HQ8X46xz; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso794565f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1758794651; x=1759399451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6PpEMiRGTWSEM77dtjFizoMhXPMleLOSmUBWuk2Lec=;
        b=HQ8X46xznXUqJ1lKecX4eHIKWJALQ1fwUNmBqa822JxZhQ2F2E/F1Pz29rvNsaYX9U
         ahcuniN97uLLf3GhD2YrYf1e9qKql5j/cIdH83us3GFL/+eiqmdSuAhH5myFIzZQJdze
         3dsSG2WG9xkp+p7UPbNpk6dX02OLhGxOjOtBJrYtx6F44gnhfDp/TLBR/5tTVOWiWb1R
         TGC0PI975OfDlMYkMF0BHuRjykNRCCODVt+MuFFx8trbjClZCUv50Dag0VPkcvyOTIeg
         kLUOyUHJ6FOm/0lHza00L4M+601oMc4M+6S7qaNBDCtk3cR8j/KmnDeitnFFDI6fwlbo
         0kFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758794651; x=1759399451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6PpEMiRGTWSEM77dtjFizoMhXPMleLOSmUBWuk2Lec=;
        b=l0pvlVoSg4OWgmdpUM3aTFn6h4wyeKIIj8RxSSDwHdLCJmUefGolnLYpVat32a6Oq2
         wq7p65ML5ZOh+aa3aV0ccoKyoUHSkfZR+CpHlJEcEj/k7df8FjPO5FeLfBMzh4Cm0wbf
         LFiIXwNtFUq+RBWU8RIV6+bQ1s9tMlVVs14Dp2U+EVryknZKJxjSOIWhq+hW5SHcKHL+
         OFDrXBioDiBqRLKRhsQGXlgcvPhyNsfeBPZeJE+lbCjBO5OCwUbglfjYrbfkFznbQnnw
         cFTCqdC44w/5Jhde7oIk+e8bnzJnFdxEo1KGjBEpuVPpulHW8T8p7a+aJfJXX0ja4VCV
         Fz4w==
X-Forwarded-Encrypted: i=1; AJvYcCUVS0RtgFwA1aXXWSPzwVIrSDYy4BiPhcXDb9jkAltGhthORNsLpajnyOxnRxmO22JhAboVGAxP1Xkf05A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuB/iV56yGq04G++VA5dK9JGbDO8sGvrsjQlNph1d9liFmVcrd
	q6PgxSAepJISAZ7As3RynMa0jqeJsqLnJPTkV6n3mbGM6nicZl2iI+Dem1utEjG1RKg=
X-Gm-Gg: ASbGnctwU5nviRcWYUmahDEEJF8MdeW6hoPmz1O7irxcqgYxXf9pBA35eodetFLEp41
	r7vZcLPK3HYcU04O7v5Sj0f09XQSRTr3C67y3iI9Vym9fPORqmPRlmXhL98/ndgDmt2jlxhkEhi
	Evg9Kv7B816uU7k/tT8Lcdm3xFbTiRb8g2T8s9uik4ExSM/G58RBvYE2upLZt1Qml+fd3eBfI0g
	IjybG6pQ8NkZM1ugem39Autcde3YWmZ1078wM1dqf/au/TuG74gvo1XxUfwQVyMxm4gFTqFu5pw
	MPqHw8mdTQjKSWsZrYo4eMu/nUpMUo8p3ZKGhuVQx/c4PYStf4su1tVh3rnAuAORm1M7MNW6AJP
	JijOdQUfuagV/vA1F7urzL41DkuSVQhLsrJcWAoeMUDwFBsPARy8G
X-Google-Smtp-Source: AGHT+IFuvYevjM7vQzCnTge/GrcBdvmEa0etUZbryGQtO8C2Khk/jcVZo4763k4ceZ8z+zJy80YYMw==
X-Received: by 2002:a05:6000:2dc9:b0:3e0:2a95:dc90 with SMTP id ffacd0b85a97d-40e47ee195dmr2667700f8f.35.1758794651152;
        Thu, 25 Sep 2025 03:04:11 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fb6b7sm2501122f8f.2.2025.09.25.03.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 03:04:10 -0700 (PDT)
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
Subject: [PATCH v7 7/7] arm64: dts: renesas: rzg3s-smarc: Enable USB support
Date: Thu, 25 Sep 2025 13:03:02 +0300
Message-ID: <20250925100302.3508038-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925100302.3508038-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250925100302.3508038-1-claudiu.beznea.uj@bp.renesas.com>
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



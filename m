Return-Path: <linux-kernel+bounces-867802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EDAC03864
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 23:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14B161A075EB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 21:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C4A29BDA3;
	Thu, 23 Oct 2025 21:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/k8Ld/D"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7EE27FB2E
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 21:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761254624; cv=none; b=NGBxZA5CBqrg7aRvfXFDr89lInh3i6cBtAyp/3ZPLK39y0IFqfeo2OFTxmZsihsmn00+xgacOnQ+whkYWJeh07zuiuaXsyfFz5GN+NaG5zUcogg2L19zXASiNVmG3tQ0xdqYWnmuG4N4b1b9x1IpkbzW1wOkzLrYtWdqAMnWpWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761254624; c=relaxed/simple;
	bh=b7ftMXztmPiXn3Lm2lKkQ4uqvmXty9CYVaot2trxCVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AYtTPnN8tEk2yWMSGWLICqM8Cl9z3ieFECCOKXdanqvBn/v8bYo+IIHPf9O4q4hvktCchX4ov1h4uYnDxYW3AZKX7NaysI4YqUASKe06Zm+8+TSqFVbimQWyU5LQ+axITHwZVn3lXpY9/MUqvjWYkaa/3LW4DJb7NrZX+69sGmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/k8Ld/D; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-26a0a694ea8so10203485ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761254622; x=1761859422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cKvN8vI2wqRAmx/29tE2NEormg2Ex4xdSESzpSEv/Y=;
        b=e/k8Ld/DfLltHavQJu/ATLkIc9QBDPy+DekbbOc8rJIQcgco5P/ahB8o24DIXhGc7+
         oRrKw6VB4GMgWPHfqQpuKzBExwyEsXgnDPhFPPRpS6kdpaSyhTHwN8wMbd7hpf2k+aVK
         tVw3J6FgE9xwiL3UCtxkcoMWZARmstXmSiPFgvkmzB2gxSQY76PeRksyOF/Hi80eTVSq
         kLjA4lneXRd+P7XRBxKzxgxLylrHUOIZEQqlFrr8VzSA6dXEDpp6PciLo0/hlDm3myFw
         q6lKEHFzzQHEOK3838FliUaYRabVKCJLPHe2V4AuQiy9Aune9CNM3QPRa9bUARtFbIj4
         ytpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761254622; x=1761859422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cKvN8vI2wqRAmx/29tE2NEormg2Ex4xdSESzpSEv/Y=;
        b=GFMp9RYcoQUv74cadpAW1daNGuejzzA1prs3rHeJaWOYBEXk+vgNeh/0xEB6O2IuJO
         zwYSE2BBJfSB5tLVGQJ+u52PXWOh2ktmI6yxcReCFjPvbFt7nckZwiQkFTt+tejSAww7
         VuppqzFGW2DJ8o6UZAPcOfnzVxUgUl3KLQyjBD4agRpEZF24QpyI9xuxRLVaYxh3lvz2
         YodfxyOgsDaX7pq4csOKYygiVq4fq3tUOC8d7hrZHZGem5djonUmK3+oeF7kdILceU1w
         5OjV8eR+gbqRnOZxA3zmuSMUCYbsJAcyh/n5A3/e500sKhvFO5bmaALmZ+O7knkTgb6K
         xAzg==
X-Forwarded-Encrypted: i=1; AJvYcCWlsFtcmPBNCEGRazKrNbeBpaN+Pf4LJiPSivw1PaDyArPB2iuwPop7w8Rfk/nCIJgGlJ9hdIheHYiCEtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbI/amcSriYqzKwFw9cZsgFLPTN1BdGz1Mvo8FYRzrnlq9JanA
	Os3GlwBbqzRPHv5MRjmZO8RAmIvF6ntWKfsG4AzdshPV/elw37zeRfIH
X-Gm-Gg: ASbGncskh5rJSWV4o270iWT5RNneZ4bsSYSf9UolC2rycDZAJEDXUA1ziCG+W1ZTYaO
	5HvraNKj/gJOJEUQJl69lS6GnbVS1mmV40SfrX/gWOaich8OAJTJY/56xpc9tZH+kpC3mkx9KNW
	Z6ksjDI37CKyHAvLlDuhCunptO3YAfWSBZMMcnPUIhFWivjOQ0zF3qz92L7ZPUf8FM8nx9bFXC9
	qsqpUJvXFDoqDPx5eIGhX8/1tGsYUMFMcYjbMWmgY05GjHD6BlmT9v2+3BZ+drR9f/nFPzibikR
	m+TU7cwagaKy8GY86onV/GiSjyxvrWII2FpBl9e48TQL0pLNvdkET/so5cBYjHUiZmzEtNMYBbM
	ahcBJifFiTMhjIlKKZyaIH8gvNF1d7f/nsSjJfoRC+QnQfmXf4xHZy7ZKGlSk53lVPRipvn8tNm
	+ebWxci4Rr0QS+rnpQytQ=
X-Google-Smtp-Source: AGHT+IHLpRymwxlIY49ur7/eBpA0+xSc6MFYG9nQg0/RBKGpI1hkFbbBfk37IK7CSagsTjoNI9nX2w==
X-Received: by 2002:a17:902:ef4c:b0:290:7803:9e8 with SMTP id d9443c01a7336-290cb659d58mr328809585ad.48.1761254622394;
        Thu, 23 Oct 2025 14:23:42 -0700 (PDT)
Received: from iku.. ([2401:4900:1c06:ef2:36b5:9454:6fa:e888])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dda7949sm34306965ad.3.2025.10.23.14.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 14:23:41 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 3/3] arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable DU and DSI
Date: Thu, 23 Oct 2025 22:23:14 +0100
Message-ID: <20251023212314.679303-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023212314.679303-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251023212314.679303-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Enable DU, DSI and adv7535 HDMI encoder on RZ/V2H Evaluation Kit.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../dts/renesas/r9a09g057h44-rzv2h-evk.dts    | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
index 5c06bce3d5b4..3e314f397541 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
@@ -34,6 +34,17 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	hdmi-out {
+		compatible = "hdmi-connector";
+		type = "d";
+
+		port {
+			hdmi_con_out: endpoint {
+				remote-endpoint = <&adv7535_out>;
+			};
+		};
+	};
+
 	memory@48000000 {
 		device_type = "memory";
 		/* first 128MB is reserved for secure area. */
@@ -90,12 +101,36 @@ x6: x6-clock {
 		#clock-cells = <0>;
 		clock-frequency = <32768>;
 	};
+
+	/* 12MHz crystal for ADV7535 */
+	y1: y1-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <12000000>;
+	};
 };
 
 &audio_extal_clk {
 	clock-frequency = <22579200>;
 };
 
+&du {
+	status = "okay";
+};
+
+&dsi {
+	status = "okay";
+
+	ports {
+		port@1 {
+			dsi_out: endpoint {
+				data-lanes = <1 2 3 4>;
+				remote-endpoint = <&adv7535_in>;
+			};
+		};
+	};
+};
+
 &ehci0 {
 	dr_mode = "otg";
 	status = "okay";
@@ -161,6 +196,42 @@ &i2c3 {
 	clock-frequency = <400000>;
 
 	status = "okay";
+
+	adv7535: hdmi@3d {
+		compatible = "adi,adv7535";
+		reg = <0x3d>, <0x3f>, <0x3c>, <0x38>;
+		reg-names = "main", "edid", "cec", "packet";
+		interrupt-parent = <&pinctrl>;
+		interrupts = <RZV2H_GPIO(7, 1) IRQ_TYPE_EDGE_FALLING>;
+		clocks = <&y1>;
+		clock-names = "cec";
+		avdd-supply = <&reg_1p8v>;
+		dvdd-supply = <&reg_1p8v>;
+		pvdd-supply = <&reg_1p8v>;
+		a2vdd-supply = <&reg_1p8v>;
+		v3p3-supply = <&reg_3p3v>;
+		v1p2-supply = <&reg_1p8v>;
+		adi,dsi-lanes = <4>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				adv7535_in: endpoint {
+					remote-endpoint = <&dsi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				adv7535_out: endpoint {
+					remote-endpoint = <&hdmi_con_out>;
+				};
+			};
+		};
+	};
 };
 
 &i2c6 {
-- 
2.43.0



Return-Path: <linux-kernel+bounces-883654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD5DC2DFB9
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 21:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D994F4EE3E6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 20:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9288B2C08CD;
	Mon,  3 Nov 2025 20:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0Mpr3v6"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C5329994B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 20:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762200281; cv=none; b=k0LRxNBae7W23r9qD1SuIkhjBp1VVlzIMPr4wSNu4/4vpgoS9UFxQBof32JamiXog5CGDxQPg7b0tB+fO2VJyazSR6Pdnsgvkdl0T+nqxnFCvVsgbHc/ldCpoMC+ydUol6Iq/mIDXiQ4w2uY/d47icelu1WIfHmI5iPnpL5ZlEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762200281; c=relaxed/simple;
	bh=AZdYyx6RpwPUgCLeQLU11abdKBjIkYuZ0XaZ7R6y/uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZMvV0hFiJX+xXtiimX+4Ehdzj5RQ2oOTHl7mZvs54AKGxF4UFletiyhMoGkvlNg9PLYP8PW/jt3218kwbdw2C89roiwc8Nwh66O74VZV/CLudxAx3itl4+rmFGZ4oRbuQeEqf3AR/5hNkgXzK3XSS8bqjLDjMW9Q3mAAFEGrS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0Mpr3v6; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso4725484b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 12:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762200278; x=1762805078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KU8vOhsYeve0BAEDeA29AU6RRX8D+x4TzBHh/hEXcc=;
        b=D0Mpr3v6ChDffqntNNMvpdenMYNIBb0SXNXQPp/gayn18vMtMDioKMoA0+KOBc4SXd
         tEN609gMwyxBhF0aRnc4HqSQpWHT/fWCqSU0v9BSl/aTNpzZFmgcGwx4+K6KQ97lCuew
         UqpguQxgJGUiw9/s+t3vw+mB4vRgxk+J2dePSR8v6mJ/EWxIRZ6jqT1x9fPRWFsrek3r
         gl8qdUcy0JZxCngDy9aijM2KOYdCy0rjUq5KpfCvEf2MbV9/qtUhBOhz0MLONEMrPlAz
         n0EWr7gxmrlHnz4iRDNW5UE4XtK9xV7fi8xmQ0Ubsc2CEBdhNONcOgc93eus9unevxk/
         ROHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762200278; x=1762805078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KU8vOhsYeve0BAEDeA29AU6RRX8D+x4TzBHh/hEXcc=;
        b=m12M1teTtGDhuC+b8oA1ygAILZzcNNkMt15aMF86YvIEkXe4uouhNLf/GqZqWDHqWT
         yffk5zOVOb1FXnXTbEy1cte5JmlllB+DVtuznh0X+6XPoVR6atzD5O8O5jXDM/c+FN/7
         o95YBPgCQ8khea1Mr9ajKDMlV9VQpVooAHsRAIQHKjChdVtufNCR9RrXpIh858fql6o/
         CxS25JDfQvI0CeY6IMuLmogbdGi9QfIP6xOjyJ8fRRMZLTV/Tz/zVfBoX9bSqQ609McU
         +SXLj5kNEi2px4qdRHuHpVZvPUisY5SrMxAgEcaOj0ZgjaokS/KoEkZsrP84i2qW1nzJ
         p3xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkkt9JONJIsEKyaZ63z+uO6l3ooWMhDaWAagcnDNKtjRBJ5cIA5xMTA/mhCRMUl3EpqeVXCqcuSgXaIeU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6OsJmSYPf4HvTUcD4p8ExsO1Fim78YXplQ8awDLmFUYf+NPz1
	SOawwq11ITrNapiOt8BuF3nfFCPFGd3Fxt2WDMt+UqpfsKw5j5IN+2OD
X-Gm-Gg: ASbGncsU1y9K2dVI5H0oTJIK/kOBd66Le116FtOBtcIL2iE2YuEwVPff2a/I5vlRYiS
	eqsSr4iAFK05Da8Ok488QBlwSqZPoQRh8welaBLTcAlo5tmgWFZhBKUh8zhbSUPv6WJlpgxAnNC
	gP7dlEsT+HfuuptDy8+WoEaDgH58lR00+6n5ORfXXKGY3cnurk/bP3U9e6DrAv5fSTNC6LWPDzt
	hJpwHhecQQcSrrxxRYhWlNkGR+0SiaxdceScaotdxmjrdHdE0So3C1GcF+6KcUcYPBalTLOEPms
	fzApSY432Jm93USfhDbkb24Aaf8oKSHdFrLigjPh1Sp2ZQZmPj81z5a/Tkh6EXNRHFol6bQCr/x
	P7n3kQzowJjpJVCskEpUA1gN4lZvD7eNMi9P6VAHuxRADGnK5EiJCXk4XDFQdWLiTv5RIY1ilPJ
	7JI9YitWYaAfhMaOBuL8kIgba+kV0PPFI=
X-Google-Smtp-Source: AGHT+IFaGFmj5djONFtqpiguTfM//9A4h/IvZW11bx86sItz9BafR6a9BGtxwXan7fS5UfrTlhSXbw==
X-Received: by 2002:a17:902:e5cf:b0:295:7b8c:661c with SMTP id d9443c01a7336-2957b8c67cbmr97452575ad.26.1762200277157;
        Mon, 03 Nov 2025 12:04:37 -0800 (PST)
Received: from iku.. ([2401:4900:1c06:600d:df45:8e1:7a61:1482])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952774570bsm127494895ad.99.2025.11.03.12.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 12:04:36 -0800 (PST)
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
Subject: [PATCH 3/3] arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable DU and DSI
Date: Mon,  3 Nov 2025 20:03:49 +0000
Message-ID: <20251103200349.62087-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103200349.62087-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251103200349.62087-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Enable DU, DSI and adv7535 HDMI encoder on RZ/V2N Evaluation Kit.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../dts/renesas/r9a09g056n48-rzv2n-evk.dts    | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
index 066e66b5d51a..5459465b81f5 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
@@ -33,6 +33,17 @@ chosen {
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
@@ -82,12 +93,36 @@ x6: x6-clock {
 		#clock-cells = <0>;
 		clock-frequency = <32768>;
 	};
+
+	/* 12MHz oscillator for ADV7535 */
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
@@ -145,6 +180,40 @@ &i2c3 {
 	pinctrl-names = "default";
 	clock-frequency = <400000>;
 	status = "okay";
+
+	adv7535: hdmi@3d {
+		compatible = "adi,adv7535";
+		reg = <0x3d>, <0x3f>, <0x3c>, <0x38>;
+		reg-names = "main", "edid", "cec", "packet";
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



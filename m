Return-Path: <linux-kernel+bounces-775807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D5BB2C53B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEED1240AFC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B90D341AC1;
	Tue, 19 Aug 2025 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F9LfaG0w"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA51341AC0
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609386; cv=none; b=qZ2TFsKtRRQW9D8++bUZCb6Jjq//SIryowt3ejEnfhBRfvv5XJ9LaS3IQHa641tiyQij20xBJQWleLVrPpT+mCPReTmVpORTBD1Tjayhueif5U6xuiAWvpm7RKRA06wYVkmSpl5ZByai0+6la2JYyi/nzkzfIN3Zdwj0eXlJmaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609386; c=relaxed/simple;
	bh=FlJ31Q4r8DtWEP1JWYKS9HEZuRwP5fOwwXXSziAxGiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DB2ORY6vq5N5Se4tn0++aTD6R8VeIFfGVNloQBuS6NSdpCFxPoGJRZ44B8rB9aiRtlL+rarXhVTlnOJN+qMf3LOQRx5jle8LijeGQLs3l5oS1Ehvoi853FGGumC9c2f2Qg+M2vf7x+Hw48w16l+/Nrf/vL0ms2bAGlMzgdSZgfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F9LfaG0w; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61a483149e8so268970a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755609383; x=1756214183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WAyUsYNwkYrgmyUPFJBgMUOEuaiMdUtsvQFJPoQdWaM=;
        b=F9LfaG0w0vsm2D//Wfq3ELbR4tEE+9O+wEY4cdy0e3nKsMdBIpB5uztGYSue7yTkgQ
         VmFxGWwGf6sQcRd4Pp/r/zXared4QSaDyoEYnBc4IJFZTbsnhezudFJyULA2iewctR5L
         WChtNjeQrMecHIArOx1ds81Uzz133D1qDvElVdFw9+Xozw+lC7cFN7wtuH3a9mpb1xyO
         HNgdVapuUUjYm+wq4iMeF3J2Ndb+OjExTQzWTB8nuhv0Bz7KXbtMHUtgGTtVX5Li8pAf
         zI1J8RA1URyAjvOjQB7sIKY7vr/7md5NOri3Z+Ae7brxkn6/dFXa4qNRQhLKdWiO++ZK
         xt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755609383; x=1756214183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WAyUsYNwkYrgmyUPFJBgMUOEuaiMdUtsvQFJPoQdWaM=;
        b=VVXk7xEfHhVxPFXc5UjxF8Plx8B7qS1n6KZsk0kblhCS8zBasM+gHZqYy5z7dYTpsB
         Rc5u7QXc/2cLExVjpEk2q+KpaC6HA85804PAlsH67b5jhONhx4t+DPsjA34StXX0hevY
         RZJRR0UnPPx9GCGS/xCkHS49qqzYWHTI1K5bbuZAFoKRnQsThvbbrvfEFJUHus795OIL
         ygsYJLqoxsC5Zr7d1y+fhARmepButaQoRklP2wDsW92nTZ2BiY9Rp5Y4/gc8V9CDT25P
         HBcfYDUxP3wsq0RwSwVaoDFMH46xoixhgir8uiJrQFK15ZYkvNuj7emUFdr/T7vsRQhx
         9R7g==
X-Forwarded-Encrypted: i=1; AJvYcCXBRFrH2IXJ5UkFIw3np7j9gwIpulV+q4qTjUj7Qrl5tV4iL3XFETPSkaLsMM59ScwnA71PzdFP7X3lVC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2v0v0tH7xxTpDZ1CQu4+kyc1ZOcyKH2A4fv91VICebZ9lbqXA
	gsaFo/ByRUCRWFK3NZ413jIY81c8siM1fhtYOMDAQu92Y/giG/XhH12oSxWyp1pCs8o=
X-Gm-Gg: ASbGncuQTGMLaGFcKtq2yB0/AvVILTBHvM64k7WarXJzIkNfQ/O2ioF92a9iAl+RE1F
	Ka/zz9v/mfbgUPuLztsiROX5rAEigMsHNHpzUN5JhsIxYEoZ0ou6gEqSf1KEiNzzyqkZwLhRnxF
	PsEk9DaCB7mDJyxzwGtRxcns99i4mjI3tFCPcES7mZkU6msq/w6BDUrO+ApPl7lSS8+kjcuNgjm
	9q85bMi+8PjOiiRJkkpnd9LAkjTRFYWCwJjo+R5+br4CKh81rXCLmqaI4neqgyJdXa/RgGpsiR4
	P+S8JB90D+kEg6bqcIixOQerBX6gO+PoytzI2Xc8nrIstiorwfsTt2a2uiwKD+EnFEMuyI524oV
	7ki250j/obEoVDDifH1d192l4vL5r/BuRcg==
X-Google-Smtp-Source: AGHT+IGicKFJYlSBqndrUCzc72c9FauFKrC2A7g5lsSNLNB3PYbxEyMtEg/eIuHm3Z90cDguU2Hd0A==
X-Received: by 2002:a05:6402:5215:b0:617:be23:1111 with SMTP id 4fb4d7f45d1cf-61a7e782ac9mr1067731a12.7.1755609383348;
        Tue, 19 Aug 2025 06:16:23 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a755ff4f1sm1779671a12.19.2025.08.19.06.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 06:16:22 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: renesas: Minor whitespace cleanup
Date: Tue, 19 Aug 2025 15:16:20 +0200
Message-ID: <20250819131619.86396-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5392; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=FlJ31Q4r8DtWEP1JWYKS9HEZuRwP5fOwwXXSziAxGiw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBopHkjDm3kaqBkQYubub/eePmSOb+rw2NpsfmNb
 Iltt+bgNYyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKR5IwAKCRDBN2bmhouD
 159fD/9oOreHQKUT23cIrD6stunETQgDTwYGUX+YY/clIG0HB4WEcjo+SvL/HYWJ0h21wPGx9jA
 LnOb+zyKYNw2t5B9vMAijjBmrTa74n6hBKdRiE+jpdQiwRIiRAto4tI8/U4wB+ZW+l7PYWN8RPD
 0TbwPuGnVu+gHGzUEMfQxo6E0NIvDysGnYS5L5F+zENATNM9TFCR+O0NC8MHlbu8mkoCCdGfkoM
 kBWxIU+uIeq1FoklPf1wxBddVrHCalam1bFUUOvoGtUJGOx50ZWHhOyE9WJs0HDKQLeR6STlxlx
 deQS0g8grQk3Fo1DE3Hp8bJXlcDNPhUmMYr/eZe7nbQrLxOPmi/wRel2B7yMsRWoGtIv/kmmTWt
 3CoCmSEDq9C7s+8BAyekU2vjbcCIz2O0bN7B7qTA5+ijyv9S0GfP1DMIWVaorXItGlT6fuT58j6
 CJa+XSaPT22dotHPo5N5DfrEPy1z2NFoQGCluRf0du6i5PEvAWSTQtg3HOjJZ8Oow8AHf0U0o67
 R2CUR7aj5wBrlQAkS8KG1pOD1JooQmkM9sJqxzFWieB9d9BGnRTv03Nm68cDmETwQhvwY9BM1s8
 P2riWvMzD8HjDLh9TyzZz7GnGFe0Jc7PRnAueI/NwZEtO+H/nP71aa+MIm94LSDqQu9Z8CcUpXb SiX+miFwMl7IEbQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The DTS code coding style expects exactly one space around '='
character.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi       | 16 ++++++++--------
 .../boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts  |  2 +-
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi       | 16 ++++++++--------
 .../boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts  |  2 +-
 .../boot/dts/renesas/r9a09g057h48-kakip.dts      |  2 +-
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi b/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
index 10d3b9727ea5..50a3d42d192c 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
@@ -735,10 +735,10 @@ eth0: ethernet@15c30000 {
 					  "rx-queue-0", "rx-queue-1", "rx-queue-2",
 					  "rx-queue-3", "tx-queue-0", "tx-queue-1",
 					  "tx-queue-2", "tx-queue-3";
-			clocks =  <&cpg CPG_MOD 0xbd>, <&cpg CPG_MOD 0xbc>,
-				  <&cpg CPG_CORE R9A09G056_GBETH_0_CLK_PTP_REF_I>,
-				  <&cpg CPG_MOD 0xb8>, <&cpg CPG_MOD 0xb9>,
-				  <&cpg CPG_MOD 0xba>, <&cpg CPG_MOD 0xbb>;
+			clocks = <&cpg CPG_MOD 0xbd>, <&cpg CPG_MOD 0xbc>,
+				 <&cpg CPG_CORE R9A09G056_GBETH_0_CLK_PTP_REF_I>,
+				 <&cpg CPG_MOD 0xb8>, <&cpg CPG_MOD 0xb9>,
+				 <&cpg CPG_MOD 0xba>, <&cpg CPG_MOD 0xbb>;
 			clock-names = "stmmaceth", "pclk", "ptp_ref",
 				      "tx", "rx", "tx-180", "rx-180";
 			resets = <&cpg 0xb0>;
@@ -836,10 +836,10 @@ eth1: ethernet@15c40000 {
 					  "rx-queue-0", "rx-queue-1", "rx-queue-2",
 					  "rx-queue-3", "tx-queue-0", "tx-queue-1",
 					  "tx-queue-2", "tx-queue-3";
-			clocks =  <&cpg CPG_MOD 0xc3>, <&cpg CPG_MOD 0xc2>,
-				  <&cpg CPG_CORE R9A09G056_GBETH_1_CLK_PTP_REF_I>,
-				  <&cpg CPG_MOD 0xbe>, <&cpg CPG_MOD 0xbf>,
-				  <&cpg CPG_MOD 0xc0>, <&cpg CPG_MOD 0xc1>;
+			clocks = <&cpg CPG_MOD 0xc3>, <&cpg CPG_MOD 0xc2>,
+				 <&cpg CPG_CORE R9A09G056_GBETH_1_CLK_PTP_REF_I>,
+				 <&cpg CPG_MOD 0xbe>, <&cpg CPG_MOD 0xbf>,
+				 <&cpg CPG_MOD 0xc0>, <&cpg CPG_MOD 0xc1>;
 			clock-names = "stmmaceth", "pclk", "ptp_ref",
 				      "tx", "rx", "tx-180", "rx-180";
 			resets = <&cpg 0xb1>;
diff --git a/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
index 03aeea781186..066e66b5d51a 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
@@ -334,7 +334,7 @@ sd1-dat-cmd {
 
 	usb20_pins: usb20 {
 		ovc {
-			pinmux =  <RZV2N_PORT_PINMUX(9, 6, 14)>; /* OVC */
+			pinmux = <RZV2N_PORT_PINMUX(9, 6, 14)>; /* OVC */
 		};
 
 		vbus {
diff --git a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
index 6d0c6449b9ff..e66f5654f2ab 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
@@ -1083,10 +1083,10 @@ eth0: ethernet@15c30000 {
 					  "rx-queue-0", "rx-queue-1", "rx-queue-2",
 					  "rx-queue-3", "tx-queue-0", "tx-queue-1",
 					  "tx-queue-2", "tx-queue-3";
-			clocks =  <&cpg CPG_MOD 0xbd>, <&cpg CPG_MOD 0xbc>,
-				  <&cpg CPG_CORE R9A09G057_GBETH_0_CLK_PTP_REF_I>,
-				  <&cpg CPG_MOD 0xb8>, <&cpg CPG_MOD 0xb9>,
-				  <&cpg CPG_MOD 0xba>, <&cpg CPG_MOD 0xbb>;
+			clocks = <&cpg CPG_MOD 0xbd>, <&cpg CPG_MOD 0xbc>,
+				 <&cpg CPG_CORE R9A09G057_GBETH_0_CLK_PTP_REF_I>,
+				 <&cpg CPG_MOD 0xb8>, <&cpg CPG_MOD 0xb9>,
+				 <&cpg CPG_MOD 0xba>, <&cpg CPG_MOD 0xbb>;
 			clock-names = "stmmaceth", "pclk", "ptp_ref",
 				      "tx", "rx", "tx-180", "rx-180";
 			resets = <&cpg 0xb0>;
@@ -1184,10 +1184,10 @@ eth1: ethernet@15c40000 {
 					  "rx-queue-0", "rx-queue-1", "rx-queue-2",
 					  "rx-queue-3", "tx-queue-0", "tx-queue-1",
 					  "tx-queue-2", "tx-queue-3";
-			clocks =  <&cpg CPG_MOD 0xc3>, <&cpg CPG_MOD 0xc2>,
-				  <&cpg CPG_CORE R9A09G057_GBETH_1_CLK_PTP_REF_I>,
-				  <&cpg CPG_MOD 0xbe>, <&cpg CPG_MOD 0xbf>,
-				  <&cpg CPG_MOD 0xc0>, <&cpg CPG_MOD 0xc1>;
+			clocks = <&cpg CPG_MOD 0xc3>, <&cpg CPG_MOD 0xc2>,
+				 <&cpg CPG_CORE R9A09G057_GBETH_1_CLK_PTP_REF_I>,
+				 <&cpg CPG_MOD 0xbe>, <&cpg CPG_MOD 0xbf>,
+				 <&cpg CPG_MOD 0xc0>, <&cpg CPG_MOD 0xc1>;
 			clock-names = "stmmaceth", "pclk", "ptp_ref",
 				      "tx", "rx", "tx-180", "rx-180";
 			resets = <&cpg 0xb1>;
diff --git a/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
index 5c3f4e471e3d..5c06bce3d5b4 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
@@ -353,7 +353,7 @@ sd1_cd {
 
 	usb20_pins: usb20 {
 		ovc {
-			pinmux =  <RZV2H_PORT_PINMUX(9, 6, 14)>; /* OVC */
+			pinmux = <RZV2H_PORT_PINMUX(9, 6, 14)>; /* OVC */
 		};
 
 		vbus {
diff --git a/arch/arm64/boot/dts/renesas/r9a09g057h48-kakip.dts b/arch/arm64/boot/dts/renesas/r9a09g057h48-kakip.dts
index f6f2cb7d2d25..adf3ab8aef2b 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057h48-kakip.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g057h48-kakip.dts
@@ -84,7 +84,7 @@ &ostm7 {
 
 &pinctrl {
 	scif_pins: scif {
-		pins =  "SCIF_RXD", "SCIF_TXD";
+		pins = "SCIF_RXD", "SCIF_TXD";
 	};
 
 	sd0-pwr-en-hog {
-- 
2.48.1



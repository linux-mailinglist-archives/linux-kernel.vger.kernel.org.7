Return-Path: <linux-kernel+bounces-855208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE68BE0861
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625955E1527
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185A630FC31;
	Wed, 15 Oct 2025 19:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcP6InBp"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15CA30E847
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760557479; cv=none; b=Qlc0RCicEK1+SuArdSmUPL/o2wCMy5C9GlCEylkI0Sj7T37WMetkz2ddZPeEB8TzjzdynwcDvq645JEw+23EybdFKTkyw2SQbbpAYlNKptkf5NFJ2OejWj9z/ByP6b2xT8iPDx49gxP4bomOjH7QB1CQeLV49Lbnc+vZAMTcHc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760557479; c=relaxed/simple;
	bh=an1IqI2DrpyzSR1UThF1rWbqQR6bxYIoSS+lWWmwVzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PRYoPWkqWr0gsOp1g9Rvedd5D2pVPG2XlpZtKN09JkOn8c2YgenGd5uxCBi6JuJoSi41NOQxB4N0wqH1sl+wS6zBBz0Id7lJJL+kPg4Kq1UMuqrSUUEUfiUhdc8TClulr5nby+oFg7crAfkqwk8ZX5V9BovumNHqoNGzscrdEb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcP6InBp; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3f4319b8c03so421713f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760557475; x=1761162275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8w0UBMRdn9WI7neqz6g09a5mjk21WNS8Jbq/ycntUs=;
        b=gcP6InBp5WkFw4Z8jdoVAqihvQtMd7PIaTSfNgwlBFgdZAYBXzT1qkc6zCYi0orm3O
         MAJzvh0g5BBmVg0SVLjzW9W0EpghZgnysDfmsbnX3dMRH5gnLihDvCVEwh4kqUMBzt3T
         +MtmaeahUIlvyNqGksssX9ayavRMbs9MbpUHsEK3/ZOyKaQwc3endIOFGVaw1yO5cjdd
         uwFTqdgvuZrVxNoo1xNrIiW1RBJwbS9S615xVRzhaSbeOzbXwcDeUzLszoh1vzbTGtQ0
         3nJwJ5vIkhNdZpVS0nM/YbhAsaZOUveBnWr4di5cFDFKDg010JW/DF3AvGq2YVaMBlmi
         CVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760557475; x=1761162275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8w0UBMRdn9WI7neqz6g09a5mjk21WNS8Jbq/ycntUs=;
        b=ffqvRKqb71JjuHdO4p40F7FQUEhe/5yPH2IxrDrHHl0xkLL8JOFz75ivHXWkX02+qo
         EYB0Izi4oyEreIVDEI9+VbbfNj3Ppm4x72Z6PhvQe03xldGCNYcBpuBqQRF6Rd5M+L0j
         BnZKTiFqOoxc3UR/VuVdjdlVH/ukQFgM1uXj5r6mGVTf1sIqSsKKAPcABSQbjx4g7mUM
         dOD4UvRIG9ZDlG4EEkliXlNp8KHlsE+nlaQPKvKdp1D1Mv2+wSZKmPsyL5WWKLHDOUI0
         gvtSlrfyArdpx8tQa5M24wIs4Bd0Q5qIR2sDAeATKXYRiTXidrIdCBoxzr+K5mNWAheQ
         b/tw==
X-Forwarded-Encrypted: i=1; AJvYcCUJEgpEjWxr3Yv/zNz3qcMv2PWIdHy8sHeonWk8Mxf1AnPK4mMrpMbSmWscKbWfnUYOBxd7C5b/4Ue3ve8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX0NKLtEhwMsxM01pr/5oACJFVrqPsMIlXwfK4DPBLUwX4tvxw
	sC3QGrf+uh2NYWqdOYkaTjLcjMCa/WxWcniO0yt3n9SG48cmdha+j/Pt
X-Gm-Gg: ASbGnctGfuUXhSpyyJzbiN/vMPXIamaOis+Kch7tmm0IG5ZZ/oHhR8UGNgI1dKErDWT
	KVo0BVsQJukGaQFuJXkIAQbyxvOfIy84znZVANX4hYsnQ5N4HQ7szg6riVvp2nhfukLQI8NGNHf
	p5ZkzlY5XKHBL6OXfPpJuQSwE0qROxEKre4Gy8nD+QXhDFnOK+gY85KH73aCE1ZWgYmB9L/HA6U
	HnqZrU5XVogAlL6vrMkvuEpjjQD+do7GviZFKNyaARHRQbvz/d4W6X2R5DPCAVLhztxDuoLsYDY
	ltrIdm/GB43L34o8GODi1VexcSVfS5jpR+3U7sV6+MH6ozvU8JeAE1y+X7pJWQs54pujD2CdJnx
	ZRymm6QhqPbwjPWjf2/IXt3a/8yVUUmBaN4DI+MVO0Ay1GjeihDPL9GCedeBxB4F4Ze6NFO1GW+
	QvJDLTam7hzCABqxD9prcbUs5z
X-Google-Smtp-Source: AGHT+IG+GBr1YE4KVcrUzbBE3ts6hhB6sCOsDLrTE1cQZZNudItepM8k89VSCatdbgfO6EsS+bUEUA==
X-Received: by 2002:a05:6000:4012:b0:3f3:3c88:5071 with SMTP id ffacd0b85a97d-4266e7c4f78mr11393933f8f.4.1760557475090;
        Wed, 15 Oct 2025 12:44:35 -0700 (PDT)
Received: from d25728c254ff.v.cablecom.net (84-74-0-139.dclient.hispeed.ch. [84.74.0.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5825aasm30291626f8f.14.2025.10.15.12.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:44:34 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	martin.petersen@oracle.com,
	pabeni@redhat.com,
	rostedt@goodmis.org,
	bhelgaas@google.com,
	l.rubusch@gmail.com
Cc: arnd@arndb.de,
	matthew.gerlach@altera.com,
	tien.fong.chee@altera.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 07/11] ARM: dts: socfpga: add Mercury AA1 variants
Date: Wed, 15 Oct 2025 19:44:12 +0000
Message-Id: <20251015194416.33502-8-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251015194416.33502-1-l.rubusch@gmail.com>
References: <20251015194416.33502-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce support for Enclustra's Mercury+ AA1 SoM, based on Intel
Arria10. This is a flexible approach to allow for combining SoM
with carrier board .dtsi and boot-mode .dtsi in a device-tree file.

Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 .../socfpga/socfpga_arria10_mercury_aa1.dtsi  | 143 +++++++++++++++---
 1 file changed, 121 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1.dtsi
index 41f865c8c098..c80201bce793 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1.dtsi
@@ -7,12 +7,14 @@
 
 / {
 
-	model = "Enclustra Mercury AA1";
-	compatible = "enclustra,mercury-aa1", "altr,socfpga-arria10", "altr,socfpga";
+	model = "Enclustra Mercury+ AA1";
+	compatible = "enclustra,mercury-aa1",
+		     "altr,socfpga-arria10", "altr,socfpga";
 
 	aliases {
 		ethernet0 = &gmac0;
 		serial1 = &uart1;
+		spi0 = &qspi;
 	};
 
 	memory@0 {
@@ -24,52 +26,102 @@ memory@0 {
 	chosen {
 		stdout-path = "serial1:115200n8";
 	};
+
+	/* Adjusted the i2c labels to use generic base-board dtsi files for
+	 * Enclustra Arria10 and Cyclone5 SoMs.
+	 *
+	 * The set of i2c0 and i2c1 labels defined in socfpga_cyclone5.dtsi and in
+	 * socfpga_arria10.dtsi do not allow for using the same base-board .dtsi
+	 * fragments. Thus define generic labels here to match the correct i2c
+	 * bus in a generic base-board .dtsi file.
+	 */
+	soc {
+		i2c_encl: i2c@ffc02300 {
+		};
+		i2c_encl_fpga: i2c@ffc02200 {
+		};
+	};
+};
+
+&i2c_encl {
+	status = "okay";
+	i2c-sda-hold-time-ns = <300>;
+	clock-frequency = <100000>;
+
+	atsha204a: crypto@64 {
+		compatible = "atmel,atsha204a";
+		reg = <0x64>;
+	};
+
+	isl12022: rtc@6f {
+		compatible = "isil,isl12022";
+		reg = <0x6f>;
+	};
+};
+
+&i2c_encl_fpga {
+	i2c-sda-hold-time-ns = <300>;
+	status = "disabled";
 };
 
 &gmac0 {
-	phy-mode = "rgmii";
+	status = "okay";
+	phy-mode = "rgmii-id";
 	phy-addr = <0xffffffff>; /* probe for phy addr */
-
 	max-frame-size = <3800>;
-
 	phy-handle = <&phy3>;
 
+	/delete-property/ mac-address;
+
 	mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "snps,dwmac-mdio";
 		phy3: ethernet-phy@3 {
-			txd0-skew-ps = <0>; /* -420ps */
-			txd1-skew-ps = <0>; /* -420ps */
-			txd2-skew-ps = <0>; /* -420ps */
-			txd3-skew-ps = <0>; /* -420ps */
+			reg = <3>;
+
+			/* Add 2ns RX clock delay (1.2ns + 0.78ns)*/
+			rxc-skew-ps = <1680>; /* 780ps */
 			rxd0-skew-ps = <420>; /* 0ps */
 			rxd1-skew-ps = <420>; /* 0ps */
 			rxd2-skew-ps = <420>; /* 0ps */
 			rxd3-skew-ps = <420>; /* 0ps */
-			txen-skew-ps = <0>; /* -420ps */
-			txc-skew-ps = <1860>; /* 960ps */
 			rxdv-skew-ps = <420>; /* 0ps */
-			rxc-skew-ps = <1680>; /* 780ps */
-			reg = <3>;
+
+			/* Add 1.38ns TX clock delay (0.96ns + 0.42ns)*/
+			txc-skew-ps = <1860>; /* 960ps */
+			txd0-skew-ps = <0>; /* -420ps */
+			txd1-skew-ps = <0>; /* -420ps */
+			txd2-skew-ps = <0>; /* -420ps */
+			txd3-skew-ps = <0>; /* -420ps */
+			txen-skew-ps = <0>; /* -420ps */
 		};
 	};
 };
 
-&i2c1 {
-	atsha204a: crypto@64 {
-		compatible = "atmel,atsha204a";
-		reg = <0x64>;
-	};
+&gpio0 {
+	status = "okay";
+};
 
-	isl12022: isl12022@6f {
-		compatible = "isil,isl12022";
-		reg = <0x6f>;
-	};
+&gpio1 {
+	status = "okay";
+};
+
+&gpio2 {
+	status = "okay";
+};
+
+&uart0 {
+	status = "disabled";
+};
+
+&uart1 {
+	status = "okay";
 };
 
 /* Following mappings are taken from arria10 socdk dts */
 &mmc {
+	status = "okay";
 	cap-sd-highspeed;
 	broken-cd;
 	bus-width = <4>;
@@ -79,3 +131,50 @@ &mmc {
 &osc1 {
 	clock-frequency = <33330000>;
 };
+
+&eccmgr {
+	sdmmca-ecc@ff8c2c00 {
+		compatible = "altr,socfpga-sdmmc-ecc";
+		reg = <0xff8c2c00 0x400>;
+		altr,ecc-parent = <&mmc>;
+		interrupts = <15 IRQ_TYPE_LEVEL_HIGH>,
+					 <47 IRQ_TYPE_LEVEL_HIGH>,
+					 <16 IRQ_TYPE_LEVEL_HIGH>,
+					 <48 IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
+
+&qspi {
+	status = "okay";
+	flash0: flash@0 {
+		u-boot,dm-pre-reloc;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+		spi-max-frequency = <10000000>;
+
+		cdns,read-delay = <4>;
+		cdns,tshsl-ns = <50>;
+		cdns,tsd2d-ns = <50>;
+		cdns,tchsh-ns = <4>;
+		cdns,tslch-ns = <4>;
+
+		partition@raw {
+			label = "Flash Raw";
+			reg = <0x0 0x4000000>;
+		};
+	};
+};
+
+&watchdog1 {
+	status = "disabled";
+};
+
+&usb0 {
+	status = "okay";
+	dr_mode = "host";
+};
-- 
2.39.5



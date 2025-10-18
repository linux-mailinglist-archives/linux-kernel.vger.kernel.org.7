Return-Path: <linux-kernel+bounces-859175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0ECBECF45
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 14:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 913F8586151
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 12:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A152FB974;
	Sat, 18 Oct 2025 12:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpksG7r/"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252C429BDB1
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 12:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760789531; cv=none; b=KWq0UJlapVwzv1GoIOPt4maVYEmE10tpqOHgEtdxzX5R2Szb5xXBwPsrrczAWHYos2833Kesgs8+a8n0ehq4vZhzqk0lfG8oEKiNCVJR7DHdpEwvkRRfZIW2PW1X26Wdm8wznhTTFlwzhS4BHjpBPvOwcTbq8XpthsORvLUKV8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760789531; c=relaxed/simple;
	bh=an1IqI2DrpyzSR1UThF1rWbqQR6bxYIoSS+lWWmwVzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BDV/uMNiY59lb0E50tWyDZLFv+VQV945M7KgCpqTuxdAvT48P5mR9Igpd2hGWETVwSrIyRaaZih6VkQG8zmKNGFjC36OxZt+yvXzaBgPfEe4jFgTi187OEIH6ercDe4DV2AOwY1eymSEEphRdPQxef92dWbur1h1Q7x9MT4Fsrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpksG7r/; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-427054641f0so350494f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 05:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760789527; x=1761394327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8w0UBMRdn9WI7neqz6g09a5mjk21WNS8Jbq/ycntUs=;
        b=mpksG7r/qZxzDQrV/aSx6SJW+z64PV/Ty0omzl0xX/kZJSMAgEIdhXBbNQKJb1j0FF
         g9KY679nfOXPKk31iUCvFSZoqyrKHcsGA5cwLw2jyC/zN2vsB4kD7DGHAzC0r2MfQEoU
         B2voSulgTlGaZGj6DqAbIQdpoTqLLjiyzjJUU0u8GRBhFXB+enAux+bhKr1jxDFOKKam
         gsPbu8sd/imHMtD68ZS92weJ4EXnWaPcBI6jgRxYxHlap8xCmDUM+hPDgjx8TIR2NM22
         dNfuUPGzVkm/8i/rWPv11XX2k+ZEzMk6zxzq44ga5qiOZbM9n/XwgbbT9gNVIxupEHTQ
         Lnnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760789527; x=1761394327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8w0UBMRdn9WI7neqz6g09a5mjk21WNS8Jbq/ycntUs=;
        b=ukNSOGswmoZT2yORxGSN7GyYll06ruDOKIB0k5V37XrCCo21ENMWbGrJqyXm0qIyEp
         Six5mfdRlxf1sUTZLALt8vVkN6v4UHLZl4A1fml4v3f40imCXKCug3QzzQPxRCKUNTN2
         MKsfLvs/uEjAPjthSESyYBTKFcARIYjYU3igjr9aYKquKNx7h9bTrQ5PNXLaBwhpXDnl
         AuPC/5y0Fhl1pay1AB1N3ZII3MYBFpEqQW9zRB469susYSDXSCP3/BxQnd4d5Kxnc9RP
         VgDq/NY2BfghRSIHMHjOBXbKK4FxYW5N34we119EPAp/S5w67NKW6M/0AQtGw/3SqMou
         3Oig==
X-Forwarded-Encrypted: i=1; AJvYcCXxz9nxUoBw7eN1O9mJ26WHMiIil54AtGmULG+JO6/LQTH55JGHzetzb72bbKB0DZ1Cs+cLszyU/S7nPXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKlTs7lakJGNvi5G/LJ1NJxoYFKLlmrvOqWbaHLjpYIAY8LOqj
	EALDFCE2mo6VF5kSe1KKN9BFS2p5NRLnqBNZF5Hg/2zUSKzbNMvcylQE
X-Gm-Gg: ASbGncvkCqEJs3gaDP9DkzhwBzT2kY2XfKpaTPkhHd+TlHvb4iqCrTN0kxMnfandAc7
	0TgqVDaao+2Nk25IS+Rd5A1hOasuB26Q1c4+JNqwFCm/zDz/7M9N/3A8QfT5siab6c1H94w/XMy
	egDE9PCJYsesEwaPW3OFvP5MBax5aeloXC5sYM+E39ZF/NtLOqwSwuZsoqmDdaMSv+ry8hvJrdx
	alKieWL1gVM3C4Oa/vS4CDwIPAQRRJVJv6Z0hvMlimY3Kz3Js/uRM8EG0Md0ENIjeMeQeQhVBrr
	T3SWHi3F4LOoGCrISIOaCCK+00DniwvSYw86WBLdXHuTGxtzvVoCSTK8sxOYlhgouPTB2uYhOvF
	8nTK0BmPytrYHCWfa/dbpR3B9STcE5rdavP3A9PKCB2cgs8/LpiL3ofzhQOhmyAokmWV6Q0o0Sb
	B/EOGx30paXLOTygkrI4CVIMX+5bdqnn3qT/jEONMjXGFw1pyrJ7E=
X-Google-Smtp-Source: AGHT+IGEfA/n1fBsH4OpE/QWlNcK4GVsyU3tzUEJqq/AVXzIIWuXIHyTt7QyAoB1zV3BNXVUvBeAbg==
X-Received: by 2002:a5d:5888:0:b0:3fb:6f9d:2711 with SMTP id ffacd0b85a97d-42704e25343mr2427187f8f.8.1760789527196;
        Sat, 18 Oct 2025 05:12:07 -0700 (PDT)
Received: from localhost.localdomain (84-74-0-139.dclient.hispeed.ch. [84.74.0.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0f19sm4763812f8f.9.2025.10.18.05.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 05:12:06 -0700 (PDT)
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
Subject: [PATCH v7 07/11] ARM: dts: socfpga: add Mercury AA1 variants
Date: Sat, 18 Oct 2025 12:11:51 +0000
Message-Id: <20251018121155.7743-8-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251018121155.7743-1-l.rubusch@gmail.com>
References: <20251018121155.7743-1-l.rubusch@gmail.com>
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



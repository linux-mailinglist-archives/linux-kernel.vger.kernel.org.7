Return-Path: <linux-kernel+bounces-859171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC1EBECF27
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 14:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4109319C5081
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 12:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027AA2D9EE1;
	Sat, 18 Oct 2025 12:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/aMgol/"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DC42D47F6
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760789526; cv=none; b=X4MSR7mU7Bzp20oGurs9jqI9NS0E3eYbbkgMTIUhK9IXTnEvxl7m+vSIAqx75EkL94BNRH3cBD2BJeJwK9nM1G+U4YySZAQDEFVdwkgyvr3TpgqUZZt+MOV43UJCFneRqGlKF/6cmNrR+lMuLEUY0HEw84fgAyPxwSjrhpbYndo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760789526; c=relaxed/simple;
	bh=aHgWnJercmO9bga0xfuGF1dB69CEj2xx22/xhOVmZyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hAUh8ROzO/syUfTmups8p9ekgf5S2q5NJxWNL4vnyE3NosxeTjKKlDdbBlCZDT/KlWe7Ft8IBVrkbQLxskbebh96/Te93eoLbrfXNgYYwYf23oiFleqhwNzGM7SP5n29tlqSaoL2NKDS9D4ND4+MFbPVhA08NxBLkULVC3gc9i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/aMgol/; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-426f7da0b64so214850f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 05:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760789523; x=1761394323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELtEzvOlSfZDw0eOq11pNQXYa7FR/HwnD4pYyXNkdPc=;
        b=D/aMgol/0/tY9SkQ2Qn64SkYKCcb7H9VTxL89L/aObgynEl8praK3gTZjnyu9Ibp5G
         IhEWiJMOizm3G4ZLkh5aHRQzreHqZAuMf1Y2sKYAI8A+jfYtysPAQKbRoelp5BP3angu
         RAg1Bir5sRwPrq8MK428nBoKn673qev9VXqHNwl9X0e7eAiN+zJhIM8QRJv3XiFVESAt
         qmT2HsmlNACDhoz7DGYh1Uya+e62VwYv/Aq6Bet8vdZNkiUYQCXPrDWlU8a4EpzJ4Pzf
         X3KMUnS5zOmFF64Mqe3wUhauKYuwPX8/3M2psF5e2neHkwU9PmP2Oywkoo8goMqOWKmx
         ECCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760789523; x=1761394323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELtEzvOlSfZDw0eOq11pNQXYa7FR/HwnD4pYyXNkdPc=;
        b=vZdtoQAvp0XzKQBdb5ElRq3uU7Ul3OcO3xKlQ0KlSqvAi48LML+BP8waK5lVzd7WKd
         3k9jmuDZ5173m/MZ/B6cbEc3/qYGFULAJy0Et+cteHJOGEl4Ad9Mxi5U9SA3RO3nFZQu
         95wIr9D+Quyda2Pui+X2PqL4MMTvX3EQvgpm+vFLV2SASJ9438g/d2gFsCDGXsusCWcr
         cdC4Jnq890CMKkpJ1miYwzCMCDCiPMTzEx1pn5hAodg/ocNIfEIrV93NHGIn097nG1GC
         VO5caGFL6kGOK4i1kn8cRhrhLITGRP8M5gupSlQKotGj01U4O/kP5I05KWLUUltBOQop
         6FWg==
X-Forwarded-Encrypted: i=1; AJvYcCW0qE2NtbkBlFidRnX4uWYbNWuR7FSBd3lR3hHmEF+jcDLwEX+lQnEhQaeXFA7jXNSF66k0/JAM9F0MxeM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj2Ak7Ms6MbfN2xoo3hwqnyDNvxay5DmCUaQACLV47dwOp4Ta2
	BhOBm4ZaSuOCdf9rAnlYGEiKoM8cuuZZuT+OZG6Lc8AiIV1FTNR4+R3h
X-Gm-Gg: ASbGncsZNmGubwYxQVvIIhZ0e0xRcjJrF+chXb5Q62WUWju0EsVQ3orAMnXC68zj6W2
	3yC04PB7b8I5MQR9b0e/wqtWwcTt8Z+eJWXNzFbip2jD9zy3CxTtRVQuQpt+1b5KbXqvkF5RLZD
	ZW/wGVDkTuYabKdwxl+Vj1EYnxbU/8FoKvEidkuXj1ZpGlAzEeBzsDZ9a9grvvch9kIeKcGSFhe
	6rybBTfzX5NH6XcyHziMzou6vB6Nb9oyS7pvoD2ciHqmgDB61P1ZcW4br3+yD9pQeCNl91fvVJj
	6srW7JO7pxldecBSTVyCnFAHySuspF7a3OzjW8xO3Y3ztB8m01XW+vcKhMRJn3tNu+Ok1LKCRao
	udLI5K222vy0QfMjP1G0Mac9AmCrgKiqfEJXBB9sGRhBcYaUUN0xobUr1TFWUHbF/heQYcT7Pow
	sgQMVKCW7+1hsAHOy0+72AkMsUpxGcZWorRdPx9dxKoS1Y/ObEEr4=
X-Google-Smtp-Source: AGHT+IFl2OlXHNJD+/6uPUbGL6WK8Fw8/JAYpjr+wCqhqtW+uDjAB+CPzFy2bZugCBb4WuxUe/AXOw==
X-Received: by 2002:a05:6000:26d1:b0:426:a87f:e8fc with SMTP id ffacd0b85a97d-42704caa860mr2705575f8f.0.1760789522527;
        Sat, 18 Oct 2025 05:12:02 -0700 (PDT)
Received: from localhost.localdomain (84-74-0-139.dclient.hispeed.ch. [84.74.0.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0f19sm4763812f8f.9.2025.10.18.05.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 05:12:02 -0700 (PDT)
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
Subject: [PATCH v7 03/11] ARM: dts: socfpga: add Enclustra Mercury SA1
Date: Sat, 18 Oct 2025 12:11:47 +0000
Message-Id: <20251018121155.7743-4-l.rubusch@gmail.com>
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

Introduce support for Enclustra's Mercury SA1 SoM based on Intel Cyclone5
technology as a .dtsi file.

Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 .../socfpga/socfpga_cyclone5_mercury_sa1.dtsi | 143 ++++++++++++++++++
 1 file changed, 143 insertions(+)
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1.dtsi

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1.dtsi
new file mode 100644
index 000000000000..49944f9632f9
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1.dtsi
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+#include "socfpga_cyclone5.dtsi"
+
+/ {
+	model = "Enclustra Mercury SA1";
+	compatible = "altr,socfpga-cyclone5", "altr,socfpga";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	aliases {
+		ethernet0 = &gmac1;
+	};
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
+		i2c_encl: i2c@ffc04000 {
+		};
+		i2c_encl_fpga: i2c@ffc05000 {
+		};
+	};
+
+	memory {
+		name = "memory";
+		device_type = "memory";
+		reg = <0x0 0x40000000>; /* 1GB */
+	};
+};
+
+&osc1 {
+	clock-frequency = <50000000>;
+};
+
+&i2c_encl {
+	i2c-sda-hold-time-ns = <300>;
+	clock-frequency = <100000>;
+	status = "okay";
+
+	isl12020: rtc@6f {
+		compatible = "isil,isl12022";
+		reg = <0x6f>;
+	};
+};
+
+&i2c_encl_fpga {
+	i2c-sda-hold-time-ns = <300>;
+	status = "disabled";
+};
+
+&uart0 {
+	clock-frequency = <100000000>;
+};
+
+&mmc0 {
+	status = "okay";
+	/delete-property/ cap-mmc-highspeed;
+	/delete-property/ cap-sd-highspeed;
+};
+
+&qspi {
+	status = "okay";
+
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
+&gpio0 {
+	status = "okay";
+};
+
+&gpio1 {
+	status = "okay";
+};
+
+&gmac1 {
+	status = "okay";
+	/delete-property/ mac-address;
+	phy-mode = "rgmii-id";
+	phy-handle = <&phy3>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+
+		phy3: ethernet-phy@3 {
+			reg = <3>;
+
+			/* Add 2ns RX clock delay (1.2ns + 0.78ns)*/
+			rxc-skew-ps = <1680>;
+			rxd0-skew-ps = <420>;
+			rxd1-skew-ps = <420>;
+			rxd2-skew-ps = <420>;
+			rxd3-skew-ps = <420>;
+			rxdv-skew-ps = <420>;
+
+			/* Add 1.38ns TX clock delay (0.96ns + 0.42ns)*/
+			txc-skew-ps = <1860>;
+			txd0-skew-ps = <0>;
+			txd1-skew-ps = <0>;
+			txd2-skew-ps = <0>;
+			txd3-skew-ps = <0>;
+			txen-skew-ps = <0>;
+		};
+	};
+};
+
+&usb1 {
+	status = "okay";
+	dr_mode = "host";
+};
-- 
2.39.5



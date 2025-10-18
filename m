Return-Path: <linux-kernel+bounces-859173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 182F7BECF36
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 14:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F9DF5869A7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 12:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F35D2E427C;
	Sat, 18 Oct 2025 12:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZ0gbgDl"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE322D94A4
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 12:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760789528; cv=none; b=XvCUQ6gDjx6WTmVsLDKkjbWBlkrPBhUtIRG+Pxsd9//hT6B4dInfjDZWQWMeoNhxnrGZxHlR9rkjpaVM5u9rPYRRRb7WLPTVuFgOvXYLgt6xOMqRA04t7CH9MX8P2WCZSD/0OjiYkfaCWN7dUPfNvNVzCIgqi/yNXyu0gFrhSZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760789528; c=relaxed/simple;
	bh=chBM4fI89RfRSTQyy77w7NKm+uci1RTfTRMtapqT118=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rSLBHauaOo/IBN8kXK6VSGAxjxh/rX4c68IfwO5kZTflzoCaBygv75zP54yNXojfkl0IikPtKuIcBf1YBE8ZSBC7bJlWoFLvNlzjd7jydAHqRT8kaPtjlBVv+Ovhq6tziqrhYfiORsPNxQ0dYh0jUR+hGpRUD6MdANyD9z7pOUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZ0gbgDl; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-426ff579fbeso322006f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 05:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760789525; x=1761394325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYhsBfZhMWFr6Wa+dWD+zvDolXEh8h6k/0rm68kc4+o=;
        b=BZ0gbgDlwlVd4ryn6rAWjhIsqyOaCUd30XrWo7Y1fe3ALJerJ+ypd8RZ25f5/2GZwq
         B5YyQIAc/xqmjOVbWy64/YfegVGElUMn74jZrkNKiOq9XqMO3SY4Uc9UkuqzrEaX7/h+
         nSGFG2t3jLsVTM+bjXR1Vcw8S2tNvUi6OooNkC06UkpeGKdZoPuMmq9VXtKWZU62Hc2a
         mMgRYZ4mCMKMXP4gnYXGXBZJghrKAqVbsplZ/1xeE6hM20WUA4HthGDne2bSyiWjW3OT
         NuL2I6sC3B514sIjV8DUOQyHGU0uCkDSIpFqpD4Pi4hbi85Q32BF4xwNzIv/s4l1ov+x
         XBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760789525; x=1761394325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYhsBfZhMWFr6Wa+dWD+zvDolXEh8h6k/0rm68kc4+o=;
        b=lxjhHuV9UKR64vDNIWnONGMYLQFOgNZcLBT174Vugip6sc7yvDFS3X036SmxDKqt1m
         a9Vb15FbsMN1OeHe30bqVIvlskxa8eIytr8+00m16CyE/RfU49yq8ySqThMjrBoiNkTA
         pwW6vrZD7Ka8DzFL5U+RZ+GxtRT+m6G7SpEpVUz4CIfZElv6h8SY5FecIE+oqHjJB8xX
         4VixWlzDr4ha6nmffvsQaaKpymWrPemset8L7AMEnUS+wxi41fEvkTvrkBVOYlb1yV0d
         ySnSYYFrZKm7SXZfta+AkW0dhff0ceUAlSjPUlZUQGXxcZ50VfjCShPF2j7ciVKcI2Wb
         YzcA==
X-Forwarded-Encrypted: i=1; AJvYcCVu/AdbfYvmR2z/A8rDX4fRTLlSyZGIfGqTlsfvJOrfMZF2/v9nWEf7qhZ0LuPQSs02n7TxDYM3WLamUK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKDxnKPC4tLFsSyYGEqXZ18OGemLAwBgRn1S+2OmmfU/oHP6KL
	eNdfQqC+7i4cK1ht2uEiPXIoGbUxEQ7DjUIunJslviFRwwTIV90dyEOD
X-Gm-Gg: ASbGncvV+MZICUlk6BSmICaK5dx5P9rnSlhy1F6WzhCMbkaXNGAEXqb+yleQhmPNC2B
	V9+XPaGoUyUhihSBcui9bPMFL3+PkwDsw+EgMI6Sa65+Yn2e3N/VY9zzD5Toq/S3Vz8EfDPbXV0
	X/9xDlx0oBlsqPSnv7UH29pP5EI6km2T8mmrbI+Hy3XEONOSc4IC8JZW6OvbVo8/Pm/2BDsqS1N
	FmgoxvpnqUrEAz3pquGg8m6QpjhPPnKKhlcCD1mkck0wp/c5KP1f1c0nCgqjjGy6pAz6PvB86EB
	sun0gBzr5et/mCLqfcWyK8rYIkQ6cegzohEigUdysHpnRMjZHcus3ioHvDyuq0F052wAtQ3T8xb
	LhL1mXQ/2vhNktj9Cmji0DU2IsiAsP7xEi4bmUaXV7YRGXX/7uiatarbVkq8SorwexcQCNoeVF7
	i+RKY5Jx2aYe45GAQZ1wU6iiPWW94n+m+jfdkE3SkKpmExWxTQkbs=
X-Google-Smtp-Source: AGHT+IH1mulJ4plOuHgKwS0SsJhY962sW9hfVUqbDYOKG7lA7bglL50b/pzvguIJkAJGW1I/kDSyIw==
X-Received: by 2002:adf:a3d7:0:b0:427:7a9:97ab with SMTP id ffacd0b85a97d-42707a99873mr1610052f8f.10.1760789524842;
        Sat, 18 Oct 2025 05:12:04 -0700 (PDT)
Received: from localhost.localdomain (84-74-0-139.dclient.hispeed.ch. [84.74.0.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0f19sm4763812f8f.9.2025.10.18.05.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 05:12:04 -0700 (PDT)
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
Subject: [PATCH v7 05/11] ARM: dts: socfpga: add Enclustra Mercury+ SA2
Date: Sat, 18 Oct 2025 12:11:49 +0000
Message-Id: <20251018121155.7743-6-l.rubusch@gmail.com>
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

Introduce Enclustra's Mercury+ SA2 SoM based on Intel Cyclone5
technology as a .dtsi file.

Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 .../socfpga/socfpga_cyclone5_mercury_sa2.dtsi | 146 ++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2.dtsi

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2.dtsi
new file mode 100644
index 000000000000..0b28964e0378
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2.dtsi
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+#include "socfpga_cyclone5.dtsi"
+
+/ {
+	model = "Enclustra Mercury+ SA2";
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
+		reg = <0x0 0x80000000>; /* 2GB */
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
+
+	atsha204a: crypto@64 {
+		compatible = "atmel,atsha204a";
+		reg = <0x64>;
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



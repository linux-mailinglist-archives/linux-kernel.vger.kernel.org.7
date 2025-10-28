Return-Path: <linux-kernel+bounces-874442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD7AC1659B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F28055088F8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B2034FF46;
	Tue, 28 Oct 2025 17:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgWVrzmy"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913A134C9B5
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761674136; cv=none; b=OUFMlrTuu7CSyA+0a0SlufRbDu2b8HYDhFMrOI7GoWFV4Al+t5H7GRJm8n2ogcCCVXaHH2mYq0dXQpcxSZVDXtNAPPxwNwLAHAr1/mJcSDI3KL1lYBs9JcK+HXIF19BwgHUqlXXOBPBuWPGYGiGGQv85iwrxgJ0kkqYBGBKxiVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761674136; c=relaxed/simple;
	bh=I3dZ4r/IY7ujNUAxDMw7mlWcZIOVQIpADZ9QnnlsISI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOlQXNvjTybAMQVidWCUWui5o4vjFEzf3bsm8OtoD5LuhJb68w6DJmSQVP12uwd3Iwv3mq3Q9uRSf05hWWfM92OJ+Cql4npgRIUlVReRCM/6w9gMpYg/seGpiU3QF6uaPnB80ZSQL5EMPsnx+i3hwrRlJazl5gNi5OnXXz3n7rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgWVrzmy; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b553412a19bso4105747a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761674134; x=1762278934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcbFKXGjYARUNll6qoAP3bTKPOC/dQImP+gxnI1KcEM=;
        b=MgWVrzmyDcspybW7xI0/OeKFUu8NJ4kTdCKXDqttisGOwaYUdGNAUq8Wkjb+b+nYJB
         tSRGkWy4XGOMkDSsmr7g5708C1YVIc5tLb4B/q9m6h3ei5gkhr+IuYSahyW/NizqENnq
         NzKS8NjgknrK1sa3HfitsxT6UNDs5gbLH3137XXZRc4oZfOl0ngFHRm1OzlAcocbpw/X
         kW5q4a6MNnzaA57vavE4kwfGXPNyE3sYA9qAXemq8ByOkolbR0/kvmAqDZfu7AsEp7Tw
         H0Pn3DuqRKMfpUZq9KEd6MwNJC9SG+C9SlWkk1M2+1uCMcp+ple0zysKHjx7Ug2oDaIH
         +D1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761674134; x=1762278934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GcbFKXGjYARUNll6qoAP3bTKPOC/dQImP+gxnI1KcEM=;
        b=axOAu80Duds/XpjTrQ8VeoY/IKG36EINYzcFquZULy8I/QFu3h1e19UVd2It/kRFHb
         wy+JyPf1ZE7FiT7PZ0Pkw82Gg3fpH9axP0m2QDITb3jroUbZRG0JQA0FvrHNYBAL4pth
         t7D0UxjVCWzohS9m8rJuo0RhzMk54pE68Dk6Lxn4Ksevx/U4De1i0VL3ObQQdJXFSmDr
         D7VeStBwBvIoTkeDLQE6Yo/YOGhVXuFVt0ZxyRSMQngL18UfkJpHUKRvG9cdq55sEWct
         YE8rIzPlVrnOf+3Um27R1grN6K6cjlrea59DijtiVaWPDfCsMLB944gzcTLi37u/zcOS
         g7OA==
X-Forwarded-Encrypted: i=1; AJvYcCX4oY882pSu2iOe4f31iT48qHjQp7OzDDnz3iTkYV6CxoWLVzH/P9opIfHQZHcynCTIl9PS3m5qNwDHJhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqkwSoCXa8Uc9HOwj/i3i9/zrt4QoS+nMuUZsy4MyjQ/V+tVA0
	4c1kdzXv89v7nBiVhQySLyYRdL0cmuv9PLertNuopBTrGMk5WVYeAFDC
X-Gm-Gg: ASbGnctyGbZRHpiV4BB8k6jbEeaYaQqXhQiATNcjY0lWpa8PnglAd0lFc+g69qreqEr
	lPETHYuj8aC6a1UJYsHJhlenh41JWJSEyUFtN3vTooAgprqr48eBSem0y11U+wGa/DLS4MFi8fX
	Cy3lbzh85dDTxAtv50xERTYAT2vxsSklGDl4nApGWGrX2m0dfpqUW3oi9C2bwy/4ALtjtATBInz
	FEEP8nuVVrURwdhVZIAijFO82MSPMpOoWDfEEztMvB/iT65oEar46y6gBEQOFfpSKBYKGiKtSGJ
	CjyB3yYoBQEDXUAeO5JQNon6b110uHrPAb1sRERIXG+DBJ24r+yTuFVDbrm8fuypJaQwPhdQXP6
	+NDGjGW27OK4sAJq+LpmK8yb5sKJGePWiWfFY6tBUwuk+Ub9khdyCQUZT7lF/KWI7H+F08JoT3L
	e3FLxeqMX9/IVP8hk1aZxh5A==
X-Google-Smtp-Source: AGHT+IHcjQCNFDv+QEbhdknouZk3pmVTOpMrG6k8YTEj4V1GdWRkgPpNZLOxpd08ubwbpZIDS45wXg==
X-Received: by 2002:a17:902:db07:b0:28d:195a:7d79 with SMTP id d9443c01a7336-294dedf4305mr752395ad.5.1761674133743;
        Tue, 28 Oct 2025 10:55:33 -0700 (PDT)
Received: from iku.. ([2401:4900:1c06:77f0:168f:479e:bf92:ce93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3410sm125713005ad.8.2025.10.28.10.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:55:33 -0700 (PDT)
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
Subject: [PATCH v2 5/5] arm64: dts: renesas: rzt2h-n2h-evk: Enable Ethernet support
Date: Tue, 28 Oct 2025 17:54:58 +0000
Message-ID: <20251028175458.1037397-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251028175458.1037397-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251028175458.1037397-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Enable Ethernet support on the RZ/T2H and RZ/N2H EVKs.

Configure the MIIC converter in mode 0x6:
  Port 0 <-> ETHSW Port 0
  Port 1 <-> ETHSW Port 1
  Port 2 <-> GMAC2
  Port 3 <-> GMAC1

Enable the ETHSS, GMAC1 and GMAC2 nodes. ETHSW support will be added
once the switch driver is available.

Configure the MIIC converters to map ports according to the selected
switching mode, with converters 0 and 1 mapped to switch ports and
converters 2 and 3 mapped to GMAC ports.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2 changes:
- Dropped *skew-psec properties which are not needed for
  VSC8541 PHYs.
---
 .../dts/renesas/r9a09g077m44-rzt2h-evk.dts    | 70 ++++++++++++++++
 .../dts/renesas/r9a09g087m44-rzn2h-evk.dts    | 79 +++++++++++++++++++
 .../dts/renesas/rzt2h-n2h-evk-common.dtsi     | 70 ++++++++++++++++
 3 files changed, 219 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
index 799c58afd6fe..33cbf74933de 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
@@ -149,7 +149,77 @@ &i2c1 {
 	status = "okay";
 };
 
+&phy2 {
+	/*
+	 * PHY2 Reset Configuration:
+	 *
+	 * SW6[1] = OFF; SW6[2] = ON; SW6[3] = OFF;
+	 * P17_5 is used as GMAC_RESETOUT2#
+	 */
+	reset-gpios = <&pinctrl RZT2H_GPIO(17, 5) GPIO_ACTIVE_LOW>;
+};
+
+&phy3 {
+	reset-gpios = <&pinctrl RZT2H_GPIO(32, 3) GPIO_ACTIVE_LOW>;
+};
+
 &pinctrl {
+	/*
+	 * ETH2 Pin Configuration:
+	 *
+	 * SW2[6] = OFF: MDC and MDIO of Ethernet port 2 are connected to GMAC2
+	 * SW2[7] = ON:  Pins P29_1-P29_7, P30_0-P30_4, and P31_2-P31_5 are used for Ethernet port 2
+	 */
+	eth2_pins: eth2-pins {
+		pinmux = <RZT2H_PORT_PINMUX(29, 1, 0xf)>, /* ETH2_TXCLK */
+			 <RZT2H_PORT_PINMUX(29, 2, 0xf)>, /* ETH2_TXD[0] */
+			 <RZT2H_PORT_PINMUX(29, 3, 0xf)>, /* ETH2_TXD[1] */
+			 <RZT2H_PORT_PINMUX(29, 4, 0xf)>, /* ETH2_TXD[2] */
+			 <RZT2H_PORT_PINMUX(29, 5, 0xf)>, /* ETH2_TXD[3] */
+			 <RZT2H_PORT_PINMUX(29, 6, 0xf)>, /* ETH2_TXEN */
+			 <RZT2H_PORT_PINMUX(29, 7, 0xf)>, /* ETH2_RXCLK */
+			 <RZT2H_PORT_PINMUX(30, 0, 0xf)>, /* ETH2_RXD[0] */
+			 <RZT2H_PORT_PINMUX(30, 1, 0xf)>, /* ETH2_RXD[1] */
+			 <RZT2H_PORT_PINMUX(30, 2, 0xf)>, /* ETH2_RXD[2] */
+			 <RZT2H_PORT_PINMUX(30, 3, 0xf)>, /* ETH2_RXD[3] */
+			 <RZT2H_PORT_PINMUX(30, 4, 0xf)>, /* ETH2_RXDV */
+			 <RZT2H_PORT_PINMUX(31, 2, 0xf)>, /* ETH2_TXER */
+			 <RZT2H_PORT_PINMUX(31, 3, 0xf)>, /* ETH2_RXER */
+			 <RZT2H_PORT_PINMUX(31, 4, 0xf)>, /* ETH2_CRS */
+			 <RZT2H_PORT_PINMUX(31, 5, 0xf)>, /* ETH2_COL */
+			 <RZT2H_PORT_PINMUX(30, 5, 0x10)>, /* ETH2_MDC */
+			 <RZT2H_PORT_PINMUX(30, 6, 0x10)>, /* ETH2_MDIO */
+			 <RZT2H_PORT_PINMUX(31, 0, 0x02)>; /* ETH2_REFCLK */
+	};
+
+	/*
+	 * ETH3 Pin Configuration:
+	 *
+	 * SW2[8] = ON, P27_2, P33_2-P33_7, P34_0-P34_5, P34_7 and P35_0-P35_5
+	 * are used for Ethernet port 3
+	 */
+	eth3_pins: eth3-pins {
+		pinmux = <RZT2H_PORT_PINMUX(33, 2, 0xf)>, /* ETH3_TXCLK */
+			 <RZT2H_PORT_PINMUX(33, 3, 0xf)>, /* ETH3_TXD[0] */
+			 <RZT2H_PORT_PINMUX(33, 4, 0xf)>, /* ETH3_TXD[1] */
+			 <RZT2H_PORT_PINMUX(33, 5, 0xf)>, /* ETH3_TXD[2] */
+			 <RZT2H_PORT_PINMUX(33, 6, 0xf)>, /* ETH3_TXD[3] */
+			 <RZT2H_PORT_PINMUX(33, 7, 0xf)>, /* ETH3_TXEN */
+			 <RZT2H_PORT_PINMUX(34, 0, 0xf)>, /* ETH3_RXCLK */
+			 <RZT2H_PORT_PINMUX(34, 1, 0xf)>, /* ETH3_RXD[0] */
+			 <RZT2H_PORT_PINMUX(34, 2, 0xf)>, /* ETH3_RXD[1] */
+			 <RZT2H_PORT_PINMUX(34, 3, 0xf)>, /* ETH3_RXD[2] */
+			 <RZT2H_PORT_PINMUX(34, 4, 0xf)>, /* ETH3_RXD[3] */
+			 <RZT2H_PORT_PINMUX(34, 5, 0xf)>, /* ETH3_RXDV */
+			 <RZT2H_PORT_PINMUX(34, 7, 0xf)>, /* ETH3_TXER */
+			 <RZT2H_PORT_PINMUX(35, 0, 0xf)>, /* ETH3_RXER */
+			 <RZT2H_PORT_PINMUX(35, 1, 0xf)>, /* ETH3_CRS */
+			 <RZT2H_PORT_PINMUX(35, 2, 0xf)>, /* ETH3_COL */
+			 <RZT2H_PORT_PINMUX(26, 1, 0x10)>, /* ETH3_MDC */
+			 <RZT2H_PORT_PINMUX(26, 2, 0x10)>, /* ETH3_MDIO */
+			 <RZT2H_PORT_PINMUX(34, 6, 0x02)>; /* ETH3_REFCLK */
+	};
+
 	/*
 	 * I2C0 Pin Configuration:
 	 * ------------------------
diff --git a/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
index d698b6368ee7..7ebc89bafaf1 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
@@ -186,7 +186,86 @@ &i2c1 {
 	status = "okay";
 };
 
+&phy2 {
+	/*
+	 * PHY2 Reset Configuration:
+	 *
+	 * DSW8[1] = ON; DSW8[2] = OFF
+	 * DSW12[7] = OFF; DSW12[8] = ON
+	 * P03_1 is used as GMAC_RESETOUT2#
+	 */
+	reset-gpios = <&pinctrl RZT2H_GPIO(3, 1) GPIO_ACTIVE_LOW>;
+};
+
+&phy3 {
+	/*
+	 * PHY3 Reset Configuration:
+	 *
+	 * DSW12[5] = OFF; DSW12[6] = ON
+	 * P03_2 is used as GMAC_RESETOUT3#
+	 */
+	reset-gpios = <&pinctrl RZT2H_GPIO(3, 2) GPIO_ACTIVE_LOW>;
+};
+
 &pinctrl {
+	/*
+	 * ETH2 Pin Configuration:
+	 *
+	 * DSW5[6] = OFF, P21_4-P21_5 are used for Ethernet port 2
+	 * DSW5[7] = ON, P29_1-P29_7, P30_0-P30_4, P30_7, P31_2, P31_4
+	 * and P31_5 are used for Ethernet port 2
+	 */
+	eth2_pins: eth2-pins {
+		pinmux = <RZT2H_PORT_PINMUX(29, 1, 0xf)>, /* ETH2_TXCLK */
+			 <RZT2H_PORT_PINMUX(29, 2, 0xf)>, /* ETH2_TXD[0] */
+			 <RZT2H_PORT_PINMUX(29, 3, 0xf)>, /* ETH2_TXD[1] */
+			 <RZT2H_PORT_PINMUX(29, 4, 0xf)>, /* ETH2_TXD[2] */
+			 <RZT2H_PORT_PINMUX(29, 5, 0xf)>, /* ETH2_TXD[3] */
+			 <RZT2H_PORT_PINMUX(29, 6, 0xf)>, /* ETH2_TXEN */
+			 <RZT2H_PORT_PINMUX(29, 7, 0xf)>, /* ETH2_RXCLK */
+			 <RZT2H_PORT_PINMUX(30, 0, 0xf)>, /* ETH2_RXD[0] */
+			 <RZT2H_PORT_PINMUX(30, 1, 0xf)>, /* ETH2_RXD[1] */
+			 <RZT2H_PORT_PINMUX(30, 2, 0xf)>, /* ETH2_RXD[2] */
+			 <RZT2H_PORT_PINMUX(30, 3, 0xf)>, /* ETH2_RXD[3] */
+			 <RZT2H_PORT_PINMUX(30, 4, 0xf)>, /* ETH2_RXDV */
+			 <RZT2H_PORT_PINMUX(31, 2, 0xf)>, /* ETH2_TXER */
+			 <RZT2H_PORT_PINMUX(31, 3, 0xf)>, /* ETH2_RXER */
+			 <RZT2H_PORT_PINMUX(31, 4, 0xf)>, /* ETH2_CRS */
+			 <RZT2H_PORT_PINMUX(31, 5, 0xf)>, /* ETH2_COL */
+			 <RZT2H_PORT_PINMUX(30, 5, 0x10)>, /* ETH2_MDC */
+			 <RZT2H_PORT_PINMUX(30, 6, 0x10)>, /* ETH2_MDIO */
+			 <RZT2H_PORT_PINMUX(31, 0, 0x02)>; /* ETH2_REFCLK */
+
+	};
+
+	/*
+	 * ETH3 Pin Configuration:
+	 *
+	 * DSW5[8] = ON, P00_0-P00_2, P33_2-P33_7, P34_0-P34_6, are used for Ethernet port 3
+	 * DSW12[1] = OFF;DSW12[2] = ON, P00_3 is used for Ethernet port 3
+	 */
+	eth3_pins: eth3-pins {
+		pinmux = <RZT2H_PORT_PINMUX(33, 2, 0xf)>, /* ETH3_TXCLK */
+			 <RZT2H_PORT_PINMUX(33, 3, 0xf)>, /* ETH3_TXD[0] */
+			 <RZT2H_PORT_PINMUX(33, 4, 0xf)>, /* ETH3_TXD[1] */
+			 <RZT2H_PORT_PINMUX(33, 5, 0xf)>, /* ETH3_TXD[2] */
+			 <RZT2H_PORT_PINMUX(33, 6, 0xf)>, /* ETH3_TXD[3] */
+			 <RZT2H_PORT_PINMUX(33, 7, 0xf)>, /* ETH3_TXEN */
+			 <RZT2H_PORT_PINMUX(34, 0, 0xf)>, /* ETH3_RXCLK */
+			 <RZT2H_PORT_PINMUX(34, 1, 0xf)>, /* ETH3_RXD[0] */
+			 <RZT2H_PORT_PINMUX(34, 2, 0xf)>, /* ETH3_RXD[1] */
+			 <RZT2H_PORT_PINMUX(34, 3, 0xf)>, /* ETH3_RXD[2] */
+			 <RZT2H_PORT_PINMUX(34, 4, 0xf)>, /* ETH3_RXD[3] */
+			 <RZT2H_PORT_PINMUX(34, 5, 0xf)>, /* ETH3_RXDV */
+			 <RZT2H_PORT_PINMUX(0, 0, 0xf)>, /* ETH3_TXER */
+			 <RZT2H_PORT_PINMUX(0, 1, 0xf)>, /* ETH3_RXER */
+			 <RZT2H_PORT_PINMUX(0, 2, 0xf)>, /* ETH3_CRS */
+			 <RZT2H_PORT_PINMUX(0, 3, 0xf)>, /* ETH3_COL */
+			 <RZT2H_PORT_PINMUX(26, 1, 0x10)>, /* ETH3_MDC */
+			 <RZT2H_PORT_PINMUX(26, 2, 0x10)>, /* ETH3_MDIO */
+			 <RZT2H_PORT_PINMUX(34, 6, 0x02)>; /* ETH3_REFCLK */
+	};
+
 	/*
 	 * I2C0 Pin Configuration:
 	 * ------------------------
diff --git a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
index 924a38c6cb0f..c608d97586ff 100644
--- a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
@@ -7,10 +7,14 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/leds/common.h>
+#include <dt-bindings/net/mscc-phy-vsc8531.h>
+#include <dt-bindings/net/renesas,r9a09g077-pcs-miic.h>
 #include <dt-bindings/pinctrl/renesas,r9a09g077-pinctrl.h>
 
 / {
 	aliases {
+		ethernet0 = &gmac1;
+		ethernet1 = &gmac2;
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
 		mmc0 = &sdhi0;
@@ -70,10 +74,34 @@ &ehci {
 	status = "okay";
 };
 
+&ethss {
+	status = "okay";
+
+	renesas,miic-switch-portin = <ETHSS_GMAC0_PORT>;
+};
+
 &extal_clk {
 	clock-frequency = <25000000>;
 };
 
+&gmac1 {
+	pinctrl-0 = <&eth3_pins>;
+	pinctrl-names = "default";
+	phy-handle = <&phy3>;
+	phy-mode = "rgmii-id";
+	pcs-handle = <&mii_conv3>;
+	status = "okay";
+};
+
+&gmac2 {
+	pinctrl-0 = <&eth2_pins>;
+	pinctrl-names = "default";
+	phy-handle = <&phy2>;
+	phy-mode = "rgmii-id";
+	pcs-handle = <&mii_conv2>;
+	status = "okay";
+};
+
 &hsusb {
 	dr_mode = "otg";
 	status = "okay";
@@ -87,6 +115,48 @@ eeprom: eeprom@50 {
 	};
 };
 
+&mdio1 {
+	phy3: ethernet-phy@3 {
+		compatible = "ethernet-phy-id0007.0772", "ethernet-phy-ieee802.3-c22";
+		reg = <3>;
+		vsc8531,led-0-mode = <VSC8531_LINK_ACTIVITY>;
+		vsc8531,led-1-mode = <VSC8531_LINK_ACTIVITY>;
+		reset-assert-us = <2000>;
+		reset-deassert-us = <15000>;
+	};
+};
+
+&mdio2 {
+	phy2: ethernet-phy@2 {
+		compatible = "ethernet-phy-id0007.0772", "ethernet-phy-ieee802.3-c22";
+		reg = <2>;
+		vsc8531,led-0-mode = <VSC8531_LINK_ACTIVITY>;
+		vsc8531,led-1-mode = <VSC8531_LINK_ACTIVITY>;
+		reset-assert-us = <2000>;
+		reset-deassert-us = <15000>;
+	};
+};
+
+&mii_conv0 {
+	renesas,miic-input = <ETHSS_ETHSW_PORT0>;
+	status = "okay";
+};
+
+&mii_conv1 {
+	renesas,miic-input = <ETHSS_ETHSW_PORT1>;
+	status = "okay";
+};
+
+&mii_conv2 {
+	renesas,miic-input = <ETHSS_GMAC2_PORT>;
+	status = "okay";
+};
+
+&mii_conv3 {
+	renesas,miic-input = <ETHSS_GMAC1_PORT>;
+	status = "okay";
+};
+
 &ohci {
 	dr_mode = "otg";
 	status = "okay";
-- 
2.43.0



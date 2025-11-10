Return-Path: <linux-kernel+bounces-892801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 94415C45DE3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4A1D4EEDCB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FA230594F;
	Mon, 10 Nov 2025 10:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rootcommit.com header.i=@rootcommit.com header.b="r67goI2W"
Received: from siberian.tulip.relay.mailchannels.net (siberian.tulip.relay.mailchannels.net [23.83.218.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88A4303CBE;
	Mon, 10 Nov 2025 10:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762769496; cv=pass; b=liCs83tVdARoYkK4dpgXCiXj0bleS1lNvEAfk8kwf5+Spz5hFT5h8qb7HpAn2/suP4I4gidjIqedkVme4f4qBR9DclVVeHwSayrQoaTbs5IDpKHyJjVa09Y+CQNpQk1KD8nvtmecVfhx2XuTJeCw4bMoDX4KlaJCyEB6JLEHqsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762769496; c=relaxed/simple;
	bh=YjrqpSZyUzBHbA3mjccVbn4n+V8LozphFrlQKfwL/oI=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Date; b=CccLYmO8tGn6/sqRlhfF/L5gmzSQXaQvrYejXM795QXxnNsw4QOxrhQuNF5/lSALGJRO9bJXanZOJe28jIqSYmD5fY7CNwqZUSnTCQDV8NQ2GQp873nBPZcE1+/VlvfjtjGBxOdS48GPNSMQwvS81Bsga7hO/xpdHAq45i4xjHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rootcommit.com; spf=pass smtp.mailfrom=rootcommit.com; dkim=pass (2048-bit key) header.d=rootcommit.com header.i=@rootcommit.com header.b=r67goI2W; arc=pass smtp.client-ip=23.83.218.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rootcommit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 1E1B34C20E8;
	Mon, 10 Nov 2025 10:11:27 +0000 (UTC)
Received: from fr-int-smtpout19.hostinger.io (trex-green-3.trex.outbound.svc.cluster.local [100.124.155.193])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 7E4EE4C160B;
	Mon, 10 Nov 2025 10:11:24 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1762769486; a=rsa-sha256;
	cv=none;
	b=4XMHq6lEP1L4W+Uq31UEndziNpXM3z/BHY6sxe/t0xe4kxuINch9d391zYTD8HP/nO3gMy
	0ynDQjDRvx/GaO5grHOThZUH81YSeBcwXvnfmSffcnl0QbZ+NTkTLQubsX3jokAT0xDBj3
	xu32YzQULW2u1PGSlcVOi4u5dHi+P8qio91NISey/hqFIKFZrG/iucUu2CdumstdcECWyh
	Ao2E9uTti47CMF0dQyLdxn+m9/G7SlColfT9RbjYhm4zWKwSbkkbPyRxzyIDNiubqPLM6t
	FXAYJA421UYi0gdI709AdIbz1meomLsNm7WWGFSVRYdRWRf7REKNXBcBWM/Glg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1762769486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Xv4qtdoTRgEtEjLgDMNE/Omj14M13wzp5a5JVmEglRk=;
	b=Tbz67d2YfgIu5ItarAWWwbH2V2cFGKmbmy3A4JNsqRMyaEIJ1wLagjP78H1kN694f1XuBE
	WWckedt0leQocISWpKx9iLFYR9l+3Tg2GJ4bEK11ne6aP0rvjVtBZGZxpIHB4pefiO/udu
	vgOfAa/5Y4CK6FE4Et8S6FMY72DtJzCxs0iaEM27CZvw2bNZ21bbcjtqUxX0qqlMZ6x+fF
	LJ4nWCyI8nHkdJE/YtDYbqLGawY313A8MQjIzuLlIC+T9TXU1Sx9PeklreSprqDPoqhcZc
	sOUPaCFotWRT1ff6DvFkOkPJBoEBL+TYLBaQhzp+8j/mG9H47VTi1+j/54ZtCA==
ARC-Authentication-Results: i=1;
	rspamd-77bb85d8d5-r7qnn;
	auth=pass smtp.auth=hostingeremail
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MC-Relay: Neutral
X-MailChannels-SenderId:
 hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MailChannels-Auth-Id: hostingeremail
X-Sponge-Army: 13dc4e3f5c0efe05_1762769486916_4271747599
X-MC-Loop-Signature: 1762769486916:2648717695
X-MC-Ingress-Time: 1762769486915
Received: from fr-int-smtpout19.hostinger.io (fr-int-smtpout19.hostinger.io
 [148.222.54.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.124.155.193 (trex/7.1.3);
	Mon, 10 Nov 2025 10:11:26 +0000
Received: from localhost.localdomain (unknown [IPv6:2001:861:4450:d360:7d90:b645:1639:d009])
	(Authenticated sender: michael.opdenacker@rootcommit.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4d4ln62cQ6z1yFF;
	Mon, 10 Nov 2025 10:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
	s=hostingermail-a; t=1762769482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xv4qtdoTRgEtEjLgDMNE/Omj14M13wzp5a5JVmEglRk=;
	b=r67goI2WtwKWjRdB0dSsLUqcRVEl3aCwPydWJdSN5v/uU+ILENn7yUjqn9g62e/IlqP/7J
	YvQdtWoV/nS8mcSFerJRDW0v7VXjSJID8/esPKFgTRU4a/emmWi5o+ecHiP8U+ppZ/QJbw
	bM8TQ2rvfD3G8ixSaHIKB+JPpHar+mNbwYbVCLz4f8EHFtoKE1lgDB4otyvHrXTq01qSkG
	xUxuGDtCqDfHCJrdtgS1XTAw1VZZRicrSErdsh4uwTvQ3e/PZt8q/Qfw6XRyTpWw8l/Vv1
	YPtHz3nAjiB1T3eKndj2bBdlJu2UDD3ZqIutwEXDLj2eqMiQUwRLOcYZ7n0PfQ==
From: michael.opdenacker@rootcommit.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@gentoo.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] riscv: dts: spacemit: Add OrangePi R2S board device tree
Message-ID: <20251110101110.948198-3-michael.opdenacker@rootcommit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110101110.948198-1-michael.opdenacker@rootcommit.com>
References: <20251110101110.948198-1-michael.opdenacker@rootcommit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Date: Mon, 10 Nov 2025 10:11:22 +0000 (UTC)
X-CM-Envelope: MS4xfCeK8aUdEUFri1FAtnPP6OhGpNiXrx/Ze5NW5ki3QmowvTEritrHWdGVijZwccCxiyziHh7W9/Xs1NJcUzH10Ts+lvJdqoTGSAy7KvchMNHtPq4xzBSm 4qSakyjdKPR14JMv5adGCNxIIliinDEBJRw0PylnmYWEx/zOOCIUcjLpvI84kwHgG9JxDdg9/G8DHwQmYYfFL/J3AYZAqhiy9FFMrIBCKpICVD5Ut5h3Ya8c xZR6LM6nva+hrFP27xXQ38rJW2RwPtNb8m95AXQhROfQ0IB+SZhoi6aDpX4oJQLj/Kj6HEnLNe3L7cCegKl8XQ7fWc8xQNhVBY9rlMuaIl6QyCjSn4Z+Z459 5Av/HbG5/jpWLuhwYeW23aDEFCnrS7KzNdhJgl5poS03D9xjwF4VLh2hQ1eRVsnlAQLzUPS5MiZfRkHugkDsa+aVUvG7l4W3Beup5mbe4MDR/sW3ksEXzF9c XGGqRLWVvp5V5nHqS9kgXEYeR9oLT4+5ZdXVzzdyhMn+9881HZTCDfu7lquWYlcC5wgbx9CVdiXyp/185FmY+CBl8JN0qyd6wP334EZOFWHYxjnM0kpTPjO/ QNQxjf9vPjJac7LthTYI28mVJSznW9GsHyDonMv7F3PCSCmlUuITBQw/ed94b5qjsBW0koFbq+UbHBIviOE5CcGgj3/xm13TgDkrTYcO9PNKjQ==
X-CM-Analysis: v=2.4 cv=NuiDcNdJ c=1 sm=1 tr=0 ts=6911ba4a a=G6G7neK3IwemRqrlzYSHdw==:617 a=xqWC_Br6kY4A:10 a=5dAzR5NRAAAA:8 a=lv0vYI88AAAA:8 a=d70CFdQeAAAA:8 a=QbPVFpUTrLpRLxxKV0IA:9 a=9STjDIb-X-UA:10 a=ZKAZAlVgJm32z6MX8p4a:22 a=9qqun4PRrEabIEPCFt1_:22 a=NcxpMcIZDGm-g932nG_k:22
X-AuthUser: michael.opdenacker@rootcommit.com

From: Michael Opdenacker <michael.opdenacker@rootcommit.com>

Add initial device tree support for the OrangePi RV2 board [1], which is
marketed as using the Ky X1 SoC but has been confirmed to be
identical to the SpacemiT K1 [2].

The device tree is similar to the OrangePi RV2 device tree
(k1-orangepi-rv2.dts).

This minimal device tree enables:

- booting into a serial console with UART.

- the two RGMII ethernet ports
  supporting Gigabit Ethernet operation.

  They have an external Motorcomm YT8531C PHY attached,
  the PHY uses GPIO for reset pin control. Their description
  was reused from the DTS from the OrangePi RV2 board.

- PDMA for the SpacemiT K1-based SoC.

- the 8 GB eMMC chip for storage.
  It works fine with the same description as
  on the BananaPi F3 board DTS.

Link: http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/Orange-Pi-R2S.html [1]
Link: https://www.spacemit.com/en/key-stone-k1 [2]

Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
---
 arch/riscv/boot/dts/spacemit/Makefile         |  1 +
 .../boot/dts/spacemit/k1-orangepi-r2s.dts     | 90 +++++++++++++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 arch/riscv/boot/dts/spacemit/k1-orangepi-r2s.dts

diff --git a/arch/riscv/boot/dts/spacemit/Makefile b/arch/riscv/boot/dts/spacemit/Makefile
index 942ecb38bea0..96b3a13a3944 100644
--- a/arch/riscv/boot/dts/spacemit/Makefile
+++ b/arch/riscv/boot/dts/spacemit/Makefile
@@ -3,3 +3,4 @@ dtb-$(CONFIG_ARCH_SPACEMIT) += k1-bananapi-f3.dtb
 dtb-$(CONFIG_ARCH_SPACEMIT) += k1-milkv-jupiter.dtb
 dtb-$(CONFIG_ARCH_SPACEMIT) += k1-musepi-pro.dtb
 dtb-$(CONFIG_ARCH_SPACEMIT) += k1-orangepi-rv2.dtb
+dtb-$(CONFIG_ARCH_SPACEMIT) += k1-orangepi-r2s.dtb
diff --git a/arch/riscv/boot/dts/spacemit/k1-orangepi-r2s.dts b/arch/riscv/boot/dts/spacemit/k1-orangepi-r2s.dts
new file mode 100644
index 000000000000..58098c4a2aab
--- /dev/null
+++ b/arch/riscv/boot/dts/spacemit/k1-orangepi-r2s.dts
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2025 Michael Opdenacker <michael.opdenacker@rootcommit.com>
+ */
+
+/dts-v1/;
+
+#include "k1.dtsi"
+#include "k1-pinctrl.dtsi"
+
+/ {
+	model = "OrangePi R2S";
+	compatible = "xunlong,orangepi-r2s", "spacemit,k1";
+
+	aliases {
+		serial0 = &uart0;
+		ethernet0 = &eth0;
+		ethernet1 = &eth1;
+	};
+
+	chosen {
+		stdout-path = "serial0";
+	};
+};
+
+&emmc {
+	bus-width = <8>;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+	non-removable;
+	no-sd;
+	no-sdio;
+	status = "okay";
+};
+
+&eth0 {
+	phy-handle = <&rgmii0>;
+	phy-mode = "rgmii-id";
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac0_cfg>;
+	rx-internal-delay-ps = <0>;
+	tx-internal-delay-ps = <0>;
+	status = "okay";
+
+	mdio-bus {
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+
+		reset-gpios = <&gpio K1_GPIO(110) GPIO_ACTIVE_LOW>;
+		reset-delay-us = <10000>;
+		reset-post-delay-us = <100000>;
+
+		rgmii0: phy@1 {
+			reg = <0x1>;
+		};
+	};
+};
+
+&eth1 {
+	phy-handle = <&rgmii1>;
+	phy-mode = "rgmii-id";
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac1_cfg>;
+	rx-internal-delay-ps = <0>;
+	tx-internal-delay-ps = <250>;
+	status = "okay";
+
+	mdio-bus {
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+
+		reset-gpios = <&gpio K1_GPIO(115) GPIO_ACTIVE_LOW>;
+		reset-delay-us = <10000>;
+		reset-post-delay-us = <100000>;
+
+		rgmii1: phy@1 {
+			reg = <0x1>;
+		};
+	};
+};
+
+&pdma {
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_2_cfg>;
+	status = "okay";
+};


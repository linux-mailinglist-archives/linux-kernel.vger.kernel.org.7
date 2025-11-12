Return-Path: <linux-kernel+bounces-896537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D8CC509BB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70075189A78B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 05:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4731C2D8764;
	Wed, 12 Nov 2025 05:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rootcommit.com header.i=@rootcommit.com header.b="Uts+Wrhf"
Received: from dog.elm.relay.mailchannels.net (dog.elm.relay.mailchannels.net [23.83.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31DC2D2384;
	Wed, 12 Nov 2025 05:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762925058; cv=pass; b=VdW+EXzKaIjo+iWDC8ueo1JKd/NKWQ2WJt+mLFD9WhtMBSZf1jB4a/fKe+mHkxBnb7TlmYaIdRVVKuOHAGzJAb+uZWe9KK1HcT2Ro8KofVFigiunhau2XmU0BRrYXAzQYlN21QU6mJaYembhRFVUdgbLHSi87mQaZWxIxPaOBdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762925058; c=relaxed/simple;
	bh=oChWLPsQFmUOub4GztOaXtftqGbPBPBTmNQUNbRIu4I=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Date; b=jrum6KOxfvGOYJkthQZy2/Fatm0eqq6JYmw//IXMsI0cXv8Olj5a2ufICj6YW+pQW8TPPHMU4EoV1/fQ/xXm3CRrZtbHinNvNNgaQvVuBakhxSM6OkW0PuhFTpC3vLhkTczHgb7h8tG6ihAhh0H4YwyzWIeMLpfoJwRJ80/SzOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rootcommit.com; spf=pass smtp.mailfrom=rootcommit.com; dkim=pass (2048-bit key) header.d=rootcommit.com header.i=@rootcommit.com header.b=Uts+Wrhf; arc=pass smtp.client-ip=23.83.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rootcommit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id AFF44120D61;
	Wed, 12 Nov 2025 04:44:46 +0000 (UTC)
Received: from de-fra-smtpout9.hostinger.io (100-124-9-98.trex-nlb.outbound.svc.cluster.local [100.124.9.98])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 3D35A120702;
	Wed, 12 Nov 2025 04:44:44 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1762922686; a=rsa-sha256;
	cv=none;
	b=s5hAP2gGaLMU5iwM1Q+OX6QaNopqW0Y6fF2pCdZ51pr1IN6SMsBuN7msVfUxDjR9nYbYbx
	ed27ZHatMQg3bsNqTAzm9aw8eVNtlfkTCEnraCOIuAu2yX40c79R3BKAzku1vj2FeKWKcl
	VcM/FCoIbrbbuuUYSGgAhqvXU9TxWm1Clsy0gbPj6/f3CFGbVe8UlBRzTpX+UFdIRQ8xAJ
	zJnw1oEL+08zI161XAiYrPrtduXJZFrhzBhv3GFAQsdEcRhRzvvLV8ABc5EQw9fE9r20+g
	CLmRqcG6vK8f1auzoqfk6DJz9WgNi6U3GsOopsa2F392JcRUKqbeA1kOvDnS4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1762922686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=JmSvlEEsv1EZGdl+whPLN9xF82hq2ZE8qaSfdvPVZaY=;
	b=gaohw1ZWqEEGUp/tV3BgJLkVzd8rjh5WBfISI90c1t/2vR8NGV9eyJHO93VVaeHySVoDe7
	82zciRkSkLxCtSOByJgsF0z7EtsrAyaUjgwDLlmoEmyhLgBLnnDLdP7qqf96oFjA/9faqv
	RLWvbdBa8vp58cP8KBeGGka4GvDn0QP5aGbVe1SanURLUVpTAMcFZqVC2P9NlWZN0auW1s
	SNcdd2KoBF/4Vw3fNko02nnZoMHcUH4cNZrGMRWrN5yKKVU9FaIWQ2LA4X5WlMXAbwJakk
	Wqk9A+DZ7nNfHUF76fqsaBIAoUv10QMYWRa2SyRr2UgCYjLscxtkD73SpQ037A==
ARC-Authentication-Results: i=1;
	rspamd-768b565cdb-dvdb4;
	auth=pass smtp.auth=hostingeremail
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MC-Relay: Neutral
X-MailChannels-SenderId:
 hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MailChannels-Auth-Id: hostingeremail
X-Keen-White: 096a509d1d464c59_1762922686615_3968737305
X-MC-Loop-Signature: 1762922686615:293400609
X-MC-Ingress-Time: 1762922686615
Received: from de-fra-smtpout9.hostinger.io (de-fra-smtpout9.hostinger.io
 [148.222.55.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.124.9.98 (trex/7.1.3);
	Wed, 12 Nov 2025 04:44:46 +0000
Received: from localhost.localdomain (unknown [IPv6:2001:861:4450:d360:e24a:32fa:a400:91c])
	(Authenticated sender: michael.opdenacker@rootcommit.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4d5rRG14J1z3yjX;
	Wed, 12 Nov 2025 04:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
	s=hostingermail-a; t=1762922682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JmSvlEEsv1EZGdl+whPLN9xF82hq2ZE8qaSfdvPVZaY=;
	b=Uts+WrhfGoamV7XEfW+MF+gh4orOLYU/VhX9Fzi0b+UM39f1x016WIhXxcpg8vMV+VX211
	ZmHpDhBEYIZaaslkBVBuNS/hd0U+aPV3CL0dA/IOLW8iwhNrcY1akQ+ZB0vjP/xxIEviQS
	esX5Fv4S0pliwaKvH8FLWT2yFm74YI4nsXD9srmILiqOHNtb8zSjOoMsjv31Uw9lKFrhED
	CRFSYr8PhVHwOZbVte7vMYrL9KiQiEQVECia23eFZsUXjST3DMkNbY+3B+g9j8znuZTZtb
	3yczie7qu6i/o5PVFGd67yCs0nc01nAPvERT/CfSOEcwKY7AFtsg76fZfr7oqw==
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
Subject: [PATCH v4 2/2] riscv: dts: spacemit: Add OrangePi R2S board device tree
Message-ID: <20251112044426.2351999-3-michael.opdenacker@rootcommit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112044426.2351999-1-michael.opdenacker@rootcommit.com>
References: <20251112044426.2351999-1-michael.opdenacker@rootcommit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Date: Wed, 12 Nov 2025 04:44:42 +0000 (UTC)
X-CM-Envelope: MS4xfNcQjoB4OUAYS+IINXIL/JUmHVWJokHEHYeKKdtgx/pB3y9ixCfqWGs2ITiK6mM6ompulTu4jLUvzR/dkUZleUOPJyWkE02yQLZR5WG5Y0m0I2UrU5jQ yn/7nJtdqZUI4IkZFm+AotrvmfYdu3jZMUgEtRB1Vxu1fMdxv+ZxJegfHihhXX3txa6JdtxLK6LWDXnubJdk0Bqc0go236vPkPDfpAQanoOcuwD8hh+eSKO8 4hjKPhQXoNtUTANl29yb1Yq5AwYpCjqgVKsnBqATGAln5sQYfSmppIfQj5Vl1/G0LSFJKducbyDJ4CliL/0H7GdaIPYF+PodMD4bmyJ+IiejGCIWprrY64JU kk4/3FPUYJ+xHRv9A8WSvwQpLB1sC0Xd+VRRDVTf7qAWlAj6klKIi7dZ5okzZAkyiuK4PlqKVsrFT2DU4Yoi5lgfV+q0rAsYaShiDE0fIT35tA4+6na+a7YS cunTH0GVu7yWLycCJAiXwYR6oQNDxnP4Z1i2hBbCBFX1klSudgeQ1VG++mk6oMvBNj7xTM4lq3rfxxqaBImTD9gkKjeV+pP9AYPeWEFhYpoU5Pv8ycxOntc6 C0Kd9RDUEivUiOIIUKWW5iWR8MkNvARG1WGK3SwfpePMddD33kAmEnedUKmA0ABxbXsJFKx6agBCeFz6eXIMC3q2ou8vs7CyOrP6MBlxV59wBw==
X-CM-Analysis: v=2.4 cv=etGNzZpX c=1 sm=1 tr=0 ts=691410ba a=XVsSf4j1YTBLvHmD+RU1sw==:617 a=xqWC_Br6kY4A:10 a=5dAzR5NRAAAA:8 a=lv0vYI88AAAA:8 a=d70CFdQeAAAA:8 a=MVgXUy26Hj1uv-KAJh8A:9 a=9STjDIb-X-UA:10 a=ZKAZAlVgJm32z6MX8p4a:22 a=9qqun4PRrEabIEPCFt1_:22 a=NcxpMcIZDGm-g932nG_k:22
X-AuthUser: michael.opdenacker@rootcommit.com

From: Michael Opdenacker <michael.opdenacker@rootcommit.com>

Add initial device tree support for the OrangePi RV2 board [1], which is
marketed as using the Ky X1 SoC but is identical in die and package
to the SpacemiT K1 SoC [2].

Enable UART0, to boot into a serial console

Two Gigabit Ethernet ports with RGMII interface standard support
are enabled, each port is connected to an external
Motorcomm YT8531C PHY chip which uses the GPIO for reset control.

Enable PDMA.

Enable 8 GB eMMC chip for storage.

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


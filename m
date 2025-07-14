Return-Path: <linux-kernel+bounces-729822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72633B03C00
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350E23A3BE6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F4D245006;
	Mon, 14 Jul 2025 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="Sth0hU4N"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDDF2441A0;
	Mon, 14 Jul 2025 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489389; cv=none; b=H0pBueRhp1qW7fxsohXwc9gC43Iv0HDNzbY85VfPi8FymWyvwbYM9GXhn2rFaF5uyvwUNAHuxUNyXNklv9FSK7i0ltB2zauO4mM0Er1US2yAkf/g5squv8RRBkFhhCwG7kz+aqDUQgrTcrCBL0pCh1B1268NcqiPmbP3leTWaJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489389; c=relaxed/simple;
	bh=eihv/WLKuds+ejTS4D7IiQymipLVGEz4ktuYQiXfyOs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MHOQcKzj9px51EQQKjgbddmB15p3nDYCe953tmCtMn5hMtW3xvW7afw86fC7I36z0zl8xRfBo+CIHmJZXCcHlMoppxdVKwazqwQNdfcAggmvNz2Sd2TsoMogtHSle/5cjsTC2vBrXLaEi3A8yclhOuMngagWaHwA0dMif+wtWns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=Sth0hU4N; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5RnWE8Ygsf6YGJd0DVniDSNOEKXVvEcC+0NZbP3MQSw=; b=Sth0hU4N6oWEa4M7hiRQG5QKuA
	ncVTUQvfjHf4pVE4tEXM2Im5wgae3XOaSfumAzZzUAe9uMkbdDziWeNCIRg6qWzJKsm5L1z/IwQdg
	ZY0OKwH4gnGXc/v+8QG+CjoUk6Go2WNYaDHboSo5yg8IcEItnmgvIJTS/aBOw7i47hn/NqeMTSOaF
	+6XJjaykSXJmDxgKYzMPmLOoJvdQeD61EOYWyxYoz+sYsljz/47CJUhZmAXD/+qNdI6CZMe9Q3DEv
	OCfOqEmj6wEA/9v8spnp3503TFP1sFhrPdgBsnnaCxAAHRT9LBVlSN+fWdtHWuC63vi0buSyblnBg
	D/GXzmpA==;
Received: from [89.212.21.243] (port=57634 helo=localhost.localdomain)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1ubGXp-001ATQ-1V;
	Mon, 14 Jul 2025 12:36:25 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH] arm64: dts: freescale: imx93-phyboard-nash: Add current sense amplifier
Date: Mon, 14 Jul 2025 12:36:24 +0200
Message-Id: <20250714103624.857493-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

There is a current sensing circuitry on the phyBOARD-Nash-i.MX93 capable
of measuring input current consumption of the phyCORE-i.MX93 SoM @ 3.3V.
Circuity consists of MAX4372 current-sense amplifier (50V/V) with two 70
mOhm shunts resistors in parallel configuration (effective R = 35 mOhm)
connected to the SoC internal 12-bit ADC channel #1 (Vref = 1.8V) via
voltage divider with ratio of 1/2. This results in a current scaling
factor of 0.502232142 mA/LSB.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts b/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts
index 00143f201876..8de7e174976f 100644
--- a/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts
@@ -28,6 +28,14 @@ chosen {
 		stdout-path = &lpuart1;
 	};
 
+	current-sense {
+		compatible = "current-sense-amplifier";
+		io-channels = <&adc1 1>;
+		sense-gain-div = <2>;
+		sense-gain-mult = <50>;
+		sense-resistor-micro-ohms = <35000>;
+	};
+
 	flexcan1_tc: can-phy0 {
 		compatible = "ti,tcan1042";
 		#phy-cells = <0>;
-- 
2.34.1



Return-Path: <linux-kernel+bounces-818370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E69F3B590AE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09A6A17B72D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FD8271479;
	Tue, 16 Sep 2025 08:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="I4ErOmQa"
Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371021BE871;
	Tue, 16 Sep 2025 08:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.12.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011451; cv=none; b=WS65Is7OY9Ch4rSvFus04OYZ2ypbmt4nsoHiHFCjcu6XJniHnJWLF+mxDsOfH2tumdqSQwZM6GOY7oeskgL07f3Wpcb0IpfRCsENEaAXIf9P18EhDdo56dgPuAaEXaFnyQ+nWxPJVUhIun4N+x8vthZafg9hxFT+thMJQ4CSRTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011451; c=relaxed/simple;
	bh=4wsksbPJvdzOs0Q/GUgi8mJkvyCPp3MeG6V+HD6zlEE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ig+UyLSfZ8VCczEIJ/iiz9UI1c5jLecnVjUGgi51n9Smo179EQWfpn36VCvEpe2ELu6AtJbeQ5lFtpcsviETIx11xOJfE/R1JHlFUm24ZA60J5b6yHPkgXs8+SwuZAaxemAs1+Oxpj0fdI/h/eCCRPg3QcBoXjeYlHel/gpE97g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=I4ErOmQa; arc=none smtp.client-ip=46.19.12.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=BkwsvX2mih3Bl3T0kiwBdBTpuq596F+gY6R6yhLMVYk=; b=I4ErOmQaWuUZh+AkBJsyJYNadh
	B5QYfcEuJxOA45LgcJHiCWhNG9zqoTLDhAP77ZkmC1PdW5pU5zn/tnbapJzULiytenVz9MHEPe5Ug
	QCnX3uUjfWmCqJoXT0Ahfd5/rkpm4en1NrUNWGOc37jB4Nw/VXRHYNSiHdwifigrRh4TmKQOhfriI
	3IxGXhaAXXQ/610duragA0eE+Ncl9MxkcngikuD/z1oicxzmHSskEpoc14lcashqlKQvzAov4ePCO
	2I8rJ2nirS+/Zc5433KfUSzNxrb2/S54QZ8+zyrRLDWuzKwCnHTBQeOuLimGknPnyfOZQL2yyThch
	KdMpFIYg==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:37984 helo=localhost.localdomain)
	by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1uyQhx-0000000DK9c-3JVv;
	Tue, 16 Sep 2025 10:06:36 +0200
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
Subject: [PATCH 1/2] arm64: dts: freescale: imx93-phyboard-nash: Add USB vbus regulators
Date: Tue, 16 Sep 2025 10:06:34 +0200
Message-Id: <20250916080635.1520551-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp2.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cp2.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cp2.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Add USB vbus regulators to silence the following kernel warnings:

  usb_phy_generic usbphynop1: dummy supplies not allowed for exclusive requests (id=vbus)
  usb_phy_generic usbphynop2: dummy supplies not allowed for exclusive requests (id=vbus)

Because generic USB PHY driver requires exclusive vbus regulators since
commit 75fd6485ccce ("usb: phy: generic: Get the vbus supply").

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 .../dts/freescale/imx93-phyboard-nash.dts     | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts b/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts
index 5599e296919f..9e875e082ee8 100644
--- a/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts
@@ -71,6 +71,22 @@ iio-hwmon {
 		io-channels = <&curr_sens 0>;
 	};
 
+	reg_usb1_vbus: regulator-usb1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "USB1_VBUS";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	reg_usb2_vbus: regulator-usb2-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "USB2_VBUS";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
 	reg_usdhc2_vmmc: regulator-usdhc2 {
 		compatible = "regulator-fixed";
 		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
@@ -187,6 +203,14 @@ &lpuart7 {
 };
 
 /* USB */
+&usbphynop1 {
+	vbus-supply = <&reg_usb1_vbus>;
+};
+
+&usbphynop2 {
+	vbus-supply = <&reg_usb2_vbus>;
+};
+
 &usbotg1 {
 	disable-over-current;
 	dr_mode = "otg";
-- 
2.34.1



Return-Path: <linux-kernel+bounces-860572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CDDBF06E6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CE301890AF3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E632F2F658A;
	Mon, 20 Oct 2025 10:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="fhCdSmbw"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700A22F6563
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954885; cv=none; b=K8z2RtoNbls9k55vAXao7jiFH69BhMgIx6YIMdu8Os/+yqsbpxdG8FhiMGnEreGIBPfQl/OAA0x1v3Lz3gZSJ1KiYkLIg+xuK7xdHF5iqjGWsJxsvpwVFnw7mlavB4aIiXzSXgJRpdkmyV3wfrv8TuEZF7GYDTQTT2NlRx9nKX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954885; c=relaxed/simple;
	bh=JZPJieBpJjFKRf9NMX2EuFbbhAFom0J/M+0q+S+EI1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uf+T+l55w64TH248mZ3SnqpZ3PgS9tWmQChEo/ACK6ZOqxVxwLmLlWxnYm7riNQf0DkjSUFlCb/mdMoUzKiWJqn1/TOXL5t5SD+SVN9VjaI92/zDE0zJmURNIu+i3R26VPotr21dJuU/3ESVdV2514bb65FEuUYplG85EUKdQZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=fhCdSmbw; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=hBNAS5M1hQOxxlrANdSff3GZBvV5T3wowX7znoz7cEM=; b=fhCdSmbwx7yd07UWQjihZgYCqB
	HrORil8TilBFrQpmlUE1aauEc5o4g8xn1aHAzgEzuKfdh1INr3eDoCL13+uS2U1gR7v0jxHoYUntR
	B7Tobhyhp7cjA4WcsP/7lOUDyDyD9V69OrptEGh1iMUOGS0oPsu6hngKmK1r4wpr9U5vHnjShl/Ex
	dN0g+J6ombfz3NZiFENa5Bu3zdLtfcYr87UXRkezFh+bCXh9pHZ+m+1ZjprZCikF6bq5f0BhxjnYr
	zKj4GfPz5xTpv+EtdWhn5WEwwTRbhBifcR2ZiRDvVPJPbk+aWTThEs6TYHIJL5r4QXoacXafcZPxZ
	DMuYUKFg==;
Received: from [141.76.253.240] (helo=phil.eduroam.local)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vAmo4-00083f-CR; Mon, 20 Oct 2025 12:08:00 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@cherry.de,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 3/3] arm64: dts: rockchip: Correctly describe the ethernet phy on rk3368-lion
Date: Mon, 20 Oct 2025 12:07:57 +0200
Message-ID: <20251020100757.3669681-4-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251020100757.3669681-1-heiko@sntech.de>
References: <20251020100757.3669681-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

So far, the board used the phy implicitly using the deprecated snps reset
properties. Improve that and describe the PHY correctly under the new
mdio node.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi | 22 ++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi b/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
index 8ccc3184a836..61c52bd91784 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
@@ -154,13 +154,11 @@ &gmac {
 	assigned-clocks = <&cru SCLK_MAC>;
 	assigned-clock-parents = <&ext_gmac>;
 	clock_in_out = "input";
+	phy-handle = <&vsc8531_2>;
 	phy-supply = <&vcc33_io>;
 	phy-mode = "rgmii";
 	pinctrl-names = "default";
 	pinctrl-0 = <&rgmii_pins>;
-	snps,reset-active-low;
-	snps,reset-delays-us = <0 10000 50000>;
-	snps,reset-gpio = <&gpio3 RK_PB3 GPIO_ACTIVE_LOW>;
 	tx_delay = <0x10>;
 	rx_delay = <0x10>;
 	status = "okay";
@@ -285,7 +283,25 @@ &io_domains {
 	status = "okay";
 };
 
+&mdio {
+	vsc8531_2: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&phy_rst>;
+		reset-assert-us = <10000>;
+		reset-deassert-us = <50000>;
+		reset-gpios = <&gpio3 RK_PB3 GPIO_ACTIVE_LOW>;
+	};
+};
+
 &pinctrl {
+	ethernet {
+		phy_rst: phy-rst {
+			rockchip,pins = <3 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	leds {
 		module_led_pins: module-led-pins {
 			rockchip,pins =
-- 
2.47.2



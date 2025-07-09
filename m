Return-Path: <linux-kernel+bounces-723694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF93DAFEA06
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA6337A8CC4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC0E2DECB3;
	Wed,  9 Jul 2025 13:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="0amw15gc"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F908290092
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067418; cv=none; b=F5KUojFn5RFD7td5nnw/wsLCQIQVvTL4jizGh7mJiYg7qOcDqmd6xRMKIIe09PMn/21phvOgjBjOHxMttyZkQhxbvY7kytQ3UWh6tbBO2lL/fnSYDxuhvKsimUBCxDzhSqzSNcK2x2AM5gWDqsB0dGFmpnrBTEP57yHxajRo28U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067418; c=relaxed/simple;
	bh=hbCzQra53cQbm9JlGw6eJnRUtAkwWzYlXHL/2fHuU80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bbrYvUKZ2cmHVUvcRk/58z0WfJ1VdHR85c6oltp8r7Sw/tB0rjO1oYCeUuKbuL2ixtGJmYmo4UTXWr7Mjv9tbdWLHCEOIp6PhI07M0HAwW859vq0WYZ3OGnjrQstBo6p/yFFZZTnUTciFjqqNiLNp4YKZGMc94/aCA53HjEtz3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=0amw15gc; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1752067414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nOh9E6KTw/G/RjNvzFhSoJb3dEHhHttr0OlC9cZGWdE=;
	b=0amw15gcaBpnOB/8CDQ13CKbnZ6BR1R38ikYGdeziEhiZRtos5mxL+B1VIaxCKvJEpqBRm
	iGCsqMwlrGBswFFfTV0r7iqfvqMJZNk9DQnt8irpGoJht1rXCxYb0ql/LNbTwKyLpItGcv
	vCxXoSnMZBgr7egmchNaOPZxEkxlQewN3FlaDt0oiSb0gZkZ7Q8VyuY1EBC/n92jRugbYj
	fC9TRL37c2PulEwj5NNgWtxhGh1I1IWvish4z+QrCl0dmYJPKryhDey9MptzXnVBNgsiLQ
	x19sCPLpBgYEVz7+40/8fFfEJuT9+9VD2a8E84zeu2q6s1+VPJe03gLW4+Sn5g==
From: Diederik de Haas <didi.debian@cknow.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Dragan Simic <dsimic@manjaro.org>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Johan Jonker <jbx6244@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH v4 02/10] arm64: dts: rockchip: Move dsi address+size-cells from SoC to rk3399 boards
Date: Wed,  9 Jul 2025 15:15:15 +0200
Message-ID: <20250709132323.128757-3-didi.debian@cknow.org>
In-Reply-To: <20250709132323.128757-1-didi.debian@cknow.org>
References: <20250709132323.128757-1-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The #address-cells and #size-cells properties are not useful on the DSI
controller node; they are only useful/required on ports and panel(s).
So remove them from the controller node and add them where actually
needed on the various rk3399 based boards.

This fixes the following DTB validation warnings:

  unnecessary #address-cells/#size-cells without "ranges",
  "dma-ranges" or child "reg" property

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-base.dtsi             | 4 ----
 arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi      | 4 +++-
 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts     | 2 ++
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64-screen.dtso | 3 +--
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-base.dtsi
index 9d5f5b083e3c..4dcceb9136b7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-base.dtsi
@@ -2071,8 +2071,6 @@ mipi_dsi: dsi@ff960000 {
 		resets = <&cru SRST_P_MIPI_DSI0>;
 		reset-names = "apb";
 		rockchip,grf = <&grf>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		status = "disabled";
 
 		ports {
@@ -2112,8 +2110,6 @@ mipi_dsi1: dsi@ff968000 {
 		resets = <&cru SRST_P_MIPI_DSI1>;
 		reset-names = "apb";
 		rockchip,grf = <&grf>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		#phy-cells = <0>;
 		status = "disabled";
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
index 5e068377a0a2..6aaaf0f7f73f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
@@ -627,8 +627,10 @@ &mipi_dphy_rx0 {
 };
 
 &mipi_dsi {
-	status = "okay";
 	clock-master;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
 
 	ports {
 		mipi_out: port@1 {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
index 909ed14035f7..fe32937a2d16 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
@@ -464,6 +464,8 @@ &io_domains {
 
 &mipi_dsi {
 	clock-master;
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 
 	panel@0 {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64-screen.dtso b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64-screen.dtso
index b1f4ab22b99c..a26c8e05c13b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64-screen.dtso
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64-screen.dtso
@@ -47,10 +47,9 @@ touch: touchscreen@5d {
 };
 
 &mipi_dsi {
+	clock-master;
 	#address-cells = <1>;
 	#size-cells = <0>;
-
-	clock-master;
 	status = "okay";
 
 	ports {
-- 
2.50.0



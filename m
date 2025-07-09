Return-Path: <linux-kernel+bounces-723697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 449B0AFEA11
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F35215A73B5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73612E4257;
	Wed,  9 Jul 2025 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="0KxKgpxq"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623732DFF3F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067421; cv=none; b=K3YhHz12ajTz8egkjAKgN9KOhIDli0PoKKxg4+xRmiEH5tGAyfUEtW48lZPt7aeCzIfSa5pE3SVlyO0NiycY/Isx7V2mm99TO1FsZsTAWUd8ZS/txvKf1c99s2QV5dAKDxeeG2CISNfqTkdEmwy6h3Sq/Zw5zrYvmnivMOkghXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067421; c=relaxed/simple;
	bh=++WUmsmG42FBtz0N90d+3dm2z4DuzAvjfBgwxUM5j6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bm/T0TdRdbHAs2WtPoc/LSL/oRg5oC02GAX/KpMp5bMSwtTApeLYc/NtXksqSq34d4honGcPY2UqHXto25+HQToWiBz/wbcZ/Lxosr7NQ1q3oWJ45qEiNGHYYsCTj03N5Gy2VFMyrXV8dK4ZcytJ8yu5e2i/ClKZnNh0TI4wuFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=0KxKgpxq; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1752067417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JXGz2WRYkb5YR3U/LDov8OvZiUYlL4TD2HwVbGHyw/0=;
	b=0KxKgpxqDV1ZI4oKLSpkMvqRtnjL/Nc/0t07ibxNqLThuLJHY0a6XTTv0vn6X5I/H/2CEQ
	VSxsSzMSZUSOCUdR87HPS3j3bIe+G30YyZB7KultcBmZ6/L/otMqkMQ3kSVo+Z5bWbPfSy
	r0Sj0QHXqIJXBt4djIxptPXk/7cPrVk7GM3OjfB7XKZmkyt62r73ZKC5/ZDMnn/Ek/D8I9
	AyC4bxHaIbPkhhOO7GJdZO81UVctqoGVQij0JyPqTZafvlCv+8jVhEoZsWP6v0PSLadSHY
	AMhEg8pJ6pLWXJco2PIGc9W24yWAqSs3Krjl76MT9yaHQ6pDizxcHDKslEf5bQ==
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
Subject: [PATCH v4 05/10] arm64: dts: rockchip: Simplify edp endpoints on several rk3399 boards
Date: Wed,  9 Jul 2025 15:15:18 +0200
Message-ID: <20250709132323.128757-6-didi.debian@cknow.org>
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

The only thing actually added here is a single endpoint on edp_out,
which is already defined in rk3399-base.dtsi, so it's simpler to just
reference that phandle, which allows the removal of several properties.

This fixes the following DTB validation warnings:

  graph node has single child node 'endpoint@0',
  #address-cells/#size-cells are not necessary

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
 .../boot/dts/rockchip/rk3399-gru-chromebook.dtsi | 15 ++++-----------
 .../boot/dts/rockchip/rk3399-pinebook-pro.dts    | 15 ++++-----------
 .../dts/rockchip/rk3399-sapphire-excavator.dts   | 16 ++++------------
 3 files changed, 12 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
index a9ea4b0daa04..9d07353df52c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
@@ -250,18 +250,11 @@ &edp {
 	 */
 	assigned-clocks = <&cru PCLK_EDP>;
 	assigned-clock-rates = <24000000>;
+};
 
-	ports {
-		edp_out: port@1 {
-			reg = <1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			edp_out_panel: endpoint@0 {
-				reg = <0>;
-				remote-endpoint = <&panel_in_edp>;
-			};
-		};
+&edp_out {
+	edp_out_panel: endpoint {
+		remote-endpoint = <&panel_in_edp>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
index 5473070823cb..5a8551d9ffe4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
@@ -404,18 +404,11 @@ &edp {
 	pinctrl-names = "default";
 	pinctrl-0 = <&edp_hpd>;
 	status = "okay";
+};
 
-	ports {
-		edp_out: port@1 {
-			reg = <1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			edp_out_panel: endpoint@0 {
-				reg = <0>;
-				remote-endpoint = <&panel_in_edp>;
-			};
-		};
+&edp_out {
+	edp_out_panel: endpoint {
+		remote-endpoint = <&panel_in_edp>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts b/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts
index fdaa8472b7a7..a4ceafe6dd7a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts
@@ -142,21 +142,13 @@ sdio_pwrseq: sdio-pwrseq {
 
 &edp {
 	status = "okay";
+};
 
-	ports {
-		edp_out: port@1 {
-			reg = <1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			edp_out_panel: endpoint@0 {
-				reg = <0>;
-				remote-endpoint = <&panel_in_edp>;
-			};
-		};
+&edp_out {
+	edp_out_panel: endpoint {
+		remote-endpoint = <&panel_in_edp>;
 	};
 };
-
 &i2c1 {
 	i2c-scl-rising-time-ns = <300>;
 	i2c-scl-falling-time-ns = <15>;
-- 
2.50.0



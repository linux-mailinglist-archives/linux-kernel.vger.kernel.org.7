Return-Path: <linux-kernel+bounces-860429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F375DBF01CA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA1B33AAE2F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92EC2ED144;
	Mon, 20 Oct 2025 09:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="TUGEX9wR"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382F441C62
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951518; cv=none; b=nalYd3vtwjN1LWtyJYjJRsV6dt+N+RhA6XMWXOTxT91XxvgZZoTCvnNCjrtWuy23WsjSQnKeVNCjulf7YHtb/+CuGipnjm1VGes/m+90U4LKIqVunpYwo9E6w/bnALpumOXsStbYE6cG6JywSQVZp5Jyr6uhYr1wlajm/Ina6hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951518; c=relaxed/simple;
	bh=ZPTlGOLBk8Yt1wXbm2bGMhULFzcL/8nl+CWvZ9Iu+mU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bHPz1TMZ/y7LNxoIYpRz96x9vQowP4cUFGFhF2hVGTyXwAGhfOTkOrlb5QkfRED3GTr6ULI/HBtMcHymknF46KJjrORGgkSIeH/CjhFlxLadzPhxDJpvybJfWgCa2fKj3YI4ke3V9U6cM/H0xwFvwFhcxQWSnvbDm9/yueWyrJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=TUGEX9wR; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=LsCwT3nRgsSBtQjwPLp4Kqd9pyI8P+SOpTbkZCVfBgE=; b=TUGEX9wRBGqX3UDToPHfTXcUGz
	UXkYaSBx6BXb2sRjOC/6KP2s2WITFZJErPOntwnAuf5w49HQ5wuo6QWUGxx1PLbs4NvwMU1NpG4WR
	Zz67vf9DszK150zPb38bybTKz/n8reB11UQPXKu/2Nsr0W2lurBQ6fEUD6m+tvXzB2U24JN5mnwek
	RKAbXtH54X83oNPq84ub5H9MF0lpusazMUn1u/G7E/DEOaXOzBxv4zx+TdqlKGLxVoGKDW3s4rEiQ
	fjr3AEGizGHdIN01gJIpLKyfKB3ZGgaH4wUwqWp0rwuc9NVdNJYx1z+ZRkLXF7/QGlGLyIOpZtMY5
	46RUqTxw==;
Received: from [141.76.253.240] (helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vAlvm-0007Un-EV; Mon, 20 Oct 2025 11:11:54 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@cherry.de,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH] arm64: dts: rockchip: Fix indentation on rk3399 haikou demo dtso
Date: Mon, 20 Oct 2025 11:11:39 +0200
Message-ID: <20251020091139.3652738-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The regulator-cam-dovdd-1v8 uses spaces for indentation, where it should
use tabs. Fix this.

Fixes: 066a69db9db3 ("arm64: dts: rockchip: add overlay for RK3399 Puma Haikou Video Demo adapter")
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 .../dts/rockchip/rk3399-puma-haikou-video-demo.dtso    | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou-video-demo.dtso b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou-video-demo.dtso
index 5e8f729c2cf2..141a921a06e4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou-video-demo.dtso
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou-video-demo.dtso
@@ -45,11 +45,11 @@ cam_avdd_2v8: regulator-cam-avdd-2v8 {
 
 	cam_dovdd_1v8: regulator-cam-dovdd-1v8 {
 		compatible = "regulator-fixed";
-	        gpio = <&pca9670 3 GPIO_ACTIVE_LOW>;
-	        regulator-max-microvolt = <1800000>;
-	        regulator-min-microvolt = <1800000>;
-	        regulator-name = "cam-dovdd-1v8";
-	        vin-supply = <&vcc1v8_video>;
+		gpio = <&pca9670 3 GPIO_ACTIVE_LOW>;
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "cam-dovdd-1v8";
+		vin-supply = <&vcc1v8_video>;
 	};
 
 	cam_dvdd_1v2: regulator-cam-dvdd-1v2 {
-- 
2.47.2



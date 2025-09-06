Return-Path: <linux-kernel+bounces-804144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D547B46ABA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 12:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 685D8174260
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 10:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FBC2C2376;
	Sat,  6 Sep 2025 10:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Xd3P8MYD"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F131C8621;
	Sat,  6 Sep 2025 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757152903; cv=none; b=SyYkBBhwX6dfYyjDmajHfFpMXhw6S1btDoSLvtYf6RJTBvAMMjXFDDar7eQ5I641unYfXAuroe9nD2tMTFDpEij6drigzBPrj4PQtpXWPYKGmMUjqFNUGBuPkmXM0hQCPl55uXiI/LJNVTyqv9Vu2BoUr8bt/eq//A5xai+98O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757152903; c=relaxed/simple;
	bh=jAp3vOU49luBBxYNMrMBw22E8K4uqpCIKTzrvDx/ns4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FhCVR6UriQKXQtt9pEJt3nfpmJ7FI8Ah99V/QDHfd/pfaI1+ND3bOu+WlpsmOhRvpE5fBwjoXXUVoeSIrx7BDgA4bdSMqddilDxA3gLgb7IIMI4V0vlUpz/ZAZF4ZTWyN9ykhYM8A6LnMrIazdlcO7WC+oWUEF/PRcLwrfmPxL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Xd3P8MYD; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1757152893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZmgR8hdgtrNlI67KeHYucu9rjYmA/NUmX4FdH8skoWU=;
	b=Xd3P8MYD2wgVHWudwHHxa2XNU4NbBnpT7XvFAmkF5w3Mp2uHK7uxgbBQ4v7EDxsc/PWN4k
	DAW/EEW4nWw9tl+KpgY98fxqLmTDdMQWAovv0hAE2gQlJ2K8P9xTi7hER9ecAG/ndLT5Qv
	wJx2pYxW5vmWMsGF1CWwkH8miGBTk5+97ZFIwzi15IWdKiqWDEX2876MEwKmWsF/+w/xXQ
	DrxFTZAsqYJWRVLhSsq6/6SgwhC836thHoEz3EQIwOMd6hdSJSPPJzr4QpANOF6Fvivi8n
	P+kQZJjLZGrjcb/4Zp5Aa902R7pcFjzyIX3bwaM2Zb/SA4xO+ADMvl+DgzLOSA==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Make RK3588 GPU OPP table naming uniform
Date: Sat,  6 Sep 2025 12:01:22 +0200
Message-Id: <355c16ab070688fc6285e0d4419eb54a3f699eee.1757152740.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Unify the naming of the existing GPU OPP table nodes found in the RK3588
and RK3588J SoC dtsi files with the other SoC's GPU OPP nodes, following
the more "modern" node naming scheme.

Fixes: a7b2070505a2 ("arm64: dts: rockchip: Split GPU OPPs of RK3588 and RK3588j")
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi | 2 +-
 arch/arm64/boot/dts/rockchip/rk3588j.dtsi    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi
index 0f1a77697351..b5d630d2c879 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi
@@ -115,7 +115,7 @@ opp-2400000000 {
 		};
 	};
 
-	gpu_opp_table: opp-table {
+	gpu_opp_table: opp-table-gpu {
 		compatible = "operating-points-v2";
 
 		opp-300000000 {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588j.dtsi b/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
index 9884a5df47df..e1e0e3fc0ca7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
@@ -66,7 +66,7 @@ opp-1608000000 {
 		};
 	};
 
-	gpu_opp_table: opp-table {
+	gpu_opp_table: opp-table-gpu {
 		compatible = "operating-points-v2";
 
 		opp-300000000 {


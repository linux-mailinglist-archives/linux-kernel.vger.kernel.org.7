Return-Path: <linux-kernel+bounces-897505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C8AC5326C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7DF44EEDC4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09ED134029C;
	Wed, 12 Nov 2025 15:02:18 +0000 (UTC)
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D79233F397
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959737; cv=none; b=N05GhY9rpOK3K+9fv2pLqXvVUb4EBG7SwOEc5ZsGIq2o4geos8zc0YAJQ87Fc/POIB2TFwytMPJ3lGjB4IqA63f6ocGdaNvoaTPpcJl95RNFyIyHyWmvEA1WUETeOOexAuJl7+Vwykt5U97jqEzEP+8mTerf7Rlf7+6Rd0yMPDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959737; c=relaxed/simple;
	bh=8moaOI6VRVpqMnWsXLrvvSdWmbM9a0SBufNuHwsGqc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HgYXW+efzclx9OqHhEKrBKRwds7V/pyrMY/EqDax/Os8GWcxnshzyBvV8rujByXHDOQVrN+48b2sfLI7a/iRZX8b9avpNyI1it5Cqiv0kBNv0bdvI3keOqX8GK8ze7s8jccgBuyBRtdf6JumsNnDiSDPDIhsQS3JGPeaURSawXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d667f66VszfD8;
	Wed, 12 Nov 2025 16:02:06 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4d667f1jG9z2cg;
	Wed, 12 Nov 2025 16:02:06 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Wed, 12 Nov 2025 16:01:53 +0100
Subject: [PATCH] arm64: dts: rockchip: disable HS400 on RK3588 Tiger
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-tiger-hs200-v1-1-b50adac107c0@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MOwqAMBBF0a2EqQ1kIoPiVsTCzzNOo5KICMG9G
 yxPcW+mhKhI1JlMEbcmPfYCrgzN27gHWF2KyTsvzOztpQHRbsk7ZyFT24AhbS1UijNi1ee/9cP
 7fuJDspFdAAAA
X-Change-ID: 20251112-tiger-hs200-e5b87e1e5835
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha

From: Quentin Schulz <quentin.schulz@cherry.de>

We've had reports from the field that some RK3588 Tiger have random
issues with eMMC errors.

Applying commit a28352cf2d2f ("mmc: sdhci-of-dwcmshc: Change
DLL_STRBIN_TAPNUM_DEFAULT to 0x4") didn't help and seemed to have made
things worse for our board.

Our HW department checked the eMMC lines and reported that they are too
long and don't look great so signal integrity is probably not the best.

Note that not all Tigers with the same eMMC chip have errors, so the
suspicion is that we're really on the edge in terms of signal integrity
and only a handful devices are failing. Additionally, we have RK3588
Jaguars with the same eMMC chip but the layout is different and we also
haven't received reports about those so far.

Lowering the max-frequency to 150MHz from 200MHz instead of simply
disabling HS400 was briefly tested and seem to work as well. We've
disabled HS400 downstream and haven't received reports since so we'll go
with that instead of lowering the max-frequency.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
index b44e89e1bb159..365c1d958f2d5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
@@ -382,14 +382,12 @@ &sdhci {
 	cap-mmc-highspeed;
 	mmc-ddr-1_8v;
 	mmc-hs200-1_8v;
-	mmc-hs400-1_8v;
-	mmc-hs400-enhanced-strobe;
 	mmc-pwrseq = <&emmc_pwrseq>;
 	no-sdio;
 	no-sd;
 	non-removable;
 	pinctrl-names = "default";
-	pinctrl-0 = <&emmc_bus8 &emmc_cmd &emmc_clk &emmc_data_strobe>;
+	pinctrl-0 = <&emmc_bus8 &emmc_cmd &emmc_clk>;
 	vmmc-supply = <&vcc_3v3_s3>;
 	vqmmc-supply = <&vcc_1v8_s3>;
 	status = "okay";

---
base-commit: 6bff916a7e9b6b7f6bd06eb5722e6dfbb777f13e
change-id: 20251112-tiger-hs200-e5b87e1e5835

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>



Return-Path: <linux-kernel+bounces-881250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8477BC27D44
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 13:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C20E11A238AD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 12:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448932F617D;
	Sat,  1 Nov 2025 12:00:29 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759712DE6EF;
	Sat,  1 Nov 2025 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761998428; cv=none; b=k9e56L6cBJd/EQXzkZlH5QR1lCztp6cgKVYI5fdnRvZr9T7q2CvPobFpOBCHR9V2KwzZid7wLAFPxsrdwWI6LOz8+JPqv3uwiNiI2bYbLpJXKJwzJM6/8YZDCFs/kOEdHaXHOfQk2ghIvfBQ6HwV6He48hOS1TMD7LoH4PEN+5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761998428; c=relaxed/simple;
	bh=8kCZj0VNTJP7hYdS7ypYthvZrDgCYLljJVCpGX8R2GA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZW28tyeTMCz9Lm9V2s4vE2izsEw1emrqF1/RS7h/LJ/X3gT97oZYQ6mUIjxh5lUm6uiqsI3HHCeQgA+reJ+s/MwmQ0beSXXOcg6wSIZskRGT4RStEQqds7r+dEfkToMOnXAK1d/lPZ49M+AEfs/lGgylXe+inrDbhvnkGZb7+nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [58.61.140.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2801cc492;
	Sat, 1 Nov 2025 20:00:14 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Chukun Pan <amadeus@jmu.edu.cn>,
	Hsun Lai <i@chainsx.cn>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 1/6] arm64: dts: rockchip: add mmc aliases for 100ASK DshanPi A1
Date: Sat,  1 Nov 2025 20:00:05 +0800
Message-Id: <20251101120010.41729-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a3f4a23ca03a2kunmfa682f8b2d365c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZQ0gdVh1LHhlNHU0aSh5PQ1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VNSlVKT0tVSkhPWVdZFhoPEhUdFFlBWU9LSFVKS0hKTkxOVUpLS1VKQk
	tLWQY+

Add missing MMC aliases. Remove the max-frequency property
from the MMC node, which is already defined in rk3576.dtsi.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dts b/arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dts
index 59c172573cf8..9cbd3fae16ab 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dts
@@ -19,6 +19,8 @@ / {
 	aliases {
 		ethernet0 = &gmac0;
 		ethernet1 = &gmac1;
+		mmc0 = &sdhci;
+		mmc1 = &sdmmc;
 	};
 
 	chosen {
@@ -735,7 +737,6 @@ &sai6 {
 &sdhci {
 	bus-width = <8>;
 	full-pwr-cycle-in-suspend;
-	max-frequency = <200000000>;
 	mmc-hs400-1_8v;
 	mmc-hs400-enhanced-strobe;
 	no-sdio;
@@ -749,7 +750,6 @@ &sdmmc {
 	cap-mmc-highspeed;
 	cap-sd-highspeed;
 	disable-wp;
-	max-frequency = <200000000>;
 	sd-uhs-sdr104;
 	vmmc-supply = <&vcc_3v3_s3>;
 	vqmmc-supply = <&vccio_sd_s0>;
-- 
2.25.1



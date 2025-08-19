Return-Path: <linux-kernel+bounces-776072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76697B2C835
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0BAC1639CE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A4927FB2D;
	Tue, 19 Aug 2025 15:10:32 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89747280A2C;
	Tue, 19 Aug 2025 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755616231; cv=none; b=pMKm2eDuxrZDTFPJ4OaMo62qMj75OartvZFZv1MH4OesqkwxajZaffSxSYJ0kOaeJ6wVVxIWA6Kvdo3Rzl75kJpA7H/OFOml067kGcawqUi79WZytvaNpIfQhYh30/PPHl3Cm6gzUR3mkN4O819KxjPwNjCBwIkuGohPTr66z6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755616231; c=relaxed/simple;
	bh=mfiHRahtxas6lkgyzgclp7/t1x4CTkqWxlw9jEw3ESA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j1QM1StVm4kpk0QpD56HVZPveJ3RNU8Bh1rTfPZLQGuXEpREizfRexjVk7c44Flg3v9bwgAKUF9y99fpJGKl861A4+2XtuamNGCp4Omv0P08LDhK/gMiFzSFSrpqxnILqZ2BWdr8WFOMyI5OkGrEQsZviuWs6ol/W93jwuYmZWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.213.154])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1fe57aa44;
	Tue, 19 Aug 2025 23:10:23 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: tobetter@gmail.com
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Change ethernet TXD timing delay value
Date: Tue, 19 Aug 2025 23:10:19 +0800
Message-Id: <20250819151019.877709-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250819075522.2238643-1-tobetter@gmail.com>
References: <20250819075522.2238643-1-tobetter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98c2e1a08103a2kunm6470503c4070c2
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSksaVh1MShoeSU8eTkgYTlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSFVKTk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE5VSktLVU
	pCS0tZBg++

Hi,

> Very poor network performance is observed on the ODROID-M1 Board
> (REV 1.0 20220613) when running iperf3 (under 200Mbits/sec), and
> this problem can be resolved after changing the value of TXD
> timing to 0x35 from 0x4f.

Can you try changing phy-mode to "rgmii-id" ?

```
--- a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
@@ -200,7 +200,7 @@ &gmac0 {
 	assigned-clock-rates = <0>, <125000000>;
 	clock_in_out = "output";
 	phy-handle = <&rgmii_phy0>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-supply = <&vcc3v3_sys>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&gmac0_miim
@@ -209,9 +209,6 @@ &gmac0_rx_bus2
 		     &gmac0_rgmii_clk
 		     &gmac0_rgmii_bus>;
 	status = "okay";
-
-	tx_delay = <0x4f>;
-	rx_delay = <0x2d>;
 };
 
 &gpu {
```

--
2.25.1




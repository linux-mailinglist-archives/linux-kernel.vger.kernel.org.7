Return-Path: <linux-kernel+bounces-786780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C28B369B2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68DEA584896
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC99A34166C;
	Tue, 26 Aug 2025 14:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="AwvndnXr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="eZ4SIp9S"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99DC2AE68
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217657; cv=none; b=MV0MgiGVc2rsogZp6+EAVXy+7qP7bCqz9eL2W4zsaviV+Zt33vGcFwemsRBqfuCRr7tG2txxLXKkIxULp5DvSHPJB0In04WyXkL1tuW2WeydvbmLtyZTvmMY5P5UzlyiEfEbOeTvp5/t0NTX7LqBiGmL+AnNz7NgRjU64dB22i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217657; c=relaxed/simple;
	bh=p8+Q4xnVtqNU++CI5Z/+XoOJlhxyohiMCfmXs3bX974=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=czjooldxJB99dORtATNXhhSDXxH6hrRNOzxzPk/V/3jXzQpR7K19xxXWT+SR8x3qWqB+IMvBlMs+NgYJg0Rf2HCgPhwcyy1wCrG3VTAm9X2L94RAZ/yFDkTn/m3v8y3Za/rR+eKI4ocpAm4kT3FCmHVUfTgY5uj3Ki46CEQMLYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=AwvndnXr; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=eZ4SIp9S reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1756217655; x=1787753655;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vntM1/TxhdiVPOOzQR2app5xuX2eIoHoYXzwuHqvn+8=;
  b=AwvndnXrpg5gtddOsq526cF/Z4xjnR3SoG6TdAZlFcAhTeEfQihxURzA
   2KYott1W8pOa3ufnMBe23NB2HcnPBXvs6rzakTF5CZVPwMptlPU8orf7h
   uwaU+o/1IKl1BtOY6CQcKtZEMMzSN2sWvlIS0VDGmIZL2IAFh+6NXe0Gg
   NbZargI3tqWNRXM+KGx9t5Akx+Vi4BamKKgRd+RiQBVVyq6T3ivhv+HlV
   FhGQmDm3UpKsKuXMACVuFedbbLv2JW0RoEuXcYkZHu9F/wT6tY1c5+3Me
   STLSxL4O0CZK9BPJxkEh0aF/kxJx+cgyN2Y2kaS7OLUVt8uQRyVDKRO17
   w==;
X-CSE-ConnectionGUID: 2XFV1cqMTSuPx9nJFDp/ww==
X-CSE-MsgGUID: u5oOWMpiShyES94+GNmoeg==
X-IronPort-AV: E=Sophos;i="6.18,214,1751234400"; 
   d="scan'208";a="45917408"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 26 Aug 2025 16:14:12 +0200
X-CheckPoint: {68ADC134-6-410E8DD8-CEA8F0F8}
X-MAIL-CPID: 6A3AB291245F51CE0A0472E892044B20_3
X-Control-Analysis: str=0001.0A002119.68ADC16E.0002,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 21662167192;
	Tue, 26 Aug 2025 16:14:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1756217648; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=vntM1/TxhdiVPOOzQR2app5xuX2eIoHoYXzwuHqvn+8=;
	b=eZ4SIp9S8PfNOWl+75CLW7e9jEbyp8gTA1yXWjCF2+dAjO3B/mkcD5ay4hFaMbQzRigbak
	8AW0QF5xaRiY+tQHHpyZHtdlCdrZVqkoXFS4JjfeQiho2oXfR1zVNtDT2jpysBDjCNnOwX
	4DvW1whyP0+8Z3Juz29812YXTQ2tLDO3P8gFNzcZhEVGcQPTGg7l3GCVAnI0TBrCHLiOGU
	uGaw3Q/ScwimACcqs+uCvqwdSv8xd7CgJlchw0wi0xl4YbtLdkXZrFA4LH1eNIsbVxIyVJ
	juhM+tAagg0UF4mdlQ/iA0aRpH567uJJmQnaifaNyZpMM78Hf7oLz6FMI2ftuQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/1] arm64: defconfig: Enable Marvell WiFi-Ex USB driver
Date: Tue, 26 Aug 2025 16:13:56 +0200
Message-ID: <20250826141356.2572830-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

MBa91xxCA (imx93-tqma9352-mba91xxca.dts) features a soldered,
non-pluggable USB attached WiFi module. lsusb says:
 ID 1286:204e Marvell Semiconductor, Inc. Bluetooth and Wireless LAN Composite Device
Enable the corresponding driver.

To: Shawn Guo <shawnguo@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: imx@lists.linux.dev
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in v3:
* Explicitly mention the onn-pluggable USB WiFi module
* Added Krzysztof's R-b

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6be80d07c2f6d..9d86c706bc211 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -441,6 +441,7 @@ CONFIG_IWLMVM=m
 CONFIG_MWIFIEX=m
 CONFIG_MWIFIEX_SDIO=m
 CONFIG_MWIFIEX_PCIE=m
+CONFIG_MWIFIEX_USB=m
 CONFIG_MT7921E=m
 CONFIG_RSI_91X=m
 CONFIG_WL18XX=m
-- 
2.43.0



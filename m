Return-Path: <linux-kernel+bounces-791864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9A8B3BD06
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C103E1C84B17
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7706D31DDB9;
	Fri, 29 Aug 2025 14:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="d4b+QEKS"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35072D321D
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756476015; cv=none; b=QfyyEcHfUruQxju1K/s03nQ4qA8X6LoFOrXrjRMnbooChdoy74x0zd3jdHltwzOZUnpWcZAhX0I5QOmuhIUkdHuGhb7KtqUGz9eg9sdNNAkkPsT7w5qcQnnwqeSmEIfO3evxCJ2HiEJNB3ReVm8GTFcku5QlD6Nnw26Im/jI0Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756476015; c=relaxed/simple;
	bh=i3EE2OR8VgBxeGjeKxy1ZjKqkUIs6GcKr78n3M/T7pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=naz3VNdy/xEMfeHo1sQtiAEHRB/exFVo8QzrsLISUOKtpU5ar2l7bUiPXeNwEbU8+UkjN2rzo2tZi0qZIphUN1dHdwn3exvhACXbQ3FXSnO/QRT/dDFexrHr3ImXkhd5QVYM69pdG+lbFQPMdaRtxILmCOMCsFqR2mt4TCcWo9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=d4b+QEKS; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250829140012epoutp02d670684bbd004002cebd8e3f8572eaec~gQaB00VJL2867728677epoutp02S
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 14:00:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250829140012epoutp02d670684bbd004002cebd8e3f8572eaec~gQaB00VJL2867728677epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756476012;
	bh=d7ikzstNHkthbtDA8b8VQUUX9xhB4JWtLC11kBw1nzg=;
	h=From:To:Cc:Subject:Date:References:From;
	b=d4b+QEKSwvDRiv4Z5hwxWvBikCAS9znK/JvuHEB7t1BBzthYGXc5/MrPAU4qQuLum
	 qMmrD/IDsL1sTg1V0nvukKjpJ7BULXFbjBXou09PEQPSx+0n5jSIfE40ZWtOdiriTs
	 azsrWTs+9Nwk5W3j8FFFlgO9AxjWTEmBSlMaVyCk=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250829140011epcas5p471bd84c4daa40aa458116a7feec21e70~gQaBPpf1b0901909019epcas5p4B;
	Fri, 29 Aug 2025 14:00:11 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.93]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cD0Jp3xbhz3hhTH; Fri, 29 Aug
	2025 14:00:10 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250829140010epcas5p1bc06faf0001ab2695f0199db65fe678d~gQZ-_j_ZR2472824728epcas5p1W;
	Fri, 29 Aug 2025 14:00:10 +0000 (GMT)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250829140008epsmtip1b0874f76e197270c46afb5cc6889618f~gQZ_nDMaH2172121721epsmtip1c;
	Fri, 29 Aug 2025 14:00:08 +0000 (GMT)
From: Varada Pavani <v.pavani@samsung.com>
To: krzk@kernel.org, alim.akhtar@samsung.com, wim@linux-watchdog.org,
	linux@roeck-us.net
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	gost.dev@samsung.com, aswani.reddy@samsung.com, Varada Pavani
	<v.pavani@samsung.com>
Subject: [PATCH] watchdog: s3c2410: Add FSD support
Date: Fri, 29 Aug 2025 19:30:02 +0530
Message-ID: <20250829140003.109588-1-v.pavani@samsung.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250829140010epcas5p1bc06faf0001ab2695f0199db65fe678d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250829140010epcas5p1bc06faf0001ab2695f0199db65fe678d
References: <CGME20250829140010epcas5p1bc06faf0001ab2695f0199db65fe678d@epcas5p1.samsung.com>

FSD SoC has 3 CPU clusters, each has its own WDT instance.
PMU register bits(.rst_stat_bit and .mask_bit) for each cluster is
different. So driver data is now modified in probe, adding needed info
depending on cluster index passed from device tree.

Signed-off-by: Varada Pavani <v.pavani@samsung.com>
---
 drivers/watchdog/s3c2410_wdt.c | 39 +++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 30450e99e5e9..a112d9747ab6 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -57,6 +57,7 @@
 #define EXYNOS5_RST_STAT_REG_OFFSET		0x0404
 #define EXYNOS5_WDT_DISABLE_REG_OFFSET		0x0408
 #define EXYNOS5_WDT_MASK_RESET_REG_OFFSET	0x040c
+#define FSD_AUTOMATIC_DISABLE_WDT		0x040c
 #define EXYNOS850_CLUSTER0_NONCPU_OUT		0x1220
 #define EXYNOS850_CLUSTER0_NONCPU_INT_EN	0x1244
 #define EXYNOS850_CLUSTER1_NONCPU_OUT		0x1620
@@ -333,6 +334,33 @@ static const struct s3c2410_wdt_variant drv_data_exynosautov920_cl1 = {
 		  QUIRK_HAS_DBGACK_BIT,
 };
 
+static const struct s3c2410_wdt_variant drv_data_fsd_cl0 = {
+	.disable_reg = FSD_AUTOMATIC_DISABLE_WDT,
+	.mask_bit = 23,
+	.rst_stat_reg = EXYNOS5_RST_STAT_REG_OFFSET,
+	.rst_stat_bit = 23,
+	.quirks = QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_PMU_RST_STAT |
+		  QUIRK_HAS_PMU_AUTO_DISABLE,
+};
+
+static const struct s3c2410_wdt_variant drv_data_fsd_cl1 = {
+	.disable_reg = FSD_AUTOMATIC_DISABLE_WDT,
+	.mask_bit = 24,
+	.rst_stat_reg = EXYNOS5_RST_STAT_REG_OFFSET,
+	.rst_stat_bit = 24,
+	.quirks = QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_PMU_RST_STAT |
+		  QUIRK_HAS_PMU_AUTO_DISABLE,
+};
+
+static const struct s3c2410_wdt_variant drv_data_fsd_cl2 = {
+	.disable_reg = FSD_AUTOMATIC_DISABLE_WDT,
+	.mask_bit = 25,
+	.rst_stat_reg = EXYNOS5_RST_STAT_REG_OFFSET,
+	.rst_stat_bit = 25,
+	.quirks = QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_PMU_RST_STAT |
+		  QUIRK_HAS_PMU_AUTO_DISABLE,
+};
+
 static const struct of_device_id s3c2410_wdt_match[] = {
 	{ .compatible = "google,gs101-wdt",
 	  .data = &drv_data_gs101_cl0 },
@@ -352,6 +380,8 @@ static const struct of_device_id s3c2410_wdt_match[] = {
 	  .data = &drv_data_exynosautov9_cl0 },
 	{ .compatible = "samsung,exynosautov920-wdt",
 	  .data = &drv_data_exynosautov920_cl0 },
+	{ .compatible = "tesla,fsd-wdt",
+	  .data = &drv_data_fsd_cl0 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, s3c2410_wdt_match);
@@ -676,7 +706,8 @@ s3c2410_get_wdt_drv_data(struct platform_device *pdev, struct s3c2410_wdt *wdt)
 	if (variant == &drv_data_exynos850_cl0 ||
 	    variant == &drv_data_exynosautov9_cl0 ||
 	    variant == &drv_data_gs101_cl0 ||
-	    variant == &drv_data_exynosautov920_cl0) {
+	    variant == &drv_data_exynosautov920_cl0 ||
+	    variant == &drv_data_fsd_cl0) {
 		u32 index;
 		int err;
 
@@ -697,6 +728,12 @@ s3c2410_get_wdt_drv_data(struct platform_device *pdev, struct s3c2410_wdt *wdt)
 				variant = &drv_data_gs101_cl1;
 			else if (variant == &drv_data_exynosautov920_cl0)
 				variant = &drv_data_exynosautov920_cl1;
+			else if (variant == &drv_data_fsd_cl0)
+				variant = &drv_data_fsd_cl1;
+			break;
+		case 2:
+			if (variant == &drv_data_fsd_cl0)
+				variant = &drv_data_fsd_cl2;
 			break;
 		default:
 			return dev_err_probe(dev, -EINVAL, "wrong cluster index: %u\n", index);
-- 
2.49.0



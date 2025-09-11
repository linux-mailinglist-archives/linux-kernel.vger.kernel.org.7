Return-Path: <linux-kernel+bounces-811478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E90B529A4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB2F581B96
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119A026A1AF;
	Thu, 11 Sep 2025 07:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HE/zeTVE"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C96266B6B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757574725; cv=none; b=rgaNsbvsjqmM5k8TkrAFCTDaxqWpLVpp50Qyfn+FtbP3oXXkY8KRFl445TcfdgornS1J4x3kDz+aTP/6x3X010ZzZrfL3VVnQW6GjQ3lohrLdaFtrV2buEg6GiBQifQww94hdO/vrDGbq6kUUERNl4DfLS1IfU01QlKHb3LjqUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757574725; c=relaxed/simple;
	bh=xINmkOLabQw1Pt8CERYQylAn9hhuK4PE+W1b5aVKkHU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vCIaDRZzzcoj40dlrz7LloxtB2dTgMNSyeAuHxLukKO1WE7xPSDk0cSSJVGNOqIsKdI9My7+3Hu5QzzSFGGLKIeKbdr9oEAeYZ9b6MPU7A9GQ6mRJa/MsdIEP2OPGbZnPLN5HwAEgy1qp9uFa1VsLXthTK70vlrdaJXvXUi+ikQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HE/zeTVE; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58B7Bdmi693253;
	Thu, 11 Sep 2025 02:11:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757574699;
	bh=sw0W0MvFvnxDpl+fs2Cqclu/ceL49VrWO42sAjkFkIg=;
	h=From:To:CC:Subject:Date;
	b=HE/zeTVEIN4oxDiZ+VhpBvwc9Er5/qIdBOrycp12DXeO2SFZSnczOQgmYXPUZ7p+X
	 v8tv2umeWTJDZhrhchxoHAOkBu85IoyPFXHmFvxUcbTGmqsHAlzYJvQFEkgB+3CCZa
	 W84IckwUaG5mMtNRcUw5SvicHEuHh/HfIkkczj8Q=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58B7BddZ1759242
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 11 Sep 2025 02:11:39 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 11
 Sep 2025 02:11:38 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Sep 2025 02:11:38 -0500
Received: from LT5CG31242FY.dhcp.ti.com (lt5cg31242fy.dhcp.ti.com [10.85.14.218])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58B7BZhv1453534;
	Thu, 11 Sep 2025 02:11:35 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <tiwai@suse.de>
CC: <broonie@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <13564923607@139.com>, <13916275206@139.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <baojun.xu@ti.com>, <Baojun.Xu@fpt.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v1] ALSA: hda/tas2781: Fix a potential race condition that causes a NULL pointer in case no efi.get_variable exsits
Date: Thu, 11 Sep 2025 15:11:31 +0800
Message-ID: <20250911071131.1886-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

A a potential race condition reported by one of my customers that leads to
a NULL pointer dereference, where the call to efi.get_variable should be
guarded with efi_rt_services_supported() to ensure that function exists.

Fixes: 4fe238513407 ("ALSA: hda/tas2781: Move and unified the calibrated-data getting function for SPI and I2C into the tas2781_hda lib")
Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
---
 sound/hda/codecs/side-codecs/tas2781_hda.c     | 5 +++++
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/sound/hda/codecs/side-codecs/tas2781_hda.c b/sound/hda/codecs/side-codecs/tas2781_hda.c
index 536940c78f00..96e6d82dc69e 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda.c
@@ -193,6 +193,11 @@ int tas2781_save_calibration(struct tas2781_hda *hda)
 	efi_status_t status;
 	int i;
 
+	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) {
+		dev_err(p->dev, "%s: NO EFI FOUND!\n", __func__);
+		return -EINVAL;
+	}
+
 	if (hda->catlog_id < LENOVO)
 		efi_guid = tasdev_fct_efi_guid[hda->catlog_id];
 
diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
index 008dbe1490a7..4dea442d8c30 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
@@ -317,6 +317,11 @@ static int tas2563_save_calibration(struct tas2781_hda *h)
 	unsigned int attr;
 	int ret, i, j, k;
 
+	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) {
+		dev_err(p->dev, "%s: NO EFI FOUND!\n", __func__);
+		return -EINVAL;
+	}
+
 	cd->cali_dat_sz_per_dev = TAS2563_CAL_DATA_SIZE * TASDEV_CALIB_N;
 
 	/* extra byte for each device is the device number */
-- 
2.43.0



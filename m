Return-Path: <linux-kernel+bounces-804141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D80AB46AAC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 11:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96AB33A5E34
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 09:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9CC27605A;
	Sat,  6 Sep 2025 09:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s3j3gS3j"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E43279354
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 09:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757150399; cv=none; b=Pzray50t9i3un/EEvgR/GfLqAvDPgRaINnYVC2LVxm7Xpy4o3ZIuZ908ASnpntge1BJYsQ9pohgMFe/ywmysdFg8UPwQRe3HViXEjt8n4tSiidhB9/8p4cO/QcQCErp6IgorFy5aoeio0X508AyHPJN6QGLzDEJbowTk+4AOkxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757150399; c=relaxed/simple;
	bh=9bNmYoNLsFa8unIWulNLAELWJUoXGwU8yuTvkUzNN1s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k4d8jdH12V+F8o70j9sWww79dTMlqNH2EAoIG3LbbfXhSI0mfFf5mSo8vcGTArRHRVz5weTzZORXdXCi8mAcaDzmT2Xigwmjfkq3WQXgcDNvvkQrjfXRFY3edpB5qiUpAnyawXFynmvaupPTWlT2M4xvI4jXWRcztJlJvGdujSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=s3j3gS3j; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5869JW8t3925761;
	Sat, 6 Sep 2025 04:19:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757150372;
	bh=YLNYxp/FSpxPNcyK6bIyluYzJiMr2F1DgAnGcWIhwgM=;
	h=From:To:CC:Subject:Date;
	b=s3j3gS3jzpe1YJY636MxtJ+jpXCJm8H8wMdfGSJxNyzztPY5G2W/NwIo9AlEFr64L
	 UH3uESkHtLPlKpFGkQkiKS1hLQbGd/+0wVNfV2NL2Mye1AxLL61RcYiMVk2F/mQD8o
	 Y0TTLhTUrjmOtQhlwinjbBvXnvbl6UAheS86tTEY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5869JVhv1518945
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sat, 6 Sep 2025 04:19:31 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sat, 6
 Sep 2025 04:19:31 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Sat, 6 Sep 2025 04:19:31 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.161.79])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5869JRgP2028007;
	Sat, 6 Sep 2025 04:19:28 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <tiwai@suse.de>
CC: <broonie@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <13564923607@139.com>, <13916275206@139.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <baojun.xu@ti.com>, <Baojun.Xu@fpt.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v3] ALSA: hda/tas2781: Fix the order of TAS2781 calibrated-data
Date: Sat, 6 Sep 2025 17:19:23 +0800
Message-ID: <20250906091923.1760-1-shenghao-ding@ti.com>
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

A bug reported by one of my customers that the order of TAS2781
calibrated-data is incorrect, the correct way is to move R0_Low
and insert it between R0 and InvR0.

Fixes: 4fe238513407 ("ALSA: hda/tas2781: Move and unified the calibrated-data getting function for SPI and I2C into the tas2781_hda lib")
Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
v3:
 - Take Tiwai's advice on cali_cnv() to make it more simpler.
v2:
 - Submit to sound branch maintianed by Tiwai instead of linux-next branch
 - Drop other fix
---
 sound/hda/codecs/side-codecs/tas2781_hda.c | 25 +++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/sound/hda/codecs/side-codecs/tas2781_hda.c b/sound/hda/codecs/side-codecs/tas2781_hda.c
index f46d2e06c64f..f4a44c6b0234 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda.c
@@ -33,6 +33,23 @@ const efi_guid_t tasdev_fct_efi_guid[] = {
 };
 EXPORT_SYMBOL_NS_GPL(tasdev_fct_efi_guid, "SND_HDA_SCODEC_TAS2781");
 
+/*
+ * The order of calibrated-data writing function is a bit different from the
+ * order in UEFI. Here is the conversion to match the order of calibrated-data
+ * writing function.
+ */
+static void cali_cnv(unsigned char *data, unsigned int base, int offset)
+{
+	struct cali_reg reg_data;
+
+	memcpy(&reg_data, data, sizeof(reg_data));
+	/* the data order has to be swapped between r0_low_reg and inv0_reg */
+	swap(reg_data.r0_low_reg, reg_data.invr0_reg);
+
+	cpu_to_be32_array((__force __be32 *)(data + offset + 1),
+		(u32 *)&reg_data, TASDEV_CALIB_N);
+}
+
 static void tas2781_apply_calib(struct tasdevice_priv *p)
 {
 	struct calidata *cali_data = &p->cali_data;
@@ -103,8 +120,7 @@ static void tas2781_apply_calib(struct tasdevice_priv *p)
 
 				data[l] = k;
 				oft++;
-				for (i = 0; i < TASDEV_CALIB_N * 4; i++)
-					data[l + i + 1] = data[4 * oft + i];
+				cali_cnv(data, 4 * oft, l);
 				k++;
 			}
 		}
@@ -130,9 +146,8 @@ static void tas2781_apply_calib(struct tasdevice_priv *p)
 
 		for (j = p->ndev - 1; j >= 0; j--) {
 			l = j * (cali_data->cali_dat_sz_per_dev + 1);
-			for (i = TASDEV_CALIB_N * 4; i > 0 ; i--)
-				data[l + i] = data[p->index * 5 + i];
-			data[l+i] = j;
+			cali_cnv(data, cali_data->cali_dat_sz_per_dev * j, l);
+			data[l] = j;
 		}
 	}
 
-- 
2.43.0



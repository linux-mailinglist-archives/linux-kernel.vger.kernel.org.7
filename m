Return-Path: <linux-kernel+bounces-587076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE207A7A78F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 18:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A2F43AA49F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 16:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6161250C08;
	Thu,  3 Apr 2025 16:07:58 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E107E24EF66
	for <linux-kernel@vger.kernel.org>; Thu,  3 Apr 2025 16:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743696478; cv=none; b=bq1bsswnaeSOj8+AQRhuKmuUjzQMRvzxul/419d9WrNAk/cKwKXkGUmQQCjdWJFD9EsoEtmC/0nqkClP2RqU7pGJmXJNf2swYb3FUNf92OKkfI1ji+EnxSnOP+W+qqt97XcHS4WCs3gAnrpCNLrkU6DE9tlIbOAehIh5gea6Goo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743696478; c=relaxed/simple;
	bh=tf694kECYu/EWPbbQ45vsQ6LcGLLICsZok3e/DD7KDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JQYvQhiMuMTKolCOFt4EHzvG2OEtZ+WgTReXyxIWWgUfyIk75i2fypICUz0aw/qbFy2hWwDh7+Ub7tXzhXVgmPwdeadg5azr0Ym6R3sMavzxVHJU+ehhifAWDBFXiJcDtEPTvcXdHQhcg/xIXIO99fR4ras18cP0i2t0KKj+7Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [221.222.48.127])
	by APP-05 (Coremail) with SMTP id zQCowAB3rgZRsu5nyDqHBQ--.49340S2;
	Fri, 04 Apr 2025 00:07:46 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: kenneth.feng@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] drm/amd/pm/powerplay/smumgr/fiji_smumgr: Fix wrong return value of fiji_populate_smc_boot_level()
Date: Fri,  4 Apr 2025 00:07:23 +0800
Message-ID: <20250403160723.2400-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3rgZRsu5nyDqHBQ--.49340S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF43Wr4xZw43CF4kCF47CFg_yoW5GF15pr
	WDXrZIv39YyanrJrnrtFs2qr4S9FyxJFW8G3y7C34rZw1UtrW8Zr40ya4ayF48GFyIkws3
	X342gFWUGr4Ika7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r1j6r
	4UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVWUMxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	WUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUjtx6UUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAYBA2fuaKzRGAAAsM

The return value of fiji_populate_smc_boot_level() is always 0, which
represent the failure of the function. The result of phm_find_boot_level()
should be recored and return. An error handling is also needed to
phm_find_boot_level() to reset the boot level when the function fails.
A proper implementation can be found in tonga_populate_smc_boot_level().

Fixes: dcaf3483ae46 ("drm/amd/pm/powerplay/smumgr/fiji_smumgr: Remove unused variable 'result'")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 .../drm/amd/pm/powerplay/smumgr/fiji_smumgr.c | 23 +++++++++++++------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
index 5e43ad2b2956..7d0cb3741b94 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
@@ -1600,19 +1600,28 @@ static int fiji_populate_smc_uvd_level(struct pp_hwmgr *hwmgr,
 static int fiji_populate_smc_boot_level(struct pp_hwmgr *hwmgr,
 		struct SMU73_Discrete_DpmTable *table)
 {
+	int result = 0;
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
 
 	table->GraphicsBootLevel = 0;
 	table->MemoryBootLevel = 0;
 
 	/* find boot level from dpm table */
-	phm_find_boot_level(&(data->dpm_table.sclk_table),
-			    data->vbios_boot_state.sclk_bootup_value,
-			    (uint32_t *)&(table->GraphicsBootLevel));
+	result = phm_find_boot_level(&(data->dpm_table.sclk_table),
+				     data->vbios_boot_state.sclk_bootup_value,
+				     (uint32_t *)&(table->GraphicsBootLevel));
+	if (result) {
+		table->GraphicsBootLevel = 0;
+		return 0;
+	}
 
-	phm_find_boot_level(&(data->dpm_table.mclk_table),
-			    data->vbios_boot_state.mclk_bootup_value,
-			    (uint32_t *)&(table->MemoryBootLevel));
+	result = phm_find_boot_level(&(data->dpm_table.mclk_table),
+				     data->vbios_boot_state.mclk_bootup_value,
+				     (uint32_t *)&(table->MemoryBootLevel));
+	if (result) {
+		table->MemoryBootLevel = 0;
+		return 0;
+	}
 
 	table->BootVddc  = data->vbios_boot_state.vddc_bootup_value *
 			VOLTAGE_SCALE;
@@ -1625,7 +1634,7 @@ static int fiji_populate_smc_boot_level(struct pp_hwmgr *hwmgr,
 	CONVERT_FROM_HOST_TO_SMC_US(table->BootVddci);
 	CONVERT_FROM_HOST_TO_SMC_US(table->BootMVdd);
 
-	return 0;
+	return result;
 }
 
 static int fiji_populate_smc_initailial_state(struct pp_hwmgr *hwmgr)
-- 
2.42.0.windows.2



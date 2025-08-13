Return-Path: <linux-kernel+bounces-767541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F952B255C7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 177113B9579
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC533009F6;
	Wed, 13 Aug 2025 21:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Iiehth8m"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BD93009D9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121342; cv=none; b=HrR+nYIqwkQk9Qb+Zzhpb7oaKWhxP4SFTzh2qMFRJ3sTAB69maLvpQkld9tWAObLoQI2Ofx5XyMJoxySigEYPYsskYXuuYeheIhZdMwrZUAiUPyHCh7MXlIa3d3uP8Ujh/Zn7Rg8IC5u+ccXKuvhH77n9Cts8MpsfBtGsfi6J2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121342; c=relaxed/simple;
	bh=IE/5ghTTVAVOQUmeBefk5+bh3lKIZz3fQ/j0z0yCEPg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i3ahXs3Dg+njSfkqFgO7wHUdhxPmRJd0ucziAG07fM1nP+JQVgOYQnsAJxAgN+UTgPreubtHsTI48FcK1gTwOoBHSn+N2O9oJGUx8Lj4fACGvrNLEl4zOALvex1KiFFgtlHquGNAn5/+xE4o/tFlnt6Fyn6XfvSemZGE0OWcasY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Iiehth8m; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DLfffA1788741;
	Wed, 13 Aug 2025 16:41:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755121301;
	bh=kTbVVjSoROXPn4Xu4layLkxNIqGNzrm2kx+jdejNJ9M=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Iiehth8m/X0TJpR/V3cdN0vn47nZSceK3Zt2k0G4Vhn197OGr7C2z/57+h70aDR3j
	 gjhm3U9XtutYStd4Bk2asboJJIrjXKB/mWQvtsmP758rpPl0O8O9GwkbIxu2pGiy6/
	 yHIOpcKyNKcyXcwP3UAMToeKET/YGjXIfh/UX/pY=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DLffcl1253252
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 16:41:41 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 16:41:40 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 16:41:40 -0500
Received: from fllvem-mr07.itg.ti.com ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DLfdNH2611079;
	Wed, 13 Aug 2025 16:41:40 -0500
From: Andrew Davis <afd@ti.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Vladimir Zapolskiy <vz@mleia.com>,
        Jacky Huang <ychuang3@nuvoton.com>,
        Shan-Chun Hung <schung@nuvoton.com>, Qin
 Jian <qinjian@cqplus1.com>
CC: <openbmc@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 2/6] reset: intel: Use devm_register_restart_handler()
Date: Wed, 13 Aug 2025 16:41:34 -0500
Message-ID: <20250813214138.477659-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250813214138.477659-1-afd@ti.com>
References: <20250813214138.477659-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Function register_restart_handler() is deprecated. Using this new API
removes our need to keep and manage a struct notifier_block and to
later unregister the handler.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/reset/reset-intel-gw.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/reset/reset-intel-gw.c b/drivers/reset/reset-intel-gw.c
index a5a01388ae7fa..97671b99f565a 100644
--- a/drivers/reset/reset-intel-gw.c
+++ b/drivers/reset/reset-intel-gw.c
@@ -28,7 +28,6 @@ struct intel_reset_soc {
 
 struct intel_reset_data {
 	struct reset_controller_dev rcdev;
-	struct notifier_block restart_nb;
 	const struct intel_reset_soc *soc_data;
 	struct regmap *regmap;
 	struct device *dev;
@@ -154,12 +153,10 @@ static int intel_reset_xlate(struct reset_controller_dev *rcdev,
 	return id;
 }
 
-static int intel_reset_restart_handler(struct notifier_block *nb,
-				       unsigned long action, void *data)
+static int intel_reset_restart_handler(struct sys_off_data *data)
 {
-	struct intel_reset_data *reset_data;
+	struct intel_reset_data *reset_data = data->cb_data;
 
-	reset_data = container_of(nb, struct intel_reset_data, restart_nb);
 	intel_assert_device(&reset_data->rcdev, reset_data->reboot_id);
 
 	return NOTIFY_DONE;
@@ -216,9 +213,7 @@ static int intel_reset_probe(struct platform_device *pdev)
 	if (data->soc_data->legacy)
 		data->reboot_id |= FIELD_PREP(STAT_BIT_OFFSET_MASK, rb_id[2]);
 
-	data->restart_nb.notifier_call =	intel_reset_restart_handler;
-	data->restart_nb.priority =		128;
-	register_restart_handler(&data->restart_nb);
+	devm_register_restart_handler(&pdev->dev, intel_reset_restart_handler, data);
 
 	return 0;
 }
-- 
2.39.2



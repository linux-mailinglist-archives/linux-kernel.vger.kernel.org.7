Return-Path: <linux-kernel+bounces-767544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE11BB255CD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 422751C239F1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138372EA152;
	Wed, 13 Aug 2025 21:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ovbl1XAW"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5141E89C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121343; cv=none; b=B5wqYy5GgHJyu646sM9fOmyQ8tuca1Weltsj3Bn2C8wYgJjE2WVLVL0os15F+YXsNLMeq9EWkcAoG6fudZcFJrvkqZFUcCitAA8HKRbwXISA7E2/ERZkbk8e3oINlanSZ87s1sXsCdlxwwnEClE68CI4B95L8V1GPvjSMoNIgVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121343; c=relaxed/simple;
	bh=GMQVUAAD521AjraivB7aePbBZDbImPR17OxqBaBkAkg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bSfUfZb/+Z3ME8GlzJ5qKl3LkSb4PjWW2sI6pw2Pct76a9e5VBltgvOpkU4nKBOrEnO9m+YwHHPnw2TQhSf3JvLzmw5rjYkJFakKFTzEizITfK8+M1QHvwoteANLMBlyZK0BtdARwxlWRJXG6AcNtJdj7t5V07peocWjNjyILRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ovbl1XAW; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DLfgo61737102;
	Wed, 13 Aug 2025 16:41:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755121302;
	bh=MOqrt+X1MgrX06YG0uRc9BpYNXl9q+Neu4iKdp93TPs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ovbl1XAW3oxAOCnxOLJJawfik+Re7PN5hgQVSC5cPx8urcpiiNm9OENX5sPkqshwq
	 a+Kqi4Wr6+KhqlPHiV0kMFyve/SFkLiDxVH/mgVr796BqxITnt+uERDw41y3gQGH41
	 JTlDJaAc8q9O2fuR66Dm1HUxrWhNgvAfkA8wlLIs=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DLfgut1253257
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 16:41:42 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 16:41:41 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 16:41:41 -0500
Received: from fllvem-mr07.itg.ti.com ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DLfdNK2611079;
	Wed, 13 Aug 2025 16:41:41 -0500
From: Andrew Davis <afd@ti.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Vladimir Zapolskiy <vz@mleia.com>,
        Jacky Huang <ychuang3@nuvoton.com>,
        Shan-Chun Hung <schung@nuvoton.com>, Qin
 Jian <qinjian@cqplus1.com>
CC: <openbmc@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 5/6] reset: npcm: Use devm_register_sys_off_handler()
Date: Wed, 13 Aug 2025 16:41:37 -0500
Message-ID: <20250813214138.477659-6-afd@ti.com>
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
 drivers/reset/reset-npcm.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/reset/reset-npcm.c b/drivers/reset/reset-npcm.c
index e5b6127783a76..6939bb3eb1507 100644
--- a/drivers/reset/reset-npcm.c
+++ b/drivers/reset/reset-npcm.c
@@ -89,7 +89,6 @@ static const struct npcm_reset_info npxm8xx_reset_info[] = {
 
 struct npcm_rc_data {
 	struct reset_controller_dev rcdev;
-	struct notifier_block restart_nb;
 	const struct npcm_reset_info *info;
 	struct regmap *gcr_regmap;
 	u32 sw_reset_number;
@@ -100,11 +99,9 @@ struct npcm_rc_data {
 
 #define to_rc_data(p) container_of(p, struct npcm_rc_data, rcdev)
 
-static int npcm_rc_restart(struct notifier_block *nb, unsigned long mode,
-			   void *cmd)
+static int npcm_rc_restart(struct sys_off_data *data)
 {
-	struct npcm_rc_data *rc = container_of(nb, struct npcm_rc_data,
-					       restart_nb);
+	struct npcm_rc_data *rc = data->cb_data;
 
 	writel(NPCM_SWRST << rc->sw_reset_number, rc->base + NPCM_SWRSTR);
 	mdelay(1000);
@@ -472,9 +469,8 @@ static int npcm_rc_probe(struct platform_device *pdev)
 	if (!of_property_read_u32(pdev->dev.of_node, "nuvoton,sw-reset-number",
 				  &rc->sw_reset_number)) {
 		if (rc->sw_reset_number && rc->sw_reset_number < 5) {
-			rc->restart_nb.priority = 192;
-			rc->restart_nb.notifier_call = npcm_rc_restart;
-			ret = register_restart_handler(&rc->restart_nb);
+			ret = devm_register_sys_off_handler(&pdev->dev, SYS_OFF_MODE_RESTART, 192,
+							    npcm_rc_restart, rc);
 			if (ret) {
 				dev_warn(&pdev->dev, "failed to register restart handler\n");
 				return ret;
-- 
2.39.2



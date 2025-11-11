Return-Path: <linux-kernel+bounces-895325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 93100C4D769
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3EC2D34F9E0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B413587C8;
	Tue, 11 Nov 2025 11:42:48 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F160E3587BC;
	Tue, 11 Nov 2025 11:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861367; cv=none; b=u7fu1OqeE8D2gkq6/T+wzYc5X+GnWouGKolQTABwK5NTR1modNrD/yTOMkBpcj5ulT1RZekfa/aw0S1k7KaBxxetPgqRv1WUc0xnk4JJdOI79oWFzzXefQDK4vZAIYxXsLiqBPQug94PvelfMzcQ654ir9NcMPs1E/PwN8Uz29E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861367; c=relaxed/simple;
	bh=mFaVVam+QsIKOh8Y6I3dylyPM9lrSlVkAj+8EE1Oo8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eLqqHyPz4M2NXjJfylqG0P0DeKFB82bDEW4NfT1iVqHIz0yj0CuQGg1saxBvgsQbINnX5PzmZOckEugASnYFCRL1UajGVQjPIvpjaVVNN0BOFPQLukU4e8TLCPH1R89zT9bOX5/CwdiUXtGonW4ZHb9uj/1DSP1kUwta24jAecU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowAAnLG0nIRNpxCBaAA--.18506S2;
	Tue, 11 Nov 2025 19:42:32 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	peng.fan@nxp.com,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH] clk: imx: imx95-blk-ctl: Fix clock leak in error paths
Date: Tue, 11 Nov 2025 19:41:23 +0800
Message-ID: <20251111114123.2075-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAnLG0nIRNpxCBaAA--.18506S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFWUKFWUtrykZF4fJrykGrg_yoW8AFW8pF
	WxXFySkrW0gryIgw47Aw48XFyYgay7ta48try7C3Wru393GF10qF4rtFy0q3WvyFZ5C343
	JryvqFs8ua909r7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_Gw4l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5UDGDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAYDA2kTAhVZtQAAsL

The probe function enables bc->clk_apb early but fails to disable it
when bc_data is NULL or clk_hw_data allocation fails. The cleanup
path also misses pm_runtime_put_sync() when rpm is enabled.

Add err_disable_clk label to ensure clk_disable_unprepare() is called
on all error paths. Add pm_runtime_put_sync() in cleanup path when rpm
is enabled.

Fixes: 5224b189462f ("clk: imx: add i.MX95 BLK CTL clk driver")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/clk/imx/clk-imx95-blk-ctl.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-imx95-blk-ctl.c b/drivers/clk/imx/clk-imx95-blk-ctl.c
index 7e88877a6245..b12aded2b304 100644
--- a/drivers/clk/imx/clk-imx95-blk-ctl.c
+++ b/drivers/clk/imx/clk-imx95-blk-ctl.c
@@ -380,13 +380,19 @@ static int imx95_bc_probe(struct platform_device *pdev)
 	}
 
 	bc_data = of_device_get_match_data(dev);
-	if (!bc_data)
-		return devm_of_platform_populate(dev);
+	if (!bc_data) {
+		ret = devm_of_platform_populate(dev);
+		if (ret)
+			clk_disable_unprepare(bc->clk_apb);
+		return ret;
+	}
 
 	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws, bc_data->num_clks),
 				   GFP_KERNEL);
-	if (!clk_hw_data)
-		return -ENOMEM;
+	if (!clk_hw_data) {
+		ret = -ENOMEM;
+		goto err_disable_clk;
+	}
 
 	if (bc_data->rpm_enabled) {
 		devm_pm_runtime_enable(&pdev->dev);
@@ -444,7 +450,11 @@ static int imx95_bc_probe(struct platform_device *pdev)
 			continue;
 		clk_hw_unregister(hws[i]);
 	}
+	if (bc_data->rpm_enabled && pm_runtime_enabled(bc->dev))
+		pm_runtime_put_sync(&pdev->dev);
 
+err_disable_clk:
+	clk_disable_unprepare(bc->clk_apb);
 	return ret;
 }
 
-- 
2.50.1.windows.1



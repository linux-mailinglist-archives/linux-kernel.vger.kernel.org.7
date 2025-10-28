Return-Path: <linux-kernel+bounces-873431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6B6C13EB1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E448A508E87
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEC82D7390;
	Tue, 28 Oct 2025 09:48:52 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5932D2BB17
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761644932; cv=none; b=iWN1U7raES9dfecGnQf1W1P0r0xLgvLq+n93gb6PqFxJ/d1IlakxvUd8bFLrm2CQc8HIm7pUFnF+PG6Xem2UMfohEpC9/c21c0dJnxiiVFwcrAaCpEYOEMkBaaWCMlYdY1NzauwHXdHIwJ89Zqkrqu07HJNT5dFBIFfLbgHQn0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761644932; c=relaxed/simple;
	bh=039KXM2Bia+WDw1Z01xQadPYs+ttlGw/0e+/ILNcOhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A2XG3C4XqgrTRWkkYrUtqXgEFKKiy80KGHvDnxxpSxZOLVmQEio8oTvO9+/O9Dqhn5q/bnFbYXweyOUQ3IIUW0gnmNjuENQVtTOSVxRb91ZnGuIvkzkQWWUm2FBKHtAC8X6HWiGndbWbjrOxWtjU/tpLUE0Cmarj8oC8PY89rnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowACHZrlukQBpRIpCBA--.6967S2;
	Tue, 28 Oct 2025 17:48:32 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	vz@mleia.com,
	piotr.wojtaszczyk@timesys.com
Cc: dmitry.torokhov@gmail.com,
	linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH] mtd: rawnand: lpc32xx_slc: fix GPIO descriptor leak on probe error and remove
Date: Tue, 28 Oct 2025 17:47:47 +0800
Message-ID: <20251028094747.1089-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACHZrlukQBpRIpCBA--.6967S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWfZw1xXrW5tryDCF47XFb_yoW8Gr45pa
	18ArWjkr4UCr47Kan2ka18AF1Fyw40yrWYqr92k34F93Z8AryUXF95XayYvF4DKFWrGF4a
	vFs7tF1rAr1DZr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9E14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r4fMxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjFfO7UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAgJA2kAjysG1gAAsT

The driver calls gpiod_get_optional() in the probe function but
never calls gpiod_put() in the remove function or in the probe
error path. This leads to a GPIO descriptor resource leak.
The lpc32xx_mlc.c driver in the same directory handles this
correctly by calling gpiod_put() on both paths.

Add gpiod_put() in the remove function and in the probe error path
to fix the resource leak.

Fixes: 6b923db2867c ("mtd: rawnand: lpc32xx_slc: switch to using gpiod API")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/mtd/nand/raw/lpc32xx_slc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
index b54d76547ffb..fea3705a2138 100644
--- a/drivers/mtd/nand/raw/lpc32xx_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
@@ -937,6 +937,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	dma_release_channel(host->dma_chan);
 enable_wp:
 	lpc32xx_wp_enable(host);
+	gpiod_put(host->wp_gpio);
 
 	return res;
 }
@@ -962,6 +963,7 @@ static void lpc32xx_nand_remove(struct platform_device *pdev)
 	writel(tmp, SLC_CTRL(host->io_base));
 
 	lpc32xx_wp_enable(host);
+	gpiod_put(host->wp_gpio);
 }
 
 static int lpc32xx_nand_resume(struct platform_device *pdev)
-- 
2.50.1.windows.1



Return-Path: <linux-kernel+bounces-884555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0AFC306F6
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DA334E7CD3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1903126D4;
	Tue,  4 Nov 2025 10:11:20 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EFB296BD3
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762251080; cv=none; b=qdK4L9/qgZjUyRnNMF0jrDJNv2HlKxap4JcEN5rCwkDQEY3ZjblGNb+zdj6JKiAgz2XWufBUGFAk1iO/tYrbIe795tT+8sz2su+tigVMaU8iz1X4kZRvCoctZJocXwPzhWpASLAPhTRB6fjpkg1ThVq9lEvMnUhL6Q4hEQ6EBVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762251080; c=relaxed/simple;
	bh=Stbp/eEGSzT0nWr0OYHvCxY1kuEMyER2xBe8JaicD2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ObSiAlz1RP22FvxmRE6SP5YhdfYRTrhXk7pSEO0y663hERuHEgJcs1IUT1KxQqXqYnpQeQ6l7M1TDtiUSZCfRt85FHiLhO7YqzpbAgP9ocyVga+cvt5e0csUx8eVwNqZW3W5hriUYEDrUBNgrliqwRdyGIGKT07x7S/bPZ4RdXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-03 (Coremail) with SMTP id rQCowAAnpOst0QlpydtqAQ--.17454S2;
	Tue, 04 Nov 2025 18:10:55 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Cc: linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH] mtd: rawnand: lpc32xx_slc: Convert to use devm_gpiod_get_optional()
Date: Tue,  4 Nov 2025 18:08:41 +0800
Message-ID: <20251104100842.369-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAnpOst0QlpydtqAQ--.17454S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr4rGr18GFyUKw1kXw48Crg_yoW8XFWDpa
	ykAFWIkrWUCF4xKanrWa1kZF1Yy3y0yrWUGrW0934F9w1DXr1jqas5KF1FvFn0yFWrGF4Y
	vFZ7tF1rAw18Zr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	tVW8ZwCY02Avz4vE14v_Gw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjfU5FApDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgoQA2kJpV+0fgAAsP

The initial fix for a GPIO descriptor leak added manual gpiod_put()
calls in the error path and remove function.

This follow-up patch improves upon the fix by switching to the
resource-managed devm_gpiod_get_optional() API.

Suggested-by: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/mtd/nand/raw/lpc32xx_slc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
index fea3705a2138..3ca30e7dce33 100644
--- a/drivers/mtd/nand/raw/lpc32xx_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
@@ -854,7 +854,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	}
 
 	/* Start with WP disabled, if available */
-	host->wp_gpio = gpiod_get_optional(&pdev->dev, NULL, GPIOD_OUT_LOW);
+	host->wp_gpio = devm_gpiod_get_optional(&pdev->dev, NULL, GPIOD_OUT_LOW);
 	res = PTR_ERR_OR_ZERO(host->wp_gpio);
 	if (res) {
 		if (res != -EPROBE_DEFER)
@@ -937,7 +937,6 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	dma_release_channel(host->dma_chan);
 enable_wp:
 	lpc32xx_wp_enable(host);
-	gpiod_put(host->wp_gpio);
 
 	return res;
 }
@@ -963,7 +962,6 @@ static void lpc32xx_nand_remove(struct platform_device *pdev)
 	writel(tmp, SLC_CTRL(host->io_base));
 
 	lpc32xx_wp_enable(host);
-	gpiod_put(host->wp_gpio);
 }
 
 static int lpc32xx_nand_resume(struct platform_device *pdev)
-- 
2.50.1.windows.1



Return-Path: <linux-kernel+bounces-884062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 59182C2F3E0
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 05:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B0FB4E698C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 04:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1591D7E5C;
	Tue,  4 Nov 2025 04:05:33 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E37418EFD1;
	Tue,  4 Nov 2025 04:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762229133; cv=none; b=lOszF+mIllwb/o5G2NxGqM84Ba4BvHB2Dp5ktDHsn9TbjfnA5ibMiunlxFVPAW2O2Uje8CJPMp4/ODB7w6TGAkAggA6rIkExYMzQankZDEaPDEb51GergXFfYkSQruxqDcdd5Fhf3c/TQf12624sumDHH3KUKbAjYnwQg2pskN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762229133; c=relaxed/simple;
	bh=9aFU8M1H4GhB4GO8OLI/CJPOoAF5GXOiQ8AtQbX7n6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tBV2Ipwr5fOcByPkMxt6A0c9vJDBO3B2G5z5zg/0NuUZrkO1JZ4a4zKyLI+IMeDPn7Ck3MSoce7oAOR3qAjvNrqfU+1Jcwoewu2zE6lvwDLck6OB71zZIuzwCnk3vYaSPd/oRyL+QVyzV/0ZpUzznSpD94AFBy5urcRQBMRU720=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowAB3IO94ewlpspxhAQ--.25862S2;
	Tue, 04 Nov 2025 12:05:14 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH] clk: mediatek: mt8173-apmixed: Fix ioremap resource leak in remove function
Date: Tue,  4 Nov 2025 12:04:31 +0800
Message-ID: <20251104040431.1452-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3IO94ewlpspxhAQ--.25862S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr45WrW5JFW3XFyfuw48WFg_yoW8AF17pF
	ykKFWakay8tw4Uur1vy3yvkF1Fva1Iqa45KFy7W3s3ZwnxGrZ2yF1rKayvva4xArWkKr1D
	tr1UurWxCFW7AFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	tVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgsQA2kJG3SlGQABss

The driver uses of_iomap() to map I/O memory in probe function, but
forgets to call iounmap() in the remove function, leading to a resource
leak when the driver is unloaded.

Replace of_iomap() with devm_of_iomap() to automatically manage the
I/O memory mapping. Remove the now-unnecessary unmap_io label and
iounmap() call from the error path.

Fixes: 4c02c9af3cb9 ("clk: mediatek: mt8173: Break down clock drivers and allow module build")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/clk/mediatek/clk-mt8173-apmixedsys.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
index 95385bb67d55..ae759ef51f03 100644
--- a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
@@ -146,15 +146,13 @@ static int clk_mt8173_apmixed_probe(struct platform_device *pdev)
 	struct clk_hw *hw;
 	int r;
 
-	base = of_iomap(node, 0);
-	if (!base)
-		return -ENOMEM;
+	base = devm_of_iomap(&pdev->dev, node, 0, NULL);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 
 	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
-	if (IS_ERR_OR_NULL(clk_data)) {
-		r = -ENOMEM;
-		goto unmap_io;
-	}
+	if (IS_ERR_OR_NULL(clk_data))
+		return -ENOMEM;
 
 	fhctl_parse_dt(fhctl_node, pllfhs, ARRAY_SIZE(pllfhs));
 	r = mtk_clk_register_pllfhs(node, plls, ARRAY_SIZE(plls),
@@ -188,8 +186,6 @@ static int clk_mt8173_apmixed_probe(struct platform_device *pdev)
 				  ARRAY_SIZE(pllfhs), clk_data);
 free_clk_data:
 	mtk_free_clk_data(clk_data);
-unmap_io:
-	iounmap(base);
 	return r;
 }
 
-- 
2.50.1.windows.1



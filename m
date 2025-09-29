Return-Path: <linux-kernel+bounces-835685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B311ABA7CEA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 04:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6315C3C1FA6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 02:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9560A1FF5F9;
	Mon, 29 Sep 2025 02:36:38 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FAABA3D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759113398; cv=none; b=jecs6i9NWUqv1mktC5Ah5WWaEajOxVM9zJW3qzkUo+H34D5huOjuOSG5Yn2b3uJ3l0HEzCdccHZ9J/GWwkQwj3FGiBd3qErq29QLf1UtmqyI1wdyquiFkZCbD8whoEBYiFgFXdrt5pOwnmZN4ytL+DXNYmaGA9e70kYnX9vAnBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759113398; c=relaxed/simple;
	bh=wjXQc3j/D3lzBcRGHvR25gLdygUmV2ZbB9zYpeIYlPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dp9CLTcgwTkcsYxzw7XgSTz7CSJyIIrUAbtdrTv9cA0B64MnV3jS/AMn08OQQbv9C/7YyEnLBjcmhdV/cfhAojuqCbO2muk7AagYbx3uCIRqQbu0P9t2wn2vDSIh++JVD7IgAAS6yisugQJoPW1mbVILNAMSNcF4VHjnIl2Pw38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowABX+RKr8NloAxaICA--.65038S2;
	Mon, 29 Sep 2025 10:36:29 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH] clk: mediatek: Use devm_alloc for clk_data allocation to fix memory leak on probe error
Date: Mon, 29 Sep 2025 10:36:20 +0800
Message-ID: <20250929023621.1968-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABX+RKr8NloAxaICA--.65038S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF13tr1DZry8Ww47WrW5GFg_yoW8WFy3pF
	ykGFWYya4ayw47KFW8tr4kK3WSy340ga4UKF15u3s7u345Gr4jkFZYk3sYva4IyrZ2kFy2
	qrn09r48ZayUuFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUehL0UU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAUAA2jZ4CVDngAAsj

The probe functions for the mt6765 apmixed, top, and infrasys clocks
use mtk_alloc_clk_data() to allocate memory. This requires manual
freeing of the memory in all error handling paths and in the driver's
remove function.

Switch to mtk_devm_alloc_clk_data() in order to fix the memory leak in the
probe function.

Fixes: 1aca9939bf72 ("clk: mediatek: Add MT6765 clock support")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/clk/mediatek/clk-mt6765.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt6765.c b/drivers/clk/mediatek/clk-mt6765.c
index d53731e7933f..5cfb9a3a5ee3 100644
--- a/drivers/clk/mediatek/clk-mt6765.c
+++ b/drivers/clk/mediatek/clk-mt6765.c
@@ -736,7 +736,7 @@ static int clk_mt6765_apmixed_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
+	clk_data = mtk_devm_alloc_clk_data(CLK_APMIXED_NR_CLK);
 	if (!clk_data)
 		return -ENOMEM;
 
@@ -770,7 +770,7 @@ static int clk_mt6765_top_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
+	clk_data = mtk_devm_alloc_clk_data(CLK_TOP_NR_CLK);
 	if (!clk_data)
 		return -ENOMEM;
 
@@ -810,7 +810,7 @@ static int clk_mt6765_ifr_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	clk_data = mtk_alloc_clk_data(CLK_IFR_NR_CLK);
+	clk_data = mtk_devm_alloc_clk_data(CLK_IFR_NR_CLK);
 	if (!clk_data)
 		return -ENOMEM;
 
-- 
2.50.1.windows.1



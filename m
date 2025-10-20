Return-Path: <linux-kernel+bounces-861388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CB650BF2991
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BED9034B2DD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C803E32AAC4;
	Mon, 20 Oct 2025 17:04:58 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9B5221FB6;
	Mon, 20 Oct 2025 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979898; cv=none; b=tbT5af7TWE6AUl1p0DdF9/nwF/5LX1+HnSOepMIt69fKVLHwjqIIoo4aMU12IiUXwF751aGUFjPQo1JAvIc6YRM7f/eCFBokeUAc95Mtz2Z6pMJZkuh6LEnJ3n64Jp9ILZF0gby/71kkaKypKAlQmHV+HgJdpId8N2CSloOmGEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979898; c=relaxed/simple;
	bh=RhAB+xKbxMLIMXYDXmqkmJqaASOGsSRQzFcwjT1q+U0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jxcS9y+fy3ACe9iiVTGRUhqa2U6UJvntWP1kuipLpEBsjGAepcVDO2cH4FjYzTr2NHysIpNCmWq814B68IXmfyhZI0hhGGMi1HUUHqAEfrMqvkxr9njbLJ9l7PbLXFKyDy6Kp1UPwmaBhjsHXmvR28R7O8RLLe3Tg1rz2F5eWa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [114.245.38.183])
	by APP-01 (Coremail) with SMTP id qwCowAAnfqCsa_ZoP4ErEg--.24677S2;
	Tue, 21 Oct 2025 01:04:44 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH] ASoC: mediatek: Fix double pm_runtime_disable in remove functions
Date: Tue, 21 Oct 2025 01:04:40 +0800
Message-ID: <20251020170440.585-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAnfqCsa_ZoP4ErEg--.24677S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJrW8ZF4UAF4UGFWktry7ZFb_yoW8ZFy3pw
	nYga93t3yaqr1UAanrAw10qa4a9ryfCF43Gryq9347Z343Xr1IvF4qy34jvFWkKFykKanx
	GFyUtFy7Gr4FqFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRABA2j2T10bSgABsH

Both mt8195-afe-pcm and mt8365-afe-pcm drivers use devm_pm_runtime_enable()
in probe function, which automatically calls pm_runtime_disable() on device
removal via devres mechanism. However, the remove callbacks explicitly call
pm_runtime_disable() again, resulting in double pm_runtime_disable() calls.

Fix by removing the redundant pm_runtime_disable() calls from remove
functions, letting the devres framework handle it automatically.

Fixes: 2ca0ec01d49c ("ASoC: mediatek: mt8195-afe-pcm: Simplify runtime PM during probe")
Fixes: e1991d102bc2 ("ASoC: mediatek: mt8365: Add the AFE driver support")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c | 1 -
 sound/soc/mediatek/mt8365/mt8365-afe-pcm.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
index 5d025ad72263..c63b3444bc17 100644
--- a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
+++ b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
@@ -3176,7 +3176,6 @@ static int mt8195_afe_pcm_dev_probe(struct platform_device *pdev)
 
 static void mt8195_afe_pcm_dev_remove(struct platform_device *pdev)
 {
-	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		mt8195_afe_runtime_suspend(&pdev->dev);
 }
diff --git a/sound/soc/mediatek/mt8365/mt8365-afe-pcm.c b/sound/soc/mediatek/mt8365/mt8365-afe-pcm.c
index 10793bbe9275..d48252cd96ac 100644
--- a/sound/soc/mediatek/mt8365/mt8365-afe-pcm.c
+++ b/sound/soc/mediatek/mt8365/mt8365-afe-pcm.c
@@ -2238,7 +2238,6 @@ static void mt8365_afe_pcm_dev_remove(struct platform_device *pdev)
 
 	mt8365_afe_disable_top_cg(afe, MT8365_TOP_CG_AFE);
 
-	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		mt8365_afe_runtime_suspend(&pdev->dev);
 }
-- 
2.25.1



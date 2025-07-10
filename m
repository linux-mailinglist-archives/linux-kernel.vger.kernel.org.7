Return-Path: <linux-kernel+bounces-724739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F54AFF663
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27A5217090B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 01:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0B62701A3;
	Thu, 10 Jul 2025 01:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Ri8SbPqW"
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F76AA95C;
	Thu, 10 Jul 2025 01:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752110300; cv=none; b=QWWvpOAkUuBoEvQxeGNnevPW4C4yNn9ds2zueWeg6kHDDm1d/2Fgzz0njQdotHR1RLweyaCii3xLON0UsXonNyQ857vl/pNEwgilnemsYZL9fmkXHCfSAgI36sy8Zi5S3El7K5MJthFnyEJSmI8F76MDYhZkyHgMlJ7X5JXxrWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752110300; c=relaxed/simple;
	bh=bhHpyxyAGVbF0NSiWpz6PTn5WY5ZCe9QNc46RU3MHis=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U2N8n8sq5ow4TLgW7VzTKKPX/86ht6TmRw5MZ2NOgCZYL3XYB9Y57SLy96WaOTwmcgZ1gCuaseLPuNbsaATd8wrtXoelt77f9wA3jRe66ZqQiNy6tKABo2s1P0XuNzwvom7fIGv1qYac8GGvv86JAXgdTskSIKVJUbC27l1S3Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Ri8SbPqW; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from laptop.lan (unknown [123.123.45.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 299183F6D4;
	Thu, 10 Jul 2025 01:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1752110295;
	bh=wvXX3+98b9csWyA6dkKmj1aJ7aZiKSOMpW9t77vrV88=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=Ri8SbPqWN+8sNA2eSG1ZrBs8nnTbhVJj4L/h1Ei8ODqA7rl5uMPibgt/t2ApkOVZs
	 1thpTWO7rPzv3GviGAubZHFsrDQv3UHwvBWskn43uyITe/1Yk+e29OI+GFpgmOCEhy
	 +GligoP3K6XD99BV8G6DluC9bgxkivdvTDk2gN5Ev5qrcneCTeJHbmE99C+fYV9AxI
	 AoWGuMfKQbJ+r61jxDMnvtSaqIzPrhH4MCDB5lMrj2adlej0CAX49k4VVITKAGGaBf
	 DhBYgVW2VLSq870ENxViVrSoZ0nI+024t2Za8NtyhrsZ5JJHSCM4CkX/c/aGhL8WKA
	 Wwwet6O9hW1iw==
From: Guoqing Jiang <guoqing.jiang@canonical.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	angelogioacchino.delregno@collabora.com,
	amergnat@baylibre.com
Cc: zoran.zhan@mediatek.com,
	guoqing.jiang@canonical.com,
	linux-sound@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2] ASoC: mediatek: mt8365-dai-i2s: pass correct size to mt8365_dai_set_priv
Date: Thu, 10 Jul 2025 09:18:06 +0800
Message-Id: <20250710011806.134507-1-guoqing.jiang@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Given mt8365_dai_set_priv allocate priv_size space to copy priv_data which
means we should pass mt8365_i2s_priv[i] or "struct mtk_afe_i2s_priv"
instead of afe_priv which has the size of "struct mt8365_afe_private".

Otherwise the KASAN complains about.

[   59.389765] BUG: KASAN: global-out-of-bounds in mt8365_dai_set_priv+0xc8/0x168 [snd_soc_mt8365_pcm]
...
[   59.394789] Call trace:
[   59.395167]  dump_backtrace+0xa0/0x128
[   59.395733]  show_stack+0x20/0x38
[   59.396238]  dump_stack_lvl+0xe8/0x148
[   59.396806]  print_report+0x37c/0x5e0
[   59.397358]  kasan_report+0xac/0xf8
[   59.397885]  kasan_check_range+0xe8/0x190
[   59.398485]  asan_memcpy+0x3c/0x98
[   59.399022]  mt8365_dai_set_priv+0xc8/0x168 [snd_soc_mt8365_pcm]
[   59.399928]  mt8365_dai_i2s_register+0x1e8/0x2b0 [snd_soc_mt8365_pcm]
[   59.400893]  mt8365_afe_pcm_dev_probe+0x4d0/0xdf0 [snd_soc_mt8365_pcm]
[   59.401873]  platform_probe+0xcc/0x228
[   59.402442]  really_probe+0x340/0x9e8
[   59.402992]  driver_probe_device+0x16c/0x3f8
[   59.403638]  driver_probe_device+0x64/0x1d8
[   59.404256]  driver_attach+0x1dc/0x4c8
[   59.404840]  bus_for_each_dev+0x100/0x190
[   59.405442]  driver_attach+0x44/0x68
[   59.405980]  bus_add_driver+0x23c/0x500
[   59.406550]  driver_register+0xf8/0x3d0
[   59.407122]  platform_driver_register+0x68/0x98
[   59.407810]  mt8365_afe_pcm_driver_init+0x2c/0xff8 [snd_soc_mt8365_pcm]

Fixes: 402bbb13a195 ("ASoC: mediatek: mt8365: Add I2S DAI support")
Signed-off-by: Guoqing Jiang <guoqing.jiang@canonical.com>
---
V2:
1. fix issue reported by lkp, thanks.

 sound/soc/mediatek/mt8365/mt8365-dai-i2s.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c b/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c
index cae51756cead..cb9beb172ed5 100644
--- a/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c
+++ b/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c
@@ -812,11 +812,10 @@ static const struct snd_soc_dapm_route mtk_dai_i2s_routes[] = {
 static int mt8365_dai_i2s_set_priv(struct mtk_base_afe *afe)
 {
 	int i, ret;
-	struct mt8365_afe_private *afe_priv = afe->platform_priv;
 
 	for (i = 0; i < DAI_I2S_NUM; i++) {
 		ret = mt8365_dai_set_priv(afe, mt8365_i2s_priv[i].id,
-					  sizeof(*afe_priv),
+					  sizeof(mt8365_i2s_priv[i]),
 					  &mt8365_i2s_priv[i]);
 		if (ret)
 			return ret;
-- 
2.34.1



Return-Path: <linux-kernel+bounces-885849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA43CC340AE
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 07:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83FFA425314
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 06:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799BE2BFC8F;
	Wed,  5 Nov 2025 06:23:28 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35948263F30;
	Wed,  5 Nov 2025 06:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762323808; cv=none; b=ruOKlYp1f0yjAhyazfceR44D3E+x19uMjg1bByRyRnvrYiQ9LGwfhoXPJYlCHh+A1AeNHNnwoxohoROeEadomD9rGIvlGUX9BQqFeUTY85RwVAkqL8WXMi2wvsTC4tiiafVVXqN+VxysaKvHr16idmqh19dc01UZdul63kgvCFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762323808; c=relaxed/simple;
	bh=VIR9Whq88jpa6u58Lv1evNfzNn7yH1nAJgRyFqo6ot8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TcbPqzMPDJ+PqWcrDZkybrxkHvMigHlXhZeXblfFbB8BCkwJXcaT1Xo5mpuoX6cF2c2EiqnM2vGYO9tLHLZ6yal602er6uo2ZBeja8kqLo2n3MPF6J8Ism4kzFSm5gvw5tdCiSD7yR7pfHaGsRq8XjBBdlQqXgfPvhvK9KQlCUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-03 (Coremail) with SMTP id rQCowABHxexD7QppON+RAQ--.24686S2;
	Wed, 05 Nov 2025 14:23:01 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH] ASoC: cs4271: Fix regulator leak on probe failure
Date: Wed,  5 Nov 2025 14:22:46 +0800
Message-ID: <20251105062246.1955-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABHxexD7QppON+RAQ--.24686S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJrW5KrWDuw1DZryxGr43GFg_yoW8AFy3pr
	n0qrZYkryUZFyrAr4vyr1fZ3WkurWfta1xG3s7G342vw15t3Z7uF1fKa4YvF97CrWkG3Zr
	ArW2yrW8CF18CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRARA2kK3AiJOQABsN

The probe function enables regulators at the beginning
but fails to disable them in its error handling path.
If any operation after enabling the regulators fails,
the probe will exit with an error, leaving the regulators
permanently enabled, which could lead to a resource leak.

Add a proper error handling path to call regulator_bulk_disable()
before returning an error.

Fixes: 9a397f473657 ("ASoC: cs4271: add regulator consumer support")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 sound/soc/codecs/cs4271.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index 6a3cca3d26c7..ead447a5da7f 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -581,17 +581,17 @@ static int cs4271_component_probe(struct snd_soc_component *component)
 
 	ret = regcache_sync(cs4271->regmap);
 	if (ret < 0)
-		return ret;
+		goto err_disable_regulator;
 
 	ret = regmap_update_bits(cs4271->regmap, CS4271_MODE2,
 				 CS4271_MODE2_PDN | CS4271_MODE2_CPEN,
 				 CS4271_MODE2_PDN | CS4271_MODE2_CPEN);
 	if (ret < 0)
-		return ret;
+		goto err_disable_regulator;
 	ret = regmap_update_bits(cs4271->regmap, CS4271_MODE2,
 				 CS4271_MODE2_PDN, 0);
 	if (ret < 0)
-		return ret;
+		goto err_disable_regulator;
 	/* Power-up sequence requires 85 uS */
 	udelay(85);
 
@@ -601,6 +601,10 @@ static int cs4271_component_probe(struct snd_soc_component *component)
 				   CS4271_MODE2_MUTECAEQUB);
 
 	return 0;
+
+err_disable_regulator:
+	regulator_bulk_disable(ARRAY_SIZE(cs4271->supplies), cs4271->supplies);
+	return ret;
 }
 
 static void cs4271_component_remove(struct snd_soc_component *component)
-- 
2.50.1.windows.1



Return-Path: <linux-kernel+bounces-835703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92854BA7D83
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 04:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C8D64E0231
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 02:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E804B20E328;
	Mon, 29 Sep 2025 02:54:17 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A12E200C2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759114457; cv=none; b=dDF9/kFNWtNVbySxLNCrfwTzkHnB5NF7fwrekxSaev74bzyeLtJ8kpEkCgJVHFGrcqICufvTARrjWhAtw5UgOfmP1Y8MksygOqfhA6mbCKyfweWlRhWfEeHu01Zjy5FS780gEB1mvzCZXqQr5tdSPq44WWKd7frFNco0aTsXl7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759114457; c=relaxed/simple;
	bh=QAYCtptksbF3Zbego6PyHqNwteDGed3frGeLlceiUAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dfQnKcwVimojgSsnTVmncpl3APR+0tL5WAU6uAaf511daUM3V1pHDa97kcMe81qck7gHIMRrApZD7MPBZ3aHy1IuQ92fXVp3yLVg41UdPHjYqA1gZcggB8D7acEpSthVwoHOvgg/nhc1Q1IRITxggvO2MRoZKaKu59OUpmqlx88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowABX+RLN9NloTWOKCA--.65172S2;
	Mon, 29 Sep 2025 10:54:06 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: David Lechner <dlechner@baylibre.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH] iio: adc: mt6360: Handle error in cleanup path correctly
Date: Mon, 29 Sep 2025 10:53:58 +0800
Message-ID: <20250929025358.2064-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABX+RLN9NloTWOKCA--.65172S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4kJw1DGr4ktryrJw13Jwb_yoW8Xw43pr
	4jkFyDJFy09FyfCF4xta1UZFWFya17Gryjy34DC3ZrZ3s8Ar12gF1rJFyqva4vvrZIyan0
	vrWUCrWUuw1UZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
	xVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r4UMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbKhF3UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwwAA2jZ4FFQ9QAAst

The return value of a regmap_raw_write() in the cleanup path was
being ignored.

Fix this by checking the return value and propagating the error.

Fixes: 1f4877218f7e ("iio: adc: mt6360: Add ADC driver for MT6360")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/iio/adc/mt6360-adc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mt6360-adc.c b/drivers/iio/adc/mt6360-adc.c
index 69b3569c90e5..97c4af8a93fc 100644
--- a/drivers/iio/adc/mt6360-adc.c
+++ b/drivers/iio/adc/mt6360-adc.c
@@ -70,6 +70,7 @@ static int mt6360_adc_read_channel(struct mt6360_adc_data *mad, int channel, int
 	ktime_t predict_end_t, timeout;
 	unsigned int pre_wait_time;
 	int ret;
+	int cleanup_ret;
 
 	mutex_lock(&mad->adc_lock);
 
@@ -130,11 +131,15 @@ static int mt6360_adc_read_channel(struct mt6360_adc_data *mad, int channel, int
 out_adc_conv:
 	/* Only keep ADC enable */
 	adc_enable = cpu_to_be16(MT6360_ADCEN_MASK);
-	regmap_raw_write(mad->regmap, MT6360_REG_PMUADCCFG, &adc_enable, sizeof(adc_enable));
+	cleanup_ret = regmap_raw_write(mad->regmap, MT6360_REG_PMUADCCFG,
+				&adc_enable, sizeof(adc_enable));
+	if (ret >= 0)
+		ret = cleanup_ret;
 	mad->last_off_timestamps[channel] = ktime_get();
 	/* Config prefer channel to NO_PREFER */
 	regmap_update_bits(mad->regmap, MT6360_REG_PMUADCRPT1, MT6360_PREFERCH_MASK,
 			   MT6360_NO_PREFER << MT6360_PREFERCH_SHFT);
+
 out_adc_lock:
 	mutex_unlock(&mad->adc_lock);
 
-- 
2.50.1.windows.1



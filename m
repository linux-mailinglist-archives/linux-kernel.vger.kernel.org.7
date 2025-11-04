Return-Path: <linux-kernel+bounces-883937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FD8C2ED62
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 02:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C333BF810
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 01:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E376D2264CA;
	Tue,  4 Nov 2025 01:41:45 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ED3225A3D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 01:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762220505; cv=none; b=LUWY3CoxxgHal7+4VI28c9uwGdo0Y8zUdMlI3epRHTUBN5icRCngZ08Cj3qYPdTFeRZtjKuQngFWz6BQkkecEUdXwzzCS4Fr+/tmn4OM8TBagEHPZswqPDtsV59EYArJxTQPLeuiUam2BG3sya8VurBfVMEdFc0nzSpG9jdJNrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762220505; c=relaxed/simple;
	bh=XXJyipCZAthiZQNDfMxD1MKPGDgk0BSGEx8bJ88lM84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=toeBFOjfR+qFuBwAYNC4wX1Yg6ZyE8Yb1IkoqYgO5OYquvZ7w5RcY9aWIzHB892qXvk1dpB3xv5uD/FgIcz2ZiEE0ZZWfpROHIAh6cE0zgmnJfYiUdNESWcSt4xXqOuEChVjpRP9V93zN5/nhQhyqwr+0YWukgiCSDuutqUS7YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowAA3pfPIWQlpa4FbAQ--.16754S2;
	Tue, 04 Nov 2025 09:41:29 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	vz@mleia.com,
	piotr.wojtaszczyk@timesys.com
Cc: linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH v2] mtd: rawnand: lpc32xx_slc: fix GPIO descriptor leak
Date: Tue,  4 Nov 2025 09:40:42 +0800
Message-ID: <20251104014042.1389-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20251028094747.1089-1-vulab@iscas.ac.cn>
References: <20251028094747.1089-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAA3pfPIWQlpa4FbAQ--.16754S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWfZw1xXrW5Zw18Zw4fXwb_yoW8GrWUpa
	yUAFWjkr1DCr429FsFga18AF1Fka10yrWUKryjg34Y9wn8ZrWUtas5Kr15ZF12kFZ5GF4Y
	vF4kJw1rCrykZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUtVW8ZwCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnU
	UI43ZEXa7VU1xu4UUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwsQA2kJRL9QgwAAsX

The driver calls gpiod_get_optional() in the probe function but
never calls gpiod_put() in the remove function or in the probe
error path. This leads to a GPIO descriptor resource leak.
The lpc32xx_mlc.c driver in the same directory handles this
correctly by calling gpiod_put() on both paths.

Switch to devm_gpiod_get_optional() to automatically manage
GPIO descriptor resource.

Fixes: 6b923db2867c ("mtd: rawnand: lpc32xx_slc: switch to using gpiod API")
Suggested by: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>

---
Changes in v2:
 -Switch to devm_gpiod_get_optional()
---
 drivers/mtd/nand/raw/lpc32xx_slc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
index b54d76547ffb..3ca30e7dce33 100644
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
-- 
2.50.1.windows.1



Return-Path: <linux-kernel+bounces-688360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44533ADB178
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 15:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1C6174CDA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 13:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60942ECE94;
	Mon, 16 Jun 2025 13:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Kor3MH/X"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4AB2E06ED
	for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 13:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750079653; cv=none; b=DfW5OgI1zqUy5E70epjsRvTjSJ0KoTl4tim/ZQJFFHgF4GJiimkMMC98vZHvXv2RkxWWCc6ckGrhJJMHb0DyiWpJC/FKHRowbFHr89qIRd7MVZMP9WXuQcYCzjmQFZOboMDW6tmA0R3s3t0XW6zaj5xwiQvSWXr+hE5o+WtKGPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750079653; c=relaxed/simple;
	bh=NTaaj0bQBTFyCLNa/36CV97eeQ50/YQ67VFHukPjTeM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T5zFwzJIWXYiOTCXHOhkowfirTsMX+fMMSmqISq7yIUPOiyZ08d/7RBWM01nDHN7VLWYLsCTQZJ7h+mkFQLGBd4djQMNgkG5cAJALW6CqT1kkiVv35148hMibo5myXaakz3YWQLBxEfgGAolvQAw/zlRkE+4ooQw+des2hpKOJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Kor3MH/X; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750079645;
	bh=6h0ix1ZdixoOBaPO3IlzuOaav+hjON9yVdm3QZ+ABs4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Kor3MH/XjP0L5Qf7xtsszE318PqOoYFUW4LmZufq+PV1IG00ZaBxZrGo4TV66c7wT
	 g/nO3IrU50YVymtMloXXIbGQO+f8DLdIeKGiiVz3Q39yBcMJhutjCY1P6IjDZcisrS
	 Mp4NB+eBYCz2rS1A5RsP1/CnZwOuLKNxHufGdxTqrrcnnrzFDrQuj1rrGpaHw1AygZ
	 W7rF21jQzGf2p4NFQsopVAid4EohIDoKXZrPsbz1GXOG9DYcwhz3RlB0Ry6fJjxZMR
	 znMkjUBhJV1S6JgpRCyd+bOGYamCJcDsSsZOIR3i4zyI6uJd3FJ5nWWndufy7SaULP
	 IP1uL0ys+1VIg==
Received: from [127.0.1.1] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0A88368865;
	Mon, 16 Jun 2025 21:14:04 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 16 Jun 2025 22:43:47 +0930
Subject: [PATCH v2 10/10] soc: aspeed: lpc-snoop: Lift channel config to
 const structs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-aspeed-lpc-snoop-fixes-v2-10-3cdd59c934d3@codeconstruct.com.au>
References: <20250616-aspeed-lpc-snoop-fixes-v2-0-3cdd59c934d3@codeconstruct.com.au>
In-Reply-To: <20250616-aspeed-lpc-snoop-fixes-v2-0-3cdd59c934d3@codeconstruct.com.au>
To: linux-aspeed@lists.ozlabs.org
Cc: Joel Stanley <joel@jms.id.au>, Henry Martin <bsdhenrymartin@gmail.com>, 
 Jean Delvare <jdelvare@suse.de>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Andrew Geissler <geissonator@yahoo.com>, 
 Ninad Palsule <ninad@linux.ibm.com>, Patrick Venture <venture@google.com>, 
 Robert Lippert <roblip@gmail.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@codeconstruct.com.au>
X-Mailer: b4 0.14.2

The shifts and masks for each channel are defined by hardware and
are not something that changes at runtime. Accordingly, describe the
information in an array of const structs and associate elements with
each channel instance, removing the need for the switch and handling of
its default case.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 100 +++++++++++++++-------------------
 1 file changed, 45 insertions(+), 55 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index 9f88c5471b1b6d85f6d9e1970240f3d1904d166c..2d97b8d5fb429e215c321c9c2ee3fa35d39f8618 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -63,7 +63,16 @@ enum aspeed_lpc_snoop_index {
 	ASPEED_LPC_SNOOP_INDEX_MAX = ASPEED_LPC_SNOOP_INDEX_1,
 };
 
+struct aspeed_lpc_snoop_channel_cfg {
+	enum aspeed_lpc_snoop_index index;
+	u32 hicr5_en;
+	u32 snpwadr_mask;
+	u32 snpwadr_shift;
+	u32 hicrb_en;
+};
+
 struct aspeed_lpc_snoop_channel {
+	const struct aspeed_lpc_snoop_channel_cfg *cfg;
 	bool enabled;
 	struct kfifo		fifo;
 	wait_queue_head_t	wq;
@@ -77,6 +86,23 @@ struct aspeed_lpc_snoop {
 	struct aspeed_lpc_snoop_channel chan[ASPEED_LPC_SNOOP_INDEX_MAX + 1];
 };
 
+static const struct aspeed_lpc_snoop_channel_cfg channel_cfgs[ASPEED_LPC_SNOOP_INDEX_MAX + 1] = {
+	{
+		.index = ASPEED_LPC_SNOOP_INDEX_0,
+		.hicr5_en = HICR5_EN_SNP0W | HICR5_ENINT_SNP0W,
+		.snpwadr_mask = SNPWADR_CH0_MASK,
+		.snpwadr_shift = SNPWADR_CH0_SHIFT,
+		.hicrb_en = HICRB_ENSNP0D,
+	},
+	{
+		.index = ASPEED_LPC_SNOOP_INDEX_1,
+		.hicr5_en = HICR5_EN_SNP1W | HICR5_ENINT_SNP1W,
+		.snpwadr_mask = SNPWADR_CH1_MASK,
+		.snpwadr_shift = SNPWADR_CH1_SHIFT,
+		.hicrb_en = HICRB_ENSNP1D,
+	},
+};
+
 static struct aspeed_lpc_snoop_channel *snoop_file_to_chan(struct file *file)
 {
 	return container_of(file->private_data,
@@ -189,28 +215,27 @@ static int aspeed_lpc_snoop_config_irq(struct aspeed_lpc_snoop *lpc_snoop,
 }
 
 __attribute__((nonnull))
-static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
-				   struct device *dev,
-				   enum aspeed_lpc_snoop_index index, u16 lpc_port)
+static int aspeed_lpc_enable_snoop(struct device *dev,
+				    struct aspeed_lpc_snoop *lpc_snoop,
+				    struct aspeed_lpc_snoop_channel *channel,
+				    const struct aspeed_lpc_snoop_channel_cfg *cfg,
+				    u16 lpc_port)
 {
 	const struct aspeed_lpc_snoop_model_data *model_data;
-	u32 hicr5_en, snpwadr_mask, snpwadr_shift, hicrb_en;
-	struct aspeed_lpc_snoop_channel *channel;
 	int rc = 0;
 
-	channel = &lpc_snoop->chan[index];
-
 	if (WARN_ON(channel->enabled))
 		return -EBUSY;
 
 	init_waitqueue_head(&channel->wq);
 
+	channel->cfg = cfg;
 	channel->miscdev.minor = MISC_DYNAMIC_MINOR;
 	channel->miscdev.fops = &snoop_fops;
 	channel->miscdev.parent = dev;
 
 	channel->miscdev.name =
-		devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME, index);
+		devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME, cfg->index);
 	if (!channel->miscdev.name)
 		return -ENOMEM;
 
@@ -223,39 +248,18 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 		goto err_free_fifo;
 
 	/* Enable LPC snoop channel at requested port */
-	switch (index) {
-	case 0:
-		hicr5_en = HICR5_EN_SNP0W | HICR5_ENINT_SNP0W;
-		snpwadr_mask = SNPWADR_CH0_MASK;
-		snpwadr_shift = SNPWADR_CH0_SHIFT;
-		hicrb_en = HICRB_ENSNP0D;
-		break;
-	case 1:
-		hicr5_en = HICR5_EN_SNP1W | HICR5_ENINT_SNP1W;
-		snpwadr_mask = SNPWADR_CH1_MASK;
-		snpwadr_shift = SNPWADR_CH1_SHIFT;
-		hicrb_en = HICRB_ENSNP1D;
-		break;
-	default:
-		rc = -EINVAL;
-		goto err_misc_deregister;
-	}
-
-	/* Enable LPC snoop channel at requested port */
-	regmap_update_bits(lpc_snoop->regmap, HICR5, hicr5_en, hicr5_en);
-	regmap_update_bits(lpc_snoop->regmap, SNPWADR, snpwadr_mask,
-			   lpc_port << snpwadr_shift);
+	regmap_set_bits(lpc_snoop->regmap, HICR5, cfg->hicr5_en);
+	regmap_update_bits(lpc_snoop->regmap, SNPWADR, cfg->snpwadr_mask,
+		lpc_port << cfg->snpwadr_shift);
 
 	model_data = of_device_get_match_data(dev);
 	if (model_data && model_data->has_hicrb_ensnp)
-		regmap_update_bits(lpc_snoop->regmap, HICRB, hicrb_en, hicrb_en);
+		regmap_set_bits(lpc_snoop->regmap, HICRB, cfg->hicrb_en);
 
 	channel->enabled = true;
 
 	return 0;
 
-err_misc_deregister:
-	misc_deregister(&channel->miscdev);
 err_free_fifo:
 	kfifo_free(&channel->fifo);
 	return rc;
@@ -263,30 +267,13 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 
 __attribute__((nonnull))
 static void aspeed_lpc_disable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
-				     enum aspeed_lpc_snoop_index index)
+				     struct aspeed_lpc_snoop_channel *channel)
 {
-	struct aspeed_lpc_snoop_channel *channel;
-
-	channel = &lpc_snoop->chan[index];
-
 	if (!channel->enabled)
 		return;
 
 	/* Disable interrupts along with the device */
-	switch (index) {
-	case 0:
-		regmap_update_bits(lpc_snoop->regmap, HICR5,
-				   HICR5_EN_SNP0W | HICR5_ENINT_SNP0W,
-				   0);
-		break;
-	case 1:
-		regmap_update_bits(lpc_snoop->regmap, HICR5,
-				   HICR5_EN_SNP1W | HICR5_ENINT_SNP1W,
-				   0);
-		break;
-	default:
-		return;
-	}
+	regmap_clear_bits(lpc_snoop->regmap, HICR5, channel->cfg->hicr5_en);
 
 	channel->enabled = false;
 	/* Consider improving safety wrt concurrent reader(s) */
@@ -299,8 +286,8 @@ static void aspeed_lpc_snoop_remove(struct platform_device *pdev)
 	struct aspeed_lpc_snoop *lpc_snoop = dev_get_drvdata(&pdev->dev);
 
 	/* Disable both snoop channels */
-	aspeed_lpc_disable_snoop(lpc_snoop, ASPEED_LPC_SNOOP_INDEX_0);
-	aspeed_lpc_disable_snoop(lpc_snoop, ASPEED_LPC_SNOOP_INDEX_1);
+	aspeed_lpc_disable_snoop(lpc_snoop, &lpc_snoop->chan[0]);
+	aspeed_lpc_disable_snoop(lpc_snoop, &lpc_snoop->chan[1]);
 }
 
 static int aspeed_lpc_snoop_probe(struct platform_device *pdev)
@@ -339,6 +326,8 @@ static int aspeed_lpc_snoop_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
+	static_assert(ARRAY_SIZE(channel_cfgs) == ARRAY_SIZE(lpc_snoop->chan),
+		"Broken implementation assumption regarding cfg count");
 	for (idx = ASPEED_LPC_SNOOP_INDEX_0; idx <= ASPEED_LPC_SNOOP_INDEX_MAX; idx++) {
 		u32 port;
 
@@ -346,7 +335,8 @@ static int aspeed_lpc_snoop_probe(struct platform_device *pdev)
 		if (rc)
 			break;
 
-		rc = aspeed_lpc_enable_snoop(lpc_snoop, dev, idx, port);
+		rc = aspeed_lpc_enable_snoop(dev, lpc_snoop, &lpc_snoop->chan[idx],
+					     &channel_cfgs[idx], port);
 		if (rc)
 			goto cleanup_channels;
 	}

-- 
2.39.5



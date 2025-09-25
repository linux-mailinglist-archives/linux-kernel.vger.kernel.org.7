Return-Path: <linux-kernel+bounces-832066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E79B9E435
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25F72188AF1A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDF32DE71A;
	Thu, 25 Sep 2025 09:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="RhNe0mLo"
Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F862D9EED;
	Thu, 25 Sep 2025 09:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.12.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758791912; cv=none; b=gH59qz/ur1yKDrQBmKe5PvH8OerxU4+HJAl6RwWEgm9amwi32SGFOblAhXqUUI4APDgPWJr1L1KWrLFNm4CpAcammX+lvWXzx5/mTtB408WVK9cSWboSxW8VuNxAME0T0F8dQEYWThivLGJBhALY4uzBWH6WTk/Lf6dZayWJLDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758791912; c=relaxed/simple;
	bh=E9tBL9cNyTn/Puyofjq4e6podEn/2MZeQRtQ0MnYnuM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gh/ldWThURxjnOnljOx7LINmW4z45VSWFkZi0inE71cwo7BDxDyZ4ZtuvDWugiBY/qJkoGio8aco33WCwogR4rsl+GXb7FU+5BRJsKwQ9h1av3/e9A1ozjXQPa971g65JvKzibw+zBDB3BenbekojQvNmfJYeIGlckYVMle8FGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=RhNe0mLo; arc=none smtp.client-ip=46.19.12.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=6oc+nJHRSVSsigrQV3wOMLqZzlnSbfWWdXErB5KFJk8=; b=RhNe0mLo5ws7kFwQuIvCFOuH3c
	s+5d3zG/9oPsm7eNSWw8sUapKjhTYkzjuFiUJIYnPUpGYbQwgsLr4WxY9d1hCVCb9I7Ye4PN7s6ck
	P30q/dQ3UXFd6yGNUFdK+zjF8T0AIJTMPqbu3C1EhXoMk0yMaBhtISDpzJu6V9s7SgIl0IjPFmpOK
	zQhvuVE3RaBTI2rDeXfmNddnU9DdRwFKtA2UppRbVits3a7B+FfDcDCAzmDFOrzLyNbJ93J9ZRDeS
	ftcioILCLNFdS88EgUYNcLHy5na3u6OrISod+L2bnLnjxjOBrWb1HVK2ZbiQKF5OB3ZJNDNPZPO2H
	gw9WM3tw==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:40922 helo=localhost.localdomain)
	by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1v1hp4-00000002j1L-2jSC;
	Thu, 25 Sep 2025 10:59:30 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH] ASoC: tlv320aic3x: Fix class-D initialization for tlv320aic3007
Date: Thu, 25 Sep 2025 10:59:29 +0200
Message-Id: <20250925085929.2581749-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp2.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cp2.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cp2.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

The problem of having class-D initialization sequence in probe using
regmap_register_patch() is that it will do hardware register writes
immediately after being called as it bypasses regcache. Afterwards, in
aic3x_init() we also perform codec soft reset, rendering class-D init
sequence pointless. This issue is even more apparent when using reset
GPIO line, since in that case class-D amplifier initialization fails
with "Failed to init class D: -5" message as codec is already held in
reset state after requesting the reset GPIO and hence hardware I/O
fails with -EIO errno.

Thus move class-D amplifier initialization sequence from probe function
to aic3x_set_power() just before the usual regcache sync. Use bypassed
regmap_multi_reg_write_bypassed() function to make sure, class-D init
sequence is performed in proper order as described in the datasheet.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 sound/soc/codecs/tlv320aic3x.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index f1649df19738..eea8ca285f8e 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -121,6 +121,16 @@ static const struct reg_default aic3x_reg[] = {
 	{ 108, 0x00 }, { 109, 0x00 },
 };
 
+static const struct reg_sequence aic3007_class_d[] = {
+	/* Class-D speaker driver init; datasheet p. 46 */
+	{ AIC3X_PAGE_SELECT, 0x0D },
+	{ 0xD, 0x0D },
+	{ 0x8, 0x5C },
+	{ 0x8, 0x5D },
+	{ 0x8, 0x5C },
+	{ AIC3X_PAGE_SELECT, 0x00 },
+};
+
 static bool aic3x_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -1393,6 +1403,10 @@ static int aic3x_set_power(struct snd_soc_component *component, int power)
 			gpiod_set_value(aic3x->gpio_reset, 0);
 		}
 
+		if (aic3x->model == AIC3X_MODEL_3007)
+			regmap_multi_reg_write_bypassed(aic3x->regmap, aic3007_class_d,
+							ARRAY_SIZE(aic3007_class_d));
+
 		/* Sync reg_cache with the hardware */
 		regcache_cache_only(aic3x->regmap, false);
 		regcache_sync(aic3x->regmap);
@@ -1723,17 +1737,6 @@ static void aic3x_configure_ocmv(struct device *dev, struct aic3x_priv *aic3x)
 	}
 }
 
-
-static const struct reg_sequence aic3007_class_d[] = {
-	/* Class-D speaker driver init; datasheet p. 46 */
-	{ AIC3X_PAGE_SELECT, 0x0D },
-	{ 0xD, 0x0D },
-	{ 0x8, 0x5C },
-	{ 0x8, 0x5D },
-	{ 0x8, 0x5C },
-	{ AIC3X_PAGE_SELECT, 0x00 },
-};
-
 int aic3x_probe(struct device *dev, struct regmap *regmap, kernel_ulong_t driver_data)
 {
 	struct aic3x_priv *aic3x;
@@ -1823,13 +1826,6 @@ int aic3x_probe(struct device *dev, struct regmap *regmap, kernel_ulong_t driver
 
 	aic3x_configure_ocmv(dev, aic3x);
 
-	if (aic3x->model == AIC3X_MODEL_3007) {
-		ret = regmap_register_patch(aic3x->regmap, aic3007_class_d,
-					    ARRAY_SIZE(aic3007_class_d));
-		if (ret != 0)
-			dev_err(dev, "Failed to init class D: %d\n", ret);
-	}
-
 	ret = devm_snd_soc_register_component(dev, &soc_component_dev_aic3x, &aic3x_dai, 1);
 	if (ret)
 		return ret;
-- 
2.34.1



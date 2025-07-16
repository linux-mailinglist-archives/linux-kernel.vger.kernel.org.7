Return-Path: <linux-kernel+bounces-732740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B40B06B9F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 04:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06B25620A6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 02:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2C4272E7B;
	Wed, 16 Jul 2025 02:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="0+f5JWDT"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B692D052
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 02:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752631940; cv=none; b=byf2eNYeUDt4nfv3+vPx9Mtd6kviu+pgCkOwMrJe2gxJ7+PxiuJf96+2cx0aFmaPv56HY7hi1fh/aVuJ0kyRTkIEeQA/uD3AiNdvHN9ebM7IAJmqpmoiIwZ6XOvp3SjKQioRhxE0Os5gM7IX0uSSuCDh2hBLRdRLmciEM8SI4mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752631940; c=relaxed/simple;
	bh=soqBDPchen//6oSZmDjETD4gCiLXBOQlzkUaAiEyP7U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hsi0OmBVHcMQJvYOkt+tLRSFoUt1yhbJtrZkJ1FvHWUv+i80HbKBA4XEvXJE55+zVydnsPEAh4LcUEfg8dun7I4f6nuMle4tluf816JLDxuloc6EftwR6IIR29YdiKuA0NFJrrWVHst8PdnJoLO0OHKJNF0E5kei7Dw5/QyGpIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=0+f5JWDT; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1752631929;
	bh=YtwilvAgBHagHoIGkBGKoSP7FUT6wxOwMRhf7pPVvgk=; l=1918;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=0+f5JWDTOwUTXQaYjbcYMOUwwwmfucMXp+gwWiiIZaO24uK5r+yp5ZIIAdA6eJBU7
	 wpSF4XGv2ig6ownXZKWGz0b8HAGj8xNtFWfLhyhAmKWpwJb8jTQQlOmDZOLGniAJJu
	 Ds33mRBqPBbmmK0hSV93w+Sg6fq72qFL/zFvGK5zfvX0EJtCyQTdgSHPJxGXLeItkl
	 TJENHWaTT8DATDEvkdg1m/RO9WZob46s3Tj7/75lOtpfsx7qtD8o8Yzh/AhAiICtOq
	 U3kMWIUXy/2K/11+T3rZgUPjLWOq8u1J5cYyK0XptQbplxLeYOeUxVDwf4x6jdG4Xj
	 ZIx5AfXAv2nXQ==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(244573:0:AUTH_RELAY)
	(envelope-from <jeff_chang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Wed, 16 Jul 2025 10:11:55 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 16 Jul
 2025 10:11:55 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Wed, 16 Jul 2025 10:11:55 +0800
From: <jeff_chang@richtek.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <jeff_chang@richtek.com>
Subject: [PATCH] regulator: rt6160: Add rt6166 vout min_uV setting for compatible
Date: Wed, 16 Jul 2025 10:08:30 +0800
Message-ID: <20250716021230.2660564-1-jeff_chang@richtek.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Jeff Chang <jeff_chang@richtek.com>

1. remove unintentional GPL change
2. using switch case for Device ID probe check.

Signed-off-by: Jeff Chang <jeff_chang@richtek.com>
---
 drivers/regulator/rt6160-regulator.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/rt6160-regulator.c b/drivers/regulator/rt6160-regulator.c
index e2a0eee95c61..548ffdf537d3 100644
--- a/drivers/regulator/rt6160-regulator.c
+++ b/drivers/regulator/rt6160-regulator.c
@@ -31,8 +31,11 @@
 #define RT6160_PGSTAT_MASK	BIT(0)
 
 #define RT6160_VENDOR_ID	0xA0
+#define RT6166_VENDOR_ID	0xB0
 #define RT6160_VOUT_MINUV	2025000
 #define RT6160_VOUT_MAXUV	5200000
+#define RT6166_VOUT_MINUV	1800000
+#define RT6166_VOUD_MAXUV	4950000
 #define RT6160_VOUT_STPUV	25000
 #define RT6160_N_VOUTS		((RT6160_VOUT_MAXUV - RT6160_VOUT_MINUV) / RT6160_VOUT_STPUV + 1)
 
@@ -43,6 +46,7 @@ struct rt6160_priv {
 	struct gpio_desc *enable_gpio;
 	struct regmap *regmap;
 	bool enable_state;
+	uint8_t devid;
 };
 
 static const unsigned int rt6160_ramp_tables[] = {
@@ -260,15 +264,26 @@ static int rt6160_probe(struct i2c_client *i2c)
 	if (ret)
 		return ret;
 
-	if ((devid & RT6160_VID_MASK) != RT6160_VENDOR_ID) {
+	devid = devid & RT6160_VID_MASK;
+
+	switch (devid) {
+	case RT6166_VENDOR_ID:
+	case RT6160_VENDOR_ID:
+		break;
+	default:
 		dev_err(&i2c->dev, "VID not correct [0x%02x]\n", devid);
 		return -ENODEV;
 	}
 
+	priv->devid = devid;
+
 	priv->desc.name = "rt6160-buckboost";
 	priv->desc.type = REGULATOR_VOLTAGE;
 	priv->desc.owner = THIS_MODULE;
-	priv->desc.min_uV = RT6160_VOUT_MINUV;
+	if (priv->devid == RT6166_VENDOR_ID)
+		priv->desc.min_uV = RT6166_VOUT_MINUV;
+	else
+		priv->desc.min_uV = RT6160_VOUT_MINUV;
 	priv->desc.uV_step = RT6160_VOUT_STPUV;
 	if (vsel_active_low)
 		priv->desc.vsel_reg = RT6160_REG_VSELL;
-- 
2.43.0



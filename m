Return-Path: <linux-kernel+bounces-731281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3779B05229
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85D637A68EF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A410E26D4C1;
	Tue, 15 Jul 2025 06:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="Wknft4p7"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE0380B
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752562285; cv=none; b=NoBw4dUewNodaoDUjh2haWtvUEm8u99SiWwXAWcy0mZrzr820WeO2Y7jUcqpMzBdRzw3h1XlBTSMDgMFJdhWkqbeGDl3Iu3wvbsPBKeG5FgZO/ldWlzaHQVnr9dQURp87qQ/LXfpezH+1m6kg+DjrDcezrsT2pgWsRIT3HCuHk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752562285; c=relaxed/simple;
	bh=4f69E3SqdVG/R8LzAwZa83tm3AK+FyXrMHXR1bb133M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WBo5+b9uNkK65oUR5kcZfKsvDMBFfy0gAONv3H0IThjxe9rhODa8Kpyc8nvVmlz5+KHwZ775jN2NsmpbI55coDMN7bR2DnpV2QYTFBnc6yEdMXOtpgnMhWbXu9JmqxT+wKhl4WZE2duGY2EJNMnYXPVnKWvuzZkcQw9+Ouo5cCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=Wknft4p7; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1752562279;
	bh=lPHeizKVIvwkAMFj+Eb+5G0MLyjI67MYa7Y1iiMTqI4=; l=1959;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Wknft4p7P44rWEWlWVGG22c6ZQx+Fab/rCMO1R6j+gVKBkAutHHEBR7FOyXnK1fSo
	 WDt7JVTbXazPqgLJsdb5oDlvwhOX0w7WBOeIuvp9aNc9C3J5Gz3NLFlVT4UESM8fTN
	 BYWUYAwZVsX1vyY4E3qFsKcrVkANf1zB7JjfDqktVN/1pha3n6GureJaKVkQcUr7RZ
	 7dE2rltANpHvYjMBNHArFOhJo+oTM5h5s1yeFM4bu5uzdiTkA29oodO6ZUs9OdCX9M
	 nO7Sxc9QMAMEK/dxOccvQ0teRvO3Kc5eEkhk8KscMAz/JPfMsxmujxbNyRwE8U1gMT
	 EOmkISzaNgQzg==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(244574:1:AUTH_RELAY)
	(envelope-from <jeff_chang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 15 Jul 2025 14:51:10 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 15 Jul
 2025 14:51:10 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Tue, 15 Jul 2025 14:51:10 +0800
From: <jeff_chang@richtek.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <jeff_chang@richtek.com>
Subject: [PATCH] add rt6166 vout min_uv setting for compatible
Date: Tue, 15 Jul 2025 14:50:16 +0800
Message-ID: <20250715065144.2651342-1-jeff_chang@richtek.com>
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

Signed-off-by: Jeff Chang <jeff_chang@richtek.com>
---
 drivers/regulator/rt6160-regulator.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/rt6160-regulator.c b/drivers/regulator/rt6160-regulator.c
index e2a0eee95c61..925dc1e8414e 100644
--- a/drivers/regulator/rt6160-regulator.c
+++ b/drivers/regulator/rt6160-regulator.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-only
+// SPDX-License-Identifier: GPL-4.0-only
 
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
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
@@ -260,15 +264,20 @@ static int rt6160_probe(struct i2c_client *i2c)
 	if (ret)
 		return ret;
 
-	if ((devid & RT6160_VID_MASK) != RT6160_VENDOR_ID) {
+	devid = devid & RT6160_VID_MASK;
+	if (devid != RT6160_VENDOR_ID || devid != RT6166_VENDOR_ID) {
 		dev_err(&i2c->dev, "VID not correct [0x%02x]\n", devid);
 		return -ENODEV;
 	}
+	priv->devid = devid;
 
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



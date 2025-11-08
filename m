Return-Path: <linux-kernel+bounces-891755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE6EC43675
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 00:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9460C34859D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 23:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735EC280339;
	Sat,  8 Nov 2025 23:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yjp9AbX/"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDD2F9D9
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 23:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762644577; cv=none; b=BA0AVL8VeiXMX7VO7SUivBnoZ36rrZ+9k11tSUcKq4w+MLHt4ecuUTGGjPCHLvm1hrnQkJDNkOCdcHnEnZAkzUiG/cYP++pcdrfPSsDU/BJ8gXf0LPBTOX3ATm1GlveZpg00Rv2V+0ydQc2vktcDI646StqR7ROqe8qgPY/1zcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762644577; c=relaxed/simple;
	bh=21mtCk5MLTqJk5Vk7WL++rUmBifOhOrSNXOsrCLLARI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j0A+/QNc7QJansFaMiL88U6oCL6NpvHvgLmdqfujHn+3+/jX8NU7jKs6ZO1w0lp5DYG/2TMbNa70Tea+GMfqK5Kf8wnxrblZwL+JJF1mRIsFyxZawmWrRDVaCumoDIMhX3odUK1tw9hQe7afWiCNg97CGu0o0mA09YVgYEgoowY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yjp9AbX/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2955623e6faso16684805ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 15:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762644576; x=1763249376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7AtxL+sdLqNDqRlc0q9YHgiZob1S+z096c2UzyI/8yI=;
        b=Yjp9AbX/cPvYSTXOI1/+CYMAmr/Zr3zBQtd7SrxW7Yk22B9FV2agz0ZmP3PbnLzP6k
         24C/ObC7bYmeENkIu1lV41/4SC+pHsybYw3s1zRcr9FaArz+eLapewRvIzAiZOZvNgAo
         canzXEs3a/thE3ZFjmWoF8A10uTcxqOWlIhUShpZMnbc5VN9bNf+hb5syMZ8Kh4TzcCk
         hPhpPRxB/7d9HT7BdSB72Vw/obUt/QwXaBFcejw3tLJrhyiVnY8U5bIqeAbM6wOnb8ni
         bJtYP4lOPD6EFPR+yyyL8LwYwsy0GBbLXhF8WhGuclMSHSUdLtKKr5IVVNPItwRZZepA
         SnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762644576; x=1763249376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7AtxL+sdLqNDqRlc0q9YHgiZob1S+z096c2UzyI/8yI=;
        b=nyKnkmpExEIfQO1J9Ecqch3aCHx120uJ01TCVlgN13Csg+RVA04rOrxZ3YCSHLmERg
         m91QkDEge07YDife06G+YVQriOhG+M6IyN79uwxRkhUgg9MveU3HhokYeYxMh3s7ZDiY
         Aqlc31zpBvX2dd+fu7KxQFBc6mhAwU+5nBe6UuqNk8OVeUWyZGoW06ut7+oe1Qwq4nKI
         yeRGot+bPHC8uJBFIE/z8lcQkmuPduqiuHaG0o0Q1GZlyx5pcVywbvwOKVDfyoaS/W+2
         CK2+MPWZPN1K9iPIAYGSaGY08ALpULkcP7Sa5IbAHNjaKGPeEtAadDVG+C5l2Hl+/ure
         C5Vw==
X-Forwarded-Encrypted: i=1; AJvYcCXQgrrvF/MtkNQsA2uLYVj44CIkN3dBGi5ra9vpjwRaTT4NlYaUhGd+Vefjw4QrCCCDMqM4npNMbbI0ZPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs2ZvGWIRCORQ4xofvJIwBdXvws5CCQM9PWI0vT9b8VrBj/sB8
	pbiPBkjq7BwxU+JNGW2v1vctwHaX0fRM0TIL4dI+ibHachDq9dvWLSdp
X-Gm-Gg: ASbGncugkcBpmb+1E2sHMfVU6UiyDsnzqbux6ocVUp8X+WmBeSTUB9cEZv2bv9M+tej
	48E4BgUXwBGWnbPD+vV4OX94ZSKgb2tT0FBYLnv2aSbHrSkY4MTImVkrrBXfXEGn9Lh6mfXTXTz
	BHjKQhxjL+7qJ/UINrHsTLZw8qDwItWwBEB6tabQzCHKZg12l92M4zluvm/ZR78ZUYJSf79L4eF
	o6XOdksAvDeSyly1p0C/27aj8wg5OCubq342pLiTbeLXgCqm7j+b0RAfynkaIq48WKnF2ytISbh
	ebqC60nGH3e2k2Zm579fKHkctNOU+XPVcyHXQ5YeTOGrJK2BXf74syz08ZTbMR3JZxXSXttdkmK
	+JVl8hbLdXTKf49dj/Hh6D4QJ4pKo5wEn7Cp76Fu94Lk1d1jiBaFyI4yPNbHxddZlXctNJ4wFqD
	kD
X-Google-Smtp-Source: AGHT+IEDcM2eeYZrQhyJQFVSP/ovcKlDegZbalJIsOjkkItxAwtRs5DfDKXi/gUt0yeOJaU1EzIfbQ==
X-Received: by 2002:a17:902:ea10:b0:264:70e9:dcb1 with SMTP id d9443c01a7336-297e56e13aemr43918735ad.56.1762644575506;
        Sat, 08 Nov 2025 15:29:35 -0800 (PST)
Received: from fedora ([172.59.161.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5ee4dsm99576265ad.45.2025.11.08.15.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 15:29:35 -0800 (PST)
From: Alex Tran <alex.t.tran@gmail.com>
To: Pavel Machek <pavel@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Tran <alex.t.tran@gmail.com>
Subject: [PATCH v1 1/2] media: i2c: et8ek8: et8ek8_driver: add support for crc configuration via device tree
Date: Sat,  8 Nov 2025 15:29:23 -0800
Message-ID: <20251108232923.2067131-1-alex.t.tran@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Retrieve the configuration for CRC from the device tree instead
using the hard coded USE_CRC directive. If there is an issue
retrieving the endpoint node or the CRC property then the default
of 1 is used and the driver does not fail to maintain backward
compatibility.

Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
---
 drivers/media/i2c/et8ek8/et8ek8_driver.c | 49 +++++++++++++++++++-----
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/media/i2c/et8ek8/et8ek8_driver.c b/drivers/media/i2c/et8ek8/et8ek8_driver.c
index 2cb7b7187..4ef92359c 100644
--- a/drivers/media/i2c/et8ek8/et8ek8_driver.c
+++ b/drivers/media/i2c/et8ek8/et8ek8_driver.c
@@ -29,6 +29,7 @@
 #include <media/media-entity.h>
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
+#include <media/v4l2-fwnode.h>
 #include <media/v4l2-subdev.h>
 
 #include "et8ek8_reg.h"
@@ -45,6 +46,7 @@ struct et8ek8_sensor {
 	struct regulator *vana;
 	struct clk *ext_clk;
 	u32 xclk_freq;
+	u32 use_crc;
 
 	u16 version;
 
@@ -130,8 +132,6 @@ static struct et8ek8_gain {
 
 #define ET8EK8_I2C_DELAY	3	/* msec delay b/w accesses */
 
-#define USE_CRC			1
-
 /*
  * Register access helpers
  *
@@ -844,20 +844,16 @@ static int et8ek8_power_on(struct et8ek8_sensor *sensor)
 	if (rval)
 		goto out;
 
-#ifdef USE_CRC
 	rval = et8ek8_i2c_read_reg(client, ET8EK8_REG_8BIT, 0x1263, &val);
 	if (rval)
 		goto out;
-#if USE_CRC /* TODO get crc setting from DT */
-	val |= BIT(4);
-#else
-	val &= ~BIT(4);
-#endif
+	if (sensor->use_crc)
+		val |= BIT(4);
+	else
+		val &= ~BIT(4);
 	rval = et8ek8_i2c_write_reg(client, ET8EK8_REG_8BIT, 0x1263, val);
 	if (rval)
 		goto out;
-#endif
-
 out:
 	if (rval)
 		et8ek8_power_off(sensor);
@@ -1396,6 +1392,34 @@ static int __maybe_unused et8ek8_resume(struct device *dev)
 	return __et8ek8_set_power(sensor, true);
 }
 
+static int et8ek8_parse_fwnode(struct device *dev, struct et8ek8_sensor *sensor)
+{
+	struct v4l2_fwnode_endpoint bus_cfg = {
+		.bus_type = V4L2_MBUS_CCP2,
+	};
+	struct fwnode_handle *ep;
+	int ret;
+
+	ep = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev), 0, 0,
+					     FWNODE_GRAPH_ENDPOINT_NEXT);
+	if (!ep) {
+		dev_warn(dev, "could not get endpoint node\n");
+		return -EINVAL;
+	}
+
+	ret = v4l2_fwnode_endpoint_alloc_parse(ep, &bus_cfg);
+	if (ret) {
+		dev_warn(dev, "parsing endpoint node failed\n");
+		goto done;
+	}
+
+	fwnode_property_read_u32(ep, "crc", &sensor->use_crc);
+done:
+	v4l2_fwnode_endpoint_free(&bus_cfg);
+	fwnode_handle_put(ep);
+	return ret;
+}
+
 static int et8ek8_probe(struct i2c_client *client)
 {
 	struct et8ek8_sensor *sensor;
@@ -1406,6 +1430,11 @@ static int et8ek8_probe(struct i2c_client *client)
 	if (!sensor)
 		return -ENOMEM;
 
+	sensor->use_crc = 1;
+	ret = et8ek8_parse_fwnode(dev, sensor);
+	if (ret)
+		dev_warn(dev, "parsing endpoint failed\n");
+
 	sensor->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(sensor->reset)) {
 		dev_dbg(&client->dev, "could not request reset gpio\n");
-- 
2.51.0



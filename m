Return-Path: <linux-kernel+bounces-871012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2523C0C3B4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2AC3AC3C5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2732E7186;
	Mon, 27 Oct 2025 08:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghTLGUlc"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E102E7BCB
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761552392; cv=none; b=PuxwOUME1Rv+Aqnvyz+JI3rizM1ajBMCQs/mKZlF96s1K2rMWk96hF0ZUB4bsF2lcxbOdiB/CC4VKmuGa4nVrusQ1ZopuZklVXUDrZLvs3abq+VVey47mQz3sFOuWsxjJur8Yg5Wip5tdhovcx3II+n9uPo9b8vBYWfTZ/hWFeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761552392; c=relaxed/simple;
	bh=eJr8JxZpepkO+MxnlRNP4S+wzfkUycx9FXy9G5ycSU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cCHzphU1nkGadjoQ9pVoGgIqQSxCf89cxU69nwA9bxG2FDk+3onP+e24i6ZX34TvtPL3MwPcvMNG9zLUl6LHbaAsYiBhiokDwKGjos6GCLrcykgh2DaOw23oQsTdRzL5qDF5Y/MH21oJiqXRIhJm4bLmfFYpKdw1u8rmxXSgapM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghTLGUlc; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59093250aabso4909185e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761552388; x=1762157188; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8az67etDCe+j6oAMVPHkMbmqmZXuNQBkA4UoBLW7ZLM=;
        b=ghTLGUlcB4jr0qatFL3+fuA0rFslrgZu3IJiNJSnhVHp6VezSaG+Cx944D4ScJ6/v+
         JmUMYTrx5D0lyjQB5AJbZNy8tXa3ffjA5XUpWwTIHIP+Ug9O6bwyzDJF6oa1ANCHB6v0
         7Xrvbj0FBNKdLUX6LfEsUuIneon6NzcULAmLCggZl5T8uV60WxtVQ8hJnV07HRxbBChg
         b9pixbOk0KnOKb7MrKTt7sykBGuV2VVFyIm87eAfq65pUGl9FtiwG0OizUsJexYjTBQV
         r99MaGIQHcAtIUV2AmVWAJ1YaMXXD3IbLob/cFvnJS/cnp1SCNhqUFRbssISpYmwvi5+
         bqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761552388; x=1762157188;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8az67etDCe+j6oAMVPHkMbmqmZXuNQBkA4UoBLW7ZLM=;
        b=MoQra5rBNAGUigDGho9zmugwJJt7HukRMlk0mu3+duuNLdKZDgxd1lWgEGMBHol6Wn
         EER/aQBZh/YNlfyaiPH8JPMs0GAlOeWAFdhOh1O8sLZvSth514/Z1H+JRyagUGIiaOiy
         ZiaNvVqHfR1sSl3pIQ8QX4suCcWOjzkj1S/wpdPQCUypHvUSMd9QluVD5NhD2fJzGc8o
         /E2DopGmoZ2nCTQuMQXSx8Ou0yLaXqRTUcPBAJuSimJOZVZ3acyE32PDhIM7rldbf8c2
         ewzEf2cCKlIt3JLRghdyxitteeKt+Ur7D8/59aipvtm55MLcguOJwJB0eCUUnWK6M2da
         nCjw==
X-Forwarded-Encrypted: i=1; AJvYcCUUvrME1Io2JRmiqYe5YS8+A9SKRRDel8hrZ0AZVW83ybNpDPa/fmFB68ry96rXkhJY43RsGoYr+gOuep8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWHfHhJa/qpJpL+QKi8IzcAh10Gn/iJfOIU7d0Lyt/P7V/dn4r
	9lqLaWBfYbOfV6/pe+uyYAszpylJ0IRDJdhb+DsMJmpv640whyiWr57K
X-Gm-Gg: ASbGncv6rAtkPButYIjbBVtJjJho3UZ979kgL00uqarGE/05HlxTjkgmxr/YHc/3a5h
	j4hqQdFYcdfqotrhpzgjaGeAczGKMQSINbIJZ9oh/ZXfPkmuQQqzl58CQ4x3Ma1yQy72aGV2t5a
	TdE2eBPPT3kaNC5KdD2P6d24+/y56C7IjBPQlzzZUC/JCkqjzovmWfVMzvcbjEN4YDaeEGTkuY8
	GPdahA8mCvzbeotcOiQ0ip4wBsXKRhq6YFBvD4GTitifyln27gmk/Q8vWeH2J7xZj583KtfMBRv
	KIwJLk9+KcG8RW8IH8KTsjAxdNVlMsvDBrTSBvr9rdQ9Ymuc1V+JuL8A2FBljOAYQabj268K0hT
	3t8KL07AISJEwxEuqc/YSh7Wx0rjIXuGBgitQ5vpJ9NQkZcA77FMCF7zAg4l7uJB1SWbbiR6QYH
	XcMMn44VGIrI30mD3WDMbKQ3QosyP4y4PlL5nvW11vdeg/
X-Google-Smtp-Source: AGHT+IFgGhZYl4/P0JPmEkwn6YhC0umUq0AKzrPz060axcPlibV51BIDoxu5l5KxvyefyI5wAhN+9w==
X-Received: by 2002:a05:6512:10cd:b0:592:faf7:2a0 with SMTP id 2adb3069b0e04-592faf702dbmr2992667e87.33.1761552388214;
        Mon, 27 Oct 2025 01:06:28 -0700 (PDT)
Received: from [192.168.1.168] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f41ce8sm2210689e87.6.2025.10.27.01.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 01:06:27 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 27 Oct 2025 09:05:44 +0100
Subject: [PATCH v2 4/6] drm/sitronix/st7571-i2c: make probe independent of
 hw interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251027-st7571-split-v2-4-8352fb278d21@gmail.com>
References: <20251027-st7571-split-v2-0-8352fb278d21@gmail.com>
In-Reply-To: <20251027-st7571-split-v2-0-8352fb278d21@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10580;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=eJr8JxZpepkO+MxnlRNP4S+wzfkUycx9FXy9G5ycSU8=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBo/yft9zKK8HA5Rvu6vWCYQInVcMNBZmq5jjOKn
 M7tGpWI4ZKJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaP8n7QAKCRCIgE5vWV1S
 MtaFD/4uP/eOzYkCfSPP273o7sXPRboi6yrUg4eUByBwLb4RUCTvRJNigy//zaOMtd30dzjt53Z
 uyQZQ3JoUlFZMBDMpv0IfeDjv3hxdEOWYkkG9Ru9mF5tN/JzG9bK8RGPVBJtQT9a57bzuw4bdH/
 BF3zuTeb7SJeBuEFlYIOjy5z6J2lVzsw3QyEw2FPIP9/T0BS/aXkEDFO5CiUHMRijaDraxqOZb4
 au7blhuqius/S+9JGZZM4ooEp8RNqurx+5p2gVu+7DVw2veaHz1B+xzs3ARwCPDGhtf4o0PCVpA
 wiPSDohIqKW3q/bO/77ppswnJwWYDR73Z2+hshHkUXptnskrWv+kbNFlpKUBXkVC/PhAWr+1zUl
 bXxvaCugXaF9nNL+yZY68GxeITw2X0w0av2d/vWuFwIl62RopH+H18ejjkeTUXEH+GJmO3rixzz
 cmJEoxJyM/+nOuCuE6kBroXFW8vMJ6DnCwwCNYzz1BajZS99gttACCQ9ALN+ZduV0q7gpNdu9Zf
 PV31aCVnrxddH1c43r4HdnFg5aoBYlTCnELMESj62pAqNsVd5xnbKOyS0GZzitq9P6byvOlrTu+
 /oXTV+ym1Dm2RO2Bl1fImfLn6pupo7J05tEyzaeLgY00upDgbz3KwFwALlHwaEcJ7HkYSPtROa+
 B9rQMBOjnJOjiNg==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Create a interface independent layer for the probe function. This to
make it possible to add support for other interfaces.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/gpu/drm/sitronix/st7571-i2c.c | 165 +++++++++++++++++++++++-----------
 drivers/gpu/drm/sitronix/st7571.h     |  25 +-----
 2 files changed, 113 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/sitronix/st7571-i2c.c b/drivers/gpu/drm/sitronix/st7571-i2c.c
index af27658a5e152534d445bc623893eee6b3ca00d5..f994ace407390dba30c0968ca99f437382badfab 100644
--- a/drivers/gpu/drm/sitronix/st7571-i2c.c
+++ b/drivers/gpu/drm/sitronix/st7571-i2c.c
@@ -80,6 +80,33 @@
 #define DRIVER_MAJOR 1
 #define DRIVER_MINOR 0
 
+struct st7571_i2c_transport {
+	struct i2c_client *client;
+
+	/*
+	 * Depending on the hardware design, the acknowledge signal may be hard to
+	 * recognize as a valid logic "0" level.
+	 * Therefor, ignore NAK if possible to stay compatible with most hardware designs
+	 * and off-the-shelf panels out there.
+	 *
+	 * From section 6.4 MICROPOCESSOR INTERFACE section in the datasheet:
+	 *
+	 * "By connecting SDA_OUT to SDA_IN externally, the SDA line becomes fully
+	 * I2C interface compatible.
+	 * Separating acknowledge-output from serial data
+	 * input is advantageous for chip-on-glass (COG) applications. In COG
+	 * applications, the ITO resistance and the pull-up resistor will form a
+	 * voltage  divider, which affects acknowledge-signal level. Larger ITO
+	 * resistance will raise the acknowledged-signal level and system cannot
+	 * recognize this level as a valid logic “0” level. By separating SDA_IN from
+	 * SDA_OUT, the IC can be used in a mode that ignores the acknowledge-bit.
+	 * For applications which check acknowledge-bit, it is necessary to minimize
+	 * the ITO resistance of the SDA_OUT trace to guarantee a valid low level."
+	 *
+	 */
+	bool ignore_nak;
+};
+
 static inline struct st7571_device *drm_to_st7571(struct drm_device *drm)
 {
 	return container_of(drm, struct st7571_device, drm);
@@ -87,18 +114,17 @@ static inline struct st7571_device *drm_to_st7571(struct drm_device *drm)
 
 static int st7571_regmap_write(void *context, const void *data, size_t count)
 {
-	struct i2c_client *client = context;
-	struct st7571_device *st7571 = i2c_get_clientdata(client);
+	struct st7571_i2c_transport *t = context;
 	int ret;
 
 	struct i2c_msg msg = {
-		.addr = st7571->client->addr,
-		.flags = st7571->ignore_nak ? I2C_M_IGNORE_NAK : 0,
+		.addr = t->client->addr,
+		.flags = t->ignore_nak ? I2C_M_IGNORE_NAK : 0,
 		.len = count,
 		.buf = (u8 *)data
 	};
 
-	ret = i2c_transfer(st7571->client->adapter, &msg, 1);
+	ret = i2c_transfer(t->client->adapter, &msg, 1);
 
 	/*
 	 * Unfortunately, there is no way to check if the transfer failed because of
@@ -106,7 +132,7 @@ static int st7571_regmap_write(void *context, const void *data, size_t count)
 	 *
 	 * However, if the transfer fails and ignore_nak is set, we know it is an error.
 	 */
-	if (ret < 0 && st7571->ignore_nak)
+	if (ret < 0 && t->ignore_nak)
 		return ret;
 
 	return 0;
@@ -845,102 +871,135 @@ static int st7571_lcd_init(struct st7571_device *st7571)
 	return st7571_send_command_list(st7571, commands, ARRAY_SIZE(commands));
 }
 
-static int st7571_probe(struct i2c_client *client)
+static struct st7571_device *st7571_probe(struct device *dev,
+					  struct regmap *regmap)
 {
 	struct st7571_device *st7571;
 	struct drm_device *drm;
 	int ret;
 
-	st7571 = devm_drm_dev_alloc(&client->dev, &st7571_driver,
+	st7571 = devm_drm_dev_alloc(dev, &st7571_driver,
 				    struct st7571_device, drm);
 	if (IS_ERR(st7571))
-		return PTR_ERR(st7571);
+		return st7571;
 
 	drm = &st7571->drm;
-	st7571->dev = &client->dev;
-	st7571->client = client;
-	i2c_set_clientdata(client, st7571);
+	st7571->dev = dev;
 	st7571->pdata = device_get_match_data(st7571->dev);
 
 	ret = st7571->pdata->parse_dt(st7571);
 	if (ret)
-		return ret;
+		return ERR_PTR(ret);
 
 	ret = st7571_validate_parameters(st7571);
 	if (ret)
-		return ret;
+		return ERR_PTR(ret);
 
 	st7571->mode = st7571_mode(st7571);
+	st7571->regmap = regmap;
 
-	/*
-	 * The hardware design could make it hard to detect a NAK on the I2C bus.
-	 * If the adapter does not support protocol mangling do
-	 * not set the I2C_M_IGNORE_NAK flag at the expense * of possible
-	 * cruft in the logs.
-	 */
-	if (i2c_check_functionality(client->adapter, I2C_FUNC_PROTOCOL_MANGLING))
-		st7571->ignore_nak = true;
-
-	st7571->regmap = devm_regmap_init(st7571->dev, &st7571_regmap_bus,
-					  client, &st7571_regmap_config);
-	if (IS_ERR(st7571->regmap)) {
-		return dev_err_probe(st7571->dev, PTR_ERR(st7571->regmap),
-				     "Failed to initialize regmap\n");
-	}
 
 	st7571->hwbuf = devm_kzalloc(st7571->dev,
 				     (st7571->nlines * st7571->ncols * st7571->bpp) / 8,
 				     GFP_KERNEL);
 	if (!st7571->hwbuf)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	st7571->row = devm_kzalloc(st7571->dev,
 				   (st7571->ncols * st7571->bpp),
 				   GFP_KERNEL);
 	if (!st7571->row)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	ret = st7571_mode_config_init(st7571);
-	if (ret)
-		return dev_err_probe(st7571->dev, ret,
-				     "Failed to initialize mode config\n");
+	if (ret) {
+		dev_err(st7571->dev, "Failed to initialize mode config\n");
+		return ERR_PTR(ret);
+	}
 
 	ret = st7571_plane_init(st7571, st7571->pformat);
-	if (ret)
-		return dev_err_probe(st7571->dev, ret,
-				     "Failed to initialize primary plane\n");
+	if (ret) {
+		dev_err(st7571->dev, "Failed to initialize primary plane\n");
+		return ERR_PTR(ret);
+	}
 
 	ret = st7571_crtc_init(st7571);
-	if (ret < 0)
-		return dev_err_probe(st7571->dev, ret,
-				     "Failed to initialize CRTC\n");
+	if (ret < 0) {
+		dev_err(st7571->dev, "Failed to initialize CRTC\n");
+		return ERR_PTR(ret);
+	}
 
 	ret = st7571_encoder_init(st7571);
-	if (ret < 0)
-		return dev_err_probe(st7571->dev, ret,
-				     "Failed to initialize encoder\n");
+	if (ret < 0) {
+		dev_err(st7571->dev, "Failed to initialize encoder\n");
+		return ERR_PTR(ret);
+	}
 
 	ret = st7571_connector_init(st7571);
-	if (ret < 0)
-		return dev_err_probe(st7571->dev, ret,
-				     "Failed to initialize connector\n");
+	if (ret < 0) {
+		dev_err(st7571->dev, "Failed to initialize connector\n");
+		return ERR_PTR(ret);
+	}
 
 	drm_mode_config_reset(drm);
 
 	ret = drm_dev_register(drm, 0);
-	if (ret)
-		return dev_err_probe(st7571->dev, ret,
-				     "Failed to register DRM device\n");
+	if (ret) {
+		dev_err(st7571->dev, "Failed to register DRM device\n");
+		return ERR_PTR(ret);
+	}
 
 	drm_client_setup(drm, NULL);
+	return st7571;
+}
+
+static void st7571_remove(struct st7571_device *st7571)
+{
+	drm_dev_unplug(&st7571->drm);
+}
+
+static int st7571_i2c_probe(struct i2c_client *client)
+{
+	struct st7571_device *st7571;
+	struct st7571_i2c_transport *t;
+	struct regmap *regmap;
+
+	t = devm_kzalloc(&client->dev, sizeof(*t), GFP_KERNEL);
+	if (!t)
+		return -ENOMEM;
+
+	t->client = client;
+
+	/*
+	 * The hardware design could make it hard to detect a NAK on the I2C bus.
+	 * If the adapter does not support protocol mangling do
+	 * not set the I2C_M_IGNORE_NAK flag at the expense * of possible
+	 * cruft in the logs.
+	 */
+	if (i2c_check_functionality(client->adapter, I2C_FUNC_PROTOCOL_MANGLING))
+		t->ignore_nak = true;
+
+	regmap = devm_regmap_init(&client->dev, &st7571_regmap_bus,
+				  t, &st7571_regmap_config);
+	if (IS_ERR(regmap)) {
+		return dev_err_probe(&client->dev, PTR_ERR(regmap),
+				     "Failed to initialize regmap\n");
+	}
+
+	st7571 = st7571_probe(&client->dev, regmap);
+	if (IS_ERR(st7571))
+		return dev_err_probe(&client->dev, PTR_ERR(st7571),
+				     "Failed to initialize regmap\n");
+
+	i2c_set_clientdata(client, st7571);
 	return 0;
 }
 
-static void st7571_remove(struct i2c_client *client)
+static void st7571_i2c_remove(struct i2c_client *client)
 {
 	struct st7571_device *st7571 = i2c_get_clientdata(client);
 
-	drm_dev_unplug(&st7571->drm);
+	st7571_remove(st7571);
 }
 
 static const struct st7571_panel_data st7567_config = {
@@ -986,8 +1045,8 @@ static struct i2c_driver st7571_i2c_driver = {
 		.name = "st7571",
 		.of_match_table = st7571_of_match,
 	},
-	.probe = st7571_probe,
-	.remove = st7571_remove,
+	.probe = st7571_i2c_probe,
+	.remove = st7571_i2c_remove,
 	.id_table = st7571_id,
 };
 
diff --git a/drivers/gpu/drm/sitronix/st7571.h b/drivers/gpu/drm/sitronix/st7571.h
index c6fd6f1d3aa33d6b43330ce8f2cb2d3f2321b29b..f62c57ddb99ebe82f63048cc2ccf75a81518d717 100644
--- a/drivers/gpu/drm/sitronix/st7571.h
+++ b/drivers/gpu/drm/sitronix/st7571.h
@@ -13,6 +13,7 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_encoder.h>
+#include <drm/drm_format_helper.h>
 
 #include <linux/regmap.h>
 
@@ -62,33 +63,9 @@ struct st7571_device {
 
 	const struct st7571_panel_format *pformat;
 	const struct st7571_panel_data *pdata;
-	struct i2c_client *client;
 	struct gpio_desc *reset;
 	struct regmap *regmap;
 
-	/*
-	 * Depending on the hardware design, the acknowledge signal may be hard to
-	 * recognize as a valid logic "0" level.
-	 * Therefor, ignore NAK if possible to stay compatible with most hardware designs
-	 * and off-the-shelf panels out there.
-	 *
-	 * From section 6.4 MICROPOCESSOR INTERFACE section in the datasheet:
-	 *
-	 * "By connecting SDA_OUT to SDA_IN externally, the SDA line becomes fully
-	 * I2C interface compatible.
-	 * Separating acknowledge-output from serial data
-	 * input is advantageous for chip-on-glass (COG) applications. In COG
-	 * applications, the ITO resistance and the pull-up resistor will form a
-	 * voltage  divider, which affects acknowledge-signal level. Larger ITO
-	 * resistance will raise the acknowledged-signal level and system cannot
-	 * recognize this level as a valid logic “0” level. By separating SDA_IN from
-	 * SDA_OUT, the IC can be used in a mode that ignores the acknowledge-bit.
-	 * For applications which check acknowledge-bit, it is necessary to minimize
-	 * the ITO resistance of the SDA_OUT trace to guarantee a valid low level."
-	 *
-	 */
-	bool ignore_nak;
-
 	bool grayscale;
 	bool inverted;
 	u32 height_mm;

-- 
2.50.1



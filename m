Return-Path: <linux-kernel+bounces-868704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC39FC05E8D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 711CA3AD834
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC1E359718;
	Fri, 24 Oct 2025 10:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpWwIWWr"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38D23590AD
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303461; cv=none; b=ICVP1oergcNn5fmiVgSbgAHZcimIV596ehM6rzOLgkuoaXFvL1gMnLd1nCKylsEpWLPNZhZ4spCf8Vm1lWA4KafKKqGxLn3OI34S3W5g3p4KYzUivrwz9v2qBcJ1+09r30Rvn9UAqWmcKZyBY58zz+/rkRftBP6/JEcetdcp19k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303461; c=relaxed/simple;
	bh=eJr8JxZpepkO+MxnlRNP4S+wzfkUycx9FXy9G5ycSU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X7IHjBzdLjWk0gIvb35D8zsWGCZ+B8jkgyNgwjvO5f5YQhpCg2KVGMOLGSiikCSf4UH41Y+uf7EWm4BGtXIktlaxIsg8I7s66cr2vX+HIQ0hH0wvsnh2+vwZbOWYWqLQLhKENm+qvf4WJYE/iDuzfmTXmm02EAMUzjWTeZXDJ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpWwIWWr; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-378ccb8f84aso20977271fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761303457; x=1761908257; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8az67etDCe+j6oAMVPHkMbmqmZXuNQBkA4UoBLW7ZLM=;
        b=VpWwIWWr1znldLVVp+Su39DjLAzlHy/AFYNXkxJfI9MW3RF9f0L791ionZpRbF/GIu
         8SmuLa7EBP1u0rAjch1uubXcDwkaVDTrYAU3i6VWAU+Ewk+V3O/hogZiBqHNA0PmairD
         vADQnMDI7T2XlVWrRAky23jctq75McfrzdVxvbYetapnWiHJjHGit6H8q7NUJjcS20DI
         sV5pYN3pU8WKTzxQ+NMH2Um/rv/g2kb5LY/tOSJQDPv2eHUQ4MG6siA9ntBE8rMzE0PS
         Q+u3pQ/Cp09Gdu43YeXfDxkOworrgizKTBBOcbuUcDvDLCRdvXdxxVEaVUAT463dnhPR
         a1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761303457; x=1761908257;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8az67etDCe+j6oAMVPHkMbmqmZXuNQBkA4UoBLW7ZLM=;
        b=RhD5cEGhcHkjWbo/F6EemWDDdzKW+2b4IRX7eYAdWx5Bi3jL7/ooIETxXAN7Wjj2Ni
         eqkawPBr1bKsqGJyWOTMUEv4yNrSqflhoKIY1PfePZFTKHKASAexVRTfXgm35dzA0msu
         PW/whr3JKmQtdCyszkkZlHHUBnTgsm4AuEcQWSa3YuZ8DwRCSBhkq6ZIRSaA8j544S7P
         8VFf5A1Q94mUPfcwiuJxu27+vWWoBdXmQ9EUsGcNaxw6WmBYr1l4gWjw2WtMQN7nIK8h
         yOL9ri/LKOy6UeerE0UehWZ0YX4OAf3j3FvIlaJ/Ny49H1lhQ8mI99cpL3nVf5g1hVXy
         gXrA==
X-Forwarded-Encrypted: i=1; AJvYcCUCrJJDV9m1c1VEKKupYdLFnxIIqMv6y050dv0Vn6dqjBep14ZAk5Oe0JiNDA2HxWO8LTEE1sF8oPTcuto=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6OdC4pvu0xQjff7MDu+xH4RccPX5/njEa9cJs5CBHebfIOMp+
	4W4VujcvZInhZq8MWqUqsSCdNfecGRneGnTfZQOhNwnwhntk9dtJvQ7s
X-Gm-Gg: ASbGncthgtEd/9+cdRA/toZMxCxnJrzooxpStkvo6YmxaPagx42l/hnh+/mTeaDGw/t
	j2wY3/M4VsQgSYo0AQ83a3r7MKR433WfNWXJ8MSdUjh0yPqnhPBVCF2rTEaqMKv8t9GTnjApBP9
	zgWljwlmBm9+k03RTwJ5lZO8CI4mjaSs/0nbYSeJeZQQ6UtYM9LuFma8YZI/vS1djJKRM96RWgX
	rNHehykAp5aDZvHttzVZ4RJmpjWx7c7qiIx0mvW2EmgLW3l/ROUa+SWwcLw9uk8PP2wxRA1jQwI
	3VMGvVeIcpAnVAa3KBklP/I2vc3dHU2lbl1bFfXcJNnsTXsgV+KxFvhpqCWC1rDOQdoHD1qpuhm
	27OYo1OYnl7xwIMKvPWIzUOqC20QzYL2gdK9JmOBzWIHO/j/Fsdy+ieel+b/FIxK+nsJon4i5Hv
	u9GSzlIN4NKtwhyuPFukgiaiTHf3ynYGMIpAwFEywSG/nC
X-Google-Smtp-Source: AGHT+IGru+Te4h4kp0Ikb5HzGXxe6fqhFW5DFP6rZ3OZLBwXPCS5W5JNZqRtRjWzvI1A4YyOre4G0A==
X-Received: by 2002:a2e:bd03:0:b0:333:e590:1bc9 with SMTP id 38308e7fff4ca-37797a0e735mr86014341fa.24.1761303456685;
        Fri, 24 Oct 2025 03:57:36 -0700 (PDT)
Received: from [192.168.1.168] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378d67db8fesm10375671fa.38.2025.10.24.03.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 03:57:35 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Fri, 24 Oct 2025 12:56:55 +0200
Subject: [PATCH 4/6] drm/sitronix/st7571-i2c: make probe independent of hw
 interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251024-st7571-split-v1-4-d3092b98130f@gmail.com>
References: <20251024-st7571-split-v1-0-d3092b98130f@gmail.com>
In-Reply-To: <20251024-st7571-split-v1-0-d3092b98130f@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10580;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=eJr8JxZpepkO+MxnlRNP4S+wzfkUycx9FXy9G5ycSU8=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBo+1uLZmh7mmLNGz9Op33SfOmz9AZiKMSeW9uqT
 j7GKhza9vqJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaPtbiwAKCRCIgE5vWV1S
 MpXSD/9Hm7BC6/5Pk0sOK8bQtAd11cE4Ovwvs/A9+sHV8X6h8ty6HOy16cHAgvdX4f24O7IHYAw
 MGENAkHKftncNdLRdQPRkShRGLCL4b4qGef7lQVUOk7ogKTCH3He4tGQbhLkMT4/zACMcV0e4VH
 pXUC/wK6BOjs5srzqjJvethlB1KJiPoWCZB41fIIrt2YdOnjmAzAmfTLsV5GiEydvsFmwg/p0OY
 hXabX7FljcNxZRTc9izggpPXGaaIkztlzgm1wrTE4ZImfyxP3+DSlZDs0kY9oWb7s6QowvGrUk1
 w3P/NA7bmbuiGPgUMG6Pp58q5gqNcXDnsHX2sIudNQpETQm/D7mull1LoMY41ZyuEAqywjylWbe
 XK+UKyPMgLOwvJ2wM1GGGEf8kBHXRRks9KOkayNNFFCbgsZPEU/zNPjCNUJfyqPC1BFmShj163t
 bwP5EVWwKxJEmeUclQT/XuGf9GeobohN+cmidsPXUKLscfu/tCyS811mGas5TT+wg0RSiWKrZ2k
 6C3jHTsMl+VydCZKIAooce3DvCT34m+8Vw66ZVhqjk/uIGqxzi/ikekApOQqvfQKfQ0WSC0yWHQ
 c9SFhW2TdytlcgbwjDvSB6iIAwYIxbHcvUnbGtzT4zjxEu9oQa4RfhI7mVlgv6LVBxq7vrYOAG4
 eqSpGTEaxkHkDhw==
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



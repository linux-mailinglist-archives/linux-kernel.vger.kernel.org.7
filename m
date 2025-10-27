Return-Path: <linux-kernel+bounces-871010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AF5C0C3C3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4EF554F0D1F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FF52E6CCE;
	Mon, 27 Oct 2025 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/wnaa1U"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCA32E7193
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761552389; cv=none; b=LMwekal6WL7lNZzovItmUnGV2gv5eex2BM6bSX0OFJ2GsaJTIT37aW9u3uw6o60ap9otaQkijeFdFPM7Kb9J2ULNs0lWPtJ00VpPtNfhvnYvJu7j4C1K5Z4N4fML0UEAA8IrFkyGCp4BxqcfIMg7cXZLIJfdjW3MooHJURnyaKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761552389; c=relaxed/simple;
	bh=LfOcWsXvHf24Rmlqiz3/HxiBo5dw0vDuG1TwXuVbpUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p0do5ZvX9Sm52j2/aa1puXh+0EbJ2GkvfDlv0deWPjeu/8w0QFGJPHJqX3M5FWCpe9xvJLBd+/zOsNpsgdZgbEjISgsm86OsF9NkX/I1zDsvsMKJg5XcZwJlZmUQkbqmHBjgiBuliB5NGDPFKxA2mKSDNUZb/QgzOcN7kZAk/D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/wnaa1U; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-592f5fe03dcso4935838e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761552386; x=1762157186; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cLWjaKLx+X0gG/JQr9xbszcB6rfPVQrK0WJygsJNUrg=;
        b=E/wnaa1UsKj4XiXbUlhiHZJQKJzhgWxd6ZD/tgNihMvsvfWMFnuu7K3kp4kE6CdyMT
         JmN1hap3ZAUZ2NEzOd9110wqpk2orFFr8ed2LQc4/Py5f79ca3bt/vMLB4qv60I7+xNH
         MTcyWXtZmRcCs4i9jFZ6xixmrW/EoO11oeye/cmUObla6HPhtANaGz27/rD06aq4HgPz
         PR84g+ySULyoRKC6hUI+7/H5lsxcfFRJizPZn7+RJQuWCFY5I4PD5ZIlh2NtlGTfVrut
         0R1pfxZ5/9836W8dhB+BIO3Jcxc54hyr1uuKyHgo7qLcSzSebVptIbbzoNC12HqauSoR
         YT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761552386; x=1762157186;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLWjaKLx+X0gG/JQr9xbszcB6rfPVQrK0WJygsJNUrg=;
        b=pEFAQMujCXk3rvQI8pN2AI80PuYslgZDPFr/tRfVt1Egam3XbAOaRYM26lscpGXuZW
         qPdmKBte9/GME7rGMl2xYZ+PkPBcM0RWj6ZhSWbAELCricARo+nhgT+mIM4FGdEJc2Ka
         bpUFrxpejhWlgpMtKgIJOFSLJxXvtPPqeCzBqC55YO/irpOL43SW1Zlya9iFs4IEdmzP
         F10ZVtnGmEuccuvKHXZ1hEOaOPzDNljK1FnFobdRwh7OADaYdULFErsIsEKZCJioUtZI
         IkkwXN96en7fwn00mjurZ2lZqYldwRjlqFPJ3UnAo9KS3XFfMmcWcnwireqeYAzavM1k
         sSMg==
X-Forwarded-Encrypted: i=1; AJvYcCXkx0Q8Qx3IJQi0rtezE9KFwdjYND94iDzGbbABDoPUG7WMlpAt/eQ7zHG86NjPFc5DwPB/t35PXHBiXhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeMsAbZ/kW5n3Vk/q6WdfEQzvyBrN8fIdWxAirPDFShtcyFiZ0
	YuRWe4w07WZOAxYyQS033CAmy0i9pPWAMNv6XerLrmKf1ogtEkuRGG2t
X-Gm-Gg: ASbGncvNur3ipI+SL3ud2kNEnID3im7m+ahe9BFArsBQNlRToOBkEpICd/MolNmgmAV
	2Mwv45lBeG4078PegwI2xCUj9dqdhTuIgKrY3ZXKlvqXUzPgrrdK/rJiQfamGZCsHysDdHs0msp
	1WWAC2790J2Te3sNJX2qxwoM2zrqWF0yO5Ai6VSIK34tuSnNuC+prest2SRkuqQv4C/uxfbHL99
	onSHh8WFlQBkE+MqNa4q/IHtthF8CJtCY0OJCsgdaWuA/I62WN4jPICVk8tchpVMj+VYq7OgH/D
	uYWz604jMfGWKXdOVJMmP6PffasRqbfUDWAtDR3HJx9cmTj3KYtCvovJkfCYKDsPp7uGYqJHUzf
	+z7IMuN8ctJwk29QVCLd3ncrZ8kP9NpaLGEZ6mFqdO184hT5rc+wOd3X/NuEMAP04RM3Nhc8/ET
	4smiltKTedOwB51lSi3heNAlCfcCVe0lE1QPd24hoLE2pX
X-Google-Smtp-Source: AGHT+IH+aurWn18ayRrtNiWRdLqqMj+bLFYNr4oOdYqVnH8OIs+weAOzhle/Vj0N0XuWicoeo8Ozrg==
X-Received: by 2002:a05:6512:acc:b0:591:c8d7:c047 with SMTP id 2adb3069b0e04-592fc9d4f1dmr3044117e87.2.1761552385274;
        Mon, 27 Oct 2025 01:06:25 -0700 (PDT)
Received: from [192.168.1.168] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f41ce8sm2210689e87.6.2025.10.27.01.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 01:06:24 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 27 Oct 2025 09:05:42 +0100
Subject: [PATCH v2 2/6] drm/sitronix/st7571-i2c: add 'struct device' to
 st7571_device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-st7571-split-v2-2-8352fb278d21@gmail.com>
References: <20251027-st7571-split-v2-0-8352fb278d21@gmail.com>
In-Reply-To: <20251027-st7571-split-v2-0-8352fb278d21@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4484;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=LfOcWsXvHf24Rmlqiz3/HxiBo5dw0vDuG1TwXuVbpUw=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBo/yfjwDnLYpkefFw8wspv86ZqWh7GZDBsJdLoT
 Um3JTZAYAiJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaP8n4wAKCRCIgE5vWV1S
 MtmTEACeFpCAFkUknPDpaoEYTuORZ3YCKbfDe6m73afchsg9qwSwf4jAQOXZB8KnpLOT4rc9kgC
 qmIS6JpWGJqAwi/uSGVC9cWTF+BZlnlXV2vIo5MPoISAwAgRuiZ3ZqViR4SHH+yB8/OZk8pREln
 3/Y8u8epGhjB7Y4d84JBvv7cD6JfZLDQUT4itSQSw4r8mccksim6hHd4hFNNCoU0LHQtKNL+gaK
 oBz9lRN2504QKfzGpBAZlTJJ+Pxhd8ZepPIkyY1UQTVnrVgvraam/bkq4SZ2IT3RtHt4VofU9sZ
 xqbqvAdH77PJkdRa/83x/8DrOTQqkFfTrxNJFtkfSB/kmpH1CSysZux8QhwFIc1+D/PJk0fROR9
 QujMlPCQHzFL0w15eoKa86244QWm2GY0DS4gc8jDYNeVggUqrs8Ccx7lm4vCuZzLyObDwbG48jB
 S6NzG5nD1lZwXNwP/ElhygkM3xUomK3ewmjcdzfc91eMpLGCrK7pbSYXW5GWLRvLV5uuJj2KaWG
 001oroV8d+vRP6n1/LInvl1bj6HScsZ4E5vRC4PeQHlDg8/5xw39pXN80NYPsyT1l5vRWtxPiD/
 1TNeL7xXLVb77nSCGhGIoBO1bQOu9HGxBGRD7zyv++c9N+6GDZEON72aPtrXGgWDq2FosKv7bBU
 Dc3zQQLkA8W+Mbw==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Keep a copy of the device structure instead of referring to i2c_client.
This is a preparation step to separate the generic part from all i2c
stuff.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/gpu/drm/sitronix/st7571-i2c.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/sitronix/st7571-i2c.c b/drivers/gpu/drm/sitronix/st7571-i2c.c
index 71814a3eb93b7adf554da082a0237da371e5f5b5..2b52919d7dd434bb16aa66274eae8730649f62f1 100644
--- a/drivers/gpu/drm/sitronix/st7571-i2c.c
+++ b/drivers/gpu/drm/sitronix/st7571-i2c.c
@@ -113,6 +113,7 @@ struct st7571_panel_format {
 
 struct st7571_device {
 	struct drm_device drm;
+	struct device *dev;
 
 	struct drm_plane primary_plane;
 	struct drm_crtc crtc;
@@ -741,7 +742,7 @@ static const struct regmap_config st7571_regmap_config = {
 
 static int st7571_validate_parameters(struct st7571_device *st7571)
 {
-	struct device *dev = st7571->dev.dev;
+	struct device *dev = st7571->dev;
 	const struct st7571_panel_constraints *constraints = &st7571->pdata->constraints;
 
 	if (st7571->width_mm  == 0) {
@@ -781,7 +782,7 @@ static int st7571_validate_parameters(struct st7571_device *st7571)
 
 static int st7567_parse_dt(struct st7571_device *st7567)
 {
-	struct device *dev = &st7567->client->dev;
+	struct device *dev = st7567->dev;
 	struct device_node *np = dev->of_node;
 	struct display_timing dt;
 	int ret;
@@ -808,7 +809,7 @@ static int st7567_parse_dt(struct st7571_device *st7567)
 
 static int st7571_parse_dt(struct st7571_device *st7571)
 {
-	struct device *dev = &st7571->client->dev;
+	struct device *dev = st7571->dev;
 	struct device_node *np = dev->of_node;
 	struct display_timing dt;
 	int ret;
@@ -943,9 +944,10 @@ static int st7571_probe(struct i2c_client *client)
 		return PTR_ERR(st7571);
 
 	drm = &st7571->drm;
+	st7571->dev = &client->dev;
 	st7571->client = client;
 	i2c_set_clientdata(client, st7571);
-	st7571->pdata = device_get_match_data(&client->dev);
+	st7571->pdata = device_get_match_data(st7571->dev);
 
 	ret = st7571->pdata->parse_dt(st7571);
 	if (ret)
@@ -966,20 +968,20 @@ static int st7571_probe(struct i2c_client *client)
 	if (i2c_check_functionality(client->adapter, I2C_FUNC_PROTOCOL_MANGLING))
 		st7571->ignore_nak = true;
 
-	st7571->regmap = devm_regmap_init(&client->dev, &st7571_regmap_bus,
+	st7571->regmap = devm_regmap_init(st7571->dev, &st7571_regmap_bus,
 					  client, &st7571_regmap_config);
 	if (IS_ERR(st7571->regmap)) {
-		return dev_err_probe(&client->dev, PTR_ERR(st7571->regmap),
+		return dev_err_probe(st7571->dev, PTR_ERR(st7571->regmap),
 				     "Failed to initialize regmap\n");
 	}
 
-	st7571->hwbuf = devm_kzalloc(&client->dev,
+	st7571->hwbuf = devm_kzalloc(st7571->dev,
 				     (st7571->nlines * st7571->ncols * st7571->bpp) / 8,
 				     GFP_KERNEL);
 	if (!st7571->hwbuf)
 		return -ENOMEM;
 
-	st7571->row = devm_kzalloc(&client->dev,
+	st7571->row = devm_kzalloc(st7571->dev,
 				   (st7571->ncols * st7571->bpp),
 				   GFP_KERNEL);
 	if (!st7571->row)
@@ -987,34 +989,34 @@ static int st7571_probe(struct i2c_client *client)
 
 	ret = st7571_mode_config_init(st7571);
 	if (ret)
-		return dev_err_probe(&client->dev, ret,
+		return dev_err_probe(st7571->dev, ret,
 				     "Failed to initialize mode config\n");
 
 	ret = st7571_plane_init(st7571, st7571->pformat);
 	if (ret)
-		return dev_err_probe(&client->dev, ret,
+		return dev_err_probe(st7571->dev, ret,
 				     "Failed to initialize primary plane\n");
 
 	ret = st7571_crtc_init(st7571);
 	if (ret < 0)
-		return dev_err_probe(&client->dev, ret,
+		return dev_err_probe(st7571->dev, ret,
 				     "Failed to initialize CRTC\n");
 
 	ret = st7571_encoder_init(st7571);
 	if (ret < 0)
-		return dev_err_probe(&client->dev, ret,
+		return dev_err_probe(st7571->dev, ret,
 				     "Failed to initialize encoder\n");
 
 	ret = st7571_connector_init(st7571);
 	if (ret < 0)
-		return dev_err_probe(&client->dev, ret,
+		return dev_err_probe(st7571->dev, ret,
 				     "Failed to initialize connector\n");
 
 	drm_mode_config_reset(drm);
 
 	ret = drm_dev_register(drm, 0);
 	if (ret)
-		return dev_err_probe(&client->dev, ret,
+		return dev_err_probe(st7571->dev, ret,
 				     "Failed to register DRM device\n");
 
 	drm_client_setup(drm, NULL);

-- 
2.50.1



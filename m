Return-Path: <linux-kernel+bounces-868701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F0DC05F4A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BFBBE5636EE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68593590A8;
	Fri, 24 Oct 2025 10:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEu3S4ig"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDA3358D11
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303457; cv=none; b=iGux+GaHwbM0C4xAzUUCLjiFOrzpElV9qw0TNWWu17Tx5C0CLNiqW8BFar1JXOgHOnLBwQLdFfsSeJPtTJ+pgWAdFbMdr8wPftnO1SHdzXdecPCzKrCvw+/b0jKT1UZGcYYHchhU5Lno163EFHirR9+B/i66RmpOh1zRzU1G8ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303457; c=relaxed/simple;
	bh=LfOcWsXvHf24Rmlqiz3/HxiBo5dw0vDuG1TwXuVbpUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a9rHKAEFei+UUBqU4Sy9n4IJRRm/pZL95SUAnr+KeGmW6SxJdcnts6wK8f5YHMy1FHk/cI96Vs/Y9atxz5Nb14GEUkpqWWSDDZv1saanFKYSYPNVFlGxTNyu5coCRAq4nX/WzdEYAu0oZpO7R4Pgf5vxZHbIkP8CJu3aUPTjs/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEu3S4ig; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-592f1988a2dso2695220e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761303454; x=1761908254; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cLWjaKLx+X0gG/JQr9xbszcB6rfPVQrK0WJygsJNUrg=;
        b=nEu3S4igsc2tdw+/q+/k2ONE7FZjnkh7RNUIPJFFOHovj0jgnOJJaqvtO05fYtmLRN
         Eh41U/KkUY97OOIukhl3yKhvEbjuIGwZVac/eN1vYuAQkMK2//mwvJJBvMJ2jCYGDiJ/
         HJl6GlHw7eK6S3LI4NclCgmluKN6KUnQ86Jrb69wZaZV+B7oAD05I07bp3ibUsnm9L2k
         QlqbbWiCac/qHorVnO9J+AO1zXrv6a5sR+W/VdOCXUEkrhOMMa+r7z45fcIZlT6m/nJu
         WWiIKSPWpi8olZMmu5Qky8dDidEL9fxoXofhJE/8DF5KndhUZith//5DhoqshjUKLnOc
         BIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761303454; x=1761908254;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLWjaKLx+X0gG/JQr9xbszcB6rfPVQrK0WJygsJNUrg=;
        b=VNhR7RyUDy8b4MOIQC8R0HlsN8gTuwR959mxpL0mPJJXbgIO87WMZfPrQg3l/NbnmU
         ZRE1ZUntDEZjJvyRrr6yY+552oroeUd3/2TCkqPcH6XGgUBpQoV9QIqg9vG57Uvw4f9u
         EO28WfbWozVDPeu3JphlHqJnj+eQxEFeY3CHGxXmSvsBLUp2sCyDLXuZTDETYw7TyQZ6
         3z/qDfsiW097c6XILL7wzjyEDYet5jUDQd65siIwlzcBQcSzGTVPBvAuS8PtUwc1axch
         cq7P5QhOLovsOQJelM6x12LCT3dWkAypBg4Cjkq8sY3bqhQUdtVbXAkighZb/g009OeC
         N4ow==
X-Forwarded-Encrypted: i=1; AJvYcCXn8Q7ARbxZ44gSKbIeWTQeuSZtjue5F6K+xRciY7sErcuOSUtoDfPLiOi7hpPv/d/kFFTpUbAcYtIzM/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRz3Vd/TIa0+p6VmtpWPG1DiOJtA9NpFT+rsOXZMs4rEwWYyyW
	lGLhW5ckzVaUEK4Zrxc+NXvnxVAp34kH5PFPEIlJaAcq8QlctnEOtBhi
X-Gm-Gg: ASbGncvTPsdqLKgHA0gwPjbr777AlVAF677I61v9PrwwWA1SHLVuAhuvuXuBFN3qv3+
	UhPIo5zx81w37im+9uv/FhjzFZoOde9eTz7/4ESFUTWpjNVq097dJGA+ach7S4+qoG9WpK1K5WR
	tcff4N3QQ+KYKGrLq0rMIb8t7NU6daDgzqTbPlmtPlj73ETWLaDc4a+HF8dMJtHTrYP356ZKhGR
	RBH43TP/wY1IoX3ruqkWptmspw7DVwqL8/Ip6On+R/1DvWeMP8y5IfdH2n+E95k2VFKsboMOdAx
	qyE6Yofzi1c8ujBiOKpKJUVoHaoBL1oG7Q8YJGAXpjoWZAule9lFta/2vcNK+j4uTVEsX/bvDlj
	LlAoIQApmpQYbTzMLqOXX3P8GQx/c5W36S7MZWQKapmJ+mjT96f6wA7uF07P292A/KHzTS+yCpT
	xofazuFbh4xJWJ/tfWAP69NoQuDV7OuX/MWOgM5WOf6asT
X-Google-Smtp-Source: AGHT+IHPZEuRVXC0U6odZEYH6VBzGyuljeXi8z12j70VD9t0T+mgQIsAZPcf5xRYome74LIjGDBMJQ==
X-Received: by 2002:a05:651c:2545:10b0:376:2802:84c3 with SMTP id 38308e7fff4ca-378e3e9bb0amr5386011fa.24.1761303453825;
        Fri, 24 Oct 2025 03:57:33 -0700 (PDT)
Received: from [192.168.1.168] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378d67db8fesm10375671fa.38.2025.10.24.03.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 03:57:33 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Fri, 24 Oct 2025 12:56:53 +0200
Subject: [PATCH 2/6] drm/sitronix/st7571-i2c: add 'struct device' to
 st7571_device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-st7571-split-v1-2-d3092b98130f@gmail.com>
References: <20251024-st7571-split-v1-0-d3092b98130f@gmail.com>
In-Reply-To: <20251024-st7571-split-v1-0-d3092b98130f@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4484;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=LfOcWsXvHf24Rmlqiz3/HxiBo5dw0vDuG1TwXuVbpUw=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBo+1uBJtoReNeQpGPnf9grYHc5UoxKbA4Kyu5cC
 CaRuM790I2JAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaPtbgQAKCRCIgE5vWV1S
 MlnoD/4s36kKAjNEWR+7hAVQ9SN+DEYe3XbUGK0AhlenjxjuvEznj9kv9Rch29yP2XhCmHE+GHC
 1CsxW5P7IXBEvTM3tuAJN7Ys4B5XXXRyiazz1LLmre+4lSkWmh7ukJcgoy1jCLzIIUCY9NgHimK
 7PkQMhOXgkNAw4TlQlBgvrxv2TReCEA19SES2cvaOZBva87BrbBwZOsGoECsuGU6+97Pwvg+9Pi
 fwrue9gdRUHIVZv09BI8WAPVOtlq6ojHfVVJtbSTiegNYRijGIwsVkJfHg0unsvRYpjpxnZ6AzX
 1PXyADKhgiYDCMgZq4Vh8GzsdFdh2B2DaA9C8mECPqF1jw100nrbpdTdQPejKc+/KuRFDUi6hZv
 oK7verRQS1Vk0FRoHgIO6pcCTK8BYR2sg9ezXGMYqNJmIw2BoF6oc3RJvmoE/LNRsyw2CCCIKr8
 47iZaI9Mk6OMb9DDox3KR1zEHgYGh1dncx+L0SX+D+hMPdKeOlDZBAati8IERmJEAW0IzsLG13E
 AqJQpRrQcGeMrF4dfoi3pIvtrwrVZLpkO5btb22tbuvAUXjxH7Z6RerEEWFkzzQlApNHOc5DTJ8
 fo3cFE21WOfNmghuv7DgQbZ1FXaTUiuZBjz51sijFAbtYS0Gtw9ee5GHijYf1fdusoOObHxkkPF
 9KlIxa2EqcW22Fg==
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



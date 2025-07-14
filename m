Return-Path: <linux-kernel+bounces-729583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034FEB038AC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43BB23B91BE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF3F23BF91;
	Mon, 14 Jul 2025 08:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYFzBP4P"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C419F23A9BF;
	Mon, 14 Jul 2025 08:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752480280; cv=none; b=N6AtQ1d8gduRyF+w+aCrdC3Ok9b13gQi2o292gG8NpBt7TyTDNJkpr/LePKC71PGwSUJUM+KUUNEY6rNPhUxPyIzFQxo1jd7b9hQHl6JlPSgFD3dCqfjiPlvsL7LM1hS7Aga+1NkjYqKMGmw37leWLOZBRMZnukKLt3bV9HPv3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752480280; c=relaxed/simple;
	bh=nKfuyWks/Dpzizjd9fHnZs7Z2hrno+oTXUBiw5zduxE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S0/8+h1CVmte3crKcWGMmAjLWrVPaXhY12MKe03zwi5qK0iSPm2FvD71kdHWFr6K/bQMJqvz0WU75nYxGVNwGe2k3szk8kjYutzCuSNHskX1im4qJZ9w9SkT9h49Rv4DLSB4xYrm9LSqjnxvvTv3V8eJgIkuDuMEoB1J9p7fB8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYFzBP4P; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-553b3316160so4289226e87.2;
        Mon, 14 Jul 2025 01:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752480277; x=1753085077; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B9GGTSztthPX9RjXgUnWoKPJH6hGe57hUvqPeJEkExw=;
        b=YYFzBP4P5czitjS6x2cyCmLdhrbPphFgu1GqGVPIKRdbIxv+dqUgK6Hm2UTYgyRDmU
         FjGR49EzBQ1k3aX5ISSQAw3Su0EwZeztGti+3VIvOIo05Y7q5VjL29PAQTSpEgR+mH2P
         d/22+m+T0ZMDU2fVLDS0jzYUfHd+QABN29e803GN8o3i1gfJP+aTbrpu6ExCEMOo9Noq
         ZsaIlrWyIIDdM4eua/gswCuwOYV05F/Hpo0mOwoxW5k2RJ0f4Wwne6wo4DjrfRVa0cFy
         B2+HjBiOpnRHRSv2Ydbeie3GoxWW3f6K//QTOtbbnPkYRDzYAvk9ZKNhrKBNWJO+ZBo8
         7KEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752480277; x=1753085077;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9GGTSztthPX9RjXgUnWoKPJH6hGe57hUvqPeJEkExw=;
        b=KTvVMMDjj4WoJ7hcxfAc72dLYOkSL1uyRnVK/qigFtgqXoabg80VP8nSPl2focNfTe
         vbFldASy6ks/ryi1vPu58/5OWpymuXnxEMn9OurU7p2V9e0nHu5pEO+2+KqkE3fMZsBx
         0IFmblfh+Xoi1Qw5WLDtupCYf7tDho6bjzT+PMIVh3d3UlBhCx+Fk6iqdJrFsdPwybPX
         VvVJIWQdTF1t95kioonLUbns7NV5pY7DV5mX+BlqfyTODYE2dWzn7/SEOCYTOeJwLNVG
         hXmexfMMEnnaMD3sbdeKTTsJmJ9pkKlUsmDccVY2DzAnvSUlQaP+IqeXy0ABZ4os3npD
         MH0A==
X-Forwarded-Encrypted: i=1; AJvYcCVRjtk3BfWXVWHODm0+l6Or+8C8+MiXoLYA81e6QtxpEQM/kq8G5J2Lt8DyYcSEaYiv51CeQ2ayxDHD@vger.kernel.org, AJvYcCXxzYA2o7teUc17tERc+SBdacufBkrTwySfZCzRUUZ9ltoSlj4d6eJG6aV//vC86ONvxxznV4EYZRKGKKA3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/9550zZe9lLMkrwuU+P/GQmFLQFE9noO+nUT+A4oeQPdx54D3
	IXP6NXwmWmYT9ujrCTJaHlC3XVlEiI3u0wI5YU9zEmNrgVwJNOmWj9a5
X-Gm-Gg: ASbGncuJApOLxsWg3t1d5l4co6zgiI0IIQvrM3mlg6xdd5hB90wnLN3zcl8xxuaJaD+
	WEcnTtrYOnK0aL84bJw6uXztXfJRlo1UVhRg8caqyRPK8X7n/k5y/+hrtH64kdeXncmnhNklk7T
	O5CLgA1i67bpy+DbfGijbKa5KentLUfj2LYB/Qk+tSjGczWUT+UE6vLbfnAzrq6BE49HmUEzKtz
	JlBTwlRIPE5QN5xG1gzrc+yRf4KpXDb/fsGwCm6q8/9v/TjTqBctn3UGWqMhheoA9oSZcG/kclX
	YH8yDp2jmLXguzRGd6iNDWKd18RlDYpdGlZUS355eU9hfeUcBIlCVfhIlufrrbUC0QXeGKHETDt
	xSEBy7GCMTZJinatOuc3qXOfo8snd4wO/IBNNFAsvOtFfGJ4DFTzeEEAYeq5sPXcnMJ8=
X-Google-Smtp-Source: AGHT+IG3FjnhooHqlt3ucCpOZF7GxfsZEIc9G4pFe0tKlk9LOep+bdnRRtjfBZr1RODnwJKZWhsU2g==
X-Received: by 2002:a05:6512:32c6:b0:553:2def:1ae8 with SMTP id 2adb3069b0e04-55a04609b20mr3587657e87.30.1752480276593;
        Mon, 14 Jul 2025 01:04:36 -0700 (PDT)
Received: from [192.168.1.198] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b6c08esm1864385e87.187.2025.07.14.01.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 01:04:36 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 14 Jul 2025 10:04:01 +0200
Subject: [PATCH 3/5] drm/st7571-i2c: add support inverted pixel format
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-st7571-format-v1-3-a27e5112baff@gmail.com>
References: <20250714-st7571-format-v1-0-a27e5112baff@gmail.com>
In-Reply-To: <20250714-st7571-format-v1-0-a27e5112baff@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1681;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=nKfuyWks/Dpzizjd9fHnZs7Z2hrno+oTXUBiw5zduxE=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBodLoAG2jgkwWTSyu2OAKveT8gTVJB/txNKVHU+
 0nUy0hNL9qJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaHS6AAAKCRCIgE5vWV1S
 MricD/4nwH7czcMqAZ8egg5+wPkfzZojgNpJ0vpw9f2C1QUKSbImn7pakYeNLXzirNnzD4ESh+c
 gRs7gnOvNfQZrlngleXgqdPPskryz8IGNuWrA0Hb0wTeB1BrJ75aEbxpnzr6zF3zKrrrOQ/vnbK
 uOW6IaE+TiJ+pPjQ/R5EMoMzvrAmtSEjHA57psyKBfOI2j92zLtYL3n/eaQEVa2oC+2ldRyieoP
 VTj6VIHcB/sv60o/3sNxTbiCT+qLkv1qrok/StbL8AHX/nCg/jwEJjXKe860UYkkm/NQAoDw+A9
 zIHQOUIPqA4yvUCy0PncpUM0X39YreAv2jtgonYakTZ+FhdMOtUUMpJjaoSC4qQsczV8TLq/NEb
 bnwBkc7igs2iizEo1RGns5OMzpE/E78YZADddn2F6qRO/WCeAEjFaqMUPtlxPy06P54GYWaDkgY
 gF9I+Jt8d6tQgVEnQ98d1vP3wVPxVzN5ZUnK4IN2nX+rcELocu1KLu0yAqXwn+7/K874SX0+GyX
 6Cvt23K316jduhtNv5piDyZxP4/XeDKPy6iKlRawHst8e1wFM7svM9JvkTqRXOJbDQxggPn9iVB
 C/cTeTDESc0LlQqtAU7mU7Dk174TGRM+z44xfrFVqItqkN6mK/D7y4ygO6eEAh4rt9YxNtdEEL/
 hQ0v8fVckWk+h0w==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Depending on which display that is connected to the controller, an
"1" means either a black or a white pixel.

The supported formats (R1/R2/XRGB8888) expects the pixels
to map against (4bit):
    00 => Black
    01 => Dark Gray
    10 => Light Gray
    11 => White

If this is not what the display map against, make it possible to invert
the pixels.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/gpu/drm/sitronix/st7571-i2c.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sitronix/st7571-i2c.c b/drivers/gpu/drm/sitronix/st7571-i2c.c
index 3024c94c890497d1ddbbf0f7f81ec4664f48d580..6a5d719f8b0044ec700ff119972b580c904ffb27 100644
--- a/drivers/gpu/drm/sitronix/st7571-i2c.c
+++ b/drivers/gpu/drm/sitronix/st7571-i2c.c
@@ -147,6 +147,7 @@ struct st7571_device {
 	bool ignore_nak;
 
 	bool grayscale;
+	bool inverted;
 	u32 height_mm;
 	u32 width_mm;
 	u32 startline;
@@ -789,6 +790,7 @@ static int st7571_parse_dt(struct st7571_device *st7571)
 	of_property_read_u32(np, "width-mm", &st7571->width_mm);
 	of_property_read_u32(np, "height-mm", &st7571->height_mm);
 	st7571->grayscale = of_property_read_bool(np, "sitronix,grayscale");
+	st7571->inverted = of_property_read_bool(np, "sitronix,inverted");
 
 	if (st7571->grayscale) {
 		st7571->pformat = &st7571_grayscale;
@@ -853,7 +855,7 @@ static int st7571_lcd_init(struct st7571_device *st7571)
 		ST7571_SET_COLOR_MODE(st7571->pformat->mode),
 		ST7571_COMMAND_SET_NORMAL,
 
-		ST7571_SET_REVERSE(0),
+		ST7571_SET_REVERSE(st7571->inverted ? 1 : 0),
 		ST7571_SET_ENTIRE_DISPLAY_ON(0),
 	};
 

-- 
2.49.0



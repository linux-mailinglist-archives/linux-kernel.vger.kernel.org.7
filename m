Return-Path: <linux-kernel+bounces-731703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDF1B0586D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC5101A622F0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E6C2DE70D;
	Tue, 15 Jul 2025 11:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5HLHTbx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57252DE6ED
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752577508; cv=none; b=dPe64NNHI+gwQ56BnBMYcovVS9zwEgkD2MWDkWi93/m1KcLS2xqOeCh4Y7qIU0Nw/XXZPQE5RKKy6m4wpzeVZK+FVvOJxP1BZWzttbdZ7IGT5M/o2bUuHBqyV5MtvIxY91m6+2A2vBvQoiadWFgJkLOVtn1ajV8z4MKOBgEY7Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752577508; c=relaxed/simple;
	bh=wvqMbbydNYHpf0fQgl6rIjSkCCYFZIBa8eEk6rht2a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YlfER2MJVK33bLRJNimM9BmIsSfO293GW64PRMsP+DV312ERf+XKHUvpLpOxnftjlTzZDCHms1BoTZsQK7wg+yod6F2aQdHN4PfXfLpjwJmazKbKff7l57NTytFfNdqXlTxfLX+poAV6wdKfu/x08F7sSRVJC0WB1r2s3jXlC6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P5HLHTbx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752577505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mXWJvgkysJAIYjhynSIqmAwCotshg97ykDbemk4MKVY=;
	b=P5HLHTbxAG+2c21bIUnEIydDE6xy6qzBUKloK8PJD8OQg+iheR6hOVO6+WntuX5q1/hX1U
	3NVVj9JqmiPrwQJElADBH7Ob8HtrvE5nA9vBVXQ8i0J5d3zHTlqq4tXTTs/+vziP0N6VSZ
	MKV7mHXHJge88ddIojl25rn8e+I3lkY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617--NSBrPVYMaGHs7cx3FY0Mw-1; Tue, 15 Jul 2025 07:05:03 -0400
X-MC-Unique: -NSBrPVYMaGHs7cx3FY0Mw-1
X-Mimecast-MFC-AGG-ID: -NSBrPVYMaGHs7cx3FY0Mw_1752577503
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4561611dc2aso18494215e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 04:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752577502; x=1753182302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXWJvgkysJAIYjhynSIqmAwCotshg97ykDbemk4MKVY=;
        b=Kf+SpphK0Z0qGPQJ16Vw4bbzi6Xi6QnZ/fvwIabg7nlSjS2jAOpNCG620RnByOC5O/
         0dKUr484SmGfHjEDdWyY/AAx40YF+hnlwEBBiGcuvzLEDxLUPqU1B2I1NlfibrtJMsnJ
         hjqt9bFMwgfXjC35Ff5eulqCpwlPebLOCr5TsvJi0MAnFeFeo1h+c6m/6FsRGqtEKAK8
         I+peRHgTi6vesIaAEk2y0ffR0KzWSPSt8xibeBomrVTmuVPGsSf8tW8sk519A8Eln8/d
         1Wfmt4mBJ76S9EFegZgmEjy+1hJrB0vfu+YzMGspBZK1qV0bhXhEXV0IU9gP2755Wp9E
         DiHA==
X-Gm-Message-State: AOJu0YwCiRCMSv0nwRSdJHXpU31yvfXZScAT38oaRcj5dDQa1REwF5Wm
	AsojAJ9CsHgXFYEBCcEkcdKwvZ04d9ZYMfTafSHP7IjkUcVeFuU+0B/MjOZ3vexp6wyu+v4WpSW
	VsQWZmfYyoumF2sqxkJwBMjYdcyyHB6jgjOexbCDkwquPcQ1pmQJCbZqOGqCJ/Uik0qYDH1U+Fu
	9DmCtkEnpmrholBRM1hPKem8CY/YiHp5QjP9OypIYD90+N0eXs
X-Gm-Gg: ASbGncuH07KdTrcOltakHL5gas7vY4/dceuAvByJuM8KMs0hRLTwlyGvtLSLsqD2eZc
	sMcruJGYbYA9adnZ6Y5/074iTXdgEBSgADVn0PHa9dZL32kMnF248zuZRJHbrqI0eLM34UR4ees
	DwbCJ1pGA/oqb8ulK/X8QlJd49ZhlrexyddfIa1JmQ3ZkbDIZZs49LeThkPYFbzs785XT/qdWu0
	t3tQJGR0taNVtPUioQuz5YBheo4JJh/DcJDcosvKFJD93kpm5ugcRH+Xv1PB7+TAnrl70JlsU1b
	pNUXALylVbl1yAQ3rQY8EnSmFmRlPW3W
X-Received: by 2002:a05:600c:3b84:b0:442:e9eb:cba2 with SMTP id 5b1f17b1804b1-456270595f5mr25683055e9.0.1752577501707;
        Tue, 15 Jul 2025 04:05:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFp+zFcABguTv2tVfluwznB62/qIMjIJQ+aN4JA01wqyr6F5mtu+/5NlUV3tbY8+UfZTV92gQ==
X-Received: by 2002:a05:600c:3b84:b0:442:e9eb:cba2 with SMTP id 5b1f17b1804b1-456270595f5mr25682415e9.0.1752577501047;
        Tue, 15 Jul 2025 04:05:01 -0700 (PDT)
Received: from localhost ([89.128.88.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45614aeba29sm73112375e9.11.2025.07.15.04.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 04:05:00 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: ipedrosa@redhat.com,
	Javier Martinez Canillas <javierm@redhat.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v3 5/5] drm/sitronix/st7571-i2c: Add support for the ST7567 Controller
Date: Tue, 15 Jul 2025 13:03:54 +0200
Message-ID: <20250715110411.448343-6-javierm@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715110411.448343-1-javierm@redhat.com>
References: <20250715110411.448343-1-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Sitronix ST7567 is a monochrome Dot Matrix LCD Controller that has SPI,
I2C and parallel interfaces. The st7571-i2c driver only has support for I2C
so displays using other transport interfaces are currently not supported.

The DRM_FORMAT_R1 pixel format and data commands are the same than what
is used by the ST7571 controller, so only is needed a different callback
that implements the expected initialization sequence for the ST7567 chip.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---

Changes in v3:
- Explicitly set ST7571_SET_REVERSE(0) instead of relying on defaults.

Changes in v2:
- Use a different parse DT function (Thomas Zimmermann).

 drivers/gpu/drm/sitronix/st7571-i2c.c | 75 +++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/sitronix/st7571-i2c.c b/drivers/gpu/drm/sitronix/st7571-i2c.c
index f9c4fedb3cca..453eb7e045e5 100644
--- a/drivers/gpu/drm/sitronix/st7571-i2c.c
+++ b/drivers/gpu/drm/sitronix/st7571-i2c.c
@@ -68,6 +68,9 @@
 #define ST7571_SET_COLOR_MODE(c)		(0x10 | FIELD_PREP(GENMASK(0, 0), (c)))
 #define ST7571_COMMAND_SET_NORMAL		(0x00)
 
+/* ST7567 commands */
+#define ST7567_SET_LCD_BIAS(m) (0xa2 | FIELD_PREP(GENMASK(0, 0), (m)))
+
 #define ST7571_PAGE_HEIGHT 8
 
 #define DRIVER_NAME "st7571"
@@ -774,6 +777,32 @@ static int st7571_validate_parameters(struct st7571_device *st7571)
 	return 0;
 }
 
+static int st7567_parse_dt(struct st7571_device *st7567)
+{
+	struct device *dev = &st7567->client->dev;
+	struct device_node *np = dev->of_node;
+	struct display_timing dt;
+	int ret;
+
+	ret = of_get_display_timing(np, "panel-timing", &dt);
+	if (ret) {
+		dev_err(dev, "Failed to get display timing from DT\n");
+		return ret;
+	}
+
+	of_property_read_u32(np, "width-mm", &st7567->width_mm);
+	of_property_read_u32(np, "height-mm", &st7567->height_mm);
+
+	st7567->pformat = &st7571_monochrome;
+	st7567->bpp = 1;
+
+	st7567->startline = dt.vfront_porch.typ;
+	st7567->nlines = dt.vactive.typ;
+	st7567->ncols = dt.hactive.typ;
+
+	return 0;
+}
+
 static int st7571_parse_dt(struct st7571_device *st7571)
 {
 	struct device *dev = &st7571->client->dev;
@@ -819,6 +848,38 @@ static void st7571_reset(struct st7571_device *st7571)
 	gpiod_set_value_cansleep(st7571->reset, 0);
 }
 
+static int st7567_lcd_init(struct st7571_device *st7567)
+{
+	/*
+	 * Most of the initialization sequence is taken directly from the
+	 * referential initial code in the ST7567 datasheet.
+	 */
+	u8 commands[] = {
+		ST7571_DISPLAY_OFF,
+
+		ST7567_SET_LCD_BIAS(1),
+
+		ST7571_SET_SEG_SCAN_DIR(0),
+		ST7571_SET_COM_SCAN_DIR(1),
+
+		ST7571_SET_REGULATOR_REG(4),
+		ST7571_SET_CONTRAST_MSB,
+		ST7571_SET_CONTRAST_LSB(0x20),
+
+		ST7571_SET_START_LINE_MSB,
+		ST7571_SET_START_LINE_LSB(st7567->startline),
+
+		ST7571_SET_POWER(0x4),	/* Power Control, VC: ON, VR: OFF, VF: OFF */
+		ST7571_SET_POWER(0x6),	/* Power Control, VC: ON, VR: ON, VF: OFF */
+		ST7571_SET_POWER(0x7),	/* Power Control, VC: ON, VR: ON, VF: ON */
+
+		ST7571_SET_REVERSE(0),
+		ST7571_SET_ENTIRE_DISPLAY_ON(0),
+	};
+
+	return st7571_send_command_list(st7567, commands, ARRAY_SIZE(commands));
+}
+
 static int st7571_lcd_init(struct st7571_device *st7571)
 {
 	/*
@@ -963,6 +1024,18 @@ static void st7571_remove(struct i2c_client *client)
 	drm_dev_unplug(&st7571->dev);
 }
 
+struct st7571_panel_data st7567_config = {
+	.init = st7567_lcd_init,
+	.parse_dt = st7567_parse_dt,
+	.constraints = {
+		.min_nlines = 1,
+		.max_nlines = 64,
+		.min_ncols = 128,
+		.max_ncols = 128,
+		.support_grayscale = false,
+	},
+};
+
 struct st7571_panel_data st7571_config = {
 	.init = st7571_lcd_init,
 	.parse_dt = st7571_parse_dt,
@@ -976,12 +1049,14 @@ struct st7571_panel_data st7571_config = {
 };
 
 static const struct of_device_id st7571_of_match[] = {
+	{ .compatible = "sitronix,st7567", .data = &st7567_config },
 	{ .compatible = "sitronix,st7571", .data = &st7571_config },
 	{},
 };
 MODULE_DEVICE_TABLE(of, st7571_of_match);
 
 static const struct i2c_device_id st7571_id[] = {
+	{ "st7567", 0 },
 	{ "st7571", 0 },
 	{ }
 };
-- 
2.49.0



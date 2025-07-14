Return-Path: <linux-kernel+bounces-729867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A55FB03CA4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4D834A5965
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11AC149C51;
	Mon, 14 Jul 2025 10:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TfG6mxll"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D1545009
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752490393; cv=none; b=kXMnLDMs9sJJMxJWDaHQr4J9PfPKwdjipXJ187YPrVDEMsQstCEudSpop+uzlUX/x+YSL5ND/4VDw0lyZT+NSnXW+0ZPB5yEH6NuP9JglXvHgvwH+P+SMz+n9CERumgYhdovocHVQrAxgX0okKzn67fRiGREwAz2VxkPAlVlmwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752490393; c=relaxed/simple;
	bh=QKCkOsCK6Zy5Qaj116PD8xxOQLfC9pstaPGQA20Sjog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXZsOqVz91JNEdxJTlbgPvUHzdsaBorrNF/USSfX/V8rfyCsKd26z8pQhRShORUjC31fMVQuESFlQe9r9L8VcIHWEg0aFnQRDfqi/2tdro1G/ZlAgmdit5ujJQ8hgkrf8nwSFuB3dwJNSbGsULPp2QtVllpTBsUwf6ZeN5/2Fww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TfG6mxll; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752490390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QcePExROBkGmXTd3pzyFFPMJePKoh9BWUTzEsDl2zWY=;
	b=TfG6mxll01c+qBz5L5dKBFWswdyu809Eqq1wPsOkpHWYBokSqCr3eH2hxTI8rGEZWUQ1pG
	zuMBl3nmlPTnQQWN5LdLIeQKhagmcrq35DtW0i5x0H9rwVa+rFIlYO462REiayfXEHc6/v
	V6j4On/WvBCWc65tVUr85drzAWV42rQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-wC9xIjc3NxSFPQE2xLtp1A-1; Mon, 14 Jul 2025 06:44:50 -0400
X-MC-Unique: wC9xIjc3NxSFPQE2xLtp1A-1
X-Mimecast-MFC-AGG-ID: wC9xIjc3NxSFPQE2xLtp1A_1752489890
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-454dee17a91so31360745e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 03:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752489889; x=1753094689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcePExROBkGmXTd3pzyFFPMJePKoh9BWUTzEsDl2zWY=;
        b=SnnZzkVQUsHNwlFEd+4Yi3uJLqx8fgoG58/Vj4MEcMve7AcMe87U95tJUIT+R4xxKI
         irUse5OGDGocOZLjjUqWHaLj+FFlz49vtgJ6PClBm81iJJFvwibypdIddGXXuM0stHsb
         7dleOy0h2kElTLyPEsKYojlxc/0GQ/LfF/g71ho7Ao2bW1Iuegjs5LviSNMJA4Le5J2H
         gbU7gfJaMmrBF07EtCa0yPrUvx3eE7wmrr9GG5a2Z0VBKC4dSavYJK01s6KgAJuekF2D
         jCv9szT89aWfw0TF23juoiXvp2hUhRsxLFFGW53W0DFxHKEvNTH+0OVvYOL3Ca3p4pj6
         tXnQ==
X-Gm-Message-State: AOJu0YxBzNijWMJWt6CCLPI9Vyl64zmnb1QmTYh1xAShTEqN7SUHy+/1
	uLiefiACQ2MyFp/SG2z0hXvF/hkpHeYC1srz77rtJtDWp9MO/cFtp/sugx2n3pJ1rkddJmPcro+
	J1Tb23NUOyrJvqGd7CvU8LWTtK7GbIXHs/kmyyzF4Mqy3+7M5/zxAGc5tR+CABPu7bbG0GcpJ/c
	F1KijA8vJoTH2oHip+/TIYNdCkz6bp13uEUFSITlTehsW/jE3p
X-Gm-Gg: ASbGncsw6bwKLI1m3R5/a9r8IIZAfhy8v4AxcJyTSgqudPLxG4CfQMLyoU3fX/3JHX5
	jc1jqfXyUNTh0n+0mmczKOWOYJaCQ/AYLFacnXvN60L9rt6ToQ9sNkCY0HwgReO9eS3Mz4BMgXc
	I8MihyxaKDHkIs5x9BsSjs8dejfwsgM2n6zse4gekKyiR6mEY6B1ISYJBn7DNEN1KsZI/E0KO4O
	vwlHZD7Sko1ubDhtwLwlcpXrZnb4IbRfeUnpEvkcpkHxVujYMUetAUrbYuzidT8wysikDrENIu+
	nvSnUo9VwN0TJTFg05fIFWg4Ow6OiHfb
X-Received: by 2002:a05:600c:1da7:b0:456:1b8b:b8c6 with SMTP id 5b1f17b1804b1-4561b8bbbf3mr26660005e9.14.1752489889192;
        Mon, 14 Jul 2025 03:44:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGnLmL3APGndfptepWrP7aJt58jFVF0xV99rnqtzmW+5CMr6NcUHBMolv58MpEYfVkZQpmmQ==
X-Received: by 2002:a05:600c:1da7:b0:456:1b8b:b8c6 with SMTP id 5b1f17b1804b1-4561b8bbbf3mr26659605e9.14.1752489888714;
        Mon, 14 Jul 2025 03:44:48 -0700 (PDT)
Received: from localhost ([89.128.88.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e14ce6sm12240314f8f.68.2025.07.14.03.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 03:44:47 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: ipedrosa@redhat.com,
	Javier Martinez Canillas <javierm@redhat.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 5/5] drm/sitronix/st7571-i2c: Add support for the ST7567 Controller
Date: Mon, 14 Jul 2025 12:44:04 +0200
Message-ID: <20250714104421.323753-6-javierm@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250714104421.323753-1-javierm@redhat.com>
References: <20250714104421.323753-1-javierm@redhat.com>
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
---

Changes in v2:
- Use a different parse DT function (Thomas Zimmermann).

 drivers/gpu/drm/sitronix/st7571-i2c.c | 74 +++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/gpu/drm/sitronix/st7571-i2c.c b/drivers/gpu/drm/sitronix/st7571-i2c.c
index f9c4fedb3cca..1b820ff6a9dd 100644
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
@@ -819,6 +848,37 @@ static void st7571_reset(struct st7571_device *st7571)
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
+		ST7571_SET_ENTIRE_DISPLAY_ON(0),
+	};
+
+	return st7571_send_command_list(st7567, commands, ARRAY_SIZE(commands));
+}
+
 static int st7571_lcd_init(struct st7571_device *st7571)
 {
 	/*
@@ -963,6 +1023,18 @@ static void st7571_remove(struct i2c_client *client)
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
@@ -976,12 +1048,14 @@ struct st7571_panel_data st7571_config = {
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



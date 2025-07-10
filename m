Return-Path: <linux-kernel+bounces-725444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DECCAFFF35
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F5E5A5043
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83BB2E5420;
	Thu, 10 Jul 2025 10:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i5+X1+lw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FAF2E3378
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752143159; cv=none; b=BuVd89LeA101ov5WoVM79P/7Q7Vuj5Bzvzcy4Hos9bF10V0Oniueei75U6yShUPNDlTfVLJ7qWGI+4EfA4NW8ZwPCu55stGtntLTMAmBvaI0ikNtRihCFhlqhwd3JGGq86y14TjiteH+8KxPAT2QJTOcaPozfGm12HN949Hd/4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752143159; c=relaxed/simple;
	bh=dAGA8WqvCdk3gWJqFmv0eOLwFEd11uDZxhV49HfOEto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYKSGUCMrhizJAUKrpC3p6YWbLsS4VlMJOzV0+BE9XCqtDZ3OaiLY2+gxiT+yUfIKhEfWkg3GKmDFpY3a7hRpj6eZzTDU6iwzG90f4B5KG+EYdpCJtkOG9PXnUItktxeG0/e/ShEi3DZvBk6WYrhOVU8SgRjyUwC/1GaxEigzvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i5+X1+lw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752143156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rpachhN0uLazu1YIn/ePDV6zDFQOiD+8nZOn/jssAK0=;
	b=i5+X1+lwFEUNDvnwQNBSduMqbM8kZSrc4P6ZejX1sBDjurqnYFQRVkjQlCm6KIasLXyQnL
	lp2454X8hcsRfpK0WMRJyrnt/2cl3FaD0Zgvl1Tn4T6iJkKPRhgDHBchDWXZrjTqYNUQAb
	OM3GUIl600uf0VULyYs+0rNE5J2OI3E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-ap02euY9NbaCr7HMBJe2Hw-1; Thu, 10 Jul 2025 06:25:55 -0400
X-MC-Unique: ap02euY9NbaCr7HMBJe2Hw-1
X-Mimecast-MFC-AGG-ID: ap02euY9NbaCr7HMBJe2Hw_1752143154
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f7f1b932so573339f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 03:25:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752143153; x=1752747953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rpachhN0uLazu1YIn/ePDV6zDFQOiD+8nZOn/jssAK0=;
        b=l6XqxfjCGJ+RgfxrLff4U24Rvut189DwzS/w/e96W+o3mXHOi6vfAXCF+a7Ux3BjKc
         xyXg8oLtvPzTRX2W8FMHe01a2Seb/1nLs8ndFHqhbKf9VAHqS9JqG8fNweyjsx5xxHr5
         HLMmKeCJCbPVc5rDg2IOS2HusCURi2ncBozNRaS6QOWTynfbWOi/6H3XwTVh0ujpmrhM
         wasxMnYsWFJg3knCVtQbSMYxlFjYfWxDkwXGweBf8BaNgedwy8jL7cYlR6u9G0XYX+ss
         0ux/3V5dQHMbcgAbcnt5R+0OMu/V7fNuxy4msprgKNd1Pvll7UWHopiAVDH2J5J4/5i8
         APNQ==
X-Gm-Message-State: AOJu0Yx2llreyI8fdeE2h3Jk3yxTlOvVa/CpnCcz2XEMzlMQ7xr0ooSH
	w5qhphe2FdfJRGCirmJkBC2tnODZ2GHqiNpa53zSGsujZ/xXynycacXyo86CMqrqfhVsd9JjkG9
	Ddmzp4T5qWeuL49DhVT0YQpDTLVECuLQQy2+WAeNgyT92hygpq4bG4EzTr/2kELcsU671JVw+cC
	/tBo+xmcH5fdoDYkxr0xgEwZo+uTgWWZ5TkYJBynhaUzwYi293
X-Gm-Gg: ASbGncubtL3MtmRjdI2+v6Rn7EKlmyYRftZ4eLIiL/GB5V8yPpy5kcT8z/4HPhUHPEt
	JpIAzCcoqc+ISLzZkGI9OhYshU8Q3TLfSWFKWVrkJoMxBGiYxBa6jIW/fsCzuOxTCgEcp9t+LSG
	70Db/J7LSGHie7w4UwJyDhBZPLnaflotBoADlDWY7ypX5Z4IdI8t+KsdV7yqAIfzuWHS6rWugM3
	IhS9whqt9zhtAoghl7npLGa8LRZBOxhTpBjWYbwwO4X8f6E5aXBfp860lGMqtcqqblnVYyRujUb
	gya1mOXQK72SmVWto3XgPdfbI0m23BzkHUD6JxQIC+ywTTc=
X-Received: by 2002:a05:6000:2dc5:b0:3a4:e7b7:3851 with SMTP id ffacd0b85a97d-3b5e86fbabbmr1843220f8f.58.1752143153214;
        Thu, 10 Jul 2025 03:25:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNFbEAiTWk6bIPshxO3enB3W4uVYluO9n+nPE5yTK/qj5yZCxHAbekX/b1jHd+JAInA2V4AA==
X-Received: by 2002:a05:6000:2dc5:b0:3a4:e7b7:3851 with SMTP id ffacd0b85a97d-3b5e86fbabbmr1843196f8f.58.1752143152721;
        Thu, 10 Jul 2025 03:25:52 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e26c97sm1507695f8f.90.2025.07.10.03.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 03:25:52 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: ipedrosa@redhat.com,
	Javier Martinez Canillas <javierm@redhat.com>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 3/3] drm/sitronix/st7571-i2c: Add support for the ST7567 Controller
Date: Thu, 10 Jul 2025 12:24:35 +0200
Message-ID: <20250710102453.101078-4-javierm@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250710102453.101078-1-javierm@redhat.com>
References: <20250710102453.101078-1-javierm@redhat.com>
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
---

 drivers/gpu/drm/sitronix/st7571-i2c.c | 47 +++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/sitronix/st7571-i2c.c b/drivers/gpu/drm/sitronix/st7571-i2c.c
index 73e8db25f895..ea915bd5deeb 100644
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
@@ -820,6 +823,37 @@ static void st7571_reset(struct st7571_device *st7571)
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
@@ -964,6 +998,17 @@ static void st7571_remove(struct i2c_client *client)
 	drm_dev_unplug(&st7571->dev);
 }
 
+struct st7571_panel_data st7567_config = {
+	.init = st7567_lcd_init,
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
 	.constraints = {
@@ -976,12 +1021,14 @@ struct st7571_panel_data st7571_config = {
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



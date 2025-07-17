Return-Path: <linux-kernel+bounces-735494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AD3B0901E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33CEC3BA67A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1F82F948D;
	Thu, 17 Jul 2025 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="QlKMtmVd"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9302F85D1
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752764541; cv=none; b=UxBNFXjmjbawFrODgjVezOoZ0FmrVZVvOS/Nify42Quz8qipZmSS6IriINkfBy0XbZH0+VQNgHgdMCdQDZK0H+bEqo/q3yKuYc8KSroNyztrcnzcKK0N0Hwgt00wqKgWlHGRh/6p5tfc4s3yEt8qznA71ruVtiRskeTizYuEsAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752764541; c=relaxed/simple;
	bh=NuZrXXQ5tlfhJZ6G10mYOT34Gf1XyPJpaO9Kpu9cCUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l3v25VHev9gFGH9qj3gPzyS4rwgb459hbb6Kwca2G4IpSjPGDB+z+hwdviJvlJyAwkYBvqKH4jkpydoXaSRKxh0HUV0sPBkOMRsAbQbnQPOiUC7DEi6c/lBlTsMmcJcg0fMSE76xQF4gSiX9U9Huz1j8Q0rXRti9V/9RqNHPri4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=QlKMtmVd; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45610582d07so8631275e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 08:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1752764538; x=1753369338; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EUbJHYYUJ4dPHD8beah1zUaqGMO0MQts8CvEiFdKGdo=;
        b=QlKMtmVdzIZpKNmfuL919rglY2RbPsVbqTVDJ4RDWZViFRTPy3/dO85osapiLPytIU
         jGV0wDrt9ChlkYAkY+9kVcKml5pa4r6VlXeS8hFAePhU/rWTxfDY9eXhXz9fQ+S9B4kg
         z+pzrj089zz21it1IUkM0TEKvpW/DXWTBt1XRfDsftu/YT/1s1sQBMnsYEB/eFZd0NUE
         WlAtyFTQYxl2WmbMRrF5A5mlfas70kdDCB4IkHZeAq9E5r9vu/zG5LQ0+NvKbz63G0tW
         McD+L7coOvYe2mJSoL1XBpDtBRmtQ4rY9bWs+n4tdNwyoDj9YCsS2R0ni9uDKg5BXwmd
         LfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752764538; x=1753369338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUbJHYYUJ4dPHD8beah1zUaqGMO0MQts8CvEiFdKGdo=;
        b=VTVRBEtEnezzkyxDWznMcUVoAVfikKklOx2jdRoYUk1c4+LxoosJiXtlCY5VXnJs/u
         hE7oMWfxOnP6P0Vf7YfPvKW6if0OFfF4ip5Wyg4Mg+P0IVMJNqUuRhEw9tbA8XA5ZRIs
         DItMLnRwRdPjfPIR7U8LWXw57ojY4X1yjtdihX7EqfZ353O00BuP7whjydIFuLfmJMB2
         ol3/XSe90syItTlA51Y9HfV+X0qcysz0FliE07WKZ6nlpa1Hc3g9MRAvVs24jKOQwm5G
         Nc8E7tNXQ3gmEsK1gUoG1sQkOTIO4L60s3EY59p+umNZNxKNUNl3KOCsO+HRBYIl7v6K
         kTFA==
X-Forwarded-Encrypted: i=1; AJvYcCWN2dtgCsVHqg5461RXstZ+5uqvBK3tyJ/ZZnNQSm7H9KJ+gRDI03wBvkel9a9k42NLzG4ZoD8QIfMH+lM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiB4iNWO58nl0vXpj42CiYWRik6wkEA1BB+4DsP5dFtTeqeof6
	F8DzA6cvWICkprXpLC8+zeu7cwAoujlxm5rRvvu4rs+OzLvGF2j/nRBzv7fKm9dtmdU=
X-Gm-Gg: ASbGnctnP03cU19WWiOx+4/rPKEu7dXeNvmdttanaLcNazT2I68YS+u8AL5xOccYDtx
	yOe0kgmiFpRSe3fRKDgHWbTfLUborJeO51V+jVTkZc2dwmXPm+nbQ4v857juqHAxvEQmadq8u1Z
	ZmsvJTVQBprTeZ+uDJfan30ZBO8uiBxTht1dE5QKEJkmY0kSIbewkpn1Tq1qCl7lCLxFSYgosL/
	D4CFdGUiGhRr1KW8axuhGFln5toB4/oL9gG1CTL7G+g25LE1Gg+vcAMF2nWntfPIGgiL2cudQZ+
	CVYKUStjnvhO8p8RXB/qLffOEutQ63cL/+QeaLrUO3qFo0OrXUq0NhOkZOnRkuNKcD7+xHAmrtE
	FB0+0OoZkqjSpM5l46QC8u1vNrnGpnBy/fSOmm8E=
X-Google-Smtp-Source: AGHT+IHkEGHGxu7VXqSi5lmH6fVl3oHkkA/hBP0zA2Ax85fviyQHeC51lkDdCJT5F7Y71CT+stzgbA==
X-Received: by 2002:a05:6000:2313:b0:3a4:e844:745d with SMTP id ffacd0b85a97d-3b613eab435mr2714201f8f.56.1752764537498;
        Thu, 17 Jul 2025 08:02:17 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c7:1d1a:9c01:ebc8:7ccb:ef04:4f83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45634f5cb9bsm25321885e9.10.2025.07.17.08.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 08:02:17 -0700 (PDT)
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Thu, 17 Jul 2025 16:02:09 +0100
Subject: [PATCH v4 3/3] leds/leds-is31fl32xx: add support for is31fl3236a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-leds-is31fl3236a-v4-3-72ef946bfbc8@thegoodpenguin.co.uk>
References: <20250717-leds-is31fl3236a-v4-0-72ef946bfbc8@thegoodpenguin.co.uk>
In-Reply-To: <20250717-leds-is31fl3236a-v4-0-72ef946bfbc8@thegoodpenguin.co.uk>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Pavel Machek <pavel@ucw.cz>, devicetree@vger.kernel.org, 
 Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752764533; l=5531;
 i=pzalewski@thegoodpenguin.co.uk; s=20250625; h=from:subject:message-id;
 bh=NuZrXXQ5tlfhJZ6G10mYOT34Gf1XyPJpaO9Kpu9cCUo=;
 b=a43lCfh+jM2LbjJFu88mbDfM8oMsA7XzFg2vx05SkvN9mAvFADOevL4QiHAyqby1wYG1AfaqC
 zRWSys/0wBaBhffIB5XBNZmvopWV2ukPwlKaUKmd8lBTEwPTs6Zh2Xi
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=hHrwBom/yjrVTqpEvKpVXLYfxr6nqBNP16RkQopIRrI=

Add an additional and optional control register for setting
the output PWM frequency to 22kHz. The default is 3kHz and
this option puts the operational frequency outside of the
audible range.

Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
---
 drivers/leds/leds-is31fl32xx.c | 47 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/leds-is31fl32xx.c b/drivers/leds/leds-is31fl32xx.c
index 8793330dd4142f49f15d6ee9d87468c08509859f..5ec1ca71f326378e3a714a886260b86002feffa9 100644
--- a/drivers/leds/leds-is31fl32xx.c
+++ b/drivers/leds/leds-is31fl32xx.c
@@ -32,6 +32,8 @@
 #define IS31FL3216_CONFIG_SSD_ENABLE  BIT(7)
 #define IS31FL3216_CONFIG_SSD_DISABLE 0
 
+#define IS31FL32XX_PWM_FREQUENCY_22kHz  0x01
+
 struct is31fl32xx_priv;
 struct is31fl32xx_led_data {
 	struct led_classdev cdev;
@@ -53,6 +55,7 @@ struct is31fl32xx_priv {
  * @pwm_update_reg      : address of PWM Update register
  * @global_control_reg  : address of Global Control register (optional)
  * @reset_reg           : address of Reset register (optional)
+ * @output_frequency_setting_reg: address of output frequency register (optional)
  * @pwm_register_base   : address of first PWM register
  * @pwm_registers_reversed: : true if PWM registers count down instead of up
  * @led_control_register_base : address of first LED control register (optional)
@@ -76,6 +79,7 @@ struct is31fl32xx_chipdef {
 	u8	pwm_update_reg;
 	u8	global_control_reg;
 	u8	reset_reg;
+	u8	output_frequency_setting_reg;
 	u8	pwm_register_base;
 	bool	pwm_registers_reversed;
 	u8	led_control_register_base;
@@ -90,6 +94,19 @@ static const struct is31fl32xx_chipdef is31fl3236_cdef = {
 	.pwm_update_reg				= 0x25,
 	.global_control_reg			= 0x4a,
 	.reset_reg				= 0x4f,
+	.output_frequency_setting_reg		= IS31FL32XX_REG_NONE,
+	.pwm_register_base			= 0x01,
+	.led_control_register_base		= 0x26,
+	.enable_bits_per_led_control_register	= 1,
+};
+
+static const struct is31fl32xx_chipdef is31fl3236a_cdef = {
+	.channels				= 36,
+	.shutdown_reg				= 0x00,
+	.pwm_update_reg				= 0x25,
+	.global_control_reg			= 0x4a,
+	.reset_reg				= 0x4f,
+	.output_frequency_setting_reg		= 0x4b,
 	.pwm_register_base			= 0x01,
 	.led_control_register_base		= 0x26,
 	.enable_bits_per_led_control_register	= 1,
@@ -101,6 +118,7 @@ static const struct is31fl32xx_chipdef is31fl3235_cdef = {
 	.pwm_update_reg				= 0x25,
 	.global_control_reg			= 0x4a,
 	.reset_reg				= 0x4f,
+	.output_frequency_setting_reg		= IS31FL32XX_REG_NONE,
 	.pwm_register_base			= 0x05,
 	.led_control_register_base		= 0x2a,
 	.enable_bits_per_led_control_register	= 1,
@@ -112,6 +130,7 @@ static const struct is31fl32xx_chipdef is31fl3218_cdef = {
 	.pwm_update_reg				= 0x16,
 	.global_control_reg			= IS31FL32XX_REG_NONE,
 	.reset_reg				= 0x17,
+	.output_frequency_setting_reg		= IS31FL32XX_REG_NONE,
 	.pwm_register_base			= 0x01,
 	.led_control_register_base		= 0x13,
 	.enable_bits_per_led_control_register	= 6,
@@ -126,6 +145,7 @@ static const struct is31fl32xx_chipdef is31fl3216_cdef = {
 	.pwm_update_reg				= 0xB0,
 	.global_control_reg			= IS31FL32XX_REG_NONE,
 	.reset_reg				= IS31FL32XX_REG_NONE,
+	.output_frequency_setting_reg		= IS31FL32XX_REG_NONE,
 	.pwm_register_base			= 0x10,
 	.pwm_registers_reversed			= true,
 	.led_control_register_base		= 0x01,
@@ -363,8 +383,21 @@ static struct is31fl32xx_led_data *is31fl32xx_find_led_data(
 static int is31fl32xx_parse_dt(struct device *dev,
 			       struct is31fl32xx_priv *priv)
 {
+	const struct is31fl32xx_chipdef *cdef = priv->cdef;
 	int ret = 0;
 
+	if ((cdef->output_frequency_setting_reg != IS31FL32XX_REG_NONE) &&
+	    of_property_read_bool(dev_of_node(dev), "issi,22kHz-pwm")) {
+
+		ret = is31fl32xx_write(priv, cdef->output_frequency_setting_reg,
+				       IS31FL32XX_PWM_FREQUENCY_22kHz);
+
+		if (ret) {
+			dev_err(dev, "Failed to write output PWM frequency register\n");
+			return ret;
+		}
+	}
+
 	for_each_available_child_of_node_scoped(dev_of_node(dev), child) {
 		struct led_init_data init_data = {};
 		struct is31fl32xx_led_data *led_data =
@@ -404,12 +437,13 @@ static int is31fl32xx_parse_dt(struct device *dev,
 }
 
 static const struct of_device_id of_is31fl32xx_match[] = {
-	{ .compatible = "issi,is31fl3236", .data = &is31fl3236_cdef, },
-	{ .compatible = "issi,is31fl3235", .data = &is31fl3235_cdef, },
-	{ .compatible = "issi,is31fl3218", .data = &is31fl3218_cdef, },
-	{ .compatible = "si-en,sn3218",    .data = &is31fl3218_cdef, },
-	{ .compatible = "issi,is31fl3216", .data = &is31fl3216_cdef, },
-	{ .compatible = "si-en,sn3216",    .data = &is31fl3216_cdef, },
+	{ .compatible = "issi,is31fl3236",  .data = &is31fl3236_cdef, },
+	{ .compatible = "issi,is31fl3236a", .data = &is31fl3236a_cdef, },
+	{ .compatible = "issi,is31fl3235",  .data = &is31fl3235_cdef, },
+	{ .compatible = "issi,is31fl3218",  .data = &is31fl3218_cdef, },
+	{ .compatible = "si-en,sn3218",     .data = &is31fl3218_cdef, },
+	{ .compatible = "issi,is31fl3216",  .data = &is31fl3216_cdef, },
+	{ .compatible = "si-en,sn3216",     .data = &is31fl3216_cdef, },
 	{},
 };
 
@@ -466,6 +500,7 @@ static void is31fl32xx_remove(struct i2c_client *client)
  */
 static const struct i2c_device_id is31fl32xx_id[] = {
 	{ "is31fl3236" },
+	{ "is31fl3236a" },
 	{ "is31fl3235" },
 	{ "is31fl3218" },
 	{ "sn3218" },

-- 
2.48.1



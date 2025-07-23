Return-Path: <linux-kernel+bounces-742250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA26BB0EF26
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 019036C035E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD81D27E079;
	Wed, 23 Jul 2025 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="WKs3JYUQ"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD72928C2B1
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753264941; cv=none; b=Zd+5mb0oushLvkmbvclPgtDu1nWHudweEoEzyGiBc+s5C1kwR0cfDRqvSxaenYjA3xV6DWJQU2bpyZ68lwVeoWmJ4j6kz0nlRG9ecGxiCA3Q8FENnjH1ZeIXDNItknWJHFTt3ydf/SvTFygXqyIbuyYmjPYLvT3sjoio7LXPezw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753264941; c=relaxed/simple;
	bh=X4RB/EqdDISFFUSuCWVjDZVIt5Na2IXaogngEJR9LaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l9RjMF3jWAFlDIaAEp+zBV8vyXO5sMt3hl8gn+vZFV3s/NtNrFlKRDixcPTl0MHPgRCKvaAA7pyk1eglRENqJnUVuAJlIaK/npZVICsWCV82RiCn3ZwikGyHzk4AenWpia1llSiyN4Xpdm81ELGM1dvkWBXs5VEfKFFe2lFCLaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=WKs3JYUQ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45611a6a706so34786445e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1753264936; x=1753869736; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZfYdzfHt38wkKRTaEHNUDVSiTE/Ug90q+HPqIdL9i0=;
        b=WKs3JYUQV4ChxOE7nGpmCJcZqogMPDbRP3ax3lYp0QYIykuZc/8KLC6LwAeaMsgu3K
         7UnSjIHquQ7BH1AtJyLmlBI72UDdE0t0kBlHmJ8kZ8B7gXFHjxeyYna1Jj9tzs29nRyt
         RiO6MRtmpxY/c0pcHh55miIFHeNwqpGT1mNrI7CeMes5gNS7DWpjwNFtXjLRydq6toV8
         b88C6EBBT5JIbFaSjdXkah+TLmvlPs24ANOuYk4S/+T9w16MUszwTjTkgeWqFK5bbAGZ
         RbY2X+/5QMf2Sex6o4rHGuNbZe5ee7ObYlXKPgYQd+rwgDEZYhmGOqEWTT91X8uG6FaY
         cZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753264936; x=1753869736;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZfYdzfHt38wkKRTaEHNUDVSiTE/Ug90q+HPqIdL9i0=;
        b=ujSWFJiOW84AZBUUEpTAkfgaxGoKtR+10ZIQWIjcomxbVK01tKaBfuffkhmMOKoc7l
         sHgtDKh4ECVbGnSMD89lrpM2hRYbPFEhipRCPxqRG9tFxNg6uagwuSIydEbxKQU2dPAX
         v+l0ALqjvY0mOYB0lhnIqYHmKxwB2fDiJs32xpWKQaLNfRQ71Q8scMssx109VKRCTl7Z
         Bfd5/JU6c7wJ6B3hTnAABaNnSB0R+jOAbkl8FqdrHpVxKuNyhkSz+jOwhmE4+8ExoHZ5
         gqQKk3yFrgk347PsQEsDLlwNQMmbcVryZnuDTc2hGCky+QOE5D/VjKg6CPyO0iDDKUxr
         t9sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwxkcj2Oq8JI304UNEzSKugLbY3d1uLtQa4IL0PyLIiDfR3KLmBTpX8IYpaSBRHwf5ve0mj8LVeH2rgDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmQnrwPYIPk+LOX+loVaSAGCVXVRHJKO317XBGXexbG9yOqpzE
	F7LTTMlKkKI9rDOO/8Sq638X7guzTV7/z1ziXMGg/Eiql3KK/AgDjUWyRuuZGco8GUY=
X-Gm-Gg: ASbGncvqLrUxxWy8oiGfGo1E+xFc86yd+z0MZsmKJiOOKo20lvPnFazM0Cipdax+YOR
	fmHsuPpED+aiRqMSJ8FQFBy20cESiN9tN175PwIhDVS2v31KjGgEmGCJWaOyAIGe1UD1mlOrU3G
	/psFjGgIMyyZpT8BSeRD/RTg317ldZrkzguy2kf6RUbxdZJ+DqKyijpxKoZoxeLKM8VQGZ0HAa9
	TwbNCuYG4UEymAW8gA4SREw9EXfSKbgkC46yzbcvjTaLr41s4N6XTpUw6Rv4YDSyczCDNYUBYNs
	hSLqjtS3D8zxDVGnM0zPIwllMrI+D8tOH5XE1WKX3+v2brvQ77B+ub8kZPkpRNDmWQJbjABQ+zH
	omb3ZGLZQUTxa+wfv8RPQn6ZvL6ibGUqeYy4WTg==
X-Google-Smtp-Source: AGHT+IFG00Ka7dTTXqD5R72xnTJ1FgjEk2W34dnzJ7eV8qjczJLkCd3qHfafX0BnqVEz8vMVuYSrkQ==
X-Received: by 2002:a05:600c:3107:b0:440:6a79:6df0 with SMTP id 5b1f17b1804b1-45868d2c693mr14672425e9.22.1753264936189;
        Wed, 23 Jul 2025 03:02:16 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c7:1d1a:9c01:6066:6737:c27:90a6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca31394sm15930793f8f.37.2025.07.23.03.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 03:02:15 -0700 (PDT)
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Wed, 23 Jul 2025 11:02:08 +0100
Subject: [PATCH v6 3/3] leds/leds-is31fl32xx: add support for is31fl3236a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-leds-is31fl3236a-v6-3-210328058625@thegoodpenguin.co.uk>
References: <20250723-leds-is31fl3236a-v6-0-210328058625@thegoodpenguin.co.uk>
In-Reply-To: <20250723-leds-is31fl3236a-v6-0-210328058625@thegoodpenguin.co.uk>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Pavel Machek <pavel@ucw.cz>, devicetree@vger.kernel.org, 
 Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753264931; l=5531;
 i=pzalewski@thegoodpenguin.co.uk; s=20250625; h=from:subject:message-id;
 bh=X4RB/EqdDISFFUSuCWVjDZVIt5Na2IXaogngEJR9LaM=;
 b=osBH6/HI1wRntHwW6t4fGMXMNUBccGGwzkGcNtaDNJfFf58F5Tw3iubILCajoCGDhA22rbET0
 jR56yYMXa2YAKOPZhhknm9UZGdILft2L6szjIDoHWDW/1PtEGedF56T
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
index 8793330dd4142f49f15d6ee9d87468c08509859f..dc9349f9d3501b179af493e0c877ec7b27a78157 100644
--- a/drivers/leds/leds-is31fl32xx.c
+++ b/drivers/leds/leds-is31fl32xx.c
@@ -32,6 +32,8 @@
 #define IS31FL3216_CONFIG_SSD_ENABLE  BIT(7)
 #define IS31FL3216_CONFIG_SSD_DISABLE 0
 
+#define IS31FL32XX_PWM_FREQUENCY_22KHZ  0x01
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
+	    of_property_read_bool(dev_of_node(dev), "issi,22khz-pwm")) {
+
+		ret = is31fl32xx_write(priv, cdef->output_frequency_setting_reg,
+				       IS31FL32XX_PWM_FREQUENCY_22KHZ);
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



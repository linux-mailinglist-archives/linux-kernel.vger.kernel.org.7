Return-Path: <linux-kernel+bounces-756551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5BEB1B5F1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E1D1890BA1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F8C279DBA;
	Tue,  5 Aug 2025 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="Ov9NjMw+"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E30277CB4;
	Tue,  5 Aug 2025 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754402514; cv=pass; b=cbWm6Wnw95vA3+LszhnXTxuj/SxHMJLi4mEYGq054KQT1k7kcbTHxC1AHSox5DRedAcL2CZvzZZv2KuatKCrUz8mbJB4+U3MxFQr7iV4cURXGKzOWTldSxdhT/b8Lmu0B9/urelLr+nElu3iEAiBbmzFdq6lrucEfRS6XkPKcGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754402514; c=relaxed/simple;
	bh=pb5l6V6MFgw+c2S3rC/qDHjKOTeDwdBvVTPGOtWjD2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ka0XytoRb/7iCG7TPbznCpiZVBQTVcg1/NWKvZo6mNRHAlo71GgRWx1XgBceTc0hjqOjB5NPsIsgtVAgMmgZWmlYEpr8cT+t8Y11Vq5X/eesWIKenykzcp8IxDwhegf/sJ62YL1quPnsmKXgn56Pwwp55gZ/rRHUDTTPlzvrqXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=Ov9NjMw+; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1754402500; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TqthBYFwMrCDJPeeiFn5g4s/vHWV8+JcqwHfrG6SwILS/xeYdDGVV3F4U2/9EjSwjRUckNPp4hKahNVQ2FPahoBiZYJQ9CV5rrYb+3/gmgA5sGEgw7Qorm4FJy+kGivYoQhqjJ5O2oLCYim5ru1Gc8YBHfdpxbnKTKNZ1+eyKNU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754402500; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=szgFRyrHBEXhnRIBZfTrku2yCNERmg+BCSoHdLQuY5U=; 
	b=bq5eHCstPqYk+NrAw1cr+WzMWQNF5yFxN5aCzlP3D3V/wGtkt1NmaQMl5Bg+797wV2hij+52r+VpluACRtgCohuLzRvTwJ5ziMMvb2loc4DsIaO/S7ow3l/2+7FgEfaHMotUl9SXC+kW7Ydw9XODDbD8gtrJbvRo+txATkqbYew=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754402500;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=szgFRyrHBEXhnRIBZfTrku2yCNERmg+BCSoHdLQuY5U=;
	b=Ov9NjMw+UCN+g9LrWDGAP3pQU28eajQOiHx912t0jwTLYufOMmOn3NnfN7NaLlKC
	/pub1VH5KZIIXDBlgBE2g2M90LfIJ0cp3d20Y746uLORuLzvqLlpVXEpmTqRPRiEbh5
	eeSH8EzK43q4Xzn6vexRae8dZSonlDOW5fwrM9Wg=
Received: by mx.zohomail.com with SMTPS id 1754402497801370.09200921968306;
	Tue, 5 Aug 2025 07:01:37 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
To: Ike Panhc <ikepanhc@gmail.com>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: Rong Zhang <i@rong.moe>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] platform/x86: ideapad-laptop: Decouple HW & cdev brightness for kbd backlight
Date: Tue,  5 Aug 2025 22:01:28 +0800
Message-ID: <20250805140131.284122-2-i@rong.moe>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250805140131.284122-1-i@rong.moe>
References: <20250805140131.284122-1-i@rong.moe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Some recent models come with an ambient light sensor (ALS). On these
models, their EC will automatically set the keyboard backlight to an
appropriate brightness when the effective "HW brightness" is 3. The term
"HW brightness" means that it cannot be perfectly mapped to an LED
classdev brightness, but the EC does use this predefined brightness
value to represent such a mode.

Currently, the code processing keyboard backlight is coupled with LED
classdev, making it hard to expose the auto brightness (ALS) mode to the
userspace.

As the first step toward the goal, decouple HW brightness from LED
classdev brightness, and update comments about corresponding backlight
modes.

Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/platform/x86/lenovo/ideapad-laptop.c | 125 +++++++++++++------
 1 file changed, 90 insertions(+), 35 deletions(-)

diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.c b/drivers/platform/x86/lenovo/ideapad-laptop.c
index fcebfbaf0460..5014c1d0b633 100644
--- a/drivers/platform/x86/lenovo/ideapad-laptop.c
+++ b/drivers/platform/x86/lenovo/ideapad-laptop.c
@@ -119,17 +119,40 @@ enum {
 };
 
 /*
- * These correspond to the number of supported states - 1
- * Future keyboard types may need a new system, if there's a collision
- * KBD_BL_TRISTATE_AUTO has no way to report or set the auto state
- * so it effectively has 3 states, but needs to handle 4
+ * The enumeration has two purposes:
+ *   - as an internal identifier for all known types of keyboard backlight
+ *   - as a mandatory parameter of the KBLC command
+ *
+ * For each type, the HW brightness values are defined as follows:
+ * +--------------------------+----------+-----+------+------+
+ * |            HW brightness |        0 |   1 |    2 |    3 |
+ * | Type                     |          |     |      |      |
+ * +--------------------------+----------+-----+------+------+
+ * | KBD_BL_STANDARD          |      off |  on |  N/A |  N/A |
+ * +--------------------------+----------+-----+------+------+
+ * | KBD_BL_TRISTATE          |      off | low | high |  N/A |
+ * +--------------------------+----------+-----+------+------+
+ * | KBD_BL_TRISTATE_AUTO     |      off | low | high | auto |
+ * +--------------------------+----------+-----+------+------+
+ *
+ * We map LED classdev brightness for KBD_BL_TRISTATE_AUTO as follows:
+ * +--------------------------+----------+-----+------+
+ * |  LED classdev brightness |        0 |   1 |    2 |
+ * | Operation                |          |     |      |
+ * +--------------------------+----------+-----+------+
+ * | Read                     | off/auto | low | high |
+ * +--------------------------+----------+-----+------+
+ * | Write                    |      off | low | high |
+ * +--------------------------+----------+-----+------+
  */
 enum {
-	KBD_BL_STANDARD      = 1,
-	KBD_BL_TRISTATE      = 2,
-	KBD_BL_TRISTATE_AUTO = 3,
+	KBD_BL_STANDARD		=	1,
+	KBD_BL_TRISTATE		=	2,
+	KBD_BL_TRISTATE_AUTO	=	3,
 };
 
+#define KBD_BL_AUTO_MODE_HW_BRIGHTNESS	3
+
 #define KBD_BL_QUERY_TYPE		0x1
 #define KBD_BL_TRISTATE_TYPE		0x5
 #define KBD_BL_TRISTATE_AUTO_TYPE	0x7
@@ -1559,7 +1582,25 @@ static int ideapad_kbd_bl_check_tristate(int type)
 	return (type == KBD_BL_TRISTATE) || (type == KBD_BL_TRISTATE_AUTO);
 }
 
-static int ideapad_kbd_bl_brightness_get(struct ideapad_private *priv)
+static int ideapad_kbd_bl_brightness_parse(struct ideapad_private *priv,
+					   unsigned int hw_brightness)
+{
+	/* Off, low or high */
+	if (hw_brightness <= priv->kbd_bl.led.max_brightness)
+		return hw_brightness;
+
+	/* Auto (controlled by EC according to ALS), report as off */
+	if (priv->kbd_bl.type == KBD_BL_TRISTATE_AUTO &&
+	    hw_brightness == KBD_BL_AUTO_MODE_HW_BRIGHTNESS)
+		return 0;
+
+	/* Unknown value */
+	dev_warn(&priv->platform_device->dev,
+		 "Unknown keyboard backlight value: %u", hw_brightness);
+	return -EINVAL;
+}
+
+static int ideapad_kbd_bl_hw_brightness_get(struct ideapad_private *priv)
 {
 	unsigned long value;
 	int err;
@@ -1573,21 +1614,7 @@ static int ideapad_kbd_bl_brightness_get(struct ideapad_private *priv)
 		if (err)
 			return err;
 
-		/* Convert returned value to brightness level */
-		value = FIELD_GET(KBD_BL_GET_BRIGHTNESS, value);
-
-		/* Off, low or high */
-		if (value <= priv->kbd_bl.led.max_brightness)
-			return value;
-
-		/* Auto, report as off */
-		if (value == priv->kbd_bl.led.max_brightness + 1)
-			return 0;
-
-		/* Unknown value */
-		dev_warn(&priv->platform_device->dev,
-			 "Unknown keyboard backlight value: %lu", value);
-		return -EINVAL;
+		return FIELD_GET(KBD_BL_GET_BRIGHTNESS, value);
 	}
 
 	err = eval_hals(priv->adev->handle, &value);
@@ -1597,6 +1624,16 @@ static int ideapad_kbd_bl_brightness_get(struct ideapad_private *priv)
 	return !!test_bit(HALS_KBD_BL_STATE_BIT, &value);
 }
 
+static int ideapad_kbd_bl_brightness_get(struct ideapad_private *priv)
+{
+	int hw_brightness = ideapad_kbd_bl_hw_brightness_get(priv);
+
+	if (hw_brightness < 0)
+		return hw_brightness;
+
+	return ideapad_kbd_bl_brightness_parse(priv, hw_brightness);
+}
+
 static enum led_brightness ideapad_kbd_bl_led_cdev_brightness_get(struct led_classdev *led_cdev)
 {
 	struct ideapad_private *priv = container_of(led_cdev, struct ideapad_private, kbd_bl.led);
@@ -1604,24 +1641,37 @@ static enum led_brightness ideapad_kbd_bl_led_cdev_brightness_get(struct led_cla
 	return ideapad_kbd_bl_brightness_get(priv);
 }
 
-static int ideapad_kbd_bl_brightness_set(struct ideapad_private *priv, unsigned int brightness)
+static int ideapad_kbd_bl_hw_brightness_set(struct ideapad_private *priv,
+					    unsigned int hw_brightness)
 {
 	int err;
 	unsigned long value;
 	int type = priv->kbd_bl.type;
 
 	if (ideapad_kbd_bl_check_tristate(type)) {
-		if (brightness > priv->kbd_bl.led.max_brightness)
-			return -EINVAL;
-
-		value = FIELD_PREP(KBD_BL_SET_BRIGHTNESS, brightness) |
+		value = FIELD_PREP(KBD_BL_SET_BRIGHTNESS, hw_brightness) |
 			FIELD_PREP(KBD_BL_COMMAND_TYPE, type) |
 			KBD_BL_COMMAND_SET;
 		err = exec_kblc(priv->adev->handle, value);
 	} else {
-		err = exec_sals(priv->adev->handle, brightness ? SALS_KBD_BL_ON : SALS_KBD_BL_OFF);
+		err = exec_sals(priv->adev->handle,
+				hw_brightness ? SALS_KBD_BL_ON : SALS_KBD_BL_OFF);
 	}
 
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int ideapad_kbd_bl_brightness_set(struct ideapad_private *priv, unsigned int brightness)
+{
+	int err;
+
+	if (brightness > priv->kbd_bl.led.max_brightness)
+		return -EINVAL;
+
+	err = ideapad_kbd_bl_hw_brightness_set(priv, brightness);
 	if (err)
 		return err;
 
@@ -1638,6 +1688,16 @@ static int ideapad_kbd_bl_led_cdev_brightness_set(struct led_classdev *led_cdev,
 	return ideapad_kbd_bl_brightness_set(priv, brightness);
 }
 
+static void ideapad_kbd_bl_notify_known(struct ideapad_private *priv, unsigned int brightness)
+{
+	if (brightness == priv->kbd_bl.last_brightness)
+		return;
+
+	priv->kbd_bl.last_brightness = brightness;
+
+	led_classdev_notify_brightness_hw_changed(&priv->kbd_bl.led, brightness);
+}
+
 static void ideapad_kbd_bl_notify(struct ideapad_private *priv)
 {
 	int brightness;
@@ -1649,12 +1709,7 @@ static void ideapad_kbd_bl_notify(struct ideapad_private *priv)
 	if (brightness < 0)
 		return;
 
-	if (brightness == priv->kbd_bl.last_brightness)
-		return;
-
-	priv->kbd_bl.last_brightness = brightness;
-
-	led_classdev_notify_brightness_hw_changed(&priv->kbd_bl.led, brightness);
+	ideapad_kbd_bl_notify_known(priv, brightness);
 }
 
 static int ideapad_kbd_bl_init(struct ideapad_private *priv)
-- 
2.50.1



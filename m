Return-Path: <linux-kernel+bounces-721299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3F4AFC74A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1143A928F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6642641C8;
	Tue,  8 Jul 2025 09:44:57 +0000 (UTC)
Received: from n169-114.mail.139.com (n169-114.mail.139.com [120.232.169.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC2179CF;
	Tue,  8 Jul 2025 09:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751967897; cv=none; b=jYY0aOhasaI02w4tngkekY3tG5TA2TofcRdMCVwD8PkAKgYEl09U9g5G2NvgPH4OMk1hYkzyDwhF/1eFmJTxHbL1tFwxnwJRuimyE9fB4PJPnv8HYlbsa9myDmC2tjxkIjfSBKGlZjYKoU/UrQ4guMsAxbPN3RcTx3Utpn8AmKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751967897; c=relaxed/simple;
	bh=rjoGb4QYUa8g4YTR1lLJbpA0zCVoViTj52sglYfLdYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IJEkue5xySAkSCYY8t7f5h08hw/NcGraLxG05dy28ewGDQItL9jFWFzseMk5LTHYBa2ukylinchqyv7abEFJxIJXDnp+8b4wIUfY8meLJL803xji+iQQjyfvUTCItL70fjgp1xVDTEWHmHJdCjsPswgXY/YU+BgujxhJy5VX/00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; arc=none smtp.client-ip=120.232.169.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from yoga-Lenovo-Slim-Pro-7-14APH8.lenovo.com (unknown[106.38.209.7])
	by rmsmtp-lg-appmail-42-12056 (RichMail) with SMTP id 2f18686ce88523b-b9f71;
	Tue, 08 Jul 2025 17:44:48 +0800 (CST)
X-RM-TRANSID:2f18686ce88523b-b9f71
From: Jackie Dong <xy-jackie@139.com>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dongeg1@lenovo.com,
	Jackie Dong <xy-jackie@139.com>
Subject: [PATCH v3] lenovo-wmi-hotkey: Fixed a kernel error report for some Lenovo non-ThinkPad devices
Date: Tue,  8 Jul 2025 17:43:05 +0800
Message-ID: <20250708094352.26850-1-xy-jackie@139.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Not all of Lenovo non-ThinkPad devices support both mic mute LED (on F4)
and audio mute LED (on F1). Some of them only support one mute LED, some
of them don't have any mute LED. Add a decision to judge this device
support mute LED or not. Without this decision, not support both of mic
mute LED and audio mute LED Lenovo non-ThinkPad brand devices (including
Ideapad/Yoga/Xiaoxin/Gaming/ThinkBook, etc.) will report a failed message
with error -5.

Signed-off-by: Jackie Dong <xy-jackie@139.com>
Suggested-by: Hans de Goede <hansg@kernel.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

---
Changes in v3:
 - Reverse orignal logic  (obj && obj->type == ACPI_TYPE_INTEGER) 
   and add new decision for led_version == 0.
 - Optimize the descriptions based on reviewer comments.

Changes in v2:
 - Add warning message and then return 0 if the device support mute LED
   abnormaly, based on Hans suggestion and Armin previous patch.


 .../x86/lenovo-wmi-hotkey-utilities.c         | 24 ++++++++++++++-----
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c b/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
index 89153afd7015..1850992f2ea8 100644
--- a/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
+++ b/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
@@ -127,21 +127,30 @@ static int lenovo_super_hotkey_wmi_led_init(enum mute_led_type led_type, struct
 	else
 		return -EIO;
 
-	wpriv->cdev[led_type].max_brightness = LED_ON;
-	wpriv->cdev[led_type].flags = LED_CORE_SUSPENDRESUME;
+	/*
+	 * Output parameters define: 0 means mute LED is not supported, Non-zero means
+	 * mute LED can be supported.
+	 */
+	if (led_version == 0)
+		return 0;
+
 
 	switch (led_type) {
 	case MIC_MUTE:
-		if (led_version != WMI_LUD_SUPPORT_MICMUTE_LED_VER)
-			return -EIO;
+		if (led_version != WMI_LUD_SUPPORT_MICMUTE_LED_VER) {
+			pr_warn("The MIC_MUTE LED of this device isn't supported now.\n");
+			return 0;
+		}
 
 		wpriv->cdev[led_type].name = "platform::micmute";
 		wpriv->cdev[led_type].brightness_set_blocking = &lsh_wmi_micmute_led_set;
 		wpriv->cdev[led_type].default_trigger = "audio-micmute";
 		break;
 	case AUDIO_MUTE:
-		if (led_version != WMI_LUD_SUPPORT_AUDIOMUTE_LED_VER)
-			return -EIO;
+		if (led_version != WMI_LUD_SUPPORT_AUDIOMUTE_LED_VER) {
+			pr_warn("The AUDIO_MUTE LED of this device isn't supported now.\n");
+			return 0;
+		}
 
 		wpriv->cdev[led_type].name = "platform::mute";
 		wpriv->cdev[led_type].brightness_set_blocking = &lsh_wmi_audiomute_led_set;
@@ -152,6 +161,9 @@ static int lenovo_super_hotkey_wmi_led_init(enum mute_led_type led_type, struct
 		return -EINVAL;
 	}
 
+	wpriv->cdev[led_type].max_brightness = LED_ON;
+	wpriv->cdev[led_type].flags = LED_CORE_SUSPENDRESUME;
+
 	err = devm_led_classdev_register(dev, &wpriv->cdev[led_type]);
 	if (err < 0) {
 		dev_err(dev, "Could not register mute LED %d : %d\n", led_type, err);
-- 
2.43.0




Return-Path: <linux-kernel+bounces-722768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 191F2AFDE9D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 05:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66A8E168F7C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 03:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF50423ABB3;
	Wed,  9 Jul 2025 03:57:44 +0000 (UTC)
Received: from n169-113.mail.139.com (n169-113.mail.139.com [120.232.169.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F274D3208;
	Wed,  9 Jul 2025 03:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752033464; cv=none; b=d+Y2OLTrdtSQvKkWtTtNVTHG2wz/3xmwE6B4VGF9UdycX0k0I+61izOdJqi2k2T8X7jqk3ELq/NoM1PGwkDSF4Vn661o9dXPmHYNq9GXFih3DoVnK1OdThtOUXgJ1E1xThrWVP8K96i2rf2NsZGNmIgsD8ymNmTbUK76vWTDD0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752033464; c=relaxed/simple;
	bh=lQwQf+B5aXKPxLLXxnKWcS15+Ho9bEWwDpexYnBX73s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MMXw/Gnb6SVFyP6DLpSLAzS0+mtrF9cd+8JZFxuhLg8ZBrFPxPcLFSAX3XtoSCocNNUCZXLwalNS4sypKvyDhiiVNBiJUQZHGmrfWDDS/2EXeEhNrNz4jA6bXDXjzg7d6OMSvvtVWJLwZqewSfaIjLs389Y/pa1zlgjd/N/QXmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; arc=none smtp.client-ip=120.232.169.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from yoga-Lenovo-Slim-Pro-7-14APH8.lenovo.com (unknown[106.38.209.7])
	by rmsmtp-lg-appmail-32-12046 (RichMail) with SMTP id 2f0e686de8a539c-ca1a9;
	Wed, 09 Jul 2025 11:57:32 +0800 (CST)
X-RM-TRANSID:2f0e686de8a539c-ca1a9
From: Jackie Dong <xy-jackie@139.com>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dongeg1@lenovo.com,
	Jackie Dong <xy-jackie@139.com>
Subject: [PATCH v4] lenovo-wmi-hotkey: Fixed a kernel bug failed with error -5
Date: Wed,  9 Jul 2025 11:57:16 +0800
Message-ID: <20250709035716.36267-1-xy-jackie@139.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

---
Changes in v4:
 - Simplify the logic code as (!obj || obj->type != ACPI_TYPE_INTEGER).
 - Drop "now" of the warning messages.

Changes in v3:
 - Reverse orignal logic  (obj && obj->type == ACPI_TYPE_INTEGER)
   and add new decision for (led_version == 0).
 - Optimize the descriptions based on reviewer comments.

Changes in v2:
 - Add warning message and then return 0 if the device support mute LED
   abnormaly, based on Hans suggestion and Armin previous patch.

---
 .../x86/lenovo-wmi-hotkey-utilities.c         | 30 +++++++++++++------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c b/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
index 89153afd7015..7b9bad1978ff 100644
--- a/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
+++ b/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
@@ -122,26 +122,35 @@ static int lenovo_super_hotkey_wmi_led_init(enum mute_led_type led_type, struct
 		return -EIO;
 
 	union acpi_object *obj __free(kfree) = output.pointer;
-	if (obj && obj->type == ACPI_TYPE_INTEGER)
-		led_version = obj->integer.value;
-	else
+	if (!obj || obj->type != ACPI_TYPE_INTEGER)
 		return -EIO;
 
-	wpriv->cdev[led_type].max_brightness = LED_ON;
-	wpriv->cdev[led_type].flags = LED_CORE_SUSPENDRESUME;
+	led_version = obj->integer.value;
+
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
+			pr_warn("The MIC_MUTE LED of this device isn't supported.\n");
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
+			pr_warn("The AUDIO_MUTE LED of this device isn't supported.\n");
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




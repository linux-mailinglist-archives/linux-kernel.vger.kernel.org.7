Return-Path: <linux-kernel+bounces-721034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8E2AFC3D3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 029BF3A5605
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F26298241;
	Tue,  8 Jul 2025 07:16:15 +0000 (UTC)
Received: from n169-111.mail.139.com (n169-111.mail.139.com [120.232.169.111])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6EB2951BA;
	Tue,  8 Jul 2025 07:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751958975; cv=none; b=PhKuRTz/t37eWnzcAOTSQBaZR9Ci0w05H4VtUbpEh5/bcje+t4xYB85k2hwjPoDMRX6RMdHSh4fuCv4ssjd3dFXx4TUpktPt+4DMSEzBvn7ZfqpsiB+gq+u5zjX0iiUtrK0W7VYytFy67ux3yAeCtrvQO7F1Tcf4up/djQT5COU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751958975; c=relaxed/simple;
	bh=WiOjYZ4uaICssgxF1b4ANmuRajVsuaenIVMaQGHeABo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kcoObqrY75mWv7kygXN42DLfSPkbacz4NG6GpBuoe1qBudVBWD0p7jX7iK0AeRYxG9w7LpXP3MGzhY5utSjaV5hLkDHIM4GTxC157eTVOgYRV2eSQEqHdcUewB4bIZ6Wb5dCEUVU+P5xQF/DV895AJavaUePXG1cN1vAl2ypEXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; arc=none smtp.client-ip=120.232.169.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from yoga-Lenovo-Slim-Pro-7-14APH8.lenovo.com (unknown[106.38.209.7])
	by rmsmtp-lg-appmail-17-12016 (RichMail) with SMTP id 2ef0686cc4edc54-bf959;
	Tue, 08 Jul 2025 15:12:57 +0800 (CST)
X-RM-TRANSID:2ef0686cc4edc54-bf959
From: Jackie Dong <xy-jackie@139.com>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dongeg1@lenovo.com,
	Jackie Dong <xy-jackie@139.com>
Subject: [PATCH v2] lenovo-wmi-hotkey: Fixed a kernel error report for
Date: Tue,  8 Jul 2025 15:11:38 +0800
Message-ID: <20250708071138.15602-1-xy-jackie@139.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not all of Lenovo non-ThinkPad devices support both mic mute LED(on F4)
and audio mute LED(on F1). Some of them only support one mute LED, some
of them don't have any mute LED. Add a decision to judge this device
support mute LED or not. Without this decision, not support both of mic
mute LED and audio mute LED Lenovo non-ThinkPad brand devices (including
Ideapad/Yoga/Xiaoxin/Gaming/ThinkBook, etc.) will report a failed message
with error -5.

Signed-off-by: Jackie Dong <xy-jackie@139.com>
Suggested-by: Hans de Goede <hansg@kernel.org>

---
Changes in v2:
 - Add warning message and then return 0 if the device support mute LED 
   abnormaly, based on Hans suggestion and Armin previous patch. 

 .../x86/lenovo-wmi-hotkey-utilities.c         | 30 +++++++++++++------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c b/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
index 89153afd7015..334c12f2896d 100644
--- a/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
+++ b/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
@@ -122,26 +122,35 @@ static int lenovo_super_hotkey_wmi_led_init(enum mute_led_type led_type, struct
 		return -EIO;
 
 	union acpi_object *obj __free(kfree) = output.pointer;
-	if (obj && obj->type == ACPI_TYPE_INTEGER)
+	if (obj && obj->type == ACPI_TYPE_INTEGER) {
 		led_version = obj->integer.value;
-	else
-		return -EIO;
 
-	wpriv->cdev[led_type].max_brightness = LED_ON;
-	wpriv->cdev[led_type].flags = LED_CORE_SUSPENDRESUME;
+		/*
+		 * Output parameters define: 0 means mute LED is not supported, Non-zero means
+		 * mute LED can be supported.
+		 */
+		if (led_version == 0)
+			return 0;
+	} else {
+		return -EIO;
+	}
 
 	switch (led_type) {
 	case MIC_MUTE:
-		if (led_version != WMI_LUD_SUPPORT_MICMUTE_LED_VER)
-			return -EIO;
+		if (led_version != WMI_LUD_SUPPORT_MICMUTE_LED_VER) {
+			pr_warn("This device MIC_MUTE LED doesn't support now.\n");
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
+			pr_warn("This device AUDIO_MUTE LED doesn't support now.\n");
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




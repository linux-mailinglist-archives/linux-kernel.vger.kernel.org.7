Return-Path: <linux-kernel+bounces-756552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AC3B1B5EC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 714B3168F51
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D581127A12D;
	Tue,  5 Aug 2025 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="iudBfvHW"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5195E2798EF;
	Tue,  5 Aug 2025 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754402516; cv=pass; b=i/yWMfAuvmY3/pkQL5PCxNzxgSPp8cXuFwE4TjI2VLibIPxBo5fqy2fHrfrritg8hobPfYkRT3LOf0kI6o7P9igbxivTlXTLrbpB9TlltMgaElw6QQaGJQKqv11wVyBevOtRKtPdYEC1Sf0qEWxYUmklLBx0ARy6eWS1DGStQpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754402516; c=relaxed/simple;
	bh=XIxQxnU0xVK+cxhZrdEdccN8S9oUSm9/ytnvIqa1W5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uyjYM6PC1CHtKun2ZFThna8tP1NeOEc/sTmp2Qye966mxymAS5dOq+IaOs982b5y1sRVw1+B+87Hh24IAuUwk6nxqYmCBUnO1BBTuZV17mcmf9cwwbmbioVz55X6D30JzPi8dfeNmbBr2pdBeKBlqtGTeMF/ehYCJBR3LPicb6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=iudBfvHW; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1754402504; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CPAhJ38echNu7NwuPSApJAYpsp9NQZFeP6B8agGEyv3JJrK0NPCEV/mDledoyhdyTN4R1px0fheXhKL8Gt0C3DBUf4f3XToc24utZTrrfgj80SRTmQglyG4DzFSz3zcnmfPKxg8G2Fvnyb0l/zmKalbB0JN21bXsUUiaX7XfJTo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754402504; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KLD0agmNAMnmyf27fVCPlQIUAQ3zVBfhyAEJ7jRU07s=; 
	b=gxcmsucE2vkOHciHnD5SE8TBOTmjdjLKlWyEF3vol7yi0MBavywe9HLBqr11lMw0DwRlFULJMq+jV17MOIgA7cXVEt9E/bWL38G8dMngspiYqiNJNG7cgnggoqDuHkSc0i8TGNiqONFyXlGLVJ5aPOWwJO0B+CFJfFNjIwU2zfg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754402504;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=KLD0agmNAMnmyf27fVCPlQIUAQ3zVBfhyAEJ7jRU07s=;
	b=iudBfvHWAuxuejX+Fs8hxlwJBf4vuchRVGJ1X4BCpRSBsCxCJGw/2eid2T9KjPgN
	lCo+j5jYO4vehWyhPSp9yqVXhKzEDvPuJby6cB0tLdb7q17SoW0eUq8Y0cELrrNmvEc
	4zSDfFrm5WKHBXZ5G7MZhvcKr7w+eIX+CBE8cXe0=
Received: by mx.zohomail.com with SMTPS id 1754402502071948.9728883893175;
	Tue, 5 Aug 2025 07:01:42 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
To: Ike Panhc <ikepanhc@gmail.com>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: Rong Zhang <i@rong.moe>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] platform/x86: ideapad-laptop: Fully support auto kbd backlight
Date: Tue,  5 Aug 2025 22:01:29 +0800
Message-ID: <20250805140131.284122-3-i@rong.moe>
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

Currently, the auto brightness mode of keyboard backlight maps to
brightness=0 in LED classdev. The only method to switch to such a mode
is by pressing the manufacturer-defined shortcut (Fn+Space). However, 0
is a multiplexed brightness value; writing 0 simply results in the
backlight being turned off.

With brightness processing code decoupled from LED classdev, we can now
fully support the auto brightness mode. In this mode, the keyboard
backlight is controlled by the EC according to the ambient light sensor
(ALS).

To utilize this, a sysfs node is exposed to the userspace:
/sys/class/leds/platform::kbd_backlight/als_enabled. The name is chosen
to align with dell-laptop, which provides a similar feature.

Signed-off-by: Rong Zhang <i@rong.moe>
---
 .../ABI/testing/sysfs-platform-ideapad-laptop | 12 ++++
 drivers/platform/x86/lenovo/ideapad-laptop.c  | 65 ++++++++++++++++++-
 2 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-ideapad-laptop b/Documentation/ABI/testing/sysfs-platform-ideapad-laptop
index 5ec0dee9e707..a2b78aa60aaa 100644
--- a/Documentation/ABI/testing/sysfs-platform-ideapad-laptop
+++ b/Documentation/ABI/testing/sysfs-platform-ideapad-laptop
@@ -50,3 +50,15 @@ Description:
 		Controls whether the "always on USB charging" feature is
 		enabled or not. This feature enables charging USB devices
 		even if the computer is not turned on.
+
+What:		/sys/class/leds/platform::kbd_backlight/als_enabled
+Date:		July 2025
+KernelVersion:	6.17
+Contact:	platform-driver-x86@vger.kernel.org
+Description:
+		This file allows to control the automatic keyboard
+		illumination mode on some systems that have an ambient
+		light sensor. Write 1 to this file to enable the auto
+		mode, 0 to disable it. In this mode, the actual
+		brightness level is not available and reading the
+		"brightness" file always returns 0.
diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.c b/drivers/platform/x86/lenovo/ideapad-laptop.c
index 5014c1d0b633..49f2fc68add4 100644
--- a/drivers/platform/x86/lenovo/ideapad-laptop.c
+++ b/drivers/platform/x86/lenovo/ideapad-laptop.c
@@ -1712,6 +1712,57 @@ static void ideapad_kbd_bl_notify(struct ideapad_private *priv)
 	ideapad_kbd_bl_notify_known(priv, brightness);
 }
 
+static ssize_t als_enabled_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+	struct ideapad_private *priv = container_of(led_cdev, struct ideapad_private, kbd_bl.led);
+	int hw_brightness;
+
+	hw_brightness = ideapad_kbd_bl_hw_brightness_get(priv);
+	if (hw_brightness < 0)
+		return hw_brightness;
+
+	return sysfs_emit(buf, "%d\n", hw_brightness == KBD_BL_AUTO_MODE_HW_BRIGHTNESS);
+}
+
+static ssize_t als_enabled_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+	struct ideapad_private *priv = container_of(led_cdev, struct ideapad_private, kbd_bl.led);
+	bool state;
+	int err;
+
+	err = kstrtobool(buf, &state);
+	if (err)
+		return err;
+
+	/*
+	 * Auto (ALS) mode uses a predefined HW brightness value. It is
+	 * impossible to disable it without setting another brightness value.
+	 * Set the brightness to 0 when disabling is requested.
+	 */
+	err = ideapad_kbd_bl_hw_brightness_set(priv, state ? KBD_BL_AUTO_MODE_HW_BRIGHTNESS : 0);
+	if (err)
+		return err;
+
+	/* Both HW brightness values map to 0 in the LED classdev. */
+	ideapad_kbd_bl_notify_known(priv, 0);
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(als_enabled);
+
+static struct attribute *ideapad_kbd_bl_als_attrs[] = {
+	&dev_attr_als_enabled.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(ideapad_kbd_bl_als);
+
 static int ideapad_kbd_bl_init(struct ideapad_private *priv)
 {
 	int brightness, err;
@@ -1722,10 +1773,20 @@ static int ideapad_kbd_bl_init(struct ideapad_private *priv)
 	if (WARN_ON(priv->kbd_bl.initialized))
 		return -EEXIST;
 
-	if (ideapad_kbd_bl_check_tristate(priv->kbd_bl.type)) {
+	switch (priv->kbd_bl.type) {
+	case KBD_BL_TRISTATE_AUTO:
+		/* The sysfs node will be /sys/class/leds/platform::kbd_backlight/als_enabled */
+		priv->kbd_bl.led.groups = ideapad_kbd_bl_als_groups;
+		fallthrough;
+	case KBD_BL_TRISTATE:
 		priv->kbd_bl.led.max_brightness = 2;
-	} else {
+		break;
+	case KBD_BL_STANDARD:
 		priv->kbd_bl.led.max_brightness = 1;
+		break;
+	default:
+		/* This has already been validated by ideapad_check_features(). */
+		unreachable();
 	}
 
 	brightness = ideapad_kbd_bl_brightness_get(priv);
-- 
2.50.1



Return-Path: <linux-kernel+bounces-882816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7F5C2B938
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A4543B4592
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 12:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5183081B2;
	Mon,  3 Nov 2025 12:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vJBJX71R"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBB22FFFB4
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 12:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762171712; cv=none; b=aHxzKE17zHqxyTYV+clGy/5fAkPIYhoJplgnlExhCAu4GIKfYZ/ZzRq9BtbLxwJVyXWxxmliAhbqvH/T/yltcF4f+8P8AFUiJfKni7eqDd1m3MxGD2ut9YNm/uRpIEV14qKmW0X/a5c9RHXMQqbhVGh5LJY8WRFDzbD6HiCY05Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762171712; c=relaxed/simple;
	bh=p0o2FuMMOcgdqopUEEms1lW5IVeru9s809ZoRQJpmL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KPLFEPTH4zgDEOGBHf3YDpevp7uJ83TmpIYuAUwqtECYOFqt+r9bXWD42VSFxr3FLrl1AyG+yc5xSInyaIO+jbcsyvqz6MJK0T+0gdjrZtGnRYGgft9Et3BzlhJIdMetNEk5okKHOw7l1useCrtXWjLVVBAGRJ2OteUU3CSvAoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vJBJX71R; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762171698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iGDcyq3Knv+D9H4bmNDRHk5OGsSqZ+1+mXD5MKk+UMY=;
	b=vJBJX71R9aAKiF3PidbLbVwzC+XRssvOjhRmD0dnAbdD7wDbMfGRZobZ4KNDyutbT+V82b
	IR23R7Mn6MiYig+eEndiZgPrVhCMc95HxoMD7mGW2j4UwypZb6fxXXC2Q/vx6Hwd6e4prX
	0CS8ZySVrqA60EAV/dUqbte2UFj6d+c=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] leds: led-class: Replace sprintf with sysfs_emit in sysfs show functions
Date: Mon,  3 Nov 2025 13:08:09 +0100
Message-ID: <20251103120809.32834-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace sprintf() with sysfs_emit() in sysfs show functions.
sysfs_emit() is preferred to format sysfs output as it provides better
bounds checking.  No functional changes.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/leds/led-class.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index f3faf37f9a08..885399ed0776 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -38,7 +38,7 @@ static ssize_t brightness_show(struct device *dev,
 	brightness = led_cdev->brightness;
 	mutex_unlock(&led_cdev->led_access);
 
-	return sprintf(buf, "%u\n", brightness);
+	return sysfs_emit(buf, "%u\n", brightness);
 }
 
 static ssize_t brightness_store(struct device *dev,
@@ -80,7 +80,7 @@ static ssize_t max_brightness_show(struct device *dev,
 	max_brightness = led_cdev->max_brightness;
 	mutex_unlock(&led_cdev->led_access);
 
-	return sprintf(buf, "%u\n", max_brightness);
+	return sysfs_emit(buf, "%u\n", max_brightness);
 }
 static DEVICE_ATTR_RO(max_brightness);
 
@@ -122,7 +122,7 @@ static ssize_t brightness_hw_changed_show(struct device *dev,
 	if (led_cdev->brightness_hw_changed == -1)
 		return -ENODATA;
 
-	return sprintf(buf, "%u\n", led_cdev->brightness_hw_changed);
+	return sysfs_emit(buf, "%u\n", led_cdev->brightness_hw_changed);
 }
 
 static DEVICE_ATTR_RO(brightness_hw_changed);
-- 
2.51.1



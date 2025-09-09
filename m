Return-Path: <linux-kernel+bounces-808154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35132B4FAE1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62A81C28257
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E231D3191B4;
	Tue,  9 Sep 2025 12:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m5Gq56iP"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8475A334738
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 12:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421048; cv=none; b=fg5Ux8XdZm7B2DnGNJIvsdBVPfswkHUFvIphjO1+ZP2DVO6CbwXp6yrXKsC24Pyp2cX0SB5Ezg/qm11bv+/qhmjvD4lTYlUb9EbVUIvTmzP0phUlOnyhTi5S7ggZXjKnI1cqq2KmWHlRXWjD182T4cnWsFb3hcl27UZWCk4i1jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421048; c=relaxed/simple;
	bh=fN049EH0gqurHLscXSdiFKelXsZTTlJy1FAhnjS+5tA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rDB9hqPignl5sqfF6T538Jd7uRD2NhOw/OOoMOcQfywbL3ac0iHMwy45S6IRAZpTXpUkyqxtBt9xUrzzSzvN50oE8v1mDS6utE/Mb48v7RIG49d9PPUyrcRsImRQEb2iS+h3DtK2hY05e3KM4ipcsE5vbu1mO7CYwelMToGXc4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m5Gq56iP; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b042cc39551so997395966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 05:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757421044; x=1758025844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h11TJTxgMeaGK+Qbd8Gn2b3zaXWavrJHEj+psQs667I=;
        b=m5Gq56iPJYfK5q9lLlzv10yE6n5JKbWQvFIfbV5kUfCLrufVIG/Qt7vktYVtoQHjSY
         v7f2b2qIaF4ih6E0830kvMi1UIWOlLKsKxFf/C30ANzF4xHRPvpd94RGx2uBDXJg76Dq
         KeeFevv7vAEv89iyOsMLHrpt4fyCG/EEvHH7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757421044; x=1758025844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h11TJTxgMeaGK+Qbd8Gn2b3zaXWavrJHEj+psQs667I=;
        b=kSXlvqQh/l7VQIsW+UNoKcr0ZaEQacjUF9/ltfyGAPDk2QCSV34cGmqZ3nEQkC2LzC
         SFgt6DpsA5faCnrqTku+FvEBKWk7/7rp4Cq1nOCeG25sLl1sz++xtk6HFic9KcN4zGIf
         tJzecQLqfBMCQyjDhcoNcG8++VzZMRXLD/oGqV7GIRsObBsuj2qQUqnHljh8sEWlNZd6
         fWVl0ljw2VwuxE75j1vin7oL7WBqdPdrbX9oTf4XJjJ0KqdDS5wNP92snaZP9e5g7MEt
         P+0aO8BrReDJAs4bT6jdC3m+36dC747uz96GDZtiFT4MzijBGWsbm4MySA5wUr87YDT9
         5SoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYb8NpAw8sZCCwc+O8gAW8LaMSkrYZ3XVJh4bT8NFXouAoXIq9a2T74ZBP/FUIM+EcsM6L56omcAT5ojc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp0UpYZmVYYvCvSDQ5kgATj/zLsbeMBlEt0kBCF1Pjc5mgIqSk
	v9md0odAdPKt3DGwJIRqk+GPuBtyw1gUqI1yfr73dEl4/hYaU3/caZhl/xhJfKvxBg==
X-Gm-Gg: ASbGncviHW1OydUayDBdg4/4n19RBQAYN4YuUwJ+f3iGa9FrRPERXuzzDboiT71pgJl
	I+9o7zWQiewDRDAJISZGJn/OoGbgyafIvB0IHeHhmCSiBAIX+F7dNLj7bxGzf813vDZvu00NeL4
	drT+qmzSsxoUE8c9beNg59IL/kUkewLwr2pWLgsJdEz+TZOt3yLlKv8hQsIZLpQav8RteguzdRb
	fgGyTXfI0b0DOam7IJKo9xnJsrvpVdfe+/MEqRpYH+xpYg4UHdSL24ffgHWVDl0EsbYPLl/AtGE
	5FFhgLuiXc7XsSMn2x8J/nZiYmqaiVyeKjjLNck2KX5Vs29wV7dFFArmawFKaOCn/jrEFIVIE52
	rUArCmNSnirHcXWML5K6/kGBELiivoVGSuiqfH8zvbpJGjlYNSCYtex/eB2ffiJZnoR6TzG8Jep
	7my6SadzgZ2Pke+vSsMQO0nVev/w==
X-Google-Smtp-Source: AGHT+IHTbMUAWbZCStfN2KSvqbzF0cZzpg6HYKgjKjtANpkaaL7p64kwSsxCsJX84Bao/nA+lAnb5w==
X-Received: by 2002:a17:907:c1d:b0:b04:6e26:7351 with SMTP id a640c23a62f3a-b04b172e8d6mr1302976866b.54.1757421043811;
        Tue, 09 Sep 2025 05:30:43 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (240.225.32.34.bc.googleusercontent.com. [34.32.225.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b01902d0e99sm2409702166b.12.2025.09.09.05.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 05:30:43 -0700 (PDT)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev
Cc: Guenter Roeck <groeck@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Andrei Kuchynski <akuchynski@chromium.org>
Subject: [PATCH RFC 2/5] usb: typec: Expose mode_selection attribute via sysfs
Date: Tue,  9 Sep 2025 12:30:25 +0000
Message-ID: <20250909123028.2127449-3-akuchynski@chromium.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
In-Reply-To: <20250909123028.2127449-1-akuchynski@chromium.org>
References: <20250909123028.2127449-1-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces new sysfs attribute to enable user control over
Type-C mode selection. Writing a boolean '1' to this attribute starts the
mode selection process, while writing '0' stops it.

Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
---
 Documentation/ABI/testing/sysfs-class-typec | 11 ++++++
 drivers/usb/typec/class.c                   | 37 +++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
index dab3e4e727b6..7addf0e69c5c 100644
--- a/Documentation/ABI/testing/sysfs-class-typec
+++ b/Documentation/ABI/testing/sysfs-class-typec
@@ -258,6 +258,17 @@ Description:	The USB Modes that the partner device supports. The active mode
 		- usb3 (USB 3.2)
 		- usb4 (USB4)
 
+What:		/sys/class/typec/<port>-partner/mode_selection
+Date:		August 2025
+Contact:	Andrei Kuchynski <akuchynski@chromium.org>
+Description:	Mode selection is activated by writing boolean 1 to the
+		file. Conversely, writing boolean 0 will cancel any ongoing selection
+		process and exit the currently active mode, if any. The attribute
+		returns "on" when mode selection is either in progress or complete,
+		and "off" otherwise.
+		This attribute is only present if the kernel supports AP driven mode
+		entry, where the Application Processor manages USB Type-C alt-modes.
+
 USB Type-C cable devices (eg. /sys/class/typec/port0-cable/)
 
 Note: Electronically Marked Cables will have a device also for one cable plug
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index aaab2e1e98b4..b66fe62f282d 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -763,6 +763,35 @@ static ssize_t number_of_alternate_modes_show(struct device *dev, struct device_
 }
 static DEVICE_ATTR_RO(number_of_alternate_modes);
 
+static ssize_t mode_selection_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	const bool ret = typec_mode_selection_is_pending(to_typec_partner(dev));
+
+	return sprintf(buf, "%s\n", str_on_off(ret));
+}
+
+static ssize_t mode_selection_store(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t size)
+{
+	struct typec_partner *partner = to_typec_partner(dev);
+	bool start;
+	int ret = kstrtobool(buf, &start);
+
+	if (!ret) {
+		if (start)
+			ret = typec_mode_selection_start(partner);
+		else
+			ret = typec_mode_selection_reset(partner);
+	}
+
+	if (ret)
+		return ret;
+
+	return size;
+}
+static DEVICE_ATTR_RW(mode_selection);
+
 static struct attribute *typec_partner_attrs[] = {
 	&dev_attr_accessory_mode.attr,
 	&dev_attr_supports_usb_power_delivery.attr,
@@ -770,6 +799,7 @@ static struct attribute *typec_partner_attrs[] = {
 	&dev_attr_type.attr,
 	&dev_attr_usb_mode.attr,
 	&dev_attr_usb_power_delivery_revision.attr,
+	&dev_attr_mode_selection.attr,
 	NULL
 };
 
@@ -794,6 +824,10 @@ static umode_t typec_partner_attr_is_visible(struct kobject *kobj, struct attrib
 		if (!get_pd_product_type(kobj_to_dev(kobj)))
 			return 0;
 
+	if (attr == &dev_attr_mode_selection.attr)
+		if (!port->mode_control)
+			return 0;
+
 	return attr->mode;
 }
 
@@ -1097,6 +1131,8 @@ struct typec_partner *typec_register_partner(struct typec_port *port,
 		typec_partner_link_device(partner, port->usb3_dev);
 	mutex_unlock(&port->partner_link_lock);
 
+	typec_mode_selection_add_partner(partner);
+
 	return partner;
 }
 EXPORT_SYMBOL_GPL(typec_register_partner);
@@ -1114,6 +1150,7 @@ void typec_unregister_partner(struct typec_partner *partner)
 	if (IS_ERR_OR_NULL(partner))
 		return;
 
+	typec_mode_selection_remove_partner(partner);
 	port = to_typec_port(partner->dev.parent);
 
 	mutex_lock(&port->partner_link_lock);
-- 
2.51.0.384.g4c02a37b29-goog



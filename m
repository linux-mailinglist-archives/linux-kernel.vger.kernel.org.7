Return-Path: <linux-kernel+bounces-769481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4C9B26F41
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 20:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B421CE24D1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE5223D2A3;
	Thu, 14 Aug 2025 18:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ETowu+CQ"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB0129D290
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 18:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755197110; cv=none; b=ivuXjWeppaznBxmHH+Vp3x6rD72Fq3C0SdFGeOssKdMEhrs26e57aHR6Uhv9QF2P6i9oQWlRdungMXpTkyzUbkzytDWEDi0CBxbdU7uDbnD1qJlI+cL6AuoMDpZ3AiKMreNFvWqPrx1+ksQ9QXLTW7BLznLX+DigaETKqj9QSYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755197110; c=relaxed/simple;
	bh=JYJuJJtKbSbwoGNn2vGBU0HeE/q6/qLRN8ZG3a0DukM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pd7MQwor3/otBz3yfuco6/R1PWC7fPHohCG4bimzD55bTNV0qitXIEbzl7KnwI52LE2j+M1q+Fkb5/MWYdZBqcUYGuHPk1YNcjiCNsoZs+MoVKspfABJVQhp2YjQySkVhJ1MWX5zJ2lVtp/HhMnL4mVxzytud9k1U6qdBE4+a4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ETowu+CQ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6188b793d21so2018411a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755197107; x=1755801907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qG0lIEyNnJu30xpAJGFwUH4NJAVmrpYlXCdXMGkL4NE=;
        b=ETowu+CQkhF9YTbVDcVyDmgazi+zp4AncQEHJT5XDpYRRFI3WTmluLo+UFRT5yIqJc
         DY67AG5sgiOuu0ddH9itw40kbMBFxYJZGizhYvtXMKuE9+QPU2wyYuJqQur6WbocGm5N
         wg89DL8op4agFGWeIypV3P6rAFPHYe0LnmB5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755197107; x=1755801907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qG0lIEyNnJu30xpAJGFwUH4NJAVmrpYlXCdXMGkL4NE=;
        b=oIgS0HD/7xlJy+lfPCPqIIbZ+bvAKUZatnxfgoeX60///UfcFvBe8aqSzNiCTYZOh6
         wn9VjCnHNS4kbE9d7Q0BId+tiDDuv6xizEsHJSI1onWVZ/eRFfQYGZ5RxFtVlCV9yOwl
         t0joGHnNP+PoiwczV1lMiNax7KFpkdCY6WvhKK7Oc/g5QHAEBUr/9X/OkGxCoPJjvvRt
         3dOa+Nigz+eoa0RFIQBLVuJGZ6643YRvXX2vkKvjmZSwGvGMo4lYex4hfyDiOZ86s3mt
         9Gnm6QW8K9FBERmEF8R0Cc/0OlA1y7n3bYeEM4xMiURGXnB1ph4y+4dlpG3Wc+q8bNAR
         lJMA==
X-Forwarded-Encrypted: i=1; AJvYcCXKXh3POqdmLkYqIu5Knz2TpTjWrl3oUafO1PJqV8pQr6pFAEvjYFcl5D5mvdXLou54j6Esaqm71sZNtyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvTrvP2goaBitQVBVfHHmbZzNUzDMcCNyhmDBNQcuU4y72ux8o
	xWvwEBOEzwb/IPNVJRKIE9T8mOS1XJVA2Nddmz/MBgmz69qaqF2JDUKy8DWPaHRoYQ==
X-Gm-Gg: ASbGncuzOUy+bvRZRr514kHgB/Gfvwwc7Kmta4BdHGYATp7/coGaC14x+NHhSGhbjHi
	OHyMSNxsTBT0hi2JpBksArEcZq2bCQuKwS16Mw4CJhr+0wENQggsKpE646IGjs2E3/d1W8UAu0x
	zUM6LhawN0HpjIASESpLTD6q1UEUKeSw7xTpHfgCSJzNg1kxazffvfq4gbyVTq9ilF6rmTP2S+Q
	JF7wvh2DVMHand2u6uQhRO7J6u1/Ms9WZ6Lhzv/HB0yxIVcDTRHduIvrZREA8wpqTEOD4EFQ0zi
	evQPE4iIyYOPE/okdGDLNVPTetAUmKt7zspT9jYEgTB3CjTCpUhvGvPShwKXs9PabI7uxG5N8qD
	z3QHlYEOPO57ld3ZXwdQYkJGWeG5riuH4DkI+DhVv9Q+ZLSFTJfjZ4KsNNOJrv5p0MGxZhDffiQ
	vPpLzMl2ObCUwsF8Z3TDPzirGCSJhEK+VAuQ==
X-Google-Smtp-Source: AGHT+IF5+9Rm5CQWAnwcUIzR8+1SMRvn/532XJx42aw5G3W3xEpn8yRTB8aPidZXpklreIMFUWH/CA==
X-Received: by 2002:a17:907:6d12:b0:af9:3ad2:6930 with SMTP id a640c23a62f3a-afcb97cb1f3mr385072666b.24.1755197106660;
        Thu, 14 Aug 2025 11:45:06 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (37.247.91.34.bc.googleusercontent.com. [34.91.247.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c0f4sm2614772466b.106.2025.08.14.11.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 11:45:06 -0700 (PDT)
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
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Venkat Jayaraman <venkat.jayaraman@intel.com>,
	linux-kernel@vger.kernel.org,
	Andrei Kuchynski <akuchynski@chromium.org>
Subject: [PATCH v1 5/5] usb: typec: Expose alternate mode priority via sysfs
Date: Thu, 14 Aug 2025 18:44:55 +0000
Message-ID: <20250814184455.723170-6-akuchynski@chromium.org>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
In-Reply-To: <20250814184455.723170-1-akuchynski@chromium.org>
References: <20250814184455.723170-1-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces a priority sysfs attribute to the USB Type-C
alternate mode port interface. This new attribute allows user-space to
configure the numeric priority of alternate modes managing their preferred
order of operation.

Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
---
 Documentation/ABI/testing/sysfs-class-typec | 12 ++++++
 drivers/usb/typec/class.c                   | 47 ++++++++++++++++++++-
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
index 38e101c17a00..001202d651fa 100644
--- a/Documentation/ABI/testing/sysfs-class-typec
+++ b/Documentation/ABI/testing/sysfs-class-typec
@@ -162,6 +162,18 @@ Description:	Lists the supported USB Modes. The default USB mode that is used
 		- usb3 (USB 3.2)
 		- usb4 (USB4)
 
+		What:		/sys/class/typec/<port>/<alt-mode>/priority
+Date:		July 2025
+Contact:	Andrei Kuchynski <akuchynski@chromium.org>
+Description:
+		Displays and allows setting the priority for a specific alt-mode.
+		When read, it shows the current integer priority value. Lower numerical
+		values indicate higher priority (0 is the highest priority).
+		If the new value is already in use by another mode, the priority of the
+		conflicting mode and any subsequent modes will be incremented until they
+		are all unique.
+		This attribute is visible only if the kernel supports mode selection.
+
 USB Type-C partner devices (eg. /sys/class/typec/port0-partner/)
 
 What:		/sys/class/typec/<port>-partner/accessory_mode
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index a72325ff099a..708f3487222a 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -19,6 +19,7 @@
 #include "bus.h"
 #include "class.h"
 #include "pd.h"
+#include "mode_selection.h"
 
 static DEFINE_IDA(typec_index_ida);
 
@@ -445,11 +446,41 @@ svid_show(struct device *dev, struct device_attribute *attr, char *buf)
 }
 static DEVICE_ATTR_RO(svid);
 
+static ssize_t priority_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t size)
+{
+	unsigned int val;
+	int err = kstrtouint(buf, 10, &val);
+
+	if (!err) {
+		err = typec_mode_set_priority(to_typec_altmode(dev), val);
+		if (!err)
+			return size;
+	}
+
+	return err;
+}
+
+static ssize_t priority_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	int val;
+	const int err = typec_mode_get_priority(to_typec_altmode(dev), &val);
+
+	if (err)
+		return err;
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RW(priority);
+
 static struct attribute *typec_altmode_attrs[] = {
 	&dev_attr_active.attr,
 	&dev_attr_mode.attr,
 	&dev_attr_svid.attr,
 	&dev_attr_vdo.attr,
+	&dev_attr_priority.attr,
 	NULL
 };
 
@@ -458,7 +489,7 @@ static umode_t typec_altmode_attr_is_visible(struct kobject *kobj,
 {
 	struct typec_altmode *adev = to_typec_altmode(kobj_to_dev(kobj));
 
-	if (attr == &dev_attr_active.attr)
+	if (attr == &dev_attr_active.attr) {
 		if (!is_typec_port(adev->dev.parent)) {
 			struct typec_partner *partner =
 				to_typec_partner(adev->dev.parent);
@@ -469,6 +500,15 @@ static umode_t typec_altmode_attr_is_visible(struct kobject *kobj,
 				!adev->ops->activate)
 				return 0444;
 		}
+	} else if (attr == &dev_attr_priority.attr) {
+		if (is_typec_port(adev->dev.parent))  {
+			struct typec_port *port = to_typec_port(adev->dev.parent);
+
+			if (!port->alt_mode_override)
+				return 0;
+		} else
+			return 0;
+	}
 
 	return attr->mode;
 }
@@ -2029,6 +2069,7 @@ static void typec_release(struct device *dev)
 	typec_mux_put(port->mux);
 	typec_retimer_put(port->retimer);
 	kfree(port->cap);
+	typec_mode_selection_destroy(port);
 	kfree(port);
 }
 
@@ -2496,6 +2537,8 @@ typec_port_register_altmode(struct typec_port *port,
 		to_altmode(adev)->retimer = retimer;
 	}
 
+	typec_mode_set_priority(adev, -1);
+
 	return adev;
 }
 EXPORT_SYMBOL_GPL(typec_port_register_altmode);
@@ -2645,6 +2688,8 @@ struct typec_port *typec_register_port(struct device *parent,
 	port->con.attach = typec_partner_attach;
 	port->con.deattach = typec_partner_deattach;
 
+	INIT_LIST_HEAD(&port->mode_list);
+
 	if (cap->usb_capability & USB_CAPABILITY_USB4)
 		port->usb_mode = USB_MODE_USB4;
 	else if (cap->usb_capability & USB_CAPABILITY_USB3)
-- 
2.51.0.rc0.215.g125493bb4a-goog



Return-Path: <linux-kernel+bounces-754903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5F6B19E3B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95D2A7A68E6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9A3247289;
	Mon,  4 Aug 2025 09:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OwbWL/As"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF19247287
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754298273; cv=none; b=HfRfLyKSvWOyrgRgbn+f1gEl7wH1w0rHhxI67MTysxBvIOj0Ud+ZjqGlYvs8olg32rSoA55K8OG2ZeqMiAe+4jVDqyJLjMAG24pR7T+2Pt30HSgx1JuofJVJ25pUixhC35txdOXetIQVqyPeSO1v9B0zQKd/W1QY5170vCuCt8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754298273; c=relaxed/simple;
	bh=xkMlzpbG01T+w0WOqF7niNZLHXyYGCXdCyisCwJ+khw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qhGir7laRIu4wHF3VGLpQ+sMt3SAyCBPQ1pecoph0QtuKL4Fh2BzSN6+lX8THwZVdg6AjZLVkD3x4OlCQ/HIICe1u0q3dmA8aWSPeT627Y7tfNE9/EQFq00EeyWPAaLP91FtH+j92Z+CXJv7/6j7QVYk+hePA4PP7xoVscRPNGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OwbWL/As; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61568fbed16so4566066a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 02:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754298269; x=1754903069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/YntZK0scRDzUtpLUdif5ObE8XPBblzRqTujLBoEls=;
        b=OwbWL/AskELe2+X9kZxcPjuQoJjgvTpo7ghwbwmHEUr71F60jxvyT08aGiJISeUGRN
         65VRw5O0teTmKDI6LLh6IXJAHMmcSwGcUzYanxpmjgejkGbKV/nXr5Wc+ymmH8jg81yh
         1cl5pEiZY7Qvmwh3MX9o6GL4MeOYwshBlyB+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754298269; x=1754903069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/YntZK0scRDzUtpLUdif5ObE8XPBblzRqTujLBoEls=;
        b=Uc5jGvMk81BOgp7ff0VAWPzsdfDcBJNoMyJdltUxFHbs4s4gL2deZ4HWEq82RY9Wpz
         siIuokhzndqoy7JqOl04PZbT0xGRtlrA4a8x6mxQH+2gQOf5v2hKFPAh5U3+2RAqcUPb
         t6Ni4XLHHg3BnnXS9W2Hvd/nd0Ra5AGZBmkw0iBiebg2Nw0870T7myzcJsJSRXSal/zD
         cCeP85AbS+KLq4rbx4nm4rP5Zj480dNTSqLF2w4QylcEGptb0XWl3wTAWkmaexdWR3kK
         FPK0NdSCGicQTnGbBR7KM9I8/s/SJgGVlN6ifFmJ1z0nZq6iJNEHwz+lYJ7z6T50YB3U
         yloQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZMUs8sHavN+Mm2pc82kLjq3VqH+MB0dtvw0BaqRvfikSU6Z7hARxHuhPWmSzqWB4TCTW8ASJH8b/hfJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXWl8GPA7XM3P8wQhS1tuJCTQwk6cDVxxak/gfeFsF3YCB7mxj
	Q/coBgdKYc2FMCsbn0h6+OCrXJJPkZO2j6D49YZ47TMC6m3emM1TqgxLV9NAoy7cTg==
X-Gm-Gg: ASbGncuoWwlVefA3nk9oirLuR7n8TsMJ6LYfg7wZ9IGurqpCA23sBoSLPwlh3Bx29M4
	Y6OeaQI/Jkn4jt8wU6qopwiid5E5Qzc5Fb/2YGdNrg+l+at7qZTTG9MKIkqYYVMvT2SstzYKc7J
	L+gyq4KiDnStUXHc9VgKVK523233kRZ2W2FW4WaYgqlfQSOoNJG+E9YVZlOTcStnRCCksREeoti
	b2cKlF95wGcEF7tuO8C2JZJp4qUWZVd/2sMez5tNRI3xSaIWXA87ETfFN3kQsTfmhMgeNxHhJSg
	AXzzc/T4jYye44IgmqUmVT1CwBbbdPnQTwF7aPjfJcNJa2/jX+1UGVvWBkAcB8v5AnYFsBm+UGT
	m9LShyg14Jf1xxKsXTBymLXxx3HbbCcUDYhK02rR5We/KxQyE0m8fFXrH0c/eO280qGm7CMx0Jc
	iAlInoh6IWmg/e2KI=
X-Google-Smtp-Source: AGHT+IFvegDt8dTEVZTkYDNlKSuxzkDH43Aovq7lgo42X8LYJ+UBemH44YKVdHdMh5C6kMgO4im2Mw==
X-Received: by 2002:a05:6402:510d:b0:615:142a:c066 with SMTP id 4fb4d7f45d1cf-615e7172f57mr7139479a12.23.1754298268904;
        Mon, 04 Aug 2025 02:04:28 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (150.230.32.34.bc.googleusercontent.com. [34.32.230.150])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8fe7995sm6412790a12.36.2025.08.04.02.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 02:04:27 -0700 (PDT)
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
Subject: [PATCH v3 04/10] usb: typec: Expose mode priorities via sysfs
Date: Mon,  4 Aug 2025 09:03:33 +0000
Message-ID: <20250804090340.3062182-5-akuchynski@chromium.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250804090340.3062182-1-akuchynski@chromium.org>
References: <20250804090340.3062182-1-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces new sysfs attributes to allow users to configure
and view Type-C mode priorities.

`priority`, `usb4_priority` attributes allow users to assign a numeric
priority to DisplayPort alt-mode, Thunderbolt alt-mode, and USB4 mode.

`mode_priorities` - read-only attribute that displays an ordered list
of all modes based on their configured priorities.

Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
---
 Documentation/ABI/testing/sysfs-class-typec |  33 +++++
 drivers/usb/typec/Makefile                  |   2 +-
 drivers/usb/typec/class.c                   | 103 +++++++++++++++-
 drivers/usb/typec/class.h                   |   1 +
 drivers/usb/typec/mode_selection.c          | 130 ++++++++++++++++++++
 drivers/usb/typec/mode_selection.h          |  23 ++++
 include/linux/usb/typec_altmode.h           |   7 ++
 7 files changed, 295 insertions(+), 4 deletions(-)
 create mode 100644 drivers/usb/typec/mode_selection.c
 create mode 100644 drivers/usb/typec/mode_selection.h

diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
index 38e101c17a00..575dd94f33ab 100644
--- a/Documentation/ABI/testing/sysfs-class-typec
+++ b/Documentation/ABI/testing/sysfs-class-typec
@@ -162,6 +162,39 @@ Description:	Lists the supported USB Modes. The default USB mode that is used
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
+		What:		/sys/class/typec/<port>/usb4_priority
+Date:		July 2025
+Contact:	Andrei Kuchynski <akuchynski@chromium.org>
+Description:
+		Displays and allows setting the priority for USB4 mode. Its behavior and
+		priority numbering scheme are identical to the general alt-mode
+		"priority" attributes.
+
+What:		/sys/class/typec/<port>/mode_priorities
+Date:		July 2025
+Contact:	Andrei Kuchynski <akuchynski@chromium.org>
+Description:	This read-only file lists the modes supported by the port,
+		ordered by their activation priority. It reflects the preferred sequence
+		the kernel will attempt to activate modes (DisplayPort alt-mode,
+		Thunderbolt alt-mode, USB4 mode).
+		This attribute is visible only if the kernel supports mode selection.
+
+		Example values:
+		- "USB4 Thunderbolt3 DisplayPort"
+		- "DisplayPort": the port only supports Displayport alt-mode
+
 USB Type-C partner devices (eg. /sys/class/typec/port0-partner/)
 
 What:		/sys/class/typec/<port>-partner/accessory_mode
diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefile
index 7a368fea61bc..8a6a1c663eb6 100644
--- a/drivers/usb/typec/Makefile
+++ b/drivers/usb/typec/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_TYPEC)		+= typec.o
-typec-y				:= class.o mux.o bus.o pd.o retimer.o
+typec-y				:= class.o mux.o bus.o pd.o retimer.o mode_selection.o
 typec-$(CONFIG_ACPI)		+= port-mapper.o
 obj-$(CONFIG_TYPEC)		+= altmodes/
 obj-$(CONFIG_TYPEC_TCPM)	+= tcpm/
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index a72325ff099a..414d94c45ab9 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -19,6 +19,7 @@
 #include "bus.h"
 #include "class.h"
 #include "pd.h"
+#include "mode_selection.h"
 
 static DEFINE_IDA(typec_index_ida);
 
@@ -445,11 +446,45 @@ svid_show(struct device *dev, struct device_attribute *attr, char *buf)
 }
 static DEVICE_ATTR_RO(svid);
 
+static ssize_t priority_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t size)
+{
+	struct typec_altmode *adev = to_typec_altmode(dev);
+	unsigned int val;
+	int err = kstrtouint(buf, 10, &val);
+
+	if (!err) {
+		err = typec_mode_set_priority(to_typec_port(adev->dev.parent),
+			typec_svid_to_altmode(adev->svid), val);
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
+	struct typec_altmode *adev = to_typec_altmode(dev);
+	int val;
+	const int err = typec_mode_get_priority(to_typec_port(adev->dev.parent),
+			typec_svid_to_altmode(adev->svid), &val);
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
 
@@ -458,7 +493,7 @@ static umode_t typec_altmode_attr_is_visible(struct kobject *kobj,
 {
 	struct typec_altmode *adev = to_typec_altmode(kobj_to_dev(kobj));
 
-	if (attr == &dev_attr_active.attr)
+	if (attr == &dev_attr_active.attr) {
 		if (!is_typec_port(adev->dev.parent)) {
 			struct typec_partner *partner =
 				to_typec_partner(adev->dev.parent);
@@ -469,6 +504,15 @@ static umode_t typec_altmode_attr_is_visible(struct kobject *kobj,
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
@@ -1942,6 +1986,44 @@ static ssize_t orientation_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(orientation);
 
+static ssize_t mode_priorities_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	return typec_mode_get_priority_list(to_typec_port(dev), buf);
+}
+static DEVICE_ATTR_RO(mode_priorities);
+
+static ssize_t usb4_priority_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct typec_port *port = to_typec_port(dev);
+	int val;
+	const int err = typec_mode_get_priority(port, TYPEC_USB4_MODE, &val);
+
+	if (err)
+		return err;
+
+	return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t usb4_priority_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t size)
+{
+	struct typec_port *port = to_typec_port(dev);
+	unsigned int val;
+	int err = kstrtouint(buf, 10, &val);
+
+	if (!err) {
+		err = typec_mode_set_priority(port, TYPEC_USB4_MODE, val);
+		if (!err)
+			return size;
+	}
+
+	return err;
+}
+static DEVICE_ATTR_RW(usb4_priority);
+
 static struct attribute *typec_attrs[] = {
 	&dev_attr_data_role.attr,
 	&dev_attr_power_operation_mode.attr,
@@ -1954,6 +2036,8 @@ static struct attribute *typec_attrs[] = {
 	&dev_attr_port_type.attr,
 	&dev_attr_orientation.attr,
 	&dev_attr_usb_capability.attr,
+	&dev_attr_mode_priorities.attr,
+	&dev_attr_usb4_priority.attr,
 	NULL,
 };
 
@@ -1992,6 +2076,13 @@ static umode_t typec_attr_is_visible(struct kobject *kobj,
 			return 0;
 		if (!port->ops || !port->ops->default_usb_mode_set)
 			return 0444;
+	} else if (attr == &dev_attr_mode_priorities.attr) {
+		if (!port->alt_mode_override)
+			return 0;
+	} else if (attr == &dev_attr_usb4_priority.attr) {
+		if (!port->alt_mode_override ||
+			!(port->cap->usb_capability & USB_CAPABILITY_USB4))
+			return 0;
 	}
 
 	return attr->mode;
@@ -2029,6 +2120,7 @@ static void typec_release(struct device *dev)
 	typec_mux_put(port->mux);
 	typec_retimer_put(port->retimer);
 	kfree(port->cap);
+	typec_mode_selection_destroy(port);
 	kfree(port);
 }
 
@@ -2496,6 +2588,8 @@ typec_port_register_altmode(struct typec_port *port,
 		to_altmode(adev)->retimer = retimer;
 	}
 
+	typec_mode_set_priority(port, typec_svid_to_altmode(adev->svid), -1);
+
 	return adev;
 }
 EXPORT_SYMBOL_GPL(typec_port_register_altmode);
@@ -2645,9 +2739,12 @@ struct typec_port *typec_register_port(struct device *parent,
 	port->con.attach = typec_partner_attach;
 	port->con.deattach = typec_partner_deattach;
 
-	if (cap->usb_capability & USB_CAPABILITY_USB4)
+	typec_mode_selection_init(port);
+
+	if (cap->usb_capability & USB_CAPABILITY_USB4) {
 		port->usb_mode = USB_MODE_USB4;
-	else if (cap->usb_capability & USB_CAPABILITY_USB3)
+		typec_mode_set_priority(port, TYPEC_USB4_MODE, -1);
+	} else if (cap->usb_capability & USB_CAPABILITY_USB3)
 		port->usb_mode = USB_MODE_USB3;
 	else if (cap->usb_capability & USB_CAPABILITY_USB2)
 		port->usb_mode = USB_MODE_USB2;
diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
index f05d9201c233..c6467e576569 100644
--- a/drivers/usb/typec/class.h
+++ b/drivers/usb/typec/class.h
@@ -82,6 +82,7 @@ struct typec_port {
 	struct device			*usb3_dev;
 
 	bool				alt_mode_override;
+	struct list_head		mode_list;
 };
 
 #define to_typec_port(_dev_) container_of(_dev_, struct typec_port, dev)
diff --git a/drivers/usb/typec/mode_selection.c b/drivers/usb/typec/mode_selection.c
new file mode 100644
index 000000000000..9a7185c07d0c
--- /dev/null
+++ b/drivers/usb/typec/mode_selection.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2025 Google LLC.
+ */
+
+#include <linux/usb/typec_altmode.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include "mode_selection.h"
+#include "class.h"
+
+static const char * const mode_names[TYPEC_MODE_MAX] = {
+	[TYPEC_DP_ALTMODE] = "DisplayPort",
+	[TYPEC_TBT_ALTMODE] = "Thunderbolt3",
+	[TYPEC_USB4_MODE] = "USB4",
+};
+
+static const int default_priorities[TYPEC_MODE_MAX] = {
+	[TYPEC_DP_ALTMODE] = 2,
+	[TYPEC_TBT_ALTMODE] = 1,
+	[TYPEC_USB4_MODE] = 0,
+};
+
+/**
+ * struct mode_selection_state - State tracking for a specific Type-C mode
+ * @mode: The type of mode this instance represents
+ * @name: Name string pointer
+ * @priority: The mode priority. Higher values indicate a more preferred mode.
+ * @list: List head to link this mode state into a prioritized list.
+ */
+struct mode_selection_state {
+	enum typec_mode_type mode;
+	const char *name;
+	int priority;
+	struct list_head list;
+};
+
+/* -------------------------------------------------------------------------- */
+/* port 'mode_priorities' attribute */
+void typec_mode_selection_init(struct typec_port *port)
+{
+	INIT_LIST_HEAD(&port->mode_list);
+}
+
+void typec_mode_selection_destroy(struct typec_port *port)
+{
+	struct mode_selection_state *ms, *tmp;
+
+	list_for_each_entry_safe(ms, tmp, &port->mode_list, list) {
+		list_del(&ms->list);
+		kfree(ms);
+	}
+}
+
+int typec_mode_set_priority(struct typec_port *port,
+		const enum typec_mode_type mode, const int priority)
+{
+	struct mode_selection_state *ms_target = NULL;
+	struct mode_selection_state *ms, *tmp;
+
+	if (mode >= TYPEC_MODE_MAX || !mode_names[mode])
+		return -EOPNOTSUPP;
+
+	list_for_each_entry_safe(ms, tmp, &port->mode_list, list) {
+		if (ms->mode == mode) {
+			ms_target = ms;
+			list_del(&ms->list);
+			break;
+		}
+	}
+
+	if (!ms_target) {
+		ms_target = kzalloc(sizeof(struct mode_selection_state), GFP_KERNEL);
+		if (!ms_target)
+			return -ENOMEM;
+		ms_target->mode = mode;
+		ms_target->name = mode_names[mode];
+		INIT_LIST_HEAD(&ms_target->list);
+	}
+
+	if (priority >= 0)
+		ms_target->priority = priority;
+	else
+		ms_target->priority = default_priorities[mode];
+
+	while (ms_target) {
+		struct mode_selection_state *ms_peer = NULL;
+
+		list_for_each_entry(ms, &port->mode_list, list)
+			if (ms->priority >= ms_target->priority) {
+				if (ms->priority == ms_target->priority)
+					ms_peer = ms;
+				break;
+			}
+
+		list_add_tail(&ms_target->list, &ms->list);
+		ms_target = ms_peer;
+		if (ms_target) {
+			ms_target->priority++;
+			list_del(&ms_target->list);
+		}
+	}
+
+	return 0;
+}
+
+int typec_mode_get_priority(struct typec_port *port,
+		const enum typec_mode_type mode, int *priority)
+{
+	struct mode_selection_state *ms;
+
+	list_for_each_entry(ms, &port->mode_list, list)
+		if (ms->mode == mode) {
+			*priority = ms->priority;
+			return 0;
+		}
+
+	return -EOPNOTSUPP;
+}
+
+ssize_t typec_mode_get_priority_list(struct typec_port *port, char *buf)
+{
+	struct mode_selection_state *ms;
+	ssize_t count = 0;
+
+	list_for_each_entry(ms, &port->mode_list, list)
+		count += sysfs_emit_at(buf, count, "%s ", ms->name);
+
+	return count + sysfs_emit_at(buf, count, "\n");
+}
diff --git a/drivers/usb/typec/mode_selection.h b/drivers/usb/typec/mode_selection.h
new file mode 100644
index 000000000000..151f0f8b6632
--- /dev/null
+++ b/drivers/usb/typec/mode_selection.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/usb/typec_dp.h>
+#include <linux/usb/typec_tbt.h>
+
+static inline enum typec_mode_type typec_svid_to_altmode(const u16 svid)
+{
+	switch (svid) {
+	case USB_TYPEC_DP_SID:
+		return TYPEC_DP_ALTMODE;
+	case USB_TYPEC_TBT_SID:
+		return TYPEC_TBT_ALTMODE;
+	}
+	return TYPEC_MODE_MAX;
+}
+
+void typec_mode_selection_init(struct typec_port *port);
+void typec_mode_selection_destroy(struct typec_port *port);
+int typec_mode_set_priority(struct typec_port *port,
+		const enum typec_mode_type mode, const int priority);
+int typec_mode_get_priority(struct typec_port *port,
+		const enum typec_mode_type mode, int *priority);
+ssize_t typec_mode_get_priority_list(struct typec_port *port, char *buf);
diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
index b3c0866ea70f..5d14363e02eb 100644
--- a/include/linux/usb/typec_altmode.h
+++ b/include/linux/usb/typec_altmode.h
@@ -145,6 +145,13 @@ enum {
 
 #define TYPEC_MODAL_STATE(_state_)	((_state_) + TYPEC_STATE_MODAL)
 
+enum typec_mode_type {
+	TYPEC_DP_ALTMODE = 0,
+	TYPEC_TBT_ALTMODE,
+	TYPEC_USB4_MODE,
+	TYPEC_MODE_MAX,
+};
+
 struct typec_altmode *typec_altmode_get_plug(struct typec_altmode *altmode,
 					     enum typec_plug_index index);
 void typec_altmode_put_plug(struct typec_altmode *plug);
-- 
2.50.1.565.gc32cd1483b-goog



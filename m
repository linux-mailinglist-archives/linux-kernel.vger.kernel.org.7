Return-Path: <linux-kernel+bounces-812256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79931B5351D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED071CC035A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE56633A03D;
	Thu, 11 Sep 2025 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sC8xv1PT"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C60833A028
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757600477; cv=none; b=TwOyWYqolB/5a+9Hsw+eK82EuwvseaM3xQcf4/GOZPJm3At2GIz0/XlWx6yIKbeyI1cCS0kWHGlO+Lf7zZlSKFb9Ok2OQrz0dF9LtqSoSWpWpd7HwMGsWo1+fvZdTRrK0pUgi9nNdZg0dM4PRaXsqXZEYYj02xLRrd4blWrjx3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757600477; c=relaxed/simple;
	bh=ZBEWXSIeqmrC3ds4q0dvNNt4iprgbUvOMgGvcwRwVCM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ls0iOu6Em9mYXRnYbyNoBj/pgXNzUQeag7ThW5DwnevGD6Qh2LcW1fxIJYkQZKUHiKe8MOBWpb842XYtlO36elkl6nSN/U1M6fHgvlwO4YFNGckQEw+Qk30G+X9zyuirOUx1VcWYk35lvq4nIvwEC1CIqoPfZ1VI2Yyjf1HzJ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sC8xv1PT; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4fbb90b453so987515a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757600474; x=1758205274; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cd4UolCkEdo/ZISJT1rflmMGOeP6XETs53xAhFcvlpo=;
        b=sC8xv1PT3luryLK1V70Fx2Y1wtK8KFDeeU83ulh35vEhPmgTpqUIvufamoqVCGCDuZ
         LFP2l6v8vF7U2ZHmiygpKIq4kT5AI9W8MJ249nLMIRC2T5iTw9LZfRwNNDQLaTuHr0Kp
         KJHgsNwnttozhhUXrx7qS6/FMM838bZ2FuS03FptfU40UPzWyxMzuStPFqwE94zkS9/4
         +F7NhT43MJFbhHPkuwybJBrJfPUALzaY8jhEa0tE53pOo5w4kNq1deyK3EysLlrbYYeC
         AKLplgsA2Jqw6FZryCSKL0xK5ijjDYKwG4DQ40VyFh9jm9C6k8ZIllw/Y54lji2XXj9/
         /bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757600474; x=1758205274;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cd4UolCkEdo/ZISJT1rflmMGOeP6XETs53xAhFcvlpo=;
        b=pxbpIj+Ar+OrAHJmVApVGae6iayfHxApolrMQHuAmYaH5q5N+B36MFZBk+nPNqRU/0
         s1kiPfaUNlKGcCz+2Pu4Z9aO6RCe4JrJqLW4t1WRucQQoo16ijUYBN7+Go1aiblBUt3C
         Zv9zGaSSjbEHSrVpuitR8RTBmc4JG8Y7DTTzcHocNzgUUWrHlJzZzXjifh2RtIeICFyW
         O+bD/y7ZVFSzXgiQgs9XR1fpL3kQY3eY3P/lxyW7XIHV4KCjf4uT5mQuj0YYq9xt5WV8
         Q774Os58/j/33Oi08+W5VEZpdI/773prmvBMr+41GUbdpzDdikGjMelXbkBNwRJKlXe8
         RDYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtVnWL4NgxO0Hql5jZupUTPqaEEi6BKZ7FgChu8d7oU2PPXt9dVP4ZC7ldA7lGLuUMEVLh60bLXf8EYFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVSc5u+tD7BqVlEE+m3ITfqvW017TAZE5T6NzVTM4R+Z2ig51r
	HllAIcPaS6xYYpWKxINIxUk2QSzt639CRBrKWztXCHmUeKkiargr2KltXporWY2X0vqO9+yRhW5
	olji9WP+d0KJ9YeOhfQ==
X-Google-Smtp-Source: AGHT+IHIv06rwyIboIBXdOUfS11nPVbWxBONJJC6nZ8x4coRAIHSyEYiKps3YULVIH9Uh7RGK9BYFphhlPjrOQU=
X-Received: from pgac28.prod.google.com ([2002:a05:6a02:295c:b0:b49:dbc4:f7a8])
 (user=guanyulin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:a10a:b0:251:e4b4:7a44 with SMTP id adf61e73a8af0-2534556ea5emr29031640637.41.1757600474392;
 Thu, 11 Sep 2025 07:21:14 -0700 (PDT)
Date: Thu, 11 Sep 2025 14:20:14 +0000
In-Reply-To: <20250911142051.90822-1-guanyulin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250911142051.90822-1-guanyulin@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250911142051.90822-3-guanyulin@google.com>
Subject: [PATCH v16 2/4] usb: offload: add apis for offload usage tracking
From: Guan-Yu Lin <guanyulin@google.com>
To: gregkh@linuxfoundation.org, mathias.nyman@intel.com, hannelotta@gmail.com, 
	zijun.hu@oss.qualcomm.com, xu.yang_2@nxp.com, stern@rowland.harvard.edu, 
	andriy.shevchenko@linux.intel.com, amardeep.rai@intel.com, 
	dominique.martinet@atmark-techno.com, quic_wcheng@quicinc.com, 
	sakari.ailus@linux.intel.com, dh10.jung@samsung.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Guan-Yu Lin <guanyulin@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce offload_usage and corresponding apis to track offload usage
on each USB device. Offload denotes that there is another co-processor
accessing the USB device via the same USB host controller. To optimize
power usage, it's essential to monitor whether the USB device is
actively used by other co-processor. This information is vital when
determining if a USB device can be safely suspended during system power
state transitions.

Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
---
 drivers/usb/core/Makefile  |   1 +
 drivers/usb/core/offload.c | 136 +++++++++++++++++++++++++++++++++++++
 drivers/usb/core/usb.c     |   1 +
 include/linux/usb.h        |  18 +++++
 4 files changed, 156 insertions(+)
 create mode 100644 drivers/usb/core/offload.c

diff --git a/drivers/usb/core/Makefile b/drivers/usb/core/Makefile
index ac006abd13b3..766000b4939e 100644
--- a/drivers/usb/core/Makefile
+++ b/drivers/usb/core/Makefile
@@ -9,6 +9,7 @@ usbcore-y += devio.o notify.o generic.o quirks.o devices.o
 usbcore-y += phy.o port.o
 
 usbcore-$(CONFIG_OF)		+= of.o
+usbcore-$(CONFIG_USB_XHCI_SIDEBAND)	+= offload.o
 usbcore-$(CONFIG_USB_PCI)		+= hcd-pci.o
 usbcore-$(CONFIG_ACPI)		+= usb-acpi.o
 
diff --git a/drivers/usb/core/offload.c b/drivers/usb/core/offload.c
new file mode 100644
index 000000000000..7c699f1b8d2b
--- /dev/null
+++ b/drivers/usb/core/offload.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * offload.c - USB offload related functions
+ *
+ * Copyright (c) 2025, Google LLC.
+ *
+ * Author: Guan-Yu Lin
+ */
+
+#include <linux/usb.h>
+
+#include "usb.h"
+
+/**
+ * usb_offload_get - increment the offload_usage of a USB device
+ * @udev: the USB device to increment its offload_usage
+ *
+ * Incrementing the offload_usage of a usb_device indicates that offload is
+ * enabled on this usb_device; that is, another entity is actively handling USB
+ * transfers. This information allows the USB driver to adjust its power
+ * management policy based on offload activity.
+ *
+ * Return: 0 on success. A negative error code otherwise.
+ */
+int usb_offload_get(struct usb_device *udev)
+{
+	int ret;
+
+	usb_lock_device(udev);
+	if (udev->state == USB_STATE_NOTATTACHED) {
+		usb_unlock_device(udev);
+		return -ENODEV;
+	}
+
+	if (udev->state == USB_STATE_SUSPENDED ||
+		   udev->offload_at_suspend) {
+		usb_unlock_device(udev);
+		return -EBUSY;
+	}
+
+	/*
+	 * offload_usage could only be modified when the device is active, since
+	 * it will alter the suspend flow of the device.
+	 */
+	ret = usb_autoresume_device(udev);
+	if (ret < 0) {
+		usb_unlock_device(udev);
+		return ret;
+	}
+
+	udev->offload_usage++;
+	usb_autosuspend_device(udev);
+	usb_unlock_device(udev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_offload_get);
+
+/**
+ * usb_offload_put - drop the offload_usage of a USB device
+ * @udev: the USB device to drop its offload_usage
+ *
+ * The inverse operation of usb_offload_get, which drops the offload_usage of
+ * a USB device. This information allows the USB driver to adjust its power
+ * management policy based on offload activity.
+ *
+ * Return: 0 on success. A negative error code otherwise.
+ */
+int usb_offload_put(struct usb_device *udev)
+{
+	int ret;
+
+	usb_lock_device(udev);
+	if (udev->state == USB_STATE_NOTATTACHED) {
+		usb_unlock_device(udev);
+		return -ENODEV;
+	}
+
+	if (udev->state == USB_STATE_SUSPENDED ||
+		   udev->offload_at_suspend) {
+		usb_unlock_device(udev);
+		return -EBUSY;
+	}
+
+	/*
+	 * offload_usage could only be modified when the device is active, since
+	 * it will alter the suspend flow of the device.
+	 */
+	ret = usb_autoresume_device(udev);
+	if (ret < 0) {
+		usb_unlock_device(udev);
+		return ret;
+	}
+
+	/* Drop the count when it wasn't 0, ignore the operation otherwise. */
+	if (udev->offload_usage)
+		udev->offload_usage--;
+	usb_autosuspend_device(udev);
+	usb_unlock_device(udev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_offload_put);
+
+/**
+ * usb_offload_check - check offload activities on a USB device
+ * @udev: the USB device to check its offload activity.
+ *
+ * Check if there are any offload activity on the USB device right now. This
+ * information could be used for power management or other forms of resource
+ * management.
+ *
+ * The caller must hold @udev's device lock. In addition, the caller should
+ * ensure downstream usb devices are all either suspended or marked as
+ * "offload_at_suspend" to ensure the correctness of the return value.
+ *
+ * Returns true on any offload activity, false otherwise.
+ */
+bool usb_offload_check(struct usb_device *udev) __must_hold(&udev->dev->mutex)
+{
+	struct usb_device *child;
+	bool active;
+	int port1;
+
+	usb_hub_for_each_child(udev, port1, child) {
+		usb_lock_device(child);
+		active = usb_offload_check(child);
+		usb_unlock_device(child);
+		if (active)
+			return true;
+	}
+
+	return !!udev->offload_usage;
+}
+EXPORT_SYMBOL_GPL(usb_offload_check);
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index b88b6271cb30..b6b0b8489523 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -670,6 +670,7 @@ struct usb_device *usb_alloc_dev(struct usb_device *parent,
 	set_dev_node(&dev->dev, dev_to_node(bus->sysdev));
 	dev->state = USB_STATE_ATTACHED;
 	dev->lpm_disable_count = 1;
+	dev->offload_usage = 0;
 	atomic_set(&dev->urbnum, 0);
 
 	INIT_LIST_HEAD(&dev->ep0.urb_list);
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 70ef00c42d22..e85105939af8 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -636,6 +636,8 @@ struct usb3_lpm_parameters {
  * @do_remote_wakeup:  remote wakeup should be enabled
  * @reset_resume: needs reset instead of resume
  * @port_is_suspended: the upstream port is suspended (L2 or U3)
+ * @offload_at_suspend: offload activities during suspend is enabled.
+ * @offload_usage: number of offload activities happening on this usb device.
  * @slot_id: Slot ID assigned by xHCI
  * @l1_params: best effor service latency for USB2 L1 LPM state, and L1 timeout.
  * @u1_params: exit latencies for USB3 U1 LPM state, and hub-initiated timeout.
@@ -724,6 +726,8 @@ struct usb_device {
 	unsigned do_remote_wakeup:1;
 	unsigned reset_resume:1;
 	unsigned port_is_suspended:1;
+	unsigned offload_at_suspend:1;
+	int offload_usage;
 	enum usb_link_tunnel_mode tunnel_mode;
 	struct device_link *usb4_link;
 
@@ -841,6 +845,20 @@ static inline void usb_mark_last_busy(struct usb_device *udev)
 { }
 #endif
 
+#if IS_ENABLED(CONFIG_USB_XHCI_SIDEBAND)
+int usb_offload_get(struct usb_device *udev);
+int usb_offload_put(struct usb_device *udev);
+bool usb_offload_check(struct usb_device *udev);
+#else
+
+static inline int usb_offload_get(struct usb_device *udev)
+{ return 0; }
+static inline int usb_offload_put(struct usb_device *udev)
+{ return 0; }
+static inline bool usb_offload_check(struct usb_device *udev)
+{ return false; }
+#endif
+
 extern int usb_disable_lpm(struct usb_device *udev);
 extern void usb_enable_lpm(struct usb_device *udev);
 /* Same as above, but these functions lock/unlock the bandwidth_mutex. */
-- 
2.51.0.384.g4c02a37b29-goog



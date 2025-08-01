Return-Path: <linux-kernel+bounces-752838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E260B17B76
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 05:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908DB166437
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 03:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374CC18E750;
	Fri,  1 Aug 2025 03:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uEdPt6KK"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A271B1917F4
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 03:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754019647; cv=none; b=Z/RY4cMWenst0xdNIu5BpLAKqyxFu5ohpPGd9qPm92d2qyRiCXMIUN98/4628x3KQYq2SyXtTTGwqeyf9GyQhG0IURYYCeOf7gs72mn4f15Yi7FsMPm5VAEiDlfyOSjxea2HnwTpEumntKUa+VdII7JSezY8PAqGpCTPJjLKoXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754019647; c=relaxed/simple;
	bh=b5avWyHXz/1OWZ/aBU1PJnAuPzJmoeYgCrTmNPRbjto=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QMmqzO7Gc8tCRdqFllpB02uy/TZIHWUBh8kjlhpnyxBb7yBs1z592t1zXYfDzX52JvH5+MZ0Hpau5g6DC+b+xw8Q1yVWeLSiVEoeGDCy2n7EQK71RJz7q/4KsvzAZ8cICI3HGwq+ui3iFgbeFYzdND3PjbepbUv2IePt3NG/D8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uEdPt6KK; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3132e7266d3so607323a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 20:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754019645; x=1754624445; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GWbckXu8w1ij4VqvtPCrxTqcWwxpTgFRcitQcVlE1Os=;
        b=uEdPt6KKUJi897Ab9q2D3m9xYmJvopjJfeUpW7nMTouRREXTRNocB5vp6MCyDmeAuM
         Velvzcv75Tc/Iq3gzlD4HgwVUTb6/INUjYXq8TCyvwRElrFMJoApvHe2lIDXpSo8bs3v
         5BMC34UFacCKkW8MQN8UWEaxBQGy7c98nehzxjqlEOWCnRPJdUVbZBt2WhvJfLaai3Ex
         4y57VsYcxHC9kQP7oma8wWYOnP5C+qTNNQ/Z4/H1sg/RiBawR8F1Mi3KE7KzMh4eYzTL
         T0LidH5QcPZNy0XOnpmgqSRwquuFR0UbDmv+v4g3ePER4zOYl6QCsvfSy1IAv+kg8jR7
         63Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754019645; x=1754624445;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GWbckXu8w1ij4VqvtPCrxTqcWwxpTgFRcitQcVlE1Os=;
        b=QccyH2ZZt7/4WNOtu45cm8p+a6zXAfBB/yGktAXq8mNSfmwiVE6J1jaK6prk3WtFQ6
         54vzHGajg+4sxz4gb4ftpTrL2MHaTOpbIyYFnZUALX+Omi52YlaeUgtxxRXDTUYDUdM7
         ajL3lst6T3H7CtfhX7gkU1pCd6vjQ6Csd7u7Grk+Pp/Zt16A5Yvr29nzAozXbUjilhVT
         YK5DQet+ftLDdUYFoyk8pvCtPBrgMMmcUf3w+Wce7QgsqVus4E4/B2KXQAw/bhS6WdBG
         fQQInVqUInanAJDt5FTMqLf3KncAJ7Im4R4pwzqg7FmBHsw2ahPzTMiG1oF6nIzR4nL0
         9hPw==
X-Forwarded-Encrypted: i=1; AJvYcCV4SaVv0P5ZXDKmejK4IwGeMoZWMvXgUhtZY86ZrhGKEUrwEw8eeHDbWBMDKywHrRJQaHm5LU3A1nYPfpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP9bDe1WFmzdPlvQzFaWd4/fDCE+Xa8NX/WuLrV2ppoP4XYAQI
	xpR8ywhSgI/eqbgxjsMOaQuvvQsMapWRksWt5EXqmw0/GoLjzFSAWraUx9QSmrMe/b8NJeS6sav
	ucIot38VGzB0iIz4LVw==
X-Google-Smtp-Source: AGHT+IH7gXP7DQrgws2wF/AzNXCxPAonzRIhflG+PxSPkDwmJiEggxfBi0vCz7RLILsIFXU65hTeWtGUPLYMcuU=
X-Received: from pjbqo6.prod.google.com ([2002:a17:90b:3dc6:b0:311:ff0f:6962])
 (user=guanyulin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3c4f:b0:31f:e6e:7313 with SMTP id 98e67ed59e1d1-31f5dd6fd4cmr13217443a91.3.1754019644947;
 Thu, 31 Jul 2025 20:40:44 -0700 (PDT)
Date: Fri,  1 Aug 2025 03:39:31 +0000
In-Reply-To: <20250801034004.3314737-1-guanyulin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250801034004.3314737-1-guanyulin@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250801034004.3314737-3-guanyulin@google.com>
Subject: [PATCH v15 2/4] usb: offload: add apis for offload usage tracking
From: Guan-Yu Lin <guanyulin@google.com>
To: gregkh@linuxfoundation.org, mathias.nyman@intel.com, hannelotta@gmail.com, 
	zijun.hu@oss.qualcomm.com, xu.yang_2@nxp.com, stern@rowland.harvard.edu, 
	andriy.shevchenko@linux.intel.com, ben@decadent.org.uk, 
	quic_wcheng@quicinc.com, krzysztof.kozlowski@linaro.org, 
	dh10.jung@samsung.com
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
 drivers/usb/core/Kconfig   |  10 +++
 drivers/usb/core/Makefile  |   1 +
 drivers/usb/core/offload.c | 136 +++++++++++++++++++++++++++++++++++++
 drivers/usb/core/usb.c     |   1 +
 include/linux/usb.h        |  18 +++++
 5 files changed, 166 insertions(+)
 create mode 100644 drivers/usb/core/offload.c

diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
index 58e3ca7e4793..d5d38657f929 100644
--- a/drivers/usb/core/Kconfig
+++ b/drivers/usb/core/Kconfig
@@ -143,3 +143,13 @@ config USB_DEFAULT_AUTHORIZATION_MODE
 	  ACPI selecting value 2 is analogous to selecting value 0.
 
 	  If unsure, keep the default value.
+
+config USB_OFFLOAD
+	bool "Enable USB offload feature"
+	depends on USB
+	depends on USB_XHCI_SIDEBAND_SUSPEND
+	help
+	  Offload denotes that there is another co-processor accessing the
+	  USB device via the same USB host controller, creating the
+	  "offloaded USB transfers". Say Y to allow offloaded USB
+	  transfers during system sleep (Suspend-to-RAM).
diff --git a/drivers/usb/core/Makefile b/drivers/usb/core/Makefile
index ac006abd13b3..df26c2885dd8 100644
--- a/drivers/usb/core/Makefile
+++ b/drivers/usb/core/Makefile
@@ -9,6 +9,7 @@ usbcore-y += devio.o notify.o generic.o quirks.o devices.o
 usbcore-y += phy.o port.o
 
 usbcore-$(CONFIG_OF)		+= of.o
+usbcore-$(CONFIG_USB_OFFLOAD)		+= offload.o
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
index fca7735fc660..e6b9ab8b4a34 100644
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
index 9d662c6abb4d..81fc0d93783f 100644
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
 
+#if IS_ENABLED(CONFIG_USB_OFFLOAD)
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
2.50.1.565.gc32cd1483b-goog



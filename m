Return-Path: <linux-kernel+bounces-745947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6A5B120C8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14C483B0908
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592A322D795;
	Fri, 25 Jul 2025 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3vYpa+pj"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F5E17A2F6
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753457171; cv=none; b=UgEFARjRas+IzPAY2qPGeodk9t/EXZJJHuHTxifbQc2FcKsZmW0ec3oB8glc/RfDeIYOFdu37VBD3oVMeFnBkUOxIAUqnaFWws576HrEwrcBHdIACowAf4sMBYNK2arFPfKcRqFS1ysBNAB8J7q2ssOgLOTgX54JDWRmji3erMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753457171; c=relaxed/simple;
	bh=vM0C4mrSdKSCuKDM/N9Vm/nrNAiR03fJag2FaScv0UE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=XbjHykT1qamlZd+s5sPFb5wBaY/mEJE5p2R37zVV7O2Cu2WrXsKE1pcviNJWbNIZCSiVaHPsQqy05hrF2Fx78oUnebJdf1vefA3qfTpIP84TgqQzw2aiATmwVAqP9q3Tmk5AMlzmxkPk33I5W0TZGQe0/YYpFpkr2ORXBnYVN6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3vYpa+pj; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-32b2f5d91c8so19706541fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753457166; x=1754061966; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qk+SQUv4vt7SEdD0ugcPkN1kgWhWABpw3+zdwVt2mDM=;
        b=3vYpa+pjzRJe3DW0KfRQLuJsqwuOf45Ld1MzgatlkuWuG+HIhGuPfIytaCscd8HWSw
         +uJdQyH7ODmBImfB8Z6Lb60Mse3mqLATXe7Aw2qpSYpXQPHmKoAy7Jz9JjdFAqSPXsGH
         IFIXLyQmav9u5GGqtoxu9Uh8riWn1vJr8eVUEeVSYN/cKla4UKtS/B9eo4FDR1XIc6LD
         dow9zpwsAofm9FvLzjIVLpVs7eMhrHutXe8bxNIOpQLpGf1Q+bMEj4ftoTXFgbKyd32H
         IIbjRhwWG1XThD5EBcNPDd7s60GE7ZRq1J4vnSo3P6EdOnPuYazmWBYfLHNS80yG8AkZ
         c+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753457166; x=1754061966;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qk+SQUv4vt7SEdD0ugcPkN1kgWhWABpw3+zdwVt2mDM=;
        b=FrQ5iNQOrW9yQm5kNWbO2yWz7oNF+Ki1c//TDGX2AluSPO7fwlp+CfAT5wJilMZfk2
         67K750SRAcLB1igoEcN0ck7XH1+4MqrnWOvxED1ct9qCndLyj79wggFhzn4LB84SY/nl
         qzsYJH2lsHjhoktn4h5lSz/ig1HFz+ERP0v2du7rPjb69y+aaw3ZhX3tc8ZvMh1tPCX1
         F2uMVtWB3csx6EV9wfTF/cmQWKPnjvScVK4vFGTi26t9oUMbDTd05L/5f/7d2QspFiXw
         /NJqyM1s0OfKMrIKstvb/4xZ8jJUgY0V+AT/tax9N/b+oJu0xJ2HHyafyImwk7gB7h5u
         4ggw==
X-Gm-Message-State: AOJu0YwbC/2MtAPm1GB6suLZQHcJvmG58HBJLnKwoXaKneqIR1VT1XYB
	cYg5d3Tcpk7pQH69G4qmDihlOVmRZUVow3FKpK/r6T7Ki/GTlfdy3z8uuXahEQxYkHrNC/fDtdV
	4Wc6hQ8nePvQGwXU/uOnRI0seBYX7MTjCDogeb8At
X-Gm-Gg: ASbGncsY1p6ecSNtPWeHIikeh8xfm5ITToZTzNJU+NzmzLyu5VxxdwlZl5duPt4skoP
	e1Q+P9TxQCnuahe2pbnrqTYodc/NS6aTZ/ziy4zJ+qcfS0XkaAJFdacaGS8ZXzjzZ7mLd3iQPID
	m6rnQ/Si8QWJ/dS8phgD7Gd034bDHKs67nMeyUSbBd3d/K5ynvyQR/OZr8pluH7rgTS1QS5kQfU
	axhXy24r2kvcUDWZg==
X-Google-Smtp-Source: AGHT+IHYo0a6ErIEg3q39JB1z0GrHw6FIqQfBKc0bTeo+ogFGydfAEhDJpEfQe5k0PHggKISx5sw49A7A8fn3ZA1wIU=
X-Received: by 2002:a2e:a7ca:0:b0:32a:7e4c:e915 with SMTP id
 38308e7fff4ca-331ee7df220mr8469001fa.29.1753457165926; Fri, 25 Jul 2025
 08:26:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Olivier Tuchon <tcn@google.com>
Date: Fri, 25 Jul 2025 17:25:49 +0200
X-Gm-Features: Ac12FXyQq1WaDR8e9bjbhVnghzwK5B8-5opiIBenNHTP2amsS2yr96atNWtsJK8
Message-ID: <CALU+5Va_zeqS5YK7v3HNvDKkg8srqc87P5ZaQUK5tGFUMyNrkg@mail.gmail.com>
Subject: [PATCH] usb: gadget: Add gadgetmon traffic monitor
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The Linux kernel lacks a tool equivalent to usbmon for the gadget side,
making it difficult to debug the lifecycle and performance of usb_requests.
This forces developers into using ad-hoc printk statements for
introspection.

This commit introduces "gadgetmon", a comprehensive framework for
monitoring USB gadget traffic. It consists of two main parts: a new
monitoring interface in the UDC core and a loadable module that
implements this interface to provide data to userspace.

The UDC core is modified to add an optional monitoring interface defined
by struct usb_gadget_mon_operations in <linux/usb/gadget.h>. An
RCU-protected global pointer, gadget_mon_ops, is defined and exported
to allow monitoring modules to register. Hooks are placed in
usb_ep_queue() and usb_gadget_giveback_request() to call this interface,
capturing request submission and completion events.

The new gadgetmon driver is added under drivers/usb/gadget/gadgetmon/.
It implements the monitor operations and creates a character device at
/dev/gadgetmon0. A kfifo ring buffer is used to safely transfer event
records from the fast-path USB callbacks to a userspace reader, minimizing
performance impact and preventing data loss during traffic bursts.

This hook-based design is chosen over tracepoints to efficiently handle
large, variable-length data payloads and to provide a viable debugging
tool on platforms like Android where debugfs may be disabled.

The entire feature is controlled by CONFIG_USB_GADGET_MON. The buffer
size and maximum per-event data capture size are tunable via Kconfig to
allow the feature to be adapted for different devices and debugging
scenarios.

Signed-off-by: Oliv <tcn@google.com>
---
 drivers/usb/gadget_mon/Kconfig          |  39 ++++
 drivers/usb/gadget_mon/Makefile         |   8 +
 drivers/usb/gadget_mon/gadget_mon.h     |  66 ++++++
 drivers/usb/gadget_mon/gadgetmon_main.c | 298 ++++++++++++++++++++++++
 4 files changed, 411 insertions(+)
 create mode 100644 drivers/usb/gadget_mon/Kconfig
 create mode 100644 drivers/usb/gadget_mon/Makefile
 create mode 100644 drivers/usb/gadget_mon/gadget_mon.h
 create mode 100644 drivers/usb/gadget_mon/gadgetmon_main.c

diff --git a/drivers/usb/gadget_mon/Kconfig b/drivers/usb/gadget_mon/Kconfig
new file mode 100644
index 000000000000..113423a2a96f
--- /dev/null
+++ b/drivers/usb/gadget_mon/Kconfig
@@ -0,0 +1,39 @@
+#SPDX - License - Identifier : GPL - 2.0
+#
+#USB Gadget monitoring configuration
+#
+
+config USB_GADGET_MON
+  tristate "Gadget-side USB monitor"
+  depends on USB_GADGET
+  help
+    This option enables a low-level monitor for the USB gadget
+    subsystem, similar to what usbmon provides for the host side.
+
+    It creates a character device (/dev/gadgetmon0) that outputs a
+    stream of all USB request submissions and completions, allowing
+    for detailed debugging and performance analysis of gadget drivers.
+
+    This is primarily a tool for developers. If you are not developing
+    or debugging a USB gadget function driver, say N.
+
+config GADGETMON_BUFFER_SIZE_MB
+ int "Buffer size for gadget monitor (in MiB)"
+ depends on USB_GADGET_MON
+ default 4
+ help
+   Sets the size of the ring buffer used to transfer event data
+   from the kernel to userspace. A larger buffer reduces the risk
+   of dropping events during high-speed traffic bursts but uses
+   more kernel memory. Value is in Megabytes (MiB).
+
+config GADGETMON_DATA_MAX_KB
+ int "Max data payload per event (in KiB)"
+ depends on USB_GADGET_MON
+ default 64
+ help
+   Sets the maximum amount of payload data captured for a single
+   event. A smaller value saves a significant amount of buffer
+   space, allowing more event headers to be stored. A larger
+   value is only needed if you must debug the contents of very
+   large USB transfers. Value is in Kilobytes (KiB).
diff --git a/drivers/usb/gadget_mon/Makefile b/drivers/usb/gadget_mon/Makefile
new file mode 100644
index 000000000000..b9d7610c72a3
--- /dev/null
+++ b/drivers/usb/gadget_mon/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the gadget monitoring driver
+#
+
+gadgetmon-y := gadgetmon_main.o
+
+obj-$(CONFIG_USB_GADGET_MON) += gadgetmon.o
diff --git a/drivers/usb/gadget_mon/gadget_mon.h
b/drivers/usb/gadget_mon/gadget_mon.h
new file mode 100644
index 000000000000..d87a891b8a93
--- /dev/null
+++ b/drivers/usb/gadget_mon/gadget_mon.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_USB_MON_GADGET_H
+#define __LINUX_USB_MON_GADGET_H
+
+#include <linux/kconfig.h>
+
+#include <linux/usb/ch9.h>
+#include <linux/usb/gadget.h>
+
+/* The device name for the monitor interface */
+#define GADGETMON_DEVICE_NAME "gadgetmon0"
+/* The device class name */
+#define GADGETMON_CLASS_NAME "gadgetmon"
+
+/* Size of the kernel-to-userspace ring buffer */
+#define GADGETMON_BUFFER_SIZE (CONFIG_GADGETMON_BUFFER_SIZE_MB * 1014 * 1024)
+/* Max data payload to capture per event */
+#define GADGETMON_DATA_MAX (CONFIG_GADGETMON_DATA_MAX_KB * 1024)
+
+/* Magic number, "mnof" as a little-endian u32 */
+#define GADGETMON_MAGIC 0x666f6e6d
+
+/**
+ * enum gadgetmon_event_type - Type of event captured by the monitor.
+ * @GADGETMON_EVENT_SUBMIT: A usb_request was submitted to an endpoint.
+ * @GADGETMON_EVENT_COMPLETE: A usb_request completed successfully.
+ * @GADGETMON_EVENT_ERROR: A usb_request completed with an error.
+ */
+enum gadgetmon_event_type {
+ GADGETMON_EVENT_SUBMIT = 'S',
+ GADGETMON_EVENT_COMPLETE = 'C',
+ GADGETMON_EVENT_ERROR = 'E',
+};
+
+/**
+ * struct gadgetmon_hdr - Event record header for gadget monitoring.
+ * @magic:      Magic number for synchronization ('mnof').
+ * @ts_usec:    Timestamp, microseconds part.
+ * @ts_sec:     Timestamp, seconds part (from ktime_get_real_ts64).
+ * @id:         A unique identifier for the life of a usb_request.
+ * @status:     For 'C'/'E', the request status. For 'S', the return
+ * code from usb_ep_queue().
+ * @req_len:    The original length of the request buffer.
+ * @actual_len: The actual length transferred on completion.
+ * @data_len:   The length of the data payload following this header.
+ * @type:       Event type, see enum gadgetmon_event_type.
+ * @xfer_type:  Transfer type (USB_ENDPOINT_XFER_*).
+ * @epnum:      Endpoint number.
+ * @dir:        Endpoint direction (USB_DIR_IN or USB_DIR_OUT).
+ */
+struct gadgetmon_hdr {
+ u32 magic;
+ s32 ts_usec;
+ s64 ts_sec;
+ u64 id;
+ int status;
+ u32 req_len;
+ u32 actual_len;
+ u32 data_len;
+ u8 type;
+ u8 xfer_type;
+ u8 epnum;
+ u8 dir;
+};
+
+#endif /* __LINUX_USB_MON_GADGET_H */
diff --git a/drivers/usb/gadget_mon/gadgetmon_main.c
b/drivers/usb/gadget_mon/gadgetmon_main.c
new file mode 100644
index 000000000000..9017f91808ae
--- /dev/null
+++ b/drivers/usb/gadget_mon/gadgetmon_main.c
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * gadgetmon.c - USB Gadget Monitoring Driver
+ *
+ * This module hooks into the UDC core to capture USB request
+ * submissions and completions, providing a character device interface
+ * (/dev/gadgetmon0) for userspace tools to read the event stream.
+ */
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/kfifo.h>
+#include <linux/module.h>
+#include <linux/rcupdate.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/time64.h>
+#include <linux/uaccess.h>
+#include <linux/wait.h>
+
+#include "gadget_mon.h"
+
+#include <linux/usb/gadget.h>
+
+/* character device and class infrastructure */
+static dev_t mon_dev_t;
+static struct cdev mon_cdev;
+static struct class *mon_class;
+
+/* the main ring buffer for passing events to userspace */
+struct kfifo mon_fifo;
+/* a spinlock to protect concurrent access to the kfifo */
+static spinlock_t mon_lock;
+/* a wait queue for blocking reads from userspace */
+static wait_queue_head_t mon_read_wait;
+
+/*
+ * gadgetmon_event - builds an event record and queue it to the FIFO
+ * @event_type: the type of event ('S', 'C', or 'E')
+ * @ep: the endpoint associated with the event
+ * @req: the USB request associated with the event
+ * @status: for 'S', the return from usb_ep_queue(); for 'C'/'E', req->status
+ */
+static void gadgetmon_event(enum gadgetmon_event_type event_type,
+     struct usb_ep *ep, const struct usb_request *req,
+     int status)
+{
+ unsigned long flags;
+ struct gadgetmon_hdr hdr;
+ u32 payload_len;
+ u32 total_len;
+ struct timespec64 ts;
+
+ if (!req || !ep)
+ return;
+
+ ktime_get_real_ts64(&ts);
+
+ /* prepare the header */
+ hdr.magic = GADGETMON_MAGIC;
+ hdr.ts_sec = ts.tv_sec;
+ hdr.ts_usec = ts.tv_nsec / NSEC_PER_USEC;
+ hdr.id = (u64)(uintptr_t)req;
+ hdr.type = event_type;
+ hdr.xfer_type = usb_endpoint_type(ep->desc);
+ hdr.epnum = usb_endpoint_num(ep->desc);
+ hdr.dir = usb_endpoint_dir_in(ep->desc) ? USB_DIR_IN : USB_DIR_OUT;
+ hdr.status = status;
+ hdr.req_len = req->length;
+ hdr.actual_len = (event_type == GADGETMON_EVENT_SUBMIT) ? 0 :
+   req->actual;
+
+ /* determine how much payload data to capture */
+ payload_len = (event_type == GADGETMON_EVENT_SUBMIT) ? req->length :
+        req->actual;
+ if (payload_len > GADGETMON_DATA_MAX)
+ payload_len = GADGETMON_DATA_MAX;
+ /*
+ * optimization: for an OUT submission (host-to-device), the data
+ * has not yet arrived from the host. The buffer is an empty
+ * placeholder, so its content is not captured to save space.
+ */
+ if (event_type == GADGETMON_EVENT_SUBMIT && hdr.dir == USB_DIR_OUT)
+ payload_len = 0;
+
+ hdr.data_len = payload_len;
+ total_len = sizeof(hdr) + payload_len;
+
+ /* lock and queue the event into the FIFO */
+ spin_lock_irqsave(&mon_lock, flags);
+
+ if (kfifo_avail(&mon_fifo) < total_len) {
+ /* not enough space, drop the event silently */
+ spin_unlock_irqrestore(&mon_lock, flags);
+ return;
+ }
+
+ kfifo_in(&mon_fifo, &hdr, sizeof(hdr));
+ if (payload_len > 0)
+ kfifo_in(&mon_fifo, req->buf, payload_len);
+
+ spin_unlock_irqrestore(&mon_lock, flags);
+
+ /* wake up any readers waiting for data */
+ wake_up_interruptible(&mon_read_wait);
+}
+
+/* called from usb_ep_queue() in the UDC core */
+static void gadgetmon_request_queue(struct usb_ep *ep,
+     const struct usb_request *req, int status)
+{
+ gadgetmon_event(GADGETMON_EVENT_SUBMIT, ep, req, status);
+}
+
+/* called from usb_gadget_giveback_request() in the UDC core */
+static void gadgetmon_request_giveback(struct usb_ep *ep,
+        const struct usb_request *req)
+{
+ enum gadgetmon_event_type type;
+
+ type = (req->status == 0) ? GADGETMON_EVENT_COMPLETE :
+     GADGETMON_EVENT_ERROR;
+ gadgetmon_event(type, ep, req, req->status);
+}
+
+/* the implementation of the monitor operations interface */
+static const struct usb_gadget_mon_operations gadget_mon_ops_impl = {
+ .request_queue = gadgetmon_request_queue,
+ .request_giveback = gadgetmon_request_giveback,
+};
+
+/*
+ * gadgetmon_open - called when the device file is opened.
+ */
+static int gadgetmon_open(struct inode *inode, struct file *file)
+{
+ return 0;
+}
+
+/**
+ * gadgetmon_release - called when the device file is closed.
+ */
+static int gadgetmon_release(struct inode *inode, struct file *file)
+{
+ return 0;
+}
+
+/*
+ * gadgetmon_read - reads monitoring data from the ring buffer
+ *
+ * Reads event records from the kfifo and copies them to userspace. The read
+ * is blocking by default, but respects the O_NONBLOCK file flag. A temporary
+ * buffer is used to copy data out of the fifo under the spinlock, allowing
+ * the subsequent copy_to_user() to sleep safely.
+ */
+static ssize_t gadgetmon_read(struct file *file, char __user *buf,
size_t count,
+       loff_t *off)
+{
+ int ret = 0;
+ unsigned int copied;
+ char *tmp_buf;
+ size_t len_to_copy;
+
+ if ((file->f_flags & O_NONBLOCK) && kfifo_is_empty(&mon_fifo))
+ return -EAGAIN;
+
+ /* wait for data to become available */
+ ret = wait_event_interruptible(mon_read_wait,
+        !kfifo_is_empty(&mon_fifo));
+ if (ret)
+ return ret; /* -ERESTARTSYS if interrupted by a signal */
+
+ len_to_copy = min_t(size_t, count, GADGETMON_BUFFER_SIZE);
+ tmp_buf = kmalloc(len_to_copy, GFP_KERNEL);
+ if (!tmp_buf)
+ return -ENOMEM;
+
+ spin_lock_irq(&mon_lock);
+ copied = kfifo_out(&mon_fifo, tmp_buf, len_to_copy);
+ spin_unlock_irq(&mon_lock);
+
+ if (copied > 0) {
+ if (copy_to_user(buf, tmp_buf, copied))
+ /* data is lost - acceptable for a monitor */
+ ret = -EFAULT;
+ }
+
+ kfree(tmp_buf);
+
+ /* On success, return the number of bytes copied, else the error */
+ return (ret < 0) ? ret : copied;
+}
+
+/* The file operations structure for our character device */
+static const struct file_operations mon_fops = {
+ .owner = THIS_MODULE,
+ .open = gadgetmon_open,
+ .release = gadgetmon_release,
+ .read = gadgetmon_read,
+};
+
+/*
+ * gadgetmon_init - Module entry point.
+ *
+ * Allocates all necessary resources (kfifo, locks, char device) and
+ * registers the monitoring callbacks with the UDC core.
+ */
+static int __init gadgetmon_init(void)
+{
+ int ret;
+
+ pr_info("Gadget Monitoring driver loading\n");
+
+ ret = kfifo_alloc(&mon_fifo, GADGETMON_BUFFER_SIZE, GFP_KERNEL);
+ if (ret) {
+ pr_err("gadgetmon: Failed to allocate kfifo\n");
+ return -ENOMEM;
+ }
+
+ spin_lock_init(&mon_lock);
+ init_waitqueue_head(&mon_read_wait);
+
+ ret = alloc_chrdev_region(&mon_dev_t, 0, 1, GADGETMON_DEVICE_NAME);
+ if (ret < 0) {
+ pr_err("gadgetmon: Failed to allocate char device region\n");
+ goto err_free_fifo;
+ }
+
+ mon_class = class_create(GADGETMON_CLASS_NAME);
+ if (IS_ERR(mon_class)) {
+ pr_err("gadgetmon: Failed to create device class\n");
+ ret = PTR_ERR(mon_class);
+ goto err_unregister_chrdev;
+ }
+
+ cdev_init(&mon_cdev, &mon_fops);
+ mon_cdev.owner = THIS_MODULE;
+
+ ret = cdev_add(&mon_cdev, mon_dev_t, 1);
+ if (ret < 0) {
+ pr_err("gadgetmon: Failed to add char device\n");
+ goto err_destroy_class;
+ }
+
+ if (IS_ERR(device_create(mon_class, NULL, mon_dev_t, NULL,
+ GADGETMON_DEVICE_NAME))) {
+ pr_err("gadgetmon: Failed to create device file\n");
+ ret = -ENODEV;
+ goto err_del_cdev;
+ }
+
+ /* Atomically publish our monitoring functions to the UDC core */
+ rcu_assign_pointer(gadget_mon_ops, &gadget_mon_ops_impl);
+
+ pr_info("gadgetmon: Gadget Monitoring driver loaded\n");
+
+ return 0;
+
+err_del_cdev:
+ cdev_del(&mon_cdev);
+err_destroy_class:
+ class_destroy(mon_class);
+err_unregister_chrdev:
+ unregister_chrdev_region(mon_dev_t, 1);
+err_free_fifo:
+ kfifo_free(&mon_fifo);
+
+ return ret;
+}
+
+/**
+ * gadgetmon_exit - Module exit point.
+ *
+ * Unregisters the interface and frees all resources. Uses RCU synchronization
+ * to ensure no callbacks are in-flight when resources are freed.
+ */
+static void __exit gadgetmon_exit(void)
+{
+ rcu_assign_pointer(gadget_mon_ops, NULL);
+ synchronize_rcu();
+
+ device_destroy(mon_class, mon_dev_t);
+ cdev_del(&mon_cdev);
+ class_destroy(mon_class);
+ unregister_chrdev_region(mon_dev_t, 1);
+ kfifo_free(&mon_fifo);
+
+ pr_info("gadgetmon: Gadget Monitoring driver unloaded\n");
+}
+
+module_init(gadgetmon_init);
+module_exit(gadgetmon_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("USB Gadget Traffic Monitor");
+MODULE_AUTHOR("Olivier Tuchon");
-- 
2.50.1.487.gc89ff58d15-goog


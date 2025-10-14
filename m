Return-Path: <linux-kernel+bounces-853292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB319BDB204
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B626958050F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AFE3043D1;
	Tue, 14 Oct 2025 19:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rMRTbd7c"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E886330275C
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760471470; cv=none; b=I3z6j/S8nwMZ4NKZP6SydG6i82W7NWTaOLeoHAMgs7wIJAhtNXMAxzIIGF0bpXajOiupogMrHSqb/a3tEq3VF8mOnjHdZGrvO/Nc24YHeER8CClNbds/dPy0m0cezUHilOh8IyMbeqBQFF3toDNNAFube/nxTCnNVG0VIdNwJHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760471470; c=relaxed/simple;
	bh=M9WRR443R6qxqNQvDIYacnnrQp0IFkkyuLGDmxJErm4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HKhNJQJym+IGE5U/b8oKAuHCEnsnlJ8Fx7J7+iLTgZNu/+AX/CqqnG1rle43riluEcEmH4MkYdRk0ta06r26EgZQRpaBnfnnFJ6GV3f9W5Ce5voaVALcAPdozPSWh0K64a483KY3ngSMIoFYy1h4jkx/onXi42arkICc9ZnDJ4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rMRTbd7c; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3304def7909so9676022a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760471468; x=1761076268; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TSnZFCZ64RkJLFEmGTXA6t+vlnwDhOD2bNaCJ3ABIL4=;
        b=rMRTbd7cgcOC2CRi/Dx1V4zrTUflsgPTxyjwa7DBqY8C/mGzK1SBoKKc37OBgiKxFh
         QQ+6bxLB6HGBPflo+wocwcZaWYnrNwsc1GLD72dFaf7veCmqvk9CW3gOc6QQ50jrHZ93
         W51NUBkML9my5oUhz58+7T+3jE23Ndj/5DF+JFGR05mGCce98WQnLm06CgUdPUYnGtWt
         Qzn2RD02JyNoR2j/3TtGW2uNNAK2TLxCjuI9j4Ze9ltBSJur+6GFZSfVotKem1l0TZ6l
         xGJRpL6vzHDRp8vHlvOA7xAwu6SqKP577GwY+zeSFWorQ/0bU4G5jZBPnJsug1YVxvn6
         C5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760471468; x=1761076268;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TSnZFCZ64RkJLFEmGTXA6t+vlnwDhOD2bNaCJ3ABIL4=;
        b=I9KWnP1u2+610Or4ziTw0aRJ7I6b/7zxVG6P6IsEU1pFhMZ2Qb9+YG10aMUDV0wESk
         8BbGDNPf9CpfsvmGAMH3XRnxSLZws31l06CexVFkVKhrjzbZXlsLBPUQECkkam0dO4/s
         M3xYNkZ3Q97ta/gWnNn3lkSe72RhihFbTkiqZgz1e0LWDisch6YS3Ejbr5oyjEcHiuf6
         wWlSkAVJRuRQSIT4zlJ7IC9C00JAPs8gMCyqBA0z1/wE6uwBjFZuIXPRgnzBh99dxVlh
         z4tdXGxhnWZkfnFl+ZWXGDt6vH5uSlSpz1qrK/me5xc83eIUFmE6UcqfpYrWt+i5sNg7
         XCWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh1ArWO1L1lLNh6CUfcPqH/8QStSAKdPeHkw0Rv+0q4N54XjE5ZkkqrKdihh3HmUHztHhumItDa711s3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Un9LJ0mRz6MgYDNRiiuarv403hDJ+s2lnT2NzzFS7kuy8TFH
	oT/XsN6Ljg08Vd+n2FCzFuS+pXco6jLHPyVo7bEca7HWvhlyM1Mij54dLM4A6BSMDJvuUugmA97
	tI5GhpA==
X-Google-Smtp-Source: AGHT+IFgpobZsj69hw26FSFP4KGGLP5xCT79tZjTdZUcK5ZAa+9I3XG+B+EckyxqNl8SVuiX5b7FY1+pnLQ=
X-Received: from pjbcz14.prod.google.com ([2002:a17:90a:d44e:b0:33b:51fe:1a93])
 (user=khtsai job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b49:b0:330:a301:35f4
 with SMTP id 98e67ed59e1d1-33b513b4b46mr35251656a91.20.1760471468285; Tue, 14
 Oct 2025 12:51:08 -0700 (PDT)
Date: Wed, 15 Oct 2025 03:50:52 +0800
In-Reply-To: <20251015-usbcore-tracing-v2-0-5a14b5b9d4e0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251015-usbcore-tracing-v2-0-5a14b5b9d4e0@google.com>
X-Developer-Key: i=khtsai@google.com; a=ed25519; pk=abA4Pw6dY2ZufSbSXW9mtp7xiv1AVPtgRhCFWJSEqLE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760471462; l=5869;
 i=khtsai@google.com; s=20250916; h=from:subject:message-id;
 bh=M9WRR443R6qxqNQvDIYacnnrQp0IFkkyuLGDmxJErm4=; b=igvHC1yDf7OSuwXjZycKtApqQXsfqpEfO/xCZmh3TnVd9nWd/oemVexhSu8+rSp4y/0fHfDDS
 aogxr6zVMNWClln2+TF23uaak2smULdRC7MeYnPGyo5P3tL6SJqJPNY
X-Mailer: b4 0.14.2
Message-ID: <20251015-usbcore-tracing-v2-2-5a14b5b9d4e0@google.com>
Subject: [PATCH v2 2/2] usb: core: Add tracepoints for device allocation and
 state changes
From: Kuen-Han Tsai <khtsai@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Mathias Nyman <mathias.nyman@linux.intel.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kuen-Han Tsai <khtsai@google.com>
Content-Type: text/plain; charset="utf-8"

Introduce new tracepoints to the USB core to improve debuggability of
USB device lifecycle events.

The following tracepoints are added:

- usb_alloc_dev: Triggered when a new USB device structure is allocated,
providing insights into early device setup.
- usb_set_device_state: Triggered when the USB device state changes,
allowing observation of the device's state transitions.

These tracepoints capture detailed information about the USB device,
including its name, speed, state, bus current value, and authorized
flag. This will aid developers in diagnosing issues related to device
enumeration within the USB subsystem.

Examples:
 usb_alloc_dev: usb 1-1 speed UNKNOWN state attached 0mA [authorized]
 usb_set_device_state: usb 1-1 speed UNKNOWN state powered 0mA [authorized]
 usb_set_device_state: usb 1-1 speed full-speed state default 500mA [authorized]
 usb_set_device_state: usb 1-1 speed full-speed state default 500mA [authorized]
 usb_set_device_state: usb 1-1 speed full-speed state addressed 500mA [authorized]
 usb_set_device_state: usb 1-1 speed full-speed state configured 500mA [authorized]
 usb_set_device_state: usb 1-1 speed full-speed state suspended 500mA [authorized]
 usb_set_device_state: usb 1-1 speed full-speed state not attached 500mA [authorized]

Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
---
 drivers/usb/core/Makefile |  5 +++-
 drivers/usb/core/hub.c    |  2 ++
 drivers/usb/core/trace.c  |  6 +++++
 drivers/usb/core/trace.h  | 61 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/core/usb.c    |  2 ++
 5 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/Makefile b/drivers/usb/core/Makefile
index 766000b4939ef937a04848aa9cc45d8bb8860fe5..60ea76160122b98e604ac416bf0ec8f398341411 100644
--- a/drivers/usb/core/Makefile
+++ b/drivers/usb/core/Makefile
@@ -3,10 +3,13 @@
 # Makefile for USB Core files and filesystem
 #
 
+# define_trace.h needs to know how to find our header
+CFLAGS_trace.o                  := -I$(src)
+
 usbcore-y := usb.o hub.o hcd.o urb.o message.o driver.o
 usbcore-y += config.o file.o buffer.o sysfs.o endpoint.o
 usbcore-y += devio.o notify.o generic.o quirks.o devices.o
-usbcore-y += phy.o port.o
+usbcore-y += phy.o port.o trace.o
 
 usbcore-$(CONFIG_OF)		+= of.o
 usbcore-$(CONFIG_USB_XHCI_SIDEBAND)	+= offload.o
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index d0f5342976a9196e8c92e7bdb0a909207f69ebb5..7c23baeb68aa864f74ee4dff56e39f70ee713bf7 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -40,6 +40,7 @@
 #include "hub.h"
 #include "phy.h"
 #include "otg_productlist.h"
+#include "trace.h"
 
 #define USB_VENDOR_GENESYS_LOGIC		0x05e3
 #define USB_VENDOR_SMSC				0x0424
@@ -2159,6 +2160,7 @@ static void update_usb_device_state(struct usb_device *udev,
 
 	udev->state = new_state;
 	update_port_device_state(udev);
+	trace_usb_set_device_state(udev);
 }
 
 static void recursively_mark_NOTATTACHED(struct usb_device *udev)
diff --git a/drivers/usb/core/trace.c b/drivers/usb/core/trace.c
new file mode 100644
index 0000000000000000000000000000000000000000..607bcf639d27f15a628537a86155fa92df33fa14
--- /dev/null
+++ b/drivers/usb/core/trace.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Google LLC
+ */
+#define CREATE_TRACE_POINTS
+#include "trace.h"
diff --git a/drivers/usb/core/trace.h b/drivers/usb/core/trace.h
new file mode 100644
index 0000000000000000000000000000000000000000..903e57dc273af58781ab3fb2f341690d4289bdf8
--- /dev/null
+++ b/drivers/usb/core/trace.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2025 Google LLC
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM usbcore
+
+#if !defined(_USB_CORE_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _USB_CORE_TRACE_H
+
+#include <linux/types.h>
+#include <linux/tracepoint.h>
+#include <linux/usb.h>
+
+DECLARE_EVENT_CLASS(usb_core_log_usb_device,
+	TP_PROTO(struct usb_device *udev),
+	TP_ARGS(udev),
+	TP_STRUCT__entry(
+		__string(name, dev_name(&udev->dev))
+		__field(enum usb_device_speed, speed)
+		__field(enum usb_device_state, state)
+		__field(unsigned short, bus_mA)
+		__field(unsigned, authorized)
+	),
+	TP_fast_assign(
+		__assign_str(name);
+		__entry->speed = udev->speed;
+		__entry->state = udev->state;
+		__entry->bus_mA = udev->bus_mA;
+		__entry->authorized = udev->authorized;
+	),
+	TP_printk("usb %s speed %s state %s %dmA [%s]",
+		__get_str(name),
+		usb_speed_string(__entry->speed),
+		usb_state_string(__entry->state),
+		__entry->bus_mA,
+		__entry->authorized ? "authorized" : "unauthorized")
+);
+
+DEFINE_EVENT(usb_core_log_usb_device, usb_set_device_state,
+	TP_PROTO(struct usb_device *udev),
+	TP_ARGS(udev)
+);
+
+DEFINE_EVENT(usb_core_log_usb_device, usb_alloc_dev,
+	TP_PROTO(struct usb_device *udev),
+	TP_ARGS(udev)
+);
+
+
+#endif /* _USB_CORE_TRACE_H */
+
+/* this part has to be here */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace
+
+#include <trace/define_trace.h>
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index b6b0b84895237e2c49b5e8015627ad2c24ee31c2..e740f7852bcdebdbcc30025dcddb16c062265d47 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -46,6 +46,7 @@
 #include <linux/dma-mapping.h>
 
 #include "hub.h"
+#include "trace.h"
 
 const char *usbcore_name = "usbcore";
 
@@ -746,6 +747,7 @@ struct usb_device *usb_alloc_dev(struct usb_device *parent,
 #endif
 
 	dev->authorized = usb_dev_authorized(dev, usb_hcd);
+	trace_usb_alloc_dev(dev);
 	return dev;
 }
 EXPORT_SYMBOL_GPL(usb_alloc_dev);

-- 
2.51.0.788.g6d19910ace-goog



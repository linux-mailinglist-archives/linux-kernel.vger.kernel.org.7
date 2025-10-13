Return-Path: <linux-kernel+bounces-849881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E408BBD1291
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 04:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00FD63BE717
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 02:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7896A2EBBAB;
	Mon, 13 Oct 2025 02:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UfjByJKw"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8A4280035
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 02:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760320907; cv=none; b=kJRso92QNmDZ/rVjLrTEDArfhHMfVw7HS2/B6QNNx3GsREQLi9r0FCZD9G/znz0lSqW6GYPogIEiGkmfCskDi7rm2dctMAzRx4AWiGondag5534DOGyWk1jChYZ+rZW3SchEwZIk8t5gaXkb3VpHTESqxQO7ENjaUnivmjIcHGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760320907; c=relaxed/simple;
	bh=cGrDWQbl1KjpVjUGq5IAO3MhdrEeWTCMATf7WJS5b6c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TGbKNaGZ5cozGKlm1qtlc5fV6iP6rY/Y3NOQ5LHwkKfgshevK70os9uRMtquz8yLUEn0EzsUguv2xAXeSkXE5HubBtZ+xiIwXNS92J0wzwLYyMVx9LJla3cU8+P8ABxxO/EhP/JBx+spOwaqALniHJz5JQkH5Ed9DkvGmYvBkPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UfjByJKw; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-272b7bdf41fso90482205ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760320905; x=1760925705; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=idZeMEzFynmM4Yz87Kr2/ZMpJ43boOVUflCLeT840S8=;
        b=UfjByJKwVqnF7eul3/s8KI8Q+6uY9h0g67hu9Lz9Q1I31vWkc0XoCIW9KohhhY46tf
         WBoHN5B4RSN3m3OuA/nD86NT67Ex7gvjigEfMxDz87ijlIFDqIh6l/8bcyz5/AZwSxvD
         A0gfIU0+qw25CET8gXixBVyVOrZz3iLYC8gwyX1FGr95RVBaeZT8K6ZKoPEuQB2yjCjE
         A4sB0jCqK4C8yvbgmY7H5wJFpXxagGPutvQQiXxU94nK5vhhbmieau/NjLEuBfXYxRKG
         /YnbaeKXHUUVCWRmRzaFWa6nQCcs7kvVZmxbL7WcPIL/nnvxQZa+y4eKthTkXoIXMXye
         vKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760320905; x=1760925705;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=idZeMEzFynmM4Yz87Kr2/ZMpJ43boOVUflCLeT840S8=;
        b=Tk5laR97SNVzcQ3mX8xdaGsZbOw8SDRvC89cqXH9duVNqmoNCNwqWaPQGblpl8WDUG
         g+M6pzXBh5me7G0MD5xYeOuo0wNUm2rX7U7giwPbWiI/ncwr20oz4IVOpvppRBwhZJwZ
         zyi10MN838n716DF7KVKoC4ITTdERIxl+gEi457BGFACkkUj1lQLLQNKhirJVC0Z0QmT
         J7E9eb2pWGIIaM39LyjbReH/LRYw39HIU48LLCGhhQnGPQmVPo2CZbqEVtH89k56SsGP
         XH83URcxWsX/Mes7hpHDxhSTJRN1BZVxpJ/KJbNt9targEX/C35MbaZNuPGKtRvMTpWO
         Ixgg==
X-Forwarded-Encrypted: i=1; AJvYcCVFFSxgOPrnH7W+LP8CzP0pNJRRl+kgkCSSZJxqqJkIwBfdUwHFy05VOK01GuwHRvcpXzKmOMlnT8Lu+BE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5AexC68NjKwxi70qxhQ2DAYjyao+gTehqkWXYaecgVFyDdg+1
	BcTftOJiBqoPVOOpl9jr/FsNn5+H7wOjkmc5pZH1vDBrW+1cMoK3rrr6IkVH7PqW0VR4DTxK97n
	liRAT+g==
X-Google-Smtp-Source: AGHT+IF3SgXMgz0ThHHx1rlALTh1Z9Z6N/RtNr915FZ2PYaekTLVhQ9rSpxCm3gc/dRa+D3CTTt+F3bexzc=
X-Received: from pjbsq6.prod.google.com ([2002:a17:90b:5306:b0:32b:ae4c:196c])
 (user=khtsai job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2a87:b0:24a:d213:9e74
 with SMTP id d9443c01a7336-290272dfbb7mr264993255ad.49.1760320905070; Sun, 12
 Oct 2025 19:01:45 -0700 (PDT)
Date: Mon, 13 Oct 2025 10:01:23 +0800
In-Reply-To: <20251013-usbcore-tracing-v1-0-b885a3121b09@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013-usbcore-tracing-v1-0-b885a3121b09@google.com>
X-Developer-Key: i=khtsai@google.com; a=ed25519; pk=abA4Pw6dY2ZufSbSXW9mtp7xiv1AVPtgRhCFWJSEqLE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760320897; l=5685;
 i=khtsai@google.com; s=20250916; h=from:subject:message-id;
 bh=cGrDWQbl1KjpVjUGq5IAO3MhdrEeWTCMATf7WJS5b6c=; b=Vg1PNgDDOsJV4tGBIEFwbR414NtO0ueQmvT69trGfXK4aXLtRJrAZxHvFpkjqPIn/CMYzsdaf
 jMzwYaco8lPCtcF8C54VPPO5NM6LgTC1xBoBfQOsXJG/FUO2AH0weGg
X-Mailer: b4 0.14.2
Message-ID: <20251013-usbcore-tracing-v1-2-b885a3121b09@google.com>
Subject: [PATCH 2/2] usb: core: Add tracepoints for device allocation and
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
 usb_alloc_dev: usb 1-1 speed 0 state 1 0mA [authorized]
 usb_set_device_state: usb 1-1 speed 0 state 2 0mA [authorized]
 usb_set_device_state: usb 1-1 speed 2 state 5 500mA [authorized]
 usb_set_device_state: usb 1-1 speed 2 state 5 500mA [authorized]
 usb_set_device_state: usb 1-1 speed 2 state 6 500mA [authorized]
 usb_set_device_state: usb 1-1 speed 2 state 7 500mA [authorized]
 usb_set_device_state: usb 1-1 speed 2 state 8 500mA [authorized]
 usb_set_device_state: usb 1-1 speed 2 state 0 500mA [authorized]

Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
---
 drivers/usb/core/Makefile |  4 ++++
 drivers/usb/core/hub.c    |  2 ++
 drivers/usb/core/trace.c  |  6 +++++
 drivers/usb/core/trace.h  | 61 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/core/usb.c    |  2 ++
 5 files changed, 75 insertions(+)

diff --git a/drivers/usb/core/Makefile b/drivers/usb/core/Makefile
index 766000b4939ef937a04848aa9cc45d8bb8860fe5..11647942ff3ae6c688dac043218f7d886a3e2f88 100644
--- a/drivers/usb/core/Makefile
+++ b/drivers/usb/core/Makefile
@@ -3,10 +3,14 @@
 # Makefile for USB Core files and filesystem
 #
 
+# define_trace.h needs to know how to find our header
+CFLAGS_trace.o                  := -I$(src)
+
 usbcore-y := usb.o hub.o hcd.o urb.o message.o driver.o
 usbcore-y += config.o file.o buffer.o sysfs.o endpoint.o
 usbcore-y += devio.o notify.o generic.o quirks.o devices.o
 usbcore-y += phy.o port.o
+usbcore-y += trace.o
 
 usbcore-$(CONFIG_OF)		+= of.o
 usbcore-$(CONFIG_USB_XHCI_SIDEBAND)	+= offload.o
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index ce3d94c960470e9be7979b1021551eab5fd03517..f66a197700c8b3414c624b8ec1bb94c629e3280c 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -40,6 +40,7 @@
 #include "hub.h"
 #include "phy.h"
 #include "otg_productlist.h"
+#include "trace.h"
 
 #define USB_VENDOR_GENESYS_LOGIC		0x05e3
 #define USB_VENDOR_SMSC				0x0424
@@ -2159,6 +2160,7 @@ static inline void update_usb_device_state(struct usb_device *udev,
 
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
index 0000000000000000000000000000000000000000..db6edf570640e7af0598ccf2c7bd71b187605a42
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
+	TP_printk("usb %s speed %d state %d %dmA [%s]",
+		__get_str(name),
+		__entry->speed,
+		__entry->state,
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
2.51.0.740.g6adb054d12-goog



Return-Path: <linux-kernel+bounces-822727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9084FB8487E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49886623D5A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0D5305045;
	Thu, 18 Sep 2025 12:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPcw21yg"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7A6304964
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758197626; cv=none; b=CHX8yUjoKg41pRAlwCKWXLZqpYFB1PzZnsMf0MR15GvcHw/q87XBATxkDpHb+HQpF93dnRI0fAIXoomzsWco2CLdz8XxAn7W19C4z1EdI4dtuocUd6t6xXoeN3GD58GxZ33Qiz3CCqOYxulrcfxl99dY5IgJ9zQ60rtAYbdPdGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758197626; c=relaxed/simple;
	bh=EIwaWaT37xFsFjgkRrWrrtDUx0Pwb/lABPC/ejoZFhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h8sCQ1IhxL4zwYLgLBdge6CFKsENmaMmt2qvKnoZMyQFg6iXdYRVcPBuRkEenqFVSeL4oO7GvknGGEhk0I+lZr40Akaw6HeEkNn50A9zdsCxu9vvEN2cdo6IErS+pEMAVishZ/9hLbWVn8u1qXfZxqLV4Go9WQLsWD+nZhd2DX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPcw21yg; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-78f15d5846dso10041866d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758197623; x=1758802423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KQ73OeZZZwvODsvYl1a5BKB7WUXqf2yiQRx3G0AX38=;
        b=TPcw21ygTs1b0gvuU+pREZTGcgdc4k7VnbvKewjQjGcGhdlNJ/dn7s/jmWfjNf1HIf
         vEVLMj3xAq9x29qf3M1F7lNCiY9QitCqzFJ2IOvjOtooagysw4C7dFZzcdYe2GIp7Kcs
         +7PcmKSWlaBaLpFCPAUhvE5/62QmveU3P6Wl3QRLNoE6zktek3ElZUop7F4XdgJEE6sH
         p3oaSuJxS4wk1GAZEh9BnqvNoie58+Ki2RINgxV4Mn3R6ijxC/RZi/aMedepAI6zLZ3a
         HvjZAzirngAZQTyecEuF18j4ETPecpVCGxV1A9/TRi2ZMVcK74gmYBnt1DnffCAeNkH2
         XXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758197623; x=1758802423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/KQ73OeZZZwvODsvYl1a5BKB7WUXqf2yiQRx3G0AX38=;
        b=V3A5nwe4bpy1p2Uj9ZYX5wxD6NqtmcnCtPxfxZP4C10DTodE4BRDZUHCZQTOWy8HtH
         FegtAyoYzPb4Iy1Px/11LAP7Cy9uimkuoY9Fe3z3ZsfzWTSZdnF2DUZR1cqWXgwRVmiE
         sOWJaHE5W2NtTjWzo7rZY+WH/i6Pn5X+jr1i3kTyr6UpIGYTcJo0GcZDnJYcaN631jQ6
         gvGvEtkvADPPFPv+j3llRQswVxi2i1ewVn5tCliMBteKXkHQuiE73jS96KkeCJh3G3l0
         e59GVGR9fpgIjQ3pZQXAaIL1ceFKDPO4VaIjgmh51OJ8RnkdFJQVyZWsN4kMqXWTNajb
         WFRA==
X-Gm-Message-State: AOJu0Yxe9wQkzVC8Xe0L9ZKPWT09yytuZtqzC9kFFeNd7NV2tGnwEvJl
	SBuHSOdpSCJY2lund8GxiXq21+wGerL1whRnjzJ7oULNILEk+Gx/BFxqPn/uXQ==
X-Gm-Gg: ASbGncuhH534gDS5VVoykyOl2EPL7QGJSQT9JrLe1aRFxXewloFtlID5nq2t4Q2C0V3
	+kqSmslLAbMfJC/6r6sYtQy2JrdUw9Ac3Hb5vW2fL9Z4oX2SjNS5sK9FroSCVP4ihigL608YB8N
	S8gD6ITZhHRDuPuCN5CDDoyvevonZmYL3gVqa4yVhlp+2LvXcnBJ3HZgvdlIilZassSQJ45Vfo/
	G+YsudoJ6gVgvM50HY9acyiaL76Oe69vL7vzOvy6uukUTbESwksrDHYfKrtln9ZH7eWMR+qVAMY
	coEmtphl7KqQKQ3ASLqfa+9SU/tFBvQrL0OXCWvTDuvDql4VlzYFm2sB9XgnzrGgUzqKqomkXDV
	+GJkG5pcbaMSlXmmmKVV2yCeA6R/PbbQOGip5aKPBuQpi53NArDivz6qPgSyHkH4ekWy70677j9
	CXt/W7DCCSbsesYkB41vKSwA==
X-Google-Smtp-Source: AGHT+IGXrefQq4AXLV0RINkfLWhu9HvDI2ERr+UwPOvbB51xD085TTu9xIJkIBf8DW0yvCsgPFrFRA==
X-Received: by 2002:ad4:5cab:0:b0:709:c7de:ce70 with SMTP id 6a1803df08f44-78ecc43a332mr59381426d6.10.1758197623027;
        Thu, 18 Sep 2025 05:13:43 -0700 (PDT)
Received: from localhost (modemcable197.17-162-184.mc.videotron.ca. [184.162.17.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-793472c3946sm12252256d6.28.2025.09.18.05.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 05:13:42 -0700 (PDT)
From: =?UTF-8?q?Jean-Fran=C3=A7ois=20Lessard?= <jefflessard3@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] auxdisplay: linedisp: support attribute attachment to auxdisplay devices
Date: Thu, 18 Sep 2025 08:13:15 -0400
Message-ID: <20250918121321.116248-6-jefflessard3@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918121321.116248-1-jefflessard3@gmail.com>
References: <20250918121321.116248-1-jefflessard3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Enable linedisp library integration into existing kernel devices (like LED
class) to provide a uniform 7-segment userspace API without creating
separate child devices, meeting the consistent interface while maintaining
coherent device hierarchies.

This allows uniform 7-segment API across all drivers while solving device
proliferation and fragmented userspace interfaces.

The sysfs attributes appear in one of the two locations depending on usage:
  1. On linedisp.N child devices (legacy linedisp_register())
  2. On the parent auxdisplay device (new linedisp_attach())
Functionality is identical in both modes.

Existing consumers of linedisp_register() are unaffected. The new API
enables drivers like TM16XX to integrate 7-segment display functionality
seamlessly within their LED class device hierarchy.

Signed-off-by: Jean-François Lessard <jefflessard3@gmail.com>
---

Notes:
    The attachment list operations are extremely lightweight (just
    adding/removing list entries), making spinlock the optimal choice because:
    - Very short critical sections: Only list traversal and pointer
      assignments; avoids context switching overhead for brief operations
    - No sleeping: No memory allocation or I/O within locked sections

 drivers/auxdisplay/line-display.c | 180 +++++++++++++++++++++++++++++-
 drivers/auxdisplay/line-display.h |   4 +
 2 files changed, 178 insertions(+), 6 deletions(-)

diff --git a/drivers/auxdisplay/line-display.c b/drivers/auxdisplay/line-display.c
index 7f3e53e2847b..4e22373fcc1a 100644
--- a/drivers/auxdisplay/line-display.c
+++ b/drivers/auxdisplay/line-display.c
@@ -6,20 +6,23 @@
  * Author: Paul Burton <paul.burton@mips.com>
  *
  * Copyright (C) 2021 Glider bv
+ * Copyright (C) 2025 Jean-François Lessard
  */
 
 #ifndef CONFIG_PANEL_BOOT_MESSAGE
 #include <generated/utsrelease.h>
 #endif
 
-#include <linux/container_of.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/idr.h>
 #include <linux/jiffies.h>
 #include <linux/kstrtox.h>
+#include <linux/list.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/sysfs.h>
 #include <linux/timer.h>
@@ -31,9 +34,80 @@
 
 #define DEFAULT_SCROLL_RATE	(HZ / 2)
 
+/**
+ * struct linedisp_attachment - Holds the device to linedisp mapping
+ * @list: List entry for the linedisp_attachments list
+ * @device: Pointer to the device where linedisp attributes are added
+ * @linedisp: Pointer to the linedisp mapped to the device
+ * @direct: true for directly attached device using linedisp_attach(),
+ *	    false for child registered device using linedisp_register()
+ */
+struct linedisp_attachment {
+	struct list_head list;
+	struct device *device;
+	struct linedisp *linedisp;
+	bool direct;
+};
+
+static LIST_HEAD(linedisp_attachments);
+static DEFINE_SPINLOCK(linedisp_attachments_lock);
+
+static int create_attachment(struct device *dev, struct linedisp *linedisp, bool direct)
+{
+	struct linedisp_attachment *attachment;
+
+	attachment = kzalloc(sizeof(*attachment), GFP_KERNEL);
+	if (!attachment)
+		return -ENOMEM;
+
+	attachment->device = dev;
+	attachment->linedisp = linedisp;
+	attachment->direct = direct;
+
+	guard(spinlock)(&linedisp_attachments_lock);
+	list_add(&attachment->list, &linedisp_attachments);
+
+	return 0;
+}
+
+static struct linedisp *delete_attachment(struct device *dev, bool direct)
+{
+	struct linedisp_attachment *attachment;
+	struct linedisp *linedisp;
+
+	guard(spinlock)(&linedisp_attachments_lock);
+
+	list_for_each_entry(attachment, &linedisp_attachments, list) {
+		if (attachment->device == dev &&
+		    attachment->direct == direct)
+			break;
+	}
+
+	if (list_entry_is_head(attachment, &linedisp_attachments, list))
+		return NULL;
+
+	linedisp = attachment->linedisp;
+	list_del(&attachment->list);
+	kfree(attachment);
+
+	return linedisp;
+}
+
 static struct linedisp *to_linedisp(struct device *dev)
 {
-	return container_of(dev, struct linedisp, dev);
+	struct linedisp_attachment *attachment;
+
+	guard(spinlock)(&linedisp_attachments_lock);
+
+	list_for_each_entry(attachment, &linedisp_attachments, list) {
+		if (attachment->device == dev)
+			break;
+	}
+
+	if (list_entry_is_head(attachment, &linedisp_attachments, list))
+		return NULL;
+
+	return attachment->linedisp;
 }
 
 static inline bool should_scroll(struct linedisp *linedisp)
@@ -348,6 +422,90 @@ static int linedisp_init_map(struct linedisp *linedisp)
 #define LINEDISP_INIT_TEXT "Linux " UTS_RELEASE "       "
 #endif
 
+/**
+ * linedisp_attach - attach a character line display
+ * @linedisp: pointer to character line display structure
+ * @dev: pointer of the device to attach to
+ * @num_chars: the number of characters that can be displayed
+ * @ops: character line display operations
+ *
+ * Directly attach the line-display sysfs attributes to the passed device.
+ * The caller is responsible for calling linedisp_detach() to release resources
+ * after use.
+ *
+ * Return: zero on success, else a negative error code.
+ */
+int linedisp_attach(struct linedisp *linedisp, struct device *dev,
+		    unsigned int num_chars, const struct linedisp_ops *ops)
+{
+	int err;
+
+	memset(linedisp, 0, sizeof(*linedisp));
+	linedisp->ops = ops;
+	linedisp->num_chars = num_chars;
+	linedisp->scroll_rate = DEFAULT_SCROLL_RATE;
+
+	linedisp->buf = kzalloc(linedisp->num_chars, GFP_KERNEL);
+	if (!linedisp->buf)
+		return -ENOMEM;
+
+	/* initialise a character mapping, if required */
+	err = linedisp_init_map(linedisp);
+	if (err)
+		goto out_free_buf;
+
+	/* initialise a timer for scrolling the message */
+	timer_setup(&linedisp->timer, linedisp_scroll, 0);
+
+	err = create_attachment(dev, linedisp, true);
+	if (err)
+		goto out_del_timer;
+
+	/* display a default message */
+	err = linedisp_display(linedisp, LINEDISP_INIT_TEXT, -1);
+	if (err)
+		goto out_del_attach;
+
+	/* add attribute groups to target device */
+	err = device_add_groups(dev, linedisp_groups);
+	if (err)
+		goto out_del_attach;
+
+	return 0;
+
+out_del_attach:
+	delete_attachment(dev, true);
+out_del_timer:
+	timer_delete_sync(&linedisp->timer);
+out_free_buf:
+	kfree(linedisp->buf);
+	return err;
+}
+EXPORT_SYMBOL_NS_GPL(linedisp_attach, "LINEDISP");
+
+/**
+ * linedisp_detach - detach a character line display
+ * @dev: pointer of the device to detach from, that was previously
+ *	 attached with linedisp_attach()
+ */
+void linedisp_detach(struct device *dev)
+{
+	struct linedisp *linedisp;
+
+	linedisp = delete_attachment(dev, true);
+	if (!linedisp)
+		return;
+
+	timer_delete_sync(&linedisp->timer);
+
+	device_remove_groups(dev, linedisp_groups);
+
+	kfree(linedisp->map);
+	kfree(linedisp->message);
+	kfree(linedisp->buf);
+}
+EXPORT_SYMBOL_NS_GPL(linedisp_detach, "LINEDISP");
+
 /**
  * linedisp_register - register a character line display
  * @linedisp: pointer to character line display structure
@@ -355,6 +513,11 @@ static int linedisp_init_map(struct linedisp *linedisp)
  * @num_chars: the number of characters that can be displayed
  * @ops: character line display operations
  *
+ * Register the line-display sysfs attributes to a new device named
+ * "linedisp.N" added to the passed parent device.
+ * The caller is responsible for calling linedisp_unregister() to release
+ * resources after use.
+ *
  * Return: zero on success, else a negative error code.
  */
 int linedisp_register(struct linedisp *linedisp, struct device *parent,
@@ -390,19 +553,23 @@ int linedisp_register(struct linedisp *linedisp, struct device *parent,
 	/* initialise a timer for scrolling the message */
 	timer_setup(&linedisp->timer, linedisp_scroll, 0);
 
-	err = device_add(&linedisp->dev);
+	err = create_attachment(&linedisp->dev, linedisp, false);
 	if (err)
 		goto out_del_timer;
 
 	/* display a default message */
 	err = linedisp_display(linedisp, LINEDISP_INIT_TEXT, -1);
 	if (err)
-		goto out_del_dev;
+		goto out_del_attach;
+
+	err = device_add(&linedisp->dev);
+	if (err)
+		goto out_del_attach;
 
 	return 0;
 
-out_del_dev:
-	device_del(&linedisp->dev);
+out_del_attach:
+	delete_attachment(&linedisp->dev, false);
 out_del_timer:
 	timer_delete_sync(&linedisp->timer);
 out_put_device:
@@ -419,6 +586,7 @@ EXPORT_SYMBOL_NS_GPL(linedisp_register, "LINEDISP");
 void linedisp_unregister(struct linedisp *linedisp)
 {
 	device_del(&linedisp->dev);
+	delete_attachment(&linedisp->dev, false);
 	timer_delete_sync(&linedisp->timer);
 	put_device(&linedisp->dev);
 }
diff --git a/drivers/auxdisplay/line-display.h b/drivers/auxdisplay/line-display.h
index 4348d7a2f69a..36853b639711 100644
--- a/drivers/auxdisplay/line-display.h
+++ b/drivers/auxdisplay/line-display.h
@@ -6,6 +6,7 @@
  * Author: Paul Burton <paul.burton@mips.com>
  *
  * Copyright (C) 2021 Glider bv
+ * Copyright (C) 2025 Jean-François Lessard
  */
 
 #ifndef _LINEDISP_H
@@ -81,6 +82,9 @@ struct linedisp {
 	unsigned int id;
 };
 
+int linedisp_attach(struct linedisp *linedisp, struct device *dev,
+		    unsigned int num_chars, const struct linedisp_ops *ops);
+void linedisp_detach(struct device *dev);
 int linedisp_register(struct linedisp *linedisp, struct device *parent,
 		      unsigned int num_chars, const struct linedisp_ops *ops);
 void linedisp_unregister(struct linedisp *linedisp);
-- 
2.43.0



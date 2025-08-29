Return-Path: <linux-kernel+bounces-790950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CACB3B02C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E79E21C24679
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 01:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C6D19E992;
	Fri, 29 Aug 2025 01:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goYGPAoq"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0133FE7
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 01:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756429409; cv=none; b=GhJ0eDy0TV7AoADXO6ravJZwnNCeOETlT+BM0c4LI5gKrNkM+BC2paB08qFLlPkYmaONodoYqRYIjWJW2KpEiwKJ5F1RMZo/d9Dp3+H9o0pcOEzHumWvj5dVV+xJo6Vl26LMS9CEU522zeW1MdtK5gOtb9Oa2XH5zzlwrEJnib4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756429409; c=relaxed/simple;
	bh=PZv0ZrDs5rGUOj3rwSD2pBvVI7hhBO2a64qgtuigr7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r4hlO8C1jFZjz0tQMVtM1h/CiGgU03ZiUC5WWGqVCJanfNZtfrzDw+sFGRkzvveqPpGhpjgXSYJc8SeXp5kKHx/XA/khyxDpERTN+/uCItXIchBeR3wm/8kEMMq1rtYAwwgujGzVEE3otTPJgpajYeA9UwArxF2uPlt22iJfWLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goYGPAoq; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7fac0a7d2b1so119821085a.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 18:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756429407; x=1757034207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TUTsL0aTtRK2Wq+RLtlWb4+ITACjnGfqLuoakzodSTk=;
        b=goYGPAoqQCG4itjOmccNF4+0/UVGvsz/g+p1HH2/daIylCb5Lr16cT4TrjhmtXkX8x
         tgrAa12GUQayCpoqv/HIrdCo/s0iQ4JS5rLS6VeAkTBHg8FwCHFjDP2R4ijsI+BPAdn4
         lLQtLeVL7mveDZ061IQfySuBCw5NlPrx4TdUQaev25WzRFOvC3QUP6z9yYUeLv+PILSZ
         hRzt4NUuE8MYCMtXM0xmxoGiGRgO5dlf6OablWteuHhgW0tGX1CmCHMeYURCiLxSeX8B
         J1QMq99V0bmLA4D1ENJrdXGMMTQPogA+QVockyFKkJb/AVIQlfF22uLQGBdFOxagqwNK
         x4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756429407; x=1757034207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUTsL0aTtRK2Wq+RLtlWb4+ITACjnGfqLuoakzodSTk=;
        b=eesD+HM1VTLeCl8yhmXDDMymwtTFh9xi3P5CTfPZ9R5kNpPyFVlYIecDJCunOV2pnl
         0eyHrwvFGXS95slEHpvTXw0QxsNuYskYismoqnzhuzRsg/7owExRmnM3hocnVnmeOL/g
         nwQz42jq9WipYWvzSyTiT41d49ln64497ve7KJjFPoN8vbhFRNf51haR9+2m+s6xfi6y
         IiJoF/1pUiiHYGqH7SK217xf31DbD6nvA/22emjHMcZma3exZ85F5ccOIOMd5ZgBJ8lx
         oKV+HbeP4Rt3egGRppM/h8oFbdrEyjh/jncFSMW8kPhXKCVEO3MbGOXqA0GA0pMDSqCd
         IdZw==
X-Gm-Message-State: AOJu0YzaJNOsjV3iqg95x2vHnSK9Gq8I2+HdOH0dSuri2yBPRJqmMzmD
	1DYOky0Q+ZE4zbUE47EKz2TMYe42QB1lEdwPNvAmSPpMPpmmL0y/jJMIFgRvgg==
X-Gm-Gg: ASbGncteUdoADdq9V89SLqf5d6QrAHDYqsGtKP71o/cKzRBIWNMcpspEkQ3qip04tRx
	HjOUda181Im/M+Twu1eA5PJs1rr9wCbvqBwl0X7EgD1bjeNJWwpuO0z+Nl89mxPv03p96nZ8WoQ
	sS31DQ7AnkvwIhiSw1y42XqscFIxv1IC3jJ/kojC9cPvirjJq264mTifcruqXAY357Sp8CoAAWc
	nL0CuhbmfhlA3pUVfcSrB8Rvs7VikfP7d5xkrHy33bukT21Zjfx4K1/ZYitNcuOC3xacM1XpJIU
	RJJte5F8xk+Aqb+arp2OK95ea1P5rbZwcNbImINgvLxC5WRjTzlCtBWDBlKGGtJMe34ZA1vIqsW
	r/sdwPMyMnJPbNyTJ63pV42jvWLywZn/rfMha03fAN1+F49EWnOwUO3r+ulm+s5nMnnBpo+t7aV
	G35Zk=
X-Google-Smtp-Source: AGHT+IEu8ezriZIvQkc/t2a8GDm3bOLfUGOhpyhWVYPAE0+nnfW72yKJF/LD3mSTlLvY9+ovxund2g==
X-Received: by 2002:a05:620a:d96:b0:7e6:9644:c977 with SMTP id af79cd13be357-7ea10f94cc4mr3243593485a.27.1756429406624;
        Thu, 28 Aug 2025 18:03:26 -0700 (PDT)
Received: from localhost (modemcable197.17-162-184.mc.videotron.ca. [184.162.17.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc0d869e5csm90219485a.7.2025.08.28.18.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 18:03:25 -0700 (PDT)
From: =?UTF-8?q?Jean-Fran=C3=A7ois=20Lessard?= <jefflessard3@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH] auxdisplay: line-display: support attribute attachment to existing device
Date: Thu, 28 Aug 2025 21:03:19 -0400
Message-ID: <20250829010324.15595-1-jefflessard3@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Modernize the line-display core library:
- Add the ability to attach line-display's sysfs attribute group directly
  to an existing parent device (not only via a child device) using
  device_add_groups(), allowing coherent integration with subsystems like
  the LED class.
- Implement a global linedisp_attachment mapping for unified and race-free
  attribute access, context lookup, and cleanup, shared between
  traditional register/unregister and new attach/detach paths.
- Modify sysfs attribute accessors to retrieve context using a consistent
  to_linedisp() mechanism.
- Add a new num_chars read-only attribute reporting the number of display
  digits to allow static non-scrolling message from userspace.
- Ensures thread safety and proper list removal for all attachments
  operations.

Backwards compatibility with existing users is maintained, while enabling
uniform n-segment sysfs API and richer information for integrated drivers.

Signed-off-by: Jean-François Lessard <jefflessard3@gmail.com>
---
 drivers/auxdisplay/line-display.c | 178 ++++++++++++++++++++++++++++--
 drivers/auxdisplay/line-display.h |   4 +
 2 files changed, 172 insertions(+), 10 deletions(-)

diff --git a/drivers/auxdisplay/line-display.c b/drivers/auxdisplay/line-display.c
index 8590a4cd2..64ab1d835 100644
--- a/drivers/auxdisplay/line-display.c
+++ b/drivers/auxdisplay/line-display.c
@@ -6,13 +6,15 @@
  * Author: Paul Burton <paul.burton@mips.com>
  *
  * Copyright (C) 2021 Glider bv
+ * Copyright (C) 2025 Jean-François Lessard
  */
 
 #ifndef CONFIG_PANEL_BOOT_MESSAGE
 #include <generated/utsrelease.h>
 #endif
 
-#include <linux/container_of.h>
+#include <linux/list.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/idr.h>
@@ -20,6 +22,7 @@
 #include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/sysfs.h>
 #include <linux/timer.h>
@@ -31,6 +34,75 @@
 
 #define DEFAULT_SCROLL_RATE	(HZ / 2)
 
+/* forward declarations */
+static const struct device_type linedisp_type;
+
+struct linedisp_attachment {
+	struct list_head list;
+	struct device *device;
+	struct linedisp *linedisp;
+	bool owns_device;  /* true for child device mode, false for attached mode */
+};
+
+static LIST_HEAD(linedisp_attachments);
+static DEFINE_SPINLOCK(linedisp_attachments_lock);
+
+static int create_attachment(struct device *dev, struct linedisp *linedisp, bool owns_device)
+{
+	struct linedisp_attachment *attachment;
+
+	attachment = kzalloc(sizeof(*attachment), GFP_KERNEL);
+	if (!attachment)
+		return -ENOMEM;
+
+	attachment->device = dev;
+	attachment->linedisp = linedisp;
+	attachment->owns_device = owns_device;
+
+	scoped_guard(spinlock, &linedisp_attachments_lock) {
+		list_add(&attachment->list, &linedisp_attachments);
+	}
+
+	return 0;
+}
+
+static struct linedisp *delete_attachment(struct device *dev, bool owns_device)
+{
+	struct linedisp_attachment *attachment, *tmp;
+	struct linedisp *linedisp = NULL;
+
+	scoped_guard(spinlock, &linedisp_attachments_lock) {
+		list_for_each_entry_safe(attachment, tmp, &linedisp_attachments, list) {
+			if (attachment->device == dev &&
+			    attachment->owns_device == owns_device) {
+				linedisp = attachment->linedisp;
+				list_del(&attachment->list);
+				kfree(attachment);
+				break;
+			}
+		}
+	}
+
+	return linedisp;
+}
+
+static struct linedisp *to_linedisp(struct device *dev)
+{
+	struct linedisp_attachment *attachment;
+	struct linedisp *linedisp = NULL;
+
+	scoped_guard(spinlock, &linedisp_attachments_lock) {
+		list_for_each_entry(attachment, &linedisp_attachments, list) {
+			if (attachment->device == dev) {
+				linedisp = attachment->linedisp;
+				break;
+			}
+		}
+	}
+
+	return linedisp;
+}
+
 /**
  * linedisp_scroll() - scroll the display by a character
  * @t: really a pointer to the private data structure
@@ -133,7 +205,7 @@ static int linedisp_display(struct linedisp *linedisp, const char *msg,
 static ssize_t message_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
-	struct linedisp *linedisp = container_of(dev, struct linedisp, dev);
+	struct linedisp *linedisp = to_linedisp(dev);
 
 	return sysfs_emit(buf, "%s\n", linedisp->message);
 }
@@ -152,7 +224,7 @@ static ssize_t message_show(struct device *dev, struct device_attribute *attr,
 static ssize_t message_store(struct device *dev, struct device_attribute *attr,
 			     const char *buf, size_t count)
 {
-	struct linedisp *linedisp = container_of(dev, struct linedisp, dev);
+	struct linedisp *linedisp = to_linedisp(dev);
 	int err;
 
 	err = linedisp_display(linedisp, buf, count);
@@ -164,7 +236,7 @@ static DEVICE_ATTR_RW(message);
 static ssize_t scroll_step_ms_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	struct linedisp *linedisp = container_of(dev, struct linedisp, dev);
+	struct linedisp *linedisp = to_linedisp(dev);
 
 	return sysfs_emit(buf, "%u\n", jiffies_to_msecs(linedisp->scroll_rate));
 }
@@ -173,7 +245,7 @@ static ssize_t scroll_step_ms_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
-	struct linedisp *linedisp = container_of(dev, struct linedisp, dev);
+	struct linedisp *linedisp = to_linedisp(dev);
 	unsigned int ms;
 	int err;
 
@@ -193,9 +265,19 @@ static ssize_t scroll_step_ms_store(struct device *dev,
 
 static DEVICE_ATTR_RW(scroll_step_ms);
 
+static ssize_t num_chars_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct linedisp *linedisp = to_linedisp(dev);
+
+	return sysfs_emit(buf, "%u\n", linedisp->num_chars);
+}
+
+static DEVICE_ATTR_RO(num_chars);
+
 static ssize_t map_seg_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct linedisp *linedisp = container_of(dev, struct linedisp, dev);
+	struct linedisp *linedisp = to_linedisp(dev);
 	struct linedisp_map *map = linedisp->map;
 
 	memcpy(buf, &map->map, map->size);
@@ -205,7 +287,7 @@ static ssize_t map_seg_show(struct device *dev, struct device_attribute *attr, c
 static ssize_t map_seg_store(struct device *dev, struct device_attribute *attr,
 			     const char *buf, size_t count)
 {
-	struct linedisp *linedisp = container_of(dev, struct linedisp, dev);
+	struct linedisp *linedisp = to_linedisp(dev);
 	struct linedisp_map *map = linedisp->map;
 
 	if (count != map->size)
@@ -224,6 +306,7 @@ static DEVICE_ATTR(map_seg14, 0644, map_seg_show, map_seg_store);
 static struct attribute *linedisp_attrs[] = {
 	&dev_attr_message.attr,
 	&dev_attr_scroll_step_ms.attr,
+	&dev_attr_num_chars.attr,
 	&dev_attr_map_seg7.attr,
 	&dev_attr_map_seg14.attr,
 	NULL
@@ -232,7 +315,7 @@ static struct attribute *linedisp_attrs[] = {
 static umode_t linedisp_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n)
 {
 	struct device *dev = kobj_to_dev(kobj);
-	struct linedisp *linedisp = container_of(dev, struct linedisp, dev);
+	struct linedisp *linedisp = to_linedisp(dev);
 	struct linedisp_map *map = linedisp->map;
 	umode_t mode = attr->mode;
 
@@ -263,7 +346,7 @@ static DEFINE_IDA(linedisp_id);
 
 static void linedisp_release(struct device *dev)
 {
-	struct linedisp *linedisp = container_of(dev, struct linedisp, dev);
+	struct linedisp *linedisp = to_linedisp(dev);
 
 	kfree(linedisp->map);
 	kfree(linedisp->message);
@@ -320,6 +403,74 @@ static int linedisp_init_map(struct linedisp *linedisp)
 #define LINEDISP_INIT_TEXT "Linux " UTS_RELEASE "       "
 #endif
 
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
+	err = -ENOMEM;
+	linedisp->buf = kzalloc(linedisp->num_chars, GFP_KERNEL);
+	if (!linedisp->buf)
+		return err;
+
+	/* initialise a character mapping, if required */
+	err = linedisp_init_map(linedisp);
+	if (err)
+		goto out_free_buf;
+
+	/* initialise a timer for scrolling the message */
+	timer_setup(&linedisp->timer, linedisp_scroll, 0);
+
+	err = create_attachment(dev, linedisp, false);
+	if (err)
+		goto out_del_timer;
+
+	/* add attribute groups to target device */
+	err = device_add_groups(dev, linedisp_groups);
+	if (err)
+		goto out_del_attach;
+
+	/* display a default message */
+	err = linedisp_display(linedisp, LINEDISP_INIT_TEXT, -1);
+	if (err)
+		goto out_rem_groups;
+
+	return 0;
+
+out_rem_groups:
+	device_remove_groups(dev, linedisp_groups);
+out_del_attach:
+	delete_attachment(dev, false);
+out_del_timer:
+	timer_delete_sync(&linedisp->timer);
+out_free_buf:
+	kfree(linedisp->buf);
+	return err;
+}
+EXPORT_SYMBOL_NS_GPL(linedisp_attach, "LINEDISP");
+
+void linedisp_detach(struct device *dev)
+{
+	struct linedisp *linedisp = delete_attachment(dev, false);
+
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
@@ -362,10 +513,14 @@ int linedisp_register(struct linedisp *linedisp, struct device *parent,
 	/* initialise a timer for scrolling the message */
 	timer_setup(&linedisp->timer, linedisp_scroll, 0);
 
-	err = device_add(&linedisp->dev);
+	err = create_attachment(&linedisp->dev, linedisp, true);
 	if (err)
 		goto out_del_timer;
 
+	err = device_add(&linedisp->dev);
+	if (err)
+		goto out_del_attach;
+
 	/* display a default message */
 	err = linedisp_display(linedisp, LINEDISP_INIT_TEXT, -1);
 	if (err)
@@ -375,6 +530,8 @@ int linedisp_register(struct linedisp *linedisp, struct device *parent,
 
 out_del_dev:
 	device_del(&linedisp->dev);
+out_del_attach:
+	delete_attachment(&linedisp->dev, true);
 out_del_timer:
 	timer_delete_sync(&linedisp->timer);
 out_put_device:
@@ -391,6 +548,7 @@ EXPORT_SYMBOL_NS_GPL(linedisp_register, "LINEDISP");
 void linedisp_unregister(struct linedisp *linedisp)
 {
 	device_del(&linedisp->dev);
+	delete_attachment(&linedisp->dev, true);
 	timer_delete_sync(&linedisp->timer);
 	put_device(&linedisp->dev);
 }
diff --git a/drivers/auxdisplay/line-display.h b/drivers/auxdisplay/line-display.h
index 4348d7a2f..36853b639 100644
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



Return-Path: <linux-kernel+bounces-793652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AC9B3D674
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 04:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C96163B9256
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 02:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C595228CBC;
	Mon,  1 Sep 2025 02:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPM0LN/f"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405F921B1AA
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 02:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756692043; cv=none; b=kRm7crvaeQujaQMXrt5lg/xz9iJrynfGydeNkHYVTrrEhsT3eUShhGZ8pYVii9710sagQCjbgCQq+0hOnbWjpWbulfOB/LsKal40iuvU5uBZ3ns8aJdHRO+JCYwJv2Zz4O4r/BWU3W/vuQhIt8tS/y0UKqRe4X/O2y3lNKOdhhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756692043; c=relaxed/simple;
	bh=uCrvTMbf7NF0MNMD7g0oXt0igXQlfP+RbJ5iFk5FAwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eS4y+9hynqaYY4XXzyEHGvS1Jps6Nh56RpbILL8nRrGBECCgiTT7jPV9bqux2upKirV9eNYVRMdDqtuBFbEg+jf5JywYwRHE3fj+Rp39EuyLRVbK3XDTKDcrlivYAlsHfjwB5I3RjZSWXqVpVwgrTvAaQ1iuBYAmMvisX0qhGkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPM0LN/f; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-70df92872ceso31591616d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 19:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756692040; x=1757296840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btv2+zrNnBuWpIYtzQbHrU0RH1HbmWmw6AIer95J2Vk=;
        b=lPM0LN/fDjToCk6umNxMUaLxf/eKuHEIy/wo1B16hsw1j2Jul6E9n6dbhhmCJUxRsb
         JUB+xrtsBqFOcWVG963psLFazb4b1FnRGIV1X0dr8XfpMpLbos4VGJoPR0k/MSiprx/y
         hsRNA2rJZZu+R257sdoUN3VrkojXpXMn/J1iqF3sguYcjwe/sBNrB+ybMsu9HVkAqO69
         BUIkMnfpz/6DSTUdnAeH04W33/0oEOAU52pFB72fiEb5zABVKatJuefg3XvzoSSgxgVw
         m7PBxt3bT5lp6q+k7qCzY19KNA82BflfbDdKP3zHP0sr7Ot1MJ1Mpc2w+ZNji0PBJ4u5
         z4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756692040; x=1757296840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btv2+zrNnBuWpIYtzQbHrU0RH1HbmWmw6AIer95J2Vk=;
        b=Zzm9E1THcu2rYDhqUscwYDwGkHToQR8hFHm3D4I6/3zMZxXh81R0X5TToQnMX1DBws
         5sJY9cNad4Ii0vzSlJKsb5y3kh8JRYvJK65mAAlrvxqyKEl/WoQ2yzhfJFedop3So/0I
         tqrIsGRirlWt5Ao8WupTOQVfCDF/4csUf+5QES0/hcsJnpeKNa4bVvKrQcRPoL87Q/PN
         Mog9DwsS0k/DxJPrl7HtJZqJ9N/OhUPHBkStjcsLP/lfqtBEjrotHu/7kzW8o7u6aprH
         DeI0NrNSGfg4St9JZ/kHKs9q3SH2EKw5UEtCP/uqavXT/qUZDvq3LDYc9uPw8M25HV8m
         I07w==
X-Gm-Message-State: AOJu0YydInbbf/BH0s66VDY0cMAT1MY6FBfGGDvss96Ok50vBN+SoV7+
	djzF0fVXTC7E6jlSbVkrw1FdSNy0xeyYMnX0nxoCBGmo6eq4AEsRvMUd
X-Gm-Gg: ASbGncvxBFPt2kWT5cJ/ouSnbPzc4wAE0HzeEvj9b1Yp5WvfxmFKisCioeyKOXUfpLf
	FD/1kE8mDgbNpLQCWPfOwXJVgPkOC3YG8RTvlFnYesmuQ44fRkopHz9eQFoKaPTB5+AMgDCSKlY
	umGPHLb1y1OWF7x4bl5sbaCpto3IcVagHqErVYJk/tl83oqsT+ojLbchkeDJ2rYFDrSzzO7GFOg
	ZKhbUsBAOXx6+gDQPRY1q97i7Dl+Ydxxy4SlZPmX5EAQO4Dmv7qOHoM9lZMbE92e9fPH/wD7R8p
	NQF67ALVtMiCaG9lC5jCJEvZH/+exJGvArtNmwvv4GkJonw4VlHXCGl/dLj8XM5SW/R2nJzwnRE
	2E3gTmuPMm8pQQos2CbeUfz3OqHleR/2CrBG5o2gSo4/IDCLh6n+zOUo/dqaJaacBoYqQSZXzp2
	KTw2I=
X-Google-Smtp-Source: AGHT+IHZTBNgW56teLD3sHSLrvkv0m337tB6iNKQKpqlBsfGGabYGgvI0lsbSLvoRIAMxLpvom0IdQ==
X-Received: by 2002:a05:6214:aca:b0:718:787b:fece with SMTP id 6a1803df08f44-718787c00a2mr23553336d6.16.1756692039841;
        Sun, 31 Aug 2025 19:00:39 -0700 (PDT)
Received: from localhost (modemcable197.17-162-184.mc.videotron.ca. [184.162.17.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70fb28983fasm31908136d6.54.2025.08.31.19.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 19:00:39 -0700 (PDT)
From: =?UTF-8?q?Jean-Fran=C3=A7ois=20Lessard?= <jefflessard3@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] auxdisplay: linedisp: support attribute attachment to auxdisplay devices
Date: Sun, 31 Aug 2025 22:00:28 -0400
Message-ID: <20250901020033.60196-5-jefflessard3@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250901020033.60196-1-jefflessard3@gmail.com>
References: <20250901020033.60196-1-jefflessard3@gmail.com>
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

The provided attributes appear in two locations depending on usage:
  1. On linedisp.N child devices (legacy linedisp_register())
  2. On the parent auxdisplay device (new linedisp_attach())
Functionality is identical in both modes.

Existing consumers of linedisp_register() are unaffected. The new API
enables drivers like TM16XX to integrate 7-segment display functionality
seamlessly within their LED class device hierarchy.

Signed-off-by: Jean-François Lessard <jefflessard3@gmail.com>
---
 drivers/auxdisplay/line-display.c | 160 +++++++++++++++++++++++++++++-
 drivers/auxdisplay/line-display.h |   4 +
 2 files changed, 161 insertions(+), 3 deletions(-)

diff --git a/drivers/auxdisplay/line-display.c b/drivers/auxdisplay/line-display.c
index abeed8812..1176d46f0 100644
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
@@ -31,9 +34,72 @@
 
 #define DEFAULT_SCROLL_RATE	(HZ / 2)
 
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
+	guard(spinlock)(&linedisp_attachments_lock);
+	list_add(&attachment->list, &linedisp_attachments);
+
+	return 0;
+}
+
+static struct linedisp *delete_attachment(struct device *dev, bool owns_device)
+{
+	struct linedisp_attachment *attachment;
+	struct linedisp *linedisp;
+
+	guard(spinlock)(&linedisp_attachments_lock);
+
+	list_for_each_entry(attachment, &linedisp_attachments, list) {
+		if (attachment->device == dev &&
+		    attachment->owns_device == owns_device)
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
@@ -349,6 +415,87 @@ static int linedisp_init_map(struct linedisp *linedisp)
 #define LINEDISP_INIT_TEXT "Linux " UTS_RELEASE "       "
 #endif
 
+/**
+ * linedisp_attach - attach a character line display
+ * @linedisp: pointer to character line display structure
+ * @dev: pointer of the device to attach to
+ * @num_chars: the number of characters that can be displayed
+ * @ops: character line display operations
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
+/**
+ * linedisp_detach - detach a character line display
+ * @dev: pointer of the device to detach from, that was previously
+ *	 attached with linedisp_attach()
+ */
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
@@ -391,10 +538,14 @@ int linedisp_register(struct linedisp *linedisp, struct device *parent,
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
@@ -404,6 +555,8 @@ int linedisp_register(struct linedisp *linedisp, struct device *parent,
 
 out_del_dev:
 	device_del(&linedisp->dev);
+out_del_attach:
+	delete_attachment(&linedisp->dev, true);
 out_del_timer:
 	timer_delete_sync(&linedisp->timer);
 out_put_device:
@@ -420,6 +573,7 @@ EXPORT_SYMBOL_NS_GPL(linedisp_register, "LINEDISP");
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



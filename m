Return-Path: <linux-kernel+bounces-730996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF81B04D52
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 03:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07CE41A66CED
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 01:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E331DF98D;
	Tue, 15 Jul 2025 01:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u29Fk8aJ"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860EC1D63DF
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 01:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752542441; cv=none; b=P0SjVIvpcbMhyatWB6ESo3mTfrs1Ge0ggMsiyf/A5uWpphOF9V34/n5x6K2bUa7wGdKyvYefBzRo2v9X9iJbsiYUst3caAZXNIfUWhPB3OlxPsWy6SOWveWZLgfQCpbIR1hJFjMYVjfIh/jEbef62U2b429NgQ3lfI+Tn6oI3ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752542441; c=relaxed/simple;
	bh=Sz4HNtOnMBo7mSId/KsVj73EzUCaVXfOGbO+6v60Gio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tU826cjjuHF2eDY7wT9OsPpqqYU4nHZauWqQVvp2b05gmzkWFHkNUOgiihjVlIvxhV/Qmws6Wk50hczADcugHT9ZxbqNGeR6XCeyyoYTuD/BbXszrZA/9esQbhsw5nHFm4awsIX9UQy5ExYmzNWFgVeZaDfqiQcQWrjx+3U8PwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u29Fk8aJ; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752542437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=34r1lxdH/9Y6yYE41yHEODqOfw+CqLwlQ46xG1M+uC0=;
	b=u29Fk8aJdKRXsivfYW+aBJBDEvVMPypfhz7JuJIjeVFr5ffwgmpRblfpK4Xkrm3WX3ynTV
	Kj/C85OOpx3DZI2qeW+CGXvr9uBXASYlkl4roqdlWcp6K9EnIEyNewR6LfmlJ+QU0pVNy9
	EkzY4EiRUuFDJUfEzCI8Drs38myKD7w=
From: Sean Anderson <sean.anderson@linux.dev>
To: Jonathan Cameron <jic23@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 3/7] iio: Add in-kernel API for events
Date: Mon, 14 Jul 2025 21:20:19 -0400
Message-Id: <20250715012023.2050178-4-sean.anderson@linux.dev>
In-Reply-To: <20250715012023.2050178-1-sean.anderson@linux.dev>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add an API to notify consumers about events. Events still need to be
enabled using the iio_read_event/iio_write_event functions. Of course,
userspace can also manipulate the enabled events. I don't think this is
too much of an issue, since userspace can also manipulate the event
thresholds. But enabling events may cause existing programs to be
surprised when they get something unexpected. Maybe we should set the
interface as busy when there are any in-kernel listeners?

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/iio/industrialio-event.c | 34 +++++++++++++++++++++++++++-----
 include/linux/iio/consumer.h     | 30 ++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index 06295cfc2da8..b9e3ff1cd5c9 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -12,11 +12,13 @@
 #include <linux/kernel.h>
 #include <linux/kfifo.h>
 #include <linux/module.h>
+#include <linux/notifier.h>
 #include <linux/poll.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/wait.h>
+#include <linux/iio/consumer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/iio-opaque.h>
 #include "iio_core.h"
@@ -26,6 +28,7 @@
 /**
  * struct iio_event_interface - chrdev interface for an event line
  * @wait:		wait queue to allow blocking reads of events
+ * @notifier:		notifier head for in-kernel event listeners
  * @det_events:		list of detected events
  * @dev_attr_list:	list of event interface sysfs attribute
  * @flags:		file operations related flags including busy flag.
@@ -35,6 +38,7 @@
  */
 struct iio_event_interface {
 	wait_queue_head_t	wait;
+	struct atomic_notifier_head notifier;
 	DECLARE_KFIFO(det_events, struct iio_event_data, 16);
 
 	struct list_head	dev_attr_list;
@@ -67,18 +71,19 @@ int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	struct iio_event_interface *ev_int = iio_dev_opaque->event_interface;
-	struct iio_event_data ev;
+	struct iio_event_data ev = {
+		.id = ev_code,
+		.timestamp = timestamp,
+	};
 	int copied;
 
 	if (!ev_int)
 		return 0;
 
+	atomic_notifier_call_chain(&ev_int->notifier, IIO_NOTIFY_EVENT, &ev);
+
 	/* Does anyone care? */
 	if (iio_event_enabled(ev_int)) {
-
-		ev.id = ev_code;
-		ev.timestamp = timestamp;
-
 		copied = kfifo_put(&ev_int->det_events, ev);
 		if (copied != 0)
 			wake_up_poll(&ev_int->wait, EPOLLIN);
@@ -223,6 +228,25 @@ static int iio_event_getfd(struct iio_dev *indio_dev)
 	return fd;
 }
 
+int iio_event_register(struct iio_dev *indio_dev, struct notifier_block *block)
+{
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+	struct iio_event_interface *ev_int = iio_dev_opaque->event_interface;
+
+	return atomic_notifier_chain_register(&ev_int->notifier, block);
+}
+EXPORT_SYMBOL_GPL(iio_event_register);
+
+void iio_event_unregister(struct iio_dev *indio_dev,
+			  struct notifier_block *block)
+{
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+	struct iio_event_interface *ev_int = iio_dev_opaque->event_interface;
+
+	WARN_ON(atomic_notifier_chain_unregister(&ev_int->notifier, block));
+}
+EXPORT_SYMBOL_GPL(iio_event_unregister);
+
 static const char * const iio_ev_type_text[] = {
 	[IIO_EV_TYPE_THRESH] = "thresh",
 	[IIO_EV_TYPE_MAG] = "mag",
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 16e7682474f3..9918e3f7af3d 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -507,4 +507,34 @@ int iio_write_event_processed_scale(struct iio_channel *chan,
 				    enum iio_event_info info, int processed,
 				    unsigned int scale);
 
+struct notifier_block;
+enum iio_notifier_val {
+	/** IIO_NOTIFY_EVENT: v is a pointer to &struct iio_event_data */
+	IIO_NOTIFY_EVENT,
+};
+
+/**
+ * iio_event_register() - Register a notifier for events
+ * @indio_dev: Device to be notified of events on
+ * @block: Notifier block to register
+ *
+ * Register a notifier for events on @indio_dev. @v will be a member of &enum
+ * iio_notifier_val. Notifiers will be called in atomic context. @indio_dev
+ * must stay valid until you call iio_event_unregister().
+ *
+ * Return: 0 on success, or -EEXIST if @block has already been registered
+ */
+int iio_event_register(struct iio_dev *indio_dev,
+		       struct notifier_block *block);
+
+/**
+ * iio_event_unregister() - Remove a previously-added notifier
+ * @indio_dev: Device to be notified of events on
+ * @block: Notifier previously-registered with iio_event_register()
+ *
+ * Remove a previously-added notifier.
+ */
+void iio_event_unregister(struct iio_dev *indio_dev,
+			  struct notifier_block *block);
+
 #endif
-- 
2.35.1.1320.gc452695387.dirty



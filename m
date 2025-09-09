Return-Path: <linux-kernel+bounces-808153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD5AB4FADE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6C95E1D9A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5893D1494CC;
	Tue,  9 Sep 2025 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yweizecu"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EA5334704
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421045; cv=none; b=fQ66ze1tB9Oao45Gql6HESu6baYxVj9nLK8FbGRG2DUeZKV2JOsxSoWcmR0TH+R3FMsJMezU9xR6RB/TZapoMwmeqhnHnuxiyHqTPyRp+VopGDzCFMFQQ4hkgDOu0GXqnEUZEnnUayU8Ez/ObmioKfCbI2hvnthSZ3HVwdp92g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421045; c=relaxed/simple;
	bh=dY2lLF3NAF75RLJg43VoI8WFxYQjrRkpfq0cWUdKBC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rI9tyreoDtK5DJoRR5q/2A70BsZVa76wPt0ogxohxCHc+khBEm9FRQdLGOOCaMnxOJWnE1xEIpQ/d85UDBWP22njjxpo4VfqlrD8Wx24fLi/ARcoji2LfvsjGNFtdoFhSuk5kKPOmuKptTdXRBqddrLk1IDxDJb7+ICf413exMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Yweizecu; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b0415e03e25so750344466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 05:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757421041; x=1758025841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSLssCaJDALppdU5kT6wkNqD+9ziSVAOFWyEMcwXE4o=;
        b=YweizecukjmL9HIP11NEeTgbsXdy17p8WIkSqJo909I5iIxXQ1FjKC7XqEgPB2PNTL
         UrevGGBrTWw3kMx4yUl5w0MawMK1O+2lJqAKDI+zEC31Ok50fNchMlEQ8Adw4MhsmC7m
         LkopqlPyNgly5c5naCzI37DjvtMsZFSey+4Ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757421041; x=1758025841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aSLssCaJDALppdU5kT6wkNqD+9ziSVAOFWyEMcwXE4o=;
        b=k9hyDF9PqmTKk19DxhQ6kem07DYaHYIDi764sVasWtUC6RkckR3M4JvxwT4JfuKJ9S
         N8iQXr6yu1mMmLLHkdzrckJzEdI2wetbIr1i0qNuvr1khbLU9Y8m9T1j67mYXmmXJKuC
         QtlG6KbrcczX7qqWviDrJIqDoIe5WNRTv/kCZefMaVV65+mjFpn34ew/r6F/vXWhp/xA
         NRGneiiN/A4wpjWPQ13UfAX8c07fcHhw6LyxD8hr7yghvIgrUMwtaUoOCs8wZvKhxhIF
         PlkGP5y/aCX+UeAid1nGc2P6vtAiQ1Is/LjxQgCLUTY9RxGl7py4UyD5OgorGq3cPa4N
         Qvqg==
X-Forwarded-Encrypted: i=1; AJvYcCU829LTXRrSxV0yXL7kq9xr2d7veY7jZNvba8KIxLzxODQ2CFW9X1xSP0T7nt4MLVTHkjlqK1u5eZrdi8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyybkcfspGeEemdatGLUcOuTEM4K4Q9EHDKQ981qJm8QztJPOY
	i9iWKOA7nN9Gj3hLagR/vELlQ4JCRzlhxhFL+uUpGuuDpkhOX99VwL6Lr3JnfQYfcw==
X-Gm-Gg: ASbGncvwz9Ie+K1ZHWvwWfoJ7U67x0cG35z2A54AjJkpTeDHdA5tveGOVMhk87e75D8
	sYCig2Ww/wGkpyyBoJ6PH1HR/Rpnli8G9XOIwdJlGQbeha/R/RGm6uB53wUNnH5n0mX0YbcL/jn
	yd0RW3s6UmcjDu0aeSweUpGVJWxYIh2VWp2wU88kE2bvTe/qAt47ceuTAoIKBwZNWB5VC0eiv/D
	nyEa3OfrPb8iUpochtvXYl0Iet/unLby04w3YvGXVoKgViIlE0CbbaHAoPMtAmkwyYVzWPCDVaj
	6OUld4FqskikN3gdsh1uUoa/pGAq/rfiUbzoeeC7PTdYoUcaIV5xQA2TC0wwHDAkSHkk8BJaXXo
	A7oXloQDTsP7hjvhtYv2/XLttYH0JKSMN8Hg+A3uzOvAuRrxRyVNwQTqttN8DlLFc1E6p4EV8Ys
	OCYaAvFsytEGjxaSGtR6Bp69ZrdokwWfHOEi6K
X-Google-Smtp-Source: AGHT+IE16iHG878b0C3cu/M9l0FZasSEco+irvhp8UD7ksl2/950K4BbreEaXdQP9P+esGS33OjJhQ==
X-Received: by 2002:a17:907:3ea2:b0:b01:8fa4:6bb0 with SMTP id a640c23a62f3a-b04b1687e20mr1097269766b.44.1757421040942;
        Tue, 09 Sep 2025 05:30:40 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (240.225.32.34.bc.googleusercontent.com. [34.32.225.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b01902d0e99sm2409702166b.12.2025.09.09.05.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 05:30:40 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	Andrei Kuchynski <akuchynski@chromium.org>
Subject: [PATCH RFC 1/5] usb: typec: Implement mode selection
Date: Tue,  9 Sep 2025 12:30:24 +0000
Message-ID: <20250909123028.2127449-2-akuchynski@chromium.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
In-Reply-To: <20250909123028.2127449-1-akuchynski@chromium.org>
References: <20250909123028.2127449-1-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds APIs for managing the alternate mode selection process,
enabling the initiation and termination of mode entry based on each
mode's priority.

Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
---
 drivers/usb/typec/class.h          |   4 +
 drivers/usb/typec/mode_selection.c | 345 +++++++++++++++++++++++++++++
 drivers/usb/typec/mode_selection.h |  25 +++
 include/linux/usb/typec_altmode.h  |  11 +
 4 files changed, 385 insertions(+)

diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
index c53a04b9dc75..f3e731616f41 100644
--- a/drivers/usb/typec/class.h
+++ b/drivers/usb/typec/class.h
@@ -40,6 +40,10 @@ struct typec_partner {
 
 	struct usb_power_delivery	*pd;
 
+	struct list_head		mode_list;
+	struct mutex			mode_list_lock;
+	struct delayed_work		mode_selection_work;
+
 	void (*attach)(struct typec_partner *partner, struct device *dev);
 	void (*deattach)(struct typec_partner *partner, struct device *dev);
 };
diff --git a/drivers/usb/typec/mode_selection.c b/drivers/usb/typec/mode_selection.c
index 2179bf25f5d4..dbeb94f7f3e6 100644
--- a/drivers/usb/typec/mode_selection.c
+++ b/drivers/usb/typec/mode_selection.c
@@ -3,10 +3,58 @@
  * Copyright 2025 Google LLC.
  */
 
+#include <linux/list_sort.h>
+
 #include "mode_selection.h"
 #include "class.h"
 #include "bus.h"
 
+/* Timeout for a mode entry attempt, ms */
+static const unsigned int mode_selection_timeout = 4000;
+/* Delay between mode entry/exit attempts, ms */
+static const unsigned int mode_selection_delay = 1000;
+/* Maximum retries for mode entry on busy status */
+static const unsigned int mode_entry_attempts = 4;
+
+/**
+ * enum ms_state - Specific mode selection states
+ * @MS_STATE_IDLE: The mode entry process has not started
+ * @MS_STATE_INPROGRESS: The mode entry process is currently underway
+ * @MS_STATE_ACTIVE: The mode has been successfully entered
+ * @MS_STATE_TIMEOUT: Mode entry failed due to a timeout
+ * @MS_STATE_FAILED: The mode driver reported the error
+ */
+enum ms_state {
+	MS_STATE_IDLE = 0,
+	MS_STATE_INPROGRESS,
+	MS_STATE_ACTIVE,
+	MS_STATE_TIMEOUT,
+	MS_STATE_FAILED,
+};
+
+/**
+ * struct mode_selection_state - State tracking for a specific Type-C mode
+ * @svid: The Standard or Vendor ID (SVID) for this alternate mode
+ * @name: Name of the alternate mode
+ * @priority: The mode priority. Lower values indicate a more preferred mode
+ * @enter: Flag indicating if the driver is currently attempting to enter or
+ * exit the mode
+ * @attempt_count: Number of times the driver has attempted to enter the mode
+ * @state: The current mode selection state
+ * @error: The outcome of the last attempt to enter the mode
+ * @list: List head to link this mode state into a prioritized list
+ */
+struct mode_selection_state {
+	u16 svid;
+	const char *name;
+	unsigned int priority;
+	bool enter;
+	int attempt_count;
+	enum ms_state state;
+	int error;
+	struct list_head list;
+};
+
 static int increment_duplicated_priority(struct device *dev, void *data)
 {
 	struct typec_altmode **alt_target = (struct typec_altmode **)data;
@@ -36,3 +84,300 @@ void typec_mode_set_priority(struct typec_altmode *alt,
 		res = device_for_each_child(&port->dev, &alt,
 				increment_duplicated_priority);
 }
+
+static void mode_list_clean(struct typec_partner *partner)
+{
+	struct mode_selection_state *ms, *tmp;
+
+	list_for_each_entry_safe(ms, tmp, &partner->mode_list, list) {
+		list_del(&ms->list);
+		kfree(ms);
+	}
+}
+
+/**
+ * mode_selection_next() - Process mode selection results and schedule next
+ * action
+ * @partner: pointer to the partner structure
+ * @ms: pointer to active mode_selection_state object that is on top in
+ * mode_list.
+ *
+ * The mutex protecting mode_list must be held by the caller when invoking this
+ * function.
+ *
+ * This function evaluates the outcome of the previous mode entry or exit
+ * attempt. Based on this result, it determines the next mode to process and
+ * schedules `mode_selection_work_fn()` if further actions are required.
+ *
+ * If the previous mode entry was successful, the mode selection sequence is
+ * considered complete for the current cycle.
+ *
+ * If the previous mode entry failed, this function schedules
+ * `mode_selection_work_fn()` to attempt exiting the mode that was partially
+ * activated but not fully entered.
+ *
+ * If the previous operation was an exit (after a failed entry attempt),
+ * the internal list of candidate modes is advanced to determine the next mode
+ * to enter.
+ */
+static void mode_selection_next(
+	struct typec_partner *partner, struct mode_selection_state *ms)
+
+	__must_hold(&partner->mode_list_lock)
+{
+	if (!ms->enter) {
+		list_del(&ms->list);
+		kfree(ms);
+	} else if (ms->state == MS_STATE_INPROGRESS && !ms->error) {
+		list_del(&ms->list);
+		mode_list_clean(partner);
+
+		ms->state = MS_STATE_ACTIVE;
+		list_add_tail(&ms->list, &partner->mode_list);
+	} else {
+		if (ms->error) {
+			ms->state = MS_STATE_FAILED;
+			dev_dbg(&partner->dev, "%s: entry mode error %pe\n",
+				ms->name, ERR_PTR(ms->error));
+		}
+		if (ms->error != -EBUSY || ms->attempt_count >= mode_entry_attempts)
+			ms->enter = false;
+	}
+
+	ms = list_first_entry_or_null(
+		&partner->mode_list, struct mode_selection_state, list);
+	if (ms && ms->state != MS_STATE_ACTIVE)
+		schedule_delayed_work(&partner->mode_selection_work,
+			msecs_to_jiffies(mode_selection_delay));
+}
+
+void typec_altmode_entry_complete(struct typec_altmode *altmode,
+				const int error)
+{
+	struct typec_partner *partner = to_typec_partner(altmode->dev.parent);
+	struct mode_selection_state *ms;
+
+	mutex_lock(&partner->mode_list_lock);
+
+	ms = list_first_entry_or_null(
+		&partner->mode_list, struct mode_selection_state, list);
+	if (ms) {
+		if (ms->svid == altmode->svid && ms->state == MS_STATE_INPROGRESS) {
+			ms->error = error;
+			cancel_delayed_work(&partner->mode_selection_work);
+			mode_selection_next(partner, ms);
+		}
+	}
+
+	mutex_unlock(&partner->mode_list_lock);
+}
+EXPORT_SYMBOL_GPL(typec_altmode_entry_complete);
+
+static int mode_selection_activate_altmode(struct device *dev, void *data)
+{
+	struct mode_selection_state *ms = (struct mode_selection_state *)data;
+	int error = -ENODEV;
+	int ret = 0;
+
+	if (is_typec_altmode(dev)) {
+		struct typec_altmode *altmode = to_typec_altmode(dev);
+
+		if (ms->svid == altmode->svid) {
+			if (altmode->ops && altmode->ops->activate)
+				error = altmode->ops->activate(altmode, ms->enter);
+			else
+				error = -EOPNOTSUPP;
+			ret = 1;
+		}
+	}
+
+	if (ms->enter) {
+		ms->attempt_count++;
+		ms->error = error;
+	}
+
+	return ret;
+}
+
+/**
+ * mode_selection_work_fn() - Activate entry into the upcoming mode
+ * @work: work structure
+ *
+ * This function works in conjunction with `mode_selection_next()`.
+ * It attempts to activate the next mode in the selection sequence.
+ *
+ * If the mode activation (`mode_selection_activate_altmode()`) fails,
+ * `mode_selection_next()` will be called to initiate a new selection cycle.
+ *
+ * Otherwise, the state is set to MS_STATE_INPROGRESS, and
+ * `mode_selection_work_fn()` is scheduled for a subsequent entry after a timeout
+ * period. The alternate mode driver is expected to call back with the actual
+ * mode entry result. Upon this callback, `mode_selection_next()` will determine
+ * the subsequent mode and re-schedule `mode_selection_work_fn()`.
+ */
+static void mode_selection_work_fn(struct work_struct *work)
+{
+	struct typec_partner *partner = container_of(work, struct typec_partner,
+						  mode_selection_work.work);
+	struct mode_selection_state *ms;
+
+	mutex_lock(&partner->mode_list_lock);
+
+	ms = list_first_entry_or_null(
+		&partner->mode_list, struct mode_selection_state, list);
+	if (ms) {
+		if (ms->state == MS_STATE_INPROGRESS) {
+			ms->state = MS_STATE_TIMEOUT;
+			mode_selection_next(partner, ms);
+		} else {
+			device_for_each_child(&partner->dev, ms,
+				mode_selection_activate_altmode);
+
+			if (ms->enter && !ms->error) {
+				ms->state = MS_STATE_INPROGRESS;
+				schedule_delayed_work(&partner->mode_selection_work,
+					msecs_to_jiffies(mode_selection_timeout));
+			} else
+				mode_selection_next(partner, ms);
+		}
+	}
+
+	mutex_unlock(&partner->mode_list_lock);
+}
+
+void typec_mode_selection_add_partner(struct typec_partner *partner)
+{
+	INIT_LIST_HEAD(&partner->mode_list);
+	mutex_init(&partner->mode_list_lock);
+	INIT_DELAYED_WORK(&partner->mode_selection_work, mode_selection_work_fn);
+}
+
+void typec_mode_selection_remove_partner(struct typec_partner *partner)
+{
+	mutex_lock(&partner->mode_list_lock);
+	mode_list_clean(partner);
+	mutex_unlock(&partner->mode_list_lock);
+
+	cancel_delayed_work_sync(&partner->mode_selection_work);
+	mutex_destroy(&partner->mode_list_lock);
+}
+
+bool typec_mode_selection_is_pending(struct typec_partner *partner)
+{
+	struct mode_selection_state *ms = list_first_entry_or_null(
+			&partner->mode_list, struct mode_selection_state, list);
+
+	return ms != NULL;
+}
+
+static int compare_priorities(void *priv,
+	const struct list_head *a, const struct list_head *b)
+{
+	struct mode_selection_state *msa =
+			container_of(a, struct mode_selection_state, list);
+	struct mode_selection_state *msb =
+			container_of(b, struct mode_selection_state, list);
+
+	if (msa->priority < msb->priority)
+		return -1;
+	return 1;
+}
+
+static int mode_add_to_list(struct device *dev, void *data)
+{
+	struct list_head *list = (struct list_head *)data;
+	struct mode_selection_state *ms;
+
+	if (is_typec_altmode(dev)) {
+		struct typec_altmode *altmode = to_typec_altmode(dev);
+		const struct typec_altmode *pdev = typec_altmode_get_partner(altmode);
+
+		if (pdev) {
+			ms = kzalloc(sizeof(struct mode_selection_state), GFP_KERNEL);
+			if (!ms)
+				return -ENOMEM;
+
+			ms->svid = altmode->svid;
+			ms->name = altmode->desc;
+			ms->priority = pdev->priority;
+			ms->enter = true;
+			INIT_LIST_HEAD(&ms->list);
+			list_add_tail(&ms->list, list);
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * typec_mode_selection_start() - Starts the mode selection process.
+ * @partner: pointer to the partner structure
+ *
+ * This function populates mode_list with pointers to
+ * `struct mode_selection_state` instances. The sequence is generated based on
+ * partner capabilities and prioritized according to the port's settings.
+ */
+int typec_mode_selection_start(struct typec_partner *partner)
+{
+	int ret;
+
+	mutex_lock(&partner->mode_list_lock);
+
+	if (typec_mode_selection_is_pending(partner))
+		ret = -EALREADY;
+	else {
+		ret = device_for_each_child(
+			&partner->dev, &partner->mode_list, mode_add_to_list);
+
+		if (ret)
+			mode_list_clean(partner);
+		else if (!list_empty(&partner->mode_list)) {
+			list_sort(NULL, &partner->mode_list, compare_priorities);
+			schedule_delayed_work(&partner->mode_selection_work, 0);
+		}
+	}
+
+	mutex_unlock(&partner->mode_list_lock);
+	return ret;
+}
+
+/**
+ * typec_mode_selection_reset() - Reset the mode selection process.
+ * @partner: pointer to the partner structure
+ *
+ * This function cancels ongoing mode selection and exits the currently active
+ * mode, if present.
+ * It returns -EINPROGRESS when a mode entry is ongoing, indicating that the
+ * reset cannot immediately complete.
+ */
+int typec_mode_selection_reset(struct typec_partner *partner)
+{
+	struct mode_selection_state *ms;
+	int ret = 0;
+
+	mutex_lock(&partner->mode_list_lock);
+
+	ms = list_first_entry_or_null(
+		&partner->mode_list, struct mode_selection_state, list);
+	if (ms) {
+		if (ms->state == MS_STATE_ACTIVE) {
+			ms->enter = false;
+			device_for_each_child(&partner->dev, ms,
+					mode_selection_activate_altmode);
+		} else if (ms->state != MS_STATE_IDLE) {
+			list_del(&ms->list);
+			mode_list_clean(partner);
+
+			ms->attempt_count = mode_entry_attempts;
+			list_add(&ms->list, &partner->mode_list);
+
+			ret = -EINPROGRESS;
+		}
+
+		if (!ret)
+			mode_list_clean(partner);
+	}
+
+	mutex_unlock(&partner->mode_list_lock);
+	return ret;
+}
diff --git a/drivers/usb/typec/mode_selection.h b/drivers/usb/typec/mode_selection.h
index cbf5a37e6404..9049b5a25d63 100644
--- a/drivers/usb/typec/mode_selection.h
+++ b/drivers/usb/typec/mode_selection.h
@@ -4,3 +4,28 @@
 
 void typec_mode_set_priority(struct typec_altmode *alt,
 		const unsigned int priority);
+
+/**
+ * The mode selection process follows a lifecycle tied to the USB-C partner
+ * device. The API is designed to first build a set of desired modes and then
+ * trigger the selection process. The expected sequence of calls is as follows:
+ *
+ * Creation and Configuration:
+ * Call typec_mode_selection_add_partner() when the partner device is being set
+ * up.
+ *
+ * Execution:
+ * Call typec_mode_selection_start() to trigger the mode selection.
+ * typec_mode_selection_is_pending() returns true if the process is in progress
+ * or complete.
+ * Call typec_mode_selection_reset() to stop the selection process and exit
+ * the currently active mode.
+ *
+ * Destruction:
+ * Before destroying a partner, call typec_mode_selection_remove_partner()
+ */
+void typec_mode_selection_add_partner(struct typec_partner *partner);
+void typec_mode_selection_remove_partner(struct typec_partner *partner);
+int typec_mode_selection_start(struct typec_partner *partner);
+bool typec_mode_selection_is_pending(struct typec_partner *partner);
+int typec_mode_selection_reset(struct typec_partner *partner);
diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
index 571c6e00b54f..fd9ee3ef8de3 100644
--- a/include/linux/usb/typec_altmode.h
+++ b/include/linux/usb/typec_altmode.h
@@ -219,4 +219,15 @@ void typec_altmode_unregister_driver(struct typec_altmode_driver *drv);
 	module_driver(__typec_altmode_driver, typec_altmode_register_driver, \
 		      typec_altmode_unregister_driver)
 
+/**
+ * typec_altmode_entry_complete - Complete an alternate mode entry request
+ * @altmode: Handle to the alternate mode.
+ * @result: Result of the entry operation.
+ *
+ * This function should be called by a driver to report the final result of
+ * an asynchronous alternate mode entry request.
+ */
+void typec_altmode_entry_complete(struct typec_altmode *altmode,
+				const int result);
+
 #endif /* __USB_TYPEC_ALTMODE_H */
-- 
2.51.0.384.g4c02a37b29-goog



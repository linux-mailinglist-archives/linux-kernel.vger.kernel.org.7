Return-Path: <linux-kernel+bounces-773844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 302CCB2AB61
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B473E5A3F8D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8797A322747;
	Mon, 18 Aug 2025 14:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AirM45sr"
Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C1A321F5F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755527345; cv=none; b=PeQnHcR2r+4WbcPL6VxCL6PZz9eyKZoNnPFpQ4sWXvMtJ2lVYVMt202Z2yWhuCKovalC7oKkqEKroSI06xgsOtoMHF4N2WU9DUyDW+Yzmq0rwQtDzN50D1wpgbk4uddueH3xBqiOrCEm+a9GY3vAsmYqqU8qY4EgiwEEnGQnsMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755527345; c=relaxed/simple;
	bh=LJ1GlPQvHqQu3u0FYX989UGu1oTfcrJCz9sTwuz2MHc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=orDjzljx7aHV7gMZBpDwcW0MIJQVA2VgCWHFhp8tYJUNC8RrB0yivqgLSe4GW9y2B+92t3nlN4FBxIlLBd9cQqC5jZmfmcnlhgNd+SPMkjUoxcZyeIjYF3UxdXsSYJEBEWQagQMCTDPwfVUd3DoNktzLedLqNVao2uD7jF8ypOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AirM45sr; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-435de5bb303so2568866b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755527343; x=1756132143; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TAAxlO68X25OTp3J1WUCgKbQRx2Z1emMAKOD610BueU=;
        b=AirM45srXIm2uP3KGduWo7q/B1pGNX0rBV7BNvoP8Pu7QnPAUdfOtiG7ebAOMc6kiT
         pjcW/uNtLhnSpyelwF3RbLSd+wWo6lM40hQhAmJrECRWBUzFD53zVa4dUi6gEl2rLso5
         rm9t6d4CZtnCNetO0GluVZHqjqvbv5uaiUruHk+2DXK+w7SWYpG4l16ZDGfY2Vpj3iro
         ewBLvoQve2/4Y5gm85sAa+KsQ7t8xgoUaNrJwHJkg5UhJ6PLxyzGNT/nWtS/uPfWUrF2
         MVTqTencoQepj2KnyUEBTKjo1v05fPtAXN1M1KXkXfwNXoVFqmEFjh8GBM6fBYoMHI8P
         plhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755527343; x=1756132143;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TAAxlO68X25OTp3J1WUCgKbQRx2Z1emMAKOD610BueU=;
        b=V/CQT1KjTX2/qPfAwMSsLkyK1bLUt7FSaNLsDZDWB4IQ3EUnWWSHhbZhBt+1AepjvZ
         OOWlxDO9E2p1TVE/nkXZLI8LNHnF9nGWBIIWqMfCgrY8G7d2IWbPmu/mrgN2mwjfbuZB
         w03AQkoXxttgeMU2gOlpBxBZAk3zixRcrZkUsyb6dm+pKJw287/ywKSNOgYmjUf/Dtno
         D/z2tGvCyC8FZmbwKjoWhiaDmjKl85Jc04ScYoWUyLLGlHISwsDMbo2AefV3i6ENcX6+
         IOuLe78bBGJeD83XhE5wyS9K23cxaPg7CFKaKPaEuZLX8ybIFWQEDUjIsD4lwkQoA1fB
         WQsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVniNwI3ttWyjjSk8D7hgXglnuaGtWhYsguJMPc0qAIVFV9ExdjQ8BlXtIyaKnLR7tQx2DnGbAv9ARZL6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo0KfeYRizty+XvR61vwGB143mwk1Ofl5g6VAo5u72HBV7MIdx
	zxUeQBtrCZiGQOgvDCH2QFYLw9Bj5YwtTwIDJD9tZa7G5KN4Vlm5vvuFOcqV9iC7qwGk3T17MxK
	m14FKXQtVzQ==
X-Google-Smtp-Source: AGHT+IEwbnYw3hhSKeD0w0SzfJ/3gajyKjN1LgLpZCzsAHO9XaTpDy4Q1dpo5YON1mlN+ZzLIBRAIQjM/G31
X-Received: from jabhb19.prod.google.com ([2002:a05:6638:6c13:b0:4fd:c6b9:3df7])
 (user=jdenose job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:23c2:b0:434:39d7:cb11
 with SMTP id 5614622812f47-435ec361f40mr6179116b6e.6.1755527342946; Mon, 18
 Aug 2025 07:29:02 -0700 (PDT)
Date: Mon, 18 Aug 2025 14:28:04 +0000
In-Reply-To: <20250818-support-forcepads-v2-0-ca2546e319d5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250818-support-forcepads-v2-0-ca2546e319d5@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250818-support-forcepads-v2-4-ca2546e319d5@google.com>
Subject: [PATCH v2 04/11] HID: haptic: introduce hid_haptic_device
From: Jonathan Denose <jdenose@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Angela Czubak <aczubak@google.com>, 
	"Sean O'Brien" <seobrien@google.com>, Jonathan Denose <jdenose@google.com>
Content-Type: text/plain; charset="utf-8"

From: Angela Czubak <aczubak@google.com>

Define a new structure that contains simple haptic device configuration
as well as current state.
Add functions that recognize auto trigger and manual trigger reports
as well as save their addresses.
Verify that the pressure unit is either grams or newtons.
Mark the input device as a haptic touchpad if the unit is correct and
the reports are found.

Signed-off-by: Angela Czubak <aczubak@google.com>
Co-developed-by: Jonathan Denose <jdenose@google.com>
Signed-off-by: Jonathan Denose <jdenose@google.com>
---
 drivers/hid/Kconfig      |  11 +++++
 drivers/hid/Makefile     |   1 +
 drivers/hid/hid-haptic.c |  72 ++++++++++++++++++++++++++++++++
 drivers/hid/hid-haptic.h | 105 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 189 insertions(+)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 43859fc757470caf6ad43bd5f72f119e9c36aea7..cbbe82a0a2ba257e45f77ca014fb5f08b71fc62f 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -92,6 +92,17 @@ config HID_GENERIC
 
 	If unsure, say Y.
 
+config HID_HAPTIC
+	bool "Haptic touchpad support"
+	default n
+	help
+	Support for touchpads with force sensors and haptic actuators instead of a
+	traditional button.
+	Adds extra parsing and FF device for the hid multitouch driver.
+	It can be used for Elan 2703 haptic touchpad.
+
+	If unsure, say N.
+
 menu "Special HID drivers"
 
 config HID_A4TECH
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 10ae5dedbd84708d988ea1f594d409ccebd85ebb..361a7daedeb85454114def8afb5f58caeab58a00 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -4,6 +4,7 @@
 #
 hid-y			:= hid-core.o hid-input.o hid-quirks.o
 hid-$(CONFIG_DEBUG_FS)		+= hid-debug.o
+hid-$(CONFIG_HID_HAPTIC)	+= hid-haptic.o
 
 obj-$(CONFIG_HID_BPF)		+= bpf/
 
diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
new file mode 100644
index 0000000000000000000000000000000000000000..d659a430c1a6b06ded31d49efe4bded909671cb6
--- /dev/null
+++ b/drivers/hid/hid-haptic.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  HID Haptic support for Linux
+ *
+ *  Copyright (c) 2021 Angela Czubak <acz@semihalf.com>
+ */
+
+#include "hid-haptic.h"
+
+void hid_haptic_feature_mapping(struct hid_device *hdev,
+				struct hid_haptic_device *haptic,
+				struct hid_field *field, struct hid_usage *usage)
+{
+	if (usage->hid == HID_HP_AUTOTRIGGER) {
+		if (usage->usage_index >= field->report_count) {
+			dev_err(&hdev->dev,
+				"HID_HP_AUTOTRIGGER out of range\n");
+			return;
+		}
+
+		hid_device_io_start(hdev);
+		hid_hw_request(hdev, field->report, HID_REQ_GET_REPORT);
+		hid_hw_wait(hdev);
+		hid_device_io_stop(hdev);
+		haptic->default_auto_trigger =
+			field->value[usage->usage_index];
+		haptic->auto_trigger_report = field->report;
+	}
+}
+EXPORT_SYMBOL_GPL(hid_haptic_feature_mapping);
+
+bool hid_haptic_check_pressure_unit(struct hid_haptic_device *haptic,
+				    struct hid_input *hi, struct hid_field *field)
+{
+	if (field->unit == HID_UNIT_GRAM || field->unit == HID_UNIT_NEWTON)
+		return true;
+	return false;
+}
+EXPORT_SYMBOL_GPL(hid_haptic_check_pressure_unit);
+
+int hid_haptic_input_mapping(struct hid_device *hdev,
+			     struct hid_haptic_device *haptic,
+			     struct hid_input *hi,
+			     struct hid_field *field, struct hid_usage *usage,
+			     unsigned long **bit, int *max)
+{
+	if (usage->hid == HID_HP_MANUALTRIGGER) {
+		haptic->manual_trigger_report = field->report;
+		/* we don't really want to map these fields */
+		return -1;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hid_haptic_input_mapping);
+
+int hid_haptic_input_configured(struct hid_device *hdev,
+				struct hid_haptic_device *haptic,
+				struct hid_input *hi)
+{
+
+	if (hi->application == HID_DG_TOUCHPAD) {
+		if (haptic->auto_trigger_report &&
+		    haptic->manual_trigger_report) {
+			__set_bit(INPUT_PROP_HAPTIC_TOUCHPAD, hi->input->propbit);
+			return 1;
+		}
+		return 0;
+	}
+	return -1;
+}
+EXPORT_SYMBOL_GPL(hid_haptic_input_configured);
diff --git a/drivers/hid/hid-haptic.h b/drivers/hid/hid-haptic.h
new file mode 100644
index 0000000000000000000000000000000000000000..b729f8245aa60c3d06b79b11846dccf6fcc0c08b
--- /dev/null
+++ b/drivers/hid/hid-haptic.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *  HID Haptic support for Linux
+ *
+ *  Copyright (c) 2021 Angela Czubak <acz@semihalf.com>
+ */
+
+/*
+ */
+
+
+#include <linux/hid.h>
+
+#define HID_HAPTIC_ORDINAL_WAVEFORMNONE 1
+#define HID_HAPTIC_ORDINAL_WAVEFORMSTOP 2
+
+#define HID_HAPTIC_MODE_DEVICE 0
+#define HID_HAPTIC_MODE_HOST 1
+
+struct hid_haptic_effect {
+	u8 *report_buf;
+	struct input_dev *input_dev;
+	struct work_struct work;
+	struct list_head control;
+	struct mutex control_mutex;
+};
+
+struct hid_haptic_effect_node {
+	struct list_head node;
+	struct file *file;
+};
+
+struct hid_haptic_device {
+	struct input_dev *input_dev;
+	struct hid_device *hdev;
+	struct hid_report *auto_trigger_report;
+	struct mutex auto_trigger_mutex;
+	struct workqueue_struct *wq;
+	struct hid_report *manual_trigger_report;
+	struct mutex manual_trigger_mutex;
+	size_t manual_trigger_report_len;
+	int pressed_state;
+	s32 pressure_sum;
+	s32 force_logical_minimum;
+	s32 force_physical_minimum;
+	s32 force_resolution;
+	u32 mode;
+	u32 default_auto_trigger;
+	u32 vendor_page;
+	u32 vendor_id;
+	u32 max_waveform_id;
+	u32 max_duration_id;
+	u16 *hid_usage_map;
+	u32 *duration_map;
+	u16 press_ordinal;
+	u16 release_ordinal;
+	struct hid_haptic_effect *effect;
+	struct hid_haptic_effect stop_effect;
+};
+
+#ifdef CONFIG_HID_HAPTIC
+void hid_haptic_feature_mapping(struct hid_device *hdev,
+				struct hid_haptic_device *haptic,
+				struct hid_field *field, struct hid_usage
+				*usage);
+bool hid_haptic_check_pressure_unit(struct hid_haptic_device *haptic,
+				    struct hid_input *hi, struct hid_field *field);
+int hid_haptic_input_mapping(struct hid_device *hdev,
+			     struct hid_haptic_device *haptic,
+			     struct hid_input *hi,
+			     struct hid_field *field, struct hid_usage *usage,
+			     unsigned long **bit, int *max);
+int hid_haptic_input_configured(struct hid_device *hdev,
+				struct hid_haptic_device *haptic,
+				struct hid_input *hi);
+#else
+static inline
+void hid_haptic_feature_mapping(struct hid_device *hdev,
+				struct hid_haptic_device *haptic,
+				struct hid_field *field, struct hid_usage
+				*usage)
+{}
+static inline
+bool hid_haptic_check_pressure_unit(struct hid_haptic_device *haptic,
+				    struct hid_input *hi, struct hid_field *field)
+{
+	return false;
+}
+static inline
+int hid_haptic_input_mapping(struct hid_device *hdev,
+			     struct hid_haptic_device *haptic,
+			     struct hid_input *hi,
+			     struct hid_field *field, struct hid_usage *usage,
+			     unsigned long **bit, int *max)
+{
+	return 0;
+}
+static inline
+int hid_haptic_input_configured(struct hid_device *hdev,
+				struct hid_haptic_device *haptic,
+				struct hid_input *hi)
+{
+	return 0;
+}
+#endif

-- 
2.51.0.rc1.163.g2494970778-goog



Return-Path: <linux-kernel+bounces-774572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B33EB2B45D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3AC2A0F14
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 23:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1AF27B352;
	Mon, 18 Aug 2025 23:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ltaHO5Fa"
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148D927A46E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 23:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755558640; cv=none; b=EVpfN7D4jyfMadhqVnFC+iq5uGA06NAYMiM0ps/FXIVEd1sRQn9BB66pqiZvDINbIous9RWR5nUzEgz9WA5kLgz6agxHoNRko6REMK71L7JciPA1SzZez9vskYaTsRNV+3ERAeIJb2ii7+pviIFU2q2VsGCLoIW9o3cg4D3tFv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755558640; c=relaxed/simple;
	bh=7TrDKAAZtsRGZI6gBph3Bshg7JPs1/WJmYhCqBgo+SQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ui1iNZtQLq7Kn6ZDIVtHvD5WOdRcz1kOxol6BaHDlnAcdGP3ziTbvp3+kLckiCZBecumZvOXLvU0yGwYtI0QDW3T20gUyHZWrptWegLFU+uM9V4Vo+ezgWTD8RQaBDL4VHK4PtN1OM3maH7ms+tMwVFfKjK+ADNqorLwW1UvPDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ltaHO5Fa; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-88432dc61d9so1255306139f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 16:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755558638; x=1756163438; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K8bS//tJvRP9+OItmvzAW0lhRS/UPeeXHlsLDZL+8Ak=;
        b=ltaHO5FahoHrE7cTOJeS85EEJMlT9LFsRaygxYgaX0KJWiTuZbJKNLNYMXhgo3czEP
         /aPl+Ks9RAL+E5RStuHtMGCPi5JEWx+fWIfTXDCwPZDAKzhwb6DUpShsAeh6BXGPcLkb
         s5k2aLWEhZ1K2uupp4UmADhSe3JVzsSRQTzAhbuVYCliO9vTpWqiR/xbmxLmN7f4Pbaq
         lf/Uld4EM13XE67IVQDNKvawevMRekLwmXgAS37Tcry40t8Z6FCtEUKPBn1KAFCLYwrt
         EfucZnddOK21Uiii+BwmGfd2I5gP69eBOtCEPJMJy1d5lxtDSvJkhEeOMHs/TdrfqKz+
         BbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755558638; x=1756163438;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K8bS//tJvRP9+OItmvzAW0lhRS/UPeeXHlsLDZL+8Ak=;
        b=uPE3aOA0QYQMTWs7TQc3UQnXHXw4xZSESG8YdgXP8PA0KaN5VVDMHvmkyUbRvSLhWZ
         MyH1fPnpg0P7KGovEhKoj8PCnG2y8GwK1asOPAd7EN7P8Zue1UwQ7KcC7brN174+tyRB
         gd3A/pUncheUIu9/Pfc2PO7iC80hApc6U1n6FB/JSROVBkxGp9Y1nBZaBVmZ9EBVd4aC
         mLQEtjPfz9OApUVfYPMc+nb/uWXAU0GcZKCr0H4qAeiOvP6Up0WiJu6OH0Xk3m0oY2CK
         0kIolKCvyQnccWe7+qWZOVkEH/41Ut0tlQJcG+0pmFG4iblgt1kYckHU7hnR9CNsor2E
         ONFA==
X-Forwarded-Encrypted: i=1; AJvYcCWZyhfr+bENHbVTRJdxZWnniAYdqdxbwSN+WwfV5TifIQYKJrbqCZTgd9ZEj3+fhSTMxO0axBdethqAflA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY6f7WCR54z4wtSBTq+W6eGbmxowUbMFip8R6k0axFGFvqKGP1
	aJLfjsZXha3HE9n26VsRo5FiQLpWXorbLTcLg6uxeuViEONs8bkvKn0l7OaPGrE3VP0hy6AD+jj
	wc6s3XXzpTw==
X-Google-Smtp-Source: AGHT+IE9gj54QP/bO7euNEkea4aABXmJLtEXYvaXSmrB2uf5bk6Si4j7pdhGAsywgRdY7g3igkBIfc4zV989
X-Received: from ioyy26.prod.google.com ([2002:a05:6602:215a:b0:87c:605f:297f])
 (user=jdenose job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6602:6429:b0:87c:30d4:65f2
 with SMTP id ca18e2360f4ac-88467e8db10mr82476339f.3.1755558638227; Mon, 18
 Aug 2025 16:10:38 -0700 (PDT)
Date: Mon, 18 Aug 2025 23:08:45 +0000
In-Reply-To: <20250818-support-forcepads-v3-0-e4f9ab0add84@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250818-support-forcepads-v3-0-e4f9ab0add84@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250818-support-forcepads-v3-4-e4f9ab0add84@google.com>
Subject: [PATCH v3 04/11] HID: haptic: introduce hid_haptic_device
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
 drivers/hid/Kconfig      |  11 ++++++
 drivers/hid/Makefile     |   1 +
 drivers/hid/hid-haptic.c |  72 +++++++++++++++++++++++++++++++++
 drivers/hid/hid-haptic.h | 101 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 185 insertions(+)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 43859fc757470caf6ad43bd5f72f119e9c36aea7..fa0a53287c0ed6b5853d0e80641df341fb728332 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -92,6 +92,17 @@ config HID_GENERIC
 
 	If unsure, say Y.
 
+config HID_HAPTIC
+	tristate "Haptic touchpad support"
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
index 0000000000000000000000000000000000000000..2e89addf5ec280d5b9a59d06088cc08bd4f445c1
--- /dev/null
+++ b/drivers/hid/hid-haptic.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *  HID Haptic support for Linux
+ *
+ *  Copyright (c) 2021 Angela Czubak <acz@semihalf.com>
+ */
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
+#if IS_ENABLED(CONFIG_HID_HAPTIC)
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
2.51.0.rc1.193.gad69d77794-goog



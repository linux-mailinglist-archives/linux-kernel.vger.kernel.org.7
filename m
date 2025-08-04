Return-Path: <linux-kernel+bounces-755289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF43B1A428
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174E618A0F89
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67658270ECF;
	Mon,  4 Aug 2025 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sPfhHnOp"
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079D626FA6F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754316683; cv=none; b=quBmTZgXNt0DgddgwEWxIUjmgbZHNcVbddSQTRMblOo6B5ntUMiwFdb33xBwW0fcdvxgvkG9Sxwst0YTZxdoeB4YcY024XLaqsIFQxsVdILCY84EO9rjAFgASJ7s5oFqdLgxnpKSEE9QAhmj9SuU+Yr594bcx/hEEcH4xV2ZHgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754316683; c=relaxed/simple;
	bh=F+PXi5nM5lhXJgRf7ORFGFHyO6OD7uAo4HwtKB8OfpY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ACFgBFYAJKGqmeirFCCjWr+A938Ix6Y5SRPzl9Iehw47eJzmUZE577N5V37l+NLw6OkHjrYAw7otAyWOH+kK3MBaFLAUI8iq8OilDfcZeRuCs4SOjcJ7ZZlt+mcYZsEXeXN2L4TOCKCAoVFJ3keOVoeqQlkIjgfnf95TtAZZb2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sPfhHnOp; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3e3f0287933so90400905ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 07:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754316681; x=1754921481; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ubZ4Umicq2gw4MKto41GXn4WlYxaCA6Z7+4qXt7C5zs=;
        b=sPfhHnOpgceGdnwJCChO6j0GkCtX1eBB2RU1sj8BV/dI7QwjH4mG/xYc3tcrCHUEAU
         Q/W4X6CDzHmA1gpbqOV/3RHDVN48JgG9fe0I5pWNrz85hv+vZofhiKfVwz9uvdbifsLc
         wa63z+ZobkDCuoW4ocdwAiLFtJTaVIwY0itlofbrCfCWmPLlEFHi7EwGVeJoWqzf+97w
         VNeuShfB5QTCeOV5MPo85OtFERB/63z981/b2TXhfotIXcGAXKidQKmUhtMoVBxhkrTA
         fZKsKD5gS54N5o9rBK+kLf1b4/lpEePStTfztkhIyYT8t2L2kfA0HlzHFvZW2VtkdKla
         rgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754316681; x=1754921481;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ubZ4Umicq2gw4MKto41GXn4WlYxaCA6Z7+4qXt7C5zs=;
        b=f4K9yC0HFpTaRv29Kje6y61LcWL+/p0WIeGbT3cJG8oqkemVd4kzsMlJv4zz1/E2VR
         VF8DDPsETK5ADPH3dpkOQlnXoiQEuXOHVzvU8hcG8Ob7gjMQWDbmxnYsf2uKwnmjhIhe
         CXqcfeMOcTAvAkeCdUPtI02Ci003opYxmcDXrx/4XGMTTgxR5khrkD88xZ1MSmgb8YL4
         ZkS4vMK7xohStec0YGCf3eIaaO/Q1LCe162cBcps5C9lkOyKweANY2cGJBUg469ZzGsu
         XuZJEHAmeq+4ivuRf7j7vboGuibG1O3q9GARhhKLXsknTsCJHF0f2ERTYsB7E4UCmwrA
         qnAg==
X-Forwarded-Encrypted: i=1; AJvYcCXlggYK7k1NBvAsosilUVMvGwzmarZ1bEP4tS4xmkEkfJCmZ9bfF4giIb9uP1E28qnO3lHlkHSS2rX3SaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOEuyfqCcsXGKqf94U1SDmlwpc2jQjVTcDXtWKLUmy9c+qcaVY
	wEDgkMlO1yG8DafMKo9cCE3jney1I35/fn2RtL+IM4TEfNSR4zsq28QCpQ2L9ZaU6pNraXE/6PA
	aWoxfK04+7A==
X-Google-Smtp-Source: AGHT+IF2q3PwFU6Q37KO4T7Vtt47/cfdjWmrjamRPYqbNsjjM1NxjObawUg+Xrc/aeyAnjn1qvapjP+kXXxu
X-Received: from ilbec19.prod.google.com ([2002:a05:6e02:4713:b0:3e4:90c:613a])
 (user=jdenose job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6e02:160b:b0:3e3:d50c:d657
 with SMTP id e9e14a558f8ab-3e41610a4ccmr163038395ab.3.1754316680974; Mon, 04
 Aug 2025 07:11:20 -0700 (PDT)
Date: Mon, 04 Aug 2025 14:11:17 +0000
In-Reply-To: <20250804-support-forcepads-v2-0-138ca980261d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250804-support-forcepads-v2-0-138ca980261d@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250804-support-forcepads-v2-2-138ca980261d@google.com>
Subject: [PATCH v2 02/11] Input: add FF_HID effect type
From: Jonathan Denose <jdenose@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Angela Czubak <aczubak@google.com>, 
	"Sean O'Brien" <seobrien@google.com>, Jonathan Denose <jdenose@google.com>
Content-Type: text/plain; charset="utf-8"

From: Angela Czubak <aczubak@google.com>

FF_HID effect type can be used to trigger haptic feedback with HID simple
haptic usages.

Signed-off-by: Angela Czubak <aczubak@google.com>
Co-developed-by: Jonathan Denose <jdenose@google.com>
Signed-off-by: Jonathan Denose <jdenose@google.com>
---
 include/uapi/linux/input.h | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index 2557eb7b056178b2b8be98d9cea855eba1bd5aaf..3ea7c826c6fb2034e46f95cb95b84ef6f5b866df 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -428,6 +428,24 @@ struct ff_rumble_effect {
 	__u16 weak_magnitude;
 };
 
+/**
+ * struct ff_hid_effect
+ * @hid_usage: hid_usage according to Haptics page (WAVEFORM_CLICK, etc.)
+ * @vendor_id: the waveform vendor ID if hid_usage is in the vendor-defined range
+ * @vendor_waveform_page: the vendor waveform page if hid_usage is in the vendor-defined range
+ * @intensity: strength of the effect as percentage
+ * @repeat_count: number of times to retrigger effect
+ * @retrigger_period: time before effect is retriggered (in ms)
+ */
+struct ff_hid_effect {
+	__u16 hid_usage;
+	__u16 vendor_id;
+	__u8  vendor_waveform_page;
+	__u16 intensity;
+	__u16 repeat_count;
+	__u16 retrigger_period;
+};
+
 /**
  * struct ff_effect - defines force feedback effect
  * @type: type of the effect (FF_CONSTANT, FF_PERIODIC, FF_RAMP, FF_SPRING,
@@ -464,6 +482,7 @@ struct ff_effect {
 		struct ff_periodic_effect periodic;
 		struct ff_condition_effect condition[2]; /* One for each axis */
 		struct ff_rumble_effect rumble;
+		struct ff_hid_effect hid;
 	} u;
 };
 
@@ -471,6 +490,7 @@ struct ff_effect {
  * Force feedback effect types
  */
 
+#define FF_HID		0x4f
 #define FF_RUMBLE	0x50
 #define FF_PERIODIC	0x51
 #define FF_CONSTANT	0x52
@@ -480,7 +500,7 @@ struct ff_effect {
 #define FF_INERTIA	0x56
 #define FF_RAMP		0x57
 
-#define FF_EFFECT_MIN	FF_RUMBLE
+#define FF_EFFECT_MIN	FF_HID
 #define FF_EFFECT_MAX	FF_RAMP
 
 /*

-- 
2.50.1.565.gc32cd1483b-goog



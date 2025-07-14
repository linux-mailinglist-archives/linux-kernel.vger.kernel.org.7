Return-Path: <linux-kernel+bounces-730311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BC3B042D7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91C9D7B5F27
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A0E25BF00;
	Mon, 14 Jul 2025 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nTr7HNOt"
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B4C25B2F4
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505782; cv=none; b=MlXwWsufDAV0DjOFx3Juzd1dJUEDL5QcuvA7qSr3N0xKaEK1wfETeGHMxVHJDdDyE8lXsNJkI0En+BbVH0sEf/dIhsQ5UcpYB4aGZhrE/XO+QTIgGWa3jexDm8CeIAdm51kXMoh9ZhmwOr4j98qzJUxzzv04Cn8AGepFQkXOlsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505782; c=relaxed/simple;
	bh=+dxNjWZwyG3m3cqvuwbj0l/9t+XgQgCGtFB3r1FCdQI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ub26DonDeg3ZPwv9DtDhi522OIKR5DLZ8EpjD0/Dfk/69rFSZnc3coQQ6jux7BY0n2wCQ/nfGbLZGBPYRUnpiqWKQB+HxZInvGWJ632NJJHQg7mrFlsvxJRqVKujBVyqvVukJ6gQ22Hz9Mdyu3E2m36kT+bAI1dDiwN7f17UwUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nTr7HNOt; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3df2d0b7c50so50245745ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752505780; x=1753110580; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GZkmyEunIC8PulMHPkw5gRVEvCR20gn2L4yB1DhL5fw=;
        b=nTr7HNOtBx/BYH7KRwADuDEnI42fRLw3yiI7sC/bnappmvFm2Y2DaHrUz7BsEaP3jG
         1Md5F7+aNri91pzIESw1C8mFYT8U5mzLkPjKggXOdyINFbJsfKzrVr8Qj5vD57+EiAN1
         Md6r+sdPMRw9A600fRjb7kX4jAYE9l7EKn4yP7ei855An/y8iAXhmJI11xyjTBd7ZmcX
         d0eZH25UZ93scBhhh+c1JgKUydtyME3LXPfhmWPrve45OXihmZqXeCqF7xKNZyxBW81M
         V3htnN1sMw67NEm7nnui6F9pIes235f1Cydy9AjRrx8N7Tg5/cKreg1epzZXvOXovyC2
         OcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752505780; x=1753110580;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GZkmyEunIC8PulMHPkw5gRVEvCR20gn2L4yB1DhL5fw=;
        b=Y40iPWfBgZDXlRw5+KVrXnYkl5vQd+S6ggiHAW7/GkkfraEkFwoFi/lrtfxq8qmgMP
         GcRpXkrRivXF0LsIB8Ufr4cWUlMFKlJbaGXP+7F0kYEJr/F0C0h0b3ilaQk4yw+G5m6t
         l/fFDiBdwhkOh3zZgSHOhG3uIzlap0uUcPCDBZD2HpMr4ZQaDzB05Hp6Mt5fcRJG66Gi
         9lI9n9GhGQMmg6hrowBDOnNOxFWRJl3cOYdJqJFePaky6sxFhVDzh66cgTJXOjyss4Cq
         GLklcVoMY1Gc4PTRgDeiDj1rxuVc77diGniKk6wz8t7Xni3wyxUq8ZHaugvZAEvmr4IC
         xxbg==
X-Forwarded-Encrypted: i=1; AJvYcCUAP0CCFuhr/Db3gowIqtSSgFxJup0OK3jYHdenkBO6VLqCBr6oDIcEiOEJM/5hppn28T3zAop3TNd3j7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMFxrn0Ov2+u/aP/t7+FYR/+tZmhocXoqEW4TTV/Yqwx7IHhnl
	irKL0xyeGUlmxBbQCO38LqGL4+IEiIqI8QLISIWHmpYp8TkbBQdZU6i6krt5pVIJXdI5q/raVSa
	qVATejXxtQQ==
X-Google-Smtp-Source: AGHT+IFbrHzvnu4/zXYPhqDZiNfeDWowVUBss3+pfKlFBXod19WPIg5vvZ5K2c+Viq2W38Xca+2hy+6vp9Bw
X-Received: from ilkk4.prod.google.com ([2002:a05:6e02:5e84:b0:3e0:50cf:827f])
 (user=jdenose job=prod-delivery.src-stubby-dispatcher) by 2002:a92:ca4f:0:b0:3dd:f4d5:1c1a
 with SMTP id e9e14a558f8ab-3e25429f85emr122743825ab.17.1752505779805; Mon, 14
 Jul 2025 08:09:39 -0700 (PDT)
Date: Mon, 14 Jul 2025 15:09:35 +0000
In-Reply-To: <20250714-support-forcepads-v1-0-71c7c05748c9@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714-support-forcepads-v1-0-71c7c05748c9@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250714-support-forcepads-v1-2-71c7c05748c9@google.com>
Subject: [PATCH 02/11] Input: add FF_HID effect type
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
2.50.0.727.gbf7dc18ff4-goog



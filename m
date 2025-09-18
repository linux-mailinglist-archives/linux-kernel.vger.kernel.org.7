Return-Path: <linux-kernel+bounces-774576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8800AB2B463
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E29DE1B218B9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 23:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB13427FD4F;
	Mon, 18 Aug 2025 23:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MHoVwHmJ"
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E7D27E1DC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 23:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755558644; cv=none; b=mgokomWqXTpXZQ1j7Zi2BdXU5va2jPrNADVmilyLnmgBLzVXSEFUbOtodVfBzvARAL3O+P0I5I3yOr2Md/gQWVoH3eI6B1D75GJ13AHZQZkBmTwi5NA7Fu4bJO2xMKzqWCe5n/qmkQgl6oJRgKXmVioncpeM2b7L+jWD5N5BdIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755558644; c=relaxed/simple;
	bh=Jkdjos4RgOTVipcn+UeTFakdYiYYbNUhS5lMAT2XaQg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G+REGnJmGcYTvzwPUMYIOaXN4RLnNRUO9RTqnR6zCWtG37+azzevLk0rqPj4T3VUJzeUUCFiQb12cotLr+zrdz0uHDJ0vsZRfvwwxtzdKiHT5dXkTfBc9UzvaRkpFiHqwQrpnM/QyXX7MRDmUPyOriaZCwwm7b6KGlAtyt4ei+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MHoVwHmJ; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3e57008a646so149512615ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 16:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755558642; x=1756163442; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=no73ok1TStGeLP/XVd+vdAffNUb1wcTzWByPRFwJ434=;
        b=MHoVwHmJbHFKM94Slb6tZs7CAhlnCEwVE/6q8MN2xVEjOQlDaopsuAATbQLHzTTbWf
         QqsLvVG9877HlT//Fv3RJmLUTfUTYZIsTzbHlcEG6QA77LKrw9cfvVQOuFZziFOHht/u
         RaUsqqdBaM8Ki/Wuue4vxhBNZIcOtzZFY5dOOcYxWek+1kIskjFPIw0W4xzCU9AVyrO0
         sj45fRSlGKE17OLaBpOYx05rQwuw+jTgkj9/3evI3kDYII9Ln5JUmaeALiT8zU1XjNF/
         jJyqYSKipKXU2jI1aQRF3xo8ZnYqg9W7L8/fZz48QrhLxd6WZbwrR+mS0GHN+31B7wfd
         NuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755558642; x=1756163442;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=no73ok1TStGeLP/XVd+vdAffNUb1wcTzWByPRFwJ434=;
        b=v6iiXFAKq6ChpL/nYp++FerJRvMNZFc3wu436/f9z0sD/vpkCNdd2P3jyiPXAh5NgC
         RJxNE4Xv2D58uYYEG2cu7Zu17BHMhaSX0fEhmNJUtCPkoAYmNa9/rWUtNZR6iFg2D55A
         GkvIzjhmRPOIc1iDjsDQ/63+prUXnq8h2Huo8TmwDTNudZAIvqWH7Hog5CusAlv/aOuK
         M/FsftnMSzq69APnZ/2NKk/nn0w/Oig+5sByKgjdrRJiukegNBjr/4nrJUyf9lnIofo2
         m3V/cCxsjms9Ajggf6wSoGJwrnVka4tPazCuUrf+x/aLfoQ+mnRydTPV2Xh7iIxU1DqJ
         ceXg==
X-Forwarded-Encrypted: i=1; AJvYcCXP2ve+Em9iv/VCXjyt8Hs7UMMg17+Jm9YllWE0Y0TDTKLrNZ9rH0Nb2Bob159jMHhqH4qkgMad3+8CK/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwStoAVQnOOD5v9wVxf3mIybYgygKEvwjKzGKuWY83dE/e3nbtP
	G4XGOSgEDTfDud+41kU9VA5SsRONWPeDmIkt/d897oBnI37N0GZu9XtuJtGBVrPiLalyac2fRYC
	7DbescuSRFw==
X-Google-Smtp-Source: AGHT+IHurdh+bNvbqq4rcSts2NvIBgNlA+bfgJ0A1Iz1oYUr7I4W0BYAjz+BOz9KO1SHicln1gt8LPcc/sEJ
X-Received: from jablw11.prod.google.com ([2002:a05:6638:ad0b:b0:501:ed30:8c8e])
 (user=jdenose job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6e02:3a03:b0:3e5:4bc5:538a
 with SMTP id e9e14a558f8ab-3e676640018mr9183085ab.11.1755558642340; Mon, 18
 Aug 2025 16:10:42 -0700 (PDT)
Date: Mon, 18 Aug 2025 23:08:49 +0000
In-Reply-To: <20250818-support-forcepads-v3-0-e4f9ab0add84@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250818-support-forcepads-v3-0-e4f9ab0add84@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250818-support-forcepads-v3-8-e4f9ab0add84@google.com>
Subject: [PATCH v3 08/11] HID: haptic: add functions handling events
From: Jonathan Denose <jdenose@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Angela Czubak <aczubak@google.com>, 
	"Sean O'Brien" <seobrien@google.com>, Jonathan Denose <jdenose@google.com>
Content-Type: text/plain; charset="utf-8"

From: Angela Czubak <aczubak@google.com>

Implement hid_haptic_handle_press_release() which generates haptic feedback
as well as saves the pressed state of the haptic device.
Add functions to increase and reset the state of the pressure detected by
the device.

Signed-off-by: Angela Czubak <aczubak@google.com>
Co-developed-by: Jonathan Denose <jdenose@google.com>
Signed-off-by: Jonathan Denose <jdenose@google.com>
---
 drivers/hid/hid-haptic.c | 20 +++++++++++++++++++-
 drivers/hid/hid-haptic.h | 15 +++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
index ef09b4039f33f15d7220e69fbed10bd8b0362bb4..c02af820051c22d1c899db84496c5a44b868fe49 100644
--- a/drivers/hid/hid-haptic.c
+++ b/drivers/hid/hid-haptic.c
@@ -50,8 +50,13 @@ EXPORT_SYMBOL_GPL(hid_haptic_feature_mapping);
 bool hid_haptic_check_pressure_unit(struct hid_haptic_device *haptic,
 				    struct hid_input *hi, struct hid_field *field)
 {
-	if (field->unit == HID_UNIT_GRAM || field->unit == HID_UNIT_NEWTON)
+	if (field->unit == HID_UNIT_GRAM || field->unit == HID_UNIT_NEWTON) {
+		haptic->force_logical_minimum = field->logical_minimum;
+		haptic->force_physical_minimum = field->physical_minimum;
+		haptic->force_resolution = input_abs_get_res(hi->input,
+							     ABS_MT_PRESSURE);
 		return true;
+	}
 	return false;
 }
 EXPORT_SYMBOL_GPL(hid_haptic_check_pressure_unit);
@@ -508,3 +513,16 @@ int hid_haptic_init(struct hid_device *hdev,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(hid_haptic_init);
+
+void hid_haptic_pressure_reset(struct hid_haptic_device *haptic)
+{
+	haptic->pressure_sum = 0;
+}
+EXPORT_SYMBOL_GPL(hid_haptic_pressure_reset);
+
+void hid_haptic_pressure_increase(struct hid_haptic_device *haptic,
+				 __s32 pressure)
+{
+	haptic->pressure_sum += pressure;
+}
+EXPORT_SYMBOL_GPL(hid_haptic_pressure_increase);
diff --git a/drivers/hid/hid-haptic.h b/drivers/hid/hid-haptic.h
index 25e0e2cef9399199796d8679d66209381b6a59f2..abdd7d710c0b832ad0be8fe63ebfa7692c8ea5ca 100644
--- a/drivers/hid/hid-haptic.h
+++ b/drivers/hid/hid-haptic.h
@@ -70,6 +70,10 @@ int hid_haptic_input_configured(struct hid_device *hdev,
 				struct hid_haptic_device *haptic,
 				struct hid_input *hi);
 int hid_haptic_init(struct hid_device *hdev, struct hid_haptic_device **haptic_ptr);
+void hid_haptic_handle_press_release(struct hid_haptic_device *haptic);
+void hid_haptic_pressure_reset(struct hid_haptic_device *haptic);
+void hid_haptic_pressure_increase(struct hid_haptic_device *haptic,
+				  __s32 pressure);
 #else
 static inline
 void hid_haptic_feature_mapping(struct hid_device *hdev,
@@ -103,4 +107,15 @@ int hid_haptic_init(struct hid_device *hdev, struct hid_haptic_device **haptic_p
 {
 	return 0;
 }
+static inline
+void hid_haptic_handle_press_release(struct hid_haptic_device *haptic)
+{}
+static inline
+void hid_haptic_pressure_reset(struct hid_haptic_device *haptic)
+{}
+static inline
+void hid_haptic_pressure_increase(struct hid_haptic_device *haptic,
+				  __s32 pressure)
+{}
 #endif
+

-- 
2.51.0.rc1.193.gad69d77794-goog



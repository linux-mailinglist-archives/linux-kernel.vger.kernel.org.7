Return-Path: <linux-kernel+bounces-730318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC584B042F7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E88044A2C76
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9162620F5;
	Mon, 14 Jul 2025 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TD4Ez4TW"
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6444C25F96B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505789; cv=none; b=GDZ7rG63o4f67/ssLDQoB6yLGjjBFz4jICO9gTA4+oVPVKDOGzjKFdj/vWYZHjwhzraDBI9TO41b/YoK6oD48GAaohrGcv4pt1Es/PSeH9BnnRJlH3x0lGY1cEP4bWySMfyypKulFbTsRun75kce4oGeSvxrDdG9GIiPqMFdNV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505789; c=relaxed/simple;
	bh=aBLwgLHN44SXrMtvSsPNS/ea4+z3ssj7TR0jIqT7srw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AOcyaN5wM9NdyFLWbLvFKUdZxnLbDDa1D52lWH1MS7R+vgVz6qeNFub5oohJe5yAKlFrgPi1ScpGyFCAZ9Uc5xypYeTphq1brtFsW5emgUKs7cZ4FAEgoDAEj4bkd13aQ9maZP9ANjKT2tNxZ5LFYLu+8RO/1g2jVVFsj47nFn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TD4Ez4TW; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-86cfe68a8bbso312710139f.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752505786; x=1753110586; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FgAgE/U54Vfw8FMo01HLbSRZxI4RE3EOliqkSMOeg7o=;
        b=TD4Ez4TWFKqEQId+6qMkpCbnYc9PRsAo8sUFSEgdqcGlmQOUEKSAziNSkl/gZRNIOi
         QusV6yPu5nawKSaQMOLULlXVz1Q6zq6fT/h3IIeMna+5tZbLx7SyRCIGCluiRdhp7KRE
         0Qu5udTi8Hyti5JZpdydJM7K28epKtf9q1tm0yihn84yuSiLDEAog3c7u95bJT+qsbms
         HTl9Ph8b4m3Ido00Qh7txDGGnNg0jih1nWxXTS/Ws5GKyAEgsoX+9KcdQv4wQjD/cAae
         D+fscI+QgNNHbmtlw1tiZE+VO0BllwsyzNBpg+Aa/GTFe1MSlGfnGFb+mdFhjNGhIGTY
         CQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752505786; x=1753110586;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FgAgE/U54Vfw8FMo01HLbSRZxI4RE3EOliqkSMOeg7o=;
        b=nhv7ViyYQLBjf3ClxuOvrkmf7NYRsSFQOsLdK27VreNwe5hFOjxnjPvhC/tEr/+xBJ
         F9y+DZlOtfooAJ27lwR823I1a76AfrFyuFDrz1BslnR4WQnGw9jUgNnXHsbo8bs+xa81
         F4f/MR3T808cLJS5eDiWmbHQuljUJVnAWSEZXktZHuWWj6eOTDLdtrEB8rUlvYl0FZtL
         7VXcxZ58EZQTfjCjvWdqB3+5+lXT3Bi832Fu1aXr7OIz56dEU/enExzJYmiWpc2b8iyk
         k/Yi831o/rS5M9kebYcJElbaAPkyJ2Y9JyItWr5sljSHcVL9xooBfLrqkKV1VyQsPqR9
         onlA==
X-Forwarded-Encrypted: i=1; AJvYcCXXXhHEUsUbXtrNH3pIneCMg+js6WrGI/rGkzQBnpTwn58V5zPuvWryvIzdLUvhebvdNqtqQRqK6O+JnaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaTjHm6xD4x37FStid41FyL/cqO+cl/MlzFpoVbomn2bUwtMUC
	7V2h3XAWd5uAfFAvnHDNpvJM6qW3I5XfVOy15zkmqmQZtkH/j3cGR7vSt+qbgqmVvh9YPL1MhHl
	0wcOmPOw+HQ==
X-Google-Smtp-Source: AGHT+IEc/wuJWYRSw6yookOyeVU2LGUdFtjrU9b7Z9gz+2dBupfl3JLFSJ1MwP4gdhw8Bp96/AigIB6V5p3e
X-Received: from iovs9.prod.google.com ([2002:a05:6602:2bc9:b0:867:5082:3d56])
 (user=jdenose job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6602:7181:b0:879:652a:ac7
 with SMTP id ca18e2360f4ac-87977fe76b3mr1232192439f.13.1752505786566; Mon, 14
 Jul 2025 08:09:46 -0700 (PDT)
Date: Mon, 14 Jul 2025 15:09:41 +0000
In-Reply-To: <20250714-support-forcepads-v1-0-71c7c05748c9@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714-support-forcepads-v1-0-71c7c05748c9@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250714-support-forcepads-v1-8-71c7c05748c9@google.com>
Subject: [PATCH 08/11] HID: haptic: add functions handling events
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
 drivers/hid/hid-haptic.h |  4 ++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
index 923b685f0e1e81b7f95567b11209af264c522373..760dd1d70583489c07e199943ebba361d347bfa4 100644
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
index 9aa910579d09206a2a882a5f708efd8620428f78..0a34b0c6d706a985630962acc41f7a8eb73cd343 100644
--- a/drivers/hid/hid-haptic.h
+++ b/drivers/hid/hid-haptic.h
@@ -73,3 +73,7 @@ int hid_haptic_input_configured(struct hid_device *hdev,
 				struct hid_haptic_device *haptic,
 				struct hid_input *hi);
 int hid_haptic_init(struct hid_device *hdev, struct hid_haptic_device **haptic_ptr);
+void hid_haptic_handle_press_release(struct hid_haptic_device *haptic);
+void hid_haptic_pressure_reset(struct hid_haptic_device *haptic);
+void hid_haptic_pressure_increase(struct hid_haptic_device *haptic,
+				  __s32 pressure);

-- 
2.50.0.727.gbf7dc18ff4-goog



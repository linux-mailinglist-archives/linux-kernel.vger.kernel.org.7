Return-Path: <linux-kernel+bounces-864871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D45BFBBE2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDDF3587ED5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E1430FF25;
	Wed, 22 Oct 2025 11:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F2rQv7FQ"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E436733F8DE
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761134121; cv=none; b=NPsXDpIhgs4poBGIAfqN0r35LiqNGdR+eTblfiC450F19x7xBxvaF4SQQ+e12EZn70/PWN2PQBE3hUP1tZAyje0dr834fQMpSllaGn9NEA369EXnWnRXUOkSCCXZQk4UYVnyAJYjyORldikpcadFExMLrMGfsFt+PWUYq1sLdxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761134121; c=relaxed/simple;
	bh=4xFArIFBCi/38kZpFjNp/HhrvCNOBQ0dVzcCEAHfOLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hovNOWmyGoWogm1CIXabf1OxDzLqGyOz7YALTlZqNcxJqikO0jponz6P30UyVMq1rrb4YMWMScyvc6TfaMz2MiUejGKiatezNNIYyDCmnLeBBgSSY6dJO4PCaa1Lp/GzwEl9lC/feHNfygp9rzbLFHvTzJ3jFIq93y0u+1tRe74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=F2rQv7FQ; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-36453927ffaso59635591fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761134118; x=1761738918; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jYH9KKHjk03g5K9Bm9ckGVdfxUSlGQea/izXLcw9vU4=;
        b=F2rQv7FQmM3aEHkTOX/AMdiegHD/zocFpZc+7D0mIKep01SNf2pCPZ33yUP+TfrWXe
         Et0oWvq3pFPn6LIySn5gZRNK1qnZlNYnPGqqOZ7obYeCO3AVAzv1HyMPTQTMUltH9YEj
         /DBYYBgNuDcs4UbV4mLg+OkKOzKX5IdsEyFgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761134118; x=1761738918;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jYH9KKHjk03g5K9Bm9ckGVdfxUSlGQea/izXLcw9vU4=;
        b=Yydu+hSr6Lq+PK1d9XLqnt2oeoUUyc8kzYlvTCKf8Ode/p2Xl6bexRZlFZmGWbE44R
         jjcjw49iHCTigqj+N/hzVQwkJ32kBTccPEmBInakUL7KuL6V63cSJNSC8Ou19kjEi41j
         iTDZ+trNmcQDulF9rJ55SBOckI8zCOoxQwa+/hh7SAR/zTzT/ph3Gv+84OdQuhN1trnA
         zmCC7fwSn4V/2bq3Lypr7SYlOYbI3y4+TXBwDwoGnefoVhGAO5FqwuSM9/rVLz3gyHkT
         gfiKsLSAeX9lNfcHPnp3ZhvAVVtO6PCzCCPGsFvYLkuEtsj9KgUZQFleKGrT/gEKxgyS
         8zkA==
X-Forwarded-Encrypted: i=1; AJvYcCVXu5WRGnsnkTXeY6KaOdM3UX7mxZWCY+NgfyaFDuX9dDIrAzho9shyNp98hSMumAYYwhNs+oWxJP7vCdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyptkXzXtpPwFtbkrwYq2K5xH4z7A+UAhYzHcypfintmaRmpq7
	i2ayHsrI7AkB1rFv0xTKbjmn4E+xTRJlPYl8idJQJ3fzgwC9grNYMqyVANJeI98dIrpwyu7wxsJ
	hZN8=
X-Gm-Gg: ASbGncva65cY2CZZx7fmtXXO33XhmMI7cJsAemcvo6Ngsnc5FVxm8Ih/5eicRmR2/vE
	9x2gEwzqh6Q4OYhVfX3QjB0SSHweNu0i2wRVKdvXLxFF19QmI8UEJNWbn+NM8RSi2U4nHsrIbke
	gByK7uGKKWI6Ff4VqUOCvC7QFXalqXAzhbQyUuaYjFEh5FCS2uJvhS+jvBx3GcF2E/vU0FJwv8l
	Pz7fZk7t0WeV8ZbagFB3PWeIILMkdwJb3ju6kAEpdvg8rd8wLleVWYhdxB9OjdKoBzgp46+aJDz
	S9w+ovh2TgsChFOfNATYky1NbReupU+QGlgHun1xmUBoB+WSxHDSyrF7Qdw0plML5wogery04yB
	c50EAO/LBCqHy71saZQlfkqpqUv56ihpip1g5t+3fSm93Kl5LbJ2dvmTcYXoAZwHYv9O5X+Urvu
	A8d2Jp1y9d9BSGBsj98u74kR5ydruHgjF4rdLK2RZyP+jzV+9At5/On5A=
X-Google-Smtp-Source: AGHT+IFstmSy3ZG7G9hzOLBQ33LR5gBe2+Ou9QgkLX9i4b8zh/4XZITZ7ccSGENfX9u9ghW1D5Ivuw==
X-Received: by 2002:a2e:a543:0:b0:377:887f:2ea with SMTP id 38308e7fff4ca-37797a56696mr63663261fa.32.1761134117880;
        Wed, 22 Oct 2025 04:55:17 -0700 (PDT)
Received: from ribalda.c.googlers.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377cd7f1e7dsm13689061fa.14.2025.10.22.04.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 04:55:17 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 22 Oct 2025 11:55:16 +0000
Subject: [PATCH] media: uvcvideo: Create a specific id namespace for output
 entities
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-uvc-grandstream-laurent-v1-1-0925738a3484@chromium.org>
X-B4-Tracking: v=1; b=H4sIACPG+GgC/x3MwQpAQBCA4VfRnE2tlcKryGHWDqZYmkVK3t3m+
 B3+/4HIKhyhzR5QviTKFhKKPINhpjAxik8Ga2xVGGvxvAaclIKPhzKtuNCpHA4sx4acq8n4ykG
 qd+VR7v/c9e/7AZa1IY5pAAAA
X-Change-ID: 20251022-uvc-grandstream-laurent-3f9abb8a0d5b
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.2

Nothing can be connected from an output entity. Which means that no
other entity can reference an output entity as baSourceId.

Use this fact to move all the output entities to a different namespace
id.

The output entities are usually named after the dev_name() of the usb
device, so there should not be any uAPI change from this change.

Although with this change we can handle some id collisions
automagically, change the logic of uvc_alloc_new_entity() to keep
showing a warning when a camera has invalid descriptors. Hopefully this
message will help vendors fix their invalid descriptors.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Hi, this patch fixes support for some devices with invalid USB
descriptor.

It is orthogonal to:
https://lore.kernel.org/linux-media/20251021184213.GC19043@pendragon.ideasonboard.com/T/#t

Some devices will be fixed by the other patch, other devices will be
fixed by this. In my opinion is worth to land both patches.

Tested with GRANDSTREAM GUV3100 in a 6.6 kernel.
---
 drivers/media/usb/uvc/uvc_driver.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index fb6afb8e84f00961f86fd8f840fba48d706d7a9a..40f8ae0df89e104992f5d55af3d3539dea3d146e 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -165,10 +165,14 @@ static struct uvc_entity *uvc_entity_by_reference(struct uvc_device *dev,
 	return NULL;
 }
 
+#define ENTITY_HARDWARE_ID(id) ((id) & ~UVC_TERM_OUTPUT)
+
 static struct uvc_streaming *uvc_stream_by_id(struct uvc_device *dev, int id)
 {
 	struct uvc_streaming *stream;
 
+	id = ENTITY_HARDWARE_ID(id);
+
 	list_for_each_entry(stream, &dev->streams, list) {
 		if (stream->header.bTerminalLink == id)
 			return stream;
@@ -810,10 +814,12 @@ static struct uvc_entity *uvc_alloc_new_entity(struct uvc_device *dev, u16 type,
 	}
 
 	/* Per UVC 1.1+ spec 3.7.2, the ID is unique. */
-	if (uvc_entity_by_id(dev, id)) {
-		dev_err(&dev->intf->dev, "Found multiple Units with ID %u\n", id);
+	if (uvc_entity_by_id(dev, ENTITY_HARDWARE_ID(id)))
+		dev_err(&dev->intf->dev, "Found multiple Units with ID %u\n",
+			ENTITY_HARDWARE_ID(id));
+
+	if (uvc_entity_by_id(dev, id))
 		id = UVC_INVALID_ENTITY_ID;
-	}
 
 	extra_size = roundup(extra_size, sizeof(*entity->pads));
 	if (num_pads)
@@ -969,6 +975,7 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
 	struct usb_host_interface *alts = dev->intf->cur_altsetting;
 	unsigned int i, n, p, len;
 	const char *type_name;
+	unsigned int id;
 	u16 type;
 
 	switch (buffer[2]) {
@@ -1107,8 +1114,16 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
 			return 0;
 		}
 
+		/*
+		 * Nothing can be connected from an output terminal. To avoid
+		 * entity-id's collisions in devices with invalid USB
+		 * descriptors, move the output terminal id to its own
+		 * namespace.
+		 */
+		id = buffer[3] | UVC_TERM_OUTPUT;
+
 		term = uvc_alloc_new_entity(dev, type | UVC_TERM_OUTPUT,
-					    buffer[3], 1, 0);
+					    id, 1, 0);
 		if (IS_ERR(term))
 			return PTR_ERR(term);
 

---
base-commit: ea299a2164262ff787c9d33f46049acccd120672
change-id: 20251022-uvc-grandstream-laurent-3f9abb8a0d5b

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>



Return-Path: <linux-kernel+bounces-865065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A98FABFC113
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 16D14357A08
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAAF26ED3C;
	Wed, 22 Oct 2025 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JbhvZV2r"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37D226ED2F
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761138735; cv=none; b=YNXcpdiDHPkI8jWQWfOdWcKtPIAXCApyPfVDNg5MXC/CJqu4c/tMliFHzeyWE424b+r4kDgxjZcL21D78FAO2KzwMMkxSZ9Q5PtcJlzTXaaByZtqhab0/uVSDm4TQ8N7C/2FOz+wa/+QXo79872+pD2LEreJCgS8bwwgIJuRp8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761138735; c=relaxed/simple;
	bh=6DxOLfAzPPsBmyRcHM8iKfOewx4AILSlI/DLm6yFybk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Y62ceMvdOU6zkAqA+vtg4l5UNg7ZQuDYRYM5JpNxhtRwD5Yq6b4iPw3mF1wKLfOz+mrVCWjVuNaIxy9uNThLl25SnM61pJKM8WXvZsZwNG0y7W2jsjpgYva3Scz+XmOxjnr/N5ABpA3hdvbbCW2xD+QqcsFJd4aiSrWvJg9pYwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JbhvZV2r; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-591c98ebe90so7464055e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761138731; x=1761743531; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mfz/6BvNBJR1eZRp7K9b46D4SU+moxLeIZ/fEtZM5T8=;
        b=JbhvZV2rxDP03QwAgZHTr6gHK8epQ9CCE1v8KtBNtiUpDiNVouhrMULkQXWPGcrclN
         AsMzd57wXBH7fK2ngvGDRW87mVAke5aIk2AYmPgtGHGrCNsBw6fc7/7heiy5BSKTf296
         VG6r+SU/5W4NS1WUUHs5EBVC7V+U0mLUtf7tE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761138731; x=1761743531;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mfz/6BvNBJR1eZRp7K9b46D4SU+moxLeIZ/fEtZM5T8=;
        b=ojcMwfPLogYkHib8JX7A9Cu3yRjny6ILchEq3T+rbIl6gCIqJ/2nwujyeaPmpxkPyh
         /Ym2/vIBlj562n3fOT4L4wiSxbGVBJdAwKhEwZCF2FdC9V4Nq9movxaRG/f6RX268H6+
         jR3U833IsAAX2whye5xKXz215gjgvnMptEho9yQBw7gZeqJTBipQCjNCTC3V3DAHTtEr
         VfWe8PHksiy6MavOq6OzbTLAZOd23svFkx7LeTK7I+gDg4dIuKevPs2HkbMYTp7OH5Pt
         9FfOx3I2ceG0fM86M1seEqBtreu9jsRiim+0TpN575TU8FdVFLNEKYi9l8b3TX+OJR6L
         6msA==
X-Forwarded-Encrypted: i=1; AJvYcCUHgECswVYuQmOkEZ8nZ2T2Fd6U07l23ZgOfhneSSW1YJqB2BpJwWUotL+WYqeAzDWC8dg6EgtRq0Ds0+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy7fLEVZsgyksp4nqEbRcBsdAbFuzvZuz6Q7a0fQumetHnAPYh
	ckXXmBw4JLIUryeUwCqrCt1i89qz+oudrTXUujIppjfHiPrklh1ajXxcLc/HdkJ/DA==
X-Gm-Gg: ASbGncs2oDcbq/cWwY4XZQ6S91NaweM1gT/zMysHYNPzx8d4R06qnmTeSaOid6/SZpT
	uzfNoij3oq4YxZQ6MXeqzXX5xCs3338jyigIo0KbOzmRoJsSd6tTf5J+1oKx/7I4DdU9rvannWS
	271N4U1l848r0WsGDk9t6jdq68nbeRXwhIcpey3QB0SC45Oq750sCgxANplfMMDBE9wUlTO1ozO
	Q6mQFdjwp5Kq3eqUZtjVBmAl42b2OVKRBy0iI4hqWJ1t+55S4ZJahKZRN86FQkRg14BEnfEclS8
	xLIdjGIAx+xzu2jMaeQdLO2AZpIwoZofjXn+wFKu4073CMM0a9460SycMADj82ST6rXdcqWQ6+A
	Dx9FCsw46RqLo4Qw5IHTm33yxo84dhNrphVbWpEMa7nTgyx4TWro3Q4EZLqgZmJCCHikcBYCZKS
	ko9urVTJd6lfjlvzfSXGgcqGkq0riE6U8sW4PtFB07FSfPn4c3/yWJDjc=
X-Google-Smtp-Source: AGHT+IEzcc4qnSpWFPHmnPditQkmeA/SeX5wXg5AO3Ra9CrcWTNxZve0pghy3Q94ewLjUi8notZXwA==
X-Received: by 2002:a05:6512:1153:b0:55c:c971:2250 with SMTP id 2adb3069b0e04-591d8577661mr6478139e87.28.1761138730666;
        Wed, 22 Oct 2025 06:12:10 -0700 (PDT)
Received: from ribalda.c.googlers.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591def16a23sm4670651e87.67.2025.10.22.06.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 06:12:10 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 22 Oct 2025 13:12:09 +0000
Subject: [PATCH v2] media: uvcvideo: Create a specific id namespace for
 output entities
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-uvc-grandstream-laurent-v2-1-8c5c20d6c571@chromium.org>
X-B4-Tracking: v=1; b=H4sIACjY+GgC/4WNQQ6CMBBFr0Jm7Zi2QARX3sOwKDDAJNKSKTQaw
 t2tXMDle8l/f4dAwhTgnu0gFDmwdwnMJYNusm4k5D4xGGVKrYzBLXY4inV9WIXsjC+7CbkV86G
 2bVtZ1ZctpPUiNPD7LD+bxBOH1cvnPIr6Z/83o0aNqjblLa9sXlTFo5vEz7zNVy8jNMdxfAG0M
 u8MwQAAAA==
X-Change-ID: 20251022-uvc-grandstream-laurent-3f9abb8a0d5b
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.2

Nothing can be connected to an output terminal. Which means that no
other entity can reference an output terminal as baSourceId.

Use this fact to move all the output streaming entities, which have no
controls, to a different namespace.

The output entities are usually named after the dev_name() of the usb
device, so there should not be any uAPI change from this change.

Although with this change we can handle some id collisions
automagically, change the logic of uvc_alloc_new_entity() to keep
showing a warning when a camera has invalid descriptors. Hopefully this
message will help vendors fix their invalid descriptors.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
Changes in v2:
- Change Macro name
- Apply quirk only to TT_STEAMING
- Add missing suggested by
- uvc_stream_for_terminal
- Note, v2 has not been tested yet in real hardware, only v1.
- Link to v1: https://lore.kernel.org/r/20251022-uvc-grandstream-laurent-v1-1-0925738a3484@chromium.org
---
 drivers/media/usb/uvc/uvc_driver.c | 31 ++++++++++++++++++++++++-------
 drivers/media/usb/uvc/uvcvideo.h   |  3 ++-
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index fb6afb8e84f00961f86fd8f840fba48d706d7a9a..c0a2c05b0f13a8c3b14018c47dfb0be2614340ce 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -165,8 +165,10 @@ static struct uvc_entity *uvc_entity_by_reference(struct uvc_device *dev,
 	return NULL;
 }
 
-static struct uvc_streaming *uvc_stream_by_id(struct uvc_device *dev, int id)
+static struct uvc_streaming *uvc_stream_for_terminal(struct uvc_device *dev,
+						     struct uvc_entity *term)
 {
+	u16 id = UVC_HARDWARE_ENTITY_ID(term->id);
 	struct uvc_streaming *stream;
 
 	list_for_each_entry(stream, &dev->streams, list) {
@@ -810,10 +812,12 @@ static struct uvc_entity *uvc_alloc_new_entity(struct uvc_device *dev, u16 type,
 	}
 
 	/* Per UVC 1.1+ spec 3.7.2, the ID is unique. */
-	if (uvc_entity_by_id(dev, id)) {
-		dev_err(&dev->intf->dev, "Found multiple Units with ID %u\n", id);
+	if (uvc_entity_by_id(dev, UVC_HARDWARE_ENTITY_ID(id)))
+		dev_err(&dev->intf->dev, "Found multiple Units with ID %u\n",
+			UVC_HARDWARE_ENTITY_ID(id));
+
+	if (uvc_entity_by_id(dev, id))
 		id = UVC_INVALID_ENTITY_ID;
-	}
 
 	extra_size = roundup(extra_size, sizeof(*entity->pads));
 	if (num_pads)
@@ -969,6 +973,7 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
 	struct usb_host_interface *alts = dev->intf->cur_altsetting;
 	unsigned int i, n, p, len;
 	const char *type_name;
+	unsigned int id;
 	u16 type;
 
 	switch (buffer[2]) {
@@ -1107,8 +1112,20 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
 			return 0;
 		}
 
+		id = buffer[3];
+
+		/*
+		 * Nothing can be connected to an output terminal. To avoid
+		 * entity-id's collisions in devices with invalid USB
+		 * descriptors, move the output terminal id to its own
+		 * namespace. Do this only for UVC_TT_STREAMING entities, to
+		 * avoid changing the id of terminals with controls.
+		 */
+		if (type & UVC_TT_STREAMING)
+			id |= UVC_TERM_OUTPUT;
+
 		term = uvc_alloc_new_entity(dev, type | UVC_TERM_OUTPUT,
-					    buffer[3], 1, 0);
+					    id, 1, 0);
 		if (IS_ERR(term))
 			return PTR_ERR(term);
 
@@ -2105,8 +2122,8 @@ static int uvc_register_terms(struct uvc_device *dev,
 		if (UVC_ENTITY_TYPE(term) != UVC_TT_STREAMING)
 			continue;
 
-		stream = uvc_stream_by_id(dev, term->id);
-		if (stream == NULL) {
+		stream = uvc_stream_for_terminal(dev, term);
+		if (!stream) {
 			dev_info(&dev->intf->dev,
 				 "No streaming interface found for terminal %u.",
 				 term->id);
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index ed7bad31f75ca474c1037d666d5310c78dd764df..3f2e832025e712585edc324afa6cad760d4edafc 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -41,7 +41,8 @@
 #define UVC_EXT_GPIO_UNIT		0x7ffe
 #define UVC_EXT_GPIO_UNIT_ID		0x100
 
-#define UVC_INVALID_ENTITY_ID          0xffff
+#define UVC_HARDWARE_ENTITY_ID(id)	((id) & 0xff)
+#define UVC_INVALID_ENTITY_ID		0xffff
 
 /* ------------------------------------------------------------------------
  * Driver specific constants.

---
base-commit: ea299a2164262ff787c9d33f46049acccd120672
change-id: 20251022-uvc-grandstream-laurent-3f9abb8a0d5b

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>



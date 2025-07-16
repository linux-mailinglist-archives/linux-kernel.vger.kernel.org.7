Return-Path: <linux-kernel+bounces-733375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E63EAB073C7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3699258187B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BE52F3C2C;
	Wed, 16 Jul 2025 10:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UfaUfV24"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D667C2F3C20
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752662630; cv=none; b=CiWVaI4QMHkGM4hbOGH/YfQyybEm3bus6Soq/HYdJTcXPSvOC+WQFV/Ejvm4eJX93IkPXxPbUkfgJMeUACT0+ohREiEl4Y2+rcdhSbwVkaSFJYJbhssGweuvn3YG75NF2Jtzs0fmBHD81wVqnHnr6nhqWZ0UKnvd5DfhqLeCubQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752662630; c=relaxed/simple;
	bh=3uXgPR8RTlTbUm5MOy2Rb536PMRnqB2zCJVH0mSOKbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uIj0m9YLL2e0YY0DIqDvLsCTSTtpSEtTYNomGoWkyjv+v06dJl4JprXhBhzUCbZR4Pi2+rkNXuWdj9R5eCnj4BTLD4EFcElpEJ2BVUrCI0sFHNoJAjCz8ut9YCeeM/aiXqvR/3w5rvK8XUCf7dayKB1C2xg6d9HvxK35jQxL1hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UfaUfV24; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-32b3a3a8201so57075751fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752662627; x=1753267427; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bob/WV7qOeJklj8uEadWB6S24Kn3tH4K6MypgV+1RNA=;
        b=UfaUfV24+ZqGy9gwM2PTIklfscQRBvz0qdmAdzXbrlgux/1xZ6Z0fFCa/E5ZbHr/xR
         8cUoZ0u1T8ch3O5q0K6SK903u+/wZOl5lPajDDOpc0og3osoVI8Sejg3UMrCHpZYbs8Z
         spmrI8Ccu2LPm7HFK90G0ok8BgsUsul8CGH2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752662627; x=1753267427;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bob/WV7qOeJklj8uEadWB6S24Kn3tH4K6MypgV+1RNA=;
        b=N2jejy5XDLOvBh+eM4j6DAaIDELidT7aGH07IyE3Vr3EGcx4ZL8bgwD7ITyhiCz4Ft
         2+sEl+iJ2i2/p9jrpmQiPlUnG7uUvwg2vj8b5zlbAEyaJBdupyqAlut6NJ5Nbp5pD8lV
         VH5H5Up4fHoOLmY9hlHDCkN9QmsxK38IW6zpyw08vvGQrTV3t5P7W6WuC0Kmh89eAJhB
         PvgfaAB65h2VVLi7XiMESwNeNWuM0PZyYiJyLXTCMPLuZMyODvYnaLYxD2ybcPwkLnpU
         KA8PLSsIco3ZJDQdnO9K+2tJLTA4Yxr5UewJwwglwIrQCsHXbJK0LfZBFn7M/d7zFYOL
         gnxg==
X-Forwarded-Encrypted: i=1; AJvYcCXha0hSgC3NgpHmvWnXc15re4mOXZGbEwiVsmDGF7Nbm7s1JnhdHCU0khGMR0oxdvbZDUPCVTIx3AAVXag=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrHljms47ji479Dfm3Zz9F/Ktk5hoRWpQaQ7Wh3RDDZLKFGMcH
	1xYLzGuz9DLY/UGF4YEoLVKcxe7KOXUSKS3PGIq+o+HIu+JaHnIoYb7zwJ2bSxB8Rg==
X-Gm-Gg: ASbGncu+Z/buwE+8sltv4VF0uyMOjcXiaOHIsb8YiTQHAbxMBJmIlw7bbVxTprzqNm3
	bDIHGbtN1YU7HbsVNpvPOHx2LwaDbm6vyhD5BwQfGhuo9W8u70yOzSw0WpjLCQQuhx81GhJZxxe
	Kuz7/6qWmoZQDYEz05ky4TVuhqyP/aG/W9Lg3rigW8wj5vLjyb6rSTCYzErOKXsdWrdIgnQmvKm
	HXNf1OO45BCHM3Ni/Cq0dPI/LNAlDXBtOXpBokcyBJI6oHGLRYRE8mZD92miYgUJm4yfwG0Ad/O
	AJu1uuKdodkj3FK4SE7anf1hHlbaU5aewC+Ffaf1VOQdyEXEydmhQ5PQDuenRi6esifzGf+94hA
	p3fsP/PGWIk5C2kXoCxH8wz4CgBeZNWydjkh10n96LX9F4p5j9Q0iKSnDY5Lrw9idVQHdxUsuob
	A73g==
X-Google-Smtp-Source: AGHT+IHZa5XbsCIjQ9PIjg1rBEBHdvI5f0YD5wHon1NOVE1OsS2yyGLjUyuWnEQInDvv/oIe8YzWkQ==
X-Received: by 2002:a05:651c:e0b:b0:32b:76fe:134e with SMTP id 38308e7fff4ca-3308f5e2b16mr4845231fa.23.1752662626984;
        Wed, 16 Jul 2025 03:43:46 -0700 (PDT)
Received: from ribalda.c.googlers.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fab912336sm20712161fa.99.2025.07.16.03.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 03:43:46 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 16 Jul 2025 10:43:44 +0000
Subject: [PATCH v2] media: uvcvideo: Fix comments in uvc_meta_detect_msxu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-uvc-meta-followup-v2-1-d3c2b995af3d@chromium.org>
X-B4-Tracking: v=1; b=H4sIAF+Cd2gC/32NQQ6CMBBFr0Jm7RjaCBhX3oOwgGEKkwAlLa0aw
 t2tHMDle8l/fwfPTtjDI9vBcRQvdkmgLxnQ2C4Do/SJQee6yCt1wxAJZ95aNHaa7CusqIi6ku9
 sSHeQdqtjI++zWTeJR/GbdZ/zIqqf/VeLChWWVdfrnvKCjX7S6OwsYb5aN0BzHMcXioE3OLUAA
 AA=
X-Change-ID: 20250714-uvc-meta-followup-1ccb6e8efc2b
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.2

The comments can be more precise. Let's fix them.

Fixes: 6cb786f040ad ("media: uvcvideo: Auto-set UVC_QUIRK_MSXU_META")
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
This series fixes the uvc metadata series landed in:
https://patchwork.linuxtv.org/project/linux-media/patch/998c5fb0-8d32-496c-a1e2-cc9c1a73ede0@kernel.org/

There is no need to Cc: stable, because the series have not landed in
any stable kernel.
---
Changes in v2:
- Improve comment even more... Thanks Laurent
- Link to v1: https://lore.kernel.org/r/20250714-uvc-meta-followup-v1-1-67bd2dc05ef2@chromium.org
---
 drivers/media/usb/uvc/uvc_metadata.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_metadata.c b/drivers/media/usb/uvc/uvc_metadata.c
index 229e08ff323eed9129d835b24ea2e8085bb713b8..2eea543b0575598279d7537ea767ca521b6431c0 100644
--- a/drivers/media/usb/uvc/uvc_metadata.c
+++ b/drivers/media/usb/uvc/uvc_metadata.c
@@ -196,7 +196,10 @@ static int uvc_meta_detect_msxu(struct uvc_device *dev)
 	if (!data)
 		return -ENOMEM;
 
-	/* Check if the metadata is already enabled. */
+	/*
+	 * Check if the metadata is already enabled, or if the device always
+	 * returns metadata.
+	 */
 	ret = uvc_query_ctrl(dev, UVC_GET_CUR, entity->id, dev->intfnum,
 			     MSXU_CONTROL_METADATA, data, sizeof(*data));
 	if (ret)
@@ -208,9 +211,11 @@ static int uvc_meta_detect_msxu(struct uvc_device *dev)
 	}
 
 	/*
-	 * We have seen devices that require 1 to enable the metadata, others
-	 * requiring a value != 1 and others requiring a value >1. Luckily for
-	 * us, the value from GET_MAX seems to work all the time.
+	 * Set the value of MSXU_CONTROL_METADATA to the value reported by
+	 * GET_MAX to enable production of MSXU metadata. The GET_MAX request
+	 * reports the maximum size of the metadata, if its value is 0 then MSXU
+	 * metadata is not supported. For more information, see
+	 * https://learn.microsoft.com/en-us/windows-hardware/drivers/stream/uvc-extensions-1-5#2229-metadata-control
 	 */
 	ret = uvc_query_ctrl(dev, UVC_GET_MAX, entity->id, dev->intfnum,
 			     MSXU_CONTROL_METADATA, data, sizeof(*data));

---
base-commit: d968e50b5c26642754492dea23cbd3592bde62d8
change-id: 20250714-uvc-meta-followup-1ccb6e8efc2b

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>



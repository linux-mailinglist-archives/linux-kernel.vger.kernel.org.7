Return-Path: <linux-kernel+bounces-587903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADD7A7B187
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 23:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CDD8164D47
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 21:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6371F1FCFD8;
	Thu,  3 Apr 2025 21:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CuCqjzWC"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6CE1FBC89
	for <linux-kernel@vger.kernel.org>; Thu,  3 Apr 2025 21:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743715894; cv=none; b=c3ZeKO9sUosXdNoKY6knzfy5fDYp8SadKRJqoFi1HWOEYKQFcgbq4iEmiEnEGJe+jld2mVkO2zF1vHKQREsOHhpoEfFhYUic56BCqkFNJAedu4UOKjoDY+chX5t5uyCcODPuZV+fw7cfXUp1srnOn576htvezIBiPDujK5hCcJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743715894; c=relaxed/simple;
	bh=86KyjaRAGjjTKuXy7mDWoRbScnGEMhFa4ax77t2ho8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=akjHZZW3MO3XxJfVOcnxtOuQKZGVq1eTS2bmCxtyLkssMai25t5kTLZ0cPi5RmE8D7YdnvMak/zXrDPkbZ+OKiW/urNc3d+sT8gZfq7qBR5yhzVcDd/CXwaiWNmnVccBdT80kcywVjZESgqSIqKnN1TXS3PQj0aL9neiQoqr5Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CuCqjzWC; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-549967c72bcso1562803e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Apr 2025 14:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1743715890; x=1744320690; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6MGj5UpsHm+GZxbdk2LCox0kgO/5V4KNTxUQIcaSNWI=;
        b=CuCqjzWCUUFg689ZDk/rYO9TSCNpC11Pa450I6E57Lf/EMh/KrdrJOHzAxOBxnbdjr
         Av/pRkRBwqLhV9RJ1fWM0n/kUee7jC7TFUXg9TiHBVJd0VwMKa1kMw1IMGKSwFGH4Kc8
         QqulYh2cd+z5ID6mOu+slFL2KAfNscL+ykL3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743715890; x=1744320690;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MGj5UpsHm+GZxbdk2LCox0kgO/5V4KNTxUQIcaSNWI=;
        b=RIpjxbdgg9wVNsPmAsc64CweejlwFFPMdd/Szp7T/HKeSR8z525jLcxFi1BQrpyvP/
         M9JdZubaR0/CXKVepD0fKRj8Sb2+PDvSwBfSmUO1j/1et+VTR/AnWV25hjLJBzmZqAGz
         8X75A97/pf8wCplXQgv2WT4aUS9LYrlFVsfPanKCPjqzyzAJttgrfkLsAVTMa1KaVA7Z
         4WH0aRccQhOWJmukiQcG5UVsaUXzbvnQ6Mgdr7OnoJrUH9rAiFKJzDkovvCN6JsfE5U6
         TfRmshDKr+l4l8kNI5xZ9DeMzFRPopWtup3ihqEPMSXtDBUPWttLWJUliwoo2Y86vkVd
         3gFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXitvnm9PfFdtXl2Y0aJwA0twTzHAqoJwHzdU+rshYHHuWowQx5EcVCgQreFZdqzW4dskLrnZEH+OQL5bQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp0hVcLH6k2JwqhRlSI185DKF+1y3jT51fCRJ3FiAlzF+dfKNy
	CuAni2YqGbrOhqsW6U+imgyKw4ZXF/ImCttR677YnCxf1Q+Q27cotQnnKfd5K/1QeEha0sQ4sXg
	=
X-Gm-Gg: ASbGncvWuRdTxFTXLUNHqry/Atg3tZ+h/GuSud8OkMEsbzl1DEot/GEz/QoPJ4xJO7h
	Knz/y8Yr5j+xAYURVkfG94GHSk6NmwlXYIjPJEazkiV/ZP8QgheXD7wJ2jI6CB+ZoH9Gl/1JoIy
	fXC+wbybTSiUVDz+5DjvsC5VBrktKRtwIs3zGz08gvewDyxi8hofVKrm49JawJ6/cI3Kp3KPwWa
	Z9VN25RoFeGcQ5iWZmWFfm9ee+HApWr8+9koY09T/QwNbzLu21fXAK6lqPgGNmaH0O6+zakSic+
	wu44h3L/KRb33uLm1dUWUKO6PuBc6GSpSJW4Y7L9jx5hmBMjNwdeC5SsQjCUa6yLDXWOnzlyzAU
	usgHq0J1YjXx6P9AQ/GQyWgKh
X-Google-Smtp-Source: AGHT+IHTbGg1GaWfCnPg2ymof4WQjtefKbcIM/OyDImt2UtLGpbIf8+qPYBSCQ/kBkFjcmGNx4MtWQ==
X-Received: by 2002:a05:6512:68c:b0:549:31e4:9ea with SMTP id 2adb3069b0e04-54c2338b38cmr46045e87.52.1743715890371;
        Thu, 03 Apr 2025 14:31:30 -0700 (PDT)
Received: from ribalda.c.googlers.com (216.148.88.34.bc.googleusercontent.com. [34.88.148.216])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c1e65d6d5sm252938e87.181.2025.04.03.14.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 14:31:29 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 03 Apr 2025 21:31:27 +0000
Subject: [PATCH v4 4/4] media: uvcvideo: Auto-set UVC_QUIRK_MSXU_META
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-uvc-meta-v4-4-877aa6475975@chromium.org>
References: <20250403-uvc-meta-v4-0-877aa6475975@chromium.org>
In-Reply-To: <20250403-uvc-meta-v4-0-877aa6475975@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.2

If the camera supports the MSXU_CONTROL_METADATA control, auto set the
MSXU_META quirk.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_metadata.c | 53 ++++++++++++++++++++++++++++++++++++
 include/linux/usb/uvc.h              |  3 ++
 2 files changed, 56 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_metadata.c b/drivers/media/usb/uvc/uvc_metadata.c
index fe2678fc795d7fd5a64e8113199012f34c419176..fb3fc75a0af20c471b87f459593418d3ac021193 100644
--- a/drivers/media/usb/uvc/uvc_metadata.c
+++ b/drivers/media/usb/uvc/uvc_metadata.c
@@ -10,6 +10,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/usb.h>
+#include <linux/usb/uvc.h>
 #include <linux/videodev2.h>
 
 #include <media/v4l2-ioctl.h>
@@ -187,11 +188,63 @@ static const struct v4l2_file_operations uvc_meta_fops = {
 	.mmap = vb2_fop_mmap,
 };
 
+#define MSXU_CONTROL_METADATA 0x9
+static int uvc_enable_msxu(struct uvc_device *dev)
+{
+	static const u8 uvc_msxu_guid[16] = UVC_GUID_MSXU_1_5;
+	u32 *data __free(kfree) = NULL;
+	struct uvc_entity *entity;
+
+	list_for_each_entry(entity, &dev->entities, list) {
+		int ret;
+
+		if (memcmp(entity->guid, uvc_msxu_guid, sizeof(entity->guid)))
+			continue;
+
+		if (!data)
+			data = kmalloc(sizeof(*data), GFP_KERNEL);
+		if (!data)
+			return -ENOMEM;
+
+		ret = uvc_query_ctrl(dev, UVC_GET_CUR, entity->id,
+				     dev->intfnum, MSXU_CONTROL_METADATA,
+				     data, sizeof(*data));
+		if (ret)
+			continue;
+
+		if (*data) {
+			dev->quirks |= UVC_QUIRK_MSXU_META;
+			return 0;
+		}
+
+		ret = uvc_query_ctrl(dev, UVC_GET_MAX, entity->id,
+				     dev->intfnum, MSXU_CONTROL_METADATA,
+				     data, sizeof(*data));
+		if (ret || !*data)
+			continue;
+
+		ret = uvc_query_ctrl(dev, UVC_SET_CUR, entity->id,
+				     dev->intfnum, MSXU_CONTROL_METADATA,
+				     data, sizeof(*data));
+		if (!ret) {
+			dev->quirks |= UVC_QUIRK_MSXU_META;
+			return 0;
+		}
+	}
+
+	return 0;
+}
+
 int uvc_meta_register(struct uvc_streaming *stream)
 {
 	struct uvc_device *dev = stream->dev;
 	struct video_device *vdev = &stream->meta.vdev;
 	struct uvc_video_queue *queue = &stream->meta.queue;
+	int ret;
+
+	ret = uvc_enable_msxu(dev);
+	if (ret)
+		return ret;
 
 	stream->meta.format = V4L2_META_FMT_UVC;
 
diff --git a/include/linux/usb/uvc.h b/include/linux/usb/uvc.h
index bce95153e5a65613a710d7316fc17cf5462b5bce..ee19e9f915b8370c333c426dc1ee4202c7b75c5b 100644
--- a/include/linux/usb/uvc.h
+++ b/include/linux/usb/uvc.h
@@ -29,6 +29,9 @@
 #define UVC_GUID_EXT_GPIO_CONTROLLER \
 	{0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
 	 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x03}
+#define UVC_GUID_MSXU_1_5 \
+	{0xdc, 0x95, 0x3f, 0x0f, 0x32, 0x26, 0x4e, 0x4c, \
+	 0x92, 0xc9, 0xa0, 0x47, 0x82, 0xf4, 0x3b, 0xc8}
 
 #define UVC_GUID_FORMAT_MJPEG \
 	{ 'M',  'J',  'P',  'G', 0x00, 0x00, 0x10, 0x00, \

-- 
2.49.0.504.g3bcea36a83-goog



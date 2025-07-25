Return-Path: <linux-kernel+bounces-745682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B059EB11D08
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4FB61C865E2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CEE2E6103;
	Fri, 25 Jul 2025 11:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W9WvHmSg"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A71023BF96
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753441297; cv=none; b=UNY+7VbLpVkit/9FmTafhbGl1QYuO/vDqVP3VA0H6Ei0iV9Sa5MEOXKuO2VcIVQ2Uh1ytTOky+uF/o6h/mku9PM9+LutFf/6KUJe2AZiXMH4quWzfYaOC2Pe4zRIHHwnecHBoQsTtZoWxRYUKYqQyr8OB6Zwzni8jimBjcu7V0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753441297; c=relaxed/simple;
	bh=91c+c3XacArZYhJktraFog1DitCooWolYjBkQgEPN+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=df2GrevkWcyA07DkmRi4XXnXkFlpqW7zL7+cACiC2Z6mcD4KnwXRBTUkcJ2XpMXO0EdhQ/SoivIp6vVQExb0bzizTyGp9gLsypODlOCdBGh98m+ngjiiDGYrU+enhroyJnzbSsXekqXglL8LwLzs9sE226BZIV4LUa0dYbO4a6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W9WvHmSg; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32f3ef6178bso16539621fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 04:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753441294; x=1754046094; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s1Nxza4r7OAZ4l5YzoQCQzc/vgKwVrRaLTJPvigr7KM=;
        b=W9WvHmSgXIVRK4haB4MedJYb/vdEhrgli7DabpIHFVLnQmq0tRau9E3tCbP07fPVRN
         9eQE8NPRaPzyHa8NbED+OVExSaD9/krjEPWEsq/qVs15i2Ju1BFbZbU9IgF/HHQFozni
         HWgN7PAd0FidpL6PYPcimWUZRQ3hZvZHsJjaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753441294; x=1754046094;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1Nxza4r7OAZ4l5YzoQCQzc/vgKwVrRaLTJPvigr7KM=;
        b=XQCkKuFn7JW5DP64wGILuDQGKkarjLCN91doqUzdqNsqyY+5Ednbsp/HPbOV9UppSo
         aKNmQD7zJZVWYJy5KjH+50chtPoMPQLjzbH7ipUcNcmP4m2RbR1VjHjfEvPx++21LMQW
         0kz1CedZkyBkfBmuOEvPs6ZIwItBvXbyfRix8zzfdCb3PsO/3pfKeVIe3LCrjusryc30
         +RlZRooeZSz3TiadbxekBr8iIE1v9kZT60iZJOLfpdeHJoVvQmf0VMpU50Poxq5oemRz
         qZ2F0iUrKLMqm9JmX2Y+/lOMiXeFjQaFB8F+XlzaIXAc21NcoYrum2jcPOY88fkMKGBW
         yS+w==
X-Forwarded-Encrypted: i=1; AJvYcCWaOCKD+gvaB7fMWeR546DflGLOIo8JBSuZG2bP0NZ+dn9pK0HH1j0Hbsc+tqRxzIanJnciYHLUdX147DQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrx+q/yKXB+RBL5FHO2KnHvPs84jjisF/wV688mHZPpdq87+XU
	J0K6JVM9seLvub04QGCn9Q8e0nK5/nGSw4BuMnBCvB9KOkB04A3FeE48S6pajUZqdw==
X-Gm-Gg: ASbGncutnqblXu1kS58eWVd24r7Uofssiy3ZGgFxyjxd20H8AjVtOy92oebXWpq/IW4
	iR3cM2MKLVSGL9DmlexZamEoQvgRnViAHB9+h7yVznsJYrdVGp0Smt8p4NkwK/ueOHrzWUs4Y7b
	9VWDw+qS0Xt+rLhFfhwXNLwmiO/5oItpan3n6GjwHBrsUNLC1ahMW/1/dqOe6H+/g8mdoXTPlGI
	Sqiose3WZm9z0CFE7XEQx+noM9C7itYLv3DpSOEzv9VMt0OHz2bh8FDkKdSWgVrF26AhSN3y7DK
	yHjcGMeWAybKnNlV59C47kwEJQi3U24YUcSI8PUZgiQH/miMNAakd/J3GYoiyygtCcZJejL12Al
	fq5ItGDhmIr3JU+SXBIDBT7EbmLiAaw9iOplVBtJzn7T7N5APMUPzFCSYNUyr/PByRXLt3L631I
	00Aw==
X-Google-Smtp-Source: AGHT+IGCop+bbnI2GJGX4G+Ze/OhblUQtpcNFHyqhlJ15tmeQfxDEPv5skwMMRx0MrNl/cPvjV1utg==
X-Received: by 2002:a2e:8e63:0:b0:32b:719f:1260 with SMTP id 38308e7fff4ca-331ee6ee566mr3407751fa.9.1753441294210;
        Fri, 25 Jul 2025 04:01:34 -0700 (PDT)
Received: from ribalda.c.googlers.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-331e8940156sm4187141fa.97.2025.07.25.04.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 04:01:33 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 25 Jul 2025 11:01:30 +0000
Subject: [PATCH 2/2] media: uvcvideo: Do not re-reference dev->udev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-uvc-nousbdev-v1-2-28f5a1fdf544@chromium.org>
References: <20250725-uvc-nousbdev-v1-0-28f5a1fdf544@chromium.org>
In-Reply-To: <20250725-uvc-nousbdev-v1-0-28f5a1fdf544@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.2

dev->udev is already referenced by the variable udev. Let's use it.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index d09d1286da0f61d5953125df23ed92555585e8f2..209cedeff59e8be2e96ce79c3d395a5a85a336c6 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -882,7 +882,7 @@ static int uvc_parse_vendor_control(struct uvc_device *dev,
 	unsigned int n, p;
 	int handled = 0;
 
-	switch (le16_to_cpu(dev->udev->descriptor.idVendor)) {
+	switch (le16_to_cpu(udev->descriptor.idVendor)) {
 	case 0x046d:		/* Logitech */
 		if (buffer[1] != 0x41 || buffer[2] != 0x01)
 			break;

-- 
2.50.1.470.g6ba607880d-goog



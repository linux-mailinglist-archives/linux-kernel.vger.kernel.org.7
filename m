Return-Path: <linux-kernel+bounces-774435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B416AB2B22B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAD977AD218
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE88271462;
	Mon, 18 Aug 2025 20:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S9zSFeoo"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B931FF1B5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 20:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755548143; cv=none; b=i8BjJ6i2Th4znWXY8dplEjhA4wCV750HHB2rWP1/i63vvkwA840IlawD45TDB9uanReiX2DAroXCvI5M2Lq6ZnM7t2pCjqjbzgQgGxmrSm8zOSssqqXGgnwmr1tE+5o40OSQXOtBAUc4fQA/AuCsZn5fwCsn+1MrqFixFm+KX8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755548143; c=relaxed/simple;
	bh=CaUrB4UP/dAbYK1r25EfF08W4CEvtMBYfIS5kCBy6PI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s/I0b+T4LxbCLaTgoTH71M+H9gqJ9oZceGDNuhntsDweHaMq+Pk6ggFfWm+TMLpA7aFlR6qyj0Boa23EQL/dKfIscFMYue5JQI3HUSHynDY5Ug+E3A7fadnEgxColxd+GSV/poueIp5xnaYDYQ63+MDSY5s5QcRkhgx6YMAqrmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S9zSFeoo; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55ce521e3f4so4838233e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755548140; x=1756152940; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7ecUUREqZxH3NQXkzrG8AHXGf+HApsHSTGrw6/8F50=;
        b=S9zSFeoogljdQWelQcjANXDsyyY+48RiE+TLPqFb6qREMI9JHz/jkC29faZnEaVmVI
         KmSk5e8eJWxNfYtI7Cn2T3AzKLvRSO3G/d1Yb2kVkeQ3XdlCBc7yFvto6n0W8qeYRVwl
         e1BaZeQCT3zPFPGPFa5n+p3FMbOyWgj2lL8Bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755548140; x=1756152940;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7ecUUREqZxH3NQXkzrG8AHXGf+HApsHSTGrw6/8F50=;
        b=mkXk+00PXK8J7gxSvz5uvZMClgHXVQUhK5hn5icqDmw9D6GXDZxl3Jmf3/Eyeg7O5K
         ZIlf+z6Wsr0r6fhLFzvRtID/8u0PwSvePaddr8UqcDyy5zvwFWStaf2n/TH24qF63Ja2
         69pppEs5ITPAg6G3MO2cn+ak9+bNwd36tzPuKK6t7KlJtRTVPylOSymL3iDq9z2w7UVt
         XN/da19D0CJslkbaNxaFeNHmfqs54NdFJ26ZvKiG8egYTHdfZm1ou5JCINqyIQKLj2Zq
         e1Qex8JXkjmwG8A53cSfEwEyc++lZInrf60247/DMPEMY9RCYd4kFBTyWtJ8s/z+BAg4
         4i3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWyozydTyWjcTgZ+ZYoMgHlhTSXe7zpzsnLtbl0rKMMaaoIhoVTkPrdszpCiU8m5NCmHJyOTo20Ku3KQI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YynFnVbmxpVPCZnJG3nDCbGyixVlK3zptp3aSIKZiFby+JMNWlh
	Xgh9VXWg3ONaLdgVDzcQrnylBwmADFMXbUEuYYAyezzGfQLv3nJWM/hRhiZdJqIy4w==
X-Gm-Gg: ASbGncsiU6yuInbEV90jB6xfBvfITS5uVzM1azhi0oe+aNZbWUfDsdxhXGhjha/R18y
	6hxtyqCxLL0nDH7vvMQ6bA4pVGld/a7g7IU81Anwf5wYgHY6uQxGPfGeDRLThPOi0jEtzviYIVb
	7fuCYSPA09BTx7NQVC0hfIi1QtY6/CaGDq04lKqtiCiec5GTzcNXIUAfqh3FMH4NGjFjoVjoNDf
	bazPx/iJ1BA5WeeEe8S6KtnrRgmr02k82+4ED1XHVdZlfMBKv/nUt1NRXBMAalWZYg2RiV9dunL
	D2kCS9pBtv+UYlNzeRIaclJtGTnJznwgXIaob1ib/0gRjB7J7NtJl83OcIUqqcBqUoQMNICl14L
	uzDVOFbtAm9deCtZEWq+t4vjfcq/MbYF3Y0BWu5jc7+vwzu/m6n4HGzR5xq/7z/ZCyeYNfVZ8vg
	s=
X-Google-Smtp-Source: AGHT+IFb9FqH/R1wchdlDtJrBvhxMgTs/qFlhYR9eOTJJ/bU3X+4wqPPopUwbCGpty45TkWd2J9jvQ==
X-Received: by 2002:a05:6512:3b13:b0:55b:9045:ec5e with SMTP id 2adb3069b0e04-55e007651f0mr50179e87.18.1755548139615;
        Mon, 18 Aug 2025 13:15:39 -0700 (PDT)
Received: from ribalda.c.googlers.com (237.65.88.34.bc.googleusercontent.com. [34.88.65.237])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3f3476sm1789268e87.107.2025.08.18.13.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 13:15:39 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 18 Aug 2025 20:15:36 +0000
Subject: [PATCH 1/4] media: uvcvideo: Fix comments in uvc_meta_detect_msxu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-uvc-iq-switch-v1-1-f7ea5e740ddd@chromium.org>
References: <20250818-uvc-iq-switch-v1-0-f7ea5e740ddd@chromium.org>
In-Reply-To: <20250818-uvc-iq-switch-v1-0-f7ea5e740ddd@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.2

The comments can be more precise. Let's fix them.

Fixes: 6cb786f040ad ("media: uvcvideo: Auto-set UVC_QUIRK_MSXU_META")
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Link: https://lore.kernel.org/r/20250716-uvc-meta-followup-v2-1-d3c2b995af3d@chromium.org
Signed-off-by: Hans de Goede <hansg@kernel.org>
---
 drivers/media/usb/uvc/uvc_metadata.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_metadata.c b/drivers/media/usb/uvc/uvc_metadata.c
index 3b0b392895119bb6ac300fc40b89a7ea00e56b40..b0960f0553cfcb30b0036d2ad8877fafa225c6a4 100644
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

-- 
2.51.0.rc1.167.g924127e9c0-goog



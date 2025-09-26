Return-Path: <linux-kernel+bounces-834083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB03BA3D3B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E356238CE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE73301714;
	Fri, 26 Sep 2025 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MEdFAQ1S"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7AB2F8BD0
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892304; cv=none; b=mN90fwjbZir+krFPvqoZJFo/ii3cqZW2RHfloE+c+eGFAxyYwH+8yEm+xrEI8rpwqBLdsMP7ffIOit+crzaZpfa0PwO0G+fALYFaRYMB1SH2b1jaK3F+5g/LesaRFAfMKbattNEm6LW1iKDXG9crfnuUHirjFVrOHNS3MLtes5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892304; c=relaxed/simple;
	bh=747DSL3/0b26gMfctw9GAJQ4wcs8qWL90knTYpPv+GE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e7RrjVwWQqNbwBJyAiZBZN59u7FB4HKEDbIWodpmZaxLIQt36YOqTJ5wJ+wdoVvMDuE/OXWqogzfRWIPvmUcjvIk308HHJDJzTcGyHeWW0idBMYS+cSsul92dyEuYsJ4EqrRFqaNQw5NXFmjX1iAV99BZ+38mnyMaPWIstmewqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MEdFAQ1S; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57a604fecb4so2646070e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758892293; x=1759497093; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEFN0lLdAUAhxOrw8NBMU68FYdHDfoPQjtv/CBRcNWg=;
        b=MEdFAQ1S/grHZMhcCO6tE2MJcK4ibjWaeuhsoYyuBn71UUcnUC/shY5ocmLp/qu7WP
         7okYhCuXdM2bbt6BvNRcorf2eaEw8bYT5GfWfnogq8O28zLjMWCbeVbc5r+A5z91fMDr
         LpswgYv+M4HDBm0DOXhHwb1oqtph27Tu0Jodw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758892293; x=1759497093;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PEFN0lLdAUAhxOrw8NBMU68FYdHDfoPQjtv/CBRcNWg=;
        b=YLrpmP7Vi31ECWqGpi63bVKJluPSU3gqz7rw2pwL3u6TmkoB3hI7hQd8vrnh/o+Lfn
         0EeNJBFnKjZSTe6qA3vB7pwNEeqFp1ijZHeDdKk+jMiQ0DusqgpoOlcsHpgQQrqDnN5C
         ZnSeu9O0gBax1X6fOnNPoCeQqRs2XdHcRLPx3SJ6G0ftO62Cds8W99rBCPBav86RLqOb
         kvtbKI/CsWxIOuQc2w87s8+qqXCdpgOmIAZqml6hq0NkyobAMTj14BgMT7BUpkkV1uKj
         qqxyJQwrauA+WfD6ngK8gmR3FQHYKbJjIGvyyCEb+/BoVDMuqpJdJJjTjWXhXB8xxSl+
         U/dQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/pHtVIDQOb99XngGNDTvBkGvDf7oM6X6rSZT4q+HKYT2hcJPy1FVspoqd5wBoVrFc4sAiu0JPIQSiySY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUqMBEpFoED4uJkkqq2tfYfeXZWHU9Oqh0dMnuF6Ah4ptDUVYW
	PuWQWbe0puyLuV2sRjWn1JAyCGftdrMLHsrE813n1BRpKBhZcrTcQpgTfb9ex4KShA==
X-Gm-Gg: ASbGncuzt8VgGso1ZBdfl5p4/sr6caPHg4rSKqie0mLrLLJ3Hplun7N27QDC3/1fEA0
	ONCtFuGziuZ0wP9ZaVHl3VwmRtoExLuDyM6Qj85KkPzffKIWIAtyTEWJF31s7/pJlC5VPQzSS3K
	8UaA+WnXpe3NNBISFcxRdC+wAWPLQMBwoLs/Ax9eKnV7/ppXKR/xH3L60Li3pAg/BbSeL+ppstb
	XKiV4Y2mKr1+ujwLF+V1TyB40fLNDbXwvgV3dYDnv/qco7vtp3qwCVoHJbvMQDqeeptbfCyEL/6
	IOwSLPUaCM21C67ymE6gL2mQOEOLkJ7q++cKTcYviRzwWAj5faOw+lDgyQH/L1TxVwxAVoYjk7S
	fbfWSTZphvXS6Hw0fDosaePi5Zol3raZlc0+swLEbfe68F+3vZgmKwfDX6J30SnnB/jdcKVxHOW
	5dgQ==
X-Google-Smtp-Source: AGHT+IHoXncX6KzHuffRNxD1bdNRByMLtGFUXJU+Vx+pJpeCHx/eyFalgZtv/Aq9A8oN/XwwQ6kRbA==
X-Received: by 2002:a05:6512:e9e:b0:563:d896:2d14 with SMTP id 2adb3069b0e04-582d2b4cb9amr2443275e87.36.1758892293127;
        Fri, 26 Sep 2025 06:11:33 -0700 (PDT)
Received: from ribalda.c.googlers.com (64.153.228.35.bc.googleusercontent.com. [35.228.153.64])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58527c6b014sm123872e87.43.2025.09.26.06.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:11:32 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 26 Sep 2025 13:11:30 +0000
Subject: [PATCH v3 06/12] media: ipu-bridge: Use v4l2_fwnode for unknown
 rotations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-uvc-orientation-v3-6-6dc2fa5b4220@chromium.org>
References: <20250926-uvc-orientation-v3-0-6dc2fa5b4220@chromium.org>
In-Reply-To: <20250926-uvc-orientation-v3-0-6dc2fa5b4220@chromium.org>
To: Hans de Goede <hansg@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.2

The v4l2_fwnode_device_properties contains information about the
rotation. Use it if the ssdb data is inconclusive.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/pci/intel/ipu-bridge.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index 441d1a5979fe94bee4738da68e185a44dbd411d4..6155046ef4fc6b5d074194d1b8113212304136bc 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -242,19 +242,23 @@ static int ipu_bridge_read_acpi_buffer(struct acpi_device *adev, char *id,
 }
 
 static u32 ipu_bridge_parse_rotation(struct acpi_device *adev,
-				     struct ipu_sensor_ssdb *ssdb)
+				     struct ipu_sensor_ssdb *ssdb,
+				     struct v4l2_fwnode_device_properties *props)
 {
+	if (props->rotation != V4L2_FWNODE_PROPERTY_UNSET)
+		return props->rotation;
+
 	switch (ssdb->degree) {
 	case IPU_SENSOR_ROTATION_NORMAL:
 		return 0;
 	case IPU_SENSOR_ROTATION_INVERTED:
 		return 180;
-	default:
-		dev_warn(ADEV_DEV(adev),
+	}
+
+	acpi_handle_warn(acpi_device_handle(adev),
 			 "Unknown rotation %d. Assume 0 degree rotation\n",
 			 ssdb->degree);
-		return 0;
-	}
+	return 0;
 }
 
 static enum v4l2_fwnode_orientation
@@ -297,7 +301,7 @@ int ipu_bridge_parse_ssdb(struct acpi_device *adev, struct ipu_sensor *sensor)
 	sensor->link = ssdb.link;
 	sensor->lanes = ssdb.lanes;
 	sensor->mclkspeed = ssdb.mclkspeed;
-	sensor->rotation = ipu_bridge_parse_rotation(adev, &ssdb);
+	sensor->rotation = ipu_bridge_parse_rotation(adev, &ssdb, &props);
 	sensor->orientation = ipu_bridge_parse_orientation(adev, &props);
 
 	if (ssdb.vcmtype)

-- 
2.51.0.536.g15c5d4f767-goog



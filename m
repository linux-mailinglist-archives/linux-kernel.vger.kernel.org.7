Return-Path: <linux-kernel+bounces-849712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 76723BD0B8D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 08F5C4ED058
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2812FBDF0;
	Sun, 12 Oct 2025 19:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeSvlw1Y"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198FC2FB63E
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760297051; cv=none; b=U0hdeRKrY4Phd/FQcrfQtX0v9zbVEpSfmbCYodbUeWd6jMvbBZtteMKvw/yOzs/2ZNaSLfVyYgogIki0J/6jWmRkp+Bt9EM4M3tMsDRXDUSbzUaKFt1vJ/lHOQ7veRErg8V56IbypKdfimU1Z/2ndFb48o2W9qAdt2Xtm0PnTeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760297051; c=relaxed/simple;
	bh=JE+9t2uTRyVmHQwjLdQehz8MHh5AG1h3FeCTYbIFTxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eE+1LsVHo21eBJv17t/xjPA75oNy1um5IRkOMBj+i593w8Kroy5OKSudRySlV4oAgAl2gkS9PZyeWCgR8HUn6/7UB1WPcXEWW1NR2d0nl3LMn3NEcHmO9qqunF03y+pbA5gLuK+HNO95/enu+EL18FxayAt8iSqBV/7GfhyiX5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeSvlw1Y; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3f5e0e2bf7so656589266b.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 12:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760297047; x=1760901847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lx6RwmSdgU4IIQBCfnjkaHIgGiO5u++wyA5NWC/K61U=;
        b=WeSvlw1YdMda0TtXTqSn94k7HvEdxRc+0knjrdWLQH5JTkQaJzqyjj80faL0SuztxB
         U6+GDVE5+Xe00zkwHgTdc9v9f2BaqiGZySu3N9hCVaKQl4VjGJ1BbMbgQ4FMTG3IB/XA
         gHxxn9YjPGlCIVwiO8uPEgqZp5RiVkqC/GsgCYzMFn4m6K5Q6dQeaXnKxauffbuMglsO
         K1mZRrc4iDVgLqC15hUVBbI36WLdFlm3Hdhtj6Ng36vfZU8vLO7YFC1PZ/Y9knk/JAHO
         xqKWz3hfFX6G1gt03JVDRMd4YpOsZ/omQ31Uo35vEoKCsjk/asjqtmuyOQkdccci1WAW
         R3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760297047; x=1760901847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lx6RwmSdgU4IIQBCfnjkaHIgGiO5u++wyA5NWC/K61U=;
        b=WGdTbR7an0QjfuxrsBEZ6J9Lthg/Zi7ZAMss1R1YWXBMYuq0wrqKaACy4acN6lSZS9
         0h+GPKREhhGFLI+MdgcxRxwW4r+TFQFExTsqmtV77qZMezTonaEgV6Zu3zEzaW3sECle
         mzwwf5+RxqMD4+tzuqZed5iCvsJT00QSUiAKsC9L2RF6mVH5dHhct7wQVkbzNACgIqWy
         TTme1RY4fy+BEN89SKcFER1ChGPtVHHDSYXXfqrKkIuy3+xJG9RMZ+OdxdUbyTrLVAOE
         bMXWmNujzxFohK5BDWJ3i2lkW3w3W2RE2Jh4Yivk8rUajiMhjCkHFWsACPvkfs4HbxXW
         gUMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVxPwWz8Zy3pS7pFzmzpkegJ+Q2If/08P1C+I+W2FxitEf1AU+EILNkAIdSaetpPndr+fTCl+u+YnUYs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX/P8+d+3JsbvWaqxEf7WYFotuQfMjgwCXxKfQd9CTwopqJs/1
	oLSEhKNAaDSt+QOQWIKAQ/Cz0+E5NgTPghNOqKTb3NlJdHxMWWlg7DSZ
X-Gm-Gg: ASbGncvDD7OoF1hFH0BctDWCqQna2TXPwZ+Yf5wH3HIN7pKwssJwlDMzZA8De361fsf
	MmqHdtxyUdRz+hg/sELw2SEdE8ZVC8wu/pFMDHmv1fch+a+n9jc+2/prVdXRGt1N7mAZ574Ddqm
	wjCJdyVAmMs4F0/4dbOuJsICaLp2YP68lck1FLY0Hi5NUdOEmMrUKS/BCxDNhoqdVBD+cVfO01D
	txkBGqD8NiFwpf5ul5dNqiKQ7fjJ0PsfHLkx/cAXLCcFReMZo/q4eqZPSKrI2pTduj1jCa45vG9
	05DdPreLdaprhGi1/O8J0Yl9rQv66fg5oW3F9xryUNpFlbvdp79AmEk27BZvZ5meXo9NMbaLBs9
	WL0A0lCdUkbZT8BmMqJbVsA2tKbI9Df//bsWzGHOxl58Fui+9C1ye8/ISE2BdqSTHaZFM5nkz2c
	Ve+jdwcvP6cx8321AtDeYWYDXHcyvKGIc=
X-Google-Smtp-Source: AGHT+IGH9C/CoLClf1Jkf0CjCgobVw/ZwbzYhFdY1bLk6LH3leZZDbDIp409NxGuCUrOaIqSIPGpIg==
X-Received: by 2002:a17:907:3f97:b0:b3c:8940:6239 with SMTP id a640c23a62f3a-b50ac3cbd52mr2018365366b.52.1760297047252;
        Sun, 12 Oct 2025 12:24:07 -0700 (PDT)
Received: from jernej-laptop (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d8283sm760176466b.38.2025.10.12.12.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 12:24:07 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: mripard@kernel.org,
	wens@csie.org
Cc: maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	samuel@sholland.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 23/30] drm/sun4i: vi_scaler: Update DE33 base calculation
Date: Sun, 12 Oct 2025 21:23:23 +0200
Message-ID: <20251012192330.6903-24-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251012192330.6903-1-jernej.skrabec@gmail.com>
References: <20251012192330.6903-1-jernej.skrabec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that channel base calculation is straightforward, let's update VI
scaler base calculation to be simpler. At the same time, also introduce
macro to avoid magic numbers.

Note, reason why current magic value and new macro value isn't the same
is because sun8i_channel_base() already introduces offset to channel
registers. Previous value is just the difference to VI scaler registers.
However, new code calculates scaler base from channel base. This is also
easier to understand when looking into BSP driver. Macro value can be
easily found whereas old diff value was not.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.c | 3 ++-
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
index 0e308feb492a..fe0bb1de6f08 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
@@ -836,7 +836,8 @@ static const u32 bicubic4coefftab32[480] = {
 static u32 sun8i_vi_scaler_base(struct sun8i_mixer *mixer, int channel)
 {
 	if (mixer->cfg->de_type == SUN8I_MIXER_DE33)
-		return sun8i_channel_base(mixer, channel) + 0x3000;
+		return DE33_VI_SCALER_UNIT_BASE +
+		       DE33_CH_SIZE * channel;
 	else if (mixer->cfg->de_type == SUN8I_MIXER_DE3)
 		return DE3_VI_SCALER_UNIT_BASE +
 		       DE3_VI_SCALER_UNIT_SIZE * channel;
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.h b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.h
index 73eecc4d1b1d..245fe2f431c3 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.h
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.h
@@ -18,6 +18,8 @@
 #define DE3_VI_SCALER_UNIT_BASE 0x20000
 #define DE3_VI_SCALER_UNIT_SIZE 0x08000
 
+#define DE33_VI_SCALER_UNIT_BASE 0x4000
+
 /* this two macros assumes 16 fractional bits which is standard in DRM */
 #define SUN8I_VI_SCALER_SCALE_MIN		1
 #define SUN8I_VI_SCALER_SCALE_MAX		((1UL << 20) - 1)
-- 
2.51.0



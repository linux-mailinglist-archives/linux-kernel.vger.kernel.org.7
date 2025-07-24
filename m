Return-Path: <linux-kernel+bounces-744638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C7AB10F70
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739C91CE5B2F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26382EA724;
	Thu, 24 Jul 2025 16:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="YzljV09b"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68FA1E1C36
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753373524; cv=none; b=s9aME1rDXs+4Hx8il6xwt31XG2E2t+e+cbX+BWvMuNgfG6CPHMAbJ3D5wnMzIa59kTdFGfv7XHIbAoLomZs85mw0W8u2jGG/LP3AkUlG5K5EUTPWHLrCjUEZhFPuWbhDCJJXiPPb/0aWK95yUz1hrcCLfnWqtimbrj5LAI0qi5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753373524; c=relaxed/simple;
	bh=SoJHiBW1PIZK1jP110UZ+DNPlCeUt+iooTnCKbcU1lg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ay0yAUvQh98I1R1buat3msmXWzcX0LTPCBJ/fAo98tzeIHDV+RNkb/6NRYRwaXJuhccc462ZGKmlRoqx2RiIFR8p92YQ+jTPO2Vy1JgI/8Dq9eFAEnTh60Una3L4DeGEzvT5jGwXKGtayEuoVzIObDvceN+/PbSHnQnbW8umeX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=YzljV09b; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45618ddd62fso12718995e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1753373520; x=1753978320; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sKE2Yth+IoZ8wREbSbWpM1Yc17BubACX60lHqBMyElY=;
        b=YzljV09bwYNlOtIwPjn1RT+JOKSanmdqF+mIqDcvna7BEGt0kHKob2opBX+OFAaTaI
         sCRuUXrb9PX+Yd81iBLaaeF3eDhTrJXc6hoLPky7XansDKpjzHHOxeFCitCwj5UapsqL
         EN/pWswwE/AvnTz/eyS0a6wsbzuCTa9ti8N1uvsw7s6+d4vigsc8v5SNjRcbkeDPuptc
         kprAEUBmqrTO+nelfzMZsImTsYo9WMaqVdrRHlswQoaIDO3cPGG/SQuAC7lfh8pr0qV6
         Dc/t7M/4NU2BlSiqBWuTnqPKFf4wz3JzH6s5YakSvI3xM1RMFpy6tts6ccEGGE2SENSI
         Tn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753373520; x=1753978320;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sKE2Yth+IoZ8wREbSbWpM1Yc17BubACX60lHqBMyElY=;
        b=lTN4kkXRvXhXKuHArrQ4suWGi9gSzScJQ0ui6qyp408pzbXV5CNRCiT8RYvD5+yvgL
         fHhL8wM6dteAVEG0tPAQ7AVhKlxZHfKASvAHfktkXWU9KTxmHZR8+Ptjkw4PSN1jjXs5
         G213P9Ah+aGHVBDyER9Uqk0T4ZVuJt3OOnG9jp/fWMsMEBdq8zKg0sxZNpcuX6MjqaJA
         NhBkoRI/Od1d5AICjLMf7rB2FfmrA5BKjrinc0ziw3Ib2ayHeuzygN9T4Fl1y8/0ElxF
         Y6DqoQ2uzXaZSfPYLkLlG0SPGoEvosUSoW5ML+9YItff1kMbhHDUvjyq6GHrY72Zc7Vo
         8dkg==
X-Forwarded-Encrypted: i=1; AJvYcCXg8Bx9S+rOUAIUO16e+QsmukjFieR5odOr6MKI7Seo7FutLoP0MHgrnaq/wY8IaZ/qT6pdVuENMNcBBrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDlhIC6PheUAmRZPy74oUdHhM9kks4EvK37PZTMj7gp97Iopro
	3mYygARyi7l8mks4K39Q/Cx2EpCe1eyJIcn9tDMCwMaVGRL35Yw0KA86DeZd4Tf+jbQ=
X-Gm-Gg: ASbGncuJmDOKqAQBR+CnrQGEuTG9aab4fqg52lj2Og+VPc55B9iP65/5JZx38GwWr+n
	+qzxwwmHVPXE2R+9+i01sNgXsRa6xksdJ0dgTibbt8WECO1bRjE1B6DrnZaqJ+y5ZRLyVYi2Vrd
	HZI6uq3lHgS1NdZyAVirFySdKiK/AREaq5EqG35vPTMIeSCHcdUbXhAOesXebkqzKuDU5C5IA5q
	1v/gmir3+JH3EFgWmyNKk7MR9S3pCqK5bdJpYsn7ApVhEsZQw9ctrozETAhhejF38d8vxxzcz63
	0Zxt4SH5H7jN156XDrkecyfBFlEy6TLycHTBqgemzatbIh9k+jTDCSfN7OBo3rywCPy6hJy688C
	gFDJgZ82hz5VJGQ==
X-Google-Smtp-Source: AGHT+IFERQTwzNbDaULjFQ2kQzB2Vjvp40JoxsenWhZmq9Krh5Kw8UX1u5qAYA7gY7+JEEXIyqnFZA==
X-Received: by 2002:a5d:4383:0:b0:3b7:739d:b4bf with SMTP id ffacd0b85a97d-3b7739db587mr697633f8f.51.1753373519838;
        Thu, 24 Jul 2025 09:11:59 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45870532a4csm24968315e9.7.2025.07.24.09.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 09:11:59 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 24 Jul 2025 17:11:46 +0100
Subject: [PATCH] drm/vc4: plane: Add support for P01[026] and S01[026]
 formats
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-drm-vc4-extra-formats-v1-1-67fa80597fad@raspberrypi.com>
X-B4-Tracking: v=1; b=H4sIAEFbgmgC/x3MTQqAIBBA4avErBtI06KuEi3ExppFP4wRgnT3p
 OW3eC9DJGGKMFYZhB6OfB4Fqq7Ab+5YCXkpBt1o2/Ta4CI7Pt4gpVschlN2d0dUwbbUmUF5r6C
 0l1Dg9H+n+X0/Nj9Q6GcAAAA=
To: Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Robert Mader <robert.mader@collabora.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.14.1

There are now formats defined for 2-plane YUV420 at 10, 12,
and 16 bit depth using the most significant bits of the 16bit
word (P010, P012, and P016), and 3-plane YUV420 at those
depths using the least significant bits of the 16 bit word
(S010, S012, and S016).

VC4_GEN_6 can support all those formats although only using
at most 10bits of resolution.
Add them as supported formats for all planes, but filtered
by hardware revision.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
We'd been asked if the S01x YUV formats could be supported on Pi5 as some
software codecs produce them.
The answer was yes, so this patch adds them and the P01x formats.
---
 drivers/gpu/drm/vc4/vc4_plane.c | 54 ++++++++++++++++++++++++++++++++++++++---
 drivers/gpu/drm/vc4/vc4_regs.h  |  9 +++++++
 2 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index 056d344c5411..3d1342751a80 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -36,6 +36,7 @@ static const struct hvs_format {
 	u32 pixel_order;
 	u32 pixel_order_hvs5;
 	bool hvs5_only;
+	bool hvs6_only;
 } hvs_formats[] = {
 	{
 		.drm = DRM_FORMAT_XRGB8888,
@@ -247,6 +248,42 @@ static const struct hvs_format {
 		.pixel_order = HVS_PIXEL_ORDER_BGRA,
 		.pixel_order_hvs5 = HVS_PIXEL_ORDER_RGBA,
 	},
+	{
+		.drm = DRM_FORMAT_P010,
+		.hvs = HVS_PIXEL_FORMAT_YCBCR_YUV420_15_6_2PLANE,
+		.pixel_order_hvs5 = HVS_PIXEL_ORDER_XYCBCR,
+		.hvs6_only = true,
+	},
+	{
+		.drm = DRM_FORMAT_P012,
+		.hvs = HVS_PIXEL_FORMAT_YCBCR_YUV420_15_6_2PLANE,
+		.pixel_order_hvs5 = HVS_PIXEL_ORDER_XYCBCR,
+		.hvs6_only = true,
+	},
+	{
+		.drm = DRM_FORMAT_P016,
+		.hvs = HVS_PIXEL_FORMAT_YCBCR_YUV420_15_6_2PLANE,
+		.pixel_order_hvs5 = HVS_PIXEL_ORDER_XYCBCR,
+		.hvs6_only = true,
+	},
+	{
+		.drm = DRM_FORMAT_S010,
+		.hvs = HVS_PIXEL_FORMAT_YCBCR_YUV420_9_0_3PLANE,
+		.pixel_order_hvs5 = HVS_PIXEL_ORDER_XYCBCR,
+		.hvs6_only = true,
+	},
+	{
+		.drm = DRM_FORMAT_S012,
+		.hvs = HVS_PIXEL_FORMAT_YCBCR_YUV420_11_2_3PLANE,
+		.pixel_order_hvs5 = HVS_PIXEL_ORDER_XYCBCR,
+		.hvs6_only = true,
+	},
+	{
+		.drm = DRM_FORMAT_S016,
+		.hvs = HVS_PIXEL_FORMAT_YCBCR_YUV420_15_6_3PLANE,
+		.pixel_order_hvs5 = HVS_PIXEL_ORDER_XYCBCR,
+		.hvs6_only = true,
+	},
 };
 
 static const struct hvs_format *vc4_get_hvs_format(u32 drm_format)
@@ -2490,6 +2527,12 @@ static bool vc4_format_mod_supported(struct drm_plane *plane,
 	case DRM_FORMAT_YVU420:
 	case DRM_FORMAT_NV16:
 	case DRM_FORMAT_NV61:
+	case DRM_FORMAT_P010:
+	case DRM_FORMAT_P012:
+	case DRM_FORMAT_P016:
+	case DRM_FORMAT_S010:
+	case DRM_FORMAT_S012:
+	case DRM_FORMAT_S016:
 	default:
 		return (modifier == DRM_FORMAT_MOD_LINEAR);
 	}
@@ -2524,10 +2567,13 @@ struct drm_plane *vc4_plane_init(struct drm_device *dev,
 	};
 
 	for (i = 0; i < ARRAY_SIZE(hvs_formats); i++) {
-		if (!hvs_formats[i].hvs5_only || vc4->gen >= VC4_GEN_5) {
-			formats[num_formats] = hvs_formats[i].drm;
-			num_formats++;
-		}
+		if (hvs_formats[i].hvs5_only && vc4->gen < VC4_GEN_5)
+			continue;
+		if (hvs_formats[i].hvs6_only && vc4->gen < VC4_GEN_6_C)
+			continue;
+
+		formats[num_formats] = hvs_formats[i].drm;
+		num_formats++;
 	}
 
 	vc4_plane = drmm_universal_plane_alloc(dev, struct vc4_plane, base,
diff --git a/drivers/gpu/drm/vc4/vc4_regs.h b/drivers/gpu/drm/vc4/vc4_regs.h
index 27158be19952..4536e3c0533b 100644
--- a/drivers/gpu/drm/vc4/vc4_regs.h
+++ b/drivers/gpu/drm/vc4/vc4_regs.h
@@ -1079,6 +1079,15 @@ enum hvs_pixel_format {
 	HVS_PIXEL_FORMAT_AYUV444_RGB = 15,
 	HVS_PIXEL_FORMAT_RGBA1010102 = 16,
 	HVS_PIXEL_FORMAT_YCBCR_10BIT = 17,
+	/* 10 bit YUV420 formats with data with various alignments */
+	HVS_PIXEL_FORMAT_YCBCR_YUV420_15_6_2PLANE = 24,
+	HVS_PIXEL_FORMAT_YCBCR_YUV420_15_6_3PLANE = 25,
+	HVS_PIXEL_FORMAT_YCBCR_YUV420_13_4_2PLANE = 26,
+	HVS_PIXEL_FORMAT_YCBCR_YUV420_13_4_3PLANE = 27,
+	HVS_PIXEL_FORMAT_YCBCR_YUV420_11_2_2PLANE = 28,
+	HVS_PIXEL_FORMAT_YCBCR_YUV420_11_2_3PLANE = 29,
+	HVS_PIXEL_FORMAT_YCBCR_YUV420_9_0_2PLANE = 30,
+	HVS_PIXEL_FORMAT_YCBCR_YUV420_9_0_3PLANE = 31,
 };
 
 /* Note: the LSB is the rightmost character shown.  Only valid for

---
base-commit: e48123c607a0db8b9ad02f83c8c3d39918dbda06
change-id: 20250724-drm-vc4-extra-formats-1f53e6491cc1

Best regards,
-- 
Dave Stevenson <dave.stevenson@raspberrypi.com>



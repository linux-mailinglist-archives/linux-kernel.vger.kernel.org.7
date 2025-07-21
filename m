Return-Path: <linux-kernel+bounces-739088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DAEB0C19E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3B2D1891A46
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091192957DE;
	Mon, 21 Jul 2025 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLxmMStp"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1779B293B7E;
	Mon, 21 Jul 2025 10:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753094662; cv=none; b=GZRof+w8wdQmFVHEvQHNV9J82yb5Vweu+1ZIjsiM9zIBGmGmAUdMnH1WSMoLWlAVBLydJi7LGboa1cJ1Pvysn7rvNVRKXbK/6r7BoTQHjIQqz3R5eSlvpaq5XHsCSPHwBwfglGEm9xmT+KwYAli382Tc74ZYa4RZ5PugMtXOBVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753094662; c=relaxed/simple;
	bh=I4G+JbRsrDS4oV8BaxIOe0VI1PnFurXtnr3+a5PfHc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AUq73d6Hy87esFBLrIpcoN47/sYb1nOvhQT08KqROc3mj8tuAFz0MCGH1Muhs+gPN48mnqatvMOCuYiwAPcL+jD6HR5OaVc6MC6fNB7sdMmVpBpFQHaLEx7rv3Ra33QXLqd13HSbUFQSmWQiy9cLmRMnCwsv+YK6MgW6vXvtfqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLxmMStp; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5562838ce68so4064756e87.2;
        Mon, 21 Jul 2025 03:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753094658; x=1753699458; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RB5lNaovChCD8tOuVlmGSmp/T+ZYteObQVStiP2KQcA=;
        b=HLxmMStpAHc+YZ9pDOe6zw8SGnaQuZHPI4rql1Xn75VeX5s4OjrJeDYYRr37kc0lq/
         ePtSSd8cn0WxNaQEEZX192u61ryuKlX5tDQD9ib+InIwwgG77/Y8CBstIzP1bS31miXf
         Mjti88e/+8LjvLicLBKSiCPng/SyF3wJDKenkNO7j3BykfatdW/qJbJyRefQZ1IqqRxY
         Dw1QXspHpIy2ZX0eMFulUKSHoNI2v8jPhoevxzkZllWkjqZN2RXU35bwJ+3bD6+lxeG3
         CkvfUrseSb5Eq+UbaYoj7xrxjA+NgxO2xVyJ16iWYJ0/CZmcXbPe1OA5pjVumB3L4Rcb
         a3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753094658; x=1753699458;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RB5lNaovChCD8tOuVlmGSmp/T+ZYteObQVStiP2KQcA=;
        b=vcnUIdjEvbIUjNAZKfGCMm720wvUrxJSKFNyK/VQV7ZmFpkaVAV1EkNScnoTQ9GxS7
         l6co3noJUvEPV3Oq0xkyo0KE8YUrj0ygEKFhnEUS5dH2zKZ+nUTUpuPULEe3QnQhZLsM
         HjHVibuuseii/6DreFtL2APbtnEMpVJhbWs3aBiEIBV/31ekAQJKtcmgoobYiQKXrMp2
         AYrKmrE0iFqim8ub3H2/MPrazW4GBtLb15yfZMiz5cOOrJh+f4IlEbwRkDiRnKyHgdti
         R4sD01B4Zfdc6d/KIbv6CxFLEXreOlFv1kp/IuFDH1pjO7p3YM9ANkiBP0/vRTScYHS/
         mw/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUV+eOL9WQSFHxRjlQqvj/YgmdX4m6Y4t/EE03DiRF8YHNzeWv6xDsyHK7zQsOz/pXrILPdTFsJyePqY4d@vger.kernel.org, AJvYcCXl6dJBeQG3deZUrxPV7WdATXlnvjgdOkU8IuGKMRhow/tbu93BnN4GDz9NAJjwy1mk4EP4dWjxoDHS@vger.kernel.org
X-Gm-Message-State: AOJu0YwnnEBeDHT/G5bb2pi8YUB13qi2cMQOVQVkrDJMrKFNhiN5nG3C
	CF7nT2oSOFjQnlhHoG/wmklOweSUUMmld2LMZYtgQ3Gtbfn44xNQVT/gwPHXgB82Kzo=
X-Gm-Gg: ASbGncupX9SQ6SR6xmjQRgeAhS/MA0dYzDpzU/3GzPF703MN8wZrxz7LgmPXQPJZ329
	DyTt/AYUgx+JLPKYojgiI4KxYNezalionzFN7SZw08c7Or5mJr4+8+Ck5j2h21ASjWGOYW7k/X7
	FrCZ/GryzC0NpSZ3Dif9sYFKEAgMDzjZJU/8N7b9hBwFVVHhZRKNriEDGtNlmR8O/dJiIOQbW9E
	wGYKy93A3TR8eAzyFuWUEs9pSd1KaeEDFU3yrFVUSzAjj3CVQE1H5tg+xwBtytipLPS/12VgsRR
	jGFOWLSMeo2vm2hH+YLeJt+M01E+sfc+dG40aotUnkRYyvikpvRrsneFnT75BByy3dtr8GC3kFK
	YFo+0RcmSX2FU191eg31ypFMrEW+6SPqMYOB5NVgeRtqtUGwDXe3pwcGIuKtLfO1NHHE=
X-Google-Smtp-Source: AGHT+IHGsOjqFEHcEedZtuyZb6FZVdOlC4x4WmTDRlK+Kfy/7WqcMJrzVPtzqLQcqUNw+Lsn6He+rQ==
X-Received: by 2002:a05:6512:15a7:b0:556:c4f1:c7c8 with SMTP id 2adb3069b0e04-55a23edf989mr6883902e87.3.1753094657570;
        Mon, 21 Jul 2025 03:44:17 -0700 (PDT)
Received: from [192.168.1.198] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31db89bbsm1505164e87.237.2025.07.21.03.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 03:44:16 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 21 Jul 2025 12:43:35 +0200
Subject: [PATCH v2 5/6] drm/format-helper: introduce
 drm_fb_xrgb8888_to_gray2()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-st7571-format-v2-5-159f4134098c@gmail.com>
References: <20250721-st7571-format-v2-0-159f4134098c@gmail.com>
In-Reply-To: <20250721-st7571-format-v2-0-159f4134098c@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5865;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=I4G+JbRsrDS4oV8BaxIOe0VI1PnFurXtnr3+a5PfHc8=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBofhntAIhYW7Ru64HRSQ9tF2adBEFc8r1kE6pGt
 347ncirUmOJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaH4Z7QAKCRCIgE5vWV1S
 MkqAD/42Gtw753U89r020ZUpRSb79kQummDbxmfUUJvvn90m+3IqG1mqI8H5gupczDBp20+nQ27
 1oJUtqwIXXwY3b+MtgILXzRqLdbQ7oVqNe1OhCg9EDANnawA2iXMY/mWg9cgRNfId9KTpHj230k
 L9QvUTsePwfAjdDEPwDZB3DcwUnsDwf+Mynq8e2YOHEH84Qe9iec45JDjsUEQReSJFI/6f2JKeo
 5CEZgM0XuNSPFLalICab0r/v+EcA4ieOqdOPiGxdSv/iCNJIcb7NiYQhtkkh7313J3FbCyUGeD9
 li1pZ2une7hHLaJqyojwV0GpmrXAsbbigEW89IPZBWRrTiluhaI97NZwncr0Azeqo3LFaZZ15jJ
 BduqfJpR94GZH10fjIHdkO36CrU4AUylpmyc+w3qiqdDGU2EprLB2OnJ7svooEeoFMkDpPiwWj5
 wp2lrMZ8lu7NGTqzoADpjftq0wU1TxF88rXqDXQUEmozquylftG0pCApr51Xm1OAL3GVWgz5F8x
 wOaZsWp64k5D8tjapjh6rS9wfdOqgdKdfBO8gR0QVY1BHypYETHgRxGV9Rrl3qG7/gzV7UIKibX
 NFZVmIIF5pqxO9yy/6QaeXutdSEMjUF8iJ39EQNljRqUBdg6nvH4edqFPfgXBq3WJ+GyuF0UA9R
 fSNiPPs/c+bgF3w==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Convert XRGB8888 to 2bit grayscale.

It uses drm_fb_xrgb8888_to_gray8() to convert the pixels to gray8 as an
intermediate step before converting to gray2.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/gpu/drm/drm_format_helper.c | 108 ++++++++++++++++++++++++++++++++++++
 include/drm/drm_format_helper.h     |   4 ++
 2 files changed, 112 insertions(+)

diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index 8f3daf38ca639d3d39742c2c9fa0c54a3a9297a5..bfeaa4db6929859ea029192a868e6d42741b31f2 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -1253,6 +1253,25 @@ int drm_fb_blit(struct iosys_map *dst, const unsigned int *dst_pitch, uint32_t d
 }
 EXPORT_SYMBOL(drm_fb_blit);
 
+static void drm_fb_gray8_to_gray2_line(void *dbuf, const void *sbuf, unsigned int pixels)
+{
+	u8 *dbuf8 = dbuf;
+	const u8 *sbuf8 = sbuf;
+	u8 px;
+
+	while (pixels) {
+		unsigned int i, bits = min(pixels, 4U);
+		u8 byte = 0;
+
+		for (i = 0; i < bits; i++, pixels--) {
+			byte >>= 2;
+			px = (*sbuf8++ * 3 + 127) / 255;
+			byte |= (px &= 0x03) << 6;
+		}
+		*dbuf8++ = byte;
+	}
+}
+
 static void drm_fb_gray8_to_mono_line(void *dbuf, const void *sbuf, unsigned int pixels)
 {
 	u8 *dbuf8 = dbuf;
@@ -1359,3 +1378,92 @@ void drm_fb_xrgb8888_to_mono(struct iosys_map *dst, const unsigned int *dst_pitc
 	}
 }
 EXPORT_SYMBOL(drm_fb_xrgb8888_to_mono);
+
+/**
+ * drm_fb_xrgb8888_to_gray2 - Convert XRGB8888 to gray2
+ * @dst: Array of gray2 destination buffer
+ * @dst_pitch: Array of numbers of bytes between the start of two consecutive scanlines
+ *             within @dst; can be NULL if scanlines are stored next to each other.
+ * @src: Array of XRGB8888 source buffers
+ * @fb: DRM framebuffer
+ * @clip: Clip rectangle area to copy
+ * @state: Transform and conversion state
+ *
+ * This function copies parts of a framebuffer to display memory and converts the
+ * color format during the process. Destination and framebuffer formats must match. The
+ * parameters @dst, @dst_pitch and @src refer to arrays. Each array must have at
+ * least as many entries as there are planes in @fb's format. Each entry stores the
+ * value for the format's respective color plane at the same index.
+ *
+ * This function does not apply clipping on @dst (i.e. the destination is at the
+ * top-left corner). The first pixel (upper left corner of the clip rectangle) will
+ * be converted and copied to the two first bits (LSB) in the first byte of the gray2
+ * destination buffer. If the caller requires that the first pixel in a byte must
+ * be located at an x-coordinate that is a multiple of 8, then the caller must take
+ * care itself of supplying a suitable clip rectangle.
+ *
+ * DRM doesn't have native gray2 support. Drivers can use this function for
+ * gray2 devices that don't support XRGB8888 natively. Such drivers can
+ * announce the commonly supported XR24 format to userspace and use this function
+ * to convert to the native format.
+ *
+ */
+void drm_fb_xrgb8888_to_gray2(struct iosys_map *dst, const unsigned int *dst_pitch,
+			     const struct iosys_map *src, const struct drm_framebuffer *fb,
+			     const struct drm_rect *clip, struct drm_format_conv_state *state)
+{
+	static const unsigned int default_dst_pitch[DRM_FORMAT_MAX_PLANES] = {
+		0, 0, 0, 0
+	};
+	unsigned int linepixels = drm_rect_width(clip);
+	unsigned int lines = drm_rect_height(clip);
+	unsigned int cpp = fb->format->cpp[0];
+	unsigned int len_src32 = linepixels * cpp;
+	struct drm_device *dev = fb->dev;
+	void *vaddr = src[0].vaddr;
+	unsigned int dst_pitch_0;
+	unsigned int y;
+	u8 *gray2 = dst[0].vaddr, *gray8;
+	u32 *src32;
+
+	if (drm_WARN_ON(dev, fb->format->format != DRM_FORMAT_XRGB8888))
+		return;
+
+	if (!dst_pitch)
+		dst_pitch = default_dst_pitch;
+	dst_pitch_0 = dst_pitch[0];
+
+	/*
+	 * The gray2 destination buffer contains 2 bit per pixel
+	 */
+	if (!dst_pitch_0)
+		dst_pitch_0 = DIV_ROUND_UP(linepixels, 4);
+
+	/*
+	 * The dma memory is write-combined so reads are uncached.
+	 * Speed up by fetching one line at a time.
+	 *
+	 * Also, format conversion from XR24 to gray2 are done
+	 * line-by-line but are converted to 8-bit grayscale as an
+	 * intermediate step.
+	 *
+	 * Allocate a buffer to be used for both copying from the cma
+	 * memory and to store the intermediate grayscale line pixels.
+	 */
+	src32 = drm_format_conv_state_reserve(state, len_src32 + linepixels, GFP_KERNEL);
+	if (!src32)
+		return;
+
+	gray8 = (u8 *)src32 + len_src32;
+
+	vaddr += clip_offset(clip, fb->pitches[0], cpp);
+	for (y = 0; y < lines; y++) {
+		src32 = memcpy(src32, vaddr, len_src32);
+		drm_fb_xrgb8888_to_gray8_line(gray8, src32, linepixels);
+		drm_fb_gray8_to_gray2_line(gray2, gray8, linepixels);
+		vaddr += fb->pitches[0];
+		gray2 += dst_pitch_0;
+	}
+}
+EXPORT_SYMBOL(drm_fb_xrgb8888_to_gray2);
+
diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
index 562bc383ece4e90d96aa92b47b4f69609f825a6e..8488befafb7e0e0311f87bd2fef5011bab45065b 100644
--- a/include/drm/drm_format_helper.h
+++ b/include/drm/drm_format_helper.h
@@ -136,4 +136,8 @@ void drm_fb_xrgb8888_to_mono(struct iosys_map *dst, const unsigned int *dst_pitc
 			     const struct iosys_map *src, const struct drm_framebuffer *fb,
 			     const struct drm_rect *clip, struct drm_format_conv_state *state);
 
+void drm_fb_xrgb8888_to_gray2(struct iosys_map *dst, const unsigned int *dst_pitch,
+			     const struct iosys_map *src, const struct drm_framebuffer *fb,
+			     const struct drm_rect *clip, struct drm_format_conv_state *state);
+
 #endif /* __LINUX_DRM_FORMAT_HELPER_H */

-- 
2.49.0



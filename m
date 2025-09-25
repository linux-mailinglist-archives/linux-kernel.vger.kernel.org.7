Return-Path: <linux-kernel+bounces-832762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8ABFBA0532
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C885F5E5B55
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2F42EBB87;
	Thu, 25 Sep 2025 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSfAv0WM"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638692E0922
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758813463; cv=none; b=Mx3OhU3UfqqAFIFkiCZeimwiGZNOOUPvTOKlI3bGMngHT5JIA5awfYpebnnS0ZrsxMg9X6oPqXOt1x1d3+MhBdvJ6l02TVps1p5dXsNHZ+PvFwYzJAavWP0UtiybhtTDvRfj5hsODJse/FyUPXmGVRO2VREoVIUV6yQw7L3Wvbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758813463; c=relaxed/simple;
	bh=Cd+31InyjedttBn2jPLwH1b53yKe5Q/mKZB/CRG/JDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JY/n7dHkz7KZF1/Sxxh3stWozSdAaer617xIxInSk4nmmOekeZ9IjvSyqm7XiPyPWZOSiPZUR0mcZXh7QeK1lMHfArUER1i09RPNloZnJulPvkYGa7suDEvstc9VWk7nSSGHZ0U1+DTrD82o+dh5Ln0rfDGE+DJQ5PDafxd1RUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSfAv0WM; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-57d8ff3944dso1090703e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758813458; x=1759418258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8swc3KhKVsBZovpQQIlz8qOzKsdH3lFJ6rE9nIfvYyI=;
        b=nSfAv0WM12ZekDcMBXNvE6Xs3QcvKIZoFsXDHe6hfzUAOJQqtDW1inK5M9ppgZMvcX
         lnPxXMG0DBzXCaRpfCf57GZKL/nx9cTMSTdanKQ8IHhf90zXo0OILPN95rPxmNSL+HAO
         GAEl/LN2uVlck3tb4omnWnpSgaAw3R5e+NXHURdzxyxzfKa0mY8Q+g1kMcVxTqCEEByK
         tJjR/QXFfXxYRq5parxnSnuCY5WPjp6jHxbEr3QipC6OMQIfQVsavZ0Pf3GlnxKHh2gz
         F4Ohu0sEqpH6q0m7kOR2628DRaqwU4GAbAqtbyWP+uSP0X8/YIz73wqID6RoE9OasOfR
         HLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758813458; x=1759418258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8swc3KhKVsBZovpQQIlz8qOzKsdH3lFJ6rE9nIfvYyI=;
        b=ZDms8hYZS1B0iFCyXGkPmWgaUc+qNejKTGr6+d/3Srn7HCcBgIfnovBTn6Th2uu8vB
         vv7+gW2zuAM4I94eJue6bYrci8kX8WQvbdJLdQJ6NnIgaumEpIWTbYm7HlX+c4zBXk5k
         lJhfXUHOCm5ziaTLj578w8qxVH0LpDznH6Wcj6ABrM7KRQ5bHeiduQesvWxvqHVAQDN4
         TMZjqtA/PUlGlKa/VrWpKa01/xvJfgfC/NHjGq5RhNduSLq9HEn3eTDvPv5SZl4v0QOy
         qSDIhrtxZl/ZfyKzwsWVQ69tqUDfeCbkJGqO9bmyXCP8kzWXaEgDqw/6aitdr34RrrfF
         IAFA==
X-Forwarded-Encrypted: i=1; AJvYcCVPLZyDvaGOmNai0F9S6CxLGbmwdL/7cJGJj5lShjWKDsSWk0j2IbggMZFN029+zaNgvstcRiTdEH0vl30=@vger.kernel.org
X-Gm-Message-State: AOJu0YweSkc97CyhWbjgWLY86C7b3AebHG57qTJ3ssbmy6TXW4dSuPsD
	3OJsPtLAAJkcHFZEHuYEDN9RnpUI+mGH60dis+l9/qZ06ph1yluN++2e
X-Gm-Gg: ASbGnctHEDyQDKGSgGfQk9QRH0zrXXBeGWY4X/8sKU6r2Dwg5qprQVb5zhIXq0xciXR
	BQZ3usRSgIc/62H+rCPyKf6vLDYPiO0PsRYpNjbZrNYZe2f0t6wO75pSVIYl0bVZPwgRi6WObC4
	3fLFaAsgOdXMni3QenBEPertYDVNRq/wmDDDHO/gaItzJzH7WXBeRKsLztX2O1Vlh3szhmdnJ3W
	1M+jx9tnV2YsSksOfXrxK6vyCspCqG+y05CeVgbNBnfArzpAIy2+Bpt766O1xGSaN5Pbrpw05+v
	4IxRfsjseDm7YrJaljNzJ7vkR0KSC2TcGcwC1FNAjvjcI8RTP1mYzs0WCJ6gf1MCppGyBqAWeup
	nSx1Xr9jtgm1Ppg==
X-Google-Smtp-Source: AGHT+IGaPEzbqVLifBj6VMV1u7ov2ufzTFhND39AMWYuMrWlxeUCOc7nQIX5EVr4wX9P3chS0k2O3Q==
X-Received: by 2002:a05:6512:1328:b0:56b:1f30:6734 with SMTP id 2adb3069b0e04-582d41623d6mr1140908e87.54.1758813457759;
        Thu, 25 Sep 2025 08:17:37 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58313430496sm870084e87.27.2025.09.25.08.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 08:17:37 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
	Dmitry Osipenko <digetx@gmail.com>,
	Charan Pedumuru <charan.pedumuru@gmail.com>,
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
	Aaron Kling <webgeek1234@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v3 15/22] staging: media: tegra-video: tegra20: simplify format align calculations
Date: Thu, 25 Sep 2025 18:16:41 +0300
Message-ID: <20250925151648.79510-16-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250925151648.79510-1-clamor95@gmail.com>
References: <20250925151648.79510-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify format align calculations by slightly modifying supported formats
structure. Adjusted U and V offset calculations for planar formats since
YUV420P bits per pixel is 12 (1 full plane for Y + 2 * 1/4 planes for U
and V) so stride is width * 3/2, but offset must be calculated with plain
width since each plain has stride width * 1. This aligns with downstream
behavior which uses same approach for offset calculations.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/staging/media/tegra-video/tegra20.c | 58 +++++++++------------
 drivers/staging/media/tegra-video/vi.h      |  3 +-
 2 files changed, 27 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/media/tegra-video/tegra20.c b/drivers/staging/media/tegra-video/tegra20.c
index 7c3ff843235d..b7a39723dfc2 100644
--- a/drivers/staging/media/tegra-video/tegra20.c
+++ b/drivers/staging/media/tegra-video/tegra20.c
@@ -280,20 +280,8 @@ static void tegra20_fmt_align(struct v4l2_pix_format *pix, unsigned int bpp)
 	pix->width  = clamp(pix->width,  TEGRA20_MIN_WIDTH,  TEGRA20_MAX_WIDTH);
 	pix->height = clamp(pix->height, TEGRA20_MIN_HEIGHT, TEGRA20_MAX_HEIGHT);
 
-	switch (pix->pixelformat) {
-	case V4L2_PIX_FMT_UYVY:
-	case V4L2_PIX_FMT_VYUY:
-	case V4L2_PIX_FMT_YUYV:
-	case V4L2_PIX_FMT_YVYU:
-		pix->bytesperline = roundup(pix->width, 2) * 2;
-		pix->sizeimage = roundup(pix->width, 2) * 2 * pix->height;
-		break;
-	case V4L2_PIX_FMT_YUV420:
-	case V4L2_PIX_FMT_YVU420:
-		pix->bytesperline = roundup(pix->width, 8);
-		pix->sizeimage = roundup(pix->width, 8) * pix->height * 3 / 2;
-		break;
-	}
+	pix->bytesperline = DIV_ROUND_UP(pix->width * bpp, 8);
+	pix->sizeimage = pix->bytesperline * pix->height;
 }
 
 /*
@@ -305,6 +293,7 @@ static void tegra20_channel_queue_setup(struct tegra_vi_channel *chan)
 {
 	unsigned int stride = chan->format.bytesperline;
 	unsigned int height = chan->format.height;
+	unsigned int width = chan->format.width;
 
 	chan->start_offset = 0;
 
@@ -321,8 +310,8 @@ static void tegra20_channel_queue_setup(struct tegra_vi_channel *chan)
 
 	case V4L2_PIX_FMT_YUV420:
 	case V4L2_PIX_FMT_YVU420:
-		chan->addr_offset_u = stride * height;
-		chan->addr_offset_v = chan->addr_offset_u + stride * height / 4;
+		chan->addr_offset_u = width * height;
+		chan->addr_offset_v = chan->addr_offset_u + width * height / 4;
 
 		/* For YVU420, we swap the locations of the U and V planes. */
 		if (chan->format.pixelformat == V4L2_PIX_FMT_YVU420)
@@ -332,14 +321,14 @@ static void tegra20_channel_queue_setup(struct tegra_vi_channel *chan)
 		chan->start_offset_v = chan->addr_offset_v;
 
 		if (chan->vflip) {
-			chan->start_offset   += stride * (height - 1);
-			chan->start_offset_u += (stride / 2) * ((height / 2) - 1);
-			chan->start_offset_v += (stride / 2) * ((height / 2) - 1);
+			chan->start_offset   += width * (height - 1);
+			chan->start_offset_u += (width / 2) * ((height / 2) - 1);
+			chan->start_offset_v += (width / 2) * ((height / 2) - 1);
 		}
 		if (chan->hflip) {
-			chan->start_offset   += stride - 1;
-			chan->start_offset_u += (stride / 2) - 1;
-			chan->start_offset_v += (stride / 2) - 1;
+			chan->start_offset   += width - 1;
+			chan->start_offset_u += (width / 2) - 1;
+			chan->start_offset_v += (width / 2) - 1;
 		}
 		break;
 	}
@@ -576,20 +565,23 @@ static const struct tegra_vi_ops tegra20_vi_ops = {
 	.vi_stop_streaming = tegra20_vi_stop_streaming,
 };
 
-#define TEGRA20_VIDEO_FMT(MBUS_CODE, BPP, FOURCC)	\
-{							\
-	.code    = MEDIA_BUS_FMT_##MBUS_CODE,		\
-	.bpp     = BPP,					\
-	.fourcc  = V4L2_PIX_FMT_##FOURCC,		\
+#define TEGRA20_VIDEO_FMT(DATA_TYPE, BIT_WIDTH, MBUS_CODE, BPP, FOURCC)	\
+{									\
+	.img_dt		= TEGRA_IMAGE_DT_##DATA_TYPE,			\
+	.bit_width	= BIT_WIDTH,					\
+	.code		= MEDIA_BUS_FMT_##MBUS_CODE,			\
+	.bpp		= BPP,						\
+	.fourcc		= V4L2_PIX_FMT_##FOURCC,			\
 }
 
 static const struct tegra_video_format tegra20_video_formats[] = {
-	TEGRA20_VIDEO_FMT(UYVY8_2X8, 2, UYVY),
-	TEGRA20_VIDEO_FMT(VYUY8_2X8, 2, VYUY),
-	TEGRA20_VIDEO_FMT(YUYV8_2X8, 2, YUYV),
-	TEGRA20_VIDEO_FMT(YVYU8_2X8, 2, YVYU),
-	TEGRA20_VIDEO_FMT(UYVY8_2X8, 1, YUV420),
-	TEGRA20_VIDEO_FMT(UYVY8_2X8, 1, YVU420),
+	/* YUV422 */
+	TEGRA20_VIDEO_FMT(YUV422_8, 16, UYVY8_2X8, 16, UYVY),
+	TEGRA20_VIDEO_FMT(YUV422_8, 16, VYUY8_2X8, 16, VYUY),
+	TEGRA20_VIDEO_FMT(YUV422_8, 16, YUYV8_2X8, 16, YUYV),
+	TEGRA20_VIDEO_FMT(YUV422_8, 16, YVYU8_2X8, 16, YVYU),
+	TEGRA20_VIDEO_FMT(YUV422_8, 16, UYVY8_2X8, 12, YUV420),
+	TEGRA20_VIDEO_FMT(YUV422_8, 16, UYVY8_2X8, 12, YVU420),
 };
 
 const struct tegra_vi_soc tegra20_vi_soc = {
diff --git a/drivers/staging/media/tegra-video/vi.h b/drivers/staging/media/tegra-video/vi.h
index bfadde8858d4..5cbc0606ed6c 100644
--- a/drivers/staging/media/tegra-video/vi.h
+++ b/drivers/staging/media/tegra-video/vi.h
@@ -281,7 +281,8 @@ enum tegra_image_dt {
  * @img_dt: MIPI CSI-2 data type (for CSI-2 only)
  * @bit_width: format width in bits per component (for CSI/Tegra210 only)
  * @code: media bus format code
- * @bpp: bytes per pixel (when stored in memory)
+ * @bpp: bytes per pixel (when stored in memory) for Tegra210,
+ *	 bits per pixel for Tegra20/Tegra30
  * @img_fmt: image format (for CSI/Tegra210 only)
  * @fourcc: V4L2 pixel format FCC identifier
  */
-- 
2.48.1



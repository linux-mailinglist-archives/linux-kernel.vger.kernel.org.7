Return-Path: <linux-kernel+bounces-865213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FC1BFC810
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2C8E4E3E73
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9AD3557F2;
	Wed, 22 Oct 2025 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOsP/YlB"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28AE34FF5B
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761142920; cv=none; b=MmAc76i+a99RkLtwUPyYUzx4hv/+VBkeu3NkvvozUgmaPalOUULNQmZl3/wtYQh1zmUEVAcVhgUIGatKFEt+sMd7slTUo63jcazLBjs3bFh2RTRTUYHKoZXfIl2zkmskT/tQ+5qb+87+w+rvm2qM3Ud/nH3FtnXuBR49BJDC5To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761142920; c=relaxed/simple;
	bh=C7vJ1F7cTRJlUjfw/9ZIDrW99S3GCg1Ni6T3HWcAFl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DgFyXA6na7mhnV7MNIJk4sw4vg6dUAw5JoISQfTqatZtwfdnAT36S3sKOwm0smh2oG3gM9TWk3P5vIEtdYPuWvBpnYqW5KZu82xRdLDNZlhF7cS6RsrMMWgPqO6r57ZptE5ien2YZmOYfMSqrKmeA4DO7pFb8bUPHJJqQoS2Oow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOsP/YlB; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso6525411f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761142912; x=1761747712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWzzLwH6jgxXjmQF82SSMCUND+xg2EriGxgvFhDvOZc=;
        b=UOsP/YlBxcLxzT7YJFaMWyC3rqVK5bFppD6Ew11c3y1rs5Mb6tRZ7vwt2US0zXMOTB
         eWLe+25LOLGigl11FQNbDmtn/FKhgcyrlVtC/o8tri0Ij9LJDyL/WbS/qER/gO4k9Szx
         PQOzBuz+7HZKJ9M3R9FY2ogtp4jbA0wLs6W3T3T1fPs6kThFK00Xz8HBFu3TIIqojeVq
         9ihacOsZos+m/s8UZA9ykvTwwzMWLRLzjL2FJ1aKbFcMVRXsWzzC0GaKJtmUZCS28oGh
         z0vDCuT9eW3BI7iAASagYkC3V2AK3HWFWzo92n1V40lE6W5aUyp1NoEFD4lZiyDapT+Y
         o1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761142912; x=1761747712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWzzLwH6jgxXjmQF82SSMCUND+xg2EriGxgvFhDvOZc=;
        b=IOAn/MfBbe3aZkGyGCyUovAAMX/Y/slojzKmiE2s5JkS77ejnR6qleOomESfgvWHyP
         Nd9cRkRn2fREw5pwcNVbQx0cNNPRW5fP7YJkmoMZvQzR0k31EpSBQLO7qjJFJpK+qpr/
         TaMktvD2e0cSEYQoFrCQ2gf0GeG5JzfAzmBWUgr10Lp2UkEpDyr2+XTFRtZBNQGcwmT7
         KEJ7Iki8BW7mVBwmp2QcYO5XiWbepDK0+Mi8quf4eDq6EKPj2KgxY34joaFxukLe22Ix
         RiCeeaYos/C/H7Y5VDKLt6YclTVJLGpX33mbtqXufO/lYYKoP+anlMQKqdtaDkNoRA1H
         MuzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvDXwBkekbGoxgZjl3QhXR+XCos8OVz+Iw0hNNhSGkKxe+LhXpvOhU4ARF/D1qSjog3KfGh9niYMuX4yA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyIGkGkQYm30bygdAcemNtwVwdzdC/B+tJao8wkO1Hx0kGdFJS
	pltA5un6npOhULxUEAhkXkNx8rygMsQXuW7e9+CQ0iYRXaZEENOmdWGvCn971g==
X-Gm-Gg: ASbGncu7vitEb+w/szJz/gfn5JJj6xvJ2WdMmRo3VfMX3W8ATAPDV6rXtKXcXUOJ6uP
	OdvvyEKLREgig3Za/HbR5HcUf895n+mfZX2g1iFxfshHPnjcEZ9AO8WemmRKLkYwrCVg61PAkty
	xYVnAmp25S6Lq5bX8TL9gRXfkU7EY+L/S03XHDOQVDNCjXt5RKiidoG0awf8wm6j9yoAJiBbYqm
	Bv1CzK3XnUj+e0WO9Y2fF/FCq6aEkWxRVxEdo+0yuDZPZJqMJc1wUONY6mLMPOscePqVTvhtU8C
	GpI+jYToH7+ktaVLn2LiHibXrcYdG/tyPkjudfA2xSiQSE1VoRBy7gH1S/z2MUkOK7Tjqr1NIiQ
	thm/m+YpbpC9FmMMDzj2wsY2DG8Hf4iw02lZQjO/+RO+54OJ8zxTrVDiDErgEENz3gj4=
X-Google-Smtp-Source: AGHT+IFxEX5dT11epaReQydShPRaD3ap7YNMoGZ00ekJglzcEJYx4BxQ7S6YQXgiTMxPpQinmI9SWQ==
X-Received: by 2002:a05:6000:2087:b0:427:921:8985 with SMTP id ffacd0b85a97d-42709218a51mr12660456f8f.40.1761142911810;
        Wed, 22 Oct 2025 07:21:51 -0700 (PDT)
Received: from xeon.. ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3d4csm24803518f8f.19.2025.10.22.07.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 07:21:51 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
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
	linux-staging@lists.linux.dev
Subject: [PATCH v5 16/23] staging: media: tegra-video: tegra20: adjust format align calculations
Date: Wed, 22 Oct 2025 17:20:44 +0300
Message-ID: <20251022142051.70400-17-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251022142051.70400-1-clamor95@gmail.com>
References: <20251022142051.70400-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expand supported formats structure with data_type and bit_width fields
required for CSI support. Adjust tegra20_fmt_align by factoring out common
bytesperline and sizeimage calculation logic shared by supported planar
and non-planar formats and leaving planar-related correction under a
switch.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/staging/media/tegra-video/tegra20.c | 39 ++++++++++-----------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/media/tegra-video/tegra20.c b/drivers/staging/media/tegra-video/tegra20.c
index 7c3ff843235d..ffaaa2bb8269 100644
--- a/drivers/staging/media/tegra-video/tegra20.c
+++ b/drivers/staging/media/tegra-video/tegra20.c
@@ -280,18 +280,13 @@ static void tegra20_fmt_align(struct v4l2_pix_format *pix, unsigned int bpp)
 	pix->width  = clamp(pix->width,  TEGRA20_MIN_WIDTH,  TEGRA20_MAX_WIDTH);
 	pix->height = clamp(pix->height, TEGRA20_MIN_HEIGHT, TEGRA20_MAX_HEIGHT);
 
+	pix->bytesperline = roundup(pix->width, 8) * bpp;
+	pix->sizeimage = pix->bytesperline * pix->height;
+
 	switch (pix->pixelformat) {
-	case V4L2_PIX_FMT_UYVY:
-	case V4L2_PIX_FMT_VYUY:
-	case V4L2_PIX_FMT_YUYV:
-	case V4L2_PIX_FMT_YVYU:
-		pix->bytesperline = roundup(pix->width, 2) * 2;
-		pix->sizeimage = roundup(pix->width, 2) * 2 * pix->height;
-		break;
 	case V4L2_PIX_FMT_YUV420:
 	case V4L2_PIX_FMT_YVU420:
-		pix->bytesperline = roundup(pix->width, 8);
-		pix->sizeimage = roundup(pix->width, 8) * pix->height * 3 / 2;
+		pix->sizeimage = pix->sizeimage * 3 / 2;
 		break;
 	}
 }
@@ -576,20 +571,24 @@ static const struct tegra_vi_ops tegra20_vi_ops = {
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
+	TEGRA20_VIDEO_FMT(YUV422_8, 16, UYVY8_2X8, 2, UYVY),
+	TEGRA20_VIDEO_FMT(YUV422_8, 16, VYUY8_2X8, 2, VYUY),
+	TEGRA20_VIDEO_FMT(YUV422_8, 16, YUYV8_2X8, 2, YUYV),
+	TEGRA20_VIDEO_FMT(YUV422_8, 16, YVYU8_2X8, 2, YVYU),
+	/* YUV420P */
+	TEGRA20_VIDEO_FMT(YUV422_8, 16, UYVY8_2X8, 1, YUV420),
+	TEGRA20_VIDEO_FMT(YUV422_8, 16, UYVY8_2X8, 1, YVU420),
 };
 
 const struct tegra_vi_soc tegra20_vi_soc = {
-- 
2.48.1



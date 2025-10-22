Return-Path: <linux-kernel+bounces-865216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A8BBFC942
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 241FB6E4E8C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADB836996A;
	Wed, 22 Oct 2025 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmjLBf9h"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A5534C988
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761142926; cv=none; b=bt1qIlX6uYr8VuvPrMZx7i74hC8kBYtMHJalQkzcEP/+ftSPZC4kfG1UQgkEQe3ZRd2f1bfrLH8ZuINyIcnspDRACPT/o2ULdK7O51wZ3rHeHu4NOPIOlPod0EOvPZcj1zYmTbvdGnWcn7S5lh/26Db+WwVdYkiSJdKHGxwLa+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761142926; c=relaxed/simple;
	bh=HgP9VExlthvNBigzlv7uekYUM102sO9tWVmQkT6CmuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=spfIU/l9JRglgrPzKu1n3+CvAROn8D7/Guuwl6XfCwxNtM0o3C4W/acWq8NyKEtc23MdFDuzZ8Yjy3s9BCdtV/CJeDpl87YPRpeAc8UXF42IHBS3Q5O8Bt3BnSC1W7sMQTVYMDERhr62pJgbHRowQI1nnmbc6B43w60HYPfsmTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmjLBf9h; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so8897462f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761142917; x=1761747717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9Z7JUaghezQ8iAuA7uRKlyBeeVsFfzYhFmFiduOSBE=;
        b=bmjLBf9hiPvAuwU5ddSZJ8xDKsES0sSh9uilv9ZV41XtijUNp2D8ETmE0eKW9OpGuz
         JXxYO49F7ePNJ6NFbeQ0Fegw+rkFo9xPWxwtSvN/6MkgE2I4y/Fo706S0yRK7aY4CO31
         QA8DLaA/YCoojU9N5ZGIXT2iGqUF6pHJMEMtATyc7GknMR+NJl9P7AWjziKHE1mZ3X6Y
         UJQVa6V/ZigqZo6DhnAbFAS5PW38l8NdgjuohYN0d0rh6Zz3ljhBXxrXvyHXmIDUkiHr
         BwZ+W64FXCnxnzU7UaD1uRvcUwrtJmI/q8piM7pMxTIKuL9OfJxS7jSNAJop9A5BsoaW
         /vPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761142917; x=1761747717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9Z7JUaghezQ8iAuA7uRKlyBeeVsFfzYhFmFiduOSBE=;
        b=B+Lg6qRlXo8LA+up3CfbKMpHHnemqwhrT0qKc53B8MsPIb9iUuhE3cn1RFzy/WIBch
         E8pIEKE/+N0lsYfv17dL4/1FjB3BSlcDfWFaaFA1YPwChUCTrxCjK3CN432Rc1rtmgLV
         qEzMzoqVHcqoq4TwFcr+aTsz8iDO9q55AIzvpmqEGV9r+zqzBpE7gSPHBs2fqzalqsi8
         ZscY+0MkVYDka4KYBcrRy3SjY/s5bmqAYOjyMJkMohwh4kqf4fiCWU7CrGRhrnoZ9OQG
         5nHgTZ6XVJShN8kzcyaQSWnWb1MSvBjij9MnpL7Sp3pgz3Z5XG+PG9A42nh+m20d9ngM
         Ef1g==
X-Forwarded-Encrypted: i=1; AJvYcCXEWpqqXnoJcZA2+WY3pzm4aMV7cpDeX5jyY5ReBAwp6E3qbPNeqpqS5dpXWcu2mDFoBb3rYDjpMETdSMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoCw/pt7HkZCsE1uRlkSzhS7vf1MKv1nQDVG7rLGjZZNek1ln/
	I/nTJvKwYY7/sLfagbyhD7P6Jcvjh6MIRa4kyYDbHb2bFxG3mhoV7QSs
X-Gm-Gg: ASbGncturPrgdosNb47FnswYLvAtwjS7eBMlXWPzdYy/sK2102uYaICb6zSKykP4zjS
	EooW2HWYX9eF6bVbvnLpDWsubQScabh+lIttIs2LCC3L3a5NdnAIAZK4CUw908GMuLqPYQ2j7u0
	PobSeCEomCM2rC1guEi26THmpdrn2qn231aLPt/lthJLgttd7Y00FEt4etdMJ+18sT4WIK9mf9m
	GUli+gkOHfCDQQgYyKovYOrn9W5/JsOZFUR4GwvmcX27gphFzJvzE1sYNzI0NE98Hp1HH8Ibv9Z
	86sz/MH41g9kR4JFF9UiXSmyO1uHuZr2uurFmHuVkyBFzzFOF9bsG2c9OE40QhGgbYCZ+NgmB/4
	yY0r8uNyLXkiiERzkNbEwFNSxSy8quu3IWOpC8L7KM1fmCqGsMA40m22begfto0D9EkE=
X-Google-Smtp-Source: AGHT+IHmpX8C5GwwN840U1BRTmU2Ck9ZgwySDSvkE0UdWgQieuzkLZOsrvn9s/zYLJBdiD8e4LeWyQ==
X-Received: by 2002:a05:6000:1ac5:b0:3ee:141a:ede5 with SMTP id ffacd0b85a97d-42704dc6d3cmr12760428f8f.57.1761142917015;
        Wed, 22 Oct 2025 07:21:57 -0700 (PDT)
Received: from xeon.. ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3d4csm24803518f8f.19.2025.10.22.07.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 07:21:56 -0700 (PDT)
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
Subject: [PATCH v5 19/23] staging: media: tegra-video: tegra20: expand format support with RAW8/10 and YUV422/YUV420p 1X16
Date: Wed, 22 Oct 2025 17:20:47 +0300
Message-ID: <20251022142051.70400-20-clamor95@gmail.com>
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

Add support for Bayer formats (RAW8 and RAW10) and YUV422/420p 1X16
versions of existing YUV422/YUV420p 2X8.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/staging/media/tegra-video/tegra20.c | 74 ++++++++++++++++++++-
 1 file changed, 71 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/tegra-video/tegra20.c b/drivers/staging/media/tegra-video/tegra20.c
index 149386a15176..0457209b789a 100644
--- a/drivers/staging/media/tegra-video/tegra20.c
+++ b/drivers/staging/media/tegra-video/tegra20.c
@@ -187,6 +187,18 @@ static void tegra20_vi_get_input_formats(struct tegra_vi_channel *chan,
 	case MEDIA_BUS_FMT_YVYU8_2X8:
 		(*yuv_input_format) = VI_INPUT_YUV_INPUT_FORMAT_YVYU;
 		break;
+	/* RAW8 */
+	case MEDIA_BUS_FMT_SBGGR8_1X8:
+	case MEDIA_BUS_FMT_SGBRG8_1X8:
+	case MEDIA_BUS_FMT_SGRBG8_1X8:
+	case MEDIA_BUS_FMT_SRGGB8_1X8:
+	/* RAW10 */
+	case MEDIA_BUS_FMT_SBGGR10_1X10:
+	case MEDIA_BUS_FMT_SGBRG10_1X10:
+	case MEDIA_BUS_FMT_SGRBG10_1X10:
+	case MEDIA_BUS_FMT_SRGGB10_1X10:
+		(*main_input_format) = VI_INPUT_INPUT_FORMAT_BAYER;
+		break;
 	}
 }
 
@@ -221,6 +233,18 @@ static void tegra20_vi_get_output_formats(struct tegra_vi_channel *chan,
 	case V4L2_PIX_FMT_YVU420:
 		(*main_output_format) = VI_OUTPUT_OUTPUT_FORMAT_YUV420PLANAR;
 		break;
+	/* RAW8 */
+	case V4L2_PIX_FMT_SBGGR8:
+	case V4L2_PIX_FMT_SGBRG8:
+	case V4L2_PIX_FMT_SGRBG8:
+	case V4L2_PIX_FMT_SRGGB8:
+	/* RAW10 */
+	case V4L2_PIX_FMT_SBGGR10:
+	case V4L2_PIX_FMT_SGBRG10:
+	case V4L2_PIX_FMT_SGRBG10:
+	case V4L2_PIX_FMT_SRGGB10:
+		(*main_output_format) = VI_OUTPUT_OUTPUT_FORMAT_VIP_BAYER_DIRECT;
+		break;
 	}
 }
 
@@ -308,6 +332,16 @@ static void tegra20_channel_queue_setup(struct tegra_vi_channel *chan)
 	case V4L2_PIX_FMT_VYUY:
 	case V4L2_PIX_FMT_YUYV:
 	case V4L2_PIX_FMT_YVYU:
+	/* RAW8 */
+	case V4L2_PIX_FMT_SRGGB8:
+	case V4L2_PIX_FMT_SGRBG8:
+	case V4L2_PIX_FMT_SGBRG8:
+	case V4L2_PIX_FMT_SBGGR8:
+	/* RAW10 */
+	case V4L2_PIX_FMT_SRGGB10:
+	case V4L2_PIX_FMT_SGRBG10:
+	case V4L2_PIX_FMT_SGBRG10:
+	case V4L2_PIX_FMT_SBGGR10:
 		if (chan->vflip)
 			chan->start_offset += stride * (height - 1);
 		if (chan->hflip)
@@ -373,6 +407,19 @@ static void tegra20_channel_vi_buffer_setup(struct tegra_vi_channel *chan,
 		tegra20_vi_write(chan, TEGRA_VI_VB0_BASE_ADDRESS(TEGRA_VI_OUT_1),  base);
 		tegra20_vi_write(chan, TEGRA_VI_VB0_START_ADDRESS(TEGRA_VI_OUT_1), base + chan->start_offset);
 		break;
+	/* RAW8 */
+	case V4L2_PIX_FMT_SRGGB8:
+	case V4L2_PIX_FMT_SGRBG8:
+	case V4L2_PIX_FMT_SGBRG8:
+	case V4L2_PIX_FMT_SBGGR8:
+	/* RAW10 */
+	case V4L2_PIX_FMT_SRGGB10:
+	case V4L2_PIX_FMT_SGRBG10:
+	case V4L2_PIX_FMT_SGBRG10:
+	case V4L2_PIX_FMT_SBGGR10:
+		tegra20_vi_write(chan, TEGRA_VI_VB0_BASE_ADDRESS(TEGRA_VI_OUT_2),  base);
+		tegra20_vi_write(chan, TEGRA_VI_VB0_START_ADDRESS(TEGRA_VI_OUT_2), base + chan->start_offset);
+		break;
 	}
 }
 
@@ -454,12 +501,15 @@ static int tegra20_chan_capture_kthread_start(void *data)
 static void tegra20_camera_capture_setup(struct tegra_vi_channel *chan)
 {
 	u32 output_fourcc = chan->format.pixelformat;
+	u32 data_type = chan->fmtinfo->img_dt;
 	int width  = chan->format.width;
 	int height = chan->format.height;
 	int stride_l = chan->format.bytesperline;
 	int stride_c = (output_fourcc == V4L2_PIX_FMT_YUV420 ||
 			output_fourcc == V4L2_PIX_FMT_YVU420) ? 1 : 0;
-	enum tegra_vi_out output_channel = TEGRA_VI_OUT_1;
+	enum tegra_vi_out output_channel = (data_type == TEGRA_IMAGE_DT_RAW8 ||
+					    data_type == TEGRA_IMAGE_DT_RAW10) ?
+					    TEGRA_VI_OUT_2 : TEGRA_VI_OUT_1;
 	int main_output_format;
 	int yuv_output_format;
 
@@ -586,9 +636,25 @@ static const struct tegra_video_format tegra20_video_formats[] = {
 	TEGRA20_VIDEO_FMT(YUV422_8, 16, VYUY8_2X8, 2, VYUY),
 	TEGRA20_VIDEO_FMT(YUV422_8, 16, YUYV8_2X8, 2, YUYV),
 	TEGRA20_VIDEO_FMT(YUV422_8, 16, YVYU8_2X8, 2, YVYU),
+	TEGRA20_VIDEO_FMT(YUV422_8, 16, UYVY8_1X16, 2, UYVY),
+	TEGRA20_VIDEO_FMT(YUV422_8, 16, VYUY8_1X16, 2, VYUY),
+	TEGRA20_VIDEO_FMT(YUV422_8, 16, YUYV8_1X16, 2, YUYV),
+	TEGRA20_VIDEO_FMT(YUV422_8, 16, YVYU8_1X16, 2, YVYU),
 	/* YUV420P */
 	TEGRA20_VIDEO_FMT(YUV422_8, 16, UYVY8_2X8, 1, YUV420),
 	TEGRA20_VIDEO_FMT(YUV422_8, 16, UYVY8_2X8, 1, YVU420),
+	TEGRA20_VIDEO_FMT(YUV422_8, 16, UYVY8_1X16, 1, YUV420),
+	TEGRA20_VIDEO_FMT(YUV422_8, 16, UYVY8_1X16, 1, YVU420),
+	/* RAW 8 */
+	TEGRA20_VIDEO_FMT(RAW8, 8, SRGGB8_1X8, 2, SRGGB8),
+	TEGRA20_VIDEO_FMT(RAW8, 8, SGRBG8_1X8, 2, SGRBG8),
+	TEGRA20_VIDEO_FMT(RAW8, 8, SGBRG8_1X8, 2, SGBRG8),
+	TEGRA20_VIDEO_FMT(RAW8, 8, SBGGR8_1X8, 2, SBGGR8),
+	/* RAW 10 */
+	TEGRA20_VIDEO_FMT(RAW10, 10, SRGGB10_1X10, 2, SRGGB10),
+	TEGRA20_VIDEO_FMT(RAW10, 10, SGRBG10_1X10, 2, SGRBG10),
+	TEGRA20_VIDEO_FMT(RAW10, 10, SGBRG10_1X10, 2, SGBRG10),
+	TEGRA20_VIDEO_FMT(RAW10, 10, SBGGR10_1X10, 2, SBGGR10),
 };
 
 const struct tegra_vi_soc tegra20_vi_soc = {
@@ -615,10 +681,12 @@ const struct tegra_vi_soc tegra20_vi_soc = {
 static int tegra20_vip_start_streaming(struct tegra_vip_channel *vip_chan)
 {
 	struct tegra_vi_channel *vi_chan = v4l2_get_subdev_hostdata(&vip_chan->subdev);
+	u32 data_type = vi_chan->fmtinfo->img_dt;
 	int width  = vi_chan->format.width;
 	int height = vi_chan->format.height;
-	enum tegra_vi_out output_channel = TEGRA_VI_OUT_1;
-
+	enum tegra_vi_out output_channel = (data_type == TEGRA_IMAGE_DT_RAW8 ||
+					    data_type == TEGRA_IMAGE_DT_RAW10) ?
+					    TEGRA_VI_OUT_2 : TEGRA_VI_OUT_1;
 	unsigned int main_input_format;
 	unsigned int yuv_input_format;
 
-- 
2.48.1



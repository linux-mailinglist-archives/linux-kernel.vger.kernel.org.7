Return-Path: <linux-kernel+bounces-882302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4B1C2A1F3
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 06:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10403ADC72
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 05:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E1328D8DB;
	Mon,  3 Nov 2025 05:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmUV17Rm"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD60285CAE
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 05:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762149444; cv=none; b=EMKoZ0ox2lYfA7DEZ8Ik/I8TLLHA8Hnk0OZpCzzkJ6PLU4vI+WLAJ8pQjVjY9ZuHdnb/a55+CfShXUP4jAEWQtDe4vVfTuEfEpNLTSainO+DTfCGiulFM71H4ifT/IcqT4uBhc+9oKIw66PVwfpiYRnFQvH9GiFHDW7HMX+mF0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762149444; c=relaxed/simple;
	bh=MQV8jD27ZG+yZve5+9joqOYFG9IDBUKao+l7F/BRtLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QuOvIaW5xRWxzSdNmvDkK8CZARCN2W1QKx34ZvhX6UwScuuogE224TMpfnnjLIdOjvJryVcEDMkobHuhxvbOup1nVTyDPjStzi4WjFce8hTjN2B+Fwg9UPmxoI2Rr2ckK3yCzKybTNy9YCePmLyiDiWPvIyTGAFmtGMVZcBlxYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmUV17Rm; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29470bc80ceso43981215ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 21:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762149442; x=1762754242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cGP4x/41RYIg15mQcXh3AwtklkR1Te1lPQnjCYwhFmM=;
        b=NmUV17RmAW8NlDQC0Tg18rVoqYMw9cahXBNnb86pYKrEwR0h+H0vPnrA6oksyMjqQs
         syMs6KPkP4+yRRTp6PWh8Nw8ivtN32Dgl42YczDGXQQGpCoCS1Z2wGfXDddNjvvhdfUg
         AiEWlYs5Ynym3gHo3v33TTEPyYr1Et+MEGhQ/QBdqDwrq37pWnM8+GYCJlSfUDBdSzEd
         b2duJ8p1b1+183vnpwHun2eyt2fSARidnNWc8zvWAn3Pp8obMAlXDNveB67sVPC6J76z
         wqEg35+ySauigJvx69/UbuGRqhL9zrvuHyZs9Q2Qs1bmRmJ0pXY0drgg5XmAHRgbQxo4
         LQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762149442; x=1762754242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cGP4x/41RYIg15mQcXh3AwtklkR1Te1lPQnjCYwhFmM=;
        b=lSuytse7m65F7vGbGumRoVYLjP2JwUly/QLdb1OJe5WplNh8veL0bbpiNMS8hP5de+
         fP8qjBoPCIvJ5vXxZsFM8p0BjrJKbb+uxCWc91fBiWsq0e5tquOh6LrrOtX0/u6wWTFb
         mEeza3En/lrTEu2bCBobErprDuCCc7VedR/GQcFw2c2aXxjsJ0WGNIznf+2KfuYh/jJH
         zfkG/b8fRTZRJyPdR/4bsKNozpqQfxtriwUtt0M/z1eND3MXtVuTuWCwmkr0nPgHWaXt
         6WH0YN0GbA05gOJFohczP/WMow4iGs140x42W6+0ry+55DbTD4dG9LwfkKVVRHZvEVOB
         QgLw==
X-Forwarded-Encrypted: i=1; AJvYcCWmlURQsI0BJ1w/f87HukhWfvtXwfWCAa5AQpxwpGhU1Vca/tXCuElZHMq7QtUzY+9Xx5F/bNE3pa7wvoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxADT96p8gTytZI0IiV33DFwAMBMv2Wcdv30NU4DnCJH6zsmLHP
	YCsTo+fzYwnWIhtn0cFVfwDYoDUgZhmIfJ/aatahehh0Usray3rLlKhC
X-Gm-Gg: ASbGncsLoF0Lc8CkS7OrWYLky4r6KUUysoAak2ZGEHkvwaDZVwnJ3sfXDSdWvN7Txfz
	2/srY3yjS9xdnO0NzcOc/6nmhwqOF06lmJIgCrMSNxOzDd0wxK9Yx0kDH45Q42JvX1IfEBvMEF3
	577XdgszPtVsP20X+STRBu0nnuETohOE8mp0j4SgZwZ3AGGVJAFFt2BAUAkzZ98SFg+7IyiR+Cs
	7PpqIjPHcldPlhb6Nk1qg85QKu1q9pcCpscvMN+aE0TRdesgGek1ZVvBaTtNhBFhMxdsHfb5nBD
	KmxxI8q93tS9znOVTAquygLmjLkjqRf+4BZjfQr7MfjW6SmWapKSC3Af2UUzeGbYq4FG7QA6Dy1
	UA/qwv5Qs5u0tgseeley5whmDP4ZJ7dSXswBkIW8lN5bjXUnBM3uTSWgoMT7/H46yO5Yz9Rn/GZ
	TDNGN4Y/0zpRxWoDsgPiPV70GORwCalWwOBekulxLEmiwo5zXOkY72B5t4QxWQVATvcSc56JQi5
	rT96qJkhvdimw8=
X-Google-Smtp-Source: AGHT+IH1lBFIhyJby/nizHMzTdE7QLj8MvERYVwOXJceUEvmMI5EfyCVP73jaq2qIMw9B4K/+LD0mQ==
X-Received: by 2002:a17:902:d4ce:b0:295:6b98:6d65 with SMTP id d9443c01a7336-2956b986f84mr71412435ad.22.1762149441675;
        Sun, 02 Nov 2025 21:57:21 -0800 (PST)
Received: from opensource206.. ([106.222.234.180])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29577d90896sm51830755ad.34.2025.11.02.21.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 21:57:21 -0800 (PST)
From: Pavan Bobba <opensource206@gmail.com>
To: skhan@linuxfoundation.org,
	kieran.bingham@ideasonboard.com,
	mchehab@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH] media: vimc: debayer: add support for multiple RGB formats
Date: Mon,  3 Nov 2025 11:27:16 +0530
Message-ID: <20251103055716.29537-1-opensource206@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enhance the vimc debayer subdevice to support multiple RGB output
formats and improve its format negotiation behavior.

This patch introduces the following changes:
 - Adds ARGB8888_1X32 to the list of supported source pad mbus codes.
 - Allows userspace to select any valid RGB code on the source pad
   through set_fmt().
 - Propagates width, height, and field settings from sink to source
   while preserving the selected RGB code.
 - Sets appropriate default colorimetry for RGB output (sRGB, full-range).
 - Updates vimc_debayer_process_rgb_frame() to handle RGB24, BGR24,
   and ARGB32 pixel formats with proper channel ordering and alpha fill.
 - Adds debug and warning logs for invalid or unsupported formats.

These changes make the virtual debayer pipeline more flexible and
realistic for testing RGB/ARGB camera capture paths.

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 .../media/test-drivers/vimc/vimc-debayer.c    | 113 ++++++++++++++----
 1 file changed, 90 insertions(+), 23 deletions(-)

diff --git a/drivers/media/test-drivers/vimc/vimc-debayer.c b/drivers/media/test-drivers/vimc/vimc-debayer.c
index bbb7c7a86df0..0fa1cb8d3be1 100644
--- a/drivers/media/test-drivers/vimc/vimc-debayer.c
+++ b/drivers/media/test-drivers/vimc/vimc-debayer.c
@@ -15,9 +15,6 @@
 
 #include "vimc-common.h"
 
-/* TODO: Add support for more output formats, we only support RGB888 for now. */
-#define VIMC_DEBAYER_SOURCE_MBUS_FMT	MEDIA_BUS_FMT_RGB888_1X24
-
 enum vimc_debayer_rgb_colors {
 	VIMC_DEBAYER_RED = 0,
 	VIMC_DEBAYER_GREEN = 1,
@@ -73,6 +70,7 @@ static const u32 vimc_debayer_src_mbus_codes[] = {
 	MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
 	MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA,
 	MEDIA_BUS_FMT_RGB888_1X32_PADHI,
+	MEDIA_BUS_FMT_ARGB8888_1X32,
 };
 
 static const struct vimc_debayer_pix_map vimc_debayer_pix_map_list[] = {
@@ -170,7 +168,7 @@ static int vimc_debayer_init_state(struct v4l2_subdev *sd,
 
 	mf = v4l2_subdev_state_get_format(sd_state, 1);
 	*mf = sink_fmt_default;
-	mf->code = VIMC_DEBAYER_SOURCE_MBUS_FMT;
+	mf->code = vimc_debayer_src_mbus_codes[0];
 
 	return 0;
 }
@@ -239,6 +237,14 @@ static void vimc_debayer_adjust_sink_fmt(struct v4l2_mbus_framefmt *fmt)
 	vimc_colorimetry_clamp(fmt);
 }
 
+static void vimc_debayer_set_rgb_mbus_fmt_default(struct v4l2_mbus_framefmt *fmt)
+{
+	fmt->colorspace = V4L2_COLORSPACE_SRGB;
+	fmt->quantization = V4L2_QUANTIZATION_FULL_RANGE;
+	fmt->xfer_func = V4L2_XFER_FUNC_SRGB;
+	fmt->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
+}
+
 static int vimc_debayer_set_fmt(struct v4l2_subdev *sd,
 				struct v4l2_subdev_state *sd_state,
 				struct v4l2_subdev_format *fmt)
@@ -250,12 +256,30 @@ static int vimc_debayer_set_fmt(struct v4l2_subdev *sd,
 	if (fmt->which == V4L2_SUBDEV_FORMAT_ACTIVE && vdebayer->src_frame)
 		return -EBUSY;
 
-	/*
-	 * Do not change the format of the source pad, it is propagated from
-	 * the sink.
-	 */
-	if (VIMC_IS_SRC(fmt->pad))
-		return v4l2_subdev_get_fmt(sd, sd_state, fmt);
+	if (VIMC_IS_SRC(fmt->pad)) {
+		struct v4l2_mbus_framefmt *source_fmt;
+		struct v4l2_mbus_framefmt *sink_fmt;
+
+		/* Validate the requested source format */
+		if (!vimc_debayer_src_code_is_valid(fmt->format.code))
+			return -EINVAL;
+
+		/* Get current formats */
+		source_fmt = v4l2_subdev_state_get_format(sd_state, 1);
+		sink_fmt = v4l2_subdev_state_get_format(sd_state, 0);
+
+		/* Update source format with appropriate properties for RGB output */
+		source_fmt->code = fmt->format.code;
+		source_fmt->width = sink_fmt->width;   /* Size should match */
+		source_fmt->height = sink_fmt->height; /* Size should match */
+		source_fmt->field = sink_fmt->field;   /* Field handling should match */
+
+		/* Set appropriate colorimetry for RGB output */
+		vimc_debayer_set_rgb_mbus_fmt_default(source_fmt);
+
+		fmt->format = *source_fmt;
+		return 0;
+	}
 
 	/* Set the new format in the sink pad. */
 	vimc_debayer_adjust_sink_fmt(&fmt->format);
@@ -278,8 +302,25 @@ static int vimc_debayer_set_fmt(struct v4l2_subdev *sd,
 
 	/* Propagate the format to the source pad. */
 	format = v4l2_subdev_state_get_format(sd_state, 1);
-	*format = fmt->format;
-	format->code = VIMC_DEBAYER_SOURCE_MBUS_FMT;
+
+	/* Propagate size and field from sink, but maintain source code */
+	format->width = fmt->format.width;
+	format->height = fmt->format.height;
+	format->field = fmt->format.field;
+
+	/*
+	 * Source code should always be valid (set during init or via set_fmt).
+	 * If somehow it's not, this is a bug - log warning and fix it.
+	 */
+	if (!vimc_debayer_src_code_is_valid(format->code)) {
+		dev_warn(vdebayer->ved.dev,
+			 "%s: Invalid source code 0x%x, resetting to default\n",
+			 vdebayer->sd.name, format->code);
+		format->code = vimc_debayer_src_mbus_codes[0];
+	}
+
+	/* Set appropriate colorimetry for RGB output */
+	vimc_debayer_set_rgb_mbus_fmt_default(format);
 
 	return 0;
 }
@@ -297,19 +338,45 @@ static void vimc_debayer_process_rgb_frame(struct vimc_debayer_device *vdebayer,
 					   unsigned int rgb[3])
 {
 	const struct vimc_pix_map *vpix;
-	unsigned int i, index;
+	unsigned int index;
 
 	vpix = vimc_pix_map_by_code(vdebayer->hw.src_code);
-	index = VIMC_FRAME_INDEX(lin, col, vdebayer->hw.size.width, 3);
-	for (i = 0; i < 3; i++) {
-		switch (vpix->pixelformat) {
-		case V4L2_PIX_FMT_RGB24:
-			vdebayer->src_frame[index + i] = rgb[i];
-			break;
-		case V4L2_PIX_FMT_BGR24:
-			vdebayer->src_frame[index + i] = rgb[2 - i];
-			break;
-		}
+	if (!vpix) {
+		dev_dbg(vdebayer->ved.dev, "Invalid source code: 0x%x\n",
+			vdebayer->hw.src_code);
+		return;
+	}
+
+	index = VIMC_FRAME_INDEX(lin, col, vdebayer->hw.size.width, vpix->bpp);
+
+	switch (vpix->pixelformat) {
+	case V4L2_PIX_FMT_RGB24:
+		/* RGB24: R-G-B */
+		vdebayer->src_frame[index + 0] = rgb[0]; /* Red */
+		vdebayer->src_frame[index + 1] = rgb[1]; /* Green */
+		vdebayer->src_frame[index + 2] = rgb[2]; /* Blue */
+		break;
+
+	case V4L2_PIX_FMT_BGR24:
+		/* BGR24: B-G-R */
+		vdebayer->src_frame[index + 0] = rgb[2]; /* Blue */
+		vdebayer->src_frame[index + 1] = rgb[1]; /* Green */
+		vdebayer->src_frame[index + 2] = rgb[0]; /* Red */
+		break;
+
+	case V4L2_PIX_FMT_ARGB32:
+		/* ARGB32: A-R-G-B (set alpha to 255) */
+		vdebayer->src_frame[index + 0] = 255;    /* Alpha */
+		vdebayer->src_frame[index + 1] = rgb[0]; /* Red */
+		vdebayer->src_frame[index + 2] = rgb[1]; /* Green */
+		vdebayer->src_frame[index + 3] = rgb[2]; /* Blue */
+		break;
+
+	default:
+		dev_dbg(vdebayer->ved.dev,
+			"Unsupported pixel format for debayer: 0x%x\n",
+			vpix->pixelformat);
+		break;
 	}
 }
 
-- 
2.43.0



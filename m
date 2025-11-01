Return-Path: <linux-kernel+bounces-881140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E64C278CE
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 07:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86E814E4A65
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 06:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB105286889;
	Sat,  1 Nov 2025 06:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTC1AX5F"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA5C1D5147
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 06:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761978801; cv=none; b=DRkCaWmNko0VH3lK4+63LySaE97bOLnWlucRiR63u8zDrL59dDiZOBMjpb/kf5ogcUGa4JrK7hUyEVH8HP79gmypnyPiR4/gKpx4FqtJyB2XKQJYVmIv1XU7iXooyOs+aSFgzEHv7Ch/OqUC76m93S1SL1UK0PXEptAHr0X/bMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761978801; c=relaxed/simple;
	bh=+zQAd6/Lx4XwBMrDDvVeD3K00OAGTAt0KqKDT/5MdBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=heJnaz6SGVazA15U5u+4SD76wvkcA6sugRGv2m7Q1VydH6rbVsbLuSx2d9le5DUK3xwglPRzAdA3YALnLVjapQIRA0jOCPZ3Er4rP37fmCH0x+5mUdBgROMnCrfwCCZp3D9QhH/6wcLhdduZ7yPFa51VVfvYOC7xCh2p97qKA8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTC1AX5F; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-780fc3b181aso2118994b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 23:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761978799; x=1762583599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=csSbJcLFM5L2vu2gw+h6Q2d5cAu19xceBRmAiyL/H8Q=;
        b=iTC1AX5FnaDqv+ALdsPkxgMavndxVUMntm/8197M3jIznZwfsKboaw1TUR4FPrB5eu
         I36BZefitP8w+Q4F7dJvwKt/rlUcTRVk9xWQTjvwtntypOReymr+NPKR5TNtiC/VJcgD
         ZwV054SprZDQ2Myy1/hCVwKTliP1bzNoReGChJlayGAWk6v5nXI+yyCkMwWtZLUmk93c
         4oJ3LzLdKMQVbXu/xPcg758yk96TnagfCJ3AEsgOAledRyl1tNvsBZ9R1QYC69MXw1VR
         9yLMvlYZ+wSufdQWQo8fCYDLEGK7AWqI2BOAurcM+t3lDCD2Q3WQoFRp+uM97CVTCkNh
         IdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761978799; x=1762583599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=csSbJcLFM5L2vu2gw+h6Q2d5cAu19xceBRmAiyL/H8Q=;
        b=mmqU7Z7v0Z/rKUXIv5f0Jh/Ul6ctMs215u/72IxxAFsD53NxPMY+qYcc+avwNwuG15
         rtOwD6bJ2WHAHQbdI1SqA548BZy7//QvjX7T1EKdd7NSA/ulgScBYPRIuy4+tRXiYkU1
         iFiqqKWE7rBrMxn+J+Zx5x2YaVaA5UcbHKW39v3rrY/pUq+LQcear7Nwv1yCgo/sIOod
         4HSqNr8tRlkUqgoFukYLQXo+s3Ca8AAAGaHVSqYSUvWjDQH7gZPFB81BvOF5hwkjcYKw
         n+WKqTVLGiiwyx/y7RXeSWG6vtbY21LTCEVHyg5C6okf5MJTDkBv+/0ah9DAnPm7y9Ru
         KaCg==
X-Forwarded-Encrypted: i=1; AJvYcCW3n2TUEwHu32jPUIQ6rpuymDZFxkkNGKVFgH0gJDKBc+C7IaysTw6uUabmB/6xm7IAND703G33A48kQXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt/DysR2yoYr2ZX9snqNWwDNEwYXxn0iNN4Nn8av6bd7wQGE29
	ve+dtBQDoptfB0+AtP+UaA+3lplATPqmV4+okngg74BHaWNCheHibGlXYZcMjA==
X-Gm-Gg: ASbGncvHBRCuctOwPhIhAerMGXQ3WaeTaw05vPLR0FrOwd2wLFBAh16+bAOyW88ftys
	lzVMHF+Jbwje+dcg2fssJXY3SoCxMO8TMa41aj5eIlVmLu01+1qlcsuC8pRbAem76ZQ1+Ukb/41
	uKuk9mi2vgH6vZsRLBbexAjxTkAxOVSuMb8ZRf86PspGpC+nXT7eVePH+ugTs+bf6abT9GSsUht
	547+WBBYdcyulsE0fBB/uaZfibsUniNIHIHgficpOzkRd5oJydObrYJrTtk7P5pyW0rIPHd0Al1
	x4h6/RLDSlXMv7U+mV9/j7MeIlUo2n/9iO2A+rGdXbwuY2bWCGvFnUJLEqJ/gVO01LBq0MBgv68
	YmbRWJF3940t8EYvKRipsQ1Pa36dkFLxDlxuRnok3fNmUz6bGKpVC7Bc0WsIdjxYraqTodzt5nj
	vgoqjULclcWyovX00TO+IHkJEBW9XpgH+HvpcdqfLIfOEOEWxy/NVvKuiBxwF6xeC7mPzcOg26S
	AD8Oal91oN+JtybHatyKiDdtQ==
X-Google-Smtp-Source: AGHT+IF/YXEAtCeyA+uL076BR8IeQ9W6hQvJB4WrGBw6+wROOWrzFmGWzsApi83flVhRhFyvZoFKhQ==
X-Received: by 2002:a05:6300:2189:b0:342:b918:b475 with SMTP id adf61e73a8af0-348ca5653aemr9055088637.21.1761978799150;
        Fri, 31 Oct 2025 23:33:19 -0700 (PDT)
Received: from opensource206.. ([106.222.234.180])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93be4045fbsm4041381a12.28.2025.10.31.23.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 23:33:18 -0700 (PDT)
From: Pavan Bobba <opensource206@gmail.com>
To: skhan@linuxfoundation.org,
	kieran.bingham@ideasonboard.com,
	mchehab@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH] media: vimc: add support for V4L2_FIELD_ALTERNATE in vimc-sensor
Date: Sat,  1 Nov 2025 12:03:12 +0530
Message-ID: <20251101063312.13466-1-opensource206@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vimc sensor currently ignores V4L2_FIELD_ALTERNATE and always
configures the test pattern generator (TPG) with a progressive field.
This patch adds basic handling for the ALTERNATE field type.

When userspace requests V4L2_FIELD_ALTERNATE, the TPG is configured
to output alternating top and bottom fields by calling tpg_s_field()
with the interlaced flag set. For all other field types, existing
progressive behaviour is preserved.

This change allows the vimc-sensor subdevice to correctly reflect
the requested field type in its reported format, enabling basic
testing of interlaced-field negotiation in the media pipeline.
Other vimc entities (debayer, scaler, capture) still treat all
streams as progressive, so streaming with ALTERNATE may not yet
succeed.

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 drivers/media/test-drivers/vimc/vimc-sensor.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/media/test-drivers/vimc/vimc-sensor.c b/drivers/media/test-drivers/vimc/vimc-sensor.c
index 027767777763..900c3f329f1c 100644
--- a/drivers/media/test-drivers/vimc/vimc-sensor.c
+++ b/drivers/media/test-drivers/vimc/vimc-sensor.c
@@ -105,8 +105,10 @@ static void vimc_sensor_tpg_s_format(struct vimc_sensor_device *vsensor,
 	tpg_s_bytesperline(&vsensor->tpg, 0, format->width * vpix->bpp);
 	tpg_s_buf_height(&vsensor->tpg, format->height);
 	tpg_s_fourcc(&vsensor->tpg, vpix->pixelformat);
-	/* TODO: add support for V4L2_FIELD_ALTERNATE */
-	tpg_s_field(&vsensor->tpg, format->field, false);
+	if (format->field == V4L2_FIELD_ALTERNATE)
+		tpg_s_field(&vsensor->tpg, V4L2_FIELD_TOP, true);
+	else
+		tpg_s_field(&vsensor->tpg, format->field, false);
 	tpg_s_colorspace(&vsensor->tpg, format->colorspace);
 	tpg_s_ycbcr_enc(&vsensor->tpg, format->ycbcr_enc);
 	tpg_s_quantization(&vsensor->tpg, format->quantization);
@@ -127,8 +129,7 @@ static void vimc_sensor_adjust_fmt(struct v4l2_mbus_framefmt *fmt)
 	fmt->height = clamp_t(u32, fmt->height, VIMC_FRAME_MIN_HEIGHT,
 			      VIMC_FRAME_MAX_HEIGHT) & ~1;
 
-	/* TODO: add support for V4L2_FIELD_ALTERNATE */
-	if (fmt->field == V4L2_FIELD_ANY || fmt->field == V4L2_FIELD_ALTERNATE)
+	if (fmt->field == V4L2_FIELD_ANY)
 		fmt->field = fmt_default.field;
 
 	vimc_colorimetry_clamp(fmt);
-- 
2.43.0



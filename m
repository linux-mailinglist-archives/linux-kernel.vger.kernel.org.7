Return-Path: <linux-kernel+bounces-882324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1F0C2A30A
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 07:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 514E74EB4F5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 06:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11BA22A4F1;
	Mon,  3 Nov 2025 06:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaQODxYY"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD617EEA8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 06:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762151434; cv=none; b=rEo8JTnqfco6Ssmqp8SeEXOSx6D2gnzb9wQZhHVnUW0/+9Ga3kbhROaE93rZp5nGSOjFaOS4hkw5s9VO20OYaTlw4eJ/SFrvHdeZAZ32XDo2m1dh0fdZw1daxxlzOOJxsHqxYnu4D2s419ZJnfkGqXBIbV7oEn35WE7nhh0f71k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762151434; c=relaxed/simple;
	bh=q9U2/lglyvUZ+6SzKjNSNlDwmEjWmsKN97d6E/pOIIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TqtOwQ6DrwTWchqV9yFVJt5PpaA4ptfqJGXw6nX31ft4iIPcT6ZOKJcDxw55Esoic0YtCeD0eV5ghbjdqB/jZa5UD6pjJXC5Opf1MTkNXtfPxPolRs/mQObuLbphlKlmhLH79tBnksn61jlUU0Pgy0HGhEB+wHg1UN0O1jDkGn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaQODxYY; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so3983341b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 22:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762151432; x=1762756232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n7GOu69hsNGmnIy0MHORKTrtvDnS7Wvg9FFJEsAiMq0=;
        b=GaQODxYYmJhe7UP+0MMsBGc3nF/Sn54ltQ0g0/ZJm0QfbGet+yw+XPYvK+XQFr6koM
         w+xMuiiwmC9qqsqNWkJ+cW9WlljOSLVJWgT8E3cL01VcWdUkqq3Z5sMT1AyVzMHjPeYk
         yvaVxUi2kKUsK0DkTiWk8Pz4hzKEQKyoQ5N47PwTC8MnV8OOmGsLfVMi1krAWHJG0SFv
         zvtNZeXhOGDvcrMcah6ma/HryEjRHwWPy6q19GeXGRluO1zyX0x92v5f6guyUMDP32w3
         zmHuP7g8br+XMyePhgu5yDyCDKFLXrJQRGI6TGTZRQwgplam2X6fuNKjE1USGt2Zp3k4
         FiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762151432; x=1762756232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n7GOu69hsNGmnIy0MHORKTrtvDnS7Wvg9FFJEsAiMq0=;
        b=fu/6C0+g1pwjihRTxqRKipRBSRSN0Dc31qweNY43LWbutCnUKus0OKheEEyQIXJ19R
         HKaM8/DBOkeYKi/PzpzdVszC+hRhmt32rfCrlGaEbhMmNdbt7QgAduOZHhwA51N45lNx
         xeKQXNkrzWzLeGyyYyTjnzLgw7SVWKnwlG4hSBg7QB1PzhD4jCt5Wxlm0QN708rftbRc
         6PYIBnzTJJWjvQramM4972URddC058qouH17xXxc6KeGl7aMj3EhNZNvgTtRZn3jzzmf
         w2gNDjv6quCuKB2ASx1Ihl7/FbjM7TglUwUPz7xap6wvro6DFwAsyoj7Lhy0j8iJ6CLA
         GbSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDUvUGlIs6tQC98QhRBsffs2dgbFNszQlMuKOb0Gnz+KS/DNapI7/t7DIzAW6EnYtlQWq57LOh7wzIzWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4tzfj8dZk0VhnXfZbPcdu9IkR2n+E25ft0R0LEjZ0ERYXz1G8
	3IE8nNfci7cQQ4gOi7RRNPs7jVOBlruQBFQcuhfJLoEtSLjWFJnr+sIp
X-Gm-Gg: ASbGnctOMFZ+nzubRAYOcCZ9DYijPuqAe9uE5FyFHcu50yaDKOaNguHTHQI4B1bJzWd
	i1ccaM0RfIV/uzliTcohqYwAKt26KiEdDHq35YoUibEMKcG5btFwlp8cnRvklo9FOmSqsnAJ6lz
	SM19JhCucypjz7Jf33X+uLkbiFBd8mxGgxgHoYgfZdZL+MFYiNDeLykW4nV5usKoghZ60U78mXz
	t+SXRe8emGFIqWklK4PpMBWf6FF3iHvnES0OqV7PeIfehiQoEoK+Rjt0nfHnbTyCLR9qOUoGgVW
	KL8vy1EufChrb5iTi9pUYnZEEvi6kXImK5E/TSRDc3EuQVu2cIbX2QreryWuwZVZoX4C0/VimQu
	L4jkMK2xBkQLg5TQYiGfOMxuylAO6AYM937hiUihAFy/kuwwHhit9FsPyZGtmsXFzZWcAzVaYki
	G66NFZv2TZeARaUyBxJrhSShDZNMyJjz22appbmkLa0kgUGdRORfCiFHfNvFBkRn/v54Tjgt7DC
	4jtSzPXKygyb7I=
X-Google-Smtp-Source: AGHT+IH8JSZYoTXiwFVK51/reIB6Nmxi0ztVqfUYR2UVDlC40mTO06fpWw0pvOd2IY7E3YIpGwSnRg==
X-Received: by 2002:a05:6a00:26c2:b0:7a9:acdf:e8f8 with SMTP id d2e1a72fcca58-7a9acdfee6fmr4765880b3a.4.1762151432018;
        Sun, 02 Nov 2025 22:30:32 -0800 (PST)
Received: from opensource206.. ([106.222.234.180])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ab30909fccsm2143549b3a.20.2025.11.02.22.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 22:30:31 -0800 (PST)
From: Pavan Bobba <opensource206@gmail.com>
To: skhan@linuxfoundation.org,
	kieran.bingham@ideasonboard.com,
	mchehab@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH] media: vimc: capture: support custom bytesperline values
Date: Mon,  3 Nov 2025 12:00:27 +0530
Message-ID: <20251103063027.31858-1-opensource206@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow userspace to request custom bytesperline (stride) values in the
vimc capture driver. The driver now clamps the requested value to a
valid range instead of forcing a fixed stride.

The minimum bytesperline is width * bytes_per_pixel, while the maximum
is limited by VIMC_FRAME_MAX_WIDTH * bytes_per_pixel. This makes the
virtual capture node behave more like real hardware that supports
aligned or padded scanlines.

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 drivers/media/test-drivers/vimc/vimc-capture.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/media/test-drivers/vimc/vimc-capture.c b/drivers/media/test-drivers/vimc/vimc-capture.c
index 7f6124025fc9..7164ec51eb80 100644
--- a/drivers/media/test-drivers/vimc/vimc-capture.c
+++ b/drivers/media/test-drivers/vimc/vimc-capture.c
@@ -85,6 +85,7 @@ static int vimc_capture_try_fmt_vid_cap(struct file *file, void *priv,
 {
 	struct v4l2_pix_format *format = &f->fmt.pix;
 	const struct vimc_pix_map *vpix;
+	u32 min_bpl, max_bpl;
 
 	format->width = clamp_t(u32, format->width, VIMC_FRAME_MIN_WIDTH,
 				VIMC_FRAME_MAX_WIDTH) & ~1;
@@ -97,8 +98,18 @@ static int vimc_capture_try_fmt_vid_cap(struct file *file, void *priv,
 		format->pixelformat = fmt_default.pixelformat;
 		vpix = vimc_pix_map_by_pixelformat(format->pixelformat);
 	}
-	/* TODO: Add support for custom bytesperline values */
-	format->bytesperline = format->width * vpix->bpp;
+
+	/* Calculate the minimum supported bytesperline value */
+	min_bpl = format->width * vpix->bpp;
+	/* Calculate the maximum supported bytesperline value */
+	max_bpl = VIMC_FRAME_MAX_WIDTH * vpix->bpp;
+
+	/* Clamp bytesperline to the valid range */
+	if (format->bytesperline > max_bpl)
+		format->bytesperline = max_bpl;
+	if (format->bytesperline < min_bpl)
+		format->bytesperline = min_bpl;
+
 	format->sizeimage = format->bytesperline * format->height;
 
 	if (format->field == V4L2_FIELD_ANY)
-- 
2.43.0



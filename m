Return-Path: <linux-kernel+bounces-744119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB14B10830
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D0C5A5E0C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933FD26A1B5;
	Thu, 24 Jul 2025 10:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSkOqPO4"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B65269CE6
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753354419; cv=none; b=L6ZZzOlp2+FOTWD+rVgsy7/DAjRnONMk4vnlivwL1v9LQe2JHlLOkbtAaRLTbP+CCQOVRu6nC1Ol1lM2/f/S55HmVV4lOCIut204nZ/Pbnv0rUcT8LIQ+FDhT4q4zMnBfqgoYbIwUG6EH8ae0bx+BnDlhaLYzcvCY9C/pdt1Q08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753354419; c=relaxed/simple;
	bh=Tknhp7etPYm0nFHjJ4hG5r6ADArSuOu7zTH+gboPamw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qn1lR650Zt8PxLKU+fRMlSEg1uluEuqhRq5fah9x2Gf3KejnD14YNxU86SewJdJWLK/tZDnYDno4GHh6IeEzjwsZ5i7pXun/BfOBmXlHceBJx8IaTvpslzxIwOFsh6Qyw2SDvssZIvDA8/n6FAwGKRcaiSoyaICNk/D4B2mKBDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSkOqPO4; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-311da0bef4aso831559a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 03:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753354418; x=1753959218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GiVGo6WrTbyzr1LDaIIUbkcnMnGG+Ed2yLDLSxUCvKk=;
        b=ZSkOqPO4yqSUCq/DcQpcNmvgDTdAyX8DAlo7Dzx90FBc5Q4xXBFlQjMjPF4otuXqlP
         1uM38FT2XaFN5osXYJSpKPRbpxBZNR4AirKiRUXFoTolVmNVsDOT4Atc08VbIXxRw/HA
         aCBMRX2mifW8Ekazq2228GGeB4Tzz6QZa3FKPD53NIxC7QKUlhHHNqM5c+rmb/ZWmLgn
         d2rhsDj1gEzqkJRpmBC46i/Z8owbnVVvdCGKNyxbG9fgxQgrixP5p3u/akwQYTFWi3pv
         veXGks9kq1s0LADy3KAVBF/tsdBa66tfMbpjXiy4KPqCyEVvprGIHP/NBKwfjgJzo6ub
         z0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753354418; x=1753959218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GiVGo6WrTbyzr1LDaIIUbkcnMnGG+Ed2yLDLSxUCvKk=;
        b=ts4mIx4u0rkI+QHEMwh8NHTRnCgmIVq5P1F6cn6xouEBU6EE3dYzSfp5kCo7+GdDKf
         e0Fb/lBecsipKYtHP0e8DlFU4vFtW+jSyHwTW3nBjVVcS4w1/qtd5e8b5xQmSsPFzOmc
         s88LOqYgiMbqkYK7D1n1AaTA4vYaL9Y/5IanS0J6oG28XOU+5cqSTXn6TEAtGL2UAP9c
         2rLCW+c7Kh++1k9SGtbL/IOFFZkV6SJ1CwG/Ub1Vfjo8N8jAa/Vc2dhhNnLERxxL9ihE
         YQY5UcN5iQs8/0eB1zcjqgPlc9ggdGINHvdkEHobVZALCOS0K/sqANkr3prJLQf7CoWV
         pOwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhpSrw2423Uc9ohpjj3AbU3mGn4MMuSfd+HAEb1bznzt3gRQDk9PneMOCcm+OWgGbM+54OuejI9c4F3Rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLmjg30/ynT2P+fy4xysheXp9sB2tXdiIwP4UFgl/MosJSZAJI
	TrgZEsd/7AJy14A8NeUeS+CCkywihbne0Caal589cxYRv/cdUlKFhBNK
X-Gm-Gg: ASbGnct8QaqDVro/IAPNEct7jt5G9Mq/voVMI1lGQ4ZQHyYVDioyqszyS2YMkAc3Y5v
	fWtVSAvJMpctXfpGOI1CaES8X0zuCHiOUA6/yGXY5q1nK/wY6We8j33h4JvUSE7L8ORamrxWltC
	xUDQoG6W6q5qJ8kVjV+VgzWHCCgwBH23Gxu/PHs6geN1aQsNaKnbuOJx7TOMN43EX+hlfOjqYAd
	wHlC0MlN8u4Bav15ta5J9+YpAbUCTH7LNZVH2QjNBXFs03CIGAd7w0hTYV79yfKZJ+eM1v2HDEG
	TBSNo2cuxuBJbI2EpEvG/tBwgm5GvHn4Z1pTx7IHMoHd+v8SLGLm/F/fP6k0It4A7XGpeVKTw7H
	6BSn2lwpBUX5W0AYOn0LBYVt0R4nGKgdWl9okMXIRp2O5jMESAQ==
X-Google-Smtp-Source: AGHT+IEDvLkch4Zgu8rPt919rhZOgH5TfZIeXUeAZKMyLZZgb+itbWw5nMGp/pzx1vJ6nTDXuGapfQ==
X-Received: by 2002:a17:90b:280e:b0:311:f684:d3cd with SMTP id 98e67ed59e1d1-31e5073683emr10512710a91.12.1753354417583;
        Thu, 24 Jul 2025 03:53:37 -0700 (PDT)
Received: from samiksha-Latitude-E6440.. ([106.213.81.205])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e6639f93esm1108066a91.39.2025.07.24.03.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 03:53:37 -0700 (PDT)
From: samiksha.palav27@gmail.com
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	shdwcodr <samiksha.palav27@gmail.com>
Subject: [PATCH] staging: sm750fb: Add hardware acceleration for 16bpp imageblit
Date: Thu, 24 Jul 2025 16:22:08 +0530
Message-ID: <20250724105254.3926-2-samiksha.palav27@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: shdwcodr <samiksha.palav27@gmail.com>

This is my first kernel patch, as mentioned in my kernel introduction.
I'm starting out with drivers/staging, and this patch targets the
sm750fb driver.

Previously, all image depths other than 1 fell back to cfb_imageblit().
This patch adds support for hardware-accelerated blitting for 16bpp
images using sm750_hw_imageblit().

The fallback path for other depths remains unchanged, with a TODO
comment in place for future enhancements.

Signed-off-by: shdwcodr <samiksha.palav27@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 53 +++++++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 1d929aca399c..e65b747fbfd0 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -121,12 +121,12 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 	sm750_hw_cursor_disable(cursor);
 	if (fbcursor->set & FB_CUR_SETSIZE)
 		sm750_hw_cursor_set_size(cursor,
-					fbcursor->image.width,
+					 fbcursor->image.width,
 					fbcursor->image.height);
 
 	if (fbcursor->set & FB_CUR_SETPOS)
 		sm750_hw_cursor_set_pos(cursor,
-				       fbcursor->image.dx - info->var.xoffset,
+					fbcursor->image.dx - info->var.xoffset,
 				       fbcursor->image.dy - info->var.yoffset);
 
 	if (fbcursor->set & FB_CUR_SETCMAP) {
@@ -249,10 +249,51 @@ static void lynxfb_ops_imageblit(struct fb_info *info,
 	pitch = info->fix.line_length;
 	Bpp = info->var.bits_per_pixel >> 3;
 
-	/* TODO: Implement hardware acceleration for image->depth > 1 */
-	if (image->depth != 1) {
-		cfb_imageblit(info, image);
-		return;
+	static void write_pixel(struct fb_info *info, int x, int y, u32 color)
+
+	{
+		u32 location;
+		u8 *fb_ptr = (u8 *)info->screen_base;
+
+		location = (y * info->fix.line_length) + (x * (info->var.bits_per_pixel / 8));
+
+		if (info->var.bits_per_pixel == 16) {
+			u16 c = ((color >> 8) & 0xF800) |
+				((color >> 5) & 0x07E0) |
+				((color >> 3) & 0x001F); // Convert 24-bit RGB to RGB565
+			*((u16 *)(fb_ptr + location)) = c;
+		} else if (info->var.bits_per_pixel == 32) {
+			*((u32 *)(fb_ptr + location)) = color;
+		}
+	}
+
+	void sm750fb_imageblit(struct fb_info *info, const struct fb_image *image)
+
+	{
+		/*
+		 * TODO: Add hardware-accelerated support for more image depths
+		 * Currently only 16-bit (RGB565) images are handled in fast path.
+		 */
+		if (image->depth != 16) {
+			cfb_imageblit(info, image);
+			return;
+		}
+
+		/* Accelerated rendering for 16-bit (RGB565) images */
+		const u16 *src = (const u16 *)image->data;
+
+		u32 fg_color = ((image->fg_color & 0xF800) << 8) |
+			       ((image->fg_color & 0x07E0) << 5) |
+			       ((image->fg_color & 0x001F) << 3); // RGB565 → RGB888
+
+		for (int j = 0; j < image->height; j++) {
+			for (int i = 0; i < image->width; i++) {
+				u16 pixel = src[j * image->width + i];
+
+				if (pixel) // Draw only non-zero (foreground) pixels
+					write_pixel(info, image->dx + i, image->dy + j, fg_color);
+			}
+		}
 	}
 
 	if (info->fix.visual == FB_VISUAL_TRUECOLOR ||
-- 
2.43.0



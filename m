Return-Path: <linux-kernel+bounces-732703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E70B06AF4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 02:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BECA17F73E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF1B21D585;
	Wed, 16 Jul 2025 00:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1EDEzSa"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2497721CA04
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 00:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752627366; cv=none; b=fZEwMgj2qs723gZAti7/ryswC3ZJ5ZvnVz/OiZ+wCC1gxgO0PbX3BRkkVkJYKZ7j1HB2ZVZeMZONay+FQ2lmfjxRe2eiJOv8YAC+VI+rHmzyq5Sil9YUgOiCIEoC2D9FIhm0TUr+jMPBiMBepJgaN9a3conX0qeqG7h+63gYem4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752627366; c=relaxed/simple;
	bh=EmmzgkVB7k8qEfWpf38+xKgwFpjcfTTpniiW5vyi0bg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CCxATX+PBcYtOpIrbkfGCeYFzyOpE9+6sXmzUcBJ4n1/hos983w7pTmj87653/Cym1wqwlcctel9EVm2YiX5TUbQ+2VvN4NOZEYtzaUtrtBPdL6nsl+jlpcvRs2eAEuV/32qgZ3DmF5im2fypCXVeX+jLypJ0NW2ByiiHco6Um0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1EDEzSa; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-73e4a448370so1341799a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 17:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752627364; x=1753232164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQCsspFtp3aJ1IuBIDFYtYNze/nuPurknN4UsanwySM=;
        b=d1EDEzSam4tCHRTbUQ7K/VL2LoLUEkh9s1DB9KaOUJpboAkloXaEi/fmkNyYxaA6Cc
         3JLaEatUogTilYjEY7Q74KL9AY+TP+U6eqfyZr3u2yXF1omXyzmYWJlouwYkHOTk8SAG
         yi/gPbqe8TFKu+clu61fb5h+9yw57Rm+ROM2uy6Ju4NUXLOxj5l36byCu9BFmIcuLNLV
         D3B+Nm2LJWsl18G5UB0nGNYDn8xGrBPtantfFRmHJvdPGxEvIKNzJaxpsdfXEnxorSAq
         FtK7UeNEIIauo3WLts+iijM/z0OEvhxBWnJyfDYUpZ3TVrPtL9zq+zZVe/mATwejche7
         Rlew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752627364; x=1753232164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQCsspFtp3aJ1IuBIDFYtYNze/nuPurknN4UsanwySM=;
        b=dM2/GZD7j/KsxImNv7/rsFeHqllmmrZ3ANcg3DZ1V/Sr593peGGZj2i8iVrdeM6liy
         TD6BNh82dAwcVtrqvFesQJHjsKQlAV+qsCHNLUjaXZ5CgWRlTbSJwUAW8oOGh0RLHb5c
         LWeUU8sHHLb3xk2T2ZjoY0YVrALhAI6Mp1zeLsHEsW5zUISpUG6ruWalc07JHLR+9qeN
         l2dCn4XhZWro38lYKgIw2xLzrkbMAwWr6GU00yxOERxlTZkZFxWFsJKbar/L4rn4em6u
         7vYMb+MQpTGMFROKX4lgX5+aDAlm5AXF2ziHMEnqsdIWzU2rp2bWtVj5jla3QjscMpOJ
         AA9g==
X-Forwarded-Encrypted: i=1; AJvYcCWv9RmGUVeHlDKTxxMu17s3wlAGw2IozAp4Ru/kXknok/jBFx/6vwkjQoJRs7F5cvTcxXRkqbxEtcXGMS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSZ3ujHDR7LRQmmqxnrKS6ILxcV/qIcuYQzQPBs33zVjfpKr8B
	tsHdi6zENn/9OHaVhHhgDE1SfgmLbhQIg50RNRPIbwLT9ECSV/ROc9Sl
X-Gm-Gg: ASbGncuCuEOnvhwlIc+gDOzQZkJtIVVdPE5hAinM+VnIsEQkKYsSAFT62p8DWJFYbvN
	lzj3AeIF2dIYKXUqnRrEz3os3tFF610Mq+45rQqC7blJ6qQvF4P1iBfnEXcRlNTiNd5Td+Uqb9x
	IFlShzJ5kLbQRuaANLRMAk5GGSoUkJ5iAa1j6Qh7rkpktbtmDuDVjylKDYaZ/9Qlm1XbB6YalvQ
	gwcaKPcYO3YjiIpX+cKL/ECvMW9j3jBo7jZHJv9MwryEaGwrYdG+CaVavlkWMX7mjrAbM1WDf65
	P/uT8TLdKbe46eue3oF8dUuyxbwyFFgbOvCcXmYhfZ8F9ZZF/6mUjxIpY1X+o6qJa9fWWfgW7Sk
	uoaMsGG+Ha2QY0Wudt4Go+DjAnRJi2cM4KkOY7gONxGcNcNcGVm/M
X-Google-Smtp-Source: AGHT+IETyTSobPkwH83OPqixRGjz/UNSynFtFOv06uXpLjjGXOB10TZv1bKbTzz/6C7be2D1OpRT/g==
X-Received: by 2002:a05:6830:f8a:b0:72b:9d2d:804 with SMTP id 46e09a7af769-73e64b4d42bmr1189795a34.26.1752627364117;
        Tue, 15 Jul 2025 17:56:04 -0700 (PDT)
Received: from localhost.localdomain ([181.161.11.224])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e56024edasm1035047a34.34.2025.07.15.17.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 17:56:03 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: dan.carpenter@linaro.org
Cc: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
Subject: [PATCH 3/3] staging: sm750fb: Fix CamelCase variable naming
Date: Tue, 15 Jul 2025 20:55:53 -0400
Message-Id: <20250716005553.52369-4-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250716005553.52369-1-ignacio.pena87@gmail.com>
References: <20250716005553.52369-1-ignacio.pena87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable 'Bpp' to 'bpp' to fix checkpatch.pl warnings about
CamelCase variable names. Use lowercase naming convention for
local variables.
---
 drivers/staging/sm750fb/sm750.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index a896227ef..f36ad8324 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -160,7 +160,7 @@ static void lynxfb_ops_fillrect(struct fb_info *info,
 {
 	struct lynxfb_par *par;
 	struct sm750_dev *sm750_dev;
-	unsigned int base, pitch, Bpp, rop;
+	unsigned int base, pitch, bpp, rop;
 	u32 color;
 
 	if (info->state != FBINFO_STATE_RUNNING)
@@ -175,9 +175,9 @@ static void lynxfb_ops_fillrect(struct fb_info *info,
 	 */
 	base = par->crtc.o_screen;
 	pitch = info->fix.line_length;
-	Bpp = info->var.bits_per_pixel >> 3;
+	bpp = info->var.bits_per_pixel >> 3;
 
-	color = (Bpp == 1) ? region->color :
+	color = (bpp == 1) ? region->color :
 		((u32 *)info->pseudo_palette)[region->color];
 	rop = (region->rop != ROP_COPY) ? HW_ROP2_XOR : HW_ROP2_COPY;
 
@@ -190,7 +190,7 @@ static void lynxfb_ops_fillrect(struct fb_info *info,
 	spin_lock(&sm750_dev->slock);
 
 	sm750_dev->accel.de_fillrect(&sm750_dev->accel,
-				     base, pitch, Bpp,
+				     base, pitch, bpp,
 				     region->dx, region->dy,
 				     region->width, region->height,
 				     color, rop);
@@ -202,7 +202,7 @@ static void lynxfb_ops_copyarea(struct fb_info *info,
 {
 	struct lynxfb_par *par;
 	struct sm750_dev *sm750_dev;
-	unsigned int base, pitch, Bpp;
+	unsigned int base, pitch, bpp;
 
 	par = info->par;
 	sm750_dev = par->dev;
@@ -213,7 +213,7 @@ static void lynxfb_ops_copyarea(struct fb_info *info,
 	 */
 	base = par->crtc.o_screen;
 	pitch = info->fix.line_length;
-	Bpp = info->var.bits_per_pixel >> 3;
+	bpp = info->var.bits_per_pixel >> 3;
 
 	/*
 	 * If not use spin_lock, system will die if user load driver
@@ -225,7 +225,7 @@ static void lynxfb_ops_copyarea(struct fb_info *info,
 
 	sm750_dev->accel.de_copyarea(&sm750_dev->accel,
 				     base, pitch, region->sx, region->sy,
-				     base, pitch, Bpp, region->dx, region->dy,
+				     base, pitch, bpp, region->dx, region->dy,
 				     region->width, region->height,
 				     HW_ROP2_COPY);
 	spin_unlock(&sm750_dev->slock);
@@ -234,7 +234,7 @@ static void lynxfb_ops_copyarea(struct fb_info *info,
 static void lynxfb_ops_imageblit(struct fb_info *info,
 				 const struct fb_image *image)
 {
-	unsigned int base, pitch, Bpp;
+	unsigned int base, pitch, bpp;
 	unsigned int fgcol, bgcol;
 	struct lynxfb_par *par;
 	struct sm750_dev *sm750_dev;
@@ -247,7 +247,7 @@ static void lynxfb_ops_imageblit(struct fb_info *info,
 	 */
 	base = par->crtc.o_screen;
 	pitch = info->fix.line_length;
-	Bpp = info->var.bits_per_pixel >> 3;
+	bpp = info->var.bits_per_pixel >> 3;
 
 	/* TODO: Implement hardware acceleration for image->depth > 1 */
 	if (image->depth != 1) {
@@ -274,7 +274,7 @@ static void lynxfb_ops_imageblit(struct fb_info *info,
 
 	sm750_dev->accel.de_imageblit(&sm750_dev->accel,
 				      image->data, image->width >> 3, 0,
-				      base, pitch, Bpp,
+				      base, pitch, bpp,
 				      image->dx, image->dy,
 				      image->width, image->height,
 				      fgcol, bgcol, HW_ROP2_COPY);
-- 
2.39.5 (Apple Git-154)



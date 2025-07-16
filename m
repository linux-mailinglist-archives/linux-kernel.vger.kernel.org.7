Return-Path: <linux-kernel+bounces-732816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863D7B06C5B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 05:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF248504356
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 03:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE65327A11E;
	Wed, 16 Jul 2025 03:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBxclEPx"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8685E278E7B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752637095; cv=none; b=Qs3H8oAJEnpGun/ErZyjYyJbnpO1bPIZBoxWlh9/kFpXX/flTN9ZpZPldPeqT5HAPvE9d5cADaKJ3/efmdcWbp5L6+jOuH3yVyO8G6NguViuWGemoI7IzLBG0bI98h+6pJPrkoDcE4N+5nE4L9IaYC9e2LxHcgRFfCjEmsfTnm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752637095; c=relaxed/simple;
	bh=m4veNJrjCLTKvu1iSBXId7E1tBvXo4OimoJ/Mueem9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ct5aCx9s//vHe0aM3J6tVfCbbZ1aTNOpDKx4euAy0tg/Re3t3Nle5MKlxU3peoMtSnSvoDHvP1sBeNKs2A2m3a5OLZ6OxWv5fsrv54Emgv/7Uc115/hcYbZxIxsD4blgELI8yJf6xca9F+rxECCk+/e6D6uDgYZ0UuVaUNoWxgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBxclEPx; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-73e57751cd9so548024a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752637092; x=1753241892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xV0AnC79VI6gCrCB07gTOb5HX2nG6iuSm2nLX9idpbI=;
        b=bBxclEPxEXBFQLVLFUDTydFY79vwfG+Mv9eOkqvM3FgwJg8a8e81JNqL+EP+mjySe0
         mhl8xJ673G6ct6tB6BctQ14EoXXbIxoL7t+Pq0eevb2141Jtnukc5JG0sPrDmeazjsdT
         NCVoGsFxOMKFYyf4ehqXAYqIXJwotLsNSgq2V75OQd8Ls6caOVk797DAEIjKBBOc4aAN
         R1sENcxIU3XbxE7y7KGIwBSyG57HheCjI2gEgFj2PV6uHMx1APrf+4lRLRmEmEjWcis0
         rGRM99VjNH88W4+O0p7g9A29Ba2UCVSDwReYxriqQDnG+zYILKO9719MMDSB91mYSEJY
         zLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752637092; x=1753241892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xV0AnC79VI6gCrCB07gTOb5HX2nG6iuSm2nLX9idpbI=;
        b=Y+uzcbZJyOxk3gkJEg5l6H9OmG8MzlH2abjQJ+us4WQxkIiZ0EHSDNrzMK+jWcJETs
         i86jI3M8oAZ4ABWEAqrao5cctcuznSkilfObldBuen5L7KtOB5qBSpjh7xOx2IkuYyeb
         CT1wu4p8m+rMGyTUyUIRRlGaxYtG8hXYSlyzV155oR9aSYZqq6AclFEwjEKWBtmUlrHM
         3iEUWkv8LPZMo4q+sHeBNVZmCeFYtSY6yS5wtR130z3t/p8C4n3k7XlQSjgJWHQnR4BL
         J/UyivsODkK3UEkXBgKVmNeY5sc06KoP15RRSp0urvi5p8HsO0AzaIzWRidZpDbZ1sWa
         YwgA==
X-Forwarded-Encrypted: i=1; AJvYcCVvBI3YFr+ayO6LBSq9scwFhTgdwyzb7FJjRvREh3GsCiBg6BJ6ccq+k/DvG6ugqJ8gstDqBL2iVDH5KSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWnQeZFTQwsKRKNLYrzKYeBUb2ybWIrqTh6JcYFOtvsP7Wd8+q
	hR7SfmIIlOg/+FmNmZBWrFRXC+um6A2FMNmkxTEo9Kr0lj5nXxJuvewQ
X-Gm-Gg: ASbGncuao8a/Nfp0gjmcLcWiETJ/LViGG0dIDoQxBKkZwGQ4ImbWrg7xz0QxLki54qO
	dwpakQCMnAisormvj0WzBToHlCGw3O/XEJ0o0Uw/v6lm/aFPMTBKpzdjp8gdynR7pbX517V4tdt
	IisPsqfEJlksHkfwNkRkl7JZ6/KnEZO9tAj6SAP0g9FdM2Iqh8WjF2SPv45RUWe8eDzy1iRQg3m
	+Ie5GEiLaZRQw7B2CFX4WWl72c0blG30ue8dm5AlZQDjOFoQvfDZm2PnGqll4DVQ1X7GHVD0OGS
	ItakvU2Z/C38k85LoGOlZ3s9EQY4r4VsAdJBtDRd2IN9WjjpQzWK06wLScNxodFfLHrELwsieyf
	TyE2wCXY4m8rmu5ZgkZq26hUlJi0zgn4Mg3CTUhS6W82ykiLxsEfqbvzMaEy8Pcc=
X-Google-Smtp-Source: AGHT+IEr5iLn9be4GrnFM45RjIpjgyYaTlcLT7ci1XZtjOeq/uRd1wyTTBOpNbesKlRS67XBqEwcrw==
X-Received: by 2002:a05:6870:304a:b0:2fe:f4f4:8501 with SMTP id 586e51a60fabf-2ffaf4dd538mr1364166fac.22.1752637092573;
        Tue, 15 Jul 2025 20:38:12 -0700 (PDT)
Received: from localhost.localdomain ([181.161.11.224])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ff116d22easm3140980fac.33.2025.07.15.20.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 20:38:12 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
Subject: [PATCH v2 3/3] staging: sm750fb: Fix CamelCase variable naming
Date: Tue, 15 Jul 2025 23:38:04 -0400
Message-Id: <20250716033804.59650-4-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250716033804.59650-1-ignacio.pena87@gmail.com>
References: <20250716033804.59650-1-ignacio.pena87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Rename variable 'Bpp' to 'bpp' to fix checkpatch.pl warnings about
CamelCase variable names. Use lowercase naming convention for
local variables.

Signed-off-by: Ignacio Peña <ignacio.pena87@gmail.com>
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



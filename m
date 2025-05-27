Return-Path: <linux-kernel+bounces-664238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83517AC55DA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 19:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F049E3AB73B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 17:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613CE28030B;
	Tue, 27 May 2025 17:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iYRnx5Oh"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA1E27FD62
	for <linux-kernel@vger.kernel.org>; Tue, 27 May 2025 17:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748365896; cv=none; b=iQ+RbxloegSow5E0CgsnBZ/dxOBJ0bNiDrwyW8YpGBny8Xuodxbpce0tbHgyBwdjpeZFYqzJH3eD3gmk34NeyyyqQH//+kC6N+Kob6tI+ByfXLcnmzkUh2wmhJ8dF8cFlbsOxK9SoQXwQIohsMgoWs3aqxoSaMzSg/BPwD5Fxmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748365896; c=relaxed/simple;
	bh=H4TqEXIjlqRG2Bie9YYiQ3GcjAC/tlMYkOyueCKVWnI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X0L+KBCyTjzghqAW4ceEeaUrDnohTej7jwA9r/pM62Td9HR7IIufg2Pi4RwXNLImp2pwaV5ydjCWf95PtRo8sq/kwdOTl7layBPN4ICo7/YntjvPFeoAQqZbPZklw1jYoOas7S6IosvOZzvZYnqTeNJ9TsCef6/CPulM6OYajE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericflorin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iYRnx5Oh; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericflorin.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-234906c5e29so15496065ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 May 2025 10:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748365894; x=1748970694; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ngriwog0WV6bwjlrawORboMmBAKwg+7ahv2Ua2MbkWI=;
        b=iYRnx5OhQbyQJRBAzFCihU/ira5ZQ1XuEV9MxXLmMDN6S2iZ/So6fNR/S5TMF9DT6Y
         dNsS/mGTyjyAAVqxE6dsyfs8XOD0LrlxMs8IiF9kCYvzYeCFBRvEiSrbXhaW+lGwBq7M
         yIbw4VObyW4RUF04e8zn+M8GR3e6WHrq6lN3p4290ItdwxTMUBMegDV9cycauZHkaYD4
         Xmf8uzjj76nYOp71oAcFm7OZkTUARsmb2XET5P/MzP45DTopGvmYGC/4cOVV1QOcyEVl
         FO7XQFokND/t9hr6NsvVQwF5Po8jgimO//5G/s2zEJI+nr4/EyJU266cGjRGYN5PFbKL
         xlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748365894; x=1748970694;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ngriwog0WV6bwjlrawORboMmBAKwg+7ahv2Ua2MbkWI=;
        b=HeCdN7raf6vJVlHPRqK6FjFrkM1oVNhsOJ0akG3R1tY/MIScTe3Jm9qARYbX+WeQJg
         ALF5EyQtrxlCRcP+pD9lrYVCnSRtuQyGoZbfd0YqL1uaVrMuuvcPFXHG6BxgmW+heUYu
         9TOAmW+7klNcJ2G8GLkFHZTYc+Qj8OM6Yk1sXXoT8DmF670kE0yji+j5dTq928Ycamsl
         NVQwIzcA2frE/T1eMTMRZkERxShRGaKPzYvEL/EqdtsPv+533q+e8MTV0BV1zD/hJaIa
         aa8m3VbUPd6giEeunD3f3hap7C60lbT4xtumRS+j80cEohzoYgPbzk5vdX5nHzvN9zDu
         6AxA==
X-Forwarded-Encrypted: i=1; AJvYcCXj/ri2RL0rxPhsp23jI5Gzan2yWS2mzFJsXKgiJlrGSA+N510yTHY2FZc6DoUmhXroKevZfp9Lx2hdVIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOI6yuEdgtxDeEIyxUkuU3pQDd6gJ40o3LL0vP7ubeqrIuOiRk
	d8QkLBDBM0+YyCgJsiXejkFdKkncTYKzA1EPwU/KhVPlc8jN1Mf0VJ8+ye0BMZjQ6k32Rbz/jF3
	HgG2JqrH09muCjAv1BjJAAw==
X-Google-Smtp-Source: AGHT+IEy6fu/76cZYpGjBrmomtCPA6OCWfT7RStBFgB/RS+SDT6QPi765w8a04wj7CvCDq5hZHQLy60AW5Fn7wpF
X-Received: from plos6.prod.google.com ([2002:a17:903:1ac6:b0:223:690d:fd84])
 (user=ericflorin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:19e3:b0:224:1781:a947 with SMTP id d9443c01a7336-23414f5ccb5mr235064785ad.21.1748365894466;
 Tue, 27 May 2025 10:11:34 -0700 (PDT)
Date: Tue, 27 May 2025 10:11:24 -0700
In-Reply-To: <cover.1748365488.git.ericflorin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1748365488.git.ericflorin@google.com>
X-Mailer: git-send-email 2.49.0.1164.gab81da1b16-goog
Message-ID: <0ee15444dc0f9430b1c7836c565e305b6dab823a.1748365488.git.ericflorin@google.com>
Subject: [PATCH 2/6] staging: sm750fb: rename `sPitch` parameter
From: Eric Florin <ericflorin@google.com>
To: teddy.wang@siliconmotion.com
Cc: sudipm.mukherjee@gmail.com, gregkh@linuxfoundation.org, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Eric Florin <ericflorin@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename `sPitch` to `s_pitch` in `sm750_hw_copyarea` to conform with
kernel style guidelines as reported by checkpatch.pl

CHECK: Avoid CamelCase: <sPitch>

Signed-off-by: Eric Florin <ericflorin@google.com>
---
 drivers/staging/sm750fb/sm750_accel.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 74e4be8103ac..029f5c013d91 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -133,7 +133,7 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
  * sm750_hw_copyarea
  * @accel: Acceleration device data
  * @s_base: Address of source: offset in frame buffer
- * @sPitch: Pitch value of source surface in BYTE
+ * @s_pitch: Pitch value of source surface in BYTE
  * @sx: Starting x coordinate of source surface
  * @sy: Starting y coordinate of source surface
  * @dBase: Address of destination: offset in frame buffer
@@ -146,7 +146,7 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
  * @rop2: ROP value
  */
 int sm750_hw_copyarea(struct lynx_accel *accel,
-		      unsigned int s_base, unsigned int sPitch,
+		      unsigned int s_base, unsigned int s_pitch,
 		      unsigned int sx, unsigned int sy,
 		      unsigned int dBase, unsigned int dPitch,
 		      unsigned int Bpp, unsigned int dx, unsigned int dy,
@@ -160,7 +160,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 	de_ctrl = 0;
 
 	/* If source and destination are the same surface, need to check for overlay cases */
-	if (s_base == dBase && sPitch == dPitch) {
+	if (s_base == dBase && s_pitch == dPitch) {
 		/* Determine direction of operation */
 		if (sy < dy) {
 			/*  +----------+
@@ -251,7 +251,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 	write_dpr(accel, DE_PITCH,
 		  ((dPitch / Bpp << DE_PITCH_DESTINATION_SHIFT) &
 		   DE_PITCH_DESTINATION_MASK) |
-		  (sPitch / Bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */
+		  (s_pitch / Bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */
 
 	/*
 	 * Screen Window width in Pixels.
@@ -261,7 +261,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 	write_dpr(accel, DE_WINDOW_WIDTH,
 		  ((dPitch / Bpp << DE_WINDOW_WIDTH_DST_SHIFT) &
 		   DE_WINDOW_WIDTH_DST_MASK) |
-		  (sPitch / Bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr3c */
+		  (s_pitch / Bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr3c */
 
 	if (accel->de_wait() != 0)
 		return -1;
-- 
2.49.0.1151.ga128411c76-goog



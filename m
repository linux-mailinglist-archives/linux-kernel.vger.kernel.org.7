Return-Path: <linux-kernel+bounces-732815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9DFB06C5A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 05:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34F9F504225
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 03:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247B7279918;
	Wed, 16 Jul 2025 03:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fdt3wWQm"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11147274B4F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752637093; cv=none; b=naytAwrc0kInxHaDh7Nt+H1LkfyP99Qntb51ftonFgLGREWDojTX8pZjxu6PiH8Ghi/xY3leZaxGkzjZG1kZ8xBTQleVum6Ht7pGd5uqopYRioMT/Ei/x4W8rXy5Rh+XsSBj6KDjEU5RPYwcMCuCoR8ULWT54J6Z5VXVYtY9FUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752637093; c=relaxed/simple;
	bh=YkOymsbrNFSkPHr2H/MLJ+sTTzLwp3OS0KBXDQCmCtw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NBcMb4F6x83z96yxmQeFL5T+DJ4Ad4BNDsxQl4twZrXZhS2bF53POGEECP43mDibFxF09zo678ZFQe8SBnn06oNlHjDisa6yznDfirp9sS8n4dQvk8WARSe4ntJAQ26GrMMDBm31gpoJjlEucJ6dRww9+8eVcBQNKRPSByprTBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fdt3wWQm; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6159c26766fso474963eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752637091; x=1753241891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTQYh3TSQe3Ke5lhkP3Kv1GZGvu8tMfK/edh4edU7rQ=;
        b=Fdt3wWQmHJCM5HnA323nT87Ns6aCKriZayU5ZCGsY2sEUOKbbxt+jg1I5fBEaakJp6
         5EnlbK7lq0CgA4xb9q+NBVA2tepqM0OwDvhgaCDHvqU7g0Cd03r08NPPYy1ZDKRa7KV8
         gxKHilY7dTfaphJH4qrIC98cOTLpHPyUmeAFjKki610Z7RbmDoyzO7n4LSF3tSmSTti8
         0fpmIahSI2BeFKNv8ZTS9g6IULLD3JU9VySt3z72EO20K6+GtcC5HoBFcrjspoC3SKap
         zCZl9YOL/wJNzwBxbxmUM/WTnj6BLIVkIscao5q5zhwi0wdNDtFIqpfJZNuNDJsO6BeK
         G0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752637091; x=1753241891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aTQYh3TSQe3Ke5lhkP3Kv1GZGvu8tMfK/edh4edU7rQ=;
        b=TlfATp3hUxx7cft0L87bQawni379HSoQ+QfeImvENdmqxw5hcKwXxYivwRikPQtjal
         R5CGV+iz3abXx9IZq6C32WzKMgkNChzoQN8lv3Wuc9Lf5WSLVPQvPD5Piu/g8ac7xjOp
         BiAfznIX3KUNg25OOoWrvUkKT9hBmLLHPgqXy4jC9TGS7z2Z780W2UZVQ9VmNUt6uHc7
         nxVtC2UMARLlgWIJC6zuuJbyqUyQo3g9Y7/7pF05bBhpUPPR4HBxz9fyjf6CdJcofRM/
         Gl7feM0JuzlRGyxNN0SVBLIhExj0XOZl6+izk7h/b+QJreM216He4Bf2t46dPu3ftNs9
         kSzw==
X-Forwarded-Encrypted: i=1; AJvYcCVyA6P81GZrxULw5bEJc9SQlngblQ+Xxr8QKO69oGgJp6iUZ2MdpqaRYixh9MCkLtqPOB1O1TRh2xcjMoI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdh+/fpJK7H9mi92iS4+rRYl3wiYLEKaffW6r/BUYC7tjmILRf
	bgMPzVGdkVHkO82Xw+B3FidDbgj1gBV2LVu1K2SWOkwNq9nmFOVfK3k0
X-Gm-Gg: ASbGncuSb4kTsB/uJdaxHQD13I+CfHNHYEpr9+iCO93iX/Yk2ugSx0uRnjrEwkJQYvv
	PaPhHRmcZz1WIXcFLljPijN6BVQexZTNFgcaqBCzwszvElqx1nrLMelHMzIWtZI7Wh+zPvoQjaH
	GO/izDVm8x08Vw4xN9BrxlNMz3IOSR6bVZ8BWaOONYMuSxx3F5/X6ld9q1DutLnYjYL/nwWRutl
	psdx5oQ++N/xh9/smJpZ6x6XuzeAgkwTfYgomaGBJJ+i0swdl+Kf83vsu+EGSf9n/ILCw+4XNbq
	vj2rjwohuZwhRBsTvf9zYXuZiW8RIMryWu0YOMi2MgE6KwDdQSuc2e9EgqMi3d3+CF1LMbWkR1T
	z9FojP0r99Z/y9gwWZwVspXsIDPC/8AQidBNKQ3LFbQMMIyyQBb1M
X-Google-Smtp-Source: AGHT+IGS7bx9+KmZh+bTEnWGO72xVs02ddqV8Ipzq9HBFxZ3uwMCtTt3ij/EF8xas3sKxuD/Z0KY3Q==
X-Received: by 2002:a05:6871:5895:b0:2ea:d491:eb45 with SMTP id 586e51a60fabf-2ffb244a744mr952449fac.18.1752637090920;
        Tue, 15 Jul 2025 20:38:10 -0700 (PDT)
Received: from localhost.localdomain ([181.161.11.224])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ff116d22easm3140980fac.33.2025.07.15.20.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 20:38:10 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
Subject: [PATCH v2 2/3] staging: sm750fb: Fix function parameter alignment
Date: Tue, 15 Jul 2025 23:38:03 -0400
Message-Id: <20250716033804.59650-3-ignacio.pena87@gmail.com>
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

Align function parameters properly to fix checkpatch.pl warnings about
misaligned function arguments.

Signed-off-by: Ignacio Peña <ignacio.pena87@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index d3bce107f..a896227ef 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -121,13 +121,13 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 	sm750_hw_cursor_disable(cursor);
 	if (fbcursor->set & FB_CUR_SETSIZE)
 		sm750_hw_cursor_set_size(cursor,
-					fbcursor->image.width,
-					fbcursor->image.height);
+					 fbcursor->image.width,
+					 fbcursor->image.height);
 
 	if (fbcursor->set & FB_CUR_SETPOS)
 		sm750_hw_cursor_set_pos(cursor,
-				       fbcursor->image.dx - info->var.xoffset,
-				       fbcursor->image.dy - info->var.yoffset);
+					fbcursor->image.dx - info->var.xoffset,
+					fbcursor->image.dy - info->var.yoffset);
 
 	if (fbcursor->set & FB_CUR_SETCMAP) {
 		/* get the 16bit color of kernel means */
-- 
2.39.5 (Apple Git-154)



Return-Path: <linux-kernel+bounces-732702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0EFB06AF3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 02:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1654A1DA0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDEE21C9F9;
	Wed, 16 Jul 2025 00:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0KaKkch"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1155E21ADB7
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 00:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752627364; cv=none; b=Mw8A5vnivdVeCJfAeCUfdymF0eChhNV44SatMcK4M4al7sOtnktOpgLT6V010Vmdlgf4rvbkoJXeUH14Uv1OVI0kJWVAay+VO5W0Ks09gk63UM1HxTJCcZwZD/99kzuAQyAay7ITHmqr4mxrml2TmhdhAz80ukr3rFq57Sx95dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752627364; c=relaxed/simple;
	bh=+1v0U5GLDthMIHnNPtPP4SPq7+6oMjMZjP2InLRU9os=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rh6BxzcQjxMyoy64IchEp1/PpYHRcSaMZNVCPXWJCCp5AwCmBCuSSoEWNrn4zNIq9R4XRpgh9bUC4RlT0QFSFXfzYVY9CBuO/7do8dGVnoz1Tj1OovOeSD5T+KHJTJ0b6Ztqed1syBHopMxcVs8/nqoUxppfLvm4/2IJBrDxP3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0KaKkch; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-73e5d932ab5so512532a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 17:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752627362; x=1753232162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHtZ4w4/IEU262S0YzaEvwuya4AQfl6hM4w75Ky/YrM=;
        b=b0KaKkchRZwuB5EQxCqv2yfolyNJ1IfoUOXsj1JgsTrRo7IGLdQUeajYOO868nrkl/
         KYpEvdTjQaCje8c54FtgZMNg9vRqMIRYPVAByvz8XGljWFHx+mGvLeCgasxIQSQH1DrE
         3VOZRef/dLaTDxAMEM2HfHptco6BUaWtMZx6ajE2mxRJOryUKRd8qPRn4iJiokE1drpY
         b8V7WNgt+eYLavACUDdkVBiCWvuJGrYzyuSs7ukDUYBaQ1tCSOPCf+R9UPuODKMVNQ8f
         seMgyzJvEgCuKXSqKEJ82nMEIf1qqs6ZgboBmOaohHwwXHFl9sXybaUz+BjGfTSn7sTt
         fNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752627362; x=1753232162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eHtZ4w4/IEU262S0YzaEvwuya4AQfl6hM4w75Ky/YrM=;
        b=FvkH1eLki+gzhSezwd+1K/1DqfE7txl8apDdwZ+VOdoq82XxvkXXChO/NlfatyJHVg
         2faq5Dj0BCmDupQnnYpoG9ECEqXDhXRkmSEF+YVdrpaE0qSE/OdkSJkeI/zGSPGYCuKv
         2ycWqS9S8LJ6enR4KG6EOLAnswAUl4SxObG+aYQJjbAQYLthXz3BepEjSYo3adCRw42R
         zWjCL/rwqrTngdLWgCxBtYuyfQqaTnX56nffrpldVhj2b4p1E/i9Flvt3MDCETH0mPgz
         gk45WNO2nO8Z2vkcshYrOPmyyIoioS1oOevfujo42sNo74FT4gjb/nM7uD197HqqFxPN
         2mhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOwqy9xyON9HXjr8fpHRdmkyzGZV+vB15+TQZfQm1hiwTq9SPuN7NMw0RrDiMbWb3nhh+CBYmWBeDLNMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOVXi0vN1O/IgozLDCPF+H6GP9PLgn3uj4B8gC6qOKhRwqJRjJ
	yRZBoxyNpenHQ0V+oNzpB4XPFAPDHK6TiOcd3BHnNPhrNQXaVjVWtQcOQPBa6Eyhz68=
X-Gm-Gg: ASbGncturqHZ2kaSetsMe9d1xMN86L3btPdnpeS9BFb6t6S+iTg176fv/ACvv9wF2cg
	xR40+NZyUE+64836InY6q58Zl/GpM5CG0ZLdDNafRFcM3Exd8J+gpBzRK0xKUf+ek0nXJsNzja/
	9IYiFyJ7SCjavNd1ZFn2LHBMSAm9CiUkSQbkldEXb9Kdl8U4z56Tp0vvK+XH5QNnIddS4b9XAG7
	yNocE9L01y0vWEoD8J76OAzXzufI1iRWN59GD8BvLPkQ8jSstX3vaEENKFgFW+Kf4RwaoHzfSL9
	39NScm9/J7uWYiXVm3cteRzc3g76atvz5AAKEJAxOskrOfsbfjvY19bQ3wNg+GLKeDrGs/aDiQM
	aYQRELzgurBLD5CXsclOiTN/QSqDFYJQgy5IItV2rhsNhsu/fXa5g
X-Google-Smtp-Source: AGHT+IG6flzBzXghptha8ePyXiKBfwVXd1Ab4SV7QRY9tv+YIXB3xB4EcONZ1d+50BMFsir2ET/QXw==
X-Received: by 2002:a05:6830:442b:b0:73e:5cb9:e576 with SMTP id 46e09a7af769-73e6662d006mr571265a34.27.1752627362179;
        Tue, 15 Jul 2025 17:56:02 -0700 (PDT)
Received: from localhost.localdomain ([181.161.11.224])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e56024edasm1035047a34.34.2025.07.15.17.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 17:56:01 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: dan.carpenter@linaro.org
Cc: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
Subject: [PATCH 2/3] staging: sm750fb: Fix function parameter alignment
Date: Tue, 15 Jul 2025 20:55:52 -0400
Message-Id: <20250716005553.52369-3-ignacio.pena87@gmail.com>
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

Align function parameters properly to fix checkpatch.pl warnings about
misaligned function arguments.
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



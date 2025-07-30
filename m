Return-Path: <linux-kernel+bounces-750555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C23B7B15DF0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD41C3B6788
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2834275867;
	Wed, 30 Jul 2025 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S41Xtgrz"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D5E1DF738;
	Wed, 30 Jul 2025 10:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753870668; cv=none; b=focWAWSNxK77YL5DUK/ncmEHYnqpwqQmkZIwWdZI2WKS85nFiYk7I1CKNi8FGhVbp9Yq3F/SNbH5QLDZ0y0gEJLPBeDZ/N/pTAWNuaXj0lirsZsOpTqAVgcuS/bYvHfzkjapcnbpKG2t8rtWmdc040fmuK1EcO9OwnTzubyh0l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753870668; c=relaxed/simple;
	bh=O+qmG/7ycFRlMp5aRPMDncbugQOZSV3NOqYfZz2Ktks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uSX9okfttSgNb3fv3u4KLuCrmfUcK5pbyk8Jjm1/2strCXlAVwJCKWtIi8kdwkPWWRhlBt2UVFUV0ms9hEnU+ZUqnx075wQeyM5gqpgstSvvChZgJtCkkcHHR5OvJ52xX372dMXMvGskajItBJcQkdbwJvp/dQjJlXJfTfWzVes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S41Xtgrz; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24003ed822cso22103565ad.1;
        Wed, 30 Jul 2025 03:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753870666; x=1754475466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+bZoUFL9G9l8B9hX7hIXTN1VCZgqBqq5bjZvrBOTHZM=;
        b=S41XtgrzZcIFSpSMcwJ2zLoaupmDALlhxglcb7/pL5l+5+f1OJAbtppVsYKZYLF5wP
         Bc8fKeU87+sSBtzTBWfyFD3g7p9iq0wUS7WpPQp8Nruwoi7w/yBJajyCjxtITqSG6Vn4
         evihT2B+OpFP27KZmtHkjYhMQhoFJ6HYIfk3vh8jtdD9Jyx4Ro7rhORCPzrR2MKt/lZm
         m/gw75UquovZdbj2xKdjZAmR/Kpmpt0/oXQxqdbFAgnpNIYRIhnJwx55/xO5PIx3mSG5
         wKtmNLzLYamDTkNGfyJCGoKaL8JjtqDnDAtOLj18wKuf82jEsn8NWDWBRbTR/B4qPaTe
         tQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753870666; x=1754475466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+bZoUFL9G9l8B9hX7hIXTN1VCZgqBqq5bjZvrBOTHZM=;
        b=JyzQFJNJl22QjgJqpJz6UNAvEXY8TMmIx16NLyVp2x7UOKRBpPWlvbvKl4XBzMJfr6
         CaCpny49zQJGZGm9OAXnhZiZaI4/iqS6fifzaSmU7KLn3w6PVf6KZzQlzynseW3tV1+/
         84sTyg6orImKrL75J8VrIok5tQMvkRoYr75kOyvGhF6mHmQmcc0mEqTy49S2/5LxB40U
         ZCl0wngYtmHZNxWrXvW1frbePnyyLiIxC2wWhcR5Yxf5M/IK0E0P2pB3WQVFEXEkqlVe
         ErY8En+wvSAVMruIHN4hvpmr1SAfD9gtKl+d5Pv92OYHBgik6qcb6rZH4wnYCR/w9CV7
         lyhg==
X-Forwarded-Encrypted: i=1; AJvYcCWJROkWRbo1LV+RMQQB2iust6BG/9UHZEkL/ABj1e4LJVKmVExk+DoEjw/D5X32+hBYDm1XFbthPJ+8naw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJgDVYYr4X4qqpq1NBa+AfrI3nxkcdt9ebLJwH+nZyITbRFdla
	WJSrS6UriU+2zUEuSL8jmBD1fPYTSMRRwr9aharDYz03wsn60Z9HcMGg
X-Gm-Gg: ASbGncsDpibqf7/SHf5PVbmHM1lS9Pdy8ctgLcJaAULI9di8mGY/d52Ze14HhVLqR7v
	yuyGSWX+8ApwT2C6Z+ZcC0yLRRAUgCqgWdlpttZyql0jSgc9XS8MS5sTJ1VOYlHQ4vuhWUueqTi
	+WWMrQPT10mEe8lF5zB6gWgL2cetD21ApEwiiSF1jP0WpXCVm2VSvX/8ZEhtG2gFmdrKFvOciWZ
	GnmmYGYkYrL4J20KN3Dv7WI9yyJItD9e+coLqopa9RU51LZkDQ/xcbg8wLaIzJCgmFFEEnX0ZOF
	R+PbekT2yQG/BgqAho6BZToGnzR2eY0ubYDiWlFrAOJKpla/IXk3BfD/68jXI9aKWpDmMlo66t5
	Ku1glSteH59Ps708r8mm3fQBYD+ZrCQP1bH1Ho6opNJ9W4mBuyO3QMC2iGP522b5WOLajC6M6ww
	==
X-Google-Smtp-Source: AGHT+IGQsO+8vGqIOomzjP0WFp+Pzob79mQJT9AXCAigJ+3Qak9aEP0dZ4x5BM+lngjN2SRvwcAh6Q==
X-Received: by 2002:a17:903:903:b0:240:2eae:aecb with SMTP id d9443c01a7336-24096b49851mr32847525ad.43.1753870665945;
        Wed, 30 Jul 2025 03:17:45 -0700 (PDT)
Received: from SIQOL-WIN-0002-DARSHAN.localdomain ([49.36.70.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2403c9922d1sm60161265ad.13.2025.07.30.03.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 03:17:45 -0700 (PDT)
From: Darshan Rathod <darshanrathod475@gmail.com>
To: gregkh@linuxfoundation.org,
	m.grzeschik@pengutronix.de
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Darshan Rathod <darshanrathod475@gmail.com>
Subject: [PATCH v2] usb: gadget: uvc: avoid assignment in if conditions
Date: Wed, 30 Jul 2025 09:04:11 +0000
Message-ID: <20250730090411.13044-1-darshanrathod475@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactored code to separate assignments from conditional checks.
This improves readability and conforms to kernel coding style
as reported by checkpatch.pl.

Signed-off-by: Darshan Rathod <darshanrathod475@gmail.com>
---
 drivers/usb/gadget/function/uvc_video.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index fb77b0b21790..d77ee5fd9b21 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -777,18 +777,21 @@ int uvcg_video_enable(struct uvc_video *video)
 	 */
 	video->is_enabled = true;
 
-	if ((ret = uvcg_queue_enable(&video->queue, 1)) < 0)
+	ret = uvcg_queue_enable(&video->queue, 1);
+	if (ret < 0)
 		return ret;
 
-	if ((ret = uvc_video_alloc_requests(video)) < 0)
+	ret = uvc_video_alloc_requests(video);
+	if (ret < 0)
 		return ret;
 
 	if (video->max_payload_size) {
 		video->encode = uvc_video_encode_bulk;
 		video->payload_size = 0;
-	} else
+	} else {
 		video->encode = video->queue.use_sg ?
 			uvc_video_encode_isoc_sg : uvc_video_encode_isoc;
+	}
 
 	video->req_int_count = 0;
 
-- 
2.43.0



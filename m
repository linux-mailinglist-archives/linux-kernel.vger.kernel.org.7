Return-Path: <linux-kernel+bounces-859265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 205FFBED2A5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE42819A6F08
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 15:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A92722D7B6;
	Sat, 18 Oct 2025 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qz2XzfAx"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37FD354AEE
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760801606; cv=none; b=kJNHIS8bijsLuUmsR6T0P/fFg0G6FpGe59RCeKmGt7RuEzQ0cWfCdSm+1BCmNT68bgfL+/RUBGWIZXzMw/aC0WuYB2CBQzfJw+xXoC9XmWG+E5GhZZ2+xO1W9C5m0B+dnzn6/7Z8UVwQ7n/sTkW4ydbULJyURh4tjansNERXI9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760801606; c=relaxed/simple;
	bh=Qc5FDyxe5YWtLm0XuQFXvXeE2CU4zdKg88u3qvubN2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q7U2jK9K2tyCIixpRbgtEZIFAdS6U/IXJQbG6kaBRtGiHdUW3L2Nr9Xq6RctAb93ZDSj+gDzZLB4CMx4HPL88fKuByEMoYtn9Gp5Kpf3vlTJjZLvrWcqbqZTpcVRcF1pnpD9G8S3sBHWYE7Af3mNa5Gm4iRNxytogMnmZ2x5YSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qz2XzfAx; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-58affa66f2bso3583249e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 08:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760801603; x=1761406403; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JI8wqflBoJeSVeIoguEa5qYxvXUp8LZtN2UpxTSv8wU=;
        b=Qz2XzfAxHxhw/R0P99YCKttOMDBl4ikZHNa+7AUDea64Y2/0DjgCp3UG4avEurdW68
         DjX4aBuM0HkYO/fW+3ITsZ2gLfoApRLoj32FO255H9J+rgdLb/6rl+vF0aAy2qd/VtOj
         HXh+xjADbCDf+WLkQaZIiiElRLTmD4aeG+Az+KJzwrA0PyAuulxlZuZ/q5dln6Ea8L9Y
         jv/xo+8z2r3ztbRQAmoXxqvhwnG+z7q6yoDN5EsT/buxvNLjJpGlPHl1gsdeocfkQA/u
         6K3YKa9gTA4o1kI90yBAusyCBbmtgPOnKck7h5j47Fi46sz71bguYzpw3Qj0ulfUa4Bx
         LKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760801603; x=1761406403;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JI8wqflBoJeSVeIoguEa5qYxvXUp8LZtN2UpxTSv8wU=;
        b=KfV5ibRv9QF4gngel25JH7O6uSePoT0grvHOBJ/mJU6bPfyYOy3HtLcphjfRZu3Onx
         /eXGtVZ50zoiieM3ARTefii8uzKLyUCFkVURIcqdfYFiZChIDPaiAzL2OsbglvFGTqeY
         Bqfl7fJgRwp24/asMj+aXdv1bhnUbq60KmQAKWd2oGLG4apBrrao8ZCBti/I/XfQHMXe
         Lt4dxJ31HhzQMaflKyWwi8p1b9cyTN9rwYhvjxrvhCPf4XkbTtL82NoEORQc+cr+iepl
         n7b85D8xP7fGB239winT4FS1uBmsRBiuBUwsVFtJDLmrB48tw/TGPEsWrISJcLs09uLU
         pAig==
X-Forwarded-Encrypted: i=1; AJvYcCV+p4BwEW91D5UHrxukfoEsTs6vcuAbqemUr0/hadjA/ZI899Re5Y91OfB7seR43nwzsJtQK4j7tH7VkmI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/diCsPS710aTBNZ7hSQz8mP8zf6G5TDg02bXHvxYJIhfhzZmT
	DTcMZnNMaTC9W47fPCwwlR+yTaQejn6chBcr3+rPfmHYx9HI91hU2oTF
X-Gm-Gg: ASbGnctMZFMpwvwN2i22DVXSwa52e2/OSy3bw/d4FNrSNdgMSFSfPOXQ7sQzmVvw2TT
	FOGsZUNp4cOEUDKwXV8B9+Zb2OpQINiZ1/CIU7m7NnRd7Xa6XpyNmltmHdVxVKmYzsZYe52ShNO
	DQDIDE/12Ss6pUdAoWXD/fdSnt2WfPNXe9U02lCGVdhAKMHlg2034JV2knYhVAmTXbB9ixXylbi
	BN/Z9BwTiKTeER+Tun1Y0GHdfPJOpeXvodWk4Jde9afKC4/mr2JgbkUDH2u2hgC3/C4vdbjL/lj
	n1rsuxzCvsSdwbt3H4S6nnfrUNZvHFgoKnn2epY5UOVdZc9RXpFuLgpfMcX7tM+091RtEuMerE3
	6zYIHxCMOJfrPZVcbqAn/KLDCq+p1ooZQSqFF8R5nJN7PC7LrnrZlxM/Uc6fTJMwuaZFnTI9HUP
	gPlQrPcChydWQjm/dm4pPahBLuKHwGhaQZx2QFpOsVzG6e+Dygn+iUuM2BYDwEK5qq
X-Google-Smtp-Source: AGHT+IHNJGLhJHT1HKOGPxf4DSdDJIV4Mlmc7c1/MsjKbF5l/T+nMmFrzXfeEG2XR7zYb9PwANEW8w==
X-Received: by 2002:a05:6512:1154:b0:591:c379:69d0 with SMTP id 2adb3069b0e04-591d850d2e6mr2429125e87.5.1760801602965;
        Sat, 18 Oct 2025 08:33:22 -0700 (PDT)
Received: from localhost (public-nat-13.vpngate.v4.open.ad.jp. [219.100.37.245])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591def272d0sm836014e87.108.2025.10.18.08.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 08:33:22 -0700 (PDT)
From: Vladimir Lypak <vladimir.lypak@gmail.com>
Date: Sat, 18 Oct 2025 14:33:43 +0000
Subject: [PATCH 6/6] drm/msm/dpu: Disable broken YUV on QSEED2 hardware
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251018-b4-dpu-fixes-v1-6-1852278064d0@gmail.com>
References: <20251017-b4-dpu-fixes-v1-0-40ce5993eeb6@gmail.com>
In-Reply-To: <20251017-b4-dpu-fixes-v1-0-40ce5993eeb6@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Kalyan Thota <quic_kalyant@quicinc.com>, 
 Vinod Polimera <quic_vpolimer@quicinc.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Vladimir Lypak <vladimir.lypak@gmail.com>
X-Mailer: b4 0.14.2

YUV formats on this hardware needs scaling for chroma planes. However it
is not implemented for QSEED2 which breaks display pipeline if YUV format
is used (causing partial and corrupted output with PPDONE timeouts).
This patch temporarily disables YUV by switching affected sub-block to
RGB only format list.

Fixes: daf9a92daeb8 ("drm/msm/dpu: Add support for MSM8996")
Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index 6641455c4ec6a2d082644f1488ea5f5605ccc208..9f8d1bba9139a7e09ee321cf1b6f30f96890918f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -267,8 +267,8 @@ static const u32 wb2_formats_rgb_yuv[] = {
 		.base = 0x200, .len = 0xa0,}, \
 	.csc_blk = {.name = "csc", \
 		.base = 0x320, .len = 0x100,}, \
-	.format_list = plane_formats_yuv, \
-	.num_formats = ARRAY_SIZE(plane_formats_yuv), \
+	.format_list = plane_formats, \
+	.num_formats = ARRAY_SIZE(plane_formats), \
 	.rotation_cfg = NULL, \
 	}
 

-- 
2.51.0



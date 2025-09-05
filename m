Return-Path: <linux-kernel+bounces-801868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E44C9B44AF0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 02:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4EF916F1D6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645FB20F079;
	Fri,  5 Sep 2025 00:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KnQUPug9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF3119F40A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 00:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757032749; cv=none; b=rxFLmIH4IFtWy0KeksDINIsyG8hLoMbsfVHsUuqsqEB+f/a1EYUJNaUJsgWvDNQ5IBBAYe/HFViffQc+VvLLFa7cFczGA0AZbEM5XIMJXvc6nN6+r/pYltHkR64+kPqKDxgcWRqnFZGSFRM5peB4DSZHlDp3+UQP2D6+6rB3Nr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757032749; c=relaxed/simple;
	bh=JJPS5pGG6bUUAwzvEHOTMwsPtX9lNOMwzWPn5B80/n0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cPCn7QP6O9/KTxIL4+D03X2ixdgZz7d5I95xP8JDNewo9GKVWO5/Rptcx5y5q/1UbR41B7yVrbz0+uTK542DQVffC3sXuv3LPMoCgNvWyadW9bGBPXaFpiUy9Ljh4vmvqY15Qd+LwNNfrTkT5z7hp6qSsYZzT/pVHSoOKnBGkGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KnQUPug9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584IJsBo023074
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 00:39:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V8EjH8EYOYf6Ibi/w1G8pp80W80O6z33eMTmlaCldHU=; b=KnQUPug9g4rGxsL/
	OKld6uxirY72DHA3ut6TvCfSrh2uVUgP/DF3430+Kaeq/f8XbLevRhSEch15xJav
	wVO90HBXi4MOmrE/Yr7O6dKfPG+yZmeYD6ttTqWHmDI0a8WoyvsdyJbcZsbIMn7j
	DdrVoHdPrV9AYXaE29l+hT+GEJHMm46PgG2RVEkLZ8VgafLmaV5YDohD1P1MDijK
	3AJXE+F5M6HeNeV556iQS/3ZoBOACuc0CB8czsIB+95cScRwgwEAl4xZvgWmPsvK
	zl22BQxAgkZ5PNSw5Aj6iw+P23spV+GBEWLAKZMrLIh28j0/ChxUSkgyVXyMNZJN
	a+GdMA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0esed8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 00:39:07 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-72048b6e864so15893686d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 17:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757032746; x=1757637546;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8EjH8EYOYf6Ibi/w1G8pp80W80O6z33eMTmlaCldHU=;
        b=Hj9UCX5P60DxjR43EGzdckkZz+oecbpoPF/3noTnUX+umwRh8+Xg1xZ+wQQfpudhqu
         nVRomhCdljVIiAmOWPNWs/zMalxHJcmF6NBHFjO/cwKFMQTOIuN4TQoKISMa4OJiN89e
         SYCTFoJmDoViS91jTR7i1NW+GLnTqxEaRvnV4iAIXX3Y0hVo3htBtxXitd92SxqpBteK
         OO9E5Zu5PdNKPlB3/lg0eIeRBngQeFJZwalD507d/JqhY9CwZfNZqjavTlRqAjC1UGD/
         bEYryg1O8l8XTqMbsrv3bLIfeoJg/b8jyOg0AbJt2pqGCTIj3DbZW4QMmY0oK099Zv6p
         zSWw==
X-Forwarded-Encrypted: i=1; AJvYcCWHDPZ3HKtfL9SFuwdl5ecjI1krpUORvHYkDgqsWYZPiKEk6NG9FVR+L1y3Boaz3lKN4d/sNxQms5Rj7Fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlQQuHvEx1WX0AiL+8wif4JdROeD+lNGO7JNR+HPX9xPzEHALO
	1nv+H7R56/RBFoMPefdvrdq2UHSKCOPSW8hmKGPM435/ZytUNqb/mXXhfKAMTmZsrr7GP+gKqRW
	Aa3CA3FrxXhXQ5hrb5qGMh5DaMMtB7DGGaYhOVY2I7hlJJo/fAE9knwlMAu2Zd3mDOOE=
X-Gm-Gg: ASbGncuJyC5+WsZ2a2j7/sOuIY19ePwdCL79cDuTyb0SXKE/5aAV9lmtqcLY9Agr8ys
	KKlu/3zOqCgx8bUD7mTyKBys1z6wIQqLoff0v7wv5QZgplH+MMUgwjtSwvtUWNbx+xvwBIQGpGz
	qpAFcVG2YY4ZNb9ix80d/7b8Wo9BD0Z/pVBPuEk6M8Fmz3zNVv/jYcYT/hQ6K7Cp/f7yxk0sMNV
	tdLRGCiuzNbKyqrgmC/1TME+u/TU+iIEky6cs+v7FvlaaoS6dZ0lZS7i5Yvqt5SzqoKs1lVo2Zh
	Wvs2r7SqgNjNLeLlRhNcoUOCizMj5PcTT4LoxKWBwPA8ZwlItg54e/LqviF0abE49yN9B0AwTwM
	hwSp6Dgj/zUSnptbY82w9tkvFLPPVAeMLYicBjnSLCU53JHuty9Gc
X-Received: by 2002:a05:6214:e67:b0:720:b2a:adf0 with SMTP id 6a1803df08f44-7200b2aaef8mr153541856d6.30.1757032745695;
        Thu, 04 Sep 2025 17:39:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGoowjAXuDT2UR0GO7JfTqRgPHDKO8FPpYvARPsmaNuPqmFwTraj6C8Ro2V7Wsk95bjRBebg==
X-Received: by 2002:a05:6214:e67:b0:720:b2a:adf0 with SMTP id 6a1803df08f44-7200b2aaef8mr153541576d6.30.1757032745183;
        Thu, 04 Sep 2025 17:39:05 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608acfd938sm1510059e87.109.2025.09.04.17.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 17:39:03 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 05 Sep 2025 03:38:39 +0300
Subject: [PATCH v2 10/12] drm/msm/dpu: drop redundant num_planes assignment
 in _dpu_format_populate_plane_sizes*()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-dpu-formats-v2-10-7a674028c048@oss.qualcomm.com>
References: <20250905-dpu-formats-v2-0-7a674028c048@oss.qualcomm.com>
In-Reply-To: <20250905-dpu-formats-v2-0-7a674028c048@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3061;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=JJPS5pGG6bUUAwzvEHOTMwsPtX9lNOMwzWPn5B80/n0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoujEKQbRCY0g4KHf8n57GpKw1Y+ttJmoYzTX04
 YBzh1yOwoOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaLoxCgAKCRCLPIo+Aiko
 1QOgB/0Uu54pfB5QH+FHqAmhB9/t2x9w4aM6hKLwp8xBksHaiLzdkMLUxqbLmWuGq8Y5wAJ6FuK
 HQeTY82/twMeyWig5sNtz8pFwD0qRw9KAvoejcrCY6ZRSx9+vNhY/jPgncA3kAdp7Txi/H/GYaR
 r3MmM2z2Ws+I41CFom8UDJjGXS27O9BarmsTQJvLl7fbo1kYSQideKI7szGSqM2iUtI2OWpjwfe
 a2k2rGcvixt0CESANK5Tg2UiQBdua0jRWSD/MOTZIdJz4rkav3chetWRI43YtK4DszRU1cGdrdd
 mXcvkajnfIe0JIuQicrml0k2o+orUwUP5zvVKJgPwL9KI5p6
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: U08UzYh4eJ4bemQEqhpsfimw8jzN5-zV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfX1llDEMJH1V8V
 LcsgDg3ozvS7LjUUg9uGffqe5Q+2Yv7k423wyaIkfb26b1a252AOInq0IMgpBys3/9aXdHCItLO
 G2SIMHEpmjGpEE+jzm5M50RseoCKE7A7ZQUju7GFcep4BWW6iMvk2dp9QizIVhAEDBBrmdVZ5YK
 c/ebLGLzphalQM/lldgvHmtHNvnaqbZ0aP2uFJEA6g+bL8tYTa8JGqQk/t9dbuDy4LjV/Cj/epG
 WAgs7RYqp1Iob83ADRyLCAfh7xohlm7Kz4yY0synbSxsgW4pQStIehp0X9BRYKt7CecInyFtHC8
 q5v4x8sAsplCcZpKc6K2NgasxKS0eVhUkNWspX5RU26HVf3yIG7l7XxZ+ui/xqfA5ljsd+ZovwJ
 QHpdAKuW
X-Proofpoint-ORIG-GUID: U08UzYh4eJ4bemQEqhpsfimw8jzN5-zV
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68ba312b cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=VIt9t0sQHfAwVTtMwRsA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_08,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300004

Drop redundant layout->num_planes assignments, using the value assigned
from the formats table. RGB UBWC formats need special handling: they use
two planes (per the format table), but the uAPI defines plane[1] as
empty.

Reviewed-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
index b950bc827a36c231bcd4a9374e58cde6b41230bf..191d1f2a0cef7ed69342eceb35df0c3e99a0c373 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
@@ -110,7 +110,6 @@ static int _dpu_format_populate_plane_sizes_ubwc(
 		uint32_t y_meta_scanlines = 0;
 		uint32_t uv_meta_scanlines = 0;
 
-		layout->num_planes = 2;
 		layout->plane_pitch[0] = VENUS_Y_STRIDE(color, fb->width);
 		y_sclines = VENUS_Y_SCANLINES(color, fb->height);
 		layout->plane_size[0] = MSM_MEDIA_ALIGN(layout->plane_pitch[0] *
@@ -124,7 +123,6 @@ static int _dpu_format_populate_plane_sizes_ubwc(
 		if (!meta)
 			return 0;
 
-		layout->num_planes += 2;
 		layout->plane_pitch[2] = VENUS_Y_META_STRIDE(color, fb->width);
 		y_meta_scanlines = VENUS_Y_META_SCANLINES(color, fb->height);
 		layout->plane_size[2] = MSM_MEDIA_ALIGN(layout->plane_pitch[2] *
@@ -138,8 +136,6 @@ static int _dpu_format_populate_plane_sizes_ubwc(
 	} else {
 		uint32_t rgb_scanlines, rgb_meta_scanlines;
 
-		layout->num_planes = 1;
-
 		layout->plane_pitch[0] = VENUS_RGB_STRIDE(color, fb->width);
 		rgb_scanlines = VENUS_RGB_SCANLINES(color, fb->height);
 		layout->plane_size[0] = MSM_MEDIA_ALIGN(layout->plane_pitch[0] *
@@ -148,7 +144,9 @@ static int _dpu_format_populate_plane_sizes_ubwc(
 		if (!meta)
 			return 0;
 
-		layout->num_planes += 2;
+		/* uAPI leaves plane[1] empty and plane[2] as meta */
+		layout->num_planes += 1;
+
 		layout->plane_pitch[2] = VENUS_RGB_META_STRIDE(color, fb->width);
 		rgb_meta_scanlines = VENUS_RGB_META_SCANLINES(color, fb->height);
 		layout->plane_size[2] = MSM_MEDIA_ALIGN(layout->plane_pitch[2] *
@@ -167,7 +165,6 @@ static int _dpu_format_populate_plane_sizes_linear(
 
 	/* Due to memset above, only need to set planes of interest */
 	if (fmt->fetch_type == MDP_PLANE_INTERLEAVED) {
-		layout->num_planes = 1;
 		layout->plane_size[0] = fb->width * fb->height * fmt->bpp;
 		layout->plane_pitch[0] = fb->width * fmt->bpp;
 	} else {
@@ -194,12 +191,10 @@ static int _dpu_format_populate_plane_sizes_linear(
 				(fb->height / v_subsample);
 
 		if (fmt->fetch_type == MDP_PLANE_PSEUDO_PLANAR) {
-			layout->num_planes = 2;
 			layout->plane_size[1] *= 2;
 			layout->plane_pitch[1] *= 2;
 		} else {
 			/* planar */
-			layout->num_planes = 3;
 			layout->plane_size[2] = layout->plane_size[1];
 			layout->plane_pitch[2] = layout->plane_pitch[1];
 		}

-- 
2.47.2



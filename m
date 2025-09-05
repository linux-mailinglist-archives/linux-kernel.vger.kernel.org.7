Return-Path: <linux-kernel+bounces-801869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C094B44AF3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 02:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EB5E7B6C99
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0B621A94F;
	Fri,  5 Sep 2025 00:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CmoBVaOW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EB2218821
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 00:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757032754; cv=none; b=Ag8wojw9QLk98cJ6EaBRBdEAwG/0kKqPvJa6ebGASamc6gclW7vpsoedfQaVWGJudjt6iMeMMzeqAvDHEXegTmLVDAvhjsxb1vMxxkk2qgEbTbUz3MqIexFiMsEu45W6+G8ov9rUzgEpH65CR0QDKJUxlzpG1Y6/OcORSbmGVZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757032754; c=relaxed/simple;
	bh=lGlOq21wJXxPf5qd4HfAzqrvugD2QrjsunL1xmnHE9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c3jgmpDW87AI7E+j8keyu/yeHuzboCtG4pZQ6tW0hCXaQA4tpMK+fH6+8dW9Ld1UkpO4+6o0m9qaYe8oJ5+oHnZtmOhQ63mR6HemuomDjkIwobqNTXP8Slh+bQ0HJ8CXeQWyLHrOdC7tPcdAGoajDudoHi8p+UOFUNbDYcfO5y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CmoBVaOW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584IAElo031754
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 00:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ra9GluSXfhMlHZ2ACIpc5GR7mvUKtMwIaWiKkZbOwVY=; b=CmoBVaOWsvaUWwyX
	Ur0wrPYC4AipxzjvoRExW9VbSJbovPTvzHSiLANjH9GfjItEI7AMThPxYCQXYAVy
	fO4OeGNM256nexMaYz5FwBgkT9eMGfY43rBLXI8Bky4gE7SqTlstmsDfR0Czj4EO
	Yr9Ea/RoEnFZQwFf4emVkwioo7G28a7E9UuoPE32+gaHD/Rka4Gx5S/8wTQEm07Y
	W09GeMAteG5p1ekvPmh47z5xiA5m2Jr3kKeJP6tWqpWVXed8F657ZPOpvsoAKNL7
	tfrSul9fTu3NIsI58o9N3gI5D5usDNuYjduGLOjQMsjrkTOkE/+2l9uEUX75HgHX
	lhchtA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw09bxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 00:39:11 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b29cdc7417so31559921cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 17:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757032751; x=1757637551;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ra9GluSXfhMlHZ2ACIpc5GR7mvUKtMwIaWiKkZbOwVY=;
        b=gHuVvb9uSdSAej+Si2PUFXZwmiDiDE0ybjgnRE0z7+D0zVrxgnCrMt+8HD4OSm3de4
         Chs/uOviiFpl2UkQRwqD4GRprl2BzcX8/+1BxQJWAmdZcDuGP4PCQQmo4PRGLJfUaTe+
         2PPDV9j/2NeLVjHcMsCj56jIFeM8EgkmydM+I2TPwi+0b1n+xVjsCBNODslYR3CXvfwS
         7Dap+Cc7TpZYNyoUZun5Y1QpwtABslsXafGH/vSMJIXHM5PqasOKlqK+IEBf/x+ATtmA
         oYiislLAMQ2Q7Y5uBBm0jfipEjUGmkraQ6NWKm/+Idv4RomURS7DBhUb8onUfB8Fo0jl
         busg==
X-Forwarded-Encrypted: i=1; AJvYcCVW3ZlV/ZCdIj8ADN2HM3VcqzpaEBllvmK3NLVR707vQY6wv8SZ4VB93oSdf+EunoAXnBpFBhTK/xzdkV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSJVbAnXARRmF11Vlv6yPn40sIrL9t5SeXNg3qqtferfQIO3eE
	17aTg/ZAgA4uX1XlQr8hIL2HEeDiwzXKSCoLV3ru9gZQrlvFTNryblQVnW67jZM/tC2UO7ijQ5U
	hd2m9kkoTmhAk3lKspZqqjtDV9sJ+7AWoa88h9VrQo6MO0tphZmzcKIE/pcMS3GPcUJw=
X-Gm-Gg: ASbGncsc+b+k88bzXzqOqSoKBwWs8pCecG3O+iGL4TdnkOxGLW1YyelgzSzNwn9dDqh
	Wz/pBZXUjA9PGodv/KbeEbqywMxGR18uQ56GNsPRtsMQjyjXXVvYx80kuWQ+/T9Fj+gJnOA2jLT
	s8QL6m8QMnMphv501vl3neCf68VwVZenIcM0409lcA453CGSeaSEZ7n0yNVU5VaX3inqZaDkfbh
	523ORNHpDC43vFF5a6X+Mkly7g8Yph38TRklVRVVgUwJEegzhlMJ17Dl4Ofo0kPs+u1L0fHq1wR
	v2HELi5COqV97bfefFc1tPGDaYR8JW8cAR4+H/LFmapbuKJZVaIbd6Y+2eHqqjMqKI+fEBwMCDf
	ZYDEq25kVQlBV36k3mdC5gui2u/7Buhw95NrMNOwwK5tTcTl2PvFx
X-Received: by 2002:a05:622a:4207:b0:4af:1535:6b53 with SMTP id d75a77b69052e-4b31da3b2a0mr222826011cf.54.1757032751055;
        Thu, 04 Sep 2025 17:39:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS3wnGT8ACgxrTqpQD8+qzTZ6t5n5H43QqgEg9VQB/rUpomSgmUzUzHoGTcB143SkCSuf93g==
X-Received: by 2002:a05:622a:4207:b0:4af:1535:6b53 with SMTP id d75a77b69052e-4b31da3b2a0mr222825811cf.54.1757032750618;
        Thu, 04 Sep 2025 17:39:10 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608acfd938sm1510059e87.109.2025.09.04.17.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 17:39:08 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 05 Sep 2025 03:38:41 +0300
Subject: [PATCH v2 12/12] drm/msm/dpu: use standard functions in
 _dpu_format_populate_plane_sizes_ubwc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-dpu-formats-v2-12-7a674028c048@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5431;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=lGlOq21wJXxPf5qd4HfAzqrvugD2QrjsunL1xmnHE9s=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoujEKK92PZaXMEwacZH5/xSig59AgXXb3CmkPc
 fjelgfuBvKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaLoxCgAKCRCLPIo+Aiko
 1TJbB/4r1O0t6fCeOk0Vjk5icw3t2tBKMN1g91Yubw5n3bIrgtCaaAj4eaBV0LGNLTrZQusxc2K
 Hw4mgODdktXjaQGdz3iQhL0wJyVXyQ19phnBcb6Y19aHwqZiiwqZ6JjfY6wgtBTZUYTgR9VzrL4
 TOkX8fsQmUcnphqOBgw7Hxn8/Sf7bBt6XRCQom6nKnZL+T9CMPCgl6cw7wVQy24Cbkwl8HArcL9
 vStylSVaxxlS+ykE/3IIxofD1eC262/fLFak/ohr8oKogkQ8P5GQsRetJ1lx9I8PIdFfc9BcQOj
 zhu4MFrmQ7SLnRgwqs10szN6IRd66kqr5s+ES0wJ4yW8eRSE
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: wDmV-oEtzCHNWERm9ytia-XjwGTxBkv-
X-Proofpoint-ORIG-GUID: wDmV-oEtzCHNWERm9ytia-XjwGTxBkv-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfXz8PL/cPR4DqX
 nljweVar/QD0vKje25iq7oM7MJvMc8Eimql50gpIYZhFL6ebHnxW1pVKOSAxtE3aAIieULd/p6L
 NIU/Kf1iPcKT+BI1BQkqs1Ww56E9jqr4xR1iJcfzGRjRGUuKoQbPbqx4TN56H+AMgvDRsIzfV9f
 FuBVTmU2hHnXAVdoHSln4lBqV3g+piu+tpnSe+uLl8lXspIFngGKaVxGUcDcvBDnsnguBgM9jZT
 BtizDWSrCgC+Kx06gI6Q9ieEyzRTz5UCoAEJP//ebZKcTCDbizBI4M7R3bqMGo4RXW625xGjz0f
 t7LRTBHi9CYFizytZAKbBUD9AwPtSIUnX1WOO7U5YtSQ94dtU498dRxkAJdHBpIAz5XkxjI8y7I
 ECVX8dfS
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68ba312f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=7bqH7Blup1pqkekdm3wA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_08,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027

The _dpu_format_populate_plane_sizes_ubwc() used MSM_MEDIA_ALIGN() and
MSM_MEDIA_ROUNDUP(), macros inherited from the previous implementation,
msm_media_info.h. Replace them with the standard Linux macros,
round_up() and DIV_ROUND_UP() respectively.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c | 63 +++++++++++++----------------
 1 file changed, 27 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
index da1870ce7680899759d09caa01050eeb9844a484..6e8883dbfad439a3b3f07b6fe9337820048fc2eb 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
@@ -10,16 +10,6 @@
 #include "dpu_kms.h"
 #include "dpu_formats.h"
 
-#ifndef MSM_MEDIA_ALIGN
-#define MSM_MEDIA_ALIGN(__sz, __align) (((__align) & ((__align) - 1)) ?\
-	((((__sz) + (__align) - 1) / (__align)) * (__align)) :\
-	(((__sz) + (__align) - 1) & (~((__align) - 1))))
-#endif
-
-#ifndef MSM_MEDIA_ROUNDUP
-#define MSM_MEDIA_ROUNDUP(__sz, __r) (((__sz) + ((__r) - 1)) / (__r))
-#endif
-
 #define DPU_UBWC_PLANE_SIZE_ALIGNMENT	4096
 
 /*
@@ -78,56 +68,57 @@ static int _dpu_format_populate_plane_sizes_ubwc(
 
 		if (MSM_FORMAT_IS_DX(fmt)) {
 			if (fmt->flags & MSM_FORMAT_FLAG_UNPACK_TIGHT) {
-				stride = MSM_MEDIA_ALIGN(fb->width, 192);
-				stride = MSM_MEDIA_ALIGN(stride * 4 / 3, 256);
+				/* can't use round_up() here because 192 is NPoT */
+				stride = roundup(fb->width, 192);
+				stride = round_up(stride * 4 / 3, 256);
 				y_tile_width = 48;
 			} else {
-				stride = MSM_MEDIA_ALIGN(fb->width * 2, 256);
+				stride = round_up(fb->width * 2, 256);
 				y_tile_width = 32;
 			}
 
-			sclines = MSM_MEDIA_ALIGN(fb->height, 16);
+			sclines = round_up(fb->height, 16);
 			y_tile_height = 4;
 		} else {
-			stride = MSM_MEDIA_ALIGN(fb->width, 128);
+			stride = round_up(fb->width, 128);
 			y_tile_width = 32;
 
-			sclines = MSM_MEDIA_ALIGN(fb->height, 32);
+			sclines = round_up(fb->height, 32);
 			y_tile_height = 8;
 		}
 
 		layout->plane_pitch[0] = stride;
-		layout->plane_size[0] = MSM_MEDIA_ALIGN(layout->plane_pitch[0] *
+		layout->plane_size[0] = round_up(layout->plane_pitch[0] *
 			sclines, DPU_UBWC_PLANE_SIZE_ALIGNMENT);
 
 		layout->plane_pitch[1] = stride;
-		layout->plane_size[1] = MSM_MEDIA_ALIGN(layout->plane_pitch[1] *
+		layout->plane_size[1] = round_up(layout->plane_pitch[1] *
 			sclines, DPU_UBWC_PLANE_SIZE_ALIGNMENT);
 
 		if (!meta)
 			return 0;
 
-		y_meta_stride = MSM_MEDIA_ROUNDUP(fb->width, y_tile_width);
-		layout->plane_pitch[2] = MSM_MEDIA_ALIGN(y_meta_stride, 64);
+		y_meta_stride = DIV_ROUND_UP(fb->width, y_tile_width);
+		layout->plane_pitch[2] = round_up(y_meta_stride, 64);
 
-		y_meta_scanlines = MSM_MEDIA_ROUNDUP(fb->height, y_tile_height);
-		y_meta_scanlines = MSM_MEDIA_ALIGN(y_meta_scanlines, 16);
-		layout->plane_size[2] = MSM_MEDIA_ALIGN(layout->plane_pitch[2] *
+		y_meta_scanlines = DIV_ROUND_UP(fb->height, y_tile_height);
+		y_meta_scanlines = round_up(y_meta_scanlines, 16);
+		layout->plane_size[2] = round_up(layout->plane_pitch[2] *
 			y_meta_scanlines, DPU_UBWC_PLANE_SIZE_ALIGNMENT);
 
-		uv_meta_stride = MSM_MEDIA_ROUNDUP((fb->width+1)>>1, y_tile_width / 2);
-		layout->plane_pitch[3] = MSM_MEDIA_ALIGN(uv_meta_stride, 64);
+		uv_meta_stride = DIV_ROUND_UP((fb->width+1)>>1, y_tile_width / 2);
+		layout->plane_pitch[3] = round_up(uv_meta_stride, 64);
 
-		uv_meta_scanlines = MSM_MEDIA_ROUNDUP((fb->height+1)>>1, y_tile_height);
-		uv_meta_scanlines = MSM_MEDIA_ALIGN(uv_meta_scanlines, 16);
-		layout->plane_size[3] = MSM_MEDIA_ALIGN(layout->plane_pitch[3] *
+		uv_meta_scanlines = DIV_ROUND_UP((fb->height+1)>>1, y_tile_height);
+		uv_meta_scanlines = round_up(uv_meta_scanlines, 16);
+		layout->plane_size[3] = round_up(layout->plane_pitch[3] *
 			uv_meta_scanlines, DPU_UBWC_PLANE_SIZE_ALIGNMENT);
 	} else {
 		unsigned int rgb_scanlines, rgb_meta_scanlines, rgb_meta_stride;
 
-		layout->plane_pitch[0] = MSM_MEDIA_ALIGN(fb->width * fmt->bpp, 256);
-		rgb_scanlines = MSM_MEDIA_ALIGN(fb->height, 16);
-		layout->plane_size[0] = MSM_MEDIA_ALIGN(layout->plane_pitch[0] *
+		layout->plane_pitch[0] = round_up(fb->width * fmt->bpp, 256);
+		rgb_scanlines = round_up(fb->height, 16);
+		layout->plane_size[0] = round_up(layout->plane_pitch[0] *
 			rgb_scanlines, DPU_UBWC_PLANE_SIZE_ALIGNMENT);
 
 		if (!meta)
@@ -136,13 +127,13 @@ static int _dpu_format_populate_plane_sizes_ubwc(
 		/* uAPI leaves plane[1] empty and plane[2] as meta */
 		layout->num_planes += 1;
 
-		rgb_meta_stride = MSM_MEDIA_ROUNDUP(fb->width, 16);
-		layout->plane_pitch[2] = MSM_MEDIA_ALIGN(rgb_meta_stride, 64);
+		rgb_meta_stride = DIV_ROUND_UP(fb->width, 16);
+		layout->plane_pitch[2] = round_up(rgb_meta_stride, 64);
 
-		rgb_meta_scanlines = MSM_MEDIA_ROUNDUP(fb->height, 4);
-		rgb_meta_scanlines = MSM_MEDIA_ALIGN(rgb_meta_scanlines, 16);
+		rgb_meta_scanlines = DIV_ROUND_UP(fb->height, 4);
+		rgb_meta_scanlines = round_up(rgb_meta_scanlines, 16);
 
-		layout->plane_size[2] = MSM_MEDIA_ALIGN(layout->plane_pitch[2] *
+		layout->plane_size[2] = round_up(layout->plane_pitch[2] *
 			rgb_meta_scanlines, DPU_UBWC_PLANE_SIZE_ALIGNMENT);
 	}
 

-- 
2.47.2



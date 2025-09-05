Return-Path: <linux-kernel+bounces-801866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C3EB44AEB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 02:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F404F188FD23
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4E01DE4FB;
	Fri,  5 Sep 2025 00:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VE5ESYjl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C271E51E1
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 00:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757032742; cv=none; b=fv90qMOyDipIyRG8JN7p5liLADl+/sQEn8500hvsfIXAGzhEOKwTqssIX8A2Y4zcer4pvGpCpaLHpaKXbr/7RZlFiafF52W0maamMohXGwWHDZZUo9bismmoWIBMSg0dQNqIPUJyT3AriZLOoJeqeCBQdNAgWj0j8vG5FmrvdhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757032742; c=relaxed/simple;
	bh=XLkwtyygZJdPj3GjkZgZ1aANtwazJqGOIEmkYbUxRwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JDz5+2MsHsp7lpKr2Su4S90joma9xES2x46imZOOnJjgJUWVqT1nZcW0YKYgnGgKQsGOI1Z4bw92VSYPZmr8Vlblg5h/HFOWFd6jB2nEJOBv5c+4wpldgC8X1qikei2MFxpc1hoo0M26LV0jZSd41Ivufi5HAkJz7Rn9Ccgnp/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VE5ESYjl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584GUjtB017818
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 00:39:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bLiIOtcLE7wWiaqufYm5bdrdybL14BNM8N/yFfbsTSY=; b=VE5ESYjllYEICnuR
	D+Vcj5mbyBY0Ok7ERnQG2ZMTt6JiQzXKuJjGttNEr5NrumYFafTrlw9RxDz/QwzH
	niqcWvxyiVSOFqgMCbLMKKRg3Txhb3AR26xlE+gkAre1HRTLCGfAJ8jQGZ/UQ02D
	UszrjoReuu+sXBg6faQRIOajSLNQq0hJDz6Naopre4wXIzRNuDUF3n93PpO+tZ/4
	SUkcwDUjHXx8eKpvV3ewQWyG/1AcihAmzIIFhsN+5AZsvFWjt8f2JhXO0b+sjonu
	7fQo8cFEzg7DKzhnGeBf0LuYb0inQxZnb1wUTowSMB+4PtIjoniG3fIqhv4UgdwT
	6yv1lA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48yebus55v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 00:39:00 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b49715fdfbso47508601cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 17:39:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757032740; x=1757637540;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLiIOtcLE7wWiaqufYm5bdrdybL14BNM8N/yFfbsTSY=;
        b=s+fdRIIiGLG4HB5N1AMXOn2k9V59/Q93y67APthUIzd/ziijThxDbs94+iNAE7TbHY
         79cosYZ5OoFNZNetoFTaAWPvPJug4xYMDogvJEYKjFIsKojkvXzQMj+p4+PtvQrSxGVV
         iZGADQPg3WN11WfNoMTtmC7trC3fNpnZk+3nXLdn8XAvTz/1pfPcP9CvzaPuF65146R9
         K0V9SOZdwmyfNytEUbnSqz1qNuBCpoSDS95Ob8bPdyQwZj3XTOAjTEcgqHiXqSWkq+SR
         u0AaoCFDBgMtcTwmPpyXXW6pKT4HKPAaOEXOZT5293seGr+XSuU6izGsjXMEaViVMYd2
         cc4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWzjhbljrYoLMKhIl6NOAPmOAA0nIXELDtb+QdwJXCggLOjMRVWyitv1fctXwT23PuEynIF6jV2eMdxJM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkOkumpdmJ/XiXtEQ5qVtKP8+VgQGfu07zY5rEvbkYRefGjqso
	gTxIvc3Ziu0wnjDEHrlfG6lPwfB7yu7YD6Enk8ALEOM2fRkIkFybj5jjdPi3Wzb+/VCI/GTRzQ5
	sPh+c10+VL0QZq5c25/5P5GHxLe2BF6rXiYaUblO6nnQJnHguO4uwAz52sM5caAlYQT4=
X-Gm-Gg: ASbGncu58Z43beFdpbl5WBZ6wP7BiGJhQ5wCJhRfThqllz2h7iAVnlQpwWfE0Q0+Pyt
	X/IOOuqil9R0/6ghmh3VhGPQcIA5QiU2PVo3fc4HdRL6TZUrJHrK3Uj09dsgGIAcMkdj97ML/Fv
	7qQiXAeb8UJ6GMQ2ieczUPxkfDHggz/I81VKodYAAofs6A/VHa1Wdq9zgDFNqqq0J1eDdW9u2Ch
	uZofCOWnWHsSVC/rqHSUUdzwj5cJcBFUPyIycCySI0xoyztEfvhx0+Dl1AbQ6AdEO6fnKp5G0KD
	8skTWUCzwnCio3PvZotYI1+z4ScjIK8zKSduY/AtGLGohDulT8a9419Ct1oj4Q2fLC+5MJQw6JO
	ZsD5uGZfkFtiCgotF2X76Q7pxJhT8jQjn2hJWbHGa5QiNrHlhRGdL
X-Received: by 2002:a05:622a:551:b0:4b3:61b:58f4 with SMTP id d75a77b69052e-4b5e18395b0mr40913331cf.53.1757032739623;
        Thu, 04 Sep 2025 17:38:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEP0nB2Vt3LMYDBx118zsJ4giTEWN/hLJl0xD4HXyg7zzaWIFQByUuhZsTTOJxoycKJ8OS8WA==
X-Received: by 2002:a05:622a:551:b0:4b3:61b:58f4 with SMTP id d75a77b69052e-4b5e18395b0mr40913091cf.53.1757032739088;
        Thu, 04 Sep 2025 17:38:59 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608acfd938sm1510059e87.109.2025.09.04.17.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 17:38:58 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 05 Sep 2025 03:38:37 +0300
Subject: [PATCH v2 08/12] drm/msm/disp: drop PSEUDO_YUV_FMT_LOOSE_TILED
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-dpu-formats-v2-8-7a674028c048@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2270;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=XLkwtyygZJdPj3GjkZgZ1aANtwazJqGOIEmkYbUxRwQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoujEK71uU2bZ8JQXFBGN1IDBH5OYQyC9Xm8v8v
 tnUi8qYOuOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaLoxCgAKCRCLPIo+Aiko
 1b2yB/wKB4v8Bk2zFkuQDoVspBPY3bca3px+IzVDe5SyzF0FfBVY/9ca/uty+7qgAX9i8dVh8NV
 LdCBJWXW7Wfb6sEB9hw323dwH4NlMLa8gY1KW5GQiOVPehuK5Pwc8yCxUOs+oG1gD9zkpY3crTj
 HvtY8KdCmsZZcOKPOGb5b1apoatF0mT/b3xWXFicKF/NQ7Tb80KTtgvQsZkQTzvDn0gbyk7bzLD
 gWxUFA9aIalzlrIfuxodQxpj5zPC/dCyc9LKMSgC8Zm+tco4YF6FhId2X3J1vDIKPmNfidpAC7J
 /RBiA+aOsGY62ro7QEhoCaSHJla3hJbN+kFDytWN6VvHG/SP
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: e4sIXU1AWCdkibvzrK8M7Ksnlsqvihr2
X-Authority-Analysis: v=2.4 cv=X+ZSKHTe c=1 sm=1 tr=0 ts=68ba3124 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=iz29p33r4uX7jxN-whAA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDE2MyBTYWx0ZWRfXyqYl9r4l9pNo
 nsWno8v23eQTmBcvsQ9b8pBpdjwd+t14RftaJRaVKFy9X1FLHDl3Zf0h6aiA0WIas6rUnb8OWlr
 hTq1P1O52gvocnLNRBacnLM0b3eN831jhZsMIYpJa/dNVheMSklggr+FrFzP20j1MzY91JAWVTF
 9gMya/C3pxLWpC84JtS4NlaarzX0VF7/MldTH8YKYO0/XJ6vssxtaO8x7JXcGxY3D7p1lVvOfZm
 hQrIyClBmrpuHEayNO1Nwy+93vVFGOYXtBnxwjGutLyaYmsVbQgWDbrdLPTzdK50sxHfqkqZMov
 0z0agfJZtOx3rzB7T10d5YoQKbpjJA3NFORvapsCsSoUlN9rFF1fu9GMwK2A25nLNloGwn7JUMm
 wUUKsS7y
X-Proofpoint-ORIG-GUID: e4sIXU1AWCdkibvzrK8M7Ksnlsqvihr2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_08,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509040163

Drop PSEUDO_YUV_FMT_LOOSE_TILED(), the macro is unused.

Reviewed-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/mdp_format.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp_format.c b/drivers/gpu/drm/msm/disp/mdp_format.c
index 79f7f973dbf348acf2c06e66afedeb8f22e7a8ca..35c443f006bbbde446cfcc0862c49d06a8e10bb4 100644
--- a/drivers/gpu/drm/msm/disp/mdp_format.c
+++ b/drivers/gpu/drm/msm/disp/mdp_format.c
@@ -325,26 +325,6 @@ static struct csc_cfg csc_convert[CSC_MAX] = {
 	.tile_height = MDP_TILE_HEIGHT_DEFAULT                            \
 }
 
-#define PSEUDO_YUV_FMT_LOOSE_TILED(fmt, a, r, g, b, e0, e1, chroma,       \
-flg, fm, np, th)                                                          \
-{                                                                         \
-	.pixel_format = DRM_FORMAT_ ## fmt,                               \
-	.fetch_type = MDP_PLANE_PSEUDO_PLANAR,                            \
-	.alpha_enable = 0,                                                \
-	.element = { (e0), (e1), 0, 0 },                                  \
-	.bpc_g_y = g,                                                     \
-	.bpc_b_cb = b,                                                    \
-	.bpc_r_cr = r,                                                    \
-	.bpc_a = a,                                                       \
-	.chroma_sample = chroma,                                          \
-	.unpack_count = 2,                                                \
-	.bpp = 2,                                                         \
-	.fetch_mode = fm,                                                 \
-	.flags = MSM_FORMAT_FLAG_UNPACK_ALIGN_MSB | flg,                  \
-	.num_planes = np,                                                 \
-	.tile_height = th                                                 \
-}
-
 #define PLANAR_YUV_FMT(fmt, bp, r, g, b, e0, e1, e2, chroma)              \
 {                                                                         \
 	.pixel_format = DRM_FORMAT_ ## fmt,                               \

-- 
2.47.2



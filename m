Return-Path: <linux-kernel+bounces-801859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A9CB44AD5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 02:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 702587B317E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A70919F130;
	Fri,  5 Sep 2025 00:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L8LxnQMk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AB6190692
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 00:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757032725; cv=none; b=dvAoTZw4cvTUGEPQFm7dDC+725VlZ61FsE2iu1hT6OmiorsYQzUBWbi94HIaRlhjWW1iSj1rJc10CcNFVmJzd2531aEm+Gk8ev8iDn6W3ID80014t/EVVw6SWA+E9h6odItGxt38zhw7Vy6ZJS7QeJ7AR5JEecofBcqKhyZn3fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757032725; c=relaxed/simple;
	bh=pjUEPhdOzoPN8Hx0y8aVOu6btqr80/b31OiPFcm79wI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ockFQPCKFOsPooVZxlqUAc1qr6CyjlvPU3GmH/JXwaYSFzGE+FhC+uwdFaQceTd9g8OwYG+j0vO+7LJJRvEKhvrLlAvutJtpJt2Btqbygay/uSjJ+3IClSTI20Mgl9dpZGS58ROxj2fyhi1mNLqilPrL/0poN756FgCw/E8plZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L8LxnQMk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584I0iG0003019
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 00:38:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yTzO62qQEXkfh7mQFeF6JWdziRWqLc1w2y3Ayzm1rok=; b=L8LxnQMkdelWd9bW
	Fv8Ct44/t9adiGQQXxAD7FZsreLPJVR0TOPF3ukyWzm55bmTb61dfRKym1W1NrYf
	4qvRZUKkD4/1OZhfagafn1kNEaKOgIV61fkn6z/agyahxT2kWLgyAa2Z+Aww+e4x
	lQbG+WoZ7cryx9tzynrZv1jE9+iPKerlXXdAyQNUdTY1IfJdp937gB6biT9/Pmfb
	Mok0gw6eFoO1UmSyXAuTVVHGKRRoM52YFamNObZyMFH1UMrEeFXO4vwCeI5PdZ41
	a9G3Krd6BEBJE5kq67I6l5EdMyqkrTobyQBtoUTHt1DEPFgXlbhyDtcool0mnuYd
	5Br25A==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush395fm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 00:38:43 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70ddadde46bso29040576d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 17:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757032721; x=1757637521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTzO62qQEXkfh7mQFeF6JWdziRWqLc1w2y3Ayzm1rok=;
        b=iAo5KWIoder4Yki8YMkMP10F5iJOY0yU99CTWx+FnG4c+uFLE6cjsfdreuCxndEoVa
         RlTlCTUgmvAHZv60SVWhUBe5wTbDsdEUADjNLMC0xRV7oh8RGLusZX19tzWyrHIlw77y
         vgFK6KERjEFMOqJoHtQ7pFH+glgms+RdSvoETH/G3r7kV7LEWOFxzUMM4MuZMBxbdz6G
         MKIt3ftCYZQ8ICxbDTzubVYeR5sF3tomsPcQqBOD1qJx8qAZyPlq7OfpU4/cSEdju9q/
         O7W2Vas6iiofNMLh4F5jO1yREkzUQsk0eXURVdejf3NRAJeMiO2hpPTKBGOGU2VOfybF
         ocTw==
X-Forwarded-Encrypted: i=1; AJvYcCVNLS4CE3uzs0b7VdY8GzyfulDcg2mc/Zes/SQA2/Ob8ixmoUIs0lUkvvOtiMrzpdQpKZ8YsTL60XkVEK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy54kKK86TkdSoKPvS0x0ehWz2Gj3YBYuLrlZaFN5nhyKyI1B7z
	ioyZ78jkq/teGpyKuQpgF2AoZzRV/X5PnRpeOgf4vK9Mm9PTkuAEpjRcUATjjb4X1NbLdY3HIBP
	I8AOFwytKKTkxgKg4+wSKcMgkGbNK7XIihXq77O4NLo4+b+kLaOckkCa2hAHkpFcfIoY=
X-Gm-Gg: ASbGnctO17k9XsRuJ1+kDR3St3cYYLjFIlo6OxvZjP+sB/bFAkjJ4Y5yglF39hgDIVb
	fEEUvLON5WOKySat+0hhZnV1aU3v2c36/kRQEAkJGVn38n0LThxeu4A7KNSi2GvO0Tq6RA/dKwp
	McNftOO2aIboA6BLIODXt2Dm3SoEtFCiMqVqN3Cv8h531tHK0QaFoIQr/q7SABik6FJI+X1O7zS
	jKDo2kW9qRBs3Soare1pmwkdxfxgFjCEDXMYLys6Lu6C5QJIEPPN9OxOvjrphrEqYVpxbQ+NahA
	Y6o7oQ2xQOrwUu+R6PnMARtlyRmsG8tfSFZm99CjGGk6eynBXBVKIWDGt3Dp1Jp6XIFqa1NFB/9
	qZaGEd2dEqGJqiMvbtlkrND2EMXMmM9eaY0R1ELvme1Z0BU6mnP5N
X-Received: by 2002:a05:6214:3018:b0:711:a23a:281 with SMTP id 6a1803df08f44-711a23a0c15mr194916396d6.65.1757032721590;
        Thu, 04 Sep 2025 17:38:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuZohjFcvi9xTjLiW9tme41He1itQHQ2UbVUwvfQWw3Lg8jdFYcIPQk8JEEU87+AyJpRPc9g==
X-Received: by 2002:a05:6214:3018:b0:711:a23a:281 with SMTP id 6a1803df08f44-711a23a0c15mr194916216d6.65.1757032721142;
        Thu, 04 Sep 2025 17:38:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608acfd938sm1510059e87.109.2025.09.04.17.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 17:38:40 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 05 Sep 2025 03:38:30 +0300
Subject: [PATCH v2 01/12] drm/msm/disp: set num_planes to 1 for interleaved
 YUV formats
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-dpu-formats-v2-1-7a674028c048@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1685;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=pjUEPhdOzoPN8Hx0y8aVOu6btqr80/b31OiPFcm79wI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoujEJ3w9H0sgiKbSsYOCwI2yiJJaK8fGHDXl/7
 ZOVoYJbKxKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaLoxCQAKCRCLPIo+Aiko
 1SnZB/90j2/8ZftKy0xyZheaergMQBEpsiEvBVvhfXlEtu+HzAJBjAEOUlwblXQ+Ygjd0HsxV9e
 xBaJ1l/OxtauN6WlE5NwuFZk5Nf89YVMZ+v03D5CbAlsVMn+FLhzizhHrw0VoZPsQx1Z27k5tEi
 6jRSUhqbN6fN+94jYERIOjUTbHtxjzdJ7spcVxcGzk6QkcFMX9UBqllWURLIDEwzK6WYS/Ybpb6
 +/ruy7WsFUdV5Jb546wmudvXtVGw7j55jtU5jfvKRPmLGPystk9ePmsqmTHi0qDeTNkypzZIH0M
 oRvWreNT1kqRFaAe1JkR6k+O8QgL6B1jqKHxgcUVuW6CeGQ/
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX5Ht9knR/u/p5
 2RTr+LA6qAQoj3HxqMkrJPAq4SMndCoVmnz3poBOGLNC81Ap96lDgNcdcWfO6SyRTDdgnFOnWwX
 fWhwvEJ6zeWkMdHl+KEiAtcdqzbAYjwyQPLfzh5hxDnwRQQErVDW5fSt58KKnAgZvQs0swUqPW9
 mm2IT77VAu1/5OZ6DfSs/llcyHQFa7pzLqRfbA8wTVRMbEug4p4Vz0CT97OC6jXNcsw4UinrY3A
 y714jmagvuhxLGAbp66cY45VyfvnLidJfqzMpkLtq9Scm3IqA8nrjQIvvssDJpFLrZzir4h2pzA
 MTgTtGvUiwwRvPc64GS8b//m6bieZO7cRBBwuwmWfhmhHqP55ZVaaTWXM8g2urD5Q9h99QBiM0J
 3pz7Z2xn
X-Proofpoint-ORIG-GUID: CLx9pwn2LZIKhWHXpDz_UECWWuhNSB0u
X-Proofpoint-GUID: CLx9pwn2LZIKhWHXpDz_UECWWuhNSB0u
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68ba3113 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=DB8TyEHaRv6uusbT9jkA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_08,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300032

Interleaved YUV formats use only one plane for all pixel data. Specify
num_planes = 1 for those formats. This was left unnoticed since
_dpu_format_populate_plane_sizes_linear() overrides layout->num_planes.

Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
Reviewed-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/mdp_format.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp_format.c b/drivers/gpu/drm/msm/disp/mdp_format.c
index 426782d50cb49d57a0db0cff3a4bb50c5a0b3d1a..eebedb1a2636e76996cf82847b7d391cb67b0941 100644
--- a/drivers/gpu/drm/msm/disp/mdp_format.c
+++ b/drivers/gpu/drm/msm/disp/mdp_format.c
@@ -479,25 +479,25 @@ static const struct msm_format mdp_formats[] = {
 		0, BPC8, BPC8, BPC8,
 		C2_R_Cr, C0_G_Y, C1_B_Cb, C0_G_Y,
 		false, CHROMA_H2V1, 4, 2, MSM_FORMAT_FLAG_YUV,
-		MDP_FETCH_LINEAR, 2),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_YUV_FMT(UYVY,
 		0, BPC8, BPC8, BPC8,
 		C1_B_Cb, C0_G_Y, C2_R_Cr, C0_G_Y,
 		false, CHROMA_H2V1, 4, 2, MSM_FORMAT_FLAG_YUV,
-		MDP_FETCH_LINEAR, 2),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_YUV_FMT(YUYV,
 		0, BPC8, BPC8, BPC8,
 		C0_G_Y, C1_B_Cb, C0_G_Y, C2_R_Cr,
 		false, CHROMA_H2V1, 4, 2, MSM_FORMAT_FLAG_YUV,
-		MDP_FETCH_LINEAR, 2),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_YUV_FMT(YVYU,
 		0, BPC8, BPC8, BPC8,
 		C0_G_Y, C2_R_Cr, C0_G_Y, C1_B_Cb,
 		false, CHROMA_H2V1, 4, 2, MSM_FORMAT_FLAG_YUV,
-		MDP_FETCH_LINEAR, 2),
+		MDP_FETCH_LINEAR, 1),
 
 	/* 3 plane YUV */
 	PLANAR_YUV_FMT(YUV420,

-- 
2.47.2



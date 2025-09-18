Return-Path: <linux-kernel+bounces-798320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6215B41C47
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86751648B9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3705E2F5465;
	Wed,  3 Sep 2025 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CaIZcbKX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C8D2F3C0A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 10:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756896721; cv=none; b=PjUwxGzjtuabiR21pfQ0V4YsBtPo2MxDxdd7iuytOE3qnYjBtYJWHcgJgVR0pKR7aTC2FaX5CnyDqbYqE9Wk+HsiPgTM4ikAfQ8Ge68YXT0IMtuhOMKnf1zCWha+yw/iqg6A9bdajtuUwcUAXcDwTm8xzFMuCpvilb+4PaLyPUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756896721; c=relaxed/simple;
	bh=VVcVNBxTp77RP3lwxz41p40biwqdBr8Vq4owPjMXldU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZLQ5bqw0aKWRsbvqKOJPTcXZ/eAPihO1UNr4YrKNqjGnXUWg/mgjXfgxyRVP1GvYYLuFdS+aqcZl3RUdfvCbtGxn2isH+6aes4tQcPyGuRifyruTHiacSeW9/YOAI/QjWZsiWIIeTrxDiB6Qm15IPXyFZWesghOPjAI6jwXXiac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CaIZcbKX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583AMLdM024031
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 10:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W+Fa5j+SX+JfM1Vod9bwyFNqvrYwDkttQ9oWzqXY34U=; b=CaIZcbKXWECiS5OQ
	MmeFWv6gFsrU3AVys1QT7S+kvuEomX4yJ5AjI+Tc3p+bVFpcNL4T4JA2zcHeNF/E
	kNorE3Y+kWGNSnDqtq9ena4quKt552GrN5VsM9CJJeBHG2FFJIpHu54dL452NvDh
	LiCh6jBFbCkcNlOa/sDUo35jRwS+TkMT0Wy5vnlsBMM2IMoP3EKtvHJc6MS1uesB
	zXF3YTf7U16yKnRjCAO+Xbczldu1IeA4MxALD9PxEpuXUSTu5h3/YDI/nktyJObt
	MpcvicV7Us+hajupksmw7FhOEcfc/KlKbVoFcWUNBlYpGd29vgDvdCeG+daHJ067
	dmEqaw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush33751-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 10:51:58 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7222232866aso16721586d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 03:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756896717; x=1757501517;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+Fa5j+SX+JfM1Vod9bwyFNqvrYwDkttQ9oWzqXY34U=;
        b=ClgCFhitSdoV+HtJw79NTL96Jo/sMOEH+zTr/zIrODmdSoq4WhqCFGsw0DeeIuovi+
         UMYMcuYny++RJKQ5RnQvrIVjmgXqFRxH+D6vf/pzQBdHXrPYR30dwH26nb49IG4ntiou
         3nXvR7jHtPHeKgWSONbK04ua5ItULP+Zx653qGY4UrZHQ+tZSCIiRDnWBoTYuZ+G8KUw
         bgMY4GV6jhpnrY/mWBWKjcZ8Mz1SecxbR3fmiSHxhzZ8jL4mP7eawxR7qTgyAOQ4wQc1
         ov2YqezpDM8tQSYcB2neiIm29pv9IAp99HsjaEFjoFKAKZnhwg/q53iozTEmRAMs3k2x
         sJLA==
X-Forwarded-Encrypted: i=1; AJvYcCVxLVJ7TVkiiAyIjZXAbC/Mi5XiskUuvbRGG13XuU+O6rlQYJJISdPXLXXFHeNmIUYhTF6CmoypxTmQlQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsuVA6CVzOtCPvVKGycdvMTSOinj2HaC8TGeA7No/kLgwk8uTN
	eDTPNYnsc4BZS3nDErwX/RTw3Jwgo1ZspFhmdVURBvLa8ns5URp0exfEWzrEtCKnOTwAC5WjVp6
	/JXYZqUbYKL12kVV+2mcx23F85KqIXZiiiU3dRtATmYn++j2EDqloeMR1pQW5XaF+Uuk=
X-Gm-Gg: ASbGncv66nSOiUIlMkttmePMvrFzWMQCZO7VW25k6oo2LJ0Xht227VqOXi5n+XDtmgW
	EN77FUcuzHfDvtY68a8CKeZv0n8s5qw7r11xUVvJgGA8Pyy0zcj3wSbLvEN9vF1KukYV/xmq9lq
	LKS2vGE0uoEaKry/KL1v6ixmM6je3+RgYV07gIupYOCHmyXbo1Ga7KW6Ia6Sze7C4mHk3DvpQ0d
	HdYiGwmy3ZIsGEECA9sOX8Pc64H8kbeu64vMlTqStfAoXQxTbvd8kkBK5Ho9DJ2Fb8D8/7saOuT
	rciMKIZ+zLbNgRG9xjeZm6sDZDN80xQgc1fvUQPJTMImWkQMbzU7USynFGNWMMP1bT3dAvmFRBK
	UuWDrkFDRsqbfvzR9JE6BCZZA93lpd1Lvuy6H4STmYaNlA+iUR63l
X-Received: by 2002:a05:6214:5005:b0:721:93da:1071 with SMTP id 6a1803df08f44-72193da141amr56362756d6.34.1756896716990;
        Wed, 03 Sep 2025 03:51:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExVl9GBAf8uXT9a8bpVa29NuOzWFwU6sdfVsGQld/IevSNRhQnIWf4CLWyosX6NvmXF0Tlaw==
X-Received: by 2002:a05:6214:5005:b0:721:93da:1071 with SMTP id 6a1803df08f44-72193da141amr56362476d6.34.1756896716456;
        Wed, 03 Sep 2025 03:51:56 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f5032df6sm9373431fa.39.2025.09.03.03.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 03:51:55 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 13:51:50 +0300
Subject: [PATCH v2 2/4] drm/msm: stop supporting no-IOMMU configuration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-msm-no-iommu-v2-2-993016250104@oss.qualcomm.com>
References: <20250903-msm-no-iommu-v2-0-993016250104@oss.qualcomm.com>
In-Reply-To: <20250903-msm-no-iommu-v2-0-993016250104@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Antonino Maniscalco <antomani103@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1138;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=VVcVNBxTp77RP3lwxz41p40biwqdBr8Vq4owPjMXldU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBouB3GdCx4xIfhZaEHEPNvhz+Nhq0FHAFd+JqVM
 hN82WJGwZeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaLgdxgAKCRCLPIo+Aiko
 1QDjB/4zbCpsE9Fapn0XIU3XUXuutlBGlGPfODt0yYr1IF7hO8FNc+gXhAPhbcemMkO4je6iUqb
 aYGyplYUcCTYuPaGRX3ot14Yksn6QNBF9ljJkoSmhHR9/GGcacndWC7L05c2vqgSE+SRJRfFG2W
 Zn+JG44gcPcJ7Wh0bCL5tXMjCttXjwY5VR/DN1QesdUuAx8ZMlvqdB/INnQc22yZ+0rJ+usDuIK
 tu5/Xivh7lZpD6vLk3G5ojERUsV3k8V0Wr4XWfsZrtG2GKtWa7OoG7j1cQ1ZWxSkMfWTgPPot+p
 GcLUTZOAMGTKDJLemyZzj4bxZC+N37L/0pVsp2wlLN5xVUEe
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfXyJ4QBFlSIGNG
 xf+YPgb/EMc/F5OM30SbiWve7QMoaCSYFQt+YyKSBSAUhSfY3c3Vu8PLLlu+zQKMshadv/xPGBL
 rnQE4Dksl9OlpByumg4mVakOCK1VkzSAYCbkMVct6xHigpFf24QDRI/X6bPdIAf/8D15S8+1LV4
 cIOWqj87NzbVEr1osHt69VyHz9e5gQVyxMbV7rJC5SOUccWmAiS1mB4aO9nrkhfgMQwtefUSAqM
 lU7HzUSQj73VylijcSqMGKBPYBpHqVRZPrlV7j+Lks83n86OwCLlzSNzuJcmB7pWv8wRSlBN435
 kh9llLTcmb7OcMLeMAVXAzVWEeKPWX1wWDApH/Dsg79t3/LR/DImJcPdgP32Sxu6Emyh1JgWmc9
 Fe/OOukg
X-Proofpoint-ORIG-GUID: dP_TXUAsvFhUD8LEp7ETUNrn6CHYd6WX
X-Proofpoint-GUID: dP_TXUAsvFhUD8LEp7ETUNrn6CHYd6WX
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68b81dce cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Y8FF1qk0yU6lqu3lwJcA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300032

With the switch to GPUVM the msm driver no longer supports the no-IOMMU
configurations (even without the actual GPU). Return an error in case we
face the lack of the IOMMU.

Fixes: 111fdd2198e6 ("drm/msm: drm_gpuvm conversion")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_kms.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
index 56828d218e88a5fa597755c8ea20da781929386c..4c4dcb095c4df97de42d0673aa2842010a249dca 100644
--- a/drivers/gpu/drm/msm/msm_kms.c
+++ b/drivers/gpu/drm/msm/msm_kms.c
@@ -195,14 +195,13 @@ struct drm_gpuvm *msm_kms_init_vm(struct drm_device *dev)
 		iommu_dev = mdp_dev;
 	else
 		iommu_dev = mdss_dev;
-
 	mmu = msm_iommu_disp_new(iommu_dev, 0);
 	if (IS_ERR(mmu))
 		return ERR_CAST(mmu);
 
 	if (!mmu) {
-		drm_info(dev, "no IOMMU, fallback to phys contig buffers for scanout\n");
-		return NULL;
+		drm_info(dev, "no IOMMU, bailing out\n");
+		return ERR_PTR(-ENODEV);
 	}
 
 	vm = msm_gem_vm_create(dev, mmu, "mdp_kms",

-- 
2.47.2



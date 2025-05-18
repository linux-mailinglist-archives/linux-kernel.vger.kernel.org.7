Return-Path: <linux-kernel+bounces-652725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C33CABAF8E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 May 2025 12:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263AF179F08
	for <lists+linux-kernel@lfdr.de>; Sun, 18 May 2025 10:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A523B219A8C;
	Sun, 18 May 2025 10:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ETZPnM02"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54862218EB4
	for <linux-kernel@vger.kernel.org>; Sun, 18 May 2025 10:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747565733; cv=none; b=eoJXjLRCRL5OCagf/7cI9idisF2yA7bEvkFt6vt2HtwSRjZk17r/um5Y8UlqxTWz2+RU5C5rBH8NTIGOr2No7/5to7R8mTaG7V3cajrnAEhP4bEq6ACI7IYFoqWuTVRo8wGEqP3o48qh1S6bZkqPWgDBZbAFGnBWzAfoGNJ4JfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747565733; c=relaxed/simple;
	bh=npSuxvWMmhzKLh8mAO06E84f1kOeMHWURDV7gpjmnuQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tyi6IDip+V4W+fFLdhnDAmA2YpIOdPg6lNczXBFV5CdqHxf7KDQEPO6s7RwIgspryCHS332Ja3t0XXZFpG7b0lWd/tzW05AgKpYBpX2a/2ykBjvA3rLHj96qNdDJTLoHprIOlyuvjGGGRtkxszGKyWy1/8Xi4xbxk5SjYlXSap0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ETZPnM02; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54I9g6fV013947
	for <linux-kernel@vger.kernel.org>; Sun, 18 May 2025 10:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R6N0tvqMMnaFd6rXphyiPbtd6QUTPIJgEbiauM+ZAzk=; b=ETZPnM02ZjSAu5J2
	JEVcF4H9kQ/0c7Yi+AUdLIUokRsCDmC2DYcbXUwCQg+OYr11L6KefBQH1dnf3fL4
	BSwkQuwjpg9yXDpthOn5lGzJ5n30fFcSorYrzf8T5W6aqP4sxWFA/IyODlQ+DEzW
	3iAvnVQwMOypqDwhp95Z08saFNy9KWOlKd5XXg2NY/fuoa4rhhhUCH8TGeTT453G
	LnoRQDbhgII1x0Djlm1D1F7InYIOaAWfjVGdZ6zbJZPEj6ndVgqXPR1aGbymTJjn
	ewB38+ZBxfEoFNNWf92qtfqcS0I/fIrAMPfMZRe26hHJORYDd4UUEGT/4dbfb+e8
	CJVQAQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pjm4hv5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 18 May 2025 10:55:30 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6f8b14d49a4so28464496d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 May 2025 03:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747565729; x=1748170529;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6N0tvqMMnaFd6rXphyiPbtd6QUTPIJgEbiauM+ZAzk=;
        b=c5FzNljFUimUciKy2cVyxYbZhoJHwFDk0uP/D/52cU0RPA//3+FmCOCvpxRmSf0qh4
         zysta5OK0BcovKSLlkzsk6fUixMcKlLRP4ImtIXQzbvMcD3lN+1nWiaIFwZg5+X4ep4c
         9LF/w6rJJg6/T26AOkE+aKlE9ZiN0IQaNJVNl1bgSnD0ChVnSlEsOUBbG6QdLEf+asKv
         y1IES4fLBTJVdMWYUU6oD6w6mRFog5dZAV1selPlHgKqSyLDz8bHJLm9hdaI2lKJyAbt
         zSbRpmOHobq7xmOjb/gvQftWCkb6/bLgK+eXC8rq04ujdnCvTlZZy6iItXonWeSvgbAQ
         Xpug==
X-Forwarded-Encrypted: i=1; AJvYcCWzLt89JBCMhy77u+c835HjyKbqVTmtzpnlhCBHadzXg7ZRr0TcNElqffQIY+Mv4iENC4Ig0VPRHMteloc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZSUeQQVdEfdHSZfSiTBBu1uZDgmb47IH4cdadp1z9/Of9YOPx
	Zh7fy6mb1ADedL8+F4AudTFG6u6eQMekdEYZi4lq4ikF+yJ49OG2VUJzMxw/dw7MtcfO1TCxGrp
	TTwPIgp2xFx89Zjd6z+YiHwbUg1c/EfM2i3Cxt2F+jZ6CUV3HkkLvahaQvxGzBezX/qE=
X-Gm-Gg: ASbGnctHMcEUmupxHvqV6lVkqtfmOkUsBF3XSZX4P98RCmqZdQ7uYpnaqbJXtQ+m5dw
	y2Piob+RlYNkRz/4ZThhaSZat05a7g49Uee9n03um0FN1MqjWKpbO1rJjjcH4keZi4tHQYVWaIs
	ZeVTImnZtH7gnnSNW8CxjkNMLbMnKmkrTs5NETwLpsUpuZS1taIFpVqp0CfKLYc/BDlmd64u5t+
	tpYP8+x9+m/YXtlwTRycPC1EREKTEF/YHtSDcYiJwPABxubyhjL2b2r8rvy+gicSLpVTmQIryQq
	Cn+ebUP7p5zdknZkvBOVyd5QItTc1RMV3nlMWZOU/eNQCtdSNcKx/Ozkx5or0i9N3JscFmvgp0B
	HtxyUl9UhvGAw+LEfSmddyolu
X-Received: by 2002:a05:6214:2303:b0:6e8:ec85:8325 with SMTP id 6a1803df08f44-6f8b094a1c1mr132319696d6.39.1747565729520;
        Sun, 18 May 2025 03:55:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBrNgDaAWSJPUXl4Pq1ttzJ470HNM0rC+ZfMUsp3qTG5xgKN+t5e9KePjsQljKtP2aOM6tPQ==
X-Received: by 2002:a05:6214:2303:b0:6e8:ec85:8325 with SMTP id 6a1803df08f44-6f8b094a1c1mr132319546d6.39.1747565729174;
        Sun, 18 May 2025 03:55:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-328085cf8ccsm14314451fa.99.2025.05.18.03.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 03:55:28 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 18 May 2025 13:55:21 +0300
Subject: [PATCH v3 03/11] drm/msm/mdp4: get rid of mdp4_crtc.id
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250518-msm-gpu-split-v3-3-0e91e8e77023@oss.qualcomm.com>
References: <20250518-msm-gpu-split-v3-0-0e91e8e77023@oss.qualcomm.com>
In-Reply-To: <20250518-msm-gpu-split-v3-0-0e91e8e77023@oss.qualcomm.com>
To: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3130;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=npSuxvWMmhzKLh8mAO06E84f1kOeMHWURDV7gpjmnuQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoKbyZ9AeY7obsJ4wix1fDb2P5WNV2DJztH7KUX
 3sUn48fmuSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaCm8mQAKCRCLPIo+Aiko
 1YPGCACN8kXmecU+jG3vEQvTISfrFHslcPAcRaXFPhbbi4VHPcFPFd/CUJ/AH9rrZnpVoBDZy6V
 1PVdYXdiazunhHd8l+Q+3DK0QPU3kMNS7CQWosLuWXXsk+mo5dZDEZ1KEee4yOFgZhp/wah9ghu
 /pNvAk4d7lrD/lYKjbjsyIBNPDkTPHdmS84bFJmCl1Us5guAjcT0Nev6LbOl095c/43foQOEUhk
 BCkAL6TS7XGsy5N6W9lb7lQG1n/f038edX+/tL13aSCY9xS8+K2sIzLP/rdwzJb0lSlEyncAhaa
 2jjXKhtiP5QnmxP+LTFc0s5aIZLqn+wQfTqgjpyhyYUH7ely
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: htQv1g8tOemSnFvC9DLS5to7xq4V5FtN
X-Authority-Analysis: v=2.4 cv=C4bpyRP+ c=1 sm=1 tr=0 ts=6829bca2 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=JeS6effYNUkig2QXyjUA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: htQv1g8tOemSnFvC9DLS5to7xq4V5FtN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE4MDEwNCBTYWx0ZWRfX89WzwkcJPgPL
 AmK70oaiKSpQ8VUZyfnOjvBF6aQplNkAK5IC2Pgzklih/+9usI78PT/hLSFctlBT3lFFgc2Cd36
 Qtxrww09Txrh/OLOb2Vywd93+aeE64gG34Vy1kLYFRxJTZ2UScj5i5gkjGMwhy+INVZSMpqTy5c
 xJhIrL9qXzsZjcRoMlOlh0iy8+GAmDWbkibhWnMtTmCTnrzexjLfhNHdGBu6Z2h/L9+b5rVY4LF
 oVCkv80z2fufXETR3gUxDuPmGGwAOD99FYimqZjpduesUJ/6ZchGOPRUi25MubMVxyPsvklXr/A
 HpauEnbG4Fh/3UqUhl9+9lnWQaooCywQlX8Kd/rvAnbxtO0nE+6TQGtk0UsRQR0z7KJLGw4h5uw
 MfT/fEhPveuy7+/W0bkz3mFkIk5lAtKYCwl2vHE7+n9B1bq1r/iqkXCt/0fXzpe6vsQfrJ1P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-18_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 mlxlogscore=998 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505180104

There is no reason to store CRTC id, it's a part of the drm_crtc. Drop
this member and use drm_crtc.name for the warning message.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c | 7 ++-----
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c  | 2 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h  | 2 +-
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
index 5e1e62256c382426f70d21a5312fb40dda68d695..7596b45e234bdcf1b7cf37c4a8d39862f48819a8 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
@@ -17,7 +17,6 @@
 struct mdp4_crtc {
 	struct drm_crtc base;
 	char name[8];
-	int id;
 	int ovlp;
 	enum mdp4_dma dma;
 	bool enabled;
@@ -539,7 +538,7 @@ static void mdp4_crtc_wait_for_flush_done(struct drm_crtc *crtc)
 			mdp4_crtc->flushed_mask),
 		msecs_to_jiffies(50));
 	if (ret <= 0)
-		dev_warn(dev->dev, "vblank time out, crtc=%d\n", mdp4_crtc->id);
+		dev_warn(dev->dev, "vblank time out, crtc=%s\n", mdp4_crtc->base.name);
 
 	mdp4_crtc->flushed_mask = 0;
 
@@ -624,7 +623,7 @@ static void mdp4_crtc_flip_cleanup(struct drm_device *dev, void *ptr)
 
 /* initialize crtc */
 struct drm_crtc *mdp4_crtc_init(struct drm_device *dev,
-		struct drm_plane *plane, int id, int ovlp_id,
+		struct drm_plane *plane, int ovlp_id,
 		enum mdp4_dma dma_id)
 {
 	struct drm_crtc *crtc = NULL;
@@ -639,8 +638,6 @@ struct drm_crtc *mdp4_crtc_init(struct drm_device *dev,
 
 	crtc = &mdp4_crtc->base;
 
-	mdp4_crtc->id = id;
-
 	mdp4_crtc->ovlp = ovlp_id;
 	mdp4_crtc->dma = dma_id;
 
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
index 7e942c1337b3597d557abd3e2e418c3958e5eb3f..00920bd44f6f73099ff2c293473e427caa49b873 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
@@ -338,7 +338,7 @@ static int modeset_init(struct mdp4_kms *mdp4_kms)
 			goto fail;
 		}
 
-		crtc  = mdp4_crtc_init(dev, plane, priv->num_crtcs, i,
+		crtc  = mdp4_crtc_init(dev, plane, i,
 				mdp4_crtcs[i]);
 		if (IS_ERR(crtc)) {
 			DRM_DEV_ERROR(dev->dev, "failed to construct crtc for %s\n",
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h
index f9d988076337cb6fb63af8e76be59b2eb34ab327..fb348583dc84de5c57c77fdf246894e9334af514 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h
@@ -185,7 +185,7 @@ void mdp4_crtc_set_config(struct drm_crtc *crtc, uint32_t config);
 void mdp4_crtc_set_intf(struct drm_crtc *crtc, enum mdp4_intf intf, int mixer);
 void mdp4_crtc_wait_for_commit_done(struct drm_crtc *crtc);
 struct drm_crtc *mdp4_crtc_init(struct drm_device *dev,
-		struct drm_plane *plane, int id, int ovlp_id,
+		struct drm_plane *plane, int ovlp_id,
 		enum mdp4_dma dma_id);
 
 long mdp4_dtv_round_pixclk(struct drm_encoder *encoder, unsigned long rate);

-- 
2.39.5



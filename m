Return-Path: <linux-kernel+bounces-768366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBD2B26025
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 640FF7B294F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3782F60AF;
	Thu, 14 Aug 2025 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UGz+aJr3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583122F60A0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162239; cv=none; b=XlER97nyJjBGn1662BVPNqMdj4vosQ3AZrW3VbU+zSNrZe+UhrJ37oBWvKcWc/YvDAsw+Bx4M7XPkGx+yz9xoQQgOj7EGoCLGVOngGpAiPnv67BGPylvGRxrVyykwLpNMqZFCNvkj8W05PmZAhXkXLzHcr3FRJcF4H1er1l0L5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162239; c=relaxed/simple;
	bh=YsXZpPAaNSeCnyMCCLmHOfqq67CcDMLsx+wfM4OBZcw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hGjBdLOloRLkUM7mvL1cULd1OENr1YEvNdWz5OCuOFMW/QusXUmsZaHcJmm52weU1wnoDop5ZYE10C2Hg+M3EljUe8iDnUj75amWt8xZt4C9jvXZ0pu8P8LzDiTUd9xvpsGYmNDLoVTgVWnZva+kEPzcUoEESUcjitGSPhXCIuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UGz+aJr3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DNJ8Rk031866
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=rGGIgrmmsmbimgDt4vADL8
	x+TnC6/clX59aBfoICLGQ=; b=UGz+aJr3XrtRjYKMQREbXjEgg1DI0Nmc0P0vkT
	m9Yf3FFnzBeGb/g437vbmMTJMFs0d4g8NGCkiFxkX5roEnYLhY6VuGwTkjaX8Hph
	sjpiBSr0vwCQ9r5wQIEzM4dlCBktf21na9+Y9tIRm6l7ROZ+Dee8Ihu+CtHSzbST
	Tdcc5BegwboSt+CV5oK66CQLFD1meSSPpzI2rcwGWQXsd0q2x3DfgIOCZavFzdOD
	bSGkndYTdrAM4AhOWeK0jOLwLYReYUTW5wQ32MvOmX8PzzpEvVkJ+bWvwS5/StIQ
	CxgMv5IbzCVxB/YNBTefbr7OPpIZluQwpYufY+o9puMJw9RA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fem4k124-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:03:57 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70a928136a0so24969706d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755162236; x=1755767036;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rGGIgrmmsmbimgDt4vADL8x+TnC6/clX59aBfoICLGQ=;
        b=s937o6KZ+Nf8HZv/IZ07l1MyLYEaO8SKZ2qMaPNJfYPFEGB2PNSuKKxqxKTBejF/gS
         VAHL5zjGnvWMQcJHHKMDsq10f9zfg3ja8vlh8HVHx97DecJwn1HfJpRDSFFBeCaJe3lw
         Pe9lzO046oBWObx0I/xNhCb+2zOqeaI/J6xB2olU+mug2mxtjKM4pmz/D2ufYERQ1Hnu
         6XZ+y1UyK+NCssFdmWOwMrzSLGQQKIzPx1wZIUVlKO2nDF9aXc7D3C3HV4r7snTskN7i
         YinNDpQMt2Jm3UZrxgqzAed0SFdlHQGferHmVnKO9l+Gqa8aDw7L3r/5y+CD1Xm2v7uY
         bW9A==
X-Forwarded-Encrypted: i=1; AJvYcCVgoPFAo6Jom3vh9QBPU1YHTtVDxeCbKCtgLw0KxMYILg986wqeXlxnx50ShidrvmwYqrGkMCIkRAc69iY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYSu9J62eYqDHjTYF4ZvdWPZlDuxIC8S3UllINGx2WQWtJCsBR
	SfU5qpy5XXOhry3ZmpFNFQ0Lc/8I9+B4TXHTLWgCeogqdDGV6q+twIGZrAKSHwD3Wvv/3/pgkfJ
	kx5gSM6YQVPMcRdSfsM6BNUw9SsqNOu2CwC7BuABVDv8Sv8jfoW89N3FZQ1zZTXNVB+0=
X-Gm-Gg: ASbGncu03J7dr4evVoVYwku36THX3Ff0HFNGuGiLbDgx70VhbLCOm87cfBY2ENXWzHX
	+9BRrc3YYApNokJ51AI3f8k/QXN2VOKk27f88blAdrOnvFJm65ffxTqLVyKWS88SKtJlnt83xZi
	QZBSeVjPKaJw4bNGWzd5XpEgxmKivz70lRv5h5r6Y4DTnQskkZqHEq8hzluHVGiFttrDsHcmXwI
	PLZoT6z8KCQOpP73E99upmfcWupQVDL7Dmcg0ipXaVDE4f6JOKGrRc/3ldtwmUDRDV9/BodqRCq
	jHeG2Y2hAfb256BrHugW7wiWKm1qAoIfwKlK1m1nriI6HtGQEIGqSD/XP+EBfVADMORCOlj9oKb
	eBGDUToaVdX1Q5d85X+iBTosdtuo1Kfw02/PcOQWNXImHdg6vkceH
X-Received: by 2002:a05:6214:dc6:b0:709:edde:4c0d with SMTP id 6a1803df08f44-70ae6d3710emr29798356d6.8.1755162236376;
        Thu, 14 Aug 2025 02:03:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQ1HL/zHxuCTsnkJlePNuWvPNebHmrVkEdAt8etPB1DsMCZbdV+ybwNuWXk1pRpyEqmj4zHw==
X-Received: by 2002:a05:6214:dc6:b0:709:edde:4c0d with SMTP id 6a1803df08f44-70ae6d3710emr29797866d6.8.1755162235837;
        Thu, 14 Aug 2025 02:03:55 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-333f8cec11asm1720061fa.23.2025.08.14.02.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:03:55 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 0/2] drm/msm/dpu: use full scale alpha in generic code
Date: Thu, 14 Aug 2025 12:03:51 +0300
Message-Id: <20250814-dpu-rework-alpha-v1-0-b4baa4ffa8fe@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHemnWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC0MT3ZSCUt2i1PL8omzdxJyCjERdAzODtDSzpDRTQwtTJaC2gqLUtMw
 KsJHRsbW1AOj5nThiAAAA
X-Change-ID: 20250814-dpu-rework-alpha-060ff6bf5185
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=818;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=YsXZpPAaNSeCnyMCCLmHOfqq67CcDMLsx+wfM4OBZcw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBonaZ5pHml9oNbOWl15GmrKptxv7thvICknjHEj
 I5Q/zBSdnCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaJ2meQAKCRCLPIo+Aiko
 1eYkCACOy0N/ydD63zVefNmO4rL9mm/EAsrC9DOD7tCihUGn5WrYCi1O3wFsMtzA3mlk5ckgJxL
 +vgK8mUH3LyTGJA+O91ZyyBplFNGQwKGSi/KnVC9LLK1fszi11Tw+h36B5nNJQj4FVp7/4AJRdG
 obZxBc0OTGxv+q9fe9tOjdZApd6BKuU9e1YidBSPv9bEhlQurDuqBiBi+aBWS+nAQ6stTkgxcJO
 KVGS6Ry1RlKgEK6+s40NaMtdTbeda1aNmj6yi0x4deum2geO51PLWV04afRFcfAjPK/ZSEI9TDR
 M4EKf/FzT7DcfvcraY8sbz2+eD6kPPGiOZ9Di/3ICMhcHt9r
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: arxJ9RlfRJu7DnazMQ-k3ZURIfcVjZb1
X-Proofpoint-ORIG-GUID: arxJ9RlfRJu7DnazMQ-k3ZURIfcVjZb1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2OCBTYWx0ZWRfXyqmSPgErhAWi
 HFCZ5vVrcEpCZy4piMbxE+RApdXkmHPfYJ//309bButvZsT3SzOg5VEk1/Me43ueVirThXHvRuI
 jqvMIhLq9PXdKbMSvEFiLzEhg5emYX3o7nzbCufKDC67bGcfHuuwlhwUKU+MlDewL8Xh0tIcl+B
 3pTgPXThbFvPsYqBKvoQXSY1i4Q48WAtVZ24mKaCn7i0bIbaoemdKf9dCR+n2O42OYv7NTrV9SY
 hQatViR9AdwqAHdJUy0+Cv/XDa/Rr4+VmWg5Kq3xo8zc0gHFwodtQxN3E7wSqz43WO0Qax4Fmm4
 lW1Y3iKb703ycnHyfANP9jxjaJJqh6F8HZ+V9fJEYQB8NaL01U7mPJiTCUE7fMWmLbC5e0v5ozM
 7uaglpD2
X-Authority-Analysis: v=2.4 cv=YMafyQGx c=1 sm=1 tr=0 ts=689da67d cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=XoDkaeHCiDYGaMSRgogA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110068

Both _dpu_crtc_setup_blend_cfg() and setup_blend_config_alpha()
callbacks embed knowledge about platform's alpha range (8-bit or
10-bit). Make _dpu_crtc_setup_blend_cfg() use full 16-bit values for
alpha and reduce alpha only in DPU-specific callbacks.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (2):
      drm/msm/dpu: simplify bg_alpha selection
      drm/msm/dpu: use full scale alpha in _dpu_crtc_setup_blend_cfg()

 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c  | 18 +++++++-----------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c | 10 ++++++----
 2 files changed, 13 insertions(+), 15 deletions(-)
---
base-commit: a933d3dc1968fcfb0ab72879ec304b1971ed1b9a
change-id: 20250814-dpu-rework-alpha-060ff6bf5185

Best regards,
-- 
With best wishes
Dmitry



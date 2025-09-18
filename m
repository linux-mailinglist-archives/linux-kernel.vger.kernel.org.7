Return-Path: <linux-kernel+bounces-798317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1114DB41C40
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D8241A8641E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FFD2F39A4;
	Wed,  3 Sep 2025 10:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K/QqQPoo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCF62F39A2
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 10:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756896716; cv=none; b=mPA+yjCuiaSvfNCm07vtCQ+gvLdGiWesZ4+QhMB0dh4p1336A9aPE2yrT3IwDVZVzMwZ8hb2EcMyIPNSPJ9ds/l5Qk8LAW55Ex5EXg26+qlcaKZVlpj5RoLoq59jiESY61jTlHg4vYPyHk3gfzplJ8D4HXBbc4bDcpeIp1ayPZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756896716; c=relaxed/simple;
	bh=MGkvf+l4O5VdeZJFhXd2WuETJysbLK+DKxuiTwq85l0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CFC/9MufnB7j9rhY2pR7TuOWUdl5TQtZYg+Wi3pEPwR+0ZRsZ77eAy815wSs64gwi1EfR7yLvI/Dxf9g7ehIbKuzNDkI1sGzPe4lP+zneQtP92stu1XG8gvEGFhymyXShT2GJDSC9KcEO76jNtn+Fwo8jP5+nb1PeOKR2mqKso8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K/QqQPoo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583AX0jv012699
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 10:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=F+ziFaz1rWekejWHwi36zb
	4EESMqmllljwggK91XpZk=; b=K/QqQPoo6L7LM1H6nl8lMTFZWvW6xzWSowgy/m
	NWbxamH9dcdq2ooC1kOE3oS09KoVnmSj/SpvlK7onzrWGGiLnwQ4h85yolOeP1p7
	wy38SLbirlYzY5+UlZaRsjuC9Epc59RncWQQQQi0xZ3ClL43tLqmx8Jsjvf8Yg0T
	oxaLOJksjUkQtdrAD53hawoCKsEYfFgjIAvPpQ9PfWd9Q019mMgYsy4ORy5Mg+oF
	6+IIYchejXUxxGDvbX+RjyR1r63WpWsL8pmWcDFZ/UIex893hMDN087UhGgboaPv
	bGRNooMxwvPLcG+PIr7YF/s492pa36Lb/Q4LPvnMjIeIQ7ZA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk9350b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 10:51:54 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b3316dd5d0so72840801cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 03:51:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756896713; x=1757501513;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F+ziFaz1rWekejWHwi36zb4EESMqmllljwggK91XpZk=;
        b=FCoje3OHAS2+SfxEGWbMlKwDaNg3vqIvTaNnqDarvp7marrCKwB/4Sn6AawOCTrWKd
         D7SzZcw3J+JjjNY61oqX8JBj6gB5AqpsypjoWCDVxSZxAUaGCwFH4sDoHZR0YAe53cVF
         UB9O4XvR4DjguCwB/dqn6Jsj1VZVdYhU2YiNTBKN1caYDex4PRS9sShmSa5FYFUN7qmX
         kOiUle91G0aHOVoKw7H9ZCgy27N4EhcRwTFwZYC/bYE1rcHd8F7LcNtWbt8ui0+Vwj50
         1fDQFingNlIpSGU0d1ut9RNlwxotvJxmfvGg92VbkFE7TwrdoTK78UTZVgt/TRa/mzd1
         asJA==
X-Forwarded-Encrypted: i=1; AJvYcCUzOlhdP0pmC/ie4E/rBcAziJuQU96gogxb39brAnGw9jmnNdzogaI/+H4miJNCIHrJdCWUAkAaFnohHgE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Ldl1DqoXuld/J1opC+ln5vKHe1Zy8OrgHS6o2CV8VQ+auy+a
	hWOG1aWz6aPfjuf6+g6AD6hZ6yLcTcyGiabkGhs7rQ9YsKi/30gkZHWIsCxbBdQNgmur+pX6Ck6
	4CP4cbUsF5yzc0Nzqcx733e8Zsmr9c2Rm6LAiLznmSWbqpw9F/Efr5mOhkpdPK1qHlho=
X-Gm-Gg: ASbGnctz0hf7sTZHguuJTy9aG48vk2TerDs7/3FXTgBin3nBXy/mAfnDwCSDiwBzfxU
	OovDp/dgrW6v6hsK+fMgGJtREXOYrkPNx0lKNAv3132lSxHkGHoY2AYwVE3EZly83JxcdajUUw7
	8Qps8BKslnTiH9irwi4mRYBuriMVe3EApADP03W6rRKEMnIQyTUyv4WxW8iM4MxV454298dBGHf
	vO8ZkR/vvkWsEUpvTogS7JJX860nOGVCgq2RlDZ4NEKVE3ekIRbpZg7kVOA+xgx+6lhVgqH4/7y
	ZPBln73m68MUHcYLvYRzclBwkSFGE45IJadpGHxg7tn0GYXzkknX6+OvzzV5Wg8IOGd0NNVfU+6
	Z44yiENxmnFRMUE8ugVdWlAr7RhpZQ/41z5Hj+4QeuAJpKs6KAfB8
X-Received: by 2002:ad4:5c64:0:b0:70d:f0ff:342d with SMTP id 6a1803df08f44-70fac6f6f89mr193125666d6.14.1756896712974;
        Wed, 03 Sep 2025 03:51:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+oE8bnboYguqZQN5BC61OgK8HvWDhBjVq/4qLeNHb+8IGeU7beHO5wd+DfDZC2hphZGhD1w==
X-Received: by 2002:ad4:5c64:0:b0:70d:f0ff:342d with SMTP id 6a1803df08f44-70fac6f6f89mr193125256d6.14.1756896712477;
        Wed, 03 Sep 2025 03:51:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f5032df6sm9373431fa.39.2025.09.03.03.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 03:51:51 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 0/4] drm/msm: drm_gpuvm leftovers
Date: Wed, 03 Sep 2025 13:51:48 +0300
Message-Id: <20250903-msm-no-iommu-v2-0-993016250104@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMQduGgC/3WMwQ6CMBBEf4Xs2SVtEaue/A/DodZVNrEtdoVoC
 P9u5e5lkjeTeTMIZSaBYzVDpomFUyxgNhX43sU7IV8Lg1GmVVbtMEjAmJBTCCN63RptnCLrPJT
 LkOnG71V37gr3LK+UP6t90r/2j2jSqPBAe2O3l0b5pjklkfo5uocve10CumVZvkY5GkyvAAAA
X-Change-ID: 20250706-msm-no-iommu-c15212a0e7ac
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1552;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=MGkvf+l4O5VdeZJFhXd2WuETJysbLK+DKxuiTwq85l0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBouB3GGf4Kjd/cIzyu2pmb5W+K/wasDzXjueuus
 0DbJBvZJhiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaLgdxgAKCRCLPIo+Aiko
 1Zf9B/4itJZUTUpMWZDvWYi472LehjoEDKy3UneWue7O5f7Zfm7RDZs5oxtf3Wj03s68j8NEQwa
 v9OUPdMfPoYgtAm6xBFequpK8wf2/245nwazaNap52oTK6VzEX+ZnPEw/35X0sxbtGT/NnRPS2L
 gOKsW97YLTzQXR0QfHuf7N3VAu7VZO8rGnrMI25+jl0EUayRrjqHyixPILRKma9KCWIrLXQH/bj
 5Ee8FO0fo7FznKRIhTQvvdV08/PldL8nSl9FMVQYnrq0EOvE7YYJt2GLX99OfHn+HbgpirXkTOL
 TS8CqbH811gqAirhiJz3gS+VL1imXzrRvFXHMpB6X0P71/NF
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: _Iahia5_oS2qNhum1lwuH-J7Zfr1pJNH
X-Proofpoint-ORIG-GUID: _Iahia5_oS2qNhum1lwuH-J7Zfr1pJNH
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b81dca cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=fyJ_PAsbgmF_WMsuyW8A:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX/dM4oLn7XFnx
 lOFBM6vQWe9IogKbVFzzbERGTIHQOjLvfu4S0D0nCXpUv1LrsI2fw2ipgcqVt349EnrA1hcb7Cu
 PO7rBisUY1wgloPk8mb2kRFsGs0Yawzl1zZJmgn5cDH4vutHZL3kMsLXQw1bJk3Mgi8fmc07K/I
 3VNlvNuMMeuGOh4nwsCOH7QTGP/Rxsh+jPzpw+aCyUUbzzvx83dQN0/2SfXf9pE/htTXk2E14Oq
 D0tmtjSJDN8aeAqCXu1z74+DlX+xmjdwukwGoOap2frt2OoW2UfCz4QQosB/EMN7WHI/VQ9hWTs
 pbMPWmYieaM5fWZe8N6psEK8T5rDJTNYXJDCiGAR15/D3SFM+y3lmLW4UiUnQ/y9+NyiRnXvS0d
 V9dLiz1h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042

After switching to drm_gpuvm, the IOMMU becomes a requirement even for
KMS-only devices (e.g. allocating a buffer for DSI commands now also
requires the IOMMU / GPUVM). Disallow non-IOMMU configurations.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v2:
- Corrected error messages (Konrad)
- Changed msm_kms_init_vm() to take mdss_dev an argument (Rob)
- Made msm_iommu_new() / msm_iommu_disp_new() / msm_iommu_gpu_new() fail
  instead of returning NULL if there is no IOMMU
- Link to v1: https://lore.kernel.org/r/20250706-msm-no-iommu-v1-0-9e8274b30c33@oss.qualcomm.com

---
Dmitry Baryshkov (4):
      drm/msm/mdp4: stop supporting no-IOMMU configuration
      drm/msm: stop supporting no-IOMMU configuration
      drm/msm: don't return NULL from msm_iommu_new()
      drm/msm/mdp4: use msm_kms_init_vm() instead of duplicating it

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c    |  2 --
 drivers/gpu/drm/msm/adreno/adreno_gpu.c  |  4 +---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c  |  2 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c | 27 +++++----------------------
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c |  2 +-
 drivers/gpu/drm/msm/msm_drv.h            |  2 +-
 drivers/gpu/drm/msm/msm_iommu.c          |  6 +++---
 drivers/gpu/drm/msm/msm_kms.c            | 14 ++++++--------
 8 files changed, 18 insertions(+), 41 deletions(-)
---
base-commit: 3cf6147f2b51a569761e1ef010efbd891e3a3a15
change-id: 20250706-msm-no-iommu-c15212a0e7ac

Best regards,
-- 
With best wishes
Dmitry



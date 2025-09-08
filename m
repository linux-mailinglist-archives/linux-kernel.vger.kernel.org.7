Return-Path: <linux-kernel+bounces-805314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BE9B486FC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FA1F189B1BC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1662EB5BF;
	Mon,  8 Sep 2025 08:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HESkbmRe"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707002EB84A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757320054; cv=none; b=sQtPkNh+8IZRIbSsiYy5RvkR9D5Ei0FqpEG4krdvtMRwTc4ouP91xJ30gzv3+2rBbMLN62sgeTXlcBghT5TKPsBEnQduAFrhGPWiRgrQvxp2kGilpdygJqNFksel3Max8iiqQaSAsar/azDvSMCsam/rBYgpqTz6NsRcbhERVgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757320054; c=relaxed/simple;
	bh=S5MyjT4mTPIr5LgIuanSA6/wDQeDhSOhfpOFVd2mIS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HfYEuczwWoFG/xHBEqEpJDNig6+3pwIktXHdwqgifbgbzRNNlfBf/Lv9wBn2wAzSqKFPTv8u9Xlu9ArHBa8mj0+By6uEEFnDQ5fZ7NikomD26sMnrQBCTeeEGAXuUa61z98BRiunyxP8kYzbcXVRLZ2EJyaWos1AR23Xkrph/ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HESkbmRe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587LjLFY022845
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 08:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p2//K0CcjRV6S1OvPg1jKb3Q1LCMP0xj6racf95PPvM=; b=HESkbmReO6y3QZok
	gl1Li8pjoQ6HCs0leP3239zXALUAfSMNm4UfvyBH6aAnhazpVq1peYy8SiuYtTJV
	cW3SdgZqsbqxP1+HKIM3/QZyjvos/HszrB7rwCYkKYs6RjUmnJT5mz0IBOt9lAz8
	Zj1CZKcS+4wBjnPRwM3VTlZcJPUpcPuQHfRu+WBeRPEnzYWXkON7DQP8+BlM6XxD
	tO4s4WJF/7qSR33QoiTy+jx7tfwl+yIvv3QemUuI1f7/hgAKrd8CLgP4/LWnmSia
	wNQpdCPXVWLpAN3msKQomxDuq+OqoSaEYuTjDdpEPWW99qQKo+ig+qVwaKbGOeKs
	QcQZfw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490c9j3vd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:27:32 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32bdfd536aeso2170562a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 01:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757320051; x=1757924851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p2//K0CcjRV6S1OvPg1jKb3Q1LCMP0xj6racf95PPvM=;
        b=oVHnox65+mHXu0Ul1UgTNN5aPMDU+7uwocC9mSPdzTC3bukuIa9fKYkqNDcqsaWsEH
         qeNg4ewXNTGzpgrmeiidG6OuesrB/dPMQ9MfR7geg+6QJU9gOYLahyL/PQ6onBixbtc6
         w6jM3dXlRNS2NfOHS6tK6xkM1v6SmOhZ7s8Vdb7WbhuJNLqNF/FpfYsbcwAJi0sflUlY
         5od+Eksnm+VVYM0HB0oa0izSmz9LeHkiXPrPC8E7VWYwFDWsFzQ2P21rKsTypDAKraLe
         T0Y6xWX7cBJuEiDBHCXGwsIGySLZfvXaNdyamuUektY0pxk2ErtK8HkwAZG5OmmSI8Ny
         kPbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE7UNboLwbjGTPsHQP18SKBP0BSXlS0csW4fdnKF2PP2FYim1d5YCCmC2alc/gZ8SISd6ND0TUspk3o4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi5RobEKBCnG2GkjrFqON/ifFVX0oQBnOQ/z6wpM9XZ2MvUkv1
	+ak/kf3TDl2oXLvzx1prc3Hx8AYdZQpdMhrZufLiAlQQYcZO8VgiLt7PwajdR8Agm2N5y4Qmh8Q
	k878KUkfy/5iHdk02AgFsL5nm5glM40GyaWRqyjWai8UMZJwTPCO3nujzLdMHVnsuiRU=
X-Gm-Gg: ASbGnctGvxSJcokgbLJC3Hukdm9dZYbiZ/suHX7uJJXaxYREBA/sR/1a+SEx4qVkXYM
	Z4DRkH1F/+lrAJyBVEclNVzZs+Y7HZk8Bd+NmbbRfoFCTm3202+3LSkABbeCbflLma5mT+YeYGd
	jzYS6J0givfPBrYNLZfQlJCOJB3hv75GhoOssA/PFroxHCky8HBj1mEXeQ0QBskuklZ2r8/w3P6
	TctF4CqUsbcTL3Tbf7oSXA89KSz6o6X+QgubKcvOMp9zBPC0txH0wLYSKX14FqziSqBGrb7h8bt
	CPKF7Y0sqLCsWmhiNwWARiexAMQ/krL61H9GaMxQAkCAyxLCRG1r76DtxspL2HTM
X-Received: by 2002:a17:90a:ec85:b0:327:4bd2:7bbe with SMTP id 98e67ed59e1d1-32d45037837mr9250962a91.4.1757320050721;
        Mon, 08 Sep 2025 01:27:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQqf8fIoETWqNunksZyViPasQDDwI23kKzq759z35d9ls/mhv5q1lAbeOT1ENDFbBHUWPswQ==
X-Received: by 2002:a17:90a:ec85:b0:327:4bd2:7bbe with SMTP id 98e67ed59e1d1-32d45037837mr9250933a91.4.1757320050266;
        Mon, 08 Sep 2025 01:27:30 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26bc9csm29157523b3a.18.2025.09.08.01.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:27:29 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 13:56:55 +0530
Subject: [PATCH v2 02/16] drm/msm: a6xx: Fix gx_is_on check for a7x family
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-ifpc-support-v2-2-631b1080bf91@oss.qualcomm.com>
References: <20250908-ifpc-support-v2-0-631b1080bf91@oss.qualcomm.com>
In-Reply-To: <20250908-ifpc-support-v2-0-631b1080bf91@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Antonino Maniscalco <antomani103@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757320036; l=1562;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=S5MyjT4mTPIr5LgIuanSA6/wDQeDhSOhfpOFVd2mIS0=;
 b=QHTLwKJPH/Cp1iIj/Fl88V5fVglSuhT3lfuw29UFrtJ4pIvQmTy0iSPN/uphabTvjR+bkY1rG
 L8d4gkxS68TDHiUvGkbMPXGZMUpyxRUFcrlDZ16WT2kVL+5wb8C8Sq+
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMiBTYWx0ZWRfXxI82p51QCdwl
 w2wHoHuD36kNF0AazUiBDVNIBjHfKq3eNgNis4gXFAo9wsdhv8kUwPv4c3B6cuWm/Euop+yPPEo
 8lshT08wko/a9mKNvnkTMvlVko3ZNG0e2wMFDmt2esK5hWs1hVXywXhpsRI+zg4nrRg8y3qn/7m
 5gPI7UEGyEzh8tw1hf6g/fdbGmbwCGZLpDJS8ze9hBlhIitdnYUzfQc4aAT1oQN4bjzAbnSI57o
 QPzHQOjoIIe/Z13TnBVIWeOybR4SqssBJfxzfBXEDL7ZrYiThY2Yo137Lr+kCwaHSn+Vbz9v4MX
 3n9YRxs20f9kO9XdrHdIXR7Q7Oq3Nk6YaXyjPAte2KigbnFvbvX72zi62CVRrXqB6P9qiKEjrDI
 C5t+5XNR
X-Proofpoint-ORIG-GUID: c5clz80Ng7FbxD4wBl8sDqEnytu2K_Kh
X-Authority-Analysis: v=2.4 cv=PpOTbxM3 c=1 sm=1 tr=0 ts=68be9374 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=lIJRztabaMjLl_BANJQA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: c5clz80Ng7FbxD4wBl8sDqEnytu2K_Kh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060022

Bitfield definition for REG_A6XX_GMU_SPTPRAC_PWR_CLK_STATUS register is
different in A7XX family. Check the correct bits to see if GX is
collapsed on A7XX series.

Fixes: af66706accdf ("drm/msm/a6xx: Add skeleton A7xx support")
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 28e6705c6da682c7b41c748e375dda59a6551898..bb30b11175737e04d4bfd6bfa5470d6365c520fa 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -93,6 +93,8 @@ bool a6xx_gmu_sptprac_is_on(struct a6xx_gmu *gmu)
 /* Check to see if the GX rail is still powered */
 bool a6xx_gmu_gx_is_on(struct a6xx_gmu *gmu)
 {
+	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
+	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
 	u32 val;
 
 	/* This can be called from gpu state code so make sure GMU is valid */
@@ -101,6 +103,11 @@ bool a6xx_gmu_gx_is_on(struct a6xx_gmu *gmu)
 
 	val = gmu_read(gmu, REG_A6XX_GMU_SPTPRAC_PWR_CLK_STATUS);
 
+	if (adreno_is_a7xx(adreno_gpu))
+		return !(val &
+			(A7XX_GMU_SPTPRAC_PWR_CLK_STATUS_GX_HM_GDSC_POWER_OFF |
+			A7XX_GMU_SPTPRAC_PWR_CLK_STATUS_GX_HM_CLK_OFF));
+
 	return !(val &
 		(A6XX_GMU_SPTPRAC_PWR_CLK_STATUS_GX_HM_GDSC_POWER_OFF |
 		A6XX_GMU_SPTPRAC_PWR_CLK_STATUS_GX_HM_CLK_OFF));

-- 
2.50.1



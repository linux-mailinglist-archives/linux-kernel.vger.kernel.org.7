Return-Path: <linux-kernel+bounces-796307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F745B3FED0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F3683AA61C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553852FE078;
	Tue,  2 Sep 2025 11:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jjBZ8smv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5172FC029
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 11:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813854; cv=none; b=X+BYvosYrV8Xf92ug34J1E/H8B0SF48hNwHYVEHKfgnKJADOcn/MOzUkQZNfOxDME0v2NhPSSHTAInONOPgCjzNrdV+Zm3MPHf2dGglrySxdwCBBtni+Ij6L8quHmmzlcrRu7gNtl6b1b5JpNN6SGOshfVTqaViqjBoVLA0PrP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813854; c=relaxed/simple;
	bh=twGhxveDnx4sa4AY86Omvzu6sh4ndfEdD71Syjd0rOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sy/7rhlFFcMZFC2wf7emLCQNQko/rxCGMRefyRYGX5BitaPf8epwldTwJYfpJpjQs88n4Y4xADf40W1WX0M02Zqe+PEInVT6sTIR5PxIfrWrJ9V2xHGQOp7RuTJTba49CPxrDUy6CPbWMAhAH4GL2iYXtygDmDVfinFpqVa1VLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jjBZ8smv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582BIUBl030092
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 11:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9Ecf2EnQwQu1LlRGQboGHCRDmSsyxJN4FsdN9WPMXtg=; b=jjBZ8smvY7EzlmxC
	vLwbTo+R9B1cZ29qygXVBlcbJtWwDCUVOz19v5dySma5+A3B9w21sgDfim6276Kn
	fzlJkMZ7jao9d22NjRllkIDf4DZvxtekR3zfOqWtLK2PT5dlhjQyST+1EAtJrN9z
	4LpgsRPBBZUmRLaWZHehbJ5njdJhmqYZArhY93o1Tf1euzb1F8nQORAdbBTZFp12
	AEr+MHCZEXCSw2AgSBAv8jxkrAJzUhEpl/OpsQfwxJddjddjfg54GeiUtRRwJ6sS
	IAYZ+Gutxpy11BUXbhsvgX22fBznE+JUEFt0hC5PFaaBFsGk3ECyyypeMhiKqM1c
	Cgwy7g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush2yhqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 11:50:52 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-248942647c5so70704325ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 04:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756813852; x=1757418652;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Ecf2EnQwQu1LlRGQboGHCRDmSsyxJN4FsdN9WPMXtg=;
        b=P54CXiqjVBiWd9V6px/WU5aWBZIotdi7eZvVCsLV/3GVobe/ejHb36QgAtVtqB7Aen
         RnBPBimT+Fx/2WxuUk9KiSYDCBiCWg18QcaLErCEhPmn4ePDBG+OEvsUtxgvswhYPNoZ
         Uiex+jfej5TPBH34njLzt/qU4FKh0XjYlHPCuYNrgjOt+A7ZZ5tzPWA6+8V2mAx4KT/d
         WbH/1h5g3PCCzgZkk5Twi/4XEArklQJquxwWkTlUE67eYjMqZgJI+YJgN+tGNxD+5LMj
         syfm5kvos+I4/R5USHJTxI88jDJqCnfd/vtCMqsnhPV7PaTKayN/3zQL9FbLd1yMG+zF
         Hf7A==
X-Forwarded-Encrypted: i=1; AJvYcCWcKwOB9Kq2OzERommR0LwzfgBdPBHpQK0z7PD1LTI2wDYAx4cRT8E86RPIHM0Xh3xN4Wo0KX0KHqCAiZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHdAQ91hq4gU2i228Ehy7e9Z+TXkJApchCtFA+zbUNuO5pzIlM
	dxcwlaC2nWbBOj2RlJzeo6ekPLber7cI6sTAV2e2xdW702e8t+WyYX+Srh/z3GS68eAaEeNH0HP
	oMWFog0df33EtVaLTEm+8co4RvHHPOTT8+ZJuN3z4OSJq8MZCIctiGTiQDsBENm1DtUU=
X-Gm-Gg: ASbGncsxKcMR0MOwmVloKlrX9p5hlI0uuNDreFCIonz0zaacn8CnsbtgquZhVLOMM2k
	B96BaY41+z2WhX2NeVFSP4xHnm83/E+L3rNU9K+LyVlwnj7UuA7vqfEQWpi9qcMdHUiXzeU2UPK
	iCm1M+rE1F7L7DwdZUwQXswczhidymFSl/O0rn0wdfE3oIeBudQ9+ICMOiSQTDf9kmwJf1Z26gr
	9EjwO/VtPJuepcZsPjEeDV+3B5n7igyPFitecXInOmYel4k5qUk+C9/OF/KlWKXhuE7krgdGy+4
	MQUHaNqqJ7L2ulAlep1vlY0D2M1r7Z3y0+gkpUl88VReKXQRSJqZdZ+Grk06B3/l
X-Received: by 2002:a17:902:e891:b0:246:2da9:73a2 with SMTP id d9443c01a7336-2493eff73d7mr150963245ad.27.1756813851562;
        Tue, 02 Sep 2025 04:50:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe9tA9MOp9iJjbDEJjzynSMTlN4118IVJo0EM9iKkN4E39bGnaCYGlxUtOV+n/mB9jDr8Myw==
X-Received: by 2002:a17:902:e891:b0:246:2da9:73a2 with SMTP id d9443c01a7336-2493eff73d7mr150962885ad.27.1756813851076;
        Tue, 02 Sep 2025 04:50:51 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329d089395esm3175428a91.1.2025.09.02.04.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 04:50:50 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 02 Sep 2025 17:20:01 +0530
Subject: [PATCH 2/4] drm/msm/a6xx: Fix GMU firmware parser
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-assorted-sept-1-v1-2-f3ec9baed513@oss.qualcomm.com>
References: <20250902-assorted-sept-1-v1-0-f3ec9baed513@oss.qualcomm.com>
In-Reply-To: <20250902-assorted-sept-1-v1-0-f3ec9baed513@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Jonathan Marek <jonathan@marek.ca>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756813835; l=1466;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=twGhxveDnx4sa4AY86Omvzu6sh4ndfEdD71Syjd0rOw=;
 b=9ysrXfc2HgE7q8Ud9ADJPJDqm3SHpwRv9C8hfpR3wt3KFdyZpE+MoLnjKe/XRgWoGg/qtW8Cw
 xWix1+PIdcwBtueU3gqiqKKj4HINkbU/zQsVGWnSrCRn7qlmE4rb5Sc
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX1782nd+bggf7
 8vDgT6qgZiq0XSWZrxKE8Bcjxl2UYQd1sosimVHh9FN0StWUiScy6JBSeciwbmuGJu/uHM5JFxE
 8addK7TDA/f+Kj3TTZVFD/blNDbZYs9DZCcA5RvfJdnK28KbA261yQ1Bw15Co2IrHZuICgmksLP
 GuJb8Qjm5w2rK+NLwnjYynKF2FkRic2nDlPuElpyTVixzAyYqhQUiECOLdosek1fdHN0wypYPHQ
 Udr6E5J8jAmCvew/pqVCT7jYE+900q/ta7GNPWEz00EzdehS9z5r5sMlsS6me8TAxV7QAIwBzyg
 dJULTSBqsq5G3GGe7hQLFzZ7IEAoKsYebCcgX1Kg4s2UOzNEkMs3J/4vcNK4/+TwD+adWZ89l6v
 lllWx7OX
X-Proofpoint-ORIG-GUID: NaF4tvGSAUXZNnLV_MZQW-uJFU5ctu40
X-Proofpoint-GUID: NaF4tvGSAUXZNnLV_MZQW-uJFU5ctu40
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68b6da1c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=gF2G-XVBjaN319PmpW4A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300032

Current parser logic for GMU firmware assumes a dword aligned payload
size for every block. This is not true for all GMU firmwares. So, fix
this by using correct 'size' value in the calculation for the offset
for the next block's header.

Fixes: c6ed04f856a4 ("drm/msm/a6xx: A640/A650 GMU firmware path")
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 28e6705c6da682c7b41c748e375dda59a6551898..ea52374c9fcd481d816ed9608e9f6eb1c2e3005a 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -758,6 +758,8 @@ static bool fw_block_mem(struct a6xx_gmu_bo *bo, const struct block_header *blk)
 	return true;
 }
 
+#define NEXT_BLK(blk) ((const struct block_header *)((const char *)blk + sizeof(*blk) + blk->size))
+
 static int a6xx_gmu_fw_load(struct a6xx_gmu *gmu)
 {
 	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
@@ -789,7 +791,7 @@ static int a6xx_gmu_fw_load(struct a6xx_gmu *gmu)
 
 	for (blk = (const struct block_header *) fw_image->data;
 	     (const u8*) blk < fw_image->data + fw_image->size;
-	     blk = (const struct block_header *) &blk->data[blk->size >> 2]) {
+	     blk = NEXT_BLK(blk)) {
 		if (blk->size == 0)
 			continue;
 

-- 
2.50.1



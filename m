Return-Path: <linux-kernel+bounces-810991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88DCB522C0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 22:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8ADA5853B9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 20:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6731831A54E;
	Wed, 10 Sep 2025 20:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HHIvGWYD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E677C31577B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757537080; cv=none; b=kwobm9PQ2NtyR8oE2Sq+XEIeF1ait8ChnXGexxGHOa6ved1h+3ksatB99gJwBnOt0uxwVbrdg0xvpWHhdVMViQXl1hNUjnzf/BPSyt3kiJK8C7KsIwMpx8Drg02qi1jVw8M3wVnVCdLDB2NQUtwP2dsptyCS4AfoMDTuq+wcyw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757537080; c=relaxed/simple;
	bh=QH5mzD4A8ywK4YBRLZvZeIsieAJxopW4JPv0czcGn2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SMT1ZjAsgdzQnGXSVo0MP4rSDforWfsbdO3oD1xHD9qXxnGzfFl2L1U/JSVjt+uMKPyrTE/YV2VwJjR9WCAr6HkZjfkGV3GAGgiD1Nn61sLkVHIv2eOdA/tOx5aQcx41UjtruAJrfzmqCxgBq0EULgOpPubwge9EHvn8OaL4Bug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HHIvGWYD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ACgGJd023740
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R/4Wft3ZFrBLCsBTvaTSzzDE7KvwF9edeAejAQ+B/BY=; b=HHIvGWYD30VWgh/x
	Y0GCG10lxYMkR+VEkiKxEny6Bw64sbPG9PzUNDVCF4cqgtSS5Ircjgk5HVzq5D+H
	NfoOrx9GGORI+uC6UqxqhhpCpVhygozg5sIw4RbB54EasURackySToq8mI0nmYrN
	lHSlQZa+CxDOc84l5j9B7GPDCQ7Wq7dTv7RkmV0owc2uhjOfRHcEMKnnhcTJ8eG/
	3HLjhmFD/qa0zKBbneoR2tmySKIYv6Oq+CWl71S/w1NlBog3irsytiQnhxQefaD+
	2WJwJ/eu1yXBRltpcIMW3OP8sEXDhaVJ0aW8jy5+FQa4UzO+dv+WOY0wzh9RZcfT
	Oru9Qw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e4m556a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:44:38 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b52358ededbso921017a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757537077; x=1758141877;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/4Wft3ZFrBLCsBTvaTSzzDE7KvwF9edeAejAQ+B/BY=;
        b=Ct6X+dYVmN0nyxDZGD7tmckBKQfAmcsokMsaOH7KMJsm7AvdPl3geRzsEQeGvWIgxh
         ov6+s2RJWO+i8s3TreT/lLWpuGMMb4MHbW72SnPyEK/5Kb2D1zUq1Idwz/wfsXnFF2O6
         M460jzBZRxjs9yGFwsamcAJRKxxTm7lXtvAqqi+nyDvR7d1j6CtyElWTYOsJtpEdmYK5
         l/wn8yjkYTAjWXhPkV1Bln0y3HXZ85AZHww2A5aT9PQWAfVECL1Rwr9740gxoYg0NcDv
         UIF4kYItGVXAfu/S0PFBkyFCfoh6tEMSEwXKLaouHCBaIUbNF3IsbhxYBfs/a4GUZBOM
         J0hA==
X-Forwarded-Encrypted: i=1; AJvYcCXvY++/RUp6FSbppM6isI1Cbpn7r4fm/FuQyCy5mWNaZfRpRTISMamwgSgxZBYDnKgt1ZgmdnCGeRy3zCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOGdUGqIwsNHQPY8Ql/ULqKfMnzjd4cztfQJV/QHw36tNrEtGU
	CT2wcXCpDJWPteukDAYyt2u/90tNdrqMALKygCXcr90WpUZ5iKwoyz73N2EZx2RQj0yXkkBDpvm
	ZWVcZYEU0HnjHfd5IdF57Hhjji5ij3eR0Y1+YCuN2196GYIIbFYRR1nFlSsywZ7VQ9mg=
X-Gm-Gg: ASbGncvvVYg1WGauRy/7uLFvpgEGkLSpd8K0j+KjiyAioJjzNM/A10lIIH0FHLeHmBq
	7uFnUsskKwPbyQuzo07loW/UF/9dJcm2HQb5A2SKQ9hc3YSpQL19gtS/QCLE7oqeUknjXMvsnXu
	HqjTPIM2RUZFOvpieJnf8h64Xog8Vm1bB1QqzoXlkJnQRQVGx+LtaPR0BjH4CD8acDeQ/g8GgTk
	phi7wWXBNL28Zr3CmV5oMNBeSxah4Xks4UWWFP9ZyOLtVHs60jfjwzUVwMkrEGOKU/tlM1HCq+g
	nrykGVJIS8XKOKr2j+enxUy7GpfxfX9qJZFrXJqltyOhYLBuR/rjakyhh3DNZuLZ
X-Received: by 2002:a17:90b:3b81:b0:32b:96f2:e2c9 with SMTP id 98e67ed59e1d1-32dd1dbb188mr764763a91.12.1757537077225;
        Wed, 10 Sep 2025 13:44:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZ34b2+3kXaCBM79RfDIeYcFfBZlEs+rc1jvA1GOQktZ1ERKp+SFIbOTtPjv3X0doccjwcwQ==
X-Received: by 2002:a17:90b:3b81:b0:32b:96f2:e2c9 with SMTP id 98e67ed59e1d1-32dd1dbb188mr764732a91.12.1757537076739;
        Wed, 10 Sep 2025 13:44:36 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd61eaa42sm46771a91.5.2025.09.10.13.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 13:44:36 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 02:14:05 +0530
Subject: [PATCH v2 2/4] drm/msm/a6xx: Fix GMU firmware parser
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-assorted-sept-1-v2-2-a8bf1ee20792@oss.qualcomm.com>
References: <20250911-assorted-sept-1-v2-0-a8bf1ee20792@oss.qualcomm.com>
In-Reply-To: <20250911-assorted-sept-1-v2-0-a8bf1ee20792@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757537061; l=1478;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=QH5mzD4A8ywK4YBRLZvZeIsieAJxopW4JPv0czcGn2k=;
 b=E/JQ2p+GzDCp/eeNWvlYpTUdKgONOclrECZtOlrFo0XCQnrPuI5PqEEU6YFEduipWLvfU2Wdh
 vzsHgYpuTkTB2Q1CS2zJyzIgbG0fCoHVY2D4nELZY3onLWrozaS2Ia+
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOCBTYWx0ZWRfXylTSNNQs0ee9
 ktKEM9znCo02f/L0oSgHTYY7ff3a7+7hmukt4DEubS0kKW8dY+75kfG7xLWzRiqxRL5ViD6ikXc
 tIs+S/JlsufOKkfudyUVn3tP67VczgNBYnFjPRKkRn2SrciPg2YwLaoeHbOxbhxvYVS1eNBr++w
 DHIBxR9LM0tqF9zxLmQNGv6p9a0cKxDSQWxByoFq5A9PJkeMy4MWZpwwQSLKoV/DeVpJYLoS9mg
 ewxBomlg6uRqzaM+A7IqYPPp3QlXsFcQsr3lUl1XIErsLaFhszdjHG5tDBQTUyKkOdmM8H/w73F
 +eTcGIKyUy2xI8htGWcOyHhjbCjqXdkP+Ta0Rx8mjVzSihgor3XdnZNB2qb/pjjuK+EXO/Xy5Rs
 6ZHgkiVN
X-Authority-Analysis: v=2.4 cv=J66q7BnS c=1 sm=1 tr=0 ts=68c1e336 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=gF2G-XVBjaN319PmpW4A:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: Wbnoh3jP9mAiNzt9WxVq13OpGJPQdQjg
X-Proofpoint-ORIG-GUID: Wbnoh3jP9mAiNzt9WxVq13OpGJPQdQjg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060038

Current parser logic for GMU firmware assumes a dword aligned payload
size for every block. This is not true for all GMU firmwares. So, fix
this by using correct 'size' value in the calculation for the offset
for the next block's header.

Fixes: c6ed04f856a4 ("drm/msm/a6xx: A640/A650 GMU firmware path")
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 28e6705c6da682c7b41c748e375dda59a6551898..4c0510cc784864da990af8cad086176a5d92ae8a 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -758,6 +758,9 @@ static bool fw_block_mem(struct a6xx_gmu_bo *bo, const struct block_header *blk)
 	return true;
 }
 
+#define NEXT_BLK(blk) \
+	((const struct block_header *)((const char *)(blk) + sizeof(*(blk)) + (blk)->size))
+
 static int a6xx_gmu_fw_load(struct a6xx_gmu *gmu)
 {
 	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
@@ -789,7 +792,7 @@ static int a6xx_gmu_fw_load(struct a6xx_gmu *gmu)
 
 	for (blk = (const struct block_header *) fw_image->data;
 	     (const u8*) blk < fw_image->data + fw_image->size;
-	     blk = (const struct block_header *) &blk->data[blk->size >> 2]) {
+	     blk = NEXT_BLK(blk)) {
 		if (blk->size == 0)
 			continue;
 

-- 
2.50.1



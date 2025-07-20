Return-Path: <linux-kernel+bounces-738219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5ACB0B606
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 14:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CE1E163783
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 12:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEC92153E1;
	Sun, 20 Jul 2025 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XJzyONwu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1852D20E032
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753013861; cv=none; b=M+bklAqmkhZjRAWAK7zqYQbwwUXRG3pKmF0Ogp3gG6rUqOdvd+prUzfTpq/mGoVBwuSlOYC10iNFyzzJBvfIK+FSC/91h1W0AlU24Y9MGQpL8zp7okTfLESZ+ESl1r9LEN0+wTATdMGYJ7RUkzixQLRxx5pmdIwkBlRW9FRB/ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753013861; c=relaxed/simple;
	bh=wqJpkzMI0ES2mEy8nQuiLa2Vdj3zgdiMb0q9pTdHGtg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N/aKgIHGyT35D5g9hI++XVtN1y1g5NLtWhnBgr3P0ceYqRu3YaNZ2G1aGfsNSR3A3/O35FTqImXb2U+NFxwi2low86AMA1ZeNJVsnfbsO76nX5tPqrGuQuCCz/yhByS8yHoCuJQKDjNMbXCk/hejvt3efv8n5xRJlkQx5epIAaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XJzyONwu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KBtGlH006240
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SthMOvj/tgeikoDF1DaOQafMj/mya3JcY+MR5c3vfhY=; b=XJzyONwuCsAmdsVp
	uEWekU2mkMBk4NTwwSL9PejCmB3rrqq5cBzI1VJRBOZUvRCI7S4NmnHYRYAZVcOF
	8tk1Zt9QV2SlNNq1dKfGjLQc27saRaYg316BXpDQzXApdRMnwjYoV2U6srXv8B2j
	R7YBHu8tBMnwk4NiIYrTA8R1rIJliXww2wqFTZTNL/Eru1vy/S4obpD7b8jd8sgX
	9H9HfN4tu+vyvWQFWC30IQ1dIEP974jiM5kgPcmHP+FbTCD/aAFOhbzay/APWrjs
	ebsH8/tg1KAS653ZxrKu18MBlDMIZJtz7B1da/R5iOiCkYzFjrdsi68pUUJarbh+
	ZmtjKw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48047q26t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:17:38 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7489ac848f3so5495123b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 05:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753013847; x=1753618647;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SthMOvj/tgeikoDF1DaOQafMj/mya3JcY+MR5c3vfhY=;
        b=o/qhzpwwa/c06XVoBk+fbGtSMV9RLFu8dgqixKug941phxwX9C/D5Q7DrWIHl93rJp
         fx75HIzPlpfmdxSNGLh/u85XnsfasbTULai9Yut1bIUTr0agWLw4QD7/ZEjJGaHQ2tZO
         1Ni+AN8x6/rkqBslmhmzM/3/JzY7P888jReh/PK8SrXhzENQvy+cjqaSAP0BSoXuTJuD
         WRLQQaAyJtnyX30y4bt9EG7gVLzfwjJX87F/MYpuSiOq3J+BkPqDulTxsrJuxWFVri8w
         eNbIhChv0UtpXlGERAsf2kEXvmaxOCVwbt5Lm0V/CJ8RNTZCqgq32GW3NCXR5+m7bmwo
         19JA==
X-Forwarded-Encrypted: i=1; AJvYcCXT7Tps55mrLKblSCIccMYYFQgIKpZOeHuCCyP6BLJMqtc5blB5H4R3Dp+vTybjcK6Giak0I5MB4tTl7hE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs4slMrbR5fWHLwIbFRUpCCV92BgWbsl1VHtD0+URw0XlWWj12
	HoBI3D379mGo3EzGBBQFcjwUrha8SLmbCZpcElwRt9yKostlbkzcIK7OWihNiY4e5MAU2OoLiBD
	Tq/cCpaRJ3Aey0vjn1Hu5RYQvNWNxn921FkwXAFR8IGLlQF1sgBXDe9lirTTCO/fI/TU=
X-Gm-Gg: ASbGncuaLLtbswCGyeAMHjkwX2/n2vxVinFJ+eR8RIcYW2rMJfChlfS1JpWzDR4FLro
	xW/78oHsrgTsO6oJJne1438Wx9QLS16VbQ9np1Hwr15vTDSznZyCGgPOiN6xF99OtXaK4xb66I1
	yNl8g0Bt339piTOujpgp0Dwc8I2doJ1yKkQjX9aREIkmVsZH/e68RTWANloOMF/Q8oDUlBBqraT
	kGQ6RGsYd0sEw9t3RSTdlqHbVUMHL4fG9lOzdFywL/Ei8Etxr6rwMn/YfVLJkkSSfAyxD2OFxep
	luUAY5UQKTWVoeqbSvatYDpXn2PI3tb2+j34IZ7JvKaQB6gc1xLQNMT6GGaCPgnz
X-Received: by 2002:a05:6a00:98d:b0:755:9110:c00c with SMTP id d2e1a72fcca58-757250806bbmr27254979b3a.11.1753013846857;
        Sun, 20 Jul 2025 05:17:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs1tuitviwC/J4/O6Bb16mbD1enJVUrTELkd81BeF8q+yHvYhQvPif6zen4HAAh/KoTrNivA==
X-Received: by 2002:a05:6a00:98d:b0:755:9110:c00c with SMTP id d2e1a72fcca58-757250806bbmr27254940b3a.11.1753013846439;
        Sun, 20 Jul 2025 05:17:26 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb154755sm4097933b3a.69.2025.07.20.05.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 05:17:26 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 20 Jul 2025 17:46:10 +0530
Subject: [PATCH 09/17] drm/msm/a6xx: Switch to GMU AO counter
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-ifpc-support-v1-9-9347aa5bcbd6@oss.qualcomm.com>
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
In-Reply-To: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753013805; l=2596;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=wqJpkzMI0ES2mEy8nQuiLa2Vdj3zgdiMb0q9pTdHGtg=;
 b=dN5Ha5ZJ1vy2SWgzYUESebNz8sZiXP+h4UlpLjzQ6YYCuUUyAbxGHHl1x/rWbxhGlW5EP8351
 +4ZawQy9qRBAIE8eJ5Tx+2jrBUEsUpkB+yuxg9EPmPkcPOU7ILwLRhb
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDExOCBTYWx0ZWRfX0X9kIF19B1O0
 a2889OPSielY4spacyfDkpWf33CLk2qWGixHkL8eJsxuUwQwLHy0F10NmWaHzSbQ2Wfhqyb4//Y
 DbY9BOXdknln1D5W+TNFfJwWOOn35h+uk7L/F5KERo0cROljzxIEuekKiDS1nSal0TDDy07ojhU
 63TUJV4kXyWpssjF2zzYdkQSUncKNmadxa55/rTV3d1XnBodNsibIKVz3ss/F9XLwRBJBFdkQb5
 Gx9P+ckQCKR/oWPfCViFmh2bmrdKKM1dQVjskIMNMEwimtFnCwfHnp/mL4yt2XFkUpuf8JIz9Rh
 E1DSuICOlChdr1qdckCtNTuOEBjwQW+3YDB2VU6BKluDjmuXOZTgCmgqCfpIpEn6//xSIkPvVeX
 8CORsCKjPnz4RH/HmxRTCxY5TC4j+I8twfsYskM2iFizJjDHaJ8JN5M8VIUcfiuAoox4TcG/
X-Proofpoint-ORIG-GUID: icvtFvwU6Sb_OQUqL_2unrCpuk4ksSec
X-Proofpoint-GUID: icvtFvwU6Sb_OQUqL_2unrCpuk4ksSec
X-Authority-Analysis: v=2.4 cv=IrMecK/g c=1 sm=1 tr=0 ts=687cde62 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=IO4KcYcNY2hykouNLhsA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507200118

CP_ALWAYS_ON counter falls under GX domain which is collapsed during
IFPC. So switch to GMU_ALWAYS_ON counter for any CPU reads since it is
not impacted by IFPC. Both counters are clocked by same xo clock source.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 6770f0363e7284e4596b1188637a4615d2c0779b..f000915a4c2698a85b45bd3c92e590f14999d10d 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -16,6 +16,19 @@
 
 #define GPU_PAS_ID 13
 
+static u64 read_gmu_ao_counter(struct a6xx_gpu *a6xx_gpu)
+{
+	u64 count_hi, count_lo, temp;
+
+	do {
+		count_hi = gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_COUNTER_H);
+		count_lo = gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_COUNTER_L);
+		temp = gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_COUNTER_H);
+	} while (count_hi != temp);
+
+	return (count_hi << 32) | count_lo;
+}
+
 static bool fence_status_check(struct msm_gpu *gpu, u32 offset, u32 value, u32 status, u32 mask)
 {
 	/* Success if !writedropped0/1 */
@@ -358,8 +371,7 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	OUT_RING(ring, upper_32_bits(rbmemptr(ring, fence)));
 	OUT_RING(ring, submit->seqno);
 
-	trace_msm_gpu_submit_flush(submit,
-		gpu_read64(gpu, REG_A6XX_CP_ALWAYS_ON_COUNTER));
+	trace_msm_gpu_submit_flush(submit, read_gmu_ao_counter(a6xx_gpu));
 
 	a6xx_flush(gpu, ring);
 }
@@ -559,8 +571,7 @@ static void a7xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	}
 
 
-	trace_msm_gpu_submit_flush(submit,
-		gpu_read64(gpu, REG_A6XX_CP_ALWAYS_ON_COUNTER));
+	trace_msm_gpu_submit_flush(submit, read_gmu_ao_counter(a6xx_gpu));
 
 	a6xx_flush(gpu, ring);
 
@@ -2246,16 +2257,7 @@ static int a6xx_gmu_get_timestamp(struct msm_gpu *gpu, uint64_t *value)
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 
-	mutex_lock(&a6xx_gpu->gmu.lock);
-
-	/* Force the GPU power on so we can read this register */
-	a6xx_gmu_set_oob(&a6xx_gpu->gmu, GMU_OOB_PERFCOUNTER_SET);
-
-	*value = gpu_read64(gpu, REG_A6XX_CP_ALWAYS_ON_COUNTER);
-
-	a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_PERFCOUNTER_SET);
-
-	mutex_unlock(&a6xx_gpu->gmu.lock);
+	*value = read_gmu_ao_counter(a6xx_gpu);
 
 	return 0;
 }

-- 
2.50.1



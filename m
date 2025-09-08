Return-Path: <linux-kernel+bounces-805326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9BCB4872F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75A53A9458
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3612F83BE;
	Mon,  8 Sep 2025 08:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BnHMSviT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC6B2F7AD6
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757320084; cv=none; b=nOYdAUTIv7cijdzUP5/G3EI/hqiXRAYjJyiANmK/H3H+t0haZlRSD9JYDCnrM93Ex/jjrnf3CKaxnrj0N39StfchSVAI76nOUQfF0S73hgWLjEft8BeDBQAZasuAxf74zxrU74aaloND8NdkPQW0iBnudclvYvgUGusE9d6j9PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757320084; c=relaxed/simple;
	bh=BnBwOePYgAk3DH3Xs1s99xX8yvtkGViS+FKVC0Tm+Fs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LiHxXcA+4v9X33Z/UVOIL+kTzi4W1pUkqr3Rw4iAF16uGh0eA7aWn0bV+6VGRYhUHPH1jpOQfzuf/s6NOpJO/SAA5tqaxZAwiKgtT3/nJqY8+nh/rbKP7Qo4x+pIt+9XKo67qHJJXWmkvtaPjdKJ1DO5ZOFmc4zIj6diEZghws0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BnHMSviT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587JqHoj032431
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 08:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WZyO3Nq93Bf/xQ1FnubJPlIMWCRx8r4Toxq5+4c0O5k=; b=BnHMSviTEesJu1Az
	snAreBs3+0WgA3WFrF2l5dpD/ZKSciieP5EARfjD5pZAErEWC0Cdnd8/iI6ppJ9L
	ZekdmBqXOEZ1tr4bC+XBZOD3ULLsieH3UOnLnCODkhtZNRsMciNoZySZn9sgynul
	fOT+ug0FK7Jr8FTvur3X5xt6B3ANZcfJ3P6joY9EC5CmnlIaZUI+4X6vZJgZ2LwE
	FO3kIWDfwt6YEY04F3raSr7TQZ57mj01I/RG8KfjK2pzh3uvBiznnzDTLYvEKiX/
	EIbzbuFUs/MNNBAT1WRUQmcnHrd5PuPo8tEQ/L3lOp3LxDjMwJ2LqibBHY5Yeal6
	qlqhQg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e8a3q2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:28:02 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77260b29516so9991862b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 01:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757320081; x=1757924881;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZyO3Nq93Bf/xQ1FnubJPlIMWCRx8r4Toxq5+4c0O5k=;
        b=QilSPl0JJAnRHh4WP9T0mR6GGAQWGiWSLcIof7JlgvlCgvFtOvSmM7CgLPrsgRFxYc
         aG7jgbAz/qMek5ONG6i6zbHeZudUcRbQ7jbVBb2mbwK5+c+o3BmNWA+1L2Pvnqa21+Uh
         XQXAaoqHLAVeXrqOndWDDDPU387a9tDAMtDJrMeSfJiGEvsDTw+zBSBYG138Q2vB0yor
         JneZHgUd3NU3gXt4gx9qW02PkOBtO2X5VHFd2Z7jlz0c6I9vHZ/Px/UcT6TzHYxiGTqN
         IYGDy9snnx9wZLeWc2HWMhpYh6ZJcQS76obha0YAeiDZB5nQSNzvaRV8NOlNX7ZpmkSm
         Zaew==
X-Forwarded-Encrypted: i=1; AJvYcCXETs5vlBVPg/yqY0b0cbttmaJMfPcsNy9VJUvN3J/Euv7dC+hrPmlJMMEwxGuitD+Z2LlN49njTTJCtEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPO7nt0yq4SZtcGKKVVVrEKffwXIdAsJ25VozqJv8jkz9I8E/k
	2PJ8aLUIkJbdTCdwIjpV7ZQqTOSSYo23CVenD6YOo5XwUwY7QfaMPoEDVrftbc1NvZEsmzfbpsH
	fKF97cS11qIY2WPe8P/VqFZc8qaCg/Z0tZDTYZbqUfevrwcnYtp9nWS7TopeMQtNRpS8=
X-Gm-Gg: ASbGnctlBLBCoaDzKMZs45pTXXVHhurzFPLLvH5avmYTNhYlKjvQ8ldEVH4o0sSVqF5
	oRVckC2y3Vzh++dD7VsTuSAcrnG8WnF66I0MhOcVhcZwdardsV1FGhrrMxRu2Ygak0greLUO7TV
	kh0lNOfHcp773OIPanX21Y0y5aGOMPIkgAYoIGf0s8SXhryCJziwdbU9P7ncUFOErMoRz+T48uC
	E/LaODlZmGVeYwuOrS5iIYAI8hzWIvlpASXY3xnaFR3WY2jKM7GcMYcy/cFpTTYMstyOEXvIY1c
	L/KT5n+XigcyOFkozxLDJOlgJ5OHoC2LFRjNWdgU2ijrgRSeTJw/dLLQLY3fNZrK
X-Received: by 2002:a05:6a00:1489:b0:774:20a0:dd65 with SMTP id d2e1a72fcca58-7742def5affmr9598640b3a.18.1757320081345;
        Mon, 08 Sep 2025 01:28:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFA/YHKsqfgyAor24HUBSKnNnWTsB78uSq0VADVG8FDB/BKgowEMs4Q/v/ZpMOJN0/Ze4YAVw==
X-Received: by 2002:a05:6a00:1489:b0:774:20a0:dd65 with SMTP id d2e1a72fcca58-7742def5affmr9598614b3a.18.1757320080912;
        Mon, 08 Sep 2025 01:28:00 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26bc9csm29157523b3a.18.2025.09.08.01.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:28:00 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 13:57:02 +0530
Subject: [PATCH v2 09/16] drm/msm/a6xx: Switch to GMU AO counter
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-ifpc-support-v2-9-631b1080bf91@oss.qualcomm.com>
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
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757320036; l=2606;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=BnBwOePYgAk3DH3Xs1s99xX8yvtkGViS+FKVC0Tm+Fs=;
 b=J31mz5s4viqszzEmkcEfZjUtCxH2Yw01ajJbFJ25U/VAJMLlEvOdpS0BogFIDeLhaY3SaHt1M
 MwcJWKugZ1QB2hkmvF0EeEVLF3Hs0+joMGgptu4DLTNtzaUEzS9JIkk
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=H7Dbw/Yi c=1 sm=1 tr=0 ts=68be9392 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=IO4KcYcNY2hykouNLhsA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: lgxnNKsVPdpYHrdj58wA5NDzg6NaPTX5
X-Proofpoint-ORIG-GUID: lgxnNKsVPdpYHrdj58wA5NDzg6NaPTX5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOSBTYWx0ZWRfXxal13VJpLgo5
 W0Cr/F0+RR9BBS9U0mFU7XWt5Q0lICnOQ8XbhCdfW5C/Sw64CP89Z5B1QqwYO5Rc9FpHo5YHclp
 aSBzpZlpwsxtrt1snxJK3iZiesioyRT2TFs+QLdHR8zxgnyBA8xRJLfb/0H3A1i1mstJ0DfwARS
 mibx4nzQqXMuGk8Q2h9zlMmS+f56QbjHIbysY3YOXZq4ffWdPjTw+l1ZYcaArRNbnTfvdJltRAJ
 nogp7DT/QJrPy54XXisPsg7Wl37eUwAjeyMyzXyCPXyXy8eDKFb1aaUgd4reRnkK1mGHArr3msc
 cmTTxwgvhFew4950EYTR4/DiqOW5s+iSfayT1Pb3XqWuB4Wcq9X9nC4Vgjjb0RtRliEwnnEEOLx
 5xcnK1kY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060039

CP_ALWAYS_ON counter falls under GX domain which is collapsed during
IFPC. So switch to GMU_ALWAYS_ON counter for any CPU reads since it is
not impacted by IFPC. Both counters are clocked by same xo clock source.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 33a26bbd245ff49784bf1219a584936b4caa62b6..c64c84affa6821f79ea74b80b2f2014df38ec918 100644
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
+	} while (unlikely(count_hi != temp));
+
+	return (count_hi << 32) | count_lo;
+}
+
 static bool fence_status_check(struct msm_gpu *gpu, u32 offset, u32 value, u32 status, u32 mask)
 {
 	/* Success if !writedropped0/1 */
@@ -376,8 +389,7 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	OUT_RING(ring, upper_32_bits(rbmemptr(ring, fence)));
 	OUT_RING(ring, submit->seqno);
 
-	trace_msm_gpu_submit_flush(submit,
-		gpu_read64(gpu, REG_A6XX_CP_ALWAYS_ON_COUNTER));
+	trace_msm_gpu_submit_flush(submit, read_gmu_ao_counter(a6xx_gpu));
 
 	a6xx_flush(gpu, ring);
 }
@@ -577,8 +589,7 @@ static void a7xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	}
 
 
-	trace_msm_gpu_submit_flush(submit,
-		gpu_read64(gpu, REG_A6XX_CP_ALWAYS_ON_COUNTER));
+	trace_msm_gpu_submit_flush(submit, read_gmu_ao_counter(a6xx_gpu));
 
 	a6xx_flush(gpu, ring);
 
@@ -2265,16 +2276,7 @@ static int a6xx_gmu_get_timestamp(struct msm_gpu *gpu, uint64_t *value)
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



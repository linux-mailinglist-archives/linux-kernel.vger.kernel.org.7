Return-Path: <linux-kernel+bounces-805329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C09AEB48732
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F8BC7AD1B8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2792FA0ED;
	Mon,  8 Sep 2025 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FlxAKuTa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8BC2EACF3
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757320098; cv=none; b=JuXzOvbOSTuc3AGikRDeOgv9rH3oUAT+gSQzPoX71jSRn+iGxzdjqCV9xf75U6CGmwUNOm4yW3/sGoBTdxtgSFHEdHwfLkn3K96/pLyGkY1p4ReEwDlh2yDTT3Q8vzKa5CjXN9gMqAQEHwzIdPz14RSt0TliuLkX9w/J4Hd9oGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757320098; c=relaxed/simple;
	bh=/iBCcOjQRFAJtVUwHHvMO3maSUVXqEkyAINnqw7b6JY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iWTJtxYAnU8d9W3EPfuJoX71v2Wjxyw4GVY1UCB7Jnw2cPPLzFHbrtbUFI/9BOsViKwbYcMrytxlnRSi1fvm+6B0t1/OG14kpLT3Ajk3IwJsHfz2yrLXRBBidIFEN4/H3fC9Eo5ZewSjGDk743VZJ+etXUjD9wweu1pbsiE5vBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FlxAKuTa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587Mt9gZ027195
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 08:28:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vz6TxjIbrwRntYK8rL5nZ8VrVI87LAGFTolpn+41CWI=; b=FlxAKuTa4YQFL5i3
	Lr1Sg7Eoigr2sQIO0vLqBg6mSj9SZXCxpr/kMckJKu7W0BZK6ctCa6C85KyWZacR
	rf03JNWe8WzFItsNSKuoNCzHh/ciZ0kBGRe0GHIUoAzoFLBj4WhT+Pr9u6p0r9Io
	18DeaKNYB4uUnuOUVHk+yrGYIDgUDq+COqXit9AIdR172Nr8WQUL43/0WE9r9SMm
	w2PaRBk/E/DBqSP/6w96J46tmcP2uKwkdaBMkZemLtne++fOHhte15IVSacR14ol
	3QZ2bRbB1cFlLiQgdebwR6Ioow68/e9tu+5DGsbCRhGFMTXZFcgOUCZrTr0eUZiX
	SM1pFA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490cj0ku6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:28:15 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-329d88c126cso4063589a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 01:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757320094; x=1757924894;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vz6TxjIbrwRntYK8rL5nZ8VrVI87LAGFTolpn+41CWI=;
        b=EzRa4+GUxIOLBBx4pSLkPJtgCtJUjgRWEYnnGvw1iN4LwT56p5O3MGlH/szMBGKawB
         t66U6TrjTkgLu3zB8pTWPaj0k3ehnC7lQy05Z0Q/LuKRiLQAXIafaIhubAXy/A3Rzh7o
         Z5voq1E1QKZ+g5m2yrTpDk38yxZkyCx3yk7C7WqHT6w9dikaQ+huBqy+qgyEvKPDppu0
         +gCuHNZtqx1lvlDeXyNGzNjthWgdHH5Vr/2iQnqGBy6+LrLIMAP0s7N/p2YBV7a6BHnB
         oXWSNA2v6aVOdSFSY4l8RfmMeZixz+u6PUJE8w/dcsxyOTthplseo+3ksQbISUEjQJWd
         BdYA==
X-Forwarded-Encrypted: i=1; AJvYcCURRz/LRroMgBME3UutsYV1k0XZyyHUbAkzcq5En/QGXjHAU8wiIkV17/6WMnDlmEIAzFSqa/ZVefP0bUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxah9f/iR6/zQbfBGfwd9jfx/KRbrdIU+OOrGZF0IWLBuhTHg0M
	npvSLPHjV7aGrmzuKRFxA3sFqxhp47hJ+Me+ZUuR6i+O/MHejzzduTypEmdnwUM9n9OKrpFemVD
	fNf8k5GAIGCcSf+3RY9ok2ufVsqfrE3r3FhevN80v6nSO/GQqUx6CuvkyQ6g+ZJu0sgk=
X-Gm-Gg: ASbGncuRu/iXlFxHIP1OAEFqnywZp+7u9Eh65GacmXDuSOsijo3hkzrwafgOaiTsbKC
	otxNCwbHyW7bKCNDVt6YiUDVpR/cfcZ9cJrdN5RPb2JCz5isM8JZ04BNFcXbSMRcEqCBZVYRrZ/
	MchWfAWTPwPVHFoU+a1P0eIYskeGUniD829QoO6d+v3Yvw1188ISai7/ZfLToaVo6CK5Ki2OxrE
	GpbUF5f4YUSMJkn0FRJV1kWuR57KZvIk/74Z/3rptp4Cf8Y+f3MTRY/5avcIDAgGwM/PlUzMWxG
	52VdZrxfZf7JhblLWziIi/4KLn63/8YIpbMaWIyOFvQZunMgv7/f3G8Rsrl2E50+
X-Received: by 2002:a17:90a:5186:b0:329:f7fe:19a5 with SMTP id 98e67ed59e1d1-32d43f98f05mr6293830a91.29.1757320094456;
        Mon, 08 Sep 2025 01:28:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdVtgX0M/N/rY2LTPdVh7osZsGoVH4LY/vXWFtabGHHLKji5snSpH3SYJgpihN+vwguCSC2A==
X-Received: by 2002:a17:90a:5186:b0:329:f7fe:19a5 with SMTP id 98e67ed59e1d1-32d43f98f05mr6293799a91.29.1757320093944;
        Mon, 08 Sep 2025 01:28:13 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26bc9csm29157523b3a.18.2025.09.08.01.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:28:13 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 13:57:05 +0530
Subject: [PATCH v2 12/16] drm/msm/a6xx: Fix hangcheck for IFPC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-ifpc-support-v2-12-631b1080bf91@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757320036; l=1733;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=/iBCcOjQRFAJtVUwHHvMO3maSUVXqEkyAINnqw7b6JY=;
 b=Yc3JK87kaA/kMtzrzX+y6eNZdaAWw7k+Obs994LrA1qoz1b8udhNxiU9ISGaVPNd52mdKns7W
 Z0IwaVVAB7HCHJIaFZwWBSBsREqhcuWIDUiL/aTaxmzWKwQtskHSNn2
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: IbhjxnAqpf7LoikM3Ga5Gv3HTMe5C9i5
X-Proofpoint-GUID: IbhjxnAqpf7LoikM3Ga5Gv3HTMe5C9i5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNCBTYWx0ZWRfXzI0a+vs2EgtX
 1xKJaNUyK7D83vtR7MKjanMCrIIAGJRKgJZTUZaDxCucxUbzWlzeH6LJWs/P/EROgl+S5SepcHL
 x+Zsu/OsYyXi3pCE4O7gUJok5tuClyMIyOi4vdjhCnXQRnzLFs+j7axN5R1oP38OJ885bQG3qq2
 ocjIeqEjOXopaP+OjN7qyUrMXd0hNEiaWzv5QHQ8ervkrmFqW2BiKl8M3lYT64qwH5J9tzdb5vR
 KbvKdygxQKnogL//xI+Hl8iTB78bI4UW6ZUdB3hI9eVqCeJOvZXrarnq61eNRuLnJuyJQubY4z7
 MVQxzEZerEXxu14XeJIvSPEIrDTkgeGm3LUJv2bCb/uIcFZnASQCgOf7rNcyo0J9siSUYAVGcy0
 ndM7IFyV
X-Authority-Analysis: v=2.4 cv=QeFmvtbv c=1 sm=1 tr=0 ts=68be939f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=DHE891H7Gske2VlohvUA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060024

From the hangcheck handler, KMD checks a few registers in GX
domain to see if the GPU made any progress. But it cannot access
those registers when IFPC is enabled. Since HW based hang detection
is pretty decent, lets rely on it instead of these registers when
IFPC is enabled.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index bba09c02f9809ed24b4a9c30b1eb993ce01c7ec0..61538b6912883a0e7ec7802cf5f5cfc8649ece2b 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2417,13 +2417,24 @@ static uint32_t a6xx_get_rptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 
 static bool a6xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 {
-	struct msm_cp_state cp_state = {
+	struct msm_cp_state cp_state;
+	bool progress;
+
+	/*
+	 * With IFPC, KMD doesn't know whether GX power domain is collapsed
+	 * or not. So, we can't blindly read the below registers in GX domain.
+	 * Lets trust the hang detection in HW and lie to the caller that
+	 * there was progress.
+	 */
+	if (to_adreno_gpu(gpu)->info->quirks & ADRENO_QUIRK_IFPC)
+		return true;
+
+	cp_state = (struct msm_cp_state) {
 		.ib1_base = gpu_read64(gpu, REG_A6XX_CP_IB1_BASE),
 		.ib2_base = gpu_read64(gpu, REG_A6XX_CP_IB2_BASE),
 		.ib1_rem  = gpu_read(gpu, REG_A6XX_CP_IB1_REM_SIZE),
 		.ib2_rem  = gpu_read(gpu, REG_A6XX_CP_IB2_REM_SIZE),
 	};
-	bool progress;
 
 	/*
 	 * Adjust the remaining data to account for what has already been

-- 
2.50.1



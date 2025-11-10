Return-Path: <linux-kernel+bounces-893723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A91CC48208
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A3F9634A8B8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2345314D23;
	Mon, 10 Nov 2025 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FylzTH7q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X/D+VmgF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681C1302CBA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762793305; cv=none; b=ehy2fRx0rZI/eqW7qsnB0okyuAdYnHImpHcKT/aHVTUwDrVOhTR3YoCpsmqJv/bjOt5f7cJ3i9TymKNY2ux8xFuj+Sg1U1KCMjk2vWDEJn829nstBpyFJsf50NqrfLBpfm2LULxa9ZbwG58vU0lsUray17hviY6AOVgJn9VEWOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762793305; c=relaxed/simple;
	bh=0RH5+HB1DhuPB+qO4uxLrDpF6juU+e+LzCOFWLT2Qxo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kFGFt8DTbte2Ugai2UXN36QCazfcDITrdykfy0fzXQC6EzcvL1jjMyxb+lYi1iCpRzDA7g7iRS72eeuxxvpn6ua/13BqmZq0mJgwrycdU//gQcpYzQMc68DO/5TqZ0PWQdkqiG8CX3g8tu1UjgtibChP7J4YdAyeGYoKX1SoO1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FylzTH7q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X/D+VmgF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AAFQ9Nh4071541
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mcdYC2GUWX3Yt8G/A+qwsr5JfoxF8rsQMfbirKGchD8=; b=FylzTH7qXckURdUD
	OLX83HGhHgJ+Q9hrI7XQQPI62RDSKKMBhh0bziVThWbjjxWf5o05jdu1XEuAvH8e
	y2wjqPz9YWG1klmm6PcsEK+dGJf1TE1OFvEQ5q6vtg4vTtft9dNnvAYFpwAGqYtI
	5cMkGqXJG1ErKfP5JM7siZHbbmnWs/YWf5DSJ0zsNpgkSHyyNeWJZlJCu9fSBCTi
	h22vLn4WnQF6xiaI8+hwlP4O/MMi5QIvHss41z8H5CVHvL/9YdB88qbjl7VH5R9z
	+pplPbbGPpUqPwS7snab8AalsHi+UjuVhJcr9kzTwD78uwY5lHZ24hYcBCC7LlYH
	BaYOPA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abjpgra4r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:48:23 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ed79dd4a47so92757851cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762793302; x=1763398102; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mcdYC2GUWX3Yt8G/A+qwsr5JfoxF8rsQMfbirKGchD8=;
        b=X/D+VmgF60XNXX22/wOK7wdHv2/w0T/JCEsAD4MmH46pDDPs3Twli0rtlb0fowy+No
         cbLmZVmZmTUCJoRxPcF22KL6O8ticZpgh3neEYuLa5HfVPLLN49ijmRq88dXMDu/UAF8
         JKjzOf9n5fsndV1ySJQzDpFNRq25lLRubFv7F0vG1zoLksDEwlMWH8YzFL1IYFFFnhg6
         +eF52UYcpkq2nfdgnKIkb+Yad7HfgYJH2KEW/tHnYvPy2ZgYI+4UPP6xWLN/Y60NHKeq
         T0fJ4drz+aCN4RI7tERQXAI5byvjxtzdeOE+18mOINaG2aqsCGZrHc3PmPKmF5oqiQ+x
         5P0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762793302; x=1763398102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mcdYC2GUWX3Yt8G/A+qwsr5JfoxF8rsQMfbirKGchD8=;
        b=n+fKpjXIgu/wY6SgdWzVFl0lu7OLfMewNkapWWMl3GGHuHLomnB65faDLyS0RHhyV+
         6KzCk4z6EVQwZE5uWJ/DiAzQ2Ndlke0kqg6/pPbmYXRhq5lO6fkbi2Wd1wm2uWIhg3/9
         fbjuekleBM2gs1eW/bwiSVrmue82klyIHfu90FF3kNC9EszcooSpnJ/KinK+xlOkCMN5
         SPhjasizkoYpd98al89FmDdyUR0wyfZPO3/SI7kRxVTYio8BOaZM6j1xwPUUXE94laie
         1S0RjzwFUxkdw4sUdES8kbJIjk8J9GlPeebMJr1hk5rEBR111kSBXTTz+Kn6SBGNxrYL
         Ap5A==
X-Forwarded-Encrypted: i=1; AJvYcCUOTo8JsuGQgDELJconx3Es9aNs+Zx0N9xfHrVkwtAgf2yiwThsVmlfXISNm8eG7vdtkAPk86DgV62D+qA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyocZz+ZV4tiSDQexiNjI9LBqReVW64BsVPc0ZUzxWMDDXSVqTL
	OL4C8P6aoPqtBAMAUIOmqo5QAANKkrkAPri1jNRW8CUcZUpICgthkyd/NqYSor3agyWk92Cl+pO
	TWQ2RCqdKhcuzNqmA522EvMfshB+Uo5VUE+nuMHA/MfV6+elgJQVVIPWAdfpfa6270ks=
X-Gm-Gg: ASbGnctR/zp2sfHNlOBsuukEFELIcjE5xLfl6SA6zqaRr8vXy6pmruSIRzdWOEYJ08P
	p3yaJiKKABuPQ7fgMvzCm7Ptrm3vt42WIwZ58yxSXdSnQeDffzXWEwiktUTVKrtPW4fYQOB6R7F
	c9yLZH2PyIT73dtk39+5sLDOFJtVUua2eZivpvJBWzFTYyDYhc2+hPBzFkQS7mRfn/GOd3JueVv
	wc/oVUI3gb94ZTTBZK6TlXOIaJkKEgWKa+gJJ9QuwJW8mXgNhzLxi8SAu05iHkEPmDLCxQ2g3X7
	YXscobMdTh1yRvgs5k0xnWquynhuHpgEQkUvxYfZ5NRorFtwSXGy70Pu36F3OmzmEXuVTl70sct
	Gyx8F/zaA9IEZCHgAdf1ae/E=
X-Received: by 2002:a17:90b:3d8d:b0:340:c64d:38d3 with SMTP id 98e67ed59e1d1-3436cba90e9mr15119943a91.12.1762792696047;
        Mon, 10 Nov 2025 08:38:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpeeLzlAYES/pvtPhYhWt6lEiwIUScD1B6YRIb/1r23lLyKUJQumTRvtgD/qeTqkbN1zcfMw==
X-Received: by 2002:a17:90b:3d8d:b0:340:c64d:38d3 with SMTP id 98e67ed59e1d1-3436cba90e9mr15119892a91.12.1762792695560;
        Mon, 10 Nov 2025 08:38:15 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c337b20sm11468922a91.13.2025.11.10.08.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:38:15 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 22:07:07 +0530
Subject: [PATCH v2 01/21] drm/msm/a6xx: Flush LRZ cache before PT switch
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-kaana-gpu-support-v2-1-bef18acd5e94@oss.qualcomm.com>
References: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
In-Reply-To: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Connor Abbott <cwabbott0@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762792679; l=1640;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=0RH5+HB1DhuPB+qO4uxLrDpF6juU+e+LzCOFWLT2Qxo=;
 b=QKpYscsE7JUidxLJTjdztF9wYuuFQ9/van/0jE0PIt/jNOJ6D3vBNzOOdZyJ/eo0wJsHZeZJC
 YOytieMGrHrAXCLYQcFt1IEg81WjWnyBwdBPtLgVa7LKRAYQ44FDAn7
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE0MiBTYWx0ZWRfX2zVOEqsEAwUJ
 vq2/USFQFnWsEfNTCMTBTh/fbpJWAZsLBCoejc2Tvwdvf/prqtCOgevYLJL8rQACkiI2dNCs5ZE
 NHk92UPMzhiANeYCv1+nvTlphi5yeTEeGqw08d0JdLZwf6zgQkqf3H+blfhrtsocbfncuNL8/lR
 dFdZxvMgnZwr2qT/z0tRRNfMvNEPWHhH/PNU4KvR9AEBVph4/4mAkHmmqYv5wLJY44zlW1HxTGd
 QTxxp7ms54Fh1gDg3k55McUazHMKzlLhM22cmP9PhlyAMREB70JtwVeys45ITDs4jg2KskUa0gs
 L/wEVhYhnqPntt7g72cHNs/gKvajkdennsUd43JfNSpQKxXqi1Nlb6ZABJRXUi7HxYNpZMYWnAy
 rWxkT1EY3RHZBsCJo/tionx6kL1+3g==
X-Authority-Analysis: v=2.4 cv=br5BxUai c=1 sm=1 tr=0 ts=69121757 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=bBR9okFf-Jgdumx6fEkA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: hbrUXX1PlucBsbRyDrcmrGs91lJpuLxZ
X-Proofpoint-ORIG-GUID: hbrUXX1PlucBsbRyDrcmrGs91lJpuLxZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100142

As per the recommendation, A7x and newer GPUs should flush the LRZ cache
before switching the pagetable. Update a6xx_set_pagetable() to do this.
While we are at it, sync both BV and BR before issuing  a
CP_RESET_CONTEXT_STATE command, to match the downstream sequence.

Fixes: af66706accdf ("drm/msm/a6xx: Add skeleton A7xx support")
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index b8f8ae940b55..6f7ed07670b1 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -224,7 +224,7 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
 		OUT_RING(ring, submit->seqno - 1);
 
 		OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
-		OUT_RING(ring, CP_SET_THREAD_BOTH);
+		OUT_RING(ring, CP_THREAD_CONTROL_0_SYNC_THREADS | CP_SET_THREAD_BOTH);
 
 		/* Reset state used to synchronize BR and BV */
 		OUT_PKT7(ring, CP_RESET_CONTEXT_STATE, 1);
@@ -235,7 +235,13 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
 			 CP_RESET_CONTEXT_STATE_0_RESET_GLOBAL_LOCAL_TS);
 
 		OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
-		OUT_RING(ring, CP_SET_THREAD_BR);
+		OUT_RING(ring, CP_THREAD_CONTROL_0_SYNC_THREADS | CP_SET_THREAD_BOTH);
+
+		OUT_PKT7(ring, CP_EVENT_WRITE, 1);
+		OUT_RING(ring, LRZ_FLUSH);
+
+		OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
+		OUT_RING(ring, CP_THREAD_CONTROL_0_SYNC_THREADS | CP_SET_THREAD_BR);
 	}
 
 	if (!sysprof) {

-- 
2.51.0



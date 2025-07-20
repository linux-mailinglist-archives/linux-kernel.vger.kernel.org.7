Return-Path: <linux-kernel+bounces-738213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DB6B0B5FB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 14:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B43F67A925D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 12:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CB02192E1;
	Sun, 20 Jul 2025 12:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pGlAy1j1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A053218ADC
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753013829; cv=none; b=mljNL6qeCWp5BMbW/bzH7Jzuxy3gvqSDxSN2dTaDOfPElIQHUFCAZACGpEwHdcZGEny4vSRzWnxkKL5Pn4FFsWqNmVP68axEJYxgFwiXFpw1Law79ldk/bqKyapM2qGJuUR8xjEhUQDOlURWPKDCvDmaT/dRA1ng8DHG2XgQAAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753013829; c=relaxed/simple;
	bh=3stwORXOyD2lHblr894e/45a/C3w1GwYkrVrwU46SQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gla/x/Y6VVpvYWqSUbyDByUU3IBPHnjrbHkEM2dGUpa+yoh89fYPlLRaTuykiJJST+9wtgxaReW8/HviQxt6N8DZq9GRn1R9ybbmGS65FyV9uPeVBvL6xh2GteJex6u4iOkW6OpHa1bCPyniqxSYxr40SRXmHeZXKQBc4hjjR+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pGlAy1j1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KAunmR013853
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kW1RdFmcoOsd1EwSoqf5o3Zsu7xmMON1mp5RNrIB+Pw=; b=pGlAy1j1w0BPkw9q
	OqoPVYZpD1yWIRztmchbQhabtaijsVtXSxz0ii10+HUti0UOP9Y1chBEXfCJ6wPs
	cr3ca4ZYA4CXzyao3IcYNyXzs6oU8uDdX5Eo+iIapJonSnahqpsB6WFuHY6nIOAz
	rPmZa220YEvmQ9CPrivOoQx8Btnc0giA0WV1B/c1Z4sYT8eTqmD3TMmnyQmmA1Uf
	gzdmOb61QzuHM0ixyaGhwZdONlTYHooKWhqLoonMN50LsHnLjZiyj6FEvGU+divW
	iZ4MXt4ReRwk9sAb2Txj5jWC7MIZ3RSfBbpu7Ne8+zzSZre8nlgcwnx120cx8EMF
	bMBEVg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804hmj407-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:17:07 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-748fd21468cso3237052b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 05:17:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753013826; x=1753618626;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kW1RdFmcoOsd1EwSoqf5o3Zsu7xmMON1mp5RNrIB+Pw=;
        b=hKurMoV1xBGcjNFbGEtvFWlXm0kdh8XOCWJA4Jj/qtHGlBGbhO1dXbOY17+sanmvXQ
         4GGLysdSSoNveyfRLWxTs2zVucE5FEmeP5TR5KnuoSURLIKLfugxcMLnRvdlxrybiMYQ
         7GRExq1uXNt0Oa9AVjiWzndLJtl3UsZSPVa8qP/CbnZgfFBvxHQipQJxct2l0MrTrfi6
         BRkJ80DvyoJG1qZIWFhyLCqONuqDOroBbQa1mSetyloFL2G3PN3XfsYdcDrInP+8IXj1
         Oe++VPB4WUdG6iGdU6QDizFmAO2K4VVcDP7iVe2VRj5hbdWfwTS3dstvQ5reh7spmgyO
         p2GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsUfhtswQ99DsMZaWqc3TKiol2ekJ9Be82GaVUtsGTRZVmv/dhLNoVVzNsit1YfntvoE1qiL708Q8HMuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2pLeLuypyeRWmDXyjMmFyOi9Yyw0jkIIIWQvbkTTIJKjOjGJA
	DLKe8G7PX7ufFAx6/jlR9uTC5KEArDixhPSglbnkJTlfmRKeZ+No1CUZtGH9uzVkYBJwL262WUh
	itPWL8H7/hTgTVacEmFR6ZtLSb8bT1PpdPDoTxU4RWVjyfXIKqgI+neenZPyd3vvlGuw=
X-Gm-Gg: ASbGnctn00/op4AOmJcNn31gRxIfRjAut74rlvd4duVd1GIUS7K2dC+d/BxNw85N+lo
	HrZTNeOtqLNHrvtZf+VSKAvHiVRraBkX8ZVJSXKUT8G7b5IZTo6Do8KSrsKweD6jZ4do69e63zS
	ZJnEa5zwy+unNf36gEu6nR9t73f22eecbfJ4znwQqMq8pGpulf5vlzqMMkK1zwp7ZZHkyBvH8vX
	tXS0AWJcVsWjnWJYcQ/yPh9LtYMDiEIPhbkSrzEHB3C+KBsu4lQZgWEWPAhuNVVZJdNS4M962Mm
	7li7fltVT8Z1d09s/aDpHk4yAEmaYc2XDq4WAP90YGTCeLcyw95ObIKafjV1qYLZ
X-Received: by 2002:a05:6a00:92a7:b0:74d:f997:1b45 with SMTP id d2e1a72fcca58-756e81a0b16mr30560723b3a.8.1753013826571;
        Sun, 20 Jul 2025 05:17:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJCPBQtnMXy/jZOOBKiFVdjpswk8HG9jRo/IJ5LNgu7cBW5KadTD0q9XkvVA+KGaxqwWZhYQ==
X-Received: by 2002:a05:6a00:92a7:b0:74d:f997:1b45 with SMTP id d2e1a72fcca58-756e81a0b16mr30560678b3a.8.1753013826033;
        Sun, 20 Jul 2025 05:17:06 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb154755sm4097933b3a.69.2025.07.20.05.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 05:17:05 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 20 Jul 2025 17:46:05 +0530
Subject: [PATCH 04/17] drm/msm/a6xx: Poll additional DRV status
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-ifpc-support-v1-4-9347aa5bcbd6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753013805; l=1549;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=3stwORXOyD2lHblr894e/45a/C3w1GwYkrVrwU46SQM=;
 b=18D4fLzbFzbWn0lxY8knNtoN1Y/tXd2BzOVJmRzc5l+AkfoVEX0r2tMLbpEmrVxCkaWemcti7
 3z95YWbq0QbC08z2Xo5a7RbYiQ7+dZgYQcq+GPAXdz3j6ZBQF1W+rhp
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: efjpSi1pD9s1j1_eFFtAiXa_lylA9Yzv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDExNyBTYWx0ZWRfX8YQPJoRy3P1U
 f0/ptInxCp//HbvZ6zvVOpG0II4OmDO2OHBVa99cUk8A9IkndCWre5RapN8L7LmSZ8qPxXhctZW
 Axd+mcllDXmDNxGcad0rJVWm8Xua7jBVbJYja/fwNFNj09hDLNFkLRHN6Ftvs/lquL29Zs1Pdhr
 UVMnpf90/ZFl+AT1LltAxcs5A7PuCNs4TsfHvy16NuENFHGmxP7N6tIDHX5v/nIgeBGocFKA2H9
 F9IUq+qgOSTaoyt6UfrTOC8iJIcD9MINimB/S8r3CWK7Ra0GH/o8RpmlzyKtQBSnscXlZSH/f73
 +i9OT1O0SKr08z17KkVuSjTg5MH/iUrjSKdFZ22iWYxZUwgMvtnZbsHTCLZRsHP3WlyQXMmu2ZR
 vgCToJgU8ku6JPnIX9NM7pDT6TispQy1aSaTtWk0SR7Z8k0sAItKM4iIHhIjTvFGSHOLa823
X-Authority-Analysis: v=2.4 cv=Navm13D4 c=1 sm=1 tr=0 ts=687cde43 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=D93cZsf7Dk1NQdFOo6kA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: efjpSi1pD9s1j1_eFFtAiXa_lylA9Yzv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=883 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 clxscore=1015 bulkscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507200117

A7XX_GEN2 generation has additional TCS slots. Poll the respective
DRV status registers before pm suspend.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 790ef2f94a0b0cd40433d7edb6a89e4f04408bf5..3bebb6dd7059782ceca29f2efd2acee24d3fc930 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -987,6 +987,22 @@ static void a6xx_gmu_rpmh_off(struct a6xx_gmu *gmu)
 		val, (val & 1), 100, 10000);
 	gmu_poll_timeout_rscc(gmu, REG_A6XX_RSCC_TCS3_DRV0_STATUS + seqmem_off,
 		val, (val & 1), 100, 1000);
+
+	if (!adreno_is_a740_family(adreno_gpu))
+		return;
+
+	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS4_DRV0_STATUS + seqmem_off,
+		val, (val & 1), 100, 10000);
+	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS5_DRV0_STATUS + seqmem_off,
+		val, (val & 1), 100, 10000);
+	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS6_DRV0_STATUS + seqmem_off,
+		val, (val & 1), 100, 10000);
+	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS7_DRV0_STATUS + seqmem_off,
+		val, (val & 1), 100, 1000);
+	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS8_DRV0_STATUS + seqmem_off,
+		val, (val & 1), 100, 10000);
+	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS9_DRV0_STATUS + seqmem_off,
+		val, (val & 1), 100, 1000);
 }
 
 /* Force the GMU off in case it isn't responsive */

-- 
2.50.1



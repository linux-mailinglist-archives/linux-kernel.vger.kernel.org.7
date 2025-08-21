Return-Path: <linux-kernel+bounces-780480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C231EB30275
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 653B21CC7CF3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F6D3469FF;
	Thu, 21 Aug 2025 18:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F5m7PP76"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAF6345743
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755802582; cv=none; b=qi40p13Y9daf1/Zqt8064ryOuoVqQTJPxHmrZUnPkx8XchphLI40uodutSe7iKI7Lbvc4JY8NLgq9/4KMHvzC2gD0w1h0/Tz4Z5D2dQFDQ3tRRV3MvLR4XxlIFzB8dVXsiMjZtEjxXt/UOixdpK7tyyJsLXLm09hhDX5UkPU2AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755802582; c=relaxed/simple;
	bh=dh5yRCCrqgo7ITPRxOGs22CFdqaavTKFG8dmxBRd41I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jozVluaETeYw7tqKL8AQXnYUz3r9PHMAJxfivsGmM1lrtFWdQQEUxM6jsX+xZ9rWjX6SxIfvto7h3H2+bc73sHO7ga6AeNdCcLtYHgUZYNDgKjh46L3aM3QrV3aCw/dGmwhz7xZcklDyyn2YGjGtZHnnZkW03V653TQ4S995o4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F5m7PP76; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LI9MX8012727
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b2aaGGi9vgh1ezkBA9wTuECFddorJT4shW0GuOItXNs=; b=F5m7PP76e/eiqROC
	vH9TlsXcBMa8M91NDemycmNCAihQsQLASWEUqCp2o0y2hohDkUdhxUQx2zKT4uqe
	kU8cjQB5PsR4nEvu6hQJAnmzhHLDNX8KG+PXeCoY2kbLfu13JzBr7U4/C7KynRHO
	9DDygMSCV0AuBdA0y04UTLCHFbKYlyxM6sUKzdo3zMQOLz43Lqzb/xS46JJY5pav
	5g4IJ3Wa2zmxuVgy3W5FISh/bzXr6vohl8DNmkaPLKstKXS67hXF36qCeqh17dCf
	8PwX/OYICINDfKkAZekxKU6I7jvLE/uXF3pwMPnc+eImw1OoDrsPqQpLFzAJGCbv
	twpptg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52dpf4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:56:19 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e2e890901so2482978b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:56:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755802578; x=1756407378;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b2aaGGi9vgh1ezkBA9wTuECFddorJT4shW0GuOItXNs=;
        b=r5zV0CJ1ZA0XWf4+CfdaBpBKclpGYoICDGzOH9MSQ0Pz5XE+PFHIa0Kyiw2alSx+o4
         86x/oJB4YZJogts3rUNuOt7aCSYY+Ww/JbUGthvDBrmJafDQo/Cqfx3o4LoBHS5nQrK0
         fQpmzPJICIIQEr2Chi7yIne9dojPfRzaFoD6FVMkNh5V33CuZM7yKo2r9vwiGq6QYNit
         0vFsiuOBrqoPjKV6XngLmehv6mXrBvWOMnsbJOYUTNiBg9NLhAbTFlGO7Xf9w5IIANnz
         doAwlzEZ7PKRXP1jwnSUENNdRsicRx8I6Y4S0VpGaICgFeY9mUxTYT3rtkIkdWbCASBM
         GFqw==
X-Forwarded-Encrypted: i=1; AJvYcCVKiYaaKFnycEWQm9vjyh1a/cFD3IULcnw9LbZ4l+uJopvtptxDGO4fzEy5TmaMOJKXKziz8AwD4CYPDc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuLXfSizxt1Msd8Eg9khuoVXBUcZdElSYfvk7EJlfxGMyw0+ku
	VYXw2CrQsv2eem0QbpK63djgMhYNVWN/qbDrA4DoU/lpmA90kXvxrsaiS1TqFF5TcpJDSdRW+D0
	psN2fGrWlsV6NrOw+HJYGvsywdZcVolPkfVQUadEXBcCciVvvx41+5ipgu+jZqZfxbNo=
X-Gm-Gg: ASbGncsW/3eU2DoK73b9ttYWiDnc1ZN0yrN6PTrvTv667z7Ab23RdP9eR+afzd1izkl
	655iD6K87zPGCO/kMSoKNJOeTAJ8lzuv+8gmiLkcVtW3639h3g9WJhlEj1knbR4ZT+gjpLBWvKI
	aC7cm/Bib3816cFIsYHElnDlpo3arwNS9g1ejknrtKTsv1ShHrAqIAGxz4R0iFGJBBOnn6Oazxs
	wO2jdIVBDO9y0237wyruetpguq2+6S8IL56rZmJjT1QMroeb8eqoJtBqisP6yzj+h09qac6PgHd
	p1wdmAUcli1ZiYalNeOYBxIpPlNSbzwdcRBN+GtzDUT/yFkxOiBqYFCArBTIPv4e
X-Received: by 2002:a05:6a20:a11e:b0:240:1bdb:bed2 with SMTP id adf61e73a8af0-24340e1c5e9mr249976637.32.1755802578344;
        Thu, 21 Aug 2025 11:56:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/PvcztiKQ3+ysLQC44wdzL2nnd84bffnnBw7HXxvb3QajRBbw4ri6k6aeKp1I8dqHAddoNg==
X-Received: by 2002:a05:6a20:a11e:b0:240:1bdb:bed2 with SMTP id adf61e73a8af0-24340e1c5e9mr249926637.32.1755802577894;
        Thu, 21 Aug 2025 11:56:17 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4764090b0esm2106977a12.37.2025.08.21.11.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 11:56:17 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 22 Aug 2025 00:25:26 +0530
Subject: [PATCH v4 1/6] drm/msm/adreno: Add speedbins for A663 GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-a663-gpu-support-v4-1-97d26bb2144e@oss.qualcomm.com>
References: <20250822-a663-gpu-support-v4-0-97d26bb2144e@oss.qualcomm.com>
In-Reply-To: <20250822-a663-gpu-support-v4-0-97d26bb2144e@oss.qualcomm.com>
To: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Connor Abbott <cwabbott0@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
Cc: Gaurav Kohli <quic_gkohli@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755802565; l=831;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=dh5yRCCrqgo7ITPRxOGs22CFdqaavTKFG8dmxBRd41I=;
 b=/5kTakfykQ3AmdnUdoMQ4AB9+wrpS6Sg4icxX7Pn8G4w06qjqaLrqdMWxoFfR2c6gCf1yXHzU
 hcJfMlyo44VADh1a3HtlGxlKxaAgKW+a2+/QdkolNcZo5tFG1ddh8Ea
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX+nIxfuK3bH84
 VKLp2zuX65O57KamW8CWZTrTBuPDIoFIKK7LHX1Xz9SEsQWiIC3cqUJUeGekurWd6hYg+8KjM5E
 dsJZRJH8M4qERZNmyvoxzeUlxTfxjW2UUvnAK6DDVlENJ335yIWqVhq8lAR24Gxh6oU2FesOpcy
 b68kCBRKayt4rZIN9w6aWHqogTcwsZnBJzsqj4xdUbeUorVJQ7P+C/nVfQbb9KNFuMMqqv5mTKP
 Dqh3ypz+cNHB+S614ocy4Z0VZLOePf/0Dkr5HP54/b1b3W7FE8TyBMoML5uqMbW7isLq078SqYd
 1QRu/jxdxi/MWkNJ67jB+IfyVJhcINXU85J+kSYcIoWh6oO+TPXGSPYCbbUCinnRwAM/SPeBNFl
 emTFEEtbwsY8l3N5Auo5uwv8zthBXA==
X-Proofpoint-ORIG-GUID: exNewn6xcFKRRMV22SBemb44wKcImXZ0
X-Proofpoint-GUID: exNewn6xcFKRRMV22SBemb44wKcImXZ0
X-Authority-Analysis: v=2.4 cv=SoXJKPO0 c=1 sm=1 tr=0 ts=68a76bd3 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=HtRe1b87dyxWHwbGPHEA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

Add speedbin mappings for A663 GPU.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 00e1afd46b81546eec03e22cda9e9a604f6f3b60..2b1c41f6cfeee912ba59f00c1beb4a43f0914796 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1024,6 +1024,11 @@ static const struct adreno_info a6xx_gpus[] = {
 			.gmu_cgc_mode = 0x00020200,
 			.prim_fifo_threshold = 0x00300200,
 		},
+		.speedbins = ADRENO_SPEEDBINS(
+			{ 0,   0 },
+			{ 169, 0 },
+			{ 113, 1 },
+		),
 	}, {
 		.chip_ids = ADRENO_CHIP_IDS(0x06030500),
 		.family = ADRENO_6XX_GEN4,

-- 
2.50.1



Return-Path: <linux-kernel+bounces-810077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DA9B51592
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A267177AD1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA059315765;
	Wed, 10 Sep 2025 11:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RwfUD00L"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B30527CCC4
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 11:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757503574; cv=none; b=pGQkrvIGnSWsXd80Gju2kGmWiA1YJ5qa5M3FfkgrJm5EX1nF20qOt6Z47HlGvKCiKFl+9z6EX4FLSXqnwq9gOX+9bZFLTF6rZ1PiL0LmbqwbPI/I7Wu2OEN7XnZc6TV9KwFebG8wMHAp8uNpbXebPvlv2puN9X1zlWw3DDLFTSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757503574; c=relaxed/simple;
	bh=uzPVmN95UYA3m4eO5APKZbdkhOvUBX1OERZwHXJ9QPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uzHgy1h/0+ofisGY2PN1nwzb2bIAxvvj5A7/CIczwABU/UkyZkgcB7M+luCOWKtH1w/lLewxOiJeN0Mrcz3gCysc9mCiaxhrIiUnCVv5V+kh16yH/u1sWwI0D7ECMTCbl//3GSQIJ7sXMIeG1YUb2VBH8n6v4hA3/i9MiZxGzEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RwfUD00L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AAFEWI012468
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 11:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gt3lMrqxrsh5HFvqVveVdKW5qqiAGEIrNSWV3HoZYpQ=; b=RwfUD00LFWtG3E6I
	qKtyTpK4TrrkwOlzlHuWsp++82VkijRFCSQvCmJddvXXATjlU+h3uIzB6pZsxbRC
	fYYHhj28oiWAfiiQFMeVSDMZ7dozANHrVlGmLGMoh/Nd3j+n90/+6tlUujQ6xHDz
	styoXDDMymUjx9dZGHlS11AqskLNnd3NBFT8mmoE9jKDVf+eFEI9nxvdNGlIgS/a
	vErf1RZUznb/WyfpL0HTZvayy5T75hHKMoZV4MbYDAedpSsLWX7iHZjO8PLzVrBq
	nzcxj4gTs9x3eVCuZLGkx0tgOG9qBCvptcGGObZxugE7BOgrW/csjBCm3hgqYFFK
	2QFRSg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490bwsbsjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 11:26:11 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77422201fd8so5166870b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 04:26:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757503571; x=1758108371;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gt3lMrqxrsh5HFvqVveVdKW5qqiAGEIrNSWV3HoZYpQ=;
        b=rPZ0bOWpTszzIcBJUDjfpE+ZvbL2MafvWqMJcycBJKBDWPzqKEqyLdr2vMLV7dqlZY
         cPoQGPl4NUAg1KZ0UGnB7XVHEaUtvr0fPBFUFQais9nrKVnromJ/s/tQ0jxhOVp4vdSZ
         S9AMiMhvWPvkQU2CEe9B3RaJ2GcYq+c/jkX7/H2wakqa90avsh3s4qigdgq47UBpBrd1
         2xYbLz1TPEmBeIzRAGHB2oqJC5ePyRvl1knLvCqLwFsOQdPsIRTacdL6hUpEzDLF6iUA
         zsp70Onbd//VSaeL2Yfn1vlH5Q5wUlpaDJ/L/h67a4ANbDzeIaFVWVnzd6eoB9p8vd+x
         zf8A==
X-Forwarded-Encrypted: i=1; AJvYcCVN2ur/I4e92buTd3BATE4Dmu5h7pF4+6fXNnY4f1Pbab3vepLm0nWVt4P8NO/rlHR8mcQh10/ZxmGtnU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6gI9wcrK553okSefneepmG4yDJz7R20mbtdvKZUs/XgtBVdkM
	I/fTAUJSliacLuAoQJ2/jcL073Toq42TA+Hp/scCtNYmb+WJHuk3MCNXEtKAi55bmhKyF3j5XPF
	geX20Ghs40e3O0XRmdYy4/lEV5Cq8j0WjANkFjFtku0SD3bqiLpZVdZtgF3WESOEMQGg=
X-Gm-Gg: ASbGnct7NuMxvihsb6z94touA0LUjw3tRIqpRNeNlIp6Jn4mRly6oFqm/KtpjTMHZPq
	LHhi6PK0VWbzrz4U0BVM0vC/q1ULIELDGEpT23+ecsXgAxk5eQTpF/XwS6rS3EqndQx6p/KWwi7
	/PXo7qGNB3wJ2xV6vBUT+A/EpAhvIVNL0tPv8wNEllt4bm+PPLIKu6oPqOBgRk1TtP12STSp8ov
	SPTq7+Xwt3s8M3eQj3o47Jcw42aeAHr2v9X/P6My76JemXqU5KvduTtYO22RUY/ro7eLn/5CahY
	Z5XUPV+D91Bw1Fn5k4hIsI3lITvLJ2VRxyJP53oockOMci6YHVSlaWkX53X++AMT
X-Received: by 2002:a05:6a00:14ce:b0:772:3b9d:70fb with SMTP id d2e1a72fcca58-7742ded7359mr21704518b3a.31.1757503570703;
        Wed, 10 Sep 2025 04:26:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGL+jXRvCFnuy9K5s7zAAadG0Sf39RWmu+cwoO05ITAyVd+5McQwptiwhwv3oQ8fuawRfi01w==
X-Received: by 2002:a05:6a00:14ce:b0:772:3b9d:70fb with SMTP id d2e1a72fcca58-7742ded7359mr21704478b3a.31.1757503570177;
        Wed, 10 Sep 2025 04:26:10 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662c7384sm4862260b3a.76.2025.09.10.04.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 04:26:09 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 10 Sep 2025 16:55:21 +0530
Subject: [PATCH v6 1/6] drm/msm/adreno: Add speedbins for A663 GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-a663-gpu-support-v6-1-5da15827b249@oss.qualcomm.com>
References: <20250910-a663-gpu-support-v6-0-5da15827b249@oss.qualcomm.com>
In-Reply-To: <20250910-a663-gpu-support-v6-0-5da15827b249@oss.qualcomm.com>
To: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757503556; l=898;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=uzPVmN95UYA3m4eO5APKZbdkhOvUBX1OERZwHXJ9QPs=;
 b=U1kGtdA1U9VR5G5dL7kDdE3dQA4lZ77QOfk2JkSYOMau99SLXDF4cj/W5i6UUvvnnF1JCd/cA
 NOgMg7nJzKUCKhcldklSwobxAc4fXE5pFPx13Sljlvxso5+uZn5kWOc
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: 048eEC1AM_MjnZml6dJJ7NDhBMmCxLu9
X-Proofpoint-GUID: 048eEC1AM_MjnZml6dJJ7NDhBMmCxLu9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfXzHT0+Q8CXVlN
 B5d3+j3HzKrL3SBIJj0c2+FtID03avQwZsESLGPGbtMbnq28i5Dr0h5ry5Tu9e36Xakr3XYu2Dc
 tY9zVoSn65CTjwolqGT0i4jccMRl2j7vm1cYg6Lo5INS8+BK3f1Tjg+4n5HLsfrL5EAFYCoPBcY
 2xUWX0hT52MoUM8o3QXheWyMwqEx1m/aZt2HUK6MmNUyhU8cf69Nbrm6wsa4aTwv9WJ9bhU5YKd
 WJKVxNfyQkQmMBlPqhMYQM6jg96diF0YmJSj8eujcFSUGPMiklGw3tseBNP5+SA5PxJrklD4VHG
 6c0KCt8BqQp5enOPNrtBhXyOpbRhqqbL2IyJkd3VdRkfhYiHJFHC0D5uJtwdCZ/igXhWLNbiY2a
 tTCLCAuI
X-Authority-Analysis: v=2.4 cv=G4kcE8k5 c=1 sm=1 tr=0 ts=68c16053 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=92do0itG5Mw8xxZS-WcA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_01,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

Add speedbin mappings for A663 GPU.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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



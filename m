Return-Path: <linux-kernel+bounces-805333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEADAB4873D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 341461B235D4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E55F2FC88C;
	Mon,  8 Sep 2025 08:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hhlPoUiC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DBE2FC036
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757320114; cv=none; b=tKp1sa8Dv0gm/l+hIpNIq4URT05q2L51VJjyPS4YhQtS+j2q3aOoswJGIJrezFyx6QTqfjQzbbeXw7cdzjDtodGSo+9VgrUVSYlaarC1KlpVS5mJxjQErmLAaZ9q4kvmwL4Bio/RqQVqRxeNr7GgmP42QBd55+ZfB+i02y60Rd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757320114; c=relaxed/simple;
	bh=8YnJ0ONhzBIexy/neyt6NTzPrJg4+1Ll8SHaMIGWprI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TVzP+l3d0jGXc1PtwysgXu/SGP7ipFA/FeugMCtVLYeuqcr6vC93WCZmoWyWRClhD7xIgeXAmX/ynA28NzFL4PhZuHgoSOKVRpsZ81NO7KdChnminHJKsMK8o6EXpE9zwGKCuatwBpFheO6r7eUo8hSZFqex91VPniEOaavlMYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hhlPoUiC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587NtL9A017237
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 08:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oxxwm+ypezCwm6BPpi+u2vyfh4HZ0FHZ1ZRXEui1g10=; b=hhlPoUiCNfS27+hK
	W8kcydaEFIN7wbBcbZDohWadLDBGzBG+XqIIPwt7/lOJvl3HWf1IagYDkhdPuhkS
	l5W/q4Plc2J3JswDd5LIqGGniohUIqu0o5AAmF2zjSU73/vNvqhbalP43AJL3NND
	dMhU46/Pix6wWIY5xa7dvJUb3ZgHv6nbketj6G0VpA6Kh6mL0uqnaBGthAYw09Uj
	//jZJ/LZEeK9kFpl8c9dDrwZDKzsisiZ3pUYGvL84o/qatAhekCZcv1YmuS/xnlp
	CjT6VK//11XDQ24/OaGnZY/Ot/KihuSiibB0cFdnyFZFpCSRZdJPj9Qx8zIiJKPD
	CSQqpw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490bws3vcr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:28:32 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24caf28cce0so103690025ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 01:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757320112; x=1757924912;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxxwm+ypezCwm6BPpi+u2vyfh4HZ0FHZ1ZRXEui1g10=;
        b=d6i+i52JqZleF6UW5823Up4jWoR8Y/9Gw4RLchbTtB2SikCOvdZ9uKfzAYsZeKYBzp
         UdtkRz2P7ieZEYnNTDGnMBk1VvdIxHYSyFcLC4dJdBMd4F2RE45UtnWFiV58aBzxzoTY
         pEItcXQu82rLTfhxsKkuBwXSiIeSeAYhDRms21AAOjC+vfTjO2g8iHO4AAEca1p/oHan
         8DFtLLOUsBO1SP5kcmSeWYUAAlx4tW2yWQpHV4dFNRsrfOI+AyMrVDxIs+CMjQBhr45A
         Wov8xB5OBACKvuPZs8B/z/MUImzHSe6rsU9nBPqCkWzNe8YVhOlCmZdWoVrQV5yOuOGh
         mEWg==
X-Forwarded-Encrypted: i=1; AJvYcCW/HuD8+sntrxocsG7UEwjCNXGsXuaCgtbBn8F5LTNQs+lF1GrVzHzZD+L3vPzh/1ZzU9LnUGZ2zbMZK/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YypLdYmtitjogDGI1Hp+BB7D/Cfep4/fNYela17O8I3fEA9a47D
	OFwXwwSMHzURH97u2qzm02DtTkb/KQnWapUtom6VfNyVgG2XaHAsRYEb+aSrn5XyRar1RCNJUBH
	hDDRVjGqApNRJmZTK+XmzQhRv0A6joFKe12Ij1YPUuklCiW8ZoDcg+I7Jcy/WBymZ0ns=
X-Gm-Gg: ASbGncsyNOtVWZazP6RmzfKf63w9iMw5aG0IhhoRMgDladwTvyl116sxH5wORDunfn/
	/meFNbSujNbCdp7Q8N+n7ZcgqeQUiyOLScWzC8QEZsJj9eQjAie22ud442phj3vartmV6Zx4Hsh
	EaoF9SMORFo/F19rbUrHmwG2lwXAjXgau/JzkbYi/bPkm7I/XilwSGiSfDWggJBBK7yaeg5ewkK
	iSHwefyaVQMbafauRKRPnHgZ9MWiJHFYZzTeuQvGj4zzd+4AMigNIX+LIhsapUmxeTGLMyUhukT
	CuzxWTv+/gm+Wzz9cnS+aMrkapSrgNUEK/TTBsBT2Yfy0fx4FIlmvWBDNyO9nFid
X-Received: by 2002:a17:90b:1c12:b0:32b:dfdb:b276 with SMTP id 98e67ed59e1d1-32d43fc847bmr8554012a91.34.1757320111806;
        Mon, 08 Sep 2025 01:28:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZA7JoDEnmt7AqwJdt4pyUQnNwI2XcSGTu2xDVrasXY1aPxGl9PN4uLyeJFuDudO5O+4Dzlw==
X-Received: by 2002:a17:90b:1c12:b0:32b:dfdb:b276 with SMTP id 98e67ed59e1d1-32d43fc847bmr8553992a91.34.1757320111383;
        Mon, 08 Sep 2025 01:28:31 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26bc9csm29157523b3a.18.2025.09.08.01.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:28:31 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 13:57:09 +0530
Subject: [PATCH v2 16/16] drm/msm/a6xx: Enable IFPC on A750 GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-ifpc-support-v2-16-631b1080bf91@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757320036; l=978;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=8YnJ0ONhzBIexy/neyt6NTzPrJg4+1Ll8SHaMIGWprI=;
 b=/l1IvAErG5vS1H8AZRE6E1eJuAQqOfkFg2PgpjJbxAG0YmEzCJLWURhkAddQLIvu89grMp8AN
 7tnV9+P5wEOD63JzvVh74oiN3+mutYEfztOYd3dDeQff4WWaZUvRxaO
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: dw7VUaGdN__NShQt8jDkjPNZ-KZAzwe7
X-Proofpoint-GUID: dw7VUaGdN__NShQt8jDkjPNZ-KZAzwe7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX4aFbSZEofPQt
 wYJE7WSZzWzI9DueJoqCw0xNZ4k5dnsS9ZAfPZaXKwCPSXZivBlM0yORY2P1V3F9MNyVHXaNHDB
 R1uZC+SY9hLSDGghGkshvWIoEaPEiZmU1VP6CZrmd2lHDwzLP4vWmpHZX3Pswqsvn/vuiln7Pz6
 uLPLsVFxFCRwp2c/BzsoyUXXExOYUsuHIu2vM8FSwAGbxPB5HdfGTMb1AYFjt8vTt6Jb/tEGDJR
 SVX+azApRBikTcLKJOqSwsj3NQCpLsBwG7FFRG1NAv0nmmiyogwR+u3wCPzonQeDS7PQn/vsBXU
 eodUTkP6E6n2YL4IHf4L6NvR71Fdnb+oMyXT4+9QipnfjX4wsFQkq583Bb/tsHK8BQI3LwR05xY
 T6VXDSzX
X-Authority-Analysis: v=2.4 cv=G4kcE8k5 c=1 sm=1 tr=0 ts=68be93b0 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=cz-sm3QmoJLqeNSv7C4A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_03,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

A750 GPU has similar IFPC related configurations like X1-85. Add
the IFPC QUIRK to enable IFPC feature.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 547c046730a9b50a82cc9b27f08a5b1eeb08dced..6008f8b0144456c5652dab4c6393b3abb7d709c9 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1525,7 +1525,8 @@ static const struct adreno_info a7xx_gpus[] = {
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
 			  ADRENO_QUIRK_HAS_HW_APRIV |
-			  ADRENO_QUIRK_PREEMPTION,
+			  ADRENO_QUIRK_PREEMPTION |
+			  ADRENO_QUIRK_IFPC,
 		.init = a6xx_gpu_init,
 		.zapfw = "gen70900_zap.mbn",
 		.a6xx = &(const struct a6xx_info) {

-- 
2.50.1



Return-Path: <linux-kernel+bounces-738222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9048FB0B60C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 14:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D9207AB2B2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 12:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6F22222D8;
	Sun, 20 Jul 2025 12:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kpSL+t0X"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF526221546
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753013866; cv=none; b=dE3s45hdZdIWl7Olc4lrARSkxAzjiUwXFB19VcVyFoKVWvCyBqR5lXBPliCWG0C9igbWe3Iu5AoPq1YViZTkxaZh4VByOPkrvy8QfLLhGLCN+ykJGJaVK8EvP+HfQojfLZkzVwMsc9H66qS0yIfPSzY+SDhV2WAUqAA1IERE1KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753013866; c=relaxed/simple;
	bh=UufTwoFz7ovGUA5R50wL9c78uLvl6377i+fkOk6Jefs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lF8XTchAGytI4VyRe9NX51dtC3mc6M7slTnjIyQw12VWYVmJmaNHhTpWCnNHRjnzpO6Lyqo8zkt17ZCntxSOLM4CA765L+dsHhZiKGB4OiRgQtOsdMIdendIRVyI47LoF824KEVdH4uuuSiwcBzpnfvUr+pCCKPlMU4rV+Mnh04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kpSL+t0X; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56K9Zik9008231
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ofDofdzCPVMyjNC6oHyPmSF5XE7uMFwOH2VSJyJTTw8=; b=kpSL+t0X+VTqmfqT
	c2f0IZ+qkOAgDrsZGF2kMOPsNS02qyarYBl8Om2IgKbrlukyqREtOzxwtG1kuNaI
	Y4UDj4OcL2N9UA6z5m9rjL1v5Ay6wpWc8AEUcVGg1O4GUzuQidhAx14aMR5+FbDn
	c0sDFBnF76FuJL2/VHY2lf/YMDJSTkcQy3o6UURWUHTpLTkk0UTfk5Rk0HovbtY4
	3r14Yy6zkk1Ec25pLmiSZjOWEoPi8lFhjf1y/CvrrXeOJwcvmN1GDCN73Lk4ztu2
	gCziGNMme/dvqeFmvrc42redOInDPL9nF+eWrNULzfzW1c1SkEONW7i7Jg8sRt1C
	1KSjfg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48045vt5c5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:17:44 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-75494e5417bso3299182b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 05:17:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753013863; x=1753618663;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofDofdzCPVMyjNC6oHyPmSF5XE7uMFwOH2VSJyJTTw8=;
        b=gUlmIXhgE6JiJYEuH9xYGPlFBJ+teST7eyqQj03SslovfEz08AJddGMEae7fh5I1SG
         FjE9M28Etce8HklOlZdPYmzVqhX0QD83FEyCWfcaD9J4OuAnbGuPhUq8ccV167odc3MR
         qI+QO5yoRxDdVHLWnwySe024fZxMlk1YxFjP+AoxVHoaWeYLRySaQr6/kNvO5dA5g7DE
         zeo7QDgYCmF/b9ohIu0q2ICTH0XT5YwrP7Jth4+QKI6Uz0dDWzP3P1MqSa5hT8yF5TE1
         gqO7TpSZ3gVU8N7xy82O9S5efvxhOE1esF9iule/rFhMfVCOoN7G73C1k31f9u8dw8Go
         Ez1A==
X-Forwarded-Encrypted: i=1; AJvYcCXHaiJkQk7dhRQ3OkfVp2y83Y3+pA+PCGdgLorNSu/lVSbPR5nImzomkDXdm8URIR3dkSImyx5qesIowMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YysVaMiBoNkSbGXZs3uqPOFWinqELne6uklBZ72joUFXK4KhewN
	SckGuB9Y1VNbn7IE7lUd83M/OXv3RE/qDaNEAaVw88dRmygXqG4M1QcLFdlD8J3nEeJK1Uep8iX
	5PQLDrFYswzATA3evn5wJETJouMq+DoS0WLQ50hskY06NNp06zQAWRC+rCyHAKinOS6s=
X-Gm-Gg: ASbGncvpRryc+jtLQF9LqaNXSXHNX/JpHSf9BkFk3FTgD09jrdcCj51uNIHAUc3v3fB
	hWJnwiTDZU95KSGtEjnYbNNOjcA3MGLwgtLlv8lcjH3Gz4sL0URCYKHEV3mXHL9voPIwt+gu0kc
	7uTnJ/k4LNWgrnESX15FFaYEtjAuri8p85oq+WUK/YjSJkrZDk1jeq9qDpVRzHb6+MetI5tU88I
	uoh6f3pP8PB3td1aXX+eTKwzaQk44LQuEnNL2EZCG6x2wdAuvpvr88y9US7Cp6RtXQT3dL/kA0H
	oeJXo9fqCh6pGSQa2BYN5yGxU1g9dQI6sg+9VIPwMtgmJnPrIJxSMRDxeU4o6DnG
X-Received: by 2002:a05:6a00:9189:b0:749:eb:22c6 with SMTP id d2e1a72fcca58-759678986ecmr12599042b3a.1.1753013862983;
        Sun, 20 Jul 2025 05:17:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmonQVHr4Bjv8W5fko1GeaHvzAIAD8dQNVPtEbw4P9/DZLSf2HcJy5PQKUDsuSf2r4OOuJdg==
X-Received: by 2002:a05:6a00:9189:b0:749:eb:22c6 with SMTP id d2e1a72fcca58-759678986ecmr12599015b3a.1.1753013862475;
        Sun, 20 Jul 2025 05:17:42 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb154755sm4097933b3a.69.2025.07.20.05.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 05:17:42 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 20 Jul 2025 17:46:14 +0530
Subject: [PATCH 13/17] drm/msm/a6xx: Fix hangcheck for IFPC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-ifpc-support-v1-13-9347aa5bcbd6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753013805; l=1726;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=UufTwoFz7ovGUA5R50wL9c78uLvl6377i+fkOk6Jefs=;
 b=CiVkKyycAjZFKjOMucGztI9T7mQEvFBYqWl/BB9hRnOWHJ1sN/2PxQHpgp6pXN3QaATDYWvrR
 h4znFJ38/PUBWDMBMqYvqyGNY0QXINe0yb2jEOge8498e2dGzdryR8t
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=LL1mQIW9 c=1 sm=1 tr=0 ts=687cde68 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Q_N0S3AoeJwl-lDGPIgA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: HOyd7eW3LpefoCaHAZrbmN0elEmOzWQV
X-Proofpoint-ORIG-GUID: HOyd7eW3LpefoCaHAZrbmN0elEmOzWQV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDExOCBTYWx0ZWRfX6LpWKUv72mZA
 q9dqfW/CC4DFqG7YVInWnpiOjLkaQP5GuytQN8wna84RvCmu2GXCK5loVJHCJRszpbb/XFMASdf
 l6+pA3jK1ChswV8DIabc2dto5arvaqzZtwLwFyAR8AZzVvsYNilhBg3bZphIeM7frTx2r8/j4Yw
 rYLE6K4piaoYTZ0R7iwkX+7yWFuw4O+aXSKCBZcPw1kqyAh5XJHvg29XndaKIVurDDZ7O2zB6XR
 Gh4tdTrcvHSfbHcewPyXfOglOAlei6N/dIBDjzH95o8b+SPI6kdx9Ho2GMjRFbebUzms5YzCiuu
 i2/2T2+khA5ZUlT/diX6lc+R4tukvq18jP9V9tqy+kGxlyhimeKrCYmr1q8J9zhMlO2j8O3gqk1
 yZQ7D79GC3fFZCaP/RH3ZnzUWrjzFEkPTqqReVgVDpAUUZcsCvTlYHmH75Xa9Ct+pkUn6EXU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxlogscore=670 clxscore=1015 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507200118

From the hangcheck handler, KMD checks a few registers in GX
domain to see if the GPU made any progress. But it cannot access
those registers when IFPC is enabled. Since HW based hang detection
is pretty decent, lets rely on it instead of these registers when
IFPC is enabled.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index e331cbdb117df6cfa8ae0e4c44a5aa91ba93f8eb..b3becb230a94163cccff4eaffb8eed44f1c29ad0 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2399,13 +2399,23 @@ static uint32_t a6xx_get_rptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 
 static bool a6xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 {
-	struct msm_cp_state cp_state = {
+	struct msm_cp_state cp_state;
+	bool progress;
+
+	/*
+	 * With IFPC, KMD doesn't know whether GX power domain is collapsed or not. So, we can't
+	 * blindly read the below registers in GX domain. Lets trust the hang detection in HW and
+	 * lie to the caller that there was progress.
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



Return-Path: <linux-kernel+bounces-738221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9088CB0B608
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 14:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BABDE1889F3A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 12:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF61221558;
	Sun, 20 Jul 2025 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CK15wmZj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26102206B1
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753013864; cv=none; b=kFKakAvb8fmaSO5UeZW8PuIvTCNNEJFjMUN3Rhaye0zecUIHSh236CDMP+MmZi3MG1FGI1KeH1lvXMW6vihCzOvDW526aTCr0a5ozZeydnE/ryWMAiFdLmAWu8TOyu6ET1QY66eocO291RUvCW/d0vfU198M/Y1OpNulzdk93fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753013864; c=relaxed/simple;
	bh=wqLkCf4B4+rAHo40MJEHOqWO43efxrMMyMYz8FlTqtg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sPcjObg+9F0VYdwiG9k4jxnc7WkHBFXWDD6SMJ5gCXgL1o++64AVtJZZoNT4SXd3bW+bmZz/muKn4IxYE+ToY+YkqIgloH7n2Q8e8VFP19mP/odrKVmXtDbMXlJbD0I5otnOXGRsCnlRkeF4yzdEiss2CKPoHLWYppDsWODOd7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CK15wmZj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KAMfLI016052
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sBmzzhW5Jj0p8WIW9/VlZBWqiN8JQGD2ZD52IVaRVEk=; b=CK15wmZjwLqVxFF+
	HUoGDkBx2r15Oxpj8YJuVlT5KgPd+CVdQnGrA3QlXxP75VuQoymPj7Hb0Qr6SgH9
	IAEZRMKDhNOWQau/kqrm06mIB4I61SsEBEAVjl3AQ3uq2oe047iyzR4+/ogMSI8S
	Oc8hDNwOYNFyR11olShvu9ilpL/auQ1VnO+p/J9bkQ0Eg9x15gwmh0j3W+X7Q3KH
	H+Ts4JuRVgKv4qUXKVQOaCM8YIdGA4BuxIz/LM/lpkjCYWKCQyw3EiaGji52jKiM
	s8Bfx2MLDsSJzUOYSXSZNOk1SEVOdsZtamAgRDk2IcrUt6lmr5vGGrePKSrhdh+9
	mMX+5A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804hmj41t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:17:41 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-74ad608d60aso2837781b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 05:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753013859; x=1753618659;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBmzzhW5Jj0p8WIW9/VlZBWqiN8JQGD2ZD52IVaRVEk=;
        b=WZnjfyfknqD0orW+2W13Bb7PRW6UDT1yzPt8qRlNXZlZGeHzLt6h0USxvN21MpikkZ
         v6C6V30G4GV4XVFF7AW6JoU5FGSN/u3jiHsX05E3ppinsjwWZOBsgiYyeYcvsZ3xygBh
         eaBK69aWihGnlyoo4x3ofeCxg6i+/sGeoBFYGDS//Y6GPLDs78+R5JhfIFzbdrtD5D1v
         Y8TeY49TUP8F3c/JfWTiD/4f6CZ1IfkKLN9LvAWo266N731TDs+3KmcD7oGkZ+2pV381
         bv5b4mAAz+kki4X4QfPnDScdJCPZJZsfte4Cgn2qpGC8/JN97ksZw3jAfk06HsF7Ttyj
         gD/g==
X-Forwarded-Encrypted: i=1; AJvYcCWjvQrM0MLxcyZyLqaAOybZZotGCnXDhnoqTT8EFe8FkYYmw0pQFIWx6HhQd6DAbwPLcQsiNHgVLjnkzo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzckMV/GCtYHdigDiYd0jX45gBbvGvpfVdTJfTUWsJJ+mfBHr01
	47tmv8eLzZcSyN0Ce0ZAkjmUTdYy3BQSspHApkq2FfkRlz3HaQN/b2NuoX14rkFONq+8ShxhdFE
	OBtwbO+9YBMnByZYA8jO+Iluq+leDpm9toFIwIy8ZZ0cbjSIQSlq56URyZ7zmXzllUrQ=
X-Gm-Gg: ASbGnctzL3rEbqsGmxjSNTzYaQfwQK6TEj1wTfFAgWDeLo5GL1r0pRZ5fq1qMwDDI7Q
	SYXHGnBX437yLZUVZXVrTnD8++5GdtCAQrMeSjO52/yC1DA6MKXfwu2K7FhPJasmqH6dUzdQ1sW
	rIBHCAiox+v2Me77nrV7x8bDwAMUSynHq3elYP7tya4D9m5hMpKh6+SfB8/q+nkqe+ilD4zm/o7
	XkK/1JD/n57nzXT8kjybwkfqPkn247bAvPXwvAfEzGvNpeHOqCAsIp0KKzQufUrWiZIh3cR4o4/
	qwF3gqFubKlkhSOAIBYsY7FWlFTtGrMCRlykAezGI2aNih8sK/JaK5+wRxnAd7jn
X-Received: by 2002:a05:6a00:1d82:b0:759:3013:8dfa with SMTP id d2e1a72fcca58-75930138e54mr15194857b3a.18.1753013858926;
        Sun, 20 Jul 2025 05:17:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHky5Ub717uk0wP0u9f8RtsuBSVWNnbbl9pWx4XoUOaKPKD1lY6iSnhVS3KCoxJyIWeda1fcw==
X-Received: by 2002:a05:6a00:1d82:b0:759:3013:8dfa with SMTP id d2e1a72fcca58-75930138e54mr15194831b3a.18.1753013858492;
        Sun, 20 Jul 2025 05:17:38 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb154755sm4097933b3a.69.2025.07.20.05.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 05:17:38 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 20 Jul 2025 17:46:13 +0530
Subject: [PATCH 12/17] drm/msm: Skip devfreq IDLE when possible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-ifpc-support-v1-12-9347aa5bcbd6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753013805; l=1263;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=wqLkCf4B4+rAHo40MJEHOqWO43efxrMMyMYz8FlTqtg=;
 b=57s3/rl0XfByZyUpDrauyiUmLfsidvykGjHJF25PhHK0hs0Hz0klsQf6cNk5NMPG4Gw8jnW4b
 RIB6TjQpayICXoNmtM+GNdsFQFkeP9cvdQ8ia7aHmoGMGigvy0nd2ix
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: rC7pMRmKCLp1ycsKLK3CcYzNYEASxiyu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDExOCBTYWx0ZWRfX2t9h9iCwFTaZ
 Dz7q7uB9jVyTT6t1a+49cv76ROhxkjVlgS5cyh+yELtlYeAeZcyco16YC1zl++EF1sOvEiC2ai6
 a/qm+o3WBodNG0bcIHx6+FbT00KkY89MX/juT+2XgcHPFrdM2DJRi0FPfi1c/om/zjmKl/7+7Li
 9+pOwtWTTv2ZVQQ58GtzEJWYyxGlzFoJKBQOhhPfYIO0UOgXbpag72Y57GdzrpokWBcx7B2vPGv
 daPHaKu97ncf35qp0uUl6RnI2QwuFgLrx6guP64K7NbFiZtt43qucAXsLUfWK4hCqGMCm6yXn9Y
 IrelC+sdSeW9DStMTBMhuOIqrfM3NhTqB8oTMAUZ0pss6NOgN8A5ja2GByBdO8GKrbQbJP3sV7r
 iz0Jb8WurHWfgqokvM3+f3IIUiM7ZtOn6/hAX15WLFei5ayGNXAPA7sH+POjhfsW/RBSMSY3
X-Authority-Analysis: v=2.4 cv=Navm13D4 c=1 sm=1 tr=0 ts=687cde65 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=_nbzAfXQmFRcFNHC6JoA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: rC7pMRmKCLp1ycsKLK3CcYzNYEASxiyu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 clxscore=1015 bulkscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507200118

When IFPC is supported, devfreq idling is redundant and adds
unnecessary pm suspend/wake latency. So skip it when IFPC is
supported.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gpu_devfreq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gpu_devfreq.c b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
index 2e1d5c3432728cde15d91f69da22bb915588fe86..53ef2add5047e7d6b6371af949cab36ce8409372 100644
--- a/drivers/gpu/drm/msm/msm_gpu_devfreq.c
+++ b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
@@ -4,6 +4,7 @@
  * Author: Rob Clark <robdclark@gmail.com>
  */
 
+#include "adreno/adreno_gpu.h"
 #include "msm_gpu.h"
 #include "msm_gpu_trace.h"
 
@@ -300,6 +301,8 @@ void msm_devfreq_active(struct msm_gpu *gpu)
 	if (!has_devfreq(gpu))
 		return;
 
+	if (to_adreno_gpu(gpu)->info->quirks & ADRENO_QUIRK_IFPC)
+		return;
 	/*
 	 * Cancel any pending transition to idle frequency:
 	 */
@@ -370,6 +373,9 @@ void msm_devfreq_idle(struct msm_gpu *gpu)
 	if (!has_devfreq(gpu))
 		return;
 
+	if (to_adreno_gpu(gpu)->info->quirks & ADRENO_QUIRK_IFPC)
+		return;
+
 	msm_hrtimer_queue_work(&df->idle_work, ms_to_ktime(1),
 			       HRTIMER_MODE_REL);
 }

-- 
2.50.1



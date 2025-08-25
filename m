Return-Path: <linux-kernel+bounces-784923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F4FB3438A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1AF7188320E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510D9303CB2;
	Mon, 25 Aug 2025 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pe2zFT1F"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63068303C85
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131554; cv=none; b=sBoa+YepbPeI1WMoIkhA3EAxYVgZ+pSl4e1qsQOQVIWDvqJ1QD3QpWVtEol7zhmr7avwM5Q1S3NByQW9btD/kZML9FEKqiW0p8ltWZzejVGTytbxNvMbJUIoTRhpWoMU55umSfq4I4Iifl4TLO1yXgC9yjv1Yc+nk+9lSpG0BzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131554; c=relaxed/simple;
	bh=8m/NmAVanmnv53nLnyrBMfNFZLTXWJekt8jy/qfdBFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BN1K8wsu+aK7w7nb8eBjHpNOC4gurRT/K91Lb1vrxuvmLn+x83F3VtuDPs9126NIKQBvzirteEp0igINo8sZgLoo0ffQwnoTJh/bGbBeyNXndR/c5WtVryHyKwUIzkzmgHF3Qj6jTI4dyuEV5MsU1M1QaZxTiJWhZNEzfHj7mbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pe2zFT1F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P895xs031245
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:19:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YmocC4ftyVaWVSgyoHNfTRGjizwe6D9zwARFQ5cI7Ho=; b=pe2zFT1FxGnv316U
	x/vKPLvcGuINyo3poA+wFMjeutaALnAlPilwcpB6vgFS1lPIGlquxi/k/GJ1uXiK
	LSp1Uhnp5dMRKjH6DkmmL3xHaVHSIGMK5YryFB+AfC6+A/qtpGF20xqaG56FaU8+
	TmQAYov2Lu46rQBe3zC4lqAglAZx1+Y686du93YO20Z4umjuVXUcDfZ4bwufjFt7
	wG9R6Ufqki8kR4eKDqI9W3y6iOqZK8N0IgSS+FVSvxdCd2tLAGh3N/sHo3z/2rGc
	UZsbEyLchC0X1I39+HOp7Ac77zEAeR9xhxDLUIR9FwcNmsA1sUa9Fb6yX4KPlEuG
	uSz+Wg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5w2nfj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:19:11 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e2eb6d2baso8845217b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756131550; x=1756736350;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmocC4ftyVaWVSgyoHNfTRGjizwe6D9zwARFQ5cI7Ho=;
        b=SjOPUW+ro8/eG6HhvfpSZf4c3o7q7SVAKHFsWvLjjzRc98U49DRugoKUrvLcDDpTQN
         /dtSMoZZ5RZFVFLrYi4oy4+gBux94f7STe7OQmsr+MNf9H21N38NBajRkejZBnfr1f/7
         sBzWosTTtY5blDWJtDy+MlXOcenmlKvOife774VlWcE4/skGUCIPkTTMYp6Mr0nQO6ir
         K9Qz2NTgf6u06swZqt+Xc/AAV18JYINlwxVcUA5/FePZq76K3GEadXFnWmtlg8fPoP3z
         F+saYFbKFnEvfliJgYTB8yR4zpkMC6plVlaBK4ny9FpfIVXioy43oMsDNnMUwh9wQwj3
         52xA==
X-Forwarded-Encrypted: i=1; AJvYcCX3llj49OA33cOJOLBwdJo+JRt3lrZRUOoqIuTuDGiTdMgC0EyeE9weAoyR/2wZC4rq2LBLiVq+ASDrlk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwATLS2qLzgNhwfa59PVw4J3oAbp6YxuluMLxj2liMw3H2QJIep
	cga6wYYrZr/34UhF+VsWVJ9YInOKNnR0tHyn00Yi/bzKV715PzaxTSGEchW1dlu4ELVFdxhO9wb
	iBByXWBijaQeq8cg/RZFHecgoINAwZ9eog448lLcU3g3t5E5+8ZBKZSpy0qBj7yFwUSY=
X-Gm-Gg: ASbGnctnyeFPPkdu7kCrTDS1rFOddUT2/2vjPLrvO6mJCEKEAUqdUB52pcWwdhSwOP0
	yOGZMxTsKf/S2OZL0dBFhfTMLKE2T4U7GrSMsw49QEVebiWXNryLyRwwLbtfHHwr7b1b1D1lR/l
	jPYcMaqxW7CmuqbgNSqBUtO0lI3LkA03rL+3BjLVFMi3HMlSc7Gz9j9u5qpjxexdWCuSm3IgBiw
	4JRWwCFTA9SVgaggH5tLMZj4NjsvcLLP/iqcZhwcsUbakXk6JiUGiEG9fq1zTbS2M/+9pzCeq9j
	loN3ZzFzZTAamy5dQC8WkUJ8FdFwb6o/oMnPOWPQz6kDZAEY5jr+O6rMW+sDvweEtsKN3q8=
X-Received: by 2002:a05:6a00:a17:b0:771:e8fd:a82a with SMTP id d2e1a72fcca58-771e8fdaaa5mr2803038b3a.23.1756131550526;
        Mon, 25 Aug 2025 07:19:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcDnzJ5RfYiEwv9A01WhZOmceWuXE7FYxb4e0UXQzViegEhpR06sENZJcy5WADZk5aDdU7VA==
X-Received: by 2002:a05:6a00:a17:b0:771:e8fd:a82a with SMTP id d2e1a72fcca58-771e8fdaaa5mr2802997b3a.23.1756131550028;
        Mon, 25 Aug 2025 07:19:10 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401eb20dsm7672339b3a.79.2025.08.25.07.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:19:09 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 22:16:15 +0800
Subject: [PATCH v3 29/38] drm/msm/dp: add MST atomic check to
 msm_atomic_check()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-msm-dp-mst-v3-29-01faacfcdedd@oss.qualcomm.com>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
In-Reply-To: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756131423; l=1376;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=8m/NmAVanmnv53nLnyrBMfNFZLTXWJekt8jy/qfdBFg=;
 b=u8gitSXMth4muAJp3+xoeK5RxUPyF1SywZCDE5hkinXcdd5++I3Vd2b6CfisCybuJNCaw3Sx+
 YU79iwt3eRbC9x0AI8+HP5lq7cTUavE7xpEFgbcoDFnLiqoiDewyvDz
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Authority-Analysis: v=2.4 cv=Z/vsHGRA c=1 sm=1 tr=0 ts=68ac70df cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=V2CHa5tHbzOdfKvFleIA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX3wjN2H6foLsb
 NoU7OCK436q3gYoOKmYG/xxNNNDRKRfzABt1GWk5by+PHG6xbZ7K0z1GjfD+Vz7Nu4z7ndLXxWX
 qcg1Mz5BBucQ+k8bZ/+TfpsiP/Efh/VSPcEDEHoi1kv9C4Nm633Xmpsxya/+a8oavd459Va7TKQ
 AHYcJnhvaWUl+NV1+9W8TL+q4Kjr4+bxjMWM9DAEeV+Hh5asNghCi0wK6QeM65tdYy7a1B+Ilgu
 9tIVGiZAsw8UTyhpBAvXZAfyKSMg8ihKbnZHqVMfIOKLjfGv+IQAauW+1JIcyEIPX8knsApEAZr
 vgfdxJuchJ1GiZSRQQw1uCGWOmW2yk2AB9fD2R47sHsCCr9I5R/qwhErapP+K1AjtXJh3v8zTpV
 Jt6182m+
X-Proofpoint-GUID: eVczGDAh-XdOQFw2rUg_hXcycnGxa9yt
X-Proofpoint-ORIG-GUID: eVczGDAh-XdOQFw2rUg_hXcycnGxa9yt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_07,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

Add a call to drm_dp_mst_atomic_check() within msm_atomic_check() to ensure
proper validation of atomic state changes related to DisplayPort
Multi-Stream Transport (MST).

This complements the existing drm_atomic_helper_check() and allows the MST
framework to perform its own consistency checks during atomic updates,
such as validating connector states and topology changes.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_atomic.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
index 87a91148a731dc911f30695add4c8f5002770220..3aa0020dec3a90b693ad3d4171cfcffc091aad4c 100644
--- a/drivers/gpu/drm/msm/msm_atomic.c
+++ b/drivers/gpu/drm/msm/msm_atomic.c
@@ -6,6 +6,7 @@
 
 #include <drm/drm_atomic_uapi.h>
 #include <drm/drm_vblank.h>
+#include <drm/display/drm_dp_mst_helper.h>
 
 #include "msm_atomic_trace.h"
 #include "msm_drv.h"
@@ -207,7 +208,11 @@ int msm_atomic_check(struct drm_device *dev, struct drm_atomic_state *state)
 	if (ret)
 		return ret;
 
-	return drm_atomic_helper_check(dev, state);
+	ret = drm_atomic_helper_check(dev, state);
+	if (ret)
+		return ret;
+
+	return drm_dp_mst_atomic_check(state);
 }
 
 void msm_atomic_commit_tail(struct drm_atomic_state *state)

-- 
2.34.1



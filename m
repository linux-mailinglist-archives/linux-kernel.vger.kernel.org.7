Return-Path: <linux-kernel+bounces-805318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35028B48715
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37991B22996
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D612A2EDD4A;
	Mon,  8 Sep 2025 08:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g7fO4S1h"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977092EC0BF
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757320067; cv=none; b=CiRHLR8Qh1Gyt7qBDMHjaEpmuI51suPALyPidASr2awfCLmjwkN0a87TyVm/hObXcod1TeXWxYrI3HvjueWI4Cdjx1XEHJ5Z0BUcnECauKGen+fLCWMSvWGvD1JZGhcYiqmmwKNTfw9ubAiP9IYpi8MPXzZRForKoLv/I7yJEig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757320067; c=relaxed/simple;
	bh=eXZ2rYau8RPQwm/75uAgTgpHfByWoOV2COXky3jbRmY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mvimzDAN8BT6FSAy3UKr+EX7K//TA2nzkKrEiuqFw4ykPXVdfY8vtJ3owNV1r6C4q0BZaH9mhQdffG6+7II6lg3bjbuqGq2NiavI19JxgFsvubPS4VhB8UbJ4QWyt/wv4pW7sS2jO1kG68oKk2VhfjUZ2Rve/zRz3sghxotqeks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g7fO4S1h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587M4knJ014127
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 08:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CJb7ofyHe4b7qn3VxGuLfEoQ37LPPZSsF0k+bZB0okM=; b=g7fO4S1hBkoOAA61
	u/VNyRsQ+q3qPIKQ9YGMPgfYs3KC98+PnA/MEvt51RYedctiZFW7k8Ntpa4C2Apd
	1IL5iRt4CJOlWuIjVNcFT8piCobIMtAp2eNY7AwGcOSQeUezdzoiuPgmOy9UAOVE
	aEB9hnJs75pOeTVKIy1FpHxDomzio9DKxDd1v7AZM7Ko/ymnWaRP66eS/2+KaAYY
	TqwLZrUOyCojwrJZFxXRahVE828sHB6//I5Az8tWGnB7/VPqAMEuf2HCHAGoqn0S
	tZ/OCaC3xJ8nf42lxlIZno9+aDGL1gqQCiDK2NExPdw9WToxL29AwYIo5ZuGHQ+x
	mxWJBQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490bws3v8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:27:44 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77243618babso4098010b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 01:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757320064; x=1757924864;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJb7ofyHe4b7qn3VxGuLfEoQ37LPPZSsF0k+bZB0okM=;
        b=CctaPCTRDo6OVJ/raLVUjGzzuKLEsdtUGwLs6Sq+71LyahQUvTMaKMhIBu7e+WWv4Q
         TVlIuRhK45YPOHkyMH2cKixiTj79hM6f22cUO6NNMnVE6JTYaaZ8iLImR3bKom4T4hjV
         0as1TMTlgWhpaXhnUPLg2hlBS0sZ464fiCPKYkUo05BWV+mUTYI5A/14yP7BaSr2fmDL
         4wE1ZB8KvQWRSVFyHGOW+6CGiXg56XW/+LTmhrkX4VymOaTCVZHSbhKU812aL3Min+Ma
         hPrP8iMbx0o94YXGmng1t3D+zB21cm+SO5zlCmrnUFpu+ocFDQDhTyD3/Lr8XJZ7f2NZ
         Z5HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWd488YUKg6W2LP4zQ8PvMkPNNsHTJZzA5u6y8YWWRLX44k7dUtNGWCjcVJwiA1NRqzQNtKpclf//NV2kE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMgQwYeGDfi8qTU+nza+fIlfe7IMNWEj9DdnHoIONc8LEOD1i/
	/ZSPuvECoDUj5P6l+g50WZo9GGwInY+xCXHD3YUkXw2pGR4mDDkmZHeU25U7/mR7+JtGPJf2BIr
	RFDBlkipO7Ja9Z29tD3zL/zjMVdK5zUq4uASdV83CKmNCfiNhW8BILGjCUScVw9foT08=
X-Gm-Gg: ASbGncu+MumcfyGvfxNIzoc3mbSTPVBPasCV8voys2Zi6PM86/hifJF7uumQehePjyj
	nJWTKZp/cDLpmMO3kWDXpNaM0Q3fpDGhRKYP2xLSoX+Si5a+xGpVZQKuyYlB0GdiVBUUUYoe7lV
	INQNtMfx3DVkmNN0mUUAe0oa1oU3vXgneT3JUST8ThiA/X1DNaIAP6GfxA5uLhOC1V9nMdmY7SP
	sJ4ULysWSZWoUbfwtJANwPCgHCRx2dQVKqB020DAJG6iYuO6PLxaYo7Vbt6w/Vc43aLEAyW5mK2
	5Kx/uKTWcVEJFhF8hxOXpdaumjlC2mTtrxxKc8uZwbMfIs5qLAWjAhUqo3E7xpLe
X-Received: by 2002:a05:6a00:3d48:b0:772:3ea3:3218 with SMTP id d2e1a72fcca58-7742de3a755mr9297816b3a.23.1757320064013;
        Mon, 08 Sep 2025 01:27:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8rtHApLprXs89baTrw5Y+tS4lxiZmePj06K6HadPj3deSzqDHtXN7z5VuOueh7Ev+7QbiFw==
X-Received: by 2002:a05:6a00:3d48:b0:772:3ea3:3218 with SMTP id d2e1a72fcca58-7742de3a755mr9297781b3a.23.1757320063559;
        Mon, 08 Sep 2025 01:27:43 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26bc9csm29157523b3a.18.2025.09.08.01.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:27:43 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 13:56:58 +0530
Subject: [PATCH v2 05/16] drm/msm: a6xx: Refactor a6xx_sptprac_enable()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-ifpc-support-v2-5-631b1080bf91@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757320036; l=2096;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=eXZ2rYau8RPQwm/75uAgTgpHfByWoOV2COXky3jbRmY=;
 b=8HEhpCUzuc7S9PJ7OQWqGbaucUWSpnfKaq9mOpMAJZ+dBfBnPhV4cF5kih6qpWasIOrwuw529
 VCWQyPoBSz2B0HDuxtCDQME4mh+8rpe3QODxD5ntDtT0ROeO3BBTMUJ
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: 47wqKERwFDIv6kEbq6mDEhT2A8VRYR_g
X-Proofpoint-GUID: 47wqKERwFDIv6kEbq6mDEhT2A8VRYR_g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX5X/fhS1jjT2U
 NSLTHwyENhShEhdKCyrVvZy35zaHmEDu9dKVvkK3wEWK40zrEEX3ZEJQW6sii0yeiZNXByB98mJ
 BbyCugXbpXX6dBK/VyZ50rpK6+HHksTCp8X/Q9j+6Q6M3Oud9aDidBlIvgzJzrupSjN5Lhf0kO0
 OzsKQgg+mitoAV4MUckX76e02ufjj0E3zhllMC7D4ePiyBLE3ShxB4zsoLKQAWJ1oHJxZiw2lV9
 +Jj6ViNgpVxNSUYecu5S9eOxLpWdV0OeUoEqSuS4QuHC+QZlLsUzXZAO2l+KZAdV1uPoL+OLNWL
 517E/MBbklNRiQNIASYmY6EQgTiN02d77qYA+EeIzLw99zMiBnuGfhS0hvtEISN1kV6e2SHCJyI
 vnJHz8Az
X-Authority-Analysis: v=2.4 cv=G4kcE8k5 c=1 sm=1 tr=0 ts=68be9380 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=B0W9oA28b3er_avpQGoA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_03,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

A minor refactor to combine the subroutines for legacy a6xx GMUs under
a single check. This helps to avoid an unnecessary check and return
early from the subroutine for majority of a6xx gpus.

Also, document an intermediate unknown low power state which is not
exposed by the GMU firmware.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 8 ++++----
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h | 3 +++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index ba593ccfe3c6a2f3a2ea0db3a1435d0668ed7bf2..18f5fc2c28e33d81ccc248216cc018300c81eb77 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -412,7 +412,10 @@ int a6xx_sptprac_enable(struct a6xx_gmu *gmu)
 	int ret;
 	u32 val;
 
-	if (!gmu->legacy)
+	WARN_ON(!gmu->legacy);
+
+	/* Nothing to do if GMU does the power management */
+	if (gmu->idle_level > GMU_IDLE_STATE_ACTIVE)
 		return 0;
 
 	gmu_write(gmu, REG_A6XX_GMU_GX_SPTPRAC_POWER_CONTROL, 0x778000);
@@ -936,10 +939,7 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsigned int state)
 		ret = a6xx_gmu_gfx_rail_on(gmu);
 		if (ret)
 			return ret;
-	}
 
-	/* Enable SPTP_PC if the CPU is responsible for it */
-	if (gmu->idle_level < GMU_IDLE_STATE_SPTP) {
 		ret = a6xx_sptprac_enable(gmu);
 		if (ret)
 			return ret;
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index 069a8c9474e8beb4ebe84d1609a8d38b44314125..9494bbed9a1ff86b19acec139d7ab27697d7ec8a 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -50,6 +50,9 @@ struct a6xx_bcm {
 /* The GMU does not do any idle state management */
 #define GMU_IDLE_STATE_ACTIVE 0
 
+/* Unknown power state. Not exposed by the firmware. For documentation purpose only */
+#define GMU_IDLE_STATE_RESERVED 1
+
 /* The GMU manages SPTP power collapse */
 #define GMU_IDLE_STATE_SPTP 2
 

-- 
2.50.1



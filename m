Return-Path: <linux-kernel+bounces-749543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 831CEB14FCC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADCB7177B04
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10BE28F520;
	Tue, 29 Jul 2025 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dFZ8g4AE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8AD288C84
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753801066; cv=none; b=D3xYpVvuT9sFgXXftxNgyIVn3G+YSxsZ2xeh01nzP46p8gU/LnmcaIggYOndXWd2twevLZAQcepdY8jhEtm+ILrn6E5qo5+uNo8Zpon6aPD3Ywpbz/PsLWAUPL5pOcuUM8iHGRYa7gSihPzv+4NBbKctQKmFC6YR2Nl8NSNQUv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753801066; c=relaxed/simple;
	bh=XjzBbwfbdEpy4W7vo1Z59g8aiB5UZLToq3ha1Cf9kVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RP5vxzsL+8qcN30o068l4DqPB6lMDD1Cd9jhEOVxOvlAkFkUghi1Z0YvXz9anknW2AMP0SYO+guQDkODo5mrT+UlcV/mwtqWr5Oi2Y2vrY82esJwEqz4RmMK+C5FZV352FJGYvgj3BdnX2+CjoT0cKLudz82BKZ6v9Ju90LBe1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dFZ8g4AE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T9Dkfp018302
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=V64f0Tb0OQD
	ZfJWk6fOVfLfxBrme2uWqEWKLnRNchS8=; b=dFZ8g4AEFk1NulFFVw51H0SG9Mi
	pGNu9HqxxGfjVLVqzcM7M2K8T0TEdjMUql0bGQ9cLBuQ2cbgt2D7uEeohWTjlatB
	lITjyboGAMT2LJRpuse182ZzQfwpC0NSzb6/6xDS9H21WGli79t4iYnrO/czGKCe
	sV+cGALA9w47dsy3YWyNMEt1pG/UJ7s8ErGZ22sW3OpE9Msf3SOBQ6C2PJnplnMo
	uzYqZkggKxRGwX+eXIHVTS1/qx+VqAgArShDEPQRMP9ReCpynddiVPlzs3e+AVP+
	tBmq9twwucgX1TK67+oozxTOqLSyMZQxYKXSKT7I4ooots5n6q2UZrgaTGw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pbm0ek1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:57:42 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24086faa5bcso2201395ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 07:57:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753801061; x=1754405861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V64f0Tb0OQDZfJWk6fOVfLfxBrme2uWqEWKLnRNchS8=;
        b=ljZuvpQ9IyRx8IV5O0IHzRaci4nKLvZ/Ep35krrdBUJcUClzZgv4c7A8bRXzBTKS6w
         MA/W5evcPtB/pjF4BI6sOQc1wUf/2mhZL8Z2oyo5XOvFGDjMVbL3xlby6rHUlFA+dvx/
         d9IjmG0LYDDjMCexq3Jn0SPJzbAIquKA9/jVNcDWsGORC+O4vhNEwgh/jDD2eoKi5Odl
         YYUOFv76edeAZq1Wp/AHcXgU2mMM6KlyjT5xiN7mlpe9U7TRxj7lawLjXQWM1TasF0CQ
         n7uLSFAav3leOZXob9dXCo/0KSUQAU066u99mRuQU6FAFozO/+h8eXQEH7cYZfjb/V7a
         Z0Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVqOfY2/dkSu7TuSGVk+MZcYyFOzTdzqVnEVli/bi50wys/MqsidyjJfYgcdPkRMABwzehhZKkNTmuhxKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPXnHa/2k/j/QCZESNnTP7fXgXlrhrCgKvs/z4ob3KMvBXTu/C
	4hCYRFsBFXkcJQSe8Q1Zo/NrvQ1PubbTbknmNQsuj8ep44ymrCbWB1Iqi250vd5QUb5pTN0F6Ur
	g1CzNCySU437Mb1hrOeEqCs5rxsvlTVGulve+dqHA0G4fpcQ4oRa/kdt4tsOyiiwS9Lw=
X-Gm-Gg: ASbGncttCgT4crSZ5aK97ZdgwUI6Vos14Sg+BuWLjHtCnedyYEUo+47icD7Wb6C2fpC
	u4JqeXiP7jXcPOgTqJ4KCgh5gHa+PAve2QyE8fP468LPhk0i3pAObb0dofDxWKC05yzxS6dZiqm
	x+TMbLGnJnWlSYJ9hKp0ptHG5U3nPTBqO/ypvK4gtJP14+cDv+V+w3So0uLRuYWCDSThOm3JyzH
	e1ovy/VU5THkUUvE4kJOf21YXi7oftUjYiCl0ZXc9Sl16e/fbklDINU2n2I6Rni41WMpTwgbFEP
	ruoHUw/caPIVXnhqu6UEkDunAueonwQi6B6x0CHMouEw6uyULkQ=
X-Received: by 2002:a17:903:1b2b:b0:234:cc7c:d2e2 with SMTP id d9443c01a7336-23fb3050848mr224991705ad.1.1753801061000;
        Tue, 29 Jul 2025 07:57:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ9hVBLh4j+kghAF/L46lgqX8VCMZ2DXnQbkvL0U172Ce+B6nS0S/3NES9fr+LT7g7KeWriw==
X-Received: by 2002:a17:903:1b2b:b0:234:cc7c:d2e2 with SMTP id d9443c01a7336-23fb3050848mr224990935ad.1.1753801060321;
        Tue, 29 Jul 2025 07:57:40 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f15be8545sm3688490a91.21.2025.07.29.07.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 07:57:40 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Connor Abbott <cwabbott0@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/7] drm/msm: Fix section names and sizes
Date: Tue, 29 Jul 2025 07:57:19 -0700
Message-ID: <20250729145729.10905-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250729145729.10905-1-robin.clark@oss.qualcomm.com>
References: <20250729145729.10905-1-robin.clark@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LsaSymdc c=1 sm=1 tr=0 ts=6888e166 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=EUspDBNiAAAA:8 a=BuD92i612R-MOt5tPB4A:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDExNCBTYWx0ZWRfX9RLxnptG6RWU
 GTq5RhirFX5hAGKGAMjhwAFeend1IFobEDe8HVIjLR2e8O8IRHVMAk3OmwYfCP1oaA1GgoiJY6Y
 0+UtD4fcgbAapqBXvIP31X/CKwjPwa7Y0LJYGVtjx1xwKA29qtAq1KCnjAio0bNdMGW8gfVoWsP
 n6CGxQwzdwHYAjkFBcy4itTZpqPnUDEalYu08x+zHEbHc9IF0Bn8L8u5urky4N+TdZP6zTwethg
 r5ycHf7Wtxboe1JYtDWazBV8ADD2ccG4zrEmbjnohTrzAFD1EYooRP/3pIIFg0ywQEBJknZyb81
 0ujDEDZ4yJF8U2OoGowZrG6j5D+9wZbLSZGC5ESXBuBHj8ZQA51kisKil5QrqvZc3pX4mGqQo3B
 /9/ozkBdS1/mAdlRJpmnoIpO5EF3EVJOrGsPFtdRV7wIsf1U7GOdNBQL/no7cKabup6czigD
X-Proofpoint-ORIG-GUID: u_O-OmiHH12dvUGNjGg9luqX9BbYNuuO
X-Proofpoint-GUID: u_O-OmiHH12dvUGNjGg9luqX9BbYNuuO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507290114

The section names randomly appended _DATA or _ADDR in many cases, and/or
didn't match the reg names.  Fix them so crashdec can properly resolve
the section names back to reg names.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h   | 38 +++++++++----------
 .../drm/msm/adreno/adreno_gen7_9_0_snapshot.h | 24 ++++++------
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
index 95d93ac6812a..1c18499b60bb 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
@@ -419,47 +419,47 @@ static const struct a6xx_indexed_registers a6xx_indexed_reglist[] = {
 		REG_A6XX_CP_SQE_STAT_DATA, 0x33, NULL },
 	{ "CP_DRAW_STATE", REG_A6XX_CP_DRAW_STATE_ADDR,
 		REG_A6XX_CP_DRAW_STATE_DATA, 0x100, NULL },
-	{ "CP_UCODE_DBG_DATA", REG_A6XX_CP_SQE_UCODE_DBG_ADDR,
+	{ "CP_SQE_UCODE_DBG", REG_A6XX_CP_SQE_UCODE_DBG_ADDR,
 		REG_A6XX_CP_SQE_UCODE_DBG_DATA, 0x8000, NULL },
-	{ "CP_ROQ", REG_A6XX_CP_ROQ_DBG_ADDR,
+	{ "CP_ROQ_DBG", REG_A6XX_CP_ROQ_DBG_ADDR,
 		REG_A6XX_CP_ROQ_DBG_DATA, 0, a6xx_get_cp_roq_size},
 };
 
 static const struct a6xx_indexed_registers a7xx_indexed_reglist[] = {
 	{ "CP_SQE_STAT", REG_A6XX_CP_SQE_STAT_ADDR,
-		REG_A6XX_CP_SQE_STAT_DATA, 0x33, NULL },
+		REG_A6XX_CP_SQE_STAT_DATA, 0x40, NULL },
 	{ "CP_DRAW_STATE", REG_A6XX_CP_DRAW_STATE_ADDR,
 		REG_A6XX_CP_DRAW_STATE_DATA, 0x100, NULL },
-	{ "CP_UCODE_DBG_DATA", REG_A6XX_CP_SQE_UCODE_DBG_ADDR,
+	{ "CP_SQE_UCODE_DBG", REG_A6XX_CP_SQE_UCODE_DBG_ADDR,
 		REG_A6XX_CP_SQE_UCODE_DBG_DATA, 0x8000, NULL },
-	{ "CP_BV_SQE_STAT_ADDR", REG_A7XX_CP_BV_SQE_STAT_ADDR,
-		REG_A7XX_CP_BV_SQE_STAT_DATA, 0x33, NULL },
-	{ "CP_BV_DRAW_STATE_ADDR", REG_A7XX_CP_BV_DRAW_STATE_ADDR,
+	{ "CP_BV_SQE_STAT", REG_A7XX_CP_BV_SQE_STAT_ADDR,
+		REG_A7XX_CP_BV_SQE_STAT_DATA, 0x40, NULL },
+	{ "CP_BV_DRAW_STATE", REG_A7XX_CP_BV_DRAW_STATE_ADDR,
 		REG_A7XX_CP_BV_DRAW_STATE_DATA, 0x100, NULL },
-	{ "CP_BV_SQE_UCODE_DBG_ADDR", REG_A7XX_CP_BV_SQE_UCODE_DBG_ADDR,
+	{ "CP_BV_SQE_UCODE_DBG", REG_A7XX_CP_BV_SQE_UCODE_DBG_ADDR,
 		REG_A7XX_CP_BV_SQE_UCODE_DBG_DATA, 0x8000, NULL },
-	{ "CP_SQE_AC_STAT_ADDR", REG_A7XX_CP_SQE_AC_STAT_ADDR,
-		REG_A7XX_CP_SQE_AC_STAT_DATA, 0x33, NULL },
-	{ "CP_LPAC_DRAW_STATE_ADDR", REG_A7XX_CP_LPAC_DRAW_STATE_ADDR,
+	{ "CP_SQE_AC_STAT", REG_A7XX_CP_SQE_AC_STAT_ADDR,
+		REG_A7XX_CP_SQE_AC_STAT_DATA, 0x40, NULL },
+	{ "CP_LPAC_DRAW_STATE", REG_A7XX_CP_LPAC_DRAW_STATE_ADDR,
 		REG_A7XX_CP_LPAC_DRAW_STATE_DATA, 0x100, NULL },
-	{ "CP_SQE_AC_UCODE_DBG_ADDR", REG_A7XX_CP_SQE_AC_UCODE_DBG_ADDR,
+	{ "CP_SQE_AC_UCODE_DBG", REG_A7XX_CP_SQE_AC_UCODE_DBG_ADDR,
 		REG_A7XX_CP_SQE_AC_UCODE_DBG_DATA, 0x8000, NULL },
-	{ "CP_LPAC_FIFO_DBG_ADDR", REG_A7XX_CP_LPAC_FIFO_DBG_ADDR,
+	{ "CP_LPAC_FIFO_DBG", REG_A7XX_CP_LPAC_FIFO_DBG_ADDR,
 		REG_A7XX_CP_LPAC_FIFO_DBG_DATA, 0x40, NULL },
-	{ "CP_ROQ", REG_A6XX_CP_ROQ_DBG_ADDR,
+	{ "CP_ROQ_DBG", REG_A6XX_CP_ROQ_DBG_ADDR,
 		REG_A6XX_CP_ROQ_DBG_DATA, 0, a7xx_get_cp_roq_size },
 };
 
 static const struct a6xx_indexed_registers a6xx_cp_mempool_indexed = {
-	"CP_MEMPOOL", REG_A6XX_CP_MEM_POOL_DBG_ADDR,
+	"CP_MEM_POOL_DBG", REG_A6XX_CP_MEM_POOL_DBG_ADDR,
 		REG_A6XX_CP_MEM_POOL_DBG_DATA, 0x2060, NULL,
 };
 
 static const struct a6xx_indexed_registers a7xx_cp_bv_mempool_indexed[] = {
-	{ "CP_MEMPOOL", REG_A6XX_CP_MEM_POOL_DBG_ADDR,
-		REG_A6XX_CP_MEM_POOL_DBG_DATA, 0x2100, NULL },
-	{ "CP_BV_MEMPOOL", REG_A7XX_CP_BV_MEM_POOL_DBG_ADDR,
-		REG_A7XX_CP_BV_MEM_POOL_DBG_DATA, 0x2100, NULL },
+	{ "CP_MEM_POOL_DBG", REG_A6XX_CP_MEM_POOL_DBG_ADDR,
+		REG_A6XX_CP_MEM_POOL_DBG_DATA, 0x2200, NULL },
+	{ "CP_BV_MEM_POOL_DBG", REG_A7XX_CP_BV_MEM_POOL_DBG_ADDR,
+		REG_A7XX_CP_BV_MEM_POOL_DBG_DATA, 0x2200, NULL },
 };
 
 #define DEBUGBUS(_id, _count) { .id = _id, .name = #_id, .count = _count }
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gen7_9_0_snapshot.h b/drivers/gpu/drm/msm/adreno/adreno_gen7_9_0_snapshot.h
index e02cabb39f19..fc62820c0a9d 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gen7_9_0_snapshot.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gen7_9_0_snapshot.h
@@ -1299,29 +1299,29 @@ static struct a6xx_indexed_registers gen7_9_0_cp_indexed_reg_list[] = {
 		REG_A6XX_CP_SQE_STAT_DATA, 0x00040},
 	{ "CP_DRAW_STATE", REG_A6XX_CP_DRAW_STATE_ADDR,
 		REG_A6XX_CP_DRAW_STATE_DATA, 0x00200},
-	{ "CP_ROQ", REG_A6XX_CP_ROQ_DBG_ADDR,
+	{ "CP_ROQ_DBG", REG_A6XX_CP_ROQ_DBG_ADDR,
 		REG_A6XX_CP_ROQ_DBG_DATA, 0x00800},
-	{ "CP_UCODE_DBG_DATA", REG_A6XX_CP_SQE_UCODE_DBG_ADDR,
+	{ "CP_UCODE_DBG", REG_A6XX_CP_SQE_UCODE_DBG_ADDR,
 		REG_A6XX_CP_SQE_UCODE_DBG_DATA, 0x08000},
-	{ "CP_BV_DRAW_STATE_ADDR", REG_A7XX_CP_BV_DRAW_STATE_ADDR,
+	{ "CP_BV_DRAW_STATE", REG_A7XX_CP_BV_DRAW_STATE_ADDR,
 		REG_A7XX_CP_BV_DRAW_STATE_DATA, 0x00200},
-	{ "CP_BV_ROQ_DBG_ADDR", REG_A7XX_CP_BV_ROQ_DBG_ADDR,
+	{ "CP_BV_ROQ_DBG", REG_A7XX_CP_BV_ROQ_DBG_ADDR,
 		REG_A7XX_CP_BV_ROQ_DBG_DATA, 0x00800},
-	{ "CP_BV_SQE_UCODE_DBG_ADDR", REG_A7XX_CP_BV_SQE_UCODE_DBG_ADDR,
+	{ "CP_BV_SQE_UCODE_DBG", REG_A7XX_CP_BV_SQE_UCODE_DBG_ADDR,
 		REG_A7XX_CP_BV_SQE_UCODE_DBG_DATA, 0x08000},
-	{ "CP_BV_SQE_STAT_ADDR", REG_A7XX_CP_BV_SQE_STAT_ADDR,
+	{ "CP_BV_SQE_STAT", REG_A7XX_CP_BV_SQE_STAT_ADDR,
 		REG_A7XX_CP_BV_SQE_STAT_DATA, 0x00040},
-	{ "CP_RESOURCE_TBL", REG_A7XX_CP_RESOURCE_TABLE_DBG_ADDR,
+	{ "CP_RESOURCE_TABLE_DBG", REG_A7XX_CP_RESOURCE_TABLE_DBG_ADDR,
 		REG_A7XX_CP_RESOURCE_TABLE_DBG_DATA, 0x04100},
-	{ "CP_LPAC_DRAW_STATE_ADDR", REG_A7XX_CP_LPAC_DRAW_STATE_ADDR,
+	{ "CP_LPAC_DRAW_STATE", REG_A7XX_CP_LPAC_DRAW_STATE_ADDR,
 		REG_A7XX_CP_LPAC_DRAW_STATE_DATA, 0x00200},
-	{ "CP_LPAC_ROQ", REG_A7XX_CP_LPAC_ROQ_DBG_ADDR,
+	{ "CP_LPAC_ROQ_DBG", REG_A7XX_CP_LPAC_ROQ_DBG_ADDR,
 		REG_A7XX_CP_LPAC_ROQ_DBG_DATA, 0x00200},
-	{ "CP_SQE_AC_UCODE_DBG_ADDR", REG_A7XX_CP_SQE_AC_UCODE_DBG_ADDR,
+	{ "CP_SQE_AC_UCODE_DBG", REG_A7XX_CP_SQE_AC_UCODE_DBG_ADDR,
 		REG_A7XX_CP_SQE_AC_UCODE_DBG_DATA, 0x08000},
-	{ "CP_SQE_AC_STAT_ADDR", REG_A7XX_CP_SQE_AC_STAT_ADDR,
+	{ "CP_SQE_AC_STAT", REG_A7XX_CP_SQE_AC_STAT_ADDR,
 		REG_A7XX_CP_SQE_AC_STAT_DATA, 0x00040},
-	{ "CP_LPAC_FIFO_DBG_ADDR", REG_A7XX_CP_LPAC_FIFO_DBG_ADDR,
+	{ "CP_LPAC_FIFO_DBG", REG_A7XX_CP_LPAC_FIFO_DBG_ADDR,
 		REG_A7XX_CP_LPAC_FIFO_DBG_DATA, 0x00040},
 	{ "CP_AQE_ROQ_0", REG_A7XX_CP_AQE_ROQ_DBG_ADDR_0,
 		REG_A7XX_CP_AQE_ROQ_DBG_DATA_0, 0x00100},
-- 
2.50.1



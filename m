Return-Path: <linux-kernel+bounces-753726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548A2B18709
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 20:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F8BE6284A2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 18:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4404328D8EE;
	Fri,  1 Aug 2025 18:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EityKLKB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66E328D821
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 18:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754071222; cv=none; b=FPOZ0eABTQqkn6ymo8Yex/Misi8mAETA7G6KNnnsn4V0LZMtNcej+o3bBaeHXyi50sdZ2k0fta6eI8h+AqBosxgR5GEqRRgBVXB3Y1YZz6V7xDcZV5MYcicRaKWf/Uj42Wp8Mm/mLT2a5IgbJz0GKwDHrfFxr5tg4iTFO82RILg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754071222; c=relaxed/simple;
	bh=jGJl8iqJGqZPa7n22eBdmzp5OM9OlGjVdL1VtHXWqRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlReQ3uhHpy5lmOTDkoP0HdQcmPI1LZDGHjGVI37Wq5SCeEB+HN0n+ryPI6QtkmtA9gcujUw/8FDK7Y0FCZXq0li9OQcBWFMaQwAJZe5d4r1BFNUAZz4NrVON5mIBFQHSlZjSL9Efwuq3kGNTIGzDgICLOEiev2AGgYfLoilUGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EityKLKB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571HfX1N028955
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 18:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=h5aGQowTyQm
	WxLOKsfUuwBsP1jaMp4P0qKNGjmBwUOc=; b=EityKLKBe0tOwLIqqVCUBnKMlba
	SvOGiDP8bgLrdJhaPskGjV0GeTETC5O8a/3NyHPS/eL7+mq8T5v4Tx9ji5xVkp//
	Egl5fv/JqDN7Co0ZSfjUqI1HuxtyxfhRs/J22x4Or9XeFuHzHNirnqjKL13H0LWG
	QJ5d+9t21Tg+XjSsg8DEViap7Z93fR0Jj3P0Q6Xekjb095Cm/aRbWThmhUU5xEoX
	puMND0i3T8uO/9cZDs/4/9kvKhKbP3IUoOwwQfq7GYXML1FBwNlq79hnSjvzB39f
	EXnH0f+erB4aC5WQXjbYk51ZTt9IAl8XIJA0eiMM20z6+79LBARWaVXruiw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q86d59v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 18:00:18 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2403e4c82ddso15736725ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 11:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754071218; x=1754676018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5aGQowTyQmWxLOKsfUuwBsP1jaMp4P0qKNGjmBwUOc=;
        b=LZ+6qelLVbAriY6cep/hWRNQibwfWnoXR2Hej4uG51lIO/vvVPgog8WkM0Gkob8+8V
         eTItucq8nVGaESg8IOnLr8506dXEvEFsAMLPsc1UG2NAZKSV62IIuVml67YPY4d8UOUc
         2V1uFQcdCRjNa1CzVa+4W7J0v7A+riuUEzvcy6Ag94/mtULlBWsgcTRIKe8/e5cssROp
         G8topVMurSP9URxuuKCqLuqOKsyaf6rkT8PSaA1XiIR7g2AJr35gBed6kfAd8NdG8+3l
         eHYEc0gEkvyULkPy9XPU1lT1Ojra8lTvL6JPJzYsimCWd7ZZHsd8taKSOvUTj45KHjAp
         71Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUh1y/QHg5D93UPX6jX2TDC84bPbeaNXPDsSeoR45ZGCdYWZnL4nXScklviE7ZGTPRDBXU2YA0BMWIPtQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS0MnZcJabyQbNToUp17iTaL9fsxQ7w6ADbQgsRXIz14ZELkfD
	kKes+pqc1h1zb8KeI1LWM2Q68kvReyAWa0gnqlCOiUyVi6m4Ne8Hv9MfqL7x7d6U5wJSWQjaB8e
	lSMa6iv6bEpjL4tixXCPdr6ICGC/bQTcEp2dv28U7CCoskqLJ9c34O8XcN89yf3i8OPQ=
X-Gm-Gg: ASbGnct0DlfvB5vrkBRhqiGcx8d7Q7XCRkKC6SoeFukFP13yNEfJbTsV+nCaCSxLAqt
	X+pnrCJ3IJ6CYgwoSzesblRcdDY0lERC4Wm7wW+PAEqOcZ9AU+hWSaW6Gq292mtyEaDnM9xxdUd
	7qFbJ89lfRPdLtdkwO3LAJrRmkmXUBPkLddKbzQc+ZZ5oQHRn0eBudByC73T8r4mWN7BDKwPCXD
	R5Ns78jEMSnv3bFPaLCvFVyzHlbyh7CSlxS+AmzKPCgNb6uTPIvYnwxPiLSImDUIeKHHgCNjOh3
	gXOwAKf//tnWeH6cak6510KObQH7QM+6wu5CbPX3lmwqnNomk7U=
X-Received: by 2002:a17:902:cec1:b0:240:86b2:aeb6 with SMTP id d9443c01a7336-24246ffbed1mr5044165ad.26.1754071217556;
        Fri, 01 Aug 2025 11:00:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbq3awaD9xvkRSNN2z/DDkqNEBB7r9FVhqVsVElrsfxoCKJuaBepuSzCBszOff9RXFmHzwmQ==
X-Received: by 2002:a17:902:cec1:b0:240:86b2:aeb6 with SMTP id d9443c01a7336-24246ffbed1mr5043565ad.26.1754071217014;
        Fri, 01 Aug 2025 11:00:17 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8977114sm48268935ad.102.2025.08.01.11.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 11:00:16 -0700 (PDT)
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
Subject: [PATCH v3 2/7] drm/msm: Fix section names and sizes
Date: Fri,  1 Aug 2025 10:59:59 -0700
Message-ID: <20250801180009.345662-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250801180009.345662-1-robin.clark@oss.qualcomm.com>
References: <20250801180009.345662-1-robin.clark@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDE0MSBTYWx0ZWRfX9cwTRv5Naa4k
 D4p3EREt4lmyQc6byME0edN8rVsR37DRNOv6A6F/ZSnmr+jLTrtHj6zBgF/TfQMW4XRZHx74uFh
 SmwKrkIEgjDQCXBs4+ORUfPy9p21a0OZqedQYM29TDti3y9huM/x6b4k4wRwUCEILaH8KRbtAwl
 MVRDPqP/a8P7JnBz0p7oe9LKq6ZBWo33K9Zu2li9Tkm4u0lUHmZbTU0U+iB9YyJsXZgLnxyJTNt
 klcUDbSTwFKuf05kpHZZKUTmgCRPOLTt435CNbrMhO9HPTiHf9AZF2e4wcWziR8ftG+DK34/hSZ
 CmDYhWr+r0U+d0kjHj/Hz6Y7ON4ck0ShZc47o8kDUMGGicdwuWsUsolSYQlumpENhcQjDHT6D6F
 9dH/npqQZjIvClTB5IA9vO4ZUJHcyGB/3Z2CPUpIDbmuOUCFKVVZA8Lbc2585nAL3PoSDmBe
X-Authority-Analysis: v=2.4 cv=TqLmhCXh c=1 sm=1 tr=0 ts=688d00b2 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=EUspDBNiAAAA:8 a=BuD92i612R-MOt5tPB4A:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: AsPrMnqM51W8fAU4w4G4ImbINVUvthkW
X-Proofpoint-GUID: AsPrMnqM51W8fAU4w4G4ImbINVUvthkW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_06,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508010141

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
index e02cabb39f19..b1f8bbf1d843 100644
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
+	{ "CP_SQE_UCODE_DBG", REG_A6XX_CP_SQE_UCODE_DBG_ADDR,
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



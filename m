Return-Path: <linux-kernel+bounces-784933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D933BB343B9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEEA02A0E65
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2FD308F2B;
	Mon, 25 Aug 2025 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cIlOjsgy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD68308F33
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131592; cv=none; b=tfiFe6NfPvzXBU396s5jJF4s3jrqk6bwWIvwe6dmFv97qufaYCvnKwYnoLbeecp44GvmN56h/UnjqmNF93yK3+v5DmEzjX/9DWR3l5CZAqxAPv0G9aR/NGWamA0iuVAKVd/a8IEc5muq01R/l1+ZpUYqlEJdRKovQ8z+lqga1tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131592; c=relaxed/simple;
	bh=oCUBHkG6GpdcXqsxM8KNCtZVQwnjIFL+vEG1AP/TG4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OGbzJBvFbiN6xR4xdIvNANDSEXXanfqqz6kJAScAXq1E6R5A5cFXfj+N2SaR468WYQAkUM8W5MgbEh2u+0ErwAmSMJrjJSl293oG/OKITF0NRSBzKmwj8kvbBtBcyV9JEpP7c+sbGY1ySiIYLdjRyUeCuYCN7mR1yW44g1m5eos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cIlOjsgy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8eS7r026226
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:19:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+jVSUKAsQPlwDM3u72L5IpcDx7MSfvV8k0RhLT9MO78=; b=cIlOjsgy0stORp13
	cMIr4V6yg1/MoiujKBG1ddiRRx5+xYE5duh2JB9t26bVmhCQxdwhUTqerYF7fpGN
	6FQplpc7YsSF1vce94Fj79eiH/x/Gh/uO55Km6tHl9PkFYmDVdEEBPrAA8qGMy93
	6xJMKVsyIM82LaFsL5pYk07NghQIoWIhWgroBI0fo3stsMLZq9vDwyRnjrvc1Bj0
	uJdL5gqP0+LTzvV74dd5pMmy5HKcqDUAHzqoaH8Ajhu5dJwn3L7tpW0kUrAsjhgy
	GIBxSYptfir27eh2pR4gU9XjkRCS5OdBHWUHLD2c8rHHdUAVwuehw97+Z81rNwfV
	6sLcIw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6x85bn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:19:45 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-771e43775c8so671851b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756131584; x=1756736384;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+jVSUKAsQPlwDM3u72L5IpcDx7MSfvV8k0RhLT9MO78=;
        b=NjE761CcR2FYjhrQ49k//21D87Ogbx248w6IKAINjZa36UlHqAHyqFFwT6vvaMuaiK
         6chpcjtjg/h7HIJVqtDCUsBwU1uaYkgrIX8HgEL08IJ3pfZrvRyh4XX25Vt9c958+XGr
         +db9xEMHFmSsO2CWBrQwE98DqmM/Dkw/ORHUN4GQBcQX1dajNj6VMYwI+hv9q929tWkh
         dMVOBIrfMgY+Ybn55b4jCzdFLXlZ31VQ78+NkxcFvPY55evhD++n0w5BWNkCdyWrJ2oQ
         erWp9PkoCTECxFmd6Pja3+zP2RqnkvRvxm1vzMsSXt6nycAIPo/t4Q8wzO3J9P5aogv5
         HjZw==
X-Forwarded-Encrypted: i=1; AJvYcCXr5sUsuBuXrpBB6OW/AfPeeaoUnbWb+QJ5QeDcC8N/7Bf2n474HIjWHNT8l2FenIWvWzgjslfubWoUUZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhWT/bWbHsGAA3TrLFI19wOAx6RBgWtBrU9YDRDoFfK+QCIwrr
	vhIKlQZyxOHxmHogVprnNqS+elHJVqySjniD72ucvQjCOwEIXRQaUP/TPYQKx3Se9lW4bvDYLwV
	20YGB/30KUW5DV/XIf7cOlxi1UzB8DyCi7EljiMllw2MGCaT0v+DW61OEmA5QQqZz5UQ=
X-Gm-Gg: ASbGncszh585mxGKXDsnh8aEFfd4eDtyafajhBGeYCCYFAC0kAxcFCXaBDYRtApJqbs
	sxZln0KH7B22Vt/gpDnOfp5yriWMvaaYafLqdeyr/utXN+bFgIsbzMPtUC1faq2f/hsjhN3o6h1
	rrahG6qEyZQmLDWrkzwHkrWzZEa8YtdBAtB5qqsHwLJW9mZt7KsZKWixQiawXZtucsQUskkVZMA
	uCkRhVC18iDNDCUNuwghgGcEJ3QUtOgbDFZByXE/ejoEPi0ADPk+cvG5BH7O2sJhuqtQRpNs1uC
	hnbB7XhY6sR2ilQ6z5Vfzed5rDfHNzNjQXqTF/UxbsgtaM5mpVuj1OD4uvvd2QYW8AfdxHY=
X-Received: by 2002:a05:6a00:22d3:b0:771:ebf1:5e43 with SMTP id d2e1a72fcca58-771ebf167e9mr2327036b3a.8.1756131584179;
        Mon, 25 Aug 2025 07:19:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe0YeC0P+4yC3N9AqqpH6lpU7B9stvJ/fZZOCIPAjAFRvUMYvzfHo9d1n1TKTLxwYU2PlooQ==
X-Received: by 2002:a05:6a00:22d3:b0:771:ebf1:5e43 with SMTP id d2e1a72fcca58-771ebf167e9mr2327002b3a.8.1756131583615;
        Mon, 25 Aug 2025 07:19:43 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401eb20dsm7672339b3a.79.2025.08.25.07.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:19:43 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 22:16:23 +0800
Subject: [PATCH v3 37/38] drm/msm/dp: fix the intf_type of MST interfaces
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-msm-dp-mst-v3-37-01faacfcdedd@oss.qualcomm.com>
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
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756131425; l=5326;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=+Hotjobwxn+plNyiLv9VlefYm+B1NrsXftE9mGji/Lg=;
 b=JbQJxplIOcDHZ0JmbYy/iZFMTiBfTUSofsps0wDjfQJg8eNPyTt0NnzvDfdNie2Xv99iSPYrZ
 nMia26c0WmzCZHuZ1DfLEKOJnwqj97/VWBYwvNeyEKC8FLyajce/9Jz
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Proofpoint-ORIG-GUID: KRHh-LU1-SiN031VM3R9rHlCU_9tnnAJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA0NCBTYWx0ZWRfX8jNy/8OPy4Qt
 sC6EQUW9UVFWPZ2yP67HhdnsPCyh8b9d26x9Ejq8AMchCYt/Z4WtVltcnjZ+p6hjvBfaF/xDQuA
 VGm987sJvg+MRIzc+4FAM4rTmhqJONXlZWFO/ID6CajYBHHeU9ugCAtl5RAI1RUjcIPjQUZdGvb
 OaZFO+Y9ZOLVsAjHB7SZpSzMk47PS7v5jrjK0dRGgUch0M938xFuAIH+HuMPTX0XSSuji9KULEG
 0YMmk+sZqOvnyPTScgPwagsB1E7fwzZYJcU6cSSNJubPXe6newOAomIKB30inlorsjCOM+A52dO
 awFYTdFC0H+BicLAnrTh3CjGk2NgQAeyev7pw4bQHGL/bcqeP9oga8n1wCxNaCB+bemIm7XQxmG
 xPnfnWK3
X-Proofpoint-GUID: KRHh-LU1-SiN031VM3R9rHlCU_9tnnAJ
X-Authority-Analysis: v=2.4 cv=Ep/SrTcA c=1 sm=1 tr=0 ts=68ac7101 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=LQ6fVd0KmpP54VAw49oA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230044

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

Interface type of MST interfaces is currently INTF_NONE. Update this to
INTF_DP. And correct the intf_6 intr_underrun/intr_vsync index for
dpu_8_4_sa8775p.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h |  6 +++---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h  | 12 ++++++------
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h |  6 +++---
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h
index 303d33dc7783ac91a496fa0a19860564ad0b6d5d..ea2329f0b5e977bb0ee3035ec1b3a3e23bbe5b1e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h
@@ -319,7 +319,7 @@ static const struct dpu_intf_cfg sc8280xp_intf[] = {
 	}, {
 		.name = "intf_3", .id = INTF_3,
 		.base = 0x37000, .len = 0x280,
-		.type = INTF_NONE,
+		.type = INTF_DP,
 		.controller_id = MSM_DP_CONTROLLER_0,
 		.prog_fetch_lines_worst_case = 24,
 		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 30),
@@ -351,7 +351,7 @@ static const struct dpu_intf_cfg sc8280xp_intf[] = {
 	}, {
 		.name = "intf_7", .id = INTF_7,
 		.base = 0x3b000, .len = 0x280,
-		.type = INTF_NONE,
+		.type = INTF_DP,
 		.controller_id = MSM_DP_CONTROLLER_2,
 		.prog_fetch_lines_worst_case = 24,
 		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 18),
@@ -359,7 +359,7 @@ static const struct dpu_intf_cfg sc8280xp_intf[] = {
 	}, {
 		.name = "intf_8", .id = INTF_8,
 		.base = 0x3c000, .len = 0x280,
-		.type = INTF_NONE,
+		.type = INTF_DP,
 		.controller_id = MSM_DP_CONTROLLER_1,
 		.prog_fetch_lines_worst_case = 24,
 		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 12),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h
index 0f7b4a224e4c971f482c3778c92e8c170b44223f..00fd0c8cc115a4a108363f6185edf93e771b2bf5 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h
@@ -347,7 +347,7 @@ static const struct dpu_intf_cfg sa8775p_intf[] = {
 	}, {
 		.name = "intf_3", .id = INTF_3,
 		.base = 0x37000, .len = 0x280,
-		.type = INTF_NONE,
+		.type = INTF_DP,
 		.controller_id = MSM_DP_CONTROLLER_0,	/* pair with intf_0 for DP MST */
 		.prog_fetch_lines_worst_case = 24,
 		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 30),
@@ -363,15 +363,15 @@ static const struct dpu_intf_cfg sa8775p_intf[] = {
 	}, {
 		.name = "intf_6", .id = INTF_6,
 		.base = 0x3A000, .len = 0x280,
-		.type = INTF_NONE,
+		.type = INTF_DP,
 		.controller_id = MSM_DP_CONTROLLER_0,	/* pair with intf_0 for DP MST */
 		.prog_fetch_lines_worst_case = 24,
-		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 17),
-		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 16),
+		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 16),
+		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 17),
 	}, {
 		.name = "intf_7", .id = INTF_7,
 		.base = 0x3b000, .len = 0x280,
-		.type = INTF_NONE,
+		.type = INTF_DP,
 		.controller_id = MSM_DP_CONTROLLER_0,	/* pair with intf_0 for DP MST */
 		.prog_fetch_lines_worst_case = 24,
 		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 18),
@@ -379,7 +379,7 @@ static const struct dpu_intf_cfg sa8775p_intf[] = {
 	}, {
 		.name = "intf_8", .id = INTF_8,
 		.base = 0x3c000, .len = 0x280,
-		.type = INTF_NONE,
+		.type = INTF_DP,
 		.controller_id = MSM_DP_CONTROLLER_1,	/* pair with intf_4 for DP MST */
 		.prog_fetch_lines_worst_case = 24,
 		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 12),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h
index 7243eebb85f36f2a8ae848f2c95d21b0bc3bebef..826f65adb18b118cf8b70208837aa7979c5701b6 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h
@@ -335,7 +335,7 @@ static const struct dpu_intf_cfg x1e80100_intf[] = {
 	}, {
 		.name = "intf_3", .id = INTF_3,
 		.base = 0x37000, .len = 0x280,
-		.type = INTF_NONE,
+		.type = INTF_DP,
 		.controller_id = MSM_DP_CONTROLLER_0,	/* pair with intf_0 for DP MST */
 		.prog_fetch_lines_worst_case = 24,
 		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 30),
@@ -367,7 +367,7 @@ static const struct dpu_intf_cfg x1e80100_intf[] = {
 	}, {
 		.name = "intf_7", .id = INTF_7,
 		.base = 0x3b000, .len = 0x280,
-		.type = INTF_NONE,
+		.type = INTF_DP,
 		.controller_id = MSM_DP_CONTROLLER_2,	/* pair with intf_6 for DP MST */
 		.prog_fetch_lines_worst_case = 24,
 		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 18),
@@ -375,7 +375,7 @@ static const struct dpu_intf_cfg x1e80100_intf[] = {
 	}, {
 		.name = "intf_8", .id = INTF_8,
 		.base = 0x3c000, .len = 0x280,
-		.type = INTF_NONE,
+		.type = INTF_DP,
 		.controller_id = MSM_DP_CONTROLLER_1,	/* pair with intf_4 for DP MST */
 		.prog_fetch_lines_worst_case = 24,
 		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 12),

-- 
2.34.1



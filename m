Return-Path: <linux-kernel+bounces-893690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A00C48110
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C269B1882F71
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4337329C57;
	Mon, 10 Nov 2025 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IFVzynHl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HriEUtbC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBF7329384
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792724; cv=none; b=pdbDHt22xKk4vyBxENJsutffCaNu6+cCITh6ZunatcQOL/q0I2iK8H393gaAzVvH2QcaQ2lByd90ht+HFpIc4QoXTzzU8181b3TxkJ7Jr2OSCHKPilCAFjPkdvs/HnO+FxoKBSgSBInujkv93c+sqg+aJi5DHlJDai8W+8VHQGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792724; c=relaxed/simple;
	bh=SpYPI0Dwwc05293klD0NCzpYJPQgyGdGUUEDRA+kgpo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jQREF0siO2+yYdhvkN+mgwuAKRMi1s9cutK5Onb/jJdWyuOQhLMFUqPveu/5iN9qD3HOF46LpCAEIKY7Wq5hVZ1yLGJTNQa/OucE6wzYFLK4XzTRHbMHwVByyb9Tfj026QuhkoIGHwKyqxXag0GKf2OZ2oVg2L5Z1VJcDjzgd00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IFVzynHl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HriEUtbC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AAGRgn92992485
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:38:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kqWzdHtLoSmSQ6c0tUp8mHto9/TmfMwNT7KQvhP7HUY=; b=IFVzynHlJh5eKUpt
	vp/AObknorlijD1QCapu+T6Yp76FHLHmjT2bhy46ViLm0DZhGTM6WNbO4qVIwnEn
	bNj6KvspKG2/Wu7OOM8OoDtgyy6ZvnB6Bb2jpnYX09I9BSxUFFPYx8Qpc96c7qMa
	3nKvFkj4JYNFkCNi46vvJc0OISyFpTZgJ0TERLDAp3sUn2mdBf1b01im0iYSowVK
	DDkOWqYDPTG0/Agucg/evTQayNbayFnSrkvPAZjKLZIHYl3pebZekGipUCcFxszK
	E90CksT9wMcYJMJsFiSoEj4kk33afgUCQ0RxbOWmqCrpJtcExzed1kF1XD3Z9+E0
	SWN+Xw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abd88sar9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:38:41 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3439fe6229aso1551565a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762792721; x=1763397521; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kqWzdHtLoSmSQ6c0tUp8mHto9/TmfMwNT7KQvhP7HUY=;
        b=HriEUtbCJ5BtfSi80b39MV4wVJ9wVdHq/Y8FjHRP+XtTGnxyd44pv9rSzVLR4kLAoe
         fNOjiwoId0Y9Iimkj4KOOkI+g1l2ZhX6klQHQi1fXEZmHkPsu5wddIo5R92/fnXJURKr
         qeWOjQmW/SVCtXZJ7C1e2CDz5jz/ohBdPShkYe66PPnycMdjtoNVpujgNx4M/CzOErEe
         9oxPZ9KAzlJbaoNy70wXBWaZwgOI4/hfJd2DPr+KEoYvD6N220JbcHVLtWxWxrVBBRmO
         CX5zmAt7m1/8c9aeWhs5OzBQdvrqRIiFM3myTjmx9hAUT5yDyGTxWqTfO8fAluhpCc93
         bYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792721; x=1763397521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kqWzdHtLoSmSQ6c0tUp8mHto9/TmfMwNT7KQvhP7HUY=;
        b=o2/F4vZI7XAJ8DRau2pIh7B1u2n/bsNTiAUYHz0vMvinPfMjIfkzeyd525X15NZPkX
         sILBq11sWympVOK46xBFyfFjN7GvZ6d1v8uDLBWCYzjxbKRGn6wx5y54c8ZSBjBsj6DO
         XN2tWw8zUpGHre4d2DbgW9Ab4UU59st42szuo1hX2gXfUHPcT6eqQvg8YQXbgsOMupfR
         Px6Kw+6AImWrce97sQuAJ4I/7KPdaGPbntkwddgfTgJEZXwg+ov8ipEG1vm1IXQASVxx
         DbkW097TXTKjm5yCj8WQ44Qz4i8RyIh+IZyvP2+sJTNO1JY6uHkV8m3PeENJ0qH9chQ7
         u/nQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+AZs0oPFBA4rLhL5C77Sw9G+qjg162evSJh7eJTePyEHQZ8gvpo+sb/KeZS2/JXVfT6mwxKfUapfX8C4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb1WKxNTaVZFfybDh/fPGZeRDVwriDQshL9j3hIYXdZ/02X7U1
	zQYgYbNY8+g8HLFmFa3Jppo6hLrYtP9qQRjEh86lDejnPBRJtnU2zNn9J68EhNG40yRcVnGJ6IE
	+i2pQtUB2GcVjpkRamxP/HgSevAM3uFk+F7cW9QQqbYDBTlCEp/Qpu4pCFiloUqqS7c0=
X-Gm-Gg: ASbGncs9efSgzezsTf7KMlLEvSh//Kd4GPlsTt2zi7WxWhgQxICQKICQc9X41gfrQLc
	5NceitQkvuEkP2B2gv+T9Ygbr3YSRskgpdDM5LVq5Th9sXWaQM6p52CjPYU0p9FesUkdZjHW+O8
	6Nw0hX0yGcAxLk1aVsEdcvR0Xi9OuUduhYnmblWIY/28rarPAQT+pfynpZuvc7m/Zy/JhSpPBTi
	FK73RPU0RyyMrBrL7kvWCraQczasTc5u67fdwjTAOBkaakBkJYurSjcSloq2o/4ohBPEPbstCyP
	aapmxx3NV//85vugcLPWSuHWNlDhojsSR+OIBHX2rUjVnk74bjQdl5ZqhCbcxyfZQnrJgGL2K0S
	IucMGvvON/+wXvl/0zk2eY18=
X-Received: by 2002:a17:90a:da8c:b0:340:9d78:59 with SMTP id 98e67ed59e1d1-343befa5329mr27626a91.3.1762792720794;
        Mon, 10 Nov 2025 08:38:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFa+U0rNARWTCaF7lT0o/+MjPISBIEKRbY/WloUig3k1nekUFejy3Fa2ZzeHzIccBq6UKyi0w==
X-Received: by 2002:a17:90a:da8c:b0:340:9d78:59 with SMTP id 98e67ed59e1d1-343befa5329mr27560a91.3.1762792720235;
        Mon, 10 Nov 2025 08:38:40 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c337b20sm11468922a91.13.2025.11.10.08.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:38:39 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 22:07:10 +0530
Subject: [PATCH v2 04/21] drm/msm/adreno: Create
 adreno_func->submit_flush()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-kaana-gpu-support-v2-4-bef18acd5e94@oss.qualcomm.com>
References: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
In-Reply-To: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Connor Abbott <cwabbott0@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762792679; l=2550;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=SpYPI0Dwwc05293klD0NCzpYJPQgyGdGUUEDRA+kgpo=;
 b=iljtrUe9v0tW0jYWcmnPgbIA1ijJ1IP3iqFE5kXmMTtN9/lE1waAYHqHOrPWj1SCMCrqoTurw
 LUilb1BA64mCClDRQ7wVSRi9QxYoF7J+ZjuTcEWO4spE9icQT8LZMnC
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: cmjbwVMZnFPR-xeYsuiLMaHsE_72eu37
X-Authority-Analysis: v=2.4 cv=PL4COPqC c=1 sm=1 tr=0 ts=69121511 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=geZ1VMdEqvdXz0YL0KoA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE0MCBTYWx0ZWRfXyd26ImJZEjxT
 aVmVlhIpdbrXBSUjIsd51C+VITjGkORgsz7gdTBFnpSlhoVj6apEs0SUFytlP1IeWPATBalBMrv
 tGzsTSW1Fwd79AhaSgwzRnHXbUy+TbpijC1gUgFBvhJvh9kvO5MN57cDUjDqBXERnFha3O/qQft
 RGirryYzQzSluluzQnkf1euVbvywF4BUZugAo430O1/vynjrlYJAqySq5GcLulsXYzwd6zyUgTx
 hh7RhZvw3ptOEarZlLn8R8HD3RfyworqFQKh9Jizw4NRRjhKZOhjiLGWQrLnkUYNG5H8UShSERZ
 6qxyWpRubGkXxgLi0hDmaaunWJwkDgo9KFHBzidvqBY0l5ro0XGCJVHgajIC5jQ2bVV3i61t/J+
 1Zv2ZWmC1+9wWUJ1ahuyXuxv2yXJ8Q==
X-Proofpoint-ORIG-GUID: cmjbwVMZnFPR-xeYsuiLMaHsE_72eu37
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100140

To dynamically decide the right flush routine, convert a6xx_flush to an
adreno_func op. This will help us to reuse a7xx_submit() along with
a8xx_flush op.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 7 +++++--
 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 6f7ed07670b1..b675a512e7ca 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -397,7 +397,7 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 
 	trace_msm_gpu_submit_flush(submit, read_gmu_ao_counter(a6xx_gpu));
 
-	a6xx_flush(gpu, ring);
+	adreno_gpu->funcs->submit_flush(gpu, ring);
 }
 
 static void a6xx_emit_set_pseudo_reg(struct msm_ringbuffer *ring,
@@ -597,7 +597,7 @@ static void a7xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 
 	trace_msm_gpu_submit_flush(submit, read_gmu_ao_counter(a6xx_gpu));
 
-	a6xx_flush(gpu, ring);
+	adreno_gpu->funcs->submit_flush(gpu, ring);
 
 	/* Check to see if we need to start preemption */
 	a6xx_preempt_trigger(gpu);
@@ -2563,6 +2563,7 @@ static const struct adreno_gpu_funcs funcs = {
 		.sysprof_setup = a6xx_gmu_sysprof_setup,
 	},
 	.get_timestamp = a6xx_gmu_get_timestamp,
+	.submit_flush = a6xx_flush,
 };
 
 static const struct adreno_gpu_funcs funcs_gmuwrapper = {
@@ -2592,6 +2593,7 @@ static const struct adreno_gpu_funcs funcs_gmuwrapper = {
 		.progress = a6xx_progress,
 	},
 	.get_timestamp = a6xx_get_timestamp,
+	.submit_flush = a6xx_flush,
 };
 
 static const struct adreno_gpu_funcs funcs_a7xx = {
@@ -2624,6 +2626,7 @@ static const struct adreno_gpu_funcs funcs_a7xx = {
 		.sysprof_setup = a6xx_gmu_sysprof_setup,
 	},
 	.get_timestamp = a6xx_gmu_get_timestamp,
+	.submit_flush = a6xx_flush,
 };
 
 struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 390fa6720d9b..77b1c73ff894 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -74,6 +74,7 @@ enum adreno_family {
 struct adreno_gpu_funcs {
 	struct msm_gpu_funcs base;
 	int (*get_timestamp)(struct msm_gpu *gpu, uint64_t *value);
+	void (*submit_flush)(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 };
 
 struct adreno_reglist {

-- 
2.51.0



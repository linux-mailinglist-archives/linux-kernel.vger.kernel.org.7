Return-Path: <linux-kernel+bounces-738215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F8EB0B5FE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 14:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C5BD7AD1D0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 12:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F941E3775;
	Sun, 20 Jul 2025 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o1lNwsmu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF3A20E702
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753013839; cv=none; b=UXB7kjoPdncGqvo52qN1uijWMtQc6UonwSeuf7Y20H36/1wMDkIavpWSZ23Um8+lNCX1sLG/iP2yKee6gRhTsZn7tEhB4A/iLeO9ERgKhOpQ0D99/oTTFR42FMRUn+aGK6SngKRVa/Mb1SLwerEJhrYJcqF8YESRmHiyLS9qaqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753013839; c=relaxed/simple;
	bh=Bix42dg0qNYgpzOcauSDsSEviuQA7o0gZ10lc64yFRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O3qUigsGdqlmt/u/EIkyWRuTM2+oeAmC4F2b0L4rnOKEid3bwRriaOYUqgW1G08yZOr2+po8chekvx/gEQDxcY+XgqQuMzvYCJBA4ztxhGcExt0aEwCkxUz0m2Q7XPL6xcZybWIStj1Lp0P/kOQDWcqTA7vp/hvEV3Nwnv7at7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o1lNwsmu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56K8QgJo019442
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dR6sJoRx42AUBHrEb7MmdRjO9rtN5rgEN4p3npPlmaw=; b=o1lNwsmubhRzA/MS
	hLpfMpaha9gGnARu5/Cv1lRhRzNcttZd6Ik6Bn/kWu3M6Z0AUOG5VFUqbc3c0qUA
	A+rw9X/j1xSQyPk/EJsuKd5bBCuK6tum5yE7l4XSNKXKY7dAFpsrGwnEbiuihZ64
	XzpW8FrCD9Ys5vrn682IM3qIkeskpQYLVFBqMTHzcJbQOqI21s8xARLalmo/jPCu
	fqii/qScMLpBrPFT7MA+C8PncqWcFuAi2hjwMs/y/bkoZ4Gm85RL6EPYN8oSpSpK
	I+1ZfnkdvxI/xq4kOrgUABR+urkbj31XwrodsN/u1x1AAV5ZuL1GSy3ebMUNRWSn
	8RuHTg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48045vt5ay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:17:15 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-74b4d2f67d5so3050548b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 05:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753013835; x=1753618635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dR6sJoRx42AUBHrEb7MmdRjO9rtN5rgEN4p3npPlmaw=;
        b=k6WkPoFmXTmcfpzYhj9FqfPndX7ez99rz7fkvkOPc9Q+yhQztJ8eeeSRg5mGSE2POf
         ufhkxjFcIZEE9NQKLyN4exII7t53ZKqIOXYc6ZNx69ELqdGw/nhfO7zAGVAP5QEp9Pht
         uWt7P83OPqcezWOgTy5HA6IbH9RFe4fx3jpFHBJyr3eCIpTvYDLa3hMf3UVw9VDPF47o
         aNvLMOTvEtbYqwYP0IL5se4uhMMYrKthGEv35teC9TaGCv57Lx5A6y65foV11ZWNb0zm
         dZ5h16WlBnOto1dftYiUTBImRl1irDR17AsNBn6cc/QrtqalYGqaU+So48lt18/9ErPJ
         mmSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrnP++yXTbEGBaiiRju+uQODzhhYWHa+7P/XSYKD7SVpdYXdVmqQxi18L3RPwRbcR95FcAU91KIwioBeU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqaz+OJMzkUiKl45i/jikt5n70QleVhXQ+nQySFg4Sz1PCJlu4
	/p6GmEnqxMfATQydOvlj6wbC13wi2NBQEBh9GZXBjmBEwn1vYD8lYAjjJP2bxF/leM8Z4wa27bS
	kEQvid6lu6MhwSWmTzyOqmAROSfDSFmF+4T+f4Ed7vownOvDKHLmkJ/t732ODKp1l3P/lKZnyOo
	4=
X-Gm-Gg: ASbGncs6yE0yZb9S/7yl3l2tMlkfZhGnyR2uSbp6SlF+DDB5UvsD5DPizVEZ2nsPZ67
	6eURKWmMnsNEG5xAe/GA3O4Kr/Jql83m9vlnW6SaVb2CzS75vqPI2ifpmrxixdhk6b+TGhG9BLQ
	G2XF5OzeLw/8BwLBDZkPSOg0kOQ03XOMpzg/MWupv7Q/Um12HkMQ08TMSzuEBEbC63jxjTsc9yl
	kPcBEHzHk2IZrNTfjT4MyzB5qTEuPHS44w5Iod4APAW/Ys9rRsyxEpMGwfWXfBTz5CHXIWYFHFT
	rV76XAn+e0zyQbWXmcMxurEc8zZ96lmSxJ4vSrB6M+U2Y/Zn9XRJAzpM3/4NUMMn
X-Received: by 2002:aa7:88cd:0:b0:736:50d1:fc84 with SMTP id d2e1a72fcca58-759adede58fmr12673879b3a.21.1753013834630;
        Sun, 20 Jul 2025 05:17:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcUStfPYDQTBrk5cKGxg9YMZv8SDo8dk5ZyQbi7KZdgKDGTRDIDq4rMokvtBoMwA8YBTbBSA==
X-Received: by 2002:aa7:88cd:0:b0:736:50d1:fc84 with SMTP id d2e1a72fcca58-759adede58fmr12673847b3a.21.1753013834116;
        Sun, 20 Jul 2025 05:17:14 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb154755sm4097933b3a.69.2025.07.20.05.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 05:17:13 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 20 Jul 2025 17:46:07 +0530
Subject: [PATCH 06/17] drm/msm: Add an ftrace for gpu register access
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-ifpc-support-v1-6-9347aa5bcbd6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753013805; l=2882;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=Bix42dg0qNYgpzOcauSDsSEviuQA7o0gZ10lc64yFRA=;
 b=YDcbRCw8zDNRVcb9x3+mPngvXNp74oc1PZwPDltZ9H3uAEhptH18/Sp1nZ5fWdZhqFXz7Nxce
 p70pMJfYquPADo46uV6P3ZE8srdpoHJ6xSt6JO7r5zRcvJ9CNUbWZb9
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=LL1mQIW9 c=1 sm=1 tr=0 ts=687cde4b cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=exQ2vEUdbx4SU7VtH2AA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: chNx9T2zN9oRQS4M1RyCWOe0BxhTnfoc
X-Proofpoint-ORIG-GUID: chNx9T2zN9oRQS4M1RyCWOe0BxhTnfoc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDExNiBTYWx0ZWRfXwDD/ms/dwjWh
 376l8Qm+uaATSfGQK2ucl4whAngVsTU/VAOcKzLYSH7YsQJYjqJbRmY8E3p23AhOppDgBaPKVn2
 lJMfh811Rh6P8Rqn32eO1p/pRaO8rwCoBAmSk2ifYizMe7HNN/hRFj3Fz0RuVxhy5kdbp+Pl8d1
 QDt5Gtq4Ur7dJxr8TJ/RO/0JHo5OPliNxK5I/DM4WmOH7QrM6RwPUAULGckby59Shb6NbCktLIg
 5kfv33ZWsP20ZoBIaBtKrlPnS0vI4GJxd8H/yCyhobS5Jc1LfmogyMhSsXehVBu4N/4QLqw7GEU
 1o4Ygj5MT12xqXNSGx58+PyDSN++zgttePA4NHXaNvhWXI8dl/El0LitGAld/88dmHkjJqYItdO
 vxcQZzU5HJCDPwynZx6YQz5CLoSCAsT6UikHiN3DfhqhUJ92GSPy2xPkRmuc4VW3F/yqC62m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507200116

With IFPC, there is a probability of accessing a GX domain register when
it is collapsed, which leads to gmu fence errors. To debug this, we need
to trace every gpu register accesses and identify the one just before a
gmu fence error. So, add an ftrace to track all gpu register accesses.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gpu.h       |  8 ++++++++
 drivers/gpu/drm/msm/msm_gpu_trace.h | 12 ++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 5bf7cd985b9c50e38468fed695234f787919a8aa..a0a0cf9efb3a8035a80cbbbf30ad294a72ccbd48 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -16,6 +16,7 @@
 
 #include "msm_drv.h"
 #include "msm_fence.h"
+#include "msm_gpu_trace.h"
 #include "msm_ringbuffer.h"
 #include "msm_gem.h"
 
@@ -555,16 +556,19 @@ struct msm_gpu_state {
 
 static inline void gpu_write(struct msm_gpu *gpu, u32 reg, u32 data)
 {
+	trace_msm_gpu_regaccess(reg);
 	writel(data, gpu->mmio + (reg << 2));
 }
 
 static inline u32 gpu_read(struct msm_gpu *gpu, u32 reg)
 {
+	trace_msm_gpu_regaccess(reg);
 	return readl(gpu->mmio + (reg << 2));
 }
 
 static inline void gpu_rmw(struct msm_gpu *gpu, u32 reg, u32 mask, u32 or)
 {
+	trace_msm_gpu_regaccess(reg);
 	msm_rmw(gpu->mmio + (reg << 2), mask, or);
 }
 
@@ -586,7 +590,9 @@ static inline u64 gpu_read64(struct msm_gpu *gpu, u32 reg)
 	 * when the lo is read, so make sure to read the lo first to trigger
 	 * that
 	 */
+	trace_msm_gpu_regaccess(reg);
 	val = (u64) readl(gpu->mmio + (reg << 2));
+	trace_msm_gpu_regaccess(reg+1);
 	val |= ((u64) readl(gpu->mmio + ((reg + 1) << 2)) << 32);
 
 	return val;
@@ -594,8 +600,10 @@ static inline u64 gpu_read64(struct msm_gpu *gpu, u32 reg)
 
 static inline void gpu_write64(struct msm_gpu *gpu, u32 reg, u64 val)
 {
+	trace_msm_gpu_regaccess(reg);
 	/* Why not a writeq here? Read the screed above */
 	writel(lower_32_bits(val), gpu->mmio + (reg << 2));
+	trace_msm_gpu_regaccess(reg+1);
 	writel(upper_32_bits(val), gpu->mmio + ((reg + 1) << 2));
 }
 
diff --git a/drivers/gpu/drm/msm/msm_gpu_trace.h b/drivers/gpu/drm/msm/msm_gpu_trace.h
index 7f863282db0d7812c8fd53b3f1fc0cd5635028ba..193dc9c8a7705c8988b8c4b60aa78a74e00af932 100644
--- a/drivers/gpu/drm/msm/msm_gpu_trace.h
+++ b/drivers/gpu/drm/msm/msm_gpu_trace.h
@@ -205,6 +205,18 @@ TRACE_EVENT(msm_gpu_preemption_irq,
 		TP_printk("preempted to %u", __entry->ring_id)
 );
 
+TRACE_EVENT(msm_gpu_regaccess,
+		TP_PROTO(u32 offset),
+		TP_ARGS(offset),
+		TP_STRUCT__entry(
+			__field(u32, offset)
+			),
+		TP_fast_assign(
+			__entry->offset = offset;
+			),
+		TP_printk("offset=0x%x", __entry->offset)
+);
+
 #endif
 
 #undef TRACE_INCLUDE_PATH

-- 
2.50.1



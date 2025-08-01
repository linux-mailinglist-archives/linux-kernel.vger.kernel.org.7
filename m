Return-Path: <linux-kernel+bounces-753725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB20B18707
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 20:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43B0E1AA6DAA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 18:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52FE28D844;
	Fri,  1 Aug 2025 18:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lqjb021A"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF4B28CF52
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 18:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754071220; cv=none; b=GvuN0MfmqqJWjl8QnrnUrF/aJZVPj1KHepdJO/e+WiG6tq6yiLvY9V8Q04qRCc+/cQo1RcUkrwM1pVNUvlaRRszo8kzvypBKgnziU3TOu5lW59mrKwqbrRbCc7vlusC+48dxn27EUCotp/Txj9mpLAn/D/h6vHQ45A2cbz3jDWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754071220; c=relaxed/simple;
	bh=e6x/dDP5ia/NlQH+0MKdj/wLpx5h4B+ZdMfBV+aj6qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7qvNueOOQa/VXif2v78ZAhgO/C00OKYg2tUilibHLdGmZOk51vDjifKdW1N5HoS6lv/oaIJexFLwjFkTwJuDQpEEuamA+C9Fn11opcZvzo7NHI3wglFiIZ6QhIyQvHI4Z4yVc8uN9Ad4GDbqirl4C5yX90oE5iKCMPLVRBqLrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lqjb021A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571HfRHd028630
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 18:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=0qBkf9JDSmf
	FwdkCS8a187SNR+0cTRqqV9Ya3fpJH68=; b=lqjb021AtTqCvnIJMJBuUKy1mw+
	SKPUHSZlPGv/P89wjiX2SYFjrHJfsfOrmAeW50LSXHK3LPcaZpjRUMIMiGKVv9l+
	fsz1dmWa9hHOHAGkgdauML9IhAYm3w2/cFdcuzXzn+uRAZj5ymAKCQ5jZtwCO/L6
	jh8aity2LH5dT6DNbCvbF5/07qdwLikc99JXmBKHqcSh94zDrcv8gWs/MFTAqQFP
	wRvF/F+jZsQXtqU9XGaAKaZ+WqcIE9sHJfO+kdHzPdMET3MbR9UXycmCFmo5ME8w
	C4BFLfa7v6ANOSZmRCZbbDFei+f0bYxtgxzaZhuyh5DWKCz7dPHV+OFRj1Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q86d59p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 18:00:17 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-31ea14cc097so1785157a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 11:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754071216; x=1754676016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qBkf9JDSmfFwdkCS8a187SNR+0cTRqqV9Ya3fpJH68=;
        b=XJnCD4GcPAupRrNn12z4mmyf57sTP07p/FfAlUEnUuXAXDMFYtoyS2oUKCx8dWjg7v
         FU105f/2ex/5HF4nXkmnJZykQcOqzQXhuczSbg/1cEizzNLgXJspcxj7OPzyEqQwhTIQ
         dBSK1VLSbwBfRViubq6rexNCkyRsREijIdaceOnHPq73x7CwtZDpnqgjnTDOXXDvefuR
         S4PPsi3arLNWty1q7jCsHK7v2WPaE7pUKIiOqMndMuduDRPe206UmO0IiRnk0DP3Mpj2
         XqK6wsSrONDnghXAfMx3ACZwL/Pgwsvzcv9A2rAirzPTp7OM+mxXBOeb8eCghWwwfWrc
         Yowg==
X-Forwarded-Encrypted: i=1; AJvYcCXtRIXnSKXM4LnIWeKbGKTBEVOfeLuhJjCyQvN8M/6cQ9JWSUenszBpMZOS83Bi2XDZmF8n22/QalusldY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd9bndMeaVrcrizODqg0e36pHukm6v4r1aoc44WI+owQsVVaO/
	UqqZZbdrO5reoccefKi3bScy1FKpT+Jk20YnMBi8TP8HPBM1Ps/llClKEWZ+uM+q45J+pcCPIT1
	tsULEnMbwysmZEtECq7c3dxTJSG+Zx7p81u4u9ClgkaZle79BfvQ7MQClsUPY3MpnA7o=
X-Gm-Gg: ASbGncuB67BlZ2AckBZD5nAa1rv/Fh9tm/z+UuNYIrhRp8H8pxIWW/eZvJ0xgNbgZIa
	49AXCbbguHWzC8Fjmcefej2LRP/id9V3Wm5qetWkkrgz+r9/7D9zsX9JVx5xs9a9DilFlE6VQ+I
	ar5k+yS30f08VagtPqURhRuLgHBLF+02qkBRVXVsFur5uu+Ir+x6HKAnt9eHGnn1aCS0Cv4OtOp
	6HQV0SWFHII7aykzXHOxr513e+3ux7HKeHJbPvLS0K31R6cbMoSQu+TlARMBPLp28KmFz7qYfbR
	9YbCFylij4T0rToNSQaZvFe1eFAWlWAWveGrOXtWuiSIQP2QAGo=
X-Received: by 2002:a17:90b:3cc7:b0:311:ad7f:3281 with SMTP id 98e67ed59e1d1-321161f1e4amr1051148a91.12.1754071216075;
        Fri, 01 Aug 2025 11:00:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCufiAuEtwIrk4MYNpS/nkKxgS/INszns4WCKtfrhQYzpgeLZK2wqU3sVv0g6l8Ck4AhkzDQ==
X-Received: by 2002:a17:90b:3cc7:b0:311:ad7f:3281 with SMTP id 98e67ed59e1d1-321161f1e4amr1051082a91.12.1754071215565;
        Fri, 01 Aug 2025 11:00:15 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63dc1bb7sm7971555a91.10.2025.08.01.11.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 11:00:15 -0700 (PDT)
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
Subject: [PATCH v3 1/7] drm/msm: Add missing "location"s to devcoredump
Date: Fri,  1 Aug 2025 10:59:58 -0700
Message-ID: <20250801180009.345662-2-robin.clark@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDE0MSBTYWx0ZWRfX4XlIAuB+Yx6k
 dNIOx2LJHjPb91a3yxvPmkhUKT0XV+mf7pkJX3lJfRo96zVuRNfmoPY9dZSP2Q6FGOhooVcvMn7
 i8avxfI0qZBwEk9q+rFy5eddr9+QFPY2QEgazNQ9YX6FLkaoYXWZL+dtHMlBG3vVKTAelTpNOYj
 1+OhALDHpXQ6Aiw6O+OuKiU8xc4942JPW9lR0S97/lAIhSvzux6eVDUwDH3v3eio+Jc3M/psNLz
 g+1KCNX+2NUYCywNiu2xPpR93mpAWD+Ah45epjb2//UjXLSaTckkgYw5uCnFGrFTC4OsxY5nh+1
 Bn9EpBgefHr6rpEsd+RDoCEEMQsCUpuxfk5g4YGr0nR4aiwxa/UYAwcqNlZd+OekyeYLnOFiNuY
 NYOXDbeJT/fOEDur7JAsKJl7mbyFz80wfFeiEaUrD7XqUclnu7Pie8cezVwURx7SKGkKyG/b
X-Authority-Analysis: v=2.4 cv=TqLmhCXh c=1 sm=1 tr=0 ts=688d00b1 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=EUspDBNiAAAA:8 a=YFM8xwheDJGXjHaRWHsA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: QaWFQTeOKyd2fBKqSCPCKP20HhsBx65_
X-Proofpoint-GUID: QaWFQTeOKyd2fBKqSCPCKP20HhsBx65_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_06,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508010141

This is needed to properly interpret some of the sections.

v2: Fix missing \n

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index fe38ea9328d4..a35cec606d59 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -1800,6 +1800,7 @@ static void a7xx_show_shader(struct a6xx_gpu_state_obj *obj,
 
 	print_name(p, "  - type: ", a7xx_statetype_names[block->statetype]);
 	print_name(p, "    - pipe: ", a7xx_pipe_names[block->pipeid]);
+	drm_printf(p, "    - location: %d\n", block->location);
 
 	for (i = 0; i < block->num_sps; i++) {
 		drm_printf(p, "      - sp: %d\n", i);
@@ -1877,6 +1878,7 @@ static void a7xx_show_dbgahb_cluster(struct a6xx_gpu_state_obj *obj,
 		print_name(p, "  - pipe: ", a7xx_pipe_names[dbgahb->pipe_id]);
 		print_name(p, "    - cluster-name: ", a7xx_cluster_names[dbgahb->cluster_id]);
 		drm_printf(p, "      - context: %d\n", dbgahb->context_id);
+		drm_printf(p, "      - location: %d\n", dbgahb->location_id);
 		a7xx_show_registers_indented(dbgahb->regs, obj->data, p, 4);
 	}
 }
-- 
2.50.1



Return-Path: <linux-kernel+bounces-748586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A79B14364
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F7374E5DBD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC1027BF80;
	Mon, 28 Jul 2025 20:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dyGqrtlg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CE7225A32
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734866; cv=none; b=gnaBSiHTfLK3JEHwcnDCm5CKEXv6j1lRwc3SPFEJID6a1REYcqFsJdvFEdrRvwx8bCz9t/3QRkUpRUKKyINDr3VmOy2jyrQUAEHFh+Pfyoz0b51JvHndlA/sGqtNwqr7bv+9L567VnSdvKMpMLCGxHXES+xL015e6E3ry7Be4GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734866; c=relaxed/simple;
	bh=7b70Q5zVK0DyCnXcj0bZzDoejA++eiLTDbI0ImTj2nM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXoP0HYaNzVasdmeqgf8G9VU5gLAK0r3t/FKmN3oiqlktFHwmulC80IK0hntBjcfe6BqZmcfgxqgzewemPmpRg4s/X6m4XMR3X0g1o/R24b6wjhxQIuzAmv8jB7FsttN1lRAdDyGsPUoLUu/vVX5TCV4SNNZbzYv/tCAD2ldZb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dyGqrtlg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SAlLkp005055
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=DJLMxQSPLul
	XmS86Qmm/+/LPCMloXGev8Y4y4Psl0K4=; b=dyGqrtlgUB93eDbcmXDouyadnwJ
	sNmpiwmsgyDI3+qLxbqFJVPzLsU1SWMAl5OOT55TRM0Eukkyn5WFy567grwzxSio
	yEWruDcHGv/Flv2AGfNskRvylbeg8Ulg+Ayrg0Lo7LErC1DcY0B1NoPD5LuGT0Fo
	XRXg/4km8fceVlfaNvyOSIbDzmTJOmLc30F6OxPXktAFheXPggZ5Mhne78PYTQ+3
	TabloM8V0mIuEY21ENDdtGySXV7kTdXRdq2Agwycugt1LlODTTknVh28v4UvvNmu
	jRsCwFsJALaboxqmGHD1HJzmjlZnhbyDFtRMm6vnLJ3Dek7nVlk6tnXAHAw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484nytx06x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:34:23 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b2c36d3f884so3533491a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734862; x=1754339662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJLMxQSPLulXmS86Qmm/+/LPCMloXGev8Y4y4Psl0K4=;
        b=Zc2H/1bDGxDLB+HZDCvYV2O5+sfqoOqYiOjdi+6YKhQBY6aL8z+upMQpi7T+anzDTk
         G1d4lhXfrd+qaeAD2FN7tujSjl2tQhPFle6c6SxlDJ7Pq19yAV0EXrFT8ch4g6aEvQS1
         joK7RlWdVwFI/sbka0bn28gSHMVCHDsSJbAUgK7Y4h5oEPJ12brtETsluajBvAXtSBXv
         DrcIlUE3zhxI8hq+f0EumqeLDbdR0e+hVHWt08VbYsPQU+37/0Fu9xDEas5u780LQ4I8
         GxAJkxdyJx8RHrRgAoOoGJSaSdktEtVEbW+Vyk0bZf3h/FqRx93baS+Or3nBJsSG8kqy
         BttA==
X-Forwarded-Encrypted: i=1; AJvYcCU2fOTlYLxfiwW9QwnsVD/6uUCLVQw3KiAXYyRoEP6T6HA0YHiupYT6ATFDbANRKUIgrQzXNF7mVTPuH7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBfo/6vBl0oef+1iaHHU2Z239g2Qcuh/aa0MaywaJda13zQZhA
	kJo+Nm78paZlk/IvRkhRzkqC5kdXPsoHG2UoRTUB6gB4onW6+az6yjJxQbngIj08CUyTbS427k1
	1tuGIt/BufV8GzkTlHBsNkFRGHmwv/BjpKwqMobz4keXeyWZTZv/cI9aPlx8lbmNrkNg=
X-Gm-Gg: ASbGncsPp7mZJC55dZWGb6Ws3guywRQrZ9sZJzsgkAMbnBpJjURWWLYxdgR7pDqGh2u
	Evr8dm5pMSwgopONaJRm1yj/beYucGj8JmF+8OVmbNnaDnHN467jfhMuq3E5e6dh3Bq51LxZY4n
	6GnHTEZG9Z01WkcydfitVXTURAW7w768HfP1Li9yqfB+Q8WSITllWQ6b2FgBZD6jQ+IVhP9fx9o
	n8Bi+YcKZLSkd7tyu0pSKQta5QHJxq4pvfwnPjY2qks/k2y7AQ51OAKqtRdQ0RbK/tNAilzJkgS
	qyiNFh1E5hG6jPTuSINUi4gdrg7FB2ck2fmsvuXxRnckjFGf3fM=
X-Received: by 2002:a17:903:1b10:b0:235:2ac3:51f2 with SMTP id d9443c01a7336-23fb3100edcmr234346495ad.45.1753734862414;
        Mon, 28 Jul 2025 13:34:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuxUhcvGJgtF6rDcn2PilTqgQgn7t0oHSLKPK2e//pz1CGm2wbhZkHISTRxQ7mDDyxLpBecA==
X-Received: by 2002:a17:903:1b10:b0:235:2ac3:51f2 with SMTP id d9443c01a7336-23fb3100edcmr234346205ad.45.1753734862031;
        Mon, 28 Jul 2025 13:34:22 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-240469a8111sm16679085ad.168.2025.07.28.13.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:34:21 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/7] drm/msm: Fix order of selector programming in cluster snapshot
Date: Mon, 28 Jul 2025 13:34:03 -0700
Message-ID: <20250728203412.22573-4-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250728203412.22573-1-robin.clark@oss.qualcomm.com>
References: <20250728203412.22573-1-robin.clark@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uhnnc9LYXa0F7FCnyF7Zs4vm_RdyvTSk
X-Proofpoint-ORIG-GUID: uhnnc9LYXa0F7FCnyF7Zs4vm_RdyvTSk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDE1MSBTYWx0ZWRfX5FnMWmbWp3mr
 +iDzEZuWnNrLYvFOkSnlBZU5ECki/Jyy3sUmJSfrVIKiJRR0q6MgRoTZfQxlWRfAtQ3N0EQoI6I
 dQDRxr4lVW3/tVLgkCr4P0gwJoJ7Y3WKBdgFve1NXrA89dbfuhF8P+PbF/DIbeUjgyYWNVSOk4N
 t6AgGEo/mMsO4NhwAHodCcKlT1bWUlIfBnzx0Km1z+BmNG6ORkv5WkV2ztP67OrklBYBaEsOSzB
 aKk4qZvDA91a1UNMqUAB0YGlOmaI1xX95nZdUOMvSqVlwCD771RlmBf4HAgIyJljD1zSvWSF1h1
 uo7cjW64EmA8LDoCO6GECPPy8FDTKjb+UOWYmenkpgAPSWmOhcqImz6AdUgPMdZ/6VM9JwJfVZB
 D6CWVp+LHgxo7ULSzBgrqOtc09luJuu/7Uc9BosN/6UyIGWDZu/YeRoVH62VbpOI6Mspmsb8
X-Authority-Analysis: v=2.4 cv=CLoqXQrD c=1 sm=1 tr=0 ts=6887decf cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=EUspDBNiAAAA:8 a=5vtJ6i-I-lkEOiUwjbYA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280151

Program the selector _after_ selecting the aperture.  This aligns with
the downstream driver, and fixes a case where we were failing to capture
ctx0 regs (and presumably what we thought were ctx1 regs were actually
ctx0).

Suggested-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index e586577e90de..b253ef38eebf 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -759,15 +759,15 @@ static void a7xx_get_cluster(struct msm_gpu *gpu,
 	size_t datasize;
 	int i, regcount = 0;
 
-	/* Some clusters need a selector register to be programmed too */
-	if (cluster->sel)
-		in += CRASHDUMP_WRITE(in, cluster->sel->cd_reg, cluster->sel->val);
-
 	in += CRASHDUMP_WRITE(in, REG_A7XX_CP_APERTURE_CNTL_CD,
 		A7XX_CP_APERTURE_CNTL_CD_PIPE(cluster->pipe_id) |
 		A7XX_CP_APERTURE_CNTL_CD_CLUSTER(cluster->cluster_id) |
 		A7XX_CP_APERTURE_CNTL_CD_CONTEXT(cluster->context_id));
 
+	/* Some clusters need a selector register to be programmed too */
+	if (cluster->sel)
+		in += CRASHDUMP_WRITE(in, cluster->sel->cd_reg, cluster->sel->val);
+
 	for (i = 0; cluster->regs[i] != UINT_MAX; i += 2) {
 		int count = RANGE(cluster->regs, i);
 
-- 
2.50.1



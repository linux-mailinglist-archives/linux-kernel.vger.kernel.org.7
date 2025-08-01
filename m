Return-Path: <linux-kernel+bounces-753727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EC2B1870A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 20:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E64316989D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 18:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF86928DB59;
	Fri,  1 Aug 2025 18:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dzLsOGhn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73AA28D849
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 18:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754071223; cv=none; b=ozRPf8NXLoR1cfzWjhuSFNEwdDTNDo9g+NttbST9cxVjUEgwN3ekTIDaK+7yWmRJwymlb89F4wRKXybtVahutMmp5obyTad9lXFa3McNDXDc9DX3+0Xjndgnr2Uz+hPTsfsciN8jWPiZt6f/1sr3ovqgh+FgNWbPB+zz+7IdLfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754071223; c=relaxed/simple;
	bh=OjCcQPQrfynntfXQWE1QbRhM4jxC/iuvd0QhrBx8e+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DR40Fh1zVlzEIiQKE23fdlDVXivYmmU2uzrjLdg9z6rF/AV9j5hEnfi++9+GFMFQ+4sagf8Hbw0d+g0htyLUNQ6UTCe2g0fk6/VCBr/4gjPwxu4hdSyjeqlENH2IL7HgkN5g2r6yYcd5lX8Lzv4JVehZ5KacJD+Q5oS/4E06BJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dzLsOGhn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571HfMwI014281
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 18:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=JAyYn1wklNQ
	c4y389Esg9VJ4y6TS3xXtsI3mzf8UH2Q=; b=dzLsOGhnul4nZ5I7+cQsdMKEAmV
	gy5K7ViT1KebwdmpHhsypAx1PONroiKyBavoudtKCdQNorSg+gMmGFdpq6cesjML
	fKvxyLVeGv+cA1HYQ9yuw2ssO5F9097RZP276dHkgy+ulIsuQGqP9L6AXqwTbhgx
	Y7ForzOSJnf6lfeY1aTzNP84TvmYbjGXEcfDstVT7uqja8L+fpK5l4xCq/la9GX+
	axyTjm3WGDRuO4H3+ZC23Yh+ocAwpA4vJslTLl25v6TqYwDPuc/dS1zvtpPz2k28
	lRgFBPeTnk1BVFNpEnJSWwnsds5omm1fcBaEeGgEmpkrPrzwjnWs2B/QtsA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484mcrmy8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 18:00:20 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23fe984fe57so15766315ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 11:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754071219; x=1754676019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAyYn1wklNQc4y389Esg9VJ4y6TS3xXtsI3mzf8UH2Q=;
        b=S5XjVzxhvRq7e7IU9qlmi7+Hl97HcHizJ2ANCEokWTKUl2uM9yCHFWI5LPCxnwwcdA
         uz9C5yQlsKDQkEWC2QvhV97K0kywr4n/Dr8jmMrIHrwSFNdmoW0ALZgh6oi2e1GTJ3xP
         TvFz63V3DV+Nf3WFfTEKrmflEpwT9FI1bNDmymtXN/QHtnKU6ofkHtMcb+ejEgXQIUnl
         +rgNBYsxsywv2qHWacPgV23UYOvVCG2aaHGJA3LEqMypoY4NLR5zDprdbfLH4E1bThoS
         1TOzyhMpSyKdCuBqloAA3mlcQfoHUU2dRkvvSdPKmXetIoAPY+r/BDPZArjNRoPzVzoK
         Q0yw==
X-Forwarded-Encrypted: i=1; AJvYcCVZPCBI/+mk48QdTn02RwxNUhJu90e0I7oeZtmCGwc4Xe/I0mdwRes/Oguv/qazO+QSxctS05A4xEDVZEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc2i682dq1tsm42zGMJo2AmlmxhcZDcAoMh51oaqEpmtK0p2Ih
	VmZquL+H2d93OCyZbczN4nUFuOWn6U2lUuekY02gJkD/0TiK3aE/zspkOy5fB4i6uYBp7vPqm4N
	6Z2SFbULURI742Qkw+2Cn/Ku9N7IslODmnfqcezy26b1w2lrKXJDvPmNyL0iEqXFTq0o=
X-Gm-Gg: ASbGncvy8DfkwgKkaOzRcuHJf8wXt5/0PbPN967dWHcY3hF8k272Y63Z1kaZRbGjw7o
	grVf9+l+0ebG6XfCUuWEvRKcCXAWsgM0Mpn9/9lsZxf3CrAymnsHV8it5TzoRRyBQkzi+R/V8io
	a0mKqJI80u74WmcjON2Mx2l1BuAWQ0e+EBIrW1+49OZSNX0svo9CAjkxwJB3fcxVqOaXhZI8xWO
	Y6yuj+cwaSQMvWTyMuz/f1Uyi8CalRybZpo4SPXdwHX8/CUDrkgrwblQihsHN8Ts5eW4ToZYaO+
	VBjcUIkZ5gH59USV9OUkyOhLA6SussLYeSxnPF8NwcZi7cCX2+Q=
X-Received: by 2002:a17:903:110c:b0:235:f078:4746 with SMTP id d9443c01a7336-24247030c77mr4913525ad.42.1754071218964;
        Fri, 01 Aug 2025 11:00:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq88m/8XtM65tFOPvwPzp0RMN6Lo0LKYxRrxCCtaSzhjaCvj19hJqOoPXnJBjwX5k93B39mA==
X-Received: by 2002:a17:903:110c:b0:235:f078:4746 with SMTP id d9443c01a7336-24247030c77mr4912905ad.42.1754071218424;
        Fri, 01 Aug 2025 11:00:18 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899b43dsm48563275ad.136.2025.08.01.11.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 11:00:17 -0700 (PDT)
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
Subject: [PATCH v3 3/7] drm/msm: Fix order of selector programming in cluster snapshot
Date: Fri,  1 Aug 2025 11:00:00 -0700
Message-ID: <20250801180009.345662-4-robin.clark@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDEzOCBTYWx0ZWRfX6MM5Hh7AYiF4
 81C8dWmLbjRI/OjvqxH3fk9/iTV65H6ZvBo4d5vdPEU+ONfk0yrCtkfVnlE69UZQBfe09fACPFS
 MAMSV8oPYJVUF99oM1E96WkSqkzdNfd6L6JsY/XcbrjEyE7k4FzAHy7S7HOPLP61eT832nwJR0P
 kG7yzsBSBdUAEwuVWxl0c+lDxSkg3zD+Osv3rseMeBLlul3o2SCSZpi78DI+xJwybIIESN6J1kC
 rngOEu3uJTx0Q9OwtfCQUKPSzubmO1VDhDgRfwTduRu1TvCqvM//JWArO7jGA8UZsSHIBY3HjII
 SvEcFQoOp5I1ZOTrlQZQBW2hrlMxo00vIGJHW+wtPAV2bcW7jjv8fXv4fBhDo7ouXZFPo4TpTvS
 axXp7dWnO9OTUytnUWIwOmzPvu1thHbdR7YAgChVjNXQJWkOdnphWXnV5/XVzCS4E4KKmIRo
X-Authority-Analysis: v=2.4 cv=Hth2G1TS c=1 sm=1 tr=0 ts=688d00b4 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=EUspDBNiAAAA:8 a=5vtJ6i-I-lkEOiUwjbYA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: ALMGQU-EgR5NP8gV-eZrNNJ_bj9m4EkJ
X-Proofpoint-ORIG-GUID: ALMGQU-EgR5NP8gV-eZrNNJ_bj9m4EkJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_06,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010138

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
index a35cec606d59..5204b28fd7f9 100644
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



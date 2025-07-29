Return-Path: <linux-kernel+bounces-749542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 287E4B14FCB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5114717BE7E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4307928ECEA;
	Tue, 29 Jul 2025 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZiwRHPIz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B4D2857DE
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753801066; cv=none; b=LThjrezYL1Tb+IzmwRpfPbgviUjdH34fHEjiFk0GNLI4BBnOjRY0uM1JMhb+d7D5KgDdqOrdWdGFFfDAQ4ZRZBpEt7F7lgdUpmAMaQovQ1iJEnGgXFPOFDROw91KwdT3ARbIRQLbjkxQBB0qbazVq34drqFyok/3VECr9JNlCjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753801066; c=relaxed/simple;
	bh=OjCcQPQrfynntfXQWE1QbRhM4jxC/iuvd0QhrBx8e+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XC5UnTu0J9i1fOA3R7rCnGINbBJvy+HC7Id5KJxg7eXlOpJ5thAZCCodJ5psWGKNC8B5BNQOTrKTFiNe+medmyf0G61oCRJC5PVQZd2H9svEhepSj3vgpfFPD2ftDbaQkUKXh7ZFchnispOAN4AN5d1oSxCd4aVGSOwillW+/Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZiwRHPIz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T8rsLc023590
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=JAyYn1wklNQ
	c4y389Esg9VJ4y6TS3xXtsI3mzf8UH2Q=; b=ZiwRHPIzkt/3rNNsb7aQ7Wtdd18
	2mqUN0vdF2ms3+s8r2S+BUfhg3DB9QllgpMo9D8qjvLLKrjXoBYHd4FjZMKKWieC
	8fSaBhWXiB7vzb2Y7L72RtZX5yOi6l0YmBmbBpJ6VKuDrPHc9dVSH5oPbUUSQKYs
	8iMyA2bzj3q0Lf8jptTAkVNWgj6+HpJdJrUVUGz7YVLEDNJIWU/UtPkLyFMxQI3R
	9D96nUziOkQ5C5PJwkRbyDc63Z5rz1VcoqkYJhVOQNfTjICVi3+HXgqfxk2oO696
	6gGlfUapttfVrzOnOsG5/7uB510eSrhwoC7KD6UNjmIsDD78n+PkExM51+w==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484r6qrfw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:57:43 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b38fc4d8dbaso7080653a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 07:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753801062; x=1754405862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAyYn1wklNQc4y389Esg9VJ4y6TS3xXtsI3mzf8UH2Q=;
        b=LbORM7ohfsKjUuXOmatYboJhcUUhc0KA7Lw4PcZd0TSOy7Q1EbJAJm1lPerdaK5PX7
         lKOke0CvySXJMarg0lArfeCJWXqsN/JaxIhPMedBfpsAyhMF3OhxFgscmWps2+1dGgT6
         71pfyL/BExYcuA4fz3m2RFyazP9jlBg0iyPbOi0zTi38pdcYobKnZLRilsb6fqvpqswS
         0gTw85A6plCY2xJypioNWSQ4hhIRrdkohYnuv7qaDiY8XesO7MiJ5WkJZi8t4fuOlz/Z
         BUdCYV+rfvge98rJBQgcdh1xhYYPafoge93s0xAWPa5S0kbhB9i3twVJSEHjF+kFwTXp
         TSVw==
X-Forwarded-Encrypted: i=1; AJvYcCUi2kdvFIY160SoiiThamW83+F9kGYIBqtbHgtxhfklerHjLzgvEimUHUmWtgbLlA4fYKW9EqJ721+GLvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjUCzjVJOMrWZGY/KvosATBkvc/HCFzocnb6B38g2mnp5iAWjN
	CPyCWQKet9thhIdgcYWpMfZadk2/0/xlBlb/eAMzO69YOUXncVdnGyZL1wuwb9En98BfnBqD2xR
	G3JHPqKC73ne96cNh4tL4WqaXlS5s9y6yqe+vgySZHlrXJM0tON5pD9NgFeFzgK36j9s=
X-Gm-Gg: ASbGncsPwS+/XBiPL8QHSSGREqu9lZvcfAtvMz9ltO1vfdxjZihIt82W/UGudruXICX
	qiEAMLZHlJy8FrGMw+C9IAUD6fA9SJu1kYpt519WJ/rB1b5zdIVoO5MAJ3RyBf2htjql1BGdHAE
	/lpAX7fn+fx8NBK+f2YkVcgDqhJ6yA/z+9ECXlheDq1v5+qt3Z9XW87Z3JLj/rnFc7zieyIW+Ee
	JGvvAbE9EsT2e4u/gTjsI0NXa1mBjYxN6noYWqtNdTk1MFq7+eEx8d0HmvIE2lMgOLPO0q6H60A
	s4JihuI/2EmgITN1l3Ymd3dPJCq1A1Vc4EgS4gJEzEnxmTKLAQE=
X-Received: by 2002:a17:90b:35cb:b0:312:639:a064 with SMTP id 98e67ed59e1d1-31e77afec2fmr23804173a91.28.1753801062176;
        Tue, 29 Jul 2025 07:57:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1VfCPq05jHjaQmPdpsTNpOERHdd8AcbiU4RZ9VCJMxFekjA0Y9XcD1WRvDW/ywpd3mPK6XA==
X-Received: by 2002:a17:90b:35cb:b0:312:639:a064 with SMTP id 98e67ed59e1d1-31e77afec2fmr23804129a91.28.1753801061607;
        Tue, 29 Jul 2025 07:57:41 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b42121a2c8fsm1289263a12.43.2025.07.29.07.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 07:57:41 -0700 (PDT)
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
Subject: [PATCH v2 3/7] drm/msm: Fix order of selector programming in cluster snapshot
Date: Tue, 29 Jul 2025 07:57:20 -0700
Message-ID: <20250729145729.10905-4-robin.clark@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDExMyBTYWx0ZWRfX2xZpdVwDaFOb
 ERvV/nb7iFGgglDe+JXXucYlZpQqU37Bjke67r7IFPwWRkwR3M07b83qMOHMeHNPbR3O7ApRWVv
 Q7/pLT160rA5XeQromiZ0uZYOGjdwentPOTOPlRwUNaeU0kjLo0GoVh3ekyUu+ELU/dI6RUxqF7
 LSexvO91A42SmiOwQli0yEVUUnJEALUs9tfD0zIRUVtmBUG8L3EeOhTBy6S3+fNbb/MnB1U7V9/
 4qRpBjcb2zKXHfCjtxH0OboTbjP9zXUcAAtG4LWqwwM62mGfdjeudoQUGLHhNg0oi7g17kSL6vX
 a+AK8u2vdvUQTdr4/cfx4BZb7csGnZV1pVmPha2yajU6etqhT15ONkEr68ukthNXiwh4htrFD85
 ihUipcDxo33Mtwzxzr08txgUNaIAj8PA0oUnM1lmThHn4z/M5NqoECRbQWq0jqHWY9qPGz+G
X-Proofpoint-ORIG-GUID: SO5L_rkWk4I-zJJW2TzmWyCXNT9JLnGE
X-Authority-Analysis: v=2.4 cv=ea89f6EH c=1 sm=1 tr=0 ts=6888e167 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=EUspDBNiAAAA:8 a=5vtJ6i-I-lkEOiUwjbYA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: SO5L_rkWk4I-zJJW2TzmWyCXNT9JLnGE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290113

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



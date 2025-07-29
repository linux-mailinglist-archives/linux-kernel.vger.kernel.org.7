Return-Path: <linux-kernel+bounces-749544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B90B14FCF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABA4818A3FFD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD96291C19;
	Tue, 29 Jul 2025 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iiZYV5jr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17C528F92E
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753801069; cv=none; b=HaZmVzFVCgdpuNziQ4ijAI5gYOUJlZ9iAZbEXg4L9c5hu6U/Z5qQrZiemAIxPoJBUiVO6lgz9Uyagxdsa6xEskpyA/XlnC9y+tJM60m9B1dLEow1tga+LZC7yG992g+rD1hYmjUuPsKruzLMihnWUlGQG7Vk5oErgn1mOIm7s7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753801069; c=relaxed/simple;
	bh=FAN6MDlQ+moZayDw2NfRU6KnZ5pK8/y1vLnQw1RaZ7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKrbB6VsW4/Qd3XHrmQn/aSEtWAn0xzvLJhE9pz4cvmyj0Wum1pUEIAaGowf8nNS6frme7UgpVSpyZ/BWiNT+8x09XjgZNVJmY51fL3t5RgdFuQZiLbM2PHtSFHD44TWXH7KSfhC81rcbT9l4H/p7zYJxQYSCW9eAJa4bomowDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iiZYV5jr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T8Krrk027594
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=mD0NBZ6SOPW
	kY6KB67p+Vrn86xtl4nZV3W1LSsEOfPE=; b=iiZYV5jriManv4CDr58TLuNr65y
	F3hzRYwPt2s67ATn13QZ/6gDeuUYU3uD4URo+ta7htvq+r3eETOy1VvFOiJmxgNy
	cRNHjFJ36qq1/ybOdfYDP7dhA0VOPouoN9z1JvBnHvvpJxjv4EnYs64poNCsCEdx
	VgrPyzVEKhxkLtQ8fgXW8mTpWiG9LDKRjpHwwleAN4Q5NjWkhF3KueR9P9qRUm5o
	qVvXNYGLurukCT/96AxEfqVQCsb0qFAGw8/lbX91E9MLAQgfO/O9ddLDjg2PCbTZ
	fdGT773F9GA4kc4spG72TylUKJpoWSjFNNaLhad06NCoC10dT3MAgAkOVOw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4860enwsjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:57:46 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-31327b2f8e4so5561403a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 07:57:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753801065; x=1754405865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mD0NBZ6SOPWkY6KB67p+Vrn86xtl4nZV3W1LSsEOfPE=;
        b=q3H5MvJyMSNZZBzN5PpMaoiM2Xb2DG7qKeEx3Y3zBN4HQHiuZjRdsTmm5tbFzLSSyF
         TV4HEtRux/NCvL5L0Z3Oc7J7641pQ+jIBGxM10KYSb5/McWhJFV9ChfoKPbsk/6JGWZq
         Elg3fK2QpxIDDMjAZxLUQhdeGXKGCnS9fQgam8jhrdXiWhGwvvi0TiHWIp0EMoPjRr4o
         VzIsEEFDVdVpcZr1UKd1PelSY5j3R+FSxJEWVsjcpS3E/UaODibJIDdZM08w/rOG7ELr
         3iz2kL04Jl0ogtmnwP03gnFh7oH7cALySb2BnSyOwTJeIPz+8G4QzPcSHqv/OkVDoUdy
         EXtA==
X-Forwarded-Encrypted: i=1; AJvYcCWT3jRUSFuDVlAIwFuQWRkCx+oekj+lbi2m+LiJ4jbkxv6hdGqpO2g3VkK2VI+zEK8VCNo7F82jAweHlao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXk9+2DJ61diBP5lt+DiosxC1nPmvKzW6T412rY2QfaBLCoKC7
	m2XqlpDE4VrB+ZLtYM1R3rA0tDHjeZfqttSMT1cI6qSBdbgwpcfD/7TdvvcYzbia3nagORAlmvf
	NEbickBtRrEuTd+n4FWdbhNGWrWfCgrgRgWkecPoUwIHlDk3V1di1w4xfekzZgXcVyv8=
X-Gm-Gg: ASbGncvsdYgzPQ8/xfW2jrq0trF/2Sy+P5XSEBbc70VmB+q/EymAbzeuRiB2eFqqTJB
	ZVJbXbvGmEqGQ5U/L0ifQi0kS+6URmCdKAaVdnkTzqaSdvfg9V6MxIe8FxY8IY7O34Pkj81+2Lo
	hBXRm08FWCChmYi/bYVuFvzzcJeFbFUtGt+IrO4CbrNHLjXMEUPSjCEJkutZnIgb/ubWrCs8Tal
	pREodBb5cvOHbVl3GpD5WNLbqs739scMHYzzVqsTMJUTzQPO70XZDGkfsfUtyopSwi6fboh60RO
	k3+yP6KyCGJrZz/oVlYrFJ2nmW+ku2l4E4bgq60alw0eho6w+BA=
X-Received: by 2002:a17:90b:4d8f:b0:315:fefe:bebf with SMTP id 98e67ed59e1d1-31e7785f8bbmr20455320a91.13.1753801064895;
        Tue, 29 Jul 2025 07:57:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEiMpmUR+bY4vgJDJrIuyQ52pRlkgEThbWo2keOzuYnD0mITzM0Bk5ZrIUFuV4Dy4dKAex9g==
X-Received: by 2002:a17:90b:4d8f:b0:315:fefe:bebf with SMTP id 98e67ed59e1d1-31e7785f8bbmr20455279a91.13.1753801064338;
        Tue, 29 Jul 2025 07:57:44 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e66eabf0esm12322972a91.11.2025.07.29.07.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 07:57:44 -0700 (PDT)
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
Subject: [PATCH v2 5/7] drm/msm: Fix a7xx debugbus read
Date: Tue, 29 Jul 2025 07:57:22 -0700
Message-ID: <20250729145729.10905-6-robin.clark@oss.qualcomm.com>
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
X-Proofpoint-GUID: 8afBe7c4wIlz3jwf4wiJYl-Z0rSuK8pS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDExMyBTYWx0ZWRfX2Pn7xSI5eiUU
 363lWjtMjc4i3AVngNXLB7dexq1ihHhMILP/KHsGFXpXwxFHIeWli6b9idTZgS1jjZE/LOeDAMd
 yzKh79ikDWmoSReY61l+AjP5G5MaWENq5fJU6ib/m4/EmoL6TVSbKlIWrHiNOTJh4JBf8/i+HCO
 IVS7cNsFgLTWB+FbGlUWDNpfn99JQfVhvvmX0+Jm7BW5DxR/49UbStj+9m30dnT/G7vtG5/4iai
 WuMyB7t8NfZWUWg/ThV9UCt0375gFZfMKh5uOEk3tAaUNsnJ2SB46TsILuK6Dt/Aai1HPVVb6Ai
 OlbAnZ243EmsAlANmgLc+7uUOgogiShQS3Rg4mBN6WX8cyLrf247n/bIbTLmDAai5Nhdg26zt/K
 BWv8B669o/f5RlZA53Iwp9EkuiUVb/6IzG3t1iy5Z7KZiZIBtWXaYLNxdmbVZb7WOWgEdgGV
X-Authority-Analysis: v=2.4 cv=DIWP4zNb c=1 sm=1 tr=0 ts=6888e16a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=EUspDBNiAAAA:8 a=IkVRe3mbPPK2UihE07gA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: 8afBe7c4wIlz3jwf4wiJYl-Z0rSuK8pS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290113

The bitfield positions changed in a7xx.

v2: Don't open-code the bitfield building

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c   | 11 +++++++++--
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml |  6 +++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index 173c14f215a7..8317e1107389 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -174,8 +174,15 @@ static int a6xx_crashdumper_run(struct msm_gpu *gpu,
 static int debugbus_read(struct msm_gpu *gpu, u32 block, u32 offset,
 		u32 *data)
 {
-	u32 reg = A6XX_DBGC_CFG_DBGBUS_SEL_D_PING_INDEX(offset) |
-		A6XX_DBGC_CFG_DBGBUS_SEL_D_PING_BLK_SEL(block);
+	u32 reg;
+
+	if (to_adreno_gpu(gpu)->info->family >= ADRENO_7XX_GEN1) {
+		reg = A7XX_DBGC_CFG_DBGBUS_SEL_D_PING_INDEX(offset) |
+			A7XX_DBGC_CFG_DBGBUS_SEL_D_PING_BLK_SEL(block);
+	} else {
+		reg = A6XX_DBGC_CFG_DBGBUS_SEL_D_PING_INDEX(offset) |
+			A6XX_DBGC_CFG_DBGBUS_SEL_D_PING_BLK_SEL(block);
+	}
 
 	gpu_write(gpu, REG_A6XX_DBGC_CFG_DBGBUS_SEL_A, reg);
 	gpu_write(gpu, REG_A6XX_DBGC_CFG_DBGBUS_SEL_B, reg);
diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx.xml b/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
index d860fd94feae..7a32f6715752 100644
--- a/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
+++ b/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
@@ -594,10 +594,14 @@ by a particular renderpass/blit.
 	<reg32 offset="0x0600" name="DBGC_CFG_DBGBUS_SEL_A"/>
 	<reg32 offset="0x0601" name="DBGC_CFG_DBGBUS_SEL_B"/>
 	<reg32 offset="0x0602" name="DBGC_CFG_DBGBUS_SEL_C"/>
-	<reg32 offset="0x0603" name="DBGC_CFG_DBGBUS_SEL_D">
+	<reg32 offset="0x0603" name="DBGC_CFG_DBGBUS_SEL_D" variants="A6XX">
 		<bitfield high="7" low="0" name="PING_INDEX"/>
 		<bitfield high="15" low="8" name="PING_BLK_SEL"/>
 	</reg32>
+	<reg32 offset="0x0603" name="DBGC_CFG_DBGBUS_SEL_D" variants="A7XX-">
+		<bitfield high="7" low="0" name="PING_INDEX"/>
+		<bitfield high="24" low="16" name="PING_BLK_SEL"/>
+	</reg32>
 	<reg32 offset="0x0604" name="DBGC_CFG_DBGBUS_CNTLT">
 		<bitfield high="5" low="0" name="TRACEEN"/>
 		<bitfield high="14" low="12" name="GRANU"/>
-- 
2.50.1



Return-Path: <linux-kernel+bounces-748590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91907B14372
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDB423B7435
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A1C26D4F9;
	Mon, 28 Jul 2025 20:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UQnJb8OL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C8327FB07
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734875; cv=none; b=MKmDfaMVqyoDN6M/EFmi23UHVyPa0GvKUtRb+moSQmypYBCXCiOrli0SQagJOsLKzkqjk8rJWPXg5smj9w8XP6QB/X7lSI7rbPgE2xxCAv6osaTqybysbv97DSZtSLyXLkQNwkwRDEQoX0JTsbM6OWLLmGu4QicwcY0HcE0HxcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734875; c=relaxed/simple;
	bh=a1xn1H8/fa/A9qraVB8eAftc2nCQicSPOhezcVcH5EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hUUZ4r2l3ymLDchr+Msp6E2w8QAr1Y+IFPuXXjpy5C40dLBZm0STZIZ6AgrMN77KAM6UwM8TSBsyqcU0EpfSfQ69lewSkSHbQ/4MFO1zQNwgRylvvzUJSWrOQpC/tz2l4NM2D5f/nJthn7N7QgXu+ggzAw/L7IXN5MOH/J3jnGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UQnJb8OL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SAlInu027612
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=V9+fcbz7W94
	r3G/u7UQJHN/TfdQW561mZf8p47PIeZU=; b=UQnJb8OLWP9QwXGogs/DlkXf7Vm
	zpe+3nPYqDV73hH5QmVsF1roKS4OGWEL3pbWD4iayMxZm3VJe4BZ5NZMEtKL2MbX
	A7KgUc9TvKS2opSSx9Zyf65Fhsi2r1OC4fGNmWZlCVqZ4qJe5pE/N92kvaoYyR+e
	siRfoXrTEpn/JqYkFYnQL6t/YwtpTGkBG4uLuoyqH6680TT5IjXnxxhA2+eUh9Ya
	J/nXg0CdXetsjayL53lOMwl0D6vdiDj9uNVaJTQSFbNAH7tApY1sFKfM3npPLy8h
	J15A4g04+UcUrb4/1Hp3n1EpzdqyTiJN8FeR5xFmjrRsDtrbvnbINTzmXpw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4860enu0hf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:34:28 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23632fd6248so49486285ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734868; x=1754339668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9+fcbz7W94r3G/u7UQJHN/TfdQW561mZf8p47PIeZU=;
        b=SDqw1YHU58A2eIdL6Ul7Az0Mvp6sIT4YDtuMlVBwuNob67Zs5bMD/Xr5lQevwp9TlN
         eu3eZqV01gqpgRSQYDI1Ej+FSWk2AiszeZv2Jz6zjl/CNjI/YFLIYJfWjluVMxvbtgpe
         uNYdrDKxrkpDMhMnJs4ZdkUmXyrYZ5RU5X1S/eSDIciKYXHO6Q8xHyLrfl5ceD3Ay2j/
         sQBLOYSlmufHY3NGLGPpIpG0JzDBj+dSaX0sW8jVCSFAcl3BFSkDAASwANvWkO4OPjwz
         CTpb/CgFoIUnwztgqvaTK+37/n9ddMs68E+URbzLf95L7224tHRBHrSRIDbbhLsJpljj
         QuPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlnPI7gB0/AX9+frPekNom6WHBblL+wJZwP6b37pvnEu7IcrvbmuyHi9MmzF1zmwTB1dOpYmxZdZA1VDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQePU0R8SVi/xCNOn3Dy+AjiJJyrTUm+NT0yASlBc/XOQ78jRt
	AOe572IjWZYdVo1389WdOWPV0NVg6Ccx/PNERRQiJRxx4kfoJDkRI5oYH2qHtSUn2ICsrtfhepT
	Xu8v7FtTFsuaSkNUnbkrP4hJg0UXHE7BTjBL1cmOaxF84kHi0zV8gy58syRHQmQbYXjY=
X-Gm-Gg: ASbGncs9AAEM04V4q7NEAkFLADcMtmLdXmaZ70Saj5mjzwv1pSxAnB7HtZb6tNnsI0p
	+Y0k7bkexXEydOgZib42MglP2Ewg4yO6pgyKRt1PgoSH6UjmxcggUm8Uw8lFz4Sq2WwKM/cqAR/
	i8cPgSeoaNT4hyPkIPD0x8VQAEqsokcJShX5UMzmQSvyYOr4QoELB+rJEe2ZbqC6O0PhXCbRGx3
	mnSwUmb3fgECgh/VIPonaWGxjJ3CXGwWXWmcSOi/4LMScpuC4aVveFtaIr9OmvbGaf7Ur0X12UT
	0QQhtIQneC6sE4p2sVAaLAJX97Otp5XcGvxJENK2Ys5ppT5X6io=
X-Received: by 2002:a17:902:f083:b0:23f:ecc1:ed6f with SMTP id d9443c01a7336-23fecc1f05dmr88609075ad.17.1753734867984;
        Mon, 28 Jul 2025 13:34:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeYWCqRtE24tEVyEPFKQ+MJ3KSpNHmjoUKuOAzp/vLakvO+2T4gVctQrTsB7zyfP/q9HW23Q==
X-Received: by 2002:a17:902:f083:b0:23f:ecc1:ed6f with SMTP id d9443c01a7336-23fecc1f05dmr88608795ad.17.1753734867535;
        Mon, 28 Jul 2025 13:34:27 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe4fd62dsm61122835ad.111.2025.07.28.13.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:34:27 -0700 (PDT)
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
Subject: [PATCH 7/7] drm/msm: Fix a7xx TPL1 cluster snapshot
Date: Mon, 28 Jul 2025 13:34:07 -0700
Message-ID: <20250728203412.22573-8-robin.clark@oss.qualcomm.com>
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
X-Proofpoint-GUID: eFi3-gGOOO1M5tU-IvR1zw0FZLSQZseT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDE0OSBTYWx0ZWRfX4Qz+MuaDBz9D
 SXpsPCiuy3KjwzdHiE6H6XC8eiXs5OlNBSQ8eqdSxgSGuCH9hbFBgVik12KZVS8q3yqi1ixyjAd
 e4yTnfDQyM6EcBFiPJ3QkIFRxMy8hUsUdKs+ZKpL7KUMeVnUc7Glh+oLMOBa9ifROegb9Fq2mD7
 HGrAkCX5u2ZY3Gg5Vio50u1K1M7bnhUxtjncOYWvjJ5dJEceO4wWEUJaDvCHGreZMeuUywzXbtt
 AulwhCsoiXyOWojVwV/DjJfK6Ie/TlQ8Wkk+KdyCaBXnVrbfTvkBuO1OJAZtFFLrHsdBu4VA84o
 JTrhsYTdgiEqwLdqVqnxH8fCZO/+eB8gMDXrv2WiAxCMoLEtbtI2HGfPc/p51zxt7IIrKkRuTZQ
 lQFpAEFEc7xTTWiw3zhpBP+pqA7/gj6jtGykv4Q8T0CBZoOXkIS5uDdFhRUOC9iBCTzT4d3Q
X-Authority-Analysis: v=2.4 cv=DIWP4zNb c=1 sm=1 tr=0 ts=6887ded4 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=EUspDBNiAAAA:8 a=zhZQclFZcvAaLIcfx54A:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: eFi3-gGOOO1M5tU-IvR1zw0FZLSQZseT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280149

Later gens have both a PIPE_BR and PIPE_NONE section.  The snapshot tool
seems to expect this for x1-85 as well.  I guess this was just a bug in
downstream kgsl, which went unnoticed?

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gen7_0_0_snapshot.h | 11 +++++++++--
 drivers/gpu/drm/msm/adreno/adreno_gen7_2_0_snapshot.h |  2 ++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gen7_0_0_snapshot.h b/drivers/gpu/drm/msm/adreno/adreno_gen7_0_0_snapshot.h
index afcc7498983f..04b49d385f9d 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gen7_0_0_snapshot.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gen7_0_0_snapshot.h
@@ -668,12 +668,19 @@ static const u32 gen7_0_0_sp_noncontext_pipe_lpac_usptp_registers[] = {
 };
 static_assert(IS_ALIGNED(sizeof(gen7_0_0_sp_noncontext_pipe_lpac_usptp_registers), 8));
 
-/* Block: TPl1 Cluster: noncontext Pipeline: A7XX_PIPE_BR */
-static const u32 gen7_0_0_tpl1_noncontext_pipe_br_registers[] = {
+/* Block: TPl1 Cluster: noncontext Pipeline: A7XX_PIPE_NONE */
+static const u32 gen7_0_0_tpl1_noncontext_pipe_none_registers[] = {
 	0x0b600, 0x0b600, 0x0b602, 0x0b602, 0x0b604, 0x0b604, 0x0b608, 0x0b60c,
 	0x0b60f, 0x0b621, 0x0b630, 0x0b633,
 	UINT_MAX, UINT_MAX,
 };
+static_assert(IS_ALIGNED(sizeof(gen7_0_0_tpl1_noncontext_pipe_none_registers), 8));
+
+/* Block: TPl1 Cluster: noncontext Pipeline: A7XX_PIPE_BR */
+static const u32 gen7_0_0_tpl1_noncontext_pipe_br_registers[] = {
+	 0x0b600, 0x0b600,
+	 UINT_MAX, UINT_MAX,
+};
 static_assert(IS_ALIGNED(sizeof(gen7_0_0_tpl1_noncontext_pipe_br_registers), 8));
 
 /* Block: TPl1 Cluster: noncontext Pipeline: A7XX_PIPE_LPAC */
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gen7_2_0_snapshot.h b/drivers/gpu/drm/msm/adreno/adreno_gen7_2_0_snapshot.h
index 6569f12bf12f..772652eb61f3 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gen7_2_0_snapshot.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gen7_2_0_snapshot.h
@@ -573,6 +573,8 @@ static const struct gen7_sptp_cluster_registers gen7_2_0_sptp_clusters[] = {
 		gen7_0_0_sp_noncontext_pipe_lpac_usptp_registers, 0xaf80 },
 	{ A7XX_CLUSTER_NONE, A7XX_TP0_NCTX_REG, A7XX_PIPE_BR, 0, A7XX_USPTP,
 		gen7_0_0_tpl1_noncontext_pipe_br_registers, 0xb600 },
+	{ A7XX_CLUSTER_NONE, A7XX_TP0_NCTX_REG, A7XX_PIPE_NONE, 0, A7XX_USPTP,
+		gen7_0_0_tpl1_noncontext_pipe_none_registers, 0xb600 },
 	{ A7XX_CLUSTER_NONE, A7XX_TP0_NCTX_REG, A7XX_PIPE_LPAC, 0, A7XX_USPTP,
 		gen7_0_0_tpl1_noncontext_pipe_lpac_registers, 0xb780 },
 	{ A7XX_CLUSTER_SP_PS, A7XX_SP_CTX0_3D_CPS_REG, A7XX_PIPE_BR, 0, A7XX_HLSQ_STATE,
-- 
2.50.1



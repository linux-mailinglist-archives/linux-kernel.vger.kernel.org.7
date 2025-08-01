Return-Path: <linux-kernel+bounces-753731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B310B18711
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 20:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94AFD1AA73B3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 18:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C183328FFC7;
	Fri,  1 Aug 2025 18:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aaNmEuGK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4C728FA91
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 18:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754071231; cv=none; b=Fko6P9Qjk+7MMADi5bIleKJg/z5bDuvcrR7EqkZfoseTAKKk+ewdewPA8sjXEpWN20V3ewtXvcs6nXBF/u5mERBlLQkwXeGDLMIVeQ59M4/acVXyqocaE8McU7DeHxh+IiiqprJN1+qWzBH/9rXEQtuc4KrjMxpqHBW3GldRYrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754071231; c=relaxed/simple;
	bh=a1xn1H8/fa/A9qraVB8eAftc2nCQicSPOhezcVcH5EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YyERpszomfg15BZiH+u6e01Uga34RsLlpP6zsZgXcoKtRtZRbmp/R5mfjIvkIoQil7EWJPAUzxEUmIyoXk4IgKms/Pc7CDAP2w18vq9sN0ohi8hdxZjM+38Y1vdzUW/TMOLwk1cdAO/XU15+JvrQuoWyauBLZcDYLQz7NLmbwmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aaNmEuGK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571HfOWV001851
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 18:00:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=V9+fcbz7W94
	r3G/u7UQJHN/TfdQW561mZf8p47PIeZU=; b=aaNmEuGKHrB1W4wwaq9fNwiKsFi
	GSNG2TX3N1hxhlRe2h2eeq+HWvw3CR55m6E0ZY+j+KoEH6u5mRGiYX5iuRxcDScb
	ooi8+X8R0l7PXPVBUGiZofF5JLWuLapA2S8GoR3qYYNlZ38Hzlthr8R8hF8tcCBF
	CyeTClbDv5gfq17XjYHCvGuB+6YYtQz3XjLeeNIkflsEOX/Ra1hxy/KOWC7x5N6t
	p+3qJpeIWwj3jmNkl+vcI9lTiB310XNujd+irtH/K732OXq8MkkRB3CwBwYLYRGY
	EHoKiMMEa5wiANXuNszOBoEXAzrjQJEZenrhoSHVAqHSVxdDsrq7hPBCICw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 488q7xtcnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 18:00:28 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3138e65efe2so2193092a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 11:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754071228; x=1754676028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9+fcbz7W94r3G/u7UQJHN/TfdQW561mZf8p47PIeZU=;
        b=MWDp2fCMwPlrqBsd0jIQoUNqQc0atSO1fnXVhlBXLmUkHTXSRgbWuFcxwucwb+vAoi
         01bUWm28k5Fm3I9l3NdAHH+nuq5zLakxGn+GND4VzARXjXMxKnOrEvI4IjA3WHI6pJNc
         BS1IU5V0Xd6DfuCRZ8e1LFX83JO18y+8KqR7I1guElfI4fD1OSknRopp2bwmRp3m4+L/
         knJbKgr6b1qAYqe7yn1Bz5+3oYSUvc210Lk2CU6GL2xh6GuY/iqqDHQ2SSF58/CKKpub
         a9Ei8O0aE8AsDcuWLsF/Y5/R3/8RyYP3WqRgTU+c+ZxgMCORgpYTP+58Ih/3lJeri3Oe
         FKjw==
X-Forwarded-Encrypted: i=1; AJvYcCUv+I3X7UV6er+CIe7vAOnBOjDLw3cVkxaOQjVjV3ax8tEJcaMJOu4J8fZeqVMBT4IAtxXiAD/FXKxPWwU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8yxHj5ixOOeKUe0AQCP+RAQu2etINiHY5qX/zudgJ2oeftr+C
	ZipNTVvm4/RE1yKNM75/iVL/sXwoeZgcwX+v9w9CjR+WEIRtubCikAOcg8qK4IO+L4yk1iQcK/O
	JYl1KgOI02bINmue4EjxLP2l3d3OpU5I23G6DTDtKj/+sAq10dMJTtOAVSFiCuQSaMuM=
X-Gm-Gg: ASbGncurWKP8FR1d2ODTVRMv975FeuqT7qdiNIR6962F1MkQmXdMWVZDNQFfFfXjr3y
	wgMvaCZMP6AyDzBt1aHMJ4a+l/naBbZh2J4Ql7qbWyIu4bqpyrg6FM6aBR/URcd3mssPdR/Ay6e
	+zvmy/8+pcSUSM97fbaNWvff3RjdydNQJ/eMSsjL0aU+4jL24QOMBhUrrxJY72gsJmEYhEEXPqr
	+ans+5wDteEwDLvgk0WY/BJSSPo1GGh0lpprv5ZzAEYyGaQbU6AF8rWV7mrLbRDHmUNQrYB1iM9
	cxNfjwgdZfvbilYe6Kea+2yV+PHob5gO3S9qVMxAbd96Z/w6vOc=
X-Received: by 2002:a17:90b:498d:b0:312:1dc9:9f67 with SMTP id 98e67ed59e1d1-321161d9bd4mr1027085a91.2.1754071227821;
        Fri, 01 Aug 2025 11:00:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH0dkuAC+cmmCazD4s9F12bafJvjQsxaVASh+WEL94pt/xIt0kpv25mM+WKaVod2hnX2+8ww==
X-Received: by 2002:a17:90b:498d:b0:312:1dc9:9f67 with SMTP id 98e67ed59e1d1-321161d9bd4mr1026863a91.2.1754071225861;
        Fri, 01 Aug 2025 11:00:25 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32102ae8b5dsm1260245a91.3.2025.08.01.11.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 11:00:25 -0700 (PDT)
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
Subject: [PATCH v3 7/7] drm/msm: Fix a7xx TPL1 cluster snapshot
Date: Fri,  1 Aug 2025 11:00:04 -0700
Message-ID: <20250801180009.345662-8-robin.clark@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=EqPSrTcA c=1 sm=1 tr=0 ts=688d00bc cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=EUspDBNiAAAA:8 a=zhZQclFZcvAaLIcfx54A:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: VyJqw1r9w4kNO09uKbsOGok_ZOg4CtuR
X-Proofpoint-GUID: VyJqw1r9w4kNO09uKbsOGok_ZOg4CtuR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDEzOCBTYWx0ZWRfX5k6aBfWz7nCg
 QHoEHdOYoUp4OKT0B/5XfKbwTGoBuz5l6F98SlyWlbW0rNwcxQrg3zhRDXem3SbL9b3/Cri+Vqg
 bbupXZs0Rvea5d6uFuhYXwstyWTUKZR29M0Mhdmr2Q86Amho2jtrGQqujU5tgsd+iTLozFFpnJ5
 FpFhVkY3LJrMl5WIYUy7pV5+6VSAyJM9YUgw0+9SKYfWUFGCtT38ePg89CiBJhi9Agr14Xx2M0I
 W5kFwvY1yCKKyFPl3eBGfPU8f1gn0mk++k3hQbtUKBWI5xhSd0lz5Vdjy5pYM8IU3D2rMlKOdQY
 qQ7lSbM/+qd1h3aGNkBwdAEwSt+yzPL1f0+hPk9Ii7ltVFo07oOLMNAyRDkGZ4UJQ5Xd/ZgX4UE
 93GgPEPCazhHIhPcT6hJFB3FxT2ry8Hp1iW2sSXoFNvV6znOLD5jQ2NRInlzfABf7MKB4VBx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_06,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010138

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



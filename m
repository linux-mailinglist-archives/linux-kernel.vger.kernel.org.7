Return-Path: <linux-kernel+bounces-749547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BC0B14FD4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E148D16B9FC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6805A293469;
	Tue, 29 Jul 2025 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g6wM7N4l"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2282529290F
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753801072; cv=none; b=QgqxwQN1LUUR5R6VOdU8n/NqZMwPpispEkvwsUSvSpykkD2kRxFTtIPfgd4BgDbzdFicVXqDZXvhFtGcH2fVlwc5O7Asewk9ZjwKBENY2P2f0UzPGpc2GAR9BNq3sGHNkMzGbSbqjJYTSR4PWUYVOZn5IB9VWjBp0TPijYgNPN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753801072; c=relaxed/simple;
	bh=a1xn1H8/fa/A9qraVB8eAftc2nCQicSPOhezcVcH5EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMU3vWcRbwXNHZ6J++vGTi0ZsCws436RH9zCm+EAAXfuQTHzQrhxeXkSq/O84oaPSyJfOBclGvllGOS2xie/tsiDNfsoGDh0Ix3KlNC9B2nRoqZc9hhxezQ3IKEy4c16jqng8v71DoklnBkhMW3IwhTrpCtaQO8+iO+LUv/NJnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g6wM7N4l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T7dFVS015048
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=V9+fcbz7W94
	r3G/u7UQJHN/TfdQW561mZf8p47PIeZU=; b=g6wM7N4lQvCzapGTjsB24ecQdnP
	AZKmCtkvjBv21XGHYm8aWaC+7I76LlAa2KB9QE8lCJvj8qwgnFfprxqu86+uw/WG
	FmQiSjoc5ug0xhf88AG5LhRtKEmAgulTy/1cn4tRNff1OvmFxN+gznutqPG9sGHF
	x+vlR73Y1jpcIKBdTvVH6RMXS8EiSvu/Za1cARBm9L4u0XO3xM/+o1pOobtct5Vq
	grnn4JEVp+dspPJ/18t9WcQHWDfc8zkB1b2Ye6/cAXTD4nVo9PIFr+ULuZH3agAO
	TNLen4WvhzPmqFop6LZq102scGiPpbq3m1ltK/r2T6FAZ4QfyXNp5FbySTA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q3xrfre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:57:49 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2400a0ad246so20891835ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 07:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753801068; x=1754405868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9+fcbz7W94r3G/u7UQJHN/TfdQW561mZf8p47PIeZU=;
        b=ri7XMU9rSoHMhgcpgJ7PqGvoJr7Q5XDXaLnbnxsG5/ASLeh1oTQPdd1jChsWwJJl/5
         HzHaqc6atZ6Q01zyODm7dGo4HIVYLB64g+DR3SRdKf/yWtxujCO8OBfTs/BFkBRuovro
         o4gf/3Mb3crKxp7LPRfaAP2ISsF1pAIXXzER0shfnIxd7O0xMz1H28OUWk9jSRIZQsg4
         iiOUgiuBcvIdtI2NU+PqJIB9phR2SL2+m9uLDr6PKfCTrXYP8PAbfc7qFpfxd3A+u2PH
         TZNLLz2dPx7/iNVq20NwNv2NTwYbB2U8PYUfVu9PIXTkpJiB+mA9X2pQTiwz35DqVdwm
         90FA==
X-Forwarded-Encrypted: i=1; AJvYcCWizFixQXv03G+BYppfYHHZjWMi9hJ8i75t0N5afUSekLB7X0hXyaW4xaUj0bqCPFS2b8le+YoTAVBWm/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzotcsMglEfzTMDnduf1jmq0US7XuBcXnlib4kroIVSx6sU+w83
	UXU5OQspH6XLNP/ec7suEytDVO4jxRp+9nhtHxfkFdjoQrnZ/u0lg+qmmyZmgbv3Rj1i32VW50S
	kvDCy3gi8AJn9G03h0HjeIK6SvetX78Y8k47yPHJfBIkkgITQiksTMR2JEoCwdN43ydA=
X-Gm-Gg: ASbGncvSeuTqN9bDXWmmAKglBaAT+Pg902gOhgVO87ZjBS8ZkMislaQx6KjMyFOGDsr
	/Ul0pcxvXNi2ff/qxBlBIv5IFlOJBTssjpKvudlnlg+OaBXBLCZhxRWGltT1dpsVlysppLG2py6
	Tx8DzQ6iiDtVeJ+WU8UR5LAFTL2z6bv/+bAr+xbMgAvkXDAsQXSCmVPq02uSyGUOuTD/S62Vj8B
	7leYpX2O/ivAlO7QMYfy62gx2SW2XVv58ucdkDIGfZRMbiutRsZk3m9A4KeeVtQrWQqw//CE7Sp
	T7Zzfoksb9VvaFu6Ia246pcU9BzxAvBdUy2G7UZJ79p2hV7nFfE=
X-Received: by 2002:a17:903:2451:b0:240:92d1:5cd3 with SMTP id d9443c01a7336-24092d165cbmr2863005ad.20.1753801067688;
        Tue, 29 Jul 2025 07:57:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjD1LFBD1KVpA0YlTQXKqialrZE77rREWeWa02W98WBwqwV+/tbJVbfbaFAXRlp8TRRBpndg==
X-Received: by 2002:a17:903:2451:b0:240:92d1:5cd3 with SMTP id d9443c01a7336-24092d165cbmr2862505ad.20.1753801067077;
        Tue, 29 Jul 2025 07:57:47 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24025f5a3ecsm49977215ad.136.2025.07.29.07.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 07:57:46 -0700 (PDT)
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
Subject: [PATCH v2 7/7] drm/msm: Fix a7xx TPL1 cluster snapshot
Date: Tue, 29 Jul 2025 07:57:24 -0700
Message-ID: <20250729145729.10905-8-robin.clark@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=JovxrN4C c=1 sm=1 tr=0 ts=6888e16d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=EUspDBNiAAAA:8 a=zhZQclFZcvAaLIcfx54A:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: CXnD-qYR6s-cC937niG2VMx9tp1rciMh
X-Proofpoint-GUID: CXnD-qYR6s-cC937niG2VMx9tp1rciMh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDExNCBTYWx0ZWRfXwNJLu/n6VPoD
 F+VI5IxM9jQepA4+83b6pbz8afYT+9FT9cvVcv8GUVd5dY4Q6oZ3pPgJ6sJncSJo5E7mVpU5h8y
 60GPQJc2sUC3AP4VRQ4AHglcR9pMu/Z5NJJ0lu3tuE3eSUJ9FU1jQVQTkO24TngAnl3f+DjSyvx
 VwvXKKsRK3WX5OsZLIJ/4Ze+MRfqhdUzS9T0kSiLtQyUSmuYx9kXMwMvGOQNuKDgsqr8Y4YH0in
 p38nna8HMhjuLvINDeJp1groxN8Bdl/+BgD30glJ0VewIG5psgUu0dxdxrehrz/d2vUiGhwm9ep
 drtdafOJ55QeucSMpn5INJcp4X0Fe9WIp6x/ACVD/yimselcnJbCQA/bDNCjxygdRBiIgsWOW8c
 3r2bKWwbi6yWV8Gw29beM5nBt2pjtoq3PX2Umh/ctwGd1Ojn61VWhUM+pxDLpLIlIiuXOvt3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290114

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



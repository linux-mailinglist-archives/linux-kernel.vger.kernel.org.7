Return-Path: <linux-kernel+bounces-784897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7874FB3435A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A21CD3BE468
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C87E2FB602;
	Mon, 25 Aug 2025 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dezX248K"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162E12FCC17
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131459; cv=none; b=etpAS5k7yd75bq6NFZ9RuPPQNNEFuCQi2Rerxno/QtLyP6nednNFNzUepAI6Fh7SfWRj3fIXNWifx3bot5zJNDAiCkk/6WQv64UU0xCFEgWcAE1f/jWNIGx+wN9AKfA4mPdp5uZHbsXr8ehLCcAZD2l/MaM5+i7qK7YScXdnAzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131459; c=relaxed/simple;
	bh=c96ZWM2YbGkHRur6wRdiO/jYHW4Vd3JzeA7uCSEtT40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b7skFKt9P1D1KmRsLIJ6Dp/TUZb+WQQmOpkcFoqua/ljjYqLLBd8TaFTXIxn2gVv0czmOb6Vqf6hSu2tBrg3zUvFwxz4FJOKt6RTxE5pD/IuHjkS8FtFK8LZmHPBhwW9sZ7BawVbFypndPwSxXT/B0qimxKtI+DbL4FQvZqfoh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dezX248K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P9Hpfd019199
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SE0gyMoB8H1CugyDSf0yuuJz5+xdbT3mnKETqrVtLJE=; b=dezX248KTCA8HBnZ
	k+1XoucYM9nNMkL0mTZDlkj234rYZWJdiHbQvaqqzxtKLhfyUWPpLm/0VKeEiNCl
	0bZf7vNVCMKE/obYAHL6JWAfg171ON2tJlFYPSIKIktLE15qGlSxulVUxFf+c7MA
	TiJhppipFBflXehXYu2B1ghesa1F5H3cWNpLP6AFoZE+9FNoPOXk7tI2SsUh3rcQ
	8dSnhQQom2xsSod+1p1n44+hxPXnD/vOtJq0HWHxz9vXMp1voV1Q9SncY+1c2P8C
	V8fhEEvaCnVhSxiPFhGLpI8lynUJcmZW25yeZOealxDGJsSKmA+RIia73j99Qen6
	y7h/7A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5uc57f9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:17:35 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76e2eb787f2so4613317b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756131454; x=1756736254;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SE0gyMoB8H1CugyDSf0yuuJz5+xdbT3mnKETqrVtLJE=;
        b=Thttify83ZBToWW5cqQ5wqmGCDxItNO6i+SB68dR98QXyQdEwqUhSmTZEqI1Kkqs32
         wvXNlxF98Pa6O4f5jmSRtYNmcZWPeCzs+jNkeozRPtgIpHSfPYJwJtR91Kxfgn1lojde
         B8a//Dx6G7hx6tp48A/NxZbdAl4TYBSA4hvwMjrTiYqOX1gUywut1NfOvrOyJFHOK8Oy
         zWIanoXpzjRiKcRDf7Q3shkTvnmmvHqC6/BAykfLTMykDyODd596sKRcbe3jP3EJFbug
         rbBD0R9AZn1KQl2aHg/oZV+Zda6lhG+5nSlyuA0Nx0G0fD/tGD1ShTDroMwdH7Pv54u1
         l4Fw==
X-Forwarded-Encrypted: i=1; AJvYcCULXjiNeW/oQkf+P9NqxqIKBsYC9sey5WN0FwzVmSceoiXI1RTiuG6JQ7Wb2DpkTZl8oSgURKXV4bkqzuU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3G7VKdUJa7SnSWJfcSYFLsGl4JvRJFGRBar/RL4YZD7PjPDGh
	bDLig/utBcbi0cH9w00J7o8m5xjb9JuUSawLJaioqVBZ2NC4UznCOtAk7aWDTqG5bRj9id6XTac
	V8kuwxp/6izwFlKeANizqJqDZQeumEl2cEBSizeLzTqab/a8QNZ6sHxTpBIYZwABQpow=
X-Gm-Gg: ASbGnctv36jEjC1shUsdpnqXqbXnIb+b9XZN91yQDsOG5bQR1QHMffjUG8OH55nQdHj
	PznfWYZDKAG9sfdpRTzzOZDiorGN0ZXY/xbUmt6Lu4E/DdCpx01KUdL/YGSCKiw+ujN8sW1Sjii
	KOMaiBp1eL6PRCRovr05K3f0Sk0zMUVEV2y6V5thQGhj5Rns793nffeS24LHioaclbDwg6pYdru
	XgUkWzLImVxqXw5xL9TpzpxZOZUllbDe0X4kkbHVUO5KB/e7iuQX2aRER7ZV+WqslJRBcDPaYvA
	ckwlUwh7+ozlUpZJtG6WdBbNnzceJreA7fsZ4qGD/dDk57JPXJoW4qQ4zOJMKivC0MnJAHE=
X-Received: by 2002:a05:6a00:1148:b0:770:343b:5457 with SMTP id d2e1a72fcca58-770343b5776mr12538548b3a.16.1756131453923;
        Mon, 25 Aug 2025 07:17:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMy2R23VqH7KKGD0dAfeWxD+PQOsTGsim/ksuVooGj2cwAdBV6kfz9RNS/shNC+Cw70XbkDw==
X-Received: by 2002:a05:6a00:1148:b0:770:343b:5457 with SMTP id d2e1a72fcca58-770343b5776mr12538514b3a.16.1756131453406;
        Mon, 25 Aug 2025 07:17:33 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401eb20dsm7672339b3a.79.2025.08.25.07.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:17:33 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 22:15:52 +0800
Subject: [PATCH v3 06/38] drm/msm/dp: extract MISC1_MISC0 configuration
 into a separate function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-msm-dp-mst-v3-6-01faacfcdedd@oss.qualcomm.com>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
In-Reply-To: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756131419; l=2040;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=c96ZWM2YbGkHRur6wRdiO/jYHW4Vd3JzeA7uCSEtT40=;
 b=7A1066X0KZACbntHPM+Jt/eD3ZsGYrvKe6zzDb5Z8KcJMssPlZjEANxf0jIuv1DUHGdJUBX6L
 K70v2S0HEELDa+s60FWY1wBPrH07gJDdKqrPryvvoisMjvel6HNe6/z
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMiBTYWx0ZWRfXyNhUE0MzCY8p
 Ea3tnsnA5LfWhFXY9yE7IwYsEekuY+hKHFPwWnZAbSAQ3BH3CJg8IVANK9QTGQOiqx4iMwiYr1S
 KtTaNukS99JTx9TG+xZLVjw6DTMeoMA41oWdyyp4kiBmSfWXndWB1g2V4ZkApSzsBzoQyNGVOqY
 z5o7+TJnVoaxemQoK50yBFQT9+NeZ6foa09FoJfnMALb2WbF6WG6rocm2MqrBaNWWwnJ4SqZSle
 Lfp2LFPZ42Cr3uOhRusLRrNVHIIf2HbpjRiOW2yPqcJu7DE82JbUv7I9oaGjgalbPGFuhE3Bxh8
 +mgiPyRrYQyz5/7q/5mmNruM5XCH7p+HAEC6Lp+PakwYbhKJwbGK6ObxtwX9tFCI+4ePol/vzWu
 CSTVnnvj
X-Proofpoint-ORIG-GUID: 9RvRUbOppxlxD6qfzeleVht-mce4VfCQ
X-Authority-Analysis: v=2.4 cv=I85lRMgg c=1 sm=1 tr=0 ts=68ac707f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=aoENilsEcffTQy9B1RkA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: 9RvRUbOppxlxD6qfzeleVht-mce4VfCQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230032

The MISC1_MISC0 register contains stream-specific configuration bits.
To improve code clarity and modularity, this patch refactors the related
code into a new helper function: msm_dp_ctrl_config_misc1_misc0().

This separation also prepares the codebase for future MST stream
programming support.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 45d6c9a7f7ddaa049443253cbf4c6fc5feda3177..6bfb639c1ebd33f1103c5b68dfb40701738fa267 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -447,13 +447,13 @@ static void msm_dp_ctrl_lane_mapping(struct msm_dp_ctrl_private *ctrl)
 			ln_mapping);
 }
 
-static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl)
+static void msm_dp_ctrl_config_misc1_misc0(struct msm_dp_ctrl_private *ctrl,
+					   struct msm_dp_panel *msm_dp_panel)
 {
 	u32 colorimetry_cfg, test_bits_depth, misc_val;
 
-	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
-
-	test_bits_depth = msm_dp_link_get_test_bits_depth(ctrl->link, ctrl->panel->msm_dp_mode.bpp);
+	test_bits_depth = msm_dp_link_get_test_bits_depth(ctrl->link,
+		msm_dp_panel->msm_dp_mode.bpp);
 	colorimetry_cfg = msm_dp_link_get_colorimetry_config(ctrl->link);
 
 	misc_val = msm_dp_read_link(ctrl, REG_DP_MISC1_MISC0);
@@ -467,6 +467,13 @@ static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl
 
 	drm_dbg_dp(ctrl->drm_dev, "misc settings = 0x%x\n", misc_val);
 	msm_dp_write_link(ctrl, REG_DP_MISC1_MISC0, misc_val);
+}
+
+static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl)
+{
+	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
+
+	msm_dp_ctrl_config_misc1_misc0(ctrl, ctrl->panel);
 
 	msm_dp_panel_timing_cfg(ctrl->panel, ctrl->msm_dp_ctrl.wide_bus_en);
 }

-- 
2.34.1



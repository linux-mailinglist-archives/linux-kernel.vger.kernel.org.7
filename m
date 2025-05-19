Return-Path: <linux-kernel+bounces-654094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E792ABC3E0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 18:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8577D1B651E8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 16:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2452287511;
	Mon, 19 May 2025 16:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PlDhKBzp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0959228750E
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 16:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747670698; cv=none; b=eobQ6hgOH9gojCJ4iaIlzlGQBoCwMxfTrdKq0zpxb737C4G1pVtxP4repLOfURjrSPLZCryJbLqGNESTChKS2XfMm1qCWJMxjuzUD7TJHWC+hjIKMyTL7bkfgC23kNYKiqJzd9yHSU+EM/Wnq2j7WuA5nUJCmmP9FGd+2ZyPlB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747670698; c=relaxed/simple;
	bh=5zJLok5PavBLhhgmYhocIuKYS1AkKRUjh4oU1Lh6QX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X5AsD2VdlXIoS9tfMlgIl71v/CmaWuYoUBNEzAXxoOpNq+Nv59UicLUG514NUUNgCo/axKiqJAjenzmFzD1qeAqVlGSdS8fExNur7nDwQCRwdGxoghnqdHPHJPHv5TX+cjIS/0HK3fpxsw4APo3Ok5D03G8MvjTntk273rXPrnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PlDhKBzp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J8dWk8002784
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 16:04:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fAN+CXJaj4W+6XYD3RlPlea/F3+2Xol5/tTlLQCHlCg=; b=PlDhKBzpDFFCnj9W
	bpiId68bOz3bDLsIBKe0A1nruFnyN90VPRc386BBDTBw4cXplYKYelYA3UXRz2Km
	l3rr59exy29AoDmnPZ8COsYXDMkFeMjtOI3OwaQd4fYXqncETNqfWKrTtLh2Lv4h
	BprCiKsmniJniiKgO2tyG5eDGi0kOHltatJ5frhnF8QD+F1Qn4CqegpbsK2z4k3I
	ilg/WFQMUrsWpymMJcQ9ZB74ItiJzubzBRw+DdWn1BhJDvkaW0qnBjSLcN7CYlJe
	NBOVJH3L1dVfEzCHFput0PG+Pesr0knPkmv+r6c3rm8TSfrlUH3x7YIFY+KUn8uC
	i04G7g==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46r1ath86u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 16:04:55 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-401c6c3a679so4156031b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 09:04:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747670695; x=1748275495;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fAN+CXJaj4W+6XYD3RlPlea/F3+2Xol5/tTlLQCHlCg=;
        b=mwo0BcSaCr+uXVafXo5aCIu8TbgnZyVQfyFlqCvyGyimAP5QwIKusYNvT9a1Ekb/GZ
         XgF+OtS07GSnAoJW5Y2ZeM5UWQ7pAg4Kw2Zhqal+dwjluKo5be7siNI/CLhqAsCsieAw
         ZqylcGwdoi2xqP382t1r7WrdQvQqmsa32Svxa8l69LprimKy6ApeeoGZ1+CufxnIII8J
         Fhq8HOThMVoGQf4sBvfjUFoVMpM1W6HZS/m0CBzYfHi0ZEWnUFsW/Lemji8NJZ2HPBAw
         /m0GvVxTaIQdPSBOGLsmkY/2sYcVpYgqOItyjtfs6uRhSiUnsfb+cHJpCrmhe+e5yFwl
         8URg==
X-Forwarded-Encrypted: i=1; AJvYcCW69tQXfAItxJJZOHHlkUT5S3JwgTj6SMBvTVmwtqliP9YgPy+DOzImwt8fiBNsIEbqkPYpC7kKnD1uN5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YypQjsnjaC7aMWle3lQt3dbS9QM+5MSZdSbswkdZQCgYpnhSxbl
	9tJUzJRJ+PxRZq9IZ980eIEb7OTPN8k3DQtr796wrPPzIGrwSoPhQxbEYaH0V1VOUGfWCkm3dIg
	VGL69rbUW7kc+MG8TarAf/aBWO2bAZKb2fM0KyZ2QiInfmWEvAff1Q4etV4tisPIMeY3aKZaqE8
	w=
X-Gm-Gg: ASbGnctKuMJ5oBTZ/ZH6+ULKTS9EIiPx0zdVrUis+9ADBqw+JPzPtcBoKrL3lXdFiVV
	RQy0+K93uTre4zXfmBoz8oQgZxB28wI0f6N20Nd3sPCJb0qIg8W4yJkr8WyZ0hlRQhj+l1DbvGo
	eR4tXrLf4GzWNCYe2/kkQbVNLrw8lM8si/n2ihI0nH1xfGLstKulVc5EkIVgbuAlwgnPHdQJHZf
	exSQvrbU04AzLY8KFVlNVshIaLfI5nwUn2FW1fFXx8NtPTS14jQNOVXkeJMSt6iShOy6GD8HQ8g
	uEUgKEEmRrnyEJkGpie/6YAvOMUVY0cDlGaXeX8RsfLW285acNjkDYzdOD+b0zCx+tTujTBZx28
	h0fE/ScFjv8JrhbbxF7QOuqbC
X-Received: by 2002:a05:6808:4448:b0:402:292:44a6 with SMTP id 5614622812f47-404d863c91dmr8270702b6e.3.1747670694614;
        Mon, 19 May 2025 09:04:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkgtsBBcTR8xj6OAM2Th4T05Oo2dctpJbP/XhdL8GFbV2K/n1LRBDpQxZywqfLvBxFQAYgJw==
X-Received: by 2002:a05:6808:4448:b0:402:292:44a6 with SMTP id 5614622812f47-404d863c91dmr8270652b6e.3.1747670694170;
        Mon, 19 May 2025 09:04:54 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e703f6f1sm1919378e87.248.2025.05.19.09.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 09:04:53 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 May 2025 19:04:20 +0300
Subject: [PATCH v4 18/30] drm/msm/dpu: get rid of DPU_MDP_VSYNC_SEL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250519-dpu-drop-features-v4-18-6c5e88e31383@oss.qualcomm.com>
References: <20250519-dpu-drop-features-v4-0-6c5e88e31383@oss.qualcomm.com>
In-Reply-To: <20250519-dpu-drop-features-v4-0-6c5e88e31383@oss.qualcomm.com>
To: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Vinod Koul <vkoul@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8101;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=+WjsCRpQ3QCe/Ce1kvO60/iVL+5JGid0k0Ksq+2ENGA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoK1Z86fQc+v66Hc/YT5TqWGoVK9TyJUgTPpwCv
 yADGvfHtIKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaCtWfAAKCRCLPIo+Aiko
 1frqB/0cG/LOLfA4Xr9FXr9voaSVWYeW+1tO8GXemyDW+OazjU8gXUNm05zOcuDkB6zMQc9hYEh
 6UlGICDt7DK2PuuXP13PuNjm9gFmbmHNzo8cGCDh9NBhUG/L5dZSVssUibdsFKuPXAHXfKDlVJ/
 //m8QaI08aDXTsxc5CQHeG2Bv/88YbhdE24hWxwXqhtDGc9ykypaDVHm6NOkI61pg769InULWXC
 t0QwpCT0pVmZEEqTOOOP8Rsv9YQSn4owRMTqkzydzkGiXhlnm0nH8zn1mp1CHsb4CxXtir4+aB0
 PodRwSJ/kgJMZiSmojj9Q8hIWhbW1rjQWO71p8CzZDpOAXVl
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=OfqYDgTY c=1 sm=1 tr=0 ts=682b56a7 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=MP74wIc9YfZe_pNrw8AA:9
 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 6t27wsgvdXs1XhunzR-IkgUaPtfLmUVN
X-Proofpoint-GUID: 6t27wsgvdXs1XhunzR-IkgUaPtfLmUVN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE1MCBTYWx0ZWRfX1wG036kyzJGS
 U2WBaxD4Ub5IyZ0bNh3WLJifLhxcjJJCbJUbNdxNRql0ACWlh9qTwGFhs6hOKNKzkCQRdJISwus
 OAaxem/UU3ij7H/qOM62sWSo2YBT41ib22ZuXBkQn2LhZXBCcIEALOmo2UJykVWte4CoGog6SAl
 jKh+Y1QD4xVJDZGtcNG+gXs7LUfpzaBIr6OsP6JG3q8Pt7yc2l19fq97Wb9ahIPFddmSEtbqqY5
 Qx1TqLxU8mloOck0q3yA6iH2HGepG8H1R2K000k2EvNkb54eXd1fvxoig7oMT5XXsmIP3wBjFN/
 PMgFiIesK0TsBemTNGL29LdmqPmgWyx67Beereh00sfLhJG8MLCGFQeq4bYlCjtmU/xBkVzdpQX
 mbx9qdUUSJknxmGBIRxOFSetrApeiYtQHq6DTkwnSumByznrbBFp3uTpKYMiN4rXLENAylE6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 spamscore=0 mlxlogscore=808
 clxscore=1015 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505190150

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Continue migration to the MDSS-revision based checks and replace
DPU_MDP_VSYNC_SEL feature bit with the core_major_ver < 5 check.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_14_msm8937.h | 1 -
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_15_msm8917.h | 1 -
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h | 1 -
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_7_msm8996.h  | 1 -
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h  | 1 -
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_2_sdm660.h   | 1 -
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h   | 1 -
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h   | 2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h           | 3 ---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c               | 2 +-
 10 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_14_msm8937.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_14_msm8937.h
index c0b4db94777c42efd941fdd52993b854ab54c694..29e0eba91930f96fb94c97c33b4490771c3a7c17 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_14_msm8937.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_14_msm8937.h
@@ -19,7 +19,6 @@ static const struct dpu_mdp_cfg msm8937_mdp[] = {
 	{
 		.name = "top_0",
 		.base = 0x0, .len = 0x454,
-		.features = BIT(DPU_MDP_VSYNC_SEL),
 		.clk_ctrls = {
 			[DPU_CLK_CTRL_VIG0] = { .reg_off = 0x2ac, .bit_off = 0 },
 			[DPU_CLK_CTRL_RGB0] = { .reg_off = 0x2ac, .bit_off = 4 },
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_15_msm8917.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_15_msm8917.h
index d3e4c48be306a04b457cc002910eb018a3f13154..cb1ee4b63f9fe8f0b069ad4a75b121d40e988d2b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_15_msm8917.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_15_msm8917.h
@@ -19,7 +19,6 @@ static const struct dpu_mdp_cfg msm8917_mdp[] = {
 	{
 		.name = "top_0",
 		.base = 0x0, .len = 0x454,
-		.features = BIT(DPU_MDP_VSYNC_SEL),
 		.clk_ctrls = {
 			[DPU_CLK_CTRL_VIG0] = { .reg_off = 0x2ac, .bit_off = 0 },
 			[DPU_CLK_CTRL_RGB0] = { .reg_off = 0x2ac, .bit_off = 4 },
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h
index c488b88332d0e69cfb23bcf4e41a2e4f4be6844d..b44d02b48418f7bca50b04119540122fb861b971 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h
@@ -19,7 +19,6 @@ static const struct dpu_mdp_cfg msm8953_mdp[] = {
 	{
 		.name = "top_0",
 		.base = 0x0, .len = 0x454,
-		.features = BIT(DPU_MDP_VSYNC_SEL),
 		.clk_ctrls = {
 			[DPU_CLK_CTRL_VIG0] = { .reg_off = 0x2ac, .bit_off = 0 },
 			[DPU_CLK_CTRL_RGB0] = { .reg_off = 0x2ac, .bit_off = 4 },
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_7_msm8996.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_7_msm8996.h
index 0e8e71775f2c1c38af018353c85ffeb6ccddb42f..8af63db315b45a5a44836303c8ce92eeccc5b1f8 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_7_msm8996.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_7_msm8996.h
@@ -22,7 +22,6 @@ static const struct dpu_mdp_cfg msm8996_mdp[] = {
 	{
 		.name = "top_0",
 		.base = 0x0, .len = 0x454,
-		.features = BIT(DPU_MDP_VSYNC_SEL),
 		.clk_ctrls = {
 			[DPU_CLK_CTRL_VIG0] = { .reg_off = 0x2ac, .bit_off = 0 },
 			[DPU_CLK_CTRL_VIG1] = { .reg_off = 0x2b4, .bit_off = 0 },
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
index f2ec30837f9ccbff1041f0465d0123382a00355a..f91220496082bd101099c1817c41699215980d53 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
@@ -23,7 +23,6 @@ static const struct dpu_caps msm8998_dpu_caps = {
 static const struct dpu_mdp_cfg msm8998_mdp = {
 	.name = "top_0",
 	.base = 0x0, .len = 0x458,
-	.features = BIT(DPU_MDP_VSYNC_SEL),
 	.clk_ctrls = {
 		[DPU_CLK_CTRL_VIG0] = { .reg_off = 0x2ac, .bit_off = 0 },
 		[DPU_CLK_CTRL_VIG1] = { .reg_off = 0x2b4, .bit_off = 0 },
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_2_sdm660.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_2_sdm660.h
index 26f39acd82e07c71cbeaaa72c14d9b7e14d2dcc3..8f9a097147c02b538e720dd52f77e705f7ff1ca2 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_2_sdm660.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_2_sdm660.h
@@ -22,7 +22,6 @@ static const struct dpu_caps sdm660_dpu_caps = {
 static const struct dpu_mdp_cfg sdm660_mdp = {
 	.name = "top_0",
 	.base = 0x0, .len = 0x458,
-	.features = BIT(DPU_MDP_VSYNC_SEL),
 	.clk_ctrls = {
 		[DPU_CLK_CTRL_VIG0] = { .reg_off = 0x2ac, .bit_off = 0 },
 		[DPU_CLK_CTRL_VIG1] = { .reg_off = 0x2b4, .bit_off = 0 },
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h
index 657f733c9ffff73f9eb5051ba55ed2e4e7bb496d..0ad18bd273ff8c080f001f0bee654393cf0c24cd 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h
@@ -22,7 +22,6 @@ static const struct dpu_caps sdm630_dpu_caps = {
 static const struct dpu_mdp_cfg sdm630_mdp = {
 	.name = "top_0",
 	.base = 0x0, .len = 0x458,
-	.features = BIT(DPU_MDP_VSYNC_SEL),
 	.clk_ctrls = {
 		[DPU_CLK_CTRL_VIG0] = { .reg_off = 0x2ac, .bit_off = 0 },
 		[DPU_CLK_CTRL_DMA0] = { .reg_off = 0x2ac, .bit_off = 8 },
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h
index 15da5ded19267711e6df8605d576539475fe634c..3e66feb3e18dcc1d9ed5403a42989d97f84a8edc 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h
@@ -23,7 +23,7 @@ static const struct dpu_caps sdm845_dpu_caps = {
 static const struct dpu_mdp_cfg sdm845_mdp = {
 	.name = "top_0",
 	.base = 0x0, .len = 0x45c,
-	.features = BIT(DPU_MDP_AUDIO_SELECT) | BIT(DPU_MDP_VSYNC_SEL),
+	.features = BIT(DPU_MDP_AUDIO_SELECT),
 	.clk_ctrls = {
 		[DPU_CLK_CTRL_VIG0] = { .reg_off = 0x2ac, .bit_off = 0 },
 		[DPU_CLK_CTRL_VIG1] = { .reg_off = 0x2b4, .bit_off = 0 },
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index d48c26a7cb6b69961cebc19576e3f7fc3b8dd2c5..92dfbb5e7f916bf32afeffdb6b843f1da3f3fd44 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -34,8 +34,6 @@
  * @DPU_MDP_10BIT_SUPPORT, Chipset supports 10 bit pixel formats
  * @DPU_MDP_PERIPH_0_REMOVED Indicates that access to periph top0 block results
  *			   in a failure
- * @DPU_MDP_VSYNC_SEL      Enables vsync source selection via MDP_VSYNC_SEL register
- *                         (moved into INTF block since DPU 5.0.0)
  * @DPU_MDP_MAX            Maximum value
 
  */
@@ -44,7 +42,6 @@ enum {
 	DPU_MDP_10BIT_SUPPORT,
 	DPU_MDP_AUDIO_SELECT,
 	DPU_MDP_PERIPH_0_REMOVED,
-	DPU_MDP_VSYNC_SEL,
 	DPU_MDP_MAX
 };
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c
index 562a3f4c5238a3ad6c8c1fa4d285b9165ada3cfd..cebe7ce7b258fc178a687770906f7c4c20aa0d4c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c
@@ -270,7 +270,7 @@ static void _setup_mdp_ops(struct dpu_hw_mdp_ops *ops,
 	ops->setup_clk_force_ctrl = dpu_hw_setup_clk_force_ctrl;
 	ops->get_danger_status = dpu_hw_get_danger_status;
 
-	if (cap & BIT(DPU_MDP_VSYNC_SEL))
+	if (mdss_rev->core_major_ver < 5)
 		ops->setup_vsync_source = dpu_hw_setup_vsync_sel;
 	else if (!(cap & BIT(DPU_MDP_PERIPH_0_REMOVED)))
 		ops->setup_vsync_source = dpu_hw_setup_wd_timer;

-- 
2.39.5



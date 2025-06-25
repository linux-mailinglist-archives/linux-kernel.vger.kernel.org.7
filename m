Return-Path: <linux-kernel+bounces-702560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2B5AE8407
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 15:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80D3F4A6F53
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 13:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1A92676C9;
	Wed, 25 Jun 2025 13:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUxLEnFx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFC0264623;
	Wed, 25 Jun 2025 13:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750857046; cv=none; b=Ozo2FgHMQiW5uXYLClwLh+YebnMaB4P6rJEUkrL4mPMwicJcMESm/p0TX+9/QT6rDIAHYukAWv/gtgMSkTx0Eb+XeNRT1KOWYK6RnPYnY3qQbGycJlk/rZGmnSXEUuBtDuvP9Zr1ekIHUS3+pq7P3el3exi7cJgcom6aIX/Ppp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750857046; c=relaxed/simple;
	bh=3LEQ356tMFYHOFgS0SBmeaGH7W54eTYJS2pkOp0ZCzA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TEFdAGDc+2XT1stmnCHgbMDgW/7f2wcNppIJf2XWZ9IwI0n9OGQjjRg+qQrovI8itcceS7SzFhYC31AxtFMybzLLgboKDHOBCqaR2tInN78x/tLNSrYrPVrjW32reNStvRVTegaUQ+HjhpMP9Mc3cgq+H6gwcif25EVbMHgMDxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUxLEnFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C12C4CEF0;
	Wed, 25 Jun 2025 13:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750857046;
	bh=3LEQ356tMFYHOFgS0SBmeaGH7W54eTYJS2pkOp0ZCzA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hUxLEnFxQaU/cteErfO/TANwBKUAlnx7jjtxQBpZ6EOwJQZeqbp48DJtwpPoWjA1R
	 6xyVTU0ihxJpGFEuM/p15xewuhDnAmoPyjB1QS6HnPJrg5qZ6rNsic01j88VBUOvrN
	 KW6itl6LHg3Q6erXpdl6XbAw6DNt7ucEioJaaXW+wN8nhtn8qtWEWj27nS7LXPNBL/
	 zMkhPZWJoCDOIJyJEMQtNb1M0bnQp0+wVARKW01JFI3+tsL+9VE16UdXy8ZvlGlr5G
	 Sbe4+Gi4Ei3RWLLPC3sVBc45HPI1z6x+s+CFY9Up7qv+6fJ+HgjLWjegIO54M7hcrm
	 aQ28ZhCVu2Mlg==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 25 Jun 2025 15:10:14 +0200
Subject: [PATCH v5 06/14] drm/msm/a6xx: Simplify uavflagprd_inv detection
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-topic-ubwc_central-v5-6-e256d18219e2@oss.qualcomm.com>
References: <20250625-topic-ubwc_central-v5-0-e256d18219e2@oss.qualcomm.com>
In-Reply-To: <20250625-topic-ubwc_central-v5-0-e256d18219e2@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750857014; l=3256;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=OhUr7NYHE/PzMXX00APT+Awea/mVV15VY28VSm+g4dg=;
 b=JHmLlXPAkwtTskzs50EvKMBfRLuOzJ9aBwgaaiWMHEw8+nyINVLe39mizOQISvB0xFRh0g1+a
 BU9T4Y5oisNB2OkKqAc/3zE+DzM7R+1ll/uyU74aiLSq80dpkYvcOSW
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Instead of setting it on a gpu-per-gpu basis, converge it to the
intended "is A650 family or A7xx".

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index d14c84a0a4b14bf7f77375e619ac6892374bb3c1..3d9c98e56d92ed43cf6e702fbd2b5cbd3293ac5a 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -611,7 +611,6 @@ static int a6xx_calc_ubwc_config(struct adreno_gpu *gpu)
 		return PTR_ERR(gpu->common_ubwc_cfg);
 
 	gpu->ubwc_config.rgb565_predicator = 0;
-	gpu->ubwc_config.uavflagprd_inv = 0;
 	gpu->ubwc_config.min_acc_len = 0;
 	gpu->ubwc_config.ubwc_swizzle = 0x6;
 	gpu->ubwc_config.macrotile_mode = 0;
@@ -633,15 +632,12 @@ static int a6xx_calc_ubwc_config(struct adreno_gpu *gpu)
 	if (adreno_is_a619_holi(gpu))
 		gpu->ubwc_config.highest_bank_bit = 13;
 
-	if (adreno_is_a621(gpu)) {
+	if (adreno_is_a621(gpu))
 		gpu->ubwc_config.highest_bank_bit = 13;
-		gpu->ubwc_config.uavflagprd_inv = 2;
-	}
 
 	if (adreno_is_a623(gpu)) {
 		gpu->ubwc_config.highest_bank_bit = 16;
 		gpu->ubwc_config.rgb565_predicator = 1;
-		gpu->ubwc_config.uavflagprd_inv = 2;
 		gpu->ubwc_config.macrotile_mode = 1;
 	}
 
@@ -656,21 +652,18 @@ static int a6xx_calc_ubwc_config(struct adreno_gpu *gpu)
 		/* TODO: get ddr type from bootloader and use 2 for LPDDR4 */
 		gpu->ubwc_config.highest_bank_bit = 16;
 		gpu->ubwc_config.rgb565_predicator = 1;
-		gpu->ubwc_config.uavflagprd_inv = 2;
 		gpu->ubwc_config.macrotile_mode = 1;
 	}
 
 	if (adreno_is_a663(gpu)) {
 		gpu->ubwc_config.highest_bank_bit = 13;
 		gpu->ubwc_config.rgb565_predicator = 1;
-		gpu->ubwc_config.uavflagprd_inv = 2;
 		gpu->ubwc_config.macrotile_mode = 1;
 		gpu->ubwc_config.ubwc_swizzle = 0x4;
 	}
 
 	if (adreno_is_7c3(gpu)) {
 		gpu->ubwc_config.highest_bank_bit = 14;
-		gpu->ubwc_config.uavflagprd_inv = 2;
 		gpu->ubwc_config.macrotile_mode = 1;
 	}
 
@@ -694,11 +687,15 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
 	BUG_ON(adreno_gpu->ubwc_config.highest_bank_bit < 13);
 	u32 hbb = adreno_gpu->ubwc_config.highest_bank_bit - 13;
 	bool amsbc = cfg->ubwc_enc_version >= UBWC_3_0;
+	u8 uavflagprd_inv = 0;
 	u32 hbb_hi = hbb >> 2;
 	u32 hbb_lo = hbb & 3;
 	u32 ubwc_mode = adreno_gpu->ubwc_config.ubwc_swizzle & 1;
 	u32 level2_swizzling_dis = !(adreno_gpu->ubwc_config.ubwc_swizzle & 2);
 
+	if (adreno_is_a650_family(adreno_gpu) || adreno_is_a7xx(adreno_gpu))
+		uavflagprd_inv = 2;
+
 	gpu_write(gpu, REG_A6XX_RB_NC_MODE_CNTL,
 		  level2_swizzling_dis << 12 |
 		  adreno_gpu->ubwc_config.rgb565_predicator << 11 |
@@ -713,7 +710,7 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
 
 	gpu_write(gpu, REG_A6XX_SP_NC_MODE_CNTL,
 		  level2_swizzling_dis << 12 | hbb_hi << 10 |
-		  adreno_gpu->ubwc_config.uavflagprd_inv << 4 |
+		  uavflagprd_inv << 4 |
 		  adreno_gpu->ubwc_config.min_acc_len << 3 |
 		  hbb_lo << 1 | ubwc_mode);
 

-- 
2.50.0



Return-Path: <linux-kernel+bounces-702563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 879FDAE8411
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 15:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7A818920D3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 13:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319F12627FC;
	Wed, 25 Jun 2025 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTiWWK6y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B98A2609F7;
	Wed, 25 Jun 2025 13:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750857061; cv=none; b=fCUs1Ild2inzHKbM+qVdLnhhABZ2h8M0Q0SfC+0ItILt9MrvbP0oocXcEK0wPHzisiUEIyNMmrpxJCcfZnNg9zNyhzEVrFdox67+eO/UKGYeu7JUl4g88Zt0FTNibV0UgB/JudSFPfUPN1ddBCg0p1xQdIYwFFaqZAxGy1gGHzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750857061; c=relaxed/simple;
	bh=Jzp4H5XI2mNdXY7mf+xttkOOu68Xs66xVgu2w4KaY6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dWKh2lExq4hiFwCBIaL8UKvUcLC1H8TRiKiA+eXKktNIsp0VliLwExzbQYVhdHHYyd7KKYx3bHLzHglbLqm7qGhyDmCapWMeh8zWwbmx780pMwFhezq/ljY6XbpHRI8nleKiwoipURSzfYWBgbrx/ylnM5frF+YNAb3os1Wmg94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTiWWK6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EBEC4CEEA;
	Wed, 25 Jun 2025 13:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750857061;
	bh=Jzp4H5XI2mNdXY7mf+xttkOOu68Xs66xVgu2w4KaY6c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LTiWWK6y8gbaXagk6u8Unpy/hH9iI8XRKZBMJKcMBcp2IBPYvJxudKZFbF2JxTouL
	 P9m7T7A06zBbot5VGNWVyl1wl/rax21phiWt0/T8V5O46wnDrkb41TbRLLjPx5Gteo
	 Gubl6mBwBeey3B4n/oyuNDXX7Dzq3XHapCmsJWtI9wDhs4aVUHqG/O0wzxDqYi7PmT
	 qJYGtxBUMVM6snRY5EVIZT/hREcuQxZHZZjj9l+Lh0jiZguJ/awofBB6URn3eBSKzk
	 eW8V16MTfKMyAa1e5eSonuqNHT+UhUDsxtAaKuO6JcPJHN1Klm9HWEGWAVsJHfomSC
	 v/7id41v4sB1w==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 25 Jun 2025 15:10:17 +0200
Subject: [PATCH v5 09/14] drm/msm/a6xx: Resolve the meaning of
 rgb565_predicator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-topic-ubwc_central-v5-9-e256d18219e2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750857014; l=2509;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=XfAVKpXihNq5QYjqmv6bbx9jLqRnqYwolc2Cu9hDUvU=;
 b=cZf5zaKtql+E6lptsfMHrBRSoGTZvXv25nzP5qh+HyvX4tmWL1iBmkq6ZEHWeSYv7gMXEZ3Jz
 SYWgEeFqZtwAoZwr5rni4HVrmObHx3LoZPUhL3/Wr1aktafVXjqyDtu
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

It's supposed to be on when the UBWC encoder version is >= 4.0.
Drop the per-GPU assignments.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 78782f94ee678e13baa6eb1a009a412e13557d59..53493f68ead2113143dab594bfedf492014d5aaa 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -610,7 +610,6 @@ static int a6xx_calc_ubwc_config(struct adreno_gpu *gpu)
 	if (IS_ERR(gpu->common_ubwc_cfg))
 		return PTR_ERR(gpu->common_ubwc_cfg);
 
-	gpu->ubwc_config.rgb565_predicator = 0;
 	gpu->ubwc_config.min_acc_len = 0;
 	gpu->ubwc_config.ubwc_swizzle = 0x6;
 	gpu->ubwc_config.macrotile_mode = 0;
@@ -637,7 +636,6 @@ static int a6xx_calc_ubwc_config(struct adreno_gpu *gpu)
 
 	if (adreno_is_a623(gpu)) {
 		gpu->ubwc_config.highest_bank_bit = 16;
-		gpu->ubwc_config.rgb565_predicator = 1;
 		gpu->ubwc_config.macrotile_mode = 1;
 	}
 
@@ -651,13 +649,11 @@ static int a6xx_calc_ubwc_config(struct adreno_gpu *gpu)
 	    adreno_is_a740_family(gpu)) {
 		/* TODO: get ddr type from bootloader and use 2 for LPDDR4 */
 		gpu->ubwc_config.highest_bank_bit = 16;
-		gpu->ubwc_config.rgb565_predicator = 1;
 		gpu->ubwc_config.macrotile_mode = 1;
 	}
 
 	if (adreno_is_a663(gpu)) {
 		gpu->ubwc_config.highest_bank_bit = 13;
-		gpu->ubwc_config.rgb565_predicator = 1;
 		gpu->ubwc_config.macrotile_mode = 1;
 		gpu->ubwc_config.ubwc_swizzle = 0x4;
 	}
@@ -686,6 +682,7 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
 	 */
 	BUG_ON(adreno_gpu->ubwc_config.highest_bank_bit < 13);
 	u32 hbb = adreno_gpu->ubwc_config.highest_bank_bit - 13;
+	bool rgb565_predicator = cfg->ubwc_enc_version >= UBWC_4_0;
 	u32 level2_swizzling_dis = !(cfg->ubwc_swizzle & BIT(1));
 	bool ubwc_mode = qcom_ubwc_get_ubwc_mode(cfg);
 	bool amsbc = cfg->ubwc_enc_version >= UBWC_3_0;
@@ -698,7 +695,7 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
 
 	gpu_write(gpu, REG_A6XX_RB_NC_MODE_CNTL,
 		  level2_swizzling_dis << 12 |
-		  adreno_gpu->ubwc_config.rgb565_predicator << 11 |
+		  rgb565_predicator << 11 |
 		  hbb_hi << 10 | amsbc << 4 |
 		  adreno_gpu->ubwc_config.min_acc_len << 3 |
 		  hbb_lo << 1 | ubwc_mode);

-- 
2.50.0



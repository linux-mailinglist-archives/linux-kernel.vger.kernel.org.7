Return-Path: <linux-kernel+bounces-702554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97551AE83F9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 15:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54AF06A49AA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 13:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A83F2620C9;
	Wed, 25 Jun 2025 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTYIzGpM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE73C2620CB;
	Wed, 25 Jun 2025 13:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750857021; cv=none; b=S2Ak27ppgRk1pq4H5bjHckC4wShRZxW6byAHiXjX3dubfCLmlI3+g0ZAY8jBzsuS0T3wUhr2Rn8BWrzoinFiJuWbqPjO9oq8Wc48Sefo4w0iGJUwAIVnzh3Ahcf/U1SgQGxgeaE8UKNBHNWYSzthVwm6QT5W8xhLZ30eZHG9I70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750857021; c=relaxed/simple;
	bh=B3Jr4MdA4tDfAIG3Jnrg1O1yont+DgK8qgQw4KUNncQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qevdqeNoM6iu4S23A2fqrCVF2jNDODTQjqthIF3mPkvEJUxAVgzY8MeOozTyFvkJInGrfFjw/qt9rSYecYzo8AjGN0IyCqY+qj5opXYxT8i/QV6ewvPEZxQLWMmlTP4FaRRuYbxuXhy4ITNXjld7bmA7gXCxfc3TQCkXOtQYGj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTYIzGpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2CDC4CEEA;
	Wed, 25 Jun 2025 13:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750857019;
	bh=B3Jr4MdA4tDfAIG3Jnrg1O1yont+DgK8qgQw4KUNncQ=;
	h=From:Subject:Date:To:Cc:From;
	b=uTYIzGpM8dxD81AJZtxOEhpN3awLLjwXUzBQjpZ/p0+1aD4D/6sqObYc+m6Z+Stzc
	 3AFPl/ivSLGULXVt2cTGul4XAmHIxQJ84sz5uqXqXBpGxh8UBrlARSgtb6XsjBNVcp
	 KWVIMXSadOsnCGXEIiOgJX3jqqQImbPcV80hITs6VfnBq71nH3N2bCVlH0p8DUPn3u
	 leJ/1CQwY+7l2bXRXDvq6oq4fn58oPjksDxhCm3tlxwseWZOZDogzdRSE86I8dGbQ5
	 VMDKG3OazKWgrbI13TbxlpMA1p4oCQQuR+/7yN0hdcmZSJ6IfnCAWWTlRm2gbeNKe9
	 iPnj9BUXcmjDg==
From: Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH v5 00/14] Add a single source of truth for UBWC
 configuration data
Date: Wed, 25 Jun 2025 15:10:08 +0200
Message-Id: <20250625-topic-ubwc_central-v5-0-e256d18219e2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADD1W2gC/3XQz2rDMAwG8FcpPs9F/qMs7WnvMcZwVGU1tHFrJ
 95GybvPaQ/Lwb0IPoF+H+gmEkfPSew3NxE5++TDUAK+bAQd3fDF0h9KFho0gjUgx3DxJKfumz6
 JhzG6k0RDaKEHtWMU5fASufc/d/T945EjX6dij//Lo09jiL/34qyW7aMDoa11ZCVBgkGyhNQxw
 ltIaXud3InC+bwtQyxq1itJ2aqkF2nH1BE4QOInkllLr1XJFMlQaxvEBvu2eSLZlaSrH8y2SNr
 ZRh2M1sa6ijTP8x+Q6eRorgEAAA==
X-Change-ID: 20250430-topic-ubwc_central-53c540f019e5
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750857014; l=4769;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=B3Jr4MdA4tDfAIG3Jnrg1O1yont+DgK8qgQw4KUNncQ=;
 b=SMXmVx2mN0GqCCPH4lAtanDdyaCXL7z8ZAmZY+URvEGO3maWYNpfA0KAdlv+3UkMcF89ryQCv
 wE+uX3Zw9kADM8w0QzuqwkBS1Svbb3Ns+yhvqI89U7DAc4mk0QQ6vcZ
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

As discussed a lot in the past, the UBWC config must be coherent across
a number of IP blocks (currently display and GPU, but it also may/will
concern camera/video as the drivers evolve).

So far, we've been trying to keep the values reasonable in each of the
two drivers separately, but it really make sense to do so, especially
given certain fields (see [1]) may need to be gathered dynamically.

This series introduces a Single Source of Truth (SSOT) database to be
consumed by multimedia drivers as needed.

[1] https://lore.kernel.org/linux-arm-msm/20250410-topic-smem_dramc-v2-0-dead15264714@oss.qualcomm.com/

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
Changes in v5:
- Drop 'RFT'
- Rebase on 8750 addition
- Pick up additional rb on patch 4
- Link to v4: https://lore.kernel.org/r/20250520-topic-ubwc_central-v4-0-2a461d32234a@oss.qualcomm.com

Changes in v4:
- Stub out qcom_ubwc_config_get_data()
- Move the select for QCOM_UBWC_CONFIG to DRM_MSM
- Use a define for UBWC_SWIZZLE_ENABLE_LVL2 in a6xx_gpu.c
- Pick up tags
- Link to v3: https://lore.kernel.org/r/20250517-topic-ubwc_central-v3-0-3c8465565f86@oss.qualcomm.com

Changes in v3:
- Rearrange some patches some more (Dmitry and I talked off-list,
  hopefully this version is reasonably sane)
- Throw the error returned by qcom_ubwc_config_get_data(), don't always
  assume it's -EINVAL (so that we can EPROBE_DEFER in the future if the
  SMEM driver that provides DDR info decides not to come up..)
- Scream if ubwc_swizzle doesn't match
- Drop dropping the ubwc_swizzle override (needs some testing in the wild)
- Move long statements out of declaration space
- explicitly define UBWC swizzling levels
- Fix the SAR2130P omission
- Pardon the funny ordering, but since it's intended to all go through
  drm, I attempted to strike a balance between clear, separate
  changes/fixes and logical succession
- Link to v2: https://lore.kernel.org/r/20250514-topic-ubwc_central-v2-0-09ecbc0a05ce@oss.qualcomm.com

Changes in v2:
- Rearrange some patches
- Don't zeroalloc a copy of ubwc_config, store a full struct inside
  adreno_gpu instead (temporary solution until we trust the central db
  on the HBB value)
- Improve some commit messages
- Fix up SM6125's config
- Don't break userspace abi (hbb value)
- Don't keep mdss_reg_bus_bw in ubwc_config
- Add the last patch warning if there are inconsistencies (I don't
  insist on it getting merged, but I think it's a good idea for the
  time being)
- Link to v1: https://lore.kernel.org/r/20250508-topic-ubwc_central-v1-0-035c4c5cbe50@oss.qualcomm.com

---
Konrad Dybcio (14):
      soc: qcom: Add UBWC config provider
      drm/msm: Offset MDSS HBB value by 13
      drm/msm: Use the central UBWC config database
      drm/msm/a6xx: Get a handle to the common UBWC config
      drm/msm/a6xx: Resolve the meaning of AMSBC
      drm/msm/a6xx: Simplify uavflagprd_inv detection
      drm/msm/a6xx: Resolve the meaning of UBWC_MODE
      drm/msm/a6xx: Replace '2' with BIT(1) in level2_swizzling_dis calc
      drm/msm/a6xx: Resolve the meaning of rgb565_predicator
      drm/msm/a6xx: Simplify min_acc_len calculation
      soc: qcom: ubwc: Fix SM6125's ubwc_swizzle value
      soc: qcom: ubwc: Add #defines for UBWC swizzle bits
      soc: qcom: ubwc: Fill in UBWC swizzle cfg for platforms that lack one
      drm/msm/adreno: Switch to the common UBWC config struct

 drivers/gpu/drm/msm/Kconfig                 |   1 +
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c       |  20 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c       | 138 +++++------
 drivers/gpu/drm/msm/adreno/adreno_gpu.c     |   6 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h     |  46 +---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c |   6 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h |   4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     |   7 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h     |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c   |   3 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c      |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h      |   2 +-
 drivers/gpu/drm/msm/msm_mdss.c              | 344 +++++-----------------------
 drivers/gpu/drm/msm/msm_mdss.h              |  29 ---
 drivers/soc/qcom/Kconfig                    |   8 +
 drivers/soc/qcom/Makefile                   |   1 +
 drivers/soc/qcom/ubwc_config.c              | 278 ++++++++++++++++++++++
 include/linux/soc/qcom/ubwc.h               |  75 ++++++
 18 files changed, 531 insertions(+), 441 deletions(-)
---
base-commit: 2ae2aaafb21454f4781c30734959cf223ab486ef
change-id: 20250430-topic-ubwc_central-53c540f019e5

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>


